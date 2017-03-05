Date: Sun, 5 Mar 2017 19:30:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170305183043.GN93896@...1296...>
References: <CAFHpkQHx1b4hDbeW2eOJDURHQoN6eCb40AZ5U4bhJOJdyPLnMg@...278...>
	<c441396b-e30e-c602-d6a0-aaafb82d8e7a@...1856...>
	<CAFHpkQHi_0LCYofSA1XDRmH2=Y-eJLWPo2j2gfdZvhOeGS=qEA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5aNh9si8bffKePh3"
Content-Disposition: inline
In-Reply-To: <CAFHpkQHi_0LCYofSA1XDRmH2=Y-eJLWPo2j2gfdZvhOeGS=qEA@...278...>
Subject: Re: [Openvpn-devel] could be gitlab-ci an alternative to buildbot
 cloud?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--5aNh9si8bffKePh3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Mar 05, 2017 at 02:42:49PM +0000, ???????? ?????????????? wrote:
> as for test agents, I assume those are dedicated servers, with no other
> applications. risk of root access
> is not high

Maintenance of throwaway systems (read: full re-image after every test
run) is too high for me to consider that.

I do not want to have my build slaves start contributing to the next
DDoS attack - thus, ours build only stuff that is committed to "master"
(or one of the branches if Samuli, David or I run a manual build - and
I somewhat trust those guys :-) ).

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--5aNh9si8bffKePh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYvFlSAAoJEB2Cnv7KVigS4c4L/ja8VMHVB+jnykk1abTpQhjc
AKE6NvYd64Cvi2tty1RlUgcpbK66MbRpGafA/RKL9VBoESHpydXfHEk4BXOOThGE
AIhEYDnM1yfmKfdqru4N8YYjCMSwjge5/GlU5Ukh3XhP3j1dsVVW5CQGFFPy+Jc6
TKfIuKgl2PPfcb2/nQzTcHW2mn1324NEOArOGkdNVyWYk1+3UDGTDBoOMvd5TqlR
aWIfhzUBiSW1uZxtkBoGJYtPkFJDatkXECKsLhJitJFlLVT4ic9coHXoOqpPhkdl
B11MVCsKVnFVrY6tHtEat0yIeWvDZkFwLaajy4/dsgP/xDeQQxAZLm9B5nmezE52
Iz16PnOPoF7J8LBk4KmsPOCQIS5LQv59mEWUvP6RQ1Qp3n26X7ztO9RKPr67aWig
Fsd7pzWU10q+k1JBRybrDvvMzUzwR3YUOCM0Fbut/QB5ihT2a4EFLama29dwar/c
BDcrxNsvUnJoRVPmJwc6PqGlgPT06IdeNJg0487T6A==
=OWgy
-----END PGP SIGNATURE-----

--5aNh9si8bffKePh3--

