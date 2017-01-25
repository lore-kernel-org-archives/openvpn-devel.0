From: David Sommerseth <davids@...515...>
Date: Wed, 25 Jan 2017 19:47:39 +0100
Message-Id: <20170125184739.9781-1-davids@...515...>
In-Reply-To: <20170124143947.27385-1-list@...1798...>
References: <20170124143947.27385-1-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH applied] systemd: Use automake tools to
	install unit files
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
To: mail@...1798...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ACK.  This works wonderfully, and I've tested a few different
approaches.

I slightly modified the commit subject line, so it is clearer
this is related to systemd.

Your patch has been applied to the following branches

commit ca5b4c2aad2370be7862660d274b7485f2d0af71  (master)
commit a125229f509b593dff7ecc24e21b3de384b3fa98  (release/2.4)
Author: Christian Hesse
Date:   Tue Jan 24 15:39:46 2017 +0100

     systemd: Use automake tools to install unit files

     Signed-off-by: Christian Hesse <mail@...1798...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20170124143947.27385-1-list@...1798...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13940.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYiPLCAAoJEIbPlEyWcf3yILQP/RvF3k2eicGox2aYmjrIALoU
rVxFeM2M3nlv2KtJ79HqdN4p3TRvzziijdWFxvVrtRTzbediCqIPZEHrrNYvcfkp
pU9QiPJr+SofPwWPr2Yv7UGMoJ8Rrj96Jx5FlZHUuPeCBLMlYPqIBXAZmVIM8osD
wshPbBO9rumvAaNx9GkaNe+GNDYH909nmL79a1Mw/OQc+7huw7R7Xy37DorukQ3U
tOUcs6Z/PV7j1Uc6sx1+DzFBTCh3whVvnJnK9PAHMomv8cgf4W81Zb0z0QEKmLBI
llyVdQVaj3LBmZVhjPQ+Zq7GgP08znU0GHFrmoqSoGoa2+GHX6XGa4ox8Jeh0uTe
6yVNHFQFSL5TKXx0jxWSDiuZ5SWYTU3YNLKzipaYNaUvrs5m4lFOXuwac3w9NhSf
uFOFBlNYgpWxrJhDulBd2TlXTf6zGEZHQZQvuCigfP34LnVr3CU7cegXdWA+JdSj
YppOivlpKsHc0Mh6WUQGZgaLzulWhz2Dt+BFeHzCktOTS8pC1e3Wn/NqPLyCpJh2
xnMvMhYJsVBqx35Svrsvcm/5M7C+TtnqaEo0KaZT2VSTPIi6gMUdYtfnh7sFSf5J
gBc6Y7WmrR9PmrdmjxDCKnadQNQ7L9Wg1aMHKT5ak18rRcKbxj7dLtvcjB2gtyGp
O51NWaY63QLzXpsQsnE6
=Cyhw
-----END PGP SIGNATURE-----

