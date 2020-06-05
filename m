References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-4-James.Bottomley@...2316...>
 <31d467d4-59da-08b2-166b-13f62a59b82f@...1227...>
 <1591374528.4728.53.camel@...2316...>
 <1591377595.4728.67.camel@...2316...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <47ddb948-d12f-6372-1ca9-34b70dee3f25@...1227...>
Date: Sat, 6 Jun 2020 00:48:36 +0200
MIME-Version: 1.0
In-Reply-To: <1591377595.4728.67.camel@...2316...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PIuPvrmYRzVFUSGIB1fD9lphg1QvSgA2w"
Subject: Re: [Openvpn-devel] [PATCH v6 3/3] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2316...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PIuPvrmYRzVFUSGIB1fD9lphg1QvSgA2w
Content-Type: multipart/mixed; boundary="3onQ529SCefJx95JoEPXG8wnY4NnnP0a8"

--3onQ529SCefJx95JoEPXG8wnY4NnnP0a8
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 05.06.20 um 19:19 schrieb James Bottomley:
> On Fri, 2020-06-05 at 09:28 -0700, James Bottomley wrote:
>> On Fri, 2020-06-05 at 13:31 +0200, Arne Schwabe wrote:
>> [...]
>>> Somehow this turns into a autoconf/automake nightmare:
>>
>> Heh, got to say autoconf is a bit of a nightmare for its more
>> esoteric features because the docs usually don't cover them and you
>> end up having to take the opinion of the internet, which is somewhat,
>> er, diverse.
>>
>>> [testengine_section]
>>> dynamic_path	=3D $ENV::srcdir/.libs/libtestengine`test .odule
>>> =3D .yes SHREXTSHREXT echo .so || echo .dylib`
>>>
>>> is what I end up in the openssl.cnf
>>>
>>> The generated Makefile already has:
>>>
>>> $(builddir)/%.cnf: $(srcdir)/%.cnf.in
>>>  	sed 's/SHREXT/`test .$module =3D .yes && echo .so || echo
>>> .dylib`/' < $< $@
>>
>> Hm, so SHREXT is dynamic on MAC platforms.  If I replace the single
>> quote with double, that should allow the shell expansion.
>=20
> The internet thinks the fix is to add eval to the hunk in configure.ac:
>=20
> eval shrext=3D$shrext_cmds
> AC_SUBST([shrext])
>=20
> I tried it out and it seems to work.

[testengine_section]
dynamic_path	=3D $ENV::srcdir/.libs/libtestengine.dylib

Yes, works here.

>=20
>>> Maybe instead of using that use magic useing two different section
>>> like testengineso and testenginedylib and then makeing the engine
>>> name in the script dynamic?
>>
>> I'll investigate, but openssl has a fairly tight binding between the
>> name of the dynamic object and the name of the engine.  It's very
>> difficult (but not I perhaps impossible) to have an engine name
>> different from the DSO name.
>>
>>> Also for some reason the makefile still builds it now as .so
>>> instead
>>> of .dylib
>>
>> That's likely a libtool flag issue.  If you update this in
>> Makefile.am:
>>
>> libtestengine_la_LDFLAGS =3D -rpath /lib -avoid-version -module -shared
>> -export-dynamic
>>
>> does it build a .dylib?
>=20
> So if this works, with the eval above and full path substitution in the
> openssl.cnf.in I think I might have a solution.

Unfortunately not. Still creates the .so file.  If everything fails we
might just do a if mac then cp from .so to .dylib as part of the test
run. It is ugly but might be better than to wait forever on this patch.

Arne


--3onQ529SCefJx95JoEPXG8wnY4NnnP0a8--

--PIuPvrmYRzVFUSGIB1fD9lphg1QvSgA2w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7ay8QACgkQFRhsZwKx
RFTv6RAAsk+omVwF++zRigFbvJC9uKo1fKhKnKVOwR8YlkkasEbvUbCtf1Lw5GKL
/Ggz1NeH6smOf4PyTCUM+4mtSCduxnBzseQG3W9kmxVuKUCZYBBfuy7WHwUM4At2
8zRi0L+fOy3QA7iP22gUkZ5WKFcl3PBNGfOBgZtf5CIH2V2gib1fMwfxTy9dkI5a
HNeTvIDUSoi6hBQAfSvGwtU9sseKx7stBDHrFmeuLa8YJb08pklNZgLnydSKHxKn
cwxrVeb1KwVjIQMdYy9WIk9SImAjAq8A/Qe+dvtQEm9bQ4Q/Maf9TiW5nHtHYkzn
qb/WBaVXtGVe5R1IgopyTV3ZtEHS6wmthcO86UV4GQu3nRx/sPN3NjzvyarzO+/N
dA4HMn9j16GE6jxTDPcXwG+CpFblJn3ovpNpgmbl5iASzcMTm/YpSo/upgwpgpu4
B04DDT7xUN21XzvDOED2Y23tpdr5+h1+Id11b2cUCwRtU/DQbz1C8GbgJsaMFbJC
OrXqAbQac4aujKLoX944AQ0C99wKR0LMEU383O+haDImZH2u2zcEx+M4RZmdE6cO
Anr7i/VIkTbw0pOWt5+oF2tachPX67Qo0NwVCZPVNR1y04LBnVnw5rQ67vZZRoWR
aI0/4beqAVozSrqHRe2embfIOWr5Sw+KLdtpdC3NZ6VGLUe+Rdg=
=gi8a
-----END PGP SIGNATURE-----

--PIuPvrmYRzVFUSGIB1fD9lphg1QvSgA2w--

