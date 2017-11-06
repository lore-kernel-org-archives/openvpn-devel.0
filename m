Message-ID: <fc836d9417be8c9d85e314d40dea51c8.squirrel@...2257...>
In-Reply-To: <20171104162253.GW958@...1296...>
References: <20170907022827.10658-1-davids@...515...>
 <20170907172004.22534-1-davids@...515...>
 <c122b7ac9f1d63ac0ba060f7f7d3ceff.squirrel@...2257...>
 <20170922205944.GA70062@...1296...>
 <a08bca638691c21471fadd3d6589359a.squirrel@...2257...>
 <20171104162253.GW958@...1296...>
Date: Mon, 6 Nov 2017 08:15:54 +0100
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20171106081554_87381"
Subject: Re: [Openvpn-devel] LZ4 library version printing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

------=_20171106081554_87381
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> Hi,
>
> returning to this patchset about printing the LZ4 library version...
>
> On Sat, Sep 23, 2017 at 10:52:16AM +0200, Simon Matter wrote:
>> > On Thu, Sep 07, 2017 at 10:40:21PM +0200, Simon Matter wrote:
>> >> While we are at it, I found it useful to see the used LZ4 version at
>> >> runtime as it is done with LZO and other libraries.
>
> I still like this :-)
>
> [..]
>> > Feature-ACK (I think this is a useful idea, for the same reasons we
>> have
>> > LZO and OpenSSL versions :-) ), but that will not work if we use
>> > compat-lz4.h, so "code NAK".
>>
>> IIRC at the time of writing this, the embedded lz4 was too old and
>> didn't
>> have the LZ4_versionString() function. So the code won't work with the
>> patch. If the embedded code has LZ4_versionString() now, it should be
>> ok.
>
> It now has...  (1.7.5).
>
> I'm not sure where LZ4_versionString() got introduced, though - their
> git repo does not have tags for 1.7.1 or 1.7.2, it is in the 1.7.3 tag,
> but not in the "last of the old numbering scheme" version.
>
> Our configure.ac requires 1.7.1 - so if LZ4_versionString() is not in
> there yet, we might want to bump to 1.7.3 then.

Hi Gert,

according to the NEWS file in lz4 there is no such thing as release 1.7.1
or 1.7.2, it goes from r131 -> v1.7.3. I therefore suggest to set the
minimum version to 1.7.3 as I'm also unable to locate any official 1.7.1
or 1.7.2 release.

BTW, for 2.4.4 I've changed to patch to the one attached.

Regards,
Simon=

------=_20171106081554_87381
Content-Type: text/x-patch; name="openvpn-2.4.4-lz4_version_string.patch"
Content-Disposition: attachment;
 filename="openvpn-2.4.4-lz4_version_string.patch"
Content-Transfer-Encoding: quoted-printable

--- openvpn-2.4.4/src/openvpn/options.c.orig	2017-09-26 11:27:37.00000000=
0 +0200
+++ openvpn-2.4.4/src/openvpn/options.c	2017-09-28 06:21:57.977919621 +02=
00
@@ -61,6 +61,10 @@
=20
 #include "memdbg.h"
=20
+#if defined(ENABLE_LZ4)
+#include "lz4.h"
+#endif
+
 const char title_string[] =3D
     PACKAGE_STRING
 #ifdef CONFIGURE_GIT_REVISION
@@ -4155,11 +4159,17 @@
 #else
 #define LZO_LIB_VER_STR "", ""
 #endif
+#ifdef ENABLE_LZ4
+#define LZ4_LIB_VER_STR ", LZ4 ", LZ4_versionString()
+#else
+#define LZ4_LIB_VER_STR "", ""
+#endif
=20
-    msg(flags, "library versions: %s%s%s", SSL_LIB_VER_STR, LZO_LIB_VER_=
STR);
+    msg(flags, "library versions: %s%s%s%s%s", SSL_LIB_VER_STR, LZO_LIB_=
VER_STR, LZ4_LIB_VER_STR);
=20
 #undef SSL_LIB_VER_STR
 #undef LZO_LIB_VER_STR
+#undef LZ4_LIB_VER_STR
 }
=20
 static void
------=_20171106081554_87381--



