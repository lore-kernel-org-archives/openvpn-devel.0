Message-ID: <4BD0648B.30800@...1114...>
Date: Thu, 22 Apr 2010 17:00:27 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1269951178-30419-1-git-send-email-dazo@...384...>		<4BBE3205.1040303@...1114...>		<p2w9e0cf0bf1004100005u819d4b3l97c269272e2604ab@...278...>	<h2z9e0cf0bf1004100035rc34e5c17rb7cb8554ba64509@...278...>
	<4BC4766A.3040601@...1114...>
In-Reply-To: <4BC4766A.3040601@...1114...>
Content-Type: multipart/mixed; boundary="------------020403060906060504090104"
Subject: Re: [Openvpn-devel] [PATCH] Add comile time settings from
 ./configure to --version
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020403060906060504090104
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/04/10 15:49, David Sommerseth wrote:
[...snip...]
> 
> I've attached three patches, which cleans up this feature further.
> 

This is an enhanced patch, based on review comments from Gert Doering.
He mentioned that the configure_log.awk could be made a bit more
"understandable".  I've done some minor adjustments to improve that,
also for people not too much acquainted with awk.  It is also made safer
to if the needed information is not found in config.log.

Patch attached.


kind regards,

David Sommerseth

- ---
 Makefile.am       |   10 +++++++---
 configure_log.awk |    7 ++-----
 options.c         |    2 ++
 3 files changed, 11 insertions(+), 8 deletions(-)



>> On Sat, Apr 10, 2010 at 10:05 AM, Alon Bar-Lev <alon.barlev@...277...> wrote:
>>> Highly none standard autotools usage.
>>> Also requires awk which may not be available.
>>> Please REVERT.
>>>
>>> On Thu, Apr 8, 2010 at 10:44 PM, David Sommerseth
>>> <openvpn.list@...1114...> wrote:
>> On 30/03/10 14:12, David Sommerseth wrote:
>>>>>> This patch will create ./configure.h which will contain two new #define
>>>>>> strings.  CONFIGURE_DEFINES will contain all USE, ENABLED, DISABLED and
>>>>>> DEPRECATED defines from ./config.h.  CONFIGURE_CALL will contain the
>>>>>> complete ./configure line which was used when configuring the package
>>>>>> for building.
>>>>>>
>>>>>> Signed-off-by: David Sommerseth <dazo@...384...>
>>>>>> ---
>>>>>>  Makefile.am       |    7 +++++++
>>>>>>  configure_h.awk   |   39 +++++++++++++++++++++++++++++++++++++++
>>>>>>  configure_log.awk |   36 ++++++++++++++++++++++++++++++++++++
>>>>>>  options.c         |    3 +++
>>>>>>  4 files changed, 85 insertions(+), 0 deletions(-)
>>>>>>  create mode 100644 configure_h.awk
>>>>>>  create mode 100644 configure_log.awk
>>
>> Applied to the openvpn-testing.git feat_misc branch.  To be merged into
>> allmerged soon.
>> Commit f27bf509315a48b0070294c3993a718df0c2626c
>>
>>
>> kind regards,
>>
>> David Sommerseth
>>>>
> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>>>
>>>
> 
> 
> 
> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> 
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvQZIkACgkQDC186MBRfrq3RgCeKFbqnn4ApvAvFxCkT1daedj/
vr0An0gRtTyhZJUZFQDpo3taFJ4o7pB2
=wWpo
-----END PGP SIGNATURE-----

--------------020403060906060504090104
Content-Type: text/x-patch;
	name="0001-Fix-dependency-checking-for-configure.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-Fix-dependency-checking-for-configure.h.patch"

From 239ed4ed97d12997a552524f30d81a88ec8b231b Mon Sep 17 00:00:00 2001
From: David Sommerseth <dazo@...384...>
Date: Thu, 22 Apr 2010 16:08:34 +0200
Subject: [PATCH 1/3] Fix dependency checking for configure.h (v2)

Alon Bar-Lev indicated commit f27bf509315a48b0070294c3993a718df0c2626c
was missing proper dependency checking.  This patch corrects this and
fixes an issue when creating configure.h via make distcheck.

This is an enhanced version of the one sent to the openvpn-devel mailing
list April 13, 2010 [1], after having received some feedback from Gert
Doering, cleaning up configure_log.awk further.

[1] <http://thread.gmane.org/gmane.network.openvpn.devel/3410/focus=3491>

Signed-off-by: David Sommerseth <dazo@...384...>
---
 Makefile.am       |   10 +++++++---
 configure_log.awk |    7 ++-----
 options.c         |    2 ++
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 20453d0..f509a4b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -66,7 +66,8 @@ dist_noinst_SCRIPTS = \
 	$(TESTS) \
 	doclean \
 	domake-win \
-	t_cltsrv-down.sh
+	t_cltsrv-down.sh \
+	configure_h.awk configure_log.awk
 
 dist_noinst_DATA = \
 	openvpn.spec \
@@ -141,9 +142,12 @@ openvpn_SOURCES = \
 	win32.h win32.c \
 	cryptoapi.h cryptoapi.c
 
+nodist_openvpn_SOURCES = configure.h
+options.$(OBJEXT): configure.h
+
 configure.h: Makefile
-	awk -f configure_h.awk config.h > $@
-	awk -f configure_log.awk config.log >> $@
+	awk -f $(srcdir)/configure_h.awk config.h > $@
+	awk -f $(srcdir)/configure_log.awk config.log >> $@
 
 clean-local:
 	-rm -f configure.h
diff --git a/configure_log.awk b/configure_log.awk
index b305f71..099e5c4 100644
--- a/configure_log.awk
+++ b/configure_log.awk
@@ -27,10 +27,7 @@
 #  ./config.log.
 #
 
-BEGIN {
-	printf ("#define CONFIGURE_CALL \"")
-}
-/\$ .\/configure/ {
-	print $0,"\""
+/\$ (.*)\/configure/ {
+	printf ("#define CONFIGURE_CALL \"%s\"\n", $0)
 	exit 0
 }
diff --git a/options.c b/options.c
index 25936d1..294ba58 100644
--- a/options.c
+++ b/options.c
@@ -2752,7 +2752,9 @@ usage_version (void)
   msg (M_INFO|M_NOPREFIX, "%s", title_string);
   msg (M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
   msg (M_INFO|M_NOPREFIX, "Copyright (C) 2002-2009 OpenVPN Technologies, Inc. <sales@...515...>");
+#ifdef CONFIGURE_CALL
   msg (M_INFO|M_NOPREFIX, "\n%s\n", CONFIGURE_CALL);
+#endif
   msg (M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
   openvpn_exit (OPENVPN_EXIT_STATUS_USAGE); /* exit point */
 }
-- 
1.6.6.1


--------------020403060906060504090104--

