Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58498CA5FA1
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3to4VHF86CyNeLjHeTe0aa0M+g5cGhG0OKLx3FeTA1c=; b=jbCzC8bnm54g4flicHrASsv3Zt
	5Q/dT9vj9yn1Ue6QpX1XWA3OLDsehhDR9Y/B7+I4iWZX8dUbeJ4EZRTcWBf/FkmLkgCOsYnyLlU9D
	kfIfVXXLtEPY7SfIKdWoQ5vg/GrFEbrWA+CghGmVoGx0PjKbUtyde6J2u5qa39grvPiY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBXhx-0003ez-7w;
	Tue, 29 Sep 2026 13:17:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBXhv-0003ed-0s
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wDxk4LbhjGqxRXrlODdF8iQvkWnU5KTYSzwAv6AVRsU=; b=fHhPGdBX8hl69qkY2VU8IrMzc4
 6fGb6j4PZgFluchCnb9XUHjniPzPZs5bUe8v4uiygZT22XDAiVItv2jc3haXTwRy1ccSEgh93A0Ns
 V/9P/bs0PFZAAjcTXm9hKHBtoPWgWeXzYW7fCh7YtRWQ0z/WkJJN5PLr7lc3GwxeIiyw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wDxk4LbhjGqxRXrlODdF8iQvkWnU5KTYSzwAv6AVRsU=; b=K
 z2kyhHkfQah+Xm1ycefAxraWkV9rIH5ooYmwi2nstV5/JggW9yfqlhNZMt0tALwSHtz/ZRctdtZ2Y
 iFnwLg7xz/5SXFZzC+M1O/9nXCSMq5oOlm2WyBYhyZx/VoLxItjiw6cHI7Yu9jjUxMZWt74OJaaJ5
 D0sv1jZDUYMWA26M=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBXht-0001GS-45 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:18 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca626so25937605e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 06:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790687830; x=1791292630; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wDxk4LbhjGqxRXrlODdF8iQvkWnU5KTYSzwAv6AVRsU=;
 b=HKpaC01sXxcrpwGx1msiJQP/2UQWCKQn4U54otAMEfWG6o75gP2O9QDEgBb+Fvetj5
 DHiREM4gLjwxCxfEfV1zEynvhyMlpcjAoBtL8MbUCivm80e2/UQUm+c9eRbhvk0sk+Pc
 4fuDcCDj4r5ZLOoHW9XPu6jbB1v/w9SzHtSPc+6Kp2lP2yHAdU+etsQN0UnRXc45j0YA
 tMdfkWjs4D0RHe9Jaqa9C56T13onLXopTLVC822gKp5K49OpO8cfD5do6cPJwB/a/0KO
 QWtbyVbpS7vAknIKgw1jrgz0CvFbimIh0WspJHBVlh0CO87CM7WEh1pqBlxjtDn8ZeH8
 HaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687830; x=1791292630;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wDxk4LbhjGqxRXrlODdF8iQvkWnU5KTYSzwAv6AVRsU=;
 b=EHDRwiUVBYODagN9YkqdT/QkqmCslifIKrf+8wdYIajYNiLE21e0XI2RtI8l6PP4HL
 ZND7VGDrO/1EtLBX0bZwNZVVa7xG0IGIJZ/RlFHDBZOnpc10nM4r0MqM0wBWo+ihnmG6
 OxZtgfOUFiiOV9Lsev77qpMyvD0HU4aSlqPa1lXEV8lLAksIfIwlNxsqB+CfAb3IIoPl
 FrMq9cJQFJ/fTIMY1K970X7dI0uPa35pZCBMGWGEw+h7/t1GUsWlfBmMTmBHo+ypX9SK
 RR0Q172RvpWWiUUYQF+T22jjKQyPHJYqeug7uS5XmH/MCNpYNK1phc3SFMuQ4IQso2zU
 7mRQ==
X-Gm-Message-State: AFuF++n2t0igXPijhg6QuAjuwDVmuPgikt3duyN3KOpulOFoyoZAW0Iq
 dU0hblMOekru8BQzpYyz/RTqDWpZH84VE2DTSz8f1v6jOeOWA6ES5+wfXOjk83w0PSjP63LoUHr
 uWZzL4/zmmCmQUrjkp/jnwxeEJ2W9BJGj6mvT8AqDwyhOLZHNA482EWGgUi36ppCTZAUNSzU1Xk
 OKWJI16w==
X-Gm-Gg: AYBFou1PJ62zGL+jVBo3uX1z3SV1T/q0r5oho5HDOSACr4GVzfB1dH0cMXm4p2whMh6
 yu/96wp3ziIl/4HL2kg3HpVhq6ai5Z9GWfVTM/g9JXJlHVSFHjv8BX0NsDNjaAdD/IpuqIvqlQn
 1FJVn7Bm7pAhcqiHqiydrZsZqK+5izkeKVwH5U1bi2eIkO8X1siOToChVk5qbhSTgnWvWKWZ1AU
 l+ypYFhJjBWlfGvIho/z+/B4i51j0hoMSAFm/aOrtxTtIQcXJSjXIs0szNRmMb8/f9FPHG5fZuw
 mK1ow2Zo8I1gLh7EVq4jH8babgO6M3bXquoouNG415MyxbVvlI90+Y1A7Mn4O7nY76sC9DQlSsm
 8nk/KL92LDQF0mdER1NkZBswcM7e83orKaAeEXIeQGDvEpPzh69yzBnxcXeER+7ZimTP6Cm69K3
 b1bBeJNUZHJw71kFVKrMwhqEBeQnbDMUkkk03qJ0ui1IC7wvg5kRT91apbpD26vrmlYVftOraUO
 1A3KgHZt/hir5fzOBu/oryH0XrraGbMlX6wVUA1JAHLuFj53+yzVYaRsjeYle7IOM77LUU+XLBu
 bQv6STrzSqb4aMSXmWNtcKrCLFVQIYxVOLFBhjVEPcVLuGSPZpFLiGpD10PRXHDNTMMVHpQ=
X-Received: by 2002:a05:600c:3150:b0:49f:fd2d:23d1 with SMTP id
 5b1f17b1804b1-49ffd2d2627mr150739605e9.27.1790687830035; 
 Tue, 29 Sep 2026 06:17:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af5030037sm4686535f8f.8.2026.09.29.06.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:17:09 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 13:16:31 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755
X-Gerrit-Change-Number: 1769
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1769?usp=email>
X-Gerrit-Commit: cb114a01aad733c7b78203ef9ea10f06ea232ee0
In-Reply-To: <gerrit.1783320647000.Iec384ee6844ab278b280d6eafec8aaecf9dde755@gerrit.openvpn.net>
References: <gerrit.1783320647000.Iec384ee6844ab278b280d6eafec8aaecf9dde755@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkllYzM4NGVlNjg0NGFiMjc4YjI4MGQ2ZWFmZWM4YWFlY2Y5ZGRlNzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a6ccf28c655f6f1e333ca9c36722d9bddd970b8c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBXht-0001GS-45
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
Content-Type: multipart/mixed; boundary="===============7074233583586325006=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7074233583586325006==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VQaaFAEKoeY="; charset=UTF-8

--VQaaFAEKoeY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1769?usp=3Demail

to look a=
t the new patch set (#26)=2E

The following approvals got outdated and were=
 removed:
Code-Review-1 by ralf_lici


Change subject: socket: Adopt a pre-=
created UDP socket for a client connection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket: Adopt a pre-created UDP socket for =
a client connection

Add LS_MODE_UDP_ADOPT: a client link_socket can take o=
wnership of a UDP
socket, set up like the connection socket (bound unless -=
-nobind),
handed off via c2=2Eoob_probe_adopt/oob_probe_sd instead of creat=
ing its
own, and pin c2=2Eoob_probe_remote as the outgoing address=2E This =
lets the
OOB server-probe socket become the connection socket, so the sourc=
e
IP+port and destination match what the server's handshake cookie is
bound=
 to=2E

  - link_socket_init_phase1: adopt the fd, inherit the address fami=
ly
    and pre-set lsa->actual (resolve_remote preserves an already-defined=

    actual)=2E The probe socket was created and bound by
    create_socket=
_udp_configured() with the link socket's options, so
    nothing is applied=
 or bound here=2E It also takes the probe's
    lookup (c2=2Eoob_probe_remo=
te_list) as the remote list, with
    current_remote at the address that an=
swered: incoming packets are
    checked against remote_list, and a second =
lookup may return other
    addresses (round-robin DNS), whose check would =
drop the server's
    replies
  - linksock_print_addr: report an adopted so=
cket's local address from
    getsockname(), since bind_local is cleared to=
 mean "do not bind
    again" and the socket may well be bound
  - link_soc=
ket_init_phase2: skip create_socket() so the adopted fd is
    not clobbere=
d (overlapped-I/O init is fd-independent, so Windows is
    fine)
  - do_in=
it_socket_phase1: select the mode for the single client socket
  - do_close=
_link_socket: close the handed-off fd and free the
    handed-off lookup if=
 the attempt aborted before they were adopted,
    so neither is leaked=2E =
context_clear_2() sets oob_probe_sd to
    SOCKET_UNDEFINED, since 0 is a v=
alid descriptor, and
    inherit_context_child() does the same for a server=
's per-client
    contexts

The adopt path itself stays unused until the cl=
ient sets oob_probe_adopt
(next commit)=2E

Change-Id: Iec384ee6844ab278b28=
0d6eafec8aaecf9dde755
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M=
 src/openvpn/init=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/socket=2Ec
M =
src/openvpn/socket=2Eh
4 files changed, 105 insertions(+), 3 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/69/1769=
/26

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index fb1aa2a=
=2E=2E5609534 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
=
@@ -90,6 +90,8 @@
 context_clear_2(struct context *c)
 {
     CLEAR(c->c2);=

+    /* 0 is a valid descriptor, so "no socket" has to be set explicitly *=
/
+    c->c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;
 }
 
 void
@@ -3465,6 +34=
67,18 @@
     }
 }
 
+/* Free a probe lookup no connection took, as clear_r=
emote_addrlist() frees a
+ * remote list: a --preresolve list belongs to th=
e DNS cache=2E */
+static void
+oob_probe_free_remote_list(struct context *=
c)
+{
+    if (c->c2=2Eoob_probe_remote_list && !c->options=2Eresolve_in_ad=
vance)
+    {
+        freeaddrinfo(c->c2=2Eoob_probe_remote_list);
+    }
=
+    c->c2=2Eoob_probe_remote_list =3D NULL;
+}
+
 static void
 do_init_fra=
me_tls(struct context *c)
 {
@@ -3788,6 +3802,12 @@
                 mode =
=3D LS_MODE_TCP_ACCEPT_FROM;
             }
         }
+        /* adopt th=
e OOB server-probe socket as this client's connection socket
+         * (p=
robe-started handshake); only the single client socket is ever adopted */
+=
        else if (c->c2=2Eoob_probe_adopt && i =3D=3D 0)
+        {
+       =
     mode =3D LS_MODE_UDP_ADOPT;
+        }
 
         /* init each socket =
with its specific args */
         link_socket_init_phase1(c, i, mode);
@@ =
-3953,6 +3973,17 @@
 static void
 do_close_link_socket(struct context *c)
 =
{
+    /* An OOB probe socket handed off for a probe-started handshake is a=
dopted by the
+     * link socket in link_socket_init_phase1() (which clear=
s oob_probe_sd)=2E If the
+     * connection attempt aborted before that, t=
he fd is still owned here; close it
+     * so it is not leaked when contex=
t_clear_2() zeroes c2=2E */
+    if (c->c2=2Eoob_probe_sd !=3D SOCKET_UNDEF=
INED)
+    {
+        openvpn_close_socket(c->c2=2Eoob_probe_sd);
+        =
c->c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;
+    }
+    oob_probe_free_remot=
e_list(c);
+
     if (c->c2=2Elink_sockets && c->c2=2Elink_socket_owned)
  =
   {
         for (int i =3D 0; i < c->c1=2Elink_sockets_num; i++)
@@ -4807=
,6 +4838,8 @@
 inherit_context_child(struct context *dest, const struct con=
text *src, struct link_socket *sock)
 {
     CLEAR(*dest);
+    /* 0 is a v=
alid descriptor, so "no socket" has to be set explicitly */
+    dest->c2=
=2Eoob_probe_sd =3D SOCKET_UNDEFINED;
 
     /* proto_is_dgram will ASSERT(=
0) if proto is invalid */
     dest->mode =3D proto_is_dgram(sock->info=2Ep=
roto) ? CM_CHILD_UDP : CM_CHILD_TCP;
diff --git a/src/openvpn/openvpn=2Eh b=
/src/openvpn/openvpn=2Eh
index e9e18bf=2E=2Ec0c6ccc 100644
--- a/src/openvp=
n/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -240,7 +240,18 @@
 
     boo=
l link_socket_owned;
 
-    const struct link_socket *accept_from;   /* pos=
sibly do accept() on a parent link_socket */
+    const struct link_socket =
*accept_from; /* possibly do accept() on a parent link_socket */
+
+    /* =
OOB probe-started handshake: when oob_probe_adopt is true, the
+     * conn=
ection adopts oob_probe_sd (the winning remote's probe
+     * socket) inst=
ead of creating one, and pins oob_probe_remote (the exact
+     * address p=
robed) as the outgoing address, so the source IP+port and the
+     * desti=
nation match what the server's handshake cookie is bound to=2E */
+    bool=
 oob_probe_adopt;
+    socket_descriptor_t oob_probe_sd;
+    struct openvp=
n_sockaddr oob_probe_remote;
+    /* the lookup the probe used; the connect=
ion takes it as its remote_list */
+    struct addrinfo *oob_probe_remote_l=
ist;
 
     struct link_socket_actual *to_link_addr; /* IP address of remot=
e */
     struct link_socket_actual from;          /* address of incoming d=
atagram */
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
ind=
ex e7acabc=2E=2Ef3d6ef0 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openv=
pn/socket=2Ec
@@ -1431,6 +1431,48 @@
         /* inherit (possibly guessed)=
 info AF from parent context */
         sock->info=2Eaf =3D c->c2=2Eaccept=
_from->info=2Eaf;
     }
+    else if (mode =3D=3D LS_MODE_UDP_ADOPT)
+    =
{
+        /* Adopt the OOB probe socket=2E create_socket_udp_configured() =
set it up with this
+         * socket's options and bind, so it only chang=
es hands and keeps the source
+         * IP:port the server's cookie is bo=
und to; phase 2 creates nothing=2E */
+        ASSERT(c->c2=2Eoob_probe_sd =
!=3D SOCKET_UNDEFINED);
+        sock->sd =3D c->c2=2Eoob_probe_sd;
+      =
  c->c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED; /* ownership moves to the link=
 socket */
+        sock->info=2Eaf =3D c->c2=2Eoob_probe_remote=2Eaddr=2Es=
a=2Esa_family;
+        sock->bind_local =3D false;              /* bound (=
or --nobind) by the prober already */
+        sock->sockflags |=3D SF_GETA=
DDRINFO_DGRAM;
+
+        /* Take the probe's lookup as the remote list, so=
 replies are checked
+         * against the addresses that were probed rat=
her than against a second
+         * lookup that may return others; resolv=
e_remote() then resolves nothing=2E
+         * Pin the exact address that =
answered, the one the cookie was minted
+         * for; resolve_remote() p=
reserves a defined actual=2E */
+        struct link_socket_addr *lsa =3D s=
ock->info=2Elsa;
+        if (lsa->remote_list && !c->options=2Eresolve_in_=
advance)
+        {
+            freeaddrinfo(lsa->remote_list);
+        }=

+        lsa->remote_list =3D c->c2=2Eoob_probe_remote_list;
+        c->c=
2=2Eoob_probe_remote_list =3D NULL; /* ownership moves with the socket */
+=
        lsa->current_remote =3D lsa->remote_list;
+        for (struct addr=
info *ai =3D lsa->remote_list; ai; ai =3D ai->ai_next)
+        {
+        =
    if (ai->ai_family !=3D c->c2=2Eoob_probe_remote=2Eaddr=2Esa=2Esa_family=
)
+            {
+                continue;
+            }
+            str=
uct openvpn_sockaddr entry =3D { 0 };
+            memcpy(&entry, ai->ai_ad=
dr, min_int((int)ai->ai_addrlen, (int)sizeof(entry)));
+            if (add=
r_port_match(&entry, &c->c2=2Eoob_probe_remote))
+            {
+          =
      lsa->current_remote =3D ai; /* a failed attempt moves on from here */=

+                break;
+            }
+        }
+        CLEAR(lsa->actu=
al);
+        lsa->actual=2Edest =3D c->c2=2Eoob_probe_remote;
+    }
 
   =
  /* are we running in HTTP proxy mode? */
     if (sock->http_proxy)
@@ -1=
515,7 +1557,19 @@
     const msglvl_t msglevel =3D (sock->mode =3D=3D LS_MO=
DE_TCP_ACCEPT_FROM) ? D_INIT_MEDIUM : M_INFO;
 
     /* print local address=
 */
-    if (sock->bind_local)
+    if (sock->mode =3D=3D LS_MODE_UDP_ADOPT=
)
+    {
+        /* bound (or not) by the prober, so ask the socket itself=
 */
+        struct sockaddr_storage local =3D { 0 };
+        socklen_t le=
n =3D sizeof(local);
+        if (!getsockname(sock->sd, (struct sockaddr *=
)&local, &len))
+        {
+            msg(msglevel, "%s link local (adopt=
ed): %s",
+                proto2ascii(sock->info=2Eproto, sock->info=2Eaf,=
 true),
+                print_sockaddr((struct sockaddr *)&local, &gc));
+=
        }
+    }
+    else if (sock->bind_local)
     {
         sa_family_=
t ai_family =3D sock->info=2Elsa->actual=2Edest=2Eaddr=2Esa=2Esa_family;
  =
       /* Socket is always bound on the first matching address,
@@ -1727,7 =
+1781,7 @@
         goto done;
     }
 #endif
-    if (sock->info=2Elsa->cu=
rrent_remote)
+    if (sock->mode !=3D LS_MODE_UDP_ADOPT && sock->info=2Els=
a->current_remote)
     {
         create_socket(sock, sock->info=2Elsa->cu=
rrent_remote);
     }
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/soc=
ket=2Eh
index 87945f9=2E=2Ec17d3bb 100644
--- a/src/openvpn/socket=2Eh
+++ =
b/src/openvpn/socket=2Eh
@@ -198,6 +198,10 @@
 #define LS_MODE_DEFAULT     =
    0
 #define LS_MODE_TCP_LISTEN      1
 #define LS_MODE_TCP_ACCEPT_FROM 2=

+/* Adopt the OOB server-probe socket, created and set up like a connectio=
n
+ * socket (bound unless --nobind), as the connection socket instead of c=
reating
+ * one=2E */
+#define LS_MODE_UDP_ADOPT       3
     int mode;
 
 =
    int resolve_retry_seconds;

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1769?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755
Gerrit-Change-Numb=
er: 1769
Gerrit-PatchSet: 26
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf=
_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Ge=
rrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>

--VQaaFAEKoeY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #26</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1769?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review-1 by ralf=
_lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">socket: Adopt a pre-created UDP socket for a client =
connection<br><br>Add LS_MODE_UDP_ADOPT: a client link_socket can take owne=
rship of a UDP<br>socket, set up like the connection socket (bound unless -=
-nobind),<br>handed off via c2=2Eoob_probe_adopt/oob_probe_sd instead of cr=
eating its<br>own, and pin c2=2Eoob_probe_remote as the outgoing address=2E=
 This lets the<br>OOB server-probe socket become the connection socket, so =
the source<br>IP+port and destination match what the server&#39;s handshake=
 cookie is<br>bound to=2E<br><br>  - link_socket_init_phase1: adopt the fd,=
 inherit the address family<br>    and pre-set lsa-&gt;actual (resolve_remo=
te preserves an already-defined<br>    actual)=2E The probe socket was crea=
ted and bound by<br>    create_socket_udp_configured() with the link socket=
&#39;s options, so<br>    nothing is applied or bound here=2E It also takes=
 the probe&#39;s<br>    lookup (c2=2Eoob_probe_remote_list) as the remote l=
ist, with<br>    current_remote at the address that answered: incoming pack=
ets are<br>    checked against remote_list, and a second lookup may return =
other<br>    addresses (round-robin DNS), whose check would drop the server=
&#39;s<br>    replies<br>  - linksock_print_addr: report an adopted socket&=
#39;s local address from<br>    getsockname(), since bind_local is cleared =
to mean &quot;do not bind<br>    again&quot; and the socket may well be bou=
nd<br>  - link_socket_init_phase2: skip create_socket() so the adopted fd i=
s<br>    not clobbered (overlapped-I/O init is fd-independent, so Windows i=
s<br>    fine)<br>  - do_init_socket_phase1: select the mode for the single=
 client socket<br>  - do_close_link_socket: close the handed-off fd and fre=
e the<br>    handed-off lookup if the attempt aborted before they were adop=
ted,<br>    so neither is leaked=2E context_clear_2() sets oob_probe_sd to<=
br>    SOCKET_UNDEFINED, since 0 is a valid descriptor, and<br>    inherit_=
context_child() does the same for a server&#39;s per-client<br>    contexts=
<br><br>The adopt path itself stays unused until the client sets oob_probe_=
adopt<br>(next commit)=2E<br><br>Change-Id: Iec384ee6844ab278b280d6eafec8aa=
ecf9dde755<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<=
br>M src/openvpn/init=2Ec<br>M src/openvpn/openvpn=2Eh<br>M src/openvpn/soc=
ket=2Ec<br>M src/openvpn/socket=2Eh<br>4 files changed, 105 insertions(+), =
3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/69/1769/26</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index fb1aa2a=2E=2E56095=
34 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/=
src/openvpn/init=2Ec</span><br><span>@@ -90,6 +90,8 @@</span><br><span> con=
text_clear_2(struct context *c)</span><br><span> {</span><br><span>     CLE=
AR(c-&gt;c2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 0 is a valid descriptor, so &quot;no socket&quot; has to be set explicitly=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eo=
ob_probe_sd =3D SOCKET_UNDEFINED;</span><br><span> }</span><br><span> </spa=
n><br><span> void</span><br><span>@@ -3465,6 +3467,18 @@</span><br><span>  =
   }</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Free a probe lookup no connection took, as clear_r=
emote_addrlist() frees a</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * remote list: a --preresolve list belongs to the DNS cache=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_free_remote_list(stru=
ct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2=2Eoob_=
probe_remote_list &amp;&amp; !c-&gt;options=2Eresolve_in_advance)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        freeaddrinfo(c-&gt;c2=2Eoob_probe=
_remote_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eoob_=
probe_remote_list =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> static void</span><br><span> do_init_frame_tls(struct context *c)</=
span><br><span> {</span><br><span>@@ -3788,6 +3802,12 @@</span><br><span>  =
               mode =3D LS_MODE_TCP_ACCEPT_FROM;</span><br><span>          =
   }</span><br><span>         }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* adopt the OOB server-probe socket as this client&#39=
;s connection socket</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+         * (probe-started handshake); only the single client socket is eve=
r adopted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else if (c-&gt;c2=2Eoob_probe_adopt &amp;&amp; i =3D=3D 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            mode =3D LS_MODE_UDP_ADOPT;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
> </span><br><span>         /* init each socket with its specific args */</=
span><br><span>         link_socket_init_phase1(c, i, mode);</span><br><spa=
n>@@ -3953,6 +3973,17 @@</span><br><span> static void</span><br><span> do_c=
lose_link_socket(struct context *c)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* An OOB probe socket handed off fo=
r a probe-started handshake is adopted by the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * link socket in link_socket_init_phase1() (=
which clears oob_probe_sd)=2E If the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * connection attempt aborted before that, the fd is s=
till owned here; close it</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * so it is not leaked when context_clear_2() zeroes c2=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2=2Eoob_=
probe_sd !=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      openvpn_close_socket(c-&gt;c2=2Eoob_probe_sd);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_sd =3D SOCKE=
T_UNDEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_probe_free_re=
mote_list(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     if (c-&gt;c2=2Elink_sockets &amp;&amp; c-&gt;c2=2Elink_sock=
et_owned)</span><br><span>     {</span><br><span>         for (int i =3D 0;=
 i &lt; c-&gt;c1=2Elink_sockets_num; i++)</span><br><span>@@ -4807,6 +4838,=
8 @@</span><br><span> inherit_context_child(struct context *dest, const str=
uct context *src, struct link_socket *sock)</span><br><span> {</span><br><s=
pan>     CLEAR(*dest);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* 0 is a valid descriptor, so &quot;no socket&quot; has to be set e=
xplicitly */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    des=
t-&gt;c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;</span><br><span> </span><br><=
span>     /* proto_is_dgram will ASSERT(0) if proto is invalid */</span><br=
><span>     dest-&gt;mode =3D proto_is_dgram(sock-&gt;info=2Eproto) ? CM_CH=
ILD_UDP : CM_CHILD_TCP;</span><br><span>diff --git a/src/openvpn/openvpn=2E=
h b/src/openvpn/openvpn=2Eh</span><br><span>index e9e18bf=2E=2Ec0c6ccc 1006=
44</span><br><span>--- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/=
openvpn/openvpn=2Eh</span><br><span>@@ -240,7 +240,18 @@</span><br><span> <=
/span><br><span>     bool link_socket_owned;</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    const struct link_socket *acce=
pt_from;   /* possibly do accept() on a parent link_socket */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const struct link_socket *acc=
ept_from; /* possibly do accept() on a parent link_socket */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* OOB probe-started handshake: when oob_probe_ad=
opt is true, the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * connection adopts oob_probe_sd (the winning remote&#39;s probe</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * socket) instead of cr=
eating one, and pins oob_probe_remote (the exact</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * address probed) as the outgoing address=
, so the source IP+port and the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * destination match what the server&#39;s handshake cookie=
 is bound to=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool oob_probe_adopt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    socket_descriptor_t oob_probe_sd;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct openvpn_sockaddr oob_probe_remote;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the lookup the prob=
e used; the connection takes it as its remote_list */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo *oob_probe_remote_lis=
t;</span><br><span> </span><br><span>     struct link_socket_actual *to_lin=
k_addr; /* IP address of remote */</span><br><span>     struct link_socket_=
actual from;          /* address of incoming datagram */</span><br><span>di=
ff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>=
index e7acabc=2E=2Ef3d6ef0 100644</span><br><span>--- a/src/openvpn/socket=
=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -1431,=
6 +1431,48 @@</span><br><span>         /* inherit (possibly guessed) info A=
F from parent context */</span><br><span>         sock-&gt;info=2Eaf =3D c-=
&gt;c2=2Eaccept_from-&gt;info=2Eaf;</span><br><span>     }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    else if (mode =3D=3D LS_MODE_UDP=
_ADOPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Adopt the OOB p=
robe socket=2E create_socket_udp_configured() set it up with this</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * socket&#39;s optio=
ns and bind, so it only changes hands and keeps the source</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+         * IP:port the server&#39;s =
cookie is bound to; phase 2 creates nothing=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        ASSERT(c-&gt;c2=2Eoob_probe_sd !=3D S=
OCKET_UNDEFINED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      sock-&gt;sd =3D c-&gt;c2=2Eoob_probe_sd;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_sd =3D SOCKET_UNDEF=
INED; /* ownership moves to the link socket */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        sock-&gt;info=2Eaf =3D c-&gt;c2=2Eoob_pr=
obe_remote=2Eaddr=2Esa=2Esa_family;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        sock-&gt;bind_local =3D false;              /* boun=
d (or --nobind) by the prober already */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        sock-&gt;sockflags |=3D SF_GETADDRINFO_DGRAM;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        /* Take the probe&#39;s lookup =
as the remote list, so replies are checked</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * against the addresses that were probed ra=
ther than against a second</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+         * lookup that may return others; resolve_remote() then reso=
lves nothing=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     * Pin the exact address that answered, the one the cookie was minted</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * for; resol=
ve_remote() preserves a defined actual=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        struct link_socket_addr *lsa =3D sock-&gt;=
info=2Elsa;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (lsa-&gt;remote_list &amp;&amp; !c-&gt;options=2Eresolve_in_advance)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            freeaddrinfo(lsa-&gt;=
remote_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        lsa-&gt;=
remote_list =3D c-&gt;c2=2Eoob_probe_remote_list;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_remote_list =3D =
NULL; /* ownership moves with the socket */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        lsa-&gt;current_remote =3D lsa-&gt;remote_l=
ist;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (st=
ruct addrinfo *ai =3D lsa-&gt;remote_list; ai; ai =3D ai-&gt;ai_next)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (ai-&gt;ai_family !=
=3D c-&gt;c2=2Eoob_probe_remote=2Eaddr=2Esa=2Esa_family)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                continue;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            struct openvpn_sockaddr entry =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   memcpy(&amp;entry, ai-&gt;ai_addr, min_int((int)ai-&gt;ai_addrlen, (int)=
sizeof(entry)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if (addr_port_match(&amp;entry, &amp;c-&gt;c2=2Eoob_probe_remote))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                lsa-&gt;c=
urrent_remote =3D ai; /* a failed attempt moves on from here */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                break;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        CLEAR(lsa-&gt;actual);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        lsa-&gt;actual=2Edest =3D=
 c-&gt;c2=2Eoob_probe_remote;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span> </span><br><span>     /* are we running in=
 HTTP proxy mode? */</span><br><span>     if (sock-&gt;http_proxy)</span><b=
r><span>@@ -1515,7 +1557,19 @@</span><br><span>     const msglvl_t msglevel=
 =3D (sock-&gt;mode =3D=3D LS_MODE_TCP_ACCEPT_FROM) ? D_INIT_MEDIUM : M_INF=
O;</span><br><span> </span><br><span>     /* print local address */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (sock-&gt;bind_local)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sock-&gt;mod=
e =3D=3D LS_MODE_UDP_ADOPT)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /* bound (or not) by the prober, so ask the socket itself */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct sockaddr_storage =
local =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     socklen_t len =3D sizeof(local);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!getsockname(sock-&gt;sd, (struct sockaddr *)=
&amp;local, &amp;len))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(msglevel, &quot;%s link local (adopted): %s&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                proto2ascii(sock-&g=
t;info=2Eproto, sock-&gt;info=2Eaf, true),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                print_sockaddr((struct sockaddr *)&a=
mp;local, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (sock-&gt;b=
ind_local)</span><br><span>     {</span><br><span>         sa_family_t ai_f=
amily =3D sock-&gt;info=2Elsa-&gt;actual=2Edest=2Eaddr=2Esa=2Esa_family;</s=
pan><br><span>         /* Socket is always bound on the first matching addr=
ess,</span><br><span>@@ -1727,7 +1781,7 @@</span><br><span>         goto do=
ne;</span><br><span>     }</span><br><span> #endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (sock-&gt;info=2Elsa-&gt;current_remote=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sock-&gt;m=
ode !=3D LS_MODE_UDP_ADOPT &amp;&amp; sock-&gt;info=2Elsa-&gt;current_remot=
e)</span><br><span>     {</span><br><span>         create_socket(sock, sock=
-&gt;info=2Elsa-&gt;current_remote);</span><br><span>     }</span><br><span=
>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><sp=
an>index 87945f9=2E=2Ec17d3bb 100644</span><br><span>--- a/src/openvpn/sock=
et=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -198=
,6 +198,10 @@</span><br><span> #define LS_MODE_DEFAULT         0</span><br>=
<span> #define LS_MODE_TCP_LISTEN      1</span><br><span> #define LS_MODE_T=
CP_ACCEPT_FROM 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Adopt the OOB server-probe socket, created and set up like a connection</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * socket (bound unless=
 --nobind), as the connection socket instead of creating</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * one=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define LS_MODE_UDP_ADOPT       3</span><br><=
span>     int mode;</span><br><span> </span><br><span>     int resolve_retr=
y_seconds;</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1769?usp=3Demail">change 1769</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1769?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: Iec384ee6844ab278b280d6e=
afec8aaecf9dde755 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1769 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 26 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: r=
alf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa =
&lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html=
>
--VQaaFAEKoeY=--


--===============7074233583586325006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7074233583586325006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7074233583586325006==--

