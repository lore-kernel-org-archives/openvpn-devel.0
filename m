Date: Mon, 21 Jan 2013 13:23:01 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20130121122301.GY22465@...1296...>
References: <1358411009-2350-1-git-send-email-steffan.karger@...1435...>
	<1358411009-2350-2-git-send-email-steffan.karger@...1435...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZM8KhnpE6nnHs8oN"
Content-Disposition: inline
In-Reply-To: <1358411009-2350-2-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 1/3] Improve PolarSSL
	key_state_read_{cipher, plain}text messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net

--ZM8KhnpE6nnHs8oN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jan 17, 2013 at 09:23:27AM +0100, steffan.karger@...1435... wrote:
> From: Steffan Karger <steffan.karger@...1435...>
>=20
> Instead of logging the fact that an error occured, log the error string o=
r (if
> the PolarSSL build does not include this feature) the error code.
>=20
> Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>

This looks good to me - ACK.

Description of error_strerror() is here:

https://github.com/polarssl/polarssl/blob/master/include/polarssl/error.h#L=
91

(Even though the design decision to call a library-specific error reporting
function "error_strerror()" is not something I find particularily well
chosen... what's wrong with "polar_strerror()"???)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ZM8KhnpE6nnHs8oN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUP0zJakuBuNlUUl1AQKLQgP/T7tUf+PAlOvLNemMTm0vDGArohQJNpnT
/LWi+xJjmK9R4rO1clFySdNmuiAy/MVEjr/rrZ1htQe/cHzfoL22asRiR4F8t2Es
UI6/GcvRWdYwqREm5xY6lIyq7bQ1rRrzgP0pgvqNYDE4WYbaY0P56TcLolB1rdzW
mwdOgw9HAgc=
=wng3
-----END PGP SIGNATURE-----

--ZM8KhnpE6nnHs8oN--

