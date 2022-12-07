<?php
session_start();
require('model/database.php');
require('components/Router.php');

header("Content-type: application/json; charset=UTF-8");
ini_set('display_errors', 1);
error_reporting(E_ALL);
define('ROOT', dirname(__FILE__));
$router = new Router();
$router->run();
/*
 * 1. Общие настройки (включение-выключение ошибок, установка констант и др.)
 * 2. Подключение файлов системы
 * 3. Установка соединения с базой данных
 * 4. Вызов Router
*/

