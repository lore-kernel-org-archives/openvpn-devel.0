Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B47C982D7
	for <openvpn-devel@archiver.kernel.org>; Sat, 19 Sep 2026 19:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aIoaqvBWjpm5kO51rjazy3tD/ezPm3GBVKD/23fW9Gc=; b=iqRQPQunFHFQvNN+8Qy4ypOdhV
	fTuoS0CUq9zX6iABwcJr9GNxVBBN0BoVhx1JcyutoRp7OX9a/ZIhaXOsG2waqRAJvmWfaN0cshisF
	o+h4ghMUgtUm31sBW+kUK01/Xby6RTBfhYLcJFZXflm20f/l6NhXQNFnH6qxV0AHGFKE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x80Zr-000552-Ia;
	Sat, 19 Sep 2026 19:18:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x80Zq-00054w-JP
 for openvpn-devel@lists.sourceforge.net;
 Sat, 19 Sep 2026 19:18:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h5S82dwCx6zpx+50jAmrT8+BpA7ItGT0viqAZMQRG1E=; b=QIQzWI1f/6POpAXl57JB0GHUd0
 ZX5a7d3ZjbPDoHaj5jOQjOpaIlmbMJhfa2PjZ3cHe73Rg3qZjvvv97doraj2lyj7Tw82RlZPgioP6
 qDRCqvzOCm72YBLzed4WkrDUauxh2jkFGptDoi4NeXm5chq2xUBiC49rXNE3Gi98XadQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=h5S82dwCx6zpx+50jAmrT8+BpA7ItGT0viqAZMQRG1E=; b=XXdEWJSvZJ4oQ8L9NGc+iBkG7H
 MOPfhd3nMn/Ev4gW/4Z6fHoAZGv/ZrJna2iYjrp1BYnWrxLgIDA4DBIwGrVFgljW6oHAf4BKeJAZ2
 DZz3KaVNyxEAiVzkyAl3b+xZD59DI1u/Bmu62yH1PDTetDxMAkAk/uRsgEDzX8vwsVXE=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x80Zn-0004Fn-0D for openvpn-devel@lists.sourceforge.net;
 Sat, 19 Sep 2026 19:18:19 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68JJIBHG014675
 for <openvpn-devel@lists.sourceforge.net>; Sat, 19 Sep 2026 21:18:11 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68JJIBvq014674
 for openvpn-devel@lists.sourceforge.net; Sat, 19 Sep 2026 21:18:11 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 19 Sep 2026 21:18:04 +0200
Message-ID: <20260919191810.14656-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1785893242000.Icc0721fd4a910110507d06b4e941e9e6dbb11e9f@gerrit.openvpn.net>
References: <gerrit.1785893242000.Icc0721fd4a910110507d06b4e941e9e6dbb11e9f@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x80Zn-0004Fn-0D
Subject: [Openvpn-devel] [PATCH v3] ssl: reject a pushed epoch data format
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
This mail reflects revision 3 of this Change.

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
index 4a4feaf..23c8ec8 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1428,10 +1428,14 @@
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
