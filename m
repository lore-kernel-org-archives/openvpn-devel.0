Date: Mon, 21 Jul 2014 20:48:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140721184801.GU1118@...1296...>
References: <11052645.930865.1405935348844.JavaMail.root@...1893...>
	<20140721120346.GL1118@...1296...>
	<53CD0B1B.6000801@...515...>
	<22905346.946911.1405963050383.JavaMail.root@...1893...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2zmMdo9kaOZMikRi"
Content-Disposition: inline
In-Reply-To: <22905346.946911.1405963050383.JavaMail.root@...1893...>
Subject: Re: [Openvpn-devel] OpenSSL in OpenVPN software to be replaced?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lisa Minogue <lminogue@...1892...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--2zmMdo9kaOZMikRi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jul 21, 2014 at 07:17:30PM +0200, Lisa Minogue wrote:
> Hi Samuli and friends:
>=20
> This is what I think.

Don't think so much, use google first :)

> Both of us don't know how long it will take for OpenSSL to fix the long l=
ist of bugs -some of which are significant- that have accumulated over the =
years. One year or two years?
>=20
> OpenVPN is in the business of providing software that enables secure comm=
unications. Can OpenVPN afford to wait one or two years for bugs to be fixe=
d?=20

What makes you assume that any of these bugs are security relevant?=20=20

All software has bugs, and of the OpenSSL bugs so far, only two had=20
really nasty effects on OpenVPN (heartbleed and the most recent weak
crypto one) and heartbleed only affected users that were on 1.0.1, none=20
that were on 0.9.8.  So while one might have opinions on OpenSSL code=20
quality and maintainability, it's track record is fairly *good* for code=20
that has been around for so long.

But we don't have to "wait one or two years".  PolarSSL support is here
*today* - you can build OpenVPN with PolarSSL just fine.  It's just that
the binaries we provide for windows are currently built against OpenSSL,
because nobody extended the windows build environment to build against
PolarSSL.

(If you feel we need windows binaries built with PolarSSL: patches for
the build system are welcome.  We are always short on time, so contributions
are welcome)


> How will OpenVPN address the concerns of its Access Server's customers? D=
o Access Server software incorporate OpenSSL or PolarSSL?

AS could be built with PolarSSL mostly fine (some functionality is missing
in PolarSSL), and judging from the patches I've seen from James, he is=20
working on it.  But for AS, ask your commercial channels, not this list.

OpenVPN Connect on iOS uses PolarSSL already today.

> Hackers and agencies sponsored by their respective governments
> will have a field day disrupting secure communications enabled by
> the use of defective VPN software. Economic espionage will wreak
> havoc on the markets and create unfair competition for those
> countries which are technically and scientifically superior. Human
> rights abuses will be on the increase.

You're welcome to funnel your excitement about the poor state of software
into patches that contribute what you think is missing.  The rest of us
is already busy doing so.


> I accept that substantial portions of the current software code for=20
> Windows will have to be rewritten.=20

Nothing at all of the *code* needs to be rewritten.  OpenVPN with PolarSSL
support is here today.

What needs to be done is extend the build system to build windows binaries
with PolarSSL - building so for Linux is very easy today, just call

 ./configure --with-crypto-library=3Dpolarssl
 make

and you get a polarssl-enabled OpenVPN binary.


> But aren't you also doing it for Access Server customers? Aren't they aff=
ected by OpenSSL's bugs?

This is not the AS support channel, so we can't answer questions about AS.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--2zmMdo9kaOZMikRi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU81gYakuBuNlUUl1AQK7bAQAwlR0jOB7zh3EJbn4iLEkvrG8056aHKH4
lHvz6rb1ML5lZ2X6vdHiCgeJ6CYUmv/8moIh7S/5ixlLA4bm2dILiN/Wy+bNQqBi
R6bdXrJK86ggjeuwKtn9KDVcd+lqQzBxuhOamDhENX/mXznn6jCWDzkHNJLt9tsY
8jP0U+rq8gI=
=iHTx
-----END PGP SIGNATURE-----

--2zmMdo9kaOZMikRi--

