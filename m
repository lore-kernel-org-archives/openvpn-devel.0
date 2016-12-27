From: David Sommerseth <davids@...515...>
Date: Tue, 27 Dec 2016 11:38:28 +0100
Message-Id: <1482835108-30102-1-git-send-email-davids@...515...>
In-Reply-To: <1482779743-9548-1-git-send-email-steffan@...1856...>
References: <1482779743-9548-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] Textual fixes for Changes.rst
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

ACK.  I have applied these changes, incoroprating Selva's comments
and done a couple of additional minor adjustments.


- - In "providing IPv6 DNS servers" section, changed:
     ...  pushed to clients and `` --up`` scripts and ``--plugin``
 to 
     ...  pushed to clients where `` --up`` scripts and ``--plugin``


- - In "With OpenVPN v2.4, the project has moved" section, changed:
     ... it is recommended to do use -std=gnu99 in CFLAGS.
 to 
     ... it is recommended to use -std=gnu99 in CFLAGS.


Your patch has been applied to the following branches

commit f38942d1440575e23d9f8713db435b434381486e  (master)
commit 1fd40c781882426c4ed0770725a58d043c000816  (release/2.4)
Author: Steffan Karger
Date:   Mon Dec 26 20:15:43 2016 +0100

     Textual fixes for Changes.rst

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1482779743-9548-1-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13732.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYYkRwAAoJEIbPlEyWcf3y9rcQAKxbIStYB/Jjcw4JB6f0w63D
/h4UdCnCfc9BGLwQEIU2N34yJxALHHsSJdw/M3LifOM6DVt/bEGNa36hKSl9zYrm
pVGAMCC95cq8Q/tgZjgXQXbI5wZeCMHYGRXPNvM7bi6UrQMqP9Fq2QujfXMYI6Zt
DbXSmpabUzxqzLNN2/wOmVRkh6AK1IK2PvpT2c2ypZKjx8SlLY1wnQaSlimXPg4s
lvaCpCuy1bI8kML+M/loHGT0GUL7SWE0XAKDg5cVF2vbJ46Nw/GZD+snI0nMBv5x
uYVHC9tB+KI4GPszjv8KcoWfA+1Fy7UzFjXU2dFVCsh4S5egm/OQX8TU9/5s9Xk8
DmRejvNNNjGAujoq2ldjd/J9Bpvi0ldwZuW8fPD+Ngf0snFXVUz/e+vD5unNvF1w
bNLp93ke5wxACZAfBJBcwhOfvmEaNwy6T23uviBTGeIZ6KGskeiE8hgaPmpVcas9
3d1m5PtGHIXQ9c0i4znNVla8Fv9F52iLAcyG4jr61w22mQ6iG+QLa0xofCVrUTm6
wDlk0293W7urB0l6EH+P+A6d3pDnYrjCpaSWnh1wxrrC1W/CJwlIXXmArGeVPZ3o
ETZkR7WOzkdFqrPgKHnEP9w/IcYYJTKABRXmIJzXX3kChQu87Vr+Q13NJI1PYZ4K
Uogbtwvw7SrmhCNjT+qO
=Scz7
-----END PGP SIGNATURE-----

