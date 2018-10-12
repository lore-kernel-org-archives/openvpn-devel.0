Reply-To: openvpn-devel@lists.sourceforge.net
References: <20180821220842.4193-1-steffan@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c47c98fc-7c75-8dcf-555d-e934fb70d702@...2080...>
Date: Fri, 12 Oct 2018 13:43:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180821220842.4193-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hyGvX7Rht1QPUisN9HP9CwaE9ILpJKMjF"
Subject: Re: [Openvpn-devel] [PATCH] cmocka: use relative paths
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hyGvX7Rht1QPUisN9HP9CwaE9ILpJKMjF
Content-Type: multipart/mixed; boundary="PwfZHbjqEK8bcQvBeDC8E9DeHvR04O3am";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <c47c98fc-7c75-8dcf-555d-e934fb70d702@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] cmocka: use relative paths
References: <20180821220842.4193-1-steffan@...1856...>
In-Reply-To: <20180821220842.4193-1-steffan@...1856...>

--PwfZHbjqEK8bcQvBeDC8E9DeHvR04O3am
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 22/08/18 00:08, Steffan Karger wrote:
> Simplifies the build scripts, and fixes my CI, where paths on the test
> slave can be different from paths on the build slave.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  configure.ac       | 11 ++---------
>  vendor/Makefile.am | 15 +++++++--------
>  2 files changed, 9 insertions(+), 17 deletions(-)

This fails on my system ...

---------------------------------------------------
$ rm -rf vendor/cmocka/
$ mkdir vendor/cmocka/
$ git submodule init
$ git submodule update
Submodule path 'vendor/cmocka': checked out 'b2732b52202ae48f866a024c633466=
efdbb8e85a'
$ autoreconf -vi
[....]
$ ./configure
[....]
$ make check
[....]
mkdir -p ./cmocka ./dist
(cd cmocka && cmake -DCMAKE_INSTALL_PREFIX=3D.././dist .././cmocka && make =
&& make install)
-- The C compiler identification is GNU 4.8.5
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Performing Test WITH_FPIC
-- Performing Test WITH_FPIC - Success
-- Performing Test WITH_STACK_PROTECTOR
-- Performing Test WITH_STACK_PROTECTOR - Success
CMake Error at cmake/Modules/MacroEnsureOutOfSourceBuild.cmake:13 (message):
  cmocka requires an out of source build.  Please create a separate build
  directory and run 'cmake /path/to/cmocka [options]' there.
Call Stack (most recent call first):
  CMakeLists.txt:41 (macro_ensure_out_of_source_build)


CMake Error at cmake/Modules/MacroEnsureOutOfSourceBuild.cmake:14 (message):
  Remove the file CMakeCache.txt in
  /home/davids/devel/OpenVPN/openvpn/vendor/cmocka first.
Call Stack (most recent call first):
  CMakeLists.txt:41 (macro_ensure_out_of_source_build)


-- Configuring incomplete, errors occurred!
---------------------------------------------------

This patch had to be rebased on top of the latest git master, where the
merge conflict had the additional ${OPTIONAL_CRYPTO/PKCS11..} variables
in TEST_LDFLAGS and TEST_FLAGS which commit b081038c7464f7a916560b4
had brought in.  So that shouldn't really be  the cause of this error.

And for reference:

$ rpm -q cmake
cmake-2.8.12.2-2.el7.x86_64


--
kind regards,

David Sommerseth
OpenVPN Inc



--PwfZHbjqEK8bcQvBeDC8E9DeHvR04O3am--

--hyGvX7Rht1QPUisN9HP9CwaE9ILpJKMjF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbwIjQAAoJEIbPlEyWcf3yis4QAK4ALdvwzFoiMP7p62oYK0nL
F8r/iMFXxVpXv5CydQnS7NYkkv3zhretGH+l1OAVVm87YHar0m107fJulhXic/FC
c7aUubl1ejI2Fjn06nemIhqYizAf0q5U0stUV2yLe5O3yXZWtsfjjF7oGlO0CeFk
6mu6OihgSgmCgtNNBy0rxrhWnAGEegj/z+z+8AVoMO2ALfVlXUoDVqhq85/SAAkc
/giz3blsoLHCwUzkyJiucvPDv0Fxnq+S3B0TMATldPqWU2jX8b7IaEYni0y48lsd
1nyYHRLS0h09W8o/GFmnV6+4wy2WMrpeOKANMLySg2T0usZIOta4bHgA4nGBTgWC
vsd9r7YZSDcsHZho3ukJ06hOebRO7awB7TR4Oxd9FCOXBuUFyuvaMML+o729U1Et
IpVQLr2lWG6cWCHM7URTWPikU/nvj/ryUiYKhHDJXMZICCvJviii4aDKMhWrK/AQ
2v57bYdSx3eIGQp5XS5HRU/Y1ok4GIopk5kX9g0rMo04NzaLf1bTlvP+RKF5GMnM
H3Mz8oTyUqMqBuukoWUsyhFU1a2TTJKF6X07lUl3I8AXt/ZzDWibME7GrHr6LySm
diy0eMbreTEs2xJBorfgadW+O5z18awKDLIFVy9gNmy3BZUg2NtG04nbc0jynAlC
394afeXxo1RsMqqSjTmH
=B4+J
-----END PGP SIGNATURE-----

--hyGvX7Rht1QPUisN9HP9CwaE9ILpJKMjF--

