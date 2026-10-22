Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F27606A319
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l2RapIqh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XDKsbcMM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PzYeEE+H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MUYorAWgUPC18Xf2qLOXf3v9c2MRXWKTNQMUQBbfrRM=; b=l2RapIqhr5M4BT
	xy1HK/1ilxCK4eyKvNkyWpEPZ2lnzb4JIS7BlwvBamlgKqtzKCKpB1L93Wu6YzezS5kjOuGcXDC4N
	swGgX9yWR/Ah8f4P5JOU7wMMX0HTyG/Um/CfVzfY8Ha0/YOr60c6c6aU5KaE+xEUUNiIIVedYV/pW
	dpU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJwDY-000000004ky-2IW1;
	Thu, 22 Oct 2026 17:04:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xJwDV-000000004kh-3CJX for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 17:04:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cPzVY0ZVH2UBF/Q+Z3VcsH16AGKZdfsa5DOmU7WcrQI=; b=XDKsbcMMQ1StOp4eligN8l9yy5
 5KNAx2DfFyb1FBedP+HYMKfFuRwWV/s0VM7rqwszReTalwtqvQG90+W/ZojwOhtLpWHLQ3utVKVGX
 x3cjA4P0JoY8dTv+TbQcQ1NEuwFKGl/4PgXgLOsMGlDA90vq5uVLRPUxsiqF1jRmNLRI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cPzVY0ZVH2UBF/Q+Z3VcsH16AGKZdfsa5DOmU7WcrQI=; b=PzYeEE+HGL8c/nFcgQVIhuKCf8
 An2tgcFg4nQ7yBma5JvD3O2RYwc92XLLfSqLwFG0KMKizKph1Hso1OAwe0bTLSoavuSwrbO5UyJso
 UEdMQXKB6e46fg0jw+xeSosj1/whjG56DVQxcKdKeWt0pZgcZeHhqf4jgqRwXKhzCQ0g=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJwDD-0000000063Q-40rR for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 17:04:21 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69MH4But020869
 for <openvpn-devel@lists.sourceforge.net>; Thu, 22 Oct 2026 19:04:11 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69MH4Bmf020868
 for openvpn-devel@lists.sourceforge.net; Thu, 22 Oct 2026 19:04:11 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 22 Oct 2026 19:04:05 +0200
Message-ID: <20261022170411.20830-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792331342000.I41bc0fcd475944f3c4701705a46f5a911480b283@gerrit.openvpn.net>
References: <gerrit.1792331342000.I41bc0fcd475944f3c4701705a46f5a911480b283@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xJwDD-0000000063Q-40rR
Subject: [Openvpn-devel] [PATCH v1] Make run-cppcheck.sh run on FreeBSD and
 macOS
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

FreeBSD has no /bin/bash, while macOS has an old 3.2.57 version from 2007.

Also work around the differences in readlink and different methods to
get the number of cpu cores.

Change-Id: I41bc0fcd475944f3c4701705a46f5a911480b283
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2018
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2018
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh
index 3c71c83..58609b2 100755
--- a/dev-tools/run-cppcheck.sh
+++ b/dev-tools/run-cppcheck.sh
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 
 set -eu
 
@@ -17,12 +17,18 @@
     disable_arg="--disable=information"
 fi
 
-SCRIPT_DIR=$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
+if [ $(uname) = "Darwin" ] || [ $(uname) = "FreeBSD" ]; then
+    SCRIPT_DIR=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))
+    num_procs=$(sysctl -n hw.ncpu)
+else
+    SCRIPT_DIR=$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
+    num_procs=$(nprocs)
+fi
 : ${SOURCE_DIR:=$SCRIPT_DIR/..}
 : ${BUILD_DIR:=$PWD}
 : ${INCLUDE_FLAGS:=}
 CPPCHECK_DIR="${BUILD_DIR}/cppcheck_build_dir"
-COMMON_ARGS="-j$(nproc) ${verbosity_arg} \
+COMMON_ARGS="-j${num_procs} ${verbosity_arg} \
  -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
  -I./include/ -I./tests/unit_tests/openvpn/ \
  -I./src/compat/ -I./src/openvpn/ -I./src/openvpnserv/ -I./src/plugins/auth-pam/ \


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
