Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FFDC55167
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p/fUC7o+SCBZ7FLq6+Yn4mCBtWkVCcGcei1swHwpKFw=; b=Qy+NrTGgcXdfW9TQ0iYAzhT9EY
	eYA+cMGPvQIfk85c3F4bGmkdOsnDK55mOKC9ni52II6vpYHu1816Um7wyF5cDXG5N9PskJnb3jrYE
	iiepJRLk27r4nRTvcGfyz0tMSjfOmUngcr7/GoUfpONYU4rmUXVI74HXfy+FThxTC0II=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpXeY-0003yr-4o;
	Thu, 30 Jul 2026 20:46:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wpXeW-0003yh-Iv
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:46:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iIryvvHPHGK6mfxjXN87UhEHkKJOMNTdxx55PoJrZpA=; b=fOmJMHc8jJ1UxVncd/i8vA939O
 Ltlb2lP5yDkm3066gm9IEWKDtcOROa4l+sYGFJDAEt86ETruaJi4NtKQsoH3CXdfPYga2iKgSpNYU
 PitpXbBXeuGaHdGvSsPvKB0WRZ8uQeO6CeWEoWchr7GZZgOrcZ+93TcErENdVP9NsgC8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iIryvvHPHGK6mfxjXN87UhEHkKJOMNTdxx55PoJrZpA=; b=DkEHsVbPep/aDSLr3PyJKhqc0t
 ls/NlgukFMel3OIXv4Xg/fKl01NRP44ZvfbU3gYuNNFeamZkor8TgoJ5g8SEB5lwDr8uZO1XWzD9t
 9MPSKLPBsgeOzyNWltni4h6P5VW/4QL9365ztohsjSeVw2NLl7zwEDDM9h4Zw1zmozv0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpXeU-00079p-TP for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:46:51 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66UKkhE8027265
 for <openvpn-devel@lists.sourceforge.net>; Thu, 30 Jul 2026 22:46:43 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66UKkh28027264
 for openvpn-devel@lists.sourceforge.net; Thu, 30 Jul 2026 22:46:43 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 30 Jul 2026 22:46:37 +0200
Message-ID: <20260730204642.27250-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1728025749000.I7e5ac9b4a8594251c3b5c4655f9d74b021950098@gerrit.openvpn.net>
References: <gerrit.1728025749000.I7e5ac9b4a8594251c3b5c4655f9d74b021950098@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wpXeU-00079p-TP
Subject: [Openvpn-devel] [PATCH v2] t_server_null: run server processes with
 'ulimit -t 300'
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

"ulimit -t" will hard limit the usable CPU time for any process started
to the specified number of seconds.  So if we have a stuck-and-looping
server process (which was observed frequently) this will make sure
the situation will fix itself eventually.

Change-Id: I7e5ac9b4a8594251c3b5c4655f9d74b021950098
Signed-off-by: Gert Doering <gert@greenie.muc.de>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/777
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/777
This mail reflects revision 2 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
index acf8479..40ce94b 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -11,6 +11,10 @@
     # Allow reading this file even umask values are strict
     touch "$log"
 
+    # limit CPU time of processes to "5 minutes"
+    # (so a stuck-and-looping process will auto-terminate)
+    ulimit -t 300
+
     if [ -z "${RUN_SUDO}" ]; then
         "${server_exec}" \
          $server_conf \


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
