Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D3C606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=a0LdeqMx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Kz5dxEY6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RdMbpFij;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cKqZWZq4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XuN+RWEPINOOatEvOe0IaD1MRnNiCUPveujLUawHvDA=; b=a0LdeqMxiV/DQZxMiDADiWghoe
	mQbDpLJeftDXRL5VywXgsOpP0DeT07WGPnEG9zs1D60d8+qmqRvZmZu40yq+NQ/RDem84Q4Ah3N7t
	oGSkS+7jPZ7a0FqALPEKM5G/az2EynEnhhPMhBHjZvdD0uXdl68muNwcKmzaIGph4skY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTKmr-000000002NM-0Ir4;
	Tue, 17 Nov 2026 15:07:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTKmq-000000002NE-08P3
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 15:07:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=znIOhUgT9jbut/TUeL+cxAOH0bXZKJ1tPQHBi37yPp4=; b=Kz5dxEY6IuqhfMbEfDH15ETYBv
 /8kP6LOMrq+3TvzCFXdQCXhDS85wVpdhzo9jhNLTIheD1iyUbLHCbdTpQ+cCDGPYMWe1V/Ztl8VzQ
 b7o14quWNSvA8MTML26TsGSSJ3C32MlE8ijySMqS8o3wjKqh/wizHiJ683AgmEBbl3JQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=znIOhUgT9jbut/TUeL+cxAOH0bXZKJ1tPQHBi37yPp4=; b=RdMbpFijd5+/cztNJa7QVPwzl7
 gc1WHWWqzVA6lk8sdG96zYVev60EXzL54/tEQtVTZrK4xe9Of7WyPj43+geMlHrQA0zlQ3mjc3ueS
 My2A+5c8t0j8G1f0KMnbqxMnrEX8MfcNxZumQP6EiIVFC9Knm5mJ2mFpxBYSkUSc8nDc=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTKmn-000000004nt-3wYD for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 15:07:55 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so34249855e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 07:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794928067; x=1795532867; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=znIOhUgT9jbut/TUeL+cxAOH0bXZKJ1tPQHBi37yPp4=;
 b=cKqZWZq4CETXSJ76zZHUmkvRjp/vYEWFg4xNXHI8eUIW1X/VEcqohyKNZrkmY1nZm/
 uQvb6VFKgNlvOzBx6KagQXNpmyrgagIeq8KwpyL2VfCJuh25y5IZaDRGFTHY+qt03XTV
 bhTQIC3GiPdnUCEe9kgDUPQfxMOFOa7EUtNQfk21lsZzwZQb4b7PRyp4BsKBJt3Jac/B
 fHz10D+M9H0sVolzXKPFCj0GtP5ubzDIfc5xFL3WZDp4zMfFOAlu+oVzit/+UpMgQ+1Y
 U5KOxOqozkWxXxj5aCvTSWwyCOjpPy40QeygPwpXDVrY0NZMZBZR7gjzH/3zByo8i35B
 Bu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928067; x=1795532867;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=znIOhUgT9jbut/TUeL+cxAOH0bXZKJ1tPQHBi37yPp4=;
 b=yPj/VJEKXWF/EiAvxcaG3FESmvzEl4IEKc1cUPq1ono+mn4+j6DeYRb7+bVNV/3AX1
 GHK/SNrj+Wy9zMUtxXNty0eru1q2TNNP/iDh7D9SENJ+nNMNA+ZKXI+1AdncQM6bbyQ2
 vdnxi79QMZ92RlGVJwpjMM/ONS0ukpxF+5Lpa7Ua55rs9TSw/rZoIk4J4XRcg7G65uSK
 wuDB3yq1C+bnBZGOGPtS/2XyoI7GMJWf9ARBJ8QfvqLIIpdiWv4vSAULiUEeZBY5THl5
 79EpBT3/r+yyLVCVJEoX7FYKgAxhDvQoIHOqFqsGKhOsXUE73ZRME6l+Cdbpg0f58CrO
 kZgA==
X-Gm-Message-State: APuU4Z8Golb6/xJ4qlBkFhjMOBOC71XUNASicUkBeMOyIlPTG6Fd+3w8
 8T0MRHCLU/rhpYsnvYtN+9zQO8ab8iny3N2YPMa37HVZ9qayprAfcgA6ywqkYwSBMgzxahcTWBn
 vF+/kSuvxhojnDOjPfLd9KAgYGoKsZSykd3VxoGnfGRJKCRXKVci0Q27S8JzNWYgahUE9
X-Gm-Gg: AYBFou2iFLzEwxAQ2G8EDrAcOwB8WHngEU0O7V8eE5Hd6vLa3MSk9I0OJVTqbWo/voa
 htTiLtSm9FGnGtCVNWTm130GeyO4Sfd5aWhOwIFAja8zzygb3ZtSwxOF0CDLMk+ax88spTkc643
 UZMs1IOT3/0Qd41Kf7vIESPbXCufIl7vECfktjZGFYCX6nTFpGC3s5TiZQ2dLLtWD6v1nSY0Oqr
 x7syjzMAAjPpgTIkWYS+T9jTFS9d9PODhOOBlIjTlPYTGvn/CR1poKEoQbPYrtN1WGo72Ybl5ZX
 Ag5sbv9Sz0czE1ryk0BbVrnKOC7uXWkUS/k9QvBxkFctG9PA49HlRJKZOcP2e9bu/JiL0RPpiK9
 pskZsa/8iJGBmcXLObvunL/SVmWf5yEy6Rd4Y31uCNo7IO+PaVaAtptn/BqQQ19HIQlYbtjbM1M
 GdNv19dczw4O6ML1i/h0uziotXxpZEq8GqENeAZO3klkEM7I2hmuTgg64Kg/h6vhkNnUKU1vEkm
 jIjllniiOogvwKX7pZStp60lnUsbiEPcC4teVwCiJh0p50bwgqUPZUzTzF2idczTrYzuehHs/nT
 oFJC6xHW9qoHQvRxDNM56dCBJLdjUEDGUyxIuN6SXM29oEnhHVrU2ptQqp53k5Dh4owB1YHKn9R
 np4msNvHT0oKDVYauzh9HdcP4efRQIx8/wgph42lqc6A8LWU5J2VDQ38jkF6ee2KIca4iBetnDM
 VZ+a49h796qlAAWLA=
X-Received: by 2002:a05:600c:3b0f:b0:4a7:a5db:a93e with SMTP id
 5b1f17b1804b1-4bb7c377678mr6812635e9.4.1794928066907; 
 Tue, 17 Nov 2026 07:07:46 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb56719391sm152636175e9.1.2026.11.17.07.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 07:07:45 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 15:07:39 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225
X-Gerrit-Change-Number: 2170
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2170?usp=email>
X-Gerrit-Commit: 727e2463939d5b4118b2b19f4445493597484718
In-Reply-To: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
References: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzQwMzgwMDAwLkk1YWI5NTllNzEwMWNmODAxYWM5M2U1MTg1ODU1ZTc1ZGIwZmI2MjI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bcc2627508854cc1a4e873f3fd63a2874a8534a9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTKmn-000000004nt-3wYD
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
Content-Type: multipart/mixed; boundary="===============8915856319450497322=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8915856319450497322==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CQlKOORImCI="; charset=UTF-8

--CQlKOORImCI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a cha=
nge=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?us=
p=3Demail

to look at the new patch set (#4)=2E

The following approvals go=
t outdated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru


Change=
 subject: DragonFly: bring things back into a working state
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

DragonFly: bring things back=
 into a working state

- t_client=2Esh(=2Ein): add "DragonFly" to the OS ve=
rsions "like FreeBSD"

- tun=2Ec open_tun()
   - add DragonFly specific han=
dling of dynamic tun/tap devices
     (open /dev/{tun,tap}, assigns first-f=
ree node, fdevname(fd) returns
      true device name)
     --dev tunN (and=
 tapN) works "the old way", by opening /dev/tunN - but
     only for device=
s pre-created with "ifconfig tun3 create"
   - set ioctl(TUNSIFMODE, IFF_BR=
OADCAST=3D1) for "topology subnet" tun ifs
     -> this is sufficient to ma=
ke FreeBSD "ifconfig ipv4" code work
     (DragonFly was broken by FreeBSD =
commit 94db3261659)

- tun=2Ec do_ifconfig_ipv4()
   - use TARGET_FREEBSD c=
ode path for DragonFly too, just amend the
     error message ("FreeBSD/Dra=
gonFly ifconfig failed")

- tun=2Ec do_ifconfig_ipv6()
   - needs "add_rout=
e_connected_v6_net()" for tun and tap(!) devices,
     otherwise the on-lin=
k /64 is not routed to the tun device

- tun=2Ec undo_ifconfig_ipv4(), undo=
_ifconfig_ipv6()
   - share FreeBSD code to undo IPv4/IPv6 ifconfig on prec=
reated interfaces
   - add delete_route_connected_v6_net() call for DragonF=
ly only
     (this is not removing fe80:: addresses from the tun if, which =
upsets
      t_client test, but for normal usage is considered "reasonably =
fine")

- lladdr=2Ec: add TARGET_DRAGONFLY to TARGET_FREEBSD format

v1 -> =
v2:
 - fix clang-format issues
 - introduce TUNSIFMODE setting
 - revert do=
_ifconfig_ipv4 change from v1 (use FREEBSD code path)
 - use M_ERR instead =
of M_FATAL
 - gate --dev tun/tap check on --dev-node being unset

v2 -> v3:=

 - clang-format in lladdr=2Ec and t_client=2Esh=2Ein

Change-Id: I5ab959e7=
101cf801ac93e5185855e75db0fb6225
Github: see also DragonFlyBSD/DPorts#266
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Acked-by: Razvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2170
Message-Id: <20261115164331=2E8511-1-gert@greenie=2Emuc=2Ede>
=
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2En=
et/msg41373=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
--=
-
M src/openvpn/lladdr=2Ec
M src/openvpn/tun=2Ec
M tests/t_client=2Esh=2Ein=

3 files changed, 75 insertions(+), 17 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/2170/4

diff --git a/src/o=
penvpn/lladdr=2Ec b/src/openvpn/lladdr=2Ec
index 8bd572a=2E=2E43480f1 10064=
4
--- a/src/openvpn/lladdr=2Ec
+++ b/src/openvpn/lladdr=2Ec
@@ -24,7 +24,7 =
@@
 }
 #else /* TARGET_LINUX */
 
-#if defined(TARGET_OPENBSD) || defined(T=
ARGET_FREEBSD) || defined(TARGET_DARWIN)
+#if defined(TARGET_OPENBSD) || de=
fined(TARGET_FREEBSD) || defined(TARGET_DARWIN) || defined(TARGET_DRAGONFLY=
)
 #define IFCONFIG_LLADDR_FMT "%s %s lladdr %s"
 #elif defined(TARGET_NETB=
SD)
 #define IFCONFIG_LLADDR_FMT "%s %s link %s active"
diff --git a/src/op=
envpn/tun=2Ec b/src/openvpn/tun=2Ec
index c56ace3=2E=2Efe1af45 100644
--- a=
/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -979,7 +979,7 @@
 #endif =
/* ifdef _WIN32 */
 }
 
-#if defined(_WIN32)
+#if defined(_WIN32) || define=
d(TARGET_DRAGONFLY)
 
 /* some of the platforms will auto-add a "network ro=
ute" pointing
  * to the interface on "ifconfig tunX 2001:db8::1/64", other=
s need
@@ -1014,8 +1014,7 @@
     route_ipv6_clear_host_bits(&r6);
     del=
ete_route_ipv6(&r6, tt, NULL, NULL);
 }
-#endif /* if defined(_WIN32) || de=
fined(TARGET_DARWIN) || defined(TARGET_NETBSD) || \
-          defined(TARG=
ET_OPENBSD) */
+#endif /* if defined(_WIN32) || defined(TARGET_DRAGONFLY) *=
/
 
 #if defined(TARGET_NETBSD) || defined(TARGET_OPENBSD)
 /* we can't use=
 true subnet mode on tun on all platforms, as that
@@ -1160,6 +1159,10 @@
 =
    openvpn_execve_check(&argv, es, S_FATAL, "FreeBSD BSD 'ifconfig inet6 -=
ifdisabled' failed");
 #endif
 
+#ifdef TARGET_DRAGONFLY
+    add_route_con=
nected_v6_net(tt, es);
+#endif
+
 #elif defined(TARGET_AIX)
     argv_print=
f(&argv, "%s %s inet6 %s/%d mtu %d up", IFCONFIG_PATH, ifname, ifconfig_ipv=
6_local,
                 tt->netbits_ipv6, tun_mtu);
@@ -1490,7 +1493,7 @@=

     }
 
     argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, es=
, S_FATAL, "FreeBSD ifconfig failed");
+    openvpn_execve_check(&argv, es,=
 S_FATAL, "FreeBSD/DragonFly ifconfig failed");
 
 #elif defined(TARGET_AIX=
)
     {
@@ -1623,14 +1626,14 @@
             msg(M_WARN, "Linux can't del =
IP from iface %s", tt->actual_name);
         }
     }
-#elif defined(TARGE=
T_FREEBSD)
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
    =
 struct gc_arena gc =3D gc_new();
     const char *ifconfig_local =3D print=
_in_addr_t(tt->local, 0, &gc);
     struct argv argv =3D argv_new();
 
    =
 argv_printf(&argv, "%s %s %s -alias", IFCONFIG_PATH, tt->actual_name, ifco=
nfig_local);
     argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv,=
 NULL, 0, "FreeBSD ip addr del failed");
+    openvpn_execve_check(&argv, N=
ULL, 0, "FreeBSD/DragonFly ip addr del failed");
 
     argv_free(&argv);
 =
    gc_free(&gc);
@@ -1646,7 +1649,12 @@
     {
         msg(M_WARN, "Linux=
 can't del IPv6 from iface %s", tt->actual_name);
     }
-#elif defined(TAR=
GET_FREEBSD)
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
+
=
+#ifdef TARGET_DRAGONFLY
+    delete_route_connected_v6_net(tt);
+#endif
+
=
     struct gc_arena gc =3D gc_new();
     const char *ifconfig_ipv6_local =
=3D print_in6_addr(tt->local_ipv6, 0, &gc);
     struct argv argv =3D argv_=
new();
@@ -1655,7 +1663,7 @@
                 ifconfig_ipv6_local, tt->netb=
its_ipv6);
 
     argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv,=
 NULL, 0, "FreeBSD ip -6 addr del failed");
+    openvpn_execve_check(&argv=
, NULL, 0, "FreeBSD/DragonFly ip -6 addr del failed");
 
     argv_free(&ar=
gv);
     gc_free(&gc);
@@ -2888,20 +2896,70 @@
 
 #elif defined(TARGET_DRA=
GONFLY)
 
+/* DragonFly tun/tap devices are similar to NetBSD
+ *  - for a =
dynamic tun/tap, open /dev/tun or /dev/tap, get assigned
+ *    the first f=
ree device, ask with (f)devname(3) what you got, and
+ *    the interface w=
ill auto-destruct on close
+ *  - for a pre-created tun/tap, open "/dev/tun=
3"
+ *  - using "--dev tun3" and have it dynamically created needs a call
+=
 *    to "ifconfig tun3 create" which we don't currently do
+ */
+
 void
 o=
pen_tun(const char *dev, const char *dev_type, const char *dev_node, struct=
 tuntap *tt,
          openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev=
, dev_type, dev_node, tt);
-
-    if (tt->fd >=3D 0)
+    if (!dev_node && =
(strcmp(dev, "tap") =3D=3D 0 || strcmp(dev, "tun") =3D=3D 0))
     {
-     =
   int i =3D 0;
+        char tunname[256];
+        snprintf(tunname, size=
of(tunname), "/dev/%s", dev);
 
-        /* Disable extended modes */
+    =
    if ((tt->fd =3D open(tunname, O_RDWR)) < 0)
+        {
+            msg=
(M_ERR, "Cannot allocate DragonFly TUN/TAP %s dynamically", tunname);
+    =
    }
+
+        char *devname =3D fdevname(tt->fd);
+        if (devname =
=3D=3D NULL)
+        {
+            msg(M_ERR, "Cannot query DragonFly TUN=
/TAP device name");
+        }
+        set_nonblock(tt->fd);
+        set_=
cloexec(tt->fd); /* don't pass fd to scripts */
+        msg(M_INFO, "TUN/T=
AP device %s opened", devname);
+
+        tt->actual_name =3D string_alloc=
(devname, NULL);
+    }
+    else
+    {
+        open_tun_generic(dev, dev=
_type, dev_node, tt);
+    }
+
+    if (tt->fd >=3D 0 && tt->type =3D=3D DE=
V_TYPE_TUN)
+    {
+        /* see "Interface Flags" in ifnet(9) */
+      =
  int i =3D IFF_POINTOPOINT | IFF_MULTICAST;
+        if (tt->topology =3D=
=3D TOP_SUBNET)
+        {
+            i =3D IFF_BROADCAST | IFF_MULTICAST=
;
+        }
+
+        if (ioctl(tt->fd, TUNSIFMODE, &i) < 0)
+        {
+=
            msg(M_WARN | M_ERRNO, "ioctl(TUNSIFMODE)");
+        }
+
+     =
   /* Disable "link layer" mode (would prepend route-nexthop address
+     =
    * on read, but is incompatible with TUNSIFHEAD multi-af mode) */
+     =
   i =3D 0;
         ioctl(tt->fd, TUNSLMODE, &i);
+
+        /* multi_af m=
ode for v4+v6, see "tun(4)" */
         i =3D 1;
-        ioctl(tt->fd, TUN=
SIFHEAD, &i);
+        if (ioctl(tt->fd, TUNSIFHEAD, &i) < 0)
+        {
+ =
           msg(M_WARN | M_ERRNO, "ioctl(TUNSIFHEAD)");
+        }
     }
 }=

 
diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 5=
e924bb=2E=2Ed81cef0 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_cli=
ent=2Esh=2Ein
@@ -212,8 +212,8 @@
                 LANG=3DC @NETSTAT@ -rn -=
4 -6
             fi
             ;;
-        FreeBSD | NetBSD | Darwin)
- =
           echo "-- FreeBSD/NetBSD/Darwin [MacOS X] --"
+        FreeBSD | =
DragonFly | NetBSD | Darwin)
+            echo "-- FreeBSD/DragonFly/NetBSD=
/Darwin [MacOS X] --"
             @IFCONFIG@ -a | egrep "(flags=3D|inet)"
=
             @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
    =
         ;;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2170?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5a=
b959e7101cf801ac93e5185855e75db0fb6225
Gerrit-Change-Number: 2170
Gerrit-Pa=
tchSet: 4
Gerrit-Owner: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>

--CQlKOORImCI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail">View Change</a></p>=
<p>The following approvals got outdated and were removed:
Code-Review+2 by =
R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">DragonFly: bring things back into a w=
orking state<br><br>- t_client=2Esh(=2Ein): add &quot;DragonFly&quot; to th=
e OS versions &quot;like FreeBSD&quot;<br><br>- tun=2Ec open_tun()<br>   - =
add DragonFly specific handling of dynamic tun/tap devices<br>     (open /d=
ev/{tun,tap}, assigns first-free node, fdevname(fd) returns<br>      true d=
evice name)<br>     --dev tunN (and tapN) works &quot;the old way&quot;, by=
 opening /dev/tunN - but<br>     only for devices pre-created with &quot;if=
config tun3 create&quot;<br>   - set ioctl(TUNSIFMODE, IFF_BROADCAST=3D1) f=
or &quot;topology subnet&quot; tun ifs<br>     -&gt; this is sufficient to =
make FreeBSD &quot;ifconfig ipv4&quot; code work<br>     (DragonFly was bro=
ken by FreeBSD commit 94db3261659)<br><br>- tun=2Ec do_ifconfig_ipv4()<br> =
  - use TARGET_FREEBSD code path for DragonFly too, just amend the<br>     =
error message (&quot;FreeBSD/DragonFly ifconfig failed&quot;)<br><br>- tun=
=2Ec do_ifconfig_ipv6()<br>   - needs &quot;add_route_connected_v6_net()&qu=
ot; for tun and tap(!) devices,<br>     otherwise the on-link /64 is not ro=
uted to the tun device<br><br>- tun=2Ec undo_ifconfig_ipv4(), undo_ifconfig=
_ipv6()<br>   - share FreeBSD code to undo IPv4/IPv6 ifconfig on precreated=
 interfaces<br>   - add delete_route_connected_v6_net() call for DragonFly =
only<br>     (this is not removing fe80:: addresses from the tun if, which =
upsets<br>      t_client test, but for normal usage is considered &quot;rea=
sonably fine&quot;)<br><br>- lladdr=2Ec: add TARGET_DRAGONFLY to TARGET_FRE=
EBSD format<br><br>v1 -&gt; v2:<br> - fix clang-format issues<br> - introdu=
ce TUNSIFMODE setting<br> - revert do_ifconfig_ipv4 change from v1 (use FRE=
EBSD code path)<br> - use M_ERR instead of M_FATAL<br> - gate --dev tun/tap=
 check on --dev-node being unset<br><br>v2 -&gt; v3:<br> - clang-format in =
lladdr=2Ec and t_client=2Esh=2Ein<br><br>Change-Id: I5ab959e7101cf801ac93e5=
185855e75db0fb6225<br>Github: see also DragonFlyBSD/DPorts#266<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Acked-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2170<br>Message-Id: &lt;20261115164331=2E8511-1-gert@gre=
enie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@=
lists=2Esourceforge=2Enet/msg41373=2Ehtml<br>Signed-off-by: Gert Doering &l=
t;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/lladdr=2Ec<br>M src/o=
penvpn/tun=2Ec<br>M tests/t_client=2Esh=2Ein<br>3 files changed, 75 inserti=
ons(+), 17 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/70/2170/4</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/lladdr=2Ec b/src/openvpn/lladdr=2Ec</span><br><span>index 8bd572a=
=2E=2E43480f1 100644</span><br><span>--- a/src/openvpn/lladdr=2Ec</span><br=
><span>+++ b/src/openvpn/lladdr=2Ec</span><br><span>@@ -24,7 +24,7 @@</span=
><br><span> }</span><br><span> #else /* TARGET_LINUX */</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_OPEN=
BSD) || defined(TARGET_FREEBSD) || defined(TARGET_DARWIN)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_OPENBSD) || define=
d(TARGET_FREEBSD) || defined(TARGET_DARWIN) || defined(TARGET_DRAGONFLY)</s=
pan><br><span> #define IFCONFIG_LLADDR_FMT &quot;%s %s lladdr %s&quot;</spa=
n><br><span> #elif defined(TARGET_NETBSD)</span><br><span> #define IFCONFIG=
_LLADDR_FMT &quot;%s %s link %s active&quot;</span><br><span>diff --git a/s=
rc/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index c56ace3=2E=
=2Efe1af45 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span=
>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -979,7 +979,7 @@</span><br><s=
pan> #endif /* ifdef _WIN32 */</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) || define=
d(TARGET_DRAGONFLY)</span><br><span> </span><br><span> /* some of the platf=
orms will auto-add a &quot;network route&quot; pointing</span><br><span>  *=
 to the interface on &quot;ifconfig tunX 2001:db8::1/64&quot;, others need<=
/span><br><span>@@ -1014,8 +1014,7 @@</span><br><span>     route_ipv6_clear=
_host_bits(&amp;r6);</span><br><span>     delete_route_ipv6(&amp;r6, tt, NU=
LL, NULL);</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(T=
ARGET_NETBSD) || \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
       defined(TARGET_OPENBSD) */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif /* if defined(_WIN32) || defined(TARGET_DRAGONFLY) */<=
/span><br><span> </span><br><span> #if defined(TARGET_NETBSD) || defined(TA=
RGET_OPENBSD)</span><br><span> /* we can&#39;t use true subnet mode on tun =
on all platforms, as that</span><br><span>@@ -1160,6 +1159,10 @@</span><br>=
<span>     openvpn_execve_check(&amp;argv, es, S_FATAL, &quot;FreeBSD BSD &=
#39;ifconfig inet6 -ifdisabled&#39; failed&quot;);</span><br><span> #endif<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
fdef TARGET_DRAGONFLY</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    add_route_connected_v6_net(tt, es);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> #elif defined(TARGET_AIX)</span><br><span>     a=
rgv_printf(&amp;argv, &quot;%s %s inet6 %s/%d mtu %d up&quot;, IFCONFIG_PAT=
H, ifname, ifconfig_ipv6_local,</span><br><span>                 tt-&gt;net=
bits_ipv6, tun_mtu);</span><br><span>@@ -1490,7 +1493,7 @@</span><br><span>=
     }</span><br><span> </span><br><span>     argv_msg(M_INFO, &amp;argv);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_che=
ck(&amp;argv, es, S_FATAL, &quot;FreeBSD ifconfig failed&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_execve_check(&amp;=
argv, es, S_FATAL, &quot;FreeBSD/DragonFly ifconfig failed&quot;);</span><b=
r><span> </span><br><span> #elif defined(TARGET_AIX)</span><br><span>     {=
</span><br><span>@@ -1623,14 +1626,14 @@</span><br><span>             msg(M=
_WARN, &quot;Linux can&#39;t del IP from iface %s&quot;, tt-&gt;actual_name=
);</span><br><span>         }</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_FREEBSD) || =
defined(TARGET_DRAGONFLY)</span><br><span>     struct gc_arena gc =3D gc_ne=
w();</span><br><span>     const char *ifconfig_local =3D print_in_addr_t(tt=
-&gt;local, 0, &amp;gc);</span><br><span>     struct argv argv =3D argv_new=
();</span><br><span> </span><br><span>     argv_printf(&amp;argv, &quot;%s =
%s %s -alias&quot;, IFCONFIG_PATH, tt-&gt;actual_name, ifconfig_local);</sp=
an><br><span>     argv_msg(M_INFO, &amp;argv);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    openvpn_execve_check(&amp;argv, NULL, 0, &quot=
;FreeBSD ip addr del failed&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    openvpn_execve_check(&amp;argv, NULL, 0, &quot;FreeBSD/=
DragonFly ip addr del failed&quot;);</span><br><span> </span><br><span>    =
 argv_free(&amp;argv);</span><br><span>     gc_free(&amp;gc);</span><br><sp=
an>@@ -1646,7 +1649,12 @@</span><br><span>     {</span><br><span>         m=
sg(M_WARN, &quot;Linux can&#39;t del IPv6 from iface %s&quot;, tt-&gt;actua=
l_name);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#elif defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONF=
LY)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_DRAGONFLY</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    delete_route_connected_v6_n=
et(tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     str=
uct gc_arena gc =3D gc_new();</span><br><span>     const char *ifconfig_ipv=
6_local =3D print_in6_addr(tt-&gt;local_ipv6, 0, &amp;gc);</span><br><span>=
     struct argv argv =3D argv_new();</span><br><span>@@ -1655,7 +1663,7 @@=
</span><br><span>                 ifconfig_ipv6_local, tt-&gt;netbits_ipv6)=
;</span><br><span> </span><br><span>     argv_msg(M_INFO, &amp;argv);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_execve_check(&a=
mp;argv, NULL, 0, &quot;FreeBSD ip -6 addr del failed&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    openvpn_execve_check(&amp;arg=
v, NULL, 0, &quot;FreeBSD/DragonFly ip -6 addr del failed&quot;);</span><br=
><span> </span><br><span>     argv_free(&amp;argv);</span><br><span>     gc=
_free(&amp;gc);</span><br><span>@@ -2888,20 +2896,70 @@</span><br><span> </=
span><br><span> #elif defined(TARGET_DRAGONFLY)</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* DragonFly tun/tap devices =
are similar to NetBSD</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  - for a dynamic tun/tap, open /dev/tun or /dev/tap, get assigned</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    the first free dev=
ice, ask with (f)devname(3) what you got, and</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *    the interface will auto-destruct on close</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - for a pre-creat=
ed tun/tap, open &quot;/dev/tun3&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  - using &quot;--dev tun3&quot; and have it dynamical=
ly created needs a call</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *    to &quot;ifconfig tun3 create&quot; which we don&#39;t currently =
do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br>=
<span> open_tun(const char *dev, const char *dev_type, const char *dev_node=
, struct tuntap *tt,</span><br><span>          openvpn_net_ctx_t *ctx)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ope=
n_tun_generic(dev, dev_type, dev_node, tt);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (tt-&gt;fd &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!dev_node &amp;&amp; (strcmp(dev, &quot;tap&quot;) =3D=3D=
 0 || strcmp(dev, &quot;tun&quot;) =3D=3D 0))</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        int i =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        char tunname[256];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tun=
name, sizeof(tunname), &quot;/dev/%s&quot;, dev);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Disable extended m=
odes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
(tt-&gt;fd =3D open(tunname, O_RDWR)) &lt; 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(M_ERR, &quot;Cannot allocate DragonFly TUN/=
TAP %s dynamically&quot;, tunname);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char =
*devname =3D fdevname(tt-&gt;fd);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (devname =3D=3D NULL)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            msg(M_ERR, &quot;Cannot query DragonFly TUN/TA=
P device name&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
set_nonblock(tt-&gt;fd);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        set_cloexec(tt-&gt;fd); /* don&#39;t pass fd to scripts */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, &qu=
ot;TUN/TAP device %s opened&quot;, devname);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        tt-&gt;actual_name =3D string_alloc(devname, NULL);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        open_tun_generic(dev, dev_type, dev_node, tt);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (tt-&gt;fd &gt;=3D 0 &amp;&amp; tt-&gt;type =3D=3D DEV_TY=
PE_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* see &quot;Inter=
face Flags&quot; in ifnet(9) */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        int i =3D IFF_POINTOPOINT | IFF_MULTICAST;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (tt-&gt;topology =3D=
=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i =
=3D IFF_BROADCAST | IFF_MULTICAST;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (io=
ctl(tt-&gt;fd, TUNSIFMODE, &amp;i) &lt; 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            msg(M_WARN | M_ERRNO, &quot;ioctl(TUNSIFMODE)&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* Disable &quot;link layer&quot; mod=
e (would prepend route-nexthop address</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         * on read, but is incompatible with TUNSIFHEAD =
multi-af mode) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      i =3D 0;</span><br><span>         ioctl(tt-&gt;fd, TUNSLMODE, &amp;i)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        /* multi_af mode for v4+v6, s=
ee &quot;tun(4)&quot; */</span><br><span>         i =3D 1;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        ioctl(tt-&gt;fd, TUNSIFHEAD, &=
amp;i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
ioctl(tt-&gt;fd, TUNSIFHEAD, &amp;i) &lt; 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            msg(M_WARN | M_ERRNO, &quot;ioctl(TUNSIFHEAD)&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span>     }</span><br><span> }</span><br><span> </span><br><span>dif=
f --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br><sp=
an>index 5e924bb=2E=2Ed81cef0 100755</span><br><span>--- a/tests/t_client=
=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>@=
@ -212,8 +212,8 @@</span><br><span>                 LANG=3DC @NETSTAT@ -rn =
-4 -6</span><br><span>             fi</span><br><span>             ;;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        FreeBSD | NetBSD | =
Darwin)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ec=
ho &quot;-- FreeBSD/NetBSD/Darwin [MacOS X] --&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        FreeBSD | DragonFly | NetBSD | Da=
rwin)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ec=
ho &quot;-- FreeBSD/DragonFly/NetBSD/Darwin [MacOS X] --&quot;</span><br><s=
pan>             @IFCONFIG@ -a | egrep &quot;(flags=3D|inet)&quot;</span><b=
r><span>             @NETSTAT@ -rn | awk &#39;$3 !~ /^UHL/ { print $1,$2,$3=
,$NF }&#39;</span><br><span>             ;;</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail">=
change 2170</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/217=
0?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 2170 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Ger=
t Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--CQlKOORImCI=--


--===============8915856319450497322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8915856319450497322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8915856319450497322==--

