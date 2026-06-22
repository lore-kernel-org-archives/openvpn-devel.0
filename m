Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467AACDB470
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 12:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JLJ9hG1mdALqT/xEkUR8KJhaZyKxZrAjIhJdsgXGz0A=; b=NwYLlUajY+rKv308AzzP5b+bmi
	SlV7P5jaH+TJaFlqhyhsiP2v/duw9w6PlzPdYW7Tp8TELAGcUwb5WEvX2dcBi+OMXPDHmYJaG6QH6
	TW6hxDwvatghrWt8JzUjJe3QCGoUyM6c9NuDNXYpbYH3XNLiG/GM1SOH+UkZubQl+nYw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbdSj-0003Lj-Qp;
	Mon, 22 Jun 2026 12:09:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wbdSh-0003Lc-AU
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 12:09:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mOAtBA3XSNDElyLnFD7em1xv64hgr355xDnUMzI87vM=; b=kVb/ajdTveUUcKlbisZcGyDSDo
 dLxafQorXb+HM7yAworRFSY6cRdT38CcfZmoyt3ZRRWFEeZdvl7lo1m4LEbMWYgVZQSMEmN1s8KM3
 fjCQZPrwuqZCSwQJmi393Re95qXj7WEsWudPGU7wdBofbED3ubGKRcHWr1eRplllm9bs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mOAtBA3XSNDElyLnFD7em1xv64hgr355xDnUMzI87vM=; b=R/FK4CZs3KkMCezD28pQYw933N
 I0OOg80Rip5g8DKmKstNU+J+iCXK+Iwk+D1hkSDKWS0dyTCs4KIUHIkfThu0PGJ6TW4yP1BSZx5cp
 uNzpUpyRUgScM7UFn9M9J/MUE0UrTd4IYGh6kPeygN5iu3fWV0/h4Blotvk042EOTSmk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbdSf-0003wR-JA for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 12:09:11 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 65MC8vG6021605
 for <openvpn-devel@lists.sourceforge.net>; Mon, 22 Jun 2026 14:08:57 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 65MC8voa021604
 for openvpn-devel@lists.sourceforge.net; Mon, 22 Jun 2026 14:08:57 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 22 Jun 2026 14:08:51 +0200
Message-ID: <20260622120856.21586-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782077103000.I49b37b5a90554fa2d4a83c8fc5608dad2a36b835@gerrit.openvpn.net>
References: <gerrit.1782077103000.I49b37b5a90554fa2d4a83c8fc5608dad2a36b835@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wbdSf-0003wR-JA
Subject: [Openvpn-devel] [PATCH v3] options: fix use-after-free of DNS
 options on client connect
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

struct dns_options embeds its own gc_arena. When inherit_context_child()
/inherit_context_top() copy struct options by value, the child shares the
parent's DNS arena. options_detach() detached o->gc but not
o->dns_options.gc, so pre_connect_restore()'s gc_free() (and context
teardown) freed allocations the parent still referenced.

With one or more non-pushed --dhcp-option directives that yield a DNS
entry, a connecting client triggers this and the server crashes
(use-after-free in setenv_dns_options(), reported as a double free).

Detach o->dns_options.gc as well, mirroring the existing o->gc handling.

Change-Id: I49b37b5a90554fa2d4a83c8fc5608dad2a36b835
GitHub: closes openvpn/OpenVPN#1060
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1715
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1715
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0c2866c..75bd87c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1531,7 +1531,18 @@
 void
 options_detach(struct options *o)
 {
+    /* The options struct carries two gc_arena's (one generic and one specific
+     * to the DNS settings), which the by-value options
+     * copy in inherit_context_child()/inherit_context_top() shares with the
+     * source.
+     *
+     * Detach both (i.e. re-initialize them), otherwise child's call of
+     * gc_free() (or context teardown) would free allocations the source
+     * context still references, leading to a use-after-free (and subsequent
+     * double-free).
+     */
     gc_detach(&o->gc);
+    gc_detach(&o->dns_options.gc);
     o->routes = NULL;
     o->client_nat = NULL;
     clone_push_list(o);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
