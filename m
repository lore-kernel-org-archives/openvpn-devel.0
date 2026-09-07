Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD93FC79F99
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 18:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b4/prK63n/ztQ0i9mtG6fcvViaiBIzWDHsSPW5qzfYY=; b=lMM+xh5Sn7JU7pSk0E7OvAVoUi
	KAs4qN26XGvnhnpZrEiXuu0/tYUI1Ca6sjCY0UAfMsA1DIFy6wjKLtf0wES7krvs2z0yMlCAM0mzg
	S8jK/0SYjXGghDDwHQ76hhFYwwNbjyLJNvi/v8F1rS2RiWLpaecHkHjns+rLK1Mkb4GA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3dux-0006Ew-Fk;
	Mon, 07 Sep 2026 18:18:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x3duv-0006Eq-EZ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 18:18:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3g9fr4wqMNr38El/jhQkFSplrYzvHep1l65A0rDQSOg=; b=L56kZqcDeslv3Tw/+6LW+e316v
 LGG3Ky14W84ejFpDnB2VDy1Pehl2E4/uLDFQXh5WhX9vbMEDedj0Zpn/ne6uCRlEZH69sJbKzRYSB
 cMT2KImtJOtX0gdKAIQ7cg/xNMBl/CQeBusVo4n825fQxeQKbKyr4rQ+EZxmvvDw3c7I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3g9fr4wqMNr38El/jhQkFSplrYzvHep1l65A0rDQSOg=; b=A9aagIyoKB2aOy3iYhgM6h7NyM
 ujLFY4LThu93u9Vze9a/2W/eKT8WrmYPvyPBy35DTfZhLluD4sR1rqZvrdURlsBYIngNwnORgwJWU
 d/s4G5xqi9agbpjYg8mFXI7CFw2FHDjPoYNXNogXlZA6FK+88heqA4X4EBRlUUDcwqHI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3dur-0005DF-JP for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 18:18:02 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 687IHsC1013372
 for <openvpn-devel@lists.sourceforge.net>; Mon, 7 Sep 2026 20:17:54 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 687IHsMd013371
 for openvpn-devel@lists.sourceforge.net; Mon, 7 Sep 2026 20:17:54 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  7 Sep 2026 20:17:49 +0200
Message-ID: <20260907181754.13356-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787672720000.I65beb37a2d822333aa888de1baf11dfcb8490e90@gerrit.openvpn.net>
References: <gerrit.1787672720000.I65beb37a2d822333aa888de1baf11dfcb8490e90@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x3dur-0005DF-JP
Subject: [Openvpn-devel] [PATCH v3] run-cppcheck.sh: Make it more
 configurable
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

- Allow to easily control verbosity and automatically
  adjust to the verbosity of the Make run
- Allow to easily control check level. With exhaustive the
  check can take hours (due to options.c), so we couldn't
  use that in CI

v3:
- Use AM_V_P instead of V to correctly reflect
  AM_DEFAULT_VERBOSITY

Change-Id: I65beb37a2d822333aa888de1baf11dfcb8490e90
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1868
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1868
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/Makefile.am b/Makefile.am
index feeaabb..dd6cee6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -96,4 +96,5 @@
 	BUILD_DIR="$(abs_top_builddir)" \
 	SOURCE_DIR="$(abs_top_srcdir)" \
 	INCLUDE_FLAGS="$(LIBNL_GENL_CFLAGS)" \
+	CPPCHECK_VERBOSE="$(AM_V_P)" \
 		"$(top_srcdir)/dev-tools/run-cppcheck.sh"
diff --git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh
index a7aa3c4..fc14405 100755
--- a/dev-tools/run-cppcheck.sh
+++ b/dev-tools/run-cppcheck.sh
@@ -2,22 +2,37 @@
 
 set -eu
 
+: ${CPPCHECK_VERBOSE:=false}
+: ${CPPCHECK_CHECK_LEVEL:=exhaustive}
+
+if "${CPPCHECK_VERBOSE}"; then
+    verbosity_arg="-v"
+else
+    verbosity_arg="-q"
+fi
+
+disable_arg=
+if [ "${CPPCHECK_CHECK_LEVEL}" != exhaustive ]; then
+    # suppress all the information that we should use exhaustive
+    disable_arg="--disable=information"
+fi
+
 SCRIPT_DIR=$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
 : ${SOURCE_DIR:=$SCRIPT_DIR/..}
 : ${BUILD_DIR:=$PWD}
 : ${INCLUDE_FLAGS:=}
 CPPCHECK_DIR="${BUILD_DIR}/cppcheck_build_dir"
-COMMON_ARGS="-j$(nproc) -q \
+COMMON_ARGS="-j$(nproc) ${verbosity_arg} \
  -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
  -I./include/ -I./tests/unit_tests/openvpn/ \
  -I./src/compat/ -I./src/openvpn/ -I./src/openvpnserv/ -I./src/plugins/auth-pam/ \
  -I${BUILD_DIR} -I${BUILD_DIR}/include/ \
- --enable=all \
+ --enable=all ${disable_arg} \
  --library=${SCRIPT_DIR}/openvpn-cppcheck-library.cfg \
  --library=openssl.cfg \
  --suppressions-list=${SCRIPT_DIR}/cppcheck-suppression \
  --cppcheck-build-dir=${CPPCHECK_DIR} \
- --check-level=exhaustive --max-configs=10 \
+ --check-level=${CPPCHECK_CHECK_LEVEL} --max-configs=10 \
  --error-exitcode=1"
 
 set -x


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
