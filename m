Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793B9606A327
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 14:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DVa4chsL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jmykXdu9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=g6RseTeh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NPLtEQcdRYqia94rfCo9be4MfYm7wBHuBOIjFSELP/I=; b=DVa4chsLHHG1JF
	vXZ2SQYHrseVr7CCZaIN5DZip36jm8wMlSxvdooP/Ol50uMdpt/LLg0qO8O7RSaeYjEOPeP4Rnvcf
	oTvDqk0NiwnULtqAS5dP2EG8e+Tx7CbgCE1+NWr4qmb8KYmgKDQfLG5ClxNWEPHpR1ZJ8Qs1rzX3R
	9/c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOFHl-000000006NI-3af9;
	Tue, 03 Nov 2026 14:14:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOFHk-000000006NB-18ot for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 14:14:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cgJY/jo15dN4LVyG8liv0uuVelqtppxfzEqVUOo0Xdk=; b=jmykXdu9ltGQ3/KSbEWvXaK8L7
 EQZojK4Y3tHPPnMDcAudJYFRd3xY0zLLMTwR/a8XC+5/b19iHTprB55LmhJrlk2eME1rtqKJI+GLo
 4TfwCE16rGUPBlvKfOG+9ZBd5cxrgXwwJGtlFDHZqIgLt+vPnVMdrwmPi96YrZ2k97Po=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cgJY/jo15dN4LVyG8liv0uuVelqtppxfzEqVUOo0Xdk=; b=g6RseTehsuDeRyFkTxJALVQx4v
 XdzdW4FXTShLWHLyYRW8R1dQlhBpwu9gehPJzTnxPhKQy5jFFPiLFlJzcNfeSg3xFZwzBsdj5Vytu
 /0DLdxxveOT5QveyLpYNYqR86cBqF3GrQeuR3YvqqPaAHNyK99ZB+SCgP9pB0YvTa5Vs=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOFHi-000000006GI-1MXc for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 14:14:48 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A3EEdnO014056
 for <openvpn-devel@lists.sourceforge.net>; Tue, 3 Nov 2026 15:14:39 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3EEdxZ014055
 for openvpn-devel@lists.sourceforge.net; Tue, 3 Nov 2026 15:14:39 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  3 Nov 2026 15:14:33 +0100
Message-ID: <20261103141439.14041-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793709839000.I36430bab897e5fe9b1cfd48de50224395d56d8fc@gerrit.openvpn.net>
References: <gerrit.1793709839000.I36430bab897e5fe9b1cfd48de50224395d56d8fc@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOFHi-000000006GI-1MXc
Subject: [Openvpn-devel] [PATCH v1] Provide minimal netlink defines for
 cppcheck on FreeBSD and macOS
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

From: Arne Schwabe <arne@rfc2549.org>

Without these defines and the hidden goto inside the NLA_PUT functions
cppcheck complains about ret in dco_linux.c. This allows to run
cppcheck on macOS and FreeBSD without triggering these warnings.

Change-Id: I36430bab897e5fe9b1cfd48de50224395d56d8fc
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2107
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2107
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/dev-tools/openvpn-cppcheck-netlink.cfg b/dev-tools/openvpn-cppcheck-netlink.cfg
new file mode 100644
index 0000000..b63adf0
--- /dev/null
+++ b/dev-tools/openvpn-cppcheck-netlink.cfg
@@ -0,0 +1,7 @@
+<?xml version ="1.0"?>
+<def>
+  <!-- minimal defines to supress the errors on non-Linux platforms that do not have the netlink headers -->
+  <define name="NLA_PUT(msg, attrtype, attrlen, data)" value="if (nla_cppcheck_dummy(msg, attrtype, attrlen, data) < 0) goto nla_put_failure;" />
+  <define name="NLA_PUT_U32(msg, attrtype, value)" value="NLA_PUT(msg, uint32_t, attrtype, value)" />
+  <define name="NLA_PUT_STRING(msg, attrtype, value)" value="NLA_PUT(msg, attrtype, (int) strlen(value) + 1, value)" />
+</def>
diff --git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh
index d1c22c5..debcd46 100755
--- a/dev-tools/run-cppcheck.sh
+++ b/dev-tools/run-cppcheck.sh
@@ -20,9 +20,11 @@
 if [ $(uname) = "Darwin" ] || [ $(uname) = "FreeBSD" ]; then
     SCRIPT_DIR=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))
     num_procs=$(sysctl -n hw.ncpu)
+    EXTRA_LIBRARY="--library=${SCRIPT_DIR}/openvpn-cppcheck-netlink.cfg"
 else
     SCRIPT_DIR=$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
     num_procs=$(nproc)
+    EXTRA_LIBRARY=""
 fi
 : ${SOURCE_DIR:=$SCRIPT_DIR/..}
 : ${BUILD_DIR:=$PWD}
@@ -35,6 +37,7 @@
  -I${BUILD_DIR} -I${BUILD_DIR}/include/ \
  --enable=all ${disable_arg} \
  --library=${SCRIPT_DIR}/openvpn-cppcheck-library.cfg \
+ ${EXTRA_LIBRARY} \
  --library=openssl.cfg \
  --suppress-xml=${SCRIPT_DIR}/cppcheck-suppressions.xml --inline-suppr \
  --cppcheck-build-dir=${CPPCHECK_DIR} \


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
