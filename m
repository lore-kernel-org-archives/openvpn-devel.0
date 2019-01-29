References: <20181230112901.29241-1-a@...2181...>
 <20181230112901.29241-4-a@...2181...>
 <6480dfbb-11a4-f370-1b61-87a2331914ad@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e63eb370-2428-71cc-7179-7f5380aa7d46@...2181...>
Date: Tue, 29 Jan 2019 15:00:35 +1000
MIME-Version: 1.0
In-Reply-To: <6480dfbb-11a4-f370-1b61-87a2331914ad@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="N7eDrqH2eQGJxvK6Ypt8To66ZJVFWEiit"
Subject: Re: [Openvpn-devel] [PATCH 3/4] options: add support for
 --transport-plugin
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
--N7eDrqH2eQGJxvK6Ypt8To66ZJVFWEiit
Content-Type: multipart/mixed; boundary="PubRNkeYtvNgeQ7oh0ws29sw0ss7LUMQP";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <e63eb370-2428-71cc-7179-7f5380aa7d46@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 3/4] options: add support for
 --transport-plugin
References: <20181230112901.29241-1-a@...2181...>
 <20181230112901.29241-4-a@...2181...>
 <6480dfbb-11a4-f370-1b61-87a2331914ad@...1227...>
In-Reply-To: <6480dfbb-11a4-f370-1b61-87a2331914ad@...1227...>

--PubRNkeYtvNgeQ7oh0ws29sw0ss7LUMQP
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 23/01/2019 03:27, Arne Schwabe wrote:
> Am 30.12.18 um 12:29 schrieb Antonio Quartulli:
>> From: Robin Tarsiger <rtt@...2484...>
>>
>> Add a new config option to allow the user to specify a transport plugin
>> implementing the new API. This plugin can be used to manipulate traffic
>> in any way, as designed by the plugin developer.
>>
>> The fondamental advantage of this plugin is that the core codebase does
> typo fundamental.
>=20
>=20
>> +.B \-\-transport-plugin module-pathname [connection-args]
>                   \- missing here.

oh right! thanks!

>=20
>> +Use the loaded plugin module identified by
>> +.B module-pathname
>> +to provide a transport layer for the connection. The
>> +.B module-pathname
>> +must be exactly equivalent to a pathname supplied to a
>> +.B \-\-plugin
>> +option. The same transport plugin may be used for
>> +multiple connections, in which case the
>> +.B \-\-plugin
>> +option which loads it should only occur once. However,
>> +only one transport plugin may be specified per
>> +connection.
>=20
> Specify if this includes the .dll/.so suffix or not.

it is matched against the pathname of the --plugin option, therefore the
same form is expected (hence including the .so/.dll extension).

>=20
>=20
>> +If
>> +.B connection-args
> I think there is a \- missing here.

thanks!

>=20
>> +are present, these arguments are passed to the transport
>> +plugin when establishing this connection specifically; this
>> +is distinct from any per-plugin arguments which may have
>> +been specified using the
>> +.B \-\-plugin
>> +option. Documentation for possible
>> +.B connection-args
>> +may be provided along with the plugin in use.
>> +
>=20
>> +#ifdef ENABLE_PLUGIN
>> +    /*
>> +     * "proto indirect" may not be specified directly without a
>> +     * transport-plugin, and vice versa.
>> +     */
>> +    if (ce->proto =3D=3D PROTO_INDIRECT && !ce->transport_plugin_argv)
>> +    {
>> +        msg(M_USAGE, "--proto indirect may not be used without a transp=
ort-plugin line");
>> +    }
>> +
>> +    if (ce->transport_plugin_argv && ce->proto !=3D PROTO_INDIRECT)
>> +    {
>> +        msg(M_USAGE, "--transport-plugin must be used with --proto indi=
rect");
>> +    }
>> +#endif
>=20
> Why are not doing that implicitly when transport-plugin is specified.
> Any particular reason or just to get a more consistent way of specifying =
it?
>=20
>=20

It is done implicitly, but the user has a chance to override it because
he may specify indirect6 or indirect4 to limit the plugin to work on a
single address family only.

Therefore, by giving a chance to the user to override the value, we also
need to check that was set.


Cheers,

>=20
> Arne
>=20

--=20
Antonio Quartulli


--PubRNkeYtvNgeQ7oh0ws29sw0ss7LUMQP--

--N7eDrqH2eQGJxvK6Ypt8To66ZJVFWEiit
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlxP3fMACgkQ9FVsWUWD
Dm2ReA/6Avk8PorraVc7JJ3yecPGFBMqnc7NIrfQ3JbJgLX3FKghcmKdheEi1rtt
MEssA3HOwaYktuC/eLRs5D9UoLX13OzclfNC9dHUmPwXn2LPVHibvPZ+pLyseqWK
TjOnCNupfSi46T/Y7BqrIM4x1KTiw5haxEtU/M1azDETX2efP2J7zGhSGKfLLpDH
rPpMIR4cEyQqopQyUWT5nDZlHPa84nqEtgDziEsKroSxMxO85HTqG73XYA1W3w3c
cAfVtCaPCoXK6wYSIDGn5sMP8PXXGnsjO5IvQcuOImIVGeI+2JylSfz8GiRG7YIA
jYNA+ULPdwCk5uLyOaSKiRSqEv6LvGh4oDkNyGkfvlFKqADwNW33x+YlgZH0HDKV
KHcOz/S6cEYoHVo0mQsWnFcCvZxiMcZOLeTjPMKw7tlBhmaSbgVaCcwndClf1VjI
gdKURgUyUvLH6yuxPiDEYN5F+TgZB0oHq9bwra7VxgwZbSLy0Qg/Pxn5+29FH0aq
1IADcSAnxPpr6LDSyR3hhcturnDc2oRvQ0lZqBh5lPH/omQQ3gPAJJ+T7JkG4bUf
4p1oDlKivex29ZYqjhtqYkdSRl5mSyEx/bYFSiuN5/R6OjLyQHHkrJGrT7n2K+Pl
NiW/FRvi0VpvnWrHtncpHt8y3eaq/scVbklypHFfOezjmu1DMhk=
=zo5a
-----END PGP SIGNATURE-----

--N7eDrqH2eQGJxvK6Ypt8To66ZJVFWEiit--

