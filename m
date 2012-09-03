Date: Mon, 3 Sep 2012 14:21:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120903122151.GP18296@...1296...>
References: <1346674564-17260-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b0op/nKJ9CeIhp9z"
Content-Disposition: inline
In-Reply-To: <1346674564-17260-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Document that keep alive will double
	the second value in server mode and give a short explanation
	why the value is chosen.
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

--b0op/nKJ9CeIhp9z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

ACK :)

gert

On Mon, Sep 03, 2012 at 02:16:04PM +0200, Arne Schwabe wrote:
> ---
>  doc/openvpn.8 |    4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index f586744..6b10fe4 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -1584,6 +1584,10 @@ and
>  .B \-\-ping-restart
>  in server mode configurations.
>=20=20
> +The server timeout is set twice the value of the second argument.=20
> +This ensures that a timeout is dectected on client side=20
> +before the server side drops the connection.
> +
>  For example,
>  .B \-\-keepalive 10 60
>  expands as follows:
> --=20
> 1.7.9.5
>=20
>=20
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and=20
> threat landscape has changed and how IT managers can respond. Discussions=
=20
> will include endpoint security, mobile security and the latest in malware=
=20
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--b0op/nKJ9CeIhp9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUESg36kuBuNlUUl1AQIo4wQAsFosqpZzyLFH7ClGnYXSScB6LqcHncDG
SvvdQ0/R/lzLWgo+3VeCLII1RLXvg6oV3b26oQlDghFK/fKSvWd75igaKay2L+UO
APX5olvHxjEtL15YvUVpw9iFOLprHa9w7ZogpC9N7/6UrU+aqV1+m6CZeBdgPTA9
MzcSX5K9Fhw=
=Aj6m
-----END PGP SIGNATURE-----

--b0op/nKJ9CeIhp9z--

