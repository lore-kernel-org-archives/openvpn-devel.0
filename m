References: <20170413172609.29093-1-davids@...515...>
	<20170421220728.31867-1-davids@...515...>
	<258342e4-0ba9-cae0-0e23-88a4aab0eacc@...1856...>
	<20170422112928.GA30424@...1296...>
	<cf8eba0b-95ee-23b5-575c-43418a9a0fd6@...2080...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <82ea4aba-7a68-0f59-163c-b184bc183f6d@...1856...>
Date: Sun, 23 Apr 2017 10:12:33 +0200
MIME-Version: 1.0
In-Reply-To: <cf8eba0b-95ee-23b5-575c-43418a9a0fd6@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UqKQX1R5dD5J51NLt0BF9E0N47IlOq0ru"
Subject: Re: [Openvpn-devel] [PATCH v4] Fix broken ./configure on systems
 without openssl.pc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UqKQX1R5dD5J51NLt0BF9E0N47IlOq0ru
Content-Type: multipart/mixed; boundary="QlMCrGw2EoHLnB1Bhok68eGWjS1ULIWRu"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>
Message-ID: <82ea4aba-7a68-0f59-163c-b184bc183f6d@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v4] Fix broken ./configure on systems
	without openssl.pc
References: <20170413172609.29093-1-davids@...515...>
	<20170421220728.31867-1-davids@...515...>
	<258342e4-0ba9-cae0-0e23-88a4aab0eacc@...1856...>
	<20170422112928.GA30424@...1296...>
	<cf8eba0b-95ee-23b5-575c-43418a9a0fd6@...2080...>
In-Reply-To: <cf8eba0b-95ee-23b5-575c-43418a9a0fd6@...2080...>

--QlMCrGw2EoHLnB1Bhok68eGWjS1ULIWRu
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable


On 22-04-17 17:27, David Sommerseth wrote:
> On 22/04/17 13:29, Gert Doering wrote:
>> On Sat, Apr 22, 2017 at 08:28:33AM +0200, Steffan Karger wrote:
>>>> v4 - Move the CFLAGS/LDFLAGS declarations before the manual
>>>>      version test; otherwise we're still testing the system install
>>>>      version
>> [..]
>>> This looks good now, ACK.
>>
>> I'm not exactly sure what happened here in v4 - but now it's broken for
>> "just run configure, with no extra WITH_OPENSSL_* arguments" (on a syste=
m=20
>> without pkgconfig).  So, NAK, as annoying as you'll surely find me :-/
>>
>> It does the version check just fine...
>>
>> configure:16566: checking additionally if OpenSSL is available and versi=
on >=3D 1.
>> 0.1
>> configure:16587: cc -c -g -O2 -std=3Dc99   conftest.c >&5
>> configure:16587: $? =3D 0
>> configure:16588: result: ok
>>
>> ... and then it tests for SSL_CTX_new, omitting the -lssl/-lcrypto bits:
>>
>> configure:16601: checking for SSL_CTX_new
>> configure:16601: cc -o conftest -g -O2 -std=3Dc99    conftest.c   >&5
>> /var/tmp/conftest-e1c536.o: In function `main':
>> /home/gert/src/openvpn-maint/test-build-master-fbsd/conftest.c:193: unde=
fined re
>> ference to `SSL_CTX_new'
>> cc: error: linker command failed with exit code 1 (use -v to see invocat=
ion)
>>
>>
>> ... failing.
>>
>> This is on FreeBSD 10.3, with the system libs, having pkg-config install=
ed,=20
>> but no openssl.pc:
>>
>> configure:16509: $PKG_CONFIG --exists --print-errors "libcrypto >=3D 1.0=
.1, libssl
>>  >=3D 1.0.1"
>> Package libcrypto was not found in the pkg-config search path.
>> Perhaps you should add the directory containing `libcrypto.pc'
>> to the PKG_CONFIG_PATH environment variable
>> Package 'libcrypto', required by 'virtual:world', not found
>> Package 'libssl', required by 'virtual:world', not found
>>
>> (not sure if this is related, but maybe the configure code path for
>> "pkg-config exists" is different from "no pkg-config found")
>>
>>
>> On Linux, with pkg-config + openssl.pc, it works fine:
>>
>> configure:16601: checking for SSL_CTX_new
>> configure:16601: gcc -o conftest -g -O2 -std=3Dc99    conftest.c  -lcryp=
to -lssl
>>> &5
>> configure:16601: $? =3D 0
>> configure:16601: result: yes
>>
>> (-lcrypto -lssl present, though I wonder why it's putting -lcrypto=20
>> first - dependency order should have -lssl first)
>=20
> I will dig further into this an submit a v5.  Gee, this autotools stuff
> can be fragile.  Each time I fight with autotools, I think of migrating
> to CMake.  But each time I struggle with CMake, I think of migrating to
> autotools.  I so wonder if there are some sane alternatives - somewhat,
> I doubt so :/

Gah, of course.

Two things:

1) The OPENSSL_LIBS=3D${OPENSSL_LIBS:--lssl -lcrypto} line should be at
the old location, and the new one should go.  That's why it now fails on
systems without pkg-config or _LIBS set manually.

2) The incorrect linking order is related to the stuff from ticket #863.
 "[libcrypto >=3D 1.0.1, libssl >=3D 1.0.1]" should be replaced with
"[openssl >=3D 1.0.1]".  I was waiting for this patch to get through
before sending a follow-up patch for that, but I'm fine with integrating
that into this patch too.

-Steffan


--QlMCrGw2EoHLnB1Bhok68eGWjS1ULIWRu--

--UqKQX1R5dD5J51NLt0BF9E0N47IlOq0ru
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY/GH1AAoJEJgCyj0AftKI1J8IAKi4UeiuH6EczRKOQ1pEQmEh
6yQ0HLdKJV1G1yztRadnsuNJiHDPmkAbcXmSACU+UQD8nu/IYhh2ttMRHaEFV5s7
BbnD2lFRcNkhSBBsAgmvSeaSBPOAHjF0WHzXinLICb1jIwESn4UY4RX/iTISAxj5
XWgrT04S0Z0cjGPhZ7fJYoVMmGgWnhrWFFEDWbduCHmFxvDwCkLQLiX2obt/F8da
zHnvt6HWz1vE7ttvgHDh/CRvw16xMTbhH6hBcJJ/zTniy5pkm1eNfPX76dVsSsVG
rFOrwY0BksBYVI6Am2yuQLNmM3fsXnMTM7anB1nqjVfYAHLh14KWjE3xKTXdYo8=
=0IDL
-----END PGP SIGNATURE-----

--UqKQX1R5dD5J51NLt0BF9E0N47IlOq0ru--

