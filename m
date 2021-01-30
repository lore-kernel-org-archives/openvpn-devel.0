References: <1611778909-20630-1-git-send-email-gcox@...1057...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3830b5b0-b070-7f5d-2ba9-dc36ccbb5713@...2080...>
Date: Sat, 30 Jan 2021 01:02:16 +0100
MIME-Version: 1.0
In-Reply-To: <1611778909-20630-1-git-send-email-gcox@...1057...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qJgj4MITOOcZKWmuOzM4lzs0WrNjQQtfu"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Update openvpn_plugin_func_v2 to
 _v3 in sample-plugins/defer/simple.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Greg Cox <gcox@...1057...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qJgj4MITOOcZKWmuOzM4lzs0WrNjQQtfu
Content-Type: multipart/mixed; boundary="vrzCypC2jv29vU726UvTbu3K8ZeRGdXqp";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Greg Cox <gcox@...1057...>, openvpn-devel@lists.sourceforge.net
Message-ID: <3830b5b0-b070-7f5d-2ba9-dc36ccbb5713@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Update openvpn_plugin_func_v2 to _v3
 in sample-plugins/defer/simple.c
References: <1611778909-20630-1-git-send-email-gcox@...1057...>
In-Reply-To: <1611778909-20630-1-git-send-email-gcox@...1057...>

--vrzCypC2jv29vU726UvTbu3K8ZeRGdXqp
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 27/01/2021 21:21, Greg Cox wrote:
> This isn't strictly required, but it modernizes the functions used.
> This change makes _open the same parameter form as _func (for better
> parallelism in function writing) and includes a check for the correct
> struct version, as recommended by openvpn-plugin.h
> ---
>   sample/sample-plugins/defer/simple.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
>=20

Thanks a lot!  This makes a lot of sense and works as expected.

Acked-By: David Sommerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--vrzCypC2jv29vU726UvTbu3K8ZeRGdXqp--

--qJgj4MITOOcZKWmuOzM4lzs0WrNjQQtfu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmAUogkACgkQhs+UTJZx
/fJBfRAAqdb3NAf9E3lIuwciha2oT61caQZ56a7gpXPpf+vY/jUOVDYyRutd+vrj
AsEevduj282L948myliT0r7Jc3iIsN7zaa1Xc2jpHJmawSdLSlaggVhYQN2C69MU
Aq1+LWVduw2iodWln/YqJO9d2z0e+ZmJsr7LV4ot+R5XmDSLJiIObWBCZKphQW34
KZHTTX/a1DDkPL6oarwDrVkZoekowqHAeZc06NNpnI6PUWN8+fwaIWv79u8VmRqo
Hl9gQ5BblqQGchzMchugk+R4c66VROKz2oOVDVkNw5+M3pdOyRUIwZnNK2COFSR6
9cmRCrkfevvMDbWDifozZv+rTbaXXeTGt9CpFnheSA3JXbDw8Y8vli+zK+Tu4dw1
TbXqhN+LWvhXm0AG5QrWrCcOhou9sp9CT2aWRosxBW/Quziu8hCmXtMUd45ICwn4
PFSui+swoDRwiUa7DUtAAl0ggeWd8zam9Zds+ORd728xpMpEXTZ2iVmcvPUv5Kqv
Ma3qzIL/kthyO6rwRTZcHtU9XglWzlkHI8zbTYq4caVATxCO1EQXeJlyxOqvClpS
6by5tNfMNfmlXM47+qPhM2xDx2gHOfTBXUS6JziJrnJBjD6Yh38bCAu4CA8XdW1X
DKlgeipN8jPQlM9qB1ReycZLhm94GM69IE2QyIa4c6jHcndUFBc=
=dZZ9
-----END PGP SIGNATURE-----

--qJgj4MITOOcZKWmuOzM4lzs0WrNjQQtfu--

