Date: Tue, 18 Jun 2013 09:31:14 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130618073114.GW20843@...1296...>
References: <5C629764-6A77-4E0D-8B27-AF0AE8B29025@...1829...>
	<51BCF5D1.6070407@...1227...>
	<BC613B74-D9A7-48B9-94B3-2AFF99BF8847@...1829...>
	<51BE2AA0.7060908@...1227...>
	<CAEsd45QVPywukuUO=h8f+PddGs1EPX2MCRC=ir=iBWEqdKx6zA@...278...>
	<20130617173949.GT20843@...1296...>
	<8B6DA5B7-E5EF-434A-89C5-F9C89D8A8451@...1829...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MoTbte+PTqanp4Nm"
Content-Disposition: inline
In-Reply-To: <8B6DA5B7-E5EF-434A-89C5-F9C89D8A8451@...1829...>
Subject: Re: [Openvpn-devel] Native OS X tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Peter Sagerson <psagers@...1829...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--MoTbte+PTqanp4Nm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 17, 2013 at 11:51:53AM -0700, Peter Sagerson wrote:
> Just a recommendation, but I wouldn't necessarily consider the two=20
> proposals alternatives.=20

I agree - the basic functionality is the same, just some of the surrounding
details are different.  As I said, I need to closely look at both patches
to form an educated opinion for the discussion on Thursday :-)

Still, anything that adds #ifdef to options.c is something I prefer to
solve in different ways...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MoTbte+PTqanp4Nm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUcAMwqkuBuNlUUl1AQLpSgQAv7M4IkJKB7m0KBHKeeClIv4oMVtIzk3t
u5pfvkCE0+RNlDuhpobV387mw/SdPDO1CqCjhrcERvOuf4thyT3eTOnLjWmwGxOP
9N0dgoXumROrtm8k2LTmjqYYXrtXtVM2qVVPjuz0JbwuTG392KVWx6tHnkojQ5QR
15EdErrzMOc=
=C3ua
-----END PGP SIGNATURE-----

--MoTbte+PTqanp4Nm--

