Date: Thu, 2 Jun 2011 19:39:02 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110602173901.GV8496@...1296...>
References: <4DE7B038.8010804@...1030...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0cIwUVkPINaeW+5C"
Content-Disposition: inline
In-Reply-To: <4DE7B038.8010804@...1030...>
Subject: Re: [Openvpn-devel] minimalistic OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Mr Dash Four <mr.dash.four@...1030...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--0cIwUVkPINaeW+5C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 02, 2011 at 04:46:00PM +0100, Mr Dash Four wrote:
> Is it possible to build a minimalistic version of OpenVPN to be used on=20
> portables?

configure --enable-small --disable-management (and maybe a few others)

As far as I have heard others talk about it, there already is an OpenVPN
version for Android...  so maybe that is an even easier approach :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0cIwUVkPINaeW+5C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTefKs6kuBuNlUUl1AQJanQP/cV0+OjgsFcUPXg8R2wVR2+yQoDK+d/h/
V0mpVfSfKw1BhyK1iAlELhOUVlgpidplB9UeYKMTHSxwpJ+J5Wsk4la9M9AxeURZ
zkKAczWQ//+dErZWMAXgXy1HwsmcmestoOpR4NZ8vZ6ew4vfkBu1oln3vBcMJPo1
fBQEHO/2cXA=
=Webv
-----END PGP SIGNATURE-----

--0cIwUVkPINaeW+5C--

