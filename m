From: David Sommerseth <davids@...515...>
Date: Thu, 11 May 2017 18:49:02 +0200
Message-Id: <20170511164902.2707-1-davids@...515...>
In-Reply-To: <1494449775-22199-1-git-send-email-steffan@...1856...>
References: <1494449775-22199-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] Introduce and use
	secure_memzero() to erase secrets
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
To: steffan@...1856...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

ACK.  Verified that the code itself is the same as in master and release/2.4.
There are a few difference where secure_memzero() are used, which is natural
due to the differences between the 2.3 and newer releases.  Overall, it
looks good.

Your patch has been applied to the release/2.3 branch

commit e80c659d1c65db2047a245a50287906fda03d305
Author: Steffan Karger
Date:   Wed May 10 22:56:15 2017 +0200

     Introduce and use secure_memzero() to erase secrets

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1494449775-22199-1-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14628.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZFJX5AAoJEIbPlEyWcf3yAZEP/ArqOAsQIFOmcElbobjQdnJ8
y4tjMsA0SlqPmMcnzEE1qr/A69zg1fshqRxHrnmdxcLCd7ge/A66dBrmBBdb3QMP
qN1kXBK12jrTXfrBBjOvg2kwx5Vpa+7oUjm0GG2V4WiAT+hpzHclGF3PE5YeUXIP
X3SY9eFMsAWofX9XP2kJkEV4uTnKHyGeZaEHhkwJFqm9+jFqurF5xa9SJ0VzztPI
oCK0IFlEMSwZwSHpHyCPA5NxUyv7GdrbKzDqZKZ6+5gROJQ7nX/SqoUGobnujFxq
lYffAJqGUJe5/Oif3AI1AIVsT1H3Nik58e4HWOxo2L7gAHLuOAlxfKH4qg/i0qJs
FuomcAMdnsuid7Pqxu1qMC6+gVuxel6Z9vb14Na6jy8qHK8fP+CHqZcwmO8ziYVw
CN6f0Ecs6OUvDN4X5zMw++CA2JIOBBI6TxBoEgzrDP7xbY20PeNWsDQlKckAX0Ai
0RRRlNZ2rVEZFWoxjx1l+2t/T2fk7HXjnkKwamoHWrWueJkKfIvM77os3GeF5jBr
4ymc0NsmnVZBaGCUE+3QTdvIni+gAUdmAIGJDbgs9Hu4lqEWo0k/naNSc7vExm4Z
ORoQhc/c5v6x2X/LxU+nKy2gVZS9lTmVUBzl/Ey7xTymWHlpY69iH+m/yNxdevJh
mvnN0x9D6ahDSU4R6VPf
=GqO4
-----END PGP SIGNATURE-----

