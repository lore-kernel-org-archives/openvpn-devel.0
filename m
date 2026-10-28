Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8522660A260B
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Je2uk1/n;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mkJI/aha;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gPbiPH4X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=THjVg8dsG1LzpX++SOK+EV4Y+6r1RosZaSUrqoUZKxY=; b=Je2uk1/nmYM4qQ
	1knY3LS9HcYBcUnWqTRFXRmhT52VE3K5ts4MZWpNxwMl0/jDmMX2wCGhAnndC+xAfKb704i287ZNB
	qZqtojwXf+S2zCxaWj4x0+cMuNTgGzvtuR1i1OJcu3Xpw/Tg2RMsvF50zQc0qIotRyAVlPIq79g7E
	cwg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMA4L-000000003lE-1EGC;
	Wed, 28 Oct 2026 20:16:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xMA4J-000000003kt-0goj for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 20:16:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tUU2kiEyTjhmM/0G8PjDplvyAf1ypoZVhFcm06Nbneo=; b=mkJI/aha8Rzecc5Ai6nm+KEf5u
 75zplIHMwDD7F9WZ/uTcQb6Tc7zK1U0P2xs6FHhVh6eKDAV/bCp2sLPGql0e/D5qfs8DKT8xOZCAX
 +w3rzZzO/8zlryf2o3YUvqQG3X3A2r3tBFQlTIyA3QVpGnPsjs5ajcgnDpEImn3YsVfw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tUU2kiEyTjhmM/0G8PjDplvyAf1ypoZVhFcm06Nbneo=; b=gPbiPH4XZnXGS6jJsMsPS6nbYc
 Dk6ubAMpQzl+dguKot3uHwrpVoWUPnBu0rsF0jhDKFVMR9z0bj9kFd6R5Gk0jPGIlzfHAHktJe5Hx
 juNS3NpXBf1CDX4oU/37EZC1R9ZeR/IGQluWuA4NEtJAusKUKc8ys57S+hDdoIZmiYQ0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMA4H-0000000028w-06Bt for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 20:16:19 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69SKGAt9013703
 for <openvpn-devel@lists.sourceforge.net>; Wed, 28 Oct 2026 21:16:10 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69SKG9Ui013702
 for openvpn-devel@lists.sourceforge.net; Wed, 28 Oct 2026 21:16:09 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 28 Oct 2026 21:16:04 +0100
Message-ID: <20261028201609.13684-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793212962000.I464672facb34de83930eddc4e86826d3b1cd3edd@gerrit.openvpn.net>
References: <gerrit.1793212962000.I464672facb34de83930eddc4e86826d3b1cd3edd@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xMA4H-0000000028w-06Bt
Subject: [Openvpn-devel] [PATCH v1] Fix numbering of examples in
 management-notes.txt
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

From: Selva Nair <selva.nair@gmail.com>

Change-Id: I464672facb34de83930eddc4e86826d3b1cd3edd
Signed-off-by: Selva Nair <selva.nair@gmail.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2068
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2068
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index a28a1a8..eac91a4 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -345,29 +345,29 @@
   The PASSWORD real-time message type can also be used to
   indicate password or other types of authentication failure:
 
-  Example 3: The private key password is incorrect and OpenVPN
+  Example 4: The private key password is incorrect and OpenVPN
   is exiting:
 
     >PASSWORD:Verification Failed: 'Private Key'
 
-  Example 4: The --auth-user-pass username/password failed,
+  Example 5: The --auth-user-pass username/password failed,
   and OpenVPN will exit with a fatal error if '--auth-retry none'
   (which is the default) is in effect:
 
     >PASSWORD:Verification Failed: 'Auth'
 
-  Example 5: The --auth-user-pass username/password failed,
+  Example 6: The --auth-user-pass username/password failed,
   and the server provided a custom client-reason-text string
   using the client-deny server-side management interface command.
 
     >PASSWORD:Verification Failed: 'custom server-generated string'
 
-  Example 6: If server pushes --auth-token to the client, the OpenVPN
+  Example 7: If server pushes --auth-token to the client, the OpenVPN
   will produce a real-time PASSWORD message:
 
     >PASSWORD:Auth-Token:foobar
 
-  Example 7: Static challenge/response:
+  Example 8: Static challenge/response:
 
     >PASSWORD:Need 'Auth' username/password SC:1,Please enter token PIN
 
@@ -378,7 +378,7 @@
   formatted as described in the Challenge/Response Protocol section
   below.
 
-  Example 8: Dynamic challenge/response:
+  Example 9: Dynamic challenge/response:
 
     >PASSWORD:Verification Failed: ['CRV1:R,E:Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6l:Y3Ix:Please enter token PIN']
 
@@ -395,7 +395,7 @@
   in the Challenge/Response Protocol section below
 
 See the "Challenge/Response Protocol" section below for more details
-about examples 7 and 8, including how the management interface client
+about examples 8 and 9, including how the management interface client
 should respond.
 
 COMMAND -- forget-passwords


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
