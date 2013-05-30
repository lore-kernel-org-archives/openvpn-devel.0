Date: Thu, 30 May 2013 21:04:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130530190437.GR20843@...1296...>
References: <0LzcMG-1ULZ4T0Fuc-014gq9@...1825...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t3wCcZxwnWQbJWrM"
Content-Disposition: inline
In-Reply-To: <0LzcMG-1ULZ4T0Fuc-014gq9@...1825...>
Subject: Re: [Openvpn-devel] Provide more accurate warning message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net

--t3wCcZxwnWQbJWrM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 30, 2013 at 04:20:55PM +0200, Davide Brini wrote:
> +    msg (M_WARN, "NOTE: starting with " PACKAGE_NAME " 2.1, '--script-se=
curity 2' or higher is required to call user-defined scripts or executables=
");

ACK, this text is even clearer than what Arne proposed.=20=20

I'll see how I can get this to apply, as the patch itself won't fit on
top of the other one changing the same line...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--t3wCcZxwnWQbJWrM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUaeixKkuBuNlUUl1AQK9KAQAvBFNWsCQcrCN6M/kjOhQHzZw/zDdCF9z
1/hJaeR7edUzWO2hoIz0H2zb3LKMNXNwgTqBvuy82Z1MWTktUL5ycnvJNWenljJ1
MC6YMZOS4vMYxZYax5UV1ED0tjGhwqDc2xoaPE7f+WyEVkgv10aLkZ/sD1P5PjGh
veVAmGC8zLc=
=8IJG
-----END PGP SIGNATURE-----

--t3wCcZxwnWQbJWrM--

