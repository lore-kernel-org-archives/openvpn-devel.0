Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C627CA6001
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 14:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fK1ggiiX3ZWuJ58TFZ53TacffYr7idc/YBeGbOYAEpM=; b=c0Yv8GRVPtP4GADltbWlYDUqvY
	dkkcoo3gLf8OxGsyT5BR0goQnXzJpChyYelJHA5AgI6/qi69ZwLGR9PBHs6hH4ZM0uIbBtEy3JXQg
	dzt5VCT8vQgq7D42ummsmxPBc7LhvyArpEblN4KCNeIUxdf7pbB2498alk/9/IESttmc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xE65A-0004Nw-Cs;
	Tue, 06 Oct 2026 14:23:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xE64q-0004Lo-W1
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 14:23:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q4z4IO5j/uqQ82lc2ZVH45qTFcJUeieiHIr/KNauX+0=; b=c6YoMRvW3P/q3Z1KudA9R1Vb0P
 4vyNqh/OSYoj9wquCroFLSfGM+Angk61dOD4ZRTofBu6AEzT/B2o7V0EwXULdU38NlN08KMpkVctv
 vi2urkijxObTe2ZEb2thqBfJ6EGCo1gL2fClpT7V5pCLnVzWfzWTJfMjRpglpVftXPCU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q4z4IO5j/uqQ82lc2ZVH45qTFcJUeieiHIr/KNauX+0=; b=TlDoQg7sJPuEMwWN4RgsYNoltj
 LFE/wByHQ/oWH5OIAUGyyjZXzdNo3KYUO8bdIvdRyigyGcKDXL6T7BZfyswj0alt3T1lAYJrkn5Hh
 s/e3fEjS6wdvEvfWDSqsFT2x5Ir92wzJCdAy38qggOau/Kq+KfQ9ByGkhoiwUDoRKd7s=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE64n-0001jX-AQ for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 14:23:32 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 696ENMC3004617
 for <openvpn-devel@lists.sourceforge.net>; Tue, 6 Oct 2026 16:23:22 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 696ENM97004616
 for openvpn-devel@lists.sourceforge.net; Tue, 6 Oct 2026 16:23:22 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  6 Oct 2026 16:23:15 +0200
Message-ID: <20261006142321.4601-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1755870317000.Ic30612971367a4aa54ca89f93452efc172d4f4e2@gerrit.openvpn.net>
References: <gerrit.1755870317000.Ic30612971367a4aa54ca89f93452efc172d4f4e2@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xE64n-0001jX-AQ
Subject: [Openvpn-devel] [PATCH v10] options: Introduce boolean_flag() and
 review usages of atoi_warn
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

This uses atoi_constrained. Note that this makes the tests
stricter since previously any non-zero integer would be
interpreted as "true".

Change-Id: Ic30612971367a4aa54ca89f93452efc172d4f4e2
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1151
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1151
This mail reflects revision 10 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5d10390..f19f683 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6388,7 +6388,7 @@
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->sc_info.challenge_text = p[1];
-        if (atoi_warn(p[2], msglevel))
+        if (boolean_flag(p[2], "static-challenge echo", msglevel))
         {
             options->sc_info.flags |= SC_ECHO;
         }
@@ -6763,7 +6763,7 @@
         options->exit_event_name = p[1];
         if (p[2])
         {
-            options->exit_event_initial_state = (atoi_warn(p[2], msglevel) != 0);
+            options->exit_event_initial_state = boolean_flag(p[2], "service state", msglevel);
         }
     }
     else if (streq(p[0], "allow-nonadmin") && !p[2])
@@ -7720,7 +7720,8 @@
     else if (streq(p[0], "show-pkcs11-ids") && !p[3])
     {
         const char *provider = p[1];
-        bool cert_private = (p[2] == NULL ? false : (atoi_warn(p[2], msglevel) != 0));
+        bool cert_private = (p[2] == NULL ? false
+                                          : boolean_flag(p[2], "show-pkcs11-ids private", msglevel));
 
 #ifdef DEFAULT_PKCS11_MODULE
         if (!provider)
@@ -7766,14 +7767,12 @@
     }
     else if (streq(p[0], "pkcs11-protected-authentication"))
     {
-        int j;
-
         VERIFY_PERMISSION(OPT_P_GENERAL);
 
-        for (j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
+        for (int j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
         {
             options->pkcs11_protected_authentication[j - 1] =
-                atoi_warn(p[j], msglevel) != 0 ? 1 : 0;
+                boolean_flag(p[j], p[0], msglevel);
         }
     }
     else if (streq(p[0], "pkcs11-private-mode") && p[1])
@@ -7789,13 +7788,11 @@
     }
     else if (streq(p[0], "pkcs11-cert-private"))
     {
-        int j;
-
         VERIFY_PERMISSION(OPT_P_GENERAL);
 
-        for (j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
+        for (int j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
         {
-            options->pkcs11_cert_private[j - 1] = (bool)(atoi_warn(p[j], msglevel));
+            options->pkcs11_cert_private[j - 1] = boolean_flag(p[j], p[0], msglevel);
         }
     }
     else if (streq(p[0], "pkcs11-pin-cache") && p[1] && !p[2])
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 779c38e..d25d85c 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -194,6 +194,14 @@
     return true;
 }
 
+bool
+boolean_flag(const char *str, const char *name, msglvl_t msglevel)
+{
+    int number = 0;
+    atoi_constrained(str, &number, name, 0, 1, msglevel);
+    return (bool)number;
+}
+
 static const char *updatable_options[] = { "block-ipv6", "block-outside-dns",
                                            "dhcp-option", "dns",
                                            "ifconfig", "ifconfig-ipv6",
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 1d4ea9b..5226a6f 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -69,6 +69,12 @@
                       msglvl_t msglevel);
 
 /**
+ * Converts a str to an boolean if the string can be parsed as either 0 or 1.
+ * Otherwise print a warning with \p msglevel and return \c false.
+ */
+bool boolean_flag(const char *str, const char *name, msglvl_t msglevel);
+
+/**
  * Filter an option line by all pull filters.
  *
  * If a match is found, the line is modified depending on
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index a41c27b..91c2a59 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -441,6 +441,22 @@
     assert_string_equal(mock_msg_buf, "test: Must be an integer >= 1, not 0");
     assert_int_equal(parameter, -42);
 
+    /* special tests for boolean_flag */
+    assert_false(boolean_flag("0", "test", msglevel));
+    assert_true(boolean_flag("1", "test", msglevel));
+
+    CLEAR(mock_msg_buf);
+    assert_false(boolean_flag("foo77", "test", msglevel));
+    assert_string_equal(mock_msg_buf, "test: Cannot parse 'foo77' as integer");
+
+    CLEAR(mock_msg_buf);
+    assert_false(boolean_flag("-77", "test", msglevel));
+    assert_string_equal(mock_msg_buf, "test: Must be an integer between 0 and 1, not -77");
+
+    CLEAR(mock_msg_buf);
+    assert_false(boolean_flag("77", "test", msglevel));
+    assert_string_equal(mock_msg_buf, "test: Must be an integer between 0 and 1, not 77");
+
     mock_set_debug_level(saved_log_level);
 }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
