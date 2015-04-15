Message-ID: <552E1111.6010201@...68...>
Date: Wed, 15 Apr 2015 09:19:45 +0200
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1429036445-17223-1-git-send-email-yegorslists@...1030...>
In-Reply-To: <1429036445-17223-1-git-send-email-yegorslists@...1030...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="8dpdh6jcqCx38HR860HaCFrdfmOeX0ams"
Subject: Re: [Openvpn-devel] [PATCH] m4: enable silent build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8dpdh6jcqCx38HR860HaCFrdfmOeX0ams
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 14.04.2015 um 20:34 schrieb Yegor Yefremov:
> Signed-off-by: Yegor Yefremov <yegorslists@...1030...>
> ---
>  configure.ac | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/configure.ac b/configure.ac
> index 9132468..ca0d9c3 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -374,6 +374,9 @@ AC_DEFINE_UNQUOTED([IPROUTE_PATH], ["$IPROUTE"], [Pat=
h to iproute tool])
>  AC_DEFINE_UNQUOTED([ROUTE_PATH], ["$ROUTE"], [Path to route tool])
>  AC_DEFINE_UNQUOTED([SYSTEMD_ASK_PASSWORD_PATH], ["$SYSTEMD_ASK_PASSWORD"=
], [Path to systemd-ask-password tool])
>=20=20
> +# enable silent build
> +m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes]]))
> +
>  #
>  # Libtool
>  #
>=20

Thanks for the proposal.

NAK, on these grounds:

- the m4_ifdef() makes the Makefile behaviour dependent on automake
version used, hence inconsistent across developer distros.  This
potentially causes confusion.

- it changes policy through the [yes] argument to AM_SILENT_RULES().
This flips the switch for the default without good reason, and that
makes debugging harder - this is a policy decision, not mechanism.

If the oldest distro we need to support (James? Samuli?) offers
"silent-rules" through AM_INIT_AUTOMAKE, we should just add it there,
but we should not touch the default. Then still anyone can call "make
V=3D0" or ./configure --enable-silent-rules and hide the output details.

Or else you can always "make -s".

This patch changes all the command line output from Make to something like:

   CC openvpn.o
   CC route.o
   LD openvpn

thus hiding compiler options, linker and -I flags and thereabouts.



--8dpdh6jcqCx38HR860HaCFrdfmOeX0ams
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUuERUACgkQvmGDOQUufZVjcgCfUr07Qs735XolUPi+deBc+6kT
hAYAoMKcRxNAKshh5i51ECiXB+AK88Uj
=oPCc
-----END PGP SIGNATURE-----

--8dpdh6jcqCx38HR860HaCFrdfmOeX0ams--

