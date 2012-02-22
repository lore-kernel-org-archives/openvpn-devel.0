MIME-Version: 1.0
Date: Wed, 22 Feb 2012 02:12:25 +0200
Message-ID: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: [Openvpn-devel] [build] Windows build test
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
To: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hello people who actually use Windows!

I will appreciate if you test my new windows build environment for OpenVPN.

You have many options, I guess all are needed.

While you at it, please try to explain me why we need Visual Studio build... :)
.
Build is here[1]

BEST METHOD - Compile on Linux

This is a generic method, it can cross compile OpenVPN using any
toolchain to any environment.
For Windows, make sure you have mingw-w64 toolchain.
We are using nsis so we can also package files at Linux.

$ cd generic
$ IMAGEROOT=`pwd`/image-win32 CHOST=i686-w64-mingw32
CBUILD=x86_64-pc-linux-gnu ./build
$ IMAGEROOT=`pwd`/image-win64 CHOST=x86_64-w64-mingw32
CBUILD=x86_64-pc-linux-gnu ./build

SLOWER METHOD - Compile on cygwin

Read README for required packages.

$ cd generic
$ IMAGEROOT=`pwd`/image-win32 CHOST=i686-w64-mingw32
CBUILD=i686-pc-cygwin ./build
$ IMAGEROOT=`pwd`/image-win64 CHOST=x86_64-w64-mingw32
CBUILD=i686-pc-cygwin ./build

Visual Studio Complete Batch

install perl

> cd msvc
> build

Visual Studio IDE

After you have the dependencies of Complete Batch or your own.
Create msvc-env-local.bat with OPENVPN_DEPROOT pointing to the
location of the dependencies.

> msvc-dev

MSBuild

After you have the dependencies of Complete Batch or your own.
Create msvc-env-local.bat with OPENVPN_DEPROOT pointing to the
location of the dependencies.

> msvc-build

Good luck,
Alon.

[1] https://github.com/alonbl/openvpn-build

