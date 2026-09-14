Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9169DC88E77
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xsa2raXtEx4/XdqNghdXBSDtZxFXsnhE93G7+u663Ks=; b=WCiupmPFbVaJ7OJVXCldFjmKah
	vwf6+tIDtEx7EnetfQIh6Ymkk1eReIznCYId6fHVMQxaSqu5GLONzshfROAI4iO/iq/xd3SO3zjEa
	jBQhuGlFZjbyPn6oroC0KcbwvypNU/uwZRelM0+CjB0LVAInQ6hCDoGI8TpqUgphhYdY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67Wb-0000Lx-Cj;
	Mon, 14 Sep 2026 14:19:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67WY-0000LS-JC
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=i1ZH+B/hP9CloFB9iCW6PVFfcebAFr/RMEAz/NhYBgo=; b=HTN+sTqzvUJzpNomI8gmxUXXig
 O3HGOH0YLwRRjFcw+9/jLp54Bd3FnOW7zUTSN3nH6P3GrQqXTP/lfbIljNoRmTYJ7aXi6vJrkDYzz
 /+kDTVBZWZSduleCjQFtSpdPt4nYCXJqa16c8VQA6VIjxp7Rjc0O8HrqgaCtPyc6nxzc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=i1ZH+B/hP9CloFB9iCW6PVFfcebAFr/RMEAz/NhYBgo=; b=c
 ZXVz5mxgeRiTH/sUht0hyC4ZJ/Bp7ug7UISiwfVbs7eh1sA1zU+cxHqf0v3TT59kk386OA0KwDj0d
 UuvILQ7fwtc0SFL+sWvPVI7HIXvuazydGSvNDSAPEz81WTWfXoIcoOEluKPxjpJEYDtlyUIfECucG
 WJiww84EVSitiPVQ=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67WU-0001Sc-Gg for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:11 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd5462b69so12655665e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395540; x=1790000340; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=i1ZH+B/hP9CloFB9iCW6PVFfcebAFr/RMEAz/NhYBgo=;
 b=NLhM37l1yLx27fB7j3Q95ot9lC/ItHJaMaLgj3t8I6kI6PC1L+v2P1SqQ+XERWJyb+
 nbxjleIyCSUI82K+jXlk/DpDcZT0/CZ1bjCAso6oEhNelpUMkq1GkIDsaHNXhaSqC/JP
 nqhE50QxFyTH5oRnzp8tKfqRt2SgwxeroNUD0TqEZQ8u43GB3H7AkF98vtgjcck1Qhhs
 qNLbtS7slWxmF8kFcbBhMBbf9QfsPUIaaVEw750Oq2aR/SoTtZbCYZLd8xlRMzQQXtOk
 7UtY78MJDZs7lA60N5iqwx0MhFHkW/6NwuzOZPZLXW9x2POsywDZOPpDhZ2ebTsrS3UP
 Fw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395540; x=1790000340;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=i1ZH+B/hP9CloFB9iCW6PVFfcebAFr/RMEAz/NhYBgo=;
 b=iM3EFzZ0luGHfoFg1hQACSOJSU16rvB+ZxHR029P/tVaMSIKM2RD1RKynuh11U4N4n
 IK9cFFla3e9rVO9O1lF61RxfFsB30f54bA1Fkq3HclYxWip/VtDXs6MlWaHW/BAJqY3m
 XW9q3gY46sJWghU304LzHtGn7MwCD6loQv3wTeFJYYLfoq++21nin6bmhG63kQJPf5If
 RyyPD7FhjKRvYcLXxzj6lTlNL6oU26Uq5CuZb2i+Qt8MO4Ude3+38qS+rv5u1IGpsuCG
 DviFFTD5xGzLQRdNaoX4WLNXnyaTXQm7KrFlIGRTLEE3YLplu3Quzmqeeiw1tpMVzox1
 6zKA==
X-Gm-Message-State: AFuF++lH3UoR52H1hGBzeKUSeQVnhWIHg4VmsrpFob0ldF4Y3O2bLPAq
 Vxw5dakRB28pytXks3L6yKYiXIL4+8fXnzZ2wJSgEXEtSV+6DUWgFKN35xtSV69OXqJQ08JCAQJ
 KnPrml0MYpA1zYckTHI7iuVqr+TkORMENu7LlCqMmrxZQxGx+n0u6YxniOzUU5mUr8z0W
X-Gm-Gg: AYBFou3JH+Xf+rYWv5cJFajqm8sBvYhgma8hvFlhubeLZrhOyTOzDXWL8P9WHtT1VrP
 63DretYA/Z/jCaBWF8EVsv6/pAlIJ2S7NGOd5Z6SFh+NUC58YDW0BzfmP5FoO8Tg7E1of9Lm20+
 Wus9D+FMKEA37jGfLfRZ4RYrAPD5TmqwdBdiJ8E00DOGd6TugYG5oh4KaJ5TxNwI+JWteIMe6M3
 I3O0p9MZXQn/dN5DL6hj/UyQJIO821xhR6pDr4yeYz75ajHizVzBXqv1/0QxKVcEaz37XauhJYY
 P0sJvgZOGWDBzQnBEkimHvEWUFxsly/EYFUJW9tgYYmgm6/2OdrA/uEFLI23Bnr56qbfyRd0bZO
 IRIv9r//RZtTvVnq/GmYlm36ACyjdyhsJ9almh1yUihRoZyQkk8Zv0CgcyaFOBsMVLFutRpidc6
 WxgPm7+RzoQcubNTwmbnO7ruQHNuKzQlC/LUfPQxcdgPV5f/Q9kGVUocqqmE1aQ8Q9Vj9b0Vayj
 MARiYAzl7o5sMA8rBKUM5T1jslYyFPACogYkr0ZX0/yCpp/m7KDkmN/TSdVRVX4qaMrPcNksCvc
 Yoqar3nISSRAIT5iAesxIorQVfzf4M1p4lO4QjOqEyPTrfXeN3AjOgtYYN5mxA==
X-Received: by 2002:a05:600c:358a:b0:49d:2607:4ada with SMTP id
 5b1f17b1804b1-49e7a6870f4mr78102135e9.14.1789395539678; 
 Mon, 14 Sep 2026 07:18:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7d23f932sm5643575e9.1.2026.09.14.07.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:18:58 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:18:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755
X-Gerrit-Change-Number: 1769
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1769?usp=email>
X-Gerrit-Commit: 1c0b21741b805c45b4af76e2cf33c9e2a89fbe5c
In-Reply-To: <gerrit.1783320647000.Iec384ee6844ab278b280d6eafec8aaecf9dde755@gerrit.openvpn.net>
References: <gerrit.1783320647000.Iec384ee6844ab278b280d6eafec8aaecf9dde755@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkllYzM4NGVlNjg0NGFiMjc4YjI4MGQ2ZWFmZWM4YWFlY2Y5ZGRlNzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0d0585d9b20afefd5bff709b81f63b55a6f7d0ee-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67WU-0001Sc-Gg
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
Content-Type: multipart/mixed; boundary="===============2196526243500224969=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2196526243500224969==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="07FlladPaEo="; charset=UTF-8

--07FlladPaEo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1769?usp=3Demail

to look at the new patch set (#18)=2E
=


Change subject: socket: adopt a pre-created UDP socket for a client conne=
ction
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket:=
 adopt a pre-created UDP socket for a client connection

Add LS_MODE_UDP_ADOPT: a client link_socket can take ownership of a UDP
socket, set up like the connection socket (bound unless --nobind),
handed off via c2=2Eoob_probe_adopt/oob_probe_sd instead of creating its
own, and pins c2=2Eoob_probe_remote as the outgoing address=2E This lets t=
he
OOB server-probe socket become the connection socket, so the source
IP+port and destination match what the server's handshake cookie is
bound to=2E

  - link_socket_init_phase1: adopt the fd, inherit the address family
    and pre-set lsa->actual (resolve_remote preserves an already-defined
    actual)=2E The probe socket was created and bound by
    create_socket_udp_configured() with the link socket's options, so
    nothing is applied or bound here
  - linksock_print_addr: report an adopted socket's local address from
    getsockname(), since bind_local is cleared to mean "do not bind
    again" and the socket may well be bound (as LS_MODE_TCP_ACCEPT_FROM
    already does)
  - link_socket_init_phase2: skip create_socket() so the adopted fd is
    not clobbered (overlapped-I/O init is fd-independent, so Windows is
    fine)
  - do_init_socket_phase1: select the mode for the single client socket
  - do_close_link_socket: close the handed-off fd if the attempt aborted
    before it was adopted, so it is not leaked=2E context_clear_2() sets
    oob_probe_sd to SOCKET_UNDEFINED, since 0 is a valid descriptor, and
    inherit_context_child() does the same for a server's per-client
    contexts

The adopt path itself stays unused until the client sets oob_probe_adopt
(next commit)=2E

Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/init=2Ec=

M src/openvpn/openvpn=2Eh
M src/openvpn/socket=2Ec
M src/openvpn/socket=2E=
h
4 files changed, 65 insertions(+), 3 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/69/1769/18

diff --git a/src/=
openvpn/init=2Ec b/src/openvpn/init=2Ec
index ddf60c6=2E=2Ee506dfe 100644
-=
-- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -90,6 +90,8 @@
 con=
text_clear_2(struct context *c)
 {
     CLEAR(c->c2);
+    /* 0 is a valid =
descriptor, so "no socket" has to be set explicitly */
+    c->c2=2Eoob_pro=
be_sd =3D SOCKET_UNDEFINED;
 }
 
 void
@@ -3795,6 +3797,12 @@
             =
    mode =3D LS_MODE_TCP_ACCEPT_FROM;
             }
         }
+        /*=
 adopt the OOB server-probe socket as this client's connection socket
+    =
     * (probe-started handshake); only the single client socket is ever ado=
pted */
+        else if (c->c2=2Eoob_probe_adopt && i =3D=3D 0)
+        {=

+            mode =3D LS_MODE_UDP_ADOPT;
+        }
 
         /* init eac=
h socket with its specific args */
         link_socket_init_phase1(c, i, m=
ode);
@@ -3960,6 +3968,16 @@
 static void
 do_close_link_socket(struct cont=
ext *c)
 {
+    /* An OOB probe socket handed off for a probe-started hands=
hake is adopted by the
+     * link socket in link_socket_init_phase1() (wh=
ich clears oob_probe_sd)=2E If the
+     * connection attempt aborted befor=
e that, the fd is still owned here; close it
+     * so it is not leaked wh=
en context_clear_2() zeroes c2=2E */
+    if (c->c2=2Eoob_probe_sd !=3D SOC=
KET_UNDEFINED)
+    {
+        openvpn_close_socket(c->c2=2Eoob_probe_sd);
=
+        c->c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;
+    }
+
     if (c->c2=
=2Elink_sockets && c->c2=2Elink_socket_owned)
     {
         for (int i =
=3D 0; i < c->c1=2Elink_sockets_num; i++)
@@ -4814,6 +4832,8 @@
 inherit_co=
ntext_child(struct context *dest, const struct context *src, struct link_so=
cket *sock)
 {
     CLEAR(*dest);
+    /* 0 is a valid descriptor, so "no s=
ocket" has to be set explicitly */
+    dest->c2=2Eoob_probe_sd =3D SOCKET_=
UNDEFINED;
 
     /* proto_is_dgram will ASSERT(0) if proto is invalid */
 =
    dest->mode =3D proto_is_dgram(sock->info=2Eproto) ? CM_CHILD_UDP : CM_C=
HILD_TCP;
diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
in=
dex e9e18bf=2E=2E09c6a3c 100644
--- a/src/openvpn/openvpn=2Eh
+++ b/src/ope=
nvpn/openvpn=2Eh
@@ -240,7 +240,16 @@
 
     bool link_socket_owned;
 
-   =
 const struct link_socket *accept_from;   /* possibly do accept() on a pare=
nt link_socket */
+    const struct link_socket *accept_from; /* possibly d=
o accept() on a parent link_socket */
+
+    /* OOB probe-started handshake=
: when oob_probe_adopt is true, the
+     * connection adopts oob_probe_sd =
(the winning remote's probe
+     * socket) instead of creating one, and pi=
ns oob_probe_remote (the exact
+     * address probed) as the outgoing addr=
ess, so the source IP+port and the
+     * destination match what the serve=
r's handshake cookie is bound to=2E */
+    bool oob_probe_adopt;
+    sock=
et_descriptor_t oob_probe_sd;
+    struct openvpn_sockaddr oob_probe_remote=
;
 
     struct link_socket_actual *to_link_addr; /* IP address of remote *=
/
     struct link_socket_actual from;          /* address of incoming data=
gram */
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index =
e7acabc=2E=2E21d983e 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/=
socket=2Ec
@@ -1431,6 +1431,23 @@
         /* inherit (possibly guessed) in=
fo AF from parent context */
         sock->info=2Eaf =3D c->c2=2Eaccept_fr=
om->info=2Eaf;
     }
+    else if (mode =3D=3D LS_MODE_UDP_ADOPT)
+    {
+=
        /* Adopt the OOB probe socket=2E create_socket_udp_configured() set=
 it up with this
+         * socket's options and bind, so it only changes =
hands and keeps the source
+         * IP:port the server's cookie is bound=
 to; phase 2 creates nothing=2E */
+        ASSERT(c->c2=2Eoob_probe_sd !=
=3D SOCKET_UNDEFINED);
+        sock->sd =3D c->c2=2Eoob_probe_sd;
+       =
 c->c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED; /* ownership moves to the link =
socket */
+        sock->info=2Eaf =3D c->c2=2Eoob_probe_remote=2Eaddr=2Esa=
=2Esa_family;
+        sock->bind_local =3D false;              /* bound (o=
r --nobind) by the prober already */
+        sock->sockflags |=3D SF_GETAD=
DRINFO_DGRAM;
+
+        /* Pin the exact address we probed so the connecti=
on targets the address
+         * the cookie was minted for; resolve_remot=
e() preserves a defined actual=2E */
+        CLEAR(sock->info=2Elsa->actua=
l);
+        sock->info=2Elsa->actual=2Edest =3D c->c2=2Eoob_probe_remote;
=
+    }
 
     /* are we running in HTTP proxy mode? */
     if (sock->http_=
proxy)
@@ -1515,7 +1532,19 @@
     const msglvl_t msglevel =3D (sock->mode =
=3D=3D LS_MODE_TCP_ACCEPT_FROM) ? D_INIT_MEDIUM : M_INFO;
 
     /* print l=
ocal address */
-    if (sock->bind_local)
+    if (sock->mode =3D=3D LS_MO=
DE_UDP_ADOPT)
+    {
+        /* bound (or not) by the prober, so ask the s=
ocket itself */
+        struct sockaddr_storage local =3D { 0 };
+        =
socklen_t len =3D sizeof(local);
+        if (!getsockname(sock->sd, (struc=
t sockaddr *)&local, &len))
+        {
+            msg(msglevel, "%s link =
local (adopted): %s",
+                proto2ascii(sock->info=2Eproto, sock=
->info=2Eaf, true),
+                print_sockaddr((struct sockaddr *)&loc=
al, &gc));
+        }
+    }
+    else if (sock->bind_local)
     {
       =
  sa_family_t ai_family =3D sock->info=2Elsa->actual=2Edest=2Eaddr=2Esa=2Es=
a_family;
         /* Socket is always bound on the first matching address,=

@@ -1727,7 +1756,7 @@
         goto done;
     }
 #endif
-    if (sock->in=
fo=2Elsa->current_remote)
+    if (sock->mode !=3D LS_MODE_UDP_ADOPT && soc=
k->info=2Elsa->current_remote)
     {
         create_socket(sock, sock->in=
fo=2Elsa->current_remote);
     }
diff --git a/src/openvpn/socket=2Eh b/src=
/openvpn/socket=2Eh
index adaa60b=2E=2E94d9a76 100644
--- a/src/openvpn/soc=
ket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -198,6 +198,10 @@
 #define LS_MODE_=
DEFAULT         0
 #define LS_MODE_TCP_LISTEN      1
 #define LS_MODE_TCP_A=
CCEPT_FROM 2
+/* Adopt the OOB server-probe socket, created and set up like=
 a connection
+ * socket (bound unless --nobind), as the connection socket =
instead of creating
+ * one=2E */
+#define LS_MODE_UDP_ADOPT       3
     i=
nt mode;
 
     int resolve_retry_seconds;

-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1769?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755
Gerrit-=
Change-Number: 1769
Gerrit-PatchSet: 18
Gerrit-Owner: stipa <lstipakov@gmai=
l=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
plaisthos <arne-openvpn@rfc2549=2Eorg>

--07FlladPaEo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #18</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1769?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">socket: =
adopt a pre-created UDP socket for a client connection<br><br>Add LS_MODE_U=
DP_ADOPT: a client link_socket can take ownership of a UDP<br>socket, set u=
p like the connection socket (bound unless --nobind),<br>handed off via c2=
=2Eoob_probe_adopt/oob_probe_sd instead of creating its<br>own, and pins c2=
=2Eoob_probe_remote as the outgoing address=2E This lets the<br>OOB server-=
probe socket become the connection socket, so the source<br>IP+port and des=
tination match what the server&#39;s handshake cookie is<br>bound to=2E<br>=
<br>  - link_socket_init_phase1: adopt the fd, inherit the address family<b=
r>    and pre-set lsa-&gt;actual (resolve_remote preserves an already-defin=
ed<br>    actual)=2E The probe socket was created and bound by<br>    creat=
e_socket_udp_configured() with the link socket&#39;s options, so<br>    not=
hing is applied or bound here<br>  - linksock_print_addr: report an adopted=
 socket&#39;s local address from<br>    getsockname(), since bind_local is =
cleared to mean &quot;do not bind<br>    again&quot; and the socket may wel=
l be bound (as LS_MODE_TCP_ACCEPT_FROM<br>    already does)<br>  - link_soc=
ket_init_phase2: skip create_socket() so the adopted fd is<br>    not clobb=
ered (overlapped-I/O init is fd-independent, so Windows is<br>    fine)<br>=
  - do_init_socket_phase1: select the mode for the single client socket<br>=
  - do_close_link_socket: close the handed-off fd if the attempt aborted<br=
>    before it was adopted, so it is not leaked=2E context_clear_2() sets<b=
r>    oob_probe_sd to SOCKET_UNDEFINED, since 0 is a valid descriptor, and<=
br>    inherit_context_child() does the same for a server&#39;s per-client<=
br>    contexts<br><br>The adopt path itself stays unused until the client =
sets oob_probe_adopt<br>(next commit)=2E<br><br>Change-Id: Iec384ee6844ab27=
8b280d6eafec8aaecf9dde755<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2E=
net&gt;<br>---<br>M src/openvpn/init=2Ec<br>M src/openvpn/openvpn=2Eh<br>M =
src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>4 files changed, 65 i=
nsertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/69/1769/18</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index ddf60c=
6=2E=2Ee506dfe 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br>=
<span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -90,6 +90,8 @@</span><b=
r><span> context_clear_2(struct context *c)</span><br><span> {</span><br><s=
pan>     CLEAR(c-&gt;c2);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* 0 is a valid descriptor, so &quot;no socket&quot; has to be se=
t explicitly */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
c-&gt;c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br><span>@@ -3795,6 +3797,12 @@</span>=
<br><span>                 mode =3D LS_MODE_TCP_ACCEPT_FROM;</span><br><spa=
n>             }</span><br><span>         }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* adopt the OOB server-probe socket as thi=
s client&#39;s connection socket</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * (probe-started handshake); only the single client s=
ocket is ever adopted */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        else if (c-&gt;c2=2Eoob_probe_adopt &amp;&amp; i =3D=3D 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            mode =3D LS_MODE_UDP_=
ADOPT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span> </span><br><span>         /* init each socket with its specif=
ic args */</span><br><span>         link_socket_init_phase1(c, i, mode);</s=
pan><br><span>@@ -3960,6 +3968,16 @@</span><br><span> static void</span><br=
><span> do_close_link_socket(struct context *c)</span><br><span> {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* An OOB probe socket h=
anded off for a probe-started handshake is adopted by the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * link socket in link_socket_ini=
t_phase1() (which clears oob_probe_sd)=2E If the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * connection attempt aborted before that,=
 the fd is still owned here; close it</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * so it is not leaked when context_clear_2() zeroes =
c2=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&=
gt;c2=2Eoob_probe_sd !=3D SOCKET_UNDEFINED)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        openvpn_close_socket(c-&gt;c2=2Eoob_probe_sd);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_s=
d =3D SOCKET_UNDEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     if (c-&gt;c2=2Elink_sockets &amp;&amp; c-&gt;c2=2Elink_socket_o=
wned)</span><br><span>     {</span><br><span>         for (int i =3D 0; i &=
lt; c-&gt;c1=2Elink_sockets_num; i++)</span><br><span>@@ -4814,6 +4832,8 @@=
</span><br><span> inherit_context_child(struct context *dest, const struct =
context *src, struct link_socket *sock)</span><br><span> {</span><br><span>=
     CLEAR(*dest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* 0 is a valid descriptor, so &quot;no socket&quot; has to be set expli=
citly */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dest-&g=
t;c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;</span><br><span> </span><br><span=
>     /* proto_is_dgram will ASSERT(0) if proto is invalid */</span><br><sp=
an>     dest-&gt;mode =3D proto_is_dgram(sock-&gt;info=2Eproto) ? CM_CHILD_=
UDP : CM_CHILD_TCP;</span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/=
src/openvpn/openvpn=2Eh</span><br><span>index e9e18bf=2E=2E09c6a3c 100644</=
span><br><span>--- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/open=
vpn/openvpn=2Eh</span><br><span>@@ -240,7 +240,16 @@</span><br><span> </spa=
n><br><span>     bool link_socket_owned;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    const struct link_socket *accept_f=
rom;   /* possibly do accept() on a parent link_socket */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const struct link_socket *accept_=
from; /* possibly do accept() on a parent link_socket */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* OOB probe-started handshake: when oob_probe_adopt =
is true, the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
connection adopts oob_probe_sd (the winning remote&#39;s probe</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * socket) instead of creati=
ng one, and pins oob_probe_remote (the exact</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * address probed) as the outgoing address, so=
 the source IP+port and the</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * destination match what the server&#39;s handshake cookie is =
bound to=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
ool oob_probe_adopt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    socket_descriptor_t oob_probe_sd;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct openvpn_sockaddr oob_probe_remote;</span><br>=
<span> </span><br><span>     struct link_socket_actual *to_link_addr; /* IP=
 address of remote */</span><br><span>     struct link_socket_actual from; =
         /* address of incoming datagram */</span><br><span>diff --git a/sr=
c/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index e7acabc=
=2E=2E21d983e 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br=
><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -1431,6 +1431,23 @@<=
/span><br><span>         /* inherit (possibly guessed) info AF from parent =
context */</span><br><span>         sock-&gt;info=2Eaf =3D c-&gt;c2=2Eaccep=
t_from-&gt;info=2Eaf;</span><br><span>     }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else if (mode =3D=3D LS_MODE_UDP_ADOPT)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* Adopt the OOB probe socket=2E=
 create_socket_udp_configured() set it up with this</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * socket&#39;s options and bind,=
 so it only changes hands and keeps the source</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * IP:port the server&#39;s cookie is bo=
und to; phase 2 creates nothing=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        ASSERT(c-&gt;c2=2Eoob_probe_sd !=3D SOCKET_UNDEFI=
NED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sock-&=
gt;sd =3D c-&gt;c2=2Eoob_probe_sd;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        c-&gt;c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED; /* own=
ership moves to the link socket */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        sock-&gt;info=2Eaf =3D c-&gt;c2=2Eoob_probe_remote=
=2Eaddr=2Esa=2Esa_family;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        sock-&gt;bind_local =3D false;              /* bound (or --no=
bind) by the prober already */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        sock-&gt;sockflags |=3D SF_GETADDRINFO_DGRAM;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* Pin the exact address we probed so the=
 connection targets the address</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         * the cookie was minted for; resolve_remote() preserve=
s a defined actual=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        CLEAR(sock-&gt;info=2Elsa-&gt;actual);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;info=2Elsa-&gt;actual=2E=
dest =3D c-&gt;c2=2Eoob_probe_remote;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span> </span><br><span>     /* are we ru=
nning in HTTP proxy mode? */</span><br><span>     if (sock-&gt;http_proxy)<=
/span><br><span>@@ -1515,7 +1532,19 @@</span><br><span>     const msglvl_t =
msglevel =3D (sock-&gt;mode =3D=3D LS_MODE_TCP_ACCEPT_FROM) ? D_INIT_MEDIUM=
 : M_INFO;</span><br><span> </span><br><span>     /* print local address */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (sock-&gt;bind=
_local)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sock=
-&gt;mode =3D=3D LS_MODE_UDP_ADOPT)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* bound (or not) by the prober, so ask the socket itself */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct sockaddr_=
storage local =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        socklen_t len =3D sizeof(local);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (!getsockname(sock-&gt;sd, (struct soc=
kaddr *)&amp;local, &amp;len))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(msglevel, &quot;%s link local (adopted): %s&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                proto2ascii=
(sock-&gt;info=2Eproto, sock-&gt;info=2Eaf, true),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                print_sockaddr((struct socka=
ddr *)&amp;local, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (so=
ck-&gt;bind_local)</span><br><span>     {</span><br><span>         sa_famil=
y_t ai_family =3D sock-&gt;info=2Elsa-&gt;actual=2Edest=2Eaddr=2Esa=2Esa_fa=
mily;</span><br><span>         /* Socket is always bound on the first match=
ing address,</span><br><span>@@ -1727,7 +1756,7 @@</span><br><span>        =
 goto done;</span><br><span>     }</span><br><span> #endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (sock-&gt;info=2Elsa-&gt;curren=
t_remote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (so=
ck-&gt;mode !=3D LS_MODE_UDP_ADOPT &amp;&amp; sock-&gt;info=2Elsa-&gt;curre=
nt_remote)</span><br><span>     {</span><br><span>         create_socket(so=
ck, sock-&gt;info=2Elsa-&gt;current_remote);</span><br><span>     }</span><=
br><span>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span=
><br><span>index adaa60b=2E=2E94d9a76 100644</span><br><span>--- a/src/open=
vpn/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span=
>@@ -198,6 +198,10 @@</span><br><span> #define LS_MODE_DEFAULT         0</s=
pan><br><span> #define LS_MODE_TCP_LISTEN      1</span><br><span> #define L=
S_MODE_TCP_ACCEPT_FROM 2</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* Adopt the OOB server-probe socket, created and set up like a connec=
tion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * socket (boun=
d unless --nobind), as the connection socket instead of creating</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * one=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define LS_MODE_UDP_ADOPT       3</sp=
an><br><span>     int mode;</span><br><span> </span><br><span>     int reso=
lve_retry_seconds;</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1769?usp=3Demail">change 17=
69</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1769?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1769 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 18 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--07FlladPaEo=--


--===============2196526243500224969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2196526243500224969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2196526243500224969==--

