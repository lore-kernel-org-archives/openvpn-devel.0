Reply-To: openvpn-devel@lists.sourceforge.net
From: David Sommerseth <openvpn@...2080...>
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
	<CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
	<ff190c51-3e5b-f7e9-f176-d86ea9dcaefd@...2080...>
Message-ID: <8aba466c-87e1-229f-13e8-5ad0c5ba7148@...2080...>
Date: Wed, 21 Jun 2017 14:40:08 +0200
MIME-Version: 1.0
In-Reply-To: <ff190c51-3e5b-f7e9-f176-d86ea9dcaefd@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="thTgXvAXDsemmq8hjV5cW1g3sqnjE63A7"
Subject: Re: [Openvpn-devel] ***UNCHECKED*** Re: OpenVPN 2.4.3 released
 (with security fixes)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>, =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--thTgXvAXDsemmq8hjV5cW1g3sqnjE63A7
Content-Type: multipart/mixed; boundary="RkhOaRLknHjj2NOItBDosCBlpUE6kl4J2";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: "Jonathan K. Bullard" <jkbullard@...277...>,
 =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <8aba466c-87e1-229f-13e8-5ad0c5ba7148@...2080...>
Subject: Re: ***UNCHECKED*** Re: [Openvpn-devel] OpenVPN 2.4.3 released (with
 security fixes)
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
 <CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
 <ff190c51-3e5b-f7e9-f176-d86ea9dcaefd@...2080...>
In-Reply-To: <ff190c51-3e5b-f7e9-f176-d86ea9dcaefd@...2080...>

--RkhOaRLknHjj2NOItBDosCBlpUE6kl4J2
Content-Type: multipart/mixed;
 boundary="------------6D2554B3D73711768701D504"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------6D2554B3D73711768701D504
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 21/06/17 14:30, David Sommerseth wrote:
> On 21/06/17 13:48, Jonathan K. Bullard wrote:
>> On Wed, Jun 21, 2017 at 6:47 AM, Samuli Sepp=C3=A4nen <samuli@...515...>=
 wrote:
>>> The OpenVPN community project team is proud to release OpenVPN 2.4.3. It
>>> can be downloaded from here:
>>>
>>> <http://openvpn.net/index.php/open-source/downloads.html>
>>
>> Hi. Thanks for this release.
>>
>> Verifying the PGP signature on 2.3.17.tar.gz works fine (so did 2.4.2
>> a few weeks ago), but trying to verify the signature on 2.4.3.tar.gz
>> fails with:
>>
>> $ gpg2 -v --verify /XXX/openvpn-2.4.3.tar.gz.asc
>>
>> gpg: armor header: Version: GnuPG v1
>> gpg: assuming signed data in '/XXX/openvpn-2.4.3.tar.gz'
>> gpg: Signature made Wed Jun 21 06:19:19 2017 EDT
>> gpg:                using RSA key D72AF3448CC2B034
>> gpg: using subkey D72AF3448CC2B034 instead of primary key 12F5F7B42F2B01=
E7
>> gpg: using pgp trust model
>> gpg: BAD signature from "OpenVPN - Security Mailing List
>> <security@...515...>" [unknown]
>> gpg: binary signature, digest algorithm SHA1, key algorithm rsa4096
>>
>> The SHA256 ofopenvpn-2.4.3.tar.gz is
>>      84a01aa3df0c12a3552ca3baaa39d700137b5bce4b6de683fe87fb79bfa5df0b
>>
>> The SHA256 of openvpn-2.4.3.tar.gz.asc is
>>      695afa06fcf94f9e8bd2ee63267332d14e52fe24dd58c470e42dafbea371e437
>>
>> The files were downloaded from
>> https://openvpn.net/index.php/open-source/downloads.html at about
>> 10:24 UCT today from the New York City area.
>>
>> For reference, here is the output from verifying 2.3.17:
>>
>> $ gpg2 -v --verify /Users/jonathanbullard/Desktop/openvpn-2.3.17.tar.gz.=
asc
>>
>> gpg: armor header: Version: GnuPG v1
>> gpg: assuming signed data in
>> '/Users/jonathanbullard/Desktop/openvpn-2.3.17.tar.gz'
>> gpg: Signature made Wed Jun 21 06:18:55 2017 EDT
>> gpg:                using RSA key D72AF3448CC2B034
>> gpg: using subkey D72AF3448CC2B034 instead of primary key 12F5F7B42F2B01=
E7
>> gpg: using pgp trust model
>> gpg: Good signature from "OpenVPN - Security Mailing List
>> <security@...515...>" [unknown]
>> gpg: WARNING: This key is not certified with a trusted signature!
>> gpg:          There is no indication that the signature belongs to the o=
wner.
>> Primary key fingerprint: F554 A368 7412 CFFE BDEF  E0A3 12F5 F7B4 2F2B 0=
1E7
>>      Subkey fingerprint: B596 06E2 D8C6 E10B 80BE  2B31 D72A F344 8CC2 B=
034
>> gpg: binary signature, digest algorithm SHA1, key algorithm rsa4096
>>
>> Any ideas or suggestions?
>=20
> I believe it is Cloudflare playing tricks on us again.
>=20
> Attached are the proper signature files and below a list of the SHA256 ch=
ecksums:
>=20
> d300029416b045666f2dc957bdde407ba97894428b5ad8433df789e793ccc1d3  openvpn=
-2.3.17.tar.xz
> b206065f4a1720c022fde710c0449b5b25e9dda8ca2911a82bacf21b9fcb4e29  openvpn=
-2.3.17.tar.xz.asc
> 7aa86167a5b8923e54e8795b814ed77288c793671f59fd830d9ab76d4b480571  openvpn=
-2.4.3.tar.xz
> 9f5f089f4a4b3e270ddb53cb0b689f4c0bad89d7e2ee08a1d4666e7ab869f210  openvpn=
-2.4.3.tar.xz.asc
>=20
> This is based on the files I've already pushed to the Fedora builder (koj=
i), which
> I downloaded soon after the swupdates.openvpn.net server was updated.
Lets try to attach the _proper_ signature file for v2.4.3.  I managed to
send the signature for the previous (v2.4.2) release in the previous mail.

--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc


--------------6D2554B3D73711768701D504
Content-Type: application/pgp-encrypted;
 name="openvpn-2.4.3.tar.xz.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="openvpn-2.4.3.tar.xz.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlRSWNC
QUFCQWdBR0JRSlpTUjd2QUFvSkVOY3E4MFNNd3JBMEQrSVFBS1pHSnh5RnA5YURiTWY5SExV
YmJMazUKVW9vZlRVUFZ0cXVVam4yeTJIQkNvTEQ3T3VDbHppelJITUYvWllrRzljbmZiTTRu
bmRSREQxc3M4MEh3UkdpSAp2TGxCTStYYjNBdkszL0tFcDJISFVkbnhSSk9ZNkdSTTllSmh4
MTRMLzE0S3VMTVMyaGF3QjFCMFU5OEZROXZOCmdQcGRZdXVnUjg3M0RjT0xITHdWS25qb1hy
bGdIWk4xL0hldHIvRVZ0TW5NcnFRZ0FZTCtPVWR1ZllWb1ptR08KVDJEc3dXRU4xMTUyS2hE
eXdUOUpUQ1Nxd0dXTFpYeGUxVVkrdmNQbE84eDFITkdnZHVqYndGMjdjSm9lNXd5UwpPaUI2
dDRJUFp5UEFwbjlpTldneWhFV1JmbTJlMUxHOWRhSlBqT0hZdGJYbXozdlVFcEF6RjAxcmNT
b2xHcE5HCnZVN0pUcHdRMVVYUDdkUWVwUWJpZEZzVFhHdUhJZWdRZ2JRSjJoTzF0dUJQeVF2
Y3hRMUNOQ0ZidlRWazc5U1EKMFZRTGVZVjZSd3l2NGZ6VzVqTk1DQzdHMnAveTE5emg5R0lW
azBxa1h5a1Fzd3c1WTZjR2hqTzFmbGNLL1dHRAoweU8wU3l3c1BHNENRWlRIczBCZ0lLK0pY
dFYzRDRDZHFSOUhaR3hvR2srY0I5d2VRV05EUWgyR3FrVE5YL1d2CmhZM3BJMDcyNm5KekJW
TXR2dWttZDFDZ0NWbGlWTWZ6RENGYTl5L0gyODY3ZzBNNHRlNCtrMUc2YnNzZlNBN2YKZXJj
bGxOSVlDWjJnV05UZ0VmQTNTRE5oTmxqM2VHSnNQR3FXbUpyOXAxc09GMWwyN3NJNVVvTTB4
bk5XUEJiNQoydDdwNkVQWENKbnMrN0pJcVdlNgo9ZTYzTgotLS0tLUVORCBQR1AgU0lHTkFU
VVJFLS0tLS0K

--------------6D2554B3D73711768701D504--

--RkhOaRLknHjj2NOItBDosCBlpUE6kl4J2--

--thTgXvAXDsemmq8hjV5cW1g3sqnjE63A7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZSmkoAAoJEIbPlEyWcf3y+mwP/23JbSbvEARROM9vA+TreW2K
d06CNhg28rZgkO3DneukdFIe/b/28weetu0FGlWxWGZhO7k5DKbiUkuJ228Uera3
pa12Ek1XFr9BT7w7RUF+BKtGDqPnC4tF6LOfAvGgPUXWASqD+Hk7L/7bB6HCRU9h
fFDqJLr2Ad1z7qGLKSqoimzYvsDyRNprd3d64UYH2woWzQTCeFpv9hunvoukD3vQ
YbYEcPWtyO3Ft1QcVxAAF8xE669GStoN/LXJCTA3W9PpTpzExhVzflnUgwpXcdYp
w1+1vuM+h9suJqiIDyUjZoHIEBswMAzWLIMGQ9587rO9Exx5V0rZvPP8Ilh6mzCn
3R3HFypjiBt3b82gHmIBQdyaob/p4Ra9hWKrmtarrcM3D1IjdgvgYXPXEcdCiRgI
X6CxwoNpkvi6iLixtJerfIwl5neAEhFo965ghdPbquSB/7wQDGHLKTfUAjVs5at0
hdXnsW4Ygrz3nktHrpVGG6eIS3gIAljO/CBqhRNl5Mk367AKVzlFmtgXCZ8jI7SO
0nd73nOTi23BIcaVN7iwlcxvTz5gnvw/d6sM4uaKm/6pV6x1R00oQfOu80lMriPP
ZbErPMlkbFFiFqupN9mn/IWifXNFRKyZx1Ny2Rl8qRBJ4SmRTbsqWVTS2E2/q7Yx
LhfMugUWVIsNkg1rS3kj
=d1/Q
-----END PGP SIGNATURE-----

--thTgXvAXDsemmq8hjV5cW1g3sqnjE63A7--

