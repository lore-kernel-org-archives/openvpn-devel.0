Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45942C5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=06fuP8aDaZRoRLtzNvQHfbHrbFqpe/GYEvAv71tP5JI=; b=RjfQm5vwpS0DK0wRhJ+lqcG4Qe
	nOB/U1gjL9uZw7C+k7IIcbDSvL9vSK4MZdz6JjoApEd0SlsFaAnvJBlVdvPNQOiZlTXJF5EKnKzz5
	uMsULXKEmrZKQoAfvW5i8b2LZaHkirlandB7bFVbOwyTXccFCnozaQytRnnKbR1xGSOk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzIkS-0006oF-Pk;
	Wed, 26 Aug 2026 18:53:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wzIkR-0006o0-ND
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 18:53:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r0BnvvpVr7IDPPFeotDWZ25DA0IJfFiEiq4llrJ13js=; b=ImH9Y7/Iz9cP1ShV3dEDmUq57v
 Fu/spS6LhYDfD8YNP8kn8LMQ3kLRZtxtcRmQk//ryutKKZJkGZUb3OVAgsHr9Vra16iIZvewkkusD
 KSrhkP4AFEnOwSP5jrwE2/R/d4OkNOH0ItBwrgkwL8TydRTn3AyAMftGrh+cKGE+79nA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=r0BnvvpVr7IDPPFeotDWZ25DA0IJfFiEiq4llrJ13js=; b=JrKcF8JzJjWnMa/O4nBkMVgATH
 r9m4U1wL1ryG7IDPbwAsdcPUYbeyKALi/LyTVDRbul7fOkX3iBenfFhR4to9SkYCtSq5uIB0Sj/NQ
 rGzLKkxdBA61jbdzpKdjTwLo+gFRiZBZ8vCuBXK/FnU/skHFHx5dJ2tkHnaJN0XOV3Ek=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzIkP-0005gW-QF for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 18:53:19 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67QIrAvF018116
 for <openvpn-devel@lists.sourceforge.net>; Wed, 26 Aug 2026 20:53:10 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67QIrALb018115
 for openvpn-devel@lists.sourceforge.net; Wed, 26 Aug 2026 20:53:10 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 26 Aug 2026 20:53:04 +0200
Message-ID: <20260826185309.18083-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787327336000.Ib7d9aa61fd878d7e025e9d1050c563dd114eb438@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib7d9aa61fd878d7e025e9d1050c563dd114eb438@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wzIkP-0005gW-QF
Subject: [Openvpn-devel] [PATCH v7] Factor out lookup_session_by_mda_key_id
 into its own method
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

This makes the code a bit easier to read and also allows reusing
the function later.

Change-Id: Ib7d9aa61fd878d7e025e9d1050c563dd114eb438
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1854
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1854
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d8dd99b..46ff1ba 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4014,6 +4014,24 @@
     }
 }
 
+static struct tls_session *
+lookup_session_by_mda_key_id(struct tls_multi *multi,
+                             const unsigned int mda_key_id)
+{
+    if (multi->session[TM_INITIAL].key[KS_PRIMARY].mda_key_id == mda_key_id)
+    {
+        return &multi->session[TM_INITIAL];
+    }
+    else if (multi->session[TM_ACTIVE].key[KS_PRIMARY].mda_key_id == mda_key_id)
+    {
+        return &multi->session[TM_ACTIVE];
+    }
+    else
+    {
+        return NULL;
+    }
+}
+
 static bool
 management_client_pending_auth(void *arg, const unsigned long cid, const unsigned int mda_key_id,
                                const char *extra, unsigned int timeout)
@@ -4024,17 +4042,9 @@
     if (mi)
     {
         struct tls_multi *multi = mi->context.c2.tls_multi;
-        struct tls_session *session;
+        struct tls_session *session = lookup_session_by_mda_key_id(multi, mda_key_id);
 
-        if (multi->session[TM_INITIAL].key[KS_PRIMARY].mda_key_id == mda_key_id)
-        {
-            session = &multi->session[TM_INITIAL];
-        }
-        else if (multi->session[TM_ACTIVE].key[KS_PRIMARY].mda_key_id == mda_key_id)
-        {
-            session = &multi->session[TM_ACTIVE];
-        }
-        else
+        if (!session)
         {
             return false;
         }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
