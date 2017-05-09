From: David Sommerseth <davids@...515...>
Date: Tue,  9 May 2017 21:39:59 +0200
Message-Id: <20170509193959.29630-1-davids@...515...>
In-Reply-To: <1494357036-3529-1-git-send-email-steffan.karger@...1435...>
References: <1494357036-3529-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH applied] cleanup: merge
	packet_id_alloc_outgoing() into packet_id_write()
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

ACK.  I have verified the changes against the similar commit in release/2.4,
based on commit 653d39192297880b4f.  No surprises in regards to what this
patch brings in.


Your patch has been applied to the release/2.3 branch

commit 5d747770efa0611cc6cfeb6b3a5853bf51046d53
Author: Steffan Karger
Date:   Tue May 9 21:10:36 2017 +0200

     cleanup: merge packet_id_alloc_outgoing() into packet_id_write()

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1494357036-3529-1-git-send-email-steffan.karger@...1435...>
     URL: http://www.mail-archive.com/search?l=mid&q=1494357036-3529-1-git-send-email-steffan.karger@...1435...
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZEhsNAAoJEIbPlEyWcf3yMMIP/jg339QTeOv2m9NYsO4/AX/G
fNWh5Sby1JBBaD0yJp/a2zDXRUTQli96DXHsZkpH3v23hApAOm/RGhcVM35RrIM2
aFHQGRi6B38yvyHgeBJivv3YbUvtaUpWYwlvj3LzQwWTKidLZNIg3oEroPXrPciA
x/31Zrrf1M8z7iQd+E8dZgCDob7wMyicD9IljjQze8lwMvPUgMcANY6ADZC4sZ6Z
U9M/poGLivJA7dt3Kn6fUlA04IIuxGD1yRKN17E3edxDmqVaGqVSwYC66ZC7ZMzJ
FL11v8UYLgiRbIoEyRhtrtImpGwcfslecYMHvFEZHLLdhkW/TmpAVJTWPDr14w79
E1MvSbUf3v+uqg1W4BJiCJ8PQ3VjIoJ6uUbm44q/nYbLVwzjuTlDBSYzo5GsXKS0
HY6D1YgNp7NviMhRy+4iQFJDVfIGmEE7veISsn2CStuWhLpxENLYoTg53Q66Qntd
Bwfm0VJ1TuWYlNNL0ap6EWJD7c6tb7gy0ErvAXM19EvTpxazeP/QnNioga0mMzUx
Y4Of7FETnNG8j1sb8vsuPRZbPqrK+azuP464mpKKfMAltOQmYIIUfhhiqD9sbPm7
imiolZJXdX+09mqtvRt1uKz9buu+VF5M0P2aHtpUW9ctHf4/EzOJvGS/Py/iLybH
OEUbc6dj7R3DUc9BhWFR
=HI2z
-----END PGP SIGNATURE-----

