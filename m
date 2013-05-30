Date: Thu, 30 May 2013 21:55:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130530195530.GT20843@...1296...>
References: <1369920428-11350-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EmDgyYu839ff8lqi"
Content-Disposition: inline
In-Reply-To: <1369920428-11350-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Only print script warnings when a
	script is used. Remove stray mention of script-security system.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--EmDgyYu839ff8lqi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 30, 2013 at 03:27:08PM +0200, Arne Schwabe wrote:
> + if (o->up_script || o->ipchange || o->down_script || o->route_script
> +     || o->route_predown_script || o->auth_user_pass_verify_script
> +     || o->client_disconnect_script || o->client_connect_script
> +     || o->learn_address_script || o->tls_verify)

... while I *do* like this approach, and jjk has acked it, buildbot
send a strong signal that this is not good enough...  if compiled
with --disable-ssl, half of these options do not exist.

Postponing 2.3.2 a bit :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--EmDgyYu839ff8lqi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUaeusqkuBuNlUUl1AQIf+QP/RpM5Ngl9aNHkoa3cFh6VBqqtIvU9fwx9
mdbLKAPbxxvsY0nVcd680+iTbYmkCHpRydowqrP0Lbc+8hI93ETYnTwRMUKj5wS9
/vGpUTSEZIzCeXny9LTB8EyLSNSIBnX1E6Pk/0yBZgQtub+PMTbuOrCV21i055tC
a3OmZ1K3KGg=
=+E1/
-----END PGP SIGNATURE-----

--EmDgyYu839ff8lqi--

