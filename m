Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA11CC61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 07:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BVIJ9MzH0LdDhWaVuPS521JnVhJH5MENNHPVG83J220=; b=VIaQJvL+k3N0Fi+ydCHqXHYjnh
	/FV4lJDF43UuxHHGr3jJDx8ftY6Pycuz7GAK3EHuBmlQnwVHTm3qqZb1eGTqYcxhdzo/cIi+OjosK
	VYXmcP0jaARMfFm8rSvJYMZ712fUwmIWoriO8bSS+JgYUtNIkeElmBfi4vhBMpo6zgYQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz7zR-00006M-ER;
	Wed, 26 Aug 2026 07:24:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wz7zQ-00006B-5c
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 07:24:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sI6F4nU2k3HK1NrEdbwdWFPdMTCuoywf/XbWRJiOlro=; b=iIeih8JDGqvD/VLf77A7CGdD8J
 QQK1k1t+OHxhvkCfZnxFYEGZA8tefL5AUyfNhQBhm1GbddUZS3xlEOEF5MCSHqiOgEBwYN9IubZ6Q
 Ug+5+QRmQ2qkRobnHUrY0v0celLUyh5w7OFjlQ4CaC0yi0beKTWtqw3QCcCT+YS8WMa8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sI6F4nU2k3HK1NrEdbwdWFPdMTCuoywf/XbWRJiOlro=; b=l
 PF2JIfAbffuV3VyUPT1rB12d+yV8KSAFXHDU0jtj0azpNDaFFne/kthSR3ZEj+FzpVxqWfHDFtUZU
 YcY6kE8PS3V1YkwADHm0RLSggnKapOlSEIW7LklU0lRrCiOwfH7fzouGmlXHfBuZBmKu33fANcxgY
 DHH40h8wRQ3Ry6yQ=;
Received: from mail-ej1-f46.google.com ([209.85.218.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz7zO-0008QT-Ph for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 07:24:04 +0000
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c25099bb1fbso73072066b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 00:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787729036; x=1788333836; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sI6F4nU2k3HK1NrEdbwdWFPdMTCuoywf/XbWRJiOlro=;
 b=FTmV/lC0/oT7jGR9C2PB/s/z5/5XrQ5sK1YYDfp15CQO/1aKWZ8pl47Ggak+fVSDHQ
 /0vfw5J6lKhrY7OcFJdMteLDqdeX8UfnyTRLo3/xuxpbfRphmjOsScW44wpNg2NxaLBk
 u7+wxTyQhtFnDhtOM0eeRxjgzqvAnwUzRml0YoMcIbYisRLS+3cYhwF6fAt1tJ/69/6Z
 nJK/L8LBHHqenuJFLlOkN1cdRRHjgK1D4vYBSfoe6uHo7SDINHZ6ZAux6wB5xmUxx381
 jv8EZc7+RU6wb/Q8RFjTTvBDuMI5U/gQXuAPJDwqXc1wGSfr6j/gGqjO1C0UcopQWTzz
 5Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787729036; x=1788333836;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sI6F4nU2k3HK1NrEdbwdWFPdMTCuoywf/XbWRJiOlro=;
 b=hIJ2kWEVBQav+y6NDG9P4bXbXCyavDyIBWNdP+JTdb1dma4jWLNIK3d+AEqtZF3abi
 gJ0U/8aIfkQcYQOkcRqml58VhnqZnYdkQlw9zIaHu5hkbTCzZA4yzpiHP43d6c/4vUjL
 QqwumNB8t4TOiJWE7FpiodhRCibu84DeaE+UWQySC4+BzClmQ0Tme3wf5wxi89plGYh/
 IO2PHZjqSqv3AVMfe/Zc7Qz+9wBVCD6pI+HdNrFibaTfxcDa7qrOjzjn0yvoj00zx6Ul
 IC9i6oFomc70U7T+Ayf3MgY/oWYtHyVwnHz6BLPQdwajv4e6vTb3FpgBmNQlzxh5D0Ze
 X6Xw==
X-Gm-Message-State: AFuF++lW7MbCkOIGWbp1AQEe4L5vRdntwetIBsqQPhI00MHGca/2AHbv
 lc9FqcigBgcJpuZksbRnzddHnEfb5PAwCh0zHic+SuC3aHjm+xsBuyQOLMiIUA1oSpXIYpsfsZR
 QiF+81O7uGRxLGe3+apmPydTKJ8iSMvRNUKrXuMaTZ8Z/IgmBv6jZe6gmuZSh0Ph6Esie
X-Gm-Gg: AR+sD13EsfPWH6JMzsHwEZwqcMqFr3BRsVSIfajgidEPxDFvrRjjNi/ZmoONLOsG2TC
 XiKJBApycShrr7Y8yaXoRaWeSTJ5mR9bfyNgzOnSGFW1oukUNkIvQZ+rXTZ2edVR3PdOZS/3f4X
 qRXGV1k2bqM1rXyrrzpfls498SQLD693p0id3ofoS+kSBi2kPeNvG2Kk0gh/BzLt0AmlwNWecw6
 Ko+VrsFtQsSS1/gQch7PYBkZ1ATAjpQE+xPPlkdvOCV78B+XbN8qpfRYFGKoENkHyk0M4wWxn5F
 6e1QK84euGTfB8vCSM+iHQkUN1ekC82dYz3opVJNovs0AZJYSyyFNLX4k/mcNGVxwPWcYj6vMuj
 noK1Qk3RW9Lj7gSl53xjFqivGDFEKEIau3HkoKJPOPsWviiSyl/gSrCqBJTBGiGyOCui4IPzfRt
 CcxnajkEbuax0TeMBKjlp7cLQq0/MtFBj75Wm4W0WcXN1Ur+B3nQ8xu9aWFwjBJr+6YEt++2dY5
 2t7tmwYXgUDcCTYwRnxtfQlaG/1GosfGmCtuctN2LfDypPFJt/AJcqulR4HyKOCVYVZHB281PlE
 F564sqVtbK8SDMoqGnnctFD/K8IWv9QGmo6heKDfoYn+x48O/mH2TWaLsjk5PA==
X-Received: by 2002:a17:907:3e90:b0:c24:d430:3929 with SMTP id
 a640c23a62f3a-c250bb05b51mr578613866b.1.1787728994043; 
 Wed, 26 Aug 2026 00:23:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9ef92csm341210566b.63.2026.08.26.00.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 00:23:13 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 07:23:10 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I7be7427480d3540d43dd818eddb6eb5860956459
X-Gerrit-Change-Number: 1476
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1476?usp=email>
X-Gerrit-Commit: 0d257840e2130815376f94006b4b2671983109d9
In-Reply-To: <gerrit.1768578994000.I7be7427480d3540d43dd818eddb6eb5860956459@gerrit.openvpn.net>
References: <gerrit.1768578994000.I7be7427480d3540d43dd818eddb6eb5860956459@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY4NTc4OTk0MDAwLkk3YmU3NDI3NDgwZDM1NDBkNDNkZDgxOGVkZGI2ZWI1ODYwOTU2NDU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8c6e5041f564a198b5fa5e76eac689ac70cb0b3a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wz7zO-0008QT-Ph
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: Fix various
 conversion warnings
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7940515062671380733=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7940515062671380733==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ca6oceWfkzs="; charset=UTF-8

--ca6oceWfkzs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#11) to the change originally created b=
y flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Dem=
ail )

The following approvals got outdated and were removed:
Code-Review+2=
 by razvanc


Change subject: socket: Fix various conversion warnings
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket: Fix vari=
ous conversion warnings

- We assume that addrinfo->ai_family always fits
 =
 into a sa_family_t, so we do not check those=2E
- Reduce places where we e=
xplicitly pass ai_family
  and prefer sock->info=2Eaf=2E
- Make sure that -=
-bind-dev has a suitable length=2E
- Treat PROTO_* as uint8_t where possibl=
e (however,
  much code uses proto =3D -1 for various error handling)=2E

C=
hange-Id: I7be7427480d3540d43dd818eddb6eb5860956459
Signed-off-by: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476
Mess=
age-Id: <20260824160553=2E761-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38632=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
options=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/socket_util=2Ec
3 files =
changed, 30 insertions(+), 40 deletions(-)


  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/76/1476/11

diff --git a/src/openvpn/o=
ptions=2Ec b/src/openvpn/options=2Ec
index 23741f0=2E=2E5f3f4e9 100644
--- =
a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -5125,7 +5125,15=
 @@
     else if (streq(p[0], "bind-dev") && p[1])
     {
         VERIFY_P=
ERMISSION(OPT_P_SOCKFLAGS);
-        options->bind_dev =3D p[1];
+        i=
f (strlen(p[1]) < IFNAMSIZ)
+        {
+            options->bind_dev =3D p=
[1];
+        }
+        else
+        {
+            msg(msglevel, "argume=
nt to --bind-dev is longer than allowed %u", IFNAMSIZ - 1);
+            go=
to err;
+        }
     }
 #endif
     else if (streq(p[0], "txqueuelen") &=
& p[1] && !p[2])
@@ -5211,11 +5219,9 @@
     }
     else if (streq(p[0], "p=
roto") && p[1] && !p[2])
     {
-        int proto;
-        sa_family_t af=
;
         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
-        pr=
oto =3D ascii2proto(p[1]);
-        af =3D ascii2af(p[1]);
+        int pro=
to =3D ascii2proto(p[1]);
+        sa_family_t af =3D ascii2af(p[1]);
     =
    if (proto < 0)
         {
             msg(msglevel, "Bad protocol: '%s=
'=2E Allowed protocols with --proto option: %s", p[1],
diff --git a/src/ope=
nvpn/socket=2Ec b/src/openvpn/socket=2Ec
index fba0a22=2E=2E7c6217a 100644
=
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -619,28 +619,2=
3 @@
 }
 
 static void
-bind_local(struct link_socket *sock, const sa_famil=
y_t ai_family)
+bind_local(struct link_socket *sock)
 {
     /* bind to loc=
al address/port */
     if (sock->bind_local)
     {
         if (sock->soc=
ks_proxy && sock->info=2Eproto =3D=3D PROTO_UDP)
         {
-            so=
cket_bind(sock->ctrl_sd, sock->info=2Elsa->bind_local, ai_family, "SOCKS", =
false);
+            socket_bind(sock->ctrl_sd, sock->info=2Elsa->bind_loca=
l, sock->info=2Eaf, "SOCKS", false);
         }
         else
         {
- =
           socket_bind(sock->sd, sock->info=2Elsa->bind_local, ai_family, "=
TCP/UDP",
+            socket_bind(sock->sd, sock->info=2Elsa->bind_local, =
sock->info=2Eaf, "TCP/UDP",
                         sock->info=2Ebind_ipv6=
_only);
         }
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)=

-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion=
"
-#endif
-
 static void
 create_socket(struct link_socket *sock, struct ad=
drinfo *addr)
 {
@@ -672,7 +667,7 @@
     }
     /* Set af field of sock->i=
nfo, so it always reflects the address family
      * of the created socket=
 */
-    sock->info=2Eaf =3D addr->ai_family;
+    sock->info=2Eaf =3D (sa_=
family_t)addr->ai_family;
 
     /* set socket buffers based on --sndbuf an=
d --rcvbuf options */
     socket_set_buffers(sock->sd, &sock->socket_buffe=
r_sizes, true);
@@ -684,8 +679,9 @@
     if (sock->bind_dev)
     {
       =
  msg(M_INFO, "Using bind-dev %s", sock->bind_dev);
+        /* Note: We ve=
rify strlen of bind_dev in options parsing */
         if (setsockopt(sock-=
>sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_dev,
-                       s=
trlen(sock->bind_dev) + 1)
+                       (socklen_t)(strlen(sock-=
>bind_dev) + 1))
             !=3D 0)
         {
             msg(M_WARN | =
M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=3D%s failed", sock->bind_dev);
@=
@ -693,13 +689,9 @@
     }
 #endif
 
-    bind_local(sock, addr->ai_family)=
;
+    bind_local(sock);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
=
-#pragma GCC diagnostic pop
-#endif
-
 #ifdef TARGET_ANDROID
 static void
 =
protect_fd_nonlocal(int fd, const struct sockaddr *addr)
@@ -1129,13 +1121,=
8 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC =
diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 s=
tatic void
-resolve_bind_local(struct link_socket *sock, const sa_family_t =
af)
+resolve_bind_local(struct link_socket *sock)
 {
     struct gc_arena g=
c =3D gc_new();
 
@@ -1151,12 +1138,12 @@
         }
 
         /* will ret=
urn AF_{INET|INET6}from local_host */
-        status =3D get_cached_dns_en=
try(sock->dns_cache, sock->local_host, sock->local_port, af,
+        statu=
s =3D get_cached_dns_entry(sock->dns_cache, sock->local_host, sock->local_p=
ort, sock->info=2Eaf,
                                       flags, &sock->=
info=2Elsa->bind_local);
 
         if (status)
         {
-            sta=
tus =3D openvpn_getaddrinfo(flags, sock->local_host, sock->local_port, 0, N=
ULL, af,
+            status =3D openvpn_getaddrinfo(flags, sock->local_hos=
t, sock->local_port, 0, NULL, sock->info=2Eaf,
                            =
              &sock->info=2Elsa->bind_local);
         }
 
@@ -1177,7 +1164=
,7 @@
             /* the resolved 'local entry' might have a different fam=
ily than
              * what was globally configured
              */
-   =
         sock->info=2Eaf =3D sock->info=2Elsa->bind_local->ai_family;
+    =
        sock->info=2Eaf =3D (sa_family_t)sock->info=2Elsa->bind_local->ai_f=
amily;
         }
     }
 
@@ -1380,7 +1367,8 @@
 
     sock->mark =3D o->m=
ark;
     sock->bind_dev =3D o->bind_dev;
-    sock->info=2Eproto =3D proto=
;
+    ASSERT(proto >=3D 0 && proto < PROTO_N);
+    sock->info=2Eproto =3D=
 (uint8_t)proto;
     sock->info=2Eaf =3D o->ce=2Eaf;
     sock->info=2Erem=
ote_float =3D o->ce=2Eremote_float;
     sock->info=2Elsa =3D &c->c1=2Elink=
_socket_addrs[sock_index];
@@ -1446,7 +1434,7 @@
     {
         if (sock->=
bind_local)
         {
-            resolve_bind_local(sock, sock->info=2Ea=
f);
+            resolve_bind_local(sock);
         }
         resolve_remo=
te(sock, 1, NULL);
     }
@@ -1711,9 +1699,9 @@
              * and we shou=
ld not connect a remote */
             if (sock->info=2Eaf =3D=3D AF_UNSPE=
C)
             {
+                sock->info=2Eaf =3D (sa_family_t)sock->i=
nfo=2Elsa->bind_local->ai_family;
                 msg(M_WARN, "Could not d=
etermine IPv4/IPv6 protocol=2E Using %s",
-                    addr_family_=
name(sock->info=2Elsa->bind_local->ai_family));
-                sock->info=
=2Eaf =3D sock->info=2Elsa->bind_local->ai_family;
+                    add=
r_family_name(sock->info=2Eaf));
             }
             create_socket(=
sock, sock->info=2Elsa->bind_local);
         }
@@ -1773,10 +1761,6 @@
    =
 }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnosti=
c pop
-#endif
-
 void
 link_socket_close(struct link_socket *sock)
 {
@@ -2=
382,8 +2366,8 @@
     else if (cmsg !=3D NULL)
     {
         msg(M_WARN,
=
-            "CMSG received that cannot be parsed (cmsg_level=3D%d, cmsg_ty=
pe=3D%d, cmsg=3Dlen=3D%d)",
-            (int)cmsg->cmsg_level, (int)cmsg->=
cmsg_type, (int)cmsg->cmsg_len);
+            "CMSG received that cannot be=
 parsed (cmsg_level=3D%d, cmsg_type=3D%d, cmsg=3Dlen=3D%zu)",
+            =
cmsg->cmsg_level, cmsg->cmsg_type, (size_t)cmsg->cmsg_len);
     }
 
     r=
eturn buf->len;
diff --git a/src/openvpn/socket_util=2Ec b/src/openvpn/sock=
et_util=2Ec
index 0194f38=2E=2E913ac69 100644
--- a/src/openvpn/socket_util=
=2Ec
+++ b/src/openvpn/socket_util=2Ec
@@ -356,7 +356,7 @@
     const char =
*short_form;
     const char *display_form;
     sa_family_t proto_af;
-   =
 int proto;
+    uint8_t proto;
 };
 
 /* Indexed by PROTO_x */

-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7be7427480d3540d43dd818eddb=
6eb5860956459
Gerrit-Change-Number: 1476
Gerrit-PatchSet: 11
Gerrit-Owner: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: flichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>

--ca6oceWfkzs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #11</strong> to the change originally created by flichtenhe=
ld=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">socket: Fix various c=
onversion warnings<br><br>- We assume that addrinfo-&gt;ai_family always fi=
ts<br>  into a sa_family_t, so we do not check those=2E<br>- Reduce places =
where we explicitly pass ai_family<br>  and prefer sock-&gt;info=2Eaf=2E<br=
>- Make sure that --bind-dev has a suitable length=2E<br>- Treat PROTO_* as=
 uint8_t where possible (however,<br>  much code uses proto =3D -1 for vari=
ous error handling)=2E<br><br>Change-Id: I7be7427480d3540d43dd818eddb6eb586=
0956459<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476<br>Message-Id: &lt;20260824=
160553=2E761-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archi=
ve=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38632=2Ehtml<br>Signed-=
off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvp=
n/options=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket_util=2Ec<=
br>3 files changed, 30 insertions(+), 40 deletions(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/76/1=
476/11</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec</span><br><span>index 23741f0=2E=2E5f3f4e9 100644</span><br><span>--- =
a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</sp=
an><br><span>@@ -5125,7 +5125,15 @@</span><br><span>     else if (streq(p[0=
], &quot;bind-dev&quot;) &amp;&amp; p[1])</span><br><span>     {</span><br>=
<span>         VERIFY_PERMISSION(OPT_P_SOCKFLAGS);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        options-&gt;bind_dev =3D p[1];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (strlen(p[1]) &l=
t; IFNAMSIZ)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            optio=
ns-&gt;bind_dev =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msgle=
vel, &quot;argument to --bind-dev is longer than allowed %u&quot;, IFNAMSIZ=
 - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            g=
oto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span>     }</span><br><span> #endif</span><br><span>     else if =
(streq(p[0], &quot;txqueuelen&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</spa=
n><br><span>@@ -5211,11 +5219,9 @@</span><br><span>     }</span><br><span> =
    else if (streq(p[0], &quot;proto&quot;) &amp;&amp; p[1] &amp;&amp; !p[2=
])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        int proto;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        sa_family_t af;</span><br><span>         VERIFY_PERMISSION(OPT_P_G=
ENERAL | OPT_P_CONNECTION);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        proto =3D ascii2proto(p[1]);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        af =3D ascii2af(p[1]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int proto =3D ascii2proto(p[1]);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sa_family_t =
af =3D ascii2af(p[1]);</span><br><span>         if (proto &lt; 0)</span><br=
><span>         {</span><br><span>             msg(msglevel, &quot;Bad prot=
ocol: &#39;%s&#39;=2E Allowed protocols with --proto option: %s&quot;, p[1]=
,</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=
=2Ec</span><br><span>index fba0a22=2E=2E7c6217a 100644</span><br><span>--- =
a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span=
><br><span>@@ -619,28 +619,23 @@</span><br><span> }</span><br><span> </span=
><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-bind_local(struct link_socket *sock, const sa_family_t ai_family)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bind_local(struct link_sock=
et *sock)</span><br><span> {</span><br><span>     /* bind to local address/=
port */</span><br><span>     if (sock-&gt;bind_local)</span><br><span>     =
{</span><br><span>         if (sock-&gt;socks_proxy &amp;&amp; sock-&gt;inf=
o=2Eproto =3D=3D PROTO_UDP)</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            socket_bind(sock-&gt;ctrl_sd, =
sock-&gt;info=2Elsa-&gt;bind_local, ai_family, &quot;SOCKS&quot;, false);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            socket_bi=
nd(sock-&gt;ctrl_sd, sock-&gt;info=2Elsa-&gt;bind_local, sock-&gt;info=2Eaf=
, &quot;SOCKS&quot;, false);</span><br><span>         }</span><br><span>   =
      else</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            socket_bind(sock-&gt;sd, sock-&gt;info=2Elsa-&g=
t;bind_local, ai_family, &quot;TCP/UDP&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            socket_bind(sock-&gt;sd, sock-&gt;inf=
o=2Elsa-&gt;bind_local, sock-&gt;info=2Eaf, &quot;TCP/UDP&quot;,</span><br>=
<span>                         sock-&gt;info=2Ebind_ipv6_only);</span><br><=
span>         }</span><br><span>     }</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> cr=
eate_socket(struct link_socket *sock, struct addrinfo *addr)</span><br><spa=
n> {</span><br><span>@@ -672,7 +667,7 @@</span><br><span>     }</span><br><=
span>     /* Set af field of sock-&gt;info, so it always reflects the addre=
ss family</span><br><span>      * of the created socket */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;info=2Eaf =3D addr-&gt;ai=
_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&g=
t;info=2Eaf =3D (sa_family_t)addr-&gt;ai_family;</span><br><span> </span><b=
r><span>     /* set socket buffers based on --sndbuf and --rcvbuf options *=
/</span><br><span>     socket_set_buffers(sock-&gt;sd, &amp;sock-&gt;socket=
_buffer_sizes, true);</span><br><span>@@ -684,8 +679,9 @@</span><br><span> =
    if (sock-&gt;bind_dev)</span><br><span>     {</span><br><span>         =
msg(M_INFO, &quot;Using bind-dev %s&quot;, sock-&gt;bind_dev);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* Note: We verify strle=
n of bind_dev in options parsing */</span><br><span>         if (setsockopt=
(sock-&gt;sd, SOL_SOCKET, SO_BINDTODEVICE, sock-&gt;bind_dev,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                       strlen(sock-=
&gt;bind_dev) + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                      (socklen_t)(strlen(sock-&gt;bind_dev) + 1))</span><br=
><span>             !=3D 0)</span><br><span>         {</span><br><span>    =
         msg(M_WARN | M_ERRNO, &quot;WARN: setsockopt SO_BINDTODEVICE=3D%s =
failed&quot;, sock-&gt;bind_dev);</span><br><span>@@ -693,13 +689,9 @@</spa=
n><br><span>     }</span><br><span> #endif</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    bind_local(sock, addr-&gt;ai_fam=
ily);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bind_local=
(sock);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef TARGET_ANDROID<=
/span><br><span> static void</span><br><span> protect_fd_nonlocal(int fd, c=
onst struct sockaddr *addr)</span><br><span>@@ -1129,13 +1121,8 @@</span><b=
r><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> static void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-resolve_bind_local(struct link_socket *sock, const sa_family_t =
af)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+resolve_bind_loc=
al(struct link_socket *sock)</span><br><span> {</span><br><span>     struct=
 gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ -1151,12 +1=
138,12 @@</span><br><span>         }</span><br><span> </span><br><span>    =
     /* will return AF_{INET|INET6}from local_host */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        status =3D get_cached_dns_entry(soc=
k-&gt;dns_cache, sock-&gt;local_host, sock-&gt;local_port, af,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        status =3D get_cached_dn=
s_entry(sock-&gt;dns_cache, sock-&gt;local_host, sock-&gt;local_port, sock-=
&gt;info=2Eaf,</span><br><span>                                       flags=
, &amp;sock-&gt;info=2Elsa-&gt;bind_local);</span><br><span> </span><br><sp=
an>         if (status)</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            status =3D openvpn_getaddrinfo(fla=
gs, sock-&gt;local_host, sock-&gt;local_port, 0, NULL, af,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            status =3D openvpn_getad=
drinfo(flags, sock-&gt;local_host, sock-&gt;local_port, 0, NULL, sock-&gt;i=
nfo=2Eaf,</span><br><span>                                          &amp;so=
ck-&gt;info=2Elsa-&gt;bind_local);</span><br><span>         }</span><br><sp=
an> </span><br><span>@@ -1177,7 +1164,7 @@</span><br><span>             /* =
the resolved &#39;local entry&#39; might have a different family than</span=
><br><span>              * what was globally configured</span><br><span>   =
           */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    sock-&gt;info=2Eaf =3D sock-&gt;info=2Elsa-&gt;bind_local-&gt;ai_family=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sock-&=
gt;info=2Eaf =3D (sa_family_t)sock-&gt;info=2Elsa-&gt;bind_local-&gt;ai_fam=
ily;</span><br><span>         }</span><br><span>     }</span><br><span> </s=
pan><br><span>@@ -1380,7 +1367,8 @@</span><br><span> </span><br><span>     =
sock-&gt;mark =3D o-&gt;mark;</span><br><span>     sock-&gt;bind_dev =3D o-=
&gt;bind_dev;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock=
-&gt;info=2Eproto =3D proto;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ASSERT(proto &gt;=3D 0 &amp;&amp; proto &lt; PROTO_N);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;info=2Eproto =
=3D (uint8_t)proto;</span><br><span>     sock-&gt;info=2Eaf =3D o-&gt;ce=2E=
af;</span><br><span>     sock-&gt;info=2Eremote_float =3D o-&gt;ce=2Eremote=
_float;</span><br><span>     sock-&gt;info=2Elsa =3D &amp;c-&gt;c1=2Elink_s=
ocket_addrs[sock_index];</span><br><span>@@ -1446,7 +1434,7 @@</span><br><s=
pan>     {</span><br><span>         if (sock-&gt;bind_local)</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   resolve_bind_local(sock, sock-&gt;info=2Eaf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            resolve_bind_local(sock);</span><b=
r><span>         }</span><br><span>         resolve_remote(sock, 1, NULL);<=
/span><br><span>     }</span><br><span>@@ -1711,9 +1699,9 @@</span><br><spa=
n>              * and we should not connect a remote */</span><br><span>   =
          if (sock-&gt;info=2Eaf =3D=3D AF_UNSPEC)</span><br><span>        =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   sock-&gt;info=2Eaf =3D (sa_family_t)sock-&gt;info=2Elsa-&gt;bind_local-&=
gt;ai_family;</span><br><span>                 msg(M_WARN, &quot;Could not =
determine IPv4/IPv6 protocol=2E Using %s&quot;,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    addr_family_name(sock-&gt;inf=
o=2Elsa-&gt;bind_local-&gt;ai_family));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                sock-&gt;info=2Eaf =3D sock-&gt;info=2Els=
a-&gt;bind_local-&gt;ai_family;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    addr_family_name(sock-&gt;info=2Eaf));</spa=
n><br><span>             }</span><br><span>             create_socket(sock,=
 sock-&gt;info=2Elsa-&gt;bind_local);</span><br><span>         }</span><br>=
<span>@@ -1773,10 +1761,6 @@</span><br><span>     }</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> void</span><br><span> link_socket_close(struct link_s=
ocket *sock)</span><br><span> {</span><br><span>@@ -2382,8 +2366,8 @@</span=
><br><span>     else if (cmsg !=3D NULL)</span><br><span>     {</span><br><=
span>         msg(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            &quot;CMSG received that cannot be parsed (cmsg_level=3D%d,=
 cmsg_type=3D%d, cmsg=3Dlen=3D%d)&quot;,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            (int)cmsg-&gt;cmsg_level, (int)cmsg-&gt;cmsg=
_type, (int)cmsg-&gt;cmsg_len);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            &quot;CMSG received that cannot be parsed (cmsg_lev=
el=3D%d, cmsg_type=3D%d, cmsg=3Dlen=3D%zu)&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            cmsg-&gt;cmsg_level, cmsg-&gt;cms=
g_type, (size_t)cmsg-&gt;cmsg_len);</span><br><span>     }</span><br><span>=
 </span><br><span>     return buf-&gt;len;</span><br><span>diff --git a/src=
/openvpn/socket_util=2Ec b/src/openvpn/socket_util=2Ec</span><br><span>inde=
x 0194f38=2E=2E913ac69 100644</span><br><span>--- a/src/openvpn/socket_util=
=2Ec</span><br><span>+++ b/src/openvpn/socket_util=2Ec</span><br><span>@@ -=
356,7 +356,7 @@</span><br><span>     const char *short_form;</span><br><spa=
n>     const char *display_form;</span><br><span>     sa_family_t proto_af;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int proto;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t proto;</span><=
br><span> };</span><br><span> </span><br><span> /* Indexed by PROTO_x */</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Demail">change 1476</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7be7427480d3540d4=
3dd818eddb6eb5860956459 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1476 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
=
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--ca6oceWfkzs=--


--===============7940515062671380733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7940515062671380733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7940515062671380733==--

