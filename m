Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F381C54F51
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CI9P11BJNDvsynyfD1yL7LgjnV0DeKNZUD/qrZAqtQc=; b=e9NunAX31KnByC8JGCz2T8dWZk
	fzVyfl6/emnrjKdwwF9I26AzWcbWrSIKprck76s3kg9Dy2E/3YueA+zIM2u3os9xiSEd/N6NWQ0Il
	uo1Hb1BSH9NRNlH/+PJ7kkjyFMRTYZ093SFrCED47K6MysITmZTX9h418/ZQuA5bGkVk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp3Jr-0001Hr-6F;
	Wed, 29 Jul 2026 12:23:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp3Jp-0001HV-BV
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TvrdGGdVAVP+brhcTBxuv4NqbNfdNEXejWG6QeTPles=; b=le3GeWwGdkJuwwNb6rWpHtltJk
 /NWdZHaZp0RqS5nfA0cgg9mTsXnw1wE4JF1iAKvSCq4oFk5CLTqarwqnBroM/k/HcDt82Z74fZGBg
 Kz5mzLwELqvBiAT9+rexCj2YvRUG62zSHpO/8LyT0GBM/xTtq12bMRKOjccy8lNI/DlU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TvrdGGdVAVP+brhcTBxuv4NqbNfdNEXejWG6QeTPles=; b=a
 ENuhJjs4i0GPw9+cHA1/HJ4NEmNyUYMFzY0YLGNJCPSkHoDX4HOJ3vIDnrsZ9RM4oi73gMN3aPiKW
 t5jUi6gmpo7cZZmNGeZi748ZNxbQVYR1Mk1Ep7fviUhdhSVkP3rEM1NjcInmhzBqINowcw2vIYHsH
 eIjKGdrvQ0kd7sK8=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp3Jn-0006ON-Am for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:30 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so1336796f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 05:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785327801; x=1785932601; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TvrdGGdVAVP+brhcTBxuv4NqbNfdNEXejWG6QeTPles=;
 b=Sk1IzIamdo9vRwR+VGv7OWXI3juGYl7YLEDExSJuKdpGQfWsStldUYJGHSHWb4gULC
 6QJ8SPAGSo6Fse8fWMmECpiL56J6MGnpSZ/YLhekXjhs4UYHsEqoBMEB+OeFIex08nt0
 JGxkqXcEMS7Mli7kSQkHWQTWUf9d1Qj95vL5G0d41DfGFjV1y+EJhCMMq3uXmlT7FmiP
 F7ec1VvDsOXNavSB5Dyd/Q3pXYWAfndfcY3q9Ea1/bTdTs5Rrm1pFS/0I7Hwey4SjoQ4
 xcb3ORqISd3IWTXEikS0UL4Er7bsWkejvmG510etP4NGY9186B82bGj/hh6IpkJEihZz
 Z54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327801; x=1785932601;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TvrdGGdVAVP+brhcTBxuv4NqbNfdNEXejWG6QeTPles=;
 b=dRz4fntk43oOvB6sIhDi7NlvYd1riaf1AFBMjUM1jyKXg6Cu0damEldgOh6jm1DrqN
 gZYC/ScT/AHKej/ux697r3hUHpmYZe6DdWLmSeUQ9AAy7qQsylHSFNiIWCTCJ9KYy/cD
 cSSquGCaD0fnff2BAUmiG+/fwY80R83Nt63POaIYWKUGBiIDVM8jLsqt9c4kdHORU6H7
 7ylfx5xvq7fCxp1KvksD/06sSjiGN9l3xICDXwVxGc2ci41AUH309O7bYCC2ddhvP8le
 PHaQdRL8DhiON8UxfquUrrKqsdXRT/e5GGgG7RT7YaLU1H/NXrDuJ9o7tapUgbo1rUu9
 80ZA==
X-Gm-Message-State: AOJu0YzyWUYLdK+9hb8Y1Iz5iQ/Id7Zkc3owrYguWoKvBrS+SkJnh7gv
 QizcSQHC/OKKwVGB6Z2IZGCCtAehhqgPUV89KuntCg5IGZUhPBpqUDTS/JJsjHZyQkjgL3C1Yno
 3gPcdl1FcNsCiG0zALzvXtBdQ7VEwBcWopF7F74GYsEM9iOJTlTfCleAViV0qxy/DsV3B/vgRpf
 rU/36vAg==
X-Gm-Gg: AR+sD12bbPZg18/ePQ7cIDa2v91xYuTyMr8ga6rVtpgmYhF2xqy0f9CiyVNDICk0mte
 FuIxMr8I32q0VZ7dEC9EnpQO/F2Mz2hhjB6dR4aBd5Piex/CTPEaT2qQVfDYrHdrKTnw2Kj4ooW
 zpeUHeOSqTCI6WWrcT1t+BR0cqirwyqxBG0NfHi6eALsoR1nq/5eVa909aI2/ApeSE258JzuTRE
 m1OAF2sTyUR5WI2PfbjqOEMv2B+PsUrxgqgSV5aaPSWTb8VkDnSsuFBTFs26/G6/ZwwuueETx8n
 yASZXGJhOfLIcaydeDGqtLXiBC4ry/v4vimV5sCRhry4DGD2jibdEPJ2Cdoj8HOuLPsxy8PJDgk
 4546/r5+1QG52ZNZ3PMgP84hUcwf/py6D5MKXFhN/wPkMwQWTqM4X4qA703sa+wfUghpuEg8NxF
 X8mOfpj9F36vv2RMHzesUXEOSOOG50FWHQ2xyLo7QALJmbf1fH3i29bo4cq2xY/gsbNWjEVJ90J
 ZFueFQoR8t1CZRh552aju9cEXLDpKECjx2zlgyGCiTuFBLWhnBSuuJsv7BkRp08UH2sm76JR28B
 JuO0mGV3qc9cWo6qU+XBHBdoejHEix6FKCUI4z+Kfs2p4UPgQiyc
X-Received: by 2002:a05:6000:4713:b0:47f:91e6:3729 with SMTP id
 ffacd0b85a97d-47fbac038d5mr2555951f8f.24.1785327800392; 
 Wed, 29 Jul 2026 05:23:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b0f295sm7440974f8f.22.2026.07.29.05.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:23:19 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 12:22:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
X-Gerrit-Change-Number: 1750
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1750?usp=email>
X-Gerrit-Commit: 9f3567b3c8c3b33c9f2953861e313f1b20276557
In-Reply-To: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxZjlkN2I1YTVlYzE5YmY3N2MwYzIxMjc5NWY1ODNjNWJhNGMwM2FjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2c0b50a8ecffb6689c386e2081ed6742b47bc7fc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp3Jn-0006ON-Am
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Wrap the client
 SERVER_PROBE with tls-auth/tls-crypt
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
Content-Type: multipart/mixed; boundary="===============0594241806466639992=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0594241806466639992==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dcUkYMGIcJ8="; charset=UTF-8

--dcUkYMGIcJ8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1750?usp=3Demail

to look at the new patch set (#14)=2E
=


Change subject: oob: Wrap the client SERVER_PROBE with tls-auth/tls-crypt=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Wrap =
the client SERVER_PROBE with tls-auth/tls-crypt

The client --server-probe =
previously sent a plaintext SERVER_PROBE and
parsed replies by hand, so it =
only worked against a server with no
control-channel wrapping=2E Build a st=
andalone wrapping context for the
probe (mirroring the server's tls_auth_st=
andalone) and route both the
outgoing probe and the incoming replies throug=
h the same control-channel
path the rest of the code uses:

  - tls_wrap_oo=
b_standalone() wraps the probe payload, applying the
    tls-auth HMAC or t=
ls-crypt encryption (or nothing, when neither is
    configured)=2E
  - rea=
d_control_auth() unwraps each reply, verifying the HMAC /
    decrypting an=
d stripping the opcode + session id, on a per-packet
    copy of the wrappi=
ng context (as tls_pre_decrypt_lite() does)=2E It
    decrypts in place, so=
 oob_probe_handle_reply() now takes a mutable
    buffer=2E

With neither t=
ls-auth nor tls-crypt configured the context stays in
TLS_WRAP_NONE and the=
 on-wire probe is byte-for-byte identical to before,
so the plaintext case =
is unchanged=2E

tls-crypt-v2 is not supported yet: the server only learns =
the client key
from the WKc carried in the TLS handshake, which an out-of-b=
and probe
cannot provide=2E Such configurations skip probing and keep the c=
onfigured
remote order=2E

Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c=
03ac
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M doc/man-sections=
/client-options=2Erst
M src/openvpn/oob_client=2Ec
2 files changed, 117 ins=
ertions(+), 33 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/50/1750/14

diff --git a/doc/man-sections/client-opti=
ons=2Erst b/doc/man-sections/client-options=2Erst
index 10ca808=2E=2Ef253a9=
4 100644
--- a/doc/man-sections/client-options=2Erst
+++ b/doc/man-sections=
/client-options=2Erst
@@ -616,9 +616,10 @@
   answering server is used, fal=
ling back to a built-in default of
   :code:`10` ms=2E
 
-  The probe is cu=
rrently sent without control-channel wrapping, so it only
-  works against =
a server configured without ``--tls-auth``,
-  ``--tls-crypt`` or ``--tls-c=
rypt-v2``=2E
+  The probe carries the same control-channel wrapping as a no=
rmal
+  connection (``--tls-auth`` or ``--tls-crypt``, when configured)=2E =
With
+  ``--tls-crypt-v2`` the remotes are left in their configured order,
=
+  because the server cannot unwrap an out-of-band probe yet=2E
 
   Only U=
DP remotes are probed; TCP remotes keep their configured
   position=2E Pro=
bing runs once, before the first connection attempt=2E
diff --git a/src/ope=
nvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
index 3de791f=2E=2E78dc432=
 100644
--- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@=
@ -29,6 +29,8 @@
 #include "oob_client=2Eh"
 #include "openvpn=2Eh"
 #inclu=
de "oob=2Eh"
+#include "init=2Eh"
+#include "ssl=2Eh"
 #include "ssl_pkt=2E=
h"
 #include "session_id=2Eh"
 #include "socket=2Eh"
@@ -80,21 +82,54 @@
  =
   return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;
 }
 
-/* Build =
a plaintext SERVER_PROBE packet:
- *   [opcode | key_id=3D0] [client sessio=
n id] [SERVER_PROBE message]
- * This is the unauthenticated OOB wire forma=
t; adding tls-auth/tls-crypt
- * wrapping for the probe is a follow-up (it =
only works against a server with
- * no control-channel wrapping for now)=
=2E */
-static bool
-oob_probe_build_packet(struct buffer *buf, const struc=
t session_id *client_sid)
+/* Build a standalone control-channel wrapping c=
ontext for the probe, mirroring
+ * the tls_auth_standalone the server uses=
 to answer it=2E With neither tls-auth
+ * nor tls-crypt configured the con=
text stays in TLS_WRAP_NONE and the probe is
+ * sent in plaintext, exactly=
 as before; with either configured the probe is
+ * authenticated/encrypted=
 like any other control packet=2E Returns NULL (and
+ * logs) for configura=
tions the probe cannot wrap yet, in which case the caller
+ * skips probing=
 and keeps the configured remote order=2E */
+static struct tls_auth_standa=
lone *
+oob_probe_init_tls_auth_standalone(struct context *c, struct gc_are=
na *gc)
 {
-    const struct oob_probe_parameter param =3D {
-        =2Eti=
mestamp =3D (uint64_t)now,
-        =2Eflags =3D 0,
-    };
-    uint8_t he=
ader =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
-    return buf_wri=
te_u8(buf, header) && session_id_write(client_sid, buf)
-           && oob_=
server_probe_write(buf, &param);
+    /* The probe runs before next_connect=
ion_entry() maps a connection entry
+     * into options=2Ece, so take the =
wrapping config from the first connection
+     * entry directly=2E A globa=
l --tls-auth/--tls-crypt is copied into every
+     * connection-list entry=
 by options_postprocess_mutate_ce(), so the first
+     * entry carries it =
even though options=2Ece does not yet=2E (Probing wraps a
+     * single pa=
cket for all remotes, so per-connection-block keys are not
+     * supporte=
d; the first entry's wrapping is used for all=2E) */
+    const struct conn=
ection_entry *ce =3D c->options=2Econnection_list->array[0];
+
+    /* tls-=
crypt-v2 wraps with a per-client key the server only learns from the
+     =
* wrapped client key (WKc) carried in the TLS handshake=2E An out-of-band
+=
     * probe carries no WKc, so the server cannot unwrap it; skip probing r=
ather
+     * than send something unverifiable=2E */
+    if (ce->tls_crypt=
_v2_file)
+    {
+        msg(D_LOW, "server-probe: not supported with tls-=
crypt-v2; using configured order");
+        return NULL;
+    }
+
+    /* =
Load the tls-auth/tls-crypt key material into c->c1=2Eks (a no-op if neithe=
r
+     * is configured)=2E This is run again per-connection later; calling=
 it early
+     * here is harmless=2E */
+    do_init_tls_wrap_key(c, ce);
=
+
+    struct tls_options to;
+    CLEAR(to);
+    init_tls_wrap_ctx(&to=2E=
tls_wrap, ce, c->options=2Etls_client, &c->c1=2Eks, &c->c1=2Epid_persist);
=
+    to=2Ereplay_window =3D c->options=2Ereplay_window;
+    to=2Ereplay_ti=
me =3D c->options=2Ereplay_time;
+
+    struct tls_auth_standalone *tas =3D=
 tls_auth_standalone_init(&to, gc);
+
+    /* Control-channel frame and wor=
k buffers, mirroring do_init_frame_tls()=2E */
+    tls_init_control_channe=
l_frame_parameters(&tas->frame, ce->tls_mtu);
+    tas->tls_wrap=2Ework =3D=
 alloc_buf_gc(BUF_SIZE(&tas->frame), gc);
+    tas->workbuf =3D alloc_buf_g=
c(BUF_SIZE(&tas->frame), gc);
+
+    return tas;
 }
 
 /* Open one native U=
DP probe socket per address family (v4 and v6)=2E Each is
@@ -145,9 +180,9 =
@@
 /* Parse one received datagram as a PROBE_REPLY and, if valid and match=
ing one
  * of the probes we sent, record the reply in results=2E */
 stati=
c void
-oob_probe_handle_reply(const uint8_t *data, int len, const struct s=
ession_id *client_sid,
-                       const struct sockaddr_storag=
e *from, const struct probe_target *targets,
-                       struct=
 oob_probe_result *results, int n)
+oob_probe_handle_reply(uint8_t *data, i=
nt len, const struct session_id *client_sid,
+                       const =
struct tls_wrap_ctx *base_wrap, const struct sockaddr_storage *from,
+     =
                  const struct probe_target *targets, struct oob_probe_resu=
lt *results, int n)
 {
     /* Need at least the opcode byte and the sessio=
n id=2E */
     if (len < 1 + (int)SID_SIZE || (data[0] >> P_OPCODE_SHIFT) =
!=3D P_CONTROL_OOB_V1)
@@ -157,7 +192,20 @@
 
     struct buffer buf;
     =
buf_set_read(&buf, data, (size_t)len);
-    buf_advance(&buf, 1 + SID_SIZE)=
; /* skip opcode + server session id */
+
+    /* Unwrap the reply with the=
 same control-channel path the server used to
+     * wrap it: this verifie=
s the tls-auth HMAC / decrypts tls-crypt, and (in all
+     * modes) strips=
 the opcode + server session id, leaving buf at the TLV
+     * payload=2E =
With no tls-auth/tls-crypt it just strips those header bytes, as
+     * be=
fore=2E read_control_auth() mutates the wrapping context, so we work on a
+=
     * per-packet copy (as tls_pre_decrypt_lite() does on the server)=2E Th=
e peer
+     * address is only used for log messages, and tls_options only =
for
+     * tls-crypt-v2 metadata checks, so both are passed as NULL=2E */
=
+    struct tls_wrap_ctx wrap =3D *base_wrap;
+    if (!read_control_auth(&=
buf, &wrap, NULL, NULL))
+    {
+        return; /* not for us, or failed a=
uthentication */
+    }
 
     struct oob_probe_reply reply;
     if (!oob_=
client_reply_read(&buf, &reply))
@@ -208,8 +256,9 @@
  * matches a probe we=
 sent=2E Returns true if every sent probe has been answered=2E */
 static b=
ool
 oob_probe_receive_slice(const struct probe_ctx *pc, const struct timev=
al *deadline,
-                        const struct session_id *client_sid,=
 const struct probe_target *targets,
-                        struct oob_pr=
obe_result *results, int n, int outstanding)
+                        const=
 struct session_id *client_sid, const struct tls_wrap_ctx *wrap,
+         =
               const struct probe_target *targets, struct oob_probe_result =
*results, int n,
+                        int outstanding)
 {
     while (t=
rue)
     {
@@ -259,7 +308,7 @@
                                     (struc=
t sockaddr *)&from, &fromlen);
             if (len > 0)
             {
-  =
              oob_probe_handle_reply(data, len, client_sid, &from, targets,=
 results, n);
+                oob_probe_handle_reply(data, len, client_sid=
, wrap, &from, targets, results, n);
             }
         }
         if =
(oob_count_answered(targets, results, n) >=3D outstanding)
@@ -296,8 +345,8=
 @@
  * once the window elapses or every sent probe has been answered=2E */=

 static void
 oob_probe_collect(const struct probe_ctx *pc, const struct b=
uffer *probe,
-                  const struct session_id *client_sid, const=
 struct probe_target *targets,
-                  struct oob_probe_result *=
results, int n)
+                  const struct session_id *client_sid, con=
st struct tls_wrap_ctx *wrap,
+                  const struct probe_target =
*targets, struct oob_probe_result *results, int n)
 {
     /* number of pro=
bes we actually sent: stop early once they all answer */
     int want =3D =
0;
@@ -321,7 +370,7 @@
             deadline=2Etv_usec -=3D 1000000;
      =
   }
 
-        if (oob_probe_receive_slice(pc, &deadline, client_sid, targ=
ets, results, n, want))
+        if (oob_probe_receive_slice(pc, &deadline,=
 client_sid, wrap, targets, results, n, want))
         {
             retu=
rn; /* all answered */
         }
@@ -363,6 +412,16 @@
 
     struct gc_are=
na gc =3D gc_new();
 
+    /* Wrapping context for the probe (tls-auth/tls-=
crypt, or plaintext if
+     * neither)=2E NULL means this configuration ca=
nnot be probed; keep the
+     * configured order=2E */
+    struct tls_aut=
h_standalone *tas =3D oob_probe_init_tls_auth_standalone(c, &gc);
+    if (=
!tas)
+    {
+        gc_free(&gc);
+        return;
+    }
+
     /* A sin=
gle random session id identifies all of our probes; servers echo it
      *=
 back in the reply's peer_session_id, letting us reject spoofed replies=2E =
*/
     struct session_id client_sid;
@@ -372,6 +431,7 @@
     if (oob_prob=
e_sockets_open(&pc) =3D=3D 0)
     {
         msg(D_LOW, "server-probe: cou=
ld not open probe socket; using configured order");
+        tls_auth_stand=
alone_free(tas);
         gc_free(&gc);
         return;
     }
@@ -379,17 =
+439,39 @@
     struct probe_target *targets =3D gc_malloc(sizeof(*targets)=
 * l->len, true, &gc);
     struct oob_probe_result *results =3D gc_malloc(=
sizeof(*results) * l->len, true, &gc);
 
-    struct buffer probe =3D alloc=
_buf_gc(256, &gc);
-    if (!oob_probe_build_packet(&probe, &client_sid))
+=
    /* Build the probe once and reuse the same bytes for every remote and f=
or
+     * resends: the SERVER_PROBE payload is a single probe_parameter TL=
V, wrapped
+     * (or sent in plaintext) like any other control packet=2E =
The client session
+     * id is prepended as the sender session id=2E */
+=
    struct buffer payload =3D alloc_buf_gc(64, &gc);
+    const struct oob_=
probe_parameter param =3D {
+        =2Etimestamp =3D (uint64_t)now,
+     =
   =2Eflags =3D 0,
+    };
+    if (!oob_server_probe_write(&payload, &para=
m))
     {
-        msg(D_LOW, "server-probe: could not build probe packet;=
 using configured order");
+        msg(D_LOW, "server-probe: could not bui=
ld probe payload; using configured order");
         oob_probe_sockets_clos=
e(&pc);
+        tls_auth_standalone_free(tas);
         gc_free(&gc);
    =
     return;
     }
 
-    msg(D_LOW, "server-probe: probing %d remote(s) w=
ith a %d ms window", l->len,
-        OOB_PROBE_WINDOW_MS);
+    struct buf=
fer probe =3D tls_wrap_oob_standalone(&tas->tls_wrap, tas, &client_sid, &pa=
yload);
+    if (!BLEN(&probe))
+    {
+        msg(D_LOW, "server-probe: c=
ould not wrap probe packet; using configured order");
+        oob_probe_so=
ckets_close(&pc);
+        tls_auth_standalone_free(tas);
+        gc_free(=
&gc);
+        return;
+    }
+
+    const char *wrap_name =3D (tas->tls_wr=
ap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? "tls-crypt"
+                          =
  : (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? "tls-auth"
+             =
                                                       : "none (plaintext)"=
;
+    msg(D_LOW, "server-probe: probing %d remote(s) with a %d ms window, =
control-channel wrapping: %s",
+        l->len, OOB_PROBE_WINDOW_MS, wrap_n=
ame);
 
     /* Send a probe to each configured remote=2E */
     int sent_=
count =3D 0;
@@ -450,7 +532,7 @@
 
     if (sent_count > 0)
     {
-       =
 oob_probe_collect(&pc, &probe, &client_sid, targets, results, l->len);
+  =
      oob_probe_collect(&pc, &probe, &client_sid, &tas->tls_wrap, targets, =
results, l->len);
     }
     oob_probe_sockets_close(&pc);
 
@@ -496,5 +57=
8,6 @@
     msg(M_INFO, "server-probe: %d of %d remote(s) answered; connect=
ing best-first", responded,
         l->len);
 
+    tls_auth_standalone_fr=
ee(tas);
     gc_free(&gc);
 }

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1750?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
Gerrit-Change-Numb=
er: 1750
Gerrit-PatchSet: 14
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>

--dcUkYMGIcJ8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #14</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1750?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Wra=
p the client SERVER_PROBE with tls-auth/tls-crypt<br><br>The client --serve=
r-probe previously sent a plaintext SERVER_PROBE and<br>parsed replies by h=
and, so it only worked against a server with no<br>control-channel wrapping=
=2E Build a standalone wrapping context for the<br>probe (mirroring the ser=
ver&#39;s tls_auth_standalone) and route both the<br>outgoing probe and the=
 incoming replies through the same control-channel<br>path the rest of the =
code uses:<br><br>  - tls_wrap_oob_standalone() wraps the probe payload, ap=
plying the<br>    tls-auth HMAC or tls-crypt encryption (or nothing, when n=
either is<br>    configured)=2E<br>  - read_control_auth() unwraps each rep=
ly, verifying the HMAC /<br>    decrypting and stripping the opcode + sessi=
on id, on a per-packet<br>    copy of the wrapping context (as tls_pre_decr=
ypt_lite() does)=2E It<br>    decrypts in place, so oob_probe_handle_reply(=
) now takes a mutable<br>    buffer=2E<br><br>With neither tls-auth nor tls=
-crypt configured the context stays in<br>TLS_WRAP_NONE and the on-wire pro=
be is byte-for-byte identical to before,<br>so the plaintext case is unchan=
ged=2E<br><br>tls-crypt-v2 is not supported yet: the server only learns the=
 client key<br>from the WKc carried in the TLS handshake, which an out-of-b=
and probe<br>cannot provide=2E Such configurations skip probing and keep th=
e configured<br>remote order=2E<br><br>Change-Id: I1f9d7b5a5ec19bf77c0c2127=
95f583c5ba4c03ac<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<b=
r>---<br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/oob_clien=
t=2Ec<br>2 files changed, 117 insertions(+), 33 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/50/1750/14</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/doc/man-sections/client-options=2Erst b/=
doc/man-sections/client-options=2Erst</span><br><span>index 10ca808=2E=2Ef2=
53a94 100644</span><br><span>--- a/doc/man-sections/client-options=2Erst</s=
pan><br><span>+++ b/doc/man-sections/client-options=2Erst</span><br><span>@=
@ -616,9 +616,10 @@</span><br><span>   answering server is used, falling ba=
ck to a built-in default of</span><br><span>   :code:`10` ms=2E</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The probe is =
currently sent without control-channel wrapping, so it only</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  works against a server configured w=
ithout ``--tls-auth``,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  ``--tls-crypt`` or ``--tls-crypt-v2``=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  The probe carries the same control-channel wrappi=
ng as a normal</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  con=
nection (``--tls-auth`` or ``--tls-crypt``, when configured)=2E With</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--tls-crypt-v2`` the r=
emotes are left in their configured order,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  because the server cannot unwrap an out-of-band pr=
obe yet=2E</span><br><span> </span><br><span>   Only UDP remotes are probed=
; TCP remotes keep their configured</span><br><span>   position=2E Probing =
runs once, before the first connection attempt=2E</span><br><span>diff --gi=
t a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span=
>index 3de791f=2E=2E78dc432 100644</span><br><span>--- a/src/openvpn/oob_cl=
ient=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@=
@ -29,6 +29,8 @@</span><br><span> #include &quot;oob_client=2Eh&quot;</span=
><br><span> #include &quot;openvpn=2Eh&quot;</span><br><span> #include &quo=
t;oob=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;init=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;ssl=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=
=2Eh&quot;</span><br><span> #include &quot;session_id=2Eh&quot;</span><br><=
span> #include &quot;socket=2Eh&quot;</span><br><span>@@ -80,21 +82,54 @@</=
span><br><span>     return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/* Build a plaintext SERVER_PROBE packet:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *   [opcode | key_id=3D0] [client ses=
sion id] [SERVER_PROBE message]</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * This is the unauthenticated OOB wire format; adding tls-auth/t=
ls-crypt</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * wrapping f=
or the probe is a follow-up (it only works against a server with</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * no control-channel wrapping f=
or now)=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static b=
ool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-oob_probe_build_pa=
cket(struct buffer *buf, const struct session_id *client_sid)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Build a standalone control-cha=
nnel wrapping context for the probe, mirroring</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * the tls_auth_standalone the server uses to an=
swer it=2E With neither tls-auth</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * nor tls-crypt configured the context stays in TLS_WRAP_NONE=
 and the probe is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 sent in plaintext, exactly as before; with either configured the probe is<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * authenticated/enc=
rypted like any other control packet=2E Returns NULL (and</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * logs) for configurations the probe=
 cannot wrap yet, in which case the caller</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * skips probing and keeps the configured remote ord=
er=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static stru=
ct tls_auth_standalone *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+oob_probe_init_tls_auth_standalone(struct context *c, struct gc_arena =
*gc)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    const struct oob_probe_parameter param =3D {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        =2Etimestamp =3D (uint64_t)now,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        =2Eflags =3D 0,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    };</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    uint8_t header =3D (uint8_t)(P_CONTRO=
L_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return buf_write_u8(buf, header) &amp;&amp; session_id_wri=
te(client_sid, buf)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
         &amp;&amp; oob_server_probe_write(buf, &amp;param);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* The probe runs before next_=
connection_entry() maps a connection entry</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * into options=2Ece, so take the wrapping confi=
g from the first connection</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * entry directly=2E A global --tls-auth/--tls-crypt is copied =
into every</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * co=
nnection-list entry by options_postprocess_mutate_ce(), so the first</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * entry carries it ev=
en though options=2Ece does not yet=2E (Probing wraps a</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * single packet for all remotes, s=
o per-connection-block keys are not</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * supported; the first entry&#39;s wrapping is used fo=
r all=2E) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st struct connection_entry *ce =3D c-&gt;options=2Econnection_list-&gt;arra=
y[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* tls-crypt-v2 wraps with a =
per-client key the server only learns from the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * wrapped client key (WKc) carried in the T=
LS handshake=2E An out-of-band</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * probe carries no WKc, so the server cannot unwrap it; ski=
p probing rather</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * than send something unverifiable=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (ce-&gt;tls_crypt_v2_file)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server-probe: not supported=
 with tls-crypt-v2; using configured order&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Load the tls-auth/tls-crypt key material into c-&gt;c1=2Eks (a no-o=
p if neither</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
is configured)=2E This is run again per-connection later; calling it early<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * here is harml=
ess=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    do_ini=
t_tls_wrap_key(c, ce);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_o=
ptions to;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR=
(to);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_tls_w=
rap_ctx(&amp;to=2Etls_wrap, ce, c-&gt;options=2Etls_client, &amp;c-&gt;c1=
=2Eks, &amp;c-&gt;c1=2Epid_persist);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    to=2Ereplay_window =3D c-&gt;options=2Ereplay_window;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=2Ereplay_time=
 =3D c-&gt;options=2Ereplay_time;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct tls_auth_standalone *tas =3D tls_auth_standalone_init(&amp;to, gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* Control-channel frame and work bu=
ffers, mirroring do_init_frame_tls()=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    tls_init_control_channel_frame_parameters(&amp;t=
as-&gt;frame, ce-&gt;tls_mtu);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    tas-&gt;tls_wrap=2Ework =3D alloc_buf_gc(BUF_SIZE(&amp;tas-&=
gt;frame), gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
tas-&gt;workbuf =3D alloc_buf_gc(BUF_SIZE(&amp;tas-&gt;frame), gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return tas;</span><br><span> }</span><br><=
span> </span><br><span> /* Open one native UDP probe socket per address fam=
ily (v4 and v6)=2E Each is</span><br><span>@@ -145,9 +180,9 @@</span><br><s=
pan> /* Parse one received datagram as a PROBE_REPLY and, if valid and matc=
hing one</span><br><span>  * of the probes we sent, record the reply in res=
ults=2E */</span><br><span> static void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-oob_probe_handle_reply(const uint8_t *data, int len, cons=
t struct session_id *client_sid,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                       const struct sockaddr_storage *from, cons=
t struct probe_target *targets,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                       struct oob_probe_result *results, int n)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_handle_repl=
y(uint8_t *data, int len, const struct session_id *client_sid,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                       const str=
uct tls_wrap_ctx *base_wrap, const struct sockaddr_storage *from,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                       const =
struct probe_target *targets, struct oob_probe_result *results, int n)</spa=
n><br><span> {</span><br><span>     /* Need at least the opcode byte and th=
e session id=2E */</span><br><span>     if (len &lt; 1 + (int)SID_SIZE || (=
data[0] &gt;&gt; P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)</span><br><span>@@ =
-157,7 +192,20 @@</span><br><span> </span><br><span>     struct buffer buf;=
</span><br><span>     buf_set_read(&amp;buf, data, (size_t)len);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    buf_advance(&amp;buf, 1 + SI=
D_SIZE); /* skip opcode + server session id */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* Unwrap the reply with the same control-channel path the serv=
er used to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * wr=
ap it: this verifies the tls-auth HMAC / decrypts tls-crypt, and (in all</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * modes) strips t=
he opcode + server session id, leaving buf at the TLV</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * payload=2E With no tls-auth/tls-cr=
ypt it just strips those header bytes, as</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * before=2E read_control_auth() mutates the wrap=
ping context, so we work on a</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * per-packet copy (as tls_pre_decrypt_lite() does on the ser=
ver)=2E The peer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * address is only used for log messages, and tls_options only for</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * tls-crypt-v2 metadat=
a checks, so both are passed as NULL=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct tls_wrap_ctx wrap =3D *base_wrap;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!read_control_auth(=
&amp;buf, &amp;wrap, NULL, NULL))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return; /* not for us, or failed authentication */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><s=
pan>     struct oob_probe_reply reply;</span><br><span>     if (!oob_client=
_reply_read(&amp;buf, &amp;reply))</span><br><span>@@ -208,8 +256,9 @@</spa=
n><br><span>  * matches a probe we sent=2E Returns true if every sent probe=
 has been answered=2E */</span><br><span> static bool</span><br><span> oob_=
probe_receive_slice(const struct probe_ctx *pc, const struct timeval *deadl=
ine,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
       const struct session_id *client_sid, const struct probe_target *targ=
ets,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
       struct oob_probe_result *results, int n, int outstanding)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                        const =
struct session_id *client_sid, const struct tls_wrap_ctx *wrap,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        const s=
truct probe_target *targets, struct oob_probe_result *results, int n,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                        i=
nt outstanding)</span><br><span> {</span><br><span>     while (true)</span>=
<br><span>     {</span><br><span>@@ -259,7 +308,7 @@</span><br><span>      =
                               (struct sockaddr *)&amp;from, &amp;fromlen);=
</span><br><span>             if (len &gt; 0)</span><br><span>             =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                oob_=
probe_handle_reply(data, len, client_sid, &amp;from, targets, results, n);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                oob_=
probe_handle_reply(data, len, client_sid, wrap, &amp;from, targets, results=
, n);</span><br><span>             }</span><br><span>         }</span><br><=
span>         if (oob_count_answered(targets, results, n) &gt;=3D outstandi=
ng)</span><br><span>@@ -296,8 +345,8 @@</span><br><span>  * once the window=
 elapses or every sent probe has been answered=2E */</span><br><span> stati=
c void</span><br><span> oob_probe_collect(const struct probe_ctx *pc, const=
 struct buffer *probe,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                  const struct session_id *client_sid, const struct probe_=
target *targets,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
             struct oob_probe_result *results, int n)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                  const struct session_id=
 *client_sid, const struct tls_wrap_ctx *wrap,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                  const struct probe_target *tar=
gets, struct oob_probe_result *results, int n)</span><br><span> {</span><br=
><span>     /* number of probes we actually sent: stop early once they all =
answer */</span><br><span>     int want =3D 0;</span><br><span>@@ -321,7 +3=
70,7 @@</span><br><span>             deadline=2Etv_usec -=3D 1000000;</span=
><br><span>         }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (oob_probe_receive_slice(pc, &amp;deadline, cl=
ient_sid, targets, results, n, want))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (oob_probe_receive_slice(pc, &amp;deadline, cl=
ient_sid, wrap, targets, results, n, want))</span><br><span>         {</spa=
n><br><span>             return; /* all answered */</span><br><span>       =
  }</span><br><span>@@ -363,6 +412,16 @@</span><br><span> </span><br><span>=
     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Wrapping context for the probe (=
tls-auth/tls-crypt, or plaintext if</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * neither)=2E NULL means this configuration cannot be =
probed; keep the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * configured order=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct tls_auth_standalone *tas =3D oob_probe_init_tls_auth_stan=
dalone(c, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (!tas)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* A singl=
e random session id identifies all of our probes; servers echo it</span><br=
><span>      * back in the reply&#39;s peer_session_id, letting us reject s=
poofed replies=2E */</span><br><span>     struct session_id client_sid;</sp=
an><br><span>@@ -372,6 +431,7 @@</span><br><span>     if (oob_probe_sockets=
_open(&amp;pc) =3D=3D 0)</span><br><span>     {</span><br><span>         ms=
g(D_LOW, &quot;server-probe: could not open probe socket; using configured =
order&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  tls_auth_standalone_free(tas);</span><br><span>         gc_free(&amp;gc);=
</span><br><span>         return;</span><br><span>     }</span><br><span>@@=
 -379,17 +439,39 @@</span><br><span>     struct probe_target *targets =3D g=
c_malloc(sizeof(*targets) * l-&gt;len, true, &amp;gc);</span><br><span>    =
 struct oob_probe_result *results =3D gc_malloc(sizeof(*results) * l-&gt;le=
n, true, &amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct buffer probe =3D alloc_buf_gc(256, &amp;gc);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!oob_probe_build_p=
acket(&amp;probe, &amp;client_sid))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* Build the probe once and reuse the same bytes for ev=
ery remote and for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * resends: the SERVER_PROBE payload is a single probe_parameter TLV, wr=
apped</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (or sen=
t in plaintext) like any other control packet=2E The client session</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * id is prepended as t=
he sender session id=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct buffer payload =3D alloc_buf_gc(64, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_para=
meter param =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      =2Etimestamp =3D (uint64_t)now,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!oob_server_probe_write(&amp;payload, &amp;param))</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  msg(D_LOW, &quot;server-probe: could not build probe packet; using config=
ured order&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(D_LOW, &quot;server-probe: could not build probe payload; using =
configured order&quot;);</span><br><span>         oob_probe_sockets_close(&=
amp;pc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls=
_auth_standalone_free(tas);</span><br><span>         gc_free(&amp;gc);</spa=
n><br><span>         return;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_LOW, &quot;server=
-probe: probing %d remote(s) with a %d ms window&quot;, l-&gt;len,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        OOB_PROBE_WINDOW_MS);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer pr=
obe =3D tls_wrap_oob_standalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_sid=
, &amp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!BLEN(&amp;probe))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(D_LOW, &quot;server-probe: could not wrap probe packet; using configured =
order&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  oob_probe_sockets_close(&amp;pc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        tls_auth_standalone_free(tas);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *wrap_name =3D (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_=
CRYPT)  ? &quot;tls-crypt&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                            : (tas-&gt;tls_wrap=2Emode =3D=3D T=
LS_WRAP_AUTH) ? &quot;tls-auth&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                                          =
          : &quot;none (plaintext)&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    msg(D_LOW, &quot;server-probe: probing %d remote(=
s) with a %d ms window, control-channel wrapping: %s&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        l-&gt;len, OOB_PROBE_WINDOW=
_MS, wrap_name);</span><br><span> </span><br><span>     /* Send a probe to =
each configured remote=2E */</span><br><span>     int sent_count =3D 0;</sp=
an><br><span>@@ -450,7 +532,7 @@</span><br><span> </span><br><span>     if =
(sent_count &gt; 0)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        oob_probe_collect(&amp;pc, &amp;probe, &amp;cl=
ient_sid, targets, results, l-&gt;len);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        oob_probe_collect(&amp;pc, &amp;probe, &amp;cli=
ent_sid, &amp;tas-&gt;tls_wrap, targets, results, l-&gt;len);</span><br><sp=
an>     }</span><br><span>     oob_probe_sockets_close(&amp;pc);</span><br>=
<span> </span><br><span>@@ -496,5 +578,6 @@</span><br><span>     msg(M_INFO=
, &quot;server-probe: %d of %d remote(s) answered; connecting best-first&qu=
ot;, responded,</span><br><span>         l-&gt;len);</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_auth_standalone_=
free(tas);</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1750?usp=3Demail">change 1750</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212=
795f583c5ba4c03ac </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1750 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>

</body></html>
--dcUkYMGIcJ8=--


--===============0594241806466639992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0594241806466639992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0594241806466639992==--

