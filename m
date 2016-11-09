References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-7-git-send-email-heiko.hund@...1489...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <02594b96-a2ba-f9c7-2a3a-7992a61fc846@...2080...>
Date: Wed, 9 Nov 2016 23:58:21 +0100
MIME-Version: 1.0
In-Reply-To: <1477672963-5724-7-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="aXxj3PMWFlTvVE8Okj15k2keUwvdG1XTD"
Subject: Re: [Openvpn-devel] [PATCH 6/7] argv: do fewer memory re-allocations
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aXxj3PMWFlTvVE8Okj15k2keUwvdG1XTD
Content-Type: multipart/mixed; boundary="p30M87x748IAhD9BrHRWxR724akBFjHqe";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net
Message-ID: <02594b96-a2ba-f9c7-2a3a-7992a61fc846@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 6/7] argv: do fewer memory re-allocations
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-7-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1477672963-5724-7-git-send-email-heiko.hund@...1489...>

--p30M87x748IAhD9BrHRWxR724akBFjHqe
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28/10/16 18:42, Heiko Hund wrote:
> Prevent the re-allocations of memory when the internal argv grows
> beyond 2 and 4 arguments by initially allocating argv to hold up to
> 7 (+ trailing NULL) pointers.
>=20
> While at it rename argv_reset to argv_free to actually express
> what's going on. Redo the argv_reset functionality so that it can
> be used to actually reset the argv without re-allocation.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/argv.c                   | 45 ++++++++++++++++++++----------=
------
>  src/openvpn/argv.h                   |  2 +-
>  src/openvpn/console_systemd.c        |  2 +-
>  src/openvpn/init.c                   |  2 +-
>  src/openvpn/lladdr.c                 |  2 +-
>  src/openvpn/misc.c                   |  4 ++--
>  src/openvpn/multi.c                  | 10 ++++----
>  src/openvpn/options.c                |  2 +-
>  src/openvpn/plugin.c                 |  2 +-
>  src/openvpn/route.c                  |  8 +++----
>  src/openvpn/socket.c                 |  4 ++--
>  src/openvpn/ssl_verify.c             |  6 ++---
>  src/openvpn/tun.c                    | 23 ++++++++----------
>  tests/unit_tests/openvpn/test_argv.c | 41 +++++++++++++++++++++---------=
--
>  14 files changed, 85 insertions(+), 68 deletions(-)
>=20

Code looks fairly reasonable, but I have a few comments ...

>  argv_init (struct argv *a)
>  {
>    a->capacity =3D 0;
>    a->argc =3D 0;
>    a->argv =3D NULL;
> +  argv_extend (a, 8);

Why 8?  Done any performance and/or memory utilization tests?  Does the
overall memory consumption increase with this?

>  void
> -argv_reset (struct argv *a)
> +argv_free (struct argv *a)

This makes more sense :)

> @@ -126,10 +138,7 @@ argv_insert_head (const struct argv *a, const char *=
head)
>  const char *
>  argv_str (const struct argv *a, struct gc_arena *gc, const unsigned int =
flags)
>  {
> -  if (a->argv)
> -    return print_argv ((const char **)a->argv, gc, flags);
> -  else
> -    return "";
> +  return print_argv ((const char **)a->argv, gc, flags);

There are very few callers of print_argv() (defined in buffer.c).
Should we migrate print_argv() into this function and move all callers
over to argv_str() instead?

> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c

tun.c:2360 close_tun() seems to be missing a argv_free(), or?
The same goes for close_tun() in tun.c:2482 and tun.c:2956
(tun.c:2821 does have it though).

Similarly, in open_tun() [tun.c:2926], argv_new() is called but no
argv_free() calls.



On a not so related note.  I noticed that init.c have a
#ifdef ARGV_TEST block.  That should probably also be killed; no need
for that as we have unit tests - and the argv_test() function it calls
no longer exists.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--p30M87x748IAhD9BrHRWxR724akBFjHqe--

--aXxj3PMWFlTvVE8Okj15k2keUwvdG1XTD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYI6oNAAoJEIbPlEyWcf3ykcMQAL1OXyx6ylXf+5SBNlMXD+Ed
mnq8IBS41mmKmcEorhvdARcbCIUCU3YtscU5V5ojPF/AV6RhHxoMfZWM19RSNvML
3c0qRH39hNVTCcRG4LY4ffjtSdumW4MA1C3SrkHHIaiPLuBj1C2msRoNlivA99ko
lUolKCrTKfaKEDHndtJb4maesXZNetKhldUea6IawdGWeTJ4QbCUedhQhrKgdosd
3vMtD/2OAuGhmrvIyy4gx8B0+meUPW0vdI1v0eFhmBRSJuH30z//PtKiGPzXbRJC
g6x2u99ci5FfyIFuS6fZ3wXeCsd0y+T0Pz012lnzvLNLD/ef1BiB+5ibJCKXBXcC
1cLwvGzh6dghA+OIs+DjAN8ZxsqebjTm7Bqh4rACJyNDb3as3x9pPJTvzrXXxFr7
RUM+U/q3lncAcx+z+eiJZhPv36jAeMT/xC0Ayr9XjUqPAPFLn8FrIBjLDhKuAMib
NL4srFGeGQqK8DmBDoatpNqE/tQH7C3uo3m+F9UkZRbJGH/3b+R9nAd9fGJxVJGm
JPXKxtTXpentN7pl7HyjEdUI5WY4pHTkHKwbKrvng65JQEqKAKi0iejda2RFpRkj
XR4OK8J3SV63TM+TaeEECrzyLdiAhH+wq2XjZK0L2hekvEXexZtXBuyLFf956NEe
V0HexWHM3jZJuuct91Od
=dC3J
-----END PGP SIGNATURE-----

--aXxj3PMWFlTvVE8Okj15k2keUwvdG1XTD--

