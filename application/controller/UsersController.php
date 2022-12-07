<?php

include_once(ROOT . '/model/User.php');

class UsersController
{

    public function processMethod()
    {
        switch ($_SERVER["REQUEST_METHOD"]) {
            case 'GET':
                if (!isset($_GET["phone"])) {
                    $result = User::getUserList();
                } else {
                    $result = User::getUserByPhone($_GET["phone"]);
                }
                echo json_encode($result);
                break;

            case 'POST':
                $data = (array)json_decode(file_get_contents("php://input"), true);
                if ($data["action"] == "create" && isset($data["phone"]) && isset($data["name"]) && isset($data["surname"]) && isset($data["password"]) && isset($data["email"])) {
                    $user = $this->createUser($data);
                    if ($user) {
                        http_response_code(201);
                        echo json_encode([
                            "message" => "User with phone ". $data['phone'] . " was created",
                            "created" => $user
                        ]);

                    } else {
                        echo json_encode([
                            "message" => "User was NOT created because of database error"
                        ]);
                    }
                } else if ($data["action"] == "login" && isset($data["phone"]) && isset($data["password"])) {
                    $this->loginUser($data["phone"],$data["password"]);
                }
                else {
                    echo json_encode([
                        "message" => "User was NOT created because not enough parameters"
                    ]);
                }
                break;

            case 'PUT':
                $data = (array)json_decode(file_get_contents("php://input"), true);
                if ($_GET["phone"] == $data["phone"] && isset($_GET["phone"])) {
                    if (isset($data["name"]) && isset($data["surname"]) && isset($data["password"]) && isset($data["email"])) {
                        $user = $this->updateUser($data);
                        if ($user) {
                            echo json_encode([
                                "message" => "User " . $_GET["phone"] . " was updated",
                                "updated" => $user
                            ]);
                        } else {
                            echo json_encode([
                                "message" => "User " . $_GET["phone"] . " was NOT updated, database error",
                                "updated" => $user
                            ]);
                        }
                    } else {
                        echo json_encode([
                            "message" => "User " . $_GET["phone"] . " was NOT updated, not enough arguments"
                        ]);
                    }
                }
                else {
                    echo json_encode([
                        "message" => "User " . $data['phone'] . " was NOT updated, phone in query and body does not match"
                    ]);
                }
                break;
            case 'DELETE':
                $phone = $_GET["phone"];
                $this->deleteUser($phone);
                break;
            default:
                http_response_code(405);
                header("Allow: GET, POST, PUT, DELETE");
                break;
        }
    }

    public function createUser($data)
    {
        $authority_title = "ROLE_USER";
        $phone = $data["phone"];
        $name = $data["name"];
        $surname = $data["surname"];
        $email = $data["email"];
        $password = $data["password"];
        return User::createUser($name, $email, $surname, $password, $authority_title, $phone);
    }

    public function updateUser($data)
    {
        $authority_title = "ROLE_USER";
        $phone = $data["phone"];
        $name = $data["name"];
        $surname = $data["surname"];
        $email = $data["email"];
        $password = $data["password"];
        return User::updateUser($name, $email, $surname, $password, $authority_title, $phone);
    }

    public function deleteUser($phone)
    {
        $deleted = null;
        if ($phone) {
            $deleted = User::deleteUser($phone);
        } else {
            echo "error";
        }
        if ($deleted) {
            echo json_encode([
                "message" => "User with phone $phone was NOT deleted"
            ]);
        } else {
            echo json_encode([
                "message" => "User with phone $phone was deleted"
            ]);
        }
    }

    public function loginUser($login, $password) {
        $user = User::getUserByPhone($login);
        if ($user['password']== $password) {
            $_SESSION["loggedIn"] = TRUE;
            $_SESSION["login"] = $login;
            echo json_encode([
                "message" => "You are logged in",
                "session login" => $_SESSION["login"]
            ]);
        } else {
            echo json_encode([
                "message" => "Invalid username or password"
            ]);
        }
    }
}