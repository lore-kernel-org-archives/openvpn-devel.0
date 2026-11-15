Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38DF606A31A
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TNpof/ML;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YsRZ0EqN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OVltGZWi;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=K2pZy7m6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EvZJdNv8By+gNI3OBcNLo1MG9GI8bL72CcernoXOJHY=; b=TNpof/ML3E2EionJUwZjQwfrD/
	/ylczbGQ2eXpRAnDyga5vJVJ51oxeYWshcD4EfwhtjOne+vhSckb2hGKnhQ9gsnERR9dd5kCp8Yvd
	LQc7CoLSSSQ5LP6YtHlOOp2RfGd7XTpCKpgopR6hlEm5RwkK7RqL8+ANG+BfEszttU+U=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSdAr-000000002Qi-0Jfr;
	Sun, 15 Nov 2026 16:33:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSdAq-000000002Qc-2GUh
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 16:33:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C4n1EkopoqMV2RpZw2TKJbqcwvuy1fna4vBhy8O4zr8=; b=YsRZ0EqNgImnjvI2BxpeoAaKSj
 +6wUtIOUR2879Bo+adqHmkwUsbKHDC6nqb9yJEswz8LShygcO6q6NF2ae6uKMDXBsYoSoc372G2uz
 mY54G24VD1pkbAjYMPJFDkzVXHQhZ3bsocRTp0bppG1q63DrZ6VC5Mh5bvejmrcjcFvQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C4n1EkopoqMV2RpZw2TKJbqcwvuy1fna4vBhy8O4zr8=; b=OVltGZWix3/WeKWjA2THSIrped
 DWC89bFgn3YfNuHeY1USxU/UgVy+XDuSvrCFFoxj+SQM5soeR63kMYGlKlG9mKUe1657un1QtRoI7
 aSrZRzMbe0NM1Gp3DqZCkINM1zg7FfefGD79bOAdcGiISPxqxTxJeNb73VQCi9E2dcZQ=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSdAo-000000004RX-3RZh for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 16:33:48 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so29305805e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 08:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794760420; x=1795365220; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C4n1EkopoqMV2RpZw2TKJbqcwvuy1fna4vBhy8O4zr8=;
 b=K2pZy7m6abmUNrGYeJbX7gNfzxqDm8oUM09ahVOALAAdfzH4d/DnRqBYD10R6Z5c96
 hY8+2jy9mHdIdaY7KK8+AjTrfi5w2/YZoEuEIUlSAojso3uuyJjFN8ry+AOEoaskd5He
 1T69KXZF57ukF7gkY64csnpujcfxnw+iUK1DJWFU1VLo3kKAjf7+FEzD6sn8zsSmPwnN
 HdosDAztkrYH1RqO9XGZUupTAtimSkg3ZbIvRa3hbzqqu5LI+oGsg3NzAxyRcqGuvO45
 yCh74ueIj9uGncWu/gor+qAxI1wuj978RzubSlm0et258AUhyzo8rNN1409wRnqqBY+F
 YOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794760420; x=1795365220;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=C4n1EkopoqMV2RpZw2TKJbqcwvuy1fna4vBhy8O4zr8=;
 b=J5u3BmnUJTMlYF+iEQr4jxODuXOKlA1TISgilDHQHXqt9jhuV1sKG+ELWIifZdSlx8
 mFm6w45i29s1ik/64FzhBx+zXsihydLVNpTjq/zXPf1aKIKAIig9OZpoqwfVkUuxLEM8
 oQbPmvnKKAVpPkWdhF2euJZMvmf4nFErs7ySuJ+qQggJWPsJTIK469ju8pothLHzvZkH
 QemfecM9LQW4BCg5UF8wQTIR1Pxiy8zB9z6TdEdFfh9m/MogZFjgN8SLIRUNr0c6NOmH
 vIqrtP8rTsufTak1t6x8zG27oFZUxF+zSE03OwxexfGXPKJMGEGHGms0R5dmddacV/s9
 pPOQ==
X-Gm-Message-State: APuU4Z/FyWymeclzCOwN/sXmX52/8zae2QbRNqzO/fQUTOFABZ9XcEh8
 f3Snko+czDwpOBSZDqkTpFzV9DZMxb200b/AR5XpRt/fdbQv29B1h2QOvUIj0qapMD8q4xHMwVK
 YXpdt0p6UP5HRVGV/1OaHQKMrLKy8Jpr3Mqjcun76cW2DvgRR6sGBW2T4PXwbbNzuUV3t
X-Gm-Gg: AYBFou3oYAZh4mZATvq5yD+LHFsa9keuacGHHiQ+TVb+H6TvfyapbT4DCCl5qhKT1eW
 NrwhV8aowY7WFkFoe/rV5y/MEzG/CGlHjQI61E9MpWuglITKzw6tsn6dRmC1mAHzfcFjMcmac0E
 tbU3E7ghRAn9fu+5FlOjlUYZUgM0weQe9jcxrY2VgNXJI19MkZ2eGYrpoCMc8GVBmDwD2uT5iBP
 XGJ/X9LyGHLliGJGabyLTwKIEv7YRC3TN3lPtcwJa9DkvQGhd1OsPo9h6JOPW8C99WxoDm35gL9
 I23Qy9JtVrmw4otjsRXuYZwHA9KYirBOxYpEsCkzkPCe6/d9SOBZuQq0b15GwMYODsChZDnPBoq
 POMozN7ZpNYTosJvD2PBdIlfqPBSqMg3m37efoV1oo2g+p68hS1u/bZCU07ZwIutwKUmOqc4Cs2
 RJJf5t6JZzD6OsJF3nokgHdmGPkfiAFkCV/giKmLG74r6/bNWL7MQUXOnpw91HG5D2a8eUBmmQ0
 Ru9xSNReKeebR0l4sb5yaaCJzGRFT5qgD4VwWrU/Uw0PosNvGle2hONNl0Z8Makv0zRIdfLD/ck
 Pqyb4h5/rha0GFioWqCDx/jFmLHnF0Pt6cKOAdcDW3eFtYdGWqY/Y//ttDG3zVN85cG7MhRiIQx
 Ht/fPzpiMjGdzRbObWEhp8ocqj0tP2SwmU4mJ2xxwjjpAR2XlU/KibOBcppG6hPs5xSXpsj+uUg
 or0tIwgsWNSb4tDvw=
X-Received: by 2002:a05:600d:3:b0:4a1:ddaa:571e with SMTP id
 5b1f17b1804b1-4bb55a50eacmr145487165e9.15.1794760420022; 
 Sun, 15 Nov 2026 08:33:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ae501bsm241552125e9.10.2026.11.15.08.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 08:33:39 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 16:33:37 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225
X-Gerrit-Change-Number: 2170
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2170?usp=email>
X-Gerrit-Commit: a52f1c50b0e6ac0fc9d4b565389aada48da696b5
In-Reply-To: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
References: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzQwMzgwMDAwLkk1YWI5NTllNzEwMWNmODAxYWM5M2U1MTg1ODU1ZTc1ZGIwZmI2MjI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9c89725d53b1ac28cd7e66edb0446eaa9d85d253-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSdAo-000000004RX-3RZh
Subject: [Openvpn-devel] [M] Change in openvpn[master]: DragonFly: bring
 things back into a working state
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0415910548399424656=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0415910548399424656==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M3xqg9kjDWI="; charset=UTF-8

--M3xqg9kjDWI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, R=C4=83zv=
an Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to=
 reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2170?usp=3Demail

to look at the new patch set (#3)=2E

The follow=
ing approvals got outdated and were removed:
Code-Review+2 by R=C4=83zvan C=
ojocaru


Change subject: DragonFly: bring things back into a working state=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

DragonFly:=
 bring things back into a working state

- t_client=2Esh(=2Ein): add "Drago=
nFly" to the OS versions "like FreeBSD"

- tun=2Ec open_tun()
   - add Drag=
onFly specific handling of dynamic tun/tap devices
     (open /dev/{tun,tap=
}, assigns first-free node, fdevname(fd) returns
      true device name)
  =
   --dev tunN (and tapN) works "the old way", by opening /dev/tunN - but
  =
   only for devices pre-created with "ifconfig tun3 create"
   - set ioctl(=
TUNSIFMODE, IFF_BROADCAST=3D1) for "topology subnet" tun ifs
     -> this i=
s sufficient to make FreeBSD "ifconfig ipv4" code work
     (DragonFly was =
broken by FreeBSD commit 94db3261659)

- tun=2Ec do_ifconfig_ipv4()
   - us=
e TARGET_FREEBSD code path for DragonFly too, just amend the
     error mes=
sage ("FreeBSD/DragonFly ifconfig failed")

- tun=2Ec do_ifconfig_ipv6()
  =
 - needs "add_route_connected_v6_net()" for tun and tap(!) devices,
     ot=
herwise the on-link /64 is not routed to the tun device

- tun=2Ec undo_ifc=
onfig_ipv4(), undo_ifconfig_ipv6()
   - share FreeBSD code to undo IPv4/IPv=
6 ifconfig on precreated interfaces
   - add delete_route_connected_v6_net(=
) call for DragonFly only
     (this is not removing fe80:: addresses from =
the tun if, which upsets
      t_client test, but for normal usage is consi=
dered "reasonably fine")

- lladdr=2Ec: add TARGET_DRAGONFLY to TARGET_FREE=
BSD format

v1 -> v2:
 - fix clang-format issues
 - introduce TUNSIFMODE se=
tting
 - revert do_ifconfig_ipv4 change from v1 (use FREEBSD code path)
 - =
use M_ERR instead of M_FATAL
 - gate --dev tun/tap check on --dev-node bein=
g unset

v2 -> v3:
 - clang-format in lladdr=2Ec and t_client=2Esh=2Ein

Ch=
ange-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225
Signed-off-by: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/lladdr=2Ec
M src/openvpn/tu=
n=2Ec
M tests/t_client=2Esh=2Ein
3 files changed, 74 insertions(+), 15 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/70/2170/3

diff --git a/src/openvpn/lladdr=2Ec b/src/openvpn/lladdr=2Ec
=
index 8bd572a=2E=2E43480f1 100644
--- a/src/openvpn/lladdr=2Ec
+++ b/src/op=
envpn/lladdr=2Ec
@@ -24,7 +24,7 @@
 }
 #else /* TARGET_LINUX */
 
-#if defi=
ned(TARGET_OPENBSD) || defined(TARGET_FREEBSD) || defined(TARGET_DARWIN)
+#=
if defined(TARGET_OPENBSD) || defined(TARGET_FREEBSD) || defined(TARGET_DAR=
WIN) || defined(TARGET_DRAGONFLY)
 #define IFCONFIG_LLADDR_FMT "%s %s lladd=
r %s"
 #elif defined(TARGET_NETBSD)
 #define IFCONFIG_LLADDR_FMT "%s %s lin=
k %s active"
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 7=
0fdd7e=2E=2Ec1c5548 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=
=2Ec
@@ -979,7 +979,7 @@
 #endif /* ifdef _WIN32 */
 }
 
-#if defined(_WIN3=
2)
+#if defined(_WIN32) || defined(TARGET_DRAGONFLY)
 
 /* some of the plat=
forms will auto-add a "network route" pointing
  * to the interface on "ifc=
onfig tunX 2001:db8::1/64", others need
@@ -1160,6 +1160,10 @@
     openvpn=
_execve_check(&argv, es, S_FATAL, "FreeBSD BSD 'ifconfig inet6 -ifdisabled'=
 failed");
 #endif
 
+#ifdef TARGET_DRAGONFLY
+    add_route_connected_v6_n=
et(tt, es);
+#endif
+
 #elif defined(TARGET_AIX)
     argv_printf(&argv, "%=
s %s inet6 %s/%d mtu %d up", IFCONFIG_PATH, ifname, ifconfig_ipv6_local,
  =
               tt->netbits_ipv6, tun_mtu);
@@ -1490,7 +1494,7 @@
     }
 
 =
    argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, es, S_FATAL, =
"FreeBSD ifconfig failed");
+    openvpn_execve_check(&argv, es, S_FATAL, "=
FreeBSD/DragonFly ifconfig failed");
 
 #elif defined(TARGET_AIX)
     {
@@=
 -1623,14 +1627,14 @@
             msg(M_WARN, "Linux can't del IP from ifa=
ce %s", tt->actual_name);
         }
     }
-#elif defined(TARGET_FREEBSD)
=
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
     struct gc_=
arena gc =3D gc_new();
     const char *ifconfig_local =3D print_in_addr_t(=
tt->local, 0, &gc);
     struct argv argv =3D argv_new();
 
     argv_print=
f(&argv, "%s %s %s -alias", IFCONFIG_PATH, tt->actual_name, ifconfig_local)=
;
     argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, NULL, 0, "=
FreeBSD ip addr del failed");
+    openvpn_execve_check(&argv, NULL, 0, "Fr=
eeBSD/DragonFly ip addr del failed");
 
     argv_free(&argv);
     gc_free=
(&gc);
@@ -1646,7 +1650,12 @@
     {
         msg(M_WARN, "Linux can't del =
IPv6 from iface %s", tt->actual_name);
     }
-#elif defined(TARGET_FREEBSD=
)
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
+
+#ifdef TAR=
GET_DRAGONFLY
+    delete_route_connected_v6_net(tt);
+#endif
+
     struct=
 gc_arena gc =3D gc_new();
     const char *ifconfig_ipv6_local =3D print_i=
n6_addr(tt->local_ipv6, 0, &gc);
     struct argv argv =3D argv_new();
@@ -=
1655,7 +1664,7 @@
                 ifconfig_ipv6_local, tt->netbits_ipv6);
=
 
     argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, NULL, 0, "=
FreeBSD ip -6 addr del failed");
+    openvpn_execve_check(&argv, NULL, 0, =
"FreeBSD/DragonFly ip -6 addr del failed");
 
     argv_free(&argv);
     g=
c_free(&gc);
@@ -2897,20 +2906,70 @@
 
 #elif defined(TARGET_DRAGONFLY)
 
+=
/* DragonFly tun/tap devices are similar to NetBSD
+ *  - for a dynamic tun=
/tap, open /dev/tun or /dev/tap, get assigned
+ *    the first free device,=
 ask with (f)devname(3) what you got, and
+ *    the interface will auto-de=
struct on close
+ *  - for a pre-created tun/tap, open "/dev/tun3"
+ *  - u=
sing "--dev tun3" and have it dynamically created needs a call
+ *    to "i=
fconfig tun3 create" which we don't currently do
+ */
+
 void
 open_tun(con=
st char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt=
,
          openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type,=
 dev_node, tt);
-
-    if (tt->fd >=3D 0)
+    if (!dev_node && (strcmp(dev=
, "tap") =3D=3D 0 || strcmp(dev, "tun") =3D=3D 0))
     {
-        int i =
=3D 0;
+        char tunname[256];
+        snprintf(tunname, sizeof(tunnam=
e), "/dev/%s", dev);
 
-        /* Disable extended modes */
+        if ((=
tt->fd =3D open(tunname, O_RDWR)) < 0)
+        {
+            msg(M_ERR, "=
Cannot allocate DragonFly TUN/TAP %s dynamically", tunname);
+        }
+
+=
        char *devname =3D fdevname(tt->fd);
+        if (devname =3D=3D NUL=
L)
+        {
+            msg(M_ERR, "Cannot query DragonFly TUN/TAP devic=
e name");
+        }
+        set_nonblock(tt->fd);
+        set_cloexec(tt=
->fd); /* don't pass fd to scripts */
+        msg(M_INFO, "TUN/TAP device =
%s opened", devname);
+
+        tt->actual_name =3D string_alloc(devname, =
NULL);
+    }
+    else
+    {
+        open_tun_generic(dev, dev_type, dev=
_node, tt);
+    }
+
+    if (tt->fd >=3D 0 && tt->type =3D=3D DEV_TYPE_TUN=
)
+    {
+        /* see "Interface Flags" in ifnet(9) */
+        int i =
=3D IFF_POINTOPOINT | IFF_MULTICAST;
+        if (tt->topology =3D=3D TOP_S=
UBNET)
+        {
+            i =3D IFF_BROADCAST | IFF_MULTICAST;
+      =
  }
+
+        if (ioctl(tt->fd, TUNSIFMODE, &i) < 0)
+        {
+         =
   msg(M_WARN | M_ERRNO, "ioctl(TUNSIFMODE)");
+        }
+
+        /* Dis=
able "link layer" mode (would prepend route-nexthop address
+         * on =
read, but is incompatible with TUNSIFHEAD multi-af mode) */
+        i =3D =
0;
         ioctl(tt->fd, TUNSLMODE, &i);
+
+        /* multi_af mode for v=
4+v6, see "tun(4)" */
         i =3D 1;
-        ioctl(tt->fd, TUNSIFHEAD, =
&i);
+        if (ioctl(tt->fd, TUNSIFHEAD, &i) < 0)
+        {
+          =
  msg(M_WARN | M_ERRNO, "ioctl(TUNSIFHEAD)");
+        }
     }
 }
 
diff -=
-git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 5e924bb=2E=
=2Ed81cef0 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=
=2Ein
@@ -212,8 +212,8 @@
                 LANG=3DC @NETSTAT@ -rn -4 -6
   =
          fi
             ;;
-        FreeBSD | NetBSD | Darwin)
-         =
   echo "-- FreeBSD/NetBSD/Darwin [MacOS X] --"
+        FreeBSD | DragonFl=
y | NetBSD | Darwin)
+            echo "-- FreeBSD/DragonFly/NetBSD/Darwin =
[MacOS X] --"
             @IFCONFIG@ -a | egrep "(flags=3D|inet)"
        =
     @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
            =
 ;;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ab959e710=
1cf801ac93e5185855e75db0fb6225
Gerrit-Change-Number: 2170
Gerrit-PatchSet: =
3
Gerrit-Owner: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: Gert Doering <gert@greenie=2Emuc=2Ede>

--M3xqg9kjDWI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, R=C4=83zvan Cojocaru=2E <=
/p>
<p>Gert Doering <strong>uploaded patch set #3</strong> to this change=
=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">DragonFly: =
bring things back into a working state<br><br>- t_client=2Esh(=2Ein): add &=
quot;DragonFly&quot; to the OS versions &quot;like FreeBSD&quot;<br><br>- t=
un=2Ec open_tun()<br>   - add DragonFly specific handling of dynamic tun/ta=
p devices<br>     (open /dev/{tun,tap}, assigns first-free node, fdevname(f=
d) returns<br>      true device name)<br>     --dev tunN (and tapN) works &=
quot;the old way&quot;, by opening /dev/tunN - but<br>     only for devices=
 pre-created with &quot;ifconfig tun3 create&quot;<br>   - set ioctl(TUNSIF=
MODE, IFF_BROADCAST=3D1) for &quot;topology subnet&quot; tun ifs<br>     -&=
gt; this is sufficient to make FreeBSD &quot;ifconfig ipv4&quot; code work<=
br>     (DragonFly was broken by FreeBSD commit 94db3261659)<br><br>- tun=
=2Ec do_ifconfig_ipv4()<br>   - use TARGET_FREEBSD code path for DragonFly =
too, just amend the<br>     error message (&quot;FreeBSD/DragonFly ifconfig=
 failed&quot;)<br><br>- tun=2Ec do_ifconfig_ipv6()<br>   - needs &quot;add_=
route_connected_v6_net()&quot; for tun and tap(!) devices,<br>     otherwis=
e the on-link /64 is not routed to the tun device<br><br>- tun=2Ec undo_ifc=
onfig_ipv4(), undo_ifconfig_ipv6()<br>   - share FreeBSD code to undo IPv4/=
IPv6 ifconfig on precreated interfaces<br>   - add delete_route_connected_v=
6_net() call for DragonFly only<br>     (this is not removing fe80:: addres=
ses from the tun if, which upsets<br>      t_client test, but for normal us=
age is considered &quot;reasonably fine&quot;)<br><br>- lladdr=2Ec: add TAR=
GET_DRAGONFLY to TARGET_FREEBSD format<br><br>v1 -&gt; v2:<br> - fix clang-=
format issues<br> - introduce TUNSIFMODE setting<br> - revert do_ifconfig_i=
pv4 change from v1 (use FREEBSD code path)<br> - use M_ERR instead of M_FAT=
AL<br> - gate --dev tun/tap check on --dev-node being unset<br><br>v2 -&gt;=
 v3:<br> - clang-format in lladdr=2Ec and t_client=2Esh=2Ein<br><br>Change-=
Id: I5ab959e7101cf801ac93e5185855e75db0fb6225<br>Signed-off-by: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/lladdr=2Ec<br>M s=
rc/openvpn/tun=2Ec<br>M tests/t_client=2Esh=2Ein<br>3 files changed, 74 ins=
ertions(+), 15 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/2170/3</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/lladdr=2Ec b/src/openvpn/lladdr=2Ec</span><br><span>index 8bd5=
72a=2E=2E43480f1 100644</span><br><span>--- a/src/openvpn/lladdr=2Ec</span>=
<br><span>+++ b/src/openvpn/lladdr=2Ec</span><br><span>@@ -24,7 +24,7 @@</s=
pan><br><span> }</span><br><span> #else /* TARGET_LINUX */</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_O=
PENBSD) || defined(TARGET_FREEBSD) || defined(TARGET_DARWIN)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_OPENBSD) || def=
ined(TARGET_FREEBSD) || defined(TARGET_DARWIN) || defined(TARGET_DRAGONFLY)=
</span><br><span> #define IFCONFIG_LLADDR_FMT &quot;%s %s lladdr %s&quot;</=
span><br><span> #elif defined(TARGET_NETBSD)</span><br><span> #define IFCON=
FIG_LLADDR_FMT &quot;%s %s link %s active&quot;</span><br><span>diff --git =
a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 70fdd7e=
=2E=2Ec1c5548 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><s=
pan>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -979,7 +979,7 @@</span><br=
><span> #endif /* ifdef _WIN32 */</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) || def=
ined(TARGET_DRAGONFLY)</span><br><span> </span><br><span> /* some of the pl=
atforms will auto-add a &quot;network route&quot; pointing</span><br><span>=
  * to the interface on &quot;ifconfig tunX 2001:db8::1/64&quot;, others ne=
ed</span><br><span>@@ -1160,6 +1160,10 @@</span><br><span>     openvpn_exec=
ve_check(&amp;argv, es, S_FATAL, &quot;FreeBSD BSD &#39;ifconfig inet6 -ifd=
isabled&#39; failed&quot;);</span><br><span> #endif</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_DRAGONFLY</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_route_connect=
ed_v6_net(tt, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> #elif defined(TARGET_AIX)</span><br><span>     argv_printf(&amp;argv, &=
quot;%s %s inet6 %s/%d mtu %d up&quot;, IFCONFIG_PATH, ifname, ifconfig_ipv=
6_local,</span><br><span>                 tt-&gt;netbits_ipv6, tun_mtu);</s=
pan><br><span>@@ -1490,7 +1494,7 @@</span><br><span>     }</span><br><span>=
 </span><br><span>     argv_msg(M_INFO, &amp;argv);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv, es, S_F=
ATAL, &quot;FreeBSD ifconfig failed&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    openvpn_execve_check(&amp;argv, es, S_FATAL, &q=
uot;FreeBSD/DragonFly ifconfig failed&quot;);</span><br><span> </span><br><=
span> #elif defined(TARGET_AIX)</span><br><span>     {</span><br><span>@@ -=
1623,14 +1627,14 @@</span><br><span>             msg(M_WARN, &quot;Linux ca=
n&#39;t del IP from iface %s&quot;, tt-&gt;actual_name);</span><br><span>  =
       }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#elif defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONF=
LY)</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> =
    const char *ifconfig_local =3D print_in_addr_t(tt-&gt;local, 0, &amp;gc=
);</span><br><span>     struct argv argv =3D argv_new();</span><br><span> <=
/span><br><span>     argv_printf(&amp;argv, &quot;%s %s %s -alias&quot;, IF=
CONFIG_PATH, tt-&gt;actual_name, ifconfig_local);</span><br><span>     argv=
_msg(M_INFO, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    openvpn_execve_check(&amp;argv, NULL, 0, &quot;FreeBSD ip addr del f=
ailed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    op=
envpn_execve_check(&amp;argv, NULL, 0, &quot;FreeBSD/DragonFly ip addr del =
failed&quot;);</span><br><span> </span><br><span>     argv_free(&amp;argv);=
</span><br><span>     gc_free(&amp;gc);</span><br><span>@@ -1646,7 +1650,12=
 @@</span><br><span>     {</span><br><span>         msg(M_WARN, &quot;Linux=
 can&#39;t del IPv6 from iface %s&quot;, tt-&gt;actual_name);</span><br><sp=
an>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif define=
d(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
lif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifdef TARGET_DRAGONFLY</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    delete_route_connected_v6_net(tt);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>     struct gc_arena gc =3D gc=
_new();</span><br><span>     const char *ifconfig_ipv6_local =3D print_in6_=
addr(tt-&gt;local_ipv6, 0, &amp;gc);</span><br><span>     struct argv argv =
=3D argv_new();</span><br><span>@@ -1655,7 +1664,7 @@</span><br><span>     =
            ifconfig_ipv6_local, tt-&gt;netbits_ipv6);</span><br><span> </s=
pan><br><span>     argv_msg(M_INFO, &amp;argv);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv, NULL, 0, &quo=
t;FreeBSD ip -6 addr del failed&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    openvpn_execve_check(&amp;argv, NULL, 0, &quot;Free=
BSD/DragonFly ip -6 addr del failed&quot;);</span><br><span> </span><br><sp=
an>     argv_free(&amp;argv);</span><br><span>     gc_free(&amp;gc);</span>=
<br><span>@@ -2897,20 +2906,70 @@</span><br><span> </span><br><span> #elif =
defined(TARGET_DRAGONFLY)</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* DragonFly tun/tap devices are similar to NetBSD<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - for a dynamic =
tun/tap, open /dev/tun or /dev/tap, get assigned</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *    the first free device, ask with (f)devna=
me(3) what you got, and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *    the interface will auto-destruct on close</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  - for a pre-created tun/tap, open &qu=
ot;/dev/tun3&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  - using &quot;--dev tun3&quot; and have it dynamically created needs a c=
all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    to &quot;i=
fconfig tun3 create&quot; which we don&#39;t currently do</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> void</span><br><span> open_tun(cons=
t char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,=
</span><br><span>          openvpn_net_ctx_t *ctx)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    open_tun_generic(dev, d=
ev_type, dev_node, tt);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tt-&gt;fd &=
gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!d=
ev_node &amp;&amp; (strcmp(dev, &quot;tap&quot;) =3D=3D 0 || strcmp(dev, &q=
uot;tun&quot;) =3D=3D 0))</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        int i =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        char tunname[256];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        snprintf(tunname, sizeof(tunname=
), &quot;/dev/%s&quot;, dev);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        /* Disable extended modes */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if ((tt-&gt;fd =3D open(=
tunname, O_RDWR)) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(M_ERR, &quot;Cannot allocate DragonFly TUN/TAP %s dynamically&q=
uot;, tunname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        char *devname =3D fdevnam=
e(tt-&gt;fd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (devname =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         msg(M_ERR, &quot;Cannot query DragonFly TUN/TAP device name&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        set_nonblock(tt-&gt;=
fd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        set_clo=
exec(tt-&gt;fd); /* don&#39;t pass fd to scripts */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;TUN/TAP device =
%s opened&quot;, devname);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tt-&=
gt;actual_name =3D string_alloc(devname, NULL);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ope=
n_tun_generic(dev, dev_type, dev_node, tt);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (t=
t-&gt;fd &gt;=3D 0 &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* see &quot;Interface Flags&quot; in =
ifnet(9) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
int i =3D IFF_POINTOPOINT | IFF_MULTICAST;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (tt-&gt;topology =3D=3D TOP_SUBNET)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            i =3D IFF_BROADCAST | I=
FF_MULTICAST;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (ioctl(tt-&gt;fd, TUNSIF=
MODE, &amp;i) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(M_WARN | M_ERRNO, &quot;ioctl(TUNSIFMODE)&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* Disable &quot;link layer&quot; mode (would prepend rout=
e-nexthop address</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       * on read, but is incompatible with TUNSIFHEAD multi-af mode) */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        i =3D 0;</span>=
<br><span>         ioctl(tt-&gt;fd, TUNSLMODE, &amp;i);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* multi_af mode for v4+v6, see &quot;tun(4)&quot;=
 */</span><br><span>         i =3D 1;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        ioctl(tt-&gt;fd, TUNSIFHEAD, &amp;i);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (ioctl(tt-&gt;fd, TUNS=
IFHEAD, &amp;i) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      msg(M_WARN | M_ERRNO, &quot;ioctl(TUNSIFHEAD)&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span>diff --git a/tests/t_cli=
ent=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br><span>index 5e924bb=2E=
=2Ed81cef0 100755</span><br><span>--- a/tests/t_client=2Esh=2Ein</span><br>=
<span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>@@ -212,8 +212,8 @@</s=
pan><br><span>                 LANG=3DC @NETSTAT@ -rn -4 -6</span><br><span=
>             fi</span><br><span>             ;;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        FreeBSD | NetBSD | Darwin)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            echo &quot;-- FreeBSD/N=
etBSD/Darwin [MacOS X] --&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        FreeBSD | DragonFly | NetBSD | Darwin)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            echo &quot;-- FreeBSD/Dr=
agonFly/NetBSD/Darwin [MacOS X] --&quot;</span><br><span>             @IFCO=
NFIG@ -a | egrep &quot;(flags=3D|inet)&quot;</span><br><span>             @=
NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3,$NF }&#39;</span><br>=
<span>             ;;</span><br></pre><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail">change 2170</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ab959e71=
01cf801ac93e5185855e75db0fb6225 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 2170 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 =
</div>
<div style=3D"display:none"> Gerrit-Owner: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--M3xqg9kjDWI=--


--===============0415910548399424656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0415910548399424656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0415910548399424656==--

