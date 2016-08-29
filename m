References: <45b848f8-6d95-2a2d-9cd6-667655e24857@...515...>
	<0fa5a591-d0ad-98f1-1320-bd155cb0ca3c@...2080...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a6e80a3b-7559-7798-a970-a19f22d88bc4@...2080...>
Date: Mon, 29 Aug 2016 22:29:05 +0200
MIME-Version: 1.0
In-Reply-To: <0fa5a591-d0ad-98f1-1320-bd155cb0ca3c@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="JpMqnB2gvrCQJhtjfE33pICGegenX3o5m"
Subject: Re: [Openvpn-devel] Fixing non-standard PKCS#11 serialization
 format using a patched pkcs11-helper?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JpMqnB2gvrCQJhtjfE33pICGegenX3o5m
Content-Type: multipart/mixed; boundary="pjqvLFHLlCOIQ0lvfwv9urtm72CSPW1hF"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
	"openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <a6e80a3b-7559-7798-a970-a19f22d88bc4@...2080...>
Subject: Re: [Openvpn-devel] Fixing non-standard PKCS#11 serialization format
	using a patched pkcs11-helper?
References: <45b848f8-6d95-2a2d-9cd6-667655e24857@...515...>
	<0fa5a591-d0ad-98f1-1320-bd155cb0ca3c@...2080...>
In-Reply-To: <0fa5a591-d0ad-98f1-1320-bd155cb0ca3c@...2080...>

--pjqvLFHLlCOIQ0lvfwv9urtm72CSPW1hF
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 29/08/16 21:55, David Sommerseth wrote:
> On 29/08/16 15:02, Samuli Sepp=E4nen wrote:
>> Hi,
>>=20
>> Right now our Windows installers use the official pkcs11-helper=20
>> release from the OpenSC project. Unfortunately this means that=20
>> output of "--show-pkcs11-ids" and input of "--pkcs11-id" are=20
>> non-standard, as reported here:
>>=20
>> <https://community.openvpn.net/openvpn/ticket/491>
>>=20
>> In Fedora this problem has been fixed with a custom patch
>>=20
>> <https://github.com/OpenSC/pkcs11-helper/pull/4>=20
>> <http://pkgs.fedoraproject.org/cgit/rpms/pkcs11-helper.git/>
>>=20
>> Debian and Ubuntu have _not_ are not patching this issue:
>>=20
>> <http://http.debian.net/debian/pool/main/p/pkcs11-helper/pkcs11-helper_1=
.11-5.debian.tar.xz>
>>
>>
>
>>=20
<http://archive.ubuntu.com/ubuntu/pool/main/p/pkcs11-helper/pkcs11-helper_1=
.11-5.debian.tar.xz>
>>=20
>> Do _we_ want to move to start using a patch pkcs11-helper
>> version?
>=20
> There have been some proposals to ditch pkcs11-helper and rather
> use a newer and more compliant library instead (p11-kit).  I think
> this makes more sense, to be honest.  There are more issues with=20
> pkcs11-helper which upstream seems less interested in resolving,
> among others challenges with systemd and the PIN code [1].  So as
> things start to pile up, I think it's better to move on to
> something else.
>=20
> Of course, someone needs to do this job.  JJK sponsored me with a=20
> PKCS#11 token at last hackathon + since that time I've gotten
> myself both a Yubikey Neo and a NitroKey so I believe I have what's
> needed to begin to dive into this rabbit hole ... I just need to
> get this prioritized on my TODO list.  Unless someone else wants to
> give it a try, if so let me know and we'll see if I can help out
> somehow.
>=20
> With that in mind, if shipping a patched pkcs11-helper in Windows=20
> makes your life easier I'd consider doing this.  But step
> carefully, avoid getting in a situation where you suddenly have to
> maintain these patches yourself.  Rather try to see what Fedora
> does and see if that can be re-used as much as possible.

And the missing [1] URL ...
<https://bugzilla.redhat.com/show_bug.cgi?id=3D1135932>


--=20
kind regards,

David Sommerseth


--pjqvLFHLlCOIQ0lvfwv9urtm72CSPW1hF--

--JpMqnB2gvrCQJhtjfE33pICGegenX3o5m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXxJsRAAoJEIbPlEyWcf3yH70P/RQXqAVCQb+DsS8qN5plUPrj
xXUdUEQGTXKRONzG3zkdz/MH3+g4OXfXsRCqhOhIsWI/Zb8RJVOrhHCdSRFHeHYZ
Drfjm56+8cLfctQGkoYAl5GUDKLIyOz2ZOLOOyGQfLsUhHLRTZ5lZStAXEmsV0Wq
YMwocVYNw4rlnQny74M/igAbqWQvt+EeVOuSLPekJPwOOYoOIjKocG0keUWMyrAs
CsYM5TkweLM9yCoY3A8uyrb7fWx2pC+ZFT4T5SIrO043ygS3nX3uBPqL6xGwC/ni
Kf96K3yRPp3ffTuNZjyyLp4FturaHgqOe6AIAEo8WL9v2UvOcblb7pfNtVQfqW9j
1uE3wJjvCOhMVNe4OEbv9fLWuPcGtF6/M2KB+jVfdKGcgEeFy3fRY1LPf1MA0WCy
1xdWTEv7yRRIM5S3XtKIoX6FuiWKqA6r0NR5NcyZxoX7M+4Qmsz5nlP05AIT3jmc
6lKoBDIwgeGbFky1YGNNWBdAShE8619p2gU8aGvsdYnTbdrYHexaAg2iaX1kt8OP
wCmIixPiwWsLKmi4DIR+x9F7HXVtklp5golJtITrDeMMf/YNr3dI2g5y+XiqAo/Z
aOVRIu1AP81ckNGDbUFkLTFb3VSLS6du3wp8gt4c7zV4b+/NxonBtbZ7j2O2sePS
qJFi4bkqDR2aX8qfm6Bz
=cvr1
-----END PGP SIGNATURE-----

--JpMqnB2gvrCQJhtjfE33pICGegenX3o5m--

