Date: Sun, 1 Jan 2017 19:20:35 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170101182035.GE78624@...1296...>
References: <024d01d26459$2589a3d0$709ceb70$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="awGZH0NYyyipry6r"
Content-Disposition: inline
In-Reply-To: <024d01d26459$2589a3d0$709ceb70$@gmail.com>
Subject: Re: [Openvpn-devel] Visual Studio support?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish Wang <fish.thss@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--awGZH0NYyyipry6r
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jan 01, 2017 at 10:01:57AM -0800, Fish Wang wrote:
> I'm finishing up a patch to make sure OpenVPN compiles under Visual Studi=
o.
> I have several questions;
>=20
> - Do you want to apply such a patch to master and/or release/2.4, or shou=
ld
> I maintain it separately?

Unless it's highly intrusive, it makes sense to merge it.

Since we're not compiling with VS, we sometimes break stuff, but this
is not intentional :-)

> - What is the minimum version of Visual Studio do we want to support?

I have no idea.  Something recent, which can do C99, as that's the=20
coding standard we've change to for 2.4 and master-after-2.4

> - Should such a patch be developed against maste, release/2.4 branch, or
> both?

Master (as always).

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--awGZH0NYyyipry6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYaUhyAAoJEB2Cnv7KVigSpe8L/AmJr4Vf1SWyKELqNtKh983y
ZltRSOmJ61wch09VOB+0JDUC8Av9WbjwV8R1kd/i7E8jRCp1yi5NvMU9VpICBkIL
c2TNdVx1fishHnC2VKtiTr84YFjEgbpJbzwVeGWILem//zzcEcge+6bQtvkGeLok
SwY0Fer3mweNJ5CtJP3IKwM8vNxRWgkNHjxECobU7ClZtGPcR4wII45auBL83ddp
xKBeiXosio4xqm7SywFALy9jQObGU1MjOhmVMowAcaXl6RYznmJTU2b1oGh0fetU
J9XPD9X7FNbuSQEy1hAwbyGxE5Ze4yMrBU5+8SWTH7TzWDgUSb2sdCHRGGtukSiw
2Uljlap2HPw7yCqklDulant8eyj+6TSxQxZ24SMiASx6RnXpwAuMVGbMmwAvZ+a+
euQvqlw4x9wNI4YbxdG6ZycT+62wrIkg/cS43wkqTRFjI0Tn7q0/pHLEdPhlcvr9
Bfn+pdlz/tvKdXYwBWrT6uRBgMYceSEAeV3lkXvpyg==
=WGg7
-----END PGP SIGNATURE-----

--awGZH0NYyyipry6r--

