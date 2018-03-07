From: David Sommerseth <davids@...515...>
Date: Wed,  7 Mar 2018 23:11:08 +0100
Message-Id: <20180307221108.9545-1-davids@...515...>
In-Reply-To: <1515067670-13094-1-git-send-email-steffan.karger@...1435...>
References: <1515067670-13094-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH applied] Check for more data in control
 channel
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
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

So I've glared a bit on the code, and it makes sense to me (while not
claiming I fully understand the full timer logic and scheduling).

Smoke tested patch on RHEL7 (client) and Fedora 27 (server) and tested
server code using the openvpn3-linux client as well.  Everything seems
to work as expected, including 'make check'.  And since James didn't
have any objections to this approach, I consider this safe to go.

Acked-by: David Sommerseth <davids@...515...>


Your patch has been applied to the following branches

commit b00d56e1b0cf4d71dc4944ef14ea7eca2fc8c519  (master)
commit 8f15fa94dd9d7c4ce2dfe3378bd6311e2ad121ba  (release/2.4)
Author: Steffan Karger
Date:   Thu Jan 4 13:07:50 2018 +0100

     Check for more data in control channel

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1515067670-13094-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16151.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaoGN5AAoJEIbPlEyWcf3ywZwQAJk0JkYcEw0PX0QbWGDsaY7F
QqRMtp4kH9Agsx1/P2Sr5B8H08XBaWDrf+2u/qcZxefB5J7b6CCAR8ueqz+vBtOv
PmUvHGrGKOZiqF2pQdqcZ+3pvljLVgXcw0uKOu4MM7TBeVhIN93F902xJE3r4cju
G3K3Nv4CkgokNI2I/XBrZWJxeBSUn7gwuAwpIEcvo9LVMoaA1H24xdpIj39W7GdO
qnouQUyQSo7UIufrkfqc06+inGGlQzSm31nVM3nGVMLOSnPi6Mjpo6GVhfLhEZMT
R/IHnSL1P0/b1GXXe1OFmTw2NSIj+L2dixxFEhaaaUcfWzHn+EfnZiQNd6b+AEMV
aqhJZfoQncIKLS3P4by27PSGEs3L416HGDUUGnFHtQxLw1YCUv8E1QvAznrGi2Ek
m8lNntoW70y8jrHMnnkdrWI+/Ert0G0ZPDgl0O2ejnje7Y6FLgeU7HDu6dIC/2xs
Xe55bdZi5rxVtgjh/jsrIZpi+yYorBKJSGKcZvappwjCGwzjY42biSOlo3dMrvFJ
ASHYrzH47lRz+Wxl8Eixy43hcVqYYuebEkbzuLcMOF5LlNjX1biE8CrCgbNkL59t
9ClW9uglx7yfUP+BwgIzo/sD4s2IcAdE3dd3+v2QBvownuC6su+PQzo7GXfeeMlJ
Xg514b81EsUdEeT4r5gY
=C8xP
-----END PGP SIGNATURE-----

