Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E0BC9830D
	for <openvpn-devel@archiver.kernel.org>; Thu, 24 Sep 2026 01:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=/Mo8oT1MqAX09+saWyiaVUMGCiBIrOc2O5FsuAaLskA=; b=mQ7gAfzgwRFEft
	OLf41yR3VmfvA3Zv9nA2xwLUNMRG7EBXNJnW2cGLxyruIPqZebLGt7SHji2A9/FijgyjD8x47e4tr
	jSCD0PrQgbpSkLvVO//8n9XFY+MtVMPsLsoz2uIDEgQSitY4MkfNw23RFlW9Brs0XWffzDzhwXUZE
	l2U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9Xyt-0004Rs-3r;
	Thu, 24 Sep 2026 01:10:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9Xyr-0004Rm-Pb
 for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 01:10:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4DW6zz4PQfwnnafjad7Cq8kvJI2oIw8IBi4WqkqG22Q=; b=k1M0tThsVZa3hcnm3GxZKrgn3O
 sGv5nX2VOmIsF+YHZ+yaJyvB4d/SpcPRpqwoyebBv/3RpcZoGckWjvbsfJaR0qDkF54q4T6toh4QQ
 FqZO/e70yhQRoxKz1Po82FO+KAiVGTcVCmsenDjpWVXUbeVwkB0eNRApTcBPUvk/JQQI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4DW6zz4PQfwnnafjad7Cq8kvJI2oIw8IBi4WqkqG22Q=; b=P
 QyXg8FKWVhO7IiZ1sob5jHRfAHqG/3pno47XtnzZ+fJ9ztGnqplUlGnR3uuv+U3VHP8CAklpQl67U
 A5C8sWDHZFRnxlNWyLfpDT92B2wAeDjt7I3WkN/jIZIRMf2PPbTXYs7dIBDsmbr7SiM1w8ye6XRok
 Pb7pZh3udkfLPDMM=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9Xyq-0007qX-41 for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 01:10:34 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso10786015e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 18:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790212225; x=1790817025; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4DW6zz4PQfwnnafjad7Cq8kvJI2oIw8IBi4WqkqG22Q=;
 b=I8dBJY4A2AKYaUldU8lm5BPtBRSARyRw7k+0kd/u4nLedDkH6iDscOppMvQUqNssNk
 pMe0yc2XZ50syxYlR9jRreyQTq4H/7dU1VV7D5wae1nycdgJd1In6WTqSWp8c1wSOu/G
 Slw6zvGduVIV4oHf4tdGgr53XDjIVaBqiWX2sY0P4BCpcYdf7Yy31krOuxXjY/uvZKXQ
 njuuDOlx8JmWYOFlQ3GevhjjlqLlnIWoqUV87Pv7bSLfwo4DPN2iDQFDtfk7IlbwaDN6
 H9F75HF61mswDP8/4zF+UCzswJfo3hjpKzqH10/JU7DPbedTcSrtdwJgkVgyG3aWulmm
 1knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790212225; x=1790817025;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4DW6zz4PQfwnnafjad7Cq8kvJI2oIw8IBi4WqkqG22Q=;
 b=HSLN18TqeBs7VpX3QKimVVBXUnwrGyYk7tZg3VZrnt6A+TJgRC0hy7qEqPxgKy7m6n
 1nhaSF9hGBw1riBcl22RjoMcgHILHi/e562ZxNJOEz5WO7JRvPoMjA9oBFEpQxo3z+/j
 miZneT4tpvFcBMiQ25sMdXgcJbmRLXBmDoN1z/4SUsp6pr1b370ExvcRZCzpRIBA9CBY
 q3zx2I/KIhTw2FNlxfjQSKmTCd2lmGs6Ce8TqdRsqpryDmBnR3zEyQ2inieAtFI+72uh
 bUNy4l1IIWTxGPTP71jO8kBFP1i11QwvOeOfpaSWtrsAXKiowx5F+5YotjDQ8aCIc8aY
 e8Xw==
X-Gm-Message-State: AFuF++nJCJsy7McXYopPQWd91TqW9PNKume+CaQloB6ugCbnmMpPJrTH
 rHofruxH8R1olHiHEzku8EaFxL5xEqKy4oauE3n4VbEfKEPXbQw//SIz9DK4A0lKu2a4HT5qKU7
 wAMR35iMl9qR7A2+Cny+OxR3A81hci98jL+hojmcOeJpUgr3LKfpYsrqEMZvV098S1A4lDVTyp/
 jhQBKx9A==
X-Gm-Gg: AYBFou3877/eLcWcZbGbACutBAGRSzisugtFo7IaQhEj+iCJENoxQTbGgumebgTeSfY
 ftbpgr/W+a4Sh6IGIyKwgchgZvpngBxaqvpvyk78wwDnme5actTa3F+0QazVfrRG+1WAoFTpBx0
 4C6nItCKu/tIq+SfYoUhliuEG2c6CU3n9xpRxT+bzhdw0Nyi+zZIEwvMMgHlXPEHO4vLQvFU8Vf
 IL1VYNuWwsoBBJh6AE1EksVp/vv+QixQUyUhAyaVW7gWOo3F2t2Smxph+ashxUr59+wuKy/64JM
 FFrUR/AiXfhKoN2NSqgAHOMxiXPXBR2p3lo0+XYBLEquZU+sSM6keL/bMxhHERbIy5WGvBC1nCv
 e1DzXeEGMmnE5BXSU3sXsFaRegzW6UsDIs6gUGl6vWuHOiX9k7BQsv2LuXp22emUZJXQ6sH4LVl
 6ustWUVtEDQ0TsDyKKV78RFayFpGZZ/wcLIOpdBxMTdpqpRIH6BafTAvoHB6nbPML/mDByMyY5r
 oYVPATPyPG7CxCgkY6L595N7Gowgo7oT2MldBfRo0LMJfCYYo0tpNIJ9cDIrM+8b7Mf2VboC6sJ
 7rdiR6EhoRwQOUsWfxY5SKfGN5W6afKLaiIEQUWP3UyqlNqS9S4PkGpssVTb
X-Received: by 2002:a05:600c:8b4c:b0:49e:8184:f63b with SMTP id
 5b1f17b1804b1-49fe66f3a68mr13716435e9.16.1790212225330; 
 Wed, 23 Sep 2026 18:10:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe667ae2fsm23806155e9.13.2026.09.23.18.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 18:10:24 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 24 Sep 2026 01:10:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: 472d1fe901e0a0261fd0cf88801d08820cd201a6
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <85aac34a03e36deb1f4eef4d083ca6307aaa2d0c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9Xyq-0007qX-41
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
 openvpn-devel@lists.sourceforge.net
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2424201747717753787=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2424201747717753787==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="49iyjccEK0c="; charset=UTF-8

--49iyjccEK0c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1946?usp=3Demail

to review the following change=2E


Chang=
e subject: tests: add a unit test driver for route=2Ec
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tests: add a unit test driver f=
or route=2Ec

route=2Ec has no unit test coverage at all, so there is nowhe=
re to put a
test when touching it=2E  Add a driver and cover the pure helpe=
rs it
already exports: the special address predicate, both netmask-to-netbi=
ts
conversions, and the IPv6 prefix host-bit masking=2E

The two conversion=
s disagree on a full-length netmask, where
netmask_to_netbits() reports -1 =
and netmask_to_netbits2() reports 32=2E
That is deliberate, callers use the=
 -1 to tell a host route from a
network route, so pin it down rather than l=
eave it to be "fixed" later=2E

The platform routing calls and the handful =
of socket helpers route=2Ec
references are stubbed in the test itself rathe=
r than linked in=2E  That
keeps the dependency list short, and it makes cer=
tain a test can never
reach the real routing table=2E

Change-Id: I9085c55a=
7efefd31839b00ec8ec9a6f085574dde
Signed-off-by: Charlie Vigue <charlie=2Evi=
gue@openvpn=2Ecom>
---
M CMakeLists=2Etxt
M tests/unit_tests/openvpn/Makefi=
le=2Eam
A tests/unit_tests/openvpn/test_route=2Ec
3 files changed, 254 inse=
rtions(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/46/1946/1

diff --git a/CMakeLists=2Etxt b/CMakeLists=
=2Etxt
index 4eda75b=2E=2Ebf4a0de 100644
--- a/CMakeLists=2Etxt
+++ b/CMake=
Lists=2Etxt
@@ -676,6 +676,7 @@
         "test_packet_id"
         "test_pk=
t"
         "test_provider"
+        "test_route"
         "test_socket"
  =
       "test_ssl"
         "test_user_pass"
@@ -900,6 +901,18 @@
         s=
rc/openvpn/base64=2Ec
         )
 
+    target_link_libraries(test_route PU=
BLIC ${RESOLV_LIBRARIES})
+    target_sources(test_route PRIVATE
+        t=
ests/unit_tests/openvpn/mock_get_random=2Ec
+        tests/unit_tests/openv=
pn/mock_management=2Ec
+        tests/unit_tests/openvpn/mock_win32_execve=
=2Ec
+        src/openvpn/env_set=2Ec
+        src/openvpn/otime=2Ec
+     =
   src/openvpn/route=2Ec
+        src/openvpn/run_command=2Ec
+        src/=
openvpn/socket_util=2Ec
+        )
+
     target_link_libraries(test_socket=
 PUBLIC ${RESOLV_LIBRARIES})
     target_sources(test_socket PRIVATE
      =
   tests/unit_tests/openvpn/mock_get_random=2Ec
diff --git a/tests/unit_tes=
ts/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index f2c=
7a0d=2E=2Eeb1ff52 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b=
/tests/unit_tests/openvpn/Makefile=2Eam
@@ -19,6 +19,7 @@
 	pkt_testdriver =
\
 	provider_testdriver \
 	push_update_msg_testdriver \
+	route_testdriver=
 \
 	socket_testdriver \
 	ssl_testdriver \
 	user_pass_testdriver
@@ -420,=
3 +421,18 @@
 	$(top_srcdir)/src/openvpn/env_set=2Ec \
 	$(top_srcdir)/src/=
openvpn/run_command=2Ec \
 	$(top_srcdir)/src/openvpn/socket_util=2Ec
+
+ro=
ute_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/=
compat @TEST_CFLAGS@
+route_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_s=
rcdir)/src/openvpn
+route_testdriver_SOURCES =3D test_route=2Ec \
+	mock_ms=
g=2Ec test_common=2Eh \
+	mock_get_random=2Ec \
+	mock_management=2Ec \
+	$=
(top_srcdir)/src/openvpn/route=2Ec \
+	$(top_srcdir)/src/openvpn/buffer=2Ec=
 \
+	$(top_srcdir)/src/openvpn/env_set=2Ec \
+	$(top_srcdir)/src/openvpn/ot=
ime=2Ec \
+	$(top_srcdir)/src/openvpn/platform=2Ec \
+	$(top_srcdir)/src/op=
envpn/run_command=2Ec \
+	$(top_srcdir)/src/openvpn/socket_util=2Ec \
+	$(t=
op_srcdir)/src/openvpn/win32-util=2Ec
diff --git a/tests/unit_tests/openvpn=
/test_route=2Ec b/tests/unit_tests/openvpn/test_route=2Ec
new file mode 100=
644
index 0000000=2E=2Edb039c1
--- /dev/null
+++ b/tests/unit_tests/openvpn=
/test_route=2Ec
@@ -0,0 +1,225 @@
+/*
+ *  OpenVPN -- An application to sec=
urely tunnel IP networks
+ *             over a single UDP port, with suppo=
rt for SSL/TLS-based
+ *             session authentication and key exchang=
e,
+ *             packet encryption, packet authentication, and
+ *       =
      packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <s=
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
+#include "test_common=2E=
h"
+
+#include "route=2Eh"
+#include "networking=2Eh"
+
+/* Stubs for funct=
ions route=2Ec references but that no test here reaches=2E
+ * They assert =
rather than return quietly, so a test straying onto one
+ * fails loudly in=
stead of silently doing nothing=2E
+ */
+struct argv
+argv_new(void)
+{
+  =
  assert_true(0);
+    struct argv a =3D { 0 };
+    return a;
+}
+
+void
+=
argv_free(struct argv *a)
+{
+    assert_true(0);
+}
+
+bool
+get_ipv6_addr=
(const char *prefix_str, struct in6_addr *network, unsigned int *netbits,
+=
              msglvl_t msglevel)
+{
+    assert_true(0);
+    return false;=

+}
+
+in_addr_t
+getaddr(unsigned int flags, const char *hostname, int res=
olve_retry, bool *succeeded,
+        struct signal_info *sig_info)
+{
+   =
 assert_true(0);
+    return 0;
+}
+
+/* The routing table is never touched=
 by these tests; stub the platform
+ * layer out so that a mistake cannot r=
each the system routing table=2E
+ */
+int
+net_route_v4_add(openvpn_net_ct=
x_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
+      =
           const openvpn_net_iface_t *iface, uint32_t table, int metric)
+{=

+    assert_true(0);
+    return -1;
+}
+
+int
+net_route_v6_add(openvpn_n=
et_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
+                =
 const struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t tabl=
e,
+                 int metric)
+{
+    assert_true(0);
+    return -1;
+}=

+
+int
+net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int=
 prefixlen, const in_addr_t *gw,
+                 const openvpn_net_iface_=
t *iface, uint32_t table, int metric)
+{
+    assert_true(0);
+    return -=
1;
+}
+
+int
+net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_add=
r *dst, int prefixlen,
+                 const struct in6_addr *gw, const o=
penvpn_net_iface_t *iface, uint32_t table,
+                 int metric)
+{=

+    assert_true(0);
+    return -1;
+}
+
+int
+net_route_v4_best_gw(openv=
pn_net_ctx_t *ctx, const in_addr_t *dst, in_addr_t *best_gw,
+             =
        openvpn_net_iface_t *best_iface)
+{
+    assert_true(0);
+    retur=
n -1;
+}
+
+int
+net_route_v6_best_gw(openvpn_net_ctx_t *ctx, const struct =
in6_addr *dst, struct in6_addr *best_gw,
+                     openvpn_net_=
iface_t *best_iface)
+{
+    assert_true(0);
+    return -1;
+}
+
+struct s=
ignal_info siginfo_static; /* GLOBAL */
+
+int
+signal_reset(struct signal_=
info *si, int signum)
+{
+    assert_true(0);
+    return 0;
+}
+
+static v=
oid
+test_is_special_addr(void **state)
+{
+    assert_true(is_special_addr=
("net_gateway"));
+    assert_true(is_special_addr("vpn_gateway"));
+    as=
sert_true(is_special_addr("remote_host"));
+
+    assert_false(is_special_a=
ddr("10=2E0=2E0=2E1"));
+    assert_false(is_special_addr("default"));
+   =
 assert_false(is_special_addr(NULL));
+}
+
+static void
+test_netmask_to_ne=
tbits(void **state)
+{
+    int netbits;
+
+    assert_true(netmask_to_netb=
its(0x0a000000, 0xff000000, &netbits)); /* 10/8 */
+    assert_int_equal(ne=
tbits, 8);
+
+    assert_true(netmask_to_netbits(0xc0a80100, 0xffffff00, &n=
etbits)); /* 192=2E168=2E1/24 */
+    assert_int_equal(netbits, 24);
+
+   =
 assert_true(netmask_to_netbits(0x00000000, 0x00000000, &netbits)); /* defa=
ult route */
+    assert_int_equal(netbits, 0);
+
+    /* a full-length mas=
k reports -1 rather than 32, which is what callers
+     * use to tell "hos=
t route" from "network route"
+     */
+    assert_true(netmask_to_netbits(=
0x0a010203, 0xffffffff, &netbits));
+    assert_int_equal(netbits, -1);
+
+=
    /* host bits set in the network part */
+    assert_false(netmask_to_ne=
tbits(0x0a000001, 0xff000000, &netbits));
+
+    /* not a contiguous netmas=
k */
+    assert_false(netmask_to_netbits(0x0a000000, 0xff00ff00, &netbits)=
);
+}
+
+static void
+test_netmask_to_netbits2(void **state)
+{
+    assert=
_int_equal(netmask_to_netbits2(0xff000000), 8);
+    assert_int_equal(netma=
sk_to_netbits2(0xffffff00), 24);
+    assert_int_equal(netmask_to_netbits2(=
0x00000000), 0);
+
+    /* unlike netmask_to_netbits(), this one reports a =
full-length mask as 32 */
+    assert_int_equal(netmask_to_netbits2(0xfffff=
fff), 32);
+
+    assert_int_equal(netmask_to_netbits2(0xff00ff00), -1);
+}=

+
+static void
+assert_clear_host_bits(const char *addr, unsigned int netb=
its, const char *expected)
+{
+    struct route_ipv6 r6;
+    struct in6_ad=
dr want;
+
+    CLEAR(r6);
+    assert_int_equal(inet_pton(AF_INET6, addr, =
&r6=2Enetwork), 1);
+    assert_int_equal(inet_pton(AF_INET6, expected, &wa=
nt), 1);
+    r6=2Enetbits =3D netbits;
+
+    route_ipv6_clear_host_bits(&=
r6);
+    assert_memory_equal(&r6=2Enetwork, &want, sizeof(struct in6_addr)=
);
+}
+
+static void
+test_route_ipv6_clear_host_bits(void **state)
+{
+   =
 /* whole bytes cleared */
+    assert_clear_host_bits("2001:db8::1", 64, "=
2001:db8::");
+    assert_clear_host_bits("2001:db8:dead:beef::1", 32, "200=
1:db8::");
+
+    /* a prefix that does not fall on a byte boundary */
+   =
 assert_clear_host_bits("2001:db8:0:00ff::1", 60, "2001:db8:0:00f0::");
+  =
  assert_clear_host_bits("2001:db8::ffff", 121, "2001:db8::ff80");
+
+    /=
* nothing to clear, and everything to clear */
+    assert_clear_host_bits(=
"2001:db8::1", 128, "2001:db8::1");
+    assert_clear_host_bits("2001:db8::=
1", 0, "::");
+}
+
+const struct CMUnitTest route_tests[] =3D {
+    cmocka=
_unit_test(test_is_special_addr),
+    cmocka_unit_test(test_netmask_to_net=
bits),
+    cmocka_unit_test(test_netmask_to_netbits2),
+    cmocka_unit_te=
st(test_route_ipv6_clear_host_bits),
+};
+
+int
+main(void)
+{
+    openvpn=
_unit_test_setup();
+    return cmocka_run_group_tests(route_tests, NULL, N=
ULL);
+}

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9085c55a7=
efefd31839b00ec8ec9a6f085574dde
Gerrit-Change-Number: 1946
Gerrit-PatchSet:=
 1
Gerrit-Owner: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2=
549=2Eorg>

--49iyjccEK0c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>chugly would like plaisthos to <=
strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1946?usp=3Demail">View Change</a></p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">t=
ests: add a unit test driver for route=2Ec<br><br>route=2Ec has no unit tes=
t coverage at all, so there is nowhere to put a<br>test when touching it=2E=
  Add a driver and cover the pure helpers it<br>already exports: the specia=
l address predicate, both netmask-to-netbits<br>conversions, and the IPv6 p=
refix host-bit masking=2E<br><br>The two conversions disagree on a full-len=
gth netmask, where<br>netmask_to_netbits() reports -1 and netmask_to_netbit=
s2() reports 32=2E<br>That is deliberate, callers use the -1 to tell a host=
 route from a<br>network route, so pin it down rather than leave it to be &=
quot;fixed&quot; later=2E<br><br>The platform routing calls and the handful=
 of socket helpers route=2Ec<br>references are stubbed in the test itself r=
ather than linked in=2E  That<br>keeps the dependency list short, and it ma=
kes certain a test can never<br>reach the real routing table=2E<br><br>Chan=
ge-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde<br>Signed-off-by: Charlie =
Vigue &lt;charlie=2Evigue@openvpn=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br=
>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/unit_tests/openvpn/tes=
t_route=2Ec<br>3 files changed, 254 insertions(+), 0 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/46/1946/1</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt<=
/span><br><span>index 4eda75b=2E=2Ebf4a0de 100644</span><br><span>--- a/CMa=
keLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -67=
6,6 +676,7 @@</span><br><span>         &quot;test_packet_id&quot;</span><br=
><span>         &quot;test_pkt&quot;</span><br><span>         &quot;test_pr=
ovider&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 &quot;test_route&quot;</span><br><span>         &quot;test_socket&quot;</s=
pan><br><span>         &quot;test_ssl&quot;</span><br><span>         &quot;=
test_user_pass&quot;</span><br><span>@@ -900,6 +901,18 @@</span><br><span> =
        src/openvpn/base64=2Ec</span><br><span>         )</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    target_link_lib=
raries(test_route PUBLIC ${RESOLV_LIBRARIES})</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    target_sources(test_route PRIVATE</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvp=
n/mock_get_random=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        tests/unit_tests/openvpn/mock_management=2Ec</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_wi=
n32_execve=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   src/openvpn/env_set=2Ec</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        src/openvpn/otime=2Ec</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        src/openvpn/route=2Ec</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        src/openvpn/run_command=2Ec</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/socket_util=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        )</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     tar=
get_link_libraries(test_socket PUBLIC ${RESOLV_LIBRARIES})</span><br><span>=
     target_sources(test_socket PRIVATE</span><br><span>         tests/unit=
_tests/openvpn/mock_get_random=2Ec</span><br><span>diff --git a/tests/unit_=
tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span>=
<br><span>index f2c7a0d=2E=2Eeb1ff52 100644</span><br><span>--- a/tests/uni=
t_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvp=
n/Makefile=2Eam</span><br><span>@@ -19,6 +19,7 @@</span><br><span> 	pkt_tes=
tdriver \</span><br><span> 	provider_testdriver \</span><br><span> 	push_up=
date_msg_testdriver \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	route_testdriver \</span><br><span> 	socket_testdriver \</span><br><span=
> 	ssl_testdriver \</span><br><span> 	user_pass_testdriver</span><br><span>=
@@ -420,3 +421,18 @@</span><br><span> 	$(top_srcdir)/src/openvpn/env_set=2E=
c \</span><br><span> 	$(top_srcdir)/src/openvpn/run_command=2Ec \</span><br=
><span> 	$(top_srcdir)/src/openvpn/socket_util=2Ec</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+route_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(to=
p_srcdir)/src/compat @TEST_CFLAGS@</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+route_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/=
src/openvpn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+route_te=
stdriver_SOURCES =3D test_route=2Ec \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	mock_msg=2Ec test_common=2Eh \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	mock_get_random=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	mock_management=2Ec \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/route=2Ec \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/=
openvpn/buffer=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	$(top_srcdir)/src/openvpn/env_set=2Ec \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platfor=
m=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdi=
r)/src/openvpn/run_command=2Ec \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	$(top_srcdir)/src/openvpn/socket_util=2Ec \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/win32-util=
=2Ec</span><br><span>diff --git a/tests/unit_tests/openvpn/test_route=2Ec b=
/tests/unit_tests/openvpn/test_route=2Ec</span><br><span>new file mode 1006=
44</span><br><span>index 0000000=2E=2Edb039c1</span><br><span>--- /dev/null=
</span><br><span>+++ b/tests/unit_tests/openvpn/test_route=2Ec</span><br><s=
pan>@@ -0,0 +1,225 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- =
An application to securely tunnel IP networks</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *             over a single UDP port, with suppo=
rt for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *             session authentication and key exchange,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pack=
et authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             packet compression=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  it under the terms of the GNU General Public License versio=
n 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published=
 by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  This program is distributed in the hope that it will be useful,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;route=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;networking=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* S=
tubs for functions route=2Ec references but that no test here reaches=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * They assert rather =
than return quietly, so a test straying onto one</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * fails loudly instead of silently doing noth=
ing=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+struct argv</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+argv_new(void)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(0);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct argv a =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return a;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+argv_free(struct argv *a)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+get_ipv6_addr(const ch=
ar *prefix_str, struct in6_addr *network, unsigned int *netbits,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+              msglvl_t msgleve=
l)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+in_addr_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+getaddr(u=
nsigned int flags, const char *hostname, int resolve_retry, bool *succeeded=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct sig=
nal_info *sig_info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* The routing table is never touched by these tests; stub t=
he platform</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * layer=
 out so that a mistake cannot reach the system routing table=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, =
int prefixlen, const in_addr_t *gw,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                 const openvpn_net_iface_t *iface, uint32_t=
 table, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return -1;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+n=
et_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int pre=
fixlen,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
     const struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t =
table,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
    int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return -1;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_r=
oute_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, co=
nst in_addr_t *gw,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                const openvpn_net_iface_t *iface, uint32_t table, int metri=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return -1;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_route_v6_del(o=
penvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                 const struct=
 in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                 int metric)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return -1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+net_route_v4_best_gw(o=
penvpn_net_ctx_t *ctx, const in_addr_t *dst, in_addr_t *best_gw,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                     openvpn_n=
et_iface_t *best_iface)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return -1;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+net_route_v6_best_gw(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,=
 struct in6_addr *best_gw,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                     openvpn_net_iface_t *best_iface)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return -1;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct signal_info =
siginfo_static; /* GLOBAL */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+signal_reset(struct signal=
_info *si, int signum)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+test_is_special_addr(void **state)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(is_special_addr(&quot;net_gateway&quot;));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(is_special_add=
r(&quot;vpn_gateway&quot;));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(is_special_addr(&quot;remote_host&quot;));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_false(is_special_addr(&quot;10=2E0=
=2E0=2E1&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_false(is_special_addr(&quot;default&quot;));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(is_special_addr(NULL));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_netmask_to_netbits(void **state)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int netbits;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(netmask_to_netbits(0x0a000000, 0xff000000, &amp;netbits)); /* 10/8 */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
netbits, 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(netmask_to=
_netbits(0xc0a80100, 0xffffff00, &amp;netbits)); /* 192=2E168=2E1/24 */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ne=
tbits, 24);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(netmask_to_=
netbits(0x00000000, 0x00000000, &amp;netbits)); /* default route */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netbit=
s, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* a full-length mask report=
s -1 rather than 32, which is what callers</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * use to tell &quot;host route&quot; from &quot=
;network route&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(netmask_to_netbits(0x0a010203, 0xffffffff, &amp;netbits));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(netbits, -=
1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* host bits set in the network=
 part */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
false(netmask_to_netbits(0x0a000001, 0xff000000, &amp;netbits));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* not a contiguous netmask */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_false(netmask_to_netbit=
s(0x0a000000, 0xff00ff00, &amp;netbits));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+test_netmask_to_netbits=
2(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(n=
etmask_to_netbits2(0xff000000), 8);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(netmask_to_netbits2(0xffffff00), 24);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(netmask_to_netbits2(0x00000000), 0);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* unlike netmask_to_netbits(), this one reports a full-length mask as 3=
2 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(netmask_to_netbits2(0xffffffff), 32);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(netmask_to_netbits2(0xff00ff00), -1);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+a=
ssert_clear_host_bits(const char *addr, unsigned int netbits, const char *e=
xpected)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct route_ipv6 r6;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr wan=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(r6);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(inet_pton(AF_INET6, =
addr, &amp;r6=2Enetwork), 1);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(inet_pton(AF_INET6, expected, &amp;want), 1)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r6=2Enetbits =
=3D netbits;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    route_ipv6_clear_host_=
bits(&amp;r6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_memory_equal(&amp;r6=2Enetwork, &amp;want, sizeof(struct in6_addr));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_route_ipv6_clear_host_bits(void **state)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* whole bytes cleared */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8::1&qu=
ot;, 64, &quot;2001:db8::&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8:dead:beef::1&quot;,=
 32, &quot;2001:db8::&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a =
prefix that does not fall on a byte boundary */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8:0:00f=
f::1&quot;, 60, &quot;2001:db8:0:00f0::&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8::ffff=
&quot;, 121, &quot;2001:db8::ff80&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* nothing to clear, and everything to clear */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db=
8::1&quot;, 128, &quot;2001:db8::1&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_clear_host_bits(&quot;2001:db8::1&quot;, =
0, &quot;::&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+const struct CMUnitTest route_tests[]=
 =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_un=
it_test(test_is_special_addr),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    cmocka_unit_test(test_netmask_to_netbits),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_netmask_to_=
netbits2),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmock=
a_unit_test(test_route_ipv6_clear_host_bits),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+main(void)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    openvpn_unit_test_setup();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_group_tests(route_t=
ests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1946?usp=3Demail">change 1946</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1946?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f0855=
74dde </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1946 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>

</body></html>
--49iyjccEK0c=--


--===============2424201747717753787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2424201747717753787==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2424201747717753787==--

