Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73657606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=V6Nk63uZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PTA7u75f;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hTYrVIQ+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dBgmbRLw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Fm4/VS8OXP7Mp8SXaPjtj9ORNEboEt6+zPJ39qcofp8=; b=V6Nk63uZyYeUZ9WYPwqUihxH/Q
	QqIJ0TOci5aJeuHUBFD0vWkHih+/4musqGvDnn2OU9DnvjOjRCUUqkeiEG9ZgfcpAmOFus1WDf8gr
	ru35JRim7d+j8pEF7QZqkY5qtYjDMd4QyCi6Fwd+IsCIz6WKO0qAdrjJHdXxXDVkrCbk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVscS-0000000065F-0aBq;
	Tue, 24 Nov 2026 15:39:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVscR-00000000658-1CMr
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 15:39:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/agB90N82mckUoItNfKjb8WQVIbD00N8hT+vgxkvaD8=; b=PTA7u75fubyH5Pz7YddYlOhsqt
 D5lZj8IFLdQXahCW8dn2B6Cx1VTDfBGQsfAGfSGHXMkrqxn6xj/n4FClH/0pYoEiRBQ0qI/jFFIu9
 mF5036dHqNKQi7Y1P2Ged/yD7WkBLpRzofD32bbq0qZLoNMfl9xoD2UimRQ2g+770YYg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/agB90N82mckUoItNfKjb8WQVIbD00N8hT+vgxkvaD8=; b=hTYrVIQ+v4Twnw3Tdne6E7hzZO
 tHiK5yhzRosGUwhRiFPbjS0ZMdXXuJXSGmopY/IdvOYB1pQT4/n0phCp72EG7mdmcKooD+Dm0S/gR
 2yYbE/RRej/xobm6GRhyOhCvOA1F+XRzY13+bmFkGOF/VMDIa6ZjoOdl6cpMJH3NRgmc=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVscP-000000005Xv-0Lp7 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 15:39:43 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bb85e07aadso57150395e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 07:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795534774; x=1796139574; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/agB90N82mckUoItNfKjb8WQVIbD00N8hT+vgxkvaD8=;
 b=dBgmbRLwtyhMvvGstFqOGSt2UPcxvvPbkB7xNtzam+noupxqJoRvLUXIYdathwiL7m
 iHEn+3jG2SgkMFAM2FLlkX4fr5EWOvZszDLRogRheQjEecw7bw6dXkAksfdcQFBPIOeC
 UEobGTnMpE8k6UgyCkzELJPWM2dsF1obg6UD0J/xpO/kvyxb5tM4SsNgv38QtGcWk4dn
 fg4vLTt2CczXLZp0lkKU872zROqpUtGulX/Pkmnrtg2AgY9m8lw72faXUCPMe5jCEhU+
 2o7szoMot+owp6R3TWAPFWIkfElI+hcG8JDLf1Sr4HjY+pHpS7oRg8vNBkjtOVBm/BHz
 tenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795534774; x=1796139574;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/agB90N82mckUoItNfKjb8WQVIbD00N8hT+vgxkvaD8=;
 b=W/u5Me6uPQRr0K+xmi6qVPeydoaVtVVLkUjFe4fPAeLnOKOu41exmB4Ac8n5//n4u6
 7kBcTb4P9c3wfoeEC8pf52+C2//sRaKhm3Z8klMXpULGP/ksn0GQqqHEStIpTDYSXIuX
 c+pfPa5zg6FVMxjiILWUUgUt0+Gmhz5eDg4akhApGy9DzyBfYIwX04rOr84u+/gFGli1
 FLsNe7faxYDhuyLgYkvFvf7W49BrV/ajbM+cnub691W7tjoKuFyEDQ1TaNOheDgz97nB
 IuBP40xbZIgJ2OpMIEKKEzZ2xrkrzP1nXTBb3npKFe8360/z0j9VBRPWddp3759p5OYr
 dWFw==
X-Gm-Message-State: APuU4Z9X5YXM8qtM3XpwUDKbATlbR4zRgWimQwuFy6ZGGZNPoGjesKQ4
 YA5Shd0qXBRCELcJ0SRzJNsHB1lQuetvDG7UOUvizn7m4Aqddb9O1Lztw08rIJOJHX14V9Bh92f
 OoVoS5xEy/G1EV3Yx+q/AwlcBynB++nFK470vGTwnRlA+uDc3kj++zx7luruOLaBkMTZN
X-Gm-Gg: AZFdTZdxj5utnta8EcBUDTa6oPt26ZnepbaeN/jRo9sFhvHFQmcO/2YPFQsePdo1RtI
 CI+gno1IJMXTWdAlJ397F/gt5dqdtaFvm3jFKyFEm/aESZB7y0cKtYTtXKLO6qZrrUqOKGvVoMC
 PkCpi2Kk5r8jziB9m2iNIZiRkk94szOc4di++ykh7+UcpdvKWiGixAPDBSLuJJgH7mgNZhD1ehB
 SNh0Iu1LTnZyagsSPwuYsOAWwumnOVkM4RNtRpl7JcOSfuT2ZhHHyBTQYAAs3K25iSCaV6sHwL8
 4LmueqCBkcrRX3RRA3pluSYOCZgjB+bi/aDQbb20nKaAoMzNFZnl+Sk04RcjdFzh2RJGC4b56vc
 +CmKYteMuyJQ2/SlYbyJILCbRLMDJYD/yuIy9IFVXBSM53W9P/J0d1RfV/g5Nl30S+sBWMSOeEN
 Fldc3hWEmix55gH1bhjWPraxif8ZBoBlYMMRncd5lH5XKDWEwNE7ptAaV0xc2Jl+57jXPwEJP7i
 hySGsWb0WHN+4wNqa0eSpJ8LRWIzkVC0zG17LuPBJMAMeBr/r+/Fi81T/BHv50ZdkZ8D4K4ZhKg
 vb+31jMhNeQd9Dr0OUGoXf80NhBkklqH5ypv29hAf/VRza6S919K4BZ6sEcexCWyx26bvbd87wr
 mKHiNVO8oqn7Zl+AfH1qlf65ioObzwMyw0qe3IJQrBYsAXXOJm33k1m0M7KG0mqrRtbrPMzRNgn
 GWVZDQ3k4JszHiE2I+9X5XrCpHW5wS4cCII7g2
X-Received: by 2002:a05:600c:8b83:b0:4a3:59c9:a747 with SMTP id
 5b1f17b1804b1-4bb8880642cmr289260285e9.17.1795534774216; 
 Tue, 24 Nov 2026 07:39:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853ca452sm434413635e9.15.2026.11.24.07.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 07:39:33 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 15:39:32 +0000
To: Ralf Lici <ralf@mandelbit.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
X-Gerrit-Change-Number: 1915
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1915?usp=email>
X-Gerrit-Commit: ccd026cbe43b2526a79ee823cd93672b5a74a1d0
In-Reply-To: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
References: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5Mzk1NTEyMDAwLkkyNGU1OTI1YTcyYWFlZGU1M2VmOWU4NjNmZTk2ZmNkNzM2M2RmNDAyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fe3473c1217d0a791a4963de2bd5c54d9252ad36-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVscP-000000005Xv-0Lp7
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: Let an
 optional UDP socket give up on a failed bind
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6834744600700045933=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6834744600700045933==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tR5ygzDD2PY="; charset=UTF-8

--tR5ygzDD2PY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Lev Stipakov, Ralf Lici=
, R=C4=83zvan Cojocaru=2E

Hello Arne Schwabe, Ralf Lici, R=C4=83zvan Cojoc=
aru, 

I'd like you to reexamine a change=2E Please visit

    https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail

to look at the new patch s=
et (#13)=2E

The following approvals got outdated and were removed:
Code-Re=
view+1 by Ralf Lici, Code-Review+2 by R=C4=83zvan Cojocaru

The change is n=
o longer submittable: Code-Review and checks~ChecksSubmitRule are unsatisfi=
ed now=2E


Change subject: socket: Let an optional UDP socket give up on a=
 failed bind
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


socket: Let an optional UDP socket give up on a failed bind

create_socke=
t_udp_configured()'s "optional" argument covers only the
socket() call: soc=
ket_bind() is fatal, so a caller that can do without
the socket still dies =
if the address is unavailable=2E

That is a problem for the upcoming --serv=
er-probe, which binds a probe
socket for every address family in use, while=
 a connection binds only
the family of the remote it is about to try=2E A -=
-lport whose IPv6 port
happens to be taken by another process would therefo=
re kill a client
that could have connected over IPv4=2E

Give socket_bind()=
 a msglevel and a return value, and let "optional"
apply to the bind as wel=
l: the socket is closed and SOCKET_UNDEFINED is
returned, so the caller can=
 skip that address family=2E Every existing
caller passes M_FATAL and keeps=
 its behaviour=2E With more than one return
path the gc arena no longer bel=
ongs at the top of the function, so it
moves into the bind failure, the onl=
y branch that formats an address=2E

The failure message now reports the ad=
dress that was actually bound,
cur, rather than the head of the list, local=
, which may belong to a
different address family=2E Until now that message =
was always followed by
a fatal exit; with an optional bind it is printed wh=
ile the client
carries on, so it needs to name the right address=2E

Change=
-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
Signed-off-by: Lev Stipakov =
<lev@openvpn=2Enet>
---
M src/openvpn/manage=2Ec
M src/openvpn/socket=2Ec
M=
 src/openvpn/socket=2Eh
3 files changed, 30 insertions(+), 18 deletions(-)
=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/15/191=
5/13

diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index ad=
dd6f2=2E=2Ebbf454a 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/ma=
nage=2Ec
@@ -2080,7 +2080,7 @@
         {
             man->connection=2Esd=
_top =3D create_socket_tcp(man->settings=2Elocal);
             socket_bind=
(man->connection=2Esd_top, man->settings=2Elocal, man->settings=2Elocal->ai=
_family,
-                        "MANAGEMENT", false);
+                  =
      "MANAGEMENT", false, M_FATAL);
         }
 
         /*
diff --git a/=
src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index c07ef60=2E=2E36cb0e5 =
100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -268,12=
 +268,13 @@
     {
         if (sock->socks_proxy && sock->info=2Eproto =3D=
=3D PROTO_UDP)
         {
-            socket_bind(sock->ctrl_sd, sock->inf=
o=2Elsa->bind_local, sock->info=2Eaf, "SOCKS", false);
+            socket_=
bind(sock->ctrl_sd, sock->info=2Elsa->bind_local, sock->info=2Eaf, "SOCKS",=
 false,
+                        M_FATAL);
         }
         else
       =
  {
             socket_bind(sock->sd, sock->info=2Elsa->bind_local, sock->=
info=2Eaf, "TCP/UDP",
-                        sock->info=2Ebind_ipv6_only)=
;
+                        sock->info=2Ebind_ipv6_only, M_FATAL);
         =
}
     }
 }
@@ -319,9 +320,11 @@
     }
 
     socket_apply_options(sd, sbs=
, mark, bind_dev);
-    if (bind_addr)
+    if (bind_addr
+        && !sock=
et_bind(sd, bind_addr, af, "TCP/UDP", bind_ipv6_only, optional ? D_LOW : M_=
FATAL))
     {
-        socket_bind(sd, bind_addr, af, "TCP/UDP", bind_ipv6=
_only);
+        openvpn_close_socket(sd);
+        return SOCKET_UNDEFINED=
;
     }
     return sd;
 }
@@ -558,12 +561,10 @@
     return new_sd;
 }
 
=
-void
+bool
 socket_bind(socket_descriptor_t sd, const struct addrinfo *loc=
al, int ai_family,
-            const char *prefix, bool ipv6only)
+       =
     const char *prefix, bool ipv6only, msglvl_t msglevel)
 {
-    struct g=
c_arena gc =3D gc_new();
-
     /* FIXME (schwabe)
      * getaddrinfo for =
the bind address might return multiple AF_INET/AF_INET6
      * entries for=
 the requested protocol=2E
@@ -584,8 +585,9 @@
     }
     if (!cur)
     {=

-        msg(M_FATAL, "%s: Socket bind failed: Addr to bind has no %s reco=
rd", prefix,
+        msg(msglevel, "%s: Socket bind failed: Addr to bind h=
as no %s record", prefix,
             addr_family_name(ai_family));
+     =
   return false;
     }
 
     if (ai_family =3D=3D AF_INET6)
@@ -600,10 +6=
02,13 @@
     }
     if (openvpn_bind(sd, cur->ai_addr, cur->ai_addrlen))
 =
    {
-        msg(M_FATAL | M_ERRNO, "%s: Socket bind failed on local addr=
ess %s", prefix,
-            print_sockaddr_ex(local->ai_addr, ":", PS_SHO=
W_PORT, &gc));
+        struct gc_arena gc =3D gc_new();
+        msg(msgle=
vel | M_ERRNO, "%s: Socket bind failed on local address %s", prefix,
+     =
       print_sockaddr_ex(cur->ai_addr, ":", PS_SHOW_PORT, &gc));
+        g=
c_free(&gc);
+        return false;
     }
-    gc_free(&gc);
+    return t=
rue;
 }
 
 int
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh=

index 2210bfe=2E=2E084b9cc 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/o=
penvpn/socket=2Eh
@@ -346,8 +346,15 @@
 
 struct link_socket *link_socket_n=
ew(void);
 
-void socket_bind(socket_descriptor_t sd, const struct addrinfo=
 *local, int af_family,
-                 const char *prefix, bool ipv6only=
);
+/**
+ * Bind @p sd to the first @p af_family address of @p local=2E A f=
ailure is
+ * reported at @p msglevel, so a caller that can do without the =
bind passes a
+ * non-fatal level and checks the result=2E
+ *
+ * @return =
whether the socket was bound
+ */
+bool socket_bind(socket_descriptor_t sd,=
 const struct addrinfo *local, int af_family,
+                 const char =
*prefix, bool ipv6only, msglvl_t msglevel);
 
 int openvpn_connect(socket_d=
escriptor_t sd, const struct sockaddr *remote, int connect_timeout,
       =
              volatile int *signal_received);
@@ -401,9 +408,9 @@
  * Creat=
e a UDP socket for @p af set up the way a link socket is: --sndbuf/--rcvbuf=
,
  * --mark, --bind-dev and, when @p bind_addr is given, the local bind (I=
PV6_V6ONLY
  * per @p bind_ipv6_only)=2E Shared by create_socket() and the =
--server-probe sockets,
- * so a probe socket is the connection socket it m=
ay become=2E A failed bind is
- * fatal; with @p optional a socket the host=
 cannot create is not, so
- * --server-probe can skip that address family (=
SOCKET_UNDEFINED is returned)=2E
+ * so a probe socket is the connection so=
cket it may become=2E With @p optional a
+ * socket the host cannot create =
or bind is not fatal, so --server-probe can skip
+ * that address family (S=
OCKET_UNDEFINED is returned)=2E
  */
 socket_descriptor_t create_socket_udp=
_configured(sa_family_t af, unsigned int sockflags,
                       =
                           const struct socket_buffer_size *sbs, int mark,
=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I24e5925a72aaed=
e53ef9e863fe96fcd7363df402
Gerrit-Change-Number: 1915
Gerrit-PatchSet: 13
G=
errit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ralf Lici <ralf@mandelbi=
t=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Lev Stipakov <lsti=
pakov@gmail=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--tR5ygzDD2PY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Lev Stipakov, Ralf Lici, R=C4=83zvan Co=
jocaru=2E </p>
<p>Lev Stipakov <strong>uploaded patch set #13</strong> to t=
his change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
915?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+1 by Ralf Lici, Code-Review+2 by R=C4=83zvan=
 Cojocaru</p><p>The change is no longer submittable: Code-Review and checks=
~ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">socket: Let an op=
tional UDP socket give up on a failed bind<br><br>create_socket_udp_configu=
red()&#39;s &quot;optional&quot; argument covers only the<br>socket() call:=
 socket_bind() is fatal, so a caller that can do without<br>the socket stil=
l dies if the address is unavailable=2E<br><br>That is a problem for the up=
coming --server-probe, which binds a probe<br>socket for every address fami=
ly in use, while a connection binds only<br>the family of the remote it is =
about to try=2E A --lport whose IPv6 port<br>happens to be taken by another=
 process would therefore kill a client<br>that could have connected over IP=
v4=2E<br><br>Give socket_bind() a msglevel and a return value, and let &quo=
t;optional&quot;<br>apply to the bind as well: the socket is closed and SOC=
KET_UNDEFINED is<br>returned, so the caller can skip that address family=2E=
 Every existing<br>caller passes M_FATAL and keeps its behaviour=2E With mo=
re than one return<br>path the gc arena no longer belongs at the top of the=
 function, so it<br>moves into the bind failure, the only branch that forma=
ts an address=2E<br><br>The failure message now reports the address that wa=
s actually bound,<br>cur, rather than the head of the list, local, which ma=
y belong to a<br>different address family=2E Until now that message was alw=
ays followed by<br>a fatal exit; with an optional bind it is printed while =
the client<br>carries on, so it needs to name the right address=2E<br><br>C=
hange-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402<br>Signed-off-by: Lev S=
tipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/manage=2Ec<br>M s=
rc/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>3 files changed, 30 in=
sertions(+), 18 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/15/1915/13</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index ad=
dd6f2=2E=2Ebbf454a 100644</span><br><span>--- a/src/openvpn/manage=2Ec</spa=
n><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -2080,7 +2080,7=
 @@</span><br><span>         {</span><br><span>             man-&gt;connect=
ion=2Esd_top =3D create_socket_tcp(man-&gt;settings=2Elocal);</span><br><sp=
an>             socket_bind(man-&gt;connection=2Esd_top, man-&gt;settings=
=2Elocal, man-&gt;settings=2Elocal-&gt;ai_family,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                        &quot;MANAGEMENT&quot;,=
 false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             &quot;MANAGEMENT&quot;, false, M_FATAL);</span><br><span>     =
    }</span><br><span> </span><br><span>         /*</span><br><span>diff --=
git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index=
 c07ef60=2E=2E36cb0e5 100644</span><br><span>--- a/src/openvpn/socket=2Ec</=
span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -268,12 +268=
,13 @@</span><br><span>     {</span><br><span>         if (sock-&gt;socks_p=
roxy &amp;&amp; sock-&gt;info=2Eproto =3D=3D PROTO_UDP)</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            so=
cket_bind(sock-&gt;ctrl_sd, sock-&gt;info=2Elsa-&gt;bind_local, sock-&gt;in=
fo=2Eaf, &quot;SOCKS&quot;, false);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            socket_bind(sock-&gt;ctrl_sd, sock-&gt;info=2El=
sa-&gt;bind_local, sock-&gt;info=2Eaf, &quot;SOCKS&quot;, false,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                        M_FATA=
L);</span><br><span>         }</span><br><span>         else</span><br><spa=
n>         {</span><br><span>             socket_bind(sock-&gt;sd, sock-&gt=
;info=2Elsa-&gt;bind_local, sock-&gt;info=2Eaf, &quot;TCP/UDP&quot;,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        sock=
-&gt;info=2Ebind_ipv6_only);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        sock-&gt;info=2Ebind_ipv6_only, M_FATAL);<=
/span><br><span>         }</span><br><span>     }</span><br><span> }</span>=
<br><span>@@ -319,9 +320,11 @@</span><br><span>     }</span><br><span> </sp=
an><br><span>     socket_apply_options(sd, sbs, mark, bind_dev);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (bind_addr)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (bind_addr</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !socket_bind(sd,=
 bind_addr, af, &quot;TCP/UDP&quot;, bind_ipv6_only, optional ? D_LOW : M_F=
ATAL))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        socket_bind(sd, bind_addr, af, &quot;TCP/UDP&quot;, bind_ip=
v6_only);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        op=
envpn_close_socket(sd);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return SOCKET_UNDEFINED;</span><br><span>     }</span><br><span=
>     return sd;</span><br><span> }</span><br><span>@@ -558,12 +561,10 @@</=
span><br><span>     return new_sd;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span> socket_bind(socket=
_descriptor_t sd, const struct addrinfo *local, int ai_family,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            const char *prefix, bo=
ol ipv6only)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     const char *prefix, bool ipv6only, msglvl_t msglevel)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena=
 gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span>     /* FIXME (schwabe)</span><br><span>      * getaddrinfo fo=
r the bind address might return multiple AF_INET/AF_INET6</span><br><span> =
     * entries for the requested protocol=2E</span><br><span>@@ -584,8 +585=
,9 @@</span><br><span>     }</span><br><span>     if (!cur)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_=
FATAL, &quot;%s: Socket bind failed: Addr to bind has no %s record&quot;, p=
refix,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(m=
sglevel, &quot;%s: Socket bind failed: Addr to bind has no %s record&quot;,=
 prefix,</span><br><span>             addr_family_name(ai_family));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span=
><br><span>     }</span><br><span> </span><br><span>     if (ai_family =3D=
=3D AF_INET6)</span><br><span>@@ -600,10 +602,13 @@</span><br><span>     }<=
/span><br><span>     if (openvpn_bind(sd, cur-&gt;ai_addr, cur-&gt;ai_addrl=
en))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        msg(M_FATAL | M_ERRNO, &quot;%s: Socket bind failed on local =
address %s&quot;, prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            print_sockaddr_ex(local-&gt;ai_addr, &quot;:&quot;, PS_SHOW=
_PORT, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        msg(msglevel | M_ERRNO, &quot;%s: Socket bind fa=
iled on local address %s&quot;, prefix,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            print_sockaddr_ex(cur-&gt;ai_addr, &quot;:&=
quot;, PS_SHOW_PORT, &amp;gc));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        return false;</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span=
> }</span><br><span> </span><br><span> int</span><br><span>diff --git a/src=
/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 2210bfe=
=2E=2E084b9cc 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br=
><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -346,8 +346,15 @@</s=
pan><br><span> </span><br><span> struct link_socket *link_socket_new(void);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-voi=
d socket_bind(socket_descriptor_t sd, const struct addrinfo *local, int af_=
family,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
   const char *prefix, bool ipv6only);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Bind @p sd to the first @p af_family address of @p local=2E A failure=
 is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reported at @=
p msglevel, so a caller that can do without the bind passes a</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * non-fatal level and checks the=
 result=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return whether the soc=
ket was bound</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+bool socket_bind(socke=
t_descriptor_t sd, const struct addrinfo *local, int af_family,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                 const char *pr=
efix, bool ipv6only, msglvl_t msglevel);</span><br><span> </span><br><span>=
 int openvpn_connect(socket_descriptor_t sd, const struct sockaddr *remote,=
 int connect_timeout,</span><br><span>                     volatile int *si=
gnal_received);</span><br><span>@@ -401,9 +408,9 @@</span><br><span>  * Cre=
ate a UDP socket for @p af set up the way a link socket is: --sndbuf/--rcvb=
uf,</span><br><span>  * --mark, --bind-dev and, when @p bind_addr is given,=
 the local bind (IPV6_V6ONLY</span><br><span>  * per @p bind_ipv6_only)=2E =
Shared by create_socket() and the --server-probe sockets,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * so a probe socket is the connection =
socket it may become=2E A failed bind is</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * fatal; with @p optional a socket the host cannot crea=
te is not, so</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --ser=
ver-probe can skip that address family (SOCKET_UNDEFINED is returned)=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * so a probe socket i=
s the connection socket it may become=2E With @p optional a</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * socket the host cannot create or=
 bind is not fatal, so --server-probe can skip</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * that address family (SOCKET_UNDEFINED is retu=
rned)=2E</span><br><span>  */</span><br><span> socket_descriptor_t create_s=
ocket_udp_configured(sa_family_t af, unsigned int sockflags,</span><br><spa=
n>                                                  const struct socket_buf=
fer_size *sbs, int mark,</span><br></pre><p>To view, visit <a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail">change 1915</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I24e5=
925a72aaede53ef9e863fe96fcd7363df402 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1915 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;ls=
tipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Lev Stipakov &lt;lstipa=
kov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>

</body></html>
--tR5ygzDD2PY=--


--===============6834744600700045933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6834744600700045933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6834744600700045933==--

