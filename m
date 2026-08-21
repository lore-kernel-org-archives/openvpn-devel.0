Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192A2C5DF97
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=YUjC+Cp3MKyKnpP6QxrQB9T8KktnFEiqS/xHLyviTWA=; b=PEgRDgS4NR3Yqy
	qhO27Qx7PDaCNhEpmb7Ru4zHRXkGn15eBv0B3760wj0oN1/mNe7ZsiLlTzDqsdbvR2/TFK5DMAuT3
	/Rm2qUCfjN3SlHWKN/89gc+YewdnaOyRiRUIDpDn9ql9U7i9jJy3hcsAJNaSRS63BHVKh4AQsVJvT
	kE0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxRUm-0004Bo-4F;
	Fri, 21 Aug 2026 15:49:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxRUk-0004Bg-P4
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lSvmuqRQlo2N0nvbmWgFFkBqrrx0q9BTFLMj/CQQ+jc=; b=U6LuhRxrMABEgNUUVoLE5B27FE
 TAkR98wBDS3BqwTQDCJ1WXzc5/ftrq+Y0toaVWrQfB4aldkEztilUTp2Q6l7RxpCmClG3X8HCukKZ
 HNC3UuPdviRQHVJm0auJrF3FS8nbma0ru09BVCbRiLGykv7kYqC6evo7nP4cOeKVBcBM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lSvmuqRQlo2N0nvbmWgFFkBqrrx0q9BTFLMj/CQQ+jc=; b=G
 snicTIcsio7FtXtPlsQ8/mzWnkte1gSTT9SjtinBu2kMxSZYSbviPV/4lf0JpRSkInjhTmRRGOJ1i
 74jZGHZcj3XpNJTBG+6QqcPThCyvATN7idcH7o5rzGVGtFXLYBTpREqF4So/s0LApr1rxsohv6d/h
 Giu/LAm3VVLL9TJg=;
Received: from mail-ej1-f43.google.com ([209.85.218.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxRUg-00058r-CK for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:24 +0000
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c167aa9500dso183599766b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787327356; x=1787932156; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lSvmuqRQlo2N0nvbmWgFFkBqrrx0q9BTFLMj/CQQ+jc=;
 b=Bkg+gXqfR5K2OWr1Tryg5Tpl74aUw4kzwS2ygE8VDGuvz1Y14rTY3kayzqWx2N73KR
 veh5L6V+oztfV6j48B6IRXgQ2pzIgYrqHQAq8VN2WSoOaHY3YhBxXFxh2SPkQdz7xfrS
 fkayka8lHXBbErgFeLd959+qfUCw5soHByDkRzyKnfDln4XzdkXYLhNtrQ2EY78/kLZt
 lwRhORWrustJjkYIvEaFOZdyDeZ/oq020SBpRa131eDHh6RVDT5x++sZWjUV//B2o6WC
 VEreFClCqOh+SLmwQDKKakZdnb/IinDAYXwj9Ev4Wu2PP+2Um4Jz39sj6RJlsTdsDafO
 z2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787327356; x=1787932156;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lSvmuqRQlo2N0nvbmWgFFkBqrrx0q9BTFLMj/CQQ+jc=;
 b=eMab1bDvYPPP3SaH9dpo7KA/pYyf/KwlmdecOGj4SqlHgXiqBiBwM9IGuiCcXNLDax
 9hFG6ww4alSB7vaqJJWeIyZunyjKIi1mJKy30cxEVADZ9ESmv/AF1s8BXwvC1rHwwQCt
 egt22yUXY6DmmHynTr9BjTeFTLW96RADZMI+8EtfjZQey/Fj30Er0DPjkdeSIvffYjCG
 JLZDxVqevN8bYdQWnFjhoHbaoySW2fnO7bgOAwkhJbfVcRoPxiEmHxTvqJ7I4Je8Sxmb
 BevEyvbFI6tpZQMWbvOqZoP42/vUYuPNKYmDkwexjUS1dVKXH8ZESaMxRWAQmGtDXb+Y
 sk/A==
X-Gm-Message-State: AFuF++lc7EVV1+JMBRF9A/90+YcJ0LGMqyUpeWlcL4u5Kk91k/tG/j/d
 JTqGF8QqghEAV39YdR1DNbhRqoxV+InYtlU6iaoujxpLdDzb2RnMmKkbpxTW6PYEC9c43xR+Tf0
 RyO4wT6beeaVTlZYu7H+kYStE3cYuUTcnFKWL1pYNNpyRjTTyOySm078jSDrwlKlwEw2GAjS99p
 bZEUoxYw==
X-Gm-Gg: AR+sD108ecjpCSSTt/H3XJSvC+ksLeEW5Y2eLsN56AO9G6CIbB4KIzaOyc9daH14oKa
 HWC3YMwbuXh28/2AXiSCD/8BdUemdhpZJxCdWGU01a1ZmESkrhBYPX8ovvJnNqHKck1GTlnIvi6
 sNxtaCHfbs02oV09P0jadZP+w0aMzjPn9tyJEMYapakCSyqZnflLJukNoZIomGpTXGmyEqbcinI
 fpL2opR1CkF32SmLW3f9QNQEjlEQ8G6HX4W8LRIXeqSf/8R5mie78DCMu/ZvLgf7lFfKrLwFT/S
 SvVJL6aTErDRkHZQsFNaXjjBYn9FDicotGT31J1YZqaRXqGCNUrYiq9otKB+6O27MclXP4WSvjq
 ZaAGH7NQGQ+L56zvJgJO6xxlRitODIpCcXAMBqOxhzpF6Oix5Pt9G38L7IjHPGqRmxr0Nd3t1BH
 QPn+56NdUTpCVcQCeh9ypuh+COM7n56kuxaHi8I6g4Cmm/d5esEYupfMtS2g0kVo7zYPE47Diuj
 GOL8QRRER00BjjqgTAXSU9DuX6vt4Wm5G/9+kCMifj5rU48mFE5Ma9FM3qWXmjrTLFHAzm0ihsD
 kcoZ1LoP2pdNX+ePDl7reuAOuOAjIQsnYM2YToeAfvi6iFP7ky4=
X-Received: by 2002:a17:907:d048:b0:c21:74ed:4608 with SMTP id
 a640c23a62f3a-c246a4cf8b5mr803423666b.10.1787327355552; 
 Fri, 21 Aug 2026 08:49:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c245921e4f5sm537898866b.55.2026.08.21.08.49.14
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:49:14 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 15:49:14 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic1ed693f73029f5b5609f717333fdaaabe42acbd
X-Gerrit-Change-Number: 1853
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1853?usp=email>
X-Gerrit-Commit: b06b7a2808b68c14de5151e5b065e1ae0a848733
References: <gerrit.1787327336000.Ic1ed693f73029f5b5609f717333fdaaabe42acbd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkljMWVkNjkzZjczMDI5ZjViNTYwOWY3MTczMzNmZGFhYWJlNDJhY2JkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9f6952377ac653ca613175ee9403e854aad2a92e-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxRUg-00058r-CK
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
Content-Type: multipart/mixed; boundary="===============1493221293452191826=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1493221293452191826==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7/CqgaVimps="; charset=UTF-8

--7/CqgaVimps=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1853?usp=3Demail )


Change subject: Move mocks from tes=
t_push_update_msg into its own compile unit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Move mocks from test_push_update_msg into i=
ts own compile unit

This allows these mocks to be reused by other unit tes=
ts that
need to include push_util=2Ec/h functions=2E

Change-Id: Ic1ed693f7=
3029f5b5609f717333fdaaabe42acbd
Signed-off-by: Arne Schwabe <arne@rfc2549=
=2Eorg>
---
M CMakeLists=2Etxt
M tests/unit_tests/openvpn/Makefile=2Eam
A t=
ests/unit_tests/openvpn/mock_push_dependencies=2Ec
M tests/unit_tests/openv=
pn/test_push_update_msg=2Ec
4 files changed, 71 insertions(+), 42 deletions=
(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/5=
3/1853/1

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 2c3324d=2E=
=2E6eb5954 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -930,6 +=
930,7 @@
     target_sources(test_push_update_msg PRIVATE
         tests/un=
it_tests/openvpn/mock_msg=2Ec
         tests/unit_tests/openvpn/mock_get_ra=
ndom=2Ec
+        tests/unit_tests/openvpn/mock_push_dependencies=2Ec
     =
    src/openvpn/options_util=2Ec
         src/openvpn/otime=2Ec
         sr=
c/openvpn/list=2Ec
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/te=
sts/unit_tests/openvpn/Makefile=2Eam
index 6db611e=2E=2E5954902 100644
--- =
a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Mak=
efile=2Eam
@@ -400,6 +400,7 @@
 push_update_msg_testdriver_SOURCES =3D test=
_push_update_msg=2Ec \
 	mock_msg=2Ec \
 	mock_get_random=2Ec \
+	mock_push=
_dependencies=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir=
)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/options_util=2Ec \=

diff --git a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/u=
nit_tests/openvpn/mock_push_dependencies=2Ec
new file mode 100644
index 000=
0000=2E=2E112bcfd
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_push_de=
pendencies=2Ec
@@ -0,0 +1,69 @@
+/*
+ *  OpenVPN -- An application to secur=
ely tunnel IP networks
+ *             over a single UDP port, with support=
 for SSL/TLS-based
+ *             session authentication and key exchange,=

+ *             packet encryption, packet authentication, and
+ *         =
    packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sal=
es@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistrib=
ute it and/or modify
+ *  it under the terms of the GNU General Public Lice=
nse version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ * =
 This program is distributed in the hope that it will be useful,
+ *  but W=
ITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABIL=
ITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public=
 License for more details=2E
+ *
+ *  You should have received a copy of th=
e GNU General Public License along
+ *  with this program; if not, see <htt=
ps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/* Set of mocked function/global=
s to get unit tests to
+ * compile that use the push_util=2Ec file */
+
+
+=
#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "error=2Eh"=

+#include "options=2Eh"
+
+void
+throw_signal_soft(const int signum, const=
 char *signal_text)
+{
+    msg(M_WARN, "Offending option received from ser=
ver");
+}
+
+uint64_t
+pull_permission_mask(const struct context *c)
+{
+  =
  uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_=
SOCKFLAGS
+                     | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER=
 | OPT_P_COMP | OPT_P_PERSIST
+                     | OPT_P_MESSAGES | OPT_=
P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
+                     | OP=
T_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+  =
  return flags;
+}
+
+void
+unlearn_ifconfig(struct multi_context *m, struc=
t multi_instance *mi)
+{
+}
+
+void
+unlearn_ifconfig_ipv6(struct multi_con=
text *m, struct multi_instance *mi)
+{
+}
+
+void
+update_vhash(struct mult=
i_context *m, struct multi_instance *mi, const char *new_ip, const char *ne=
w_ipv6)
+{
+}
+
+bool
+options_postprocess_pull(struct options *options, st=
ruct env_set *es)
+{
+    return true;
+}
diff --git a/tests/unit_tests/ope=
nvpn/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/test_push_update_m=
sg=2Ec
index 01bf6c8=2E=2Ea93f916 100644
--- a/tests/unit_tests/openvpn/tes=
t_push_update_msg=2Ec
+++ b/tests/unit_tests/openvpn/test_push_update_msg=
=2Ec
@@ -12,48 +12,6 @@
 
 #include "push_util=2Ec"
 
-/* mocks */
-
-void
=
-throw_signal_soft(const int signum, const char *signal_text)
-{
-    msg(M=
_WARN, "Offending option received from server");
-}
-
-uint64_t
-pull_permi=
ssion_mask(const struct context *c)
-{
-    unsigned int flags =3D OPT_P_UP=
 | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
-                  =
       | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PER=
SIST
-                         | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | O=
PT_P_ECHO | OPT_P_PULL_MODE
-                         | OPT_P_PEER_ID | OPT=
_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
-    return flags;
-=
}
-
-void
-unlearn_ifconfig(struct multi_context *m, struct multi_instance =
*mi)
-{
-    return;
-}
-
-void
-unlearn_ifconfig_ipv6(struct multi_context=
 *m, struct multi_instance *mi)
-{
-    return;
-}
-
-void
-update_vhash(st=
ruct multi_context *m, struct multi_instance *mi, const char *new_ip, const=
 char *new_ipv6)
-{
-    return;
-}
-
-bool
-options_postprocess_pull(struc=
t options *options, struct env_set *es)
-{
-    return true;
-}
-
 /*
  * C=
ounters to track route accumulation across continuation messages=2E
  * Use=
d to verify the bug where update_options_found resets per message=2E

-- 
T=
o view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1853?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic1ed693f73029f5b5609f717=
333fdaaabe42acbd
Gerrit-Change-Number: 1853
Gerrit-PatchSet: 1
Gerrit-Owner=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>

--7/CqgaVimps=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1853?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Move mocks from test_push_update_msg into its own compile unit<br>=
<br>This allows these mocks to be reused by other unit tests that<br>need t=
o include push_util=2Ec/h functions=2E<br><br>Change-Id: Ic1ed693f73029f5b5=
609f717333fdaaabe42acbd<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eo=
rg&gt;<br>---<br>M CMakeLists=2Etxt<br>M tests/unit_tests/openvpn/Makefile=
=2Eam<br>A tests/unit_tests/openvpn/mock_push_dependencies=2Ec<br>M tests/u=
nit_tests/openvpn/test_push_update_msg=2Ec<br>4 files changed, 71 insertion=
s(+), 42 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/53/1853/1</pre><pre style=3D"font-fa=
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
/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><span>index 01=
bf6c8=2E=2Ea93f916 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
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
00%, 40%);">-    unsigned int flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT=
_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                         | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER=
 | OPT_P_COMP | OPT_P_PERSIST</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                         | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY |=
 OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                         | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_M=
TU | OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return flags;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-unlearn_ifconfig(struct multi_context *m, struct m=
ulti_instance *mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unlearn_ifconfig=
_ipv6(struct multi_context *m, struct multi_instance *mi)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-update_vhash(struct multi_context *m, struct multi_i=
nstance *mi, const char *new_ip, const char *new_ipv6)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-options_postprocess_pull(struct options *options, struc=
t env_set *es)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Counters to=
 track route accumulation across continuation messages=2E</span><br><span> =
 * Used to verify the bug where update_options_found resets per message=2E<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1853?usp=3Demail">change 1853</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1853?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic1ed693f73029f5b560=
9f717333fdaaabe42acbd </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1853 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--7/CqgaVimps=--


--===============1493221293452191826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1493221293452191826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1493221293452191826==--

