<?php

include_once(ROOT . '/model/Room.php');

class RoomsController
{

    public function processMethod()
    {
        switch ($_SERVER["REQUEST_METHOD"]) {
            case 'GET':
                if (!isset($_GET["id"])) {
                    $result = Room::getRoomList();
                }
                else {
                    $result = Room::getRoomById($_GET["id"]);
                }
                echo json_encode($result);
                break;

            case 'POST':
                $data = (array) json_decode(file_get_contents("php://input"), true);
                if (isset($data["id"]) && isset($data["people"]) && isset($data["room_type_title"]) && isset($data["chambers"])) {
                    $room =  $this->createRoom($data);
                    if ($room) {
                        echo json_encode([
                            "message" => "Room ". $data['id'] . " was created",
                            "created" => $room
                        ]);
                        http_response_code(201);
                    }
                } else {
                    echo json_encode([
                        "message" => "Room ". $data['id'] . " was NOT created"
                    ]);
                }
                break;

            case 'PUT':
                $data = (array) json_decode(file_get_contents("php://input"), true);
                if (isset($data["id"]) && isset($data["people"]) && isset($data["room_type_title"]) && isset($data["chambers"])) {
                    $room = $this->updateRoom($data);
                    if ($room) {
                        echo json_encode([
                            "message" => "Room ". $data['id'] . " was updated",
                            "updated" => $room
                        ]);
                    }  else {
                        echo json_encode([
                            "message" => "Room ". $data['id'] . " was NOT updated because id is null",
                            "updated" => $room
                        ]);
                    }
                }  else {
                    echo json_encode([
                        "message" => "Room ". $data['id'] . " was NOT updated because not enough arguments"
                    ]);
                }
                break;
            case 'DELETE':
                $id = $_GET["id"];
                $this->deleteRoom($id);
                break;
            default:
                http_response_code(405);
                header("Allow: GET, POST, PUT, DELETE");
                break;
        }
    }

    public function createRoom($data)
    {
        $id = $data["id"];
        $people = $data["people"];
        $chambers= $data["chambers"];
        $room_type_title = $data["room_type_title"];
        return Room::createRoom($id, $chambers, $people, $room_type_title);
    }

    public function updateRoom($data)
    {
        $id = $data["id"];
        $people = $data["people"];
        $chambers= $data["chambers"];
        $room_type_title = $data["room_type_title"];
        return Room::updateRoom($id, $chambers, $people, $room_type_title);
    }

    public function deleteRoom($id) {
        $deleted = Room::deleteRoom($id);
        if ($deleted) {
            echo json_encode([
                "message" => "Room $id was NOT deleted",
                "deleted" => $deleted
            ]);
        } else {
            echo json_encode([
                "message" => "Room $id was deleted",
                "deleted" => $deleted
            ]);
        }
    }
}