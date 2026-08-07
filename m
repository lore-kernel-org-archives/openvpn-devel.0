Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E103C5AC7A
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RM8/nvPCRJavv3qSNhuoKSiL8v9XpETekovsqA9uiA4=; b=B1ZOgQNx9Nc3rysmL7ObYZVcS3
	ycfgy0mPtIs8uq0LfkpmKTQqJ15eZ/+86J9wHQ3r2uwdgWHNnz3IiOu/Zb2o6EF7i4y0/NQ152NLo
	pzkXUc7w0MUr1fgOnG6EaiX29LSpCzvTiyEScpxvSQO7/NXtcQDlNj7YxLb1dFhXF1EE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsMkR-0003yP-Br;
	Fri, 07 Aug 2026 15:44:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1wsMkP-0003yI-B8
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:44:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8hzjPJs3n3thU21ay/Cm0iGrn59yZJtM9hAFz9PPXoQ=; b=Yh2MiexKsr+mA4dj5GtkqNRL/k
 FMyBUOHVbh/O7DV83E4wHcmwLp8/qqldhoDhtRGjXaD5iaonQVNGgl69EnTrgFnzPLfQxMp1G/Pv8
 YOQyWdgLl0o70jb37gCHB90DpGq1nXXQXub1qhObQjrmT8a5MpifZ0fGCiJNG8SSdRGA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8hzjPJs3n3thU21ay/Cm0iGrn59yZJtM9hAFz9PPXoQ=; b=lY3Kj6ZDD0ffJSY9Z+rz1dpOoO
 JzOOrTCx5huNfI6/uXgp0/kyAAoFkM3zG+tNnt+HZL8Q1m4g66T+kJiNKukF7X/cMIBdEVKuaq3W0
 RVodx+A5NayvOiI9d8jw0bfcJZQpxWkmB3t58sxONjH3SrAMLQCy1XP9Fjp/LddeVDMo=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsMkR-0004qk-6I for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:44:37 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hGl444cTRzMlCv;
 Fri, 07 Aug 2026 15:14:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1786108484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hzjPJs3n3thU21ay/Cm0iGrn59yZJtM9hAFz9PPXoQ=;
 b=zaRHT2S2ZOrVc8OG1joN+WI8uy2ayug6SRAgiivSKjKOPNwCs5C9Ilp50FTtMo3wYcfvRa
 BTH+gjJLUy85prq/MKSu+U3Qsu1A3rl0FeufYhs0FcmhESAg8ycg/Ha9vIDdHHK6u9J1pt
 g54Zu6T6VAqhxNDtMOXTCJubWKFcjohNRnKVuo5gSzXLxnRHt5CdI0eko7JH+xoL5NJgX5
 SjSdk0B183YwR2SRnRH6K0j4c1tWUMdBh7HN9Zo7OVU0WjPrfQ5bkUcZEkmAn9L6DXlC1y
 +3tM+YmkbaeituK0iEXy/B2GZof8Vf44pbFgbF2l+VvJSUWHbsP/eBEFkbyacw==
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  7 Aug 2026 15:14:43 +0200
Message-ID: <20260807131443.53351-1-frank@lichtenheld.com>
In-Reply-To: <gerrit.1782933852000.I752e03eabec085e47e8d74a9b4fa99e9ff267efb@gerrit.openvpn.net>
References: <gerrit.1782933852000.I752e03eabec085e47e8d74a9b4fa99e9ff267efb@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wsMkR-0004qk-6I
Subject: [Openvpn-devel] [PATCH v2] t_client.sh.in: Do not try to guess the
 absolute path to LOGDIR
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
Cc: Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

We know it, we do not need to guess it. Makes it easier
to move LOGDIR around.

Change-Id: I752e03eabec085e47e8d74a9b4fa99e9ff267efb
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1764
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1764
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index fc12dda..6c9c8ae 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -126,6 +126,7 @@
 fi
 
 LOGDIR=t_client-`hostname`-`date +%Y%m%d-%H%M%S`
+LOGDIR_ABS="$PWD/$LOGDIR"
 if mkdir $LOGDIR
 then :
 else
@@ -383,7 +384,7 @@
 	printf "$outbuf" ; continue
     fi
 
-    pidfile="${top_builddir}/tests/$LOGDIR/openvpn-$SUF.pid"
+    pidfile="$LOGDIR_ABS/openvpn-$SUF.pid"
     openvpn_conf="$openvpn_conf --writepid $pidfile $up"
     output " run openvpn $openvpn_conf"
     echo "# ${openvpn} $openvpn_conf" >$LOGDIR/$SUF:openvpn.log


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
