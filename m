Date: Sun, 21 Mar 2021 17:50:45 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210321165045.GY976@...1296...>
References: <20210321144627.1621-1-simon@...2293...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="z0Sl2Dirnm4zWb82"
Content-Disposition: inline
In-Reply-To: <20210321144627.1621-1-simon@...2293...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] MSVC: Disable LZ4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

--z0Sl2Dirnm4zWb82
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 21, 2021 at 03:46:23PM +0100, Simon Rozman via Openvpn-devel wr=
ote:
> Commit 24596b25 ("build: Remove compat-lz4") removed lz4 compat layer,
> but openvpn-build\msvc doesn't provide LZ4 library either.

What would be needed to actually *build* with LZ4 on MSVC?  That is,
build it as prerequisite as LZO is built?

The idea wasn't to remove LZ4 from builds, just to remove the bundled
LZ4 "because all platforms have it now, so we do not need to maintain=20
our own copy".  But it seems that was a bit shortsighted wrt windows
building...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--z0Sl2Dirnm4zWb82
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgV3lkAAoJEB2Cnv7KVigS8QEL/RTGJXy8jViNMh4DzPc4t25X
f+H50u2iXtJctkejxDwThHncAaep6Y89mKOWz+552iq1HcRIiZ+mGs1MlmgyPLro
7vmpflP7zp+me6EKnhW3fUhwZpa9MVUh4i4Ql8bjvhxbTtAM9b7KUspC6Fl7Xkdh
VUDPLzLrm5EOOXnakP8yzXttI38fDmGKtDu6LTvqRlaWGD55FPRGQYDiCGlx6kG0
Yxgbk/wG7PjL10Npwfisv6cBrUUDOvXlbYOB6OXM3GJ1/t5jsGsRwH3nC7kqM+wo
ieyPsYVVx+VWqBUw5+qRmf2gtQNv5ohw0mAFYWfd8scjB21yvEvwWR9mb7TQd0ng
/OMEWHiBkDmioz4neav+E2OLNqhSnzAa0q9EvBnypConNUfPvq2mIRjqkSNv9fUO
ipfL1JoXN0Yxhkr2mrG97MChm6qrRDqu1iyIBiMRTdCesGFKNsSjCQZ3xflGiQWq
yc9HmfgfMEsnPsXU+RwpIikCeQPlP60hsyYY1KhG1A==
=zoIg
-----END PGP SIGNATURE-----

--z0Sl2Dirnm4zWb82--

