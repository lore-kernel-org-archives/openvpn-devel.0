References: <20200903114455.29341-1-themiron@...2010...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <0ec2c2a7-61d5-69c6-76a4-af83c283c64c@...2080...>
Date: Tue, 8 Sep 2020 15:22:44 +0200
MIME-Version: 1.0
In-Reply-To: <20200903114455.29341-1-themiron@...2010...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ghaaweZg8Ir3Wk8YusFcGUIetrJME261A"
Subject: Re: [Openvpn-devel] [PATCH] Fix --remote protocol can't be set
 without port argument
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ghaaweZg8Ir3Wk8YusFcGUIetrJME261A
Content-Type: multipart/mixed; boundary="Mm76vNmrTFZRf3PcPuoZWhLOtUhGjJdyt";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Vladislav Grishenko <themiron@...2010...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <0ec2c2a7-61d5-69c6-76a4-af83c283c64c@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Fix --remote protocol can't be set
 without port argument
References: <20200903114455.29341-1-themiron@...2010...>
In-Reply-To: <20200903114455.29341-1-themiron@...2010...>

--Mm76vNmrTFZRf3PcPuoZWhLOtUhGjJdyt
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 03/09/2020 13:44, Vladislav Grishenko wrote:
> According client-options.rst additional argumets ``port`` and ``proto``
> are both optional and it's allowed to have port absent and protocol set:
>     --remote args
>       Examples:
>          remote server.example.net tcp
>=20
> But when protocol is set without preceeding port argument, it is being
> misparsed as a port with subsequent error:
>     RESOLVE: Cannot resolve host address: server.example.net:tcp
>     (Servname not supported for ai_socktype)
>=20
> Since protocol names are predefined and don't match service names, fix
> this behavior by checking second argument for valid protocol first.
>=20
> Signed-off-by: Vladislav Grishenko <themiron@...2010...>
Uhm ... I'm leaning towards a NAK to this patch and would rather suggest
updating the man page to be correct.  This is a mistake from my side when
converting the man page to .rst files.  The example should be:

       remote server.example.net 1194 tcp

The OpenVPN 2.4 and prior releases has this line:

       --remote host [port] [proto]

But this syntax was not supported by rst2man, so it was replaced with "args"
and the examples coming below; which carried an error.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--Mm76vNmrTFZRf3PcPuoZWhLOtUhGjJdyt--

--ghaaweZg8Ir3Wk8YusFcGUIetrJME261A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfV4WkAAoJEIbPlEyWcf3yOkUQAKfxdVcidWSkQbpMaXZysgDu
5uRUfYRAgnev4KvJoyPYMboInYCmIlUvhzB+kPE6rM4rj2IRC8wutQcp+cBpKzbS
ISMLcSUTU5S/lE4EV+A+WxUsTSMhXaSAVhZ433hmsWKWaClqmCik+y09mXso4mGe
+pAOr6rWfLVBW+3ndz656D/ZKeQ+NXe5F00xSGQgjw59mojmggQ5cLp77tUtbmo+
NsOqyZCpFfy5ejOpYX0zsElDzhTA8pzTJfUDwnOTaLaYaLZ4AlNbuIOjTtAOdjqA
xfUrjRcbEkJFj3kjmcbbMKZGMukcEspimuANPiM8/S9YOvsSGVPxDct7eTe0iJzp
84Y7HPbTNJczCXcOVcCnW0A4JQEQW2+ID/Es1fzhj0g+6U64tboA6puiZg0R0G5T
IDYs3/o0O5ZR0cRQGmc4XWwDQu5IT1R+7FYBQgrh70eVZd9BNAQCkYl0mMbtjqV/
C94lExV52PBpqbwFoWsE7V8EuOPVBvvWyzGNaMHfBpBaLXXR/5xn+/OLKQOI1ND8
QYI3ivsy9Ht7c6z8rsd3RYboNSPS/yNroXSGFUKJOkNsYgF8k1TEoEn/KmrP2yHR
b7S2LS7/xTpmXJ9YMJzYlENf0XxnmigtaT+J1FUig//1OMkoFhJsUHzSpZNOf7vA
CL0UOtmk2LKbUqjgK+Su
=p2ke
-----END PGP SIGNATURE-----

--ghaaweZg8Ir3Wk8YusFcGUIetrJME261A--

