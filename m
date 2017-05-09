From: David Sommerseth <davids@...515...>
Date: Tue,  9 May 2017 21:41:34 +0200
Message-Id: <20170509194134.30077-1-davids@...515...>
In-Reply-To: <1494354764-19354-1-git-send-email-steffan.karger@...1435...>
References: <1494354764-19354-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH applied] Always clear username/password
	from memory on error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

ACK.  This covers the concerns raised and avoids unexpected behaviours.

Your patch has been applied to the following branches

commit 2b60198e08a9d7e8de9beeb65a587ee34107efe8  (master)
commit 47d80b95646a3cf62c9cd46ab589c442124c0474  (release/2.4)
Author: Steffan Karger
Date:   Tue May 9 20:32:44 2017 +0200

     Always clear username/password from memory on error

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1494354764-19354-1-git-send-email-steffan.karger@...1435...>
     URL: http://www.mail-archive.com/search?l=mid&q=1494354764-19354-1-git-send-email-steffan.karger@...1435...
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZEhtsAAoJEIbPlEyWcf3yV+oP/i+1q3oISx2W/O6cBiQBRvJ8
oCzOY3P/VeFNJK2Z4KSG+PDDw5qt0/3AsrI9BHGhYAE98LeR7lcRkRCN/F8ta5KP
/OYRHX1mh9X3tretR9GhnH6Zeab0K33Kqd+v8saxujlPz2uqnXnlAkpecgHZcdGe
PmldC/CSJbcrGGIBgy7rWdhOytpWlQmb+DA/+aIOvfEGFT0aGwWtKSokZG+JNdPa
OJBrj0zPBSDly/z1qirnFgmL2AYQtn1/1BO9ntUtUl8TrfT4cTaMnxMR0doGA/6o
NbPGJuTOa6Vto2HNwyl2AC2MerJ5kvqXgRnifqFRGdB63/fh1HMuuQOf0ch+cOAz
sZ6UboFLZjINicfO8nkap4ouDL6eynho2LWV5Qhfqq19qezif8KVMv+TtPepZMzK
Emtva0fpOAltsVg/p/QzIp6XnmWcyYo0qmYN1YEFmMfCVB1kfUoglO3tghpUTVMv
ZINB0AnNIpemvJ9sX8thqCyJcdlR69Sx1JcJz1RuAdzzrNtz7Spwm43PRWEsBSHO
D0i5jb1KxGcRxLHwbKrfwVuPhP1D1elWYFphyKmY4qIB0BwLcysEh/QUZypKbrOw
6FGSLAJaMI6TL+ezB9YBrmKvLoQMx4TtqQDryXiR/zL5mGzjrmMzHpORBMXe4VlZ
wxD9ALn6SSTN3Zydipjb
=AID1
-----END PGP SIGNATURE-----

