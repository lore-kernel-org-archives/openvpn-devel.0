MIME-Version: 1.0
In-Reply-To: <1268244277.8679.3@...1207...>
References: <1268242750.8679.0@...1207...> <4B97DCEC.9020108@...1114...>
	<1268244277.8679.3@...1207...>
Date: Wed, 10 Mar 2010 20:09:04 +0200
Message-ID: <9e0cf0bf1003101009kb323a2csccc86d7c148766f4@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] On TARGET_LINUX define _GNU_SOURCE if
	not defined
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Mar 10, 2010 at 8:04 PM, Karl O. Pinc <kop@...1206...> wrote:
> But how is it then that Alon does not run ./configure
> on machine 2 above?

You do...
On the target machine:

tar -xf @TARBALL@
cd @TOP@
./configure
make install

You must run configure in order to generate Makefile in autoconf environmen=
t.

> Nothing should patch the autotools generated files, just the autotools
> source files. =C2=A0Right?

If you patch autoconf/automake stuff, you *MUST* add autoconf/automake
dependency to your package, so you can regenerate the files. It is
much simpler to patch also the generated files and avoid this
dependency. But it is packager's call.

Please understand, in order to build a package you *DO NOT* need
autoconf/automake/libtool installed *AT ALL*.

Best case is to approach upstream to issue a fix release in this case.

Alon.

