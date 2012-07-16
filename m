MIME-Version: 1.0
In-Reply-To: <CAEsd45Rh9zu=FC_Qdt4KiUfGayMqRzshF4OpxsHcszVH+8vBHw@...278...>
References: <CAEsd45Rh9zu=FC_Qdt4KiUfGayMqRzshF4OpxsHcszVH+8vBHw@...278...>
Date: Mon, 16 Jul 2012 19:45:03 +0300
Message-ID: <CAOazyz1+Px-wFYd3DVdm-1Sxponr0xsp2w4m8Mum+HTDyMtovg@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] New build system questions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

On Mon, Jul 16, 2012 at 7:24 PM, Jonathan K. Bullard
<jkbullard@...277...> wrote:
> I'm in the process of trying to build 2.3_alpha2 into Tunnelblick. It's slow
> going because of my unfamiliarity with make/automake, etc. I have several
> questions:
>
> (1) Is there a way to disable building "openvpnserv" and the "auth-pam"
> plugin? (Other than modifying src/Makefile.am and src/plugins/Makefile.am,
> of course.) I'm thinking of something along the lines of
> "ENABLE_OPENVPNSERV=no" or "DISABLE-AUTH-PAM".

--disable-plugin-auth-pam

Do you build for windows? if not, please send me the compile error and
config.log.
The windows service should not be built on none windows.

>
> (2) Should I be concerned about the following warnings?
>
> checking lzo/lzoutil.h presence... no
> configure: WARNING: lzo/lzoutil.h: accepted by the compiler, rejected by the
> preprocessor!
> configure: WARNING: lzo/lzoutil.h: proceeding with the compiler's result
> checking for lzo/lzoutil.h... yes
> checking lzo/lzo1x.h usability... yes
> checking lzo/lzo1x.h presence... no
> configure: WARNING: lzo/lzo1x.h: accepted by the compiler, rejected by the
> preprocessor!
> configure: WARNING: lzo/lzo1x.h: proceeding with the compiler's result
>

No.

>
>
> (3) I want to build "compat" as a static library. How can I do that?
>
> I've tried adding the following arguments after "./configure":
>
> --enable-static --disable-shared
>
>
> And I've tried prefixing ./configure with the following:
>
> COMPAT_CFLAGS=-static  LIBCOMPAT_CFLAGS=-static  LIBCOMPAT_LA_CFLAGS=-static
> compat_CFLAGS=-static  libcompat_CFLAGS=-static  libcompat_la_CFLAGS=-static
> COMPAT_LDFLAGS=-static  LIBCOMPAT_LDFLAGS=-static
> LIBCOMPAT_LA_LDFLAGS=-static compat_LDFLAGS=-static
> libcompat_LDFLAGS=-static  libcompat_la_LDFLAGS=-static
> COMPAT_LIBTOOLFLAGS=-static  LIBCOMPAT_LIBTOOLFLAGS=-static
> LIBCOMPAT_LA_LIBTOOLFLAGS=-static compat_LIBTOOLFLAGS=-static
> libcompat_LIBTOOLFLAGS=-static libcompat_la_LIBTOOLFLAGS=-static
>

You don't need the above... just add LDFLAGS="-static", I guess.


> But it still seems to be building a "shared" library for compat -- I get the
> following warning:
>
> *** Warning: Linking the shared library libcompat.la against the
>
> *** static library [path to] libcrypto.a is not portable!
>
> along with the same warning about libssl.a, liblzo2.a, and
> libpkcs11-helper.a.
>

To compile static, you need to build openvpn without plugins
(--disable-plugins) and all dependencies such as openssl the same.

In openvpn-build[1] project you have a script to build all as static:

Try it out:
DO_STATIC=1 DO_REALLY_STATIC=1 ./generic/build

Alon.

[1] https://github.com/OpenVPN/openvpn-build

