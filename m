References: <CAGyAFMULV02g3gyCbvQ1+L+cMdE4UZMmzVfey-T1g4Y0NcmKeg@...278...>
 <1539174377-2678-1-git-send-email-lstipakov@...277...>
 <20181010185023.GD962@...1296...>
 <CAGyAFMVqTChKmpfTY0XhdJB+q030LkxDCsitEwVrwV2Ui8bJdQ@...278...>
 <20181011112317.GF962@...1296...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <39371514-ad3a-0768-54d1-459457877e37@...1435...>
Date: Thu, 11 Oct 2018 13:52:37 +0200
MIME-Version: 1.0
In-Reply-To: <20181011112317.GF962@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="y7tICc4JPMWI5usptKpzqButJQ0jq6ADz"
Subject: Re: [Openvpn-devel] [PATCH v2] options.c: fix broken unary minus
 usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--y7tICc4JPMWI5usptKpzqButJQ0jq6ADz
Content-Type: multipart/mixed; boundary="rVX8tVVV5fR0WlFrw59lC1RcgugUkNqoa";
 protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <39371514-ad3a-0768-54d1-459457877e37@...1435...>
Subject: Re: [Openvpn-devel] [PATCH v2] options.c: fix broken unary minus
 usage
References: <CAGyAFMULV02g3gyCbvQ1+L+cMdE4UZMmzVfey-T1g4Y0NcmKeg@...278...>
 <1539174377-2678-1-git-send-email-lstipakov@...277...>
 <20181010185023.GD962@...1296...>
 <CAGyAFMVqTChKmpfTY0XhdJB+q030LkxDCsitEwVrwV2Ui8bJdQ@...278...>
 <20181011112317.GF962@...1296...>
In-Reply-To: <20181011112317.GF962@...1296...>

--rVX8tVVV5fR0WlFrw59lC1RcgugUkNqoa
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 11-10-18 13:23, Gert Doering wrote:
> On Thu, Oct 11, 2018 at 01:40:16PM +0300, Lev Stipakov wrote:
>>> Since crypto_overhead and crypto_max_overhead() are both size_t, and
>>> frame_add_to_extra_frame() is declared to take an "unsigned int" now,
>>> this cast should not be necessary.
>>
>>
>> Visual Studio disagrees. Without explicit cast I got
>>
>>> warning C4267: 'function': conversion from 'size_t' to 'const unsigned
>> int', possible loss of data
>>
>> https://docs.microsoft.com/fi-fi/cpp/error-messages/compiler-warnings/co=
mpiler-warning-level-3-c4267?view=3Dvs-2017
>>
>>
>> 'var' : conversion from 'size_t' to 'type', possible loss of data
>> The compiler detected a conversion from size_t to a smaller type.
>=20
> So, maybe "crypto_overhead" and "crypto_max_overhead()" should be
> changed to be just "int" here...?
>=20
> For something which has a numeric value between "10-ish" and "100" (maybe=
),
> using a 64bit integer initially and then adding casts because we want
> to work with 32bit integers later on and not be warned about it sounds
> like the wrong way to tackle this...
>=20
> I know that Steffan likes using size_t for "things that have a size"
> but I find it a bit questionable here :-)

So the underlying problem is that "further down" used int to store
sizes, but since that just is the way it is and we shouldn't pull in
refactoring the code base for each small change, I would say either make
both 'int', or make both 'size_t', but without changing the types of
struct frame itself.  I of course prefer the latter ;-)

-Steffan


--rVX8tVVV5fR0WlFrw59lC1RcgugUkNqoa--

--y7tICc4JPMWI5usptKpzqButJQ0jq6ADz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJbvzmMAAoJEEEwndWOY1w59qkIAI+0Jb6uQnfCcV+Xr0qR53eS
yA5djfcvhzRqFq4PeqAeFh5GXYPbYZ2YXF81TNc/CCWNTL+fONtRoFnp/YmWYeyX
EqobftjveJvidEXrUNErrNOD6xycVnFwfx/dKsAY6aLzb2OVT5BUYxAtBy1i1v0V
pruYf+/FwoiR8asyuPdSHNpmo4e/fnsCdaokKDARNY+az5k/SYqJY7gI1Jkcv2Dx
Cn82j0qefGtQfOJ+XbFz+5hc4THgr8vnvcRuRX+YrJMPU0YmTQvbr6+dlpvkhqQn
g9mzOXySbqdV/KPaZ6mVyYiw7q8U+LlbnsRTp5P5GypRLXSrLucHsxlpgIb5XS8=
=eCKA
-----END PGP SIGNATURE-----

--y7tICc4JPMWI5usptKpzqButJQ0jq6ADz--

