Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF102C44520
	for <openvpn-devel@archiver.kernel.org>; Mon, 20 Jul 2026 22:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=4fvy5UqZTS/fm0gIjPGP/79fr1lOuLWAhaBaDPOp/0Y=; b=kzeBxk0MW+OPB5
	9IeOBNLu//y4MQks3GY6n5p8IUAblYdAMpHNVLnuJQE5Dloj1dX4lbtOZNz0KYO/mV5BgRHzldDOU
	qcVomEdk3c78I0CGF4W0eM+Gb5v8PEw2UIsgIO3lv4zYjxiYZdHqdWs89WojNIK8qz3e2NGhnC7zr
	oaU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wlwMU-0003Cb-7V;
	Mon, 20 Jul 2026 22:21:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wlwMS-0003CU-0g
 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 22:21:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xhtBt/EoD2/F7oHHrijXy8eZg+XwKixfRTX2wDFXDFI=; b=nRK7vAbfAr3yrWkccIpImI4cP4
 rxAad7bfOh3ryyunuESnTb51Z5CVzxTOLDCvvMc77/3PJ3YDBXJ9sprF1soMLPlnBoINn77cjIijZ
 sdBuXnW+2nqqCOl/9MTJj37gZ+lwMuZSF5xtcca79AHYVbvcmaBdtyMiT/ruFiZef1y8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xhtBt/EoD2/F7oHHrijXy8eZg+XwKixfRTX2wDFXDFI=; b=X
 bKSwkeCf/N19ThOW3SyBOfWwcM8dUxl6z4oindQeZZAcQmM3tDWvyp+o+4KYIgvwmun52HuKAGA6K
 Uv77V9JK3c0k0iKlx5EI87Priiizxoe0psarXUoVqyefbHUzNX3L4XUIjkbR9+FnY8GNgGn2zANz1
 xSHlwkjY9UTNQBtI=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wlwMQ-0003Ze-71 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 22:21:19 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so80844335e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 15:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784586072; x=1785190872; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xhtBt/EoD2/F7oHHrijXy8eZg+XwKixfRTX2wDFXDFI=;
 b=f5ng76YsLRLtHL6S1wZWJB+pE7kvTLUUSg5jhT6/4GTbXXCmzq1jKJsj6xE7KH4C/a
 oZ/eMQTxCyF8ZxUiS2TFmP24/ZyxzP1tunDe0EwljyDJoao2YacIps2mTa6GXcK+aMMt
 nMV3JR/pWDgWZEjUudIzb1d9zz377UqdMsKSoHjVfuRUJYBjWRtC3y9IOtxWHcv64PZ8
 OSJgiI5Kn28SLUCauyx0whz3IW6DuFaGw8sX4bOIW4+bc3VRiohkxgUEgMsIQ6hYaCIG
 bhF8iP5yAWk9jUMsnejnKbXGdDI44v5bLr9fiLJ+BBWmGd+xliDxC8pAOlPHnVdX7fCP
 hEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784586072; x=1785190872;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xhtBt/EoD2/F7oHHrijXy8eZg+XwKixfRTX2wDFXDFI=;
 b=nghBNCsLZxaqnlikxMg65CJM6kGLVskbAn2At56riibB3j+wXFAGJhLvgkYulTL1kI
 jAD3psUlG0wcqUuqGHZYOX/IQ8uMuR4pLhUuNWe6CGdAKV4Gvq8aS6pH+0xHOEt46dr4
 DtqiEZHVIIKITsTGkcgIFosSCvZWA4pgZrEIUWMRgxIXyfYovJDiLE0qoWyON1s9BghM
 WnfEhrN52b2gcBwIk/SqA2X4wZopr3pHDDWkg7Vpnsl4zQ58g488Owx+/PzQGyhEU3mH
 qGJn5hbpyNMmsfqhvZKiUV5qao1zAEHrOoh78Q0fnqJ4D0epMDtjpfpphRzH+vYSCesW
 +lKw==
X-Gm-Message-State: AOJu0YzcO0Nyn7pezVG8dGPiMa00/m+11faWUPhnSEjHBeyiXAQwKFiz
 c3HIGY8NtLAjGQtN2MrpW9Rc80imwLU1sw8lR7kztS7TA0wtQjU2VKOZFR3uYWPkOAf8BGWAcu7
 4FZFNPA2PQ6aSHDBRjqKR2qtt9TD3vezWRXwLuUBb3Sv50xIcw5olRLl6FXDyiMyWKPv5P792cB
 HgDUkT4Q==
X-Gm-Gg: AfdE7cmjsC4lqTD4mOD1hNeq9rGfmU+YJWrkqIoH8gIh8VvfHXWQaXUz46go2aZSDid
 QaTJFU7wLVM9E14SsMc1juc5XAf2RgZ2jofKdT4Uk8c8ZRgtf1wIvTsyYO64Ysd/mIWhWdU/yoJ
 td6JHAinqDj95e9tlRIwAjOnR6qL16stIyiHZ2zZr0r7fXnsEaIImL6kXV+L5F677oq03kjgQLQ
 S0+cuHRmR3ESLyaS/pgpgrBixHCwLEnt+kM2cwe8QZ8Alicmrr3LgDUjlJfDHfSdu+HsKf/xjOY
 usduBlusgXnKJ5nCsUlbltVhcxq/GL7xwBYw7c7sRbHyZ+cfvgdrL5OxEXZKDHZbLGVyv8IXxi3
 EoC2BhSzX4bEVOdi0EvVGdkABExYZcIjgrfeZZ6U1abfj/7PPT9Ay42/x2RVQsbAT2SP7GE4Cpq
 XFzqAMoPAlJa/u1ksJ3fkPh+hFuYnViDxSRaX4GjOVnQbZpCDtRHu6WH53KcdcILEOVJx9Qrncc
 aRA4Gd+PQmSUSI+ewOgAnGdUIBECB/EqOfMGIdyXczrMKw4lNIKjLM7aDxyHd1ucT8R
X-Received: by 2002:a05:600c:c10c:b0:495:56d4:3077 with SMTP id
 5b1f17b1804b1-49556d432b4mr124891205e9.17.1784586071369; 
 Mon, 20 Jul 2026 15:21:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956541e2fbsm18870475e9.0.2026.07.20.15.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 15:21:11 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 20 Jul 2026 22:21:10 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
X-Gerrit-Change-Number: 1797
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1797?usp=email>
X-Gerrit-Commit: 0ce327878bdd991c5a45c1b08ed1bb593d477975
References: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NTg2MDY2MDAwLkk0MzRhNTM3M2Y3N2IwZjc1NzBhNmEyYWFmZTBlYWY5NzBlMmVhYmU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <acb195b28cf8f8e41f11474235f604d0cebf32e4-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wlwMQ-0003Ze-71
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Enable TCP_NODELAY
 by default and deprecate --tcp-nodelay
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8974514567533749546=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8974514567533749546==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wza3yezEvCU="; charset=UTF-8

--wza3yezEvCU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1797?usp=3Demail

to review the following change=2E


Chang=
e subject: Enable TCP_NODELAY by default and deprecate --tcp-nodelay
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Enable TCP_NODELAY =
by default and deprecate --tcp-nodelay

TCP_NODELAY disables Nagle's algori=
thm, which is
beneficial for tunnelled traffic and has long been
recommende=
d for OpenVPN over TCP=2E Until now it had
to be requested explicitly via -=
-tcp-nodelay or
"socket-flags TCP_NODELAY"=2E

Set SF_TCP_NODELAY unconditi=
onally on every TCP
socket so the flag is always applied
(socket_set_flags =
still skips it on dco-win and
non-TCP transports)=2E

With the flag always =
on, --tcp-nodelay is deprecated=2E

Measured over a p2p TCP tunnel: bulk th=
roughput is
unchanged (~1=2E7 Gbit/s, within 0=2E4%), while
small-packet in=
teractive latency improves sharply
where Nagle bites: a request/response tu=
rn that
spans several packets drops from ~82 ms to ~0=2E03 ms
round-trip=2E=
 A turn of a single packet stays fast
with or without TCP_NODELAY, as Nagle=
 cannot delay
a lone packet=2E

Change-Id: I434a5373f77b0f7570a6a2aafe0eaf9=
70e2eabe7
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M =
doc/man-sections/link-options=2Erst
M src/openvpn/helper=2Ec
M src/openvpn/=
helper=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/openvp=
n/socket=2Ec
6 files changed, 21 insertions(+), 66 deletions(-)



  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/97/1797/1

diff =
--git a/doc/man-sections/link-options=2Erst b/doc/man-sections/link-options=
=2Erst
index df8c917=2E=2Ece7200f 100644
--- a/doc/man-sections/link-option=
s=2Erst
+++ b/doc/man-sections/link-options=2Erst
@@ -465,24 +465,19 @@
   =
trying to group several smaller packets into a larger packet=2E  This can
 =
  result in a considerably improvement in latency=2E
 
-  This option is pu=
shable from server to client, and should be used on
-  both client and serv=
er for maximum effect=2E
+  Since OpenVPN 2=2E7 :code:`TCP_NODELAY` is enab=
led by default on every TCP
+  socket, so specifying it here is no longer n=
ecessary=2E
 
 --tcp-nodelay
-  This macro sets the :code:`TCP_NODELAY` soc=
ket flag on the server as well
-  as pushes it to connecting clients=2E The=
 :code:`TCP_NODELAY` flag disables
-  the Nagle algorithm on TCP sockets ca=
using packets to be transmitted
-  immediately with low latency, rather tha=
n waiting a short period of time
-  in order to aggregate several packets i=
nto a larger containing packet=2E
-  In VPN applications over TCP, :code:`T=
CP_NODELAY` is generally a good
-  latency optimization=2E
+  (DEPRECATED) =
The :code:`TCP_NODELAY` socket flag is now enabled by default
+  on every T=
CP socket, so this option no longer has any effect and is
+  ignored=2E
 
-=
  The macro expands as follows:
-  ::
-
-     if mode server:
-         soc=
ket-flags TCP_NODELAY
-         push "socket-flags TCP_NODELAY"
+  :code:`T=
CP_NODELAY` disables the Nagle algorithm on TCP sockets, causing
+  packets=
 to be transmitted immediately with low latency, rather than
+  waiting a s=
hort period of time in order to aggregate several packets into
+  a larger =
containing packet=2E In VPN applications over TCP this is generally
+  a go=
od latency optimization=2E
 
 --max-packet-size size
   This option will in=
struct OpenVPN to try to limit the maximum on-write packet
diff --git a/src=
/openvpn/helper=2Ec b/src/openvpn/helper=2Ec
index 4c540a6=2E=2Ebe2e246 100=
644
--- a/src/openvpn/helper=2Ec
+++ b/src/openvpn/helper=2Ec
@@ -99,14 +99=
,6 @@
     return BSTR(&out);
 }
 
-static const char *
-print_str(const ch=
ar *str, struct gc_arena *gc)
-{
-    struct buffer out =3D alloc_buf_gc(12=
8, gc);
-    buf_printf(&out, "%s", str);
-    return BSTR(&out);
-}
-
 sta=
tic void
 helper_add_route(const in_addr_t network, const in_addr_t netmask=
, struct options *o)
 {
@@ -587,32 +579,3 @@
         }
     }
 }
-
-/*
- *=

- * HELPER DIRECTIVE:
- *
- * tcp-nodelay
- *
- * EXPANDS TO:
- *
- * if m=
ode server:
- *   socket-flags TCP_NODELAY
- *   push "socket-flags TCP_NOD=
ELAY"
- */
-void
-helper_tcp_nodelay(struct options *o)
-{
-    if (o->serv=
er_flags & SF_TCP_NODELAY_HELPER)
-    {
-        if (o->mode =3D=3D MODE_S=
ERVER)
-        {
-            o->sockflags |=3D SF_TCP_NODELAY;
-         =
   push_option(o, print_str("socket-flags TCP_NODELAY", &o->gc), M_USAGE);
=
-        }
-        else
-        {
-            o->sockflags |=3D SF_TCP_N=
ODELAY;
-        }
-    }
-}
diff --git a/src/openvpn/helper=2Eh b/src/open=
vpn/helper=2Eh
index d29257c=2E=2Ed4e7015 100644
--- a/src/openvpn/helper=
=2Eh
+++ b/src/openvpn/helper=2Eh
@@ -35,6 +35,4 @@
 
 void helper_client_s=
erver(struct options *o);
 
-void helper_tcp_nodelay(struct options *o);
-
=
 #endif
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
inde=
x 87218d4=2E=2E6fcec92 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openv=
pn/options=2Ec
@@ -486,8 +486,7 @@
     "                  virtual address =
table to v=2E\n"
     "--bcast-buffers n : Allocate n broadcast buffers=2E\=
n"
     "--tcp-queue-limit n : Maximum number of queued TCP output packets=
=2E\n"
-    "--tcp-nodelay   : Macro that sets TCP_NODELAY socket flag on t=
he server\n"
-    "                  as well as pushes it to connecting cli=
ents=2E\n"
+    "--tcp-nodelay   : (DEPRECATED) TCP_NODELAY is now enabled =
by default=2E\n"
     "--learn-address cmd : Run command cmd to validate cl=
ient virtual addresses=2E\n"
     "--connect-freq n s : Allow a maximum of =
n new connections per s seconds=2E\n"
     "--connect-freq-initial n s : Al=
low a maximum of n replies for initial connections attempts per s seconds=
=2E\n"
@@ -2644,12 +2643,6 @@
                       "verify-client-cert");=

         MUST_BE_FALSE(options->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME, =
"username-as-common-name");
         MUST_BE_FALSE(options->ssl_flags & SSL=
F_AUTH_USER_PASS_OPTIONAL, "auth-user-pass-optional");
-        if (options=
->server_flags & SF_TCP_NODELAY_HELPER)
-        {
-            msg(M_WARN,=
 "WARNING: setting tcp-nodelay on the client side will not "
-             =
           "affect the server=2E To have TCP_NODELAY in both direction use =
"
-                        "tcp-nodelay in the server configuration instead=
=2E");
-        }
         MUST_BE_UNDEF(auth_user_pass_verify_script, "aut=
h-user-pass-verify");
         MUST_BE_UNDEF(auth_token_generate, "auth-gen=
-token");
 #if PORT_SHARE
@@ -3769,7 +3762,6 @@
     /* must be called afte=
r helpers that might set --mode */
     helper_setdefault_topology(o);
    =
 helper_keepalive(o);
-    helper_tcp_nodelay(o);
 
     if (o->mode =3D=3D=
 MODE_SERVER)
     {
@@ -7715,7 +7707,8 @@
     else if (streq(p[0], "tcp-n=
odelay") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-     =
   options->server_flags |=3D SF_TCP_NODELAY_HELPER;
+        msg(M_WARN, "=
DEPRECATED OPTION: --tcp-nodelay is now the default and "
+                =
    "the option is ignored=2E");
     }
     else if (streq(p[0], "stale-ro=
utes-check") && p[1] && !p[3])
     {
diff --git a/src/openvpn/options=2Eh =
b/src/openvpn/options=2Eh
index a111cf8=2E=2E7aa7928 100644
--- a/src/openv=
pn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -470,8 +470,7 @@
     unsig=
ned int server_netbits_ipv6;    /* IPv6 */
 
 #define SF_NOPOOL            =
    (1 << 0)
-#define SF_TCP_NODELAY_HELPER    (1 << 1)
-#define SF_NO_PUSH=
_ROUTE_GATEWAY (1 << 2)
+#define SF_NO_PUSH_ROUTE_GATEWAY (1 << 1)
     uns=
igned int server_flags;
 
     bool server_bridge_proxy_dhcp;
diff --git a/=
src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index df2cc9e=2E=2E871bf0c =
100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -1485,6=
 +1485,13 @@
 static void
 phase2_set_socket_flags(struct link_socket *sock=
)
 {
+    /* TCP_NODELAY is enabled by default on every TCP socket (socket_=
set_flags
+     * skips it on dco-win and non-TCP transports) */
+    if (p=
roto_is_tcp(sock->info=2Eproto))
+    {
+        sock->sockflags |=3D SF_TC=
P_NODELAY;
+    }
+
     /* set misc socket parameters */
     socket_set_f=
lags(sock->sd, sock->sockflags);
 

-- 
To view, visit http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1797?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
Gerrit-Change-Num=
ber: 1797
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>

--wza3yezEvCU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1797?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">En=
able TCP_NODELAY by default and deprecate --tcp-nodelay<br><br>TCP_NODELAY =
disables Nagle&#39;s algorithm, which is<br>beneficial for tunnelled traffi=
c and has long been<br>recommended for OpenVPN over TCP=2E Until now it had=
<br>to be requested explicitly via --tcp-nodelay or<br>&quot;socket-flags T=
CP_NODELAY&quot;=2E<br><br>Set SF_TCP_NODELAY unconditionally on every TCP<=
br>socket so the flag is always applied<br>(socket_set_flags still skips it=
 on dco-win and<br>non-TCP transports)=2E<br><br>With the flag always on, -=
-tcp-nodelay is deprecated=2E<br><br>Measured over a p2p TCP tunnel: bulk t=
hroughput is<br>unchanged (~1=2E7 Gbit/s, within 0=2E4%), while<br>small-pa=
cket interactive latency improves sharply<br>where Nagle bites: a request/r=
esponse turn that<br>spans several packets drops from ~82 ms to ~0=2E03 ms<=
br>round-trip=2E A turn of a single packet stays fast<br>with or without TC=
P_NODELAY, as Nagle cannot delay<br>a lone packet=2E<br><br>Change-Id: I434=
a5373f77b0f7570a6a2aafe0eaf970e2eabe7<br>Signed-off-by: Antonio Quartulli &=
lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M doc/man-sections/link-options=2E=
rst<br>M src/openvpn/helper=2Ec<br>M src/openvpn/helper=2Eh<br>M src/openvp=
n/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/socket=2Ec<br>6=
 files changed, 21 insertions(+), 66 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/97/179=
7/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/doc/man-sections/link-options=2Erst b/doc/man-sect=
ions/link-options=2Erst</span><br><span>index df8c917=2E=2Ece7200f 100644</=
span><br><span>--- a/doc/man-sections/link-options=2Erst</span><br><span>++=
+ b/doc/man-sections/link-options=2Erst</span><br><span>@@ -465,24 +465,19 =
@@</span><br><span>   trying to group several smaller packets into a larger=
 packet=2E  This can</span><br><span>   result in a considerably improvemen=
t in latency=2E</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  This option is pushable from server to client, and should be =
used on</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  both client =
and server for maximum effect=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  Since OpenVPN 2=2E7 :code:`TCP_NODELAY` is enabled by defaul=
t on every TCP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  soc=
ket, so specifying it here is no longer necessary=2E</span><br><span> </spa=
n><br><span> --tcp-nodelay</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  This macro sets the :code:`TCP_NODELAY` socket flag on the server as=
 well</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  as pushes it t=
o connecting clients=2E The :code:`TCP_NODELAY` flag disables</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  the Nagle algorithm on TCP socket=
s causing packets to be transmitted</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  immediately with low latency, rather than waiting a short p=
eriod of time</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  in ord=
er to aggregate several packets into a larger containing packet=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  In VPN applications over TCP=
, :code:`TCP_NODELAY` is generally a good</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  latency optimization=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  (DEPRECATED) The :code:`TCP_NODELAY` socket fla=
g is now enabled by default</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  on every TCP socket, so this option no longer has any effect and =
is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ignored=2E</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The ma=
cro expands as follows:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  ::</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-     if mode server:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-         socket-flags TCP_NODELAY</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-         push &quot;socke=
t-flags TCP_NODELAY&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  :code:`TCP_NODELAY` disables the Nagle algorithm on TCP sockets, ca=
using</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  packets to b=
e transmitted immediately with low latency, rather than</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  waiting a short period of time in ord=
er to aggregate several packets into</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  a larger containing packet=2E In VPN applications over T=
CP this is generally</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  a good latency optimization=2E</span><br><span> </span><br><span> --max-=
packet-size size</span><br><span>   This option will instruct OpenVPN to tr=
y to limit the maximum on-write packet</span><br><span>diff --git a/src/ope=
nvpn/helper=2Ec b/src/openvpn/helper=2Ec</span><br><span>index 4c540a6=2E=
=2Ebe2e246 100644</span><br><span>--- a/src/openvpn/helper=2Ec</span><br><s=
pan>+++ b/src/openvpn/helper=2Ec</span><br><span>@@ -99,14 +99,6 @@</span><=
br><span>     return BSTR(&amp;out);</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-static const char *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-print_str(const char *str=
, struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer o=
ut =3D alloc_buf_gc(128, gc);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    buf_printf(&amp;out, &quot;%s&quot;, str);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return BSTR(&amp;out);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> static void</span><br><span> helper_add=
_route(const in_addr_t network, const in_addr_t netmask, struct options *o)=
</span><br><span> {</span><br><span>@@ -587,32 +579,3 @@</span><br><span>  =
       }</span><br><span>     }</span><br><span> }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * HELPER DIRECTIVE:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * tcp-nodelay</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* EXPANDS TO:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * if mode server:</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *   socket-flags TCP_NODELAY<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   push &quot;socket=
-flags TCP_NODELAY&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-helper_tcp_nodelay(struct option=
s *o)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;server_flags &amp; SF_=
TCP_NODELAY_HELPER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (o-&gt;=
mode =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   o-&gt;sockflags |=3D SF_TCP_NODELAY;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            push_option(o, print_str(&quot;socket-flags T=
CP_NODELAY&quot;, &amp;o-&gt;gc), M_USAGE);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 o-&gt;sockflags |=3D SF_TCP_NODELAY;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span>diff --git a/src/openvpn/helper=2Eh b/src/openvpn/helper=2Eh</span><b=
r><span>index d29257c=2E=2Ed4e7015 100644</span><br><span>--- a/src/openvpn=
/helper=2Eh</span><br><span>+++ b/src/openvpn/helper=2Eh</span><br><span>@@=
 -35,6 +35,4 @@</span><br><span> </span><br><span> void helper_client_serve=
r(struct options *o);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-void helper_tcp_nodelay(struct options *o);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif</span><br>=
<span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span>=
<br><span>index 87218d4=2E=2E6fcec92 100644</span><br><span>--- a/src/openv=
pn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><spa=
n>@@ -486,8 +486,7 @@</span><br><span>     &quot;                  virtual =
address table to v=2E\n&quot;</span><br><span>     &quot;--bcast-buffers n =
: Allocate n broadcast buffers=2E\n&quot;</span><br><span>     &quot;--tcp-=
queue-limit n : Maximum number of queued TCP output packets=2E\n&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;--tcp-nodelay   =
: Macro that sets TCP_NODELAY socket flag on the server\n&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    &quot;                  as we=
ll as pushes it to connecting clients=2E\n&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &quot;--tcp-nodelay   : (DEPRECATED) TCP_N=
ODELAY is now enabled by default=2E\n&quot;</span><br><span>     &quot;--le=
arn-address cmd : Run command cmd to validate client virtual addresses=2E\n=
&quot;</span><br><span>     &quot;--connect-freq n s : Allow a maximum of n=
 new connections per s seconds=2E\n&quot;</span><br><span>     &quot;--conn=
ect-freq-initial n s : Allow a maximum of n replies for initial connections=
 attempts per s seconds=2E\n&quot;</span><br><span>@@ -2644,12 +2643,6 @@</=
span><br><span>                       &quot;verify-client-cert&quot;);</spa=
n><br><span>         MUST_BE_FALSE(options-&gt;ssl_flags &amp; SSLF_USERNAM=
E_AS_COMMON_NAME, &quot;username-as-common-name&quot;);</span><br><span>   =
      MUST_BE_FALSE(options-&gt;ssl_flags &amp; SSLF_AUTH_USER_PASS_OPTIONA=
L, &quot;auth-user-pass-optional&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (options-&gt;server_flags &amp; SF_TCP_NODELA=
Y_HELPER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, =
&quot;WARNING: setting tcp-nodelay on the client side will not &quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                        &qu=
ot;affect the server=2E To have TCP_NODELAY in both direction use &quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
&quot;tcp-nodelay in the server configuration instead=2E&quot;);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span>      =
   MUST_BE_UNDEF(auth_user_pass_verify_script, &quot;auth-user-pass-verify&=
quot;);</span><br><span>         MUST_BE_UNDEF(auth_token_generate, &quot;a=
uth-gen-token&quot;);</span><br><span> #if PORT_SHARE</span><br><span>@@ -3=
769,7 +3762,6 @@</span><br><span>     /* must be called after helpers that =
might set --mode */</span><br><span>     helper_setdefault_topology(o);</sp=
an><br><span>     helper_keepalive(o);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    helper_tcp_nodelay(o);</span><br><span> </span><br><sp=
an>     if (o-&gt;mode =3D=3D MODE_SERVER)</span><br><span>     {</span><br=
><span>@@ -7715,7 +7707,8 @@</span><br><span>     else if (streq(p[0], &quo=
t;tcp-nodelay&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><sp=
an>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        options-&gt;server_flags |=3D SF_TCP_NODELA=
Y_HELPER;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(M_WARN, &quot;DEPRECATED OPTION: --tcp-nodelay is now the default and &qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    &quot;the option is ignored=2E&quot;);</span><br><span>     }</span><br=
><span>     else if (streq(p[0], &quot;stale-routes-check&quot;) &amp;&amp;=
 p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>diff --git a=
/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index a1=
11cf8=2E=2E7aa7928 100644</span><br><span>--- a/src/openvpn/options=2Eh</sp=
an><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -470,8 +470,7=
 @@</span><br><span>     unsigned int server_netbits_ipv6;    /* IPv6 */</s=
pan><br><span> </span><br><span> #define SF_NOPOOL                (1 &lt;&l=
t; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SF_TCP_N=
ODELAY_HELPER    (1 &lt;&lt; 1)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define SF_NO_PUSH_ROUTE_GATEWAY (1 &lt;&lt; 2)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define SF_NO_PUSH_ROUTE_GATEWAY (1 &=
lt;&lt; 1)</span><br><span>     unsigned int server_flags;</span><br><span>=
 </span><br><span>     bool server_bridge_proxy_dhcp;</span><br><span>diff =
--git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>ind=
ex df2cc9e=2E=2E871bf0c 100644</span><br><span>--- a/src/openvpn/socket=2Ec=
</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -1485,6 +1=
485,13 @@</span><br><span> static void</span><br><span> phase2_set_socket_f=
lags(struct link_socket *sock)</span><br><span> {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* TCP_NODELAY is enabled by default on e=
very TCP socket (socket_set_flags</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * skips it on dco-win and non-TCP transports) */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (proto_is_tcp(sock-&=
gt;info=2Eproto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sock-&gt=
;sockflags |=3D SF_TCP_NODELAY;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     /* set misc socket parameters */</span><br><span>     s=
ocket_set_flags(sock-&gt;sd, sock-&gt;sockflags);</span><br><span> </span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1797?usp=3Demail">change 1797</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1797?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I434a5373f77b0f7570a6a2aaf=
e0eaf970e2eabe7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
797 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>

</body></html>
--wza3yezEvCU=--


--===============8974514567533749546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8974514567533749546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8974514567533749546==--

