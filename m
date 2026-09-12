Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C634AC88E53
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wccvvQBXsw/1QCDXUhnUbhqMt5jmJAGa+vbCMrxz7ls=; b=Z2hZbE8y077xISM9CMQG/1dnN9
	3n8mVpnVkTGymYM7qhiW7LM1QQLuVDiYyMuNoDNG4jRaakQjfPRf+lxFppYh0ON2zloyiRQZt+ipc
	bzFaAlcssqKdA8t1cRD5kaRxLFpmqtgc5dnkG6LYK2mH0I3d79ilV7i1PnzcOG6AuewE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5Ktr-0005gG-EV;
	Sat, 12 Sep 2026 10:23:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x5Ktp-0005g9-Hj
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 10:23:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+O7TGrz445XFN95lok4UPqCFaqnWznBpw5a4tXbeF2M=; b=R2rIkXpjJSKJEh5G85k6HNlKNx
 b95GO1Ii4g6poBOU/tGmcVq89XOX/GQP/hgG94s4qjlaVckCV3yDx2EJU5Kl2ihn8Dt7ldzQ1ap44
 buKvyxl3qlvme7/OmAFqX9PTEFv4/Aa8m+6qgoZfHeaf1LNX+NLSi51rR28zqHbKO4/s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+O7TGrz445XFN95lok4UPqCFaqnWznBpw5a4tXbeF2M=; b=SHHGY3/yvUvCknzQEH1LKdFI2P
 +TRRo7Q9PMkSbEP6jgEwGvnc6oDLgr2LRKICJsPEJr4zZTiBX+0jPXS2YIgFuIu11nBfbiqsOvq2Y
 GgLzohzpyOl/9blof2pkKGmiqouWNkyFfTPi3P8DmTEHGCDSBvJeYLmHmW8swIXSLrX4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5Kto-0005Vz-0g for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 10:23:57 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68CANnht000439
 for <openvpn-devel@lists.sourceforge.net>; Sat, 12 Sep 2026 12:23:49 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68CANnK5000438
 for openvpn-devel@lists.sourceforge.net; Sat, 12 Sep 2026 12:23:49 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 12 Sep 2026 12:23:42 +0200
Message-ID: <20260912102348.423-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1789127367000.I65f8826f343822c75e789d91881c9dbac676880f@gerrit.openvpn.net>
References: <gerrit.1789127367000.I65f8826f343822c75e789d91881c9dbac676880f@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x5Kto-0005Vz-0g
Subject: [Openvpn-devel] [PATCH v1] cppcheck: Update suppressions for
 current master
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

Trying to get to a state where it actually passes when
merged.

Change-Id: I65f8826f343822c75e789d91881c9dbac676880f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1911
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1911
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index f4f88a3..e1ffe37 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -26,17 +26,14 @@
 getpwnamCalled
 getservbynameCalled
 localtimeCalled
-strtokCalled
 # FP: posix.cfg claims suseconds_t is unsigned for some reason
 unsignedLessThanZero:src/openvpn/otime.h:148
 # IGN: multi code does weird things with pointers to local variables...
-autoVariables:src/openvpn/multi.c:4232
+autoVariables:src/openvpn/multi.c:4242
 autoVariables:src/openvpn/multi_io.c:324
 # IGN: the code header = 0 | (OPCODE << P_OPCODE_SHIFT) is used intentionally
 badBitmaskCheck:src/openvpn/mudp.c
 badBitmaskCheck:tests/unit_tests/openvpn/test_pkt.c
-# IGN: we store integers in pointers
-CastAddressToIntegerAtReturn:src/openvpn/multi.c
 # IGN: Windows specific (unsigned long == unsigned int)
 compareValueOutOfTypeRangeError:src/openvpn/ssl_verify.c:928
 # FP: cppcheck seems to have wrong signature of DeviceIoControl()
@@ -78,8 +75,6 @@
 nullPointerRedundantCheck:src/openvpn/init.c:301
 # FP: cppcheck doesn't understand ZeroMemory
 redundantAssignment:src/openvpnserv/interactive.c:203
-# FP: cppcheck doesn't know the NLA macros
-redundantInitialization:src/openvpn/dco_linux.c
 # IGN: We reuse the same variable name due to macro usage
 shadowVariable:src/openvpn/options.c:1948
 shadowVariable:src/openvpn/options.c:1966
@@ -93,12 +88,10 @@
 uninitvar:src/openvpn/options_parse.c:148
 # FP: uninit is fine when it is a return parameter
 ctuuninitvar:src/openvpn/crypto_mbedtls_legacy.c:690
-uninitvar:src/openvpnserv/interactive.c:2775
+uninitvar:src/openvpnserv/interactive.c:2783
 uninitvar:src/tapctl/main.c:566
-# FP: we added a check but cppcheck is not convinced
-uninitvar:src/openvpnserv/interactive.c:2667
 # FP: weird parse error, the macro is fine in the rest of the file
-unknownMacro:src/openvpnserv/interactive.c:3596
+unknownMacro:src/openvpnserv/interactive.c:3604
 # FP: cppcheck doesn't account for short-circuiting
 unreadVariable:src/openvpn/manage.c:682
 unusedFunction:src/openvpn/siphash_reference.c
@@ -112,8 +105,6 @@
 unusedFunction:tests/unit_tests/openvpnserv/test_openvpnserv.c
 # IGN: keep mocking around for future use
 unusedFunction:tests/unit_tests/openvpn/mock_msg.c
-# FP: doesn't account for --wrap
-unusedFunction:tests/unit_tests/openvpn/test_tls_crypt.c
 unusedFunction:/usr/include/*
 # FP: cppcheck doesn't know the NLA macros
 unusedLabel:src/openvpn/dco_linux.c
diff --git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh
index fc14405..37de267 100755
--- a/dev-tools/run-cppcheck.sh
+++ b/dev-tools/run-cppcheck.sh
@@ -33,7 +33,7 @@
  --suppressions-list=${SCRIPT_DIR}/cppcheck-suppression \
  --cppcheck-build-dir=${CPPCHECK_DIR} \
  --check-level=${CPPCHECK_CHECK_LEVEL} --max-configs=10 \
- --error-exitcode=1"
+ --error-exitcode=1 --showtime=summary"
 
 set -x
 
@@ -53,5 +53,6 @@
     -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \
     -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \
     -UTARGET_AIX \
+    -UOPENSSL_NO_EC \
     src/openvpn* src/compat/ \
     tests/unit_tests/example_test/ tests/unit_tests/openvpn*
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 71459ee..48508e5 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3226,7 +3226,7 @@
         return;
     }
 
-    uint8_t *dataptr = to_link->data;
+    const uint8_t *dataptr = to_link->data;
 
     /* we don't expect send_reliable to be NULL when state is
      * not S_UNDEF, but people have reported crashes nonetheless,


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
