Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B1D606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Q+YT8Fwv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LaWtg+F4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VvoNm45l;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Q4fIkaX2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=q7zmLWcrRvdxcfzGnuAsaXgLxo84f1WbX6V5C0mjKkY=; b=Q+YT8FwvjrblZIaSyQB23E/R9W
	xMZZJvtVt/liUBue2H2XycQvJyNkN1F4b/WutGcdXT2oi2zYo8OKG/zUbpFQr/GfAKmvAJG3pMe3G
	T4lb4mhODdDJ+VHM9ms664+xLZvZ35E6s81JiEeuVvHvZ5+I5ylDIXDiHplO4HC17Z2A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOcrx-000000003o4-3rJS;
	Wed, 04 Nov 2026 15:25:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOcrw-000000003nw-0TCS
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:25:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ouOPtJlJti5Tjja4YI236UFz73UVqQ+CeVnhhoMbLQI=; b=LaWtg+F4nxcUwlXzjLAFMGFklK
 8yWcqw8pnCTgpb5xHQz1GaVFFmRjo5LGSQivFJ8OBo6fdNsLIC1tOq4EkuY7mQFCPrpgpw7OPYFOB
 klTz6Y/SwQzUhGzD0tFsiJUn/8HdQ/u9JBKLfkBtSavD+l6+LI+QcV15z0lToVog1eqY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ouOPtJlJti5Tjja4YI236UFz73UVqQ+CeVnhhoMbLQI=; b=VvoNm45lmqpfnqBPyY99qlcRdq
 vHOlUJVP5KU9Yic1IJwk68lt+U6IsK/G2KA4VCQZxt8L5qcR0lKa6eIhC3lx/WuGHsfemOUnXQuyg
 RjpSEKTtrqREDaLtOb+KOrR/aN77I6rTRfP020SXsR92ED304TkQGwVlCx/pkMtYaI+4=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOcrt-000000004Wr-1Exg for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:25:44 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a4dc547987so4574715e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 07:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793805935; x=1794410735; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ouOPtJlJti5Tjja4YI236UFz73UVqQ+CeVnhhoMbLQI=;
 b=Q4fIkaX2dD7OuyIn/hFgt+hjdFMLv0D0XdorGXnArmMcjNs874HuOArPytZAxQ2JEn
 qeEU2XCk5vnVdeI1f4YmvijHqjBkex0G4IBP2l5OclZGNm63RRIUfNVj+Wv3bNKc6xPm
 U64iGdweek7KnMTc1DVrMOBh+QyusL35Fd3MBCRGYAiOmUL0r9Q5RaLGLalq8VxFnMZf
 werlAPorpx/uB6ojPqETRVWHm93E9hysL+gE1gf8ALk8G5sgPeUG1v/1e/zVKc1MMk2V
 Suopd3cj3puZpgnjZQs7P2KD8JBQUfUJPYbY9JOVlKG8jUsVtYVe865d8pboHFAcFj6T
 p9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793805935; x=1794410735;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ouOPtJlJti5Tjja4YI236UFz73UVqQ+CeVnhhoMbLQI=;
 b=WWW+imN1C6SZU7+PY4iBeZNPoE1juW/+awRImJV+MWQaQ+8w5UXg7JvDaLBc7DWCKS
 n+48GLil++RHycdA10uZNjvUC08sTP5cDGivbPH6J9SRMG1gSAV+MRKuXrxjAF7wgOjT
 S3cdkeu40js3xB8zhyoRzUplCs4gVK/tbnW2Ma9Hw6U+sPnCEeFeMH5eU0Zy5Jseja7P
 T2VZrxNRNWHRrJfznhh89sAVRKwdfMNtyLHNXluTZDaj1rgpcRoNbLezuW9uBYm+Xqvt
 623u0hX3vKfUhdyiXdFzHLUSQ34Y7SMbi+8oxjrTXHCMH6Ovp00gJxrgCI1QjFWovMQh
 ngPg==
X-Gm-Message-State: APuU4Z/AKIBYrKAMv18LaIJFZh4RSczJscC+uPioy31zyFUPb4WDFk0l
 E0gUwkP2VHQV300WdC4eUHOYfiTMPQ52ceKCTwrQsn2tnBb0GmuJAjoGvjgWHfj9G8xxt50x1jF
 Bl3JVYDPqKyd5l5SEhDLR+roEKsq/UdI9B+yuhBfSmhN3ZaiO2s/pZ3uF/wpE+Djy3eEZ27H2pr
 fni43zrw==
X-Gm-Gg: AYBFou0w49dNHFb+AtBOorfZTrRnHEva9Ukc4yihP2wbEpvMKzz0sVc07i6lCJm0EXe
 jk7qTZiaFBX43AOj04YDqJHatxHsW8EjSFxG+h5sK4MqUEH3ILHlGpyLcihrjc654AX+PTCZYv9
 eG9oowdeUKvMfMHnNnZ4+JxaD/MVCiGICUat/kd93isq8u1LulwdwZjFj0ALi0o3G0w/3HedDrh
 mvccmlgKWdHy2CUanWnf8JWD7Fe1WMWshWFWipp7TCC3GA+TD0BpLDrb4ARk8W/SHFNIyrD2wUE
 11CnhIy1cD/kD6vGaK85bQnBCBW6IUOKMeS89BdPyA/ZobHf8NDtbJCYkYrC1revuC7Oj5ze1N7
 ueURRDIf6U0wJEjOjJ8az4b55lVFkd1nPQAmre/wlCH0x6U8dL/lL3cluLoqHfhcmPSc44WNm+g
 IoPYeAeWcdjvfaHR+xdrE5NMIkLzwLpGUYM+8PbVChjZKbWcseegfb9z+lPAjUqt/yRqeoRlUf8
 OGLFeW58SC1yj4Vh67sFON4We3YCyWdbwExyMkaRRzm0GFS1T2gjW7d+NxSk4YK7tbrEksAfPTf
 UcBtF1qtIQKZ764dBlm9mdN8LJCn0U5mn90qLSrVtgvOFPanwBWLZW+0n0R6+GcJK/48CvFR57o
 r+6/nlQNYtoLI+N48sma4MVFVsDf7gfhyFCmsvzQsajDS6fO6O7ZbrMBwVOdDoXBItpIO/Fh6oC
 ZD+AkZxYk09/xfn/Ejy+bY1yXMkaImjkBehZ8=
X-Received: by 2002:a05:600c:19d2:b0:4a6:4d6b:a840 with SMTP id
 5b1f17b1804b1-4ac1932a12fmr372073905e9.31.1793805934316; 
 Wed, 04 Nov 2026 07:25:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43da9825bsm61464885e9.15.2026.11.04.07.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 07:25:33 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 15:25:30 +0000
To: Ralf Lici <ralf@mandelbit.com>,
	Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
X-Gerrit-Change-Number: 1915
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1915?usp=email>
X-Gerrit-Commit: 07c096a514de967e7fda4329f129d42478f3ac58
In-Reply-To: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
References: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5Mzk1NTEyMDAwLkkyNGU1OTI1YTcyYWFlZGU1M2VmOWU4NjNmZTk2ZmNkNzM2M2RmNDAyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2f1fc2e17a96219ac085f1af254c101fa1387057-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOcrt-000000004Wr-1Exg
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
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, razvanc@mailbox.org, ralf@mandelbit.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1317122437004038343=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1317122437004038343==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s9ysT5uvD2U="; charset=UTF-8

--s9ysT5uvD2U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Ralf Lici, R=C4=83zvan =
Cojocaru=2E

Hello Arne Schwabe, Ralf Lici, 

I'd like you to reexamine a c=
hange=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?=
usp=3Demail

to look at the new patch set (#12)=2E


Change subject: socket=
: Let an optional UDP socket give up on a failed bind
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket: Let an optional UDP socket=
 give up on a failed bind

create_socket_udp_configured()'s "optional" argu=
ment covers only the
socket() call: socket_bind() is fatal, so a caller tha=
t can do without
the socket still dies if the address is unavailable=2E

Th=
at is a problem for the upcoming --server-probe, which binds a probe
socket=
 for every address family in use, while a connection binds only
the family =
of the remote it is about to try=2E A --lport whose IPv6 port
happens to be=
 taken by another process would therefore kill a client
that could have con=
nected over IPv4=2E

Give socket_bind() a msglevel and a return value, and =
let "optional"
apply to the bind as well: the socket is closed and SOCKET_U=
NDEFINED is
returned, so the caller can skip that address family=2E Every e=
xisting
caller passes M_FATAL and keeps its behaviour=2E

The failure messa=
ge now reports the address that was actually bound,
cur, rather than the he=
ad of the list, local, which may belong to a
different address family=2E Un=
til now that message was always followed by
a fatal exit; with an optional =
bind it is printed while the client
carries on, so it needs to name the rig=
ht address=2E

Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
Signed-=
off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/manage=2Ec
M src=
/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
3 files changed, 30 insertions=
(+), 15 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/15/1915/12

diff --git a/src/openvpn/manage=2Ec b/src/openvp=
n/manage=2Ec
index 58f63e6=2E=2E013d516 100644
--- a/src/openvpn/manage=2Ec=

+++ b/src/openvpn/manage=2Ec
@@ -2105,7 +2105,7 @@
         {
            =
 man->connection=2Esd_top =3D create_socket_tcp(man->settings=2Elocal);
   =
          socket_bind(man->connection=2Esd_top, man->settings=2Elocal, man-=
>settings=2Elocal->ai_family,
-                        "MANAGEMENT", false)=
;
+                        "MANAGEMENT", false, M_FATAL);
         }
 
    =
     /*
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index =
307b5c6=2E=2Ec7de904 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/=
socket=2Ec
@@ -268,12 +268,13 @@
     {
         if (sock->socks_proxy && s=
ock->info=2Eproto =3D=3D PROTO_UDP)
         {
-            socket_bind(soc=
k->ctrl_sd, sock->info=2Elsa->bind_local, sock->info=2Eaf, "SOCKS", false);=

+            socket_bind(sock->ctrl_sd, sock->info=2Elsa->bind_local, sock=
->info=2Eaf, "SOCKS", false,
+                        M_FATAL);
         }
=
         else
         {
             socket_bind(sock->sd, sock->info=2Els=
a->bind_local, sock->info=2Eaf, "TCP/UDP",
-                        sock->i=
nfo=2Ebind_ipv6_only);
+                        sock->info=2Ebind_ipv6_only=
, M_FATAL);
         }
     }
 }
@@ -319,9 +320,11 @@
     }
 
     socket_=
apply_options(sd, sbs, mark, bind_dev);
-    if (bind_addr)
+    if (bind_a=
ddr
+        && !socket_bind(sd, bind_addr, af, "TCP/UDP", bind_ipv6_only, =
optional ? D_LOW : M_FATAL))
     {
-        socket_bind(sd, bind_addr, af,=
 "TCP/UDP", bind_ipv6_only);
+        openvpn_close_socket(sd);
+        re=
turn SOCKET_UNDEFINED;
     }
     return sd;
 }
@@ -556,9 +559,9 @@
     r=
eturn new_sd;
 }
 
-void
+bool
 socket_bind(socket_descriptor_t sd, const s=
truct addrinfo *local, int ai_family,
-            const char *prefix, bool=
 ipv6only)
+            const char *prefix, bool ipv6only, msglvl_t msgleve=
l)
 {
     struct gc_arena gc =3D gc_new();
 
@@ -582,8 +585,10 @@
     }
 =
    if (!cur)
     {
-        msg(M_FATAL, "%s: Socket bind failed: Addr to=
 bind has no %s record", prefix,
+        msg(msglevel, "%s: Socket bind fa=
iled: Addr to bind has no %s record", prefix,
             addr_family_name=
(ai_family));
+        gc_free(&gc);
+        return false;
     }
 
     i=
f (ai_family =3D=3D AF_INET6)
@@ -598,10 +603,13 @@
     }
     if (openvpn=
_bind(sd, cur->ai_addr, cur->ai_addrlen))
     {
-        msg(M_FATAL | M_E=
RRNO, "%s: Socket bind failed on local address %s", prefix,
-            pr=
int_sockaddr_ex(local->ai_addr, ":", PS_SHOW_PORT, &gc));
+        msg(msgl=
evel | M_ERRNO, "%s: Socket bind failed on local address %s", prefix,
+    =
        print_sockaddr_ex(cur->ai_addr, ":", PS_SHOW_PORT, &gc));
+        =
gc_free(&gc);
+        return false;
     }
     gc_free(&gc);
+    return =
true;
 }
 
 int
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2E=
h
index 52e09c9=2E=2E88c51fa 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/=
openvpn/socket=2Eh
@@ -337,8 +337,15 @@
 
 struct link_socket *link_socket_=
new(void);
 
-void socket_bind(socket_descriptor_t sd, const struct addrinf=
o *local, int af_family,
-                 const char *prefix, bool ipv6onl=
y);
+/**
+ * Bind @p sd to the first @p af_family address of @p local=2E A =
failure is
+ * reported at @p msglevel, so a caller that can do without the=
 bind passes a
+ * non-fatal level and checks the result=2E
+ *
+ * @return=
 whether the socket was bound
+ */
+bool socket_bind(socket_descriptor_t sd=
, const struct addrinfo *local, int af_family,
+                 const char=
 *prefix, bool ipv6only, msglvl_t msglevel);
 
 int openvpn_connect(socket_=
descriptor_t sd, const struct sockaddr *remote, int connect_timeout,
      =
               volatile int *signal_received);
@@ -392,9 +399,9 @@
  * Crea=
te a UDP socket for @p af set up the way a link socket is: --sndbuf/--rcvbu=
f,
  * --mark, --bind-dev and, when @p bind_addr is given, the local bind (=
IPV6_V6ONLY
  * per @p bind_ipv6_only)=2E Shared by create_socket() and the=
 --server-probe sockets,
- * so a probe socket is the connection socket it =
may become=2E A failed bind is
- * fatal; with @p optional a socket the hos=
t cannot create is not, so
- * --server-probe can skip that address family =
(SOCKET_UNDEFINED is returned)=2E
+ * so a probe socket is the connection s=
ocket it may become=2E With @p optional a
+ * socket the host cannot create=
 or bind is not fatal, so --server-probe can skip
+ * that address family (=
SOCKET_UNDEFINED is returned)=2E
  */
 socket_descriptor_t create_socket_ud=
p_configured(sa_family_t af, unsigned int sockflags,
                      =
                            const struct socket_buffer_size *sbs, int mark,=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I24e5925a72aae=
de53ef9e863fe96fcd7363df402
Gerrit-Change-Number: 1915
Gerrit-PatchSet: 12
=
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ralf Lici <ralf@mandelb=
it=2Ecom>
Gerrit-CC: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--s9ysT5uvD2U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Ralf Lici, R=C4=83zvan Cojocaru=2E </p>=

<p>Lev Stipakov <strong>uploaded patch set #12</strong> to this change=2E<=
/p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demai=
l">View Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">socket: Let an optional UDP socket give=
 up on a failed bind<br><br>create_socket_udp_configured()&#39;s &quot;opti=
onal&quot; argument covers only the<br>socket() call: socket_bind() is fata=
l, so a caller that can do without<br>the socket still dies if the address =
is unavailable=2E<br><br>That is a problem for the upcoming --server-probe,=
 which binds a probe<br>socket for every address family in use, while a con=
nection binds only<br>the family of the remote it is about to try=2E A --lp=
ort whose IPv6 port<br>happens to be taken by another process would therefo=
re kill a client<br>that could have connected over IPv4=2E<br><br>Give sock=
et_bind() a msglevel and a return value, and let &quot;optional&quot;<br>ap=
ply to the bind as well: the socket is closed and SOCKET_UNDEFINED is<br>re=
turned, so the caller can skip that address family=2E Every existing<br>cal=
ler passes M_FATAL and keeps its behaviour=2E<br><br>The failure message no=
w reports the address that was actually bound,<br>cur, rather than the head=
 of the list, local, which may belong to a<br>different address family=2E U=
ntil now that message was always followed by<br>a fatal exit; with an optio=
nal bind it is printed while the client<br>carries on, so it needs to name =
the right address=2E<br><br>Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363=
df402<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M =
src/openvpn/manage=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=
=2Eh<br>3 files changed, 30 insertions(+), 15 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/15/1915/12</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manag=
e=2Ec</span><br><span>index 58f63e6=2E=2E013d516 100644</span><br><span>---=
 a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</spa=
n><br><span>@@ -2105,7 +2105,7 @@</span><br><span>         {</span><br><spa=
n>             man-&gt;connection=2Esd_top =3D create_socket_tcp(man-&gt;se=
ttings=2Elocal);</span><br><span>             socket_bind(man-&gt;connectio=
n=2Esd_top, man-&gt;settings=2Elocal, man-&gt;settings=2Elocal-&gt;ai_famil=
y,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
     &quot;MANAGEMENT&quot;, false);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                        &quot;MANAGEMENT&quot;, false, M_F=
ATAL);</span><br><span>         }</span><br><span> </span><br><span>       =
  /*</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/sock=
et=2Ec</span><br><span>index 307b5c6=2E=2Ec7de904 100644</span><br><span>--=
- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</sp=
an><br><span>@@ -268,12 +268,13 @@</span><br><span>     {</span><br><span> =
        if (sock-&gt;socks_proxy &amp;&amp; sock-&gt;info=2Eproto =3D=3D PR=
OTO_UDP)</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            socket_bind(sock-&gt;ctrl_sd, sock-&gt;info=2Elsa=
-&gt;bind_local, sock-&gt;info=2Eaf, &quot;SOCKS&quot;, false);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            socket_bind(sock-&g=
t;ctrl_sd, sock-&gt;info=2Elsa-&gt;bind_local, sock-&gt;info=2Eaf, &quot;SO=
CKS&quot;, false,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      M_FATAL);</span><br><span>         }</span><br><span>=
         else</span><br><span>         {</span><br><span>             socke=
t_bind(sock-&gt;sd, sock-&gt;info=2Elsa-&gt;bind_local, sock-&gt;info=2Eaf,=
 &quot;TCP/UDP&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                        sock-&gt;info=2Ebind_ipv6_only);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                        sock-&gt;info=
=2Ebind_ipv6_only, M_FATAL);</span><br><span>         }</span><br><span>   =
  }</span><br><span> }</span><br><span>@@ -319,9 +320,11 @@</span><br><span=
>     }</span><br><span> </span><br><span>     socket_apply_options(sd, sbs=
, mark, bind_dev);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (bind_addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (bind_addr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  &amp;&amp; !socket_bind(sd, bind_addr, af, &quot;TCP/UDP&quot;, bind_ipv6=
_only, optional ? D_LOW : M_FATAL))</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        socket_bind(sd, bind_addr, af,=
 &quot;TCP/UDP&quot;, bind_ipv6_only);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        openvpn_close_socket(sd);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return SOCKET_UNDEFINED;</span><b=
r><span>     }</span><br><span>     return sd;</span><br><span> }</span><br=
><span>@@ -556,9 +559,9 @@</span><br><span>     return new_sd;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><=
br><span> socket_bind(socket_descriptor_t sd, const struct addrinfo *local,=
 int ai_family,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      const char *prefix, bool ipv6only)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            const char *prefix, bool ipv6only, msglvl_=
t msglevel)</span><br><span> {</span><br><span>     struct gc_arena gc =3D =
gc_new();</span><br><span> </span><br><span>@@ -582,8 +585,10 @@</span><br>=
<span>     }</span><br><span>     if (!cur)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;%s:=
 Socket bind failed: Addr to bind has no %s record&quot;, prefix,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;%=
s: Socket bind failed: Addr to bind has no %s record&quot;, prefix,</span><=
br><span>             addr_family_name(ai_family));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><sp=
an>     }</span><br><span> </span><br><span>     if (ai_family =3D=3D AF_IN=
ET6)</span><br><span>@@ -598,10 +603,13 @@</span><br><span>     }</span><br=
><span>     if (openvpn_bind(sd, cur-&gt;ai_addr, cur-&gt;ai_addrlen))</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     msg(M_FATAL | M_ERRNO, &quot;%s: Socket bind failed on local address %=
s&quot;, prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       print_sockaddr_ex(local-&gt;ai_addr, &quot;:&quot;, PS_SHOW_PORT, &a=
mp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(msglevel | M_ERRNO, &quot;%s: Socket bind failed on local address %s&quot;=
, prefix,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  print_sockaddr_ex(cur-&gt;ai_addr, &quot;:&quot;, PS_SHOW_PORT, &amp;gc))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn false;</span><br><span>     }</span><br><span>     gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span>=
<br><span> }</span><br><span> </span><br><span> int</span><br><span>diff --=
git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index=
 52e09c9=2E=2E88c51fa 100644</span><br><span>--- a/src/openvpn/socket=2Eh</=
span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -337,8 +337,=
15 @@</span><br><span> </span><br><span> struct link_socket *link_socket_ne=
w(void);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void socket_bind(socket_descriptor_t sd, const struct addrinfo *local,=
 int af_family,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
           const char *prefix, bool ipv6only);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Bind @p sd to the first @p af_family address of @p local=2E A=
 failure is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * repor=
ted at @p msglevel, so a caller that can do without the bind passes a</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * non-fatal level and ch=
ecks the result=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return whether=
 the socket was bound</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool socket_bi=
nd(socket_descriptor_t sd, const struct addrinfo *local, int af_family,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const =
char *prefix, bool ipv6only, msglvl_t msglevel);</span><br><span> </span><b=
r><span> int openvpn_connect(socket_descriptor_t sd, const struct sockaddr =
*remote, int connect_timeout,</span><br><span>                     volatile=
 int *signal_received);</span><br><span>@@ -392,9 +399,9 @@</span><br><span=
>  * Create a UDP socket for @p af set up the way a link socket is: --sndbu=
f/--rcvbuf,</span><br><span>  * --mark, --bind-dev and, when @p bind_addr i=
s given, the local bind (IPV6_V6ONLY</span><br><span>  * per @p bind_ipv6_o=
nly)=2E Shared by create_socket() and the --server-probe sockets,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * so a probe socket is the con=
nection socket it may become=2E A failed bind is</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * fatal; with @p optional a socket the host can=
not create is not, so</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * --server-probe can skip that address family (SOCKET_UNDEFINED is returne=
d)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * so a probe =
socket is the connection socket it may become=2E With @p optional a</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * socket the host cannot c=
reate or bind is not fatal, so --server-probe can skip</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * that address family (SOCKET_UNDEFINED=
 is returned)=2E</span><br><span>  */</span><br><span> socket_descriptor_t =
create_socket_udp_configured(sa_family_t af, unsigned int sockflags,</span>=
<br><span>                                                  const struct so=
cket_buffer_size *sbs, int mark,</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail">change 191=
5</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I24e5925a72aaede53ef9e863fe96fcd7363df402 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 1915 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov=
 &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></=
html>
--s9ysT5uvD2U=--


--===============1317122437004038343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1317122437004038343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1317122437004038343==--

