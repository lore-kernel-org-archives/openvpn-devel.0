Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50214C55174
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rbhaM9dsCgZz+Zshwcpm87u14YCAuvZBc559FzJgyTY=; b=B4wSD0byvT2Toq6zrZQXiiM4qU
	Z0vsj5Zr/JVJnFr8+A3BxYNtaBTf9dEm5N0dpvkhQsR8iB6+/6W7g7ufM63JYH3+5Ib/vVxHKYj8v
	Wi2PL5w5tXDDvLwJL/y9GerkqKARghr9YonPtu2XKIW6l8VTcbHOEoQ5vCN8r8RkWqlI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wreZz-0006yO-8w;
	Wed, 05 Aug 2026 16:34:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wreZy-0006yD-6w
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 16:34:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nvJybsn1c7JZYY5cJoQQZZgBlbsczaHyqoR6SxNyq1E=; b=MjedzRTcGfWmb4g780VhKT1e+0
 T6Pi4vhnE1WAJs7JDAMeXZQLGHGK82rbpKS3i5SiOU4l0ch1jFslVUkqwP7C/2+nkmq7/7ARMoKWf
 REbtIjYntUxgAVQSl/MC3nmDG1LTa0a1fehtxnfrd1DEQ7nKFNCFqk2Bg25CzOSekTmY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nvJybsn1c7JZYY5cJoQQZZgBlbsczaHyqoR6SxNyq1E=; b=DY8x7zMJzRFwHggPo5C1Z+BUWn
 adp131eVG/Y7lsuzVTE5Ti+9WY98CG9gFhiyAEDPe2dvB1S5hK71yNMYCgPuBw/NFWWj+8Df5EWmH
 roH143hisiIDdF0sJ6OS5WAblV1pGeblU12u8M/h0vNYgcETLuf/VPTncTpS7Qhs/0Ss=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wreZx-0008Hc-Ag for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 16:34:54 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 675GYkDx029346
 for <openvpn-devel@lists.sourceforge.net>; Wed, 5 Aug 2026 18:34:46 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 675GYkPB029345
 for openvpn-devel@lists.sourceforge.net; Wed, 5 Aug 2026 18:34:46 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  5 Aug 2026 18:34:40 +0200
Message-ID: <20260805163445.29330-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1785893242000.Icc0721fd4a910110507d06b4e941e9e6dbb11e9f@gerrit.openvpn.net>
References: <gerrit.1785893242000.Icc0721fd4a910110507d06b4e941e9e6dbb11e9f@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wreZx-0008Hc-Ag
Subject: [Openvpn-devel] [PATCH v2] ssl: reject a pushed epoch data format
 tag with a non-AEAD cipher
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

From: Antonio Quartulli <antonio@mandelbit.com>

The epoch data key format is defined for AEAD ciphers only. Both places
that enable it locally verify this - multi.c when picking the cipher to
push and ssl_ncp.c for p2p NCP - but the pulling side imports the
"aead-epoch" protocol flag without validating it against the cipher that
was actually negotiated.

A peer pushing "protocol-flags aead-epoch" together with a non-AEAD
cipher therefore makes us reach the M_FATAL in init_key_contexts() and
terminate the process. This can be triggered whenever a non-AEAD cipher
is part of our own --data-ciphers, which is not unusual in
configurations kept compatible with old peers, e.g.

  data-ciphers AES-256-GCM:AES-256-CBC

Validate the combination in do_deferred_options(), next to the existing
data v2 check, so that the mismatch is reported as an OPTIONS ERROR and
the connection is restarted. Turn the now unreachable M_FATAL in
init_key_contexts() into a session error as well, so that no future code
path can promote this to a process exit.

Change-Id: Icc0721fd4a910110507d06b4e941e9e6dbb11e9f
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1836
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1836
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0236886..84de986 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2711,6 +2711,18 @@
         return false;
     }
 
+    /* The epoch data format is defined for AEAD ciphers only. A peer may push
+     * the tag along with a non-AEAD cipher, so this has to be checked here
+     * rather than trusted */
+    if (epoch_data && !cipher_kt_mode_aead(c->options.ciphername))
+    {
+        msg(D_PUSH_ERRORS,
+            "OPTIONS ERROR: Epoch key data format tag requires an AEAD "
+            "cipher, but '%s' was negotiated.",
+            c->options.ciphername);
+        return false;
+    }
+
 
     if (found & OPT_P_PUSH_MTU)
     {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index b5ab51e..2c7e672 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1413,10 +1413,14 @@
     {
         if (!cipher_kt_mode_aead(key_type->cipher))
         {
-            msg(M_FATAL,
-                "AEAD cipher (currently %s) "
+            /* The pulled options are validated in do_deferred_options(), so
+             * reaching this point means a code path escaped that check. Fail
+             * the session instead of the whole process */
+            msg(D_TLS_ERRORS,
+                "TLS Error: AEAD cipher (currently %s) "
                 "required for epoch data format.",
                 cipher_kt_name(key_type->cipher));
+            return KEY_GEN_FAILED;
         }
         init_epoch_keys(ks, multi, key_type, server, key2);
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
