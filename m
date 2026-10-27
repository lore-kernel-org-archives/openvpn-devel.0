Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E09F606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JHUFf/LZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aT6ZWCvr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZhhMpShE;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bPSuFMg5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=b7EBig3cZLl492dEO2pxI54LpaOsNEEGtJlD3iJNUik=; b=JHUFf/LZ0mBCPl0jou9+PIAt7+
	SUqcQ8CRcd09IYtwbhcwHFvEAw69A5cX/sHbnYtRIMgqllRlfbCpoBQ6tMVeslaj1leJf+tX3cg/2
	ooJ1I3umB7fiKjOGtuzA6HwAgrGC9UBqrnLmyehu6A15TsVa1TyPrp14A9MlYKH76NEw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLeCZ-000000005iv-2FGj;
	Tue, 27 Oct 2026 10:14:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLeCY-000000005io-0Oh9
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:14:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eYaRvMpInFR6raEtQ+22vrC9cgmcRN7mEuwl9ysRvCI=; b=aT6ZWCvrP5Y0IQpgPKepq7Nj5O
 lgO+Y3ANfI36SO4eNRhDIwIj40Nfisel4LsH3IrH5crMdoryUi72zr+x2icXNGw2s5iU+8r7cF71z
 NsCup8ZPGfEUbk9+G1EljPdtyFNeqnkAbqEaSqC/70jLz5b8lYfWF4FgR0X4bYaPWFRE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eYaRvMpInFR6raEtQ+22vrC9cgmcRN7mEuwl9ysRvCI=; b=ZhhMpShEXlU7409N8O4M10rifw
 ol+QAXqUSjtP9qsGgDQIV2IUVmJVR1Me2icqv/lz8CkP9z4T8xbbbBN260t3vxYX/+FLgTxtsbKSh
 UPoP/1sKgkIFYhoJHd6eEp0FFP4SuXWbD/d4CaNtMDCFK68RPfjdLjM6uJk0VwOaKeL8=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLeCV-000000001zn-3bfF for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:14:42 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so2280950f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 03:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793096073; x=1793700873; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eYaRvMpInFR6raEtQ+22vrC9cgmcRN7mEuwl9ysRvCI=;
 b=bPSuFMg5Yb7yVANpdFK4/TlJc652ermcEuZdgEkWBrhQWWjjgs3apU/5xKC3Hu1iIz
 lD5wBvbyYwfGJSlxAu0Eu0kyTDiTO7vkj6jg86FvMYYMw20u8izxwwbZFt4PUmtcBidf
 h8GwP+gGuON2wHGM06LdfzLWojmHnRna238BsaJxeB8SUdhcPITSpyyuF760619bnd0k
 SzYLhybMPtIIZPopJzuGtEBc5HxejVELGtXv65DSL/v/k9wmzCUn5aDbptXJawUcBfCM
 Z5owmMXA8bXMzZus0l7JSQC5X3b5NBRnNFiYU3vBkMx+SIzPsdT4PuvS6QBZhyYAlBsy
 91KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793096073; x=1793700873;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eYaRvMpInFR6raEtQ+22vrC9cgmcRN7mEuwl9ysRvCI=;
 b=T03l8VaCJZ0TfEQY4PlfknUcoOv4IPvGwt/VyHMCsKZfXNmt7dl82pK15rDEzqx6yN
 5HkQ3LNuhMTDW69C5xUZRW6rDOQ5+8ZS8Aq7u7nue6k2MR83L4TWU+eqFdqA6wLM9CR8
 Pm+fQ5uqMLoYBjrFywtQaGU22ErvxsYX49saCJwJ/z4Rt84TxNsvkigBraRrZRA1zx61
 HlHN/UYtUGzsravybCf8NCreDVX2NL9K449AaDUg5gJrhd3zD/+XDIV36VDWAk+d4KTV
 tjilAHDNExC2ZrynMeVhPMQMjgvIru76tH+aIP2KF7k3axgZDKLBeOVgPhB/feYZ2/4E
 4Pjw==
X-Gm-Message-State: AFq9FYJHTXWO4Pjk6QfkIzElodt2ztAUTlCicsCNDQl/SB2iXFY2fN/P
 U63aM0+hBcz4A0WGCaOws7DN0iWn0ypugtEh9KexXnFHuyLdN74noe8jtGlAz08YYkM4xDAQctR
 k5y15LSD/k2CS+BLpzxj6NCT6Q7LyJuUwI9kZQLTbCJlz+qt8QDEffl+2VN+Ib2cYVFN1F4BLq/
 U/I/Cq4Q==
X-Gm-Gg: AYBFou2dP2w6dcMInrXPuYuInMoDBPbENsri5yjclv9jIfAsWcszzZSgm1UDgLsx3mI
 8bNRpmu8R+xXA8EzuUH1CqriYzo7uQjhBoHLwTQ9XaZ491lwa5CrECiKllGQjvFghMXJdwsdgyG
 zMe/w/Q3gaCXH8rgFoBrF1TflWqoV3NdCTVtFm/wRIAoX+Kfzgo7cTwM3PACGi5Uurj0pvRhXjt
 /+HzMxrVuBTtFgL+rSIENbrp+P6+0E1kQrBCInecPg03WVjm875PV/ungj1Quw2i88YoGVh+gfY
 cI2gEDfz4TUaZM0ampUlBAP8PWtOh28Wh05pyXLPYBr3ybGfaE/6Xd2tffAiWLdWLT1riD6BPTf
 XZtA2Baq0EpYG91YkZ6HSHUtyz/9cSnIgD0OUafGwOgXRuFL8ebFzyBREoKXgCIFNzLdXDufcB7
 OQytFeQekCrRpSPle+KrNIPin9nuYXOeuiu/dscCLMUIZJ1borW0Cf/v9hoUkmeS3IGqqobs0Vz
 Vazr+2OEM8DR92WihLx5Mx2Bd4WW0tYNKXgk3+KhtYUhQS8AXZ2b0ZDshOOqov3JBH7/kXtRaDC
 lnPbyUZaU7Ko90SPl8uZhLQ38+YxxRQw58MpVMG+kBdFY5lZ5vm1FXdL7GF+jQnzU9h8VUkOKYq
 EHz9yBrfWzlTWGk63w7p/aW8ZhKMlgyilpdmcyyJoNw==
X-Received: by 2002:a05:6000:1883:b0:48d:ee0d:8b3d with SMTP id
 ffacd0b85a97d-48e3eb93317mr16663684f8f.28.1793096072886; 
 Tue, 27 Oct 2026 03:14:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd48eesm21890531f8f.30.2026.10.27.03.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 03:14:32 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 10:14:31 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ibc3194b64f8a69d2877097157311ff5d6cd2911e
X-Gerrit-Change-Number: 2053
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2053?usp=email>
X-Gerrit-Commit: ad067bb3c1730bced3863a6e64d0418da1c48438
References: <gerrit.1793096063000.Ibc3194b64f8a69d2877097157311ff5d6cd2911e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk2MDYzMDAwLkliYzMxOTRiNjRmOGE2OWQyODc3MDk3MTU3MzExZmY1ZDZjZDI5MTFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ead2752f0f3a4b66d2c2d47f7e0c1bb9139de799-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLeCV-000000001zn-3bfF
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: introduce
 INDIRECT transport protocol abstraction
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3610636525665712231=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3610636525665712231==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LWUrL1RNpxc="; charset=UTF-8

--LWUrL1RNpxc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2053?usp=3Demail

to review the following change=2E
=


Change subject: socket: introduce INDIRECT transport protocol abstraction=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket: in=
troduce INDIRECT transport protocol abstraction

This new transport protoco=
l is used to tell the core code that traffic
should not be directly process=
ed, but should rather be rerouted to a
transport plugin=2E It is basically =
an abstraction as it does not say tell
the code how to process the data, bu=
t simply forces its redirection to
the external code=2E

Change-Id: Ibc3194=
b64f8a69d2877097157311ff5d6cd2911e
Signed-off-by: Robin Tarsiger <rtt@dasya=
tidae=2Ecom>
[antonio@openvpn=2Enet: refactored commits, restyled code]
[gi=
anmarco@mandelbit=2Ecom: rebased, adapted to multisocket]
---
M src/openvpn=
/forward=2Ec
M src/openvpn/options=2Ec
M src/openvpn/socket=2Ec
M src/openv=
pn/socket=2Eh
M src/openvpn/socket_util=2Ec
M src/openvpn/socket_util=2Eh
M=
 src/openvpn/transport=2Eh
7 files changed, 220 insertions(+), 7 deletions(=
-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/53=
/2053/1

diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
ind=
ex 681210d=2E=2E0343646 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/open=
vpn/forward=2Ec
@@ -2217,6 +2217,11 @@
             {
                 int =
i;
                 c->c2=2Eevent_set_status =3D 0;
+                c->c2=
=2Eevent_set_status |=3D
+                    (socket_indirect_pump(c->c2=
=2Elink_sockets[0], esr, &status)
+                     & (EVENT_READ | EVE=
NT_WRITE))
+                    << socket_shift;
+
                 for (i =
=3D 0; i < status; ++i)
                 {
                     const struc=
t event_set_return *e =3D &esr[i];
diff --git a/src/openvpn/options=2Ec b/s=
rc/openvpn/options=2Ec
index 8e0c602=2E=2E912d8e0 100644
--- a/src/openvpn/=
options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -1828,7 +1828,8 @@
         {
=
             msg(M_WARN, "--pull-filter ignored for --mode server");
      =
   }
-        if (!(proto_is_udp(ce->proto) || ce->proto =3D=3D PROTO_TCP_S=
ERVER))
+        if (!(proto_is_udp(ce->proto) || proto_is_indirect(ce->pro=
to)
+              || ce->proto =3D=3D PROTO_TCP_SERVER))
         {
      =
       msg(M_USAGE, USAGE_VALID_SERVER_PROTOS);
         }
diff --git a/src=
/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 307b5c6=2E=2E9629cb3 100=
644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -39,6 +39,=
7 @@
 #include "openvpn=2Eh"
 #include "forward=2Eh"
 #include "resolve=2Eh=
"
+#include "transport=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -326,6 +327,50 @@=

     return sd;
 }
 
+#ifdef ENABLE_PLUGIN
+
+static void
+create_socket_i=
ndirect(struct link_socket *sock, sa_family_t ai_family)
+{
+    struct add=
rinfo *bind_addresses =3D NULL;
+    if (sock->bind_local)
+    {
+        =
bind_addresses =3D sock->info=2Elsa->bind_local;
+    }
+
+    sock->indire=
ct =3D transport_bind(sock->info=2Eplugins,
+                              =
      sock->info=2Etransport_plugin_argv,
+                                =
    ai_family,
+                                    bind_addresses);
+}
+
+=
unsigned
+socket_indirect_pump(struct link_socket *s, struct event_set_retu=
rn *esr, int *esrlen)
+{
+    if (s->indirect)
+    {
+        return trans=
port_update_event(s->indirect, esr, esrlen);
+    }
+    else
+    {
+     =
   return 0;
+    }
+}
+
+#else  /* ifdef ENABLE_PLUGIN */
+
+static void
+=
create_socket_indirect(struct link_socket *sock, sa_family_t ai_family)
+{
=
+}
+
+unsigned
+socket_indirect_pump(struct link_socket *s, struct event_se=
t_return *esr, int *esrlen)
+{
+    return 0;
+}
+#endif /* ENABLE_PLUGIN *=
/
+
 static void
 create_socket(struct link_socket *sock, struct addrinfo *=
addr)
 {
@@ -333,6 +378,12 @@
      * of the created socket */
     sock->i=
nfo=2Eaf =3D (sa_family_t)addr->ai_family;
 
+    if (proto_is_indirect(soc=
k->info=2Eproto))
+    {
+        create_socket_indirect(sock, sock->info=
=2Eaf);
+        return;
+    }
+
     if (addr->ai_protocol =3D=3D IPPROTO=
_UDP || addr->ai_socktype =3D=3D SOCK_DGRAM)
     {
         /* With a SOCK=
S proxy the local bind goes on the control socket instead
@@ -1367,7 +1418,=
11 @@
     }
 
     /* If socket has not already been created create it now=
 */
-    if (sock->sd =3D=3D SOCKET_UNDEFINED)
+    if (sock->sd =3D=3D SOC=
KET_UNDEFINED
+#ifdef ENABLE_PLUGIN
+        && !sock->indirect
+#endif
+  =
  )
     {
         /* If we have no --remote and have still not figured ou=
t the
          * protocol family to use we will use the first of the bind =
*/
@@ -1387,7 +1442,11 @@
     }
 
     /* Socket still undefined, give a w=
arning and abort connection */
-    if (sock->sd =3D=3D SOCKET_UNDEFINED)
+=
    if (sock->sd =3D=3D SOCKET_UNDEFINED
+#ifdef ENABLE_PLUGIN
+        && =
!sock->indirect
+#endif
+    )
     {
         msg(M_WARN, "Could not deter=
mine IPv4/IPv6 protocol");
         register_signal(sig_info, SIGUSR1, "Cou=
ld not determine IPv4/IPv6 protocol");
@@ -1422,7 +1481,10 @@
         goto=
 done;
     }
 
-    phase2_set_socket_flags(sock);
+    if (sock->sd !=3D =
SOCKET_UNDEFINED)
+    {
+        phase2_set_socket_flags(sock);
+    }
   =
  linksock_print_addr(sock);
 
 done:
@@ -1451,6 +1513,14 @@
         const=
 int gremlin =3D 0;
 #endif
 
+#ifdef ENABLE_PLUGIN
+        if (sock->indi=
rect)
+        {
+            sock->indirect->vtab->close(sock->indirect);
=
+            sock->indirect =3D NULL;
+        }
+#endif
+
         if (soc=
ket_defined(sock->sd))
         {
 #ifdef _WIN32
@@ -1966,6 +2036,29 @@
   =
  }
 }
 
+#ifdef ENABLE_PLUGIN
+
+int
+link_socket_read_indirect(struct lin=
k_socket *sock,
+                          struct buffer *buf,
+           =
               struct link_socket_actual *from)
+{
+    ASSERT(sock->indire=
ct);
+    socklen_t fromlen =3D sizeof(from->dest=2Eaddr);
+    socklen_t e=
xpectedlen =3D (socklen_t)af_addr_size(sock->info=2Eaf);
+    addr_zero_hos=
t(&from->dest);
+    int len =3D transport_read(sock->indirect, buf,
+     =
                        &from->dest=2Eaddr=2Esa, &fromlen);
+    if (len >=
=3D 0 && expectedlen && fromlen !=3D expectedlen)
+    {
+        bad_addre=
ss_length(fromlen, expectedlen);
+    }
+
+    return buf->len =3D len;
+}
=
+
+#endif /* ENABLE_PLUGIN */
+
 #ifndef _WIN32
 
 #if ENABLE_IP_PKTINFO
@@=
 -2114,6 +2207,21 @@
 #endif
 }
 
+#ifdef ENABLE_PLUGIN
+
+int
+link_socket=
_write_indirect(struct link_socket *sock,
+                           struc=
t buffer *buf,
+                           struct link_socket_actual *to)
+=
{
+    ASSERT(sock->indirect);
+    struct sockaddr *addr =3D (struct socka=
ddr *)&to->dest=2Eaddr=2Esa;
+    socklen_t addrlen =3D (socklen_t)af_addr_=
size(to->dest=2Eaddr=2Esa=2Esa_family);
+    return transport_write(sock->i=
ndirect, buf, addr, addrlen);
+}
+
+#endif /* ENABLE_PLUGIN */
+
 #if ENABL=
E_IP_PKTINFO
 
 ssize_t
@@ -2215,6 +2323,12 @@
 int
 socket_recv_queue(stru=
ct link_socket *sock, int maxsize)
 {
+    if (proto_is_indirect(sock->info=
=2Eproto))
+    {
+        /* Indirect handler will take care of this, so d=
o nothing=2E */
+        return IOSTATE_QUEUED;
+    }
+
     if (sock->rea=
ds=2Eiostate =3D=3D IOSTATE_INITIAL)
     {
         WSABUF wsabuf[1];
@@ -=
2612,7 +2726,16 @@
         /* if persistent is defined, call event_ctl onl=
y if rwflags has changed since last call */
         if (!persistent || *pe=
rsistent !=3D rwflags)
         {
-            event_ctl(es, socket_event_h=
andle(s), rwflags, arg);
+#ifdef ENABLE_PLUGIN
+            if (s->indirect=
)
+            {
+                transport_request_events(s->indirect, es,=
 rwflags);
+            }
+            else
+#endif
+            {
+       =
         event_ctl(es, socket_event_handle(s), rwflags, arg);
+            =
}
             if (persistent)
             {
                 *persistent =
=3D rwflags;
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
i=
ndex 52e09c9=2E=2E4119330 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/ope=
nvpn/socket=2Eh
@@ -78,6 +78,7 @@
     bool connection_established;
     co=
nst char *ipchange_command;
     const struct plugin_list *plugins;
+    co=
nst char **transport_plugin_argv;
     bool remote_float;
     uint8_t prot=
o;   /* Protocol (PROTO_x defined below) */
     sa_family_t af;  /* Addres=
s family like AF_INET, AF_INET6 or AF_UNSPEC*/
@@ -171,6 +172,11 @@
     st=
ruct rw_handle listen_handle; /* For listening on TCP socket in server mode=
 */
 #endif
 
+#ifdef ENABLE_PLUGIN
+    /* only valid when info=2Eproto =
=3D=3D PROTO_INDIRECT */
+    openvpn_transport_socket_t indirect;
+#endif
=
+
     /* used for printing status info only */
     unsigned int rwflags_d=
ebug;
 
@@ -612,10 +618,46 @@
 
 #endif /* ifdef _WIN32 */
 
+#ifdef ENABLE=
_PLUGIN
+
+int link_socket_read_indirect(struct link_socket *sock,
+       =
                       struct buffer *buf,
+                              s=
truct link_socket_actual *from);
+
+int link_socket_write_indirect(struct l=
ink_socket *sock,
+                               struct buffer *buf,
+    =
                           struct link_socket_actual *from);
+
+#else  /* i=
fdef ENABLE_PLUGIN */
+
+static inline int
+link_socket_read_indirect(struc=
t link_socket *sock,
+                          struct buffer *buf, struct =
link_socket_actual *from)
+{
+    return -1;
+}
+
+static inline int
+link_=
socket_write_indirect(struct link_socket *sock,
+                          =
 struct buffer *buf, struct link_socket_actual *from)
+{
+    return -1;
+}=

+
+#endif /* ENABLE_PLUGIN */
+
+unsigned
+socket_indirect_pump(struct lin=
k_socket *s, struct event_set_return *esr, int *esrlen);
+
 /* read a TCP o=
r UDP packet from link */
 static inline ssize_t
 link_socket_read(struct l=
ink_socket *sock, struct buffer *buf, struct link_socket_actual *from)
 {
+=
    if (proto_is_indirect(sock->info=2Eproto))
+    {
+        return link_=
socket_read_indirect(sock, buf, from);
+    }
+
     if (proto_is_udp(sock-=
>info=2Eproto) || socket_is_dco_win(sock))
     /* unified UDPv4 and UDPv6,=
 for DCO-WIN the kernel
      * will strip the length header */
@@ -735,6 +=
777,11 @@
 static inline ssize_t
 link_socket_write(struct link_socket *soc=
k, struct buffer *buf, struct link_socket_actual *to)
 {
+    if (proto_is_=
indirect(sock->info=2Eproto))
+    {
+        return link_socket_write_indi=
rect(sock, buf, to);
+    }
+
     if (proto_is_udp(sock->info=2Eproto) || =
socket_is_dco_win(sock))
     {
         /* unified UDPv4, UDPv6 and DCO-WI=
N (driver adds length header) */
@@ -811,7 +858,7 @@
 static inline void
 s=
ocket_set_listen_persistent(struct link_socket *sock, struct event_set *es,=
 void *arg)
 {
-    if (sock && !sock->listen_persistent_queued)
+    if (s=
ock && !sock->listen_persistent_queued && !sock->indirect)
     {
         =
event_ctl(es, socket_listen_event_handle(sock), EVENT_READ, arg);
         =
sock->listen_persistent_queued =3D true;
diff --git a/src/openvpn/socket_ut=
il=2Ec b/src/openvpn/socket_util=2Ec
index 879be73=2E=2E1230542 100644
--- =
a/src/openvpn/socket_util=2Ec
+++ b/src/openvpn/socket_util=2Ec
@@ -367,16 =
+367,25 @@
     { "tcp-server", "TCP_SERVER", AF_UNSPEC, PROTO_TCP_SERVER }=
,
     { "tcp-client", "TCP_CLIENT", AF_UNSPEC, PROTO_TCP_CLIENT },
     { =
"tcp", "TCP", AF_UNSPEC, PROTO_TCP },
+#ifdef ENABLE_PLUGIN
+    { "indirec=
t", "INDIRECT", AF_UNSPEC, PROTO_INDIRECT },
+#endif
     /* force IPv4 */
=
     { "udp4", "UDPv4", AF_INET, PROTO_UDP },
     { "tcp4-server", "TCPv4_=
SERVER", AF_INET, PROTO_TCP_SERVER },
     { "tcp4-client", "TCPv4_CLIENT",=
 AF_INET, PROTO_TCP_CLIENT },
     { "tcp4", "TCPv4", AF_INET, PROTO_TCP },=

+#ifdef ENABLE_PLUGIN
+    { "indirect4", "INDIRECT_IPv4", AF_INET, PROTO_=
INDIRECT },
+#endif
     /* force IPv6 */
     { "udp6", "UDPv6", AF_INET6,=
 PROTO_UDP },
     { "tcp6-server", "TCPv6_SERVER", AF_INET6, PROTO_TCP_SER=
VER },
     { "tcp6-client", "TCPv6_CLIENT", AF_INET6, PROTO_TCP_CLIENT },
=
     { "tcp6", "TCPv6", AF_INET6, PROTO_TCP },
+#ifdef ENABLE_PLUGIN
+    {=
 "indirect6", "INDIRECT_IPv6", AF_INET6, PROTO_INDIRECT },
+#endif
 };
 
 i=
nt
@@ -486,6 +495,18 @@
         return "TCPv4_CLIENT";
     }
 
+#ifdef EN=
ABLE_PLUGIN
+    if (proto =3D=3D PROTO_INDIRECT)
+    {
+        /* FIXME:=
 the string reported here should match the actual transport
+         * pro=
tocol being used, however in this function we have no knowledge of
+       =
  * what protocol is exactly being used by the transport-plugin=2E
+       =
  * Therefore we simply return INDIRECT for now=2E
+         */
+        re=
turn "INDIRECT";
+    }
+#endif
+
     ASSERT(0);
     return ""; /* Make t=
he compiler happy */
 }
diff --git a/src/openvpn/socket_util=2Eh b/src/open=
vpn/socket_util=2Eh
index 40f9334=2E=2E72432c5 100644
--- a/src/openvpn/soc=
ket_util=2Eh
+++ b/src/openvpn/socket_util=2Eh
@@ -26,6 +26,7 @@
 #include =
"buffer=2Eh"
 #include "env_set=2Eh"
 #include "sig=2Eh"
+#include "transpo=
rt=2Eh"
 
 #define PS_SHOW_PORT_IF_DEFINED (1 << 0)
 #define PS_SHOW_PORT  =
          (1 << 1)
@@ -163,6 +164,16 @@
     return proto =3D=3D PROTO_UDP;=

 }
 
+static inline bool
+proto_is_indirect(int proto)
+{
+#ifdef ENABLE_P=
LUGIN
+    return proto =3D=3D PROTO_INDIRECT;
+#else
+    return false;
+#=
endif
+}
+
 /**
  * @brief Return if the protocol is datagram (UDP)
  *
@@ =
-170,7 +181,7 @@
 static inline bool
 proto_is_dgram(int proto)
 {
-    ret=
urn proto_is_udp(proto);
+    return proto_is_udp(proto) || proto_is_indire=
ct(proto);
 }
 
 /**
diff --git a/src/openvpn/transport=2Eh b/src/openvpn/t=
ransport=2Eh
index 72778c5=2E=2E05422e6 100644
--- a/src/openvpn/transport=
=2Eh
+++ b/src/openvpn/transport=2Eh
@@ -27,6 +27,11 @@
 #include "plugin=
=2Eh"
 #include "openvpn-transport=2Eh"
 
+/* INDIRECT does not have any ov=
erhead per se, but it depends on what is
+ * implemented by the transport p=
lugin
+ */
+/*#define INDIRECT_HEADER_SIZE    0 */
+
 /* Given a list of pl=
ugins and an argument list for a desired
  * transport plugin instance, pre=
pare to bind new link sockets using
  * that transport plugin and args=2E I=
f all succeeds, return true, and:

-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2053?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: Ibc3194b64f8a69d2877097157311ff5d6cd2911e
Gerrit-Change-Nu=
mber: 2053
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco De Gregori <gianmarco=
@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--LWUrL1RNpxc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2053?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">socket: introduce INDIRECT transport protocol abstracti=
on<br><br>This new transport protocol is used to tell the core code that tr=
affic<br>should not be directly processed, but should rather be rerouted to=
 a<br>transport plugin=2E It is basically an abstraction as it does not say=
 tell<br>the code how to process the data, but simply forces its redirectio=
n to<br>the external code=2E<br><br>Change-Id: Ibc3194b64f8a69d287709715731=
1ff5d6cd2911e<br>Signed-off-by: Robin Tarsiger &lt;rtt@dasyatidae=2Ecom&gt;=
<br>[antonio@openvpn=2Enet: refactored commits, restyled code]<br>[gianmarc=
o@mandelbit=2Ecom: rebased, adapted to multisocket]<br>---<br>M src/openvpn=
/forward=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/socket=2Ec<br>M =
src/openvpn/socket=2Eh<br>M src/openvpn/socket_util=2Ec<br>M src/openvpn/so=
cket_util=2Eh<br>M src/openvpn/transport=2Eh<br>7 files changed, 220 insert=
ions(+), 7 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/53/2053/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 681210=
d=2E=2E0343646 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><=
br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -2217,6 +2217,11 =
@@</span><br><span>             {</span><br><span>                 int i;</=
span><br><span>                 c-&gt;c2=2Eevent_set_status =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c2=2Ee=
vent_set_status |=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    (socket_indirect_pump(c-&gt;c2=2Elink_sockets[0], esr,=
 &amp;status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
               &amp; (EVENT_READ | EVENT_WRITE))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    &lt;&lt; socket_shift;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>      =
           for (i =3D 0; i &lt; status; ++i)</span><br><span>              =
   {</span><br><span>                     const struct event_set_return *e =
=3D &amp;esr[i];</span><br><span>diff --git a/src/openvpn/options=2Ec b/src=
/openvpn/options=2Ec</span><br><span>index 8e0c602=2E=2E912d8e0 100644</spa=
n><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn=
/options=2Ec</span><br><span>@@ -1828,7 +1828,8 @@</span><br><span>        =
 {</span><br><span>             msg(M_WARN, &quot;--pull-filter ignored for=
 --mode server&quot;);</span><br><span>         }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (!(proto_is_udp(ce-&gt;proto) || ce-=
&gt;proto =3D=3D PROTO_TCP_SERVER))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (!(proto_is_udp(ce-&gt;proto) || proto_is_indire=
ct(ce-&gt;proto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
           || ce-&gt;proto =3D=3D PROTO_TCP_SERVER))</span><br><span>      =
   {</span><br><span>             msg(M_USAGE, USAGE_VALID_SERVER_PROTOS);<=
/span><br><span>         }</span><br><span>diff --git a/src/openvpn/socket=
=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 307b5c6=2E=2E9629cb3 10=
0644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src=
/openvpn/socket=2Ec</span><br><span>@@ -39,6 +39,7 @@</span><br><span> #inc=
lude &quot;openvpn=2Eh&quot;</span><br><span> #include &quot;forward=2Eh&qu=
ot;</span><br><span> #include &quot;resolve=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;transport=2Eh&quot;</span>=
<br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><spa=
n> </span><br><span>@@ -326,6 +327,50 @@</span><br><span>     return sd;</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef ENABLE_PLUGIN</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+create_sock=
et_indirect(struct link_socket *sock, sa_family_t ai_family)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct addrinfo *bind_addresses =3D NULL;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sock-&gt;bind_loca=
l)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        bind_addresses =3D sock=
-&gt;info=2Elsa-&gt;bind_local;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;indirect=
 =3D transport_bind(sock-&gt;info=2Eplugins,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                    sock-&gt;info=
=2Etransport_plugin_argv,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                    ai_family,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                    bind_=
addresses);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+unsigned</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+socket_indirect_pump(struct link_socket *s, struct event=
_set_return *esr, int *esrlen)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(s-&gt;indirect)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return tr=
ansport_update_event(s-&gt;indirect, esr, esrlen);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#else  /* ifdef ENABLE_PLUGIN */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+create_socket_indirect(struct link_socket *sock, sa_family_t ai_family)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+un=
signed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_indire=
ct_pump(struct link_socket *s, struct event_set_return *esr, int *esrlen)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif /* ENABLE_PLUGIN */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> static void</span><br><span> create_so=
cket(struct link_socket *sock, struct addrinfo *addr)</span><br><span> {</s=
pan><br><span>@@ -333,6 +378,12 @@</span><br><span>      * of the created s=
ocket */</span><br><span>     sock-&gt;info=2Eaf =3D (sa_family_t)addr-&gt;=
ai_family;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (proto_is_indirect(sock-&gt;info=2Eproto))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        create_socket_indirect(sock, sock-&gt;info=
=2Eaf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (addr=
-&gt;ai_protocol =3D=3D IPPROTO_UDP || addr-&gt;ai_socktype =3D=3D SOCK_DGR=
AM)</span><br><span>     {</span><br><span>         /* With a SOCKS proxy t=
he local bind goes on the control socket instead</span><br><span>@@ -1367,7=
 +1418,11 @@</span><br><span>     }</span><br><span> </span><br><span>     =
/* If socket has not already been created create it now */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (sock-&gt;sd =3D=3D SOCKET_UNDE=
FINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sock-=
&gt;sd =3D=3D SOCKET_UNDEFINED</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifdef ENABLE_PLUGIN</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        &amp;&amp; !sock-&gt;indirect</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    )</span><br><span>     {</span><br><span>         /* I=
f we have no --remote and have still not figured out the</span><br><span>  =
        * protocol family to use we will use the first of the bind */</span=
><br><span>@@ -1387,7 +1442,11 @@</span><br><span>     }</span><br><span> <=
/span><br><span>     /* Socket still undefined, give a warning and abort co=
nnection */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (so=
ck-&gt;sd =3D=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (sock-&gt;sd =3D=3D SOCKET_UNDEFINED</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PLUGIN</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !sock-&gt;indire=
ct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span>     {</=
span><br><span>         msg(M_WARN, &quot;Could not determine IPv4/IPv6 pro=
tocol&quot;);</span><br><span>         register_signal(sig_info, SIGUSR1, &=
quot;Could not determine IPv4/IPv6 protocol&quot;);</span><br><span>@@ -142=
2,7 +1481,10 @@</span><br><span>         goto done;</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
phase2_set_socket_flags(sock);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (sock-&gt;sd !=3D SOCKET_UNDEFINED)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        phase2_set_socket_flags(sock);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     linksock_=
print_addr(sock);</span><br><span> </span><br><span> done:</span><br><span>=
@@ -1451,6 +1513,14 @@</span><br><span>         const int gremlin =3D 0;</s=
pan><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#ifdef ENABLE_PLUGIN</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (sock-&gt;indirect)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            sock-&gt;indirect-&gt;vtab-&gt;close(so=
ck-&gt;indirect);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          sock-&gt;indirect =3D NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>         if (socket_defined(sock-&gt;sd))</span><br><span>     =
    {</span><br><span> #ifdef _WIN32</span><br><span>@@ -1966,6 +2036,29 @@=
</span><br><span>     }</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PLUGIN</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+link_socket_read_indirect(struct link_socket *sock,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                          struct buf=
fer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                struct link_socket_actual *from)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ASSERT(sock-&gt;indirect);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    socklen_t fromlen =3D sizeof(from-&gt;dest=2Eaddr=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socklen_t exp=
ectedlen =3D (socklen_t)af_addr_size(sock-&gt;info=2Eaf);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    addr_zero_host(&amp;from-&gt;dest=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int len =3D t=
ransport_read(sock-&gt;indirect, buf,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                             &amp;from-&gt;dest=2Eaddr=2E=
sa, &amp;fromlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (len &gt;=3D 0 &amp;&amp; expectedlen &amp;&amp; fromlen !=3D expecte=
dlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        bad_address_length(f=
romlen, expectedlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return buf-&gt;len =3D len;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif /* ENABLE_PLUGIN */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> #ifndef _WIN32</span><br><span>=
 </span><br><span> #if ENABLE_IP_PKTINFO</span><br><span>@@ -2114,6 +2207,2=
1 @@</span><br><span> #endif</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PLUGIN</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+link_socket_write_indirect(struct link_socket *sock,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                           str=
uct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                        struct link_socket_actual *to)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ASSERT(sock-&gt;indirect);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct sockaddr *addr =3D (struct sockaddr =
*)&amp;to-&gt;dest=2Eaddr=2Esa;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    socklen_t addrlen =3D (socklen_t)af_addr_size(to-&gt;dest=
=2Eaddr=2Esa=2Esa_family);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return transport_write(sock-&gt;indirect, buf, addr, addrlen);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif /* ENABLE_PLUGIN */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> #if ENABLE_IP_PKTINFO</span><br><=
span> </span><br><span> ssize_t</span><br><span>@@ -2215,6 +2323,12 @@</spa=
n><br><span> int</span><br><span> socket_recv_queue(struct link_socket *soc=
k, int maxsize)</span><br><span> {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (proto_is_indirect(sock-&gt;info=2Eproto))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* Indirect handler will take care o=
f this, so do nothing=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return IOSTATE_QUEUED;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>     if (sock-&gt;reads=2Eiostate =3D=3D IOSTATE_INIT=
IAL)</span><br><span>     {</span><br><span>         WSABUF wsabuf[1];</spa=
n><br><span>@@ -2612,7 +2726,16 @@</span><br><span>         /* if persisten=
t is defined, call event_ctl only if rwflags has changed since last call */=
</span><br><span>         if (!persistent || *persistent !=3D rwflags)</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            event_ctl(es, socket_event_handle(s), rwflags, arg);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PLUGIN</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (s-&gt;indire=
ct)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                transp=
ort_request_events(s-&gt;indirect, es, rwflags);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                event_ctl(es, socket_event_handle(s), rwflags, arg);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span>             if (persistent)</span><br><span>             {</span><br>=
<span>                 *persistent =3D rwflags;</span><br><span>diff --git =
a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 52e=
09c9=2E=2E4119330 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span=
><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -78,6 +78,7 @@</=
span><br><span>     bool connection_established;</span><br><span>     const=
 char *ipchange_command;</span><br><span>     const struct plugin_list *plu=
gins;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 **transport_plugin_argv;</span><br><span>     bool remote_float;</span><br=
><span>     uint8_t proto;   /* Protocol (PROTO_x defined below) */</span><=
br><span>     sa_family_t af;  /* Address family like AF_INET, AF_INET6 or =
AF_UNSPEC*/</span><br><span>@@ -171,6 +172,11 @@</span><br><span>     struc=
t rw_handle listen_handle; /* For listening on TCP socket in server mode */=
</span><br><span> #endif</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#ifdef ENABLE_PLUGIN</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* only valid when info=2Eproto =3D=3D PROTO_IN=
DIRECT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvp=
n_transport_socket_t indirect;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     /* used for printing status info only */</span><br><spa=
n>     unsigned int rwflags_debug;</span><br><span> </span><br><span>@@ -61=
2,10 +618,46 @@</span><br><span> </span><br><span> #endif /* ifdef _WIN32 *=
/</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#ifdef ENABLE_PLUGIN</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int link_socket_re=
ad_indirect(struct link_socket *sock,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                              struct buffer *buf,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
   struct link_socket_actual *from);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
t link_socket_write_indirect(struct link_socket *sock,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                               struct bu=
ffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                      struct link_socket_actual *from);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#else  /* ifdef ENABLE_PLUGIN */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static inline int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+link_socket_read_indirect(struct link_socket *sock,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                          struct b=
uffer *buf, struct link_socket_actual *from)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static inline int</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+link_socket_write_indirect(struct lin=
k_socket *sock,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                       struct buffer *buf, struct link_socket_actual *from)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return -1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif /* ENABLE_PLUGIN */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+socket_indirect_pump(struc=
t link_socket *s, struct event_set_return *esr, int *esrlen);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* read a TCP o=
r UDP packet from link */</span><br><span> static inline ssize_t</span><br>=
<span> link_socket_read(struct link_socket *sock, struct buffer *buf, struc=
t link_socket_actual *from)</span><br><span> {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (proto_is_indirect(sock-&gt;info=2Eproto)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return link_socket_read_=
indirect(sock, buf, from);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     if (proto_is_udp(sock-&gt;info=2Eproto) || socket_is_dco_win=
(sock))</span><br><span>     /* unified UDPv4 and UDPv6, for DCO-WIN the ke=
rnel</span><br><span>      * will strip the length header */</span><br><spa=
n>@@ -735,6 +777,11 @@</span><br><span> static inline ssize_t</span><br><sp=
an> link_socket_write(struct link_socket *sock, struct buffer *buf, struct =
link_socket_actual *to)</span><br><span> {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (proto_is_indirect(sock-&gt;info=2Eproto))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return link_socket_write_ind=
irect(sock, buf, to);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     if (proto_is_udp(sock-&gt;info=2Eproto) || socket_is_dco_win(sock=
))</span><br><span>     {</span><br><span>         /* unified UDPv4, UDPv6 =
and DCO-WIN (driver adds length header) */</span><br><span>@@ -811,7 +858,7=
 @@</span><br><span> static inline void</span><br><span> socket_set_listen_=
persistent(struct link_socket *sock, struct event_set *es, void *arg)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
sock &amp;&amp; !sock-&gt;listen_persistent_queued)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (sock &amp;&amp; !sock-&gt;listen_=
persistent_queued &amp;&amp; !sock-&gt;indirect)</span><br><span>     {</sp=
an><br><span>         event_ctl(es, socket_listen_event_handle(sock), EVENT=
_READ, arg);</span><br><span>         sock-&gt;listen_persistent_queued =3D=
 true;</span><br><span>diff --git a/src/openvpn/socket_util=2Ec b/src/openv=
pn/socket_util=2Ec</span><br><span>index 879be73=2E=2E1230542 100644</span>=
<br><span>--- a/src/openvpn/socket_util=2Ec</span><br><span>+++ b/src/openv=
pn/socket_util=2Ec</span><br><span>@@ -367,16 +367,25 @@</span><br><span>  =
   { &quot;tcp-server&quot;, &quot;TCP_SERVER&quot;, AF_UNSPEC, PROTO_TCP_S=
ERVER },</span><br><span>     { &quot;tcp-client&quot;, &quot;TCP_CLIENT&qu=
ot;, AF_UNSPEC, PROTO_TCP_CLIENT },</span><br><span>     { &quot;tcp&quot;,=
 &quot;TCP&quot;, AF_UNSPEC, PROTO_TCP },</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#ifdef ENABLE_PLUGIN</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    { &quot;indirect&quot;, &quot;INDIRECT&quot;, AF=
_UNSPEC, PROTO_INDIRECT },</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span>     /* force IPv4 */</span><br><span>     { =
&quot;udp4&quot;, &quot;UDPv4&quot;, AF_INET, PROTO_UDP },</span><br><span>=
     { &quot;tcp4-server&quot;, &quot;TCPv4_SERVER&quot;, AF_INET, PROTO_TC=
P_SERVER },</span><br><span>     { &quot;tcp4-client&quot;, &quot;TCPv4_CLI=
ENT&quot;, AF_INET, PROTO_TCP_CLIENT },</span><br><span>     { &quot;tcp4&q=
uot;, &quot;TCPv4&quot;, AF_INET, PROTO_TCP },</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef ENABLE_PLUGIN</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    { &quot;indirect4&quot;, &quot;INDIRECT_IPv=
4&quot;, AF_INET, PROTO_INDIRECT },</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span>     /* force IPv6 */</span><br><spa=
n>     { &quot;udp6&quot;, &quot;UDPv6&quot;, AF_INET6, PROTO_UDP },</span>=
<br><span>     { &quot;tcp6-server&quot;, &quot;TCPv6_SERVER&quot;, AF_INET=
6, PROTO_TCP_SERVER },</span><br><span>     { &quot;tcp6-client&quot;, &quo=
t;TCPv6_CLIENT&quot;, AF_INET6, PROTO_TCP_CLIENT },</span><br><span>     { =
&quot;tcp6&quot;, &quot;TCPv6&quot;, AF_INET6, PROTO_TCP },</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_PLUGIN</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    { &quot;indirect6&quot;, &quot=
;INDIRECT_IPv6&quot;, AF_INET6, PROTO_INDIRECT },</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span> };</span><br><span> <=
/span><br><span> int</span><br><span>@@ -486,6 +495,18 @@</span><br><span> =
        return &quot;TCPv4_CLIENT&quot;;</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE=
_PLUGIN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (prot=
o =3D=3D PROTO_INDIRECT)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
* FIXME: the string reported here should match the actual transport</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+         * protocol being u=
sed, however in this function we have no knowledge of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * what protocol is exactly being=
 used by the transport-plugin=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * Therefore we simply return INDIRECT for now=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return &quot;INDIRECT&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ASSERT(0);</span><b=
r><span>     return &quot;&quot;; /* Make the compiler happy */</span><br><=
span> }</span><br><span>diff --git a/src/openvpn/socket_util=2Eh b/src/open=
vpn/socket_util=2Eh</span><br><span>index 40f9334=2E=2E72432c5 100644</span=
><br><span>--- a/src/openvpn/socket_util=2Eh</span><br><span>+++ b/src/open=
vpn/socket_util=2Eh</span><br><span>@@ -26,6 +26,7 @@</span><br><span> #inc=
lude &quot;buffer=2Eh&quot;</span><br><span> #include &quot;env_set=2Eh&quo=
t;</span><br><span> #include &quot;sig=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;transport=2Eh&quot;</span><br><=
span> </span><br><span> #define PS_SHOW_PORT_IF_DEFINED (1 &lt;&lt; 0)</spa=
n><br><span> #define PS_SHOW_PORT            (1 &lt;&lt; 1)</span><br><span=
>@@ -163,6 +164,16 @@</span><br><span>     return proto =3D=3D PROTO_UDP;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+proto_is_indirect(int proto)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifdef ENABLE_PLUGIN</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return proto =3D=3D PROTO_INDIRECT;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*=
*</span><br><span>  * @brief Return if the protocol is datagram (UDP)</span=
><br><span>  *</span><br><span>@@ -170,7 +181,7 @@</span><br><span> static =
inline bool</span><br><span> proto_is_dgram(int proto)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return proto_is_udp=
(proto);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
proto_is_udp(proto) || proto_is_indirect(proto);</span><br><span> }</span><=
br><span> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/tr=
ansport=2Eh b/src/openvpn/transport=2Eh</span><br><span>index 72778c5=2E=2E=
05422e6 100644</span><br><span>--- a/src/openvpn/transport=2Eh</span><br><s=
pan>+++ b/src/openvpn/transport=2Eh</span><br><span>@@ -27,6 +27,11 @@</spa=
n><br><span> #include &quot;plugin=2Eh&quot;</span><br><span> #include &quo=
t;openvpn-transport=2Eh&quot;</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* INDIRECT does not have any overhead per se, =
but it depends on what is</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * implemented by the transport plugin</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/*#define INDIRECT_HEADER_SIZE    0 */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> /* Given a list of plugins an=
d an argument list for a desired</span><br><span>  * transport plugin insta=
nce, prepare to bind new link sockets using</span><br><span>  * that transp=
ort plugin and args=2E If all succeeds, return true, and:</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2053=
?usp=3Demail">change 2053</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2053?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchang=
e </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: Ibc3194b64f8a69d2877097157311ff5d6cd2911e </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2053 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>

</body></html>
--LWUrL1RNpxc=--


--===============3610636525665712231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3610636525665712231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3610636525665712231==--

