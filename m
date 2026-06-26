Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBF3C43458
	for <openvpn-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1mup4dMEPdIln5KXdCzq4XHDRjsrQKNO5Zm+FmxNUPA=; b=XUCPvvuzltYYK/RbRDQgGN60u0
	IqV9Z6xKtmPoZDulhBFdGC3tizTHQgzGGrjbYOz5RHJvGeBspGr/xfVbku7tUc83ZBAZtTKuy70hS
	T8Ax3RcP6LroBU8crWsVqcEdUd1DBkXj7yRdExdqyNKhCdofJeBPHbK4GwkWe6hzhkwM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wd8Vs-0007WH-CI;
	Fri, 26 Jun 2026 15:30:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wd8VY-0007Vq-Li
 for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 15:30:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V9vSu3C/sIYSvdNowAdX9Ev6DaW/6HC+v+QvsfN0bcQ=; b=YbdRtlvsqmT6LHAx/0x4OmyA42
 YjWjJyfoecczLjPMZxPpTALrRd3o7Fm97DXNicQPBXiy+ALtM64X0wPs+s69Kx+y3l6Mt8wMXegnI
 sS47bE/VRSDE8aGUKbX9erC4Rj2X/9cXuk/4GyaZBB6eJRJjGP8IUB98ZeEA663HfuAU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=V9vSu3C/sIYSvdNowAdX9Ev6DaW/6HC+v+QvsfN0bcQ=; b=LurtpiDrYf9IOlNeFPZjVvhmTV
 2vMbGvWAKwFWEj8tvyCrOQz65+740Roc5ylO2ZWNnZ118d1qG/YQJ8P0ihIvLnTUoo32eL3YuVmuh
 +0L1dFP8/tCepNqbizSKU2mo/wOXKq96GB/no8qTDwOkBBhrJeCNuvMMRA8SA889mCVE=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wd8VH-0008Hn-91 for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 15:30:05 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 65QFTpXF029229
 for <openvpn-devel@lists.sourceforge.net>; Fri, 26 Jun 2026 17:29:51 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 65QFTp1w029227
 for openvpn-devel@lists.sourceforge.net; Fri, 26 Jun 2026 17:29:51 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 26 Jun 2026 17:29:46 +0200
Message-ID: <20260626152951.29207-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782486295000.Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125@gerrit.openvpn.net>
References: <gerrit.1782486295000.Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wd8VH-0008Hn-91
Subject: [Openvpn-devel] [PATCH v2] Make get_random return int64 instead of
 long
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

This avoids having get_ranomd being different on 32bit/Windows vs
64 bit Unix platform. Also adjust platform_create_temp_file to
create the same files on all platforms.

Change-Id: Ifefb3ad204c0c16cb4952dd6e8661fdc9136b125
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1732
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1732
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 7954e8a..3d79fe5 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1731,11 +1731,12 @@
     ASSERT(rand_bytes(output, len));
 }
 
-/* an analogue to the random() function, but use prng_bytes */
-long int
+/* an analogue to the random() function, but use prng_bytes and
+ * also int64_t instead of long to avoid LLP64 vs LP64 */
+int64_t
 get_random(void)
 {
-    long int l;
+    int64_t l;
     prng_bytes((unsigned char *)&l, sizeof(l));
     if (l < 0)
     {
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index fbca2a0..ee5b50f 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -603,8 +603,13 @@
  */
 void prng_bytes(uint8_t *output, int len);
 
-/* an analogue to the random() function, but use prng_bytes */
-long int get_random(void);
+/**
+ * an analogue to the random() function, but use prng_bytes and
+ * also int64_t instead of long to avoid LLP64 vs LP64
+ *
+ * @return Returns a random positive 63 bit integer
+ */
+int64_t get_random(void);
 
 /** Print a cipher list entry */
 void print_cipher(const char *cipher);
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 9fa9363..85b6408 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -543,7 +543,7 @@
     const char *retfname = NULL;
     unsigned int attempts = 0;
     char fname[256] = { 0 };
-    const char *fname_fmt = PACKAGE "_%.*s_%08lx%08lx.tmp";
+    const char *fname_fmt = PACKAGE "_%.*s_%08" PRIx64 "%08" PRIx64 ".tmp";
     const int max_prefix_len = sizeof(fname) - (sizeof(PACKAGE) + 7 + (2 * 8));
 
     while (attempts < 6)
@@ -551,7 +551,7 @@
         ++attempts;
 
         if (!checked_snprintf(fname, sizeof(fname), fname_fmt, max_prefix_len, prefix,
-                              (unsigned long)get_random(), (unsigned long)get_random()))
+                              get_random(), get_random()))
         {
             msg(M_WARN, "ERROR: temporary filename too long");
             return NULL;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
