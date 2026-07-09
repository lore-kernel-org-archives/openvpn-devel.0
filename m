Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006F3C44506
	for <openvpn-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ezmBeNb+RaCfg7zsdJKHetGssXsiPdXQxMu4xLhZv3U=; b=ZaiJfESGnsdo9oKHYngzxumYyG
	fpl0eQTjqN9IWr+RqtMUXCzUaxyPCuKNsa5D3sykTYBxETGrhEQ+0MxEb8buM7mXN1C0Sg15QJfCX
	WvQqixtM2HUWxKGoKLGxIGLG6KSLkoNF2zOuLDeqOhLxML/yGyIYD04aVyK9Zf/PPeXg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whqXn-0004j0-SW;
	Thu, 09 Jul 2026 15:20:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1whqXZ-0004hp-05
 for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:19:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yzFXE5eVVSs6age2Z8onHIYo/ziMqqECyatam/aPWwU=; b=UTduYyKvIVnXV4EyRtPYw0/IVU
 P0ysRLzgPd4kR0PjrTQOxjG/nIR+o1+mJjSeFU3iZYJC7xcdicrXQWhQEj2GI5c5fESoHziuY8pOP
 Ck5rSzUF2xjH/e+qG0uAyr+xlNO3b5xgNJsAWKYNQNFyBB7QeyKyymy5Oa2Wcj1rvWMs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yzFXE5eVVSs6age2Z8onHIYo/ziMqqECyatam/aPWwU=; b=nD7tCJaaS1dPosT+6V4FJBOIuX
 33FkGIiLam4YsN5eqtBE73CL3db529j5611g3+7b4PIgmvfNARHNz+5E2yrqtU2d5FWZcMfaKEYVd
 fww2+P4bIqSNXQmsXQgKUJWazrjNQBpiHhRtWGkLBf41b9CLr3DmZxIOjG4ILS05j+uc=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1whqXP-0007Yh-Fy for openvpn-devel@lists.sourceforge.net;
 Thu, 09 Jul 2026 15:19:46 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gwyNy5ycczMlFg;
 Thu, 09 Jul 2026 16:42:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1783608162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yzFXE5eVVSs6age2Z8onHIYo/ziMqqECyatam/aPWwU=;
 b=jbjhI5kKDUw5BoSPPOWYgRis9xbwM/O1OpSLGlXqOwRpJgc1gUkNd/dv5IyTOExCpbbdJS
 iPQO+h/MQKzxvTZLiDqEGKTT9A1qjf/EqHmqvr3IEc1JGJ1zzsH/Ki4woS+3egAcRLEc2U
 PKARZ0hiQmrxMy5+AOgmZAX7DmINK/9eNSW5D4GYDfhhXNr/1kSRHLGsPN0rOylutC57Kn
 h2Mkfr9/G2P+BZKkYQXCRKBhN0WlesebDCFGq3BjAg3JQ6wGnffg/sQJ8cV61OnjfsB81s
 TKvJTPYS6eNupl/2C3xsAxoFozHXzELeCaTelPQtMzI1ss64GNei8gzeAJAWFQ==
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  9 Jul 2026 16:42:40 +0200
Message-ID: <20260709144240.61362-1-frank@lichtenheld.com>
In-Reply-To: <gerrit.1782719911000.Icc14b286f2409738c73873aa7550dcc005ee8cbb@gerrit.openvpn.net>
References: <gerrit.1782719911000.Icc14b286f2409738c73873aa7550dcc005ee8cbb@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1whqXP-0007Yh-Fy
Subject: [Openvpn-devel] [PATCH v1] CMake: detect cmocka_version.h via
 include path, not by linking
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
Cc: Lev Stipakov <lev@openvpn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Lev Stipakov <lev@openvpn.net>

check_include_files() was invoked with cmocka in CMAKE_REQUIRED_LIBRARIES,
which makes the probe link the (shared, imported) cmocka library. On some
platforms that link step fails inside the minimal probe, so the header check
reports failure and HAVE_CMOCKA_VERSION_H is left undefined even though
cmocka_version.h is present.

test_common.h then selects its cmocka 1.x compatibility shims and redefines
macros (check_expected_uint, expect_uint_value, ...) that cmocka 2.x already
provides, which breaks the -Werror build of every unit test driver.

Detecting a header only needs the include search path, so pass cmocka's
INTERFACE_INCLUDE_DIRECTORIES via CMAKE_REQUIRED_INCLUDES and drop the library
link requirement from the probe.

Change-Id: Icc14b286f2409738c73873aa7550dcc005ee8cbb
Signed-off-by: Lev Stipakov <lev@openvpn.net>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1739
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1739
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 4779d69..8de836a 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -385,12 +385,20 @@
     find_package(cmocka CONFIG)
     if (TARGET cmocka::cmocka)
         set(CMOCKA_LIBRARIES cmocka::cmocka)
+        get_target_property(CMOCKA_INCLUDE_DIRS cmocka::cmocka INTERFACE_INCLUDE_DIRECTORIES)
     else ()
         pkg_search_module(cmocka cmocka REQUIRED IMPORTED_TARGET)
         set(CMOCKA_LIBRARIES PkgConfig::cmocka)
+        set(CMOCKA_INCLUDE_DIRS ${cmocka_INCLUDE_DIRS})
     endif ()
-    set(CMAKE_REQUIRED_LIBRARIES ${CMOCKA_LIBRARIES})
+    # cmocka_version.h exists since cmocka 2.0; its absence selects the
+    # cmocka 1.x compat shims in test_common.h. Detecting a header only needs
+    # the include path - do NOT add cmocka to CMAKE_REQUIRED_LIBRARIES, as that
+    # makes check_include_files link the shared library, which can fail in the
+    # probe for unrelated reasons and wrongly mis-detect cmocka 2.x as < 2.0.
+    set(CMAKE_REQUIRED_INCLUDES ${CMOCKA_INCLUDE_DIRS})
     check_include_files(cmocka_version.h HAVE_CMOCKA_VERSION_H)
+    unset(CMAKE_REQUIRED_INCLUDES)
 endif ()
 
 configure_file(config.h.cmake.in config.h)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
