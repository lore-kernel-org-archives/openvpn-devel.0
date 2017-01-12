References: <CAKuzo_hbGphKBoB3MEtA5mn6JLNanGshntvmJxisxVTDWAWKxA@...278...>
	<1482532854-13699-1-git-send-email-steffan@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <97aa6b6d-e7a9-e10b-021d-69d42d7c042f@...2080...>
Date: Thu, 12 Jan 2017 02:14:46 +0100
MIME-Version: 1.0
In-Reply-To: <1482532854-13699-1-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="6QHKwWi5uXB2boPqspU0AgdLwRHoF4SUK"
Subject: Re: [Openvpn-devel] [PATCH v2] More broadly enforce Allman style
 and braces-around-conditionals
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6QHKwWi5uXB2boPqspU0AgdLwRHoF4SUK
Content-Type: multipart/mixed; boundary="iFxFRbRTMiEkGF6lOKThRg17kQOoM2DjQ";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <97aa6b6d-e7a9-e10b-021d-69d42d7c042f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] More broadly enforce Allman style and
	braces-around-conditionals
References: <CAKuzo_hbGphKBoB3MEtA5mn6JLNanGshntvmJxisxVTDWAWKxA@...278...>
	<1482532854-13699-1-git-send-email-steffan@...1856...>
In-Reply-To: <1482532854-13699-1-git-send-email-steffan@...1856...>

--iFxFRbRTMiEkGF6lOKThRg17kQOoM2DjQ
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 23/12/16 23:40, Steffan Karger wrote:
> We want { and } aligned, which means also adding a newline between each
> for() and {, while() and {, etc.
>=20
> Also, we agreed to always use braces with conditionals.  The previous
> uncrustify config added these for if()s, now also add these for while()
> and for().
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
> This patch replaces the "Add nl_for_brace=3Dadd to uncrustify.conf" patch.
>=20
> v2: also add nl_do_brace=3Dadd and mod_full_brace_do=3Dadd
>=20
>  dev-tools/uncrustify.conf          |  8 +++++
>  src/compat/compat-daemon.c         |  3 +-
>  src/compat/compat-dirname.c        |  7 +++-
>  src/compat/compat-inet_ntop.c      |  3 +-
>  src/compat/compat-inet_pton.c      |  3 +-
>  src/compat/compat-versionhelpers.h | 36 ++++++++++++++-------
>  src/openvpn/argv.c                 | 10 ++++++
>  src/openvpn/base64.c               | 11 +++++--
>  src/openvpn/buffer.c               |  9 +++++-
>  src/openvpn/buffer.h               |  2 ++
>  src/openvpn/comp-lz4.c             |  3 +-
>  src/openvpn/compstub.c             |  3 +-
>  src/openvpn/console.c              |  6 ++--
>  src/openvpn/crypto.c               | 18 +++++++----
>  src/openvpn/crypto.h               |  3 +-
>  src/openvpn/crypto_mbedtls.h       |  3 +-
>  src/openvpn/crypto_openssl.c       |  6 ++--
>  src/openvpn/cryptoapi.c            |  9 ++++--
>  src/openvpn/dhcp.c                 | 11 +++++--
>  src/openvpn/error.c                |  3 +-
>  src/openvpn/error.h                |  3 +-
>  src/openvpn/event.c                |  4 +++
>  src/openvpn/fragment.c             |  9 +++++-
>  src/openvpn/gremlin.c              | 15 ++++++---
>  src/openvpn/httpdigest.c           |  3 +-
>  src/openvpn/init.c                 | 11 ++++++-
>  src/openvpn/interval.h             |  3 +-
>  src/openvpn/list.c                 |  6 ++--
>  src/openvpn/lzo.c                  |  3 +-
>  src/openvpn/manage.c               | 15 +++++++--
>  src/openvpn/mbuf.c                 |  3 +-
>  src/openvpn/memdbg.h               |  3 +-
>  src/openvpn/misc.c                 |  9 +++++-
>  src/openvpn/mroute.c               |  3 +-
>  src/openvpn/mss.c                  |  3 +-
>  src/openvpn/mtcp.c                 |  3 +-
>  src/openvpn/multi.c                | 14 ++++++--
>  src/openvpn/ntlm.c                 | 14 +++++---
>  src/openvpn/occ.c                  |  3 +-
>  src/openvpn/openvpn.c              |  6 ++--
>  src/openvpn/options.c              | 52 +++++++++++++++++++++++++++---
>  src/openvpn/otime.h                |  3 +-
>  src/openvpn/packet_id.c            |  3 +-
>  src/openvpn/perf.c                 |  5 ++-
>  src/openvpn/perf.h                 |  9 ++++--
>  src/openvpn/pkcs11.c               | 66 +++++++++++++++++++++++++-------=
------
>  src/openvpn/plugin.c               | 11 ++++++-
>  src/openvpn/pool.c                 |  2 ++
>  src/openvpn/proxy.c                | 10 ++++--
>  src/openvpn/reliable.c             |  7 +++-
>  src/openvpn/route.c                | 13 +++++++-
>  src/openvpn/route.h                |  3 +-
>  src/openvpn/schedule.c             |  4 +++
>  src/openvpn/session_id.c           |  3 +-
>  src/openvpn/shaper.c               |  3 +-
>  src/openvpn/socket.c               | 12 +++++--
>  src/openvpn/socket.h               | 24 +++++++++-----
>  src/openvpn/ssl.c                  | 26 +++++++++++----
>  src/openvpn/ssl_mbedtls.c          |  8 +++--
>  src/openvpn/ssl_openssl.c          |  3 +-
>  src/openvpn/ssl_verify.c           |  6 ++++
>  src/openvpn/ssl_verify_mbedtls.c   |  2 ++
>  src/openvpn/ssl_verify_openssl.c   |  3 +-
>  src/openvpn/tls_crypt.c            |  6 ++--
>  src/openvpn/tun.c                  | 26 +++++++++++----
>  src/openvpn/win32.c                |  8 +++--
>  src/openvpnserv/automatic.c        |  3 +-
>  src/openvpnserv/interactive.c      |  5 ++-
>  src/plugins/auth-pam/utils.c       |  5 ++-
>  src/plugins/down-root/down-root.c  |  2 ++
>  70 files changed, 479 insertions(+), 144 deletions(-)
>=20

So I tried to apply this one, but there are some odd issues now.  Did
you apply your changes against the proper branch locally?  Because a
couple of these ones are really odd.

> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -558,7 +559,8 @@ cipher_kt_iv_size(const EVP_CIPHER *cipher_kt)
>  }
>=20=20
>  int
> -cipher_kt_block_size(const EVP_CIPHER *cipher) {
> +cipher_kt_block_size(const EVP_CIPHER *cipher)
> +{
>      /*
>       * OpenSSL reports OFB/CFB/GCM cipher block sizes as '1 byte'.  To w=
ork
>       * around that, try to replace the mode with 'CBC' and return the bl=
ock size

For some odd reason, this hunk does not apply ... not even with
'patch -p1'.


> --- a/src/openvpn/memdbg.h
> +++ b/src/openvpn/memdbg.h
> @@ -90,7 +90,8 @@
>  #include "dmalloc.h"
>=20=20
>  static inline void *
> -openvpn_dmalloc(const char *file, int line, size_t size) {
> +openvpn_dmalloc(const char *file, int line, size_t size)
> +{
>      void *ret =3D dmalloc_malloc(file, line, size, DMALLOC_FUNC_MALLOC, =
0, 0);
>      check_malloc_return(ret);
>      return ret;

This function does not exit, only as a #defined macro


> --- a/src/openvpn/ntlm.c
> +++ b/src/openvpn/ntlm.c
> @@ -192,7 +196,8 @@ utf8_to_utf16LE(uint8_t *dst, int dst_len, const char=
 *src)
>          }
>=20=20
>          /* The cases all fall through. */
> -        switch (extraBytes) {
> +        switch (extraBytes)
> +        {
>              case 5: ch +=3D *usrc++; ch <<=3D 6;
>=20=20
>              case 4: ch +=3D *usrc++; ch <<=3D 6;

There is no utf8 functions in ntlm.c ...

My master branch where I try to apply these changes to are based on
commit db5b9b45508ea8f66ea8, which I believe should be the latest one.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--iFxFRbRTMiEkGF6lOKThRg17kQOoM2DjQ--

--6QHKwWi5uXB2boPqspU0AgdLwRHoF4SUK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYdtiLAAoJEIbPlEyWcf3y3cEP/RaX4H1lhcJ1GUPn+xqdX1PE
UTCuBFPFItw5sjNoDvf3RuirDhjkco5aVjNAr5+3YoKJZybdo99h7cw6+bloidK3
UjDLY4BbxoFlQC3ksMLwpRkEdC7qiQPD/LvjrYs4oL6dI4VPZBX5KtXktnCacW/l
tBFqf7hoFAOcNwDWfal1ZLlzebKMeg7Gy5ME9Mrn4Cyf8O1PyxH3TOvHFDmcz/U+
Qq9/YS8eeBLW4b4ZofNQ9eRD5GprOoprY6MSvgZzkqLXQZBmRDxwCRJjOW2Nn26B
mwrUlwKF8hcA+HXA3KcEVnIhn9PcwIzG2Ur8yp5cCqO7aHHHL0lYxQiNzHYd1rc3
yfhP367T9pHw1ZWzZm8wTyJthemMbyh1numFiTL5BgA5d6VQ4ft/LttXNYa1DAWV
5QSaGPO0B5UTKGHXp7djHYrGmVspxSuv7KQ1LCjb0JYzFcTOqx8xLUhYh0aarqF7
vxXQI0x2FWlAzFHtxHc6rUjJetNd/hlpEYR+EHiGZO3dEmeVQAkdtPVb2IlClnOj
8k1L8cERuMSNJ3jrKi2rfKWwkMzpqtDf8EyoOicM0pk040QcALxROO0Zspw3N3Lx
xGe/WStZ0EKVHPc3ypZ/qAla0VTnivByalActZeEZ59fgtzkE7+Z4Kc5LaEIgHbZ
35hF0zQjjBnBSJGscoln
=xDP8
-----END PGP SIGNATURE-----

--6QHKwWi5uXB2boPqspU0AgdLwRHoF4SUK--

