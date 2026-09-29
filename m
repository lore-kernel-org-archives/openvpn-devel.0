Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4440CA5FAE
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i/d78gsYGiGAHC3ku6A0xmwMhSKkEhQuowOpj78rhN8=; b=N8WPlHPcC311S1cxoaVjCogeuM
	vXTYwXY3vFVfVpLjo/LuHDGYx2VRs6610jHfzADCTJkgnDGvmd/sISGv5feVLQjXv1FDvTwMsn9CC
	blGUWgju17Yej+IAZbsdYsndqbux7xZSvSKleE+v/D75BfzyB9Q1MAumMEzF92KbZQp4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBXhZ-0003c0-Dp;
	Tue, 29 Sep 2026 13:16:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBXhY-0003br-4T
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:16:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vVshNPHFgpTwuy57CqukS2VoePlD4Bb2foE65/AHQGw=; b=NMJxSRRQ+pQrTarsmBSdH86lxS
 ONFULnkai5Gt48GnETrzgu4UAkwCO4CXDr5MJU9ASgvAKBCVCVZL9g1EzKCSz4/14ealHzSbzqQjf
 9OIBTJkBxOY85joTEImkxJWFFtv7bs8uWSaF+kJL2Ps2JgjnnDwEqI6xWPiXVjBaPawM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vVshNPHFgpTwuy57CqukS2VoePlD4Bb2foE65/AHQGw=; b=X
 qLL2RB8mr0mnY9871LArN03vdYTFB6pe1LzUc3Qk0LWuw+gwCJzgUTDK1NCL5Vcuu4J/n8Gbfk2CL
 6U3iF9DFZ2f6+vkmBiPT9vXOvjar5Q37rJ6YzYAo/8+XzgeX7QsnpkA5iDGVuPrsekLsvMLOgQ1l4
 8wgMXyOTimhYhmtU=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBXhU-0007lG-Qu for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:16:56 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f635552aso3284054f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 06:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790687806; x=1791292606; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vVshNPHFgpTwuy57CqukS2VoePlD4Bb2foE65/AHQGw=;
 b=GfAE3jg0vFSAl1/v0UKXfHmme2n0JfnKOORVd5i3sD+KYkp4OnoZP4xRySaZEuvahc
 g6pqyUXAxu6Dm6ziix+0lhY/JqKqT6m9yyXM2qNW9sS8vOtOnj9GB9Rs3+I4xVyu7WPz
 n/oDz3C2XoRsLEGNRbOqry4o3QZV2UpqMV3aJbKFAFeh4twO64FcbY2Hd9Qal+Vv9hQM
 uQg1ZllMlhlcj1aMpXAhpmci4gDavF3xESU6Qtfa8T/ynle7vV2K5VTwtBocuO2a5u+v
 Ic+M5k6BNqma80jIoTZ/wpSxyi9jxxwOtz3VQGFDWg2P8zSGQYIuonrUV5KJJnnk/xzS
 0v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687806; x=1791292606;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vVshNPHFgpTwuy57CqukS2VoePlD4Bb2foE65/AHQGw=;
 b=pOqPATMoGpYbMxi0squ4FiPsBw26IN9ToJ//TVHuYzdCEL1tJdz79L53v8VL1kq+w4
 LWAwznDU8b5iAd/agHU2Mq16JARczYwCd2Ysww48Os8pUMfC4fWOium4Pl59HUpyF38Z
 GkLQ7jRe6MLJUKRkMMdaZsmnK93fuVXq2EA5eBVn9jg5hQRW6sYkSyZLdokSKT+9jmfz
 9on2a3EeX/TNEZ6YbyB/oABhlxqk862PDi0goyTGhqaBNJCroZYSVS3mADJ6ACzP6DRf
 Ue27BXGJ0NH+uQNm3dRHAC2B+Yn9BwuJgSBQd5Tt7A/O86UWxIT9M2d1I6hr6h/SJjM0
 yJpg==
X-Gm-Message-State: AFq9FYLGeupiUl3VLx0Ys2zntc3ieZM9GTOqohEUwx9h1XuXWXsV91pC
 oJeVe20PAR12yc7393kmGU7sWEXqTRkk+lkTH641KHEhA2cW0TeAG1mLmBQUnVu8lHFkdDipwzb
 F1/cQhcoqbQUhPqJ79r/fGkpe7ptNCi8uxuRxfyBfC8Iy2ZKYbwk66qb7V4ffQjKr9x3x
X-Gm-Gg: AYBFou1VkMjdOaEneMFEX+aP3gjKkz6ZWf8Bkx+A5NwaZPfn86rUnot42jLV0Ii+vIh
 FCI/N+mto4NPDdKzps8lcF9mMD4kkK8XOCNH0h5/xDRDu7TxDrBDqdVA9BdX+sgpgiQ8q+IdiuR
 iZ00Y5r1Jp7zToMBTNUPr91Hc8NlOWxkY236mM/Sb7z5L7YbCnv52hV69m0poh2ohnkTGStIGu0
 3wf9sCrsqRlwulF0PQ/I1Dg1A9Y1MaqWm3LGqt+/T36UHWl3o21y+kNSRPwWnAfOCbN6hL0bXX5
 gnl9n3sFWPDQGrcGfQguaovEogyiIxyqB+6lOoL/5q7VTP2b9gFv+7uUlm3TXq158MlAI6Tfgz9
 e1+AQGHVnskVu3ckjLpinpIl2aW5vwVkaSg0EMproW/1Wjl3hdcnGRejSofA2yqGwtHnRq5hKM9
 SLzEk4ptuMe4EcIHKjXmBSnmjFyf8d7DwD/YVmoXpJk1khVfcfhcimIln75Xz+4Qg3B/AFJQCJ0
 6DIBLHs+cz7SjCPy4SP07jy+wFdVDuVIeIjoZUr3AE2tY/1gqy28HyV22yOWzv4b3YdAHyQ9h4W
 8wkj+2/V0BzzxzAKhRvbgI6hwSce0y8gLXSQ853OKhDdwEt0Hc/X0gy5rY8A
X-Received: by 2002:a5d:588f:0:b0:488:ba61:e3be with SMTP id
 ffacd0b85a97d-488ba61e623mr13469064f8f.46.1790687805025; 
 Tue, 29 Sep 2026 06:16:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af5080925sm4001463f8f.25.2026.09.29.06.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:16:44 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 13:16:31 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: 44bd8f0869c586469dcbc122453b2e96aa931631
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <08615a129b9f5feb34afa5ac5383e1ce7273984f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBXhU-0007lG-Qu
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Answer
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
Content-Type: multipart/mixed; boundary="===============0128705945485072574=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0128705945485072574==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dS7XD01YU2w="; charset=UTF-8

--dS7XD01YU2w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello plaisthos, ralf_lici, 

I'd like you to reexamine a change=
=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3D=
email

to look at the new patch set (#19)=2E

The following approvals got o=
utdated and were removed:
Code-Review+1 by ralf_lici


Change subject: oob:=
 Answer SERVER_PROBE on the server (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Answer SERVER_PROBE on the se=
rver (P_CONTROL_OOB_V1)

Make a --mode server UDP listener answer an out-of=
-band SERVER_PROBE
without creating a session, so probing costs the server =
no state=2E

tls_pre_decrypt_lite() accepts P_CONTROL_OOB_V1 and returns th=
e new
VERDICT_VALID_OOB_V1, and tls_wrap_oob_standalone() wraps a bare OOB
=
message with the usual tls-auth/tls-crypt wrapping but no reliability
field=
s, mirroring tls_reset_standalone()=2E do_pre_decrypt_check()
classifies th=
e probe with oob_server_probe_check() and answers with a
PROBE_REPLY that e=
choes the probe's request_id=2E

A reply is charged against the same rate l=
imit as the reset replies,
once one is going to be sent, so a probe flood i=
s capped like a reset
flood=2E A stale probe, one whose timestamp is outsid=
e --hand-window, is
still answered, but only within a separate budget of a =
twentieth of
--connect-freq-initial per period (at least one): a client wit=
h a
skewed clock can still probe, and a replayed probe gets no more than
th=
at budget=2E The budget's limiter is quiet, as a replayed probe
hitting it =
is not worth a warning=2E

The reply carries, as its own session id, the st=
ateless SYN cookie the
three-way handshake uses, so the server keeps nothin=
g per probe and a
client can later start the handshake from the reply=2E

C=
hange-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Signed-off-by: Lev Stip=
akov <lev@openvpn=2Enet>
---
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec=

M src/openvpn/multi=2Eh
M src/openvpn/reflect_filter=2Ec
M src/openvpn/ref=
lect_filter=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openv=
pn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/test_pkt=2Ec
9 files changed, 248=
 insertions(+), 7 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/44/1744/19

diff --git a/src/openvpn/mudp=2Ec b/sr=
c/openvpn/mudp=2Ec
index de3d467=2E=2E3d20d21 100644
--- a/src/openvpn/mudp=
=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -32,6 +32,7 @@
 
 #include "memdbg=2Eh"
=
 #include "ssl_pkt=2Eh"
+#include "oob=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #=
include <sys/inotify=2Eh>
@@ -87,6 +88,34 @@
                           "Re=
set packet from client, sending HMAC based reset challenge", sock);
 }
 
+/=
* Send an out-of-band PROBE_REPLY back to the source of a SERVER_PROBE,
+ *=
 synchronously and without keeping any state, mirroring the reset path=2E *=
/
+static void
+send_probe_reply(struct multi_context *m, struct tls_pre_de=
crypt_state *state,
+                 struct tls_auth_standalone *tas, cons=
t struct oob_probe_reply *reply,
+                 struct session_id *own_s=
id, struct link_socket *sock)
+{
+    struct gc_arena gc =3D gc_new();
+
+ =
   /* A PROBE_REPLY carries just the probe reply TLV */
+    struct buffer =
payload =3D alloc_buf_gc(128, &gc);
+    if (!oob_probe_reply_write(&payloa=
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
@@ -203,6 +232,47 @@
 
         return ret;
  =
   }
+    else if (verdict =3D=3D VERDICT_VALID_OOB_V1)
+    {
+        /* =
Out-of-band server probe=2E state->newbuf points at the OOB message
+      =
   * (read_control_auth has stripped the opcode, session id and any
+      =
   * tls-auth/tls-crypt wrapping)=2E Answer it without creating a session=
=2E */
+        struct oob_probe_request req;
+        enum oob_probe_verdi=
ct probe =3D
+            oob_server_probe_check(&state->newbuf, (uint64_t)=
now, (uint64_t)handwindow, &req);
+        if (probe =3D=3D OOB_PROBE_INVAL=
ID)
+        {
+            return false; /* malformed: silently drop */
+ =
       }
+        /* A client whose clock is off by more than --hand-window=
 still gets a
+         * few probes per period answered, which is also all=
 a replayed probe
+         * can get=2E */
+        if (probe =3D=3D OOB_P=
ROBE_STALE && !reflect_filter_rate_limit_check(m->stale_probe_limiter))
+  =
      {
+            return false;
+        }
+        /* The reply counts =
against the same limit as the reset replies, charged
+         * only now t=
hat we know one is going to be sent=2E */
+        if (!reflect_filter_rate=
_limit_check(m->initial_rate_limiter))
+        {
+            return false=
;
+        }
+
+        /* the reply echoes the probe's request_id */
+    =
    struct oob_probe_reply reply =3D { =2Erequest_id =3D req=2Erequest_id }=
;
+
+        /* Our session id is a stateless SYN cookie (the same HMAC the=
 three-way
+         * handshake uses): we keep no per-probe state, and the=
 reply can later
+         * also serve as the server's CONTROL_HARD_RESET_=
SERVER_V2, so a client
+         * can start the handshake from it=2E */
+ =
       struct session_id sid =3D
+            calculate_session_id_hmac(sta=
te->peer_session_id, from, hmac_key, handwindow, 0);
+
+        send_probe_=
reply(m, state, tas, &reply, &sid, sock);
+
+        /* An OOB probe never =
creates a session */
+        return false;
+    }
 
     /* VERDICT_INVALI=
D */
     return false;
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mu=
lti=2Ec
index 3e72b92=2E=2Ea438a34 100644
--- a/src/openvpn/multi=2Ec
+++ b=
/src/openvpn/multi=2Ec
@@ -326,6 +326,12 @@
     m->new_connection_limiter =
=3D frequency_limit_init(t->options=2Ecf_max, t->options=2Ecf_per);
     m-=
>initial_rate_limiter =3D
         initial_rate_limit_init(t->options=2Ecf_=
initial_max, t->options=2Ecf_initial_per);
+    /* stale server probes: a t=
wentieth of the initial-packet rate, at least 1
+     * per period (5 per 1=
0 s by default, the wire protocol's own example)=2E
+     * Quiet, as a rep=
layed probe hitting the limit is not worth a warning=2E */
+    m->stale_pr=
obe_limiter =3D
+        initial_rate_limit_init(max_int(1, t->options=2Ecf=
_initial_max / 20), t->options=2Ecf_initial_per);
+    m->stale_probe_limit=
er->quiet =3D true;
 
     /*
      * Allocate broadcast/multicast buffer l=
ist
@@ -689,6 +695,7 @@
         ifconfig_pool_free(m->ifconfig_pool);
    =
     frequency_limit_free(m->new_connection_limiter);
         initial_rate=
_limit_free(m->initial_rate_limiter);
+        initial_rate_limit_free(m->s=
tale_probe_limiter);
         multi_reap_free(m->reaper);
         mroute_h=
elper_free(m->route_helper);
         multi_io_free(m->multi_io);
diff --gi=
t a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 6cb86c7=2E=2Ed85443=
8 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -178,6 =
+178,7 @@
     struct ifconfig_pool *ifconfig_pool;
     struct frequency_l=
imit *new_connection_limiter;
     struct initial_packet_rate_limit *initia=
l_rate_limiter;
+    struct initial_packet_rate_limit *stale_probe_limiter;=
 /**< stale SERVER_PROBE answers */
     struct mroute_helper *route_helper=
;
     struct multi_reap *reaper;
     struct mroute_addr local;
diff --git=
 a/src/openvpn/reflect_filter=2Ec b/src/openvpn/reflect_filter=2Ec
index e5=
226e4=2E=2E4887f01 100644
--- a/src/openvpn/reflect_filter=2Ec
+++ b/src/op=
envpn/reflect_filter=2Ec
@@ -44,7 +44,7 @@
     if (now > irl->last_period_=
reset + irl->period_length)
     {
         int64_t dropped =3D irl->curr_p=
eriod_counter - irl->max_per_period;
-        if (dropped > 0)
+        if =
(dropped > 0 && !irl->quiet)
         {
             msg(D_TLS_DEBUG_LOW,
 =
                "Dropped %" PRId64 " initial handshake packets"
@@ -60,7 +6=
0,7 @@
 
     bool over_limit =3D irl->curr_period_counter > irl->max_per_p=
eriod;
 
-    if (over_limit && !irl->warning_displayed)
+    if (over_limi=
t && !irl->warning_displayed && !irl->quiet)
     {
         msg(M_WARN,
  =
           "Note: --connect-freq-initial %" PRId64 " %d rate limit "
@@ -89=
,7 +89,7 @@
     struct initial_packet_rate_limit *irl;
 
 
-    ALLOC_OBJ(=
irl, struct initial_packet_rate_limit);
+    ALLOC_OBJ_CLEAR(irl, struct in=
itial_packet_rate_limit);
 
     irl->max_per_period =3D max_per_period;
  =
   irl->period_length =3D period_length;
diff --git a/src/openvpn/reflect_f=
ilter=2Eh b/src/openvpn/reflect_filter=2Eh
index 84915e8c6=2E=2Ee996d07 100=
644
--- a/src/openvpn/reflect_filter=2Eh
+++ b/src/openvpn/reflect_filter=
=2Eh
@@ -44,6 +44,9 @@
     /* we want to warn once per period that packets=
 are being started to
      * be dropped */
     bool warning_displayed;
+
=
+    /* drop silently: no per-period warning or summary in the log */
+    =
bool quiet;
 };
 
 
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
=
index 2864661=2E=2Ea6a67a2 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openv=
pn/ssl=2Ec
@@ -3706,7 +3706,8 @@
     struct session_id sid; /* remote sess=
ion ID */
 
     /* verify legal opcode=2E An out-of-band packet has no con=
trol message id and
-     * no ACK array, which is what we parse next=2E */=

+     * no ACK array, which is what we parse next; do_pre_decrypt_check() =
answers
+     * those=2E */
     if (op < P_FIRST_OPCODE || op > P_LAST_OPC=
ODE || opcode_is_oob(op))
     {
         if (op =3D=3D P_CONTROL_HARD_RESE=
T_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)
diff --git a/src/o=
penvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index 7f9ce1d27=2E=2Ee5c69b4 1=
00644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -168,7=
 +168,8 @@
 {
     ASSERT(ks->key_id >=3D 0 && ks->key_id <=3D P_KEY_ID_MAS=
K);
     ASSERT(opcode >=3D 0 && opcode <=3D P_LAST_OPCODE);
-    /* OOB pa=
ckets carry no message id or ACK array */
+    /* OOB packets carry no mess=
age id or ACK array; tls_wrap_oob_standalone()
+     * builds them */
     =
ASSERT(!opcode_is_oob(opcode));
     uint8_t header =3D (uint8_t)(ks->key_i=
d | (opcode << P_OPCODE_SHIFT));
 
@@ -316,7 +317,8 @@
 
     /* Allow only=
 the reset packet or the first packet of the actual handshake=2E */
     if=
 (op !=3D P_CONTROL_HARD_RESET_CLIENT_V2 && op !=3D P_CONTROL_HARD_RESET_CL=
IENT_V3
-        && op !=3D P_CONTROL_V1 && op !=3D P_CONTROL_WKC_V1 && op =
!=3D P_ACK_V1)
+        && op !=3D P_CONTROL_V1 && op !=3D P_CONTROL_WKC_V1=
 && op !=3D P_ACK_V1
+        && !opcode_is_oob(op))
     {
         /*
   =
       * This can occur due to bogus data or DoS packets=2E
@@ -391,6 +393,=
10 @@
     {
         return VERDICT_VALID_WKC_V1;
     }
+    else if (opc=
ode_is_oob(op))
+    {
+        return VERDICT_VALID_OOB_V1;
+    }
     el=
se
     {
         return VERDICT_VALID_RESET_V2;
@@ -445,6 +451,29 @@
    =
 return buf;
 }
 
+struct buffer
+tls_wrap_oob_standalone(struct tls_wrap_c=
tx *ctx, struct tls_auth_standalone *tas,
+                        struct s=
ession_id *own_sid, const struct buffer *payload)
+{
+    /* Copy buffer he=
re to point at the same data but allow tls_wrap_control
+     * to potentia=
lly change buf to point to another buffer without
+     * modifying the buf=
fer in tas */
+    struct buffer buf =3D tas->workbuf;
+    ASSERT(buf_init=
(&buf, tas->frame=2Ebuf=2Eheadroom));
+
+    /* Out-of-band messages carry =
the payload directly, with no reliability
+     * or ACK fields=2E */
+    =
ASSERT(buf_copy(&buf, payload));
+
+    uint8_t header =3D (uint8_t)(P_CONT=
ROL_OOB_V1 << P_OPCODE_SHIFT);
+
+    /* Add tls-auth/tls-crypt wrapping, t=
his might replace buf with
+     * ctx->work */
+    tls_wrap_control(ctx, =
header, &buf, own_sid);
+
+    return buf;
+}
+
 struct session_id
 calcula=
te_session_id_hmac(struct session_id client_sid, const struct openvpn_socka=
ddr *from,
                           const uint8_t *key, int handwindow, i=
nt offset)
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
i=
ndex d4fad04=2E=2E38e6665 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/op=
envpn/ssl_pkt=2Eh
@@ -60,7 +60,8 @@
 
 /* Out-of-band control message, e=2E=
g=2E a server probe=2E Not part of the reliable
  * control channel: no con=
trol message id and no ACK array, just a message
- * header and TLVs after =
the session id; never handled by tls_pre_decrypt()=2E */
+ * header and TLV=
s after the session id=2E Answered statelessly in
+ * do_pre_decrypt_check(=
), never handled by tls_pre_decrypt()=2E */
 #define P_CONTROL_OOB_V1 12
 
=
 /* define the range of defined opcodes, in- and out-of-band
@@ -106,6 +107=
,9 @@
     VERDICT_VALID_ACK_V1,
     /** The packet is a valid control pac=
ket with appended wrapped client key */
     VERDICT_VALID_WKC_V1,
+    /**=
 This packet is a valid out-of-band control message (e=2Eg=2E a server
+   =
  * probe)=2E It does not belong to a session and must not create one=2E */=

+    VERDICT_VALID_OOB_V1,
     /** the packet failed on of the various ch=
ecks */
     VERDICT_INVALID
 };
@@ -226,6 +230,21 @@
                     =
               struct session_id *own_sid, struct session_id *remote_sid,
 =
                                   uint8_t header, bool request_resend_wkc)=
;
 
+/**
+ * Wrap an already-built out-of-band message (e=2Eg=2E a PROBE_RE=
PLY) into a
+ * standalone, session-less P_CONTROL_OOB_V1 packet: it prepen=
ds the opcode and
+ * own_sid and applies the same tls-auth/tls-crypt wrapp=
ing as a regular
+ * control packet, but carries no reliability/ACK fields=
=2E
+ *
+ * @param ctx       tls wrapping context (from the pre-decrypt sta=
te)
+ * @param tas       standalone auth context providing the work buffer
=
+ * @param own_sid   session id to use as our session id in the header
+ * =
@param payload   the OOB message (header and TLVs) to wrap
+ * @return     =
     the wrapped packet buffer, ready to send
+ */
+struct buffer tls_wrap_=
oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
+=
                                      struct session_id *own_sid, const str=
uct buffer *payload);
+
 
 /**
  * Extracts a control channel message from =
buf and adjusts the size of
diff --git a/tests/unit_tests/openvpn/test_pkt=
=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index 390b3f6=2E=2Ee41dc6e 100=
644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/open=
vpn/test_pkt=2Ec
@@ -697,6 +697,114 @@
     free_tas(&tas_server);
 }
 
+/*=
 Payload every OOB round-trip below wraps: one TLV (type 1, 4 bytes of
+ * =
value)=2E */
+static const uint8_t oob_payload[] =3D { 0x00, 0x01, 0x00, 0x=
04, 0xde, 0xad, 0xbe, 0xef };
+
+/* Wrap oob_payload as a standalone P_CONT=
ROL_OOB_V1 with the client side of a
+ * tls-auth/tls-crypt pair (or none),=
 run it through the server's stateless
+ * first-packet path, and check ver=
dict, recovered session id and payload=2E */
+static void
+oob_standalone_r=
oundtrip(struct tls_auth_standalone *tas_client,
+                         =
struct tls_auth_standalone *tas_server)
+{
+    struct link_socket_actual f=
rom =3D { 0 };
+    struct tls_pre_decrypt_state state =3D { 0 };
+    stru=
ct session_id sid =3D { { 0x0b, 1, 2, 3, 4, 5, 6, 0x0b } };
+
+    struct b=
uffer payload =3D alloc_buf(64);
+    buf_write(&payload, oob_payload, size=
of(oob_payload));
+
+    /* Client side: opcode + session id + tls-auth/tls=
-crypt wrapping around the
+     * bare payload, with none of the reliabili=
ty/ACK fields a control packet
+     * carries=2E */
+    struct buffer buf=
 =3D
+        tls_wrap_oob_standalone(&tas_client->tls_wrap, tas_client, &s=
id, &payload);
+    assert_int_equal((BPTR(&buf))[0] >> P_OPCODE_SHIFT, P_C=
ONTROL_OOB_V1);
+
+    /* Server side: the stateless first-packet path must=
 recognise the opcode,
+     * verify the wrapping and leave exactly the pa=
yload in newbuf -- that is
+     * what mudp=2Ec hands to the probe parser=
=2E */
+    enum first_packet_verdict verdict =3D tls_pre_decrypt_lite(tas_=
server, &state, &from, &buf);
+    assert_int_equal(verdict, VERDICT_VALID_=
OOB_V1);
+    assert_memory_equal(state=2Epeer_session_id=2Eid, sid=2Eid, S=
ID_SIZE);
+    assert_int_equal(BLEN(&state=2Enewbuf), (int)sizeof(oob_payl=
oad));
+    assert_memory_equal(BPTR(&state=2Enewbuf), oob_payload, sizeof(=
oob_payload));
+    free_tls_pre_decrypt_state(&state);
+
+    /* Tampering=
 with any single byte must fail authentication: the flip runs
+     * over =
opcode, session id, packet id, HMAC/tag and payload alike=2E Skipped
+     =
* for TLS_WRAP_NONE, where a changed payload is legitimately accepted=2E */=

+    if (tas_server->tls_wrap=2Emode !=3D TLS_WRAP_NONE)
+    {
+        s=
truct buffer copy =3D alloc_buf(BLEN(&buf));
+        for (int i =3D 0; i <=
 BLEN(&buf); i++)
+        {
+            buf_reset_len(&copy);
+          =
  buf_write(&copy, BPTR(&buf), BLEN(&buf));
+            (BPTR(&copy))[i] ^=
=3D 0xff;
+            struct tls_pre_decrypt_state tstate =3D { 0 };
+    =
        verdict =3D tls_pre_decrypt_lite(tas_server, &tstate, &from, &copy)=
;
+            assert_int_equal(verdict, VERDICT_INVALID);
+            fre=
e_tls_pre_decrypt_state(&tstate);
+        }
+        free_buf(&copy);
+   =
 }
+
+    free_buf(&payload);
+}
+
+static void
+test_oob_standalone_plain(=
void **ut_state)
+{
+    struct tls_auth_standalone tas =3D { 0 };
+    str=
uct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D=
 1400 }, 0 };
+    tas=2Eframe =3D frame;
+    tas=2Etls_wrap=2Emode =3D TL=
S_WRAP_NONE;
+    tas=2Eworkbuf =3D alloc_buf(1600);
+
+    oob_standalone_=
roundtrip(&tas, &tas);
+
+    free_tas(&tas);
+}
+
+static void
+test_oob_s=
tandalone_tls_auth(void **ut_state)
+{
+    struct tls_auth_standalone tas_=
server =3D init_tas_auth(KEY_DIRECTION_NORMAL);
+    struct tls_auth_standa=
lone tas_client =3D init_tas_auth(KEY_DIRECTION_INVERSE);
+    packet_id_in=
it(&tas_client=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "UNITTEST", 0);
+    /* =
the server consumes the tls-auth packet id only with packet-id state,
+    =
 * which tls_auth_standalone_init() sets up for the real one */
+    packet=
_id_init(&tas_server=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, "UNITTEST", 0);
+
=
+    now =3D 0x22446688;
+    oob_standalone_roundtrip(&tas_client, &tas_se=
rver);
+
+    packet_id_free(&tas_client=2Etls_wrap=2Eopt=2Epacket_id);
+  =
  packet_id_free(&tas_server=2Etls_wrap=2Eopt=2Epacket_id);
+    free_tas(&=
tas_client);
+    free_tas(&tas_server);
+}
+
+static void
+test_oob_standa=
lone_tls_crypt(void **ut_state)
+{
+    struct frame frame =3D { =2Ebuf =3D=
 { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };
+    struct tls_au=
th_standalone tas_server =3D init_tas_crypt(true);
+    struct tls_auth_sta=
ndalone tas_client =3D init_tas_crypt(false);
+    tas_server=2Eframe =3D f=
rame;
+    tas_client=2Eframe =3D frame;
+    packet_id_init(&tas_client=2E=
tls_wrap=2Eopt=2Epacket_id, 5, 5, "UNITTEST", 0);
+
+    now =3D 0x22446688=
;
+    oob_standalone_roundtrip(&tas_client, &tas_server);
+
+    packet_id=
_free(&tas_client=2Etls_wrap=2Eopt=2Epacket_id);
+    free_tas(&tas_client)=
;
+    free_tas(&tas_server);
+}
+
 static void
 test_extract_control_messa=
ge(void **ut_state)
 {
@@ -747,6 +855,9 @@
         cmocka_unit_test(test_v=
erify_hmac_none_out_of_range_ack),
         cmocka_unit_test(test_generate_=
reset_packet_plain),
         cmocka_unit_test(test_generate_reset_packet_t=
ls_auth),
+        cmocka_unit_test(test_oob_standalone_plain),
+        cm=
ocka_unit_test(test_oob_standalone_tls_auth),
+        cmocka_unit_test(tes=
t_oob_standalone_tls_crypt),
         cmocka_unit_test(test_extract_control=
_message)
     };
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1744?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Gerrit-Change-Number: 1744
Ger=
rit-PatchSet: 19
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewe=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@=
mandelbit=2Ecom>
Gerrit-CC: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: flichtenheld <frank@lichtenheld=2Ecom>

--dS7XD01YU2w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #19</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Re=
view+1 by ralf_lici</p><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">oob: Answer SERVER_PROBE on the server=
 (P_CONTROL_OOB_V1)<br><br>Make a --mode server UDP listener answer an out-=
of-band SERVER_PROBE<br>without creating a session, so probing costs the se=
rver no state=2E<br><br>tls_pre_decrypt_lite() accepts P_CONTROL_OOB_V1 and=
 returns the new<br>VERDICT_VALID_OOB_V1, and tls_wrap_oob_standalone() wra=
ps a bare OOB<br>message with the usual tls-auth/tls-crypt wrapping but no =
reliability<br>fields, mirroring tls_reset_standalone()=2E do_pre_decrypt_c=
heck()<br>classifies the probe with oob_server_probe_check() and answers wi=
th a<br>PROBE_REPLY that echoes the probe&#39;s request_id=2E<br><br>A repl=
y is charged against the same rate limit as the reset replies,<br>once one =
is going to be sent, so a probe flood is capped like a reset<br>flood=2E A =
stale probe, one whose timestamp is outside --hand-window, is<br>still answ=
ered, but only within a separate budget of a twentieth of<br>--connect-freq=
-initial per period (at least one): a client with a<br>skewed clock can sti=
ll probe, and a replayed probe gets no more than<br>that budget=2E The budg=
et&#39;s limiter is quiet, as a replayed probe<br>hitting it is not worth a=
 warning=2E<br><br>The reply carries, as its own session id, the stateless =
SYN cookie the<br>three-way handshake uses, so the server keeps nothing per=
 probe and a<br>client can later start the handshake from the reply=2E<br><=
br>Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0<br>Signed-off-by: L=
ev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>M=
 src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn/reflect_=
filter=2Ec<br>M src/openvpn/reflect_filter=2Eh<br>M src/openvpn/ssl=2Ec<br>=
M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_test=
s/openvpn/test_pkt=2Ec<br>9 files changed, 248 insertions(+), 7 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/44/1744/19</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/s=
rc/openvpn/mudp=2Ec</span><br><span>index de3d467=2E=2E3d20d21 100644</span=
><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mud=
p=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br><span> </span><br><span> =
#include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;oob=2Eh&quot;</span><br><span> </span><br><span> #ifdef HAVE_SYS_INOTIFY_=
H</span><br><span> #include &lt;sys/inotify=2Eh&gt;</span><br><span>@@ -87,=
6 +88,34 @@</span><br><span>                           &quot;Reset packet f=
rom client, sending HMAC based reset challenge&quot;, sock);</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Send an out-of-band PROBE_REPLY back to the source of a SERVER_PROBE,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * synchronously an=
d without keeping any state, mirroring the reset path=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+send_probe_reply(struct multi_context *m,=
 struct tls_pre_decrypt_state *state,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                 struct tls_auth_standalone *tas, const s=
truct oob_probe_reply *reply,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                 struct session_id *own_sid, struct link_socket *=
sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* A PROBE_REPLY carries just =
the probe reply TLV */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer payload =3D alloc_buf_gc(128, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_probe_reply_write(&am=
p;payload, reply))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free=
(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* OOB replies use the same control-channe=
l wrapping as the request */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epacke=
t_id=2Esend);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ate-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =3D true;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct buffer buf =3D tls_wrap_oob_standa=
lone(&amp;state-&gt;tls_wrap_tmp, tas, own_sid, &amp;payload);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    send_standalone_reply(m, &am=
p;buf, &quot;Server Probe&quot;, &quot;Server probe from client, sending pr=
obe reply&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                       sock);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span>=
<br><span> /* Returns true if this packet should create a new session */</s=
pan><br><span> static bool</span><br><span>@@ -203,6 +232,47 @@</span><br><=
span> </span><br><span>         return ret;</span><br><span>     }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    else if (verdict =3D=3D =
VERDICT_VALID_OOB_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* O=
ut-of-band server probe=2E state-&gt;newbuf points at the OOB message</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+         * (read_control_=
auth has stripped the opcode, session id and any</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+         * tls-auth/tls-crypt wrapping)=2E Ans=
wer it without creating a session=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct oob_probe_request req;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        enum oob_probe_verdict probe =
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            oob_=
server_probe_check(&amp;state-&gt;newbuf, (uint64_t)now, (uint64_t)handwind=
ow, &amp;req);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (probe =3D=3D OOB_PROBE_INVALID)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return false; /* malformed: silently drop */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        /* A client whose clock is off =
by more than --hand-window still gets a</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         * few probes per period answered, which is als=
o all a replayed probe</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+         * can get=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (probe =3D=3D OOB_PROBE_STALE &amp;&amp; !reflect_filter=
_rate_limit_check(m-&gt;stale_probe_limiter))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* The reply counts against the same limit as the reset=
 replies, charged</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       * only now that we know one is going to be sent=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (!reflect_filter_rate_l=
imit_check(m-&gt;initial_rate_limiter))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            return false;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* th=
e reply echoes the probe&#39;s request_id */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        struct oob_probe_reply reply =3D { =2Erequ=
est_id =3D req=2Erequest_id };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
/* Our session id is a stateless SYN cookie (the same HMAC the three-way</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * handshake u=
ses): we keep no per-probe state, and the reply can later</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         * also serve as the server&#=
39;s CONTROL_HARD_RESET_SERVER_V2, so a client</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * can start the handshake from it=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct sess=
ion_id sid =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       calculate_session_id_hmac(state-&gt;peer_session_id, from, hmac_key,=
 handwindow, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        send_probe_rep=
ly(m, state, tas, &amp;reply, &amp;sid, sock);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        /* An OOB probe never creates a session */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br>=
<span>     /* VERDICT_INVALID */</span><br><span>     return false;</span><=
br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><=
br><span>index 3e72b92=2E=2Ea438a34 100644</span><br><span>--- a/src/openvp=
n/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ =
-326,6 +326,12 @@</span><br><span>     m-&gt;new_connection_limiter =3D fre=
quency_limit_init(t-&gt;options=2Ecf_max, t-&gt;options=2Ecf_per);</span><b=
r><span>     m-&gt;initial_rate_limiter =3D</span><br><span>         initia=
l_rate_limit_init(t-&gt;options=2Ecf_initial_max, t-&gt;options=2Ecf_initia=
l_per);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* stale=
 server probes: a twentieth of the initial-packet rate, at least 1</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * per period (5 per 10 =
s by default, the wire protocol&#39;s own example)=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * Quiet, as a replayed probe hitting=
 the limit is not worth a warning=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    m-&gt;stale_probe_limiter =3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        initial_rate_limit_init(max_int(1=
, t-&gt;options=2Ecf_initial_max / 20), t-&gt;options=2Ecf_initial_per);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;stale_probe_=
limiter-&gt;quiet =3D true;</span><br><span> </span><br><span>     /*</span=
><br><span>      * Allocate broadcast/multicast buffer list</span><br><span=
>@@ -689,6 +695,7 @@</span><br><span>         ifconfig_pool_free(m-&gt;ifco=
nfig_pool);</span><br><span>         frequency_limit_free(m-&gt;new_connect=
ion_limiter);</span><br><span>         initial_rate_limit_free(m-&gt;initia=
l_rate_limiter);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     initial_rate_limit_free(m-&gt;stale_probe_limiter);</span><br><span>  =
       multi_reap_free(m-&gt;reaper);</span><br><span>         mroute_helpe=
r_free(m-&gt;route_helper);</span><br><span>         multi_io_free(m-&gt;mu=
lti_io);</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/m=
ulti=2Eh</span><br><span>index 6cb86c7=2E=2Ed854438 100644</span><br><span>=
--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</sp=
an><br><span>@@ -178,6 +178,7 @@</span><br><span>     struct ifconfig_pool =
*ifconfig_pool;</span><br><span>     struct frequency_limit *new_connection=
_limiter;</span><br><span>     struct initial_packet_rate_limit *initial_ra=
te_limiter;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct initial_packet_rate_limit *stale_probe_limiter; /**&lt; stale SERVER_PRO=
BE answers */</span><br><span>     struct mroute_helper *route_helper;</spa=
n><br><span>     struct multi_reap *reaper;</span><br><span>     struct mro=
ute_addr local;</span><br><span>diff --git a/src/openvpn/reflect_filter=2Ec=
 b/src/openvpn/reflect_filter=2Ec</span><br><span>index e5226e4=2E=2E4887f0=
1 100644</span><br><span>--- a/src/openvpn/reflect_filter=2Ec</span><br><sp=
an>+++ b/src/openvpn/reflect_filter=2Ec</span><br><span>@@ -44,7 +44,7 @@</=
span><br><span>     if (now &gt; irl-&gt;last_period_reset + irl-&gt;period=
_length)</span><br><span>     {</span><br><span>         int64_t dropped =
=3D irl-&gt;curr_period_counter - irl-&gt;max_per_period;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (dropped &gt; 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (dropped &gt; 0 &amp=
;&amp; !irl-&gt;quiet)</span><br><span>         {</span><br><span>         =
    msg(D_TLS_DEBUG_LOW,</span><br><span>                 &quot;Dropped %&q=
uot; PRId64 &quot; initial handshake packets&quot;</span><br><span>@@ -60,7=
 +60,7 @@</span><br><span> </span><br><span>     bool over_limit =3D irl-&g=
t;curr_period_counter &gt; irl-&gt;max_per_period;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (over_limit &amp;&amp=
; !irl-&gt;warning_displayed)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (over_limit &amp;&amp; !irl-&gt;warning_displayed &amp;&am=
p; !irl-&gt;quiet)</span><br><span>     {</span><br><span>         msg(M_WA=
RN,</span><br><span>             &quot;Note: --connect-freq-initial %&quot;=
 PRId64 &quot; %d rate limit &quot;</span><br><span>@@ -89,7 +89,7 @@</span=
><br><span>     struct initial_packet_rate_limit *irl;</span><br><span> </s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    AL=
LOC_OBJ(irl, struct initial_packet_rate_limit);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(irl, struct initial_packet_=
rate_limit);</span><br><span> </span><br><span>     irl-&gt;max_per_period =
=3D max_per_period;</span><br><span>     irl-&gt;period_length =3D period_l=
ength;</span><br><span>diff --git a/src/openvpn/reflect_filter=2Eh b/src/op=
envpn/reflect_filter=2Eh</span><br><span>index 84915e8c6=2E=2Ee996d07 10064=
4</span><br><span>--- a/src/openvpn/reflect_filter=2Eh</span><br><span>+++ =
b/src/openvpn/reflect_filter=2Eh</span><br><span>@@ -44,6 +44,9 @@</span><b=
r><span>     /* we want to warn once per period that packets are being star=
ted to</span><br><span>      * be dropped */</span><br><span>     bool warn=
ing_displayed;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* drop silently: no=
 per-period warning or summary in the log */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    bool quiet;</span><br><span> };</span><br><spa=
n> </span><br><span> </span><br><span>diff --git a/src/openvpn/ssl=2Ec b/sr=
c/openvpn/ssl=2Ec</span><br><span>index 2864661=2E=2Ea6a67a2 100644</span><=
br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2E=
c</span><br><span>@@ -3706,7 +3706,8 @@</span><br><span>     struct session=
_id sid; /* remote session ID */</span><br><span> </span><br><span>     /* =
verify legal opcode=2E An out-of-band packet has no control message id and<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * no ACK array, w=
hich is what we parse next=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * no ACK array, which is what we parse next; do_pre_decry=
pt_check() answers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * those=2E */</span><br><span>     if (op &lt; P_FIRST_OPCODE || op &gt=
; P_LAST_OPCODE || opcode_is_oob(op))</span><br><span>     {</span><br><spa=
n>         if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONT=
ROL_HARD_RESET_SERVER_V1)</span><br><span>diff --git a/src/openvpn/ssl_pkt=
=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index 7f9ce1d27=2E=2Ee5c69b4=
 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b=
/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -168,7 +168,8 @@</span><br><spa=
n> {</span><br><span>     ASSERT(ks-&gt;key_id &gt;=3D 0 &amp;&amp; ks-&gt;=
key_id &lt;=3D P_KEY_ID_MASK);</span><br><span>     ASSERT(opcode &gt;=3D 0=
 &amp;&amp; opcode &lt;=3D P_LAST_OPCODE);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* OOB packets carry no message id or ACK array */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* OOB packets =
carry no message id or ACK array; tls_wrap_oob_standalone()</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * builds them */</span><br><sp=
an>     ASSERT(!opcode_is_oob(opcode));</span><br><span>     uint8_t header=
 =3D (uint8_t)(ks-&gt;key_id | (opcode &lt;&lt; P_OPCODE_SHIFT));</span><br=
><span> </span><br><span>@@ -316,7 +317,8 @@</span><br><span> </span><br><s=
pan>     /* Allow only the reset packet or the first packet of the actual h=
andshake=2E */</span><br><span>     if (op !=3D P_CONTROL_HARD_RESET_CLIENT=
_V2 &amp;&amp; op !=3D P_CONTROL_HARD_RESET_CLIENT_V3</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; op !=3D P_CONTROL_V1 &am=
p;&amp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op !=3D P_ACK_V1)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; op !=3D P_CONT=
ROL_V1 &amp;&amp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op !=3D P_ACK_V1</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !opco=
de_is_oob(op))</span><br><span>     {</span><br><span>         /*</span><br=
><span>          * This can occur due to bogus data or DoS packets=2E</span=
><br><span>@@ -391,6 +393,10 @@</span><br><span>     {</span><br><span>    =
     return VERDICT_VALID_WKC_V1;</span><br><span>     }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    else if (opcode_is_oob(op))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return VERDICT_VALID_OOB_V1;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> =
    else</span><br><span>     {</span><br><span>         return VERDICT_VAL=
ID_RESET_V2;</span><br><span>@@ -445,6 +451,29 @@</span><br><span>     retu=
rn buf;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+struct buffer</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct=
 tls_auth_standalone *tas,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        struct session_id *own_sid, const struct buf=
fer *payload)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Copy buffer here =
to point at the same data but allow tls_wrap_control</span><br><span style=
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
sl_pkt=2Eh</span><br><span>index d4fad04=2E=2E38e6665 100644</span><br><spa=
n>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=
=2Eh</span><br><span>@@ -60,7 +60,8 @@</span><br><span> </span><br><span> /=
* Out-of-band control message, e=2Eg=2E a server probe=2E Not part of the r=
eliable</span><br><span>  * control channel: no control message id and no A=
CK array, just a message</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * header and TLVs after the session id; never handled by tls_pre_decryp=
t()=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * header =
and TLVs after the session id=2E Answered statelessly in</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * do_pre_decrypt_check(), never handl=
ed by tls_pre_decrypt()=2E */</span><br><span> #define P_CONTROL_OOB_V1 12<=
/span><br><span> </span><br><span> /* define the range of defined opcodes, =
in- and out-of-band</span><br><span>@@ -106,6 +107,9 @@</span><br><span>   =
  VERDICT_VALID_ACK_V1,</span><br><span>     /** The packet is a valid cont=
rol packet with appended wrapped client key */</span><br><span>     VERDICT=
_VALID_WKC_V1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
** This packet is a valid out-of-band control message (e=2Eg=2E a server</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * probe)=2E It do=
es not belong to a session and must not create one=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    VERDICT_VALID_OOB_V1,</span><br><s=
pan>     /** the packet failed on of the various checks */</span><br><span>=
     VERDICT_INVALID</span><br><span> };</span><br><span>@@ -226,6 +230,21 =
@@</span><br><span>                                    struct session_id *o=
wn_sid, struct session_id *remote_sid,</span><br><span>                    =
                uint8_t header, bool request_resend_wkc);</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Wrap an already-built out-of-ban=
d message (e=2Eg=2E a PROBE_REPLY) into a</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * standalone, session-less P_CONTROL_OOB_V1 packet: =
it prepends the opcode and</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * own_sid and applies the same tls-auth/tls-crypt wrapping as a reg=
ular</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * control pack=
et, but carries no reliability/ACK fields=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param ctx       tls wrapping context (from the pre-decrypt stat=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param tas    =
   standalone auth context providing the work buffer</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param own_sid   session id to use as =
our session id in the header</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param payload   the OOB message (header and TLVs) to wrap</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return          the =
wrapped packet buffer, ready to send</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+struct buffer tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls=
_auth_standalone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                      struct session_id *own_sid, const =
struct buffer *payload);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> </span><br><span> /**</span><br><span>  * Extracts a=
 control channel message from buf and adjusts the size of</span><br><span>d=
iff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvp=
n/test_pkt=2Ec</span><br><span>index 390b3f6=2E=2Ee41dc6e 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -697,6 +697,114 @@</s=
pan><br><span>     free_tas(&amp;tas_server);</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Payload e=
very OOB round-trip below wraps: one TLV (type 1, 4 bytes of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * value)=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static const uint8_t oob_payload[] =3D=
 { 0x00, 0x01, 0x00, 0x04, 0xde, 0xad, 0xbe, 0xef };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Wrap oob_payload as a standalone P_CONTROL_OOB_V1 with th=
e client side of a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* tls-auth/tls-crypt pair (or none), run it through the server&#39;s statel=
ess</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * first-packet =
path, and check verdict, recovered session id and payload=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+oob_standalone_roundtrip(struct tls_aut=
h_standalone *tas_client,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                         struct tls_auth_standalone *tas_server)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct link_socket_actual from =3D { =
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_=
pre_decrypt_state state =3D { 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct session_id sid =3D { { 0x0b, 1, 2, 3, 4, 5, 6, 0x=
0b } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer payload =3D a=
lloc_buf(64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
f_write(&amp;payload, oob_payload, sizeof(oob_payload));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Client side: opcode + session id + tls-auth/tls-cr=
ypt wrapping around the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * bare payload, with none of the reliability/ACK fields a control =
packet</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * carrie=
s=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct b=
uffer buf =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  tls_wrap_oob_standalone(&amp;tas_client-&gt;tls_wrap, tas_client, &amp;si=
d, &amp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal((BPTR(&amp;buf))[0] &gt;&gt; P_OPCODE_SHIFT, P_CONTROL_O=
OB_V1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* Server side: the statele=
ss first-packet path must recognise the opcode,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * verify the wrapping and leave exactly th=
e payload in newbuf -- that is</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * what mudp=2Ec hands to the probe parser=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    enum first_packet_verdict v=
erdict =3D tls_pre_decrypt_lite(tas_server, &amp;state, &amp;from, &amp;buf=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(verdict, VERDICT_VALID_OOB_V1);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_memory_equal(state=2Epeer_session_id=2Eid, sid=
=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(BLEN(&amp;state=2Enewbuf), (int)sizeof(oob_payload));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equa=
l(BPTR(&amp;state=2Enewbuf), oob_payload, sizeof(oob_payload));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    free_tls_pre_decrypt_state(=
&amp;state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Tampering with any =
single byte must fail authentication: the flip runs</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * over opcode, session id, packet id=
, HMAC/tag and payload alike=2E Skipped</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * for TLS_WRAP_NONE, where a changed payload is le=
gitimately accepted=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (tas_server-&gt;tls_wrap=2Emode !=3D TLS_WRAP_NONE)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        struct buffer copy =3D alloc_buf(BLE=
N(&amp;buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  for (int i =3D 0; i &lt; BLEN(&amp;buf); i++)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            buf_reset_len(&amp;copy);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            buf_write(&amp;copy, BPTR(&=
amp;buf), BLEN(&amp;buf));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            (BPTR(&amp;copy))[i] ^=3D 0xff;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            struct tls_pre_decrypt_state tst=
ate =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       verdict =3D tls_pre_decrypt_lite(tas_server, &amp;tstate, &amp;from,=
 &amp;copy);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     assert_int_equal(verdict, VERDICT_INVALID);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            free_tls_pre_decrypt_state(&amp;ts=
tate);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        free_buf(&amp;c=
opy);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    free_buf(&amp;payload);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_oob_=
standalone_plain(void **ut_state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct tls_auth_standalone tas =3D { 0 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct frame frame =3D { =2Ebuf =3D { =2Eheadroom=
 =3D 200, =2Epayload_size =3D 1400 }, 0 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    tas=2Eframe =3D frame;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas=2Eworkbuf =
=3D alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_standalone=
_roundtrip(&amp;tas, &amp;tas);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fre=
e_tas(&amp;tas);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+test_oob_standalone_tls_auth(void **ut_state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone tas_serve=
r =3D init_tas_auth(KEY_DIRECTION_NORMAL);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct tls_auth_standalone tas_client =3D init_t=
as_auth(KEY_DIRECTION_INVERSE);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    packet_id_init(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id=
, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* the server consumes the tls-auth packet id only with p=
acket-id state,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * which tls_auth_standalone_init() sets up for the real one */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas_ser=
ver=2Etls_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    now =3D 0x22446688;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    oob_standalone_roundtrip(&amp;tas_client=
, &amp;tas_server);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_free(=
&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas_server=2Etls_wrap=2E=
opt=2Epacket_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  free_tas(&amp;tas_client);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    free_tas(&amp;tas_server);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test_oob_standalone_tls_c=
rypt(void **ut_state)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct frame=
 frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, =
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_=
auth_standalone tas_server =3D init_tas_crypt(true);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone tas_client=
 =3D init_tas_crypt(false);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    tas_server=2Eframe =3D frame;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    tas_client=2Eframe =3D frame;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas_client=2Etl=
s_wrap=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    now =3D 0x22446688;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    oob_standalone_roundtrip(&amp;tas_client, &amp;t=
as_server);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas=
_client=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    free_tas(&amp;tas_client);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    free_tas(&amp;tas_server);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span> test_=
extract_control_message(void **ut_state)</span><br><span> {</span><br><span=
>@@ -747,6 +855,9 @@</span><br><span>         cmocka_unit_test(test_verify_=
hmac_none_out_of_range_ack),</span><br><span>         cmocka_unit_test(test=
_generate_reset_packet_plain),</span><br><span>         cmocka_unit_test(te=
st_generate_reset_packet_tls_auth),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cmocka_unit_test(test_oob_standalone_plain),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(t=
est_oob_standalone_tls_auth),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test(test_oob_standalone_tls_crypt),</span><b=
r><span>         cmocka_unit_test(test_extract_control_message)</span><br><=
span>     };</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1744?usp=3Demail">change 1744</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I930d3789e0313aa0c=
3bc51ee5fd1d108343d59f0 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1744 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 19 </div>
=
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: r=
alf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>

</body></html>
--dS7XD01YU2w=--


--===============0128705945485072574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0128705945485072574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0128705945485072574==--

