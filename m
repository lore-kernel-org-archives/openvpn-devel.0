References: <1493194434-16926-1-git-send-email-chipitsine@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <f2c52b1c-44a1-31bc-a6c4-a5c014cbfb0f@...1856...>
Date: Wed, 3 May 2017 21:13:42 +0200
MIME-Version: 1.0
In-Reply-To: <1493194434-16926-1-git-send-email-chipitsine@...277...>
Subject: Re: [Openvpn-devel] [PATCH] v3,
 travis-ci: add 2 mingw "build only" configurations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

On 26-04-17 10:13, Ilya Shipitsin wrote:
> Inspired by https://www.mail-archive.com/openvpn-devel@lists.sourceforge.=
net/msg13032.html
> build options are taken from regular windows installer builds
>=20
> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> ---
> v2: moved download/build dependencies into functions, changed cross build
> detection from shell expansion ${CHOST+x} to more recognised -z "${CHOST}=
",
> which required changing 'set -eux' to 'set -ex'. Added comments to make
> code readable without looking into commit message.
>=20
> v3: fixed "trailing whitespaces" found by Samuli Sepp=E4nen. Added back "=
set -u",
> thanks to Steffan Karger. Changed repo manipulation to "apt-add-repositor=
y", thanks
> to Nathan Stratton Treadway.

Thanks for not giving up - this looks a lot better now!  Still a problem
though:

> -  - ./configure --with-crypto-library=3D"${SSLLIB}" ${EXTRA_CONFIG} || (=
cat config.log && exit 1)
> -  - make -j$JOBS
> -  - src/openvpn/openvpn --version || true
> -  - if [ "${TRAVIS_OS_NAME}" =3D "linux" ]; then ldd src/openvpn/openvpn=
; fi
> -  - if [ "${TRAVIS_OS_NAME}" =3D "osx" ]; then otool -L src/openvpn/open=
vpn; fi
> -  - make check
> -  - $EXTRA_SCRIPT
> +  - if [ -z "${CHOST}" ]; then
> +      ./configure --with-crypto-library=3D"${SSLLIB}" ${EXTRA_CONFIG} ||=
 (cat config.log && exit 1);
> +      make -j$JOBS;
> +      src/openvpn/openvpn --version || true;
> +      if [ "${TRAVIS_OS_NAME}" =3D "linux" ]; then ldd src/openvpn/openv=
pn; fi;
> +      if [ "${TRAVIS_OS_NAME}" =3D "osx" ]; then otool -L src/openvpn/op=
envpn; fi;
> +      make check;
> +      $EXTRA_SCRIPT;
> +    else
> +      export TAP_CFLAGS=3D"-I${PWD}/tap-windows-${TAP_WINDOWS_VERSION}/i=
nclude";
> +      export LZO_CFLAGS=3D"-I${PREFIX}/include";
> +      export LZO_LIBS=3D"-L${PREFIX}/lib -llzo2";
> +      export PKCS11_HELPER_LIBS=3D"-L${PREFIX}/lib -lpkcs11-helper";
> +      export PKCS11_HELPER_CFLAGS=3D"-I${PREFIX}/include";
> +      ./configure --with-crypto-library=3D"${SSLLIB}" --host=3D${CHOST} =
--build=3Dx86_64-pc-linux-gnu --enable-pkcs11 --disable-plugins || (cat con=
fig.log && exit 1);
> +      make -j$JOBS;
> +    fi

Adding this as a command - with the steps separated by ; - will cause
failures to be ignored.  This patch should fail the build:

       make check;
+      false;
       $EXTRA_SCRIPT;

... but it doesn't:

https://github.com/syzzer/openvpn/commit/df910243428589691cfaa1c0dcc6d92ec7=
d12b8e

https://travis-ci.org/syzzer/openvpn/builds/228462383?utm_source=3Dgithub_s=
tatus&utm_medium=3Dnotification

To fix this, I propose to create a .travis/build-check.sh script, which
contains the build steps (and set -eu), and call that script from
.travis.yml

-Steffan

