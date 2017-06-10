Date: Sat, 10 Jun 2017 20:00:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170610180046.GM97029@...1296...>
References: <87fuf7u455.fsf@...2274...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MtzsW+Yl6G+Nb1ry"
Content-Disposition: inline
In-Reply-To: <87fuf7u455.fsf@...2274...>
Subject: Re: [Openvpn-devel] Missing include for socket-flags TCP_NODELAY on
 OpenBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--MtzsW+Yl6G+Nb1ry
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 10, 2017 at 07:46:46PM +0200, Jeremie Courreges-Anglas wrote:
> --- a/src/openvpn/syshead.h
> +++ b/src/openvpn/syshead.h
> @@ -288,6 +288,10 @@
>  #include <netinet/ip.h>
>  #endif
>=20=20
> +#ifdef HAVE_NETINET_TCP_H
> +#include <netinet/tcp.h>
> +#endif
> +

*grumble* - our syshead.h has *five* such code blocks today...

$ grep -n netinet/tcp.h syshead.h

243:#include <netinet/tcp.h>
272:#include <netinet/tcp.h>
312:#include <netinet/tcp.h>
328:#include <netinet/tcp.h>
356:#include <netinet/tcp.h>

(Linux, Solaris, FreeBSD, NetBSD and Darwin/MacOS) - but not OpenBSD,
most recent additions

commit 37170767a221a4847416fc339083704ae1b4c001  (Darwin)
commit 3e86f688757529f8b33f9e6b49e31ba8d8564c5e  (FreeBSD)

... so basically all platforms but Windows have an identical code=20
block afterwards...  (and "but DragonFly", but I assume that if someone
would care about TCP_NODELAY there, we'd add another such chunk)...


Anyway: thanks for your patch, I'll add it later this weekend to
all relevant branches (2.3, 2.4, master) - and then send a refactoring
patch for master that joins all these into a common (unix) block...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MtzsW+Yl6G+Nb1ry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZPDPOAAoJEB2Cnv7KVigSMh8L/idB44vNvIhmBKdupOqThLWB
ByY57GTmN6o7aCWsIKV2KqTCxzep7Cx6P7jpHezFsaZs/i6UzGrJOtk3Tuv2OXx+
saj/gT8vrB1zgqhij/upsUNlNdIWS+nrDrDsLLybJJ93WxXMCTJ3R2SMbL4wzC6S
pnVl5wwVJWY46rycsH4N5FfmQQz301BVDeBU5FXu8cmljHHArpfqx1oibYR+WWYh
1JYhR7gpIlmR6fH0CGNQAdlzxv7UdRIis/b9vEBc2LVVvMO2wfgYgpRRzoBTJYai
x73tC2hdUWVBtQkEwy1dr8XYWBeehHVlPc0Gw23lQE88mC8glXxtT2f9wYGvt0XB
3/+qSa+O7YVC5G2cfe9BmGOqn4DxGWQyucWsx6kh1ZuKNRUclw7lsXNtTauQ6ktv
vLX+5Yj0z6ANZy0bPPb6ESDSFXElGJgBLRq8DkW8RkyAhlQvPipAtV+W+p9eyj6y
xZvVfkhtzbTh+LZJBtPRHEFV8YHvs5NdbCoV50NIFQ==
=q6IY
-----END PGP SIGNATURE-----

--MtzsW+Yl6G+Nb1ry--

