Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1ED0C88E40
	for <openvpn-devel@archiver.kernel.org>; Sun, 13 Sep 2026 09:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ArOhmDK/2eWsb9UbnlMaDbY4hTRGEIYs8H6N/CrrPRo=; b=fN8tGO44vuZy5rBm8cGiaynLjV
	B07ZjjHskmrJ7JcefpTC+RIAJh2XS4uV1q8eHh32vtWedtF+w8mIEcKoAMSNCFeeuPN1n67CXX5jz
	i2gRbOVf55da8wnneY6eTNXrIgitvG6z0gX78Dx1+8pJ+V1hBlgvWT0HO/KdErTrogWY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5gUl-0000Ct-EZ;
	Sun, 13 Sep 2026 09:27:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5gUY-0000BX-Q7
 for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 09:27:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QfnkEx7gjtHOI4ynPpNJJzQ6c0x9EVxbnZQbKDDZ7as=; b=dXTZCQ+FevbxnZtmIsfzClWYK4
 MzuJNn0Yi+hwc6FvpdBQDhHTvlcryRJdnSo6hrYmS++x4TOTmpZrNzAebf7SAkK46baZYQGP21utD
 CUJPkqy/Kk0Qli+DlTmjQmW3qj5rAYHQZ9dEWNYspwLBexU+PGpEZ7v2ol7NwI28Lx5Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QfnkEx7gjtHOI4ynPpNJJzQ6c0x9EVxbnZQbKDDZ7as=; b=c
 Wd/e9c7+CuC2cE4qOj9vggTMw7XoFR5XXEafWgpVBvV5hIeFqdDPA/vGpfZNLUZ8zipUfAUzAfkBz
 +RsVykfSG8BGrBy+dm1GwFWnupkstxaAsuR3jLUHCOdSZVoI20oklD0EVlk0VIDIDI5V5uYpAh84B
 gTsngDSbd2OVqPag=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5gUE-0001uw-KB for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 09:27:01 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6351831so471691f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 13 Sep 2026 02:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789291612; x=1789896412; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QfnkEx7gjtHOI4ynPpNJJzQ6c0x9EVxbnZQbKDDZ7as=;
 b=g+lnJkGYiinA+suypWEQReV0f60uxxAGKT/oXwA/q5EFzjgWRFuE0bp+HiWfxS07d7
 FyAbmn28q+ntrreDlJ1ydvdfaEaAsEg3c1eDn3q2NWIW5el26eofGC/k+NYQjE8fauKT
 P+jFkwjJkG5pNbZDjet24Goh2FWeJ7ZBJgamyMqpVvIsHc0OIePv5hE8lmTRK3dc3Au+
 JpfXgSHLmxz+nP85s9VgluE80U8HnUwUZu87mywCo4V3O1CZJg4h4JfU6jeDpUdXUZEc
 6IMjQ57NKpsqVb1TjOVdjlYKlsrgSmVeh75hsMmqG7GZf/9nh7o49/mK66rcV2Ot2btS
 8UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789291612; x=1789896412;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QfnkEx7gjtHOI4ynPpNJJzQ6c0x9EVxbnZQbKDDZ7as=;
 b=b76biGd0wn0DXoXIVbH/goP22LKF110NpWq76oPguoSX8GmEtLVx1MDfbwEtz4fu47
 cBcPrWL3eceFtOVjYZ6O3KWKW7qX6FhdflkG4DYzGefbdzGIVyCu4qwOfgepDn1uNknv
 vYImIFP/FsW6EguXm6/JDplOjBh6au9O74xzJI4bEXLDBtJwWjctUJTwiROYDuO+gtwP
 H2uQt7bCZJj91gmXbn7f2uSKU6L8n5ywRhWLvtX0laFcNZObsIQhPsUWXBU1gjzsd5PB
 0gVM6zIfIS+BjnJoIMABEExbfCJ6f2bjM+Sj4J9M10gE2VCc2vQwOzCUwBKRDi/U+T/5
 smsw==
X-Gm-Message-State: AFuF++kZEI+LTfW2YTk5tCsgzSnz2TuLV0EbiSg38cW5jpBcOSEuqHRO
 mZyD/z8lvZF1drigg6ZGHlz5eDk910Lw2DwBn9jCZL0FUEJSefopDXvI0EnG+vj2mNdnfxgEpJd
 pILoBIbcyscJK3z3S1D1afNsY2QEB4Wv8dJqMt3a83qi1qOmewB5Fb0zD0RQc1RPQfNA/j5Hs9b
 RgtG88Tg==
X-Gm-Gg: AYBFou1lGN87jvILO8daV+o8RJ+6JhTnHNk0gz0IXPAgq8e9LxcSArin9l9PtwY5JU7
 yF6ykR6B++vHzvhPwfcjYnmxpLkkBNgcUE69zWrvyTujTPcW1DY39MLu8gMLw7DAEMSrNT8N/95
 xw3MvyA/c7vyE4NZZqcebx3ZnvEAAHRrSqvkDP14eQNgSl/EmOcDROSE/0Ql10bMoyE6Tvcv/gJ
 ZFYbqlJHaBEmXhd5dENX9OdUywe+jQBlAXWGNqHeisjfRO6pexxaDDv6anCLbsW4XYsw7e3SzPK
 FKWTZs2ylB+k7ml7MDIGzHbV8hnanPPTTp1xr+kLIZRJH/P6F8tigI4MsY6f1mo/QKVV+HFRTk9
 vFFws0BLT+LiwwSJ6ZUxGoXhPybqwTLpcfEAXjFMlRQ0YZjM2DCTTkyrdD+GDu1cemn3Y+pTgaf
 GxzkY+okQSBK0Xgzmfou5Ib9RttznaDffVCKkQJoWE7XkXnOXmNoF/TPYd3V1fgIiWF8GQ+Mvff
 e+gWwDt+S8aFjrdN6L+7MGt83smWH4/GWsuNTUjv1KX6EEYwP2T/M8k1usBMHKny4jV6U5oZg5B
 +GfuXt6KVJPmqNRwqP8fba8InLXzK4TUUtjLwN2QNOVuF7l0yjJiDgHO7JA+RQ==
X-Received: by 2002:a05:6000:4b14:b0:484:46e9:3f99 with SMTP id
 ffacd0b85a97d-486eb2dba9cmr12539828f8f.13.1789291611630; 
 Sun, 13 Sep 2026 02:26:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34e74esm18367829f8f.25.2026.09.13.02.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 02:26:51 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 13 Sep 2026 09:26:49 +0000
To: stipa <lstipakov@gmail.com>, plaisthos <arne-openvpn@rfc2549.org>,
 ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I8f2bd694146aacd244a1d385ddfe9bb84ec29334
X-Gerrit-Change-Number: 1910
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1910?usp=email>
X-Gerrit-Commit: af1f73dbe442b42b8a1addc614aa13c3485db266
In-Reply-To: <gerrit.1789114696000.I8f2bd694146aacd244a1d385ddfe9bb84ec29334@gerrit.openvpn.net>
References: <gerrit.1789114696000.I8f2bd694146aacd244a1d385ddfe9bb84ec29334@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTE0Njk2MDAwLkk4ZjJiZDY5NDE0NmFhY2QyNDRhMWQzODVkZGZlOWJiODRlYzI5MzM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <00ed2af3bef59979c3080a78b10a19fa612d4869-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5gUE-0001uw-KB
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3948493612457104524=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3948493612457104524==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dnMSbSBS6hk="; charset=UTF-8

--dnMSbSBS6hk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=3Demail )


=
Change subject: socket: factor out UDP socket creation and setup
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket: factor out UDP=
 socket creation and setup

create_socket() creates the UDP socket and then=
 applies the link
socket's options and local bind in place=2E Pull that seq=
uence into
create_socket_udp_configured(), taking the address family and th=
e
option values rather than a struct link_socket, and have create_socket()
=
call it; the TCP path keeps its own sequence through the shared
socket_appl=
y_options()=2E

--server-probe will open its probe sockets through the same=
 function, so
a probe socket is set up and bound exactly like the connectio=
n socket it
may later become=2E Its "optional" argument lets that caller tr=
eat a
socket the host cannot create as "do not probe this address family"
i=
nstead of dying; the connection path passes false and keeps the fatal
error=
=2E No behaviour change for existing callers=2E

Change-Id: I8f2bd694146aac=
d244a1d385ddfe9bb84ec29334
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1910
Message-Id: <20=
260912092917=2E27218-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39126=2Ehtml
Signed-o=
ff-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/socket=2Ec
=
M src/openvpn/socket=2Eh
2 files changed, 78 insertions(+), 28 deletions(-)=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/10/19=
10/5

diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 7f=
39268=2E=2Ef6ebf10 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/so=
cket=2Ec
@@ -565,7 +565,7 @@
 }
 
 static socket_descriptor_t
-create_socke=
t_udp(struct addrinfo *addrinfo, const unsigned int flags)
+create_socket_u=
dp(struct addrinfo *addrinfo, const unsigned int flags, bool optional)
 {
 =
    socket_descriptor_t sd;
 
@@ -575,7 +575,8 @@
     if ((sd =3D socket(a=
ddrinfo->ai_family, addrinfo->ai_socktype, addrinfo->ai_protocol))
        =
 =3D=3D SOCKET_UNDEFINED)
     {
-        msg(M_ERR, "UDP: Cannot create UD=
P/UDP6 socket");
+        msg(optional ? D_LOW | M_ERRNO : M_ERR, "UDP: Can=
not create UDP/UDP6 socket");
+        return SOCKET_UNDEFINED;
     }
 #if=
 ENABLE_IP_PKTINFO
     else if (flags & SF_USE_IP_PKTINFO)
@@ -636,12 +637=
,70 @@
     }
 }
 
+/* The per-socket options every link socket gets right =
after creation=2E */
+static void
+socket_apply_options(socket_descriptor_t=
 sd, const struct socket_buffer_size *sbs, int mark,
+                     =
const char *bind_dev)
+{
+    /* set socket buffers based on --sndbuf and -=
-rcvbuf options */
+    socket_set_buffers(sd, sbs, true);
+
+    /* set so=
cket to --mark packets with given value */
+    socket_set_mark(sd, mark);
=
+
+#if defined(TARGET_LINUX)
+    if (bind_dev)
+    {
+        msg(M_INFO,=
 "Using bind-dev %s", bind_dev);
+        /* Note: We verify strlen of bind=
_dev in options parsing */
+        if (setsockopt(sd, SOL_SOCKET, SO_BINDT=
ODEVICE, bind_dev, (socklen_t)(strlen(bind_dev) + 1))
+            !=3D 0)
=
+        {
+            msg(M_WARN | M_ERRNO, "WARN: setsockopt SO_BINDTODE=
VICE=3D%s failed", bind_dev);
+        }
+    }
+#else
+    (void)bind_dev;=

+#endif
+}
+
+socket_descriptor_t
+create_socket_udp_configured(sa_family_=
t af, unsigned int sockflags, const struct socket_buffer_size *sbs,
+      =
                       int mark, const char *bind_dev, struct addrinfo *bin=
d_addr,
+                             bool bind_ipv6_only, bool optional)
+=
{
+    struct addrinfo ai =3D { =2Eai_family =3D af, =2Eai_socktype =3D SOC=
K_DGRAM, =2Eai_protocol =3D IPPROTO_UDP };
+    socket_descriptor_t sd =3D =
create_socket_udp(&ai, sockflags, optional);
+
+    if (sd =3D=3D SOCKET_UN=
DEFINED)
+    {
+        return SOCKET_UNDEFINED;
+    }
+
+    socket_appl=
y_options(sd, sbs, mark, bind_dev);
+    if (bind_addr)
+    {
+        soc=
ket_bind(sd, bind_addr, af, "TCP/UDP", bind_ipv6_only);
+    }
+    return =
sd;
+}
+
 static void
 create_socket(struct link_socket *sock, struct addri=
nfo *addr)
 {
+    /* Set af field of sock->info, so it always reflects the=
 address family
+     * of the created socket */
+    sock->info=2Eaf =3D (=
sa_family_t)addr->ai_family;
+
     if (addr->ai_protocol =3D=3D IPPROTO_UD=
P || addr->ai_socktype =3D=3D SOCK_DGRAM)
     {
-        sock->sd =3D crea=
te_socket_udp(addr, sock->sockflags);
+        /* With a SOCKS proxy the lo=
cal bind goes on the control socket instead
+         * (see bind_local()),=
 so the UDP socket is created unbound then=2E */
+        struct addrinfo *=
bind_addr =3D
+            (sock->bind_local && !sock->socks_proxy) ? sock-=
>info=2Elsa->bind_local : NULL;
+        sock->sd =3D create_socket_udp_con=
figured(sock->info=2Eaf, sock->sockflags, &sock->socket_buffer_sizes,
+    =
                                            sock->mark, sock->bind_dev, bin=
d_addr,
+                                                sock->info=2Ebind_=
ipv6_only, false);
         sock->sockflags |=3D SF_GETADDRINFO_DGRAM;
 
  =
       /* Assume that control socket and data socket to the socks proxy
@@ =
-655,41 +714,19 @@
             addrinfo_tmp=2Eai_socktype =3D SOCK_STREAM;=

             addrinfo_tmp=2Eai_protocol =3D IPPROTO_TCP;
             sock=
->ctrl_sd =3D create_socket_tcp(&addrinfo_tmp);
+            bind_local(soc=
k);
         }
     }
     else if (addr->ai_protocol =3D=3D IPPROTO_TCP ||=
 addr->ai_socktype =3D=3D SOCK_STREAM)
     {
         sock->sd =3D create_=
socket_tcp(addr);
+        socket_apply_options(sock->sd, &sock->socket_buf=
fer_sizes, sock->mark, sock->bind_dev);
+        bind_local(sock);
     }
 =
    else
     {
         ASSERT(0);
     }
-    /* Set af field of sock->in=
fo, so it always reflects the address family
-     * of the created socket =
*/
-    sock->info=2Eaf =3D (sa_family_t)addr->ai_family;
-
-    /* set soc=
ket buffers based on --sndbuf and --rcvbuf options */
-    socket_set_buffe=
rs(sock->sd, &sock->socket_buffer_sizes, true);
-
-    /* set socket to --m=
ark packets with given value */
-    socket_set_mark(sock->sd, sock->mark);=

-
-#if defined(TARGET_LINUX)
-    if (sock->bind_dev)
-    {
-        msg(=
M_INFO, "Using bind-dev %s", sock->bind_dev);
-        /* Note: We verify s=
trlen of bind_dev in options parsing */
-        if (setsockopt(sock->sd, S=
OL_SOCKET, SO_BINDTODEVICE, sock->bind_dev,
-                       (sockle=
n_t)(strlen(sock->bind_dev) + 1))
-            !=3D 0)
-        {
-        =
    msg(M_WARN | M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=3D%s failed", s=
ock->bind_dev);
-        }
-    }
-#endif
-
-    bind_local(sock);
 }
 
 #i=
fdef TARGET_ANDROID
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socke=
t=2Eh
index c6a29f4=2E=2E46fa29c 100644
--- a/src/openvpn/socket=2Eh
+++ b/=
src/openvpn/socket=2Eh
@@ -401,6 +401,19 @@
 
 socket_descriptor_t create_s=
ocket_tcp(struct addrinfo *);
 
+/**
+ * Create a UDP socket for @p af set =
up the way a link socket is: --sndbuf/--rcvbuf,
+ * --mark, --bind-dev and,=
 when @p bind_addr is given, the local bind (IPV6_V6ONLY
+ * per @p bind_ip=
v6_only)=2E Shared by create_socket() and the --server-probe sockets,
+ * s=
o a probe socket is the connection socket it may become=2E A failed bind is=

+ * fatal; with @p optional a socket the host cannot create is not, so
+ *=
 --server-probe can skip that address family (SOCKET_UNDEFINED is returned)=
=2E
+ */
+socket_descriptor_t create_socket_udp_configured(sa_family_t af, =
unsigned int sockflags,
+                                                 c=
onst struct socket_buffer_size *sbs, int mark,
+                           =
                      const char *bind_dev, struct addrinfo *bind_addr,
+  =
                                               bool bind_ipv6_only, bool op=
tional);
+
 socket_descriptor_t socket_do_accept(socket_descriptor_t sd, st=
ruct link_socket_actual *act,
                                      const b=
ool nowait);
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1910?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8=
f2bd694146aacd244a1d385ddfe9bb84ec29334
Gerrit-Change-Number: 1910
Gerrit-P=
atchSet: 5
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandel=
bit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--dnMSbSBS6hk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by stipa=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=3Demail">=
View Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mo=
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
ns(+), 28 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/10/1910/5</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 7f39268=
=2E=2Ef6ebf10 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br=
><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -565,7 +565,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> static socket_descriptor=
_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-create_socket_udp(s=
truct addrinfo *addrinfo, const unsigned int flags)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+create_socket_udp(struct addrinfo *addrin=
fo, const unsigned int flags, bool optional)</span><br><span> {</span><br><=
span>     socket_descriptor_t sd;</span><br><span> </span><br><span>@@ -575=
,7 +575,8 @@</span><br><span>     if ((sd =3D socket(addrinfo-&gt;ai_family=
, addrinfo-&gt;ai_socktype, addrinfo-&gt;ai_protocol))</span><br><span>    =
     =3D=3D SOCKET_UNDEFINED)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_ERR, &quot;UDP: Cannot create=
 UDP/UDP6 socket&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(optional ? D_LOW | M_ERRNO : M_ERR, &quot;UDP: Cannot crea=
te UDP/UDP6 socket&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return SOCKET_UNDEFINED;</span><br><span>     }</span><br><s=
pan> #if ENABLE_IP_PKTINFO</span><br><span>     else if (flags &amp; SF_USE=
_IP_PKTINFO)</span><br><span>@@ -636,12 +637,70 @@</span><br><span>     }</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* The per-socket options every link socket gets right afte=
r creation=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_appl=
y_options(socket_descriptor_t sd, const struct socket_buffer_size *sbs, int=
 mark,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
        const char *bind_dev)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* s=
et socket buffers based on --sndbuf and --rcvbuf options */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    socket_set_buffers(sd, sbs, tru=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* set socket to --mark packets=
 with given value */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    socket_set_mark(sd, mark);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if def=
ined(TARGET_LINUX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (bind_dev)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_INF=
O, &quot;Using bind-dev %s&quot;, bind_dev);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* Note: We verify strlen of bind_dev in o=
ptions parsing */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (setsockopt(sd, SOL_SOCKET, SO_BINDTODEVICE, bind_dev, (socklen_t)=
(strlen(bind_dev) + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      msg(M_WARN | M_ERRNO, &quot;WARN: setsockopt SO_BINDTODEVICE=3D%s fai=
led&quot;, bind_dev);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    (void)bind_dev;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_desc=
riptor_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+create_sock=
et_udp_configured(sa_family_t af, unsigned int sockflags, const struct sock=
et_buffer_size *sbs,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                             int mark, const char *bind_dev, struct addrin=
fo *bind_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                        bool bind_ipv6_only, bool optional)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct addrinfo ai =3D { =2Eai_family =3D af, =2E=
ai_socktype =3D SOCK_DGRAM, =2Eai_protocol =3D IPPROTO_UDP };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    socket_descriptor_t sd =3D cr=
eate_socket_udp(&amp;ai, sockflags, optional);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (sd =3D=3D SOCKET_UNDEFINED)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return SOCKET_UNDEFINED;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socket=
_apply_options(sd, sbs, mark, bind_dev);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (bind_addr)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        socket_bind(sd, bind_addr, af, &quot;TCP/UDP&quot;, bind_ipv6=
_only);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return sd;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span> cr=
eate_socket(struct link_socket *sock, struct addrinfo *addr)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Set af f=
ield of sock-&gt;info, so it always reflects the address family</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * of the created socket */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;info=
=2Eaf =3D (sa_family_t)addr-&gt;ai_family;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>     if (addr-&gt;ai_protocol =3D=
=3D IPPROTO_UDP || addr-&gt;ai_socktype =3D=3D SOCK_DGRAM)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sock-&g=
t;sd =3D create_socket_udp(addr, sock-&gt;sockflags);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* With a SOCKS proxy the local b=
ind goes on the control socket instead</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         * (see bind_local()), so the UDP socket is crea=
ted unbound then=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        struct addrinfo *bind_addr =3D</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            (sock-&gt;bind_local &amp;&amp; !sock-&gt=
;socks_proxy) ? sock-&gt;info=2Elsa-&gt;bind_local : NULL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;sd =3D create_socke=
t_udp_configured(sock-&gt;info=2Eaf, sock-&gt;sockflags, &amp;sock-&gt;sock=
et_buffer_sizes,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                             sock-&gt;mark, sock-&gt;bind_d=
ev, bind_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                           sock-&gt;info=2Ebind_ipv6_only, =
false);</span><br><span>         sock-&gt;sockflags |=3D SF_GETADDRINFO_DGR=
AM;</span><br><span> </span><br><span>         /* Assume that control socke=
t and data socket to the socks proxy</span><br><span>@@ -655,41 +714,19 @@<=
/span><br><span>             addrinfo_tmp=2Eai_socktype =3D SOCK_STREAM;</s=
pan><br><span>             addrinfo_tmp=2Eai_protocol =3D IPPROTO_TCP;</spa=
n><br><span>             sock-&gt;ctrl_sd =3D create_socket_tcp(&amp;addrin=
fo_tmp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 bind_local(sock);</span><br><span>         }</span><br><span>     }</span>=
<br><span>     else if (addr-&gt;ai_protocol =3D=3D IPPROTO_TCP || addr-&gt=
;ai_socktype =3D=3D SOCK_STREAM)</span><br><span>     {</span><br><span>   =
      sock-&gt;sd =3D create_socket_tcp(addr);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        socket_apply_options(sock-&gt;sd, &amp;s=
ock-&gt;socket_buffer_sizes, sock-&gt;mark, sock-&gt;bind_dev);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        bind_local(sock);</span=
><br><span>     }</span><br><span>     else</span><br><span>     {</span><b=
r><span>         ASSERT(0);</span><br><span>     }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    /* Set af field of sock-&gt;info, so it al=
ways reflects the address family</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-     * of the created socket */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    sock-&gt;info=2Eaf =3D (sa_family_t)addr-&gt;ai_fa=
mily;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    /* set socket buffers based on --=
sndbuf and --rcvbuf options */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    socket_set_buffers(sock-&gt;sd, &amp;sock-&gt;socket_buffer_si=
zes, true);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* set socket to --mark pac=
kets with given value */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    socket_set_mark(sock-&gt;sd, sock-&gt;mark);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(TARGET_LINUX)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (sock-&gt;bind_dev)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        msg(M_INFO, &quot;Using bind-dev %s&quot;, sock-&gt;bind_dev);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Note: We ve=
rify strlen of bind_dev in options parsing */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (setsockopt(sock-&gt;sd, SOL_SOCKET, SO_=
BINDTODEVICE, sock-&gt;bind_dev,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                       (socklen_t)(strlen(sock-&gt;bind_dev) + 1=
))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            !=3D 0)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN | M_ERRNO,=
 &quot;WARN: setsockopt SO_BINDTODEVICE=3D%s failed&quot;, sock-&gt;bind_de=
v);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bin=
d_local(sock);</span><br><span> }</span><br><span> </span><br><span> #ifdef=
 TARGET_ANDROID</span><br><span>diff --git a/src/openvpn/socket=2Eh b/src/o=
penvpn/socket=2Eh</span><br><span>index c6a29f4=2E=2E46fa29c 100644</span><=
br><span>--- a/src/openvpn/socket=2Eh</span><br><span>+++ b/src/openvpn/soc=
ket=2Eh</span><br><span>@@ -401,6 +401,19 @@</span><br><span> </span><br><s=
pan> socket_descriptor_t create_socket_tcp(struct addrinfo *);</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Create a UDP socket for @p =
af set up the way a link socket is: --sndbuf/--rcvbuf,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * --mark, --bind-dev and, when @p bind_=
addr is given, the local bind (IPV6_V6ONLY</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * per @p bind_ipv6_only)=2E Shared by create_socket=
() and the --server-probe sockets,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * so a probe socket is the connection socket it may become=
=2E A failed bind is</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * fatal; with @p optional a socket the host cannot create is not, so</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --server-probe can sk=
ip that address family (SOCKET_UNDEFINED is returned)=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+socket_descriptor_t create_socket_udp_configured(sa_fa=
mily_t af, unsigned int sockflags,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                                 const struc=
t socket_buffer_size *sbs, int mark,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                                 const cha=
r *bind_dev, struct addrinfo *bind_addr,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                                 bool =
bind_ipv6_only, bool optional);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> socket_descriptor_t socket_do_accept(socket_d=
escriptor_t sd, struct link_socket_actual *act,</span><br><span>           =
                           const bool nowait);</span><br><span> </span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1910?usp=3Demail">change 1910</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I8f2bd694146aacd244a1d385d=
dfe9bb84ec29334 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
910 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf=
_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--dnMSbSBS6hk=--


--===============3948493612457104524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3948493612457104524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3948493612457104524==--

