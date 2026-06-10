Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F303CD8CB2
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IAqaF3s5j7nTCQzHeWcDbgqexf7dKHTAJqaZBqtizvc=; b=diFABBL5K2DAf4sYlAJTguUpho
	uefIxH67wQZL5SWkwUL4bskA2EjbX0ItRsUDlG4tsI3AqnRPWg+bJv4F0Hf9twq2OawQAoF9xnErQ
	j3JsE8YkWhHh8fDyPuW95C8IpgYzXEqF+ZMtHYxuxc4ttkRI1lMLVHFmvF+zNlgglxI0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXM6x-00032n-7Q;
	Wed, 10 Jun 2026 16:49:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXM6u-00032f-Ma
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 16:49:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wf2cz4ZK7XfIkRYQWx7fe62mbWPdY/vhKBwMWCxH4Oc=; b=Unk7m4OQ+iq1y6HO9dbq5Ut+TV
 kI87NgKodo/6ypA9FzxRiuhisvvNEJrEMsISyCnznYRWHEg12V9He8X/XkWF5+cNhGnvO4tLOlh03
 6Gs53eCUFF/GHVMTa7z1LBqZ9iPIwXdB6mmTXa7YyKCoxpsanTvN3SOpVnCTLQ+srETU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wf2cz4ZK7XfIkRYQWx7fe62mbWPdY/vhKBwMWCxH4Oc=; b=R
 swX9WNIZsjoAM1UrbF7QQddDLKDXADj78nGkp4u+4r0bOMyKVg6oATvb3q6S63Dv13J5oYw3t6KNz
 wrkJOwbGisXHDj1b/x62PpUvDQPDNm3zNhJolAK5+K7DpeQHGv+KDz+4LrPcmX9qtkKiH0KKJbfq5
 7YE857m0wZOWeKV0=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXM6t-0004L9-1K for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 16:49:01 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso80651725e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781110128; x=1781714928; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wf2cz4ZK7XfIkRYQWx7fe62mbWPdY/vhKBwMWCxH4Oc=;
 b=BwkdM8MJfkMK8RZ2UglHGBH8KX8M5xOCaSEGP5/BCPiMpa7/Y+UhlaIThh4LUOvd80
 0f5wD34KrbtxzGYk7rcnxfTmPGT5O2PHsfKg1QDbpUMz2VIwOKS/xehECF9gAAku3uiT
 IziOF8pxyIcQUZdF+TgououEA1vcI+Nz2UYclBrEKzh0umJ07KND/OrF002yZNNQfuok
 oUiV36sfqngQEAgMzVK+RA7K74QZ/9kbjmvRqjgPyXMy7LrpRwHkjluSxgTEStzJrttG
 i/yP9Uolog/+3D6i/O9O87ZP7Wk/MpVxShpENQfX3zkbUfPIYg/SoJgeO5CJLH7Kos2p
 76Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781110128; x=1781714928;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wf2cz4ZK7XfIkRYQWx7fe62mbWPdY/vhKBwMWCxH4Oc=;
 b=YCvFIF8301SdUBGRRHOvmD7yWHeSdv7xjT7/Zn0GKK6aMui5D8kA3V6X5eeiqrlQpH
 tXhJ/1S4urjO4Ho6AxUH8RA47d5cBH7mQn5jtRZlR0veLVIxFZo/042nZr+8KgNhIyck
 m28ZYLBIb1M1xOe15l4HXVNydsciOzr28qmgzgi6UFmFRbaiR9DKIKpuRFa0hnV2jq8X
 djjOPiS7ag/oH1CX/DPQL6ajym7q2z8b6BXriTnyWYrnvjnmWb7m2C1tJG8PF+Iqwwqa
 oweIfHWRyPUtGmmdhZUHQzGzuyllbUPdzaAnjh+HcyKZTgnH8vK0CPScB4oKyOHxzDc1
 CSLA==
X-Gm-Message-State: AOJu0YwUPtV52dN/wcB7K5bb/rLB5ToDDodMWOXNnWAUv9vIZfI+m1PH
 9SQy4OgD6EC2N/bz+CqVZpy/yTQVv2IRY5aF0uayPK65ty8kue38z1cXXmnDQ+4iNIAdYGTuEft
 sYSIcsukMVzrthOG1nY5PSyfRjg8ualtRCOyo35xNLvPsAsqRK5X7VT4jagjigbXPvjJulPTECj
 zfDvdd2w==
X-Gm-Gg: Acq92OGnQMQ6fpU0WI5VZuPJRp0plLeoWDNTWvGwLykNvX6E92/AAQY/sh29oaRFG8c
 d4corzcJCgsVKi9KtkPKCPh9uL8MpWYJrkFBro+/exBiXRvB8jAD8tGVB2o/z2MTfCWliV2gSVt
 lowvqMUp1bRbXun7W/aip1YNRFQo+Kru7vQ70XiZCndlEB+BwDMOpustbM83997zCAieYnx1+7D
 aWSbaWrNXBD2xxaNga4MPqd7g3MCOXPEBPKXa7QV8o1ySEcWVae/Ko4DsBXuZVVf4haL3uU/GQZ
 +CsxJdwoSrkAM/qFFZEzPa82MghGb/UQGjN62u5TnFrlbrhly/7uuBowFB8bYKqsxoxI6sNHfb+
 l4d23kBNbie6ssAXmNdLOBqbJbuXqhj9P5YcWZPQ5TREE89oPRCxF2wkGA6CDp4XmMd6CTs5QgB
 muTizkTbtXz5sMsT6C22ZqaUq9OTUmtXqknKgWTvwj7ExJuhRrHCXC76nyJ79LyN+b1oHNpa3lC
 Zea8Qd3jnErSKw3k3sEWA6TPr4eIR8vusxS6FDwaC7iyT6AVGDuUtOgrEv0MKWg+SJMhcAxV3O9
 KiPKL1oaiPi+HV1QJj+dNpdgh9xX5oiv5KI=
X-Received: by 2002:a05:600c:1f90:b0:490:b00c:8e6a with SMTP id
 5b1f17b1804b1-490c2602971mr426589375e9.28.1781110127820; 
 Wed, 10 Jun 2026 09:48:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2b23606sm76625e9.11.2026.06.10.09.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:48:47 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 10 Jun 2026 16:48:45 +0000
To: its_Giaan <gianmarco@mandelbit.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942
X-Gerrit-Change-Number: 1702
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1702?usp=email>
X-Gerrit-Commit: 9bad30f6d9884d48db57106ce078bfd7b2a73df9
In-Reply-To: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
References: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5NDU1ODgwMDAwLkkyZGYwZmVjNzg2MTg0YjlmY2Y5YjdjNTZjNzQ4MTYzMjVjZGI2OTQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0bb1c694ee1756f12d447cbda2a18e17528e796d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXM6t-0004L9-1K
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8891352764351224145=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8891352764351224145==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dKCPNuaaDks="; charset=UTF-8

--dKCPNuaaDks=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 its_Giaan=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
cron2, Code-Review+2 by ordex


Change subject: mudp: send HMAC reset reply=
 synchronously
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


mudp: send HMAC reset reply synchronously

Building a HARD_RESET reply wa=
s queueing the result into three
multi_context fields and deferring the sen=
d to the next event-loop
iteration, where multi_process_outgoing_link() flu=
shed it:

  struct buffer hmac_reply;
  struct link_socket_actual *hmac_rep=
ly_dest;  /* aliased &m->top=2Ec2=2Efrom */
  struct link_socket *hmac_repl=
y_ls;

The mechanism had three latent issues:

1=2E hmac_reply_dest =3D &m-=
>top=2Ec2=2Efrom stored a pointer alias into
   shared mutable state=2E  An=
y subsequent read into m->top=2Ec2=2Efrom
   silently retargeted the pendin=
g reply to a different peer=2E
2=2E m->hmac_reply_ls =3D sock; at the top o=
f multi_get_create_instance_udp()
   was executed unconditionally for every=
 UDP packet, including packets
   that did not queue a reply=2E  A stale qu=
eued reply could thus be sent
   on the wrong listening socket=2E
3=2E hmac=
_reply=2Edata pointed into m->top=2Ec2=2Ebuffers->aux_buf (the only
   slot=
)=2E  A second send_hmac_reset_packet() before the first flush
   would ove=
rwrite the first reply's bytes=2E

These were latent on master because m->m=
ulti_io->udp_flags was consumed
and zeroed by the first event in each multi=
_io_process_io() loop, so at
most one UDP read ran per outer iteration=2E

=
Send the reply synchronously from within send_hmac_reset_packet() using
the=
 sock that the read fired on (threaded through do_pre_decrypt_check)=2E
The=
 reply is small, stateless, and rate-limited by the existing
reflect_filter=
_rate_limit_check(); dropping on EAGAIN is acceptable
because the client re=
transmits its HARD_RESET=2E  The three multi_context
fields and the deferre=
d-flush block in multi_process_outgoing_link() are
gone; p2mp_iow_flags() n=
o longer needs an IOW_TO_LINK branch for hmac
state=2E

Change-Id: I2df0fec=
786184b9fcf9b7c56c74816325cdb6942
Signed-off-by: Antonio Quartulli <antonio=
@mandelbit=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702
Message-Id: <2026060907=
5413=2E17380-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ec=
om/openvpn-devel@lists=2Esourceforge=2Enet/msg37117=2Ehtml
Signed-off-by: G=
ert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/mudp=2Ec
M src/open=
vpn/multi=2Eh
2 files changed, 21 insertions(+), 25 deletions(-)


  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/02/1702/3

diff =
--git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 432c79a=2E=2Edded=
1ee 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -40,7 +=
40,7 @@
 static void
 send_hmac_reset_packet(struct multi_context *m, struc=
t tls_pre_decrypt_state *state,
                        struct tls_auth_sta=
ndalone *tas, struct session_id *sid,
-                       bool request_=
resend_wkc)
+                       bool request_resend_wkc, struct link_so=
cket *sock)
 {
     reset_packet_id_send(&state->tls_wrap_tmp=2Eopt=2Epacke=
t_id=2Esend);
     state->tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialize=
d =3D true;
@@ -54,16 +54,30 @@
     ASSERT(buf_init(&c->c2=2Ebuffers->aux_=
buf, buf=2Eoffset));
 
     buf_copy(&c->c2=2Ebuffers->aux_buf, &buf);
-   =
 m->hmac_reply =3D c->c2=2Ebuffers->aux_buf;
-    m->hmac_reply_dest =3D &m=
->top=2Ec2=2Efrom;
+
+    /*
+     * We do not want to keep any state here,=
 so we send the reply to the
+     * initial packet synchronously without q=
ueueing anything=2E
+     *
+     * If we hit EAGAIN on a busy socket, the =
packet will be lost and the
+     * client will have to retransmit its HARD=
_RESET=2E This is considered an
+     * acceptable compromise to avoid cons=
uming server resources under attack=2E
+     */
+    msg_set_prefix("Connec=
tion Attempt");
+    c->c2=2Eto_link =3D c->c2=2Ebuffers->aux_buf;
+    c->=
c2=2Eto_link_addr =3D &c->c2=2Efrom;
     msg(D_MULTI_DEBUG, "Reset packet =
from client, sending HMAC based reset challenge");
+    process_outgoing_li=
nk(c, sock);
+    c->c2=2Eto_link=2Elen =3D 0;
+    c->c2=2Eto_link_addr =
=3D NULL;
+    msg_set_prefix(NULL);
 }
 
 
 /* Returns true if this packet=
 should create a new session */
 static bool
 do_pre_decrypt_check(struct m=
ulti_context *m, struct tls_pre_decrypt_state *state,
-                    =
 struct mroute_addr addr)
+                     struct mroute_addr addr, st=
ruct link_socket *sock)
 {
     ASSERT(m->top=2Ec2=2Etls_auth_standalone);
=
 
@@ -106,7 +120,7 @@
             /* Calculate the session ID HMAC for our=
 reply and create reset packet */
             struct session_id sid =3D
  =
               calculate_session_id_hmac(state->peer_session_id, from, hmac=
, handwindow, 0);
-            send_hmac_reset_packet(m, state, tas, &sid, =
true);
+            send_hmac_reset_packet(m, state, tas, &sid, true, sock)=
;
 
             return false;
         }
@@ -139,7 +153,7 @@
         stru=
ct session_id sid =3D
             calculate_session_id_hmac(state->peer_se=
ssion_id, from, hmac, handwindow, 0);
 
-        send_hmac_reset_packet(m, =
state, tas, &sid, false);
+        send_hmac_reset_packet(m, state, tas, &s=
id, false, sock);
 
         /* We have a reply do not create a new session=
 */
         return false;
@@ -194,7 +208,6 @@
     struct multi_instance *=
mi =3D NULL;
     struct hash *hash =3D m->hash;
     real=2Eproto =3D sock=
->info=2Eproto;
-    m->hmac_reply_ls =3D sock;
 
     if (mroute_extract_o=
penvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Eb=
uf=2Elen > 0)
     {
@@ -253,7 +266,7 @@
                     "shutting dow=
n",
                     mroute_addr_print(&real, &gc));
             }
-  =
          else if (do_pre_decrypt_check(m, &state, real))
+            else=
 if (do_pre_decrypt_check(m, &state, real, sock))
             {
          =
       /* This is an unknown session but with valid tls-auth/tls-crypt
    =
              * (or no auth at all)=2E  If this is the initial packet of a
=
@@ -321,15 +334,6 @@
     {
         multi_process_outgoing_link_dowork(m, =
mi, mpp_flags);
     }
-    if (m->hmac_reply_dest && m->hmac_reply=2Elen >=
 0)
-    {
-        msg_set_prefix("Connection Attempt");
-        m->top=
=2Ec2=2Eto_link =3D m->hmac_reply;
-        m->top=2Ec2=2Eto_link_addr =3D =
m->hmac_reply_dest;
-        process_outgoing_link(&m->top, m->hmac_reply_l=
s);
-        m->hmac_reply_ls =3D NULL;
-        m->hmac_reply_dest =3D NUL=
L;
-    }
 }
 
 /*
@@ -382,10 +386,6 @@
     {
         flags |=3D IOW_MBUF=
;
     }
-    else if (m->hmac_reply_dest)
-    {
-        flags |=3D IOW_T=
O_LINK;
-    }
     else
     {
         flags |=3D IOW_READ;
diff --git a/=
src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 3ed08d4=2E=2E8b837fa 10=
0644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -201,10 +20=
1,6 @@
     struct context top; /**< Storage structure for process-wide
   =
                       *   configuration=2E */
 
-    struct buffer hmac_re=
ply;
-    struct link_socket_actual *hmac_reply_dest;
-    struct link_sock=
et *hmac_reply_ls;
-
     /*
      * Timer object for stale route check
   =
   */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2df0fec786=
184b9fcf9b7c56c74816325cdb6942
Gerrit-Change-Number: 1702
Gerrit-PatchSet: =
3
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: cron=
2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-CC: ordex <antonio@mandelbit=2Ecom>

--dKCPNuaaDks=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by its_Giaan=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by cron2, Code-Review+2 by ordex</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">mud=
p: send HMAC reset reply synchronously<br><br>Building a HARD_RESET reply w=
as queueing the result into three<br>multi_context fields and deferring the=
 send to the next event-loop<br>iteration, where multi_process_outgoing_lin=
k() flushed it:<br><br>  struct buffer hmac_reply;<br>  struct link_socket_=
actual *hmac_reply_dest;  /* aliased &amp;m-&gt;top=2Ec2=2Efrom */<br>  str=
uct link_socket *hmac_reply_ls;<br><br>The mechanism had three latent issue=
s:<br><br>1=2E hmac_reply_dest =3D &amp;m-&gt;top=2Ec2=2Efrom stored a poin=
ter alias into<br>   shared mutable state=2E  Any subsequent read into m-&g=
t;top=2Ec2=2Efrom<br>   silently retargeted the pending reply to a differen=
t peer=2E<br>2=2E m-&gt;hmac_reply_ls =3D sock; at the top of multi_get_cre=
ate_instance_udp()<br>   was executed unconditionally for every UDP packet,=
 including packets<br>   that did not queue a reply=2E  A stale queued repl=
y could thus be sent<br>   on the wrong listening socket=2E<br>3=2E hmac_re=
ply=2Edata pointed into m-&gt;top=2Ec2=2Ebuffers-&gt;aux_buf (the only<br> =
  slot)=2E  A second send_hmac_reset_packet() before the first flush<br>   =
would overwrite the first reply&#39;s bytes=2E<br><br>These were latent on =
master because m-&gt;multi_io-&gt;udp_flags was consumed<br>and zeroed by t=
he first event in each multi_io_process_io() loop, so at<br>most one UDP re=
ad ran per outer iteration=2E<br><br>Send the reply synchronously from with=
in send_hmac_reset_packet() using<br>the sock that the read fired on (threa=
ded through do_pre_decrypt_check)=2E<br>The reply is small, stateless, and =
rate-limited by the existing<br>reflect_filter_rate_limit_check(); dropping=
 on EAGAIN is acceptable<br>because the client retransmits its HARD_RESET=
=2E  The three multi_context<br>fields and the deferred-flush block in mult=
i_process_outgoing_link() are<br>gone; p2mp_iow_flags() no longer needs an =
IOW_TO_LINK branch for hmac<br>state=2E<br><br>Change-Id: I2df0fec786184b9f=
cf9b7c56c74816325cdb6942<br>Signed-off-by: Antonio Quartulli &lt;antonio@ma=
ndelbit=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;=
<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702<br>Message-=
Id: &lt;20260609075413=2E17380-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37117=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Eh<br>2 files changed,=
 21 insertions(+), 25 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/02/1702/3</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 4=
32c79a=2E=2Edded1ee 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span=
><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -40,7 +40,7 @@</sp=
an><br><span> static void</span><br><span> send_hmac_reset_packet(struct mu=
lti_context *m, struct tls_pre_decrypt_state *state,</span><br><span>      =
                  struct tls_auth_standalone *tas, struct session_id *sid,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
 bool request_resend_wkc)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                       bool request_resend_wkc, struct link_socket *s=
ock)</span><br><span> {</span><br><span>     reset_packet_id_send(&amp;stat=
e-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);</span><br><span>     state-&g=
t;tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =3D true;</span><br><s=
pan>@@ -54,16 +54,30 @@</span><br><span>     ASSERT(buf_init(&amp;c-&gt;c2=
=2Ebuffers-&gt;aux_buf, buf=2Eoffset));</span><br><span> </span><br><span> =
    buf_copy(&amp;c-&gt;c2=2Ebuffers-&gt;aux_buf, &amp;buf);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;hmac_reply =3D c-&gt;c2=2E=
buffers-&gt;aux_buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   m-&gt;hmac_reply_dest =3D &amp;m-&gt;top=2Ec2=2Efrom;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * We do not want to keep any state here, so we send the reply to =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * initial p=
acket synchronously without queueing anything=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * If we hit EAGAIN on a busy socket, the packet will b=
e lost and the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* client will have to retransmit its HARD_RESET=2E This is considered an</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * acceptable comp=
romise to avoid consuming server resources under attack=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    msg_set_prefix(&quot;Connection Attempt&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Et=
o_link =3D c-&gt;c2=2Ebuffers-&gt;aux_buf;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    c-&gt;c2=2Eto_link_addr =3D &amp;c-&gt;c2=2Efrom=
;</span><br><span>     msg(D_MULTI_DEBUG, &quot;Reset packet from client, s=
ending HMAC based reset challenge&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    process_outgoing_link(c, sock);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eto_link=2Elen =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eto_lin=
k_addr =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 msg_set_prefix(NULL);</span><br><span> }</span><br><span> </span><br><span=
> </span><br><span> /* Returns true if this packet should create a new sess=
ion */</span><br><span> static bool</span><br><span> do_pre_decrypt_check(s=
truct multi_context *m, struct tls_pre_decrypt_state *state,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                     struct mroute_a=
ddr addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
           struct mroute_addr addr, struct link_socket *sock)</span><br><sp=
an> {</span><br><span>     ASSERT(m-&gt;top=2Ec2=2Etls_auth_standalone);</s=
pan><br><span> </span><br><span>@@ -106,7 +120,7 @@</span><br><span>       =
      /* Calculate the session ID HMAC for our reply and create reset packe=
t */</span><br><span>             struct session_id sid =3D</span><br><span=
>                 calculate_session_id_hmac(state-&gt;peer_session_id, from=
, hmac, handwindow, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            send_hmac_reset_packet(m, state, tas, &amp;sid, true);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            send_hmac_rese=
t_packet(m, state, tas, &amp;sid, true, sock);</span><br><span> </span><br>=
<span>             return false;</span><br><span>         }</span><br><span=
>@@ -139,7 +153,7 @@</span><br><span>         struct session_id sid =3D</sp=
an><br><span>             calculate_session_id_hmac(state-&gt;peer_session_=
id, from, hmac, handwindow, 0);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        send_hmac_reset_packet(m, state, tas, &=
amp;sid, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     send_hmac_reset_packet(m, state, tas, &amp;sid, false, sock);</span><b=
r><span> </span><br><span>         /* We have a reply do not create a new s=
ession */</span><br><span>         return false;</span><br><span>@@ -194,7 =
+208,6 @@</span><br><span>     struct multi_instance *mi =3D NULL;</span><b=
r><span>     struct hash *hash =3D m-&gt;hash;</span><br><span>     real=2E=
proto =3D sock-&gt;info=2Eproto;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    m-&gt;hmac_reply_ls =3D sock;</span><br><span> </span><br><s=
pan>     if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=
=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span><=
br><span>     {</span><br><span>@@ -253,7 +266,7 @@</span><br><span>       =
              &quot;shutting down&quot;,</span><br><span>                  =
   mroute_addr_print(&amp;real, &amp;gc));</span><br><span>             }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            else if (do=
_pre_decrypt_check(m, &amp;state, real))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            else if (do_pre_decrypt_check(m, &amp;stat=
e, real, sock))</span><br><span>             {</span><br><span>            =
     /* This is an unknown session but with valid tls-auth/tls-crypt</span>=
<br><span>                  * (or no auth at all)=2E  If this is the initia=
l packet of a</span><br><span>@@ -321,15 +334,6 @@</span><br><span>     {</=
span><br><span>         multi_process_outgoing_link_dowork(m, mi, mpp_flags=
);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (m-&gt;hmac_reply_dest &amp;&amp; m-&gt;hmac_reply=2Elen &gt; 0)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        msg_set_prefix(&quot;Connecti=
on Attempt&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     m-&gt;top=2Ec2=2Eto_link =3D m-&gt;hmac_reply;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        m-&gt;top=2Ec2=2Eto_link_addr =3D m=
-&gt;hmac_reply_dest;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        process_outgoing_link(&amp;m-&gt;top, m-&gt;hmac_reply_ls);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        m-&gt;hmac_reply_ls =
=3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m-&g=
t;hmac_reply_dest =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span> }</span><br><span> </span><br><span> /*</span>=
<br><span>@@ -382,10 +386,6 @@</span><br><span>     {</span><br><span>     =
    flags |=3D IOW_MBUF;</span><br><span>     }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    else if (m-&gt;hmac_reply_dest)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        flags |=3D IOW_TO_LINK;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>     else</span><br=
><span>     {</span><br><span>         flags |=3D IOW_READ;</span><br><span=
>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span=
>index 3ed08d4=2E=2E8b837fa 100644</span><br><span>--- a/src/openvpn/multi=
=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><br><span>@@ -201,10=
 +201,6 @@</span><br><span>     struct context top; /**&lt; Storage structu=
re for process-wide</span><br><span>                          *   configura=
tion=2E */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct buffer hmac_reply;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct link_socket_actual *hmac_reply_dest;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct link_socket *hmac_reply=
_ls;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
     /*</span><br><span>      * Timer object for stale route check</span><b=
r><span>      */</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail">change 1702=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
2df0fec786184b9fcf9b7c56c74816325cdb6942 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1702 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gi=
anmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: or=
dex &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--dKCPNuaaDks=--


--===============8891352764351224145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8891352764351224145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8891352764351224145==--

