From: David Sommerseth <davids@...515...>
Date: Wed,  6 Dec 2017 22:35:26 +0100
Message-Id: <20171206213526.20213-1-davids@...515...>
In-Reply-To: <20171206154356.30764-1-a@...2181...>
References: <20171206154356.30764-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH applied] Allow learning iroutes with
 network made up of all 0s (only if netbits < 8)
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
To: a@...2181...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

ACK.  Code makes sense and seems not to break an existing server
configuration I have.

Your patch has been applied to the following branches

commit a19c56db9bd42b7b8c4a8f353f7db92781397cec  (master)
commit 80614c7c547c84e0884cf2bde1dbbac76b4767c3  (release/2.4)
Author: Antonio Quartulli
Date:   Wed Dec 6 23:43:56 2017 +0800

     Allow learning iroutes with network made up of all 0s (only if netbits < 8)

     Trac: #726
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20171206154356.30764-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16044.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaKGJuAAoJEIbPlEyWcf3yEWoQAJ9T+3H4EzmfvH3JKuLoQZpc
galt9+wDH1raFEGBUAECf+wnEgNA+QGbM7Sv0E1xXaqAfuRup7A1GJyIKqN2yaLN
SF2RMiihmnu9S33qUkiBMzH9KiU974G6zwZVRtd+NpeEak7a3PaHM0nyIyOvuX5Y
cm/npJTAvgolxW7WvPQrmuJ9qwKFitGD4d4KMU6AmA7Bs+Jfk2MFwfjpZTx9UxEa
YR9EdZU7kVxF/H5mai8xdsTkLUpccdywaDet2TOjEYU+4gTZdBEP5afRrO8VU27b
U6ynTmny94LYGBG1mnSj4f/l3gMSfPWLKm/nw1s0FyoBRKme0Wp637NJfqRBQj25
KQJXye8dR80Dlf2UjDpEARNPeb81CNFpYx2q6tnO1iMjLXH+SB10Glmp4qh81nuA
Gp4DyNRSj8DGx/ocWqVKldCVpH4swlFVG2HNA3b6E2pFt5Y+0qmIsizywxbT0NzX
aL2FDNU+ibhgoFcW08pEFUtFmmMlAfq4Nb3cMJziebQYEVyFFupM4ajZ41Esxd2+
1XfwHrLblgNHQ5j3+p6uO1Hgy4lb4IyrNEqmEFzX+MbcLimva4dWvaTccFHHt0jX
4snpPc7zN4s9Ir/pc5hQUd9mkY/Vd1NrOnCwBJh0KB9WTivBCMFk1Qo+AOJEfl7e
B0SE4yDZTUWM8ANmavQw
=77MP
-----END PGP SIGNATURE-----

