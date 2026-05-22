Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF45DCD5BB0
	for <openvpn-devel@archiver.kernel.org>; Fri, 22 May 2026 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=BsSoI+tMIdECaWdvIYk1wjLaSzYqsuQd4u+154172MQ=; b=iifYVE1EBVR8JN
	/xyEimWbkjGO2lErytBJ14iwiJ0sTpGIG1ueX/cL5Nx74Kwo5mw5EhXhm4laL39KUxB9wGG3+l+79
	a9XQQmhdKXbVkiWamiICmS+1NGMmzSiB3JeQCo04Z21u8FYpKUdUbbSG0dcUa7oMqjwRjnD8H7UDQ
	9Kw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wQPlx-0005wq-U1;
	Fri, 22 May 2026 13:18:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wQPla-0005wS-TM
 for openvpn-devel@lists.sourceforge.net;
 Fri, 22 May 2026 13:18:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iJA1Eoyv5tBK8w3MjvRU85LoJmsV8ROvazjHH6H7aa4=; b=Vm7AvfhszVfYAl4G+MYDvL46Ft
 oca9utBj3XvVBfLJYxjaJ6HfOlhPQe4jNmyoI4iAyU//A1+7ygbEUeVronOHO8DvWI1Bf8EL94IFC
 aPbOMAsZA40Z6/0J31uM+DNZpLQWE8fkJcwMIcbUKLEHRqRKbTzYlt9RkvOuxm8AnlPg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iJA1Eoyv5tBK8w3MjvRU85LoJmsV8ROvazjHH6H7aa4=; b=J
 vAJGe9PLnEe0xIhl9Sx/Vy1h0nFGb1qCnggvm9BA7xB8ajryPmkEPxb0WZ+HtANiQq+bV6NYqrR+d
 ZwyNkFTmq4gwxIKBpw2RqW9wMUu3/cRNagZ6tgHgJ3Rhl1GDrvv1TnW88jzt1eC64CfysFj4Fn2bG
 vbXBeIcHJJcElexw=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wQPlY-0006va-SG for openvpn-devel@lists.sourceforge.net;
 Fri, 22 May 2026 13:18:19 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so47104185e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 22 May 2026 06:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779455886; x=1780060686; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iJA1Eoyv5tBK8w3MjvRU85LoJmsV8ROvazjHH6H7aa4=;
 b=frysaS7bwiA/UYBpFxukrP4qKVOteUIQLy63i7NX6YVtaJCxVGhUT3m7ufcfTCBpPS
 6Cce5pHCjoy/nnz1u0ydv6E8rR7xdMODoU41fzy0lkSuiR0/wcZWd6uzinNDXImXc/R2
 R1IcsY36gp6PQYMMxde3HxkHQCzOb5X2asONDYTL9NRq/J4Wl5epZjmrGLx+b7NYxGoV
 q+/h6vTKIDLhxa7j/YZRYXv+v3EnCuV4zqRiUTf3EXQiub5oN4gzlT4/4FttEH5U7LTD
 o3Nz3zlyUAKn9gew2LXf/wMb2pl4sxUT2bJwqc4MyENw3vWWwj6P4DzQo3q64w+D04n3
 6zjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779455886; x=1780060686;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iJA1Eoyv5tBK8w3MjvRU85LoJmsV8ROvazjHH6H7aa4=;
 b=eJUeuGPrJvRSvWaMWv9gwlF21bB8P7EfQdpNxtathz9RNN5u2BnHfRjmWWb89WBXqh
 G/lUFfUA50efPBZ/fPZnyvTgvz1IIwdpzXPtPdkXMW/oe8nkkZI5LalFwzg3NbARFiEI
 9A7mO+o16gxMlXUNgtDBQH/l8Qj0Aa3fJw25dWKYoA6fQUeo1vP9KBxAwDsu0lgek4zK
 xessCl+XaxAqhVO4ssxHOS01R95ClglxHhbv8WCX+QAUxkeIN6++2U7Pt6ydurkmjR+y
 Qbu6xVcFeS7ZdxZL6h8AqGu/zT78SsBoCE2o4T/DyaRtFkTN2S4Ae88aDyI6evlDBASg
 Zjdw==
X-Gm-Message-State: AOJu0YwRJnKnmBVGhkrtkDDHrKE8aRg71NHVOVa//oPhMe4Ji7gfOFak
 Oqsnl7py1B+2h52OBpdpuYwbDc4ql8vaqAC3nv/Z7mMJTw/1n3WRu69VSJu+/rshQcdef7PK0VP
 EM3WGSqMt56INbtoj0XAl70yt8qGrEtRISGR3dr0/oF4i8txIV/NqI4ysHwHkrwUSW5j2zjunGx
 FjA1/c9A==
X-Gm-Gg: Acq92OGrKz64f9GiepaGYWUl/Ti6NskZM3o/kdIlVN/boziHOTHTvd5VTJ+Z7PEZb9J
 6BvL7gr8LbRjtYWO73qLPVdJKvGFEODbqhycN0jzOP2MJILmNVxsxTIhDwCH5cKhk6G5ysz12F6
 sPsXkeViHKwO6oWatJmVZG/w7boMpIsDa2JECwX4NlAj/4c9GWkiK+UCZXIuULiUPBoaPbLYwM1
 lZElXFw7qOoz3lIvVnzFi8/rb+JVsGaL0dBhG1DFCtEuVmqaJPdkkvRHkIzNUbhp2tZgbk0cqgS
 ADLf6asb6wCE/d8crh/goe47iWZFr/lSMO49OPbnaQKV2gnYEBwcwEKWLWtAPhpzLXp5qjtPE5G
 CQeB1C+g3DAsuHqYF5ANmC6GLhFVK3L1LG2O2EbrGNaH6BdARsuskWwFZ2YQTcF55GPd2udYo8R
 3WS9CAtNIG2jK2m0Rt97ep8Bby4XoeMcY8g0pZipad7MCBNrm5xBjME1xguxTqRro2K3SgHH5m7
 LZZ6JZURIbRuTKV8njnMWfDaRatupmTlVLS2GG1dp79p4Hy6QO+i0Xs79vBacAG3une2DO6u6Zm
 4iohy6ocU5SLWA6OvxHBlhq4
X-Received: by 2002:a05:600c:c059:20b0:490:31e:d6fd with SMTP id
 5b1f17b1804b1-490426d3319mr38012345e9.25.1779455885568; 
 Fri, 22 May 2026 06:18:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49045284855sm36816195e9.0.2026.05.22.06.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 06:18:05 -0700 (PDT)
From: "its_Giaan (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 22 May 2026 13:18:04 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942
X-Gerrit-Change-Number: 1702
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1702?usp=email>
X-Gerrit-Commit: 813856dba54347167bcd041b67ed831479cf37b7
References: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5NDU1ODgwMDAwLkkyZGYwZmVjNzg2MTg0YjlmY2Y5YjdjNTZjNzQ4MTYzMjVjZGI2OTQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <15c7d9ca9d976389621d03e1d5d3c56bc257cec0-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wQPlY-0006va-SG
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
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5280773015147119935=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5280773015147119935==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="v7ZXKJTd+c0="; charset=UTF-8

--v7ZXKJTd+c0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

Hello plaisthos,=


I'd like you to do a code review=2E
Please visit

    http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1702?usp=3Demail

to review the following change=2E
=


Change subject: mudp: send HMAC reset reply synchronously
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mudp: send HMAC reset reply =
synchronously

Building a HARD_RESET reply was queueing the result into thr=
ee
multi_context fields and deferring the send to the next event-loop
itera=
tion, where multi_process_outgoing_link() flushed it:

  struct buffer hmac=
_reply;
  struct link_socket_actual *hmac_reply_dest;  /* aliased &m->top=
=2Ec2=2Efrom */
  struct link_socket *hmac_reply_ls;

The mechanism had thr=
ee latent issues:

1=2E hmac_reply_dest =3D &m->top=2Ec2=2Efrom stored a po=
inter alias into
   shared mutable state=2E  Any subsequent read into m->to=
p=2Ec2=2Efrom
   silently retargeted the pending reply to a different peer=
=2E
2=2E m->hmac_reply_ls =3D sock; at the top of multi_get_create_instance=
_udp()
   was executed unconditionally for every UDP packet, including pack=
ets
   that did not queue a reply=2E  A stale queued reply could thus be se=
nt
   on the wrong listening socket=2E
3=2E hmac_reply=2Edata pointed into =
m->top=2Ec2=2Ebuffers->aux_buf (the only
   slot)=2E  A second send_hmac_re=
set_packet() before the first flush
   would overwrite the first reply's by=
tes=2E

These were latent on master because m->multi_io->udp_flags was cons=
umed
and zeroed by the first event in each multi_io_process_io() loop, so a=
t
most one UDP read ran per outer iteration=2E

Send the reply synchronousl=
y from within send_hmac_reset_packet() using
the sock that the read fired o=
n (threaded through do_pre_decrypt_check)=2E
The reply is small, stateless,=
 and rate-limited by the existing
reflect_filter_rate_limit_check(); droppi=
ng on EAGAIN is acceptable
because the client retransmits its HARD_RESET=2E=
  The three multi_context
fields and the deferred-flush block in multi_proc=
ess_outgoing_link() are
gone; p2mp_iow_flags() no longer needs an IOW_TO_LI=
NK branch for hmac
state=2E

Change-Id: I2df0fec786184b9fcf9b7c56c74816325c=
db6942
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M src=
/openvpn/mudp=2Ec
M src/openvpn/multi=2Eh
2 files changed, 18 insertions(+)=
, 25 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/02/1702/1

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mud=
p=2Ec
index 432c79a=2E=2E874736e 100644
--- a/src/openvpn/mudp=2Ec
+++ b/sr=
c/openvpn/mudp=2Ec
@@ -40,7 +40,7 @@
 static void
 send_hmac_reset_packet(s=
truct multi_context *m, struct tls_pre_decrypt_state *state,
              =
          struct tls_auth_standalone *tas, struct session_id *sid,
-       =
                bool request_resend_wkc)
+                       bool reque=
st_resend_wkc, struct link_socket *sock)
 {
     reset_packet_id_send(&stat=
e->tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);
     state->tls_wrap_tmp=2Eopt=
=2Epacket_id=2Erec=2Einitialized =3D true;
@@ -54,8 +54,19 @@
     ASSERT(b=
uf_init(&c->c2=2Ebuffers->aux_buf, buf=2Eoffset));
 
     buf_copy(&c->c2=
=2Ebuffers->aux_buf, &buf);
-    m->hmac_reply =3D c->c2=2Ebuffers->aux_buf=
;
-    m->hmac_reply_dest =3D &m->top=2Ec2=2Efrom;
+
+    /* Send synchrono=
usly: queueing across event-loop iterations would alias
+     * m->top=2Ec2=
=2Efrom and aux_buf into cross-socket race territory=2E  The reply
+     * =
is small, stateless, and rate-limited by reflect_filter_rate_limit_check();=

+     * dropping on EAGAIN is acceptable as the client retransmits its HAR=
D_RESET=2E */
+    msg_set_prefix("Connection Attempt");
+    c->c2=2Eto_li=
nk =3D c->c2=2Ebuffers->aux_buf;
+    c->c2=2Eto_link_addr =3D &c->c2=2Efro=
m;
+    process_outgoing_link(c, sock);
+    c->c2=2Eto_link=2Elen =3D 0;
+=
    c->c2=2Eto_link_addr =3D NULL;
+    msg_set_prefix(NULL);
+
     msg(D_=
MULTI_DEBUG, "Reset packet from client, sending HMAC based reset challenge"=
);
 }
 
@@ -63,7 +74,7 @@
 /* Returns true if this packet should create a n=
ew session */
 static bool
 do_pre_decrypt_check(struct multi_context *m, s=
truct tls_pre_decrypt_state *state,
-                     struct mroute_add=
r addr)
+                     struct mroute_addr addr, struct link_socket *=
sock)
 {
     ASSERT(m->top=2Ec2=2Etls_auth_standalone);
 
@@ -106,7 +117,7=
 @@
             /* Calculate the session ID HMAC for our reply and create =
reset packet */
             struct session_id sid =3D
                 cal=
culate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, 0);
=
-            send_hmac_reset_packet(m, state, tas, &sid, true);
+          =
  send_hmac_reset_packet(m, state, tas, &sid, true, sock);
 
             r=
eturn false;
         }
@@ -139,7 +150,7 @@
         struct session_id sid =
=3D
             calculate_session_id_hmac(state->peer_session_id, from, hm=
ac, handwindow, 0);
 
-        send_hmac_reset_packet(m, state, tas, &sid, =
false);
+        send_hmac_reset_packet(m, state, tas, &sid, false, sock);
=
 
         /* We have a reply do not create a new session */
         retur=
n false;
@@ -194,7 +205,6 @@
     struct multi_instance *mi =3D NULL;
     =
struct hash *hash =3D m->hash;
     real=2Eproto =3D sock->info=2Eproto;
- =
   m->hmac_reply_ls =3D sock;
 
     if (mroute_extract_openvpn_sockaddr(&r=
eal, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
    =
 {
@@ -253,7 +263,7 @@
                     "shutting down",
              =
       mroute_addr_print(&real, &gc));
             }
-            else if =
(do_pre_decrypt_check(m, &state, real))
+            else if (do_pre_decryp=
t_check(m, &state, real, sock))
             {
                 /* This is =
an unknown session but with valid tls-auth/tls-crypt
                  * (o=
r no auth at all)=2E  If this is the initial packet of a
@@ -321,15 +331,6 =
@@
     {
         multi_process_outgoing_link_dowork(m, mi, mpp_flags);
  =
   }
-    if (m->hmac_reply_dest && m->hmac_reply=2Elen > 0)
-    {
-      =
  msg_set_prefix("Connection Attempt");
-        m->top=2Ec2=2Eto_link =3D =
m->hmac_reply;
-        m->top=2Ec2=2Eto_link_addr =3D m->hmac_reply_dest;
=
-        process_outgoing_link(&m->top, m->hmac_reply_ls);
-        m->hmac=
_reply_ls =3D NULL;
-        m->hmac_reply_dest =3D NULL;
-    }
 }
 
 /*
@=
@ -382,10 +383,6 @@
     {
         flags |=3D IOW_MBUF;
     }
-    else i=
f (m->hmac_reply_dest)
-    {
-        flags |=3D IOW_TO_LINK;
-    }
     =
else
     {
         flags |=3D IOW_READ;
diff --git a/src/openvpn/multi=2E=
h b/src/openvpn/multi=2Eh
index 3ed08d4=2E=2E8b837fa 100644
--- a/src/openv=
pn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -201,10 +201,6 @@
     struct c=
ontext top; /**< Storage structure for process-wide
                       =
   *   configuration=2E */
 
-    struct buffer hmac_reply;
-    struct lin=
k_socket_actual *hmac_reply_dest;
-    struct link_socket *hmac_reply_ls;
-=

     /*
      * Timer object for stale route check
      */

-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I2df0fec786184b9fcf9b7c56c7481632=
5cdb6942
Gerrit-Change-Number: 1702
Gerrit-PatchSet: 1
Gerrit-Owner: its_Gi=
aan <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: ordex <antonio@mandelbit=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ordex <antonio@mand=
elbit=2Ecom>

--v7ZXKJTd+c0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>its_Giaan would like plai=
sthos to <strong>review</strong> this change=2E
</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">mudp: send HMAC reset reply synchronously<br><br>Building a HARD_R=
ESET reply was queueing the result into three<br>multi_context fields and d=
eferring the send to the next event-loop<br>iteration, where multi_process_=
outgoing_link() flushed it:<br><br>  struct buffer hmac_reply;<br>  struct =
link_socket_actual *hmac_reply_dest;  /* aliased &amp;m-&gt;top=2Ec2=2Efrom=
 */<br>  struct link_socket *hmac_reply_ls;<br><br>The mechanism had three =
latent issues:<br><br>1=2E hmac_reply_dest =3D &amp;m-&gt;top=2Ec2=2Efrom s=
tored a pointer alias into<br>   shared mutable state=2E  Any subsequent re=
ad into m-&gt;top=2Ec2=2Efrom<br>   silently retargeted the pending reply t=
o a different peer=2E<br>2=2E m-&gt;hmac_reply_ls =3D sock; at the top of m=
ulti_get_create_instance_udp()<br>   was executed unconditionally for every=
 UDP packet, including packets<br>   that did not queue a reply=2E  A stale=
 queued reply could thus be sent<br>   on the wrong listening socket=2E<br>=
3=2E hmac_reply=2Edata pointed into m-&gt;top=2Ec2=2Ebuffers-&gt;aux_buf (t=
he only<br>   slot)=2E  A second send_hmac_reset_packet() before the first =
flush<br>   would overwrite the first reply&#39;s bytes=2E<br><br>These wer=
e latent on master because m-&gt;multi_io-&gt;udp_flags was consumed<br>and=
 zeroed by the first event in each multi_io_process_io() loop, so at<br>mos=
t one UDP read ran per outer iteration=2E<br><br>Send the reply synchronous=
ly from within send_hmac_reset_packet() using<br>the sock that the read fir=
ed on (threaded through do_pre_decrypt_check)=2E<br>The reply is small, sta=
teless, and rate-limited by the existing<br>reflect_filter_rate_limit_check=
(); dropping on EAGAIN is acceptable<br>because the client retransmits its =
HARD_RESET=2E  The three multi_context<br>fields and the deferred-flush blo=
ck in multi_process_outgoing_link() are<br>gone; p2mp_iow_flags() no longer=
 needs an IOW_TO_LINK branch for hmac<br>state=2E<br><br>Change-Id: I2df0fe=
c786184b9fcf9b7c56c74816325cdb6942<br>Signed-off-by: Antonio Quartulli &lt;=
antonio@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>M src/openv=
pn/multi=2Eh<br>2 files changed, 18 insertions(+), 25 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/02/1702/1</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/=
mudp=2Ec</span><br><span>index 432c79a=2E=2E874736e 100644</span><br><span>=
--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span=
><br><span>@@ -40,7 +40,7 @@</span><br><span> static void</span><br><span> =
send_hmac_reset_packet(struct multi_context *m, struct tls_pre_decrypt_stat=
e *state,</span><br><span>                        struct tls_auth_standalon=
e *tas, struct session_id *sid,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                       bool request_resend_wkc)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                       bool request_r=
esend_wkc, struct link_socket *sock)</span><br><span> {</span><br><span>   =
  reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Esend=
);</span><br><span>     state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Ein=
itialized =3D true;</span><br><span>@@ -54,8 +54,19 @@</span><br><span>    =
 ASSERT(buf_init(&amp;c-&gt;c2=2Ebuffers-&gt;aux_buf, buf=2Eoffset));</span=
><br><span> </span><br><span>     buf_copy(&amp;c-&gt;c2=2Ebuffers-&gt;aux_=
buf, &amp;buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-=
&gt;hmac_reply =3D c-&gt;c2=2Ebuffers-&gt;aux_buf;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    m-&gt;hmac_reply_dest =3D &amp;m-&gt;top=
=2Ec2=2Efrom;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Send synchronously=
: queueing across event-loop iterations would alias</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * m-&gt;top=2Ec2=2Efrom and aux_buf =
into cross-socket race territory=2E  The reply</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * is small, stateless, and rate-limited by =
reflect_filter_rate_limit_check();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * dropping on EAGAIN is acceptable as the client retran=
smits its HARD_RESET=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    msg_set_prefix(&quot;Connection Attempt&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eto_link =3D c-&gt;c2=
=2Ebuffers-&gt;aux_buf;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    c-&gt;c2=2Eto_link_addr =3D &amp;c-&gt;c2=2Efrom;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    process_outgoing_link(c, sock);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eto_lin=
k=2Elen =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
-&gt;c2=2Eto_link_addr =3D NULL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    msg_set_prefix(NULL);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>     msg(D_MULTI_DEBUG, &quot;Reset pac=
ket from client, sending HMAC based reset challenge&quot;);</span><br><span=
> }</span><br><span> </span><br><span>@@ -63,7 +74,7 @@</span><br><span> /*=
 Returns true if this packet should create a new session */</span><br><span=
> static bool</span><br><span> do_pre_decrypt_check(struct multi_context *m=
, struct tls_pre_decrypt_state *state,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                     struct mroute_addr addr)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                     struct mrou=
te_addr addr, struct link_socket *sock)</span><br><span> {</span><br><span>=
     ASSERT(m-&gt;top=2Ec2=2Etls_auth_standalone);</span><br><span> </span>=
<br><span>@@ -106,7 +117,7 @@</span><br><span>             /* Calculate the=
 session ID HMAC for our reply and create reset packet */</span><br><span> =
            struct session_id sid =3D</span><br><span>                 calc=
ulate_session_id_hmac(state-&gt;peer_session_id, from, hmac, handwindow, 0)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            send_hma=
c_reset_packet(m, state, tas, &amp;sid, true);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            send_hmac_reset_packet(m, state, tas=
, &amp;sid, true, sock);</span><br><span> </span><br><span>             ret=
urn false;</span><br><span>         }</span><br><span>@@ -139,7 +150,7 @@</=
span><br><span>         struct session_id sid =3D</span><br><span>         =
    calculate_session_id_hmac(state-&gt;peer_session_id, from, hmac, handwi=
ndow, 0);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        send_hmac_reset_packet(m, state, tas, &amp;sid, false);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        send_hmac_reset_p=
acket(m, state, tas, &amp;sid, false, sock);</span><br><span> </span><br><s=
pan>         /* We have a reply do not create a new session */</span><br><s=
pan>         return false;</span><br><span>@@ -194,7 +205,6 @@</span><br><s=
pan>     struct multi_instance *mi =3D NULL;</span><br><span>     struct ha=
sh *hash =3D m-&gt;hash;</span><br><span>     real=2Eproto =3D sock-&gt;inf=
o=2Eproto;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;h=
mac_reply_ls =3D sock;</span><br><span> </span><br><span>     if (mroute_ex=
tract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) =
&amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span><br><span>     {</span>=
<br><span>@@ -253,7 +263,7 @@</span><br><span>                     &quot;sh=
utting down&quot;,</span><br><span>                     mroute_addr_print(&=
amp;real, &amp;gc));</span><br><span>             }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            else if (do_pre_decrypt_check(m=
, &amp;state, real))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            else if (do_pre_decrypt_check(m, &amp;state, real, sock))</spa=
n><br><span>             {</span><br><span>                 /* This is an u=
nknown session but with valid tls-auth/tls-crypt</span><br><span>          =
        * (or no auth at all)=2E  If this is the initial packet of a</span>=
<br><span>@@ -321,15 +331,6 @@</span><br><span>     {</span><br><span>     =
    multi_process_outgoing_link_dowork(m, mi, mpp_flags);</span><br><span> =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (m-&gt;hm=
ac_reply_dest &amp;&amp; m-&gt;hmac_reply=2Elen &gt; 0)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        msg_set_prefix(&quot;Connection Attempt&quot;);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m-&gt;top=2Ec2=
=2Eto_link =3D m-&gt;hmac_reply;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        m-&gt;top=2Ec2=2Eto_link_addr =3D m-&gt;hmac_reply_dest;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        process_outgo=
ing_link(&amp;m-&gt;top, m-&gt;hmac_reply_ls);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        m-&gt;hmac_reply_ls =3D NULL;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        m-&gt;hmac_reply_dest =3D =
NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span> }</span><br><span> </span><br><span> /*</span><br><span>@@ -382,10 +=
383,6 @@</span><br><span>     {</span><br><span>         flags |=3D IOW_MBU=
F;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    else if (m-&gt;hmac_reply_dest)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        flags |=3D IOW_TO_LINK;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span>     else</span><br><span>     {</span><b=
r><span>         flags |=3D IOW_READ;</span><br><span>diff --git a/src/open=
vpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 3ed08d4=2E=2E8b=
837fa 100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>++=
+ b/src/openvpn/multi=2Eh</span><br><span>@@ -201,10 +201,6 @@</span><br><s=
pan>     struct context top; /**&lt; Storage structure for process-wide</sp=
an><br><span>                          *   configuration=2E */</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffe=
r hmac_reply;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct link_socket_actual *hmac_reply_dest;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct link_socket *hmac_reply_ls;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /*</span><br><span=
>      * Timer object for stale route check</span><br><span>      */</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1702?usp=3Demail">change 1702</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I2df0fec786184b9fcf9b7c56c=
74816325cdb6942 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
702 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@m=
andelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--v7ZXKJTd+c0=--


--===============5280773015147119935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5280773015147119935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5280773015147119935==--

