<?php
  require_once "../config.php";
  session_start();
  if(!isset($_SESSION['login'])){
    header("Location: ../logres.php");
  }
  if(isset($_GET['id'])){
    $id = $_GET['id'];
    if (!isset($_GET['kelas'])) {
      if (isset($_POST['cari'])) {
          $search = $_POST['search'];
          $id = $_GET['id'];
          $query = "SELECT * FROM kategori WHERE id_mapel = $id AND kategori LIKE '%$search%'";
          $kategori = mysqli_query($mysqli, $query);
      } else {
          $query = "SELECT * FROM kategori WHERE id_mapel = $id";
          $kategori = mysqli_query($mysqli, $query);
      }
  } else {
      $kelas = $_GET['kelas'];
      if (isset($_POST['cari'])) {
          $search = $_POST['search'];
          $id = $_GET['id'];
          $query = "SELECT * FROM kategori WHERE id_mapel = $id AND kategori LIKE '%$search%' AND kelas = $kelas";
          $kategori = mysqli_query($mysqli, $query);
      } else {
          $query = "SELECT * FROM kategori WHERE id_mapel = $id AND kelas = $kelas";
          $kategori = mysqli_query($mysqli, $query);
      }
  }
  } else {
    $query = "SELECT * FROM kategori";
    $kategori = mysqli_query($mysqli, $query);
  }
  $mapel = $_GET['mapel'];
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Draft Soal Quiz</title>

    <link rel="stylesheet" href="draftMateri.css" />

    <!-- GOOGLE FONT -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=PT+Sans:wght@400;700&family=Poppins:wght@100;200;300;400;500;600;700;800&display=swap"
      rel="stylesheet"
    />
  </head>
  
  <body>
    <!-- HEADER -->
    <nav class="header">
      <div class="logo1">
        <img class="logoAwal" src="../gambar/logo2.svg" alt="SoalPedia" />
      </div>
      <div class="menuAwal">
        <!-- Menu Latihan dan Kumpulan -->
        <!-- <a class="menuLatihan" href="../latihan_soal/draft_quiz.php?id=<?php echo $id?>">Latihan Soal</a> -->
        <a class="menuKumpulan" href="">Kumpulan Soal</a>
      </div>
      <div class="btnAwal">
        <!-- Buat nama user --><a class="btnMasuk" href="">Halo, <?php echo $_SESSION['username'] ?></a>
      </div>
    </nav>
    <!-- END HEADER -->

    <!-- CONTENT -->
    <div class="heading">
      <div class="back">
      <a href="../mapel/mapel.php"><img src="../icon/back.svg" alt=""></a>
      <a href="../mapel/mapel.php">Back</a>
      </div>

      <div class="kritik-saran">
        <a class="tambah" href="../kritik&saran/tambah_krisan.php?id=<?php echo $id ?>"><img src="../icon/add.svg" alt="" /></a>
        <a class="krisan" href="../kritik&saran/tambah_krisan.php?id=<?php echo $id ?>">Kritik & Saran</a>
      </div>

      <?php if ( $_SESSION['role'] == 'admin' || $_SESSION['role'] == 'editor'): ?>
      <!-- Tombol Lihat Kritik & Saran HANYA UNTUK ADMIN -->
      <div class="lihat-krisan">
        <a class="info" href="../kritik&saran/kritik_saran.php?id=<?php echo $id ?>"><img src="../icon/info2.svg" alt="" /></a>
        <a class="lihat" href="../kritik&saran/kritik_saran.php?id=<?php echo $id ?>">Lihat Kritik & Saran</a>
      </div>
      <?php endif ?>
    </div>
    
    <center>
    <div class="main">
      <!-- Nama Mapel -->
      <div class="namaMapel">
            <?php if(isset($_GET['id'])) : ?>
              <?php
                $id = $_GET['id'];
                $query = "SELECT * FROM mapel WHERE id = $id";
                $result = mysqli_query($mysqli, $query);
                $row = mysqli_fetch_assoc($result);
              ?>
              <p><?php echo $row['pelajaran'] ?></p>
            <?php else : ?>
              <p>Semua Materi</p>
            <?php endif ?>
      </div>

      <!-- Dropdown Pilih Kelas buat User Guru,Admin,Siswa -->
      <div class="dropdown">
          <button>
              <?php 
              if(isset($_GET['kelas'])) {
                  echo "Kelas " . htmlspecialchars($_GET['kelas']); 
              } else {
                  echo "Pilih Kelas";
              }
              ?>
          </button>
          <div class="dropdown-content">
              <a href="draft_materi.php?id=<?php echo $id ?>&kelas=12">Kelas 12</a>
              <a href="draft_materi.php?id=<?php echo $id ?>&kelas=11">Kelas 11</a>
              <a href="draft_materi.php?id=<?php echo $id ?>&kelas=10">Kelas 10</a>
          </div>
      </div>

      <!-- Menu Tambah Materi hanya bisa buat User Guru dan Admin -->
      <?php if($_SESSION['role'] == 'guru' || $_SESSION['role'] == 'admin') : ?>
      <!-- Menu Tambah Soal hanya bisa buat User Guru dan Admin -->
      <div class="tambahSoal">
        <a class="add" href="form-kategori.php?id=<?php echo $id ?>"><img src="../icon/add.svg" alt=""></a>
        <a class="tambah" href="form-kategori.php?id=<?php echo $id ?>">Tambah Kategori</a>
      </div>
      <?php endif ?>

      <!-- Searching -->
      <div class="search">
        <form class="cari" action="" method="post">
          <button type="submit" name = "cari">
            <img src="../icon/search.svg" alt="">
          </button >
          <label for="search"></label>
          <input type="text" name="search" placeholder="Cari...">
        </form>
      </div>
    </div>

    </center>
    <div class='draft'>
      <?php
        while($row = mysqli_fetch_assoc($kategori)){
          echo "<div class='draftMapel'>";
          echo "<div class='listMapel'>";
          echo "<img src='../gambar/materi.svg' alt=''>";
          echo "<a class='mapel-1' href='download_materi.php?id=".$row['id']."&mapel=".$id."'>".$row['kategori']."</a>";
          echo "</div>";
          if ($_SESSION['role'] == 'guru' || $_SESSION['role'] == 'admin' || $_SESSION['role'] == 'editor'){
            echo "<div class='icon'>";
            echo "<a class='trash' href='delete_kategori.php?id=".$row['id']."&kategori=".$id."'><img src='../icon/trash.svg' alt=''></a>";
            echo "</div>";
          }
          echo "</div>";
        }
      ?>
    </div>
    <!-- END CONTENT -->

    <!-- FOOTER -->
    <footer>
        <p class="copyRight">&copy; 2023, SoalPedia</p>
    </footer>
    <!-- END FOOTER -->
  </body>
</html>
