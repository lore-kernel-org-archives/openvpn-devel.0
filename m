References: <CAGyAFMULV02g3gyCbvQ1+L+cMdE4UZMmzVfey-T1g4Y0NcmKeg@...278...>
 <1539174377-2678-1-git-send-email-lstipakov@...277...>
 <20181010185023.GD962@...1296...>
 <CAGyAFMVqTChKmpfTY0XhdJB+q030LkxDCsitEwVrwV2Ui8bJdQ@...278...>
 <20181011112317.GF962@...1296...>
 <39371514-ad3a-0768-54d1-459457877e37@...1435...>
 <20181011115647.GG962@...1296...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <516fc1b6-e7f3-e92b-2f24-c2fd0db9e76f@...1435...>
Date: Thu, 11 Oct 2018 14:10:07 +0200
MIME-Version: 1.0
In-Reply-To: <20181011115647.GG962@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="83pWRa8cDOqHbwbfpEgzWq6uJ5YZ253Xd"
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--83pWRa8cDOqHbwbfpEgzWq6uJ5YZ253Xd
Content-Type: multipart/mixed; boundary="t7z90Qj3elh0IriMyVb1Bn5henbXEl7Iw";
 protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <516fc1b6-e7f3-e92b-2f24-c2fd0db9e76f@...1435...>
Subject: Re: [Openvpn-devel] [PATCH v2] options.c: fix broken unary minus
 usage
References: <CAGyAFMULV02g3gyCbvQ1+L+cMdE4UZMmzVfey-T1g4Y0NcmKeg@...278...>
 <1539174377-2678-1-git-send-email-lstipakov@...277...>
 <20181010185023.GD962@...1296...>
 <CAGyAFMVqTChKmpfTY0XhdJB+q030LkxDCsitEwVrwV2Ui8bJdQ@...278...>
 <20181011112317.GF962@...1296...>
 <39371514-ad3a-0768-54d1-459457877e37@...1435...>
 <20181011115647.GG962@...1296...>
In-Reply-To: <20181011115647.GG962@...1296...>

--t7z90Qj3elh0IriMyVb1Bn5henbXEl7Iw
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 11-10-18 13:56, Gert Doering wrote:
> On Thu, Oct 11, 2018 at 01:52:37PM +0200, Steffan Karger wrote:
>>> I know that Steffan likes using size_t for "things that have a size"
>>> but I find it a bit questionable here :-)
>>
>> So the underlying problem is that "further down" used int to store
>> sizes, but since that just is the way it is and we shouldn't pull in
>> refactoring the code base for each small change, I would say either make
>> both 'int', or make both 'size_t', but without changing the types of
>> struct frame itself.  I of course prefer the latter ;-)
>=20
> Adding or substracting a size_t from frame->extra_frame (which is an int)
> will quite likely cause the same warning again...

I don't think so, because at that level, you'll be adding/subtracting
either "int + int" or "int + size_t", which are equally likely to cause
overflows. Only that signed overflows are not only not what you want,
but also undefined behaviour.

But well, as I said, I'm fine with both in this case. It will
effectively not change any logic anyway.

-Steffan



--t7z90Qj3elh0IriMyVb1Bn5henbXEl7Iw--

--83pWRa8cDOqHbwbfpEgzWq6uJ5YZ253Xd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJbvz2fAAoJEEEwndWOY1w5fAcH/07rXTYNPSrXVATycKbwluBI
efXgH2OtBlpBp8yW2J7p6HSnVsQzwsp4pnsbTwDmq6geKkYmhCup+0HvooysWM24
KVzKKN88zkBkC3mQpOEj6mKUP7+T8cY2fDARRafhl5K5B5TbkUGAccB9YL7u5Eow
evWzX6LMNv6t6g+bUtvG7AQ84EMRkn/cuYppieDFKtjMwNh7N7SylGD1VzGTKBmW
cRwp6F8EH/iuhpgYTJ1wVxKrg3YbKamzl+Dz+FmjR3IeDlMoXAJjv/bqqvy+TWYd
yVt2S9mrFenGenxaKgzw8Pa/0kGpLvlE1WJezKf3pZPles0ownW8o+/dUoi1vA0=
=A6Fp
-----END PGP SIGNATURE-----

--83pWRa8cDOqHbwbfpEgzWq6uJ5YZ253Xd--

