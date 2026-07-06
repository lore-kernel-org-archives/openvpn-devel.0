Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F49C43458
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 06:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=+CtZwH7hv5Oyg4N/KoA4k+59/NMSqnFFtLvc9qUfj5o=; b=AzvZAqowzROYT1
	u32fYY/86koxZ94sBlrT5qvy4rx024Q9bWdbYBCHiPqkQSs7t2Z0XD58FZvC+bKJB9h6xFbnpXVh/
	xGtVU54qbYvCKTm16vAN1Vsyhg3GVGwFpAtsbY/dGlh3gVPDw08lgUV68MVxcEBf9Rit4Fx9hFG0z
	8h8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgdAr-0005O9-2O;
	Mon, 06 Jul 2026 06:51:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wgdAp-0005O1-Iu
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:51:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tNTZBrMJ/boFc+zPOWPCI898gwoAQbYOUkMMjaLMaKg=; b=LEUjgOKZ++fCMNCjwDfR3Vo7A3
 eZmr5rZNqiRBdhpLRS1LwTefTPSuLxlkwA3ZWFwNYHjGXXgwAmkDCAXZSsaK7LBKokBUNAsYcyjso
 HUumAVdOvGjCQ8uMwX/ITHtP+C7Nce1PbKh8Fq9j5kwUlunQ9EjwHW2znULkGIjbm4Nw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tNTZBrMJ/boFc+zPOWPCI898gwoAQbYOUkMMjaLMaKg=; b=T
 sMEfv4yaGbmDJQVxQwiTN2nA1UDefvZD9Gzzusv4J+VgOR0adIvN4lJe3iFKWl1iSayhl+V/Zm7O4
 EPz43k63DM9rPN5Nt8cpGVinU7qcU+ipkF9h0z5qgm86iwy60eUFmGgnm/GQ/KhrbAXBSwgtP9X+D
 oOEstB1DxsuxDItk=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wgdAl-000488-0u for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:51:21 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so17594425e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 05 Jul 2026 23:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783320668; x=1783925468; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tNTZBrMJ/boFc+zPOWPCI898gwoAQbYOUkMMjaLMaKg=;
 b=gXZ1X49CnRJs81jk20hEoyXDwEHJJAhb0QOUSwTrnrrc+Km1UYO5/dQDAGoDfJfjwE
 bKJ6aA9dXzglH0wYvJCvPiBo3tfaXgq52IC+KqeYTIpq2T0xQig3ydc5rPYdiCRRAYtC
 U2gV627yKxlQPwkkMplbvH3PNmnLbGFoWgGN6Js8yHnGEkj5JbaCHLGbSHm50bMsw+SV
 y9iN2yZ1/WLiPqOD1t60OFEcG+o/5tLetUCeLkwOdmB+zxwe5AHXHJ51KwX0KFXYUtDr
 NNfUZSxxOtg7gRWX0O/7wL6rloVbgolpzDAaWZ6F9/n+N4U5JOA7fTL0y/evJ6AJYEx2
 AtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783320668; x=1783925468;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tNTZBrMJ/boFc+zPOWPCI898gwoAQbYOUkMMjaLMaKg=;
 b=n7SLIueB1KjsomFVX5jFKUrs8wuvKk7G5fhmEDoGwicjIUNtiGp7NB91Nb+40r/zoN
 zcLR2/yZlmrRRZcDRmVZZa+EZ+zeDSMp5tKCsI1O1Qrph6eTRIoocApOJerVVStSvy1F
 r1cvVB7fhIuGvitziry2+uK4qxlMtfS0D6V1cMEjh7e9tEXPLDpP58aZY5KCqTO6VEih
 auWMHDIeG/xTJkfn0imQ8wk0Kq7lXuuq9jgxKyWSppa00lnmsUMJMRZKk+bZS0w3KEBA
 KkGVN38FU3EhqzBudF+S6U9RtxGq05ToL9grvybbrOZ3R8G7blrIrKo9DAzbeTrocN15
 fp2Q==
X-Gm-Message-State: AOJu0YxuK0TxiKjb4ytTcPADuFLbQsGj6J3BYRRkwphTjff63n3HKVRi
 sXkAO9SrFsyNacECpUejEdrBo1CU8DTQwg5+cGgkNyHRMRDg9o1WGqwUTUyoPEDY95UKe5oFFue
 lwfO7VB5q2ABvyB7mTiucNYp4IkSF9mPr4E0ySZeviM4gi3NyEH8/nrlHaAysmn+5dbLNmXwk2T
 xQESXS8Q==
X-Gm-Gg: AfdE7cnLUdnmq2rJleraB1i8XjLwFxHzSuo4bn4nf2c0T+a+ATavm7CabboAHlDYn/B
 viFsfSwWaTSjtLMBwc4XLFKdm/xUIOta4STWn76IkCEEw+aZM8eQ9mszNwoXkz619xJegK2ukma
 WgOKg2Iu+hM2/tyz9/YRSVlOlHB4k3Ib5GSdriDtTClyM9Upga0Y3J4xQ5dX/BgUtMnGLp5D8Rs
 zdn+7I3Gnm64Dv1kt6sb2D7yn2Vc3US+0uJquFSjwprBLh8lJPf5RWTNGqI0B6tcetdBHggvmyK
 HTZiSSNS57hdjIMPV/rsEPNMvLIZtXyVRir2lVF7iqoJt4+2Y5CQ0Asfiabxudci4wev4cAxLGd
 TIDe8AVdCJttBRIT3vit+Erv8hbUXrFUlehGvOoCFWqgaNRw/FDg8/q2i3pe+mHGccBC8+z2+y/
 ihOJ6Ni87htuMmQ6Nc+rCuLGV0QSldAtaMqVjgyGHd93qVCQ38I0fvKU6/beoVUbkUjAozC2F1O
 U5E47FF3bNz/YUXHibAiY3mu7RsVDPcwD2KIdRyKG8TrvLYQHJh8lvYI/lE0Hb1MmHRX6cyS/IB
 FURdMt5y6p9ujg==
X-Received: by 2002:a05:6000:718:b0:473:a74d:34d7 with SMTP id
 ffacd0b85a97d-47aaa60de9emr9160493f8f.2.1783320667698; 
 Sun, 05 Jul 2026 23:51:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960af0sm20453905f8f.30.2026.07.05.23.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 23:51:07 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 6 Jul 2026 06:51:06 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755
X-Gerrit-Change-Number: 1769
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1769?usp=email>
X-Gerrit-Commit: e5bf3f752723bf8da1d79993651a64c5b3155ba3
References: <gerrit.1783320647000.Iec384ee6844ab278b280d6eafec8aaecf9dde755@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkllYzM4NGVlNjg0NGFiMjc4YjI4MGQ2ZWFmZWM4YWFlY2Y5ZGRlNzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2fa08f93456a85aad051ea56db323ce6c7d66c09-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wgdAl-000488-0u
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: adopt a
 pre-created UDP socket for a client connection
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
Content-Type: multipart/mixed; boundary="===============5586878196900944935=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5586878196900944935==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tPSfUvHlwjc="; charset=UTF-8

--tPSfUvHlwjc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1769?usp=3Demail

to review the following change=2E


Chang=
e subject: socket: adopt a pre-created UDP socket for a client connection
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket: adopt=
 a pre-created UDP socket for a client connection

Add LS_MODE_UDP_ADOPT: a=
 client link_socket can take ownership of an
already-bound UDP socket hande=
d off via c2=2Eoob_probe_adopt/oob_probe_sd
instead of creating its own, an=
d pins c2=2Eoob_probe_remote as the outgoing
address=2E This lets the OOB s=
erver-probe socket become the connection socket,
so the source IP+port and =
destination match what the server's handshake
cookie is bound to=2E

  - li=
nk_socket_init_phase1: adopt the fd, inherit the address family, skip the
 =
   local bind, and pre-set lsa->actual (resolve_remote preserves an already=
-
    defined actual)
  - link_socket_init_phase2: skip create_socket() so =
the adopted fd is not
    clobbered (overlapped-I/O init is fd-independent,=
 so Windows is fine)
  - do_init_socket_phase1: select the mode for the sin=
gle client socket

Dormant until the client sets oob_probe_adopt (next comm=
it)=2E

Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755
Signed-off-by:=
 Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/init=2Ec
M src/openvpn/=
openvpn=2Eh
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
4 files chang=
ed, 65 insertions(+), 2 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/69/1769/1

diff --git a/src/openvpn/init=
=2Ec b/src/openvpn/init=2Ec
index e0d6a14=2E=2E8eca6f7 100644
--- a/src/ope=
nvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3820,6 +3820,12 @@
           =
      mode =3D LS_MODE_TCP_ACCEPT_FROM;
             }
         }
+        =
/* adopt the OOB server-probe socket as this client's connection socket
+  =
       * (handshake shortcut); only the single client socket is ever adopte=
d */
+        else if (c->c2=2Eoob_probe_adopt && i =3D=3D 0)
+        {
+ =
           mode =3D LS_MODE_UDP_ADOPT;
+        }
 
         /* init each s=
ocket with its specific args */
         link_socket_init_phase1(c, i, mode=
);
@@ -3985,6 +3991,16 @@
 static void
 do_close_link_socket(struct context=
 *c)
 {
+    /* An OOB probe socket handed off for the handshake shortcut i=
s adopted by the
+     * link socket in link_socket_init_phase1() (which cl=
ears oob_probe_sd)=2E If the
+     * connection attempt aborted before that=
, the fd is still owned here; close it
+     * so it is not leaked when con=
text_clear_2() zeroes c2=2E */
+    if (c->c2=2Eoob_probe_sd !=3D SOCKET_UN=
DEFINED)
+    {
+        openvpn_close_socket(c->c2=2Eoob_probe_sd);
+     =
   c->c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;
+    }
+
     if (c->c2=2Elin=
k_sockets && c->c2=2Elink_socket_owned)
     {
         for (int i =3D 0; i=
 < c->c1=2Elink_sockets_num; i++)
diff --git a/src/openvpn/openvpn=2Eh b/sr=
c/openvpn/openvpn=2Eh
index fa00822=2E=2Ee5a1d76 100644
--- a/src/openvpn/o=
penvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -239,7 +239,16 @@
 
     bool l=
ink_socket_owned;
 
-    const struct link_socket *accept_from;   /* possib=
ly do accept() on a parent link_socket */
+    const struct link_socket *ac=
cept_from; /* possibly do accept() on a parent link_socket */
+
+    /* OOB=
 server-probe handshake shortcut: when oob_probe_adopt is true, the
+     *=
 connection adopts oob_probe_sd (the winning remote's already-bound probe
+=
     * socket) instead of creating one, and pins oob_probe_remote (the exac=
t
+     * address probed) as the outgoing address, so the source IP+port an=
d the
+     * destination match what the server's handshake cookie is bound=
 to=2E */
+    bool oob_probe_adopt;
+    socket_descriptor_t oob_probe_sd;=

+    struct openvpn_sockaddr oob_probe_remote;
 
     struct link_socket_a=
ctual *to_link_addr; /* IP address of remote */
     struct link_socket_act=
ual from;          /* address of incoming datagram */
diff --git a/src/open=
vpn/socket=2Ec b/src/openvpn/socket=2Ec
index df2cc9e=2E=2Ea9dca0a 100644
-=
-- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -1428,6 +1428,4=
1 @@
         /* inherit (possibly guessed) info AF from parent context */
=
         sock->info=2Eaf =3D c->c2=2Eaccept_from->info=2Eaf;
     }
+    el=
se if (mode =3D=3D LS_MODE_UDP_ADOPT)
+    {
+        /* Adopt the OOB prob=
e socket: same source IP+port the server's cookie is
+         * bound to=
=2E It is already bound, so do not bind again=2E */
+        ASSERT(c->c2=
=2Eoob_probe_sd !=3D SOCKET_UNDEFINED);
+        sock->sd =3D c->c2=2Eoob_p=
robe_sd;
+        c->c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED; /* ownership m=
oves to the link socket */
+        sock->info=2Eaf =3D c->c2=2Eoob_probe_r=
emote=2Eaddr=2Esa=2Esa_family;
+        sock->bind_local =3D false;
+
+    =
    /* The probe socket was created plainly, so apply the same options
+   =
      * create_socket() would (it is already bound, so no bind here)=2E
+  =
       * --multihome's IP_PKTINFO never applies to a probing client, so it =
is
+         * intentionally not set=2E */
+        sock->sockflags |=3D SF=
_GETADDRINFO_DGRAM;
+        socket_set_buffers(sock->sd, &sock->socket_buf=
fer_sizes, true);
+        socket_set_mark(sock->sd, sock->mark);
+#if defi=
ned(TARGET_LINUX)
+        if (sock->bind_dev)
+        {
+            msg(=
M_INFO, "Using bind-dev %s", sock->bind_dev);
+            if (setsockopt(s=
ock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_dev,
+                    =
       strlen(sock->bind_dev) + 1)
+                !=3D 0)
+            {
=
+                msg(M_WARN | M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=3D=
%s failed", sock->bind_dev);
+            }
+        }
+#endif
+
+        /=
* Pin the exact address we probed so the connection targets the address
+  =
       * the cookie was minted for; resolve_remote() preserves a defined ac=
tual=2E */
+        CLEAR(sock->info=2Elsa->actual);
+        sock->info=2E=
lsa->actual=2Edest =3D c->c2=2Eoob_probe_remote;
+    }
 
     /* are we ru=
nning in HTTP proxy mode? */
     if (sock->http_proxy)
@@ -1720,7 +1755,7 =
@@
         goto done;
     }
 #endif
-    if (sock->info=2Elsa->current_re=
mote)
+    if (sock->mode !=3D LS_MODE_UDP_ADOPT && sock->info=2Elsa->curre=
nt_remote)
     {
         create_socket(sock, sock->info=2Elsa->current_re=
mote);
     }
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
=
index cd4e8ed=2E=2Ed807f36 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/op=
envpn/socket=2Eh
@@ -197,6 +197,9 @@
 #define LS_MODE_DEFAULT         0
 #d=
efine LS_MODE_TCP_LISTEN      1
 #define LS_MODE_TCP_ACCEPT_FROM 2
+/* Adop=
t a pre-created, already-bound UDP socket (from the OOB server probe) as
+ =
* the connection socket, instead of creating one=2E */
+#define LS_MODE_UDP=
_ADOPT       3
     int mode;
 
     int resolve_retry_seconds;

-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1769?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iec384ee6844ab278b280d6eafec8a=
aecf9dde755
Gerrit-Change-Number: 1769
Gerrit-PatchSet: 1
Gerrit-Owner: sti=
pa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--tPSfUvHlwjc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1769?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">so=
cket: adopt a pre-created UDP socket for a client connection<br><br>Add LS_=
MODE_UDP_ADOPT: a client link_socket can take ownership of an<br>already-bo=
und UDP socket handed off via c2=2Eoob_probe_adopt/oob_probe_sd<br>instead =
of creating its own, and pins c2=2Eoob_probe_remote as the outgoing<br>addr=
ess=2E This lets the OOB server-probe socket become the connection socket,<=
br>so the source IP+port and destination match what the server&#39;s handsh=
ake<br>cookie is bound to=2E<br><br>  - link_socket_init_phase1: adopt the =
fd, inherit the address family, skip the<br>    local bind, and pre-set lsa=
-&gt;actual (resolve_remote preserves an already-<br>    defined actual)<br=
>  - link_socket_init_phase2: skip create_socket() so the adopted fd is not=
<br>    clobbered (overlapped-I/O init is fd-independent, so Windows is fin=
e)<br>  - do_init_socket_phase1: select the mode for the single client sock=
et<br><br>Dormant until the client sets oob_probe_adopt (next commit)=2E<br=
><br>Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755<br>Signed-off-by:=
 Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/init=2Ec<br=
>M src/openvpn/openvpn=2Eh<br>M src/openvpn/socket=2Ec<br>M src/openvpn/soc=
ket=2Eh<br>4 files changed, 65 insertions(+), 2 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/69/1769/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec</span><br><span>index e0d6a14=2E=2E8eca6f7 100644</span><br><span>--- =
a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br=
><span>@@ -3820,6 +3820,12 @@</span><br><span>                 mode =3D LS_=
MODE_TCP_ACCEPT_FROM;</span><br><span>             }</span><br><span>      =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* adop=
t the OOB server-probe socket as this client&#39;s connection socket</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+         * (handshake shor=
tcut); only the single client socket is ever adopted */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        else if (c-&gt;c2=2Eoob_probe_a=
dopt &amp;&amp; i =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          mode =3D LS_MODE_UDP_ADOPT;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span> </span><br><span>         /* i=
nit each socket with its specific args */</span><br><span>         link_soc=
ket_init_phase1(c, i, mode);</span><br><span>@@ -3985,6 +3991,16 @@</span><=
br><span> static void</span><br><span> do_close_link_socket(struct context =
*c)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* An OOB probe socket handed off for the handshake shortcut is adop=
ted by the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * li=
nk socket in link_socket_init_phase1() (which clears oob_probe_sd)=2E If th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * connection =
attempt aborted before that, the fd is still owned here; close it</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * so it is not leaked wh=
en context_clear_2() zeroes c2=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (c-&gt;c2=2Eoob_probe_sd !=3D SOCKET_UNDEFINED)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        openvpn_close_socket(c-&gt;c2=
=2Eoob_probe_sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      c-&gt;c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     if (c-&gt;c2=2Elink_sockets &amp;=
&amp; c-&gt;c2=2Elink_socket_owned)</span><br><span>     {</span><br><span>=
         for (int i =3D 0; i &lt; c-&gt;c1=2Elink_sockets_num; i++)</span><=
br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</sp=
an><br><span>index fa00822=2E=2Ee5a1d76 100644</span><br><span>--- a/src/op=
envpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</span><br><=
span>@@ -239,7 +239,16 @@</span><br><span> </span><br><span>     bool link_=
socket_owned;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    const struct link_socket *accept_from;   /* possibly do accep=
t() on a parent link_socket */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const struct link_socket *accept_from; /* possibly do accept=
() on a parent link_socket */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* OO=
B server-probe handshake shortcut: when oob_probe_adopt is true, the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * connection adopts o=
ob_probe_sd (the winning remote&#39;s already-bound probe</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * socket) instead of creating on=
e, and pins oob_probe_remote (the exact</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * address probed) as the outgoing address, so the =
source IP+port and the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * destination match what the server&#39;s handshake cookie is bound=
 to=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool o=
ob_probe_adopt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
socket_descriptor_t oob_probe_sd;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct openvpn_sockaddr oob_probe_remote;</span><br><span=
> </span><br><span>     struct link_socket_actual *to_link_addr; /* IP addr=
ess of remote */</span><br><span>     struct link_socket_actual from;      =
    /* address of incoming datagram */</span><br><span>diff --git a/src/ope=
nvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index df2cc9e=2E=
=2Ea9dca0a 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><s=
pan>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -1428,6 +1428,41 @@</sp=
an><br><span>         /* inherit (possibly guessed) info AF from parent con=
text */</span><br><span>         sock-&gt;info=2Eaf =3D c-&gt;c2=2Eaccept_f=
rom-&gt;info=2Eaf;</span><br><span>     }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else if (mode =3D=3D LS_MODE_UDP_ADOPT)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* Adopt the OOB probe socket: sa=
me source IP+port the server&#39;s cookie is</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+         * bound to=2E It is already bound, so do =
not bind again=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        ASSERT(c-&gt;c2=2Eoob_probe_sd !=3D SOCKET_UNDEFINED);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;sd =3D c-&gt;c=
2=2Eoob_probe_sd;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      c-&gt;c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED; /* ownership moves to t=
he link socket */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      sock-&gt;info=2Eaf =3D c-&gt;c2=2Eoob_probe_remote=2Eaddr=2Esa=2Esa_f=
amily;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sock-=
&gt;bind_local =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Th=
e probe socket was created plainly, so apply the same options</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+         * create_socket() would =
(it is already bound, so no bind here)=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+         * --multihome&#39;s IP_PKTINFO never applies=
 to a probing client, so it is</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         * intentionally not set=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        sock-&gt;sockflags |=3D SF_GETADDRINF=
O_DGRAM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        soc=
ket_set_buffers(sock-&gt;sd, &amp;sock-&gt;socket_buffer_sizes, true);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        socket_set_mark(=
sock-&gt;sd, sock-&gt;mark);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(TARGET_LINUX)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (sock-&gt;bind_dev)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(M_INFO, &quot;Using bind-dev %s&quot;, sock=
-&gt;bind_dev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (setsockopt(sock-&gt;sd, SOL_SOCKET, SO_BINDTODEVICE, sock-&gt;b=
ind_dev,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                strlen(sock-&gt;bind_dev) + 1)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                !=3D 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                msg(M_WARN | M_ERRNO, &quot;WARN: =
setsockopt SO_BINDTODEVICE=3D%s failed&quot;, sock-&gt;bind_dev);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* Pin the exact address we probed so the connection targets the addr=
ess</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * the c=
ookie was minted for; resolve_remote() preserves a defined actual=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(sock-&gt;=
info=2Elsa-&gt;actual);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        sock-&gt;info=2Elsa-&gt;actual=2Edest =3D c-&gt;c2=2Eoob_probe_=
remote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span> </span><br><span>     /* are we running in HTTP proxy mode? */</=
span><br><span>     if (sock-&gt;http_proxy)</span><br><span>@@ -1720,7 +17=
55,7 @@</span><br><span>         goto done;</span><br><span>     }</span><b=
r><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (sock-&gt;info=2Elsa-&gt;current_remote)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (sock-&gt;mode !=3D LS_MODE_UDP_ADOPT &amp;&am=
p; sock-&gt;info=2Elsa-&gt;current_remote)</span><br><span>     {</span><br=
><span>         create_socket(sock, sock-&gt;info=2Elsa-&gt;current_remote)=
;</span><br><span>     }</span><br><span>diff --git a/src/openvpn/socket=2E=
h b/src/openvpn/socket=2Eh</span><br><span>index cd4e8ed=2E=2Ed807f36 10064=
4</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span>+++ b/src/op=
envpn/socket=2Eh</span><br><span>@@ -197,6 +197,9 @@</span><br><span> #defi=
ne LS_MODE_DEFAULT         0</span><br><span> #define LS_MODE_TCP_LISTEN   =
   1</span><br><span> #define LS_MODE_TCP_ACCEPT_FROM 2</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* Adopt a pre-created, already-bound U=
DP socket (from the OOB server probe) as</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * the connection socket, instead of creating one=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define LS_MODE_UD=
P_ADOPT       3</span><br><span>     int mode;</span><br><span> </span><br>=
<span>     int resolve_retry_seconds;</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1769?usp=
=3Demail">change 1769</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1769?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1769 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--tPSfUvHlwjc=--


--===============5586878196900944935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5586878196900944935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5586878196900944935==--

