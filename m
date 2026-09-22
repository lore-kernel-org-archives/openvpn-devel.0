Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5776BC98302
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZBhiqNZ3aTz3JroC79hTGR7VTZlKhYNUCwSJ+DgMEI4=; b=cO2wz/oLQ9KRehVKGKW66A5edz
	jNTM7Cbpjz2Hls3HRoguUejtHAVBp6NJo3iJiw47W3tx+e7BRs/tNkNwpfilLG7BrA6vX+pYcQu4C
	uixD8JI04ggHtCTLdoFJIWeIw4mYhF4QzUZibC8NhARUwAyoHplRuOImMNNcD4nE6MYQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x933e-0007ld-QI;
	Tue, 22 Sep 2026 16:09:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x933b-0007lD-6k
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 16:09:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X1lVltdfmuoH4RPGRS0G+HAgXtJv7C6QxQM/ApHF2nQ=; b=AEmRv/b7YMsAGPG3S3AqJ30614
 FHsMdxiFl0ph2Zd+hJWaAjoZu6RjT1+qxQjgSUykcluxm8Gu53VgDSMKoWcgWjgXzq8o+eGCX8+uT
 9KvxkoD3BimNF3ai8G7zMaRTQQp1jh2XzuwLlghRHyrQK656/KmxF4eT/WVCN6LDW+N0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X1lVltdfmuoH4RPGRS0G+HAgXtJv7C6QxQM/ApHF2nQ=; b=cVvRSCAA2rXKheYjYUeJeKmNGg
 OV+xhVZKDzGtDER+nUjabRqs8HFDtF12tiwASjLaf7gxaQQ9Ct5ZpzRbPovrsO0omnbHEz26WyP8S
 GVTtqqC5J+MrnPijWgh1//Zz+8EhiiJSB0WOStRMlQWkdYQOwsHQ3xmtzL0SnEpIxuiw=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x933a-0007yi-7T for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 16:09:23 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68MG9DJk020920
 for <openvpn-devel@lists.sourceforge.net>; Tue, 22 Sep 2026 18:09:13 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68MG9DAr020919
 for openvpn-devel@lists.sourceforge.net; Tue, 22 Sep 2026 18:09:13 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 22 Sep 2026 18:09:07 +0200
Message-ID: <20260922160913.20905-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
References: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x933a-0007yi-7T
Subject: [Openvpn-devel] [PATCH v3] Document notify as auth pending method
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

This allows a server to signal a pending authentication that does
not require any action from the user or client but can still take
a while to complete and enter the auth pending state.

Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1919
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1919
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 1126468..efbe757 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -794,6 +794,36 @@
 The client should return the response to the crtext challenge
 using the cr-response command.
 
+notify
+======
+This is notification that there might be some activity that potentially takes
+a while to finish is happening beyond the control of the client. This might be
+a server side check or an out-of-band authentication like requiring to have
+to authorise the connection on a mobile phone app. Beyond the control of
+the client is here meant in the strict sense of OpenVPN client program.
+This message still might prompt the user to look at their phone for example.
+
+The syntax of {EXTRA} for notify is:
+
+    NOTIFY:<flags>:<notify_message>
+
+<flags>: a series of optional, comma-separated flags. No flags have
+been defined yet.
+
+<notify_message>: The message to show the user to inform them about the
+ongoing authentication
+
+An example for a notify EXTRA of a server that does some checks against
+well known list of blacklists could be
+
+    NOTIFY::Please wait while your IP is checked against multiple online abuse databases.
+
+to inform the user that there is a delay in the connection attempt.
+
+Since the notify pending auth is not requiring any action on the client side
+that is required to continue the connection (unlike MFA or opening a browser)
+this message is not negotiated but can just be sent as a gratuitous message.
+
 COMMAND -- client-deny  (OpenVPN 2.1 or higher)
 -----------------------------------------------
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
