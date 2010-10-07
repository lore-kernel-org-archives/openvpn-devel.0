Date: Thu, 7 Oct 2010 17:47:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20101007154740.GL10703@...1296...>
References: <20101007142817.GU7437@...1152...> <4CADE70D.8070307@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sEASj6BbPXAOAu+u"
Content-Disposition: inline
In-Reply-To: <4CADE70D.8070307@...1147...>
Subject: Re: [Openvpn-devel] [Openvpn-users] TAP installation Problem
	(2.1.3) on Windows 2000
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Katja.Stange@...1152..., Ralf Hildebrandt <Ralf.Hildebrandt@...1152...>, openvpn-users@lists.sourceforge.net

--sEASj6BbPXAOAu+u
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 07, 2010 at 05:28:13PM +0200, Jan Just Keijser wrote:
> > WHy is that?
> it's a (minor) mistake in how openvpn 2.1.3 is packaged:

This is not a mistake (as in "oops, we didn't know"), but was unavoidable=20
since the latest WDK is needed to properly support signed drivers for=20
Win7, and that version does not support Win2k anymore.

OTOH, there *should* be a Windows 2000 install.exe, but right now=20
I cannot find it on the download page either - James did build it,
with the old WDK/DDK, but somewhere in the release process it must=20
have fallen through the cracks.

Samuli: can you find it on the internal build servers?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--sEASj6BbPXAOAu+u
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTK3rnKkuBuNlUUl1AQIr9wP/big+XF2JZIeHDECrC3pH8f0WhXBqxVdT
doQzd5YAuEs30hhtgkKRCy+SCxOe3+zeAjUKuNqAPLGDl2Sci8CCdj22CCP0O3GG
Cycl/Cltk280Ke6/BZNtyotA2VLfJsfs7EqJ6LGIiBfll29hqv3eb+W7ut+WuU77
2OjgHnCppZs=
=tUdt
-----END PGP SIGNATURE-----

--sEASj6BbPXAOAu+u--

