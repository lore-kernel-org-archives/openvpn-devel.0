Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CAE606A322
	for <openvpn-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iGV7mSrF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QIA/LBVR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JJj03yxX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TV5+vyP6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MOFXwfxRvNnM3O/wuzszgUXinYuLKjQy/gr5WfOMlt8=; b=iGV7mSrFfywafsd8Iat8904j9p
	L/Ayqe4jSXhqJvnf+BLkzorvQQ9yoqmOQuuGSKiP+aqqrwbwxxkwucSno4potZ/V+wfLJSgDSmofG
	yq75t6mo2cqcyZvZaCpRKMl8L86HX/jgYFdbQZ/UdS8i7oBg2JymqEdQ3rdo68VmYUGw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xKAp6-000000001Hp-1XzP;
	Fri, 23 Oct 2026 08:40:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xKAow-000000001Gu-1WuO
 for openvpn-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 08:40:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bhvcy6FRLE+as/4AvCHiIhmakTAMCVncqk+brGdX458=; b=QIA/LBVR9zXtrpVTxt5lp07lea
 xWPMSv22LjX/vosRCes/pt7heSv/czEtGhuL/pSHB+mwL7wYrsj8xLxoOHpGDKA0dSVSpIb88+Qg+
 XRremyP4T7hPWQE+mrEbkR0m3RonP8DYyVli7mMXaNtJSt/buMf5+q2cllsGEoBG2TaU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bhvcy6FRLE+as/4AvCHiIhmakTAMCVncqk+brGdX458=; b=JJj03yxXa9fBPYSgyikC4JlCWH
 dqphbvdJNzDnjdtHGtxJX1f68oIpXQWfau0Ryq1726ezNjuDCk7JLCkkU/PcOHZqwy8B2nIr3sphc
 +/osTAjcbfoLHUBLeGO07A59ICW+q6uq3WIhPumE+RxmTv7THOUsFfCNK0Paom9s0H/s=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xKAor-000000008Ce-39tO for openvpn-devel@lists.sourceforge.net;
 Fri, 23 Oct 2026 08:40:14 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso351745f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 23 Oct 2026 01:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792744803; x=1793349603; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Bhvcy6FRLE+as/4AvCHiIhmakTAMCVncqk+brGdX458=;
 b=TV5+vyP66XiyF+KyqQwxue26CZFnSC26FqRS//bldcxsEhbMGnZP9/tbXfcf4kXMMt
 56wLeSzA4l+A80C1dxXiAGfEwn6UINoPjda47csvl2ujYGmgJkC/8o6URj6H25mP/4fZ
 WQXZk5l5J9e3m+eHvNSOFE2OkeCvx92PuZMadvWHV75TSWgMKHspmApNPac6D0/iS1Zv
 obaExbdoMyf7Y2tVTGIFa9WH6Z+qZJek1IVDsx9h5RJGea/ZrKi+bXOynKO9LJvIz/OF
 izPatswvHob58uigQ5U0FMKerCZBD9v4sBmb2/FJTVFh/fMoSgN0d+mShLS5eTSs3J8L
 0zNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792744803; x=1793349603;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Bhvcy6FRLE+as/4AvCHiIhmakTAMCVncqk+brGdX458=;
 b=ofx9en8xUYN1ixyYUqitRa9G4gQ6zftlafgYl3gW8idbBHzpVdk5zObjFGoZmM2je7
 X+EPUQKjtTRobXZQe3L/tSiR3H+C1YvVjtXxbbTzy4GxX+p2JCMrIsNea8q2irm+ro8y
 ey1VcjW6aRvgFNAs2Pw6FhNrZfQXFsySja1NjGCKhirP4whmtPIzAr8JVpd5JXNzHjqq
 0G1+/ON+WKOK1r8dJT/53v0zB0O4ep31b95M4znS5GbxeLFsFlPP4LAlHgJkg2VvwcH2
 KR9Mnc0PvJsxVWkLxjEUPpdDewPRaWSIFNua/Uev4WeuHMKluQdSdgODWa/eowvV0sTC
 9SKA==
X-Gm-Message-State: AFq9FYKpsow7uhZZvzEhK8MDvXPJd/crf+GtVmaRr4Nd8XkqfV3o5LG5
 4Ys+IH7ZFvIE/2wyhWf7ENgHyBlFi/2kcklSy0iudj4t3y3r2dHNQTq6NTyjfpThqzKaPrko0UV
 vtIU4TLqAjoMHRs4aIcGN4+T/DDdxIXmu2f07QWy0PdsFdqZLCfqHxkg1/J493bIzqRZl9dH8g2
 dxxCdRfg==
X-Gm-Gg: AYBFou3YytTZsTdH1gCY7ZxayqR3jVh6wHtPKffUeRuVp0CqZ7YAlsU+n2FkbtMIw8r
 qy30ALuospmqOBjDREGqgYYF5vsj6XEvhfoB3qgNWckjc9L12e+5HxJ38/YNSHpzsYd8i2hfkGw
 w3G/e0V+1dE7SorUC9czJTRgVx7HQDbUYw7/+0/DEZ8akdD1ZGfTpceaK/n+Xbo1Y9PdQd737Z+
 elWWaeQEHkDnDBdCnkOREtT/lg0y6Q0C/jcHpD1JKZ72QvE59bSleKxm2Un6ujsNrxglc651iwV
 CudpbYf6NfHVJHE9nkf1AzcjHKxHLDjbW2E2rHSOXRBC7z04kh7ceOxN36uvgrDgrCPCqah9Nx0
 HExSv/cQ7x8O0G0mSjkpDgABctyBBmAKRI1xhdYUv6hldM/qXd3gYzGZkKw4HWBR6GvcRdufF6w
 yJ3335u+nMTpbPeS4J+/BMrWZZr2+q7roR0YiaINyiWmbjUqVvNh4cI6H8eQeeP5hqQQMtJjGkG
 g3zBCNY2mc5eGp6fP7DH3ovOKuUXyAPQnTvqmJhRCr/0NA03ycwYEx4afB4t4dAYVLeQ7Q02D0P
 Wn88TOYJesKIrPgSvgtE8k5civAXqTt9ANW+Pshcv/5fwFQweljl5UGiRjF9k1jGFxlP+1KFRsG
 ny7FXMt+rmGvchAPJX5Yij+w8QSyrdN9v6cHVBhs8SFOwgUzSCio0fqIbZGKCJS0=
X-Received: by 2002:a5d:5f50:0:b0:48d:ee31:a07b with SMTP id
 ffacd0b85a97d-48e385bae28mr2229320f8f.42.1792744802407; 
 Fri, 23 Oct 2026 01:40:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38026852sm3667140f8f.10.2026.10.23.01.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 01:40:01 -0700 (PDT)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 23 Oct 2026 08:39:59 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I88f37e47026a7d7ea0f7c6bde1d79d32c14e5297
X-Gerrit-Change-Number: 1450
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1450?usp=email>
X-Gerrit-Commit: 26a4059c325c565d529cbb6772bfa480c81ea9da
In-Reply-To: <gerrit.1766071205000.I88f37e47026a7d7ea0f7c6bde1d79d32c14e5297@gerrit.openvpn.net>
References: <gerrit.1766071205000.I88f37e47026a7d7ea0f7c6bde1d79d32c14e5297@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY2MDcxMjA1MDAwLkk4OGYzN2U0NzAyNmE3ZDdlYTBmN2M2YmRlMWQ3OWQzMmMxNGU1Mjk3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5c7bb0c287c43c708c014340db697b577b1688c5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xKAor-000000008Ce-39tO
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE: add DCO
 and iroutes support on server
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Marco Baffo \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3532335578704927520=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3532335578704927520==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WMcdmkZbZU0="; charset=UTF-8

--WMcdmkZbZU0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1450?usp=3Demail

to look at the new patch set (#=
13)=2E


Change subject: PUSH_UPDATE: add DCO and iroutes support on server=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

PUSH_UPDAT=
E: add DCO and iroutes support on server

Renamed update_vhash() to update_=
vaddr()=2E
Moved the -ifconfig logic from send_single_push_update() to upda=
te_vaddr()=2E
Changed canary logic to use the current ifconfig value, if pr=
esent=2E
Avoid re-learning unchanged addresses=2E

Added dco_multi_update_p=
eer_addr() and dco_update_peer_addr() to update
the peer's virtual addresse=
s in DCO after PUSH_UPDATE on Linux=2E

Added logic to reinstall DCO iroute=
s after changing the peer's virtual
addresses, keeping userspace iroutes=2E=

Split dco_delete_iroutes() into _v4() and _v6() to update iroutes per
addr=
ess family=2E

Skip DCO route installation when address learning fails, inc=
luding on
client connect=2E Restart the affected client and report failure =
when
the DCO peer address update fails=2E Skip PUSH_UPDATE for clients with=

a scheduled exit=2E

Change-Id: I88f37e47026a7d7ea0f7c6bde1d79d32c14e5297
=
Signed-off-by: Marco Baffo <marco@mandelbit=2Ecom>
---
M src/openvpn/dco=2E=
c
M src/openvpn/dco=2Eh
M src/openvpn/dco_freebsd=2Ec
M src/openvpn/dco_lin=
ux=2Ec
M src/openvpn/dco_win=2Ec
M src/openvpn/dco_win=2Eh
M src/openvpn/fo=
rward=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/ope=
nvpn=2Eh
M src/openvpn/push_util=2Ec
M tests/unit_tests/openvpn/mock_push_d=
ependencies=2Ec
12 files changed, 416 insertions(+), 107 deletions(-)


  g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/50/1450/13
=

diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index f3b5d44=2E=2E=
401ffea 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -676,=
6 +676,40 @@
     return 0;
 }
 
+int
+dco_multi_update_peer_addr(struct co=
ntext *c, int flags)
+{
+    if (!flags || c->c2=2Etls_multi->dco_peer_id =
=3D=3D -1)
+    {
+        return 0;
+    }
+
+    int peer_id =3D c->c2=2E=
tls_multi->dco_peer_id;
+
+    /* In server mode we need to fetch the remot=
e addresses from the push config */
+    struct in_addr vpn_ip4 =3D { 0 };
=
+    const struct in_addr *vpn_addr4 =3D NULL;
+    if (c->c2=2Epush_ifconf=
ig_defined)
+    {
+        vpn_ip4=2Es_addr =3D htonl(c->c2=2Epush_ifconfi=
g_local);
+        vpn_addr4 =3D &vpn_ip4;
+    }
+
+    const struct in6_a=
ddr *vpn_addr6 =3D NULL;
+    if (c->c2=2Epush_ifconfig_ipv6_defined)
+    =
{
+        vpn_addr6 =3D &c->c2=2Epush_ifconfig_ipv6_local;
+    }
+
+    i=
nt ret =3D dco_update_peer_addr(&c->c1=2Etuntap->dco, peer_id, vpn_addr4, v=
pn_addr6, flags);
+    if (ret < 0)
+    {
+        return ret;
+    }
+
+ =
   return 0;
+}
+
 void
 dco_install_iroute(struct multi_context *m, struct=
 multi_instance *mi, const struct mroute_addr *addr)
 {
@@ -706,8 +740,8 @@=

     if (addrtype =3D=3D MR_ADDR_IPV6)
     {
 #if defined(_WIN32)
-      =
  dco_win_add_iroute_ipv6(&c->c1=2Etuntap->dco, addr->v6=2Eaddr, addr->netb=
its,
-                                c->c2=2Etls_multi->rx_peer_id);
+    =
    bool installed =3D dco_win_add_iroute_ipv6(&c->c1=2Etuntap->dco, addr->=
v6=2Eaddr, addr->netbits,
+                                                =
 c->c2=2Etls_multi->rx_peer_id);
 #else
         const struct in6_addr *gat=
eway =3D &mi->context=2Ec2=2Epush_ifconfig_ipv6_local;
         if (addr->t=
ype & MR_ONLINK_DCO_ADDR)
@@ -715,16 +749,18 @@
             gateway =3D NU=
LL;
         }
 
-        net_route_v6_add(&m->top=2Enet_ctx, &addr->v6=2Ea=
ddr, addr->netbits,
-                         gateway, c->c1=2Etuntap->actu=
al_name, 0,
-                         DCO_IROUTE_METRIC);
+        bool ins=
talled =3D net_route_v6_add(&m->top=2Enet_ctx, &addr->v6=2Eaddr, addr->netb=
its,
+                                          gateway, c->c1=2Etuntap->ac=
tual_name, 0,
+                                          DCO_IROUTE_METRIC)=

+                         =3D=3D 0;
 #endif
+        mi->context=2Edid_dco=
_iroutes_v6 |=3D installed;
     }
     else if (addrtype =3D=3D MR_ADDR_IP=
V4)
     {
 #if defined(_WIN32)
-        dco_win_add_iroute_ipv4(&c->c1=2Et=
untap->dco, addr->v4=2Eaddr, addr->netbits,
-                              =
  c->c2=2Etls_multi->rx_peer_id);
+        bool installed =3D dco_win_add_i=
route_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Eaddr, addr->netbits,
+         =
                                        c->c2=2Etls_multi->rx_peer_id);
 #e=
lse
         in_addr_t dest =3D htonl(addr->v4=2Eaddr);
         const in_a=
ddr_t *gateway =3D &mi->context=2Ec2=2Epush_ifconfig_local;
@@ -733,15 +769=
,17 @@
             gateway =3D NULL;
         }
 
-        net_route_v4_ad=
d(&m->top=2Enet_ctx, &dest, addr->netbits, gateway,
-                      =
   c->c1=2Etuntap->actual_name, 0, DCO_IROUTE_METRIC);
+        bool instal=
led =3D net_route_v4_add(&m->top=2Enet_ctx, &dest, addr->netbits, gateway,
=
+                                          c->c1=2Etuntap->actual_name, 0, =
DCO_IROUTE_METRIC)
+                         =3D=3D 0;
 #endif
+        mi-=
>context=2Edid_dco_iroutes_v4 |=3D installed;
     }
 #endif /* if defined(=
TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */
 }
 
 void
-=
dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struct context *c)
+dc=
o_delete_iroutes_v4(openvpn_net_ctx_t *net_ctx, const struct context *c)
 {=

 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
 =
    if (!dco_enabled(&c->options))
@@ -750,7 +788,7 @@
     }
     ASSERT(T=
UNNEL_TYPE(c->c1=2Etuntap) =3D=3D DEV_TYPE_TUN);
 
-    msg(D_DCO, "DCO: at=
tempt removing iroutes from system table");
+    msg(D_DCO, "DCO: attempt r=
emoving IPv4 iroutes from system table");
 
     if (c->c2=2Epush_ifconfig_=
defined)
     {
@@ -778,6 +816,20 @@
         }
 #endif
     }
+#endif /* i=
f defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */
+}=

+
+void
+dco_delete_iroutes_v6(openvpn_net_ctx_t *net_ctx, const struct co=
ntext *c)
+{
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defin=
ed(_WIN32)
+    if (!dco_enabled(&c->options))
+    {
+        return;
+   =
 }
+    ASSERT(TUNNEL_TYPE(c->c1=2Etuntap) =3D=3D DEV_TYPE_TUN);
+
+    msg=
(D_DCO, "DCO: attempt removing IPv6 iroutes from system table");
 
     if =
(c->c2=2Epush_ifconfig_ipv6_defined)
     {
@@ -807,4 +859,11 @@
 #endif /*=
 if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */
=
 }
 
+void
+dco_delete_iroutes(openvpn_net_ctx_t *net_ctx, const struct con=
text *c)
+{
+    dco_delete_iroutes_v4(net_ctx, c);
+    dco_delete_iroutes=
_v6(net_ctx, c);
+}
+
 #endif /* defined(ENABLE_DCO) */
diff --git a/src/op=
envpn/dco=2Eh b/src/openvpn/dco=2Eh
index c435f8c=2E=2E3093ff5 100644
--- a=
/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -191,6 +191,31 @@
       =
           int keepalive_timeout, int mss);
 
 /**
+ * Update the peer's vi=
rtual address(es) in the DCO to the current value(s)
+ *
+ * @param dco    =
   DCO device context
+ * @param peerid    the ID of the peer to be modifie=
d
+ * @param vpn_ipv4  new IPv4 or NULL to remove the outdated one, only us=
ed when `(1 << AF_INET)` flag is present
+ * @param vpn_ipv6  new IPv6 or N=
ULL to remove the outdated one, only used when `(1 << AF_INET6)` flag is pr=
esent
+ * @param flags     `(1 << AF_INET)`, `(1 << AF_INET6)` or `(1 << AF=
_INET) | (1 << AF_INET6)` depending on which address has changed
+ * @retur=
n int      the DCO message status on success or a negative error code other=
wise
+ */
+int
+dco_update_peer_addr(dco_context_t *dco, unsigned int peeri=
d,
+                     const struct in_addr *vpn_ipv4, const struct in6_a=
ddr *vpn_ipv6,
+                     int flags);
+
+/**
+ * Update the peer=
's virtual address(es) in the DCO to the current value(s)
+ *
+ * @param c =
        peer context
+ * @param flags     `(1 << AF_INET)`, `(1 << AF_INET6=
)` or `(1 << AF_INET) | (1 << AF_INET6)` depending on which address has cha=
nged
+ * @return int      0 on success or a negative error code otherwise
+=
 */
+int
+dco_multi_update_peer_addr(struct context *c, int flags);
+
+/**
=
  * Remove a peer from DCO
  *
  * @param c         the main instance conte=
xt of the peer to remove
@@ -218,6 +243,22 @@
                         cons=
t struct mroute_addr *addr);
 
 /**
+ * Remove all IPv4 routes added throug=
h the specified client
+ *
+ * @param net_ctx   the iface networking contex=
t
+ * @param c         the client context for which routes have to be remov=
ed
+ */
+void dco_delete_iroutes_v4(openvpn_net_ctx_t *net_ctx, const struc=
t context *c);
+
+/**
+ * Remove all IPv6 routes added through the specifie=
d client
+ *
+ * @param net_ctx   the iface networking context
+ * @param c=
         the client context for which routes have to be removed
+ */
+void =
dco_delete_iroutes_v6(openvpn_net_ctx_t *net_ctx, const struct context *c);=

+
+/**
  * Remove all routes added through the specified client
  *
  * @p=
aram net_ctx   the iface networking context
@@ -344,6 +385,20 @@
     retur=
n 0;
 }
 
+static inline int
+dco_update_peer_addr(dco_context_t *dco, unsi=
gned int peerid,
+                     const struct in_addr *vpn_ipv4, cons=
t struct in6_addr *vpn_ipv6,
+                     int flags)
+{
+    retur=
n 0;
+}
+
+static inline int
+dco_multi_update_peer_addr(struct context *c,=
 int flags)
+{
+    return 0;
+}
+
 static inline void
 dco_remove_peer(str=
uct context *c)
 {
@@ -356,7 +411,17 @@
 }
 
 static inline void
-dco_insta=
ll_iroute(struct multi_context *m, struct multi_instance *mi, struct mroute=
_addr *addr)
+dco_install_iroute(struct multi_context *m, struct multi_inst=
ance *mi, const struct mroute_addr *addr)
+{
+}
+
+static inline void
+dco_=
delete_iroutes_v4(openvpn_net_ctx_t *net_ctx, const struct context *c)
+{
+=
}
+
+static inline void
+dco_delete_iroutes_v6(openvpn_net_ctx_t *net_ctx, =
const struct context *c)
 {
 }
 
diff --git a/src/openvpn/dco_freebsd=2Ec b=
/src/openvpn/dco_freebsd=2Ec
index 3148f10=2E=2Ed85104a 100644
--- a/src/op=
envpn/dco_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -559,6 +559,12 @=
@
     return ret;
 }
 
+int
+dco_update_peer_addr(dco_context_t *dco, unsi=
gned int peerid, const struct in_addr *vpn_ipv4, const struct in6_addr *vpn=
_ipv6, int flags)
+{
+    return 0;
+}
+
 static void
 dco_update_peer_stat=
(struct multi_context *m, uint32_t peerid, const nvlist_t *nvl)
 {
diff --g=
it a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index 4412ad0=2E=
=2E744d687 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_lin=
ux=2Ec
@@ -724,6 +724,50 @@
     return ret;
 }
 
+int
+dco_update_peer_add=
r(dco_context_t *dco, unsigned int peerid, const struct in_addr *vpn_ipv4, =
const struct in6_addr *vpn_ipv6, int flags)
+{
+    msg(D_DCO_DEBUG, "%s: p=
eer-id %u", __func__, peerid);
+
+    if (!flags)
+    {
+        return 0;=

+    }
+
+    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CM=
D_PEER_SET);
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
+  =
  struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);
+    int ret=
 =3D -EMSGSIZE;
+    NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);
+
+    if=
 (flags & (1 << AF_INET))
+    {
+        NLA_PUT_U32(nl_msg, OVPN_A_PEER_V=
PN_IPV4, vpn_ipv4 ? vpn_ipv4->s_addr : 0);
+    }
+
+    if (flags & (1 << =
AF_INET6))
+    {
+        struct in6_addr addr6;
+        if (!vpn_ipv6)
+=
        {
+            CLEAR(addr6);
+            vpn_ipv6 =3D &addr6;
+   =
     }
+        NLA_PUT(nl_msg, OVPN_A_PEER_VPN_IPV6, sizeof(struct in6_add=
r), vpn_ipv6);
+    }
+
+    nla_nest_end(nl_msg, attr);
+    ret =3D ovpn_=
nl_msg_send(dco, nl_msg, __func__);
+
+nla_put_failure:
+    nlmsg_free(nl_=
msg);
+    return ret;
+}
+
 /* This function parses the reply provided by =
the kernel to the CTRL_CMD_GETFAMILY
  * message=2E We parse the reply and =
we retrieve the multicast group ID associated
  * with the "ovpn-dco" netli=
nk family=2E
diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec=

index 12b0666=2E=2E8f7c8f62 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src=
/openvpn/dco_win=2Ec
@@ -519,6 +519,12 @@
 }
 
 int
+dco_update_peer_addr(d=
co_context_t *dco, unsigned int peerid, const struct in_addr *vpn_ipv4, con=
st struct in6_addr *vpn_ipv6, int flags)
+{
+    return 0;
+}
+
+int
 dco_n=
ew_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_slot_t s=
lot,
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv, co=
nst uint8_t *decrypt_key,
             const uint8_t *decrypt_iv, const cha=
r *ciphername, bool epoch)
@@ -1007,7 +1013,7 @@
     return dco_get_versio=
n(&ver) && ver=2EMajor >=3D 2;
 }
 
-void
+bool
 dco_win_add_iroute_ipv4(dc=
o_context_t *dco, in_addr_t dst, unsigned int netbits,
                    =
     unsigned int peer_id)
 {
@@ -1021,16 +1027,18 @@
         netbits, pee=
r_id);
 
     DWORD bytes_returned =3D 0;
-    if (!DeviceIoControl(dco->tt=
->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NULL, 0,
-        =
                 &bytes_returned, NULL))
+    bool installed =3D DeviceIoCo=
ntrol(dco->tt->hand, OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NULL,=
 0,
+                                     &bytes_returned, NULL);
+    if (=
!installed)
     {
         msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOC=
TL_MP_ADD_IROUTE) failed");
     }
 
     gc_free(&gc);
+    return install=
ed;
 }
 
-void
+bool
 dco_win_add_iroute_ipv6(dco_context_t *dco, struct in=
6_addr dst, unsigned int netbits,
                         unsigned int pee=
r_id)
 {
@@ -1042,13 +1050,15 @@
         netbits, peer_id);
 
     DWORD b=
ytes_returned =3D 0;
-    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP=
_ADD_IROUTE, &route, sizeof(route), NULL, 0,
-                         &byt=
es_returned, NULL))
+    bool installed =3D DeviceIoControl(dco->tt->hand, =
OVPN_IOCTL_MP_ADD_IROUTE, &route, sizeof(route), NULL, 0,
+                =
                     &bytes_returned, NULL);
+    if (!installed)
     {
  =
       msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_MP_ADD_IROUTE) fai=
led");
     }
 
     gc_free(&gc);
+    return installed;
 }
 
 void
diff -=
-git a/src/openvpn/dco_win=2Eh b/src/openvpn/dco_win=2Eh
index a92e5ad=2E=
=2E28795b7 100644
--- a/src/openvpn/dco_win=2Eh
+++ b/src/openvpn/dco_win=
=2Eh
@@ -67,10 +67,10 @@
 
 bool dco_win_supports_multipeer(void);
 
-void =
dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int net=
bits,
+bool dco_win_add_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsi=
gned int netbits,
                              unsigned int peer_id);
 
-v=
oid dco_win_add_iroute_ipv6(dco_context_t *dco, struct in6_addr dst, unsign=
ed int netbits,
+bool dco_win_add_iroute_ipv6(dco_context_t *dco, struct in=
6_addr dst, unsigned int netbits,
                              unsigned in=
t peer_id);
 
 void dco_win_del_iroute_ipv4(dco_context_t *dco, in_addr_t d=
st, unsigned int netbits);
diff --git a/src/openvpn/forward=2Ec b/src/openv=
pn/forward=2Ec
index 681210d=2E=2E7b6f4f8 100644
--- a/src/openvpn/forward=
=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -550,9 +550,10 @@
      * last connec=
ting client claiming the iroutes takes ownership=2E Therefore
      * they =
are not removed during delayed cleanup=2E
      */
-    if (c->did_dco_irou=
tes)
+    if (c->did_dco_iroutes_v4 || c->did_dco_iroutes_v6)
     {
-     =
   c->did_dco_iroutes =3D false;
+        c->did_dco_iroutes_v4 =3D false;
=
+        c->did_dco_iroutes_v6 =3D false;
         dco_delete_iroutes(&c->n=
et_ctx, c);
     }
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec
index e302a81=2E=2Ed1b3d16 100644
--- a/src/openvpn/multi=2Ec
+++ b/sr=
c/openvpn/multi=2Ec
@@ -478,6 +478,28 @@
     set_prefix(mi);
 }
 
+static =
void
+multi_del_dco_iroutes_v4(struct multi_context *m, struct multi_instan=
ce *mi)
+{
+    /* Skip DCO IPv4 iroutes that have already been removed=2E =
*/
+    if (mi->context=2Edid_dco_iroutes_v4)
+    {
+        mi->context=
=2Edid_dco_iroutes_v4 =3D false;
+        dco_delete_iroutes_v4(&m->top=2En=
et_ctx, &mi->context);
+    }
+}
+
+static void
+multi_del_dco_iroutes_v6(s=
truct multi_context *m, struct multi_instance *mi)
+{
+    /* Skip DCO IPv6=
 iroutes that have already been removed=2E */
+    if (mi->context=2Edid_dc=
o_iroutes_v6)
+    {
+        mi->context=2Edid_dco_iroutes_v6 =3D false;
+=
        dco_delete_iroutes_v6(&m->top=2Enet_ctx, &mi->context);
+    }
+}
+=

 /*
  * Tell the route helper about deleted iroutes so
  * that it can upd=
ate its mask of currently used
@@ -489,12 +511,8 @@
     const struct irout=
e *ir;
     const struct iroute_ipv6 *ir6;
 
-    /* check if DCO iroutes w=
ere already removed when scheduling a delayed exit */
-    if (mi->context=
=2Edid_dco_iroutes)
-    {
-        mi->context=2Edid_dco_iroutes =3D false=
;
-        dco_delete_iroutes(&m->top=2Enet_ctx, &mi->context);
-    }
+   =
 multi_del_dco_iroutes_v4(m, mi);
+    multi_del_dco_iroutes_v6(m, mi);
 
 =
    if (TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
     {
=
@@ -1211,8 +1229,12 @@
     }
 
     struct multi_instance *owner =3D multi=
_learn_addr(m, mi, &addr, MULTI_ROUTE_PERMANENT);
+    if (owner !=3D mi)
+=
    {
+        return owner;
+    }
 #ifdef ENABLE_MANAGEMENT
-    if (mana=
gement && owner)
+    if (management)
     {
         management_learn_addr=
(&mi->context=2Ec2=2Emda_context, &addr, primary);
     }
@@ -1256,8 +1278,=
12 @@
     }
 
     struct multi_instance *owner =3D multi_learn_addr(m, mi=
, &addr, MULTI_ROUTE_PERMANENT);
+    if (owner !=3D mi)
+    {
+        re=
turn owner;
+    }
 #ifdef ENABLE_MANAGEMENT
-    if (management && owner)
=
+    if (management)
     {
         management_learn_addr(&mi->context=2Ec=
2=2Emda_context, &addr, primary);
     }
@@ -1297,8 +1323,6 @@
     if (TUN=
NEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
     {
         mi=
->did_iroutes =3D true;
-        /* multi_learn_in{6}_addr_t takes care of =
installing the DCO iroute */
-        mi->context=2Edid_dco_iroutes =3D tru=
e;
         for (ir =3D mi->context=2Eoptions=2Eiroutes; ir !=3D NULL; ir =
=3D ir->next)
         {
             if (ir->netbits >=3D 0)
@@ -4409,9 +4=
433,10 @@
 }
 
 /* Function to unlearn previous ifconfig of a client in the=
 server multi_context after a PUSH_UPDATE */
-void
+static void
 unlearn_if=
config(struct multi_context *m, struct multi_instance *mi)
 {
+    multi_de=
l_dco_iroutes_v4(m, mi);
     in_addr_t old_addr =3D 0;
     old_addr =3D h=
tonl(mi->context=2Ec2=2Epush_ifconfig_local);
     multi_unlearn_in_addr_t(=
m, mi, old_addr);
@@ -4421,9 +4446,10 @@
 }
 
 /* Function to unlearn previ=
ous ifconfig-ipv6 of a client in the server multi_context after a PUSH_UPDA=
TE */
-void
+static void
 unlearn_ifconfig_ipv6(struct multi_context *m, st=
ruct multi_instance *mi)
 {
+    multi_del_dco_iroutes_v6(m, mi);
     stru=
ct in6_addr old_addr6;
     CLEAR(old_addr6);
     old_addr6 =3D mi->contex=
t=2Ec2=2Epush_ifconfig_ipv6_local;
@@ -4433,60 +4459,162 @@
     CLEAR(mi->=
reporting_addr_ipv6);
 }
 
+/* Reinstall only routes that are still owned b=
y this client=2E */
+static void
+multi_reinstall_owned_dco_iroute(struct m=
ulti_context *m, struct multi_instance *mi,
+                              =
   const struct mroute_addr *addr)
+{
+    const struct multi_route *route =
=3D hash_lookup(m->vhash, addr);
+    if (route && route->instance =3D=3D m=
i && multi_route_defined(m, route))
+    {
+        dco_install_iroute(m, m=
i, addr);
+    }
+}
+
+/* Userspace iroutes do not depend on the client's V=
PN address=2E Only their
+ * DCO routes need to be reinstalled when the gat=
eway changes=2E */
+static void
+multi_reinstall_dco_iroutes(struct multi_c=
ontext *m, struct multi_instance *mi, int flags)
+{
+    if ((flags & (1 <<=
 AF_INET)) && mi->context=2Ec2=2Epush_ifconfig_defined)
+    {
+        for=
 (const struct iroute *ir =3D mi->context=2Eoptions=2Eiroutes; ir; ir =3D i=
r->next)
+        {
+            struct mroute_addr addr =3D { 0 };
+      =
      mroute_extract_in_addr_t(&addr, ir->network);
+            addr=2Etyp=
e |=3D MR_WITH_NETBITS;
+            addr=2Enetbits =3D (uint8_t)ir->netbit=
s;
+            multi_reinstall_owned_dco_iroute(m, mi, &addr);
+        }
=
+    }
+
+    if ((flags & (1 << AF_INET6)) && mi->context=2Ec2=2Epush_ifco=
nfig_ipv6_defined)
+    {
+        for (const struct iroute_ipv6 *ir6 =3D m=
i->context=2Eoptions=2Eiroutes_ipv6; ir6; ir6 =3D ir6->next)
+        {
+  =
          struct mroute_addr addr =3D { 0 };
+            addr=2Etype =3D M=
R_ADDR_IPV6 | MR_WITH_NETBITS;
+            addr=2Elen =3D 16;
+           =
 addr=2Enetbits =3D (uint8_t)ir6->netbits;
+            addr=2Ev6=2Eaddr =
=3D ir6->network;
+            mroute_addr_mask_host_bits(&addr);
+        =
    multi_reinstall_owned_dco_iroute(m, mi, &addr);
+        }
+    }
+}
+
=
 /**
- * Update the vhash with new IP/IPv6 addresses in the multi_context w=
hen a
- * push-update message containing ifconfig/ifconfig-ipv6 options is =
sent
- * from the server=2E
+ * Update the vhash and DCO peer addresses whe=
n a push-update message containing
+ * ifconfig/ifconfig-ipv6 options is se=
nt from the server=2E Preserve userspace
+ * iroutes and reinstall their DC=
O routes with the new IP if needed=2E
  *
  * @param m         The multi_co=
ntext
  * @param mi        The multi_instance of the client we are updating=

- * @param new_ip    The new IPv4 address or NULL if no change
- * @param =
new_ipv6  The new IPv6 address or NULL if no change
+ * @param new_ip    Th=
e new IPv4 address, NULL for -ifconfig or the current IPv4 if no change
+ *=
 @param new_ipv6  The new IPv6 address, NULL for -ifconfig-ipv6 or the curr=
ent IPv6 if no change
  */
 void
-update_vhash(struct multi_context *m, str=
uct multi_instance *mi, const char *new_ip, const char *new_ipv6)
+update_v=
addr(struct multi_context *m, struct multi_instance *mi, const char *new_ip=
, const char *new_ipv6)
 {
+    /* Track changed address families to avoid =
resetting unchanged DCO addresses=2E */
+    int update_flags =3D 0;
+
+   =
 /* -ifconfig */
+    if (!new_ip && mi->context=2Ec2=2Epush_ifconfig_defin=
ed)
+    {
+        unlearn_ifconfig(m, mi);
+        update_flags |=3D (1 =
<< AF_INET);
+    }
+    /* -ifconfig-ipv6 */
+    if (!new_ipv6 && mi->con=
text=2Ec2=2Epush_ifconfig_ipv6_defined)
+    {
+        unlearn_ifconfig_ip=
v6(m, mi);
+        update_flags |=3D (1 << AF_INET6);
+    }
+
     if (ne=
w_ip)
     {
-        /* Remove old IP */
-        if (mi->context=2Ec2=2Ep=
ush_ifconfig_defined)
-        {
-            unlearn_ifconfig(m, mi);
-   =
     }
-
-        /* Add new IP */
         struct in_addr new_addr;
-     =
   CLEAR(new_addr);
         if (inet_pton(AF_INET, new_ip, &new_addr) =3D=
=3D 1
-            && multi_learn_in_addr_t(m, mi, ntohl(new_addr=2Es_addr)=
, -1, true))
+            && (!mi->context=2Ec2=2Epush_ifconfig_defined
+  =
              || ntohl(new_addr=2Es_addr) !=3D mi->context=2Ec2=2Epush_ifco=
nfig_local))
         {
+            /* Remove old IP */
+            if (m=
i->context=2Ec2=2Epush_ifconfig_defined)
+            {
+                un=
learn_ifconfig(m, mi);
+                update_flags |=3D (1 << AF_INET);
+=
            }
+
+            /* DCO needs the new address while installing =
its on-link route=2E */
             mi->context=2Ec2=2Epush_ifconfig_defin=
ed =3D true;
             mi->context=2Ec2=2Epush_ifconfig_local =3D ntohl(=
new_addr=2Es_addr);
-            /* set our client's VPN endpoint for statu=
s reporting purposes */
-            mi->reporting_addr =3D mi->context=2Ec=
2=2Epush_ifconfig_local;
+            if (multi_learn_in_addr_t(m, mi, mi->=
context=2Ec2=2Epush_ifconfig_local, -1, true) =3D=3D mi)
+            {
+  =
              /* set our client's VPN endpoint for status reporting purpose=
s */
+                mi->reporting_addr =3D mi->context=2Ec2=2Epush_ifconf=
ig_local;
+                update_flags |=3D (1 << AF_INET);
+            }=

+            else
+            {
+                mi->context=2Ec2=2Epush_=
ifconfig_defined =3D false;
+                mi->context=2Ec2=2Epush_ifconf=
ig_local =3D 0;
+            }
         }
     }
 
     if (new_ipv6)
     =
{
-        /* Remove old IPv6 */
-        if (mi->context=2Ec2=2Epush_ifcon=
fig_ipv6_defined)
-        {
-            unlearn_ifconfig_ipv6(m, mi);
-  =
      }
-
-        /* Add new IPv6 */
         struct in6_addr new_addr6;
-=
        CLEAR(new_addr6);
         if (inet_pton(AF_INET6, new_ipv6, &new_a=
ddr6) =3D=3D 1
-            && multi_learn_in6_addr(m, mi, new_addr6, -1, t=
rue))
+            && (!mi->context=2Ec2=2Epush_ifconfig_ipv6_defined
+    =
            || memcmp(&new_addr6, &mi->context=2Ec2=2Epush_ifconfig_ipv6_lo=
cal, sizeof(new_addr6))))
         {
+            /* Remove old IPv6 */
+  =
          if (mi->context=2Ec2=2Epush_ifconfig_ipv6_defined)
+            {=

+                unlearn_ifconfig_ipv6(m, mi);
+                update_fla=
gs |=3D (1 << AF_INET6);
+            }
+
+            /* DCO needs the new=
 address while installing its on-link route=2E */
             mi->context=
=2Ec2=2Epush_ifconfig_ipv6_defined =3D true;
             mi->context=2Ec2=
=2Epush_ifconfig_ipv6_local =3D new_addr6;
-            /* set our client's=
 VPN endpoint for status reporting purposes */
-            mi->reporting_a=
ddr_ipv6 =3D mi->context=2Ec2=2Epush_ifconfig_ipv6_local;
+            if (=
multi_learn_in6_addr(m, mi, new_addr6, -1, true) =3D=3D mi)
+            {
=
+                /* set our client's VPN endpoint for status reporting purp=
oses */
+                mi->reporting_addr_ipv6 =3D mi->context=2Ec2=2Epus=
h_ifconfig_ipv6_local;
+                update_flags |=3D (1 << AF_INET6);
=
+            }
+            else
+            {
+                mi->contex=
t=2Ec2=2Epush_ifconfig_ipv6_defined =3D false;
+                CLEAR(mi->c=
ontext=2Ec2=2Epush_ifconfig_ipv6_local);
+            }
         }
     }
+=

+    if (!update_flags || !dco_enabled(&m->top=2Eoptions))
+    {
+       =
 return;
+    }
+
+#if defined(TARGET_LINUX)
+    int ret =3D dco_multi_upd=
ate_peer_addr(&mi->context, update_flags);
+    if (ret < 0)
+    {
+      =
  msg(M_WARN, "MULTI: failed to update DCO peer addresses (error %d)", ret)=
;
+        /* PUSH_UPDATE is already queued, so reconnect to restore consis=
tent state=2E */
+        send_restart(&mi->context, NULL);
+        multi_=
schedule_context_wakeup(m, mi);
+        return;
+    }
+#endif
+
+    if (=
TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
+    {
+       =
 multi_reinstall_dco_iroutes(m, mi, update_flags);
+    }
 }
 
 bool
diff -=
-git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 5db7147=2E=2E010=
fb9b 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -730=
,8 +730,6 @@
 #endif
 
 void
-update_vhash(struct multi_context *m, struct =
multi_instance *mi, const char *new_ip, const char *new_ipv6);
-void unlear=
n_ifconfig(struct multi_context *m, struct multi_instance *mi);
-void unlea=
rn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi);
+upda=
te_vaddr(struct multi_context *m, struct multi_instance *mi, const char *ne=
w_ip, const char *new_ipv6);
 
 #endif /* MULTI_H */
diff --git a/src/openv=
pn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index cdd02b6=2E=2E72436fe 100644
=
--- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -507,7 +507,=
8 @@
     bool did_we_daemonize;       /**< Whether demonization has alread=
y
                                   *   taken place=2E */
 
-    bool did_=
dco_iroutes;        /**< Whether DCO iroutes have been installed */
+    bo=
ol did_dco_iroutes_v4;     /**< Whether DCO IPv4 iroutes have been installe=
d */
+    bool did_dco_iroutes_v6;     /**< Whether DCO IPv6 iroutes have b=
een installed */
 
     struct context_persist persist;
     /**< Persisten=
t %context=2E */
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_=
util=2Ec
index 34cb26c=2E=2E05e4cbb 100644
--- a/src/openvpn/push_util=2Ec
=
+++ b/src/openvpn/push_util=2Ec
@@ -149,14 +149,35 @@
     struct options o=
;
     CLEAR(o);
 
-    /* Set canary values to detect ifconfig options in =
push-update messages=2E
-     * These placeholder strings will be overwritt=
en to NULL by the option
-     * parser if -ifconfig or -ifconfig-ipv6 opti=
ons are present in the
-     * push-update=2E
+    /* Set canary values to =
detect -ifconfig and -ifconfig-ipv6 options in
+     * push-update messages=
=2E These placeholder strings will be overwritten
+     * to NULL by the op=
tion parser if -ifconfig or -ifconfig-ipv6 options
+     * are present in t=
he push-update, to the new value if present, or
+     * they will remain eq=
ual to the current values otherwise=2E
+     * If the current values are no=
t defined they will remain NULL=2E
      */
-    const char *canary =3D "ca=
nary";
-    o=2Eifconfig_local =3D canary;
-    o=2Eifconfig_ipv6_local =3D=
 canary;
+
+    char ifconfig_local[INET_ADDRSTRLEN];
+    struct in_addr a=
ddr4 =3D { =2Es_addr =3D htonl(mi->context=2Ec2=2Epush_ifconfig_local) };
+=
    if (mi->context=2Ec2=2Epush_ifconfig_defined)
+    {
+        if (!inet=
_ntop(AF_INET, &addr4, ifconfig_local, sizeof(ifconfig_local)))
+        {
=
+            return false;
+        }
+        o=2Eifconfig_local =3D ifcon=
fig_local;
+    }
+
+    char ifconfig_ipv6_local[INET6_ADDRSTRLEN];
+    i=
f (mi->context=2Ec2=2Epush_ifconfig_ipv6_defined)
+    {
+        if (!inet=
_ntop(AF_INET6, &mi->context=2Ec2=2Epush_ifconfig_ipv6_local,
+            =
           ifconfig_ipv6_local, sizeof(ifconfig_ipv6_local)))
+        {
+ =
           return false;
+        }
+        o=2Eifconfig_ipv6_local =3D if=
config_ipv6_local;
+    }
 
     struct buffer_entry *e =3D msgs->head;
   =
  while (e)
@@ -194,28 +215,9 @@
 
     if (option_types_found & OPT_P_UP)
=
     {
-        /* -ifconfig */
-        if (!o=2Eifconfig_local && mi->con=
text=2Ec2=2Epush_ifconfig_defined)
-        {
-            unlearn_ifconfig=
(m, mi);
-        }
-        /* -ifconfig-ipv6 */
-        if (!o=2Eifconfi=
g_ipv6_local && mi->context=2Ec2=2Epush_ifconfig_ipv6_defined)
-        {
-=
            unlearn_ifconfig_ipv6(m, mi);
-        }
-
-        if (o=2Eifc=
onfig_local && !strcmp(o=2Eifconfig_local, canary))
-        {
-           =
 o=2Eifconfig_local =3D NULL;
-        }
-        if (o=2Eifconfig_ipv6_loc=
al && !strcmp(o=2Eifconfig_ipv6_local, canary))
-        {
-            o=
=2Eifconfig_ipv6_local =3D NULL;
-        }
-
-        /* new ifconfig or n=
ew ifconfig-ipv6 */
-        update_vhash(m, mi, o=2Eifconfig_local, o=2Eif=
config_ipv6_local);
+        /* ifconfig or ifconfig-ipv6 */
+        updat=
e_vaddr(m, mi, o=2Eifconfig_local, o=2Eifconfig_ipv6_local);
+        retur=
n !event_timeout_defined(&c->c2=2Escheduled_exit);
     }
 
     uninit_opt=
ions(&o);
@@ -253,12 +255,14 @@
 static int
 send_push_update(struct multi_=
context *m, const void *target, const char *msg, const push_update_type typ=
e, const size_t push_bundle_size)
 {
+#if !defined(TARGET_LINUX)
     if (d=
co_enabled(&m->top=2Eoptions))
     {
         msg(M_WARN, "WARN: PUSH_UPDA=
TE messages cannot currently be sent while DCO is enabled=2E"
             =
        " To send a PUSH_UPDATE message, be sure to use the --disable-dco o=
ption=2E");
         return 0;
     }
+#endif
 
     if (!msg || !*msg || !=
m || (!target && type !=3D UPT_BROADCAST))
     {
@@ -301,6 +305,7 @@
     =
    }
 
         if (!mi->halt
+            && !event_timeout_defined(&mi->=
context=2Ec2=2Escheduled_exit)
             && send_single_push_update(m, m=
i, msgs))
         {
             buffer_list_free(msgs);
@@ -321,7 +326,9 =
@@
     {
         struct multi_instance *curr_mi =3D m->instances[i];
 
- =
       if (!curr_mi || curr_mi->halt || !support_push_update(curr_mi))
+   =
     if (!curr_mi || curr_mi->halt
+            || event_timeout_defined(&c=
urr_mi->context=2Ec2=2Escheduled_exit)
+            || !support_push_update=
(curr_mi))
         {
             continue;
         }
diff --git a/tests/=
unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/openvpn/mo=
ck_push_dependencies=2Ec
index bf2ccf3=2E=2Ec951a8f 100644
--- a/tests/unit=
_tests/openvpn/mock_push_dependencies=2Ec
+++ b/tests/unit_tests/openvpn/mo=
ck_push_dependencies=2Ec
@@ -48,17 +48,7 @@
 }
 
 void
-unlearn_ifconfig(st=
ruct multi_context *m, struct multi_instance *mi)
-{
-}
-
-void
-unlearn_if=
config_ipv6(struct multi_context *m, struct multi_instance *mi)
-{
-}
-
-vo=
id
-update_vhash(struct multi_context *m, struct multi_instance *mi, const =
char *new_ip, const char *new_ipv6)
+update_vaddr(struct multi_context *m, =
struct multi_instance *mi, const char *new_ip, const char *new_ipv6)
 {
 }
=
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1450?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I88f37e4702=
6a7d7ea0f7c6bde1d79d32c14e5297
Gerrit-Change-Number: 1450
Gerrit-PatchSet: =
13
Gerrit-Owner: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>

--WMcdmkZbZU0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Marco Baffo <strong>uploaded =
patch set #13</strong> to this change=2E</p><p><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1450?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">PUSH_UPDATE: add DCO and iroutes support on server<br><br>Renamed updat=
e_vhash() to update_vaddr()=2E<br>Moved the -ifconfig logic from send_singl=
e_push_update() to update_vaddr()=2E<br>Changed canary logic to use the cur=
rent ifconfig value, if present=2E<br>Avoid re-learning unchanged addresses=
=2E<br><br>Added dco_multi_update_peer_addr() and dco_update_peer_addr() to=
 update<br>the peer&#39;s virtual addresses in DCO after PUSH_UPDATE on Lin=
ux=2E<br><br>Added logic to reinstall DCO iroutes after changing the peer&#=
39;s virtual<br>addresses, keeping userspace iroutes=2E<br>Split dco_delete=
_iroutes() into _v4() and _v6() to update iroutes per<br>address family=2E<=
br><br>Skip DCO route installation when address learning fails, including o=
n<br>client connect=2E Restart the affected client and report failure when<=
br>the DCO peer address update fails=2E Skip PUSH_UPDATE for clients with<b=
r>a scheduled exit=2E<br><br>Change-Id: I88f37e47026a7d7ea0f7c6bde1d79d32c1=
4e5297<br>Signed-off-by: Marco Baffo &lt;marco@mandelbit=2Ecom&gt;<br>---<b=
r>M src/openvpn/dco=2Ec<br>M src/openvpn/dco=2Eh<br>M src/openvpn/dco_freeb=
sd=2Ec<br>M src/openvpn/dco_linux=2Ec<br>M src/openvpn/dco_win=2Ec<br>M src=
/openvpn/dco_win=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn/multi=2E=
c<br>M src/openvpn/multi=2Eh<br>M src/openvpn/openvpn=2Eh<br>M src/openvpn/=
push_util=2Ec<br>M tests/unit_tests/openvpn/mock_push_dependencies=2Ec<br>1=
2 files changed, 416 insertions(+), 107 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/50/14=
50/13</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span>=
<br><span>index f3b5d44=2E=2E401ffea 100644</span><br><span>--- a/src/openv=
pn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -67=
6,6 +676,40 @@</span><br><span>     return 0;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+dco_multi_update_peer_addr(s=
truct context *c, int flags)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
flags || c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D=3D -1)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int peer=
_id =3D c-&gt;c2=2Etls_multi-&gt;dco_peer_id;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* In server mode we need to fetch the remote addresses from the=
 push config */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct in_addr vpn_ip4 =3D { 0 };</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const struct in_addr *vpn_addr4 =3D NULL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2=2Epush_ifconfig_de=
fined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        vpn_ip4=2Es_addr =
=3D htonl(c-&gt;c2=2Epush_ifconfig_local);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        vpn_addr4 =3D &amp;vpn_ip4;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const struct in6_addr *vpn_addr6 =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2=2Epush_ifconfig_ipv6_def=
ined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        vpn_addr6 =3D &amp;c=
-&gt;c2=2Epush_ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D d=
co_update_peer_addr(&amp;c-&gt;c1=2Etuntap-&gt;dco, peer_id, vpn_addr4, vpn=
_addr6, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return ret=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> void</span><br><span> dco_install_iroute(struct multi_con=
text *m, struct multi_instance *mi, const struct mroute_addr *addr)</span><=
br><span> {</span><br><span>@@ -706,8 +740,8 @@</span><br><span>     if (ad=
drtype =3D=3D MR_ADDR_IPV6)</span><br><span>     {</span><br><span> #if def=
ined(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        d=
co_win_add_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v6=2Eaddr, =
addr-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                            c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        bool installed =3D dc=
o_win_add_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v6=2Eaddr, a=
ddr-&gt;netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                              c-&gt;c2=2Etls_multi-&gt;rx_p=
eer_id);</span><br><span> #else</span><br><span>         const struct in6_a=
ddr *gateway =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</span=
><br><span>         if (addr-&gt;type &amp; MR_ONLINK_DCO_ADDR)</span><br><=
span>@@ -715,16 +749,18 @@</span><br><span>             gateway =3D NULL;</=
span><br><span>         }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        net_route_v6_add(&amp;m-&gt;top=2Enet_ctx, &a=
mp;addr-&gt;v6=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                         gateway, c-&gt;c1=2Etuntap-&gt;=
actual_name, 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                   DCO_IROUTE_METRIC);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        bool installed =3D net_route_v6_add(&amp;m-&gt;t=
op=2Enet_ctx, &amp;addr-&gt;v6=2Eaddr, addr-&gt;netbits,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
    gateway, c-&gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                          DC=
O_IROUTE_METRIC)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                      =3D=3D 0;</span><br><span> #endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context=2Edid_dco_iroute=
s_v6 |=3D installed;</span><br><span>     }</span><br><span>     else if (a=
ddrtype =3D=3D MR_ADDR_IPV4)</span><br><span>     {</span><br><span> #if de=
fined(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
dco_win_add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v4=2Eaddr,=
 addr-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                             c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        bool installed =3D d=
co_win_add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v4=2Eaddr, =
addr-&gt;netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                               c-&gt;c2=2Etls_multi-&gt;rx_=
peer_id);</span><br><span> #else</span><br><span>         in_addr_t dest =
=3D htonl(addr-&gt;v4=2Eaddr);</span><br><span>         const in_addr_t *ga=
teway =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_local;</span><br><span>@=
@ -733,15 +769,17 @@</span><br><span>             gateway =3D NULL;</span><=
br><span>         }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        net_route_v4_add(&amp;m-&gt;top=2Enet_ctx, &amp;des=
t, addr-&gt;netbits, gateway,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                         c-&gt;c1=2Etuntap-&gt;actual_name, 0, DCO_=
IROUTE_METRIC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    bool installed =3D net_route_v4_add(&amp;m-&gt;top=2Enet_ctx, &amp;dest=
, addr-&gt;netbits, gateway,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                          c-&gt;c1=2Etuntap-&gt;ac=
tual_name, 0, DCO_IROUTE_METRIC)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                         =3D=3D 0;</span><br><span> #endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context=
=2Edid_dco_iroutes_v4 |=3D installed;</span><br><span>     }</span><br><spa=
n> #endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined=
(_WIN32) */</span><br><span> }</span><br><span> </span><br><span> void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_delete_iroutes(openvpn=
_net_ctx_t *net_ctx, const struct context *c)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+dco_delete_iroutes_v4(openvpn_net_ctx_t *net_ctx,=
 const struct context *c)</span><br><span> {</span><br><span> #if defined(T=
ARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)</span><br><span>=
     if (!dco_enabled(&amp;c-&gt;options))</span><br><span>@@ -750,7 +788,7=
 @@</span><br><span>     }</span><br><span>     ASSERT(TUNNEL_TYPE(c-&gt;c1=
=2Etuntap) =3D=3D DEV_TYPE_TUN);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    msg(D_DCO, &quot;DCO: attempt removing iro=
utes from system table&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    msg(D_DCO, &quot;DCO: attempt removing IPv4 iroutes from sys=
tem table&quot;);</span><br><span> </span><br><span>     if (c-&gt;c2=2Epus=
h_ifconfig_defined)</span><br><span>     {</span><br><span>@@ -778,6 +816,2=
0 @@</span><br><span>         }</span><br><span> #endif</span><br><span>   =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if def=
ined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32) */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_=
delete_iroutes_v6(openvpn_net_ctx_t *net_ctx, const struct context *c)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARG=
ET_FREEBSD) || defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!dco_enabled(&amp;c-&gt;options))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ASSERT(TUNNEL_TYPE(c-&gt;c1=2Etuntap) =3D=3D DEV_TYPE_TUN);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    msg(D_DCO, &quot;DCO: attempt removing IPv6 =
iroutes from system table&quot;);</span><br><span> </span><br><span>     if=
 (c-&gt;c2=2Epush_ifconfig_ipv6_defined)</span><br><span>     {</span><br><=
span>@@ -807,4 +859,11 @@</span><br><span> #endif /* if defined(TARGET_LINU=
X) || defined(TARGET_FREEBSD) || defined(_WIN32) */</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_delete_iroutes(op=
envpn_net_ctx_t *net_ctx, const struct context *c)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    dco_delete_iroutes_v4(net_ctx, c);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    dco_delete_iroutes_v6(net_ctx, c);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* defined(ENAB=
LE_DCO) */</span><br><span>diff --git a/src/openvpn/dco=2Eh b/src/openvpn/d=
co=2Eh</span><br><span>index c435f8c=2E=2E3093ff5 100644</span><br><span>--=
- a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/openvpn/dco=2Eh</span><br=
><span>@@ -191,6 +191,31 @@</span><br><span>                  int keepalive=
_timeout, int mss);</span><br><span> </span><br><span> /**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Update the peer&#39;s virtual add=
ress(es) in the DCO to the current value(s)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param dco       DCO device context</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param peerid    the ID of the peer to be modi=
fied</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param vpn_i=
pv4  new IPv4 or NULL to remove the outdated one, only used when `(1 &lt;&l=
t; AF_INET)` flag is present</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param vpn_ipv6  new IPv6 or NULL to remove the outdated one, o=
nly used when `(1 &lt;&lt; AF_INET6)` flag is present</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param flags     `(1 &lt;&lt; AF_INET)=
`, `(1 &lt;&lt; AF_INET6)` or `(1 &lt;&lt; AF_INET) | (1 &lt;&lt; AF_INET6)=
` depending on which address has changed</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @return int      the DCO message status on success =
or a negative error code otherwise</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_update_peer_a=
ddr(dco_context_t *dco, unsigned int peerid,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                     const struct in_addr *vpn_ipv=
4, const struct in6_addr *vpn_ipv6,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                     int flags);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Upd=
ate the peer&#39;s virtual address(es) in the DCO to the current value(s)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param c         peer context</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param flags     `(1 &=
lt;&lt; AF_INET)`, `(1 &lt;&lt; AF_INET6)` or `(1 &lt;&lt; AF_INET) | (1 &l=
t;&lt; AF_INET6)` depending on which address has changed</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @return int      0 on success or a =
negative error code otherwise</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_multi_update_peer_=
addr(struct context *c, int flags);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span>  * Remove a peer from DCO</span><br><span>  *</span><br><=
span>  * @param c         the main instance context of the peer to remove</=
span><br><span>@@ -218,6 +243,22 @@</span><br><span>                       =
  const struct mroute_addr *addr);</span><br><span> </span><br><span> /**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Remove all IPv4 ro=
utes added through the specified client</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param net_ctx   the iface networking context</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param c         the client context fo=
r which routes have to be removed</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id dco_delete_iroutes_v4(openvpn_net_ctx_t *net_ctx, const struct context *=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Remove all IPv6 routes added through the specifi=
ed client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param net_ctx   the ifa=
ce networking context</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param c         the client context for which routes have to be remove=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void dco_delete_iroutes_v6(openvpn=
_net_ctx_t *net_ctx, const struct context *c);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span>  * Remove all routes added through the specifi=
ed client</span><br><span>  *</span><br><span>  * @param net_ctx   the ifac=
e networking context</span><br><span>@@ -344,6 +385,20 @@</span><br><span> =
    return 0;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static inline int</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+dco_update_peer_addr(dco_context_t *dco, unsig=
ned int peerid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                 const struct in_addr *vpn_ipv4, const struct in6_addr *vpn=
_ipv6,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
        int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static inline int</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+dco_multi_update_peer_addr(struct context *c, int flags)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> static inline void</span><br><span> dco_remove_=
peer(struct context *c)</span><br><span> {</span><br><span>@@ -356,7 +411,1=
7 @@</span><br><span> }</span><br><span> </span><br><span> static inline vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_install_iroute(=
struct multi_context *m, struct multi_instance *mi, struct mroute_addr *add=
r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_install_irout=
e(struct multi_context *m, struct multi_instance *mi, const struct mroute_a=
ddr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static inline void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+dco_delete_iroutes_v4(openvpn_net_ctx_t *net_ctx, const struct co=
ntext *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static inline void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+dco_delete_iroutes_v6(openvpn_net_ctx_t *net_ctx, const struct con=
text *c)</span><br><span> {</span><br><span> }</span><br><span> </span><br>=
<span>diff --git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2E=
c</span><br><span>index 3148f10=2E=2Ed85104a 100644</span><br><span>--- a/s=
rc/openvpn/dco_freebsd=2Ec</span><br><span>+++ b/src/openvpn/dco_freebsd=2E=
c</span><br><span>@@ -559,6 +559,12 @@</span><br><span>     return ret;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dc=
o_update_peer_addr(dco_context_t *dco, unsigned int peerid, const struct in=
_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6, int flags)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> static void</span><br><span> dco_update_peer_stat(struct m=
ulti_context *m, uint32_t peerid, const nvlist_t *nvl)</span><br><span> {</=
span><br><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_lin=
ux=2Ec</span><br><span>index 4412ad0=2E=2E744d687 100644</span><br><span>--=
- a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=
=2Ec</span><br><span>@@ -724,6 +724,50 @@</span><br><span>     return ret;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+dco_update_peer_addr(dco_context_t *dco, unsigned int peerid, const struct=
 in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6, int flags)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %u&quot;, =
__func__, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!flags)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_SE=
T);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!nl_msg)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return -ENOMEM;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PE=
ER);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D=
 -EMSGSIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NLA_=
PUT_U32(nl_msg, OVPN_A_PEER_ID, peerid);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (flags &amp; (1 &lt;&lt; AF_INET))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        NLA_PUT_U32(nl_msg, OVPN_A_PEER_VPN_IPV4, vpn_ipv4 ? vpn_=
ipv4-&gt;s_addr : 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp; (1 &lt;&lt;=
 AF_INET6))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct in6_add=
r addr6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(!vpn_ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            CLEAR(=
addr6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
vpn_ipv6 =3D &amp;addr6;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   NLA_PUT(nl_msg, OVPN_A_PEER_VPN_IPV6, sizeof(struct in6_addr), vpn_ipv6)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    nla_nest_end(nl_msg, attr);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ret =3D ovpn_nl_msg_send(dco, nl_ms=
g, __func__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+nla_put_failure:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    nlmsg_free(nl_msg);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> /* This function parses the =
reply provided by the kernel to the CTRL_CMD_GETFAMILY</span><br><span>  * =
message=2E We parse the reply and we retrieve the multicast group ID associ=
ated</span><br><span>  * with the &quot;ovpn-dco&quot; netlink family=2E</s=
pan><br><span>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2E=
c</span><br><span>index 12b0666=2E=2E8f7c8f62 100644</span><br><span>--- a/=
src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</span=
><br><span>@@ -519,6 +519,12 @@</span><br><span> }</span><br><span> </span>=
<br><span> int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_u=
pdate_peer_addr(dco_context_t *dco, unsigned int peerid, const struct in_ad=
dr *vpn_ipv4, const struct in6_addr *vpn_ipv6, int flags)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span> dc=
o_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_slot_=
t slot,</span><br><span>             const uint8_t *encrypt_key, const uint=
8_t *encrypt_iv, const uint8_t *decrypt_key,</span><br><span>             c=
onst uint8_t *decrypt_iv, const char *ciphername, bool epoch)</span><br><sp=
an>@@ -1007,7 +1013,7 @@</span><br><span>     return dco_get_version(&amp;v=
er) &amp;&amp; ver=2EMajor &gt;=3D 2;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span> dco_win_add_iro=
ute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int netbits,</span><br=
><span>                         unsigned int peer_id)</span><br><span> {</s=
pan><br><span>@@ -1021,16 +1027,18 @@</span><br><span>         netbits, pee=
r_id);</span><br><span> </span><br><span>     DWORD bytes_returned =3D 0;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!DeviceIoContro=
l(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_ADD_IROUTE, &amp;route, sizeof(route),=
 NULL, 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
             &amp;bytes_returned, NULL))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    bool installed =3D DeviceIoControl(dco-&gt;tt-&gt;=
hand, OVPN_IOCTL_MP_ADD_IROUTE, &amp;route, sizeof(route), NULL, 0,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
          &amp;bytes_returned, NULL);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!installed)</span><br><span>     {</span><br><spa=
n>         msg(M_WARN | M_ERRNO, &quot;DeviceIoControl(OVPN_IOCTL_MP_ADD_IR=
OUTE) failed&quot;);</span><br><span>     }</span><br><span> </span><br><sp=
an>     gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return installed;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bool</span><br><span> dco_win_add_iroute_ipv6(d=
co_context_t *dco, struct in6_addr dst, unsigned int netbits,</span><br><sp=
an>                         unsigned int peer_id)</span><br><span> {</span>=
<br><span>@@ -1042,13 +1050,15 @@</span><br><span>         netbits, peer_id=
);</span><br><span> </span><br><span>     DWORD bytes_returned =3D 0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!DeviceIoControl(dc=
o-&gt;tt-&gt;hand, OVPN_IOCTL_MP_ADD_IROUTE, &amp;route, sizeof(route), NUL=
L, 0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
         &amp;bytes_returned, NULL))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    bool installed =3D DeviceIoControl(dco-&gt;tt-&gt;hand=
, OVPN_IOCTL_MP_ADD_IROUTE, &amp;route, sizeof(route), NULL, 0,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
      &amp;bytes_returned, NULL);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (!installed)</span><br><span>     {</span><br><span>  =
       msg(M_WARN | M_ERRNO, &quot;DeviceIoControl(OVPN_IOCTL_MP_ADD_IROUTE=
) failed&quot;);</span><br><span>     }</span><br><span> </span><br><span> =
    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return installed;</span><br><span> }</span><br><span> </span><br><spa=
n> void</span><br><span>diff --git a/src/openvpn/dco_win=2Eh b/src/openvpn/=
dco_win=2Eh</span><br><span>index a92e5ad=2E=2E28795b7 100644</span><br><sp=
an>--- a/src/openvpn/dco_win=2Eh</span><br><span>+++ b/src/openvpn/dco_win=
=2Eh</span><br><span>@@ -67,10 +67,10 @@</span><br><span> </span><br><span>=
 bool dco_win_supports_multipeer(void);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void dco_win_add_iroute_ipv4(dco_contex=
t_t *dco, in_addr_t dst, unsigned int netbits,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool dco_win_add_iroute_ipv4(dco_context_t *dco,=
 in_addr_t dst, unsigned int netbits,</span><br><span>                     =
         unsigned int peer_id);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-void dco_win_add_iroute_ipv6(dco_context_t *dco=
, struct in6_addr dst, unsigned int netbits,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool dco_win_add_iroute_ipv6(dco_context_t *dco, s=
truct in6_addr dst, unsigned int netbits,</span><br><span>                 =
             unsigned int peer_id);</span><br><span> </span><br><span> void=
 dco_win_del_iroute_ipv4(dco_context_t *dco, in_addr_t dst, unsigned int ne=
tbits);</span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/=
forward=2Ec</span><br><span>index 681210d=2E=2E7b6f4f8 100644</span><br><sp=
an>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=
=2Ec</span><br><span>@@ -550,9 +550,10 @@</span><br><span>      * last conn=
ecting client claiming the iroutes takes ownership=2E Therefore</span><br><=
span>      * they are not removed during delayed cleanup=2E</span><br><span=
>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&g=
t;did_dco_iroutes)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (c-&gt;did_dco_iroutes_v4 || c-&gt;did_dco_iroutes_v6)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt=
;did_dco_iroutes =3D false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        c-&gt;did_dco_iroutes_v4 =3D false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        c-&gt;did_dco_iroutes_v6 =3D fals=
e;</span><br><span>         dco_delete_iroutes(&amp;c-&gt;net_ctx, c);</spa=
n><br><span>     }</span><br><span> </span><br><span>diff --git a/src/openv=
pn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index e302a81=2E=2Ed1b=
3d16 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++=
 b/src/openvpn/multi=2Ec</span><br><span>@@ -478,6 +478,28 @@</span><br><sp=
an>     set_prefix(mi);</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_del_dco_iroutes_v4(struct multi_con=
text *m, struct multi_instance *mi)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* Skip DCO IPv4 iroutes that have already been removed=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Edid_dc=
o_iroutes_v4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;conte=
xt=2Edid_dco_iroutes_v4 =3D false;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        dco_delete_iroutes_v4(&amp;m-&gt;top=2Enet_ctx, &amp=
;mi-&gt;context);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+multi_del_dco_iroutes_v6(struct multi_context *m, struct mult=
i_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Skip DCO IPv6 i=
routes that have already been removed=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Edid_dco_iroutes_v6)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context=2Edid_dco_iroutes=
_v6 =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   dco_delete_iroutes_v6(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&gt;context);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Tell the rout=
e helper about deleted iroutes so</span><br><span>  * that it can update it=
s mask of currently used</span><br><span>@@ -489,12 +511,8 @@</span><br><sp=
an>     const struct iroute *ir;</span><br><span>     const struct iroute_i=
pv6 *ir6;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* check if DCO iroutes were already removed when scheduling a de=
layed exit */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
mi-&gt;context=2Edid_dco_iroutes)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    mi-&gt;context=2Edid_dco_iroutes =3D false;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        dco_delete_iroutes(&amp;m-&gt;top=2Enet_c=
tx, &amp;mi-&gt;context);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_=
del_dco_iroutes_v4(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    multi_del_dco_iroutes_v6(m, mi);</span><br><span> </span><br><sp=
an>     if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)<=
/span><br><span>     {</span><br><span>@@ -1211,8 +1229,12 @@</span><br><sp=
an>     }</span><br><span> </span><br><span>     struct multi_instance *own=
er =3D multi_learn_addr(m, mi, &amp;addr, MULTI_ROUTE_PERMANENT);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (owner !=3D mi)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return owner;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #ifdef ENABLE_M=
ANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mana=
gement &amp;&amp; owner)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (management)</span><br><span>     {</span><br><span>         ma=
nagement_learn_addr(&amp;mi-&gt;context=2Ec2=2Emda_context, &amp;addr, prim=
ary);</span><br><span>     }</span><br><span>@@ -1256,8 +1278,12 @@</span><=
br><span>     }</span><br><span> </span><br><span>     struct multi_instanc=
e *owner =3D multi_learn_addr(m, mi, &amp;addr, MULTI_ROUTE_PERMANENT);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (owner !=3D mi)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return owner;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #ifdef EN=
ABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (management &amp;&amp; owner)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (management)</span><br><span>     {</span><br><span>     =
    management_learn_addr(&amp;mi-&gt;context=2Ec2=2Emda_context, &amp;addr=
, primary);</span><br><span>     }</span><br><span>@@ -1297,8 +1323,6 @@</s=
pan><br><span>     if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV=
_TYPE_TUN)</span><br><span>     {</span><br><span>         mi-&gt;did_irout=
es =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /=
* multi_learn_in{6}_addr_t takes care of installing the DCO iroute */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;context=2Edi=
d_dco_iroutes =3D true;</span><br><span>         for (ir =3D mi-&gt;context=
=2Eoptions=2Eiroutes; ir !=3D NULL; ir =3D ir-&gt;next)</span><br><span>   =
      {</span><br><span>             if (ir-&gt;netbits &gt;=3D 0)</span><b=
r><span>@@ -4409,9 +4433,10 @@</span><br><span> }</span><br><span> </span><=
br><span> /* Function to unlearn previous ifconfig of a client in the serve=
r multi_context after a PUSH_UPDATE */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span> unlearn_ifconfig(struct multi_context *m, st=
ruct multi_instance *mi)</span><br><span> {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    multi_del_dco_iroutes_v4(m, mi);</span><br><spa=
n>     in_addr_t old_addr =3D 0;</span><br><span>     old_addr =3D htonl(mi=
-&gt;context=2Ec2=2Epush_ifconfig_local);</span><br><span>     multi_unlear=
n_in_addr_t(m, mi, old_addr);</span><br><span>@@ -4421,9 +4446,10 @@</span>=
<br><span> }</span><br><span> </span><br><span> /* Function to unlearn prev=
ious ifconfig-ipv6 of a client in the server multi_context after a PUSH_UPD=
ATE */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> u=
nlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 multi_del_dco_iroutes_v6(m, mi);</span><br><span>     struct in6_addr old_=
addr6;</span><br><span>     CLEAR(old_addr6);</span><br><span>     old_addr=
6 =3D mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span>@@ -4=
433,60 +4459,162 @@</span><br><span>     CLEAR(mi-&gt;reporting_addr_ipv6);=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* Reinstall only routes that are still owned by this cli=
ent=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_reinstall_ow=
ned_dco_iroute(struct multi_context *m, struct multi_instance *mi,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
     const struct mroute_addr *addr)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const struct multi_route *route =3D hash_lookup(m-&gt;vhash, addr);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (route &amp;&amp;=
 route-&gt;instance =3D=3D mi &amp;&amp; multi_route_defined(m, route))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        dco_install_iroute(m, mi, add=
r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Userspace iroutes do not depend on the client&#39;s VPN address=
=2E Only their</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * DC=
O routes need to be reinstalled when the gateway changes=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+multi_reinstall_dco_iroutes(struct multi=
_context *m, struct multi_instance *mi, int flags)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if ((flags &amp; (1 &lt;&lt; AF_INET)) &amp;&amp; mi-&gt;c=
ontext=2Ec2=2Epush_ifconfig_defined)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        for (const struct iroute *ir =3D mi-&gt;context=2Eoptions=2Eirou=
tes; ir; ir =3D ir-&gt;next)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           struct mroute_addr addr =3D { 0 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            mroute_extract_in_addr_t(&amp;addr, i=
r-&gt;network);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        addr=2Etype |=3D MR_WITH_NETBITS;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            addr=2Enetbits =3D (uint8_t)ir-&gt;netbit=
s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi=
_reinstall_owned_dco_iroute(m, mi, &amp;addr);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((flags &=
amp; (1 &lt;&lt; AF_INET6)) &amp;&amp; mi-&gt;context=2Ec2=2Epush_ifconfig_=
ipv6_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (const s=
truct iroute_ipv6 *ir6 =3D mi-&gt;context=2Eoptions=2Eiroutes_ipv6; ir6; ir=
6 =3D ir6-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  struct mroute_addr addr =3D { 0 };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            addr=2Etype =3D MR_ADDR_IPV6 | MR_WITH_NETBITS=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            addr=
=2Elen =3D 16;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       addr=2Enetbits =3D (uint8_t)ir6-&gt;netbits;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            addr=2Ev6=2Eaddr =3D ir6-&gt;=
network;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 mroute_addr_mask_host_bits(&amp;addr);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            multi_reinstall_owned_dco_iroute(m, mi, &am=
p;addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> /**</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * Update the vhash with new IP/IPv6 addresses in the=
 multi_context when a</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * push-update message containing ifconfig/ifconfig-ipv6 options is sent</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * from the server=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Update the vhash an=
d DCO peer addresses when a push-update message containing</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * ifconfig/ifconfig-ipv6 options is=
 sent from the server=2E Preserve userspace</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * iroutes and reinstall their DCO routes with the =
new IP if needed=2E</span><br><span>  *</span><br><span>  * @param m       =
  The multi_context</span><br><span>  * @param mi        The multi_instance=
 of the client we are updating</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * @param new_ip    The new IPv4 address or NULL if no change</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param new_ipv6  The ne=
w IPv6 address or NULL if no change</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param new_ip    The new IPv4 address, NULL for -ifconfi=
g or the current IPv4 if no change</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param new_ipv6  The new IPv6 address, NULL for -ifconfig=
-ipv6 or the current IPv6 if no change</span><br><span>  */</span><br><span=
> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-update_vhash(st=
ruct multi_context *m, struct multi_instance *mi, const char *new_ip, const=
 char *new_ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+upd=
ate_vaddr(struct multi_context *m, struct multi_instance *mi, const char *n=
ew_ip, const char *new_ipv6)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Track changed address families to avoid =
resetting unchanged DCO addresses=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int update_flags =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* -ifconfig */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!new_ip &amp;&amp; mi-&gt;context=2Ec2=2Epush_ifconfig_def=
ined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        unlearn_ifconfig(m, =
mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        update_=
flags |=3D (1 &lt;&lt; AF_INET);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* -ifconfig-ipv6 */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!new_ipv6 &amp;&amp; mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_d=
efined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        unlearn_ifconfig_i=
pv6(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
update_flags |=3D (1 &lt;&lt; AF_INET6);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>     if (new_ip)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        /* Remove old IP */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;context=
=2Ec2=2Epush_ifconfig_defined)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         unlearn_ifconfig(m, mi);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Add new IP=
 */</span><br><span>         struct in_addr new_addr;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        CLEAR(new_addr);</span><br><span>  =
       if (inet_pton(AF_INET, new_ip, &amp;new_addr) =3D=3D 1</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; multi_learn_=
in_addr_t(m, mi, ntohl(new_addr=2Es_addr), -1, true))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; (!mi-&gt;context=
=2Ec2=2Epush_ifconfig_defined</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                || ntohl(new_addr=2Es_addr) !=3D mi-&gt;context=
=2Ec2=2Epush_ifconfig_local))</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            /* Remove old IP */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if (mi-&gt;con=
text=2Ec2=2Epush_ifconfig_defined)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                unlearn_ifconfig(m, mi);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                update_flags |=3D (1 &lt;&lt;=
 AF_INET);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            /* DCO needs the new a=
ddress while installing its on-link route=2E */</span><br><span>           =
  mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D true;</span><br><span>   =
          mi-&gt;context=2Ec2=2Epush_ifconfig_local =3D ntohl(new_addr=2Es_=
addr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* =
set our client&#39;s VPN endpoint for status reporting purposes */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            mi-&gt;reporting_a=
ddr =3D mi-&gt;context=2Ec2=2Epush_ifconfig_local;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if (multi_learn_in_addr_t(m, mi,=
 mi-&gt;context=2Ec2=2Epush_ifconfig_local, -1, true) =3D=3D mi)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                /* set our client&#3=
9;s VPN endpoint for status reporting purposes */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                mi-&gt;reporting_addr =3D mi-=
&gt;context=2Ec2=2Epush_ifconfig_local;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                update_flags |=3D (1 &lt;&lt; AF_INET);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                mi-&gt;context=2Ec=
2=2Epush_ifconfig_defined =3D false;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                mi-&gt;context=2Ec2=2Epush_ifconfig_local =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span>         }</span><br><span>     }</span><br><span> </span>=
<br><span>     if (new_ipv6)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* Remove old IPv6 */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;context=2Ec2=2Ep=
ush_ifconfig_ipv6_defined)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     unlearn_ifconfig_ipv6(m, mi);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Add new I=
Pv6 */</span><br><span>         struct in6_addr new_addr6;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(new_addr6);</span><br><s=
pan>         if (inet_pton(AF_INET6, new_ipv6, &amp;new_addr6) =3D=3D 1</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; mu=
lti_learn_in6_addr(m, mi, new_addr6, -1, true))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            &amp;&amp; (!mi-&gt;context=2Ec2=2E=
push_ifconfig_ipv6_defined</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                || memcmp(&amp;new_addr6, &amp;mi-&gt;context=2Ec2=
=2Epush_ifconfig_ipv6_local, sizeof(new_addr6))))</span><br><span>         =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Rem=
ove old IPv6 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                unlearn_ifconfig_ipv6(m=
, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   update_flags |=3D (1 &lt;&lt; AF_INET6);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           /* DCO needs the new address while installing its on-link route=
=2E */</span><br><span>             mi-&gt;context=2Ec2=2Epush_ifconfig_ipv=
6_defined =3D true;</span><br><span>             mi-&gt;context=2Ec2=2Epush=
_ifconfig_ipv6_local =3D new_addr6;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            /* set our client&#39;s VPN endpoint for status r=
eporting purposes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           mi-&gt;reporting_addr_ipv6 =3D mi-&gt;context=2Ec2=2Epush_ifconf=
ig_ipv6_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if (multi_learn_in6_addr(m, mi, new_addr6, -1, true) =3D=3D mi)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                /* set our cli=
ent&#39;s VPN endpoint for status reporting purposes */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                mi-&gt;reporting_addr_i=
pv6 =3D mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                update_flags |=3D (1 &l=
t;&lt; AF_INET6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m=
i-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined =3D false;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                CLEAR(mi-&gt;context=
=2Ec2=2Epush_ifconfig_ipv6_local);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span>         }</span><br><span>   =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!update_flags || !dco_enabl=
ed(&amp;m-&gt;top=2Eoptions))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D dco_multi_update_pe=
er_addr(&amp;mi-&gt;context, update_flags);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(M_WARN, &quot;MULTI: failed to update DCO peer addres=
ses (error %d)&quot;, ret);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        /* PUSH_UPDATE is already queued, so reconnect to restore c=
onsistent state=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        send_restart(&amp;mi-&gt;context, NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        multi_schedule_context_wakeup(m, mi)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TU=
N)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        multi_reinstall_dco_iro=
utes(m, mi, update_flags);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span> }</span><br><span> </span><br><span> bool</sp=
an><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</sp=
an><br><span>index 5db7147=2E=2E010fb9b 100644</span><br><span>--- a/src/op=
envpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><br><span=
>@@ -730,8 +730,6 @@</span><br><span> #endif</span><br><span> </span><br><s=
pan> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-update_vhash=
(struct multi_context *m, struct multi_instance *mi, const char *new_ip, co=
nst char *new_ipv6);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid unlearn_ifconfig(struct multi_context *m, struct multi_instance *mi);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-void unlearn_ifconfig_i=
pv6(struct multi_context *m, struct multi_instance *mi);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+update_vaddr(struct multi_context *m, =
struct multi_instance *mi, const char *new_ip, const char *new_ipv6);</span=
><br><span> </span><br><span> #endif /* MULTI_H */</span><br><span>diff --g=
it a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</span><br><span>inde=
x cdd02b6=2E=2E72436fe 100644</span><br><span>--- a/src/openvpn/openvpn=2Eh=
</span><br><span>+++ b/src/openvpn/openvpn=2Eh</span><br><span>@@ -507,7 +5=
07,8 @@</span><br><span>     bool did_we_daemonize;       /**&lt; Whether d=
emonization has already</span><br><span>                                   =
*   taken place=2E */</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    bool did_dco_iroutes;        /**&lt; Whether DCO irou=
tes have been installed */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    bool did_dco_iroutes_v4;     /**&lt; Whether DCO IPv4 iroutes ha=
ve been installed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    bool did_dco_iroutes_v6;     /**&lt; Whether DCO IPv6 iroutes have bee=
n installed */</span><br><span> </span><br><span>     struct context_persis=
t persist;</span><br><span>     /**&lt; Persistent %context=2E */</span><br=
><span>diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec</=
span><br><span>index 34cb26c=2E=2E05e4cbb 100644</span><br><span>--- a/src/=
openvpn/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec</span=
><br><span>@@ -149,14 +149,35 @@</span><br><span>     struct options o;</sp=
an><br><span>     CLEAR(o);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* Set canary values to detect ifconfig options=
 in push-update messages=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-     * These placeholder strings will be overwritten to NULL by the o=
ption</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * parser if=
 -ifconfig or -ifconfig-ipv6 options are present in the</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     * push-update=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Set canary values to detect -ifc=
onfig and -ifconfig-ipv6 options in</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * push-update messages=2E These placeholder strings wi=
ll be overwritten</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * to NULL by the option parser if -ifconfig or -ifconfig-ipv6 options</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * are present in =
the push-update, to the new value if present, or</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * they will remain equal to the current v=
alues otherwise=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * If the current values are not defined they will remain NULL=2E</span>=
<br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 const char *canary =3D &quot;canary&quot;;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    o=2Eifconfig_local =3D canary;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    o=2Eifconfig_ipv6_local =3D canary;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    char ifconfig_local[INET_ADDRSTRLEN=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in_add=
r addr4 =3D { =2Es_addr =3D htonl(mi-&gt;context=2Ec2=2Epush_ifconfig_local=
) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;=
context=2Ec2=2Epush_ifconfig_defined)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (!inet_ntop(AF_INET, &amp;addr4, ifconfig_local, sizeof(ifco=
nfig_local)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=2Eifconfig=
_local =3D ifconfig_local;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    char ifconfig_ipv6_loc=
al[INET6_ADDRSTRLEN];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (!inet_ntop(AF_INET6, &amp;mi-&gt;cont=
ext=2Ec2=2Epush_ifconfig_ipv6_local,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                       ifconfig_ipv6_local, sizeof(ifconfi=
g_ipv6_local)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=2Eifconf=
ig_ipv6_local =3D ifconfig_ipv6_local;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span> </span><br><span>     struct buff=
er_entry *e =3D msgs-&gt;head;</span><br><span>     while (e)</span><br><sp=
an>@@ -194,28 +215,9 @@</span><br><span> </span><br><span>     if (option_t=
ypes_found &amp; OPT_P_UP)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        /* -ifconfig */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!o=2Eifconfig_local &amp;&amp; =
mi-&gt;context=2Ec2=2Epush_ifconfig_defined)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            unlearn_ifconfig(m, mi);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        /* -ifconfig-ipv6 */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (!o=2Eifconfig_ipv6_local &amp;&amp; mi-&gt=
;context=2Ec2=2Epush_ifconfig_ipv6_defined)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            unlearn_ifconfig_ipv6(m, mi);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (o=2Eifconfig_local &amp;&amp; !strcmp(o=2Eifconfig_local, canary=
))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            o=2Eifconfig_local =
=3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (o=2Eifconfig=
_ipv6_local &amp;&amp; !strcmp(o=2Eifconfig_ipv6_local, canary))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            o=2Eifconfig_ipv6_local =3D NUL=
L;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        /* new ifconfig or new ifconfig-ipv6 */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        update_vhash(m, mi=
, o=2Eifconfig_local, o=2Eifconfig_ipv6_local);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* ifconfig or ifconfig-ipv6 */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        update_vaddr(m, mi,=
 o=2Eifconfig_local, o=2Eifconfig_ipv6_local);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return !event_timeout_defined(&amp;c-&gt=
;c2=2Escheduled_exit);</span><br><span>     }</span><br><span> </span><br><=
span>     uninit_options(&amp;o);</span><br><span>@@ -253,12 +255,14 @@</sp=
an><br><span> static int</span><br><span> send_push_update(struct multi_con=
text *m, const void *target, const char *msg, const push_update_type type, =
const size_t push_bundle_size)</span><br><span> {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#if !defined(TARGET_LINUX)</span><br><span>  =
   if (dco_enabled(&amp;m-&gt;top=2Eoptions))</span><br><span>     {</span>=
<br><span>         msg(M_WARN, &quot;WARN: PUSH_UPDATE messages cannot curr=
ently be sent while DCO is enabled=2E&quot;</span><br><span>               =
      &quot; To send a PUSH_UPDATE message, be sure to use the --disable-dc=
o option=2E&quot;);</span><br><span>         return 0;</span><br><span>    =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span> </span><br><span>     if (!msg || !*msg || !m || (!target &amp;&amp;=
 type !=3D UPT_BROADCAST))</span><br><span>     {</span><br><span>@@ -301,6=
 +305,7 @@</span><br><span>         }</span><br><span> </span><br><span>   =
      if (!mi-&gt;halt</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            &amp;&amp; !event_timeout_defined(&amp;mi-&gt;context=2Ec2=
=2Escheduled_exit)</span><br><span>             &amp;&amp; send_single_push=
_update(m, mi, msgs))</span><br><span>         {</span><br><span>          =
   buffer_list_free(msgs);</span><br><span>@@ -321,7 +326,9 @@</span><br><s=
pan>     {</span><br><span>         struct multi_instance *curr_mi =3D m-&g=
t;instances[i];</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (!curr_mi || curr_mi-&gt;halt || !support_push_updat=
e(curr_mi))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (!curr_mi || curr_mi-&gt;halt</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            || event_timeout_defined(&amp;curr_mi-&gt;context=
=2Ec2=2Escheduled_exit)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            || !support_push_update(curr_mi))</span><br><span>         =
{</span><br><span>             continue;</span><br><span>         }</span><=
br><span>diff --git a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec b=
/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>index =
bf2ccf3=2E=2Ec951a8f 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
mock_push_dependencies=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/m=
ock_push_dependencies=2Ec</span><br><span>@@ -48,17 +48,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-unlearn_ifconfig(struct multi_context *m, struct mul=
ti_instance *mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unlear=
n_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-update_vhash(struct multi_contex=
t *m, struct multi_instance *mi, const char *new_ip, const char *new_ipv6)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+update_vaddr(struct =
multi_context *m, struct multi_instance *mi, const char *new_ip, const char=
 *new_ipv6)</span><br><span> {</span><br><span> }</span><br></pre><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1450?usp=3De=
mail">change 1450</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1450?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I88f37e47026a7d7ea0f7c6bde1d79d32c14e5297 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1450 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body>=
</html>
--WMcdmkZbZU0=--


--===============3532335578704927520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3532335578704927520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3532335578704927520==--

