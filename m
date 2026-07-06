Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B83AC43458
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 08:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+QIqKaP4S6W+VGSrG/vbdncQz8DoGwnhZodI1aNx2WU=; b=BVDLsmestsFf86f9yLFuEA/NAI
	/jK/s3iGgcC1eAf063INP+iAOgK8qCaz8MIJX+eC1OvSMtiAG4ubjpWngkXReJ1o4gGbz9Z6zQB9M
	lzQyCk9cYnnLsyT23U9smGaaKjoeoV4HWL0Y7MSsk7MRDhYd/Sa4Q+DIvEl9PdsQfUIc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgebS-0004yU-Nb;
	Mon, 06 Jul 2026 08:22:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wgebN-0004y4-8j
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 08:22:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TR5yk3b07xPZZbeonwFcyEXAg7SUuE6fQ53Sfrj7Tbo=; b=VXEgM+PSihvAbMwEwWgQY6icTU
 pffCzlFYKOq0OstsxrSsTPpg7vrLFk6KKTpxOLKcOhAYSEYng2tCYOZEE8Sw9x91S5reP/BuzlQzm
 4MR86/D59ChsINMV0H8A+1bkr8wmteXEwFoqJVEqnTMF6MG6nKhL//VzmrtVEY3jmyBA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TR5yk3b07xPZZbeonwFcyEXAg7SUuE6fQ53Sfrj7Tbo=; b=e
 T1j6U63ErSeT3QfVN8MEg/HFxuWb+cU5Yja5nw1bZ56W6QP67/cHYFsSrkd/T9d2u7rVLdfP0pD0f
 Z9uZHoR5zGq2p4+yOSI9OESuKX4MLaL5GljuL+qzH93AXMq33OoRylFxm2tFPCQaKpFVF4SS6dMqU
 +E8XrI1F+7CNPiq8=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wgebJ-0007LN-Il for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 08:22:53 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so20161155e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 06 Jul 2026 01:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783326158; x=1783930958; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TR5yk3b07xPZZbeonwFcyEXAg7SUuE6fQ53Sfrj7Tbo=;
 b=hGRHB29XgmfVwBrwD0tsqdoiP0DBO/ASSLR9nGkCzremloWpHV9QfAKcyAtAxexKqp
 jNO0pOzJvrv4JadW365oaJE4pIBlE/cgc5KO942+gO7nVdpCktofwlx74fj03979Z9jK
 M8vMfuNOJPWLHNENHs6gvF9rD4bl2OiKWo142f2MkDL30wimMkwkpPcSixacZXvV8sNg
 avdqsUBR05Y0whweNVifk/5UGnQ658gmSbrbDrvaW/uriM5KD8mrRFNLmd57IPLz5ghm
 /xXoy2pvjtlRrEazo12ucOs0q+FbZnvc6+iVZmGrWQrN4ELYrpdkY6BVdS4cyz5aWfCs
 KDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783326158; x=1783930958;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TR5yk3b07xPZZbeonwFcyEXAg7SUuE6fQ53Sfrj7Tbo=;
 b=DtSXArtshI4quM5ktfnCDQjq61fzE/NADoxXETM8ccUejEVH+2AsXmO3Z7RGIx+58M
 yd4yGpoLpe8UmNoWRboxVKhtViJNvnoSGDt9X9wf18mAOJ80hEtY0vwX5SgfinSCXKhF
 sl9w/NV7hHjSDuijPfkOLRBXC02CgqTKM5Nme85joqNalIJKOniya5CrOAm5jb1r8XmK
 Wic20ZwyJANyAuwNN70Kdgz0EmV3nvL/KAynW0eliJK+Tg9uxgyO9Bx72vFJTdW/WJfD
 JeP55gN63cidsap8RmHaRXMHtQFJEaPEsdSdmNYi6PXpXWCIA5+EJMrpVkGl6X+X9VaC
 9sKg==
X-Gm-Message-State: AOJu0YyZbLra2OE1NTI0EQuDFtynnaD4xa8FlC780VS/Ow+FIKHwWB+4
 p6cBSOEUw2LsqLJa0pucvBhfCv4WjmHCzvcXiwQDlt1XT/Rq3cWBNcV27Q2YYq+X5PxGOZcI+oG
 qb6jmdpEgA7WPjnoF7jef6sf1m6Pt/uRN/JnM13EIiVbhensnQWkRPpO0f7VIyg4T7rjCFMD+hy
 N+twqpVA==
X-Gm-Gg: AfdE7cltosTdcktQqAfRXxsytpiZuEN9/P5hgpXk/7qJhrh9q76BX8ebTxQp2tNxCsr
 PwGNhVqYd7K+BthnlVA+FfBswfwsqcT8QkfN59jUNz8/r79L2hv+DQoTUSGxYCgbf4BdftYyU44
 zUex2Kfta6e6tytmrxa0Cdu0miPDjddQ1Fsok0ScYvwNUqi/RDo14iAgt52MtMDljsxNyDj2TV3
 PwMhKjO9PGrnSp8+rLXB5wuw2LGQkaZ1wyQdj143wa6UeNpSBA8xBMcgfZpPxUOM+xON4OL4m6W
 3qs45oFey2lQ1mYrOE80DinCMRtFIdojI7FxapP0Z45gK1qliw6NMlqGGsMlqZPIqTJ58BwFJWX
 aeKXOJXX/5Lo8bx6LkHQjMyZ2tpxzNo3nn/hFBLg4pv5g5L1IUBPAAlitpMtoBFV4lhVJaow/Wn
 jP1wB7DRhYL/SxPk6fbgPSDCqfE+2KyZXuIWKbDLjblzKP3bjIDQbGjPokKh2o4cKLeGYqSZcRe
 UbN4NjnwjW9faCXfQzQO/lEUkxAK5dLPPrb+WL277oItSnVQaBh/aJv4M6otsLc/vMi5Gk3G1M0
 FY8=
X-Received: by 2002:a05:600c:848c:b0:493:bc31:b2ae with SMTP id
 5b1f17b1804b1-493d11db5damr105056785e9.10.1783326157934; 
 Mon, 06 Jul 2026 01:22:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f21543sm21815870f8f.35.2026.07.06.01.22.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 01:22:37 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 6 Jul 2026 08:22:28 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: dd46a47bcfe23c4f972a0435811b5b50b556f5ae
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <21c58ee0ac1346eca951ba92c13aedb82d37db40-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wgebJ-0007LN-Il
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 --server-probe to order client remotes by probe
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2773619070685296868=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2773619070685296868==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1qdKxIAqLfQ="; charset=UTF-8

--1qdKxIAqLfQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1747?usp=3Demail

to look at the new patch set (#6)=2E

=

Change subject: oob: Add --server-probe to order client remotes by probe
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add --se=
rver-probe to order client remotes by probe

With --server-probe, before co=
nnecting a client sends an out-of-band
SERVER_PROBE to all configured UDP r=
emotes, collects the PROBE_REPLYs within a
short window, and reorders the c=
onnection list so the best-responding server is
tried first=2E The option i=
s off by default=2E

The probe phase is self-contained in oob_client=2Ec be=
hind a single call from
init=2Ec (before next_connection_entry())=2E It use=
s one dual-stack UDP socket
(IPV6_V6ONLY off, IPv4 remotes sent as IPv4-map=
ped, with an IPv4-only socket
fallback) to fan probes out and collect repli=
es, matches each reply to its
remote by source address, and rejects spoofed=
 replies via the session id the
server echoes back=2E Ranking and reorderin=
g use oob_rank_probe_results()=2E

Per-remote outcomes (skips, resolve/send=
 failures, which servers answered with
their priority/weight, and the final=
 connection order) are logged at verb 4
(D_LOW); a one-line summary of how =
many remotes answered stays at M_INFO=2E

Because the probe is pre-connecti=
on and session-less, replies are handled in
this dedicated loop and never r=
each tls_pre_decrypt(), so P_LAST_OPCODE is not
widened=2E

First-cut limit=
ations: the probe is sent unwrapped, so it currently works only
against a s=
erver without tls-auth/tls-crypt (control-channel wrapping is a
follow-up);=
 only UDP remotes are probed; probing runs once before the first
connection=
=2E

Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Signed-off-by: Le=
v Stipakov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M src/openvpn/Makefil=
e=2Eam
M src/openvpn/init=2Ec
A src/openvpn/oob_client=2Ec
A src/openvpn/oo=
b_client=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
7 files ch=
anged, 560 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/47/1747/6

diff --git a/CMakeLists=2Etxt=
 b/CMakeLists=2Etxt
index 608e39e4=2E=2E16b3aae 100644
--- a/CMakeLists=2Et=
xt
+++ b/CMakeLists=2Etxt
@@ -520,6 +520,8 @@
     src/openvpn/occ=2Eh
    =
 src/openvpn/oob=2Ec
     src/openvpn/oob=2Eh
+    src/openvpn/oob_client=
=2Ec
+    src/openvpn/oob_client=2Eh
     src/openvpn/openvpn=2Ec
     src/=
openvpn/openvpn=2Eh
     src/openvpn/openvpn_win32_resources=2Erc
diff --gi=
t a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index b4b1b92=2E=
=2E78abfa8 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefil=
e=2Eam
@@ -107,6 +107,7 @@
 	pkcs11_openssl=2Ec \
 	pkcs11_mbedtls=2Ec \
 	=
oob=2Ec oob=2Eh \
+	oob_client=2Ec oob_client=2Eh \
 	openvpn=2Ec openvpn=
=2Eh \
 	options=2Ec options=2Eh \
 	options_util=2Ec options_util=2Eh \
di=
ff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index caaa769=2E=2E2=
74c86a 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -48,=
6 +48,7 @@
 #include "ssl_ncp=2Eh"
 #include "tls_crypt=2Eh"
 #include "for=
ward=2Eh"
+#include "oob_client=2Eh"
 #include "auth_token=2Eh"
 #include "=
mss=2Eh"
 #include "mudp=2Eh"
@@ -4474,6 +4475,10 @@
         }
     }
 
+ =
   /* Probe configured remotes and reorder them best-first (--server-probe)=
;
+     * no-op otherwise=2E Must run before next_connection_entry() picks =
a remote=2E */
+    client_probe_and_order_remotes(c);
+
     /* Resets all=
 values to the initial values from the config where needed */
     pre_conn=
ect_restore(&c->options, &c->c2=2Egc);
 
diff --git a/src/openvpn/oob_clien=
t=2Ec b/src/openvpn/oob_client=2Ec
new file mode 100644
index 0000000=2E=2E=
8f93259
--- /dev/null
+++ b/src/openvpn/oob_client=2Ec
@@ -0,0 +1,483 @@
+/=
*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *        =
     over a single TCP/UDP port, with support for SSL/TLS-based
+ *        =
     session authentication and key exchange,
+ *             packet encryp=
tion, packet authentication, and
+ *             packet compression=2E
+ *
=
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  Thi=
s program is free software; you can redistribute it and/or modify
+ *  it u=
nder the terms of the GNU General Public License version 2
+ *  as publishe=
d by the Free Software Foundation=2E
+ *
+ *  This program is distributed i=
n the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without e=
ven the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULA=
R PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+=
 *
+ *  You should have received a copy of the GNU General Public License a=
long
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/=
>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#includ=
e "syshead=2Eh"
+
+#include "oob_client=2Eh"
+#include "openvpn=2Eh"
+#incl=
ude "oob=2Eh"
+#include "ssl_pkt=2Eh"
+#include "session_id=2Eh"
+#include =
"socket=2Eh"
+#include "socket_util=2Eh"
+#include "otime=2Eh"
+#include "f=
dmisc=2Eh"
+#include "crypto=2Eh"
+#include "error=2Eh"
+
+#include "memdbg=
=2Eh"
+
+/* Total time we wait for probe replies before giving up and conne=
cting=2E */
+#define OOB_PROBE_WINDOW_MS 1000
+
+/* Number of times an unan=
swered probe is resent within the window, to ride out
+ * UDP packet loss=
=2E With this set to 1, each remote is probed up to 2 times,
+ * which remo=
ves the single-packet-loss false negative; further retries give
+ * sharply=
 diminishing returns for a low-stakes selection=2E */
+#define OOB_PROBE_RE=
TRIES 1
+
+/* Where we sent a probe, so a reply's source address can be mat=
ched back to the
+ * connection-list entry it belongs to=2E */
+struct prob=
e_target
+{
+    struct sockaddr_storage dest;
+    socklen_t destlen;
+   =
 bool sent;
+};
+
+/* The probe uses one native socket per address family, =
so every remote is probed
+ * on an AF-native socket (no IPv4-mapped addres=
ses)=2E The winning remote's socket
+ * can then be reused as its connectio=
n socket, presenting the same source
+ * IP+port the server bound its hands=
hake cookie to=2E */
+#define PROBE_AF_V4    0
+#define PROBE_AF_V6    1
+#=
define PROBE_AF_COUNT 2
+
+struct probe_ctx
+{
+    socket_descriptor_t sd[=
PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if that AF is unavailable */
+};
+
+/*=
 @p af is an int (not sa_family_t) so callers can pass addrinfo::ai_family
=
+ * directly without a narrowing conversion (-Werror=3Dconversion)=2E */
+s=
tatic int
+probe_af_index(int af)
+{
+    return (af =3D=3D AF_INET6) ? PRO=
BE_AF_V6 : PROBE_AF_V4;
+}
+
+/* Build a plaintext SERVER_PROBE packet:
+ *=
   [opcode | key_id=3D0] [client session id] [SERVER_PROBE message]
+ * Thi=
s is the unauthenticated OOB wire format; adding tls-auth/tls-crypt
+ * wra=
pping for the probe is a follow-up (it only works against a server with
+ *=
 no control-channel wrapping for now)=2E */
+static bool
+oob_probe_build_p=
acket(struct buffer *buf, const struct session_id *client_sid)
+{
+    cons=
t struct oob_probe_parameter param =3D {
+        =2Etimestamp =3D (uint64_=
t)now,
+        =2Eflags =3D 0,
+    };
+    uint8_t header =3D (uint8_t)(P=
_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
+    return buf_write_u8(buf, header) &=
& session_id_write(client_sid, buf)
+           && oob_server_probe_write(b=
uf, &param);
+}
+
+/* Open one native UDP probe socket per address family (=
v4 and v6)=2E Each is
+ * AF-native (the v6 socket is set IPV6_V6ONLY so no=
 IPv4-mapped traffic crosses
+ * it), so a remote is always probed on a soc=
ket that can later serve as its
+ * connection socket=2E Unavailable famili=
es are left SOCKET_UNDEFINED=2E Returns the
+ * number of sockets opened=2E=
 */
+static int
+oob_probe_sockets_open(struct probe_ctx *pc)
+{
+    int o=
pened =3D 0;
+
+    pc->sd[PROBE_AF_V4] =3D socket(AF_INET, SOCK_DGRAM, IPP=
ROTO_UDP);
+    if (pc->sd[PROBE_AF_V4] !=3D SOCKET_UNDEFINED)
+    {
+    =
    set_cloexec(pc->sd[PROBE_AF_V4]);
+        opened++;
+    }
+
+    pc->=
sd[PROBE_AF_V6] =3D socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP);
+    if (pc-=
>sd[PROBE_AF_V6] !=3D SOCKET_UNDEFINED)
+    {
+        set_cloexec(pc->sd[=
PROBE_AF_V6]);
+        int on =3D 1;
+        if (setsockopt(pc->sd[PROBE_=
AF_V6], IPPROTO_IPV6, IPV6_V6ONLY, (void *)&on, sizeof(on)) !=3D 0)
+      =
  {
+            msg(D_LOW, "server-probe: could not set IPV6_V6ONLY on pro=
be socket");
+        }
+        opened++;
+    }
+
+    return opened;
+}
=
+
+static void
+oob_probe_sockets_close(struct probe_ctx *pc)
+{
+    for (=
int i =3D 0; i < PROBE_AF_COUNT; i++)
+    {
+        if (pc->sd[i] !=3D SO=
CKET_UNDEFINED)
+        {
+            openvpn_close_socket(pc->sd[i]);
+ =
           pc->sd[i] =3D SOCKET_UNDEFINED;
+        }
+    }
+}
+
+/* Parse=
 one received datagram as a PROBE_REPLY and, if valid and matching one
+ * =
of the probes we sent, record the reply in @p results=2E */
+static void
+o=
ob_probe_handle_reply(const uint8_t *data, int len, const struct session_id=
 *client_sid,
+                       const struct sockaddr_storage *from, =
const struct probe_target *targets,
+                       struct oob_prob=
e_result *results, int n)
+{
+    /* Need at least the opcode byte and the =
session id=2E */
+    if (len < 1 + (int)SID_SIZE || (data[0] >> P_OPCODE_S=
HIFT) !=3D P_CONTROL_OOB_V1)
+    {
+        return;
+    }
+
+    struct b=
uffer buf;
+    buf_set_read(&buf, data, (size_t)len);
+    buf_advance(&bu=
f, 1 + SID_SIZE); /* skip opcode + server session id */
+
+    struct oob_p=
robe_reply reply;
+    if (!oob_client_reply_read(&buf, &reply))
+    {
+  =
      return;
+    }
+
+    /* Reject spoofed replies: the reply must echo =
our probe's session id=2E */
+    if (!session_id_equal(&reply=2Epeer_sessi=
on_id, client_sid))
+    {
+        return;
+    }
+
+    /* Match the repl=
y's source address to the remote we probed=2E */
+    for (int i =3D 0; i <=
 n; i++)
+    {
+        if (targets[i]=2Esent
+            && addr_port_ma=
tch((const struct openvpn_sockaddr *)(const void *)from,
+                 =
              (const struct openvpn_sockaddr *)(const void *)&targets[i]=2E=
dest))
+        {
+            results[i]=2Eresponded =3D true;
+          =
  results[i]=2Epriority =3D reply=2Epriority;
+            results[i]=2Ewei=
ght =3D reply=2Eweight;
+            results[i]=2Emax_latency_diff =3D repl=
y=2Emax_latency_diff;
+            break;
+        }
+    }
+}
+
+/* Count =
how many of the probes we sent have been answered so far=2E */
+static int
=
+oob_count_answered(const struct probe_target *targets, const struct oob_pr=
obe_result *results,
+                   int n)
+{
+    int answered =3D 0;=

+    for (int i =3D 0; i < n; i++)
+    {
+        answered +=3D (targets[=
i]=2Esent && results[i]=2Eresponded) ? 1 : 0;
+    }
+    return answered;
=
+}
+
+/* Receive replies for one time slice (until @p deadline), recording =
each that
+ * matches a probe we sent=2E Returns true if every sent probe h=
as been answered=2E */
+static bool
+oob_probe_receive_slice(const struct p=
robe_ctx *pc, const struct timeval *deadline,
+                        cons=
t struct session_id *client_sid, const struct probe_target *targets,
+     =
                   struct oob_probe_result *results, int n, int outstanding=
)
+{
+    while (true)
+    {
+        struct timeval tnow, timeout;
+     =
   openvpn_gettimeofday(&tnow, NULL);
+        timeout=2Etv_sec =3D deadlin=
e->tv_sec - tnow=2Etv_sec;
+        timeout=2Etv_usec =3D deadline->tv_usec=
 - tnow=2Etv_usec;
+        if (timeout=2Etv_usec < 0)
+        {
+        =
    timeout=2Etv_sec -=3D 1;
+            timeout=2Etv_usec +=3D 1000000;
+=
        }
+        if (timeout=2Etv_sec < 0)
+        {
+            return=
 false; /* slice elapsed */
+        }
+
+        fd_set readfds;
+        =
FD_ZERO(&readfds);
+        socket_descriptor_t maxsd =3D 0;
+        for (=
int i =3D 0; i < PROBE_AF_COUNT; i++)
+        {
+            if (pc->sd[i]=
 !=3D SOCKET_UNDEFINED)
+            {
+                openvpn_fd_set(pc->=
sd[i], &readfds);
+                if (pc->sd[i] > maxsd)
+                =
{
+                    maxsd =3D pc->sd[i];
+                }
+           =
 }
+        }
+        if (openvpn_select((int)maxsd + 1, &readfds, NULL, N=
ULL, &timeout) <=3D 0)
+        {
+            return false; /* slice timed=
 out, or error */
+        }
+
+        for (int i =3D 0; i < PROBE_AF_COUN=
T; i++)
+        {
+            if (pc->sd[i] =3D=3D SOCKET_UNDEFINED || !F=
D_ISSET(pc->sd[i], &readfds))
+            {
+                continue;
+  =
          }
+            uint8_t data[256];
+            struct sockaddr_st=
orage from;
+            socklen_t fromlen =3D sizeof(from);
+            i=
nt len =3D (int)recvfrom(pc->sd[i], (char *)data, (int)sizeof(data), 0,
+  =
                                  (struct sockaddr *)&from, &fromlen);
+   =
         if (len > 0)
+            {
+                oob_probe_handle_repl=
y(data, len, client_sid, &from, targets, results, n);
+            }
+     =
   }
+        if (oob_count_answered(targets, results, n) >=3D outstanding)=

+        {
+            return true; /* every probe we sent has been answe=
red */
+        }
+    }
+}
+
+/* Resend the probe to every remote that we =
probed but that has not answered=2E */
+static void
+oob_probe_resend_unans=
wered(const struct probe_ctx *pc, const struct buffer *probe,
+            =
                const struct probe_target *targets,
+                      =
      const struct oob_probe_result *results, int n)
+{
+    for (int i =3D=
 0; i < n; i++)
+    {
+        if (targets[i]=2Esent && !results[i]=2Eresp=
onded)
+        {
+            socket_descriptor_t sd =3D pc->sd[probe_af_i=
ndex(targets[i]=2Edest=2Ess_family)];
+            if (sd !=3D SOCKET_UNDEF=
INED)
+            {
+                sendto(sd, (const char *)BPTR(probe),=
 (int)BLEN(probe), 0,
+                       (const struct sockaddr *)&tar=
gets[i]=2Edest, targets[i]=2Edestlen);
+            }
+        }
+    }
+}
=
+
+/* Collect replies over the probe window, resending unanswered probes up=
 to
+ * OOB_PROBE_RETRIES times (UDP is lossy and a probe carries no retran=
smission
+ * of its own)=2E The window is split into equal slices, one per =
send round; after
+ * each slice but the last we resend to whoever has not =
answered yet=2E Returns
+ * once the window elapses or every sent probe has=
 been answered=2E */
+static void
+oob_probe_collect(const struct probe_ctx=
 *pc, const struct buffer *probe,
+                  const struct session_i=
d *client_sid, const struct probe_target *targets,
+                  struc=
t oob_probe_result *results, int n)
+{
+    /* number of probes we actually=
 sent: stop early once they all answer */
+    int want =3D 0;
+    for (in=
t i =3D 0; i < n; i++)
+    {
+        want +=3D targets[i]=2Esent ? 1 : 0;=

+    }
+
+    const int slices =3D 1 + OOB_PROBE_RETRIES;
+    const long =
slice_ms =3D OOB_PROBE_WINDOW_MS / slices;
+
+    for (int slice =3D 0; sli=
ce < slices; slice++)
+    {
+        struct timeval deadline;
+        ope=
nvpn_gettimeofday(&deadline, NULL);
+        deadline=2Etv_sec +=3D slice_m=
s / 1000;
+        deadline=2Etv_usec +=3D (slice_ms % 1000) * 1000;
+     =
   if (deadline=2Etv_usec >=3D 1000000)
+        {
+            deadline=2E=
tv_sec +=3D 1;
+            deadline=2Etv_usec -=3D 1000000;
+        }
+
+=
        if (oob_probe_receive_slice(pc, &deadline, client_sid, targets, res=
ults, n, want))
+        {
+            return; /* all answered */
+       =
 }
+
+        if (slice + 1 < slices)
+        {
+            oob_probe_res=
end_unanswered(pc, probe, targets, results, n);
+        }
+    }
+}
+
+/* =
Permute the connection list so entries appear in @p ranked order=2E */
+sta=
tic void
+oob_apply_order(struct connection_list *l, const struct oob_probe=
_result *ranked,
+                struct gc_arena *gc)
+{
+    struct conne=
ction_entry **reordered =3D gc_malloc(sizeof(*reordered) * l->len, false, g=
c);
+    for (int i =3D 0; i < l->len; i++)
+    {
+        reordered[i] =
=3D l->array[ranked[i]=2Eindex];
+    }
+    memcpy(l->array, reordered, si=
zeof(*l->array) * l->len);
+}
+
+void
+client_probe_and_order_remotes(struc=
t context *c)
+{
+    /* Probe only once, before the first connection attem=
pt=2E */
+    if (!c->options=2Eserver_probe || !c->first_time)
+    {
+   =
     return;
+    }
+
+    struct connection_list *l =3D c->options=2Econne=
ction_list;
+    if (!l || l->len <=3D 1)
+    {
+        return; /* nothin=
g to choose between */
+    }
+
+    struct gc_arena gc =3D gc_new();
+
+  =
  /* A single random session id identifies all of our probes; servers echo =
it
+     * back in the reply's peer_session_id, letting us reject spoofed r=
eplies=2E */
+    struct session_id client_sid;
+    session_id_random(&cli=
ent_sid);
+
+    struct probe_ctx pc =3D { =2Esd =3D { SOCKET_UNDEFINED, SO=
CKET_UNDEFINED } };
+    if (oob_probe_sockets_open(&pc) =3D=3D 0)
+    {
+=
        msg(D_LOW, "server-probe: could not open probe socket; using config=
ured order");
+        gc_free(&gc);
+        return;
+    }
+
+    struct =
probe_target *targets =3D gc_malloc(sizeof(*targets) * l->len, true, &gc);
=
+    struct oob_probe_result *results =3D gc_malloc(sizeof(*results) * l->l=
en, true, &gc);
+
+    struct buffer probe =3D alloc_buf_gc(256, &gc);
+   =
 if (!oob_probe_build_packet(&probe, &client_sid))
+    {
+        msg(D_LO=
W, "server-probe: could not build probe packet; using configured order");
+=
        oob_probe_sockets_close(&pc);
+        gc_free(&gc);
+        retur=
n;
+    }
+
+    msg(D_LOW, "server-probe: probing %d remote(s) with a %d m=
s window", l->len,
+        OOB_PROBE_WINDOW_MS);
+
+    /* Send a probe to=
 each configured remote=2E */
+    int sent_count =3D 0;
+    for (int i =
=3D 0; i < l->len; i++)
+    {
+        results[i]=2Eindex =3D i;
+        =
results[i]=2Eresponded =3D false;
+
+        const struct connection_entry =
*ce =3D l->array[i];
+        if (!ce->remote)
+        {
+            cont=
inue; /* nothing to probe (e=2Eg=2E a connection block with no --remote) */=

+        }
+        if (!proto_is_udp(ce->proto))
+        {
+            =
msg(D_LOW, "server-probe: %s:%s: skipping (not a UDP remote)", ce->remote,
=
+                ce->remote_port);
+            continue;
+        }
+
+   =
     struct addrinfo *ai =3D NULL;
+        int status =3D openvpn_getaddri=
nfo(GETADDR_RESOLVE | GETADDR_TRY_ONCE | GETADDR_DATAGRAM,
+               =
                          ce->remote, ce->remote_port, 0, NULL, AF_UNSPEC, =
&ai);
+        if (status !=3D 0 || !ai)
+        {
+            msg(D_LOW,=
 "server-probe: %s:%s: could not resolve", ce->remote, ce->remote_port);
+ =
           continue;
+        }
+
+        /* Probe the first resolved addr=
ess on the socket matching its address
+         * family (stored natively;=
 no IPv4-mapping)=2E */
+        socket_descriptor_t sd =3D pc=2Esd[probe_a=
f_index(ai->ai_family)];
+        if (sd =3D=3D SOCKET_UNDEFINED)
+        =
{
+            msg(D_LOW, "server-probe: %s:%s: not reachable by the probe =
socket", ce->remote,
+                ce->remote_port);
+        }
+       =
 else
+        {
+            memcpy(&targets[i]=2Edest, ai->ai_addr, ai->a=
i_addrlen);
+            socklen_t destlen =3D (socklen_t)ai->ai_addrlen;
+=
            if (sendto(sd, (const char *)BPTR(&probe), (int)BLEN(&probe), 0=
,
+                       (struct sockaddr *)&targets[i]=2Edest, destlen)
+=
                < 0)
+            {
+                msg(D_LOW, "server-pro=
be: %s:%s: probe send failed", ce->remote, ce->remote_port);
+            }=

+            else
+            {
+                targets[i]=2Edestlen =3D=
 destlen;
+                targets[i]=2Esent =3D true;
+                sen=
t_count++;
+            }
+        }
+        freeaddrinfo(ai);
+    }
+
+ =
   if (sent_count > 0)
+    {
+        oob_probe_collect(&pc, &probe, &clie=
nt_sid, targets, results, l->len);
+    }
+    oob_probe_sockets_close(&pc)=
;
+
+    /* Log each remote's outcome while results[i] still maps to array[=
i]=2E */
+    int responded =3D 0;
+    for (int i =3D 0; i < l->len; i++)
=
+    {
+        const struct connection_entry *ce =3D l->array[i];
+       =
 if (results[i]=2Eresponded)
+        {
+            responded++;
+        =
    msg(D_LOW, "server-probe: %s:%s answered (priority %d, weight %d)", ce-=
>remote,
+                ce->remote_port, results[i]=2Epriority, results[i=
]=2Eweight);
+        }
+        else
+        {
+            msg(D_LOW, "s=
erver-probe: %s:%s did not answer", ce->remote, ce->remote_port);
+        =
}
+    }
+
+    /* Rank best-first and reorder the connection list accordin=
gly=2E */
+    oob_rank_probe_results(results, l->len, c->options=2Eserver_=
probe_latency_margin, get_random, &gc);
+    oob_apply_order(l, results, &g=
c);
+
+    msg(D_LOW, "server-probe: connecting in this order:");
+    for =
(int i =3D 0; i < l->len; i++)
+    {
+        msg(D_LOW, "server-probe:   =
%d=2E %s:%s", i + 1, l->array[i]->remote,
+            l->array[i]->remote_=
port);
+    }
+
+    msg(M_INFO, "server-probe: %d of %d remote(s) answered=
; connecting best-first", responded,
+        l->len);
+
+    gc_free(&gc);=

+}
diff --git a/src/openvpn/oob_client=2Eh b/src/openvpn/oob_client=2Eh
ne=
w file mode 100644
index 0000000=2E=2Eac44cdb
--- /dev/null
+++ b/src/openv=
pn/oob_client=2Eh
@@ -0,0 +1,44 @@
+/*
+ *  OpenVPN -- An application to se=
curely tunnel IP networks
+ *             over a single TCP/UDP port, with =
support for SSL/TLS-based
+ *             session authentication and key ex=
change,
+ *             packet encryption, packet authentication, and
+ *  =
           packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN I=
nc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can re=
distribute it and/or modify
+ *  it under the terms of the GNU General Publ=
ic License version 2
+ *  as published by the Free Software Foundation=2E
+=
 *
+ *  This program is distributed in the hope that it will be useful,
+ *=
  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCH=
ANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General=
 Public License for more details=2E
+ *
+ *  You should have received a cop=
y of the GNU General Public License along
+ *  with this program; if not, s=
ee <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * Client-=
side server-probe phase: before connecting, optionally probe all
+ * config=
ured remotes with an out-of-band SERVER_PROBE and order them
+ * best-first=
, so the connection loop tries the most suitable server first=2E
+ */
+
+#i=
fndef OOB_CLIENT_H
+#define OOB_CLIENT_H
+
+struct context;
+
+/**
+ * Prob=
e all configured remotes and reorder the connection list best-first=2E
+ *
=
+ * Does nothing unless --server-probe is enabled=2E On any failure (or if =
no
+ * server answers), the configured remote order is left unchanged and t=
he
+ * normal connection sequence proceeds=2E
+ */
+void client_probe_and_o=
rder_remotes(struct context *c);
+
+#endif /* OOB_CLIENT_H */
diff --git a/=
src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index f414024=2E=2Ed54e3a=
b 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -80=
3,6 +803,11 @@
     o->topology =3D TOP_UNDEF;
     o->ce=2Eproto =3D PROTO=
_UDP;
     o->ce=2Eaf =3D AF_UNSPEC;
+
+    /* The client latency margin is=
 -1 =3D "not set": the client's value is
+     * authoritative when given, =
otherwise each server's advertised margin (or
+     * the built-in default)=
 applies=2E */
+    o->server_probe_latency_margin =3D -1;
     o->ce=2Ebin=
d_ipv6_only =3D false;
     o->ce=2Econnect_retry_seconds =3D 1;
     o->ce=
=2Econnect_retry_seconds_max =3D 300;
@@ -6506,6 +6511,21 @@
         VERIF=
Y_PERMISSION(OPT_P_GENERAL);
         options->mtu_test =3D true;
     }
+ =
   else if (streq(p[0], "server-probe") && !p[2])
+    {
+        VERIFY_PE=
RMISSION(OPT_P_GENERAL);
+        options->server_probe =3D true;
+        =
if (p[1])
+        {
+            int margin =3D positive_atoi(p[1], msglev=
el);
+            if (margin > 0xffff)
+            {
+                msg(=
msglevel, "--server-probe: max-latency-diff must be 0 to 65535 ms");
+     =
           goto err;
+            }
+            options->server_probe_late=
ncy_margin =3D margin;
+        }
+    }
     else if (streq(p[0], "nice") =
&& p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE);
diff --git=
 a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index a111cf8=2E=2E6b1=
120a 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ =
-335,6 +335,11 @@
 
     bool mtu_test;
 
+    bool server_probe; /* client=
: probe remotes (--server-probe) and connect best-first */
+    /* client: =
default candidate-band margin in ms (--server-probe [max-latency-diff]):
+ =
    * servers within this RTT of the fastest are treated as equally fast */=

+    int server_probe_latency_margin;
+
     bool mlock;
 
     int keepal=
ive_ping; /* a proxy for ping/ping-restart */

-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Ge=
rrit-Change-Number: 1747
Gerrit-PatchSet: 6
Gerrit-Owner: stipa <lstipakov@=
gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: plaisthos <arne-openvpn@rfc2549=2Eorg>

--1qdKxIAqLfQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #6</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1747?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Add =
--server-probe to order client remotes by probe<br><br>With --server-probe,=
 before connecting a client sends an out-of-band<br>SERVER_PROBE to all con=
figured UDP remotes, collects the PROBE_REPLYs within a<br>short window, an=
d reorders the connection list so the best-responding server is<br>tried fi=
rst=2E The option is off by default=2E<br><br>The probe phase is self-conta=
ined in oob_client=2Ec behind a single call from<br>init=2Ec (before next_c=
onnection_entry())=2E It uses one dual-stack UDP socket<br>(IPV6_V6ONLY off=
, IPv4 remotes sent as IPv4-mapped, with an IPv4-only socket<br>fallback) t=
o fan probes out and collect replies, matches each reply to its<br>remote b=
y source address, and rejects spoofed replies via the session id the<br>ser=
ver echoes back=2E Ranking and reordering use oob_rank_probe_results()=2E<b=
r><br>Per-remote outcomes (skips, resolve/send failures, which servers answ=
ered with<br>their priority/weight, and the final connection order) are log=
ged at verb 4<br>(D_LOW); a one-line summary of how many remotes answered s=
tays at M_INFO=2E<br><br>Because the probe is pre-connection and session-le=
ss, replies are handled in<br>this dedicated loop and never reach tls_pre_d=
ecrypt(), so P_LAST_OPCODE is not<br>widened=2E<br><br>First-cut limitation=
s: the probe is sent unwrapped, so it currently works only<br>against a ser=
ver without tls-auth/tls-crypt (control-channel wrapping is a<br>follow-up)=
; only UDP remotes are probed; probing runs once before the first<br>connec=
tion=2E<br><br>Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2<br>Sign=
ed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M CMakeLists=2E=
txt<br>M src/openvpn/Makefile=2Eam<br>M src/openvpn/init=2Ec<br>A src/openv=
pn/oob_client=2Ec<br>A src/openvpn/oob_client=2Eh<br>M src/openvpn/options=
=2Ec<br>M src/openvpn/options=2Eh<br>7 files changed, 560 insertions(+), 0 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/47/1747/6</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Et=
xt b/CMakeLists=2Etxt</span><br><span>index 608e39e4=2E=2E16b3aae 100644</s=
pan><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt=
</span><br><span>@@ -520,6 +520,8 @@</span><br><span>     src/openvpn/occ=
=2Eh</span><br><span>     src/openvpn/oob=2Ec</span><br><span>     src/open=
vpn/oob=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/=
openvpn/oob_client=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    src/openvpn/oob_client=2Eh</span><br><span>     src/openvpn/openvpn=
=2Ec</span><br><span>     src/openvpn/openvpn=2Eh</span><br><span>     src/=
openvpn/openvpn_win32_resources=2Erc</span><br><span>diff --git a/src/openv=
pn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index b4b1b92=
=2E=2E78abfa8 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span>=
<br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -107,6 +107,7 =
@@</span><br><span> 	pkcs11_openssl=2Ec \</span><br><span> 	pkcs11_mbedtls=
=2Ec \</span><br><span> 	oob=2Ec oob=2Eh \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	oob_client=2Ec oob_client=2Eh \</span><br><span> 	o=
penvpn=2Ec openvpn=2Eh \</span><br><span> 	options=2Ec options=2Eh \</span>=
<br><span> 	options_util=2Ec options_util=2Eh \</span><br><span>diff --git =
a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index caaa769=
=2E=2E274c86a 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><=
span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -48,6 +48,7 @@</span><br=
><span> #include &quot;ssl_ncp=2Eh&quot;</span><br><span> #include &quot;tl=
s_crypt=2Eh&quot;</span><br><span> #include &quot;forward=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob_client=
=2Eh&quot;</span><br><span> #include &quot;auth_token=2Eh&quot;</span><br><=
span> #include &quot;mss=2Eh&quot;</span><br><span> #include &quot;mudp=2Eh=
&quot;</span><br><span>@@ -4474,6 +4475,10 @@</span><br><span>         }</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* Probe configured remotes and reorder them best-fi=
rst (--server-probe);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * no-op otherwise=2E Must run before next_connection_entry() picks a=
 remote=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cl=
ient_probe_and_order_remotes(c);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     /* Resets all values to the initial valu=
es from the config where needed */</span><br><span>     pre_connect_restore=
(&amp;c-&gt;options, &amp;c-&gt;c2=2Egc);</span><br><span> </span><br><span=
>diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span=
><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E8f93259<=
/span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob_client=
=2Ec</span><br><span>@@ -0,0 +1,483 @@</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP=
/UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             session authentication and key exchang=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket encryption, packet authentication, and</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@o=
penvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is =
free software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is distributed in the hope that it wi=
ll be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  GNU General Public License for more details=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/lic=
enses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;oob_client=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;openvpn=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_pkt=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
session_id=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;socket=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;socket_util=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;otime=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;fdmisc=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;error=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;me=
mdbg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Total time we wait fo=
r probe replies before giving up and connecting=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define OOB_PROBE_WINDOW_MS 1000</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Number of times an unanswered probe is resen=
t within the window, to ride out</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * UDP packet loss=2E With this set to 1, each remote is probe=
d up to 2 times,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
which removes the single-packet-loss false negative; further retries give</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sharply diminishin=
g returns for a low-stakes selection=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define OOB_PROBE_RETRIES 1</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* Where we sent a probe, so a reply&#39;s source address can b=
e matched back to the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * connection-list entry it belongs to=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+struct probe_target</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct sockaddr_storage dest;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    socklen_t destlen;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    bool sent;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The probe us=
es one native socket per address family, so every remote is probed</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * on an AF-native socket (n=
o IPv4-mapped addresses)=2E The winning remote&#39;s socket</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * can then be reused as its connec=
tion socket, presenting the same source</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * IP+port the server bound its handshake cookie to=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROBE_AF_=
V4    0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROB=
E_AF_V6    1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 PROBE_AF_COUNT 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct probe_ctx</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    socket_descriptor_t sd[PROBE_AF_COUNT=
]; /* SOCKET_UNDEFINED if that AF is unavailable */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 @p af is an int (not sa_family_t) so callers can pass addrinfo::ai_family<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * directly without =
a narrowing conversion (-Werror=3Dconversion)=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+probe_af_index(int af)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Build a plaintext SERVER_PROBE packet:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *   [opcode | key_id=3D0] [client ses=
sion id] [SERVER_PROBE message]</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * This is the unauthenticated OOB wire format; adding tls-auth=
/tls-crypt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * wrappi=
ng for the probe is a follow-up (it only works against a server with</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * no control-channel wrap=
ping for now)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_prob=
e_build_packet(struct buffer *buf, const struct session_id *client_sid)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter para=
m =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Et=
imestamp =3D (uint64_t)now,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_write=
_u8(buf, header) &amp;&amp; session_id_write(client_sid, buf)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; oob_server_=
probe_write(buf, &amp;param);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* Open one native UDP prob=
e socket per address family (v4 and v6)=2E Each is</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * AF-native (the v6 socket is set IPV6_V6ON=
LY so no IPv4-mapped traffic crosses</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * it), so a remote is always probed on a socket that can =
later serve as its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* connection socket=2E Unavailable families are left SOCKET_UNDEFINED=2E Re=
turns the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * number =
of sockets opened=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_p=
robe_sockets_open(struct probe_ctx *pc)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int opened =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pc-&gt;sd[P=
ROBE_AF_V4] =3D socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (pc-&gt;sd[PROBE_AF_V4] !=3D S=
OCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        set_cloex=
ec(pc-&gt;sd[PROBE_AF_V4]);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        opened++;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    pc-&gt;sd[PROBE_AF_V6] =
=3D socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (pc-&gt;sd[PROBE_AF_V6] !=3D SOCKET_UNDEF=
INED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        set_cloexec(pc-&gt;s=
d[PROBE_AF_V6]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     int on =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (setsockopt(pc-&gt;sd[PROBE_AF_V6], IPPROTO_IPV6, IPV6_V6ONLY, (v=
oid *)&amp;on, sizeof(on)) !=3D 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            msg(D_LOW, &quot;server-probe: could not set IPV6_V6ONLY o=
n probe socket&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 opened++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return opened;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_s=
ockets_close(struct probe_ctx *pc)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (int i =3D 0; i &lt; PROBE_AF_COUNT; i++)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (pc-&gt;sd[i] !=3D SOCKET_UNDEFINED)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            openvpn_close_socket(pc-&gt;sd[i=
]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            pc-&=
gt;sd[i] =3D SOCKET_UNDEFINED;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* Parse one received datagram as a PROBE_REPLY an=
d, if valid and matching one</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * of the probes we sent, record the reply in @p results=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_handle_reply(const ui=
nt8_t *data, int len, const struct session_id *client_sid,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                       const struct =
sockaddr_storage *from, const struct probe_target *targets,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                       struct oob_p=
robe_result *results, int n)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Ne=
ed at least the opcode byte and the session id=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 1 + (int)SID_SIZE || (da=
ta[0] &gt;&gt; P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_re=
ad(&amp;buf, data, (size_t)len);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    buf_advance(&amp;buf, 1 + SID_SIZE); /* skip opcode + serv=
er session id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_r=
eply reply;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!oob_client_reply_read(&amp;buf, &amp;reply))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Reject spoofed rep=
lies: the reply must echo our probe&#39;s session id=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!session_id_equal(&amp;reply=
=2Epeer_session_id, client_sid))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* Match the reply&#39;s source ad=
dress to the remote we probed=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    for (int i =3D 0; i &lt; n; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (targets[i]=2Esent</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &amp;&amp; addr_port_match((const=
 struct openvpn_sockaddr *)(const void *)from,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                               (const struct ope=
nvpn_sockaddr *)(const void *)&amp;targets[i]=2Edest))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            results[i]=2Eresponded =3D true;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            results[i]=2E=
priority =3D reply=2Epriority;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            results[i]=2Eweight =3D reply=2Eweight;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            results[i]=2Emax_lat=
ency_diff =3D reply=2Emax_latency_diff;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Count how many of the probes we sent h=
ave been answered so far=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+oob_count_answered(const struct probe_target *targets, const struct oob_p=
robe_result *results,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                   int n)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int an=
swered =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fo=
r (int i =3D 0; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     answered +=3D (targets[i]=2Esent &amp;&amp; results[i]=2Eresponded) ? =
1 : 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return answered;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* Receive replies for one time slice (until @p deadline), reco=
rding each that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * m=
atches a probe we sent=2E Returns true if every sent probe has been answere=
d=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_receive_sl=
ice(const struct probe_ctx *pc, const struct timeval *deadline,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        const s=
truct session_id *client_sid, const struct probe_target *targets,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                        struc=
t oob_probe_result *results, int n, int outstanding)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    while (true)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       struct timeval tnow, timeout;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        openvpn_gettimeofday(&amp;tnow, NULL);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        timeout=2Etv_sec =3D de=
adline-&gt;tv_sec - tnow=2Etv_sec;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        timeout=2Etv_usec =3D deadline-&gt;tv_usec - tnow=2E=
tv_usec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(timeout=2Etv_usec &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         timeout=2Etv_sec -=3D 1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            timeout=2Etv_usec +=3D 1000000;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (timeout=2Etv_sec &lt; 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            return false; /* slice elaps=
ed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        fd_set readfds;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        FD_ZERO(&amp;readfds);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        socket_descriptor_=
t maxsd =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   for (int i =3D 0; i &lt; PROBE_AF_COUNT; i++)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (pc-&gt;sd[i] !=3D SOCKET_UNDEFINED)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                openvpn_fd_set=
(pc-&gt;sd[i], &amp;readfds);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                if (pc-&gt;sd[i] &gt; maxsd)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    maxsd =3D pc-&gt;sd[i=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (openvpn_select((int)max=
sd + 1, &amp;readfds, NULL, NULL, &amp;timeout) &lt;=3D 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return false; /* slice timed out, =
or error */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; PROB=
E_AF_COUNT; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (pc-&gt;sd[i] =3D=3D SOCKET_UNDEFINED || !FD_ISSET(pc-&gt;sd[i], &amp;rea=
dfds))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                con=
tinue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            uint8_t=
 data[256];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    struct sockaddr_storage from;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            socklen_t fromlen =3D sizeof(from);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            int len =3D (int)recv=
from(pc-&gt;sd[i], (char *)data, (int)sizeof(data), 0,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                    (str=
uct sockaddr *)&amp;from, &amp;fromlen);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (len &gt; 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                oob_probe_handle_reply(data, len, cl=
ient_sid, &amp;from, targets, results, n);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (oob_count_answered(targets, results, n) &gt;=3D outstand=
ing)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return true; =
/* every probe we sent has been answered */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* Resend the probe to every remote t=
hat we probed but that has not answered=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+oob_probe_resend_unanswered(const struct probe_ctx *pc, c=
onst struct buffer *probe,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                            const struct probe_target *targets,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
    const struct oob_probe_result *results, int n)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (int i =3D 0; i &lt; n; i++)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (targets[i]=2Esent &amp;&amp; !results[i]=2Eresp=
onded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            socket_desc=
riptor_t sd =3D pc-&gt;sd[probe_af_index(targets[i]=2Edest=2Ess_family)];</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (sd !=
=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            sendto(sd, (const char *)BPTR(probe), (int)BLEN(probe), 0,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                       (=
const struct sockaddr *)&amp;targets[i]=2Edest, targets[i]=2Edestlen);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Collect repli=
es over the probe window, resending unanswered probes up to</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * OOB_PROBE_RETRIES times (UDP is =
lossy and a probe carries no retransmission</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * of its own)=2E The window is split into equal sl=
ices, one per send round; after</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * each slice but the last we resend to whoever has not answere=
d yet=2E Returns</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
once the window elapses or every sent probe has been answered=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+oob_probe_collect(const struct prob=
e_ctx *pc, const struct buffer *probe,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                  const struct session_id *client_sid, c=
onst struct probe_target *targets,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                  struct oob_probe_result *results, int n)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* number of probes we actually sen=
t: stop early once they all answer */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int want =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (int i =3D 0; i &lt; n; i++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        want +=3D targets[i]=2Esent ? 1 : 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const int slices =3D 1 + OOB_PROBE_RETRIES;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const long slice_ms =3D OOB_=
PROBE_WINDOW_MS / slices;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int =
slice =3D 0; slice &lt; slices; slice++)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        struct timeval deadline;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        openvpn_gettimeofday(&amp;deadline, NULL);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        deadline=2Etv_se=
c +=3D slice_ms / 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        deadline=2Etv_usec +=3D (slice_ms % 1000) * 1000;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (deadline=2Etv_usec &g=
t;=3D 1000000)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dea=
dline=2Etv_sec +=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            deadline=2Etv_usec -=3D 1000000;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (oob_probe_receive_slice(pc, &amp;deadline, client_sid, targets, =
results, n, want))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 return; /* all answered */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (slice + 1=
 &lt; slices)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            oob_=
probe_resend_unanswered(pc, probe, targets, results, n);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Permute the connectio=
n list so entries appear in @p ranked order=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+oob_apply_order(struct connection_list *l, const stru=
ct oob_probe_result *ranked,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                struct gc_arena *gc)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct connection_entry **reordered =3D gc_malloc(sizeof(*reord=
ered) * l-&gt;len, false, gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        reordered[i] =3D l-&gt;array[ranked[i]=2Einde=
x];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(l-&gt;array, reorde=
red, sizeof(*l-&gt;array) * l-&gt;len);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+client_probe_and_order_remotes(s=
truct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Probe only on=
ce, before the first connection attempt=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!c-&gt;options=2Eserver_probe || !c-&gt;f=
irst_time)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct connection_list *l =3D c-&gt;options=2Econnection=
_list;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!l ||=
 l-&gt;len &lt;=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn; /* nothing to choose between */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* A single ran=
dom session id identifies all of our probes; servers echo it</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * back in the reply&#39;s pee=
r_session_id, letting us reject spoofed replies=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct session_id client_sid;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&amp;=
client_sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct probe_ctx pc =
=3D { =2Esd =3D { SOCKET_UNDEFINED, SOCKET_UNDEFINED } };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (oob_probe_sockets_open(&amp;p=
c) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &q=
uot;server-probe: could not open probe socket; using configured order&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct probe_target *targets =3D gc_malloc(s=
izeof(*targets) * l-&gt;len, true, &amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct oob_probe_result *results =3D gc_malloc=
(sizeof(*results) * l-&gt;len, true, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer probe =3D alloc_buf_gc(256, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_probe_build_packet=
(&amp;probe, &amp;client_sid))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(D_LOW, &quot;server-probe: could not build probe packet; using con=
figured order&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        oob_probe_sockets_close(&amp;pc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
(D_LOW, &quot;server-probe: probing %d remote(s) with a %d ms window&quot;,=
 l-&gt;len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
OOB_PROBE_WINDOW_MS);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Send a pro=
be to each configured remote=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int sent_count =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Eindex =3D i;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Erespon=
ded =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct con=
nection_entry *ce =3D l-&gt;array[i];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!ce-&gt;remote)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            continue; /* nothing to probe (e=2Eg=2E a conne=
ction block with no --remote) */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (!proto_is_udp(ce-&gt;proto))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s: skipping (n=
ot a UDP remote)&quot;, ce-&gt;remote,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                ce-&gt;remote_port);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        struct addrinfo *ai =3D NULL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        int status =3D openvpn_getaddrinfo(GETAD=
DR_RESOLVE | GETADDR_TRY_ONCE | GETADDR_DATAGRAM,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                         ce-&=
gt;remote, ce-&gt;remote_port, 0, NULL, AF_UNSPEC, &amp;ai);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (status !=3D 0 || !ai)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;s=
erver-probe: %s:%s: could not resolve&quot;, ce-&gt;remote, ce-&gt;remote_p=
ort);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            co=
ntinue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* Probe the first resolved addre=
ss on the socket matching its address</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+         * family (stored natively; no IPv4-mapping)=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        socket_des=
criptor_t sd =3D pc=2Esd[probe_af_index(ai-&gt;ai_family)];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (sd =3D=3D SOCKET_UNDEFI=
NED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &q=
uot;server-probe: %s:%s: not reachable by the probe socket&quot;, ce-&gt;re=
mote,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  ce-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;=
targets[i]=2Edest, ai-&gt;ai_addr, ai-&gt;ai_addrlen);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            socklen_t destlen =3D (sockl=
en_t)ai-&gt;ai_addrlen;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (sendto(sd, (const char *)BPTR(&amp;probe), (int)BLEN(&a=
mp;probe), 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                 (struct sockaddr *)&amp;targets[i]=2Edest, destlen)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                &lt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_LOW, &=
quot;server-probe: %s:%s: probe send failed&quot;, ce-&gt;remote, ce-&gt;re=
mote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            el=
se</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                targets=
[i]=2Edestlen =3D destlen;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                targets[i]=2Esent =3D true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                sent_count++;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        freeaddrinfo(ai);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (sent_count &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=
ob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid, targets, results, l-=
&gt;len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_probe_sockets_cl=
ose(&amp;pc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Log each remote&#3=
9;s outcome while results[i] still maps to array[i]=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int responded =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&=
gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct =
connection_entry *ce =3D l-&gt;array[i];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (results[i]=2Eresponded)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            responded++;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe=
: %s:%s answered (priority %d, weight %d)&quot;, ce-&gt;remote,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                ce-&gt;remote_p=
ort, results[i]=2Epriority, results[i]=2Eweight);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(D_LOW, &quot;server-probe: %s:%s did not answer&quot;, c=
e-&gt;remote, ce-&gt;remote_port);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Rank best-first and r=
eorder the connection list accordingly=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    oob_rank_probe_results(results, l-&gt;len, c-&=
gt;options=2Eserver_probe_latency_margin, get_random, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    oob_apply_order(l, results,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;server-=
probe: connecting in this order:&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server-probe:   =
%d=2E %s:%s&quot;, i + 1, l-&gt;array[i]-&gt;remote,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            l-&gt;array[i]-&gt;remote_por=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    msg(M_INFO, &quot;server-probe: %d of %d remo=
te(s) answered; connecting best-first&quot;, responded,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        l-&gt;len);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/oob_client=2E=
h b/src/openvpn/oob_client=2Eh</span><br><span>new file mode 100644</span><=
br><span>index 0000000=2E=2Eac44cdb</span><br><span>--- /dev/null</span><br=
><span>+++ b/src/openvpn/oob_client=2Eh</span><br><span>@@ -0,0 +1,44 @@</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to secure=
ly tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             over a single TCP/UDP port, with support for SSL/TLS-based=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sess=
ion authentication and key exchange,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             packet encryption, packet authentication, a=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C)=
 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is free software; you can redistribute it an=
d/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it u=
nder the terms of the GNU General Public License version 2</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Softwar=
e Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is d=
istributed in the hope that it will be useful,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the i=
mplied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Licen=
se for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should=
 have received a copy of the GNU General Public License along</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, se=
e &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Client-side server-probe phase: =
before connecting, optionally probe all</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * configured remotes with an out-of-band SERVER_PROBE =
and order them</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * be=
st-first, so the connection loop tries the most suitable server first=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifndef OOB_CLIENT_H</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define OOB_CLIENT_H</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+struct context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Probe all configured remotes and re=
order the connection list best-first=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Does nothing unless --server-probe is enabled=2E On any failure (or i=
f no</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * server answe=
rs), the configured remote order is left unchanged and the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * normal connection sequence procee=
ds=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void client_probe_and_order_re=
motes(struct context *c);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* OOB=
_CLIENT_H */</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/ope=
nvpn/options=2Ec</span><br><span>index f414024=2E=2Ed54e3ab 100644</span><b=
r><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/opt=
ions=2Ec</span><br><span>@@ -803,6 +803,11 @@</span><br><span>     o-&gt;to=
pology =3D TOP_UNDEF;</span><br><span>     o-&gt;ce=2Eproto =3D PROTO_UDP;<=
/span><br><span>     o-&gt;ce=2Eaf =3D AF_UNSPEC;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* The client latency margin is -1 =3D &quot;not set&quot;: =
the client&#39;s value is</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * authoritative when given, otherwise each server&#39;s advertis=
ed margin (or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 the built-in default) applies=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    o-&gt;server_probe_latency_margin =3D -1;</span><br><s=
pan>     o-&gt;ce=2Ebind_ipv6_only =3D false;</span><br><span>     o-&gt;ce=
=2Econnect_retry_seconds =3D 1;</span><br><span>     o-&gt;ce=2Econnect_ret=
ry_seconds_max =3D 300;</span><br><span>@@ -6506,6 +6511,21 @@</span><br><s=
pan>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         opt=
ions-&gt;mtu_test =3D true;</span><br><span>     }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;server-probe&=
quot;) &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        V=
ERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        options-&gt;server_probe =3D true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (p[1])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            int margin =3D positive_atoi(p[1], msgl=
evel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (margin &gt; 0xffff)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             msg(msglevel, &quot;--server-probe: max-latency-diff must be 0=
 to 65535 ms&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                goto err;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            options-&gt;server_probe_latency_margin =3D margin;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (stre=
q(p[0], &quot;nice&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span=
>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_NICE);</span><br><=
span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><=
br><span>index a111cf8=2E=2E6b1120a 100644</span><br><span>--- a/src/openvp=
n/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span=
>@@ -335,6 +335,11 @@</span><br><span> </span><br><span>     bool mtu_test;=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool server_probe; /* client: probe remotes (--server-probe) and connect=
 best-first */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* client: default candidate-band margin in ms (--server-probe [max-latency-=
diff]):</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * serve=
rs within this RTT of the fastest are treated as equally fast */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int server_probe_latency_m=
argin;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     bool mlock;</span><br><span> </span><br><span>     int keepalive_p=
ing; /* a proxy for ping/ping-restart */</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?=
usp=3Demail">change 1747</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1747?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1747 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit=
-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--1qdKxIAqLfQ=--


--===============2773619070685296868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2773619070685296868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2773619070685296868==--

