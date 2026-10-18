Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB40CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+1OfWQYhghm75AuJ7jXpE3zBh+pvm6hrqwWD7dXJuM0=; b=JeqVBi2/E4Oa/AYU3i6LOJe3VS
	9x2hdnIjKaRV4aHvgjCj7Gw675O1hKwFohZWo1emrduZ1V1UVHgBXcoiHI6E1VS0aflOByoZyQHOj
	GkrCyyA36N+JWnmnsHcsCi677/JkG8RkSOrZzI+YsJkZUsce2jpA3HKoIfW5W2iPqDVo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xISHF-0000t3-0z;
	Sun, 18 Oct 2026 14:54:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xISHE-0000sw-1b
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 14:54:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o4/NCngruOsLeNbzZbGAYm3GGoup3PMtyHEpfEWV5As=; b=HhfEN73NX/oJIczGfVRYfWPJYD
 a3SubiVzZyn7x1nY5OZQnwMdjZJYGZ/q1jJmWuS4bvwTNX16phC26ZzShehzBp/QfMXG4hchNyDmW
 LDnLQdazZ1MPth0ET8rYvodTvnVnFlkzNnH6qu5qjtuC8ljwHVuY9Q2YAQE8OLDwPnGU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o4/NCngruOsLeNbzZbGAYm3GGoup3PMtyHEpfEWV5As=; b=dCY4A5ypGy4EjXRGSCd8HqWdqJ
 /0TUpO8Nq2iFNOL4uDD+R8EF9QGYDjVn0eeDWEXS0d8X5+EFKZ2h+R/Fk+4BHdRjXDAr/NxoXRSRE
 IREOnsqaTOKoNLD8zkYkImERjTE0AZojkac0DRzzgeOFwKIPynUHFKgB+yB2hmtBYp4s=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xISHD-0006qC-1D for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 14:54:19 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69IEsCit019788
 for <openvpn-devel@lists.sourceforge.net>; Sun, 18 Oct 2026 16:54:12 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69IEsCj6019787
 for openvpn-devel@lists.sourceforge.net; Sun, 18 Oct 2026 16:54:12 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 18 Oct 2026 16:54:06 +0200
Message-ID: <20261018145411.19775-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792325770000.I10ebb5821829bf738e58fec23f9f9dd65d4626d3@gerrit.openvpn.net>
References: <gerrit.1792325770000.I10ebb5821829bf738e58fec23f9f9dd65d4626d3@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xISHD-0006qC-1D
Subject: [Openvpn-devel] [PATCH v2] Fix cppcheck warnings on macOS
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

- Replace bzero with CLEAR/memset

   memset is nowadays preferred to bzero

- add_route_ipv6: Fix %d used with unsigned int
- add const to two variables that can be const

Found-By: cppcheck on macOS
Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3
Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2014
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2014
This mail reflects revision 2 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 8e93404..0b1634c 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1862,7 +1862,7 @@
 #elif defined(TARGET_ANDROID)
     char out[64];
 
-    snprintf(out, sizeof(out), "%s/%d %s", network, r6->netbits, device);
+    snprintf(out, sizeof(out), "%s/%u %s", network, r6->netbits, device);
 
     status = management_android_control(management, "ROUTE6", out);
 
@@ -3348,10 +3348,10 @@
     rtm_addrs = RTA_DST | RTA_NETMASK | RTA_IFP;
 #endif
 
-    bzero(&m_rtmsg, sizeof(m_rtmsg));
-    bzero(&so_dst, sizeof(so_dst));
-    bzero(&so_mask, sizeof(so_mask));
-    bzero(&rtm, sizeof(struct rt_msghdr));
+    CLEAR(m_rtmsg);
+    CLEAR(so_dst);
+    CLEAR(so_mask);
+    CLEAR(rtm);
 
     rtm.rtm_type = RTM_GET;
     rtm.rtm_flags = RTF_UP | RTF_GATEWAY;
@@ -3566,10 +3566,10 @@
     rtm_addrs = RTA_DST | RTA_NETMASK | RTA_IFP;
 #endif
 
-    bzero(&m_rtmsg, sizeof(m_rtmsg));
-    bzero(&so_dst, sizeof(so_dst));
-    bzero(&so_mask, sizeof(so_mask));
-    bzero(&rtm, sizeof(struct rt_msghdr));
+    CLEAR(m_rtmsg);
+    CLEAR(so_dst);
+    CLEAR(so_mask);
+    CLEAR(rtm);
 
     rtm.rtm_type = RTM_GET;
     rtm.rtm_flags = RTF_UP;
@@ -3654,7 +3654,7 @@
     /* get gateway addr and interface name */
     if (gate != NULL)
     {
-        struct sockaddr_in6 *s6 = (struct sockaddr_in6 *)gate;
+        const struct sockaddr_in6 *s6 = (struct sockaddr_in6 *)gate;
         struct in6_addr gw = s6->sin6_addr;
 
 #ifndef TARGET_SOLARIS
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index a226fc4..18c1cff 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1833,7 +1833,7 @@
             for (int i = 0; i < 256; ++i)
             {
                 /* some platforms have a dedicated directory per driver */
-                char *sep = "";
+                const char *sep = "";
 #if defined(TARGET_HAIKU)
                 sep = "/";
 #endif


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
