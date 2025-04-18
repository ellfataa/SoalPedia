<?php
    require_once '../config.php';
    session_start();
    if(!isset($_SESSION['login'])){
        header("Location: logres.php");
    }
    if(!isset($_GET['id'])){
        $id = $_SESSION['id'];
    } else {
        $id = $_GET['id'];  
    }
    $query = "select * from user where id = $id";
    $result = mysqli_query($mysqli, $query);
    $row = mysqli_fetch_assoc($result);
    if(isset($_POST['submit'])){
        $nama = $_POST['nama'];
        $username = $_POST['username'];
        $email = $_POST['email'];
        $role = $_POST['role'];
        $query = "UPDATE user SET nama = '$nama', username = '$username', email = '$email', role = '$role' WHERE id = $id";
        mysqli_query($mysqli, $query);
        echo "<script>alert('profil berhasil diubah!');window.location.href='lihat_akun.php';</script>";
    }
    if(isset($_POST['cancel'])){
        header("Location: lihat_akun.php");
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profil</title>

    <link rel="stylesheet" href="edit-profil.css" />

    <!-- GOOGLE FONT -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=PT+Sans:wght@400;700&family=Poppins:wght@100;200;300;400;500;600;700;800&display=swap"
      rel="stylesheet"
    />
</head>
<body>
    <nav class="header">
        <div class="logo1">
          <img class="logoAwal" src="../gambar/logo2.svg" alt="SoalPedia" />
        </div>
        <div class="menuAwal">
            <a class="menuLatihan" href=""></a>
            <a class="menuKumpulan" href=""></a>
        </div>
        <div class="btnAwal">
            <!-- Buat nama user --><a class="user" href="">Halo, <?php echo $_SESSION['username'] ?></a>
        </div>
    </nav>
  
    <div class="heading">
        <a href="lihat_akun.php"><img src="../icon/back.svg" alt=""></a>
        <a href="lihat_akun.php">Back</a>
    </div>

    <div class="main">
        <span>Edit Profil</span>
        <form action="" method="post">
            <table>
                <tr>
                    <td>Nama</td>
                    <td>:</td>
                    <td>
                        <label for="nama"></label>
                        <input type="text" name="nama" placeholder="Masukkan nama..." value="<?php echo $row['nama']?>">
                    </td>
                </tr>

                <tr></tr>

                <tr>
                    <td>Username</td>
                    <td>:</td>
                    <td>
                        <label for="username"></label>
                        <input type="text" name="username" placeholder="Masukkan username..." value="<?php echo $row['username']?>">
                    </td>
                </tr>

                <tr></tr>

                <tr>
                    <td>Email</td>
                    <td>:</td>
                    <td>
                        <label for="email"></label>
                        <input type="text" name="email" placeholder="Masukkan email..." value="<?php echo $row['email']?>">
                    </td>
                </tr>

                <tr></tr>

                <tr>
                    <td>Role</td>
                    <td>:</td>
                    <td>
                        <label for="role"></label>
                        <select class="role" name="role" id="role">
                            <option value="admin" 
                            <?php 
                                if($row['role'] == 'admin'){
                                    echo "selected";
                                }
                            ?>
                            >Admin</option>
                            <option value="guru"
                            <?php 
                                if($row['role'] == 'guru'){
                                    echo "selected";
                                }
                            ?>
                            >Guru</option>
                            <option value="siswa"
                            <?php 
                                if($row['role'] == 'siswa'){
                                    echo "selected";
                                }
                            ?>
                            >Siswa</option>
                            <option value="editor"
                            <?php 
                                if($row['role'] == 'editor'){
                                    echo "selected";
                                }
                            ?>
                            >Editor</option>
                        </select>
                    </td>
                </tr>
                <tr></tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td>
                        <!-- CANCEL -->
                        <label for="cancel"></label>
                        <input class="cancel" type="submit" name="cancel" value="Cancel">

                        <!-- SUBMIT -->
                        <label for="submit"></label>
                        <input class="submit" type="submit" name="submit" value="Submit">
                </td>
                </tr>
            </table>
        </form>
    </div>

    <!-- FOOTER -->
    <footer>
        <p class="copyRight">&copy; 2023, SoalPedia</p>
    </footer>
</body>
</html>