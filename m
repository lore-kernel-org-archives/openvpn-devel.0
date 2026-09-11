Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6262C88E4C
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 08:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ejEz2cWdSgo0th8n1S6OC9wkJez8SKjcKm+pFkiOAvk=; b=OPhhX2mNgAiQ/F
	DPbBEhBY1pOKq9S6bpndIt3HY03cjKU1B+tR/zOAqQsQGsVeoRPnz87pD2btJ/wfLsHQt7uRO1ZyT
	MAQmbZSmnMeYNH0tzFUneAlyWCryM9MfSyL7IxIvKJ3EFnv70wG3dlotU7XKd9Kg0rSMTYb7LbMkl
	tM0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4wT7-0006SS-MW;
	Fri, 11 Sep 2026 08:18:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4wT5-0006SK-I0
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:18:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2qKwLCVyS28Q5DeDdBtELzQG7PFCit/mKr8OF93cgik=; b=RJKUOCWib9aODqYFpIp65sozYh
 ptK6HeSTqAubV7fOMh+kXIQCVaZZg7GaNEoez0PaY5s4lIMSCkXSRcKW6+WV01gk4BoLcBl1PbYv8
 QFiC+GLQXiJerO88e7+lADGgY9c1LXPak/HPA3slFiVYDWqw8mkuehbUc7Nb2SvwmsCk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2qKwLCVyS28Q5DeDdBtELzQG7PFCit/mKr8OF93cgik=; b=m
 s1XNlExDG7fKYupLvyrf/Wk7CcYgcwl7RSx2Q8EWJXofY10H27j3Raq+QjVlYsCkzSA8sCv7wEcQk
 6+n/93N7TOrzYFEtLb9DDXrzgE8i91SG4Go2Wbd8fF1uT9aDOLOo1DMjpC8k0D9R3vbaqxWk8yXSw
 UDJNhAdZqf8y9bj0=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4wT2-0005QA-1E for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 08:18:44 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so6268805e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 01:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789114713; x=1789719513; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2qKwLCVyS28Q5DeDdBtELzQG7PFCit/mKr8OF93cgik=;
 b=BIxrnDMgYcjGdGq0/hTg0hzIUTFUefGjscaCHIjKNbxf6ADrjate5qAWUzr25v/c29
 BHX+2cM7G6aJGgPP2Zv3hQplePPZ0qz+vAuoZStiyMxNBrCCYdYlVQTmEDgm7uTsbqwI
 56BWyimZoVvG9P9r4INb+im8msiofhSNjUP52W3onpCZr3+0rwYPPdJ35zhIjX9fQ/Rl
 eqBBemNYmFvPetU1CNfPWyBn8odDSJR8totKgmZu7Cde2bB/fA2rHDi6L66OfKZ69fj+
 CZci8WCDOJe2KyZcW7Vz++RkbQft8XOjnUhd5c0fkb5s7ryWwYvROZC/RZyUM/YRs9rt
 DU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789114713; x=1789719513;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2qKwLCVyS28Q5DeDdBtELzQG7PFCit/mKr8OF93cgik=;
 b=cKL898GDpwiFKTbhbw+le7LCQtTRCcrv7oIqcD0lJicI+uzdMhN8OX8TK4Fj4p+JtU
 +SIBJxGbl/G/McEcofHq1nQxdgxqscA2sfMs/XvguFcWgbuBB1khlcxMmeSFFk6e42cA
 EiMM78njkhekttLf8mcIxc5F/EKNjvQzPWul9Jz9GcHhtt476FmsdHQweiyRtTVPaBbX
 1iuPhfTr6kNNwE2/e84s7TSx+60qJReQQodsTk7lOgBuUhY58ceGn5ywq18t7GeI6Ha3
 7JSMdI0edKk3MLzCixz4+EpZm+eGvGU15/bWHyuWKNMTb97Mpli5wPeMZJpR5LhZNUhp
 OzkA==
X-Gm-Message-State: AFuF++n/gu502wA81URQ4M0RMyanor+GcmgeABxLKtbThqyEnX1pCkUA
 Nr3FRUxS3iML6EBzuyc6YPjDOhfQ38E/eHukoQMnjSTshb82YEo8AKQB2VfXtBZpPKXvceC1OwL
 YMqCRblaHKVYP2/YKhsmkexPT2iW96p9tjKI3iGTk7IARmR14q0f3QNYnNGwUfFapnuE3GVxZVT
 fhsMWJ3w==
X-Gm-Gg: AYBFou3Q6WTWUqvVdJs3WBzbtbuLd5SrRGtvmeBaQn5CSy3KRvGy7gXucBmqRRU34dW
 o0HfbF9ELqQ4iVYmuQDAKXhptaLU+x4efxTM5YMi174ggh2kcNPQ9cqam+pYKekDG0S8zGrG/+G
 qhng2XllpEPKgzKTf5Fb+AVlyx1zYO03uWXpC/PsRGZjowilAvPG3Skm6UxpcZJ8RjlDpUYQgnw
 Ed+crgHvBruQurFonYeVrR4TJGnRxnn2BNaI1zMI+BnLeSdZHNHD1BxBdgRXERXuI+Xjzgz+hPc
 RNv3zWOHaWVITZG520pAOAKOpRnZlszvI6sVHYfegq2x/iJjM8CvR8S5YvDrkHHYQB+LcGjobU/
 qb6CUvzgxXVrMuxKxRbbhDgNiIG3Xk3cQYHWj+gsf9m5oZgNln4AZDFdtR5UobsoY/ngqXQKReL
 yOJzognxlejNmLOZzznjPYwQA2LAEV9j9M+eLoWyddzNtRmyyI0drh8lWGiKVc1TbVgtpGLMYSI
 7xvGzV/BOr3X/c/24IQ2BLI3UZ/lX/78yaRjt2S00e+cvHPl3yh7EPkzN0pqXClQzSvj0EIjFj4
 IVy1w4CjjensJERJyCemd108pIUyVNgJyilVRQyl4mwMp5gIJ81Ch0HKXobasFX6r+/r08jx
X-Received: by 2002:a05:600c:a4a:b0:49d:2a10:11f1 with SMTP id
 5b1f17b1804b1-49e61a092e4mr28890205e9.33.1789114713325; 
 Fri, 11 Sep 2026 01:18:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60ac42b9sm55552585e9.6.2026.09.11.01.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 01:18:32 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 08:18:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8f2bd694146aacd244a1d385ddfe9bb84ec29334
X-Gerrit-Change-Number: 1910
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1910?usp=email>
X-Gerrit-Commit: eb930310fd92dc2ea9859800a975ead0c73960fe
References: <gerrit.1789114696000.I8f2bd694146aacd244a1d385ddfe9bb84ec29334@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTE0Njk2MDAwLkk4ZjJiZDY5NDE0NmFhY2QyNDRhMWQzODVkZGZlOWJiODRlYzI5MzM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e64c40383575ff9e63fcd8bb6ab2f387626077b9-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4wT2-0005QA-1E
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: factor out
 UDP socket creation and setup
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
Content-Type: multipart/mixed; boundary="===============9119772903271122345=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9119772903271122345==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rTcJb2SBSQ8="; charset=UTF-8

--rTcJb2SBSQ8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1910?usp=3Demail

to review the following change=2E


Chang=
e subject: socket: factor out UDP socket creation and setup
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket: factor out UDP socke=
t creation and setup

create_socket() creates the UDP socket and then appli=
es the link
socket's options and local bind in place=2E Pull that sequence =
into
create_socket_udp_configured(), taking the address family and the
opti=
on values rather than a struct link_socket, and have create_socket()
call i=
t; the TCP path keeps its own sequence through the shared
socket_apply_opti=
ons()=2E

--server-probe will open its probe sockets through the same funct=
ion, so
a probe socket is set up and bound exactly like the connection sock=
et it
may later become=2E No behaviour change here=2E

Change-Id: I8f2bd694=
146aacd244a1d385ddfe9bb84ec29334
Signed-off-by: Lev Stipakov <lev@openvpn=
=2Enet>
---
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
2 files chang=
ed, 69 insertions(+), 26 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/10/1910/1

diff --git a/src/openvpn/socke=
t=2Ec b/src/openvpn/socket=2Ec
index 7c6217a=2E=2E223b811 100644
--- a/src/=
openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -636,12 +636,65 @@
     =
}
 }
 
+/* The per-socket options every link socket gets right after creati=
on=2E */
+static void
+socket_apply_options(socket_descriptor_t sd, const s=
truct socket_buffer_size *sbs, int mark,
+                     const char *=
bind_dev)
+{
+    /* set socket buffers based on --sndbuf and --rcvbuf opti=
ons */
+    socket_set_buffers(sd, sbs, true);
+
+    /* set socket to --ma=
rk packets with given value */
+    socket_set_mark(sd, mark);
+
+#if defin=
ed(TARGET_LINUX)
+    if (bind_dev)
+    {
+        msg(M_INFO, "Using bind=
-dev %s", bind_dev);
+        /* Note: We verify strlen of bind_dev in opti=
ons parsing */
+        if (setsockopt(sd, SOL_SOCKET, SO_BINDTODEVICE, bin=
d_dev, (socklen_t)(strlen(bind_dev) + 1))
+            !=3D 0)
+        {
+=
            msg(M_WARN | M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=3D%s fa=
iled", bind_dev);
+        }
+    }
+#else
+    (void)bind_dev;
+#endif
+}
=
+
+socket_descriptor_t
+create_socket_udp_configured(sa_family_t af, unsign=
ed int sockflags, const struct socket_buffer_size *sbs,
+                  =
           int mark, const char *bind_dev, struct addrinfo *bind_local,
+  =
                           bool bind_ipv6_only)
+{
+    struct addrinfo ai =
=3D { =2Eai_family =3D af, =2Eai_socktype =3D SOCK_DGRAM, =2Eai_protocol =
=3D IPPROTO_UDP };
+    socket_descriptor_t sd =3D create_socket_udp(&ai, s=
ockflags);
+
+    socket_apply_options(sd, sbs, mark, bind_dev);
+    if (b=
ind_local)
+    {
+        socket_bind(sd, bind_local, af, "TCP/UDP", bind_=
ipv6_only);
+    }
+    return sd;
+}
+
 static void
 create_socket(struct =
link_socket *sock, struct addrinfo *addr)
 {
+    /* Set af field of sock->=
info, so it always reflects the address family
+     * of the created socke=
t */
+    sock->info=2Eaf =3D (sa_family_t)addr->ai_family;
+
     if (addr=
->ai_protocol =3D=3D IPPROTO_UDP || addr->ai_socktype =3D=3D SOCK_DGRAM)
  =
   {
-        sock->sd =3D create_socket_udp(addr, sock->sockflags);
+     =
   /* With a SOCKS proxy the local bind goes on the control socket instead
=
+         * (see bind_local()), so the UDP socket is created unbound then=
=2E */
+        struct addrinfo *bind_addr =3D
+            (sock->bind_loc=
al && !sock->socks_proxy) ? sock->info=2Elsa->bind_local : NULL;
+        s=
ock->sd =3D create_socket_udp_configured(sock->info=2Eaf, sock->sockflags, =
&sock->socket_buffer_sizes,
+                                              =
  sock->mark, sock->bind_dev, bind_addr,
+                                 =
               sock->info=2Ebind_ipv6_only);
         sock->sockflags |=3D =
SF_GETADDRINFO_DGRAM;
 
         /* Assume that control socket and data soc=
ket to the socks proxy
@@ -655,41 +708,19 @@
             addrinfo_tmp=2Eai=
_socktype =3D SOCK_STREAM;
             addrinfo_tmp=2Eai_protocol =3D IPPR=
OTO_TCP;
             sock->ctrl_sd =3D create_socket_tcp(&addrinfo_tmp);
+=
            bind_local(sock);
         }
     }
     else if (addr->ai_prot=
ocol =3D=3D IPPROTO_TCP || addr->ai_socktype =3D=3D SOCK_STREAM)
     {
   =
      sock->sd =3D create_socket_tcp(addr);
+        socket_apply_options(s=
ock->sd, &sock->socket_buffer_sizes, sock->mark, sock->bind_dev);
+        =
bind_local(sock);
     }
     else
     {
         ASSERT(0);
     }
-    /=
* Set af field of sock->info, so it always reflects the address family
-   =
  * of the created socket */
-    sock->info=2Eaf =3D (sa_family_t)addr->ai=
_family;
-
-    /* set socket buffers based on --sndbuf and --rcvbuf option=
s */
-    socket_set_buffers(sock->sd, &sock->socket_buffer_sizes, true);
-=

-    /* set socket to --mark packets with given value */
-    socket_set_m=
ark(sock->sd, sock->mark);
-
-#if defined(TARGET_LINUX)
-    if (sock->bind=
_dev)
-    {
-        msg(M_INFO, "Using bind-dev %s", sock->bind_dev);
-  =
      /* Note: We verify strlen of bind_dev in options parsing */
-        =
if (setsockopt(sock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_dev,
-    =
                   (socklen_t)(strlen(sock->bind_dev) + 1))
-            !=
=3D 0)
-        {
-            msg(M_WARN | M_ERRNO, "WARN: setsockopt SO_B=
INDTODEVICE=3D%s failed", sock->bind_dev);
-        }
-    }
-#endif
-
-   =
 bind_local(sock);
 }
 
 #ifdef TARGET_ANDROID
diff --git a/src/openvpn/soc=
ket=2Eh b/src/openvpn/socket=2Eh
index 89465bc=2E=2E2633ca8 100644
--- a/sr=
c/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -401,6 +401,18 @@
 
 s=
ocket_descriptor_t create_socket_tcp(struct addrinfo *);
 
+/**
+ * Create =
a UDP socket for @p af set up the way a link socket is: --sndbuf/--rcvbuf,
=
+ * --mark, --bind-dev and, when @p bind_local is given, the local bind (IP=
V6_V6ONLY
+ * per @p bind_ipv6_only)=2E Shared by create_socket() and the -=
-server-probe sockets,
+ * so a probe socket is the connection socket it ma=
y become=2E Fatal if the socket
+ * cannot be created or bound=2E
+ */
+soc=
ket_descriptor_t create_socket_udp_configured(sa_family_t af, unsigned int =
sockflags,
+                                                 const struct s=
ocket_buffer_size *sbs, int mark,
+                                        =
         const char *bind_dev, struct addrinfo *bind_local,
+              =
                                   bool bind_ipv6_only);
+
 socket_descript=
or_t socket_do_accept(socket_descriptor_t sd, struct link_socket_actual *ac=
t,
                                      const bool nowait);
 

-- 
To view=
, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: I8f2bd694146aacd244a1d385ddfe9b=
b84ec29334
Gerrit-Change-Number: 1910
Gerrit-PatchSet: 1
Gerrit-Owner: stip=
a <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--rTcJb2SBSQ8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1910?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">so=
cket: factor out UDP socket creation and setup<br><br>create_socket() creat=
es the UDP socket and then applies the link<br>socket&#39;s options and loc=
al bind in place=2E Pull that sequence into<br>create_socket_udp_configured=
(), taking the address family and the<br>option values rather than a struct=
 link_socket, and have create_socket()<br>call it; the TCP path keeps its o=
wn sequence through the shared<br>socket_apply_options()=2E<br><br>--server=
-probe will open its probe sockets through the same function, so<br>a probe=
 socket is set up and bound exactly like the connection socket it<br>may la=
ter become=2E No behaviour change here=2E<br><br>Change-Id: I8f2bd694146aac=
d244a1d385ddfe9bb84ec29334<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=
=2Enet&gt;<br>---<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<b=
r>2 files changed, 69 insertions(+), 26 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/10/19=
10/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</=
span><br><span>index 7c6217a=2E=2E223b811 100644</span><br><span>--- a/src/=
openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><=
span>@@ -636,12 +636,65 @@</span><br><span>     }</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The p=
er-socket options every link socket gets right after creation=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+socket_apply_options(socket_descrip=
tor_t sd, const struct socket_buffer_size *sbs, int mark,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                     const char *bind=
_dev)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* set socket buffers based =
on --sndbuf and --rcvbuf options */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    socket_set_buffers(sd, sbs, true);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* set socket to --mark packets with given value */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    socket_set_mark(sd,=
 mark);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (bind_dev)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;Using bind-dev =
%s&quot;, bind_dev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* Note: We verify strlen of bind_dev in options parsing */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (setsockopt(sd,=
 SOL_SOCKET, SO_BINDTODEVICE, bind_dev, (socklen_t)(strlen(bind_dev) + 1))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            !=3D 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN | M_ERR=
NO, &quot;WARN: setsockopt SO_BINDTODEVICE=3D%s failed&quot;, bind_dev);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    (void)bind_dev;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+socket_descriptor_t</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+create_socket_udp_configured(sa_fam=
ily_t af, unsigned int sockflags, const struct socket_buffer_size *sbs,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
      int mark, const char *bind_dev, struct addrinfo *bind_local,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
 bool bind_ipv6_only)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct addri=
nfo ai =3D { =2Eai_family =3D af, =2Eai_socktype =3D SOCK_DGRAM, =2Eai_prot=
ocol =3D IPPROTO_UDP };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    socket_descriptor_t sd =3D create_socket_udp(&amp;ai, sockflags);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    socket_apply_options(sd, sbs, mark, =
bind_dev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (b=
ind_local)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        socket_bind(sd,=
 bind_local, af, &quot;TCP/UDP&quot;, bind_ipv6_only);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return sd;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> static void</span><br><span> create_socket(struct link_sock=
et *sock, struct addrinfo *addr)</span><br><span> {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Set af field of sock-&gt;info, so =
it always reflects the address family</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * of the created socket */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    sock-&gt;info=2Eaf =3D (sa_family_t)addr-=
&gt;ai_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>     if (addr-&gt;ai_protocol =3D=3D IPPROTO_UDP || addr-&gt;ai=
_socktype =3D=3D SOCK_DGRAM)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;sd =3D create_socket_udp(a=
ddr, sock-&gt;sockflags);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        /* With a SOCKS proxy the local bind goes on the control sock=
et instead</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
* (see bind_local()), so the UDP socket is created unbound then=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct addrinfo *=
bind_addr =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      (sock-&gt;bind_local &amp;&amp; !sock-&gt;socks_proxy) ? sock-&gt;inf=
o=2Elsa-&gt;bind_local : NULL;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        sock-&gt;sd =3D create_socket_udp_configured(sock-&gt;in=
fo=2Eaf, sock-&gt;sockflags, &amp;sock-&gt;socket_buffer_sizes,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
                 sock-&gt;mark, sock-&gt;bind_dev, bind_addr,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
               sock-&gt;info=2Ebind_ipv6_only);</span><br><span>         so=
ck-&gt;sockflags |=3D SF_GETADDRINFO_DGRAM;</span><br><span> </span><br><sp=
an>         /* Assume that control socket and data socket to the socks prox=
y</span><br><span>@@ -655,41 +708,19 @@</span><br><span>             addrin=
fo_tmp=2Eai_socktype =3D SOCK_STREAM;</span><br><span>             addrinfo=
_tmp=2Eai_protocol =3D IPPROTO_TCP;</span><br><span>             sock-&gt;c=
trl_sd =3D create_socket_tcp(&amp;addrinfo_tmp);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            bind_local(sock);</span><br><span>=
         }</span><br><span>     }</span><br><span>     else if (addr-&gt;ai=
_protocol =3D=3D IPPROTO_TCP || addr-&gt;ai_socktype =3D=3D SOCK_STREAM)</s=
pan><br><span>     {</span><br><span>         sock-&gt;sd =3D create_socket=
_tcp(addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
socket_apply_options(sock-&gt;sd, &amp;sock-&gt;socket_buffer_sizes, sock-&=
gt;mark, sock-&gt;bind_dev);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        bind_local(sock);</span><br><span>     }</span><br><span> =
    else</span><br><span>     {</span><br><span>         ASSERT(0);</span><=
br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*=
 Set af field of sock-&gt;info, so it always reflects the address family</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     * of the created so=
cket */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;i=
nfo=2Eaf =3D (sa_family_t)addr-&gt;ai_family;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* set socket buffers based on --sndbuf and --rcvbuf options */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    socket_set_buffers(soc=
k-&gt;sd, &amp;sock-&gt;socket_buffer_sizes, true);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* set socket to --mark packets with given value */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    socket_set_mark(sock-&gt;s=
d, sock-&gt;mark);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (sock-&gt;bin=
d_dev)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;Using=
 bind-dev %s&quot;, sock-&gt;bind_dev);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        /* Note: We verify strlen of bind_dev in options =
parsing */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(setsockopt(sock-&gt;sd, SOL_SOCKET, SO_BINDTODEVICE, sock-&gt;bind_dev,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                       (=
socklen_t)(strlen(sock-&gt;bind_dev) + 1))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            !=3D 0)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg(M_WARN | M_ERRNO, &quot;WARN: setsockopt SO_BINDTODE=
VICE=3D%s failed&quot;, sock-&gt;bind_dev);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    bind_local(sock);</span><br><span> }</=
span><br><span> </span><br><span> #ifdef TARGET_ANDROID</span><br><span>dif=
f --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>i=
ndex 89465bc=2E=2E2633ca8 100644</span><br><span>--- a/src/openvpn/socket=
=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -401,6=
 +401,18 @@</span><br><span> </span><br><span> socket_descriptor_t create_s=
ocket_tcp(struct addrinfo *);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Create a UDP socket for @p af set up the way a link socket i=
s: --sndbuf/--rcvbuf,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * --mark, --bind-dev and, when @p bind_local is given, the local bind (I=
PV6_V6ONLY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * per @p=
 bind_ipv6_only)=2E Shared by create_socket() and the --server-probe socket=
s,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * so a probe soc=
ket is the connection socket it may become=2E Fatal if the socket</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * cannot be created or bound=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+socket_descriptor_t create_socke=
t_udp_configured(sa_family_t af, unsigned int sockflags,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
           const struct socket_buffer_size *sbs, int mark,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
             const char *bind_dev, struct addrinfo *bind_local,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
                  bool bind_ipv6_only);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> socket_descriptor_t socket_do_accept(=
socket_descriptor_t sd, struct link_socket_actual *act,</span><br><span>   =
                                   const bool nowait);</span><br><span> </s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=3Demail">change 1910</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8f2bd694146aacd244a=
1d385ddfe9bb84ec29334 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1910 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>

</body></html>
--rTcJb2SBSQ8=--


--===============9119772903271122345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9119772903271122345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9119772903271122345==--

