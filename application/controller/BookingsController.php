<?php

include_once(ROOT . '/model/Booking.php');
include_once(ROOT . '/model/User.php');

class BookingsController
{

    public function processMethod()
    {
        $data = (array) json_decode(file_get_contents("php://input"), true);
        $isSet = isset($data["people"]) && isset($data["check_in_date"]) && isset($data["check_out_date"]) && isset($data["user_id"]) && isset($data["room_id"]);
        switch ($_SERVER["REQUEST_METHOD"]) {
            case 'GET':
                if (!isset($_GET["id"]) && !isset($_SESSION["login"])) {
                    $result = Booking::getBookingList();
                }
                else if (isset($_SESSION["login"])) {
                    $result = $this->getMyBookings($_SESSION["login"]);
                }
                else {
                    $result = Booking::getBookingById($_GET["id"]);
                }
                echo json_encode($result);
                break;

            case 'POST':
                if ($isSet) {
                    $booking = $this->createBooking($data);
                    if ($booking) {
                        http_response_code(201);
                        echo json_encode([
                            "message" => "Booking ". $booking->{'id'}. " was created",
                            "created" => $booking
                        ]);
                    }
                    else {
                        echo json_encode([
                            "message" => "Booking was NOT created, database error"
                        ]);
                    }
                } else {
                    echo json_encode([
                        "message" => "Booking was NOT created, not enough params"
                    ]);
                }
                break;

            case 'PUT':
                if ($_GET["id"] == $data["id"] && isset($_GET["id"])) {
                    if ($isSet) {
                        $booking = $this->updateBooking($data);
                        if ($booking) {
                            http_response_code(201);
                            echo json_encode([
                                "message" => "Booking " . $data['id'] . " was updated",
                                "updated" => $booking
                            ]);
                        } else {
                            echo json_encode([
                                "message" => "Booking " . $data['id'] . " was NOT updated",
                                "updated" => $booking
                            ]);
                        }
                    } else {
                        echo json_encode([
                            "message" => "Booking " . $data['id'] . " was NOT updated, not enough params"
                        ]);
                    }
                }
                else {
                    echo json_encode([
                        "message" => "Booking " . $data['id'] . " was NOT updated, booking id does not match id in query"
                    ]);
                }
                break;
            case 'DELETE':
                $id = $_GET["id"];
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
                break;
            default:
                http_response_code(405);
                header("Allow: GET, POST, PUT, DELETE");
                break;
        }
    }

    public function createBooking($data)
    {
        $people = $data["people"];
        $time = strtotime($data["check_in_date"]);
        $newformat = date('Y-m-d h:i:s',$time);
        $check_in_date = $newformat;
        $time = strtotime($data["check_out_date"]);
        $newformat = date('Y-m-d h:i:s',$time);
        $check_out_date = $newformat;
        $room_id= $data["room_id"];
        $user_id = $data["user_id"];
        return Booking::createBooking($room_id, $user_id, $check_in_date, $check_out_date, $people);
    }

    public function updateBooking($data)
    {
        $id=$data["id"];
        $people =$data["people"];
        $time = strtotime($data["check_in_date"]);
        $newformat = date('Y-m-d h:i:s',$time);
        $check_in_date = $newformat;
        $time = strtotime($data["check_out_date"]);
        $newformat = date('Y-m-d h:i:s',$time);
        $check_out_date = $newformat;
        $room_id= $data["room_id"];
        $user_id = $data["user_id"];
        return Booking::updateBooking($id, $room_id, $user_id, $check_in_date, $check_out_date, $people);
    }

    public function getMyBookings($login) {
        $user = User::getUserByPhone($login);
        return Booking::getBookingsByUserId($user["id"]);
    }
}