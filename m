Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38506606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LvLHQpBo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lrjCrkPe;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GoUjlDmN;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fNEd2sRV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XO8BLQecRf8HATJWAgwQtFrKadc/GXAMWyXbBU/d/JI=; b=LvLHQpBoZga6VmsOnk4QWqZ0LH
	Q0MGdMv5Wku6ZdSxSF01DkPBPQoU1KaiHk5Ngd8gTXs0mwcpZWchf80WF2UwtsdieY5Y3SU+byWzp
	0a0nRJ65WhProruIc8HSDNORQ+jVqoTq97ag/cvgR4nsNj4t8PbOvMMWgana37lrCzkE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVvom-000000006PY-3rf8;
	Tue, 24 Nov 2026 19:04:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVvol-000000006PR-1Kt2
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 19:04:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xrA7JKvEzU4yWI2Z9erHEd5UnetSvp9Z1z6vhZUv0+k=; b=lrjCrkPer/J5LPvp23GVQWxA13
 42/gSGVhDceQck1XdBc27NAB2qbLAc4rWDoS8pbIc14Vpg3QvDLLt8ixCJ6MNK+la4/uvJJ8aXoBK
 +vaSQ3VoWtUgQkfvIdU9Sktt2kBd+NBCnYDa7WNn49fpdr7eA2/UZ+BXBbEyYJa6uYi0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xrA7JKvEzU4yWI2Z9erHEd5UnetSvp9Z1z6vhZUv0+k=; b=GoUjlDmNWIPeRa5a4EUZw+NiRo
 bXaWq77nuhEnshDlDREpsQvUXx4UVVCJ9q4l1FLmJQOG86SD5kDYp91s7531BtmEujMIdSbNXDzl3
 Tn32fjh+lc3x8ajDi99quG6ANcLV2ODQsJVyXC+OTQc/wV5D0q2Sop7yuMrY7oEESFB0=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVvoj-000000001zt-0VIW for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 19:04:39 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4a5024b3c28so3479591f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 11:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795547070; x=1796151870; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xrA7JKvEzU4yWI2Z9erHEd5UnetSvp9Z1z6vhZUv0+k=;
 b=fNEd2sRVeaOcDMAHsib4MSf+LQkYOYjgW188Ol2zH4XFsxiuDrBl10bYlAb9l8BUmr
 D50nAPuaj7ceEzroM04yVCQf9Rmbx3vZ0jUhxGVKDKWmmAn+9uydNaiy66PjWXn0e9iC
 hpu2xkuGeNWzNXmXeIIuc0qigh+HsCpUcqtmzpyvNK2M7CjoYOKJ2Ri48wUpIES4rrVa
 kXTe02Izik2kRC/mdisLNqO0ivb4aAN9wInhA61MiDsoLzmQBI+QdDULJXidSS2NeWzs
 sAQqsXqrjCgtAmvuW4FLdFZ6Bz8KHWI8WHqfKKffjGngF/fEJk4ZCvdGF7z8UNS3a6YY
 3LXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547070; x=1796151870;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xrA7JKvEzU4yWI2Z9erHEd5UnetSvp9Z1z6vhZUv0+k=;
 b=oQlO+RvlLg0VsSUl7hpP1M8IYlguhqZgrHKst44MsLQeMgIeW9Qh/riorHyAD44o57
 Av7XpGaITRSU/Ol2Tum8JaKXUmEBRDskLFi9M/sHG4Sh/9YmgU2TjnfDdjDfkBB2l1Ra
 Y7ZLYtzZfRH2l8pIwB+taC2bl1WB4kFnzoPBQNmrM4zvlzJ/DIhYUHFvoxHl80D/fGmg
 CIMQr62T1GklJyy7EZFm5pkdWo6oAxyseAROtK45r6DAkytK/404Fwu7bJR8kB84afSV
 iTMQzQgUVKjTBLoMFHOfV16yCwOFVhNGKYBIeLsPFM0P3wWiTW6KXQXaq2d+gpt9iio9
 FMEQ==
X-Gm-Message-State: APuU4Z88dS1ikcqzI62iMvyxcYgwfJK/QrjSCmBebRBPW9WGNZPATy2G
 tEDhdj2cZk1iffREGJvBj2TX9Mmzgtlo2QRvSw3tt6ZPh281EDPQ6Gi5FUTD69NE7EaQNXtgiBL
 Tr3qn6OL2EpxTXRacT4DAP2toKLvwB8/7e5KXbbnt/FE7kXxNFqEfmRXFWqKujQiT1lVy
X-Gm-Gg: AZFdTZeX7Mew4AipsG1RDYksg/41MhGDIBHHZaqWVGxWOYO9a/nO58M6zx7DT0x+API
 /q6AbmPgnW658vSQ/+Sp+wfm5qCFnMbuwrfJVQTtp/amiOxiuaSvgKkkTsToTxa4vDid5RoZPim
 4dSegI47128ZgsDxUsjeDlAWrM+r6wvf/pv2c16zzSVHvGGe8tRgEyfgjWYr4J5AtHjV8yOHxw+
 MXd6peH9R3htzNWHKXKZ6JEync3hSCKuLZ3RP4R9onxtc/NUxfgfn3Wnh5Lmp6gjRet50M7Yby3
 gOUN2VvkEli2wZvG8GLvdimir4NkVCYKanCPICOYYIlBpjORnwh+SkAZQs/fOs/PFtfM3rMDADn
 Ifj9h1i0hvrJzNgn+PvArl+o6KslnDHGmulLbWRUwZt9N2IGy0e2frHzO9gv6XHddOA4vhQoO7q
 yIRq2G9/z0gLrRpuep35G5XE2rlRZY4VysyiDR816LZLByx+4GkHmCT5+z1IfScIW4ag2izqTUa
 pn77bQaw7T5CTlFw2N4qxL/L33taU8aWpOPpBTIUooHK1rFbyHb6C3h6jA4/guqef+vtXn9IxqS
 z8n+woD6nbml1Je7ppxm+63lvIj1KfcRDEuPgS0k+8OAzn77HFEmq5b5XhknQGJXl7uKD4zTs3+
 Gqv96Fo4Md7FG1mtcWSwEGpTt7c5QlovrCRPZfSL2k5V3i4/0fIXyD4Hx0+/JSq4R8DUerNOZ94
 mbMgF9+veYJkb2Le2A
X-Received: by 2002:a05:6000:2903:b0:491:c392:1f31 with SMTP id
 ffacd0b85a97d-4aa5ab788d1mr39658289f8f.28.1795547070297; 
 Tue, 24 Nov 2026 11:04:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b70c05b9desm5702043f8f.54.2026.11.24.11.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:04:29 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 19:04:28 +0000
To: Lev Stipakov <lstipakov@gmail.com>, Ralf Lici <ralf@mandelbit.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
X-Gerrit-Change-Number: 1915
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1915?usp=email>
X-Gerrit-Commit: 66ea3e05b6c67cc0438c58140d6ca76be0c315a0
In-Reply-To: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
References: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5Mzk1NTEyMDAwLkkyNGU1OTI1YTcyYWFlZGU1M2VmOWU4NjNmZTk2ZmNkNzM2M2RmNDAyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8f93d2616ea9c5e016083270b0207b3a89eb4ea0-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVvoj-000000001zt-0VIW
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2941884455574695906=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2941884455574695906==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mSkJlquEkjc="; charset=UTF-8

--mSkJlquEkjc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#14) to the change originally cr=
eated by Lev Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?=
usp=3Demail )

The following approvals got outdated and were removed:
Code-=
Review+2 by R=C4=83zvan Cojocaru


Change subject: socket: Let an optional =
UDP socket give up on a failed bind
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

socket: Let an optional UDP socket give up on a fail=
ed bind

create_socket_udp_configured()'s "optional" argument covers only t=
he
socket() call: socket_bind() is fatal, so a caller that can do without
t=
he socket still dies if the address is unavailable=2E

That is a problem fo=
r the upcoming --server-probe, which binds a probe
socket for every address=
 family in use, while a connection binds only
the family of the remote it i=
s about to try=2E A --lport whose IPv6 port
happens to be taken by another =
process would therefore kill a client
that could have connected over IPv4=
=2E

Give socket_bind() a msglevel and a return value, and let "optional"
a=
pply to the bind as well: the socket is closed and SOCKET_UNDEFINED is
retu=
rned, so the caller can skip that address family=2E Every existing
caller p=
asses M_FATAL and keeps its behaviour=2E With more than one return
path the=
 gc arena no longer belongs at the top of the function, so it
moves into th=
e bind failure, the only branch that formats an address=2E

The failure mes=
sage now reports the address that was actually bound,
cur, rather than the =
head of the list, local, which may belong to a
different address family=2E =
Until now that message was always followed by
a fatal exit; with an optiona=
l bind it is printed while the client
carries on, so it needs to name the r=
ight address=2E

Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
Signe=
d-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: Razvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
15
Message-Id: <20261124162555=2E722-1-gert@greenie=2Emuc=2Ede>
URL: https:=
//lore=2Ekernel=2Eorg/openvpn-devel/20261124162555=2E722-1-gert@greenie=2Em=
uc=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/ope=
nvpn/manage=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
3 files c=
hanged, 30 insertions(+), 18 deletions(-)


  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/15/1915/14

diff --git a/src/openvpn/ma=
nage=2Ec b/src/openvpn/manage=2Ec
index addd6f2=2E=2Ebbf454a 100644
--- a/s=
rc/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2080,7 +2080,7 @@
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
index c07ef60=2E=2E36cb0e5 100644
--- a/src/openvpn/socket=
=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -268,12 +268,13 @@
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
@@ -319,9 +320,11 =
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
 -558,12 +561,10 @@
     return new_sd;
 }
 
-void
+bool
 socket_bind(socke=
t_descriptor_t sd, const struct addrinfo *local, int ai_family,
-          =
  const char *prefix, bool ipv6only)
+            const char *prefix, bool =
ipv6only, msglvl_t msglevel)
 {
-    struct gc_arena gc =3D gc_new();
-
   =
  /* FIXME (schwabe)
      * getaddrinfo for the bind address might return =
multiple AF_INET/AF_INET6
      * entries for the requested protocol=2E
@@ =
-584,8 +585,9 @@
     }
     if (!cur)
     {
-        msg(M_FATAL, "%s: So=
cket bind failed: Addr to bind has no %s record", prefix,
+        msg(msgl=
evel, "%s: Socket bind failed: Addr to bind has no %s record", prefix,
    =
         addr_family_name(ai_family));
+        return false;
     }
 
    =
 if (ai_family =3D=3D AF_INET6)
@@ -600,10 +602,13 @@
     }
     if (openv=
pn_bind(sd, cur->ai_addr, cur->ai_addrlen))
     {
-        msg(M_FATAL | M=
_ERRNO, "%s: Socket bind failed on local address %s", prefix,
-            =
print_sockaddr_ex(local->ai_addr, ":", PS_SHOW_PORT, &gc));
+        struct=
 gc_arena gc =3D gc_new();
+        msg(msglevel | M_ERRNO, "%s: Socket bin=
d failed on local address %s", prefix,
+            print_sockaddr_ex(cur->=
ai_addr, ":", PS_SHOW_PORT, &gc));
+        gc_free(&gc);
+        return f=
alse;
     }
-    gc_free(&gc);
+    return true;
 }
 
 int
diff --git a/sr=
c/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index 2210bfe=2E=2E084b9cc 10=
0644
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -346,8 +3=
46,15 @@
 
 struct link_socket *link_socket_new(void);
 
-void socket_bind(=
socket_descriptor_t sd, const struct addrinfo *local, int af_family,
-     =
            const char *prefix, bool ipv6only);
+/**
+ * Bind @p sd to the =
first @p af_family address of @p local=2E A failure is
+ * reported at @p m=
sglevel, so a caller that can do without the bind passes a
+ * non-fatal le=
vel and checks the result=2E
+ *
+ * @return whether the socket was bound
+=
 */
+bool socket_bind(socket_descriptor_t sd, const struct addrinfo *local,=
 int af_family,
+                 const char *prefix, bool ipv6only, msglvl=
_t msglevel);
 
 int openvpn_connect(socket_descriptor_t sd, const struct s=
ockaddr *remote, int connect_timeout,
                     volatile int *si=
gnal_received);
@@ -401,9 +408,9 @@
  * Create a UDP socket for @p af set u=
p the way a link socket is: --sndbuf/--rcvbuf,
  * --mark, --bind-dev and, =
when @p bind_addr is given, the local bind (IPV6_V6ONLY
  * per @p bind_ipv=
6_only)=2E Shared by create_socket() and the --server-probe sockets,
- * so=
 a probe socket is the connection socket it may become=2E A failed bind is
=
- * fatal; with @p optional a socket the host cannot create is not, so
- * =
--server-probe can skip that address family (SOCKET_UNDEFINED is returned)=
=2E
+ * so a probe socket is the connection socket it may become=2E With @p=
 optional a
+ * socket the host cannot create or bind is not fatal, so --se=
rver-probe can skip
+ * that address family (SOCKET_UNDEFINED is returned)=
=2E
  */
 socket_descriptor_t create_socket_udp_configured(sa_family_t af, =
unsigned int sockflags,
                                                  c=
onst struct socket_buffer_size *sbs, int mark,

-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
G=
errit-Change-Number: 1915
Gerrit-PatchSet: 14
Gerrit-Owner: Lev Stipakov <l=
stipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>

--mSkJlquEkjc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #14</strong> to the change originally created by Lev=
 Stipakov=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
15?usp=3Demail">View Change</a></p><p>The following approvals got outdated =
and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">so=
cket: Let an optional UDP socket give up on a failed bind<br><br>create_soc=
ket_udp_configured()&#39;s &quot;optional&quot; argument covers only the<br=
>socket() call: socket_bind() is fatal, so a caller that can do without<br>=
the socket still dies if the address is unavailable=2E<br><br>That is a pro=
blem for the upcoming --server-probe, which binds a probe<br>socket for eve=
ry address family in use, while a connection binds only<br>the family of th=
e remote it is about to try=2E A --lport whose IPv6 port<br>happens to be t=
aken by another process would therefore kill a client<br>that could have co=
nnected over IPv4=2E<br><br>Give socket_bind() a msglevel and a return valu=
e, and let &quot;optional&quot;<br>apply to the bind as well: the socket is=
 closed and SOCKET_UNDEFINED is<br>returned, so the caller can skip that ad=
dress family=2E Every existing<br>caller passes M_FATAL and keeps its behav=
iour=2E With more than one return<br>path the gc arena no longer belongs at=
 the top of the function, so it<br>moves into the bind failure, the only br=
anch that formats an address=2E<br><br>The failure message now reports the =
address that was actually bound,<br>cur, rather than the head of the list, =
local, which may belong to a<br>different address family=2E Until now that =
message was always followed by<br>a fatal exit; with an optional bind it is=
 printed while the client<br>carries on, so it needs to name the right addr=
ess=2E<br><br>Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402<br>Signe=
d-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Razvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1915<br>Message-Id: &lt;20261124162555=2E722-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-devel/202611241=
62555=2E722-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/manage=2Ec<br>M src/openv=
pn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>3 files changed, 30 insertions=
(+), 18 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/15/1915/14</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index addd6f2=2E=
=2Ebbf454a 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><s=
pan>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -2080,7 +2080,7 @@</spa=
n><br><span>         {</span><br><span>             man-&gt;connection=2Esd=
_top =3D create_socket_tcp(man-&gt;settings=2Elocal);</span><br><span>     =
        socket_bind(man-&gt;connection=2Esd_top, man-&gt;settings=2Elocal, =
man-&gt;settings=2Elocal-&gt;ai_family,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                        &quot;MANAGEMENT&quot;, false);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   &quot;MANAGEMENT&quot;, false, M_FATAL);</span><br><span>         }</spa=
n><br><span> </span><br><span>         /*</span><br><span>diff --git a/src/=
openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index c07ef60=
=2E=2E36cb0e5 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br=
><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -268,12 +268,13 @@</=
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
n>@@ -319,9 +320,11 @@</span><br><span>     }</span><br><span> </span><br><=
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
return sd;</span><br><span> }</span><br><span>@@ -558,12 +561,10 @@</span><=
br><span>     return new_sd;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool</span><br><span> socket_bind(socket_descr=
iptor_t sd, const struct addrinfo *local, int ai_family,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            const char *prefix, bool ipv=
6only)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c=
onst char *prefix, bool ipv6only, msglvl_t msglevel)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span>     /* FIXME (schwabe)</span><br><span>      * getaddrinfo for th=
e bind address might return multiple AF_INET/AF_INET6</span><br><span>     =
 * entries for the requested protocol=2E</span><br><span>@@ -584,8 +585,9 @=
@</span><br><span>     }</span><br><span>     if (!cur)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATA=
L, &quot;%s: Socket bind failed: Addr to bind has no %s record&quot;, prefi=
x,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msgle=
vel, &quot;%s: Socket bind failed: Addr to bind has no %s record&quot;, pre=
fix,</span><br><span>             addr_family_name(ai_family));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br=
><span>     }</span><br><span> </span><br><span>     if (ai_family =3D=3D A=
F_INET6)</span><br><span>@@ -600,10 +602,13 @@</span><br><span>     }</span=
><br><span>     if (openvpn_bind(sd, cur-&gt;ai_addr, cur-&gt;ai_addrlen))<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        msg(M_FATAL | M_ERRNO, &quot;%s: Socket bind failed on local addre=
ss %s&quot;, prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           print_sockaddr_ex(local-&gt;ai_addr, &quot;:&quot;, PS_SHOW_PORT=
, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(msglevel | M_ERRNO, &quot;%s: Socket bind failed =
on local address %s&quot;, prefix,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            print_sockaddr_ex(cur-&gt;ai_addr, &quot;:&quot;=
, PS_SHOW_PORT, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return false;</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span> }</=
span><br><span> </span><br><span> int</span><br><span>diff --git a/src/open=
vpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 2210bfe=2E=2E=
084b9cc 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span=
>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -346,8 +346,15 @@</span><b=
r><span> </span><br><span> struct link_socket *link_socket_new(void);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void sock=
et_bind(socket_descriptor_t sd, const struct addrinfo *local, int af_family=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 con=
st char *prefix, bool ipv6only);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Bind @p sd to the first @p af_family address of @p local=2E A failure is</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reported at @p msgl=
evel, so a caller that can do without the bind passes a</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * non-fatal level and checks the resul=
t=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return whether the socket wa=
s bound</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool socket_bind(socket_desc=
riptor_t sd, const struct addrinfo *local, int af_family,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                 const char *prefix, =
bool ipv6only, msglvl_t msglevel);</span><br><span> </span><br><span> int o=
penvpn_connect(socket_descriptor_t sd, const struct sockaddr *remote, int c=
onnect_timeout,</span><br><span>                     volatile int *signal_r=
eceived);</span><br><span>@@ -401,9 +408,9 @@</span><br><span>  * Create a =
UDP socket for @p af set up the way a link socket is: --sndbuf/--rcvbuf,</s=
pan><br><span>  * --mark, --bind-dev and, when @p bind_addr is given, the l=
ocal bind (IPV6_V6ONLY</span><br><span>  * per @p bind_ipv6_only)=2E Shared=
 by create_socket() and the --server-probe sockets,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * so a probe socket is the connection sock=
et it may become=2E A failed bind is</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * fatal; with @p optional a socket the host cannot create i=
s not, so</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --server-=
probe can skip that address family (SOCKET_UNDEFINED is returned)=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * so a probe socket is th=
e connection socket it may become=2E With @p optional a</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * socket the host cannot create or bin=
d is not fatal, so --server-probe can skip</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * that address family (SOCKET_UNDEFINED is returned=
)=2E</span><br><span>  */</span><br><span> socket_descriptor_t create_socke=
t_udp_configured(sa_family_t af, unsigned int sockflags,</span><br><span>  =
                                                const struct socket_buffer_=
size *sbs, int mark,</span><br></pre><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail">change 1915</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I24e5925a72=
aaede53ef9e863fe96fcd7363df402 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1915 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 =
</div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipako=
v@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--mSkJlquEkjc=--


--===============2941884455574695906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2941884455574695906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2941884455574695906==--

