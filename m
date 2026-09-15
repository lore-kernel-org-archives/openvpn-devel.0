Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22C3C88E75
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 06:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cQtYDMVJYP/TgSILaoYBYiCEE4OhoQbT/5uzqqH32qI=; b=Usc05B5seSjoUicgZdr5dnf2ZN
	v0eid+i7G2WsrrScIBNJcOEGI9eyzHv4ZpyUDVQueYZx9CzLnSzowy1FhTbrIMH+5iOqPBuisi+v7
	b+3+5WpzExAWFkCTsD9dYlmBIMftc1TP7lGZYS3TG6ANC37rQlq3cubGr8iofakoXcvg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6Ma7-0001WZ-Rw;
	Tue, 15 Sep 2026 06:23:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6Ma6-0001Us-3n
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 06:23:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BBvnhsWlP0+tknxzWhqHe3i2SzhDcoxHlM/aN1KJM64=; b=AdLDeJDiFj5TjQcVbLCdj0LTg/
 thJVh0q6Wsa/HIst43h2taca9GzvYC8wbfKPzj+KnTen/9G1UCguWgQGFkvRaYJUqMvJ6LYwCIgA2
 hqlJ0DFOfiTo4FKVci5yR2q6abZBlxmJI3WHNiG+u33ZV2O2Wg9Pu2eiiWRyZlKexH1I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BBvnhsWlP0+tknxzWhqHe3i2SzhDcoxHlM/aN1KJM64=; b=D
 vRgPevQSMxQ4Yya+WtWZJRLSUD1PQRR348/XkcOOrHRnYugN1CP6MNVuslz7bTQktcc9SX/7/lLn9
 uYiPNtT+Ik6OJJi4gmMox3yovHrtngHlnNDQjj1qlBvnB/uahUtjlApqGuMnEOO3xvO8dYLnBaZCG
 59Z+/Yp5YQVyFdqc=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6Ma2-00041R-PB for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 06:23:50 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e69b9e16aso26697455e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 23:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789453420; x=1790058220; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BBvnhsWlP0+tknxzWhqHe3i2SzhDcoxHlM/aN1KJM64=;
 b=X42FUdKBlbJQYuvYCb437wjE/9Hbp9wCZyW9XXfzBCArU2gssi0KW5O9PN7XrkwKyd
 Om/Pcv/8lTZ8/BQX6Fkf5jMTe4m6O6IBx7ZVSG92zQ4uZvDCKir1f7uQPZtE8TtrKliw
 hevCMtYozCVkfZ0PpEjWHl6ani8cPY5UTa+USEBEsHHySWV4vHs4cmiwx8Lbh//hIsrs
 sikyjFU1V+2Snk8in0+Q3pRQfsr8wFB/dTdvCgRoA0btlEammBCmQiM4eZPJ29aBZ1+r
 Y4dG0LvNglKCWhWF46ePRBgLR9MizdsNckDdQvFy3esEwppldcKXvI605cPApdwwaKAV
 1DVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789453420; x=1790058220;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BBvnhsWlP0+tknxzWhqHe3i2SzhDcoxHlM/aN1KJM64=;
 b=M9tnyri0oeWvAm4BTrKgzYgY0I0b/b2XmJaQ40qCWQY2G+otEdJRu/GGeNvpHWkcrU
 wieT2KLALGBjGBo8fTc099mRSoemSYF0iok+xTBTOeN2+7LAyC2z+jfrhjVS4N4n/NoW
 vXMnS5D/JYnB73kkRD14Ot4GwZ3MWtSTdIjIzMuEEcmFJCiSUdMcuBkSBWozAi7gAD3U
 voxBNu3gP3qVSqlibgWC8JpMwejOx9L5ZJc+53JI5n7ymZVudZdhn2kWs2jblIQ+2BBf
 9fe7OKEteRaCJFW1wYlul2Tlsq/T0N117maWylRFCzlAVP6r7/KuYCkhAHxP+cXgoYi4
 JJRQ==
X-Gm-Message-State: AFuF++lRLjDgzz1MOsiqK9Zmatek9XtRAAz9FLst2LO5T9ekgh4sG+0F
 pdH6mudCoVIvzAd8UdJMYHAa6kIhTDz6HR81OlfwroEq1LDFC961C1qQssYPk7nVHoj1BMdwHNt
 sIDMr1TGzTq9KNwgndHqKqQ3ZTVUClYFp3IccPjtJfyR/IR0C2+PNR+zMii4PaF3LF2Tn
X-Gm-Gg: AYBFou2ZcL/4PaCL4hS0UzsrNaO52l6EuR+IAuVWLorL1BQkXJHBWGSbaBJd5YkHuF0
 +J6qTaTkiPVX/elackthZK7J/71c/kB7YFtK11KtpX73RMj59sNrw6wLtyHQcWboBrpf5A0TKIT
 IAlIfnaWyADX3arT7mrmsUE7oWPMlTOGeMUNJ3W8kF6LnFj1O5GaLjUPtCr7GTknCzSSdHCu94M
 036J1g7IOERbtafzNUAeXC07HULR1KIX1ObH5rwSSxzwwPgkrs4h5sdpIO1AnU3WtKbhE93/6Mo
 bmD8jacorBUsZnwl5sXPFADrGRBJWJsUl99by0G8dX3Hu/RHP0JZZOQOcL9QE9sRKUJyzsEFNf3
 aGWQvYAmoX26agfCi7i3Pb15P4AZPPooIsXf8TdTL+q+7C7ow6UVrgfC79gkGbo0eKf5dVHn5IF
 LkMvu+ek27MUFt9f5icb9qQZAS1acS9CTpxHN80h58+ek6eH/eSNFkbyVacR9LW97NitsVxgXtB
 Wc7JsF24saEip5x9hUh5hmTAq5ZonW60gmBFblrRyUR6XzG8wsl7yqHJcq2XQ2u/7JnrDm4ZprK
 3dka5AgGELrV0J8BRlXP6S2sh6hxBDvMVzdYxVpyR/7eeGCKECSrdQbisUAGTw==
X-Received: by 2002:a05:600c:620e:b0:49c:fa21:1c89 with SMTP id
 5b1f17b1804b1-49e7a69c01fmr79358125e9.30.1789453419914; 
 Mon, 14 Sep 2026 23:23:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7ef6bbdasm34671055e9.4.2026.09.14.23.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 23:23:39 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 06:23:31 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
X-Gerrit-Change-Number: 1750
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1750?usp=email>
X-Gerrit-Commit: d0fffc509e1a69b7d24ec755451a4d8a8acb23e2
In-Reply-To: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxZjlkN2I1YTVlYzE5YmY3N2MwYzIxMjc5NWY1ODNjNWJhNGMwM2FjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5dead22d21dca4a8fbbf9e76c9797beb240b3d9e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6Ma2-00041R-PB
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3514520186520465092=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3514520186520465092==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6EPXKO2hFfY="; charset=UTF-8

--6EPXKO2hFfY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail

to look a=
t the new patch set (#21)=2E

The following approvals got outdated and were=
 removed:
Code-Review+1 by ralf_lici


Change subject: oob: Wrap the client=
 SERVER_PROBE with tls-auth/tls-crypt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

oob: Wrap the client SERVER_PROBE with tls-auth/t=
ls-crypt

The client --server-probe previously sent a plaintext SERVER_PROB=
E and
parsed replies by hand, so it only worked against a server with no
co=
ntrol-channel wrapping=2E Build a standalone wrapping context for the
probe=
 (mirroring the server's tls_auth_standalone) and route both the
outgoing p=
robe and the incoming replies through the same control-channel
path the res=
t of the code uses:

  - tls_wrap_oob_standalone() wraps the probe payload,=
 applying the
    tls-auth HMAC or tls-crypt encryption (or nothing, when n=
either is
    configured)=2E
  - read_control_auth() unwraps each reply, ve=
rifying the HMAC /
    decrypting and stripping the opcode + session id, on=
 a per-packet
    copy of the wrapping context (as tls_pre_decrypt_lite() d=
oes)=2E It
    decrypts in place, so oob_probe_handle_reply() now takes a m=
utable
    buffer=2E

With neither tls-auth nor tls-crypt configured the co=
ntext stays in
TLS_WRAP_NONE and the on-wire probe is byte-for-byte identic=
al to
before, so the plaintext case is unchanged=2E

tls-crypt-v2 is not su=
pported yet: the server only learns the client key
from the WKc carried in =
the TLS handshake, which an out-of-band probe
cannot provide=2E Such config=
urations skip probing and keep the configured
remote order=2E

The probe is=
 wrapped with the key of the first remote we can probe --
the same entry th=
e other probed remotes are compared against -- so
probing is declined when =
another one of them is keyed differently=2E The
key material loaded for the=
 probe is released afterwards; init loads it
again for the connection=2E

C=
hange-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
Signed-off-by: Lev Stip=
akov <lev@openvpn=2Enet>
---
M doc/man-sections/client-options=2Erst
M src/=
openvpn/oob_client=2Ec
2 files changed, 177 insertions(+), 41 deletions(-)
=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/50/175=
0/21

diff --git a/doc/man-sections/client-options=2Erst b/doc/man-sections=
/client-options=2Erst
index 766e3bc=2E=2E8b6bb2f 100644
--- a/doc/man-secti=
ons/client-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -61=
7,19 +617,21 @@
   server advertising :code:`0` asks to be considered only =
while it ties
   the fastest of its priority group, without constraining th=
e others=2E
 
-  The probe is currently sent without control-channel wrappi=
ng, so it only
-  works against a server configured without ``--tls-auth``,=

-  ``--tls-crypt`` or ``--tls-crypt-v2``=2E
+  The probe carries the same =
control-channel wrapping as a normal
+  connection (``--tls-auth`` or ``--t=
ls-crypt``, when configured)=2E With
+  ``--tls-crypt-v2`` the remotes are =
left in their configured order,
+  because the server cannot unwrap an out-=
of-band probe yet=2E
 
   Only UDP remotes are probed, and only when there =
are at least two
   remotes; remotes reached through a SOCKS proxy are not =
probed=2E All
   probed remotes must share the local bind settings (``--loc=
al``,
-  ``--lport``, ``--bind``) of the first one among them, since a sing=
le
-  socket per address family carries the probes; otherwise probing is
- =
 skipped and the configured order is used=2E Remotes that answered are trie=
d first, in the
-  order described above; all other remotes, including TCP =
ones, follow in
-  their configured order=2E Probing runs once, before the =
first connection
-  attempt; a restart does not probe again=2E
+  ``--lport=
``, ``--bind``) and the control-channel key of the first one
+  among them,=
 since a single socket per address family carries the
+  probes; otherwise =
probing is skipped and the configured order is used=2E
+  Remotes that answ=
ered are tried first, in the order described above;
+  all other remotes, i=
ncluding TCP ones, follow in their configured
+  order=2E Probing runs once=
, before the first connection attempt; a
+  restart does not probe again=2E=

 
   Probing delays the first connection attempt by up to one second, plus=

   the time needed to resolve each remote=2E A server only answers a probe=

diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
index=
 61e2602=2E=2E5a3042a 100644
--- a/src/openvpn/oob_client=2Ec
+++ b/src/ope=
nvpn/oob_client=2Ec
@@ -29,6 +29,8 @@
 #include "oob_client=2Eh"
 #include =
"openvpn=2Eh"
 #include "oob=2Eh"
+#include "init=2Eh"
+#include "ssl=2Eh"
=
 #include "ssl_pkt=2Eh"
 #include "session_id=2Eh"
 #include "socket=2Eh"
@=
@ -79,21 +81,78 @@
     return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_A=
F_V4;
 }
 
-/* Build a plaintext SERVER_PROBE packet:
- *   [opcode | key_i=
d=3D0] [client session id] [SERVER_PROBE message]
- * This is the unauthent=
icated OOB wire format; adding tls-auth/tls-crypt
- * wrapping for the prob=
e is a follow-up (it only works against a server with
- * no control-channe=
l wrapping for now)=2E */
-static bool
-oob_probe_build_packet(struct buffe=
r *buf, const struct session_id *client_sid)
+static bool oob_probe_eligibl=
e(const struct connection_entry *ce);
+
+/* Build a standalone control-chan=
nel wrapping context for the probe, mirroring
+ * the tls_auth_standalone t=
he server uses to answer it=2E With neither tls-auth
+ * nor tls-crypt conf=
igured the context stays in TLS_WRAP_NONE and the probe is
+ * sent in plai=
ntext, exactly as before; with either configured the probe is
+ * authentic=
ated/encrypted like any other control packet=2E Returns NULL (and
+ * logs)=
 for configurations the probe cannot wrap yet, in which case the caller
+ *=
 skips probing and keeps the configured remote order=2E */
+static struct t=
ls_auth_standalone *
+oob_probe_init_tls_auth_standalone(struct context *c,=
 struct gc_arena *gc)
 {
-    const struct oob_probe_parameter param =3D {
=
-        =2Etimestamp =3D (uint64_t)now,
-        =2Eflags =3D 0,
-    };
-=
    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
-    =
return buf_write_u8(buf, header) && session_id_write(client_sid, buf)
-    =
       && oob_server_probe_write(buf, &param);
+    /* Wrap with the first =
entry we can actually probe: that is the entry every
+     * other probed r=
emote is checked against, so the key on the wire is the one
+     * they we=
re checked for=2E Falls back to entry 0 when nothing is probeable,
+     * =
in which case the caller bails out before anything is sent=2E */
+    const=
 struct connection_list *l =3D c->options=2Econnection_list;
+    const str=
uct connection_entry *ce =3D l->array[0];
+    for (int i =3D 0; i < l->len=
; i++)
+    {
+        if (oob_probe_eligible(l->array[i]))
+        {
+   =
         ce =3D l->array[i];
+            break;
+        }
+    }
+
+    /=
* tls-crypt-v2 wraps with a per-client key the server only learns from the
=
+     * wrapped client key (WKc) carried in the TLS handshake=2E An out-of-=
band
+     * probe carries no WKc, so the server cannot unwrap it; skip pro=
bing rather
+     * than send something unverifiable=2E */
+    if (ce->tls=
_crypt_v2_file)
+    {
+        msg(D_LOW, "server-probe: not supported wit=
h tls-crypt-v2; using configured order");
+        return NULL;
+    }
+
+ =
   /* Load the tls-auth/tls-crypt key material into c->c1=2Eks (a no-op if =
neither
+     * is configured)=2E This is run again per-connection later; c=
alling it early
+     * here is harmless=2E */
+    do_init_tls_wrap_key(c,=
 ce);
+
+    struct tls_options to;
+    CLEAR(to);
+    init_tls_wrap_ctx(=
&to=2Etls_wrap, ce, c->options=2Etls_client, &c->c1=2Eks, &c->c1=2Epid_pers=
ist);
+    to=2Ereplay_window =3D c->options=2Ereplay_window;
+    to=2Erep=
lay_time =3D c->options=2Ereplay_time;
+
+    struct tls_auth_standalone *t=
as =3D tls_auth_standalone_init(&to, gc);
+
+    /* Control-channel frame a=
nd work buffers, mirroring do_init_frame_tls()=2E */
+    tls_init_control_=
channel_frame_parameters(&tas->frame, ce->tls_mtu);
+    tas->tls_wrap=2Ewo=
rk =3D alloc_buf_gc(BUF_SIZE(&tas->frame), gc);
+    tas->workbuf =3D alloc=
_buf_gc(BUF_SIZE(&tas->frame), gc);
+
+    return tas;
+}
+
+/* Release the=
 probe's wrapping context and the key material
+ * do_init_tls_wrap_key() l=
oaded for it: do_init_crypto_tls_c1() loads the same
+ * fields again later=
 without freeing them first=2E */
+static void
+oob_probe_free_wrap(struct =
context *c, struct tls_auth_standalone *tas)
+{
+    tls_auth_standalone_fr=
ee(tas);
+    free_key_ctx_bi(&c->c1=2Eks=2Etls_wrap_key);
+    CLEAR(c->c1=
=2Eks=2Etls_wrap_key);
+    buf_clear(&c->c1=2Eks=2Etls_crypt_v2_wkc);
+   =
 free_buf(&c->c1=2Eks=2Etls_crypt_v2_wkc);
+    /* the raw key bytes too: d=
o_init_crypto_tls_c1() may never load a key over
+     * them, so they woul=
d otherwise stay resident for the process lifetime */
+    secure_memzero(&=
c->c1=2Eks=2Eoriginal_wrap_keydata, sizeof(c->c1=2Eks=2Eoriginal_wrap_keyda=
ta));
 }
 
 /* The local address and port ce's connection socket binds: its=
 first --local,
@@ -156,6 +215,22 @@
            && str_equal_or_both_null(=
port_a, port_b);
 }
 
+/* Do a and b wrap the control channel with the same=
 key (--tls-auth,
+ * --tls-crypt, --tls-crypt-v2 and key direction)? The o=
ne probe is wrapped with
+ * the first probeable entry's key, so a server k=
eyed differently could never
+ * answer it=2E */
+static bool
+oob_probe_sa=
me_wrap(const struct connection_entry *a, const struct connection_entry *b)=

+{
+    return str_equal_or_both_null(a->tls_auth_file, b->tls_auth_file)
=
+           && a->tls_auth_file_inline =3D=3D b->tls_auth_file_inline
+    =
       && a->key_direction =3D=3D b->key_direction
+           && str_equal=
_or_both_null(a->tls_crypt_file, b->tls_crypt_file)
+           && a->tls_c=
rypt_file_inline =3D=3D b->tls_crypt_file_inline
+           && str_equal_o=
r_both_null(a->tls_crypt_v2_file, b->tls_crypt_v2_file)
+           && a->t=
ls_crypt_v2_file_inline =3D=3D b->tls_crypt_v2_file_inline;
+}
+
 /* Resolv=
e the local bind address of ce's connection socket; NULL with --nobind=2E
 =
 * Fatal on failure, like the link socket=2E */
 static struct addrinfo *
@=
@ -250,9 +325,9 @@
 /* Parse one received datagram as a PROBE_REPLY and, if=
 valid and matching one
  * of the probes we sent, record the reply in resu=
lts=2E */
 static void
-oob_probe_handle_reply(const uint8_t *data, int len=
, const struct session_id *client_sid,
-                       const struct=
 openvpn_sockaddr *from, const struct oob_probe_target *targets,
-         =
              struct oob_probe_result *results, int n)
+oob_probe_handle_re=
ply(uint8_t *data, int len, const struct session_id *client_sid,
+         =
              const struct tls_wrap_ctx *base_wrap, const struct openvpn_so=
ckaddr *from,
+                       const struct oob_probe_target *target=
s, struct oob_probe_result *results, int n)
 {
     /* Need at least the op=
code byte and the session id=2E */
     if (len < 1 + (int)SID_SIZE || (dat=
a[0] >> P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)
@@ -262,7 +337,20 @@
 
     =
struct buffer buf;
     buf_set_read(&buf, data, (size_t)len);
-    buf_adv=
ance(&buf, 1 + SID_SIZE); /* skip opcode + server session id */
+
+    /* U=
nwrap the reply with the same control-channel path the server used to
+    =
 * wrap it: this verifies the tls-auth HMAC / decrypts tls-crypt, and (in a=
ll
+     * modes) strips the opcode + server session id, leaving buf at the=
 TLV
+     * payload=2E With no tls-auth/tls-crypt it just strips those hea=
der bytes, as
+     * before=2E read_control_auth() mutates the wrapping co=
ntext, so we work on a
+     * per-packet copy (as tls_pre_decrypt_lite() d=
oes on the server)=2E The peer
+     * address is only used for log message=
s, and tls_options only for
+     * tls-crypt-v2 metadata checks, so both a=
re passed as NULL=2E */
+    struct tls_wrap_ctx wrap =3D *base_wrap;
+    =
if (!read_control_auth(&buf, &wrap, NULL, NULL))
+    {
+        return; /*=
 not for us, or failed authentication */
+    }
 
     struct oob_probe_rep=
ly reply;
     if (!oob_client_reply_read(&buf, &reply))
@@ -314,8 +402,9 @=
@
  * matches a probe we sent=2E Returns true if every sent probe has been =
answered=2E */
 static bool
 oob_probe_receive_slice(const struct probe_ctx=
 *pc, const struct timeval *deadline,
-                        const struct=
 session_id *client_sid, const struct oob_probe_target *targets,
-         =
               struct oob_probe_result *results, int n, int outstanding)
+ =
                       const struct session_id *client_sid, const struct tl=
s_wrap_ctx *wrap,
+                        const struct oob_probe_target *t=
argets, struct oob_probe_result *results, int n,
+                        i=
nt outstanding)
 {
     while (true)
     {
@@ -365,7 +454,7 @@
           =
                          (struct sockaddr *)&from, &fromlen);
            =
 if (len > 0)
             {
-                oob_probe_handle_reply(data, =
len, client_sid, &from, targets, results, n);
+                oob_probe_ha=
ndle_reply(data, len, client_sid, wrap, &from, targets, results, n);
      =
       }
         }
         if (oob_count_answered(targets, results, n) >=
=3D outstanding)
@@ -418,8 +507,8 @@
  * once the window elapses or every s=
ent probe has been answered=2E */
 static void
 oob_probe_collect(struct pr=
obe_ctx *pc, const struct buffer *probe,
-                  const struct se=
ssion_id *client_sid, struct oob_probe_target *targets,
-                  =
struct oob_probe_result *results, int n,
+                  const struct se=
ssion_id *client_sid, const struct tls_wrap_ctx *wrap,
+                  s=
truct oob_probe_target *targets, struct oob_probe_result *results, int n,
 =
                  const struct signal_info *sig)
 {
     /* number of probe=
s we actually sent: stop early once they all answer */
@@ -444,7 +533,7 @@
=
             deadline=2Etv_usec -=3D 1000000;
         }
 
-        if (oob=
_probe_receive_slice(pc, &deadline, client_sid, targets, results, n, want)
=
+        if (oob_probe_receive_slice(pc, &deadline, client_sid, wrap, targe=
ts, results, n, want)
             || sig->signal_received)
         {
    =
         return; /* all answered, or we are being told to stop */
@@ -487,6=
 +576,16 @@
 
     struct gc_arena gc =3D gc_new();
 
+    /* Wrapping cont=
ext for the probe (tls-auth/tls-crypt, or plaintext if
+     * neither)=2E =
NULL means this configuration cannot be probed; keep the
+     * configured=
 order=2E */
+    struct tls_auth_standalone *tas =3D oob_probe_init_tls_au=
th_standalone(c, &gc);
+    if (!tas)
+    {
+        gc_free(&gc);
+      =
  return;
+    }
+
     /* A single random session id identifies all of our=
 probes; servers echo it
      * back in the reply's peer_session_id, letti=
ng us reject spoofed replies=2E */
     struct session_id client_sid;
@@ -5=
08,11 +607,21 @@
             tmpl =3D ce;
             continue;
         =
}
+        const char *differs =3D NULL;
         if (!oob_probe_same_bind(=
tmpl, ce, &c->options))
         {
-            msg(D_LOW, "server-probe: %=
s:%s binds differently from %s:%s;"
+            differs =3D "binds";
+    =
    }
+        else if (!oob_probe_same_wrap(tmpl, ce))
+        {
+       =
     differs =3D "wraps the control channel";
+        }
+        if (diffe=
rs)
+        {
+            msg(D_LOW, "server-probe: %s:%s %s differently =
from %s:%s;"
                        " not probing, using configured order"=
,
-                ce->remote, ce->remote_port, tmpl->remote, tmpl->remote_=
port);
+                ce->remote, ce->remote_port, differs, tmpl->remote,=
 tmpl->remote_port);
+            oob_probe_free_wrap(c, tas);
            =
 gc_free(&gc);
             return;
         }
@@ -520,6 +629,7 @@
     if =
(!tmpl)
     {
         msg(D_LOW, "server-probe: no remote can be probed; =
using configured order");
+        oob_probe_free_wrap(c, tas);
         gc=
_free(&gc);
         return;
     }
@@ -528,17 +638,39 @@
     struct oob_p=
robe_target *targets =3D gc_malloc(sizeof(*targets) * l->len, true, &gc);
 =
    struct oob_probe_result *results =3D gc_malloc(sizeof(*results) * l->le=
n, true, &gc);
 
-    struct buffer probe =3D alloc_buf_gc(256, &gc);
-    =
if (!oob_probe_build_packet(&probe, &client_sid))
+    /* Build the probe o=
nce and reuse the same bytes for every remote and for
+     * resends: the =
SERVER_PROBE payload is a single probe_parameter TLV, wrapped
+     * (or s=
ent in plaintext) like any other control packet=2E The client session
+    =
 * id is prepended as the sender session id=2E */
+    struct buffer payloa=
d =3D alloc_buf_gc(64, &gc);
+    const struct oob_probe_parameter param =
=3D {
+        =2Etimestamp =3D (uint64_t)now,
+        =2Eflags =3D 0,
+  =
  };
+    if (!oob_server_probe_write(&payload, &param))
     {
-        ms=
g(D_LOW, "server-probe: could not build probe packet; using configured orde=
r");
+        msg(D_LOW, "server-probe: could not build probe payload; usin=
g configured order");
         oob_probe_sockets_close(&pc);
+        oob_p=
robe_free_wrap(c, tas);
         gc_free(&gc);
         return;
     }
 
- =
   msg(D_LOW, "server-probe: probing %d remote(s) with a %d ms window", l->=
len,
-        OOB_PROBE_WINDOW_MS);
+    struct buffer probe =3D tls_wrap_o=
ob_standalone(&tas->tls_wrap, tas, &client_sid, &payload);
+    if (!BLEN(&=
probe))
+    {
+        msg(D_LOW, "server-probe: could not wrap probe pack=
et; using configured order");
+        oob_probe_sockets_close(&pc);
+     =
   oob_probe_free_wrap(c, tas);
+        gc_free(&gc);
+        return;
+  =
  }
+
+    const char *wrap_name =3D (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_=
CRYPT)  ? "tls-crypt"
+                            : (tas->tls_wrap=2Emode =
=3D=3D TLS_WRAP_AUTH) ? "tls-auth"
+                                       =
                             : "none (plaintext)";
+    msg(D_LOW, "server-=
probe: probing %d remote(s) with a %d ms window, control-channel wrapping: =
%s",
+        l->len, OOB_PROBE_WINDOW_MS, wrap_name);
 
     /* Resolve ev=
ery remote first, so only the address families actually in use
      * get =
a probe socket=2E */
@@ -585,6 +717,7 @@
         {
             freeaddrin=
fo(bind_local);
         }
+        oob_probe_free_wrap(c, tas);
         g=
c_free(&gc);
         return;
     }
@@ -646,7 +779,7 @@
 
     if (sent_co=
unt > 0)
     {
-        oob_probe_collect(&pc, &probe, &client_sid, target=
s, results, l->len,
+        oob_probe_collect(&pc, &probe, &client_sid, &t=
as->tls_wrap, targets, results, l->len,
                           c->sig);=

     }
     oob_probe_sockets_close(&pc);
@@ -694,5 +827,6 @@
     msg(M_I=
NFO, "server-probe: %d of %d probed remote(s) answered; connecting best-fir=
st",
         responded, sent_count);
 
+    oob_probe_free_wrap(c, tas);
 =
    gc_free(&gc);
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1750?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
Gerrit-Change-Number: 1750
Ge=
rrit-PatchSet: 21
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Review=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf=
@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-A=
ttention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipak=
ov@gmail=2Ecom>

--6EPXKO2hFfY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #21</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review+1 by ralf=
_lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">oob: Wrap the client SERVER_PROBE with tls-auth/tls-=
crypt<br><br>The client --server-probe previously sent a plaintext SERVER_P=
ROBE and<br>parsed replies by hand, so it only worked against a server with=
 no<br>control-channel wrapping=2E Build a standalone wrapping context for =
the<br>probe (mirroring the server&#39;s tls_auth_standalone) and route bot=
h the<br>outgoing probe and the incoming replies through the same control-c=
hannel<br>path the rest of the code uses:<br><br>  - tls_wrap_oob_standalon=
e() wraps the probe payload, applying the<br>    tls-auth HMAC or tls-crypt=
 encryption (or nothing, when neither is<br>    configured)=2E<br>  - read_=
control_auth() unwraps each reply, verifying the HMAC /<br>    decrypting a=
nd stripping the opcode + session id, on a per-packet<br>    copy of the wr=
apping context (as tls_pre_decrypt_lite() does)=2E It<br>    decrypts in pl=
ace, so oob_probe_handle_reply() now takes a mutable<br>    buffer=2E<br><b=
r>With neither tls-auth nor tls-crypt configured the context stays in<br>TL=
S_WRAP_NONE and the on-wire probe is byte-for-byte identical to<br>before, =
so the plaintext case is unchanged=2E<br><br>tls-crypt-v2 is not supported =
yet: the server only learns the client key<br>from the WKc carried in the T=
LS handshake, which an out-of-band probe<br>cannot provide=2E Such configur=
ations skip probing and keep the configured<br>remote order=2E<br><br>The p=
robe is wrapped with the key of the first remote we can probe --<br>the sam=
e entry the other probed remotes are compared against -- so<br>probing is d=
eclined when another one of them is keyed differently=2E The<br>key materia=
l loaded for the probe is released afterwards; init loads it<br>again for t=
he connection=2E<br><br>Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03a=
c<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M doc/=
man-sections/client-options=2Erst<br>M src/openvpn/oob_client=2Ec<br>2 file=
s changed, 177 insertions(+), 41 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/50/1750/21</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/doc/man-sections/client-options=2Erst b/doc/man-section=
s/client-options=2Erst</span><br><span>index 766e3bc=2E=2E8b6bb2f 100644</s=
pan><br><span>--- a/doc/man-sections/client-options=2Erst</span><br><span>+=
++ b/doc/man-sections/client-options=2Erst</span><br><span>@@ -617,19 +617,=
21 @@</span><br><span>   server advertising :code:`0` asks to be considered=
 only while it ties</span><br><span>   the fastest of its priority group, w=
ithout constraining the others=2E</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  The probe is currently sent without contr=
ol-channel wrapping, so it only</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  works against a server configured without ``--tls-auth``,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--tls-crypt`` or ``--tl=
s-crypt-v2``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Th=
e probe carries the same control-channel wrapping as a normal</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  connection (``--tls-auth`` or `=
`--tls-crypt``, when configured)=2E With</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  ``--tls-crypt-v2`` the remotes are left in their con=
figured order,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  bec=
ause the server cannot unwrap an out-of-band probe yet=2E</span><br><span> =
</span><br><span>   Only UDP remotes are probed, and only when there are at=
 least two</span><br><span>   remotes; remotes reached through a SOCKS prox=
y are not probed=2E All</span><br><span>   probed remotes must share the lo=
cal bind settings (``--local``,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  ``--lport``, ``--bind``) of the first one among them, since a s=
ingle</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  socket per add=
ress family carries the probes; otherwise probing is</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  skipped and the configured order is used=
=2E Remotes that answered are tried first, in the</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  order described above; all other remotes, inc=
luding TCP ones, follow in</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  their configured order=2E Probing runs once, before the first connec=
tion</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  attempt; a rest=
art does not probe again=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  ``--lport``, ``--bind``) and the control-channel key of the first=
 one</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  among them, s=
ince a single socket per address family carries the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  probes; otherwise probing is skipped an=
d the configured order is used=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  Remotes that answered are tried first, in the order describ=
ed above;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  all othe=
r remotes, including TCP ones, follow in their configured</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  order=2E Probing runs once, before =
the first connection attempt; a</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  restart does not probe again=2E</span><br><span> </span><br><=
span>   Probing delays the first connection attempt by up to one second, pl=
us</span><br><span>   the time needed to resolve each remote=2E A server on=
ly answers a probe</span><br><span>diff --git a/src/openvpn/oob_client=2Ec =
b/src/openvpn/oob_client=2Ec</span><br><span>index 61e2602=2E=2E5a3042a 100=
644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+++ b/=
src/openvpn/oob_client=2Ec</span><br><span>@@ -29,6 +29,8 @@</span><br><spa=
n> #include &quot;oob_client=2Eh&quot;</span><br><span> #include &quot;open=
vpn=2Eh&quot;</span><br><span> #include &quot;oob=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;init=2Eh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl=2Eh&qu=
ot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><span> #inc=
lude &quot;session_id=2Eh&quot;</span><br><span> #include &quot;socket=2Eh&=
quot;</span><br><span>@@ -79,21 +81,78 @@</span><br><span>     return (af =
=3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Build a pla=
intext SERVER_PROBE packet:</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *   [opcode | key_id=3D0] [client session id] [SERVER_PROBE message]=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This is the unauth=
enticated OOB wire format; adding tls-auth/tls-crypt</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * wrapping for the probe is a follow-up (i=
t only works against a server with</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * no control-channel wrapping for now)=2E */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-oob_probe_build_packet(struct buffer *buf, const=
 struct session_id *client_sid)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static bool oob_probe_eligible(const struct connection_entry *c=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* Build a standalone control-chann=
el wrapping context for the probe, mirroring</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * the tls_auth_standalone the server uses to answ=
er it=2E With neither tls-auth</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * nor tls-crypt configured the context stays in TLS_WRAP_NONE a=
nd the probe is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * s=
ent in plaintext, exactly as before; with either configured the probe is</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * authenticated/encry=
pted like any other control packet=2E Returns NULL (and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * logs) for configurations the probe c=
annot wrap yet, in which case the caller</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * skips probing and keeps the configured remote order=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct=
 tls_auth_standalone *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+oob_probe_init_tls_auth_standalone(struct context *c, struct gc_arena *g=
c)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    const struct oob_probe_parameter param =3D {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        =2Etimestamp =3D (uint64_t)now,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        =2Eflags =3D 0,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    };</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint8_t header =3D (uint8_t)(P_CONTROL_=
OOB_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return buf_write_u8(buf, header) &amp;&amp; session_id_write=
(client_sid, buf)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
       &amp;&amp; oob_server_probe_write(buf, &amp;param);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* Wrap with the first entry we =
can actually probe: that is the entry every</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * other probed remote is checked against, so t=
he key on the wire is the one</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * they were checked for=2E Falls back to entry 0 when nothin=
g is probeable,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * in which case the caller bails out before anything is sent=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct connection=
_list *l =3D c-&gt;options=2Econnection_list;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const struct connection_entry *ce =3D l-&gt;a=
rray[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (in=
t i =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (oob_probe_eligible(l-&gt;array[i]))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            ce =3D l-&gt;array[i];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* tl=
s-crypt-v2 wraps with a per-client key the server only learns from the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * wrapped client ke=
y (WKc) carried in the TLS handshake=2E An out-of-band</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * probe carries no WKc, so the serv=
er cannot unwrap it; skip probing rather</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * than send something unverifiable=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;tls_crypt_v2_=
file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;ser=
ver-probe: not supported with tls-crypt-v2; using configured order&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Load the tls-auth/tls-crypt key material into=
 c-&gt;c1=2Eks (a no-op if neither</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * is configured)=2E This is run again per-connection la=
ter; calling it early</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * here is harmless=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    do_init_tls_wrap_key(c, ce);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct tls_options to;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    CLEAR(to);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    init_tls_wrap_ctx(&amp;to=2Etls_wrap, ce, c-&gt;options=2Etls_c=
lient, &amp;c-&gt;c1=2Eks, &amp;c-&gt;c1=2Epid_persist);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    to=2Ereplay_window =3D c-&gt;optio=
ns=2Ereplay_window;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    to=2Ereplay_time =3D c-&gt;options=2Ereplay_time;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct tls_auth_standalone *tas =3D tls_auth_standalone_=
init(&amp;to, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Control-chann=
el frame and work buffers, mirroring do_init_frame_tls()=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    tls_init_control_channel_fra=
me_parameters(&amp;tas-&gt;frame, ce-&gt;tls_mtu);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    tas-&gt;tls_wrap=2Ework =3D alloc_buf_gc=
(BUF_SIZE(&amp;tas-&gt;frame), gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    tas-&gt;workbuf =3D alloc_buf_gc(BUF_SIZE(&amp;tas-&gt;=
frame), gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return tas;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Release the probe&#39;s wrapping context and the key material</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * do_init_tls_wrap_ke=
y() loaded for it: do_init_crypto_tls_c1() loads the same</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * fields again later without freeing=
 them first=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_=
free_wrap(struct context *c, struct tls_auth_standalone *tas)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    tls_auth_standalone_free(tas);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    free_key_ctx_bi(&amp;c-&gt;c1=2E=
ks=2Etls_wrap_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    CLEAR(c-&gt;c1=2Eks=2Etls_wrap_key);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    buf_clear(&amp;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;c-=
&gt;c1=2Eks=2Etls_crypt_v2_wkc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* the raw key bytes too: do_init_crypto_tls_c1() may neve=
r load a key over</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * them, so they would otherwise stay resident for the process lifetime *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure_memzero=
(&amp;c-&gt;c1=2Eks=2Eoriginal_wrap_keydata, sizeof(c-&gt;c1=2Eks=2Eorigina=
l_wrap_keydata));</span><br><span> }</span><br><span> </span><br><span> /* =
The local address and port ce&#39;s connection socket binds: its first --lo=
cal,</span><br><span>@@ -156,6 +215,22 @@</span><br><span>            &amp;=
&amp; str_equal_or_both_null(port_a, port_b);</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Do a and =
b wrap the control channel with the same key (--tls-auth,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * --tls-crypt, --tls-crypt-v2 and ke=
y direction)? The one probe is wrapped with</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * the first probeable entry&#39;s key, so a server=
 keyed differently could never</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * answer it=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+oob_probe_same_wrap(const struct connection_entry *a, const struct connec=
tion_entry *b)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return str_equal_or=
_both_null(a-&gt;tls_auth_file, b-&gt;tls_auth_file)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; a-&gt;tls_auth_file=
_inline =3D=3D b-&gt;tls_auth_file_inline</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+           &amp;&amp; a-&gt;key_direction =3D=3D b-&g=
t;key_direction</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
       &amp;&amp; str_equal_or_both_null(a-&gt;tls_crypt_file, b-&gt;tls_cr=
ypt_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
 &amp;&amp; a-&gt;tls_crypt_file_inline =3D=3D b-&gt;tls_crypt_file_inline<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp=
; str_equal_or_both_null(a-&gt;tls_crypt_v2_file, b-&gt;tls_crypt_v2_file)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp=
; a-&gt;tls_crypt_v2_file_inline =3D=3D b-&gt;tls_crypt_v2_file_inline;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Resolve the local bi=
nd address of ce&#39;s connection socket; NULL with --nobind=2E</span><br><=
span>  * Fatal on failure, like the link socket=2E */</span><br><span> stat=
ic struct addrinfo *</span><br><span>@@ -250,9 +325,9 @@</span><br><span> /=
* Parse one received datagram as a PROBE_REPLY and, if valid and matching o=
ne</span><br><span>  * of the probes we sent, record the reply in results=
=2E */</span><br><span> static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-oob_probe_handle_reply(const uint8_t *data, int len, const st=
ruct session_id *client_sid,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                       const struct openvpn_sockaddr *from, const st=
ruct oob_probe_target *targets,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                       struct oob_probe_result *results, int n)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_handle_repl=
y(uint8_t *data, int len, const struct session_id *client_sid,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                       const str=
uct tls_wrap_ctx *base_wrap, const struct openvpn_sockaddr *from,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                       const =
struct oob_probe_target *targets, struct oob_probe_result *results, int n)<=
/span><br><span> {</span><br><span>     /* Need at least the opcode byte an=
d the session id=2E */</span><br><span>     if (len &lt; 1 + (int)SID_SIZE =
|| (data[0] &gt;&gt; P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)</span><br><span=
>@@ -262,7 +337,20 @@</span><br><span> </span><br><span>     struct buffer =
buf;</span><br><span>     buf_set_read(&amp;buf, data, (size_t)len);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_advance(&amp;buf, 1 =
+ SID_SIZE); /* skip opcode + server session id */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* Unwrap the reply with the same control-channel path the =
server used to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* wrap it: this verifies the tls-auth HMAC / decrypts tls-crypt, and (in al=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * modes) stri=
ps the opcode + server session id, leaving buf at the TLV</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * payload=2E With no tls-auth/tl=
s-crypt it just strips those header bytes, as</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * before=2E read_control_auth() mutates the =
wrapping context, so we work on a</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * per-packet copy (as tls_pre_decrypt_lite() does on the=
 server)=2E The peer</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * address is only used for log messages, and tls_options only for</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * tls-crypt-v2 met=
adata checks, so both are passed as NULL=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct tls_wrap_ctx wrap =3D *base_wrap;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!read_control_a=
uth(&amp;buf, &amp;wrap, NULL, NULL))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return; /* not for us, or failed authentication */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><b=
r><span>     struct oob_probe_reply reply;</span><br><span>     if (!oob_cl=
ient_reply_read(&amp;buf, &amp;reply))</span><br><span>@@ -314,8 +402,9 @@<=
/span><br><span>  * matches a probe we sent=2E Returns true if every sent p=
robe has been answered=2E */</span><br><span> static bool</span><br><span> =
oob_probe_receive_slice(const struct probe_ctx *pc, const struct timeval *d=
eadline,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
           const struct session_id *client_sid, const struct oob_probe_targ=
et *targets,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
               struct oob_probe_result *results, int n, int outstanding)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  const struct session_id *client_sid, const struct tls_wrap_ctx *wrap,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
 const struct oob_probe_target *targets, struct oob_probe_result *results, =
int n,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
           int outstanding)</span><br><span> {</span><br><span>     while (=
true)</span><br><span>     {</span><br><span>@@ -365,7 +454,7 @@</span><br>=
<span>                                     (struct sockaddr *)&amp;from, &a=
mp;fromlen);</span><br><span>             if (len &gt; 0)</span><br><span> =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        oob_probe_handle_reply(data, len, client_sid, &amp;from, targets, r=
esults, n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        oob_probe_handle_reply(data, len, client_sid, wrap, &amp;from, targ=
ets, results, n);</span><br><span>             }</span><br><span>         }=
</span><br><span>         if (oob_count_answered(targets, results, n) &gt;=
=3D outstanding)</span><br><span>@@ -418,8 +507,8 @@</span><br><span>  * on=
ce the window elapses or every sent probe has been answered=2E */</span><br=
><span> static void</span><br><span> oob_probe_collect(struct probe_ctx *pc=
, const struct buffer *probe,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                  const struct session_id *client_sid, struct oob_p=
robe_target *targets,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                  struct oob_probe_result *results, int n,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                  const struct sessi=
on_id *client_sid, const struct tls_wrap_ctx *wrap,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                  struct oob_probe_target=
 *targets, struct oob_probe_result *results, int n,</span><br><span>       =
            const struct signal_info *sig)</span><br><span> {</span><br><sp=
an>     /* number of probes we actually sent: stop early once they all answ=
er */</span><br><span>@@ -444,7 +533,7 @@</span><br><span>             dead=
line=2Etv_usec -=3D 1000000;</span><br><span>         }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (oob_probe_r=
eceive_slice(pc, &amp;deadline, client_sid, targets, results, n, want)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (oob_probe_re=
ceive_slice(pc, &amp;deadline, client_sid, wrap, targets, results, n, want)=
</span><br><span>             || sig-&gt;signal_received)</span><br><span> =
        {</span><br><span>             return; /* all answered, or we are b=
eing told to stop */</span><br><span>@@ -487,6 +576,16 @@</span><br><span> =
</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Wrapping contex=
t for the probe (tls-auth/tls-crypt, or plaintext if</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * neither)=2E NULL means this config=
uration cannot be probed; keep the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * configured order=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct tls_auth_standalone *tas =3D oob_probe_=
init_tls_auth_standalone(c, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!tas)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>     /* A single random session id identifies all of our probes; servers=
 echo it</span><br><span>      * back in the reply&#39;s peer_session_id, l=
etting us reject spoofed replies=2E */</span><br><span>     struct session_=
id client_sid;</span><br><span>@@ -508,11 +607,21 @@</span><br><span>      =
       tmpl =3D ce;</span><br><span>             continue;</span><br><span>=
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst char *differs =3D NULL;</span><br><span>         if (!oob_probe_same_b=
ind(tmpl, ce, &amp;c-&gt;options))</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            msg(D_LOW, &quot;server=
-probe: %s:%s binds differently from %s:%s;&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            differs =3D &quot;binds&quot;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        else if (!oob_probe_same=
_wrap(tmpl, ce))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            d=
iffers =3D &quot;wraps the control channel&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (differs)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s %s differently =
from %s:%s;&quot;</span><br><span>                        &quot; not probin=
g, using configured order&quot;,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                ce-&gt;remote, ce-&gt;remote_port, tmpl-&gt;remo=
te, tmpl-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                ce-&gt;remote, ce-&gt;remote_port, differs, tmpl-&gt=
;remote, tmpl-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            oob_probe_free_wrap(c, tas);</span><br><span>      =
       gc_free(&amp;gc);</span><br><span>             return;</span><br><sp=
an>         }</span><br><span>@@ -520,6 +629,7 @@</span><br><span>     if (=
!tmpl)</span><br><span>     {</span><br><span>         msg(D_LOW, &quot;ser=
ver-probe: no remote can be probed; using configured order&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_free_wrap(=
c, tas);</span><br><span>         gc_free(&amp;gc);</span><br><span>       =
  return;</span><br><span>     }</span><br><span>@@ -528,17 +638,39 @@</spa=
n><br><span>     struct oob_probe_target *targets =3D gc_malloc(sizeof(*tar=
gets) * l-&gt;len, true, &amp;gc);</span><br><span>     struct oob_probe_re=
sult *results =3D gc_malloc(sizeof(*results) * l-&gt;len, true, &amp;gc);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct buffer probe =3D alloc_buf_gc(256, &amp;gc);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!oob_probe_build_packet(&amp;probe, &a=
mp;client_sid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Build the probe once and reuse the same bytes for every remote and for</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * resends: the S=
ERVER_PROBE payload is a single probe_parameter TLV, wrapped</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * (or sent in plaintext) like=
 any other control packet=2E The client session</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * id is prepended as the sender session id=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bu=
ffer payload =3D alloc_buf_gc(64, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const struct oob_probe_parameter param =3D {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =
=3D (uint64_t)now,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o=
ob_server_probe_write(&amp;payload, &amp;param))</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_LOW, &quot;=
server-probe: could not build probe packet; using configured order&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &=
quot;server-probe: could not build probe payload; using configured order&qu=
ot;);</span><br><span>         oob_probe_sockets_close(&amp;pc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_free_wrap(c,=
 tas);</span><br><span>         gc_free(&amp;gc);</span><br><span>         =
return;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    msg(D_LOW, &quot;server-probe: probing %d re=
mote(s) with a %d ms window&quot;, l-&gt;len,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        OOB_PROBE_WINDOW_MS);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer probe =3D tls_wrap_oob_=
standalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_sid, &amp;payload);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!BLEN(&amp;probe=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server=
-probe: could not wrap probe packet; using configured order&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_sockets_c=
lose(&amp;pc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   oob_probe_free_wrap(c, tas);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *wra=
p_name =3D (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? &quot;tls-cry=
pt&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                 : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? &quot;t=
ls-auth&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                                              : &quot;none =
(plaintext)&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   msg(D_LOW, &quot;server-probe: probing %d remote(s) with a %d ms window,=
 control-channel wrapping: %s&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        l-&gt;len, OOB_PROBE_WINDOW_MS, wrap_name);</span>=
<br><span> </span><br><span>     /* Resolve every remote first, so only the=
 address families actually in use</span><br><span>      * get a probe socke=
t=2E */</span><br><span>@@ -585,6 +717,7 @@</span><br><span>         {</spa=
n><br><span>             freeaddrinfo(bind_local);</span><br><span>        =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        oob_probe=
_free_wrap(c, tas);</span><br><span>         gc_free(&amp;gc);</span><br><s=
pan>         return;</span><br><span>     }</span><br><span>@@ -646,7 +779,=
7 @@</span><br><span> </span><br><span>     if (sent_count &gt; 0)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 oob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid, targets, results, =
l-&gt;len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=
ob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid, &amp;tas-&gt;tls_wra=
p, targets, results, l-&gt;len,</span><br><span>                           =
c-&gt;sig);</span><br><span>     }</span><br><span>     oob_probe_sockets_c=
lose(&amp;pc);</span><br><span>@@ -694,5 +827,6 @@</span><br><span>     msg=
(M_INFO, &quot;server-probe: %d of %d probed remote(s) answered; connecting=
 best-first&quot;,</span><br><span>         responded, sent_count);</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_p=
robe_free_wrap(c, tas);</span><br><span>     gc_free(&amp;gc);</span><br><s=
pan> }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail">change 1750</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1f9d7b5a5e=
c19bf77c0c212795f583c5ba4c03ac </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1750 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 21 =
</div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
=

</body></html>
--6EPXKO2hFfY=--


--===============3514520186520465092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3514520186520465092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3514520186520465092==--

