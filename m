Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCABC9832F
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 06:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=33+q7hYvwlIX5QZP07CC3tHWmMLUyovSvwytapuWhQo=; b=GOW66zG7CqT3WI/UX5+UBZyPqJ
	QepgOz0k/FpaeEx9jdmBYBtocAatmAwOjdHO1qauE6rz+cs9ss6y5vjTF49UyxZOS2uhp+a6y384r
	6wX0nMXMA0sGcw1QQPWwkuE4T3dXFJ8968oCBgS0figTU7yXyfSZDfI0kIQMJQPiA30Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xB563-0001Zh-Vr;
	Mon, 28 Sep 2026 06:44:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xB55u-0001Yf-Tv
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 06:44:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QwsjgZ5LRmbwE5JeYfpNWuwV+b2/ksWekx99I7k5Wcw=; b=grRaDzEG7N3nDpR14Zgd0F7RUJ
 kTlllMNpdzdcC+0BDNwbpANq1hAjMrrc9qBs09qo6V3k/ZJcLQi5k3ANGsVA895U4s9uOIWBpdyu0
 gP9pK2gt0dmFrhTmmxiCnRjXIvk05IDS5ADXOHfxTEzYwmdZgAjzT+YJqA5Wu5luOB+8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QwsjgZ5LRmbwE5JeYfpNWuwV+b2/ksWekx99I7k5Wcw=; b=P
 jPHtgjDxuKXSlJoudp7s1fhaEWRL8nfs65VjiCbVkj+xUVJHj6EPZ4V1glPSl45FC3ThT3wodDwrv
 Z1M5DLaHSu6eJ2RbqEhzGVUyJD8U9qd5ER0A6rNPDvwS5eW3CVsoUyGIXt/fCBbrTMkwFoWTz3B4n
 +qNST8toDiJCG8DU=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xB55t-0004AN-1g for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 06:44:11 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e83a388f8so19911255e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 27 Sep 2026 23:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790577842; x=1791182642; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QwsjgZ5LRmbwE5JeYfpNWuwV+b2/ksWekx99I7k5Wcw=;
 b=H2+ODSP7388hRDh8PlzCHS2Oivv8YQuyqAHv7qsJ1jArrg5/ranuE0SOSffH0IYsLw
 SWXOdou5IVU7c3jlMsseyqlC+400zfarPqq88YA5rth7xcdVPaKy9sXr48RuuAzlpCz/
 VtJ9eI9h/Rw1bFyk5S1XzhB/6+EyUSUL9+3kfuMyu7huapvVUUqiid4ST859VOhROQlT
 Ml1wN5AaKg64SqiJRf6ea0HJ9tS8A3VC8X2MiZ/vFWXXwZi9mrMd6xETmdY0QUcJM7S4
 JBTu3bIR+XZSkyviJoVV89WD+R8gmg5mjSenC5O4FkEjWrJFfgzuKn4QZ+qyaGSk9vjx
 g+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790577842; x=1791182642;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QwsjgZ5LRmbwE5JeYfpNWuwV+b2/ksWekx99I7k5Wcw=;
 b=cV7PqXPYsoGttgcbdM41985be+EyNBpi7NkBMxUUkK5s+kKsW+tFgcbH4NUyDx+r8e
 Gx7ZMNHZmxlkDRVZqjuxWJY+t0KjhlFoe5FOkSkBCEpra+Wr/mpMNWwZooVJZVQqNgNp
 pUNFgkjqUQfJxOkyvdvuiR+w2tUdmE1IwR8TKIxlAwW26UMTVvbdlyK1tmtIsKInUMdR
 ltGe0ilcMlhdY+tp0rYCHWMGgxdRwYw2k2cTCVqWM1qXO1mxQwnip2AdbHt5z9ENeOly
 X1t/lk710YapFVPZW/P9/s+CnFe29+ZNSvgeyZVp47fDNMH4hmAhWmh0GeRZuH8SEkRU
 TEpg==
X-Gm-Message-State: AFuF++nf0AOgp9PmhrsC+hzFgIOKdOyFy2jQzvLJMybF8XtQP6EUIuqX
 IT0BiHT8X9YHXUmmOay+OYL9AlQknC/KG8OtuCAedfRK/lVd9KU4FCZxW3BVFEI2SPVDlMEqqpE
 DOjTz0zM8+kV0ofLi1Ks3BxnMB6YvV3Xw+5XYWn1Zlc4IEPbIAgd9Mb/WRh94PbgfTXWl
X-Gm-Gg: AYBFou1/xPtwJbHiP3uXQ9liZZZ+oqxVsriCAx+DG4YnCzlkADLz6S9Qza9QuhgE4PO
 rSGYRgTT7Ghs0JrSBKubTwvh8My31hCoPAITGpUPhP2cUrfhFuKm8zihFcdAQiekY0gr4Xn8xjO
 WsClpCDzLq3I478BpQBqOzDJLBelHneUVvuzY599/0sYqexLojnEo9ppHm1f8Hs/LWVuGLHmQNg
 5faF8UT90xj1AwIba7TZxOYEYRW6pcLri3Eg6qkUVPwgUQ74grUC8gbeeGs44jgSYVEBNwyc/Ji
 tXExdh6mgdaYDs3lva77CjR+CWGIGsoqxKoP3jngl07AnmQ3gKGHjzxj1A1qd1GTRUhV4BSnZP2
 iIbnv9cOWHDJ3Jxx5LUFIwFG5BrA8h/Dsjz1LHiwbR28cFLVPZGf+AF+8+KFk/ttoSB1NE0H6LE
 CPUBR1kdJT9UN+aKbW7qiLDmgiR5PkaiGl2IE2ncdOeqX53gIU/w6V6Yb9UQMb6+wybvFDC1pWD
 rv8zThQx+cKr6Xwi1pLUYI94PmrGoiSd+07S4AmYAiFOCw9mQXs+dygQz/PoFc4AcUVs8ngmBVQ
 43CkDDdaT3K7aEgCteAFksGKmhCBUSxXRKwphMlKWNHfmlGUJHBeoxkEFjGh
X-Received: by 2002:a05:600c:630f:b0:49f:bd3c:bc1f with SMTP id
 5b1f17b1804b1-49fe66fd51dmr215833705e9.26.1790577842128; 
 Sun, 27 Sep 2026 23:44:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f0e79sm189945375e9.7.2026.09.27.23.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 23:44:01 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 06:43:57 +0000
To: razvanc <razvanc@mailbox.org>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: 90dac0ff74b5023b593c7903d89f7c9210fbd403
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4512a291587e81bc7f0c0fa499f2a10661f08ff9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xB55t-0004AN-1g
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
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1787845992040672578=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1787845992040672578==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uSb7Yv1bDzM="; charset=UTF-8

--uSb7Yv1bDzM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: chugly, plaisthos, razvanc=2E

Hello =
plaisthos, razvanc, 

I'd like you to reexamine a change=2E Please visit

 =
   http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail

to look at t=
he new patch set (#3)=2E

The following approvals got outdated and were rem=
oved:
Code-Review-1 by plaisthos


Change subject: tests: add unit tests fo=
r route=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t=
ests: add unit tests for route=2Ec

route=2Ec has no unit test coverage at =
all, so there is nowhere to put a
test when touching it=2E  Cover the pure =
helpers it already exports: the
special address predicate, both netmask-to-=
netbits conversions, and the
IPv6 prefix host-bit masking=2E

The two conve=
rsions disagree on a full-length netmask, where
netmask_to_netbits() report=
s -1 and netmask_to_netbits2() reports 32=2E
That is deliberate, callers us=
e the -1 to tell a host route from a
network route, so pin it down rather t=
han leave it to be "fixed" later=2E

Rather than add a driver of its own, t=
he tests are hosted by
networking_testdriver as case 9, in the way test_mis=
c hosts
test_schedule=2E  That driver is already gated on HAVE_SITNL, which=
 is
what route=2Ec needs: it reaches the routing table through net_route_* =
on
Linux and through argv/execve elsewhere, so one set of stubs cannot
link=
 on both=2E  t_net=2Esh runs the cases above LAST_AUTO_TEST after it has
re=
moved its dummy interface, so the route tests need no interface and no
part=
icular network state=2E

route=2Ec links against the real networking_sitnl=
=2Ec that the driver
already carries=2E  Only the socket and argv helpers t=
hat route=2Ec
references but no test here reaches are stubbed, and those as=
sert rather
than return quietly, so a test straying onto one fails loudly=
=2E

Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
Signed-off-by: Ch=
arlie Vigue <charlie=2Evigue@openvpn=2Ecom>
---
M CMakeLists=2Etxt
M tests/=
t_net=2Esh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/open=
vpn/test_networking=2Ec
A tests/unit_tests/openvpn/test_route=2Ec
A tests/u=
nit_tests/openvpn/test_route=2Eh
6 files changed, 223 insertions(+), 4 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/46/1946/3

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 6eb595=
4=2E=2E88c5383 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -944=
,7 +944,6 @@
 
     if (TARGET test_cryptoapi)
         target_sources(test=
_cryptoapi PRIVATE
-            tests/unit_tests/openvpn/mock_get_random=2E=
c
             tests/unit_tests/openvpn/cert_data=2Eh
             tests/un=
it_tests/openvpn/pkey_test_utils=2Ec
             src/openvpn/xkey_provider=
=2Ec
@@ -961,7 +960,15 @@
     if (TARGET test_networking)
         target_=
link_options(test_networking PRIVATE -Wl,--wrap=3Dparse_line)
         targ=
et_compile_options(test_networking PRIVATE -UNDEBUG)
+        target_link_l=
ibraries(test_networking PUBLIC ${RESOLV_LIBRARIES})
         target_source=
s(test_networking PRIVATE
+            tests/unit_tests/openvpn/test_route=
=2Ec
+            tests/unit_tests/openvpn/mock_management=2Ec
+           =
 tests/unit_tests/openvpn/mock_win32_execve=2Ec
+            src/openvpn/ro=
ute=2Ec
+            src/openvpn/env_set=2Ec
+            src/openvpn/run_c=
ommand=2Ec
+            src/openvpn/socket_util=2Ec
             src/openvp=
n/networking_sitnl=2Ec
             src/openvpn/crypto_epoch=2Ec
          =
   src/openvpn/crypto_mbedtls=2Ec
@@ -1004,7 +1011,6 @@
             -DSOFT=
HSM2_UTIL_PATH=3D\"${SOFTHSM2_UTIL}\"
             )
         target_source=
s(test_pkcs11 PRIVATE
-            tests/unit_tests/openvpn/mock_get_random=
=2Ec
             tests/unit_tests/openvpn/pkey_test_utils=2Ec
            =
 src/openvpn/argv=2Ec
             src/openvpn/base64=2Ec
diff --git a/test=
s/t_net=2Esh b/tests/t_net=2Esh
index d63f648=2E=2Efd07277 100755
--- a/tes=
ts/t_net=2Esh
+++ b/tests/t_net=2Esh
@@ -3,7 +3,7 @@
 IFACE=3D"ovpn-dummy0"=

 UNIT_TEST=3D"=2E/unit_tests/openvpn/networking_testdriver"
 LAST_AUTO_TES=
T=3D7
-LAST_TEST=3D8
+LAST_TEST=3D9
 
 srcdir=3D"${srcdir:-=2E}"
 top_build=
dir=3D"${top_builddir:-=2E=2E}"
diff --git a/tests/unit_tests/openvpn/Makef=
ile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 5954902=2E=2Ea65331=
1 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_test=
s/openvpn/Makefile=2Eam
@@ -212,7 +212,14 @@
 networking_testdriver_LDFLAGS=
 =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn \
 	$(OPTIONAL_CRYPTO_LIBS)=

 networking_testdriver_SOURCES =3D test_networking=2Ec mock_msg=2Ec \
+	te=
st_route=2Ec test_route=2Eh test_common=2Eh \
+	mock_management=2Ec \
 	$(t=
op_srcdir)/src/openvpn/networking_sitnl=2Ec \
+	$(top_srcdir)/src/openvpn/r=
oute=2Ec \
+	$(top_srcdir)/src/openvpn/env_set=2Ec \
+	$(top_srcdir)/src/op=
envpn/run_command=2Ec \
+	$(top_srcdir)/src/openvpn/socket_util=2Ec \
+	$(t=
op_srcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=
=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn=
/crypto_epoch=2Ec \
diff --git a/tests/unit_tests/openvpn/test_networking=
=2Ec b/tests/unit_tests/openvpn/test_networking=2Ec
index 1c9cac1=2E=2E849f=
247 100644
--- a/tests/unit_tests/openvpn/test_networking=2Ec
+++ b/tests/u=
nit_tests/openvpn/test_networking=2Ec
@@ -2,6 +2,8 @@
 #include "syshead=2E=
h"
 #include "networking=2Eh"
 
+#include "test_route=2Eh"
+
 #include <set=
jmp=2Eh>
 #include <cmocka=2Eh>
 
@@ -212,7 +214,7 @@
 static void
 usage(c=
har *name)
 {
-    printf("Usage: %s <0-8>\n", name);
+    printf("Usage: %=
s <0-9>\n", name);
 }
 
 int
@@ -272,6 +274,9 @@
             assert_int_eq=
ual(net__iface_type("dummy0815", NULL), -ENODEV);
             return 0;
 
=
+        case 9:
+            return route_tests();
+
         default:
   =
          printf("invalid test: %d\n", test);
             break;
diff --gi=
t a/tests/unit_tests/openvpn/test_route=2Ec b/tests/unit_tests/openvpn/test=
_route=2Ec
new file mode 100644
index 0000000=2E=2E476cfa9
--- /dev/null
++=
+ b/tests/unit_tests/openvpn/test_route=2Ec
@@ -0,0 +1,174 @@
+/*
+ *  Open=
VPN -- An application to securely tunnel IP networks
+ *             over a=
 single UDP port, with support for SSL/TLS-based
+ *             session au=
thentication and key exchange,
+ *             packet encryption, packet au=
thentication, and
+ *             packet compression=2E
+ *
+ *  Copyright =
(C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is fr=
ee software; you can redistribute it and/or modify
+ *  it under the terms =
of the GNU General Public License version 2
+ *  as published by the Free S=
oftware Foundation=2E
+ *
+ *  This program is distributed in the hope that=
 it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied=
 warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  S=
ee the
+ *  GNU General Public License for more details=2E
+ *
+ *  You sho=
uld have received a copy of the GNU General Public License along
+ *  with =
this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#i=
fdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"=

+
+#include "test_common=2Eh"
+
+#include "route=2Eh"
+#include "networkin=
g=2Eh"
+
+#include "test_route=2Eh"
+
+/* Stubs for functions route=2Ec ref=
erences but that no test here reaches=2E
+ * They assert rather than return=
 quietly, so a test straying onto one
+ * fails loudly instead of silently =
doing nothing=2E
+ */
+struct argv
+argv_new(void)
+{
+    assert_true(0);
=
+    struct argv a =3D { 0 };
+    return a;
+}
+
+void
+argv_free(struct a=
rgv *a)
+{
+    assert_true(0);
+}
+
+bool
+get_ipv6_addr(const char *prefi=
x_str, struct in6_addr *network, unsigned int *netbits,
+              msgl=
vl_t msglevel)
+{
+    assert_true(0);
+    return false;
+}
+
+in_addr_t
+=
getaddr(unsigned int flags, const char *hostname, int resolve_retry, bool *=
succeeded,
+        struct signal_info *sig_info)
+{
+    assert_true(0);
+=
    return 0;
+}
+
+struct signal_info siginfo_static; /* GLOBAL */
+
+int
=
+signal_reset(struct signal_info *si, int signum)
+{
+    assert_true(0);
+=
    return 0;
+}
+
+static void
+test_is_special_addr(void **state)
+{
+   =
 assert_true(is_special_addr("net_gateway"));
+    assert_true(is_special_a=
ddr("vpn_gateway"));
+    assert_true(is_special_addr("remote_host"));
+
+ =
   assert_false(is_special_addr("10=2E0=2E0=2E1"));
+    assert_false(is_sp=
ecial_addr("default"));
+    assert_false(is_special_addr(NULL));
+}
+
+sta=
tic void
+test_netmask_to_netbits(void **state)
+{
+    int netbits;
+
+   =
 assert_true(netmask_to_netbits(0x0a000000, 0xff000000, &netbits)); /* 10/8=
 */
+    assert_int_equal(netbits, 8);
+
+    assert_true(netmask_to_netbit=
s(0xc0a80100, 0xffffff00, &netbits)); /* 192=2E168=2E1/24 */
+    assert_in=
t_equal(netbits, 24);
+
+    assert_true(netmask_to_netbits(0x00000000, 0x0=
0000000, &netbits)); /* default route */
+    assert_int_equal(netbits, 0);=

+
+    /* a full-length mask reports -1 rather than 32, which is what call=
ers
+     * use to tell "host route" from "network route"
+     */
+    ass=
ert_true(netmask_to_netbits(0x0a010203, 0xffffffff, &netbits));
+    assert=
_int_equal(netbits, -1);
+
+    /* host bits set in the network part */
+  =
  assert_false(netmask_to_netbits(0x0a000001, 0xff000000, &netbits));
+
+  =
  /* not a contiguous netmask */
+    assert_false(netmask_to_netbits(0x0a0=
00000, 0xff00ff00, &netbits));
+}
+
+static void
+test_netmask_to_netbits2(=
void **state)
+{
+    assert_int_equal(netmask_to_netbits2(0xff000000), 8);=

+    assert_int_equal(netmask_to_netbits2(0xffffff00), 24);
+    assert_in=
t_equal(netmask_to_netbits2(0x00000000), 0);
+
+    /* unlike netmask_to_ne=
tbits(), this one reports a full-length mask as 32 */
+    assert_int_equal=
(netmask_to_netbits2(0xffffffff), 32);
+
+    assert_int_equal(netmask_to_n=
etbits2(0xff00ff00), -1);
+}
+
+static void
+assert_clear_host_bits(const c=
har *addr, unsigned int netbits, const char *expected)
+{
+    struct route=
_ipv6 r6;
+    struct in6_addr want;
+
+    CLEAR(r6);
+    assert_int_equa=
l(inet_pton(AF_INET6, addr, &r6=2Enetwork), 1);
+    assert_int_equal(inet_=
pton(AF_INET6, expected, &want), 1);
+    r6=2Enetbits =3D netbits;
+
+    =
route_ipv6_clear_host_bits(&r6);
+    assert_memory_equal(&r6=2Enetwork, &w=
ant, sizeof(struct in6_addr));
+}
+
+static void
+test_route_ipv6_clear_hos=
t_bits(void **state)
+{
+    /* whole bytes cleared */
+    assert_clear_ho=
st_bits("2001:db8::1", 64, "2001:db8::");
+    assert_clear_host_bits("2001=
:db8:dead:beef::1", 32, "2001:db8::");
+
+    /* a prefix that does not fal=
l on a byte boundary */
+    assert_clear_host_bits("2001:db8:0:00ff::1", 6=
0, "2001:db8:0:00f0::");
+    assert_clear_host_bits("2001:db8::ffff", 121,=
 "2001:db8::ff80");
+
+    /* nothing to clear, and everything to clear */
=
+    assert_clear_host_bits("2001:db8::1", 128, "2001:db8::1");
+    assert=
_clear_host_bits("2001:db8::1", 0, "::");
+}
+
+static const struct CMUnitT=
est route_test_list[] =3D {
+    cmocka_unit_test(test_is_special_addr),
+ =
   cmocka_unit_test(test_netmask_to_netbits),
+    cmocka_unit_test(test_ne=
tmask_to_netbits2),
+    cmocka_unit_test(test_route_ipv6_clear_host_bits),=

+};
+
+int
+route_tests(void)
+{
+    openvpn_unit_test_setup();
+    retu=
rn cmocka_run_group_tests(route_test_list, NULL, NULL);
+}
diff --git a/tes=
ts/unit_tests/openvpn/test_route=2Eh b/tests/unit_tests/openvpn/test_route=
=2Eh
new file mode 100644
index 0000000=2E=2Ecaa5c3c
--- /dev/null
+++ b/te=
sts/unit_tests/openvpn/test_route=2Eh
@@ -0,0 +1,27 @@
+/*
+ *  OpenVPN -- =
An application to securely tunnel IP networks
+ *             over a single=
 UDP port, with support for SSL/TLS-based
+ *             session authentic=
ation and key exchange,
+ *             packet encryption, packet authentic=
ation, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 200=
2-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free soft=
ware; you can redistribute it and/or modify
+ *  it under the terms of the =
GNU General Public License version 2
+ *  as published by the Free Software=
 Foundation=2E
+ *
+ *  This program is distributed in the hope that it wil=
l be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warran=
ty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
=
+ *  GNU General Public License for more details=2E
+ *
+ *  You should hav=
e received a copy of the GNU General Public License along
+ *  with this pr=
ogram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+#ifndef TES=
T_ROUTE_H
+#define TEST_ROUTE_H
+/** Runs the route=2Ec unit tests, returns=
 the number of failures */
+int
+route_tests(void);
+#endif

-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f=
085574dde
Gerrit-Change-Number: 1946
Gerrit-PatchSet: 3
Gerrit-Owner: chugl=
y <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: c=
hugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Attention: razvanc <razvanc@ma=
ilbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--uSb7Yv1bDzM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: chugly, plaisthos, razvanc=2E </p>
<p>chugly <strong>=
uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">View Change</a></p><p>Th=
e following approvals got outdated and were removed:
Code-Review-1 by plais=
thos</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">tests: add unit tests for route=2Ec<br><br>route=2Ec =
has no unit test coverage at all, so there is nowhere to put a<br>test when=
 touching it=2E  Cover the pure helpers it already exports: the<br>special =
address predicate, both netmask-to-netbits conversions, and the<br>IPv6 pre=
fix host-bit masking=2E<br><br>The two conversions disagree on a full-lengt=
h netmask, where<br>netmask_to_netbits() reports -1 and netmask_to_netbits2=
() reports 32=2E<br>That is deliberate, callers use the -1 to tell a host r=
oute from a<br>network route, so pin it down rather than leave it to be &qu=
ot;fixed&quot; later=2E<br><br>Rather than add a driver of its own, the tes=
ts are hosted by<br>networking_testdriver as case 9, in the way test_misc h=
osts<br>test_schedule=2E  That driver is already gated on HAVE_SITNL, which=
 is<br>what route=2Ec needs: it reaches the routing table through net_route=
_* on<br>Linux and through argv/execve elsewhere, so one set of stubs canno=
t<br>link on both=2E  t_net=2Esh runs the cases above LAST_AUTO_TEST after =
it has<br>removed its dummy interface, so the route tests need no interface=
 and no<br>particular network state=2E<br><br>route=2Ec links against the r=
eal networking_sitnl=2Ec that the driver<br>already carries=2E  Only the so=
cket and argv helpers that route=2Ec<br>references but no test here reaches=
 are stubbed, and those assert rather<br>than return quietly, so a test str=
aying onto one fails loudly=2E<br><br>Change-Id: I9085c55a7efefd31839b00ec8=
ec9a6f085574dde<br>Signed-off-by: Charlie Vigue &lt;charlie=2Evigue@openvpn=
=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M tests/t_net=2Esh<br>M tests/un=
it_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_networkin=
g=2Ec<br>A tests/unit_tests/openvpn/test_route=2Ec<br>A tests/unit_tests/op=
envpn/test_route=2Eh<br>6 files changed, 223 insertions(+), 4 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/46/1946/3</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLis=
ts=2Etxt</span><br><span>index 6eb5954=2E=2E88c5383 100644</span><br><span>=
--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><sp=
an>@@ -944,7 +944,6 @@</span><br><span> </span><br><span>     if (TARGET te=
st_cryptoapi)</span><br><span>         target_sources(test_cryptoapi PRIVAT=
E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            tests/un=
it_tests/openvpn/mock_get_random=2Ec</span><br><span>             tests/uni=
t_tests/openvpn/cert_data=2Eh</span><br><span>             tests/unit_tests=
/openvpn/pkey_test_utils=2Ec</span><br><span>             src/openvpn/xkey_=
provider=2Ec</span><br><span>@@ -961,7 +960,15 @@</span><br><span>     if (=
TARGET test_networking)</span><br><span>         target_link_options(test_n=
etworking PRIVATE -Wl,--wrap=3Dparse_line)</span><br><span>         target_=
compile_options(test_networking PRIVATE -UNDEBUG)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        target_link_libraries(test_networking=
 PUBLIC ${RESOLV_LIBRARIES})</span><br><span>         target_sources(test_n=
etworking PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          tests/unit_tests/openvpn/test_route=2Ec</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            tests/unit_tests/openvpn/mock_man=
agement=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            src/openvpn/route=2Ec</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/env_se=
t=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sr=
c/openvpn/run_command=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            src/openvpn/socket_util=2Ec</span><br><span>             =
src/openvpn/networking_sitnl=2Ec</span><br><span>             src/openvpn/c=
rypto_epoch=2Ec</span><br><span>             src/openvpn/crypto_mbedtls=2Ec=
</span><br><span>@@ -1004,7 +1011,6 @@</span><br><span>             -DSOFTH=
SM2_UTIL_PATH=3D\&quot;${SOFTHSM2_UTIL}\&quot;</span><br><span>            =
 )</span><br><span>         target_sources(test_pkcs11 PRIVATE</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            tests/unit_tests/openv=
pn/mock_get_random=2Ec</span><br><span>             tests/unit_tests/openvp=
n/pkey_test_utils=2Ec</span><br><span>             src/openvpn/argv=2Ec</sp=
an><br><span>             src/openvpn/base64=2Ec</span><br><span>diff --git=
 a/tests/t_net=2Esh b/tests/t_net=2Esh</span><br><span>index d63f648=2E=2Ef=
d07277 100755</span><br><span>--- a/tests/t_net=2Esh</span><br><span>+++ b/=
tests/t_net=2Esh</span><br><span>@@ -3,7 +3,7 @@</span><br><span> IFACE=3D&=
quot;ovpn-dummy0&quot;</span><br><span> UNIT_TEST=3D&quot;=2E/unit_tests/op=
envpn/networking_testdriver&quot;</span><br><span> LAST_AUTO_TEST=3D7</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-LAST_TEST=3D8</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+LAST_TEST=3D9</span><br><span> </=
span><br><span> srcdir=3D&quot;${srcdir:-=2E}&quot;</span><br><span> top_bu=
ilddir=3D&quot;${top_builddir:-=2E=2E}&quot;</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=
=2Eam</span><br><span>index 5954902=2E=2Ea653311 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_=
tests/openvpn/Makefile=2Eam</span><br><span>@@ -212,7 +212,14 @@</span><br>=
<span> networking_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src=
/openvpn \</span><br><span> 	$(OPTIONAL_CRYPTO_LIBS)</span><br><span> netwo=
rking_testdriver_SOURCES =3D test_networking=2Ec mock_msg=2Ec \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	test_route=2Ec test_route=2Eh =
test_common=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	m=
ock_management=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/networking=
_sitnl=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_=
srcdir)/src/openvpn/route=2Ec \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	$(top_srcdir)/src/openvpn/env_set=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/run_command=2E=
c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/s=
rc/openvpn/socket_util=2Ec \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span> 	$(to=
p_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/open=
vpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=
=2Ec \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_networkin=
g=2Ec b/tests/unit_tests/openvpn/test_networking=2Ec</span><br><span>index =
1c9cac1=2E=2E849f247 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_networking=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_net=
working=2Ec</span><br><span>@@ -2,6 +2,8 @@</span><br><span> #include &quot=
;syshead=2Eh&quot;</span><br><span> #include &quot;networking=2Eh&quot;</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;test_route=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> #include &lt;setjmp=2Eh&gt;</span><br><span> #=
include &lt;cmocka=2Eh&gt;</span><br><span> </span><br><span>@@ -212,7 +214=
,7 @@</span><br><span> static void</span><br><span> usage(char *name)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    prin=
tf(&quot;Usage: %s &lt;0-8&gt;\n&quot;, name);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    printf(&quot;Usage: %s &lt;0-9&gt;\n&quot;, =
name);</span><br><span> }</span><br><span> </span><br><span> int</span><br>=
<span>@@ -272,6 +274,9 @@</span><br><span>             assert_int_equal(net=
__iface_type(&quot;dummy0815&quot;, NULL), -ENODEV);</span><br><span>      =
       return 0;</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        case 9:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            return route_tests();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>         default:</span><br><span=
>             printf(&quot;invalid test: %d\n&quot;, test);</span><br><span=
>             break;</span><br><span>diff --git a/tests/unit_tests/openvpn/=
test_route=2Ec b/tests/unit_tests/openvpn/test_route=2Ec</span><br><span>ne=
w file mode 100644</span><br><span>index 0000000=2E=2E476cfa9</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_route=
=2Ec</span><br><span>@@ -0,0 +1,174 @@</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP=
 port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *             session authentication and key exchange,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet=
 encryption, packet authentication, and</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *             packet compression=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openv=
pn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free=
 software; you can redistribute it and/or modify</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Publ=
ic License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  as published by the Free Software Foundation=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is distributed in the hope that it will b=
e useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WI=
THOUT ANY WARRANTY; without even the implied warranty of</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  GNU General Public License for more details=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Gene=
ral Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/license=
s/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;test_common=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;route=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;networking=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;test_route=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Stubs for functions route=2Ec references but that no test here r=
eaches=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * They as=
sert rather than return quietly, so a test straying onto one</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * fails loudly instead of silentl=
y doing nothing=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct argv</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+argv_new(void)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct argv a =3D { 0 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return a;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+argv_free(struct argv =
*a)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_ipv6_ad=
dr(const char *prefix_str, struct in6_addr *network, unsigned int *netbits,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              msglv=
l_t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+in_addr_t</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+getaddr(unsigned int flags, const char *hostname, int resolve_retry, bool=
 *succeeded,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 struct signal_info *sig_info)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+struct signal_info siginfo_static; /* GLOBAL */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+signal_reset(struct signal_info *si, int signum)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+test_is_special_addr(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(is_specia=
l_addr(&quot;net_gateway&quot;));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(is_special_addr(&quot;vpn_gateway&quot;));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(is_spe=
cial_addr(&quot;remote_host&quot;));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_false(is_special_addr(&quot;10=2E0=2E0=2E1&quot;));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_false(is_special_addr(&=
quot;default&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(is_special_addr(NULL));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+test_netmask_to_netbit=
s(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int netbits;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(netmask_to_netbits(0x0a00000=
0, 0xff000000, &amp;netbits)); /* 10/8 */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(netbits, 8);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(netmask_to_netbits(0xc0a80100, 0xffffff00,=
 &amp;netbits)); /* 192=2E168=2E1/24 */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(netbits, 24);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(netmask_to_netbits(0x00000000, 0x00000000, =
&amp;netbits)); /* default route */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(netbits, 0);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* a full-length mask reports -1 rather than 32, which is wh=
at callers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * us=
e to tell &quot;host route&quot; from &quot;network route&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(netmask_to_netbits(0x0a01=
0203, 0xffffffff, &amp;netbits));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(netbits, -1);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* host bits set in the network part */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(netmask_to_netbits(0x0a0=
00001, 0xff000000, &amp;netbits));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* not a contiguous netmask */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_false(netmask_to_netbits(0x0a000000, 0xff00ff00, &amp=
;netbits));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+test_netmask_to_netbits2(void **state)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(netmask_to_netbits2(0xff000000)=
, 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(netmask_to_netbits2(0xffffff00), 24);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(netmask_to_netbits2(0x0000000=
0), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* unlike netmask_to_netbit=
s(), this one reports a full-length mask as 32 */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(netmask_to_netbits2(0xff=
ffffff), 32);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netm=
ask_to_netbits2(0xff00ff00), -1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+assert_clear_host_bits(const ch=
ar *addr, unsigned int netbits, const char *expected)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct route_ipv6 r6;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct in6_addr want;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    CLEAR(r6);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(inet_pton(AF_INET6, addr, &amp;r6=2Enetwork), 1);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(inet_pton(AF_INET6, expected, &amp;want), 1);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    r6=2Enetbits =3D netbits;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    route_ipv6_clear_host_bits(&amp;r6);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(&amp;r6=2Ene=
twork, &amp;want, sizeof(struct in6_addr));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_route_ipv6_clear=
_host_bits(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* whole =
bytes cleared */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_clear_host_bits(&quot;2001:db8::1&quot;, 64, &quot;2001:db8::&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_clear_=
host_bits(&quot;2001:db8:dead:beef::1&quot;, 32, &quot;2001:db8::&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* a prefix that does not fall on a =
byte boundary */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_clear_host_bits(&quot;2001:db8:0:00ff::1&quot;, 60, &quot;2001:db8:=
0:00f0::&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_clear_host_bits(&quot;2001:db8::ffff&quot;, 121, &quot;2001:db8::ff=
80&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* nothing to clear, and=
 everything to clear */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_clear_host_bits(&quot;2001:db8::1&quot;, 128, &quot;2001:db8=
::1&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_clear_host_bits(&quot;2001:db8::1&quot;, 0, &quot;::&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static const struct CMUnitTest route_test_list[] =3D {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_is_spec=
ial_addr),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmock=
a_unit_test(test_netmask_to_netbits),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    cmocka_unit_test(test_netmask_to_netbits2),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_rou=
te_ipv6_clear_host_bits),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+route_tests(void)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    openvpn_unit_test_setup();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return cmocka_run_group_tests(route_test_list, NULL=
, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span>diff --git a/tests/unit_tests/openvpn/test_route=2Eh b/tests/unit_te=
sts/openvpn/test_route=2Eh</span><br><span>new file mode 100644</span><br><=
span>index 0000000=2E=2Ecaa5c3c</span><br><span>--- /dev/null</span><br><sp=
an>+++ b/tests/unit_tests/openvpn/test_route=2Eh</span><br><span>@@ -0,0 +1=
,27 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application =
to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             over a single UDP port, with support for SSL/TLS-=
based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 session authentication and key exchange,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             packet encryption, packet authenticati=
on, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyrigh=
t (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  This program is free software; you can redistribute =
it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 it under the terms of the GNU General Public License version 2</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free So=
ftware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program=
 is distributed in the hope that it will be useful,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without eve=
n the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Publi=
c License for more details=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You=
 should have received a copy of the GNU General Public License along</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifndef TEST_ROUTE_H</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define TEST_ROUTE_H</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/** Runs the route=2Ec unit tests, returns the number o=
f failures */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+route_tests(void);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946=
?usp=3Demail">change 1946</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1946?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchse=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1946 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerri=
t-Owner: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--uSb7Yv1bDzM=--


--===============1787845992040672578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1787845992040672578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1787845992040672578==--

