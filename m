Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4D6C88E56
	for <openvpn-devel@archiver.kernel.org>; Sun, 13 Sep 2026 09:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f2fvPes7u5Njm6Q7++yWkrdYQpnTeF6aTShOOuZ9vO0=; b=cxb8SOyRO4DdjyONP432to33Wv
	CeLgHZ+t8RB/wXDCYsmQM9ZnA9qulgDn8+NQ2yEGUDeD9HVxHQlLrJV1XKfml68hmblQ8rJZYMfM4
	dw7Nxq1J8cE9IWjc/Kip9xoKqjQ6c2LPaA9AB49iKb00kW/LEYOdOuktbWDd/Vz7TMJ8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5gUj-0000lX-Jj;
	Sun, 13 Sep 2026 09:27:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5gUY-0000jo-SN
 for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 09:27:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zzXwqw2ap2Zr3GEdCGfwcQ6TuMb3/X+SkgXSHP7gYH8=; b=AADTFRLKZiOt4hs9vV0mqzdE7a
 SCNT7GuYj11HDd7WLoaKSXt/4PKu+vlljX2MiBrBu41+Qhf7KQ9rysmIz9W6tduDRZBG9bcfWWQNx
 5NrMagLjVPZV1acI106CG5UN2HoDR1muvTQy7xSb6WuPVxWR53EeEAs5Vowp5Fzn2PtA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zzXwqw2ap2Zr3GEdCGfwcQ6TuMb3/X+SkgXSHP7gYH8=; b=N
 rof79qRe7sJQ/zb/Txq8GyxlHmMYYj8qpMQwCbinmOuu0Ks+1B6dJrSq+qKQZcB/7Jh+VziYvm67e
 RO2mezAuCP2jOFznZeIRKal8Wdn8+70wByCrr+1kOl2LlJrR722P2Qhr5vZ8PUZUaT8rF6a5vrHab
 DVQhVYSUrKLom1jc=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5gUF-0004iI-7z for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 09:27:01 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccff31419so8367295e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 13 Sep 2026 02:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789291613; x=1789896413; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zzXwqw2ap2Zr3GEdCGfwcQ6TuMb3/X+SkgXSHP7gYH8=;
 b=JrWISNWWEoAAB5yEHeukuq4o3hbUvZCm9Kks10fErAzsM3HMlfibnRousl9dQhqLLL
 Wc7oB7BxGe/Ily1ZZBgHFI6qJw2vHp0v7Nai5tRNiVFiJJzv83+dUGPyRwIUtqFmhl4D
 NwRTZXqIG8ShR7roiIPJnPm1cxGOk6172kLOwAXjQXJX7wZOFUk4TGyrsr237se2U6Hv
 IzkJMy4/nlQUbbTm68XDFRmir0dzzVevXsXZvifi9EOatnGmhvPVFioWGrtfKdy1k9Ic
 VZmiSwTuyBOLAt9sjQiehaK8HcwS3F+KQiNCnqqFL5kIY4M4+XLgfMRj41GalE6AixBX
 oGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789291613; x=1789896413;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zzXwqw2ap2Zr3GEdCGfwcQ6TuMb3/X+SkgXSHP7gYH8=;
 b=F3c+5Lhmx7bbtUF3fp/e6qu0dhLjGvLac+oPQ056S6BAUH8xx+Dai6dfYOpb/gEQWb
 0kUsbpfocYOHi7Hv9baXGPJG78RKDElfjV1Wfi9+/LZbH6XIrCIKrRVGnigzZL3kOQWY
 fpUhX181rFmjg3bJ2c0N2XfxD3RkNc2E9OZY47Cqly4STkx05Ht3fJvy3bOpKEV3PWog
 HoKzO/urGtojFPG4RPnrihE19lNvQe33FM7VKQBW/PnjUdDV3MZHxTDuuLr6eSGlolGC
 IFs8NXiMjHSUhWzwYwEL3/g/zAf2Un1claUe3whCPIVVf4c7leS27c1aUhvVymSsSzEV
 UtvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfvWI76grXwd+7TG/osv1mFOEE+sBDIxoloUPtviXdNKYExmQ6ia9uhjLNOKjssurZqskj2CGpK+5Tzq37@lists.sourceforge.net
X-Gm-Message-State: AFuF++k4Y8bAviUZ0OUg9TqLvlTKiqZtenw5P0OVpmWRjGqdtVhSvivd
 8OsSsQTc2uUc7cZyhWXCViCNL1hfXerb7QIWltN02wV8O63kJ2CPTmbCZLzbHUKXxpN0+iPf9dX
 SFJR+RT18lMdHTB4lmKewqPE9x87tu+qV/fKr19BdlZxeR0bRteZkxCO9GMvC70JRSkQ0
X-Gm-Gg: AYBFou1USCAEHobiVGOFIZfTOMT+XjQbuPJ4OqYEAjNkZ7zvRTdMPO+WP+gswuEfdfb
 330c0xNkm7raTtdnMKjBac3eFpbKn9WCoPHiVkiwUP+KL3QEXLLnFW+eEVFRP5f1iSV3CEvIaZr
 0foEMkgDNjDe00xCFybUw2QnB+O6qKSfDWVKmwxxXNq5AGUztLv1e0PYdlpJO0sKPsEOqNwd2Vf
 o7mqL0QLpfqJI0Z+5UH+WgrKTVGX66C/ZZQwT6GEfEa2F1tnAH12vO0JtvOlqthnTKno7kTU3gm
 qDydxWAu7t+qd7E7PW2oXdCQ2VC65opJGO4fhYjdpSiWwGbEEwrg9a/l2i9lWyKZQyn/A3psjHj
 QSRKQIyYTNVfbPSStrJRfFtrz3qTYqeKYADYmt/9zUkC2/NiZr329w2KQXj0ZJSrledgeJM+XoS
 xKFXqigP8fCwn/UmFVfDqheMgKcX0If7oOl+898KIOyVyg6QHZxT6/Ne16HwAMBT0f2K+mwEdaF
 Px3NjKAPN4q/EjmSqnu+oZ4BLUAialWGNxhvP8IxR8dH09RKojd8Vd8WDirB63aqT3uVgVI14Pw
 1Sydlgv9lDGLiCvBcmM41SmxDg/DRNrKs5WWYy+gzDS77sR7e5Wxxb8OEtmOCg==
X-Received: by 2002:a05:600c:3594:b0:49c:fa21:1c89 with SMTP id
 5b1f17b1804b1-49e6cc14055mr71980275e9.30.1789291612500; 
 Sun, 13 Sep 2026 02:26:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60ac411asm211588685e9.8.2026.09.13.02.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 02:26:52 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 13 Sep 2026 09:26:51 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I8f2bd694146aacd244a1d385ddfe9bb84ec29334
X-Gerrit-Change-Number: 1910
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1910?usp=email>
X-Gerrit-Commit: af1f73dbe442b42b8a1addc614aa13c3485db266
In-Reply-To: <gerrit.1789114696000.I8f2bd694146aacd244a1d385ddfe9bb84ec29334@gerrit.openvpn.net>
References: <gerrit.1789114696000.I8f2bd694146aacd244a1d385ddfe9bb84ec29334@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTE0Njk2MDAwLkk4ZjJiZDY5NDE0NmFhY2QyNDRhMWQzODVkZGZlOWJiODRlYzI5MzM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <00ed2af3bef59979c3080a78b10a19fa612d4869-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5gUF-0004iI-7z
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6134460868606472935=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6134460868606472935==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XFfarkaT2sM="; charset=UTF-8

--XFfarkaT2sM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1910?usp=3Demail )

Change subject: socket: factor out UDP socket creat=
ion and setup
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


socket: factor out UDP socket creation and setup

create_socket() creates=
 the UDP socket and then applies the link
socket's options and local bind i=
n place=2E Pull that sequence into
create_socket_udp_configured(), taking t=
he address family and the
option values rather than a struct link_socket, a=
nd have create_socket()
call it; the TCP path keeps its own sequence throug=
h the shared
socket_apply_options()=2E

--server-probe will open its probe =
sockets through the same function, so
a probe socket is set up and bound ex=
actly like the connection socket it
may later become=2E Its "optional" argu=
ment lets that caller treat a
socket the host cannot create as "do not prob=
e this address family"
instead of dying; the connection path passes false a=
nd keeps the fatal
error=2E No behaviour change for existing callers=2E

Ch=
ange-Id: I8f2bd694146aacd244a1d385ddfe9bb84ec29334
Signed-off-by: Lev Stipa=
kov <lev@openvpn=2Enet>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1910
Message-Id: <20260912092917=2E27218-1-gert@greenie=2Emuc=2Ede>
URL=
: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/=
msg39126=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M=
 src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
2 files changed, 78 insert=
ions(+), 28 deletions(-)




diff --git a/src/openvpn/socket=2Ec b/src/open=
vpn/socket=2Ec
index 7f39268=2E=2Ef6ebf10 100644
--- a/src/openvpn/socket=
=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -565,7 +565,7 @@
 }
 
 static socket_d=
escriptor_t
-create_socket_udp(struct addrinfo *addrinfo, const unsigned in=
t flags)
+create_socket_udp(struct addrinfo *addrinfo, const unsigned int f=
lags, bool optional)
 {
     socket_descriptor_t sd;
 
@@ -575,7 +575,8 @@
=
     if ((sd =3D socket(addrinfo->ai_family, addrinfo->ai_socktype, addrinf=
o->ai_protocol))
         =3D=3D SOCKET_UNDEFINED)
     {
-        msg(M_ER=
R, "UDP: Cannot create UDP/UDP6 socket");
+        msg(optional ? D_LOW | M=
_ERRNO : M_ERR, "UDP: Cannot create UDP/UDP6 socket");
+        return SOCK=
ET_UNDEFINED;
     }
 #if ENABLE_IP_PKTINFO
     else if (flags & SF_USE_IP=
_PKTINFO)
@@ -636,12 +637,70 @@
     }
 }
 
+/* The per-socket options ever=
y link socket gets right after creation=2E */
+static void
+socket_apply_op=
tions(socket_descriptor_t sd, const struct socket_buffer_size *sbs, int mar=
k,
+                     const char *bind_dev)
+{
+    /* set socket buffer=
s based on --sndbuf and --rcvbuf options */
+    socket_set_buffers(sd, sbs=
, true);
+
+    /* set socket to --mark packets with given value */
+    so=
cket_set_mark(sd, mark);
+
+#if defined(TARGET_LINUX)
+    if (bind_dev)
+ =
   {
+        msg(M_INFO, "Using bind-dev %s", bind_dev);
+        /* Note:=
 We verify strlen of bind_dev in options parsing */
+        if (setsockopt=
(sd, SOL_SOCKET, SO_BINDTODEVICE, bind_dev, (socklen_t)(strlen(bind_dev) + =
1))
+            !=3D 0)
+        {
+            msg(M_WARN | M_ERRNO, "WAR=
N: setsockopt SO_BINDTODEVICE=3D%s failed", bind_dev);
+        }
+    }
+#=
else
+    (void)bind_dev;
+#endif
+}
+
+socket_descriptor_t
+create_socket_=
udp_configured(sa_family_t af, unsigned int sockflags, const struct socket_=
buffer_size *sbs,
+                             int mark, const char *bind_=
dev, struct addrinfo *bind_addr,
+                             bool bind_ip=
v6_only, bool optional)
+{
+    struct addrinfo ai =3D { =2Eai_family =3D a=
f, =2Eai_socktype =3D SOCK_DGRAM, =2Eai_protocol =3D IPPROTO_UDP };
+    so=
cket_descriptor_t sd =3D create_socket_udp(&ai, sockflags, optional);
+
+  =
  if (sd =3D=3D SOCKET_UNDEFINED)
+    {
+        return SOCKET_UNDEFINED;
=
+    }
+
+    socket_apply_options(sd, sbs, mark, bind_dev);
+    if (bind_=
addr)
+    {
+        socket_bind(sd, bind_addr, af, "TCP/UDP", bind_ipv6_o=
nly);
+    }
+    return sd;
+}
+
 static void
 create_socket(struct link_s=
ocket *sock, struct addrinfo *addr)
 {
+    /* Set af field of sock->info, =
so it always reflects the address family
+     * of the created socket */
+=
    sock->info=2Eaf =3D (sa_family_t)addr->ai_family;
+
     if (addr->ai_p=
rotocol =3D=3D IPPROTO_UDP || addr->ai_socktype =3D=3D SOCK_DGRAM)
     {
-=
        sock->sd =3D create_socket_udp(addr, sock->sockflags);
+        /* =
With a SOCKS proxy the local bind goes on the control socket instead
+     =
    * (see bind_local()), so the UDP socket is created unbound then=2E */
+=
        struct addrinfo *bind_addr =3D
+            (sock->bind_local && !s=
ock->socks_proxy) ? sock->info=2Elsa->bind_local : NULL;
+        sock->sd =
=3D create_socket_udp_configured(sock->info=2Eaf, sock->sockflags, &sock->s=
ocket_buffer_sizes,
+                                                sock->=
mark, sock->bind_dev, bind_addr,
+                                         =
       sock->info=2Ebind_ipv6_only, false);
         sock->sockflags |=3D S=
F_GETADDRINFO_DGRAM;
 
         /* Assume that control socket and data sock=
et to the socks proxy
@@ -655,41 +714,19 @@
             addrinfo_tmp=2Eai_=
socktype =3D SOCK_STREAM;
             addrinfo_tmp=2Eai_protocol =3D IPPRO=
TO_TCP;
             sock->ctrl_sd =3D create_socket_tcp(&addrinfo_tmp);
+ =
           bind_local(sock);
         }
     }
     else if (addr->ai_proto=
col =3D=3D IPPROTO_TCP || addr->ai_socktype =3D=3D SOCK_STREAM)
     {
    =
     sock->sd =3D create_socket_tcp(addr);
+        socket_apply_options(so=
ck->sd, &sock->socket_buffer_sizes, sock->mark, sock->bind_dev);
+        b=
ind_local(sock);
     }
     else
     {
         ASSERT(0);
     }
-    /*=
 Set af field of sock->info, so it always reflects the address family
-    =
 * of the created socket */
-    sock->info=2Eaf =3D (sa_family_t)addr->ai_=
family;
-
-    /* set socket buffers based on --sndbuf and --rcvbuf options=
 */
-    socket_set_buffers(sock->sd, &sock->socket_buffer_sizes, true);
-
=
-    /* set socket to --mark packets with given value */
-    socket_set_ma=
rk(sock->sd, sock->mark);
-
-#if defined(TARGET_LINUX)
-    if (sock->bind_=
dev)
-    {
-        msg(M_INFO, "Using bind-dev %s", sock->bind_dev);
-   =
     /* Note: We verify strlen of bind_dev in options parsing */
-        i=
f (setsockopt(sock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_dev,
-     =
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
index c6a29f4=2E=2E46fa29c 100644
--- a/sr=
c/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -401,6 +401,19 @@
 
 s=
ocket_descriptor_t create_socket_tcp(struct addrinfo *);
 
+/**
+ * Create =
a UDP socket for @p af set up the way a link socket is: --sndbuf/--rcvbuf,
=
+ * --mark, --bind-dev and, when @p bind_addr is given, the local bind (IPV=
6_V6ONLY
+ * per @p bind_ipv6_only)=2E Shared by create_socket() and the --=
server-probe sockets,
+ * so a probe socket is the connection socket it may=
 become=2E A failed bind is
+ * fatal; with @p optional a socket the host c=
annot create is not, so
+ * --server-probe can skip that address family (SO=
CKET_UNDEFINED is returned)=2E
+ */
+socket_descriptor_t create_socket_udp_=
configured(sa_family_t af, unsigned int sockflags,
+                       =
                          const struct socket_buffer_size *sbs, int mark,
+=
                                                 const char *bind_dev, stru=
ct addrinfo *bind_addr,
+                                                 b=
ool bind_ipv6_only, bool optional);
+
 socket_descriptor_t socket_do_accept=
(socket_descriptor_t sd, struct link_socket_actual *act,
                  =
                    const bool nowait);
 

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: I8f2bd694146aacd244a1d385ddfe9bb84ec29334
Gerrit-Change=
-Number: 1910
Gerrit-PatchSet: 5
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>

--XFfarkaT2sM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1910?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">socket: factor out UDP socket creation and=
 setup<br><br>create_socket() creates the UDP socket and then applies the l=
ink<br>socket&#39;s options and local bind in place=2E Pull that sequence i=
nto<br>create_socket_udp_configured(), taking the address family and the<br=
>option values rather than a struct link_socket, and have create_socket()<b=
r>call it; the TCP path keeps its own sequence through the shared<br>socket=
_apply_options()=2E<br><br>--server-probe will open its probe sockets throu=
gh the same function, so<br>a probe socket is set up and bound exactly like=
 the connection socket it<br>may later become=2E Its &quot;optional&quot; a=
rgument lets that caller treat a<br>socket the host cannot create as &quot;=
do not probe this address family&quot;<br>instead of dying; the connection =
path passes false and keeps the fatal<br>error=2E No behaviour change for e=
xisting callers=2E<br><br>Change-Id: I8f2bd694146aacd244a1d385ddfe9bb84ec29=
334<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Gerrit URL:=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1910<br>Message-Id: &lt;2026091=
2092917=2E27218-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39126=2Ehtml<br>Sign=
ed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/ope=
nvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>2 files changed, 78 insertio=
ns(+), 28 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/socket=2Ec=
 b/src/openvpn/socket=2Ec</span><br><span>index 7f39268=2E=2Ef6ebf10 100644=
</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/ope=
nvpn/socket=2Ec</span><br><span>@@ -565,7 +565,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> static socket_descriptor_t</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-create_socket_udp(struct addrinfo *addr=
info, const unsigned int flags)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+create_socket_udp(struct addrinfo *addrinfo, const unsigned int=
 flags, bool optional)</span><br><span> {</span><br><span>     socket_descr=
iptor_t sd;</span><br><span> </span><br><span>@@ -575,7 +575,8 @@</span><br=
><span>     if ((sd =3D socket(addrinfo-&gt;ai_family, addrinfo-&gt;ai_sock=
type, addrinfo-&gt;ai_protocol))</span><br><span>         =3D=3D SOCKET_UND=
EFINED)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(M_ERR, &quot;UDP: Cannot create UDP/UDP6 socket&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(option=
al ? D_LOW | M_ERRNO : M_ERR, &quot;UDP: Cannot create UDP/UDP6 socket&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return S=
OCKET_UNDEFINED;</span><br><span>     }</span><br><span> #if ENABLE_IP_PKTI=
NFO</span><br><span>     else if (flags &amp; SF_USE_IP_PKTINFO)</span><br>=
<span>@@ -636,12 +637,70 @@</span><br><span>     }</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The =
per-socket options every link socket gets right after creation=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+socket_apply_options(socket_descri=
ptor_t sd, const struct socket_buffer_size *sbs, int mark,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                     const char *bin=
d_dev)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* set socket buffers based=
 on --sndbuf and --rcvbuf options */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    socket_set_buffers(sd, sbs, true);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* set socket to --mark packets with given value */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    socket_set_mark(sd=
, mark);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (bind_dev)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;Using bind-dev=
 %s&quot;, bind_dev);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* Note: We verify strlen of bind_dev in options parsing */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (setsockopt(sd=
, SOL_SOCKET, SO_BINDTODEVICE, bind_dev, (socklen_t)(strlen(bind_dev) + 1))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            !=3D 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN | M_ER=
RNO, &quot;WARN: setsockopt SO_BINDTODEVICE=3D%s failed&quot;, bind_dev);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    (void)bind_dev;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+socket_descriptor_t</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+create_socket_udp_configured(sa_fa=
mily_t af, unsigned int sockflags, const struct socket_buffer_size *sbs,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
       int mark, const char *bind_dev, struct addrinfo *bind_addr,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
 bool bind_ipv6_only, bool optional)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct addrinfo ai =3D { =2Eai_family =3D af, =2Eai_socktype =3D SOCK_DG=
RAM, =2Eai_protocol =3D IPPROTO_UDP };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    socket_descriptor_t sd =3D create_socket_udp(&amp;ai=
, sockflags, optional);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sd =3D=
=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn SOCKET_UNDEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    socket_apply_options(sd, sbs=
, mark, bind_dev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (bind_addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        socket_b=
ind(sd, bind_addr, af, &quot;TCP/UDP&quot;, bind_ipv6_only);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return sd;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> static void</span><br><span> create_socket(struct lin=
k_socket *sock, struct addrinfo *addr)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Set af field of sock-&gt;info,=
 so it always reflects the address family</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * of the created socket */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;info=2Eaf =3D (sa_family_t)a=
ddr-&gt;ai_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>     if (addr-&gt;ai_protocol =3D=3D IPPROTO_UDP || addr-&g=
t;ai_socktype =3D=3D SOCK_DGRAM)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;sd =3D create_socket_udp=
(addr, sock-&gt;sockflags);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        /* With a SOCKS proxy the local bind goes on the control so=
cket instead</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
  * (see bind_local()), so the UDP socket is created unbound then=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct addrinfo=
 *bind_addr =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        (sock-&gt;bind_local &amp;&amp; !sock-&gt;socks_proxy) ? sock-&gt;i=
nfo=2Elsa-&gt;bind_local : NULL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        sock-&gt;sd =3D create_socket_udp_configured(sock-&gt;=
info=2Eaf, sock-&gt;sockflags, &amp;sock-&gt;socket_buffer_sizes,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
                   sock-&gt;mark, sock-&gt;bind_dev, bind_addr,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
                 sock-&gt;info=2Ebind_ipv6_only, false);</span><br><span>  =
       sock-&gt;sockflags |=3D SF_GETADDRINFO_DGRAM;</span><br><span> </spa=
n><br><span>         /* Assume that control socket and data socket to the s=
ocks proxy</span><br><span>@@ -655,41 +714,19 @@</span><br><span>          =
   addrinfo_tmp=2Eai_socktype =3D SOCK_STREAM;</span><br><span>            =
 addrinfo_tmp=2Eai_protocol =3D IPPROTO_TCP;</span><br><span>             s=
ock-&gt;ctrl_sd =3D create_socket_tcp(&amp;addrinfo_tmp);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            bind_local(sock);</span><=
br><span>         }</span><br><span>     }</span><br><span>     else if (ad=
dr-&gt;ai_protocol =3D=3D IPPROTO_TCP || addr-&gt;ai_socktype =3D=3D SOCK_S=
TREAM)</span><br><span>     {</span><br><span>         sock-&gt;sd =3D crea=
te_socket_tcp(addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        socket_apply_options(sock-&gt;sd, &amp;sock-&gt;socket_buffer_size=
s, sock-&gt;mark, sock-&gt;bind_dev);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        bind_local(sock);</span><br><span>     }</span><b=
r><span>     else</span><br><span>     {</span><br><span>         ASSERT(0)=
;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* Set af field of sock-&gt;info, so it always reflects the address =
family</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * of the c=
reated socket */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
ock-&gt;info=2Eaf =3D (sa_family_t)addr-&gt;ai_family;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /* set socket buffers based on --sndbuf and --rcvbuf option=
s */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    socket_set_bu=
ffers(sock-&gt;sd, &amp;sock-&gt;socket_buffer_sizes, true);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* set socket to --mark packets with given value */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    socket_set_mark(soc=
k-&gt;sd, sock-&gt;mark);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGE=
T_LINUX)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (sock-=
&gt;bind_dev)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quo=
t;Using bind-dev %s&quot;, sock-&gt;bind_dev);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        /* Note: We verify strlen of bind_dev in o=
ptions parsing */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (setsockopt(sock-&gt;sd, SOL_SOCKET, SO_BINDTODEVICE, sock-&gt;bind_=
dev,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
      (socklen_t)(strlen(sock-&gt;bind_dev) + 1))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            !=3D 0)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            msg(M_WARN | M_ERRNO, &quot;WARN: setsockopt SO_B=
INDTODEVICE=3D%s failed&quot;, sock-&gt;bind_dev);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    bind_local(sock);</span><br><sp=
an> }</span><br><span> </span><br><span> #ifdef TARGET_ANDROID</span><br><s=
pan>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br>=
<span>index c6a29f4=2E=2E46fa29c 100644</span><br><span>--- a/src/openvpn/s=
ocket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -=
401,6 +401,19 @@</span><br><span> </span><br><span> socket_descriptor_t cre=
ate_socket_tcp(struct addrinfo *);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Create a UDP socket for @p af set up the way a link so=
cket is: --sndbuf/--rcvbuf,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * --mark, --bind-dev and, when @p bind_addr is given, the local bi=
nd (IPV6_V6ONLY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * p=
er @p bind_ipv6_only)=2E Shared by create_socket() and the --server-probe s=
ockets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * so a prob=
e socket is the connection socket it may become=2E A failed bind is</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * fatal; with @p optional =
a socket the host cannot create is not, so</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * --server-probe can skip that address family (SOCK=
ET_UNDEFINED is returned)=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_=
descriptor_t create_socket_udp_configured(sa_family_t af, unsigned int sock=
flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                                    const struct socket_buffer_size *sbs, i=
nt mark,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                                      const char *bind_dev, struct addrinfo=
 *bind_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                                          bool bind_ipv6_only, bool optiona=
l);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> socket_descriptor_t socket_do_accept(socket_descriptor_t sd, struct link_=
socket_actual *act,</span><br><span>                                      c=
onst bool nowait);</span><br><span> </span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=
=3Demail">change 1910</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1910?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I8f2bd694146aacd244a1d385ddfe9bb84ec29334 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1910 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--XFfarkaT2sM=--


--===============6134460868606472935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6134460868606472935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6134460868606472935==--

