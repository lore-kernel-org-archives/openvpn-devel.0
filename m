Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4222DCD98C5
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M2XpktYB1i4Si0S8C1H3xWAQrWJM5fh2Wmp7Ajc5qT4=; b=EyWe7xijnVyiKTYK9cIMxcY4ng
	hcNWuR2EwlwTQ/aObYqpJmz2nci7+sLo8rSchYyBZogo3/r3cb0NtSs2v+EkF1W+qqRmXsV4txDb+
	pI/D9hjLcY7IMQ1iX1hnM+EBUOjQr2OfidVyQ6d7PYwmgG+tnpezxz4vk/Kk+gclCJ1o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWz1R-00085X-2S;
	Tue, 09 Jun 2026 16:09:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWz1P-00085R-Au
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 16:09:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=MRnFr28RYBMKcTOLCNHUYflVVPPwL8lvcGp4kmJw/Es=; b=bKZm2CyImtl9AxHPX+w8vjgLed
 HYoY2lvHeEoC7VRC6o6wxKlLetDfMBg4YFg8dBpTvpdpNo+RAyVjlU+nS54kLBvE05hX2UHq2ZUR3
 fkd8OGRTRgPVIfSoNSVoyioCnIZlPsv2tSu3KCguJc+VBhXgkbqdwFOoEQS360Hf4iQ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MRnFr28RYBMKcTOLCNHUYflVVPPwL8lvcGp4kmJw/Es=; b=O
 Zr6ZNrRmGn2Hi7sRwGd6WYAULIXDDGLcMkCH5AM0KpZbWQJ9IMrIRrJqB5h02XB9HbK926ajExMIw
 UlFh2lwH1ChdjGroVIIqtzLqyNsU+BMmQqqQOdk0D65FGrFyFCzoqwGb3JkJX3HNjO+odTnYsyKCR
 GXE/Hf9nCPReuts0=;
Received: from mail-ed1-f48.google.com ([209.85.208.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWz1N-0003s6-8I for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 16:09:47 +0000
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-68bd9fce347so10467440a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 09:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781021374; x=1781626174; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MRnFr28RYBMKcTOLCNHUYflVVPPwL8lvcGp4kmJw/Es=;
 b=Y9au+H59ZhS6JzvFih2I2kLBNnS/DDvoguf/yOEWmmpl0HZg4X8n/Fr8alMGs9/mD+
 MfqFePK3OinbIIq/q3NOllc17+RCgzYLzh06VzSNDMa3GXpXRR5/0uCq4mKLzRFEe1h+
 kc3FBdF4GwZk4NH9EHT2DD1BJSijgN+aWJJl1gk2FKLx0g7Xc3GPmE1Jwa2F6/0/hdP+
 dN9LTXnDd7M9yECLTEOtndwYi6l13806Y++yHJdGL3ZBURkO+fgxrMRhG3rZMWMeLkGh
 fw2Cfgp4yaHsyij727MEGy+HTZ8G+xzFk+bVYrFJk5OoYgw9OJTzM1Syhx3JXu12aQP7
 6aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781021374; x=1781626174;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MRnFr28RYBMKcTOLCNHUYflVVPPwL8lvcGp4kmJw/Es=;
 b=VCnoAH5q6cS3dZETSNURHhqnBzIFBLfcZMLVSYqlwIpToBSQFfXHw8jzuXqs4vbcoH
 3U7PfcUprh2U4DLwIcH/5Sit3PfvgTrfL9sWUCWqX+zdfApsg87TBCwd5KNcdTMTYhh0
 2Px/+J4wQ1FQlBUDNFxo+FdWjp71NsVTcYR7Yy5Q5KEEMIgV+XJ6oTNgrzMJphc4CaYY
 AKunEzLntzYhT93NROejpCSNJREueBv5RPJDRa5N6IDYyUPo+PUr/SYfqo8JC2G/iEjw
 p6wwTFLH2xP3nZLYZgdSwg09yvdfKIo/PaVvBGreQkEFzkWPm/IGwRX4131hWuhhjmci
 VDnA==
X-Gm-Message-State: AOJu0YymuUiNAV4eJ0puAXwnFvSf8JBqqNqyuIoF1jgiFohDT0G/NOww
 oD4rutAyYI4rGU30XTDeKjghqJq6raAJlDB/9T/ZR9Pr48Y3K5w/BcfZJrLfExVxhrIchWC1t7e
 1M6d9s+YGRbrFFWOhiDXj08rs0nwyrNE8TT7WM0AJA+qIVdYIIcPMrTEdGbPsq9cfHiceTkQTyc
 9ABcYf4A==
X-Gm-Gg: Acq92OHFlAD0C7pzMlh+2TUvVM1d8G9EgulUZhlpnp4oThfDGeBaorK0LA9tcYElPwr
 WN+ieTHsPj5Z36zkfE++fPGNKdYM8q9qFhe7bIf5Loz6pFac9JR2LzPvQEyPYSroB7gn0XHO6nf
 6Pz2PKiHWMaoOVM3WVW/IJoDEkTRZjKxF6YBGc9L8qRKhAuk8hBfrGRNsVf1+nytdoiYwij+Mjm
 WqptV/YuhylDcTmKkojt2koLzR9rPwufopiizgrERr0sGnFOlRYcCDHyEV4ptP5/kJM7KYcpDel
 Zx4Zcbm9/J2kHNrlP3Ga25BkB5vY2lU058qOJS6QI4yZbM3bRjkzToNwp4KOJjicfwgCOKv12Ho
 hGtzYizpxaqHfAa+5pn7J4Seez9Jfo5I38kvFo+oMiyMj73aXAtB88twZs7bSwso/cdF5ybz+sK
 kShVTfXgTHMd+yRkYObAEvdiStQUvwB/lQYoHV7yMPBE/ZRjoBl8CV43Z8hMvwUvvyGPZpf2wuw
 uvqAK271ftkkLAvewSV5GeA6M/W+76WU1sq5mCsdBMCQdJoFVgjfodzxW7LnP7Qyo85wITuXIII
 SN5/v89iVrn3UbDHk+x+mr1r
X-Received: by 2002:a05:6000:4a09:b0:45e:779a:302c with SMTP id
 ffacd0b85a97d-460566c94ddmr1704401f8f.29.1780990957118; 
 Tue, 09 Jun 2026 00:42:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351d69sm107927991f8f.29.2026.06.09.00.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 00:42:36 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 07:42:34 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942
X-Gerrit-Change-Number: 1702
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1702?usp=email>
X-Gerrit-Commit: 9bb6c3cf8378bba2bd4c7ae2495f6882de92cd95
In-Reply-To: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
References: <gerrit.1779455880000.I2df0fec786184b9fcf9b7c56c74816325cdb6942@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5NDU1ODgwMDAwLkkyZGYwZmVjNzg2MTg0YjlmY2Y5YjdjNTZjNzQ4MTYzMjVjZGI2OTQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b646c3cf056be032df9ea68f161a986f03890f1c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWz1N-0003s6-8I
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
From: "its_Giaan \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com,
 gert@greenie.muc.de
Cc: "its_Giaan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9058560078795217623=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9058560078795217623==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TEpm8K51uRE="; charset=UTF-8

--TEpm8K51uRE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, its_Giaan, plaisthos=2E

Hello=
 cron2, ordex, plaisthos, 

I'd like you to reexamine a change=2E Please vi=
sit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail

to loo=
k at the new patch set (#2)=2E

The following approvals got outdated and we=
re removed:
Code-Review+2 by plaisthos, Code-Review-1 by cron2


Change sub=
ject: mudp: send HMAC reset reply synchronously
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mudp: send HMAC reset reply synchronousl=
y

Building a HARD_RESET reply was queueing the result into three
multi_con=
text fields and deferring the send to the next event-loop
iteration, where =
multi_process_outgoing_link() flushed it:

  struct buffer hmac_reply;
  st=
ruct link_socket_actual *hmac_reply_dest;  /* aliased &m->top=2Ec2=2Efrom *=
/
  struct link_socket *hmac_reply_ls;

The mechanism had three latent issu=
es:

1=2E hmac_reply_dest =3D &m->top=2Ec2=2Efrom stored a pointer alias in=
to
   shared mutable state=2E  Any subsequent read into m->top=2Ec2=2Efrom
=
   silently retargeted the pending reply to a different peer=2E
2=2E m->hma=
c_reply_ls =3D sock; at the top of multi_get_create_instance_udp()
   was e=
xecuted unconditionally for every UDP packet, including packets
   that did=
 not queue a reply=2E  A stale queued reply could thus be sent
   on the wr=
ong listening socket=2E
3=2E hmac_reply=2Edata pointed into m->top=2Ec2=2Eb=
uffers->aux_buf (the only
   slot)=2E  A second send_hmac_reset_packet() be=
fore the first flush
   would overwrite the first reply's bytes=2E

These w=
ere latent on master because m->multi_io->udp_flags was consumed
and zeroed=
 by the first event in each multi_io_process_io() loop, so at
most one UDP =
read ran per outer iteration=2E

Send the reply synchronously from within s=
end_hmac_reset_packet() using
the sock that the read fired on (threaded thr=
ough do_pre_decrypt_check)=2E
The reply is small, stateless, and rate-limit=
ed by the existing
reflect_filter_rate_limit_check(); dropping on EAGAIN is=
 acceptable
because the client retransmits its HARD_RESET=2E  The three mul=
ti_context
fields and the deferred-flush block in multi_process_outgoing_li=
nk() are
gone; p2mp_iow_flags() no longer needs an IOW_TO_LINK branch for h=
mac
state=2E

Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942
Signed-o=
ff-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M src/openvpn/mudp=
=2Ec
M src/openvpn/multi=2Eh
2 files changed, 21 insertions(+), 25 deletion=
s(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/0=
2/1702/2

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 43=
2c79a=2E=2Edded1ee 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=
=2Ec
@@ -40,7 +40,7 @@
 static void
 send_hmac_reset_packet(struct multi_co=
ntext *m, struct tls_pre_decrypt_state *state,
                        stru=
ct tls_auth_standalone *tas, struct session_id *sid,
-                     =
  bool request_resend_wkc)
+                       bool request_resend_wkc,=
 struct link_socket *sock)
 {
     reset_packet_id_send(&state->tls_wrap_tm=
p=2Eopt=2Epacket_id=2Esend);
     state->tls_wrap_tmp=2Eopt=2Epacket_id=2Er=
ec=2Einitialized =3D true;
@@ -54,16 +54,30 @@
     ASSERT(buf_init(&c->c2=
=2Ebuffers->aux_buf, buf=2Eoffset));
 
     buf_copy(&c->c2=2Ebuffers->aux_=
buf, &buf);
-    m->hmac_reply =3D c->c2=2Ebuffers->aux_buf;
-    m->hmac_r=
eply_dest =3D &m->top=2Ec2=2Efrom;
+
+    /*
+     * We do not want to keep=
 any state here, so we send the reply to the
+     * initial packet synchro=
nously without queueing anything=2E
+     *
+     * If we hit EAGAIN on a b=
usy socket, the packet will be lost and the
+     * client will have to ret=
ransmit its HARD_RESET=2E This is considered an
+     * acceptable compromi=
se to avoid consuming server resources under attack=2E
+     */
+    msg_se=
t_prefix("Connection Attempt");
+    c->c2=2Eto_link =3D c->c2=2Ebuffers->a=
ux_buf;
+    c->c2=2Eto_link_addr =3D &c->c2=2Efrom;
     msg(D_MULTI_DEBUG=
, "Reset packet from client, sending HMAC based reset challenge");
+    pro=
cess_outgoing_link(c, sock);
+    c->c2=2Eto_link=2Elen =3D 0;
+    c->c2=
=2Eto_link_addr =3D NULL;
+    msg_set_prefix(NULL);
 }
 
 
 /* Returns tru=
e if this packet should create a new session */
 static bool
 do_pre_decryp=
t_check(struct multi_context *m, struct tls_pre_decrypt_state *state,
-    =
                 struct mroute_addr addr)
+                     struct mrou=
te_addr addr, struct link_socket *sock)
 {
     ASSERT(m->top=2Ec2=2Etls_au=
th_standalone);
 
@@ -106,7 +120,7 @@
             /* Calculate the session=
 ID HMAC for our reply and create reset packet */
             struct sessi=
on_id sid =3D
                 calculate_session_id_hmac(state->peer_sessio=
n_id, from, hmac, handwindow, 0);
-            send_hmac_reset_packet(m, st=
ate, tas, &sid, true);
+            send_hmac_reset_packet(m, state, tas, &=
sid, true, sock);
 
             return false;
         }
@@ -139,7 +153,7 =
@@
         struct session_id sid =3D
             calculate_session_id_hma=
c(state->peer_session_id, from, hmac, handwindow, 0);
 
-        send_hmac_=
reset_packet(m, state, tas, &sid, false);
+        send_hmac_reset_packet(m=
, state, tas, &sid, false, sock);
 
         /* We have a reply do not crea=
te a new session */
         return false;
@@ -194,7 +208,6 @@
     struct =
multi_instance *mi =3D NULL;
     struct hash *hash =3D m->hash;
     real=
=2Eproto =3D sock->info=2Eproto;
-    m->hmac_reply_ls =3D sock;
 
     if =
(mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) &=
& m->top=2Ec2=2Ebuf=2Elen > 0)
     {
@@ -253,7 +266,7 @@
                 =
    "shutting down",
                     mroute_addr_print(&real, &gc));
 =
            }
-            else if (do_pre_decrypt_check(m, &state, real))
=
+            else if (do_pre_decrypt_check(m, &state, real, sock))
        =
     {
                 /* This is an unknown session but with valid tls-au=
th/tls-crypt
                  * (or no auth at all)=2E  If this is the ini=
tial packet of a
@@ -321,15 +334,6 @@
     {
         multi_process_outgoin=
g_link_dowork(m, mi, mpp_flags);
     }
-    if (m->hmac_reply_dest && m->h=
mac_reply=2Elen > 0)
-    {
-        msg_set_prefix("Connection Attempt");
=
-        m->top=2Ec2=2Eto_link =3D m->hmac_reply;
-        m->top=2Ec2=2Eto=
_link_addr =3D m->hmac_reply_dest;
-        process_outgoing_link(&m->top, =
m->hmac_reply_ls);
-        m->hmac_reply_ls =3D NULL;
-        m->hmac_rep=
ly_dest =3D NULL;
-    }
 }
 
 /*
@@ -382,10 +386,6 @@
     {
         flag=
s |=3D IOW_MBUF;
     }
-    else if (m->hmac_reply_dest)
-    {
-        f=
lags |=3D IOW_TO_LINK;
-    }
     else
     {
         flags |=3D IOW_READ=
;
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 3ed08d4=
=2E=2E8b837fa 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2E=
h
@@ -201,10 +201,6 @@
     struct context top; /**< Storage structure for =
process-wide
                          *   configuration=2E */
 
-    struc=
t buffer hmac_reply;
-    struct link_socket_actual *hmac_reply_dest;
-    =
struct link_socket *hmac_reply_ls;
-
     /*
      * Timer object for stale=
 route check
      */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1702?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942
Gerrit-Change-Number: 1702
G=
errit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerri=
t-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attentio=
n: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@gre=
enie=2Emuc=2Ede>
Gerrit-Attention: its_Giaan <gianmarco@mandelbit=2Ecom>

--TEpm8K51uRE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, its_Giaan, plaisthos=2E </p>
<p>its_Giaan <str=
ong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1702?usp=3Demail">View Change</a></p><=
p>The following approvals got outdated and were removed:
Code-Review+2 by p=
laisthos, Code-Review-1 by cron2</p><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">mudp: send HMAC reset rep=
ly synchronously<br><br>Building a HARD_RESET reply was queueing the result=
 into three<br>multi_context fields and deferring the send to the next even=
t-loop<br>iteration, where multi_process_outgoing_link() flushed it:<br><br=
>  struct buffer hmac_reply;<br>  struct link_socket_actual *hmac_reply_des=
t;  /* aliased &amp;m-&gt;top=2Ec2=2Efrom */<br>  struct link_socket *hmac_=
reply_ls;<br><br>The mechanism had three latent issues:<br><br>1=2E hmac_re=
ply_dest =3D &amp;m-&gt;top=2Ec2=2Efrom stored a pointer alias into<br>   s=
hared mutable state=2E  Any subsequent read into m-&gt;top=2Ec2=2Efrom<br> =
  silently retargeted the pending reply to a different peer=2E<br>2=2E m-&g=
t;hmac_reply_ls =3D sock; at the top of multi_get_create_instance_udp()<br>=
   was executed unconditionally for every UDP packet, including packets<br>=
   that did not queue a reply=2E  A stale queued reply could thus be sent<b=
r>   on the wrong listening socket=2E<br>3=2E hmac_reply=2Edata pointed int=
o m-&gt;top=2Ec2=2Ebuffers-&gt;aux_buf (the only<br>   slot)=2E  A second s=
end_hmac_reset_packet() before the first flush<br>   would overwrite the fi=
rst reply&#39;s bytes=2E<br><br>These were latent on master because m-&gt;m=
ulti_io-&gt;udp_flags was consumed<br>and zeroed by the first event in each=
 multi_io_process_io() loop, so at<br>most one UDP read ran per outer itera=
tion=2E<br><br>Send the reply synchronously from within send_hmac_reset_pac=
ket() using<br>the sock that the read fired on (threaded through do_pre_dec=
rypt_check)=2E<br>The reply is small, stateless, and rate-limited by the ex=
isting<br>reflect_filter_rate_limit_check(); dropping on EAGAIN is acceptab=
le<br>because the client retransmits its HARD_RESET=2E  The three multi_con=
text<br>fields and the deferred-flush block in multi_process_outgoing_link(=
) are<br>gone; p2mp_iow_flags() no longer needs an IOW_TO_LINK branch for h=
mac<br>state=2E<br><br>Change-Id: I2df0fec786184b9fcf9b7c56c74816325cdb6942=
<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---=
<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Eh<br>2 files changed, 2=
1 insertions(+), 25 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/02/1702/2</pre><pre sty=
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
chSet: 2 </div>
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
<div style=3D"display:none"> Ger=
rit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianm=
arco@mandelbit=2Ecom&gt; </div>

</body></html>
--TEpm8K51uRE=--


--===============9058560078795217623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9058560078795217623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9058560078795217623==--

