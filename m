Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595C6C61DBE
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uNQ3gRKJfm/n1Otqv8wnLh+C7BPW0U9LVJrJI8t5sTs=; b=eowUoqzx+EDIw7B3BWWkcsf0ov
	+lWSXb/XXVci0ooa4qojDDyoGHAJSbLrXh2iFH0i4rDaX3OQjTWukzQ4cuVrtnWf0KKDsVRuGltZE
	i715ixPHvO/HSKi/opa77LE8/1YOcWRMfVPoUElg/maD3ZQsilFCQoCT6AwDmzbZ7rn4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wytPC-0006G9-LQ;
	Tue, 25 Aug 2026 15:49:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wytPB-0006Fz-0H
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:49:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eFi+S5tA/sNn9UgRHfxbljEwtnZQGz1h9Zcgz8xISw0=; b=OpKppww08bPDC9sc8i85COVgSW
 lLQ/zfEGCDrOXGCtNrEAjrPwKOJSQbM9rQvKRXUHe7c0hnXqldu7ZsPuj0CPX8glixu8W0sYrg29v
 /pR8GEmfhQrQ2DH8JVaksjW12FMuZKj/ZdVA30sH2mJKNpUO5ot9xvW9FN9O4VmWczB0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eFi+S5tA/sNn9UgRHfxbljEwtnZQGz1h9Zcgz8xISw0=; b=D/R6w33phZTGjgYLKpa0FoPvBG
 bRHCk3H9Jc3G1JVimmKzI8mMm0erxznXDOGM9nR0aj10oUfn0fUZmCChTrpy/0DAciu3Y6t5+JjtP
 8r/SWPSUoAnrm25oW3nxFa3qi1NpdmHm9/ax8zTvpWCJZ5MjOVZhxCyi1VArfdLobarI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wytP9-0002J5-Ap for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:49:40 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67PFnWCQ004602
 for <openvpn-devel@lists.sourceforge.net>; Tue, 25 Aug 2026 17:49:32 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67PFnWSJ004601
 for openvpn-devel@lists.sourceforge.net; Tue, 25 Aug 2026 17:49:32 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 25 Aug 2026 17:49:26 +0200
Message-ID: <20260825154932.4586-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787672720000.Id56fbfa4767346995eaa05ac95c7a20fbba99b2d@gerrit.openvpn.net>
References: <gerrit.1787672720000.Id56fbfa4767346995eaa05ac95c7a20fbba99b2d@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wytP9-0002J5-Ap
Subject: [Openvpn-devel] [PATCH v1] Make cppcheck run pass on top of current
 master
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

From: Frank Lichtenheld <frank@lichtenheld.com>

* Update cppcheck-suppressions to be in sync with
  current code
* Suppress some additional findings that we have
  patches for in the queue but which are not merged,
  yet
* Add some additional fixes for categories we had
  fixed but for which new occurences crept in

The goal is to have one commit that allows us to
enable a cppcheck run in buildbot to keep it
up to date going forward.

Change-Id: Id56fbfa4767346995eaa05ac95c7a20fbba99b2d
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1869
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1869
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index 900e03c..a585513 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -5,6 +5,10 @@
 constParameterPointer
 invalidPrintfArgType_sint
 invalidPrintfArgType_uint
+redundantAssignment
+redundantInitialization
+unreadVariable
+unusedFunction
 usleepCalled
 variableScope
 # We have a lot of library includes, not all of them are really required,
@@ -24,15 +28,21 @@
 localtimeCalled
 strtokCalled
 # FP: posix.cfg claims suseconds_t is unsigned for some reason
-unsignedLessThanZero:src/openvpn/otime.h:235
+unsignedLessThanZero:src/openvpn/otime.h:148
 # IGN: multi code does weird things with pointers to local variables...
-autoVariables:src/openvpn/multi.c:4177
-autoVariables:src/openvpn/multi_io.c:280
+autoVariables:src/openvpn/multi.c:4232
+autoVariables:src/openvpn/multi_io.c:324
 # IGN: the code header = 0 | (OPCODE << P_OPCODE_SHIFT) is used intentionally
 badBitmaskCheck:src/openvpn/mudp.c
 badBitmaskCheck:tests/unit_tests/openvpn/test_pkt.c
 # IGN: we store integers in pointers
 CastAddressToIntegerAtReturn:src/openvpn/multi.c
+# IGN: Windows specific (unsigned long == unsigned int)
+compareValueOutOfTypeRangeError:src/openvpn/ssl_verify.c:928
+# FP: cppcheck seems to have wrong signature of DeviceIoControl()
+constVariablePointer:src/openvpn/dco_win.c
+# IGN: test_networking code would break with iproute2 but that is prevented
+ctunullpointer:src/openvpn/networking_iproute2.c
 # IGN: event code uses a pointer to store integers
 intToPointerCast:src/openvpn/forward.c
 intToPointerCast:src/openvpn/multi_io.c
@@ -40,7 +50,7 @@
 # FP: constant but differs between platforms
 knownConditionTrueFalse:src/openvpn/error.h:380
 knownConditionTrueFalse:src/openvpn/fdmisc.c:80
-knownConditionTrueFalse:src/openvpn/lladdr.c:65
+knownConditionTrueFalse:src/openvpn/lladdr.c:64
 knownConditionTrueFalse:src/openvpn/platform.c
 # FP: code needs to accomodate many different defines
 knownConditionTrueFalse:src/openvpn/event.c:1139
@@ -48,13 +58,13 @@
 # FP: dco_win support has "false" stubs
 knownConditionTrueFalse:src/openvpn/forward.c
 knownConditionTrueFalse:src/openvpn/init.c
-knownConditionTrueFalse:src/openvpn/multi_io.c:163
+knownConditionTrueFalse:src/openvpn/multi_io.c:197
 # FP: cppcheck thinks that some functions always return true, but they don't
 knownConditionTrueFalse:src/openvpn/misc.c:97
 knownConditionTrueFalse:src/openvpn/sig.h:116
 # FP: cert_uri_supported is a wrapper around defines, so it's
 # always constant but differs depending on OpenSSL version
-knownConditionTrueFalse:src/openvpn/ssl_openssl.c:1332
+knownConditionTrueFalse:src/openvpn/ssl_openssl.c:1260
 # FP: cppcheck doesn't understand that the function changes szErrMessage
 knownConditionTrueFalse:src/tapctl/main.c:704
 knownConditionTrueFalse:src/openvpnmsica/dllmain.c:164
@@ -65,12 +75,18 @@
 # FP: eventmsg.h is not built on Unix
 missingInclude:src/openvpnserv/common.c:25
 # IGN: strlen(NULL) is not nice code, but seems to work
-nullPointerRedundantCheck:src/openvpn/init.c:299
+nullPointerRedundantCheck:src/openvpn/init.c:301
 # FP: cppcheck doesn't understand ZeroMemory
 redundantAssignment:src/openvpnserv/interactive.c:203
+# FP: cppcheck doesn't know the NLA macros
+redundantInitialization:src/openvpn/dco_linux.c
 # IGN: We reuse the same variable name due to macro usage
-shadowVariable:src/openvpn/options.c:2580
-shadowVariable:src/openvpn/options.c:2598
+shadowVariable:src/openvpn/options.c:1948
+shadowVariable:src/openvpn/options.c:1966
+# IGN: sure this is theoretically undefined, but works
+shiftNegativeLHS:tests/unit_tests/openvpn/test_schedule.c:183
+# FP: fun:tls_crypt_v2_wrap_unwrap_invalid: cppcheck is confused
+syntaxError:tests/unit_tests/openvpn/test_tls_crypt.c:684
 # FP: this file is never compiled on _WIN32
 umaskCalled:tests/unit_tests/openvpn/test_pkcs11.c
 # FP: yes, t_prev is unitialized, but t_prev_len is 0, so that's handled
@@ -78,13 +94,13 @@
 # FP: yes, parm is unitialized, but parm_len is 0, so that's handled
 uninitvar:src/openvpn/options_parse.c:148
 # FP: uninit is fine when it is a return parameter
-ctuuninitvar:src/openvpn/crypto_mbedtls_legacy.c:698
-uninitvar:src/openvpnserv/interactive.c:1935
+ctuuninitvar:src/openvpn/crypto_mbedtls_legacy.c:690
+uninitvar:src/openvpnserv/interactive.c:2775
 uninitvar:src/tapctl/main.c:566
 # FP: we added a check but cppcheck is not convinced
 uninitvar:src/openvpnserv/interactive.c:2667
 # FP: weird parse error, the macro is fine in the rest of the file
-unknownMacro:src/openvpnserv/interactive.c:3488
+unknownMacro:src/openvpnserv/interactive.c:3596
 # FP: cppcheck doesn't account for short-circuiting
 unreadVariable:src/openvpn/manage.c:682
 unusedFunction:src/openvpn/siphash_reference.c
@@ -101,8 +117,10 @@
 # FP: doesn't account for --wrap
 unusedFunction:tests/unit_tests/openvpn/test_tls_crypt.c
 unusedFunction:/usr/include/*
+# FP: cppcheck doesn't know the NLA macros
+unusedLabel:src/openvpn/dco_linux.c
 # IGN: old code that is difficult to test (MSG_ERRQUEUE), ignore for now
-unusedStructMember:src/openvpn/mtu.c:281
+unusedStructMember:src/openvpn/mtu.c:289
 # FP: used implictly by NL macros
 unusedStructMember:src/openvpn/networking_sitnl.c
 # IGN: keep explanatory fields in test data
@@ -111,3 +129,5 @@
 variableScope:src/openvpn/networking_sitnl.c:1390
 # IGN: nicer to keep the "variable" earlier
 variableScope:src/openvpnserv/interactive.c:2687
+# FP: fun:platform_create_temp_file: cppcheck is confused
+wrongPrintfScanfArgNum:src/openvpn/platform.c:553
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 6d9c181..de3d467 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -324,7 +324,7 @@
 {
     struct multi_instance *mi = NULL;
 
-    uint8_t *ptr = BPTR(&m->top.c2.buf);
+    const uint8_t *ptr = BPTR(&m->top.c2.buf);
     uint8_t op = ptr[0] >> P_OPCODE_SHIFT;
     bool v2 = (op == P_DATA_V2) && (m->top.c2.buf.len >= (1 + 3));
     bool peer_id_disabled = false;
@@ -376,7 +376,7 @@
         return NULL;
     }
 
-    uint8_t *ptr = BPTR(&m->top.c2.buf);
+    const uint8_t *ptr = BPTR(&m->top.c2.buf);
     uint8_t op = ptr[0] >> P_OPCODE_SHIFT;
 
     struct mroute_addr real = { 0 };
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 60a5148..74939bf 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3095,8 +3095,8 @@
 
     struct multi_instance *ex_mi = he->value;
 
-    struct tls_multi *m1 = mi->context.c2.tls_multi;
-    struct tls_multi *m2 = ex_mi->context.c2.tls_multi;
+    const struct tls_multi *m1 = mi->context.c2.tls_multi;
+    const struct tls_multi *m2 = ex_mi->context.c2.tls_multi;
 
     struct gc_arena gc = gc_new();
     int ret = false;
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index d8cc708..3604684 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -191,12 +191,12 @@
 int
 multi_io_wait(struct multi_context *m)
 {
-    int status, i;
+    int status;
     unsigned int *persistent = &m->multi_io->tun_rwflags;
 
     if (!tuntap_is_dco_win(m->top.c1.tuntap))
     {
-        for (i = 0; i < m->top.c1.link_sockets_num; i++)
+        for (int i = 0; i < m->top.c1.link_sockets_num; i++)
         {
             socket_set_listen_persistent(m->top.c2.link_sockets[i], m->multi_io->es,
                                          &m->top.c2.link_sockets[i]->ev_arg);
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 7d35195..24d6bb6 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -32,7 +32,6 @@
 #include "win32.h"
 #include "options_show.h"
 #include "platform.h"
-#include "string.h"
 
 #include "memdbg.h"
 
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index faf5a27..c92c423 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -286,7 +286,7 @@
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 {
-    char *tmp_ciphers, *tmp_ciphers_orig, *token;
+    char *tmp_ciphers, *tmp_ciphers_orig;
 
     if (NULL == ciphers)
     {
@@ -306,7 +306,7 @@
     char *lasts = NULL;
     tmp_ciphers_orig = tmp_ciphers = string_alloc(ciphers, NULL);
 
-    token = strtok_r(tmp_ciphers, ":", &lasts);
+    const char *token = strtok_r(tmp_ciphers, ":", &lasts);
     while (token)
     {
         ctx->allowed_ciphers[i] = mbedtls_ssl_get_ciphersuite_id(tls_translate_cipher_name(token));
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 5ec6781..a732c2b 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -562,7 +562,7 @@
 static void
 test_calc_session_id_hmac_static(void **ut_state)
 {
-    uint8_t key[SIPHASH_KEY_SIZE] = { 1, 2, 3, 0 };
+    const uint8_t key[SIPHASH_KEY_SIZE] = { 1, 2, 3, 0 };
     static const int handwindow = 100;
 
     struct openvpn_sockaddr addr = { 0 };


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
