Date: Sat, 8 Aug 2015 14:53:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150808125340.GA13114@...1296...>
References: <CAEsd45RvRfmqetu-EoFjSdyBk5F9X1K5muPGu-+_+30TMNOU_A@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <CAEsd45RvRfmqetu-EoFjSdyBk5F9X1K5muPGu-+_+30TMNOU_A@...278...>
Subject: Re: [Openvpn-devel] [Patch] Version 2: Fail if options have extra
	parameters
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

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

coming back to this, due to a bug introduced by this (Arne sent a patch),
me not finding the original patch in release/2.3 (so I can't apply the
fix), and I think there was a misunderstanding here :-)

On Tue, Jun 02, 2015 at 08:43:26AM -0400, Jonathan K. Bullard wrote:
> This is a new thread with version 2 of the patch; the first submission
> included the wrong .patch file and was withdrawn.
>=20
> The attached patch causes an error if an option has extra
> parameters; previously they were ignored (ticket #557 at
> https://community.openvpn.net/openvpn/ticket/557).
>=20
> This feature was discussed on the openvpn-devel mailing list (
> http://thread.gmane.org/gmane.network.openvpn.devel/9599).
>=20
> The patch is for the master branch only -- the consensus of the
> mailing list discussion was that the patch should not be included in
> the 2.3 branch.

I seem to remember that we said "no hard errors in 2.3", but *warnings*
for 2.3 would be certainly acceptable and welcome.

OTOH, looking at the current patch, it cannot reasonably easy turned into
something that prints warnings only (because if there are extra arguments,
the current patch will just ignore the option in question and all its
arguments) - so we'd need to instrument every single clause with an

   if (p[MAXFORTHIS])
     { msg(M_WARN, "WARNING: too many arguments for --xxx"); }

which would be quite a lot of extra code...


So, for the time being, I'll split Arne's patch from yesterday into=20
"the master" and "the 2.3" fix (one of two chunks :) )

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVcX71KkuBuNlUUl1AQKMGQP/aZV7yGjrg6Yuq0owLQ4OQeJJN6ULuMNK
haqMOsV80nolXWfyq/xIGrY+ZsXf3jUPteNvwLO04DpnvXeEafHv/J/Yxh3s2vc/
5rczIwk12R+z8C962jNWnm6XJrygtxYoWGhzhIZ2FYRB2A1TUMOUPw0gXJw2CJGb
9YZW2wMc2JU=
=vWrr
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

