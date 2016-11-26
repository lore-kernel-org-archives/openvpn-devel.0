References: <CAFHpkQEKrJqNB2ZmhAwKGebVb6SB75HpnWcrw_niSaALL_S4mA@...278...>
	<CAA1AbxJZL70qY=ivMvskeUapj0V_+z_LVnM2Zp2LxAJT4t62vA@...278...>
	<CAFHpkQEnATPgCyxsLW6bpC5Qr-Cdh=+4X4MRXxgUD+orKpq+EQ@...278...>
	<20161121174953.GM28918@...1296...>
	<CAFHpkQFZD+hYzq_FW075wQt5AopcyCP20BEDzLsTx5Vq6uko3Q@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d48609b7-43df-80d5-a57f-e96e85ad4389@...2080...>
Date: Sun, 27 Nov 2016 00:29:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQFZD+hYzq_FW075wQt5AopcyCP20BEDzLsTx5Vq6uko3Q@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="uiKMa6RhahAFLnXnL32BDOntoHBrC99ik"
Subject: Re: [Openvpn-devel] https://travis-ci.org/OpenVPN/openvpn/builds
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uiKMa6RhahAFLnXnL32BDOntoHBrC99ik
Content-Type: multipart/mixed; boundary="A9l91GpkIXWDTaKu9raxhLdnRUgShMCMK";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Message-ID: <d48609b7-43df-80d5-a57f-e96e85ad4389@...2080...>
Subject: Re: [Openvpn-devel] https://travis-ci.org/OpenVPN/openvpn/builds
References: <CAFHpkQEKrJqNB2ZmhAwKGebVb6SB75HpnWcrw_niSaALL_S4mA@...278...>
	<CAA1AbxJZL70qY=ivMvskeUapj0V_+z_LVnM2Zp2LxAJT4t62vA@...278...>
	<CAFHpkQEnATPgCyxsLW6bpC5Qr-Cdh=+4X4MRXxgUD+orKpq+EQ@...278...>
	<20161121174953.GM28918@...1296...>
	<CAFHpkQFZD+hYzq_FW075wQt5AopcyCP20BEDzLsTx5Vq6uko3Q@...278...>
In-Reply-To: <CAFHpkQFZD+hYzq_FW075wQt5AopcyCP20BEDzLsTx5Vq6uko3Q@...278...>

--A9l91GpkIXWDTaKu9raxhLdnRUgShMCMK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 26/11/16 12:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
>=20
>=20
> 2016-11-21 22:49 GMT+05:00 Gert Doering <gert@...1296...
> <mailto:gert@...1296...>>:
>=20
>     Hi,
>=20
>     On Mon, Nov 21, 2016 at 10:31:45PM +0500, ???????? ?????????????? wro=
te:
>     > this line
>     >
>     > https://github.com/OpenVPN/openvpn/blob/master/tests/unit_tests/ope=
nvpn/Makefile.am#L17
>     <https://github.com/OpenVPN/openvpn/blob/master/tests/unit_tests/open=
vpn/Makefile.am#L17>
>     >
>     > causes an error
>=20
>     GNU LD manpage says this is a trick to make it link "another function"
>     "--wrap parse_line" would make it link __wrap_parse_line() instead -
>     most likely because @d12fk provided a stub function that mocks the
>     result (or whatever).
>=20
>     Have not looked into this in more detail.
>=20
>=20
> http://www.mockator.com/projects/mockator/wiki/Wrap_Functions
>=20
> "Alas, this feature is *only available with the GNU tool chain on
> Linux*. GCC for Mac OS X does not offer the linker flag |-wrap|. "
>=20
> should we skip those tests on osx ? or someone will rewrite them ?

I'd hold back a little bit.  I know Arne, Heiko and some people from
#cmocka on FreeNode had a discussion about this issue earlier this week.
 I don't know what they agreed on, but there was a discussion where they
looked at a few alternatives at least.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--A9l91GpkIXWDTaKu9raxhLdnRUgShMCMK--

--uiKMa6RhahAFLnXnL32BDOntoHBrC99ik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYOhrFAAoJEIbPlEyWcf3y3TcP/1SVFyk9Vp7O0YhkBzIGYHg+
fH71DPn4iobJDL+CuYdOiwwxqxGv4C8c/bEzRIK8hMDsVn35u+pK/G/rM7Cx/nI5
40IKNxojFYpSB21RGbuXl9QZ7RX+aW/TsxCipKNLNgj20rhdmw1rUhuDrhZog3n8
wlE6SBu4lS1wI5ZhgDSp5aLM1tvyqtOn1KCDyBtuRJYqX40fVttSHsfhgbZvqRZh
khsxs/iEF+GO4ZiXn22cPdVSb10i6t6OCZnKDfj7ozfCspJU11cuYfuHhtIZRo9f
aesuW1hlG1O1Oz/+owz4xY8WTTLm5AhaOKwJMs/RD7O1S1q4jTrRvdkFUWB81e0I
ezzKzNJOKGxu+GShjVXasncW4lmqKWuCFtZrV2AXv6d53H33/DpyA3L6bo/BmXez
dxp+zDAMsbGrBrpeJxBVrLVEYyF2FClENScBE+3lQN4lfDTxxFVMDyvLf/UVkrbN
fBcadI+DK/uxHZ/BoTfDj/MuhhOqnJbeHwdLD58tmmNEhs64sBBHBPcb4V4yyqrj
GbEuy3jsMvYhV+U7bk8RMSffQBlUDFHlUtP17O+Izsfg5MmSfG59NRtqbX6RyLrJ
O1dO6G9vpi5axGn3wmkYOpurmPKTYapCDO+maOQ1T3oicxyGQyZVm7s82VmTFfap
BH6F8MDRdSSKWTC5BUGn
=lvcn
-----END PGP SIGNATURE-----

--uiKMa6RhahAFLnXnL32BDOntoHBrC99ik--

