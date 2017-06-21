References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
	<CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
	<ff190c51-3e5b-f7e9-f176-d86ea9dcaefd@...2080...>
	<8aba466c-87e1-229f-13e8-5ad0c5ba7148@...2080...>
	<CAEsd45SxWq+jh7HffEcrjKsK-mxaQMi-bOyj7bswubSXnMSmHQ@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <675ab7d8-bb22-6150-1855-0e8a7f40d075@...515...>
Date: Wed, 21 Jun 2017 16:31:33 +0300
MIME-Version: 1.0
In-Reply-To: <CAEsd45SxWq+jh7HffEcrjKsK-mxaQMi-bOyj7bswubSXnMSmHQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GUt16NP2dTgw4E6oqrP3aeB8eAH3mCXEP"
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
To: "Jonathan K. Bullard" <jkbullard@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GUt16NP2dTgw4E6oqrP3aeB8eAH3mCXEP
Content-Type: multipart/mixed; boundary="0LGsgdLDDu5piC9rsOWjrWpfq8Cu1jpuQ";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: "Jonathan K. Bullard" <jkbullard@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <675ab7d8-bb22-6150-1855-0e8a7f40d075@...515...>
Subject: Re: ***UNCHECKED*** Re: [Openvpn-devel] OpenVPN 2.4.3 released (with
 security fixes)
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
 <CAEsd45RR25O+vw=70Q5ZXRc+nnw19t+gjtz4+yiuOMM350vgcg@...278...>
 <ff190c51-3e5b-f7e9-f176-d86ea9dcaefd@...2080...>
 <8aba466c-87e1-229f-13e8-5ad0c5ba7148@...2080...>
 <CAEsd45SxWq+jh7HffEcrjKsK-mxaQMi-bOyj7bswubSXnMSmHQ@...278...>
In-Reply-To: <CAEsd45SxWq+jh7HffEcrjKsK-mxaQMi-bOyj7bswubSXnMSmHQ@...278...>

--0LGsgdLDDu5piC9rsOWjrWpfq8Cu1jpuQ
Content-Type: multipart/mixed;
 boundary="------------27CE7F73103DDDA977BCD097"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------27CE7F73103DDDA977BCD097
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 21/06/2017 16:11, Jonathan K. Bullard wrote:
> On Wed, Jun 21, 2017 at 8:40 AM, David Sommerseth
> <openvpn@...2080...> wrote:
>> On 21/06/17 14:30, David Sommerseth wrote:
>>> On 21/06/17 13:48, Jonathan K. Bullard wrote:
>>>> On Wed, Jun 21, 2017 at 6:47 AM, Samuli Sepp=C3=A4nen <samuli@...1699...=
.> wrote:
>>>>> The OpenVPN community project team is proud to release OpenVPN 2.4.3.=
 It
>>>>> can be downloaded from here:
>>>>>
>>>>> <http://openvpn.net/index.php/open-source/downloads.html>
>>>>
>>>> Hi. Thanks for this release.
>>>>
>>>> Verifying the PGP signature on 2.3.17.tar.gz works fine (so did 2.4.2
>>>> a few weeks ago), but trying to verify the signature on 2.4.3.tar.gz
>>>> fails with:
>>>>
>>>> $ gpg2 -v --verify /XXX/openvpn-2.4.3.tar.gz.asc
>>>>
>>>> gpg: armor header: Version: GnuPG v1
>>>> gpg: assuming signed data in '/XXX/openvpn-2.4.3.tar.gz'
>>>> gpg: Signature made Wed Jun 21 06:19:19 2017 EDT
>>>> gpg:                using RSA key D72AF3448CC2B034
>>>> gpg: using subkey D72AF3448CC2B034 instead of primary key 12F5F7B42F2B=
01E7
>>>> gpg: using pgp trust model
>>>> gpg: BAD signature from "OpenVPN - Security Mailing List
>>>> <security@...515...>" [unknown]
>>>> gpg: binary signature, digest algorithm SHA1, key algorithm rsa4096
>>>>
>>>> The SHA256 ofopenvpn-2.4.3.tar.gz is
>>>>      84a01aa3df0c12a3552ca3baaa39d700137b5bce4b6de683fe87fb79bfa5df0b
>>>>
>>>> The SHA256 of openvpn-2.4.3.tar.gz.asc is
>>>>      695afa06fcf94f9e8bd2ee63267332d14e52fe24dd58c470e42dafbea371e437
>>>>
>>>> The files were downloaded from
>>>> https://openvpn.net/index.php/open-source/downloads.html at about
>>>> 10:24 UCT today from the New York City area.
>>>>
>>>> For reference, here is the output from verifying 2.3.17:
>>>>
>>>> $ gpg2 -v --verify /Users/jonathanbullard/Desktop/openvpn-2.3.17.tar.g=
z.asc
>>>>
>>>> gpg: armor header: Version: GnuPG v1
>>>> gpg: assuming signed data in
>>>> '/Users/jonathanbullard/Desktop/openvpn-2.3.17.tar.gz'
>>>> gpg: Signature made Wed Jun 21 06:18:55 2017 EDT
>>>> gpg:                using RSA key D72AF3448CC2B034
>>>> gpg: using subkey D72AF3448CC2B034 instead of primary key 12F5F7B42F2B=
01E7
>>>> gpg: using pgp trust model
>>>> gpg: Good signature from "OpenVPN - Security Mailing List
>>>> <security@...515...>" [unknown]
>>>> gpg: WARNING: This key is not certified with a trusted signature!
>>>> gpg:          There is no indication that the signature belongs to the=
 owner.
>>>> Primary key fingerprint: F554 A368 7412 CFFE BDEF  E0A3 12F5 F7B4 2F2B=
 01E7
>>>>      Subkey fingerprint: B596 06E2 D8C6 E10B 80BE  2B31 D72A F344 8CC2=
 B034
>>>> gpg: binary signature, digest algorithm SHA1, key algorithm rsa4096
>>>>
>>>> Any ideas or suggestions?
>>>
>>> I believe it is Cloudflare playing tricks on us again.
>>>
>>> Attached are the proper signature files and below a list of the SHA256 =
checksums:
>>>
>>> d300029416b045666f2dc957bdde407ba97894428b5ad8433df789e793ccc1d3  openv=
pn-2.3.17.tar.xz
>>> b206065f4a1720c022fde710c0449b5b25e9dda8ca2911a82bacf21b9fcb4e29  openv=
pn-2.3.17.tar.xz.asc
>>> 7aa86167a5b8923e54e8795b814ed77288c793671f59fd830d9ab76d4b480571  openv=
pn-2.4.3.tar.xz
>>> 9f5f089f4a4b3e270ddb53cb0b689f4c0bad89d7e2ee08a1d4666e7ab869f210  openv=
pn-2.4.3.tar.xz.asc
>>>
>>> This is based on the files I've already pushed to the Fedora builder (k=
oji), which
>>> I downloaded soon after the swupdates.openvpn.net server was updated.
>> Lets try to attach the _proper_ signature file for v2.4.3.  I managed to
>> send the signature for the previous (v2.4.2) release in the previous mai=
l.
>=20
> Thanks.
>=20
> My original post was about the .tar.**gz**, but I downloaded (at about
> 12:45 UCT) both openvpn-2.4.3.tar.xz and openvpn-2.4.3.tar.xz.asc, and
> verifying fails. However, verifying the .tar.xz against the .asc in
> your email succeeds. So the problems seem to be with the .asc (for the
> tar.xz, at least), not with the .tar.gz itself.
>=20
> And I tried using a VPN : ) to download from London, hoping to get a
> different CloudFlare server, but get the same (bad) .targ.gz and/or
> .tar.gz.asc as my original downloads.
>=20
> Should swupdates.openvpn.net be publicly accessible? It doesn't
> resolve for me using Google DNS.
>=20
> Best regards,
>=20
> Jon
>=20

Hi,

For whatever reason the following packages were incorrect:

  openvpn-2.4.3.tar.gz
  openvpn-2.4.3.tar.xz
  openvpn-2.4.3.zip

I suspect that the incorrect packages were the ones generated
automatically by my release script. The contents of those packages would
have been identical to the "official" packages, but the GPG signature
belonging to the correct package would not verify correctly.

Now all the files on the primary download server (swupdate) should be
correct. I will verify the files on the secondary server next and add
automated "download files from web and verify them with GnuPG" to my
release script.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------27CE7F73103DDDA977BCD097
Content-Type: application/pgp-keys;
 name="0x40864578.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x40864578.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
XuwT7RpGDZ6jBfphYQ=3D=3D
=3DFKLE
-----END PGP PUBLIC KEY BLOCK-----

--------------27CE7F73103DDDA977BCD097--

--0LGsgdLDDu5piC9rsOWjrWpfq8Cu1jpuQ--

--GUt16NP2dTgw4E6oqrP3aeB8eAH3mCXEP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZSnU2AAoJEClYTZ9AhkV4Ng8H/1knqpAWHU4JtfFooFGubnf3
5+K+UqQ9IsrZHpIgPnVa/N4bprEs3tbMgauy42d9DNlxVkJqg0AuaGv8uGZ2n/o8
xol3NvtYnctIEsKbI0oDgUq28fspzIrp8vaM9VV+6j1tICTbZ4joCdLD9xi7lxi9
SBkoMqiCHxlZyU2g2ZSrcbrQQShx+SQwvkrJBNoICX+riZDDdw8HNt8yfWyrc7qu
gUtLs02usox78Z8MtLcOzMg2/R1rIKKklNigJHzroyyIbE3S4TedRsbrxd7FjHh+
3kDIn7u6bf78+Mrc45HsPqBWVORWe/wamNOE/DM12+EvnFx17g90j2bZtPVJzjw=
=vUAa
-----END PGP SIGNATURE-----

--GUt16NP2dTgw4E6oqrP3aeB8eAH3mCXEP--

