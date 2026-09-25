Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7584FC9830D
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 14:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oseu4gNpuKjuiwATWPgXK17/eEwdjgIS6wE8vemiIv8=; b=NrYbe4Hl6Y7o19ImnBd7VFvWGA
	H1YJ1A/2g1VSlhUb9VVbImzxehEYrpQYKfI1N6ZLg30ThSnes+cpG0u9wdf9aSQEI3SV82NKkHPru
	1pYZ0Bnn2K75rNviLzuv+ygQqxHXrRlTO5ogS+aJyPJB4kphtV+E/TfPARqKa6It9w/o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA72C-0004n7-1V;
	Fri, 25 Sep 2026 14:36:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA72A-0004mt-El
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 14:36:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2nNvvs3vUcqpWD9Z9RmjNPXT8umFnnQmdP7YlS6o4dk=; b=P1KH4F7c25kpbc3cchS68nwo7R
 fooUadiVyzihekzhLZxYo8lcBKcHbzSzS+nBwsbU/67RbHesfSxei4Ye0LBRpNkRJdXipIlfzn0ln
 ZA1xts5UP/qCeVDfeEz19JDScXZqzOJTi/t43P7SpRKoENMhtx0i6V4y1s0eyXu2Ddas=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2nNvvs3vUcqpWD9Z9RmjNPXT8umFnnQmdP7YlS6o4dk=; b=F
 HQP2vLGLZR7p7WUBhHY/v0jduVZ0/nAae301JeyBzfP6iAT5XG52zuxwSLhYZf8alfkhYFOo1NZos
 fONQMOs72sj0uHlG0MpvkBA5b2TTLdxCV7sUTuOYCh9aSNfaBw8WL6Y+dSHmqNIgFh3uYAxsqOx1q
 R0ORP/0p/KTFxF/I=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA726-0000ZM-Pc for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 14:36:19 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843f22dcb8so775520f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790346968; x=1790951768; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2nNvvs3vUcqpWD9Z9RmjNPXT8umFnnQmdP7YlS6o4dk=;
 b=RXbtrkmaFNv0FoCBWwdUYtZtjAwuguPFGue9JnjUwdzaMeeJb8jmDbTrUbLTjEDFOz
 Hs1lNsd2cl7GIAjO9EGJjier0HnJe4IZMCV9ubgichvqdYO407SlcNjO+RrF7ZPnFfjk
 laWZd8xxjTSLWLksUNiboZiDPBeiMZumXBuzEAJMLoY7lWaBSOApQTn5zsGluvtL8dDr
 DtCP240SvzelCpahWPfOgwq/pR3w5R0bT0Y0VkB/M4V3yEWOWqWo/gkNcHeoC7ZeZKDD
 CxW6E13HhD8T/v/7iRNGQdjjrNAKa0RjIdpAFaodHM1+Ky290avf3hxT7Vu7mtQmbD+H
 OyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790346968; x=1790951768;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2nNvvs3vUcqpWD9Z9RmjNPXT8umFnnQmdP7YlS6o4dk=;
 b=mBXoPFGCkDounOXGruvYkK5KNCsswgHBCC2fNe23VhHBL4Cf7CT9mMQ4LfJuJJgt49
 DlT5yija3iHrwEHMf2/N8MkWh0dOR1zhEnpDWouioJHbvMII0TzKjaP2sStSGYn1JPam
 rF3BxrvfCn+TCkmrckZFtVw/NdcJ0w/t2GMwLWx2ExMe7K6e/2TeunmDL2Oh1olWIctq
 pTWw6xYyzIAYdryn+z+0Wlii48CQLYvVQknbvyNQztwsy5fmEppqHsw4Hep5bxapjLNX
 cyKn26XUZZkEY/nCJyY/dPDAINRpr6hnPAu3ZM9kGnlhgw7VIQa/sh12UH6VTDLGynQH
 8yzg==
X-Gm-Message-State: AFuF++mWgDYjNyeTGDndGKnQZvR6oCKpsZv+zvH8UdRE1gWbLnE3oBZr
 ZQ3G9mrIDZC8IYIv5Gwe88DewJzkPhM1PkugtC0d/95/epuoGmok9qUuwBYkDJZb/Jg4h0/5SlZ
 aH1VKc6wnvWXd6BTfbjjwDdvhAvjY6W6ywlCZNl9v+8dEJlL++pbMtq6/11X9ZH2m6ntBYtdQtR
 I/bci+RQ==
X-Gm-Gg: AYBFou0X+igcoJ0fEvXfEL0AnNl+SDMx9DmS18/bdhLENHGfSGTf259uAPJk4u9JTjr
 ajhE88qR39MAoEIKEd2CiK8DYrPb5uvGIlH5UxyIN4mLwA5M6e/q0D7jNBIRG1uP3GARqhu5Vcn
 IbQIAkX3DwCxM3QOcz9euNR6cWgs2tLl/7l6WwOoYCv6OuTI+AYUAC/3XUlzdIdAzC8N5WUu7Df
 JnAYhBwcv9ln4QftisNXstRV+U9GYj+FCLauSrjdzmn8ORuC5fEWUzhtrU1DpgB6jmIoGa9BJim
 03KdigbIsGDNzvbDvtFfRQWwf7jNGd45Wka864b1xa65+GjwYfh/POELid5b8p6sRllxIOu85ke
 ZsnEfI4DFUoXL3tATior+LqpaTxsIAQTTPQBpFgVJdl7TdYOXpKVFUiRavA2RjaqOVv6PBtXhaP
 cSr2wyhTwE8GtM+PDsh98cNc2efWsKy3N2dvwT8cs4lokbZVl29IK22d2GMnS9WzxEbu6l1/Y5T
 9VIdWhxVw6AE0xXLq18Nd1vhivin7J2cNoqshR/BSL99mEu8qHsAP1ShDZgbROrBK2pBMMOmH0b
 1XXJ++U98OwnlDUqezNvBqT2RpjcC83KfNhi7Gz8Iov/IhoJlAXJvFfLPEk1iq6wFE/VtBA=
X-Received: by 2002:a05:600c:8b6e:b0:49c:fc6e:8cbb with SMTP id
 5b1f17b1804b1-49fe66f9fe3mr104984045e9.31.1790346967841; 
 Fri, 25 Sep 2026 07:36:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ff06b4d45sm67230695e9.7.2026.09.25.07.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 07:36:06 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 14:36:05 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: 91be564f67196b38c2f41323a0e0e113746068b5
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e086ce638183da7c2f6e0b6ccea3459202d1481e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA726-0000ZM-Pc
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
Content-Type: multipart/mixed; boundary="===============7174373174336307659=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7174373174336307659==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WIqHdKsD+oo="; charset=UTF-8

--WIqHdKsD+oo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#11) to the change originally created b=
y plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail=
 )

The following approvals got outdated and were removed:
Code-Review+2 by=
 flichtenheld


Change subject: Change most ENABLE_DEBUG ifdefs to ifndef E=
NABLE_SMALL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

C=
hange most ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL

Most of these are ve=
rbose logging or even enable logging at high
verbosity level or just useful=
 tools like --show-gateway=2E

We had --enabled-debug on by default forever=
, so these "debug"
logs are on by default=2E This patch instead moves them =
to
enable-small=2E

Since the verbose logging is now always enabled
(apart =
from --enable-small), --enable-debug now only covers true
debug options lik=
e gremlin=2E

Rename the configure option from --enable-debug to
--enable-d=
eveloper-debug to ensure existing build
script/maintainer do not enable thi=
s option
by default=2E

This patch also adds [SMALL] and [DEBUG] as identif=
ier in the OpenVPN
version string more easily identify builds with this fea=
ture=2E

In addition both configure and openvpn itself will add a warning
a=
bout --enable-developer-debug to discourage users and maintainers
from enab=
ling this feature=2E

Remove dmsg macro from tapctl's error=2Eh since it do=
es
not use that macro at all=2E

Change-Id: I3f96cd1c3488b558b8a597594d99ed=
cba1214d27
Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Acked-b=
y: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1942
Message-Id: <20260925122231=2E5805-1-gert=
@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg39490=2Ehtml
Signed-off-by: Gert Doering <gert@g=
reenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M Changes=2Emd
M config=2Eh=2Ecma=
ke=2Ein
M configure=2Eac
M dev-tools/cppcheck-suppression
M dev-tools/openv=
pn-cppcheck-library=2Ecfg
M src/openvpn/compstub=2Ec
M src/openvpn/crypto_m=
bedtls=2Ec
M src/openvpn/crypto_mbedtls_legacy=2Ec
M src/openvpn/error=2Eh
=
M src/openvpn/event=2Ec
M src/openvpn/forward=2Ec
M src/openvpn/mroute=2Ec
=
M src/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src=
/openvpn/multi_io=2Ec
M src/openvpn/openvpn=2Ec
M src/openvpn/options=2Ec
M=
 src/openvpn/options=2Eh
M src/openvpn/packet_id=2Ec
M src/openvpn/plugin=
=2Ec
M src/openvpn/plugin=2Eh
M src/openvpn/reliable=2Ec
M src/openvpn/rout=
e=2Ec
M src/openvpn/schedule=2Ec
M src/tapctl/error=2Eh
27 files changed, 8=
5 insertions(+), 59 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/42/1942/11

diff --git a/CMakeLists=2Etxt b/CMak=
eLists=2Etxt
index 6eb5954=2E=2Ed553697 100644
--- a/CMakeLists=2Etxt
+++ b=
/CMakeLists=2Etxt
@@ -40,6 +40,7 @@
 option(ENABLE_PKCS11 "BUILD with pkcs1=
1-helper" ON)
 option(USE_WERROR "Treat compiler warnings as errors (-Werro=
r)" ON)
 option(FAKE_ANDROID "Target Android but do not use actual cross co=
mpile/Android cmake to build for simple compile checks on Linux")
+option(E=
NABLE_DEBUG "Enable building with debug" OFF)
 
 option(ENABLE_DNS_UPDOWN_B=
Y_DEFAULT "Run --dns-updown hook by default" ON)
 set(DNS_UPDOWN_PATH "${CM=
AKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown" CACHE STRING "Default locat=
ion for the DNS up/down script")
diff --git a/Changes=2Emd b/Changes=2Emd
i=
ndex 2684251=2E=2E5c3270b 100644
--- a/Changes=2Emd
+++ b/Changes=2Emd
@@ -=
23,6 +23,12 @@
   the characters mentioned above were already escaped=2E Ho=
wever, the behavior of
   Mbed TLS is slightly different from OpenSSL in th=
at it also escapes "=3D"=2E
 
+## Maintainer-visible changes
+
+- The confi=
gure-time option `--enable-debug` is no longer  available
+  and the verbos=
e logging is now always included unless `--enable-small`
+  is enabled=2E
+=

 # Overview of changes in 2=2E7
 
 ## New features
diff --git a/config=2Eh=
=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index c3bb5a5=2E=2Ec6c0a96 100644
-=
-- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -18,8 +18,8 @=
@
 /* Enable shared data channel offload */
 #cmakedefine ENABLE_DCO
 
-/* =
Enable debugging support (needed for verb>=3D4) */
-#define ENABLE_DEBUG 1
=
+/* Enable debugging support */
+#cmakedefine ENABLE_DEBUG
 
 /* Enable int=
ernal fragmentation support */
 #define ENABLE_FRAGMENT 1
diff --git a/conf=
igure=2Eac b/configure=2Eac
index 469a475=2E=2E1fa0e63 100644
--- a/configu=
re=2Eac
+++ b/configure=2Eac
@@ -130,10 +130,10 @@
 )
 
 AC_ARG_ENABLE(
-	[=
debug],
-	[AS_HELP_STRING([--disable-debug], [disable debugging support (di=
sable gremlin and verb 7+ messages) @<:@default=3Dyes@:>@])],
-	,
-	[enable=
_debug=3D"yes"]
+	[developer-debug],
+	[AS_HELP_STRING([--enable-developer-=
debug], [enable developer debugging support (enable gremlin) @<:@default=3D=
no@:>@])],
+	[enable_debug=3D"yes"],
+	[enable_debug=3D"no"]
 )
 
 AC_ARG_E=
NABLE(
@@ -1393,3 +1393,8 @@
 ])
 AC_CONFIG_FILES([tests/t_client=2Esh], [c=
hmod +x tests/t_client=2Esh])
 AC_OUTPUT
+
+# Put the warning at the end, s=
o it is better visible
+if test "${enable_debug}" =3D "yes"; then
+    AC_M=
SG_WARN([--enable-developer-debug is enabled=2E This should be only used fo=
r test/development builds and not for production usage])
+fi
\ No newline a=
t end of file
diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppch=
eck-suppression
index 299d7a3=2E=2E27c9d30 100644
--- a/dev-tools/cppcheck-=
suppression
+++ b/dev-tools/cppcheck-suppression
@@ -42,7 +42,7 @@
 intToPo=
interCast:src/openvpn/multi_io=2Ec
 intToPointerCast:src/openvpn/ps=2Ec
 # =
FP: constant but differs between platforms
-knownConditionTrueFalse:src/ope=
nvpn/error=2Eh:380
+knownConditionTrueFalse:src/openvpn/error=2Eh:382
 know=
nConditionTrueFalse:src/openvpn/fdmisc=2Ec:80
 knownConditionTrueFalse:src/=
openvpn/lladdr=2Ec:64
 knownConditionTrueFalse:src/openvpn/platform=2Ec
@@ =
-73,8 +73,8 @@
 # FP: cppcheck doesn't understand ZeroMemory
 redundantAssi=
gnment:src/openvpnserv/interactive=2Ec:204
 # IGN: We reuse the same variab=
le name due to macro usage
-shadowVariable:src/openvpn/options=2Ec:1948
-sh=
adowVariable:src/openvpn/options=2Ec:1966
+shadowVariable:src/openvpn/optio=
ns=2Ec:1955
+shadowVariable:src/openvpn/options=2Ec:1973
 # FP: fun:tls_cry=
pt_v2_wrap_unwrap_invalid: cppcheck is confused
 syntaxError:tests/unit_tes=
ts/openvpn/test_tls_crypt=2Ec:684
 # FP: this file is never compiled on _WI=
N32
diff --git a/dev-tools/openvpn-cppcheck-library=2Ecfg b/dev-tools/openv=
pn-cppcheck-library=2Ecfg
index 1ea91f4=2E=2Edecac67 100644
--- a/dev-tools=
/openvpn-cppcheck-library=2Ecfg
+++ b/dev-tools/openvpn-cppcheck-library=2E=
cfg
@@ -26,4 +26,6 @@
   <!-- work around macro confusion -->
   <define na=
me=3D"CMSG_FIRSTHDR" value=3D"cmsg_firsthdr" />
   <define name=3D"CMSG_NXT=
HDR" value=3D"cmsg_nxthdr" />
+  <!-- otherwise a lot of unused variables a=
re shown for enable-small builds -->
+  <define name=3D"DMSG_ALWAYS_AVAILAB=
LE" value=3D"1" />
 </def>
diff --git a/src/openvpn/compstub=2Ec b/src/open=
vpn/compstub=2Ec
index f0c89f7=2E=2E2eef587 100644
--- a/src/openvpn/compst=
ub=2Ec
+++ b/src/openvpn/compstub=2Ec
@@ -125,7 +125,7 @@
         return;
=
     }
 
-    uint8_t *head =3D BPTR(buf);
+    const uint8_t *head =3D BPT=
R(buf);
 
     /* no compression or packet to short*/
     if (head[0] !=3D=
 COMP_ALGV2_INDICATOR_BYTE)
diff --git a/src/openvpn/crypto_mbedtls=2Ec b/s=
rc/openvpn/crypto_mbedtls=2Ec
index 0c5beb4=2E=2E05bb60d 100644
--- a/src/o=
penvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/crypto_mbedtls=2Ec
@@ -842,8 +8=
42,8 @@
     struct gc_arena gc =3D gc_new();
     uint8_t A1[MAX_HMAC_KEY_=
LENGTH];
 
-#ifdef ENABLE_DEBUG
-    /* used by the D_SHOW_KEY_SOURCE, guar=
ded with ENABLE_DEBUG to avoid unused
+#ifndef ENABLE_SMALL
+    /* used by=
 the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unused
      * v=
ariables warnings if compiled with --enable-small */
     const size_t olen=
_orig =3D olen;
     const uint8_t *out_orig =3D out;
diff --git a/src/open=
vpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec
index=
 bbd012f6=2E=2Ef46d8bf 100644
--- a/src/openvpn/crypto_mbedtls_legacy=2Ec
+=
++ b/src/openvpn/crypto_mbedtls_legacy=2Ec
@@ -989,8 +989,8 @@
     struct =
gc_arena gc =3D gc_new();
     uint8_t A1[MAX_HMAC_KEY_LENGTH];
 
-#ifdef E=
NABLE_DEBUG
-    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBU=
G to avoid unused
+#ifndef ENABLE_SMALL
+    /* used by the D_SHOW_KEY_SOUR=
CE, guarded with ENABLE_SMALL to avoid unused
      * variables warnings if=
 compiled with --enable-small */
     const size_t olen_orig =3D olen;
    =
 const uint8_t *out_orig =3D out;
diff --git a/src/openvpn/error=2Eh b/src/=
openvpn/error=2Eh
index a887fc7=2E=2E9f39572 100644
--- a/src/openvpn/error=
=2Eh
+++ b/src/openvpn/error=2Eh
@@ -158,7 +158,9 @@
         }            =
                    \
         EXIT_FATAL(flags);               \
     } wh=
ile (false)
-#ifdef ENABLE_DEBUG
+/* We have DMSG_ALWAYS_AVAILABLE here to =
able to silence unused warnings for
+ * cppcheck */
+#if !defined(ENABLE_SM=
ALL) || defined(DMSG_ALWAYS_AVAILABLE)
 #define dmsg(flags, =2E=2E=2E)     =
            \
     do                                   \
     {           =
                         \
diff --git a/src/openvpn/event=2Ec b/src/openvpn=
/event=2Ec
index 8b7716a=2E=2E2cb4e04 100644
--- a/src/openvpn/event=2Ec
++=
+ b/src/openvpn/event=2Ec
@@ -398,7 +398,7 @@
 
     dmsg(D_EVENT_WAIT, "WE=
_WAIT enter n=3D%d to=3D%d", wes->n_events, timeout);
 
-#ifdef ENABLE_DEBU=
G
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_EVENT_WAIT))
     {
  =
       int i;
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2E=
c
index 6fe5849=2E=2Ea8a4a07 100644
--- a/src/openvpn/forward=2Ec
+++ b/src=
/openvpn/forward=2Ec
@@ -50,7 +50,7 @@
 
 /* show event wait debugging info=
 */
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 
 static const char *
 wa=
it_status_string(struct context *c, struct gc_arena *gc)
@@ -75,7 +75,7 @@
=
     gc_free(&gc);
 }
 
-#endif /* ifdef ENABLE_DEBUG */
+#endif
 
 static =
void
 check_tls_errors_co(struct context *c)
@@ -2190,7 +2190,7 @@
        =
 {
             int status;
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
  =
           if (check_debug_level(D_EVENT_WAIT))
             {
            =
     show_wait_status(c);
diff --git a/src/openvpn/mroute=2Ec b/src/openvpn=
/mroute=2Ec
index 39fa482=2E=2E261d25a 100644
--- a/src/openvpn/mroute=2Ec
=
+++ b/src/openvpn/mroute=2Ec
@@ -501,7 +501,7 @@
     }
     mh->n_net_len =
=3D j;
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_le=
vel(D_MULTI_DEBUG))
     {
         struct gc_arena gc =3D gc_new();
diff -=
-git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index 5d88f8a=2E=2Eb0125=
f1 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -74,7 +7=
4,7 @@
         mi->did_real_hash =3D true;
     }
 
-#ifdef ENABLE_DEBUG
+=
#ifndef ENABLE_SMALL
     if (mi)
     {
         dmsg(D_MULTI_DEBUG, "MULT=
I TCP: instance added: %s", mroute_addr_print(&mi->real, &gc));
diff --git =
a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 88b0091=2E=2E4794b7e 10=
0644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -431,7 +431,7=
 @@
         }
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if =
(check_debug_level(D_MULTI_DEBUG))
     {
         struct gc_arena gc =3D g=
c_new();
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 3=
e72b92=2E=2E67204c3 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/mu=
lti=2Ec
@@ -1145,7 +1145,7 @@
         }
     }
 
-#ifdef ENABLE_DEBUG
+#if=
ndef ENABLE_SMALL
     if (check_debug_level(D_MULTI_DEBUG))
     {
       =
  struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/multi_io=2Ec b/=
src/openvpn/multi_io=2Ec
index 3604684=2E=2E4b96c57 100644
--- a/src/openvp=
n/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -46,7 +46,7 @@
 #define MU=
LTI_IO_FILE_CLOSE_WRITE ((void *)5)
 #define MULTI_IO_DCO              ((vo=
id *)6)
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 static const char *
 =
pract(int action)
 {
@@ -89,7 +89,7 @@
             return "?";
     }
 }
-=
#endif /* ENABLE_DEBUG */
+#endif
 
 static inline struct context *
 multi_=
get_context(struct multi_context *m, struct multi_instance *mi)
diff --git =
a/src/openvpn/openvpn=2Ec b/src/openvpn/openvpn=2Ec
index 24d6bb6=2E=2Eacd3=
66d 100644
--- a/src/openvpn/openvpn=2Ec
+++ b/src/openvpn/openvpn=2Ec
@@ -=
252,6 +252,8 @@
 #endif
             show_library_versions(M_INFO);
 
+    =
        show_debug_warning(M_INFO);
+
             show_dco_version(M_INFO)=
;
 
             /* misc stuff */
diff --git a/src/openvpn/options=2Ec b/sr=
c/openvpn/options=2Ec
index e3cd527=2E=2E3c5a249 100644
--- a/src/openvpn/o=
ptions=2Ec
+++ b/src/openvpn/options=2Ec
@@ -113,9 +113,16 @@
 #ifdef ENABL=
E_DCO
     " [DCO]"
 #endif
+#ifdef ENABLE_SMALL
+    " [SMALL]"
+#endif
+#=
ifdef ENABLE_DEBUG
+    " [DEBUG]"
+#endif
 #ifdef CONFIGURE_GIT_REVISION
 =
    " built on " __DATE__
 #endif
+
     ;
 
 #ifndef ENABLE_SMALL
@@ -785,=
7 +792,7 @@
 #endif /* ENABLE_PKCS11 */
     "\n"
     "General Standalone =
Options:\n"
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     "--show-gateway=
 [address]: Show info about gateway [to v4/v6 address]=2E\n"
 #endif
     ;=

@@ -3534,6 +3541,9 @@
     msg(M_INFO | M_NOPREFIX, "special build: %s", C=
ONFIGURE_SPECIAL_BUILD);
 #endif
 #endif
+
+    show_debug_warning(M_INFO |=
 M_NOPREFIX);
+
     openvpn_exit(OPENVPN_EXIT_STATUS_GOOD);
 }
 
@@ -4229,=
7 +4239,7 @@
         read_config_file(options, p[1], level, file, line, ms=
glevel, permission_mask,
                          option_types_found, es);=

     }
-#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifndef ENABL=
E_SMALL
     else if (streq(p[0], "show-gateway") && !p[2])
     {
        =
 struct route_gateway_info rgi;
@@ -4938,12 +4948,13 @@
              * mbe=
d TLS always generating debug level logging */
             options->ssl_fl=
ags |=3D SSLF_TLS_DEBUG_ENABLED;
         }
-#if !defined(ENABLE_DEBUG) && =
!defined(ENABLE_SMALL)
+#ifdef ENABLE_SMALL
         /* Warn when a debug v=
erbosity is supplied when built without debug support */
         if (optio=
ns->verbosity >=3D 7)
         {
             msg(M_WARN,
-                =
"NOTE: debug verbosity (--verb %d) is enabled but this build lacks debug su=
pport=2E",
+                "NOTE: debug verbosity (--verb %d) is enabled b=
ut this build is "
+                "built with --enable-small that lacks s=
upport for high --verb settings",
                 options->verbosity);
   =
      }
 #endif
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=
=2Eh
index f472676=2E=2E31ae17b 100644
--- a/src/openvpn/options=2Eh
+++ b/=
src/openvpn/options=2Eh
@@ -888,6 +888,16 @@
 
 void show_library_versions(=
const unsigned int flags);
 
+static inline void
+show_debug_warning(const =
unsigned int flags)
+{
+#ifdef ENABLE_DEBUG
+    msg(flags, "WARNING: OpenV=
PN has been compiled with --enable-developer-debug=2E "
+               "Th=
is should be only used for test/development builds and not for "
+         =
      "production usage");
+#endif
+}
+
 #ifdef _WIN32
 void show_windows_v=
ersion(const unsigned int flags);
 
diff --git a/src/openvpn/packet_id=2Ec =
b/src/openvpn/packet_id=2Ec
index a4b627c=2E=2E22c53c7 100644
--- a/src/ope=
nvpn/packet_id=2Ec
+++ b/src/openvpn/packet_id=2Ec
@@ -52,18 +52,18 @@
 #de=
fine SEQ_UNSEEN  ((time_t)0)
 #define SEQ_EXPIRED ((time_t)1)
 
-#ifdef ENA=
BLE_DEBUG
+#ifndef ENABLE_SMALL
 static void packet_id_debug_print(msglvl_t=
 msglevel, const struct packet_id_rec *p,
                                 =
  const struct packet_id_net *pin, const char *message,
                   =
                packet_id_print_type value);
 
-#endif /* ENABLE_DEBUG */
+=
#endif
 
 static inline void
 packet_id_debug(msglvl_t msglevel, const stru=
ct packet_id_rec *p,
                 const struct packet_id_net *pin, cons=
t char *message, uint64_t value)
 {
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SM=
ALL
     if (unlikely(check_debug_level(msglevel)))
     {
         packet_=
id_debug_print(msglevel, p, pin, message, value);
@@ -576,7 +576,7 @@
     =
return (char *)out=2Edata;
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
=
 
 static void
 packet_id_debug_print(msglvl_t msglevel, const struct packe=
t_id_rec *p,
@@ -648,7 +648,7 @@
     gc_free(&gc);
 }
 
-#endif /* ifdef E=
NABLE_DEBUG */
+#endif
 
 uint16_t
 packet_id_read_epoch(struct packet_id_n=
et *pin, struct buffer *buf)
diff --git a/src/openvpn/plugin=2Ec b/src/open=
vpn/plugin=2Ec
index f8adde5=2E=2Ea94f07b 100644
--- a/src/openvpn/plugin=
=2Ec
+++ b/src/openvpn/plugin=2Ec
@@ -993,7 +993,7 @@
     pr->n =3D 0;
 }
=
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 void
 plugin_return_print(con=
st msglvl_t msglevel, const char *prefix, const struct plugin_return *pr)
 =
{
@@ -1012,5 +1012,5 @@
         }
     }
 }
-#endif /* ifdef ENABLE_DEBUG =
*/
+#endif
 #endif /* ENABLE_PLUGIN */
diff --git a/src/openvpn/plugin=2Eh =
b/src/openvpn/plugin=2Eh
index 7e9faf3=2E=2E684632c 100644
--- a/src/openvp=
n/plugin=2Eh
+++ b/src/openvpn/plugin=2Eh
@@ -135,7 +135,7 @@
 
 void plugi=
n_return_free(struct plugin_return *pr);
 
-#ifdef ENABLE_DEBUG
+#ifndef EN=
ABLE_SMALL
 void plugin_return_print(const msglvl_t msglevel, const char *p=
refix, const struct plugin_return *pr);
 
 #endif
diff --git a/src/openvpn/=
reliable=2Ec b/src/openvpn/reliable=2Ec
index ced438e=2E=2Eb5315ff 100644
-=
-- a/src/openvpn/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -462,7 +462=
,7 @@
     }
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 /* print the =
current sequence of active packet IDs */
 static const char *
 reliable_pri=
nt_ids(const struct reliable *rel, struct gc_arena *gc)
@@ -480,7 +480,7 @@=

     }
     return BSTR(&out);
 }
-#endif /* ENABLE_DEBUG */
+#endif
 
 /*=
 true if at least one free buffer available */
 bool
diff --git a/src/openv=
pn/route=2Ec b/src/openvpn/route=2Ec
index 03a2526=2E=2Ee8001b3 100644
--- =
a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -81,7 +81,7 @@
 
 st=
atic void get_bypass_addresses(struct route_bypass *rb, const unsigned int =
flags);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 
 static void
 print_=
bypass_addresses(const struct route_bypass *rb)
@@ -617,7 +617,7 @@
     if=
 (rl->ngi=2Eflags & RGI_ADDR_DEFINED)
     {
         setenv_route_addr(es,=
 "net_gateway", rl->ngi=2Egateway=2Eaddr, -1);
-#if defined(ENABLE_DEBUG) &=
& !defined(ENABLE_SMALL)
+#ifndef ENABLE_SMALL
         print_default_gatew=
ay(D_ROUTE, &rl->rgi, NULL);
 #endif
     }
@@ -660,7 +660,7 @@
           =
  add_block_local_routes(rl);
         }
         get_bypass_addresses(&rl-=
>spec=2Ebypass, rl->flags);
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
    =
     print_bypass_addresses(&rl->spec=2Ebypass);
 #endif
     }
@@ -768,7 +=
768,7 @@
     if (rl6->ngi6=2Eflags & RGI_ADDR_DEFINED)
     {
         set=
env_str(es, "net_gateway_ipv6", print_in6_addr(rl6->ngi6=2Egateway=2Eaddr_i=
pv6, 0, &gc));
-#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifnde=
f ENABLE_SMALL
         print_default_gateway(D_ROUTE, NULL, &rl6->rgi6);
 =
#endif
     }
diff --git a/src/openvpn/schedule=2Ec b/src/openvpn/schedule=
=2Ec
index 6772ad6=2E=2E6c60dc2 100644
--- a/src/openvpn/schedule=2Ec
+++ b=
/src/openvpn/schedule=2Ec
@@ -33,7 +33,7 @@
 
 #include "memdbg=2Eh"
 
-#if=
def ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 static void
 schedule_entry_debug_i=
nfo(const char *caller, const struct schedule_entry *e)
 {
@@ -308,7 +308,7=
 @@
 void
 schedule_add_modify(struct schedule *s, struct schedule_entry *e=
)
 {
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(=
D_SCHEDULER))
     {
         schedule_entry_debug_info("schedule_add_modif=
y", e);
@@ -355,7 +355,7 @@
         }
     }
 
-#ifdef ENABLE_DEBUG
+#ifnd=
ef ENABLE_SMALL
     if (check_debug_level(D_SCHEDULER))
     {
         sc=
hedule_entry_debug_info("schedule_find_least", e);
diff --git a/src/tapctl/=
error=2Eh b/src/tapctl/error=2Eh
index f9586dc=2E=2E4424f56 100644
--- a/sr=
c/tapctl/error=2Eh
+++ b/src/tapctl/error=2Eh
@@ -83,19 +83,6 @@
         }=
                                \
         EXIT_FATAL(flags);              =
 \
     } while (false)
-#ifdef ENABLE_DEBUG
-#define dmsg(flags, =2E=2E=2E=
)                 \
-    do                                   \
-    {     =
                               \
-        if (msg_test(flags))             =
\
-        {                                \
-            x_msg((flags), _=
_VA_ARGS__); \
-        }                                \
-        EXIT_FA=
TAL(flags);               \
-    } while (false)
-#else
-#define dmsg(flags=
, =2E=2E=2E)
-#endif
 
 void x_msg(const unsigned int flags, const char *fo=
rmat, =2E=2E=2E); /* should be called via msg above */
 

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1=
214d27
Gerrit-Change-Number: 1942
Gerrit-PatchSet: 11
Gerrit-Owner: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>

--WIqHdKsD+oo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #11</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Change most ENABLE_D=
EBUG ifdefs to ifndef ENABLE_SMALL<br><br>Most of these are verbose logging=
 or even enable logging at high<br>verbosity level or just useful tools lik=
e --show-gateway=2E<br><br>We had --enabled-debug on by default forever, so=
 these &quot;debug&quot;<br>logs are on by default=2E This patch instead mo=
ves them to<br>enable-small=2E<br><br>Since the verbose logging is now alwa=
ys enabled<br>(apart from --enable-small), --enable-debug now only covers t=
rue<br>debug options like gremlin=2E<br><br>Rename the configure option fro=
m --enable-debug to<br>--enable-developer-debug to ensure existing build<br=
>script/maintainer do not enable this option<br>by default=2E<br><br>This p=
atch also adds [SMALL] and [DEBUG] as identifier in the OpenVPN<br>version =
string more easily identify builds with this feature=2E<br><br>In addition =
both configure and openvpn itself will add a warning<br>about --enable-deve=
loper-debug to discourage users and maintainers<br>from enabling this featu=
re=2E<br><br>Remove dmsg macro from tapctl&#39;s error=2Eh since it does<br=
>not use that macro at all=2E<br><br>Change-Id: I3f96cd1c3488b558b8a597594d=
99edcba1214d27<br>Signed-off-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942<br>Message-Id: &lt=
;20260925122231=2E5805-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39490=2Ehtml<=
br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =
CMakeLists=2Etxt<br>M Changes=2Emd<br>M config=2Eh=2Ecmake=2Ein<br>M config=
ure=2Eac<br>M dev-tools/cppcheck-suppression<br>M dev-tools/openvpn-cppchec=
k-library=2Ecfg<br>M src/openvpn/compstub=2Ec<br>M src/openvpn/crypto_mbedt=
ls=2Ec<br>M src/openvpn/crypto_mbedtls_legacy=2Ec<br>M src/openvpn/error=2E=
h<br>M src/openvpn/event=2Ec<br>M src/openvpn/forward=2Ec<br>M src/openvpn/=
mroute=2Ec<br>M src/openvpn/mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M src/ope=
nvpn/multi=2Ec<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/openvpn=2Ec<b=
r>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/p=
acket_id=2Ec<br>M src/openvpn/plugin=2Ec<br>M src/openvpn/plugin=2Eh<br>M s=
rc/openvpn/reliable=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvpn/schedul=
e=2Ec<br>M src/tapctl/error=2Eh<br>27 files changed, 85 insertions(+), 59 d=
eletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/42/1942/11</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Et=
xt b/CMakeLists=2Etxt</span><br><span>index 6eb5954=2E=2Ed553697 100644</sp=
an><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt<=
/span><br><span>@@ -40,6 +40,7 @@</span><br><span> option(ENABLE_PKCS11 &qu=
ot;BUILD with pkcs11-helper&quot; ON)</span><br><span> option(USE_WERROR &q=
uot;Treat compiler warnings as errors (-Werror)&quot; ON)</span><br><span> =
option(FAKE_ANDROID &quot;Target Android but do not use actual cross compil=
e/Android cmake to build for simple compile checks on Linux&quot;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+option(ENABLE_DEBUG &quot;En=
able building with debug&quot; OFF)</span><br><span> </span><br><span> opti=
on(ENABLE_DNS_UPDOWN_BY_DEFAULT &quot;Run --dns-updown hook by default&quot=
; ON)</span><br><span> set(DNS_UPDOWN_PATH &quot;${CMAKE_INSTALL_PREFIX}/li=
bexec/openvpn/dns-updown&quot; CACHE STRING &quot;Default location for the =
DNS up/down script&quot;)</span><br><span>diff --git a/Changes=2Emd b/Chang=
es=2Emd</span><br><span>index 2684251=2E=2E5c3270b 100644</span><br><span>-=
-- a/Changes=2Emd</span><br><span>+++ b/Changes=2Emd</span><br><span>@@ -23=
,6 +23,12 @@</span><br><span>   the characters mentioned above were already=
 escaped=2E However, the behavior of</span><br><span>   Mbed TLS is slightl=
y different from OpenSSL in that it also escapes &quot;=3D&quot;=2E</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+## Mainta=
iner-visible changes</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- The configure-ti=
me option `--enable-debug` is no longer  available</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  and the verbose logging is now always incl=
uded unless `--enable-small`</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  is enabled=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> # Overview of changes in 2=2E7</span><br><span> </sp=
an><br><span> ## New features</span><br><span>diff --git a/config=2Eh=2Ecma=
ke=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>index c3bb5a5=2E=2Ec6c0a9=
6 100644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ =
b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -18,8 +18,8 @@</span><br><span=
> /* Enable shared data channel offload */</span><br><span> #cmakedefine EN=
ABLE_DCO</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-/* Enable debugging support (needed for verb&gt;=3D4) */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define ENABLE_DEBUG 1</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* Enable debugging support */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine ENABLE_D=
EBUG</span><br><span> </span><br><span> /* Enable internal fragmentation su=
pport */</span><br><span> #define ENABLE_FRAGMENT 1</span><br><span>diff --=
git a/configure=2Eac b/configure=2Eac</span><br><span>index 469a475=2E=2E1f=
a0e63 100644</span><br><span>--- a/configure=2Eac</span><br><span>+++ b/con=
figure=2Eac</span><br><span>@@ -130,10 +130,10 @@</span><br><span> )</span>=
<br><span> </span><br><span> AC_ARG_ENABLE(</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	[debug],</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	[AS_HELP_STRING([--disable-debug], [disable debugging support (d=
isable gremlin and verb 7+ messages) @&lt;:@default=3Dyes@:&gt;@])],</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	[enable_debug=3D&quot;yes&quot;]</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	[developer-debug],</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	[AS_HELP_STRING([--enable-develo=
per-debug], [enable developer debugging support (enable gremlin) @&lt;:@def=
ault=3Dno@:&gt;@])],</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	[enable_debug=3D&quot;yes&quot;],</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	[enable_debug=3D&quot;no&quot;]</span><br><span> )</span><=
br><span> </span><br><span> AC_ARG_ENABLE(</span><br><span>@@ -1393,3 +1393=
,8 @@</span><br><span> ])</span><br><span> AC_CONFIG_FILES([tests/t_client=
=2Esh], [chmod +x tests/t_client=2Esh])</span><br><span> AC_OUTPUT</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# Put the warning at the end, so it is better v=
isible</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if test &quot=
;${enable_debug}&quot; =3D &quot;yes&quot;; then</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    AC_MSG_WARN([--enable-developer-debug is e=
nabled=2E This should be only used for test/development builds and not for =
production usage])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+f=
i</span><br><span>\ No newline at end of file</span><br><span>diff --git a/=
dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression</span><br><=
span>index 299d7a3=2E=2E27c9d30 100644</span><br><span>--- a/dev-tools/cppc=
heck-suppression</span><br><span>+++ b/dev-tools/cppcheck-suppression</span=
><br><span>@@ -42,7 +42,7 @@</span><br><span> intToPointerCast:src/openvpn/=
multi_io=2Ec</span><br><span> intToPointerCast:src/openvpn/ps=2Ec</span><br=
><span> # FP: constant but differs between platforms</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn/error=
=2Eh:380</span><br><span style=3D"color: hsl(120, 100%, 40%);">+knownCondit=
ionTrueFalse:src/openvpn/error=2Eh:382</span><br><span> knownConditionTrueF=
alse:src/openvpn/fdmisc=2Ec:80</span><br><span> knownConditionTrueFalse:src=
/openvpn/lladdr=2Ec:64</span><br><span> knownConditionTrueFalse:src/openvpn=
/platform=2Ec</span><br><span>@@ -73,8 +73,8 @@</span><br><span> # FP: cppc=
heck doesn&#39;t understand ZeroMemory</span><br><span> redundantAssignment=
:src/openvpnserv/interactive=2Ec:204</span><br><span> # IGN: We reuse the s=
ame variable name due to macro usage</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-shadowVariable:src/openvpn/options=2Ec:1948</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-shadowVariable:src/openvpn/options=2Ec=
:1966</span><br><span style=3D"color: hsl(120, 100%, 40%);">+shadowVariable=
:src/openvpn/options=2Ec:1955</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+shadowVariable:src/openvpn/options=2Ec:1973</span><br><span> # FP=
: fun:tls_crypt_v2_wrap_unwrap_invalid: cppcheck is confused</span><br><spa=
n> syntaxError:tests/unit_tests/openvpn/test_tls_crypt=2Ec:684</span><br><s=
pan> # FP: this file is never compiled on _WIN32</span><br><span>diff --git=
 a/dev-tools/openvpn-cppcheck-library=2Ecfg b/dev-tools/openvpn-cppcheck-li=
brary=2Ecfg</span><br><span>index 1ea91f4=2E=2Edecac67 100644</span><br><sp=
an>--- a/dev-tools/openvpn-cppcheck-library=2Ecfg</span><br><span>+++ b/dev=
-tools/openvpn-cppcheck-library=2Ecfg</span><br><span>@@ -26,4 +26,6 @@</sp=
an><br><span>   &lt;!-- work around macro confusion --&gt;</span><br><span>=
   &lt;define name=3D&quot;CMSG_FIRSTHDR&quot; value=3D&quot;cmsg_firsthdr&=
quot; /&gt;</span><br><span>   &lt;define name=3D&quot;CMSG_NXTHDR&quot; va=
lue=3D&quot;cmsg_nxthdr&quot; /&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  &lt;!-- otherwise a lot of unused variables are shown for=
 enable-small builds --&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  &lt;define name=3D&quot;DMSG_ALWAYS_AVAILABLE&quot; value=3D&quot=
;1&quot; /&gt;</span><br><span> &lt;/def&gt;</span><br><span>diff --git a/s=
rc/openvpn/compstub=2Ec b/src/openvpn/compstub=2Ec</span><br><span>index f0=
c89f7=2E=2E2eef587 100644</span><br><span>--- a/src/openvpn/compstub=2Ec</s=
pan><br><span>+++ b/src/openvpn/compstub=2Ec</span><br><span>@@ -125,7 +125=
,7 @@</span><br><span>         return;</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *head=
 =3D BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const uint8_t *head =3D BPTR(buf);</span><br><span> </span><br><span>     /=
* no compression or packet to short*/</span><br><span>     if (head[0] !=3D=
 COMP_ALGV2_INDICATOR_BYTE)</span><br><span>diff --git a/src/openvpn/crypto=
_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>index 0c5beb4=
=2E=2E05bb60d 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls=2Ec</=
span><br><span>+++ b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -842=
,8 +842,8 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span><b=
r><span>     uint8_t A1[MAX_HMAC_KEY_LENGTH];</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    /* used by the D_SHOW_KEY_SOURC=
E, guarded with ENABLE_DEBUG to avoid unused</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* used by the D_SHOW_KEY_SOURCE, guarded wit=
h ENABLE_SMALL to avoid unused</span><br><span>      * variables warnings i=
f compiled with --enable-small */</span><br><span>     const size_t olen_or=
ig =3D olen;</span><br><span>     const uint8_t *out_orig =3D out;</span><b=
r><span>diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/cr=
ypto_mbedtls_legacy=2Ec</span><br><span>index bbd012f6=2E=2Ef46d8bf 100644<=
/span><br><span>--- a/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span=
>+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>@@ -989,8 +989=
,8 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span=
>     uint8_t A1[MAX_HMAC_KEY_LENGTH];</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /* used by the D_SHOW_KEY_SOURCE, guar=
ded with ENABLE_DEBUG to avoid unused</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABL=
E_SMALL to avoid unused</span><br><span>      * variables warnings if compi=
led with --enable-small */</span><br><span>     const size_t olen_orig =3D =
olen;</span><br><span>     const uint8_t *out_orig =3D out;</span><br><span=
>diff --git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh</span><br><span=
>index a887fc7=2E=2E9f39572 100644</span><br><span>--- a/src/openvpn/error=
=2Eh</span><br><span>+++ b/src/openvpn/error=2Eh</span><br><span>@@ -158,7 =
+158,9 @@</span><br><span>         }                                \</span=
><br><span>         EXIT_FATAL(flags);               \</span><br><span>    =
 } while (false)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifde=
f ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* We=
 have DMSG_ALWAYS_AVAILABLE here to able to silence unused warnings for</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * cppcheck */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(ENABLE_SMALL) |=
| defined(DMSG_ALWAYS_AVAILABLE)</span><br><span> #define dmsg(flags, =2E=
=2E=2E)                 \</span><br><span>     do                          =
         \</span><br><span>     {                                    \</spa=
n><br><span>diff --git a/src/openvpn/event=2Ec b/src/openvpn/event=2Ec</spa=
n><br><span>index 8b7716a=2E=2E2cb4e04 100644</span><br><span>--- a/src/ope=
nvpn/event=2Ec</span><br><span>+++ b/src/openvpn/event=2Ec</span><br><span>=
@@ -398,7 +398,7 @@</span><br><span> </span><br><span>     dmsg(D_EVENT_WAI=
T, &quot;WE_WAIT enter n=3D%d to=3D%d&quot;, wes-&gt;n_events, timeout);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnde=
f ENABLE_SMALL</span><br><span>     if (check_debug_level(D_EVENT_WAIT))</s=
pan><br><span>     {</span><br><span>         int i;</span><br><span>diff -=
-git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>in=
dex 6fe5849=2E=2Ea8a4a07 100644</span><br><span>--- a/src/openvpn/forward=
=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -50,7=
 +50,7 @@</span><br><span> </span><br><span> /* show event wait debugging i=
nfo */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef ENABLE_SMALL</span><br><span> </span><br><span> static const cha=
r *</span><br><span> wait_status_string(struct context *c, struct gc_arena =
*gc)</span><br><span>@@ -75,7 +75,7 @@</span><br><span>     gc_free(&amp;gc=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif /* ifdef ENABLE_DEBUG */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> sta=
tic void</span><br><span> check_tls_errors_co(struct context *c)</span><br>=
<span>@@ -2190,7 +2190,7 @@</span><br><span>         {</span><br><span>    =
         int status;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>             if (chec=
k_debug_level(D_EVENT_WAIT))</span><br><span>             {</span><br><span=
>                 show_wait_status(c);</span><br><span>diff --git a/src/ope=
nvpn/mroute=2Ec b/src/openvpn/mroute=2Ec</span><br><span>index 39fa482=2E=
=2E261d25a 100644</span><br><span>--- a/src/openvpn/mroute=2Ec</span><br><s=
pan>+++ b/src/openvpn/mroute=2Ec</span><br><span>@@ -501,7 +501,7 @@</span>=
<br><span>     }</span><br><span>     mh-&gt;n_net_len =3D j;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEB=
UG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SM=
ALL</span><br><span>     if (check_debug_level(D_MULTI_DEBUG))</span><br><s=
pan>     {</span><br><span>         struct gc_arena gc =3D gc_new();</span>=
<br><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><b=
r><span>index 5d88f8a=2E=2Eb0125f1 100644</span><br><span>--- a/src/openvpn=
/mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -74=
,7 +74,7 @@</span><br><span>         mi-&gt;did_real_hash =3D true;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (mi)</span><br><sp=
an>     {</span><br><span>         dmsg(D_MULTI_DEBUG, &quot;MULTI TCP: ins=
tance added: %s&quot;, mroute_addr_print(&amp;mi-&gt;real, &amp;gc));</span=
><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><=
br><span>index 88b0091=2E=2E4794b7e 100644</span><br><span>--- a/src/openvp=
n/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -4=
31,7 +431,7 @@</span><br><span>         }</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_=
DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE=
_SMALL</span><br><span>     if (check_debug_level(D_MULTI_DEBUG))</span><br=
><span>     {</span><br><span>         struct gc_arena gc =3D gc_new();</sp=
an><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</sp=
an><br><span>index 3e72b92=2E=2E67204c3 100644</span><br><span>--- a/src/op=
envpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span=
>@@ -1145,7 +1145,7 @@</span><br><span>         }</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnde=
f ENABLE_SMALL</span><br><span>     if (check_debug_level(D_MULTI_DEBUG))</=
span><br><span>     {</span><br><span>         struct gc_arena gc =3D gc_ne=
w();</span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/mu=
lti_io=2Ec</span><br><span>index 3604684=2E=2E4b96c57 100644</span><br><spa=
n>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=
=2Ec</span><br><span>@@ -46,7 +46,7 @@</span><br><span> #define MULTI_IO_FI=
LE_CLOSE_WRITE ((void *)5)</span><br><span> #define MULTI_IO_DCO           =
   ((void *)6)</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> static const char *</span>=
<br><span> pract(int action)</span><br><span> {</span><br><span>@@ -89,7 +8=
9,7 @@</span><br><span>             return &quot;?&quot;;</span><br><span> =
    }</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif /* ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span> </span><br><span> static inline struct con=
text *</span><br><span> multi_get_context(struct multi_context *m, struct m=
ulti_instance *mi)</span><br><span>diff --git a/src/openvpn/openvpn=2Ec b/s=
rc/openvpn/openvpn=2Ec</span><br><span>index 24d6bb6=2E=2Eacd366d 100644</s=
pan><br><span>--- a/src/openvpn/openvpn=2Ec</span><br><span>+++ b/src/openv=
pn/openvpn=2Ec</span><br><span>@@ -252,6 +252,8 @@</span><br><span> #endif<=
/span><br><span>             show_library_versions(M_INFO);</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+            show_=
debug_warning(M_INFO);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>             show_dco_version(M_INFO);</span><br><span>=
 </span><br><span>             /* misc stuff */</span><br><span>diff --git =
a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index e=
3cd527=2E=2E3c5a249 100644</span><br><span>--- a/src/openvpn/options=2Ec</s=
pan><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -113,9 +113,=
16 @@</span><br><span> #ifdef ENABLE_DCO</span><br><span>     &quot; [DCO]&=
quot;</span><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#ifdef ENABLE_SMALL</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot; [SMALL]&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &quot; [DEBUG]&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span> #ifdef CONFIGURE_GIT_REVISION</span><br><spa=
n>     &quot; built on &quot; __DATE__</span><br><span> #endif</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ;</span><b=
r><span> </span><br><span> #ifndef ENABLE_SMALL</span><br><span>@@ -785,7 +=
792,7 @@</span><br><span> #endif /* ENABLE_PKCS11 */</span><br><span>     &=
quot;\n&quot;</span><br><span>     &quot;General Standalone Options:\n&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL=
</span><br><span>     &quot;--show-gateway [address]: Show info about gatew=
ay [to v4/v6 address]=2E\n&quot;</span><br><span> #endif</span><br><span>  =
   ;</span><br><span>@@ -3534,6 +3541,9 @@</span><br><span>     msg(M_INFO =
| M_NOPREFIX, &quot;special build: %s&quot;, CONFIGURE_SPECIAL_BUILD);</spa=
n><br><span> #endif</span><br><span> #endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    show_debug_warning(M_INFO | M_NOPREFIX);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     openvpn_exit(OPENVPN_EX=
IT_STATUS_GOOD);</span><br><span> }</span><br><span> </span><br><span>@@ -4=
229,7 +4239,7 @@</span><br><span>         read_config_file(options, p[1], l=
evel, file, line, msglevel, permission_mask,</span><br><span>              =
            option_types_found, es);</span><br><span>     }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DEBUG) &amp;&amp; =
!defined(ENABLE_SMALL)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef ENABLE_SMALL</span><br><span>     else if (streq(p[0], &quot;sho=
w-gateway&quot;) &amp;&amp; !p[2])</span><br><span>     {</span><br><span> =
        struct route_gateway_info rgi;</span><br><span>@@ -4938,12 +4948,13=
 @@</span><br><span>              * mbed TLS always generating debug level =
logging */</span><br><span>             options-&gt;ssl_flags |=3D SSLF_TLS=
_DEBUG_ENABLED;</span><br><span>         }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if !defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_=
SMALL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE=
_SMALL</span><br><span>         /* Warn when a debug verbosity is supplied =
when built without debug support */</span><br><span>         if (options-&g=
t;verbosity &gt;=3D 7)</span><br><span>         {</span><br><span>         =
    msg(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          &quot;NOTE: debug verbosity (--verb %d) is enabled but this build=
 lacks debug support=2E&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                &quot;NOTE: debug verbosity (--verb %d) is enabl=
ed but this build is &quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                &quot;built with --enable-small that lacks support =
for high --verb settings&quot;,</span><br><span>                 options-&g=
t;verbosity);</span><br><span>         }</span><br><span> #endif</span><br>=
<span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span>=
<br><span>index f472676=2E=2E31ae17b 100644</span><br><span>--- a/src/openv=
pn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><spa=
n>@@ -888,6 +888,16 @@</span><br><span> </span><br><span> void show_library=
_versions(const unsigned int flags);</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static inline void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+show_debug_warning(const unsigned int fla=
gs)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_DEBUG</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    msg(flags, &quot;WARNING: Open=
VPN has been compiled with --enable-developer-debug=2E &quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+               &quot;This should =
be only used for test/development builds and not for &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+               &quot;production usa=
ge&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef _WIN32</span><b=
r><span> void show_windows_version(const unsigned int flags);</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/packet_id=2Ec b/src/openvpn/p=
acket_id=2Ec</span><br><span>index a4b627c=2E=2E22c53c7 100644</span><br><s=
pan>--- a/src/openvpn/packet_id=2Ec</span><br><span>+++ b/src/openvpn/packe=
t_id=2Ec</span><br><span>@@ -52,18 +52,18 @@</span><br><span> #define SEQ_U=
NSEEN  ((time_t)0)</span><br><span> #define SEQ_EXPIRED ((time_t)1)</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENAB=
LE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENA=
BLE_SMALL</span><br><span> static void packet_id_debug_print(msglvl_t msgle=
vel, const struct packet_id_rec *p,</span><br><span>                       =
            const struct packet_id_net *pin, const char *message,</span><br=
><span>                                   packet_id_print_type value);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /=
* ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span> </span><br><span> static inline void</span><br><span>=
 packet_id_debug(msglvl_t msglevel, const struct packet_id_rec *p,</span><b=
r><span>                 const struct packet_id_net *pin, const char *messa=
ge, uint64_t value)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (unlikely(che=
ck_debug_level(msglevel)))</span><br><span>     {</span><br><span>         =
packet_id_debug_print(msglevel, p, pin, message, value);</span><br><span>@@=
 -576,7 +576,7 @@</span><br><span>     return (char *)out=2Edata;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifndef ENABLE_SMALL</span><br><span> </span><br><span> static void</=
span><br><span> packet_id_debug_print(msglvl_t msglevel, const struct packe=
t_id_rec *p,</span><br><span>@@ -648,7 +648,7 @@</span><br><span>     gc_fr=
ee(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_DEBUG */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br>=
<span> uint16_t</span><br><span> packet_id_read_epoch(struct packet_id_net =
*pin, struct buffer *buf)</span><br><span>diff --git a/src/openvpn/plugin=
=2Ec b/src/openvpn/plugin=2Ec</span><br><span>index f8adde5=2E=2Ea94f07b 10=
0644</span><br><span>--- a/src/openvpn/plugin=2Ec</span><br><span>+++ b/src=
/openvpn/plugin=2Ec</span><br><span>@@ -993,7 +993,7 @@</span><br><span>   =
  pr-&gt;n =3D 0;</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> voi=
d</span><br><span> plugin_return_print(const msglvl_t msglevel, const char =
*prefix, const struct plugin_return *pr)</span><br><span> {</span><br><span=
>@@ -1012,5 +1012,5 @@</span><br><span>         }</span><br><span>     }</s=
pan><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f /* ifdef ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span> #endif /* ENABLE_PLUGIN */</span><br><span>d=
iff --git a/src/openvpn/plugin=2Eh b/src/openvpn/plugin=2Eh</span><br><span=
>index 7e9faf3=2E=2E684632c 100644</span><br><span>--- a/src/openvpn/plugin=
=2Eh</span><br><span>+++ b/src/openvpn/plugin=2Eh</span><br><span>@@ -135,7=
 +135,7 @@</span><br><span> </span><br><span> void plugin_return_free(struc=
t plugin_return *pr);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> void plugin_return_=
print(const msglvl_t msglevel, const char *prefix, const struct plugin_retu=
rn *pr);</span><br><span> </span><br><span> #endif</span><br><span>diff --g=
it a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec</span><br><span>in=
dex ced438e=2E=2Eb5315ff 100644</span><br><span>--- a/src/openvpn/reliable=
=2Ec</span><br><span>+++ b/src/openvpn/reliable=2Ec</span><br><span>@@ -462=
,7 +462,7 @@</span><br><span>     }</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</sp=
an><br><span> /* print the current sequence of active packet IDs */</span><=
br><span> static const char *</span><br><span> reliable_print_ids(const str=
uct reliable *rel, struct gc_arena *gc)</span><br><span>@@ -480,7 +480,7 @@=
</span><br><span>     }</span><br><span>     return BSTR(&amp;out);</span><=
br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* =
ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if</span><br><span> </span><br><span> /* true if at least one free buffer a=
vailable */</span><br><span> bool</span><br><span>diff --git a/src/openvpn/=
route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 03a2526=2E=2Ee8001b=
3 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/=
src/openvpn/route=2Ec</span><br><span>@@ -81,7 +81,7 @@</span><br><span> </=
span><br><span> static void get_bypass_addresses(struct route_bypass *rb, c=
onst unsigned int flags);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> </span><br><spa=
n> static void</span><br><span> print_bypass_addresses(const struct route_b=
ypass *rb)</span><br><span>@@ -617,7 +617,7 @@</span><br><span>     if (rl-=
&gt;ngi=2Eflags &amp; RGI_ADDR_DEFINED)</span><br><span>     {</span><br><s=
pan>         setenv_route_addr(es, &quot;net_gateway&quot;, rl-&gt;ngi=2Ega=
teway=2Eaddr, -1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> =
        print_default_gateway(D_ROUTE, &amp;rl-&gt;rgi, NULL);</span><br><s=
pan> #endif</span><br><span>     }</span><br><span>@@ -660,7 +660,7 @@</spa=
n><br><span>             add_block_local_routes(rl);</span><br><span>      =
   }</span><br><span>         get_bypass_addresses(&amp;rl-&gt;spec=2Ebypas=
s, rl-&gt;flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def ENABLE_SMALL</span><br><span>         print_bypass_addresses(&amp;rl-&g=
t;spec=2Ebypass);</span><br><span> #endif</span><br><span>     }</span><br>=
<span>@@ -768,7 +768,7 @@</span><br><span>     if (rl6-&gt;ngi6=2Eflags &am=
p; RGI_ADDR_DEFINED)</span><br><span>     {</span><br><span>         setenv=
_str(es, &quot;net_gateway_ipv6&quot;, print_in6_addr(rl6-&gt;ngi6=2Egatewa=
y=2Eaddr_ipv6, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><=
br><span>         print_default_gateway(D_ROUTE, NULL, &amp;rl6-&gt;rgi6);<=
/span><br><span> #endif</span><br><span>     }</span><br><span>diff --git a=
/src/openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec</span><br><span>index =
6772ad6=2E=2E6c60dc2 100644</span><br><span>--- a/src/openvpn/schedule=2Ec<=
/span><br><span>+++ b/src/openvpn/schedule=2Ec</span><br><span>@@ -33,7 +33=
,7 @@</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnde=
f ENABLE_SMALL</span><br><span> static void</span><br><span> schedule_entry=
_debug_info(const char *caller, const struct schedule_entry *e)</span><br><=
span> {</span><br><span>@@ -308,7 +308,7 @@</span><br><span> void</span><br=
><span> schedule_add_modify(struct schedule *s, struct schedule_entry *e)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def ENABLE_SMALL</span><br><span>     if (check_debug_level(D_SCHEDULER))</=
span><br><span>     {</span><br><span>         schedule_entry_debug_info(&q=
uot;schedule_add_modify&quot;, e);</span><br><span>@@ -355,7 +355,7 @@</spa=
n><br><span>         }</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><s=
pan>     if (check_debug_level(D_SCHEDULER))</span><br><span>     {</span><=
br><span>         schedule_entry_debug_info(&quot;schedule_find_least&quot;=
, e);</span><br><span>diff --git a/src/tapctl/error=2Eh b/src/tapctl/error=
=2Eh</span><br><span>index f9586dc=2E=2E4424f56 100644</span><br><span>--- =
a/src/tapctl/error=2Eh</span><br><span>+++ b/src/tapctl/error=2Eh</span><br=
><span>@@ -83,19 +83,6 @@</span><br><span>         }                       =
         \</span><br><span>         EXIT_FATAL(flags);               \</spa=
n><br><span>     } while (false)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define dmsg(flags, =2E=2E=2E)                 \</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    do                                 =
  \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {             =
                       \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (msg_test(flags))             \</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        {                                \</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            x_msg((flags), __V=
A_ARGS__); \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }=
                                \</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        EXIT_FATAL(flags);               \</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    } while (false)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define dmsg(flags, =2E=2E=2E)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span> </span><br><span> void x_m=
sg(const unsigned int flags, const char *format, =2E=2E=2E); /* should be c=
alled via msg above */</span><br></pre><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail">change 1942</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f96cd1c348=
8b558b8a597594d99edcba1214d27 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 1942 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: fli=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>

</body></html>
--WIqHdKsD+oo=--


--===============7174373174336307659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7174373174336307659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7174373174336307659==--

