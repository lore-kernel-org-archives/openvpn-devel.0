Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C18AC98314
	for <openvpn-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8uDtLnZnYyslUFEWuQkIlIc5SiqAgIMqHX0lSNn/dv0=; b=Tag9unhzy9b6YQzLKRodTqfcHH
	TISRrmSnNlUdOaR4Y6qi6J9Ba38IOdgJ6UWza3oCyjXDXV96MZtLupmftbTXAVGKx8wEP/K54Dyq8
	zWF92YtppNEzCqSgbzrd1gQLbCXlEBJFLtlEdiVFoBQkFbwe5mQAOvQD85n8VNG21ksM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9iz3-0000zQ-IX;
	Thu, 24 Sep 2026 12:55:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9iz0-0000zH-AA
 for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 12:55:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Nk0MQfIr64Pe/AUCv/DwWxtj4JkPIUqk67zVm6HFUNU=; b=FD994MVGLc9UZuCJ3AI+aHS7iX
 TVsbFRIV6OhDdYUj94pwfEZeeTnvVdI2l9XIL2/1DVpZzdcqsRxUSfBhRgz/HLf5hSwtxlEJAVaQt
 2P2nb9LX9dSjgpkej3obMXHbcQgBAGNpGZpxAed32JOWgcBMnUQe+m2GDa99wEaEHYio=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Nk0MQfIr64Pe/AUCv/DwWxtj4JkPIUqk67zVm6HFUNU=; b=J
 cQ8nnTPn/758ZI6Vn4ip0r3FreKxu0nxgMBy3hv6vqlcOe8UTM+fo8m0j9FYpYHf7uyo50N1ex42i
 dmCMPwA1f7gcwSiwPDOFFo7A/oaCkEQYXrl1l/tjIPA90WRmVttpjJxPiShRxg9c5MJZ9Z6/KVXIj
 e7OJPoexrAkXnIyc=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9iyx-0008Nk-4U for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 12:55:26 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49febbce9afso1559095e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790254516; x=1790859316; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Nk0MQfIr64Pe/AUCv/DwWxtj4JkPIUqk67zVm6HFUNU=;
 b=RPMrfv+Pvd3IKu543jLkS4AqByia+DkyR1pLdMYQGpMMXrsgcwNP7KpkmDcuwHHG9/
 xlzRLlMk0dzUVxaGOrSRg8PKzzsQMFl+vWcR9sPlw+ReQ2cLwZxbED3u8wvyhi5dTfKn
 aSbBb3NQrctSLfwyMivdVNSt025njufejeTuaeTzc/6hK4/svAn6zEb2wUjvRfNZfbs6
 XlAO+brQk/haRDJBx1oU1Tw6VD/KhcaGCkQWOhTSdSLmRADzufAs6AG8PsV9fOsdFkQZ
 tsNB3oqm4Kbn4L/K/Z3CTA3LMMxSzsR6m5jyc1e+AlWrS/POSzay4VRtLU2qqi3+rnwG
 Cyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790254516; x=1790859316;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Nk0MQfIr64Pe/AUCv/DwWxtj4JkPIUqk67zVm6HFUNU=;
 b=IS5q9rYdKC+5fb2JJmO6qnMl6YQyrKVXd6yqU2FZsCa5Vydm1uT6kyvgM93ltbg9b6
 SKbckou0OxVefIZoBUX2Ytwf5j7UYaceXjaqXlUhDQ7hj45S1n0ZDNVSwx2Jv3cANkTi
 CgvlDa2spEAX9MRd1MifujVIgMqNMNVPqOSp0zbo/1Ap46Z3AkD7XcTWDYtnRhtCOzZC
 IZVRv7J2Itr7SEm+Pzcl8Hz3vVDJyvXfchAbYLBBLkWR0gqh91N1h6vXwuOPkHirRwKu
 HSDUmXTwcEuFGhE7oiknVE07YaC/IBIXmNRkXaWafU5K1CIOfFJCKbNdv9oAz7rPIsMy
 r15w==
X-Gm-Message-State: AFuF++lDzFLdia8VIgHZJQ+znrClGk5jIJhR3cdABNsdLKaIG79rgS5A
 oBup+SOnw/NBVnqwByUz6tcXzITo6uwG1MGruvU48tyCvhXXDyv9OF/K/BvNFrNuCw98sCutoj+
 LK8V4f9MoYRm6nBoVxgp08rK/Ecrfmj1ZKBhfejPdFMPEsRDaUuul67a8eAcDFaOTktMLgQVker
 /5UkMSfQ==
X-Gm-Gg: AYBFou1NifKh/NaShtBMCaJjeFnjheavH7DjqPF2+78qg7lNn63j/Ar0tAEMz87FQbR
 VMEEn5Hg5IJkAcdGkP/K4KmvIyVk1Dgq6FaDIs+yUCFV40jW4IIx0peAO8XNM8RXQRfkj6+8oVm
 JtllKfyz0aLuVrhqzSC2UENobmWaBit4w+dMkNZyiZEmKzb9KnfdfOdfAuQ/YCfT68c30LLtuT/
 ofrIykbqOENETbiaaxylBtn9Lq4M4EzZNsBJyICm4tJBIi9wBbCvzlVpt3D3QF9rxmiUfQ67O2q
 swLBNztTkWPD3LU/y2BUix0Oglnkh1OBOUseY93FPuNk7YQ2ThOunjNemoXMhE3cUhqDLOpXRP4
 nTKQCC/bF4wb9U42RC/DREsmVIeNher5qWaDa0mTfAuUgbbU3PK8NNpXCNiH1qe6QCMg2g0FDUv
 o3fEqO16Ix6+tzo7/EagGx6Qg5iPJXrP5/5aCcWbf5iG84eGrZbqGFzbTJbyR4u7vAB2JN8YvET
 uLhqQkRDOk4QGYxPUiJ6lOjN/gEZ6LjATIc2y7PgvMFbzciWj9ew/WZ6q/RYSSU1LeUuPNMY+GT
 vMdPpglTqtzPC65kpsuBU3n2DRXTtSIPxODIH33Dc/vF3h3Gmhi72t7Cf0h99w==
X-Received: by 2002:a05:600c:c492:b0:49d:1f32:c911 with SMTP id
 5b1f17b1804b1-49fe66c867fmr35296165e9.3.1790254516047; 
 Thu, 24 Sep 2026 05:55:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5bae43dsm65386745e9.5.2026.09.24.05.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 05:55:14 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 24 Sep 2026 12:55:13 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: 1b0fd629f80b3eeb32e665223402afc26101581c
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eb0859c66df47067d8b5a9551ab38f8c3ae70300-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9iyx-0008Nk-4U
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0643202432959408294=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0643202432959408294==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0l2JHuPbYv8="; charset=UTF-8

--0l2JHuPbYv8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail

to look at the new pa=
tch set (#10)=2E

The following approvals got outdated and were removed:
Co=
de-Review+2 by flichtenheld


Change subject: Change most ENABLE_DEBUG ifde=
fs to ifndef ENABLE_SMALL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Change most ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL

Most =
of these are verbose logging or even enable logging at high
verbosity level=
 or just useful tools like --show-gateway=2E

We had --enabled-debug on by =
default forever, so these "debug"
logs are on by default=2E This patch inst=
ead moves them to
enable-small=2E

Since the verbose logging is now always =
enabled
(apart from --enable-small), --enable-debug now only covers true
de=
bug options like gremlin=2E

Rename the configure option from --enable-debu=
g to
--enable-developer-debug to ensure existing build
script/maintainer do=
 not enable this option
by default=2E

This patch also adds [SMALL] and [DE=
BUG] as identifier in the OpenVPN
version string more easily identify build=
s with this feature=2E

In addition both configure and openvpn itself will =
add a warning
about --enable-developer-debug to discourage users and mainta=
iners
from enabling this feature=2E

Remove dmsg macro from tapctl's error=
=2Eh since it does
not use that macro at all=2E

Change-Id: I3f96cd1c3488b5=
58b8a597594d99edcba1214d27
---
M CMakeLists=2Etxt
M Changes=2Emd
M config=
=2Eh=2Ecmake=2Ein
M configure=2Eac
M dev-tools/cppcheck-suppression
M dev-t=
ools/openvpn-cppcheck-library=2Ecfg
M src/openvpn/compstub=2Ec
M src/openvp=
n/crypto_mbedtls=2Ec
M src/openvpn/crypto_mbedtls_legacy=2Ec
M src/openvpn/=
error=2Eh
M src/openvpn/event=2Ec
M src/openvpn/forward=2Ec
M src/openvpn/m=
route=2Ec
M src/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=
=2Ec
M src/openvpn/multi_io=2Ec
M src/openvpn/openvpn=2Ec
M src/openvpn/opt=
ions=2Ec
M src/openvpn/options=2Eh
M src/openvpn/packet_id=2Ec
M src/openvp=
n/plugin=2Ec
M src/openvpn/plugin=2Eh
M src/openvpn/reliable=2Ec
M src/open=
vpn/route=2Ec
M src/openvpn/schedule=2Ec
M src/tapctl/error=2Eh
27 files ch=
anged, 85 insertions(+), 59 deletions(-)


  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/42/1942/10

diff --git a/CMakeLists=2Etx=
t b/CMakeLists=2Etxt
index 6eb5954=2E=2Ed553697 100644
--- a/CMakeLists=2Et=
xt
+++ b/CMakeLists=2Etxt
@@ -40,6 +40,7 @@
 option(ENABLE_PKCS11 "BUILD wi=
th pkcs11-helper" ON)
 option(USE_WERROR "Treat compiler warnings as errors=
 (-Werror)" ON)
 option(FAKE_ANDROID "Target Android but do not use actual =
cross compile/Android cmake to build for simple compile checks on Linux")
+=
option(ENABLE_DEBUG "Enable building with debug" OFF)
 
 option(ENABLE_DNS_=
UPDOWN_BY_DEFAULT "Run --dns-updown hook by default" ON)
 set(DNS_UPDOWN_PA=
TH "${CMAKE_INSTALL_PREFIX}/libexec/openvpn/dns-updown" CACHE STRING "Defau=
lt location for the DNS up/down script")
diff --git a/Changes=2Emd b/Change=
s=2Emd
index 2684251=2E=2E5c3270b 100644
--- a/Changes=2Emd
+++ b/Changes=
=2Emd
@@ -23,6 +23,12 @@
   the characters mentioned above were already esc=
aped=2E However, the behavior of
   Mbed TLS is slightly different from Ope=
nSSL in that it also escapes "=3D"=2E
 
+## Maintainer-visible changes
+
+-=
 The configure-time option `--enable-debug` is no longer  available
+  and =
the verbose logging is now always included unless `--enable-small`
+  is en=
abled=2E
+
 # Overview of changes in 2=2E7
 
 ## New features
diff --git a/=
config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index c3bb5a5=2E=2Ec6c0a9=
6 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -18=
,8 +18,8 @@
 /* Enable shared data channel offload */
 #cmakedefine ENABLE_=
DCO
 
-/* Enable debugging support (needed for verb>=3D4) */
-#define ENABL=
E_DEBUG 1
+/* Enable debugging support */
+#cmakedefine ENABLE_DEBUG
 
 /* =
Enable internal fragmentation support */
 #define ENABLE_FRAGMENT 1
diff --=
git a/configure=2Eac b/configure=2Eac
index 469a475=2E=2E1fa0e63 100644
---=
 a/configure=2Eac
+++ b/configure=2Eac
@@ -130,10 +130,10 @@
 )
 
 AC_ARG_E=
NABLE(
-	[debug],
-	[AS_HELP_STRING([--disable-debug], [disable debugging s=
upport (disable gremlin and verb 7+ messages) @<:@default=3Dyes@:>@])],
-	,=

-	[enable_debug=3D"yes"]
+	[developer-debug],
+	[AS_HELP_STRING([--enable-=
developer-debug], [enable developer debugging support (enable gremlin) @<:@=
default=3Dno@:>@])],
+	[enable_debug=3D"yes"],
+	[enable_debug=3D"no"]
 )
 =

 AC_ARG_ENABLE(
@@ -1393,3 +1393,8 @@
 ])
 AC_CONFIG_FILES([tests/t_client=
=2Esh], [chmod +x tests/t_client=2Esh])
 AC_OUTPUT
+
+# Put the warning at =
the end, so it is better visible
+if test "${enable_debug}" =3D "yes"; then=

+    AC_MSG_WARN([--enable-developer-debug is enabled=2E This should be on=
ly used for test/development builds and not for production usage])
+fi
\ No=
 newline at end of file
diff --git a/dev-tools/cppcheck-suppression b/dev-t=
ools/cppcheck-suppression
index 299d7a3=2E=2E27c9d30 100644
--- a/dev-tools=
/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -42,7 +42,7 @=
@
 intToPointerCast:src/openvpn/multi_io=2Ec
 intToPointerCast:src/openvpn/=
ps=2Ec
 # FP: constant but differs between platforms
-knownConditionTrueFal=
se:src/openvpn/error=2Eh:380
+knownConditionTrueFalse:src/openvpn/error=2Eh=
:382
 knownConditionTrueFalse:src/openvpn/fdmisc=2Ec:80
 knownConditionTrue=
False:src/openvpn/lladdr=2Ec:64
 knownConditionTrueFalse:src/openvpn/platfo=
rm=2Ec
@@ -73,8 +73,8 @@
 # FP: cppcheck doesn't understand ZeroMemory
 red=
undantAssignment:src/openvpnserv/interactive=2Ec:204
 # IGN: We reuse the s=
ame variable name due to macro usage
-shadowVariable:src/openvpn/options=2E=
c:1948
-shadowVariable:src/openvpn/options=2Ec:1966
+shadowVariable:src/ope=
nvpn/options=2Ec:1955
+shadowVariable:src/openvpn/options=2Ec:1973
 # FP: f=
un:tls_crypt_v2_wrap_unwrap_invalid: cppcheck is confused
 syntaxError:test=
s/unit_tests/openvpn/test_tls_crypt=2Ec:684
 # FP: this file is never compi=
led on _WIN32
diff --git a/dev-tools/openvpn-cppcheck-library=2Ecfg b/dev-t=
ools/openvpn-cppcheck-library=2Ecfg
index 1ea91f4=2E=2Edecac67 100644
--- a=
/dev-tools/openvpn-cppcheck-library=2Ecfg
+++ b/dev-tools/openvpn-cppcheck-=
library=2Ecfg
@@ -26,4 +26,6 @@
   <!-- work around macro confusion -->
   =
<define name=3D"CMSG_FIRSTHDR" value=3D"cmsg_firsthdr" />
   <define name=
=3D"CMSG_NXTHDR" value=3D"cmsg_nxthdr" />
+  <!-- otherwise a lot of unused=
 variables are shown for enable-small builds -->
+  <define name=3D"DMSG_AL=
WAYS_AVAILABLE" value=3D"1" />
 </def>
diff --git a/src/openvpn/compstub=2E=
c b/src/openvpn/compstub=2Ec
index f0c89f7=2E=2E2eef587 100644
--- a/src/op=
envpn/compstub=2Ec
+++ b/src/openvpn/compstub=2Ec
@@ -125,7 +125,7 @@
     =
    return;
     }
 
-    uint8_t *head =3D BPTR(buf);
+    const uint8_t *=
head =3D BPTR(buf);
 
     /* no compression or packet to short*/
     if (=
head[0] !=3D COMP_ALGV2_INDICATOR_BYTE)
diff --git a/src/openvpn/crypto_mbe=
dtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec
index 0c5beb4=2E=2E05bb60d 100644=

--- a/src/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/crypto_mbedtls=2Ec
=
@@ -842,8 +842,8 @@
     struct gc_arena gc =3D gc_new();
     uint8_t A1[M=
AX_HMAC_KEY_LENGTH];
 
-#ifdef ENABLE_DEBUG
-    /* used by the D_SHOW_KEY_=
SOURCE, guarded with ENABLE_DEBUG to avoid unused
+#ifndef ENABLE_SMALL
+  =
  /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unus=
ed
      * variables warnings if compiled with --enable-small */
     const=
 size_t olen_orig =3D olen;
     const uint8_t *out_orig =3D out;
diff --gi=
t a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_lega=
cy=2Ec
index bbd012f6=2E=2Ef46d8bf 100644
--- a/src/openvpn/crypto_mbedtls_=
legacy=2Ec
+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec
@@ -989,8 +989,8 @@
=
     struct gc_arena gc =3D gc_new();
     uint8_t A1[MAX_HMAC_KEY_LENGTH];=

 
-#ifdef ENABLE_DEBUG
-    /* used by the D_SHOW_KEY_SOURCE, guarded with=
 ENABLE_DEBUG to avoid unused
+#ifndef ENABLE_SMALL
+    /* used by the D_S=
HOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unused
      * variables=
 warnings if compiled with --enable-small */
     const size_t olen_orig =
=3D olen;
     const uint8_t *out_orig =3D out;
diff --git a/src/openvpn/er=
ror=2Eh b/src/openvpn/error=2Eh
index a887fc7=2E=2E9f39572 100644
--- a/src=
/openvpn/error=2Eh
+++ b/src/openvpn/error=2Eh
@@ -158,7 +158,9 @@
        =
 }                                \
         EXIT_FATAL(flags);            =
   \
     } while (false)
-#ifdef ENABLE_DEBUG
+/* We have DMSG_ALWAYS_AVAI=
LABLE here to able to silence unused warnings for
+ * cppcheck */
+#if !def=
ined(ENABLE_SMALL) || defined(DMSG_ALWAYS_AVAILABLE)
 #define dmsg(flags, =
=2E=2E=2E)                 \
     do                                   \
  =
   {                                    \
diff --git a/src/openvpn/event=2E=
c b/src/openvpn/event=2Ec
index 8b7716a=2E=2E2cb4e04 100644
--- a/src/openv=
pn/event=2Ec
+++ b/src/openvpn/event=2Ec
@@ -398,7 +398,7 @@
 
     dmsg(D_=
EVENT_WAIT, "WE_WAIT enter n=3D%d to=3D%d", wes->n_events, timeout);
 
-#if=
def ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_debug_level(D_EVENT_W=
AIT))
     {
         int i;
diff --git a/src/openvpn/forward=2Ec b/src/ope=
nvpn/forward=2Ec
index 6fe5849=2E=2Ea8a4a07 100644
--- a/src/openvpn/forwar=
d=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -50,7 +50,7 @@
 
 /* show event wait=
 debugging info */
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 
 static c=
onst char *
 wait_status_string(struct context *c, struct gc_arena *gc)
@@ =
-75,7 +75,7 @@
     gc_free(&gc);
 }
 
-#endif /* ifdef ENABLE_DEBUG */
+#e=
ndif
 
 static void
 check_tls_errors_co(struct context *c)
@@ -2190,7 +219=
0,7 @@
         {
             int status;
 
-#ifdef ENABLE_DEBUG
+#ifndef =
ENABLE_SMALL
             if (check_debug_level(D_EVENT_WAIT))
            =
 {
                 show_wait_status(c);
diff --git a/src/openvpn/mroute=2E=
c b/src/openvpn/mroute=2Ec
index 39fa482=2E=2E261d25a 100644
--- a/src/open=
vpn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -501,7 +501,7 @@
     }
    =
 mh->n_net_len =3D j;
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if =
(check_debug_level(D_MULTI_DEBUG))
     {
         struct gc_arena gc =3D g=
c_new();
diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index 5d8=
8f8a=2E=2Eb0125f1 100644
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

Gerrit-MessageType: newpatchset
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3f96cd1c3488b558b8a597=
594d99edcba1214d27
Gerrit-Change-Number: 1942
Gerrit-PatchSet: 10
Gerrit-Ow=
ner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--0l2JHuPbYv8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #10</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review+2 by flic=
htenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">Change most ENABLE_DEBUG ifdefs to ifndef ENABLE_=
SMALL<br><br>Most of these are verbose logging or even enable logging at hi=
gh<br>verbosity level or just useful tools like --show-gateway=2E<br><br>We=
 had --enabled-debug on by default forever, so these &quot;debug&quot;<br>l=
ogs are on by default=2E This patch instead moves them to<br>enable-small=
=2E<br><br>Since the verbose logging is now always enabled<br>(apart from -=
-enable-small), --enable-debug now only covers true<br>debug options like g=
remlin=2E<br><br>Rename the configure option from --enable-debug to<br>--en=
able-developer-debug to ensure existing build<br>script/maintainer do not e=
nable this option<br>by default=2E<br><br>This patch also adds [SMALL] and =
[DEBUG] as identifier in the OpenVPN<br>version string more easily identify=
 builds with this feature=2E<br><br>In addition both configure and openvpn =
itself will add a warning<br>about --enable-developer-debug to discourage u=
sers and maintainers<br>from enabling this feature=2E<br><br>Remove dmsg ma=
cro from tapctl&#39;s error=2Eh since it does<br>not use that macro at all=
=2E<br><br>Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27<br>---<br>M=
 CMakeLists=2Etxt<br>M Changes=2Emd<br>M config=2Eh=2Ecmake=2Ein<br>M confi=
gure=2Eac<br>M dev-tools/cppcheck-suppression<br>M dev-tools/openvpn-cppche=
ck-library=2Ecfg<br>M src/openvpn/compstub=2Ec<br>M src/openvpn/crypto_mbed=
tls=2Ec<br>M src/openvpn/crypto_mbedtls_legacy=2Ec<br>M src/openvpn/error=
=2Eh<br>M src/openvpn/event=2Ec<br>M src/openvpn/forward=2Ec<br>M src/openv=
pn/mroute=2Ec<br>M src/openvpn/mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M src/=
openvpn/multi=2Ec<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/openvpn=2E=
c<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvp=
n/packet_id=2Ec<br>M src/openvpn/plugin=2Ec<br>M src/openvpn/plugin=2Eh<br>=
M src/openvpn/reliable=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvpn/sche=
dule=2Ec<br>M src/tapctl/error=2Eh<br>27 files changed, 85 insertions(+), 5=
9 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/42/1942/10</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeList=
s=2Etxt b/CMakeLists=2Etxt</span><br><span>index 6eb5954=2E=2Ed553697 10064=
4</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -40,6 +40,7 @@</span><br><span> option(ENABLE_PKC=
S11 &quot;BUILD with pkcs11-helper&quot; ON)</span><br><span> option(USE_WE=
RROR &quot;Treat compiler warnings as errors (-Werror)&quot; ON)</span><br>=
<span> option(FAKE_ANDROID &quot;Target Android but do not use actual cross=
 compile/Android cmake to build for simple compile checks on Linux&quot;)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+option(ENABLE_DEBUG &=
quot;Enable building with debug&quot; OFF)</span><br><span> </span><br><spa=
n> option(ENABLE_DNS_UPDOWN_BY_DEFAULT &quot;Run --dns-updown hook by defau=
lt&quot; ON)</span><br><span> set(DNS_UPDOWN_PATH &quot;${CMAKE_INSTALL_PRE=
FIX}/libexec/openvpn/dns-updown&quot; CACHE STRING &quot;Default location f=
or the DNS up/down script&quot;)</span><br><span>diff --git a/Changes=2Emd =
b/Changes=2Emd</span><br><span>index 2684251=2E=2E5c3270b 100644</span><br>=
<span>--- a/Changes=2Emd</span><br><span>+++ b/Changes=2Emd</span><br><span=
>@@ -23,6 +23,12 @@</span><br><span>   the characters mentioned above were =
already escaped=2E However, the behavior of</span><br><span>   Mbed TLS is =
slightly different from OpenSSL in that it also escapes &quot;=3D&quot;=2E<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+##=
 Maintainer-visible changes</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- The confi=
gure-time option `--enable-debug` is no longer  available</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  and the verbose logging is now alwa=
ys included unless `--enable-small`</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  is enabled=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> # Overview of changes in 2=2E7</span><br><spa=
n> </span><br><span> ## New features</span><br><span>diff --git a/config=2E=
h=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>index c3bb5a5=2E=
=2Ec6c0a96 100644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</span><br><=
span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -18,8 +18,8 @@</span>=
<br><span> /* Enable shared data channel offload */</span><br><span> #cmake=
define ENABLE_DCO</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-/* Enable debugging support (needed for verb&gt;=3D4) */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define ENABLE_DEBUG 1</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Enable debugging sup=
port */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine=
 ENABLE_DEBUG</span><br><span> </span><br><span> /* Enable internal fragmen=
tation support */</span><br><span> #define ENABLE_FRAGMENT 1</span><br><spa=
n>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>index 469a47=
5=2E=2E1fa0e63 100644</span><br><span>--- a/configure=2Eac</span><br><span>=
+++ b/configure=2Eac</span><br><span>@@ -130,10 +130,10 @@</span><br><span>=
 )</span><br><span> </span><br><span> AC_ARG_ENABLE(</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	[debug],</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	[AS_HELP_STRING([--disable-debug], [disable debugging =
support (disable gremlin and verb 7+ messages) @&lt;:@default=3Dyes@:&gt;@]=
)],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	[enable_debug=3D&quot;yes&quot;]</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	[developer-debug],</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	[AS_HELP_STRING([--ena=
ble-developer-debug], [enable developer debugging support (enable gremlin) =
@&lt;:@default=3Dno@:&gt;@])],</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	[enable_debug=3D&quot;yes&quot;],</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	[enable_debug=3D&quot;no&quot;]</span><br><span>=
 )</span><br><span> </span><br><span> AC_ARG_ENABLE(</span><br><span>@@ -13=
93,3 +1393,8 @@</span><br><span> ])</span><br><span> AC_CONFIG_FILES([tests=
/t_client=2Esh], [chmod +x tests/t_client=2Esh])</span><br><span> AC_OUTPUT=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# Put the warning at the end, so it is=
 better visible</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if t=
est &quot;${enable_debug}&quot; =3D &quot;yes&quot;; then</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    AC_MSG_WARN([--enable-developer-d=
ebug is enabled=2E This should be only used for test/development builds and=
 not for production usage])</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+fi</span><br><span>\ No newline at end of file</span><br><span>diff=
 --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression</s=
pan><br><span>index 299d7a3=2E=2E27c9d30 100644</span><br><span>--- a/dev-t=
ools/cppcheck-suppression</span><br><span>+++ b/dev-tools/cppcheck-suppress=
ion</span><br><span>@@ -42,7 +42,7 @@</span><br><span> intToPointerCast:src=
/openvpn/multi_io=2Ec</span><br><span> intToPointerCast:src/openvpn/ps=2Ec<=
/span><br><span> # FP: constant but differs between platforms</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-knownConditionTrueFalse:src/openvpn=
/error=2Eh:380</span><br><span style=3D"color: hsl(120, 100%, 40%);">+known=
ConditionTrueFalse:src/openvpn/error=2Eh:382</span><br><span> knownConditio=
nTrueFalse:src/openvpn/fdmisc=2Ec:80</span><br><span> knownConditionTrueFal=
se:src/openvpn/lladdr=2Ec:64</span><br><span> knownConditionTrueFalse:src/o=
penvpn/platform=2Ec</span><br><span>@@ -73,8 +73,8 @@</span><br><span> # FP=
: cppcheck doesn&#39;t understand ZeroMemory</span><br><span> redundantAssi=
gnment:src/openvpnserv/interactive=2Ec:204</span><br><span> # IGN: We reuse=
 the same variable name due to macro usage</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-shadowVariable:src/openvpn/options=2Ec:1948</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-shadowVariable:src/openvpn/optio=
ns=2Ec:1966</span><br><span style=3D"color: hsl(120, 100%, 40%);">+shadowVa=
riable:src/openvpn/options=2Ec:1955</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+shadowVariable:src/openvpn/options=2Ec:1973</span><br><span=
> # FP: fun:tls_crypt_v2_wrap_unwrap_invalid: cppcheck is confused</span><b=
r><span> syntaxError:tests/unit_tests/openvpn/test_tls_crypt=2Ec:684</span>=
<br><span> # FP: this file is never compiled on _WIN32</span><br><span>diff=
 --git a/dev-tools/openvpn-cppcheck-library=2Ecfg b/dev-tools/openvpn-cppch=
eck-library=2Ecfg</span><br><span>index 1ea91f4=2E=2Edecac67 100644</span><=
br><span>--- a/dev-tools/openvpn-cppcheck-library=2Ecfg</span><br><span>+++=
 b/dev-tools/openvpn-cppcheck-library=2Ecfg</span><br><span>@@ -26,4 +26,6 =
@@</span><br><span>   &lt;!-- work around macro confusion --&gt;</span><br>=
<span>   &lt;define name=3D&quot;CMSG_FIRSTHDR&quot; value=3D&quot;cmsg_fir=
sthdr&quot; /&gt;</span><br><span>   &lt;define name=3D&quot;CMSG_NXTHDR&qu=
ot; value=3D&quot;cmsg_nxthdr&quot; /&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  &lt;!-- otherwise a lot of unused variables are sho=
wn for enable-small builds --&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  &lt;define name=3D&quot;DMSG_ALWAYS_AVAILABLE&quot; value=
=3D&quot;1&quot; /&gt;</span><br><span> &lt;/def&gt;</span><br><span>diff -=
-git a/src/openvpn/compstub=2Ec b/src/openvpn/compstub=2Ec</span><br><span>=
index f0c89f7=2E=2E2eef587 100644</span><br><span>--- a/src/openvpn/compstu=
b=2Ec</span><br><span>+++ b/src/openvpn/compstub=2Ec</span><br><span>@@ -12=
5,7 +125,7 @@</span><br><span>         return;</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8=
_t *head =3D BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const uint8_t *head =3D BPTR(buf);</span><br><span> </span><br><spa=
n>     /* no compression or packet to short*/</span><br><span>     if (head=
[0] !=3D COMP_ALGV2_INDICATOR_BYTE)</span><br><span>diff --git a/src/openvp=
n/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>index=
 0c5beb4=2E=2E05bb60d 100644</span><br><span>--- a/src/openvpn/crypto_mbedt=
ls=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtls=2Ec</span><br><span=
>@@ -842,8 +842,8 @@</span><br><span>     struct gc_arena gc =3D gc_new();<=
/span><br><span>     uint8_t A1[MAX_HMAC_KEY_LENGTH];</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* used by the D_SHOW_K=
EY_SOURCE, guarded with ENABLE_DEBUG to avoid unused</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* used by the D_SHOW_KEY_SOURCE, gu=
arded with ENABLE_SMALL to avoid unused</span><br><span>      * variables w=
arnings if compiled with --enable-small */</span><br><span>     const size_=
t olen_orig =3D olen;</span><br><span>     const uint8_t *out_orig =3D out;=
</span><br><span>diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/o=
penvpn/crypto_mbedtls_legacy=2Ec</span><br><span>index bbd012f6=2E=2Ef46d8b=
f 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls_legacy=2Ec</span>=
<br><span>+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>@@ -9=
89,8 +989,8 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span>=
<br><span>     uint8_t A1[MAX_HMAC_KEY_LENGTH];</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* used by the D_SHOW_KEY_SOU=
RCE, guarded with ENABLE_DEBUG to avoid unused</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* used by the D_SHOW_KEY_SOURCE, guarded w=
ith ENABLE_SMALL to avoid unused</span><br><span>      * variables warnings=
 if compiled with --enable-small */</span><br><span>     const size_t olen_=
orig =3D olen;</span><br><span>     const uint8_t *out_orig =3D out;</span>=
<br><span>diff --git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh</span>=
<br><span>index a887fc7=2E=2E9f39572 100644</span><br><span>--- a/src/openv=
pn/error=2Eh</span><br><span>+++ b/src/openvpn/error=2Eh</span><br><span>@@=
 -158,7 +158,9 @@</span><br><span>         }                               =
 \</span><br><span>         EXIT_FATAL(flags);               \</span><br><s=
pan>     } while (false)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* We have DMSG_ALWAYS_AVAILABLE here to able to silence unused warnings=
 for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * cppcheck */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(ENABLE_=
SMALL) || defined(DMSG_ALWAYS_AVAILABLE)</span><br><span> #define dmsg(flag=
s, =2E=2E=2E)                 \</span><br><span>     do                    =
               \</span><br><span>     {                                    =
\</span><br><span>diff --git a/src/openvpn/event=2Ec b/src/openvpn/event=2E=
c</span><br><span>index 8b7716a=2E=2E2cb4e04 100644</span><br><span>--- a/s=
rc/openvpn/event=2Ec</span><br><span>+++ b/src/openvpn/event=2Ec</span><br>=
<span>@@ -398,7 +398,7 @@</span><br><span> </span><br><span>     dmsg(D_EVE=
NT_WAIT, &quot;WE_WAIT enter n=3D%d to=3D%d&quot;, wes-&gt;n_events, timeou=
t);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#ifndef ENABLE_SMALL</span><br><span>     if (check_debug_level(D_EVENT_WAI=
T))</span><br><span>     {</span><br><span>         int i;</span><br><span>=
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><s=
pan>index 6fe5849=2E=2Ea8a4a07 100644</span><br><span>--- a/src/openvpn/for=
ward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -=
50,7 +50,7 @@</span><br><span> </span><br><span> /* show event wait debuggi=
ng info */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#ifndef ENABLE_SMALL</span><br><span> </span><br><span> static const=
 char *</span><br><span> wait_status_string(struct context *c, struct gc_ar=
ena *gc)</span><br><span>@@ -75,7 +75,7 @@</span><br><span>     gc_free(&am=
p;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_DEBUG */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>=
 static void</span><br><span> check_tls_errors_co(struct context *c)</span>=
<br><span>@@ -2190,7 +2190,7 @@</span><br><span>         {</span><br><span>=
             int status;</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>             if (=
check_debug_level(D_EVENT_WAIT))</span><br><span>             {</span><br><=
span>                 show_wait_status(c);</span><br><span>diff --git a/src=
/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec</span><br><span>index 39fa482=
=2E=2E261d25a 100644</span><br><span>--- a/src/openvpn/mroute=2Ec</span><br=
><span>+++ b/src/openvpn/mroute=2Ec</span><br><span>@@ -501,7 +501,7 @@</sp=
an><br><span>     }</span><br><span>     mh-&gt;n_net_len =3D j;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_=
DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE=
_SMALL</span><br><span>     if (check_debug_level(D_MULTI_DEBUG))</span><br=
><span>     {</span><br><span>         struct gc_arena gc =3D gc_new();</sp=
an><br><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span=
><br><span>index 5d88f8a=2E=2Eb0125f1 100644</span><br><span>--- a/src/open=
vpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ =
-74,7 +74,7 @@</span><br><span>         mi-&gt;did_real_hash =3D true;</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (mi)</span><br>=
<span>     {</span><br><span>         dmsg(D_MULTI_DEBUG, &quot;MULTI TCP: =
instance added: %s&quot;, mroute_addr_print(&amp;mi-&gt;real, &amp;gc));</s=
pan><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</spa=
n><br><span>index 88b0091=2E=2E4794b7e 100644</span><br><span>--- a/src/ope=
nvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@=
 -431,7 +431,7 @@</span><br><span>         }</span><br><span>     }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENAB=
LE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENA=
BLE_SMALL</span><br><span>     if (check_debug_level(D_MULTI_DEBUG))</span>=
<br><span>     {</span><br><span>         struct gc_arena gc =3D gc_new();<=
/span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec<=
/span><br><span>index 3e72b92=2E=2E67204c3 100644</span><br><span>--- a/src=
/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><s=
pan>@@ -1145,7 +1145,7 @@</span><br><span>         }</span><br><span>     }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
def ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
ndef ENABLE_SMALL</span><br><span>     if (check_debug_level(D_MULTI_DEBUG)=
)</span><br><span>     {</span><br><span>         struct gc_arena gc =3D gc=
_new();</span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn=
/multi_io=2Ec</span><br><span>index 3604684=2E=2E4b96c57 100644</span><br><=
span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi=
_io=2Ec</span><br><span>@@ -46,7 +46,7 @@</span><br><span> #define MULTI_IO=
_FILE_CLOSE_WRITE ((void *)5)</span><br><span> #define MULTI_IO_DCO        =
      ((void *)6)</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> static const char *</sp=
an><br><span> pract(int action)</span><br><span> {</span><br><span>@@ -89,7=
 +89,7 @@</span><br><span>             return &quot;?&quot;;</span><br><spa=
n>     }</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif /* ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span> </span><br><span> static inline struct =
context *</span><br><span> multi_get_context(struct multi_context *m, struc=
t multi_instance *mi)</span><br><span>diff --git a/src/openvpn/openvpn=2Ec =
b/src/openvpn/openvpn=2Ec</span><br><span>index 24d6bb6=2E=2Eacd366d 100644=
</span><br><span>--- a/src/openvpn/openvpn=2Ec</span><br><span>+++ b/src/op=
envpn/openvpn=2Ec</span><br><span>@@ -252,6 +252,8 @@</span><br><span> #end=
if</span><br><span>             show_library_versions(M_INFO);</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sh=
ow_debug_warning(M_INFO);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span>             show_dco_version(M_INFO);</span><br><sp=
an> </span><br><span>             /* misc stuff */</span><br><span>diff --g=
it a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>inde=
x e3cd527=2E=2E3c5a249 100644</span><br><span>--- a/src/openvpn/options=2Ec=
</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -113,9 +1=
13,16 @@</span><br><span> #ifdef ENABLE_DCO</span><br><span>     &quot; [DC=
O]&quot;</span><br><span> #endif</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#ifdef ENABLE_SMALL</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &quot; [SMALL]&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &quot; [DEBUG]&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span> #ifdef CONFIGURE_GIT_REVISION</span><br><=
span>     &quot; built on &quot; __DATE__</span><br><span> #endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ;</span=
><br><span> </span><br><span> #ifndef ENABLE_SMALL</span><br><span>@@ -785,=
7 +792,7 @@</span><br><span> #endif /* ENABLE_PKCS11 */</span><br><span>   =
  &quot;\n&quot;</span><br><span>     &quot;General Standalone Options:\n&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEB=
UG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SM=
ALL</span><br><span>     &quot;--show-gateway [address]: Show info about ga=
teway [to v4/v6 address]=2E\n&quot;</span><br><span> #endif</span><br><span=
>     ;</span><br><span>@@ -3534,6 +3541,9 @@</span><br><span>     msg(M_IN=
FO | M_NOPREFIX, &quot;special build: %s&quot;, CONFIGURE_SPECIAL_BUILD);</=
span><br><span> #endif</span><br><span> #endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    show_debug_warning(M_INFO | M_NOPREFIX);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     openvpn_exit(OPENVP=
N_EXIT_STATUS_GOOD);</span><br><span> }</span><br><span> </span><br><span>@=
@ -4229,7 +4239,7 @@</span><br><span>         read_config_file(options, p[1=
], level, file, line, msglevel, permission_mask,</span><br><span>          =
                option_types_found, es);</span><br><span>     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DEBUG) &amp;&a=
mp; !defined(ENABLE_SMALL)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#ifndef ENABLE_SMALL</span><br><span>     else if (streq(p[0], &quot=
;show-gateway&quot;) &amp;&amp; !p[2])</span><br><span>     {</span><br><sp=
an>         struct route_gateway_info rgi;</span><br><span>@@ -4938,12 +494=
8,13 @@</span><br><span>              * mbed TLS always generating debug le=
vel logging */</span><br><span>             options-&gt;ssl_flags |=3D SSLF=
_TLS_DEBUG_ENABLED;</span><br><span>         }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if !defined(ENABLE_DEBUG) &amp;&amp; !defined(ENA=
BLE_SMALL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef EN=
ABLE_SMALL</span><br><span>         /* Warn when a debug verbosity is suppl=
ied when built without debug support */</span><br><span>         if (option=
s-&gt;verbosity &gt;=3D 7)</span><br><span>         {</span><br><span>     =
        msg(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              &quot;NOTE: debug verbosity (--verb %d) is enabled but this b=
uild lacks debug support=2E&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                &quot;NOTE: debug verbosity (--verb %d) is e=
nabled but this build is &quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                &quot;built with --enable-small that lacks supp=
ort for high --verb settings&quot;,</span><br><span>                 option=
s-&gt;verbosity);</span><br><span>         }</span><br><span> #endif</span>=
<br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</s=
pan><br><span>index f472676=2E=2E31ae17b 100644</span><br><span>--- a/src/o=
penvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br>=
<span>@@ -888,6 +888,16 @@</span><br><span> </span><br><span> void show_lib=
rary_versions(const unsigned int flags);</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static inline void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+show_debug_warning(const unsigned int=
 flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_DEBUG</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    msg(flags, &quot;WARNING: =
OpenVPN has been compiled with --enable-developer-debug=2E &quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+               &quot;This sho=
uld be only used for test/development builds and not for &quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+               &quot;production=
 usage&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef _WIN32</spa=
n><br><span> void show_windows_version(const unsigned int flags);</span><br=
><span> </span><br><span>diff --git a/src/openvpn/packet_id=2Ec b/src/openv=
pn/packet_id=2Ec</span><br><span>index a4b627c=2E=2E22c53c7 100644</span><b=
r><span>--- a/src/openvpn/packet_id=2Ec</span><br><span>+++ b/src/openvpn/p=
acket_id=2Ec</span><br><span>@@ -52,18 +52,18 @@</span><br><span> #define S=
EQ_UNSEEN  ((time_t)0)</span><br><span> #define SEQ_EXPIRED ((time_t)1)</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef =
ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef=
 ENABLE_SMALL</span><br><span> static void packet_id_debug_print(msglvl_t m=
sglevel, const struct packet_id_rec *p,</span><br><span>                   =
                const struct packet_id_net *pin, const char *message,</span=
><br><span>                                   packet_id_print_type value);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if /* ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span> </span><br><span> static inline void</span><br><s=
pan> packet_id_debug(msglvl_t msglevel, const struct packet_id_rec *p,</spa=
n><br><span>                 const struct packet_id_net *pin, const char *m=
essage, uint64_t value)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (unlikely=
(check_debug_level(msglevel)))</span><br><span>     {</span><br><span>     =
    packet_id_debug_print(msglevel, p, pin, message, value);</span><br><spa=
n>@@ -576,7 +576,7 @@</span><br><span>     return (char *)out=2Edata;</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#ifndef ENABLE_SMALL</span><br><span> </span><br><span> static vo=
id</span><br><span> packet_id_debug_print(msglvl_t msglevel, const struct p=
acket_id_rec *p,</span><br><span>@@ -648,7 +648,7 @@</span><br><span>     g=
c_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_DEBUG */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span>=
<br><span> uint16_t</span><br><span> packet_id_read_epoch(struct packet_id_=
net *pin, struct buffer *buf)</span><br><span>diff --git a/src/openvpn/plug=
in=2Ec b/src/openvpn/plugin=2Ec</span><br><span>index f8adde5=2E=2Ea94f07b =
100644</span><br><span>--- a/src/openvpn/plugin=2Ec</span><br><span>+++ b/s=
rc/openvpn/plugin=2Ec</span><br><span>@@ -993,7 +993,7 @@</span><br><span> =
    pr-&gt;n =3D 0;</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> vo=
id</span><br><span> plugin_return_print(const msglvl_t msglevel, const char=
 *prefix, const struct plugin_return *pr)</span><br><span> {</span><br><spa=
n>@@ -1012,5 +1012,5 @@</span><br><span>         }</span><br><span>     }</=
span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if /* ifdef ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span> #endif /* ENABLE_PLUGIN */</span><br><span>=
diff --git a/src/openvpn/plugin=2Eh b/src/openvpn/plugin=2Eh</span><br><spa=
n>index 7e9faf3=2E=2E684632c 100644</span><br><span>--- a/src/openvpn/plugi=
n=2Eh</span><br><span>+++ b/src/openvpn/plugin=2Eh</span><br><span>@@ -135,=
7 +135,7 @@</span><br><span> </span><br><span> void plugin_return_free(stru=
ct plugin_return *pr);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> void plugin_return=
_print(const msglvl_t msglevel, const char *prefix, const struct plugin_ret=
urn *pr);</span><br><span> </span><br><span> #endif</span><br><span>diff --=
git a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec</span><br><span>i=
ndex ced438e=2E=2Eb5315ff 100644</span><br><span>--- a/src/openvpn/reliable=
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
<div style=3D"display:none"> Gerrit-PatchSet: 10 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: fli=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--0l2JHuPbYv8=--


--===============0643202432959408294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0643202432959408294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0643202432959408294==--

