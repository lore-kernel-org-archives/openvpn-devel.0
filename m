References: <20181230112901.29241-1-a@...2181...>
 <20181230112901.29241-2-a@...2181...>
 <6d230449-e579-8e57-197a-a6a6e34d03d0@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d27201bb-d3a1-a9c8-a94f-774733124304@...2181...>
Date: Tue, 29 Jan 2019 14:27:52 +1000
MIME-Version: 1.0
In-Reply-To: <6d230449-e579-8e57-197a-a6a6e34d03d0@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EpUiRSdIPW4xjkblBb5R39o5yfzrZL9Tv"
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EpUiRSdIPW4xjkblBb5R39o5yfzrZL9Tv
Content-Type: multipart/mixed; boundary="aXEvOCDso1bmrU2VrtKVFMtHKjJ1StcOI";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <d27201bb-d3a1-a9c8-a94f-774733124304@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] transport: introduce tranport API
 plugin codebase
References: <20181230112901.29241-1-a@...2181...>
 <20181230112901.29241-2-a@...2181...>
 <6d230449-e579-8e57-197a-a6a6e34d03d0@...1227...>
In-Reply-To: <6d230449-e579-8e57-197a-a6a6e34d03d0@...1227...>

--aXEvOCDso1bmrU2VrtKVFMtHKjJ1StcOI
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Arne and thanks for the review!

On 23/01/2019 03:03, Arne Schwabe wrote:
>>=20=20
>> +/*
>> + * FUNCTION: openvpn_plugin_get_vtab_v1
>> + *
>=20
> It would be nice if we also use the docutils style to document the new
> functions in this file rather than is this different documentation style.

I agree - will fix this.

>=20
>> + * This is only used for TRANSPORT plugins presently.  It is called to
>> + * retrieve a vtable structure to be used for binding virtual sockets
>> + * which use the transport provided by the plugin. The selector is an
>> + * OPENVPN_VTAB constant. *size_out must be set to the size of the
>> + * structure returned.
>=20
> A reference to openvpn_transport_bind_vtab1 might be a good idea here.

ok, will have a look.

>=20
>> +/* On Windows, platform-native events to wait on are provided to OpenVP=
N core as
>=20
> I think for multi line comments we use the following style
>=20
> /*
>  * first line of text
>  * last line of text
>  */
>=20
> but not sure. Might want to double check that style.
>=20

as discussed on IRC it is acceptable to have multi-line comments
starting directly on the first line. So I'll keep them as they are.

> Rest of the file look fine but I also would like to see docstyle comments.
>> +#endif
>> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
>> index 197e62ba..41cd90aa 100644
>> --- a/src/openvpn/Makefile.am
>> +++ b/src/openvpn/Makefile.am
>> @@ -119,6 +119,7 @@ openvpn_SOURCES =3D \
>>  	status.c status.h \
>>  	syshead.h \
>>  	tls_crypt.c tls_crypt.h \
>> +	transport.c transport.h \
>>  	tun.c tun.h \
>>  	win32.h win32.c \
>>  	cryptoapi.h cryptoapi.c
>=20
>> +openvpn_transport_socket_t
>> +transport_bind(const struct plugin_list *plugins,
>> +               const char **transport_plugin_argv, sa_family_t ai_famil=
y,
>> +               struct addrinfo *bind_addresses)
>> +{
>> +    openvpn_plugin_handle_t handle;
>> +    openvpn_transport_args_t args;
>> +    openvpn_transport_socket_t indirect;
>> +    struct openvpn_transport_bind_vtab1 *vtab;
>> +    struct addrinfo *cur =3D NULL;
>> +    struct openvpn_sockaddr zero;
>> +
>> +    if (!transport_prepare(plugins, transport_plugin_argv, &vtab, &hand=
le,
>> +                           &args))
>> +    {
>> +        msg(M_FATAL, "INDIRECT: Socket bind failed: provider plugin not=
 found");
>> +    }
>> +
>> +    /* Partially replicates the functionality of socket_bind. No bind_i=
pv6_only
>> +     * or other such options, presently.
>> +     */
>> +    if (bind_addresses)
>> +    {
>> +        for (cur =3D bind_addresses; cur; cur =3D cur->ai_next)
>> +        {
>> +            if (cur->ai_family =3D=3D ai_family)
>> +            {
>> +                break;
>> +            }
>> +        }
>> +
>> +        if (!cur)
>> +        {
>> +            msg(M_FATAL, "INDIRECT: Socket bind failed: Addr to bind ha=
s no %s record",
>> +                addr_family_name(ai_family));
>> +        }
>> +    }
>> +
>> +    if (cur)
>> +    {
>> +        indirect =3D vtab->bind(handle, args, cur->ai_addr, cur->ai_add=
rlen);
>> +    }
>> +    else if (ai_family =3D=3D AF_UNSPEC)
>> +    {
>> +        msg(M_ERR, "INDIRECT: cannot bind with unspecified address fami=
ly");
>> +    }
>> +    else
>> +    {
>> +        memset(&zero, 0, sizeof(zero));
>> +        zero.addr.sa.sa_family =3D ai_family;
>> +        addr_zero_host(&zero);
>> +        indirect =3D vtab->bind(handle, args, &zero.addr.sa, af_addr_si=
ze(ai_family));
>> +    }
>> +
>> +    if (!indirect)
>> +    {
>> +        msg(M_ERR, "INDIRECT: Socket bind failed");
>> +    }
>> +
>> +    if (vtab->freeargs)
>> +    {
>> +        vtab->freeargs(args);
>> +    }
>> +
>> +    return indirect;
>> +}
>> +
>> +struct encapsulated_event_set
>> +{
>> +    struct openvpn_transport_event_set_handle handle;
>> +    struct event_set *real;
>> +};
>> +
>> +#if EVENT_READ =3D=3D OPENVPN_TRANSPORT_EVENT_READ \
>> +    && EVENT_WRITE =3D=3D OPENVPN_TRANSPORT_EVENT_WRITE
>> +#define TRANSPORT_EVENT_BITS_IDENTICAL 1
>> +#else
>> +#define TRANSPORT_EVENT_BITS_IDENTICAL 0
>> +#endif
>=20
> A small comment when this is identical like Win32 vs posix-y would be nic=
e.

ok!

>=20
>=20
>> +
>> +unsigned
>> +transport_pump(openvpn_transport_socket_t indirect,
>> +               struct event_set_return *esr, int *esrlen)
>> +{
>=20
>=20
> The name 'pump' is confusing, especially without comment. Why not
> transport_update_event? Something that tells what the function actually
> does.

I believe this is called such because it "injects" (hence pump) data
into the event buffer (esr). But I agree that a better name can be found.

'transport_update_event' might be ok.

Regards,



--=20
Antonio Quartulli


--aXEvOCDso1bmrU2VrtKVFMtHKjJ1StcOI--

--EpUiRSdIPW4xjkblBb5R39o5yfzrZL9Tv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlxP1kwACgkQ9FVsWUWD
Dm22Xg/+OzLRM/wtKvUhYiq82vb5ewFb+qtNYXxrmncPNTaEa+FqHmZIjFOh3EcR
UPgXb3kU9LUazLDbIN/5goHh0u9NIWmwHWBICvMtZUs1agLvY42Z/F8c+pbANgwr
V7o5B2fKMF50FhlFb+IT0XaYMb4z4wCPSjx3CR4+q15wwBS5dxATlxT6vuhS4Myg
y7xUwtSMd5biufu92x427FKiovrn63le0xydStJlNgawYPBr1J5DiObP2bfEvqwv
46hCJw5LWihD9lXhS8bi2iwHfIVQGlerTxUUcpyG8M1TKOxqiLMisnzojAQpwF3T
85MB+PJ6en/wBPB2u3nVkffMxCT37YnrTnnaBkihTzA+kp/NHfcaroOwNmMgTMv3
I0ZTV1EYPQSVQH+DUNPUaAXa76EtPk5Od2fko/hlrTTmuBejpwnBG/GhGSOGevB9
4AhBhv2fg8KTT2tJ9hvzqTKZzqHulQLo+oQMNxpnnUaan162iYckULT/kvWEwDPi
Xa4qH235drmjs6F+cWvJS1n8fWASbXtYt/5s/IPGEy39ds5qWZsY2eCUt621uW2m
iB24ZcwrXUb/prth2CUWGDw8GtlX7WWZ1BAUyS6KgMYx8P5LHj+27KHzNSYXaSDO
0dguDykNHKcdUOovaTqgYbnGCSn5dOM5U1IbbTLlzAxWs/6Ut2c=
=SttA
-----END PGP SIGNATURE-----

--EpUiRSdIPW4xjkblBb5R39o5yfzrZL9Tv--

