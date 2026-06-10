Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E26ACD98CC
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/J6wN1YX26Mu5jGe98eiPC87gfNbQI5sCBKgmve1XNs=; b=TdykSup6HE44AtpHbwdz7dTYf9
	qAdHedh1t1OtJUsyRL6Pora3ID0IpQJs5pIp6QaX+OVfG33y1q8yl2J0Zi3Xsmx0VXhjLJky2WSXk
	5lIUbL57N+AGavmeH9W7fAipTwYLwWXv+Ti+Zg7sF/LqC9FDsYM7uT8lBFnGTw8bEb04=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXM6z-00041J-9s;
	Wed, 10 Jun 2026 16:49:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXM6y-00041C-9X
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 16:49:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Z0TFMMywHgQvLceUr6hq7Ggzh6O2Bcz6F/tSKcabXeo=; b=IYgc3mu/TKQd35WGoUt1/GVS/l
 DUYMfNMh6u8wgqIews2Yj8AUwVuggUHH/lkNqK410DK5oGSzVaCEeYW3VJL1XGujzEbMSH1u3JdfK
 dlEceee/eoh6vj/gUkiltAec8bSBtxO1V0aDeeInsVEy7fYw6lb6qPABTeIP814+Pr0Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Z0TFMMywHgQvLceUr6hq7Ggzh6O2Bcz6F/tSKcabXeo=; b=e
 yx8mnZ4I10jnyGEplDol2n6TiYe+FYhH/WUdZZN7Ra5cBwbuS86Z+fE2wgW4wmVVE1wkhxqlSqVr1
 LjfGGgCOB5XRXfblStebFoK+Tkq5qrdVTVqD81s/oW4MBLIpEGJdtS+1cY35cKfRSR84QqtvakuGE
 08d5xzx4MMGqNEOA=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXM6v-0004LH-Eu for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 16:49:04 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490af320e2aso77068515e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781110129; x=1781714929; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z0TFMMywHgQvLceUr6hq7Ggzh6O2Bcz6F/tSKcabXeo=;
 b=fZfu458ZpI0HSmSjbEtOsTNdlLz6PlW3hwA0ZwU45vr4Cyquv6PkGMti7zNr38ge7e
 rB01fshbJB5YOd+d2lPxGLkpbbC0wdcLtKHXmnrZeG0d/XDrka7YsAuPHt4D4b1U6Ziw
 KQTEkAd2PyJEfPLCaCfpFCln8+TCEwB8Fc6xNdLzkXWhy8DqQ3QIqV0QC+pP+GCZE9Yx
 2ShSu0kHezFYYmbWre9owGR6yhs4sIH9CAh7NuL+7FE7Xou/ico47+Du5wzGLKdwTX85
 0/3lq4bLfBTvp2AX0a8Fn2v9ap4DjrPskgy+OHL83AyL8Ju4oXzfxvMRZMPcwVOeaWbl
 R4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781110129; x=1781714929;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z0TFMMywHgQvLceUr6hq7Ggzh6O2Bcz6F/tSKcabXeo=;
 b=fbhawi0t/wxJQNlwrPuU9fkI4PQlRkWhRZ068oPQZgBIHh6lH+bf3lSRL8FvuswhM1
 futRpY1Jf0ocdyFbvJrNT8Lf2y6CRiuWRC8QAGRe6qARukfhjKF6w1RRzh9Mc2YHOxOk
 ZgLuOerliJU3f7evaaA0n88tLnYR3oZY7V5hWFaOw4wLOw8Q7fVD0rC8yO4BkCPp0/of
 MkwtVkW/sXN1OhQF1qQehDSnG3RbATzCWv/k8IRTtTZcDVe9VPCXZo0IuLq3U1Gf2SDc
 LWCRWZqh3vmbN/vVqt5QOVSwoL9j3GhJ7GjCYNVllLC1bbiEfgTvm/i4FlRlO/NyYx5g
 YnfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IMmPkHtwf4/5E6LTRoBEs4jQzKojvVG4xKciqLJlAd9qzV9Zr77Yhyhhqoi9geq56I8NQ8K7/qj1Nlqp9@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyGN5pr54zT1UVuJd+LU3ZoT82NdQvFB8OBAHtV+yetmcx36U20
 LEZTe6TeKdgeOwEIPDYjx48rxqiEcgc0S4VSCHH0sarRfEK0OJAa4ncrrBWfOYFM+TT5UgWifD5
 myDTcFTOHKWtJFCJ1bXdOZB7tKV2ICndAWpbav1I5arecR/Ly1SdXbhf5OH7Ct0PUj7R1/6HoM4
 ktYpI9Ag==
X-Gm-Gg: Acq92OFz1Nk1EGzA/L4EoEGFGojOg3MDAfJO8lpW0VZcX+bXYraOsYGLDyRWp+7e/Rs
 EoLS8OQslQoLNQWPdBs0LBDiInfpPlNdacYL6Z2M892azfOKvKTQfw4Scst7JSm6W1wq2cZyp36
 nhTyTHxWmOmcbDsGTB4a1pMBVekDbwTZx0kev2cJnJnOyDpoi+uFoDewooudsb34NLm6GrTu6rZ
 G9rncM3dopnTJDCoQnISUG4eGN/tnOh+kW08oo+hshFNaWB6Kp2Cru9UYWooFkSeUtbj/FqHnAB
 +45CxF9RiLxj+Ls9wjaCaTGdIwykD47O0Trb29hDHSGhphyOdgO+qKik30HuLes+8oO/e/JMC49
 elJe7lb+DXKFt03tZn2FjGc6NvHfUkPdJVKmJ4C3wqZfT7TI8oHpKDMIscxcGQraSnCw69g58Uz
 taATdKY77xKM/WzuKSN6tKy5KDVf3hkn2qBvWy9ehJdSErVbfCSHxWCZPQV20JZZenlR0xfLn/X
 YLJH02ebQCUQ1TD+FvYoEUwr0mm1PcQqD98anglksij0TtRRDVs/36ZglNU3Lr5gGpJEMdxq4RZ
 WwSHUc+Rnqpgbf9dgHU9vkpbONP9MrgEGKA=
X-Received: by 2002:a05:600c:608e:b0:490:b355:9c8c with SMTP id
 5b1f17b1804b1-490c25f3f00mr403452695e9.23.1781110129371; 
 Wed, 10 Jun 2026 09:48:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e246f28asm3947655e9.0.2026.06.10.09.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:48:49 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 10 Jun 2026 16:48:48 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942
X-Gerrit-Change-Number: 1702
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1702?usp=email>
X-Gerrit-Commit: 9bad30f6d9884d48db57106ce078bfd7b2a73df9
In-Reply-To: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
References: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5NDU1ODgwMDAwLkkyZGYwZmVjNzg2MTg0YjlmY2Y5YjdjNTZjNzQ4MTYzMjVjZGI2OTQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0bb1c694ee1756f12d447cbda2a18e17528e796d-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXM6v-0004LH-Eu
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mudp: send HMAC
 reset reply synchronously
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5124176018136282770=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5124176018136282770==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1DchmUjVD30="; charset=UTF-8

--1DchmUjVD30=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1702?usp=3Demail )

Change subject: mudp: send HMAC reset reply synchro=
nously
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mudp=
: send HMAC reset reply synchronously

Building a HARD_RESET reply was queu=
eing the result into three
multi_context fields and deferring the send to t=
he next event-loop
iteration, where multi_process_outgoing_link() flushed i=
t:

  struct buffer hmac_reply;
  struct link_socket_actual *hmac_reply_des=
t;  /* aliased &m->top=2Ec2=2Efrom */
  struct link_socket *hmac_reply_ls;
=

The mechanism had three latent issues:

1=2E hmac_reply_dest =3D &m->top=
=2Ec2=2Efrom stored a pointer alias into
   shared mutable state=2E  Any su=
bsequent read into m->top=2Ec2=2Efrom
   silently retargeted the pending re=
ply to a different peer=2E
2=2E m->hmac_reply_ls =3D sock; at the top of mu=
lti_get_create_instance_udp()
   was executed unconditionally for every UDP=
 packet, including packets
   that did not queue a reply=2E  A stale queued=
 reply could thus be sent
   on the wrong listening socket=2E
3=2E hmac_rep=
ly=2Edata pointed into m->top=2Ec2=2Ebuffers->aux_buf (the only
   slot)=2E=
  A second send_hmac_reset_packet() before the first flush
   would overwri=
te the first reply's bytes=2E

These were latent on master because m->multi=
_io->udp_flags was consumed
and zeroed by the first event in each multi_io_=
process_io() loop, so at
most one UDP read ran per outer iteration=2E

Send=
 the reply synchronously from within send_hmac_reset_packet() using
the soc=
k that the read fired on (threaded through do_pre_decrypt_check)=2E
The rep=
ly is small, stateless, and rate-limited by the existing
reflect_filter_rat=
e_limit_check(); dropping on EAGAIN is acceptable
because the client retran=
smits its HARD_RESET=2E  The three multi_context
fields and the deferred-fl=
ush block in multi_process_outgoing_link() are
gone; p2mp_iow_flags() no lo=
nger needs an IOW_TO_LINK branch for hmac
state=2E

Change-Id: I2df0fec7861=
84b9fcf9b7c56c74816325cdb6942
Signed-off-by: Antonio Quartulli <antonio@man=
delbit=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702
Message-Id: <20260609075413=
=2E17380-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg37117=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/mudp=2Ec
M src/openvpn/=
multi=2Eh
2 files changed, 21 insertions(+), 25 deletions(-)




diff --git=
 a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 432c79a=2E=2Edded1ee 1=
00644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -40,7 +40,7 =
@@
 static void
 send_hmac_reset_packet(struct multi_context *m, struct tls=
_pre_decrypt_state *state,
                        struct tls_auth_standalo=
ne *tas, struct session_id *sid,
-                       bool request_resen=
d_wkc)
+                       bool request_resend_wkc, struct link_socket =
*sock)
 {
     reset_packet_id_send(&state->tls_wrap_tmp=2Eopt=2Epacket_id=
=2Esend);
     state->tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =
=3D true;
@@ -54,16 +54,30 @@
     ASSERT(buf_init(&c->c2=2Ebuffers->aux_bu=
f, buf=2Eoffset));
 
     buf_copy(&c->c2=2Ebuffers->aux_buf, &buf);
-    m=
->hmac_reply =3D c->c2=2Ebuffers->aux_buf;
-    m->hmac_reply_dest =3D &m->=
top=2Ec2=2Efrom;
+
+    /*
+     * We do not want to keep any state here, s=
o we send the reply to the
+     * initial packet synchronously without que=
ueing anything=2E
+     *
+     * If we hit EAGAIN on a busy socket, the pa=
cket will be lost and the
+     * client will have to retransmit its HARD_R=
ESET=2E This is considered an
+     * acceptable compromise to avoid consum=
ing server resources under attack=2E
+     */
+    msg_set_prefix("Connecti=
on Attempt");
+    c->c2=2Eto_link =3D c->c2=2Ebuffers->aux_buf;
+    c->c2=
=2Eto_link_addr =3D &c->c2=2Efrom;
     msg(D_MULTI_DEBUG, "Reset packet fr=
om client, sending HMAC based reset challenge");
+    process_outgoing_link=
(c, sock);
+    c->c2=2Eto_link=2Elen =3D 0;
+    c->c2=2Eto_link_addr =3D =
NULL;
+    msg_set_prefix(NULL);
 }
 
 
 /* Returns true if this packet sho=
uld create a new session */
 static bool
 do_pre_decrypt_check(struct multi=
_context *m, struct tls_pre_decrypt_state *state,
-                     str=
uct mroute_addr addr)
+                     struct mroute_addr addr, struct=
 link_socket *sock)
 {
     ASSERT(m->top=2Ec2=2Etls_auth_standalone);
 
@@=
 -106,7 +120,7 @@
             /* Calculate the session ID HMAC for our rep=
ly and create reset packet */
             struct session_id sid =3D
      =
           calculate_session_id_hmac(state->peer_session_id, from, hmac, ha=
ndwindow, 0);
-            send_hmac_reset_packet(m, state, tas, &sid, true=
);
+            send_hmac_reset_packet(m, state, tas, &sid, true, sock);
 
=
             return false;
         }
@@ -139,7 +153,7 @@
         struct s=
ession_id sid =3D
             calculate_session_id_hmac(state->peer_sessio=
n_id, from, hmac, handwindow, 0);
 
-        send_hmac_reset_packet(m, stat=
e, tas, &sid, false);
+        send_hmac_reset_packet(m, state, tas, &sid, =
false, sock);
 
         /* We have a reply do not create a new session */
=
         return false;
@@ -194,7 +208,6 @@
     struct multi_instance *mi =
=3D NULL;
     struct hash *hash =3D m->hash;
     real=2Eproto =3D sock->i=
nfo=2Eproto;
-    m->hmac_reply_ls =3D sock;
 
     if (mroute_extract_open=
vpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=
=2Elen > 0)
     {
@@ -253,7 +266,7 @@
                     "shutting down"=
,
                     mroute_addr_print(&real, &gc));
             }
-    =
        else if (do_pre_decrypt_check(m, &state, real))
+            else i=
f (do_pre_decrypt_check(m, &state, real, sock))
             {
            =
     /* This is an unknown session but with valid tls-auth/tls-crypt
      =
            * (or no auth at all)=2E  If this is the initial packet of a
@@=
 -321,15 +334,6 @@
     {
         multi_process_outgoing_link_dowork(m, mi=
, mpp_flags);
     }
-    if (m->hmac_reply_dest && m->hmac_reply=2Elen > 0=
)
-    {
-        msg_set_prefix("Connection Attempt");
-        m->top=2Ec=
2=2Eto_link =3D m->hmac_reply;
-        m->top=2Ec2=2Eto_link_addr =3D m->h=
mac_reply_dest;
-        process_outgoing_link(&m->top, m->hmac_reply_ls);
=
-        m->hmac_reply_ls =3D NULL;
-        m->hmac_reply_dest =3D NULL;
-=
    }
 }
 
 /*
@@ -382,10 +386,6 @@
     {
         flags |=3D IOW_MBUF;
  =
   }
-    else if (m->hmac_reply_dest)
-    {
-        flags |=3D IOW_TO_LI=
NK;
-    }
     else
     {
         flags |=3D IOW_READ;
diff --git a/src/=
openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 3ed08d4=2E=2E8b837fa 100644=

--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -201,10 +201,6 =
@@
     struct context top; /**< Storage structure for process-wide
       =
                   *   configuration=2E */
 
-    struct buffer hmac_reply;=

-    struct link_socket_actual *hmac_reply_dest;
-    struct link_socket *=
hmac_reply_ls;
-
     /*
      * Timer object for stale route check
      *=
/

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2df0fec786184b9fcf9=
b7c56c74816325cdb6942
Gerrit-Change-Number: 1702
Gerrit-PatchSet: 3
Gerrit-=
Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@g=
reenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-C=
C: ordex <antonio@mandelbit=2Ecom>

--1DchmUjVD30=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1702?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">mudp: send HMAC reset reply synchronously<=
br><br>Building a HARD_RESET reply was queueing the result into three<br>mu=
lti_context fields and deferring the send to the next event-loop<br>iterati=
on, where multi_process_outgoing_link() flushed it:<br><br>  struct buffer =
hmac_reply;<br>  struct link_socket_actual *hmac_reply_dest;  /* aliased &a=
mp;m-&gt;top=2Ec2=2Efrom */<br>  struct link_socket *hmac_reply_ls;<br><br>=
The mechanism had three latent issues:<br><br>1=2E hmac_reply_dest =3D &amp=
;m-&gt;top=2Ec2=2Efrom stored a pointer alias into<br>   shared mutable sta=
te=2E  Any subsequent read into m-&gt;top=2Ec2=2Efrom<br>   silently retarg=
eted the pending reply to a different peer=2E<br>2=2E m-&gt;hmac_reply_ls =
=3D sock; at the top of multi_get_create_instance_udp()<br>   was executed =
unconditionally for every UDP packet, including packets<br>   that did not =
queue a reply=2E  A stale queued reply could thus be sent<br>   on the wron=
g listening socket=2E<br>3=2E hmac_reply=2Edata pointed into m-&gt;top=2Ec2=
=2Ebuffers-&gt;aux_buf (the only<br>   slot)=2E  A second send_hmac_reset_p=
acket() before the first flush<br>   would overwrite the first reply&#39;s =
bytes=2E<br><br>These were latent on master because m-&gt;multi_io-&gt;udp_=
flags was consumed<br>and zeroed by the first event in each multi_io_proces=
s_io() loop, so at<br>most one UDP read ran per outer iteration=2E<br><br>S=
end the reply synchronously from within send_hmac_reset_packet() using<br>t=
he sock that the read fired on (threaded through do_pre_decrypt_check)=2E<b=
r>The reply is small, stateless, and rate-limited by the existing<br>reflec=
t_filter_rate_limit_check(); dropping on EAGAIN is acceptable<br>because th=
e client retransmits its HARD_RESET=2E  The three multi_context<br>fields a=
nd the deferred-flush block in multi_process_outgoing_link() are<br>gone; p=
2mp_iow_flags() no longer needs an IOW_TO_LINK branch for hmac<br>state=2E<=
br><br>Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942<br>Signed-off-b=
y: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Acked-by: Gert Doer=
ing &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1702<br>Message-Id: &lt;20260609075413=2E17380-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg37117=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>M src/op=
envpn/multi=2Eh<br>2 files changed, 21 insertions(+), 25 deletions(-)<br><b=
r></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span>=
<br><span>index 432c79a=2E=2Edded1ee 100644</span><br><span>--- a/src/openv=
pn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -=
40,7 +40,7 @@</span><br><span> static void</span><br><span> send_hmac_reset=
_packet(struct multi_context *m, struct tls_pre_decrypt_state *state,</span=
><br><span>                        struct tls_auth_standalone *tas, struct =
session_id *sid,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                  bool request_resend_wkc)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                       bool request_resend_wkc, stru=
ct link_socket *sock)</span><br><span> {</span><br><span>     reset_packet_=
id_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);</span><br><s=
pan>     state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =3D t=
rue;</span><br><span>@@ -54,16 +54,30 @@</span><br><span>     ASSERT(buf_in=
it(&amp;c-&gt;c2=2Ebuffers-&gt;aux_buf, buf=2Eoffset));</span><br><span> </=
span><br><span>     buf_copy(&amp;c-&gt;c2=2Ebuffers-&gt;aux_buf, &amp;buf)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;hmac_reply=
 =3D c-&gt;c2=2Ebuffers-&gt;aux_buf;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    m-&gt;hmac_reply_dest =3D &amp;m-&gt;top=2Ec2=2Efrom;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * We do not want to keep any state here, so we se=
nd the reply to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * initial packet synchronously without queueing anything=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * If we hit EAGAIN on a busy socket,=
 the packet will be lost and the</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * client will have to retransmit its HARD_RESET=2E This i=
s considered an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * acceptable compromise to avoid consuming server resources under attack=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    msg_set_prefix(&quot;Con=
nection Attempt&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    c-&gt;c2=2Eto_link =3D c-&gt;c2=2Ebuffers-&gt;aux_buf;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eto_link_addr =3D =
&amp;c-&gt;c2=2Efrom;</span><br><span>     msg(D_MULTI_DEBUG, &quot;Reset p=
acket from client, sending HMAC based reset challenge&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    process_outgoing_link(c, sock=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eto=
_link=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   c-&gt;c2=2Eto_link_addr =3D NULL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    msg_set_prefix(NULL);</span><br><span> }</span><br><sp=
an> </span><br><span> </span><br><span> /* Returns true if this packet shou=
ld create a new session */</span><br><span> static bool</span><br><span> do=
_pre_decrypt_check(struct multi_context *m, struct tls_pre_decrypt_state *s=
tate,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
     struct mroute_addr addr)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                     struct mroute_addr addr, struct link_socket =
*sock)</span><br><span> {</span><br><span>     ASSERT(m-&gt;top=2Ec2=2Etls_=
auth_standalone);</span><br><span> </span><br><span>@@ -106,7 +120,7 @@</sp=
an><br><span>             /* Calculate the session ID HMAC for our reply an=
d create reset packet */</span><br><span>             struct session_id sid=
 =3D</span><br><span>                 calculate_session_id_hmac(state-&gt;p=
eer_session_id, from, hmac, handwindow, 0);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            send_hmac_reset_packet(m, state, tas, &am=
p;sid, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      send_hmac_reset_packet(m, state, tas, &amp;sid, true, sock);</span><b=
r><span> </span><br><span>             return false;</span><br><span>      =
   }</span><br><span>@@ -139,7 +153,7 @@</span><br><span>         struct se=
ssion_id sid =3D</span><br><span>             calculate_session_id_hmac(sta=
te-&gt;peer_session_id, from, hmac, handwindow, 0);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        send_hmac_reset_pac=
ket(m, state, tas, &amp;sid, false);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        send_hmac_reset_packet(m, state, tas, &amp;sid, fa=
lse, sock);</span><br><span> </span><br><span>         /* We have a reply d=
o not create a new session */</span><br><span>         return false;</span>=
<br><span>@@ -194,7 +208,6 @@</span><br><span>     struct multi_instance *m=
i =3D NULL;</span><br><span>     struct hash *hash =3D m-&gt;hash;</span><b=
r><span>     real=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    m-&gt;hmac_reply_ls =3D sock;</span><br=
><span> </span><br><span>     if (mroute_extract_openvpn_sockaddr(&amp;real=
, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=
=2Elen &gt; 0)</span><br><span>     {</span><br><span>@@ -253,7 +266,7 @@</=
span><br><span>                     &quot;shutting down&quot;,</span><br><s=
pan>                     mroute_addr_print(&amp;real, &amp;gc));</span><br>=
<span>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           else if (do_pre_decrypt_check(m, &amp;state, real))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            else if (do_pre_decr=
ypt_check(m, &amp;state, real, sock))</span><br><span>             {</span>=
<br><span>                 /* This is an unknown session but with valid tls=
-auth/tls-crypt</span><br><span>                  * (or no auth at all)=2E =
 If this is the initial packet of a</span><br><span>@@ -321,15 +334,6 @@</s=
pan><br><span>     {</span><br><span>         multi_process_outgoing_link_d=
owork(m, mi, mpp_flags);</span><br><span>     }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (m-&gt;hmac_reply_dest &amp;&amp; m-&gt;hm=
ac_reply=2Elen &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg_set=
_prefix(&quot;Connection Attempt&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        m-&gt;top=2Ec2=2Eto_link =3D m-&gt;hmac_reply;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m-&gt;top=2Ec2=
=2Eto_link_addr =3D m-&gt;hmac_reply_dest;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        process_outgoing_link(&amp;m-&gt;top, m-&gt;hm=
ac_reply_ls);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
m-&gt;hmac_reply_ls =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        m-&gt;hmac_reply_dest =3D NULL;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span> }</span><br><span> </span>=
<br><span> /*</span><br><span>@@ -382,10 +386,6 @@</span><br><span>     {</=
span><br><span>         flags |=3D IOW_MBUF;</span><br><span>     }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (m-&gt;hmac_reply=
_dest)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        flags |=3D IOW_TO_LINK;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
>     else</span><br><span>     {</span><br><span>         flags |=3D IOW_R=
EAD;</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=
=2Eh</span><br><span>index 3ed08d4=2E=2E8b837fa 100644</span><br><span>--- =
a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><=
br><span>@@ -201,10 +201,6 @@</span><br><span>     struct context top; /**&=
lt; Storage structure for process-wide</span><br><span>                    =
      *   configuration=2E */</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct buffer hmac_reply;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    struct link_socket_actual *hmac_reply=
_dest;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link=
_socket *hmac_reply_ls;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span>     /*</span><br><span>      * Timer object for stale r=
oute check</span><br><span>      */</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=
=3Demail">change 1702</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1702?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1702 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></htm=
l>
--1DchmUjVD30=--


--===============5124176018136282770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5124176018136282770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5124176018136282770==--

