Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2D0C53200
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u6P2GTiv0n0bS5SWMBEIXJoK7NH4FeEZB8wSeg23Sx4=; b=SK7hbjSJf6dEruWoZGbTs1aRsi
	ilRjZtRSyDdljvQ5QCdfUOX8waG1rzqEtoZtvV4vvoTgWbHtbkjlvRYdLMJMSLLxRyLDq5B2Xntqp
	LlldlravI6SIG8vLUK4yAzDGrX/MBTx95QurN7iqFJFrYtQsDYUpg5lpLH8aovgjyQOg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp3KY-0002D2-9p;
	Wed, 29 Jul 2026 12:24:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp3K1-00029D-LI
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pzgsn+WEemJJTgZyKRqMkkWnZ1m8jM8dSC8ug01MfSQ=; b=ZA4u2+tTTvmH/Qownv0xtbHXBg
 eXeWQjtQk9AJsYnh7u1ZGjALeem6U0NPujaIkcRxuR+KS2hx7vZFjwWldtB9EeEnxz3z8Aarv0EtM
 l5eJ599o9UXkDJm5m8vwdiZuT/ZKfCgz7YpNo+xWzEs+YEY71CnMufR8zpeYiIDhChbc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pzgsn+WEemJJTgZyKRqMkkWnZ1m8jM8dSC8ug01MfSQ=; b=I
 e0MPkvR5zy4uCaE+QINVDh/kiO358wTKLIBeGpSqhjgMyMVN+JUOTMYGD/5H5jQjIK06J3+XQcpWF
 7kIk82lCSAqcg/oUKhxQpCc9Aql44ZENAnNi4ZJILYhYXMCBzdrmF4xUHmEebkQSciNW0FS2HmNds
 Qp5w3O35Oj0CZJ9Y=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp3Jz-0005Lw-KJ for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:42 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso9924055e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 05:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785327809; x=1785932609; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pzgsn+WEemJJTgZyKRqMkkWnZ1m8jM8dSC8ug01MfSQ=;
 b=asS9z/AnE3mMdn9aPOHklxtVKYWDzm0BhEYN6AK0kQRHOOoQna4Dwju1DAFGk97aKN
 1fttcSocCiElKeb+j8D3MaxFfTxdSounlB+s/Bh6wo7691ibkKEq+rY31GsONGpAn83/
 AeFRphVwVNoxl1UObOM4aE3IIqDSOohg1cWmcXG2KRQ+D/9kGYPVAQwxquemRGpLmCL/
 tlfRbnQmcBL9wgOIdqcP4dTz3E7KitNjbufrCSDpEqvdtbpqpJ93TUuEdSMvkSyEGEh8
 oEa/oStTa+feRb2ZcP4KeJ+4VeuULkaJ1VihM3X/X175DFM++4G3CNbt7USmi3jkC5X4
 EUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327809; x=1785932609;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pzgsn+WEemJJTgZyKRqMkkWnZ1m8jM8dSC8ug01MfSQ=;
 b=ej3jR6GaNt2+gFmLgnQT4ZTBMulAKf7MrO+ZbJn/s+2wetrZ3dCaDXfJnelc8WM9rv
 4I5/A/U2lIXQHqWlcXTrr1aLrIdEranQYVP9prAHOy46BlwAbfu7DWG0V75HEjykzSJE
 Y6FFzAX6YsL4NNjclo8SOGvuZUW97Rh6AfateLBg8aBbcm6E6toVcSU6bw04Atq2NigS
 QIvy24EbF1xbdK4ddZXy4PJrL/4zRCzFQRPMrNQhAgcYvTaWYCAools1b3sV9pbke4+b
 kj6Teo6ToC0dBkHiodTnYcCRaHoPkpO7ICyS1sPdY11jbmO6R27irxGAYuMggRQeXyRJ
 GwzA==
X-Gm-Message-State: AOJu0YyJXzLZ9ReBILGCYQgYPoiWnH2T8pOaJiMAPwfn5PD17lXgwX0w
 ozucdcO93WO1aPJT8MNYTqxlqwFr2dwk7iLVS5nHN1wRtS4V4irFDq4A211H/BFb2RHdf+dupMt
 gnw8sNXX7eT6g3MGhd9Ssw+IMdn0bQLGQRB4VofbEOPCxz/t+1/AbkibWHg7T1eK4nfLi5HrOEF
 /1McWDvA==
X-Gm-Gg: AR+sD13fu2PfJaTRv0Tm3ZA/UHT6LS6pjEUvq+ozlBDfAb+ApKyAZk1EH9Ltfr+OAmU
 VhZQmxMxpaPLTIdjutnJs8k33pezqS4AWsVerKn2mvegHR3Uv3eEzBtAVDZXx3g1knR0McDiK1Z
 k1vYv/WYZK6DEzuVSNR0vEbtO05GD8e+EaLqzaVrQSwUf+OddX/ITn83ml8BRkL4B58MDPXWGU0
 dydu0YKSPA6+IXX6MFQoW1rQsTXVTuU1JJaeXYARRdR30puRFE81Da6oCcbW/s+fusERguKW84u
 DHeHYguu01TISt2mlX/qQrns/ld0YYGjuya5AA3tgWOUESvBUKra9RPAMOCPZoFLpLwSy6kQRk9
 3SSzk1dy+jLTibRQFCYfbqy5rgTO21/Kxpm8bcjHLGGm8r2yDRZ4SyjwRqy1KWqSPQ8AwWG7l4H
 SXMmWTIRVjzs7Imh7tzaxdoAMFl+1yhqk8EhmWcODxPZ4aCX0lRylMdDgBij73q+CHiBUyImTtl
 c7qFUZcv1tOqwbPK0+cdJ6x1fYbeWGCfL8NvWiNxRkYG0cijLn0/FCLpFqxXIEKtT7pWFwuLMsC
 ihRm3ska33XO/iC4OMUqycVbWqXrr4G3NJO39RnYoIzDBM/AJqM=
X-Received: by 2002:a05:600c:1992:b0:495:727f:40d2 with SMTP id
 5b1f17b1804b1-496c65d4947mr76909755e9.38.1785327809193; 
 Wed, 29 Jul 2026 05:23:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b0f039sm8041342f8f.18.2026.07.29.05.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:23:28 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 12:22:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
X-Gerrit-Change-Number: 1770
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1770?usp=email>
X-Gerrit-Commit: e737cb18671990dcc6dfe38f0702df123f17d50d
In-Reply-To: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
References: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkk0NTRkNTA0MGNiYWQ0ZDM3M2VlNGY5MGI4ZDY4MzIwMGQyYTRjMGU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <074e118cb1a5b1fbfee0c8eaaf14e5a2ccfda3a6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp3Jz-0005Lw-KJ
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
Content-Type: multipart/mixed; boundary="===============2128253188981459948=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2128253188981459948==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XJd/Lz9GVFc="; charset=UTF-8

--XJd/Lz9GVFc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1770?usp=3Demail

to look at the new patch set (#10)=2E
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
7 files changed, 176 insertions(+), 6 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1770/10

diff --git a=
/Changes=2Erst b/Changes=2Erst
index 080d928=2E=2E4d7a16c9 100644
--- a/Cha=
nges=2Erst
+++ b/Changes=2Erst
@@ -9,6 +9,13 @@
     measured latency and a=
dvertised weight with DNS-SRV-like semantics=2E
     Servers advertise thes=
e values with ``--server-probe-reply``=2E
 
+Probe exchange doubles as the =
start of the handshake
+    When a probing client picks a server that adver=
tises support for it,
+    the probe and its reply take the place of the cl=
ient's and server's
+    reset packets, so the client does not need a separ=
ate reset exchange
+    before the handshake=2E This saves one round trip c=
ompared with probing
+    and then connecting, and needs no extra configura=
tion=2E
+
 
 Overview of changes in 2=2E7
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/src/openvpn/i=
nit=2Ec b/src/openvpn/init=2Ec
index 1598a23=2E=2E065cc47 100644
--- a/src/=
openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3507,6 +3507,21 @@
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
index 3ff7b53=2E=2E9e758ce 100644
--- a/=
src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -197,8 +197,11 @@
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
t sockaddr_storage responder; /* address that answered (pin the connection =
to it) */
+    struct oob_probe_reply reply;      /* the values the server =
advertised */
 };
 
 /**
diff --git a/src/openvpn/oob_client=2Ec b/src/open=
vpn/oob_client=2Ec
index d53e376=2E=2Ebfc129b 100644
--- a/src/openvpn/oob_=
client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -38,6 +38,7 @@
 #include "ot=
ime=2Eh"
 #include "fdmisc=2Eh"
 #include "crypto=2Eh"
+#include "dco=2Eh"
=
 #include "error=2Eh"
 
 #include "memdbg=2Eh"
@@ -217,6 +218,13 @@
       =
  return;
     }
 
+    /* The reply's own session id (the server's statele=
ss SYN-cookie) follows the
+     * opcode byte=2E Capture it before read_co=
ntrol_auth() strips it: a client may
+     * reuse it to start the handshak=
e from this reply (the connect_lifetime
+     * advertisement)=2E */
+    s=
truct session_id server_sid;
+    memcpy(server_sid=2Eid, data + 1, SID_SIZ=
E);
+
     struct buffer buf;
     buf_set_read(&buf, data, (size_t)len);
 =

@@ -274,6 +282,8 @@
 
         results[i]=2Eresponded =3D true;
         r=
esults[i]=2Ertt_ms =3D (ms > 0) ? (unsigned int)ms : 0;
+        results[i]=
=2Eserver_sid =3D server_sid;
+        results[i]=2Eresponder =3D *from; /*=
 pin the connection to the address that answered */
         results[i]=2Er=
eply =3D reply;
         break;
     }
@@ -590,7 +600,6 @@
     {
         =
oob_probe_collect(&pc, &probe, &client_sid, &tas->tls_wrap, targets, result=
s, l->len);
     }
-    oob_probe_sockets_close(&pc);
 
     /* Log each re=
mote's outcome while results[i] still maps to array[i]=2E */
     int respo=
nded =3D 0;
@@ -609,10 +618,10 @@
                                      : r=
esults[i]=2Ereply=2Emax_latency_diff > 0 ? "server-advertised"
            =
                                                                  : "defaul=
t";
             msg(D_LOW,
-                "server-probe: %s:%s answered =
(priority %d, weight %d, rtt %u ms;"
-                " latency margin %d m=
s [%s])",
+                "server-probe: %s:%s answered (priority %d, weig=
ht %d, connect-lifetime %d s,"
+                " rtt %u ms; latency margin=
 %d ms [%s])",
                 ce->remote, ce->remote_port, results[i]=2Er=
eply=2Epriority, results[i]=2Ereply=2Eweight,
-                results[i]=
=2Ertt_ms, margin, margin_src);
+                results[i]=2Ereply=2Econne=
ct_lifetime, results[i]=2Ertt_ms, margin, margin_src);
         }
         =
else
         {
@@ -634,6 +643,69 @@
     msg(M_INFO, "server-probe: %d of =
%d remote(s) answered; connecting best-first", responded,
         l->len);=

 
+    /* If the winner advertised a connect_lifetime, its reply also serv=
ed as the
+     * server's reset: hand its probe socket and the captured co=
okie to the
+     * connection, which then starts the handshake from that r=
eply (see
+     * session_skip_to_pre_start_client)=2E Reusing that socket =
keeps the source
+     * IP+port the cookie is bound to=2E dco-win cannot h=
and a socket to the
+     * kernel, so it only gets the probe ordering=2E *=
/
+
+    /* Single-use, so the RFC's connect_lifetime expiry check is not n=
eeded yet:
+     * we probe once (c->first_time) and arm only results[0]=2E=
 */
+    bool probe_start =3D results[0]=2Eresponded && results[0]=2Ereply=
=2Econnect_lifetime > 0;
+    bool dco_win_gate =3D false;
+#if defined(_WI=
N32)
+    if (dco_enabled(&c->options))
+    {
+        probe_start =3D fal=
se;
+        dco_win_gate =3D true;
+    }
+#endif
+    if (probe_start)
+ =
   {
+        const int af_idx =3D probe_af_index(results[0]=2Eresponder=2E=
ss_family);
+        c->c2=2Eoob_probe_sd =3D pc=2Esd[af_idx];
+        pc=
=2Esd[af_idx] =3D SOCKET_UNDEFINED; /* relinquish: the connection owns it n=
ow */
+
+        CLEAR(c->c2=2Eoob_probe_remote);
+        if (results[0]=
=2Eresponder=2Ess_family =3D=3D AF_INET)
+        {
+            c->c2=2Eoo=
b_probe_remote=2Eaddr=2Ein4 =3D *(struct sockaddr_in *)(void *)&results[0]=
=2Eresponder;
+        }
+        else
+        {
+            c->c2=2Eoob_=
probe_remote=2Eaddr=2Ein6 =3D *(struct sockaddr_in6 *)(void *)&results[0]=
=2Eresponder;
+        }
+        c->c2=2Eoob_probe_client_sid =3D client_s=
id;
+        c->c2=2Eoob_probe_server_sid =3D results[0]=2Eserver_sid;
+   =
     c->c2=2Eoob_probe_resend_wkc =3D
+            (results[0]=2Ereply=2Efl=
ags & OOB_PROBE_REPLY_FLAG_RESEND_WKC) !=3D 0;
+        c->c2=2Eoob_probe_a=
dopt =3D true;
+
+        msg(D_LOW, "server-probe: starting handshake from=
 probe reply of %s:%s"
+                   " (connect-lifetime %d s)",
+   =
         l->array[0]->remote, l->array[0]->remote_port, results[0]=2Ereply=
=2Econnect_lifetime);
+    }
+    else if (results[0]=2Eresponded)
+    {
+=
        /* A server answered but we won't start the handshake from it -- sa=
y why=2E */
+        if (dco_win_gate)
+        {
+            msg(D_LOW, "=
server-probe: cannot start the handshake from a probe reply"
+             =
          " with dco-win;"
+                       " using a full handshake=
");
+        }
+        else if (results[0]=2Ereply=2Econnect_lifetime =3D=
=3D 0)
+        {
+            msg(D_LOW, "server-probe: %s:%s did not adve=
rtise a connect-lifetime"
+                       " (connect-lifetime 0); u=
sing a full handshake",
+                l->array[0]->remote, l->array[0]->=
remote_port);
+        }
+    }
+
+    /* Close any probe sockets we did no=
t hand off to the connection=2E */
+    oob_probe_sockets_close(&pc);
+
   =
  tls_auth_standalone_free(tas);
     gc_free(&gc);
 }
diff --git a/src/ope=
nvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index 44c598f=2E=2Ed8e02f2 10064=
4
--- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -249,6 +24=
9,9 @@
     bool oob_probe_adopt;
     socket_descriptor_t oob_probe_sd;
  =
   struct openvpn_sockaddr oob_probe_remote;
+    struct session_id oob_pro=
be_client_sid;  /* our probe session id (cookie was minted over it) */
+   =
 struct session_id oob_probe_server_sid;  /* the reply's session id =3D ser=
ver cookie to echo back */
+    bool oob_probe_resend_wkc;               /*=
 reply asked to complete with CONTROL_WKC_V1 (v2) */
 
     struct link_soc=
ket_actual *to_link_addr; /* IP address of remote */
     struct link_socke=
t_actual from;          /* address of incoming datagram */
diff --git a/src=
/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 9e1a6aa=2E=2Eee8c5bf 100644
--=
- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2516,6 +2516,59 @@
  =
   return session_move_pre_start(session, ks, true);
 }
 
+bool
+session_sk=
ip_to_pre_start_client(struct tls_session *session, const struct session_id=
 *client_sid,
+                                 const struct session_id *se=
rver_sid,
+                                 const struct openvpn_sockaddr *=
remote, bool resend_wkc)
+{
+    struct key_state *ks =3D &session->key[KS_=
PRIMARY];
+
+    /* Our session id must be the one used for the probe: the =
server's cookie
+     * (server_sid) is an HMAC over it, and the server re-=
derives and checks it
+     * when it validates our third packet=2E */
+   =
 session->session_id =3D *client_sid;
+    ks->session_id_remote =3D *serve=
r_sid;
+
+    struct link_socket_actual act =3D { 0 };
+    act=2Edest =3D =
*remote;
+    ks->remote_addr =3D act;
+    session->untrusted_addr =3D act=
;
+    session->burst =3D true;
+
+    /* tls-crypt-v2: the stateless serve=
r discarded the WKc after the probe, so
+     * complete the handshake with=
 P_CONTROL_WKC_V1 (drives control_packet_needs_wkc)=2E */
+    if (resend_w=
kc)
+    {
+        ks->crypto_options=2Eflags |=3D CO_RESEND_WKC;
+    }
+=

+    /* We never received the server's HARD_RESET (id 0) =E2=80=94 the pro=
be reply stood
+     * in for it=2E Acknowledge that phantom id 0 so our th=
ird packet carries an
+     * ACK together with the server session id (the =
cookie): reliable_ack_write()
+     * only emits that session id when at le=
ast one ACK is present, and the server
+     * needs it to validate the sta=
teless cookie=2E */
+    reliable_ack_acknowledge_packet_id(ks->rec_ack, 0)=
;
+
+    /* Skip one (RESET) packet in each direction, so ids start at 1 (s=
ee
+     * session_skip_to_pre_start)=2E */
+    ks->rec_reliable->packet_i=
d =3D 1;
+    session->tls_wrap=2Eopt=2Epacket_id=2Esend=2Eid =3D 1;
+
+   =
 /* Do not send our own HARD_RESET=2E Unlike the server's skip, the client =
must
+     * send first: the stateless server only replies once it sees our=
 third
+     * packet=2E session_move_pre_start(skip=3Dtrue) leaves us in S=
_PRE_START_SKIP,
+     * which only advances when a packet is *received*; i=
nstead drop to
+     * S_PRE_START with an empty send-reliable (the initial=
 packet was generated
+     * and immediately deleted), so tls_process() pr=
omotes us to S_START and
+     * sends the ClientHello without waiting for =
a server reset=2E */
+    if (!session_move_pre_start(session, ks, true))
+=
    {
+        return false;
+    }
+    ks->state =3D S_PRE_START;
+    re=
turn true;
+}
+
 /**
  * Parses the TLVs (type, length, value) in the early=
 negotiation
  */
diff --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh
in=
dex 7ddf965=2E=2Ea534007 100644
--- a/src/openvpn/ssl=2Eh
+++ b/src/openvpn=
/ssl=2Eh
@@ -576,4 +576,21 @@
 bool session_skip_to_pre_start(struct tls_se=
ssion *session, struct tls_pre_decrypt_state *state,
                      =
          struct link_socket_actual *from);
 
+/**
+ * Client counterpart o=
f session_skip_to_pre_start(): start the handshake from a
+ * server sessio=
n id (SYN-cookie) learned earlier from an OOB server probe
+ * reply, which=
 already served as the server's HARD_RESET, so we send none=2E
+ *
+ * @par=
am session     the (client) TLS session to fast-forward
+ * @param client_s=
id  session id used for the probe (the cookie is an HMAC over it)
+ * @para=
m server_sid  the server's cookie, echoed back to complete the handshake
+ =
* @param remote      the probed (pinned) server address to connect to
+ * @=
param resend_wkc  true to complete with P_CONTROL_WKC_V1 (tls-crypt-v2)
+ *=
 @return true if the session was fast-forwarded, false on failure
+ */
+boo=
l session_skip_to_pre_start_client(struct tls_session *session,
+          =
                            const struct session_id *client_sid,
+         =
                             const struct session_id *server_sid,
+        =
                              const struct openvpn_sockaddr *remote, bool r=
esend_wkc);
+
 #endif /* ifndef OPENVPN_SSL_H */

-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
G=
errit-Change-Number: 1770
Gerrit-PatchSet: 10
Gerrit-Owner: stipa <lstipako=
v@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--XJd/Lz9GVFc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #10</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
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
s changed, 176 insertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1770/10</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/Changes=2Erst b/Changes=2Erst</span><br><span>index 080d=
928=2E=2E4d7a16c9 100644</span><br><span>--- a/Changes=2Erst</span><br><spa=
n>+++ b/Changes=2Erst</span><br><span>@@ -9,6 +9,13 @@</span><br><span>    =
 measured latency and advertised weight with DNS-SRV-like semantics=2E</spa=
n><br><span>     Servers advertise these values with ``--server-probe-reply=
``=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+Probe exchange doubles as the start of the handshake</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    When a probing client picks a serv=
er that advertises support for it,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    the probe and its reply take the place of the client&#39=
;s and server&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    reset packets, so the client does not need a separate reset exchange</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    before the handsha=
ke=2E This saves one round trip compared with probing</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    and then connecting, and needs no ext=
ra configuration=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> </span><br><span> Overview of changes in 2=2E7</span><br>=
<span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvp=
n/init=2Ec</span><br><span>index 1598a23=2E=2E065cc47 100644</span><br><spa=
n>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</sp=
an><br><span>@@ -3507,6 +3507,21 @@</span><br><span>         /* Keep the ma=
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
oob=2Eh</span><br><span>index 3ff7b53=2E=2E9e758ce 100644</span><br><span>-=
-- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><b=
r><span>@@ -197,8 +197,11 @@</span><br><span> {</span><br><span>     int in=
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
: hsl(120, 100%, 40%);">+    struct sockaddr_storage responder; /* address =
that answered (pin the connection to it) */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct oob_probe_reply reply;      /* the value=
s the server advertised */</span><br><span> };</span><br><span> </span><br>=
<span> /**</span><br><span>diff --git a/src/openvpn/oob_client=2Ec b/src/op=
envpn/oob_client=2Ec</span><br><span>index d53e376=2E=2Ebfc129b 100644</spa=
n><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+++ b/src/open=
vpn/oob_client=2Ec</span><br><span>@@ -38,6 +38,7 @@</span><br><span> #incl=
ude &quot;otime=2Eh&quot;</span><br><span> #include &quot;fdmisc=2Eh&quot;<=
/span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;dco=2Eh&quot;</span><br><span> =
#include &quot;error=2Eh&quot;</span><br><span> </span><br><span> #include =
&quot;memdbg=2Eh&quot;</span><br><span>@@ -217,6 +218,13 @@</span><br><span=
>         return;</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* The reply&#39;s own session i=
d (the server&#39;s stateless SYN-cookie) follows the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * opcode byte=2E Capture it before r=
ead_control_auth() strips it: a client may</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * reuse it to start the handshake from this rep=
ly (the connect_lifetime</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * advertisement)=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct session_id server_sid;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    memcpy(server_sid=2Eid, data + 1, SID_SIZE);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   struct buffer buf;</span><br><span>     buf_set_read(&amp;buf, data, (si=
ze_t)len);</span><br><span> </span><br><span>@@ -274,6 +282,8 @@</span><br>=
<span> </span><br><span>         results[i]=2Eresponded =3D true;</span><br=
><span>         results[i]=2Ertt_ms =3D (ms &gt; 0) ? (unsigned int)ms : 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=
=2Eserver_sid =3D server_sid;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        results[i]=2Eresponder =3D *from; /* pin the connection t=
o the address that answered */</span><br><span>         results[i]=2Ereply =
=3D reply;</span><br><span>         break;</span><br><span>     }</span><br=
><span>@@ -590,7 +600,6 @@</span><br><span>     {</span><br><span>         =
oob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid, &amp;tas-&gt;tls_wr=
ap, targets, results, l-&gt;len);</span><br><span>     }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    oob_probe_sockets_close(&amp;pc);</s=
pan><br><span> </span><br><span>     /* Log each remote&#39;s outcome while=
 results[i] still maps to array[i]=2E */</span><br><span>     int responded=
 =3D 0;</span><br><span>@@ -609,10 +618,10 @@</span><br><span>             =
                         : results[i]=2Ereply=2Emax_latency_diff &gt; 0 ? &=
quot;server-advertised&quot;</span><br><span>                              =
                                                : &quot;default&quot;;</spa=
n><br><span>             msg(D_LOW,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                &quot;server-probe: %s:%s answered (priority =
%d, weight %d, rtt %u ms;&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                &quot; latency margin %d ms [%s])&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;server=
-probe: %s:%s answered (priority %d, weight %d, connect-lifetime %d s,&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &q=
uot; rtt %u ms; latency margin %d ms [%s])&quot;,</span><br><span>         =
        ce-&gt;remote, ce-&gt;remote_port, results[i]=2Ereply=2Epriority, r=
esults[i]=2Ereply=2Eweight,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                results[i]=2Ertt_ms, margin, margin_src);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                results[i]=2Ere=
ply=2Econnect_lifetime, results[i]=2Ertt_ms, margin, margin_src);</span><br=
><span>         }</span><br><span>         else</span><br><span>         {<=
/span><br><span>@@ -634,6 +643,69 @@</span><br><span>     msg(M_INFO, &quot=
;server-probe: %d of %d remote(s) answered; connecting best-first&quot;, re=
sponded,</span><br><span>         l-&gt;len);</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* If the winner advertised=
 a connect_lifetime, its reply also served as the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * server&#39;s reset: hand its probe soc=
ket and the captured cookie to the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * connection, which then starts the handshake from that=
 reply (see</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * s=
ession_skip_to_pre_start_client)=2E Reusing that socket keeps the source</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * IP+port the coo=
kie is bound to=2E dco-win cannot hand a socket to the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * kernel, so it only gets the probe=
 ordering=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Single-use, so t=
he RFC&#39;s connect_lifetime expiry check is not needed yet:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * we probe once (c-&gt;first=
_time) and arm only results[0]=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    bool probe_start =3D results[0]=2Eresponded &amp;&amp;=
 results[0]=2Ereply=2Econnect_lifetime &gt; 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    bool dco_win_gate =3D false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (dco_enabled(&amp;c-&gt;opti=
ons))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        probe_start =3D fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco_win_g=
ate =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (probe_start)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        const int af_idx =3D probe_af_index(re=
sults[0]=2Eresponder=2Ess_family);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        c-&gt;c2=2Eoob_probe_sd =3D pc=2Esd[af_idx];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        pc=2Esd[af_idx] =3D=
 SOCKET_UNDEFINED; /* relinquish: the connection owns it now */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        CLEAR(c-&gt;c2=2Eoob_probe_remote);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (results[0]=2Er=
esponder=2Ess_family =3D=3D AF_INET)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            c-&gt;c2=2Eoob_probe_remote=2Eaddr=2Ein4 =3D *(struct so=
ckaddr_in *)(void *)&amp;results[0]=2Eresponder;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            c-&gt;c2=2Eoob_probe_remote=2Eaddr=2Ein6 =3D *(struct sockadd=
r_in6 *)(void *)&amp;results[0]=2Eresponder;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        c-&gt;c2=2Eoob_probe_client_sid =3D client_sid;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_p=
robe_server_sid =3D results[0]=2Eserver_sid;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_resend_wkc =3D</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            (results[0]=2E=
reply=2Eflags &amp; OOB_PROBE_REPLY_FLAG_RESEND_WKC) !=3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_adopt=
 =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;ser=
ver-probe: starting handshake from probe reply of %s:%s&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                   &quot; (connec=
t-lifetime %d s)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            l-&gt;array[0]-&gt;remote, l-&gt;array[0]-&gt;remote_port, =
results[0]=2Ereply=2Econnect_lifetime);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    else if (results[0]=2Eresponded)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* A server answered but we won&#39;t start the handshake =
from it -- say why=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (dco_win_gate)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(D_LOW, &quot;server-probe: cannot start the handshake from=
 a probe reply&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                       &quot; with dco-win;&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                       &quot; using a full h=
andshake&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else =
if (results[0]=2Ereply=2Econnect_lifetime =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s di=
d not advertise a connect-lifetime&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                       &quot; (connect-lifetime 0); us=
ing a full handshake&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                l-&gt;array[0]-&gt;remote, l-&gt;array[0]-&gt;remot=
e_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Close any probe sockets we did not hand off to =
the connection=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    oob_probe_sockets_close(&amp;pc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>     tls_auth_standalone_free(tas);</sp=
an><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span>diff=
 --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</span><br><span>=
index 44c598f=2E=2Ed8e02f2 100644</span><br><span>--- a/src/openvpn/openvpn=
=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</span><br><span>@@ -249,=
6 +249,9 @@</span><br><span>     bool oob_probe_adopt;</span><br><span>    =
 socket_descriptor_t oob_probe_sd;</span><br><span>     struct openvpn_sock=
addr oob_probe_remote;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct session_id oob_probe_client_sid;  /* our probe session id (co=
okie was minted over it) */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct session_id oob_probe_server_sid;  /* the reply&#39;s ses=
sion id =3D server cookie to echo back */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    bool oob_probe_resend_wkc;               /* reply=
 asked to complete with CONTROL_WKC_V1 (v2) */</span><br><span> </span><br>=
<span>     struct link_socket_actual *to_link_addr; /* IP address of remote=
 */</span><br><span>     struct link_socket_actual from;          /* addres=
s of incoming datagram */</span><br><span>diff --git a/src/openvpn/ssl=2Ec =
b/src/openvpn/ssl=2Ec</span><br><span>index 9e1a6aa=2E=2Eee8c5bf 100644</sp=
an><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ss=
l=2Ec</span><br><span>@@ -2516,6 +2516,59 @@</span><br><span>     return se=
ssion_move_pre_start(session, ks, true);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+session_skip_to_pre_start_client=
(struct tls_session *session, const struct session_id *client_sid,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
     const struct session_id *server_sid,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                 const struct openvpn=
_sockaddr *remote, bool resend_wkc)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Our session id must be the one used for the pr=
obe: the server&#39;s cookie</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * (server_sid) is an HMAC over it, and the server re-derives =
and checks it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 when it validates our third packet=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    session-&gt;session_id =3D *client_sid;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;session_id_remote =
=3D *server_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct link_socket=
_actual act =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    act=2Edest =3D *remote;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ks-&gt;remote_addr =3D act;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    session-&gt;untrusted_addr =3D act;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;burst =3D true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* tls-crypt-v2: the stateless serv=
er discarded the WKc after the probe, so</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * complete the handshake with P_CONTROL_WKC_V1 (d=
rives control_packet_needs_wkc)=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (resend_wkc)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        ks-&gt;crypto_options=2Eflags |=3D CO_RESEND_WKC;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* We never received the server&#39;s HARD_RESET (id 0) =E2=80=
=94 the probe reply stood</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * in for it=2E Acknowledge that phantom id 0 so our third packet=
 carries an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * A=
CK together with the server session id (the cookie): reliable_ack_write()</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * only emits tha=
t session id when at least one ACK is present, and the server</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * needs it to validate the s=
tateless cookie=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    reliable_ack_acknowledge_packet_id(ks-&gt;rec_ack, 0);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Skip one (RESET) packet in each direction, so =
ids start at 1 (see</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * session_skip_to_pre_start)=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ks-&gt;rec_reliable-&gt;packet_id =3D 1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;tls_wrap=2Eopt=
=2Epacket_id=2Esend=2Eid =3D 1;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Do not send our own HARD_RESET=2E Unlike the server&#39;s skip, the client =
must</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * send fir=
st: the stateless server only replies once it sees our third</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * packet=2E session_move_pre_=
start(skip=3Dtrue) leaves us in S_PRE_START_SKIP,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * which only advances when a packet is *=
received*; instead drop to</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * S_PRE_START with an empty send-reliable (the initial packet w=
as generated</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
and immediately deleted), so tls_process() promotes us to S_START and</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * sends the ClientHe=
llo without waiting for a server reset=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!session_move_pre_start(session, ks, true)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ks-&gt;state =3D S_PRE_START;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Parses th=
e TLVs (type, length, value) in the early negotiation</span><br><span>  */<=
/span><br><span>diff --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh</spa=
n><br><span>index 7ddf965=2E=2Ea534007 100644</span><br><span>--- a/src/ope=
nvpn/ssl=2Eh</span><br><span>+++ b/src/openvpn/ssl=2Eh</span><br><span>@@ -=
576,4 +576,21 @@</span><br><span> bool session_skip_to_pre_start(struct tls=
_session *session, struct tls_pre_decrypt_state *state,</span><br><span>   =
                             struct link_socket_actual *from);</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Client counterpart of sessi=
on_skip_to_pre_start(): start the handshake from a</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * server session id (SYN-cookie) learned ea=
rlier from an OOB server probe</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * reply, which already served as the server&#39;s HARD_RESET, s=
o we send none=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param session  =
   the (client) TLS session to fast-forward</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param client_sid  session id used for the probe=
 (the cookie is an HMAC over it)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param server_sid  the server&#39;s cookie, echoed back to =
complete the handshake</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param remote      the probed (pinned) server address to connect to</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param resend_wkc =
 true to complete with P_CONTROL_WKC_V1 (tls-crypt-v2)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @return true if the session was fast-=
forwarded, false on failure</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ses=
sion_skip_to_pre_start_client(struct tls_session *session,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
  const struct session_id *client_sid,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                      const struct sessi=
on_id *server_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                     const struct openvpn_sockaddr *remote,=
 bool resend_wkc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> #endif /* ifndef OPENVPN_SSL_H */</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1770?usp=3Demail">change 1770</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1770?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1770 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 10 </div>
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
--XJd/Lz9GVFc=--


--===============2128253188981459948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2128253188981459948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2128253188981459948==--

