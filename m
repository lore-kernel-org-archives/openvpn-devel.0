References: <6a1b6995-67c1-e30b-bdc1-af1d5485fda5@...515...>
 <d34d5974-30ac-6949-9be4-7f4a55126564@...515...>
 <bf866bdc-4be0-fea9-92d1-61d27ce7ecda@...277...>
 <df929876-8c63-0934-02f6-4ac7186d986e@...515...>
 <e4b61969-aac3-a5cd-6642-b65e3a9f0256@...277...>
 <7d23f054-2ab4-d6f2-77b0-5cb76c2ec2df@...515...>
 <AD1D828E-B77F-4D08-BB7E-722AE9545CA1@...2293...>
 <6b2de5c1-99b7-406f-04d5-bb9449d120b9@...277...>
 <1b342791-a3ba-9932-dc02-a616f86c3e17@...515...>
 <CAC6SzHLVL4d-PVA6NBSHL4xyoo=4pVPrrAHZqKWTFkjxa3UEug@...278...>
 <8i52hb.q0k274.rtj366-qmf@...2533...>
 <CAC6SzH+tWMmEC-n0s+p6ooukjBeqOifrD5uWF0B2gz7qe187Zw@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <f4c7d7fc-f757-9f13-56fc-93a3145da4c4@...515...>
Date: Sat, 9 Nov 2019 19:53:11 +0200
MIME-Version: 1.0
In-Reply-To: <CAC6SzH+tWMmEC-n0s+p6ooukjBeqOifrD5uWF0B2gz7qe187Zw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="N3F6KvG5nb5JJBKwoh3q9vE2Uv93VJ5IR"
Subject: Re: [Openvpn-devel] OpenVPN 2.4.8 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d tbsky <tbskyd@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N3F6KvG5nb5JJBKwoh3q9vE2Uv93VJ5IR
Content-Type: multipart/mixed; boundary="WO7TDNt96ixnxWsGhn43r3S2vHuqzMoC9"

--WO7TDNt96ixnxWsGhn43r3S2vHuqzMoC9
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Il 07/11/19 05:46, d tbsky ha scritto:
> <samuli@...515...>
>> It would be interesting too what error message there is in setupapi.dev.=
log:
>>
>=20
> I found a win7 vm with openvpn 2.4.6. try to upgrade to 2.4.8 and get
> the same result.
> setupapi.dev.log attached. there are some international characters but
> I think they are not important.
> I snapshot the vm before upgrade. so I can repeat the procedure if necess=
ary.
>=20
> Regards,
> tbskyd
>=20

Hi,

The error is pretty clear:

Error 0x800b0109: A certificate chain processed, but terminated in a
root certificate which is not trusted by the trust provider.

Is your computer perhaps behind in Windows updates? My hunch is that
Digicert's latest root certificate is not availabe in the Windows
certificate store and this causes the failure.

Samuli


--WO7TDNt96ixnxWsGhn43r3S2vHuqzMoC9--

--N3F6KvG5nb5JJBKwoh3q9vE2Uv93VJ5IR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAl3G/QcACgkQKVhNn0CG
RXgDtQgAny8KZdfWCoiCUpcVPX0B/nLtsjvAphtd0zBQIkrfW4qHflEk42mhW3eE
wOEF3OHn9X+NEH0yzdB4SohUk8QzyPdQnyS73pFUzMyiisGOfYwG/c4ZdMS6agLh
37gzsF3WLEzGEM0ruuKefA4HFJhdX+ZEn5TzYCLjEsuDtNbaRLEr5x5sE7r97wgM
lItQWeE1FioLDDv20L0n9KYjKk8oAPmS8p/ZVbTjKX0WwdK0dIkQnNOTUKz2Rvr3
J6lszpMIYGeFOTZqft+J6COkI1MwiwWguA4XINv1gfW6EQCfbbpwrciOtZN9B/3a
0uz1kEkShoyttmzSn/4zEECReme4Xw==
=Acu4
-----END PGP SIGNATURE-----

--N3F6KvG5nb5JJBKwoh3q9vE2Uv93VJ5IR--

