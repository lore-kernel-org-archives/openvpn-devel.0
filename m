Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41DAC9830E
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 12:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n64zKe8VsgNuvCiI55R8RFzHUOh2N3x2wJ1uaS4kQjA=; b=VdXYOi1B9nOkeeFI6w2eVhOMgy
	oOgpBwS57wnYUtvx0EKVAyP3nMo3/FOhjzLpIYRxEnxbYl7LbHzhhaIudj/npHH2JTMe3WwDOaRIo
	ywRPe6vg5HVLuX+k2A6JmTAgfRUdvhYc9pjw88u39wCO+Kr/svl8JBW2kx4Zh2z7Sj5g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA4ww-0007uK-Kk;
	Fri, 25 Sep 2026 12:22:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xA4wu-0007u2-Uw
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 12:22:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MQSaYEzjhOD6uZwZz7UDFNreIXC+yHaJcfQXBIHxfvg=; b=aMAJUlrwsRnXhdz9k38Afn1C3v
 4+SHmh8AxOposXInZ5jYP/za5QGCRtJTMI3mVG+Wm++h9++qVMO3T/6oSwXAZnqb+mPyV3nf1o67/
 z7bOnzT5nu9bh36cAs6xNO3i6dP4a5GJQdMz5/nZdY+nhf5k6UIwI9SoseV3i0Xl//Y0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MQSaYEzjhOD6uZwZz7UDFNreIXC+yHaJcfQXBIHxfvg=; b=aSvbg8Ekr+UEoMBr87a9SAoXxs
 86pgc34k4gUlowO5sFCvWFQBeMAqjU0U52UoKZ8tGEh61uO+kZia5ieXGLFIEn/Po9zTYYLy8mHCp
 d6y8AMpRtgUyXcDnFSAWHy8ApowYhzgTtHFQmmysfGRMr34XZWD/iLcargYHjmQB0LwA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xA4wo-0006Pu-PV for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 12:22:42 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68PCMV67005818
 for <openvpn-devel@lists.sourceforge.net>; Fri, 25 Sep 2026 14:22:31 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68PCMV8C005817
 for openvpn-devel@lists.sourceforge.net; Fri, 25 Sep 2026 14:22:31 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 25 Sep 2026 14:22:26 +0200
Message-ID: <20260925122231.5805-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xA4wo-0006Pu-PV
Subject: [Openvpn-devel] [PATCH v10] Change most ENABLE_DEBUG ifdefs to
 ifndef ENABLE_SMALL
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Arne Schwabe <arne@rfc2549.org>

Most of these are verbose logging or even enable logging at high
verbosity level or just useful tools like --show-gateway.

We had --enabled-debug on by default forever, so these "debug"
logs are on by default. This patch instead moves them to
enable-small.

Since the verbose logging is now always enabled
(apart from --enable-small), --enable-debug now only covers true
debug options like gremlin.

Rename the configure option from --enable-debug to
--enable-developer-debug to ensure existing build
script/maintainer do not enable this option
by default.

This patch also adds [SMALL] and [DEBUG] as identifier in the OpenVPN
version string more easily identify builds with this feature.

In addition both configure and openvpn itself will add a warning
about --enable-developer-debug to discourage users and maintainers
from enabling this feature.

Remove dmsg macro from tapctl's error.h since it does
not use that macro at all.

Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1942
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1942
This mail reflects revision 10 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 6eb5954..d553697 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -40,6 +40,7 @@
 option(ENABLE_PKCS11 "BUILD with pkcs11-helper" ON)
 option(USE_WERROR "Treat compiler warnings as errors (-Werror)" ON)
 option(FAKE_ANDROID "Target Android but do not use actual cross compile/Android cmake to build for simple compile checks on Linux")
+option(ENABLE_DEBUG "Enable building with debug" OFF)
 
 option(ENABLE_DNS_UPDOWN_BY_DEFAULT "Run --dns-updown hook by default" ON)
 set(DNS_UPDOWN_PATH "${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown" CACHE STRING "Default location for the DNS up/down script")
diff --git a/Changes.md b/Changes.md
index 2684251..5c3270b 100644
--- a/Changes.md
+++ b/Changes.md
@@ -23,6 +23,12 @@
   the characters mentioned above were already escaped. However, the behavior of
   Mbed TLS is slightly different from OpenSSL in that it also escapes "=".
 
+## Maintainer-visible changes
+
+- The configure-time option `--enable-debug` is no longer  available
+  and the verbose logging is now always included unless `--enable-small`
+  is enabled.
+
 # Overview of changes in 2.7
 
 ## New features
diff --git a/config.h.cmake.in b/config.h.cmake.in
index c3bb5a5..c6c0a96 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -18,8 +18,8 @@
 /* Enable shared data channel offload */
 #cmakedefine ENABLE_DCO
 
-/* Enable debugging support (needed for verb>=4) */
-#define ENABLE_DEBUG 1
+/* Enable debugging support */
+#cmakedefine ENABLE_DEBUG
 
 /* Enable internal fragmentation support */
 #define ENABLE_FRAGMENT 1
diff --git a/configure.ac b/configure.ac
index 469a475..1fa0e63 100644
--- a/configure.ac
+++ b/configure.ac
@@ -130,10 +130,10 @@
 )
 
 AC_ARG_ENABLE(
-	[debug],
-	[AS_HELP_STRING([--disable-debug], [disable debugging support (disable gremlin and verb 7+ messages) @<:@default=yes@:>@])],
-	,
-	[enable_debug="yes"]
+	[developer-debug],
+	[AS_HELP_STRING([--enable-developer-debug], [enable developer debugging support (enable gremlin) @<:@default=no@:>@])],
+	[enable_debug="yes"],
+	[enable_debug="no"]
 )
 
 AC_ARG_ENABLE(
@@ -1393,3 +1393,8 @@
 ])
 AC_CONFIG_FILES([tests/t_client.sh], [chmod +x tests/t_client.sh])
 AC_OUTPUT
+
+# Put the warning at the end, so it is better visible
+if test "${enable_debug}" = "yes"; then
+    AC_MSG_WARN([--enable-developer-debug is enabled. This should be only used for test/development builds and not for production usage])
+fi
\ No newline at end of file
diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index 299d7a3..27c9d30 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -42,7 +42,7 @@
 intToPointerCast:src/openvpn/multi_io.c
 intToPointerCast:src/openvpn/ps.c
 # FP: constant but differs between platforms
-knownConditionTrueFalse:src/openvpn/error.h:380
+knownConditionTrueFalse:src/openvpn/error.h:382
 knownConditionTrueFalse:src/openvpn/fdmisc.c:80
 knownConditionTrueFalse:src/openvpn/lladdr.c:64
 knownConditionTrueFalse:src/openvpn/platform.c
@@ -73,8 +73,8 @@
 # FP: cppcheck doesn't understand ZeroMemory
 redundantAssignment:src/openvpnserv/interactive.c:204
 # IGN: We reuse the same variable name due to macro usage
-shadowVariable:src/openvpn/options.c:1948
-shadowVariable:src/openvpn/options.c:1966
+shadowVariable:src/openvpn/options.c:1955
+shadowVariable:src/openvpn/options.c:1973
 # FP: fun:tls_crypt_v2_wrap_unwrap_invalid: cppcheck is confused
 syntaxError:tests/unit_tests/openvpn/test_tls_crypt.c:684
 # FP: this file is never compiled on _WIN32
diff --git a/dev-tools/openvpn-cppcheck-library.cfg b/dev-tools/openvpn-cppcheck-library.cfg
index 1ea91f4..decac67 100644
--- a/dev-tools/openvpn-cppcheck-library.cfg
+++ b/dev-tools/openvpn-cppcheck-library.cfg
@@ -26,4 +26,6 @@
   <!-- work around macro confusion -->
   <define name="CMSG_FIRSTHDR" value="cmsg_firsthdr" />
   <define name="CMSG_NXTHDR" value="cmsg_nxthdr" />
+  <!-- otherwise a lot of unused variables are shown for enable-small builds -->
+  <define name="DMSG_ALWAYS_AVAILABLE" value="1" />
 </def>
diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c
index f0c89f7..2eef587 100644
--- a/src/openvpn/compstub.c
+++ b/src/openvpn/compstub.c
@@ -125,7 +125,7 @@
         return;
     }
 
-    uint8_t *head = BPTR(buf);
+    const uint8_t *head = BPTR(buf);
 
     /* no compression or packet to short*/
     if (head[0] != COMP_ALGV2_INDICATOR_BYTE)
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 0c5beb4..05bb60d 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -842,8 +842,8 @@
     struct gc_arena gc = gc_new();
     uint8_t A1[MAX_HMAC_KEY_LENGTH];
 
-#ifdef ENABLE_DEBUG
-    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unused
+#ifndef ENABLE_SMALL
+    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unused
      * variables warnings if compiled with --enable-small */
     const size_t olen_orig = olen;
     const uint8_t *out_orig = out;
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedtls_legacy.c
index bbd012f6..f46d8bf 100644
--- a/src/openvpn/crypto_mbedtls_legacy.c
+++ b/src/openvpn/crypto_mbedtls_legacy.c
@@ -989,8 +989,8 @@
     struct gc_arena gc = gc_new();
     uint8_t A1[MAX_HMAC_KEY_LENGTH];
 
-#ifdef ENABLE_DEBUG
-    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unused
+#ifndef ENABLE_SMALL
+    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unused
      * variables warnings if compiled with --enable-small */
     const size_t olen_orig = olen;
     const uint8_t *out_orig = out;
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index a887fc7..9f39572 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -158,7 +158,9 @@
         }                                \
         EXIT_FATAL(flags);               \
     } while (false)
-#ifdef ENABLE_DEBUG
+/* We have DMSG_ALWAYS_AVAILABLE here to able to silence unused warnings for
+ * cppcheck */
+#if !defined(ENABLE_SMALL) || defined(DMSG_ALWAYS_AVAILABLE)
 #define dmsg(flags, ...)                 \
     do                                   \
     {                                    \
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 8b7716a..2cb4e04 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -398,7 +398,7 @@
 
     dmsg(D_EVENT_WAIT, "WE_WAIT enter n=%d to=%d", wes->n_events, timeout);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_EVENT_WAIT))
     {
         int i;
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6fe5849..a8a4a07 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -50,7 +50,7 @@
 
 /* show event wait debugging info */
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 
 static const char *
 wait_status_string(struct context *c, struct gc_arena *gc)
@@ -75,7 +75,7 @@
     gc_free(&gc);
 }
 
-#endif /* ifdef ENABLE_DEBUG */
+#endif
 
 static void
 check_tls_errors_co(struct context *c)
@@ -2190,7 +2190,7 @@
         {
             int status;
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
             if (check_debug_level(D_EVENT_WAIT))
             {
                 show_wait_status(c);
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 39fa482..261d25a 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -501,7 +501,7 @@
     }
     mh->n_net_len = j;
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_MULTI_DEBUG))
     {
         struct gc_arena gc = gc_new();
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 5d88f8a..b0125f1 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -74,7 +74,7 @@
         mi->did_real_hash = true;
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (mi)
     {
         dmsg(D_MULTI_DEBUG, "MULTI TCP: instance added: %s", mroute_addr_print(&mi->real, &gc));
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 88b0091..4794b7e 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -431,7 +431,7 @@
         }
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_MULTI_DEBUG))
     {
         struct gc_arena gc = gc_new();
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3e72b92..67204c3 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1145,7 +1145,7 @@
         }
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_MULTI_DEBUG))
     {
         struct gc_arena gc = gc_new();
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 3604684..4b96c57 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -46,7 +46,7 @@
 #define MULTI_IO_FILE_CLOSE_WRITE ((void *)5)
 #define MULTI_IO_DCO              ((void *)6)
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 static const char *
 pract(int action)
 {
@@ -89,7 +89,7 @@
             return "?";
     }
 }
-#endif /* ENABLE_DEBUG */
+#endif
 
 static inline struct context *
 multi_get_context(struct multi_context *m, struct multi_instance *mi)
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 24d6bb6..acd366d 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -252,6 +252,8 @@
 #endif
             show_library_versions(M_INFO);
 
+            show_debug_warning(M_INFO);
+
             show_dco_version(M_INFO);
 
             /* misc stuff */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e3cd527..3c5a249 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -113,9 +113,16 @@
 #ifdef ENABLE_DCO
     " [DCO]"
 #endif
+#ifdef ENABLE_SMALL
+    " [SMALL]"
+#endif
+#ifdef ENABLE_DEBUG
+    " [DEBUG]"
+#endif
 #ifdef CONFIGURE_GIT_REVISION
     " built on " __DATE__
 #endif
+
     ;
 
 #ifndef ENABLE_SMALL
@@ -785,7 +792,7 @@
 #endif /* ENABLE_PKCS11 */
     "\n"
     "General Standalone Options:\n"
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     "--show-gateway [address]: Show info about gateway [to v4/v6 address].\n"
 #endif
     ;
@@ -3534,6 +3541,9 @@
     msg(M_INFO | M_NOPREFIX, "special build: %s", CONFIGURE_SPECIAL_BUILD);
 #endif
 #endif
+
+    show_debug_warning(M_INFO | M_NOPREFIX);
+
     openvpn_exit(OPENVPN_EXIT_STATUS_GOOD);
 }
 
@@ -4229,7 +4239,7 @@
         read_config_file(options, p[1], level, file, line, msglevel, permission_mask,
                          option_types_found, es);
     }
-#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifndef ENABLE_SMALL
     else if (streq(p[0], "show-gateway") && !p[2])
     {
         struct route_gateway_info rgi;
@@ -4938,12 +4948,13 @@
              * mbed TLS always generating debug level logging */
             options->ssl_flags |= SSLF_TLS_DEBUG_ENABLED;
         }
-#if !defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifdef ENABLE_SMALL
         /* Warn when a debug verbosity is supplied when built without debug support */
         if (options->verbosity >= 7)
         {
             msg(M_WARN,
-                "NOTE: debug verbosity (--verb %d) is enabled but this build lacks debug support.",
+                "NOTE: debug verbosity (--verb %d) is enabled but this build is "
+                "built with --enable-small that lacks support for high --verb settings",
                 options->verbosity);
         }
 #endif
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f472676..31ae17b 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -888,6 +888,16 @@
 
 void show_library_versions(const unsigned int flags);
 
+static inline void
+show_debug_warning(const unsigned int flags)
+{
+#ifdef ENABLE_DEBUG
+    msg(flags, "WARNING: OpenVPN has been compiled with --enable-developer-debug. "
+               "This should be only used for test/development builds and not for "
+               "production usage");
+#endif
+}
+
 #ifdef _WIN32
 void show_windows_version(const unsigned int flags);
 
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index a4b627c..22c53c7 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -52,18 +52,18 @@
 #define SEQ_UNSEEN  ((time_t)0)
 #define SEQ_EXPIRED ((time_t)1)
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 static void packet_id_debug_print(msglvl_t msglevel, const struct packet_id_rec *p,
                                   const struct packet_id_net *pin, const char *message,
                                   packet_id_print_type value);
 
-#endif /* ENABLE_DEBUG */
+#endif
 
 static inline void
 packet_id_debug(msglvl_t msglevel, const struct packet_id_rec *p,
                 const struct packet_id_net *pin, const char *message, uint64_t value)
 {
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (unlikely(check_debug_level(msglevel)))
     {
         packet_id_debug_print(msglevel, p, pin, message, value);
@@ -576,7 +576,7 @@
     return (char *)out.data;
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 
 static void
 packet_id_debug_print(msglvl_t msglevel, const struct packet_id_rec *p,
@@ -648,7 +648,7 @@
     gc_free(&gc);
 }
 
-#endif /* ifdef ENABLE_DEBUG */
+#endif
 
 uint16_t
 packet_id_read_epoch(struct packet_id_net *pin, struct buffer *buf)
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index f8adde5..a94f07b 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -993,7 +993,7 @@
     pr->n = 0;
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 void
 plugin_return_print(const msglvl_t msglevel, const char *prefix, const struct plugin_return *pr)
 {
@@ -1012,5 +1012,5 @@
         }
     }
 }
-#endif /* ifdef ENABLE_DEBUG */
+#endif
 #endif /* ENABLE_PLUGIN */
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 7e9faf3..684632c 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -135,7 +135,7 @@
 
 void plugin_return_free(struct plugin_return *pr);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 void plugin_return_print(const msglvl_t msglevel, const char *prefix, const struct plugin_return *pr);
 
 #endif
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index ced438e..b5315ff 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -462,7 +462,7 @@
     }
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 /* print the current sequence of active packet IDs */
 static const char *
 reliable_print_ids(const struct reliable *rel, struct gc_arena *gc)
@@ -480,7 +480,7 @@
     }
     return BSTR(&out);
 }
-#endif /* ENABLE_DEBUG */
+#endif
 
 /* true if at least one free buffer available */
 bool
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 03a2526..e8001b3 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -81,7 +81,7 @@
 
 static void get_bypass_addresses(struct route_bypass *rb, const unsigned int flags);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 
 static void
 print_bypass_addresses(const struct route_bypass *rb)
@@ -617,7 +617,7 @@
     if (rl->ngi.flags & RGI_ADDR_DEFINED)
     {
         setenv_route_addr(es, "net_gateway", rl->ngi.gateway.addr, -1);
-#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifndef ENABLE_SMALL
         print_default_gateway(D_ROUTE, &rl->rgi, NULL);
 #endif
     }
@@ -660,7 +660,7 @@
             add_block_local_routes(rl);
         }
         get_bypass_addresses(&rl->spec.bypass, rl->flags);
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
         print_bypass_addresses(&rl->spec.bypass);
 #endif
     }
@@ -768,7 +768,7 @@
     if (rl6->ngi6.flags & RGI_ADDR_DEFINED)
     {
         setenv_str(es, "net_gateway_ipv6", print_in6_addr(rl6->ngi6.gateway.addr_ipv6, 0, &gc));
-#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifndef ENABLE_SMALL
         print_default_gateway(D_ROUTE, NULL, &rl6->rgi6);
 #endif
     }
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index 6772ad6..6c60dc2 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -33,7 +33,7 @@
 
 #include "memdbg.h"
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 static void
 schedule_entry_debug_info(const char *caller, const struct schedule_entry *e)
 {
@@ -308,7 +308,7 @@
 void
 schedule_add_modify(struct schedule *s, struct schedule_entry *e)
 {
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_SCHEDULER))
     {
         schedule_entry_debug_info("schedule_add_modify", e);
@@ -355,7 +355,7 @@
         }
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_SCHEDULER))
     {
         schedule_entry_debug_info("schedule_find_least", e);
diff --git a/src/tapctl/error.h b/src/tapctl/error.h
index f9586dc..4424f56 100644
--- a/src/tapctl/error.h
+++ b/src/tapctl/error.h
@@ -83,19 +83,6 @@
         }                                \
         EXIT_FATAL(flags);               \
     } while (false)
-#ifdef ENABLE_DEBUG
-#define dmsg(flags, ...)                 \
-    do                                   \
-    {                                    \
-        if (msg_test(flags))             \
-        {                                \
-            x_msg((flags), __VA_ARGS__); \
-        }                                \
-        EXIT_FATAL(flags);               \
-    } while (false)
-#else
-#define dmsg(flags, ...)
-#endif
 
 void x_msg(const unsigned int flags, const char *format, ...); /* should be called via msg above */
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
