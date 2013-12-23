Date: Mon, 23 Dec 2013 12:32:29 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131223113229.GB161@...1296...>
References: <8c01c399-7f0c-477d-9bbe-dab589231ffc@...1848...>
	<52B75C6B.9080100@...1847...> <52B76494.5010903@...1847...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="88Dt+WjNvgkXZfPO"
Content-Disposition: inline
In-Reply-To: <52B76494.5010903@...1847...>
Subject: Re: [Openvpn-devel] [PATCH v3] Floating: Add support for floating
	in TLS mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Andre Valentin <avalentin@...1847...>
Cc: openvpn-devel@lists.sourceforge.net

--88Dt+WjNvgkXZfPO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Dec 22, 2013 at 11:15:48PM +0100, Andre Valentin wrote:
> Just for reference, I got my throughput numbers from:
> http://thread.gmane.org/gmane.network.openvpn.devel/7384/focus=3D7395

Just so that it has been said :-)

We've discussed the patch on the Munich Hackathon, and we intend to do
it in a different way.  James wants to change the packet format for
data packets anyway (due to bad alignment in the current packet format),
and the new format would have the option to send the session ID in the
data packet as well, like "normally it's not sent, but if we have't heard
from the server longer than <x> time units, send a session ID so that
hmac-float will work".

This code has not been written yet, though, and we have no specific=20
timelines when it will happen.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--88Dt+WjNvgkXZfPO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUrgfTakuBuNlUUl1AQKuFQP/SbwL5sWxbxDEjNfRVlCCg+qkXM4MUsjg
o4I40FFVKu+kJVlLN12L9Sy2iXFAySifzYXI5NPcUS/f26mH881Ylx3j6Z4BchUk
FlUPV9RF+puOZ+lfAs0KmOS7CxeE82NnHZunMDNPcJR2U1JVfdXydAWxmXCawU5b
1AS8xrlxhbQ=
=ZJTP
-----END PGP SIGNATURE-----

--88Dt+WjNvgkXZfPO--

