Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1392C44507
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 22:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=qd2JGvBI4SNvcSZsBuJN8INnYdLEYiv1su5bXHg56kM=; b=dcleKm4qzFhH6T
	/QZ+1xNFWToYqhzcXv5zhbu+qeSQ/l41MFlD4edxjc1cSUvi7n9ZGPfgAs4OyIETz2l9dnXSfzjKe
	e9hDIt0cLysB1YB3uysHEvrsRqfU3iKhhL2tOEIZ211Q09PP9X4NEOfZNfBa2+FIa2grDhAX43Ws4
	NjI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjlRr-00030j-EU;
	Tue, 14 Jul 2026 22:17:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjlRp-00030d-Rj
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 22:17:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mD3kD90NqDMqw/DCGC1KI+D/5vTKmimEfTZvA08qfcY=; b=BfqSIxBzLfirc++TITCQ3rqi3u
 hfYddHkYPEsD6JVj1tc4WauHhfY2KirZQa5GlYhgoMbfy8g+j0kg/UxwWvh5jeaCtC1uimkVGhMHf
 zg5qWlIbJrsIm7LLyxOvsqHJs2sDKhwBk5nyLO2iTlXpQrRspQeL+XQvdpLeeRPpJa0A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mD3kD90NqDMqw/DCGC1KI+D/5vTKmimEfTZvA08qfcY=; b=L
 SS7LoJJXMN2gy2iVgF2vNKekxDlDDwkIvMhlYUteV7zD+TDhjJNhRMC7ZWd9TChTCaN2rNtj8I7Eu
 5ZvIq+dAQ80VgtBss3ZiUGJDmDBXkHfh4qp/8HUD5H2p8rin4z7WMmsL2OoV4m4y8jv8eNdZxNI4+
 ZGlCsU/D9xKcx2w4=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjlRo-0002eP-13 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 22:17:53 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493bf73ec2aso32954415e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784067460; x=1784672260; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mD3kD90NqDMqw/DCGC1KI+D/5vTKmimEfTZvA08qfcY=;
 b=UzYB1moBRyEY6K2KhrDy4A6cXVOAJgAZTpaIPVc6UsE2wM3wCr7Flz+aJXa2rNEg/x
 4+fnurrkh1KnApXsdiC5LahbaKYDAMwzcTICS3mne5aC0sjXECnoNjKXZb/RK4MvUhDx
 NgIv5FpQrttJywX8IzwEdULv/x8mgM3mfw9J6fbjtIvyJ+KTM25FnSP5eZ2Qclntd+07
 VOhO2JfUe+rgcZCQ5/JOk+XZgR3JgxDXzW/nD0w+1o6nVFxWjcEVvdtmaPVkdlLIqxVy
 uZhUFyHH5aVGKjXup0Fn+hddlGI/OMo2aViIdQPwPGCCyOP8vUKcszjhNCH8H7/07jBC
 ooBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784067460; x=1784672260;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mD3kD90NqDMqw/DCGC1KI+D/5vTKmimEfTZvA08qfcY=;
 b=quWBc+cbezzAOZTRPIpoOgg4b7djB1qCgB9EABbLg0fukdmDuQraHp0HBjo/Wrj5Ut
 JyILZDFOmrvfuR4hPzDQylqYmqT5pquzhM53NkI405EMTpxWFU+nkJ34l7JPVt15/BLg
 iNrZSo1tXGmnQnQcJYeRFRSVB8NR4Hi/u5NGAfiFfSU+i6+05aRKHejwJz9B8cDJnhCx
 5xwz2LqBBtoMsVRxkuQbCElaoeedXFRJEySxLtXnt3l6GbdPdOiV87MWdJcfgYXtQ35S
 sNOHHj4iq5JwK2+zMV9bVSTICTdhNUiWusf7CBue7hWcu73AhVmQfYSLfbWS3MyrK+m3
 wUew==
X-Gm-Message-State: AOJu0YzFR+JWYzUBjyCSHYtJKtGre4xzYIWI9YoqWW+ov0eWYPuk6JRH
 ErGPnqBVFrWOiAsmTT/VoURijMTWZa6FH3ok6/s6SXtrwP9MnMt7Y2RUTcvRTzpt7ndmNi+2C5h
 RXvl1yUw6plJ4fjU/cfph6fEsK5YOGqydUusj0y7ngNEOc/ee5ybFqb9ClGbZkGfbmXh9chMJlm
 1wGhRgFg==
X-Gm-Gg: AfdE7cn/0o318GSs5KJf42ARCz061HYFdexogbTRqITTeWu1yqWPAe4v3GtEqCoyP8l
 vTk7Fq1TP0Cno2xKGcHZ6qZghvCdeLIz7vSFbbIrUiy5fEnPoWopLFvsWXLQuZCT7qi4JYP+Jt6
 3gSy4OsH4l0m4rUK/7714SnBf3ozNozMek2s0Y72d7NxiDRwH6dxzaZBdNrRTuvDbUYYUyPc2tk
 HqNI85dzKtoliDAOR70K7lazDycXoQO4Ko1KTD6aksRLSef2Y600jJPRUd6cuDgOp3p5EbKaHU8
 04YcblsjqMaD1UFRxNcOCGunm5or3Z79CxZjGll9iovwDcuy4/mbBzdELNfEOrAF2jWX23C3K6u
 WyYfKWOa0vdDTNPe3g+oRCpDvPoYvXYHBG7vfTnixTyDR9qcLK8XvHpVhZl6FjM9wXv6N2H+mCO
 XK9Lg0SSmSEgOsNI/TW52shXXFPQVmsdm+Y9JGH5XCzGW6L08Y1o1iMWkIo8uiQhnSlhtVR4Z/J
 lDPfqwsTt/F9YLR+IfBWtVXBSQKFxQRqkBMmBkuchx6FaSypu+/9oUq2PSEUXRpN0iSjGkTrZ6x
 K9b9JA7OX+HQ6g==
X-Received: by 2002:a05:6000:178b:b0:472:90af:e406 with SMTP id
 ffacd0b85a97d-47f4fd111a9mr172227f8f.37.1784067460118; 
 Tue, 14 Jul 2026 15:17:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635ac2esm11631634f8f.13.2026.07.14.15.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 15:17:39 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 22:17:39 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id414ce0c8f5ed5b01259590e4eaa1b19f2239362
X-Gerrit-Change-Number: 1785
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1785?usp=email>
X-Gerrit-Commit: 7bd1cbc8374c890b03e3a9e5c6d9a63639d63255
References: <gerrit.1784067448000.Id414ce0c8f5ed5b01259590e4eaa1b19f2239362@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklkNDE0Y2UwYzhmNWVkNWIwMTI1OTU5MGU0ZWFhMWIxOWYyMjM5MzYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f03309248207d4696ffd93c560700bb5e8db94f8-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjlRo-0002eP-13
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: add
 subnet-pool tag lookup unit test
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8230874888092986844=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8230874888092986844==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zU0il0tV/js="; charset=UTF-8

--zU0il0tV/js=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1785?usp=3Demail

to review the following change=2E


Chang=
e subject: tests: add subnet-pool tag lookup unit test
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tests: add subnet-pool tag look=
up unit test

Cover subnet_pool_by_tag: a client's subnet-pool-tag resolves=
 to the
right pool (carrying its subnet and gateway), and an unknown tag re=
turns
NULL, which is the condition that rejects the client with AUTH_FAILED=
=2E

Change-Id: Id414ce0c8f5ed5b01259590e4eaa1b19f2239362
GitHub: closes op=
envpn/OpenVPN#987
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom=
>
---
M CMakeLists=2Etxt
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/u=
nit_tests/openvpn/test_subnet_pool=2Ec
3 files changed, 92 insertions(+), 0=
 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/85/1785/1

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index =
8de836a=2E=2Eac1d05e 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@=
@ -671,6 +671,7 @@
         "test_provider"
         "test_socket"
        =
 "test_ssl"
+        "test_subnet_pool"
         "test_user_pass"
         =
"test_push_update_msg"
         )
@@ -830,6 +831,11 @@
         src/openvpn=
/list=2Ec
         )
 
+    target_sources(test_subnet_pool PRIVATE
+      =
  tests/unit_tests/openvpn/mock_get_random=2Ec
+        src/openvpn/options=
_util=2Ec
+        )
+
     target_sources(test_ncp PRIVATE
         src/op=
envpn/crypto_epoch=2Ec
         src/openvpn/crypto_mbedtls=2Ec
diff --git a=
/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=
=2Eam
index 1128eb4=2E=2Ebfb7284 100644
--- a/tests/unit_tests/openvpn/Make=
file=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -21,6 +21,7 @@
 	=
push_update_msg_testdriver \
 	socket_testdriver \
 	ssl_testdriver \
+	sub=
net_pool_testdriver \
 	user_pass_testdriver
 
 if HAVE_LD_WRAP_SUPPORT
@@ =
-361,6 +362,19 @@
 	$(top_srcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir=
)/src/openvpn/mbuf=2Ec
 
+subnet_pool_testdriver_CFLAGS  =3D \
+	-I$(top_sr=
cdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@T=
EST_CFLAGS@
+
+subnet_pool_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+
+subnet_=
pool_testdriver_SOURCES =3D test_subnet_pool=2Ec \
+	mock_msg=2Ec test_comm=
on=2Eh \
+	mock_get_random=2Ec \
+	$(top_srcdir)/src/openvpn/buffer=2Ec \
+=
	$(top_srcdir)/src/openvpn/options_util=2Ec \
+	$(top_srcdir)/src/openvpn/p=
latform=2Ec
+
 misc_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(=
top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	-DSOURCEDIR=3D\"$(to=
p_srcdir)\" @TEST_CFLAGS@
diff --git a/tests/unit_tests/openvpn/test_subnet=
_pool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=2Ec
new file mode 100=
644
index 0000000=2E=2E8e73b64
--- /dev/null
+++ b/tests/unit_tests/openvpn=
/test_subnet_pool=2Ec
@@ -0,0 +1,72 @@
+/*
+ *  OpenVPN -- An application t=
o securely tunnel IP networks
+ *             over a single UDP port, with =
support for SSL/TLS-based
+ *             session authentication and key ex=
change,
+ *             packet encryption, packet authentication, and
+ *  =
           packet compression=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc <s=
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
+
+#ifdef HAVE_CONFIG_H
+#include=
 "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdlib=2Eh>
+#=
include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "options=2Eh"
+#inc=
lude "options_util=2Eh"
+#include "test_common=2Eh"
+#include "mock_msg=2Eh=
"
+
+/* --subnet-pool-tag resolves a client to its --subnet-pool; an unknow=
n tag
+ * returns NULL, which is what makes the server reject that client=
=2E */
+static void
+test_subnet_pool_by_tag(void **state)
+{
+    struct s=
ubnet_pool_def c =3D { =2Enext =3D NULL, =2Etag =3D "grpC", =2Enetwork =3D =
0x0a020300, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020301 };
+    st=
ruct subnet_pool_def b =3D { =2Enext =3D &c, =2Etag =3D "grpB", =2Enetwork =
=3D 0x0a020200, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020201 };
+  =
  struct subnet_pool_def a =3D { =2Enext =3D &b, =2Etag =3D "grpA", =2Enetw=
ork =3D 0x0a020100, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020101 };=

+
+    /* every configured tag resolves to its own pool, wherever it sits =
*/
+    assert_ptr_equal(subnet_pool_by_tag(&a, "grpA"), &a);
+    assert_p=
tr_equal(subnet_pool_by_tag(&a, "grpB"), &b);
+    assert_ptr_equal(subnet_=
pool_by_tag(&a, "grpC"), &c);
+
+    /* and it carries that pool's subnet/g=
ateway */
+    const struct subnet_pool_def *r =3D subnet_pool_by_tag(&a, "=
grpB");
+    assert_int_equal(r->network, 0x0a020200);
+    assert_int_equa=
l(r->netmask, 0xffffff00);
+    assert_int_equal(r->gateway, 0x0a020201);
+=

+    /* unknown tag and empty list both miss */
+    assert_null(subnet_po=
ol_by_tag(&a, "nope"));
+    assert_null(subnet_pool_by_tag(NULL, "grpA"));=

+}
+
+const struct CMUnitTest subnet_pool_tests[] =3D {
+    cmocka_unit_t=
est(test_subnet_pool_by_tag),
+};
+
+int
+main(void)
+{
+    openvpn_unit_t=
est_setup();
+    return cmocka_run_group_tests(subnet_pool_tests, NULL, NU=
LL);
+}

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1785?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id414ce0c8f=
5ed5b01259590e4eaa1b19f2239362
Gerrit-Change-Number: 1785
Gerrit-PatchSet: =
1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>

--zU0il0tV/js=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1785?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">te=
sts: add subnet-pool tag lookup unit test<br><br>Cover subnet_pool_by_tag: =
a client&#39;s subnet-pool-tag resolves to the<br>right pool (carrying its =
subnet and gateway), and an unknown tag returns<br>NULL, which is the condi=
tion that rejects the client with AUTH_FAILED=2E<br><br>Change-Id: Id414ce0=
c8f5ed5b01259590e4eaa1b19f2239362<br>GitHub: closes openvpn/OpenVPN#987<br>=
Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>=
M CMakeLists=2Etxt<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/u=
nit_tests/openvpn/test_subnet_pool=2Ec<br>3 files changed, 92 insertions(+)=
, 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/85/1785/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt</span><br><span>index 8de836a=2E=2Eac1d05e 100644=
</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2E=
txt</span><br><span>@@ -671,6 +671,7 @@</span><br><span>         &quot;test=
_provider&quot;</span><br><span>         &quot;test_socket&quot;</span><br>=
<span>         &quot;test_ssl&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        &quot;test_subnet_pool&quot;</span><br><span>      =
   &quot;test_user_pass&quot;</span><br><span>         &quot;test_push_upda=
te_msg&quot;</span><br><span>         )</span><br><span>@@ -830,6 +831,11 @=
@</span><br><span>         src/openvpn/list=2Ec</span><br><span>         )<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  target_sources(test_subnet_pool PRIVATE</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_get_random=2Ec<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/=
options_util=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     target_sources(test_ncp PRIVATE</span><br><span>         src/openv=
pn/crypto_epoch=2Ec</span><br><span>         src/openvpn/crypto_mbedtls=2Ec=
</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/test=
s/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 1128eb4=2E=2Ebfb72=
84 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</spa=
n><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@=
 -21,6 +21,7 @@</span><br><span> 	push_update_msg_testdriver \</span><br><s=
pan> 	socket_testdriver \</span><br><span> 	ssl_testdriver \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	subnet_pool_testdriver \</span><b=
r><span> 	user_pass_testdriver</span><br><span> </span><br><span> if HAVE_L=
D_WRAP_SUPPORT</span><br><span>@@ -361,6 +362,19 @@</span><br><span> 	$(top=
_srcdir)/src/openvpn/platform=2Ec \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/mbuf=2Ec</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+subnet_pool_testdriver_CFLAGS  =3D \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/include -I$(top_srcdir)/src/c=
ompat -I$(top_srcdir)/src/openvpn \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	@TEST_CFLAGS@</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+subnet_p=
ool_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+subnet_pool_testdriver_SOURCES =3D test_subnet_pool=2Ec \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	mock_msg=2Ec test_common=2Eh \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_get_random=2Ec \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/=
openvpn/buffer=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	$(top_srcdir)/src/openvpn/options_util=2Ec \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform=2Ec</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> misc_testd=
river_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdi=
r)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span> 	-DSOURCEDIR=
=3D\&quot;$(top_srcdir)\&quot; @TEST_CFLAGS@</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/test_subnet_pool=2Ec b/tests/unit_tests/openvpn/tes=
t_subnet_pool=2Ec</span><br><span>new file mode 100644</span><br><span>inde=
x 0000000=2E=2E8e73b64</span><br><span>--- /dev/null</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_subnet_pool=2Ec</span><br><span>@@ -0,0 +1,72=
 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to =
securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             over a single UDP port, with support for SSL/TLS-bas=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             se=
ssion authentication and key exchange,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             packet encryption, packet authentication,=
 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (=
C) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  This program is free software; you can redistribute it and/o=
r modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it unde=
r the terms of the GNU General Public License version 2</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software F=
oundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is dist=
ributed in the hope that it will be useful,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the impl=
ied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License =
for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should ha=
ve received a copy of the GNU General Public License along</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &=
lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE=
_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;op=
tions_util=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;mock_msg=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* --subnet-pool-tag resolves a client to its --subnet-pool;=
 an unknown tag</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * r=
eturns NULL, which is what makes the server reject that client=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+test_subnet_pool_by_tag(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def c =3D {=
 =2Enext =3D NULL, =2Etag =3D &quot;grpC&quot;, =2Enetwork =3D 0x0a020300, =
=2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020301 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def b =3D { =2En=
ext =3D &amp;c, =2Etag =3D &quot;grpB&quot;, =2Enetwork =3D 0x0a020200, =2E=
netmask =3D 0xffffff00, =2Egateway =3D 0x0a020201 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def a =3D { =2Enex=
t =3D &amp;b, =2Etag =3D &quot;grpA&quot;, =2Enetwork =3D 0x0a020100, =2Ene=
tmask =3D 0xffffff00, =2Egateway =3D 0x0a020101 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* every configured tag resolves to its own pool, wherever =
it sits */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_ptr_equal(subnet_pool_by_tag(&amp;a, &quot;grpA&quot;), &amp;a);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(subnet_=
pool_by_tag(&amp;a, &quot;grpB&quot;), &amp;b);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_ptr_equal(subnet_pool_by_tag(&amp;a,=
 &quot;grpC&quot;), &amp;c);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* and=
 it carries that pool&#39;s subnet/gateway */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const struct subnet_pool_def *r =3D subnet_po=
ol_by_tag(&amp;a, &quot;grpB&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(r-&gt;network, 0x0a020200);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r-&gt;ne=
tmask, 0xffffff00);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(r-&gt;gateway, 0x0a020201);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* unknown tag and empty list both miss */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_null(subnet_pool_by_tag(&am=
p;a, &quot;nope&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_null(subnet_pool_by_tag(NULL, &quot;grpA&quot;));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+const struct CMUnitTest subnet_pool_tests[] =3D {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_subnet_poo=
l_by_tag),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+main(void)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_u=
nit_test_setup();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return cmocka_run_group_tests(subnet_pool_tests, NULL, NULL);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1785?usp=3Demail">change 1785</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1785?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newcha=
nge </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: Id414ce0c8f5ed5b01259590e4eaa1b19f2239362 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 1785 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></h=
tml>
--zU0il0tV/js=--


--===============8230874888092986844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8230874888092986844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8230874888092986844==--

