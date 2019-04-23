References: <51d6f746-c379-3cba-d204-103d722f1fde@...515...>
 <20190420150941.GN31008@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <c054eb3a-027f-fc11-da9b-67a4ad18ecca@...515...>
Date: Tue, 23 Apr 2019 20:38:04 +0300
MIME-Version: 1.0
In-Reply-To: <20190420150941.GN31008@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EC93rqCe5b2GYNB7eY0ESUB2dKHHFjznS"
Subject: Re: [Openvpn-devel] New OpenVPN 2.4.7 installers with tap-windows6
 and other componets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EC93rqCe5b2GYNB7eY0ESUB2dKHHFjznS
Content-Type: multipart/mixed; boundary="7ViqCPzRmAVgUWSSNo5Huq4aRHRiryPg6";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <c054eb3a-027f-fc11-da9b-67a4ad18ecca@...515...>
Subject: Re: [Openvpn-devel] New OpenVPN 2.4.7 installers with tap-windows6
 and other componets
References: <51d6f746-c379-3cba-d204-103d722f1fde@...515...>
 <20190420150941.GN31008@...1296...>
In-Reply-To: <20190420150941.GN31008@...1296...>

--7ViqCPzRmAVgUWSSNo5Huq4aRHRiryPg6
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Il 20/04/19 18:09, Gert Doering ha scritto:
> Hi,
>=20
> On Sat, Apr 20, 2019 at 12:16:49PM +0300, Samuli Sepp=E4nen wrote:
>> Here are completely untested OpenVPN 2.4.7 installers which I wanted to
>> get out for testing a.s.a.p.:
>>
>> <https://build.openvpn.net/downloads/releases/openvpn-install-2.4.7-I604=
-Win7.exe>
>> <https://build.openvpn.net/downloads/releases/openvpn-install-2.4.7-I604=
-Win10.exe>
>>
>> As the name implies, there is a different version for Windows 7 (plus
>> 8/8.1/Server 2012r2) and for Windows 10 (all versions). This is
>> necessary due to code signatures in the tap-windows6 driver.
>=20
> Shouldn't it be possible to have a normal signed driver also attestation
> signed, so "one driver for win7+win10"?
>=20
> Or have we just never tested this?
>=20
> gert
>=20

Hi,

This is a good question. Attestation signing at Microsoft end has some
interesting properties:

- It removes any existing signatures from tap0901.cat and tap0901.sys
- It does _not_ remove existing signatures from tapinstall.exe

We could potentially attestation-sign tap-windows6 first, then
cross-sign it. The result _might_ work on everything except Windows
Server 2016/2019.

I intend to do final installer / tap-windows6 testing tomorrow (Windows
7 and 10 work already). I can give double signatures a go in
tap-windows6 as well. Due to historic reasons the Powershell scripts I
use already support appending signatures.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--7ViqCPzRmAVgUWSSNo5Huq4aRHRiryPg6--

--EC93rqCe5b2GYNB7eY0ESUB2dKHHFjznS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAly/TX0ACgkQKVhNn0CG
RXh3TwgAhWAZdzQIH8HLMRibkK5LI6KZPpSYpLVHtODJO04TGSABAhP6YJMF5zkN
YYo6W/5hAhVtgrUMjw87iwN3x/OB4SOoVo5+MnD4fgdunPZMucPnF5I//Cmo1Bzu
kBU4CuxczqNCPQBW+XRoM2whWx/yyqlmlIBsnrxPMIzVPjVEz21vtt/JDrWelduE
rPlsxSKD/lPJgcPOz7ZMumzrtMVyoGVNrLFCuXc2foxeOi0Amh6gPTiad7s+B86M
weoahekC3gEhJmwSb8+nvhVv7ZBlMy8bWXL2WFYFx5N08l1CSZDhONgMlIa7+USB
s48Tz5c8jgtaxBYX0+exGLr/IkqKEg==
=z55y
-----END PGP SIGNATURE-----

--EC93rqCe5b2GYNB7eY0ESUB2dKHHFjznS--

