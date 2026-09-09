Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F221C79F8C
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FnZMuQ+JQSXn3bN+v2S/xbVY2BUt4Zai1SHB9yfEIdY=; b=MAHfZE6/QdhQ4opiGHzqFWOSCZ
	CZY5Sb4disjqFyASxPcoxrhGn/I3aueehTpd5bOu+g6RFxPsjBvh3GWBRA+AG/8k1lOr4FP9vRH9W
	7LFQoVAp4BYhAGeNWMVDn6vAykwn43H5G8wujPW7dNFnyGVFJgmM7gF2j9c6+xM9t8xI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4Cif-0004jV-Cf;
	Wed, 09 Sep 2026 07:27:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4CiK-0004j6-Mo
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:27:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zLiR6sPXhke3EqWSPYNu8qerXI2Xuhs1e99q959vwn8=; b=NUnIHaEgOf08PZfOHdjyLAf8W2
 vwkP5DPNfTg6gG1/lzN3n4xxtXTd6HxPivk4G5yLUjjuUJfMxEDwvYz8S8qwIo8nLUnzn2HYpvOK9
 2+1RHQP1glZkARAJuFxNDG4WvlPDXP3zc8tduS1A0hLqWUwH2Mu0tJfrqnyCLFmxYxcM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zLiR6sPXhke3EqWSPYNu8qerXI2Xuhs1e99q959vwn8=; b=T
 7M/rvhdX/t7TCGljnkK1LCEGoOH+qq13scSyORD72c071xo8kRNWqPN0/K1uXhy16R6u32vL1iQ9d
 lgtoGCHZzX0XjYwi2LXKygOhHZQHL//osW9lMi3BHsq49jdmEozbo4de+zh4k/AXQEANJCHUuG4El
 VDN7vlBhjWfQOb1Y=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4CiE-0006bj-KQ for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:27:23 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-499b2981a7bso59468205e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 00:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788938832; x=1789543632; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zLiR6sPXhke3EqWSPYNu8qerXI2Xuhs1e99q959vwn8=;
 b=bjc49q5iOPeyDuUBApazj39mP6FjSooGI13lPUZdlwPNJ9KxZ6n1RfXT0PzQ2CqwrR
 tAS/54wrzLf6kHh8wyYRWuTYVXA9uTYR7pIjWzij+EL9jhs7BTmjHw31bYI76sOjfF3y
 2FIjuUVA/AIfHsgyVWqgxKoq2eEBNIIYqbgDYy249wFLeqbJdS7htQm+hAptMTyATkyZ
 bBIbceqisnpRJUX+c1Tc/I2xdwHTNKWy3Xeuz5m+UCQocwgx72hOiKfnkg7oL9YcP+WM
 ey0do89PAW0efHkcg7YAaxyi2jXZD0+D/kPKyWPl9jDNAeTB7C4N/5DGfQ/o0VSOusDF
 NCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788938832; x=1789543632;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zLiR6sPXhke3EqWSPYNu8qerXI2Xuhs1e99q959vwn8=;
 b=UkyEtXjIatA6QIb80IRPm/nu9sz+efrFgyRDL6iVaxk+4EivZpfNNREwYntsDDoGkf
 Gpdb4ZhNpkG6sRzAaLyNoHFCooOdERyFBU/CI0NK5hKBvcAerKu4eHFFRFxp2uVie1V4
 UGdvyi3n2xpzxb5eAOhqaDyPnRYds3QcUeBQBiwLGvVuyoS0uf3XM/ZythHSBHStpzEJ
 Si0DOutzkfMlN1e3fl+/ezT1xVkmQIz2BqM/zmhCCdgikW2pTBBaYFtRFCQtgnFlUt17
 uZDMG/dGKO5cD4saKnJ6wQvzUVOqUQ/xZERuEtHhF6YIDW6wXw0qvYwnTiayAGikanr7
 S+mg==
X-Forwarded-Encrypted: i=1;
 AKwUvByZq6QuXnikBuBleq/I+xjLASK4mgxBogkC6p8BLxArCCz+DvxkqA5OxOcgeg1QVxVZOBByzAL/DLLpsn6p@lists.sourceforge.net
X-Gm-Message-State: AFuF++leE0nq3zENPG5bEGIne3L4JmlQ1MLzO0aMzMeANGbTXG5qr9wo
 cgbxpXI5SPF+adfH1kh1TTzGgmkiM640FsmifruERXK3NBlKDI7oWWM8PxYVmodYrltng/hFF9l
 uopDT/VyA8VfAHEHl05Yi1BnvGRoqL5oG7YLC3QmZrV5SyTAbWW48Zc2GMPledW4JlsaS
X-Gm-Gg: AYBFou2/SRvTlVbWUdczUmnjeoHjq/Nh5b6opAICuJdZ+0CeKVjiysE//g9PxnJ49k+
 j7cS/E/iPTKB8ZLhqjZApGZawccy39tiKEoZXDPlxzDJ4ZW6SXT+e9OHA9eYYWE1rTp0VmMBAli
 GNnq9G/zaIBLBsvBr2iDfG/0yHMwvh5nJFUupWB5sNGfSnRONAsG/GH3q7CiLcq6WMG2x2nciZD
 mPnbDwC9wnyKEGWkxQTD07nuFdCbFURTukIKJGiqQC5mxDRNQ69Y/AgqNaOWjs2VJYRMyYZyqkW
 iKeHZhbjnPbxcMS3Su3R7NGbyZ9Zs3AkcWCI6u6Gzjiz56WLvTyBiSeQ+kwWTNNhESg2vSnsaye
 jT89ADNwhgbYrOZd7ecTUUX2R0V3/EETF4UyUFFP4LmPGKIvbUhsAd6zq+Ym4HY94kD6Ey9Qxym
 a+2Hu6/OYm7r1OivFSqlVAHpyQZqwyvPziDpvx8ji9kyomCGRkcnr7M2XW1BxZUWk8vXEyfdWtw
 FGyY9gZIJ/+nS7xlPxsZRDVYyAzQoIo7vLz6FswNZodRJGQ5ifzQxjNsFxDmD12WuU32UH7t/pX
 LDEu7mp8taJRhYObICmIRHmf2HfSuaq27UlF1p/Ag8+9noGe4JjAe0Tz3J8VTw==
X-Received: by 2002:a05:600c:3f12:b0:49c:c8de:96a9 with SMTP id
 5b1f17b1804b1-49cf7fdd2dfmr692543095e9.2.1788938831771; 
 Wed, 09 Sep 2026 00:27:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d03543064sm359227585e9.13.2026.09.09.00.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 00:27:11 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 07:27:02 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: 67f1661f3e35af061ceec0138e4083e89321c541
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6c9090d64d41c4b26770c96025b911eeb46456a9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4CiE-0006bj-KQ
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2950800636648255775=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2950800636648255775==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yI580Zs5+XE="; charset=UTF-8

--yI580Zs5+XE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello plaisthos, ralf_lici, 

I'd like you to reexamine a change=
=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3D=
email

to look at the new patch set (#13)=2E

The following approvals got o=
utdated and were removed:
Code-Review-1 by ralf_lici


Change subject: oob:=
 Answer SERVER_PROBE on the server (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Answer SERVER_PROBE on the se=
rver (P_CONTROL_OOB_V1)

Make a --mode server UDP listener answer an out-of=
-band SERVER_PROBE without
creating a session, so probing costs the server =
no state:

  - tls_pre_decrypt_lite() accepts P_CONTROL_OOB_V1 and returns =
the new
    VERDICT_VALID_OOB_V1 verdict=2E
  - tls_wrap_oob_standalone() b=
uilds a session-less P_CONTROL_OOB_V1 packet:
    opcode + session id + the=
 usual tls-auth/tls-crypt wrapping around a bare
    TLV payload (no reliab=
ility/ACK fields), mirroring tls_reset_standalone()=2E
  - oob_client_reply=
_write() writes the PROBE_REPLY message (message-type
    header + probe_re=
ply TLV)=2E
  - do_pre_decrypt_check() handles the new verdict: it asks
   =
 oob_server_probe_accept() whether to answer, and if so builds the
    PROB=
E_REPLY, echoing the peer's session id, and sends it via
    send_probe_rep=
ly() (synchronous, stateless, like the HMAC reset path)
    and returns fal=
se so no session is created=2E The verdict joins the reset
    verdicts in =
the reflect_filter rate-limit check, so a probe flood is capped
    like a =
reset flood=2E

The reply carries, as its own session id, the stateless SYN=
-cookie the three-way
handshake uses, so the server keeps nothing per probe=
 and a client can later
reuse the reply as the server's reset=2E

Change-Id=
: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Signed-off-by: Lev Stipakov <le=
v@openvpn=2Enet>
---
M src/openvpn/mudp=2Ec
M src/openvpn/oob=2Ec
M src/ope=
nvpn/oob=2Eh
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/un=
it_tests/openvpn/test_pkt=2Ec
6 files changed, 229 insertions(+), 4 deletio=
ns(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
44/1744/13

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index =
de3d467=2E=2E7d54c96 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mu=
dp=2Ec
@@ -32,6 +32,7 @@
 
 #include "memdbg=2Eh"
 #include "ssl_pkt=2Eh"
+=
#include "oob=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inotify=2Eh>=

@@ -87,6 +88,34 @@
                           "Reset packet from client, s=
ending HMAC based reset challenge", sock);
 }
 
+/* Send an out-of-band PRO=
BE_REPLY back to the source of a SERVER_PROBE,
+ * synchronously and withou=
t keeping any state, mirroring the reset path=2E */
+static void
+send_prob=
e_reply(struct multi_context *m, struct tls_pre_decrypt_state *state,
+    =
             struct tls_auth_standalone *tas, const struct oob_probe_reply =
*reply,
+                 struct session_id *own_sid, struct link_socket *s=
ock)
+{
+    struct gc_arena gc =3D gc_new();
+
+    /* Build the payload o=
f the reply (message-type header + probe_reply TLV) */
+    struct buffer p=
ayload =3D alloc_buf_gc(128, &gc);
+    if (!oob_client_reply_write(&payloa=
d, reply))
+    {
+        gc_free(&gc);
+        return;
+    }
+
+    /* =
OOB replies use the same control-channel wrapping as the request */
+    re=
set_packet_id_send(&state->tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);
+    sta=
te->tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =3D true;
+
+    str=
uct buffer buf =3D tls_wrap_oob_standalone(&state->tls_wrap_tmp, tas, own_s=
id, &payload);
+    send_standalone_reply(m, &buf, "Server Probe", "Server =
probe from client, sending probe reply",
+                          sock);
=
+
+    gc_free(&gc);
+}
+
 
 /* Returns true if this packet should create a=
 new session */
 static bool
@@ -105,7 +134,8 @@
     const struct openvpn_=
sockaddr *from =3D &m->top=2Ec2=2Efrom=2Edest;
     int handwindow =3D m->t=
op=2Eoptions=2Ehandshake_window;
 
-    if (verdict =3D=3D VERDICT_VALID_RE=
SET_V3 || verdict =3D=3D VERDICT_VALID_RESET_V2)
+    if (verdict =3D=3D VE=
RDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VALID_RESET_V2
+        || v=
erdict =3D=3D VERDICT_VALID_OOB_V1)
     {
         /* Check if we are stil=
l below our limit for sending out
          * responses */
@@ -203,6 +233,3=
2 @@
 
         return ret;
     }
+    else if (verdict =3D=3D VERDICT_VAL=
ID_OOB_V1)
+    {
+        /* Out-of-band server probe=2E state->newbuf poi=
nts at the TLV payload
+         * (read_control_auth has stripped the opco=
de, session id and any
+         * tls-auth/tls-crypt wrapping)=2E Answer i=
t without creating a session=2E */
+        if (!oob_server_probe_accept(&s=
tate->newbuf, (uint64_t)now, (uint64_t)handwindow))
+        {
+           =
 /* malformed or replayed/stale probe: silently drop */
+            return=
 false;
+        }
+
+        /* the reply echoes the peer's session id */
=
+        struct oob_probe_reply reply =3D { =2Epeer_session_id =3D state->p=
eer_session_id };
+
+        /* Our session id is a stateless SYN cookie (t=
he same HMAC the three-way
+         * handshake uses): we keep no per-prob=
e state, and the reply can later
+         * also serve as the server's CON=
TROL_HARD_RESET_SERVER_V2, so a client
+         * can start the handshake =
from it (the connect_lifetime advertisement)=2E */
+        struct session_=
id sid =3D
+            calculate_session_id_hmac(state->peer_session_id, f=
rom, hmac_key, handwindow, 0);
+
+        send_probe_reply(m, state, tas, &=
reply, &sid, sock);
+
+        /* An OOB probe never creates a session */
+=
        return false;
+    }
 
     /* VERDICT_INVALID */
     return false=
;
diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index c8c7346=2E=
=2E3d48276 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -1=
06,6 +106,12 @@
 }
 
 bool
+oob_client_reply_write(struct buffer *buf, cons=
t struct oob_probe_reply *reply)
+{
+    return buf_write_u16(buf, OOB_MSG_=
PROBE_REPLY) && oob_probe_reply_write(buf, reply);
+}
+
+bool
 oob_timestam=
p_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs)
 {
     =
uint64_t diff =3D (now > probe_ts) ? (now - probe_ts) : (probe_ts - now);
d=
iff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 8c091fc=2E=2E95=
bb594 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -127,6 =
+127,12 @@
 bool oob_server_probe_read(struct buffer *payload, struct oob_p=
robe_parameter *param);
 
 /**
+ * Write a complete PROBE_REPLY message (me=
ssage-type header + probe_reply TLV)
+ * to buf=2E Sent by the server=2E
+ =
*/
+bool oob_client_reply_write(struct buffer *buf, const struct oob_probe_=
reply *reply);
+
+/**
  * Check whether a probe timestamp is within an acce=
ptable window around the
  * current time=2E Used to cheaply drop replayed =
or implausibly-timed probes
  * before doing any further work (see the prob=
e_parameter timestamp rationale
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/=
openvpn/ssl_pkt=2Ec
index 39cb648=2E=2E78552c4 100644
--- a/src/openvpn/ssl=
_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -314,7 +314,8 @@
 
     /* Allow =
only the reset packet or the first packet of the actual handshake=2E */
   =
  if (op !=3D P_CONTROL_HARD_RESET_CLIENT_V2 && op !=3D P_CONTROL_HARD_RESE=
T_CLIENT_V3
-        && op !=3D P_CONTROL_V1 && op !=3D P_CONTROL_WKC_V1 &&=
 op !=3D P_ACK_V1)
+        && op !=3D P_CONTROL_V1 && op !=3D P_CONTROL_WK=
C_V1 && op !=3D P_ACK_V1
+        && !opcode_is_oob(op))
     {
         /*=

          * This can occur due to bogus data or DoS packets=2E
@@ -389,6 +=
390,10 @@
     {
         return VERDICT_VALID_WKC_V1;
     }
+    else if =
(opcode_is_oob(op))
+    {
+        return VERDICT_VALID_OOB_V1;
+    }
   =
  else
     {
         return VERDICT_VALID_RESET_V2;
@@ -443,6 +448,29 @@
=
     return buf;
 }
 
+struct buffer
+tls_wrap_oob_standalone(struct tls_wr=
ap_ctx *ctx, struct tls_auth_standalone *tas,
+                        stru=
ct session_id *own_sid, const struct buffer *payload)
+{
+    /* Copy buffe=
r here to point at the same data but allow tls_wrap_control
+     * to pote=
ntially change buf to point to another buffer without
+     * modifying the=
 buffer in tas */
+    struct buffer buf =3D tas->workbuf;
+    ASSERT(buf_=
init(&buf, tas->frame=2Ebuf=2Eheadroom));
+
+    /* Out-of-band messages ca=
rry the payload directly, with no reliability
+     * or ACK fields=2E */
+=
    ASSERT(buf_copy(&buf, payload));
+
+    uint8_t header =3D (uint8_t)(P_=
CONTROL_OOB_V1 << P_OPCODE_SHIFT);
+
+    /* Add tls-auth/tls-crypt wrappin=
g, this might replace buf with
+     * ctx->work */
+    tls_wrap_control(c=
tx, header, &buf, own_sid);
+
+    return buf;
+}
+
 struct session_id
 cal=
culate_session_id_hmac(struct session_id client_sid, const struct openvpn_s=
ockaddr *from,
                           const uint8_t *key, int handwindo=
w, int offset)
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=
=2Eh
index d46b8c5=2E=2E581ec48 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/=
src/openvpn/ssl_pkt=2Eh
@@ -62,8 +62,9 @@
  * control channel session (e=2E=
g=2E a server probe)=2E Inherently unreliable:
  * there is no protocol-lev=
el retransmission=2E
  *
- * It is not legal on an established session; see=
 opcode_valid_in_session()
- * below=2E */
+ * On the server this is accept=
ed via the tls_pre_decrypt_lite() allowlist and
+ * handled in the new-conn=
ection path (it never creates a session)=2E It is not
+ * legal on an estab=
lished session; see opcode_valid_in_session() below=2E */
 #define P_CONTRO=
L_OOB_V1 12
 
 /* define the range of defined opcodes, in- and out-of-band=
=2E Note this is not
@@ -136,6 +137,9 @@
     VERDICT_VALID_ACK_V1,
     /*=
* The packet is a valid control packet with appended wrapped client key */
=
     VERDICT_VALID_WKC_V1,
+    /** This packet is a valid out-of-band cont=
rol message (e=2Eg=2E a server
+     * probe)=2E It does not belong to a se=
ssion and must not create one=2E */
+    VERDICT_VALID_OOB_V1,
     /** the=
 packet failed on of the various checks */
     VERDICT_INVALID
 };
@@ -256=
,6 +260,21 @@
                                    struct session_id *own_si=
d, struct session_id *remote_sid,
                                    uint8=
_t header, bool request_resend_wkc);
 
+/**
+ * Wrap an already-built out-o=
f-band payload (e=2Eg=2E probe-reply TLVs) into a
+ * standalone, session-l=
ess P_CONTROL_OOB_V1 packet: it prepends the opcode and
+ * own_sid and app=
lies the same tls-auth/tls-crypt wrapping as a regular
+ * control packet, =
but carries no reliability/ACK fields=2E
+ *
+ * @param ctx       tls wrapp=
ing context (from the pre-decrypt state)
+ * @param tas       standalone au=
th context providing the work buffer
+ * @param own_sid   session id to use=
 as our session id in the header
+ * @param payload   the OOB message paylo=
ad (TLV stream) to wrap
+ * @return          the wrapped packet buffer, rea=
dy to send
+ */
+struct buffer tls_wrap_oob_standalone(struct tls_wrap_ctx =
*ctx, struct tls_auth_standalone *tas,
+                                   =
   struct session_id *own_sid, const struct buffer *payload);
+
 
 /**
  * =
Extracts a control channel message from buf and adjusts the size of
diff --=
git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test=
_pkt=2Ec
index a732c2b=2E=2Eca3045a 100644
--- a/tests/unit_tests/openvpn/t=
est_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -695,6 +695,113 =
@@
     free_tas(&tas_server);
 }
 
+/* Payload every OOB round-trip below =
wraps: a message header and one TLV=2E */
+static const uint8_t oob_payload=
[] =3D { 0x01, 0x00, 0x00, 0x01, 0x00, 0x04, 0xde, 0xad, 0xbe, 0xef };
+
+/=
* Wrap oob_payload as a standalone P_CONTROL_OOB_V1 with the client side of=
 a
+ * tls-auth/tls-crypt pair (or none), run it through the server's state=
less
+ * first-packet path, and check verdict, recovered session id and pay=
load=2E */
+static void
+oob_standalone_roundtrip(struct tls_auth_standalon=
e *tas_client,
+                         struct tls_auth_standalone *tas_se=
rver)
+{
+    struct link_socket_actual from =3D { 0 };
+    struct tls_pre=
_decrypt_state state =3D { 0 };
+    struct session_id sid =3D { { 0x0b, 1,=
 2, 3, 4, 5, 6, 0x0b } };
+
+    struct buffer payload =3D alloc_buf(64);
+=
    buf_write(&payload, oob_payload, sizeof(oob_payload));
+
+    /* Client=
 side: opcode + session id + tls-auth/tls-crypt wrapping around the
+     *=
 bare payload, with none of the reliability/ACK fields a control packet
+  =
   * carries=2E */
+    struct buffer buf =3D
+        tls_wrap_oob_standal=
one(&tas_client->tls_wrap, tas_client, &sid, &payload);
+    assert_int_equ=
al((BPTR(&buf))[0] >> P_OPCODE_SHIFT, P_CONTROL_OOB_V1);
+
+    /* Server s=
ide: the stateless first-packet path must recognise the opcode,
+     * ver=
ify the wrapping and leave exactly the payload in newbuf -- that is
+     *=
 what mudp=2Ec hands to the probe parser=2E */
+    enum first_packet_verdi=
ct verdict =3D tls_pre_decrypt_lite(tas_server, &state, &from, &buf);
+    =
assert_int_equal(verdict, VERDICT_VALID_OOB_V1);
+    assert_memory_equal(s=
tate=2Epeer_session_id=2Eid, sid=2Eid, SID_SIZE);
+    assert_int_equal(BLE=
N(&state=2Enewbuf), (int)sizeof(oob_payload));
+    assert_memory_equal(BPT=
R(&state=2Enewbuf), oob_payload, sizeof(oob_payload));
+    free_tls_pre_de=
crypt_state(&state);
+
+    /* Tampering with any single byte must fail aut=
hentication: the flip runs
+     * over opcode, session id, packet id, HMAC=
/tag and payload alike=2E Skipped
+     * for TLS_WRAP_NONE, where a change=
d payload is legitimately accepted=2E */
+    if (tas_server->tls_wrap=2Emo=
de !=3D TLS_WRAP_NONE)
+    {
+        struct buffer copy =3D alloc_buf(BLE=
N(&buf));
+        for (int i =3D 0; i < BLEN(&buf); i++)
+        {
+     =
       buf_reset_len(&copy);
+            buf_write(&copy, BPTR(&buf), BLEN=
(&buf));
+            (BPTR(&copy))[i] ^=3D 0xff;
+            struct tls_p=
re_decrypt_state tstate =3D { 0 };
+            verdict =3D tls_pre_decrypt=
_lite(tas_server, &tstate, &from, &copy);
+            assert_int_equal(ver=
dict, VERDICT_INVALID);
+            free_tls_pre_decrypt_state(&tstate);
+=
        }
+        free_buf(&copy);
+    }
+
+    free_buf(&payload);
+}
+
=
+static void
+test_oob_standalone_plain(void **ut_state)
+{
+    struct tls=
_auth_standalone tas =3D { 0 };
+    struct frame frame =3D { =2Ebuf =3D { =
=2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };
+    tas=2Eframe =3D =
frame;
+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;
+    tas=2Eworkbuf =3D=
 alloc_buf(1600);
+
+    oob_standalone_roundtrip(&tas, &tas);
+
+    free_=
tas(&tas);
+}
+
+static void
+test_oob_standalone_tls_auth(void **ut_state)=

+{
+    struct tls_auth_standalone tas_server =3D init_tas_auth(KEY_DIRECT=
ION_NORMAL);
+    struct tls_auth_standalone tas_client =3D init_tas_auth(K=
EY_DIRECTION_INVERSE);
+    packet_id_init(&tas_client=2Etls_wrap=2Eopt=2Ep=
acket_id, 5, 5, "UNITTEST", 0);
+    /* the server consumes the tls-auth pa=
cket id only with packet-id state,
+     * which tls_auth_standalone_init()=
 sets up for the real one */
+    packet_id_init(&tas_server=2Etls_wrap=2Eo=
pt=2Epacket_id, 5, 5, "UNITTEST", 0);
+
+    now =3D 0x22446688;
+    oob_s=
tandalone_roundtrip(&tas_client, &tas_server);
+
+    packet_id_free(&tas_c=
lient=2Etls_wrap=2Eopt=2Epacket_id);
+    packet_id_free(&tas_server=2Etls_=
wrap=2Eopt=2Epacket_id);
+    free_tas(&tas_client);
+    free_tas(&tas_ser=
ver);
+}
+
+static void
+test_oob_standalone_tls_crypt(void **ut_state)
+{
=
+    struct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_=
size =3D 1400 }, 0 };
+    struct tls_auth_standalone tas_server =3D init_t=
as_crypt(true);
+    struct tls_auth_standalone tas_client =3D init_tas_cry=
pt(false);
+    tas_server=2Eframe =3D frame;
+    tas_client=2Eframe =3D f=
rame;
+    packet_id_init(&tas_client=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "=
UNITTEST", 0);
+
+    now =3D 0x22446688;
+    oob_standalone_roundtrip(&ta=
s_client, &tas_server);
+
+    packet_id_free(&tas_client=2Etls_wrap=2Eopt=
=2Epacket_id);
+    free_tas(&tas_client);
+    free_tas(&tas_server);
+}
+=

 static void
 test_extract_control_message(void **ut_state)
 {
@@ -745,6 +=
852,9 @@
         cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),=

         cmocka_unit_test(test_generate_reset_packet_plain),
         cmoc=
ka_unit_test(test_generate_reset_packet_tls_auth),
+        cmocka_unit_tes=
t(test_oob_standalone_plain),
+        cmocka_unit_test(test_oob_standalone=
_tls_auth),
+        cmocka_unit_test(test_oob_standalone_tls_crypt),
     =
    cmocka_unit_test(test_extract_control_message)
     };
 

-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d1=
08343d59f0
Gerrit-Change-Number: 1744
Gerrit-PatchSet: 13
Gerrit-Owner: sti=
pa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Att=
ention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov=
@gmail=2Ecom>

--yI580Zs5+XE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #13</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Re=
view-1 by ralf_lici</p><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">oob: Answer SERVER_PROBE on the server=
 (P_CONTROL_OOB_V1)<br><br>Make a --mode server UDP listener answer an out-=
of-band SERVER_PROBE without<br>creating a session, so probing costs the se=
rver no state:<br><br>  - tls_pre_decrypt_lite() accepts P_CONTROL_OOB_V1 a=
nd returns the new<br>    VERDICT_VALID_OOB_V1 verdict=2E<br>  - tls_wrap_o=
ob_standalone() builds a session-less P_CONTROL_OOB_V1 packet:<br>    opcod=
e + session id + the usual tls-auth/tls-crypt wrapping around a bare<br>   =
 TLV payload (no reliability/ACK fields), mirroring tls_reset_standalone()=
=2E<br>  - oob_client_reply_write() writes the PROBE_REPLY message (message=
-type<br>    header + probe_reply TLV)=2E<br>  - do_pre_decrypt_check() han=
dles the new verdict: it asks<br>    oob_server_probe_accept() whether to a=
nswer, and if so builds the<br>    PROBE_REPLY, echoing the peer&#39;s sess=
ion id, and sends it via<br>    send_probe_reply() (synchronous, stateless,=
 like the HMAC reset path)<br>    and returns false so no session is create=
d=2E The verdict joins the reset<br>    verdicts in the reflect_filter rate=
-limit check, so a probe flood is capped<br>    like a reset flood=2E<br><b=
r>The reply carries, as its own session id, the stateless SYN-cookie the th=
ree-way<br>handshake uses, so the server keeps nothing per probe and a clie=
nt can later<br>reuse the reply as the server&#39;s reset=2E<br><br>Change-=
Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0<br>Signed-off-by: Lev Stipako=
v &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>M src/openv=
pn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M src/openvpn/ssl_pkt=2Ec<br>M src/o=
penvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>6 files ch=
anged, 229 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/44/1744/13</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>=
index de3d467=2E=2E7d54c96 100644</span><br><span>--- a/src/openvpn/mudp=2E=
c</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -32,6 +32,7=
 @@</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</spa=
n><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><span> </s=
pan><br><span> #ifdef HAVE_SYS_INOTIFY_H</span><br><span> #include &lt;sys/=
inotify=2Eh&gt;</span><br><span>@@ -87,6 +88,34 @@</span><br><span>        =
                   &quot;Reset packet from client, sending HMAC based reset=
 challenge&quot;, sock);</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Send an out-of-band PROBE_REPL=
Y back to the source of a SERVER_PROBE,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * synchronously and without keeping any state, mirrori=
ng the reset path=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send=
_probe_reply(struct multi_context *m, struct tls_pre_decrypt_state *state,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 str=
uct tls_auth_standalone *tas, const struct oob_probe_reply *reply,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                 struct sess=
ion_id *own_sid, struct link_socket *sock)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* Build the payload of the reply (message-type header + probe_reply=
 TLV) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
buffer payload =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!oob_client_reply_write(&amp;payload, re=
ply))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* OOB replies use the same control-channel wrapping as=
 the request */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    state-&gt;tls_w=
rap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =3D true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer buf =3D tls_wrap_oob_standalone(&amp;sta=
te-&gt;tls_wrap_tmp, tas, own_sid, &amp;payload);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    send_standalone_reply(m, &amp;buf, &quot;=
Server Probe&quot;, &quot;Server probe from client, sending probe reply&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
          sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span> /*=
 Returns true if this packet should create a new session */</span><br><span=
> static bool</span><br><span>@@ -105,7 +134,8 @@</span><br><span>     cons=
t struct openvpn_sockaddr *from =3D &amp;m-&gt;top=2Ec2=2Efrom=2Edest;</spa=
n><br><span>     int handwindow =3D m-&gt;top=2Eoptions=2Ehandshake_window;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VALID_=
RESET_V2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ve=
rdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VALID_RESET_V=
2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || verdict=
 =3D=3D VERDICT_VALID_OOB_V1)</span><br><span>     {</span><br><span>      =
   /* Check if we are still below our limit for sending out</span><br><span=
>          * responses */</span><br><span>@@ -203,6 +233,32 @@</span><br><s=
pan> </span><br><span>         return ret;</span><br><span>     }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    else if (verdict =3D=3D V=
ERDICT_VALID_OOB_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Ou=
t-of-band server probe=2E state-&gt;newbuf points at the TLV payload</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+         * (read_control_a=
uth has stripped the opcode, session id and any</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+         * tls-auth/tls-crypt wrapping)=2E Answ=
er it without creating a session=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (!oob_server_probe_accept(&amp;state-&gt;newb=
uf, (uint64_t)now, (uint64_t)handwindow))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            /* malformed or replayed/stale probe: silently drop=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        /* the reply echoes the peer&#3=
9;s session id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      struct oob_probe_reply reply =3D { =2Epeer_session_id =3D state-&gt;p=
eer_session_id };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Our sessio=
n id is a stateless SYN cookie (the same HMAC the three-way</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * handshake uses): we keep=
 no per-probe state, and the reply can later</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+         * also serve as the server&#39;s CONTROL_=
HARD_RESET_SERVER_V2, so a client</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * can start the handshake from it (the connect_lifet=
ime advertisement)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        struct session_id sid =3D</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            calculate_session_id_hmac(state-&gt;peer_ses=
sion_id, from, hmac_key, handwindow, 0);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        send_probe_reply(m, state, tas, &amp;reply, &amp;sid, sock);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* An OOB probe never creates a s=
ession */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span> </span><br><span>     /* VERDICT_INVALID */</span><br><span>=
     return false;</span><br><span>diff --git a/src/openvpn/oob=2Ec b/src/o=
penvpn/oob=2Ec</span><br><span>index c8c7346=2E=2E3d48276 100644</span><br>=
<span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</=
span><br><span>@@ -106,6 +106,12 @@</span><br><span> }</span><br><span> </s=
pan><br><span> bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
oob_client_reply_write(struct buffer *buf, const struct oob_probe_reply *re=
ply)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u16(buf, OOB=
_MSG_PROBE_REPLY) &amp;&amp; oob_probe_reply_write(buf, reply);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool</span><br><span> oob_timestamp_in_window(uint64_t probe_ts, uin=
t64_t now, uint64_t window_secs)</span><br><span> {</span><br><span>     ui=
nt64_t diff =3D (now &gt; probe_ts) ? (now - probe_ts) : (probe_ts - now);<=
/span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</spa=
n><br><span>index 8c091fc=2E=2E95bb594 100644</span><br><span>--- a/src/ope=
nvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -=
127,6 +127,12 @@</span><br><span> bool oob_server_probe_read(struct buffer =
*payload, struct oob_probe_parameter *param);</span><br><span> </span><br><=
span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a=
 complete PROBE_REPLY message (message-type header + probe_reply TLV)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to buf=2E Sent by the =
server=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_client_reply_writ=
e(struct buffer *buf, const struct oob_probe_reply *reply);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span>  * Check whether a probe timestam=
p is within an acceptable window around the</span><br><span>  * current tim=
e=2E Used to cheaply drop replayed or implausibly-timed probes</span><br><s=
pan>  * before doing any further work (see the probe_parameter timestamp ra=
tionale</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/=
ssl_pkt=2Ec</span><br><span>index 39cb648=2E=2E78552c4 100644</span><br><sp=
an>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=
=2Ec</span><br><span>@@ -314,7 +314,8 @@</span><br><span> </span><br><span>=
     /* Allow only the reset packet or the first packet of the actual hands=
hake=2E */</span><br><span>     if (op !=3D P_CONTROL_HARD_RESET_CLIENT_V2 =
&amp;&amp; op !=3D P_CONTROL_HARD_RESET_CLIENT_V3</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        &amp;&amp; op !=3D P_CONTROL_V1 &amp;&a=
mp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op !=3D P_ACK_V1)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; op !=3D P_CONTROL_=
V1 &amp;&amp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op !=3D P_ACK_V1</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !opcode_i=
s_oob(op))</span><br><span>     {</span><br><span>         /*</span><br><sp=
an>          * This can occur due to bogus data or DoS packets=2E</span><br=
><span>@@ -389,6 +390,10 @@</span><br><span>     {</span><br><span>        =
 return VERDICT_VALID_WKC_V1;</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (opcode_is_oob(op))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return VERDICT_VALID_OOB_V1;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>  =
   else</span><br><span>     {</span><br><span>         return VERDICT_VALI=
D_RESET_V2;</span><br><span>@@ -443,6 +448,29 @@</span><br><span>     retur=
n buf;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+struct buffer</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct =
tls_auth_standalone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        struct session_id *own_sid, const struct buff=
er *payload)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Copy buffer here t=
o point at the same data but allow tls_wrap_control</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * to potentially change buf to point=
 to another buffer without</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * modifying the buffer in tas */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct buffer buf =3D tas-&gt;workbuf;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_init(&amp;bu=
f, tas-&gt;frame=2Ebuf=2Eheadroom));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* Out-of-band messages carry the payload directly, with no reliability</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * or ACK fields=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(bu=
f_copy(&amp;buf, payload));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t=
 header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* Add tls-auth/tls-crypt wrapping, this migh=
t replace buf with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * ctx-&gt;work */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    tls_wrap_control(ctx, header, &amp;buf, own_sid);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return buf;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> struct session_id</span><br><span> calculate_session_id_hmac(s=
truct session_id client_sid, const struct openvpn_sockaddr *from,</span><br=
><span>                           const uint8_t *key, int handwindow, int o=
ffset)</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/s=
sl_pkt=2Eh</span><br><span>index d46b8c5=2E=2E581ec48 100644</span><br><spa=
n>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=
=2Eh</span><br><span>@@ -62,8 +62,9 @@</span><br><span>  * control channel =
session (e=2Eg=2E a server probe)=2E Inherently unreliable:</span><br><span=
>  * there is no protocol-level retransmission=2E</span><br><span>  *</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * It is not legal on an es=
tablished session; see opcode_valid_in_session()</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * below=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * On the server this is accepted via the tls_pre_dec=
rypt_lite() allowlist and</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * handled in the new-connection path (it never creates a session)=2E=
 It is not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * legal =
on an established session; see opcode_valid_in_session() below=2E */</span>=
<br><span> #define P_CONTROL_OOB_V1 12</span><br><span> </span><br><span> /=
* define the range of defined opcodes, in- and out-of-band=2E Note this is =
not</span><br><span>@@ -136,6 +137,9 @@</span><br><span>     VERDICT_VALID_=
ACK_V1,</span><br><span>     /** The packet is a valid control packet with =
appended wrapped client key */</span><br><span>     VERDICT_VALID_WKC_V1,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** This packet i=
s a valid out-of-band control message (e=2Eg=2E a server</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * probe)=2E It does not belong to=
 a session and must not create one=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    VERDICT_VALID_OOB_V1,</span><br><span>     /** the=
 packet failed on of the various checks */</span><br><span>     VERDICT_INV=
ALID</span><br><span> };</span><br><span>@@ -256,6 +260,21 @@</span><br><sp=
an>                                    struct session_id *own_sid, struct s=
ession_id *remote_sid,</span><br><span>                                    =
uint8_t header, bool request_resend_wkc);</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Wrap an already-built out-of-band payload (e=2Eg=
=2E probe-reply TLVs) into a</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * standalone, session-less P_CONTROL_OOB_V1 packet: it prepends t=
he opcode and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * own=
_sid and applies the same tls-auth/tls-crypt wrapping as a regular</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * control packet, but carri=
es no reliability/ACK fields=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram ctx       tls wrapping context (from the pre-decrypt state)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param tas       standalone=
 auth context providing the work buffer</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param own_sid   session id to use as our session id=
 in the header</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram payload   the OOB message payload (TLV stream) to wrap</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @return          the wrapped pac=
ket buffer, ready to send</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buf=
fer tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_stand=
alone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                              struct session_id *own_sid, const struct buff=
er *payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> </span><br><span> /**</span><br><span>  * Extracts a control ch=
annel message from buf and adjusts the size of</span><br><span>diff --git a=
/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=
=2Ec</span><br><span>index a732c2b=2E=2Eca3045a 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_te=
sts/openvpn/test_pkt=2Ec</span><br><span>@@ -695,6 +695,113 @@</span><br><s=
pan>     free_tas(&amp;tas_server);</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Payload every OOB r=
ound-trip below wraps: a message header and one TLV=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static const uint8_t oob_payload[] =
=3D { 0x01, 0x00, 0x00, 0x01, 0x00, 0x04, 0xde, 0xad, 0xbe, 0xef };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* Wrap oob_payload as a standalone P_CONTROL_=
OOB_V1 with the client side of a</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * tls-auth/tls-crypt pair (or none), run it through the serve=
r&#39;s stateless</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 first-packet path, and check verdict, recovered session id and payload=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_standalone_roundtrip(=
struct tls_auth_standalone *tas_client,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                         struct tls_auth_standalone *ta=
s_server)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct link_socket_actua=
l from =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct tls_pre_decrypt_state state =3D { 0 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct session_id sid =3D { { 0x0b, 1, 2, 3=
, 4, 5, 6, 0x0b } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
payload =3D alloc_buf(64);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    buf_write(&amp;payload, oob_payload, sizeof(oob_payload));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* Client side: opcode + session id + tl=
s-auth/tls-crypt wrapping around the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * bare payload, with none of the reliability/ACK fiel=
ds a control packet</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * carries=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct buffer buf =3D</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        tls_wrap_oob_standalone(&amp;tas_client-&gt;tls_wrap, tas_cl=
ient, &amp;sid, &amp;payload);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal((BPTR(&amp;buf))[0] &gt;&gt; P_OPCODE_SHIFT=
, P_CONTROL_OOB_V1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Server side=
: the stateless first-packet path must recognise the opcode,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * verify the wrapping and lea=
ve exactly the payload in newbuf -- that is</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * what mudp=2Ec hands to the probe parser=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    enum first_pac=
ket_verdict verdict =3D tls_pre_decrypt_lite(tas_server, &amp;state, &amp;f=
rom, &amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(verdict, VERDICT_VALID_OOB_V1);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_memory_equal(state=2Epeer_session_i=
d=2Eid, sid=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(BLEN(&amp;state=2Enewbuf), (int)sizeof(oob_pa=
yload));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
memory_equal(BPTR(&amp;state=2Enewbuf), oob_payload, sizeof(oob_payload));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_tls_pre_dec=
rypt_state(&amp;state);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Tamperin=
g with any single byte must fail authentication: the flip runs</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * over opcode, session id, =
packet id, HMAC/tag and payload alike=2E Skipped</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * for TLS_WRAP_NONE, where a changed payl=
oad is legitimately accepted=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (tas_server-&gt;tls_wrap=2Emode !=3D TLS_WRAP_NONE)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        struct buffer copy =3D allo=
c_buf(BLEN(&amp;buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        for (int i =3D 0; i &lt; BLEN(&amp;buf); i++)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            buf_reset_len(&amp;copy);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            buf_write(&amp;cop=
y, BPTR(&amp;buf), BLEN(&amp;buf));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            (BPTR(&amp;copy))[i] ^=3D 0xff;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            struct tls_pre_decrypt_=
state tstate =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            verdict =3D tls_pre_decrypt_lite(tas_server, &amp;tstate, &=
amp;from, &amp;copy);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            assert_int_equal(verdict, VERDICT_INVALID);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            free_tls_pre_decrypt_stat=
e(&amp;tstate);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free_b=
uf(&amp;copy);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;payload);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_oob_standalone_plain(void **ut_state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct tls_auth_standalone tas =3D { 0 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct frame frame =3D { =2Ebuf =3D { =
=2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    tas=2Eframe =3D frame;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    tas=2Etls_wrap=2Emode =3D TLS_=
WRAP_NONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas=
=2Eworkbuf =3D alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob=
_standalone_roundtrip(&amp;tas, &amp;tas);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    free_tas(&amp;tas);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_oob_standalone_tls_auth(void **u=
t_state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalon=
e tas_server =3D init_tas_auth(KEY_DIRECTION_NORMAL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone tas_client=
 =3D init_tas_auth(KEY_DIRECTION_INVERSE);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas_client=2Etls_wrap=2Eopt=
=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* the server consumes the tls-auth packet id=
 only with packet-id state,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * which tls_auth_standalone_init() sets up for the real one */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(=
&amp;tas_server=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    now =3D 0x22446688;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    oob_standalone_roundtrip(&am=
p;tas_client, &amp;tas_server);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pac=
ket_id_free(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas_server=
=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    free_tas(&amp;tas_client);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    free_tas(&amp;tas_server);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_oob_st=
andalone_tls_crypt(void **ut_state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_siz=
e =3D 1400 }, 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct tls_auth_standalone tas_server =3D init_tas_crypt(true);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalo=
ne tas_client =3D init_tas_crypt(false);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    tas_server=2Eframe =3D frame;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Eframe =3D frame;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;ta=
s_client=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    now =3D 0x22446688;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    oob_standalone_roundtrip(&amp;tas=
_client, &amp;tas_server);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_i=
d_free(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free_tas(&amp;tas_client);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    free_tas(&amp;tas_server);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><=
br><span> test_extract_control_message(void **ut_state)</span><br><span> {<=
/span><br><span>@@ -745,6 +852,9 @@</span><br><span>         cmocka_unit_te=
st(test_verify_hmac_none_out_of_range_ack),</span><br><span>         cmocka=
_unit_test(test_generate_reset_packet_plain),</span><br><span>         cmoc=
ka_unit_test(test_generate_reset_packet_tls_auth),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_oob_standalone=
_plain),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmo=
cka_unit_test(test_oob_standalone_tls_auth),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_oob_standalone_tls_c=
rypt),</span><br><span>         cmocka_unit_test(test_extract_control_messa=
ge)</span><br><span>     };</span><br><span> </span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1744?usp=3Demail">change 1744</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1744?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpat=
chset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0 </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 1744 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> =
Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flicht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>

</body></html>
--yI580Zs5+XE=--


--===============2950800636648255775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2950800636648255775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2950800636648255775==--

