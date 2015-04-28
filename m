Message-ID: <553F9217.7050000@...1114...>
Date: Tue, 28 Apr 2015 15:58:47 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1430219063-12291-1-git-send-email-gert@...1296...>
In-Reply-To: <1430219063-12291-1-git-send-email-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="XNCgdOq1A1RlsG8RhrJ4I6pQEfKknQn6N"
Subject: Re: [Openvpn-devel] [PATCH] Print helpful error message on
 --mktun/--rmtun if not available.
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XNCgdOq1A1RlsG8RhrJ4I6pQEfKknQn6N
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28/04/15 13:04, Gert Doering wrote:
> OpenVPN only supports --mktun/--rmtun to create/destroy persistant
> tunnels on Linux.  On BSD OSes, "ifconfig tun0 create" can do the
> same job, so we do not actually need to support it - but the previous
> error message ("unknown option") wasn't helpful.  So always accept
> the option now, and on non-supported systems, direct user to manpage.
>=20
> Trac #85
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/init.c    | 10 ++++++++--
>  src/openvpn/options.c |  2 --
>  2 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index b97d2da..42cb3e2 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -887,7 +887,6 @@ do_genkey (const struct options * options)
>  bool
>  do_persist_tuntap (const struct options *options)
>  {
> -#ifdef ENABLE_FEATURE_TUN_PERSIST
>    if (options->persist_config)
>      {
>        /* sanity check on options for --mktun or --rmtun */
> @@ -901,14 +900,21 @@ do_persist_tuntap (const struct options *options)
>  	)
>  	msg (M_FATAL|M_OPTERR,
>  	     "options --mktun or --rmtun should only be used together with --de=
v");
> +#ifdef ENABLE_FEATURE_TUN_PERSIST
>        tuncfg (options->dev, options->dev_type, options->dev_node,
>  	      options->persist_mode,
>  	      options->username, options->groupname, &options->tuntap_options);
>        if (options->persist_mode && options->lladdr)
>          set_lladdr(options->dev, options->lladdr, NULL);
>        return true;
> -    }
> +#else
> +      msg( M_FATAL|M_OPTERR,
> +	"options --mktun and --rmtun are not available on your operating "
> +	"system.  Please check 'man tun' (or 'tap'), whether your system "
> +        "supports using 'ifconfig %s create' / 'destroy' to create/remov=
e "
> +        "persistant tunnel interfaces.", options->dev );
>  #endif
> +    }
>    return false;
>  }
>=20=20
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index e8cf06a..4f27336 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -7023,7 +7023,6 @@ add_option (struct options *options,
>        options->pkcs11_id_management =3D true;
>      }
>  #endif
> -#ifdef ENABLE_FEATURE_TUN_PERSIST
>    else if (streq (p[0], "rmtun"))
>      {
>        VERIFY_PERMISSION (OPT_P_GENERAL);
> @@ -7036,7 +7035,6 @@ add_option (struct options *options,
>        options->persist_config =3D true;
>        options->persist_mode =3D 1;
>      }
> -#endif
>    else if (streq (p[0], "peer-id"))
>      {
>        VERIFY_PERMISSION (OPT_P_PEER_ID);
>=20

(Lets try again, this time to the mailing list)

ACK.

--=20
kind regards,

David Sommerseth


--XNCgdOq1A1RlsG8RhrJ4I6pQEfKknQn6N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlU/khcACgkQDC186MBRfrpJZgCfcFPm4TvcbNl0lEgDy3Zrsf8A
mJ4An01pdRYuzR6NpvknK/lwV1jSwLcY
=abSN
-----END PGP SIGNATURE-----

--XNCgdOq1A1RlsG8RhrJ4I6pQEfKknQn6N--

