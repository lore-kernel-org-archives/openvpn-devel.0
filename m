References: <CAFHpkQEKrJqNB2ZmhAwKGebVb6SB75HpnWcrw_niSaALL_S4mA@...278...>
	<CAA1AbxJZL70qY=ivMvskeUapj0V_+z_LVnM2Zp2LxAJT4t62vA@...278...>
	<CAFHpkQEnATPgCyxsLW6bpC5Qr-Cdh=+4X4MRXxgUD+orKpq+EQ@...278...>
	<20161121174953.GM28918@...1296...>
	<CAFHpkQFZD+hYzq_FW075wQt5AopcyCP20BEDzLsTx5Vq6uko3Q@...278...>
	<d48609b7-43df-80d5-a57f-e96e85ad4389@...2080...>
	<CAFHpkQHxVWvHSFK2hS7CV8ytUnxUHi5ZfjSOiuLBfWdufzMrCQ@...278...>
	<9048486e-03d9-7aa1-74f8-892a9cc7c1ee@...515...>
	<CAFHpkQHtPm2gPfHYEngJoMymUxt8iOFA7L0z+p54oVSNEmEPFQ@...278...>
	<4ea0b775-5681-b908-f06d-9251d28e8c8a@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c41ad01c-d1a2-cf2c-4876-c22954ae90a9@...2080...>
Date: Mon, 19 Dec 2016 14:44:34 +0100
MIME-Version: 1.0
In-Reply-To: <4ea0b775-5681-b908-f06d-9251d28e8c8a@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="mjhc6tDqVVfWXPSWtmm0ulGDDMN6Oq68x"
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
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mjhc6tDqVVfWXPSWtmm0ulGDDMN6Oq68x
Content-Type: multipart/mixed; boundary="i8mLiHPSxhqEPpvBhfckCB1HuwUEDwXFM";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
	=?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <c41ad01c-d1a2-cf2c-4876-c22954ae90a9@...2080...>
Subject: Re: [Openvpn-devel] https://travis-ci.org/OpenVPN/openvpn/builds
References: <CAFHpkQEKrJqNB2ZmhAwKGebVb6SB75HpnWcrw_niSaALL_S4mA@...278...>
	<CAA1AbxJZL70qY=ivMvskeUapj0V_+z_LVnM2Zp2LxAJT4t62vA@...278...>
	<CAFHpkQEnATPgCyxsLW6bpC5Qr-Cdh=+4X4MRXxgUD+orKpq+EQ@...278...>
	<20161121174953.GM28918@...1296...>
	<CAFHpkQFZD+hYzq_FW075wQt5AopcyCP20BEDzLsTx5Vq6uko3Q@...278...>
	<d48609b7-43df-80d5-a57f-e96e85ad4389@...2080...>
	<CAFHpkQHxVWvHSFK2hS7CV8ytUnxUHi5ZfjSOiuLBfWdufzMrCQ@...278...>
	<9048486e-03d9-7aa1-74f8-892a9cc7c1ee@...515...>
	<CAFHpkQHtPm2gPfHYEngJoMymUxt8iOFA7L0z+p54oVSNEmEPFQ@...278...>
	<4ea0b775-5681-b908-f06d-9251d28e8c8a@...515...>
In-Reply-To: <4ea0b775-5681-b908-f06d-9251d28e8c8a@...515...>

--i8mLiHPSxhqEPpvBhfckCB1HuwUEDwXFM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 19/12/16 11:01, Samuli Sepp=C3=A4nen wrote:
[...snip...]
> Right now cmocka tests are skipped if
>=20
> a) cmocka Git submodule is not initialized
> b) CMake is not installed
>=20
> See commit 45f6e7991cf for details.
>=20
> Travis logs say this:
>=20
> $ git clone --depth=3D50 --branch=3Dmaster=20
> https://github.com/OpenVPN/openvpn.git OpenVPN/openvpn
> $ git submodule update --init --recursive
>=20
> Which means that cmocka Git submodule gets sucked in automatically. So=20
> that leaves us with the following options afaics:
>=20
> 1) Remove the cmocka directory after the fact (rather nasty)

In deed nasty.  Why not rather detect if it os OSX and skip the 'git
submodule' step?


> 2) Ensure that CMake is not installed on MacOS X (does mbedTLS require=20
> this?)

If mbedTLS is built from source, then I believe CMake is needed.


> 3) Allow the user to select if cmocka tests are run or not

Try to avoid adding more options ... rather try to have some reasonable
defaults which is auto-detected based on reasonable triggers (such as
distro/platform)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--i8mLiHPSxhqEPpvBhfckCB1HuwUEDwXFM--

--mjhc6tDqVVfWXPSWtmm0ulGDDMN6Oq68x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYV+RCAAoJEIbPlEyWcf3yCzMQALZz00JBZQAAUdI+c7xI9/90
yBRyUT6c/TxbZU8esrNWCGaUSZ/XUsFzJQMgRJGk+Q3L3v6rI7L8BT/JWNxxyBYZ
gPdzO46E+wA/qejjKJHBWbBfVxlx1iql3sSV6ba1fRej1N0iNDHcI9gNtvwcLZxe
l/0fiCeOr6uspbL/UKHhJ6F7e0RMTRTtujmVsIAHg0CKa8/awN2pWv9fbf8KA8jp
ygdnENPjZDNV+t8fFQinQvtv3TTSgC3x6Y/NY3f2MP7ssUKzVmGQAxv/zNzj8W8r
rpt6IhmYAFjskLDhcogsRS8ruqu9H+1nBp7V6CM35gCTiy/+7zmAHQyTdvbznHM8
FsAUOvZRdVsJdlifm9uDveulXqLsrXBgfCXfcitxHWzuWuxHEliRfyctqNV1epEc
opDopR9KGCcxCOblo5Db8PhxRCSn3dv5uk313u0PCvWNtsZjrVho6BbF0IOC7K2+
vw2xhC3Jtz3jebamwxcOXRByi0n+w7ME52pz/lIbKaboMKnO3ftxa/kwiaSXl9rF
Ajq/Vf8u1rKnk8MkeeKtkQqP2vBkgu6+CCynXh96w/sW5NNgifZd0dNK7omO2fmk
gHeTQ5eLVK8ivNmRegr3He3h5E4si1/FMNphyEH+AppKkEjXJgWCMvM3bQct5wPm
M2ZZPpvO8kAIWeYhkND9
=yBP0
-----END PGP SIGNATURE-----

--mjhc6tDqVVfWXPSWtmm0ulGDDMN6Oq68x--

