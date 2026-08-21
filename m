Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EAEC5DF9C
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 20:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=20QYSPT2JoibB1ZK0Ney+4D2F1cWKHbBEp+okll0awc=; b=kphVErXcp3A8JQ8q1kRX3V9+KA
	THRAh36qlQYEqdi7NIoagRFIPG410v1NR9Djbiqh/TufLyWgrH21Z6tNT6uyTgLyI4DYs9gXWD5mE
	2xvMA99Bj+bmiCUwBEGYA0kRYle2lwsrOj3R+a5qnafyizsGHf2MGcgpDKA4czjG2XUM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxWCY-0001pi-Ly;
	Fri, 21 Aug 2026 20:50:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxWCE-0001pN-8a
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 20:50:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/DVUknTWU6dIRmWSod24IaTeaI9EmN9NSJQvo1PsiKA=; b=Wb/taJqzoTgebl8eZQZBofN/fn
 nb6nrr9Ia8sJDT1FMZnCJDnKFeiNIIz5enQkaZtle+mTUYVvOGOmLdwCibx195GHZ9RQ+RVBkvtQs
 1ECtBS5ucd39m1bLfY1zUaYkaKcf6glanbMaNUVbzm3oD3+n9OvY0kg2gMmaU5XbtYeo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/DVUknTWU6dIRmWSod24IaTeaI9EmN9NSJQvo1PsiKA=; b=F
 zeVETe64IdIbD8lzW+Mi/Yauc5rUoYxwrjcVpqugcwoTtjLY1jXfqpcpsxzsZvOooGX/l6nhzW6bt
 JzwPDZZSKVzZ2UuQd+UyPzVi4LgK023iQhKoL50P1jG6EwHQtaz7+gtZoErjZRytO3bdRuNlyzSZe
 t2J15Gf6VZeIY+b4=;
Received: from mail-ej1-f42.google.com ([209.85.218.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxWCC-00052p-RU for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 20:50:37 +0000
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c15e2dab83eso280144866b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 13:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787345430; x=1787950230; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/DVUknTWU6dIRmWSod24IaTeaI9EmN9NSJQvo1PsiKA=;
 b=cW4Nb35EWuRDDrLom3KRrt1vpnbRwQqftq33Qo3N5Ke/DU1X2Acn+sDnWWsl2v5yQP
 ibHkqoA1NcLEKVOTqKG8ctD3fnfbPlB79AEJMTNAxL9WN8Qgc2T4kyKRmcynlwAYSPoE
 TMG2h7+t6aXXeseG8lFhjwD3Ei3paIWIKh3ShCPaGXa3PLqd+o5kNWpf6GcoPm1HgyTS
 MbXa30L/dOWnPV/CVuVhPQ3pkLFAyghbOJlzq2Erh5E8sS80stYzz0Yl9Bvi7cPp/Nwc
 pJW9iDJwXDyMaJI6jc+HXZ91vpLWHZockdwqVrgn1L7kS0/CUDHw4dShbvEOv8L5NqL4
 lRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787345430; x=1787950230;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/DVUknTWU6dIRmWSod24IaTeaI9EmN9NSJQvo1PsiKA=;
 b=B27BFFGoStTC4PmkCxJPGewYenE7Ow+LsD3W3BbuaU6nraqjBoaDAQ7ZwIUQQGuurJ
 cQxgSCcfmC79yU9/rPIyKRCb6XIS5uZE2sp5m17GbRWAUVxrGp+fIylQLQryNiRKOkgA
 r5lSBA+sJSOSoppKiiEc4R0MEd2ptvr2k4y6+olwjSyqrOzUPMOWea6d+ZFfpaUlGlOK
 zMdriJdnjWyrwYgacNEGCnGjHbWkwW6bUX6+AeNxyVt+HpDj9Dv+eYiAy0yf+IhPol5w
 V47ZEgkD7yrB8Jsq6lp8g3l1wjxwo+Q4EMj13L5L9vhKoMHdKnKDQaQvsp1noydpoZMf
 8grA==
X-Gm-Message-State: AFuF++l2OZhVMfbGd2MeagNmdgdRTlv+3qSkKgSduQ2f+gslbIjygfeX
 3DCSoEikkcoNxAxatOC697peeZA4jAihLyMepeRMXy6l41jL0KrKcCMEV84SAhdD9+1f5DzT588
 psMGzYqFLyk+egbdyGx7Ap1OeeJuul+jfRgr6TamCS8gDNF9iAd2D5UysIBNIulLDq9W65yb6w1
 gv0S9V2w==
X-Gm-Gg: AR+sD11zJTaFovx/pvGaPQOzEtz2hnAzjFI4e80AaLSVeCPxH7PXMmdYlIVSJso3qqu
 klEEh5tUP/lzka8NYa66yQ0bBdPbJADRJgDJNJnloFUnPjw92GhFNLNZB9nE8811HFxlbV/870z
 kLEXfqEZAYVqii0jDxHKnuZ0fQluAm+P+rdPPraJYrZWBZh2x9N51AjFPlMTcJ6MT5ndSUmEVU3
 ucjgxwKgXQguwgRi4X/mkXexlB3L/Ibxgn9+oWkH5D0H4PQtIftLr8h0Qolelcu/W+tugONvFeW
 ddHO3lb4ryy2xKfYP+HcPC5TufrCHxieZ/FPuLPWUDrG5iHaO15JO92EqpwO2NZkbWGxReo402z
 0xCrc6+P7CMMvYT98Eaiop0Cfr71T75WjsaZBQBHyatJ2FzusMTtMWlC6YBpuw+QNbrEJsgM00u
 SNNdO6HytuhuAJocqLXsRf5k6I3Ry0GmmrtMyEi8M6cnH1DYQHX4jLF1N5oGaZnj1wDADIo+H+M
 do57pvW80izdSEf2xHxOGyj67/d7h2cYkZRJ8Mkyz9CKK16p9Txp+AzPXgs/TrEpXezpnCkUc71
 /r9jMkSmo5qMBk6Ra/RcKmVauQ5Zp/t8Sl7YO2u5lFDhG95nUbOgBT92JK/eNA==
X-Received: by 2002:a17:907:3e02:b0:c21:6f8c:2335 with SMTP id
 a640c23a62f3a-c246a6b1745mr910897766b.16.1787345429905; 
 Fri, 21 Aug 2026 13:50:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2459198ec5sm578415366b.34.2026.08.21.13.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 13:50:29 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 20:50:16 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic1ed693f73029f5b5609f717333fdaaabe42acbd
X-Gerrit-Change-Number: 1853
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1853?usp=email>
X-Gerrit-Commit: f5493c91298a2f9c8807625ebf3dffd41b4d802b
In-Reply-To: <gerrit.1787327336000.Ic1ed693f73029f5b5609f717333fdaaabe42acbd@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ic1ed693f73029f5b5609f717333fdaaabe42acbd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkljMWVkNjkzZjczMDI5ZjViNTYwOWY3MTczMzNmZGFhYWJlNDJhY2JkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4b42a287b9b5ec15743d678d64547e3da0f50930-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxWCC-00052p-RU
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1810582479795668004=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1810582479795668004==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tlNRNNC5g74="; charset=UTF-8

--tlNRNNC5g74=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#2)=2E ( http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1853?usp=3Demail )


Change subject: Move mocks from test_p=
ush_update_msg into its own compile unit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Move mocks from test_push_update_msg into its =
own compile unit

This allows these mocks to be reused by other unit tests =
that
need to include push_util=2Ec/h functions=2E

Change-Id: Ic1ed693f7302=
9f5b5609f717333fdaaabe42acbd
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eor=
g>
---
M CMakeLists=2Etxt
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/=
unit_tests/openvpn/mock_push_dependencies=2Ec
M tests/unit_tests/openvpn/te=
st_push_update_msg=2Ec
4 files changed, 71 insertions(+), 42 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/53/1853=
/2

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 2c3324d=2E=2E6eb=
5954 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -930,6 +930,7 =
@@
     target_sources(test_push_update_msg PRIVATE
         tests/unit_tes=
ts/openvpn/mock_msg=2Ec
         tests/unit_tests/openvpn/mock_get_random=
=2Ec
+        tests/unit_tests/openvpn/mock_push_dependencies=2Ec
         =
src/openvpn/options_util=2Ec
         src/openvpn/otime=2Ec
         src/op=
envpn/list=2Ec
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/=
unit_tests/openvpn/Makefile=2Eam
index 6db611e=2E=2E5954902 100644
--- a/te=
sts/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefil=
e=2Eam
@@ -400,6 +400,7 @@
 push_update_msg_testdriver_SOURCES =3D test_pus=
h_update_msg=2Ec \
 	mock_msg=2Ec \
 	mock_get_random=2Ec \
+	mock_push_dep=
endencies=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/sr=
c/openvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/options_util=2Ec \
dif=
f --git a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_=
tests/openvpn/mock_push_dependencies=2Ec
new file mode 100644
index 0000000=
=2E=2E112bcfd
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_push_depend=
encies=2Ec
@@ -0,0 +1,69 @@
+/*
+ *  OpenVPN -- An application to securely =
tunnel IP networks
+ *             over a single UDP port, with support for=
 SSL/TLS-based
+ *             session authentication and key exchange,
+ *=
             packet encryption, packet authentication, and
+ *             =
packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@o=
penvpn=2Enet>
+ *
+ *  This program is free software; you can redistribute =
it and/or modify
+ *  it under the terms of the GNU General Public License =
version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  Thi=
s program is distributed in the hope that it will be useful,
+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY =
or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Lic=
ense for more details=2E
+ *
+ *  You should have received a copy of the GN=
U General Public License along
+ *  with this program; if not, see <https:/=
/www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/* Set of mocked function/globals to=
 get unit tests to
+ * compile that use the push_util=2Ec file */
+
+
+#ifd=
ef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "error=2Eh"
+#i=
nclude "options=2Eh"
+
+void
+throw_signal_soft(const int signum, const cha=
r *signal_text)
+{
+    msg(M_WARN, "Offending option received from server"=
);
+}
+
+uint64_t
+pull_permission_mask(const struct context *c)
+{
+    ui=
nt64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCK=
FLAGS
+                     | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | O=
PT_P_COMP | OPT_P_PERSIST
+                     | OPT_P_MESSAGES | OPT_P_EX=
PLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
+                     | OPT_P_=
PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+    re=
turn flags;
+}
+
+void
+unlearn_ifconfig(struct multi_context *m, struct mu=
lti_instance *mi)
+{
+}
+
+void
+unlearn_ifconfig_ipv6(struct multi_context=
 *m, struct multi_instance *mi)
+{
+}
+
+void
+update_vhash(struct multi_co=
ntext *m, struct multi_instance *mi, const char *new_ip, const char *new_ip=
v6)
+{
+}
+
+bool
+options_postprocess_pull(struct options *options, struct=
 env_set *es)
+{
+    return true;
+}
diff --git a/tests/unit_tests/openvpn=
/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/test_push_update_msg=
=2Ec
index 2653749=2E=2Ea93f916 100644
--- a/tests/unit_tests/openvpn/test_=
push_update_msg=2Ec
+++ b/tests/unit_tests/openvpn/test_push_update_msg=2Ec=

@@ -12,48 +12,6 @@
 
 #include "push_util=2Ec"
 
-/* mocks */
-
-void
-thr=
ow_signal_soft(const int signum, const char *signal_text)
-{
-    msg(M_WAR=
N, "Offending option received from server");
-}
-
-uint64_t
-pull_permissio=
n_mask(const struct context *c)
-{
-    uint64_t flags =3D OPT_P_UP | OPT_P=
_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
-                     | OPT=
_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
-      =
               | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_=
P_PULL_MODE
-                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_=
MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
-    return flags;
-}
-
-void
-unlearn_i=
fconfig(struct multi_context *m, struct multi_instance *mi)
-{
-    return;=

-}
-
-void
-unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_in=
stance *mi)
-{
-    return;
-}
-
-void
-update_vhash(struct multi_context *=
m, struct multi_instance *mi, const char *new_ip, const char *new_ipv6)
-{
=
-    return;
-}
-
-bool
-options_postprocess_pull(struct options *options, =
struct env_set *es)
-{
-    return true;
-}
-
 /*
  * Counters to track rou=
te accumulation across continuation messages=2E
  * Used to verify the bug =
where update_options_found resets per message=2E

-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1853?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: Ic1ed693f73029f5b5609f717333fdaaabe42acbd
G=
errit-Change-Number: 1853
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>

--tlNRNNC5g74=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1853?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Move mocks from test_push_update_msg into its own compile unit<br=
><br>This allows these mocks to be reused by other unit tests that<br>need =
to include push_util=2Ec/h functions=2E<br><br>Change-Id: Ic1ed693f73029f5b=
5609f717333fdaaabe42acbd<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2E=
org&gt;<br>---<br>M CMakeLists=2Etxt<br>M tests/unit_tests/openvpn/Makefile=
=2Eam<br>A tests/unit_tests/openvpn/mock_push_dependencies=2Ec<br>M tests/u=
nit_tests/openvpn/test_push_update_msg=2Ec<br>4 files changed, 71 insertion=
s(+), 42 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/53/1853/2</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMake=
Lists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 2c3324d=2E=2E6eb5954 1=
00644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLis=
ts=2Etxt</span><br><span>@@ -930,6 +930,7 @@</span><br><span>     target_so=
urces(test_push_update_msg PRIVATE</span><br><span>         tests/unit_test=
s/openvpn/mock_msg=2Ec</span><br><span>         tests/unit_tests/openvpn/mo=
ck_get_random=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><span> =
        src/openvpn/options_util=2Ec</span><br><span>         src/openvpn/o=
time=2Ec</span><br><span>         src/openvpn/list=2Ec</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/=
Makefile=2Eam</span><br><span>index 6db611e=2E=2E5954902 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -400,6 +400,7 @@</sp=
an><br><span> push_update_msg_testdriver_SOURCES =3D test_push_update_msg=
=2Ec \</span><br><span> 	mock_msg=2Ec \</span><br><span> 	mock_get_random=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_push_de=
pendencies=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</=
span><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span> =
	$(top_srcdir)/src/openvpn/options_util=2Ec \</span><br><span>diff --git a/=
tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/open=
vpn/mock_push_dependencies=2Ec</span><br><span>new file mode 100644</span><=
br><span>index 0000000=2E=2E112bcfd</span><br><span>--- /dev/null</span><br=
><span>+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br>=
<span>@@ -0,0 +1,69 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN --=
 An application to securely tunnel IP networks</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             over a single UDP port, with supp=
ort for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             session authentication and key exchange,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pac=
ket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             packet compression=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you c=
an redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  it under the terms of the GNU General Public License versi=
on 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publishe=
d by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  This program is distributed in the hope that it will be useful,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANT=
Y; without even the implied warranty of</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Set of mocked function/globals to get unit tests to</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * compile that use the p=
ush_util=2Ec file */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;error=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;options=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+throw_signal_soft(const int signum, const char *signal_text)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(M_WARN, &quot;Offending option re=
ceived from server&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+pull_permission_mask(const struct context=
 *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    uint64_t flags =3D OPT_P_UP |=
 OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_SETENV | OPT=
_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_MESSAGES | O=
PT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_PEER_ID | OP=
T_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return flags;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unlearn_ifconfig(s=
truct multi_context *m, struct multi_instance *mi)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+unlearn_ifconfig_ipv6(struct multi_cont=
ext *m, struct multi_instance *mi)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+update_vhash(struct multi_context *m, struct multi_inst=
ance *mi, const char *new_ip, const char *new_ipv6)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+options_postprocess_pull(struct opti=
ons *options, struct env_set *es)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span>diff --git a/tests/unit_tests/openvpn/test_push_update_msg=2Ec b=
/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><span>index 26=
53749=2E=2Ea93f916 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
st_push_update_msg=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
push_update_msg=2Ec</span><br><span>@@ -12,48 +12,6 @@</span><br><span> </s=
pan><br><span> #include &quot;push_util=2Ec&quot;</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-/* mocks */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-th=
row_signal_soft(const int signum, const char *signal_text)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    msg(M_WARN, &quot;Offending option received from serve=
r&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-uint64_t</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-pull_permission_mask(const struct context *c)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_S=
OCKBUF | OPT_P_SOCKFLAGS</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                     | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P=
_COMP | OPT_P_PERSIST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                     | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO =
| OPT_P_PULL_MODE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                 | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE=
 | OPT_P_DHCPDNS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return flags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-unlearn_ifconfig(struct multi_context *m, struct multi_instance *m=
i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-unlearn_ifconfig_ipv6(struct mul=
ti_context *m, struct multi_instance *mi)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-update_vhash(struct multi_context *m, struct multi_instance *mi, con=
st char *new_ip, const char *new_ipv6)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-options_postprocess_pull(struct options *options, struct env_set *es)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> /*</span><br><span>  * Counters to track route acc=
umulation across continuation messages=2E</span><br><span>  * Used to verif=
y the bug where update_options_found resets per message=2E</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1853?usp=3Demail">change 1853</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1853?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: Ic1ed693f73029f5b5609f717333fdaaab=
e42acbd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1853 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--tlNRNNC5g74=--


--===============1810582479795668004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1810582479795668004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1810582479795668004==--

