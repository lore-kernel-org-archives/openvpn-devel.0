From: David Sommerseth <davids@...515...>
Date: Thu, 20 Feb 2020 19:19:46 +0100
Message-Id: <20200220181951.7603-2-davids@...515...>
In-Reply-To: <20200220181951.7603-1-davids@...515...>
References: <20200220181951.7603-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] argv: do fewer memory
 re-allocations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net, Heiko Hund <heiko.hund@...1489...>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Your patch has been applied to the master branch

commit 870e2405e27fb0c119ade6fc0032c81af4d89819
Author: Heiko Hund
Date:   Thu Feb 6 14:21:01 2020 +0100

     argv: do fewer memory re-allocations

     Signed-off-by: Heiko Hund <heiko.hund@...1489...>
     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20200206132103.15977-3-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19378.html


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJeTqh3AAoJEIbPlEyWcf3y7JoP/j7hrKtTzmEpYVIbPqC5NDjr
qwk9knNt5tQ1dcoae18qtYkyPXoanxgWnqgMwwyyFZfvU9LenQkFx/edioxRX0VV
PtoniuM512sGKUoPXiKjs8Kpdhpg1swnOqPbgUMx1mhdD3KFpzhKq2U39pAn5d2G
7hzGJd4jP7dU8ilfqpYfNneIXRr65VRimOGTAgquQgkndcy3WUlrLAxpmUS+HYMk
pvWTP6wRi6607ECTTcuRJTrc2317o3RiFcmVxodxSuGWSbASaqtt0hsbChwWG2pu
QFc7Cjxc9Gd7EG2eKG2SItocOpcFJ8tg6tgGj8clnBjWhvLXHGO2TWiBMg3RLEEm
Vq7+3MrCUYwtIUgfSEqnmUCfEEqz+7cwVXONdWnCxW+adN0Iafk1FevCyTIhGF+J
0ZdAVecy8g6eZJTgUC8OX6iIZxKu4JEI6VfgXZ1E0CK196YgIpeDC31xyxB3h/nR
4tmFitE/bh3W/D2QNPe+XJlZKOqbMaq7iluclJuqkE73TWWA9nlK5HRnuaUzYIZv
nYjYyzWrNsDQ5JrLuW7TNFFuONJeUEmuJUaq0HVTOwYCAv+ELScbNCT2Sri3iXg4
a5BibPdVmQOJepLri+7IVdRObtkDbhrJzHj42p/N7Er57BBZLAM1De7jXtLI8ayd
6aO6VHgW5wsUN5ZUbcHn
=KeLS
-----END PGP SIGNATURE-----

