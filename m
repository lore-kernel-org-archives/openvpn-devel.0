Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89190C43327
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=efnoafcOHd6F89cUG9W8Sd2dVgaOyAZdRmQLE+gZc7Q=; b=MQT+7+vL+1gv4X
	zJasz6g4sK2aJ+qlqMLqwHUVDZdIjCTKQnSAG/fyniL029WrjB4HnSEE+KuNY9uFtoP9R9YQUp/ca
	dSbCBE+Oq+UF10tboOTlW3g0WMekY+vgCdHuUcpFrBdOQCqUP+/Mgt8M/boBtH4cwmWAihvLPEb4V
	pQo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we6td-0004vW-Nr;
	Mon, 29 Jun 2026 07:59:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we6tc-0004vO-RK
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LNvZ4mG/nCMtpYghYmIIvBvXTHIL+Rk2fj4hrwgQXAY=; b=esdX+5eqqM/VCA40y5savJ1dfP
 X2dmCoU5t/EEjAoyLhOh7aALFgX0D+UvLmEydWYkHi7X50aD4SF3Ucko8MZRvoEMdA1x4vLlOEUQ4
 R1HWN5ak6Ty7RW1Phie8aMyus805fExGFKLjbZGC33BEQmqYuiO7SnBc/D9OojZdlW/4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LNvZ4mG/nCMtpYghYmIIvBvXTHIL+Rk2fj4hrwgQXAY=; b=F
 wtTOoZ6JDBTC08fmNPqCABboowYo3VIyUgDDD9kJiXbgypfSHS2EHGtyWXsD54Xq1Z0gvVQxl2N/F
 rK/KJ/OzoFTiMoZG4YyXiTxctTWE/ukVuKP0BCbZzbETmxq9/iApwYaaf9cI7CjOL7bcR/k2BhVvV
 4Hlcn0WKP63inpJw=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we6tY-0008NR-Bp for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:13 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4938d5f86f3so10161555e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 00:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782719942; x=1783324742; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LNvZ4mG/nCMtpYghYmIIvBvXTHIL+Rk2fj4hrwgQXAY=;
 b=JcoBjdC9i2tUGzM0YpNKT6qIq/taPGf1vsliZiXwpp+MD81fH7eieENYWIKRJ1D5F2
 oYVzeti71iH9EhulG1xAkCrYYIEVBJTV8K28MnmfVHX1KmsHhTMVHtaxC84+17TtG/xq
 hlpZMV8SAKmdIbczQvoTA0whcORHqfPHj51FOWWHTOCXjH5pFiYsrYMR1fFeuO2gU156
 fAwTYDMxzR8ioMHfcbzXNSONZx1fIJu6pVZsCssP+OOgtfO0SJr96RLluIyJP70+4TwD
 hwtLjtqm56y0AUQFZfjFn0abuate9R8tynH9Tj0rg+khdbrZ3S2hkfp6OO4aHD3/XgMV
 T8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719942; x=1783324742;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LNvZ4mG/nCMtpYghYmIIvBvXTHIL+Rk2fj4hrwgQXAY=;
 b=Z56M9jX4B5dgSDXGAsGQurv3YNxFXbaMNx9u/hfFcXo184e2bCspWauMNmV/CxfzSz
 zVaBK9yGmo32guehhqZYtCEN8UDXLpx59q1QGCbaQzoi167zZKDd1RNK+klpMfQz2T4b
 g+Bm/McS/Rv9puu2HExWgVKBtFEh1YEtmDwUCUadvpL2gSgaoQLuC6IdDzbl5W8/YqbL
 fpMsmLS5ehE2BF7uYqpipUGhVf4zqSJ+sOfQ84gAF0WeZJpVsAfO7VzTh0FCkpO6Jkky
 o0Maqc26BdvPV4E4ZJSyJXJsb1rzDrtUlTr0OyfQIo0ZeY53LZNSR6ZRgwk68ixOU4bM
 nhHQ==
X-Gm-Message-State: AOJu0Yyxt+Xx552OhN7bTd6mfCQSYNkeBMxPu8tFm0L4CY/OpbgJO90q
 oTS+qBztRg+EbPdtnLiUCkdnDcuyWtmLKaSm9DIGRX+2Oa6qMxGljgts0IoUVzQom/ISHLi10Dv
 d2oJa5suVY3/RDQgqJcIPsloMw4rukAegpq2MhMsIrHXhiag8JqwUH5F+3FMxymJtRKAKK40MvR
 fpj79t+w==
X-Gm-Gg: AfdE7clho1WkX5fd+e0vWfXrNI4K7sEoFPVFnsKk4Jvkk4R4/AIGqO2ZhOrg+6aInJl
 A8GSZbQEypFMY+9jaUnwN5YKlG7W0X1xxuVII9hYPtpkrlNLnQFXyjZ7k+8z3lLAl4T0uiQk6Sb
 zebzfdXZ2y+mwtg/U5JHHDHvoDjFtCxTT2g7Iavm9R4Bmv5hz4EJOb8RV8FrBHwVvTDGteITVYg
 762VBwZnTsAT9qsrTiz9nKkJjV8X4yChlQolK5t4UNuK8TUmYH/kjBqJoSbqYO7EwmSmIpX0K1b
 Fz7LwaznHC1zb+ZaTOrkEwn/D6ixu6/zU6sSZ8jdyMsCUsLID1jBx3uAFOH/HLXZc+r5k6D9f4P
 YuW0kwUjqMnwgKDcit1Y4jNclnCP6FFyP5QpbB9q5KjiC+7DLUKXcJH4llvngV2UDZXmuHP+FI4
 IfFiwZgK1AClS9PZ3HDt3qLVKaig0+p+PO9lL7dXGoonzwsH9aHIvoD9IejT1txuSGumsUkF1x6
 skn7XLz2yIWynSW5cFNaUAVs5g93Q5vqOUTmMGqDdCMzGsF1/bnGdVJlvt0RzuERFqcw0+Y9BEn
 g4Q=
X-Received: by 2002:a05:600c:3587:b0:492:4871:7e21 with SMTP id
 5b1f17b1804b1-4926641b4c3mr190001585e9.10.1782719941780; 
 Mon, 29 Jun 2026 00:59:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ae973535sm45631695e9.0.2026.06.29.00.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 00:59:01 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 07:59:00 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: 577a0d1d7afdf2b6f17f2595c5b72401dc6fb5d2
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <19a3cad87d19ae9da919cb52fca548d591a88ef8-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we6tY-0008NR-Bp
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
Content-Type: multipart/mixed; boundary="===============2318009177187376320=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2318009177187376320==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w6p5e6lh/wg="; charset=UTF-8

--w6p5e6lh/wg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1747?usp=3Demail

to review the following change=2E


Chang=
e subject: oob: Add --server-probe to order client remotes by probe
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add --server-p=
robe to order client remotes by probe

With --server-probe, before connecti=
ng a client sends an out-of-band
SERVER_PROBE to all configured UDP remotes=
, collects the PROBE_REPLYs within a
short window, and reorders the connect=
ion list so the best-responding server is
tried first=2E The option is off =
by default=2E

The probe phase is self-contained in oob_client=2Ec behind a=
 single call from
init=2Ec (before next_connection_entry())=2E It uses one =
dual-stack UDP socket
(IPV6_V6ONLY off, IPv4 remotes sent as IPv4-mapped, w=
ith an IPv4-only socket
fallback) to fan probes out and collect replies, ma=
tches each reply to its
remote by source address, and rejects spoofed repli=
es via the session id the
server echoes back=2E Ranking and reordering use =
oob_rank_probe_results()=2E

Per-remote outcomes (skips, resolve/send failu=
res, which servers answered with
their priority/weight, and the final conne=
ction order) are logged at verb 4
(D_LOW); a one-line summary of how many r=
emotes answered stays at M_INFO=2E

Because the probe is pre-connection and=
 session-less, replies are handled in
this dedicated loop and never reach t=
ls_pre_decrypt(), so P_LAST_OPCODE is not
widened=2E

First-cut limitations=
: the probe is sent unwrapped, so it currently works only
against a server =
without tls-auth/tls-crypt (control-channel wrapping is a
follow-up); only =
UDP remotes are probed; probing runs once before the first
connection=2E

C=
hange-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Signed-off-by: Lev Stip=
akov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam=

M src/openvpn/init=2Ec
A src/openvpn/oob_client=2Ec
A src/openvpn/oob_clie=
nt=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
7 files changed,=
 528 insertions(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/47/1747/1

diff --git a/CMakeLists=2Etxt b/CM=
akeLists=2Etxt
index 608e39e4=2E=2E16b3aae 100644
--- a/CMakeLists=2Etxt
++=
+ b/CMakeLists=2Etxt
@@ -520,6 +520,8 @@
     src/openvpn/occ=2Eh
     src/=
openvpn/oob=2Ec
     src/openvpn/oob=2Eh
+    src/openvpn/oob_client=2Ec
+ =
   src/openvpn/oob_client=2Eh
     src/openvpn/openvpn=2Ec
     src/openvpn=
/openvpn=2Eh
     src/openvpn/openvpn_win32_resources=2Erc
diff --git a/src=
/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index b4b1b92=2E=2E78abf=
a8 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@=
@ -107,6 +107,7 @@
 	pkcs11_openssl=2Ec \
 	pkcs11_mbedtls=2Ec \
 	oob=2Ec =
oob=2Eh \
+	oob_client=2Ec oob_client=2Eh \
 	openvpn=2Ec openvpn=2Eh \
 	o=
ptions=2Ec options=2Eh \
 	options_util=2Ec options_util=2Eh \
diff --git a=
/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index caaa769=2E=2E274c86a 100=
644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -48,6 +48,7 @@=

 #include "ssl_ncp=2Eh"
 #include "tls_crypt=2Eh"
 #include "forward=2Eh"
=
+#include "oob_client=2Eh"
 #include "auth_token=2Eh"
 #include "mss=2Eh"
 =
#include "mudp=2Eh"
@@ -4474,6 +4475,10 @@
         }
     }
 
+    /* Prob=
e configured remotes and reorder them best-first (--server-probe);
+     * =
no-op otherwise=2E Must run before next_connection_entry() picks a remote=
=2E */
+    client_probe_and_order_remotes(c);
+
     /* Resets all values =
to the initial values from the config where needed */
     pre_connect_rest=
ore(&c->options, &c->c2=2Egc);
 
diff --git a/src/openvpn/oob_client=2Ec b/=
src/openvpn/oob_client=2Ec
new file mode 100644
index 0000000=2E=2E43aee8d
=
--- /dev/null
+++ b/src/openvpn/oob_client=2Ec
@@ -0,0 +1,451 @@
+/*
+ *  O=
penVPN -- An application to securely tunnel IP networks
+ *             ove=
r a single TCP/UDP port, with support for SSL/TLS-based
+ *             ses=
sion authentication and key exchange,
+ *             packet encryption, pa=
cket authentication, and
+ *             packet compression=2E
+ *
+ *  Cop=
yright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This progra=
m is free software; you can redistribute it and/or modify
+ *  it under the=
 terms of the GNU General Public License version 2
+ *  as published by the=
 Free Software Foundation=2E
+ *
+ *  This program is distributed in the ho=
pe that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the =
implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  =
You should have received a copy of the GNU General Public License along
+ *=
  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ *=
/
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshe=
ad=2Eh"
+
+#include "oob_client=2Eh"
+#include "openvpn=2Eh"
+#include "oob=
=2Eh"
+#include "ssl_pkt=2Eh"
+#include "session_id=2Eh"
+#include "socket=
=2Eh"
+#include "socket_util=2Eh"
+#include "otime=2Eh"
+#include "fdmisc=
=2Eh"
+#include "crypto=2Eh"
+#include "error=2Eh"
+
+#include "memdbg=2Eh"=

+
+/* Total time we wait for probe replies before giving up and connecting=
=2E */
+#define OOB_PROBE_WINDOW_MS 1000
+
+/* Number of times an unanswere=
d probe is resent within the window, to ride out
+ * UDP packet loss=2E Wit=
h this set to 1, each remote is probed up to 2 times,
+ * which removes the=
 single-packet-loss false negative; further retries give
+ * sharply dimini=
shing returns for a low-stakes selection=2E */
+#define OOB_PROBE_RETRIES 1=

+
+/* Where we sent a probe, so a reply's source address can be matched ba=
ck to the
+ * connection-list entry it belongs to=2E */
+struct probe_targe=
t
+{
+    struct sockaddr_storage dest;
+    socklen_t destlen;
+    bool s=
ent;
+};
+
+/* Build a plaintext SERVER_PROBE packet:
+ *   [opcode | key_i=
d=3D0] [client session id] [SERVER_PROBE message]
+ * This is the unauthent=
icated OOB wire format; adding tls-auth/tls-crypt
+ * wrapping for the prob=
e is a follow-up (it only works against a server with
+ * no control-channe=
l wrapping for now)=2E */
+static bool
+oob_probe_build_packet(struct buffe=
r *buf, const struct session_id *client_sid)
+{
+    const struct oob_probe=
_parameter param =3D {
+        =2Etimestamp =3D (uint64_t)now,
+        =
=2Eflags =3D 0,
+    };
+    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 =
<< P_OPCODE_SHIFT);
+    return buf_write_u8(buf, header) && session_id_wri=
te(client_sid, buf)
+           && oob_server_probe_write(buf, &param);
+}
=
+
+/* Open a UDP socket for probing=2E Prefer a dual-stack IPv6 socket (so =
a single
+ * socket reaches both IPv6 and IPv4-mapped remotes, matching Ope=
nVPN's default
+ * IPV6_V6ONLY=3D0 behaviour); fall back to IPv4 if IPv6 is=
 unavailable=2E *af is
+ * set to the socket's address family=2E */
+static=
 socket_descriptor_t
+oob_probe_socket_open(sa_family_t *af)
+{
+    socket=
_descriptor_t sd =3D socket(AF_INET6, SOCK_DGRAM, IPPROTO_UDP);
+    if (sd=
 !=3D SOCKET_UNDEFINED)
+    {
+        set_cloexec(sd);
+        int off =
=3D 0;
+        if (setsockopt(sd, IPPROTO_IPV6, IPV6_V6ONLY, (void *)&off,=
 sizeof(off)) !=3D 0)
+        {
+            /* Not fatal: on a v6-only st=
ack we simply cannot reach v4 remotes=2E */
+            msg(D_LOW, "server=
-probe: could not enable dual-stack on probe socket");
+        }
+        =
*af =3D AF_INET6;
+        return sd;
+    }
+
+    /* No IPv6 available: f=
all back to an IPv4-only probe socket=2E */
+    sd =3D socket(AF_INET, SOC=
K_DGRAM, IPPROTO_UDP);
+    if (sd !=3D SOCKET_UNDEFINED)
+    {
+        s=
et_cloexec(sd);
+        *af =3D AF_INET;
+    }
+    return sd;
+}
+
+/* F=
ill @p dst from a resolved address, converting IPv4 to an IPv4-mapped IPv6
=
+ * address when we are sending through a dual-stack v6 socket=2E Returns t=
he
+ * address length, or 0 if the address cannot be reached by this socket=
=2E */
+static socklen_t
+oob_probe_make_dest(const struct addrinfo *ai, sa=
_family_t sock_af, struct sockaddr_storage *dst)
+{
+    memset(dst, 0, siz=
eof(*dst));
+
+    if (ai->ai_family =3D=3D sock_af)
+    {
+        memcpy=
(dst, ai->ai_addr, ai->ai_addrlen);
+        return (socklen_t)ai->ai_addrl=
en;
+    }
+
+    if (sock_af =3D=3D AF_INET6 && ai->ai_family =3D=3D AF_IN=
ET)
+    {
+        /* IPv4 -> IPv4-mapped IPv6 (::ffff:a=2Eb=2Ec=2Ed) for =
the dual-stack socket=2E */
+        const struct sockaddr_in *s4 =3D (cons=
t struct sockaddr_in *)(const void *)ai->ai_addr;
+        struct sockaddr_=
in6 *s6 =3D (struct sockaddr_in6 *)dst;
+        s6->sin6_family =3D AF_INE=
T6;
+        s6->sin6_port =3D s4->sin_port;
+        s6->sin6_addr=2Es6_ad=
dr[10] =3D 0xff;
+        s6->sin6_addr=2Es6_addr[11] =3D 0xff;
+        me=
mcpy(&s6->sin6_addr=2Es6_addr[12], &s4->sin_addr, 4);
+        return sizeo=
f(struct sockaddr_in6);
+    }
+
+    /* e=2Eg=2E an IPv6 remote reached on=
ly via a v4-only fallback socket */
+    return 0;
+}
+
+/* Parse one recei=
ved datagram as a PROBE_REPLY and, if valid and matching one
+ * of the pro=
bes we sent, record the reply in @p results=2E */
+static void
+oob_probe_h=
andle_reply(const uint8_t *data, int len, const struct session_id *client_s=
id,
+                       const struct sockaddr_storage *from, const stru=
ct probe_target *targets,
+                       struct oob_probe_result *=
results, int n)
+{
+    /* Need at least the opcode byte and the session id=
=2E */
+    if (len < 1 + (int)SID_SIZE || (data[0] >> P_OPCODE_SHIFT) !=3D=
 P_CONTROL_OOB_V1)
+    {
+        return;
+    }
+
+    struct buffer buf;=

+    buf_set_read(&buf, data, (size_t)len);
+    buf_advance(&buf, 1 + SID=
_SIZE); /* skip opcode + server session id */
+
+    struct oob_probe_reply=
 reply;
+    if (!oob_client_reply_read(&buf, &reply))
+    {
+        retu=
rn;
+    }
+
+    /* Reject spoofed replies: the reply must echo our probe'=
s session id=2E */
+    if (!session_id_equal(&reply=2Epeer_session_id, cli=
ent_sid))
+    {
+        return;
+    }
+
+    /* Match the reply's source=
 address to the remote we probed=2E */
+    for (int i =3D 0; i < n; i++)
+=
    {
+        if (targets[i]=2Esent
+            && addr_port_match((const=
 struct openvpn_sockaddr *)(const void *)from,
+                           =
    (const struct openvpn_sockaddr *)(const void *)&targets[i]=2Edest))
+  =
      {
+            results[i]=2Eresponded =3D true;
+            results[=
i]=2Epriority =3D reply=2Epriority;
+            results[i]=2Eweight =3D re=
ply=2Eweight;
+            results[i]=2Emax_latency_diff =3D reply=2Emax_la=
tency_diff;
+            break;
+        }
+    }
+}
+
+/* Count how many o=
f the probes we sent have been answered so far=2E */
+static int
+oob_count=
_answered(const struct probe_target *targets, const struct oob_probe_result=
 *results,
+                   int n)
+{
+    int answered =3D 0;
+    for =
(int i =3D 0; i < n; i++)
+    {
+        answered +=3D (targets[i]=2Esent =
&& results[i]=2Eresponded) ? 1 : 0;
+    }
+    return answered;
+}
+
+/* R=
eceive replies for one time slice (until @p deadline), recording each that
=
+ * matches a probe we sent=2E Returns true if every sent probe has been an=
swered=2E */
+static bool
+oob_probe_receive_slice(socket_descriptor_t sd, =
const struct timeval *deadline,
+                        const struct sessi=
on_id *client_sid, const struct probe_target *targets,
+                   =
     struct oob_probe_result *results, int n, int outstanding)
+{
+    whil=
e (true)
+    {
+        struct timeval tnow, timeout;
+        openvpn_get=
timeofday(&tnow, NULL);
+        timeout=2Etv_sec =3D deadline->tv_sec - tn=
ow=2Etv_sec;
+        timeout=2Etv_usec =3D deadline->tv_usec - tnow=2Etv_u=
sec;
+        if (timeout=2Etv_usec < 0)
+        {
+            timeout=2E=
tv_sec -=3D 1;
+            timeout=2Etv_usec +=3D 1000000;
+        }
+   =
     if (timeout=2Etv_sec < 0)
+        {
+            return false; /* sli=
ce elapsed */
+        }
+
+        fd_set readfds;
+        FD_ZERO(&readf=
ds);
+        openvpn_fd_set(sd, &readfds);
+        if (openvpn_select((in=
t)sd + 1, &readfds, NULL, NULL, &timeout) <=3D 0)
+        {
+            r=
eturn false; /* slice timed out, or error */
+        }
+
+        uint8_t =
data[256];
+        struct sockaddr_storage from;
+        socklen_t fromle=
n =3D sizeof(from);
+        int len =3D (int)recvfrom(sd, (char *)data, (i=
nt)sizeof(data), 0,
+                                (struct sockaddr *)&fr=
om, &fromlen);
+        if (len > 0)
+        {
+            oob_probe_hand=
le_reply(data, len, client_sid, &from, targets, results, n);
+            i=
f (oob_count_answered(targets, results, n) >=3D outstanding)
+            {=

+                return true; /* every probe we sent has been answered */
=
+            }
+        }
+    }
+}
+
+/* Resend the probe to every remote =
that we probed but that has not answered=2E */
+static void
+oob_probe_rese=
nd_unanswered(socket_descriptor_t sd, const struct buffer *probe,
+        =
                    const struct probe_target *targets,
+                  =
          const struct oob_probe_result *results, int n)
+{
+    for (int i=
 =3D 0; i < n; i++)
+    {
+        if (targets[i]=2Esent && !results[i]=2E=
responded)
+        {
+            sendto(sd, (const char *)BPTR(probe), (i=
nt)BLEN(probe), 0,
+                   (const struct sockaddr *)&targets[i]=
=2Edest, targets[i]=2Edestlen);
+        }
+    }
+}
+
+/* Collect replies =
over the probe window, resending unanswered probes up to
+ * OOB_PROBE_RETR=
IES times (UDP is lossy and a probe carries no retransmission
+ * of its ow=
n)=2E The window is split into equal slices, one per send round; after
+ * =
each slice but the last we resend to whoever has not answered yet=2E Return=
s
+ * once the window elapses or every sent probe has been answered=2E */
+=
static void
+oob_probe_collect(socket_descriptor_t sd, const struct buffer =
*probe,
+                  const struct session_id *client_sid, const struc=
t probe_target *targets,
+                  struct oob_probe_result *result=
s, int n)
+{
+    /* number of probes we actually sent: stop early once the=
y all answer */
+    int want =3D 0;
+    for (int i =3D 0; i < n; i++)
+  =
  {
+        want +=3D targets[i]=2Esent ? 1 : 0;
+    }
+
+    const int s=
lices =3D 1 + OOB_PROBE_RETRIES;
+    const long slice_ms =3D OOB_PROBE_WIN=
DOW_MS / slices;
+
+    for (int slice =3D 0; slice < slices; slice++)
+   =
 {
+        struct timeval deadline;
+        openvpn_gettimeofday(&deadlin=
e, NULL);
+        deadline=2Etv_sec +=3D slice_ms / 1000;
+        deadlin=
e=2Etv_usec +=3D (slice_ms % 1000) * 1000;
+        if (deadline=2Etv_usec =
>=3D 1000000)
+        {
+            deadline=2Etv_sec +=3D 1;
+          =
  deadline=2Etv_usec -=3D 1000000;
+        }
+
+        if (oob_probe_rece=
ive_slice(sd, &deadline, client_sid, targets, results, n, want))
+        {=

+            return; /* all answered */
+        }
+
+        if (slice + =
1 < slices)
+        {
+            oob_probe_resend_unanswered(sd, probe, =
targets, results, n);
+        }
+    }
+}
+
+/* Permute the connection lis=
t so entries appear in @p ranked order=2E */
+static void
+oob_apply_order(=
struct connection_list *l, const struct oob_probe_result *ranked,
+        =
        struct gc_arena *gc)
+{
+    struct connection_entry **reordered =
=3D gc_malloc(sizeof(*reordered) * l->len, false, gc);
+    for (int i =3D =
0; i < l->len; i++)
+    {
+        reordered[i] =3D l->array[ranked[i]=2Ei=
ndex];
+    }
+    memcpy(l->array, reordered, sizeof(*l->array) * l->len);=

+}
+
+void
+client_probe_and_order_remotes(struct context *c)
+{
+    /* P=
robe only once, before the first connection attempt=2E */
+    if (!c->opti=
ons=2Eserver_probe || !c->first_time)
+    {
+        return;
+    }
+
+   =
 struct connection_list *l =3D c->options=2Econnection_list;
+    if (!l ||=
 l->len <=3D 1)
+    {
+        return; /* nothing to choose between */
+  =
  }
+
+    struct gc_arena gc =3D gc_new();
+
+    /* A single random sessi=
on id identifies all of our probes; servers echo it
+     * back in the rep=
ly's peer_session_id, letting us reject spoofed replies=2E */
+    struct s=
ession_id client_sid;
+    session_id_random(&client_sid);
+
+    sa_family=
_t sock_af =3D AF_UNSPEC;
+    socket_descriptor_t sd =3D oob_probe_socket_=
open(&sock_af);
+    if (sd =3D=3D SOCKET_UNDEFINED)
+    {
+        msg(D_=
LOW, "server-probe: could not open probe socket; using configured order");
=
+        gc_free(&gc);
+        return;
+    }
+
+    struct probe_target *=
targets =3D gc_malloc(sizeof(*targets) * l->len, true, &gc);
+    struct oo=
b_probe_result *results =3D gc_malloc(sizeof(*results) * l->len, true, &gc)=
;
+
+    struct buffer probe =3D alloc_buf_gc(256, &gc);
+    if (!oob_prob=
e_build_packet(&probe, &client_sid))
+    {
+        msg(D_LOW, "server-pro=
be: could not build probe packet; using configured order");
+        openvp=
n_close_socket(sd);
+        gc_free(&gc);
+        return;
+    }
+
+    m=
sg(D_LOW, "server-probe: probing %d remote(s) with a %d ms window", l->len,=

+        OOB_PROBE_WINDOW_MS);
+
+    /* Send a probe to each configured r=
emote=2E */
+    int sent_count =3D 0;
+    for (int i =3D 0; i < l->len; i=
++)
+    {
+        results[i]=2Eindex =3D i;
+        results[i]=2Erespond=
ed =3D false;
+
+        const struct connection_entry *ce =3D l->array[i];=

+        if (!ce->remote)
+        {
+            continue; /* nothing to =
probe (e=2Eg=2E a connection block with no --remote) */
+        }
+       =
 if (!proto_is_udp(ce->proto))
+        {
+            msg(D_LOW, "server-p=
robe: %s:%s: skipping (not a UDP remote)", ce->remote,
+                ce-=
>remote_port);
+            continue;
+        }
+
+        struct addrinfo=
 *ai =3D NULL;
+        int status =3D openvpn_getaddrinfo(GETADDR_RESOLVE =
| GETADDR_TRY_ONCE | GETADDR_DATAGRAM,
+                                   =
      ce->remote, ce->remote_port, 0, NULL, AF_UNSPEC, &ai);
+        if (s=
tatus !=3D 0 || !ai)
+        {
+            msg(D_LOW, "server-probe: %s:%=
s: could not resolve", ce->remote, ce->remote_port);
+            continue;=

+        }
+
+        socklen_t destlen =3D oob_probe_make_dest(ai, sock_a=
f, &targets[i]=2Edest);
+        if (destlen =3D=3D 0)
+        {
+        =
    msg(D_LOW, "server-probe: %s:%s: not reachable by the probe socket", ce=
->remote,
+                ce->remote_port);
+        }
+        else if (s=
endto(sd, (const char *)BPTR(&probe), (int)BLEN(&probe), 0,
+              =
          (struct sockaddr *)&targets[i]=2Edest, destlen)
+                =
 < 0)
+        {
+            msg(D_LOW, "server-probe: %s:%s: probe send f=
ailed", ce->remote, ce->remote_port);
+        }
+        else
+        {
+=
            targets[i]=2Edestlen =3D destlen;
+            targets[i]=2Esen=
t =3D true;
+            sent_count++;
+        }
+        freeaddrinfo(ai)=
;
+    }
+
+    if (sent_count > 0)
+    {
+        oob_probe_collect(sd, &=
probe, &client_sid, targets, results, l->len);
+    }
+    openvpn_close_so=
cket(sd);
+
+    /* Log each remote's outcome while results[i] still maps t=
o array[i]=2E */
+    int responded =3D 0;
+    for (int i =3D 0; i < l->le=
n; i++)
+    {
+        const struct connection_entry *ce =3D l->array[i];
=
+        if (results[i]=2Eresponded)
+        {
+            responded++;
+=
            msg(D_LOW, "server-probe: %s:%s answered (priority %d, weight %=
d)", ce->remote,
+                ce->remote_port, results[i]=2Epriority, r=
esults[i]=2Eweight);
+        }
+        else
+        {
+            msg(D=
_LOW, "server-probe: %s:%s did not answer", ce->remote, ce->remote_port);
+=
        }
+    }
+
+    /* Rank best-first and reorder the connection list =
accordingly=2E */
+    oob_rank_probe_results(results, l->len, c->options=
=2Eserver_probe_latency_margin, get_random, &gc);
+    oob_apply_order(l, r=
esults, &gc);
+
+    msg(D_LOW, "server-probe: connecting in this order:");=

+    for (int i =3D 0; i < l->len; i++)
+    {
+        msg(D_LOW, "server=
-probe:   %d=2E %s:%s", i + 1, l->array[i]->remote,
+            l->array[i=
]->remote_port);
+    }
+
+    msg(M_INFO, "server-probe: %d of %d remote(s=
) answered; connecting best-first", responded,
+        l->len);
+
+    gc_=
free(&gc);
+}
diff --git a/src/openvpn/oob_client=2Eh b/src/openvpn/oob_cli=
ent=2Eh
new file mode 100644
index 0000000=2E=2Eac44cdb
--- /dev/null
+++ b=
/src/openvpn/oob_client=2Eh
@@ -0,0 +1,44 @@
+/*
+ *  OpenVPN -- An applica=
tion to securely tunnel IP networks
+ *             over a single TCP/UDP p=
ort, with support for SSL/TLS-based
+ *             session authentication =
and key exchange,
+ *             packet encryption, packet authentication,=
 and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026=
 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; =
you can redistribute it and/or modify
+ *  it under the terms of the GNU Ge=
neral Public License version 2
+ *  as published by the Free Software Found=
ation=2E
+ *
+ *  This program is distributed in the hope that it will be u=
seful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
=
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  G=
NU General Public License for more details=2E
+ *
+ *  You should have rece=
ived a copy of the GNU General Public License along
+ *  with this program;=
 if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+=
 * Client-side server-probe phase: before connecting, optionally probe all
=
+ * configured remotes with an out-of-band SERVER_PROBE and order them
+ * =
best-first, so the connection loop tries the most suitable server first=2E
=
+ */
+
+#ifndef OOB_CLIENT_H
+#define OOB_CLIENT_H
+
+struct context;
+
+/*=
*
+ * Probe all configured remotes and reorder the connection list best-fir=
st=2E
+ *
+ * Does nothing unless --server-probe is enabled=2E On any failu=
re (or if no
+ * server answers), the configured remote order is left uncha=
nged and the
+ * normal connection sequence proceeds=2E
+ */
+void client_p=
robe_and_order_remotes(struct context *c);
+
+#endif /* OOB_CLIENT_H */
dif=
f --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index f414024=
=2E=2Ed54e3ab 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/option=
s=2Ec
@@ -803,6 +803,11 @@
     o->topology =3D TOP_UNDEF;
     o->ce=2Epro=
to =3D PROTO_UDP;
     o->ce=2Eaf =3D AF_UNSPEC;
+
+    /* The client laten=
cy margin is -1 =3D "not set": the client's value is
+     * authoritative =
when given, otherwise each server's advertised margin (or
+     * the built=
-in default) applies=2E */
+    o->server_probe_latency_margin =3D -1;
    =
 o->ce=2Ebind_ipv6_only =3D false;
     o->ce=2Econnect_retry_seconds =3D 1=
;
     o->ce=2Econnect_retry_seconds_max =3D 300;
@@ -6506,6 +6511,21 @@
  =
       VERIFY_PERMISSION(OPT_P_GENERAL);
         options->mtu_test =3D tru=
e;
     }
+    else if (streq(p[0], "server-probe") && !p[2])
+    {
+     =
   VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->server_probe =3D tru=
e;
+        if (p[1])
+        {
+            int margin =3D positive_atoi(=
p[1], msglevel);
+            if (margin > 0xffff)
+            {
+        =
        msg(msglevel, "--server-probe: max-latency-diff must be 0 to 65535 =
ms");
+                goto err;
+            }
+            options->serve=
r_probe_latency_margin =3D margin;
+        }
+    }
     else if (streq(p[=
0], "nice") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE)=
;
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index a111=
cf8=2E=2E6b1120a 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/opt=
ions=2Eh
@@ -335,6 +335,11 @@
 
     bool mtu_test;
 
+    bool server_prob=
e; /* client: probe remotes (--server-probe) and connect best-first */
+   =
 /* client: default candidate-band margin in ms (--server-probe [max-latenc=
y-diff]):
+     * servers within this RTT of the fastest are treated as equ=
ally fast */
+    int server_probe_latency_margin;
+
     bool mlock;
 
   =
  int keepalive_ping; /* a proxy for ping/ping-restart */

-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3=
c06f2
Gerrit-Change-Number: 1747
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <ls=
tipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--w6p5e6lh/wg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oo=
b: Add --server-probe to order client remotes by probe<br><br>With --server=
-probe, before connecting a client sends an out-of-band<br>SERVER_PROBE to =
all configured UDP remotes, collects the PROBE_REPLYs within a<br>short win=
dow, and reorders the connection list so the best-responding server is<br>t=
ried first=2E The option is off by default=2E<br><br>The probe phase is sel=
f-contained in oob_client=2Ec behind a single call from<br>init=2Ec (before=
 next_connection_entry())=2E It uses one dual-stack UDP socket<br>(IPV6_V6O=
NLY off, IPv4 remotes sent as IPv4-mapped, with an IPv4-only socket<br>fall=
back) to fan probes out and collect replies, matches each reply to its<br>r=
emote by source address, and rejects spoofed replies via the session id the=
<br>server echoes back=2E Ranking and reordering use oob_rank_probe_results=
()=2E<br><br>Per-remote outcomes (skips, resolve/send failures, which serve=
rs answered with<br>their priority/weight, and the final connection order) =
are logged at verb 4<br>(D_LOW); a one-line summary of how many remotes ans=
wered stays at M_INFO=2E<br><br>Because the probe is pre-connection and ses=
sion-less, replies are handled in<br>this dedicated loop and never reach tl=
s_pre_decrypt(), so P_LAST_OPCODE is not<br>widened=2E<br><br>First-cut lim=
itations: the probe is sent unwrapped, so it currently works only<br>agains=
t a server without tls-auth/tls-crypt (control-channel wrapping is a<br>fol=
low-up); only UDP remotes are probed; probing runs once before the first<br=
>connection=2E<br><br>Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2<=
br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M CMakeL=
ists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>M src/openvpn/init=2Ec<br>A sr=
c/openvpn/oob_client=2Ec<br>A src/openvpn/oob_client=2Eh<br>M src/openvpn/o=
ptions=2Ec<br>M src/openvpn/options=2Eh<br>7 files changed, 528 insertions(=
+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/47/1747/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLis=
ts=2Etxt b/CMakeLists=2Etxt</span><br><span>index 608e39e4=2E=2E16b3aae 100=
644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -520,6 +520,8 @@</span><br><span>     src/openvpn=
/occ=2Eh</span><br><span>     src/openvpn/oob=2Ec</span><br><span>     src/=
openvpn/oob=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
src/openvpn/oob_client=2Ec</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    src/openvpn/oob_client=2Eh</span><br><span>     src/openvpn/open=
vpn=2Ec</span><br><span>     src/openvpn/openvpn=2Eh</span><br><span>     s=
rc/openvpn/openvpn_win32_resources=2Erc</span><br><span>diff --git a/src/op=
envpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index b4b1b=
92=2E=2E78abfa8 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</spa=
n><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -107,6 +107,=
7 @@</span><br><span> 	pkcs11_openssl=2Ec \</span><br><span> 	pkcs11_mbedtl=
s=2Ec \</span><br><span> 	oob=2Ec oob=2Eh \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	oob_client=2Ec oob_client=2Eh \</span><br><span> 	=
openvpn=2Ec openvpn=2Eh \</span><br><span> 	options=2Ec options=2Eh \</span=
><br><span> 	options_util=2Ec options_util=2Eh \</span><br><span>diff --git=
 a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index caaa76=
9=2E=2E274c86a 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br>=
<span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -48,6 +48,7 @@</span><b=
r><span> #include &quot;ssl_ncp=2Eh&quot;</span><br><span> #include &quot;t=
ls_crypt=2Eh&quot;</span><br><span> #include &quot;forward=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob_client=
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
><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E43aee8d<=
/span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob_client=
=2Ec</span><br><span>@@ -0,0 +1,451 @@</span><br><span style=3D"color: hsl(=
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
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Build a plai=
ntext SERVER_PROBE packet:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *   [opcode | key_id=3D0] [client session id] [SERVER_PROBE message=
]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This is the una=
uthenticated OOB wire format; adding tls-auth/tls-crypt</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * wrapping for the probe is a follow-u=
p (it only works against a server with</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * no control-channel wrapping for now)=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+oob_probe_build_packet(struct buffer *=
buf, const struct session_id *client_sid)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const struct oob_probe_parameter param =3D {</span><br><span style=
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
120, 100%, 40%);">+/* Open a UDP socket for probing=2E Prefer a dual-stack =
IPv6 socket (so a single</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * socket reaches both IPv6 and IPv4-mapped remotes, matching OpenVPN&=
#39;s default</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * IPV=
6_V6ONLY=3D0 behaviour); fall back to IPv4 if IPv6 is unavailable=2E *af is=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * set to the socke=
t&#39;s address family=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static socket_descriptor_t</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+oob_probe_socket_open(sa_family_t *af)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    socket_descriptor_t sd =3D socket(AF_INET6, SOCK_DGRAM=
, IPPROTO_UDP);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (sd !=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    set_cloexec(sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        int off =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (setsockopt(sd, IPPROTO_IPV6, IPV6_V6ONLY, (void *)&amp;off,=
 sizeof(off)) !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    /* Not fatal: on a v6-only stack we simply cannot reach v4 remotes=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_=
LOW, &quot;server-probe: could not enable dual-stack on probe socket&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        *af =3D AF_INET6;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return sd;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* No IPv6 available: fall back to an IPv4-only prob=
e socket=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
d =3D socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (sd !=3D SOCKET_UNDEFINED)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        set_cloexec(sd);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        *af =3D AF_INET;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return sd;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Fill @p dst fr=
om a resolved address, converting IPv4 to an IPv4-mapped IPv6</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * address when we are sending th=
rough a dual-stack v6 socket=2E Returns the</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * address length, or 0 if the address cannot be re=
ached by this socket=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static socklen_t</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+oob_probe_make_dest(const struct addrinfo *ai, sa_family_t sock_af, str=
uct sockaddr_storage *dst)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memset(=
dst, 0, sizeof(*dst));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ai-&gt;a=
i_family =3D=3D sock_af)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
emcpy(dst, ai-&gt;ai_addr, ai-&gt;ai_addrlen);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return (socklen_t)ai-&gt;ai_addrlen;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (sock_af =3D=3D AF_INET6 &amp;&amp; ai-&gt;ai_fam=
ily =3D=3D AF_INET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* IPv=
4 -&gt; IPv4-mapped IPv6 (::ffff:a=2Eb=2Ec=2Ed) for the dual-stack socket=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const=
 struct sockaddr_in *s4 =3D (const struct sockaddr_in *)(const void *)ai-&g=
t;ai_addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
truct sockaddr_in6 *s6 =3D (struct sockaddr_in6 *)dst;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        s6-&gt;sin6_family =3D AF_INET6;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s6-&gt;sin6=
_port =3D s4-&gt;sin_port;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        s6-&gt;sin6_addr=2Es6_addr[10] =3D 0xff;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        s6-&gt;sin6_addr=2Es6_addr[11] =
=3D 0xff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        me=
mcpy(&amp;s6-&gt;sin6_addr=2Es6_addr[12], &amp;s4-&gt;sin_addr, 4);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return sizeof(struc=
t sockaddr_in6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* e=2Eg=2E an IPv6 remote reach=
ed only via a v4-only fallback socket */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Parse one received =
datagram as a PROBE_REPLY and, if valid and matching one</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * of the probes we sent, record the r=
eply in @p results=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob=
_probe_handle_reply(const uint8_t *data, int len, const struct session_id *=
client_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
               const struct sockaddr_storage *from, const struct probe_targ=
et *targets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                struct oob_probe_result *results, int n)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* Need at least the opcode byte and the session id=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len &=
lt; 1 + (int)SID_SIZE || (data[0] &gt;&gt; P_OPCODE_SHIFT) !=3D P_CONTROL_O=
OB_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct buffer buf;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    buf_set_read(&amp;buf, data, (size_t)len);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    buf_advance(&amp;buf, 1 + SID_=
SIZE); /* skip opcode + server session id */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct oob_probe_reply reply;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!oob_client_reply_read(&amp;buf, &amp;reply))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* Reject spoofed replies: the reply must echo our probe&#39;s sessi=
on id=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!session_id_equal(&amp;reply=2Epeer_session_id, client_sid))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Mat=
ch the reply&#39;s source address to the remote we probed=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; n;=
 i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (targets[i]=2Esen=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&=
amp; addr_port_match((const struct openvpn_sockaddr *)(const void *)from,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
          (const struct openvpn_sockaddr *)(const void *)&amp;targets[i]=2E=
dest))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            results[i]=
=2Eresponded =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            results[i]=2Epriority =3D reply=2Epriority;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            results[i]=2Eweight =3D =
reply=2Eweight;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        results[i]=2Emax_latency_diff =3D reply=2Emax_latency_diff;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Count how m=
any of the probes we sent have been answered so far=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+oob_count_answered(const struct probe_target *=
targets, const struct oob_probe_result *results,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                   int n)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int answered =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    for (int i =3D 0; i &lt; n; i++)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        answered +=3D (targets[i]=2Esent &amp;&amp;=
 results[i]=2Eresponded) ? 1 : 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return answered;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* Receive replies for one time slic=
e (until @p deadline), recording each that</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * matches a probe we sent=2E Returns true if every =
sent probe has been answered=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+oob_probe_receive_slice(socket_descriptor_t sd, const struct timeval=
 *deadline,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                const struct session_id *client_sid, const struct probe_tar=
get *targets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                  struct oob_probe_result *results, int n, int outstanding)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    while (true)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        struct timeval tnow, timeout;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        openvpn_gettimeofday(&amp;tn=
ow, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t=
imeout=2Etv_sec =3D deadline-&gt;tv_sec - tnow=2Etv_sec;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        timeout=2Etv_usec =3D deadline=
-&gt;tv_usec - tnow=2Etv_usec;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (timeout=2Etv_usec &lt; 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            timeout=2Etv_sec -=3D 1;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            timeout=2Etv_usec +=3D 1000=
000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (timeout=2Etv_=
sec &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return=
 false; /* slice elapsed */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fd_set readfd=
s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        FD_ZERO(&=
amp;readfds);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  openvpn_fd_set(sd, &amp;readfds);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (openvpn_select((int)sd + 1, &amp;readfds, NULL,=
 NULL, &amp;timeout) &lt;=3D 0)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            return false; /* slice timed out, or error */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        uint8_t data[256];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        struct sockaddr_storage from;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        socklen_t fromlen =3D sizeof(fr=
om);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int len=
 =3D (int)recvfrom(sd, (char *)data, (int)sizeof(data), 0,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                (str=
uct sockaddr *)&amp;from, &amp;fromlen);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (len &gt; 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            oob_probe_handle_reply(data, len, client_sid, &a=
mp;from, targets, results, n);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (oob_count_answered(targets, results, n) &gt;=3D =
outstanding)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   return true; /* every probe we sent has been answered */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* Resend the probe to ever=
y remote that we probed but that has not answered=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+oob_probe_resend_unanswered(socket_descriptor_t=
 sd, const struct buffer *probe,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                            const struct probe_target *targets=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
          const struct oob_probe_result *results, int n)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (int i =3D 0; i &lt; n; i++)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (targets[i]=2Esent &amp;&amp; !results[i]=
=2Eresponded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            send=
to(sd, (const char *)BPTR(probe), (int)BLEN(probe), 0,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                   (const struct sockadd=
r *)&amp;targets[i]=2Edest, targets[i]=2Edestlen);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* Collect replies over the pr=
obe window, resending unanswered probes up to</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * OOB_PROBE_RETRIES times (UDP is lossy and a pr=
obe carries no retransmission</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * of its own)=2E The window is split into equal slices, one per =
send round; after</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 each slice but the last we resend to whoever has not answered yet=2E Retur=
ns</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * once the windo=
w elapses or every sent probe has been answered=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+oob_probe_collect(socket_descriptor_t sd, const s=
truct buffer *probe,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                  const struct session_id *client_sid, const struct probe_=
target *targets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
               struct oob_probe_result *results, int n)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* number of probes we actually sent: stop early once=
 they all answer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int want =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    for (int i =3D 0; i &lt; n; i++)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        want +=3D targets[i]=2Esent ? 1 : 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst int slices =3D 1 + OOB_PROBE_RETRIES;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const long slice_ms =3D OOB_PROBE_WINDOW_MS / sl=
ices;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    for (int slice =3D 0; slice &=
lt; slices; slice++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struc=
t timeval deadline;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        openvpn_gettimeofday(&amp;deadline, NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        deadline=2Etv_sec +=3D slice_ms / 10=
00;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        deadline=
=2Etv_usec +=3D (slice_ms % 1000) * 1000;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (deadline=2Etv_usec &gt;=3D 1000000)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            deadline=2Etv_sec +=3D =
1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            deadl=
ine=2Etv_usec -=3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (oob_probe=
_receive_slice(sd, &amp;deadline, client_sid, targets, results, n, want))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            return; /* all answ=
ered */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (slice + 1 &lt; slices)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            oob_probe_resend_unanswe=
red(sd, probe, targets, results, n);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* Permute the connection list so entries ap=
pear in @p ranked order=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+oob_apply_order(struct connection_list *l, const struct oob_probe_result =
*ranked,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct c=
onnection_entry **reordered =3D gc_malloc(sizeof(*reordered) * l-&gt;len, f=
alse, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (=
int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        reordered[i] =3D l-&gt;array[ranked[i]=2Eindex];</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    memcpy(l-&gt;array, reordered, sizeof(*l-&gt;a=
rray) * l-&gt;len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+client_probe_and_order_remotes(struct context *c)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* Probe only once, before the first=
 connection attempt=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!c-&gt;options=2Eserver_probe || !c-&gt;first_time)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct connection_list *l =3D c-&gt;options=2Econnection_list;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!l || l-&gt;len &lt;=3D=
 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return; /* nothing to =
choose between */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* A single random session id ide=
ntifies all of our probes; servers echo it</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * back in the reply&#39;s peer_session_id, lett=
ing us reject spoofed replies=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct session_id client_sid;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    session_id_random(&amp;client_sid);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    sa_family_t sock_af =3D AF_UNSPEC;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    socket_descriptor_t s=
d =3D oob_probe_socket_open(&amp;sock_af);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (sd =3D=3D SOCKET_UNDEFINED)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server-probe: could not o=
pen probe socket; using configured order&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct probe_target *targets =3D gc_malloc(sizeof(*targets) * l-&gt;len, =
true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct oob_probe_result *results =3D gc_malloc(sizeof(*results) * l-&gt;len=
, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer pro=
be =3D alloc_buf_gc(256, &amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!oob_probe_build_packet(&amp;probe, &amp;client_sid)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server-=
probe: could not build probe packet; using configured order&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        openvpn_close_socke=
t(sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;server-probe: probing %=
d remote(s) with a %d ms window&quot;, l-&gt;len,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        OOB_PROBE_WINDOW_MS);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Send a probe to each configured remote=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int sent_count =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =
=3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    results[i]=2Eindex =3D i;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        results[i]=2Eresponded =3D false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const struct connection_entry *ce =3D l-&gt;array[i]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ce-&g=
t;remote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue=
; /* nothing to probe (e=2Eg=2E a connection block with no --remote) */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (!proto_is_udp(ce-&gt;=
proto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW,=
 &quot;server-probe: %s:%s: skipping (not a UDP remote)&quot;, ce-&gt;remot=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                c=
e-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        struct addrinfo *ai=
 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
nt status =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_TRY_ONCE | GETA=
DDR_DATAGRAM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                   ce-&gt;remote, ce-&gt;remote_port, 0, NU=
LL, AF_UNSPEC, &amp;ai);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (status !=3D 0 || !ai)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s: could not resolv=
e&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            continue;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      socklen_t destlen =3D oob_probe_make_dest(ai, sock_af, &amp;targets[i=
]=2Edest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (destlen =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(D_LOW, &quot;server-probe: %s:%s: not reachable by the probe socket&=
quot;, ce-&gt;remote,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                ce-&gt;remote_port);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        else if (sendto(sd, (const char *)BPTR(&amp;probe), (int)B=
LEN(&amp;probe), 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        (struct sockaddr *)&amp;targets[i]=2Edest, destlen)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 &l=
t; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &=
quot;server-probe: %s:%s: probe send failed&quot;, ce-&gt;remote, ce-&gt;re=
mote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            targets[i]=2Edestlen =
=3D destlen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     targets[i]=2Esent =3D true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            sent_count++;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        freeaddrinfo(ai);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sent_count=
 &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_collect=
(sd, &amp;probe, &amp;client_sid, targets, results, l-&gt;len);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    openvpn_close_socket(sd);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Log each remote&#39;s outcome while results[i] =
still maps to array[i]=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int responded =3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        const struct connection_entry *ce =3D l-&g=
t;array[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (results[i]=2Eresponded)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          responded++;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(D_LOW, &quot;server-probe: %s:%s answered (priority %d, =
weight %d)&quot;, ce-&gt;remote,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                ce-&gt;remote_port, results[i]=2Epriority, res=
ults[i]=2Eweight);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot=
;server-probe: %s:%s did not answer&quot;, ce-&gt;remote, ce-&gt;remote_por=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* Rank best-first and reorder the connection list acco=
rdingly=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oo=
b_rank_probe_results(results, l-&gt;len, c-&gt;options=2Eserver_probe_laten=
cy_margin, get_random, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    oob_apply_order(l, results, &amp;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    msg(D_LOW, &quot;server-probe: connecting in this order=
:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i=
nt i =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        msg(D_LOW, &quot;server-probe:   %d=2E %s:%s&quot;, i + 1, l-&gt;a=
rray[i]-&gt;remote,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            l-&gt;array[i]-&gt;remote_port);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(=
M_INFO, &quot;server-probe: %d of %d remote(s) answered; connecting best-fi=
rst&quot;, responded,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        l-&gt;len);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an>diff --git a/src/openvpn/oob_client=2Eh b/src/openvpn/oob_client=2Eh</sp=
an><br><span>new file mode 100644</span><br><span>index 0000000=2E=2Eac44cd=
b</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob_clien=
t=2Eh</span><br><span>@@ -0,0 +1,44 @@</span><br><span style=3D"color: hsl(=
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
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Client-side server-probe phase: before connecting, optionally pro=
be all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * configured=
 remotes with an out-of-band SERVER_PROBE and order them</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * best-first, so the connection loop =
tries the most suitable server first=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef OOB_CLI=
ENT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_CL=
IENT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+struct context;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Probe all configured remotes and reorder the connection list best-fi=
rst=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Does nothing unless --serve=
r-probe is enabled=2E On any failure (or if no</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * server answers), the configured remote order =
is left unchanged and the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * normal connection sequence proceeds=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void client_probe_and_order_remotes(struct context *c);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif /* OOB_CLIENT_H */</span><br><span>diff=
 --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>=
index f414024=2E=2Ed54e3ab 100644</span><br><span>--- a/src/openvpn/options=
=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -803,=
6 +803,11 @@</span><br><span>     o-&gt;topology =3D TOP_UNDEF;</span><br><=
span>     o-&gt;ce=2Eproto =3D PROTO_UDP;</span><br><span>     o-&gt;ce=2Ea=
f =3D AF_UNSPEC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The client late=
ncy margin is -1 =3D &quot;not set&quot;: the client&#39;s value is</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * authoritative when g=
iven, otherwise each server&#39;s advertised margin (or</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * the built-in default) applies=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server=
_probe_latency_margin =3D -1;</span><br><span>     o-&gt;ce=2Ebind_ipv6_onl=
y =3D false;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds =3D 1;</=
span><br><span>     o-&gt;ce=2Econnect_retry_seconds_max =3D 300;</span><br=
><span>@@ -6506,6 +6511,21 @@</span><br><span>         VERIFY_PERMISSION(OP=
T_P_GENERAL);</span><br><span>         options-&gt;mtu_test =3D true;</span=
><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else if (streq(p[0], &quot;server-probe&quot;) &amp;&amp; !p[2])</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt=
;server_probe =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (p[1])</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    int margin =3D positive_atoi(p[1], msglevel);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (margin &gt; 0xffff)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot=
;--server-probe: max-latency-diff must be 0 to 65535 ms&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                goto err;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;server_=
probe_latency_margin =3D margin;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span>     else if (streq(p[0], &quot;nice&quot;) &amp;&=
amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>        =
 VERIFY_PERMISSION(OPT_P_NICE);</span><br><span>diff --git a/src/openvpn/op=
tions=2Eh b/src/openvpn/options=2Eh</span><br><span>index a111cf8=2E=2E6b11=
20a 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>++=
+ b/src/openvpn/options=2Eh</span><br><span>@@ -335,6 +335,11 @@</span><br>=
<span> </span><br><span>     bool mtu_test;</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    bool server_probe; /* client:=
 probe remotes (--server-probe) and connect best-first */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* client: default candidate-band=
 margin in ms (--server-probe [max-latency-diff]):</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * servers within this RTT of the fastes=
t are treated as equally fast */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int server_probe_latency_margin;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     bool mlock;</span><br><=
span> </span><br><span>     int keepalive_ping; /* a proxy for ping/ping-re=
start */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">change 1747</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5a7e9e13b9=
f9548b7ff717daae2b4a9cde3c06f2 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1747 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>

</body></html>
--w6p5e6lh/wg=--


--===============2318009177187376320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2318009177187376320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2318009177187376320==--

