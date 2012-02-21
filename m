MIME-Version: 1.0
In-Reply-To: <CAOBzU4PtoHi66QDaKuL6FX55cyccwgfS+0vZ4SOR3dBhNMMXKQ@...278...>
References: <CAOBzU4PN6qDxf39+s4noXEiW8hNbDy-hkQWGSauBd3hX0pu2hw@...278...>
	<CAOazyz0f3sERwjZsf3Ts3Xu7CQqBEf_-_VdbUZ7TrzhLbmTEsg@...278...>
	<CAOBzU4M02rr2U0kT6F=5s=NAX58AnbJZ+QfO2fZTPGyNnR1+7Q@...278...>
	<CAOazyz1MKVbzzGPLdVNKzaUKuVUj11awdPVwCejDtf8zKjhW6A@...278...>
	<CAOBzU4PtoHi66QDaKuL6FX55cyccwgfS+0vZ4SOR3dBhNMMXKQ@...278...>
Date: Tue, 21 Feb 2012 11:01:31 +0200
Message-ID: <CAOazyz2yKB5+SSK1cjWWnVryKxoYvxJjpE39ZTv+6_fBKvFmpQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 00/35] build revolution
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
To: Frank de Brabander <debrabander@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi!

Will there are no more --with-*-headers configure options, as they are
none standard.
This tarball uses pkgconfig (if possible) to detect dependencies.
Don't you have pkg-config package on your system?
Can you please send me config.log?

In order to bypass pkgconfig you may add the following to your configure:
PKG_CONFIG=3Dtrue LZO_CFLAGS=3D"-I/opt/local/include"
LZO_LIBS=3D"-L/opt/local/lib -llzo2"

Alon.

On Tue, Feb 21, 2012 at 10:38 AM, Frank de Brabander
<debrabander@...277...> wrote:
> Ok, this tarball works!
>
> But now I get the following ( with ./configure
> --with-lzo-headers=3D/opt/local/include =C2=A0 --with-lzo-lib=3D/opt/loca=
l/lib
> ):
>
> checking for lzo1x_1_15_compress in -llzo... no
> checking for PKCS11_HELPER... no
> configure: error: in
> `/Users/brabander/Documents/Fox/openvpn_src/openvpn-2.x-master':
> configure: error: The pkg-config script could not be found or is too
> old. =C2=A0Make sure it
> is in your PATH or set the PKG_CONFIG environment variable to the full
> path to pkg-config.
>
> Alternatively, you may set the environment variables PKCS11_HELPER_CFLAGS
> and PKCS11_HELPER_LIBS to avoid the need to call pkg-config.
> See the pkg-config man page for more details.
>
> To get pkg-config, see <http://pkg-config.freedesktop.org/>.
> See `config.log' for more details
> mekboek:openvpn-2.x-master brabander$
>
>
>
> While I get this (snippet) on master branch
>
> configure: checking for pkcs11-helper Library and Header files...
> checking pkcs11-helper-1.0/pkcs11h-core.h usability... no
> checking pkcs11-helper-1.0/pkcs11h-core.h presence... no
> checking for pkcs11-helper-1.0/pkcs11h-core.h... no
> pkcs11-helper headers not found.
>
>
> Greetings,
> Frank
>
> Op 21 februari 2012 09:28 heeft Alon Bar-Lev <alon.barlev@...277...>
> het volgende geschreven:
>> Thanks!
>>
>> I think I fixed the file, please try again.
>>
>> This is very strange as the m4/ax_socklen_t.m4 looks correct to me.
>> I will investigate this, but appreciate if you can try the tarball.
>>
>> Alon.
>>
>> On Tue, Feb 21, 2012 at 10:17 AM, Frank de Brabander
>> <debrabander@...277...> wrote:
>>> Hey Alon,
>>>
>>> The tarball openvpn-2.x-master.tar.gz on github has a size of "<1KB"
>>> and when I try to download it, I get a "File was not found" message on
>>> the page. Maybe something went wrong while uploading this file?
>>>
>>> mekboek:~ brabander$ autoconf --version
>>> autoconf (GNU Autoconf) 2.61
>>> Copyright (C) 2006 Free Software Foundation, Inc.
>>> This is free software. =C2=A0You may redistribute copies of it under th=
e terms of
>>> the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.
>>> There is NO WARRANTY, to the extent permitted by law.
>>>
>>> Written by David J. MacKenzie and Akim Demaille.
>>> mekboek:~ brabander$ aclocal --version
>>> aclocal (GNU automake) 1.10
>>> Written by Tom Tromey <tromey@...1347...>
>>> =C2=A0 =C2=A0 =C2=A0 and Alexandre Duret-Lutz <adl@...1269...>.
>>>
>>> Copyright (C) 2006 Free Software Foundation, Inc.
>>> This is free software; see the source for copying conditions. =C2=A0The=
re is NO
>>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE.
>>> mekboek:~ brabander$ automake --version
>>> automake (GNU automake) 1.10
>>> Written by Tom Tromey <tromey@...1347...>
>>> =C2=A0 =C2=A0 =C2=A0 and Alexandre Duret-Lutz <adl@...1269...>.
>>>
>>> Copyright 2006 Free Software Foundation, Inc.
>>> This is free software; see the source for copying conditions. =C2=A0The=
re is NO
>>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE.
>>> mekboek:~ brabander$ libtool -V
>>> Apple Computer, Inc. version cctools-809
>>>
>>> Greetings,
>>> Frank
>>>
>>> Ps. The autoreconf does work for the official git repo's master branch
>>>
>>>
>>> Op 21 februari 2012 09:07 heeft Alon Bar-Lev <alon.barlev@...277...>
>>> het volgende geschreven:
>>>> Hello Frank,
>>>>
>>>> Thank you for testing.
>>>>
>>>> Can you please try to download my tarball[1] and not autoreconf at you=
r machine?
>>>> I think your autotools are waaay to old.
>>>>
>>>> And... can you please send me:
>>>> # autoconf --version
>>>> # aclocal --version
>>>> # automake --version
>>>> # libtool --version
>>>>
>>>> Alon
>>>>
>>>> [1] https://github.com/alonbl/openvpn/downloads
>>>>
>>>>
>>>> On Tue, Feb 21, 2012 at 9:47 AM, Frank de Brabander
>>>> <debrabander@...277...> wrote:
>>>>> I did a quick test on OS X (Lion) and the build fails.
>>>>>
>>>>> mekboek:openvpn_src brabander$ git clone --branch build
>>>>> https://github.com/alonbl/openvpn.git openvpn_alonbl
>>>>> mekboek:openvpn_src brabander$ cd openvpn_alonbl/
>>>>> mekboek:openvpn_alonbl brabander$ autoreconf -i -v
>>>>> autoreconf: Entering directory `.'
>>>>> autoreconf: configure.ac: not using Gettext
>>>>> autoreconf: running: aclocal -I m4
>>>>> configure.ac:337: warning: AC_CACHE_VAL(VAR, ...): suspicious presence
>>>>> of an AC_DEFINE in the second argument, where no actions should be
>>>>> taken
>>>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf=
/general.m4:1905:
>>>>> AC_CACHE_VAL is expanded from...
>>>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf=
/general.m4:1918:
>>>>> AC_CACHE_CHECK is expanded from...
>>>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/m4sugar/=
m4sh.m4:523:
>>>>> AS_IF is expanded from...
>>>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf=
/types.m4:243:
>>>>> AC_CHECK_TYPE is expanded from...
>>>>> m4/ax_socklen_t.m4:63: AX_TYPE_SOCKLEN_T is expanded from...
>>>>> configure.ac:337: the top level
>>>>> autoreconf: configure.ac: tracing
>>>>> configure.ac:337: warning: AC_CACHE_VAL(VAR, ...): suspicious presence
>>>>> of an AC_DEFINE in the second argument, where no actions should be
>>>>> taken
>>>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf=
/general.m4:1905:
>>>>> AC_CACHE_VAL is expanded from...
>>>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf=
/general.m4:1918:
>>>>> AC_CACHE_CHECK is expanded from...
>>>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/m4sugar/=
m4sh.m4:523:
>>>>> AS_IF is expanded from...
>>>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf=
/types.m4:243:
>>>>> AC_CHECK_TYPE is expanded from...
>>>>> m4/ax_socklen_t.m4:63: AX_TYPE_SOCKLEN_T is expanded from...
>>>>> configure.ac:337: the top level
>>>>> autoreconf: running: glibtoolize --copy
>>>>> glibtoolize: putting auxiliary files in AC_CONFIG_AUX_DIR, `.'.
>>>>> glibtoolize: copying file `./ltmain.sh'
>>>>> glibtoolize: putting macros in AC_CONFIG_MACRO_DIR, `m4'.
>>>>> glibtoolize: copying file `m4/libtool.m4'
>>>>> glibtoolize: copying file `m4/ltoptions.m4'
>>>>> glibtoolize: copying file `m4/ltsugar.m4'
>>>>> glibtoolize: copying file `m4/ltversion.m4'
>>>>> glibtoolize: copying file `m4/lt~obsolete.m4'
>>>>> configure.ac:337: warning: AC_CACHE_VAL(VAR, ...): suspicious presence
>>>>> of an AC_DEFINE in the second argument, where no actions should be
>>>>> taken
>>>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf=
/general.m4:1905:
>>>>> AC_CACHE_VAL is expanded from...
>>>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf=
/general.m4:1918:
>>>>> AC_CACHE_CHECK is expanded from...
>>>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/m4sugar/=
m4sh.m4:523:
>>>>> AS_IF is expanded from...
>>>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf=
/types.m4:243:
>>>>> AC_CHECK_TYPE is expanded from...
>>>>> m4/ax_socklen_t.m4:63: AX_TYPE_SOCKLEN_T is expanded from...
>>>>> configure.ac:337: the top level
>>>>> autoreconf: running: /usr/bin/autoconf
>>>>> configure.ac:337: warning: AC_CACHE_VAL(VAR, ...): suspicious presence
>>>>> of an AC_DEFINE in the second argument, where no actions should be
>>>>> taken
>>>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf=
/general.m4:1905:
>>>>> AC_CACHE_VAL is expanded from...
>>>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf=
/general.m4:1918:
>>>>> AC_CACHE_CHECK is expanded from...
>>>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/m4sugar/=
m4sh.m4:523:
>>>>> AS_IF is expanded from...
>>>>> /private/var/tmp/autoconf/autoconf-17.1~539/SRC/autoconf/lib/autoconf=
/types.m4:243:
>>>>> AC_CHECK_TYPE is expanded from...
>>>>> m4/ax_socklen_t.m4:63: AX_TYPE_SOCKLEN_T is expanded from...
>>>>> configure.ac:337: the top level
>>>>> configure.ac:31: error: possibly undefined macro: AC_DEFINE
>>>>> =C2=A0 =C2=A0 =C2=A0If this token and others are legitimate, please u=
se m4_pattern_allow.
>>>>> =C2=A0 =C2=A0 =C2=A0See the Autoconf documentation.
>>>>> configure.ac:545: error: possibly undefined macro: AC_CHECK_LIB
>>>>> configure:14349: error: possibly undefined macro: AS_VAR_IF
>>>>> autoreconf: /usr/bin/autoconf failed with exit status: 1
>>>>>
>>>>> ---------------------------------------------------------------------=
---------
>>>>> Keep Your Developer Skills Current with LearnDevNow!
>>>>> The most comprehensive online learning library for Microsoft develope=
rs
>>>>> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MV=
C3,
>>>>> Metro Style Apps, more. Free future releases when you subscribe now!
>>>>> http://p.sf.net/sfu/learndevnow-d2d
>>>>> _______________________________________________
>>>>> Openvpn-devel mailing list
>>>>> Openvpn-devel@lists.sourceforge.net
>>>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

