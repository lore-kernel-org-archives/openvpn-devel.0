Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7C1C9832A
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Do4BK5yN6BJlsoUrrVtCk6C2Mq4/G29VYHd/VLK/CoQ=; b=NVJPmecbmz1ASzZjTTKOREnHJA
	02g3kMoOI8pFBVJBR8hLseY2fIbD+qkH78j81pQORdaAFtVs6IjqeOxi3ahFxcSKX59QVV7Qm0+GD
	1w8hJ1DjEymMaqBdG0WREALn5YvJ0P92SVA6le24+VoJBNysO/EGCGj4OlyYNvXjt4Lk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xADVw-0000O3-MJ;
	Fri, 25 Sep 2026 21:31:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xADVv-0000Ns-IB
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 21:31:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pac9RQSgWiMKFBbpaAhxny0GJKquF8MJ5KMdxbMay0M=; b=DLuzQjS3wqNBTbCaxRWco+j2bo
 VndqFXC+JQREpGcf1rB8k3AofuWZ2xaSh6OKFvnoes7MK/VsruGZe8z4wmm7NEy9HmYFKghG1xoG0
 Hg+7/i0r9SEWHKeLkCX/Qv/sum8OM18BHGrxNGc8E8Ucmoif+dn4+EorgI2q0b265TI4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pac9RQSgWiMKFBbpaAhxny0GJKquF8MJ5KMdxbMay0M=; b=iJn6RRDX0e/lxDJ2ILEL8H88MO
 zJIXIDj52YSWO4Ua49nFCT5yoeZCnOVgREe0NtLVRqDYWzBX9ZvknLmlqCwVeWd/rz7D0I1YLT23Q
 nv674SdILNVbv4I+OW/Y06ss2hFYJmgAhJfEl0l/QFigHtCz8kYk8VU0Vd1UFfdxyo04=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xADVu-0000N9-7x for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 21:31:28 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68PLVJiu029522
 for <openvpn-devel@lists.sourceforge.net>; Fri, 25 Sep 2026 23:31:19 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68PLVJVr029521
 for openvpn-devel@lists.sourceforge.net; Fri, 25 Sep 2026 23:31:19 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 25 Sep 2026 23:31:12 +0200
Message-ID: <20260925213118.29507-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790352577000.Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9@gerrit.openvpn.net>
References: <gerrit.1790352577000.Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xADVu-0000N9-7x
Subject: [Openvpn-devel] [PATCH v2] cppcheck: Clean up suppressions to not
 annoy developers
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

Actually using it in CI has shown that the line number
based suppression is just too annoying. Therefor:

- Switch to XML based suppressions that allow us to
  use symbolName in addition to lineNumber to limit the
  suppression.
- Suppress knownConditionTrueFalse always. There are just
  too many instances due to how our code is structured.
- Also remove some unused suppressions.
- Replace some suppressions with code fixes. These are
  generally speaking false positives but the code fix
  is less ugly than the suppression.
- Work around one issue with using PRIx64 macro in a
  pre-prepared format string by adding a definition in
  our library definition.
- All suppressions that remain that were still lineNumber
  based (due to the check not reporting a symbol), move
  to inline suppressions. Inline suppressions are somewhat
  ugly, but these are very few and I see no better
  alternative. Maybe we can get rid of some of them by
  reporting issues to cppcheck. (Or, in some cases, by
  improving our code).

While here, make sure that we always run the Windows scan
as well, so developers get complete feedback on first push.

Change-Id: Ie06d3543d0a5d4ca3d3fd6f41498e6917ab4c8a9
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1953
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1953
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
deleted file mode 100644
index 27c9d30..0000000
--- a/dev-tools/cppcheck-suppression
+++ /dev/null
@@ -1,119 +0,0 @@
-# We start with --enable=all, but then suppress some issues that have too many
-# occurences right now. They still should be fixed at some point
-constParameter
-constParameterCallback
-constParameterPointer
-invalidPrintfArgType_sint
-invalidPrintfArgType_uint
-unusedFunction
-usleepCalled
-variableScope
-# We have a lot of library includes, not all of them are really required,
-# so ignore them
-missingIncludeSystem
-# cppcheck doesn't understand about check_malloc_return, so these are
-# usually misleading
-nullPointerOutOfMemory
-nullPointerArithmeticOutOfMemory
-# These are specific false-positives (FP) or ignored (IGN) issues
-# We might want to move some of them to inline-suppression to avoid
-# the static line-numbers
-# IGN: posix.cfg: We are not threadsafe
-getgrnamCalled
-getpwnamCalled
-getservbynameCalled
-localtimeCalled
-# FP: posix.cfg claims suseconds_t is unsigned for some reason
-unsignedLessThanZero:src/openvpn/otime.h:148
-# IGN: multi code does weird things with pointers to local variables...
-autoVariables:src/openvpn/multi.c:4242
-autoVariables:src/openvpn/multi_io.c:324
-# IGN: the code header = 0 | (OPCODE << P_OPCODE_SHIFT) is used intentionally
-badBitmaskCheck:src/openvpn/mudp.c
-badBitmaskCheck:tests/unit_tests/openvpn/test_pkt.c
-# IGN: Windows specific (unsigned long == unsigned int)
-compareValueOutOfTypeRangeError:src/openvpn/ssl_verify.c:928
-# FP: cppcheck seems to have wrong signature of DeviceIoControl()
-constVariablePointer:src/openvpn/dco_win.c
-# IGN: test_networking code would break with iproute2 but that is prevented
-ctunullpointer:src/openvpn/networking_iproute2.c
-# IGN: event code uses a pointer to store integers
-intToPointerCast:src/openvpn/forward.c
-intToPointerCast:src/openvpn/multi_io.c
-intToPointerCast:src/openvpn/ps.c
-# FP: constant but differs between platforms
-knownConditionTrueFalse:src/openvpn/error.h:382
-knownConditionTrueFalse:src/openvpn/fdmisc.c:80
-knownConditionTrueFalse:src/openvpn/lladdr.c:64
-knownConditionTrueFalse:src/openvpn/platform.c
-# FP: code needs to accomodate many different defines
-knownConditionTrueFalse:src/openvpn/event.c:1139
-knownConditionTrueFalse:src/openvpn/event.c:1148
-# FP: dco_win support has "false" stubs
-knownConditionTrueFalse:src/openvpn/forward.c
-knownConditionTrueFalse:src/openvpn/init.c
-knownConditionTrueFalse:src/openvpn/multi_io.c:197
-# FP: cppcheck thinks that some functions always return true, but they don't
-knownConditionTrueFalse:src/openvpn/misc.c:97
-knownConditionTrueFalse:src/openvpn/sig.h:116
-# FP: cert_uri_supported is a wrapper around defines, so it's
-# always constant but differs depending on OpenSSL version
-knownConditionTrueFalse:src/openvpn/ssl_openssl.c:1260
-# FP: cppcheck doesn't understand that the function changes szErrMessage
-knownConditionTrueFalse:src/tapctl/main.c:704
-knownConditionTrueFalse:src/openvpnmsica/dllmain.c:164
-# FP: cppcheck seems to be confused since we cast the pointer to integer
-memleak:src/plugins/down-root/down-root.c:337
-# IGN: we just abort instead
-memleakOnRealloc:src/openvpn/dco_freebsd.c:845
-# FP: eventmsg.h is not built on Unix
-missingInclude:src/openvpnserv/common.c:25
-# IGN: strlen(NULL) is not nice code, but seems to work
-nullPointerRedundantCheck:src/openvpn/init.c:301
-# FP: cppcheck doesn't understand ZeroMemory
-redundantAssignment:src/openvpnserv/interactive.c:204
-# IGN: We reuse the same variable name due to macro usage
-shadowVariable:src/openvpn/options.c:1955
-shadowVariable:src/openvpn/options.c:1973
-# FP: fun:tls_crypt_v2_wrap_unwrap_invalid: cppcheck is confused
-syntaxError:tests/unit_tests/openvpn/test_tls_crypt.c:684
-# FP: this file is never compiled on _WIN32
-umaskCalled:tests/unit_tests/openvpn/test_pkcs11.c
-# FP: yes, t_prev is unitialized, but t_prev_len is 0, so that's handled
-uninitvar:src/openvpn/crypto_epoch.c:60
-# FP: yes, parm is unitialized, but parm_len is 0, so that's handled
-uninitvar:src/openvpn/options_parse.c:148
-# FP: uninit is fine when it is a return parameter
-ctuuninitvar:src/openvpn/crypto_mbedtls_legacy.c:690
-uninitvar:src/openvpnserv/interactive.c:2783
-uninitvar:src/tapctl/main.c:566
-# FP: weird parse error, the macro is fine in the rest of the file
-unknownMacro:src/openvpnserv/interactive.c:3604
-# FP: cppcheck doesn't account for short-circuiting
-unreadVariable:src/openvpn/manage.c:682
-unusedFunction:src/openvpn/siphash_reference.c
-# FP: exported as DLL
-unusedFunction:src/openvpnmsica/*.c
-# FP: loaded as plugins
-unusedFunction:src/plugins/*
-unusedFunction:sample/sample-plugins/*
-# FP: wmain
-unusedFunction:src/tapctl/main.c:613
-unusedFunction:tests/unit_tests/openvpnserv/test_openvpnserv.c
-# IGN: keep mocking around for future use
-unusedFunction:tests/unit_tests/openvpn/mock_msg.c
-unusedFunction:/usr/include/*
-# FP: cppcheck doesn't know the NLA macros
-unusedLabel:src/openvpn/dco_linux.c
-# IGN: old code that is difficult to test (MSG_ERRQUEUE), ignore for now
-unusedStructMember:src/openvpn/mtu.c:289
-# FP: used implictly by NL macros
-unusedStructMember:src/openvpn/networking_sitnl.c
-# IGN: keep explanatory fields in test data
-unusedStructMember:tests/unit_tests/openvpn/test_pkcs11.c
-# IGN: nicer to assign generic "arg" early
-variableScope:src/openvpn/networking_sitnl.c:1390
-# IGN: nicer to keep the "variable" earlier
-variableScope:src/openvpnserv/interactive.c:2687
-# FP: fun:platform_create_temp_file: cppcheck is confused
-wrongPrintfScanfArgNum:src/openvpn/platform.c:553
diff --git a/dev-tools/cppcheck-suppressions.xml b/dev-tools/cppcheck-suppressions.xml
new file mode 100644
index 0000000..73dd41b
--- /dev/null
+++ b/dev-tools/cppcheck-suppressions.xml
@@ -0,0 +1,209 @@
+<?xml version="1.0"?>
+<suppressions>
+  <!-- We start with enable=all, but then suppress some issues that have too many
+       occurences right now. They still should be fixed at some point -->
+  <suppress>
+    <id>constParameter</id>
+  </suppress>
+  <suppress>
+    <id>constParameterCallback</id>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+  </suppress>
+  <suppress>
+    <id>invalidPrintfArgType_sint</id>
+  </suppress>
+  <suppress>
+    <id>invalidPrintfArgType_uint</id>
+  </suppress>
+  <suppress>
+    <id>unusedFunction</id>
+  </suppress>
+  <suppress>
+    <id>usleepCalled</id>
+  </suppress>
+  <suppress>
+    <id>variableScope</id>
+  </suppress>
+  <!-- We have a lot of library includes, not all of them are really required,
+       so ignore them -->
+  <suppress>
+    <id>missingIncludeSystem</id>
+  </suppress>
+  <!-- cppcheck doesn't understand about check_malloc_return, so these are
+       usually misleading -->
+  <suppress>
+    <id>nullPointerOutOfMemory</id>
+  </suppress>
+  <suppress>
+    <id>nullPointerArithmeticOutOfMemory</id>
+  </suppress>
+  <!-- These are specific false-positives (FP) or ignored (IGN) issues
+       We might want to move some of them to inline-suppression to avoid
+       the static line-numbers -->
+  <!-- IGN: posix.cfg: We are not threadsafe -->
+  <suppress>
+    <id>getgrnamCalled</id>
+  </suppress>
+  <suppress>
+    <id>getpwnamCalled</id>
+  </suppress>
+  <suppress>
+    <id>getservbynameCalled</id>
+  </suppress>
+  <suppress>
+    <id>localtimeCalled</id>
+  </suppress>
+  <!-- IGN: too many false-positives due to platform-specific code -->
+  <suppress>
+    <id>knownConditionTrueFalse</id>
+  </suppress>
+  <!-- FP: posix.cfg claims suseconds_t is unsigned for some reason -->
+  <suppress>
+    <id>unsignedLessThanZero</id>
+    <fileName>src/openvpn/otime.h</fileName>
+    <symbolName>usec</symbolName>
+  </suppress>
+  <!-- IGN: the code header = 0 | (OPCODE << P_OPCODE_SHIFT) is used intentionally -->
+  <suppress>
+    <id>badBitmaskCheck</id>
+    <fileName>src/openvpn/mudp.c</fileName>
+  </suppress>
+  <suppress>
+    <id>badBitmaskCheck</id>
+    <fileName>tests/unit_tests/openvpn/test_pkt.c</fileName>
+  </suppress>
+  <!-- FP: cppcheck seems to have wrong signature of DeviceIoControl() -->
+  <suppress>
+    <id>constVariablePointer</id>
+    <fileName>src/openvpn/dco_win.c</fileName>
+    <symbolName>buf</symbolName>
+  </suppress>
+  <!-- IGN: test_networking code would break with iproute2 but that is prevented -->
+  <suppress>
+    <id>ctunullpointer</id>
+    <fileName>src/openvpn/networking_iproute2.c</fileName>
+  </suppress>
+  <!-- IGN: event code uses a pointer to store integers -->
+  <suppress>
+    <id>intToPointerCast</id>
+    <fileName>src/openvpn/forward.c</fileName>
+  </suppress>
+  <suppress>
+    <id>intToPointerCast</id>
+    <fileName>src/openvpn/multi_io.c</fileName>
+  </suppress>
+  <suppress>
+    <id>intToPointerCast</id>
+    <fileName>src/openvpn/ps.c</fileName>
+  </suppress>
+  <!-- FP: cppcheck seems to be confused since we cast the pointer to integer -->
+  <suppress>
+    <id>memleak</id>
+    <fileName>src/plugins/down-root/down-root.c</fileName>
+    <symbolName>context.command</symbolName>
+  </suppress>
+  <!-- IGN: we just abort instead -->
+  <suppress>
+    <id>memleakOnRealloc</id>
+    <fileName>src/openvpn/dco_freebsd.c</fileName>
+    <symbolName>buf</symbolName>
+  </suppress>
+  <!-- IGN: strlen(NULL) is not nice code, but seems to work -->
+  <suppress>
+    <id>nullPointerRedundantCheck</id>
+    <fileName>src/openvpn/init.c</fileName>
+    <symbolName>parameters</symbolName>
+  </suppress>
+  <!-- FP: cppcheck doesn't understand ZeroMemory -->
+  <suppress>
+    <id>redundantAssignment</id>
+    <fileName>src/openvpnserv/interactive.c</fileName>
+    <symbolName>overlapped-&gt;hEvent</symbolName>
+  </suppress>
+  <!-- IGN: We reuse the same variable name due to macro usage -->
+  <suppress>
+    <id>shadowVariable</id>
+    <fileName>src/openvpn/options.c</fileName>
+    <symbolName>use_err</symbolName>
+  </suppress>
+  <!-- FP: this file is never compiled on _WIN32 -->
+  <suppress>
+    <id>umaskCalled</id>
+    <fileName>tests/unit_tests/openvpn/test_pkcs11.c</fileName>
+  </suppress>
+  <!-- FP: yes, t_prev is unitialized, but t_prev_len is 0, so that's handled -->
+  <suppress>
+    <id>uninitvar</id>
+    <fileName>src/openvpn/crypto_epoch.c</fileName>
+    <symbolName>t_prev</symbolName>
+  </suppress>
+  <!-- FP: yes, parm is unitialized, but parm_len is 0, so that's handled -->
+  <suppress>
+    <id>uninitvar</id>
+    <fileName>src/openvpn/options_parse.c</fileName>
+    <symbolName>parm</symbolName>
+  </suppress>
+  <!-- FP: uninit is fine when it is a return parameter -->
+  <suppress>
+    <id>uninitvar</id>
+    <fileName>src/openvpnserv/interactive.c</fileName>
+    <symbolName>addr_list</symbolName>
+  </suppress>
+  <suppress>
+    <id>uninitvar</id>
+    <fileName>src/tapctl/main.c</fileName>
+    <symbolName>guidAdapter</symbolName>
+  </suppress>
+  <!-- FP: cppcheck doesn't account for short-circuiting -->
+  <suppress>
+    <id>unreadVariable</id>
+    <fileName>src/openvpn/manage.c</fileName>
+    <symbolName>n</symbolName>
+  </suppress>
+  <!-- FP: exported as DLL -->
+  <suppress>
+    <id>unusedFunction</id>
+    <fileName>src/openvpnmsica/*.c</fileName>
+  </suppress>
+  <!-- FP: loaded as plugins -->
+  <suppress>
+    <id>unusedFunction</id>
+    <fileName>src/plugins/*</fileName>
+  </suppress>
+  <suppress>
+    <id>unusedFunction</id>
+    <fileName>sample/sample-plugins/*</fileName>
+  </suppress>
+  <!-- IGN: keep mocking around for future use -->
+  <suppress>
+    <id>unusedFunction</id>
+    <fileName>tests/unit_tests/openvpn/mock_msg.c</fileName>
+  </suppress>
+  <suppress>
+    <id>unusedFunction</id>
+    <fileName>/usr/include/*</fileName>
+  </suppress>
+  <!-- FP: cppcheck doesn't know the NLA macros -->
+  <suppress>
+    <id>unusedLabel</id>
+    <fileName>src/openvpn/dco_linux.c</fileName>
+  </suppress>
+  <!-- IGN: old code that is difficult to test (MSG_ERRQUEUE), ignore for now -->
+  <suppress>
+    <id>unusedStructMember</id>
+    <fileName>src/openvpn/mtu.c</fileName>
+    <symbolName>probehdr::ttl</symbolName>
+  </suppress>
+  <!-- FP: used implictly by NL macros -->
+  <suppress>
+    <id>unusedStructMember</id>
+    <fileName>src/openvpn/networking_sitnl.c</fileName>
+  </suppress>
+  <!-- IGN: keep explanatory fields in test data -->
+  <suppress>
+    <id>unusedStructMember</id>
+    <fileName>tests/unit_tests/openvpn/test_pkcs11.c</fileName>
+  </suppress>
+</suppressions>
diff --git a/dev-tools/openvpn-cppcheck-library.cfg b/dev-tools/openvpn-cppcheck-library.cfg
index decac67..0537b39 100644
--- a/dev-tools/openvpn-cppcheck-library.cfg
+++ b/dev-tools/openvpn-cppcheck-library.cfg
@@ -28,4 +28,7 @@
   <define name="CMSG_NXTHDR" value="cmsg_nxthdr" />
   <!-- otherwise a lot of unused variables are shown for enable-small builds -->
   <define name="DMSG_ALWAYS_AVAILABLE" value="1" />
+  <!-- cppcheck understands it directly in format string, but not
+       indirectly when the format string is constructed earlier -->
+  <define name="PRIx64" value="&quot;lx&quot;" />
 </def>
diff --git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh
index 37de267..4c4ba2c 100755
--- a/dev-tools/run-cppcheck.sh
+++ b/dev-tools/run-cppcheck.sh
@@ -30,7 +30,7 @@
  --enable=all ${disable_arg} \
  --library=${SCRIPT_DIR}/openvpn-cppcheck-library.cfg \
  --library=openssl.cfg \
- --suppressions-list=${SCRIPT_DIR}/cppcheck-suppression \
+ --suppress-xml=${SCRIPT_DIR}/cppcheck-suppressions.xml --inline-suppr \
  --cppcheck-build-dir=${CPPCHECK_DIR} \
  --check-level=${CPPCHECK_CHECK_LEVEL} --max-configs=10 \
  --error-exitcode=1 --showtime=summary"
@@ -39,13 +39,14 @@
 
 mkdir -p "$CPPCHECK_DIR"
 cd "${SOURCE_DIR}"
+ret=0
 cppcheck $COMMON_ARGS $INCLUDE_FLAGS \
     --platform=unix64 \
     --library=posix.cfg --library=bsd.cfg --library=gnu.cfg \
     -U_WIN32 \
     src/openvpn/ src/compat/ src/plugins/ sample/ \
     tests/unit_tests/example_test/ tests/unit_tests/openvpn/ \
-    tests/unit_tests/plugins/
+    tests/unit_tests/plugins/ || ret=$?
 cppcheck $COMMON_ARGS \
     --platform=win64 \
     --library=windows.cfg \
@@ -55,4 +56,6 @@
     -UTARGET_AIX \
     -UOPENSSL_NO_EC \
     src/openvpn* src/compat/ \
-    tests/unit_tests/example_test/ tests/unit_tests/openvpn*
+    tests/unit_tests/example_test/ tests/unit_tests/openvpn* || ret=$?
+
+exit $ret
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index e5ad31a..dc22af5 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -268,7 +268,7 @@
             }
 
             /* Encrypt packet ID, payload */
-            int outlen;
+            int outlen = 0;
             ASSERT(cipher_ctx_update(ctx->cipher, BEND(&work), &outlen, BPTR(buf), BLEN(buf)));
             ASSERT(buf_inc_len(&work, outlen));
 
@@ -566,7 +566,7 @@
     dmsg(D_PACKET_CONTENT, "DECRYPT AD: %s", format_hex(ad_start, ad_size, 0, &gc));
 
     /* Decrypt and authenticate packet */
-    int outlen;
+    int outlen = 0;
     if (!cipher_ctx_update(ctx->cipher, BPTR(&work), &outlen, BPTR(buf), data_len))
     {
         CRYPT_ERROR("packet decryption failed");
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index fd54946..a6fadf6 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4239,6 +4239,7 @@
     struct multi_context multi;
 
     top->mode = CM_TOP;
+    // cppcheck-suppress autoVariables ; yes, we know this is dangerous
     top->multi = &multi;
     context_clear_2(top);
 
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 4b96c57..bce5018 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -321,6 +321,7 @@
 {
     const unsigned int mpp_flags = MPP_PRE_SELECT | MPP_RECORD_TOUCH;
     struct multi_instance *touched = mi;
+    // cppcheck-suppress autoVariables ; yes, we know this is dangerous
     m->mpp_touched = &touched;
 
     dmsg(D_MULTI_DEBUG, "MULTI IO: multi_io_dispatch a=%s mi=" ptr_format, pract(action),
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 3653eb4..6631718 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -925,6 +925,7 @@
 
             errno = 0;
             long timeout = strtol(BSTR(timeout_buf), NULL, 10);
+            // cppcheck-suppress compareValueOutOfTypeRangeError ; ULONG_MAX==UINT_MAX on Windows
             if (timeout <= 0 || (unsigned long)timeout > UINT_MAX || errno)
             {
                 msg(M_WARN, "could not parse auth pending file timeout");
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 7fc8c14..cce5318 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -22,6 +22,7 @@
 
 #include "service.h"
 #include "validate.h"
+// cppcheck-suppress missingInclude ; we run cppcheck on Linux w/o this file
 #include "eventmsg.h"
 
 #include <pathcch.h>
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 7819f5a..4a38aa4 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -3601,6 +3601,7 @@
         goto out;
     }
     swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
+             // cppcheck-suppress unknownMacro ; FP, complains about _L only here...
              L"\\\\.\\pipe\\" _L(PACKAGE) L"%ls\\service_%lu_%ls", service_instance,
              GetCurrentThreadId(), pipe_uuid_str);
     RpcStringFreeW(&pipe_uuid_str);
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index f648e13..f8aa199 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -681,6 +681,7 @@
     struct buffer tmp = create_client_key_input(ctx, 12);
 
     /* Make the wrapped key invalid by flipping a few bits */
+    // cppcheck-suppress syntaxError ; cppcheck is confused by this code
     buf_bptr(&tmp)[buf_len(&tmp) - 20] ^= 0x55;
 
     assert_false(tls_crypt_v2_extract_client_key(&tmp, &wrap_ctx, NULL));


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
