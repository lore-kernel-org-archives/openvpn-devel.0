References: <61a238ea-3a52-da19-9a21-a127540e2b5e@...515...>
	<CAFHpkQG3GOm-GKj24pccyn84pZaA=KsvMgfqYLVjs9DxEo6Y5w@...278...>
	<0a77ede7-0374-ed7a-a10e-20d0ac9e31b9@...2080...>
	<95c70c5e-22ac-81ab-0fca-b9195f426f7a@...1856...>
	<a0821983-407a-dd9f-dbac-47f94a18c4dd@...515...>
	<ea1e3d78-2534-e918-5b46-ac510822415d@...1147...>
	<b0dbe975-53c0-65e0-27f3-788c3156dc11@...2080...>
	<CAKuzo_j1hHgnDuFjTt4jYZg5q1QL5U15=iiLsYT-Uao++sYACQ@...278...>
	<CAA1AbxKDk40-RF68g-OadXtQxToH3oZ8C5B7Q7h27E1BEu-Opg@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <77168236-103b-3fb0-0e92-6035a25e36ba@...515...>
Date: Wed, 5 Apr 2017 11:12:31 +0300
MIME-Version: 1.0
In-Reply-To: <CAA1AbxKDk40-RF68g-OadXtQxToH3oZ8C5B7Q7h27E1BEu-Opg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="np00I2Unb983bTWsDjQaSXDrXcA5x9PVp"
Subject: Re: [Openvpn-devel] Upgrading EasyRSA 2's defaults
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--np00I2Unb983bTWsDjQaSXDrXcA5x9PVp
Content-Type: multipart/mixed; boundary="------------1FC588259AFEAD9A084D6B10"

This is a multi-part message in MIME format.
--------------1FC588259AFEAD9A084D6B10
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 04/04/2017 10:48, Steffan Karger wrote:
> Hi,
>=20
> On 3 April 2017 at 23:14, Selva Nair <selva.nair@...277...> wrote:
>>
>>
>> On Mon, Apr 3, 2017 at 4:43 PM, David Sommerseth
>> <openvpn@...2080...> wrote:
>>>
>>> On 03/04/17 16:12, Jan Just Keijser wrote:
>>>> Hi Samuli,
>>>>
>>>> On 03/04/17 15:53, Samuli Sepp=C3=A4nen wrote:
>>>>> On 02/04/2017 10:57, Steffan Karger wrote:
>>
>>
>> snip..
>>
>>>
>>>>>> DSA is _not_ a preferred choice.  The original 1024-bit DSA is too
>>>>>> weak
>>>>>> nowadays, and the 'larger' DSA variants are not even close to the wi=
de
>>>>>> support that RSA has.
>>>>>>
>>>>>> -Steffan
>>>>>>
>>>>> Hi,
>>>>>
>>>>> I've issue a pull request here and review would be appreciated:
>>>>>
>>>>> <https://github.com/OpenVPN/easy-rsa-old/pull/1>
>>>>>
>>>>> I tested these changes on Debian 8 which has OpenSSL-1.0.1. Key size
>>>>> was
>>>>> set to 4096-bits and signature algorithm to SHA256WithRSAEncryption.
>>>>>
>>>>> The only real issue was DH parameter generation: it took ~25 minutes =
on
>>>>> my Intel i5 laptop. Is that acceptable default behavior?
>>>>>
>>>> what kind of i5 is this? on my i7-4810 it took 5 minutes. Can you give
>>>> the full CPUID string (from /proc/cpuinfo) ?  then I can
>>>> guestimate whether the 25 minutes is realistic for slower hardware.
>>>
>>> I've run a a couple of "quick" tests ... on a two different laptops
>>>
>>> --- test 1 ----------------------------------------------------------
>>> $ time openssl gendh -out test 4096
>>> [...snip...]
>>>
>>> real    35m40.098s
>>> user    35m38.922s
>>> sys     0m0.367s
>>> $ cat /proc/cpuinfo  | grep model\ name | uniq -c
>>>       4 model name      : Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz
>>
>>
>> 4096 bit "strong" prime is indeed an intensive computation.. Is using
>> -dsaparam  option not secure enough?
>>
>> openssl dhparam -dsaparam -out test 4096
>>
>> is 15 seconds vs forever without it on my ancient desktop.
>=20
> From the openssl man page:
>=20
> "Beware that with such DSA-style DH parameters, a fresh DH key should
> be created for each use to avoid small-subgroup attacks that may be
> possible otherwise."
>=20
> This means that if for some reason a non-ephemeral diffie-hellman
> cipher suite is selected, you are at risk of these attacks.
>=20
> If you are worried about the parameter generation time, just use one
> of the IETF-provided parameters, e.g:
> https://tools.ietf.org/html/rfc7919#appendix-A.2
>=20
> But beware that using larger groups does not only slow down parameter
> generation, it also slows down connection setup.  ECDH is much faster,
> but if you need to use DH, do some performance tests before blindly
> using 4096-bits parameters.
>=20

As discussed in the pull request we could easily make EasyRSA 2 use a
different keysize for the Diffie-Hellman parameters and for the private
key. Would that be the easiest way out?

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------1FC588259AFEAD9A084D6B10
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

--------------1FC588259AFEAD9A084D6B10--

--np00I2Unb983bTWsDjQaSXDrXcA5x9PVp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY5KbvAAoJEClYTZ9AhkV4Ln4H/3A7x+1hfe2CcurDS74gF+Zq
Zx0wwbi1ik10XzEp7XyjVc7R6GWUWzssBPyRxlK+P8SVnqgY16EjXxlEPy8N8FUu
g4xIk1bXTvBCf7rbxM+qLO7kD+FXQ6032S5Ihl/7HbuvAUuiuE4Jjt6n9BkpKIOc
NS0wojAGXBewxZl7xmU9YlCK1RnoVPvVFJVrf4Jab1EZ1TJxkmZMfLkan0Rmco3o
1Ku4pjr/mqLhgZyl54a7WyJAAU9crmQVFR7i6Pz2O3qf1G+/E3GGGVSlajWEZx39
VDq/7KZ8WP+eQplQreb6dEMOK0o5pnzNiXkYMt7fsLpKssyalObmhbTFph7kBaU=
=lnzL
-----END PGP SIGNATURE-----

--np00I2Unb983bTWsDjQaSXDrXcA5x9PVp--

