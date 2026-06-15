Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99028CD98C7
	for <openvpn-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SnNDdNVJVlDhd7Um4yXi9r8/o/AO1LChIkPaB+F6HNY=; b=WKz8cScZcrlg1woBcBzfTiMEWO
	3kB3ppXbVr2miRLpyF+JGIHTOvyL7SMPBupdwoYvjgaF6TFPTy6mRkFCKwTwogA5pnMbPFc0zpdFy
	VeYJUcyoGC8FFjLN2i0O0ndgBo8G3nDN5xstMrtgZ9lvVTrbT4LhlNK1plM14ekqaJWU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wZ4uK-0003au-C3;
	Mon, 15 Jun 2026 10:51:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wZ4uG-0003am-KA
 for openvpn-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 10:51:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Oi+sdt6gbv+ZuXxi2pI4SQ7EFprWdCFsdVNlBMZku6U=; b=modfr/NhHkbmWzIbqfwcjVyfvD
 gQjKGFgDQy04Y98sR5IpTqlL8aGE5B59zal9fXOokSPu31ymjYvwzlYhPj0mfXLpeUFZMBhFBth9X
 q5sLKCnUgCgQ1EwiPYGH40JqGToGwKpd5UWRfskzPWdCU5h7hHuv4tL86oIKDQFJZwBk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Oi+sdt6gbv+ZuXxi2pI4SQ7EFprWdCFsdVNlBMZku6U=; b=W
 7bu3NrdO332sKgKSWcrAA80sNegCYKXYC/72CPxGc8uKhJHEsEU8xaA9U62vhi/OM/xc6NVcUi0h5
 7VwqyPLLD9PJrKgPb5O+ot9XdWqfT+HhAjkSUoHgi6RPOaC0L9FGfEdhGvxIR+AUQzTIWKJAGgKh7
 Dn3B969xRDvM0h0A=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wZ4uC-0006ac-EG for openvpn-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 10:51:04 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4905529b933so32032405e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 15 Jun 2026 03:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781520649; x=1782125449; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oi+sdt6gbv+ZuXxi2pI4SQ7EFprWdCFsdVNlBMZku6U=;
 b=Vb3yFgAmUL80nKpfp++WS/yUdv/ZQXK3+3tOXsyZzOEOzQYLcnNzuPMZCDGg+W4rql
 DrQ0RfORryIkUVWBwkcdrSGo6sj9hclXAzk4yntdYwJKb90i74G9/fvhHJQNcwAoczgM
 E13sCUaE+SQ7V6p9N2WinEEsDtpzLBs6bXPjtIIJ4j/kMYM1rjLOYwcwb6ThkrcKRtnd
 hrTv6OX+ua9RqOWiMjMoxD2Ir0LJpWG/OlJ8g8taeQvIdyv9q5gBmtcXx8IuzLR+GDPB
 R7Q/1DvV8DfZn2Hilxu3QKLmEWxx9DruzOfs61QINhR/+2NxRTgdQRy07p0TKPuCJruq
 HudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781520649; x=1782125449;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oi+sdt6gbv+ZuXxi2pI4SQ7EFprWdCFsdVNlBMZku6U=;
 b=hVl4mTzyYlbPyT/6nMBF+SYcTCNW7gnl/3AF3QPBhpi2OhCCVr/pOW8IxOcqY6Ny/K
 QrvQpBVj2pRxtLCNnhgrN32hC1xPYIKi3eC0Gl489gFAhcy9Cqxa16dwp6Jcqy5nih2U
 qDBhSF9EAbAvnq9Paj5UvQtCQwfNCqA214atg4PYbxsDvD5b3YRUr2zJ+v9zmF6ILF0n
 CQIZI3zC71kwrah03iybd6ijd4u/jm1AW7Nv3fx0pS8IeCUZJYkjG67HmAqXQ/dVbrqy
 CNZ04R/eQ+IZIz0THhNM1yqTANeISawpJcEkoTASBnIyXzO61CDsi9Hld+uY2sjnre2f
 inbw==
X-Gm-Message-State: AOJu0YxS0QEG5Cla8bTInkbPHGY1ieSTQRDDnHm/Zy8x6lAPfbAuNY29
 oOizviqmzvJmIDMIToTPbJcvFSmgJ36Zh+rRNfCCkqWmmjriVGUoLrpVu1U7WZD6jNegfij1kir
 Hs1wz+eUixXYcWysJ+CuuYE4L0nYCRZmfwORVvfQ6XQ4vwuwumemV/uxMW/9ZyCYdlVGq
X-Gm-Gg: Acq92OGxgZ6qBflsgDeRDCiWFG4xVAH+RIKOMLtbxZHOvvNQ4xmxNv+LFb08itQFEqx
 pI//SfFnJg6VIWy5ON4xFnRWIGLdYiAEvHIwzbwOBbN8HuF2+eUb/IoZoZ+bMJYF2BGsxOMEcV6
 9F3YP//YdFETOcf5t+QCaaMfVnkBV4Hvp5FPup6k4UGTmA0zC0d0GtCbQyTk/aSonNVLtGAGsDe
 qsM2AkwB9lFF7oey3778mbVh8CuXI1RmsTiMRRpaQkpNB2OWl6S3qxha5Ho6Tywxhylu+JPZmMM
 HbrVJWJ4tvJR4eipJiqHmE8V2jv0u6saX42sm8PthGw0evesT+pgagos/Mhe3optN5e4z8xB3Gn
 r0RMVpR8KAHobOqacWKzS1+B8KDwNjuTZSxP3yyQVGtx11c6m360pD3jKVOAK3YMF9K93TyCpOy
 S/crTj7WaoLphSm/sTB3N9mFXUfskjvTXCkNX8ipLNPz+tv8ng/AojWe/Dokha79jJJC7AL5GPu
 k+U2cLdBid4uV7u3KyAbH3xJyPehhA5z43WwQvuNND82HpliMOX3awgcg0DRgm2wofIIvVoZw4e
 L+TmSWvBfgTHPw==
X-Received: by 2002:a05:600c:3513:b0:490:ae94:a7e6 with SMTP id
 5b1f17b1804b1-490ec4ee41fmr176979905e9.24.1781520649049; 
 Mon, 15 Jun 2026 03:50:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922033dd59sm232101585e9.9.2026.06.15.03.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 03:50:48 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 15 Jun 2026 10:50:45 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
X-Gerrit-Change-Number: 1635
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1635?usp=email>
X-Gerrit-Commit: 9293beb911e4618a0cdaa9a81384a96b4acb46fd
In-Reply-To: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
References: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzgzMTAwMDAwLkk2YjMwMzgwNWEzNjg4YjZmNjM2MzE0MGM3Njg1M2E1OGJhZGVjZDhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <da05b50c42dab0986486527d8bc78dbc828b423a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wZ4uC-0006ac-EG
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
Content-Type: multipart/mixed; boundary="===============0126515305140455451=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0126515305140455451==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZF5LBIHmtW8="; charset=UTF-8

--ZF5LBIHmtW8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos=2E

Hello cro=
n2, ordex, plaisthos, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail

to look at=
 the new patch set (#7)=2E


Change subject: Multisocket: use event engine =
rwflags for UDP I/O
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Multisocket: use event engine rwflags for UDP I/O

udp_flags does n=
ot guarantee correct association with the socket being
processed=2E Use the=
 rwflags delivered by the event engine along with the
event to ensure prope=
r per-socket I/O handling=2E

Remove udp_flags entirely=2E

Replace the pre=
vious global-style flag computation with a per-socket
decision model in p2m=
p_iow_flags(), which derives I/O flags
directly from the current multi_cont=
ext state and the specific socket
being processed=2E This ensures that read=
/write decisions are correctly
bound to the active socket rather than share=
d or implicit global state=2E

This change is based on an investigation tri=
ggered by a report from
Joshua Rogers using ZeroPath=2E

Change-Id: I6b3038=
05a3688b6f6363140c76853a58badecd8f
Signed-off-by: Gianmarco De Gregori <gia=
nmarco@mandelbit=2Ecom>
---
M src/openvpn/forward=2Ec
M src/openvpn/forward=
=2Eh
M src/openvpn/mudp=2Ec
M src/openvpn/mudp=2Eh
M src/openvpn/multi_io=
=2Ec
M src/openvpn/multi_io=2Eh
6 files changed, 74 insertions(+), 83 delet=
ions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/35/1635/7

diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec=

index d24f534=2E=2Eab76b9e 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/=
openvpn/forward=2Ec
@@ -2030,9 +2030,8 @@
     check_timeout_random_compone=
nt(c);
 }
 
-static void
-multi_io_process_flags(struct context *c, struct =
event_set *es, const unsigned int flags,
-                       unsigned i=
nt *out_socket, unsigned int *out_tuntap)
+void
+multi_io_process_flags(str=
uct context *c, struct event_set *es, struct link_socket *sock, const unsig=
ned int flags)
 {
     unsigned int socket =3D 0;
     unsigned int tuntap =
=3D 0;
@@ -2123,50 +2122,19 @@
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
 }
 
 /*
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
-}
-
-/*
- * This is the core I/O wait function, used f=
or all I/O waits except
- * for the top-level server sockets=2E
+ * This is=
 the core I/O wait function, used for all I/O waits=2E
+ *
+ * Invoked by P=
2P instances in tunnel_point_to_point() or by P2MP
+ * instances within the=
 per-client context in multi_io=2Ec=2E
  */
 void
 io_wait(struct context *=
c, const unsigned int flags)
 {
-    unsigned int out_socket;
-    unsigned=
 int out_tuntap;
     struct event_set_return esr[4];
 
     /* These shift=
s all depend on EVENT_READ and EVENT_WRITE */
@@ -2185,7 +2153,7 @@
      *=
/
     event_reset(c->c2=2Eevent_set);
 
-    multi_io_process_flags(c, c->=
c2=2Eevent_set, flags, &out_socket, &out_tuntap);
+    multi_io_process_fla=
gs(c, c->c2=2Eevent_set, c->c2=2Elink_sockets[0], flags);
 
 #if defined(TA=
RGET_LINUX) || defined(TARGET_FREEBSD)
     if (c->c1=2Etuntap)
diff --git =
a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh
index 0d3e492=2E=2E324c=
0b4 100644
--- a/src/openvpn/forward=2Eh
+++ b/src/openvpn/forward=2Eh
@@ -=
68,7 +68,22 @@
 
 extern counter_type link_write_bytes_global;
 
-void get_=
io_flags_udp(struct context *c, struct multi_io *multi_io, const unsigned i=
nt flags);
+/**
+ * @brief Processes I/O flags to configure socket and TUN/=
TAP event monitors=2E
+ *
+ * Evaluates the current I/O state (`flags`) and=
 context mode to determine
+ * which READ or WRITE events to register in th=
e event loop=2E
+ *
+ * @note This function gets called from client instanc=
es from @c io_wait()
+ * and from p2mp (Point-to-multipoint) instances in @=
c multi_io_wait()=2E
+ *
+ * @param c      Pointer to the core context=2E
+=
 * @param es     The event set where descriptors are registered=2E
+ * @par=
am sock   The link socket to configure=2E
+ * @param flags  Bitmask of acti=
ve I/O operation requests (e=2Eg=2E, @ref IOW_TO_LINK,
+ * @ref IOW_READ_TU=
N, @ref IOW_TO_TUN, @ref IOW_SHAPER)=2E
+ */
+void multi_io_process_flags(s=
truct context *c, struct event_set *es, struct link_socket *sock, const uns=
igned int flags);
 
 void io_wait(struct context *c, const unsigned int fla=
gs);
 
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index dded1=
ee=2E=2E143a330 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2E=
c
@@ -340,18 +340,17 @@
  * Process a UDP socket event=2E
  */
 void
-multi=
_process_io_udp(struct multi_context *m, struct link_socket *sock)
+multi_p=
rocess_io_udp(struct multi_context *m, struct link_socket *sock, unsigned i=
nt rwflags)
 {
-    const unsigned int status =3D m->multi_io->udp_flags;
 =
    const unsigned int mpp_flags =3D (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL)=
;
 
     /* UDP port ready to accept write */
-    if (status & SOCKET_WRIT=
E)
+    if (rwflags & SOCKET_WRITE)
     {
         multi_process_outgoing_=
link(m, mpp_flags);
     }
     /* Incoming data on UDP port */
-    else i=
f (status & SOCKET_READ)
+    else if (rwflags & SOCKET_READ)
     {
      =
   read_incoming_link(&m->top, sock);
         if (!IS_SIG(&m->top))
@@ -35=
9,36 +358,4 @@
             multi_process_incoming_link(m, NULL, mpp_flags,=
 sock);
         }
     }
-
-    m->multi_io->udp_flags =3D ES_ERROR;
-}
-
=
-/*
- * Return the io_wait() flags appropriate for
- * a point-to-multipoin=
t tunnel=2E
- */
-unsigned int
-p2mp_iow_flags(const struct multi_context *=
m)
-{
-    unsigned int flags =3D IOW_WAIT_SIGNAL;
-    if (m->pending)
-  =
  {
-        if (TUN_OUT(&m->pending->context))
-        {
-            fla=
gs |=3D IOW_TO_TUN;
-        }
-        if (LINK_OUT(&m->pending->context))=

-        {
-            flags |=3D IOW_TO_LINK;
-        }
-    }
-    els=
e if (mbuf_defined(m->mbuf))
-    {
-        flags |=3D IOW_MBUF;
-    }
- =
   else
-    {
-        flags |=3D IOW_READ;
-    }
-    return flags;
 }
d=
iff --git a/src/openvpn/mudp=2Eh b/src/openvpn/mudp=2Eh
index 005ee10=2E=2E=
6567539 100644
--- a/src/openvpn/mudp=2Eh
+++ b/src/openvpn/mudp=2Eh
@@ -30=
,9 +30,7 @@
 struct context;
 struct multi_context;
 
-unsigned int p2mp_io=
w_flags(const struct multi_context *m);
-
-void multi_process_io_udp(struct=
 multi_context *m, struct link_socket *sock);
+void multi_process_io_udp(st=
ruct multi_context *m, struct link_socket *sock, unsigned int rwflags);
 /*=
*************************************************************************/
=
 /**
  * Get, and if necessary create, the multi_instance associated with a=

diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
index e6f=
4e9c=2E=2Ed8cc708 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/m=
ulti_io=2Ec
@@ -154,6 +154,40 @@
     }
 }
 
+/*
+ * Return the io flags ap=
propriate for
+ * a point-to-multipoint tunnel=2E
+ */
+static unsigned int=

+p2mp_iow_flags(const struct multi_context *m, struct link_socket *sock)
+=
{
+    unsigned int flags =3D IOW_WAIT_SIGNAL;
+
+    if (m->pending)
+    =
{
+        if (TUN_OUT(&m->pending->context))
+        {
+            flags=
 |=3D IOW_TO_TUN;
+        }
+
+        /* If the to be processed socket ha=
ppens to be the same one on the pending
+         * UDP client instance, we=
 set that socket ready for write */
+        if (LINK_OUT(&m->pending->cont=
ext) && m->pending->context=2Ec2=2Elink_sockets[0] =3D=3D sock)
+        {
=
+            flags |=3D IOW_TO_LINK;
+        }
+    }
+    else if (mbuf_d=
efined(m->mbuf))
+    {
+        flags |=3D IOW_MBUF;
+    }
+    else
+   =
 {
+        flags |=3D IOW_READ;
+    }
+    return flags;
+}
+
 int
 multi=
_io_wait(struct multi_context *m)
 {
@@ -171,7 +205,17 @@
 
     if (has_ud=
p_in_local_list(&m->top=2Eoptions))
     {
-        get_io_flags_udp(&m->to=
p, m->multi_io, p2mp_iow_flags(m));
+        for (int i =3D 0; i < m->top=
=2Ec1=2Elink_sockets_num; i++)
+        {
+            struct link_socket *=
sock =3D m->top=2Ec2=2Elink_sockets[i];
+
+            if ((m->top=2Eoption=
s=2Emode =3D=3D MODE_SERVER) && proto_is_dgram(sock->info=2Eproto))
+      =
      {
+                unsigned int flags =3D p2mp_iow_flags(m, sock);
+
=
+                multi_io_process_flags(&m->top, m->multi_io->es, sock, fla=
gs);
+            }
+        }
     }
 
     tun_set(m->top=2Ec1=2Etuntap, =
m->multi_io->es, EVENT_READ, MULTI_IO_TUN, persistent);
@@ -457,7 +501,7 @@=

                     }
                     else
                     {
- =
                       multi_process_io_udp(m, ev_arg->u=2Esock);
+        =
                multi_process_io_udp(m, ev_arg->u=2Esock, e->rwflags);
    =
                     mi =3D m->pending;
                     }
            =
         /* monitor and/or handle events that are
diff --git a/src/openvpn/=
multi_io=2Eh b/src/openvpn/multi_io=2Eh
index 6b2f59a=2E=2Ed6734bd 100644
-=
-- a/src/openvpn/multi_io=2Eh
+++ b/src/openvpn/multi_io=2Eh
@@ -55,7 +55,6=
 @@
     int n_esr;
     int maxevents;
     unsigned int tun_rwflags;
-   =
 unsigned int udp_flags;
 #ifdef ENABLE_MANAGEMENT
     unsigned int manage=
ment_persist_flags;
 #endif

-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1635?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
Gerrit-Change-Number: =
1635
Gerrit-PatchSet: 7
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>=

Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: ordex <a=
ntonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cro=
n2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: ordex <antonio@mandelbit=2Ec=
om>

--ZF5LBIHmtW8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, ordex, plaisthos=2E </p>
<p>its_Giaan <strong>=
uploaded patch set #7</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Multisocket: use event engine rwflags for UDP I/O<br><br>udp_flags=
 does not guarantee correct association with the socket being<br>processed=
=2E Use the rwflags delivered by the event engine along with the<br>event t=
o ensure proper per-socket I/O handling=2E<br><br>Remove udp_flags entirely=
=2E<br><br>Replace the previous global-style flag computation with a per-so=
cket<br>decision model in p2mp_iow_flags(), which derives I/O flags<br>dire=
ctly from the current multi_context state and the specific socket<br>being =
processed=2E This ensures that read/write decisions are correctly<br>bound =
to the active socket rather than shared or implicit global state=2E<br><br>=
This change is based on an investigation triggered by a report from<br>Josh=
ua Rogers using ZeroPath=2E<br><br>Change-Id: I6b303805a3688b6f6363140c7685=
3a58badecd8f<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=
=2Ecom&gt;<br>---<br>M src/openvpn/forward=2Ec<br>M src/openvpn/forward=2Eh=
<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/mudp=2Eh<br>M src/openvpn/multi=
_io=2Ec<br>M src/openvpn/multi_io=2Eh<br>6 files changed, 74 insertions(+),=
 83 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/35/1635/7</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index d24f534=2E=2E=
ab76b9e 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><spa=
n>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -2030,9 +2030,8 @@</span=
><br><span>     check_timeout_random_component(c);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_io_process_fl=
ags(struct context *c, struct event_set *es, const unsigned int flags,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                       uns=
igned int *out_socket, unsigned int *out_tuntap)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+multi_io_process_flags(struct context *c, struct event_set *e=
s, struct link_socket *sock, const unsigned int flags)</span><br><span> {</=
span><br><span>     unsigned int socket =3D 0;</span><br><span>     unsigne=
d int tuntap =3D 0;</span><br><span>@@ -2123,50 +2122,19 @@</span><br><span=
>      * (for TCP server sockets this happens in</span><br><span>      *  s=
ocket_set_listen_persistent())=2E</span><br><span>      */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; c-&gt;c1=
=2Elink_sockets_num; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
(c-&gt;options=2Emode !=3D MODE_SERVER) || (proto_is_dgram(c-&gt;c2=2Elink_=
sockets[i]-&gt;info=2Eproto)))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         socket_set(c-&gt;c2=2Elink_sockets[i], es, socket, &amp;c-&gt;c2=
=2Elink_sockets[i]-&gt;ev_arg, NULL);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    socket_set(sock, es, socket=
, &amp;sock-&gt;ev_arg, NULL);</span><br><span>     tun_set(c-&gt;c1=2Etunt=
ap, es, tuntap, (void *)tun_shift, NULL);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (out_socket)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *out_socket=
 =3D socket;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (out_tuntap)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        *out_tuntap =3D tuntap;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span> }</span><br><span> </span><br><=
span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Wait for I=
/O events=2E  Used for UDP sockets in</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * point-to-multipoint mode=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-get_io_flags_udp(struct context=
 *c, struct multi_io *multi_io, const unsigned int flags)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    unsigned int out_socket;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    multi_io_process_flags(c, multi_io-&gt;es, flags, &amp;out_socket, NU=
LL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_io-&gt;=
udp_flags =3D (out_socket &lt;&lt; SOCKET_SHIFT);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * This is the core I/O wait fun=
ction, used for all I/O waits except</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * for the top-level server sockets=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * This is the core I/O wait function, us=
ed for all I/O waits=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Invoked by=
 P2P instances in tunnel_point_to_point() or by P2MP</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * instances within the per-client contex=
t in multi_io=2Ec=2E</span><br><span>  */</span><br><span> void</span><br><=
span> io_wait(struct context *c, const unsigned int flags)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int ou=
t_socket;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned=
 int out_tuntap;</span><br><span>     struct event_set_return esr[4];</span=
><br><span> </span><br><span>     /* These shifts all depend on EVENT_READ =
and EVENT_WRITE */</span><br><span>@@ -2185,7 +2153,7 @@</span><br><span>  =
    */</span><br><span>     event_reset(c-&gt;c2=2Eevent_set);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_io_pro=
cess_flags(c, c-&gt;c2=2Eevent_set, flags, &amp;out_socket, &amp;out_tuntap=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_io_proc=
ess_flags(c, c-&gt;c2=2Eevent_set, c-&gt;c2=2Elink_sockets[0], flags);</spa=
n><br><span> </span><br><span> #if defined(TARGET_LINUX) || defined(TARGET_=
FREEBSD)</span><br><span>     if (c-&gt;c1=2Etuntap)</span><br><span>diff -=
-git a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh</span><br><span>in=
dex 0d3e492=2E=2E324c0b4 100644</span><br><span>--- a/src/openvpn/forward=
=2Eh</span><br><span>+++ b/src/openvpn/forward=2Eh</span><br><span>@@ -68,7=
 +68,22 @@</span><br><span> </span><br><span> extern counter_type link_writ=
e_bytes_global;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void get_io_flags_udp(struct context *c, struct multi_io *multi=
_io, const unsigned int flags);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
brief Processes I/O flags to configure socket and TUN/TAP event monitors=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Evaluates the current I/O state (=
`flags`) and context mode to determine</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * which READ or WRITE events to register in the event l=
oop=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @note This function gets ca=
lled from client instances from @c io_wait()</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * and from p2mp (Point-to-multipoint) instances i=
n @c multi_io_wait()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c  =
    Pointer to the core context=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param es     The event set where descriptors are registe=
red=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param soc=
k   The link socket to configure=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param flags  Bitmask of active I/O operation requests (=
e=2Eg=2E, @ref IOW_TO_LINK,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @ref IOW_READ_TUN, @ref IOW_TO_TUN, @ref IOW_SHAPER)=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void multi_io_process_flags(struct context *=
c, struct event_set *es, struct link_socket *sock, const unsigned int flags=
);</span><br><span> </span><br><span> void io_wait(struct context *c, const=
 unsigned int flags);</span><br><span> </span><br><span>diff --git a/src/op=
envpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index dded1ee=2E=2E14=
3a330 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++=
 b/src/openvpn/mudp=2Ec</span><br><span>@@ -340,18 +340,17 @@</span><br><sp=
an>  * Process a UDP socket event=2E</span><br><span>  */</span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_process_io_=
udp(struct multi_context *m, struct link_socket *sock)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+multi_process_io_udp(struct multi_contex=
t *m, struct link_socket *sock, unsigned int rwflags)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    const unsigned int s=
tatus =3D m-&gt;multi_io-&gt;udp_flags;</span><br><span>     const unsigned=
 int mpp_flags =3D (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span>=
 </span><br><span>     /* UDP port ready to accept write */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (status &amp; SOCKET_WRITE)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rwflags &amp; =
SOCKET_WRITE)</span><br><span>     {</span><br><span>         multi_process=
_outgoing_link(m, mpp_flags);</span><br><span>     }</span><br><span>     /=
* Incoming data on UDP port */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    else if (status &amp; SOCKET_READ)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    else if (rwflags &amp; SOCKET_READ)</span><=
br><span>     {</span><br><span>         read_incoming_link(&amp;m-&gt;top,=
 sock);</span><br><span>         if (!IS_SIG(&amp;m-&gt;top))</span><br><sp=
an>@@ -359,36 +358,4 @@</span><br><span>             multi_process_incoming=
_link(m, NULL, mpp_flags, sock);</span><br><span>         }</span><br><span=
>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;multi_io-&gt;udp_flags =
=3D ES_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * Return the io_wait() flags appropriate for</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * a point-to-multipoint tunnel=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-unsigned int</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-p2mp_iow_flags(const struct multi_context *m)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    unsigned int flags =3D IOW_WAIT_SIGNAL;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (m-&gt;pending)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (TUN_OUT(&amp;m-&gt;pending-&gt;con=
text))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            flags |=3D IOW_=
TO_TUN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (LINK_OUT(&amp;=
m-&gt;pending-&gt;context))</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      flags |=3D IOW_TO_LINK;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (mbuf_de=
fined(m-&gt;mbuf))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        flags |=3D =
IOW_MBUF;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        flags |=3D IOW_READ;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    return flags;</span><br><span> }</span><br><span>diff --git a/=
src/openvpn/mudp=2Eh b/src/openvpn/mudp=2Eh</span><br><span>index 005ee10=
=2E=2E6567539 100644</span><br><span>--- a/src/openvpn/mudp=2Eh</span><br><=
span>+++ b/src/openvpn/mudp=2Eh</span><br><span>@@ -30,9 +30,7 @@</span><br=
><span> struct context;</span><br><span> struct multi_context;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned int p2m=
p_iow_flags(const struct multi_context *m);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void multi_process_io_udp(struct multi_context *m, struct link_socket *soc=
k);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void multi_proce=
ss_io_udp(struct multi_context *m, struct link_socket *sock, unsigned int r=
wflags);</span><br><span> /************************************************=
**************************/</span><br><span> /**</span><br><span>  * Get, a=
nd if necessary create, the multi_instance associated with a</span><br><spa=
n>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><b=
r><span>index e6f4e9c=2E=2Ed8cc708 100644</span><br><span>--- a/src/openvpn=
/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><spa=
n>@@ -154,6 +154,40 @@</span><br><span>     }</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the io flags approp=
riate for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * a point=
-to-multipoint tunnel=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static unsi=
gned int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+p2mp_iow_fl=
ags(const struct multi_context *m, struct link_socket *sock)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    unsigned int flags =3D IOW_WAIT_SIGNAL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (m-&gt;pending)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (TUN_OUT(&amp;m-&gt;pending-&gt;context))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            flags |=3D IOW_TO_TUN;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* If the to be processed socket happens =
to be the same one on the pending</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * UDP client instance, we set that socket ready for =
write */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(LINK_OUT(&amp;m-&gt;pending-&gt;context) &amp;&amp; m-&gt;pending-&gt;cont=
ext=2Ec2=2Elink_sockets[0] =3D=3D sock)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            flags |=3D IOW_TO_LINK;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else if (mbuf_defined(m-&gt;mbuf))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        flags |=3D IOW_MBUF;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        flags |=3D IOW_=
READ;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return flags;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> multi_io_=
wait(struct multi_context *m)</span><br><span> {</span><br><span>@@ -171,7 =
+205,17 @@</span><br><span> </span><br><span>     if (has_udp_in_local_list=
(&amp;m-&gt;top=2Eoptions))</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        get_io_flags_udp(&amp;m-&gt;top, m-&gt=
;multi_io, p2mp_iow_flags(m));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        for (int i =3D 0; i &lt; m-&gt;top=2Ec1=2Elink_sockets_n=
um; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct li=
nk_socket *sock =3D m-&gt;top=2Ec2=2Elink_sockets[i];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if ((m-&gt;top=2Eoptions=2Emode =3D=3D MODE_SERV=
ER) &amp;&amp; proto_is_dgram(sock-&gt;info=2Eproto))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                unsigned int flags =3D p2mp_iow=
_flags(m, sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                multi_=
io_process_flags(&amp;m-&gt;top, m-&gt;multi_io-&gt;es, sock, flags);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     =
}</span><br><span> </span><br><span>     tun_set(m-&gt;top=2Ec1=2Etuntap, m=
-&gt;multi_io-&gt;es, EVENT_READ, MULTI_IO_TUN, persistent);</span><br><spa=
n>@@ -457,7 +501,7 @@</span><br><span>                     }</span><br><spa=
n>                     else</span><br><span>                     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                        multi_=
process_io_udp(m, ev_arg-&gt;u=2Esock);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                        multi_process_io_udp(m, ev_arg-=
&gt;u=2Esock, e-&gt;rwflags);</span><br><span>                         mi =
=3D m-&gt;pending;</span><br><span>                     }</span><br><span> =
                    /* monitor and/or handle events that are</span><br><spa=
n>diff --git a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh</span><b=
r><span>index 6b2f59a=2E=2Ed6734bd 100644</span><br><span>--- a/src/openvpn=
/multi_io=2Eh</span><br><span>+++ b/src/openvpn/multi_io=2Eh</span><br><spa=
n>@@ -55,7 +55,6 @@</span><br><span>     int n_esr;</span><br><span>     in=
t maxevents;</span><br><span>     unsigned int tun_rwflags;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    unsigned int udp_flags;</span><br=
><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     unsigned int manageme=
nt_persist_flags;</span><br><span> #endif</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635=
?usp=3Demail">change 1635</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1635?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchse=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1635 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerri=
t-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron=
2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--ZF5LBIHmtW8=--


--===============0126515305140455451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0126515305140455451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0126515305140455451==--

