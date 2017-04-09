References: <1490527279-31426-1-git-send-email-chipitsine@...277...>
	<12987e8a-1873-fc96-3b4f-0576939773fb@...1856...>
	<CAFHpkQHyR+fO-PpK-q+vHvWC02sjRiOWkcwOTje7g6wqyZyEYg@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <7e470072-787c-c7c3-39cb-b9338720b79c@...1856...>
Date: Sun, 9 Apr 2017 14:03:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHyR+fO-PpK-q+vHvWC02sjRiOWkcwOTje7g6wqyZyEYg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: add 2 mingw "build only
 configurations"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 09-04-17 12:54, Илья Шипицин wrote:
> 
> 2017-04-09 13:44 GMT+05:00 Steffan Karger <steffan@...1856...
> <mailto:steffan@...1856...>>:
> 
>     On 26-03-17 13:21, Ilya Shipitsin wrote:
>     > +      TAP_CFLAGS="-I${PWD}/tap-windows-${TAP_WINDOWS_VERSION}/include"
>     LZO_CFLAGS="-I${PREFIX}/include" LZO_LIBS="-L${PREFIX}/lib -llzo2"
>     PKCS11_HELPER_LIBS="-L${PREFIX}/lib -lpkcs11-helper"
>     PKCS11_HELPER_CFLAGS="-I${PREFIX}/include" ./configure
>     --host=${CHOST} --build=x86_64-pc-linux-gnu --enable-pkcs11
>     --disable-plugins || (cat config.log && exit 1);
> 
>     All these _CFLAGS and _LIBS should go into the env: section above.
> 
> 
> there are 3 "env" sections: global and 2 "mingw".
> I'm afraid, defining those variables in global section might have some
> side effect, while specifying variables 2 times in both mingw sections
> also do not make much sense.

Good point, my suggestion will not work.  I'm still not quite happy with
this very long line though.  Maybe put them in something like
.travis/win_build_vars and source that file from .travis.yml ?  Other
suggestions are welcome too.

>     Any reason to --enable-pkcs11 for the windows builds, while that's not
>     done for the non-windows builds?
> 
> 
> regular windows installer is built with pkcs11. that's why I added that
> option.

Ok.  Makes sense to verify that at least our own Windows builds work.

> build matrix for non-windows builds was discussed and nobody asked me to
> add pkcs11 there.

I just wondered why the difference, didn't mean to suggest that we need
to add pkcs11 to the other builds.

>     >  # Enable ccache
>     > -if [ "${TRAVIS_OS_NAME}" != "osx" ]; then
>     > +if [ "${TRAVIS_OS_NAME}" != "osx" ] && [ -z "${CHOST+xxx}" ]; then
>     >      # ccache not available on osx, see:
>     >      # https://github.com/travis-ci/travis-ci/issues/5567
>     <https://github.com/travis-ci/travis-ci/issues/5567>
> 
>     Is ccache not available for mingw?  In that case, please update the
>     comment, preferably with a reference to a travis issue so that we can
>     enable it if travis adds support later on.
> 
> 
> I could not get ccache working with mingw, but there's no issue, I'm not
> sure it is related to travis either.

Ok.  Then just make sure to update the comment so it becomes clear that
&& [ -z "${CHOST+xxx}" ] disables ccache for windows cross compiles.

>     > @@ -70,7 +84,6 @@ if [ "${TRAVIS_OS_NAME}" != "osx" ]; then
>     >  fi
>     >
>     >  # Download and build crypto lib
>     > -mkdir -p download-cache
>     >  if [ "${SSLLIB}" = "openssl" ]; then
>     >      download_openssl
>     >      build_openssl
>     > @@ -81,3 +94,35 @@ else
>     >      echo "Invalid crypto lib: ${SSLLIB}"
>     >      exit 1
>     >  fi
>     > +
>     > +if [ ! -z ${CHOST+xxx} ]; then
>     > +      echo "deb http://archive.ubuntu.com/ubuntu <http://archive.ubuntu.com/ubuntu>
>     xenial main universe" | sudo tee -a /etc/apt/sources.list.d/xenial.list
>     > +      echo "deb http://archive.ubuntu.com/ubuntu <http://archive.ubuntu.com/ubuntu>
>     xenial main" | sudo tee -a /etc/apt/sources.list.d/xenial.list
>     > +      sudo apt-get update
>     > +      sudo apt-get -y install dpkg mingw-w64
>     > +      if [ ! -f "download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip" ]; then
>     > +         wget -P download-cache/ http://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip
>     <http://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip>
>     > +      fi
> 
>     This should be in a download_tap_windows() function.
> 
> 
> can you be more particular on "should be".
> it does not mean "must be".
> if so, we can leave it, right ?

I'll be more clear (and less polite..):  writing long lists of commands
is bad.  That's not only true for code, it goes for scripts as well.
Writing functions (with good names!) allows the reader to not have to
parse the commands to understand what the author wanted to do.

If we put this in functions, the pkcs11 section will read

      download_pkcs11helper
      build_pkcs11helper

Which makes it immediately clear what the intent of that code is.

For tap-windows we only have to download and extract, to that would only
read

     download_tap_windows

which makes this immediately clear too.

This really is basic software engineering, and the lack of quality in
quite some of your contributions is an important reason why your
contributions aren't picked up quickly.  Your ideas and intentions are
good, but we need to put in far too much effort to make the quality of
your contribution acceptable.  Time that we can also spend on
better-quality contributions.  It would help us all (including you) if
you would try to improve on that.

-Steffan

