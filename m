Date: Fri, 16 Mar 2012 16:21:45 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120316152145.GF1359@...1296...>
References: <4F632647.30603@...515...>
	<20120316114747.GV6615@...1330...>
	<CAOazyz2K4s3V3Yq6W8f9Q2us+vk9ArLT1UX3gKCS4Zxr245o+g@...278...>
	<4F633670.1000807@...1114...>
	<CAOazyz0nMAdD5H2MbBR=+ssOPPHgFsdgxr2g-SwWb4BHzDMdcw@...278...>
	<4F633B0C.8080502@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ivd6Nf4GAZ12BQqh"
Content-Disposition: inline
In-Reply-To: <4F633B0C.8080502@...515...>
Subject: Re: [Openvpn-devel] New generic buildsystem: lzo enabled or
	disabled by default?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Ivd6Nf4GAZ12BQqh
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 16, 2012 at 03:07:24PM +0200, Samuli Sepp=E4nen wrote:
> Having as much stuff as possible disabled by default and then enabled
> selectively _feels_ cleaner. But I'm fine with either approach.

I think the default should be "what most people are using".

 - enable crypto and ssl
 - enable lzo

> Personally, I don't think we'll get many complaints if lzo is disabled
> by default. As Alon points out, this is not the only thing packagers
> need to adjust to, so they expect things to work differently. Hopefully
> this translates to them paying some attention while doing the builds :).

It would annoy me a lot to have to remember to add --enable-lzo whenever
I build, and I see no compelling reason to change the default.

About the only time you want to disable lzo is if you need to save code
space, like on very small embedded systems - and that's the exception,
not the common case.

(And I don't see any reason why "the packages that people ship" should
be built with non-default options, except "the default options do not
make sense, so all the packagers need to change the options")

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Ivd6Nf4GAZ12BQqh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT2NaiakuBuNlUUl1AQJv8AP+N1wE2gOSZ8X+k7h7UTg6dZgWm6dg83ah
IDip4O52BMhEv4IUqlp3gs5ScMlp9Of3KWeaszzWGr28dCqfQtb0mSqIul1qA5kw
8WxO1zIW0WhU58FGgvfcTafRKUs+AyY32Tduc156RwGthOX3L/P9tuzD0vANuHw7
wnqYnWvXYog=
=RBDY
-----END PGP SIGNATURE-----

--Ivd6Nf4GAZ12BQqh--

