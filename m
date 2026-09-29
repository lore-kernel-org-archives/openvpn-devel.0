Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DD2CA5FAB
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 00:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Xv2MLCcSQfeB/VTe0AasavmMAsmk6yuCak7RF09seQ=; b=SzgloYPD/EAYfRRHXRor9FDk9a
	mmUjztVuVnI0IV9FgH+/gSXxK2BvN+h++TTPQs6ZK2haGzCIDg+js/qYBF8fKIdYGhTCvFjgn4fa0
	0rcOhBdLyXHDAGDoc7RpRY0uH6w9RoP8b12FPcuXyIfaMygEM32T1UfRhkexbjzgQURY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBLLc-0004hR-N8;
	Tue, 29 Sep 2026 00:05:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBLLb-0004hK-Nt
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 00:05:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YdeGITBQd1bGTYP3ABqTuegxGx8/33cd7Qa50avpUtw=; b=J8JwmmRrAj0VrD8FeVHPM36ZIM
 0LOIgYf4MGMd6tXET/duVtI/dxnPxS2v+wwGeiTCwcgEL2ZEbtoyv8XiGty4BQwO0Om/cHRtXvAZ1
 liPER4lKW/JcxA+8zQqmAbUfiQ5RBZRH88GbONiUlCxzYzNhkjZVupCije9hn8ut1X+Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YdeGITBQd1bGTYP3ABqTuegxGx8/33cd7Qa50avpUtw=; b=h
 bmcyYZaprUrwdHng49RZveVlL/iCZSkizptzsh/tlC2UEvfbCADKgj4kQZdF/uCVlRMkG94otjHKs
 AZl/PVJTNj5eYSbi3gt9SVzqp28MowUEpyO9QpFTDQQPDzptiGdmxlF8ipcrn8mB8ap9egI8E56Ie
 G2+xjfXcwcgCutvk=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBLLZ-0001hf-3E for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 00:05:27 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a00d8bec5aso1686875e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 17:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790640318; x=1791245118; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YdeGITBQd1bGTYP3ABqTuegxGx8/33cd7Qa50avpUtw=;
 b=Sexjq+tyEdMgBLgAi7ZfU0T9Z1fDw8vsR19Ss7ZRYFg+bO9oRBXSjiOZsZDWgoaOmd
 QC8Q8lz+YpH5f6G2f/rrAi2FxJoSem1BGbzn6myDaZGLWhWfea3Ow6Ghi95Oi6YTzE25
 Iigh8BNzncqJTDoXNmmrP3QIpdTTVNxOknhFj3ja65whDcJPjP3Ae2Awm+f7F5WPCK8i
 EKnk0Z/MyVkmpBJLv5wRAnTXDJpMZ9Mc7HEQFgNVAhcd8lTV/rujEsWmr5lWyC4Fl1iz
 gGqNG/A7gHtOG0K5zROU5zrMdTtC/qrY4xYU8I+Bu+kjcfHJwLcJj53nc2R5P8Qe25hL
 +gtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790640318; x=1791245118;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YdeGITBQd1bGTYP3ABqTuegxGx8/33cd7Qa50avpUtw=;
 b=GywPssLRuMZ6sTGAGvKzQ7W0c/2hS/U99ftV54htFFEhXShauLe6nq86NnrNpYIPBp
 BZx8mJGz1ggLNnMyaeJNeTb954Gsmgceujx2TIaIJknZ7eRm8/LLj07Pr2FNWcVMBOck
 IcYMnJE2+AnipKo64A1/dQRP4ZxaFffr10Z5658+VadarMTtaHetJjjBCxqCeg4uTEJW
 am/JKqaKwA+dXJUXoYYk7DLNSFaPQ5HPQE1PXVS+ZIKNekNtuL0anZ8nbU/Ca4wZaw7b
 0D7gfXnU6yxhhQMqFdnI2vcA9njqbMdKfys2DcYYwZd8cna64D0uibsoGpuECaM9+zjQ
 zDVg==
X-Gm-Message-State: AFuF++kKejiHHGkJXTQGG+JPifWLR1kZGo/nr0tAhhWe5S4PRGO9PRwK
 qOe372p+CL/O2b6QiXqIEFCwm4YV8QcW/h77wPPqfJcIJ9ZNbV5mhR29g88UQqJhboYDqRjfvGI
 hFlp1IAEp253qC4Fgq5lFLZoTFY8/uXxIooulKKX8NyIJgwWntagXbuIwWqZ8SdQKFYNR
X-Gm-Gg: AYBFou39skblM5jIFMcCYUAQ745gUw4oSgoNJ3dYMEIGkPZmXa7gZ9XYMVv2hJVXyK+
 UrL54cXBU891KCQpp+dx62UVF9DloRIhE0xWjM4IQTkVGZCXjM8QfkdPccQDE93CPMCexNEn7n7
 EH46Icxues9Rk9scZ7bd2O6U94SzmegHMmrhfVZuN5o11MG22QLgB/lThPW5Dg4ImkN46J0t54m
 yvKOz8S7c/zxV8cMDxgzTtreUNzdn9BZvi304B2OcJq461L6BoXvx5wRiOjsl7HTvAJM/el4oKx
 /FEeOXu0R/XwZBLBGsQMcQ/I1htil4N6aQKDyyApBkAxww6HeTStucoGs5ywSxvCkRVHdUOvK6P
 k3yQzXqlE1xuLu4uP/ALXZX0kyxSM+up/l1+aFn3A+pqQ0ygWTm4bT0mV2/BR4tOra1p8ibVIv3
 YbEZaj/9uVBjA89VHDoDl/myVdKCyn+iGWwQq2aTjMgZtTqRh2tLJb7erppw1i07FBcOy2U8g4H
 ZHIX8kb50bEWsmnmnP/gPj5lL1B4E1TbvGtj/U5IUHiCMOnnutD/s30/Nt3rzZRL9tXNc1moCYq
 ndnBhvpDgR1k3rSyha6O4JY9VnI5lTWaP8li/oJ2tdK79vc5SkozfubVyYHY6eGervyCuDPS3fS
 d/oQZnw==
X-Received: by 2002:a05:600c:c48f:b0:499:bf8c:cfd1 with SMTP id
 5b1f17b1804b1-49fe66bdfdbmr258367965e9.2.1790640317862; 
 Mon, 28 Sep 2026 17:05:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfec703sm27650225e9.6.2026.09.28.17.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 17:05:17 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 00:05:14 +0000
To: razvanc <razvanc@mailbox.org>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: f92779b63f0595e83a0ae158f2dfee5ec2653376
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9208e9e02639e160c5fea400f6b2167ee5de809a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBLLZ-0001hf-3E
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
Content-Type: multipart/mixed; boundary="===============3303586994265094530=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3303586994265094530==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="d5F5CnvV5+k="; charset=UTF-8

--d5F5CnvV5+k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: chugly, flichtenheld, plaisthos, razv=
anc=2E

Hello flichtenheld, plaisthos, razvanc, 

I'd like you to reexamine=
 a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
46?usp=3Demail

to look at the new patch set (#4)=2E

The following approva=
ls got outdated and were removed:
Code-Review-1 by flichtenheld


Change su=
bject: tests: add unit tests for route=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tests: add unit tests for route=2Ec

route=
=2Ec has no unit test coverage at all, so there is nowhere to put a
test wh=
en touching it=2E  Cover the pure helpers it already exports: the
special a=
ddress predicate, both netmask-to-netbits conversions, and the
IPv6 prefix =
host-bit masking=2E

The two conversions disagree on a full-length netmask,=
 where
netmask_to_netbits() reports -1 and netmask_to_netbits2() reports 32=
=2E
That is deliberate, callers use the -1 to tell a host route from a
netw=
ork route, so pin it down rather than leave it to be "fixed" later=2E

Rath=
er than add a driver of its own, the tests are hosted by
networking_testdri=
ver as case 9, in the way test_misc hosts
test_schedule=2E  That driver is =
already gated on HAVE_SITNL, which is
what route=2Ec needs: it reaches the =
routing table through net_route_* on
Linux and through argv/execve elsewher=
e, so one set of stubs cannot
link on both=2E  t_net=2Esh runs the cases ab=
ove LAST_AUTO_TEST after it has
removed its dummy interface, so the route t=
ests need no interface and no
particular network state=2E

route=2Ec links =
against the real networking_sitnl=2Ec that the driver
already carries=2E  O=
nly the socket and argv helpers that route=2Ec
references but no test here =
reaches are stubbed, and those assert rather
than return quietly, so a test=
 straying onto one fails loudly=2E

Change-Id: I9085c55a7efefd31839b00ec8ec=
9a6f085574dde
Signed-off-by: Charlie Vigue <charlie=2Evigue@openvpn=2Ecom>
=
---
M CMakeLists=2Etxt
M tests/t_net=2Esh
M tests/unit_tests/openvpn/Makefi=
le=2Eam
M tests/unit_tests/openvpn/test_networking=2Ec
A tests/unit_tests/o=
penvpn/test_route=2Ec
A tests/unit_tests/openvpn/test_route=2Eh
6 files cha=
nged, 223 insertions(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/46/1946/4

diff --git a/CMakeLists=2Etxt =
b/CMakeLists=2Etxt
index 6eb5954=2E=2E6fd2940 100644
--- a/CMakeLists=2Etxt=

+++ b/CMakeLists=2Etxt
@@ -961,7 +961,15 @@
     if (TARGET test_networkin=
g)
         target_link_options(test_networking PRIVATE -Wl,--wrap=3Dparse_=
line)
         target_compile_options(test_networking PRIVATE -UNDEBUG)
+  =
      target_link_libraries(test_networking PUBLIC ${RESOLV_LIBRARIES})
   =
      target_sources(test_networking PRIVATE
+            tests/unit_tests/=
openvpn/test_route=2Ec
+            tests/unit_tests/openvpn/mock_managemen=
t=2Ec
+            tests/unit_tests/openvpn/mock_win32_execve=2Ec
+        =
    src/openvpn/route=2Ec
+            src/openvpn/env_set=2Ec
+           =
 src/openvpn/run_command=2Ec
+            src/openvpn/socket_util=2Ec
     =
        src/openvpn/networking_sitnl=2Ec
             src/openvpn/crypto_ep=
och=2Ec
             src/openvpn/crypto_mbedtls=2Ec
diff --git a/tests/t_ne=
t=2Esh b/tests/t_net=2Esh
index d63f648=2E=2Efd07277 100755
--- a/tests/t_n=
et=2Esh
+++ b/tests/t_net=2Esh
@@ -3,7 +3,7 @@
 IFACE=3D"ovpn-dummy0"
 UNIT=
_TEST=3D"=2E/unit_tests/openvpn/networking_testdriver"
 LAST_AUTO_TEST=3D7
=
-LAST_TEST=3D8
+LAST_TEST=3D9
 
 srcdir=3D"${srcdir:-=2E}"
 top_builddir=3D=
"${top_builddir:-=2E=2E}"
diff --git a/tests/unit_tests/openvpn/Makefile=2E=
am b/tests/unit_tests/openvpn/Makefile=2Eam
index 5954902=2E=2Ea653311 1006=
44
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/open=
vpn/Makefile=2Eam
@@ -212,7 +212,14 @@
 networking_testdriver_LDFLAGS =3D @=
TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn \
 	$(OPTIONAL_CRYPTO_LIBS)
 netw=
orking_testdriver_SOURCES =3D test_networking=2Ec mock_msg=2Ec \
+	test_rou=
te=2Ec test_route=2Eh test_common=2Eh \
+	mock_management=2Ec \
 	$(top_src=
dir)/src/openvpn/networking_sitnl=2Ec \
+	$(top_srcdir)/src/openvpn/route=
=2Ec \
+	$(top_srcdir)/src/openvpn/env_set=2Ec \
+	$(top_srcdir)/src/openvp=
n/run_command=2Ec \
+	$(top_srcdir)/src/openvpn/socket_util=2Ec \
+	$(top_s=
rcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec =
\
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/cryp=
to_epoch=2Ec \
diff --git a/tests/unit_tests/openvpn/test_networking=2Ec b/=
tests/unit_tests/openvpn/test_networking=2Ec
index 1c9cac1=2E=2E849f247 100=
644
--- a/tests/unit_tests/openvpn/test_networking=2Ec
+++ b/tests/unit_tes=
ts/openvpn/test_networking=2Ec
@@ -2,6 +2,8 @@
 #include "syshead=2Eh"
 #in=
clude "networking=2Eh"
 
+#include "test_route=2Eh"
+
 #include <setjmp=2Eh=
>
 #include <cmocka=2Eh>
 
@@ -212,7 +214,7 @@
 static void
 usage(char *na=
me)
 {
-    printf("Usage: %s <0-8>\n", name);
+    printf("Usage: %s <0-9>=
\n", name);
 }
 
 int
@@ -272,6 +274,9 @@
             assert_int_equal(net=
__iface_type("dummy0815", NULL), -ENODEV);
             return 0;
 
+      =
  case 9:
+            return route_tests();
+
         default:
          =
   printf("invalid test: %d\n", test);
             break;
diff --git a/tes=
ts/unit_tests/openvpn/test_route=2Ec b/tests/unit_tests/openvpn/test_route=
=2Ec
new file mode 100644
index 0000000=2E=2E476cfa9
--- /dev/null
+++ b/te=
sts/unit_tests/openvpn/test_route=2Ec
@@ -0,0 +1,174 @@
+/*
+ *  OpenVPN --=
 An application to securely tunnel IP networks
+ *             over a singl=
e UDP port, with support for SSL/TLS-based
+ *             session authenti=
cation and key exchange,
+ *             packet encryption, packet authenti=
cation, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 20=
02-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free sof=
tware; you can redistribute it and/or modify
+ *  it under the terms of the=
 GNU General Public License version 2
+ *  as published by the Free Softwar=
e Foundation=2E
+ *
+ *  This program is distributed in the hope that it wi=
ll be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warra=
nty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the=

+ *  GNU General Public License for more details=2E
+ *
+ *  You should ha=
ve received a copy of the GNU General Public License along
+ *  with this p=
rogram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef H=
AVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#i=
nclude "test_common=2Eh"
+
+#include "route=2Eh"
+#include "networking=2Eh"=

+
+#include "test_route=2Eh"
+
+/* Stubs for functions route=2Ec reference=
s but that no test here reaches=2E
+ * They assert rather than return quiet=
ly, so a test straying onto one
+ * fails loudly instead of silently doing =
nothing=2E
+ */
+struct argv
+argv_new(void)
+{
+    assert_true(0);
+    s=
truct argv a =3D { 0 };
+    return a;
+}
+
+void
+argv_free(struct argv *a=
)
+{
+    assert_true(0);
+}
+
+bool
+get_ipv6_addr(const char *prefix_str,=
 struct in6_addr *network, unsigned int *netbits,
+              msglvl_t m=
sglevel)
+{
+    assert_true(0);
+    return false;
+}
+
+in_addr_t
+getadd=
r(unsigned int flags, const char *hostname, int resolve_retry, bool *succee=
ded,
+        struct signal_info *sig_info)
+{
+    assert_true(0);
+    re=
turn 0;
+}
+
+struct signal_info siginfo_static; /* GLOBAL */
+
+int
+signa=
l_reset(struct signal_info *si, int signum)
+{
+    assert_true(0);
+    re=
turn 0;
+}
+
+static void
+test_is_special_addr(void **state)
+{
+    asser=
t_true(is_special_addr("net_gateway"));
+    assert_true(is_special_addr("v=
pn_gateway"));
+    assert_true(is_special_addr("remote_host"));
+
+    ass=
ert_false(is_special_addr("10=2E0=2E0=2E1"));
+    assert_false(is_special_=
addr("default"));
+    assert_false(is_special_addr(NULL));
+}
+
+static vo=
id
+test_netmask_to_netbits(void **state)
+{
+    int netbits;
+
+    asser=
t_true(netmask_to_netbits(0x0a000000, 0xff000000, &netbits)); /* 10/8 */
+ =
   assert_int_equal(netbits, 8);
+
+    assert_true(netmask_to_netbits(0xc0=
a80100, 0xffffff00, &netbits)); /* 192=2E168=2E1/24 */
+    assert_int_equa=
l(netbits, 24);
+
+    assert_true(netmask_to_netbits(0x00000000, 0x0000000=
0, &netbits)); /* default route */
+    assert_int_equal(netbits, 0);
+
+  =
  /* a full-length mask reports -1 rather than 32, which is what callers
+ =
    * use to tell "host route" from "network route"
+     */
+    assert_tr=
ue(netmask_to_netbits(0x0a010203, 0xffffffff, &netbits));
+    assert_int_e=
qual(netbits, -1);
+
+    /* host bits set in the network part */
+    asse=
rt_false(netmask_to_netbits(0x0a000001, 0xff000000, &netbits));
+
+    /* n=
ot a contiguous netmask */
+    assert_false(netmask_to_netbits(0x0a000000,=
 0xff00ff00, &netbits));
+}
+
+static void
+test_netmask_to_netbits2(void *=
*state)
+{
+    assert_int_equal(netmask_to_netbits2(0xff000000), 8);
+    =
assert_int_equal(netmask_to_netbits2(0xffffff00), 24);
+    assert_int_equa=
l(netmask_to_netbits2(0x00000000), 0);
+
+    /* unlike netmask_to_netbits(=
), this one reports a full-length mask as 32 */
+    assert_int_equal(netma=
sk_to_netbits2(0xffffffff), 32);
+
+    assert_int_equal(netmask_to_netbits=
2(0xff00ff00), -1);
+}
+
+static void
+assert_clear_host_bits(const char *a=
ddr, unsigned int netbits, const char *expected)
+{
+    struct route_ipv6 =
r6;
+    struct in6_addr want;
+
+    CLEAR(r6);
+    assert_int_equal(inet=
_pton(AF_INET6, addr, &r6=2Enetwork), 1);
+    assert_int_equal(inet_pton(A=
F_INET6, expected, &want), 1);
+    r6=2Enetbits =3D netbits;
+
+    route_=
ipv6_clear_host_bits(&r6);
+    assert_memory_equal(&r6=2Enetwork, &want, s=
izeof(struct in6_addr));
+}
+
+static void
+test_route_ipv6_clear_host_bits=
(void **state)
+{
+    /* whole bytes cleared */
+    assert_clear_host_bit=
s("2001:db8::1", 64, "2001:db8::");
+    assert_clear_host_bits("2001:db8:d=
ead:beef::1", 32, "2001:db8::");
+
+    /* a prefix that does not fall on a=
 byte boundary */
+    assert_clear_host_bits("2001:db8:0:00ff::1", 60, "20=
01:db8:0:00f0::");
+    assert_clear_host_bits("2001:db8::ffff", 121, "2001=
:db8::ff80");
+
+    /* nothing to clear, and everything to clear */
+    a=
ssert_clear_host_bits("2001:db8::1", 128, "2001:db8::1");
+    assert_clear=
_host_bits("2001:db8::1", 0, "::");
+}
+
+static const struct CMUnitTest ro=
ute_test_list[] =3D {
+    cmocka_unit_test(test_is_special_addr),
+    cmo=
cka_unit_test(test_netmask_to_netbits),
+    cmocka_unit_test(test_netmask_=
to_netbits2),
+    cmocka_unit_test(test_route_ipv6_clear_host_bits),
+};
+=

+int
+route_tests(void)
+{
+    openvpn_unit_test_setup();
+    return cmo=
cka_run_group_tests(route_test_list, NULL, NULL);
+}
diff --git a/tests/uni=
t_tests/openvpn/test_route=2Eh b/tests/unit_tests/openvpn/test_route=2Eh
ne=
w file mode 100644
index 0000000=2E=2Ecaa5c3c
--- /dev/null
+++ b/tests/uni=
t_tests/openvpn/test_route=2Eh
@@ -0,0 +1,27 @@
+/*
+ *  OpenVPN -- An appl=
ication to securely tunnel IP networks
+ *             over a single UDP po=
rt, with support for SSL/TLS-based
+ *             session authentication a=
nd key exchange,
+ *             packet encryption, packet authentication, =
and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 =
OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; y=
ou can redistribute it and/or modify
+ *  it under the terms of the GNU Gen=
eral Public License version 2
+ *  as published by the Free Software Founda=
tion=2E
+ *
+ *  This program is distributed in the hope that it will be us=
eful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+=
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GN=
U General Public License for more details=2E
+ *
+ *  You should have recei=
ved a copy of the GNU General Public License along
+ *  with this program; =
if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+#ifndef TEST_ROUTE=
_H
+#define TEST_ROUTE_H
+/** Runs the route=2Ec unit tests, returns the nu=
mber of failures */
+int
+route_tests(void);
+#endif

-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574d=
de
Gerrit-Change-Number: 1946
Gerrit-PatchSet: 4
Gerrit-Owner: chugly <char=
lie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: chugly <charlie=2Evigue@ope=
nvpn=2Ecom>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attent=
ion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld =
<frank@lichtenheld=2Ecom>

--d5F5CnvV5+k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: chugly, flichtenheld, plaisthos, razvanc=2E </p>
<p>c=
hugly <strong>uploaded patch set #4</strong> to this change=2E</p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Rev=
iew-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">tests: add unit tests for route=2Ec<=
br><br>route=2Ec has no unit test coverage at all, so there is nowhere to p=
ut a<br>test when touching it=2E  Cover the pure helpers it already exports=
: the<br>special address predicate, both netmask-to-netbits conversions, an=
d the<br>IPv6 prefix host-bit masking=2E<br><br>The two conversions disagre=
e on a full-length netmask, where<br>netmask_to_netbits() reports -1 and ne=
tmask_to_netbits2() reports 32=2E<br>That is deliberate, callers use the -1=
 to tell a host route from a<br>network route, so pin it down rather than l=
eave it to be &quot;fixed&quot; later=2E<br><br>Rather than add a driver of=
 its own, the tests are hosted by<br>networking_testdriver as case 9, in th=
e way test_misc hosts<br>test_schedule=2E  That driver is already gated on =
HAVE_SITNL, which is<br>what route=2Ec needs: it reaches the routing table =
through net_route_* on<br>Linux and through argv/execve elsewhere, so one s=
et of stubs cannot<br>link on both=2E  t_net=2Esh runs the cases above LAST=
_AUTO_TEST after it has<br>removed its dummy interface, so the route tests =
need no interface and no<br>particular network state=2E<br><br>route=2Ec li=
nks against the real networking_sitnl=2Ec that the driver<br>already carrie=
s=2E  Only the socket and argv helpers that route=2Ec<br>references but no =
test here reaches are stubbed, and those assert rather<br>than return quiet=
ly, so a test straying onto one fails loudly=2E<br><br>Change-Id: I9085c55a=
7efefd31839b00ec8ec9a6f085574dde<br>Signed-off-by: Charlie Vigue &lt;charli=
e=2Evigue@openvpn=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M tests/t_net=
=2Esh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/ope=
nvpn/test_networking=2Ec<br>A tests/unit_tests/openvpn/test_route=2Ec<br>A =
tests/unit_tests/openvpn/test_route=2Eh<br>6 files changed, 223 insertions(=
+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/46/1946/4</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLis=
ts=2Etxt b/CMakeLists=2Etxt</span><br><span>index 6eb5954=2E=2E6fd2940 1006=
44</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -961,7 +961,15 @@</span><br><span>     if (TARGET=
 test_networking)</span><br><span>         target_link_options(test_network=
ing PRIVATE -Wl,--wrap=3Dparse_line)</span><br><span>         target_compil=
e_options(test_networking PRIVATE -UNDEBUG)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        target_link_libraries(test_networking PUBLI=
C ${RESOLV_LIBRARIES})</span><br><span>         target_sources(test_network=
ing PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    tests/unit_tests/openvpn/test_route=2Ec</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            tests/unit_tests/openvpn/mock_managemen=
t=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            te=
sts/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            src/openvpn/route=2Ec</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/env_set=2Ec<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            src/open=
vpn/run_command=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            src/openvpn/socket_util=2Ec</span><br><span>             src/op=
envpn/networking_sitnl=2Ec</span><br><span>             src/openvpn/crypto_=
epoch=2Ec</span><br><span>             src/openvpn/crypto_mbedtls=2Ec</span=
><br><span>diff --git a/tests/t_net=2Esh b/tests/t_net=2Esh</span><br><span=
>index d63f648=2E=2Efd07277 100755</span><br><span>--- a/tests/t_net=2Esh</=
span><br><span>+++ b/tests/t_net=2Esh</span><br><span>@@ -3,7 +3,7 @@</span=
><br><span> IFACE=3D&quot;ovpn-dummy0&quot;</span><br><span> UNIT_TEST=3D&q=
uot;=2E/unit_tests/openvpn/networking_testdriver&quot;</span><br><span> LAS=
T_AUTO_TEST=3D7</span><br><span style=3D"color: hsl(0, 100%, 40%);">-LAST_T=
EST=3D8</span><br><span style=3D"color: hsl(120, 100%, 40%);">+LAST_TEST=3D=
9</span><br><span> </span><br><span> srcdir=3D&quot;${srcdir:-=2E}&quot;</s=
pan><br><span> top_builddir=3D&quot;${top_builddir:-=2E=2E}&quot;</span><br=
><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tes=
ts/openvpn/Makefile=2Eam</span><br><span>index 5954902=2E=2Ea653311 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><spa=
n>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -212,7 +2=
12,14 @@</span><br><span> networking_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ =
-L$(top_srcdir)/src/openvpn \</span><br><span> 	$(OPTIONAL_CRYPTO_LIBS)</sp=
an><br><span> networking_testdriver_SOURCES =3D test_networking=2Ec mock_ms=
g=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	test_route=
=2Ec test_route=2Eh test_common=2Eh \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	mock_management=2Ec \</span><br><span> 	$(top_srcdir)/sr=
c/openvpn/networking_sitnl=2Ec \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	$(top_srcdir)/src/openvpn/route=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/env_set=2Ec \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/o=
penvpn/run_command=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	$(top_srcdir)/src/openvpn/socket_util=2Ec \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/win32-util=2Ec \</=
span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$=
(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/o=
penvpn/crypto_epoch=2Ec \</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/test_networking=2Ec b/tests/unit_tests/openvpn/test_networking=2Ec</sp=
an><br><span>index 1c9cac1=2E=2E849f247 100644</span><br><span>--- a/tests/=
unit_tests/openvpn/test_networking=2Ec</span><br><span>+++ b/tests/unit_tes=
ts/openvpn/test_networking=2Ec</span><br><span>@@ -2,6 +2,8 @@</span><br><s=
pan> #include &quot;syshead=2Eh&quot;</span><br><span> #include &quot;netwo=
rking=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;test_route=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> #include &lt;setjmp=2Eh&gt;=
</span><br><span> #include &lt;cmocka=2Eh&gt;</span><br><span> </span><br><=
span>@@ -212,7 +214,7 @@</span><br><span> static void</span><br><span> usag=
e(char *name)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    printf(&quot;Usage: %s &lt;0-8&gt;\n&quot;, name);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    printf(&quot;Usage: %s &l=
t;0-9&gt;\n&quot;, name);</span><br><span> }</span><br><span> </span><br><s=
pan> int</span><br><span>@@ -272,6 +274,9 @@</span><br><span>             a=
ssert_int_equal(net__iface_type(&quot;dummy0815&quot;, NULL), -ENODEV);</sp=
an><br><span>             return 0;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case 9:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return route_tests();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         defau=
lt:</span><br><span>             printf(&quot;invalid test: %d\n&quot;, tes=
t);</span><br><span>             break;</span><br><span>diff --git a/tests/=
unit_tests/openvpn/test_route=2Ec b/tests/unit_tests/openvpn/test_route=2Ec=
</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E47=
6cfa9</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/=
openvpn/test_route=2Ec</span><br><span>@@ -0,0 +1,174 @@</span><br><span st=
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
er than 32, which is what callers</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * use to tell &quot;host route&quot; from &quot;network =
route&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(netm=
ask_to_netbits(0x0a010203, 0xffffffff, &amp;netbits));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netbits, -1);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* host bits set in the network part */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(net=
mask_to_netbits(0x0a000001, 0xff000000, &amp;netbits));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* not a contiguous netmask */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(netmask_to_netbits(0x0a0=
00000, 0xff00ff00, &amp;netbits));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_netmask_to_netbits2(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netmask_=
to_netbits2(0xff000000), 8);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(netmask_to_netbits2(0xffffff00), 24);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netmas=
k_to_netbits2(0x00000000), 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* u=
nlike netmask_to_netbits(), this one reports a full-length mask as 32 */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(n=
etmask_to_netbits2(0xffffffff), 32);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(netmask_to_netbits2(0xff00ff00), -1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+assert_c=
lear_host_bits(const char *addr, unsigned int netbits, const char *expected=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct route_ipv6 r6;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr want;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CLEAR(r6);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(inet_pton(AF_INET6, addr,=
 &amp;r6=2Enetwork), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(inet_pton(AF_INET6, expected, &amp;want), 1);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    r6=2Enetbits =3D ne=
tbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    route_ipv6_clear_host_bits(&=
amp;r6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
memory_equal(&amp;r6=2Enetwork, &amp;want, sizeof(struct in6_addr));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+test_route_ipv6_clear_host_bits(void **state)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* whole bytes cleared */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8::1&quot;, 6=
4, &quot;2001:db8::&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_clear_host_bits(&quot;2001:db8:dead:beef::1&quot;, 32, &=
quot;2001:db8::&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a prefix=
 that does not fall on a byte boundary */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8:0:00ff::1&q=
uot;, 60, &quot;2001:db8:0:00f0::&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8::ffff&quot;=
, 121, &quot;2001:db8::ff80&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* nothing to clear, and everything to clear */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8::1&q=
uot;, 128, &quot;2001:db8::1&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8::1&quot;, 0, &qu=
ot;::&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static const struct CMUnitTest route_test=
_list[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cm=
ocka_unit_test(test_is_special_addr),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    cmocka_unit_test(test_netmask_to_netbits),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_netm=
ask_to_netbits2),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  cmocka_unit_test(test_route_ipv6_clear_host_bits),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+route_tests(void)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_group=
_tests(route_test_list, NULL, NULL);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/te=
st_route=2Eh b/tests/unit_tests/openvpn/test_route=2Eh</span><br><span>new =
file mode 100644</span><br><span>index 0000000=2E=2Ecaa5c3c</span><br><span=
>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_route=2E=
h</span><br><span>@@ -0,0 +1,27 @@</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  OpenVPN -- An application to securely tunnel IP networks</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP por=
t, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             session authentication and key exchange,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet enc=
ryption, packet authentication, and</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free s=
oftware; you can redistribute it and/or modify</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public=
 License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  as published by the Free Software Foundation=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is distributed in the hope that it will be u=
seful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  GNU General Public License for more details=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&=
gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_ROUTE_H</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define TEST_ROUTE_H</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/** Runs the route=2Ec unit=
 tests, returns the number of failures */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+route_tests(void);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1946?usp=3Demail">change 1946</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I9085c55a7efefd31839b00=
ec8ec9a6f085574dde </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1946 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: chugly &lt;charlie=2Evigue@openvpn=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: fli=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--d5F5CnvV5+k=--


--===============3303586994265094530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3303586994265094530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3303586994265094530==--

