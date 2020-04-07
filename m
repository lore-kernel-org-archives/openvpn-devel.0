References: <20200401215052.3489613-1-wgh@...2548...>
 <79cc0c02-63cf-d668-e71b-1e4343228567@...1227...>
 <1de06e6d-72a0-97d0-b9aa-0be2ab716677@...2548...>
 <bd48b82f-1baa-aec8-7f6a-d3f3853dfc9f@...1227...>
 <45d7ba54-8107-6481-9ccd-0bbed27fcad0@...2548...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <517c16b8-b552-8728-2e73-5f7bcc149953@...1227...>
Date: Tue, 7 Apr 2020 07:40:52 +0200
MIME-Version: 1.0
In-Reply-To: <45d7ba54-8107-6481-9ccd-0bbed27fcad0@...2548...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fDxgWFVaY8OW4rsb4AIIISob21ijFDtCC"
Subject: Re: [Openvpn-devel] [PATCH] OpenSSL: Fix --crl-verify not loading
 multiple CRLs in one file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: WGH <wgh@...2548...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fDxgWFVaY8OW4rsb4AIIISob21ijFDtCC
Content-Type: multipart/mixed; boundary="fHcDDVA8nzoTsF7XD1w3F0Par1pNVVYbK"

--fHcDDVA8nzoTsF7XD1w3F0Par1pNVVYbK
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 07.04.20 um 03:28 schrieb WGH:
> I think there has been some misunderstanding about the error handling in =
my patch.
>=20
> On 4/2/20 5:25 PM, Arne Schwabe wrote:
>>> backend_tls_ctx_reload_crl doesn't return an error (as it's void), and =
its caller never checks OpenSSL error stack. So as this function is, I thin=
k it should handle all errors itself, and leave the error stack clear.
>> Yes. But your patch throws that error code away. If there an error that
>> is not PEM_R_NO_START_LINE it will be silenty discarded. That is my
>> problem with using ERR_get_error there.
> Please look again: the patch doesn't throw it away, it's printed with ERR=
_error_string_n/msg combo.
>>> Compare with how it was in current edition of the patch:
>>>
>>> =C2=A0=C2=A0=C2=A0 Thu Apr=C2=A0 2 17:07:13 2020 Diffie-Hellman initial=
ized with 2048 bit key
>>> =C2=A0=C2=A0=C2=A0 Thu Apr=C2=A0 2 17:07:13 2020 OpenSSL: error:0909006=
C:PEM routines:get_name:no start line
>>> =C2=A0=C2=A0=C2=A0 Thu Apr=C2=A0 2 17:07:13 2020 CRL: cannot read CRL f=
rom file combined_crl.pem: error:0908F066:PEM routines:get_header_and_data:=
bad end line
>>> =C2=A0=C2=A0=C2=A0 Thu Apr=C2=A0 2 17:07:13 2020 CRL: loaded 1 CRLs fro=
m file combined_crl.pem
>>>
>> Yeah but *always* having a scary error that translates to "No more crls
>> found in the file" is not very user friendly since most people will not
>> understand that this is to be expected.
>=20
> Perhaps you glanced over and didn't notice that it says "bad _end_ line"?=
 Here I simulated a corrupt file, causing this error, to highlight the diff=
erence in how errors are printed by crypto_msg and by my ad-hoc code. My co=
de does a better job at indicating that the error comes from the CRL file, =
where messages printed by crypto_msg may blend with other bogus errors and =
warnings, like it happened with that bogus warning you fixed in the aforeme=
ntioned patch.
>=20

Yeah sorry, the formatting of the patch made me believe the control flow
was different from what it really is. But this bogus error message was a
one off mistake in OpenVPN. In general printing an error before the
message isn't a big problem.


> Also, my patch doesn't print "no start line" error unless there were no v=
alid CRLs inside the specified file. Printing a scary error in the latter c=
ase is IMHO justfified: file is either empty due to some administrative mis=
take (e.g. buggy updating scripts) or corrupt.
>=20
> I do not insist on leaving my logging in place, though, and will replace =
it with crypto_msg as you suggested. After all, crypto_msg is used all over=
 the place, and making its errors more understandable is something out of s=
cope of this patch.
>=20

I feel consistency in code is important. And crypto_msg will also print
the whole error stack instead of just the last message (which probably
does not matter in this case). Since crypto_msg is used all over the
place, its printing should be improved instead of having different error
message handling/printing all over the place. For your one-off patch it
might seem superior but for maintaining the code it is not.

Arne


--fHcDDVA8nzoTsF7XD1w3F0Par1pNVVYbK--

--fDxgWFVaY8OW4rsb4AIIISob21ijFDtCC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6MEmQACgkQFRhsZwKx
RFQRvQ//Y90Ym8RXxnKcLMEbACP6TMRhEvHx4cvQSZNbB0xIxv7NWa5jubnddDlA
EDcieTlfFDLYeip1uqbepI+rGkEHhCGSueI+3FqRrXSnjWDFgdoKp8CScH4LVfdG
UGI4jHqihGW6B8pKKi1zvHl7s1CwO9bfL/Hw5w52KLK6apzpw8E6mumZoFuU36Ul
sBYfhDWm3wBVu2HyMkQt6FPJbEmBg69nG4CUaa5IotKPG2nHPp/kCY7F6MSyXRyW
mQs6qTGUDs2tqs1R7F6HSBjLVN5o1MLc/lrGAwulcY3awJhn9GrB43QXOnvhxoW1
OIQJqisamS1/m1kij44wXQgDtf1huIKljKzWURphPPPWUGcOduIEuitUQD7l5NMP
5lf6PDkRDcD+1f8UFNzU0J1LoBgUFoMJMTCjjLf9uAxBik95pdCyv/FxFaTLlAcN
IJrtC9ldTeQ4m2dxARdiP0xB/jPWDdKCt4zMfn4yltG5TYol6OmkU9AF5yI/VdO9
2DuZvh2odxFBlCrd89pvazyMIWQDza0OoV6ohu14v/J6WGmtnPksb/+2FtxRUYlS
ZNurD8Ot5eJK4qnqOBvYg3LegxKM7oW5U1Rce+6pI4IVpknfagimuTuejCrF+qNH
OhQgnaMmgDxVVE63QvMpicLBJKQ3ZrHC5+iiGN7tC8nmbuzB1cs=
=x5g2
-----END PGP SIGNATURE-----

--fDxgWFVaY8OW4rsb4AIIISob21ijFDtCC--

