Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB2EC98324
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XGEEiyEtGvP8us3nSSEgaKjE38F3CF9+Tl8RP+482jU=; b=J4e2YWOE877VorOMLDUA+ADydU
	yutulReQqtuGhv7Az9cqJTTxyOheIAv013l7P4EjfEUOMMay2MqM5Qy7d20xU6nAuvnnoNix3zSMw
	Z6h1bObXUlSEe/YUG+YJpBOMH94WpoA+t2xLa80oVSgC7DVwqpyTKHznPZFRCdzxKGl0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA72F-0000CZ-0X;
	Fri, 25 Sep 2026 14:36:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA72D-0000CS-MF
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 14:36:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kzsYDzh4ygvxbK17LFry3r4oRKNJVfoIqKYllqDRa3M=; b=egecKmGr3VxH60uQ7BUxHi2bip
 78c+r/vUOrVyMlnJ1+o1p9U3tLtfudX54kwMMlB/1MmkuQ3GiPsmjrJR03PJBa+jVCeLoLjhf0Gs3
 ZF0W6uwjBsCvgD7sBeAcE+0oTFSGLpA40sfek27VvEhn1rFtkZfdmrVr2emQfN3kDKCs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kzsYDzh4ygvxbK17LFry3r4oRKNJVfoIqKYllqDRa3M=; b=g
 HFfjxZ/i4E1IyO2AVGzqZp+lRpuDeRiyj8y+ZggGkOTD83EDOaoPivtdZCR+ZgJzdmWEhUWdCv3SX
 d9PZDAj6djboO2wBQislMNcYf02oNQ59wDYZ9gRf2Afi9kAQ7VfJM1T3VB0r2Wq5lW7tjWinGGlfo
 FegGgYHV0eD3tekw=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA728-0007UY-7b for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 14:36:19 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4887f690df6so538662f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 07:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790346970; x=1790951770; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kzsYDzh4ygvxbK17LFry3r4oRKNJVfoIqKYllqDRa3M=;
 b=PqKN1JLskzkd9lzQ5baKjtzSsEFBZu+p1IcoODjGgCqX1ZBXg3sffm5GlFuXvyiUf5
 dkyNjXtETVTTvDw0EW2KlsZkhr+BG+etdqs/5BmznwzNqoMLvClZT3o5A5ozIW1VTwdX
 Iba8rWUEpGiKjpDQLL6JXbuo5fBOBDhXaV/rCDK5krqlsJnZ5fsMdAo+aJrCcK4o6/Fw
 O7qV9Z1vamc/SaglDDPlZ8J7tbzXoyUpk7IBlcdkGlawJrqrBvA0B5y/bG7sag5fRIzf
 hJBtUzaIGvUj5NBWYymInH8RYuCCcV2ubTb5Nqq4CGo1b+oJYg7x0ASCSzHAmZGJUXpv
 KXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790346970; x=1790951770;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kzsYDzh4ygvxbK17LFry3r4oRKNJVfoIqKYllqDRa3M=;
 b=QkIzl8arECcPe9zHL7hscgbEBnfgd/h+FB3oidhFucm1fZusLIJHFA4JHAWHmca3D6
 MEGcsdZZHgAIF3jyKpgfVYUz+pMOrO3igVqcFdQerKAyjaLV5qY4sW15WcQnwNfE5K1b
 k7jFWkm5oUxUnzvcW90LZ/POQM6VH5cyLW53go73MAcDOHvXVeuWaNTNdjd5V978rOnH
 AZ5kex+GCAziVAICljp3ZvJ+AFqn1dZB60Zhj0bYAi7BzZW0aFRRcS+1GICfBQn5CMgi
 2onaD+mDy92drW0IT+wNr+1q8y7xxevIrYSnS2LjadnbrIwcNqfCGsZCIah0zFvJGnqT
 Nx7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByc/0PUNHFTRifVMEf22aIn2D1rjpS5izBAp89T+iMWClIdnkLQhqQhAjvTtT2QGO7ojP1iC1L6WSyyAltZ@lists.sourceforge.net
X-Gm-Message-State: AFuF++kCQSuYE/mmq20mWzT4VZn32KTMCY4Zh0AIcVReb6lWyOG2pCg/
 RONVYtdNXOABEX7Q2Ds5b41iG4FW+tkBoiZkFFnD6awVLuWsL5mILq9WHOMND3kPEvzrM83jCnY
 iJyX1XpFfZYbIRL5MG++iz3V5Bux0HQzaVdEbZJBG32n7g+DJY+0J716DOoOfz4zURLsYxoygR8
 J1VNvsig==
X-Gm-Gg: AYBFou0EQQMT1Djdh9WW6eH+kGhlNnATtd+h1z9QlN9vEWtbv3YR4wX3MMU4tTW0dwI
 2rpDuXl9KgVITQ3diuIh1AGyaQiDntaA+aeW1T5CyeIeYfiJBvWXQtX/Ydb8bsYkceU0w81VUfg
 mrVJJOeWuCkLaIUCfca+EI/RNqUUWP76XNHebDlTw6XAJGqbLSyXcDVNuxMqGo4L1YxxSpgPsaL
 1ZzGe/7BFS8B0b4axsZlafcgOjNkaVxNqbGxNd/3bZpGrbu/W7JzruCVyyuDayA9h2m2cG1eKL6
 8GBv1iePI50WFyYwZsLuQsi+oZKLkuO3T/tC+FKdf8eRIkm4TGNZvV4rKGwwlb9MC9mkCHwA73p
 jQcDFqJncabTMjuAGXicPOAiYpjnJLbC97Yg9V/2gue4AOCiL8v4S4UXp0fCODWX855CGZqg52F
 dpnls086P9LLamUur9n9Jrfj/MugZBPv3oVEyaUB5UUmJX1iHDQahbCkFFRlR1qi9VR9yVF1y0S
 51P+3npOKBQKOD0lpMZysxEhBoOBzXW0rA6bynpUOLq5bywZaI5aOFt1pyGKkQWbv2+r1hMuqKE
 dkYho0lZLPxpt6TpDAqg8v9tPa2L2sCjqb4rCtFbxygHDBY2naAPHcqAIWFy
X-Received: by 2002:a05:6000:38b:b0:487:40a:5ba8 with SMTP id
 ffacd0b85a97d-48871679eddmr9519998f8f.15.1790346969288; 
 Fri, 25 Sep 2026 07:36:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a2acb4dsm7792470f8f.0.2026.09.25.07.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 07:36:08 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 14:36:07 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: 91be564f67196b38c2f41323a0e0e113746068b5
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e086ce638183da7c2f6e0b6ccea3459202d1481e-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA728-0007UY-7b
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change most
 ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6768015672972280953=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6768015672972280953==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ioiRKlZXzNk="; charset=UTF-8

--ioiRKlZXzNk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1942?usp=3Demail )

Change subject: Change most ENABLE_DEBUG ifdefs to =
ifndef ENABLE_SMALL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Change most ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL

Most of the=
se are verbose logging or even enable logging at high
verbosity level or ju=
st useful tools like --show-gateway=2E

We had --enabled-debug on by defaul=
t forever, so these "debug"
logs are on by default=2E This patch instead mo=
ves them to
enable-small=2E

Since the verbose logging is now always enable=
d
(apart from --enable-small), --enable-debug now only covers true
debug op=
tions like gremlin=2E

Rename the configure option from --enable-debug to
-=
-enable-developer-debug to ensure existing build
script/maintainer do not e=
nable this option
by default=2E

This patch also adds [SMALL] and [DEBUG] a=
s identifier in the OpenVPN
version string more easily identify builds with=
 this feature=2E

In addition both configure and openvpn itself will add a =
warning
about --enable-developer-debug to discourage users and maintainers
=
from enabling this feature=2E

Remove dmsg macro from tapctl's error=2Eh si=
nce it does
not use that macro at all=2E

Change-Id: I3f96cd1c3488b558b8a59=
7594d99edcba1214d27
Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942
Message-Id: <20260925122231=2E5805=
-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg39490=2Ehtml
Signed-off-by: Gert Doering =
<gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M Changes=2Emd
M config=2E=
h=2Ecmake=2Ein
M configure=2Eac
M dev-tools/cppcheck-suppression
M dev-tool=
s/openvpn-cppcheck-library=2Ecfg
M src/openvpn/compstub=2Ec
M src/openvpn/c=
rypto_mbedtls=2Ec
M src/openvpn/crypto_mbedtls_legacy=2Ec
M src/openvpn/err=
or=2Eh
M src/openvpn/event=2Ec
M src/openvpn/forward=2Ec
M src/openvpn/mrou=
te=2Ec
M src/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2E=
c
M src/openvpn/multi_io=2Ec
M src/openvpn/openvpn=2Ec
M src/openvpn/option=
s=2Ec
M src/openvpn/options=2Eh
M src/openvpn/packet_id=2Ec
M src/openvpn/p=
lugin=2Ec
M src/openvpn/plugin=2Eh
M src/openvpn/reliable=2Ec
M src/openvpn=
/route=2Ec
M src/openvpn/schedule=2Ec
M src/tapctl/error=2Eh
27 files chang=
ed, 85 insertions(+), 59 deletions(-)




diff --git a/CMakeLists=2Etxt b/C=
MakeLists=2Etxt
index 6eb5954=2E=2Ed553697 100644
--- a/CMakeLists=2Etxt
++=
+ b/CMakeLists=2Etxt
@@ -40,6 +40,7 @@
 option(ENABLE_PKCS11 "BUILD with pk=
cs11-helper" ON)
 option(USE_WERROR "Treat compiler warnings as errors (-We=
rror)" ON)
 option(FAKE_ANDROID "Target Android but do not use actual cross=
 compile/Android cmake to build for simple compile checks on Linux")
+optio=
n(ENABLE_DEBUG "Enable building with debug" OFF)
 
 option(ENABLE_DNS_UPDOW=
N_BY_DEFAULT "Run --dns-updown hook by default" ON)
 set(DNS_UPDOWN_PATH "$=
{CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown" CACHE STRING "Default lo=
cation for the DNS up/down script")
diff --git a/Changes=2Emd b/Changes=2Em=
d
index 2684251=2E=2E5c3270b 100644
--- a/Changes=2Emd
+++ b/Changes=2Emd
@=
@ -23,6 +23,12 @@
   the characters mentioned above were already escaped=2E=
 However, the behavior of
   Mbed TLS is slightly different from OpenSSL in=
 that it also escapes "=3D"=2E
 
+## Maintainer-visible changes
+
+- The co=
nfigure-time option `--enable-debug` is no longer  available
+  and the ver=
bose logging is now always included unless `--enable-small`
+  is enabled=
=2E
+
 # Overview of changes in 2=2E7
 
 ## New features
diff --git a/confi=
g=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index c3bb5a5=2E=2Ec6c0a96 100=
644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -18,8 +1=
8,8 @@
 /* Enable shared data channel offload */
 #cmakedefine ENABLE_DCO
 =

-/* Enable debugging support (needed for verb>=3D4) */
-#define ENABLE_DEB=
UG 1
+/* Enable debugging support */
+#cmakedefine ENABLE_DEBUG
 
 /* Enabl=
e internal fragmentation support */
 #define ENABLE_FRAGMENT 1
diff --git a=
/configure=2Eac b/configure=2Eac
index 469a475=2E=2E1fa0e63 100644
--- a/co=
nfigure=2Eac
+++ b/configure=2Eac
@@ -130,10 +130,10 @@
 )
 
 AC_ARG_ENABLE=
(
-	[debug],
-	[AS_HELP_STRING([--disable-debug], [disable debugging suppor=
t (disable gremlin and verb 7+ messages) @<:@default=3Dyes@:>@])],
-	,
-	[e=
nable_debug=3D"yes"]
+	[developer-debug],
+	[AS_HELP_STRING([--enable-devel=
oper-debug], [enable developer debugging support (enable gremlin) @<:@defau=
lt=3Dno@:>@])],
+	[enable_debug=3D"yes"],
+	[enable_debug=3D"no"]
 )
 
 AC_=
ARG_ENABLE(
@@ -1393,3 +1393,8 @@
 ])
 AC_CONFIG_FILES([tests/t_client=2Esh=
], [chmod +x tests/t_client=2Esh])
 AC_OUTPUT
+
+# Put the warning at the e=
nd, so it is better visible
+if test "${enable_debug}" =3D "yes"; then
+   =
 AC_MSG_WARN([--enable-developer-debug is enabled=2E This should be only us=
ed for test/development builds and not for production usage])
+fi
\ No newl=
ine at end of file
diff --git a/dev-tools/cppcheck-suppression b/dev-tools/=
cppcheck-suppression
index 299d7a3=2E=2E27c9d30 100644
--- a/dev-tools/cppc=
heck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -42,7 +42,7 @@
 in=
tToPointerCast:src/openvpn/multi_io=2Ec
 intToPointerCast:src/openvpn/ps=2E=
c
 # FP: constant but differs between platforms
-knownConditionTrueFalse:sr=
c/openvpn/error=2Eh:380
+knownConditionTrueFalse:src/openvpn/error=2Eh:382
=
 knownConditionTrueFalse:src/openvpn/fdmisc=2Ec:80
 knownConditionTrueFalse=
:src/openvpn/lladdr=2Ec:64
 knownConditionTrueFalse:src/openvpn/platform=2E=
c
@@ -73,8 +73,8 @@
 # FP: cppcheck doesn't understand ZeroMemory
 redundan=
tAssignment:src/openvpnserv/interactive=2Ec:204
 # IGN: We reuse the same v=
ariable name due to macro usage
-shadowVariable:src/openvpn/options=2Ec:194=
8
-shadowVariable:src/openvpn/options=2Ec:1966
+shadowVariable:src/openvpn/=
options=2Ec:1955
+shadowVariable:src/openvpn/options=2Ec:1973
 # FP: fun:tl=
s_crypt_v2_wrap_unwrap_invalid: cppcheck is confused
 syntaxError:tests/uni=
t_tests/openvpn/test_tls_crypt=2Ec:684
 # FP: this file is never compiled o=
n _WIN32
diff --git a/dev-tools/openvpn-cppcheck-library=2Ecfg b/dev-tools/=
openvpn-cppcheck-library=2Ecfg
index 1ea91f4=2E=2Edecac67 100644
--- a/dev-=
tools/openvpn-cppcheck-library=2Ecfg
+++ b/dev-tools/openvpn-cppcheck-libra=
ry=2Ecfg
@@ -26,4 +26,6 @@
   <!-- work around macro confusion -->
   <defi=
ne name=3D"CMSG_FIRSTHDR" value=3D"cmsg_firsthdr" />
   <define name=3D"CMS=
G_NXTHDR" value=3D"cmsg_nxthdr" />
+  <!-- otherwise a lot of unused variab=
les are shown for enable-small builds -->
+  <define name=3D"DMSG_ALWAYS_AV=
AILABLE" value=3D"1" />
 </def>
diff --git a/src/openvpn/compstub=2Ec b/src=
/openvpn/compstub=2Ec
index f0c89f7=2E=2E2eef587 100644
--- a/src/openvpn/c=
ompstub=2Ec
+++ b/src/openvpn/compstub=2Ec
@@ -125,7 +125,7 @@
         ret=
urn;
     }
 
-    uint8_t *head =3D BPTR(buf);
+    const uint8_t *head =
=3D BPTR(buf);
 
     /* no compression or packet to short*/
     if (head[=
0] !=3D COMP_ALGV2_INDICATOR_BYTE)
diff --git a/src/openvpn/crypto_mbedtls=
=2Ec b/src/openvpn/crypto_mbedtls=2Ec
index 0c5beb4=2E=2E05bb60d 100644
---=
 a/src/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/crypto_mbedtls=2Ec
@@ -=
842,8 +842,8 @@
     struct gc_arena gc =3D gc_new();
     uint8_t A1[MAX_H=
MAC_KEY_LENGTH];
 
-#ifdef ENABLE_DEBUG
-    /* used by the D_SHOW_KEY_SOUR=
CE, guarded with ENABLE_DEBUG to avoid unused
+#ifndef ENABLE_SMALL
+    /*=
 used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unused
 =
     * variables warnings if compiled with --enable-small */
     const siz=
e_t olen_orig =3D olen;
     const uint8_t *out_orig =3D out;
diff --git a/=
src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_legacy=
=2Ec
index bbd012f6=2E=2Ef46d8bf 100644
--- a/src/openvpn/crypto_mbedtls_le=
gacy=2Ec
+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec
@@ -989,8 +989,8 @@
  =
   struct gc_arena gc =3D gc_new();
     uint8_t A1[MAX_HMAC_KEY_LENGTH];
 =

-#ifdef ENABLE_DEBUG
-    /* used by the D_SHOW_KEY_SOURCE, guarded with E=
NABLE_DEBUG to avoid unused
+#ifndef ENABLE_SMALL
+    /* used by the D_SHO=
W_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unused
      * variables w=
arnings if compiled with --enable-small */
     const size_t olen_orig =3D =
olen;
     const uint8_t *out_orig =3D out;
diff --git a/src/openvpn/error=
=2Eh b/src/openvpn/error=2Eh
index a887fc7=2E=2E9f39572 100644
--- a/src/op=
envpn/error=2Eh
+++ b/src/openvpn/error=2Eh
@@ -158,7 +158,9 @@
         } =
                               \
         EXIT_FATAL(flags);               =
\
     } while (false)
-#ifdef ENABLE_DEBUG
+/* We have DMSG_ALWAYS_AVAILAB=
LE here to able to silence unused warnings for
+ * cppcheck */
+#if !define=
d(ENABLE_SMALL) || defined(DMSG_ALWAYS_AVAILABLE)
 #define dmsg(flags, =2E=
=2E=2E)                 \
     do                                   \
     =
{                                    \
diff --git a/src/openvpn/event=2Ec b=
/src/openvpn/event=2Ec
index 8b7716a=2E=2E2cb4e04 100644
--- a/src/openvpn/=
event=2Ec
+++ b/src/openvpn/event=2Ec
@@ -398,7 +398,7 @@
 
     dmsg(D_EVE=
NT_WAIT, "WE_WAIT enter n=3D%d to=3D%d", wes->n_events, timeout);
 
-#ifdef=
 ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_EVENT_WAIT=
))
     {
         int i;
diff --git a/src/openvpn/forward=2Ec b/src/openvp=
n/forward=2Ec
index 6fe5849=2E=2Ea8a4a07 100644
--- a/src/openvpn/forward=
=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -50,7 +50,7 @@
 
 /* show event wait =
debugging info */
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 
 static co=
nst char *
 wait_status_string(struct context *c, struct gc_arena *gc)
@@ -=
75,7 +75,7 @@
     gc_free(&gc);
 }
 
-#endif /* ifdef ENABLE_DEBUG */
+#en=
dif
 
 static void
 check_tls_errors_co(struct context *c)
@@ -2190,7 +2190=
,7 @@
         {
             int status;
 
-#ifdef ENABLE_DEBUG
+#ifndef E=
NABLE_SMALL
             if (check_debug_level(D_EVENT_WAIT))
             =
{
                 show_wait_status(c);
diff --git a/src/openvpn/mroute=2Ec=
 b/src/openvpn/mroute=2Ec
index 39fa482=2E=2E261d25a 100644
--- a/src/openv=
pn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -501,7 +501,7 @@
     }
     =
mh->n_net_len =3D j;
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (=
check_debug_level(D_MULTI_DEBUG))
     {
         struct gc_arena gc =3D gc=
_new();
diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index 5d88=
f8a=2E=2Eb0125f1 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=
=2Ec
@@ -74,7 +74,7 @@
         mi->did_real_hash =3D true;
     }
 
-#ifde=
f ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (mi)
     {
         dmsg(D_MU=
LTI_DEBUG, "MULTI TCP: instance added: %s", mroute_addr_print(&mi->real, &g=
c));
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 88b0091=
=2E=2E4794b7e 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
=
@@ -431,7 +431,7 @@
         }
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABL=
E_SMALL
     if (check_debug_level(D_MULTI_DEBUG))
     {
         struct g=
c_arena gc =3D gc_new();
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/m=
ulti=2Ec
index 3e72b92=2E=2E67204c3 100644
--- a/src/openvpn/multi=2Ec
+++ =
b/src/openvpn/multi=2Ec
@@ -1145,7 +1145,7 @@
         }
     }
 
-#ifdef E=
NABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_MULTI_DEBUG)=
)
     {
         struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn=
/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index 3604684=2E=2E4b96c57 100644
=
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -46,7 +46,=
7 @@
 #define MULTI_IO_FILE_CLOSE_WRITE ((void *)5)
 #define MULTI_IO_DCO  =
            ((void *)6)
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 stati=
c const char *
 pract(int action)
 {
@@ -89,7 +89,7 @@
             return =
"?";
     }
 }
-#endif /* ENABLE_DEBUG */
+#endif
 
 static inline struct c=
ontext *
 multi_get_context(struct multi_context *m, struct multi_instance =
*mi)
diff --git a/src/openvpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec
index 2=
4d6bb6=2E=2Eacd366d 100644
--- a/src/openvpn/openvpn=2Ec
+++ b/src/openvpn/=
openvpn=2Ec
@@ -252,6 +252,8 @@
 #endif
             show_library_versions(=
M_INFO);
 
+            show_debug_warning(M_INFO);
+
             show_dco=
_version(M_INFO);
 
             /* misc stuff */
diff --git a/src/openvpn/=
options=2Ec b/src/openvpn/options=2Ec
index e3cd527=2E=2E3c5a249 100644
---=
 a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -113,9 +113,16 =
@@
 #ifdef ENABLE_DCO
     " [DCO]"
 #endif
+#ifdef ENABLE_SMALL
+    " [SM=
ALL]"
+#endif
+#ifdef ENABLE_DEBUG
+    " [DEBUG]"
+#endif
 #ifdef CONFIGUR=
E_GIT_REVISION
     " built on " __DATE__
 #endif
+
     ;
 
 #ifndef ENABL=
E_SMALL
@@ -785,7 +792,7 @@
 #endif /* ENABLE_PKCS11 */
     "\n"
     "Gen=
eral Standalone Options:\n"
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
    =
 "--show-gateway [address]: Show info about gateway [to v4/v6 address]=2E\n=
"
 #endif
     ;
@@ -3534,6 +3541,9 @@
     msg(M_INFO | M_NOPREFIX, "speci=
al build: %s", CONFIGURE_SPECIAL_BUILD);
 #endif
 #endif
+
+    show_debug_=
warning(M_INFO | M_NOPREFIX);
+
     openvpn_exit(OPENVPN_EXIT_STATUS_GOOD)=
;
 }
 
@@ -4229,7 +4239,7 @@
         read_config_file(options, p[1], level=
, file, line, msglevel, permission_mask,
                          option_t=
ypes_found, es);
     }
-#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL=
)
+#ifndef ENABLE_SMALL
     else if (streq(p[0], "show-gateway") && !p[2])=

     {
         struct route_gateway_info rgi;
@@ -4938,12 +4948,13 @@
   =
           * mbed TLS always generating debug level logging */
            =
 options->ssl_flags |=3D SSLF_TLS_DEBUG_ENABLED;
         }
-#if !defined(E=
NABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifdef ENABLE_SMALL
         /* War=
n when a debug verbosity is supplied when built without debug support */
  =
       if (options->verbosity >=3D 7)
         {
             msg(M_WARN,
-=
                "NOTE: debug verbosity (--verb %d) is enabled but this buil=
d lacks debug support=2E",
+                "NOTE: debug verbosity (--verb =
%d) is enabled but this build is "
+                "built with --enable-sm=
all that lacks support for high --verb settings",
                 options-=
>verbosity);
         }
 #endif
diff --git a/src/openvpn/options=2Eh b/src/=
openvpn/options=2Eh
index f472676=2E=2E31ae17b 100644
--- a/src/openvpn/opt=
ions=2Eh
+++ b/src/openvpn/options=2Eh
@@ -888,6 +888,16 @@
 
 void show_li=
brary_versions(const unsigned int flags);
 
+static inline void
+show_debug=
_warning(const unsigned int flags)
+{
+#ifdef ENABLE_DEBUG
+    msg(flags, =
"WARNING: OpenVPN has been compiled with --enable-developer-debug=2E "
+   =
            "This should be only used for test/development builds and not f=
or "
+               "production usage");
+#endif
+}
+
 #ifdef _WIN32
 void=
 show_windows_version(const unsigned int flags);
 
diff --git a/src/openvpn=
/packet_id=2Ec b/src/openvpn/packet_id=2Ec
index a4b627c=2E=2E22c53c7 10064=
4
--- a/src/openvpn/packet_id=2Ec
+++ b/src/openvpn/packet_id=2Ec
@@ -52,18=
 +52,18 @@
 #define SEQ_UNSEEN  ((time_t)0)
 #define SEQ_EXPIRED ((time_t)1=
)
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 static void packet_id_debug=
_print(msglvl_t msglevel, const struct packet_id_rec *p,
                  =
                 const struct packet_id_net *pin, const char *message,
    =
                               packet_id_print_type value);
 
-#endif /* EN=
ABLE_DEBUG */
+#endif
 
 static inline void
 packet_id_debug(msglvl_t msgle=
vel, const struct packet_id_rec *p,
                 const struct packet_id=
_net *pin, const char *message, uint64_t value)
 {
-#ifdef ENABLE_DEBUG
+#i=
fndef ENABLE_SMALL
     if (unlikely(check_debug_level(msglevel)))
     {
 =
        packet_id_debug_print(msglevel, p, pin, message, value);
@@ -576,7 =
+576,7 @@
     return (char *)out=2Edata;
 }
 
-#ifdef ENABLE_DEBUG
+#ifnde=
f ENABLE_SMALL
 
 static void
 packet_id_debug_print(msglvl_t msglevel, con=
st struct packet_id_rec *p,
@@ -648,7 +648,7 @@
     gc_free(&gc);
 }
 
-#e=
ndif /* ifdef ENABLE_DEBUG */
+#endif
 
 uint16_t
 packet_id_read_epoch(str=
uct packet_id_net *pin, struct buffer *buf)
diff --git a/src/openvpn/plugin=
=2Ec b/src/openvpn/plugin=2Ec
index f8adde5=2E=2Ea94f07b 100644
--- a/src/o=
penvpn/plugin=2Ec
+++ b/src/openvpn/plugin=2Ec
@@ -993,7 +993,7 @@
     pr-=
>n =3D 0;
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 void
 plugin_ret=
urn_print(const msglvl_t msglevel, const char *prefix, const struct plugin_=
return *pr)
 {
@@ -1012,5 +1012,5 @@
         }
     }
 }
-#endif /* ifdef =
ENABLE_DEBUG */
+#endif
 #endif /* ENABLE_PLUGIN */
diff --git a/src/openvp=
n/plugin=2Eh b/src/openvpn/plugin=2Eh
index 7e9faf3=2E=2E684632c 100644
---=
 a/src/openvpn/plugin=2Eh
+++ b/src/openvpn/plugin=2Eh
@@ -135,7 +135,7 @@
=
 
 void plugin_return_free(struct plugin_return *pr);
 
-#ifdef ENABLE_DEBU=
G
+#ifndef ENABLE_SMALL
 void plugin_return_print(const msglvl_t msglevel, =
const char *prefix, const struct plugin_return *pr);
 
 #endif
diff --git a=
/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec
index ced438e=2E=2Eb53=
15ff 100644
--- a/src/openvpn/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@=
@ -462,7 +462,7 @@
     }
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 =
/* print the current sequence of active packet IDs */
 static const char *
=
 reliable_print_ids(const struct reliable *rel, struct gc_arena *gc)
@@ -48=
0,7 +480,7 @@
     }
     return BSTR(&out);
 }
-#endif /* ENABLE_DEBUG */
=
+#endif
 
 /* true if at least one free buffer available */
 bool
diff --gi=
t a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 03a2526=2E=2Ee8001b=
3 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -81,7 +=
81,7 @@
 
 static void get_bypass_addresses(struct route_bypass *rb, const =
unsigned int flags);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 
 static=
 void
 print_bypass_addresses(const struct route_bypass *rb)
@@ -617,7 +617=
,7 @@
     if (rl->ngi=2Eflags & RGI_ADDR_DEFINED)
     {
         setenv_r=
oute_addr(es, "net_gateway", rl->ngi=2Egateway=2Eaddr, -1);
-#if defined(EN=
ABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifndef ENABLE_SMALL
         print_=
default_gateway(D_ROUTE, &rl->rgi, NULL);
 #endif
     }
@@ -660,7 +660,7 @=
@
             add_block_local_routes(rl);
         }
         get_bypass_a=
ddresses(&rl->spec=2Ebypass, rl->flags);
-#ifdef ENABLE_DEBUG
+#ifndef ENAB=
LE_SMALL
         print_bypass_addresses(&rl->spec=2Ebypass);
 #endif
     =
}
@@ -768,7 +768,7 @@
     if (rl6->ngi6=2Eflags & RGI_ADDR_DEFINED)
     {=

         setenv_str(es, "net_gateway_ipv6", print_in6_addr(rl6->ngi6=2Egat=
eway=2Eaddr_ipv6, 0, &gc));
-#if defined(ENABLE_DEBUG) && !defined(ENABLE_S=
MALL)
+#ifndef ENABLE_SMALL
         print_default_gateway(D_ROUTE, NULL, &=
rl6->rgi6);
 #endif
     }
diff --git a/src/openvpn/schedule=2Ec b/src/open=
vpn/schedule=2Ec
index 6772ad6=2E=2E6c60dc2 100644
--- a/src/openvpn/schedu=
le=2Ec
+++ b/src/openvpn/schedule=2Ec
@@ -33,7 +33,7 @@
 
 #include "memdbg=
=2Eh"
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 static void
 schedule_e=
ntry_debug_info(const char *caller, const struct schedule_entry *e)
 {
@@ -=
308,7 +308,7 @@
 void
 schedule_add_modify(struct schedule *s, struct sched=
ule_entry *e)
 {
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_=
debug_level(D_SCHEDULER))
     {
         schedule_entry_debug_info("schedu=
le_add_modify", e);
@@ -355,7 +355,7 @@
         }
     }
 
-#ifdef ENABLE_=
DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_SCHEDULER))
     {=

         schedule_entry_debug_info("schedule_find_least", e);
diff --git a=
/src/tapctl/error=2Eh b/src/tapctl/error=2Eh
index f9586dc=2E=2E4424f56 100=
644
--- a/src/tapctl/error=2Eh
+++ b/src/tapctl/error=2Eh
@@ -83,19 +83,6 @=
@
         }                                \
         EXIT_FATAL(flags);  =
             \
     } while (false)
-#ifdef ENABLE_DEBUG
-#define dmsg(flag=
s, =2E=2E=2E)                 \
-    do                                   \=

-    {                                    \
-        if (msg_test(flags)) =
            \
-        {                                \
-            x_ms=
g((flags), __VA_ARGS__); \
-        }                                \
-   =
     EXIT_FATAL(flags);               \
-    } while (false)
-#else
-#defin=
e dmsg(flags, =2E=2E=2E)
-#endif
 
 void x_msg(const unsigned int flags, co=
nst char *format, =2E=2E=2E); /* should be called via msg above */
 

-- 
T=
o view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d9=
9edcba1214d27
Gerrit-Change-Number: 1942
Gerrit-PatchSet: 11
Gerrit-Owner: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--ioiRKlZXzNk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1942?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Change most ENABLE_DEBUG ifdefs to ifndef =
ENABLE_SMALL<br><br>Most of these are verbose logging or even enable loggin=
g at high<br>verbosity level or just useful tools like --show-gateway=2E<br=
><br>We had --enabled-debug on by default forever, so these &quot;debug&quo=
t;<br>logs are on by default=2E This patch instead moves them to<br>enable-=
small=2E<br><br>Since the verbose logging is now always enabled<br>(apart f=
rom --enable-small), --enable-debug now only covers true<br>debug options l=
ike gremlin=2E<br><br>Rename the configure option from --enable-debug to<br=
>--enable-developer-debug to ensure existing build<br>script/maintainer do =
not enable this option<br>by default=2E<br><br>This patch also adds [SMALL]=
 and [DEBUG] as identifier in the OpenVPN<br>version string more easily ide=
ntify builds with this feature=2E<br><br>In addition both configure and ope=
nvpn itself will add a warning<br>about --enable-developer-debug to discour=
age users and maintainers<br>from enabling this feature=2E<br><br>Remove dm=
sg macro from tapctl&#39;s error=2Eh since it does<br>not use that macro at=
 all=2E<br><br>Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27<br>Sign=
ed-off-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Acked-by: Fra=
nk Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1942<br>Message-Id: &lt;20260925122231=2E5805=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg39490=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M =
Changes=2Emd<br>M config=2Eh=2Ecmake=2Ein<br>M configure=2Eac<br>M dev-tool=
s/cppcheck-suppression<br>M dev-tools/openvpn-cppcheck-library=2Ecfg<br>M s=
rc/openvpn/compstub=2Ec<br>M src/openvpn/crypto_mbedtls=2Ec<br>M src/openvp=
n/crypto_mbedtls_legacy=2Ec<br>M src/openvpn/error=2Eh<br>M src/openvpn/eve=
nt=2Ec<br>M src/openvpn/forward=2Ec<br>M src/openvpn/mroute=2Ec<br>M src/op=
envpn/mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M sr=
c/openvpn/multi_io=2Ec<br>M src/openvpn/openvpn=2Ec<br>M src/openvpn/option=
s=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/packet_id=2Ec<br>M src/=
openvpn/plugin=2Ec<br>M src/openvpn/plugin=2Eh<br>M src/openvpn/reliable=2E=
c<br>M src/openvpn/route=2Ec<br>M src/openvpn/schedule=2Ec<br>M src/tapctl/=
error=2Eh<br>27 files changed, 85 insertions(+), 59 deletions(-)<br><br></p=
re>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>ind=
ex 6eb5954=2E=2Ed553697 100644</span><br><span>--- a/CMakeLists=2Etxt</span=
><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -40,6 +40,7 @@</span><=
br><span> option(ENABLE_PKCS11 &quot;BUILD with pkcs11-helper&quot; ON)</sp=
an><br><span> option(USE_WERROR &quot;Treat compiler warnings as errors (-W=
error)&quot; ON)</span><br><span> option(FAKE_ANDROID &quot;Target Android =
but do not use actual cross compile/Android cmake to build for simple compi=
le checks on Linux&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+option(ENABLE_DEBUG &quot;Enable building with debug&quot; OFF)</span=
><br><span> </span><br><span> option(ENABLE_DNS_UPDOWN_BY_DEFAULT &quot;Run=
 --dns-updown hook by default&quot; ON)</span><br><span> set(DNS_UPDOWN_PAT=
H &quot;${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown&quot; CACHE STRI=
NG &quot;Default location for the DNS up/down script&quot;)</span><br><span=
>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index 2684251=2E=
=2E5c3270b 100644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/=
Changes=2Emd</span><br><span>@@ -23,6 +23,12 @@</span><br><span>   the char=
acters mentioned above were already escaped=2E However, the behavior of</sp=
an><br><span>   Mbed TLS is slightly different from OpenSSL in that it also=
 escapes &quot;=3D&quot;=2E</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+## Maintainer-visible changes</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+- The configure-time option `--enable-debug` is no longer =
 available</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  and the=
 verbose logging is now always included unless `--enable-small`</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  is enabled=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # Overview of cha=
nges in 2=2E7</span><br><span> </span><br><span> ## New features</span><br>=
<span>diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span>=
<br><span>index c3bb5a5=2E=2Ec6c0a96 100644</span><br><span>--- a/config=2E=
h=2Ecmake=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><spa=
n>@@ -18,8 +18,8 @@</span><br><span> /* Enable shared data channel offload =
*/</span><br><span> #cmakedefine ENABLE_DCO</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/* Enable debugging support (needed=
 for verb&gt;=3D4) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define ENABLE_DEBUG 1</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Enable debugging support */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#cmakedefine ENABLE_DEBUG</span><br><span> </span><br><span> =
/* Enable internal fragmentation support */</span><br><span> #define ENABLE=
_FRAGMENT 1</span><br><span>diff --git a/configure=2Eac b/configure=2Eac</s=
pan><br><span>index 469a475=2E=2E1fa0e63 100644</span><br><span>--- a/confi=
gure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -130,10 +=
130,10 @@</span><br><span> )</span><br><span> </span><br><span> AC_ARG_ENAB=
LE(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[debug],</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	[AS_HELP_STRING([--disable-de=
bug], [disable debugging support (disable gremlin and verb 7+ messages) @&l=
t;:@default=3Dyes@:&gt;@])],</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[enable_deb=
ug=3D&quot;yes&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	[developer-debug],</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	[AS_HELP_STRING([--enable-developer-debug], [enable developer debugging =
support (enable gremlin) @&lt;:@default=3Dno@:&gt;@])],</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	[enable_debug=3D&quot;yes&quot;],</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	[enable_debug=3D&quot;n=
o&quot;]</span><br><span> )</span><br><span> </span><br><span> AC_ARG_ENABL=
E(</span><br><span>@@ -1393,3 +1393,8 @@</span><br><span> ])</span><br><spa=
n> AC_CONFIG_FILES([tests/t_client=2Esh], [chmod +x tests/t_client=2Esh])</=
span><br><span> AC_OUTPUT</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Put the war=
ning at the end, so it is better visible</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+if test &quot;${enable_debug}&quot; =3D &quot;yes&quot=
;; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    AC_MSG_W=
ARN([--enable-developer-debug is enabled=2E This should be only used for te=
st/development builds and not for production usage])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span>\ No newline at end of=
 file</span><br><span>diff --git a/dev-tools/cppcheck-suppression b/dev-too=
ls/cppcheck-suppression</span><br><span>index 299d7a3=2E=2E27c9d30 100644</=
span><br><span>--- a/dev-tools/cppcheck-suppression</span><br><span>+++ b/d=
ev-tools/cppcheck-suppression</span><br><span>@@ -42,7 +42,7 @@</span><br><=
span> intToPointerCast:src/openvpn/multi_io=2Ec</span><br><span> intToPoint=
erCast:src/openvpn/ps=2Ec</span><br><span> # FP: constant but differs betwe=
en platforms</span><br><span style=3D"color: hsl(0, 100%, 40%);">-knownCond=
itionTrueFalse:src/openvpn/error=2Eh:380</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+knownConditionTrueFalse:src/openvpn/error=2Eh:382</spa=
n><br><span> knownConditionTrueFalse:src/openvpn/fdmisc=2Ec:80</span><br><s=
pan> knownConditionTrueFalse:src/openvpn/lladdr=2Ec:64</span><br><span> kno=
wnConditionTrueFalse:src/openvpn/platform=2Ec</span><br><span>@@ -73,8 +73,=
8 @@</span><br><span> # FP: cppcheck doesn&#39;t understand ZeroMemory</spa=
n><br><span> redundantAssignment:src/openvpnserv/interactive=2Ec:204</span>=
<br><span> # IGN: We reuse the same variable name due to macro usage</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-shadowVariable:src/openvpn/o=
ptions=2Ec:1948</span><br><span style=3D"color: hsl(0, 100%, 40%);">-shadow=
Variable:src/openvpn/options=2Ec:1966</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+shadowVariable:src/openvpn/options=2Ec:1955</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+shadowVariable:src/openvpn/option=
s=2Ec:1973</span><br><span> # FP: fun:tls_crypt_v2_wrap_unwrap_invalid: cpp=
check is confused</span><br><span> syntaxError:tests/unit_tests/openvpn/tes=
t_tls_crypt=2Ec:684</span><br><span> # FP: this file is never compiled on _=
WIN32</span><br><span>diff --git a/dev-tools/openvpn-cppcheck-library=2Ecfg=
 b/dev-tools/openvpn-cppcheck-library=2Ecfg</span><br><span>index 1ea91f4=
=2E=2Edecac67 100644</span><br><span>--- a/dev-tools/openvpn-cppcheck-libra=
ry=2Ecfg</span><br><span>+++ b/dev-tools/openvpn-cppcheck-library=2Ecfg</sp=
an><br><span>@@ -26,4 +26,6 @@</span><br><span>   &lt;!-- work around macro=
 confusion --&gt;</span><br><span>   &lt;define name=3D&quot;CMSG_FIRSTHDR&=
quot; value=3D&quot;cmsg_firsthdr&quot; /&gt;</span><br><span>   &lt;define=
 name=3D&quot;CMSG_NXTHDR&quot; value=3D&quot;cmsg_nxthdr&quot; /&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- otherwise a lot=
 of unused variables are shown for enable-small builds --&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  &lt;define name=3D&quot;DMSG_AL=
WAYS_AVAILABLE&quot; value=3D&quot;1&quot; /&gt;</span><br><span> &lt;/def&=
gt;</span><br><span>diff --git a/src/openvpn/compstub=2Ec b/src/openvpn/com=
pstub=2Ec</span><br><span>index f0c89f7=2E=2E2eef587 100644</span><br><span=
>--- a/src/openvpn/compstub=2Ec</span><br><span>+++ b/src/openvpn/compstub=
=2Ec</span><br><span>@@ -125,7 +125,7 @@</span><br><span>         return;</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    uint8_t *head =3D BPTR(buf);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const uint8_t *head =3D BPTR(buf);</span=
><br><span> </span><br><span>     /* no compression or packet to short*/</s=
pan><br><span>     if (head[0] !=3D COMP_ALGV2_INDICATOR_BYTE)</span><br><s=
pan>diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtl=
s=2Ec</span><br><span>index 0c5beb4=2E=2E05bb60d 100644</span><br><span>---=
 a/src/openvpn/crypto_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/crypto_=
mbedtls=2Ec</span><br><span>@@ -842,8 +842,8 @@</span><br><span>     struct=
 gc_arena gc =3D gc_new();</span><br><span>     uint8_t A1[MAX_HMAC_KEY_LEN=
GTH];</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid un=
used</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_=
SMALL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* used by=
 the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unused</span><br=
><span>      * variables warnings if compiled with --enable-small */</span>=
<br><span>     const size_t olen_orig =3D olen;</span><br><span>     const =
uint8_t *out_orig =3D out;</span><br><span>diff --git a/src/openvpn/crypto_=
mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>=
index bbd012f6=2E=2Ef46d8bf 100644</span><br><span>--- a/src/openvpn/crypto=
_mbedtls_legacy=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtls_legacy=
=2Ec</span><br><span>@@ -989,8 +989,8 @@</span><br><span>     struct gc_are=
na gc =3D gc_new();</span><br><span>     uint8_t A1[MAX_HMAC_KEY_LENGTH];</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifde=
f ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* =
used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unused</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* used by the D_=
SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unused</span><br><span>=
      * variables warnings if compiled with --enable-small */</span><br><sp=
an>     const size_t olen_orig =3D olen;</span><br><span>     const uint8_t=
 *out_orig =3D out;</span><br><span>diff --git a/src/openvpn/error=2Eh b/sr=
c/openvpn/error=2Eh</span><br><span>index a887fc7=2E=2E9f39572 100644</span=
><br><span>--- a/src/openvpn/error=2Eh</span><br><span>+++ b/src/openvpn/er=
ror=2Eh</span><br><span>@@ -158,7 +158,9 @@</span><br><span>         }     =
                           \</span><br><span>         EXIT_FATAL(flags);   =
            \</span><br><span>     } while (false)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* We have DMSG_ALWAYS_AVAILABLE here to able =
to silence unused warnings for</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * cppcheck */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if !defined(ENABLE_SMALL) || defined(DMSG_ALWAYS_AVAILABLE)</span><b=
r><span> #define dmsg(flags, =2E=2E=2E)                 \</span><br><span> =
    do                                   \</span><br><span>     {          =
                          \</span><br><span>diff --git a/src/openvpn/event=
=2Ec b/src/openvpn/event=2Ec</span><br><span>index 8b7716a=2E=2E2cb4e04 100=
644</span><br><span>--- a/src/openvpn/event=2Ec</span><br><span>+++ b/src/o=
penvpn/event=2Ec</span><br><span>@@ -398,7 +398,7 @@</span><br><span> </spa=
n><br><span>     dmsg(D_EVENT_WAIT, &quot;WE_WAIT enter n=3D%d to=3D%d&quot=
;, wes-&gt;n_events, timeout);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (ch=
eck_debug_level(D_EVENT_WAIT))</span><br><span>     {</span><br><span>     =
    int i;</span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openv=
pn/forward=2Ec</span><br><span>index 6fe5849=2E=2Ea8a4a07 100644</span><br>=
<span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forwa=
rd=2Ec</span><br><span>@@ -50,7 +50,7 @@</span><br><span> </span><br><span>=
 /* show event wait debugging info */</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> </s=
pan><br><span> static const char *</span><br><span> wait_status_string(stru=
ct context *c, struct gc_arena *gc)</span><br><span>@@ -75,7 +75,7 @@</span=
><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_DEB=
UG */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span> </span><br><span> static void</span><br><span> check_tls_errors_c=
o(struct context *c)</span><br><span>@@ -2190,7 +2190,7 @@</span><br><span>=
         {</span><br><span>             int status;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span>=
<br><span>             if (check_debug_level(D_EVENT_WAIT))</span><br><span=
>             {</span><br><span>                 show_wait_status(c);</span=
><br><span>diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec</sp=
an><br><span>index 39fa482=2E=2E261d25a 100644</span><br><span>--- a/src/op=
envpn/mroute=2Ec</span><br><span>+++ b/src/openvpn/mroute=2Ec</span><br><sp=
an>@@ -501,7 +501,7 @@</span><br><span>     }</span><br><span>     mh-&gt;n=
_net_len =3D j;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check_debug_level=
(D_MULTI_DEBUG))</span><br><span>     {</span><br><span>         struct gc_=
arena gc =3D gc_new();</span><br><span>diff --git a/src/openvpn/mtcp=2Ec b/=
src/openvpn/mtcp=2Ec</span><br><span>index 5d88f8a=2E=2Eb0125f1 100644</spa=
n><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn/mt=
cp=2Ec</span><br><span>@@ -74,7 +74,7 @@</span><br><span>         mi-&gt;di=
d_real_hash =3D true;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><sp=
an>     if (mi)</span><br><span>     {</span><br><span>         dmsg(D_MULT=
I_DEBUG, &quot;MULTI TCP: instance added: %s&quot;, mroute_addr_print(&amp;=
mi-&gt;real, &amp;gc));</span><br><span>diff --git a/src/openvpn/mudp=2Ec b=
/src/openvpn/mudp=2Ec</span><br><span>index 88b0091=2E=2E4794b7e 100644</sp=
an><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/m=
udp=2Ec</span><br><span>@@ -431,7 +431,7 @@</span><br><span>         }</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check_debug_le=
vel(D_MULTI_DEBUG))</span><br><span>     {</span><br><span>         struct =
gc_arena gc =3D gc_new();</span><br><span>diff --git a/src/openvpn/multi=2E=
c b/src/openvpn/multi=2Ec</span><br><span>index 3e72b92=2E=2E67204c3 100644=
</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/open=
vpn/multi=2Ec</span><br><span>@@ -1145,7 +1145,7 @@</span><br><span>       =
  }</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check_=
debug_level(D_MULTI_DEBUG))</span><br><span>     {</span><br><span>        =
 struct gc_arena gc =3D gc_new();</span><br><span>diff --git a/src/openvpn/=
multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index 3604684=2E=2E=
4b96c57 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><sp=
an>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -46,7 +46,7 @@</span><=
br><span> #define MULTI_IO_FILE_CLOSE_WRITE ((void *)5)</span><br><span> #d=
efine MULTI_IO_DCO              ((void *)6)</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><spa=
n> static const char *</span><br><span> pract(int action)</span><br><span> =
{</span><br><span>@@ -89,7 +89,7 @@</span><br><span>             return &qu=
ot;?&quot;;</span><br><span>     }</span><br><span> }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_DEBUG */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><s=
pan> static inline struct context *</span><br><span> multi_get_context(stru=
ct multi_context *m, struct multi_instance *mi)</span><br><span>diff --git =
a/src/openvpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec</span><br><span>index 2=
4d6bb6=2E=2Eacd366d 100644</span><br><span>--- a/src/openvpn/openvpn=2Ec</s=
pan><br><span>+++ b/src/openvpn/openvpn=2Ec</span><br><span>@@ -252,6 +252,=
8 @@</span><br><span> #endif</span><br><span>             show_library_vers=
ions(M_INFO);</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            show_debug_warning(M_INFO);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             show_dco_ve=
rsion(M_INFO);</span><br><span> </span><br><span>             /* misc stuff=
 */</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/opti=
ons=2Ec</span><br><span>index e3cd527=2E=2E3c5a249 100644</span><br><span>-=
-- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec<=
/span><br><span>@@ -113,9 +113,16 @@</span><br><span> #ifdef ENABLE_DCO</sp=
an><br><span>     &quot; [DCO]&quot;</span><br><span> #endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_SMALL</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &quot; [SMALL]&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot; [DEBUG]&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> #ifdef CONFI=
GURE_GIT_REVISION</span><br><span>     &quot; built on &quot; __DATE__</spa=
n><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span>     ;</span><br><span> </span><br><span> #ifndef ENABLE_S=
MALL</span><br><span>@@ -785,7 +792,7 @@</span><br><span> #endif /* ENABLE_=
PKCS11 */</span><br><span>     &quot;\n&quot;</span><br><span>     &quot;Ge=
neral Standalone Options:\n&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     &quot;--show-gateway =
[address]: Show info about gateway [to v4/v6 address]=2E\n&quot;</span><br>=
<span> #endif</span><br><span>     ;</span><br><span>@@ -3534,6 +3541,9 @@<=
/span><br><span>     msg(M_INFO | M_NOPREFIX, &quot;special build: %s&quot;=
, CONFIGURE_SPECIAL_BUILD);</span><br><span> #endif</span><br><span> #endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    show_debug_warning(M_INFO | M_NOPR=
EFIX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     openvpn_exit(OPENVPN_EXIT_STATUS_GOOD);</span><br><span> }</span><=
br><span> </span><br><span>@@ -4229,7 +4239,7 @@</span><br><span>         r=
ead_config_file(options, p[1], level, file, line, msglevel, permission_mask=
,</span><br><span>                          option_types_found, es);</span>=
<br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if d=
efined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>   =
  else if (streq(p[0], &quot;show-gateway&quot;) &amp;&amp; !p[2])</span><b=
r><span>     {</span><br><span>         struct route_gateway_info rgi;</spa=
n><br><span>@@ -4938,12 +4948,13 @@</span><br><span>              * mbed TL=
S always generating debug level logging */</span><br><span>             opt=
ions-&gt;ssl_flags |=3D SSLF_TLS_DEBUG_ENABLED;</span><br><span>         }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(ENABLE_DE=
BUG) &amp;&amp; !defined(ENABLE_SMALL)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#ifdef ENABLE_SMALL</span><br><span>         /* Warn whe=
n a debug verbosity is supplied when built without debug support */</span><=
br><span>         if (options-&gt;verbosity &gt;=3D 7)</span><br><span>    =
     {</span><br><span>             msg(M_WARN,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                &quot;NOTE: debug verbosity (--ve=
rb %d) is enabled but this build lacks debug support=2E&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                &quot;NOTE: debu=
g verbosity (--verb %d) is enabled but this build is &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                &quot;built with --=
enable-small that lacks support for high --verb settings&quot;,</span><br><=
span>                 options-&gt;verbosity);</span><br><span>         }</s=
pan><br><span> #endif</span><br><span>diff --git a/src/openvpn/options=2Eh =
b/src/openvpn/options=2Eh</span><br><span>index f472676=2E=2E31ae17b 100644=
</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/op=
envpn/options=2Eh</span><br><span>@@ -888,6 +888,16 @@</span><br><span> </s=
pan><br><span> void show_library_versions(const unsigned int flags);</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static i=
nline void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_debu=
g_warning(const unsigned int flags)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
fdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  msg(flags, &quot;WARNING: OpenVPN has been compiled with --enable-develop=
er-debug=2E &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
              &quot;This should be only used for test/development builds an=
d not for &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
            &quot;production usage&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> #ifdef _WIN32</span><br><span> void show_windows_version(const un=
signed int flags);</span><br><span> </span><br><span>diff --git a/src/openv=
pn/packet_id=2Ec b/src/openvpn/packet_id=2Ec</span><br><span>index a4b627c=
=2E=2E22c53c7 100644</span><br><span>--- a/src/openvpn/packet_id=2Ec</span>=
<br><span>+++ b/src/openvpn/packet_id=2Ec</span><br><span>@@ -52,18 +52,18 =
@@</span><br><span> #define SEQ_UNSEEN  ((time_t)0)</span><br><span> #defin=
e SEQ_EXPIRED ((time_t)1)</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> static void pac=
ket_id_debug_print(msglvl_t msglevel, const struct packet_id_rec *p,</span>=
<br><span>                                   const struct packet_id_net *pi=
n, const char *message,</span><br><span>                                   =
packet_id_print_type value);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif /* ENABLE_DEBUG */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> st=
atic inline void</span><br><span> packet_id_debug(msglvl_t msglevel, const =
struct packet_id_rec *p,</span><br><span>                 const struct pack=
et_id_net *pin, const char *message, uint64_t value)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</spa=
n><br><span>     if (unlikely(check_debug_level(msglevel)))</span><br><span=
>     {</span><br><span>         packet_id_debug_print(msglevel, p, pin, me=
ssage, value);</span><br><span>@@ -576,7 +576,7 @@</span><br><span>     ret=
urn (char *)out=2Edata;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span=
> </span><br><span> static void</span><br><span> packet_id_debug_print(msgl=
vl_t msglevel, const struct packet_id_rec *p,</span><br><span>@@ -648,7 +64=
8,7 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifde=
f ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span> </span><br><span> uint16_t</span><br><span> packet_id=
_read_epoch(struct packet_id_net *pin, struct buffer *buf)</span><br><span>=
diff --git a/src/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec</span><br><spa=
n>index f8adde5=2E=2Ea94f07b 100644</span><br><span>--- a/src/openvpn/plugi=
n=2Ec</span><br><span>+++ b/src/openvpn/plugin=2Ec</span><br><span>@@ -993,=
7 +993,7 @@</span><br><span>     pr-&gt;n =3D 0;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENAB=
LE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENA=
BLE_SMALL</span><br><span> void</span><br><span> plugin_return_print(const =
msglvl_t msglevel, const char *prefix, const struct plugin_return *pr)</spa=
n><br><span> {</span><br><span>@@ -1012,5 +1012,5 @@</span><br><span>      =
   }</span><br><span>     }</span><br><span> }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_DEBUG */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> #endif /* ENAB=
LE_PLUGIN */</span><br><span>diff --git a/src/openvpn/plugin=2Eh b/src/open=
vpn/plugin=2Eh</span><br><span>index 7e9faf3=2E=2E684632c 100644</span><br>=
<span>--- a/src/openvpn/plugin=2Eh</span><br><span>+++ b/src/openvpn/plugin=
=2Eh</span><br><span>@@ -135,7 +135,7 @@</span><br><span> </span><br><span>=
 void plugin_return_free(struct plugin_return *pr);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span>=
<br><span> void plugin_return_print(const msglvl_t msglevel, const char *pr=
efix, const struct plugin_return *pr);</span><br><span> </span><br><span> #=
endif</span><br><span>diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/r=
eliable=2Ec</span><br><span>index ced438e=2E=2Eb5315ff 100644</span><br><sp=
an>--- a/src/openvpn/reliable=2Ec</span><br><span>+++ b/src/openvpn/reliabl=
e=2Ec</span><br><span>@@ -462,7 +462,7 @@</span><br><span>     }</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifndef ENABLE_SMALL</span><br><span> /* print the current sequence of=
 active packet IDs */</span><br><span> static const char *</span><br><span>=
 reliable_print_ids(const struct reliable *rel, struct gc_arena *gc)</span>=
<br><span>@@ -480,7 +480,7 @@</span><br><span>     }</span><br><span>     r=
eturn BSTR(&amp;out);</span><br><span> }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif /* ENABLE_DEBUG */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> /* true =
if at least one free buffer available */</span><br><span> bool</span><br><s=
pan>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><s=
pan>index 03a2526=2E=2Ee8001b3 100644</span><br><span>--- a/src/openvpn/rou=
te=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -81,7=
 +81,7 @@</span><br><span> </span><br><span> static void get_bypass_address=
es(struct route_bypass *rb, const unsigned int flags);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</sp=
an><br><span> </span><br><span> static void</span><br><span> print_bypass_a=
ddresses(const struct route_bypass *rb)</span><br><span>@@ -617,7 +617,7 @@=
</span><br><span>     if (rl-&gt;ngi=2Eflags &amp; RGI_ADDR_DEFINED)</span>=
<br><span>     {</span><br><span>         setenv_route_addr(es, &quot;net_g=
ateway&quot;, rl-&gt;ngi=2Egateway=2Eaddr, -1);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if defined(ENABLE_DEBUG) &amp;&amp; !defined(ENA=
BLE_SMALL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef E=
NABLE_SMALL</span><br><span>         print_default_gateway(D_ROUTE, &amp;rl=
-&gt;rgi, NULL);</span><br><span> #endif</span><br><span>     }</span><br><=
span>@@ -660,7 +660,7 @@</span><br><span>             add_block_local_route=
s(rl);</span><br><span>         }</span><br><span>         get_bypass_addre=
sses(&amp;rl-&gt;spec=2Ebypass, rl-&gt;flags);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>         prin=
t_bypass_addresses(&amp;rl-&gt;spec=2Ebypass);</span><br><span> #endif</spa=
n><br><span>     }</span><br><span>@@ -768,7 +768,7 @@</span><br><span>    =
 if (rl6-&gt;ngi6=2Eflags &amp; RGI_ADDR_DEFINED)</span><br><span>     {</s=
pan><br><span>         setenv_str(es, &quot;net_gateway_ipv6&quot;, print_i=
n6_addr(rl6-&gt;ngi6=2Egateway=2Eaddr_ipv6, 0, &amp;gc));</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DEBUG) &amp;&amp; !d=
efined(ENABLE_SMALL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifndef ENABLE_SMALL</span><br><span>         print_default_gateway(D_ROUT=
E, NULL, &amp;rl6-&gt;rgi6);</span><br><span> #endif</span><br><span>     }=
</span><br><span>diff --git a/src/openvpn/schedule=2Ec b/src/openvpn/schedu=
le=2Ec</span><br><span>index 6772ad6=2E=2E6c60dc2 100644</span><br><span>--=
- a/src/openvpn/schedule=2Ec</span><br><span>+++ b/src/openvpn/schedule=2Ec=
</span><br><span>@@ -33,7 +33,7 @@</span><br><span> </span><br><span> #incl=
ude &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> static void</s=
pan><br><span> schedule_entry_debug_info(const char *caller, const struct s=
chedule_entry *e)</span><br><span> {</span><br><span>@@ -308,7 +308,7 @@</s=
pan><br><span> void</span><br><span> schedule_add_modify(struct schedule *s=
, struct schedule_entry *e)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (chec=
k_debug_level(D_SCHEDULER))</span><br><span>     {</span><br><span>        =
 schedule_entry_debug_info(&quot;schedule_add_modify&quot;, e);</span><br><=
span>@@ -355,7 +355,7 @@</span><br><span>         }</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def ENABLE_SMALL</span><br><span>     if (check_debug_level(D_SCHEDULER))</=
span><br><span>     {</span><br><span>         schedule_entry_debug_info(&q=
uot;schedule_find_least&quot;, e);</span><br><span>diff --git a/src/tapctl/=
error=2Eh b/src/tapctl/error=2Eh</span><br><span>index f9586dc=2E=2E4424f56=
 100644</span><br><span>--- a/src/tapctl/error=2Eh</span><br><span>+++ b/sr=
c/tapctl/error=2Eh</span><br><span>@@ -83,19 +83,6 @@</span><br><span>     =
    }                                \</span><br><span>         EXIT_FATAL(=
flags);               \</span><br><span>     } while (false)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define dmsg(flags, =2E=2E=2E)        =
         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    do     =
                              \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {                                    \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (msg_test(flags))             \<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {             =
                   \</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           x_msg((flags), __VA_ARGS__); \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }                                \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        EXIT_FATAL(flags);        =
       \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    } while (=
false)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define dmsg(flags, =2E=2E=2E)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
> </span><br><span> void x_msg(const unsigned int flags, const char *format=
, =2E=2E=2E); /* should be called via msg above */</span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3De=
mail">change 1942</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1942?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1942 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--ioiRKlZXzNk=--


--===============6768015672972280953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6768015672972280953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6768015672972280953==--

