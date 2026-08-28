Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1C6C61DD7
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 10:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J5zQCFl58WiidmzAJMC6tvsappHEzVeHTJCehq9zJ90=; b=GNzgu21b3WFgoJGCoQcb0ns2DY
	jRFa5SXfZQ8oDwjw3JNtyNm64gc6uB5hIijbRDFit4YKFQu6/60Rz0PK4fM/tlGVLe11n7ulZeDVi
	QwzP8EN0lZxqSFQu8BMCp7/rg/9JFq0hNOJ6bC0mRk79EfPjF8uNIR7oaIs7VpH2tfm8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wztoP-0000qb-T3;
	Fri, 28 Aug 2026 10:27:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzto6-0000ol-Qs
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:27:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jra06c0Xr2RbFD0Dbah6Xs2jG1WxtC2orlH+R55ruBA=; b=D9A+h6JhAsYffKhLWwcs24FZyt
 FjKDMAfGVnSvmfHBY6N0oVwjOXQXLTr4Pi1oAEgHZ7DuoWXP5vjeZm1IZTgPJBQm3NDxGabaoLA/8
 u0F+eiJXjvj1LzKzdzBE8tTNX6bld7ZKC2ivyC3XyGP9kouHEQGJ4kfWAR1+dmJGDF3Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jra06c0Xr2RbFD0Dbah6Xs2jG1WxtC2orlH+R55ruBA=; b=A
 rqcj33jwb/kfsdQNNZ8KxTfFhVUSKGscMOSqghqCXGMcIFbHIF8+it+BAtFGT/GG4vz3HCj4O9aCe
 zFetFXQSWiOE4uhZ83nptcfJ8qMA19SwkVyLAgZwVMVe1C5mGPSQmdTbU8hujRWyRFXT7a8wNG88G
 vmzNepKXFVSo0dxM=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wztnw-0007r2-Bf for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 10:27:26 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so468338f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 03:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787912838; x=1788517638; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jra06c0Xr2RbFD0Dbah6Xs2jG1WxtC2orlH+R55ruBA=;
 b=gNNHwCbb2/ItHVwCj1epWbdphqbj67iWnQrY6FGn5RYN7JWBL7JQ9Rht+oaYl+WAhT
 NyCcwqpGspPjMJlfJ4s3XT55svuyF1tTCzuGO6nVll+V1Kb+HjPtE1cVmilf9o52jChk
 Sn50KlpSlOSTDCPLFn9Vj+QbZXcVhZ5vtUDpVN1bn34nzE34+MPzlSI9SqHf1h7QPEb9
 GKmtkZKhKbMI7WYlRnw53K7+f1BFR8V9ODBmS+0oCCWIp62RxggE8rD71oNQt6r0/iuD
 Uk+VjLv+8ybJ/tbNcuUM57Ph03RZnWMz7fXc5Ow5ktEnQYLgLn8J1dIM7NVGx6iLrzY5
 i5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787912838; x=1788517638;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jra06c0Xr2RbFD0Dbah6Xs2jG1WxtC2orlH+R55ruBA=;
 b=myK4TLJ7ZxgX1/tUxp+yxfn1BMROkh7J7gF3JaFWHik34t0n5uuz0s6V04qYb5cBi2
 btaaHij+T6mG7xJcnzk2ew8lnjhleKOSxczOjh4MDckB3KcvBQRtBX/MXOir3QSnqUCf
 Ine0bJRH6CfU1HVy5GCSXiJLBfPQJPOhIo6hlaUx6855/kubBAZQENAX5YZgu5iRoxVC
 W8EDUzA81994tZXxNyPoWeVt80/9hpzwbuZeT+q/+VfV1QgK8JsnbGcRdFZ+fwHHPH33
 fu248m5LuE7OuOV6bXkLEzQXJ2AJPPTY2ntMIVW99jF+0iwIRmPMtoi3LgmGxLdw0ha4
 rMNQ==
X-Gm-Message-State: AFuF++mv8Sh4MSSpuNcR1Dg/Kwo0mFWZF/eJtS1Lg9NC+SElUq5fwzUb
 nMGZHeJPVPwq+kZs0mjmO8Q4NbPSDxYALtFNPYdQXX/5n5o1b/+kUTjyKDv+/sdR3JNE5b7ocIM
 7lVN1tWN8CzHrX1pq0gRbS8de2EpMy84fq0Lfxs0wEoKp7lQ6JPWReP3SPxy+behiRo+L
X-Gm-Gg: AR+sD11fdK0dPGuy8K4b3R9XhEj8eWHWqhU/4OL60pJkfYZmkmODx4WhKZSFJslJW+N
 4F90piVb3crknFzKkiGtM4Cq8xxXJD0o10GKXvQQzgszAN54Bzc4a1T9yTw1V6hlwUANJQqDlI+
 LZB3eZw3/ZtehrybMVFfl4HWF1GXY2L4ALusCJq7AUgE0nTpFBeOHIfgHAlf/JL4Tp2l9djPIHC
 L7mca9HfA2A+KFY+1WwWdDbzDvyFt/77hdupNII4n2pXpkRmL2spgisW4hEpY4v5ogXky16cHD7
 QLBsA5TWDVnkwHSz7rA019hcvLmjBSGStLOZU1OuLN/F/O4z+YXH0QQLoUrxbxOitvCdX/dusC+
 c3+wk4lURFIYgGq3QjfWqtISfnuPkZHe4RK9tvAuMmekJppHaS8CEzBDhQ0IG+gjJ7F6FuLDrgO
 s45zP2IEQLBA5K/rijnYKsLwM6jpa0dB+HwPns14uVpsq9+GcsjhDMqwc+Dde1Fban4H72FXqPu
 ukSsDYqvzN3U7XcxzNIx9u39jSd1DYKCw4tJOVqYhslnrRdug93ABApfDtcyAdQyOXyexOkiSx1
 cEbsu1oQWKvmYGoI27lL5Y2k66JSkRCv2E2RCCRmTYIKLl/sgrw=
X-Received: by 2002:a5d:5a45:0:b0:47f:e721:1f77 with SMTP id
 ffacd0b85a97d-482f79db52emr6860048f8f.13.1787912836659; 
 Fri, 28 Aug 2026 03:27:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3f22sm3145348f8f.2.2026.08.28.03.27.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 03:27:16 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 10:27:15 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ic1ed693f73029f5b5609f717333fdaaabe42acbd
X-Gerrit-Change-Number: 1853
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1853?usp=email>
X-Gerrit-Commit: 79f5dc97f643d5157d5b9eebd1481af6960b3aab
In-Reply-To: <gerrit.1787327336000.Ic1ed693f73029f5b5609f717333fdaaabe42acbd@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ic1ed693f73029f5b5609f717333fdaaabe42acbd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkljMWVkNjkzZjczMDI5ZjViNTYwOWY3MTczMzNmZGFhYWJlNDJhY2JkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <683a0bc269106257d59bc2182fa97584338c2022-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wztnw-0007r2-Bf
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
Content-Type: multipart/mixed; boundary="===============5398888694069150281=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5398888694069150281==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="haQbiwGUL/c="; charset=UTF-8

--haQbiwGUL/c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1853?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
flichtenheld


Change subject: Move mocks from test_push_update_msg into it=
s own compile unit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Move mocks from test_push_update_msg into its own compile unit

Thi=
s allows these mocks to be reused by other unit tests that
need to include =
push_util=2Ec/h functions=2E

Change-Id: Ic1ed693f73029f5b5609f717333fdaaab=
e42acbd
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1853
Message-Id: <20260826185329=2E18177-1-gert@greenie=2Em=
uc=2Ede>
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeL=
ists=2Etxt
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/unit_tests/open=
vpn/mock_push_dependencies=2Ec
M tests/unit_tests/openvpn/test_push_update_=
msg=2Ec
4 files changed, 71 insertions(+), 42 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/53/1853/8

diff --git =
a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 2c3324d=2E=2E6eb5954 100644
---=
 a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -930,6 +930,7 @@
     target_=
sources(test_push_update_msg PRIVATE
         tests/unit_tests/openvpn/mock=
_msg=2Ec
         tests/unit_tests/openvpn/mock_get_random=2Ec
+        tes=
ts/unit_tests/openvpn/mock_push_dependencies=2Ec
         src/openvpn/optio=
ns_util=2Ec
         src/openvpn/otime=2Ec
         src/openvpn/list=2Ec
di=
ff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvp=
n/Makefile=2Eam
index 6db611e=2E=2E5954902 100644
--- a/tests/unit_tests/op=
envpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -400,6 =
+400,7 @@
 push_update_msg_testdriver_SOURCES =3D test_push_update_msg=2Ec =
\
 	mock_msg=2Ec \
 	mock_get_random=2Ec \
+	mock_push_dependencies=2Ec \
 =
	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/platfor=
m=2Ec \
 	$(top_srcdir)/src/openvpn/options_util=2Ec \
diff --git a/tests/u=
nit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/openvpn/moc=
k_push_dependencies=2Ec
new file mode 100644
index 0000000=2E=2E112bcfd
---=
 /dev/null
+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
@@ -0,=
0 +1,69 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP network=
s
+ *             over a single UDP port, with support for SSL/TLS-based
+ =
*             session authentication and key exchange,
+ *             pack=
et encryption, packet authentication, and
+ *             packet compressio=
n=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *=

+ *  This program is free software; you can redistribute it and/or modify
=
+ *  it under the terms of the GNU General Public License version 2
+ *  as=
 published by the Free Software Foundation=2E
+ *
+ *  This program is dist=
ributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; =
without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A =
PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more det=
ails=2E
+ *
+ *  You should have received a copy of the GNU General Public =
License along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/=
licenses/>=2E
+ */
+
+/* Set of mocked function/globals to get unit tests t=
o
+ * compile that use the push_util=2Ec file */
+
+
+#ifdef HAVE_CONFIG_H
=
+#include "config=2Eh"
+#endif
+
+#include "error=2Eh"
+#include "options=
=2Eh"
+
+void
+throw_signal_soft(const int signum, const char *signal_text)=

+{
+    msg(M_WARN, "Offending option received from server");
+}
+
+uint64=
_t
+pull_permission_mask(const struct context *c)
+{
+    uint64_t flags =
=3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
+      =
               | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | O=
PT_P_PERSIST
+                     | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY=
 | OPT_P_ECHO | OPT_P_PULL_MODE
+                     | OPT_P_PEER_ID | OPT=
_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+    return flags;
+=
}
+
+void
+unlearn_ifconfig(struct multi_context *m, struct multi_instance =
*mi)
+{
+}
+
+void
+unlearn_ifconfig_ipv6(struct multi_context *m, struct m=
ulti_instance *mi)
+{
+}
+
+void
+update_vhash(struct multi_context *m, str=
uct multi_instance *mi, const char *new_ip, const char *new_ipv6)
+{
+}
+
+=
bool
+options_postprocess_pull(struct options *options, struct env_set *es)=

+{
+    return true;
+}
diff --git a/tests/unit_tests/openvpn/test_push_up=
date_msg=2Ec b/tests/unit_tests/openvpn/test_push_update_msg=2Ec
index 2653=
749=2E=2Ea93f916 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg=
=2Ec
+++ b/tests/unit_tests/openvpn/test_push_update_msg=2Ec
@@ -12,48 +12,=
6 @@
 
 #include "push_util=2Ec"
 
-/* mocks */
-
-void
-throw_signal_soft(=
const int signum, const char *signal_text)
-{
-    msg(M_WARN, "Offending o=
ption received from server");
-}
-
-uint64_t
-pull_permission_mask(const st=
ruct context *c)
-{
-    uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS |=
 OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
-                     | OPT_P_SETENV | OPT=
_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
-                     =
| OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-  =
                   | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROU=
TE | OPT_P_DHCPDNS;
-    return flags;
-}
-
-void
-unlearn_ifconfig(struct =
multi_context *m, struct multi_instance *mi)
-{
-    return;
-}
-
-void
-un=
learn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi)
-{
=
-    return;
-}
-
-void
-update_vhash(struct multi_context *m, struct multi=
_instance *mi, const char *new_ip, const char *new_ipv6)
-{
-    return;
-}=

-
-bool
-options_postprocess_pull(struct options *options, struct env_set =
*es)
-{
-    return true;
-}
-
 /*
  * Counters to track route accumulation=
 across continuation messages=2E
  * Used to verify the bug where update_op=
tions_found resets per message=2E

-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1853?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: Ic1ed693f73029f5b5609f717333fdaaabe42acbd
Gerrit-Change-Nu=
mber: 1853
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--haQbiwGUL/c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #8</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1853?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Move mocks from test=
_push_update_msg into its own compile unit<br><br>This allows these mocks t=
o be reused by other unit tests that<br>need to include push_util=2Ec/h fun=
ctions=2E<br><br>Change-Id: Ic1ed693f73029f5b5609f717333fdaaabe42acbd<br>Si=
gned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1853<br>Message-Id: &lt;20260826185329=2E18177-1-ge=
rt@greenie=2Emuc=2Ede&gt;<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M tests/unit_tests/openvpn/=
Makefile=2Eam<br>A tests/unit_tests/openvpn/mock_push_dependencies=2Ec<br>M=
 tests/unit_tests/openvpn/test_push_update_msg=2Ec<br>4 files changed, 71 i=
nsertions(+), 42 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/53/1853/8</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 2c3324d=2E=2E6=
eb5954 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/=
CMakeLists=2Etxt</span><br><span>@@ -930,6 +930,7 @@</span><br><span>     t=
arget_sources(test_push_update_msg PRIVATE</span><br><span>         tests/u=
nit_tests/openvpn/mock_msg=2Ec</span><br><span>         tests/unit_tests/op=
envpn/mock_get_random=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br=
><span>         src/openvpn/options_util=2Ec</span><br><span>         src/o=
penvpn/otime=2Ec</span><br><span>         src/openvpn/list=2Ec</span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/=
openvpn/Makefile=2Eam</span><br><span>index 6db611e=2E=2E5954902 100644</sp=
an><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+=
++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -400,6 +400,=
7 @@</span><br><span> push_update_msg_testdriver_SOURCES =3D test_push_upda=
te_msg=2Ec \</span><br><span> 	mock_msg=2Ec \</span><br><span> 	mock_get_ra=
ndom=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_pus=
h_dependencies=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/options_util=2Ec \</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/=
openvpn/mock_push_dependencies=2Ec</span><br><span>new file mode 100644</sp=
an><br><span>index 0000000=2E=2E112bcfd</span><br><span>--- /dev/null</span=
><br><span>+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span>=
<br><span>@@ -0,0 +1,69 @@</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVP=
N -- An application to securely tunnel IP networks</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             over a single UDP port, with =
support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             session authentication and key exchange,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption,=
 packet authentication, and</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             packet compression=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; y=
ou can redistribute it and/or modify</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  it under the terms of the GNU General Public License v=
ersion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publ=
ished by the Free Software Foundation=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  This program is distributed in the hope that it will be useful,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WAR=
RANTY; without even the implied warranty of</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PUR=
POSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 GNU General Public License for more details=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  You should have received a copy of the GNU General Public Li=
cense along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with=
 this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* Set of mocked function/globals to get unit tests to</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * compile that use the=
 push_util=2Ec file */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;error=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;options=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+throw_signal_soft(const int signum, const char *signal_text)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    msg(M_WARN, &quot;Offending option =
received from server&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+pull_permission_mask(const struct conte=
xt *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t flags =3D OPT_P_UP=
 | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_SETENV | O=
PT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_MESSAGES | =
OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span style=
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
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--haQbiwGUL/c=--


--===============5398888694069150281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5398888694069150281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5398888694069150281==--

