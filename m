Date: Tue, 25 Feb 2014 09:22:38 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140225082237.GN16637@...1296...>
References: <5302AADC.80801@...277...> <20140218085500.GU16637@...1296...>
	<530340C4.5060702@...277...>
	<20140218115015.GW16637@...1296...>
	<5304AFE4.2050702@...277...> <530917A4.4050905@...1528...>
	<53093043.9080808@...277...> <5309B31C.50208@...1856...>
	<530A9219.8050809@...277...> <530BE62F.4090709@...1856...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JJMoBJ7VTrzwkVuk"
Content-Disposition: inline
In-Reply-To: <530BE62F.4090709@...1856...>
Subject: Re: [Openvpn-devel] [Patch] ECDH support
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

--JJMoBJ7VTrzwkVuk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 25, 2014 at 01:39:11AM +0100, Steffan Karger wrote:
> > I added warning if DH isn't specified - old client may not support ECDH.
> > Autodetecting ecdh is a good idea - I made option ecdh=3Dauto.
>=20
> On the long run I agree that a warning should suffice, but for now I
> would really like to stick with forcing the DH-file to be present. Lots
> of people using OpenVPN do not understand the crypto or configuration
> options properly, but do rely on it for secure communication. As long as
> EC-crypto is not common, I prefer to make sure OpenVPN can always fall
> back on DH.

+1

[..]
> Although there is apparently more work to do to get more cipher suites
> working, this does give us a start on working with EC-crypto. Maybe this
> part can go in (once ACK'ed) as 'the start of EC-support', so more
> people can help improve the code. Any other opinions on this?

- easy to understand and a bit more detailed README
- ACK from a "trusted contributor" (read: someone who has worked on the
  OpenVPN crypto code before and knows the pitfalls)

then I'm fine with it

- PolarSSL...?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--JJMoBJ7VTrzwkVuk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUwxSzakuBuNlUUl1AQLYUAP9EqezQH0K2H4ZGjtx0BwqQYcfDg03n9x1
wgZj0ABNX+DsmohxaeMsJzXyC8bIyXe531OIs4l5+Cm69SjjXXUoVwe1tkVwhfIT
e+U29+7GL2XHBwPEGj0uGNRj+fQsfwxahU1X9FT/gCa2k9YS/n8xBldsG+HEwvsc
eQ4oLaAqqbA=
=uCLt
-----END PGP SIGNATURE-----

--JJMoBJ7VTrzwkVuk--

