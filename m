Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEEBC88E5B
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wK9RZkwJB77SF3DEMCIFyiPcEf+CoZ9KFAe3iq1LECw=; b=QdwRf5/j9w80kph0Ogels3Iboy
	bFyaVti1aMyfcaaqqDxU7lqO1RXri8TDcJHg2pKZXiePaevlArc0JN0dQcjPrwDV2H4Ng5PB6tWuW
	S9JCHo2OwphV93B+IuBUROFyy/SrsIOecT271y4hREfoDCJYlVyLjeVeYYYR0kGHIpck=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4xIQ-0004jT-PB;
	Fri, 11 Sep 2026 09:11:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4xII-0004iN-LL
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=y5jlO/w9itT9EzuySy5Ky7SO22zDNhFZVi5MfcOZdvg=; b=TJWotih5Z9U9da4m2KDQuUtqxw
 Dhp/VdUkkmPPz5ObtnOoCqolcov86zkTqTEBgP06put2KW61LAew9iNa9lcgHq75OJmDyoFi2FtYt
 PH+NMkwwJBnr0S4pO0MRfMnLzquXAzL7blPF0KsrkRPhSR5jCSi4/qtg+rIIBWUm9anI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=y5jlO/w9itT9EzuySy5Ky7SO22zDNhFZVi5MfcOZdvg=; b=L
 etf9+JbUZjnW9LtL8SLimoSBZnaVMsn8/8hniy3LFyLfSqciJZeRartTL7Od0yTC5Jkhx7PVRcmVe
 RNH7SaCyElhQ+fiaj5RwN+MPatxAu69J+p3GUshxD6dg11S8wl/O/h8Ow6vn/H8WyToz5IRJFaMyk
 NqaOcl1pPoewaxsg=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4xIB-0006cg-4b for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:36 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-486955ae01eso718812f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 02:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789117884; x=1789722684; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y5jlO/w9itT9EzuySy5Ky7SO22zDNhFZVi5MfcOZdvg=;
 b=PuqmAvxaOj9U2WsPyZm5WkE6JMVuDHwJF9XTB8YUQNczEMOAVr/aC4zHKqQ/ASaNV4
 QIk7Nn45im32PR9bfEPVr4Z9BNStqWMCISpYznLfjTR+b7coKrFTMTArQCLO4ddvKRiM
 FoTGUYXqq7r5ayEeMea/7807t0TaUPk42Z8ry04rSrYJr2AfGwN80r+/wLx0TfBNmb4S
 CoCLONUGx2zGDqC1QcGqkg1YcWWAhOLWYU2cttZiQzvFZnsDFNGBOjznoNcw8ismWqKB
 +KZJyVOMGOTXPgsrxA0DeVUvaMWczbQ6mEsq2MQWNqvTQf2EXbb0FlbSrJ/sh9Vo0pff
 RIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117884; x=1789722684;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=y5jlO/w9itT9EzuySy5Ky7SO22zDNhFZVi5MfcOZdvg=;
 b=VWld7xeBpMOBRB6/8wlL8y6dztBd0uULmmoYK6m0upah93KI8wFyDl7qj7ueWPK16V
 Hf1dRG9PMW5n2k3zFY9DwQXNB2rbhqcyI36AaK1ETqo1fLayffv/pvnykHrXVjCf7edB
 VMy4Qa6nzCAf5vq6s6kjj8n8ryKS/s0lUgDk5kUszE9/J+p+LNZnlwAOt9OdUehy+TaL
 d5iIldRVoDRzFuSfksJ15GC1MJph8TiGHwH77QXJvHdHe8CwwTLUESB1qrvkTC2YPE7w
 3Y2w0FTxS1VbxbWxBfrPtskRl9bV4YKYoGsbGno6qJUvRvhLdfT3pCjoacsm//Ic+jgG
 7m0A==
X-Gm-Message-State: AFuF++k1fsd4d6h9Ih8pGtaLLbn5FlqU46Lh8LfVSkyRFTIucRcUwwgg
 XDPt92Bgj5Syi3gBfZ0qBTKV5BHCvkRe6lRXNMwV3PYhqQpkR8RZZrdxymAmmZdj6gmJplv4tlD
 k6p+aQNZrOjzrQJVnV8cRTS+EaXZLkDxyY08RMUTB4ekZQw3gkem7cNdrxFh8Fo7ltL69cothiF
 NzfH9QEQ==
X-Gm-Gg: AYBFou0FwAq6Ds3votJ3P8/IXhf4T47QSRIcUB/DtrL5+bOxE3HsAsUPW+uWTAkHjgp
 duGgl3wzWb4+jsGFlcFXHFfoO0pYySI9BWnsasbtuEBbEjh8NyPf9QSJX3qEg1ejXNkgLsL/pNw
 KDTgLzc7OOOaWWxZuucyc9wtcFAiVJE3E2CX47M9G1ZMhvQ6xvk5jWK8IfATEwKbXwUTI9K1RJn
 4n55+HOHW/UykYCJ/EKukHzF1fNXsrpe1Dt613IIwT20fUDrdvszCESN1fnh019nWgrupUVfk0M
 BAwqv+SX2RSm5hp47e0gheGopoTPK2oPPmSSm7yAAw0HcN/CGtcpry9wHuwuquXhBmgulGqerH6
 wwRR/1J/o5BgcS2du5lL4Y032KD2A2kR6WJjBGF0L/8eHhYFgX9WUrYbRuUM+OPKH/7itTVPAQX
 n5Q8AP0wcikepo1NlKeJ9AZYQZC0RjKRng348k+DfUXH4qCqcsHP1Euy3JVF+1Rmdj9l8H5GIh/
 DKwX7xJUhDmweCpvktc9BduluwclLxPdO+MkSOEThH5pAxGquCjmwe0JDIvZlooai9WBlEvGGEN
 cQt+qj4FQBRd7wj5zeRpq+OBERXdjA+wLXzY+zjNSr8uuLs7QAfXmvVlw0R3nw==
X-Received: by 2002:a05:600c:8b5b:b0:49c:fc6c:be1b with SMTP id
 5b1f17b1804b1-49e619d5301mr38541585e9.33.1789117883780; 
 Fri, 11 Sep 2026 02:11:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb2ecf2esm5162586f8f.2.2026.09.11.02.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:11:23 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 09:11:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755
X-Gerrit-Change-Number: 1769
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1769?usp=email>
X-Gerrit-Commit: d21561bf2734066edcb5c1041d115b9fcebfebdf
In-Reply-To: <gerrit.1783320647000.Iec384ee6844ab278b280d6eafec8aaecf9dde755@gerrit.openvpn.net>
References: <gerrit.1783320647000.Iec384ee6844ab278b280d6eafec8aaecf9dde755@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkllYzM4NGVlNjg0NGFiMjc4YjI4MGQ2ZWFmZWM4YWFlY2Y5ZGRlNzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <84ee453f5c6fe404a5d2c503435a9b8dfd97cf9b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4xIB-0006cg-4b
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
Content-Type: multipart/mixed; boundary="===============1094097506947329594=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1094097506947329594==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="86PNv+ES3Sg="; charset=UTF-8

--86PNv+ES3Sg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1769?usp=3Demail

to look at the new patch set (#15)=2E
=


Change subject: socket: adopt a pre-created UDP socket for a client conne=
ction
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket:=
 adopt a pre-created UDP socket for a client connection

Add LS_MODE_UDP_AD=
OPT: a client link_socket can take ownership of a UDP
socket, set up like t=
he connection socket (bound unless --nobind),
handed off via c2=2Eoob_probe=
_adopt/oob_probe_sd instead of creating its
own, and pins c2=2Eoob_probe_re=
mote as the outgoing address=2E This lets the
OOB server-probe socket becom=
e the connection socket, so the source
IP+port and destination match what t=
he server's handshake cookie is
bound to=2E

  - link_socket_init_phase1: a=
dopt the fd, inherit the address family
    and pre-set lsa->actual (resolv=
e_remote preserves an already-defined
    actual)=2E The probe socket was c=
reated and bound by
    create_socket_udp_configured() with the link socket=
's options, so
    nothing is applied or bound here
  - link_socket_init_ph=
ase2: skip create_socket() so the adopted fd is
    not clobbered (overlapp=
ed-I/O init is fd-independent, so Windows is
    fine)
  - do_init_socket_p=
hase1: select the mode for the single client socket
  - do_close_link_socke=
t: close the handed-off fd if the attempt aborted
    before it was adopted=
, so it is not leaked=2E context_clear_2() sets
    oob_probe_sd to SOCKET_=
UNDEFINED, since 0 is a valid descriptor, and
    inherit_context_child() d=
oes the same for a server's per-client
    contexts

The adopt path itself =
stays unused until the client sets oob_probe_adopt
(next commit)=2E

Change=
-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755
Signed-off-by: Lev Stipakov =
<lev@openvpn=2Enet>
---
M src/openvpn/init=2Ec
M src/openvpn/openvpn=2Eh
M =
src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
4 files changed, 52 inserti=
ons(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/69/1769/15

diff --git a/src/openvpn/init=2Ec b/src/openvp=
n/init=2Ec
index fabe4b2=2E=2Eea85bad 100644
--- a/src/openvpn/init=2Ec
+++=
 b/src/openvpn/init=2Ec
@@ -90,6 +90,8 @@
 context_clear_2(struct context *=
c)
 {
     CLEAR(c->c2);
+    /* 0 is a valid descriptor, so "no socket" ha=
s to be set explicitly */
+    c->c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;
 =
}
 
 void
@@ -3792,6 +3794,12 @@
                 mode =3D LS_MODE_TCP_ACCE=
PT_FROM;
             }
         }
+        /* adopt the OOB server-probe s=
ocket as this client's connection socket
+         * (probe-started handsha=
ke); only the single client socket is ever adopted */
+        else if (c->=
c2=2Eoob_probe_adopt && i =3D=3D 0)
+        {
+            mode =3D LS_MOD=
E_UDP_ADOPT;
+        }
 
         /* init each socket with its specific ar=
gs */
         link_socket_init_phase1(c, i, mode);
@@ -3957,6 +3965,16 @@
=
 static void
 do_close_link_socket(struct context *c)
 {
+    /* An OOB pro=
be socket handed off for a probe-started handshake is adopted by the
+     =
* link socket in link_socket_init_phase1() (which clears oob_probe_sd)=2E I=
f the
+     * connection attempt aborted before that, the fd is still owned=
 here; close it
+     * so it is not leaked when context_clear_2() zeroes c=
2=2E */
+    if (c->c2=2Eoob_probe_sd !=3D SOCKET_UNDEFINED)
+    {
+      =
  openvpn_close_socket(c->c2=2Eoob_probe_sd);
+        c->c2=2Eoob_probe_sd=
 =3D SOCKET_UNDEFINED;
+    }
+
     if (c->c2=2Elink_sockets && c->c2=2Eli=
nk_socket_owned)
     {
         for (int i =3D 0; i < c->c1=2Elink_sockets=
_num; i++)
@@ -4811,6 +4829,8 @@
 inherit_context_child(struct context *des=
t, const struct context *src, struct link_socket *sock)
 {
     CLEAR(*dest=
);
+    /* 0 is a valid descriptor, so "no socket" has to be set explicitly=
 */
+    dest->c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;
 
     /* proto_is_d=
gram will ASSERT(0) if proto is invalid */
     dest->mode =3D proto_is_dgr=
am(sock->info=2Eproto) ? CM_CHILD_UDP : CM_CHILD_TCP;
diff --git a/src/open=
vpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index e9e18bf=2E=2E09c6a3c 100644=

--- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -240,7 +240=
,16 @@
 
     bool link_socket_owned;
 
-    const struct link_socket *acce=
pt_from;   /* possibly do accept() on a parent link_socket */
+    const st=
ruct link_socket *accept_from; /* possibly do accept() on a parent link_soc=
ket */
+
+    /* OOB probe-started handshake: when oob_probe_adopt is true,=
 the
+     * connection adopts oob_probe_sd (the winning remote's probe
+  =
   * socket) instead of creating one, and pins oob_probe_remote (the exact
=
+     * address probed) as the outgoing address, so the source IP+port and =
the
+     * destination match what the server's handshake cookie is bound t=
o=2E */
+    bool oob_probe_adopt;
+    socket_descriptor_t oob_probe_sd;
+=
    struct openvpn_sockaddr oob_probe_remote;
 
     struct link_socket_act=
ual *to_link_addr; /* IP address of remote */
     struct link_socket_actua=
l from;          /* address of incoming datagram */
diff --git a/src/openvp=
n/socket=2Ec b/src/openvpn/socket=2Ec
index 223b811=2E=2Ec531b6e 100644
---=
 a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -1417,6 +1417,23 =
@@
         /* inherit (possibly guessed) info AF from parent context */
  =
       sock->info=2Eaf =3D c->c2=2Eaccept_from->info=2Eaf;
     }
+    else=
 if (mode =3D=3D LS_MODE_UDP_ADOPT)
+    {
+        /* Adopt the OOB probe =
socket=2E create_socket_udp_configured() set it up with this
+         * so=
cket's options and bind, so it only changes hands and keeps the source
+   =
      * IP:port the server's cookie is bound to; phase 2 creates nothing=2E=
 */
+        ASSERT(c->c2=2Eoob_probe_sd !=3D SOCKET_UNDEFINED);
+        s=
ock->sd =3D c->c2=2Eoob_probe_sd;
+        c->c2=2Eoob_probe_sd =3D SOCKET_=
UNDEFINED; /* ownership moves to the link socket */
+        sock->info=2Ea=
f =3D c->c2=2Eoob_probe_remote=2Eaddr=2Esa=2Esa_family;
+        sock->bind=
_local =3D false;              /* bound (or --nobind) by the prober already=
 */
+        sock->sockflags |=3D SF_GETADDRINFO_DGRAM;
+
+        /* Pin t=
he exact address we probed so the connection targets the address
+         =
* the cookie was minted for; resolve_remote() preserves a defined actual=2E=
 */
+        CLEAR(sock->info=2Elsa->actual);
+        sock->info=2Elsa->ac=
tual=2Edest =3D c->c2=2Eoob_probe_remote;
+    }
 
     /* are we running i=
n HTTP proxy mode? */
     if (sock->http_proxy)
@@ -1713,7 +1730,7 @@
    =
     goto done;
     }
 #endif
-    if (sock->info=2Elsa->current_remote)
+=
    if (sock->mode !=3D LS_MODE_UDP_ADOPT && sock->info=2Elsa->current_remo=
te)
     {
         create_socket(sock, sock->info=2Elsa->current_remote);
=
     }
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index 2=
633ca8=2E=2E9c675c0 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/s=
ocket=2Eh
@@ -198,6 +198,10 @@
 #define LS_MODE_DEFAULT         0
 #define =
LS_MODE_TCP_LISTEN      1
 #define LS_MODE_TCP_ACCEPT_FROM 2
+/* Adopt the =
OOB server-probe socket, created and set up like a connection
+ * socket (b=
ound unless --nobind), as the connection socket instead of creating
+ * one=
=2E */
+#define LS_MODE_UDP_ADOPT       3
     int mode;
 
     int resolve=
_retry_seconds;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1769?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: ne=
wpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
ec384ee6844ab278b280d6eafec8aaecf9dde755
Gerrit-Change-Number: 1769
Gerrit-=
PatchSet: 15
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>

--86PNv+ES3Sg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #15</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
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
hing is applied or bound here<br>  - link_socket_init_phase2: skip create_s=
ocket() so the adopted fd is<br>    not clobbered (overlapped-I/O init is f=
d-independent, so Windows is<br>    fine)<br>  - do_init_socket_phase1: sel=
ect the mode for the single client socket<br>  - do_close_link_socket: clos=
e the handed-off fd if the attempt aborted<br>    before it was adopted, so=
 it is not leaked=2E context_clear_2() sets<br>    oob_probe_sd to SOCKET_U=
NDEFINED, since 0 is a valid descriptor, and<br>    inherit_context_child()=
 does the same for a server&#39;s per-client<br>    contexts<br><br>The ado=
pt path itself stays unused until the client sets oob_probe_adopt<br>(next =
commit)=2E<br><br>Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755<br>S=
igned-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvp=
n/init=2Ec<br>M src/openvpn/openvpn=2Eh<br>M src/openvpn/socket=2Ec<br>M sr=
c/openvpn/socket=2Eh<br>4 files changed, 52 insertions(+), 2 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/69/1769/15</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/=
openvpn/init=2Ec</span><br><span>index fabe4b2=2E=2Eea85bad 100644</span><b=
r><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=
=2Ec</span><br><span>@@ -90,6 +90,8 @@</span><br><span> context_clear_2(str=
uct context *c)</span><br><span> {</span><br><span>     CLEAR(c-&gt;c2);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 0 is a valid de=
scriptor, so &quot;no socket&quot; has to be set explicitly */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eoob_probe_sd =3D =
SOCKET_UNDEFINED;</span><br><span> }</span><br><span> </span><br><span> voi=
d</span><br><span>@@ -3792,6 +3794,12 @@</span><br><span>                 m=
ode =3D LS_MODE_TCP_ACCEPT_FROM;</span><br><span>             }</span><br><=
span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* adopt the OOB server-probe socket as this client&#39;s connection so=
cket</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * (pro=
be-started handshake); only the single client socket is ever adopted */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (c-&gt;=
c2=2Eoob_probe_adopt &amp;&amp; i =3D=3D 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            mode =3D LS_MODE_UDP_ADOPT;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> </span><br><sp=
an>         /* init each socket with its specific args */</span><br><span> =
        link_socket_init_phase1(c, i, mode);</span><br><span>@@ -3957,6 +39=
65,16 @@</span><br><span> static void</span><br><span> do_close_link_socket=
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
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (c-&gt;c2=2El=
ink_sockets &amp;&amp; c-&gt;c2=2Elink_socket_owned)</span><br><span>     {=
</span><br><span>         for (int i =3D 0; i &lt; c-&gt;c1=2Elink_sockets_=
num; i++)</span><br><span>@@ -4811,6 +4829,8 @@</span><br><span> inherit_co=
ntext_child(struct context *dest, const struct context *src, struct link_so=
cket *sock)</span><br><span> {</span><br><span>     CLEAR(*dest);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* 0 is a valid descripto=
r, so &quot;no socket&quot; has to be set explicitly */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    dest-&gt;c2=2Eoob_probe_sd =3D SOCK=
ET_UNDEFINED;</span><br><span> </span><br><span>     /* proto_is_dgram will=
 ASSERT(0) if proto is invalid */</span><br><span>     dest-&gt;mode =3D pr=
oto_is_dgram(sock-&gt;info=2Eproto) ? CM_CHILD_UDP : CM_CHILD_TCP;</span><b=
r><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</spa=
n><br><span>index e9e18bf=2E=2E09c6a3c 100644</span><br><span>--- a/src/ope=
nvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</span><br><s=
pan>@@ -240,7 +240,16 @@</span><br><span> </span><br><span>     bool link_s=
ocket_owned;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    const struct link_socket *accept_from;   /* possibly do accept=
() on a parent link_socket */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const struct link_socket *accept_from; /* possibly do accept(=
) on a parent link_socket */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* OOB=
 probe-started handshake: when oob_probe_adopt is true, the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * connection adopts oob_probe_=
sd (the winning remote&#39;s probe</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * socket) instead of creating one, and pins oob_probe_r=
emote (the exact</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * address probed) as the outgoing address, so the source IP+port and the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * destination m=
atch what the server&#39;s handshake cookie is bound to=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    bool oob_probe_adopt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    socket_descriptor_t oob=
_probe_sd;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t openvpn_sockaddr oob_probe_remote;</span><br><span> </span><br><span>    =
 struct link_socket_actual *to_link_addr; /* IP address of remote */</span>=
<br><span>     struct link_socket_actual from;          /* address of incom=
ing datagram */</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/o=
penvpn/socket=2Ec</span><br><span>index 223b811=2E=2Ec531b6e 100644</span><=
br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/soc=
ket=2Ec</span><br><span>@@ -1417,6 +1417,23 @@</span><br><span>         /* =
inherit (possibly guessed) info AF from parent context */</span><br><span> =
        sock-&gt;info=2Eaf =3D c-&gt;c2=2Eaccept_from-&gt;info=2Eaf;</span>=
<br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else if (mode =3D=3D LS_MODE_UDP_ADOPT)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* Adopt the OOB probe socket=2E create_socket_udp_configure=
d() set it up with this</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+         * socket&#39;s options and bind, so it only changes hands and =
keeps the source</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
      * IP:port the server&#39;s cookie is bound to; phase 2 creates nothin=
g=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSE=
RT(c-&gt;c2=2Eoob_probe_sd !=3D SOCKET_UNDEFINED);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        sock-&gt;sd =3D c-&gt;c2=2Eoob_probe=
_sd;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c=
2=2Eoob_probe_sd =3D SOCKET_UNDEFINED; /* ownership moves to the link socke=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sock-&g=
t;info=2Eaf =3D c-&gt;c2=2Eoob_probe_remote=2Eaddr=2Esa=2Esa_family;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;bind_loca=
l =3D false;              /* bound (or --nobind) by the prober already */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;sock=
flags |=3D SF_GETADDRINFO_DGRAM;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /* Pin the exact address we probed so the connection targets the address<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * the cooki=
e was minted for; resolve_remote() preserves a defined actual=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(sock-&gt;info=
=2Elsa-&gt;actual);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        sock-&gt;info=2Elsa-&gt;actual=2Edest =3D c-&gt;c2=2Eoob_probe_remo=
te;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span> </span><br><span>     /* are we running in HTTP proxy mode? */</span=
><br><span>     if (sock-&gt;http_proxy)</span><br><span>@@ -1713,7 +1730,7=
 @@</span><br><span>         goto done;</span><br><span>     }</span><br><s=
pan> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (so=
ck-&gt;info=2Elsa-&gt;current_remote)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (sock-&gt;mode !=3D LS_MODE_UDP_ADOPT &amp;&amp; s=
ock-&gt;info=2Elsa-&gt;current_remote)</span><br><span>     {</span><br><sp=
an>         create_socket(sock, sock-&gt;info=2Elsa-&gt;current_remote);</s=
pan><br><span>     }</span><br><span>diff --git a/src/openvpn/socket=2Eh b/=
src/openvpn/socket=2Eh</span><br><span>index 2633ca8=2E=2E9c675c0 100644</s=
pan><br><span>--- a/src/openvpn/socket=2Eh</span><br><span>+++ b/src/openvp=
n/socket=2Eh</span><br><span>@@ -198,6 +198,10 @@</span><br><span> #define =
LS_MODE_DEFAULT         0</span><br><span> #define LS_MODE_TCP_LISTEN      =
1</span><br><span> #define LS_MODE_TCP_ACCEPT_FROM 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Adopt the OOB server-probe socket, cre=
ated and set up like a connection</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * socket (bound unless --nobind), as the connection socket i=
nstead of creating</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* one=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
LS_MODE_UDP_ADOPT       3</span><br><span>     int mode;</span><br><span> <=
/span><br><span>     int resolve_retry_seconds;</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1769?usp=3Demail">change 1769</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1769?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1769 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 15 </div>
<div style=3D"display:n=
one"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</b=
ody></html>
--86PNv+ES3Sg=--


--===============1094097506947329594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1094097506947329594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1094097506947329594==--

