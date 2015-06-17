Date: Wed, 17 Jun 2015 12:07:53 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150617100752.GG382@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="68RnY3phKFzO6ir9"
Content-Disposition: inline
Subject: [Openvpn-devel] why is "route add failure" considered not an error?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--68RnY3phKFzO6ir9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

OpenVPN history confuses me :-) - right now, I am wondering about the
following:

 - if we call ifconfig to set up the tun device, and that fails, we=20
   consider it a hard error (openvpn_exec_check(..., S_FATAL, ...) and
   terminate

 - if we then proceed to set up routing, and *that* fails, we just ignore
   the result (we do take notice that we couldn't add a route, so we don't
   try to remove it later on - but we do not actually fail)

in some situations, this behaviour is causing problems...

Typical example is windows when not running the gui with admin privileges.=
=20=20
Interface config is done by ioctl()->DHCP (which we do have access rights=20
to...), route add silently fails, VPN is "incomplete".  Another example is
trac #563, which after quite a bit of discussion seems to boil down to
"a previous instance of something left around a route to the /28 subnet
that should have pointed to tun1, but instead it pointed to lo0, causing
loops and non-working VPN"...


So, we have good reasons to *not* do it that way, but I'm missing a reason
why this is so...?

Shall we change it in 2.4 to make route add failures S_FATAL?

By default?  Or add an option to turn it back into a soft-fail in case
someone knows what they ar doing?


(At least for the FreeBSD "TOP_SUBNET" local route, I'm definitely going
to make that connected route fatal as it will totally not work otherwise)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--68RnY3phKFzO6ir9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVYFG+KkuBuNlUUl1AQJoVQQAqBtpRLrceb+BFmIAg6737mxdgBkw5Z43
KhJrzpFkf04DVpEUx2BGkOkj1j+tvXfd/zHfOCkeYJ7jxC7uJerE0R9ein5lKqTu
Qik0MKUlepEw0ZSUnN+PY3WXFXw27oYjNCpf9B68BOqcuc/mgITk6FBtCosxFv2z
2CA+ydF6Kks=
=BLbL
-----END PGP SIGNATURE-----

--68RnY3phKFzO6ir9--

