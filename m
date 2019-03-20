Date: Wed, 20 Mar 2019 12:40:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20190320114026.GW962@...1296...>
References: <20190311133620.18278-3-chipitsine@...277...>
 <201903181900.x2IJ01hV043882@...2054...>
 <CAFHpkQHGchzS8_=sxVZEi5V20VLCEFuv2dSDZYM1bsaQKmcrvA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="O+m0AVbsNU64TeWp"
Content-Disposition: inline
In-Reply-To: <CAFHpkQHGchzS8_=sxVZEi5V20VLCEFuv2dSDZYM1bsaQKmcrvA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: travis-ci: change trusty
 image to xenial
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--O+m0AVbsNU64TeWp
Content-Type: multipart/mixed; boundary="s2DZqDUwsJbKKj+e"
Content-Disposition: inline

--s2DZqDUwsJbKKj+e
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 19, 2019 at 01:18:37AM +0500, ???????? ?????????????? wrote:
> can we apply it to 2.4 as well ?
> ubuntu trusty is EOL soon

Steffan ACKed merging it into 2.4 as well.  For brevity I squashed the
three commits to the same file into one, which is appended below.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--s2DZqDUwsJbKKj+e
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-travis-ci-add-linux-ppc64le-to-build-matrix-change-t.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 6a5c9bb146061e3331a9000405c84150c8bad310 Mon Sep 17 00:00:00 2001
=46rom: Ilya Shipitsin <chipitsine@...277...>
Date: Mon, 11 Mar 2019 18:36:18 +0500
Subject: [PATCH] travis-ci: add "linux-ppc64le" to build matrix, change tru=
sty
 image to xenial, update osx to xcode9.4 and modernize brew management

Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
Acked-by: Steffan Karger <steffan.karger@...1435...>
Message-Id: <20190311133620.18278-2-chipitsine@...277...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18=
271.html
Signed-off-by: Gert Doering <gert@...1296...>
(cherry picked from commit 27fb43da6f86eda7a6e5a033e060cab5be0cdbe9)

Ubuntu Trusty reaches End of Life on April 30, 2019
Let us switch to xenial. Also, it simplifies mingw builds.
We do not need to add xenial mingw manually anymore

Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
Acked-by: Steffan Karger <steffan.karger@...1435...>
Message-Id: <20190311133620.18278-3-chipitsine@...277...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18=
270.html
Signed-off-by: Gert Doering <gert@...1296...>
(cherry picked from commit 4ca813798af89997441bc35723ed1995b6b269e1)

osx image used for builds, i.e. xcode7.3 is outdated, we
can switch to "default" xcode9.4 and use more fast brew
travis-ci plugin

Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
Acked-by: Steffan Karger <steffan.karger@...1435...>
Message-Id: <20190311133620.18278-4-chipitsine@...277...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18=
269.html
Signed-off-by: Gert Doering <gert@...1296...>
(cherry picked from commit 2cae16aae55dd1ef2ae41c36bec752db34ab4695)
---
 .travis.yml           | 21 ++++++++-------------
 .travis/build-deps.sh |  9 ---------
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 62587d28..d7aff06e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,5 +1,5 @@
 sudo: required
-dist: trusty
+dist: xenial
=20
 os: linux
=20
@@ -33,6 +33,9 @@ matrix:
     - env: SSLLIB=3D"openssl" OPENSSL_VERSION=3D"1.1.0f"
       os: linux
       compiler: gcc
+    - env: SSLLIB=3D"openssl" OPENSSL_VERSION=3D"1.1.0h" LABEL=3D"linux-pp=
c64le"
+      os: linux-ppc64le
+      compiler: gcc
     - env: SSLLIB=3D"openssl" CFLAGS=3D"-fsanitize=3Daddress"
       os: linux
       compiler: clang
@@ -47,11 +50,9 @@ matrix:
       compiler: clang
     - env: SSLLIB=3D"openssl"
       os: osx
-      osx_image: xcode7.3
       compiler: clang
     - env: SSLLIB=3D"mbedtls"
       os: osx
-      osx_image: xcode7.3
       compiler: clang
     - env: SSLLIB=3D"openssl" CHOST=3Dx86_64-w64-mingw32 OPENSSL_VERSION=
=3D"1.0.1u"
       os: linux
@@ -76,12 +77,10 @@ matrix:
=20
 addons:
   apt:
-    packages:
-      - liblzo2-dev
-      - libpam0g-dev
-      - liblz4-dev
-      - linux-libc-dev
-      - man2html
+    update: true
+    packages: [ liblzo2-dev, libpam0g-dev, liblz4-dev, linux-libc-dev, man=
2html, mingw-w64]
+  homebrew:
+    packages: [ lzo ]
=20
 cache:
   directories:
@@ -89,10 +88,6 @@ cache:
   - ${HOME}/opt
   - ${HOME}/Library/Caches/Homebrew
=20
-before_install:
-  - if [ "${TRAVIS_OS_NAME}" =3D "osx" ]; then brew update     ; fi
-  - if [ "${TRAVIS_OS_NAME}" =3D "osx" ]; then brew install lzo; fi
-
 install:
   - if [ ! -z "${CHOST}" ]; then unset CC; fi
   - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log && =
exit 1)
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
index 96a030cc..391b35ef 100755
--- a/.travis/build-deps.sh
+++ b/.travis/build-deps.sh
@@ -130,15 +130,6 @@ build_openssl () {
     fi
 }
=20
-if [ ! -z ${CHOST+x} ]; then
-      #
-      # openvpn requires at least mingw-gcc-4.9, which is available at xen=
ial repo
-      #
-      sudo apt-add-repository "deb http://archive.ubuntu.com/ubuntu xenial=
 main universe"
-      sudo apt-get update
-      sudo apt-get -y install dpkg mingw-w64
-fi
-
 # Download and build crypto lib
 if [ "${SSLLIB}" =3D "openssl" ]; then
     download_openssl
--=20
2.18.0


--s2DZqDUwsJbKKj+e--

--O+m0AVbsNU64TeWp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJckiapAAoJEB2Cnv7KVigSZcUL/i/PvGpnfG7p7Y4Ax/qcFaPd
Ze6RicD17Nc6+ELHOSCDVezdFjqMMMQJpMDot9aGSaG47X6IrRXHvWLpJ3ElUDi2
yrBS5h76nVs6TwVmfe3vTWoaqE0h48mAEPyEz9VW2tfYM7rx+qYrFkhPtcFdkTE1
Qh6AW1+O2EEyw3oxVlpVO9nswF5ZBp/vXO9ewSLaVtAXfsEr0BHyzAIOX4kYg5vh
VDbx6wmppVXVW3Kd4etJo44P00JUcuPKKHHCpQi6Y2FI6eM4LhCYzLvEfm+LY98C
XvJnVgi4DpBPBlfKGg/z8rrXYt7X2TydPg12pzdSvB8xImvMCQM/GltARtwYbNMv
WPNHo8Bg96B2HkUD3sqOKJIg7FSO7QZuntHQnJ3KLU992Xl798ZOvZ1cBbP4QqDU
oDpbCK/px+v7SM3yZp95XXOP1EFF8vHCEe2TN6kQ5nhbelNwmEnNjNcDrTcHwrum
gQvAaOAxKnm61A91EuCvyQuUUKtkx+hcUImaosY4dQ==
=HjFW
-----END PGP SIGNATURE-----

--O+m0AVbsNU64TeWp--

