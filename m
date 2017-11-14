Reply-To: openvpn-devel@lists.sourceforge.net
References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
 <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
 <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
 <4717a1f2-b8c6-26ae-2cf4-42ae5f34c3eb@...1435...>
 <6ad9db3e-63b5-78fe-0105-81c92746feb2@...2080...>
 <20171114083134.GV958@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <10ef4327-7cc1-9bd7-7307-af8b90c66962@...2080...>
Date: Tue, 14 Nov 2017 11:56:10 +0100
MIME-Version: 1.0
In-Reply-To: <20171114083134.GV958@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="c01uq22o4MGRgsuKN3BiOnNLVCO1dXoeT"
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c01uq22o4MGRgsuKN3BiOnNLVCO1dXoeT
Content-Type: multipart/mixed; boundary="BF1EViL7ltfoO1IDrJ6jNp6063gD8wxAB";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Message-ID: <10ef4327-7cc1-9bd7-7307-af8b90c66962@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
 <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
 <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
 <4717a1f2-b8c6-26ae-2cf4-42ae5f34c3eb@...1435...>
 <6ad9db3e-63b5-78fe-0105-81c92746feb2@...2080...>
 <20171114083134.GV958@...1296...>
In-Reply-To: <20171114083134.GV958@...1296...>

--BF1EViL7ltfoO1IDrJ6jNp6063gD8wxAB
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 14/11/17 09:31, Gert Doering wrote:
> Hi,
>=20
> On Mon, Nov 13, 2017 at 01:16:46PM +0100, David Sommerseth wrote:
>> But we should consider if we want to make use of a JSON library
>> producing the JSON streams.  The reason is to ensure the output is
>> according to the specification and that escaping if contents is
>> consistent and proper.  Imagine if someone puts a double-quote into the
>> CN field of a certificate?
>>
>>  CN=3D"} Lets explode things, O=3DHacktivist0
>>
>> Or other characters which needs escaping.
>=20
> I'm not convinced we want to import a new library dependency and a heap
> of #ifdef for this.
>=20
> Escaping on *output* is pretty trivial ("characters from <this set>=20
> need to be encoded <like this>") - and as long as we do not need to parse=
=20
> *incoming* JSON, a full-blown new library is mainly adding complications
> (like, configure flags, #ifdefs, library version dependencies, ...).
>=20
> But you knew that this response would be coming :-)
Not surprised ;-)

But I do disagree.  I tend to dislike re-inventing wheels when others do
the job for you.  Quite some years ago, I would probably have agreed
with you.  But I've been in projects where I implemented producing XML
data manually in a similar manner.  After fixing numerous of escaping
errors, I switched to a library and all these bugs disappeared and never
came back.  It is so easy to think you know exactly what needs to be
escaped beforehand and firmly believe you have covered each corner-case,
but it always sneaks back at you - as you didn't spot the hidden doors.

And to me this feels like it actually contradicts our netlink discussion
on the Hackathon, where you initially wanted to use an external library
... ;-)

That said, json-c is packaged and available on Linux, FreeBSD and even
OpenWRT/LEDE got a recent version available. I don't know the situation
on macOS (but that's similar to FreeBSD, I'd presume) and Windows is
also not clear to me (if this is a relevant feature there).  json-c is
also fairly small (approx 7k lines of code, stripped binary lib ~60KB)
and is being maintained (last commits from late October).  So this isn't
a big massive dependency.

With ./configure --enable-json we also don't change the current
behaviour in OpenVPN.  Which should only require a single #ifdef
ENABLE_JSON in the multi_print_status() [multi.c:859] function.  But I
also see that the status printing stuff could be improved as well, to
simplify the implementation a bit too (which is a different task).


--=20
kind regards,

David Sommerseth
OpenVPN, Inc



--BF1EViL7ltfoO1IDrJ6jNp6063gD8wxAB--

--c01uq22o4MGRgsuKN3BiOnNLVCO1dXoeT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaCsvOAAoJEIbPlEyWcf3yjPkP/jNS9D6lljTII35qHZLsAA0h
Hwb/fJeU4oGwM19/ihv4ONaUuRXZyrmbgfL7ArOoNZKGaahsUiA4t0LiLI0wIMet
rZZzOAx3K1+y0HBNQexchR0cNA6zvkvlOUlc4dh5TH76PC2lP2w3yx//baIDoNXi
8xylVWp4bIatuoJEh7rXINcCRRMw94f3/Xd2tSy1kBrPLBR0DqBE3F7Akwr+hqp/
fqE9FCUX0tiVJeXhMrc40Wa3nGji8p0s0ZH/ZebwNIo1XB9nAoOS2Qp2Uib0kINL
z9hc8M1raXrFhGX43s21cm7wC7q00Crf+tVZGmNuKr8kgvjoSqTOgF0fmtpEc+xv
bhcCcsvnogAuWqLB4RFiP27jQkHBZgJPjAhbDZUX6evgasoQ+kZZN+YBwXIiBA1z
qso81Yb9IHnaG8CuwlAACeqHZpycmC6L6arfHSSuN4J9MMszinyNxN/jmeXxUTxm
fMvW/AL4BwBNQhP9/Mmf4730l2Ov/q/ZG4cip5EYkyUOaxvUQESMi72p+yX/PmDB
C3hpJl+sPZYMUHIwUiG06HYsDAzbmKULIIE+vVt1q3mKWp+FANN86cLwyDUMm9oJ
CjJ0hj6/fIeoY1wHoXQ/9JM8wzXfjUJAihV29NxRnzVQJtISNlzgmF/ki5Ei0rdi
ajXr/pS4GVyiQQo2TciD
=KQci
-----END PGP SIGNATURE-----

--c01uq22o4MGRgsuKN3BiOnNLVCO1dXoeT--

