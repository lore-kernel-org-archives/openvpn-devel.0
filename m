Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D65ACA5FAC
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CPTYpkTkPkRF7QNaxD6CyFHpIGSN75vV4iYGZkjBwmE=; b=IYthDgJPd68IF6klfkHbaqb7A3
	8fX+1vCRmrsr7hCCsws0vofgIQxEl96/q3TxFReO1tevc97KW+dLTM++8FJ8crMo/wVbMtdCydWd6
	g/L/GKkZcTDE1I/zjuf/h7hXdKVJAQdzova6G0+2Jo30RzMLE1dO9mWCIL+qtTD7s0nY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBXi4-0003gP-W5;
	Tue, 29 Sep 2026 13:17:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBXi3-0003gF-Hj
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=VhdWaFmwfAdzT86KUpKsTSi2GmXzeAXIMcAoNFUcQnc=; b=dPnAnDWHn3oy+yqKS4XjKZ0g5P
 2JnJcfv5IiB8Ps+lY+Y+/bp5ikaRJvSKx1+6uRo1UUj21q5vVeqlElVw3gUQckHGYbfA46YxAW2rn
 o5yGnmhJJsO/pXnXG/76WKE6s9PgcvBcgvVjsXOYcJl3qanYN8RenhQzE5+BbPPQ6QAE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VhdWaFmwfAdzT86KUpKsTSi2GmXzeAXIMcAoNFUcQnc=; b=I
 7v9lsjJqqlxP3vx1WuNY9Pk3W0ms7Ns/BenJpzidilIu7dbRVoqyHdgATbvAXBgjnkZGuOW5Qw1cJ
 1fjUz/d53M8E9N9FMphUCyVk+hKaQJ1aCE4dgpUNN87MSa8ydYFKvLEegSfAWowIEP3PmzH/m6TSS
 LJPUtv+gkSMah684=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBXhx-0001Gl-P1 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:27 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so22822785e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 06:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790687835; x=1791292635; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VhdWaFmwfAdzT86KUpKsTSi2GmXzeAXIMcAoNFUcQnc=;
 b=auOPLsuP4MKYLQbSfYs4J8a5hBnsWibpVzThsEBNaw7tiSEp/Oqen3iTnJkTKHZJzL
 QcDyXfjKB7p7ZjJcj0HrAG9gPDlEPmoxww8T0+f2KZFwpRNN98HTCnMrUfQn9NhLKW+z
 QTzLKZGTsZGS4EZoH64kvl1lsQhx1ifnTt30iMPlYzRU60kxrfiGiIumcUMbsjehbciI
 WSPvnCTVY2vofQNTHm20PWFT+7XIU7r9eFYuHx4p6hkuWQTy0NWCHUVKpnEI9DDpIju7
 akrFdGg1qKivcFRnoHXB6ZjozkGhvOcHBGLCNVPxIWZIXabFS+Dl7NYjJt6O+L73yMVU
 u/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687835; x=1791292635;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VhdWaFmwfAdzT86KUpKsTSi2GmXzeAXIMcAoNFUcQnc=;
 b=LTj7o7Scv9zPQkmYFAu091Q/8e9XR4Y9vCDJU4lgbz89bG+Orj+RGCZlGT/eWkOfZY
 +LBhE2LuHy/Ib9yGrIyn+Sx8fVtcnD6vu2B8/RaeXEZXi6Brw9CUZp3K7gElwY4B4tGb
 EZ3Nk30nm282D3je1AU3VxolxR05xV+rzELZvmdc4M8Ya0Da2UcuB06VEBDIetZCzv73
 SlvZ8yiOHIMfNENvNQeCaSVDedDtQEGnAerMvIw8K7fSTmsE0MOOgERZ8OKu8fuJy0yC
 I5Zi3VmPlYII4zAepKCmm2f97hb+Y1BahRfPiuamf2KQvxObtST732v43awUThO+RXcw
 XubA==
X-Gm-Message-State: AFuF++kkWN9NO54D9nOBk1EVc4vvzubprVns9aW6yWajf425QH8V6fji
 Q7OaSpnbS8AXZf01ycQOXuUu4qAOD2sQNt1aRhYdOMP6nfx17Bf7mlNN7znX3vEbbUfogM8qSzq
 Z/LxlM3pXj92EuTwG3dIWJyAiNcQ1gl0ka1YYlF4xujrk0OQoPFdp4hok9i7PDN/HZ+3gl6rmzh
 OpsFbUpg==
X-Gm-Gg: AYBFou1FVrr6SBNl3hzQU4hDHoDmg71t5lr1BFcWTDv77MzDS730lqJhyISuELsLd/K
 hUYMdgdFzI2DlTX747YVMJnBQbmJS2PcamFVHTR+BANzY3AfYmgiT7efUFDh4mdCbK0ETbieH/Y
 fkJB5A6ztF3Pn6YJsni2iXOXra4MM+KdEIxohwIP/Fz6dbXwKCeb30IzR/V6VcDzaAk810e1D38
 DUCtN7+8uzGz+w8U7QbnoPY9waa9HBK5Y4LCDGIAgkW0UDVW11gQaeB/vTDCHSqepU37pBptWmz
 HcbmXOkIAUYXC9J65nrHv9ANjxZ4tyYkfmMJ4DzcVhg2WuCz7pWP+Da/Q28IPEsSijNCJ3p2uf6
 SySZew/UPSN2I0+34cqin/6LEl0aCDvyNjUhaqMaBpzXADSKuWtiNN0XNYhLIuM0MdbeGddUIPF
 y0ZBWHGteXCLfMua/6H8BNqfZISEZHYS/LwWQENi/B+5RkwLU179fbU0cULm5eAdat2VDg4YCgl
 v6Q+xeYI8fgUPtJ8iYfe5yDnSlMMQdCvktganeYH7wGcJbbaHVlxIhWmCOrumf6nA7nuJL3NSh1
 KRJoMZVu6DJQg8WYk9Hh41Y2c1hnNru+AJa1bpF0Vvtgpxbb/+kApy7DUZA97Q==
X-Received: by 2002:a05:600c:310b:b0:49c:ee20:e787 with SMTP id
 5b1f17b1804b1-49fe66c8959mr264988455e9.1.1790687835035; 
 Tue, 29 Sep 2026 06:17:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfe16a2sm77844795e9.4.2026.09.29.06.17.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:17:14 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 13:16:31 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9
X-Gerrit-Change-Number: 1771
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1771?usp=email>
X-Gerrit-Commit: 18029bfb739911ed56936c01bd0921cb9c1e4f96
In-Reply-To: <gerrit.1783320647000.Icec4696ff263ab39ebab06e8d478395a5ddfaab9@gerrit.openvpn.net>
References: <gerrit.1783320647000.Icec4696ff263ab39ebab06e8d478395a5ddfaab9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkljZWM0Njk2ZmYyNjNhYjM5ZWJhYjA2ZThkNDc4Mzk1YTVkZGZhYWI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5db329519a960cc452edf15382c61d6f9d31f7ef-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBXhx-0001Gl-P1
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Fall back
 quickly when a probe-started handshake is ignored
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
Content-Type: multipart/mixed; boundary="===============7680559347022341382=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7680559347022341382==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NgkhU3q84L0="; charset=UTF-8

--NgkhU3q84L0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ralf_lici, stipa=2E

Hello plaisthos,=
 ralf_lici, 

I'd like you to reexamine a change=2E Please visit

    http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3Demail

to look at the new p=
atch set (#26)=2E

The following approvals got outdated and were removed:
C=
ode-Review+1 by ralf_lici


Change subject: oob: Fall back quickly when a p=
robe-started handshake is ignored
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

oob: Fall back quickly when a probe-started handshak=
e is ignored

If the server does not accept the third packet of a handshake=
 started
from a probe reply, the client stalled for the full handshake_wind=
ow
(~60s) before recovering=2E

In a normal handshake, no answer could mean=
 the server is down, so
waiting is right=2E Here we know it is up, since it=
 answered a probe a
moment ago -- so no answer means it did not accept the =
reply as a reset,
and waiting 60s is pointless=2E That happens when a load =
balancer sends
the probe and the handshake to different instances, when NAT=
 changes the
source port the cookie is bound to, or when the server restart=
ed and
rotated its session-id HMAC key=2E

Give such a session a short firs=
t-response deadline
(min(handshake_window, 5s)); once the server answers, t=
ls_pre_decrypt()
restores the full window so a slow-but-working handshake i=
s not cut off=2E
If no response arrives the session times out quickly and t=
he client
restarts the attempt rather than retrying in place: the restart m=
oves on
to the next resolved address or connection entry, so the address th=
at
answered the probe is not retried this cycle (with --persist-remote-ip
t=
he restart keeps it, as for any restart)=2E A rejected reply therefore
cost=
s a few seconds instead of ~60=2E

Change-Id: Icec4696ff263ab39ebab06e8d478=
395a5ddfaab9
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M doc/man-=
sections/client-options=2Erst
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_commo=
n=2Eh
3 files changed, 51 insertions(+), 2 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/1771/26

diff --git a/=
doc/man-sections/client-options=2Erst b/doc/man-sections/client-options=2Er=
st
index 80f760f=2E=2Ee35de8c 100644
--- a/doc/man-sections/client-options=
=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -660,7 +660,16 @@
   =
- the server honours its reply only for a limited time (see
     ``--server=
-probe-reply``), so an unusually slow start-up, such as a
     private key =
passphrase or token prompt, can outlast it; the client
-    then falls back=
 to a normal handshake=2E
+    then falls back to a normal handshake;
+  - =
a handshake started this way is given only a few seconds to draw a
+    res=
ponse, rather than ``--hand-window``=2E If none arrives the client
+    log=
s a key negotiation timeout, restarts the attempt and moves on to
+    the =
next address or remote, so the address that answered the probe is
+    not =
retried during this cycle=2E The server answered a probe moments
+    earli=
er, so silence means it did not accept the reply as a reset,
+    which hap=
pens when a load balancer sends the probe and the handshake
+    to differe=
nt instances, when NAT changes the source port, or when the
+    server rot=
ated its session id key=2E
 
   The handshake shortcut is not used on Windo=
ws while DCO is active=2E
 
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/=
ssl=2Ec
index d6b5d21=2E=2Ed65a0a7 100644
--- a/src/openvpn/ssl=2Ec
+++ b/s=
rc/openvpn/ssl=2Ec
@@ -2587,6 +2587,11 @@
     return session_move_pre_star=
t(session, ks, true);
 }
 
+/* Seconds to wait for the server's first respo=
nse to a probe-started handshake
+ * before giving up and falling back to a=
 normal handshake=2E A couple of
+ * control-channel retransmits; capped at=
 handshake_window by the caller=2E */
+#define OOB_PROBE_START_FALLBACK_SEC=
S 5
+
 bool
 session_skip_to_pre_start_client(struct tls_session *session, =
const struct session_id *client_sid,
                                  cons=
t struct session_id *server_sid,
@@ -2639,6 +2644,10 @@
         return fal=
se;
     }
     ks->state =3D S_PRE_START;
+
+    /* Fail fast if the serve=
r ignores it: wait seconds, not handshake_window=2E
+     * tls_pre_decrypt=
() restores the full window once the server answers=2E */
+    ks->oob_prob=
e_start =3D true;
     return true;
 }
 
@@ -2884,12 +2893,31 @@
         c=
ontinue_tls_process =3D session_move_pre_start(session, ks, false);
     }
=
 
+    /* Start the probe-started fallback clock only once our first contro=
l packet
+     * is queued: opening the tun, plugin init and chroot all hap=
pen before that
+     * and must not be counted against a deadline meant fo=
r the server's reply=2E */
+    if (ks->oob_probe_start && !reliable_empty(=
ks->send_reliable))
+    {
+        const time_t deadline =3D
+            =
now + min_int(session->opt->handshake_window, OOB_PROBE_START_FALLBACK_SECS=
);
+        if (ks->must_negotiate > deadline)
+        {
+            ks->=
must_negotiate =3D deadline;
+        }
+    }
+
     /* Are we timed out o=
n receive? */
     if (now >=3D ks->must_negotiate && ks->state >=3D S_UNDE=
F && ks->state < S_ACTIVE)
     {
+        /* Report the window that actual=
ly applied: an unanswered probe-started
+         * handshake times out on =
the short fallback deadline, not
+         * handshake_window=2E */
+      =
  int window =3D ks->oob_probe_start
+                         ? min_int(se=
ssion->opt->handshake_window, OOB_PROBE_START_FALLBACK_SECS)
+             =
            : session->opt->handshake_window;
         msg(D_TLS_ERRORS,
  =
           "TLS Error: TLS key negotiation failed to occur within %d second=
s (check your network connectivity)",
-            session->opt->handshake_=
window);
+            window);
         goto error;
     }
 
@@ -4001,6 +40=
29,16 @@
         goto error;
     }
 
+    /* First valid response to a pr=
obe-started handshake: the server accepted it,
+     * so restore the norma=
l negotiation window (it was shortened to fail fast if
+     * the probe re=
ply had been ignored)=2E Only after the source address matched,
+     * or =
any forged packet could re-arm the long window=2E */
+    if (ks->oob_probe=
_start)
+    {
+        ks->oob_probe_start =3D false;
+        ks->must_ne=
gotiate =3D now + session->opt->handshake_window;
+    }
+
     /*
      * =
Should we do a retransmit of all unacknowledged packets in
      * the send=
 buffer?  This improves the start-up efficiency of the
diff --git a/src/ope=
nvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index f6392f9=2E=2E905006c=
 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@=
@ -227,6 +227,8 @@
     time_t initial;                        /* when we c=
reated this session */
     time_t established;                    /* when =
our state went S_ACTIVE */
     time_t must_negotiate;                 /* k=
ey negotiation times out if not finished before this time */
+    bool oob_=
probe_start;                  /* probe-started handshake: must_negotiate is=
 a short
+                                            * first-response dead=
line, not the full window */
     time_t must_die;                       /*=
 this object is destroyed at this time */
     time_t peer_last_packet;    =
           /* Last time we received a packet in this control session */
 

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icec4696ff263ab39e=
bab06e8d478395a5ddfaab9
Gerrit-Change-Number: 1771
Gerrit-PatchSet: 26
Gerr=
it-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@g=
mail=2Ecom>

--NgkhU3q84L0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ralf_lici, stipa=2E </p>
<p>stipa <strong>uploaded pa=
tch set #26</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1771?usp=3Demail">View Change</a></p><p>The followin=
g approvals got outdated and were removed:
Code-Review+1 by ralf_lici</p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">oob: Fall back quickly when a probe-started handshake is ignore=
d<br><br>If the server does not accept the third packet of a handshake star=
ted<br>from a probe reply, the client stalled for the full handshake_window=
<br>(~60s) before recovering=2E<br><br>In a normal handshake, no answer cou=
ld mean the server is down, so<br>waiting is right=2E Here we know it is up=
, since it answered a probe a<br>moment ago -- so no answer means it did no=
t accept the reply as a reset,<br>and waiting 60s is pointless=2E That happ=
ens when a load balancer sends<br>the probe and the handshake to different =
instances, when NAT changes the<br>source port the cookie is bound to, or w=
hen the server restarted and<br>rotated its session-id HMAC key=2E<br><br>G=
ive such a session a short first-response deadline<br>(min(handshake_window=
, 5s)); once the server answers, tls_pre_decrypt()<br>restores the full win=
dow so a slow-but-working handshake is not cut off=2E<br>If no response arr=
ives the session times out quickly and the client<br>restarts the attempt r=
ather than retrying in place: the restart moves on<br>to the next resolved =
address or connection entry, so the address that<br>answered the probe is n=
ot retried this cycle (with --persist-remote-ip<br>the restart keeps it, as=
 for any restart)=2E A rejected reply therefore<br>costs a few seconds inst=
ead of ~60=2E<br><br>Change-Id: Icec4696ff263ab39ebab06e8d478395a5ddfaab9<b=
r>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M doc/man=
-sections/client-options=2Erst<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ss=
l_common=2Eh<br>3 files changed, 51 insertions(+), 2 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/71/1771/26</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/doc/man-sections/client-options=2Er=
st b/doc/man-sections/client-options=2Erst</span><br><span>index 80f760f=2E=
=2Ee35de8c 100644</span><br><span>--- a/doc/man-sections/client-options=2Er=
st</span><br><span>+++ b/doc/man-sections/client-options=2Erst</span><br><s=
pan>@@ -660,7 +660,16 @@</span><br><span>   - the server honours its reply =
only for a limited time (see</span><br><span>     ``--server-probe-reply``)=
, so an unusually slow start-up, such as a</span><br><span>     private key=
 passphrase or token prompt, can outlast it; the client</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    then falls back to a normal handshake=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    then falls b=
ack to a normal handshake;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  - a handshake started this way is given only a few seconds to draw=
 a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    response, rat=
her than ``--hand-window``=2E If none arrives the client</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    logs a key negotiation timeout, re=
starts the attempt and moves on to</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    the next address or remote, so the address that answered=
 the probe is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    no=
t retried during this cycle=2E The server answered a probe moments</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    earlier, so silence mean=
s it did not accept the reply as a reset,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    which happens when a load balancer sends the prob=
e and the handshake</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    to different instances, when NAT changes the source port, or when the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    server rotated it=
s session id key=2E</span><br><span> </span><br><span>   The handshake shor=
tcut is not used on Windows while DCO is active=2E</span><br><span> </span>=
<br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br>=
<span>index d6b5d21=2E=2Ed65a0a7 100644</span><br><span>--- a/src/openvpn/s=
sl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -2587,6=
 +2587,11 @@</span><br><span>     return session_move_pre_start(session, ks=
, true);</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* Seconds to wait for the server&#39;s first res=
ponse to a probe-started handshake</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * before giving up and falling back to a normal handshake=
=2E A couple of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * c=
ontrol-channel retransmits; capped at handshake_window by the caller=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_PROBE_ST=
ART_FALLBACK_SECS 5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> bool</span><br><span> session_skip_to_pre_start_client(st=
ruct tls_session *session, const struct session_id *client_sid,</span><br><=
span>                                  const struct session_id *server_sid,=
</span><br><span>@@ -2639,6 +2644,10 @@</span><br><span>         return fal=
se;</span><br><span>     }</span><br><span>     ks-&gt;state =3D S_PRE_STAR=
T;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* Fail fast if the server ignor=
es it: wait seconds, not handshake_window=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * tls_pre_decrypt() restores the full window =
once the server answers=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ks-&gt;oob_probe_start =3D true;</span><br><span>     return =
true;</span><br><span> }</span><br><span> </span><br><span>@@ -2884,12 +289=
3,31 @@</span><br><span>         continue_tls_process =3D session_move_pre_=
start(session, ks, false);</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Start the probe-star=
ted fallback clock only once our first control packet</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * is queued: opening the tun, plugin=
 init and chroot all happen before that</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * and must not be counted against a deadline meant=
 for the server&#39;s reply=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (ks-&gt;oob_probe_start &amp;&amp; !reliable_empty(ks-=
&gt;send_reliable))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
time_t deadline =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            now + min_int(session-&gt;opt-&gt;handshake_window, OOB_PROBE_S=
TART_FALLBACK_SECS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (ks-&gt;must_negotiate &gt; deadline)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            ks-&gt;must_negotiate =3D deadline;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>     /* Are we timed out on receiv=
e? */</span><br><span>     if (now &gt;=3D ks-&gt;must_negotiate &amp;&amp;=
 ks-&gt;state &gt;=3D S_UNDEF &amp;&amp; ks-&gt;state &lt; S_ACTIVE)</span>=
<br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* Report the window that actually applied: an unanswered probe-starte=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * handsha=
ke times out on the short fallback deadline, not</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+         * handshake_window=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        int window =3D ks-&gt;oo=
b_probe_start</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                   ? min_int(session-&gt;opt-&gt;handshake_window, OOB_PROB=
E_START_FALLBACK_SECS)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                         : session-&gt;opt-&gt;handshake_window;</span><=
br><span>         msg(D_TLS_ERRORS,</span><br><span>             &quot;TLS =
Error: TLS key negotiation failed to occur within %d seconds (check your ne=
twork connectivity)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            session-&gt;opt-&gt;handshake_window);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            window);</span><br><span>  =
       goto error;</span><br><span>     }</span><br><span> </span><br><span=
>@@ -4001,6 +4029,16 @@</span><br><span>         goto error;</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* First valid response to a probe-started handshake: the server=
 accepted it,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 so restore the normal negotiation window (it was shortened to fail fast if=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the probe re=
ply had been ignored)=2E Only after the source address matched,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * or any forged packet cou=
ld re-arm the long window=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (ks-&gt;oob_probe_start)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        ks-&gt;oob_probe_start =3D false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ks-&gt;must_negotiate =3D now + s=
ession-&gt;opt-&gt;handshake_window;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     /*</span><br><span>      * Should we do a retransm=
it of all unacknowledged packets in</span><br><span>      * the send buffer=
?  This improves the start-up efficiency of the</span><br><span>diff --git =
a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>i=
ndex f6392f9=2E=2E905006c 100644</span><br><span>--- a/src/openvpn/ssl_comm=
on=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ =
-227,6 +227,8 @@</span><br><span>     time_t initial;                      =
  /* when we created this session */</span><br><span>     time_t establishe=
d;                    /* when our state went S_ACTIVE */</span><br><span>  =
   time_t must_negotiate;                 /* key negotiation times out if n=
ot finished before this time */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    bool oob_probe_start;                  /* probe-started han=
dshake: must_negotiate is a short</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                            * first-response =
deadline, not the full window */</span><br><span>     time_t must_die;     =
                  /* this object is destroyed at this time */</span><br><sp=
an>     time_t peer_last_packet;               /* Last time we received a p=
acket in this control session */</span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3Demail">change 1771=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1771?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
cec4696ff263ab39ebab06e8d478395a5ddfaab9 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1771 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 26 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: r=
alf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--NgkhU3q84L0=--


--===============7680559347022341382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7680559347022341382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7680559347022341382==--

