Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EA8C61DB6
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+RisIr1MUhVAL/AZtGEEeL27+hJEE1uCDQuT6g9Nq+M=; b=S8R+Sxe8Ay+811K0G+x1tLDKEb
	PyXBD8mvh7f097g8zSryRzqzPFqNNllGmbQhwv/PcG3K3wTzRcy7Kwz+X16dsfyv03YvXqrkCreiS
	+aH0K10y97oRDw1UhHdtjOqCbKum0r/z4Zj4GV0C7XSCoxuOdIl7D2lMxRzsxk5cYkGk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wylK4-0005w5-Vb;
	Tue, 25 Aug 2026 07:11:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wylK3-0005vz-Ib
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:11:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fFL9kRQaUbYSd1Cv+PWU6LNnwsbjlKBvVAWYcFkpU+s=; b=TfkoQyDIYJ0nSpjEC/Fq9DIMZk
 cROQwEia3Udgu74OKtWXkRWKxLvJvaCu8nG44yDEtc59Z7/ZYTeaRwFfK7n1ky7lR3+wMqXT6oHg8
 dd36l61k2N5OCvdL6hMmqkhXREUYrh/9013eD8ixhQJKehhagGNRdM4TN4gOBcEe0pRQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fFL9kRQaUbYSd1Cv+PWU6LNnwsbjlKBvVAWYcFkpU+s=; b=eY9mcFQYIQdzxnY/vlXgvj/Hwq
 /qdiVtjoHMq0JdnNLdAtwXtGy9mH+HGlJH98wIsSG7L1ci7hfSu1oJOWGUxXFCiM0b4B13iMkdnTB
 MuiGxf2TuZcPB/tp7FIDNAbNsn67hLl1H5MxhGKvhuaNBwpdmkv37lb87V+Ux+CjNKGM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wylJz-0006Y3-4Q for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:11:49 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67P7BdWx021820
 for <openvpn-devel@lists.sourceforge.net>; Tue, 25 Aug 2026 09:11:39 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67P7BdiI021819
 for openvpn-devel@lists.sourceforge.net; Tue, 25 Aug 2026 09:11:39 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 25 Aug 2026 09:11:33 +0200
Message-ID: <20260825071139.21756-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1774268486000.I52773764e0f4056fe5367918a9b2e6720b165c21@gerrit.openvpn.net>
References: <gerrit.1774268486000.I52773764e0f4056fe5367918a9b2e6720b165c21@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wylJz-0006Y3-4Q
Subject: [Openvpn-devel] [PATCH v2] dev-tools: Add new script to convert
 mails to Gerrit patches
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

Also checks for some common issues.

Change-Id: I52773764e0f4056fe5367918a9b2e6720b165c21
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1585
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1585
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/dev-tools/gerrit-submit-from-mail.sh b/dev-tools/gerrit-submit-from-mail.sh
new file mode 100755
index 0000000..ad5775f
--- /dev/null
+++ b/dev-tools/gerrit-submit-from-mail.sh
@@ -0,0 +1,42 @@
+#!/bin/bash
+
+# Assertions:
+#  - there is a remote called "gerrit" that can be used to
+#    pushed to gerrit. Create it with
+#    git remote add gerrit ssh://<yourgerritusername>@gerrit.openvpn.net:29418/openvpn.git
+# - the master branch does not contain pending commits, move them to branches
+#
+# Usage:
+# - Pipe mail to this script on stdin
+# - You can specify the target branch as the first argument to the script
+#   if it is not master.
+
+set -eu
+
+TARGET_BRANCH=${1:-master}
+SOURCE_DIR=$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
+TIMESTAMP=$(date +%Y%m%dT%H%M%S)
+
+git -C $SOURCE_DIR checkout $TARGET_BRANCH
+git -C $SOURCE_DIR checkout -B mail-submit-${TIMESTAMP}
+git -C $SOURCE_DIR am
+
+warnings=0
+if git -C $SOURCE_DIR log -n1 --format=%an | grep -q "via Openvpn-devel"; then
+    echo WARNING: Author contains \"via Openvpn-devel\"
+    echo Try to get an actual email-adress from the submitter!
+    warnings=$((warnings + 1))
+fi
+
+if ! git -C $SOURCE_DIR log -n1 --format=%b | grep -qi "signed-off-by:"; then
+    echo WARNING: Signed-off-by: line missing
+    echo Consider adding it.
+    warnings=$((warnings + 1))
+fi
+
+if [ "$warnings" -gt 0 ]; then
+    echo Please fix the $warnings warnings above before pushing.
+    echo Push the changes with git -C $SOURCE_DIR push gerrit HEAD:refs/for/$TARGET_BRANCH
+else
+    echo git -C $SOURCE_DIR push gerrit HEAD:refs/for/$TARGET_BRANCH
+fi


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
