Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDEDC88E4C
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7sODlAUFguZpgekhPkEs2IrYGfP9GMALfgXw62aWKiA=; b=Nilxap1oplQMAcddqgdwnxmdhl
	MjdZmTo3bN7V1nlysO9P3JhS4ZrhuH+zUrfy5xACiO8PQvrFfZvdohVZyvvo2LKUQwdeu1luEeoSN
	2lXxwHJV2aguQ3aRjXDBmIwmkVRH7jgT2pavifvtrEHCMnje1h5eXI+Y3l2owf3s+PDs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4wTI-0005dX-9A;
	Fri, 11 Sep 2026 08:18:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4wT4-0005XE-Pw
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:18:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LkPI9mIUhHiyK428ohDmnlzb5ODYZ6Gf6Lan8dyR61A=; b=BjRSBxHvWzPiW+WpaOoAI4W1lX
 eRqjsxQIdJgtZWjAKyg+HNZ0MR0ouWaIJWqEa3Rblc1CI7qWghhuaNvgPEFPOA84WKDHtlqOJ1AmZ
 /3Xa+VUUfMltldjGeobxtyO8HmVvhWPdfw8bFiCQsfsPeQWXrHTahg8gaY6Q7no/bdGs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LkPI9mIUhHiyK428ohDmnlzb5ODYZ6Gf6Lan8dyR61A=; b=G
 iWmMCkdJWuL5o2f6+dqZRV4SbvoNbr0C1jHv/a621y3BPjCvyQEzH48XHK0wAp4z+BpmH+cnLxBcq
 1FNtzMNNcA0UHbSrnkT8lQf+YBLR6QKKsLWFYd+8sgyd6FHv4dWLS0f2jdF3TcSQGi4rayiLVLR9T
 7l5l2WISQpO1HHWo=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4wSz-0005Pv-UW for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:18:40 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so3872555e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789114711; x=1789719511; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LkPI9mIUhHiyK428ohDmnlzb5ODYZ6Gf6Lan8dyR61A=;
 b=cUZDnrvLEyYxnQ/B0XU9ahAql6nvQuFx1tzaUJYq4zoXinDveyvRbi2hMbD6vU0Ruq
 aEjcRRSaXgFb6RvdUm83I1yNlsnN2PhROU9cWjtCVJUhWWWloD9c1PwseIpU3cfFrOML
 QUhzHtowZA82A6nlomAJhRDCEnV7KJeBOLA147ks4Q9SpuYWmRIpCdtIfUUstd42iAe3
 HuL0IVO2V5Wd6+QSsYbGEQWg5pQN52ptqEx8Y5ac/sHQBLwB13w58W3u0LZNbqJak6PP
 oatoFA8xzmID8wFPmrK+rjcSN+nXvduLIsI4vJXJLoPW1gUGcYiXEPsUT7CHcZ6xr6Pa
 Q8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789114711; x=1789719511;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LkPI9mIUhHiyK428ohDmnlzb5ODYZ6Gf6Lan8dyR61A=;
 b=etpUnVy/f90B3GEGootc68LK5UKImwJ1y1UYycmjO7AcOQ2pMH8z6j2DRilHWlFm5y
 AuVNRco1bEMs3iy1Z1YlR9Na6a9YWcSRguqylD/COLXpEMQ34TT5zm/oanyA8ZoyBpGN
 KWzjxAMy9lTpmx/5YriRMAb0kPGox3xkeGXlJQIG+h7y+wiObh8Z9QqGss6NRj6N22yM
 SJRc2ZL9seezYRyOS0rrfTfBsKpVEyhgVAAeFywuIZN2y9z++mj8Coa2oc/kqR5/ul62
 QUyOgI8j6C9gL+2jualw5+llAdWMbAkox5K9caEWl8+KYwYknqQhGctMTS456kqm0XUF
 a9pA==
X-Gm-Message-State: AFuF++lUJL4T3t7EuRgoRpcdBTB2t4ZIZ0D0DNJSbftwM0Mjm04jc2tv
 HPY5emuBraf9B7mS0yANFBOMSKwGZ3Ej7MG0N+V4jp/w4xpi/+nxzv2hX4Vyv9BeSzhPMj3EX9q
 Qk4oPwylCaf3fypI35rkdt529kXWQXOUebpVIF2PgFPLzD6bqXifqeVSYtGN5RgNUCp6n
X-Gm-Gg: AYBFou2tZiqa1VOY3ARXJE6GqkOjcFD3YKMlJ5oxYhQlVDtM0H5rpHxNvfkQaLPm+W7
 6gCL1JkJ+5Rkak/lNFNpUrh9uyhobtEy21u48xsqYjfkno9k8kdp+AYtJC/yRwa7fbZTF/4Xdyb
 +QgGTZPGx5qLBabCvsyzqZx9Dq3kEtbOM3RgX4cBatzCOn2Yrp3vnzm2uFzt93mjhl0h7Rm6iVM
 PV6XcjDfclcb+n4EtX9HjKUCwyYHwUlRS6SEHMY+w+n0QEwZ3KD4wkpfJZKFWOrA7fxPlDHb0V8
 yOYn0PIDCvnF8WeiizShrddBPlBHKzZfzMkZN94XN57DtIEjHBD5d+r+u7t3m42XDwr8bcSt7SU
 v6dYRddbsk813UamDdehiWGe0WIvnfDoVbfDn5SWRMYGbeFLeNeDhLhFy7tgI6fzdNHzKC1y9vg
 KfpMHvfbYnU6ZSeUIpSEpwAisIsIdW3ZO8yGhdkB4+erpTADxJ5PxjwWTLamZvpVsF/pfszchpN
 n+gPVji1cUyPSJRCQwGZ9Xj72YE8Y/zRCXg2W3c1+Vy5h2PmA4Mu0MhjOrXWl55V9ZpA9hFiYr2
 3jkywSRwDw3x3KOl7x5D3ioBStMhf7G6mJGY0HQ8DJZYx7+SyqA2DAuSEHA5CJmrIrvIFtm7
X-Received: by 2002:a05:600c:a40e:b0:49e:65ac:eb5f with SMTP id
 5b1f17b1804b1-49e65aced4bmr21895035e9.10.1789114711118; 
 Fri, 11 Sep 2026 01:18:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb359f38sm3995581f8f.30.2026.09.11.01.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 01:18:30 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 08:18:16 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
X-Gerrit-Change-Number: 1770
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1770?usp=email>
X-Gerrit-Commit: dcec71008791f76c404e0d0d19fa233b549ecd5f
In-Reply-To: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
References: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkk0NTRkNTA0MGNiYWQ0ZDM3M2VlNGY5MGI4ZDY4MzIwMGQyYTRjMGU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cd93945c03bab3170dae128ef785b4e6ccf43dc5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4wSz-0005Pv-UW
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
Content-Type: multipart/mixed; boundary="===============2252339005475099390=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2252339005475099390==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OFkKVX+DfmU="; charset=UTF-8

--OFkKVX+DfmU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1770?usp=3Demail

to look at the new patch set (#14)=2E
=


Change subject: oob: start the client handshake from the server probe
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: start the c=
lient handshake from the server probe

When the best remote answered a prob=
e and advertised a connect_lifetime, its
reply also served as the server's =
HARD_RESET: its session id is a valid
stateless SYN-cookie=2E The client th=
erefore starts the handshake from that reply
instead of running its own res=
et exchange=2E

Note this does not shorten the handshake itself -- the prob=
e and its reply take
the place of the two reset packets rather than removin=
g them=2E The saving is one
RTT compared with probing and then connecting; =
a client that does not probe is
unaffected=2E

  - oob_client=2Ec: when the=
 winner advertised a connect_lifetime, hand its probe
    socket, the captu=
red server session id (cookie), our probe session id, the
    pinned respon=
der address, and the resend-wkc flag to the connection via c2;
    relinqui=
sh that socket (do not close it); gate off for dco-win, which has no
    us=
er-to-kernel socket handoff (probing still works, only starting from the
  =
  reply is skipped)=2E
  - ssl=2Ec session_skip_to_pre_start_client(): seed=
 our session id to the probe's
    (the cookie is an HMAC over it), the rem=
ote session id to the cookie, ack
    the phantom server reset (id 0) so th=
e third packet carries the cookie, set
    CO_RESEND_WKC for tls-crypt-v2, =
and drop to S_PRE_START so tls_process()
    promotes to S_START and sends =
the ClientHello (no HARD_RESET sent)=2E
  - init=2Ec: invoke the client ski=
p after tls_multi_init_finalize when adopting,
    and count the probe repl=
y as the initial packet received (n_sessions++, as
    the server does befo=
re its own session_skip_to_pre_start) so
    check_server_poll_timeout() do=
es not restart the connected session=2E

Change-Id: I454d5040cbad4d373ee4f9=
0b8d683200d2a4c0e4
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M Ch=
anges=2Erst
M src/openvpn/init=2Ec
M src/openvpn/oob=2Eh
M src/openvpn/oob_=
client=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ss=
l=2Eh
7 files changed, 172 insertions(+), 10 deletions(-)


  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1770/14

diff --git =
a/Changes=2Erst b/Changes=2Erst
index 080d928=2E=2E4d7a16c9 100644
--- a/Ch=
anges=2Erst
+++ b/Changes=2Erst
@@ -9,6 +9,13 @@
     measured latency and =
advertised weight with DNS-SRV-like semantics=2E
     Servers advertise the=
se values with ``--server-probe-reply``=2E
 
+Probe exchange doubles as the=
 start of the handshake
+    When a probing client picks a server that adve=
rtises support for it,
+    the probe and its reply take the place of the c=
lient's and server's
+    reset packets, so the client does not need a sepa=
rate reset exchange
+    before the handshake=2E This saves one round trip =
compared with probing
+    and then connecting, and needs no extra configur=
ation=2E
+
 
 Overview of changes in 2=2E7
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/src/openvpn/i=
nit=2Ec b/src/openvpn/init=2Ec
index 3f805f3=2E=2Eede0259 100644
--- a/src/=
openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3483,6 +3483,21 @@
        =
 /* Keep the max mtu also in the frame of tls multi so it can access
      =
    * it in push_peer_info */
         c->c2=2Etls_multi->opt=2Eframe=2Etun=
_max_mtu =3D c->c2=2Eframe=2Etun_max_mtu;
+
+        /* OOB server probe: t=
he probe reply already served as the server's
+         * HARD_RESET (it ca=
rried a valid SYN-cookie), so the handshake starts
+         * from that re=
ply and we send no reset of our own=2E Count
+         * the reply as the i=
nitial packet received (as the server does before its
+         * own sessi=
on_skip_to_pre_start), so tls_initial_packet_received() is true
+         *=
 and check_server_poll_timeout() does not restart a connected session=2E */=

+        if (c->c2=2Eoob_probe_adopt)
+        {
+            c->c2=2Etls_=
multi->n_sessions++;
+            session_skip_to_pre_start_client(&c->c2=
=2Etls_multi->session[TM_ACTIVE],
+                                        =
     &c->c2=2Eoob_probe_client_sid,
+                                      =
       &c->c2=2Eoob_probe_server_sid, &c->c2=2Eoob_probe_remote,
+         =
                                    c->c2=2Eoob_probe_resend_wkc);
+       =
 }
     }
     if (c->c2=2Etls_auth_standalone)
     {
diff --git a/src/ope=
nvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 9fde094=2E=2E5568177 100644
--- a/=
src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -192,8 +192,11 @@
 {
     =
int index;
     bool responded;
-    unsigned int rtt_ms;          /* probe=
 round-trip time in ms (responders only) */
-    struct oob_probe_reply rep=
ly; /* the values the server advertised */
+    unsigned int rtt_ms; /* pro=
be round-trip time in ms (responders only) */
+    /* Captured from the pac=
ket and its reply TLV (responders only): */
+    struct session_id server_s=
id;      /* the packet's own session id =3D server SYN-cookie */
+    struc=
t openvpn_sockaddr responder; /* address that answered (pin the connection =
to it) */
+    struct oob_probe_reply reply;      /* the values the server =
advertised */
 };
 
 /* Where the client probed one connection entry: its r=
esolved addresses=2E */
diff --git a/src/openvpn/oob_client=2Ec b/src/openv=
pn/oob_client=2Ec
index 37a75ff=2E=2Ee50147b 100644
--- a/src/openvpn/oob_c=
lient=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -38,6 +38,7 @@
 #include "oti=
me=2Eh"
 #include "fdmisc=2Eh"
 #include "crypto=2Eh"
+#include "dco=2Eh"
 =
#include "error=2Eh"
 
 #include "memdbg=2Eh"
@@ -303,6 +304,13 @@
        =
 return;
     }
 
+    /* The reply's own session id (the server's stateles=
s SYN-cookie) follows the
+     * opcode byte=2E Capture it before read_con=
trol_auth() strips it: a client may
+     * reuse it to start the handshake=
 from this reply (the connect_lifetime
+     * advertisement)=2E */
+    st=
ruct session_id server_sid;
+    memcpy(server_sid=2Eid, data + 1, SID_SIZE=
);
+
     struct buffer buf;
     buf_set_read(&buf, data, (size_t)len);
 
=
@@ -346,6 +354,8 @@
 
         results[i]=2Eresponded =3D true;
         re=
sults[i]=2Ertt_ms =3D (ms > 0) ? (unsigned int)ms : 0;
+        results[i]=
=2Eserver_sid =3D server_sid;
+        results[i]=2Eresponder =3D *from; /*=
 pin the connection to the address that answered */
         results[i]=2Er=
eply =3D reply;
 
         i =3D oob_probe_next_target_at(from, targets, re=
sults, n, i + 1);
@@ -704,11 +714,6 @@
     {
         oob_probe_collect(&p=
c, &probe, &client_sid, &tas->tls_wrap, targets, results, l->len);
     }
-=
    oob_probe_sockets_close(&pc);
-    if (bind_local)
-    {
-        free=
addrinfo(bind_local);
-    }
 
     /* Log each remote's outcome while resu=
lts[i] still maps to array[i]=2E */
     int responded =3D 0;
@@ -724,10 +7=
29,10 @@
             int margin =3D oob_effective_margin(&results[i], clie=
nt_margin);
             const char *margin_src =3D client_margin >=3D 0 ? =
"client" : "server-advertised";
             msg(D_LOW,
-                "s=
erver-probe: %s:%s answered (priority %d, weight %d, rtt %u ms;"
-         =
       " latency margin %d ms [%s])",
+                "server-probe: %s:%s=
 answered (priority %d, weight %d, connect-lifetime %d s,"
+               =
 " rtt %u ms; latency margin %d ms [%s])",
                 ce->remote, ce-=
>remote_port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight,
-=
                results[i]=2Ertt_ms, margin, margin_src);
+                =
results[i]=2Ereply=2Econnect_lifetime, results[i]=2Ertt_ms, margin, margin_=
src);
         }
         else
         {
@@ -749,6 +754,65 @@
     msg(M_I=
NFO, "server-probe: %d of %d remote(s) answered; connecting best-first", re=
sponded,
         l->len);
 
+    /* If the winner advertised a connect_lif=
etime, its reply also served as the
+     * server's reset: hand its probe =
socket and the captured cookie to the
+     * connection, which then starts=
 the handshake from that reply (see
+     * session_skip_to_pre_start_clien=
t)=2E Reusing that socket keeps the source
+     * IP+port the cookie is bo=
und to=2E dco-win cannot hand a socket to the
+     * kernel, so it only ge=
ts the probe ordering=2E */
+
+    /* Single-use, so the RFC's connect_life=
time expiry check is not needed yet:
+     * we probe once (c->first_time) =
and arm only results[0]=2E */
+    bool probe_start =3D results[0]=2Erespon=
ded && results[0]=2Ereply=2Econnect_lifetime > 0;
+    bool dco_win_gate =
=3D false;
+#if defined(_WIN32)
+    if (dco_enabled(&c->options))
+    {
+=
        probe_start =3D false;
+        dco_win_gate =3D true;
+    }
+#end=
if
+    if (probe_start)
+    {
+        const int af_idx =3D probe_af_inde=
x(results[0]=2Eresponder=2Eaddr=2Esa=2Esa_family);
+        c->c2=2Eoob_pro=
be_sd =3D pc=2Esd[af_idx];
+        pc=2Esd[af_idx] =3D SOCKET_UNDEFINED; /=
* relinquish: the connection owns it now */
+
+        c->c2=2Eoob_probe_re=
mote =3D results[0]=2Eresponder;
+        c->c2=2Eoob_probe_client_sid =3D =
client_sid;
+        c->c2=2Eoob_probe_server_sid =3D results[0]=2Eserver_s=
id;
+        c->c2=2Eoob_probe_resend_wkc =3D
+            (results[0]=2Ere=
ply=2Eflags & OOB_PROBE_REPLY_FLAG_RESEND_WKC) !=3D 0;
+        c->c2=2Eoob=
_probe_adopt =3D true;
+
+        msg(D_LOW, "server-probe: starting handsh=
ake from probe reply of %s:%s"
+                   " (connect-lifetime %d s=
)",
+            l->array[0]->remote, l->array[0]->remote_port, results[0]=
=2Ereply=2Econnect_lifetime);
+    }
+    else if (results[0]=2Eresponded)
=
+    {
+        /* A server answered but we won't start the handshake from =
it -- say why=2E */
+        if (dco_win_gate)
+        {
+            msg(=
D_LOW, "server-probe: cannot start the handshake from a probe reply"
+     =
                  " with dco-win;"
+                       " using a full h=
andshake");
+        }
+        else if (results[0]=2Ereply=2Econnect_lifet=
ime =3D=3D 0)
+        {
+            msg(D_LOW, "server-probe: %s:%s did n=
ot advertise a connect-lifetime"
+                       " (connect-lifetim=
e 0); using a full handshake",
+                l->array[0]->remote, l->arr=
ay[0]->remote_port);
+        }
+    }
+
+    /* Close any probe sockets we=
 did not hand off to the connection=2E */
+    oob_probe_sockets_close(&pc)=
;
+
+    if (bind_local)
+    {
+        freeaddrinfo(bind_local);
+    }
 =
    tls_auth_standalone_free(tas);
     gc_free(&gc);
 }
diff --git a/src/o=
penvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index 436495e=2E=2Ec0f9c62 100=
644
--- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -250,6 +=
250,9 @@
     bool oob_probe_adopt;
     socket_descriptor_t oob_probe_sd;
=
     struct openvpn_sockaddr oob_probe_remote;
+    struct session_id oob_p=
robe_client_sid;  /* our probe session id (cookie was minted over it) */
+ =
   struct session_id oob_probe_server_sid;  /* the reply's session id =3D s=
erver cookie to echo back */
+    bool oob_probe_resend_wkc;               =
/* reply asked to complete with CONTROL_WKC_V1 (v2) */
 
     struct link_s=
ocket_actual *to_link_addr; /* IP address of remote */
     struct link_soc=
ket_actual from;          /* address of incoming datagram */
diff --git a/s=
rc/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index c8fc465=2E=2E66efd39 100644
=
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2569,6 +2569,59 @@
=
     return session_move_pre_start(session, ks, true);
 }
 
+bool
+session_=
skip_to_pre_start_client(struct tls_session *session, const struct session_=
id *client_sid,
+                                 const struct session_id *=
server_sid,
+                                 const struct openvpn_sockaddr=
 *remote, bool resend_wkc)
+{
+    struct key_state *ks =3D &session->key[K=
S_PRIMARY];
+
+    /* Our session id must be the one used for the probe: th=
e server's cookie
+     * (server_sid) is an HMAC over it, and the server r=
e-derives and checks it
+     * when it validates our third packet=2E */
+ =
   session->session_id =3D *client_sid;
+    ks->session_id_remote =3D *ser=
ver_sid;
+
+    struct link_socket_actual act =3D { 0 };
+    act=2Edest =
=3D *remote;
+    ks->remote_addr =3D act;
+    session->untrusted_addr =3D=
 act;
+    session->burst =3D true;
+
+    /* tls-crypt-v2: the stateless s=
erver discarded the WKc after the probe, so
+     * complete the handshake =
with P_CONTROL_WKC_V1 (drives control_packet_needs_wkc)=2E */
+    if (rese=
nd_wkc)
+    {
+        ks->crypto_options=2Eflags |=3D CO_RESEND_WKC;
+   =
 }
+
+    /* We never received the server's HARD_RESET (id 0) =E2=80=94 the=
 probe reply stood
+     * in for it=2E Acknowledge that phantom id 0 so ou=
r third packet carries an
+     * ACK together with the server session id (=
the cookie): reliable_ack_write()
+     * only emits that session id when a=
t least one ACK is present, and the server
+     * needs it to validate the=
 stateless cookie=2E */
+    reliable_ack_acknowledge_packet_id(ks->rec_ack=
, 0);
+
+    /* Skip one (RESET) packet in each direction, so ids start at =
1 (see
+     * session_skip_to_pre_start)=2E */
+    ks->rec_reliable->pack=
et_id =3D 1;
+    session->tls_wrap=2Eopt=2Epacket_id=2Esend=2Eid =3D 1;
+
=
+    /* Do not send our own HARD_RESET=2E Unlike the server's skip, the cli=
ent must
+     * send first: the stateless server only replies once it sees=
 our third
+     * packet=2E session_move_pre_start(skip=3Dtrue) leaves us =
in S_PRE_START_SKIP,
+     * which only advances when a packet is *received=
*; instead drop to
+     * S_PRE_START with an empty send-reliable (the ini=
tial packet was generated
+     * and immediately deleted), so tls_process(=
) promotes us to S_START and
+     * sends the ClientHello without waiting =
for a server reset=2E */
+    if (!session_move_pre_start(session, ks, true=
))
+    {
+        return false;
+    }
+    ks->state =3D S_PRE_START;
+  =
  return true;
+}
+
 /**
  * Parses the TLVs (type, length, value) in the e=
arly negotiation
  */
diff --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2E=
h
index 7ddf965=2E=2Ea534007 100644
--- a/src/openvpn/ssl=2Eh
+++ b/src/ope=
nvpn/ssl=2Eh
@@ -576,4 +576,21 @@
 bool session_skip_to_pre_start(struct tl=
s_session *session, struct tls_pre_decrypt_state *state,
                  =
              struct link_socket_actual *from);
 
+/**
+ * Client counterpa=
rt of session_skip_to_pre_start(): start the handshake from a
+ * server se=
ssion id (SYN-cookie) learned earlier from an OOB server probe
+ * reply, w=
hich already served as the server's HARD_RESET, so we send none=2E
+ *
+ * =
@param session     the (client) TLS session to fast-forward
+ * @param clie=
nt_sid  session id used for the probe (the cookie is an HMAC over it)
+ * @=
param server_sid  the server's cookie, echoed back to complete the handshak=
e
+ * @param remote      the probed (pinned) server address to connect to
+=
 * @param resend_wkc  true to complete with P_CONTROL_WKC_V1 (tls-crypt-v2)=

+ * @return true if the session was fast-forwarded, false on failure
+ */
=
+bool session_skip_to_pre_start_client(struct tls_session *session,
+      =
                                const struct session_id *client_sid,
+     =
                                 const struct session_id *server_sid,
+    =
                                  const struct openvpn_sockaddr *remote, bo=
ol resend_wkc);
+
 #endif /* ifndef OPENVPN_SSL_H */

-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0=
e4
Gerrit-Change-Number: 1770
Gerrit-PatchSet: 14
Gerrit-Owner: stipa <lsti=
pakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--OFkKVX+DfmU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #14</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1770?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: sta=
rt the client handshake from the server probe<br><br>When the best remote a=
nswered a probe and advertised a connect_lifetime, its<br>reply also served=
 as the server&#39;s HARD_RESET: its session id is a valid<br>stateless SYN=
-cookie=2E The client therefore starts the handshake from that reply<br>ins=
tead of running its own reset exchange=2E<br><br>Note this does not shorten=
 the handshake itself -- the probe and its reply take<br>the place of the t=
wo reset packets rather than removing them=2E The saving is one<br>RTT comp=
ared with probing and then connecting; a client that does not probe is<br>u=
naffected=2E<br><br>  - oob_client=2Ec: when the winner advertised a connec=
t_lifetime, hand its probe<br>    socket, the captured server session id (c=
ookie), our probe session id, the<br>    pinned responder address, and the =
resend-wkc flag to the connection via c2;<br>    relinquish that socket (do=
 not close it); gate off for dco-win, which has no<br>    user-to-kernel so=
cket handoff (probing still works, only starting from the<br>    reply is s=
kipped)=2E<br>  - ssl=2Ec session_skip_to_pre_start_client(): seed our sess=
ion id to the probe&#39;s<br>    (the cookie is an HMAC over it), the remot=
e session id to the cookie, ack<br>    the phantom server reset (id 0) so t=
he third packet carries the cookie, set<br>    CO_RESEND_WKC for tls-crypt-=
v2, and drop to S_PRE_START so tls_process()<br>    promotes to S_START and=
 sends the ClientHello (no HARD_RESET sent)=2E<br>  - init=2Ec: invoke the =
client skip after tls_multi_init_finalize when adopting,<br>    and count t=
he probe reply as the initial packet received (n_sessions++, as<br>    the =
server does before its own session_skip_to_pre_start) so<br>    check_serve=
r_poll_timeout() does not restart the connected session=2E<br><br>Change-Id=
: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4<br>Signed-off-by: Lev Stipakov =
&lt;lev@openvpn=2Enet&gt;<br>---<br>M Changes=2Erst<br>M src/openvpn/init=
=2Ec<br>M src/openvpn/oob=2Eh<br>M src/openvpn/oob_client=2Ec<br>M src/open=
vpn/openvpn=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl=2Eh<br>7 file=
s changed, 172 insertions(+), 10 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1770/14</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/Changes=2Erst b/Changes=2Erst</span><br><span>index 080=
d928=2E=2E4d7a16c9 100644</span><br><span>--- a/Changes=2Erst</span><br><sp=
an>+++ b/Changes=2Erst</span><br><span>@@ -9,6 +9,13 @@</span><br><span>   =
  measured latency and advertised weight with DNS-SRV-like semantics=2E</sp=
an><br><span>     Servers advertise these values with ``--server-probe-repl=
y``=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+Probe exchange doubles as the start of the handshake</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    When a probing client picks a ser=
ver that advertises support for it,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    the probe and its reply take the place of the client&#3=
9;s and server&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    reset packets, so the client does not need a separate reset exchange</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    before the handsh=
ake=2E This saves one round trip compared with probing</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    and then connecting, and needs no ex=
tra configuration=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> </span><br><span> Overview of changes in 2=2E7</span><br=
><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvp=
n/init=2Ec</span><br><span>index 3f805f3=2E=2Eede0259 100644</span><br><spa=
n>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</sp=
an><br><span>@@ -3483,6 +3483,21 @@</span><br><span>         /* Keep the ma=
x mtu also in the frame of tls multi so it can access</span><br><span>     =
     * it in push_peer_info */</span><br><span>         c-&gt;c2=2Etls_mult=
i-&gt;opt=2Eframe=2Etun_max_mtu =3D c-&gt;c2=2Eframe=2Etun_max_mtu;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* OOB server probe: the probe reply a=
lready served as the server&#39;s</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * HARD_RESET (it carried a valid SYN-cookie), so the=
 handshake starts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       * from that reply and we send no reset of our own=2E Count</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * the reply as the i=
nitial packet received (as the server does before its</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * own session_skip_to_pre_start)=
, so tls_initial_packet_received() is true</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * and check_server_poll_timeout() does not =
restart a connected session=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (c-&gt;c2=2Eoob_probe_adopt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            c-&gt;c2=2Etls_multi-&gt;n_sessions++;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            session_=
skip_to_pre_start_client(&amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE],<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                         &amp;c-&gt;c2=2Eoob_probe_client_sid,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
             &amp;c-&gt;c2=2Eoob_probe_server_sid, &amp;c-&gt;c2=2Eoob_prob=
e_remote,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                   c-&gt;c2=2Eoob_probe_resend_wkc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>=
     }</span><br><span>     if (c-&gt;c2=2Etls_auth_standalone)</span><br><=
span>     {</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/=
oob=2Eh</span><br><span>index 9fde094=2E=2E5568177 100644</span><br><span>-=
-- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><b=
r><span>@@ -192,8 +192,11 @@</span><br><span> {</span><br><span>     int in=
dex;</span><br><span>     bool responded;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    unsigned int rtt_ms;          /* probe round-trip t=
ime in ms (responders only) */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    struct oob_probe_reply reply; /* the values the server adverti=
sed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned =
int rtt_ms; /* probe round-trip time in ms (responders only) */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* Captured from the packet=
 and its reply TLV (responders only): */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct session_id server_sid;      /* the packet&#=
39;s own session id =3D server SYN-cookie */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr responder; /* address =
that answered (pin the connection to it) */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct oob_probe_reply reply;      /* the value=
s the server advertised */</span><br><span> };</span><br><span> </span><br>=
<span> /* Where the client probed one connection entry: its resolved addres=
ses=2E */</span><br><span>diff --git a/src/openvpn/oob_client=2Ec b/src/ope=
nvpn/oob_client=2Ec</span><br><span>index 37a75ff=2E=2Ee50147b 100644</span=
><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+++ b/src/openv=
pn/oob_client=2Ec</span><br><span>@@ -38,6 +38,7 @@</span><br><span> #inclu=
de &quot;otime=2Eh&quot;</span><br><span> #include &quot;fdmisc=2Eh&quot;</=
span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;dco=2Eh&quot;</span><br><span> #=
include &quot;error=2Eh&quot;</span><br><span> </span><br><span> #include &=
quot;memdbg=2Eh&quot;</span><br><span>@@ -303,6 +304,13 @@</span><br><span>=
         return;</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* The reply&#39;s own session id=
 (the server&#39;s stateless SYN-cookie) follows the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * opcode byte=2E Capture it before r=
ead_control_auth() strips it: a client may</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * reuse it to start the handshake from this rep=
ly (the connect_lifetime</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * advertisement)=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct session_id server_sid;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    memcpy(server_sid=2Eid, data + 1, SID_SIZE);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   struct buffer buf;</span><br><span>     buf_set_read(&amp;buf, data, (si=
ze_t)len);</span><br><span> </span><br><span>@@ -346,6 +354,8 @@</span><br>=
<span> </span><br><span>         results[i]=2Eresponded =3D true;</span><br=
><span>         results[i]=2Ertt_ms =3D (ms &gt; 0) ? (unsigned int)ms : 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=
=2Eserver_sid =3D server_sid;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        results[i]=2Eresponder =3D *from; /* pin the connection t=
o the address that answered */</span><br><span>         results[i]=2Ereply =
=3D reply;</span><br><span> </span><br><span>         i =3D oob_probe_next_=
target_at(from, targets, results, n, i + 1);</span><br><span>@@ -704,11 +71=
4,6 @@</span><br><span>     {</span><br><span>         oob_probe_collect(&a=
mp;pc, &amp;probe, &amp;client_sid, &amp;tas-&gt;tls_wrap, targets, results=
, l-&gt;len);</span><br><span>     }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    oob_probe_sockets_close(&amp;pc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (bind_local)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        freeaddrinfo(bind_local);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span> </span><br><span>     /*=
 Log each remote&#39;s outcome while results[i] still maps to array[i]=2E *=
/</span><br><span>     int responded =3D 0;</span><br><span>@@ -724,10 +729=
,10 @@</span><br><span>             int margin =3D oob_effective_margin(&am=
p;results[i], client_margin);</span><br><span>             const char *marg=
in_src =3D client_margin &gt;=3D 0 ? &quot;client&quot; : &quot;server-adve=
rtised&quot;;</span><br><span>             msg(D_LOW,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                &quot;server-probe: %s:%s a=
nswered (priority %d, weight %d, rtt %u ms;&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                &quot; latency margin %d ms [%s=
])&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      &quot;server-probe: %s:%s answered (priority %d, weight %d, connect-l=
ifetime %d s,&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                &quot; rtt %u ms; latency margin %d ms [%s])&quot;,</span><=
br><span>                 ce-&gt;remote, ce-&gt;remote_port, results[i]=2Er=
eply=2Epriority, results[i]=2Ereply=2Eweight,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                results[i]=2Ertt_ms, margin, margin=
_src);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   results[i]=2Ereply=2Econnect_lifetime, results[i]=2Ertt_ms, margin, marg=
in_src);</span><br><span>         }</span><br><span>         else</span><br=
><span>         {</span><br><span>@@ -749,6 +754,65 @@</span><br><span>    =
 msg(M_INFO, &quot;server-probe: %d of %d remote(s) answered; connecting be=
st-first&quot;, responded,</span><br><span>         l-&gt;len);</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* If the=
 winner advertised a connect_lifetime, its reply also served as the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * server&#39;s reset: =
hand its probe socket and the captured cookie to the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * connection, which then starts the =
handshake from that reply (see</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * session_skip_to_pre_start_client)=2E Reusing that socket =
keeps the source</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * IP+port the cookie is bound to=2E dco-win cannot hand a socket to the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * kernel, so it =
only gets the probe ordering=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Single-use, so the RFC&#39;s connect_lifetime expiry check is not needed=
 yet:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * we prob=
e once (c-&gt;first_time) and arm only results[0]=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    bool probe_start =3D results[0]=2Er=
esponded &amp;&amp; results[0]=2Ereply=2Econnect_lifetime &gt; 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    bool dco_win_gate =3D fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN=
32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco_enab=
led(&amp;c-&gt;options))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        p=
robe_start =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        dco_win_gate =3D true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (probe_=
start)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        const int af_idx =
=3D probe_af_index(results[0]=2Eresponder=2Eaddr=2Esa=2Esa_family);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_prob=
e_sd =3D pc=2Esd[af_idx];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        pc=2Esd[af_idx] =3D SOCKET_UNDEFINED; /* relinquish: the conn=
ection owns it now */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=
=2Eoob_probe_remote =3D results[0]=2Eresponder;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_client_sid =3D cli=
ent_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&=
gt;c2=2Eoob_probe_server_sid =3D results[0]=2Eserver_sid;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_resend_w=
kc =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            (=
results[0]=2Ereply=2Eflags &amp; OOB_PROBE_REPLY_FLAG_RESEND_WKC) !=3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoo=
b_probe_adopt =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_L=
OW, &quot;server-probe: starting handshake from probe reply of %s:%s&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   &=
quot; (connect-lifetime %d s)&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            l-&gt;array[0]-&gt;remote, l-&gt;array[0]-&gt;=
remote_port, results[0]=2Ereply=2Econnect_lifetime);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else if (results[0]=2Eresponded)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* A server answered but we won&#39;t start =
the handshake from it -- say why=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (dco_win_gate)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            msg(D_LOW, &quot;server-probe: cannot start the =
handshake from a probe reply&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                       &quot; with dco-win;&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                       &quot; =
using a full handshake&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        else if (results[0]=2Ereply=2Econnect_lifetime =3D=3D 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-pro=
be: %s:%s did not advertise a connect-lifetime&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                       &quot; (connect-li=
fetime 0); using a full handshake&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                l-&gt;array[0]-&gt;remote, l-&gt;array=
[0]-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Close any probe sockets we did not=
 hand off to the connection=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    oob_probe_sockets_close(&amp;pc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (bind_local)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        freeaddrinfo(bind_local);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span>     tls_auth_standalone_free(tas);</s=
pan><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span>dif=
f --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</span><br><span=
>index 436495e=2E=2Ec0f9c62 100644</span><br><span>--- a/src/openvpn/openvp=
n=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</span><br><span>@@ -250=
,6 +250,9 @@</span><br><span>     bool oob_probe_adopt;</span><br><span>   =
  socket_descriptor_t oob_probe_sd;</span><br><span>     struct openvpn_soc=
kaddr oob_probe_remote;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct session_id oob_probe_client_sid;  /* our probe session id (c=
ookie was minted over it) */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct session_id oob_probe_server_sid;  /* the reply&#39;s se=
ssion id =3D server cookie to echo back */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    bool oob_probe_resend_wkc;               /* repl=
y asked to complete with CONTROL_WKC_V1 (v2) */</span><br><span> </span><br=
><span>     struct link_socket_actual *to_link_addr; /* IP address of remot=
e */</span><br><span>     struct link_socket_actual from;          /* addre=
ss of incoming datagram */</span><br><span>diff --git a/src/openvpn/ssl=2Ec=
 b/src/openvpn/ssl=2Ec</span><br><span>index c8fc465=2E=2E66efd39 100644</s=
pan><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/s=
sl=2Ec</span><br><span>@@ -2569,6 +2569,59 @@</span><br><span>     return s=
ession_move_pre_start(session, ks, true);</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+session_skip_to_pre_start_clien=
t(struct tls_session *session, const struct session_id *client_sid,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
      const struct session_id *server_sid,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                 const struct openvp=
n_sockaddr *remote, bool resend_wkc)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Our session id must be the one used for the p=
robe: the server&#39;s cookie</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * (server_sid) is an HMAC over it, and the server re-derives=
 and checks it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* when it validates our third packet=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    session-&gt;session_id =3D *client_sid;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;session_id_remote=
 =3D *server_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct link_socke=
t_actual act =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    act=2Edest =3D *remote;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ks-&gt;remote_addr =3D act;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    session-&gt;untrusted_addr =3D act;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;burst =3D true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* tls-crypt-v2: the stateless ser=
ver discarded the WKc after the probe, so</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * complete the handshake with P_CONTROL_WKC_V1 (=
drives control_packet_needs_wkc)=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (resend_wkc)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        ks-&gt;crypto_options=2Eflags |=3D CO_RESEND_WKC;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* We never received the server&#39;s HARD_RESET (id 0) =E2=
=80=94 the probe reply stood</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * in for it=2E Acknowledge that phantom id 0 so our third pac=
ket carries an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* ACK together with the server session id (the cookie): reliable_ack_write(=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * only emits =
that session id when at least one ACK is present, and the server</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * needs it to validate th=
e stateless cookie=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    reliable_ack_acknowledge_packet_id(ks-&gt;rec_ack, 0);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* Skip one (RESET) packet in each direction, =
so ids start at 1 (see</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * session_skip_to_pre_start)=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ks-&gt;rec_reliable-&gt;packet_id =3D 1;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;tls_wrap=2E=
opt=2Epacket_id=2Esend=2Eid =3D 1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Do not send our own HARD_RESET=2E Unlike the server&#39;s skip, the clie=
nt must</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * send =
first: the stateless server only replies once it sees our third</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * packet=2E session_move_p=
re_start(skip=3Dtrue) leaves us in S_PRE_START_SKIP,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * which only advances when a packet =
is *received*; instead drop to</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * S_PRE_START with an empty send-reliable (the initial pack=
et was generated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * and immediately deleted), so tls_process() promotes us to S_START and</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * sends the Clie=
ntHello without waiting for a server reset=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!session_move_pre_start(session, ks, t=
rue))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;state =3D S_PRE_START;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Parse=
s the TLVs (type, length, value) in the early negotiation</span><br><span> =
 */</span><br><span>diff --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh<=
/span><br><span>index 7ddf965=2E=2Ea534007 100644</span><br><span>--- a/src=
/openvpn/ssl=2Eh</span><br><span>+++ b/src/openvpn/ssl=2Eh</span><br><span>=
@@ -576,4 +576,21 @@</span><br><span> bool session_skip_to_pre_start(struct=
 tls_session *session, struct tls_pre_decrypt_state *state,</span><br><span=
>                                struct link_socket_actual *from);</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Client counterpart of s=
ession_skip_to_pre_start(): start the handshake from a</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * server session id (SYN-cookie) learne=
d earlier from an OOB server probe</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * reply, which already served as the server&#39;s HARD_RESE=
T, so we send none=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param sessi=
on     the (client) TLS session to fast-forward</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param client_sid  session id used for the p=
robe (the cookie is an HMAC over it)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param server_sid  the server&#39;s cookie, echoed back=
 to complete the handshake</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param remote      the probed (pinned) server address to connect =
to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param resend_=
wkc  true to complete with P_CONTROL_WKC_V1 (tls-crypt-v2)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the session was f=
ast-forwarded, false on failure</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
 session_skip_to_pre_start_client(struct tls_session *session,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
      const struct session_id *client_sid,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                      const struct s=
ession_id *server_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                      const struct openvpn_sockaddr *rem=
ote, bool resend_wkc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> #endif /* ifndef OPENVPN_SSL_H */</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1770?usp=3Demail">change 1770</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1770?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2=
a4c0e4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1770 </div=
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
--OFkKVX+DfmU=--


--===============2252339005475099390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2252339005475099390==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2252339005475099390==--

