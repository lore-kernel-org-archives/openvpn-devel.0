References: <20181230112901.29241-1-a@...2181...>
 <20181230112901.29241-4-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <6480dfbb-11a4-f370-1b61-87a2331914ad@...1227...>
Date: Tue, 22 Jan 2019 18:27:51 +0100
MIME-Version: 1.0
In-Reply-To: <20181230112901.29241-4-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VvMJcA00ODR5otejUryq8s3yhoJ1Qi4Nk"
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Cc: antonio@...515..., Robin Tarsiger <rtt@...2484...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VvMJcA00ODR5otejUryq8s3yhoJ1Qi4Nk
Content-Type: multipart/mixed; boundary="7HtdVN2ag4dMngSfkLmsIfWvS4Kd7MQls";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Cc: antonio@...515..., Robin Tarsiger <rtt@...2484...>
Message-ID: <6480dfbb-11a4-f370-1b61-87a2331914ad@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 3/4] options: add support for
 --transport-plugin
References: <20181230112901.29241-1-a@...2181...>
 <20181230112901.29241-4-a@...2181...>
In-Reply-To: <20181230112901.29241-4-a@...2181...>

--7HtdVN2ag4dMngSfkLmsIfWvS4Kd7MQls
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 30.12.18 um 12:29 schrieb Antonio Quartulli:
> From: Robin Tarsiger <rtt@...2484...>
>=20
> Add a new config option to allow the user to specify a transport plugin
> implementing the new API. This plugin can be used to manipulate traffic
> in any way, as designed by the plugin developer.
>=20
> The fondamental advantage of this plugin is that the core codebase does
typo fundamental.


> +.B \-\-transport-plugin module-pathname [connection-args]
                  \- missing here.

> +Use the loaded plugin module identified by
> +.B module-pathname
> +to provide a transport layer for the connection. The
> +.B module-pathname
> +must be exactly equivalent to a pathname supplied to a
> +.B \-\-plugin
> +option. The same transport plugin may be used for
> +multiple connections, in which case the
> +.B \-\-plugin
> +option which loads it should only occur once. However,
> +only one transport plugin may be specified per
> +connection.

Specify if this includes the .dll/.so suffix or not.


> +If
> +.B connection-args
I think there is a \- missing here.

> +are present, these arguments are passed to the transport
> +plugin when establishing this connection specifically; this
> +is distinct from any per-plugin arguments which may have
> +been specified using the
> +.B \-\-plugin
> +option. Documentation for possible
> +.B connection-args
> +may be provided along with the plugin in use.
> +

> +#ifdef ENABLE_PLUGIN
> +    /*
> +     * "proto indirect" may not be specified directly without a
> +     * transport-plugin, and vice versa.
> +     */
> +    if (ce->proto =3D=3D PROTO_INDIRECT && !ce->transport_plugin_argv)
> +    {
> +        msg(M_USAGE, "--proto indirect may not be used without a transpo=
rt-plugin line");
> +    }
> +
> +    if (ce->transport_plugin_argv && ce->proto !=3D PROTO_INDIRECT)
> +    {
> +        msg(M_USAGE, "--transport-plugin must be used with --proto indir=
ect");
> +    }
> +#endif

Why are not doing that implicitly when transport-plugin is specified.
Any particular reason or just to get a more consistent way of specifying it?



Arne


--7HtdVN2ag4dMngSfkLmsIfWvS4Kd7MQls--

--VvMJcA00ODR5otejUryq8s3yhoJ1Qi4Nk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxHUpcACgkQFRhsZwKx
RFTKFxAAm8tvpkGKFF1jpjvarug0xzcRVs5HuIAA3vagndQPR7ArUVelhQ2JQUmy
ASu7jhRvwylM6nmLUnhr4HpcbrWEvtUDOjyDBcX+ii6prpVy9/KN/G1e1Z8bLNmJ
sR1d2UeAlblEBKnE9sUQiSzYUgJWEcjluOFCvVmjd+jK9s0e9Z4lCLtfv3rX0A3o
mb17tXzNo2DFW/q4r74+TXHy5A0qQsj/RBnHNsyGXsZWHSQcOjxRe8i3k8iWuVIn
3HJ3SgqbVWTXGZrV0kzxmJc20HVIpAjAVSobKxmljPC4hYb5MTfHrec6P9NDSgw5
Wko4gtU50Iqc6RfX05cbPGOi98Bvoe9Zi3dfS8ASiKpIBMICdP//+8QX7qEBY2nn
JnLaNbPqaP9IJ4mnxw7iaSqOzeQaNjuuPOGMMvg3o3dQCq6UQZxH6/JHEpAN60BS
x7br9ugrYUfh1y5S4+y5EGuJQ5Yd0hdp/JbgyvHb2i+F+7nhbI5Xudf3leVvXr6P
OvSwk3wKp+I3c76OymGl1zG5X7mOBrkBt9Fwcd1zvpOqYAu6F88D6vlV4vudMpBm
Ut/bllpmxICrOQyXBST7CdaXOYCMX36l8tEd/0RYqb4J1uukVTYayITJosuTZitC
AjqUUfI2eOcRTYY/16uo9nwD+OJ/IJloT0okfkYll4N5lKObUgc=
=86GO
-----END PGP SIGNATURE-----

--VvMJcA00ODR5otejUryq8s3yhoJ1Qi4Nk--

