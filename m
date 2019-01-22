References: <20181230112901.29241-1-a@...2181...>
 <20181230112901.29241-2-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <6d230449-e579-8e57-197a-a6a6e34d03d0@...1227...>
Date: Tue, 22 Jan 2019 18:03:22 +0100
MIME-Version: 1.0
In-Reply-To: <20181230112901.29241-2-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Z0RFzgTMrSuKenbv7ANRRfUL0ziTlgW1b"
Subject: Re: [Openvpn-devel] [PATCH 1/4] transport: introduce tranport API
 plugin codebase
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Cc: antonio@...515..., Robin Tarsiger <rtt@...2484...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z0RFzgTMrSuKenbv7ANRRfUL0ziTlgW1b
Content-Type: multipart/mixed; boundary="29DZJjQcv5SO7fHl7aGuUCvNU8QQ2oXx5";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Cc: antonio@...515..., Robin Tarsiger <rtt@...2484...>
Message-ID: <6d230449-e579-8e57-197a-a6a6e34d03d0@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] transport: introduce tranport API
 plugin codebase
References: <20181230112901.29241-1-a@...2181...>
 <20181230112901.29241-2-a@...2181...>
In-Reply-To: <20181230112901.29241-2-a@...2181...>

--29DZJjQcv5SO7fHl7aGuUCvNU8QQ2oXx5
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

>=20=20
> +/*
> + * FUNCTION: openvpn_plugin_get_vtab_v1
> + *

It would be nice if we also use the docutils style to document the new
functions in this file rather than is this different documentation style.

> + * This is only used for TRANSPORT plugins presently.  It is called to
> + * retrieve a vtable structure to be used for binding virtual sockets
> + * which use the transport provided by the plugin. The selector is an
> + * OPENVPN_VTAB constant. *size_out must be set to the size of the
> + * structure returned.

A reference to openvpn_transport_bind_vtab1 might be a good idea here.

> +/* On Windows, platform-native events to wait on are provided to OpenVPN=
 core as

I think for multi line comments we use the following style

/*
 * first line of text
 * last line of text
 */

but not sure. Might want to double check that style.

Rest of the file look fine but I also would like to see docstyle comments.
> +#endif
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index 197e62ba..41cd90aa 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -119,6 +119,7 @@ openvpn_SOURCES =3D \
>  	status.c status.h \
>  	syshead.h \
>  	tls_crypt.c tls_crypt.h \
> +	transport.c transport.h \
>  	tun.c tun.h \
>  	win32.h win32.c \
>  	cryptoapi.h cryptoapi.c

> +openvpn_transport_socket_t
> +transport_bind(const struct plugin_list *plugins,
> +               const char **transport_plugin_argv, sa_family_t ai_family,
> +               struct addrinfo *bind_addresses)
> +{
> +    openvpn_plugin_handle_t handle;
> +    openvpn_transport_args_t args;
> +    openvpn_transport_socket_t indirect;
> +    struct openvpn_transport_bind_vtab1 *vtab;
> +    struct addrinfo *cur =3D NULL;
> +    struct openvpn_sockaddr zero;
> +
> +    if (!transport_prepare(plugins, transport_plugin_argv, &vtab, &handl=
e,
> +                           &args))
> +    {
> +        msg(M_FATAL, "INDIRECT: Socket bind failed: provider plugin not =
found");
> +    }
> +
> +    /* Partially replicates the functionality of socket_bind. No bind_ip=
v6_only
> +     * or other such options, presently.
> +     */
> +    if (bind_addresses)
> +    {
> +        for (cur =3D bind_addresses; cur; cur =3D cur->ai_next)
> +        {
> +            if (cur->ai_family =3D=3D ai_family)
> +            {
> +                break;
> +            }
> +        }
> +
> +        if (!cur)
> +        {
> +            msg(M_FATAL, "INDIRECT: Socket bind failed: Addr to bind has=
 no %s record",
> +                addr_family_name(ai_family));
> +        }
> +    }
> +
> +    if (cur)
> +    {
> +        indirect =3D vtab->bind(handle, args, cur->ai_addr, cur->ai_addr=
len);
> +    }
> +    else if (ai_family =3D=3D AF_UNSPEC)
> +    {
> +        msg(M_ERR, "INDIRECT: cannot bind with unspecified address famil=
y");
> +    }
> +    else
> +    {
> +        memset(&zero, 0, sizeof(zero));
> +        zero.addr.sa.sa_family =3D ai_family;
> +        addr_zero_host(&zero);
> +        indirect =3D vtab->bind(handle, args, &zero.addr.sa, af_addr_siz=
e(ai_family));
> +    }
> +
> +    if (!indirect)
> +    {
> +        msg(M_ERR, "INDIRECT: Socket bind failed");
> +    }
> +
> +    if (vtab->freeargs)
> +    {
> +        vtab->freeargs(args);
> +    }
> +
> +    return indirect;
> +}
> +
> +struct encapsulated_event_set
> +{
> +    struct openvpn_transport_event_set_handle handle;
> +    struct event_set *real;
> +};
> +
> +#if EVENT_READ =3D=3D OPENVPN_TRANSPORT_EVENT_READ \
> +    && EVENT_WRITE =3D=3D OPENVPN_TRANSPORT_EVENT_WRITE
> +#define TRANSPORT_EVENT_BITS_IDENTICAL 1
> +#else
> +#define TRANSPORT_EVENT_BITS_IDENTICAL 0
> +#endif

A small comment when this is identical like Win32 vs posix-y would be nice.


> +
> +unsigned
> +transport_pump(openvpn_transport_socket_t indirect,
> +               struct event_set_return *esr, int *esrlen)
> +{


The name 'pump' is confusing, especially without comment. Why not
transport_update_event? Something that tells what the function actually
does.

Arne



--29DZJjQcv5SO7fHl7aGuUCvNU8QQ2oXx5--

--Z0RFzgTMrSuKenbv7ANRRfUL0ziTlgW1b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxHTNoACgkQFRhsZwKx
RFRKZRAApPQTfoAj7ynkV2qPCfr6Eg98/FcMu9wHJiZ/Xk/zCN/rExvhJpCZ0VC2
Q3UxJ6j/X054Zt/RKbZs05iTTjzbwvihIYuxuSpUUKTlsg2lTTMItpayr+issxhI
YEP+SoRlHpawt4vesp7N5/79ZCqltvs/+abClcrdE28DtOaDiUhvu4USf59B9YNR
1+0B03usjx7K/2Pv6bcGCeWY3+2lwsqbeMKDo005+jIEuCSAhGpPSDqE4O77jX8l
rSTx6XGlmxhZH9Jexhxux/xAarMQnjEaAN+T8jkNSVX7dTpsdBBqGxHsvcNvuRT5
0avVOwc0tZnNkZ30ROaWNNAzjhvZJBxggZZNn05wdeq1Xt4BcGQczawgeDx3zQbX
XTBuZG8E9a5D3OyMqaCxi+yA17L3Ru49DUSA7j1/Kqz8YwYa9PXJxtgIKHyGQlh/
37Z0keWxnGYnmbPS0Htc1TwrSJWnu50cBkmvxUL2eJP5I1t9sDIB5b3pKKgnJbFx
4NbxCCIbdI5z8a71sxz/vk1mjrO8MMbjuRMtRHcbgkVxhAEFpldTLAlmU4JyD/R7
GOALefsg/lVp2ZE+EleL/u7LJARALzrRSF6KlmltPLJD07WX/N4s5Qbf0qOCE0ps
fUDo5IIWPw/pFzs/Oyy6Q4wZAy1cWKksB9UYPq/gEiUm3Sago3g=
=nKnY
-----END PGP SIGNATURE-----

--Z0RFzgTMrSuKenbv7ANRRfUL0ziTlgW1b--

