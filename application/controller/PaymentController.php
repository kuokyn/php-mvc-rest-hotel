<?php

include_once(ROOT . '/model/Payment.php');

class PaymentController
{
    public function processMethod()
    {
        switch ($_SERVER["REQUEST_METHOD"]) {
            case 'GET':
                $result = Payment::getPaymentList();
                echo json_encode($result);
                break;
            case 'POST':
                $data = (array) json_decode(file_get_contents("php://input"), true);
                if (isset($data["people"]) && isset($data["check_in_date"]) && isset($data["check_out_date"]) && isset($data["user_id"]) && isset($data["room_id"])) {
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
                $data = (array) json_decode(file_get_contents("php://input"), true);
                if ($_GET["id"] == $data["id"] && isset($_GET["id"])) {
                    if (isset($data["people"]) && isset($data["check_in_date"]) && isset($data["check_out_date"]) && isset($data["user_id"]) && isset($data["room_id"])) {
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
                if ($id) {
                    $rows = Booking::deleteBooking($id);
                } else {
                    echo "error";
                }
                echo json_encode([
                    "message" => "Booking $id was deleted",

                ]);
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
}