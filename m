Reply-To: openvpn-devel@lists.sourceforge.net
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
	<CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ff190c51-3e5b-f7e9-f176-d86ea9dcaefd@...2080...>
Date: Wed, 21 Jun 2017 14:30:56 +0200
MIME-Version: 1.0
In-Reply-To: <CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PvbNWPi7XgVQCARuv9JDNi4SdxLKF6S6M"
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
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
--PvbNWPi7XgVQCARuv9JDNi4SdxLKF6S6M
Content-Type: multipart/mixed; boundary="hFnhbtwKchBRFfJXieHjQart8RciQTSqc";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: "Jonathan K. Bullard" <jkbullard@...277...>,
 =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <ff190c51-3e5b-f7e9-f176-d86ea9dcaefd@...2080...>
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
 <CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
In-Reply-To: <CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>

--hFnhbtwKchBRFfJXieHjQart8RciQTSqc
Content-Type: multipart/mixed;
 boundary="------------6C1217D37D5CA85A1506B3ED"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------6C1217D37D5CA85A1506B3ED
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 21/06/17 13:48, Jonathan K. Bullard wrote:
> On Wed, Jun 21, 2017 at 6:47 AM, Samuli Sepp=C3=A4nen <samuli@...515...> =
wrote:
>> The OpenVPN community project team is proud to release OpenVPN 2.4.3. It
>> can be downloaded from here:
>>
>> <http://openvpn.net/index.php/open-source/downloads.html>
>=20
> Hi. Thanks for this release.
>=20
> Verifying the PGP signature on 2.3.17.tar.gz works fine (so did 2.4.2
> a few weeks ago), but trying to verify the signature on 2.4.3.tar.gz
> fails with:
>=20
> $ gpg2 -v --verify /XXX/openvpn-2.4.3.tar.gz.asc
>=20
> gpg: armor header: Version: GnuPG v1
> gpg: assuming signed data in '/XXX/openvpn-2.4.3.tar.gz'
> gpg: Signature made Wed Jun 21 06:19:19 2017 EDT
> gpg:                using RSA key D72AF3448CC2B034
> gpg: using subkey D72AF3448CC2B034 instead of primary key 12F5F7B42F2B01E7
> gpg: using pgp trust model
> gpg: BAD signature from "OpenVPN - Security Mailing List
> <security@...515...>" [unknown]
> gpg: binary signature, digest algorithm SHA1, key algorithm rsa4096
>=20
> The SHA256 ofopenvpn-2.4.3.tar.gz is
>      84a01aa3df0c12a3552ca3baaa39d700137b5bce4b6de683fe87fb79bfa5df0b
>=20
> The SHA256 of openvpn-2.4.3.tar.gz.asc is
>      695afa06fcf94f9e8bd2ee63267332d14e52fe24dd58c470e42dafbea371e437
>=20
> The files were downloaded from
> https://openvpn.net/index.php/open-source/downloads.html at about
> 10:24 UCT today from the New York City area.
>=20
> For reference, here is the output from verifying 2.3.17:
>=20
> $ gpg2 -v --verify /Users/jonathanbullard/Desktop/openvpn-2.3.17.tar.gz.a=
sc
>=20
> gpg: armor header: Version: GnuPG v1
> gpg: assuming signed data in
> '/Users/jonathanbullard/Desktop/openvpn-2.3.17.tar.gz'
> gpg: Signature made Wed Jun 21 06:18:55 2017 EDT
> gpg:                using RSA key D72AF3448CC2B034
> gpg: using subkey D72AF3448CC2B034 instead of primary key 12F5F7B42F2B01E7
> gpg: using pgp trust model
> gpg: Good signature from "OpenVPN - Security Mailing List
> <security@...515...>" [unknown]
> gpg: WARNING: This key is not certified with a trusted signature!
> gpg:          There is no indication that the signature belongs to the ow=
ner.
> Primary key fingerprint: F554 A368 7412 CFFE BDEF  E0A3 12F5 F7B4 2F2B 01=
E7
>      Subkey fingerprint: B596 06E2 D8C6 E10B 80BE  2B31 D72A F344 8CC2 B0=
34
> gpg: binary signature, digest algorithm SHA1, key algorithm rsa4096
>=20
> Any ideas or suggestions?

I believe it is Cloudflare playing tricks on us again.

Attached are the proper signature files and below a list of the SHA256 chec=
ksums:

d300029416b045666f2dc957bdde407ba97894428b5ad8433df789e793ccc1d3  openvpn-2=
.3.17.tar.xz
b206065f4a1720c022fde710c0449b5b25e9dda8ca2911a82bacf21b9fcb4e29  openvpn-2=
.3.17.tar.xz.asc
7aa86167a5b8923e54e8795b814ed77288c793671f59fd830d9ab76d4b480571  openvpn-2=
.4.3.tar.xz
9f5f089f4a4b3e270ddb53cb0b689f4c0bad89d7e2ee08a1d4666e7ab869f210  openvpn-2=
.4.3.tar.xz.asc

This is based on the files I've already pushed to the Fedora builder (koji)=
, which
I downloaded soon after the swupdates.openvpn.net server was updated.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc


--------------6C1217D37D5CA85A1506B3ED
Content-Type: application/pgp-encrypted;
 name="openvpn-2.3.17.tar.xz.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="openvpn-2.3.17.tar.xz.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlRSWNC
QUFCQWdBR0JRSlpTa2dYQUFvSkVOY3E4MFNNd3JBMFB5MFAvMVFTeXJaVkRUdFdMM2pPR0tB
aUpSaG8KeU4zZHVwZDVjd1BTcXNwLytxQXB1VGYvMi9RWmRhNjlPWTV2R3d0d1NTVFNQK3V6
N2dGLyswTHBQd2xIeWl2SwpTbkdqUWFPTlg1YVVNem4vcXNhemw3YzJQT1kxR2hza1ZxN2hr
KzRRMFBUL2JBcUdlSGhxTk5kd0RNTkswWjlWCk02dWZXKzFtbXFFaS9JdWs3NWRUeGNNaEx5
STNGdGsraWJMWGVydTZxM2ZaTXQzYTFrNlQ2bkFMaHdUQ2NZMHoKT2RhQ3d4aTg5TllWeDNl
VTlNZnVVMXJqbUtKRE1CZWhVYzNETjVPVlZ0TWlnckU0SzhCT0VEak9qRjcvcjVvcQpWaWxY
U2d2dUlzUDNPeDJha3ZDWjNraC9vNmgzdkRxK0d6YWo4WHZMUWhlaEVYd1h6WjN4MytMajNt
VE1sRlVtCi9jMVlidm9NUEdsT0ZkeGU4eEpHZE5BcGkrakNlWmx6ZURyd3g4TkYrRmdxTUx2
TEtwb01TOEdxTWJud2lqWXcKbTRwMnpaVnZEWVRKenR5eVo2WHZiTXNHN21kb3k1UW9wdGd1
SEwzVTllN0oxbVJKdFlNWVlDK2dhejdmTUVzQwpmYnYvWlN0aUtwc2ZKQXpHZ3MwTER3SkpQ
ZHEyZUJQOEdDaTNLVlBCalVlYkRZRGIyK0k0MWFWYnZJQnluejB3CnB5UzdNUy9LSzdqUDQv
K282MWIrVHk1RmRCRGxnNzZ4VkFDSHEraEpyQktIY2RpQjBHK1BsVFNSbzJTSFBtTm0KT0Zu
c2NzMXNOT2M3QWZVTHJzakJMUkh3Zm5KZGR4c29lRnV0STNWMG9pWHNZaS9LVmpSWDF5blJh
dlovb0x5NwpWWkdVOGdHbm9oQzU4Q0owdDkyRgo9ekJWYgotLS0tLUVORCBQR1AgU0lHTkFU
VVJFLS0tLS0K

--------------6C1217D37D5CA85A1506B3ED
Content-Type: application/pgp-encrypted;
 name="openvpn-2.4.2.tar.xz.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="openvpn-2.4.2.tar.xz.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlRRWNC
QUFCQWdBR0JRSlpGRTRoQUFvSkVDbFlUWjlBaGtWNDU0RUlBTUk2R3dxVnJ4Z08rWGV3dkNG
V01yWHYKR3VWcEZ4OHc0RFZvQk42S2M2YkxyY1AxUjRtMDRTQ1lyc2V5ODhhaERQNTExM1o0
UWxHa3VWbzNHU0tTcUZ0Uwpadk8wcjljMzdWblNVcElwOHlEMUYvRi9LOW5wMW12eXd5Rjgv
MWNIREZvSU13RWU1VE50aTNGdm8wVGFGTzdrCnJMbk5kY1RJTFd2ZXFUUUJQNEhobWE5SGww
TVJMT1hZOUNQY3dLQmhZWnFoOFVCamxtYm5BeU9QWEQ5aFFlL3EKUVA5NlpDbDZzQ2x2UHlC
VGZHdzhxMGJ4c2RXalRKUWpabmlvTzYxeGtSNEp5UXI3ZHBPTHIyZ0N3bkwxbDlVNgpmZVY5
RXlqSFF4WDlsYnIrU3ZmdURPV01aWEFBcU1meDBMdHo3b29wQjNEVEF0aU45VEFXUW41djdr
U3h3eGM9Cj1Xa3c0Ci0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--------------6C1217D37D5CA85A1506B3ED--

--hFnhbtwKchBRFfJXieHjQart8RciQTSqc--

--PvbNWPi7XgVQCARuv9JDNi4SdxLKF6S6M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZSmcAAAoJEIbPlEyWcf3y4KYP/2rIOFGKcVkgBoz9SP7ft4MU
NQflEn6m/8+aImF6zj3ATXiNeQURtUsLJfNpRPVlyt0oqzf77eBDBhDtdd2cvi97
JRRww8bAGFrMSlHTHrumcj1dQ53kjiNoj4WmyhDgCAM7BHVZKvdOau9q3vN3YPrY
mtkkw1e4lr77bStBDU9OGlYwJ9BpdfhC+CjAYMUPqqr05+kEFD1WGDpmyxnr1+Fh
0RMjWRp0Gle5QPxu7aydS2wgMAI0fFHWnrd8t7wyvs3/cQlaU45XWykXmkF8UIJP
+WPBNxmWG9TDdIXLqt2qChrZcFmDnobIAqZjPGWbZY9b57QcA4srMJy1Bxc3NpGD
OVcKnMN2+07sEH7flzFGfcHlTzIXsNN6jpTxdDY9+qzme94tQR2OlXWtYqc+DEXp
eNiasbI0j9SYK8NCR+4IATmKvUp5u4F/WFh8TcICB6O5Cd7yeGk7t7nvAbjhGvX9
VMkKcuCW3bKzI4J9VtMkNjiack/k9wI51I1tuaXLjrtvbRxMb3+DhUI9Ene6qR0x
lXAiMjVxzhs9qhGim3xy+BE9Ikfx2Fu0vemRGntdYCx/UBChlNZxZcfCeuL1WyGP
Fg+Hv3RawFFRTV/Zr5gPGZPftLkgIgRhTSX02DQ2vYDLpFP4Rp+jZRcdVUMHMGpO
4FQx4PkB9jFwXdSVexTr
=5zyX
-----END PGP SIGNATURE-----

--PvbNWPi7XgVQCARuv9JDNi4SdxLKF6S6M--

