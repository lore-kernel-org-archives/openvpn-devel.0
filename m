Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E0606A329
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lbfEhKaO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dUilBaGA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CTnfTmmc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LZUx9yzi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5msGLUEtZ2hFPPUSq38Xt896jBxzAljDSO4pd7E9xPg=; b=lbfEhKaOOImWhBY/Px95YchwmN
	ZjmtxwP08FymDNZ/XcvR+Q6W45YshxyuxobcnHjEVwV/L2OWrYFqZnXe6ue6+ofIGlnkjEN/rmYIK
	vi1O/cSRCHz3iThku4K+nj79AS9fGDLPiLQkEiJD4TlDMMMRTh2/DfawsToH30QeXDbQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVvp1-000000007WE-3jrG;
	Tue, 24 Nov 2026 19:04:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVvol-000000007W0-3kOT
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 19:04:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jugL+iT45vcIhYq4hn8j7UlW5AM0ISNJ9PLjI3MwtuI=; b=dUilBaGA5jxajk8v/Tjh1dbVpP
 SAAGx1Pwj4qViuBHUwpopX1YNpZvQWQLEE56DOqABS1X5Wvjq7CblYt13QxDOQVVxCp9vuQ69eGIG
 nDgmSyn7ppVG4Hj3ZjhPuUMaBWZ5MoaDyiVVZh0O9r21DhAchUon8xCTaD+HtU/4/RPk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jugL+iT45vcIhYq4hn8j7UlW5AM0ISNJ9PLjI3MwtuI=; b=CTnfTmmcdfo5kExVb530/l4dhX
 aYmIPqOa+OUtvhxkHUFtPhwI8+7zH1BEdL8Qaj1DC/2fJSmuhhaJiruzhlQai18P+7hs5gTnL6twS
 EvC+4al2XdGkG3OC8xMVxrtmmcwd57Y3fpcgdpNibFuqNDCUP34J6ACoybxHMcKWvEkQ=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVvok-000000003Ye-0808 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 19:04:39 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so33575595e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 11:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795547071; x=1796151871; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jugL+iT45vcIhYq4hn8j7UlW5AM0ISNJ9PLjI3MwtuI=;
 b=LZUx9yziR89q54L4Nrt0Y6gpMH1jVp6/PsRCWrBmz+Z7lbNVMbPI38amZYctQo2ytB
 wrMSrb6ktSaYjCe7dnwJj8nxoG7DFdVx3HwZ/xqbT//n7nmK9rp0fX8Eajq0f62GOBrf
 ss6i/wbNYmk/aNnk0vOoDPTwtJ+hi6Rj3sqQykw+11TYL1RS7hyLfOXOn/IlhQSE6X8Z
 kssra+Nqo5szjWmgQlLUp4r2lqB3mLRTjkUG0jvNPB0ccD37Wi50E3+76AwKa6BFg+dR
 j9XGpbPlViGGVtn0XkN3fImL9FZn5OTDFxASPcpB4BXDfq8D/NhrLvavnxHEmDrP0Wrl
 Qsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547071; x=1796151871;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jugL+iT45vcIhYq4hn8j7UlW5AM0ISNJ9PLjI3MwtuI=;
 b=BCqWqk3XGSCXKFlEv+lcCmOS+2/uKUsnL2yMzr2ua0vcLCa+yd1IuqOmr0M/88odXJ
 mVntNSYAFelVM3v5OSM3odc1ehLRwiQl3NJuHzbGCHwKAJslm35cfK7WsR29FbHkvW7z
 P8Zj97URfOFalqWDVMEzHGCYXa/U1Tt+h9opSCiL9TcM+scOO05LFyPjXvxXaeUiXhhB
 2Hg9Yh85JurbMiebmK/Jj/qKua1SeGifWVspcZM4TlJufvIaoRJ+zjHw1aTeqOa9MbgQ
 Bjr+hlu0Re5Q8VC7o6xK3w3fvMw4xp/PZLZxPiH2BEN4BclCD+MZdMd2ruyb5CyBX916
 tGXw==
X-Forwarded-Encrypted: i=1;
 AL+hErH1TrjQQ1+d1lfuRuCsBX+cC01BkZ5VDCwDsM5XtW2Keehkn5G/q1bOHJ1v4pmqPzl2YB18Mfg0U4/pyDzo@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/weT5HeyT6Bpx0b1ksC0gdv9/5d0gMjzLBfR3W5zTNC5RbK0nG
 VNRYzo7/au6+VuNs9cqJ2DKARMT/N5uR90BqXs6xfLLUxT6V6zlJAO2SzPGnKLpFMO5cI1RqWka
 2qt4vuzFQO8ZHm58fZRIeXJlIF4bWuCb0XlQ3BXFV1cNsrvwVvh61e0z45SjHUt6TKpD2
X-Gm-Gg: AZFdTZeCoogfkLqmkakaRvZr+sN1244Q8eTyTxDU1pbgRbM0Gb1OdUcCWQcFQw6qHg0
 vCm4Q67j/42YI8MmVsgBUrJS4U8m5n02MVWGgNydHYvYbJ4DDeMtN/5Q7jhT/XpsW0ytebmh4rl
 +xzwsSuMI5NzgCOBUisyyXOux4VC4RPkYZeP8QDO3G8CzDlfZgNP+7mHOBR83Z3ETKM5JX9OAZL
 3K2JC28FOdS/NyFgJeigQkunxx1sAMbflJn45ylDesVraupd9226qWJ5NEIc1TkQUEkvy7tfNgo
 bMa6wnPcQcrNo5mFkPCd2ILnUqxtuOi2ccSnKBo5OE0hUpv+pLxY5tQ90c0G3SEHtEv6nC0EDpK
 mSmbiwlSkEN852NieK2l8XZClEnGVrY+iANPoq7zZnyuPMFUN0WgHFssmZ3EgoNnNBFSaqufio5
 LTrWWeFT2YaaK0JNOfStuLUFJvLKHkoXsP4/4kjQA6u52givYk/Hu1+RfxcnZN1yUy6uS338WMd
 JXpnE3mBlhJS3DRsplVqcx1Mnt5ZNngo8SwxZbjaYL6v6/MTtXBVxCXMWy04j9yDxETFNBx/8Pw
 hBKUQ98bKi9ooEGVaLWbExb7DH6275WpFBs+ZwFEkkgdK++IH/xb3SjeKb86QcieW3744sFiuMc
 WFeEDU5w0+N+N7/4f2uJBIVorZnplepwGneXIcUMYwEMAsV6vMeTNSFCygCu5MqhSiYdIh/1gxj
 ka+TDZbe4b1zr5K/I=
X-Received: by 2002:a05:600c:a15:b0:4b6:267a:dd6e with SMTP id
 5b1f17b1804b1-4bb88938a62mr319482075e9.28.1795547071194; 
 Tue, 24 Nov 2026 11:04:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906d6a13sm240814165e9.3.2026.11.24.11.04.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:04:30 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 19:04:30 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
X-Gerrit-Change-Number: 1915
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1915?usp=email>
X-Gerrit-Commit: 66ea3e05b6c67cc0438c58140d6ca76be0c315a0
In-Reply-To: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
References: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5Mzk1NTEyMDAwLkkyNGU1OTI1YTcyYWFlZGU1M2VmOWU4NjNmZTk2ZmNkNzM2M2RmNDAyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8f93d2616ea9c5e016083270b0207b3a89eb4ea0-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVvok-000000003Ye-0808
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8240131881634992372=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8240131881634992372==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="przTcCztPis="; charset=UTF-8

--przTcCztPis=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1915?usp=3Demail )

Change subject: socket: Let an optional UDP=
 socket give up on a failed bind
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
 M_FATAL and keeps its behaviour=2E With more than one return
path the gc a=
rena no longer belongs at the top of the function, so it
moves into the bin=
d failure, the only branch that formats an address=2E

The failure message =
now reports the address that was actually bound,
cur, rather than the head =
of the list, local, which may belong to a
different address family=2E Until=
 now that message was always followed by
a fatal exit; with an optional bin=
d it is printed while the client
carries on, so it needs to name the right =
address=2E

Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
Signed-off=
-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: Razvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915
Me=
ssage-Id: <20261124162555=2E722-1-gert@greenie=2Emuc=2Ede>
URL: https://lor=
e=2Ekernel=2Eorg/openvpn-devel/20261124162555=2E722-1-gert@greenie=2Emuc=2E=
de
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
manage=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
3 files change=
d, 30 insertions(+), 18 deletions(-)




diff --git a/src/openvpn/manage=2E=
c b/src/openvpn/manage=2Ec
index addd6f2=2E=2Ebbf454a 100644
--- a/src/open=
vpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2080,7 +2080,7 @@
         =
{
             man->connection=2Esd_top =3D create_socket_tcp(man->settings=
=2Elocal);
             socket_bind(man->connection=2Esd_top, man->settings=
=2Elocal, man->settings=2Elocal->ai_family,
-                        "MANAG=
EMENT", false);
+                        "MANAGEMENT", false, M_FATAL);
   =
      }
 
         /*
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/soc=
ket=2Ec
index c07ef60=2E=2E36cb0e5 100644
--- a/src/openvpn/socket=2Ec
+++ =
b/src/openvpn/socket=2Ec
@@ -268,12 +268,13 @@
     {
         if (sock->so=
cks_proxy && sock->info=2Eproto =3D=3D PROTO_UDP)
         {
-            s=
ocket_bind(sock->ctrl_sd, sock->info=2Elsa->bind_local, sock->info=2Eaf, "S=
OCKS", false);
+            socket_bind(sock->ctrl_sd, sock->info=2Elsa->bi=
nd_local, sock->info=2Eaf, "SOCKS", false,
+                        M_FATAL=
);
         }
         else
         {
             socket_bind(sock->sd, s=
ock->info=2Elsa->bind_local, sock->info=2Eaf, "TCP/UDP",
-                 =
       sock->info=2Ebind_ipv6_only);
+                        sock->info=2E=
bind_ipv6_only, M_FATAL);
         }
     }
 }
@@ -319,9 +320,11 @@
     }
=
 
     socket_apply_options(sd, sbs, mark, bind_dev);
-    if (bind_addr)
+=
    if (bind_addr
+        && !socket_bind(sd, bind_addr, af, "TCP/UDP", bi=
nd_ipv6_only, optional ? D_LOW : M_FATAL))
     {
-        socket_bind(sd, =
bind_addr, af, "TCP/UDP", bind_ipv6_only);
+        openvpn_close_socket(sd=
);
+        return SOCKET_UNDEFINED;
     }
     return sd;
 }
@@ -558,12 +=
561,10 @@
     return new_sd;
 }
 
-void
+bool
 socket_bind(socket_descript=
or_t sd, const struct addrinfo *local, int ai_family,
-            const ch=
ar *prefix, bool ipv6only)
+            const char *prefix, bool ipv6only, =
msglvl_t msglevel)
 {
-    struct gc_arena gc =3D gc_new();
-
     /* FIXME=
 (schwabe)
      * getaddrinfo for the bind address might return multiple A=
F_INET/AF_INET6
      * entries for the requested protocol=2E
@@ -584,8 +58=
5,9 @@
     }
     if (!cur)
     {
-        msg(M_FATAL, "%s: Socket bind =
failed: Addr to bind has no %s record", prefix,
+        msg(msglevel, "%s:=
 Socket bind failed: Addr to bind has no %s record", prefix,
             a=
ddr_family_name(ai_family));
+        return false;
     }
 
     if (ai_fa=
mily =3D=3D AF_INET6)
@@ -600,10 +602,13 @@
     }
     if (openvpn_bind(sd=
, cur->ai_addr, cur->ai_addrlen))
     {
-        msg(M_FATAL | M_ERRNO, "%=
s: Socket bind failed on local address %s", prefix,
-            print_sock=
addr_ex(local->ai_addr, ":", PS_SHOW_PORT, &gc));
+        struct gc_arena =
gc =3D gc_new();
+        msg(msglevel | M_ERRNO, "%s: Socket bind failed o=
n local address %s", prefix,
+            print_sockaddr_ex(cur->ai_addr, "=
:", PS_SHOW_PORT, &gc));
+        gc_free(&gc);
+        return false;
    =
 }
-    gc_free(&gc);
+    return true;
 }
 
 int
diff --git a/src/openvpn/=
socket=2Eh b/src/openvpn/socket=2Eh
index 2210bfe=2E=2E084b9cc 100644
--- a=
/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -346,8 +346,15 @@
 =

 struct link_socket *link_socket_new(void);
 
-void socket_bind(socket_des=
criptor_t sd, const struct addrinfo *local, int af_family,
-               =
  const char *prefix, bool ipv6only);
+/**
+ * Bind @p sd to the first @p a=
f_family address of @p local=2E A failure is
+ * reported at @p msglevel, s=
o a caller that can do without the bind passes a
+ * non-fatal level and ch=
ecks the result=2E
+ *
+ * @return whether the socket was bound
+ */
+bool =
socket_bind(socket_descriptor_t sd, const struct addrinfo *local, int af_fa=
mily,
+                 const char *prefix, bool ipv6only, msglvl_t msgleve=
l);
 
 int openvpn_connect(socket_descriptor_t sd, const struct sockaddr *r=
emote, int connect_timeout,
                     volatile int *signal_recei=
ved);
@@ -401,9 +408,9 @@
  * Create a UDP socket for @p af set up the way =
a link socket is: --sndbuf/--rcvbuf,
  * --mark, --bind-dev and, when @p bi=
nd_addr is given, the local bind (IPV6_V6ONLY
  * per @p bind_ipv6_only)=2E=
 Shared by create_socket() and the --server-probe sockets,
- * so a probe s=
ocket is the connection socket it may become=2E A failed bind is
- * fatal;=
 with @p optional a socket the host cannot create is not, so
- * --server-p=
robe can skip that address family (SOCKET_UNDEFINED is returned)=2E
+ * so =
a probe socket is the connection socket it may become=2E With @p optional a=

+ * socket the host cannot create or bind is not fatal, so --server-probe =
can skip
+ * that address family (SOCKET_UNDEFINED is returned)=2E
  */
 so=
cket_descriptor_t create_socket_udp_configured(sa_family_t af, unsigned int=
 sockflags,
                                                  const struct =
socket_buffer_size *sbs, int mark,

-- 
To view, visit https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1915?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
Gerrit-Change-Numb=
er: 1915
Gerrit-PatchSet: 14
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2E=
com>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>

--przTcCztPis=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1915?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">socket: Let an optional UDP socket=
 give up on a failed bind<br><br>create_socket_udp_configured()&#39;s &quot=
;optional&quot; argument covers only the<br>socket() call: socket_bind() is=
 fatal, so a caller that can do without<br>the socket still dies if the add=
ress is unavailable=2E<br><br>That is a problem for the upcoming --server-p=
robe, which binds a probe<br>socket for every address family in use, while =
a connection binds only<br>the family of the remote it is about to try=2E A=
 --lport whose IPv6 port<br>happens to be taken by another process would th=
erefore kill a client<br>that could have connected over IPv4=2E<br><br>Give=
 socket_bind() a msglevel and a return value, and let &quot;optional&quot;<=
br>apply to the bind as well: the socket is closed and SOCKET_UNDEFINED is<=
br>returned, so the caller can skip that address family=2E Every existing<b=
r>caller passes M_FATAL and keeps its behaviour=2E With more than one retur=
n<br>path the gc arena no longer belongs at the top of the function, so it<=
br>moves into the bind failure, the only branch that formats an address=2E<=
br><br>The failure message now reports the address that was actually bound,=
<br>cur, rather than the head of the list, local, which may belong to a<br>=
different address family=2E Until now that message was always followed by<b=
r>a fatal exit; with an optional bind it is printed while the client<br>car=
ries on, so it needs to name the right address=2E<br><br>Change-Id: I24e592=
5a72aaede53ef9e863fe96fcd7363df402<br>Signed-off-by: Lev Stipakov &lt;lev@o=
penvpn=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915<br>Message-=
Id: &lt;20261124162555=2E722-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://=
lore=2Ekernel=2Eorg/openvpn-devel/20261124162555=2E722-1-gert@greenie=2Emuc=
=2Ede<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---=
<br>M src/openvpn/manage=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/s=
ocket=2Eh<br>3 files changed, 30 insertions(+), 18 deletions(-)<br><br></pr=
e>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><b=
r><span>index addd6f2=2E=2Ebbf454a 100644</span><br><span>--- a/src/openvpn=
/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@=
 -2080,7 +2080,7 @@</span><br><span>         {</span><br><span>            =
 man-&gt;connection=2Esd_top =3D create_socket_tcp(man-&gt;settings=2Elocal=
);</span><br><span>             socket_bind(man-&gt;connection=2Esd_top, ma=
n-&gt;settings=2Elocal, man-&gt;settings=2Elocal-&gt;ai_family,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                        &quot;MAN=
AGEMENT&quot;, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        &quot;MANAGEMENT&quot;, false, M_FATAL);</span><=
br><span>         }</span><br><span> </span><br><span>         /*</span><br=
><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><=
br><span>index c07ef60=2E=2E36cb0e5 100644</span><br><span>--- a/src/openvp=
n/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@=
@ -268,12 +268,13 @@</span><br><span>     {</span><br><span>         if (so=
ck-&gt;socks_proxy &amp;&amp; sock-&gt;info=2Eproto =3D=3D PROTO_UDP)</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            socket_bind(sock-&gt;ctrl_sd, sock-&gt;info=2Elsa-&gt;bind_loca=
l, sock-&gt;info=2Eaf, &quot;SOCKS&quot;, false);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            socket_bind(sock-&gt;ctrl_sd, soc=
k-&gt;info=2Elsa-&gt;bind_local, sock-&gt;info=2Eaf, &quot;SOCKS&quot;, fal=
se,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        M_FATAL);</span><br><span>         }</span><br><span>         else<=
/span><br><span>         {</span><br><span>             socket_bind(sock-&g=
t;sd, sock-&gt;info=2Elsa-&gt;bind_local, sock-&gt;info=2Eaf, &quot;TCP/UDP=
&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
          sock-&gt;info=2Ebind_ipv6_only);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        sock-&gt;info=2Ebind_ipv6_on=
ly, M_FATAL);</span><br><span>         }</span><br><span>     }</span><br><=
span> }</span><br><span>@@ -319,9 +320,11 @@</span><br><span>     }</span><=
br><span> </span><br><span>     socket_apply_options(sd, sbs, mark, bind_de=
v);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (bind_addr)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (bind_addr</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !s=
ocket_bind(sd, bind_addr, af, &quot;TCP/UDP&quot;, bind_ipv6_only, optional=
 ? D_LOW : M_FATAL))</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        socket_bind(sd, bind_addr, af, &quot;TCP/UDP&=
quot;, bind_ipv6_only);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        openvpn_close_socket(sd);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        return SOCKET_UNDEFINED;</span><br><span>     }</=
span><br><span>     return sd;</span><br><span> }</span><br><span>@@ -558,1=
2 +561,10 @@</span><br><span>     return new_sd;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span> sock=
et_bind(socket_descriptor_t sd, const struct addrinfo *local, int ai_family=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            const ch=
ar *prefix, bool ipv6only)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            const char *prefix, bool ipv6only, msglvl_t msglevel)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span>     /* FIXME (schwabe)</span><br><span>      * =
getaddrinfo for the bind address might return multiple AF_INET/AF_INET6</sp=
an><br><span>      * entries for the requested protocol=2E</span><br><span>=
@@ -584,8 +585,9 @@</span><br><span>     }</span><br><span>     if (!cur)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        msg(M_FATAL, &quot;%s: Socket bind failed: Addr to bind has no %s r=
ecord&quot;, prefix,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        msg(msglevel, &quot;%s: Socket bind failed: Addr to bind has no %s=
 record&quot;, prefix,</span><br><span>             addr_family_name(ai_fam=
ily));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n false;</span><br><span>     }</span><br><span> </span><br><span>     if (=
ai_family =3D=3D AF_INET6)</span><br><span>@@ -600,10 +602,13 @@</span><br>=
<span>     }</span><br><span>     if (openvpn_bind(sd, cur-&gt;ai_addr, cur=
-&gt;ai_addrlen))</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        msg(M_FATAL | M_ERRNO, &quot;%s: Socket bind fai=
led on local address %s&quot;, prefix,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            print_sockaddr_ex(local-&gt;ai_addr, &quot;:&q=
uot;, PS_SHOW_PORT, &amp;gc));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel | M_ERRNO, &quot;%s:=
 Socket bind failed on local address %s&quot;, prefix,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            print_sockaddr_ex(cur-&gt;ai=
_addr, &quot;:&quot;, PS_SHOW_PORT, &amp;gc));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span>   =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;=
</span><br><span> }</span><br><span> </span><br><span> int</span><br><span>=
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><spa=
n>index 2210bfe=2E=2E084b9cc 100644</span><br><span>--- a/src/openvpn/socke=
t=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -346,=
8 +346,15 @@</span><br><span> </span><br><span> struct link_socket *link_so=
cket_new(void);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void socket_bind(socket_descriptor_t sd, const struct addrinfo =
*local, int af_family,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                 const char *prefix, bool ipv6only);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Bind @p sd to the first @p af_family address of @p loc=
al=2E A failure is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* reported at @p msglevel, so a caller that can do without the bind passes =
a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * non-fatal level=
 and checks the result=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return =
whether the socket was bound</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool so=
cket_bind(socket_descriptor_t sd, const struct addrinfo *local, int af_fami=
ly,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
 const char *prefix, bool ipv6only, msglvl_t msglevel);</span><br><span> </=
span><br><span> int openvpn_connect(socket_descriptor_t sd, const struct so=
ckaddr *remote, int connect_timeout,</span><br><span>                     v=
olatile int *signal_received);</span><br><span>@@ -401,9 +408,9 @@</span><b=
r><span>  * Create a UDP socket for @p af set up the way a link socket is: =
--sndbuf/--rcvbuf,</span><br><span>  * --mark, --bind-dev and, when @p bind=
_addr is given, the local bind (IPV6_V6ONLY</span><br><span>  * per @p bind=
_ipv6_only)=2E Shared by create_socket() and the --server-probe sockets,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * so a probe socket is =
the connection socket it may become=2E A failed bind is</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * fatal; with @p optional a socket the h=
ost cannot create is not, so</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * --server-probe can skip that address family (SOCKET_UNDEFINED is =
returned)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * so a=
 probe socket is the connection socket it may become=2E With @p optional a<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * socket the host c=
annot create or bind is not fatal, so --server-probe can skip</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * that address family (SOCKET_UN=
DEFINED is returned)=2E</span><br><span>  */</span><br><span> socket_descri=
ptor_t create_socket_udp_configured(sa_family_t af, unsigned int sockflags,=
</span><br><span>                                                  const st=
ruct socket_buffer_size *sbs, int mark,</span><br></pre><p>To view, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail">chan=
ge 1915</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

=
<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1915 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 14 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipa=
kov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--przTcCztPis=--


--===============8240131881634992372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8240131881634992372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8240131881634992372==--

