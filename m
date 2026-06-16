Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EDCCD98E1
	for <openvpn-devel@archiver.kernel.org>; Tue, 16 Jun 2026 20:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wtv/+m6wV5udz1SxcTaqWw6AIFu4BFL9e5y9HOUPBlM=; b=T6UYct42bxp+V+oOuLXgIstIz/
	/Z4himDkx7S9EddjkH16FOxh6G4BAVOClegzcWQlGqZpvyv6xyt5qeyIneS9PgoknqSeC6ZosUWyL
	Kl4AWKGrnFfmJjbLyjIvN7NTtYieXyrsByVQpdxmYcc4w6pnwbrqB07OpZjexiUb50wc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wZaHl-0002e5-3l;
	Tue, 16 Jun 2026 20:21:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wZaHj-0002dw-VV
 for openvpn-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 20:21:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HJYBolctq8fJ+tTOaR8g/HjPr3qVFoRm3i6e3LW0URw=; b=iOS1QQ+DeJyU8RYmggtQFfVEGq
 QLNXqHQm+/RZG8zf+0MziXsYBcxb5QvnrogDe+n6hTm2wFZhd6no8ci9nRpj1rhscAPxhUoUG8vtd
 BSgjtamlr867/ZU/Ybq3WxKqm+oo1L6tYAYSotGPbw6PgRc4f04LNBBMBx15d99yjaMU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HJYBolctq8fJ+tTOaR8g/HjPr3qVFoRm3i6e3LW0URw=; b=b
 cTpNZcah9aPlTAkwzuX4lI315eDvoXs9qPu/WXlhmlKni7UrPmtJaPEeUUeXtdxv2erB2zj7oE5hp
 mU9UZK7dlcVN1uloKG3Njap8BdyGRtz7pBpl+glQ42QrwrU+TS/gPw4IzYKJLmecEZ++eUnAV9Yly
 2UdQ86F27Pr7cu3g=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wZaHe-0000Nb-VH for openvpn-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 20:21:21 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so3692009f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 16 Jun 2026 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781641273; x=1782246073; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HJYBolctq8fJ+tTOaR8g/HjPr3qVFoRm3i6e3LW0URw=;
 b=SYaSbSS/vgrcBFFwEe4LL+FaOctuviIgWXAan/scQFZMUDWeyGV7FEggkbBJw8dI5Y
 TSBzLF+26xZGMM+/+4nDyujwR3TiFMXrONA5EfI31jFBfAOm3Z8Kk6CNQEfibPIsxT9Y
 hlIseUfWswLx0LilnnULjamZwVyRn7LbpMBf9cTPgCBjq+5NZ14y8I5iQVckdUgV6rfe
 FuznBdpy9XL5eZqFKzT+aUBuCeSzGAgENoCHHo1Sd6MiAlZPEPqNByNGyDESB8ewAbVA
 wQ+rE1FtqhhaQIxJaOsrxo55naOifuEsG3PBoTr5CcjTYfrRQPXjymsNjo/VXrkyXcU9
 h+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781641273; x=1782246073;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HJYBolctq8fJ+tTOaR8g/HjPr3qVFoRm3i6e3LW0URw=;
 b=Ngv6m6Kq7xCL9pMkY6+M41iTKCoupvfK+bNzBr0ICt98sdjJpj86eAYMCTl7iDEJ+Z
 1sSJpOSLw4r4phH9xdIPgEOnrZ2bh4MMfFWtdppJMSfr7rao2Fh70qiSA6lCJDVh6eKq
 UqfB4psbp8D7GDo1tQaIOUF9JMqxAMVc3wv/g0Df0Ct8AxAdhtafTi1VbPRQ6fpPke9v
 cvzsqqcmjaEqI8Y3fgCgHJtbbfFJMJxbocrChsWWgN1UBch/oq8+BlAm/mcuYBhbuqmM
 wgP2Sbz0J29cJl9//6o2ugmzHGnPKOqtGgrSVJlrLDtOL7kxHDYeyYmNzjFMXQoybuym
 FaYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8x/esT5RQdhz7qzh/sbl5KiqC+x2QXYbcm4ONZs4pYpE/gkhbhqXJ3+3UHo0jyzWidBmdzRash1ht9Tjvz@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy9kt5J5eIhFVRY0LauZkrkaViKqMu63CqRQZitLS0RJBLbm64k
 dnDTPtz38ouoIor1BvyY1olAAZPAYnXHrm30q5kfrMPKsHzJIh3psIVZH3zjBVnQqFmYBXDu33y
 SyLO5dfeszM1gQ0uNFvOcQw4J/ro6L3niBi9RTDXqcye8nsCmivxP4jKoHs4rfsA7Y4jj
X-Gm-Gg: Acq92OEkZfXu7v+ogv+OE7nkcMQsRUcxescqn/pDuR9H3qz/Q5Dt7+E4n11yL6ClD4F
 ty/4NBokfU/tzV6+/iv001pG57dB6Sw9X0DXfIQxhp1liBNdBOUOFdY43EO2pkL/TCnbNQe1mHk
 bOdb28Ka1pJTg5Kq2bud3Tj/PH2oFyjNKIg2jQ8BGL4wdqxDVKBMhnF6Obvik66Td8zlANVLa8W
 Vx6h4sxU9gMjUUO9anj28qnCcFY6Rg745CnfHE3cqPJqBP/R8tTm+ajcV+EDTmufY7ame9tPTmq
 HqpCHqZI6mc/9uU0UXRdC/Zr2n+CZ8793Is89jdy5gX4PA4i2I5wYZOzlmtzuXjtZoVgIhTABYc
 CvH62ApQnOUQ/lFLd6RNW7tzhwSSzbQU5/ePAntA6V2B7MrPmnmgl3WnV0cBS429qX7ukpEvI3o
 XvmohSkDjJ0Eqf3UAr+bYUn9SphAkuvOLpBhla7S7tgXSLSWK48khk4tjqjn5/CFXbE6bwCQFto
 nZEbviXg32Hp1wqE+hxr/E/d2QtYJPXSoFsP55QKtvAWPejCSh83YchE/vNmz/DR3XoZHZwRmRR
 UH+/wqPE8rv6BQ==
X-Received: by 2002:a05:6000:43c6:20b0:460:6a8f:5d36 with SMTP id
 ffacd0b85a97d-46238acb5ebmr1412729f8f.22.1781641272712; 
 Tue, 16 Jun 2026 13:21:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26393asm50248893f8f.5.2026.06.16.13.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 13:21:12 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 16 Jun 2026 20:21:11 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
X-Gerrit-Change-Number: 1635
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1635?usp=email>
X-Gerrit-Commit: 1281d264a259bf8e95695bbb831737a4778d4afa
In-Reply-To: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
References: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzgzMTAwMDAwLkk2YjMwMzgwNWEzNjg4YjZmNjM2MzE0MGM3Njg1M2E1OGJhZGVjZDhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bd939eb53dab543e25e13b24f181926636ab9526-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wZaHe-0000Nb-VH
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6341809967224109145=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6341809967224109145==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ILrU2Kpi9Nc="; charset=UTF-8

--ILrU2Kpi9Nc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1635?usp=3Demail )

Change subject: Multisocket: use event engine rwfla=
gs for UDP I/O
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Multisocket: use event engine rwflags for UDP I/O

udp_flags does not gua=
rantee correct association with the socket being
processed=2E Use the rwfla=
gs delivered by the event engine along with the
event to ensure proper per-=
socket I/O handling=2E

Remove udp_flags entirely=2E

Replace the previous =
global-style flag computation with a per-socket
decision model in p2mp_iow_=
flags(), which derives I/O flags
directly from the current multi_context st=
ate and the specific socket
being processed=2E This ensures that read/write=
 decisions are correctly
bound to the active socket rather than shared or i=
mplicit global state=2E

This change is based on an investigation triggered=
 by a report from
Joshua Rogers using ZeroPath=2E

Change-Id: I6b303805a368=
8b6f6363140c76853a58badecd8f
Signed-off-by: Gianmarco De Gregori <gianmarco=
@mandelbit=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635
Message-Id: <2026061616=
2129=2E28519-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ec=
om/openvpn-devel@lists=2Esourceforge=2Enet/msg37198=2Ehtml
Signed-off-by: G=
ert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/forward=2Ec
M src/o=
penvpn/forward=2Eh
M src/openvpn/mudp=2Ec
M src/openvpn/mudp=2Eh
M src/open=
vpn/multi_io=2Ec
M src/openvpn/multi_io=2Eh
6 files changed, 74 insertions(=
+), 83 deletions(-)




diff --git a/src/openvpn/forward=2Ec b/src/openvpn/=
forward=2Ec
index d24f534=2E=2Eab76b9e 100644
--- a/src/openvpn/forward=2Ec=

+++ b/src/openvpn/forward=2Ec
@@ -2030,9 +2030,8 @@
     check_timeout_ran=
dom_component(c);
 }
 
-static void
-multi_io_process_flags(struct context =
*c, struct event_set *es, const unsigned int flags,
-                      =
 unsigned int *out_socket, unsigned int *out_tuntap)
+void
+multi_io_proces=
s_flags(struct context *c, struct event_set *es, struct link_socket *sock, =
const unsigned int flags)
 {
     unsigned int socket =3D 0;
     unsigned =
int tuntap =3D 0;
@@ -2123,50 +2122,19 @@
      * (for TCP server sockets t=
his happens in
      *  socket_set_listen_persistent())=2E
      */
-    fo=
r (int i =3D 0; i < c->c1=2Elink_sockets_num; i++)
-    {
-        if ((c->=
options=2Emode !=3D MODE_SERVER) || (proto_is_dgram(c->c2=2Elink_sockets[i]=
->info=2Eproto)))
-        {
-            socket_set(c->c2=2Elink_sockets[i=
], es, socket, &c->c2=2Elink_sockets[i]->ev_arg, NULL);
-        }
-    }
-=

+    socket_set(sock, es, socket, &sock->ev_arg, NULL);
     tun_set(c->c1=
=2Etuntap, es, tuntap, (void *)tun_shift, NULL);
-
-    if (out_socket)
-  =
  {
-        *out_socket =3D socket;
-    }
-
-    if (out_tuntap)
-    {
-=
        *out_tuntap =3D tuntap;
-    }
 }
 
 /*
- * Wait for I/O events=2E =
 Used for UDP sockets in
- * point-to-multipoint mode=2E
- */
-
-void
-get_=
io_flags_udp(struct context *c, struct multi_io *multi_io, const unsigned i=
nt flags)
-{
-    unsigned int out_socket;
-
-    multi_io_process_flags(c,=
 multi_io->es, flags, &out_socket, NULL);
-    multi_io->udp_flags =3D (out=
_socket << SOCKET_SHIFT);
-}
-
-/*
- * This is the core I/O wait function, =
used for all I/O waits except
- * for the top-level server sockets=2E
+ * T=
his is the core I/O wait function, used for all I/O waits=2E
+ *
+ * Invoke=
d by P2P instances in tunnel_point_to_point() or by P2MP
+ * instances with=
in the per-client context in multi_io=2Ec=2E
  */
 void
 io_wait(struct con=
text *c, const unsigned int flags)
 {
-    unsigned int out_socket;
-    un=
signed int out_tuntap;
     struct event_set_return esr[4];
 
     /* These=
 shifts all depend on EVENT_READ and EVENT_WRITE */
@@ -2185,7 +2153,7 @@
 =
     */
     event_reset(c->c2=2Eevent_set);
 
-    multi_io_process_flags(=
c, c->c2=2Eevent_set, flags, &out_socket, &out_tuntap);
+    multi_io_proce=
ss_flags(c, c->c2=2Eevent_set, c->c2=2Elink_sockets[0], flags);
 
 #if defi=
ned(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (c->c1=2Etuntap)
diff =
--git a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh
index 0d3e492=2E=
=2E324c0b4 100644
--- a/src/openvpn/forward=2Eh
+++ b/src/openvpn/forward=
=2Eh
@@ -68,7 +68,22 @@
 
 extern counter_type link_write_bytes_global;
 
-=
void get_io_flags_udp(struct context *c, struct multi_io *multi_io, const u=
nsigned int flags);
+/**
+ * @brief Processes I/O flags to configure socket=
 and TUN/TAP event monitors=2E
+ *
+ * Evaluates the current I/O state (`fl=
ags`) and context mode to determine
+ * which READ or WRITE events to regis=
ter in the event loop=2E
+ *
+ * @note This function gets called from clien=
t instances from @c io_wait()
+ * and from p2mp (Point-to-multipoint) insta=
nces in @c multi_io_wait()=2E
+ *
+ * @param c      Pointer to the core con=
text=2E
+ * @param es     The event set where descriptors are registered=2E=

+ * @param sock   The link socket to configure=2E
+ * @param flags  Bitmas=
k of active I/O operation requests (e=2Eg=2E, @ref IOW_TO_LINK,
+ * @ref IO=
W_READ_TUN, @ref IOW_TO_TUN, @ref IOW_SHAPER)=2E
+ */
+void multi_io_proces=
s_flags(struct context *c, struct event_set *es, struct link_socket *sock, =
const unsigned int flags);
 
 void io_wait(struct context *c, const unsigne=
d int flags);
 
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
in=
dex dded1ee=2E=2E143a330 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvp=
n/mudp=2Ec
@@ -340,18 +340,17 @@
  * Process a UDP socket event=2E
  */
 vo=
id
-multi_process_io_udp(struct multi_context *m, struct link_socket *sock)=

+multi_process_io_udp(struct multi_context *m, struct link_socket *sock, u=
nsigned int rwflags)
 {
-    const unsigned int status =3D m->multi_io->udp=
_flags;
     const unsigned int mpp_flags =3D (MPP_PRE_SELECT | MPP_CLOSE_O=
N_SIGNAL);
 
     /* UDP port ready to accept write */
-    if (status & SO=
CKET_WRITE)
+    if (rwflags & SOCKET_WRITE)
     {
         multi_process_=
outgoing_link(m, mpp_flags);
     }
     /* Incoming data on UDP port */
- =
   else if (status & SOCKET_READ)
+    else if (rwflags & SOCKET_READ)
    =
 {
         read_incoming_link(&m->top, sock);
         if (!IS_SIG(&m->top=
))
@@ -359,36 +358,4 @@
             multi_process_incoming_link(m, NULL, m=
pp_flags, sock);
         }
     }
-
-    m->multi_io->udp_flags =3D ES_ERR=
OR;
-}
-
-/*
- * Return the io_wait() flags appropriate for
- * a point-to-=
multipoint tunnel=2E
- */
-unsigned int
-p2mp_iow_flags(const struct multi_=
context *m)
-{
-    unsigned int flags =3D IOW_WAIT_SIGNAL;
-    if (m->pen=
ding)
-    {
-        if (TUN_OUT(&m->pending->context))
-        {
-      =
      flags |=3D IOW_TO_TUN;
-        }
-        if (LINK_OUT(&m->pending->=
context))
-        {
-            flags |=3D IOW_TO_LINK;
-        }
-    }=

-    else if (mbuf_defined(m->mbuf))
-    {
-        flags |=3D IOW_MBUF;
=
-    }
-    else
-    {
-        flags |=3D IOW_READ;
-    }
-    return fl=
ags;
 }
diff --git a/src/openvpn/mudp=2Eh b/src/openvpn/mudp=2Eh
index 005e=
e10=2E=2E6567539 100644
--- a/src/openvpn/mudp=2Eh
+++ b/src/openvpn/mudp=
=2Eh
@@ -30,9 +30,7 @@
 struct context;
 struct multi_context;
 
-unsigned =
int p2mp_iow_flags(const struct multi_context *m);
-
-void multi_process_io=
_udp(struct multi_context *m, struct link_socket *sock);
+void multi_proces=
s_io_udp(struct multi_context *m, struct link_socket *sock, unsigned int rw=
flags);
 /*****************************************************************=
*********/
 /**
  * Get, and if necessary create, the multi_instance associ=
ated with a
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2E=
c
index e6f4e9c=2E=2Ed8cc708 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/sr=
c/openvpn/multi_io=2Ec
@@ -154,6 +154,40 @@
     }
 }
 
+/*
+ * Return the =
io flags appropriate for
+ * a point-to-multipoint tunnel=2E
+ */
+static u=
nsigned int
+p2mp_iow_flags(const struct multi_context *m, struct link_sock=
et *sock)
+{
+    unsigned int flags =3D IOW_WAIT_SIGNAL;
+
+    if (m->pen=
ding)
+    {
+        if (TUN_OUT(&m->pending->context))
+        {
+      =
      flags |=3D IOW_TO_TUN;
+        }
+
+        /* If the to be processe=
d socket happens to be the same one on the pending
+         * UDP client i=
nstance, we set that socket ready for write */
+        if (LINK_OUT(&m->pe=
nding->context) && m->pending->context=2Ec2=2Elink_sockets[0] =3D=3D sock)
=
+        {
+            flags |=3D IOW_TO_LINK;
+        }
+    }
+    else=
 if (mbuf_defined(m->mbuf))
+    {
+        flags |=3D IOW_MBUF;
+    }
+  =
  else
+    {
+        flags |=3D IOW_READ;
+    }
+    return flags;
+}
+
=
 int
 multi_io_wait(struct multi_context *m)
 {
@@ -171,7 +205,17 @@
 
    =
 if (has_udp_in_local_list(&m->top=2Eoptions))
     {
-        get_io_flags=
_udp(&m->top, m->multi_io, p2mp_iow_flags(m));
+        for (int i =3D 0; i=
 < m->top=2Ec1=2Elink_sockets_num; i++)
+        {
+            struct link=
_socket *sock =3D m->top=2Ec2=2Elink_sockets[i];
+
+            if ((m->top=
=2Eoptions=2Emode =3D=3D MODE_SERVER) && proto_is_dgram(sock->info=2Eproto)=
)
+            {
+                unsigned int flags =3D p2mp_iow_flags(m, =
sock);
+
+                multi_io_process_flags(&m->top, m->multi_io->es, =
sock, flags);
+            }
+        }
     }
 
     tun_set(m->top=2Ec1=
=2Etuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, persistent);
@@ -457,=
7 +501,7 @@
                     }
                     else
              =
       {
-                        multi_process_io_udp(m, ev_arg->u=2Esock)=
;
+                        multi_process_io_udp(m, ev_arg->u=2Esock, e->rwf=
lags);
                         mi =3D m->pending;
                     }
 =
                    /* monitor and/or handle events that are
diff --git a/s=
rc/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh
index 6b2f59a=2E=2Ed6734=
bd 100644
--- a/src/openvpn/multi_io=2Eh
+++ b/src/openvpn/multi_io=2Eh
@@ =
-55,7 +55,6 @@
     int n_esr;
     int maxevents;
     unsigned int tun_rw=
flags;
-    unsigned int udp_flags;
 #ifdef ENABLE_MANAGEMENT
     unsigned=
 int management_persist_flags;
 #endif

-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1635?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
Gerrit-Change-Nu=
mber: 1635
Gerrit-PatchSet: 8
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=
=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: o=
rdex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>

--ILrU2Kpi9Nc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1635?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Multisocket: use event engine rwflags for =
UDP I/O<br><br>udp_flags does not guarantee correct association with the so=
cket being<br>processed=2E Use the rwflags delivered by the event engine al=
ong with the<br>event to ensure proper per-socket I/O handling=2E<br><br>Re=
move udp_flags entirely=2E<br><br>Replace the previous global-style flag co=
mputation with a per-socket<br>decision model in p2mp_iow_flags(), which de=
rives I/O flags<br>directly from the current multi_context state and the sp=
ecific socket<br>being processed=2E This ensures that read/write decisions =
are correctly<br>bound to the active socket rather than shared or implicit =
global state=2E<br><br>This change is based on an investigation triggered b=
y a report from<br>Joshua Rogers using ZeroPath=2E<br><br>Change-Id: I6b303=
805a3688b6f6363140c76853a58badecd8f<br>Signed-off-by: Gianmarco De Gregori =
&lt;gianmarco@mandelbit=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1635<br>Message-Id: &lt;20260616162129=2E28519-1-gert@greenie=2Emuc=2Ede&gt=
;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforg=
e=2Enet/msg37198=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt;<br>---<br>M src/openvpn/forward=2Ec<br>M src/openvpn/forward=2E=
h<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/mudp=2Eh<br>M src/openvpn/mult=
i_io=2Ec<br>M src/openvpn/multi_io=2Eh<br>6 files changed, 74 insertions(+)=
, 83 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward=2Ec b/s=
rc/openvpn/forward=2Ec</span><br><span>index d24f534=2E=2Eab76b9e 100644</s=
pan><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openv=
pn/forward=2Ec</span><br><span>@@ -2030,9 +2030,8 @@</span><br><span>     c=
heck_timeout_random_component(c);</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-multi_io_process_flags(struct contex=
t *c, struct event_set *es, const unsigned int flags,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                       unsigned int *out_so=
cket, unsigned int *out_tuntap)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mul=
ti_io_process_flags(struct context *c, struct event_set *es, struct link_so=
cket *sock, const unsigned int flags)</span><br><span> {</span><br><span>  =
   unsigned int socket =3D 0;</span><br><span>     unsigned int tuntap =3D =
0;</span><br><span>@@ -2123,50 +2122,19 @@</span><br><span>      * (for TCP=
 server sockets this happens in</span><br><span>      *  socket_set_listen_=
persistent())=2E</span><br><span>      */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; c-&gt;c1=2Elink_sockets_nu=
m; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if ((c-&gt;options=2Em=
ode !=3D MODE_SERVER) || (proto_is_dgram(c-&gt;c2=2Elink_sockets[i]-&gt;inf=
o=2Eproto)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            socket_se=
t(c-&gt;c2=2Elink_sockets[i], es, socket, &amp;c-&gt;c2=2Elink_sockets[i]-&=
gt;ev_arg, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    socket_set(sock, es, socket, &amp;sock-&gt;ev_a=
rg, NULL);</span><br><span>     tun_set(c-&gt;c1=2Etuntap, es, tuntap, (voi=
d *)tun_shift, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (out_socket)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        *out_socket =3D socket;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (out_tuntap)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 *out_tuntap =3D tuntap;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span> }</span><br><span> </span><br><span> /*</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * Wait for I/O events=2E  Used=
 for UDP sockets in</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 point-to-multipoint mode=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-get_io_flags_udp(struct context *c, struct multi_=
io *multi_io, const unsigned int flags)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  unsigned int out_socket;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_io_pro=
cess_flags(c, multi_io-&gt;es, flags, &amp;out_socket, NULL);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    multi_io-&gt;udp_flags =3D (out=
_socket &lt;&lt; SOCKET_SHIFT);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * This is the core I/O wait function, used for al=
l I/O waits except</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
for the top-level server sockets=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * This is the core I/O wait function, used for all I/O wai=
ts=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Invoked by P2P instances in =
tunnel_point_to_point() or by P2MP</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * instances within the per-client context in multi_io=2Ec=
=2E</span><br><span>  */</span><br><span> void</span><br><span> io_wait(str=
uct context *c, const unsigned int flags)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    unsigned int out_socket;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int out_tuntap;<=
/span><br><span>     struct event_set_return esr[4];</span><br><span> </spa=
n><br><span>     /* These shifts all depend on EVENT_READ and EVENT_WRITE *=
/</span><br><span>@@ -2185,7 +2153,7 @@</span><br><span>      */</span><br>=
<span>     event_reset(c-&gt;c2=2Eevent_set);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    multi_io_process_flags(c, c-&=
gt;c2=2Eevent_set, flags, &amp;out_socket, &amp;out_tuntap);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    multi_io_process_flags(c, c-&g=
t;c2=2Eevent_set, c-&gt;c2=2Elink_sockets[0], flags);</span><br><span> </sp=
an><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><b=
r><span>     if (c-&gt;c1=2Etuntap)</span><br><span>diff --git a/src/openvp=
n/forward=2Eh b/src/openvpn/forward=2Eh</span><br><span>index 0d3e492=2E=2E=
324c0b4 100644</span><br><span>--- a/src/openvpn/forward=2Eh</span><br><spa=
n>+++ b/src/openvpn/forward=2Eh</span><br><span>@@ -68,7 +68,22 @@</span><b=
r><span> </span><br><span> extern counter_type link_write_bytes_global;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void ge=
t_io_flags_udp(struct context *c, struct multi_io *multi_io, const unsigned=
 int flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Processes I/O=
 flags to configure socket and TUN/TAP event monitors=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Evaluates the current I/O state (`flags`) and contex=
t mode to determine</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * which READ or WRITE events to register in the event loop=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @note This function gets called from client in=
stances from @c io_wait()</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * and from p2mp (Point-to-multipoint) instances in @c multi_io_wait(=
)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param c      Pointer to the =
core context=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param es     The event set where descriptors are registered=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param sock   The link socket=
 to configure=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param flags  Bitmask of active I/O operation requests (e=2Eg=2E, @ref IOW_=
TO_LINK,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ref IOW=
_READ_TUN, @ref IOW_TO_TUN, @ref IOW_SHAPER)=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void multi_io_process_flags(struct context *c, struct event_set=
 *es, struct link_socket *sock, const unsigned int flags);</span><br><span>=
 </span><br><span> void io_wait(struct context *c, const unsigned int flags=
);</span><br><span> </span><br><span>diff --git a/src/openvpn/mudp=2Ec b/sr=
c/openvpn/mudp=2Ec</span><br><span>index dded1ee=2E=2E143a330 100644</span>=
<br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=
=2Ec</span><br><span>@@ -340,18 +340,17 @@</span><br><span>  * Process a UD=
P socket event=2E</span><br><span>  */</span><br><span> void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-multi_process_io_udp(struct multi_co=
ntext *m, struct link_socket *sock)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+multi_process_io_udp(struct multi_context *m, struct link_s=
ocket *sock, unsigned int rwflags)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const unsigned int status =3D m-&gt;mul=
ti_io-&gt;udp_flags;</span><br><span>     const unsigned int mpp_flags =3D =
(MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span> </span><br><span> =
    /* UDP port ready to accept write */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (status &amp; SOCKET_WRITE)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (rwflags &amp; SOCKET_WRITE)</span=
><br><span>     {</span><br><span>         multi_process_outgoing_link(m, m=
pp_flags);</span><br><span>     }</span><br><span>     /* Incoming data on =
UDP port */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else i=
f (status &amp; SOCKET_READ)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    else if (rwflags &amp; SOCKET_READ)</span><br><span>     {</sp=
an><br><span>         read_incoming_link(&amp;m-&gt;top, sock);</span><br><=
span>         if (!IS_SIG(&amp;m-&gt;top))</span><br><span>@@ -359,36 +358,=
4 @@</span><br><span>             multi_process_incoming_link(m, NULL, mpp_=
flags, sock);</span><br><span>         }</span><br><span>     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    m-&gt;multi_io-&gt;udp_flags =3D ES_ERROR;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Return the =
io_wait() flags appropriate for</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * a point-to-multipoint tunnel=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-unsigned int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-p2mp=
_iow_flags(const struct multi_context *m)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    unsigned int flags =3D IOW_WAIT_SIGNAL;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (m-&gt;pending)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (TUN_OUT(&amp;m-&gt;pending-&gt;context))</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            flags |=3D IOW_TO_TUN;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (LINK_OUT(&amp;m-&gt;pending-&gt;cont=
ext))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            flags |=3D IOW_T=
O_LINK;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    else if (mbuf_defined(m-&gt;mbuf))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        flags |=3D IOW_MBUF;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    flags |=3D IOW_READ;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return fl=
ags;</span><br><span> }</span><br><span>diff --git a/src/openvpn/mudp=2Eh b=
/src/openvpn/mudp=2Eh</span><br><span>index 005ee10=2E=2E6567539 100644</sp=
an><br><span>--- a/src/openvpn/mudp=2Eh</span><br><span>+++ b/src/openvpn/m=
udp=2Eh</span><br><span>@@ -30,9 +30,7 @@</span><br><span> struct context;<=
/span><br><span> struct multi_context;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-unsigned int p2mp_iow_flags(const struct=
 multi_context *m);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-void multi_process_io_u=
dp(struct multi_context *m, struct link_socket *sock);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void multi_process_io_udp(struct multi_c=
ontext *m, struct link_socket *sock, unsigned int rwflags);</span><br><span=
> /************************************************************************=
**/</span><br><span> /**</span><br><span>  * Get, and if necessary create, =
the multi_instance associated with a</span><br><span>diff --git a/src/openv=
pn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index e6f4e9c=2E=
=2Ed8cc708 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br>=
<span>+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -154,6 +154,40 @@</=
span><br><span>     }</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Return the io flags appropriate for</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * a point-to-multipoint tunnel=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static unsigned int</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+p2mp_iow_flags(const struct multi_c=
ontext *m, struct link_socket *sock)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   unsigned int flags =3D IOW_WAIT_SIGNAL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (m-&gt;pending)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (TUN_OUT(&amp;m-&gt;pending-&gt;context))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            flags |=3D IOW_TO_TUN;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* If the to be processed socket happens to be the same one on th=
e pending</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *=
 UDP client instance, we set that socket ready for write */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (LINK_OUT(&amp;m-&gt;pen=
ding-&gt;context) &amp;&amp; m-&gt;pending-&gt;context=2Ec2=2Elink_sockets[=
0] =3D=3D sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fl=
ags |=3D IOW_TO_LINK;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (mbuf_defi=
ned(m-&gt;mbuf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        flags |=
=3D IOW_MBUF;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        flags |=3D IOW_READ;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return flags;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> int</span><br><span> multi_io_wait(struct multi_cont=
ext *m)</span><br><span> {</span><br><span>@@ -171,7 +205,17 @@</span><br><=
span> </span><br><span>     if (has_udp_in_local_list(&amp;m-&gt;top=2Eopti=
ons))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        get_io_flags_udp(&amp;m-&gt;top, m-&gt;multi_io, p2mp_iow_fl=
ags(m));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for=
 (int i =3D 0; i &lt; m-&gt;top=2Ec1=2Elink_sockets_num; i++)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            struct link_socket *sock =3D =
m-&gt;top=2Ec2=2Elink_sockets[i];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if ((m-&gt;top=2Eoptions=2Emode =3D=3D MODE_SERVER) &amp;&amp; proto=
_is_dgram(sock-&gt;info=2Eproto))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                unsigned int flags =3D p2mp_iow_flags(m, sock);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                multi_io_process_flags(&a=
mp;m-&gt;top, m-&gt;multi_io-&gt;es, sock, flags);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span> =
</span><br><span>     tun_set(m-&gt;top=2Ec1=2Etuntap, m-&gt;multi_io-&gt;e=
s, EVENT_READ, MULTI_IO_TUN, persistent);</span><br><span>@@ -457,7 +501,7 =
@@</span><br><span>                     }</span><br><span>                 =
    else</span><br><span>                     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                        multi_process_io_udp(m, e=
v_arg-&gt;u=2Esock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        multi_process_io_udp(m, ev_arg-&gt;u=2Esock, e-&gt=
;rwflags);</span><br><span>                         mi =3D m-&gt;pending;</=
span><br><span>                     }</span><br><span>                     =
/* monitor and/or handle events that are</span><br><span>diff --git a/src/o=
penvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh</span><br><span>index 6b2f59=
a=2E=2Ed6734bd 100644</span><br><span>--- a/src/openvpn/multi_io=2Eh</span>=
<br><span>+++ b/src/openvpn/multi_io=2Eh</span><br><span>@@ -55,7 +55,6 @@<=
/span><br><span>     int n_esr;</span><br><span>     int maxevents;</span><=
br><span>     unsigned int tun_rwflags;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    unsigned int udp_flags;</span><br><span> #ifdef ENABL=
E_MANAGEMENT</span><br><span>     unsigned int management_persist_flags;</s=
pan><br><span> #endif</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail">change=
 1635</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
6b303805a3688b6f6363140c76853a58badecd8f </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1635 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gi=
anmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--ILrU2Kpi9Nc=--


--===============6341809967224109145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6341809967224109145==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6341809967224109145==--

