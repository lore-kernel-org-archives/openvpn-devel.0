Message-ID: <4aff28800802180341w13683e6m6c4636c0e4890fdc@...278...>
Date: Mon, 18 Feb 2008 13:41:46 +0200
From: "Diaa Sami" <diaasami@...277...>
In-Reply-To: <9e0cf0bf0802172159v149280aax38ae1f39e33882e2@...278...>
MIME-Version: 1.0
References: <4aff28800802160916r506572a0r44a9e619e31ce5ee@...278...>
	<9e0cf0bf0802160925w2dd86c02mb6f8dd5cfd4ab9e5@...278...>
	<4aff28800802160957i114f38f4o2fdd483a780ff203@...278...>
	<9e0cf0bf0802161014j6de5ddd2l37f42bbd835d4a90@...278...>
	<4aff28800802161507r3c5ccf91vb2bfc0d56951906a@...278...>
	<9e0cf0bf0802162232n40953c6bjac66494ac1cf7e64@...278...>
	<4aff28800802171046v2b37359elcba3cdf4d14223de@...278...>
	<9e0cf0bf0802171248ra12c019g4bbbef1ceee9647c@...278...>
	<4aff28800802171619k135c1965m52ad9ab11394ad6b@...278...>
	<9e0cf0bf0802172159v149280aax38ae1f39e33882e2@...278...>
Subject: Re: [Openvpn-devel] Compiling OpenVPN 2.1rc7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On Feb 18, 2008 7:59 AM, Alon Bar-Lev <alon.barlev@...277...> wrote:
> I wish to reproduce this.
> Can you please provide some instruction of how to do this?
> 1. Which EXACT version and platform of Windows are you using?

Windows XP SP2 Home edition

> 2. Which mingw version you are using, how did you installed it.

The current latest, there's no single version for the whole package
but gcc -v gives
----
Reading specs from c:/MinGW/bin/../lib/gcc/mingw32/3.4.5/specs

Configured with: ../gcc-3.4.5/configure --with-gcc --with-gnu-ld
--with-gnu-as --host=mingw32 --target=mingw32 --prefix=/mingw
--enable-threads --disable-nls
--enable-languages=c,c++,f77,ada,objc,java --disable-win32-registry
--disable-shared --enable-sjlj-exceptions --enable-libgcj
--disable-java-awt --without-x --enable-java-gc=boehm
--disable-libgcj-debug --enable-interpreter
--enable-hash-synchronization --enable-libstdcxx-debug

Thread model: win32

gcc version 3.4.5 (mingw special)
----

I installed MinGW manually  by unpacking .tar.gz packages in c:/MinGW

> 3. Which msys version are you using, how did you installed it.

1.0.10, installed using the installer provided at mingw.org

> 4. How did you EXACTLY compile OpenSSL?

Patched it using the patch provided with openvpn, then ran ms\mw.bat

Thanks

