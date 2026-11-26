Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA405606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FjYN/QEV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OXK2gKey;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VTwL+fok
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IF7u+ACRe13nQsHuyuLJLMuzXrOBAc4Xr3k9OIvpa8E=; b=FjYN/QEVzPw7Fo
	G9/b2ty38cqImlUxE5tlHnQtbQGg/UItvodcOMWzItiAvIg/B96C6gOME1He/EC6PkdA6sVqZD0BV
	PDZiDpYENHnAANUspx9M2VQwGVezs+R8zCKnkytcPVRTw8HywUdAR9ej7aHjvxafVlPdAfLtpH3ij
	CkA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWb8v-000000007CE-1ydl;
	Thu, 26 Nov 2026 15:12:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xWb8r-000000007C5-0qDe for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 15:12:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8rXBYPEORMTyMVO3mwg4i48EIdqpT36hBNUIjBzKu/s=; b=OXK2gKeyTvpfLcMU/hTBu2ZOkv
 kguh6PVJ561RbM5jO1Mc8wBgQ7FkYrDg0bfUI/XkPM/UD/meLC/az/okKfdFC8mRuK59IWYowkpio
 P7H8BOOx4MtcGHLhdMeehr8u93IJoJE6WI8hFPEldUCC3StxNFZRZhy/9NWeLiFylpUo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8rXBYPEORMTyMVO3mwg4i48EIdqpT36hBNUIjBzKu/s=; b=VTwL+fok+1gRsV20nhItmJQUMC
 TvI5xe43+LQg1wvs8+lxQsu4zb05WonLXTljXXcuCcfAx790utnHRfDuXkXPCWhaH7UKFfhT1JLzz
 H6z1rPZe0Qk0+4oYjT/XsUlpUZvWbdJE+Boc3iNR4G2nIewJNizIvVLy/B0lqz//U6cY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWb8p-000000006SG-1KtM for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 15:12:09 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AQFC0kC027673
 for <openvpn-devel@lists.sourceforge.net>; Thu, 26 Nov 2026 16:12:00 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQFC06Z027672
 for openvpn-devel@lists.sourceforge.net; Thu, 26 Nov 2026 16:12:00 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 16:11:54 +0100
Message-ID: <20261126151159.27658-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795691059000.Ibc58b9c3029ffea4f87093178cf52bbb46f6d837@gerrit.openvpn.net>
References: <gerrit.1795691059000.Ibc58b9c3029ffea4f87093178cf52bbb46f6d837@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xWb8p-000000006SG-1KtM
Subject: [Openvpn-devel] [PATCH v2] manage: return early from
 man_check_for_signals() if a signal is set
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

Four standalone event loops checked signal_received, called
man_check_for_signals() if it was unset, then checked it again.
Make man_check_for_signals() return true right away when a signal
is already set, so each loop needs a single call.

Change-Id: Ibc58b9c3029ffea4f87093178cf52bbb46f6d837
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2352
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2352
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index bbf454a..96428c0 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3444,6 +3444,10 @@
 {
     if (signal_received)
     {
+        if (*signal_received)
+        {
+            return true;
+        }
         get_signal(signal_received);
         if (*signal_received)
         {
@@ -3620,11 +3624,7 @@
         do
         {
             man_standalone_event_loop(man, &signal_received, expire);
-            if (!signal_received)
-            {
-                man_check_for_signals(&signal_received);
-            }
-            if (signal_received)
+            if (man_check_for_signals(&signal_received))
             {
                 return;
             }
@@ -3762,11 +3762,7 @@
             do
             {
                 man_standalone_event_loop(man, &signal_received, 0);
-                if (!signal_received)
-                {
-                    man_check_for_signals(&signal_received);
-                }
-                if (signal_received)
+                if (man_check_for_signals(&signal_received))
                 {
                     ret = false;
                     break;
@@ -3847,11 +3843,7 @@
         do
         {
             man_standalone_event_loop(man, &signal_received, 0);
-            if (!signal_received)
-            {
-                man_check_for_signals(&signal_received);
-            }
-            if (signal_received)
+            if (man_check_for_signals(&signal_received))
             {
                 goto done;
             }
@@ -3990,11 +3982,7 @@
             do
             {
                 man_standalone_event_loop(man, &signal_received, 0);
-                if (!signal_received)
-                {
-                    man_check_for_signals(&signal_received);
-                }
-                if (signal_received)
+                if (man_check_for_signals(&signal_received))
                 {
                     break;
                 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
