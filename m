Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E970606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 23 Oct 2026 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=N9eutXYN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Jed7M3/4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WeOBf1B3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=R/9ata3nbqR0Kb676h932HbvBavtKVAejTxqEnxsgYI=; b=N9eutXYNuN9pfX
	JDBan692yDQfiEatInkIcqyw9PjUPUzIUu3KX5W7cV+wU52jRC73R0EuEw5QzEeXdjCoNKhY6FzzX
	MCIDLPw8HDtItitgJfEchPD/8icoJTq4vZa5861Rb9qqwK93BI5T5NomLfrYa0ox5CXieAnO/MAc0
	PKQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xKKRG-000000001s8-0Maz;
	Fri, 23 Oct 2026 18:56:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xKKRE-000000001s2-0kjc for openvpn-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 18:56:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QiRN3hdUN3eAma9Fghyc5LOSWgV/AdoOs+ZVW7geTdE=; b=Jed7M3/4bvo88BXENIKwEcv4nA
 BxsaAlzlaBb1Hwqx18ZFRto1769A4RaGqLXCeGbMwu8JZUaFf27MSz1Gb0CC7r683pNdih2X58Iiw
 dsxHjRbrljij8ZEzaFR2aRQ8szq/43lctUKPjM98wksKnka+VkWb3/2jEZuwys+07Qa4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QiRN3hdUN3eAma9Fghyc5LOSWgV/AdoOs+ZVW7geTdE=; b=WeOBf1B3hB4NtNOlu1nMnA6Ne1
 HFK3/Bci28pkLZgUhvm+PKzQWxTocWWmr8dCVM5HEz3NOetCld6yJu18wHuA3Cf9z+Q6xTEHzk0+v
 WVQHto1PLydBwQS4JyAX9607en2w/ZRgiDKYJLj/aBz5YbIObW1F31zLyd/+K50ASOs4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xKKRC-000000006T7-2LNA for openvpn-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 18:56:24 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69NIuF9I005216
 for <openvpn-devel@lists.sourceforge.net>; Fri, 23 Oct 2026 20:56:15 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69NIuFRt005215
 for openvpn-devel@lists.sourceforge.net; Fri, 23 Oct 2026 20:56:15 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 23 Oct 2026 20:56:09 +0200
Message-ID: <20261023185614.5201-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792779949000.I0083c6c5460ff2aff638598ac26f99fd30d01fd1@gerrit.openvpn.net>
References: <gerrit.1792779949000.I0083c6c5460ff2aff638598ac26f99fd30d01fd1@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xKKRC-000000006T7-2LNA
Subject: [Openvpn-devel] [PATCH v1] interactive: validate message size for
 dns/nrpt/wins handlers
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Naveed Khan <dxbnaveed.k@gmail.com>

HandleMessage() dispatches every fixed-size request only after checking
that msg.header.size equals the size of the expected struct: address,
route, flush_neighbors, wfp_block, enable_dhcp, set_mtu and
create_adapter all do this. The dns, nrpt and wins config handlers do
not, so they inherit only the generic gate (header.size <= sizeof the
message union).

The stack message object is not zeroed, so an unprivileged pipe client
can send an undersized dns/nrpt/wins message and have the service act on
uninitialized stack memory: addr_len, the address array, family, the
interface name and the domain lists are all read beyond the bytes that
were actually received. The service runs as SYSTEM and takes these
messages from any local user, so it should apply the same size check the
other handlers already use.

Add the matching msg.header.size == sizeof(...) check to the dns,
nrpt_dns and wins cases.

Acked-by: Heiko Hund <heiko@ist.eigentlich.net>
Change-Id: I0083c6c5460ff2aff638598ac26f99fd30d01fd1
Signed-off-by: Naveed Khan <dxbnaveed.k@gmail.com>
Acked-by: Heiko Hund <heiko@openvpn.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2030
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2030
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@openvpn.net>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index d36e8d5..e8203c6e 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -3292,20 +3292,27 @@
 
         case msg_add_dns_cfg:
         case msg_del_dns_cfg:
-            ack.error_number = HandleDNSConfigMessage(&msg.dns, lists);
+            if (msg.header.size == sizeof(msg.dns))
+            {
+                ack.error_number = HandleDNSConfigMessage(&msg.dns, lists);
+            }
             break;
 
         case msg_add_nrpt_cfg:
         case msg_del_nrpt_cfg:
-        {
-            DWORD ovpn_pid = proc_info->dwProcessId;
-            ack.error_number = HandleDNSConfigNrptMessage(&msg.nrpt_dns, ovpn_pid, lists);
-        }
-        break;
+            if (msg.header.size == sizeof(msg.nrpt_dns))
+            {
+                DWORD ovpn_pid = proc_info->dwProcessId;
+                ack.error_number = HandleDNSConfigNrptMessage(&msg.nrpt_dns, ovpn_pid, lists);
+            }
+            break;
 
         case msg_add_wins_cfg:
         case msg_del_wins_cfg:
-            ack.error_number = HandleWINSConfigMessage(&msg.wins, lists);
+            if (msg.header.size == sizeof(msg.wins))
+            {
+                ack.error_number = HandleWINSConfigMessage(&msg.wins, lists);
+            }
             break;
 
         case msg_enable_dhcp:


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
