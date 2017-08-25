References: <20170824133305.25604-1-a@...2181...>
 <20170824191848.GH70062@...1296...>
 <011fb50e-4b84-6f2c-c730-dc419b840f6f@...2080...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <f9727fce-bda2-e21d-c944-22b5b28f7629@...2181...>
Date: Fri, 25 Aug 2017 09:41:45 +0800
MIME-Version: 1.0
In-Reply-To: <011fb50e-4b84-6f2c-c730-dc419b840f6f@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NIf2IoebD2EDQGjWUxQTFnq7CWothxsuQ"
Subject: Re: [Openvpn-devel] [PATCH] bash: substitute legacy `` with modern
 $()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NIf2IoebD2EDQGjWUxQTFnq7CWothxsuQ
Content-Type: multipart/mixed; boundary="6PiUK1gABqLQdI9bePv5rTLRXasU3IIKs";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>
Message-ID: <f9727fce-bda2-e21d-c944-22b5b28f7629@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] bash: substitute legacy `` with modern
 $()
References: <20170824133305.25604-1-a@...2181...>
 <20170824191848.GH70062@...1296...>
 <011fb50e-4b84-6f2c-c730-dc419b840f6f@...2080...>
In-Reply-To: <011fb50e-4b84-6f2c-c730-dc419b840f6f@...2080...>

--6PiUK1gABqLQdI9bePv5rTLRXasU3IIKs
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable



On 25/08/17 04:21, David Sommerseth wrote:
> On 24/08/17 21:18, Gert Doering wrote:
>> (gen-release-tarballs.sh only needs to work on FreeBSD and Linux, and
>> FreeBSD's /bin/sh is sufficiently modern so so it's likely to work
>>  - but the test scripts need to run robustly everywhere a user builds,
>> so never assume "because bash says so!" is a way anywhere but into worlds
>> of pain.  And yes, we've been there before :-) )
>=20
> And to avoid style confusions ... as long as we can avoid having "one
> style" on the test scripts and "another style" on the dev-tools scripts,
> that will be easier to review and maintain.
>=20
> We can have more slack in dev-tools, but if we deviate, then we need to
> properly document it so we won't forget why.

I also think it is a bad idea to have different styles. If we have to
agree on something, it should be valid for every file of that type.

Let's postpone this for when we'll have tested various platforms.


Cheers,

--=20
Antonio Quartulli


--6PiUK1gABqLQdI9bePv5rTLRXasU3IIKs--

--NIf2IoebD2EDQGjWUxQTFnq7CWothxsuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlmfgFkACgkQ0+HICM1s
oFAAsw//Vb6x+x8pHj0PqTmVbtDapa80vjUZs1u4eFun8Yx5hAtvGZF3KmRFFZ0A
GcyJDAJSRn3+uAU+wgglFJra1GrtqrLvL0TTGK8tLy7ADRJ1FHE8AWwNMHoPI8Bo
1G+PQZSsoaGB3+In4esXOqnr2fbz14YJZIcr/swi1P9tWoxCrRokf/0PZW98RNfO
PESwweeTicMj+ByPZzmYQX1eK48evFOVtPU8pU/RSlbB18Qe1SioGCDKdFndjp8I
bw3G33MbBf310JwYInvtrLCT3nYvvBzmpb+UaRQjk8ZJqojvC502NWvNq4BV1QdV
DHjtROcHd+oql0VlYcyA/Pu5xJKL3SUVrtGoW/xHhgahkxPOt5y1CojePuuzS7wx
JcTjDvJhtPZ8tCYuuv49pHArvzdT3IR2NAOMGxWXgQPGVY3ZzizxSsqIMScRkqtI
cv4JFZORgltVHtjYnNcQApShXQ0J8jXuJpS5IbPlQz4FeZM5JgjleYW0WbMyqEq7
QkRJqG3vOC8TIk8L2yR+shNzJgcHcToafQvraurIslV7jrH73k7cQmWv0mkpEQCR
i14Y9wa7QCV6yD0XgKr1MpQntiZE6wouaToVmEkiz4ERavLksJOTkp2ugo577nYt
MpZh1PI0EJvmiUyPgqclUkC5xs8ZbZix8yfDi2mQ7oa60f4ZwtU=
=z/t7
-----END PGP SIGNATURE-----

--NIf2IoebD2EDQGjWUxQTFnq7CWothxsuQ--

