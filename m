Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C0CCD8C9F
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tokeMzuntXaRSY6P91oVKY4U3JnflhorYREwxVrQvko=; b=OWKzVWdhrePZeQ3DBgADZTdwwc
	mxJmO5nWpSvfweA3bbaSqCxfAokKxWeSaSYSortzBkkgFGP57uEPaqVQcKG5Qi7DVDoa/DJ4+UUYy
	RrI8LymfeXmghZqUDJfsmtfHWUkeLB5cG52zBTdmLCGi3ojLzIEJDpimJ93kBt8mprMM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWZQW-0000KU-Ps;
	Mon, 08 Jun 2026 12:50:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWZQW-0000Ji-0l
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 12:50:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9g3q2ZIxPHkjhoGJqdCCUKNVoSmMwXhlDZd80dZaJwI=; b=hZMYj9olrKlkiA2LbvXED/lLkL
 iyOeCblZ4q5UJfJE8HQaK0o7KKQrUtKjXDqro0WW1e0hJoA5DyeQeuwa4Pr5dkglqcQ6NKMoWTsYX
 buCId3UK+K4Nsa2lOZVK/Cv+P9ZSQ1vW5gAicvEoMWHPY4x+aeZM2JZUf4AUtCzFU43o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9g3q2ZIxPHkjhoGJqdCCUKNVoSmMwXhlDZd80dZaJwI=; b=S
 HGx9LpOck7P/VblRwmsMWAK/F8371dGZ7EKAtEjK9hbpYx1NApzwtUgOeVwjSs+ObnqofzHy9g38X
 kGxqxR10WTgNL6cqdm7P/LUt/Ewjp5dxpHbzpGtcmizCUTA0CbOj0PIgO2KajMxB1kaXNdMWyM5KJ
 Em/N51uEtsS5kTQ8=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWZQS-0000Gl-VU for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 12:50:00 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-45ef616daf6so3886468f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 08 Jun 2026 05:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780922986; x=1781527786; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9g3q2ZIxPHkjhoGJqdCCUKNVoSmMwXhlDZd80dZaJwI=;
 b=fwOWAIgFfsNgl/ihDZPVTe7mHlFNGQ65zfhdiZO6sMtahZmx+ODw+NRmWqKOgmcJF/
 VuSmP2H9j7faIkShRX0FoR2M5uHXEwk/QlqVxS2UlTKN7rdoN7bRqIpdTnnzaPwAszX4
 +1TjiRPeCh7hHtb4AxqvkMUJB5yrVee12PpyJFDoqafVydc9QJf9wxsirjob/bLJnIAN
 Kr3c67BycaOkaLG26gK+8N/xi1MWX3ZMrZZ+CEIwtOzHm0jYnU9D3RZcQb1n6z3KBK9C
 AM9t7bJJ85IwqSGv8g4XvW6oefqeIYjgtA1iKqAqc4hX/KSeEA5ZnyIG4Ugjg77rqRRP
 gbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780922986; x=1781527786;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9g3q2ZIxPHkjhoGJqdCCUKNVoSmMwXhlDZd80dZaJwI=;
 b=lRU4sxSJeOAyqklqydWR/AJ5itBbgqPFfL0cKMIjyHnRt/lZxD2U3OaVdyaC4X5+8r
 h8InKOflWJfx7Df8JeJqCyRKGkXOmwjhp8ZX6r7DR6jvOT8iVhoMxootV05zZb1ptHQb
 q7fiUO8X2A7SzC6BmDjnbHaqD1r7//4Oz1fTC/JitAT9uaT0BzN4m41/JNr42e6OphC6
 NZ+0A/7CVUYa6vvt4BU7j+pBuUmelET7i+Uz+b8C3yjQ1ZG+CcTqK04bgz/0x5z/42TN
 BbJlN475+EXkfT0PlGarOxvO6vmYBJf6aI7MnRmzznfoKU3Z8uUqnHVGUWkr3F1fymfG
 dJoA==
X-Gm-Message-State: AOJu0Yz5ypNS9IMugeYTTHfGSsbNPGlAWhKuuw1pF9jvuDVP0LPJjc2c
 3WlQL9Jg+jBJqG6OUn+xJx50MmhYmw1vhx7m2ZKk8NEy/tTRYuaqH+Qvg66TlOT1q0//x+cgIym
 n9GPSVZky1n9mAWhWXV7J8gvdBOABaVfuayK3ez5y/w/8h5RKWLRCEn+F9Qd8e8fDCE1V
X-Gm-Gg: Acq92OFRCPGsV+stOguh6LAMsaHyZSr87wGDNGSxcs5cckAW0AfUaenH11iF++gdtif
 6Nz3dGbMbdeIZ+k+kDO7EOoZRRPPNa67pxINyescBXYEbdPr+D4oH3aiXGIqVOLmrMZSKEk5cbY
 JJG4LWHnFnIOwpXWAPBUZyA9xRqAiJ9ZxkklYlKz4p6qAxvi1yZeLryYVcQo5F2Gu5RQ2Jlvw9K
 MNQcSuZy8MHb1ctcC43MvO5Ek//0v05IL7YsVPupYC2/ZAmHs/wQNiJBhfXV4dQClCZU39FsO0A
 BoIUUpizST/gOr9zh2PP6y2JPRuSWsmTs9Ohw7e+9Iox/zYTcw+zD+6Xyoj8+HBOEnQ53NkUw60
 dk/VNno1dkrVCuohnh5gXkNzPATH8+z5TiFAupZegzWwKp/b+7u7BCZlGZxUXPDnxAVxAKwaY67
 vswtqOizWulOvhXsLnSindsAI69I2pCxKrNCz+t+HTbxGAo8XWXbiKEtqu9potHJiyMmUNf1ruf
 NgnJhJrL/PnxxA8LEVROw6VpF5zcH5S5dKsNAtEQ8Yc23VuQgaAx3sTdrgNCxlSoXF6wEdSYjoV
 XJf3negKvRxgvDND//X5dH0dwCeMzbvReGo=
X-Received: by 2002:a5d:4290:0:b0:45e:ce49:43d8 with SMTP id
 ffacd0b85a97d-460302dcd43mr16542748f8f.4.1780922985654; 
 Mon, 08 Jun 2026 05:49:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm94061691f8f.27.2026.06.08.05.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 05:49:45 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 8 Jun 2026 12:49:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
X-Gerrit-Change-Number: 1635
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1635?usp=email>
X-Gerrit-Commit: 6e690c619252e5d88271ace9b302f8abd626c965
In-Reply-To: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
References: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzgzMTAwMDAwLkk2YjMwMzgwNWEzNjg4YjZmNjM2MzE0MGM3Njg1M2E1OGJhZGVjZDhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0420daf0f2a4aca18520006c85684060e1eff9f8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWZQS-0000Gl-VU
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Multisocket: use
 event engine rwflags for UDP I/O
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
Content-Type: multipart/mixed; boundary="===============4258624391902863862=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4258624391902863862==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qW6Ir226krQ="; charset=UTF-8

--qW6Ir226krQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, its_Giaan, plaisthos=2E

Hello=
 cron2, ordex, plaisthos, 

I'd like you to reexamine a change=2E Please vi=
sit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail

to loo=
k at the new patch set (#5)=2E


Change subject: Multisocket: use event eng=
ine rwflags for UDP I/O
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Multisocket: use event engine rwflags for UDP I/O

udp_flags doe=
s not guarantee correct association with the socket being
processed=2E Use =
the rwflags delivered by the event engine along with the
event to ensure pr=
oper per-socket I/O handling=2E

Remove udp_flags entirely=2E

Replace the =
previous global-style flag computation with a per-socket
decision model in =
p2mp_iow_flags(), which derives I/O flags
directly from the current multi_c=
ontext state and the specific socket
being processed=2E This ensures that r=
ead/write decisions are correctly
bound to the active socket rather than sh=
ared or implicit global state=2E

This change is based on an investigation =
triggered by a report from
Joshua Rogers using ZeroPath=2E

Change-Id: I6b3=
03805a3688b6f6363140c76853a58badecd8f
Signed-off-by: Gianmarco De Gregori <=
gianmarco@mandelbit=2Ecom>
---
M src/openvpn/forward=2Ec
M src/openvpn/forw=
ard=2Eh
M src/openvpn/mudp=2Ec
M src/openvpn/mudp=2Eh
M src/openvpn/multi_i=
o=2Ec
M src/openvpn/multi_io=2Eh
6 files changed, 27 insertions(+), 53 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/35/1635/5

diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2E=
c
index d24f534=2E=2Ef2dc2da 100644
--- a/src/openvpn/forward=2Ec
+++ b/src=
/openvpn/forward=2Ec
@@ -2030,9 +2030,8 @@
     check_timeout_random_compon=
ent(c);
 }
 
-static void
-multi_io_process_flags(struct context *c, struct=
 event_set *es, const unsigned int flags,
-                       unsigned =
int *out_socket, unsigned int *out_tuntap)
+void
+multi_io_process_flags(st=
ruct context *c, struct event_set *es, struct link_socket *sock, const unsi=
gned int flags)
 {
     unsigned int socket =3D 0;
     unsigned int tuntap=
 =3D 0;
@@ -2123,39 +2122,8 @@
      * (for TCP server sockets this happens=
 in
      *  socket_set_listen_persistent())=2E
      */
-    for (int i =
=3D 0; i < c->c1=2Elink_sockets_num; i++)
-    {
-        if ((c->options=
=2Emode !=3D MODE_SERVER) || (proto_is_dgram(c->c2=2Elink_sockets[i]->info=
=2Eproto)))
-        {
-            socket_set(c->c2=2Elink_sockets[i], es,=
 socket, &c->c2=2Elink_sockets[i]->ev_arg, NULL);
-        }
-    }
-
+    =
socket_set(sock, es, socket, &sock->ev_arg, NULL);
     tun_set(c->c1=2Etun=
tap, es, tuntap, (void *)tun_shift, NULL);
-
-    if (out_socket)
-    {
- =
       *out_socket =3D socket;
-    }
-
-    if (out_tuntap)
-    {
-      =
  *out_tuntap =3D tuntap;
-    }
-}
-
-/*
- * Wait for I/O events=2E  Used =
for UDP sockets in
- * point-to-multipoint mode=2E
- */
-
-void
-get_io_fla=
gs_udp(struct context *c, struct multi_io *multi_io, const unsigned int fla=
gs)
-{
-    unsigned int out_socket;
-
-    multi_io_process_flags(c, multi=
_io->es, flags, &out_socket, NULL);
-    multi_io->udp_flags =3D (out_socke=
t << SOCKET_SHIFT);
 }
 
 /*
@@ -2165,8 +2133,6 @@
 void
 io_wait(struct co=
ntext *c, const unsigned int flags)
 {
-    unsigned int out_socket;
-    u=
nsigned int out_tuntap;
     struct event_set_return esr[4];
 
     /* Thes=
e shifts all depend on EVENT_READ and EVENT_WRITE */
@@ -2185,7 +2151,7 @@
=
      */
     event_reset(c->c2=2Eevent_set);
 
-    multi_io_process_flags=
(c, c->c2=2Eevent_set, flags, &out_socket, &out_tuntap);
+    multi_io_proc=
ess_flags(c, c->c2=2Eevent_set, c->c2=2Elink_sockets[0], flags);
 
 #if def=
ined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (c->c1=2Etuntap)
diff=
 --git a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh
index 0d3e492=2E=
=2Ed4edfba 100644
--- a/src/openvpn/forward=2Eh
+++ b/src/openvpn/forward=
=2Eh
@@ -68,7 +68,7 @@
 
 extern counter_type link_write_bytes_global;
 
-v=
oid get_io_flags_udp(struct context *c, struct multi_io *multi_io, const un=
signed int flags);
+void multi_io_process_flags(struct context *c, struct e=
vent_set *es, struct link_socket *sock, const unsigned int flags);
 
 void =
io_wait(struct context *c, const unsigned int flags);
 
diff --git a/src/op=
envpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 432c79a=2E=2Ebb89221 100644
---=
 a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -336,18 +336,17 @@
  =
* Process a UDP socket event=2E
  */
 void
-multi_process_io_udp(struct mul=
ti_context *m, struct link_socket *sock)
+multi_process_io_udp(struct multi=
_context *m, struct link_socket *sock, unsigned int rwflags)
 {
-    const =
unsigned int status =3D m->multi_io->udp_flags;
     const unsigned int mpp=
_flags =3D (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);
 
     /* UDP port ready=
 to accept write */
-    if (status & SOCKET_WRITE)
+    if (rwflags & SOCK=
ET_WRITE)
     {
         multi_process_outgoing_link(m, mpp_flags);
     }=

     /* Incoming data on UDP port */
-    else if (status & SOCKET_READ)
+=
    else if (rwflags & SOCKET_READ)
     {
         read_incoming_link(&m->=
top, sock);
         if (!IS_SIG(&m->top))
@@ -355,25 +354,25 @@
          =
   multi_process_incoming_link(m, NULL, mpp_flags, sock);
         }
     }=

-
-    m->multi_io->udp_flags =3D ES_ERROR;
 }
 
 /*
- * Return the io_wai=
t() flags appropriate for
+ * Return the io flags appropriate for
  * a poi=
nt-to-multipoint tunnel=2E
  */
 unsigned int
-p2mp_iow_flags(const struct =
multi_context *m)
+p2mp_iow_flags(const struct multi_context *m, struct lin=
k_socket *sock)
 {
     unsigned int flags =3D IOW_WAIT_SIGNAL;
+
     if (=
m->pending)
     {
         if (TUN_OUT(&m->pending->context))
         {
 =
            flags |=3D IOW_TO_TUN;
         }
-        if (LINK_OUT(&m->pen=
ding->context))
+
+        if (LINK_OUT(&m->pending->context) && m->pending=
->context=2Ec2=2Elink_sockets[0] =3D=3D sock)
         {
             flags=
 |=3D IOW_TO_LINK;
         }
diff --git a/src/openvpn/mudp=2Eh b/src/openv=
pn/mudp=2Eh
index 005ee10=2E=2Edfc69b9 100644
--- a/src/openvpn/mudp=2Eh
++=
+ b/src/openvpn/mudp=2Eh
@@ -30,9 +30,9 @@
 struct context;
 struct multi_c=
ontext;
 
-unsigned int p2mp_iow_flags(const struct multi_context *m);
+uns=
igned int p2mp_iow_flags(const struct multi_context *m, struct link_socket =
*sock);
 
-void multi_process_io_udp(struct multi_context *m, struct link_s=
ocket *sock);
+void multi_process_io_udp(struct multi_context *m, struct li=
nk_socket *sock, unsigned int rwflags);
 /*********************************=
*****************************************/
 /**
  * Get, and if necessary c=
reate, the multi_instance associated with a
diff --git a/src/openvpn/multi_=
io=2Ec b/src/openvpn/multi_io=2Ec
index e6f4e9c=2E=2E1334a74 100644
--- a/s=
rc/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -171,7 +171,17 @@=

 
     if (has_udp_in_local_list(&m->top=2Eoptions))
     {
-        get_i=
o_flags_udp(&m->top, m->multi_io, p2mp_iow_flags(m));
+        for (int i =
=3D 0; i < m->top=2Ec1=2Elink_sockets_num; i++)
+        {
+            str=
uct link_socket *sock =3D m->top=2Ec2=2Elink_sockets[i];
+
+            if =
((m->top=2Eoptions=2Emode =3D=3D MODE_SERVER) && proto_is_dgram(sock->info=
=2Eproto))
+            {
+                unsigned int flags =3D p2mp_iow_=
flags(m, sock);
+
+                multi_io_process_flags(&m->top, m->multi=
_io->es, sock, flags);
+            }
+        }
     }
 
     tun_set(m->t=
op=2Ec1=2Etuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, persistent);
@=
@ -457,7 +467,7 @@
                     }
                     else
       =
              {
-                        multi_process_io_udp(m, ev_arg->u=
=2Esock);
+                        multi_process_io_udp(m, ev_arg->u=2Esock=
, e->rwflags);
                         mi =3D m->pending;
                =
     }
                     /* monitor and/or handle events that are
diff -=
-git a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh
index 6b2f59a=2E=
=2Ed6734bd 100644
--- a/src/openvpn/multi_io=2Eh
+++ b/src/openvpn/multi_io=
=2Eh
@@ -55,7 +55,6 @@
     int n_esr;
     int maxevents;
     unsigned in=
t tun_rwflags;
-    unsigned int udp_flags;
 #ifdef ENABLE_MANAGEMENT
     =
unsigned int management_persist_flags;
 #endif

-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
Ge=
rrit-Change-Number: 1635
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gianma=
rco@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerri=
t-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Attention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Attention: cr=
on2 <gert@greenie=2Emuc=2Ede>

--qW6Ir226krQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, its_Giaan, plaisthos=2E </p>
<p>its_Giaan <str=
ong>uploaded patch set #5</strong> to this change=2E</p><p><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Multisocket: use event engine rwflags for UDP I/O<br><br>udp_f=
lags does not guarantee correct association with the socket being<br>proces=
sed=2E Use the rwflags delivered by the event engine along with the<br>even=
t to ensure proper per-socket I/O handling=2E<br><br>Remove udp_flags entir=
ely=2E<br><br>Replace the previous global-style flag computation with a per=
-socket<br>decision model in p2mp_iow_flags(), which derives I/O flags<br>d=
irectly from the current multi_context state and the specific socket<br>bei=
ng processed=2E This ensures that read/write decisions are correctly<br>bou=
nd to the active socket rather than shared or implicit global state=2E<br><=
br>This change is based on an investigation triggered by a report from<br>J=
oshua Rogers using ZeroPath=2E<br><br>Change-Id: I6b303805a3688b6f6363140c7=
6853a58badecd8f<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandel=
bit=2Ecom&gt;<br>---<br>M src/openvpn/forward=2Ec<br>M src/openvpn/forward=
=2Eh<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/mudp=2Eh<br>M src/openvpn/m=
ulti_io=2Ec<br>M src/openvpn/multi_io=2Eh<br>6 files changed, 27 insertions=
(+), 53 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/35/1635/5</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index d24f534=
=2E=2Ef2dc2da 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><b=
r><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -2030,9 +2030,8 @@=
</span><br><span>     check_timeout_random_component(c);</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_io_proc=
ess_flags(struct context *c, struct event_set *es, const unsigned int flags=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
   unsigned int *out_socket, unsigned int *out_tuntap)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+multi_io_process_flags(struct context *c, struct event_=
set *es, struct link_socket *sock, const unsigned int flags)</span><br><spa=
n> {</span><br><span>     unsigned int socket =3D 0;</span><br><span>     u=
nsigned int tuntap =3D 0;</span><br><span>@@ -2123,39 +2122,8 @@</span><br>=
<span>      * (for TCP server sockets this happens in</span><br><span>     =
 *  socket_set_listen_persistent())=2E</span><br><span>      */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; c-&g=
t;c1=2Elink_sockets_num; i++)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if ((c-&gt;options=2Emode !=3D MODE_SERVER) || (proto_is_dgram(c-&gt;c2=2El=
ink_sockets[i]-&gt;info=2Eproto)))</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            socket_set(c-&gt;c2=2Elink_sockets[i], es, socket, &amp;c-&gt;=
c2=2Elink_sockets[i]-&gt;ev_arg, NULL);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    socket_set(sock, es, sock=
et, &amp;sock-&gt;ev_arg, NULL);</span><br><span>     tun_set(c-&gt;c1=2Etu=
ntap, es, tuntap, (void *)tun_shift, NULL);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (out_socket)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *out_sock=
et =3D socket;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (out_tuntap)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        *out_tuntap =3D tuntap;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * Wait for I/O events=2E  Used for UDP sockets in=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * point-to-multipoin=
t mode=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-get_io_flags_udp(struct context *c, struct multi_io *multi_io, const=
 unsigned int flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int out_=
socket;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    multi_io_process_flags(c, multi=
_io-&gt;es, flags, &amp;out_socket, NULL);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    multi_io-&gt;udp_flags =3D (out_socket &lt;&lt; SO=
CKET_SHIFT);</span><br><span> }</span><br><span> </span><br><span> /*</span=
><br><span>@@ -2165,8 +2133,6 @@</span><br><span> void</span><br><span> io_=
wait(struct context *c, const unsigned int flags)</span><br><span> {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int out_socket;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int out_=
tuntap;</span><br><span>     struct event_set_return esr[4];</span><br><spa=
n> </span><br><span>     /* These shifts all depend on EVENT_READ and EVENT=
_WRITE */</span><br><span>@@ -2185,7 +2151,7 @@</span><br><span>      */</s=
pan><br><span>     event_reset(c-&gt;c2=2Eevent_set);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_io_process_flag=
s(c, c-&gt;c2=2Eevent_set, flags, &amp;out_socket, &amp;out_tuntap);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_io_process_flags=
(c, c-&gt;c2=2Eevent_set, c-&gt;c2=2Elink_sockets[0], flags);</span><br><sp=
an> </span><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)<=
/span><br><span>     if (c-&gt;c1=2Etuntap)</span><br><span>diff --git a/sr=
c/openvpn/forward=2Eh b/src/openvpn/forward=2Eh</span><br><span>index 0d3e4=
92=2E=2Ed4edfba 100644</span><br><span>--- a/src/openvpn/forward=2Eh</span>=
<br><span>+++ b/src/openvpn/forward=2Eh</span><br><span>@@ -68,7 +68,7 @@</=
span><br><span> </span><br><span> extern counter_type link_write_bytes_glob=
al;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
void get_io_flags_udp(struct context *c, struct multi_io *multi_io, const u=
nsigned int flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void multi_io_process_flags(struct context *c, struct event_set *es, struct=
 link_socket *sock, const unsigned int flags);</span><br><span> </span><br>=
<span> void io_wait(struct context *c, const unsigned int flags);</span><br=
><span> </span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mu=
dp=2Ec</span><br><span>index 432c79a=2E=2Ebb89221 100644</span><br><span>--=
- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><=
br><span>@@ -336,18 +336,17 @@</span><br><span>  * Process a UDP socket eve=
nt=2E</span><br><span>  */</span><br><span> void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-multi_process_io_udp(struct multi_context *m, st=
ruct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+multi_process_io_udp(struct multi_context *m, struct link_socket *sock,=
 unsigned int rwflags)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    const unsigned int status =3D m-&gt;multi_io-&gt;ud=
p_flags;</span><br><span>     const unsigned int mpp_flags =3D (MPP_PRE_SEL=
ECT | MPP_CLOSE_ON_SIGNAL);</span><br><span> </span><br><span>     /* UDP p=
ort ready to accept write */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (status &amp; SOCKET_WRITE)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (rwflags &amp; SOCKET_WRITE)</span><br><span> =
    {</span><br><span>         multi_process_outgoing_link(m, mpp_flags);</=
span><br><span>     }</span><br><span>     /* Incoming data on UDP port */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (status &a=
mp; SOCKET_READ)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else if (rwflags &amp; SOCKET_READ)</span><br><span>     {</span><br><span=
>         read_incoming_link(&amp;m-&gt;top, sock);</span><br><span>       =
  if (!IS_SIG(&amp;m-&gt;top))</span><br><span>@@ -355,25 +354,25 @@</span>=
<br><span>             multi_process_incoming_link(m, NULL, mpp_flags, sock=
);</span><br><span>         }</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    m-&gt;multi_io-&gt;udp_flags =3D ES_ERROR;</span><br><span> =
}</span><br><span> </span><br><span> /*</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * Return the io_wait() flags appropriate for</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Return the io flags appropri=
ate for</span><br><span>  * a point-to-multipoint tunnel=2E</span><br><span=
>  */</span><br><span> unsigned int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-p2mp_iow_flags(const struct multi_context *m)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+p2mp_iow_flags(const struct multi_c=
ontext *m, struct link_socket *sock)</span><br><span> {</span><br><span>   =
  unsigned int flags =3D IOW_WAIT_SIGNAL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>     if (m-&gt;pending)</span><br><s=
pan>     {</span><br><span>         if (TUN_OUT(&amp;m-&gt;pending-&gt;cont=
ext))</span><br><span>         {</span><br><span>             flags |=3D IO=
W_TO_TUN;</span><br><span>         }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (LINK_OUT(&amp;m-&gt;pending-&gt;context))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (LINK_OUT(&amp;m-&gt;pending-&gt;c=
ontext) &amp;&amp; m-&gt;pending-&gt;context=2Ec2=2Elink_sockets[0] =3D=3D =
sock)</span><br><span>         {</span><br><span>             flags |=3D IO=
W_TO_LINK;</span><br><span>         }</span><br><span>diff --git a/src/open=
vpn/mudp=2Eh b/src/openvpn/mudp=2Eh</span><br><span>index 005ee10=2E=2Edfc6=
9b9 100644</span><br><span>--- a/src/openvpn/mudp=2Eh</span><br><span>+++ b=
/src/openvpn/mudp=2Eh</span><br><span>@@ -30,9 +30,9 @@</span><br><span> st=
ruct context;</span><br><span> struct multi_context;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned int p2mp_iow_flag=
s(const struct multi_context *m);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+unsigned int p2mp_iow_flags(const struct multi_context *m, st=
ruct link_socket *sock);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void multi_process_io_udp(struct multi_context *m, str=
uct link_socket *sock);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void multi_process_io_udp(struct multi_context *m, struct link_socket *=
sock, unsigned int rwflags);</span><br><span> /****************************=
**********************************************/</span><br><span> /**</span>=
<br><span>  * Get, and if necessary create, the multi_instance associated w=
ith a</span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/m=
ulti_io=2Ec</span><br><span>index e6f4e9c=2E=2E1334a74 100644</span><br><sp=
an>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_i=
o=2Ec</span><br><span>@@ -171,7 +171,17 @@</span><br><span> </span><br><spa=
n>     if (has_udp_in_local_list(&amp;m-&gt;top=2Eoptions))</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        get_io=
_flags_udp(&amp;m-&gt;top, m-&gt;multi_io, p2mp_iow_flags(m));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt;=
 m-&gt;top=2Ec1=2Elink_sockets_num; i++)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            struct link_socket *sock =3D m-&gt;top=2Ec2=2Elink_s=
ockets[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if ((m-&gt;top=
=2Eoptions=2Emode =3D=3D MODE_SERVER) &amp;&amp; proto_is_dgram(sock-&gt;in=
fo=2Eproto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   unsigned int flags =3D p2mp_iow_flags(m, sock);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                multi_io_process_flags(&amp;m-&gt;top, m-&gt;mu=
lti_io-&gt;es, sock, flags);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span>     }</span><br><span> </span><br><span>     =
tun_set(m-&gt;top=2Ec1=2Etuntap, m-&gt;multi_io-&gt;es, EVENT_READ, MULTI_I=
O_TUN, persistent);</span><br><span>@@ -457,7 +467,7 @@</span><br><span>   =
                  }</span><br><span>                     else</span><br><sp=
an>                     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                        multi_process_io_udp(m, ev_arg-&gt;u=2Esock);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   multi_process_io_udp(m, ev_arg-&gt;u=2Esock, e-&gt;rwflags);</span><br><=
span>                         mi =3D m-&gt;pending;</span><br><span>       =
              }</span><br><span>                     /* monitor and/or hand=
le events that are</span><br><span>diff --git a/src/openvpn/multi_io=2Eh b/=
src/openvpn/multi_io=2Eh</span><br><span>index 6b2f59a=2E=2Ed6734bd 100644<=
/span><br><span>--- a/src/openvpn/multi_io=2Eh</span><br><span>+++ b/src/op=
envpn/multi_io=2Eh</span><br><span>@@ -55,7 +55,6 @@</span><br><span>     i=
nt n_esr;</span><br><span>     int maxevents;</span><br><span>     unsigned=
 int tun_rwflags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
unsigned int udp_flags;</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br=
><span>     unsigned int management_persist_flags;</span><br><span> #endif<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail">change 1635</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6b303805a3688b6f6=
363140c76853a58badecd8f </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1635 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<=
div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;g=
ert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>

</body></html>
--qW6Ir226krQ=--


--===============4258624391902863862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4258624391902863862==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4258624391902863862==--

