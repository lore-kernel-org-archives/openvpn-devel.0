Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A16C88E50
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=riFdspgP2pItJxsMrNFyVpKlws+qXjVBu9m9/CD4s0I=; b=Ud+H7iaHpbUff4PTFxvXCS1Rnx
	v1ab1LMaKH5ZPIyzKtwN1P8zgK0v7Wj0r16/0YiGx9Ge6qJ+XG59lc3Xg2xJhPHsemP7gQuCYyjdV
	DbcaBhnBmCt2pQwQIveDSyKe9EZ7c5RkbLO7Ui6jvj9eHsHlj9bGeqPQpfD16zlTatik=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5368-0008SV-2E;
	Fri, 11 Sep 2026 15:23:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5367-0008SP-Jc
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:23:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zDk5ZpSarSxAylJrW8iC2+nqBdCKF0vVV2U4mHO6YV4=; b=YmrAPyaTm664T55neEKqaeVppD
 chkXvPpBl+NMDiVCixhvT7JxGmh//rbKdaN5UIcR40Hbrv2266M29N2TnfKeDVPrPIk++9zXi//xX
 2MnIs3E4+irHN6exujsDbZauYWzFRDtlE2M99Zjf2fu4WvmON1t/WnWihpNIRMQowHt0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zDk5ZpSarSxAylJrW8iC2+nqBdCKF0vVV2U4mHO6YV4=; b=E
 kMAMrySb1UJ3QOJUzR1bnBMof44wUzZveQseeobyNxVFjdc8COsXChwBOf6L2dv23QVESKaGzwaIa
 bvkSvxA2G1FnJ9p8bPyaKCFpVL7TFSdfUmxv7LUuTFAtIGWppuADn3+LMxTXXszY9CHDYMCm6w4oL
 z6HMQ1cf8H4VD87c=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5366-0007aL-TU for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:23:28 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f62ccdb1so339582f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789140200; x=1789745000; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zDk5ZpSarSxAylJrW8iC2+nqBdCKF0vVV2U4mHO6YV4=;
 b=dCjc2TuarKWQnEiHxPRUTp9maNG7KijW6QlK4aDP5jKNcVY35VbUo9Qt6jdbez7Y6A
 O6GmC0GjtiJdPUjSiy22vuBATPD1CBEqxRrVUZgcLyil2AjoWjoYK/q1fVfLIGNvQL+6
 B+HS0c9FtuCoa41i3Xq3jQ54s++OnBTlOYnErpgVe9xB+RFwT5B7zslRtiDy0HqetGvL
 EWhdO8OULPZ0QB3ie0n4BRsRzoXpiqIGQ7UFoo1t8bx3c4rrlQwR8zE5FSYd8NsxjSMQ
 TeVJfvH+71JDLnSUuc948WWjrK0vOJV6wUX7WieHQSinOsCzT2fVeC5OS4jDqirGwQ5g
 w0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789140200; x=1789745000;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zDk5ZpSarSxAylJrW8iC2+nqBdCKF0vVV2U4mHO6YV4=;
 b=NstOvLPCzrDRtbRwrFnDcq2wa7RhtiRacmIWaFEvAgzQ0se+HdgYB/xI1h/DJUlr+Y
 g+dqFCVoab/Wv01aiTwa7lfOIUBFpb1vScpy3kYm4J1FlcgpaaEvhWjryaENpDK/5RqL
 Cw9LkBrPZ1dnjmcH2RQjqy3zkZuDwgRcs79ZOAMNjPXAFXlq2wbehmdRRF9l0Mi0hc5e
 Ht49a1OwlAV8xlCLU3f41sLgv64fjhZ6l58uyWdGJskjI8ISnyyjF2Sr0bFeujj6PB90
 BrqpddEX5pr+toEZHirLg0oANKoUG0YmLoOGcspzLoscvUSqxg+zOAUlSbttvKo/kVAD
 TWtQ==
X-Gm-Message-State: AFuF++kqgudY9EPcykqeXwgubgJ8yy6u23wor9ZzWc6xuQdv2f01JYit
 nSo1BkVWV1BX/KzgwDFag5khtVes2VQzSvDlZzPbnRf7riveJ1LkTpLIOKNPq8H0aUw/pAFAJCa
 pOVgB6TB1U8mkpwKjrfhZrqq3kv4dnVU1/vHvstbgRFPvjAtLADcAweQ6sBdcimkl8FKR
X-Gm-Gg: AYBFou3yE6gqWrvj4W7DC8DfNNMeFzwHBUFy6vr0fzrctpZ4ai48wxNNOjBv3JHUlK6
 iwpxBvzQscRl8Tay8pHGQmgAdLwHCsezmbbpQyKftWTz+zJFgMg6bjTpAv5F4CpJDsv4RcLxRCk
 kGLJX3IOvwdOyy+zsDWO529DF+QWCgrXeVzwjO7+DrHBIcq2XWlbrfwemt2PW7pNhQdFLbG2bLA
 CbMDL3sH3PVbwFrp9yE2qZgPcWxRvpeIJJwDhcWdR08rabT35tnnU73hkWbk6GbUUq0W8WMiP8X
 ElQHSnJFbvVDbJtbN04vUYOoIc2jv26sRDlFuJHwlSoftfPRgs04vNuFKUVSDb/Xc1WLDf7/7DJ
 odh2IGqlugpXcTyzoJWYHfsK0O8+sCyM38sUOWrQOtrMwxagDKmedBK6ln7NkTDvIpxKmWdEvwg
 ZEPTFYJsjonlVrlv66kllzhsScP2KcQL6GUrUPAK203qol1Jof98cARjL7pg66npqXt7aTw3uEA
 lD7TgBCcBaiMj9fq84rWe+4ZSOmeANYPtyXzos+2jhMuApUOPjz/VwsaUcbDPV2MAH+h6xgLuZI
 qkDSWaUsOsmB2nN3mKGixffwPPSJV8jFBF/kyw/zxqVbfsyr8nW6XsbP4vbcPEjHjflT/Vq0jA=
 =
X-Received: by 2002:a05:6000:2589:b0:486:f29d:f1b2 with SMTP id
 ffacd0b85a97d-486f29df210mr2816602f8f.0.1789140200006; 
 Fri, 11 Sep 2026 08:23:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb36e4a6sm6811850f8f.37.2026.09.11.08.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:23:19 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:23:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I8f2bd694146aacd244a1d385ddfe9bb84ec29334
X-Gerrit-Change-Number: 1910
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1910?usp=email>
X-Gerrit-Commit: 14405c4b129ad134ba8847f7f8a2cd825bffa0fc
In-Reply-To: <gerrit.1789114696000.I8f2bd694146aacd244a1d385ddfe9bb84ec29334@gerrit.openvpn.net>
References: <gerrit.1789114696000.I8f2bd694146aacd244a1d385ddfe9bb84ec29334@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTE0Njk2MDAwLkk4ZjJiZDY5NDE0NmFhY2QyNDRhMWQzODVkZGZlOWJiODRlYzI5MzM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <21cb2660fe86bdb6955547fdf480962304839715-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5366-0007aL-TU
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
Content-Type: multipart/mixed; boundary="===============4194617630090934455=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4194617630090934455==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="h4hjN8qK57Y="; charset=UTF-8

--h4hjN8qK57Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=3Demail

to look a=
t the new patch set (#3)=2E

The following approvals got outdated and were =
removed:
Code-Review+2 by ralf_lici


Change subject: socket: factor out UD=
P socket creation and setup
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

socket: factor out UDP socket creation and setup

create_s=
ocket() creates the UDP socket and then applies the link
socket's options a=
nd local bind in place=2E Pull that sequence into
create_socket_udp_configu=
red(), taking the address family and the
option values rather than a struct=
 link_socket, and have create_socket()
call it; the TCP path keeps its own =
sequence through the shared
socket_apply_options()=2E

--server-probe will =
open its probe sockets through the same function, so
a probe socket is set =
up and bound exactly like the connection socket it
may later become=2E No b=
ehaviour change here=2E

Change-Id: I8f2bd694146aacd244a1d385ddfe9bb84ec293=
34
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/socket=
=2Ec
M src/openvpn/socket=2Eh
2 files changed, 69 insertions(+), 26 deletio=
ns(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
10/1910/3

diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
ind=
ex 7c6217a=2E=2Ec2e7f7b 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openv=
pn/socket=2Ec
@@ -636,12 +636,65 @@
     }
 }
 
+/* The per-socket options =
every link socket gets right after creation=2E */
+static void
+socket_appl=
y_options(socket_descriptor_t sd, const struct socket_buffer_size *sbs, int=
 mark,
+                     const char *bind_dev)
+{
+    /* set socket bu=
ffers based on --sndbuf and --rcvbuf options */
+    socket_set_buffers(sd,=
 sbs, true);
+
+    /* set socket to --mark packets with given value */
+  =
  socket_set_mark(sd, mark);
+
+#if defined(TARGET_LINUX)
+    if (bind_dev=
)
+    {
+        msg(M_INFO, "Using bind-dev %s", bind_dev);
+        /* N=
ote: We verify strlen of bind_dev in options parsing */
+        if (setsoc=
kopt(sd, SOL_SOCKET, SO_BINDTODEVICE, bind_dev, (socklen_t)(strlen(bind_dev=
) + 1))
+            !=3D 0)
+        {
+            msg(M_WARN | M_ERRNO, =
"WARN: setsockopt SO_BINDTODEVICE=3D%s failed", bind_dev);
+        }
+    =
}
+#else
+    (void)bind_dev;
+#endif
+}
+
+socket_descriptor_t
+create_soc=
ket_udp_configured(sa_family_t af, unsigned int sockflags, const struct soc=
ket_buffer_size *sbs,
+                             int mark, const char *b=
ind_dev, struct addrinfo *bind_addr,
+                             bool bin=
d_ipv6_only)
+{
+    struct addrinfo ai =3D { =2Eai_family =3D af, =2Eai_so=
cktype =3D SOCK_DGRAM, =2Eai_protocol =3D IPPROTO_UDP };
+    socket_descri=
ptor_t sd =3D create_socket_udp(&ai, sockflags);
+
+    socket_apply_option=
s(sd, sbs, mark, bind_dev);
+    if (bind_addr)
+    {
+        socket_bind=
(sd, bind_addr, af, "TCP/UDP", bind_ipv6_only);
+    }
+    return sd;
+}
+=

 static void
 create_socket(struct link_socket *sock, struct addrinfo *add=
r)
 {
+    /* Set af field of sock->info, so it always reflects the address=
 family
+     * of the created socket */
+    sock->info=2Eaf =3D (sa_famil=
y_t)addr->ai_family;
+
     if (addr->ai_protocol =3D=3D IPPROTO_UDP || add=
r->ai_socktype =3D=3D SOCK_DGRAM)
     {
-        sock->sd =3D create_socke=
t_udp(addr, sock->sockflags);
+        /* With a SOCKS proxy the local bind=
 goes on the control socket instead
+         * (see bind_local()), so the =
UDP socket is created unbound then=2E */
+        struct addrinfo *bind_add=
r =3D
+            (sock->bind_local && !sock->socks_proxy) ? sock->info=2E=
lsa->bind_local : NULL;
+        sock->sd =3D create_socket_udp_configured(=
sock->info=2Eaf, sock->sockflags, &sock->socket_buffer_sizes,
+            =
                                    sock->mark, sock->bind_dev, bind_addr,
=
+                                                sock->info=2Ebind_ipv6_onl=
y);
         sock->sockflags |=3D SF_GETADDRINFO_DGRAM;
 
         /* Assum=
e that control socket and data socket to the socks proxy
@@ -655,41 +708,19=
 @@
             addrinfo_tmp=2Eai_socktype =3D SOCK_STREAM;
             a=
ddrinfo_tmp=2Eai_protocol =3D IPPROTO_TCP;
             sock->ctrl_sd =3D c=
reate_socket_tcp(&addrinfo_tmp);
+            bind_local(sock);
         }
=
     }
     else if (addr->ai_protocol =3D=3D IPPROTO_TCP || addr->ai_sockt=
ype =3D=3D SOCK_STREAM)
     {
         sock->sd =3D create_socket_tcp(addr=
);
+        socket_apply_options(sock->sd, &sock->socket_buffer_sizes, sock=
->mark, sock->bind_dev);
+        bind_local(sock);
     }
     else
     {=

         ASSERT(0);
     }
-    /* Set af field of sock->info, so it alway=
s reflects the address family
-     * of the created socket */
-    sock->i=
nfo=2Eaf =3D (sa_family_t)addr->ai_family;
-
-    /* set socket buffers bas=
ed on --sndbuf and --rcvbuf options */
-    socket_set_buffers(sock->sd, &s=
ock->socket_buffer_sizes, true);
-
-    /* set socket to --mark packets wit=
h given value */
-    socket_set_mark(sock->sd, sock->mark);
-
-#if defined=
(TARGET_LINUX)
-    if (sock->bind_dev)
-    {
-        msg(M_INFO, "Using =
bind-dev %s", sock->bind_dev);
-        /* Note: We verify strlen of bind_d=
ev in options parsing */
-        if (setsockopt(sock->sd, SOL_SOCKET, SO_B=
INDTODEVICE, sock->bind_dev,
-                       (socklen_t)(strlen(soc=
k->bind_dev) + 1))
-            !=3D 0)
-        {
-            msg(M_WARN =
| M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=3D%s failed", sock->bind_dev);=

-        }
-    }
-#endif
-
-    bind_local(sock);
 }
 
 #ifdef TARGET_AND=
ROID
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index 894=
65bc=2E=2E905b4fd 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/soc=
ket=2Eh
@@ -401,6 +401,18 @@
 
 socket_descriptor_t create_socket_tcp(struc=
t addrinfo *);
 
+/**
+ * Create a UDP socket for @p af set up the way a li=
nk socket is: --sndbuf/--rcvbuf,
+ * --mark, --bind-dev and, when @p bind_a=
ddr is given, the local bind (IPV6_V6ONLY
+ * per @p bind_ipv6_only)=2E Sha=
red by create_socket() and the --server-probe sockets,
+ * so a probe socke=
t is the connection socket it may become=2E Fatal if the socket
+ * cannot =
be created or bound=2E
+ */
+socket_descriptor_t create_socket_udp_configur=
ed(sa_family_t af, unsigned int sockflags,
+                               =
                  const struct socket_buffer_size *sbs, int mark,
+        =
                                         const char *bind_dev, struct addri=
nfo *bind_addr,
+                                                 bool bind=
_ipv6_only);
+
 socket_descriptor_t socket_do_accept(socket_descriptor_t sd=
, struct link_socket_actual *act,
                                      con=
st bool nowait);
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1910?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I8f2bd694146aacd244a1d385ddfe9bb84ec29334
Gerrit-Change-Number: 1910
Gerr=
it-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@ma=
ndelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov=
@gmail=2Ecom>

--h4hjN8qK57Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=3Demail">View Change</a></p><p>Th=
e following approvals got outdated and were removed:
Code-Review+2 by ralf_=
lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">socket: factor out UDP socket creation and setup<br><=
br>create_socket() creates the UDP socket and then applies the link<br>sock=
et&#39;s options and local bind in place=2E Pull that sequence into<br>crea=
te_socket_udp_configured(), taking the address family and the<br>option val=
ues rather than a struct link_socket, and have create_socket()<br>call it; =
the TCP path keeps its own sequence through the shared<br>socket_apply_opti=
ons()=2E<br><br>--server-probe will open its probe sockets through the same=
 function, so<br>a probe socket is set up and bound exactly like the connec=
tion socket it<br>may later become=2E No behaviour change here=2E<br><br>Ch=
ange-Id: I8f2bd694146aacd244a1d385ddfe9bb84ec29334<br>Signed-off-by: Lev St=
ipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/socket=2Ec<br>M sr=
c/openvpn/socket=2Eh<br>2 files changed, 69 insertions(+), 26 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/10/1910/3</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/socket=2Ec b/sr=
c/openvpn/socket=2Ec</span><br><span>index 7c6217a=2E=2Ec2e7f7b 100644</spa=
n><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/=
socket=2Ec</span><br><span>@@ -636,12 +636,65 @@</span><br><span>     }</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/* The per-socket options every link socket gets right after =
creation=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_apply_=
options(socket_descriptor_t sd, const struct socket_buffer_size *sbs, int m=
ark,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
      const char *bind_dev)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* set=
 socket buffers based on --sndbuf and --rcvbuf options */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    socket_set_buffers(sd, sbs, true)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* set socket to --mark packets w=
ith given value */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   socket_set_mark(sd, mark);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(TARGET_LINUX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (bind_dev)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO,=
 &quot;Using bind-dev %s&quot;, bind_dev);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* Note: We verify strlen of bind_dev in opt=
ions parsing */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (setsockopt(sd, SOL_SOCKET, SO_BINDTODEVICE, bind_dev, (socklen_t)(s=
trlen(bind_dev) + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(M_WARN | M_ERRNO, &quot;WARN: setsockopt SO_BINDTODEVICE=3D%s faile=
d&quot;, bind_dev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    (void)bind_dev;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_descri=
ptor_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+create_socket=
_udp_configured(sa_family_t af, unsigned int sockflags, const struct socket=
_buffer_size *sbs,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                            int mark, const char *bind_dev, struct addrinfo=
 *bind_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                      bool bind_ipv6_only)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct addrinfo ai =3D { =2Eai_family =3D af, =2Eai_socktype =3D S=
OCK_DGRAM, =2Eai_protocol =3D IPPROTO_UDP };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    socket_descriptor_t sd =3D create_socket_udp(&=
amp;ai, sockflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socket_apply_op=
tions(sd, sbs, mark, bind_dev);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (bind_addr)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     socket_bind(sd, bind_addr, af, &quot;TCP/UDP&quot;, bind_ipv6_only);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return sd;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> static void</span><br><span> create_sock=
et(struct link_socket *sock, struct addrinfo *addr)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Set af field of s=
ock-&gt;info, so it always reflects the address family</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * of the created socket */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;info=2Eaf =3D (=
sa_family_t)addr-&gt;ai_family;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>     if (addr-&gt;ai_protocol =3D=3D IPPROTO_U=
DP || addr-&gt;ai_socktype =3D=3D SOCK_DGRAM)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;sd =3D crea=
te_socket_udp(addr, sock-&gt;sockflags);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        /* With a SOCKS proxy the local bind goes on t=
he control socket instead</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+         * (see bind_local()), so the UDP socket is created unbound t=
hen=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        st=
ruct addrinfo *bind_addr =3D</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            (sock-&gt;bind_local &amp;&amp; !sock-&gt;socks_proxy)=
 ? sock-&gt;info=2Elsa-&gt;bind_local : NULL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        sock-&gt;sd =3D create_socket_udp_configu=
red(sock-&gt;info=2Eaf, sock-&gt;sockflags, &amp;sock-&gt;socket_buffer_siz=
es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                                sock-&gt;mark, sock-&gt;bind_dev, bind_addr=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                              sock-&gt;info=2Ebind_ipv6_only);</span><br><s=
pan>         sock-&gt;sockflags |=3D SF_GETADDRINFO_DGRAM;</span><br><span>=
 </span><br><span>         /* Assume that control socket and data socket to=
 the socks proxy</span><br><span>@@ -655,41 +708,19 @@</span><br><span>    =
         addrinfo_tmp=2Eai_socktype =3D SOCK_STREAM;</span><br><span>      =
       addrinfo_tmp=2Eai_protocol =3D IPPROTO_TCP;</span><br><span>        =
     sock-&gt;ctrl_sd =3D create_socket_tcp(&amp;addrinfo_tmp);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            bind_local(sock);</=
span><br><span>         }</span><br><span>     }</span><br><span>     else =
if (addr-&gt;ai_protocol =3D=3D IPPROTO_TCP || addr-&gt;ai_socktype =3D=3D =
SOCK_STREAM)</span><br><span>     {</span><br><span>         sock-&gt;sd =
=3D create_socket_tcp(addr);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        socket_apply_options(sock-&gt;sd, &amp;sock-&gt;socket_buf=
fer_sizes, sock-&gt;mark, sock-&gt;bind_dev);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        bind_local(sock);</span><br><span>     }<=
/span><br><span>     else</span><br><span>     {</span><br><span>         A=
SSERT(0);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* Set af field of sock-&gt;info, so it always reflects the =
address family</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * =
of the created socket */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    sock-&gt;info=2Eaf =3D (sa_family_t)addr-&gt;ai_family;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* set socket buffers based on --sndbuf and --rcvbu=
f options */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    socke=
t_set_buffers(sock-&gt;sd, &amp;sock-&gt;socket_buffer_sizes, true);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    /* set socket to --mark packets with given va=
lue */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    socket_set_=
mark(sock-&gt;sd, sock-&gt;mark);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defin=
ed(TARGET_LINUX)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (sock-&gt;bind_dev)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_IN=
FO, &quot;Using bind-dev %s&quot;, sock-&gt;bind_dev);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        /* Note: We verify strlen of bind_=
dev in options parsing */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (setsockopt(sock-&gt;sd, SOL_SOCKET, SO_BINDTODEVICE, sock-&=
gt;bind_dev,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
              (socklen_t)(strlen(sock-&gt;bind_dev) + 1))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            !=3D 0)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            msg(M_WARN | M_ERRNO, &quot;WARN: setsock=
opt SO_BINDTODEVICE=3D%s failed&quot;, sock-&gt;bind_dev);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    bind_local(sock);</span=
><br><span> }</span><br><span> </span><br><span> #ifdef TARGET_ANDROID</spa=
n><br><span>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</s=
pan><br><span>index 89465bc=2E=2E905b4fd 100644</span><br><span>--- a/src/o=
penvpn/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><s=
pan>@@ -401,6 +401,18 @@</span><br><span> </span><br><span> socket_descript=
or_t create_socket_tcp(struct addrinfo *);</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Create a UDP socket for @p af set up the way a =
link socket is: --sndbuf/--rcvbuf,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * --mark, --bind-dev and, when @p bind_addr is given, the l=
ocal bind (IPV6_V6ONLY</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * per @p bind_ipv6_only)=2E Shared by create_socket() and the --server-=
probe sockets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * so=
 a probe socket is the connection socket it may become=2E Fatal if the sock=
et</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * cannot be crea=
ted or bound=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_descriptor_t =
create_socket_udp_configured(sa_family_t af, unsigned int sockflags,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
                       const struct socket_buffer_size *sbs, int mark,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
                         const char *bind_dev, struct addrinfo *bind_addr,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                             bool bind_ipv6_only);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> socket_descriptor_t socket=
_do_accept(socket_descriptor_t sd, struct link_socket_actual *act,</span><b=
r><span>                                      const bool nowait);</span><br=
><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=3Demail">change 1910</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1910?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8f2bd694=
146aacd244a1d385ddfe9bb84ec29334 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1910 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3=
 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
=

</body></html>
--h4hjN8qK57Y=--


--===============4194617630090934455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4194617630090934455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4194617630090934455==--

