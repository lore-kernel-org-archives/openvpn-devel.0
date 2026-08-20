Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B1FC5DF81
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 09:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QHdn0JYuVIyHSE9Qe1k8yPRqAcRe3G0Usq6HR/AEGjY=; b=eo2MPpz6QF+diNdYINBwJgnjsJ
	8Y2sYGuI6PsnEC4x/qPcUlX9kbaMdgQa9ChqpprQtapX2ZLxm5RwxkOiwa+/U0DmvvST94ovx79Zy
	8DYEmzv4dSRKO9ffgXRs1PN1gCoiJLNE04xtIG7Pn5h70DPpHSXuOVQaeN8w+g3IoMwc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwysJ-0003Qj-T3;
	Thu, 20 Aug 2026 09:15:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wwys2-0003Pr-6z
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 09:15:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VWNvQDA0m5tLP/xez2CAqqbUW3ysXqcJExf5Z/kDL2w=; b=UPXTHj1oDyV6VVSsUdz5ohwbh1
 SuvelGQVrZmaTRDwoNsmi9CIu64i20qXmseptU0qWuIBxrLvtCr444kjZIG9GAxK6OYvkKb/iRGuk
 14l4Ly8ijqxUeoc3u7Y6c2XZAlGacA2nc/VL7V55aYnEjOeiwOM/d58lMlE1a1wvLal4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VWNvQDA0m5tLP/xez2CAqqbUW3ysXqcJExf5Z/kDL2w=; b=QJrEQtZhCM3gLRcCbWew6lH+6Q
 ATaea1/UIlpmr9bckMCguwm2TI7SzRGJsV09BnYeguCeanhROoANVu0yzuXdnq7f4/tzZJpqIHQ8p
 x84PXk9UZUXMtUakYSHGCT0Vcl6p24Utsg+OJZKzNG9807lRlq/4gF+oOZ51s8GMt+zo=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwyro-0001CH-5s for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 09:15:22 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67K9FDv1004564
 for <openvpn-devel@lists.sourceforge.net>; Thu, 20 Aug 2026 11:15:13 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67K9FDDM004563
 for openvpn-devel@lists.sourceforge.net; Thu, 20 Aug 2026 11:15:13 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 20 Aug 2026 11:15:07 +0200
Message-ID: <20260820091512.4550-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1784305303000.I80a94dde26631e5a665029f495b2104cfecb1915@gerrit.openvpn.net>
References: <gerrit.1784305303000.I80a94dde26631e5a665029f495b2104cfecb1915@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wwyro-0001CH-5s
Subject: [Openvpn-devel] [PATCH v4] dev-tools/reformat-shell.sh: Make our
 shell code more consistent
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

Our shell code is currently not very consistent about
formatting. So provide a tool to achieve that consistency.
Especially in our test code we have several important shell
scripts that we actively develop.

Change-Id: I80a94dde26631e5a665029f495b2104cfecb1915
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1792
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1792
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/dev-tools/reformat-shell.sh b/dev-tools/reformat-shell.sh
new file mode 100755
index 0000000..dbbdaa9
--- /dev/null
+++ b/dev-tools/reformat-shell.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+#
+# Apply consistent formatting to our shell code.
+# Uses shfmt: https://github.com/mvdan/sh
+
+set -u
+
+FORMAT_ARGS="--indent=4 --func-next-line --case-indent"
+FORMAT_CMD="shfmt --list --write"
+
+# hardcoded to --posix due to .in filename and invalid shebang
+$FORMAT_CMD --posix $FORMAT_ARGS ./tests/t_client.sh.in
+# handle *.sh files recursively
+$FORMAT_CMD $FORMAT_ARGS ./tests ./dev-tools


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
