References: <20191116102835.22883-1-arne@...1227...>
 <2ce5e07d-ac3d-4034-c2e1-56a00cb332bc@...2080...>
 <20200328113327.GO1431@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <172c2cf6-c27e-4b53-7867-83a01fb16b60@...2080...>
Date: Sun, 29 Mar 2020 23:54:36 +0200
MIME-Version: 1.0
In-Reply-To: <20200328113327.GO1431@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="l89nJe8zlhxGzkqDIfsVBxUA6jzOBu7C4"
Subject: Re: [Openvpn-devel] [PATCH] Reformat all source files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l89nJe8zlhxGzkqDIfsVBxUA6jzOBu7C4
Content-Type: multipart/mixed; boundary="I21nTQfjvKQKovYYwG9SWFDkwG1nLnEer";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <172c2cf6-c27e-4b53-7867-83a01fb16b60@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Reformat all source files
References: <20191116102835.22883-1-arne@...1227...>
 <2ce5e07d-ac3d-4034-c2e1-56a00cb332bc@...2080...>
 <20200328113327.GO1431@...1296...>
In-Reply-To: <20200328113327.GO1431@...1296...>

--I21nTQfjvKQKovYYwG9SWFDkwG1nLnEer
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28/03/2020 12:33, Gert Doering wrote:
> Hi,
>=20
> On Fri, Mar 27, 2020 at 04:24:00PM +0100, David Sommerseth wrote:
>> On 16/11/2019 11:28, Arne Schwabe wrote:
>>> Over time some patches slipped in that were not 100% complient to uncru=
stify
>>> This rerun fixes those issues
> [..]
>> Only done quick code review and RHEL-7 build.  Changes looks reasonable =
and is
>> by far closer to what I would expect our coding style to look like.
>>
>> Acked-By: David Sommerseth <davids@...515...>
>=20
> ... but it does not apply to current git master...?
>=20
> Applying: Reformat all source files
> error: patch failed: src/openvpn/tun.c:3418
> error: src/openvpn/tun.c: patch does not apply
> Patch failed at 0001 Reformat all source files

Ahh, sorry ... I did the reviews based on Arne's github tree [1], so I could
compile test them.  And I trust him enough to not do any stupid stunts in h=
is
tree.  His icsopenvpn branch has all of the stuff I've reviewed; that branch
rebased against our latest master without any hickups.

Unfortunately git apply is (rightfully) super picky about conflicts.

Not sure now what would be the best approach forward. Picking the commit
contents from a rebased icsopenvpn branch would be one way (I can provide
commitish references I reviewed, if needed).  Another approach is for Arne =
to
resend rebased patches to ML.

As we have several patch series lingering in our mail queue, we should look=
 at
alternatives pulling in patches which would go smoother and allow a better
flexibility for all of us (submitter, reviewer and committer) while keeping
the review and commit process decentralized.  But that's a longer discussion
we need to take in a different place than this thread.


[1] <https://github.com/schwabe/openvpn>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--I21nTQfjvKQKovYYwG9SWFDkwG1nLnEer--

--l89nJe8zlhxGzkqDIfsVBxUA6jzOBu7C4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJegRklAAoJEIbPlEyWcf3y6XAP/R0AU7p7mC3fGIoOBkaJp9Ol
TZqr5gz2JuQdZUIHYmzitvuBtI4Trtafv9TlgaiGFXktNmcFi+bAytvmnLxkvXx7
9+TdgUTDavqmhgDOskImskikKU/1P5h38zE2KOeLkH1fOSwqoxjSFgupOxBWoqZz
HjZfTyMJTftCdAoRf1vw+h8U57MPVnumJleaYFERXgpD7tZ0JxUsVATBEhlyfdGL
Jxd41zTvcLyLWMdjV35Xb3q/mkLQTIhSRn4Yj/9tikS1Gn6jvPhtGklDCmcO40F/
C3KBJgM2pcJtZQm8gghD0L88t8RtFssIlznGSy86QouAz1qfXCtbAhVYXQqozJsM
u8q3ZdlzLnALmEG+q2HZ4O0uUMnymJq8J0w47E4gSnYM0r2ac2U/n+YXuda5we8W
Yuondr4tNnqfoiz3E4fDdhdPdyVayA0WnutId8yOJOZ7XrictQUIgsQtyk/HkRGB
UIFFB3t6y8mG5urF6ZLT65o+ghhf77WyGP8m2VfRD07U2TzEcl3AfX9p3EA5mTeZ
7/KPrdpSjb2vUFqILqql4Unk0iFZiPSnbF1TC8lm0wkbhB2Y+LfaaWBb3LmTiV0w
hUGEugMBRBazGs41ZiumRGypEyG7ZIOhHgazF6hK4fOsmOL2E+q1+AdOl92KSJPl
FQClDd1LKCpG5cohBRXs
=TwaB
-----END PGP SIGNATURE-----

--l89nJe8zlhxGzkqDIfsVBxUA6jzOBu7C4--

