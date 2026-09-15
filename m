Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887B8C88E7B
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qlVeY4xfU/UdzxAtsi6sBJStfeMjkVJiQtfkuapyl+k=; b=SgmCU3FYxNTstpCE/0w++4EN92
	OrWlFxCpgFBz5dMZqGDZPof9aYiYyAfSyOOfewQO5o6U6+nv3xkwME0avUzkkWKotsqz0XP/i93xl
	HzsSDkTN5McWJ5xjbUl7BfVLBdn+/+txH7GKse29aazqEfbK+aMw1gTY9aI6w8ltC1BI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6Sl6-0005gW-84;
	Tue, 15 Sep 2026 12:59:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6Sl4-0005gI-OY
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:59:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vMxCOox3uWzGdjGY1T+UEB7slrouAaqJMr6A9yD6Ikw=; b=au7IjpGBwur4AYozUb/Lmxjqcn
 K2FdMeY5Zs1IdWdbh5GMjALp7QO2f8l2ZoCSd1ek6GUBFK64xtvFGq4PtLHRYbC5iP7V5n/1u2ILb
 9SOmHfKfmYtGz5oBO3ildzr4PtgqvRe159DiXNwkQqJn6nUx68V3bR81UENoanilFhmg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vMxCOox3uWzGdjGY1T+UEB7slrouAaqJMr6A9yD6Ikw=; b=D
 jpThrgqKQiQ8Y6lJudsAhe5O6GZS2fZh5/ratSvJ6jpBG+y8LXd1C041a5AUvDWH9TCsdL1jM6IMy
 rWgzJi6FZiFBxi1kt0z/DmlLqB+T86FuD8AD3NsBBDKGiPFLd4V3b/CtueJxAyFPmOghd/1oyWMMK
 N3p1Ob+QrNi0YsuY=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6Sl2-0007gg-6H for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:59:35 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so2118405e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 05:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789477166; x=1790081966; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vMxCOox3uWzGdjGY1T+UEB7slrouAaqJMr6A9yD6Ikw=;
 b=bJXQB427dvkzTEjCgPbIaGX2O7GQ+8CH13YCf90V9s0YeMkObRINSXkCxbXASrQFx6
 PNJ5UfQcsRXvcMvT4GO0Avm/GWwTsKDSOk0552izsXD4Xx9K5EyM1E+qK9NKlW1WHYUN
 3FIAOJvBO0nMJvoO/a/FSO6hGiv2JhL694Hq8RbzFZd/X91PJ/49p3hf8JGWVgUwacTa
 bcJRGbmyH0LDhk1mlWe2RSkY2EmO5oGuUYllITYLbJ2lypzNVEkRKap0sOUnMvZik7pb
 MDiG3gni3fdJTUE3keasAp0eAgsFFEkGTj9GU++h+i/oHmpCCLbzlkRCWKlpE57AWp6R
 /nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789477166; x=1790081966;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vMxCOox3uWzGdjGY1T+UEB7slrouAaqJMr6A9yD6Ikw=;
 b=cxybvGvCHQJNTQ8XCTLiwS5fOoEKDVIRl3wnphsSA201WVWv0iywAQdQjydkh7CS/h
 Eq4fEw2mW0p21llPhEWjevAkNCAsj/n53fmt1fGqYUJq0oermS+VMVbyVLFvXPQJKW7M
 lnJ6jnHx2nVW8GX1rKtWNiIu0DJafakt7fttLVd4f53pPZxJmf9EeQY0IFJITpTAtlMZ
 /etLtXEQINdlRLqNPPuIvPLr3yqa13sgK/6Bn3LH4MmNRJFn3MgkXH56Q33YTnek/cfR
 tZBGv4uIqQW1dzEcOoijoZmflaIQUx9ivj8wAWx3yxp52e0Rp+e9MgRxSXOTy3BLJdhY
 ljwg==
X-Gm-Message-State: AFuF++l7iBFf4IGzhHuoYBzVge3Ux+nKYI+D2OXVfwL9CIaeoOm8VY8M
 U8SCGIRjzbqBciJQaKEKSW9iIpSPwqPrte+99FvAgMAgt/x6L10WZhgyr9Mz1LbRroRFopM5hSF
 9uU3gmAKuPLpHQeZ0RnwUBcr5k/WlEzW69EXdcmHfvbKVbTMy3iqYLZfIY22Y+jmSjJtJ
X-Gm-Gg: AYBFou07Kv4OQRNVAKKBeNrUp/CuHCQVV6+uy3FNZ0WYyUd+/g5Gvnlba0gAG13WVWx
 nwU2nyVfgkfXqisT1N/adh08co+tC8TDZmHP3aUuKGR6W3j9kWBpZdVr1uxdXGVCUS5Lq06hrT5
 cO3DIrlIoZQ6xyNGGtp2NS6aKW+MaFjmZSZy6fcI2XqT+ucPof8LAHWOwD3cvCtTxW4hSRW/UUL
 CbYgWUmGrhJRqs1M8SxU0CnPSOuqE1BeX9qri09mLJPFB0gWWDTYWIKeS/oMWJ2wN3vPDYIBT97
 RZ+6x4j0SjJlx+T5KEw3kOicnVekbXYLhdj+RuxqE0mPeL9nJoW+ha0m26cBiWo2fJvWzUK7nvW
 CX5lG49v2FO/drEVjT79VHe3Y2xMO8fk7hSbRLiTQOrYjGGZE/N2gYErsaCUf811qeotBshc4Hy
 hm77nKLfR0qxFFrFmJRhG2rMqhUXHx8bGFJ4/PBDUkIJx447u4Zs19OsQHA0F1CvhK0o/iFB41X
 i70O8jPih7tFVUerMcsSMh7d+mGb3swGStQuWRVhZl6hnOb8OBLAwyJfOU1xv/ve+t3tmjpoVL3
 AB0Jz7IAiNpBEDJz2mKxYO7B6m4saZO/14sLs0JSt1iyW0gSUHVirVrCwhtRjA==
X-Received: by 2002:a05:600c:c4a2:b0:49d:1842:f001 with SMTP id
 5b1f17b1804b1-49e8224ff79mr15067755e9.14.1789477165410; 
 Tue, 15 Sep 2026 05:59:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7ef6bc50sm63615105e9.3.2026.09.15.05.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 05:59:25 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 12:59:19 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
X-Gerrit-Change-Number: 1915
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1915?usp=email>
X-Gerrit-Commit: f8b56895c8b30e954f0d3a12c95c420a24f8bea8
In-Reply-To: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
References: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5Mzk1NTEyMDAwLkkyNGU1OTI1YTcyYWFlZGU1M2VmOWU4NjNmZTk2ZmNkNzM2M2RmNDAyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b12dc64ee562619a15260d4997c5a9c7e4539821-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6Sl2-0007gg-6H
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: let an
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1759791306910763250=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1759791306910763250==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pZV+agvBRkI="; charset=UTF-8

--pZV+agvBRkI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1915?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: socket: let an optional UDP socket give up on a failed bin=
d
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket: le=
t an optional UDP socket give up on a failed bind

create_socket_udp_config=
ured()'s "optional" argument covers only the
socket() call: socket_bind() i=
s fatal, so a caller that can do without
the socket still dies if the addre=
ss is unavailable=2E

That is a problem for --server-probe, which binds a p=
robe socket for
every address family in use, while a connection binds only =
the family of
the remote it is about to try=2E A --lport whose IPv6 port ha=
ppens to be
taken by another process therefore kills a client that would ha=
ve
connected over IPv4=2E

Give socket_bind() a msglevel and a return value=
, and let "optional"
apply to the bind as well: the socket is closed and SO=
CKET_UNDEFINED is
returned, so the caller can skip that address family=2E E=
very existing
caller passes M_FATAL and keeps its behaviour=2E

Change-Id: =
I24e5925a72aaede53ef9e863fe96fcd7363df402
Signed-off-by: Lev Stipakov <lev@=
openvpn=2Enet>
---
M src/openvpn/manage=2Ec
M src/openvpn/socket=2Ec
M src/=
openvpn/socket=2Eh
3 files changed, 32 insertions(+), 17 deletions(-)


  g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/15/1915/2

=
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index e121b38=
=2E=2E46b0abe 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=
=2Ec
@@ -2044,7 +2044,7 @@
         {
             man->connection=2Esd_top=
 =3D create_socket_tcp(man->settings=2Elocal);
             socket_bind(man=
->connection=2Esd_top, man->settings=2Elocal, man->settings=2Elocal->ai_fam=
ily,
-                        "MANAGEMENT", false);
+                      =
  "MANAGEMENT", false, M_FATAL);
         }
 
         /*
diff --git a/src/=
openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 41c8bac=2E=2E4c0aab5 1006=
44
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -627,12 +62=
7,13 @@
     {
         if (sock->socks_proxy && sock->info=2Eproto =3D=3D =
PROTO_UDP)
         {
-            socket_bind(sock->ctrl_sd, sock->info=2E=
lsa->bind_local, sock->info=2Eaf, "SOCKS", false);
+            socket_bind=
(sock->ctrl_sd, sock->info=2Elsa->bind_local, sock->info=2Eaf, "SOCKS", fal=
se,
+                        M_FATAL);
         }
         else
         {
=
             socket_bind(sock->sd, sock->info=2Elsa->bind_local, sock->info=
=2Eaf, "TCP/UDP",
-                        sock->info=2Ebind_ipv6_only);
+ =
                       sock->info=2Ebind_ipv6_only, M_FATAL);
         }
  =
   }
 }
@@ -678,9 +679,11 @@
     }
 
     socket_apply_options(sd, sbs, ma=
rk, bind_dev);
-    if (bind_addr)
+    if (bind_addr
+        && !socket_b=
ind(sd, bind_addr, af, "TCP/UDP", bind_ipv6_only, optional ? D_LOW : M_FATA=
L))
     {
-        socket_bind(sd, bind_addr, af, "TCP/UDP", bind_ipv6_onl=
y);
+        openvpn_close_socket(sd);
+        return SOCKET_UNDEFINED;
  =
   }
     return sd;
 }
@@ -914,9 +917,9 @@
     return new_sd;
 }
 
-void
=
+bool
 socket_bind(socket_descriptor_t sd, struct addrinfo *local, int ai_f=
amily, const char *prefix,
-            bool ipv6only)
+            bool ip=
v6only, msglvl_t msglevel)
 {
     struct gc_arena gc =3D gc_new();
 
@@ -9=
40,8 +943,10 @@
     }
     if (!cur)
     {
-        msg(M_FATAL, "%s: Soc=
ket bind failed: Addr to bind has no %s record", prefix,
+        msg(msgle=
vel, "%s: Socket bind failed: Addr to bind has no %s record", prefix,
     =
        addr_family_name(ai_family));
+        gc_free(&gc);
+        retur=
n false;
     }
 
     if (ai_family =3D=3D AF_INET6)
@@ -956,10 +961,13 @@=

     }
     if (openvpn_bind(sd, cur->ai_addr, cur->ai_addrlen))
     {
- =
       msg(M_FATAL | M_ERRNO, "%s: Socket bind failed on local address %s",=
 prefix,
+        msg(msglevel | M_ERRNO, "%s: Socket bind failed on local =
address %s", prefix,
             print_sockaddr_ex(local->ai_addr, ":", PS=
_SHOW_PORT, &gc));
+        gc_free(&gc);
+        return false;
     }
   =
  gc_free(&gc);
+    return true;
 }
 
 int
diff --git a/src/openvpn/socket=
=2Eh b/src/openvpn/socket=2Eh
index 46fa29c=2E=2E4db3f3b 100644
--- a/src/o=
penvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -348,8 +348,15 @@
 
 stru=
ct link_socket *link_socket_new(void);
 
-void socket_bind(socket_descripto=
r_t sd, struct addrinfo *local, int af_family, const char *prefix,
-       =
          bool ipv6only);
+/**
+ * Bind \p sd to the first \p af_family add=
ress of \p local=2E A failure is
+ * reported at \p msglevel, so a caller t=
hat can do without the bind passes a
+ * non-fatal level and checks the res=
ult=2E
+ *
+ * @return whether the socket was bound
+ */
+bool socket_bind(=
socket_descriptor_t sd, struct addrinfo *local, int af_family, const char *=
prefix,
+                 bool ipv6only, msglvl_t msglevel);
 
 int openvpn=
_connect(socket_descriptor_t sd, const struct sockaddr *remote, int connect=
_timeout,
                     volatile int *signal_received);
@@ -402,12 +=
409,12 @@
 socket_descriptor_t create_socket_tcp(struct addrinfo *);
 
 /**=

- * Create a UDP socket for @p af set up the way a link socket is: --sndbu=
f/--rcvbuf,
- * --mark, --bind-dev and, when @p bind_addr is given, the loc=
al bind (IPV6_V6ONLY
- * per @p bind_ipv6_only)=2E Shared by create_socket(=
) and the --server-probe sockets,
- * so a probe socket is the connection s=
ocket it may become=2E A failed bind is
- * fatal; with @p optional a socke=
t the host cannot create is not, so
- * --server-probe can skip that addres=
s family (SOCKET_UNDEFINED is returned)=2E
+ * Create a UDP socket for \p a=
f set up the way a link socket is: --sndbuf/--rcvbuf,
+ * --mark, --bind-de=
v and, when \p bind_addr is given, the local bind (IPV6_V6ONLY
+ * per \p b=
ind_ipv6_only)=2E Shared by create_socket() and the --server-probe sockets,=

+ * so a probe socket is the connection socket it may become=2E With \p op=
tional a
+ * socket the host cannot create or bind is not fatal, so --serve=
r-probe can skip
+ * that address family (SOCKET_UNDEFINED is returned)=2E
=
  */
 socket_descriptor_t create_socket_udp_configured(sa_family_t af, unsi=
gned int sockflags,
                                                  const=
 struct socket_buffer_size *sbs, int mark,

-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
Gerrit-=
Change-Number: 1915
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>

--pZV+agvBRkI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1915?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">socket: l=
et an optional UDP socket give up on a failed bind<br><br>create_socket_udp=
_configured()&#39;s &quot;optional&quot; argument covers only the<br>socket=
() call: socket_bind() is fatal, so a caller that can do without<br>the soc=
ket still dies if the address is unavailable=2E<br><br>That is a problem fo=
r --server-probe, which binds a probe socket for<br>every address family in=
 use, while a connection binds only the family of<br>the remote it is about=
 to try=2E A --lport whose IPv6 port happens to be<br>taken by another proc=
ess therefore kills a client that would have<br>connected over IPv4=2E<br><=
br>Give socket_bind() a msglevel and a return value, and let &quot;optional=
&quot;<br>apply to the bind as well: the socket is closed and SOCKET_UNDEFI=
NED is<br>returned, so the caller can skip that address family=2E Every exi=
sting<br>caller passes M_FATAL and keeps its behaviour=2E<br><br>Change-Id:=
 I24e5925a72aaede53ef9e863fe96fcd7363df402<br>Signed-off-by: Lev Stipakov &=
lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/manage=2Ec<br>M src/openvp=
n/socket=2Ec<br>M src/openvpn/socket=2Eh<br>3 files changed, 32 insertions(=
+), 17 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/15/1915/2</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index e121b38=2E=
=2E46b0abe 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><s=
pan>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -2044,7 +2044,7 @@</spa=
n><br><span>         {</span><br><span>             man-&gt;connection=2Esd=
_top =3D create_socket_tcp(man-&gt;settings=2Elocal);</span><br><span>     =
        socket_bind(man-&gt;connection=2Esd_top, man-&gt;settings=2Elocal, =
man-&gt;settings=2Elocal-&gt;ai_family,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                        &quot;MANAGEMENT&quot;, false);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   &quot;MANAGEMENT&quot;, false, M_FATAL);</span><br><span>         }</spa=
n><br><span> </span><br><span>         /*</span><br><span>diff --git a/src/=
openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 41c8bac=
=2E=2E4c0aab5 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br=
><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -627,12 +627,13 @@</=
span><br><span>     {</span><br><span>         if (sock-&gt;socks_proxy &am=
p;&amp; sock-&gt;info=2Eproto =3D=3D PROTO_UDP)</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            socket_bin=
d(sock-&gt;ctrl_sd, sock-&gt;info=2Elsa-&gt;bind_local, sock-&gt;info=2Eaf,=
 &quot;SOCKS&quot;, false);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            socket_bind(sock-&gt;ctrl_sd, sock-&gt;info=2Elsa-&gt;b=
ind_local, sock-&gt;info=2Eaf, &quot;SOCKS&quot;, false,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                        M_FATAL);</spa=
n><br><span>         }</span><br><span>         else</span><br><span>      =
   {</span><br><span>             socket_bind(sock-&gt;sd, sock-&gt;info=2E=
lsa-&gt;bind_local, sock-&gt;info=2Eaf, &quot;TCP/UDP&quot;,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                        sock-&gt;inf=
o=2Ebind_ipv6_only);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        sock-&gt;info=2Ebind_ipv6_only, M_FATAL);</span><b=
r><span>         }</span><br><span>     }</span><br><span> }</span><br><spa=
n>@@ -678,9 +679,11 @@</span><br><span>     }</span><br><span> </span><br><=
span>     socket_apply_options(sd, sbs, mark, bind_dev);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (bind_addr)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (bind_addr</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !socket_bind(sd, bind_=
addr, af, &quot;TCP/UDP&quot;, bind_ipv6_only, optional ? D_LOW : M_FATAL))=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        socket_bind(sd, bind_addr, af, &quot;TCP/UDP&quot;, bind_ipv6_onl=
y);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        openvpn_=
close_socket(sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return SOCKET_UNDEFINED;</span><br><span>     }</span><br><span>     =
return sd;</span><br><span> }</span><br><span>@@ -914,9 +917,9 @@</span><br=
><span>     return new_sd;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool</span><br><span> socket_bind(socket_descrip=
tor_t sd, struct addrinfo *local, int ai_family, const char *prefix,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            bool ipv6only)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            bool ipv6=
only, msglvl_t msglevel)</span><br><span> {</span><br><span>     struct gc_=
arena gc =3D gc_new();</span><br><span> </span><br><span>@@ -940,8 +943,10 =
@@</span><br><span>     }</span><br><span>     if (!cur)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FAT=
AL, &quot;%s: Socket bind failed: Addr to bind has no %s record&quot;, pref=
ix,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msgl=
evel, &quot;%s: Socket bind failed: Addr to bind has no %s record&quot;, pr=
efix,</span><br><span>             addr_family_name(ai_family));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</s=
pan><br><span>     }</span><br><span> </span><br><span>     if (ai_family =
=3D=3D AF_INET6)</span><br><span>@@ -956,10 +961,13 @@</span><br><span>    =
 }</span><br><span>     if (openvpn_bind(sd, cur-&gt;ai_addr, cur-&gt;ai_ad=
drlen))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(M_FATAL | M_ERRNO, &quot;%s: Socket bind failed on loc=
al address %s&quot;, prefix,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(msglevel | M_ERRNO, &quot;%s: Socket bind failed on lo=
cal address %s&quot;, prefix,</span><br><span>             print_sockaddr_e=
x(local-&gt;ai_addr, &quot;:&quot;, PS_SHOW_PORT, &amp;gc));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span>=
<br><span>     }</span><br><span>     gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span> }</sp=
an><br><span> </span><br><span> int</span><br><span>diff --git a/src/openvp=
n/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 46fa29c=2E=2E4d=
b3f3b 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span>+=
++ b/src/openvpn/socket=2Eh</span><br><span>@@ -348,8 +348,15 @@</span><br>=
<span> </span><br><span> struct link_socket *link_socket_new(void);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void socket=
_bind(socket_descriptor_t sd, struct addrinfo *local, int af_family, const =
char *prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
         bool ipv6only);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Bind \p =
sd to the first \p af_family address of \p local=2E A failure is</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * reported at \p msglevel, so=
 a caller that can do without the bind passes a</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * non-fatal level and checks the result=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @return whether the socket was bound<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool socket_bind(socket_descriptor_t=
 sd, struct addrinfo *local, int af_family, const char *prefix,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                 bool ipv6only,=
 msglvl_t msglevel);</span><br><span> </span><br><span> int openvpn_connect=
(socket_descriptor_t sd, const struct sockaddr *remote, int connect_timeout=
,</span><br><span>                     volatile int *signal_received);</spa=
n><br><span>@@ -402,12 +409,12 @@</span><br><span> socket_descriptor_t crea=
te_socket_tcp(struct addrinfo *);</span><br><span> </span><br><span> /**</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * Create a UDP socket f=
or @p af set up the way a link socket is: --sndbuf/--rcvbuf,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * --mark, --bind-dev and, when @p b=
ind_addr is given, the local bind (IPV6_V6ONLY</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * per @p bind_ipv6_only)=2E Shared by create_sock=
et() and the --server-probe sockets,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * so a probe socket is the connection socket it may become=
=2E A failed bind is</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* fatal; with @p optional a socket the host cannot create is not, so</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * --server-probe can skip t=
hat address family (SOCKET_UNDEFINED is returned)=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Create a UDP socket for \p af set up t=
he way a link socket is: --sndbuf/--rcvbuf,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * --mark, --bind-dev and, when \p bind_addr is giv=
en, the local bind (IPV6_V6ONLY</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * per \p bind_ipv6_only)=2E Shared by create_socket() and the =
--server-probe sockets,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * so a probe socket is the connection socket it may become=2E With \p =
optional a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * socket=
 the host cannot create or bind is not fatal, so --server-probe can skip</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * that address family=
 (SOCKET_UNDEFINED is returned)=2E</span><br><span>  */</span><br><span> so=
cket_descriptor_t create_socket_udp_configured(sa_family_t af, unsigned int=
 sockflags,</span><br><span>                                               =
   const struct socket_buffer_size *sbs, int mark,</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1915?usp=3Demail">change 1915</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1915?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1915 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body=
></html>
--pZV+agvBRkI=--


--===============1759791306910763250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1759791306910763250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1759791306910763250==--

