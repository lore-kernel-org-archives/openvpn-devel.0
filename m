Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A1ECA5FFC
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 06:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xHP02bTUOpNBy4XGQNMHjv5casDGNKrFw9uI2Ul0QYI=; b=cX+TLrkklUTnff9ikGloAJeHag
	c9jVSOMYDVmcUBZBhY1cq2PaUp6/zuq0zPEzeF8MOTKRdx0irbrlTzqhdPfScXITPtDvrP2RljgGJ
	h9EcayyXZZiozViq8sByTOIDobbAFilKeiyOlg0stYVL1gecT1YuYiyW1V7StPm+bybY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDyme-0004Yy-V6;
	Tue, 06 Oct 2026 06:36:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDyme-0004Ys-10
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 06:36:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Hv0cXzWiXnAwqj3993gtzaJvUg0/k2FAcn0/yU96PGU=; b=ULG8p7my5NJi+EDYZeH2XcIhsm
 4T6yicPczrnhp7wK7Y+/lhLCrEbTcUC9FAJrX1rfEqgcLE3CMCxTXJxKPRb/QkDDJAZGqt2WZfN0a
 /M9xQ1mnDL/VwvA6pN81AVZXskyrwH6IB7QiKxyqR1rR/p14uXS+9/7H4OJ9222c5TQ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Hv0cXzWiXnAwqj3993gtzaJvUg0/k2FAcn0/yU96PGU=; b=h
 9YXZaIHrF0n2nXefjK98taCIjEw1ZNQaRudqgdJmBTqOTk8qp9/ztk5b1Hswz0Pf1fdVweOawLJ0E
 yk5tJwcQ2R6hkzZmHICK/RcJh65/XQvlP1wwQaErkWIyXxBO4GM64/0i60QixF1Y5aQQ0jtxP92tV
 6CV7WM54+T2sy9b4=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDymb-0004oj-Vx for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 06:36:16 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-487048857f6so185008f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 23:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791268567; x=1791873367; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Hv0cXzWiXnAwqj3993gtzaJvUg0/k2FAcn0/yU96PGU=;
 b=cnu8KIa893cCjDIW6BRKlcO/YEY7HL92h/Pp8OzLHHN7lTlUYqP6rfE8kJ8g/Gqcj6
 nth0kLlJ5HYlutpedxqykw/5WamWcMRpnDhDoZ2Ll6H2ArHmzXIFpBoYQyLahjUQYpGO
 SdhVsiPF/AGnh54JL6VK2uGAMkInOv2vlIgkqNJI+kJcZ5P4XHwL5lteJ8Ju3qIE2VZO
 gnH+j72qTEfrXmrBKotJZZ8q7ej0FvigbJT9y1smU/3KPqc0sriyN/ZsX3R+4H/436rM
 ppWu0c3a7L85spCtjSDMrUJanBVIBqwBOavS8TaiP3wpwsrP4bgrt1beiRvut4mNV7b+
 NJ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791268567; x=1791873367;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Hv0cXzWiXnAwqj3993gtzaJvUg0/k2FAcn0/yU96PGU=;
 b=zx+1Mfzgb6lo96Q+ikH4KZQstZGXcE+4yi35Z6fQKgi3qKfNCpjj/Yrb+b/Oy6yUAf
 TcbM93Hh+1iOkpeEF8fDorFLAHbeCI5xvqObf10gdLgdNEBs2SrG6PuJa8QaobVJRBUV
 LRyk2SaNSTZtQVwA6jT0OZb872dZ+yUmlTSNOEC51LyJsG80424W0ypY7dYri4AxFb6u
 kWvoyf3a+V1Zr3izbUu8XgJodPmy180T/TahGJX3o0O/yVVDydxgEej5CaiKFzK5AK7C
 8kM0A8TYn/BHZ2Ia8UGsmBYlf3K4Z/mH9vSV5Yh6pHLNUAkrjNOmsqhrWHE9c2gxBFIR
 oePA==
X-Gm-Message-State: AFq9FYKf+C3JyKTlKJ2IlSYdelpYMxZhH9oASPQWYfZc7CFzWRdxuNst
 8izcrYW8Ra37TBhU4gI4wx87vNUIGsl6dA5O5QcOGn1m5dvrSn8ExGWBz55chQDy0NRb6nZgEzo
 waXdRAa6fsi+LiswRM2OEVsmt3anKwPyvptGIW3jU49I45/u54W+aYDLMOzndGEiL3i2S
X-Gm-Gg: AYBFou0VcfdEVrklmIN3upJ4u64oea0JTncQSjRDBQ7E2iDjLx5osOMXGNQFTelVI9+
 3Lw/2jq9gkMA+JIcSIydXQlLnmBYBiOJKY5K+YdpYZqeOo61LlHVUu3ox+5Im5YYRQozwk8b2an
 Wl3XyOtwnMDD1m6AlSMmBgv9dTzgQTXVMS8Dc4fkqIbtoziyr8klZ/6q4zZBt9gLfsF6MZDO/4E
 mu6mMAcXA4Tb2eg1pDLL+Zv3c2d/pl+iPX9/v2GH7iMoQUX8pE+RkpexgoTSqtXSJQmiuUkfeaU
 FQUUAldsRU7yk2F1692unlgUQj0r4hr8l5VO3kiNfyw52R+0pMaPdlp2zKeAROGuoE2MlKUI19I
 WcgI5HbgKKsmyq+Si/moyE1Pezqgxc6y73vcir2ORJ9pDcDFnx27OGjYEV1x1AsGCUuA2DQ2iJG
 odacmeLuVlmiQrKAi06+w4+2X/R5qCUDQSf6wNNZLsE/BbHTPU6yJ4HxU9Z2znTOi0zHL4ExlYC
 /ay5Pb4jweDV6wv6NUOTDG4FyAg9UVkRvzRvOAOa0WuMi3dli88E2iPKH/orUjNAE95vekAxQRW
 vq4Q3YcJRhdA1L5LWn+AcA8hqpzvWagw2v22vi7SoA0Z1QM8xvNN9Ii+0XRiY1QI/DLlvVg=
X-Received: by 2002:a05:6000:288d:b0:48a:efee:db70 with SMTP id
 ffacd0b85a97d-48c6d0f22f2mr701874f8f.7.1791268567007; 
 Mon, 05 Oct 2026 23:36:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c62eda863sm7461653f8f.43.2026.10.05.23.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 23:36:06 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 06:36:04 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: 01ecff0a2f8a41597b0a2350ae48ad21162eaf12
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e1c7ab0fddea3c6f619997212ee0a75c77d704f9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDymb-0004oj-Vx
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: add unit
 tests for route.c
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
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4104762708167406045=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4104762708167406045==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oDyKIZOayJY="; charset=UTF-8

--oDyKIZOayJY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru, chugly=2E

Hello Arne Schwabe, Frank Lichtenheld, R=C4=83=
zvan Cojocaru, 

I'd like you to reexamine a change=2E Please visit

    ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail

to look at the n=
ew patch set (#5)=2E

The following approvals got outdated and were removed=
:
Code-Review-1 by R=C4=83zvan Cojocaru


Change subject: tests: add unit t=
ests for route=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

tests: add unit tests for route=2Ec

route=2Ec has no unit test cov=
erage at all, so there is nowhere to put a
test when touching it=2E  Cover =
the pure helpers it already exports: the
special address predicate, both ne=
tmask-to-netbits conversions, and the
IPv6 prefix host-bit masking=2E

The =
two conversions disagree on a full-length netmask:
netmask_to_netbits() rep=
orts -1 and netmask_to_netbits2() reports 32=2E
--server relies on the -1 t=
o reject a /32, so pin it down=2E

Rather than add a driver of its own, the=
 tests are hosted by
networking_testdriver as case 9, alongside its existin=
g cases=2E  That
driver is already gated on HAVE_SITNL, which is what route=
=2Ec needs: it
reaches the routing table through net_route_* on Linux and t=
hrough
argv/execve elsewhere, so one set of stubs cannot link on both=2E
t_=
net=2Esh runs the cases above LAST_AUTO_TEST after it has removed its
dummy=
 interface, so the route tests need no interface and no particular
network =
state=2E

route=2Ec links against the real networking_sitnl=2Ec that the dr=
iver
already carries=2E  Only the socket and argv helpers that route=2Ec
re=
ferences but no test here reaches are stubbed, and those assert rather
than=
 return quietly, so a test straying onto one fails loudly=2E

Change-Id: I9=
085c55a7efefd31839b00ec8ec9a6f085574dde
Signed-off-by: Charlie Vigue <charl=
ie=2Evigue@openvpn=2Ecom>
---
M CMakeLists=2Etxt
M tests/t_net=2Esh
M tests=
/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_networkin=
g=2Ec
A tests/unit_tests/openvpn/test_route=2Ec
A tests/unit_tests/openvpn/=
test_route=2Eh
6 files changed, 219 insertions(+), 2 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/46/1946/5

diff=
 --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 2d9b546=2E=2E7e73fff 100=
644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -970,7 +970,14 @@
    =
 if (TARGET test_networking)
         target_link_options(test_networking P=
RIVATE -Wl,--wrap=3Dparse_line)
         target_compile_options(test_networ=
king PRIVATE -UNDEBUG)
+        target_link_libraries(test_networking PUBLI=
C ${RESOLV_LIBRARIES})
         target_sources(test_networking PRIVATE
+   =
         tests/unit_tests/openvpn/test_route=2Ec
+            tests/unit_te=
sts/openvpn/mock_management=2Ec
+            src/openvpn/route=2Ec
+       =
     src/openvpn/env_set=2Ec
+            src/openvpn/run_command=2Ec
+    =
        src/openvpn/socket_util=2Ec
             src/openvpn/networking_sit=
nl=2Ec
             src/openvpn/crypto_epoch=2Ec
             src/openvpn/c=
rypto_mbedtls=2Ec
diff --git a/tests/t_net=2Esh b/tests/t_net=2Esh
index d6=
3f648=2E=2Efd07277 100755
--- a/tests/t_net=2Esh
+++ b/tests/t_net=2Esh
@@ =
-3,7 +3,7 @@
 IFACE=3D"ovpn-dummy0"
 UNIT_TEST=3D"=2E/unit_tests/openvpn/ne=
tworking_testdriver"
 LAST_AUTO_TEST=3D7
-LAST_TEST=3D8
+LAST_TEST=3D9
 
 s=
rcdir=3D"${srcdir:-=2E}"
 top_builddir=3D"${top_builddir:-=2E=2E}"
diff --g=
it a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Make=
file=2Eam
index 5954902=2E=2E30b40b1 100644
--- a/tests/unit_tests/openvpn/=
Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -212,7 +212,1=
3 @@
 networking_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/=
openvpn \
 	$(OPTIONAL_CRYPTO_LIBS)
 networking_testdriver_SOURCES =3D test=
_networking=2Ec mock_msg=2Ec \
+	test_route=2Ec test_route=2Eh test_common=
=2Eh \
+	mock_management=2Ec \
 	$(top_srcdir)/src/openvpn/networking_sitnl=
=2Ec \
+	$(top_srcdir)/src/openvpn/route=2Ec \
+	$(top_srcdir)/src/openvpn/=
env_set=2Ec \
+	$(top_srcdir)/src/openvpn/run_command=2Ec \
+	$(top_srcdir)=
/src/openvpn/socket_util=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$=
(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_ep=
och=2Ec \
diff --git a/tests/unit_tests/openvpn/test_networking=2Ec b/tests=
/unit_tests/openvpn/test_networking=2Ec
index 1c9cac1=2E=2E849f247 100644
-=
-- a/tests/unit_tests/openvpn/test_networking=2Ec
+++ b/tests/unit_tests/op=
envpn/test_networking=2Ec
@@ -2,6 +2,8 @@
 #include "syshead=2Eh"
 #include=
 "networking=2Eh"
 
+#include "test_route=2Eh"
+
 #include <setjmp=2Eh>
 #i=
nclude <cmocka=2Eh>
 
@@ -212,7 +214,7 @@
 static void
 usage(char *name)
 =
{
-    printf("Usage: %s <0-8>\n", name);
+    printf("Usage: %s <0-9>\n", =
name);
 }
 
 int
@@ -272,6 +274,9 @@
             assert_int_equal(net__ifa=
ce_type("dummy0815", NULL), -ENODEV);
             return 0;
 
+        cas=
e 9:
+            return route_tests();
+
         default:
             pr=
intf("invalid test: %d\n", test);
             break;
diff --git a/tests/un=
it_tests/openvpn/test_route=2Ec b/tests/unit_tests/openvpn/test_route=2Ec
n=
ew file mode 100644
index 0000000=2E=2Ee24c696
--- /dev/null
+++ b/tests/un=
it_tests/openvpn/test_route=2Ec
@@ -0,0 +1,172 @@
+/*
+ *  OpenVPN -- An ap=
plication to securely tunnel IP networks
+ *             over a single UDP =
port, with support for SSL/TLS-based
+ *             session authentication=
 and key exchange,
+ *             packet encryption, packet authentication=
, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-202=
6 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software;=
 you can redistribute it and/or modify
+ *  it under the terms of the GNU G=
eneral Public License version 2
+ *  as published by the Free Software Foun=
dation=2E
+ *
+ *  This program is distributed in the hope that it will be =
useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of=

+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  =
GNU General Public License for more details=2E
+ *
+ *  You should have rec=
eived a copy of the GNU General Public License along
+ *  with this program=
; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CO=
NFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include=
 "test_common=2Eh"
+
+#include "route=2Eh"
+#include "networking=2Eh"
+
+#i=
nclude "test_route=2Eh"
+
+/* Stubs for functions route=2Ec references but =
that no test here reaches=2E
+ * They assert rather than return quietly, so=
 a test straying onto one
+ * fails loudly instead of silently doing nothin=
g=2E
+ */
+struct argv
+argv_new(void)
+{
+    assert_true(0);
+    struct =
argv a =3D { 0 };
+    return a;
+}
+
+void
+argv_free(struct argv *a)
+{
+=
    assert_true(0);
+}
+
+bool
+get_ipv6_addr(const char *prefix_str, struc=
t in6_addr *network, unsigned int *netbits,
+              msglvl_t msgleve=
l)
+{
+    assert_true(0);
+    return false;
+}
+
+in_addr_t
+getaddr(unsi=
gned int flags, const char *hostname, int resolve_retry, bool *succeeded,
+=
        struct signal_info *sig_info)
+{
+    assert_true(0);
+    return 0=
;
+}
+
+struct signal_info siginfo_static; /* GLOBAL */
+
+int
+signal_rese=
t(struct signal_info *si, int signum)
+{
+    assert_true(0);
+    return 0=
;
+}
+
+static void
+test_is_special_addr(void **state)
+{
+    assert_true=
(is_special_addr("net_gateway"));
+    assert_true(is_special_addr("vpn_gat=
eway"));
+    assert_true(is_special_addr("remote_host"));
+
+    assert_fa=
lse(is_special_addr("10=2E0=2E0=2E1"));
+    assert_false(is_special_addr("=
default"));
+    assert_false(is_special_addr(NULL));
+}
+
+static void
+te=
st_netmask_to_netbits(void **state)
+{
+    int netbits;
+
+    assert_true=
(netmask_to_netbits(0x0a000000, 0xff000000, &netbits)); /* 10/8 */
+    ass=
ert_int_equal(netbits, 8);
+
+    assert_true(netmask_to_netbits(0xc0a80100=
, 0xffffff00, &netbits)); /* 192=2E168=2E1/24 */
+    assert_int_equal(netb=
its, 24);
+
+    assert_true(netmask_to_netbits(0x00000000, 0x00000000, &ne=
tbits)); /* default route */
+    assert_int_equal(netbits, 0);
+
+    /* a=
 full-length mask reports -1 rather than 32 */
+    assert_true(netmask_to_=
netbits(0x0a010203, 0xffffffff, &netbits));
+    assert_int_equal(netbits, =
-1);
+
+    /* host bits set in the network part */
+    assert_false(netma=
sk_to_netbits(0x0a000001, 0xff000000, &netbits));
+
+    /* not a contiguou=
s netmask */
+    assert_false(netmask_to_netbits(0x0a000000, 0xff00ff00, &=
netbits));
+}
+
+static void
+test_netmask_to_netbits2(void **state)
+{
+  =
  assert_int_equal(netmask_to_netbits2(0xff000000), 8);
+    assert_int_equ=
al(netmask_to_netbits2(0xffffff00), 24);
+    assert_int_equal(netmask_to_n=
etbits2(0x00000000), 0);
+
+    /* unlike netmask_to_netbits(), this one re=
ports a full-length mask as 32 */
+    assert_int_equal(netmask_to_netbits2=
(0xffffffff), 32);
+
+    assert_int_equal(netmask_to_netbits2(0xff00ff00),=
 -1);
+}
+
+static void
+assert_clear_host_bits(const char *addr, unsigned =
int netbits, const char *expected)
+{
+    struct route_ipv6 r6;
+    struc=
t in6_addr want;
+
+    CLEAR(r6);
+    assert_int_equal(inet_pton(AF_INET6=
, addr, &r6=2Enetwork), 1);
+    assert_int_equal(inet_pton(AF_INET6, expec=
ted, &want), 1);
+    r6=2Enetbits =3D netbits;
+
+    route_ipv6_clear_hos=
t_bits(&r6);
+    assert_memory_equal(&r6=2Enetwork, &want, sizeof(struct i=
n6_addr));
+}
+
+static void
+test_route_ipv6_clear_host_bits(void **state)=

+{
+    /* whole bytes cleared */
+    assert_clear_host_bits("2001:db8::1=
", 64, "2001:db8::");
+    assert_clear_host_bits("2001:db8:dead:beef::1", =
32, "2001:db8::");
+
+    /* a prefix that does not fall on a byte boundary=
 */
+    assert_clear_host_bits("2001:db8:0:00ff::1", 60, "2001:db8:0:00f0:=
:");
+    assert_clear_host_bits("2001:db8::ffff", 121, "2001:db8::ff80");
=
+
+    /* nothing to clear, and everything to clear */
+    assert_clear_ho=
st_bits("2001:db8::1", 128, "2001:db8::1");
+    assert_clear_host_bits("20=
01:db8::1", 0, "::");
+}
+
+static const struct CMUnitTest route_test_list[=
] =3D {
+    cmocka_unit_test(test_is_special_addr),
+    cmocka_unit_test(=
test_netmask_to_netbits),
+    cmocka_unit_test(test_netmask_to_netbits2),
=
+    cmocka_unit_test(test_route_ipv6_clear_host_bits),
+};
+
+int
+route_t=
ests(void)
+{
+    openvpn_unit_test_setup();
+    return cmocka_run_group_=
tests(route_test_list, NULL, NULL);
+}
diff --git a/tests/unit_tests/openvp=
n/test_route=2Eh b/tests/unit_tests/openvpn/test_route=2Eh
new file mode 10=
0644
index 0000000=2E=2Ecaa5c3c
--- /dev/null
+++ b/tests/unit_tests/openvp=
n/test_route=2Eh
@@ -0,0 +1,27 @@
+/*
+ *  OpenVPN -- An application to sec=
urely tunnel IP networks
+ *             over a single UDP port, with suppo=
rt for SSL/TLS-based
+ *             session authentication and key exchang=
e,
+ *             packet encryption, packet authentication, and
+ *       =
      packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <s=
ales@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistr=
ibute it and/or modify
+ *  it under the terms of the GNU General Public Li=
cense version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ =
*  This program is distributed in the hope that it will be useful,
+ *  but=
 WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTAB=
ILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Publ=
ic License for more details=2E
+ *
+ *  You should have received a copy of =
the GNU General Public License along
+ *  with this program; if not, see <h=
ttps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+#ifndef TEST_ROUTE_H
+#define TE=
ST_ROUTE_H
+/** Runs the route=2Ec unit tests, returns the number of failur=
es */
+int
+route_tests(void);
+#endif

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
Gerrit-=
Change-Number: 1946
Gerrit-PatchSet: 5
Gerrit-Owner: chugly <charlie=2Evigu=
e@openvpn=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Review=
er: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: chugly <charlie=
=2Evigue@openvpn=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--oDyKIZOayJY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
, chugly=2E </p>
<p>chugly <strong>uploaded patch set #5</strong> to this c=
hange=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?u=
sp=3Demail">View Change</a></p><p>The following approvals got outdated and =
were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">tests:=
 add unit tests for route=2Ec<br><br>route=2Ec has no unit test coverage at=
 all, so there is nowhere to put a<br>test when touching it=2E  Cover the p=
ure helpers it already exports: the<br>special address predicate, both netm=
ask-to-netbits conversions, and the<br>IPv6 prefix host-bit masking=2E<br><=
br>The two conversions disagree on a full-length netmask:<br>netmask_to_net=
bits() reports -1 and netmask_to_netbits2() reports 32=2E<br>--server relie=
s on the -1 to reject a /32, so pin it down=2E<br><br>Rather than add a dri=
ver of its own, the tests are hosted by<br>networking_testdriver as case 9,=
 alongside its existing cases=2E  That<br>driver is already gated on HAVE_S=
ITNL, which is what route=2Ec needs: it<br>reaches the routing table throug=
h net_route_* on Linux and through<br>argv/execve elsewhere, so one set of =
stubs cannot link on both=2E<br>t_net=2Esh runs the cases above LAST_AUTO_T=
EST after it has removed its<br>dummy interface, so the route tests need no=
 interface and no particular<br>network state=2E<br><br>route=2Ec links aga=
inst the real networking_sitnl=2Ec that the driver<br>already carries=2E  O=
nly the socket and argv helpers that route=2Ec<br>references but no test he=
re reaches are stubbed, and those assert rather<br>than return quietly, so =
a test straying onto one fails loudly=2E<br><br>Change-Id: I9085c55a7efefd3=
1839b00ec8ec9a6f085574dde<br>Signed-off-by: Charlie Vigue &lt;charlie=2Evig=
ue@openvpn=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M tests/t_net=2Esh<br>=
M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test=
_networking=2Ec<br>A tests/unit_tests/openvpn/test_route=2Ec<br>A tests/uni=
t_tests/openvpn/test_route=2Eh<br>6 files changed, 219 insertions(+), 2 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/46/1946/5</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt =
b/CMakeLists=2Etxt</span><br><span>index 2d9b546=2E=2E7e73fff 100644</span>=
<br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</sp=
an><br><span>@@ -970,7 +970,14 @@</span><br><span>     if (TARGET test_netw=
orking)</span><br><span>         target_link_options(test_networking PRIVAT=
E -Wl,--wrap=3Dparse_line)</span><br><span>         target_compile_options(=
test_networking PRIVATE -UNDEBUG)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        target_link_libraries(test_networking PUBLIC ${RESOLV=
_LIBRARIES})</span><br><span>         target_sources(test_networking PRIVAT=
E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            tests/=
unit_tests/openvpn/test_route=2Ec</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            tests/unit_tests/openvpn/mock_management=2Ec</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/=
route=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  src/openvpn/env_set=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            src/openvpn/run_command=2Ec</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            src/openvpn/socket_util=2Ec</span><br=
><span>             src/openvpn/networking_sitnl=2Ec</span><br><span>      =
       src/openvpn/crypto_epoch=2Ec</span><br><span>             src/openvp=
n/crypto_mbedtls=2Ec</span><br><span>diff --git a/tests/t_net=2Esh b/tests/=
t_net=2Esh</span><br><span>index d63f648=2E=2Efd07277 100755</span><br><spa=
n>--- a/tests/t_net=2Esh</span><br><span>+++ b/tests/t_net=2Esh</span><br><=
span>@@ -3,7 +3,7 @@</span><br><span> IFACE=3D&quot;ovpn-dummy0&quot;</span=
><br><span> UNIT_TEST=3D&quot;=2E/unit_tests/openvpn/networking_testdriver&=
quot;</span><br><span> LAST_AUTO_TEST=3D7</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-LAST_TEST=3D8</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+LAST_TEST=3D9</span><br><span> </span><br><span> srcdir=3D&qu=
ot;${srcdir:-=2E}&quot;</span><br><span> top_builddir=3D&quot;${top_builddi=
r:-=2E=2E}&quot;</span><br><span>diff --git a/tests/unit_tests/openvpn/Make=
file=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 59=
54902=2E=2E30b40b1 100644</span><br><span>--- a/tests/unit_tests/openvpn/Ma=
kefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</s=
pan><br><span>@@ -212,7 +212,13 @@</span><br><span> networking_testdriver_L=
DFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn \</span><br><span> 	$=
(OPTIONAL_CRYPTO_LIBS)</span><br><span> networking_testdriver_SOURCES =3D t=
est_networking=2Ec mock_msg=2Ec \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	test_route=2Ec test_route=2Eh test_common=2Eh \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	mock_management=2Ec \</span><br=
><span> 	$(top_srcdir)/src/openvpn/networking_sitnl=2Ec \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/route=2Ec =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src=
/openvpn/env_set=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	$(top_srcdir)/src/openvpn/run_command=2Ec \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/socket_util=2Ec \</s=
pan><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(=
top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/op=
envpn/crypto_epoch=2Ec \</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_networking=2Ec b/tests/unit_tests/openvpn/test_networking=2Ec</spa=
n><br><span>index 1c9cac1=2E=2E849f247 100644</span><br><span>--- a/tests/u=
nit_tests/openvpn/test_networking=2Ec</span><br><span>+++ b/tests/unit_test=
s/openvpn/test_networking=2Ec</span><br><span>@@ -2,6 +2,8 @@</span><br><sp=
an> #include &quot;syshead=2Eh&quot;</span><br><span> #include &quot;networ=
king=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;test_route=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> #include &lt;setjmp=2Eh&gt;<=
/span><br><span> #include &lt;cmocka=2Eh&gt;</span><br><span> </span><br><s=
pan>@@ -212,7 +214,7 @@</span><br><span> static void</span><br><span> usage=
(char *name)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    printf(&quot;Usage: %s &lt;0-8&gt;\n&quot;, name);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;Usage: %s &lt=
;0-9&gt;\n&quot;, name);</span><br><span> }</span><br><span> </span><br><sp=
an> int</span><br><span>@@ -272,6 +274,9 @@</span><br><span>             as=
sert_int_equal(net__iface_type(&quot;dummy0815&quot;, NULL), -ENODEV);</spa=
n><br><span>             return 0;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case 9:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return route_tests();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         defau=
lt:</span><br><span>             printf(&quot;invalid test: %d\n&quot;, tes=
t);</span><br><span>             break;</span><br><span>diff --git a/tests/=
unit_tests/openvpn/test_route=2Ec b/tests/unit_tests/openvpn/test_route=2Ec=
</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2Ee2=
4c696</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/=
openvpn/test_route=2Ec</span><br><span>@@ -0,0 +1,172 @@</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP net=
works</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 over a single UDP port, with support for SSL/TLS-based</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             session authentication a=
nd key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            packet encryption, packet authentication, and</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN I=
nc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Th=
is program is free software; you can redistribute it and/or modify</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of th=
e GNU General Public License version 2</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=
=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;route=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;networking=2Eh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;test_route=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Stubs for functions route=2Ec references but=
 that no test here reaches=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * They assert rather than return quietly, so a test straying ont=
o one</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * fails loudl=
y instead of silently doing nothing=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+struct argv</span><br><span style=3D"color: hsl(120, 100%, 40%);">+argv_=
new(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct argv a =3D { 0 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return a;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
argv_free(struct argv *a)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+get_ipv6_addr(const char *prefix_str, struct in6_addr *network, =
unsigned int *netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+              msglvl_t msglevel)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+in_addr_t</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+getaddr(unsigned int flags, const char *hostname, i=
nt resolve_retry, bool *succeeded,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        struct signal_info *sig_info)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(0);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+struct signal_info siginfo_=
static; /* GLOBAL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+signal_reset(struct signal_info *s=
i, int signum)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+test_is_special_addr(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(is_special_addr(&quot;net_gateway&quot;));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(is_special_addr(&quot;=
vpn_gateway&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(is_special_addr(&quot;remote_host&quot;));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_false(is_special_addr(&quot;10=2E0=2E0=2E1&=
quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
false(is_special_addr(&quot;default&quot;));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_false(is_special_addr(NULL));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+test_netmask_to_netbits(void **state)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int netbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(netma=
sk_to_netbits(0x0a000000, 0xff000000, &amp;netbits)); /* 10/8 */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netbits, =
8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(netmask_to_netbits(=
0xc0a80100, 0xffffff00, &amp;netbits)); /* 192=2E168=2E1/24 */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netbits, 24=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(netmask_to_netbits(0=
x00000000, 0x00000000, &amp;netbits)); /* default route */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netbits, 0);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* a full-length mask reports -1 rath=
er than 32 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(netmask_to_netbits(0x0a010203, 0xffffffff, &amp;netbits));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netbi=
ts, -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* host bits set in the ne=
twork part */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_false(netmask_to_netbits(0x0a000001, 0xff000000, &amp;netbits));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* not a contiguous netmask */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(netmask_to_n=
etbits(0x0a000000, 0xff00ff00, &amp;netbits));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_netmask_to_ne=
tbits2(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(netmask_to_netbits2(0xff000000), 8);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(netmask_to_netbits2(0xffffff00), =
24);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(netmask_to_netbits2(0x00000000), 0);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* unlike netmask_to_netbits(), this one reports a full-length mask=
 as 32 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(netmask_to_netbits2(0xffffffff), 32);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(netmask_to_netbits2(0xff00ff00), -1);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+assert_clear_host_bits(const char *addr, unsigned int netbits, const ch=
ar *expected)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct route_ipv6 r6=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_add=
r want;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(r6);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(inet_pton(AF_IN=
ET6, addr, &amp;r6=2Enetwork), 1);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(inet_pton(AF_INET6, expected, &amp;want=
), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r6=2Enetb=
its =3D netbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    route_ipv6_clear_h=
ost_bits(&amp;r6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_memory_equal(&amp;r6=2Enetwork, &amp;want, sizeof(struct in6_addr=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+test_route_ipv6_clear_host_bits(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* whole bytes cleared */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8=
::1&quot;, 64, &quot;2001:db8::&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8:dead:beef::1&=
quot;, 32, &quot;2001:db8::&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* a prefix that does not fall on a byte boundary */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8=
:0:00ff::1&quot;, 60, &quot;2001:db8:0:00f0::&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8=
::ffff&quot;, 121, &quot;2001:db8::ff80&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* nothing to clear, and everything to clear */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_clear_host_bits(&quot;2=
001:db8::1&quot;, 128, &quot;2001:db8::1&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8::1&q=
uot;, 0, &quot;::&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static const struct CMUnitTest =
route_test_list[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    cmocka_unit_test(test_is_special_addr),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_netmask_to_netbits),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test=
(test_netmask_to_netbits2),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    cmocka_unit_test(test_route_ipv6_clear_host_bits),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+route_tes=
ts(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return cmocka_=
run_group_tests(route_test_list, NULL, NULL);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/o=
penvpn/test_route=2Eh b/tests/unit_tests/openvpn/test_route=2Eh</span><br><=
span>new file mode 100644</span><br><span>index 0000000=2E=2Ecaa5c3c</span>=
<br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test=
_route=2Eh</span><br><span>@@ -0,0 +1,27 @@</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a singl=
e UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             session authentication and key exchan=
ge,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             p=
acket encryption, packet authentication, and</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@=
openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is=
 free software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is distributed in the hope that it wi=
ll be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  GNU General Public License for more details=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/lic=
enses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_ROUTE_H</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TEST_ROUTE_H<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Runs the route=
=2Ec unit tests, returns the number of failures */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+route_tests(void);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br></pre><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">change 1946</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9085c55a7e=
fefd31839b00ec8ec9a6f085574dde </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1946 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: chugly &lt;charlie=2Evigue=
@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: chugly &lt;charlie=2Evigue@openvpn=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>

</body></html>
--oDyKIZOayJY=--


--===============4104762708167406045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4104762708167406045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4104762708167406045==--

