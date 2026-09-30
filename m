Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307BCCA5FB1
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=elMHk05jwBtTu2z1Tb0RBcD9keRKRgaIA8PVIlk/RYw=; b=EzcqHd6Tsf8eXRHNQrBI9oIZy4
	IJSxDpaD+7LNSni4v1eYkcqPn1H5Wl9AFsh9obx0WDkP5fg2+Zq5M+Tlfbk43jrGJnM/mk8OBbz7F
	hQmiHDY183bDgZ7Js4vbaSJVxKv+gtduUBwJcfadOv8ApgIGPxLb++TWj7rJz4MDCvSQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpe8-0002lL-95;
	Wed, 30 Sep 2026 08:26:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpdh-0002i4-0d
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EX0i66DB0JDWXXkPuv9HOlGdswFSsmV1mp6rEHvYyl4=; b=f7lkJ176SyqAykEMv3n1EEcqaq
 RxdDYIQ0eX2brIEHsH2vPR/RsSXewdqNXNYTqRlHvOtWj1hezaFw/Me6wnfaSMKG/d1LdUsUrTi/8
 geMmRtZ83Ll3a5qAQroEYRTlNyDZ0vud6HHaSvueEPVR1MLMNw3WlTTHxs+0hJTVAAM0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EX0i66DB0JDWXXkPuv9HOlGdswFSsmV1mp6rEHvYyl4=; b=B
 n7bhSCi7kCpTWgLe/Fc7Z+31xGin9qvpxWG0yKgTDhbWCqNEsjqmaktzFb0Y7TY54x06D1DELCsbI
 vtfjF8qf2bKTLFpDw+QDP5hgFTJwlipQ72BgpwOM14txl7VIF/O6Zbqoqu5mkWEeLNia6cAvU5mMX
 nAPoFTzCKUXCl0Hg=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpdf-0006k5-9b for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:09 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ffe817151so21114405e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756761; x=1791361561; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EX0i66DB0JDWXXkPuv9HOlGdswFSsmV1mp6rEHvYyl4=;
 b=QmSQDeB1sPfpyj+Azr8CLpF+jrhYlfzr/LxKiQDqLOfuY2WVsh4Tdf61/1wiIDa2Zq
 Vn1oZaHOUiqISP/e/PF3u6w6FV6jr3x7fPLR+2Gmz9sBPRJ2PpBGHJ6TP3xln2NkqIVF
 uTHXEbcanlJdfKSUS9KDyj1n1rUX6uij70NmvueqggMhDXEL4Wkl/qB0nBjSGu0/hsG6
 hCIqlwUBOBZFW1rPydvmcmCcL1nQ4FeadVVm61ZKlqXnRfk1rks6rgcLhBke/w7F470h
 QKhkiNvzzx0q5fAE98yC8fdFqImrSayCbm+ZpeHHcmaEzidyX1swNhz3w3Fgzy9NP0r+
 Sl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756761; x=1791361561;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EX0i66DB0JDWXXkPuv9HOlGdswFSsmV1mp6rEHvYyl4=;
 b=XGWeT76s6UT+VmO3TPFJqwE2coQs75GTt6yZZwz9x3oHcqpPboonjmKrws5F8yLxDC
 ZpSL5+lDCctuiKCm0oCK0smp8NUM6mmn9CEm8iY48G/Ip3oZx3/SHeU1r3VwruFV3HX/
 Wp6WBv2hRapquzwkdnKmg8cO1+RbHKOn6obRSrvu4j6knNqebo1XPA9xhlMb+vga3v+d
 kYMQKIhTJh50BAQb/4O/SJXTwifMANzpejnJcBIr6xVCf8QWJDrWYW3LjWD/vUAGy9Rl
 uEUlAfreJ6T/nDt+nxeGwrvVAP+Cvdlwv5hgRehsWFVlyUAIRQPm7rFSrpD2Ti5s5tPz
 329w==
X-Gm-Message-State: AFuF++ke1sf6PSpTSI40qa/4jY2ChMPlbnhclk2fOCSKJIQGHCjlc8BE
 fDWVLb2XYXw5ATiY4oBHQ9/7IrYbSxRMxA0KUTbDWzQUQe8xZpMpF9wyR08yroObfLe+OaJU6hf
 AnwKDTLf4pu0htLylqitPADQ7MGw8XmKliPcU7WFAJf05taHV+LnfMkSs4GYgntfGUG6O
X-Gm-Gg: AYBFou1lExagKs8HXQFF+Bn4CjwV0sTjYXrkAvyGkyalDKHa4x5ySFyJVjpJJnJWkqT
 OnY/Tf994DojPj/SP8P4F+wV12932r7c4S3l/95pnY6rnIcoV81zmxEbeWBxahrufWdCbR6CVFW
 UjfPLeEjYr/xbVRR3b6hQgKhzf9VcNJ7M3tZR9KeZcNiZQbJOWusjMvbRDPmAwcmi1LThWq8non
 xCB9eVI6bXpJ2U6B6gIlIt4CvIJddzimAY+iSt30SV2RnFju8aP8DIb56oJyUzc68nEC58APVri
 9m2qR6mFjjDMEv7ypyrdfDDmAKWRfgAhC8N5Qoff5/e5IBVM5GsDJyGPD+r9UcIE2++1KdhWwXl
 LrcI2MWPKSLvfRPnuBKBMRxnJIazcw26mtog3edgdhmylSxA83efNYLX2xcBDp7eXOktFUM8jEL
 4QuoWKekj95jnQK4xLHmN6Pr2Qap/xiK+POLAoNOiaXjZB/gFb404jyPhMGRaLw07K0nFWBrjLv
 KulKU7eQi5p7gsrpxYY9M+dkctsmNfISTft5ZcIc1q7rjgTFcRuEAV2HOs0wIkTgcm/s5tADR1j
 VIRqLJiiNG0O+/hUkAxnMCeOsGPTJXpTKtu7Kp8iWnMnzPjq7ADNy0/qF5tq
X-Received: by 2002:a05:600c:4fcc:b0:49f:f9d1:e618 with SMTP id
 5b1f17b1804b1-4a01aff61bamr8319105e9.17.1790756760439; 
 Wed, 30 Sep 2026 01:26:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a015cd1282sm53098085e9.4.2026.09.30.01.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:26:00 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:25:29 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 29
X-Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
X-Gerrit-Change-Number: 1750
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1750?usp=email>
X-Gerrit-Commit: eba94b5d13c734281738d6a01ded685b8186042d
In-Reply-To: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxZjlkN2I1YTVlYzE5YmY3N2MwYzIxMjc5NWY1ODNjNWJhNGMwM2FjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d5252b5f8fc651c33c4fc291a2d3b74b9e2bd477-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpdf-0006k5-9b
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Wrap the client
 probe request with tls-auth/tls-crypt
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6613079610014639758=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6613079610014639758==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dwso+s2c2zU="; charset=UTF-8

--dwso+s2c2zU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail

to look a=
t the new patch set (#29)=2E


Change subject: oob: Wrap the client probe r=
equest with tls-auth/tls-crypt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

oob: Wrap the client probe request with tls-auth/tls-cr=
ypt

The client --server-probe sent a plaintext probe request and parsed
re=
plies by hand, so it only worked against a server with no
control-channel w=
rapping=2E

Build a standalone wrapping context for the probe, mirroring th=
e
server's tls_auth_standalone, and send probes and unwrap replies through
=
the regular control-channel path (tls_wrap_oob_standalone() and
read_contro=
l_auth())=2E Replies are unwrapped on a per-packet copy of the
context, as =
tls_pre_decrypt_lite() does=2E Each transmission is wrapped on
its own, as =
each carries its own request_id; with tls-auth or tls-crypt
that also gives=
 each its own replay packet id=2E Without either, the
probe goes out in pla=
intext as before=2E

tls-crypt-v2 is not supported yet: the server only lea=
rns the client
key from the WKc carried in the TLS handshake, which an out-=
of-band
probe cannot provide=2E Such configurations skip probing and keep t=
he
configured remote order=2E

The probe is wrapped with the key of the fir=
st remote we can probe --
the same entry the other probed remotes are compa=
red against -- so
probing is declined when another one of them is keyed dif=
ferently=2E The
key material loaded for the probe is released afterwards; i=
nit loads it
again for the connection=2E

Change-Id: I1f9d7b5a5ec19bf77c0c2=
12795f583c5ba4c03ac
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M d=
oc/man-sections/client-options=2Erst
M src/openvpn/oob_client=2Ec
2 files c=
hanged, 141 insertions(+), 27 deletions(-)


  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/50/1750/29

diff --git a/doc/man-secti=
ons/client-options=2Erst b/doc/man-sections/client-options=2Erst
index 9835=
403=2E=2Ef1f004f 100644
--- a/doc/man-sections/client-options=2Erst
+++ b/d=
oc/man-sections/client-options=2Erst
@@ -620,20 +620,23 @@
   priority grou=
p a candidate, since replies only arrive within the
   one-second probe win=
dow; the group is then ordered by weight alone=2E
 
-  The probe is current=
ly sent without control-channel wrapping, so it only
-  works against a ser=
ver configured without ``--tls-auth``,
-  ``--tls-crypt`` or ``--tls-crypt-=
v2``=2E
+  The probe carries the same control-channel wrapping as a normal
=
+  connection (``--tls-auth`` or ``--tls-crypt``, when configured)=2E With
=
+  ``--tls-crypt-v2`` the remotes are left in their configured order,
+  be=
cause the server cannot unwrap an out-of-band probe yet=2E
 
   Only UDP re=
motes are probed, and only when there are at least two
   remotes; remotes =
reached through a SOCKS proxy are not probed=2E The
   probes are sent from=
 one socket per address family, set up like the
   connection socket of the=
 first remote that can be probed; all probed
   remotes must therefore shar=
e its local bind settings (``--local``,
-  ``--lport``, ``--bind``), otherw=
ise probing is skipped and the
-  configured order is used=2E Remotes that =
answered are tried first, in the
-  order described above; all other remote=
s, including TCP ones, follow in
-  their configured order=2E Probing runs =
once per process, before the first
-  connection attempt; a reconnect or a =
SIGUSR1 restart does not probe again=2E
+  ``--lport``, ``--bind``) and con=
trol-channel key, otherwise probing is
+  skipped and the configured order =
is used=2E
+
+  Remotes that answered are tried first, in the order describ=
ed above;
+  all other remotes, including TCP ones, follow in their configu=
red
+  order=2E Probing runs once per process, before the first connection
=
+  attempt; a reconnect or a SIGUSR1 restart does not probe again=2E
 
   P=
robing delays the first connection attempt by up to one second, plus
   the=
 time needed to resolve each remote=2E A server answers only a few
diff --g=
it a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
index 276e21a=
=2E=2E2ac3faa 100644
--- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob=
_client=2Ec
@@ -29,6 +29,8 @@
 #include "oob_client=2Eh"
 #include "openvpn=
=2Eh"
 #include "oob=2Eh"
+#include "init=2Eh"
+#include "ssl=2Eh"
 #includ=
e "ssl_pkt=2Eh"
 #include "session_id=2Eh"
 #include "socket=2Eh"
@@ -69,9 =
+71,9 @@
     int round_start;  /* first transmission of the current round =
*/
     uint32_t id_base; /* random, so request_ids cannot be guessed */
  =
   /* What each probe is built from; only the request_id differs=2E */
+   =
 struct tls_auth_standalone *tas;
     struct session_id *client_sid;
     =
struct oob_probe_request req;
-    uint8_t packet[64];                /* th=
e probe being sent */
 #ifdef TARGET_ANDROID
     bool fd_protected[PROBE_A=
F_COUNT]; /* VPNService protect(), once per socket */
 #endif
@@ -85,20 +87=
,73 @@
     return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;
 }
 
-=
/* Build a plaintext probe request packet with the given request_id:
- *   =
[opcode | key_id=3D0] [client session id] [probe request TLV]
- * This is t=
he unauthenticated OOB wire format; adding tls-auth/tls-crypt
- * wrapping =
for the probe is a follow-up (it only works against a server with
- * no co=
ntrol-channel wrapping for now)=2E The result points into pc->packet:
- * s=
end it before building the next=2E */
+/* Build the standalone wrapping con=
text the probe is sent with, mirroring the
+ * one the server answers it wi=
th, keyed like ce, the entry every other probed
+ * remote was checked agai=
nst; without tls-auth/tls-crypt it stays in
+ * TLS_WRAP_NONE and the probe=
 goes out in plaintext=2E Returns NULL (and logs)
+ * for tls-crypt-v2, whi=
ch the probe cannot carry yet=2E */
+static struct tls_auth_standalone *
+o=
ob_probe_init_tls_auth_standalone(struct context *c, const struct connectio=
n_entry *ce,
+                                   struct gc_arena *gc)
+{
+ =
   /* tls-crypt-v2 wraps with a per-client key the server only learns from =
the
+     * wrapped client key (WKc) carried in the TLS handshake=2E An out=
-of-band
+     * probe carries no WKc, so the server cannot unwrap it; skip=
 probing rather
+     * than send something unverifiable=2E */
+    if (ce-=
>tls_crypt_v2_file)
+    {
+        msg(D_LOW, "server-probe: not supported=
 with tls-crypt-v2; using configured order");
+        return NULL;
+    }
=
+
+    /* options=2Ece is not mapped yet; options_postprocess_mutate_ce() h=
as already
+     * copied any global key into ce=2E Loaded again per-connec=
tion later=2E */
+    do_init_tls_wrap_key(c, ce);
+
+    struct tls_option=
s to;
+    CLEAR(to);
+    init_tls_wrap_ctx(&to=2Etls_wrap, ce, c->options=
=2Etls_client, &c->c1=2Eks, &c->c1=2Epid_persist);
+    to=2Ereplay_window =
=3D c->options=2Ereplay_window;
+    to=2Ereplay_time =3D c->options=2Erepl=
ay_time;
+
+    struct tls_auth_standalone *tas =3D tls_auth_standalone_ini=
t(&to, gc);
+
+    tls_init_control_channel_frame_parameters(&tas->frame, c=
e->tls_mtu);
+    tas->tls_wrap=2Ework =3D alloc_buf_gc(BUF_SIZE(&tas->fram=
e), gc);
+    tas->workbuf =3D alloc_buf_gc(BUF_SIZE(&tas->frame), gc);
+
+=
    return tas;
+}
+
+/* Release the probe's wrapping context and the key m=
aterial
+ * do_init_tls_wrap_key() loaded for it: do_init_crypto_tls_c1() l=
oads the same
+ * fields again later without freeing them first=2E */
+stat=
ic void
+oob_probe_free_wrap(struct context *c, struct tls_auth_standalone =
*tas)
+{
+    tls_auth_standalone_free(tas);
+    free_key_ctx_bi(&c->c1=2E=
ks=2Etls_wrap_key);
+    CLEAR(c->c1=2Eks=2Etls_wrap_key);
+    /* the raw =
key bytes too: do_init_crypto_tls_c1() may never load a key over
+     * th=
em, so they would otherwise stay resident for the process lifetime */
+    =
secure_memzero(&c->c1=2Eks=2Eoriginal_wrap_keydata, sizeof(c->c1=2Eks=2Eori=
ginal_wrap_keydata));
+}
+
+/* Build a wrapped probe request with the given=
 request_id=2E The result points
+ * into tas's work buffers: send it befor=
e building the next=2E */
 static bool
 oob_probe_build(struct probe_ctx *p=
c, uint32_t request_id, struct buffer *probe)
 {
+    uint8_t data[64];
+  =
  struct buffer payload;
+    buf_set_write(&payload, data, sizeof(data));
=
     pc->req=2Erequest_id =3D request_id;
-    buf_set_write(probe, pc->pac=
ket, sizeof(pc->packet));
-    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V=
1 << P_OPCODE_SHIFT);
-    return buf_write_u8(probe, header) && session_id=
_write(pc->client_sid, probe)
-           && oob_probe_request_write(probe,=
 &pc->req);
+    if (!oob_probe_request_write(&payload, &pc->req))
+    {
+=
        return false;
+    }
+    *probe =3D tls_wrap_oob_standalone(&pc->t=
as->tls_wrap, pc->tas, pc->client_sid, &payload);
+    return BLEN(probe) >=
 0;
 }
 
 /* Was addr already probed in the current round? */
@@ -127,6 +18=
2,7 @@
     struct buffer probe;
     if (!oob_probe_build(pc, pc->id_base =
+ (uint32_t)pc->n_sends, &probe))
     {
+        msg(D_LOW, "server-probe:=
 could not build probe packet");
         return false;
     }
     openvpn=
_gettimeofday(&s->sent_at, NULL);
@@ -201,6 +257,22 @@
            && str_e=
qual_or_both_null(port_a, port_b);
 }
 
+/* Do a and b wrap the control cha=
nnel with the same key (--tls-auth,
+ * --tls-crypt, --tls-crypt-v2 and key=
 direction)? Probes are wrapped with the
+ * first probeable entry's key, s=
o a server keyed differently could never answer
+ * them=2E */
+static bool=

+oob_probe_same_wrap(const struct connection_entry *a, const struct connec=
tion_entry *b)
+{
+    return str_equal_or_both_null(a->tls_auth_file, b->t=
ls_auth_file)
+           && a->tls_auth_file_inline =3D=3D b->tls_auth_fil=
e_inline
+           && a->key_direction =3D=3D b->key_direction
+         =
  && str_equal_or_both_null(a->tls_crypt_file, b->tls_crypt_file)
+        =
   && a->tls_crypt_file_inline =3D=3D b->tls_crypt_file_inline
+           =
&& str_equal_or_both_null(a->tls_crypt_v2_file, b->tls_crypt_v2_file)
+    =
       && a->tls_crypt_v2_file_inline =3D=3D b->tls_crypt_v2_file_inline;
+=
}
+
 /* Resolve the local bind address of ce's connection socket; NULL with=
 --nobind=2E
  * Fatal on failure, like the link socket=2E */
 static struc=
t addrinfo *
@@ -295,7 +367,7 @@
 /* Parse one received datagram as a probe=
 reply and, if valid and answering one
  * of the probes we sent, record th=
e reply in results=2E */
 static void
-oob_probe_handle_reply(const struct =
probe_ctx *pc, const uint8_t *data, int len,
+oob_probe_handle_reply(const =
struct probe_ctx *pc, uint8_t *data, int len,
                        const=
 struct openvpn_sockaddr *from, const struct oob_probe_target *targets,
   =
                     struct oob_probe_result *results, int n)
 {
@@ -307,7 =
+379,19 @@
 
     struct buffer buf;
     buf_set_read(&buf, data, (size_t)=
len);
-    buf_advance(&buf, 1 + SID_SIZE); /* skip opcode + server session=
 id */
+
+    /* Unwrap the reply with the same control-channel path the se=
rver used to
+     * wrap it: this verifies the tls-auth HMAC / decrypts tl=
s-crypt, and (in all
+     * modes) strips the opcode + server session id, =
leaving buf at the OOB
+     * message=2E read_control_auth() mutates the w=
rapping context, so we work on a
+     * per-packet copy (as tls_pre_decryp=
t_lite() does on the server)=2E The peer
+     * address is only used for l=
og messages, and tls_options only for
+     * tls-crypt-v2 metadata checks,=
 so both are passed as NULL=2E */
+    struct tls_wrap_ctx wrap =3D pc->tas=
->tls_wrap;
+    if (!read_control_auth(&buf, &wrap, NULL, NULL))
+    {
+ =
       return; /* not for us, or failed authentication */
+    }
 
     str=
uct oob_probe_reply reply;
     if (!oob_probe_reply_find(&buf, &reply))
@@=
 -537,11 +621,20 @@
             tmpl =3D ce;
             continue;
      =
   }
+        const char *differs =3D NULL;
         if (!oob_probe_same_bi=
nd(tmpl, ce, &c->options))
         {
-            msg(D_LOW, "server-probe=
: %s:%s binds differently from %s:%s;"
+            differs =3D "binds";
+ =
       }
+        else if (!oob_probe_same_wrap(tmpl, ce))
+        {
+    =
        differs =3D "wraps the control channel";
+        }
+        if (di=
ffers)
+        {
+            msg(D_LOW, "server-probe: %s:%s %s different=
ly from %s:%s;"
                        " not probing, using configured ord=
er",
-                ce->remote, ce->remote_port, tmpl->remote, tmpl->remo=
te_port);
+                ce->remote, ce->remote_port, differs, tmpl->remo=
te, tmpl->remote_port);
             gc_free(&gc);
             return;
   =
      }
@@ -553,12 +646,25 @@
         return;
     }
 
+    /* Wrapping co=
ntext for the probe (tls-auth/tls-crypt, or plaintext if
+     * neither)=
=2E NULL means this configuration cannot be probed; keep the
+     * config=
ured order=2E */
+    struct tls_auth_standalone *tas =3D oob_probe_init_tl=
s_auth_standalone(c, tmpl, &gc);
+    if (!tas)
+    {
+        gc_free(&gc=
);
+        return;
+    }
+
     struct probe_ctx pc =3D { =2Esd =3D { SOC=
KET_UNDEFINED, SOCKET_UNDEFINED } };
     struct oob_probe_target *targets =
=3D gc_malloc(sizeof(*targets) * l->len, true, &gc);
     struct oob_probe_=
result *results =3D gc_malloc(sizeof(*results) * l->len, true, &gc);
 
-   =
 /* Every probe carries the same session id and timestamp; each
-     * tra=
nsmission gets a request_id of its own=2E */
+    /* Every probe is a singl=
e probe request TLV, wrapped (or sent in
+     * plaintext) like any other =
control packet, with the client session id as
+     * the sender session id=
=2E Each transmission is built on its own, as each
+     * carries its own =
request_id=2E */
+    pc=2Etas =3D tas;
     pc=2Eclient_sid =3D &client_si=
d;
     pc=2Eid_base =3D (uint32_t)get_random();
     pc=2Ereq =3D (struct =
oob_probe_request){
@@ -566,8 +672,11 @@
         =2Eflags =3D 0,
     };
 =

-    msg(D_LOW, "server-probe: probing %d remote(s) with a %d ms window", =
l->len,
-        OOB_PROBE_WINDOW_MS);
+    const char *wrap_name =3D (tas-=
>tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? "tls-crypt"
+                   =
         : (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? "tls-auth"
+      =
                                                              : "none (plai=
ntext)";
+    msg(D_LOW, "server-probe: probing %d remote(s) with a %d ms w=
indow, control-channel wrapping: %s",
+        l->len, OOB_PROBE_WINDOW_MS,=
 wrap_name);
 
     /* Resolve every remote first, so only the address fami=
lies actually in use
      * get a probe socket=2E */
@@ -614,6 +723,7 @@
 =
        {
             freeaddrinfo(bind_local);
         }
+        oob_pr=
obe_free_wrap(c, tas);
         gc_free(&gc);
         return;
     }
@@ -7=
07,5 +817,6 @@
     msg(M_INFO, "server-probe: %d of %d probed remote(s) an=
swered; connecting best-first",
         responded, sent_count);
 
+    oob=
_probe_free_wrap(c, tas);
     gc_free(&gc);
 }

-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
Ge=
rrit-Change-Number: 1750
Gerrit-PatchSet: 29
Gerrit-Owner: stipa <lstipakov=
@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@mand=
elbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attenti=
on: plaisthos <arne-openvpn@rfc2549=2Eorg>

--dwso+s2c2zU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #29</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">oob: Wrap the client probe request with tls-auth/tls-crypt<br><br=
>The client --server-probe sent a plaintext probe request and parsed<br>rep=
lies by hand, so it only worked against a server with no<br>control-channel=
 wrapping=2E<br><br>Build a standalone wrapping context for the probe, mirr=
oring the<br>server&#39;s tls_auth_standalone, and send probes and unwrap r=
eplies through<br>the regular control-channel path (tls_wrap_oob_standalone=
() and<br>read_control_auth())=2E Replies are unwrapped on a per-packet cop=
y of the<br>context, as tls_pre_decrypt_lite() does=2E Each transmission is=
 wrapped on<br>its own, as each carries its own request_id; with tls-auth o=
r tls-crypt<br>that also gives each its own replay packet id=2E Without eit=
her, the<br>probe goes out in plaintext as before=2E<br><br>tls-crypt-v2 is=
 not supported yet: the server only learns the client<br>key from the WKc c=
arried in the TLS handshake, which an out-of-band<br>probe cannot provide=
=2E Such configurations skip probing and keep the<br>configured remote orde=
r=2E<br><br>The probe is wrapped with the key of the first remote we can pr=
obe --<br>the same entry the other probed remotes are compared against -- s=
o<br>probing is declined when another one of them is keyed differently=2E T=
he<br>key material loaded for the probe is released afterwards; init loads =
it<br>again for the connection=2E<br><br>Change-Id: I1f9d7b5a5ec19bf77c0c21=
2795f583c5ba4c03ac<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;=
<br>---<br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/oob_cli=
ent=2Ec<br>2 files changed, 141 insertions(+), 27 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/50/1750/29</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/doc/man-sections/client-options=2Erst =
b/doc/man-sections/client-options=2Erst</span><br><span>index 9835403=2E=2E=
f1f004f 100644</span><br><span>--- a/doc/man-sections/client-options=2Erst<=
/span><br><span>+++ b/doc/man-sections/client-options=2Erst</span><br><span=
>@@ -620,20 +620,23 @@</span><br><span>   priority group a candidate, since=
 replies only arrive within the</span><br><span>   one-second probe window;=
 the group is then ordered by weight alone=2E</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  The probe is currently sent wit=
hout control-channel wrapping, so it only</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  works against a server configured without ``--tls-aut=
h``,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--tls-crypt``=
 or ``--tls-crypt-v2``=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  The probe carries the same control-channel wrapping as a normal</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  connection (``--tls-a=
uth`` or ``--tls-crypt``, when configured)=2E With</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  ``--tls-crypt-v2`` the remotes are left in=
 their configured order,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  because the server cannot unwrap an out-of-band probe yet=2E</span><=
br><span> </span><br><span>   Only UDP remotes are probed, and only when th=
ere are at least two</span><br><span>   remotes; remotes reached through a =
SOCKS proxy are not probed=2E The</span><br><span>   probes are sent from o=
ne socket per address family, set up like the</span><br><span>   connection=
 socket of the first remote that can be probed; all probed</span><br><span>=
   remotes must therefore share its local bind settings (``--local``,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--lport``, ``--bind``),=
 otherwise probing is skipped and the</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  configured order is used=2E Remotes that answered are tri=
ed first, in the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ord=
er described above; all other remotes, including TCP ones, follow in</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  their configured order=2E =
Probing runs once per process, before the first</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  connection attempt; a reconnect or a SIGUSR1 re=
start does not probe again=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  ``--lport``, ``--bind``) and control-channel key, otherwise pro=
bing is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  skipped an=
d the configured order is used=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Rem=
otes that answered are tried first, in the order described above;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  all other remotes, includin=
g TCP ones, follow in their configured</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  order=2E Probing runs once per process, before the fir=
st connection</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  atte=
mpt; a reconnect or a SIGUSR1 restart does not probe again=2E</span><br><sp=
an> </span><br><span>   Probing delays the first connection attempt by up t=
o one second, plus</span><br><span>   the time needed to resolve each remot=
e=2E A server answers only a few</span><br><span>diff --git a/src/openvpn/o=
ob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index 276e21a=2E=
=2E2ac3faa 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><b=
r><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -29,6 +29,8 @@<=
/span><br><span> #include &quot;oob_client=2Eh&quot;</span><br><span> #incl=
ude &quot;openvpn=2Eh&quot;</span><br><span> #include &quot;oob=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;init=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;ssl=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span=
><br><span> #include &quot;session_id=2Eh&quot;</span><br><span> #include &=
quot;socket=2Eh&quot;</span><br><span>@@ -69,9 +71,9 @@</span><br><span>   =
  int round_start;  /* first transmission of the current round */</span><br=
><span>     uint32_t id_base; /* random, so request_ids cannot be guessed *=
/</span><br><span>     /* What each probe is built from; only the request_i=
d differs=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct tls_auth_standalone *tas;</span><br><span>     struct session_id *cl=
ient_sid;</span><br><span>     struct oob_probe_request req;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    uint8_t packet[64];             =
   /* the probe being sent */</span><br><span> #ifdef TARGET_ANDROID</span>=
<br><span>     bool fd_protected[PROBE_AF_COUNT]; /* VPNService protect(), =
once per socket */</span><br><span> #endif</span><br><span>@@ -85,20 +87,73=
 @@</span><br><span>     return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_=
AF_V4;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/* Build a plaintext probe request packet with the gi=
ven request_id:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   [=
opcode | key_id=3D0] [client session id] [probe request TLV]</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * This is the unauthenticated OOB w=
ire format; adding tls-auth/tls-crypt</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * wrapping for the probe is a follow-up (it only works aga=
inst a server with</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
no control-channel wrapping for now)=2E The result points into pc-&gt;packe=
t:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * send it before b=
uilding the next=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Build the standalone wrapping context the probe is sent with, mirrori=
ng the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * one the se=
rver answers it with, keyed like ce, the entry every other probed</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * remote was checked against=
; without tls-auth/tls-crypt it stays in</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * TLS_WRAP_NONE and the probe goes out in plaintext=
=2E Returns NULL (and logs)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * for tls-crypt-v2, which the probe cannot carry yet=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static struct tls_auth_stan=
dalone *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_i=
nit_tls_auth_standalone(struct context *c, const struct connection_entry *c=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                  struct gc_arena *gc)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* tls-crypt-v2 wraps with a per-client key the server only learns fro=
m the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * wrapped=
 client key (WKc) carried in the TLS handshake=2E An out-of-band</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * probe carries no WKc, s=
o the server cannot unwrap it; skip probing rather</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * than send something unverifiable=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;tls=
_crypt_v2_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW,=
 &quot;server-probe: not supported with tls-crypt-v2; using configured orde=
r&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* options=2Ece is not mapped yet; op=
tions_postprocess_mutate_ce() has already</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * copied any global key into ce=2E Loaded again =
per-connection later=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    do_init_tls_wrap_key(c, ce);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct tls_options to;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    CLEAR(to);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    init_tls_wrap_ctx(&amp;to=2Etls_wrap, ce, c-&gt;options=2Etls_client=
, &amp;c-&gt;c1=2Eks, &amp;c-&gt;c1=2Epid_persist);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    to=2Ereplay_window =3D c-&gt;options=
=2Ereplay_window;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  to=2Ereplay_time =3D c-&gt;options=2Ereplay_time;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct tls_auth_standalone *tas =3D tls_auth_standalone_=
init(&amp;to, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_init_control=
_channel_frame_parameters(&amp;tas-&gt;frame, ce-&gt;tls_mtu);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    tas-&gt;tls_wrap=2Ework =3D =
alloc_buf_gc(BUF_SIZE(&amp;tas-&gt;frame), gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    tas-&gt;workbuf =3D alloc_buf_gc(BUF_SIZE(&=
amp;tas-&gt;frame), gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tas=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Release the probe&#39;s wrapping context and the key=
 material</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * do_init=
_tls_wrap_key() loaded for it: do_init_crypto_tls_c1() loads the same</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * fields again later wit=
hout freeing them first=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+oob_probe_free_wrap(struct context *c, struct tls_auth_standalone *tas)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    tls_auth_standalone_free(tas);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_key_ctx_bi(&amp=
;c-&gt;c1=2Eks=2Etls_wrap_key);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    CLEAR(c-&gt;c1=2Eks=2Etls_wrap_key);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* the raw key bytes too: do_init_cry=
pto_tls_c1() may never load a key over</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * them, so they would otherwise stay resident for t=
he process lifetime */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    secure_memzero(&amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata, sizeof(c-=
&gt;c1=2Eks=2Eoriginal_wrap_keydata));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Build a wrapped=
 probe request with the given request_id=2E The result points</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * into tas&#39;s work buffers: s=
end it before building the next=2E */</span><br><span> static bool</span><b=
r><span> oob_probe_build(struct probe_ctx *pc, uint32_t request_id, struct =
buffer *probe)</span><br><span> {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    uint8_t data[64];</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct buffer payload;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    buf_set_write(&amp;payload, data, sizeof(data));=
</span><br><span>     pc-&gt;req=2Erequest_id =3D request_id;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    buf_set_write(probe, pc-&gt;pac=
ket, sizeof(pc-&gt;packet));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPCODE_=
SHIFT);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return buf=
_write_u8(probe, header) &amp;&amp; session_id_write(pc-&gt;client_sid, pro=
be)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           &amp;&a=
mp; oob_probe_request_write(probe, &amp;pc-&gt;req);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!oob_probe_request_write(&amp;pay=
load, &amp;pc-&gt;req))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    *probe =3D tls_wra=
p_oob_standalone(&amp;pc-&gt;tas-&gt;tls_wrap, pc-&gt;tas, pc-&gt;client_si=
d, &amp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return BLEN(probe) &gt; 0;</span><br><span> }</span><br><span> </span><br=
><span> /* Was addr already probed in the current round? */</span><br><span=
>@@ -127,6 +182,7 @@</span><br><span>     struct buffer probe;</span><br><s=
pan>     if (!oob_probe_build(pc, pc-&gt;id_base + (uint32_t)pc-&gt;n_sends=
, &amp;probe))</span><br><span>     {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        msg(D_LOW, &quot;server-probe: could not build pr=
obe packet&quot;);</span><br><span>         return false;</span><br><span> =
    }</span><br><span>     openvpn_gettimeofday(&amp;s-&gt;sent_at, NULL);<=
/span><br><span>@@ -201,6 +257,22 @@</span><br><span>            &amp;&amp;=
 str_equal_or_both_null(port_a, port_b);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Do a and b wra=
p the control channel with the same key (--tls-auth,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * --tls-crypt, --tls-crypt-v2 and key di=
rection)? Probes are wrapped with the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * first probeable entry&#39;s key, so a server keyed dif=
ferently could never answer</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * them=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_pr=
obe_same_wrap(const struct connection_entry *a, const struct connection_ent=
ry *b)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return str_equal_or_both_nu=
ll(a-&gt;tls_auth_file, b-&gt;tls_auth_file)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+           &amp;&amp; a-&gt;tls_auth_file_inline =
=3D=3D b-&gt;tls_auth_file_inline</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+           &amp;&amp; a-&gt;key_direction =3D=3D b-&gt;key_di=
rection</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &=
amp;&amp; str_equal_or_both_null(a-&gt;tls_crypt_file, b-&gt;tls_crypt_file=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&a=
mp; a-&gt;tls_crypt_file_inline =3D=3D b-&gt;tls_crypt_file_inline</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; str_eq=
ual_or_both_null(a-&gt;tls_crypt_v2_file, b-&gt;tls_crypt_v2_file)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; a-&gt;=
tls_crypt_v2_file_inline =3D=3D b-&gt;tls_crypt_v2_file_inline;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> /* Resolve the local bind addre=
ss of ce&#39;s connection socket; NULL with --nobind=2E</span><br><span>  *=
 Fatal on failure, like the link socket=2E */</span><br><span> static struc=
t addrinfo *</span><br><span>@@ -295,7 +367,7 @@</span><br><span> /* Parse =
one received datagram as a probe reply and, if valid and answering one</spa=
n><br><span>  * of the probes we sent, record the reply in results=2E */</s=
pan><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-oob_probe_handle_reply(const struct probe_ctx *pc, const uint8_t *data=
, int len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe=
_handle_reply(const struct probe_ctx *pc, uint8_t *data, int len,</span><br=
><span>                        const struct openvpn_sockaddr *from, const s=
truct oob_probe_target *targets,</span><br><span>                        st=
ruct oob_probe_result *results, int n)</span><br><span> {</span><br><span>@=
@ -307,7 +379,19 @@</span><br><span> </span><br><span>     struct buffer bu=
f;</span><br><span>     buf_set_read(&amp;buf, data, (size_t)len);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    buf_advance(&amp;buf, 1 + =
SID_SIZE); /* skip opcode + server session id */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* Unwrap the reply with the same control-channel path the se=
rver used to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
wrap it: this verifies the tls-auth HMAC / decrypts tls-crypt, and (in all<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * modes) strips=
 the opcode + server session id, leaving buf at the OOB</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * message=2E read_control_auth() m=
utates the wrapping context, so we work on a</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * per-packet copy (as tls_pre_decrypt_lite() =
does on the server)=2E The peer</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * address is only used for log messages, and tls_options o=
nly for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * tls-c=
rypt-v2 metadata checks, so both are passed as NULL=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct tls_wrap_ctx wrap =3D pc-&=
gt;tas-&gt;tls_wrap;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!read_control_auth(&amp;buf, &amp;wrap, NULL, NULL))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return; /* not for us, or failed authen=
tication */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span> </span><br><span>     struct oob_probe_reply reply;</span><b=
r><span>     if (!oob_probe_reply_find(&amp;buf, &amp;reply))</span><br><sp=
an>@@ -537,11 +621,20 @@</span><br><span>             tmpl =3D ce;</span><b=
r><span>             continue;</span><br><span>         }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        const char *differs =3D NULL;=
</span><br><span>         if (!oob_probe_same_bind(tmpl, ce, &amp;c-&gt;opt=
ions))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            msg(D_LOW, &quot;server-probe: %s:%s binds differen=
tly from %s:%s;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            differs =3D &quot;binds&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        else if (!oob_probe_same_wrap(tmpl, ce))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            differs =3D &quot;wraps the c=
ontrol channel&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (differs)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D=
_LOW, &quot;server-probe: %s:%s %s differently from %s:%s;&quot;</span><br>=
<span>                        &quot; not probing, using configured order&qu=
ot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                c=
e-&gt;remote, ce-&gt;remote_port, tmpl-&gt;remote, tmpl-&gt;remote_port);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ce-&g=
t;remote, ce-&gt;remote_port, differs, tmpl-&gt;remote, tmpl-&gt;remote_por=
t);</span><br><span>             gc_free(&amp;gc);</span><br><span>        =
     return;</span><br><span>         }</span><br><span>@@ -553,12 +646,25 =
@@</span><br><span>         return;</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Wrapping co=
ntext for the probe (tls-auth/tls-crypt, or plaintext if</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * neither)=2E NULL means this con=
figuration cannot be probed; keep the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * configured order=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct tls_auth_standalone *tas =3D oob_pro=
be_init_tls_auth_standalone(c, tmpl, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!tas)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>     struct probe_ctx pc =3D { =2Esd =3D { SOCKET_UNDEFINED, SO=
CKET_UNDEFINED } };</span><br><span>     struct oob_probe_target *targets =
=3D gc_malloc(sizeof(*targets) * l-&gt;len, true, &amp;gc);</span><br><span=
>     struct oob_probe_result *results =3D gc_malloc(sizeof(*results) * l-&=
gt;len, true, &amp;gc);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* Every probe carries the same session id and time=
stamp; each</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * tra=
nsmission gets a request_id of its own=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* Every probe is a single probe request TLV, =
wrapped (or sent in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * plaintext) like any other control packet, with the client session id=
 as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the sende=
r session id=2E Each transmission is built on its own, as each</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * carries its own request_i=
d=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pc=2Etas=
 =3D tas;</span><br><span>     pc=2Eclient_sid =3D &amp;client_sid;</span><=
br><span>     pc=2Eid_base =3D (uint32_t)get_random();</span><br><span>    =
 pc=2Ereq =3D (struct oob_probe_request){</span><br><span>@@ -566,8 +672,11=
 @@</span><br><span>         =2Eflags =3D 0,</span><br><span>     };</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_=
LOW, &quot;server-probe: probing %d remote(s) with a %d ms window&quot;, l-=
&gt;len,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        OOB_P=
ROBE_WINDOW_MS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char *wrap_name =3D (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT) =
 ? &quot;tls-crypt&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                            : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP=
_AUTH) ? &quot;tls-auth&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                                                 =
   : &quot;none (plaintext)&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msg(D_LOW, &quot;server-probe: probing %d remote(s) with=
 a %d ms window, control-channel wrapping: %s&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        l-&gt;len, OOB_PROBE_WINDOW_MS, w=
rap_name);</span><br><span> </span><br><span>     /* Resolve every remote f=
irst, so only the address families actually in use</span><br><span>      * =
get a probe socket=2E */</span><br><span>@@ -614,6 +723,7 @@</span><br><spa=
n>         {</span><br><span>             freeaddrinfo(bind_local);</span><=
br><span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        oob_probe_free_wrap(c, tas);</span><br><span>         gc_free(&amp;=
gc);</span><br><span>         return;</span><br><span>     }</span><br><spa=
n>@@ -707,5 +817,6 @@</span><br><span>     msg(M_INFO, &quot;server-probe: =
%d of %d probed remote(s) answered; connecting best-first&quot;,</span><br>=
<span>         responded, sent_count);</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    oob_probe_free_wrap(c, tas);</span=
><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br></pre><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=
=3Demail">change 1750</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1750?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1750 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 29 </div>
<div style=3D"display:none"> Gerrit-O=
wner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--dwso+s2c2zU=--


--===============6613079610014639758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6613079610014639758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6613079610014639758==--

