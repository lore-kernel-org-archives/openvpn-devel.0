Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46112606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fDvbOllb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gLDBH9Lp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=avv74TCY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kstM9lHvMsIRp/iv1nLCghB32a5vin5oAkPHC1lu+rQ=; b=fDvbOllbUl4wSB
	7JjXRaLCCaYCbF2wu9oMiPPrDavtUxMdiAf7vbx/qZv7pyTsjVIxT1L0iOWapXyERufpq5tUA2KzC
	LTXwYagzeomvTvmDG+Bx8QQ/6K8iUqvXE2Tlag/zZ1AGgHGPtrINHVGfy1IKa24JRP6Fl33Qg+5+z
	JLU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMAGO-0000000013l-1MY2;
	Wed, 28 Oct 2026 20:28:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xMAGM-0000000013e-18eC for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 20:28:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ALdFeJqzq8QUtZqtxXka0U/wtumFWQVjskVe34WAQjg=; b=gLDBH9LpmRWiNFuHs8k7iZ8+3T
 KyBBftNeb4Rr9xvyLiee8xcbwwoyC18A/2k0FsiEbDsTB6pTtc0btWjou5fynvlzEoZf4hGr5vclm
 FT8/vOcaOkfEYzoLCy9wRjmXhupQ5oIU51mBG7z8CPx3dTq4wfwY2XuRDp2UkZCRJoW4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ALdFeJqzq8QUtZqtxXka0U/wtumFWQVjskVe34WAQjg=; b=avv74TCYzZtvi/XgkqxO3RrHbr
 UOs7I/eFsxDrcx3lq/OKrE5pDlUi1zugRT0/8PW6MFPDprKdVngCjPVNLWuliBKfVHLkg2gHwy9WW
 0Fs4swM1bzzcqzCaJIKy0AcnbR4frjExjjK5fzOFHa47hmihfnX3NeGyDdpP47V1MB/w=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMAGL-000000002Pj-1O9y for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 20:28:46 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69SKScln014820
 for <openvpn-devel@lists.sourceforge.net>; Wed, 28 Oct 2026 21:28:38 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69SKScnw014819
 for openvpn-devel@lists.sourceforge.net; Wed, 28 Oct 2026 21:28:38 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 28 Oct 2026 21:28:32 +0100
Message-ID: <20261028202838.14796-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793203931000.Iad51b2f31e4215c58e160cc6239836015ea4d3cf@gerrit.openvpn.net>
References: <gerrit.1793203931000.Iad51b2f31e4215c58e160cc6239836015ea4d3cf@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xMAGL-000000002Pj-1O9y
Subject: [Openvpn-devel] [PATCH v2] Track number of assigned peer ids and
 use it for max-clients check
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
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arne Schwabe <arne@rfc2549.org>

In the past we used the real address hash as proxy for the number
of connected clients. TCP connections do not really need
this and we might remove adding them to this hash map in the future.
UDP connections only need to be added to this hash map in a later stage
of the connection process and then only for peers that do not support
DATA_V2.

Instead have a simple counter that is kept up to date when a peer id
is assigned and freed. This also allows this to be decoupled from
the real addresses hash.

Reported-by: Ar-maan05 https://github.com/OpenVPN/openvpn/issues/1127
Github: Closes OpenVPN/openvpn#1127
Change-Id: Iad51b2f31e4215c58e160cc6239836015ea4d3cf
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2064
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2064
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e302a81..82757f4 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -621,6 +621,8 @@
             {
                 m->max_peerid--;
             }
+
+            m->assigned_peer_ids--;
         }
 
         schedule_remove_entry(m->schedule, (struct schedule_entry *)mi);
@@ -749,7 +751,7 @@
 
     mi->context.c2.tls_multi->multi_state = CAS_NOT_CONNECTED;
 
-    if (hash_n_elements(m->hash) >= m->max_clients)
+    if (m->assigned_peer_ids >= m->max_clients)
     {
         msg(D_MULTI_ERRORS,
             "MULTI: new incoming connection would exceed maximum number of clients (%u)",
@@ -4219,6 +4221,8 @@
     {
         m->max_peerid = mi->context.c2.tls_multi->rx_peer_id;
     }
+
+    m->assigned_peer_ids++;
 }
 
 /**
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 5db7147..cc7ccd3 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -174,6 +174,8 @@
     uint32_t max_peerid;               /**< highest currently allocated peer-id
                                         * and maximum allocated/valid index in
                                         * instances */
+    uint32_t assigned_peer_ids;        /**< Number of peer-ids that are
+                                        *   currently assigned */
     struct hash *hash;                 /**< VPN tunnel instances indexed by real
                                         *   address of the remote peer. */
     struct hash *vhash;                /**< VPN tunnel instances indexed by


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
