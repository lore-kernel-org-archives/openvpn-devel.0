Message-ID: <4F44B38B.7010201@...515...>
Date: Wed, 22 Feb 2012 11:21:15 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
	<4F44A1A3.8050007@...515...>
In-Reply-To: <4F44A1A3.8050007@...515...>
Subject: Re: [Openvpn-devel] [build] Windows build test
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>


>> .
>> Build is here[1]
>>
>> BEST METHOD - Compile on Linux
>>
>> This is a generic method, it can cross compile OpenVPN using any
>> toolchain to any environment.
>> For Windows, make sure you have mingw-w64 toolchain.
>> We are using nsis so we can also package files at Linux.
>>
>> $ cd generic
>> $ IMAGEROOT=3D`pwd`/image-win32 CHOST=3Di686-w64-mingw32
>> CBUILD=3Dx86_64-pc-linux-gnu ./build
>> $ IMAGEROOT=3D`pwd`/image-win64 CHOST=3Dx86_64-w64-mingw32
>> CBUILD=3Dx86_64-pc-linux-gnu ./build
>>

I used this method to cross-compile for Windows (32-bit and 64-bit) on
Ubuntu 11.10 amd64. I replaced the "bin" directory of an existing
openvpn-2.3-alpha1 installation with the results on a 32-bit WinXP box
and it seemed work ok.

Anyways, there was a problem with permissions during build:

--- snip ---
Fixup libtool files
Restore libtool files
Copying documents
Copying sources
Cleaning empty directories
x86_64-w64-mingw32-strip: unable to copy file
'/home/samuli/opt/openvpn/generic/image
-win64/openvpn/lib/engines/gmpeay32.dll'; reason: Permission denied
x86_64-w64-mingw32-strip: unable to copy file
'/home/samuli/opt/openvpn/generic/image-win64/openvpn/lib/engines/atallaeay=
32.dll';
reason: Permission denied
--- snip ---

The offending files had 555 permissions. Changing them manually to 755
and restarting the build from correct phase allowed the build to complete.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


