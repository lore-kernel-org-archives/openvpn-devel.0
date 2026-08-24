Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E983C5DF9C
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IZecTeAlUeCoCECOecEET1Cu01i0UqUGTbkfaOZg0JU=; b=aaGfn5sVRr/Zdwr5zsLuJNvavs
	EcltXFIRtb3asrYGMQ8lpBj2S1wP40D/50lWmhsCFio1DFvWBey3KyS7UBK4rFUktiNl3SDnioAg+
	qr5kVER7//1FE77hA9Ud7tVp5FxdbpRLM7gvxZx+XOUSE8K2pwTRVeT7JR4dRMQxh+b0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wySDA-0004fA-I3;
	Mon, 24 Aug 2026 10:47:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wySD9-0004f3-5H
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:47:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4Cw8KYqnRNWKq6QcS3FKEQMMyE308aGAfjwNRk/PrrQ=; b=dM4P8VZbjlE3KqKIarz8i4Q9t6
 tuuuumVeRbLokiYoGnMR2cTS0e+C8m8E6Un3z4ZVwcLOR2iPHuVILqqeswRxOYOioQOcF9NBpyIdo
 O6wLLmZJnR+36OWpzfhIswFLr/nEjt7379xm0SjKQo5zvbjgebG/Jx5gd/FPr0YkfxjI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4Cw8KYqnRNWKq6QcS3FKEQMMyE308aGAfjwNRk/PrrQ=; b=H
 W/23DHtrjK24PgKta0/uw1RSuTHjYySyJa57Cb6zII9wdHa0LfUPdvXRvzqe9QChcBKTiiUmDB1xn
 lDR3+7GD0fdRl3o37ho2gKA3zH+Cx6RQ1BV0HbY8lw8dv7Wee92c/OOlHRUGO7rNAlETDoLoch28J
 pe0przQ92dBE4s5o=;
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wySD7-00020b-0j for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 10:47:27 +0000
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6a41191c9a9so6556818a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 03:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787568438; x=1788173238; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4Cw8KYqnRNWKq6QcS3FKEQMMyE308aGAfjwNRk/PrrQ=;
 b=Lwc/DBLWIM79CvUVsMMARCVIUTRxMtcj3oK63g4RFSxRFrKExWYDYdxfPAheKymzQK
 a2KvKGUtiEUeRLVzuPDph8/PCfcO8VXdfNX5JkP/jVTLrVWvI1YiQxXcX2ZCMjwukPlU
 PvY1AB88QHX71Nk/lAkzsB8fw7Y6Fdx1JEFPL10OZI4VhrizhSlZFTiovjzn3TpyV36v
 RG51rrHScNF1Uv0rCStFn8AmC4qYmalrjF5yzL10n34JBMq6csu0VWdxPQJ/rx2I+f6o
 lyLUOGwNTWbbL61VdZuXLzUSXsmx7kMjGn0x62qnJW0FB6/B/+pkYF3leiEM45XKB+xC
 VcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787568438; x=1788173238;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4Cw8KYqnRNWKq6QcS3FKEQMMyE308aGAfjwNRk/PrrQ=;
 b=AXEWIfiJmQGlA+sN3ivBHUfOylJCYYh/VsY5URkdxZ2f3fWFu9wAXth53yZ83RJ0Q4
 z+6BYb3qqYsQvkY5i2l4Auf6LHFar5jQ5Nv+5nfEkyGc9lSK3JP2jH318psJleKg/Mwu
 Opc1i7jAqYEb3zq3zARp/4dF0bDAZQuL0a3oWvHEAPbI6rVY2UOYhHhGV1h2BzCZnK7q
 Ob5ruJHI3Fw2ap7tPJS9uGkw0jJ8/luQZAoTrC6yAFtNxFbIclH7MryewciKGotNNpJu
 BZPJp1tsx0qejoHD8l3govQBVP8bngh5HanhpbCFHKh6pOgL/z+6c5WkRhZLsQhNqNZ9
 Rdug==
X-Forwarded-Encrypted: i=1;
 AHgh+RrubplnNXZP2ohXCW1/xUvKAPFvnNfs888lh+TowEiuLcn8azp9OG3ZuXbF0oatvx+oV+TBiWQg1ssMYLsj@lists.sourceforge.net
X-Gm-Message-State: AFuF++mxG/3hK2MQLy4HTu1QnCwSmRXWxmjyYvkL0C1zUwIeUsI15NkI
 mx5MLKp6//KUOyELfqacC1mlvwYPDiu4sTjwmgpOcfjaRseZLgQusvnWOrpNU2CBFyhGnlmB+xF
 TM1/tEqTvON2MrlKGvc17NbKLYUeQhW7AVunfXMOQR4A7G38zq84aQgwQ0YStXKL7VhRz
X-Gm-Gg: AR+sD1030x0YywZn/7c2TSxLDdVMXYfSb22aW51pAg8InIDvZ6RDctTX2hj/7C8YfqL
 tTYjrBN3uv8t9fq/BpBUZ6kdHm01O/gr1w5i9kmAV0nND899yH+p9q3j+pkBFTmgryfm+HT3Uj8
 I2OUIJK+Ce6BBZHOiKFEGQm5DKqka9FeDJQboErEg1E7zigKOKB+CA0xXGgcsdXkccJM5yQ0zUN
 DlzfLxjIAsEOPwobuLO5dBBle3MXcKnop2qB9k9nP4NRB4DGt+Zy1w6fHNI1U5tZPXe+c/RSzym
 kS/uoqZcEJC0VzvGZ1cwnxG+OSbgoBsGHbeVFeZDcWUS1T1EZFgeiV8JR7MwJXhrP0/9UPMGrrw
 6x4uuokhp23ypUgcd7RJlvOfxJ+ISMJyRranExa5v5Qum7ucbIN4NfmRGVT1yQnpbazynqWNm9p
 POElOBiDy1+D2duH01tiCiTptO2I2uMBU8zFH6ohgG+9lEbiYKM6Fyn/61qUkDHPPJdVHG6O27f
 UZRMH7EoNqJ7YADJEixxRsNJpoGKWsklBe4QWuqw1kCVpjTID//thP7DPwWqw4HiDNi4mgmd7YT
 61+y/H2L03DiLHcqdGcCkOpFBU5ZYtFubKvkxafkERdYsHGP3jg=
X-Received: by 2002:a17:907:930a:b0:c1c:6f0d:5b22 with SMTP id
 a640c23a62f3a-c246a654342mr3053362466b.11.1787568438135; 
 Mon, 24 Aug 2026 03:47:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f9cbcsm1337772966b.29.2026.08.24.03.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:47:17 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 10:47:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I7be7427480d3540d43dd818eddb6eb5860956459
X-Gerrit-Change-Number: 1476
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1476?usp=email>
X-Gerrit-Commit: f60ede0a4794500f000dfc310e49d3938b3f5748
In-Reply-To: <gerrit.1768578994000.I7be7427480d3540d43dd818eddb6eb5860956459@gerrit.openvpn.net>
References: <gerrit.1768578994000.I7be7427480d3540d43dd818eddb6eb5860956459@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY4NTc4OTk0MDAwLkk3YmU3NDI3NDgwZDM1NDBkNDNkZDgxOGVkZGI2ZWI1ODYwOTU2NDU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <43861aafc40cd87ac18209f125deb8cb8d67769f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wySD7-00020b-0j
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3990809278318319053=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3990809278318319053==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3j4fLVh2uo8="; charset=UTF-8

--3j4fLVh2uo8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Demail

to look at the new patch=
 set (#10)=2E


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
---
M src/openvpn/options=2Ec
M src/ope=
nvpn/socket=2Ec
M src/openvpn/socket_util=2Ec
3 files changed, 30 insertion=
s(+), 40 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/76/1476/10

diff --git a/src/openvpn/options=2Ec b/src/open=
vpn/options=2Ec
index 107b3fa9=2E=2E089bff4 100644
--- a/src/openvpn/option=
s=2Ec
+++ b/src/openvpn/options=2Ec
@@ -5125,7 +5125,15 @@
     else if (st=
req(p[0], "bind-dev") && p[1])
     {
         VERIFY_PERMISSION(OPT_P_SOCK=
FLAGS);
-        options->bind_dev =3D p[1];
+        if (strlen(p[1]) < IF=
NAMSIZ)
+        {
+            options->bind_dev =3D p[1];
+        }
+   =
     else
+        {
+            msg(msglevel, "argument to --bind-dev is =
longer than allowed %u", IFNAMSIZ - 1);
+            goto err;
+        }
 =
    }
 #endif
     else if (streq(p[0], "txqueuelen") && p[1] && !p[2])
@@ =
-5211,11 +5219,9 @@
     }
     else if (streq(p[0], "proto") && p[1] && !p=
[2])
     {
-        int proto;
-        sa_family_t af;
         VERIFY_PE=
RMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
-        proto =3D ascii2proto(=
p[1]);
-        af =3D ascii2af(p[1]);
+        int proto =3D ascii2proto(p=
[1]);
+        sa_family_t af =3D ascii2af(p[1]);
         if (proto < 0)
 =
        {
             msg(msglevel, "Bad protocol: '%s'=2E Allowed protoco=
ls with --proto option: %s", p[1],
diff --git a/src/openvpn/socket=2Ec b/sr=
c/openvpn/socket=2Ec
index 0f66ad51=2E=2E0a08267 100644
--- a/src/openvpn/s=
ocket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -619,28 +619,23 @@
 }
 
 static v=
oid
-bind_local(struct link_socket *sock, const sa_family_t ai_family)
+bin=
d_local(struct link_socket *sock)
 {
     /* bind to local address/port */
=
     if (sock->bind_local)
     {
         if (sock->socks_proxy && sock->i=
nfo=2Eproto =3D=3D PROTO_UDP)
         {
-            socket_bind(sock->ctr=
l_sd, sock->info=2Elsa->bind_local, ai_family, "SOCKS", false);
+          =
  socket_bind(sock->ctrl_sd, sock->info=2Elsa->bind_local, sock->info=2Eaf,=
 "SOCKS", false);
         }
         else
         {
-            socket_b=
ind(sock->sd, sock->info=2Elsa->bind_local, ai_family, "TCP/UDP",
+        =
    socket_bind(sock->sd, sock->info=2Elsa->bind_local, sock->info=2Eaf, "T=
CP/UDP",
                         sock->info=2Ebind_ipv6_only);
         }
=
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagn=
ostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static=
 void
 create_socket(struct link_socket *sock, struct addrinfo *addr)
 {
@@=
 -672,7 +667,7 @@
     }
     /* Set af field of sock->info, so it always r=
eflects the address family
      * of the created socket */
-    sock->info=
=2Eaf =3D addr->ai_family;
+    sock->info=2Eaf =3D (sa_family_t)addr->ai_f=
amily;
 
     /* set socket buffers based on --sndbuf and --rcvbuf options =
*/
     socket_set_buffers(sock->sd, &sock->socket_buffer_sizes, true);
@@ =
-684,8 +679,9 @@
     if (sock->bind_dev)
     {
         msg(M_INFO, "Usin=
g bind-dev %s", sock->bind_dev);
+        /* Note: We verify strlen of bind=
_dev in options parsing */
         if (setsockopt(sock->sd, SOL_SOCKET, SO=
_BINDTODEVICE, sock->bind_dev,
-                       strlen(sock->bind_de=
v) + 1)
+                       (socklen_t)(strlen(sock->bind_dev) + 1))
  =
           !=3D 0)
         {
             msg(M_WARN | M_ERRNO, "WARN: set=
sockopt SO_BINDTODEVICE=3D%s failed", sock->bind_dev);
@@ -693,13 +689,9 @@=

     }
 #endif
 
-    bind_local(sock, addr->ai_family);
+    bind_local(s=
ock);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagno=
stic pop
-#endif
-
 #ifdef TARGET_ANDROID
 static void
 protect_fd_nonlocal=
(int fd, const struct sockaddr *addr)
@@ -1131,13 +1123,8 @@
     }
 }
 
-#=
if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#p=
ragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
-resolve=
_bind_local(struct link_socket *sock, const sa_family_t af)
+resolve_bind_l=
ocal(struct link_socket *sock)
 {
     struct gc_arena gc =3D gc_new();
 
@=
@ -1153,12 +1140,12 @@
         }
 
         /* will return AF_{INET|INET6}=
from local_host */
-        status =3D get_cached_dns_entry(sock->dns_cache=
, sock->local_host, sock->local_port, af,
+        status =3D get_cached_dn=
s_entry(sock->dns_cache, sock->local_host, sock->local_port, sock->info=2Ea=
f,
                                       flags, &sock->info=2Elsa->bind_lo=
cal);
 
         if (status)
         {
-            status =3D openvpn_get=
addrinfo(flags, sock->local_host, sock->local_port, 0, NULL, af,
+         =
   status =3D openvpn_getaddrinfo(flags, sock->local_host, sock->local_port=
, 0, NULL, sock->info=2Eaf,
                                          &sock=
->info=2Elsa->bind_local);
         }
 
@@ -1179,7 +1166,7 @@
             =
/* the resolved 'local entry' might have a different family than
          =
    * what was globally configured
              */
-            sock->info=
=2Eaf =3D sock->info=2Elsa->bind_local->ai_family;
+            sock->info=
=2Eaf =3D (sa_family_t)sock->info=2Elsa->bind_local->ai_family;
         }
=
     }
 
@@ -1382,7 +1369,8 @@
 
     sock->mark =3D o->mark;
     sock->bi=
nd_dev =3D o->bind_dev;
-    sock->info=2Eproto =3D proto;
+    ASSERT(prot=
o >=3D 0 && proto < PROTO_N);
+    sock->info=2Eproto =3D (uint8_t)proto;
 =
    sock->info=2Eaf =3D o->ce=2Eaf;
     sock->info=2Eremote_float =3D o->c=
e=2Eremote_float;
     sock->info=2Elsa =3D &c->c1=2Elink_socket_addrs[sock=
_index];
@@ -1448,7 +1436,7 @@
     {
         if (sock->bind_local)
      =
   {
-            resolve_bind_local(sock, sock->info=2Eaf);
+            r=
esolve_bind_local(sock);
         }
         resolve_remote(sock, 1, NULL);=

     }
@@ -1713,9 +1701,9 @@
              * and we should not connect a r=
emote */
             if (sock->info=2Eaf =3D=3D AF_UNSPEC)
             {
=
+                sock->info=2Eaf =3D (sa_family_t)sock->info=2Elsa->bind_lo=
cal->ai_family;
                 msg(M_WARN, "Could not determine IPv4/IPv6=
 protocol=2E Using %s",
-                    addr_family_name(sock->info=2E=
lsa->bind_local->ai_family));
-                sock->info=2Eaf =3D sock->in=
fo=2Elsa->bind_local->ai_family;
+                    addr_family_name(sock=
->info=2Eaf));
             }
             create_socket(sock, sock->info=
=2Elsa->bind_local);
         }
@@ -1775,10 +1763,6 @@
     }
 }
 
-#if def=
ined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
=
 void
 link_socket_close(struct link_socket *sock)
 {
@@ -2384,8 +2368,8 @@=

     else if (cmsg !=3D NULL)
     {
         msg(M_WARN,
-            "CM=
SG received that cannot be parsed (cmsg_level=3D%d, cmsg_type=3D%d, cmsg=3D=
len=3D%d)",
-            (int)cmsg->cmsg_level, (int)cmsg->cmsg_type, (int)=
cmsg->cmsg_len);
+            "CMSG received that cannot be parsed (cmsg_le=
vel=3D%d, cmsg_type=3D%d, cmsg=3Dlen=3D%zu)",
+            cmsg->cmsg_level=
, cmsg->cmsg_type, (size_t)cmsg->cmsg_len);
     }
 
     return buf->len;
=
diff --git a/src/openvpn/socket_util=2Ec b/src/openvpn/socket_util=2Ec
inde=
x 0194f38=2E=2E913ac69 100644
--- a/src/openvpn/socket_util=2Ec
+++ b/src/o=
penvpn/socket_util=2Ec
@@ -356,7 +356,7 @@
     const char *short_form;
   =
  const char *display_form;
     sa_family_t proto_af;
-    int proto;
+   =
 uint8_t proto;
 };
 
 /* Indexed by PROTO_x */

-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I7be7427480d3540d43dd818eddb6eb5860956459
Ge=
rrit-Change-Number: 1476
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <raz=
vanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--3j4fLVh2uo8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #10</strong> to this change=2E</p><p><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1476?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">socket: Fix various conversion warnings<br><br>- We assume tha=
t addrinfo-&gt;ai_family always fits<br>  into a sa_family_t, so we do not =
check those=2E<br>- Reduce places where we explicitly pass ai_family<br>  a=
nd prefer sock-&gt;info=2Eaf=2E<br>- Make sure that --bind-dev has a suitab=
le length=2E<br>- Treat PROTO_* as uint8_t where possible (however,<br>  mu=
ch code uses proto =3D -1 for various error handling)=2E<br><br>Change-Id: =
I7be7427480d3540d43dd818eddb6eb5860956459<br>Signed-off-by: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/options=2Ec<br>M=
 src/openvpn/socket=2Ec<br>M src/openvpn/socket_util=2Ec<br>3 files changed=
, 30 insertions(+), 40 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/76/1476/10</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span=
>index 107b3fa9=2E=2E089bff4 100644</span><br><span>--- a/src/openvpn/optio=
ns=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -51=
25,7 +5125,15 @@</span><br><span>     else if (streq(p[0], &quot;bind-dev&q=
uot;) &amp;&amp; p[1])</span><br><span>     {</span><br><span>         VERI=
FY_PERMISSION(OPT_P_SOCKFLAGS);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        options-&gt;bind_dev =3D p[1];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (strlen(p[1]) &lt; IFNAMSIZ)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;bind_dev =3D=
 p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;argument=
 to --bind-dev is longer than allowed %u&quot;, IFNAMSIZ - 1);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>    =
 }</span><br><span> #endif</span><br><span>     else if (streq(p[0], &quot;=
txqueuelen&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>@@ -521=
1,11 +5219,9 @@</span><br><span>     }</span><br><span>     else if (streq(=
p[0], &quot;proto&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int pro=
to;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sa_family_=
t af;</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONN=
ECTION);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        proto=
 =3D ascii2proto(p[1]);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        af =3D ascii2af(p[1]);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        int proto =3D ascii2proto(p[1]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        sa_family_t af =3D ascii2af(p[1])=
;</span><br><span>         if (proto &lt; 0)</span><br><span>         {</sp=
an><br><span>             msg(msglevel, &quot;Bad protocol: &#39;%s&#39;=2E=
 Allowed protocols with --proto option: %s&quot;, p[1],</span><br><span>dif=
f --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>i=
ndex 0f66ad51=2E=2E0a08267 100644</span><br><span>--- a/src/openvpn/socket=
=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -619,2=
8 +619,23 @@</span><br><span> }</span><br><span> </span><br><span> static v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bind_local(struct =
link_socket *sock, const sa_family_t ai_family)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bind_local(struct link_socket *sock)</span><br>=
<span> {</span><br><span>     /* bind to local address/port */</span><br><s=
pan>     if (sock-&gt;bind_local)</span><br><span>     {</span><br><span>  =
       if (sock-&gt;socks_proxy &amp;&amp; sock-&gt;info=2Eproto =3D=3D PRO=
TO_UDP)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            socket_bind(sock-&gt;ctrl_sd, sock-&gt;info=2Elsa-=
&gt;bind_local, ai_family, &quot;SOCKS&quot;, false);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            socket_bind(sock-&gt;ctrl_sd,=
 sock-&gt;info=2Elsa-&gt;bind_local, sock-&gt;info=2Eaf, &quot;SOCKS&quot;,=
 false);</span><br><span>         }</span><br><span>         else</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        socket_bind(sock-&gt;sd, sock-&gt;info=2Elsa-&gt;bind_local, ai_fam=
ily, &quot;TCP/UDP&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            socket_bind(sock-&gt;sd, sock-&gt;info=2Elsa-&gt;bind_loc=
al, sock-&gt;info=2Eaf, &quot;TCP/UDP&quot;,</span><br><span>              =
           sock-&gt;info=2Ebind_ipv6_only);</span><br><span>         }</spa=
n><br><span>     }</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC d=
iagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> static void</span><br><span> create_socket(struct l=
ink_socket *sock, struct addrinfo *addr)</span><br><span> {</span><br><span=
>@@ -672,7 +667,7 @@</span><br><span>     }</span><br><span>     /* Set af =
field of sock-&gt;info, so it always reflects the address family</span><br>=
<span>      * of the created socket */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    sock-&gt;info=2Eaf =3D addr-&gt;ai_family;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;info=2Eaf =3D (sa_=
family_t)addr-&gt;ai_family;</span><br><span> </span><br><span>     /* set =
socket buffers based on --sndbuf and --rcvbuf options */</span><br><span>  =
   socket_set_buffers(sock-&gt;sd, &amp;sock-&gt;socket_buffer_sizes, true)=
;</span><br><span>@@ -684,8 +679,9 @@</span><br><span>     if (sock-&gt;bin=
d_dev)</span><br><span>     {</span><br><span>         msg(M_INFO, &quot;Us=
ing bind-dev %s&quot;, sock-&gt;bind_dev);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* Note: We verify strlen of bind_dev in opt=
ions parsing */</span><br><span>         if (setsockopt(sock-&gt;sd, SOL_SO=
CKET, SO_BINDTODEVICE, sock-&gt;bind_dev,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                       strlen(sock-&gt;bind_dev) + 1)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
  (socklen_t)(strlen(sock-&gt;bind_dev) + 1))</span><br><span>             =
!=3D 0)</span><br><span>         {</span><br><span>             msg(M_WARN =
| M_ERRNO, &quot;WARN: setsockopt SO_BINDTODEVICE=3D%s failed&quot;, sock-&=
gt;bind_dev);</span><br><span>@@ -693,13 +689,9 @@</span><br><span>     }</=
span><br><span> #endif</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    bind_local(sock, addr-&gt;ai_family);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    bind_local(sock);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> #ifdef TARGET_ANDROID</span><br><span> s=
tatic void</span><br><span> protect_fd_nonlocal(int fd, const struct sockad=
dr *addr)</span><br><span>@@ -1131,13 +1123,8 @@</span><br><span>     }</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quo=
t;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-resolve_=
bind_local(struct link_socket *sock, const sa_family_t af)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+resolve_bind_local(struct link_socke=
t *sock)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_=
new();</span><br><span> </span><br><span>@@ -1153,12 +1140,12 @@</span><br>=
<span>         }</span><br><span> </span><br><span>         /* will return =
AF_{INET|INET6}from local_host */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        status =3D get_cached_dns_entry(sock-&gt;dns_cache, soc=
k-&gt;local_host, sock-&gt;local_port, af,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        status =3D get_cached_dns_entry(sock-&gt;dns=
_cache, sock-&gt;local_host, sock-&gt;local_port, sock-&gt;info=2Eaf,</span=
><br><span>                                       flags, &amp;sock-&gt;info=
=2Elsa-&gt;bind_local);</span><br><span> </span><br><span>         if (stat=
us)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            status =3D openvpn_getaddrinfo(flags, sock-&gt;local_h=
ost, sock-&gt;local_port, 0, NULL, af,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            status =3D openvpn_getaddrinfo(flags, sock-&=
gt;local_host, sock-&gt;local_port, 0, NULL, sock-&gt;info=2Eaf,</span><br>=
<span>                                          &amp;sock-&gt;info=2Elsa-&g=
t;bind_local);</span><br><span>         }</span><br><span> </span><br><span=
>@@ -1179,7 +1166,7 @@</span><br><span>             /* the resolved &#39;lo=
cal entry&#39; might have a different family than</span><br><span>         =
     * what was globally configured</span><br><span>              */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            sock-&gt;info=2E=
af =3D sock-&gt;info=2Elsa-&gt;bind_local-&gt;ai_family;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            sock-&gt;info=2Eaf =3D (sa=
_family_t)sock-&gt;info=2Elsa-&gt;bind_local-&gt;ai_family;</span><br><span=
>         }</span><br><span>     }</span><br><span> </span><br><span>@@ -13=
82,7 +1369,8 @@</span><br><span> </span><br><span>     sock-&gt;mark =3D o-=
&gt;mark;</span><br><span>     sock-&gt;bind_dev =3D o-&gt;bind_dev;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    sock-&gt;info=2Eproto =
=3D proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSER=
T(proto &gt;=3D 0 &amp;&amp; proto &lt; PROTO_N);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    sock-&gt;info=2Eproto =3D (uint8_t)proto;=
</span><br><span>     sock-&gt;info=2Eaf =3D o-&gt;ce=2Eaf;</span><br><span=
>     sock-&gt;info=2Eremote_float =3D o-&gt;ce=2Eremote_float;</span><br><=
span>     sock-&gt;info=2Elsa =3D &amp;c-&gt;c1=2Elink_socket_addrs[sock_in=
dex];</span><br><span>@@ -1448,7 +1436,7 @@</span><br><span>     {</span><b=
r><span>         if (sock-&gt;bind_local)</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            resolve_bind_loc=
al(sock, sock-&gt;info=2Eaf);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            resolve_bind_local(sock);</span><br><span>         }<=
/span><br><span>         resolve_remote(sock, 1, NULL);</span><br><span>   =
  }</span><br><span>@@ -1713,9 +1701,9 @@</span><br><span>              * a=
nd we should not connect a remote */</span><br><span>             if (sock-=
&gt;info=2Eaf =3D=3D AF_UNSPEC)</span><br><span>             {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                sock-&gt;info=2E=
af =3D (sa_family_t)sock-&gt;info=2Elsa-&gt;bind_local-&gt;ai_family;</span=
><br><span>                 msg(M_WARN, &quot;Could not determine IPv4/IPv6=
 protocol=2E Using %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    addr_family_name(sock-&gt;info=2Elsa-&gt;bind_lo=
cal-&gt;ai_family));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               sock-&gt;info=2Eaf =3D sock-&gt;info=2Elsa-&gt;bind_local-&g=
t;ai_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             addr_family_name(sock-&gt;info=2Eaf));</span><br><span>       =
      }</span><br><span>             create_socket(sock, sock-&gt;info=2Els=
a-&gt;bind_local);</span><br><span>         }</span><br><span>@@ -1775,10 +=
1763,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> void</span><br><span> link_socket_close(struct link_socket *sock)</span>=
<br><span> {</span><br><span>@@ -2384,8 +2368,8 @@</span><br><span>     els=
e if (cmsg !=3D NULL)</span><br><span>     {</span><br><span>         msg(M=
_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &qu=
ot;CMSG received that cannot be parsed (cmsg_level=3D%d, cmsg_type=3D%d, cm=
sg=3Dlen=3D%d)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            (int)cmsg-&gt;cmsg_level, (int)cmsg-&gt;cmsg_type, (int)cmsg-&g=
t;cmsg_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &quot;CMSG received that cannot be parsed (cmsg_level=3D%d, cmsg_type=
=3D%d, cmsg=3Dlen=3D%zu)&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            cmsg-&gt;cmsg_level, cmsg-&gt;cmsg_type, (size_t)cm=
sg-&gt;cmsg_len);</span><br><span>     }</span><br><span> </span><br><span>=
     return buf-&gt;len;</span><br><span>diff --git a/src/openvpn/socket_ut=
il=2Ec b/src/openvpn/socket_util=2Ec</span><br><span>index 0194f38=2E=2E913=
ac69 100644</span><br><span>--- a/src/openvpn/socket_util=2Ec</span><br><sp=
an>+++ b/src/openvpn/socket_util=2Ec</span><br><span>@@ -356,7 +356,7 @@</s=
pan><br><span>     const char *short_form;</span><br><span>     const char =
*display_form;</span><br><span>     sa_family_t proto_af;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int proto;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    uint8_t proto;</span><br><span> };</span=
><br><span> </span><br><span> /* Indexed by PROTO_x */</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1476?usp=3Demail">change 1476</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1476?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I7be7427480d3540d43dd818eddb6eb5860=
956459 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1476 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body><=
/html>
--3j4fLVh2uo8=--


--===============3990809278318319053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3990809278318319053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3990809278318319053==--

