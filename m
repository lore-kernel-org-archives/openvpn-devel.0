Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EB0CA5FC6
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VZR3W3htd+CyclqDstPNW5t2c4DdAm74VsclcBOvI74=; b=X5XNgVAkp3QfL318e7YtV3lZTc
	iWYRNM2A4yDnt+53VCIXXcm3qikyibWwxe8A7ym0ukumA3NacJpJTlSFdbXSHV6V0hZR9poC9mfpC
	fY/eoUujTiI1AieCWsWU4My3F1CqfwPvMdbFxPxPj14AlDN4wWdR8XoyHSriRRZrCeYs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpe9-0001Xo-PB;
	Wed, 30 Sep 2026 08:26:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpdz-0001WB-L2
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cVrECsBEgLTPgka7/FQfK5nvjffdqtSB6b1ViOJrueM=; b=Xq4VTSkcRllWUMA4vQHy44ZsUB
 uR0rzlyg8j9bD0oMJO/HUzqArLWmk+9T3YOZWjQrQ6Af00WIR2rGC8J1g0JYvpykoUjmS4rtXoyHQ
 UcJaQ+zHqMP04t+hLOBc1w0RHqkpOgDKz0uUElbVsrGwXt7lvD8uTldl2i5EHAqok3tg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cVrECsBEgLTPgka7/FQfK5nvjffdqtSB6b1ViOJrueM=; b=i
 6A7i4A7O15Uq4f97S4eFYgrq46sYlY4z9d7SErt90zvfXzrfnhr5r0M0c1k6viQ0GlUyVIkPRV+Hy
 l/pt7niqqM7Zace8YywFL6Rly2lPSdnpkmTayiEpZ7bYhimRZKzAXEu6wIlJVN+VmrWfp0sSBPcaA
 LSGWDnUun5ONzVuY=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpdV-0006jm-Li for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:25:58 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48b00a0ac65so241067f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756751; x=1791361551; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cVrECsBEgLTPgka7/FQfK5nvjffdqtSB6b1ViOJrueM=;
 b=RnUdQHehIkz6Fq8P0mcWQVeMrMNRnOvQzDGMaj8Bt61dALpNs45vFtJg+gfNfi0LZX
 VtP10keVCZrY4jJmS1O86HGN3giT8+ABzLuaJnrLpPaT3kH9qUPnfCEULJZZTzy9Gb3u
 Q2yQCt4pPeAoc6Zm1B8EYNFV7dRZ+RCKHHAWbyyjRD+x9PMj+Pcnl+57U/wBPb9QTJNp
 bLzlzTeXznzg9KN2ANeN7qQxP4nmoiluaJUkgoWlrnTvn5GfccXQL2+I1mpcHPXZFIoj
 gABN4JlmwxhmVxSc9Fbjz+YT/MjMA5K5LdGnMDFF9EJ2RncAIK+E6xOMlSpqRx+9B6C5
 j84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756751; x=1791361551;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cVrECsBEgLTPgka7/FQfK5nvjffdqtSB6b1ViOJrueM=;
 b=Iwu52Avu8dlpnMYBrSNgWKOt6J8o8WY4dUalR+JfsNcqfNwQHqj+ks3Y0rgS385ki6
 YenjEPbOZNXz7+HcPbB8z+4lId5lMa6guoxg6rINboOsGuJq1tKSGZoyPNNjEYbj4HEb
 VjVru4li5GQzacFTSLQI2Y5z40IhFl86cn1qAAHUDQRxCtaOTdY8DGAD3WMdu51b/7t5
 VXncybRiNM9Bupsn5Ogarw9MByIgge+JwtwVSTTTul5BCESVBpG1zQm/Is+g0jACHnLt
 w7G9zZ83TZ4RZtVHxxONcWSHR74TZhLg7Xq2Kt31PLhZz+9lo66p1hdVtR8/3tqhE9C+
 m9Bw==
X-Gm-Message-State: AFq9FYJABdcF8XpujpEB2REpEAwI7K4W4uvFT1B2b5fukGPALIwTsUHA
 pRGuiAz8kBurR1UJ97firaGchC0/AkNI/xRnpquewog28r7tNGjulRC9yX+UHvjE5/1zr5gtRGi
 TV3SsQTVO3enDxcDMabFCWvXfifkUoaZeupUiNvjLHX6q1a5Vn9oJT5Mg6dwxcFiPPkTa5K1GmE
 gL9LZV4g==
X-Gm-Gg: AYBFou0owRwULQQ9xN4Pvr4zMIaNKrc2+KMdkORuRgoF7eFJ1Yji9Q3YZLkzklLiQOK
 LZuVnkgRPBAmlH/6Ru+YrlMst5xS0fRKeXFdAXBPnh1uozWFED+j9IoU8j5/awQe8tA/ynQUTMw
 RhaLmbya500rrVx5lvFwy1rwv2qb2yQi4fvEY8rZDA3/MTIJrv9V1iuvVLRbTMtN1BcUoY62tAg
 IkNU5vp6of+sSC1zeHAF0GlGtRKoM/ktWrLFlHBAsH1Dk3whE/3IGW5WXcbhty19XlDo4EhQcaP
 KCrXN9h8l4qOrli27pGstMJikmYUwIiaWuKi6IY0XWHiU0h3S8ulu6VJM9AamM4uKEy//p+tUN4
 bf1ISSdnyA3+X3fOUyub7PaqRgMARBIwO/HbM+BbIqBlWj8C8w8OkIDiVD56AcVj15aIMp5Kwhd
 al5qga9NglTE+HX1KAadfe/87DWDnBkxKe93+z3uEJUolC/3MGIt4aLlV8PnOSFLBJjJu4rq5s1
 9jqMR7o0cWMYTq6w9KuApA6e1yngl8YzYgkb8wRDW0CEfpr4Nq+PG6OCYfd3bGi7ZDMy85Fr0jP
 bAXr2yY1Qha5wKuJicTDnlFiP2fZGND2iwl16SE3JXyZVhqZ7Z27Av46y6UQ
X-Received: by 2002:a5d:5d0e:0:b0:487:27f6:a4d3 with SMTP id
 ffacd0b85a97d-48b02512ddamr1672677f8f.35.1790756750243; 
 Wed, 30 Sep 2026 01:25:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b02a0dd0dsm1455063f8f.35.2026.09.30.01.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:25:49 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:25:29 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
X-Gerrit-Change-Number: 1915
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1915?usp=email>
X-Gerrit-Commit: 840214a21d0e2ef481177e118f9371c18f8def29
In-Reply-To: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
References: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5Mzk1NTEyMDAwLkkyNGU1OTI1YTcyYWFlZGU1M2VmOWU4NjNmZTk2ZmNkNzM2M2RmNDAyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cb36141c37e399ae05e268096c92c84352cad016-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpdV-0006jm-Li
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: Let an
 optional UDP socket give up on a failed bind
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
Content-Type: multipart/mixed; boundary="===============0149455487759950744=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0149455487759950744==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kFWWeWyDX+o="; charset=UTF-8

--kFWWeWyDX+o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail

to look a=
t the new patch set (#9)=2E


Change subject: socket: Let an optional UDP s=
ocket give up on a failed bind
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

socket: Let an optional UDP socket give up on a failed =
bind

create_socket_udp_configured()'s "optional" argument covers only the
=
socket() call: socket_bind() is fatal, so a caller that can do without
the =
socket still dies if the address is unavailable=2E

That is a problem for t=
he upcoming --server-probe, which binds a probe
socket for every address fa=
mily in use, while a connection binds only
the family of the remote it is a=
bout to try=2E A --lport whose IPv6 port
happens to be taken by another pro=
cess would therefore kill a client
that could have connected over IPv4=2E

=
Give socket_bind() a msglevel and a return value, and let "optional"
apply =
to the bind as well: the socket is closed and SOCKET_UNDEFINED is
returned,=
 so the caller can skip that address family=2E Every existing
caller passes=
 M_FATAL and keeps its behaviour=2E

Change-Id: I24e5925a72aaede53ef9e863fe=
96fcd7363df402
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/op=
envpn/manage=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
3 files =
changed, 29 insertions(+), 14 deletions(-)


  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/15/1915/9

diff --git a/src/openvpn/ma=
nage=2Ec b/src/openvpn/manage=2Ec
index e121b38=2E=2E46b0abe 100644
--- a/s=
rc/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2044,7 +2044,7 @@
  =
       {
             man->connection=2Esd_top =3D create_socket_tcp(man->s=
ettings=2Elocal);
             socket_bind(man->connection=2Esd_top, man->s=
ettings=2Elocal, man->settings=2Elocal->ai_family,
-                       =
 "MANAGEMENT", false);
+                        "MANAGEMENT", false, M_FATA=
L);
         }
 
         /*
diff --git a/src/openvpn/socket=2Ec b/src/open=
vpn/socket=2Ec
index 41c8bac=2E=2E4c0aab5 100644
--- a/src/openvpn/socket=
=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -627,12 +627,13 @@
     {
         if =
(sock->socks_proxy && sock->info=2Eproto =3D=3D PROTO_UDP)
         {
-    =
        socket_bind(sock->ctrl_sd, sock->info=2Elsa->bind_local, sock->info=
=2Eaf, "SOCKS", false);
+            socket_bind(sock->ctrl_sd, sock->info=
=2Elsa->bind_local, sock->info=2Eaf, "SOCKS", false,
+                     =
   M_FATAL);
         }
         else
         {
             socket_bind(s=
ock->sd, sock->info=2Elsa->bind_local, sock->info=2Eaf, "TCP/UDP",
-       =
                 sock->info=2Ebind_ipv6_only);
+                        soc=
k->info=2Ebind_ipv6_only, M_FATAL);
         }
     }
 }
@@ -678,9 +679,11 =
@@
     }
 
     socket_apply_options(sd, sbs, mark, bind_dev);
-    if (bi=
nd_addr)
+    if (bind_addr
+        && !socket_bind(sd, bind_addr, af, "TC=
P/UDP", bind_ipv6_only, optional ? D_LOW : M_FATAL))
     {
-        socket=
_bind(sd, bind_addr, af, "TCP/UDP", bind_ipv6_only);
+        openvpn_close=
_socket(sd);
+        return SOCKET_UNDEFINED;
     }
     return sd;
 }
@@=
 -914,9 +917,9 @@
     return new_sd;
 }
 
-void
+bool
 socket_bind(socket_=
descriptor_t sd, struct addrinfo *local, int ai_family, const char *prefix,=

-            bool ipv6only)
+            bool ipv6only, msglvl_t msglevel)=

 {
     struct gc_arena gc =3D gc_new();
 
@@ -940,8 +943,10 @@
     }
   =
  if (!cur)
     {
-        msg(M_FATAL, "%s: Socket bind failed: Addr to b=
ind has no %s record", prefix,
+        msg(msglevel, "%s: Socket bind fail=
ed: Addr to bind has no %s record", prefix,
             addr_family_name(a=
i_family));
+        gc_free(&gc);
+        return false;
     }
 
     if =
(ai_family =3D=3D AF_INET6)
@@ -956,10 +961,13 @@
     }
     if (openvpn_b=
ind(sd, cur->ai_addr, cur->ai_addrlen))
     {
-        msg(M_FATAL | M_ERR=
NO, "%s: Socket bind failed on local address %s", prefix,
+        msg(msgl=
evel | M_ERRNO, "%s: Socket bind failed on local address %s", prefix,
     =
        print_sockaddr_ex(local->ai_addr, ":", PS_SHOW_PORT, &gc));
+      =
  gc_free(&gc);
+        return false;
     }
     gc_free(&gc);
+    retur=
n true;
 }
 
 int
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=
=2Eh
index 46fa29c=2E=2E20c10c2 100644
--- a/src/openvpn/socket=2Eh
+++ b/s=
rc/openvpn/socket=2Eh
@@ -348,8 +348,15 @@
 
 struct link_socket *link_sock=
et_new(void);
 
-void socket_bind(socket_descriptor_t sd, struct addrinfo *=
local, int af_family, const char *prefix,
-                 bool ipv6only);=

+/**
+ * Bind @p sd to the first @p af_family address of @p local=2E A fai=
lure is
+ * reported at @p msglevel, so a caller that can do without the bi=
nd passes a
+ * non-fatal level and checks the result=2E
+ *
+ * @return wh=
ether the socket was bound
+ */
+bool socket_bind(socket_descriptor_t sd, s=
truct addrinfo *local, int af_family, const char *prefix,
+                =
 bool ipv6only, msglvl_t msglevel);
 
 int openvpn_connect(socket_descripto=
r_t sd, const struct sockaddr *remote, int connect_timeout,
               =
      volatile int *signal_received);
@@ -405,9 +412,9 @@
  * Create a UDP =
socket for @p af set up the way a link socket is: --sndbuf/--rcvbuf,
  * --=
mark, --bind-dev and, when @p bind_addr is given, the local bind (IPV6_V6ON=
LY
  * per @p bind_ipv6_only)=2E Shared by create_socket() and the --server=
-probe sockets,
- * so a probe socket is the connection socket it may becom=
e=2E A failed bind is
- * fatal; with @p optional a socket the host cannot =
create is not, so
- * --server-probe can skip that address family (SOCKET_U=
NDEFINED is returned)=2E
+ * so a probe socket is the connection socket it =
may become=2E With @p optional a
+ * socket the host cannot create or bind =
is not fatal, so --server-probe can skip
+ * that address family (SOCKET_UN=
DEFINED is returned)=2E
  */
 socket_descriptor_t create_socket_udp_configu=
red(sa_family_t af, unsigned int sockflags,
                               =
                   const struct socket_buffer_size *sbs, int mark,

-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I24e5925a72aaede53ef9e863=
fe96fcd7363df402
Gerrit-Change-Number: 1915
Gerrit-PatchSet: 9
Gerrit-Owner=
: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ra=
lf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ec=
om>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--kFWWeWyDX+o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #9</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">socket: Let an optional UDP socket give up on a failed bind<br><br=
>create_socket_udp_configured()&#39;s &quot;optional&quot; argument covers =
only the<br>socket() call: socket_bind() is fatal, so a caller that can do =
without<br>the socket still dies if the address is unavailable=2E<br><br>Th=
at is a problem for the upcoming --server-probe, which binds a probe<br>soc=
ket for every address family in use, while a connection binds only<br>the f=
amily of the remote it is about to try=2E A --lport whose IPv6 port<br>happ=
ens to be taken by another process would therefore kill a client<br>that co=
uld have connected over IPv4=2E<br><br>Give socket_bind() a msglevel and a =
return value, and let &quot;optional&quot;<br>apply to the bind as well: th=
e socket is closed and SOCKET_UNDEFINED is<br>returned, so the caller can s=
kip that address family=2E Every existing<br>caller passes M_FATAL and keep=
s its behaviour=2E<br><br>Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df=
402<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M sr=
c/openvpn/manage=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2E=
h<br>3 files changed, 29 insertions(+), 14 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/15=
/1915/9</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2E=
c</span><br><span>index e121b38=2E=2E46b0abe 100644</span><br><span>--- a/s=
rc/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><b=
r><span>@@ -2044,7 +2044,7 @@</span><br><span>         {</span><br><span>  =
           man-&gt;connection=2Esd_top =3D create_socket_tcp(man-&gt;settin=
gs=2Elocal);</span><br><span>             socket_bind(man-&gt;connection=2E=
sd_top, man-&gt;settings=2Elocal, man-&gt;settings=2Elocal-&gt;ai_family,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 &quot;MANAGEMENT&quot;, false);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                        &quot;MANAGEMENT&quot;, false, M_FATAL=
);</span><br><span>         }</span><br><span> </span><br><span>         /*=
</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=
=2Ec</span><br><span>index 41c8bac=2E=2E4c0aab5 100644</span><br><span>--- =
a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span=
><br><span>@@ -627,12 +627,13 @@</span><br><span>     {</span><br><span>   =
      if (sock-&gt;socks_proxy &amp;&amp; sock-&gt;info=2Eproto =3D=3D PROT=
O_UDP)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            socket_bind(sock-&gt;ctrl_sd, sock-&gt;info=2Elsa-&=
gt;bind_local, sock-&gt;info=2Eaf, &quot;SOCKS&quot;, false);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            socket_bind(sock-&gt;=
ctrl_sd, sock-&gt;info=2Elsa-&gt;bind_local, sock-&gt;info=2Eaf, &quot;SOCK=
S&quot;, false,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    M_FATAL);</span><br><span>         }</span><br><span>  =
       else</span><br><span>         {</span><br><span>             socket_=
bind(sock-&gt;sd, sock-&gt;info=2Elsa-&gt;bind_local, sock-&gt;info=2Eaf, &=
quot;TCP/UDP&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                      sock-&gt;info=2Ebind_ipv6_only);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        sock-&gt;info=2E=
bind_ipv6_only, M_FATAL);</span><br><span>         }</span><br><span>     }=
</span><br><span> }</span><br><span>@@ -678,9 +679,11 @@</span><br><span>  =
   }</span><br><span> </span><br><span>     socket_apply_options(sd, sbs, m=
ark, bind_dev);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (bind_addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(bind_addr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &=
amp;&amp; !socket_bind(sd, bind_addr, af, &quot;TCP/UDP&quot;, bind_ipv6_on=
ly, optional ? D_LOW : M_FATAL))</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        socket_bind(sd, bind_addr, af, &q=
uot;TCP/UDP&quot;, bind_ipv6_only);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        openvpn_close_socket(sd);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return SOCKET_UNDEFINED;</span><br><s=
pan>     }</span><br><span>     return sd;</span><br><span> }</span><br><sp=
an>@@ -914,9 +917,9 @@</span><br><span>     return new_sd;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span> socket_bind(socket_descriptor_t sd, struct addrinfo *local, int ai_fa=
mily, const char *prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            bool ipv6only)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            bool ipv6only, msglvl_t msglevel)</span><br><span> {=
</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </s=
pan><br><span>@@ -940,8 +943,10 @@</span><br><span>     }</span><br><span> =
    if (!cur)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        msg(M_FATAL, &quot;%s: Socket bind failed: Addr to b=
ind has no %s record&quot;, prefix,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(msglevel, &quot;%s: Socket bind failed: Addr to=
 bind has no %s record&quot;, prefix,</span><br><span>             addr_fam=
ily_name(ai_family));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return false;</span><br><span>     }</span><br><span> </spa=
n><br><span>     if (ai_family =3D=3D AF_INET6)</span><br><span>@@ -956,10 =
+961,13 @@</span><br><span>     }</span><br><span>     if (openvpn_bind(sd,=
 cur-&gt;ai_addr, cur-&gt;ai_addrlen))</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL | M_ERRNO, &quo=
t;%s: Socket bind failed on local address %s&quot;, prefix,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel | M_ERRNO, &qu=
ot;%s: Socket bind failed on local address %s&quot;, prefix,</span><br><spa=
n>             print_sockaddr_ex(local-&gt;ai_addr, &quot;:&quot;, PS_SHOW_=
PORT, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return false;</span><br><span>     }</span><br><span>     gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn true;</span><br><span> }</span><br><span> </span><br><span> int</span><b=
r><span>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span>=
<br><span>index 46fa29c=2E=2E20c10c2 100644</span><br><span>--- a/src/openv=
pn/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>=
@@ -348,8 +348,15 @@</span><br><span> </span><br><span> struct link_socket =
*link_socket_new(void);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-void socket_bind(socket_descriptor_t sd, struct addrinf=
o *local, int af_family, const char *prefix,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                 bool ipv6only);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Bind @p sd to the first @p af_family address of @p l=
ocal=2E A failure is</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * reported at @p msglevel, so a caller that can do without the bind passe=
s a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * non-fatal lev=
el and checks the result=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retur=
n whether the socket was bound</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool =
socket_bind(socket_descriptor_t sd, struct addrinfo *local, int af_family, =
const char *prefix,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                 bool ipv6only, msglvl_t msglevel);</span><br><span> </span=
><br><span> int openvpn_connect(socket_descriptor_t sd, const struct sockad=
dr *remote, int connect_timeout,</span><br><span>                     volat=
ile int *signal_received);</span><br><span>@@ -405,9 +412,9 @@</span><br><s=
pan>  * Create a UDP socket for @p af set up the way a link socket is: --sn=
dbuf/--rcvbuf,</span><br><span>  * --mark, --bind-dev and, when @p bind_add=
r is given, the local bind (IPV6_V6ONLY</span><br><span>  * per @p bind_ipv=
6_only)=2E Shared by create_socket() and the --server-probe sockets,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * so a probe socket is the =
connection socket it may become=2E A failed bind is</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * fatal; with @p optional a socket the hos=
t cannot create is not, so</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * --server-probe can skip that address family (SOCKET_UNDEFINED is re=
turned)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * so a p=
robe socket is the connection socket it may become=2E With @p optional a</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * socket the host can=
not create or bind is not fatal, so --server-probe can skip</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * that address family (SOCKET_UNDE=
FINED is returned)=2E</span><br><span>  */</span><br><span> socket_descript=
or_t create_socket_udp_configured(sa_family_t af, unsigned int sockflags,</=
span><br><span>                                                  const stru=
ct socket_buffer_size *sbs, int mark,</span><br></pre><p>To view, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail">change =
1915</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1915 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;=
lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>

</body></html>
--kFWWeWyDX+o=--


--===============0149455487759950744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0149455487759950744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0149455487759950744==--

