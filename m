Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416B4C43458
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 06:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GYoMMB4QRgpAcL+ePRrHoyatZbLRV5TOJ+j9yC3Ynxo=; b=ZmdXotijqib0u/gM3khUv9kB/0
	qOHfdivbBuAl6jS2AFlrmWyr0RdLvZKlqMsgSru3I3GbfQSGcjx5TXiM2GCv/8cFdPxpK8UnDIrz1
	QVs50Gq+tGUM1PMPWmEGfg+ABeBUyxpy5vPIqeO+4aPsAUy+xU2MZc/v2JZ1jurtjO24=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgdAh-0004He-8a;
	Mon, 06 Jul 2026 06:51:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wgdAf-0004HM-9p
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:51:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LO3bvckYvb2T595XYyZdxoOfpfMZmwMgvGDY6fmxj54=; b=m3X/CQREaBcrtZ70adab50o+Pd
 gLHgIUvfpkxC02AP8vRfMD+ZPt4IhuyIvb4MwfywEhhK65GIUjpbEpkciPPY2Jc0LAE9H9fsJF+Sf
 vbphvS7mUmXI1bfOPKL3FHfbb/kD7kK5yJeFTadRmphtGUu+rLbtVxwBbfHsoVZzMyrg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LO3bvckYvb2T595XYyZdxoOfpfMZmwMgvGDY6fmxj54=; b=m
 +xnLp0uS7TzlchibsMkGdJo6/lrQrEyFtV/LFS6aGmroViTeVj9asC28dj9Zxn90nj5LMPqWpd2ZL
 qWVBZy5qe+oDa+6ipbDjG/egR7rzqXdSNvvFFVoq+4FCHcU3XZaxEUpOovP+oeUNHdmhTLX9uJb0q
 IC7Zmg/A6O8ODGxI=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wgdAb-000463-1G for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:51:14 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-493b7612475so23516705e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 05 Jul 2026 23:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783320658; x=1783925458; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LO3bvckYvb2T595XYyZdxoOfpfMZmwMgvGDY6fmxj54=;
 b=TzDthdx+Aa/gYKgSataLV2663yRKMjaz91bh7CVVdmGJXVDwg4e5rMKR233Lzvyay2
 oCfEUTnr/w40Drkk23AqvrmSM7TSE9FiMQqxLF7S5bsg4jpIS0jZPBP3tu+GLoSdz7vL
 IpvV7IKN7NchRhhV560n8E97D/zop5wEGhjwFU3qP2SQwlr09j+cNwesH+VAKuQWOFk1
 Y2qqKyrDM6+0QfmNbe4fqDAMd/hVNlgZzXxWi4ihq08LGjx34zfjpvlYqdgi72BjXG06
 kkeaVw5to/ZCSDe35D5yhwJKUXfPIKOYov+Vdp9Xa1jvUUXj9iwvGxRDfHMtORJAL8P0
 1GJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783320658; x=1783925458;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LO3bvckYvb2T595XYyZdxoOfpfMZmwMgvGDY6fmxj54=;
 b=rS8WHuDAfkS441/MhHCoM7t2b1z3Cx7uFJT49e/oJhVmEYfKl93A2U7xY0MtprX22j
 hHNoSYjHVLjWr+U67c1Eq3hOAiDaCT7tT3nge/Ad+ZYw5U/T7hJ3DKGFumDgXuAQL/a9
 aIUFl/pqqU9PgAVH00yhaiM67uR+dTyMNqj0EaHjCbxEjGAPQgj2ZaBHEGNXM2D2LPwH
 CSDJfuwTD9FuVRntz0Hy6vopI+Ow/qCxhn37BwHE5p/YOpVVUoiMKnEkr8vMCB7T5SSd
 G2X1VpQ7w6/RJzeyBEoxxn7rIZRgBJbqkqlF9koX4JvYViPUqaql/dQ1FJn6ABtRbs5n
 UYuA==
X-Gm-Message-State: AOJu0YzmNYU72mLSDv130Dyjgo+KS5Cf0Vbh8HfVgDlrP7wypE9LSWGA
 Gl4epCxQ2X4Sji6SByIISlwrZewT3vS1lRVIfVe6n4VFdXNlMSmoI+ZOsDCuBl5Li0bfTQx2njE
 SSYbzfcpiGCjIvwiu0zCw1O5cNuzcpWxIqvWEzLHiJCxPLCy4wyx8egtZacNmGzWvSDXGwdXMNx
 D8/qLnZw==
X-Gm-Gg: AfdE7cnUucUyKzf/3u/LRQ5knXLjqOeXvJEGM8TASRhZ6jnyDmC3S80iMH7xA0tDoaD
 2duBgZB2/JBSC6pWqk51Npc/D1A1krI+q9Ua5Tg+PrRt65m1MctmxAO1uhKATCxKKf9bQ4IOwZj
 arOF4cFARucN9NcQ8J/A/WGX9wruhuYsSrEjiyouFRawGwwoPYyCxetuLRYrAFbNXYJztbCTPKJ
 0xJI8CDP1/Qj2WutdGmxC0Ep6uKhqdRDwc2t6x25aCxqFIzkqFv9y52xDvuy43vkdkimBx3kE5J
 OBZOpRTW1gI7Pu+maQDy6uSS+IxuAabx/s/pS4t0vTdkw1KRmJAgKgvzJvImJ3N9n8Dw+prRXVa
 2yw05HabKg5JnNSU6q0e31RKYK9KPUaeTv+D5UaW++hYIU17Xt3+PzH4czUvlN4AUteA+W49ISS
 4/Sl8dt27e1Vvax1dvAK9PN7VIUMMMmZPuG+dqDtBRfeXZZWwZnVHA3zdoyYoJa2N0WItUhkyTH
 zOsHmgNGbYdXKUdaOzFOcXm1XdYNPDlQi/zrlN6U6qMFkqnf2kthAerN9/t1dmW6wV5g0c1uyCt
 G0M=
X-Received: by 2002:a05:600c:3112:b0:492:46c3:c7dc with SMTP id
 5b1f17b1804b1-493dd5b0fa4mr4536625e9.14.1783320657241; 
 Sun, 05 Jul 2026 23:50:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdab27dsm243097655e9.4.2026.07.05.23.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 23:50:56 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 6 Jul 2026 06:50:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: b8fe6e45a2f7c60c5f6e6f862b868522b598fad7
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <efa6b4d2b21c1c0552e33db199f92f92091962d0-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wgdAb-000463-1G
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
Content-Type: multipart/mixed; boundary="===============3175486753656047902=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3175486753656047902==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cCSm4q4j8vU="; charset=UTF-8

--cCSm4q4j8vU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1747?usp=3Demail

to look at the new patch set (#5)=2E

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
anged, 558 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/47/1747/5

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
9a53dd5
--- /dev/null
+++ b/src/openvpn/oob_client=2Ec
@@ -0,0 +1,481 @@
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
+st=
atic int
+probe_af_index(sa_family_t af)
+{
+    return (af =3D=3D AF_INET6=
) ? PROBE_AF_V6 : PROBE_AF_V4;
+}
+
+/* Build a plaintext SERVER_PROBE pack=
et:
+ *   [opcode | key_id=3D0] [client session id] [SERVER_PROBE message]
=
+ * This is the unauthenticated OOB wire format; adding tls-auth/tls-crypt
=
+ * wrapping for the probe is a follow-up (it only works against a server w=
ith
+ * no control-channel wrapping for now)=2E */
+static bool
+oob_probe_=
build_packet(struct buffer *buf, const struct session_id *client_sid)
+{
+ =
   const struct oob_probe_parameter param =3D {
+        =2Etimestamp =3D (=
uint64_t)now,
+        =2Eflags =3D 0,
+    };
+    uint8_t header =3D (uin=
t8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
+    return buf_write_u8(buf, he=
ader) && session_id_write(client_sid, buf)
+           && oob_server_probe_=
write(buf, &param);
+}
+
+/* Open one native UDP probe socket per address f=
amily (v4 and v6)=2E Each is
+ * AF-native (the v6 socket is set IPV6_V6ONL=
Y so no IPv4-mapped traffic crosses
+ * it), so a remote is always probed o=
n a socket that can later serve as its
+ * connection socket=2E Unavailable=
 families are left SOCKET_UNDEFINED=2E Returns the
+ * number of sockets op=
ened=2E */
+static int
+oob_probe_sockets_open(struct probe_ctx *pc)
+{
+  =
  int opened =3D 0;
+
+    pc->sd[PROBE_AF_V4] =3D socket(AF_INET, SOCK_DGR=
AM, IPPROTO_UDP);
+    if (pc->sd[PROBE_AF_V4] !=3D SOCKET_UNDEFINED)
+    =
{
+        set_cloexec(pc->sd[PROBE_AF_V4]);
+        opened++;
+    }
+
+ =
   pc->sd[PROBE_AF_V6] =3D socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP);
+    =
if (pc->sd[PROBE_AF_V6] !=3D SOCKET_UNDEFINED)
+    {
+        set_cloexec(=
pc->sd[PROBE_AF_V6]);
+        int on =3D 1;
+        if (setsockopt(pc->sd=
[PROBE_AF_V6], IPPROTO_IPV6, IPV6_V6ONLY, (void *)&on, sizeof(on)) !=3D 0)
=
+        {
+            msg(D_LOW, "server-probe: could not set IPV6_V6ONLY=
 on probe socket");
+        }
+        opened++;
+    }
+
+    return open=
ed;
+}
+
+static void
+oob_probe_sockets_close(struct probe_ctx *pc)
+{
+  =
  for (int i =3D 0; i < PROBE_AF_COUNT; i++)
+    {
+        if (pc->sd[i] =
!=3D SOCKET_UNDEFINED)
+        {
+            openvpn_close_socket(pc->sd[=
i]);
+            pc->sd[i] =3D SOCKET_UNDEFINED;
+        }
+    }
+}
+
+/=
* Parse one received datagram as a PROBE_REPLY and, if valid and matching o=
ne
+ * of the probes we sent, record the reply in @p results=2E */
+static =
void
+oob_probe_handle_reply(const uint8_t *data, int len, const struct ses=
sion_id *client_sid,
+                       const struct sockaddr_storage =
*from, const struct probe_target *targets,
+                       struct o=
ob_probe_result *results, int n)
+{
+    /* Need at least the opcode byte a=
nd the session id=2E */
+    if (len < 1 + (int)SID_SIZE || (data[0] >> P_O=
PCODE_SHIFT) !=3D P_CONTROL_OOB_V1)
+    {
+        return;
+    }
+
+    s=
truct buffer buf;
+    buf_set_read(&buf, data, (size_t)len);
+    buf_adva=
nce(&buf, 1 + SID_SIZE); /* skip opcode + server session id */
+
+    struc=
t oob_probe_reply reply;
+    if (!oob_client_reply_read(&buf, &reply))
+  =
  {
+        return;
+    }
+
+    /* Reject spoofed replies: the reply mus=
t echo our probe's session id=2E */
+    if (!session_id_equal(&reply=2Epee=
r_session_id, client_sid))
+    {
+        return;
+    }
+
+    /* Match t=
he reply's source address to the remote we probed=2E */
+    for (int i =3D=
 0; i < n; i++)
+    {
+        if (targets[i]=2Esent
+            && addr_=
port_match((const struct openvpn_sockaddr *)(const void *)from,
+          =
                     (const struct openvpn_sockaddr *)(const void *)&target=
s[i]=2Edest))
+        {
+            results[i]=2Eresponded =3D true;
+   =
         results[i]=2Epriority =3D reply=2Epriority;
+            results[i=
]=2Eweight =3D reply=2Eweight;
+            results[i]=2Emax_latency_diff =
=3D reply=2Emax_latency_diff;
+            break;
+        }
+    }
+}
+
+/=
* Count how many of the probes we sent have been answered so far=2E */
+sta=
tic int
+oob_count_answered(const struct probe_target *targets, const struc=
t oob_probe_result *results,
+                   int n)
+{
+    int answere=
d =3D 0;
+    for (int i =3D 0; i < n; i++)
+    {
+        answered +=3D (=
targets[i]=2Esent && results[i]=2Eresponded) ? 1 : 0;
+    }
+    return an=
swered;
+}
+
+/* Receive replies for one time slice (until @p deadline), re=
cording each that
+ * matches a probe we sent=2E Returns true if every sent=
 probe has been answered=2E */
+static bool
+oob_probe_receive_slice(const =
struct probe_ctx *pc, const struct timeval *deadline,
+                    =
    const struct session_id *client_sid, const struct probe_target *targets=
,
+                        struct oob_probe_result *results, int n, int out=
standing)
+{
+    while (true)
+    {
+        struct timeval tnow, timeout=
;
+        openvpn_gettimeofday(&tnow, NULL);
+        timeout=2Etv_sec =3D=
 deadline->tv_sec - tnow=2Etv_sec;
+        timeout=2Etv_usec =3D deadline-=
>tv_usec - tnow=2Etv_usec;
+        if (timeout=2Etv_usec < 0)
+        {
+=
            timeout=2Etv_sec -=3D 1;
+            timeout=2Etv_usec +=3D 10=
00000;
+        }
+        if (timeout=2Etv_sec < 0)
+        {
+          =
  return false; /* slice elapsed */
+        }
+
+        fd_set readfds;
+=
        FD_ZERO(&readfds);
+        socket_descriptor_t maxsd =3D 0;
+     =
   for (int i =3D 0; i < PROBE_AF_COUNT; i++)
+        {
+            if (p=
c->sd[i] !=3D SOCKET_UNDEFINED)
+            {
+                openvpn_fd_=
set(pc->sd[i], &readfds);
+                if (pc->sd[i] > maxsd)
+        =
        {
+                    maxsd =3D pc->sd[i];
+                }
+   =
         }
+        }
+        if (openvpn_select((int)maxsd + 1, &readfds,=
 NULL, NULL, &timeout) <=3D 0)
+        {
+            return false; /* sli=
ce timed out, or error */
+        }
+
+        for (int i =3D 0; i < PROBE=
_AF_COUNT; i++)
+        {
+            if (pc->sd[i] =3D=3D SOCKET_UNDEFIN=
ED || !FD_ISSET(pc->sd[i], &readfds))
+            {
+                conti=
nue;
+            }
+            uint8_t data[256];
+            struct soc=
kaddr_storage from;
+            socklen_t fromlen =3D sizeof(from);
+     =
       int len =3D (int)recvfrom(pc->sd[i], (char *)data, (int)sizeof(data)=
, 0,
+                                    (struct sockaddr *)&from, &fromle=
n);
+            if (len > 0)
+            {
+                oob_probe_han=
dle_reply(data, len, client_sid, &from, targets, results, n);
+            =
}
+        }
+        if (oob_count_answered(targets, results, n) >=3D outs=
tanding)
+        {
+            return true; /* every probe we sent has be=
en answered */
+        }
+    }
+}
+
+/* Resend the probe to every remote =
that we probed but that has not answered=2E */
+static void
+oob_probe_rese=
nd_unanswered(const struct probe_ctx *pc, const struct buffer *probe,
+    =
                        const struct probe_target *targets,
+              =
              const struct oob_probe_result *results, int n)
+{
+    for (i=
nt i =3D 0; i < n; i++)
+    {
+        if (targets[i]=2Esent && !results[i=
]=2Eresponded)
+        {
+            socket_descriptor_t sd =3D pc->sd[pr=
obe_af_index(targets[i]=2Edest=2Ess_family)];
+            if (sd !=3D SOCK=
ET_UNDEFINED)
+            {
+                sendto(sd, (const char *)BPTR=
(probe), (int)BLEN(probe), 0,
+                       (const struct sockadd=
r *)&targets[i]=2Edest, targets[i]=2Edestlen);
+            }
+        }
+ =
   }
+}
+
+/* Collect replies over the probe window, resending unanswered p=
robes up to
+ * OOB_PROBE_RETRIES times (UDP is lossy and a probe carries n=
o retransmission
+ * of its own)=2E The window is split into equal slices, =
one per send round; after
+ * each slice but the last we resend to whoever =
has not answered yet=2E Returns
+ * once the window elapses or every sent p=
robe has been answered=2E */
+static void
+oob_probe_collect(const struct p=
robe_ctx *pc, const struct buffer *probe,
+                  const struct s=
ession_id *client_sid, const struct probe_target *targets,
+               =
   struct oob_probe_result *results, int n)
+{
+    /* number of probes we =
actually sent: stop early once they all answer */
+    int want =3D 0;
+   =
 for (int i =3D 0; i < n; i++)
+    {
+        want +=3D targets[i]=2Esent =
? 1 : 0;
+    }
+
+    const int slices =3D 1 + OOB_PROBE_RETRIES;
+    con=
st long slice_ms =3D OOB_PROBE_WINDOW_MS / slices;
+
+    for (int slice =
=3D 0; slice < slices; slice++)
+    {
+        struct timeval deadline;
+ =
       openvpn_gettimeofday(&deadline, NULL);
+        deadline=2Etv_sec +=
=3D slice_ms / 1000;
+        deadline=2Etv_usec +=3D (slice_ms % 1000) * 1=
000;
+        if (deadline=2Etv_usec >=3D 1000000)
+        {
+            =
deadline=2Etv_sec +=3D 1;
+            deadline=2Etv_usec -=3D 1000000;
+  =
      }
+
+        if (oob_probe_receive_slice(pc, &deadline, client_sid, t=
argets, results, n, want))
+        {
+            return; /* all answered =
*/
+        }
+
+        if (slice + 1 < slices)
+        {
+            oo=
b_probe_resend_unanswered(pc, probe, targets, results, n);
+        }
+    =
}
+}
+
+/* Permute the connection list so entries appear in @p ranked order=
=2E */
+static void
+oob_apply_order(struct connection_list *l, const struc=
t oob_probe_result *ranked,
+                struct gc_arena *gc)
+{
+    s=
truct connection_entry **reordered =3D gc_malloc(sizeof(*reordered) * l->le=
n, false, gc);
+    for (int i =3D 0; i < l->len; i++)
+    {
+        reor=
dered[i] =3D l->array[ranked[i]=2Eindex];
+    }
+    memcpy(l->array, reor=
dered, sizeof(*l->array) * l->len);
+}
+
+void
+client_probe_and_order_remo=
tes(struct context *c)
+{
+    /* Probe only once, before the first connect=
ion attempt=2E */
+    if (!c->options=2Eserver_probe || !c->first_time)
+ =
   {
+        return;
+    }
+
+    struct connection_list *l =3D c->option=
s=2Econnection_list;
+    if (!l || l->len <=3D 1)
+    {
+        return; =
/* nothing to choose between */
+    }
+
+    struct gc_arena gc =3D gc_new=
();
+
+    /* A single random session id identifies all of our probes; serv=
ers echo it
+     * back in the reply's peer_session_id, letting us reject =
spoofed replies=2E */
+    struct session_id client_sid;
+    session_id_ra=
ndom(&client_sid);
+
+    struct probe_ctx pc =3D { =2Esd =3D { SOCKET_UNDE=
FINED, SOCKET_UNDEFINED } };
+    if (oob_probe_sockets_open(&pc) =3D=3D 0)=

+    {
+        msg(D_LOW, "server-probe: could not open probe socket; usi=
ng configured order");
+        gc_free(&gc);
+        return;
+    }
+
+  =
  struct probe_target *targets =3D gc_malloc(sizeof(*targets) * l->len, tru=
e, &gc);
+    struct oob_probe_result *results =3D gc_malloc(sizeof(*result=
s) * l->len, true, &gc);
+
+    struct buffer probe =3D alloc_buf_gc(256, &=
gc);
+    if (!oob_probe_build_packet(&probe, &client_sid))
+    {
+       =
 msg(D_LOW, "server-probe: could not build probe packet; using configured o=
rder");
+        oob_probe_sockets_close(&pc);
+        gc_free(&gc);
+    =
    return;
+    }
+
+    msg(D_LOW, "server-probe: probing %d remote(s) wi=
th a %d ms window", l->len,
+        OOB_PROBE_WINDOW_MS);
+
+    /* Send a=
 probe to each configured remote=2E */
+    int sent_count =3D 0;
+    for =
(int i =3D 0; i < l->len; i++)
+    {
+        results[i]=2Eindex =3D i;
+ =
       results[i]=2Eresponded =3D false;
+
+        const struct connection=
_entry *ce =3D l->array[i];
+        if (!ce->remote)
+        {
+         =
   continue; /* nothing to probe (e=2Eg=2E a connection block with no --rem=
ote) */
+        }
+        if (!proto_is_udp(ce->proto))
+        {
+     =
       msg(D_LOW, "server-probe: %s:%s: skipping (not a UDP remote)", ce->r=
emote,
+                ce->remote_port);
+            continue;
+        }=

+
+        struct addrinfo *ai =3D NULL;
+        int status =3D openvpn_g=
etaddrinfo(GETADDR_RESOLVE | GETADDR_TRY_ONCE | GETADDR_DATAGRAM,
+        =
                                 ce->remote, ce->remote_port, 0, NULL, AF_U=
NSPEC, &ai);
+        if (status !=3D 0 || !ai)
+        {
+            msg=
(D_LOW, "server-probe: %s:%s: could not resolve", ce->remote, ce->remote_po=
rt);
+            continue;
+        }
+
+        /* Probe the first resolv=
ed address on the socket matching its address
+         * family (stored na=
tively; no IPv4-mapping)=2E */
+        socket_descriptor_t sd =3D pc=2Esd[=
probe_af_index(ai->ai_family)];
+        if (sd =3D=3D SOCKET_UNDEFINED)
+ =
       {
+            msg(D_LOW, "server-probe: %s:%s: not reachable by the=
 probe socket", ce->remote,
+                ce->remote_port);
+        }
+=
        else
+        {
+            memcpy(&targets[i]=2Edest, ai->ai_addr=
, ai->ai_addrlen);
+            socklen_t destlen =3D (socklen_t)ai->ai_add=
rlen;
+            if (sendto(sd, (const char *)BPTR(&probe), (int)BLEN(&pr=
obe), 0,
+                       (struct sockaddr *)&targets[i]=2Edest, des=
tlen)
+                < 0)
+            {
+                msg(D_LOW, "ser=
ver-probe: %s:%s: probe send failed", ce->remote, ce->remote_port);
+      =
      }
+            else
+            {
+                targets[i]=2Edest=
len =3D destlen;
+                targets[i]=2Esent =3D true;
+            =
    sent_count++;
+            }
+        }
+        freeaddrinfo(ai);
+   =
 }
+
+    if (sent_count > 0)
+    {
+        oob_probe_collect(&pc, &probe=
, &client_sid, targets, results, l->len);
+    }
+    oob_probe_sockets_clo=
se(&pc);
+
+    /* Log each remote's outcome while results[i] still maps to=
 array[i]=2E */
+    int responded =3D 0;
+    for (int i =3D 0; i < l->len=
; i++)
+    {
+        const struct connection_entry *ce =3D l->array[i];
+=
        if (results[i]=2Eresponded)
+        {
+            responded++;
+ =
           msg(D_LOW, "server-probe: %s:%s answered (priority %d, weight %d=
)", ce->remote,
+                ce->remote_port, results[i]=2Epriority, re=
sults[i]=2Eweight);
+        }
+        else
+        {
+            msg(D_=
LOW, "server-probe: %s:%s did not answer", ce->remote, ce->remote_port);
+ =
       }
+    }
+
+    /* Rank best-first and reorder the connection list a=
ccordingly=2E */
+    oob_rank_probe_results(results, l->len, c->options=2E=
server_probe_latency_margin, get_random, &gc);
+    oob_apply_order(l, resu=
lts, &gc);
+
+    msg(D_LOW, "server-probe: connecting in this order:");
+ =
   for (int i =3D 0; i < l->len; i++)
+    {
+        msg(D_LOW, "server-pr=
obe:   %d=2E %s:%s", i + 1, l->array[i]->remote,
+            l->array[i]->=
remote_port);
+    }
+
+    msg(M_INFO, "server-probe: %d of %d remote(s) a=
nswered; connecting best-first", responded,
+        l->len);
+
+    gc_fre=
e(&gc);
+}
diff --git a/src/openvpn/oob_client=2Eh b/src/openvpn/oob_client=
=2Eh
new file mode 100644
index 0000000=2E=2Eac44cdb
--- /dev/null
+++ b/sr=
c/openvpn/oob_client=2Eh
@@ -0,0 +1,44 @@
+/*
+ *  OpenVPN -- An applicatio=
n to securely tunnel IP networks
+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based
+ *             session authentication and=
 key exchange,
+ *             packet encryption, packet authentication, an=
d
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 Op=
enVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you=
 can redistribute it and/or modify
+ *  it under the terms of the GNU Gener=
al Public License version 2
+ *  as published by the Free Software Foundati=
on=2E
+ *
+ *  This program is distributed in the hope that it will be usef=
ul,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *=
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU =
General Public License for more details=2E
+ *
+ *  You should have receive=
d a copy of the GNU General Public License along
+ *  with this program; if=
 not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * =
Client-side server-probe phase: before connecting, optionally probe all
+ *=
 configured remotes with an out-of-band SERVER_PROBE and order them
+ * bes=
t-first, so the connection loop tries the most suitable server first=2E
+ *=
/
+
+#ifndef OOB_CLIENT_H
+#define OOB_CLIENT_H
+
+struct context;
+
+/**
+=
 * Probe all configured remotes and reorder the connection list best-first=
=2E
+ *
+ * Does nothing unless --server-probe is enabled=2E On any failure=
 (or if no
+ * server answers), the configured remote order is left unchang=
ed and the
+ * normal connection sequence proceeds=2E
+ */
+void client_pro=
be_and_order_remotes(struct context *c);
+
+#endif /* OOB_CLIENT_H */
diff =
--git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index f414024=2E=
=2Ed54e3ab 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=
=2Ec
@@ -803,6 +803,11 @@
     o->topology =3D TOP_UNDEF;
     o->ce=2Eprot=
o =3D PROTO_UDP;
     o->ce=2Eaf =3D AF_UNSPEC;
+
+    /* The client latenc=
y margin is -1 =3D "not set": the client's value is
+     * authoritative w=
hen given, otherwise each server's advertised margin (or
+     * the built-=
in default) applies=2E */
+    o->server_probe_latency_margin =3D -1;
     =
o->ce=2Ebind_ipv6_only =3D false;
     o->ce=2Econnect_retry_seconds =3D 1;=

     o->ce=2Econnect_retry_seconds_max =3D 300;
@@ -6506,6 +6511,21 @@
   =
      VERIFY_PERMISSION(OPT_P_GENERAL);
         options->mtu_test =3D true=
;
     }
+    else if (streq(p[0], "server-probe") && !p[2])
+    {
+      =
  VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->server_probe =3D true=
;
+        if (p[1])
+        {
+            int margin =3D positive_atoi(p=
[1], msglevel);
+            if (margin > 0xffff)
+            {
+         =
       msg(msglevel, "--server-probe: max-latency-diff must be 0 to 65535 m=
s");
+                goto err;
+            }
+            options->server=
_probe_latency_margin =3D margin;
+        }
+    }
     else if (streq(p[0=
], "nice") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE);=

diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index a111c=
f8=2E=2E6b1120a 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/opti=
ons=2Eh
@@ -335,6 +335,11 @@
 
     bool mtu_test;
 
+    bool server_probe=
; /* client: probe remotes (--server-probe) and connect best-first */
+    =
/* client: default candidate-band margin in ms (--server-probe [max-latency=
-diff]):
+     * servers within this RTT of the fastest are treated as equa=
lly fast */
+    int server_probe_latency_margin;
+
     bool mlock;
 
    =
 int keepalive_ping; /* a proxy for ping/ping-restart */

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde=
3c06f2
Gerrit-Change-Number: 1747
Gerrit-PatchSet: 5
Gerrit-Owner: stipa <l=
stipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--cCSm4q4j8vU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #5</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
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
=2Ec<br>M src/openvpn/options=2Eh<br>7 files changed, 558 insertions(+), 0 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/47/1747/5</pre><pre style=3D"font-family: mon=
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
><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E9a53dd5<=
/span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob_client=
=2Ec</span><br><span>@@ -0,0 +1,481 @@</span><br><span style=3D"color: hsl(=
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
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+probe_af_in=
dex(sa_family_t af)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (af =3D=
=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Build a pla=
intext SERVER_PROBE packet:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *   [opcode | key_id=3D0] [client session id] [SERVER_PROBE messag=
e]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This is the un=
authenticated OOB wire format; adding tls-auth/tls-crypt</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * wrapping for the probe is a follow-=
up (it only works against a server with</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * no control-channel wrapping for now)=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+oob_probe_build_packet(struct buffer =
*buf, const struct session_id *client_sid)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const struct oob_probe_parameter param =3D {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =3D (uint64_t)now,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D =
0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t header =3D (uint8_=
t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return buf_write_u8(buf, header) &amp;&amp; s=
ession_id_write(client_sid, buf)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+           &amp;&amp; oob_server_probe_write(buf, &amp;param);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* Open one native UDP probe socket per address family (=
v4 and v6)=2E Each is</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * AF-native (the v6 socket is set IPV6_V6ONLY so no IPv4-mapped traffic =
crosses</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * it), so a=
 remote is always probed on a socket that can later serve as its</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * connection socket=2E Unavai=
lable families are left SOCKET_UNDEFINED=2E Returns the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * number of sockets opened=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+oob_probe_sockets_open(struct prob=
e_ctx *pc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    int opened =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    pc-&gt;sd[PROBE_AF_V4] =3D socket(AF_INE=
T, SOCK_DGRAM, IPPROTO_UDP);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (pc-&gt;sd[PROBE_AF_V4] !=3D SOCKET_UNDEFINED)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        set_cloexec(pc-&gt;sd[PROBE_AF_V4]);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        opened++;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    pc-&gt;sd[PROBE_AF_V6] =3D socket(AF_INET6, SOCK_DGR=
AM, IPPROTO_UDP);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (pc-&gt;sd[PROBE_AF_V6] !=3D SOCKET_UNDEFINED)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        set_cloexec(pc-&gt;sd[PROBE_AF_V6]);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        int on =3D 1;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (setsockopt(pc-&g=
t;sd[PROBE_AF_V6], IPPROTO_IPV6, IPV6_V6ONLY, (void *)&amp;on, sizeof(on)) =
!=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW,=
 &quot;server-probe: could not set IPV6_V6ONLY on probe socket&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        opened++;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return opened;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+oob_probe_sockets_close(struct probe_ctx=
 *pc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; PRO=
BE_AF_COUNT; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (pc-&=
gt;sd[i] !=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            openvpn_close_socket(pc-&gt;sd[i]);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            pc-&gt;sd[i] =3D SOCKET_UNDEFINED=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Parse one received datagram as a PROBE_REPLY and, if valid and matching one=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * of the probes we=
 sent, record the reply in @p results=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+oob_probe_handle_reply(const uint8_t *data, int len, const =
struct session_id *client_sid,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                       const struct sockaddr_storage *from, cons=
t struct probe_target *targets,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                       struct oob_probe_result *results, int n)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Need at least the opcode byte =
and the session id=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (len &lt; 1 + (int)SID_SIZE || (data[0] &gt;&gt; P_OPCODE_SHIFT=
) !=3D P_CONTROL_OOB_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct buffer buf;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;buf, data, (size_t)=
len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_advanc=
e(&amp;buf, 1 + SID_SIZE); /* skip opcode + server session id */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct oob_probe_reply reply;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_client_reply_read(&amp=
;buf, &amp;reply))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Reject spoofed replies: the reply must echo o=
ur probe&#39;s session id=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!session_id_equal(&amp;reply=2Epeer_session_id, client_=
sid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* Match the reply&#39;s source address to the remote we prob=
ed=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (in=
t i =3D 0; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (targets[i]=2Esent</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            &amp;&amp; addr_port_match((const struct openvpn_sockaddr *)(=
const void *)from,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                              (const struct openvpn_sockaddr *)(const void =
*)&amp;targets[i]=2Edest))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         results[i]=2Eresponded =3D true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            results[i]=2Epriority =3D reply=2Epriorit=
y;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            resul=
ts[i]=2Eweight =3D reply=2Eweight;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            results[i]=2Emax_latency_diff =3D reply=2Emax_la=
tency_diff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* Count how many of the probes we sent have been answered so far=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+oob_count_answered(const st=
ruct probe_target *targets, const struct oob_probe_result *results,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                   int n)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int answered =3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; n; i++=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        answered +=3D (targets[i=
]=2Esent &amp;&amp; results[i]=2Eresponded) ? 1 : 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return answered;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Receive repli=
es for one time slice (until @p deadline), recording each that</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * matches a probe we sent=2E Re=
turns true if every sent probe has been answered=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+oob_probe_receive_slice(const struct probe_ctx *=
pc, const struct timeval *deadline,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        const struct session_id *client_sid=
, const struct probe_target *targets,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        struct oob_probe_result *results,=
 int n, int outstanding)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (tr=
ue)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        struct timeval tnow, t=
imeout;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        open=
vpn_gettimeofday(&amp;tnow, NULL);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        timeout=2Etv_sec =3D deadline-&gt;tv_sec - tnow=2Etv=
_sec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        timeou=
t=2Etv_usec =3D deadline-&gt;tv_usec - tnow=2Etv_usec;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (timeout=2Etv_usec &lt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            timeout=2Etv_sec -=
=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            t=
imeout=2Etv_usec +=3D 1000000;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (timeout=2Etv_sec &lt; 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            return false; /* slice elapsed */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        fd_set readfds;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        FD_ZERO(&amp;readfds);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        socket_descriptor_t maxsd =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; P=
ROBE_AF_COUNT; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (pc-&gt;sd[i] !=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                openvpn_fd_set(pc-&gt;sd[i], &amp;readfds);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if =
(pc-&gt;sd[i] &gt; maxsd)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    maxsd =3D pc-&gt;sd[i];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (openvpn_select((int)maxsd + 1, &amp;readfds, NULL, NU=
LL, &amp;timeout) &lt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return false; /* slice timed out, or error */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        for (int i =3D 0; i &lt; PROBE_AF_COUNT; i++)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (pc-&gt;sd[i] =3D=3D SOCKE=
T_UNDEFINED || !FD_ISSET(pc-&gt;sd[i], &amp;readfds))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                continue;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            uint8_t data[256];</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            struct sockaddr_storage =
from;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            so=
cklen_t fromlen =3D sizeof(from);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            int len =3D (int)recvfrom(pc-&gt;sd[i], (char *)d=
ata, (int)sizeof(data), 0,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                    (struct sockaddr *)&amp;from, &a=
mp;fromlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (len &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           oob_probe_handle_reply(data, len, client_sid, &amp;from, targets=
, results, n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (oob_count=
_answered(targets, results, n) &gt;=3D outstanding)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return true; /* every probe we sent has=
 been answered */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* Resend the probe to every remote that we probed but that has=
 not answered=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_prob=
e_resend_unanswered(const struct probe_ctx *pc, const struct buffer *probe,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
         const struct probe_target *targets,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                            const struct oob_probe=
_result *results, int n)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int =
i =3D 0; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (targets[i]=2Esent &amp;&amp; !results[i]=2Eresponded)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            socket_descriptor_t sd =3D pc-&gt;sd[=
probe_af_index(targets[i]=2Edest=2Ess_family)];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (sd !=3D SOCKET_UNDEFINED)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                sendto(sd, (con=
st char *)BPTR(probe), (int)BLEN(probe), 0,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                       (const struct sockaddr *)&am=
p;targets[i]=2Edest, targets[i]=2Edestlen);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Collect replies over the probe window,=
 resending unanswered probes up to</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * OOB_PROBE_RETRIES times (UDP is lossy and a probe carries=
 no retransmission</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* of its own)=2E The window is split into equal slices, one per send round;=
 after</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * each slice=
 but the last we resend to whoever has not answered yet=2E Returns</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * once the window elapses o=
r every sent probe has been answered=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+oob_probe_collect(const struct probe_ctx *pc, const struct b=
uffer *probe,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
            const struct session_id *client_sid, const struct probe_target =
*targets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
        struct oob_probe_result *results, int n)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* number of probes we actually sent: stop early once they a=
ll answer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 want =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for=
 (int i =3D 0; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    want +=3D targets[i]=2Esent ? 1 : 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const in=
t slices =3D 1 + OOB_PROBE_RETRIES;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const long slice_ms =3D OOB_PROBE_WINDOW_MS / slices;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    for (int slice =3D 0; slice &lt; sli=
ces; slice++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct timev=
al deadline;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 openvpn_gettimeofday(&amp;deadline, NULL);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        deadline=2Etv_sec +=3D slice_ms / 1000;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        deadline=2Etv_u=
sec +=3D (slice_ms % 1000) * 1000;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (deadline=2Etv_usec &gt;=3D 1000000)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            deadline=2Etv_sec +=3D 1;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            deadline=2E=
tv_usec -=3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (oob_probe_recei=
ve_slice(pc, &amp;deadline, client_sid, targets, results, n, want))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return; /* all answered *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (slice + 1 &lt; slices)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            oob_probe_resend_unanswered(p=
c, probe, targets, results, n);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* Permute the connection list so entries appear =
in @p ranked order=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob=
_apply_order(struct connection_list *l, const struct oob_probe_result *rank=
ed,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct connec=
tion_entry **reordered =3D gc_malloc(sizeof(*reordered) * l-&gt;len, false,=
 gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i=
 =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     reordered[i] =3D l-&gt;array[ranked[i]=2Eindex];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    memcpy(l-&gt;array, reordered, sizeof(*l-&gt;array)=
 * l-&gt;len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+client_probe_and_order_remotes(struct context *c)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* Probe only once, before the first con=
nection attempt=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!c-&gt;options=2Eserver_probe || !c-&gt;first_time)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t connection_list *l =3D c-&gt;options=2Econnection_list;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!l || l-&gt;len &lt;=3D 1)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return; /* nothing to choose=
 between */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* A single random session id identif=
ies all of our probes; servers echo it</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * back in the reply&#39;s peer_session_id, letting =
us reject spoofed replies=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct session_id client_sid;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    session_id_random(&amp;client_sid);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct probe_ctx pc =3D { =2Esd =3D { SOCKET=
_UNDEFINED, SOCKET_UNDEFINED } };</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (oob_probe_sockets_open(&amp;pc) =3D=3D 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server-probe: could =
not open probe socket; using configured order&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct probe_target *targets =3D gc_malloc(sizeof(*targets) * l-&gt;=
len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct oob_probe_result *results =3D gc_malloc(sizeof(*results) * l-&g=
t;len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffe=
r probe =3D alloc_buf_gc(256, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!oob_probe_build_packet(&amp;probe, &amp;client=
_sid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;se=
rver-probe: could not build probe packet; using configured order&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_sock=
ets_close(&amp;pc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;server-pro=
be: probing %d remote(s) with a %d ms window&quot;, l-&gt;len,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        OOB_PROBE_WINDOW_MS);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Send a probe to each configured re=
mote=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int s=
ent_count =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        results[i]=2Eindex =3D i;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        results[i]=2Eresponded =3D false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        const struct connection_entry *ce =3D l-&g=
t;array[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (!ce-&gt;remote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  continue; /* nothing to probe (e=2Eg=2E a connection block with no --remo=
te) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!proto_is_u=
dp(ce-&gt;proto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(D_LOW, &quot;server-probe: %s:%s: skipping (not a UDP remote)&quot;, ce=
-&gt;remote,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         ce-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            continue;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct ad=
drinfo *ai =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        int status =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_TRY_O=
NCE | GETADDR_DATAGRAM,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                         ce-&gt;remote, ce-&gt;remote_p=
ort, 0, NULL, AF_UNSPEC, &amp;ai);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (status !=3D 0 || !ai)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s: could =
not resolve&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        /* Probe the first resolved address on the socket matching =
its address</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * family (stored natively; no IPv4-mapping)=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        socket_descriptor_t sd =3D pc=2Esd[p=
robe_af_index(ai-&gt;ai_family)];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (sd =3D=3D SOCKET_UNDEFINED)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s: n=
ot reachable by the probe socket&quot;, ce-&gt;remote,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                ce-&gt;remote_port);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            memcpy(&amp;targets[i]=2Edest, ai-&gt;=
ai_addr, ai-&gt;ai_addrlen);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            socklen_t destlen =3D (socklen_t)ai-&gt;ai_addrlen;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (sendto=
(sd, (const char *)BPTR(&amp;probe), (int)BLEN(&amp;probe), 0,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                       (struct s=
ockaddr *)&amp;targets[i]=2Edest, destlen)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                &lt; 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                msg(D_LOW, &quot;server-probe: %s:%s: =
probe send failed&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                targets[i]=2Edestlen =3D destle=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                t=
argets[i]=2Esent =3D true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                sent_count++;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        freeaddrinfo(ai);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sent_count &gt; 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_collect(&amp;pc=
, &amp;probe, &amp;client_sid, targets, results, l-&gt;len);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    oob_probe_sockets_close(&amp;pc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* Log each remote&#39;s outcome while result=
s[i] still maps to array[i]=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    int responded =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        const struct connection_entry *ce =3D=
 l-&gt;array[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (results[i]=2Eresponded)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            responded++;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(D_LOW, &quot;server-probe: %s:%s answered (priority=
 %d, weight %d)&quot;, ce-&gt;remote,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                ce-&gt;remote_port, results[i]=2Epriority=
, results[i]=2Eweight);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, =
&quot;server-probe: %s:%s did not answer&quot;, ce-&gt;remote, ce-&gt;remot=
e_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Rank best-first and reorder the connection list=
 accordingly=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   oob_rank_probe_results(results, l-&gt;len, c-&gt;options=2Eserver_probe_=
latency_margin, get_random, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    oob_apply_order(l, results, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    msg(D_LOW, &quot;server-probe: connecting in this =
order:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    f=
or (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(D_LOW, &quot;server-probe:   %d=2E %s:%s&quot;, i + 1, l-=
&gt;array[i]-&gt;remote,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            l-&gt;array[i]-&gt;remote_port);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 msg(M_INFO, &quot;server-probe: %d of %d remote(s) answered; connecting be=
st-first&quot;, responded,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        l-&gt;len);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(=
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span>diff --git a/src/openvpn/oob_client=2Eh b/src/openvpn/oob_client=2E=
h</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2Ea=
c44cdb</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob_=
client=2Eh</span><br><span>@@ -0,0 +1,44 @@</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a singl=
e TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             session authentication and key ex=
change,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   packet encryption, packet authentication, and</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sa=
les@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This progra=
m is free software; you can redistribute it and/or modify</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Gen=
eral Public License version 2</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  as published by the Free Software Foundation=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that i=
t will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS=
 FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  GNU General Public License for more details=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of th=
e GNU General Public License along</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eo=
rg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Client-side server-probe phase: before connecting, optional=
ly probe all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * conf=
igured remotes with an out-of-band SERVER_PROBE and order them</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * best-first, so the connection=
 loop tries the most suitable server first=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef O=
OB_CLIENT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
OOB_CLIENT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+struct context;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Probe all configured remotes and reorder the connection list b=
est-first=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Does nothing unless -=
-server-probe is enabled=2E On any failure (or if no</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * server answers), the configured remote=
 order is left unchanged and the</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * normal connection sequence proceeds=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void client_probe_and_order_remotes(struct context *c);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif /* OOB_CLIENT_H */</span><br><sp=
an>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br=
><span>index f414024=2E=2Ed54e3ab 100644</span><br><span>--- a/src/openvpn/=
options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@=
@ -803,6 +803,11 @@</span><br><span>     o-&gt;topology =3D TOP_UNDEF;</spa=
n><br><span>     o-&gt;ce=2Eproto =3D PROTO_UDP;</span><br><span>     o-&gt=
;ce=2Eaf =3D AF_UNSPEC;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The clie=
nt latency margin is -1 =3D &quot;not set&quot;: the client&#39;s value is<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * authoritative=
 when given, otherwise each server&#39;s advertised margin (or</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * the built-in default) app=
lies=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt=
;server_probe_latency_margin =3D -1;</span><br><span>     o-&gt;ce=2Ebind_i=
pv6_only =3D false;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds =
=3D 1;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds_max =3D 300;</=
span><br><span>@@ -6506,6 +6511,21 @@</span><br><span>         VERIFY_PERMI=
SSION(OPT_P_GENERAL);</span><br><span>         options-&gt;mtu_test =3D tru=
e;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    else if (streq(p[0], &quot;server-probe&quot;) &amp;&amp; !p[2])<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GE=
NERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        opti=
ons-&gt;server_probe =3D true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (p[1])</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           int margin =3D positive_atoi(p[1], msglevel);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (margin &gt; 0xffff)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel=
, &quot;--server-probe: max-latency-diff must be 0 to 65535 ms&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                goto err=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;=
server_probe_latency_margin =3D margin;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;nice&quot;)=
 &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span> =
        VERIFY_PERMISSION(OPT_P_NICE);</span><br><span>diff --git a/src/ope=
nvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index a111cf8=2E=
=2E6b1120a 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><=
span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -335,6 +335,11 @@</sp=
an><br><span> </span><br><span>     bool mtu_test;</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    bool server_probe; /* =
client: probe remotes (--server-probe) and connect best-first */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* client: default candida=
te-band margin in ms (--server-probe [max-latency-diff]):</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * servers within this RTT of the=
 fastest are treated as equally fast */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int server_probe_latency_margin;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     bool mlock;</spa=
n><br><span> </span><br><span>     int keepalive_ping; /* a proxy for ping/=
ping-restart */</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">change 1747=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1747 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipa=
kov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--cCSm4q4j8vU=--


--===============3175486753656047902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3175486753656047902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3175486753656047902==--

