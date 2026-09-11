Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4D4C88E50
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fZYXv/MaevOuHN6CFLG6GiZo8fH6xF9cLDRXyXQb8o4=; b=JNqmApcksj5gMM0ltGUNzOYbl8
	WiqOqKdkJ/NRokaMVbQFe8hN2gYuwZ/pX03gGuIDo37Fx78uYZRFkZ0LlTfxVtu1tv8pE9B5fi4o/
	53Dh8WVk7OKMcwQkBjPY1SwRGktk93d8zaFvM3j0UkLcAC2cjsoq7l4ta7xN+hGwoADA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4wT3-0004ro-K6;
	Fri, 11 Sep 2026 08:18:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4wT2-0004rh-5Q
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:18:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cy3QlIZsPQxOX4UX+mkCzg8t75JYKNlAUkqEj3JwZ5Y=; b=UD528YIPnHZ6GBdklzZqEd03Fw
 M437mS+k3ky5wgtDnKnhgZwmkJMq8NVQLF7XTb+S0mAkgA/HU1MRsV5Ph+L8DELqNnDXpT/Vle2xP
 TphKrB1ph3Z0Xah3FkROP2Ozu545T5sfDWxr9J7Uu0HZsJjhHinonLv2JgwLAiLEfwZo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cy3QlIZsPQxOX4UX+mkCzg8t75JYKNlAUkqEj3JwZ5Y=; b=L
 L3b6vSE+bztYnMAtZwtO2SuownNQaUvtSDOJ3kxrgtTWGNqwVaqFzqRCrOBkA+5E8lRWqSkTPBV73
 QtCR9s3I6m9JgARzLCusv+IlY9p6i4oUnrpebiCNMYeT167t/wFXZmliF4oYLo+Hslt8U7hwAA7JM
 Gbszj8JK0s/l1Wyo=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4wSy-0005Pl-Sp for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:18:40 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso4690185e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 01:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789114710; x=1789719510; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cy3QlIZsPQxOX4UX+mkCzg8t75JYKNlAUkqEj3JwZ5Y=;
 b=FxVyJPGl9U45CtHudnnzd23moMAOfX6/Y0mSBdNbTsdWYoasqubwvwyKcajpSL2/Db
 Buaqge/3hdYjD78IdH7uGJGQeQkUpDBxRAx5EEPu5xDtb2tf13BEPRXJejo0Z5cRMA9f
 xzSxtU/kozZb+UsZMwcP0Z44bzA++2vM+/CdSbPOp0a+wDJcGjttN4u0mxoTCu+Zb3H7
 nvZscMwW128fjYVcnCGHaXvVz+f8vSjukcvyf0Jf6egfHCxYfxHKui3+Lh1hQKtdLwPk
 w3o35iYYu3WW8MIPGDdZn/kDhCwQUEb0pY+aUFkRBVbbXKiKDa+u7WMShKg9CylHqGUP
 gx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789114710; x=1789719510;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cy3QlIZsPQxOX4UX+mkCzg8t75JYKNlAUkqEj3JwZ5Y=;
 b=VxMZXpUAp9ItiTtdjyz95jTkkJrnB08GHgXqVYMqT8WwbAmJ81tp6l3iSV8eGSxfO0
 Ax30JZF/G2B7uu0iVAb54SI0MKeYc8xn6vyHveFqDGdy+caCj7yEFw0HAoIq0rBy8J9O
 rAFaq1Mx6o6XTG9EAJDR0CEIGJlKn8xUlhtamNd0OaHbjUoxbxGk7+a51+8OVyME5bNi
 QlORLDvVk/Ti3KCDKJ9qQeAYQMTxmLeTTXQWfuAXSTmj62xMLMitQidiRiZlGqcNFZFS
 go6AADH+/0vsLvYIpFD9N76qfxtaP+lcDwTusu273+CS/DI2htxRCRg9Gt8DZ24VNupx
 Y0xg==
X-Gm-Message-State: AFuF++n4WAZwFu8d5/8WSiBxTP2DZxsNT0kdZ2W8Pusxz7ouAa1eGjFU
 +uuDKxPZyEJWJ3DH2hhPcHGotRjXPyVbYvhyU+IOkSGMohkWvxrDWiLGfEsAyY70/GWOoKuP0Cj
 tfgHaFNMka3PVNuTS4am5WJvKziQDTczp65jHP3Sh0Tx6xb2BemfXC+8so7GwrBUmcvoS
X-Gm-Gg: AYBFou27gbUjPDXBMhnyopFM6SwahaAoS1+arGSTWal2x/R8UtE1JAhYgMsTwDmpOld
 DDkPvsOhSwepJE0C/f20RxbzuS+f7frmAdzmJ1jJXvknSgXvEOfSs40Vl2SGQxBu1thtoHZp1fH
 lhok9FH4cwip1+2K0HY0gsDJN5oNLLPCTnZf2pLccZO3SurbgSdnA6dvc7e0/3w/trQjpkDkkcI
 3nEcAwn18OxY5QkR1mzryG3kIE8ke8JofLTCwks3gnqIZ3MTsnl0HnWquPXPMtydanth+RNV7Vi
 qCzpA11DZYF/mW9OKt2SzLuxCAeyx8wBC+eAPXPsVirdP2ErRpT0Q8YM3CbOH9YzHxmCClDmRw2
 U1tyzLvACMJE9ziWymSvxIBZ/6XsKO8iNLFNVMqFxD3536A57sP0Aj1xFX3xakTSI2rA8B8IcQ4
 uzjyqwNl/24mrsY2d1SXboklhn0mimjgRFkSaa8jP8teMJDc/ZECWLAR4TR40/+4bBXq2ISWY9L
 JzHGWbzlhXqz9rY1a173e1zHHZ16IB4AafCui5Msxr0HzsuJ4Nb5RiEIAsBOavFEDdvlxBWknBj
 jwwg3xtdRPZR0T9CSfAiI6AB6YvO64tcG+uG/GWKZt94uI4varCN5cMghuO4jU0=
X-Received: by 2002:a05:600c:19c8:b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-49e619f3ae1mr57147195e9.10.1789114710091; 
 Fri, 11 Sep 2026 01:18:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60946249sm66583605e9.0.2026.09.11.01.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 01:18:29 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 08:18:16 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755
X-Gerrit-Change-Number: 1769
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1769?usp=email>
X-Gerrit-Commit: 64a51e2de89a73a146e0c55f7c59c1ccb9e7ef31
In-Reply-To: <gerrit.1783320647000.Iec384ee6844ab278b280d6eafec8aaecf9dde755@gerrit.openvpn.net>
References: <gerrit.1783320647000.Iec384ee6844ab278b280d6eafec8aaecf9dde755@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkllYzM4NGVlNjg0NGFiMjc4YjI4MGQ2ZWFmZWM4YWFlY2Y5ZGRlNzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <178d7cbd694048cf3008f8ccc8647b00c408d273-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4wSy-0005Pl-Sp
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
Content-Type: multipart/mixed; boundary="===============7251909595289995534=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7251909595289995534==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5hduNu086eI="; charset=UTF-8

--5hduNu086eI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1769?usp=3Demail

to look at the new patch set (#14)=2E
=


Change subject: socket: adopt a pre-created UDP socket for a client conne=
ction
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket:=
 adopt a pre-created UDP socket for a client connection

Add LS_MODE_UDP_AD=
OPT: a client link_socket can take ownership of an
already-bound UDP socket=
 handed off via c2=2Eoob_probe_adopt/oob_probe_sd
instead of creating its o=
wn, and pins c2=2Eoob_probe_remote as the outgoing
address=2E This lets the=
 OOB server-probe socket become the connection socket,
so the source IP+por=
t and destination match what the server's handshake
cookie is bound to=2E

=
  - link_socket_init_phase1: adopt the fd, inherit the address family and
 =
   pre-set lsa->actual (resolve_remote preserves an already-defined actual)=
=2E
    The probe socket was created and bound by create_socket_udp_configu=
red()
    with the link socket's options, so nothing is applied or bound he=
re
  - link_socket_init_phase2: skip create_socket() so the adopted fd is n=
ot
    clobbered (overlapped-I/O init is fd-independent, so Windows is fine=
)
  - do_init_socket_phase1: select the mode for the single client socket
 =
 - do_close_link_socket: close the handed-off fd if the attempt aborted bef=
ore
    it was adopted, so it is not leaked=2E context_clear_2() sets oob_p=
robe_sd to
    SOCKET_UNDEFINED, since 0 is a valid descriptor

The adopt p=
ath itself stays unused until the client sets oob_probe_adopt (next
commit)=
=2E

Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755
Signed-off-by: Le=
v Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/init=2Ec
M src/openvpn/ope=
nvpn=2Eh
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
4 files changed,=
 48 insertions(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/69/1769/14

diff --git a/src/openvpn/init=2Ec b=
/src/openvpn/init=2Ec
index fabe4b2=2E=2E3f805f3 100644
--- a/src/openvpn/i=
nit=2Ec
+++ b/src/openvpn/init=2Ec
@@ -90,6 +90,8 @@
 context_clear_2(struc=
t context *c)
 {
     CLEAR(c->c2);
+    /* 0 is a valid descriptor, so "no=
 socket" has to be set explicitly */
+    c->c2=2Eoob_probe_sd =3D SOCKET_U=
NDEFINED;
 }
 
 void
@@ -3792,6 +3794,12 @@
                 mode =3D LS_MO=
DE_TCP_ACCEPT_FROM;
             }
         }
+        /* adopt the OOB ser=
ver-probe socket as this client's connection socket
+         * (probe-star=
ted handshake); only the single client socket is ever adopted */
+        e=
lse if (c->c2=2Eoob_probe_adopt && i =3D=3D 0)
+        {
+            mode=
 =3D LS_MODE_UDP_ADOPT;
+        }
 
         /* init each socket with its =
specific args */
         link_socket_init_phase1(c, i, mode);
@@ -3957,6 +=
3965,16 @@
 static void
 do_close_link_socket(struct context *c)
 {
+    /*=
 An OOB probe socket handed off for a probe-started handshake is adopted by=
 the
+     * link socket in link_socket_init_phase1() (which clears oob_pro=
be_sd)=2E If the
+     * connection attempt aborted before that, the fd is =
still owned here; close it
+     * so it is not leaked when context_clear_2=
() zeroes c2=2E */
+    if (c->c2=2Eoob_probe_sd !=3D SOCKET_UNDEFINED)
+  =
  {
+        openvpn_close_socket(c->c2=2Eoob_probe_sd);
+        c->c2=2Eo=
ob_probe_sd =3D SOCKET_UNDEFINED;
+    }
+
     if (c->c2=2Elink_sockets &&=
 c->c2=2Elink_socket_owned)
     {
         for (int i =3D 0; i < c->c1=2El=
ink_sockets_num; i++)
diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/op=
envpn=2Eh
index e9e18bf=2E=2E436495e 100644
--- a/src/openvpn/openvpn=2Eh
+=
++ b/src/openvpn/openvpn=2Eh
@@ -240,7 +240,16 @@
 
     bool link_socket_o=
wned;
 
-    const struct link_socket *accept_from;   /* possibly do accept=
() on a parent link_socket */
+    const struct link_socket *accept_from; /=
* possibly do accept() on a parent link_socket */
+
+    /* OOB probe-start=
ed handshake: when oob_probe_adopt is true, the
+     * connection adopts o=
ob_probe_sd (the winning remote's already-bound probe
+     * socket) inste=
ad of creating one, and pins oob_probe_remote (the exact
+     * address pr=
obed) as the outgoing address, so the source IP+port and the
+     * destin=
ation match what the server's handshake cookie is bound to=2E */
+    bool =
oob_probe_adopt;
+    socket_descriptor_t oob_probe_sd;
+    struct openvpn=
_sockaddr oob_probe_remote;
 
     struct link_socket_actual *to_link_addr;=
 /* IP address of remote */
     struct link_socket_actual from;          /=
* address of incoming datagram */
diff --git a/src/openvpn/socket=2Ec b/src=
/openvpn/socket=2Ec
index 223b811=2E=2E3d1bc27 100644
--- a/src/openvpn/soc=
ket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -1417,6 +1417,22 @@
         /* inh=
erit (possibly guessed) info AF from parent context */
         sock->info=
=2Eaf =3D c->c2=2Eaccept_from->info=2Eaf;
     }
+    else if (mode =3D=3D =
LS_MODE_UDP_ADOPT)
+    {
+        /* Adopt the OOB probe socket=2E create_=
socket_udp_configured() set it up with this
+         * socket's options an=
d bind, so it only changes hands and keeps the source
+         * IP:port t=
he server's cookie is bound to; phase 2 creates nothing=2E */
+        ASSE=
RT(c->c2=2Eoob_probe_sd !=3D SOCKET_UNDEFINED);
+        sock->sd =3D c->c2=
=2Eoob_probe_sd;
+        c->c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED; /* own=
ership moves to the link socket */
+        sock->info=2Eaf =3D c->c2=2Eoob=
_probe_remote=2Eaddr=2Esa=2Esa_family;
+        sock->sockflags |=3D SF_GET=
ADDRINFO_DGRAM;
+
+        /* Pin the exact address we probed so the connec=
tion targets the address
+         * the cookie was minted for; resolve_rem=
ote() preserves a defined actual=2E */
+        CLEAR(sock->info=2Elsa->act=
ual);
+        sock->info=2Elsa->actual=2Edest =3D c->c2=2Eoob_probe_remote=
;
+    }
 
     /* are we running in HTTP proxy mode? */
     if (sock->htt=
p_proxy)
@@ -1713,7 +1729,7 @@
         goto done;
     }
 #endif
-    if (=
sock->info=2Elsa->current_remote)
+    if (sock->mode !=3D LS_MODE_UDP_ADOP=
T && sock->info=2Elsa->current_remote)
     {
         create_socket(sock, =
sock->info=2Elsa->current_remote);
     }
diff --git a/src/openvpn/socket=
=2Eh b/src/openvpn/socket=2Eh
index 2633ca8=2E=2Ef7cdfa8 100644
--- a/src/o=
penvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -198,6 +198,9 @@
 #define=
 LS_MODE_DEFAULT         0
 #define LS_MODE_TCP_LISTEN      1
 #define LS_M=
ODE_TCP_ACCEPT_FROM 2
+/* Adopt a pre-created, already-bound UDP socket (fr=
om the OOB server probe) as
+ * the connection socket, instead of creating =
one=2E */
+#define LS_MODE_UDP_ADOPT       3
     int mode;
 
     int reso=
lve_retry_seconds;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1769?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: Iec384ee6844ab278b280d6eafec8aaecf9dde755
Gerrit-Change-Number: 1769
Gerr=
it-PatchSet: 14
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>

--5hduNu086eI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #14</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1769?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">socket: =
adopt a pre-created UDP socket for a client connection<br><br>Add LS_MODE_U=
DP_ADOPT: a client link_socket can take ownership of an<br>already-bound UD=
P socket handed off via c2=2Eoob_probe_adopt/oob_probe_sd<br>instead of cre=
ating its own, and pins c2=2Eoob_probe_remote as the outgoing<br>address=2E=
 This lets the OOB server-probe socket become the connection socket,<br>so =
the source IP+port and destination match what the server&#39;s handshake<br=
>cookie is bound to=2E<br><br>  - link_socket_init_phase1: adopt the fd, in=
herit the address family and<br>    pre-set lsa-&gt;actual (resolve_remote =
preserves an already-defined actual)=2E<br>    The probe socket was created=
 and bound by create_socket_udp_configured()<br>    with the link socket&#3=
9;s options, so nothing is applied or bound here<br>  - link_socket_init_ph=
ase2: skip create_socket() so the adopted fd is not<br>    clobbered (overl=
apped-I/O init is fd-independent, so Windows is fine)<br>  - do_init_socket=
_phase1: select the mode for the single client socket<br>  - do_close_link_=
socket: close the handed-off fd if the attempt aborted before<br>    it was=
 adopted, so it is not leaked=2E context_clear_2() sets oob_probe_sd to<br>=
    SOCKET_UNDEFINED, since 0 is a valid descriptor<br><br>The adopt path i=
tself stays unused until the client sets oob_probe_adopt (next<br>commit)=
=2E<br><br>Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755<br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/init=
=2Ec<br>M src/openvpn/openvpn=2Eh<br>M src/openvpn/socket=2Ec<br>M src/open=
vpn/socket=2Eh<br>4 files changed, 48 insertions(+), 2 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/69/1769/14</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvp=
n/init=2Ec</span><br><span>index fabe4b2=2E=2E3f805f3 100644</span><br><spa=
n>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</sp=
an><br><span>@@ -90,6 +90,8 @@</span><br><span> context_clear_2(struct cont=
ext *c)</span><br><span> {</span><br><span>     CLEAR(c-&gt;c2);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* 0 is a valid descriptor=
, so &quot;no socket&quot; has to be set explicitly */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Eoob_probe_sd =3D SOCKET_U=
NDEFINED;</span><br><span> }</span><br><span> </span><br><span> void</span>=
<br><span>@@ -3792,6 +3794,12 @@</span><br><span>                 mode =3D =
LS_MODE_TCP_ACCEPT_FROM;</span><br><span>             }</span><br><span>   =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* a=
dopt the OOB server-probe socket as this client&#39;s connection socket</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         * (probe-start=
ed handshake); only the single client socket is ever adopted */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        else if (c-&gt;c2=2Eoob=
_probe_adopt &amp;&amp; i =3D=3D 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            mode =3D LS_MODE_UDP_ADOPT;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span> </span><br><span>     =
    /* init each socket with its specific args */</span><br><span>         =
link_socket_init_phase1(c, i, mode);</span><br><span>@@ -3957,6 +3965,16 @@=
</span><br><span> static void</span><br><span> do_close_link_socket(struct =
context *c)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* An OOB probe socket handed off for a probe-started handsh=
ake is adopted by the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * link socket in link_socket_init_phase1() (which clears oob_probe_s=
d)=2E If the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
connection attempt aborted before that, the fd is still owned here; close i=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * so it is no=
t leaked when context_clear_2() zeroes c2=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (c-&gt;c2=2Eoob_probe_sd !=3D SOCKET_UND=
EFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        openvpn_close_sock=
et(c-&gt;c2=2Eoob_probe_sd);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        c-&gt;c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>     if (c-&gt;c2=2Elink_sock=
ets &amp;&amp; c-&gt;c2=2Elink_socket_owned)</span><br><span>     {</span><=
br><span>         for (int i =3D 0; i &lt; c-&gt;c1=2Elink_sockets_num; i++=
)</span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvp=
n=2Eh</span><br><span>index e9e18bf=2E=2E436495e 100644</span><br><span>---=
 a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</s=
pan><br><span>@@ -240,7 +240,16 @@</span><br><span> </span><br><span>     b=
ool link_socket_owned;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const struct link_socket *accept_from;   /* possibly=
 do accept() on a parent link_socket */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const struct link_socket *accept_from; /* possibly =
do accept() on a parent link_socket */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* OOB probe-started handshake: when oob_probe_adopt is true, the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * connection adopts =
oob_probe_sd (the winning remote&#39;s already-bound probe</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * socket) instead of creating o=
ne, and pins oob_probe_remote (the exact</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * address probed) as the outgoing address, so the=
 source IP+port and the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * destination match what the server&#39;s handshake cookie is boun=
d to=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool =
oob_probe_adopt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 socket_descriptor_t oob_probe_sd;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct openvpn_sockaddr oob_probe_remote;</span><br><spa=
n> </span><br><span>     struct link_socket_actual *to_link_addr; /* IP add=
ress of remote */</span><br><span>     struct link_socket_actual from;     =
     /* address of incoming datagram */</span><br><span>diff --git a/src/op=
envpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 223b811=2E=
=2E3d1bc27 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><s=
pan>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -1417,6 +1417,22 @@</sp=
an><br><span>         /* inherit (possibly guessed) info AF from parent con=
text */</span><br><span>         sock-&gt;info=2Eaf =3D c-&gt;c2=2Eaccept_f=
rom-&gt;info=2Eaf;</span><br><span>     }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else if (mode =3D=3D LS_MODE_UDP_ADOPT)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* Adopt the OOB probe socket=2E =
create_socket_udp_configured() set it up with this</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * socket&#39;s options and bind, so=
 it only changes hands and keeps the source</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+         * IP:port the server&#39;s cookie is bound=
 to; phase 2 creates nothing=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        ASSERT(c-&gt;c2=2Eoob_probe_sd !=3D SOCKET_UNDEFINED=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;=
sd =3D c-&gt;c2=2Eoob_probe_sd;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        c-&gt;c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED; /* owners=
hip moves to the link socket */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        sock-&gt;info=2Eaf =3D c-&gt;c2=2Eoob_probe_remote=2Ead=
dr=2Esa=2Esa_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        sock-&gt;sockflags |=3D SF_GETADDRINFO_DGRAM;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* Pin the exact address we probed so the connectio=
n targets the address</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * the cookie was minted for; resolve_remote() preserves a define=
d actual=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   CLEAR(sock-&gt;info=2Elsa-&gt;actual);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        sock-&gt;info=2Elsa-&gt;actual=2Edest =3D c-&=
gt;c2=2Eoob_probe_remote;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span> </span><br><span>     /* are we running in HTT=
P proxy mode? */</span><br><span>     if (sock-&gt;http_proxy)</span><br><s=
pan>@@ -1713,7 +1729,7 @@</span><br><span>         goto done;</span><br><sp=
an>     }</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (sock-&gt;info=2Elsa-&gt;current_remote)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (sock-&gt;mode !=3D LS_MODE_=
UDP_ADOPT &amp;&amp; sock-&gt;info=2Elsa-&gt;current_remote)</span><br><spa=
n>     {</span><br><span>         create_socket(sock, sock-&gt;info=2Elsa-&=
gt;current_remote);</span><br><span>     }</span><br><span>diff --git a/src=
/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 2633ca8=
=2E=2Ef7cdfa8 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br=
><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -198,6 +198,9 @@</sp=
an><br><span> #define LS_MODE_DEFAULT         0</span><br><span> #define LS=
_MODE_TCP_LISTEN      1</span><br><span> #define LS_MODE_TCP_ACCEPT_FROM 2<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Adopt a pre-creat=
ed, already-bound UDP socket (from the OOB server probe) as</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * the connection socket, instead o=
f creating one=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define LS_MODE_UDP_ADOPT       3</span><br><span>     int mode;</span><br=
><span> </span><br><span>     int resolve_retry_seconds;</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1769?usp=3Demail">change 1769</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1769?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9=
dde755 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1769 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--5hduNu086eI=--


--===============7251909595289995534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7251909595289995534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7251909595289995534==--

