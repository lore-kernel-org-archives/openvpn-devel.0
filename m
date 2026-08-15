Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17E4C5DF6A
	for <openvpn-devel@archiver.kernel.org>; Sat, 15 Aug 2026 13:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MMNMcxcdw9kUi4WVDX5V1O2bGw9g2h3oyoWJguBSeOg=; b=frbgPVVdT8enKqgD+OgTJ2brFs
	1uQA9D3VPMrqZlPhqmeDdVMddbqLYFkLmmwb6agmGSQ2zV+/LvJCMVL+F95uYw75ZrZE44JOFXG7j
	QVRC6fqb42Ek+IzQBz26RQL2tSucYcr/bA9OiKS4qjt7+Av4Gg7N1ErdN/EyycEZdfB0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvE5k-0005rS-8h;
	Sat, 15 Aug 2026 13:06:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wvE5j-0005rM-6L
 for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 13:06:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NUDX0RJmmie8kmPQLmH3tOtBBgtnWjfWCPpuNPvF/lI=; b=lGvFIKYo59Uf7v0CKJ83jy5Q66
 ac64B/2yru+Y1psxpHHFP34/MCxkKCX3gIs7NQS50Gqkxqv2sTF2gd/OX9VdIxGoaJQfIZ/jVY4pz
 PuGBkMCjX/I9ha2LZT3IjoY8BKgniYpBPkZi8KyS2G+CfnDzwZ8MNqnanRO6B50TT7OE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NUDX0RJmmie8kmPQLmH3tOtBBgtnWjfWCPpuNPvF/lI=; b=MgBd/ULFfF54x2n3aVjdOSlAc3
 x+shV3EVTBkQhynKtExoOGTj/qckBFiY0OLDvEN7V4xXD4CVsj6YZDAR4HZXTPyG0IJSe9nU+FhI/
 LAAKmn3DhUyGWGSgWPlMbrtUVIIUugtQikIwwNWwGjbaI55jSh6vlFnjGmkk63ZpUsS0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvE5l-0008Vd-JK for openvpn-devel@lists.sourceforge.net;
 Sat, 15 Aug 2026 13:06:27 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67FD6JQo020205
 for <openvpn-devel@lists.sourceforge.net>; Sat, 15 Aug 2026 15:06:19 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67FD6Jxc020204
 for openvpn-devel@lists.sourceforge.net; Sat, 15 Aug 2026 15:06:19 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 15 Aug 2026 15:06:12 +0200
Message-ID: <20260815130619.20187-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1783961511000.I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19@gerrit.openvpn.net>
References: <gerrit.1783961511000.I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wvE5l-0008Vd-JK
Subject: [Openvpn-devel] [PATCH v1] platform: Add function to determine temp
 directory
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

Move the code out of options.c and make it shareable.
Replace various stripped down versions of the code from
test_*

Change-Id: I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1780
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1780
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 87218d4..c57f398 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -881,25 +881,8 @@
     o->auth_token_generate = false;
 
     /* Set default --tmp-dir */
-#ifdef _WIN32
-    /* On Windows, find temp dir via environment variables */
-    o->tmp_dir = win_get_tempdir();
+    o->tmp_dir = platform_get_tmp_dir();
 
-    if (!o->tmp_dir)
-    {
-        /* Error out if we can't find a valid temporary directory, which should
-         * be very unlikely. */
-        msg(M_USAGE, "Could not find a suitable temporary directory."
-                     " (GetTempPath() failed).  Consider using --tmp-dir");
-    }
-#else  /* ifdef _WIN32 */
-    /* Non-windows platforms use $TMPDIR, and if not set, default to '/tmp' */
-    o->tmp_dir = getenv("TMPDIR");
-    if (!o->tmp_dir)
-    {
-        o->tmp_dir = "/tmp";
-    }
-#endif /* _WIN32 */
     o->allow_recursive_routing = false;
 
 #ifndef ENABLE_DCO
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 85b6408..6c766c2 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -584,6 +584,34 @@
     return NULL;
 }
 
+const char *
+platform_get_tmp_dir(void)
+{
+    const char *ret;
+#ifdef _WIN32
+    /* On Windows, find temp dir via environment variables */
+    ret = win_get_tempdir();
+
+    if (!ret)
+    {
+        /* Error out if we can't find a valid temporary directory, which should
+         * be very unlikely. */
+        msg(M_USAGE, "Could not find a suitable temporary directory."
+                     " (GetTempPath() failed).  Consider using --tmp-dir");
+    }
+#else
+    /* Non-windows platforms use $TMPDIR, and if not set, default to '/tmp' */
+    ret = getenv("TMPDIR");
+    if (!ret)
+    {
+        ret = "/tmp";
+    }
+#endif
+
+    return ret;
+}
+
+
 /*
  * Put a directory and filename together.
  */
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index 8e7ab7e..784427bb 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -128,6 +128,13 @@
 const char *platform_create_temp_file(const char *directory, const char *prefix,
                                       struct gc_arena *gc);
 
+/**
+ * Get a directory for temporary files
+ *
+ * @return path to a directory
+ */
+const char *platform_get_tmp_dir(void);
+
 /** Put a directory and filename together. */
 const char *platform_gen_path(const char *directory, const char *filename, struct gc_arena *gc);
 
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index 0e9cecf..065c7e3f 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -115,19 +115,6 @@
     "-----END PRIVATE KEY-----\n";
 
 
-static const char *
-get_tmp_dir(void)
-{
-    const char *ret;
-#ifdef _WIN32
-    ret = win_get_tempdir();
-#else
-    ret = "/tmp";
-#endif
-    assert_non_null(ret);
-    return ret;
-}
-
 static struct
 {
     struct gc_arena gc;
@@ -140,8 +127,8 @@
 {
     (void)state;
     global_state.gc = gc_new();
-    global_state.certfile = platform_create_temp_file(get_tmp_dir(), "cert", &global_state.gc);
-    global_state.keyfile = platform_create_temp_file(get_tmp_dir(), "key", &global_state.gc);
+    global_state.certfile = platform_create_temp_file(platform_get_tmp_dir(), "cert", &global_state.gc);
+    global_state.keyfile = platform_create_temp_file(platform_get_tmp_dir(), "key", &global_state.gc);
 
     int certfd = open(global_state.certfile, O_RDWR);
     int keyfd = open(global_state.keyfile, O_RDWR);
@@ -188,7 +175,7 @@
     cert = ctx.crt_chain;
 #endif
 
-    const char *tmpfile = platform_create_temp_file(get_tmp_dir(), "ut_pem", &gc);
+    const char *tmpfile = platform_create_temp_file(platform_get_tmp_dir(), "ut_pem", &gc);
     backend_x509_write_pem(cert, tmpfile);
 
     struct buffer exported_pem = buffer_read_from_file(tmpfile, &gc);
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 1d8ac25..a2987c6 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -720,7 +720,7 @@
         tls_options.tls_crypt_v2_verify_script = "/bin/true";
     }
 
-    tls_options.tmp_dir = "/tmp";
+    tls_options.tmp_dir = platform_get_tmp_dir();
 
     /* Since we override rand_bytes the tmpfile name is non-random as well.
      * Build the expected name via the same code path as


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
