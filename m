Date: Wed, 20 Aug 2014 10:15:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140820081530.GW1118@...1296...>
References: <CAFLxGvy77WaHhrsqSfm2Va4fbD_y5Ta5ykMsczCQ=-Z9AkNjnQ@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p/86pQykzvg7BfF3"
Content-Disposition: inline
In-Reply-To: <CAFLxGvy77WaHhrsqSfm2Va4fbD_y5Ta5ykMsczCQ=-Z9AkNjnQ@...278...>
Subject: Re: [Openvpn-devel] Ongoing Windoes 8 issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Richard Weinberger <richard.weinberger@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--p/86pQykzvg7BfF3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 20, 2014 at 09:32:46AM +0200, Richard Weinberger wrote:
> This bug exists for almost 14 months (!!) without a solution.
> Some hacks work some not.
> https://community.openvpn.net/openvpn/ticket/316
>=20
> I really wonder why this issue is ignored by the OpenVPN developers.

We'll send you a refund for the money you've paid.

Seriously: because the amount of free time people can invest is limited,
and Windows RT isn't high on the personal pain list for one of the Community
developers.  If it bothers you so much, take the source and fix the issue,
we're happy to review and merge the fixes.

OTOH, OpenVPN Tech *has* started tackling the issue and funded work for a=20
NDIS6 tap driver (which is more than "just recompile") - which nobody=20
tested for about half a year, so the remaining bugs have only been=20
uncovered recently when Samuli started to ship all the windows installers=20
"for Vista and up" with the NDIS6 driver by default.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--p/86pQykzvg7BfF3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU/RZIqkuBuNlUUl1AQKmZQQAuDLp/td2RGCQ11qyKw+1Q02a2BWt0cuT
CjFXiCz9D58W/1DvhMvq//xTfy2w1MISbMFnnp8fZr4vh8fUtNz7Wjcm6JVF4SWj
xPpRG7BWydhh87JXTREP2ERZEHJwde3yqnQAr17FVOET4vml3QutEhg4IDGejulb
UnqlXA0bJaQ=
=8zT5
-----END PGP SIGNATURE-----

--p/86pQykzvg7BfF3--

