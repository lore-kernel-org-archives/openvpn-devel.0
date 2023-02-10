Date: Fri, 10 Feb 2023 22:13:41 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y+azhVMqdJb/6gAN@...1296...>
References: <20230208001819.244694-3-arne@...1227...>
 <20230208005925.393200-1-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TJ1Zt9eSPnDgn55Z"
Content-Disposition: inline
In-Reply-To: <20230208005925.393200-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/3] Build unit tests in mingw
 Windows build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--TJ1Zt9eSPnDgn55Z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 07, 2023 at 07:59:25PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> - Minor changes to the build system to include some
>   dependencies for Windows build
>=20
> - test_tls_crypt not built as it will pull in win32.c and
>   its dependencies
>=20
> - If cross-compiling, "make check" will only build the tests but not
>   run any. Copy to Windows and run manually. Executables are in
>   <buid-dir>/tests/unit_tests/openvpn/.libs/ and these depend on
>   cmocka.dll in addition to openssl libs that some tests link to.

I am something wrong, or I'm missing some bits.

I took this patch, on top of commit e80720ef939 ("top of master as of
now").  MinGW on Ubuntu.  "autoreconf -iv", make clean, then
make && make check.

make check claims

make[4]: Entering directory '/home/gert/mingw/openvpn.git/tests'
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
All 0 tests passed
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

... but it seems to have done... nothing?

gert@...2713...:~/mingw/openvpn.git$ ls -l tests/unit_test/openvpn/.libs
ls: cannot access 'tests/unit_test/openvpn/.libs': No such file or directory

... given argv_testdriver exists, I should find "something" with argv*.o*
here...

gert@...2713...:~/mingw/openvpn.git$ find . -name "*argv*o"
./tests/unit_tests/openvpn/.deps/argv_testdriver-mock_get_random.Po
./tests/unit_tests/openvpn/.deps/tls_crypt_testdriver-argv.Po
./tests/unit_tests/openvpn/.deps/argv_testdriver-test_argv.Po
./tests/unit_tests/openvpn/.deps/argv_testdriver-mock_msg.Po
./tests/unit_tests/openvpn/.deps/argv_testdriver-platform.Po
./tests/unit_tests/openvpn/.deps/argv_testdriver-buffer.Po
./tests/unit_tests/openvpn/.deps/pkt_testdriver-argv.Po
./tests/unit_tests/openvpn/.deps/argv_testdriver-argv.Po
./src/openvpn/.deps/tls_crypt_testdriver-argv.Po
./src/openvpn/.deps/argv.Po
./src/openvpn/.deps/argv_testdriver-win32-util.Po
./src/openvpn/.deps/argv_testdriver-platform.Po
./src/openvpn/.deps/argv_testdriver-buffer.Po
./src/openvpn/.deps/pkt_testdriver-argv.Po
./src/openvpn/.deps/argv_testdriver-argv.Po
./src/openvpn/argv.o

... so it seems as if it did the "make depend" dance for the unit_tests,
but then didn't compile anything for real.


Did I apply stuff in the wrong order?  Do I need to more forcefully clean
my build tree?

slightly puzzled...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--TJ1Zt9eSPnDgn55Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJj5rOFAAoJEB2Cnv7KVigSZLsL/2S8E6pkmw4SlF2BXSAd3qMs
rpBOyAAuCnxgxWJaS5uabHypTw86/2kx/CnyYRCpQgUZwL28RfEXpoh8NnEey9nW
HyTFqnqJgTNuxV6TFEQebFn/UoOxW6t4k1uqKllJZPwcSP9SMigw+VB+CtVs6Qlo
jNY3UpmYcqqLUqDmPDGVYSCQNUGPNuqUOqaJ5x75mCFKDTsnt2Cb6MVX1bqXsqUK
ZSoDIqJYGP70UH4dDrDlYa9B3pE6kPlQo8JkCNWOYMz6eDV2gAxlUMOBrvpFZoah
prmHkKSBKyv4FFZDtN6VZOLAxCu9bJfPfEJY6C5W+DOUcelYIRBm/3+WFYSkVX3h
dEUFIHHYgRxnseWNfN/15us/YiF4rscgtDumkX7BdlnA9J71/SOyuYCmOxK3lw0y
178h06Qa7shr8LEIUd1swMH5SRrWiZNBrr6nTPJnYeoiCy7777nquecpS5lk99xc
LLEz23ow28hTHJtRX3iSi7/oK2ectJSaiAvNfwIU6w==
=MUXc
-----END PGP SIGNATURE-----

--TJ1Zt9eSPnDgn55Z--

