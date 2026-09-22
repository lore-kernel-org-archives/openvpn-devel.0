Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF122C982FA
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CvBF6LE674XvAbhJMfUqCL1yY2AADhyrG8fLKViiCnU=; b=OgfDUMZSUTdyR0UqLHU28nLuRQ
	ghZ/edCpT5zOGtQ669lq1GIWniHyCgHfePCw2VN2izgvUguMdnNmd5F3aPQxTd6/M6Efvzpl7suWk
	nY8P+9cajadsfL35fs9YsEnA2bMsP54duLt0ITSCC3H1dyti7mR9OGIhROJec5AaQO+o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x90K4-0000wP-Cg;
	Tue, 22 Sep 2026 13:14:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x90K2-0000wJ-Ic
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:14:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Ulmnx8wE+6RHGzKx0YwrEo0hNZbZ+1cMoqOcZVpMalA=; b=hPgvkL8gSZ9pL2INmBq+igSRDp
 x9k0e39WNSpnl9aR7kqQqnVQTCYHUg6G0rPntwichoo2pXvU+CaIbl1u1eu0wUsevNfE23EP58PiQ
 p93uT8Q7F7UJtXWfkCtchXefZA+uaP3P/kZ+pji7bY7Jkr88qXP3WSSZGDEZUJJDTXDw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ulmnx8wE+6RHGzKx0YwrEo0hNZbZ+1cMoqOcZVpMalA=; b=L
 tP0ueN96DoDFgqHzM5562pUEYcB1OzoD9RYUbvEwIDq9kySkku5Q9vyr4bQgdrAGVqjaPVk5CtfYJ
 fkKtpQM4x3v0XULWw77Yf5OElgrZFw1hWW+qc0vvJy1FZSZoqBlsD78nTvTznj+8jNOyHMyFTiDvh
 hZu1kYrjSCAz9Dbc=;
Received: from mail-wr2-f15.google.com ([74.125.225.79])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x90K0-000440-5c for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:14:10 +0000
Received: by mail-wr2-f15.google.com with SMTP id
 ffacd0b85a97d-482f633ecdeso3522168f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 06:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790082841; x=1790687641; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ulmnx8wE+6RHGzKx0YwrEo0hNZbZ+1cMoqOcZVpMalA=;
 b=EkAwl63iQ3kaa+SeqYM7iW/6mqKgXDEW9xUWhEj+Zh/skNyvh0oH2L8PPY/Jp91Cw7
 CDCfGn6wm+jLUw8uc1zhcm4IgP7BOceHTxczwk/zRlV6b3jLDc57S8AtrPgMMEH9NyhC
 ZKOR5VBzubv3CKo5IxE82zzDwP5Q6MwT4lYuJJzgT8yG/qpu98I55o3cN5Ltd6t+i7XP
 2nS0bEtrxDE036BUwsBlIVF1zph7E+rkrTPy9JHAEo3ILBqRqYU0KOqwAwRg3Pv25Lqt
 PtAY7fLBv9U1FozAC1NkLw17uvQ+BNM1ouESAmarNjOz92Z9KX2m40HTiLgqBftqpkX9
 sRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790082841; x=1790687641;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ulmnx8wE+6RHGzKx0YwrEo0hNZbZ+1cMoqOcZVpMalA=;
 b=eDwdb+VfpLUwSzN7551YalaTQ6eWEZCYcjVqRkQSIscQj21Zip87NpMej/LfOe/N21
 C+HYqpn26eKyml8cx4ZVvvLT7i398jvbdrndBOuXIzE1pH8GyfXob3G4T4InL3cRQ5we
 vArR4LVJSPCZZ+p48QGam7rEaBcYhhY39CS1nwOc+5dICQgwJgdlICxvN8JiLHDuwzRN
 vOTR4zfwqw4fT/dL5OeBdro0fJ+pE7ePj25ybICFVjDlHpZoEQfQ7LCVT19E3jYMrDf6
 HvuxR51SMHQT0YGsFSQ06UkYE8XHcYMN+mxM1WwLA8577pkohIIQIue/+QdBKsGsKwXg
 ZbqA==
X-Gm-Message-State: AFuF++kqMV+fePGx0CcwKq5I8ARO4vjIujfZh4+Bd/T8yrcgywlcVurM
 O+mrceZOESQ9avnwnIjy4q7pthPo1zZaQWdHakFkzOqelEcrVUwFNz1u4mb/O02IvnyWVhCmM+f
 WTlP0ReU9zz3gU5mYuJxOlTI9ieZa29WK2fk0AJPDbrPLSY7+Du8IvVuE3Dq+yZeZm5EvGpwEB2
 EuRBK6Tg==
X-Gm-Gg: AYBFou0Rm4f+E9hPuxyEhW3As95BWe+AsL2ygo1DWr8ivWJTl8rw5ZFep181lJvek1A
 ON3MF/UbAnmLJgDeOg2FZWsLPqyiqRZ+MgapHuHIB5hkEpQe6ZbrxVzeohLrTo7qOLnLmruorhH
 n/FGz7Qyq5yYIUiX0xs/tyyCfLm8wrNCZ+ySgOwf/rJ2c4hRohxexbHHB2IOlEcHJFReBYwdRoo
 7tNIuhjhHc1cJSR3Y+0LLYIvqWbKMAR0X5PK8C4WgOmQkYIL/PyAYaDANQIbevWzVF6CKFyx8MY
 Z4fiHQblMLoHD7bckeQlh5JKAwlAsc0xSOSUt5V047WKG3SVfIXArJ2vRFs0TL8HvcqGj9vxLaA
 tcVqw2DzTSG7DbbG62EI62khXShH2RFOWbhoP3AXvsozR1qiBrlgEZLarM71lN4Llrnpp71zSFm
 g5Y6riCWb6BAfkuYwX5N5XZ2ZCQeM/39nkgiNByLlfXaCYFoSdIUreHx+VsQueXSH0Gft6/t1CI
 ZXndUYE4Xeg0S+EEdIXAmkp+7pk6I+gBlTNynHlR6xUdSENtUAhw7x+/bxoO4s5mqgIG9qP/jss
 cdFTkx3hPd+RpZ73CaoFgdsR7Vb9b66qMlG4I4lM/dVLw8S92Pi18EhY9ONR
X-Received: by 2002:a05:6000:298d:10b0:488:57c0:d5bb with SMTP id
 ffacd0b85a97d-48857c0d5ddmr7358405f8f.5.1790082841327; 
 Tue, 22 Sep 2026 06:14:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48862774483sm4690315f8f.8.2026.09.22.06.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 06:14:00 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 13:13:59 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: 91b470d50dd8a5cbfd0cfeb3e84dff79f2b82930
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0b01b6aa8b150d5f7f6ecc845139d57bcd4f6002-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x90K0-000440-5c
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
Content-Type: multipart/mixed; boundary="===============5202265481904489643=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5202265481904489643==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TAxokjS+Ntg="; charset=UTF-8

--TAxokjS+Ntg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1942?usp=3Demail

to look at the new patch set (#2=
)=2E

The following approvals got outdated and were removed:
Code-Review-1 =
by flichtenheld


Change subject: Change most ENABLE_DEBUG ifdefs to ifndef=
 ENABLE_SMALL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Change most ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL

Most of these are=
 verbose logging or even enable logging at high
verbosity level or just use=
ful tools like --show-gateway=2E

We had --enabled-debug on by default fore=
ver, so these "debug"
logs are on by default=2E This patch instead moves th=
em to
enable-small=2E

Since the verbose logging is now always enabled
(apa=
rt from --enable-small), --enable-debug now only covers true
debug options =
like gremlin=2E

Rename the configure option from --enable-debug to
--enabl=
e-developer-debug to ensure existing build
script/maintainer do not enable =
this option
by default=2E

Change-Id: I3f96cd1c3488b558b8a597594d99edcba121=
4d27
---
M CMakeLists=2Etxt
M Changes=2Emd
M config=2Eh=2Ecmake=2Ein
M conf=
igure=2Eac
M src/openvpn/crypto_mbedtls=2Ec
M src/openvpn/crypto_mbedtls_le=
gacy=2Ec
M src/openvpn/error=2Eh
M src/openvpn/event=2Ec
M src/openvpn/forw=
ard=2Ec
M src/openvpn/mroute=2Ec
M src/openvpn/mtcp=2Ec
M src/openvpn/mudp=
=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/multi_io=2Ec
M src/openvpn/optio=
ns=2Ec
M src/openvpn/packet_id=2Ec
M src/openvpn/plugin=2Ec
M src/openvpn/p=
lugin=2Eh
M src/openvpn/reliable=2Ec
M src/openvpn/route=2Ec
M src/openvpn/=
schedule=2Ec
M src/tapctl/error=2Eh
22 files changed, 45 insertions(+), 38 =
deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/42/1942/2

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 6e=
b5954=2E=2Ed553697 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ =
-40,6 +40,7 @@
 option(ENABLE_PKCS11 "BUILD with pkcs11-helper" ON)
 option=
(USE_WERROR "Treat compiler warnings as errors (-Werror)" ON)
 option(FAKE_=
ANDROID "Target Android but do not use actual cross compile/Android cmake t=
o build for simple compile checks on Linux")
+option(ENABLE_DEBUG "Enable b=
uilding with debug" OFF)
 
 option(ENABLE_DNS_UPDOWN_BY_DEFAULT "Run --dns-=
updown hook by default" ON)
 set(DNS_UPDOWN_PATH "${CMAKE_INSTALL_PREFIX}/l=
ibexec/openvpn/dns-updown" CACHE STRING "Default location for the DNS up/do=
wn script")
diff --git a/Changes=2Emd b/Changes=2Emd
index 2684251=2E=2E776=
3d59 100644
--- a/Changes=2Emd
+++ b/Changes=2Emd
@@ -23,6 +23,11 @@
   the=
 characters mentioned above were already escaped=2E However, the behavior o=
f
   Mbed TLS is slightly different from OpenSSL in that it also escapes "=
=3D"=2E
 
+## Maintainer-visible changes
+
+- The configure-time option `--=
enable-debug` is no longer
+  available and the verbose logging is now alwa=
ys included=2E
+
 # Overview of changes in 2=2E7
 
 ## New features
diff --=
git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index c3bb5a5=2E=2E=
c6c0a96 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
=
@@ -18,8 +18,8 @@
 /* Enable shared data channel offload */
 #cmakedefine E=
NABLE_DCO
 
-/* Enable debugging support (needed for verb>=3D4) */
-#define=
 ENABLE_DEBUG 1
+/* Enable debugging support */
+#cmakedefine ENABLE_DEBUG
=
 
 /* Enable internal fragmentation support */
 #define ENABLE_FRAGMENT 1
d=
iff --git a/configure=2Eac b/configure=2Eac
index 469a475=2E=2E47e4759 1006=
44
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -131,9 +131,9 @@
 
 AC_ARG_=
ENABLE(
 	[debug],
-	[AS_HELP_STRING([--disable-debug], [disable debugging =
support (disable gremlin and verb 7+ messages) @<:@default=3Dyes@:>@])],
+	=
[AS_HELP_STRING([--enable-developer-debug], [enable developer debugging sup=
port (enable gremlin) @<:@default=3Dyes@:>@])],
 	,
-	[enable_debug=3D"yes"=
]
+	[enable_debug=3D"no"]
 )
 
 AC_ARG_ENABLE(
diff --git a/src/openvpn/cry=
pto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec
index 0c5beb4=2E=2E9d19902=
 100644
--- a/src/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvpn/crypto_mbedt=
ls=2Ec
@@ -842,7 +842,7 @@
     struct gc_arena gc =3D gc_new();
     uint8=
_t A1[MAX_HMAC_KEY_LENGTH];
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
  =
   /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unu=
sed
      * variables warnings if compiled with --enable-small */
     cons=
t size_t olen_orig =3D olen;
diff --git a/src/openvpn/crypto_mbedtls_legacy=
=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec
index bbd012f6=2E=2Ef46d8bf 10=
0644
--- a/src/openvpn/crypto_mbedtls_legacy=2Ec
+++ b/src/openvpn/crypto_m=
bedtls_legacy=2Ec
@@ -989,8 +989,8 @@
     struct gc_arena gc =3D gc_new();=

     uint8_t A1[MAX_HMAC_KEY_LENGTH];
 
-#ifdef ENABLE_DEBUG
-    /* used =
by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unused
+#ifnde=
f ENABLE_SMALL
+    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_S=
MALL to avoid unused
      * variables warnings if compiled with --enable-s=
mall */
     const size_t olen_orig =3D olen;
     const uint8_t *out_orig =
=3D out;
diff --git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh
index a=
887fc7=2E=2E5811bef 100644
--- a/src/openvpn/error=2Eh
+++ b/src/openvpn/er=
ror=2Eh
@@ -158,7 +158,7 @@
         }                                \
   =
      EXIT_FATAL(flags);               \
     } while (false)
-#ifdef ENABL=
E_DEBUG
+#ifndef ENABLE_SMALL
 #define dmsg(flags, =2E=2E=2E)              =
   \
     do                                   \
     {                    =
                \
diff --git a/src/openvpn/event=2Ec b/src/openvpn/event=2E=
c
index 8b7716a=2E=2E2cb4e04 100644
--- a/src/openvpn/event=2Ec
+++ b/src/o=
penvpn/event=2Ec
@@ -398,7 +398,7 @@
 
     dmsg(D_EVENT_WAIT, "WE_WAIT ent=
er n=3D%d to=3D%d", wes->n_events, timeout);
 
-#ifdef ENABLE_DEBUG
+#ifnde=
f ENABLE_SMALL
     if (check_debug_level(D_EVENT_WAIT))
     {
         in=
t i;
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 6=
fe5849=2E=2E7811245 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/=
forward=2Ec
@@ -50,7 +50,7 @@
 
 /* show event wait debugging info */
 
-#i=
fdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 
 static const char *
 wait_status=
_string(struct context *c, struct gc_arena *gc)
@@ -2190,7 +2190,7 @@
     =
    {
             int status;
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL=

             if (check_debug_level(D_EVENT_WAIT))
             {
         =
        show_wait_status(c);
diff --git a/src/openvpn/mroute=2Ec b/src/open=
vpn/mroute=2Ec
index 39fa482=2E=2E261d25a 100644
--- a/src/openvpn/mroute=
=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -501,7 +501,7 @@
     }
     mh->n_net=
_len =3D j;
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_deb=
ug_level(D_MULTI_DEBUG))
     {
         struct gc_arena gc =3D gc_new();
d=
iff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index 5d88f8a=2E=2E=
b0125f1 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -74=
,7 +74,7 @@
         mi->did_real_hash =3D true;
     }
 
-#ifdef ENABLE_DE=
BUG
+#ifndef ENABLE_SMALL
     if (mi)
     {
         dmsg(D_MULTI_DEBUG, =
"MULTI TCP: instance added: %s", mroute_addr_print(&mi->real, &gc));
diff -=
-git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 88b0091=2E=2E4794b=
7e 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -431,7 +=
431,7 @@
         }
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
   =
  if (check_debug_level(D_MULTI_DEBUG))
     {
         struct gc_arena gc =
=3D gc_new();
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
in=
dex 3e72b92=2E=2E67204c3 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openv=
pn/multi=2Ec
@@ -1145,7 +1145,7 @@
         }
     }
 
-#ifdef ENABLE_DEBUG=

+#ifndef ENABLE_SMALL
     if (check_debug_level(D_MULTI_DEBUG))
     {
  =
       struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/multi_io=
=2Ec b/src/openvpn/multi_io=2Ec
index 3604684=2E=2E4b96c57 100644
--- a/src=
/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -46,7 +46,7 @@
 #de=
fine MULTI_IO_FILE_CLOSE_WRITE ((void *)5)
 #define MULTI_IO_DCO           =
   ((void *)6)
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 static const c=
har *
 pract(int action)
 {
@@ -89,7 +89,7 @@
             return "?";
    =
 }
 }
-#endif /* ENABLE_DEBUG */
+#endif
 
 static inline struct context *
=
 multi_get_context(struct multi_context *m, struct multi_instance *mi)
diff=
 --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index e3cd527=2E=
=2Ee8ec9db 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=
=2Ec
@@ -785,7 +785,7 @@
 #endif /* ENABLE_PKCS11 */
     "\n"
     "Genera=
l Standalone Options:\n"
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     "-=
-show-gateway [address]: Show info about gateway [to v4/v6 address]=2E\n"
 =
#endif
     ;
@@ -4229,7 +4229,7 @@
         read_config_file(options, p[1]=
, level, file, line, msglevel, permission_mask,
                          o=
ption_types_found, es);
     }
-#if defined(ENABLE_DEBUG) && !defined(ENABL=
E_SMALL)
+#ifndef ENABLE_SMALL
     else if (streq(p[0], "show-gateway") &&=
 !p[2])
     {
         struct route_gateway_info rgi;
@@ -4938,12 +4938,13=
 @@
              * mbed TLS always generating debug level logging */
     =
        options->ssl_flags |=3D SSLF_TLS_DEBUG_ENABLED;
         }
-#if !de=
fined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#if defined(ENABLE_SMALL)
  =
       /* Warn when a debug verbosity is supplied when built without debug =
support */
         if (options->verbosity >=3D 7)
         {
             =
msg(M_WARN,
-                "NOTE: debug verbosity (--verb %d) is enabled =
but this build lacks debug support=2E",
+                "NOTE: debug verbo=
sity (--verb %d) is enabled but this build is "
+                "built wit=
h --enable-small that lacks support for high --verb settings",
            =
     options->verbosity);
         }
 #endif
diff --git a/src/openvpn/packe=
t_id=2Ec b/src/openvpn/packet_id=2Ec
index a4b627c=2E=2E22c53c7 100644
--- =
a/src/openvpn/packet_id=2Ec
+++ b/src/openvpn/packet_id=2Ec
@@ -52,18 +52,1=
8 @@
 #define SEQ_UNSEEN  ((time_t)0)
 #define SEQ_EXPIRED ((time_t)1)
 
-#=
ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 static void packet_id_debug_print=
(msglvl_t msglevel, const struct packet_id_rec *p,
                        =
           const struct packet_id_net *pin, const char *message,
          =
                         packet_id_print_type value);
 
-#endif /* ENABLE_D=
EBUG */
+#endif
 
 static inline void
 packet_id_debug(msglvl_t msglevel, c=
onst struct packet_id_rec *p,
                 const struct packet_id_net *=
pin, const char *message, uint64_t value)
 {
-#ifdef ENABLE_DEBUG
+#ifndef =
ENABLE_SMALL
     if (unlikely(check_debug_level(msglevel)))
     {
       =
  packet_id_debug_print(msglevel, p, pin, message, value);
@@ -576,7 +576,7=
 @@
     return (char *)out=2Edata;
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENAB=
LE_SMALL
 
 static void
 packet_id_debug_print(msglvl_t msglevel, const str=
uct packet_id_rec *p,
@@ -648,7 +648,7 @@
     gc_free(&gc);
 }
 
-#endif /=
* ifdef ENABLE_DEBUG */
+#endif
 
 uint16_t
 packet_id_read_epoch(struct pa=
cket_id_net *pin, struct buffer *buf)
diff --git a/src/openvpn/plugin=2Ec b=
/src/openvpn/plugin=2Ec
index f8adde5=2E=2Ed10f9fa 100644
--- a/src/openvpn=
/plugin=2Ec
+++ b/src/openvpn/plugin=2Ec
@@ -993,7 +993,7 @@
     pr->n =3D=
 0;
 }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 void
 plugin_return_pr=
int(const msglvl_t msglevel, const char *prefix, const struct plugin_return=
 *pr)
 {
diff --git a/src/openvpn/plugin=2Eh b/src/openvpn/plugin=2Eh
index=
 7e9faf3=2E=2E684632c 100644
--- a/src/openvpn/plugin=2Eh
+++ b/src/openvpn=
/plugin=2Eh
@@ -135,7 +135,7 @@
 
 void plugin_return_free(struct plugin_re=
turn *pr);
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 void plugin_return=
_print(const msglvl_t msglevel, const char *prefix, const struct plugin_ret=
urn *pr);
 
 #endif
diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/rel=
iable=2Ec
index ced438e=2E=2Eb5315ff 100644
--- a/src/openvpn/reliable=2Ec
=
+++ b/src/openvpn/reliable=2Ec
@@ -462,7 +462,7 @@
     }
 }
 
-#ifdef ENAB=
LE_DEBUG
+#ifndef ENABLE_SMALL
 /* print the current sequence of active pac=
ket IDs */
 static const char *
 reliable_print_ids(const struct reliable *=
rel, struct gc_arena *gc)
@@ -480,7 +480,7 @@
     }
     return BSTR(&out)=
;
 }
-#endif /* ENABLE_DEBUG */
+#endif
 
 /* true if at least one free buf=
fer available */
 bool
diff --git a/src/openvpn/route=2Ec b/src/openvpn/rou=
te=2Ec
index 03a2526=2E=2Ee8001b3 100644
--- a/src/openvpn/route=2Ec
+++ b/=
src/openvpn/route=2Ec
@@ -81,7 +81,7 @@
 
 static void get_bypass_addresses=
(struct route_bypass *rb, const unsigned int flags);
 
-#ifdef ENABLE_DEBUG=

+#ifndef ENABLE_SMALL
 
 static void
 print_bypass_addresses(const struct =
route_bypass *rb)
@@ -617,7 +617,7 @@
     if (rl->ngi=2Eflags & RGI_ADDR_D=
EFINED)
     {
         setenv_route_addr(es, "net_gateway", rl->ngi=2Egate=
way=2Eaddr, -1);
-#if defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifn=
def ENABLE_SMALL
         print_default_gateway(D_ROUTE, &rl->rgi, NULL);
 =
#endif
     }
@@ -660,7 +660,7 @@
             add_block_local_routes(rl);
=
         }
         get_bypass_addresses(&rl->spec=2Ebypass, rl->flags);
-#=
ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
         print_bypass_addresses(&r=
l->spec=2Ebypass);
 #endif
     }
@@ -768,7 +768,7 @@
     if (rl6->ngi6=2E=
flags & RGI_ADDR_DEFINED)
     {
         setenv_str(es, "net_gateway_ipv6"=
, print_in6_addr(rl6->ngi6=2Egateway=2Eaddr_ipv6, 0, &gc));
-#if defined(EN=
ABLE_DEBUG) && !defined(ENABLE_SMALL)
+#ifndef ENABLE_SMALL
         print_=
default_gateway(D_ROUTE, NULL, &rl6->rgi6);
 #endif
     }
diff --git a/src=
/openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec
index 6772ad6=2E=2E6c60dc2=
 100644
--- a/src/openvpn/schedule=2Ec
+++ b/src/openvpn/schedule=2Ec
@@ -3=
3,7 +33,7 @@
 
 #include "memdbg=2Eh"
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABL=
E_SMALL
 static void
 schedule_entry_debug_info(const char *caller, const s=
truct schedule_entry *e)
 {
@@ -308,7 +308,7 @@
 void
 schedule_add_modify(=
struct schedule *s, struct schedule_entry *e)
 {
-#ifdef ENABLE_DEBUG
+#ifn=
def ENABLE_SMALL
     if (check_debug_level(D_SCHEDULER))
     {
         s=
chedule_entry_debug_info("schedule_add_modify", e);
@@ -355,7 +355,7 @@
   =
      }
     }
 
-#ifdef ENABLE_DEBUG
+#ifndef ENABLE_SMALL
     if (check_=
debug_level(D_SCHEDULER))
     {
         schedule_entry_debug_info("schedu=
le_find_least", e);
diff --git a/src/tapctl/error=2Eh b/src/tapctl/error=2E=
h
index f9586dc=2E=2E34aa894 100644
--- a/src/tapctl/error=2Eh
+++ b/src/ta=
pctl/error=2Eh
@@ -83,7 +83,7 @@
         }                                =
\
         EXIT_FATAL(flags);               \
     } while (false)
-#ifdef =
ENABLE_DEBUG
+#ifndef ENABLE_SMALL
 #define dmsg(flags, =2E=2E=2E)         =
        \
     do                                   \
     {               =
                     \

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1942?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
Gerrit-Change-Number: 1942
=
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld=
 <frank@lichtenheld=2Ecom>

--TAxokjS+Ntg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1942?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Change most ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL<br><br=
>Most of these are verbose logging or even enable logging at high<br>verbos=
ity level or just useful tools like --show-gateway=2E<br><br>We had --enabl=
ed-debug on by default forever, so these &quot;debug&quot;<br>logs are on b=
y default=2E This patch instead moves them to<br>enable-small=2E<br><br>Sin=
ce the verbose logging is now always enabled<br>(apart from --enable-small)=
, --enable-debug now only covers true<br>debug options like gremlin=2E<br><=
br>Rename the configure option from --enable-debug to<br>--enable-developer=
-debug to ensure existing build<br>script/maintainer do not enable this opt=
ion<br>by default=2E<br><br>Change-Id: I3f96cd1c3488b558b8a597594d99edcba12=
14d27<br>---<br>M CMakeLists=2Etxt<br>M Changes=2Emd<br>M config=2Eh=2Ecmak=
e=2Ein<br>M configure=2Eac<br>M src/openvpn/crypto_mbedtls=2Ec<br>M src/ope=
nvpn/crypto_mbedtls_legacy=2Ec<br>M src/openvpn/error=2Eh<br>M src/openvpn/=
event=2Ec<br>M src/openvpn/forward=2Ec<br>M src/openvpn/mroute=2Ec<br>M src=
/openvpn/mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M=
 src/openvpn/multi_io=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/pac=
ket_id=2Ec<br>M src/openvpn/plugin=2Ec<br>M src/openvpn/plugin=2Eh<br>M src=
/openvpn/reliable=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvpn/schedule=
=2Ec<br>M src/tapctl/error=2Eh<br>22 files changed, 45 insertions(+), 38 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/42/1942/2</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt=
 b/CMakeLists=2Etxt</span><br><span>index 6eb5954=2E=2Ed553697 100644</span=
><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</s=
pan><br><span>@@ -40,6 +40,7 @@</span><br><span> option(ENABLE_PKCS11 &quot=
;BUILD with pkcs11-helper&quot; ON)</span><br><span> option(USE_WERROR &quo=
t;Treat compiler warnings as errors (-Werror)&quot; ON)</span><br><span> op=
tion(FAKE_ANDROID &quot;Target Android but do not use actual cross compile/=
Android cmake to build for simple compile checks on Linux&quot;)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+option(ENABLE_DEBUG &quot;Enab=
le building with debug&quot; OFF)</span><br><span> </span><br><span> option=
(ENABLE_DNS_UPDOWN_BY_DEFAULT &quot;Run --dns-updown hook by default&quot; =
ON)</span><br><span> set(DNS_UPDOWN_PATH &quot;${CMAKE_INSTALL_PREFIX}/libe=
xec/openvpn/dns-updown&quot; CACHE STRING &quot;Default location for the DN=
S up/down script&quot;)</span><br><span>diff --git a/Changes=2Emd b/Changes=
=2Emd</span><br><span>index 2684251=2E=2E7763d59 100644</span><br><span>---=
 a/Changes=2Emd</span><br><span>+++ b/Changes=2Emd</span><br><span>@@ -23,6=
 +23,11 @@</span><br><span>   the characters mentioned above were already e=
scaped=2E However, the behavior of</span><br><span>   Mbed TLS is slightly =
different from OpenSSL in that it also escapes &quot;=3D&quot;=2E</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+## Maintain=
er-visible changes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+- The configure-time=
 option `--enable-debug` is no longer</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  available and the verbose logging is now always include=
d=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> # Overview of changes in 2=2E7</span><br><span> </span><br><span> ## New=
 features</span><br><span>diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=
=2Ecmake=2Ein</span><br><span>index c3bb5a5=2E=2Ec6c0a96 100644</span><br><=
span>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/config=2Eh=2Ecmake=
=2Ein</span><br><span>@@ -18,8 +18,8 @@</span><br><span> /* Enable shared d=
ata channel offload */</span><br><span> #cmakedefine ENABLE_DCO</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Enable debug=
ging support (needed for verb&gt;=3D4) */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define ENABLE_DEBUG 1</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* Enable debugging support */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#cmakedefine ENABLE_DEBUG</span><br><span=
> </span><br><span> /* Enable internal fragmentation support */</span><br><=
span> #define ENABLE_FRAGMENT 1</span><br><span>diff --git a/configure=2Eac=
 b/configure=2Eac</span><br><span>index 469a475=2E=2E47e4759 100644</span><=
br><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span><b=
r><span>@@ -131,9 +131,9 @@</span><br><span> </span><br><span> AC_ARG_ENABL=
E(</span><br><span> 	[debug],</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	[AS_HELP_STRING([--disable-debug], [disable debugging support (dis=
able gremlin and verb 7+ messages) @&lt;:@default=3Dyes@:&gt;@])],</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	[AS_HELP_STRING([--enable-d=
eveloper-debug], [enable developer debugging support (enable gremlin) @&lt;=
:@default=3Dyes@:&gt;@])],</span><br><span> 	,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	[enable_debug=3D&quot;yes&quot;]</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	[enable_debug=3D&quot;no&quot;]</sp=
an><br><span> )</span><br><span> </span><br><span> AC_ARG_ENABLE(</span><br=
><span>diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbe=
dtls=2Ec</span><br><span>index 0c5beb4=2E=2E9d19902 100644</span><br><span>=
--- a/src/openvpn/crypto_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/cryp=
to_mbedtls=2Ec</span><br><span>@@ -842,7 +842,7 @@</span><br><span>     str=
uct gc_arena gc =3D gc_new();</span><br><span>     uint8_t A1[MAX_HMAC_KEY_=
LENGTH];</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifndef ENABLE_SMALL</span><br><span>     /* used by the D_SHOW_KEY_SO=
URCE, guarded with ENABLE_DEBUG to avoid unused</span><br><span>      * var=
iables warnings if compiled with --enable-small */</span><br><span>     con=
st size_t olen_orig =3D olen;</span><br><span>diff --git a/src/openvpn/cryp=
to_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><sp=
an>index bbd012f6=2E=2Ef46d8bf 100644</span><br><span>--- a/src/openvpn/cry=
pto_mbedtls_legacy=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtls_leg=
acy=2Ec</span><br><span>@@ -989,8 +989,8 @@</span><br><span>     struct gc_=
arena gc =3D gc_new();</span><br><span>     uint8_t A1[MAX_HMAC_KEY_LENGTH]=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
fdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG to avoid unused=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMAL=
L</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* used by the=
 D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unused</span><br><sp=
an>      * variables warnings if compiled with --enable-small */</span><br>=
<span>     const size_t olen_orig =3D olen;</span><br><span>     const uint=
8_t *out_orig =3D out;</span><br><span>diff --git a/src/openvpn/error=2Eh b=
/src/openvpn/error=2Eh</span><br><span>index a887fc7=2E=2E5811bef 100644</s=
pan><br><span>--- a/src/openvpn/error=2Eh</span><br><span>+++ b/src/openvpn=
/error=2Eh</span><br><span>@@ -158,7 +158,7 @@</span><br><span>         }  =
                              \</span><br><span>         EXIT_FATAL(flags);=
               \</span><br><span>     } while (false)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> #de=
fine dmsg(flags, =2E=2E=2E)                 \</span><br><span>     do      =
                             \</span><br><span>     {                      =
              \</span><br><span>diff --git a/src/openvpn/event=2Ec b/src/op=
envpn/event=2Ec</span><br><span>index 8b7716a=2E=2E2cb4e04 100644</span><br=
><span>--- a/src/openvpn/event=2Ec</span><br><span>+++ b/src/openvpn/event=
=2Ec</span><br><span>@@ -398,7 +398,7 @@</span><br><span> </span><br><span>=
     dmsg(D_EVENT_WAIT, &quot;WE_WAIT enter n=3D%d to=3D%d&quot;, wes-&gt;n=
_events, timeout);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check_debug_le=
vel(D_EVENT_WAIT))</span><br><span>     {</span><br><span>         int i;</=
span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=
=2Ec</span><br><span>index 6fe5849=2E=2E7811245 100644</span><br><span>--- =
a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</sp=
an><br><span>@@ -50,7 +50,7 @@</span><br><span> </span><br><span> /* show e=
vent wait debugging info */</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> </span><br><s=
pan> static const char *</span><br><span> wait_status_string(struct context=
 *c, struct gc_arena *gc)</span><br><span>@@ -2190,7 +2190,7 @@</span><br><=
span>         {</span><br><span>             int status;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</=
span><br><span>             if (check_debug_level(D_EVENT_WAIT))</span><br>=
<span>             {</span><br><span>                 show_wait_status(c);<=
/span><br><span>diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2E=
c</span><br><span>index 39fa482=2E=2E261d25a 100644</span><br><span>--- a/s=
rc/openvpn/mroute=2Ec</span><br><span>+++ b/src/openvpn/mroute=2Ec</span><b=
r><span>@@ -501,7 +501,7 @@</span><br><span>     }</span><br><span>     mh-=
&gt;n_net_len =3D j;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check_debug_=
level(D_MULTI_DEBUG))</span><br><span>     {</span><br><span>         struc=
t gc_arena gc =3D gc_new();</span><br><span>diff --git a/src/openvpn/mtcp=
=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index 5d88f8a=2E=2Eb0125f1 1006=
44</span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/ope=
nvpn/mtcp=2Ec</span><br><span>@@ -74,7 +74,7 @@</span><br><span>         mi=
-&gt;did_real_hash =3D true;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span>=
<br><span>     if (mi)</span><br><span>     {</span><br><span>         dmsg=
(D_MULTI_DEBUG, &quot;MULTI TCP: instance added: %s&quot;, mroute_addr_prin=
t(&amp;mi-&gt;real, &amp;gc));</span><br><span>diff --git a/src/openvpn/mud=
p=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 88b0091=2E=2E4794b7e 100=
644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/op=
envpn/mudp=2Ec</span><br><span>@@ -431,7 +431,7 @@</span><br><span>        =
 }</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check_d=
ebug_level(D_MULTI_DEBUG))</span><br><span>     {</span><br><span>         =
struct gc_arena gc =3D gc_new();</span><br><span>diff --git a/src/openvpn/m=
ulti=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 3e72b92=2E=2E67204c3=
 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/s=
rc/openvpn/multi=2Ec</span><br><span>@@ -1145,7 +1145,7 @@</span><br><span>=
         }</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>    =
 if (check_debug_level(D_MULTI_DEBUG))</span><br><span>     {</span><br><sp=
an>         struct gc_arena gc =3D gc_new();</span><br><span>diff --git a/s=
rc/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index 36=
04684=2E=2E4b96c57 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</s=
pan><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -46,7 +46,7=
 @@</span><br><span> #define MULTI_IO_FILE_CLOSE_WRITE ((void *)5)</span><b=
r><span> #define MULTI_IO_DCO              ((void *)6)</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</sp=
an><br><span> static const char *</span><br><span> pract(int action)</span>=
<br><span> {</span><br><span>@@ -89,7 +89,7 @@</span><br><span>            =
 return &quot;?&quot;;</span><br><span>     }</span><br><span> }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_DEBUG */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </=
span><br><span> static inline struct context *</span><br><span> multi_get_c=
ontext(struct multi_context *m, struct multi_instance *mi)</span><br><span>=
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><s=
pan>index e3cd527=2E=2Ee8ec9db 100644</span><br><span>--- a/src/openvpn/opt=
ions=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -=
785,7 +785,7 @@</span><br><span> #endif /* ENABLE_PKCS11 */</span><br><span=
>     &quot;\n&quot;</span><br><span>     &quot;General Standalone Options:=
\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE=
_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABL=
E_SMALL</span><br><span>     &quot;--show-gateway [address]: Show info abou=
t gateway [to v4/v6 address]=2E\n&quot;</span><br><span> #endif</span><br><=
span>     ;</span><br><span>@@ -4229,7 +4229,7 @@</span><br><span>         =
read_config_file(options, p[1], level, file, line, msglevel, permission_mas=
k,</span><br><span>                          option_types_found, es);</span=
><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if =
defined(ENABLE_DEBUG) &amp;&amp; !defined(ENABLE_SMALL)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>  =
   else if (streq(p[0], &quot;show-gateway&quot;) &amp;&amp; !p[2])</span><=
br><span>     {</span><br><span>         struct route_gateway_info rgi;</sp=
an><br><span>@@ -4938,12 +4938,13 @@</span><br><span>              * mbed T=
LS always generating debug level logging */</span><br><span>             op=
tions-&gt;ssl_flags |=3D SSLF_TLS_DEBUG_ENABLED;</span><br><span>         }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(ENABLE_D=
EBUG) &amp;&amp; !defined(ENABLE_SMALL)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(ENABLE_SMALL)</span><br><span>         /* W=
arn when a debug verbosity is supplied when built without debug support */<=
/span><br><span>         if (options-&gt;verbosity &gt;=3D 7)</span><br><sp=
an>         {</span><br><span>             msg(M_WARN,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                &quot;NOTE: debug verbosit=
y (--verb %d) is enabled but this build lacks debug support=2E&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;NOT=
E: debug verbosity (--verb %d) is enabled but this build is &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;built =
with --enable-small that lacks support for high --verb settings&quot;,</spa=
n><br><span>                 options-&gt;verbosity);</span><br><span>      =
   }</span><br><span> #endif</span><br><span>diff --git a/src/openvpn/packe=
t_id=2Ec b/src/openvpn/packet_id=2Ec</span><br><span>index a4b627c=2E=2E22c=
53c7 100644</span><br><span>--- a/src/openvpn/packet_id=2Ec</span><br><span=
>+++ b/src/openvpn/packet_id=2Ec</span><br><span>@@ -52,18 +52,18 @@</span>=
<br><span> #define SEQ_UNSEEN  ((time_t)0)</span><br><span> #define SEQ_EXP=
IRED ((time_t)1)</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> static void packet_id_de=
bug_print(msglvl_t msglevel, const struct packet_id_rec *p,</span><br><span=
>                                   const struct packet_id_net *pin, const =
char *message,</span><br><span>                                   packet_id=
_print_type value);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif /* ENABLE_DEBUG */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> static inli=
ne void</span><br><span> packet_id_debug(msglvl_t msglevel, const struct pa=
cket_id_rec *p,</span><br><span>                 const struct packet_id_net=
 *pin, const char *message, uint64_t value)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><sp=
an>     if (unlikely(check_debug_level(msglevel)))</span><br><span>     {</=
span><br><span>         packet_id_debug_print(msglevel, p, pin, message, va=
lue);</span><br><span>@@ -576,7 +576,7 @@</span><br><span>     return (char=
 *)out=2Edata;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> </s=
pan><br><span> static void</span><br><span> packet_id_debug_print(msglvl_t =
msglevel, const struct packet_id_rec *p,</span><br><span>@@ -648,7 +648,7 @=
@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENA=
BLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span> </span><br><span> uint16_t</span><br><span> packet_id_read=
_epoch(struct packet_id_net *pin, struct buffer *buf)</span><br><span>diff =
--git a/src/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec</span><br><span>ind=
ex f8adde5=2E=2Ed10f9fa 100644</span><br><span>--- a/src/openvpn/plugin=2Ec=
</span><br><span>+++ b/src/openvpn/plugin=2Ec</span><br><span>@@ -993,7 +99=
3,7 @@</span><br><span>     pr-&gt;n =3D 0;</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DE=
BUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_S=
MALL</span><br><span> void</span><br><span> plugin_return_print(const msglv=
l_t msglevel, const char *prefix, const struct plugin_return *pr)</span><br=
><span> {</span><br><span>diff --git a/src/openvpn/plugin=2Eh b/src/openvpn=
/plugin=2Eh</span><br><span>index 7e9faf3=2E=2E684632c 100644</span><br><sp=
an>--- a/src/openvpn/plugin=2Eh</span><br><span>+++ b/src/openvpn/plugin=2E=
h</span><br><span>@@ -135,7 +135,7 @@</span><br><span> </span><br><span> vo=
id plugin_return_free(struct plugin_return *pr);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br=
><span> void plugin_return_print(const msglvl_t msglevel, const char *prefi=
x, const struct plugin_return *pr);</span><br><span> </span><br><span> #end=
if</span><br><span>diff --git a/src/openvpn/reliable=2Ec b/src/openvpn/reli=
able=2Ec</span><br><span>index ced438e=2E=2Eb5315ff 100644</span><br><span>=
--- a/src/openvpn/reliable=2Ec</span><br><span>+++ b/src/openvpn/reliable=
=2Ec</span><br><span>@@ -462,7 +462,7 @@</span><br><span>     }</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#ifndef ENABLE_SMALL</span><br><span> /* print the current sequence of =
active packet IDs */</span><br><span> static const char *</span><br><span> =
reliable_print_ids(const struct reliable *rel, struct gc_arena *gc)</span><=
br><span>@@ -480,7 +480,7 @@</span><br><span>     }</span><br><span>     re=
turn BSTR(&amp;out);</span><br><span> }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif /* ENABLE_DEBUG */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> /* true i=
f at least one free buffer available */</span><br><span> bool</span><br><sp=
an>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><sp=
an>index 03a2526=2E=2Ee8001b3 100644</span><br><span>--- a/src/openvpn/rout=
e=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -81,7 =
+81,7 @@</span><br><span> </span><br><span> static void get_bypass_addresse=
s(struct route_bypass *rb, const unsigned int flags);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</spa=
n><br><span> </span><br><span> static void</span><br><span> print_bypass_ad=
dresses(const struct route_bypass *rb)</span><br><span>@@ -617,7 +617,7 @@<=
/span><br><span>     if (rl-&gt;ngi=2Eflags &amp; RGI_ADDR_DEFINED)</span><=
br><span>     {</span><br><span>         setenv_route_addr(es, &quot;net_ga=
teway&quot;, rl-&gt;ngi=2Egateway=2Eaddr, -1);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if defined(ENABLE_DEBUG) &amp;&amp; !defined(ENAB=
LE_SMALL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef EN=
ABLE_SMALL</span><br><span>         print_default_gateway(D_ROUTE, &amp;rl-=
&gt;rgi, NULL);</span><br><span> #endif</span><br><span>     }</span><br><s=
pan>@@ -660,7 +660,7 @@</span><br><span>             add_block_local_routes=
(rl);</span><br><span>         }</span><br><span>         get_bypass_addres=
ses(&amp;rl-&gt;spec=2Ebypass, rl-&gt;flags);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>         print=
_bypass_addresses(&amp;rl-&gt;spec=2Ebypass);</span><br><span> #endif</span=
><br><span>     }</span><br><span>@@ -768,7 +768,7 @@</span><br><span>     =
if (rl6-&gt;ngi6=2Eflags &amp; RGI_ADDR_DEFINED)</span><br><span>     {</sp=
an><br><span>         setenv_str(es, &quot;net_gateway_ipv6&quot;, print_in=
6_addr(rl6-&gt;ngi6=2Egateway=2Eaddr_ipv6, 0, &amp;gc));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DEBUG) &amp;&amp; !de=
fined(ENABLE_SMALL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#ifndef ENABLE_SMALL</span><br><span>         print_default_gateway(D_ROUTE=
, NULL, &amp;rl6-&gt;rgi6);</span><br><span> #endif</span><br><span>     }<=
/span><br><span>diff --git a/src/openvpn/schedule=2Ec b/src/openvpn/schedul=
e=2Ec</span><br><span>index 6772ad6=2E=2E6c60dc2 100644</span><br><span>---=
 a/src/openvpn/schedule=2Ec</span><br><span>+++ b/src/openvpn/schedule=2Ec<=
/span><br><span>@@ -33,7 +33,7 @@</span><br><span> </span><br><span> #inclu=
de &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> static void</sp=
an><br><span> schedule_entry_debug_info(const char *caller, const struct sc=
hedule_entry *e)</span><br><span> {</span><br><span>@@ -308,7 +308,7 @@</sp=
an><br><span> void</span><br><span> schedule_add_modify(struct schedule *s,=
 struct schedule_entry *e)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span>     if (check=
_debug_level(D_SCHEDULER))</span><br><span>     {</span><br><span>         =
schedule_entry_debug_info(&quot;schedule_add_modify&quot;, e);</span><br><s=
pan>@@ -355,7 +355,7 @@</span><br><span>         }</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifde=
f ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnd=
ef ENABLE_SMALL</span><br><span>     if (check_debug_level(D_SCHEDULER))</s=
pan><br><span>     {</span><br><span>         schedule_entry_debug_info(&qu=
ot;schedule_find_least&quot;, e);</span><br><span>diff --git a/src/tapctl/e=
rror=2Eh b/src/tapctl/error=2Eh</span><br><span>index f9586dc=2E=2E34aa894 =
100644</span><br><span>--- a/src/tapctl/error=2Eh</span><br><span>+++ b/src=
/tapctl/error=2Eh</span><br><span>@@ -83,7 +83,7 @@</span><br><span>       =
  }                                \</span><br><span>         EXIT_FATAL(fl=
ags);               \</span><br><span>     } while (false)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_SMALL</span><br><span> =
#define dmsg(flags, =2E=2E=2E)                 \</span><br><span>     do   =
                                \</span><br><span>     {                   =
                 \</span><br></pre><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail">change 1942</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f96cd1c3488b=
558b8a597594d99edcba1214d27 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1942 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flicht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>

</body></html>
--TAxokjS+Ntg=--


--===============5202265481904489643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5202265481904489643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5202265481904489643==--

