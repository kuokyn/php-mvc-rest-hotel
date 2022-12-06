<?php

class Router {
    public function __construct() {
        $routesPath = ROOT . '/components/routes.php';
    }

    // метод будет принимать управление от фронтконтроллера
    public function run()
    {
        $uri = $this->getURI();
        $segments = explode('/', $uri);
        $entity = explode('&', array_shift($segments));
        $controller = null;
        switch ($entity[0]) {
            case 'bookings':
                include_once (ROOT . '/controller/BookingsController.php');
                $controller= new BookingsController();
                break;
            case 'book': // для пользователей
                include_once (ROOT . '/controller/BookController.php');
                $controller= new BookController();
            break;
            case 'rooms':
                include_once (ROOT . '/controller/RoomsController.php');
                $controller= new RoomsController();
                break;
            case 'users':
                include_once (ROOT . '/controller/UsersController.php');
                $controller= new UsersController();
                break;
            case 'services':
                include_once (ROOT . '/controller/ServiceController.php');
                $controller= new ServiceController();
                break;
            case 'payment':
                include_once (ROOT . '/controller/PaymentController.php');
                $controller= new PaymentController();
                break;
            default:
                break;
        }
        if ($controller) {
            $controller->processMethod();
        }
        else {
            http_response_code(404);
            echo json_encode([
                "message" => "404"
            ]);
        }
    }

    private function getURI()
    {
        if(!empty($_SERVER['REQUEST_URI']))
        {
            $uri = explode('=', $_SERVER['REQUEST_URI']);
            // trim - удаляет пробелы или другие символы из начала и конца строки
            return rtrim(trim($uri[1], '/'), '&');
        }
    }
}