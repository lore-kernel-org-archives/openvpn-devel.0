References: <e9e561b5-d893-a61b-7424-aed7c757e3aa@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3d4d3db5-7abf-5fb4-8581-5077d1070b48@...2080...>
Date: Mon, 22 Jun 2020 20:14:53 +0200
MIME-Version: 1.0
In-Reply-To: <e9e561b5-d893-a61b-7424-aed7c757e3aa@...515...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="FlKG9pyR318hNGI7F4UehmKEJo59ZuhUA"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FlKG9pyR318hNGI7F4UehmKEJo59ZuhUA
Content-Type: multipart/mixed; boundary="nDgEOKINDR42hQrnObNJk2KjMsmyVQAgh";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Selva Nair <selva.nair@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <3d4d3db5-7abf-5fb4-8581-5077d1070b48@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Change the default cipher to
 AES-256-GCM for server configs
References: <e9e561b5-d893-a61b-7424-aed7c757e3aa@...515...>
In-Reply-To: <e9e561b5-d893-a61b-7424-aed7c757e3aa@...515...>

--nDgEOKINDR42hQrnObNJk2KjMsmyVQAgh
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

[resent for the ML inclusion]

On 22/06/2020 18:58, Selva Nair wrote:
> On Mon, Jun 22, 2020 at 7:31 AM David Sommerseth <davids@...515...> wrote:
[...snip...]
>> +ExecStart=3D@...2235...@/openvpn --status %t/openvpn-server/status-%i.log =
--status-version 2 --suppress-timestamps --cipher AES-256-GCM --ncp-ciphers=
 AES-256-GCM:AES-128-GCM:AES-256-CBC:AES-128-CBC:BF-CBC --config %i.conf
>=20
> This is why I keep my openvpn servers out of systemd's view -- it
> keeps deciding what's good for us. I want to run my configs as is.

The order of options are crucial here.  This only changes the _default_ if
these options are not set.  If they are set in the config file, the config
file will override.


--=20
kind regards,

David Sommerseth
OpenVPN Inc





--nDgEOKINDR42hQrnObNJk2KjMsmyVQAgh--

--FlKG9pyR318hNGI7F4UehmKEJo59ZuhUA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJe8PUdAAoJEIbPlEyWcf3yl3oP/jUEdhIBnypFS/u0mT33ZpMJ
28ojiLJbn5LvCrm5kDmQEFtnc8AVxF6HwpdbJSZ/2ELpTFdc5w2YCHdlBzM+pOxK
anwtY0fMRw+y5jSYp80vNcJc28sC8U4ywC07PvD14dr27709U2VqTX0w3bXQV4hT
UwS6GW6ZMRg7dvoR8VK9vvd63/GA8+se7IyMrel5x8kzdqdinMfeEOW4ol+iDpUz
1XR56l/OpTh3NadIKgstwzRv3BcYVQ6lJiDAAQnbBj3Ip1TSy75iej1j7bN6pyKk
Xxay6NQU+YAOQfXoe6LcdnXFcbcjYcFoyhVESXFCq1cDq3q9qCNDqW2YTlAq80lx
D8TGjQ0VPKPmxsVMrr78ezgHwH2md/JvbBzYejZaovWntBzzwUEEkSgWE24GaGLZ
QFwVoz/+uC9AZGA2E0xZzBeFHFnPG6Lqtw4PDyDZ/WHC4vN01918XlAvtCCKr3Nm
qXBr5pdq9Bzpbs5vYfHuDv5iVgfg2XHTAau5e+KjcPo/vZX0XImqiC3DnPJr6eWu
AXlCqEWHPP5XdfRYJLLCbMKS6HV050/pdAsfKFrgngf1PoqcB4jBNDr5a+R5EAPY
RhPDadFQRHsyRxA+ngx82VH02y2eyjrVkDtxB0cv93WwcOjQj6jsgCXMChk0ojTM
bIPjIuwk8f45se505VtO
=DXk+
-----END PGP SIGNATURE-----

--FlKG9pyR318hNGI7F4UehmKEJo59ZuhUA--

