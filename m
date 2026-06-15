Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F510CD98C5
	for <openvpn-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V2VGa+lT2PvE1//D/i+TFRhGcTga00MkwKG1K3PKsVo=; b=KdznSHsL/3MGv7fEWqr6FlL/N6
	7pxGhKRDjDNBS7MKnJoHMPRq/1VX359ivRm2u7+ZWsp/o7trJYBGC1QJc2iF+jct5K4H+cHdqQhCE
	2mPS9J1+HwbrTGRsACuRDWlyJJh0KJnwPMWR+uvb3Qkry1/NFAp7YHJb+3qYfdBiDhAU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wZ4Cl-0002in-Td;
	Mon, 15 Jun 2026 10:06:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wZ4CR-0002iI-U6
 for openvpn-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 10:05:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pIK20ccgWz6BTnGhYFcn3JTRiTw94P+woM3K1Bb6KHk=; b=CvVzej3RzHdy/1KSTcnD3+CBwB
 2SUUjSsE4GGO+f9cVduJXYEt+nEhqzqjgiZ2o6xsedMxdEh9f4iSMCZUvM7YdTmPneGyydK9UtAuC
 tu5taDiD0NFpHmauazZRSomMq8MTfUryyk0F5V7AmOPAomm5K+/U9RUQJ6tG+gwN91aM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pIK20ccgWz6BTnGhYFcn3JTRiTw94P+woM3K1Bb6KHk=; b=k
 B+d0ks1YsRz0fCbQgqWmiPkIc7I2x7P+bVKEiNsEu9kYYPQUN7q00HTiFpfPMXpK3MNnDLG55sJBJ
 O/HvxYlr2uJYi6DGjjdlmfIExnkZS5mnR0jP4+vyfb6AdlQn4n28ALNQ5ZQtcReW1tN6N5opSFG7t
 bhF8lkX1F5gaNRz8=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wZ4CH-00005n-R6 for openvpn-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 10:05:40 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso2145967f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 15 Jun 2026 03:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781517927; x=1782122727; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pIK20ccgWz6BTnGhYFcn3JTRiTw94P+woM3K1Bb6KHk=;
 b=NSlEzkVn7hZXlkLWbcVD18x7idc9DMSxcHVrz/LlhFN7fdADQc+nq0PryRACd1EprV
 TL3ZHKsooV3ofUoZASAPXqkl1AVXK/rVjGS9O4MJ3CUMC1uttAPKNKbTmpDe5WdfSLQO
 HjuXPBjDK7YNDYGHImn+JQla/e9huTGeOnZ2M4lexniLmt+m9Ah10NY02a8xIg19ZvA7
 Md72gC6Ft7QM278u8I5zwfHM+HQvf9C+SGgacZ9izdUM4ZcKFlI2oUrO388UsFSJOXtS
 yRp3drdo339ISLC7XMaTIn0b2AYYxFtYffRucqX7ApAcdIT6laidOCnVDBxTlOwjfnlS
 QW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781517927; x=1782122727;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pIK20ccgWz6BTnGhYFcn3JTRiTw94P+woM3K1Bb6KHk=;
 b=IlHelBnU2sSPdgrCpGCuwnMIXLgsphn5Y320z6BxSG8pr6iJuyu5pgOjqiZFnXGlDq
 bV7H25Q0FomM/OAEPwPEFK/arc6QfdxJXFRA4Uc6l2PHCrKbrU9WXRnH77GvM78tcqh4
 G8ibFLcQGOEkwHTSuKSU88r+jPo39lzRmwPPKB1NgDwBxA+MsHA0QAz87zgFem0J52lU
 urkRwqweC/hZAT8x0TbR2F61ZU32kLa55E4JPYVncEz/by251AXwjVoW2ePZuuEXRMdD
 RFmn7nAhsFl0vL5MmqPMjzl3lax538LMPU3lINkpNPkfvOPWyEsi6zqIRFwoFtdywQNt
 jfqQ==
X-Gm-Message-State: AOJu0YwTmmNxUvbO0Up8WWXd6G1D8OV0iE77t/iqQZW1YTou7ugCVOjQ
 KVnqEYWGb7SMprMmTX2umhw+Yf3VsP1Iu3/nX4riGIm7ZWBQyKLYXtSh5pa23IqfsMgkEbbeEDt
 3KAjLkie9m6SWcJExi0lt6gEk+N+GEWn9IZfbPK9SCEQhGDOTU5r2ghgU4BDt8ZVhXAfn07pr58
 8hBlmHXw==
X-Gm-Gg: Acq92OGF/s6Mi8obwhM/9AKCEZvb8ssRfX6PU8g/pxk7eAegXm++w8zLwHooFF/83Bx
 WMq3EQPZSEEd41bCNu+/ci8DGogGed+cXkAa6JRh6SThwgwEHcXuaxzDIDd4ygDUBivyWjbCrby
 Wx2oxIS8cPeeG7ZgKRWCNOa1FL7dXuxJO9h/rRS2bR4VTvmdJgXHD44v4WBwEdhrxjSBVyl6uMR
 2FAaCXJvaHMaAjBh65S7jAaQzKkShz2WzxN2tMHJ6Tmq0lpuFZ7eci/oGr9Z5N04Nhd5EekGKZS
 Wrb5783PrXSYW+JnGK++tTGWE2q55+AXF0cR12IUvIkyVfC+qwVRzKJ6mDC2o3fXOFTOLq1gF2c
 3CEoMNoPE86vi4K/YQq5GHybFaaPYyvqKQ/PruY/K+MqLxXjQ2MRhluUg7KiC94ghPSavhv6zva
 fvH4M7W0T9B1G5Rqt9ujQqdkxT5W0ka1mrRLDLFRoo39B5Sp44p64Me8udr3qMlV+51Crgl1oCQ
 e3o0P2cFMEY3bBWIDeGjP5u+c5HKLqDOnDKJWeA7wOWwXq4vm9Uvwhx+QlPF5YwnlAsa5shhFLP
 DRoe/0uKM87GuA==
X-Received: by 2002:a05:6000:4b04:b0:460:71e6:e11 with SMTP id
 ffacd0b85a97d-46071e60f39mr15954083f8f.24.1781517925906; 
 Mon, 15 Jun 2026 03:05:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2dbfb1sm35911526f8f.35.2026.06.15.03.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 03:05:25 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 15 Jun 2026 10:05:21 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
X-Gerrit-Change-Number: 1635
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1635?usp=email>
X-Gerrit-Commit: 052e3fc122f867d848340b684537317f5d28ebb8
In-Reply-To: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
References: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzgzMTAwMDAwLkk2YjMwMzgwNWEzNjg4YjZmNjM2MzE0MGM3Njg1M2E1OGJhZGVjZDhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cfcdd8dd89497c2b261056b269d9a3a0a2e91da7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wZ4CH-00005n-R6
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
Content-Type: multipart/mixed; boundary="===============7196732366901368526=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7196732366901368526==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UEUcawXvezQ="; charset=UTF-8

--UEUcawXvezQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, its_Giaan, ordex, plaisthos=2E=


Hello cron2, ordex, plaisthos, 

I'd like you to reexamine a change=2E Pl=
ease visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail
=

to look at the new patch set (#6)=2E

The following approvals got outdated=
 and were removed:
Code-Review+2 by ordex, Code-Review-1 by cron2


Change =
subject: Multisocket: use event engine rwflags for UDP I/O
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Multisocket: use event engin=
e rwflags for UDP I/O

udp_flags does not guarantee correct association wit=
h the socket being
processed=2E Use the rwflags delivered by the event engi=
ne along with the
event to ensure proper per-socket I/O handling=2E

Remove=
 udp_flags entirely=2E

Replace the previous global-style flag computation =
with a per-socket
decision model in p2mp_iow_flags(), which derives I/O fla=
gs
directly from the current multi_context state and the specific socket
be=
ing processed=2E This ensures that read/write decisions are correctly
bound=
 to the active socket rather than shared or implicit global state=2E

This =
change is based on an investigation triggered by a report from
Joshua Roger=
s using ZeroPath=2E

Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
S=
igned-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M src/op=
envpn/forward=2Ec
M src/openvpn/forward=2Eh
M src/openvpn/mudp=2Ec
M src/op=
envpn/mudp=2Eh
M src/openvpn/multi_io=2Ec
M src/openvpn/multi_io=2Eh
6 file=
s changed, 76 insertions(+), 83 deletions(-)


  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/35/1635/6

diff --git a/src/openvpn/=
forward=2Ec b/src/openvpn/forward=2Ec
index d24f534=2E=2Eab76b9e 100644
---=
 a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -2030,9 +2030,8=
 @@
     check_timeout_random_component(c);
 }
 
-static void
-multi_io_pro=
cess_flags(struct context *c, struct event_set *es, const unsigned int flag=
s,
-                       unsigned int *out_socket, unsigned int *out_tunt=
ap)
+void
+multi_io_process_flags(struct context *c, struct event_set *es, =
struct link_socket *sock, const unsigned int flags)
 {
     unsigned int so=
cket =3D 0;
     unsigned int tuntap =3D 0;
@@ -2123,50 +2122,19 @@
      *=
 (for TCP server sockets this happens in
      *  socket_set_listen_persist=
ent())=2E
      */
-    for (int i =3D 0; i < c->c1=2Elink_sockets_num; i++=
)
-    {
-        if ((c->options=2Emode !=3D MODE_SERVER) || (proto_is_dgr=
am(c->c2=2Elink_sockets[i]->info=2Eproto)))
-        {
-            socket_=
set(c->c2=2Elink_sockets[i], es, socket, &c->c2=2Elink_sockets[i]->ev_arg, =
NULL);
-        }
-    }
-
+    socket_set(sock, es, socket, &sock->ev_arg,=
 NULL);
     tun_set(c->c1=2Etuntap, es, tuntap, (void *)tun_shift, NULL);
=
-
-    if (out_socket)
-    {
-        *out_socket =3D socket;
-    }
-
-  =
  if (out_tuntap)
-    {
-        *out_tuntap =3D tuntap;
-    }
 }
 
 /*
-=
 * Wait for I/O events=2E  Used for UDP sockets in
- * point-to-multipoint =
mode=2E
- */
-
-void
-get_io_flags_udp(struct context *c, struct multi_io *=
multi_io, const unsigned int flags)
-{
-    unsigned int out_socket;
-
-   =
 multi_io_process_flags(c, multi_io->es, flags, &out_socket, NULL);
-    mu=
lti_io->udp_flags =3D (out_socket << SOCKET_SHIFT);
-}
-
-/*
- * This is th=
e core I/O wait function, used for all I/O waits except
- * for the top-lev=
el server sockets=2E
+ * This is the core I/O wait function, used for all I=
/O waits=2E
+ *
+ * Invoked by P2P instances in tunnel_point_to_point() or =
by P2MP
+ * instances within the per-client context in multi_io=2Ec=2E
  */=

 void
 io_wait(struct context *c, const unsigned int flags)
 {
-    unsign=
ed int out_socket;
-    unsigned int out_tuntap;
     struct event_set_retu=
rn esr[4];
 
     /* These shifts all depend on EVENT_READ and EVENT_WRITE =
*/
@@ -2185,7 +2153,7 @@
      */
     event_reset(c->c2=2Eevent_set);
 
- =
   multi_io_process_flags(c, c->c2=2Eevent_set, flags, &out_socket, &out_tu=
ntap);
+    multi_io_process_flags(c, c->c2=2Eevent_set, c->c2=2Elink_socke=
ts[0], flags);
 
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
    =
 if (c->c1=2Etuntap)
diff --git a/src/openvpn/forward=2Eh b/src/openvpn/for=
ward=2Eh
index 0d3e492=2E=2E324c0b4 100644
--- a/src/openvpn/forward=2Eh
++=
+ b/src/openvpn/forward=2Eh
@@ -68,7 +68,22 @@
 
 extern counter_type link_=
write_bytes_global;
 
-void get_io_flags_udp(struct context *c, struct mult=
i_io *multi_io, const unsigned int flags);
+/**
+ * @brief Processes I/O fl=
ags to configure socket and TUN/TAP event monitors=2E
+ *
+ * Evaluates the=
 current I/O state (`flags`) and context mode to determine
+ * which READ o=
r WRITE events to register in the event loop=2E
+ *
+ * @note This function=
 gets called from client instances from @c io_wait()
+ * and from p2mp (Poi=
nt-to-multipoint) instances in @c multi_io_wait()=2E
+ *
+ * @param c      =
Pointer to the core context=2E
+ * @param es     The event set where descri=
ptors are registered=2E
+ * @param sock   The link socket to configure=2E
+=
 * @param flags  Bitmask of active I/O operation requests (e=2Eg=2E, @ref I=
OW_TO_LINK,
+ * @ref IOW_READ_TUN, @ref IOW_TO_TUN, @ref IOW_SHAPER)=2E
+ *=
/
+void multi_io_process_flags(struct context *c, struct event_set *es, str=
uct link_socket *sock, const unsigned int flags);
 
 void io_wait(struct co=
ntext *c, const unsigned int flags);
 
diff --git a/src/openvpn/mudp=2Ec b/=
src/openvpn/mudp=2Ec
index dded1ee=2E=2E143a330 100644
--- a/src/openvpn/mu=
dp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -340,18 +340,17 @@
  * Process a UDP s=
ocket event=2E
  */
 void
-multi_process_io_udp(struct multi_context *m, st=
ruct link_socket *sock)
+multi_process_io_udp(struct multi_context *m, stru=
ct link_socket *sock, unsigned int rwflags)
 {
-    const unsigned int stat=
us =3D m->multi_io->udp_flags;
     const unsigned int mpp_flags =3D (MPP_P=
RE_SELECT | MPP_CLOSE_ON_SIGNAL);
 
     /* UDP port ready to accept write =
*/
-    if (status & SOCKET_WRITE)
+    if (rwflags & SOCKET_WRITE)
     {
=
         multi_process_outgoing_link(m, mpp_flags);
     }
     /* Incoming=
 data on UDP port */
-    else if (status & SOCKET_READ)
+    else if (rwfl=
ags & SOCKET_READ)
     {
         read_incoming_link(&m->top, sock);
     =
    if (!IS_SIG(&m->top))
@@ -359,36 +358,4 @@
             multi_process_i=
ncoming_link(m, NULL, mpp_flags, sock);
         }
     }
-
-    m->multi_i=
o->udp_flags =3D ES_ERROR;
-}
-
-/*
- * Return the io_wait() flags appropri=
ate for
- * a point-to-multipoint tunnel=2E
- */
-unsigned int
-p2mp_iow_fl=
ags(const struct multi_context *m)
-{
-    unsigned int flags =3D IOW_WAIT_=
SIGNAL;
-    if (m->pending)
-    {
-        if (TUN_OUT(&m->pending->conte=
xt))
-        {
-            flags |=3D IOW_TO_TUN;
-        }
-        if =
(LINK_OUT(&m->pending->context))
-        {
-            flags |=3D IOW_TO_=
LINK;
-        }
-    }
-    else if (mbuf_defined(m->mbuf))
-    {
-      =
  flags |=3D IOW_MBUF;
-    }
-    else
-    {
-        flags |=3D IOW_READ=
;
-    }
-    return flags;
 }
diff --git a/src/openvpn/mudp=2Eh b/src/open=
vpn/mudp=2Eh
index 005ee10=2E=2E6567539 100644
--- a/src/openvpn/mudp=2Eh
+=
++ b/src/openvpn/mudp=2Eh
@@ -30,9 +30,7 @@
 struct context;
 struct multi_=
context;
 
-unsigned int p2mp_iow_flags(const struct multi_context *m);
-
-=
void multi_process_io_udp(struct multi_context *m, struct link_socket *sock=
);
+void multi_process_io_udp(struct multi_context *m, struct link_socket *=
sock, unsigned int rwflags);
 /********************************************=
******************************/
 /**
  * Get, and if necessary create, the =
multi_instance associated with a
diff --git a/src/openvpn/multi_io=2Ec b/sr=
c/openvpn/multi_io=2Ec
index e6f4e9c=2E=2E04c57e9 100644
--- a/src/openvpn/=
multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -154,6 +154,40 @@
     }
 }
=
 
+/*
+ * Return the io flags appropriate for
+ * a point-to-multipoint tun=
nel=2E
+ */
+unsigned int
+p2mp_iow_flags(const struct multi_context *m, st=
ruct link_socket *sock)
+{
+    unsigned int flags =3D IOW_WAIT_SIGNAL;
+
+=
    if (m->pending)
+    {
+        if (TUN_OUT(&m->pending->context))
+   =
     {
+            flags |=3D IOW_TO_TUN;
+        }
+
+        /* If the =
to be processed socket happens to be the same one on the pending
+         =
* UDP client instance, we set that socket ready for write */
+        if (L=
INK_OUT(&m->pending->context) && m->pending->context=2Ec2=2Elink_sockets[0]=
 =3D=3D sock)
+        {
+            flags |=3D IOW_TO_LINK;
+        }
+ =
   }
+    else if (mbuf_defined(m->mbuf))
+    {
+        flags |=3D IOW_MB=
UF;
+    }
+    else
+    {
+        flags |=3D IOW_READ;
+    }
+    retur=
n flags;
+}
+
 int
 multi_io_wait(struct multi_context *m)
 {
@@ -171,7 +20=
5,17 @@
 
     if (has_udp_in_local_list(&m->top=2Eoptions))
     {
-      =
  get_io_flags_udp(&m->top, m->multi_io, p2mp_iow_flags(m));
+        for (=
int i =3D 0; i < m->top=2Ec1=2Elink_sockets_num; i++)
+        {
+         =
   struct link_socket *sock =3D m->top=2Ec2=2Elink_sockets[i];
+
+         =
   if ((m->top=2Eoptions=2Emode =3D=3D MODE_SERVER) && proto_is_dgram(sock-=
>info=2Eproto))
+            {
+                unsigned int flags =3D p2mp=
_iow_flags(m, sock);
+
+                multi_io_process_flags(&m->top, m->=
multi_io->es, sock, flags);
+            }
+        }
     }
 
     tun_set=
(m->top=2Ec1=2Etuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, persisten=
t);
@@ -457,7 +501,7 @@
                     }
                     else
  =
                   {
-                        multi_process_io_udp(m, ev_ar=
g->u=2Esock);
+                        multi_process_io_udp(m, ev_arg->u=2E=
sock, e->rwflags);
                         mi =3D m->pending;
            =
         }
                     /* monitor and/or handle events that are
di=
ff --git a/src/openvpn/multi_io=2Eh b/src/openvpn/multi_io=2Eh
index 6b2f59=
a=2E=2Eb974a5f 100644
--- a/src/openvpn/multi_io=2Eh
+++ b/src/openvpn/mult=
i_io=2Eh
@@ -55,7 +55,6 @@
     int n_esr;
     int maxevents;
     unsigne=
d int tun_rwflags;
-    unsigned int udp_flags;
 #ifdef ENABLE_MANAGEMENT
 =
    unsigned int management_persist_flags;
 #endif
@@ -65,6 +64,8 @@
 
 voi=
d multi_io_free(struct multi_io *multi_io);
 
+unsigned int p2mp_iow_flags(=
const struct multi_context *m, struct link_socket *sock);
+
 int multi_io_w=
ait(struct multi_context *m);
 
 void multi_io_process_io(struct multi_cont=
ext *m);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchs=
et
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6b30380=
5a3688b6f6363140c76853a58badecd8f
Gerrit-Change-Number: 1635
Gerrit-PatchSe=
t: 6
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: c=
ron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: ordex <antonio@mandelbit=2E=
com>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2E=
muc=2Ede>
Gerrit-Attention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-At=
tention: ordex <antonio@mandelbit=2Ecom>

--UEUcawXvezQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, its_Giaan, ordex, plaisthos=2E </p>
<p>its_Gia=
an <strong>uploaded patch set #6</strong> to this change=2E</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail">View Change=
</a></p><p>The following approvals got outdated and were removed:
Code-Revi=
ew+2 by ordex, Code-Review-1 by cron2</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Multisocket: use eve=
nt engine rwflags for UDP I/O<br><br>udp_flags does not guarantee correct a=
ssociation with the socket being<br>processed=2E Use the rwflags delivered =
by the event engine along with the<br>event to ensure proper per-socket I/O=
 handling=2E<br><br>Remove udp_flags entirely=2E<br><br>Replace the previou=
s global-style flag computation with a per-socket<br>decision model in p2mp=
_iow_flags(), which derives I/O flags<br>directly from the current multi_co=
ntext state and the specific socket<br>being processed=2E This ensures that=
 read/write decisions are correctly<br>bound to the active socket rather th=
an shared or implicit global state=2E<br><br>This change is based on an inv=
estigation triggered by a report from<br>Joshua Rogers using ZeroPath=2E<br=
><br>Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f<br>Signed-off-by:=
 Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M src/ope=
nvpn/forward=2Ec<br>M src/openvpn/forward=2Eh<br>M src/openvpn/mudp=2Ec<br>=
M src/openvpn/mudp=2Eh<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/multi=
_io=2Eh<br>6 files changed, 76 insertions(+), 83 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/35/1635/6</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/fo=
rward=2Ec</span><br><span>index d24f534=2E=2Eab76b9e 100644</span><br><span=
>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2E=
c</span><br><span>@@ -2030,9 +2030,8 @@</span><br><span>     check_timeout_=
random_component(c);</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-multi_io_process_flags(struct context *c, struct =
event_set *es, const unsigned int flags,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                       unsigned int *out_socket, unsigne=
d int *out_tuntap)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_io_process=
_flags(struct context *c, struct event_set *es, struct link_socket *sock, c=
onst unsigned int flags)</span><br><span> {</span><br><span>     unsigned i=
nt socket =3D 0;</span><br><span>     unsigned int tuntap =3D 0;</span><br>=
<span>@@ -2123,50 +2122,19 @@</span><br><span>      * (for TCP server socke=
ts this happens in</span><br><span>      *  socket_set_listen_persistent())=
=2E</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    for (int i =3D 0; i &lt; c-&gt;c1=2Elink_sockets_num; i++)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if ((c-&gt;options=2Emode !=3D MODE=
_SERVER) || (proto_is_dgram(c-&gt;c2=2Elink_sockets[i]-&gt;info=2Eproto)))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            socket_set(c-&gt;c2=2E=
link_sockets[i], es, socket, &amp;c-&gt;c2=2Elink_sockets[i]-&gt;ev_arg, NU=
LL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    socket_set(sock, es, socket, &amp;sock-&gt;ev_arg, NULL);<=
/span><br><span>     tun_set(c-&gt;c1=2Etuntap, es, tuntap, (void *)tun_shi=
ft, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (out_socket)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        *out_socket =3D socket;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (out_tuntap)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *out_tuntap =
=3D tuntap;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span> }</span><br><span> </span><br><span> /*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Wait for I/O events=2E  Used for UDP soc=
kets in</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * point-to-mu=
ltipoint mode=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-get_io_flags_udp(struct context *c, struct multi_io *multi_i=
o, const unsigned int flags)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned =
int out_socket;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_io_process_flags(=
c, multi_io-&gt;es, flags, &amp;out_socket, NULL);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    multi_io-&gt;udp_flags =3D (out_socket &lt=
;&lt; SOCKET_SHIFT);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * This is the core I/O wait function, used for all I/O waits=
 except</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * for the top=
-level server sockets=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * This is the core I/O wait function, used for all I/O waits=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Invoked by P2P instances in tunnel_poi=
nt_to_point() or by P2MP</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * instances within the per-client context in multi_io=2Ec=2E</span><b=
r><span>  */</span><br><span> void</span><br><span> io_wait(struct context =
*c, const unsigned int flags)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    unsigned int out_socket;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    unsigned int out_tuntap;</span><br><s=
pan>     struct event_set_return esr[4];</span><br><span> </span><br><span>=
     /* These shifts all depend on EVENT_READ and EVENT_WRITE */</span><br>=
<span>@@ -2185,7 +2153,7 @@</span><br><span>      */</span><br><span>     e=
vent_reset(c-&gt;c2=2Eevent_set);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    multi_io_process_flags(c, c-&gt;c2=2Eev=
ent_set, flags, &amp;out_socket, &amp;out_tuntap);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    multi_io_process_flags(c, c-&gt;c2=2Eeve=
nt_set, c-&gt;c2=2Elink_sockets[0], flags);</span><br><span> </span><br><sp=
an> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span>  =
   if (c-&gt;c1=2Etuntap)</span><br><span>diff --git a/src/openvpn/forward=
=2Eh b/src/openvpn/forward=2Eh</span><br><span>index 0d3e492=2E=2E324c0b4 1=
00644</span><br><span>--- a/src/openvpn/forward=2Eh</span><br><span>+++ b/s=
rc/openvpn/forward=2Eh</span><br><span>@@ -68,7 +68,22 @@</span><br><span> =
</span><br><span> extern counter_type link_write_bytes_global;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void get_io_flag=
s_udp(struct context *c, struct multi_io *multi_io, const unsigned int flag=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @brief Processes I/O flags to=
 configure socket and TUN/TAP event monitors=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Evaluates the current I/O state (`flags`) and context mode to=
 determine</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * which =
READ or WRITE events to register in the event loop=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @note This function gets called from client instances f=
rom @c io_wait()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
and from p2mp (Point-to-multipoint) instances in @c multi_io_wait()=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param c      Pointer to the core cont=
ext=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param es =
    The event set where descriptors are registered=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param sock   The link socket to confi=
gure=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param fl=
ags  Bitmask of active I/O operation requests (e=2Eg=2E, @ref IOW_TO_LINK,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ref IOW_READ_TUN=
, @ref IOW_TO_TUN, @ref IOW_SHAPER)=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void multi_io_process_flags(struct context *c, struct event_set *es, str=
uct link_socket *sock, const unsigned int flags);</span><br><span> </span><=
br><span> void io_wait(struct context *c, const unsigned int flags);</span>=
<br><span> </span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn=
/mudp=2Ec</span><br><span>index dded1ee=2E=2E143a330 100644</span><br><span=
>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</spa=
n><br><span>@@ -340,18 +340,17 @@</span><br><span>  * Process a UDP socket =
event=2E</span><br><span>  */</span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-multi_process_io_udp(struct multi_context *=
m, struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+multi_process_io_udp(struct multi_context *m, struct link_socket *=
sock, unsigned int rwflags)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    const unsigned int status =3D m-&gt;multi_io-&=
gt;udp_flags;</span><br><span>     const unsigned int mpp_flags =3D (MPP_PR=
E_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span> </span><br><span>     /* =
UDP port ready to accept write */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (status &amp; SOCKET_WRITE)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (rwflags &amp; SOCKET_WRITE)</span><br><s=
pan>     {</span><br><span>         multi_process_outgoing_link(m, mpp_flag=
s);</span><br><span>     }</span><br><span>     /* Incoming data on UDP por=
t */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (stat=
us &amp; SOCKET_READ)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else if (rwflags &amp; SOCKET_READ)</span><br><span>     {</span><br>=
<span>         read_incoming_link(&amp;m-&gt;top, sock);</span><br><span>  =
       if (!IS_SIG(&amp;m-&gt;top))</span><br><span>@@ -359,36 +358,4 @@</s=
pan><br><span>             multi_process_incoming_link(m, NULL, mpp_flags, =
sock);</span><br><span>         }</span><br><span>     }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    m-&gt;multi_io-&gt;udp_flags =3D ES_ERROR;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Return the io_wait=
() flags appropriate for</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * a point-to-multipoint tunnel=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-un=
signed int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-p2mp_iow_fl=
ags(const struct multi_context *m)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uns=
igned int flags =3D IOW_WAIT_SIGNAL;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (m-&gt;pending)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (TUN_OUT(&amp;m-&gt;pending-&gt;context))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            flags |=3D IOW_TO_TUN;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (LINK_OUT(&amp;m-&gt;pending-&gt;context))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            flags |=3D IOW_TO_LINK=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    else if (mbuf_defined(m-&gt;mbuf))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        flags |=3D IOW_MBUF;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fl=
ags |=3D IOW_READ;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return flags;</=
span><br><span> }</span><br><span>diff --git a/src/openvpn/mudp=2Eh b/src/o=
penvpn/mudp=2Eh</span><br><span>index 005ee10=2E=2E6567539 100644</span><br=
><span>--- a/src/openvpn/mudp=2Eh</span><br><span>+++ b/src/openvpn/mudp=2E=
h</span><br><span>@@ -30,9 +30,7 @@</span><br><span> struct context;</span>=
<br><span> struct multi_context;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-unsigned int p2mp_iow_flags(const struct multi=
_context *m);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void multi_process_io_udp(str=
uct multi_context *m, struct link_socket *sock);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void multi_process_io_udp(struct multi_context=
 *m, struct link_socket *sock, unsigned int rwflags);</span><br><span> /***=
***********************************************************************/</s=
pan><br><span> /**</span><br><span>  * Get, and if necessary create, the mu=
lti_instance associated with a</span><br><span>diff --git a/src/openvpn/mul=
ti_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index e6f4e9c=2E=2E04c=
57e9 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>=
+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -154,6 +154,40 @@</span><=
br><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Return the io flags appropriate for</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * a point-to-multipoint tunnel=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+p2mp_iow_flags(const struct multi_context *m, s=
truct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned =
int flags =3D IOW_WAIT_SIGNAL;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
m-&gt;pending)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (TUN_OUT=
(&amp;m-&gt;pending-&gt;context))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            flags |=3D IOW_TO_TUN;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 If the to be processed socket happens to be the same one on the pending</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * UDP client =
instance, we set that socket ready for write */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (LINK_OUT(&amp;m-&gt;pending-&gt;con=
text) &amp;&amp; m-&gt;pending-&gt;context=2Ec2=2Elink_sockets[0] =3D=3D so=
ck)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            flags |=3D IOW=
_TO_LINK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else if (mbuf_defined(m-&gt;mb=
uf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        flags |=3D IOW_MBUF;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        flags |=3D IOW_READ;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return flags;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> int</span><br><span> multi_io_wait(struct multi_context *m)</span>=
<br><span> {</span><br><span>@@ -171,7 +205,17 @@</span><br><span> </span><=
br><span>     if (has_udp_in_local_list(&amp;m-&gt;top=2Eoptions))</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 get_io_flags_udp(&amp;m-&gt;top, m-&gt;multi_io, p2mp_iow_flags(m));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0;=
 i &lt; m-&gt;top=2Ec1=2Elink_sockets_num; i++)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            struct link_socket *sock =3D m-&gt;top=2Ec2=
=2Elink_sockets[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if ((m-=
&gt;top=2Eoptions=2Emode =3D=3D MODE_SERVER) &amp;&amp; proto_is_dgram(sock=
-&gt;info=2Eproto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          unsigned int flags =3D p2mp_iow_flags(m, sock);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                multi_io_process_flags(&amp;m-&gt;top, m=
-&gt;multi_io-&gt;es, sock, flags);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span>     }</span><br><span> </span><br><spa=
n>     tun_set(m-&gt;top=2Ec1=2Etuntap, m-&gt;multi_io-&gt;es, EVENT_READ, =
MULTI_IO_TUN, persistent);</span><br><span>@@ -457,7 +501,7 @@</span><br><s=
pan>                     }</span><br><span>                     else</span>=
<br><span>                     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                        multi_process_io_udp(m, ev_arg-&gt;u=2Es=
ock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          multi_process_io_udp(m, ev_arg-&gt;u=2Esock, e-&gt;rwflags);</spa=
n><br><span>                         mi =3D m-&gt;pending;</span><br><span>=
                     }</span><br><span>                     /* monitor and/=
or handle events that are</span><br><span>diff --git a/src/openvpn/multi_io=
=2Eh b/src/openvpn/multi_io=2Eh</span><br><span>index 6b2f59a=2E=2Eb974a5f =
100644</span><br><span>--- a/src/openvpn/multi_io=2Eh</span><br><span>+++ b=
/src/openvpn/multi_io=2Eh</span><br><span>@@ -55,7 +55,6 @@</span><br><span=
>     int n_esr;</span><br><span>     int maxevents;</span><br><span>     u=
nsigned int tun_rwflags;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    unsigned int udp_flags;</span><br><span> #ifdef ENABLE_MANAGEMENT</s=
pan><br><span>     unsigned int management_persist_flags;</span><br><span> =
#endif</span><br><span>@@ -65,6 +64,8 @@</span><br><span> </span><br><span>=
 void multi_io_free(struct multi_io *multi_io);</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int p2mp_iow_flags(c=
onst struct multi_context *m, struct link_socket *sock);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int multi_io_wait(st=
ruct multi_context *m);</span><br><span> </span><br><span> void multi_io_pr=
ocess_io(struct multi_context *m);</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3D=
email">change 1635</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1635?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1635 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner=
: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
=

</body></html>
--UEUcawXvezQ=--


--===============7196732366901368526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7196732366901368526==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7196732366901368526==--

