Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD17BC53219
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GgBl5aOSzWbIhK25XMG5576Jkgp1JMIJM89cs/KGAeE=; b=LFUpKEGCfb8K1bmDGSxE1ss/8a
	SMd+ofj7PYw1tTdhQc7A1IwLVZhWG9cFVBuzUfPOMlfNIAOBVxg1LL/gilF1m9/ePuvYeIre0ixBQ
	dLEqS+pJM6douT2AfRNK9Bz+LrgZURWu/hOulr63tWeae71mt13rmXYnEb5eCoJbNado=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojLV-0006pS-6J;
	Tue, 28 Jul 2026 15:03:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojLT-0006pM-Mx
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:03:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YYvDnDWLaBG1DexxT9F4XPFUYZJ2KiKE31DFQakZeCY=; b=RA1ocylKh/Vxow2/liS38eLjc6
 jrsphKK5kSUe98XFzC1XErxfDfbesnHoZTL/WsDjTUqWWwzdCmIAlTmgnBUua3NlKE25Y3NqMf64h
 +PiKO0cNDmkvQHEwdgFt7ma7x+O5h+1CWXI8T/e5mgBAVHlX3vv18ReWHk4+H9G9YWGg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YYvDnDWLaBG1DexxT9F4XPFUYZJ2KiKE31DFQakZeCY=; b=I
 daOEhDkj4HMFLze38O1SLTh6fUXsU16u60HP4bFVPzWp2OU873V6eA0IVMzPsZS4UN29f07vRQ9jP
 I06x054MSM+e6hh2herEdH7AqPH5yNwoSXw5/690ns9abaROcFjPNKJeLfpU+BTrXpBUUkFu/9G0Z
 rH0hSVRr1cvVOS1o=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojLV-0000Q9-5t for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:03:51 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so3978708f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251023; x=1785855823; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YYvDnDWLaBG1DexxT9F4XPFUYZJ2KiKE31DFQakZeCY=;
 b=alF5FrT/iEoQ+M2TQXSBjtkbonCtcjeTUMJmc/e/9j1jXmwQWOk6nYYZPSUjEWaP5W
 hFFREfHbVyzlwH00L7t2nKDwrW40uVq1l2M+D5bhunK7VBLzn5jdFbH6S7YAEEwhe7Fv
 7MzVUa/rS5M4gVL5yxmjtfizavVFxs4yjcOpBXxUB8vxAoQ7av3XULQK1F2pZV/CFaYs
 d8QJunr4J4ll4+LHqXFCiEI1EiF9wVFXAXl6A182j3hdZ/piWwfDpUAr2afMDLp71tl4
 5sCXxkx9Y8HQ5KspyTVCbkUqq8C21PJ936Ti6rPdk3hHCo9EnMiqolCzZ5r0YYAHC13D
 Ib7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251023; x=1785855823;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YYvDnDWLaBG1DexxT9F4XPFUYZJ2KiKE31DFQakZeCY=;
 b=f02ycADlyzM2VjqWLTytLvcxvNVkb5J5KA8Ky2DhcmGhrZtJic2dwLOUjw96auSsxz
 Cdg4COYFLUnH5vYmjCfujqYE5fz+svp0VeSF/vd/3Jmnt840NXemst30cBzM3vp9PTFw
 WXaImzzmjK1YP2LU5f4iJAUXJx++708Jvupk3u6/SmOXfoEtSGow7SY5Bi3mJvP2Ii9e
 Webg0rrsk8bMTaVsy4k74rriDb6tGqOj6YU0lsJmbbK6GIuf+1Daob5TaDM4tOYZkuKu
 NJSfeRg3PSCbiby07fxbUvSxlu4p3lBeSw/UL3BmAvzDxqXGF8D4vn/eQVlJUGV3EkVt
 6RwA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpj7igtPxMCqEkZ8D/1eFlwNp7vH3EC1l9W9cWWJRmRXiI8EVhb9VsICwMYDTWBiH6iFTvyr0cBK30St8bE@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwJT5xeCM14YGbtqUk5f4qwQFkjxYiiWXrGyGSMQue40B7FY7li
 rxKAU1e+GqAUTE8zV8Qjoo1TC021lwKqaRk7CByHUSzvVaNyrzI3zYJZqAbQMjbt2EnCXV2JtOY
 CMgBb84klSUXt8MWledI4HNkVqL0FmRBzZmG/04cX3ZUSohLSnj73rs72mrXX5e338beL
X-Gm-Gg: AR+sD11WrjCPbMql2qv22BaHx5tWQ1IsPHqxkFc0nC0CDVeHy3KGqw/tm8P/5ySH+Vi
 dqkSspLLjwXpDufBsUtasmhaMyZhhwGig2RDbBqafAqQ54hfVMz/v74n3Ksl7/8v85cZ46wffoq
 B8mPe0z7y+pQ6U//0Z3Q/mBaWRcnfVKGyjajOULGI/IwZc56F91LzNdEyhT8bfPgggAB96ewwfx
 UN/5+bzfxVhQv2f82EWow7SiDtT5Yi0xL4vUgzRe791em5HSzfANnmOL9cZGe/0DwjlaUMv26TN
 SvpWWdJ1ggPDimITbCOFSYqy19jM5Vd05xFoAlrnf4SJ5oGVCBrN/uGQHq6fFz9DN7JxEihA0dj
 Gt8AWY8W39xKCh8+qJjOMe9yk+0HWLMI4PgzHDHVXEc3Y8tfK8m8k7uQuZrUdWkIFN8vzug38eH
 qrHYSFwQz04CveUwNAuMLQpeThKYHq0u6t+Kt9dW1DsO3GwXpOR04bluq2p1chijv8u4T9dVeiF
 DgPlCFgPMl727YdzyyxkOMBdD73u+Tikgxi+kbcWA8ouWFES1pZenhWVY9t1ZDfIEKz
X-Received: by 2002:a05:6000:2c0c:b0:47f:8b75:2520 with SMTP id
 ffacd0b85a97d-47fb1edbd56mr3181448f8f.42.1785251022714; 
 Tue, 28 Jul 2026 08:03:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6dc25sm57566939f8f.33.2026.07.28.08.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:03:41 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:03:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: 9565b10bbed5fd91897e7f84ade40811017c7d28
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0f9669bdcccae874108a989d68654ff7bb42e460-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojLV-0000Q9-5t
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Answer
 SERVER_PROBE on the server (P_CONTROL_OOB_V1)
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1203629100981288047=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1203629100981288047==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RKbqOpLvDlA="; charset=UTF-8

--RKbqOpLvDlA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

Hello plaisthos, 

I'd like=
 you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1744?usp=3Demail

to look at the new patch set (#9)=2E


Cha=
nge subject: oob: Answer SERVER_PROBE on the server (P_CONTROL_OOB_V1)
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Answer SERV=
ER_PROBE on the server (P_CONTROL_OOB_V1)

Make a --mode server UDP listene=
r answer an out-of-band SERVER_PROBE without
creating a session:

  - tls_p=
re_decrypt_lite() accepts P_CONTROL_OOB_V1 and returns the new
    VERDICT_=
VALID_OOB_V1 verdict=2E
  - tls_wrap_oob_standalone() builds a session-less=
 P_CONTROL_OOB_V1 packet:
    opcode + session id + the usual tls-auth/tls-=
crypt wrapping around a bare
    TLV payload (no reliability/ACK fields), m=
irroring tls_reset_standalone()=2E
  - oob_client_reply_write() writes the =
PROBE_REPLY message (message-type
    header + probe_reply TLV)=2E
  - do_p=
re_decrypt_check() handles the new verdict: it asks
    oob_build_probe_rep=
ly() whether to answer, and if so sends a PROBE_REPLY
    via send_probe_re=
ply() (synchronous, stateless, like the HMAC reset path)
    and returns fa=
lse so no session is created=2E The verdict joins the reset
    verdicts in=
 the reflect_filter rate-limit check, so probes cannot be used
    to make =
the server answer faster than a reset flood could=2E

The reply's own sessi=
on id is the stateless SYN-cookie used by the three-way
handshake, so the r=
esponder keeps no state and the reply can later serve as
the handshake rese=
t (connect_lifetime advertisement)=2E

Change-Id: I930d3789e0313aa0c3bc51ee=
5fd1d108343d59f0
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/=
openvpn/mudp=2Ec
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M src/openvpn/=
ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
5 files changed, 118 insertions(+), 4=
 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/44/1744/9

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec=

index 2be085f=2E=2E2209407 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/ope=
nvpn/mudp=2Ec
@@ -32,6 +32,7 @@
 
 #include "memdbg=2Eh"
 #include "ssl_pkt=
=2Eh"
+#include "oob=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inoti=
fy=2Eh>
@@ -87,6 +88,34 @@
                           "Reset packet from cl=
ient, sending HMAC based reset challenge", sock);
 }
 
+/* Send an out-of-b=
and PROBE_REPLY back to the source of a SERVER_PROBE,
+ * synchronously and=
 without keeping any state, mirroring the reset path=2E */
+static void
+se=
nd_probe_reply(struct multi_context *m, struct tls_pre_decrypt_state *state=
,
+                 struct tls_auth_standalone *tas, const struct oob_probe=
_reply *reply,
+                 struct session_id *own_sid, struct link_so=
cket *sock)
+{
+    struct gc_arena gc =3D gc_new();
+
+    /* Build the pa=
yload of the reply (message-type header + probe_reply TLV) */
+    struct b=
uffer payload =3D alloc_buf_gc(128, &gc);
+    if (!oob_client_reply_write(=
&payload, reply))
+    {
+        gc_free(&gc);
+        return;
+    }
+
+=
    /* OOB replies use the same control-channel wrapping as the request */
=
+    reset_packet_id_send(&state->tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);
+=
    state->tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =3D true;
+
+=
    struct buffer buf =3D tls_wrap_oob_standalone(&state->tls_wrap_tmp, tas=
, own_sid, &payload);
+    send_standalone_reply(m, &buf, "Server Probe", "=
Server probe from client, sending probe reply",
+                          =
sock);
+
+    gc_free(&gc);
+}
+
 
 /* Returns true if this packet should c=
reate a new session */
 static bool
@@ -105,7 +134,8 @@
     struct openvpn=
_sockaddr *from =3D &m->top=2Ec2=2Efrom=2Edest;
     int handwindow =3D m->=
top=2Eoptions=2Ehandshake_window;
 
-    if (verdict =3D=3D VERDICT_VALID_R=
ESET_V3 || verdict =3D=3D VERDICT_VALID_RESET_V2)
+    if (verdict =3D=3D V=
ERDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VALID_RESET_V2
+        || =
verdict =3D=3D VERDICT_VALID_OOB_V1)
     {
         /* Check if we are sti=
ll below our limit for sending out
          * responses */
@@ -203,6 +233,=
31 @@
 
         return ret;
     }
+    else if (verdict =3D=3D VERDICT_VA=
LID_OOB_V1)
+    {
+        /* Out-of-band server probe=2E state->newbuf po=
ints at the TLV payload
+         * (read_control_auth has stripped the opc=
ode, session id and any
+         * tls-auth/tls-crypt wrapping)=2E Answer =
it without creating a session=2E */
+        struct oob_probe_reply reply;
=
+        if (!oob_build_probe_reply(&state->newbuf, (uint64_t)now, (uint64_=
t)handwindow,
+                                   &state->peer_session_id, =
&reply))
+        {
+            /* malformed or replayed/stale probe: sile=
ntly drop */
+            return false;
+        }
+
+        /* Our sessio=
n id is a stateless SYN cookie (the same HMAC the three-way
+         * han=
dshake uses): we keep no per-probe state, and the reply can later
+        =
 * also serve as the server's CONTROL_HARD_RESET_SERVER_V2, so a client
+  =
       * can start the handshake from it (the connect_lifetime advertisemen=
t)=2E */
+        struct session_id sid =3D
+            calculate_session_=
id_hmac(state->peer_session_id, from, hmac, handwindow, 0);
+
+        send=
_probe_reply(m, state, tas, &reply, &sid, sock);
+
+        /* An OOB probe=
 never creates a session */
+        return false;
+    }
 
     /* VERDICT=
_INVALID */
     return false;
diff --git a/src/openvpn/oob=2Ec b/src/openv=
pn/oob=2Ec
index 930b213=2E=2Ec841d59 100644
--- a/src/openvpn/oob=2Ec
+++ =
b/src/openvpn/oob=2Ec
@@ -106,6 +106,12 @@
 }
 
 bool
+oob_client_reply_wri=
te(struct buffer *buf, const struct oob_probe_reply *reply)
+{
+    return =
buf_write_u16(buf, OOB_MSG_PROBE_REPLY) && oob_probe_reply_write(buf, reply=
);
+}
+
+bool
 oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, uin=
t64_t window_secs)
 {
     uint64_t diff =3D (now > probe_ts) ? (now - prob=
e_ts) : (probe_ts - now);
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oo=
b=2Eh
index 1afabbd=2E=2E49d64e8 100644
--- a/src/openvpn/oob=2Eh
+++ b/src=
/openvpn/oob=2Eh
@@ -126,6 +126,12 @@
 bool oob_server_probe_read(struct bu=
ffer *payload, struct oob_probe_parameter *param);
 
 /**
+ * Write a compl=
ete PROBE_REPLY message (message-type header + probe_reply TLV)
+ * to buf=
=2E Sent by the server=2E
+ */
+bool oob_client_reply_write(struct buffer *=
buf, const struct oob_probe_reply *reply);
+
+/**
  * Check whether a probe=
 timestamp is within an acceptable window around the
  * current time=2E Us=
ed to cheaply drop replayed or implausibly-timed probes
  * before doing an=
y further work (see the probe_parameter timestamp rationale
diff --git a/sr=
c/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index 0d882d9=2E=2E335e26f =
100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -313,=
7 +313,8 @@
 
     /* Allow only the reset packet or the first packet of th=
e actual handshake=2E */
     if (op !=3D P_CONTROL_HARD_RESET_CLIENT_V2 &&=
 op !=3D P_CONTROL_HARD_RESET_CLIENT_V3
-        && op !=3D P_CONTROL_V1 &&=
 op !=3D P_CONTROL_WKC_V1 && op !=3D P_ACK_V1)
+        && op !=3D P_CONTRO=
L_V1 && op !=3D P_CONTROL_WKC_V1 && op !=3D P_ACK_V1
+        && !opcode_is=
_oob(op))
     {
         /*
          * This can occur due to bogus data o=
r DoS packets=2E
@@ -388,6 +389,10 @@
     {
         return VERDICT_VALID_=
WKC_V1;
     }
+    else if (opcode_is_oob(op))
+    {
+        return VERD=
ICT_VALID_OOB_V1;
+    }
     else
     {
         return VERDICT_VALID_RES=
ET_V2;
@@ -442,6 +447,29 @@
     return buf;
 }
 
+struct buffer
+tls_wrap_=
oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
+=
                        struct session_id *own_sid, const struct buffer *pa=
yload)
+{
+    /* Copy buffer here to point at the same data but allow tls_=
wrap_control
+     * to potentially change buf to point to another buffer w=
ithout
+     * modifying the buffer in tas */
+    struct buffer buf =3D ta=
s->workbuf;
+    ASSERT(buf_init(&buf, tas->frame=2Ebuf=2Eheadroom));
+
+  =
  /* Out-of-band messages carry the payload directly, with no reliability
+=
     * or ACK fields=2E */
+    ASSERT(buf_copy(&buf, payload));
+
+    uin=
t8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
+
+    /* Ad=
d tls-auth/tls-crypt wrapping, this might replace buf with
+     * ctx->wor=
k */
+    tls_wrap_control(ctx, header, &buf, own_sid);
+
+    return buf;
=
+}
+
 hmac_ctx_t *
 session_id_hmac_init(void)
 {
diff --git a/src/openvpn/=
ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 25e50bf=2E=2E3ab09db 100644
---=
 a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -62,8 +62,9 @@
=
  * control channel session (e=2Eg=2E a server probe)=2E Inherently unrelia=
ble:
  * there is no protocol-level retransmission=2E
  *
- * It is not leg=
al on an established session; see opcode_valid_in_session()
- * below=2E */=

+ * On the server this is accepted via the tls_pre_decrypt_lite() allowlis=
t and
+ * handled in the new-connection path (it never creates a session)=
=2E It is not
+ * legal on an established session; see opcode_valid_in_sess=
ion() below=2E */
 #define P_CONTROL_OOB_V1 12
 
 /* define the range of de=
fined opcodes, in- and out-of-band=2E Note this is not
@@ -136,6 +137,9 @@
=
     VERDICT_VALID_ACK_V1,
     /** The packet is a valid control packet wi=
th appended wrapped client key */
     VERDICT_VALID_WKC_V1,
+    /** This =
packet is a valid out-of-band control message (e=2Eg=2E a server
+     * pr=
obe)=2E It does not belong to a session and must not create one=2E */
+    =
VERDICT_VALID_OOB_V1,
     /** the packet failed on of the various checks *=
/
     VERDICT_INVALID
 };
@@ -264,6 +268,21 @@
                           =
         struct session_id *own_sid, struct session_id *remote_sid,
       =
                             uint8_t header, bool request_resend_wkc);
 
+/=
**
+ * Wrap an already-built out-of-band payload (e=2Eg=2E probe-reply TLVs=
) into a
+ * standalone, session-less P_CONTROL_OOB_V1 packet: it prepends =
the opcode and
+ * own_sid and applies the same tls-auth/tls-crypt wrapping=
 as a regular
+ * control packet, but carries no reliability/ACK fields=2E
=
+ *
+ * @param ctx       tls wrapping context (from the pre-decrypt state)
=
+ * @param tas       standalone auth context providing the work buffer
+ * =
@param own_sid   session id to use as our session id in the header
+ * @par=
am payload   the OOB message payload (TLV stream) to wrap
+ * @return      =
    the wrapped packet buffer, ready to send
+ */
+struct buffer tls_wrap_o=
ob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
+ =
                                     struct session_id *own_sid, const stru=
ct buffer *payload);
+
 
 /**
  * Extracts a control channel message from b=
uf and adjusts the size of

-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1744?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Gerrit-Change-Number: 1=
744
Gerrit-PatchSet: 9
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--RKbqOpLvDlA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>stipa <strong>uploaded patch set #9<=
/strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1744?usp=3Demail">View Change</a></p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Answer S=
ERVER_PROBE on the server (P_CONTROL_OOB_V1)<br><br>Make a --mode server UD=
P listener answer an out-of-band SERVER_PROBE without<br>creating a session=
:<br><br>  - tls_pre_decrypt_lite() accepts P_CONTROL_OOB_V1 and returns th=
e new<br>    VERDICT_VALID_OOB_V1 verdict=2E<br>  - tls_wrap_oob_standalone=
() builds a session-less P_CONTROL_OOB_V1 packet:<br>    opcode + session i=
d + the usual tls-auth/tls-crypt wrapping around a bare<br>    TLV payload =
(no reliability/ACK fields), mirroring tls_reset_standalone()=2E<br>  - oob=
_client_reply_write() writes the PROBE_REPLY message (message-type<br>    h=
eader + probe_reply TLV)=2E<br>  - do_pre_decrypt_check() handles the new v=
erdict: it asks<br>    oob_build_probe_reply() whether to answer, and if so=
 sends a PROBE_REPLY<br>    via send_probe_reply() (synchronous, stateless,=
 like the HMAC reset path)<br>    and returns false so no session is create=
d=2E The verdict joins the reset<br>    verdicts in the reflect_filter rate=
-limit check, so probes cannot be used<br>    to make the server answer fas=
ter than a reset flood could=2E<br><br>The reply&#39;s own session id is th=
e stateless SYN-cookie used by the three-way<br>handshake, so the responder=
 keeps no state and the reply can later serve as<br>the handshake reset (co=
nnect_lifetime advertisement)=2E<br><br>Change-Id: I930d3789e0313aa0c3bc51e=
e5fd1d108343d59f0<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<=
br>---<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/oob=2Ec<br>M src/openvpn/=
oob=2Eh<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>5 file=
s changed, 118 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/44/1744/9</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><sp=
an>index 2be085f=2E=2E2209407 100644</span><br><span>--- a/src/openvpn/mudp=
=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -32,6 +3=
2,7 @@</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</=
span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><span> =
</span><br><span> #ifdef HAVE_SYS_INOTIFY_H</span><br><span> #include &lt;s=
ys/inotify=2Eh&gt;</span><br><span>@@ -87,6 +88,34 @@</span><br><span>     =
                      &quot;Reset packet from client, sending HMAC based re=
set challenge&quot;, sock);</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* Send an out-of-band PROBE_R=
EPLY back to the source of a SERVER_PROBE,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * synchronously and without keeping any state, mirr=
oring the reset path=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
end_probe_reply(struct multi_context *m, struct tls_pre_decrypt_state *stat=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
struct tls_auth_standalone *tas, const struct oob_probe_reply *reply,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                 struct s=
ession_id *own_sid, struct link_socket *sock)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* Build the payload of the reply (message-type header + probe_re=
ply TLV) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct buffer payload =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!oob_client_reply_write(&amp;payload,=
 reply))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* OOB replies use the same control-channel wrapping=
 as the request */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Esen=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    state-&gt;tl=
s_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =3D true;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer buf =3D tls_wrap_oob_standalone(&amp;=
state-&gt;tls_wrap_tmp, tas, own_sid, &amp;payload);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    send_standalone_reply(m, &amp;buf, &q=
uot;Server Probe&quot;, &quot;Server probe from client, sending probe reply=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
              sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span=
> /* Returns true if this packet should create a new session */</span><br><=
span> static bool</span><br><span>@@ -105,7 +134,8 @@</span><br><span>     =
struct openvpn_sockaddr *from =3D &amp;m-&gt;top=2Ec2=2Efrom=2Edest;</span>=
<br><span>     int handwindow =3D m-&gt;top=2Eoptions=2Ehandshake_window;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VALID_RE=
SET_V2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (verd=
ict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VALID_RESET_V2<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || verdict =
=3D=3D VERDICT_VALID_OOB_V1)</span><br><span>     {</span><br><span>       =
  /* Check if we are still below our limit for sending out</span><br><span>=
          * responses */</span><br><span>@@ -203,6 +233,31 @@</span><br><sp=
an> </span><br><span>         return ret;</span><br><span>     }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else if (verdict =3D=3D VE=
RDICT_VALID_OOB_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Out=
-of-band server probe=2E state-&gt;newbuf points at the TLV payload</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+         * (read_control_au=
th has stripped the opcode, session id and any</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * tls-auth/tls-crypt wrapping)=2E Answe=
r it without creating a session=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        struct oob_probe_reply reply;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (!oob_build_probe_reply(&amp=
;state-&gt;newbuf, (uint64_t)now, (uint64_t)handwindow,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                   &amp=
;state-&gt;peer_session_id, &amp;reply))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            /* malformed or replayed/stale probe: silently drop =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retur=
n false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* Our session id is a stateless=
 SYN cookie (the same HMAC the three-way</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+         * handshake uses): we keep no per-probe state=
, and the reply can later</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+         * also serve as the server&#39;s CONTROL_HARD_RESET_SERVER_V=
2, so a client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    * can start the handshake from it (the connect_lifetime advertisement)=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struc=
t session_id sid =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            calculate_session_id_hmac(state-&gt;peer_session_id, from, hma=
c, handwindow, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        send_probe_r=
eply(m, state, tas, &amp;reply, &amp;sid, sock);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        /* An OOB probe never creates a session */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><b=
r><span>     /* VERDICT_INVALID */</span><br><span>     return false;</span=
><br><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br=
><span>index 930b213=2E=2Ec841d59 100644</span><br><span>--- a/src/openvpn/=
oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br><span>@@ -106,6=
 +106,12 @@</span><br><span> }</span><br><span> </span><br><span> bool</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_client_reply_write(s=
truct buffer *buf, const struct oob_probe_reply *reply)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return buf_write_u16(buf, OOB_MSG_PROBE_REPLY) &amp;&=
amp; oob_probe_reply_write(buf, reply);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><s=
pan> oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t wind=
ow_secs)</span><br><span> {</span><br><span>     uint64_t diff =3D (now &gt=
; probe_ts) ? (now - probe_ts) : (probe_ts - now);</span><br><span>diff --g=
it a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 1afabb=
d=2E=2E49d64e8 100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><=
span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -126,6 +126,12 @@</span><=
br><span> bool oob_server_probe_read(struct buffer *payload, struct oob_pro=
be_parameter *param);</span><br><span> </span><br><span> /**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Write a complete PROBE_REPLY me=
ssage (message-type header + probe_reply TLV)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * to buf=2E Sent by the server=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool oob_client_reply_write(struct buffer *buf, co=
nst struct oob_probe_reply *reply);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span>  * Check whether a probe timestamp is within an acceptabl=
e window around the</span><br><span>  * current time=2E Used to cheaply dro=
p replayed or implausibly-timed probes</span><br><span>  * before doing any=
 further work (see the probe_parameter timestamp rationale</span><br><span>=
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><s=
pan>index 0d882d9=2E=2E335e26f 100644</span><br><span>--- a/src/openvpn/ssl=
_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -=
313,7 +313,8 @@</span><br><span> </span><br><span>     /* Allow only the re=
set packet or the first packet of the actual handshake=2E */</span><br><spa=
n>     if (op !=3D P_CONTROL_HARD_RESET_CLIENT_V2 &amp;&amp; op !=3D P_CONT=
ROL_HARD_RESET_CLIENT_V3</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        &amp;&amp; op !=3D P_CONTROL_V1 &amp;&amp; op !=3D P_CONTROL_WKC=
_V1 &amp;&amp; op !=3D P_ACK_V1)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        &amp;&amp; op !=3D P_CONTROL_V1 &amp;&amp; op !=3D P_C=
ONTROL_WKC_V1 &amp;&amp; op !=3D P_ACK_V1</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        &amp;&amp; !opcode_is_oob(op))</span><br><spa=
n>     {</span><br><span>         /*</span><br><span>          * This can o=
ccur due to bogus data or DoS packets=2E</span><br><span>@@ -388,6 +389,10 =
@@</span><br><span>     {</span><br><span>         return VERDICT_VALID_WKC=
_V1;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    else if (opcode_is_oob(op))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return VERDICT_VALID_OOB_V1;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span>     else</span><br><span>    =
 {</span><br><span>         return VERDICT_VALID_RESET_V2;</span><br><span>=
@@ -442,6 +447,29 @@</span><br><span>     return buf;</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+stru=
ct buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_wrap_o=
ob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  struct session_id *own_sid, const struct buffer *payload)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Copy buffer here to point at the same data but=
 allow tls_wrap_control</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * to potentially change buf to point to another buffer without</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * modifying the bu=
ffer in tas */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct buffer buf =3D tas-&gt;workbuf;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ASSERT(buf_init(&amp;buf, tas-&gt;frame=2Ebuf=2Eheadr=
oom));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* Out-of-band messages carr=
y the payload directly, with no reliability</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * or ACK fields=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ASSERT(buf_copy(&amp;buf, payload));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint8_t header =3D (uint8_t)(P_CONTRO=
L_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Add tls-auth/tls-crypt wrapping, this might replace buf with</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * ctx-&gt;work */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    tls_wrap_control(ctx, he=
ader, &amp;buf, own_sid);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return bu=
f;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> hmac_ctx_t *</spa=
n><br><span> session_id_hmac_init(void)</span><br><span> {</span><br><span>=
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><s=
pan>index 25e50bf=2E=2E3ab09db 100644</span><br><span>--- a/src/openvpn/ssl=
_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -=
62,8 +62,9 @@</span><br><span>  * control channel session (e=2Eg=2E a serve=
r probe)=2E Inherently unreliable:</span><br><span>  * there is no protocol=
-level retransmission=2E</span><br><span>  *</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * It is not legal on an established session; see op=
code_valid_in_session()</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * below=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
On the server this is accepted via the tls_pre_decrypt_lite() allowlist and=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * handled in the n=
ew-connection path (it never creates a session)=2E It is not</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * legal on an established session=
; see opcode_valid_in_session() below=2E */</span><br><span> #define P_CONT=
ROL_OOB_V1 12</span><br><span> </span><br><span> /* define the range of def=
ined opcodes, in- and out-of-band=2E Note this is not</span><br><span>@@ -1=
36,6 +137,9 @@</span><br><span>     VERDICT_VALID_ACK_V1,</span><br><span> =
    /** The packet is a valid control packet with appended wrapped client k=
ey */</span><br><span>     VERDICT_VALID_WKC_V1,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /** This packet is a valid out-of-band con=
trol message (e=2Eg=2E a server</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * probe)=2E It does not belong to a session and must not c=
reate one=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
VERDICT_VALID_OOB_V1,</span><br><span>     /** the packet failed on of the =
various checks */</span><br><span>     VERDICT_INVALID</span><br><span> };<=
/span><br><span>@@ -264,6 +268,21 @@</span><br><span>                      =
              struct session_id *own_sid, struct session_id *remote_sid,</s=
pan><br><span>                                    uint8_t header, bool requ=
est_resend_wkc);</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Wrap an already-built out-of-band payload (e=2Eg=2E probe-reply TLVs) int=
o a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * standalone, s=
ession-less P_CONTROL_OOB_V1 packet: it prepends the opcode and</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * own_sid and applies the same=
 tls-auth/tls-crypt wrapping as a regular</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * control packet, but carries no reliability/ACK fie=
lds=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param ctx       tls wrappi=
ng context (from the pre-decrypt state)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param tas       standalone auth context providing t=
he work buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram own_sid   session id to use as our session id in the header</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param payload   the OOB me=
ssage payload (TLV stream) to wrap</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @return          the wrapped packet buffer, ready to send=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+struct buffer tls_wrap_oob_standalo=
ne(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
     struct session_id *own_sid, const struct buffer *payload);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><s=
pan> /**</span><br><span>  * Extracts a control channel message from buf an=
d adjusts the size of</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">change=
 1744</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1744 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;=
lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--RKbqOpLvDlA=--


--===============1203629100981288047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1203629100981288047==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1203629100981288047==--

