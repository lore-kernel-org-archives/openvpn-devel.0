Message-ID: <464872CA.3080109@...260...>
Date: Mon, 14 May 2007 16:31:38 +0200
From: =?ISO-8859-1?Q?Emmanuel_Qu=E9mener?= <emmanuel.quemener@...260...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Compilation under AIX OS : problem...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello all,


I've only manipulate OpenVPN under Linux, MacOSX and Windows OSes.


A new project needs a VPN infrastructure but most of machines are under
AIX OS.


I've tried to compile OpenVPN and it hangs after few files due to
compilation error :


make  all-am
make[1]: Entering directory `/home/equemene/sources/openvpn-2.0.9'
source='base64.c' object='base64.o' libtool=no \
depfile='.deps/base64.Po' tmpdepfile='.deps/base64.TPo' \
depmode=aix /bin/sh ./depcomp \
cc_r -DHAVE_CONFIG_H -I. -I. -I.   -I/opt/freeware/include/
-I/home/equemene/root/include/ -I.  -g -D_THREAD_SAFE  -c base64.c
source='buffer.c' object='buffer.o' libtool=no \
depfile='.deps/buffer.Po' tmpdepfile='.deps/buffer.TPo' \
depmode=aix /bin/sh ./depcomp \
cc_r -DHAVE_CONFIG_H -I. -I. -I.   -I/opt/freeware/include/
-I/home/equemene/root/include/ -I.  -g -D_THREAD_SAFE  -c buffer.c
source='crypto.c' object='crypto.o' libtool=no \
depfile='.deps/crypto.Po' tmpdepfile='.deps/crypto.TPo' \
depmode=aix /bin/sh ./depcomp \
cc_r -DHAVE_CONFIG_H -I. -I. -I.   -I/opt/freeware/include/
-I/home/equemene/root/include/ -I.  -g -D_THREAD_SAFE  -c crypto.c
source='error.c' object='error.o' libtool=no \
depfile='.deps/error.Po' tmpdepfile='.deps/error.TPo' \
depmode=aix /bin/sh ./depcomp \
cc_r -DHAVE_CONFIG_H -I. -I. -I.   -I/opt/freeware/include/
-I/home/equemene/root/include/ -I.  -g -D_THREAD_SAFE  -c error.c
source='event.c' object='event.o' libtool=no \
depfile='.deps/event.Po' tmpdepfile='.deps/event.TPo' \
depmode=aix /bin/sh ./depcomp \
cc_r -DHAVE_CONFIG_H -I. -I. -I.   -I/opt/freeware/include/
-I/home/equemene/root/include/ -I.  -g -D_THREAD_SAFE  -c event.c
source='fdmisc.c' object='fdmisc.o' libtool=no \
depfile='.deps/fdmisc.Po' tmpdepfile='.deps/fdmisc.TPo' \
depmode=aix /bin/sh ./depcomp \
cc_r -DHAVE_CONFIG_H -I. -I. -I.   -I/opt/freeware/include/
-I/home/equemene/root/include/ -I.  -g -D_THREAD_SAFE  -c fdmisc.c
source='forward.c' object='forward.o' libtool=no \
depfile='.deps/forward.Po' tmpdepfile='.deps/forward.TPo' \
depmode=aix /bin/sh ./depcomp \
cc_r -DHAVE_CONFIG_H -I. -I. -I.   -I/opt/freeware/include/
-I/home/equemene/root/include/ -I.  -g -D_THREAD_SAFE  -c forward.c
"options.h", line 77.10: 1506-007 (S) "struct route_option_list" is
undefined.
make[1]: *** [forward.o] Error 1
make[1]: Leaving directory `/home/equemene/sources/openvpn-2.0.9'
make: *** [all] Error 2


Mysteriously, the compiler says that route_option_list is not defined
but it's already define in route.h. The previous file route.h is also
defined in config.h


What's wrong ?


Best regards


