Date: Sun, 29 Jun 2014 18:25:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140629162551.GK1118@...1296...>
References: <CAEsd45Q1Ow+pasP0FhtJEkV-WW-yFA4dfKzx6QEKgnJf+m5Dtg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qABWltju4eaUXBmg"
Content-Disposition: inline
In-Reply-To: <CAEsd45Q1Ow+pasP0FhtJEkV-WW-yFA4dfKzx6QEKgnJf+m5Dtg@...278...>
Subject: Re: [Openvpn-devel] Recently-disclosed LZO vulnerability and
	OpenVPN's use of LZO
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

--qABWltju4eaUXBmg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jun 29, 2014 at 12:09:01PM -0400, Jonathan K. Bullard wrote:
> Am I correct to assume that OpenVPN's use of LZO is restricted to much
> smaller block sizes? I assume the block sizes that OpenVPN uses LZO for a=
re
> limited to the maximum packet size, which would be on the order of 1500
> bytes or so (because of MTU size limits).

OpenVPN does not use "cross block" decompression state, so yes, only
a single packet at a time is decompressed.  For UDP, this is obviously
below 64kbyte.  For TCP, the OpenVPN socket code imposes a maximum
length which is based on MTU + overhead (if I understand the code=20
right, it's a bit complicated) and if the TCP stream claims to contain
an "OpenVPN packet" larger than that, the session is torn down.

> Or does OpenVPN ever use LZO on larger amounts of data? Is there any
> possibility of OpenVPN using LZO on 8MB?

I do not see any such possibility.

> * Also see the discussion on the LZ4 discussion board
> <https://code.google.com/p/lz4/issues/detail?id=3D52>; the vulnerability =
was
> actually discovered by Ludvig Strigeus
> <https://en.wikipedia.org/wiki/Ludvig_Strigeus> eighteen months ago.

"git master" contains a copy of lz4 in src/compat/, which I intend to
update to their fixed-version - not because I think we're vulnerable,
but because I want to avoid questions and user irritation ("they are still
shipping the vulnerable version!!").  So it might be a good thing to=20
release new bundles with lzo 2.07 anyway...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qABWltju4eaUXBmg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU7A+DqkuBuNlUUl1AQKO0wP/Wm0S+Htd7oR2rnZNepKzkEBJlM2W1hME
1azSlcRjqWqwpWjwiQc58dq6cM48BiziskadMyoWrfrUUG28rP51wydrmSCJVM4C
AOqP4YAUHS9IDOokrjx9Vx+ow307ZbfUEiWwXOxjLHCzXV/+SI4TF8Co8fqCiMv3
GF/YT9DLPWI=
=vvjD
-----END PGP SIGNATURE-----

--qABWltju4eaUXBmg--

