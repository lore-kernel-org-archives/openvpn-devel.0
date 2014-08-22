Message-ID: <53F70EE2.4010506@...1114...>
Date: Fri, 22 Aug 2014 11:35:30 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1408568426-19601-1-git-send-email-steffan@...1856...>
In-Reply-To: <1408568426-19601-1-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="cTpl8xi477LDGij10N29p6KKRtVIWo99o"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Fix some unintialized variable
	warnings
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
--cTpl8xi477LDGij10N29p6KKRtVIWo99o
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 20/08/14 23:00, Steffan Karger wrote:
> Does not actually change behaviour, but fixes compiler warnings
> and properly initializing is good habit anyway.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  src/openvpn/plugin.c | 2 +-
>  src/openvpn/sig.c    | 2 +-
>  src/openvpn/socket.c | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
> index 0948f23..54c5b52 100644
> --- a/src/openvpn/plugin.c
> +++ b/src/openvpn/plugin.c
> @@ -291,7 +291,7 @@ plugin_init_item (struct plugin *p, const struct plug=
in_option *o)
>  static void
>  plugin_vlog (openvpn_plugin_log_flags_t flags, const char *name, const c=
har *format, va_list arglist)
>  {
> -  unsigned int msg_flags;
> +  unsigned int msg_flags =3D 0;
>=20=20
>    if (!format)
>      return;
> diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
> index 90e39a4..a3d29de 100644
> --- a/src/openvpn/sig.c
> +++ b/src/openvpn/sig.c
> @@ -126,7 +126,7 @@ print_signal (const struct signal_info *si, const cha=
r *title, int msglevel)
>      {
>        const char *type =3D (si->signal_text ? si->signal_text : "");
>        const char *t =3D (title ? title : "process");
> -      const char *hs;
> +      const char *hs =3D NULL;
>        switch (si->source)
>          {
>          case SIG_SOURCE_SOFT:
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 9e6bd10..c649d62 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -2354,12 +2354,12 @@ print_sockaddr_ex (const struct sockaddr *sa,
>  				   struct gc_arena *gc)
>  {
>    struct buffer out =3D alloc_buf_gc (128, gc);
> -  bool addr_is_defined;
> +  bool addr_is_defined =3D false;
>    char hostaddr[NI_MAXHOST] =3D "";
>    char servname[NI_MAXSERV] =3D "";
>    int status;
>=20=20
> -  socklen_t salen;
> +  socklen_t salen =3D 0;
>    switch(sa->sa_family)
>      {
>      case AF_INET:
>=20

ACK.  Safe and sane changes.

--=20
kind regards,

David Sommerseth


--cTpl8xi477LDGij10N29p6KKRtVIWo99o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlP3DuIACgkQDC186MBRfrpeDACfQaxbBHi/JkV1JPENaY1ep2Mk
mcQAoINfx6bRnDW8oQDV62MhnbIheWc/
=kxpv
-----END PGP SIGNATURE-----

--cTpl8xi477LDGij10N29p6KKRtVIWo99o--

