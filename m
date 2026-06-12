Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8944ACD8CA8
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MtI2gPCY/x1aos8t4yxqEFg8DiInf278A0mswhhm0uk=; b=U3kTNiRoinxXQou4BtmZ3XmMCg
	yHXy7uo/N8xhevTRWHirpy2r6NFWGsQUm/NWb+3jR2v/Q0epA9wJZubd5vcE67/joyOqUfg0xmgu6
	TxYQv6QVD2E21LGMA0uMu4RIHjRCYLz3ceKG8ZZP8xHFjJy8sUy2N1v3mPqbECFUWXB8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wY08a-0004n0-CO;
	Fri, 12 Jun 2026 11:33:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wY08Z-0004mt-3v
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 11:33:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PcZm2482skWE6XCcc1J9OAgBV3v+JWkSDHCiwc11Rm8=; b=CzXWvHO61yvj8plV9R+RYQbswy
 Qk0krrhB4cB/c8ZNcChailOHTq+LTBA91BrhiWbIBJwRNpveBONHZWLVHaisiHPnjdbUD8lxbrdBu
 7M21l0Q+qxzUTZDMADPeIN4LFk4r5PACtStrFK5fV0Q3ju/XCN7E03ZfYvh07H0CfA1A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PcZm2482skWE6XCcc1J9OAgBV3v+JWkSDHCiwc11Rm8=; b=RhDdk8XMizzk/waguUEAjYsGGt
 Z3OHOAfvpK0aGK1o1IPnm+YF/HLBh00YDdCUP63lJnushf7JJluLPeXEipFBnDAuC5emsAo6Vx/W7
 Fgyr+4eULOEG6sIFRzk86G4il+YKgmeP30wtodFCNMKM/aFzmebhExa3MIoTpFrx9N1U=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wY08W-0000X0-UT for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 11:33:23 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 65CBX91F029927
 for <openvpn-devel@lists.sourceforge.net>; Fri, 12 Jun 2026 13:33:09 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 65CBX9lO029926
 for openvpn-devel@lists.sourceforge.net; Fri, 12 Jun 2026 13:33:09 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 12 Jun 2026 13:33:02 +0200
Message-ID: <20260612113309.29903-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1761063820000.Icc31b7fa0da86220df45552aecc15dc6c769cd54@gerrit.openvpn.net>
References: <gerrit.1761063820000.Icc31b7fa0da86220df45552aecc15dc6c769cd54@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wY08W-0000X0-UT
Subject: [Openvpn-devel] [PATCH v12] push: Fix conversion issues related to
 timeout in send_auth_pending_messages
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

Add additional checking to make sure that the required
casts are safe.

Change-Id: Icc31b7fa0da86220df45552aecc15dc6c769cd54
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1293
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1293
This mail reflects revision 12 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 564ce86..e391147 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -429,11 +429,6 @@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 send_auth_pending_messages(struct tls_multi *tls_multi, struct tls_session *session,
                            const char *extra, unsigned int timeout)
@@ -449,7 +444,12 @@
     /* Calculate the maximum timeout and subtract the time we already waited */
     unsigned int max_timeout =
         max_uint(tls_multi->opt.renegotiate_seconds / 2, tls_multi->opt.handshake_window);
-    max_timeout = max_timeout - (now - ks->initial);
+    time_t time_elapsed = now - ks->initial;
+    if (time_elapsed < 0 || time_elapsed >= (time_t)max_timeout)
+    {
+        return false;
+    }
+    max_timeout -= (unsigned int)time_elapsed;
     timeout = min_uint(max_timeout, timeout);
 
     struct gc_arena gc = gc_new();
@@ -734,6 +734,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static bool
 send_push_options(struct context *c, struct buffer *buf, struct push_list *push_list, int safe_cap,
                   bool *push_sent, bool *multi_push)
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 0804d2d..31ecf13 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -922,8 +922,9 @@
             buf_chomp(iv_buf);
             buf_chomp(extra_buf);
 
+            errno = 0;
             long timeout = strtol(BSTR(timeout_buf), NULL, 10);
-            if (timeout <= 0)
+            if (timeout <= 0 || (unsigned long)timeout > UINT_MAX || errno)
             {
                 msg(M_WARN, "could not parse auth pending file timeout");
                 buffer_list_free(lines);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
