Date: Sun, 17 Nov 2013 15:32:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131117143204.GB161@...1296...>
References: <1384698620-27946-1-git-send-email-gert@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OfhnfQefHcom74K3"
Content-Disposition: inline
In-Reply-To: <1384698620-27946-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Make code and documentation for
	--remote-random-hostname consistent.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: openvpn-users@lists.sourceforge.net

--OfhnfQefHcom74K3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

this is actually not only asking for an ACK, but also for users that
rely on the *old* behaviour ("foo.bar.gov" -> "foo-0x12345.bar.gov")
and would be surprised.

gert

On Sun, Nov 17, 2013 at 03:30:20PM +0100, Gert Doering wrote:
> Documentation examples, description and code were disagreeing on what
> this option actually does.  Now they will all agree that it will
> *prepend* a random-byte string to the hostname name before resolving
> to work around DNS caching (needs a "*" wildcard record in the zone).
>=20
> Fix trac #143
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  doc/openvpn.8      |  2 +-
>  src/openvpn/misc.c | 27 +++++++++------------------
>  2 files changed, 10 insertions(+), 19 deletions(-)
>=20
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index b53d383..3e2e1a4 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -271,7 +271,7 @@ failover capability.
>  .\"*********************************************************
>  .TP
>  .B \-\-remote-random-hostname
> -Add a random string (6 characters) to first DNS label of hostname to pre=
vent
> +Prepend a random string (6 bytes, 12 hex characters) to hostname to prev=
ent
>  DNS caching.  For example, "foo.bar.gov" would be modified to
>  "<random-chars>.foo.bar.gov".
>  .\"*********************************************************
> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
> index 4688444..7483184 100644
> --- a/src/openvpn/misc.c
> +++ b/src/openvpn/misc.c
> @@ -926,32 +926,23 @@ create_temp_file (const char *directory, const char=
 *prefix, struct gc_arena *gc
>  }
>=20=20
>  /*
> - * Add a random string to first DNS label of hostname to prevent DNS cac=
hing.
> + * Prepend a random string to hostname to prevent DNS caching.
>   * For example, foo.bar.gov would be modified to <random-chars>.foo.bar.=
gov.
> - * Of course, this requires explicit support in the DNS server.
> + * Of course, this requires explicit support in the DNS server (wildcard=
).
>   */
>  const char *
>  hostname_randomize(const char *hostname, struct gc_arena *gc)
>  {
>  # define n_rnd_bytes 6
>=20=20
> -  char *hst =3D string_alloc(hostname, gc);
> -  char *dot =3D strchr(hst, '.');
> +  uint8_t rnd_bytes[n_rnd_bytes];
> +  const char *rnd_str;
> +  struct buffer hname =3D alloc_buf_gc (strlen(hostname)+sizeof(rnd_byte=
s)*2+4, gc);
>=20=20
> -  if (dot)
> -    {
> -      uint8_t rnd_bytes[n_rnd_bytes];
> -      const char *rnd_str;
> -      struct buffer hname =3D alloc_buf_gc (strlen(hostname)+sizeof(rnd_=
bytes)*2+4, gc);
> -
> -      *dot++ =3D '\0';
> -      prng_bytes (rnd_bytes, sizeof (rnd_bytes));
> -      rnd_str =3D format_hex_ex (rnd_bytes, sizeof (rnd_bytes), 40, 0, N=
ULL, gc);
> -      buf_printf(&hname, "%s-0x%s.%s", hst, rnd_str, dot);
> -      return BSTR(&hname);
> -    }
> -  else
> -    return hostname;
> +  prng_bytes (rnd_bytes, sizeof (rnd_bytes));
> +  rnd_str =3D format_hex_ex (rnd_bytes, sizeof (rnd_bytes), 40, 0, NULL,=
 gc);
> +  buf_printf(&hname, "%s.%s", rnd_str, hostname);
> +  return BSTR(&hname);
>  # undef n_rnd_bytes
>  }
>=20=20
> --=20
> 1.8.1.5
>=20

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--OfhnfQefHcom74K3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUojTZKkuBuNlUUl1AQLBGAP/bNLLZ2sObmOOKPHKtYGIWW4R5cubMV4J
kWhyjltQTqR1BpL+t4dqgo7CF9QnKX833UQ9s97ymoAmbWnazLgJ0unhntr583Nv
yWTPZb0ym6bfQiu7XrZsFJCYjyeIB8o9EPDpaqFN0OmyZrCDyUn8crprgpZCKCMP
r6SPHBFrYV4=
=rRVN
-----END PGP SIGNATURE-----

--OfhnfQefHcom74K3--

