Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F987606A322
	for <openvpn-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Nx3TE5sy;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QXA8q6Gn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YBkpMgLx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TmufyYJjeF3foOfZaZF77DzAMA0eK77OCO8Uj/gW98c=; b=Nx3TE5sy5E8Ggi7OniL3BsAfuQ
	l1/6eeySWXbTY/M/NVlzhCAI9tYNIfR6QO5jnp0wsfL77klHi4HB5wD8PWJyjTxQmEZP+kgzFTeK2
	tFYApDDAhzKEt0qLOGfmeFSR5I0lKCgJeVWbgihUr4cBYuw9RVSdIMFUY/qam8XR0ZFQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJZdi-0007h7-Eo;
	Wed, 21 Oct 2026 16:58:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xJZdN-0007gd-OR
 for openvpn-devel@lists.sourceforge.net;
 Wed, 21 Oct 2026 16:57:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=egGkI3bGCd6eN2cgad26NjS6wPVCXPudupaWsYbaCSg=; b=QXA8q6GnaQqWxRZXJ2W9vBx7Pb
 meMmsy95pGTqgcFFnp+uGZPVysbyeWFuBFTdIfkOt+hRySA2j+D2E0pn56EarE5ddBbOKyE0V4YZg
 sSiaY/sH35+Kti3KJWJLmDjSLZ/XUmJuZi5Pgnsk7fPrE+EyaqTPLAiYy7OjFeCvqEs4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=egGkI3bGCd6eN2cgad26NjS6wPVCXPudupaWsYbaCSg=; b=YBkpMgLxwAwRl7FRSPS62KSuKw
 m/99jCEFGWunsEFZ+GsQBpb+VC8EI3EVCY/hbvtIlMvFTkpD6MExkk6kFzVfx6Ta5ZoOOaKfSpI5m
 sPURaxav0YOp74It9OkPlrQZ1xL6NhgnD/I5AcvW5IfDOpV2TTBbPGAVg+vfiQcvY0MA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJZdG-0000000010t-3HYb for openvpn-devel@lists.sourceforge.net;
 Wed, 21 Oct 2026 16:57:43 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69LGvZoh011188
 for <openvpn-devel@lists.sourceforge.net>; Wed, 21 Oct 2026 18:57:35 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69LGvZwb011185
 for openvpn-devel@lists.sourceforge.net; Wed, 21 Oct 2026 18:57:35 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 21 Oct 2026 18:57:29 +0200
Message-ID: <20261021165735.11175-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792566915000.I26fe14053446dbd215f947910565c20318c34627@gerrit.openvpn.net>
References: <gerrit.1792566915000.I26fe14053446dbd215f947910565c20318c34627@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xJZdG-0000000010t-3HYb
Subject: [Openvpn-devel] [PATCH v1] interactive: null-terminate iface.name
 in address and route handlers
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

HandleAddressMessage() and HandleRouteMessage() pass the client supplied
interface name to InterfaceLuid() and strlen() without making sure it is
null-terminated. A pipe client sending a message with iface.index set to
TUN_ADAPTER_INDEX_INVALID and a 256 byte name without a terminating NUL
makes the service read past the name into the remainder of the on-stack
pipe_message_t and beyond.

This is hardening rather than a fix for an exploitable bug: the trailing
bytes only ever reach ConvertInterfaceAliasToLuid(), which fails on them,
and nothing is returned to the client beyond an error code. Terminate the
name anyway, like HandleDNSConfigMessage() and HandleDNSConfigNrptMessage()
already do.

Github: OpenVPN/openvpn#1130
Change-Id: I26fe14053446dbd215f947910565c20318c34627
Signed-off-by: Naveed Khan <dxbnaveed.k@gmail.com>
Signed-off-by: Lev Stipakov <lev@openvpn.net>
Acked-by: Heiko Hund <heiko@openvpn.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2027
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2027
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@openvpn.net>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ed163a4..d36e8d5 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -575,6 +575,9 @@
     PMIB_UNICASTIPADDRESS_ROW addr_row;
     BOOL add = msg->header.type == msg_add_address;
 
+    /* enforce null-termination of the interface name from client */
+    msg->iface.name[_countof(msg->iface.name) - 1] = '\0';
+
     addr_row = malloc(sizeof(*addr_row));
     if (addr_row == NULL)
     {
@@ -653,6 +656,9 @@
     PMIB_IPFORWARD_ROW2 fwd_row;
     BOOL add = msg->header.type == msg_add_route;
 
+    /* enforce null-termination of the interface name from client */
+    msg->iface.name[_countof(msg->iface.name) - 1] = '\0';
+
     fwd_row = malloc(sizeof(*fwd_row));
     if (fwd_row == NULL)
     {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
