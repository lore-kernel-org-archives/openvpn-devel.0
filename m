Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0691CC88E54
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g6Zc8UresVhnrEBdxdjYrzdJZ1uv3S6TaL0GjYqUi/g=; b=d6ivQu7ktS9d8Ed20ajEeJ6fGe
	sgHulz2VT2ga7TFI/ekyzFnJ9+gzoREqv3bfXbe5nlsKaK5f5wpAUoxw+CQg4McvBzDiF0BrwgRgH
	1hnAmK/h7BtmrJ+HOLqKU0XVt5sBV8q7RQyxQsRPqdLucWVuvcZXC3hOOiR98XGqwDGI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4xIL-0006U3-W2;
	Fri, 11 Sep 2026 09:11:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4xII-0006Ta-Gv
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Brbhyqmt6bncCzVvSxCbumxLSu1R1yFhdcRVkG3hc8Y=; b=V+YzeynSqSQsP7BbfWHGtx/fJV
 gbFhxtAV5djVffXSe3kRgAdvj5gl/4UUZC4j1AKayfGdF8SUZgrODqnTNvu/3KSBzyo9G1j+ycXLv
 RHxocQRBeVi4pd7nvPDyYzb9uwTJdUXaOrIZdtMBYPsS5BJDZQBZSjgfd0kIlZxsyGVM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Brbhyqmt6bncCzVvSxCbumxLSu1R1yFhdcRVkG3hc8Y=; b=S
 NMQiTJEL5ZhP99ga3gQxwXN0Evh8O7GCpTRCowWZE3BRUeXfBrQyHdS8MG5UlErGyCMYAE0GvYliq
 WPDVGtGV21WybzkjB6lpT58JFiiuXrB/9r3NuX/dKtCCIPUat0PZX8W8EUJEJy8l1KMqXzd/3JdNX
 Gtdu5+/C/4RcseH0=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4xIC-0008Cx-1b for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:38 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso6256615e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 02:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789117885; x=1789722685; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Brbhyqmt6bncCzVvSxCbumxLSu1R1yFhdcRVkG3hc8Y=;
 b=e5dELSNrziinEQLq8qwc/LfnuBWpXdQpgXsGgvEnk7Jd2iKbnCnzjqC8DlaaeceoE+
 kfmfJo9ZKrSBigkzCzMo452+LMoUPRWdzEXyJw3VOiG4Yvs/irHvR+RfW6ZC2a5BHU+b
 ElZr8zJMuEz3n0WJc2q0UQy5K//FNcL7x+L3ZsESGUuFR3Rduj3yycsgQneYfLfoZIGq
 wbbh33TmbS2jsiQxO+501v6qekvKW+WnMIOZr7Do48zZpieamXqr9jAU662S/pxgWRr/
 q0DeCeebFQCp1Ux3WOM71nxDQfjGo5la97WVlbvJhXRIbMH8PCEoa0wywCdG9qdDeaN0
 i8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117885; x=1789722685;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Brbhyqmt6bncCzVvSxCbumxLSu1R1yFhdcRVkG3hc8Y=;
 b=c4KMh+/J4kHFWN9VS6eCVXMYk6WxZuskOOyXdRHeV65Qp2hV1pmb1XeYsYzRcax0fR
 Lib/QNavfWKkdc8g+lNUY8JrWCw3EY5GvqbrwL9/OO3i6QsN9/WCsuTTaAM4etV8Vlbf
 MlF0Kl3vX0nBnxbYnBvXCPQtb1Z2FfgfMAqLR8TepIpysmptvnjy1gTWryzZIL5CD5eE
 8KNeT9D3jkItReqSRhHaahGA3ZhEgkpfRNZoEm7cJ+dxqb/gIhu/2/fNUCd3XMcVSBsk
 vxRais4S1GWqgdfzm+1glTj3/e4s+j/UXzy2YC1uSigWpPCj1OCO47ENS9EpTfKDJL1p
 WeIA==
X-Gm-Message-State: AFuF++kWnc1r8V+EvH+Kq0oTjgeX4yy63SxX/m9uG4DGEz0KTspAW0Qd
 YH9WicrE6m0VdKIX8bXVbQYjrur+UlWALJEl/vvoqAF/VX1xiwXUmkJzPJvkm5hJP86XNlEyv3K
 w1ddcV2fnS6MtqKXOsKpSe9+MheeuBntkFGS9KCOEghKljGXc2KlTQoU0qZPA86LnFmn8tqM++Q
 ThRCz5sg==
X-Gm-Gg: AYBFou0s/jvKjpm/bpF667876GEtFhw5Bmmco9y9mJYp5Y3vKWr2Vnk0GdTI4ggtxew
 GR/57tGluxKcFcDk2HUUvK70ZRMc7OGxx5iP0u2vAwe+REmo4aQPhXPdYagyytSTJtwCl/pTVrn
 RwPSAmEC7DWeYFaw/aSj/7BYDdWIt27vD7FJIfjQSq10nm/k3sdleal5s70XVYi37zmoADcLfwF
 zkX2vSiVIVEgDjNJuCkCelpwUbMtrZ0sg7Ohk0BCNVJ2Fp1GhsZCoyZZBseFUPneZgekEVkhtBS
 uNMtaJceWsHV/wgY6frjYxz53x9Uuk0zKmvBEK73W668+4oajue2XBfKcz0MBYvqCE/AfdPkcVE
 YAp0a1ANlGZut1hfQRKXV9BxqKrv90IJSZdfqhvgEuaatM7CBy09ehgInFqk9uWf8bRIu892hLl
 M+PNSOjcMsTsXfeHgagxGtCmu4s2036yiw/l/cYcRsfJe2/kvxqs4IdUICxg0TbW3svnAu1WEAm
 qblBQwlfQ6TwdNhSXmzRIYV2loqyvbn5wxXruVLcOFnvACkx7m4yKq2ot8QAg0yA4MU5ZoBiJht
 sexipztqRoslz9WpA9zacvZCkVUm6Ad+oZc6fIIXpCoMwqCbwBcav8nO6ZIbtQ==
X-Received: by 2002:a05:600c:3515:b0:49d:16dc:e721 with SMTP id
 5b1f17b1804b1-49e61a74140mr33351165e9.24.1789117885285; 
 Fri, 11 Sep 2026 02:11:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm30141855e9.4.2026.09.11.02.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:11:24 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 09:11:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
X-Gerrit-Change-Number: 1770
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1770?usp=email>
X-Gerrit-Commit: 46303ec4c076da3e8a2e9f7ca03125e932e769ff
In-Reply-To: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
References: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkk0NTRkNTA0MGNiYWQ0ZDM3M2VlNGY5MGI4ZDY4MzIwMGQyYTRjMGU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a99b4423e8b46e463ad982ae690452cafe6bd058-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4xIC-0008Cx-1b
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: start the
 client handshake from the server probe
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
Content-Type: multipart/mixed; boundary="===============9157746402693473999=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9157746402693473999==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Oxd+AnsvdYg="; charset=UTF-8

--Oxd+AnsvdYg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1770?usp=3Demail

to look at the new patch set (#15)=2E
=


Change subject: oob: start the client handshake from the server probe
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: start the c=
lient handshake from the server probe

When the best remote answered a prob=
e and advertised a connect_lifetime,
its reply also served as the server's =
HARD_RESET: its session id is a
valid stateless SYN-cookie=2E The client th=
erefore starts the handshake
from that reply instead of running its own res=
et exchange=2E

Note this does not shorten the handshake itself -- the prob=
e and its
reply take the place of the two reset packets rather than removin=
g them=2E
The saving is one RTT compared with probing and then connecting; =
a
client that does not probe is unaffected=2E

  - oob_client=2Ec: when the=
 winner advertised a connect_lifetime, hand
    its probe socket, the captu=
red server session id (cookie), our probe
    session id, the pinned respon=
der address, and the resend-wkc flag to
    the connection via c2; relinqui=
sh that socket (do not close it);
    gate off for dco-win, which has no us=
er-to-kernel socket handoff
    (probing still works, only starting from th=
e reply is skipped)=2E
  - ssl=2Ec session_skip_to_pre_start_client(): seed=
 our session id to the
    probe's (the cookie is an HMAC over it), the rem=
ote session id to
    the cookie, ack the phantom server reset (id 0) so th=
e third packet
    carries the cookie, set CO_RESEND_WKC for tls-crypt-v2, =
and drop to
    S_PRE_START so tls_process() promotes to S_START and sends =
the
    ClientHello (no HARD_RESET sent)=2E
  - init=2Ec: invoke the client=
 skip after tls_multi_init_finalize when
    adopting, and count the probe =
reply as the initial packet received
    (n_sessions++, as the server does =
before its own
    session_skip_to_pre_start) so check_server_poll_timeout(=
) does not
    restart the connected session=2E

Change-Id: I454d5040cbad4d=
373ee4f90b8d683200d2a4c0e4
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
=
---
M Changes=2Erst
M src/openvpn/init=2Ec
M src/openvpn/oob=2Eh
M src/open=
vpn/oob_client=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/ssl=2Ec
M src/op=
envpn/ssl=2Eh
7 files changed, 172 insertions(+), 10 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1770/15

dif=
f --git a/Changes=2Erst b/Changes=2Erst
index 080d928=2E=2E4d7a16c9 100644
=
--- a/Changes=2Erst
+++ b/Changes=2Erst
@@ -9,6 +9,13 @@
     measured late=
ncy and advertised weight with DNS-SRV-like semantics=2E
     Servers adver=
tise these values with ``--server-probe-reply``=2E
 
+Probe exchange double=
s as the start of the handshake
+    When a probing client picks a server t=
hat advertises support for it,
+    the probe and its reply take the place =
of the client's and server's
+    reset packets, so the client does not nee=
d a separate reset exchange
+    before the handshake=2E This saves one rou=
nd trip compared with probing
+    and then connecting, and needs no extra =
configuration=2E
+
 
 Overview of changes in 2=2E7
 =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/src/=
openvpn/init=2Ec b/src/openvpn/init=2Ec
index ea85bad=2E=2E81562a7 100644
-=
-- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3483,6 +3483,21 @@=

         /* Keep the max mtu also in the frame of tls multi so it can acce=
ss
          * it in push_peer_info */
         c->c2=2Etls_multi->opt=2Efr=
ame=2Etun_max_mtu =3D c->c2=2Eframe=2Etun_max_mtu;
+
+        /* OOB server=
 probe: the probe reply already served as the server's
+         * HARD_RES=
ET (it carried a valid SYN-cookie), so the handshake starts
+         * fro=
m that reply and we send no reset of our own=2E Count
+         * the reply=
 as the initial packet received (as the server does before its
+         * =
own session_skip_to_pre_start), so tls_initial_packet_received() is true
+ =
        * and check_server_poll_timeout() does not restart a connected sess=
ion=2E */
+        if (c->c2=2Eoob_probe_adopt)
+        {
+            c->=
c2=2Etls_multi->n_sessions++;
+            session_skip_to_pre_start_client=
(&c->c2=2Etls_multi->session[TM_ACTIVE],
+                                 =
            &c->c2=2Eoob_probe_client_sid,
+                               =
              &c->c2=2Eoob_probe_server_sid, &c->c2=2Eoob_probe_remote,
+  =
                                           c->c2=2Eoob_probe_resend_wkc);
+=
        }
     }
     if (c->c2=2Etls_auth_standalone)
     {
diff --git a/=
src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 9fde094=2E=2E5568177 100644=

--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -192,8 +192,11 @@
 =
{
     int index;
     bool responded;
-    unsigned int rtt_ms;          /=
* probe round-trip time in ms (responders only) */
-    struct oob_probe_re=
ply reply; /* the values the server advertised */
+    unsigned int rtt_ms;=
 /* probe round-trip time in ms (responders only) */
+    /* Captured from =
the packet and its reply TLV (responders only): */
+    struct session_id s=
erver_sid;      /* the packet's own session id =3D server SYN-cookie */
+  =
  struct openvpn_sockaddr responder; /* address that answered (pin the conn=
ection to it) */
+    struct oob_probe_reply reply;      /* the values the =
server advertised */
 };
 
 /* Where the client probed one connection entry=
: its resolved addresses=2E */
diff --git a/src/openvpn/oob_client=2Ec b/sr=
c/openvpn/oob_client=2Ec
index 5ae8462=2E=2Ed413f6d 100644
--- a/src/openvp=
n/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -38,6 +38,7 @@
 #inclu=
de "otime=2Eh"
 #include "fdmisc=2Eh"
 #include "crypto=2Eh"
+#include "dco=
=2Eh"
 #include "error=2Eh"
 
 #include "memdbg=2Eh"
@@ -320,6 +321,13 @@
 =
        return;
     }
 
+    /* The reply's own session id (the server's s=
tateless SYN-cookie) follows the
+     * opcode byte=2E Capture it before r=
ead_control_auth() strips it: a client may
+     * reuse it to start the ha=
ndshake from this reply (the connect_lifetime
+     * advertisement)=2E */
=
+    struct session_id server_sid;
+    memcpy(server_sid=2Eid, data + 1, S=
ID_SIZE);
+
     struct buffer buf;
     buf_set_read(&buf, data, (size_t)l=
en);
 
@@ -363,6 +371,8 @@
 
         results[i]=2Eresponded =3D true;
    =
     results[i]=2Ertt_ms =3D (ms > 0) ? (unsigned int)ms : 0;
+        resu=
lts[i]=2Eserver_sid =3D server_sid;
+        results[i]=2Eresponder =3D *fr=
om; /* pin the connection to the address that answered */
         results[=
i]=2Ereply =3D reply;
 
         i =3D oob_probe_next_target_at(from, targe=
ts, results, n, i + 1);
@@ -715,11 +725,6 @@
     {
         oob_probe_coll=
ect(&pc, &probe, &client_sid, &tas->tls_wrap, targets, results, l->len);
  =
   }
-    oob_probe_sockets_close(&pc);
-    if (bind_local)
-    {
-      =
  freeaddrinfo(bind_local);
-    }
 
     /* Log each remote's outcome whil=
e results[i] still maps to array[i]=2E */
     int responded =3D 0;
@@ -735=
,10 +740,10 @@
             int margin =3D oob_effective_margin(&results[i]=
, client_margin);
             const char *margin_src =3D client_margin >=
=3D 0 ? "client" : "server-advertised";
             msg(D_LOW,
-          =
      "server-probe: %s:%s answered (priority %d, weight %d, rtt %u ms;"
- =
               " latency margin %d ms [%s])",
+                "server-prob=
e: %s:%s answered (priority %d, weight %d, connect-lifetime %d s,"
+       =
         " rtt %u ms; latency margin %d ms [%s])",
                 ce->rem=
ote, ce->remote_port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Ew=
eight,
-                results[i]=2Ertt_ms, margin, margin_src);
+        =
        results[i]=2Ereply=2Econnect_lifetime, results[i]=2Ertt_ms, margin,=
 margin_src);
         }
         else
         {
@@ -760,6 +765,65 @@
    =
 msg(M_INFO, "server-probe: %d of %d remote(s) answered; connecting best-fi=
rst", responded,
         l->len);
 
+    /* If the winner advertised a con=
nect_lifetime, its reply also served as the
+     * server's reset: hand it=
s probe socket and the captured cookie to the
+     * connection, which the=
n starts the handshake from that reply (see
+     * session_skip_to_pre_sta=
rt_client)=2E Reusing that socket keeps the source
+     * IP+port the cook=
ie is bound to=2E dco-win cannot hand a socket to the
+     * kernel, so it=
 only gets the probe ordering=2E */
+
+    /* Single-use, so the RFC's conn=
ect_lifetime expiry check is not needed yet:
+     * we probe once (c->firs=
t_time) and arm only results[0]=2E */
+    bool probe_start =3D results[0]=
=2Eresponded && results[0]=2Ereply=2Econnect_lifetime > 0;
+    bool dco_wi=
n_gate =3D false;
+#if defined(_WIN32)
+    if (dco_enabled(&c->options))
+=
    {
+        probe_start =3D false;
+        dco_win_gate =3D true;
+    =
}
+#endif
+    if (probe_start)
+    {
+        const int af_idx =3D probe_=
af_index(results[0]=2Eresponder=2Eaddr=2Esa=2Esa_family);
+        c->c2=2E=
oob_probe_sd =3D pc=2Esd[af_idx];
+        pc=2Esd[af_idx] =3D SOCKET_UNDEF=
INED; /* relinquish: the connection owns it now */
+
+        c->c2=2Eoob_p=
robe_remote =3D results[0]=2Eresponder;
+        c->c2=2Eoob_probe_client_s=
id =3D client_sid;
+        c->c2=2Eoob_probe_server_sid =3D results[0]=2Es=
erver_sid;
+        c->c2=2Eoob_probe_resend_wkc =3D
+            (results[=
0]=2Ereply=2Eflags & OOB_PROBE_REPLY_FLAG_RESEND_WKC) !=3D 0;
+        c->c=
2=2Eoob_probe_adopt =3D true;
+
+        msg(D_LOW, "server-probe: starting=
 handshake from probe reply of %s:%s"
+                   " (connect-lifeti=
me %d s)",
+            l->array[0]->remote, l->array[0]->remote_port, resu=
lts[0]=2Ereply=2Econnect_lifetime);
+    }
+    else if (results[0]=2Erespo=
nded)
+    {
+        /* A server answered but we won't start the handshake=
 from it -- say why=2E */
+        if (dco_win_gate)
+        {
+          =
  msg(D_LOW, "server-probe: cannot start the handshake from a probe reply"
=
+                       " with dco-win;"
+                       " using a =
full handshake");
+        }
+        else if (results[0]=2Ereply=2Econnect=
_lifetime =3D=3D 0)
+        {
+            msg(D_LOW, "server-probe: %s:%s=
 did not advertise a connect-lifetime"
+                       " (connect-l=
ifetime 0); using a full handshake",
+                l->array[0]->remote, =
l->array[0]->remote_port);
+        }
+    }
+
+    /* Close any probe sock=
ets we did not hand off to the connection=2E */
+    oob_probe_sockets_clos=
e(&pc);
+
+    if (bind_local)
+    {
+        freeaddrinfo(bind_local);
+ =
   }
     tls_auth_standalone_free(tas);
     gc_free(&gc);
 }
diff --git a=
/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index 09c6a3c=2E=2E238eb=
a2 100644
--- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -2=
50,6 +250,9 @@
     bool oob_probe_adopt;
     socket_descriptor_t oob_prob=
e_sd;
     struct openvpn_sockaddr oob_probe_remote;
+    struct session_id=
 oob_probe_client_sid;  /* our probe session id (cookie was minted over it)=
 */
+    struct session_id oob_probe_server_sid;  /* the reply's session id=
 =3D server cookie to echo back */
+    bool oob_probe_resend_wkc;         =
      /* reply asked to complete with CONTROL_WKC_V1 (v2) */
 
     struct =
link_socket_actual *to_link_addr; /* IP address of remote */
     struct li=
nk_socket_actual from;          /* address of incoming datagram */
diff --g=
it a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index c8fc465=2E=2Eccd5fda 1=
00644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2569,6 +2569,=
59 @@
     return session_move_pre_start(session, ks, true);
 }
 
+bool
+se=
ssion_skip_to_pre_start_client(struct tls_session *session, const struct se=
ssion_id *client_sid,
+                                 const struct sessio=
n_id *server_sid,
+                                 const struct openvpn_so=
ckaddr *remote, bool resend_wkc)
+{
+    struct key_state *ks =3D &session-=
>key[KS_PRIMARY];
+
+    /* Our session id must be the one used for the pro=
be: the server's cookie
+     * (server_sid) is an HMAC over it, and the se=
rver re-derives and checks it
+     * when it validates our third packet=2E=
 */
+    session->session_id =3D *client_sid;
+    ks->session_id_remote =
=3D *server_sid;
+
+    struct link_socket_actual act =3D { 0 };
+    act=
=2Edest =3D *remote;
+    ks->remote_addr =3D act;
+    session->untrusted_=
addr =3D act;
+    session->burst =3D true;
+
+    /* tls-crypt-v2: the sta=
teless server discarded the WKc after the probe, so
+     * complete the ha=
ndshake with P_CONTROL_WKC_V1 (drives control_packet_needs_wkc)=2E */
+    =
if (resend_wkc)
+    {
+        ks->crypto_options=2Eflags |=3D CO_RESEND_W=
KC;
+    }
+
+    /* We never received the server's HARD_RESET (id 0) -- th=
e probe reply stood
+     * in for it=2E Acknowledge that phantom id 0 so o=
ur third packet carries an
+     * ACK together with the server session id =
(the cookie): reliable_ack_write()
+     * only emits that session id when =
at least one ACK is present, and the server
+     * needs it to validate th=
e stateless cookie=2E */
+    reliable_ack_acknowledge_packet_id(ks->rec_ac=
k, 0);
+
+    /* Skip one (RESET) packet in each direction, so ids start at=
 1 (see
+     * session_skip_to_pre_start)=2E */
+    ks->rec_reliable->pac=
ket_id =3D 1;
+    session->tls_wrap=2Eopt=2Epacket_id=2Esend=2Eid =3D 1;
+=

+    /* Do not send our own HARD_RESET=2E Unlike the server's skip, the cl=
ient must
+     * send first: the stateless server only replies once it see=
s our third
+     * packet=2E session_move_pre_start(skip=3Dtrue) leaves us=
 in S_PRE_START_SKIP,
+     * which only advances when a packet is *receive=
d*; instead drop to
+     * S_PRE_START with an empty send-reliable (the in=
itial packet was generated
+     * and immediately deleted), so tls_process=
() promotes us to S_START and
+     * sends the ClientHello without waiting=
 for a server reset=2E */
+    if (!session_move_pre_start(session, ks, tru=
e))
+    {
+        return false;
+    }
+    ks->state =3D S_PRE_START;
+ =
   return true;
+}
+
 /**
  * Parses the TLVs (type, length, value) in the =
early negotiation
  */
diff --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=
=2Eh
index 7ddf965=2E=2Ea534007 100644
--- a/src/openvpn/ssl=2Eh
+++ b/src/=
openvpn/ssl=2Eh
@@ -576,4 +576,21 @@
 bool session_skip_to_pre_start(struct=
 tls_session *session, struct tls_pre_decrypt_state *state,
               =
                 struct link_socket_actual *from);
 
+/**
+ * Client counte=
rpart of session_skip_to_pre_start(): start the handshake from a
+ * server=
 session id (SYN-cookie) learned earlier from an OOB server probe
+ * reply=
, which already served as the server's HARD_RESET, so we send none=2E
+ *
+=
 * @param session     the (client) TLS session to fast-forward
+ * @param c=
lient_sid  session id used for the probe (the cookie is an HMAC over it)
+ =
* @param server_sid  the server's cookie, echoed back to complete the hands=
hake
+ * @param remote      the probed (pinned) server address to connect t=
o
+ * @param resend_wkc  true to complete with P_CONTROL_WKC_V1 (tls-crypt-=
v2)
+ * @return true if the session was fast-forwarded, false on failure
+ =
*/
+bool session_skip_to_pre_start_client(struct tls_session *session,
+   =
                                   const struct session_id *client_sid,
+  =
                                    const struct session_id *server_sid,
+ =
                                     const struct openvpn_sockaddr *remote,=
 bool resend_wkc);
+
 #endif /* ifndef OPENVPN_SSL_H */

-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a=
4c0e4
Gerrit-Change-Number: 1770
Gerrit-PatchSet: 15
Gerrit-Owner: stipa <l=
stipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--Oxd+AnsvdYg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #15</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1770?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: sta=
rt the client handshake from the server probe<br><br>When the best remote a=
nswered a probe and advertised a connect_lifetime,<br>its reply also served=
 as the server&#39;s HARD_RESET: its session id is a<br>valid stateless SYN=
-cookie=2E The client therefore starts the handshake<br>from that reply ins=
tead of running its own reset exchange=2E<br><br>Note this does not shorten=
 the handshake itself -- the probe and its<br>reply take the place of the t=
wo reset packets rather than removing them=2E<br>The saving is one RTT comp=
ared with probing and then connecting; a<br>client that does not probe is u=
naffected=2E<br><br>  - oob_client=2Ec: when the winner advertised a connec=
t_lifetime, hand<br>    its probe socket, the captured server session id (c=
ookie), our probe<br>    session id, the pinned responder address, and the =
resend-wkc flag to<br>    the connection via c2; relinquish that socket (do=
 not close it);<br>    gate off for dco-win, which has no user-to-kernel so=
cket handoff<br>    (probing still works, only starting from the reply is s=
kipped)=2E<br>  - ssl=2Ec session_skip_to_pre_start_client(): seed our sess=
ion id to the<br>    probe&#39;s (the cookie is an HMAC over it), the remot=
e session id to<br>    the cookie, ack the phantom server reset (id 0) so t=
he third packet<br>    carries the cookie, set CO_RESEND_WKC for tls-crypt-=
v2, and drop to<br>    S_PRE_START so tls_process() promotes to S_START and=
 sends the<br>    ClientHello (no HARD_RESET sent)=2E<br>  - init=2Ec: invo=
ke the client skip after tls_multi_init_finalize when<br>    adopting, and =
count the probe reply as the initial packet received<br>    (n_sessions++, =
as the server does before its own<br>    session_skip_to_pre_start) so chec=
k_server_poll_timeout() does not<br>    restart the connected session=2E<br=
><br>Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4<br>Signed-off-by:=
 Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M Changes=2Erst<br>M src/=
openvpn/init=2Ec<br>M src/openvpn/oob=2Eh<br>M src/openvpn/oob_client=2Ec<b=
r>M src/openvpn/openvpn=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl=
=2Eh<br>7 files changed, 172 insertions(+), 10 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/70/1770/15</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/Changes=2Erst b/Changes=2Erst</span><br><=
span>index 080d928=2E=2E4d7a16c9 100644</span><br><span>--- a/Changes=2Erst=
</span><br><span>+++ b/Changes=2Erst</span><br><span>@@ -9,6 +9,13 @@</span=
><br><span>     measured latency and advertised weight with DNS-SRV-like se=
mantics=2E</span><br><span>     Servers advertise these values with ``--ser=
ver-probe-reply``=2E</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+Probe exchange doubles as the start of the handshake</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    When a probing clie=
nt picks a server that advertises support for it,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    the probe and its reply take the place of=
 the client&#39;s and server&#39;s</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    reset packets, so the client does not need a separate re=
set exchange</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bef=
ore the handshake=2E This saves one round trip compared with probing</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    and then connecting, a=
nd needs no extra configuration=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> </span><br><span> Overview of changes in 2=
=2E7</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span>diff --git a/src/openvpn/init=
=2Ec b/src/openvpn/init=2Ec</span><br><span>index ea85bad=2E=2E81562a7 1006=
44</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/ope=
nvpn/init=2Ec</span><br><span>@@ -3483,6 +3483,21 @@</span><br><span>      =
   /* Keep the max mtu also in the frame of tls multi so it can access</spa=
n><br><span>          * it in push_peer_info */</span><br><span>         c-=
&gt;c2=2Etls_multi-&gt;opt=2Eframe=2Etun_max_mtu =3D c-&gt;c2=2Eframe=2Etun=
_max_mtu;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        /* OOB server probe: =
the probe reply already served as the server&#39;s</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * HARD_RESET (it carried a valid SY=
N-cookie), so the handshake starts</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         * from that reply and we send no reset of our own=
=2E Count</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *=
 the reply as the initial packet received (as the server does before its</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * own session=
_skip_to_pre_start), so tls_initial_packet_received() is true</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+         * and check_server_poll_=
timeout() does not restart a connected session=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c2=2Eoob_probe_adopt)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2Etls_mult=
i-&gt;n_sessions++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            session_skip_to_pre_start_client(&amp;c-&gt;c2=2Etls_multi-&gt;=
session[TM_ACTIVE],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                             &amp;c-&gt;c2=2Eoob_probe_clie=
nt_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                                 &amp;c-&gt;c2=2Eoob_probe_server_sid, &amp=
;c-&gt;c2=2Eoob_probe_remote,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                             c-&gt;c2=2Eoob_probe=
_resend_wkc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span>     }</span><br><span>     if (c-&gt;c2=2Etls_auth_sta=
ndalone)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/oo=
b=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 9fde094=2E=2E5568177 1006=
44</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/open=
vpn/oob=2Eh</span><br><span>@@ -192,8 +192,11 @@</span><br><span> {</span><=
br><span>     int index;</span><br><span>     bool responded;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    unsigned int rtt_ms;          /=
* probe round-trip time in ms (responders only) */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct oob_probe_reply reply; /* the value=
s the server advertised */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    unsigned int rtt_ms; /* probe round-trip time in ms (responders =
only) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Capt=
ured from the packet and its reply TLV (responders only): */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct session_id server_sid; =
     /* the packet&#39;s own session id =3D server SYN-cookie */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr re=
sponder; /* address that answered (pin the connection to it) */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply repl=
y;      /* the values the server advertised */</span><br><span> };</span><b=
r><span> </span><br><span> /* Where the client probed one connection entry:=
 its resolved addresses=2E */</span><br><span>diff --git a/src/openvpn/oob_=
client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index 5ae8462=2E=2E=
d413f6d 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><=
span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -38,6 +38,7 @@</sp=
an><br><span> #include &quot;otime=2Eh&quot;</span><br><span> #include &quo=
t;fdmisc=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;dco=2Eh&quot=
;</span><br><span> #include &quot;error=2Eh&quot;</span><br><span> </span><=
br><span> #include &quot;memdbg=2Eh&quot;</span><br><span>@@ -320,6 +321,13=
 @@</span><br><span>         return;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The reply&=
#39;s own session id (the server&#39;s stateless SYN-cookie) follows the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * opcode byte=2E =
Capture it before read_control_auth() strips it: a client may</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * reuse it to start the hand=
shake from this reply (the connect_lifetime</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * advertisement)=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct session_id server_sid;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(server_sid=2Eid,=
 data + 1, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>     struct buffer buf;</span><br><span>     buf_set_rea=
d(&amp;buf, data, (size_t)len);</span><br><span> </span><br><span>@@ -363,6=
 +371,8 @@</span><br><span> </span><br><span>         results[i]=2Eresponde=
d =3D true;</span><br><span>         results[i]=2Ertt_ms =3D (ms &gt; 0) ? =
(unsigned int)ms : 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        results[i]=2Eserver_sid =3D server_sid;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        results[i]=2Eresponder =3D *from; /* =
pin the connection to the address that answered */</span><br><span>        =
 results[i]=2Ereply =3D reply;</span><br><span> </span><br><span>         i=
 =3D oob_probe_next_target_at(from, targets, results, n, i + 1);</span><br>=
<span>@@ -715,11 +725,6 @@</span><br><span>     {</span><br><span>         =
oob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid, &amp;tas-&gt;tls_wr=
ap, targets, results, l-&gt;len);</span><br><span>     }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    oob_probe_sockets_close(&amp;pc);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (bind_local)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        freeaddrinfo(bind_local);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> </span>=
<br><span>     /* Log each remote&#39;s outcome while results[i] still maps=
 to array[i]=2E */</span><br><span>     int responded =3D 0;</span><br><spa=
n>@@ -735,10 +740,10 @@</span><br><span>             int margin =3D oob_eff=
ective_margin(&amp;results[i], client_margin);</span><br><span>            =
 const char *margin_src =3D client_margin &gt;=3D 0 ? &quot;client&quot; : =
&quot;server-advertised&quot;;</span><br><span>             msg(D_LOW,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;serv=
er-probe: %s:%s answered (priority %d, weight %d, rtt %u ms;&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                &quot; latency=
 margin %d ms [%s])&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                &quot;server-probe: %s:%s answered (priority %d, wei=
ght %d, connect-lifetime %d s,&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                &quot; rtt %u ms; latency margin %d ms [%s=
])&quot;,</span><br><span>                 ce-&gt;remote, ce-&gt;remote_por=
t, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                results[i]=2Ertt_m=
s, margin, margin_src);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                results[i]=2Ereply=2Econnect_lifetime, results[i]=2Ertt=
_ms, margin, margin_src);</span><br><span>         }</span><br><span>      =
   else</span><br><span>         {</span><br><span>@@ -760,6 +765,65 @@</sp=
an><br><span>     msg(M_INFO, &quot;server-probe: %d of %d remote(s) answer=
ed; connecting best-first&quot;, responded,</span><br><span>         l-&gt;=
len);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* If the winner advertised a connect_lifetime, its reply also serv=
ed as the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ser=
ver&#39;s reset: hand its probe socket and the captured cookie to the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * connection, which =
then starts the handshake from that reply (see</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * session_skip_to_pre_start_client)=2E Reus=
ing that socket keeps the source</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * IP+port the cookie is bound to=2E dco-win cannot hand a=
 socket to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* kernel, so it only gets the probe ordering=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* Single-use, so the RFC&#39;s connect_lifetime expiry che=
ck is not needed yet:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * we probe once (c-&gt;first_time) and arm only results[0]=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool probe_start =
=3D results[0]=2Eresponded &amp;&amp; results[0]=2Ereply=2Econnect_lifetime=
 &gt; 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool dc=
o_win_gate =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (dco_enabled(&amp;c-&gt;options))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        probe_start =3D false;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        dco_win_gate =3D true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (probe_start)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst int af_idx =3D probe_af_index(results[0]=2Eresponder=2Eaddr=2Esa=2Esa_=
family);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&=
gt;c2=2Eoob_probe_sd =3D pc=2Esd[af_idx];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        pc=2Esd[af_idx] =3D SOCKET_UNDEFINED; /* reli=
nquish: the connection owns it now */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       c-&gt;c2=2Eoob_probe_remote =3D results[0]=2Eresponder;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_cli=
ent_sid =3D client_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        c-&gt;c2=2Eoob_probe_server_sid =3D results[0]=2Eserver_sid;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob=
_probe_resend_wkc =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            (results[0]=2Ereply=2Eflags &amp; OOB_PROBE_REPLY_FLAG_RESEND=
_WKC) !=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  c-&gt;c2=2Eoob_probe_adopt =3D true;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(D_LOW, &quot;server-probe: starting handshake from probe reply =
of %s:%s&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
              &quot; (connect-lifetime %d s)&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            l-&gt;array[0]-&gt;remote, l-=
&gt;array[0]-&gt;remote_port, results[0]=2Ereply=2Econnect_lifetime);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else if (results[0]=2Eresponded)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* A server answered but we =
won&#39;t start the handshake from it -- say why=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (dco_win_gate)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe: c=
annot start the handshake from a probe reply&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                       &quot; with dco-win;&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
         &quot; using a full handshake&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        else if (results[0]=2Ereply=2Econnect_lifetime =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, =
&quot;server-probe: %s:%s did not advertise a connect-lifetime&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                       &qu=
ot; (connect-lifetime 0); using a full handshake&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                l-&gt;array[0]-&gt;remo=
te, l-&gt;array[0]-&gt;remote_port);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Close any probe soc=
kets we did not hand off to the connection=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    oob_probe_sockets_close(&amp;pc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (bind_local)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        freeaddrinfo(bind_local);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span>     tls_auth_standalone_=
free(tas);</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span>=
<br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</s=
pan><br><span>index 09c6a3c=2E=2E238eba2 100644</span><br><span>--- a/src/o=
penvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</span><br>=
<span>@@ -250,6 +250,9 @@</span><br><span>     bool oob_probe_adopt;</span>=
<br><span>     socket_descriptor_t oob_probe_sd;</span><br><span>     struc=
t openvpn_sockaddr oob_probe_remote;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct session_id oob_probe_client_sid;  /* our probe =
session id (cookie was minted over it) */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct session_id oob_probe_server_sid;  /* the r=
eply&#39;s session id =3D server cookie to echo back */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    bool oob_probe_resend_wkc;         =
      /* reply asked to complete with CONTROL_WKC_V1 (v2) */</span><br><spa=
n> </span><br><span>     struct link_socket_actual *to_link_addr; /* IP add=
ress of remote */</span><br><span>     struct link_socket_actual from;     =
     /* address of incoming datagram */</span><br><span>diff --git a/src/op=
envpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index c8fc465=2E=2Eccd5=
fda 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/=
src/openvpn/ssl=2Ec</span><br><span>@@ -2569,6 +2569,59 @@</span><br><span>=
     return session_move_pre_start(session, ks, true);</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+session_skip_to_pr=
e_start_client(struct tls_session *session, const struct session_id *client=
_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                   const struct session_id *server_sid,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                 const =
struct openvpn_sockaddr *remote, bool resend_wkc)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Our session id must be the one u=
sed for the probe: the server&#39;s cookie</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * (server_sid) is an HMAC over it, and the serv=
er re-derives and checks it</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * when it validates our third packet=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    session-&gt;session_id =3D *client_=
sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;sess=
ion_id_remote =3D *server_sid;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct link_socket_actual act =3D { 0 };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    act=2Edest =3D *remote;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ks-&gt;remote_addr =3D act;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    session-&gt;untrusted_addr =3D act=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;bu=
rst =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* tls-crypt-v2: the =
stateless server discarded the WKc after the probe, so</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * complete the handshake with P_CON=
TROL_WKC_V1 (drives control_packet_needs_wkc)=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (resend_wkc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        ks-&gt;crypto_options=2Eflags |=3D CO_RESEND_WK=
C;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* We never received the server&#39;s HARD_RES=
ET (id 0) -- the probe reply stood</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * in for it=2E Acknowledge that phantom id 0 so our thi=
rd packet carries an</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * ACK together with the server session id (the cookie): reliable_ack_=
write()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * only =
emits that session id when at least one ACK is present, and the server</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * needs it to valid=
ate the stateless cookie=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    reliable_ack_acknowledge_packet_id(ks-&gt;rec_ack, 0);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* Skip one (RESET) packet in each direc=
tion, so ids start at 1 (see</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * session_skip_to_pre_start)=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ks-&gt;rec_reliable-&gt;packet_id =3D 1;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;tls_w=
rap=2Eopt=2Epacket_id=2Esend=2Eid =3D 1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Do not send our own HARD_RESET=2E Unlike the server&#39;s skip, th=
e client must</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 send first: the stateless server only replies once it sees our third</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * packet=2E session_=
move_pre_start(skip=3Dtrue) leaves us in S_PRE_START_SKIP,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * which only advances when a pa=
cket is *received*; instead drop to</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * S_PRE_START with an empty send-reliable (the initial=
 packet was generated</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * and immediately deleted), so tls_process() promotes us to S_START =
and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * sends the=
 ClientHello without waiting for a server reset=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!session_move_pre_start(session, =
ks, true))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;state =3D S_PRE_START;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *=
 Parses the TLVs (type, length, value) in the early negotiation</span><br><=
span>  */</span><br><span>diff --git a/src/openvpn/ssl=2Eh b/src/openvpn/ss=
l=2Eh</span><br><span>index 7ddf965=2E=2Ea534007 100644</span><br><span>---=
 a/src/openvpn/ssl=2Eh</span><br><span>+++ b/src/openvpn/ssl=2Eh</span><br>=
<span>@@ -576,4 +576,21 @@</span><br><span> bool session_skip_to_pre_start(=
struct tls_session *session, struct tls_pre_decrypt_state *state,</span><br=
><span>                                struct link_socket_actual *from);</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Client counterpar=
t of session_skip_to_pre_start(): start the handshake from a</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * server session id (SYN-cookie) =
learned earlier from an OOB server probe</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * reply, which already served as the server&#39;s HAR=
D_RESET, so we send none=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 session     the (client) TLS session to fast-forward</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param client_sid  session id used for=
 the probe (the cookie is an HMAC over it)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param server_sid  the server&#39;s cookie, echoe=
d back to complete the handshake</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param remote      the probed (pinned) server address to co=
nnect to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param r=
esend_wkc  true to complete with P_CONTROL_WKC_V1 (tls-crypt-v2)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the session=
 was fast-forwarded, false on failure</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bool session_skip_to_pre_start_client(struct tls_session *session,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
            const struct session_id *client_sid,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                      const st=
ruct session_id *server_sid,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                      const struct openvpn_sockadd=
r *remote, bool resend_wkc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> #endif /* ifndef OPENVPN_SSL_H */</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1770?usp=3Demail">change 1770</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d6832=
00d2a4c0e4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1770 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 15 </div>
<div style=3D=
"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--Oxd+AnsvdYg=--


--===============9157746402693473999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9157746402693473999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9157746402693473999==--

