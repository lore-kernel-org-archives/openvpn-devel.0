Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92492CA5FE6
	for <openvpn-devel@archiver.kernel.org>; Sat,  3 Oct 2026 17:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=el54fU32al+cGZe2DWNDO4JhnU6hUjkCl++f/YHOTvE=; b=QPjs6TWlieUAr+UY6hwW6n/jSb
	skwqWKwrPCiLFI7/JoXushlrm8KuYaNBbMaDl6EiMMZhibIENQFzin/Qv9aXAUpS9zfJrLctOQ6gt
	yt4CGEHSQH8SZf4G+azA1bboMNCxAWr6GfP2k1ReC21Wsko2r6AgLE49ySyK9zQgPDOI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xD3wA-0007Qz-E7;
	Sat, 03 Oct 2026 17:54:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xD3w8-0007Qt-JJ
 for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 17:54:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7kL/qVjjuxchaZGdamYhDAJophMUbx3dculW/pH6k80=; b=AMz3ogPnmOIfRPN0YsQvtBpPKh
 ajbcnTy7DCJaROxW7vWEBkvCxIO9pQjqqRPfHPHFwwJijR+8GGgLcsJbTA2RAAH/CTnbGoVSDBBJo
 TvrC0fhkqV79gJkSnnzdFrzkVu6YJdrBNBwaudQx/iC2ufMnD1J30S7w9GN1OqPqyslI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7kL/qVjjuxchaZGdamYhDAJophMUbx3dculW/pH6k80=; b=IB3ZcQOH71wDCI+yI6PtWCsEfH
 yzo7300utFbQErXqsxOGFTPuHny26C6p+F0jEFYEHPx6loyIjE30h8pyHsWfoGywvPJcnJjZEDIIa
 Shfw3q1Y8ojfWdOPCmjNuZ66FexwYjCrWXQxZvBqky2T2vMEGs+RAK9MrjcoTmIsiZz8=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xD3w7-00077O-6h for openvpn-devel@lists.sourceforge.net;
 Sat, 03 Oct 2026 17:54:16 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 693Hs8U0006195
 for <openvpn-devel@lists.sourceforge.net>; Sat, 3 Oct 2026 19:54:08 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 693Hs8MW006194
 for openvpn-devel@lists.sourceforge.net; Sat, 3 Oct 2026 19:54:08 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat,  3 Oct 2026 19:54:01 +0200
Message-ID: <20261003175407.6176-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790774523000.I76c310f9e69276d4f21a4ad31a24490553d6d5c4@gerrit.openvpn.net>
References: <gerrit.1790774523000.I76c310f9e69276d4f21a4ad31a24490553d6d5c4@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xD3w7-00077O-6h
Subject: [Openvpn-devel] [PATCH v2] cppcheck: Review suppressions for
 constParameter and constParameterCallback
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

I reviewed all the occurrences of the two cppcheck
errors constParameter and constParameterCallback.

All of constParameterCallback occurences were bogus and
I think in most cases they will be. So continue to ignore
it completely but document that we considered it and it
is not useful.

All existing cases of constParameter were bogus, but
there might be useful hits in the future so I only
suppress the existing occurrences.

Change-Id: I76c310f9e69276d4f21a4ad31a24490553d6d5c4
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1966
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1966
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/dev-tools/cppcheck-suppressions.xml b/dev-tools/cppcheck-suppressions.xml
index bd24c3b..33337cf 100644
--- a/dev-tools/cppcheck-suppressions.xml
+++ b/dev-tools/cppcheck-suppressions.xml
@@ -3,23 +3,20 @@
   <!-- We start with enable=all, but then suppress some issues that have too many
        occurences right now. They still should be fixed at some point -->
   <suppress>
-    <id>constParameter</id>
-  </suppress>
-  <suppress>
-    <id>constParameterCallback</id>
-  </suppress>
-  <suppress>
     <id>unusedFunction</id>
   </suppress>
   <suppress>
     <id>usleepCalled</id>
   </suppress>
-  <!-- We have a lot of library includes, not all of them are really required,
+  <!-- These are specific false-positives (FP) or ignored (IGN) issues
+       We might want to move some of them to inline-suppression to avoid
+       the static line-numbers -->
+  <!-- IGN: We have a lot of library includes, not all of them are really required,
        so ignore them -->
   <suppress>
     <id>missingIncludeSystem</id>
   </suppress>
-  <!-- cppcheck doesn't understand about check_malloc_return, so these are
+  <!-- FP: cppcheck doesn't understand about check_malloc_return, so these are
        usually misleading -->
   <suppress>
     <id>nullPointerOutOfMemory</id>
@@ -27,9 +24,6 @@
   <suppress>
     <id>nullPointerArithmeticOutOfMemory</id>
   </suppress>
-  <!-- These are specific false-positives (FP) or ignored (IGN) issues
-       We might want to move some of them to inline-suppression to avoid
-       the static line-numbers -->
   <!-- IGN: posix.cfg: We are not threadsafe -->
   <suppress>
     <id>getgrnamCalled</id>
@@ -62,6 +56,11 @@
     <id>badBitmaskCheck</id>
     <fileName>tests/unit_tests/openvpn/test_pkt.c</fileName>
   </suppress>
+  <!-- FP: All occurrences are either external types or types that
+       explicitly need to be non-const in some variants of the callback -->
+  <suppress>
+    <id>constParameterCallback</id>
+  </suppress>
   <!-- IGN: we use casts to remove const -->
   <suppress>
     <id>constParameterPointer</id>
@@ -74,6 +73,12 @@
     <fileName>src/openvpn/buffer.c</fileName>
     <symbolName>buf</symbolName>
   </suppress>
+  <!-- FP: can't change the signature of wmain -->
+  <suppress>
+    <id>constParameter</id>
+    <fileName>src/openvpn/openvpn.c</fileName>
+    <symbolName>wargv</symbolName>
+  </suppress>
   <!-- IGN: external -->
   <suppress>
     <id>constParameterPointer</id>
@@ -81,6 +86,10 @@
   </suppress>
   <!-- IGN: too many false-positives due to stubs -->
   <suppress>
+    <id>constParameter</id>
+    <fileName>tests/unit_tests/openvpn*/test_*</fileName>
+  </suppress>
+  <suppress>
     <id>constParameterPointer</id>
     <fileName>tests/unit_tests/openvpn*/test_*</fileName>
   </suppress>


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
