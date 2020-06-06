References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-4-James.Bottomley@...2316...>
 <31d467d4-59da-08b2-166b-13f62a59b82f@...1227...>
 <1591374528.4728.53.camel@...2316...>
 <1591377595.4728.67.camel@...2316...>
 <47ddb948-d12f-6372-1ca9-34b70dee3f25@...1227...>
 <20200606084110.GY1431@...1296...>
 <fe88bc2f-948d-d0c1-8969-b81ccfe1dba2@...1227...>
 <20200606112817.GZ1431@...1296...>
 <1591456971.3589.12.camel@...2316...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <348ac979-6c70-abba-e6d0-66e125391434@...1227...>
Date: Sat, 6 Jun 2020 18:20:43 +0200
MIME-Version: 1.0
In-Reply-To: <1591456971.3589.12.camel@...2316...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ycTahZ2KhEKhPBVGEknvUG89eqIjqUCTv"
Subject: Re: [Openvpn-devel] [PATCH v6 3/3] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2316...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ycTahZ2KhEKhPBVGEknvUG89eqIjqUCTv
Content-Type: multipart/mixed; boundary="OHNH8t9EAgm5rSG5a4iUg06SoooRT5yAA"

--OHNH8t9EAgm5rSG5a4iUg06SoooRT5yAA
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 06.06.20 um 17:22 schrieb James Bottomley:
> On Sat, 2020-06-06 at 13:28 +0200, Gert Doering wrote:
>> Hi,
>>
>> On Sat, Jun 06, 2020 at 12:43:10PM +0200, Arne Schwabe wrote:
>>>> Naive question - can we not just use a .so on Mac?  Like,
>>>> consistent, build .so, request .so from openssl.cnf?
>>>
>>> I thought I tested that and it didn't work but I tested it again
>>> and that also works.
>>
>> Then let's just do that, and simplifiy the test stuff :-)
>>
>> (Building a "production quality" OpenSSL engine would need to do what
>> the platform wants, but for "this is really just to test the OpenVPN
>> code", I think "less autoconf hoops is better")
>=20
> Well, I am intellectually curious since I maintain the TPM engine for
> openssl.  But Macs don't have TPMs so no-one is ever going to complain
> ...
>=20
> The only remaining problem is the lack of environment variable support
> in MAC openssl which I'll fix by using the absolute path.  If it works
> I think below is the replacement patch.
>=20

Looks more like one step forward, two back:
openssl.cnf absolute path looks good:

dynamic_path	=3D
/Users/arne/oss/openvpn-ossl/tests/unit_tests/engine-key/.libs/libtestengin=
e.so

But now it has .so there. Alos the .libs directory now has neither .so
nor .dylib


engine-key% find .
.
./libtestengine_la-libtestengine.o
./Makefile
./libtestengine.la
./libtestengine_la-libtestengine.lo
./openssl.cnf
./log.txt
./.deps
./.deps/libtestengine_la-libtestengine.Plo
./.libs
./.libs/libtestengine_la-libtestengine.o
./.libs/libtestengine.la
./.libs/libtestengine.a
./passwd
./client.key


(This is an out of tree build so only generated files here)

Make log:

make check
[...]
Making check in engine-key
Makefile:451: .deps/libtestengine_la-libtestengine.Plo: No such file or
directory
/Applications/Xcode.app/Contents/Developer/usr/bin/make  libtestengine.la
/bin/sh ../../../libtool  --tag=3DCC   --mode=3Dcompile clang
-DHAVE_CONFIG_H -I.
-I../../../../openvpn-git/tests/unit_tests/engine-key -I../../..
-I../../../include    -I/usr/local/opt/openssl@...2560.../include
-I../../../../openvpn-git/include
-I/usr/local/Cellar/cmocka/1.1.5/include -I -I -Wall
-Wno-unused-parameter -Wno-unused-function -O2 -g -Wall -std=3Dc99 -MT
libtestengine_la-libtestengine.lo -MD -MP -MF
.deps/libtestengine_la-libtestengine.Tpo -c -o
libtestengine_la-libtestengine.lo `test -f 'libtestengine.c' || echo
'../../../../openvpn-git/tests/unit_tests/engine-key/'`libtestengine.c
libtool: compile:  clang -DHAVE_CONFIG_H -I.
-I../../../../openvpn-git/tests/unit_tests/engine-key -I../../..
-I../../../include -I/usr/local/opt/openssl@...2560.../include
-I../../../../openvpn-git/include
-I/usr/local/Cellar/cmocka/1.1.5/include -I -I -Wall
-Wno-unused-parameter -Wno-unused-function -O2 -g -Wall -std=3Dc99 -MT
libtestengine_la-libtestengine.lo -MD -MP -MF
.deps/libtestengine_la-libtestengine.Tpo -c
../../../../openvpn-git/tests/unit_tests/engine-key/libtestengine.c
-fno-common -DPIC -o .libs/libtestengine_la-libtestengine.o
libtool: compile:  clang -DHAVE_CONFIG_H -I.
-I../../../../openvpn-git/tests/unit_tests/engine-key -I../../..
-I../../../include -I/usr/local/opt/openssl@...2560.../include
-I../../../../openvpn-git/include
-I/usr/local/Cellar/cmocka/1.1.5/include -I -I -Wall
-Wno-unused-parameter -Wno-unused-function -O2 -g -Wall -std=3Dc99 -MT
libtestengine_la-libtestengine.lo -MD -MP -MF
.deps/libtestengine_la-libtestengine.Tpo -c
../../../../openvpn-git/tests/unit_tests/engine-key/libtestengine.c -o
libtestengine_la-libtestengine.o >/dev/null 2>&1
mv -f .deps/libtestengine_la-libtestengine.Tpo
.deps/libtestengine_la-libtestengine.Plo
/bin/sh ../../../libtool  --tag=3DCC   --mode=3Dlink clang
-I/usr/local/opt/openssl@...2560.../include   -I../../../../openvpn-git/inc=
lude
-I/usr/local/Cellar/cmocka/1.1.5/include -I -I -Wall
-Wno-unused-parameter -Wno-unused-function -O2 -g -Wall -std=3Dc99
-L/usr/local/opt/openssl@...2560.../lib -lcrypto -lssl
-L/usr/local/Cellar/cmocka/1.1.5/lib -lcmocka -avoid-version -module
-shared -export-dynamic  -o libtestengine.la
libtestengine_la-libtestengine.lo  -lresolv
libtool: link: ar cru .libs/libtestengine.a
.libs/libtestengine_la-libtestengine.o
libtool: link: ranlib .libs/libtestengine.a
libtool: link: ( cd ".libs" && rm -f "libtestengine.la" && ln -s
"../libtestengine.la" "libtestengine.la" )
/Applications/Xcode.app/Contents/Developer/usr/bin/make  check-TESTS
sed
"s|SHREXT|.so|;s|ABSBUILDDIR|/Users/arne/oss/openvpn-ossl/tests/unit_tests/=
engine-key|"
< ../../../../openvpn-git/tests/unit_tests/engine-key/openssl.cnf.in >
openssl.cnf


--OHNH8t9EAgm5rSG5a4iUg06SoooRT5yAA--

--ycTahZ2KhEKhPBVGEknvUG89eqIjqUCTv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7bwlsACgkQFRhsZwKx
RFTJ8Q//TcDZyXfbGqUjG60hIPRAqjQ2ZMFQ/4I6FMoBM6cCQ/qAWyH9OAaB3PUl
EFJpjhPTRm4m5EGmU9pdnHbhziqcnFZk13TCBbJ0ISUDdTb2j+Q0VgFeLPJL/1SZ
9wIbTdBrLI9nlr2mDcKpgMrjljgdPXRf3djyCqAWbwDmSBPZUnCtRerlXJn1zzhw
qibtCIPB2LEUUaFryl1ohnlKXqPBdzY+IIMu3/Smc5Q6fNCi21uGZZ+fnpCpIQ29
VPJUssChbdK7hbestzB7jbMYMNIvQ9jA6zdiuxGP95ygxo5jD2xrLrk+PT4Ba41q
ZdfRmmeomEJq2kA04VMIXEsHguwPN/8JkS8ZZVN/yeDjDQQN9t85Lx8YINLiqeOA
kvc78KzChGUXOGEu1Gm3lrKb6uLnOl8V5wd372madcvJsw7AihcZmF7lW3TUXz9s
T9suPYzlKCeaa2i45ufCeQV0oGxZFMXIf34pbabG8vTlv9r4F9RnCYntU0egCDKF
mJWaLRgbxSc1staUuc4Dr6154dj9yda0s5RHrfVpRPzZd/S0lt7Ubsh5YP01IyVk
SoQIWQheA4x6xpORHZX2J56B1d7skwYkgeWb3gGu8W38wZ3f3+FEU5jdiQgsV2h6
XcKhxeTNytRZgDQ0AxDo+nC1v5pz1EeEkBvwV3W4vz7btbkpvRE=
=FcD5
-----END PGP SIGNATURE-----

--ycTahZ2KhEKhPBVGEknvUG89eqIjqUCTv--

