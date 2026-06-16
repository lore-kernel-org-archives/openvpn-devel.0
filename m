Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B19CD98E6
	for <openvpn-devel@archiver.kernel.org>; Tue, 16 Jun 2026 20:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YiQheYdrXjqGUde4aZvI2Ns5Uvc8wD4lmEpHJlU8U1w=; b=GEnuNGfFhXdh05QNewDxn/5jQw
	cYGXKlvMWj9tvrY6hgIEmBrdZGINrRkeM2QyPMgUJ3Tk3TeXnAE/qxgfcU+ldQDRf/DxnTAdY398X
	ScUE02mnplnXLoK2NI2J5UuyzQiByDYksDyowQkcqKPGyScs/FuFbaSYHxq/Hc0mfv7A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wZaHl-00006q-14;
	Tue, 16 Jun 2026 20:21:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wZaHj-00006a-JQ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 20:21:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=oFtCa2NQi1piEokcF8DmXwrePAYXIG7UOuTkyDOmJc0=; b=LG0/wu/ilUn999ngxzbgrMgdt8
 vrWEG9D4sDFhjZsmNf9zCgOrbrLdarVi/n3ncwDBonUsWO9cDV0cqPBfzxdk/dr/3yHY/Jdg53MKH
 k96Iid4D7uKt+Rp8q1F0iIwdLM87X9dkO9e3fKc/abgL0w7NyR3uDjLeSXpL97MSEUeo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oFtCa2NQi1piEokcF8DmXwrePAYXIG7UOuTkyDOmJc0=; b=C
 0pWqQqN3pwmgWm3HDBScmOoQQuSaNP7XQOStsc/nngR1mKKb1rjjbxNr9awPV3RTeAGqwndGvyddU
 9OZBU9MGqxohCPmvvL1uQUBsSMzS75STyKtRioEx3wvTOoJ05GAT2cHUf4l65cF/CAV1yuZnoGu5x
 U//JH+TzV9acZdGc=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wZaHi-0000Nq-52 for openvpn-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 20:21:24 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-460166910e6so2667926f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 16 Jun 2026 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781641271; x=1782246071; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oFtCa2NQi1piEokcF8DmXwrePAYXIG7UOuTkyDOmJc0=;
 b=aM+0pP5XjL3VBWoXaZLeAPWrR5U17K1ripgyfe1OZT3gMPxhV0qb5IYXILPWAOlobc
 uQTM2fU6glT4/Fikvdooo91qdxIV71D8OdvJA/hwBiYtxk7O2I+j9h0ORfjfSYxPo2Kp
 HvwgCub7eWqj0A39dec+aHZEdnNMFzlhxxbL+nv5+CXphz3YciWnojdSyZvtPHew8Wtt
 jEVGDPIdwpZ2i9EQPNplK7caTuqk3uR71WtJDjtQ9p6/My5le0lf93h0+zxULYMqk7qQ
 KOsgW2gPH9SfMV/W6qwAdbY6PaxtMUqvdyPx/i01qS0qCAZyUbvJa9goDwjVzwRqbArC
 01mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781641271; x=1782246071;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oFtCa2NQi1piEokcF8DmXwrePAYXIG7UOuTkyDOmJc0=;
 b=V6rZ2DnJA7SQZ7vj5mvdH2asnNDS+7CERN8+4PXwKzZg4XP2cdH0N9wyC815o4sp5x
 udOWYarbyaC+9NeoAts5PVR6m+A7IPM4D66VdtY7mg7RwgMKgl9oDWle0URo55m9jx+o
 LW8uG5Nh5TTv4OCp+W6r/kZ5iDG7N6Jmmqkluq0ebSf3qLF1z31kxFuknoCzLuPv3KwC
 1X6AY0k7RVftOmpt0Zmyf1pvrpATBxpKf1RMYgXH/11mQX23lcIwoJIIWevHE5/15IO5
 gaP37IKwppnChCi4+h80SKOwWFJU9cBWTcd4YTGdL9v+NO4dI/S89by85vgF2w5bhsHP
 8viA==
X-Gm-Message-State: AOJu0YyB4CRn9wvefXpRLidUsjtLl+rcACNwqfeHN5Gw3QjPneIaxU43
 L7YLU8hXmvgk27xzyU+rJn3WGHQFboS4zl5LggCs0cdS2ZlWKY6vYNWZ2DlF7Wg/BxU+MdKJv9I
 0b6KtDv7zblbnYxpD5Pyu7965ySjwzOMEt7EPLxMdvSbrfCZngwXdwvLc4ne0oD9LF40G
X-Gm-Gg: Acq92OEJ0G3XPWhZlANKG4ljbx76vgTbFrciEHcXDvhbSWDfjuSfZU1QhHTzlAoS4HR
 bQXsVHlsesGdAJfITqU/v2RAF6llrvQ5MmcAmCZXrXSAMgdh7yXoBpCA8IU6vkYFrjEQTsFkISP
 tqpcvqSiB2V+YVopT0Ju9YjlmxgBFmSqCJEBNaOdwmJFcmVE9/SlWaCOCA8euxql1o1tEHBPA65
 PYSJTXVGc6mZLQqLTDKY1OzaFllTT9mar5U1mi9nN/IFApGD8I43rBliePxxVYAsCkP38sTD31W
 iV/qnD/fT2udn4gkBlnYH3g4z4+ZfNcgbAaAubb6g1XemWos0xewGhRtPZYwy3Ivs9VLZgnU4D3
 yqmMQQDZVjRcT0jxTnVG0h/I/UZfEq9Hiv/ZucW698WHhdKQjPmuQXcnXpV6I8s5F9VwIqfdHad
 43zZ/zC5eEUexveW0lBKrbAmEJ9dInFZ8dxmwTCxbNblUU1sUY/ZHnFHwWpuV6ZAE4QZ0f9yTDQ
 UXspALhDap6589N44PBmfbBtKG6j7dqijteMnsxre4Da8bFpPwHeuYKXpfLqisteCVeH/UkIMuW
 3u611lNtY7ORbw==
X-Received: by 2002:a05:6000:43c6:20b0:452:75ca:3fab with SMTP id
 ffacd0b85a97d-4623955b609mr1291372f8f.38.1781641270937; 
 Tue, 16 Jun 2026 13:21:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b1056sm46840573f8f.18.2026.06.16.13.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 13:21:10 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 16 Jun 2026 20:21:08 +0000
To: its_Giaan <gianmarco@mandelbit.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
X-Gerrit-Change-Number: 1635
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1635?usp=email>
X-Gerrit-Commit: 1281d264a259bf8e95695bbb831737a4778d4afa
In-Reply-To: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
References: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzgzMTAwMDAwLkk2YjMwMzgwNWEzNjg4YjZmNjM2MzE0MGM3Njg1M2E1OGJhZGVjZDhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bd939eb53dab543e25e13b24f181926636ab9526-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wZaHi-0000Nq-52
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5010129587478759747=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5010129587478759747==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U/wln7yC55A="; charset=UTF-8

--U/wln7yC55A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 its_Giaan=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
cron2


Change subject: Multisocket: use event engine rwflags for UDP I/O
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Multisocket: =
use event engine rwflags for UDP I/O

udp_flags does not guarantee correct =
association with the socket being
processed=2E Use the rwflags delivered by=
 the event engine along with the
event to ensure proper per-socket I/O hand=
ling=2E

Remove udp_flags entirely=2E

Replace the previous global-style fl=
ag computation with a per-socket
decision model in p2mp_iow_flags(), which =
derives I/O flags
directly from the current multi_context state and the spe=
cific socket
being processed=2E This ensures that read/write decisions are =
correctly
bound to the active socket rather than shared or implicit global =
state=2E

This change is based on an investigation triggered by a report fr=
om
Joshua Rogers using ZeroPath=2E

Change-Id: I6b303805a3688b6f6363140c768=
53a58badecd8f
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Eco=
m>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1635
Message-Id: <20260616162129=2E28519-1-=
gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg37198=2Ehtml
Signed-off-by: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
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
s/35/1635/8

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
Gerrit-PatchSet: 8
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>=

Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: ordex <a=
ntonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--U/wln7yC55A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #8</strong> to the change originally created by its_Giaan=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">Multisocket: use event engi=
ne rwflags for UDP I/O<br><br>udp_flags does not guarantee correct associat=
ion with the socket being<br>processed=2E Use the rwflags delivered by the =
event engine along with the<br>event to ensure proper per-socket I/O handli=
ng=2E<br><br>Remove udp_flags entirely=2E<br><br>Replace the previous globa=
l-style flag computation with a per-socket<br>decision model in p2mp_iow_fl=
ags(), which derives I/O flags<br>directly from the current multi_context s=
tate and the specific socket<br>being processed=2E This ensures that read/w=
rite decisions are correctly<br>bound to the active socket rather than shar=
ed or implicit global state=2E<br><br>This change is based on an investigat=
ion triggered by a report from<br>Joshua Rogers using ZeroPath=2E<br><br>Ch=
ange-Id: I6b303805a3688b6f6363140c76853a58badecd8f<br>Signed-off-by: Gianma=
rco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>Acked-by: Gert Doering =
&lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1635<br>Message-Id: &lt;20260616162129=2E28519-1-gert@greeni=
e=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lis=
ts=2Esourceforge=2Enet/msg37198=2Ehtml<br>Signed-off-by: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/forward=2Ec<br>M src/ope=
nvpn/forward=2Eh<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/mudp=2Eh<br>M s=
rc/openvpn/multi_io=2Ec<br>M src/openvpn/multi_io=2Eh<br>6 files changed, 7=
4 insertions(+), 83 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/35/1635/8</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>i=
ndex d24f534=2E=2Eab76b9e 100644</span><br><span>--- a/src/openvpn/forward=
=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -2030=
,9 +2030,8 @@</span><br><span>     check_timeout_random_component(c);</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
multi_io_process_flags(struct context *c, struct event_set *es, const unsig=
ned int flags,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                unsigned int *out_socket, unsigned int *out_tuntap)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_io_process_flags(struct context *c,=
 struct event_set *es, struct link_socket *sock, const unsigned int flags)<=
/span><br><span> {</span><br><span>     unsigned int socket =3D 0;</span><b=
r><span>     unsigned int tuntap =3D 0;</span><br><span>@@ -2123,50 +2122,1=
9 @@</span><br><span>      * (for TCP server sockets this happens in</span>=
<br><span>      *  socket_set_listen_persistent())=2E</span><br><span>     =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D=
 0; i &lt; c-&gt;c1=2Elink_sockets_num; i++)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if ((c-&gt;options=2Emode !=3D MODE_SERVER) || (proto_is_dgr=
am(c-&gt;c2=2Elink_sockets[i]-&gt;info=2Eproto)))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            socket_set(c-&gt;c2=2Elink_sockets[i], es, sock=
et, &amp;c-&gt;c2=2Elink_sockets[i]-&gt;ev_arg, NULL);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socket_set=
(sock, es, socket, &amp;sock-&gt;ev_arg, NULL);</span><br><span>     tun_se=
t(c-&gt;c1=2Etuntap, es, tuntap, (void *)tun_shift, NULL);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (out_socket)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      *out_socket =3D socket;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (out_tuntap)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        *out_tuntap =3D tuntap;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> }</span><br><s=
pan> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * Wait for I/O events=2E  Used for UDP sockets in</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * point-to-multipoint mode=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_io_flags_u=
dp(struct context *c, struct multi_io *multi_io, const unsigned int flags)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    unsigned int out_socket;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    multi_io_process_flags(c, multi_io-&gt;es, flags, &a=
mp;out_socket, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    multi_io-&gt;udp_flags =3D (out_socket &lt;&lt; SOCKET_SHIFT);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This is the =
core I/O wait function, used for all I/O waits except</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * for the top-level server sockets=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This is the core I/O =
wait function, used for all I/O waits=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Invoked by P2P instances in tunnel_point_to_point() or by P2MP</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * instances within the p=
er-client context in multi_io=2Ec=2E</span><br><span>  */</span><br><span> =
void</span><br><span> io_wait(struct context *c, const unsigned int flags)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 unsigned int out_socket;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    unsigned int out_tuntap;</span><br><span>     struct event_set_retu=
rn esr[4];</span><br><span> </span><br><span>     /* These shifts all depen=
d on EVENT_READ and EVENT_WRITE */</span><br><span>@@ -2185,7 +2153,7 @@</s=
pan><br><span>      */</span><br><span>     event_reset(c-&gt;c2=2Eevent_se=
t);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    multi_io_process_flags(c, c-&gt;c2=2Eevent_set, flags, &amp;out_socket,=
 &amp;out_tuntap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   multi_io_process_flags(c, c-&gt;c2=2Eevent_set, c-&gt;c2=2Elink_sockets[=
0], flags);</span><br><span> </span><br><span> #if defined(TARGET_LINUX) ||=
 defined(TARGET_FREEBSD)</span><br><span>     if (c-&gt;c1=2Etuntap)</span>=
<br><span>diff --git a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh</s=
pan><br><span>index 0d3e492=2E=2E324c0b4 100644</span><br><span>--- a/src/o=
penvpn/forward=2Eh</span><br><span>+++ b/src/openvpn/forward=2Eh</span><br>=
<span>@@ -68,7 +68,22 @@</span><br><span> </span><br><span> extern counter_=
type link_write_bytes_global;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-void get_io_flags_udp(struct context *c, struct m=
ulti_io *multi_io, const unsigned int flags);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @brief Processes I/O flags to configure socket and TUN/TAP eve=
nt monitors=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Evaluates the curre=
nt I/O state (`flags`) and context mode to determine</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * which READ or WRITE events to register=
 in the event loop=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @note This f=
unction gets called from client instances from @c io_wait()</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * and from p2mp (Point-to-multipoi=
nt) instances in @c multi_io_wait()=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param c      Pointer to the core context=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param es     The event set where descript=
ors are registered=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param sock   The link socket to configure=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param flags  Bitmask of active I/O opera=
tion requests (e=2Eg=2E, @ref IOW_TO_LINK,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @ref IOW_READ_TUN, @ref IOW_TO_TUN, @ref IOW_SHAP=
ER)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void multi_io_process_flags(s=
truct context *c, struct event_set *es, struct link_socket *sock, const uns=
igned int flags);</span><br><span> </span><br><span> void io_wait(struct co=
ntext *c, const unsigned int flags);</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index =
dded1ee=2E=2E143a330 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</spa=
n><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -340,18 +340,17 @=
@</span><br><span>  * Process a UDP socket event=2E</span><br><span>  */</s=
pan><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mu=
lti_process_io_udp(struct multi_context *m, struct link_socket *sock)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_process_io_udp(stru=
ct multi_context *m, struct link_socket *sock, unsigned int rwflags)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const=
 unsigned int status =3D m-&gt;multi_io-&gt;udp_flags;</span><br><span>    =
 const unsigned int mpp_flags =3D (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</=
span><br><span> </span><br><span>     /* UDP port ready to accept write */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (status &amp; S=
OCKET_WRITE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(rwflags &amp; SOCKET_WRITE)</span><br><span>     {</span><br><span>       =
  multi_process_outgoing_link(m, mpp_flags);</span><br><span>     }</span><=
br><span>     /* Incoming data on UDP port */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    else if (status &amp; SOCKET_READ)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else if (rwflags &amp; SOCKE=
T_READ)</span><br><span>     {</span><br><span>         read_incoming_link(=
&amp;m-&gt;top, sock);</span><br><span>         if (!IS_SIG(&amp;m-&gt;top)=
)</span><br><span>@@ -359,36 +358,4 @@</span><br><span>             multi_p=
rocess_incoming_link(m, NULL, mpp_flags, sock);</span><br><span>         }<=
/span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;multi_io-&=
gt;udp_flags =3D ES_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * Return the io_wait() flags appropriate for</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * a point-to-multipoint tunnel=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-unsigned int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-p2mp_iow_flags(const struct multi_context *=
m)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    unsigned int flags =3D IOW_WAIT_SIG=
NAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (m-&gt;pen=
ding)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (TUN_OUT(&amp;m-&gt;p=
ending-&gt;context))</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            f=
lags |=3D IOW_TO_TUN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
LINK_OUT(&amp;m-&gt;pending-&gt;context))</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            flags |=3D IOW_TO_LINK;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    el=
se if (mbuf_defined(m-&gt;mbuf))</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   flags |=3D IOW_MBUF;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        flags |=3D IOW_READ;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return flags;</span><br><span> }</span><br><span=
>diff --git a/src/openvpn/mudp=2Eh b/src/openvpn/mudp=2Eh</span><br><span>i=
ndex 005ee10=2E=2E6567539 100644</span><br><span>--- a/src/openvpn/mudp=2Eh=
</span><br><span>+++ b/src/openvpn/mudp=2Eh</span><br><span>@@ -30,9 +30,7 =
@@</span><br><span> struct context;</span><br><span> struct multi_context;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsi=
gned int p2mp_iow_flags(const struct multi_context *m);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void multi_process_io_udp(struct multi_context *m, struct link=
_socket *sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
 multi_process_io_udp(struct multi_context *m, struct link_socket *sock, un=
signed int rwflags);</span><br><span> /************************************=
**************************************/</span><br><span> /**</span><br><spa=
n>  * Get, and if necessary create, the multi_instance associated with a</s=
pan><br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=
=2Ec</span><br><span>index e6f4e9c=2E=2Ed8cc708 100644</span><br><span>--- =
a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</=
span><br><span>@@ -154,6 +154,40 @@</span><br><span>     }</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the io=
 flags appropriate for</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * a point-to-multipoint tunnel=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+p2mp_iow_flags(const struct multi_context *m, struct link_socket *sock)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags =3D IOW_WAIT_SIG=
NAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (m-&gt;pending)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (TUN_OUT(&amp;m-&gt;pending-&gt;co=
ntext))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            flags |=3D=
 IOW_TO_TUN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* If the to be processed so=
cket happens to be the same one on the pending</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * UDP client instance, we set that sock=
et ready for write */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (LINK_OUT(&amp;m-&gt;pending-&gt;context) &amp;&amp; m-&gt;pen=
ding-&gt;context=2Ec2=2Elink_sockets[0] =3D=3D sock)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            flags |=3D IOW_TO_LINK;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else if (mbuf_defined(m-&gt;mbuf))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        flags |=3D IOW_MBUF;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        f=
lags |=3D IOW_READ;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return fla=
gs;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><s=
pan> multi_io_wait(struct multi_context *m)</span><br><span> {</span><br><s=
pan>@@ -171,7 +205,17 @@</span><br><span> </span><br><span>     if (has_udp=
_in_local_list(&amp;m-&gt;top=2Eoptions))</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        get_io_flags_udp(&amp;m-=
&gt;top, m-&gt;multi_io, p2mp_iow_flags(m));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; m-&gt;top=2Ec1=2E=
link_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     struct link_socket *sock =3D m-&gt;top=2Ec2=2Elink_sockets[i];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            if ((m-&gt;top=2Eoptions=2Emode =
=3D=3D MODE_SERVER) &amp;&amp; proto_is_dgram(sock-&gt;info=2Eproto))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                unsigned int fl=
ags =3D p2mp_iow_flags(m, sock);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          multi_io_process_flags(&amp;m-&gt;top, m-&gt;multi_io-&gt;es, soc=
k, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span>     }</span><br><span> </span><br><span>     tun_set(m-&gt;top=
=2Ec1=2Etuntap, m-&gt;multi_io-&gt;es, EVENT_READ, MULTI_IO_TUN, persistent=
);</span><br><span>@@ -457,7 +501,7 @@</span><br><span>                    =
 }</span><br><span>                     else</span><br><span>              =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
           multi_process_io_udp(m, ev_arg-&gt;u=2Esock);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                        multi_process_=
io_udp(m, ev_arg-&gt;u=2Esock, e-&gt;rwflags);</span><br><span>            =
             mi =3D m-&gt;pending;</span><br><span>                     }</=
span><br><span>                     /* monitor and/or handle events that ar=
e</span><br><span>diff --git a/src/openvpn/multi_io=2Eh b/src/openvpn/multi=
_io=2Eh</span><br><span>index 6b2f59a=2E=2Ed6734bd 100644</span><br><span>-=
-- a/src/openvpn/multi_io=2Eh</span><br><span>+++ b/src/openvpn/multi_io=2E=
h</span><br><span>@@ -55,7 +55,6 @@</span><br><span>     int n_esr;</span><=
br><span>     int maxevents;</span><br><span>     unsigned int tun_rwflags;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int udp_=
flags;</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     unsig=
ned int management_persist_flags;</span><br><span> #endif</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1635?usp=3Demail">change 1635</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1635?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58ba=
decd8f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1635 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;an=
tonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>

</body></html>
--U/wln7yC55A=--


--===============5010129587478759747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5010129587478759747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5010129587478759747==--

