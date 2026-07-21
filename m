Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B796C4452D
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hq0RWL3AeLrLTRzvofYXRfgnNQUqZDv8DTO564Sn8uA=; b=nSGoD4tU+A5MO6drC8EBoVW2ci
	JWaUlt7iSO1rHY1USNfmdfVDp72bgDZ2PiqX/ZMshbFIU5uu2/eINS8vGyWrET4NyhqIpuOPt8t4B
	/kQo8ClVZW3+csH1BLiYK1KD0iLa+CqMAM+5DdhPuljoJ6b7Q3X1YFEpFszeFyYNLeHs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmHEJ-0004qx-AD;
	Tue, 21 Jul 2026 20:38:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wmHEH-0004qq-NZ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 20:38:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ueA6b/cRvIPwWCLCy+FVzX82xpJYGd0SNRL49Epf/1w=; b=Mj+YyHfpdB/F3uQ/zyJyt/AN2Y
 +wQA8TSUbYWgTLdmjHatQ/L4Rjl7zrL3sFhH6JJyWBf2Gcvd16fjOIBUmP8+Toni8DkEeEnv/OBzq
 i43hQZ6rnPRB8vGU/FkIyPKSjjcQ8JUtd1kTafF8YQm1YMNZ91PlEO/G2y+nWQpjeLsU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ueA6b/cRvIPwWCLCy+FVzX82xpJYGd0SNRL49Epf/1w=; b=adC2RZhtJu0vP1HB9pELB5Gz2c
 s76FHpzylZlzHxv4kaddvflK4VjpdFup9/W/J1w+jmvQjrtX4/EAnCYzKBcasjV7ov4Ru/cOVJygH
 VTgdWEvFtFpm9IOU3yWD2aseDf1x0pw1EMztUSUJraDehVqOwwy3hfkPB0T9Aytdqn0U=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmHEF-0007cD-ID for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 20:38:17 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66LKc8QK005857
 for <openvpn-devel@lists.sourceforge.net>; Tue, 21 Jul 2026 22:38:08 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66LKc8Tp005856
 for openvpn-devel@lists.sourceforge.net; Tue, 21 Jul 2026 22:38:08 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 21 Jul 2026 22:38:01 +0200
Message-ID: <20260721203807.5813-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1784390158000.I4d0887839b4a13a92e92250d1b315dec949698f3@gerrit.openvpn.net>
References: <gerrit.1784390158000.I4d0887839b4a13a92e92250d1b315dec949698f3@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wmHEF-0007cD-ID
Subject: [Openvpn-devel] [PATCH v3] dco: make key state desync recoverable
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

From: Ralf Lici <ralf@mandelbit.com>

If installing a DCO key succeeds, always record the slot in the
corresponding key_state. The installed-key counter only tracks whether
the number of kernel slots grew, but a successful KEY_NEW still means
that this key_state is associated with the selected DCO slot.

Also replace DCO key-state assertions in dco_update_keys() with error
returns. This preserves the invariant checks but lets the existing
caller restart the connection instead of aborting the process if
userspace ever detects inconsistent DCO key state.

Github: https://github.com/OpenVPN/openvpn-private-issues/issues/143
Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1795
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1795
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@mandelbit.com>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index e944547..2584368 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -73,9 +73,12 @@
 
     int ret = dco_new_key(multi->dco, multi->dco_peer_id, ks->key_id, slot, encrypt_key, encrypt_iv,
                           decrypt_key, decrypt_iv, ciphername, epoch);
-    if ((ret == 0) && (multi->dco_keys_installed < 2))
+    if (ret == 0)
     {
-        multi->dco_keys_installed++;
+        if (multi->dco_keys_installed < 2)
+        {
+            multi->dco_keys_installed++;
+        }
         ks->dco_status =
             (slot == OVPN_KEY_SLOT_PRIMARY) ? DCO_INSTALLED_PRIMARY : DCO_INSTALLED_SECONDARY;
     }
@@ -166,7 +169,13 @@
     /* if we have a primary key, it must have been installed already (keys
      * are installed upon generation in the TLS code)
      */
-    ASSERT(primary->dco_status != DCO_NOT_INSTALLED);
+    if (primary->dco_status == DCO_NOT_INSTALLED)
+    {
+        msg(D_DCO, "DCO key state mismatch: selected primary key is not installed "
+                   "(peer_id=%d, key_id=%d, dco_keys_installed=%d)",
+            multi->dco_peer_id, primary->key_id, multi->dco_keys_installed);
+        return false;
+    }
 
     struct key_state *secondary = dco_get_secondary_key(multi, primary);
     /* if the current primary key was installed as secondary in DCO,
@@ -190,6 +199,14 @@
                 primary->key_id);
         }
 
+        if (secondary && secondary->dco_status != DCO_INSTALLED_PRIMARY)
+        {
+            msg(D_DCO, "DCO key state mismatch: expected old primary key is not installed as DCO primary before swap "
+                       "(peer_id=%d, new_primary_key_id=%d, old_primary_key_id=%d, old_primary_dco_status=%d, dco_keys_installed=%d)",
+                multi->dco_peer_id, primary->key_id, secondary->key_id, secondary->dco_status, multi->dco_keys_installed);
+            return false;
+        }
+
         int ret = dco_swap_keys(dco, multi->dco_peer_id);
         if (ret < 0)
         {
@@ -200,7 +217,6 @@
         primary->dco_status = DCO_INSTALLED_PRIMARY;
         if (secondary)
         {
-            ASSERT(secondary->dco_status == DCO_INSTALLED_PRIMARY);
             secondary->dco_status = DCO_INSTALLED_SECONDARY;
         }
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
