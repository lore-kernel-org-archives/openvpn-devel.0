Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82021C88E45
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 07:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0iP0QR8SLeob8PGsb9cFSDY8OREYcNLjZs+l6LooUp4=; b=KYHVT7Qvvf9Bz0h37/aE+yBXl6
	+3Ka6ahyX0SnuLX++z/i2FxTqhdVuU8qRW6jd3DJ43Li8tuAiJ7Yz48dcRdQTxJt5lyNE4M4vF81O
	NmA8sZyFEnTNga9OMVU9TEKb5Xx8A2LqjLqWbiikp0Ojt3UQhCF4hWVPDc4rfOT2pQe8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5HrH-000638-03;
	Sat, 12 Sep 2026 07:09:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5HrF-000632-NT
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 07:09:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=eTw9XJUdcEFBuV6Bol3qzLwgd7m0zstexN+HL3EXpBk=; b=Tjjv7piDSd/RV8axDFWIx48LjH
 PivYkO2vQ7IV7l/qT0ay2uXg6z4zJqSGHMaCDVk/mu0BcJPHUg7i4Flm44nTKAV17Tv5XKnzpcy8z
 Jg3N5H/uzIunHBvcnjRdfs2Uad3SlXtBUMNDDTL7foFJBTsCfCnQwsBU00UbUL/3Q8pY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eTw9XJUdcEFBuV6Bol3qzLwgd7m0zstexN+HL3EXpBk=; b=m
 8iCJc+VwjYEX+ixD/YNIKBm9EmG+NlrkCLuqn8cYO/1Hczd3p2RTQO5fIb+DFp2FkIoEA+eVOw99w
 QjLQ+zAzdaPTnb748fF3DrdzD14ptjpNMwVqSs/sDWqM25bG+9AO4tpiYNLJmbG39wKlUEHzVBh6r
 h5DRHbyruPCLwx/k=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5HrB-0007pC-DQ for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 07:09:03 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso173795e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 12 Sep 2026 00:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789196935; x=1789801735; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eTw9XJUdcEFBuV6Bol3qzLwgd7m0zstexN+HL3EXpBk=;
 b=QMqxrCh6cNwY1pOaeuZY+wgFd6zjaZLLGzd7z0tvEo6QokHy00sAVo0Lqcu/nD90tS
 xmpUKS3QiFqfh+rOPCj59uxJLK0GdNGkJ4pqha+WyoiBwqmGvRjgspC5cTypnMUuLBn7
 4xdYCvnN0pCLxk5RQIceLKrOB5egIcJibQQc0riZgTv188zPa4PZtT5N0keLCRJi+AS2
 8JK+kSGKeS06b6boeHCkQTUYssw8B2CkTQMolpI49o9YytGqL6cwkW1xXpUdtiYZQE1e
 zMG+YfHgCZY55xzWYnZFGYR8I7DmAfRuSsS7jyNHS/NZapGZkSlAqeTOApAvhkCglgzH
 qjrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789196935; x=1789801735;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eTw9XJUdcEFBuV6Bol3qzLwgd7m0zstexN+HL3EXpBk=;
 b=ecphbF8RNtI46UmKdi15gGT4TZx5NTRkLoCPfDU1YpS84wRnAy2j0pVw2VGczK7UIA
 6iba7eSIDncZtFKl7dNZmKnhmh0Ww0+IoBE2OXKOPWdNfm3d2Z/ywrk5xQRcarzHCqUy
 wCeeVVbRHoERFtuFsiaVDrhj87kHBCUqml6k4iqFkWUcXChcEWh1hiPxHOAvOosmnCVI
 HFhiiz/X0VJCMdoKWzBYGxDiocHyyTcBiwyXz9Meiil/G5cqfQqiBFLnRmH2zcsksZWd
 munA01ejnaSG1zLPmpW+nrcbj7KaopHklO8ya3UP0v4QmCP2jCjTvzs3/O0117Nh3ssx
 nEaw==
X-Gm-Message-State: AFuF++nKWbghKJ9oJXohaVzsOSrNtDLIl7alc9GwcTdT+0b5YLKw8aHy
 eAEv+zRTrgg+/4Id4IiawI8RInk0sMVZsTcPxjLCdv4mVa7xRv7rUMXL0mGOr3IQbCkrIXNK8+d
 zQzcLC9ji1fpPS8nD7WLfSKcEbeF/BEoexn+BBI6CHBXHuTUDkcADLsGtDDL/8nTrV91JzzZVA4
 fpKkKk+w==
X-Gm-Gg: AYBFou3NoVJZkwkEcLVVnLOTJx8/i1oCes29dY4SQ+hixRv/q3Pej3uKmzv24ufOnNV
 jMU61gUwkztm7qK/YVKAtr2pSc2wYsvMQy/upZX6ZXkt02U2gaswePnJyqXhQdlDXCXoX2A3WPX
 6JQmpLIe28Vh1AJMeMGQZn3+XU0+TFD514p51X+1CrFj6mR0wxMSrAI0KlroBnHayNCbTgwfZfx
 SE/62IkO5t4shW/1L3UC1WgW5Rb6wtFWmJpO177H8Kk+UIR5W8Ak8lNwd3knIx0PXlZRqT8B9YE
 PYiJDO2dEAxPOFIYQrcSqMVWm4KnbrciYc/IicMHALEP/5BHLTGNnk506oPuYA7EqgDBFUdQMNY
 cXnQlq02h/bvlOy4v5R9u9e/IOHUtvYEQgKK++GTFmhc9JTYhT6Gfc9yYXVLeYauSr45FB5KOt2
 LBmQOyflbEomO6WioGoEelIsPhAQ7T77EFVAshI9F8fc6DvHsZaMulIOSOmSe2XUGTLOqJpU0Ob
 QFLD+63cnsEx2o1n8frcqouL/y0TM7IX2hkeCtXJejmt7q9PZJ2Erfe0lYSI44iz1tIIS9Bbmq2
 VREHIpac7m1Qwi1Ih3ZzxPJCwSnUiQQxKRfmUibgP1dMNv24fgzXqSXCHzwItQ==
X-Received: by 2002:a05:600c:5248:b0:49e:645e:2616 with SMTP id
 5b1f17b1804b1-49e6caad0b1mr13602495e9.5.1789196934531; 
 Sat, 12 Sep 2026 00:08:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60acff8bsm138147735e9.9.2026.09.12.00.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 00:08:53 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 12 Sep 2026 07:08:46 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I8f2bd694146aacd244a1d385ddfe9bb84ec29334
X-Gerrit-Change-Number: 1910
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1910?usp=email>
X-Gerrit-Commit: 533c4818d69234a3ba0542f56e50657cfdce6573
In-Reply-To: <gerrit.1789114696000.I8f2bd694146aacd244a1d385ddfe9bb84ec29334@gerrit.openvpn.net>
References: <gerrit.1789114696000.I8f2bd694146aacd244a1d385ddfe9bb84ec29334@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTE0Njk2MDAwLkk4ZjJiZDY5NDE0NmFhY2QyNDRhMWQzODVkZGZlOWJiODRlYzI5MzM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b64ab1fd5ee4fea3475db59c29a9807eb1a09ab7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5HrB-0007pC-DQ
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4442323171896063291=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4442323171896063291==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z3UPsurOXVQ="; charset=UTF-8

--Z3UPsurOXVQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=3Demail

to look a=
t the new patch set (#4)=2E


Change subject: socket: factor out UDP socket=
 creation and setup
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

socket: factor out UDP socket creation and setup

create_socket() c=
reates the UDP socket and then applies the link
socket's options and local =
bind in place=2E Pull that sequence into
create_socket_udp_configured(), ta=
king the address family and the
option values rather than a struct link_soc=
ket, and have create_socket()
call it; the TCP path keeps its own sequence =
through the shared
socket_apply_options()=2E

--server-probe will open its =
probe sockets through the same function, so
a probe socket is set up and bo=
und exactly like the connection socket it
may later become=2E Its "optional=
" argument lets that caller treat a
socket the host cannot create as "do no=
t probe this address family"
instead of dying; the connection path passes f=
alse and keeps the fatal
error=2E No behaviour change for existing callers=
=2E

Change-Id: I8f2bd694146aacd244a1d385ddfe9bb84ec29334
Signed-off-by: Le=
v Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/socket=2Ec
M src/openvpn/s=
ocket=2Eh
2 files changed, 78 insertions(+), 28 deletions(-)


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/10/1910/4

diff --gi=
t a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 7c6217a=2E=2Ee918=
1c8 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -56=
5,7 +565,7 @@
 }
 
 static socket_descriptor_t
-create_socket_udp(struct ad=
drinfo *addrinfo, const unsigned int flags)
+create_socket_udp(struct addri=
nfo *addrinfo, const unsigned int flags, bool optional)
 {
     socket_desc=
riptor_t sd;
 
@@ -575,7 +575,8 @@
     if ((sd =3D socket(addrinfo->ai_fam=
ily, addrinfo->ai_socktype, addrinfo->ai_protocol))
         =3D=3D SOCKET_=
UNDEFINED)
     {
-        msg(M_ERR, "UDP: Cannot create UDP/UDP6 socket")=
;
+        msg(optional ? D_LOW | M_ERRNO : M_ERR, "UDP: Cannot create UDP/=
UDP6 socket");
+        return SOCKET_UNDEFINED;
     }
 #if ENABLE_IP_PKTI=
NFO
     else if (flags & SF_USE_IP_PKTINFO)
@@ -636,12 +637,70 @@
     }
 =
}
 
+/* The per-socket options every link socket gets right after creation=
=2E */
+static void
+socket_apply_options(socket_descriptor_t sd, const str=
uct socket_buffer_size *sbs, int mark,
+                     const char *bi=
nd_dev)
+{
+    /* set socket buffers based on --sndbuf and --rcvbuf option=
s */
+    socket_set_buffers(sd, sbs, true);
+
+    /* set socket to --mark=
 packets with given value */
+    socket_set_mark(sd, mark);
+
+#if defined=
(TARGET_LINUX)
+    if (bind_dev)
+    {
+        msg(M_INFO, "Using bind-d=
ev %s", bind_dev);
+        /* Note: We verify strlen of bind_dev in option=
s parsing */
+        if (setsockopt(sd, SOL_SOCKET, SO_BINDTODEVICE, bind_=
dev, (socklen_t)(strlen(bind_dev) + 1))
+            !=3D 0)
+        {
+  =
          msg(M_WARN | M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=3D%s fail=
ed", bind_dev);
+        }
+    }
+#else
+    (void)bind_dev;
+#endif
+}
+
=
+socket_descriptor_t
+create_socket_udp_configured(sa_family_t af, unsigned=
 int sockflags, const struct socket_buffer_size *sbs,
+                    =
         int mark, const char *bind_dev, struct addrinfo *bind_addr,
+     =
                        bool bind_ipv6_only, bool optional)
+{
+    struct =
addrinfo ai =3D { =2Eai_family =3D af, =2Eai_socktype =3D SOCK_DGRAM, =2Eai=
_protocol =3D IPPROTO_UDP };
+    socket_descriptor_t sd =3D create_socket_=
udp(&ai, sockflags, optional);
+
+    if (sd =3D=3D SOCKET_UNDEFINED)
+    =
{
+        return SOCKET_UNDEFINED;
+    }
+
+    socket_apply_options(sd, =
sbs, mark, bind_dev);
+    if (bind_addr)
+    {
+        socket_bind(sd, b=
ind_addr, af, "TCP/UDP", bind_ipv6_only);
+    }
+    return sd;
+}
+
 stat=
ic void
 create_socket(struct link_socket *sock, struct addrinfo *addr)
 {
=
+    /* Set af field of sock->info, so it always reflects the address famil=
y
+     * of the created socket */
+    sock->info=2Eaf =3D (sa_family_t)ad=
dr->ai_family;
+
     if (addr->ai_protocol =3D=3D IPPROTO_UDP || addr->ai_=
socktype =3D=3D SOCK_DGRAM)
     {
-        sock->sd =3D create_socket_udp(=
addr, sock->sockflags);
+        /* With a SOCKS proxy the local bind goes =
on the control socket instead
+         * (see bind_local()), so the UDP so=
cket is created unbound then=2E */
+        struct addrinfo *bind_addr =3D
=
+            (sock->bind_local && !sock->socks_proxy) ? sock->info=2Elsa->b=
ind_local : NULL;
+        sock->sd =3D create_socket_udp_configured(sock->=
info=2Eaf, sock->sockflags, &sock->socket_buffer_sizes,
+                  =
                              sock->mark, sock->bind_dev, bind_addr,
+     =
                                           sock->info=2Ebind_ipv6_only, fal=
se);
         sock->sockflags |=3D SF_GETADDRINFO_DGRAM;
 
         /* Assu=
me that control socket and data socket to the socks proxy
@@ -655,41 +714,1=
9 @@
             addrinfo_tmp=2Eai_socktype =3D SOCK_STREAM;
             =
addrinfo_tmp=2Eai_protocol =3D IPPROTO_TCP;
             sock->ctrl_sd =3D =
create_socket_tcp(&addrinfo_tmp);
+            bind_local(sock);
         }=

     }
     else if (addr->ai_protocol =3D=3D IPPROTO_TCP || addr->ai_sock=
type =3D=3D SOCK_STREAM)
     {
         sock->sd =3D create_socket_tcp(add=
r);
+        socket_apply_options(sock->sd, &sock->socket_buffer_sizes, soc=
k->mark, sock->bind_dev);
+        bind_local(sock);
     }
     else
     =
{
         ASSERT(0);
     }
-    /* Set af field of sock->info, so it alwa=
ys reflects the address family
-     * of the created socket */
-    sock->=
info=2Eaf =3D (sa_family_t)addr->ai_family;
-
-    /* set socket buffers ba=
sed on --sndbuf and --rcvbuf options */
-    socket_set_buffers(sock->sd, &=
sock->socket_buffer_sizes, true);
-
-    /* set socket to --mark packets wi=
th given value */
-    socket_set_mark(sock->sd, sock->mark);
-
-#if define=
d(TARGET_LINUX)
-    if (sock->bind_dev)
-    {
-        msg(M_INFO, "Using=
 bind-dev %s", sock->bind_dev);
-        /* Note: We verify strlen of bind_=
dev in options parsing */
-        if (setsockopt(sock->sd, SOL_SOCKET, SO_=
BINDTODEVICE, sock->bind_dev,
-                       (socklen_t)(strlen(so=
ck->bind_dev) + 1))
-            !=3D 0)
-        {
-            msg(M_WARN=
 | M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=3D%s failed", sock->bind_dev)=
;
-        }
-    }
-#endif
-
-    bind_local(sock);
 }
 
 #ifdef TARGET_AN=
DROID
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index 89=
465bc=2E=2Ed296d3b 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/so=
cket=2Eh
@@ -401,6 +401,19 @@
 
 socket_descriptor_t create_socket_tcp(stru=
ct addrinfo *);
 
+/**
+ * Create a UDP socket for @p af set up the way a l=
ink socket is: --sndbuf/--rcvbuf,
+ * --mark, --bind-dev and, when @p bind_=
addr is given, the local bind (IPV6_V6ONLY
+ * per @p bind_ipv6_only)=2E Sh=
ared by create_socket() and the --server-probe sockets,
+ * so a probe sock=
et is the connection socket it may become=2E A failed bind is
+ * fatal; wi=
th @p optional a socket the host cannot create is not, so
+ * --server-prob=
e can skip that address family (SOCKET_UNDEFINED is returned)=2E
+ */
+sock=
et_descriptor_t create_socket_udp_configured(sa_family_t af, unsigned int s=
ockflags,
+                                                 const struct so=
cket_buffer_size *sbs, int mark,
+                                         =
        const char *bind_dev, struct addrinfo *bind_addr,
+                =
                                 bool bind_ipv6_only, bool optional);
+
 so=
cket_descriptor_t socket_do_accept(socket_descriptor_t sd, struct link_sock=
et_actual *act,
                                      const bool nowait);
 =


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8f2bd694146aac=
d244a1d385ddfe9bb84ec29334
Gerrit-Change-Number: 1910
Gerrit-PatchSet: 4
Ge=
rrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici =
<ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--Z3UPsurOXVQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">socket: factor out UDP socket creation and setup<br><br>create_soc=
ket() creates the UDP socket and then applies the link<br>socket&#39;s opti=
ons and local bind in place=2E Pull that sequence into<br>create_socket_udp=
_configured(), taking the address family and the<br>option values rather th=
an a struct link_socket, and have create_socket()<br>call it; the TCP path =
keeps its own sequence through the shared<br>socket_apply_options()=2E<br><=
br>--server-probe will open its probe sockets through the same function, so=
<br>a probe socket is set up and bound exactly like the connection socket i=
t<br>may later become=2E Its &quot;optional&quot; argument lets that caller=
 treat a<br>socket the host cannot create as &quot;do not probe this addres=
s family&quot;<br>instead of dying; the connection path passes false and ke=
eps the fatal<br>error=2E No behaviour change for existing callers=2E<br><b=
r>Change-Id: I8f2bd694146aacd244a1d385ddfe9bb84ec29334<br>Signed-off-by: Le=
v Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/socket=2Ec<br>=
M src/openvpn/socket=2Eh<br>2 files changed, 78 insertions(+), 28 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/10/1910/4</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/socket=2Ec =
b/src/openvpn/socket=2Ec</span><br><span>index 7c6217a=2E=2Ee9181c8 100644<=
/span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/open=
vpn/socket=2Ec</span><br><span>@@ -565,7 +565,7 @@</span><br><span> }</span=
><br><span> </span><br><span> static socket_descriptor_t</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-create_socket_udp(struct addrinfo *addri=
nfo, const unsigned int flags)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+create_socket_udp(struct addrinfo *addrinfo, const unsigned int =
flags, bool optional)</span><br><span> {</span><br><span>     socket_descri=
ptor_t sd;</span><br><span> </span><br><span>@@ -575,7 +575,8 @@</span><br>=
<span>     if ((sd =3D socket(addrinfo-&gt;ai_family, addrinfo-&gt;ai_sockt=
ype, addrinfo-&gt;ai_protocol))</span><br><span>         =3D=3D SOCKET_UNDE=
FINED)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        msg(M_ERR, &quot;UDP: Cannot create UDP/UDP6 socket&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(optiona=
l ? D_LOW | M_ERRNO : M_ERR, &quot;UDP: Cannot create UDP/UDP6 socket&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return SO=
CKET_UNDEFINED;</span><br><span>     }</span><br><span> #if ENABLE_IP_PKTIN=
FO</span><br><span>     else if (flags &amp; SF_USE_IP_PKTINFO)</span><br><=
span>@@ -636,12 +637,70 @@</span><br><span>     }</span><br><span> }</span>=
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
      int mark, const char *bind_dev, struct addrinfo *bind_addr,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
bool bind_ipv6_only, bool optional)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct addrinfo ai =3D { =2Eai_family =3D af, =2Eai_socktype =3D SOCK_DGR=
AM, =2Eai_protocol =3D IPPROTO_UDP };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    socket_descriptor_t sd =3D create_socket_udp(&amp;ai,=
 sockflags, optional);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sd =3D=
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
<span>index 89465bc=2E=2Ed296d3b 100644</span><br><span>--- a/src/openvpn/s=
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

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I8f2bd694146aacd244a1d385ddfe9bb84ec29334 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1910 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lsti=
pakov@gmail=2Ecom&gt; </div>

</body></html>
--Z3UPsurOXVQ=--


--===============4442323171896063291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4442323171896063291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4442323171896063291==--

