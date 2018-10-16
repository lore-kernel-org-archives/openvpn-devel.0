From: David Sommerseth <davids@...515...>
Date: Tue, 16 Oct 2018 22:38:34 +0200
Message-Id: <20181016203834.10474-1-davids@...515...>
In-Reply-To: <20181008214123.10819-1-arne@...1227...>
References: <20181008214123.10819-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH applied] Refuse mbed TLS external key
 with non RSA certificates
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
To: arne@...1227...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Fixed coding style detail spotted by Steffan on-the-fly during commit.

Your patch has been applied to the master branch

commit b3c24842a807014c1663eed6f79e888d73182205
Author: Arne Schwabe
Date:   Mon Oct 8 23:41:23 2018 +0200

     Refuse mbed TLS external key with non RSA certificates

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Steffan Karger <steffan@...1856...>
     Message-Id: <20181008214123.10819-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg17671.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbxkxHAAoJEIbPlEyWcf3yOv8P/1SZGc19VLoq/5CcEpWIdjSX
qQOLUXKUt8w83cnoo2vpZLEZ/tKD0NoPdtqJWFd4Wk1xr2+t2DfmkDzaO/c1UOwa
zM4aAHhAH2ZPSrZcNcu0VU4TfzpvFv4APM4cgrYP9xUqWeQH3WiXN1SGF8WJCMlc
korhfoDeA3Ph4OXXtRl0lV0x0EasTwR95MdMA5J1CcZ5NPKP2ZCG1hrhEJJ/quqO
tfIeH0QkQRtWJnOkLrnR0VqOGdxyXIk5sHMTAoZsrDFa6lVIL3TAA8iPIM9vrB7U
QSGstRzd/IZNJNMLwfaPwxec8jPZJiuubxWwQbR7H4MyR4+D8fO+QbSk6kKPBvXB
QMaV6GHTqj3dVJel4yCAhDquIaskhUC70a9ZDJrcqtdSHh+oWAPPC9tcbrDk7mnX
QnSTVdESguZUdhQJHfOcLmwvIWA+ASmYw+cZwF2aXQwMikutqbQYMANBDQBY0767
j44tIwppE4XJQkXhAP0BBIEp8E/zvhxw/bH3THw0mbSLGeW4FkxxYeH2ouYiSTsq
uTb2FUQUNiHByLIcGAWszAHzk+HajeAnQSuRyQotM5JorSqt4CM43kpgOWl05Jbm
YQmRPgMhDJ5jlZ4Fm7BGFtppPrrV8AqwSmXuC8gZoHN99ILtnoC/FgygMNYwwrZ/
kpIYhYV8JwXlS2/IeS+t
=aHf+
-----END PGP SIGNATURE-----

