Date: Mon, 17 Jun 2013 19:39:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130617173949.GT20843@...1296...>
References: <5C629764-6A77-4E0D-8B27-AF0AE8B29025@...1829...>
	<51BCF5D1.6070407@...1227...>
	<BC613B74-D9A7-48B9-94B3-2AFF99BF8847@...1829...>
	<51BE2AA0.7060908@...1227...>
	<CAEsd45QVPywukuUO=h8f+PddGs1EPX2MCRC=ir=iBWEqdKx6zA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="psiQidSaV97t/NN8"
Content-Disposition: inline
In-Reply-To: <CAEsd45QVPywukuUO=h8f+PddGs1EPX2MCRC=ir=iBWEqdKx6zA@...278...>
Subject: Re: [Openvpn-devel] Native OS X tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--psiQidSaV97t/NN8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 17, 2013 at 11:33:54AM -0400, Jonathan K. Bullard wrote:
> I have a slight preference forArne's patch, which doesn't introduce yet
> another new OpenVPN option.

Without having compared the code itself, I second that argument.  No more
super-special-case options (which depend on #ifdef TARGET_XYZ), please.

Now it might be a good idea to find time to actually read both patches
before Thursday and have a more educated opinion :-) *put on TODO list*

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--psiQidSaV97t/NN8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUb9J5akuBuNlUUl1AQImNwP+O9JNLgrjDF656iL0bdMl+7PSkbK7fsep
ixjzh5SpxmA3BOIHgb6pHu1EbUU+4FViNUqqekU4X/A/MYrh0Qv9CPK0NZRoDZ/d
OpsYshNJqMqpTQ5NgT38T9VSdxgY3D2nlrmKElQcp0uvJBltmAF2Ue5j50LNeE4Y
/98JWMw1oug=
=l6MD
-----END PGP SIGNATURE-----

--psiQidSaV97t/NN8--

