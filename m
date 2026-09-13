Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D22EC88E65
	for <openvpn-devel@archiver.kernel.org>; Sun, 13 Sep 2026 13:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i7iPv5z8RY/cHZDb7sCXV0vYZ1aGC4tAnZMVZZBJQKA=; b=XuaLSWyc52FggVYEDyic3+oKrb
	bGDQdFRzZSaow0a58gMqkaulbws1ychp+EujBIH6mFQC1Cqix8wFWiz5nG0sc/u1p/liG+r4mM9PA
	FdJ55ilCxQruMZwnt342zUiVrDUam+K6G84PQwEuGlyl90ItUbYpH/nw95lZ8+G26/ic=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5kB9-0000Wz-5G;
	Sun, 13 Sep 2026 13:23:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x5kB8-0000Wt-BU
 for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 13:23:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1hPkNIUxlgxTGy3flRcX6H0+pgpGWZrqb8I5G1UF+2U=; b=f2azQKpiHA81jfKAEgG2lwxBDF
 mIygIsH22wklfk8SoKENA4oD9ABlMltFRFi6NdMi0lyiNCoiMSv4lF6B/trJKzZhqiXG9uqAuJcg6
 1ALyPFYF+mlUR2HmDAuRVLIt0CzzycqqaSW/Xs7WjtmSDgqN3XK/AgyHAQJNZumGYRKQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1hPkNIUxlgxTGy3flRcX6H0+pgpGWZrqb8I5G1UF+2U=; b=Z/ZbJv6MVwUGB6q/1IJ+Ao8Esk
 uVtA9LAIX5FsBBUwsErvwgo0z3eh13kFXVObXecL5sUKrcoonvtfF/PamxKSyhCNY0UXIT8/v5C/r
 ey5c5QdVZkkdjpOwPuheAb+aVKUvtdPauBG+vem+8tg9KE9aTU3lA298w/UtKXzTnhk4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5kB7-0000kj-VZ for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 13:23:31 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68DDNMLb002299
 for <openvpn-devel@lists.sourceforge.net>; Sun, 13 Sep 2026 15:23:22 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68DDNMIR002298
 for openvpn-devel@lists.sourceforge.net; Sun, 13 Sep 2026 15:23:22 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 13 Sep 2026 15:23:17 +0200
Message-ID: <20260913132322.2283-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1789291650000.I3724236d4acc3d05d786274d6baf34a21c570594@gerrit.openvpn.net>
References: <gerrit.1789291650000.I3724236d4acc3d05d786274d6baf34a21c570594@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x5kB7-0000kj-VZ
Subject: [Openvpn-devel] [PATCH v2] options: fix unsigned underflow when
 clearing domain_search_list
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

From: Cole Munz <Munzzyy1@proton.me>

remove_option() and update_option() clear the domain search list with

    while (o->domain_search_list_len-- > 0)

domain_search_list_len is unsigned, and the post-decrement runs on the
final test too. When the length reaches 0 the condition is false but
the decrement has already wrapped it to UINT_MAX, so the field is left
corrupted. The next reset then does

    o->domain_search_list[UINT_MAX] = NULL

and walks far out of bounds, writing NULL through each slot. A server
can drive this reset path against a client with PUSH_UPDATE, so on
Windows and Android this is a remotely reachable out-of-bounds write.

v2:
  Change to the semantics used for all the other lists there - set
  length to 0 and clear the list with CLEAR().

Change-Id: I3724236d4acc3d05d786274d6baf34a21c570594
Signed-off-by: Cole Munz <Munzzyy1@proton.me>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1914
Github: OpenVPN/openvpn-private-issues#178
CVE: 2026-88964
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1914
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 25a3746..f6a5fe4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3778,12 +3778,12 @@
         memset(o->ntp, 0, sizeof(o->ntp));
         o->nbdd_len = 0;
         memset(o->nbdd, 0, sizeof(o->nbdd));
-        while (o->domain_search_list_len-- > 0)
-        {
-            o->domain_search_list[o->domain_search_list_len] = NULL;
-        }
+        o->domain_search_list_len = 0;
+        CLEAR(o->domain_search_list);
         o->disable_nbt = 0;
         o->dhcp_options = 0;
+        CLEAR(options->dns_options.from_dhcp);
+
 #if defined(TARGET_ANDROID)
         o->http_proxy_port = 0;
         o->http_proxy = NULL;
@@ -4082,10 +4082,8 @@
             CLEAR(o->ntp);
             o->nbdd_len = 0;
             CLEAR(o->nbdd);
-            while (o->domain_search_list_len-- > 0)
-            {
-                o->domain_search_list[o->domain_search_list_len] = NULL;
-            }
+            o->domain_search_list_len = 0;
+            CLEAR(o->domain_search_list);
             o->disable_nbt = 0;
             o->dhcp_options = 0;
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
