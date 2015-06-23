Date: Tue, 23 Jun 2015 09:39:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150623073914.GH382@...1296...>
References: <55882EBE.9030503@...1147...> <55887C2D.6080203@...1490...>
	<55890A3E.4010200@...1856...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1p1NbnqnRmT6HfKI"
Content-Disposition: inline
In-Reply-To: <55890A3E.4010200@...1856...>
Subject: Re: [Openvpn-devel] about client-cert-not-required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--1p1NbnqnRmT6HfKI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 23, 2015 at 09:26:54AM +0200, Steffan Karger wrote:
> In 2.3:
>  * Add soon-to-be-deprecated message to --client-cert-not-required man
> page entry.
>=20
> In 2.4:
>  * add --verify-client-cert (none|optional|required)
>  * add a clear deprecation message  when client-cert-not-required is used

Sounds like a good plan to me.

As far as the feature itself is concerned, I'm not voicing an opinion
(as I've never seen a deployment without client certs, so don't understand
the implications)

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--1p1NbnqnRmT6HfKI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVYkNIqkuBuNlUUl1AQKsewQAw69V+nCKZrzBx+tpjM+yXVnpSJtOJrd6
2H3PBiBQJnSwYTOOPNbUiWiattfq23HavVkWXZqAxWxQykD9u1a7gMUUSeHrd66E
LBKY61XgprSlDFd3iRHwh5Oe5YdkOerhLVY4JsOevS7PKaPOYtuu4y2lWd8xno+K
eUJCOzhTtSE=
=6oiu
-----END PGP SIGNATURE-----

--1p1NbnqnRmT6HfKI--

