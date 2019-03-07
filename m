From: David Sommerseth <davids@...515...>
Date: Thu,  7 Mar 2019 23:32:55 +0100
Message-Id: <20190307223255.1038-1-davids@...515...>
In-Reply-To: <20190220131906.22970-1-davids@...515...>
References: <20190220131906.22970-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] cleanup: Remove RPM
 openvpn.spec build approach
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
To: davids@...515...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I've fixed the minor differences causing conflict and applied it to
release/2.4 as well, keeping Gerts ACK - as he said was fine in the
previous "patch applied" mail.

Your patch has been applied to the following branches

commit 57ec6cec85b92e6af35a7871d105d84a753d6549  (master)
commit f6a447cb42c097a2b35f55d3ca3e1a4be46738c6  (release/2.4)
Author: David Sommerseth
Date:   Wed Feb 20 14:19:06 2019 +0100

     cleanup: Remove RPM openvpn.spec build approach

     Signed-off-by: David Sommerseth <davids@...515...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20190220131906.22970-1-davids@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18222.html
     Signed-off-by: Gert Doering <gert@...1296...>


- --
kind regards,

David Sommerseth
OpenVPN Inc
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJcgZwTAAoJEIbPlEyWcf3yKWQP/RvgQAmJGu/Y2DYwwPYvDM62
qfJ9mc77sETfwvEM+QcrfXlcrd+/WPOzhmDPfAWp8CGUyE7KS45Jo1a/QDgRRGxD
eqvw7aVaZ2OXkhMM6m5iGNV+w1otls/3ISUvNxyhl8R/rQY6OJWfWZDL/E/pAgTy
VBRtf5AIPBotftAweVoXBEz2k2urwrc+oKbv6V45ndT1qct6FdIDLGv9UxczUniv
9iX9pFsFDGjb5dN9x8mALYrncBR5TpXIxcFsJ/F0g8hX5KRRur0tI9a4rV0bcOh6
qUzndi2+PWuIX8cCsH6o7uzh0cThCrY3y/pGRgzQwqjLJneWUk9/arhdUlDfOZmw
XpUEegpxF0MIinYN10HKDRBjxFPsvTea6vDBeZySJDkpWm5G5h6xulYuQQKUw9Aw
7mXdSeqv7e4aiEIa0Q8wxXoXQKaXYzscGho/GOKry8tGEVUA2UJvJryylxWCMX4J
52jJrKwvouDC4npEbPda395Tj702Vb8B/WozM58g1t0JVnTMzGJuoRzez4AlmL0q
JfPNPy5aO2HePdXqeazUwuW3zlnBaVXV+vu2yKD6C4stsLbdYpiibTfL0EslhpId
frPgO0KI5IlzbMYz644Kn426KLfJJv/3vAMJKL5HSi8KTRnM7eIS43klrImW46NP
w+ukBpXCjtaax8iGAadZ
=G9WS
-----END PGP SIGNATURE-----

