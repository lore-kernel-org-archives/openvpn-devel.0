Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0CDC44503
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 06:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=qQxR9kk8dISwrnvD7eVMAoY6aDYNGa1SHfYDjWKMZ5I=; b=PlXbuVKEgra4/u
	CxWZZe4/4LZVt6OrdgGKiZK5emVZlobqZ1Ai4ThPNJFjyp1a0ZwXgMucLioDd5+IN34g1p5/98qms
	fGbmOeuowN+f941YFJxQsipfYioaBFhDl5C2LnarxsWojZqBSPrDx5zB6FhJg0SZdSQwUGiCD9Bz1
	Imk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgdAm-0001CY-MB;
	Mon, 06 Jul 2026 06:51:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wgdAl-0001CP-9V
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:51:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F3AFlBmDn/sFm/yRjyZr4XAAB1HJ7uAYNGl0bCyC2fg=; b=Y57Kp3DeeArYImO/XFBnutqNxv
 uC56FB6oTPGXMjPLkODTyLkj/JQTsg+HjMsNGdkR+RMExofJVX2Ehz/HwgSqZmMAbukU1fB3wheEt
 Ae2kltal1b8JYBZCPBQIH6kgDzT8mTb9ZiLI6mRnDa3WSItWZdgavOge3eAeuHhNJhA0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=F3AFlBmDn/sFm/yRjyZr4XAAB1HJ7uAYNGl0bCyC2fg=; b=d
 NGvftaqRilgiBzQxcxEOwdu5Z1oKzrmVvhktoNfI3VRZz1kII1V6YN8VAEsVdLHdY+qSGYOmlHJ44
 T7UEZrhOLsCP5QEIze0KWyJ6k4nxvHbGqhp75cEjSPIshYbPnUv6ITjNLXqe4orPB7WiDKElfUnfI
 ohFgHeCNf2RWc8ao=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wgdAh-00047P-VE for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:51:19 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-475cb71a4ebso2785314f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 05 Jul 2026 23:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783320670; x=1783925470; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F3AFlBmDn/sFm/yRjyZr4XAAB1HJ7uAYNGl0bCyC2fg=;
 b=OZpPmWUnL4qv/6ZvhIh6R9GYNPll0oK4tSAuJ9kohs620wxU39bgnAk3gnAo8nRJ00
 WJzbYFo7XNyFSeB2PEDgjBRr2qIvGgjdAFHhcjsEQtSPeH4D4+RmDc5DvmMzVQqIhfJ4
 /Z3tJbw8J21I0r8NGMgSNiwXw4yTBA5MejhgEO+C91iegj8SBpYez9jnGhnE9IrMBo50
 GpDSMa02uoh87n84GQIOaKfSc5/PlzXG6IgLqKpcbX/ovRfRcdw5ywcgoRjJgcJ1gABW
 V9cxsktrHJuHllaJPOcnR/WWnY2XAW1biqVfMLMKU4pokeiRW7QLMRLEcpEdEiW63kNx
 Qipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783320670; x=1783925470;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F3AFlBmDn/sFm/yRjyZr4XAAB1HJ7uAYNGl0bCyC2fg=;
 b=qIuMGixqkfJGYoPCdWXx3Rq1OckVb/H3q0KJDDXfG9KR5XFsN+Hgt0Lct9UO6MqXvA
 fAEBmqYsp38tlZUaDH7azuxKoUfS/sxfgtfIMSB09wUOI1PpOE9FV60phFwSdr8IqeVA
 VRm/87umgoXk9y5t+mgbo6Uzi0sZhyfOA8VHs8Seu5Skh+ilhOoWnAMdRnT+eyZScRu8
 Mll1V1+dYNLrp+QCETRs4s70K61tpoynV84fgIt3KNcyD8H/W+4ImawkVIBdCM7cF2Jf
 pG0xkjmBy7O+Ley5D2928gOlmTn+Vdr9Nam/UJGKOIz6jQ+a0A86H1H71rvGu4hRAMWY
 TrjA==
X-Gm-Message-State: AOJu0YwJp7wErGf7UjjBwqxPdTudT+Ds2LZsMq2PF6cvj+lDinWFkTaL
 FKF5QqpXVR38XDjFqjokgx+9nut+hpvkOMcBfxQrNj5USI0N3QylBOEl3Ew/knqsfOJarHsl5zk
 FwqvNYDHaXSx+Ls1FKcNEtS6Owi0n0TySgVTP0Ox4vvF3yo3xWaKbg1oYOB3nG4x7cVDL3rFQv+
 We0paBAg==
X-Gm-Gg: AfdE7clFgMdg0GBjWyzM17EXamnEVn767TDpAKCycinSYqe8RqdPVh8viRnoxrnC61e
 xvBuNZWu3qg8UoisVveBzOLkRHqVgTWZQdaizTZD3Co13lQtAGWPnVLCaJbLNeY5UEDdCNgXkTf
 RPejgq8inXfaYsz3BG/OrCWV+OQshs+gg1jJXkxsyYAyox9yRSs9bm37JMvcBcTJEDP9nIf/wmv
 6dkn6CTQ6gPE3TDoSa0ZS/xJOXgLXnTi725kl14wAXyb0lI3ixgGOn/DlBL5+eTIB2L58cYB5xb
 Hh2vVOxGFJB94vk0PL3NSgSERXxz2t58V3r4kuRzDPV9I2CAcVlD9drqXbJAsygxLGhqhri1Vlx
 iaomKfcm/2s1/JDCjCoGm6HqSxWgiLHtQZ8knVJjHL7iFJRUe9mAznhhZNe/xis6i8kjvG1NbzM
 O11Jb5lj5zxyBjIHCVNAhOvnuAWzHu1pnSbw0oKKQmh3PVof7RF/AOiR1I9KtxRsZDrJicFygKK
 9WwzYXSlFLl0se6NwupCRyIWaS00e6rG78jOTxcOEhPEnOPrfl7c7cv2Sn+c1Dy7YoFHjOHswy5
 RYc=
X-Received: by 2002:adf:e003:0:10b0:472:edc7:b4c9 with SMTP id
 ffacd0b85a97d-47aabf25869mr6811551f8f.38.1783320669658; 
 Sun, 05 Jul 2026 23:51:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ae4fsm22866275f8f.18.2026.07.05.23.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 23:51:09 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 6 Jul 2026 06:51:08 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
X-Gerrit-Change-Number: 1770
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1770?usp=email>
X-Gerrit-Commit: fbd8bd63102fd7461907218a0a0224e40e3475ab
References: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkk0NTRkNTA0MGNiYWQ0ZDM3M2VlNGY5MGI4ZDY4MzIwMGQyYTRjMGU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8e30e9d0cee2f6ab9c51251cec48733a890a4e7c-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wgdAh-00047P-VE
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: client
 handshake shortcut via a server probe
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
Content-Type: multipart/mixed; boundary="===============0568465983131484314=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0568465983131484314==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SLsBGh3i+7k="; charset=UTF-8

--SLsBGh3i+7k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1770?usp=3Demail

to review the following change=2E


Chang=
e subject: oob: client handshake shortcut via a server probe
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: client handshake sho=
rtcut via a server probe

When the best remote answered a probe and adverti=
sed a connect_lifetime, the
client now skips its own three-way handshake an=
d starts at the third packet,
reusing the probe reply as the server's HARD_=
RESET (its session id is a valid
stateless SYN-cookie)=2E Saves one RTT on =
connect=2E

  - oob_client=2Ec: on a shortcut-capable winner, hand its prob=
e socket, the
    captured server session id (cookie), our probe session id=
, the pinned
    responder address, and the resend-wkc flag to the connecti=
on via c2;
    relinquish that socket (do not close it); gate off for dco-w=
in, which has
    no user-to-kernel socket handoff (probing still works, on=
ly the shortcut is
    skipped)=2E
  - ssl=2Ec session_skip_to_pre_start_cl=
ient(): seed our session id to the probe's
    (the cookie is an HMAC over =
it), the remote session id to the cookie, ack
    the phantom server reset =
(id 0) so the third packet carries the cookie, set
    CO_RESEND_WKC for tl=
s-crypt-v2, and drop to S_PRE_START so tls_process()
    promotes to S_STAR=
T and sends the ClientHello (no HARD_RESET sent)=2E
  - init=2Ec: invoke th=
e client skip after tls_multi_init_finalize when adopting=2E

Change-Id: I4=
54d5040cbad4d373ee4f90b8d683200d2a4c0e4
Signed-off-by: Lev Stipakov <lev@op=
envpn=2Enet>
---
M src/openvpn/init=2Ec
M src/openvpn/oob=2Eh
M src/openvpn=
/oob_client=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/ssl=2Ec
M src/openv=
pn/ssl=2Eh
6 files changed, 172 insertions(+), 4 deletions(-)



  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1770/1

diff --=
git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 8eca6f7=2E=2Efc44f4=
1 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3505,6 +=
3505,21 @@
         /* Keep the max mtu also in the frame of tls multi so i=
t can access
          * it in push_peer_info */
         c->c2=2Etls_multi=
->opt=2Eframe=2Etun_max_mtu =3D c->c2=2Eframe=2Etun_max_mtu;
+
+        /* =
OOB server-probe handshake shortcut: the probe reply already served as
+   =
      * the server's HARD_RESET (it carried a valid SYN-cookie), so skip ou=
r
+         * own reset exchange and start the handshake at the third packe=
t=2E Count
+         * the reply as the initial packet received (as the ser=
ver does before its
+         * own session_skip_to_pre_start), so tls_init=
ial_packet_received() is true
+         * and check_server_poll_timeout() d=
oes not restart a connected session=2E */
+        if (c->c2=2Eoob_probe_ad=
opt)
+        {
+            c->c2=2Etls_multi->n_sessions++;
+            =
session_skip_to_pre_start_client(&c->c2=2Etls_multi->session[TM_ACTIVE],
+ =
                                            &c->c2=2Eoob_probe_client_sid,
=
+                                             &c->c2=2Eoob_probe_server_sid=
, &c->c2=2Eoob_probe_remote,
+                                             =
c->c2=2Eoob_probe_resend_wkc);
+        }
     }
     if (c->c2=2Etls_auth_=
standalone)
     {
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
i=
ndex 44a51ec=2E=2E1bfa601 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvp=
n/oob=2Eh
@@ -245,6 +245,11 @@
     uint16_t weight;
     uint16_t max_late=
ncy_diff; /* margin advertised by this server (ms); 0 =3D use client defaul=
t */
     unsigned int rtt_ms;       /* probe round-trip time in ms (respon=
ders only) */
+    /* Captured from the reply for the handshake shortcut (r=
esponders only): */
+    struct session_id server_sid;      /* the reply's =
own session id =3D server SYN-cookie */
+    uint16_t connect_lifetime;    =
     /* seconds the reply is valid as a shortcut; 0 =3D none */
+    uint32=
_t reply_flags;              /* OOB_PROBE_REPLY_FLAG_* advertised by the se=
rver */
+    struct sockaddr_storage responder; /* address that answered (p=
in the connection to it) */
 };
 
 /**
diff --git a/src/openvpn/oob_client=
=2Ec b/src/openvpn/oob_client=2Ec
index b257da3=2E=2E6d47413 100644
--- a/s=
rc/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -38,6 +38,7 @=
@
 #include "otime=2Eh"
 #include "fdmisc=2Eh"
 #include "crypto=2Eh"
+#inc=
lude "dco=2Eh"
 #include "error=2Eh"
 
 #include "memdbg=2Eh"
@@ -215,6 +21=
6,13 @@
         return;
     }
 
+    /* The reply's own session id (the s=
erver's stateless SYN-cookie) follows the
+     * opcode byte=2E Capture it=
 before read_control_auth() strips it: a client may
+     * reuse it to ski=
p to the third handshake packet (the connect_lifetime
+     * shortcut)=2E =
*/
+    struct session_id server_sid;
+    memcpy(server_sid=2Eid, data + 1=
, SID_SIZE);
+
     struct buffer buf;
     buf_set_read(&buf, data, (size_=
t)len);
 
@@ -273,6 +281,10 @@
         results[i]=2Eweight =3D reply=2Ewei=
ght;
         results[i]=2Emax_latency_diff =3D reply=2Emax_latency_diff;
 =
        results[i]=2Ertt_ms =3D (ms > 0) ? (unsigned int)ms : 0;
+        r=
esults[i]=2Eserver_sid =3D server_sid;
+        results[i]=2Econnect_lifeti=
me =3D reply=2Econnect_lifetime;
+        results[i]=2Ereply_flags =3D repl=
y=2Eflags;
+        results[i]=2Eresponder =3D *from; /* pin the connection=
 to the address that answered */
         break;
     }
 }
@@ -588,7 +600,6=
 @@
     {
         oob_probe_collect(&pc, &probe, &client_sid, &tas->tls_w=
rap, targets, results, l->len);
     }
-    oob_probe_sockets_close(&pc);
 =

     /* Log each remote's outcome while results[i] still maps to array[i]=
=2E */
     int responded =3D 0;
@@ -607,10 +618,10 @@
                    =
                  : results[i]=2Emax_latency_diff > 0 ? "server-advertised"=

                                                                        : =
"default";
             msg(D_LOW,
-                "server-probe: %s:%s an=
swered (priority %d, weight %d, rtt %u ms;"
-                " latency marg=
in %d ms [%s])",
+                "server-probe: %s:%s answered (priority %=
d, weight %d, connect-lifetime %d s,"
+                " rtt %u ms; latency=
 margin %d ms [%s])",
                 ce->remote, ce->remote_port, results=
[i]=2Epriority, results[i]=2Eweight,
-                results[i]=2Ertt_ms, =
margin, margin_src);
+                results[i]=2Econnect_lifetime, result=
s[i]=2Ertt_ms, margin, margin_src);
         }
         else
         {
@@ =
-632,6 +643,70 @@
     msg(M_INFO, "server-probe: %d of %d remote(s) answer=
ed; connecting best-first", responded,
         l->len);
 
+    /* Handshak=
e shortcut: if the best remote (now l->array[0] / results[0])
+     * answe=
red and advertised a connect_lifetime, hand its probe socket and the
+     =
* captured cookie/details to the connection so it starts at the third packe=
t
+     * (see session_skip_to_pre_start_client)=2E The winner's AF socket =
becomes the
+     * connection socket, preserving the source IP+port the se=
rver's cookie is
+     * bound to=2E Not possible with dco-win (no user->ke=
rnel socket handoff), so
+     * skip the shortcut there; probing/ordering =
still applied above=2E */
+    /* The RFC also requires the client to fall =
back to a full handshake once
+     * more than connect_lifetime seconds ha=
ve elapsed since the probe=2E We probe
+     * immediately before connectin=
g (~0 s gap), so that check is a no-op today;
+     * add an elapsed-time g=
uard here if probe results are ever cached and reused
+     * across reconn=
ects=2E */
+    bool shortcut =3D results[0]=2Eresponded && results[0]=2Eco=
nnect_lifetime > 0;
+    bool dco_win_gate =3D false;
+#if defined(_WIN32)
=
+    if (dco_enabled(&c->options))
+    {
+        shortcut =3D false;
+   =
     dco_win_gate =3D true;
+    }
+#endif
+    if (shortcut)
+    {
+     =
   const int af_idx =3D probe_af_index(results[0]=2Eresponder=2Ess_family);=

+        c->c2=2Eoob_probe_sd =3D pc=2Esd[af_idx];
+        pc=2Esd[af_idx=
] =3D SOCKET_UNDEFINED; /* relinquish: the connection owns it now */
+
+   =
     CLEAR(c->c2=2Eoob_probe_remote);
+        if (results[0]=2Eresponder=
=2Ess_family =3D=3D AF_INET)
+        {
+            c->c2=2Eoob_probe_remo=
te=2Eaddr=2Ein4 =3D *(struct sockaddr_in *)(void *)&results[0]=2Eresponder;=

+        }
+        else
+        {
+            c->c2=2Eoob_probe_remote=
=2Eaddr=2Ein6 =3D *(struct sockaddr_in6 *)(void *)&results[0]=2Eresponder;
=
+        }
+        c->c2=2Eoob_probe_client_sid =3D client_sid;
+        c=
->c2=2Eoob_probe_server_sid =3D results[0]=2Eserver_sid;
+        c->c2=2Eo=
ob_probe_resend_wkc =3D
+            (results[0]=2Ereply_flags & OOB_PROBE_=
REPLY_FLAG_RESEND_WKC) !=3D 0;
+        c->c2=2Eoob_probe_adopt =3D true;
+=

+        msg(D_LOW, "server-probe: using handshake shortcut to %s:%s (conn=
ect-lifetime %d s)",
+            l->array[0]->remote, l->array[0]->remote_=
port, results[0]=2Econnect_lifetime);
+    }
+    else if (results[0]=2Eres=
ponded)
+    {
+        /* A server answered but we won't take the shortcut=
 -- say why=2E */
+        if (dco_win_gate)
+        {
+            msg(D_=
LOW, "server-probe: handshake shortcut unavailable with dco-win;"
+        =
               " using a full handshake");
+        }
+        else if (res=
ults[0]=2Econnect_lifetime =3D=3D 0)
+        {
+            msg(D_LOW, "se=
rver-probe: %s:%s did not offer a handshake shortcut"
+                    =
   " (connect-lifetime 0); using a full handshake",
+                l->arr=
ay[0]->remote, l->array[0]->remote_port);
+        }
+    }
+
+    /* Close=
 any probe sockets we did not hand off to the connection=2E */
+    oob_pro=
be_sockets_close(&pc);
+
     tls_auth_standalone_free(tas);
     gc_free(&=
gc);
 }
diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
inde=
x e5a1d76=2E=2E69eec10 100644
--- a/src/openvpn/openvpn=2Eh
+++ b/src/openv=
pn/openvpn=2Eh
@@ -249,6 +249,9 @@
     bool oob_probe_adopt;
     socket_d=
escriptor_t oob_probe_sd;
     struct openvpn_sockaddr oob_probe_remote;
+ =
   struct session_id oob_probe_client_sid;  /* our probe session id (cookie=
 was minted over it) */
+    struct session_id oob_probe_server_sid;  /* th=
e reply's session id =3D server cookie to echo back */
+    bool oob_probe_=
resend_wkc;               /* reply asked to complete with CONTROL_WKC_V1 (v=
2) */
 
     struct link_socket_actual *to_link_addr; /* IP address of remo=
te */
     struct link_socket_actual from;          /* address of incoming =
datagram */
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 09=
98bd6=2E=2E4503a05 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=
=2Ec
@@ -2516,6 +2516,59 @@
     return session_move_pre_start(session, ks,=
 true);
 }
 
+bool
+session_skip_to_pre_start_client(struct tls_session *se=
ssion, const struct session_id *client_sid,
+                              =
   const struct session_id *server_sid,
+                                 c=
onst struct openvpn_sockaddr *remote, bool resend_wkc)
+{
+    struct key_s=
tate *ks =3D &session->key[KS_PRIMARY];
+
+    /* Our session id must be th=
e one used for the probe: the server's cookie
+     * (server_sid) is an HM=
AC over it, and the server re-derives and checks it
+     * when it validat=
es our (shortcut) third packet=2E */
+    session->session_id =3D *client_s=
id;
+    ks->session_id_remote =3D *server_sid;
+
+    struct link_socket_a=
ctual act =3D { 0 };
+    act=2Edest =3D *remote;
+    ks->remote_addr =3D =
act;
+    session->untrusted_addr =3D act;
+    session->burst =3D true;
+
=
+    /* tls-crypt-v2: the stateless server discarded the WKc after the prob=
e, so
+     * complete the handshake with P_CONTROL_WKC_V1 (drives control_=
packet_needs_wkc)=2E */
+    if (resend_wkc)
+    {
+        ks->crypto_opt=
ions=2Eflags |=3D CO_RESEND_WKC;
+    }
+
+    /* We never received the ser=
ver's HARD_RESET (id 0) =E2=80=94 the probe reply stood
+     * in for it=
=2E Acknowledge that phantom id 0 so our third packet carries an
+     * AC=
K together with the server session id (the cookie): reliable_ack_write()
+ =
    * only emits that session id when at least one ACK is present, and the =
server
+     * needs it to validate the stateless cookie=2E */
+    reliabl=
e_ack_acknowledge_packet_id(ks->rec_ack, 0);
+
+    /* Skip one (RESET) pac=
ket in each direction, so ids start at 1 (see
+     * session_skip_to_pre_s=
tart)=2E */
+    ks->rec_reliable->packet_id =3D 1;
+    session->tls_wrap=
=2Eopt=2Epacket_id=2Esend=2Eid =3D 1;
+
+    /* Do not send our own HARD_RE=
SET=2E Unlike the server's skip, the client must
+     * send first: the st=
ateless server only replies once it sees our third
+     * packet=2E sessio=
n_move_pre_start(skip=3Dtrue) leaves us in S_PRE_START_SKIP,
+     * which =
only advances when a packet is *received*; instead drop to
+     * S_PRE_ST=
ART with an empty send-reliable (the initial packet was generated
+     * a=
nd immediately deleted), so tls_process() promotes us to S_START and
+     =
* sends the ClientHello without waiting for a server reset=2E */
+    if (!=
session_move_pre_start(session, ks, true))
+    {
+        return false;
+ =
   }
+    ks->state =3D S_PRE_START;
+    return true;
+}
+
 /**
  * Parses=
 the TLVs (type, length, value) in the early negotiation
  */
diff --git a/=
src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh
index 5822336=2E=2E6ae9678 100644=

--- a/src/openvpn/ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@ -576,4 +576,21 @@
 =
bool session_skip_to_pre_start(struct tls_session *session, struct tls_pre_=
decrypt_state *state,
                                struct link_socket_ac=
tual *from);
 
+/**
+ * Client counterpart of session_skip_to_pre_start(): =
start the handshake at the
+ * third packet using a server session id (SYN-=
cookie) learned earlier from an
+ * OOB server probe reply, instead of send=
ing our own HARD_RESET=2E Saves one RTT=2E
+ *
+ * @param session     the (=
client) TLS session to fast-forward
+ * @param client_sid  session id used =
for the probe (the cookie is an HMAC over it)
+ * @param server_sid  the se=
rver's cookie, echoed back to complete the handshake
+ * @param remote     =
 the probed (pinned) server address to connect to
+ * @param resend_wkc  tr=
ue to complete with P_CONTROL_WKC_V1 (tls-crypt-v2)
+ * @return true if the=
 session was fast-forwarded, false on failure
+ */
+bool session_skip_to_pr=
e_start_client(struct tls_session *session,
+                              =
        const struct session_id *client_sid,
+                             =
         const struct session_id *server_sid,
+                            =
          const struct openvpn_sockaddr *remote, bool resend_wkc);
+
 #endi=
f /* ifndef OPENVPN_SSL_H */

-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1770?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
Gerrit-Change-Number: 1=
770
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>

--SLsBGh3i+7k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1770?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oo=
b: client handshake shortcut via a server probe<br><br>When the best remote=
 answered a probe and advertised a connect_lifetime, the<br>client now skip=
s its own three-way handshake and starts at the third packet,<br>reusing th=
e probe reply as the server&#39;s HARD_RESET (its session id is a valid<br>=
stateless SYN-cookie)=2E Saves one RTT on connect=2E<br><br>  - oob_client=
=2Ec: on a shortcut-capable winner, hand its probe socket, the<br>    captu=
red server session id (cookie), our probe session id, the pinned<br>    res=
ponder address, and the resend-wkc flag to the connection via c2;<br>    re=
linquish that socket (do not close it); gate off for dco-win, which has<br>=
    no user-to-kernel socket handoff (probing still works, only the shortcu=
t is<br>    skipped)=2E<br>  - ssl=2Ec session_skip_to_pre_start_client(): =
seed our session id to the probe&#39;s<br>    (the cookie is an HMAC over i=
t), the remote session id to the cookie, ack<br>    the phantom server rese=
t (id 0) so the third packet carries the cookie, set<br>    CO_RESEND_WKC f=
or tls-crypt-v2, and drop to S_PRE_START so tls_process()<br>    promotes t=
o S_START and sends the ClientHello (no HARD_RESET sent)=2E<br>  - init=2Ec=
: invoke the client skip after tls_multi_init_finalize when adopting=2E<br>=
<br>Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4<br>Signed-off-by: =
Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/init=2Ec<br>=
M src/openvpn/oob=2Eh<br>M src/openvpn/oob_client=2Ec<br>M src/openvpn/open=
vpn=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl=2Eh<br>6 files change=
d, 172 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1770/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index=
 8eca6f7=2E=2Efc44f41 100644</span><br><span>--- a/src/openvpn/init=2Ec</sp=
an><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -3505,6 +3505,21=
 @@</span><br><span>         /* Keep the max mtu also in the frame of tls m=
ulti so it can access</span><br><span>          * it in push_peer_info */</=
span><br><span>         c-&gt;c2=2Etls_multi-&gt;opt=2Eframe=2Etun_max_mtu =
=3D c-&gt;c2=2Eframe=2Etun_max_mtu;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* OOB server-probe handshake shortcut: the probe reply already served=
 as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * the s=
erver&#39;s HARD_RESET (it carried a valid SYN-cookie), so skip our</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+         * own reset exchan=
ge and start the handshake at the third packet=2E Count</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * the reply as the initial pac=
ket received (as the server does before its</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+         * own session_skip_to_pre_start), so tls_i=
nitial_packet_received() is true</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * and check_server_poll_timeout() does not restart a =
connected session=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (c-&gt;c2=2Eoob_probe_adopt)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            c-&gt;c2=2Etls_multi-&gt;n_sessions++;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            session_skip_to_pr=
e_start_client(&amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE],</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
               &amp;c-&gt;c2=2Eoob_probe_client_sid,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
    &amp;c-&gt;c2=2Eoob_probe_server_sid, &amp;c-&gt;c2=2Eoob_probe_remote,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                          c-&gt;c2=2Eoob_probe_resend_wkc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</s=
pan><br><span>     if (c-&gt;c2=2Etls_auth_standalone)</span><br><span>    =
 {</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</=
span><br><span>index 44a51ec=2E=2E1bfa601 100644</span><br><span>--- a/src/=
openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@=
@ -245,6 +245,11 @@</span><br><span>     uint16_t weight;</span><br><span> =
    uint16_t max_latency_diff; /* margin advertised by this server (ms); 0 =
=3D use client default */</span><br><span>     unsigned int rtt_ms;       /=
* probe round-trip time in ms (responders only) */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* Captured from the reply for the hands=
hake shortcut (responders only): */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct session_id server_sid;      /* the reply&#39;s o=
wn session id =3D server SYN-cookie */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    uint16_t connect_lifetime;         /* seconds the re=
ply is valid as a shortcut; 0 =3D none */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    uint32_t reply_flags;              /* OOB_PROBE_R=
EPLY_FLAG_* advertised by the server */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct sockaddr_storage responder; /* address that =
answered (pin the connection to it) */</span><br><span> };</span><br><span>=
 </span><br><span> /**</span><br><span>diff --git a/src/openvpn/oob_client=
=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index b257da3=2E=2E6d4741=
3 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+=
++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -38,6 +38,7 @@</span><br=
><span> #include &quot;otime=2Eh&quot;</span><br><span> #include &quot;fdmi=
sc=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;dco=2Eh&quot;</spa=
n><br><span> #include &quot;error=2Eh&quot;</span><br><span> </span><br><sp=
an> #include &quot;memdbg=2Eh&quot;</span><br><span>@@ -215,6 +216,13 @@</s=
pan><br><span>         return;</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The reply&#39;s =
own session id (the server&#39;s stateless SYN-cookie) follows the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * opcode byte=2E Captur=
e it before read_control_auth() strips it: a client may</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * reuse it to skip to the third ha=
ndshake packet (the connect_lifetime</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * shortcut)=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct session_id server_sid;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    memcpy(server_sid=2Eid, data + 1, SID=
_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     struct buffer buf;</span><br><span>     buf_set_read(&amp;buf, da=
ta, (size_t)len);</span><br><span> </span><br><span>@@ -273,6 +281,10 @@</s=
pan><br><span>         results[i]=2Eweight =3D reply=2Eweight;</span><br><s=
pan>         results[i]=2Emax_latency_diff =3D reply=2Emax_latency_diff;</s=
pan><br><span>         results[i]=2Ertt_ms =3D (ms &gt; 0) ? (unsigned int)=
ms : 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        resu=
lts[i]=2Eserver_sid =3D server_sid;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        results[i]=2Econnect_lifetime =3D reply=2Econnect_l=
ifetime;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        res=
ults[i]=2Ereply_flags =3D reply=2Eflags;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        results[i]=2Eresponder =3D *from; /* pin the c=
onnection to the address that answered */</span><br><span>         break;</=
span><br><span>     }</span><br><span> }</span><br><span>@@ -588,7 +600,6 @=
@</span><br><span>     {</span><br><span>         oob_probe_collect(&amp;pc=
, &amp;probe, &amp;client_sid, &amp;tas-&gt;tls_wrap, targets, results, l-&=
gt;len);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    oob_probe_sockets_close(&amp;pc);</span><br><span> </span><br=
><span>     /* Log each remote&#39;s outcome while results[i] still maps to=
 array[i]=2E */</span><br><span>     int responded =3D 0;</span><br><span>@=
@ -607,10 +618,10 @@</span><br><span>                                      =
: results[i]=2Emax_latency_diff &gt; 0 ? &quot;server-advertised&quot;</spa=
n><br><span>                                                               =
         : &quot;default&quot;;</span><br><span>             msg(D_LOW,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;ser=
ver-probe: %s:%s answered (priority %d, weight %d, rtt %u ms;&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot; latenc=
y margin %d ms [%s])&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                &quot;server-probe: %s:%s answered (priority %d, we=
ight %d, connect-lifetime %d s,&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                &quot; rtt %u ms; latency margin %d ms [%=
s])&quot;,</span><br><span>                 ce-&gt;remote, ce-&gt;remote_po=
rt, results[i]=2Epriority, results[i]=2Eweight,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                results[i]=2Ertt_ms, margin, marg=
in_src);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     results[i]=2Econnect_lifetime, results[i]=2Ertt_ms, margin, margin_src=
);</span><br><span>         }</span><br><span>         else</span><br><span=
>         {</span><br><span>@@ -632,6 +643,70 @@</span><br><span>     msg(M=
_INFO, &quot;server-probe: %d of %d remote(s) answered; connecting best-fir=
st&quot;, responded,</span><br><span>         l-&gt;len);</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Handshake sh=
ortcut: if the best remote (now l-&gt;array[0] / results[0])</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * answered and advertised a c=
onnect_lifetime, hand its probe socket and the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * captured cookie/details to the connection=
 so it starts at the third packet</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * (see session_skip_to_pre_start_client)=2E The winner&#=
39;s AF socket becomes the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * connection socket, preserving the source IP+port the server&#=
39;s cookie is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* bound to=2E Not possible with dco-win (no user-&gt;kernel socket handoff)=
, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * skip the=
 shortcut there; probing/ordering still applied above=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* The RFC also requires the cl=
ient to fall back to a full handshake once</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * more than connect_lifetime seconds have elaps=
ed since the probe=2E We probe</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * immediately before connecting (~0 s gap), so that check i=
s a no-op today;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * add an elapsed-time guard here if probe results are ever cached and reu=
sed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * across re=
connects=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
ool shortcut =3D results[0]=2Eresponded &amp;&amp; results[0]=2Econnect_lif=
etime &gt; 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bo=
ol dco_win_gate =3D false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (dco_enabled(&amp;c-&gt;options))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        shortcut =3D false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        dco_win_gate =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (shortcut)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst int af_idx =3D probe_af_index(results[0]=2Eresponder=2Ess_family);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_=
probe_sd =3D pc=2Esd[af_idx];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        pc=2Esd[af_idx] =3D SOCKET_UNDEFINED; /* relinquish: the =
connection owns it now */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR=
(c-&gt;c2=2Eoob_probe_remote);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (results[0]=2Eresponder=2Ess_family =3D=3D AF_INET)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2Eoob_prob=
e_remote=2Eaddr=2Ein4 =3D *(struct sockaddr_in *)(void *)&amp;results[0]=2E=
responder;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2Eoob_probe_rem=
ote=2Eaddr=2Ein6 =3D *(struct sockaddr_in6 *)(void *)&amp;results[0]=2Eresp=
onder;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_=
probe_client_sid =3D client_sid;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        c-&gt;c2=2Eoob_probe_server_sid =3D results[0]=2Eserve=
r_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt=
;c2=2Eoob_probe_resend_wkc =3D</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            (results[0]=2Ereply_flags &amp; OOB_PROBE_REPLY_FLAG=
_RESEND_WKC) !=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        c-&gt;c2=2Eoob_probe_adopt =3D true;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(D_LOW, &quot;server-probe: using handshake shortcut to %=
s:%s (connect-lifetime %d s)&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            l-&gt;array[0]-&gt;remote, l-&gt;array[0]-&gt;r=
emote_port, results[0]=2Econnect_lifetime);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else if (results[0]=2Eresponded)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        /* A server answered but we won&#39;t take the shortcu=
t -- say why=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (dco_win_gate)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       msg(D_LOW, &quot;server-probe: handshake shortcut unavailable with d=
co-win;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                 &quot; using a full handshake&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        else if (results[0]=2Econnect_lifetime =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, =
&quot;server-probe: %s:%s did not offer a handshake shortcut&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                       &quot=
; (connect-lifetime 0); using a full handshake&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                l-&gt;array[0]-&gt;remote=
, l-&gt;array[0]-&gt;remote_port);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Close any probe socke=
ts we did not hand off to the connection=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    oob_probe_sockets_close(&amp;pc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     tls_auth=
_standalone_free(tas);</span><br><span>     gc_free(&amp;gc);</span><br><sp=
an> }</span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/op=
envpn=2Eh</span><br><span>index e5a1d76=2E=2E69eec10 100644</span><br><span=
>--- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2E=
h</span><br><span>@@ -249,6 +249,9 @@</span><br><span>     bool oob_probe_a=
dopt;</span><br><span>     socket_descriptor_t oob_probe_sd;</span><br><spa=
n>     struct openvpn_sockaddr oob_probe_remote;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct session_id oob_probe_client_sid;  /=
* our probe session id (cookie was minted over it) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct session_id oob_probe_server_si=
d;  /* the reply&#39;s session id =3D server cookie to echo back */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    bool oob_probe_resend_w=
kc;               /* reply asked to complete with CONTROL_WKC_V1 (v2) */</s=
pan><br><span> </span><br><span>     struct link_socket_actual *to_link_add=
r; /* IP address of remote */</span><br><span>     struct link_socket_actua=
l from;          /* address of incoming datagram */</span><br><span>diff --=
git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 0998b=
d6=2E=2E4503a05 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br>=
<span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -2516,6 +2516,59 @@</spa=
n><br><span>     return session_move_pre_start(session, ks, true);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sessio=
n_skip_to_pre_start_client(struct tls_session *session, const struct sessio=
n_id *client_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                               const struct session_id *server_sid,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
      const struct openvpn_sockaddr *remote, bool resend_wkc)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct key_state *ks =3D &amp;session-&gt;key[K=
S_PRIMARY];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Our session id must =
be the one used for the probe: the server&#39;s cookie</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * (server_sid) is an HMAC over it, =
and the server re-derives and checks it</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * when it validates our (shortcut) third packet=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;=
session_id =3D *client_sid;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ks-&gt;session_id_remote =3D *server_sid;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct link_socket_actual act =3D { 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    act=2Edest =3D *remote;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;remote_addr =3D =
act;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session-&gt=
;untrusted_addr =3D act;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    session-&gt;burst =3D true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* tls-crypt-v2: the stateless server discarded the WKc after the probe, =
so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * complete t=
he handshake with P_CONTROL_WKC_V1 (drives control_packet_needs_wkc)=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (resend_wkc)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        ks-&gt;crypto_options=2Efl=
ags |=3D CO_RESEND_WKC;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* We never received the =
server&#39;s HARD_RESET (id 0) =E2=80=94 the probe reply stood</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * in for it=2E Acknowledge =
that phantom id 0 so our third packet carries an</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * ACK together with the server session id=
 (the cookie): reliable_ack_write()</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * only emits that session id when at least one ACK is =
present, and the server</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * needs it to validate the stateless cookie=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    reliable_ack_acknowledge_packet_=
id(ks-&gt;rec_ack, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Skip one =
(RESET) packet in each direction, so ids start at 1 (see</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * session_skip_to_pre_start)=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;rec_rel=
iable-&gt;packet_id =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    session-&gt;tls_wrap=2Eopt=2Epacket_id=2Esend=2Eid =3D 1;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Do not send our own HARD_RESET=2E Unli=
ke the server&#39;s skip, the client must</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * send first: the stateless server only replies =
once it sees our third</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * packet=2E session_move_pre_start(skip=3Dtrue) leaves us in S_PRE_=
START_SKIP,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * w=
hich only advances when a packet is *received*; instead drop to</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * S_PRE_START with an empt=
y send-reliable (the initial packet was generated</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * and immediately deleted), so tls_proce=
ss() promotes us to S_START and</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * sends the ClientHello without waiting for a server reset=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!sess=
ion_move_pre_start(session, ks, true))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks-=
&gt;state =3D S_PRE_START;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> /**</span><br><span>  * Parses the TLVs (type, length, value) in the ea=
rly negotiation</span><br><span>  */</span><br><span>diff --git a/src/openv=
pn/ssl=2Eh b/src/openvpn/ssl=2Eh</span><br><span>index 5822336=2E=2E6ae9678=
 100644</span><br><span>--- a/src/openvpn/ssl=2Eh</span><br><span>+++ b/src=
/openvpn/ssl=2Eh</span><br><span>@@ -576,4 +576,21 @@</span><br><span> bool=
 session_skip_to_pre_start(struct tls_session *session, struct tls_pre_decr=
ypt_state *state,</span><br><span>                                struct li=
nk_socket_actual *from);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Client counterpart of session_skip_to_pre_start(): start the hand=
shake at the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * thir=
d packet using a server session id (SYN-cookie) learned earlier from an</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * OOB server probe rep=
ly, instead of sending our own HARD_RESET=2E Saves one RTT=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param session     the (client) TLS session to =
fast-forward</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am client_sid  session id used for the probe (the cookie is an HMAC over it=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param server_s=
id  the server&#39;s cookie, echoed back to complete the handshake</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param remote      the pr=
obed (pinned) server address to connect to</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param resend_wkc  true to complete with P_CONTRO=
L_WKC_V1 (tls-crypt-v2)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @return true if the session was fast-forwarded, false on failure</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool session_skip_to_pre_start_client(s=
truct tls_session *session,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                      const struct session_id *clie=
nt_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                          const struct session_id *server_sid,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
      const struct openvpn_sockaddr *remote, bool resend_wkc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifnd=
ef OPENVPN_SSL_H */</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demail">change 1=
770</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"=
display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> =
Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id:=
 I454d5040cbad4d373ee4f90b8d683200d2a4c0e4 </div>
<div style=3D"display:non=
e"> Gerrit-Change-Number: 1770 </div>
<div style=3D"display:none"> Gerrit-P=
atchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lsti=
pakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--SLsBGh3i+7k=--


--===============0568465983131484314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0568465983131484314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0568465983131484314==--

