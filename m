References: <1490527279-31426-1-git-send-email-chipitsine@...277...>
	<12987e8a-1873-fc96-3b4f-0576939773fb@...1856...>
	<CAFHpkQHyR+fO-PpK-q+vHvWC02sjRiOWkcwOTje7g6wqyZyEYg@...278...>
	<7e470072-787c-c7c3-39cb-b9338720b79c@...1856...>
	<CAFHpkQELjBpk4TXNrrOrkMaE1vooH=ZySG6HfQts+RuuPuXGfg@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <3b1c076e-4cd9-07f6-dd8c-9c687c0f5eb8@...1856...>
Date: Sun, 9 Apr 2017 18:58:17 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQELjBpk4TXNrrOrkMaE1vooH=ZySG6HfQts+RuuPuXGfg@...278...>
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

On 09-04-17 15:31, Илья Шипицин wrote:
>     >     > @@ -70,7 +84,6 @@ if [ "${TRAVIS_OS_NAME}" != "osx" ]; then
>     >     >  fi
>     >     >
>     >     >  # Download and build crypto lib
>     >     > -mkdir -p download-cache
>     >     >  if [ "${SSLLIB}" = "openssl" ]; then
>     >     >      download_openssl
>     >     >      build_openssl
>     >     > @@ -81,3 +94,35 @@ else
>     >     >      echo "Invalid crypto lib: ${SSLLIB}"
>     >     >      exit 1
>     >     >  fi
>     >     > +
>     >     > +if [ ! -z ${CHOST+xxx} ]; then
>     >     > +      echo "deb http://archive.ubuntu.com/ubuntu
>     <http://archive.ubuntu.com/ubuntu> <http://archive.ubuntu.com/ubuntu
>     <http://archive.ubuntu.com/ubuntu>>
>     >     xenial main universe" | sudo tee -a /etc/apt/sources.list.d/xenial.list
>     >     > +      echo "deb http://archive.ubuntu.com/ubuntu
>     <http://archive.ubuntu.com/ubuntu> <http://archive.ubuntu.com/ubuntu
>     <http://archive.ubuntu.com/ubuntu>>
>     >     xenial main" | sudo tee -a /etc/apt/sources.list.d/xenial.list
>     >     > +      sudo apt-get update
>     >     > +      sudo apt-get -y install dpkg mingw-w64
>     >     > +      if [ ! -f "download-cache/tap-windows-${TAP_WINDOWS_VERSION}.zip" ]; then
>     >     > +         wget -P download-cache/ http://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip
>     <http://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip>
>     >     <http://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip
>     <http://build.openvpn.net/downloads/releases/tap-windows-${TAP_WINDOWS_VERSION}.zip>>
>     >     > +      fi
>     >
>     >     This should be in a download_tap_windows() function.
>     >
>     >
>     > can you be more particular on "should be".
>     > it does not mean "must be".
>     > if so, we can leave it, right ?
> 
>     I'll be more clear (and less polite..):  writing long lists of commands
>     is bad.  That's not only true for code, it goes for scripts as well.
>     Writing functions (with good names!) allows the reader to not have to
>     parse the commands to understand what the author wanted to do.
> 
>     If we put this in functions, the pkcs11 section will read
> 
>           download_pkcs11helper
>           build_pkcs11helper
> 
>     Which makes it immediately clear what the intent of that code is.
> 
>     For tap-windows we only have to download and extract, to that would only
>     read
> 
>          download_tap_windows
> 
>     which makes this immediately clear too.
> 
>     This really is basic software engineering, and the lack of quality in
>     quite some of your contributions is an important reason why your
>     contributions aren't picked up quickly.  Your ideas and intentions are
>     good, but we need to put in far too much effort to make the quality of
>     your contribution acceptable.  Time that we can also spend on
>     better-quality contributions.  It would help us all (including you) if
>     you would try to improve on that.
> 
> 
> 
> those code lines are not reusable, so not splitting it into functions
> does not mean poor quality (for me)
> the rule of thumb is "to put into function piece of code, which is
> called many times"
> 
> otherwise, it might be either function or not.

Functions are not only to prevent code duplication.  They are also for
structuring your code.  Which is exactly what I'm suggesting here.  Code
does not only need to do it's job, it also needs to be maintainable.

> how did you came to conclusion that it means poor code quality?
> is it written somewhere on the https://openvpn.net on how to write bash
> scripts ?

We're not here to give software engineering classes.  Nor is the openvpn
wiki meant to be a book on software engineering.

-Steffan

