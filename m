Message-ID: <4D262C21.6080905@...68...>
Date: Thu, 06 Jan 2011 21:54:57 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <jb2PkGhmqClC.rQXy2JmT@...1444...>
	<4D260407.9090004@...1030...> <4D260739.1030201@...68...>
	<4D262940.5020104@...1030...>
In-Reply-To: <4D262940.5020104@...1030...>
Subject: Re: [Openvpn-devel] bugfix2.1: automake support for plugin build
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
To: Mr Dash Four <mr.dash.four@...1030...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 06.01.2011 21:42, schrieb Mr Dash Four:
> 
>> I suppose you need to modify the .spec file to make sure you're running
>> autoreconf twice up front (or libtoolize, aclocal, autoconf, automake,
>> possibly autoheader).
>>
>> Note you'll want to remove the .la files from the destdir, and list the
>> .so files in the %files section, /usr/lib/openvpn/*.so might do the
>> trick ISTR that RPM does globbing.
>>   
> Your patches did not work!
> 
> As with my initial post on this thread - the flags are *exactly* the
> same (hard-coded):
> 
> make: Entering directory
> `/home/zeek/rpmbuild/BUILD/openvpn-2.1.4/plugin/down-root'
> gcc -O2 -Wall -fPIC -c -I../.. down-root.c
> gcc -O2 -Wall -fPIC -shared -Wl,-soname,openvpn-down-root.so -o
> openvpn-down-root.so down-root.o -lc
> make: Leaving directory
> `/home/zeek/rpmbuild/BUILD/openvpn-2.1.4/plugin/down-root'
> + for plugin in down-root auth-pam
> + /usr/bin/make -C plugin/auth-pam

This has gone wrong.  The plugins should be built from the top-level
directory instead (see below how it works for me), with the regular
"make" that also builds openvpn, so the "for plugin in ... make -C
$plugin ..." is no longer needed for these two guys.

"make install" should load the material where it belongs, namely into
libdir/packagename, i. e. /usr[/local]/lib/openvpn/*.so

But I should possibly remove the Makefiles that are no longer needed.

My log excerpt is given below.

> make: Entering directory
> `/home/zeek/rpmbuild/BUILD/openvpn-2.1.4/plugin/auth-pam'
> gcc -O2 -Wall -DDLOPEN_PAM=0 -fPIC -c -I../.. auth-pam.c
> gcc -O2 -Wall -DDLOPEN_PAM=0 -fPIC -c -I../.. pamdl.c
> gcc -O2 -Wall -DDLOPEN_PAM=0 -fPIC -shared
> -Wl,-soname,openvpn-auth-pam.so -o openvpn-auth-pam.so auth-pam.o
> pamdl.o -lc -lpam
> make: Leaving directory
> `/home/zeek/rpmbuild/BUILD/openvpn-2.1.4/plugin/auth-pam'
> 
> I also had to adjust your patches slightly to fit the 2.1.4 source tree
> - see the modified versions attached.
> 

Quite possibly, mine were against git's bugfix2.1 branch. There are
minor differences.


...
make[2]: Leaving directory `/tmp/ovpn/install-win32'
make[2]: Entering directory `/tmp/ovpn'
/bin/bash ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.
-I/home/emma/VCS-other/openvpn-testing.git
-I/home/emma/VCS-other/openvpn-testing.git    -g -O2 -MT down-root.lo
-MD -MP -MF .deps/down-root.Tpo -c -o down-root.lo `test -f
'plugin/down-root/down-root.c' || echo
'/home/emma/VCS-other/openvpn-testing.git/'`plugin/down-root/down-root.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I.
-I/home/emma/VCS-other/openvpn-testing.git
-I/home/emma/VCS-other/openvpn-testing.git -g -O2 -MT down-root.lo -MD
-MP -MF .deps/down-root.Tpo -c
/home/emma/VCS-other/openvpn-testing.git/plugin/down-root/down-root.c
-fPIC -DPIC -o .libs/down-root.o
mv -f .deps/down-root.Tpo .deps/down-root.Plo
/bin/bash ./libtool --tag=CC   --mode=link gcc  -g -O2 -module
-avoid-version  -o down-root.la -rpath /usr/local/lib/openvpn
down-root.lo  -lselinux -lssl -lcrypto -llzo2 -ldl
libtool: link: gcc -shared  .libs/down-root.o   -lselinux -lssl -lcrypto
/usr/lib/liblzo2.so -ldl    -Wl,-soname -Wl,down-root.so -o
.libs/down-root.so
libtool: link: ( cd ".libs" && rm -f "down-root.la" && ln -s
"../down-root.la" "down-root.la" )
/bin/bash ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.
-I/home/emma/VCS-other/openvpn-testing.git
-I/home/emma/VCS-other/openvpn-testing.git    -g -O2 -MT auth-pam.lo -MD
-MP -MF .deps/auth-pam.Tpo -c -o auth-pam.lo `test -f
'plugin/auth-pam/auth-pam.c' || echo
'/home/emma/VCS-other/openvpn-testing.git/'`plugin/auth-pam/auth-pam.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I.
-I/home/emma/VCS-other/openvpn-testing.git
-I/home/emma/VCS-other/openvpn-testing.git -g -O2 -MT auth-pam.lo -MD
-MP -MF .deps/auth-pam.Tpo -c
/home/emma/VCS-other/openvpn-testing.git/plugin/auth-pam/auth-pam.c
-fPIC -DPIC -o .libs/auth-pam.o
mv -f .deps/auth-pam.Tpo .deps/auth-pam.Plo
/bin/bash ./libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.
-I/home/emma/VCS-other/openvpn-testing.git
-I/home/emma/VCS-other/openvpn-testing.git    -g -O2 -MT pamdl.lo -MD
-MP -MF .deps/pamdl.Tpo -c -o pamdl.lo `test -f
'plugin/auth-pam/pamdl.c' || echo
'/home/emma/VCS-other/openvpn-testing.git/'`plugin/auth-pam/pamdl.c
libtool: compile:  gcc -DHAVE_CONFIG_H -I.
-I/home/emma/VCS-other/openvpn-testing.git
-I/home/emma/VCS-other/openvpn-testing.git -g -O2 -MT pamdl.lo -MD -MP
-MF .deps/pamdl.Tpo -c
/home/emma/VCS-other/openvpn-testing.git/plugin/auth-pam/pamdl.c  -fPIC
-DPIC -o .libs/pamdl.o
mv -f .deps/pamdl.Tpo .deps/pamdl.Plo
/bin/bash ./libtool --tag=CC   --mode=link gcc  -g -O2 -module
-avoid-version  -o auth-pam.la -rpath /usr/local/lib/openvpn auth-pam.lo
pamdl.lo -lpam -lselinux -lssl -lcrypto -llzo2 -ldl
libtool: link: gcc -shared  .libs/auth-pam.o .libs/pamdl.o   -lpam
-lselinux -lssl -lcrypto /usr/lib/liblzo2.so -ldl    -Wl,-soname
-Wl,auth-pam.so -o .libs/auth-pam.so
libtool: link: ( cd ".libs" && rm -f "auth-pam.la" && ln -s
"../auth-pam.la" "auth-pam.la" )
gcc -DHAVE_CONFIG_H -I. -I/home/emma/VCS-other/openvpn-testing.git
-I/home/emma/VCS-other/openvpn-testing.git    -g -O2 -MT base64.o -MD
-MP -MF .deps/base64.Tpo -c -o base64.o
/home/emma/VCS-other/openvpn-testing.git/base64.c
mv -f .deps/base64.Tpo .deps/base64.Po
gcc -DHAVE_CONFIG_H -I. -I/home/emma/VCS-other/openvpn-testing.git
-I/home/emma/VCS-other/openvpn-testing.git    -g -O2 -MT buffer.o -MD
-MP -MF .deps/buffer.Tpo -c -o buffer.o
/home/emma/VCS-other/openvpn-testing.git/buffer.c
mv -f .deps/buffer.Tpo .deps/buffer.Po
...

HTH

