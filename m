Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8F3C9831E
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=csIaItgiS3OKumqXt7g0w9CcW6a6jD7Z4PXzT4c1SIU=; b=Gw1rNIIkIUXHF4vJ1Drc2GnuVO
	Njq3tu8fpMzruygUXuclOs5guJ6hnKj0J2xodFHmfuaOOO/3r4qJdB3R9r+b6oT2+WWNoiLWDpSbt
	ro7237PeQWnwWeYt4LGywEa7RMt7DZF1NIzXHHY7uSz7EuKZvIiZOtGMEdl0ztP0Enjo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9vrT-0007ru-WA;
	Fri, 25 Sep 2026 02:40:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9vrS-0007rh-QW
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 02:40:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TP4Vat6LDaJnNN6CdAcKv+7PpZuoCYlimOdzB1Vv/g4=; b=mjQvY11nnAzr+mWPOELuXq+FEF
 3lAibMUDOOMzCoMjY4PqcRb3qVpEERn/WRN9yZjpbvdu7ANqBNfxcpKNHKMREqy78tNMqjjo0chYO
 4XWN1BA3Ns/8tNUvfz87mAr/nqezp5lfLf1fMN5E9SdwKnfDo9ogmYulb+UwFTzLcvfc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TP4Vat6LDaJnNN6CdAcKv+7PpZuoCYlimOdzB1Vv/g4=; b=P
 o9c87v+A11nQFFLNYvogRWDfHQvhGhftsvARloy4Kjx/8FUMHqFCrKVB/eO910qeVFDrW2IZuY8te
 5QYnKAKvltqTiWZ9AgmDpVZ1kt7EChW1VdyS5uQ8umCWd9BbOpkAtkcVV6yhjgpuECj8lr5C4d5zV
 uwdqAkWxjSwGzl6g=;
Received: from mail-wr2-f21.google.com ([74.125.225.85])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9vrR-0001C2-H6 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 02:40:31 +0000
Received: by mail-wr2-f21.google.com with SMTP id
 ffacd0b85a97d-482f633cd80so198415f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 19:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790304023; x=1790908823; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TP4Vat6LDaJnNN6CdAcKv+7PpZuoCYlimOdzB1Vv/g4=;
 b=XcvOpd9yCEcwyv7ovr7v5vE79oiyLBbmMOCjxv7jxy2kGFxsaC92/1MOZ9mUezw0af
 27t3nb5YjqOc9TVREkqbIG/2UDRDA24zjwL7N00P7ok3nvA0/dCW90DTFEMLtH4ZBzQw
 4IEVUHi8NsQpNAgr2o64SeCrV3vVABPacsEGPoL7Je+NXtTHm5jSLVwaCJ8JQIL1oJOE
 BjY3sbYdLsPohyqJncdtqFW3b14e0XMWMJhWI02KIgCMwkZoLS0jwn+L1yGlInjQ5S28
 TU793Ns21hEX9Hm4BAx2GppjDbjvFsC4vWLpmNuwBhbgnjUhU3HnG7UnUNfiQOeFDq+o
 XVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790304023; x=1790908823;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TP4Vat6LDaJnNN6CdAcKv+7PpZuoCYlimOdzB1Vv/g4=;
 b=AFDcmxr4Vw/WwJ4qWNm0AMeRKSXhhE4/pQ0YaKV+1GMvoYp1vxSb/RUCb5mVHCYber
 Irf9iVt61+U4rLuUIBabl+ai4mY3egcIY8tLN6sg2qRJAdbYK8pNX9CwwzOnlS0HHtSv
 UTMwn7Fk6xOeYhd7Yb3LIfWG+Frpgr2fabSzYdJLOwg3JIt0vxbbQi16rA02oOQQ+sog
 b+4cJCzOz1C8Bq8ybCoS0ELu1jJhYXnB5EItAO1QVUCCyI4isO1SUzid9RWu+/gLGA/Z
 kmOb2vr9/IY5CKlwYar/Wj5Y6vQ+nwn1NOKJsWP1FQKe/05zWOB5irtHNMLm2ZuCgHPX
 irjQ==
X-Gm-Message-State: AFuF++kj1E6r2dp5+UVkUI7mAFUF0JTwTwJgGD2DI3vVKzsvL3BeXD5a
 BTXTYsiYY8Y/hTiCpwi88HWaFKR7JZC+7u/pmaZWIHPneYboDCZ/FkZYoXaTidrbReLXaL4dEW5
 gLgf/vpyaVXCP5Qb7Ug3nsWEu0oSTTeaiJn/dyq0vcauqHoMZEG7dozzfBqwIFMo2z10NfTY7Y0
 VdnePYAg==
X-Gm-Gg: AYBFou34LI/DrGM6H2VfIL6GMOMH1e5JLbqlwHWEuRUAcG08ZmoOGf5MoIgzbzRlMh3
 sNyjitd4C7kA7WDewrxLNNeMsI6I8rKPzeEgcGVWlXlsVGxts+ARQsFdXVke1uX/E/zP4I5gyLq
 /6GlorJe6BvbgLTKryREVNSwdahqGY6LvDllMIM6BKdXmiKd8+wGbI6ICeDsc2aTv9q/ecGRpCy
 1NHRIm0/byzxxeynFPzRB14AYeAmAdC7EqiWtW+NDZR4x4WE32agyh34y9XHlCi1xahvYHJUOAd
 9S1ctsOAe3VZ4JhF1bnXcapWMFlhSba1DZ9Y4oJwL3bHmeaTvRuA+fYpdACS5MbdU68ZMs/zdku
 1w8K4g89mS2++PXOep8qwbLeMZ3k5Goqebr42HaxvrsVe2/QvpclSYACbTS+lkPBPbQVCP7QJXC
 5hiEJ7MQHiHoMNo3rSWZ/HVMGrKBoxhMUdyw/SO8fWmJg1QtPSkvBEvDDKsf986rf03pS3iHuYz
 CF649EyMcS721btAQdGXtZ0wU8tlG4stTp/b8fD2jl0pd6ZALTVh6BfK4k8YWmtrdDfwBADcJ6y
 jYYO/z4DvKWpPL1bkaSeLhI7BY+ariL4hq84l/PcNNnw3kOb4yxgs4KIdFLkNA9RXcgdOqM=
X-Received: by 2002:a05:6000:2489:b0:488:800b:11f3 with SMTP id
 ffacd0b85a97d-488800b1336mr244511f8f.49.1790304022747; 
 Thu, 24 Sep 2026 19:40:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a6456f8sm3231315f8f.26.2026.09.24.19.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 19:40:21 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 02:40:20 +0000
To: razvanc <razvanc@mailbox.org>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: b5a04e7484242f1d3ac861ce929773c19fd58732
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <593ebba2c743e92d64f27ca92148dc13636891f7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9vrR-0001C2-H6
Subject: [Openvpn-devel] [L] Change in openvpn[master]: tests: add a unit
 test driver for route.c
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
Content-Type: multipart/mixed; boundary="===============0879570393786918339=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0879570393786918339==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zio2G6lAkDM="; charset=UTF-8

--zio2G6lAkDM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: chugly, plaisthos, razvanc=2E

Hello =
plaisthos, razvanc, 

I'd like you to reexamine a change=2E Please visit

 =
   http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail

to look at t=
he new patch set (#2)=2E

The following approvals got outdated and were rem=
oved:
Code-Review-1 by razvanc


Change subject: tests: add a unit test dri=
ver for route=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

tests: add a unit test driver for route=2Ec

route=2Ec has no unit tes=
t coverage at all, so there is nowhere to put a
test when touching it=2E  A=
dd a driver and cover the pure helpers it
already exports: the special addr=
ess predicate, both netmask-to-netbits
conversions, and the IPv6 prefix hos=
t-bit masking=2E

The two conversions disagree on a full-length netmask, wh=
ere
netmask_to_netbits() reports -1 and netmask_to_netbits2() reports 32=2E=

That is deliberate, callers use the -1 to tell a host route from a
network=
 route, so pin it down rather than leave it to be "fixed" later=2E

The pla=
tform routing calls and the handful of socket helpers route=2Ec
references =
are stubbed in the test itself rather than linked in=2E  That
keeps the dep=
endency list short, and it makes certain a test can never
reach the real ro=
uting table=2E

route=2Ec reaches the routing table through a different API=
 on each
platform, so the stubs here only match the Linux one=2E Build the =
driver on
Linux only, the same way test_networking already is=2E

Change-Id=
: I9085c55a7efefd31839b00ec8ec9a6f085574dde
Signed-off-by: Charlie Vigue <c=
harlie=2Evigue@openvpn=2Ecom>
---
M CMakeLists=2Etxt
M tests/unit_tests/ope=
nvpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_route=2Ec
3 files change=
d, 261 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/46/1946/2

diff --git a/CMakeLists=2Etxt b/C=
MakeLists=2Etxt
index 6eb5954=2E=2E9225ab1 100644
--- a/CMakeLists=2Etxt
++=
+ b/CMakeLists=2Etxt
@@ -711,6 +711,7 @@
     if (${CMAKE_SYSTEM_NAME} STRE=
QUAL "Linux")
         list(APPEND unit_tests
             "test_networking=
"
+            "test_route"
             )
     endif ()
 
@@ -908,6 +909,2=
0 @@
         src/openvpn/base64=2Ec
         )
 
+    if (TARGET test_rout=
e)
+        target_link_libraries(test_route PUBLIC ${RESOLV_LIBRARIES})
+ =
       target_sources(test_route PRIVATE
+            tests/unit_tests/open=
vpn/mock_get_random=2Ec
+            tests/unit_tests/openvpn/mock_manageme=
nt=2Ec
+            tests/unit_tests/openvpn/mock_win32_execve=2Ec
+       =
     src/openvpn/env_set=2Ec
+            src/openvpn/otime=2Ec
+          =
  src/openvpn/route=2Ec
+            src/openvpn/run_command=2Ec
+         =
   src/openvpn/socket_util=2Ec
+            )
+    endif ()
+
     target_l=
ink_libraries(test_socket PUBLIC ${RESOLV_LIBRARIES})
     target_sources(t=
est_socket PRIVATE
         tests/unit_tests/openvpn/mock_get_random=2Ec
di=
ff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvp=
n/Makefile=2Eam
index 5954902=2E=2E87612e5 100644
--- a/tests/unit_tests/op=
envpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -29,6 +=
29,12 @@
 endif
 endif
 
+# route=2Ec reaches the system routing table thro=
ugh a different API on each
+# platform, and this driver stubs out the Linu=
x one=2E Build it there only=2E
+if HAVE_SITNL
+test_binaries +=3D route_te=
stdriver
+endif
+
 if WIN32
 test_binaries +=3D cryptoapi_testdriver
 LDADD=
 =3D -lws2_32
@@ -424,3 +430,18 @@
 	$(top_srcdir)/src/openvpn/env_set=2Ec =
\
 	$(top_srcdir)/src/openvpn/run_command=2Ec \
 	$(top_srcdir)/src/openvpn=
/socket_util=2Ec
+
+route_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvp=
n -I$(top_srcdir)/src/compat @TEST_CFLAGS@
+route_testdriver_LDFLAGS =3D @T=
EST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
+route_testdriver_SOURCES =3D test=
_route=2Ec \
+	mock_msg=2Ec test_common=2Eh \
+	mock_get_random=2Ec \
+	moc=
k_management=2Ec \
+	$(top_srcdir)/src/openvpn/route=2Ec \
+	$(top_srcdir)/=
src/openvpn/buffer=2Ec \
+	$(top_srcdir)/src/openvpn/env_set=2Ec \
+	$(top_=
srcdir)/src/openvpn/otime=2Ec \
+	$(top_srcdir)/src/openvpn/platform=2Ec \
=
+	$(top_srcdir)/src/openvpn/run_command=2Ec \
+	$(top_srcdir)/src/openvpn/s=
ocket_util=2Ec \
+	$(top_srcdir)/src/openvpn/win32-util=2Ec
diff --git a/te=
sts/unit_tests/openvpn/test_route=2Ec b/tests/unit_tests/openvpn/test_route=
=2Ec
new file mode 100644
index 0000000=2E=2Edb039c1
--- /dev/null
+++ b/te=
sts/unit_tests/openvpn/test_route=2Ec
@@ -0,0 +1,225 @@
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
+/* Stubs for functions route=2Ec references but that no test here reach=
es=2E
+ * They assert rather than return quietly, so a test straying onto o=
ne
+ * fails loudly instead of silently doing nothing=2E
+ */
+struct argv
=
+argv_new(void)
+{
+    assert_true(0);
+    struct argv a =3D { 0 };
+    =
return a;
+}
+
+void
+argv_free(struct argv *a)
+{
+    assert_true(0);
+}
=
+
+bool
+get_ipv6_addr(const char *prefix_str, struct in6_addr *network, un=
signed int *netbits,
+              msglvl_t msglevel)
+{
+    assert_true(=
0);
+    return false;
+}
+
+in_addr_t
+getaddr(unsigned int flags, const c=
har *hostname, int resolve_retry, bool *succeeded,
+        struct signal_i=
nfo *sig_info)
+{
+    assert_true(0);
+    return 0;
+}
+
+/* The routing =
table is never touched by these tests; stub the platform
+ * layer out so t=
hat a mistake cannot reach the system routing table=2E
+ */
+int
+net_route=
_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const =
in_addr_t *gw,
+                 const openvpn_net_iface_t *iface, uint32_t=
 table, int metric)
+{
+    assert_true(0);
+    return -1;
+}
+
+int
+net_=
route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefix=
len,
+                 const struct in6_addr *gw, const openvpn_net_iface_t=
 *iface, uint32_t table,
+                 int metric)
+{
+    assert_true(=
0);
+    return -1;
+}
+
+int
+net_route_v4_del(openvpn_net_ctx_t *ctx, con=
st in_addr_t *dst, int prefixlen, const in_addr_t *gw,
+                 co=
nst openvpn_net_iface_t *iface, uint32_t table, int metric)
+{
+    assert_=
true(0);
+    return -1;
+}
+
+int
+net_route_v6_del(openvpn_net_ctx_t *ctx=
, const struct in6_addr *dst, int prefixlen,
+                 const struct=
 in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table,
+         =
        int metric)
+{
+    assert_true(0);
+    return -1;
+}
+
+int
+net_=
route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst, in_addr_t *b=
est_gw,
+                     openvpn_net_iface_t *best_iface)
+{
+    asse=
rt_true(0);
+    return -1;
+}
+
+int
+net_route_v6_best_gw(openvpn_net_ctx=
_t *ctx, const struct in6_addr *dst, struct in6_addr *best_gw,
+           =
          openvpn_net_iface_t *best_iface)
+{
+    assert_true(0);
+    ret=
urn -1;
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
+const struct CMUnitTest route_tes=
ts[] =3D {
+    cmocka_unit_test(test_is_special_addr),
+    cmocka_unit_te=
st(test_netmask_to_netbits),
+    cmocka_unit_test(test_netmask_to_netbits2=
),
+    cmocka_unit_test(test_route_ipv6_clear_host_bits),
+};
+
+int
+main=
(void)
+{
+    openvpn_unit_test_setup();
+    return cmocka_run_group_test=
s(route_tests, NULL, NULL);
+}

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1946?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
Gerrit-Change-Numb=
er: 1946
Gerrit-PatchSet: 2
Gerrit-Owner: chugly <charlie=2Evigue@openvpn=
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

--zio2G6lAkDM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: chugly, plaisthos, razvanc=2E </p>
<p>chugly <strong>=
uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">View Change</a></p><p>Th=
e following approvals got outdated and were removed:
Code-Review-1 by razva=
nc</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">tests: add a unit test driver for route=2Ec<br><br>rout=
e=2Ec has no unit test coverage at all, so there is nowhere to put a<br>tes=
t when touching it=2E  Add a driver and cover the pure helpers it<br>alread=
y exports: the special address predicate, both netmask-to-netbits<br>conver=
sions, and the IPv6 prefix host-bit masking=2E<br><br>The two conversions d=
isagree on a full-length netmask, where<br>netmask_to_netbits() reports -1 =
and netmask_to_netbits2() reports 32=2E<br>That is deliberate, callers use =
the -1 to tell a host route from a<br>network route, so pin it down rather =
than leave it to be &quot;fixed&quot; later=2E<br><br>The platform routing =
calls and the handful of socket helpers route=2Ec<br>references are stubbed=
 in the test itself rather than linked in=2E  That<br>keeps the dependency =
list short, and it makes certain a test can never<br>reach the real routing=
 table=2E<br><br>route=2Ec reaches the routing table through a different AP=
I on each<br>platform, so the stubs here only match the Linux one=2E Build =
the driver on<br>Linux only, the same way test_networking already is=2E<br>=
<br>Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde<br>Signed-off-by: =
Charlie Vigue &lt;charlie=2Evigue@openvpn=2Ecom&gt;<br>---<br>M CMakeLists=
=2Etxt<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/unit_tests/op=
envpn/test_route=2Ec<br>3 files changed, 261 insertions(+), 0 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/46/1946/2</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLis=
ts=2Etxt</span><br><span>index 6eb5954=2E=2E9225ab1 100644</span><br><span>=
--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><sp=
an>@@ -711,6 +711,7 @@</span><br><span>     if (${CMAKE_SYSTEM_NAME} STREQU=
AL &quot;Linux&quot;)</span><br><span>         list(APPEND unit_tests</span=
><br><span>             &quot;test_networking&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;test_route&quot;</span>=
<br><span>             )</span><br><span>     endif ()</span><br><span> </s=
pan><br><span>@@ -908,6 +909,20 @@</span><br><span>         src/openvpn/bas=
e64=2Ec</span><br><span>         )</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (TARGET test_route)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        target_link_libraries(test=
_route PUBLIC ${RESOLV_LIBRARIES})</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        target_sources(test_route PRIVATE</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            tests/unit_tests/openvpn/m=
ock_get_random=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           tests/unit_tests/openvpn/mock_management=2Ec</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            tests/unit_tests/openvpn/mo=
ck_win32_execve=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            src/openvpn/env_set=2Ec</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            src/openvpn/otime=2Ec</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            src/openvpn/route=2Ec</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/run_com=
mand=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 src/openvpn/socket_util=2Ec</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            )</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>     target_link_libraries(test_socket PUBLIC ${RESOLV_LIBRARI=
ES})</span><br><span>     target_sources(test_socket PRIVATE</span><br><spa=
n>         tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><span>dif=
f --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn=
/Makefile=2Eam</span><br><span>index 5954902=2E=2E87612e5 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/te=
sts/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -29,6 +29,12 @@</sp=
an><br><span> endif</span><br><span> endif</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# route=2Ec reaches the system rou=
ting table through a different API on each</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# platform, and this driver stubs out the Linux one=
=2E Build it there only=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+if HAVE_SITNL</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+test_binaries +=3D route_testdriver</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> if WIN32</span><br><span> test_binaries +=3D cryptoapi=
_testdriver</span><br><span> LDADD =3D -lws2_32</span><br><span>@@ -424,3 +=
430,18 @@</span><br><span> 	$(top_srcdir)/src/openvpn/env_set=2Ec \</span><=
br><span> 	$(top_srcdir)/src/openvpn/run_command=2Ec \</span><br><span> 	$(=
top_srcdir)/src/openvpn/socket_util=2Ec</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+route_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/s=
rc/compat @TEST_CFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+route_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+route_testdriver_SO=
URCES =3D test_route=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	mock_msg=2Ec test_common=2Eh \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	mock_get_random=2Ec \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	mock_management=2Ec \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/route=2Ec \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buff=
er=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcd=
ir)/src/openvpn/env_set=2Ec \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform=2Ec \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openv=
pn/run_command=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	$(top_srcdir)/src/openvpn/socket_util=2Ec \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/win32-util=2Ec</span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_route=2Ec b/tests/unit_=
tests/openvpn/test_route=2Ec</span><br><span>new file mode 100644</span><br=
><span>index 0000000=2E=2Edb039c1</span><br><span>--- /dev/null</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_route=2Ec</span><br><span>@@ -0,0 =
+1,225 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applicati=
on to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             over a single UDP port, with support for SSL/T=
LS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    session authentication and key exchange,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             packet encryption, packet authentic=
ation, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyr=
ight (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  This program is free software; you can redistribu=
te it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  it under the terms of the GNU General Public License version 2</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free=
 Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This prog=
ram is distributed in the hope that it will be useful,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without ev=
en the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Publ=
ic License for more details=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Yo=
u should have received a copy of the GNU General Public License along</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if=
 not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sysh=
ead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_commo=
n=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;route=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;n=
etworking=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Stubs for functi=
ons route=2Ec references but that no test here reaches=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * They assert rather than return qui=
etly, so a test straying onto one</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * fails loudly instead of silently doing nothing=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+struct argv</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+argv_new(void)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct argv a =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return a;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+argv_free(struct argv *a)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(0);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+get_ipv6_addr(const char *prefix_str=
, struct in6_addr *network, unsigned int *netbits,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+              msglvl_t msglevel)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in_addr_t</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+getaddr(unsigned int fl=
ags, const char *hostname, int resolve_retry, bool *succeeded,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct signal_info *sig_=
info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* The routing table is never touched by these tests; stub the platform</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * layer out so that a =
mistake cannot reach the system routing table=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net=
_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, =
const in_addr_t *gw,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                 const openvpn_net_iface_t *iface, uint32_t table, int met=
ric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return -1;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_route_v6_add=
(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                 const stru=
ct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                 int metric)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return -1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_route_v4_del(op=
envpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t =
*gw,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
  const openvpn_net_iface_t *iface, uint32_t table, int metric)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return -1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+net_route_v6_del(openvpn_net_ctx=
_t *ctx, const struct in6_addr *dst, int prefixlen,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 const struct in6_addr *g=
w, const openvpn_net_iface_t *iface, uint32_t table,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 int metric)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return -1;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+net_route_v4_best_gw(openvpn_net_=
ctx_t *ctx, const in_addr_t *dst, in_addr_t *best_gw,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     openvpn_net_iface_t =
*best_iface)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return -1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_rout=
e_v6_best_gw(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, struct in6=
_addr *best_gw,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                 openvpn_net_iface_t *best_iface)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return -1;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+struct signal_info siginfo_sta=
tic; /* GLOBAL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+signal_reset(struct signal_info *si, =
int signum)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+te=
st_is_special_addr(void **state)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(is_special_addr(&quot;net_gateway&quot;));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(is_special_addr(&quot;vpn=
_gateway&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(is_special_addr(&quot;remote_host&quot;));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_false(is_special_addr(&quot;10=2E0=2E0=2E1&quo=
t;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fal=
se(is_special_addr(&quot;default&quot;));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_false(is_special_addr(NULL));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+te=
st_netmask_to_netbits(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int netbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(netmask_=
to_netbits(0x0a000000, 0xff000000, &amp;netbits)); /* 10/8 */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netbits, 8);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(netmask_to_netbits(0xc=
0a80100, 0xffffff00, &amp;netbits)); /* 192=2E168=2E1/24 */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netbits, 24);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(netmask_to_netbits(0x00=
000000, 0x00000000, &amp;netbits)); /* default route */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netbits, 0);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* a full-length mask reports -1 rather =
than 32, which is what callers</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * use to tell &quot;host route&quot; from &quot;network rou=
te&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(netmask=
_to_netbits(0x0a010203, 0xffffffff, &amp;netbits));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netbits, -1);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* host bits set in the network part */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(netm=
ask_to_netbits(0x0a000001, 0xff000000, &amp;netbits));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* not a contiguous netmask */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_false(netmask_to_netbits(0x0a0000=
00, 0xff00ff00, &amp;netbits));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_netmask_to_netbits2(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netmask_to_=
netbits2(0xff000000), 8);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(netmask_to_netbits2(0xffffff00), 24);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netmask_t=
o_netbits2(0x00000000), 0);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* unli=
ke netmask_to_netbits(), this one reports a full-length mask as 32 */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netm=
ask_to_netbits2(0xffffffff), 32);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(netmask_to_netbits2(0xff00ff00), -1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+assert_clea=
r_host_bits(const char *addr, unsigned int netbits, const char *expected)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct route_ipv6 r6;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr want;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    CLEAR(r6);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(inet_pton(AF_INET6, addr, &amp=
;r6=2Enetwork), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(inet_pton(AF_INET6, expected, &amp;want), 1);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    r6=2Enetbits =3D netbits=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    route_ipv6_clear_host_bits(&amp;r=
6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memor=
y_equal(&amp;r6=2Enetwork, &amp;want, sizeof(struct in6_addr));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est_route_ipv6_clear_host_bits(void **state)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* whole bytes cleared */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8::1&quot;, 64, &q=
uot;2001:db8::&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_clear_host_bits(&quot;2001:db8:dead:beef::1&quot;, 32, &quot;=
2001:db8::&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a prefix that=
 does not fall on a byte boundary */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8:0:00ff::1&quot;,=
 60, &quot;2001:db8:0:00f0::&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8::ffff&quot;, 121=
, &quot;2001:db8::ff80&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* n=
othing to clear, and everything to clear */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8::1&quot;,=
 128, &quot;2001:db8::1&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_clear_host_bits(&quot;2001:db8::1&quot;, 0, &quot;::=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+const struct CMUnitTest route_tests[] =3D {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(tes=
t_is_special_addr),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    cmocka_unit_test(test_netmask_to_netbits),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_netmask_to_netbits2),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test=
(test_route_ipv6_clear_host_bits),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+main(void)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    openvpn_unit_test_setup();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return cmocka_run_group_tests(route_tests, NULL, =
NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1946?usp=3Demail">change 1946</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1946?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1946 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: chugly &lt;charlie=2Evigue@openvpn=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--zio2G6lAkDM=--


--===============0879570393786918339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0879570393786918339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0879570393786918339==--

