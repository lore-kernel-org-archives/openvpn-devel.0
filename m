From: "Noam Rathaus" <noamr@...117...>
Message-ID: <086c01c3995a$0d005da0$3301a8c0@...118...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_086D_01C3996A.D0892DA0"
In-Reply-To: <twig.1066589443.4353@...41...>
Subject: [Openvpn-devel] RE: OpenVPN and Windows
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Oct 25 01:24:52 2003
To: 'James Yonan' <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_086D_01C3996A.D0892DA0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I was able to compile the OpenVPN under the Visual C++ environment it
required some changes
1) I need to change
#define OPENVPN_S_ERROR          -1
#define OPENVPN_S_UNDEF           0
#define OPENVPN_S_INITIAL         1	/* tls_init() was called */
#define OPENVPN_S_PRE_START       2	/* waiting for initial reset &
acknowledgement */
#define OPENVPN_S_START           3	/* ready to exchange keys */
#define OPENVPN_S_SENT_KEY        4	/* client does S_SENT_KEY ->
S_GOT_KEY */
#define OPENVPN_S_GOT_KEY         5	/* server does S_GOT_KEY ->
S_SENT_KEY */
#define OPENVPN_S_ACTIVE          6	/* ready to exchange data channel
packets */
#define OPENVPN_S_NORMAL          7	/* normal operations */

Instead of those that are currently in place, as S_NORMAL already exist as
an MFC #define.

2) And:
  fd =3D open (filename, O_CREAT | O_TRUNC | O_WRONLY
#ifndef _WINDOWS=09=09
		, S_IRUSR | S_IWUSR
#endif
		);

Instead of what it is currently, as S_IRUSR and S_IWUSR do not exist, nor is
there a permission problem for file descriptors, if you request a O_WRONLY,
you will fail if you cannot write to it due to permission errors.

3) Also inside config-win32.h I did:
#ifndef _WINDOWS
#include <windows.h>
#endif

As windows.h is the console include, and when building an MFC environment it
is not needed.

4) And last but not least I created an MFC.h file to include all the things
I needed:
#ifndef MFC_H
#define MFC_H

#undef TIME_WITH_SYS_TIME
#undef HAVE_SYS_TIME_H
#undef HAVE_SYS_FILE_H
#undef HAVE_STDINT_H
#undef HAVE_UNISTD_H

#include <stdio.h>
#include <io.h>
#include <direct.h>
#include <openssl/err.h>

#define vsnprintf _vsnprintf
#define snwprintf _snwprintf=20

#ifdef _WINDOWS
 InternalMsg (flags, ...);
#endif

#endif

5) And replaced in error.h:
#ifdef _WINDOWS
	#define msg InternalMsg
#else
 #if defined(HAVE_CPP_VARARG_MACRO_ISO) && !defined(__LCLINT__)
 #define HAVE_VARARG_MACROS
 #define msg(flags, ...) do { if (MSG_TEST(flags)) x_msg((flags),
__VA_ARGS__); } while (false)
 #elif defined(HAVE_CPP_VARARG_MACRO_GCC) && !defined(__LCLINT__)
 #define HAVE_VARARG_MACROS
 #define msg(flags, args...) do { if (MSG_TEST(flags)) x_msg((flags), args);
} while (false)
 #else
 #warning this compiler appears to lack vararg macros which will cause a
significant degradation in efficiency (you can ignore this warning if you
are using LCLINT)
 #define msg x_msg
 #endif
#endif

As Visual C++ does not support any unnumbered variable in Macros
(InternalMsg is a wrapper). This is the only problem BTW, I cannot make the
InternalMsg behave correctly as the msg macro does, as I cannot properly
parse the values passes to the InternalMsg function.

The only solution that appears to be the valid one at the moment is
replacing the msg calls, with msg0, msg1, msg2, msg3, etc instead of a
single unnumber msg call (this is how Microsoft's Debugging functions work).

I also attached a short txt explaining how to compile.

Any help / comments  will be greatly appreciated.
Thanks
Noam Rathaus
CTO
Beyond Security Ltd.
http://www.securiteam.com=20

-----Original Message-----
From: James Yonan [mailto:jim@...41...]=20
Sent: Sunday, October 19, 2003 20:51
To: Noam Rathaus
Subject: Re: OpenVPN and Windows


Noam,

I don't use Visual C++, but I've posted your message to the openvpn-devel
list.

James

Noam Rathaus <noamr@...117...> said:

> Hi,
>=20
> I am sorry for contacting you directly, but I tried posting to the=20
> Mailing
list multiple times, but I wasn't able to get through (even though I am able
to receive the mailing, so I am subscribed), this is the email I tried to
post into the list.
>=20
> =3D=3D=3D=3D=3D
>=20
> I have been trying for a few hours now to get my Visual C++ to compile=20
> the
OpenVPN user mode client, but without any luck, I would be happy to hear
from someone who was able to, or has an idea how to do it.
>=20
> I have MinGW, MSYS, GCC, etc installed, but I want to create an Open=20
> Source
MFC GUI for the client, as opposed to the console one.
>=20
> =3D=3D=3D=3D=3D
>=20
> Thanks
> Noam Rathaus
> CTO
> Beyond Security Ltd.
> http://www.securiteam.com
>=20
>=20



--=20





------=_NextPart_000_086D_01C3996A.D0892DA0
Content-Type: text/plain;
	name="OpenVPN under VC++.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="OpenVPN under VC++.txt"

To compile you need to do:

1) Go to http://www.microsoft.com/msdownload/platformsdk/sdkupdate/ and =
get the Microsoft Platform SDK, you can use WINE's but it will be a lot =
more compilicated. -- Troubleshoot note: "Cannot open include file: =
'iphlpapi.h': No such file or directory" means you are missing the =
Platform SDK

2) You need in the Platform SDK the following:
Under Core SDK:
 Build environment (31 mb)=20
 Documentation (release and prerelease) (91.6 mb) - Optional
 Sample and source code (10.6 mb) - Optional
=20
3) If your connection didn't die, and you downloaded the small 31mb =
package (usually some other files come along like Windows Installer, and =
Common Setup Files, but they aren't needed by us), you should have the =
Platform SDK.

4) Make sure that under Tools->Options->Directories->Include Files, =
C:\PROGRAM FILES\MICROSOFT SDK\INCLUDE appears. Some directories have =
become "obsolete" and need changing (C:\Program Files\Microsoft Visual =
Studio\VC98\INCLUDE), so you need to reorder, place C:\Program =
Files\Microsoft Visual Studio\VC98\MFC\INCLUDE after the Platform SDK's.

5) Get OpenSSL from www.openssl.org, open the package, compile it:
5.1) perl Configure VC-WIN32
5.2) ms\do_nasm
(appears to work better than masm)
5.3) nmake -f ms\ntdll.mak
(Don't forget VC++ enviroment)

5.4) cd out32dll
5.5) ..\ms\test
(This just tests that it worked :))

6) Include the directory C:\Projects\lzo-1.08\include
7) And the Library directory C:\Projects\openssl-0.9.6k\out32dll, =
C:\PROGRAM FILES\MICROSOFT SDK\LIB
8) The external lib file: libeay32.lib, Ws2_32.lib, ssleay32.lib, =
Advapi32.lib

9) Make sure these files are in the same Debug directory libeay32.dll, =
lzo.dll, ssleay32.dll
------=_NextPart_000_086D_01C3996A.D0892DA0--


