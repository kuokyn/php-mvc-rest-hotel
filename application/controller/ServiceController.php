<?php

include_once(ROOT . '/model/Service.php');

class ServiceController
{

    public function processMethod()
    {
        switch ($_SERVER["REQUEST_METHOD"]) {
            case 'GET':
                if (!isset($_GET["title"])) {
                    $result = Service::getServiceList();
                }
                else {
                    $result = Service::getServiceById($_GET["title"]);
                }
                echo json_encode($result);
                break;

            case 'POST':
                $data = (array) json_decode(file_get_contents("php://input"), true);
                if (isset($data["title"]) && isset($data["price"]) && isset($data["description"])) {
                    $service = $this->createService($data);
                    if ($service) {
                        echo json_encode([
                            "message" => "Service ". $data['title'] . " was created",
                            "created" => $service
                        ]);
                        http_response_code(201);
                    }
                    else {
                        echo json_encode([
                            "message" => "Service ". $data['title'] . " was NOT created, database error"
                        ]);
                    }
                } else {
                    echo json_encode([
                        "message" => "Service ". $data['title'] . " was NOT created, not enough params"
                    ]);
                }
                break;

            case 'PUT':
                $data = (array)json_decode(file_get_contents("php://input"), true);
                if ($_GET["title"] == $data["title"] && isset($_GET["title"])) {
                    if (isset($data["description"]) && isset($data["price"])) {
                        $user = $this->updateService($data);
                        if ($user) {
                            echo json_encode([
                                "message" => "Service " . $_GET["title"] . " was updated",
                                "updated" => $user
                            ]);
                        } else {
                            echo json_encode([
                                "message" => "Service " . $_GET["title"] . " was NOT updated, database error",
                                "updated" => $user
                            ]);
                        }
                    } else {
                        echo json_encode([
                            "message" => "Service " . $_GET["title"] . " was NOT updated, not enough arguments"
                        ]);
                    }
                }
                else {
                    echo json_encode([
                        "message" => "Service " . $data['title'] . " was NOT updated, title in query and body does not match"
                    ]);
                }
                break;
            case 'DELETE':
                $title = $_GET["title"];
                $this->deleteService($title);
                break;
            default:
                http_response_code(405);
                header("Allow: GET, POST, PUT, DELETE");
                break;
        }
    }

    public function createService($data)
    {
        $title = $data["title"];
        $price = $data["price"];
        $description = $data["description"];
        return Service::createService($title, $price, $description);
    }

    public function updateService($data)
    {
        $title = $data["title"];
        $price = $data["price"];
        $description = $data["description"];
        return Service::updateService($title, $price, $description);
    }

    public function deleteService($title) {
        $deleted  = null;
        if ($title) {
            $deleted = Service::deleteService($title);
        } else {
            echo "error";
        }
        if ($deleted) {
            echo json_encode([
                "message" => "Service $title was NOT deleted",
                "deleted" => $deleted
            ]);
        } else {
            echo json_encode([
                "message" => "Service $title was deleted",
                "deleted" => $deleted
            ]);
        }
    }
}