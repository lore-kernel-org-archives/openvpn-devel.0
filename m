Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046EDC61DB9
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/cLVthlXGbJJYMxrYAAxSGM7QLS5qj9dI+lD9lDw3LI=; b=Ze1T9LJpYCmZr/iyVwllZspcZX
	58Gmm4JlNUUOc/vWxdUV2ILOs+8+NYIQuS4aB2upbXdJsSDOvjMTIcDYlPPTfjd3fmrWo4uBfni8C
	dNqJFkcfnFnqaCpP2Az5jQuLAitdKdFxmZlKwpboIgMinZlLKqGsjSIu/Lf3IhcWmIbo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wztoT-0008A4-16;
	Fri, 28 Aug 2026 10:27:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wztoA-00089j-1L
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:27:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BRySXR/hoS1IJr/88KIsN1irENVqX9oQaEw/HjjL7K4=; b=GGZV0bCfqF5Vl8MKMehZqk0Ogf
 DRFS/YDrnWk+aJS+rHJKBQ+CXofs8u4hmoWBdt0+q2mLrUZBHfAZr33gqa3T5fdpEx/a0nFGKyRcd
 KnJvCIahA6eIS9cLj8jIDJtrFRHKXRI8fATh781RpsMUnf4UzDGWIGRkj05ba7OD8wO4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BRySXR/hoS1IJr/88KIsN1irENVqX9oQaEw/HjjL7K4=; b=f
 PTsZF9ZQXnLkK9NsLsuLLwjlQODX1fv8PEgDUZRDqvdYod4shDvWsymlEXRWHe3fHw+2KfASs9X5T
 rQ7/HY910ZuDE4qPM5FMOmpCyN9HpPpeH5BG9KXro3GQmS7QVtoIw4SRLryxlCcTXzW03942nnRuH
 YL2ije6jVCbdsckU=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wztnw-0001Fv-Aq for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:27:26 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49b8ce9b733so5855875e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 03:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787912838; x=1788517638; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BRySXR/hoS1IJr/88KIsN1irENVqX9oQaEw/HjjL7K4=;
 b=BJPgmMivdHWMCBvFGRNaLLz/OtOk+B543Zz9Gj+x1bzeM3VDX545WJeQUJsETVyzYi
 9kgNeik10Xxy4bDYd45X3xxulztk69ZLCcLTaWTDk1JS8AjuvmOgTubQirNoGsqtg+UL
 CW5Rh775f89hAZ5LgR7PTKMUDUgQSj8aXpWsSbk3RoD4+yP442XVT12+j/Vy7zTpnrwu
 BwEfaHduyowT30LY0dRK0cEVQU+PIfwSXitG86mt8nM5XQ0Q6xklBG83akjh4PnvDgoR
 FIbG/kMM2Jkq2YrGETJDdoECf401EauL70tClcPrPQ84SNxDRjaoMejUNDD1TbG261B3
 mZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787912838; x=1788517638;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BRySXR/hoS1IJr/88KIsN1irENVqX9oQaEw/HjjL7K4=;
 b=TlGDDncTVZ8hboIb2Bs5u+IDwLrHtzlkWdg08swBFgrCWWrdP0Pjj/PLKacYq8/jTs
 qoO0MMAMDdUkDRZ9qp5me3qapHQzX28IoDhLxKkVF5r1zILGQ2ERE7jWTVcfzW3zJLbi
 XN2MkhO/s8Ip8L+OgomnJAwCGpgoTjK2z1pkhvUXh+6cqAMejVRtyrdXEgZ/6eLBUlUW
 3h8rViPWh9eyIFXZgNnoGLdk4mVSJIiBToJe9cZYX1N+pEfdrBPcQ7q2WwZb5eJbc2rm
 19J7L6Xi5g8ENVrN7PNsmkcM0EAEYi72md5pqo2bGVVuQ0gL5hyr0MfQWc7vZIogoiVY
 Q/aw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhYfjV0HOlyRfe65HktaWWti7SAV75vYVRtMBNTMUvmzrB6OLP7xYaffYiVT6ju7ZBNSUUbUqSXwTZG4TH@lists.sourceforge.net
X-Gm-Message-State: AFuF++lZ4gcr31HrKY/KQ5xKYe46sMpWwaigtWbBli9ipbpj2jVd6Jly
 gutSiae08QqAkZ+mTo3iaPkavh8edLqkUQQUFc0KMGLkQsF2eR8RiQGglm064Cm5+dd5gy/pCHN
 EiTP2075s/2d60QIONgAwYP0H8u1Tq+PY2K3rMuL81HVdm56gZHv2wTE4MzuBY/a/coHr
X-Gm-Gg: AR+sD13BszYsOB8Um0r9HM/Z2r5Qwx54uwyYzEISm7T9PAaW26ne5dHO20GHsYCNJ2O
 tVUnUGhALqi8GRGEg92o//ls+G5VWT3/cdE+9/KmNXjDUP0/o41IAJllhqVXKuQzCDhhdigTUrN
 Q6e+ovjJkCzndTfQn46g/k7AgIMKopQZM5SdW0MCT4vyG0/7eBqvjkSF17EDQ7RboJ4x48ynKI7
 LCx3D+EhZdvFJyB7c6isZcbeaJjcvbfjroxGPnWcTEoaKuvk69029z2K35NutMNjgWN8Yix7vHg
 dipZj8htYCwIgdTLaOEQnR8R9DFxOHvi/lnIKbz+AX1Px7LRiAttR/4B0pl6PTBMXuMsyixDj9r
 g871LFH2DEVoE2c05nDI6b6hED/neDR8Lc6OUhp+2are61Fwt2rBzrlBO1YDauPC4JvkIXVLRFd
 OHXz1bjXpkpz8pGF7im2XtHoM9jfNfLVUImr/+VC57LvueyUi0GZUV3v1JYTddmZfU/voC7u1Ep
 DrNXUDa6/9RVInNi67P8o5roEPwH0A19Awul5F/w5xqtRrfSKD9LV7YQ4oMJ1YDhM7mF3xwHUnf
 gJPAQHm7y+n+KBgFHuZmBe1E37AiGx9u/lOHlVs47IK9Is02CkM=
X-Received: by 2002:a05:600c:609a:b0:49b:9032:9c94 with SMTP id
 5b1f17b1804b1-49b91bd41eemr88386245e9.0.1787912837622; 
 Fri, 28 Aug 2026 03:27:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9500c80asm42248265e9.9.2026.08.28.03.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 03:27:17 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 10:27:16 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ic1ed693f73029f5b5609f717333fdaaabe42acbd
X-Gerrit-Change-Number: 1853
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1853?usp=email>
X-Gerrit-Commit: 79f5dc97f643d5157d5b9eebd1481af6960b3aab
In-Reply-To: <gerrit.1787327336000.Ic1ed693f73029f5b5609f717333fdaaabe42acbd@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ic1ed693f73029f5b5609f717333fdaaabe42acbd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkljMWVkNjkzZjczMDI5ZjViNTYwOWY3MTczMzNmZGFhYWJlNDJhY2JkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <683a0bc269106257d59bc2182fa97584338c2022-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wztnw-0001Fv-Aq
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Move mocks from
 test_push_update_msg into its own compile unit
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
Content-Type: multipart/mixed; boundary="===============7970703031823140147=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7970703031823140147==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WysHuyxU83c="; charset=UTF-8

--WysHuyxU83c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1853?usp=3Demail )

Change subject: Move mocks from test_push_update_ms=
g into its own compile unit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Move mocks from test_push_update_msg into its own compile =
unit

This allows these mocks to be reused by other unit tests that
need to=
 include push_util=2Ec/h functions=2E

Change-Id: Ic1ed693f73029f5b5609f717=
333fdaaabe42acbd
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1853
Message-Id: <20260826185329=2E18177-1-gert@gr=
eenie=2Emuc=2Ede>
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---=

M CMakeLists=2Etxt
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/unit_t=
ests/openvpn/mock_push_dependencies=2Ec
M tests/unit_tests/openvpn/test_pus=
h_update_msg=2Ec
4 files changed, 71 insertions(+), 42 deletions(-)




dif=
f --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 2c3324d=2E=2E6eb5954 10=
0644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -930,6 +930,7 @@
    =
 target_sources(test_push_update_msg PRIVATE
         tests/unit_tests/open=
vpn/mock_msg=2Ec
         tests/unit_tests/openvpn/mock_get_random=2Ec
+   =
     tests/unit_tests/openvpn/mock_push_dependencies=2Ec
         src/openv=
pn/options_util=2Ec
         src/openvpn/otime=2Ec
         src/openvpn/lis=
t=2Ec
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_test=
s/openvpn/Makefile=2Eam
index 6db611e=2E=2E5954902 100644
--- a/tests/unit_=
tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@=
 -400,6 +400,7 @@
 push_update_msg_testdriver_SOURCES =3D test_push_update_=
msg=2Ec \
 	mock_msg=2Ec \
 	mock_get_random=2Ec \
+	mock_push_dependencies=
=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn=
/platform=2Ec \
 	$(top_srcdir)/src/openvpn/options_util=2Ec \
diff --git a=
/tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/ope=
nvpn/mock_push_dependencies=2Ec
new file mode 100644
index 0000000=2E=2E112=
bcfd
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2E=
c
@@ -0,0 +1,69 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP=
 networks
+ *             over a single UDP port, with support for SSL/TLS-=
based
+ *             session authentication and key exchange,
+ *         =
    packet encryption, packet authentication, and
+ *             packet co=
mpression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2E=
net>
+ *
+ *  This program is free software; you can redistribute it and/or=
 modify
+ *  it under the terms of the GNU General Public License version 2=

+ *  as published by the Free Software Foundation=2E
+ *
+ *  This program=
 is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WA=
RRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNES=
S FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for =
more details=2E
+ *
+ *  You should have received a copy of the GNU General=
 Public License along
+ *  with this program; if not, see <https://www=2Egn=
u=2Eorg/licenses/>=2E
+ */
+
+/* Set of mocked function/globals to get unit=
 tests to
+ * compile that use the push_util=2Ec file */
+
+
+#ifdef HAVE_C=
ONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "error=2Eh"
+#include "o=
ptions=2Eh"
+
+void
+throw_signal_soft(const int signum, const char *signal=
_text)
+{
+    msg(M_WARN, "Offending option received from server");
+}
+
+=
uint64_t
+pull_permission_mask(const struct context *c)
+{
+    uint64_t fl=
ags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
+  =
                   | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP=
 | OPT_P_PERSIST
+                     | OPT_P_MESSAGES | OPT_P_EXPLICIT_NO=
TIFY | OPT_P_ECHO | OPT_P_PULL_MODE
+                     | OPT_P_PEER_ID |=
 OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+    return flag=
s;
+}
+
+void
+unlearn_ifconfig(struct multi_context *m, struct multi_insta=
nce *mi)
+{
+}
+
+void
+unlearn_ifconfig_ipv6(struct multi_context *m, stru=
ct multi_instance *mi)
+{
+}
+
+void
+update_vhash(struct multi_context *m,=
 struct multi_instance *mi, const char *new_ip, const char *new_ipv6)
+{
+}=

+
+bool
+options_postprocess_pull(struct options *options, struct env_set =
*es)
+{
+    return true;
+}
diff --git a/tests/unit_tests/openvpn/test_pus=
h_update_msg=2Ec b/tests/unit_tests/openvpn/test_push_update_msg=2Ec
index =
2653749=2E=2Ea93f916 100644
--- a/tests/unit_tests/openvpn/test_push_update=
_msg=2Ec
+++ b/tests/unit_tests/openvpn/test_push_update_msg=2Ec
@@ -12,48 =
+12,6 @@
 
 #include "push_util=2Ec"
 
-/* mocks */
-
-void
-throw_signal_s=
oft(const int signum, const char *signal_text)
-{
-    msg(M_WARN, "Offendi=
ng option received from server");
-}
-
-uint64_t
-pull_permission_mask(cons=
t struct context *c)
-{
-    uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTR=
AS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
-                     | OPT_P_SETENV |=
 OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
-                 =
    | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE=

-                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P=
_ROUTE | OPT_P_DHCPDNS;
-    return flags;
-}
-
-void
-unlearn_ifconfig(str=
uct multi_context *m, struct multi_instance *mi)
-{
-    return;
-}
-
-void=

-unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi)=

-{
-    return;
-}
-
-void
-update_vhash(struct multi_context *m, struct m=
ulti_instance *mi, const char *new_ip, const char *new_ipv6)
-{
-    return=
;
-}
-
-bool
-options_postprocess_pull(struct options *options, struct env_=
set *es)
-{
-    return true;
-}
-
 /*
  * Counters to track route accumula=
tion across continuation messages=2E
  * Used to verify the bug where updat=
e_options_found resets per message=2E

-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1853?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Ic1ed693f73029f5b5609f717333fdaaabe42acbd
Gerrit-Change-Num=
ber: 1853
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--WysHuyxU83c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1853?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Move mocks from test_push_update_msg into =
its own compile unit<br><br>This allows these mocks to be reused by other u=
nit tests that<br>need to include push_util=2Ec/h functions=2E<br><br>Chang=
e-Id: Ic1ed693f73029f5b5609f717333fdaaabe42acbd<br>Signed-off-by: Arne Schw=
abe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1853<br>Message-Id: &lt;20260826185329=2E18177-1-gert@greenie=2Emuc=2Ede&=
gt;<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<b=
r>M CMakeLists=2Etxt<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests=
/unit_tests/openvpn/mock_push_dependencies=2Ec<br>M tests/unit_tests/openvp=
n/test_push_update_msg=2Ec<br>4 files changed, 71 insertions(+), 42 deletio=
ns(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</sp=
an><br><span>index 2c3324d=2E=2E6eb5954 100644</span><br><span>--- a/CMakeL=
ists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -930,6=
 +930,7 @@</span><br><span>     target_sources(test_push_update_msg PRIVATE=
</span><br><span>         tests/unit_tests/openvpn/mock_msg=2Ec</span><br><=
span>         tests/unit_tests/openvpn/mock_get_random=2Ec</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/moc=
k_push_dependencies=2Ec</span><br><span>         src/openvpn/options_util=
=2Ec</span><br><span>         src/openvpn/otime=2Ec</span><br><span>       =
  src/openvpn/list=2Ec</span><br><span>diff --git a/tests/unit_tests/openvp=
n/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>in=
dex 6db611e=2E=2E5954902 100644</span><br><span>--- a/tests/unit_tests/open=
vpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=
=2Eam</span><br><span>@@ -400,6 +400,7 @@</span><br><span> push_update_msg_=
testdriver_SOURCES =3D test_push_update_msg=2Ec \</span><br><span> 	mock_ms=
g=2Ec \</span><br><span> 	mock_get_random=2Ec \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	mock_push_dependencies=2Ec \</span><br><span> =
	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src=
/openvpn/platform=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/options=
_util=2Ec \</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_push=
_dependencies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</sp=
an><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E112bcf=
d</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/open=
vpn/mock_push_dependencies=2Ec</span><br><span>@@ -0,0 +1,69 @@</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel=
 IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
        over a single UDP port, with support for SSL/TLS-based</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             session authentic=
ation and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             packet encryption, packet authentication, and</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compress=
ion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 Op=
enVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  This program is free software; you can redistribute it and/or modify</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the term=
s of the GNU General Public License version 2</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed i=
n the hope that it will be useful,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warra=
nty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTA=
BILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more =
details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have receiv=
ed a copy of the GNU General Public License along</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https:=
//www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Set of mocked fun=
ction/globals to get unit tests to</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * compile that use the push_util=2Ec file */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;e=
rror=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;options=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+throw_signal_soft(const in=
t signum, const char *signal_text)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 msg(M_WARN, &quot;Offending option received from server&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+uint64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pul=
l_permission_mask(const struct context *c)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF |=
 OPT_P_SOCKFLAGS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                  | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP =
| OPT_P_PERSIST</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                 | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OP=
T_P_PULL_MODE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
               | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE |=
 OPT_P_DHCPDNS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+unlearn_ifconfig(struct multi_context *m, struct multi_i=
nstance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+update_vhash(str=
uct multi_context *m, struct multi_instance *mi, const char *new_ip, const =
char *new_ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+options_postprocess_pull(struct options *options, struct env_set *es)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit_te=
sts/openvpn/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/test_push_u=
pdate_msg=2Ec</span><br><span>index 2653749=2E=2Ea93f916 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><spa=
n>+++ b/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><span>@=
@ -12,48 +12,6 @@</span><br><span> </span><br><span> #include &quot;push_ut=
il=2Ec&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-/* mocks */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-throw_signal_soft(const int signum, con=
st char *signal_text)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_WARN, &quo=
t;Offending option received from server&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint64_t</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-pull_permission_mask(const s=
truct context *c)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint64_t flags =3D O=
PT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                     | OPT_P_SETEN=
V | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                     | OPT_P_MESSAGES=
 | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                     | OPT_P_PEER_ID | OP=
T_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    return flags;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-unlearn_ifconfig(struct mu=
lti_context *m, struct multi_instance *mi)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instanc=
e *mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-update_vhash(struct multi_=
context *m, struct multi_instance *mi, const char *new_ip, const char *new_=
ipv6)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    return;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-options_postprocess_pull(stru=
ct options *options, struct env_set *es)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span=
><br><span>  * Counters to track route accumulation across continuation mes=
sages=2E</span><br><span>  * Used to verify the bug where update_options_fo=
und resets per message=2E</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1853?usp=3Demail">ch=
ange 1853</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1853?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ic1ed693f73029f5b5609f717333fdaaabe42acbd </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1853 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--WysHuyxU83c=--


--===============7970703031823140147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7970703031823140147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7970703031823140147==--

