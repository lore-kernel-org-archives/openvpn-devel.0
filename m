Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5573FC43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+AvNoSKGLrBBDff9nDXFxslySvEOTmtTMMlCvuZahlQ=; b=kCuiqIIRts4GVB3TqTxkVB9g5M
	0ktEqiDKdCEK7w9a1PZgVM6su6jE6pJKS/owfcm5xwvtQaPD1eXnHcpCBQhy1sln1WCNW7DyzFr39
	wsv2H3mr/nmna06D2nwLLWrU7Z5vJURO0YsdnjwuCOZLNYw1DGLbXu5UrqjlteeWZiL0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjIQS-0005BV-P3;
	Mon, 13 Jul 2026 15:18:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wjIQR-0005BF-G4
 for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 15:18:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V/mNWUjP+EZ0AIdxuLivsMBzFsgsboUI/c8QobyUSbM=; b=fZ0ti8yWs8tJm0FN8Z+G1CkN+I
 n2wTYqRFdtKpQqpMm8o/Q2ZOajPLGA9Ab2CTFf7NPqPefVGBceg4Aw7iN5RvM8S7eTqaKKnv0phE0
 lac4xnqYafghjQG2rAkiSPfc9aM+H8gaysQZhC/3aoLxq2/RZ/z0IcnxaIk+cyzFul/U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=V/mNWUjP+EZ0AIdxuLivsMBzFsgsboUI/c8QobyUSbM=; b=mLI+YOhuENSaeoD2NWBrS2kIv6
 MYwjt+JNstRHGeVKcdeBAUZ40Ck7NYmxOujqFT0oF0Vfs7e4zoRTgeemIdfvAnMf8pTv5ZduP03Wx
 NAg3OXqVsYLgccfOXRZxKVN1wrtNCXE4HLimgP9Pmmq8hF7Zhx83q9T8rC+uYHayHwRk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjIQP-0002SR-D3 for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 15:18:32 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66DFIHN4022031
 for <openvpn-devel@lists.sourceforge.net>; Mon, 13 Jul 2026 17:18:17 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66DFIHsT022030
 for openvpn-devel@lists.sourceforge.net; Mon, 13 Jul 2026 17:18:17 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 13 Jul 2026 17:18:11 +0200
Message-ID: <20260713151816.22005-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1783945377000.I677d3206c24aad997889ed76fb8eca2e6f4b1259@gerrit.openvpn.net>
References: <gerrit.1783945377000.I677d3206c24aad997889ed76fb8eca2e6f4b1259@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wjIQP-0002SR-D3
Subject: [Openvpn-devel] [PATCH v1] t_client.sh.in: Do not run resolvectl if
 systemd is not running
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

From: Frank Lichtenheld <frank@lichtenheld.com>

In some cases we will have resolvectl installed but no
running systemd. E.g. on old Ubuntu distros resolvectl
is part of the main systemd package which we have installed
as a build-dependency.

Supress the warnings from resolvectl in this case.

Change-Id: I677d3206c24aad997889ed76fb8eca2e6f4b1259
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1778
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1778
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 5bf9dbb..52f2a0d 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -243,7 +243,7 @@
     # except Linux and MacOS
     case $UNAME in
 	Linux)
-            if [ -x /usr/bin/resolvectl ] ; then
+            if [ -x /usr/bin/resolvectl -a -d /run/systemd/system ] ; then
                 echo "-- linux resolvectl --"
                 resolvectl status
             else


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
