<?php
/**
 * Typecho 2 Hexo
 *
 */

if (!defined("__TYPECHO_ROOT_DIR__") && !@include_once "../config.inc.php") {
    file_exists("../install.php") ? header("Location: install.php") : print("Missing Config File");
    exit;
}


define("TPL", "---
title: {{ title }}
date: {{ date }}
tags: {{ tags }}
categories: {{ categories }}
---

");

define("SOURCE_DIR", dirname(dirname(__FILE__)) . "/data/hexo/");
define("DRAFT_DIR", SOURCE_DIR . "_drafts/");
define("POST_DIR", SOURCE_DIR . "_posts/");

$all_post_sql = "SELECT a.cid, a.title, a.slug, a.text, a.created, a.status,
    CASE c.type
        WHEN 'tag' THEN group_concat(c.name)
    END tags,
    CASE c.type
        WHEN 'category' THEN group_concat(c.name)
    END categories
    FROM typecho_contents AS a
    LEFT JOIN typecho_relationships AS b ON b.cid=a.cid
    LEFT JOIN typecho_metas AS c ON c.mid=b.mid
    GROUP BY a.cid
    ORDER BY a.cid DESC";

create_folder(SOURCE_DIR);

create_folder(DRAFT_DIR);

create_folder(POST_DIR);

$db = Typecho_Db::get();

$query = $db->query($all_post_sql);

$rows = $db->fetchAll($query);

foreach($rows as $row){
    generate($row);
}

function create_folder($dir){
    if(! file_exists($dir)){
        mkdir($dir);
    }
}

function generate($data)
{
    $foler = DRAFT_DIR;

    $tpl = TPL;

    $filename = $data["slug"] . ".md";
    if ($data["status"] == "publish") {
        $foler = POST_DIR;
    }

    $tpl = str_replace("{{ title }}", $data["title"], $tpl);
    $tpl = str_replace("{{ date }}", date("Y-m-d H:i:s", $data["created"]), $tpl);
    $tpl = str_replace("{{ tags }}", $data["tags"] ? "[" . $data["tags"] . "]" : "", $tpl);
    $tpl = str_replace("{{ categories }}", $data["categories"] ? "[" . $data["categories"] . "]" : "", $tpl);

    $tpl .= $data["text"];
    $tpl = str_replace("<!--markdown-->", "", $tpl);
    file_put_contents($foler . $filename, $tpl);
    $data["filename"] = $filename;
    display_row($data);
}

function display_row($data){
    print($data["filename"] . " -> " . $data["title"]);
    print("<hr>");
}