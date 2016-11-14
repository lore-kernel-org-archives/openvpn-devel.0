From: David Sommerseth <davids@...515...>
Date: Mon, 14 Nov 2016 23:08:31 +0100
Message-Id: <1479161311-11670-1-git-send-email-davids@...515...>
In-Reply-To: <1479045751-22297-1-git-send-email-steffan.karger@...1435...>
References: <1479045751-22297-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH applied] Move private file access checks
	to options_postprocess_filechecks()
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
Hash: SHA1

ACK, but I added a slight modification at commit time.  I removed
any reference to --tls-crypt, to get this nice clean-up into the
current tree.  When --tls-crypt is added, it needs to be slightly
adjusted to add the proper check in options_postprocess_filechecks().

Your patch has been applied to the master branch

commit 825e2ec1f358f2e81b623f2770fbbf76748b0739
Author: Steffan Karger
Date:   Sun Nov 13 15:02:31 2016 +0100

     Move private file access checks to options_postprocess_filechecks()

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1479045751-22297-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13019.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYKjXbAAoJEIbPlEyWcf3yVeEP/Rs8Yz2iR9j3gp9ad79AIVKs
Hgs+OkAQQaPoUAfVlKaC6fkvgf3p+pFd1yh7eQ45ymnUxlX3ViHs916DUaGn77jA
rgXXCDu5kYZu3+BsknTCk+tO0oWE3GUP1DoSffAdVB5AQ7iyAqELODT5FEhDP4rf
q8NmGoz3XOpjFduAK5O8oK73ftMEYK+Uw31DtJEWnUIK1FxoVLcFP8eOxMVLPKzq
usKM0XO4GeoiFSR7xEKSZ5xvBtxO2edKiQzQpSgu8B12JaPLQ0OZ4SOgTNMSHn9d
eUbbk0qbVyPt8mX8ARKb11/pEV7juG8SBRcii7D+OPbcDjl2YBrc8oHZUjndYRlv
3Zk92R3FudmbpOJEA1CFGzeL94CTpNhWjFVIMncuyt7QO1UdzYu1ikSmO9rXYFYH
3RWp6cMpfYZEo9gu2txYdhJgRpMXOg+TAMHLFkiwN1e2KGHpLEnosnDnP1DBgkkr
atTNiH5c02kjMwIXeo5boLeBer/v+i+T/07dCoxIUghIhY37Y/3MAxw7uzAzzRPw
t7dm/0bTYm0UeGQfMNmHelCKB/b7j1Wn7am1tUZOAkQuzfO/10kMqdOt7G2bW7FJ
22sHlSZ1DtdoUPQUCm2yLqsOnqMyIztCCEapMMW2XAhk6PTG+szyoAat3ri51aDT
BwX3yZLM7VNPtOaRmAfU
=emq9
-----END PGP SIGNATURE-----

