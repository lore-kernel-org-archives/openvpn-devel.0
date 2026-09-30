Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6E3CA5FC3
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wX23i81krHsLPPofj7Xf6gU0PIIsVxCfXg3BT3yy5E8=; b=GRtPHuePbzzaLipKA+TVFyL0FV
	BjHSzPFfdEGEdO+frDaBQCp+zu523mzVhn3zmZlyLXSWC82Kc5CgrodCGSWCSBAzHbJ1hNCtAMsQd
	g8DTwpjNilVrdBlsC4tknes/G4Ydooz6ByuVxem3Hixkw8ZUQ6j0tzjWVhN/AU6VdQVY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpeM-0003MW-45;
	Wed, 30 Sep 2026 08:26:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpe2-0003GI-47
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vCWVWooc5pyAkZGbvQiAWdiMCpsA0AqyXWH6+4JnB+o=; b=EXRDfWlzDEc5+5CkSREGB1q1wj
 T51VpfHonjp06Dh3bplSP7bLGKaBC1PLXdBmCHSHsLfjrksmVulDtQAeCZecHnn9FekpJK9A64Uyh
 vGu0wj3UXLhYW6BIlFRrugeIqjpRJnJu9if4x955bshD4EKJuQhul+MJ1JyB+XGoEskI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vCWVWooc5pyAkZGbvQiAWdiMCpsA0AqyXWH6+4JnB+o=; b=M
 1IBPRXWnDCcu2FBgIQAjfkwpwapn7W3eQMLndo9YYKKI39LmZ6tq1G1FV2ae1x3mf768a8SfZ8BuL
 +x9T1WovjDIxBNGoZy1S01u17lGMFd1/JpxoERwDtP0H/hNhohbWaDOaknzPttvTZqjb/r2UJ0c9a
 lnR6uDiBN/4mW3m4=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpdt-0006km-IW for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:23 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912df756so39301395e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756775; x=1791361575; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vCWVWooc5pyAkZGbvQiAWdiMCpsA0AqyXWH6+4JnB+o=;
 b=Gi40JQx+VkJxMvWIp7W8qTWw/v+k0oO2F4kLsy8HfK44t0qhVNbfJleEvUb3i9PEIN
 arSeelgGvpwjUPjqFpThzzyQfiCMV1YUww/i1B8CpYUs3SDbk03bcU9WEkaeG+KzUW0G
 snLvOu100dLWqQp/b6wEEbh5sFNazlh8ybC+s7QQ0fDtGL/hi5h2k7CTzljiFP0xVCiu
 fvYB42jqusXC20n7SExpOeCBletQGQgzhsXRHbz5VEtOys+75D75dJQBaagxIA2c2ZLB
 GEBwjlq2kYBRO8p7UHKtjCe78L8uNwN+w6/DLQ+hxUI3tw/MYiKWpku2gMkq85582ZZp
 Z/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756775; x=1791361575;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vCWVWooc5pyAkZGbvQiAWdiMCpsA0AqyXWH6+4JnB+o=;
 b=lnaUgJ02gyhOG8tF46TAa1gCO7k7yD+AqNmwUS2oJ7bjfIHklO2TdN4zjDhU5pPb0f
 NJ0jD8K7EJJAmVwgGBaT0P5ntdB+LwArM3Na/KaF2vitmBltgNKjcERQ6YLxARXidU0W
 DFlURw35RzcfmnNUSWfmwX9h1H9db23joIxM5A5OFYUlLaqD1s7CU8dfbo4Z4UACDIiW
 yaseW4w10BsIqLiA7oQM8oTn1cJlXmx8E0dBMebAw1J9iUpwf6X5JTPGubR5aJtM+CYx
 fwzc0W05gdmI4TlTSo85g5OyDRyj9b9xcaQsbdxjEgxl7gQ2nzOVHaivnv7Nlh+wWjsQ
 co9w==
X-Gm-Message-State: AFuF++nINk6ktGEW8jtfisyjT4pPEQblgPg8SB70XoobxxziDeJqmkrQ
 zRc4DqkdnQYC5iDZvckj1AKkcgb13m7h7n6s7htRGHosoLJlC19LIzwDIwGl1QtrYcI2r3f2bAd
 4u88ITNyKFnCHLgmp2Jw6SPLGPhMt7FeFe2qTCNmeiBTNkomJEIpASXqZ55urPc2VZN7HTTpr3d
 DlnLSX7A==
X-Gm-Gg: AYBFou2ZFjofC+LGU3SNI1YHBSqRr9IGYD2Us01fPRJwXUVBXB++R0MozNWX/RS/fSp
 hS3Fu8dHRM2vCveSTHhUHbJbu09nRtKIZGfsp4d90BJ69xbB7AlfFx0+Pg451kujdOPY7DWRwup
 A5EFt/h8uzSB+NWeGbA0VmD3+rvKBGrog04wVd32FynrD/JE7nMASsarjI5em6ZTdkcj709IfuG
 aWB9uG+u9phk0TL0tjlycrhdX/c2JvymoldZ0vnO1wqmFLcx+m2GAoYQrc8HIBvV25ICz7gnreR
 lQ5SGCsAOB503iO2NIwAu2mCGPJgwFFGAueWCseYJYQ/IJglI+szG1NelFkcnOcrLnWDIGaOrBa
 3BkmWnt6Sac2U8i9eajkYMumDG/4/aK0FGNeNvDB9Fdxalhvb6momw0E/HayBRtPX7FH2QX5NNk
 XV+YDew3BxCfpmR4KFznoq61whtQw1Ues2wGnz4fNOGDZDsjYReRxonI7FkHsJhOz0z7uFkkFzN
 asT4KY9/hUzkndgN3Z9K9W8U2rSNAKW6mjPr4z3vkPlXJtujPYCVPq2iiFx9o8TJjj99VZml6jz
 xD7Srrf7FG4+zNrPSsLhbyodj1pMKljCK9nplsqe2XaHlqiv4zhiG09YBwFy
X-Received: by 2002:a05:600c:3e1b:b0:4a0:159b:d2a9 with SMTP id
 5b1f17b1804b1-4a01b126300mr10675495e9.24.1790756774801; 
 Wed, 30 Sep 2026 01:26:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a017b7bbc1sm37191715e9.10.2026.09.30.01.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:26:14 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:25:29 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755
X-Gerrit-Change-Number: 1769
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1769?usp=email>
X-Gerrit-Commit: a396158d815c3a767935711426cea95665c1273b
In-Reply-To: <gerrit.1783320647000.Iec384ee6844ab278b280d6eafec8aaecf9dde755@gerrit.openvpn.net>
References: <gerrit.1783320647000.Iec384ee6844ab278b280d6eafec8aaecf9dde755@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkllYzM4NGVlNjg0NGFiMjc4YjI4MGQ2ZWFmZWM4YWFlY2Y5ZGRlNzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5ce4c28383f25b694c9be8e1bbc7e7886ebb281b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpdt-0006km-IW
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: Adopt a
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2836046242957646886=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2836046242957646886==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a3OhxZ9Tqx0="; charset=UTF-8

--a3OhxZ9Tqx0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1769?usp=3Demail

to look a=
t the new patch set (#27)=2E


Change subject: socket: Adopt a pre-created =
UDP socket for a client connection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

socket: Adopt a pre-created UDP socket for a client =
connection

Add LS_MODE_UDP_ADOPT: a client link_socket can take ownership =
of a UDP
socket, set up like the connection socket (bound unless --nobind),=

handed off via c2=2Eoob_probe_adopt/oob_probe_sd instead of creating its
o=
wn, and pin c2=2Eoob_probe_remote as the outgoing address=2E This lets the
=
OOB server-probe socket become the connection socket, so the source
IP+port=
 and destination match what the server's handshake cookie is
bound to=2E

 =
 - link_socket_init_phase1: adopt the fd, inherit the address family
    an=
d pre-set lsa->actual (resolve_remote preserves an already-defined
    actu=
al)=2E The probe socket was created and bound by
    create_socket_udp_conf=
igured() with the link socket's options, so
    nothing is applied or bound=
 here=2E It also takes the probe's
    lookup (c2=2Eoob_probe_remote_list) =
as the remote list, with
    current_remote at the address that answered: i=
ncoming packets are
    checked against remote_list, and a second lookup ma=
y return other
    addresses (round-robin DNS), whose check would drop the =
server's
    replies
  - linksock_print_addr: report an adopted socket's lo=
cal address from
    getsockname(), since bind_local is cleared to mean "do=
 not bind
    again" and the socket may well be bound
  - link_socket_init_=
phase2: skip create_socket() so the adopted fd is
    not clobbered (overla=
pped-I/O init is fd-independent, so Windows is
    fine)
  - do_init_socket=
_phase1: select the mode for the single client socket
  - do_close_link_soc=
ket: close the handed-off fd and free the
    handed-off lookup if the atte=
mpt aborted before they were adopted,
    so neither is leaked=2E context_c=
lear_2() sets oob_probe_sd to
    SOCKET_UNDEFINED, since 0 is a valid desc=
riptor, and
    inherit_context_child() does the same for a server's per-cl=
ient
    contexts

The adopt path itself stays unused until the client sets=
 oob_probe_adopt
(next commit)=2E

Change-Id: Iec384ee6844ab278b280d6eafec8=
aaecf9dde755
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/open=
vpn/init=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/socket=2Ec
M src/openv=
pn/socket=2Eh
4 files changed, 105 insertions(+), 3 deletions(-)


  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/69/1769/27

diff=
 --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index fb1aa2a=2E=2E560=
9534 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -90,6 =
+90,8 @@
 context_clear_2(struct context *c)
 {
     CLEAR(c->c2);
+    /* =
0 is a valid descriptor, so "no socket" has to be set explicitly */
+    c-=
>c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;
 }
 
 void
@@ -3465,6 +3467,18 @@
=
     }
 }
 
+/* Free a probe lookup no connection took, as clear_remote_add=
rlist() frees a
+ * remote list: a --preresolve list belongs to the DNS cac=
he=2E */
+static void
+oob_probe_free_remote_list(struct context *c)
+{
+  =
  if (c->c2=2Eoob_probe_remote_list && !c->options=2Eresolve_in_advance)
+ =
   {
+        freeaddrinfo(c->c2=2Eoob_probe_remote_list);
+    }
+    c->c=
2=2Eoob_probe_remote_list =3D NULL;
+}
+
 static void
 do_init_frame_tls(st=
ruct context *c)
 {
@@ -3788,6 +3802,12 @@
                 mode =3D LS_MOD=
E_TCP_ACCEPT_FROM;
             }
         }
+        /* adopt the OOB serv=
er-probe socket as this client's connection socket
+         * (probe-start=
ed handshake); only the single client socket is ever adopted */
+        el=
se if (c->c2=2Eoob_probe_adopt && i =3D=3D 0)
+        {
+            mode =
=3D LS_MODE_UDP_ADOPT;
+        }
 
         /* init each socket with its s=
pecific args */
         link_socket_init_phase1(c, i, mode);
@@ -3953,6 +3=
973,17 @@
 static void
 do_close_link_socket(struct context *c)
 {
+    /* =
An OOB probe socket handed off for a probe-started handshake is adopted by =
the
+     * link socket in link_socket_init_phase1() (which clears oob_prob=
e_sd)=2E If the
+     * connection attempt aborted before that, the fd is s=
till owned here; close it
+     * so it is not leaked when context_clear_2(=
) zeroes c2=2E */
+    if (c->c2=2Eoob_probe_sd !=3D SOCKET_UNDEFINED)
+   =
 {
+        openvpn_close_socket(c->c2=2Eoob_probe_sd);
+        c->c2=2Eoo=
b_probe_sd =3D SOCKET_UNDEFINED;
+    }
+    oob_probe_free_remote_list(c);=

+
     if (c->c2=2Elink_sockets && c->c2=2Elink_socket_owned)
     {
     =
    for (int i =3D 0; i < c->c1=2Elink_sockets_num; i++)
@@ -4807,6 +4838,8=
 @@
 inherit_context_child(struct context *dest, const struct context *src,=
 struct link_socket *sock)
 {
     CLEAR(*dest);
+    /* 0 is a valid descr=
iptor, so "no socket" has to be set explicitly */
+    dest->c2=2Eoob_probe=
_sd =3D SOCKET_UNDEFINED;
 
     /* proto_is_dgram will ASSERT(0) if proto =
is invalid */
     dest->mode =3D proto_is_dgram(sock->info=2Eproto) ? CM_C=
HILD_UDP : CM_CHILD_TCP;
diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn=
/openvpn=2Eh
index e9e18bf=2E=2Ec0c6ccc 100644
--- a/src/openvpn/openvpn=2E=
h
+++ b/src/openvpn/openvpn=2Eh
@@ -240,7 +240,18 @@
 
     bool link_socke=
t_owned;
 
-    const struct link_socket *accept_from;   /* possibly do acc=
ept() on a parent link_socket */
+    const struct link_socket *accept_from=
; /* possibly do accept() on a parent link_socket */
+
+    /* OOB probe-st=
arted handshake: when oob_probe_adopt is true, the
+     * connection adopt=
s oob_probe_sd (the winning remote's probe
+     * socket) instead of creat=
ing one, and pins oob_probe_remote (the exact
+     * address probed) as th=
e outgoing address, so the source IP+port and the
+     * destination match=
 what the server's handshake cookie is bound to=2E */
+    bool oob_probe_a=
dopt;
+    socket_descriptor_t oob_probe_sd;
+    struct openvpn_sockaddr o=
ob_probe_remote;
+    /* the lookup the probe used; the connection takes it=
 as its remote_list */
+    struct addrinfo *oob_probe_remote_list;
 
     =
struct link_socket_actual *to_link_addr; /* IP address of remote */
     st=
ruct link_socket_actual from;          /* address of incoming datagram */
d=
iff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index e7acabc=
=2E=2Ef3d6ef0 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=
=2Ec
@@ -1431,6 +1431,48 @@
         /* inherit (possibly guessed) info AF =
from parent context */
         sock->info=2Eaf =3D c->c2=2Eaccept_from->in=
fo=2Eaf;
     }
+    else if (mode =3D=3D LS_MODE_UDP_ADOPT)
+    {
+      =
  /* Adopt the OOB probe socket=2E create_socket_udp_configured() set it up=
 with this
+         * socket's options and bind, so it only changes hands =
and keeps the source
+         * IP:port the server's cookie is bound to; p=
hase 2 creates nothing=2E */
+        ASSERT(c->c2=2Eoob_probe_sd !=3D SOCK=
ET_UNDEFINED);
+        sock->sd =3D c->c2=2Eoob_probe_sd;
+        c->c2=
=2Eoob_probe_sd =3D SOCKET_UNDEFINED; /* ownership moves to the link socket=
 */
+        sock->info=2Eaf =3D c->c2=2Eoob_probe_remote=2Eaddr=2Esa=2Esa_=
family;
+        sock->bind_local =3D false;              /* bound (or --no=
bind) by the prober already */
+        sock->sockflags |=3D SF_GETADDRINFO=
_DGRAM;
+
+        /* Take the probe's lookup as the remote list, so replie=
s are checked
+         * against the addresses that were probed rather tha=
n against a second
+         * lookup that may return others; resolve_remot=
e() then resolves nothing=2E
+         * Pin the exact address that answere=
d, the one the cookie was minted
+         * for; resolve_remote() preserve=
s a defined actual=2E */
+        struct link_socket_addr *lsa =3D sock->in=
fo=2Elsa;
+        if (lsa->remote_list && !c->options=2Eresolve_in_advance=
)
+        {
+            freeaddrinfo(lsa->remote_list);
+        }
+     =
   lsa->remote_list =3D c->c2=2Eoob_probe_remote_list;
+        c->c2=2Eoob=
_probe_remote_list =3D NULL; /* ownership moves with the socket */
+       =
 lsa->current_remote =3D lsa->remote_list;
+        for (struct addrinfo *a=
i =3D lsa->remote_list; ai; ai =3D ai->ai_next)
+        {
+            if =
(ai->ai_family !=3D c->c2=2Eoob_probe_remote=2Eaddr=2Esa=2Esa_family)
+    =
        {
+                continue;
+            }
+            struct ope=
nvpn_sockaddr entry =3D { 0 };
+            memcpy(&entry, ai->ai_addr, min=
_int((int)ai->ai_addrlen, (int)sizeof(entry)));
+            if (addr_port_=
match(&entry, &c->c2=2Eoob_probe_remote))
+            {
+                l=
sa->current_remote =3D ai; /* a failed attempt moves on from here */
+     =
           break;
+            }
+        }
+        CLEAR(lsa->actual);
+ =
       lsa->actual=2Edest =3D c->c2=2Eoob_probe_remote;
+    }
 
     /* ar=
e we running in HTTP proxy mode? */
     if (sock->http_proxy)
@@ -1515,7 +=
1557,19 @@
     const msglvl_t msglevel =3D (sock->mode =3D=3D LS_MODE_TCP_=
ACCEPT_FROM) ? D_INIT_MEDIUM : M_INFO;
 
     /* print local address */
-  =
  if (sock->bind_local)
+    if (sock->mode =3D=3D LS_MODE_UDP_ADOPT)
+    =
{
+        /* bound (or not) by the prober, so ask the socket itself */
+  =
      struct sockaddr_storage local =3D { 0 };
+        socklen_t len =3D s=
izeof(local);
+        if (!getsockname(sock->sd, (struct sockaddr *)&local=
, &len))
+        {
+            msg(msglevel, "%s link local (adopted): %s=
",
+                proto2ascii(sock->info=2Eproto, sock->info=2Eaf, true),=

+                print_sockaddr((struct sockaddr *)&local, &gc));
+       =
 }
+    }
+    else if (sock->bind_local)
     {
         sa_family_t ai_fa=
mily =3D sock->info=2Elsa->actual=2Edest=2Eaddr=2Esa=2Esa_family;
         =
/* Socket is always bound on the first matching address,
@@ -1727,7 +1781,7=
 @@
         goto done;
     }
 #endif
-    if (sock->info=2Elsa->current_r=
emote)
+    if (sock->mode !=3D LS_MODE_UDP_ADOPT && sock->info=2Elsa->curr=
ent_remote)
     {
         create_socket(sock, sock->info=2Elsa->current_r=
emote);
     }
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh=

index 87945f9=2E=2Ec17d3bb 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/o=
penvpn/socket=2Eh
@@ -198,6 +198,10 @@
 #define LS_MODE_DEFAULT         0
 =
#define LS_MODE_TCP_LISTEN      1
 #define LS_MODE_TCP_ACCEPT_FROM 2
+/* Ad=
opt the OOB server-probe socket, created and set up like a connection
+ * s=
ocket (bound unless --nobind), as the connection socket instead of creating=

+ * one=2E */
+#define LS_MODE_UDP_ADOPT       3
     int mode;
 
     int=
 resolve_retry_seconds;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1769?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755
Gerrit-Change-Number: 1769=

Gerrit-PatchSet: 27
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <r=
alf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Atte=
ntion: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>

--a3OhxZ9Tqx0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #27</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1769?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">socket: Adopt a pre-created UDP socket for a client connection<br=
><br>Add LS_MODE_UDP_ADOPT: a client link_socket can take ownership of a UD=
P<br>socket, set up like the connection socket (bound unless --nobind),<br>=
handed off via c2=2Eoob_probe_adopt/oob_probe_sd instead of creating its<br=
>own, and pin c2=2Eoob_probe_remote as the outgoing address=2E This lets th=
e<br>OOB server-probe socket become the connection socket, so the source<br=
>IP+port and destination match what the server&#39;s handshake cookie is<br=
>bound to=2E<br><br>  - link_socket_init_phase1: adopt the fd, inherit the =
address family<br>    and pre-set lsa-&gt;actual (resolve_remote preserves =
an already-defined<br>    actual)=2E The probe socket was created and bound=
 by<br>    create_socket_udp_configured() with the link socket&#39;s option=
s, so<br>    nothing is applied or bound here=2E It also takes the probe&#3=
9;s<br>    lookup (c2=2Eoob_probe_remote_list) as the remote list, with<br>=
    current_remote at the address that answered: incoming packets are<br>  =
  checked against remote_list, and a second lookup may return other<br>    =
addresses (round-robin DNS), whose check would drop the server&#39;s<br>   =
 replies<br>  - linksock_print_addr: report an adopted socket&#39;s local a=
ddress from<br>    getsockname(), since bind_local is cleared to mean &quot=
;do not bind<br>    again&quot; and the socket may well be bound<br>  - lin=
k_socket_init_phase2: skip create_socket() so the adopted fd is<br>    not =
clobbered (overlapped-I/O init is fd-independent, so Windows is<br>    fine=
)<br>  - do_init_socket_phase1: select the mode for the single client socke=
t<br>  - do_close_link_socket: close the handed-off fd and free the<br>    =
handed-off lookup if the attempt aborted before they were adopted,<br>    s=
o neither is leaked=2E context_clear_2() sets oob_probe_sd to<br>    SOCKET=
_UNDEFINED, since 0 is a valid descriptor, and<br>    inherit_context_child=
() does the same for a server&#39;s per-client<br>    contexts<br><br>The a=
dopt path itself stays unused until the client sets oob_probe_adopt<br>(nex=
t commit)=2E<br><br>Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755<br=
>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/open=
vpn/init=2Ec<br>M src/openvpn/openvpn=2Eh<br>M src/openvpn/socket=2Ec<br>M =
src/openvpn/socket=2Eh<br>4 files changed, 105 insertions(+), 3 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/69/1769/27</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/s=
rc/openvpn/init=2Ec</span><br><span>index fb1aa2a=2E=2E5609534 100644</span=
><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/ini=
t=2Ec</span><br><span>@@ -90,6 +90,8 @@</span><br><span> context_clear_2(st=
ruct context *c)</span><br><span> {</span><br><span>     CLEAR(c-&gt;c2);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 0 is a valid d=
escriptor, so &quot;no socket&quot; has to be set explicitly */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eoob_probe_sd =3D=
 SOCKET_UNDEFINED;</span><br><span> }</span><br><span> </span><br><span> vo=
id</span><br><span>@@ -3465,6 +3467,18 @@</span><br><span>     }</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* Free a probe lookup no connection took, as clear_remote_addrlist(=
) frees a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * remote =
list: a --preresolve list belongs to the DNS cache=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+oob_probe_free_remote_list(struct context *c)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2=2Eoob_probe_remote_li=
st &amp;&amp; !c-&gt;options=2Eresolve_in_advance)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        freeaddrinfo(c-&gt;c2=2Eoob_probe_remote_list);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eoob_probe_remote_list=
 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static vo=
id</span><br><span> do_init_frame_tls(struct context *c)</span><br><span> {=
</span><br><span>@@ -3788,6 +3802,12 @@</span><br><span>                 mo=
de =3D LS_MODE_TCP_ACCEPT_FROM;</span><br><span>             }</span><br><s=
pan>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   /* adopt the OOB server-probe socket as this client&#39;s connection soc=
ket</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * (prob=
e-started handshake); only the single client socket is ever adopted */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (c-&gt;c=
2=2Eoob_probe_adopt &amp;&amp; i =3D=3D 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            mode =3D LS_MODE_UDP_ADOPT;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> </span><br><sp=
an>         /* init each socket with its specific args */</span><br><span> =
        link_socket_init_phase1(c, i, mode);</span><br><span>@@ -3953,6 +39=
73,17 @@</span><br><span> static void</span><br><span> do_close_link_socket=
(struct context *c)</span><br><span> {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* An OOB probe socket handed off for a probe-starte=
d handshake is adopted by the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * link socket in link_socket_init_phase1() (which clears oob=
_probe_sd)=2E If the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * connection attempt aborted before that, the fd is still owned here;=
 close it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * so =
it is not leaked when context_clear_2() zeroes c2=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2=2Eoob_probe_sd !=3D SO=
CKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        openvpn_cl=
ose_socket(c-&gt;c2=2Eoob_probe_sd);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    oob_probe_free_remote_list(c);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     i=
f (c-&gt;c2=2Elink_sockets &amp;&amp; c-&gt;c2=2Elink_socket_owned)</span><=
br><span>     {</span><br><span>         for (int i =3D 0; i &lt; c-&gt;c1=
=2Elink_sockets_num; i++)</span><br><span>@@ -4807,6 +4838,8 @@</span><br><=
span> inherit_context_child(struct context *dest, const struct context *src=
, struct link_socket *sock)</span><br><span> {</span><br><span>     CLEAR(*=
dest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 0 is a=
 valid descriptor, so &quot;no socket&quot; has to be set explicitly */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    dest-&gt;c2=2Eoob_p=
robe_sd =3D SOCKET_UNDEFINED;</span><br><span> </span><br><span>     /* pro=
to_is_dgram will ASSERT(0) if proto is invalid */</span><br><span>     dest=
-&gt;mode =3D proto_is_dgram(sock-&gt;info=2Eproto) ? CM_CHILD_UDP : CM_CHI=
LD_TCP;</span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/=
openvpn=2Eh</span><br><span>index e9e18bf=2E=2Ec0c6ccc 100644</span><br><sp=
an>--- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=
=2Eh</span><br><span>@@ -240,7 +240,18 @@</span><br><span> </span><br><span=
>     bool link_socket_owned;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    const struct link_socket *accept_from;   /* p=
ossibly do accept() on a parent link_socket */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const struct link_socket *accept_from; /* po=
ssibly do accept() on a parent link_socket */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* OOB probe-started handshake: when oob_probe_adopt is true, th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * connection =
adopts oob_probe_sd (the winning remote&#39;s probe</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * socket) instead of creating one, a=
nd pins oob_probe_remote (the exact</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * address probed) as the outgoing address, so the sour=
ce IP+port and the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * destination match what the server&#39;s handshake cookie is bound to=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool oob_=
probe_adopt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    soc=
ket_descriptor_t oob_probe_sd;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct openvpn_sockaddr oob_probe_remote;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* the lookup the probe used; the =
connection takes it as its remote_list */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct addrinfo *oob_probe_remote_list;</span><br=
><span> </span><br><span>     struct link_socket_actual *to_link_addr; /* I=
P address of remote */</span><br><span>     struct link_socket_actual from;=
          /* address of incoming datagram */</span><br><span>diff --git a/s=
rc/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index e7acab=
c=2E=2Ef3d6ef0 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><b=
r><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -1431,6 +1431,48 @@=
</span><br><span>         /* inherit (possibly guessed) info AF from parent=
 context */</span><br><span>         sock-&gt;info=2Eaf =3D c-&gt;c2=2Eacce=
pt_from-&gt;info=2Eaf;</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else if (mode =3D=3D LS_MODE_UDP_ADOPT)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        /* Adopt the OOB probe socket=
=2E create_socket_udp_configured() set it up with this</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         * socket&#39;s options and bind=
, so it only changes hands and keeps the source</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+         * IP:port the server&#39;s cookie is b=
ound to; phase 2 creates nothing=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        ASSERT(c-&gt;c2=2Eoob_probe_sd !=3D SOCKET_UNDEF=
INED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sock-=
&gt;sd =3D c-&gt;c2=2Eoob_probe_sd;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED; /* ow=
nership moves to the link socket */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        sock-&gt;info=2Eaf =3D c-&gt;c2=2Eoob_probe_remote=
=2Eaddr=2Esa=2Esa_family;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        sock-&gt;bind_local =3D false;              /* bound (or --no=
bind) by the prober already */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        sock-&gt;sockflags |=3D SF_GETADDRINFO_DGRAM;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* Take the probe&#39;s lookup as the rem=
ote list, so replies are checked</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * against the addresses that were probed rather than =
against a second</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
      * lookup that may return others; resolve_remote() then resolves nothi=
ng=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * Pin=
 the exact address that answered, the one the cookie was minted</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+         * for; resolve_remote(=
) preserves a defined actual=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        struct link_socket_addr *lsa =3D sock-&gt;info=2Elsa=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (lsa-&g=
t;remote_list &amp;&amp; !c-&gt;options=2Eresolve_in_advance)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            freeaddrinfo(lsa-&gt;remote_l=
ist);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        lsa-&gt;remote_l=
ist =3D c-&gt;c2=2Eoob_probe_remote_list;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_remote_list =3D NULL; /*=
 ownership moves with the socket */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        lsa-&gt;current_remote =3D lsa-&gt;remote_list;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (struct add=
rinfo *ai =3D lsa-&gt;remote_list; ai; ai =3D ai-&gt;ai_next)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (ai-&gt;ai_family !=3D c-&=
gt;c2=2Eoob_probe_remote=2Eaddr=2Esa=2Esa_family)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                continue;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            struct openvpn_sockaddr entry =3D { 0 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy=
(&amp;entry, ai-&gt;ai_addr, min_int((int)ai-&gt;ai_addrlen, (int)sizeof(en=
try)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (addr_port_match(&amp;entry, &amp;c-&gt;c2=2Eoob_probe_remote))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                lsa-&gt;current_re=
mote =3D ai; /* a failed attempt moves on from here */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        CLEAR(lsa-&gt;actual);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        lsa-&gt;actual=2Edest =3D c-&gt;=
c2=2Eoob_probe_remote;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span> </span><br><span>     /* are we running in HTTP p=
roxy mode? */</span><br><span>     if (sock-&gt;http_proxy)</span><br><span=
>@@ -1515,7 +1557,19 @@</span><br><span>     const msglvl_t msglevel =3D (s=
ock-&gt;mode =3D=3D LS_MODE_TCP_ACCEPT_FROM) ? D_INIT_MEDIUM : M_INFO;</spa=
n><br><span> </span><br><span>     /* print local address */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (sock-&gt;bind_local)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sock-&gt;mode =3D=
=3D LS_MODE_UDP_ADOPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
bound (or not) by the prober, so ask the socket itself */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct sockaddr_storage local=
 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
socklen_t len =3D sizeof(local);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (!getsockname(sock-&gt;sd, (struct sockaddr *)&amp;=
local, &amp;len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(msglevel, &quot;%s link local (adopted): %s&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                proto2ascii(sock-&gt;inf=
o=2Eproto, sock-&gt;info=2Eaf, true),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                print_sockaddr((struct sockaddr *)&amp;lo=
cal, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    else if (sock-&gt;bind_l=
ocal)</span><br><span>     {</span><br><span>         sa_family_t ai_family=
 =3D sock-&gt;info=2Elsa-&gt;actual=2Edest=2Eaddr=2Esa=2Esa_family;</span><=
br><span>         /* Socket is always bound on the first matching address,<=
/span><br><span>@@ -1727,7 +1781,7 @@</span><br><span>         goto done;</=
span><br><span>     }</span><br><span> #endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (sock-&gt;info=2Elsa-&gt;current_remote)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sock-&gt;mode !=
=3D LS_MODE_UDP_ADOPT &amp;&amp; sock-&gt;info=2Elsa-&gt;current_remote)</s=
pan><br><span>     {</span><br><span>         create_socket(sock, sock-&gt;=
info=2Elsa-&gt;current_remote);</span><br><span>     }</span><br><span>diff=
 --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>in=
dex 87945f9=2E=2Ec17d3bb 100644</span><br><span>--- a/src/openvpn/socket=2E=
h</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -198,6 +1=
98,10 @@</span><br><span> #define LS_MODE_DEFAULT         0</span><br><span=
> #define LS_MODE_TCP_LISTEN      1</span><br><span> #define LS_MODE_TCP_AC=
CEPT_FROM 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Adopt=
 the OOB server-probe socket, created and set up like a connection</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * socket (bound unless --no=
bind), as the connection socket instead of creating</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * one=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define LS_MODE_UDP_ADOPT       3</span><br><spa=
n>     int mode;</span><br><span> </span><br><span>     int resolve_retry_s=
econds;</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1769?usp=3Demail">change 1769</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1769?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: Iec384ee6844ab278b280d6eaf=
ec8aaecf9dde755 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
769 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 27 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ral=
f_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &l=
t;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--a3OhxZ9Tqx0=--


--===============2836046242957646886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2836046242957646886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2836046242957646886==--

