Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0378760A3813
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=d0muXfiL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iCyaFPeJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kFKro/b9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HMaJpGQ2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=hLUg/P/KBFLBAEtHJKTZyiFDzQEac5enNfFq9PhSqko=; b=d0muXfiLuS5pG21GDToongIrwt
	9ajaoGrZRWPfgPCahbhFDC8dSR2iDPZ1Y+nlbei7YSpiwm99jjFRJwFaQPrpvt0dPGmjTSUz/gQyT
	lH1J8qurdw9gQCKGQ+TwDbYM51hGt/IPgJ6hx4ObWJTtYwX0FvEds83NJ6ojy/+obqTE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQru5-000000004MO-0nb8;
	Tue, 10 Nov 2026 19:53:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQru4-000000004MG-0Ron
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 19:53:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G5je2F0cQqn3Vu8T0mmL8QCMyWDryLSkRXCZROVE89c=; b=iCyaFPeJ3CMCYBsi7e0tnPYx57
 o6HQT/W7eyvje4WsEPbd1zyZqtSF+zM4+StUk9sSNGISQYsga7dpHNCvmPWVlyMsOnykL3xSsBf5X
 NjNa5GW6LdRIJLXifBL6VoWt4vHzKMZcmB6mKTcJq1JLvXrqZlFp14BT+m+XaKuwobkY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G5je2F0cQqn3Vu8T0mmL8QCMyWDryLSkRXCZROVE89c=; b=kFKro/b9geBP51z9Qen1fhKwO9
 Bq2dTvtQgq6qv5E+JyRrRQz+OzM/xt98JqItVL3V6PtrAAD3WO+c2kgHTxMvkSQDwfxmDhiWpoQMj
 x5bFz+YqjXq+g6bzrX2ynsNOP4e6KACmCSgvzZfM3P19yhh2TiQlN+PPTLXCw4oQ+EqQ=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQru1-000000008Cg-31pz for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 19:53:12 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so20517075e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 11:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794340383; x=1794945183; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=G5je2F0cQqn3Vu8T0mmL8QCMyWDryLSkRXCZROVE89c=;
 b=HMaJpGQ2kQ/77Igywm/Ol0755z1MtOAcRjzQVoK/KtcRUbR6OnYQncUH7n4MeWEefz
 xwLq0ltYTOnZl1BsiBEF/SCCXCx1bE0sCQI6NgbyNB+pFg5FvwvoBvg3HKa/MqjLOwxr
 9+iKDLn/NlfC/7wXZQNlZhSQwZqKSZO4ghEbwT3abiUs+K7Wmhr0A7oPxrQUR8SIz+9d
 YCay3L22FXG9wvQOUD0rTGrv3HYRJA4AZ9jn2VLnUGGSHoWBy+poJHjPQuJTXV9uMccP
 Hg9Zo4PNGSecYXhTuVTQ4fKbdtrKJ99eK6zeH8RDlorXl9oQh/oAYrwTNNZmL4GsEqHX
 8cbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794340383; x=1794945183;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=G5je2F0cQqn3Vu8T0mmL8QCMyWDryLSkRXCZROVE89c=;
 b=xq2gQZPZqeTFcXFdHaQ53O0O1FpnWOJgu6NN8TBczxrNDd79FonTMvB3RfNA3ftEmL
 75po+tOo+GWBY4NMHXmdEBWsWwn8xoqHafKMj3I0MLbc4qm+R1tC6ti9hJRrG/0vEZj6
 xsJ5tGO9HAMN+l/Z2/UXB/qUNQaVIH73CiDLdqswiS6S41MOTctqXRDklzERu4jxthLW
 KvysoRp5JE7Hzbh4vQIV1AMHYnxDgRc6Zhn3vo9/i9w++nXd5ZIv7lXOSNOBToMP7tBL
 FI5ElfTDlYt3t9XVfmhn9axnsS48zd5miWJbZ60rTesAv+D2eLEo27WMXa7XVdVxhvRQ
 xQYg==
X-Gm-Message-State: APuU4Z/daeIJUYA7Rd/EV9ukHgY7kVRv1PVRpNNzYow3XG56fwdmh8Uu
 4rdt+xO8GMtpMYewxM2JOfKrsPVPhjKFISzSDnTfcpMGpoVbdtvEE5FcBqXOvSDeE+jFesxizZO
 4HNeT6oLYlD+4JgBfsI9gBAvwPs22fqpmMN0p4lsIC1Zth/HEZkszDK1Kn3Yl9f4zrymOtl3KOy
 A/p9L7hw==
X-Gm-Gg: AYBFou2iV9eBN3mjyMRSM1sMZ8/bvBCpC7cswRY3DqcEWtH/4wcrYSFkjd8nIRqg0ga
 MFFEapVM5GQfep6Oor/lS5gpqF262MP7dpMdgL2CtCDiC2IPlcKkNYzc+mM0iOw/6o4BcBu8pSG
 3i05raAfw/aY81INX+bBMZxO2Gi0FlZTiy0wnHS6dCAOSq4/hWHHevuDl0rLPS5qVgNY09qqlfb
 AisADlvr/SN7U+YlVikgzqlHguFNuQnrJj+d1Df1SfXNGrcPhxluRKy1P1oCgnfHlZBzy/x7Tj4
 yUiKV5xWlSYp/XxGSThCnrZ86DpA+ZmTKY9XNypDRaBtkWf/5gsx/GREv+u+sofJ6dyy/hmoEeS
 x4uhXddXfD8M/NnQpqmox/Z8aJnQj93MieaBJ1kjIa9saA/GmSwLaMK5DR8Ub500SrtvKMwbw7x
 uj6Ce0mAbv5SpCUw3cQsqpD4kOWfdKeXDhLyvmVen3wuBqGY1Irzdv6VaZ8dK4VF+T6XODeo609
 huXFpBUrDMbYtOO0e5Xz4pWIReitng8Cz/xVUXrxGucLyFnCw3tU0Okiu87eAorG+exdnGrv7uT
 j7PNzbZrRg8LSKLXMaID56O//0HUf4akTA8fFdPslxS7l0VrMp5ZiFPJtaO/f4bBwr+0hc7p5nD
 Opmp+OOctTKQbTuY4pqO0p2mIjsMG19VGM9ysshrmZc6454Kvptega0Vwk/9qNFB8EcfYfUtuBG
 3Sv0uKUcXKRCDTZekBz/NBOC0+oCjTSVJJOM8C
X-Received: by 2002:a05:600c:6819:b0:4a2:167a:c946 with SMTP id
 5b1f17b1804b1-4ba0935f880mr2877655e9.13.1794340382909; 
 Tue, 10 Nov 2026 11:53:02 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba020433casm81072835e9.7.2026.11.10.11.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 11:53:02 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 19:53:02 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225
X-Gerrit-Change-Number: 2170
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2170?usp=email>
X-Gerrit-Commit: 829177950a079c191414f6f94c18db76c6e2b33b
References: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzQwMzgwMDAwLkk1YWI5NTllNzEwMWNmODAxYWM5M2U1MTg1ODU1ZTc1ZGIwZmI2MjI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <52ace69263d57c7cf3a15ffb1019e795cb46dc94-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQru1-000000008Cg-31pz
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2906840163742485335=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2906840163742485335==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="80Qey4bwxow="; charset=UTF-8

--80Qey4bwxow=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2170?usp=3Demail

to review the following change=2E
=


Change subject: DragonFly: bring things back into a working state
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

DragonFly: bring th=
ings back into a working state

- t_client=2Esh(=2Ein): add "DragonFly" to =
the OS versions "like FreeBSD"

- tun=2Ec open_tun()
   - add DragonFly spe=
cific handling of dynamic tun/tap devices
     (open /dev/{tun,tap}, assign=
s first-free node, fdevname(fd) returns
      true device name)
     --dev =
tunN (and tapN) works "the old way", by opening /dev/tunN - but
     only f=
or devices pre-created with "ifconfig tun3 create"

- tun=2Ec do_ifconfig_i=
pv4()
   - bring back "old FreeBSD" IPv4 ifconfig handling (all tun interfa=
ces
     are "p2p", TOPOLOGY_SUBNET is simulated with an extra network rout=
e)
     this part is based on "patch-src_openvpn_tun=2Ec" to OpenVPN 2=2E6=
=2E14
     in DragonFly "dports"
     (TODO: see if TUNSIFMODE -> IFF_BROAD=
CAST works here?)

- tun=2Ec do_ifconfig_ipv6()
   - needs "add_route_conne=
cted_v6_net()" for tun and tap(!) devices,
     otherwise the on-link /64 i=
s not routed to the tun device

- lladdr=2Ec: add TARGET_DRAGONFLY to TARGE=
T_FREEBSD format

Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225
Sign=
ed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/lladdr=
=2Ec
M src/openvpn/tun=2Ec
M tests/t_client=2Esh=2Ein
3 files changed, 82 i=
nsertions(+), 6 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/70/2170/1

diff --git a/src/openvpn/lladdr=2Ec b/sr=
c/openvpn/lladdr=2Ec
index 8bd572a=2E=2Ec70e282 100644
--- a/src/openvpn/ll=
addr=2Ec
+++ b/src/openvpn/lladdr=2Ec
@@ -24,7 +24,8 @@
 }
 #else /* TARGET=
_LINUX */
 
-#if defined(TARGET_OPENBSD) || defined(TARGET_FREEBSD) || defi=
ned(TARGET_DARWIN)
+#if defined(TARGET_OPENBSD) || defined(TARGET_FREEBSD) =
|| \
+    defined(TARGET_DARWIN)  || defined(TARGET_DRAGONFLY)
 #define IFC=
ONFIG_LLADDR_FMT "%s %s lladdr %s"
 #elif defined(TARGET_NETBSD)
 #define I=
FCONFIG_LLADDR_FMT "%s %s link %s active"
diff --git a/src/openvpn/tun=2Ec =
b/src/openvpn/tun=2Ec
index bcea331=2E=2E605a9fe 100644
--- a/src/openvpn/t=
un=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -965,7 +965,7 @@
 #endif /* ifdef _WIN3=
2 */
 }
 
-#if defined(_WIN32)
+#if defined(_WIN32) || defined(TARGET_DRAGO=
NFLY)
 
 /* some of the platforms will auto-add a "network route" pointing
=
  * to the interface on "ifconfig tunX 2001:db8::1/64", others need
@@ -114=
7,6 +1147,10 @@
     openvpn_execve_check(&argv, es, S_FATAL, "FreeBSD BSD =
'ifconfig inet6 -ifdisabled' failed");
 #endif
 
+#ifdef TARGET_DRAGONFLY
+=
    add_route_connected_v6_net(tt, es);
+#endif
+
 #elif defined(TARGET_AIX=
)
     argv_printf(&argv, "%s %s inet6 %s/%d mtu %d up", IFCONFIG_PATH, ifn=
ame, ifconfig_ipv6_local,
                 tt->netbits_ipv6, tun_mtu);
@@ -=
1461,7 +1465,7 @@
         add_route(&r, tt, 0, NULL, es, NULL);
     }
 
-=
#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
+#elif defined(T=
ARGET_FREEBSD)
 
     /* example: ifconfig tun2 10=2E2=2E0=2E2 10=2E2=2E0=
=2E1 mtu 1450 netmask 255=2E255=2E255=2E255 up */
     if (tun_p2p) /* poin=
t-to-point tun */
@@ -1479,6 +1483,44 @@
     argv_msg(M_INFO, &argv);
    =
 openvpn_execve_check(&argv, es, S_FATAL, "FreeBSD ifconfig failed");
 
+#e=
lif defined(TARGET_DRAGONFLY)
+    in_addr_t remote_end =3D INADDR_ANY;  /*=
 for "virtual" subnet topology */
+
+    /* example: ifconfig tun2 10=2E2=
=2E0=2E2 10=2E2=2E0=2E1 mtu 1450 netmask 255=2E255=2E255=2E255 up */
+    i=
f (tun_p2p)       /* point-to-point tun */
+    {
+        argv_printf(&arg=
v, "%s %s %s %s mtu %d netmask 255=2E255=2E255=2E255 up",
+                =
    IFCONFIG_PATH, ifname, ifconfig_local,
+                    ifconfig_re=
mote_netmask, tun_mtu);
+    }
+    else if (tt->type =3D=3D DEV_TYPE_TUN &=
& tt->topology =3D=3D TOP_SUBNET)
+    {
+        remote_end =3D create_arb=
itrary_remote(tt);
+        argv_printf(&argv, "%s %s %s %s mtu %d netmask =
%s up", IFCONFIG_PATH,
+                    ifname, ifconfig_local, print_i=
n_addr_t(remote_end, 0, &gc),
+                    tun_mtu, ifconfig_remote=
_netmask);
+    }
+    else
+    {
+        argv_printf(&argv, "%s %s %s ne=
tmask %s mtu %d",
+                    IFCONFIG_PATH, ifname, ifconfig_loca=
l,
+                    ifconfig_remote_netmask, tun_mtu);
+    }
+    argv=
_msg(M_INFO, &argv);
+    openvpn_execve_check(&argv, es, S_FATAL, "DragonF=
ly ifconfig failed");
+
+    /* Add a network route for the local tun inter=
face */
+    if (tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SU=
BNET)
+    {
+        struct route_ipv4 r;
+        CLEAR(r);
+        r=2E=
flags =3D RT_DEFINED;
+        r=2Enetwork =3D tt->local & tt->remote_netma=
sk;
+        r=2Enetmask =3D tt->remote_netmask;
+        r=2Egateway =3D r=
emote_end;
+        add_route(&r, tt, 0, NULL, es, NULL);
+    }
+
 #elif d=
efined(TARGET_AIX)
     {
         /* AIX ifconfig will complain if it can'=
t find ODM path in env */
@@ -2853,11 +2895,44 @@
 
 #elif defined(TARGET_D=
RAGONFLY)
 
+/* DragonFly tun/tap devices are similar to NetBSD
+ *  - for =
a dynamic tun/tap, open /dev/tun or /dev/tap, get assigned
+ *    the first=
 free device, ask with devname(3) what you got, and
+ *    the interface wi=
ll auto-destruct on close
+ *  - for a pre-created tun/tap, open "/dev/tun3=
"
+ *  - using "--dev tun3" and have it dynamically created needs a call
+ =
*    to "ifconfig tun3 create" which we don't currently do
+ */
+
 void
 op=
en_tun(const char *dev, const char *dev_type, const char *dev_node, struct =
tuntap *tt,
          openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev,=
 dev_type, dev_node, tt);
+    if (strcmp(dev, "tap") =3D=3D 0 || strcmp(de=
v, "tun") =3D=3D 0)
+    {
+        char tunname[256];
+        snprintf(tu=
nname, sizeof(tunname), "/dev/%s", dev);
+
+        if ((tt->fd =3D open(tu=
nname, O_RDWR)) < 0)
+        {
+            msg(M_FATAL, "Cannot allocate =
DragonFly TUN/TAP %s dynamically", tunname);
+        }
+
+	char *devname =
=3D fdevname(tt->fd);
+        if (devname =3D=3D NULL)
+        {
+       =
     msg(M_FATAL, "Cannot query DragonFly TUN/TAP device name");
+        }=

+        set_nonblock(tt->fd);
+        set_cloexec(tt->fd); /* don't pass=
 fd to scripts */
+        msg(M_INFO, "TUN/TAP device %s opened", devname)=
;
+
+        tt->actual_name =3D string_alloc(devname, NULL);
+    }
+    e=
lse
+    {
+        open_tun_generic(dev, dev_type, dev_node, tt);
+    }
 =

     if (tt->fd >=3D 0)
     {
diff --git a/tests/t_client=2Esh=2Ein b/tes=
ts/t_client=2Esh=2Ein
index 5e924bb=2E=2E7488d4b 100755
--- a/tests/t_clien=
t=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -212,8 +212,8 @@
            =
     LANG=3DC @NETSTAT@ -rn -4 -6
             fi
             ;;
-        =
FreeBSD | NetBSD | Darwin)
-            echo "-- FreeBSD/NetBSD/Darwin [Mac=
OS X] --"
+        FreeBSD | DragonFly | NetBSD | Darwin )
+            ech=
o "-- FreeBSD/DragonFly/NetBSD/Darwin [MacOS X] --"
             @IFCONFIG@=
 -a | egrep "(flags=3D|inet)"
             @NETSTAT@ -rn | awk '$3 !~ /^UHL=
/ { print $1,$2,$3,$NF }'
             ;;

-- 
To view, visit https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225
Gerrit-C=
hange-Number: 2170
Gerrit-PatchSet: 1
Gerrit-Owner: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--80Qey4bwxow=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gert Doering would like Arne =
Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">DragonFly: bring things back into a working state<br><br>- t_cl=
ient=2Esh(=2Ein): add &quot;DragonFly&quot; to the OS versions &quot;like F=
reeBSD&quot;<br><br>- tun=2Ec open_tun()<br>   - add DragonFly specific han=
dling of dynamic tun/tap devices<br>     (open /dev/{tun,tap}, assigns firs=
t-free node, fdevname(fd) returns<br>      true device name)<br>     --dev =
tunN (and tapN) works &quot;the old way&quot;, by opening /dev/tunN - but<b=
r>     only for devices pre-created with &quot;ifconfig tun3 create&quot;<b=
r><br>- tun=2Ec do_ifconfig_ipv4()<br>   - bring back &quot;old FreeBSD&quo=
t; IPv4 ifconfig handling (all tun interfaces<br>     are &quot;p2p&quot;, =
TOPOLOGY_SUBNET is simulated with an extra network route)<br>     this part=
 is based on &quot;patch-src_openvpn_tun=2Ec&quot; to OpenVPN 2=2E6=2E14<br=
>     in DragonFly &quot;dports&quot;<br>     (TODO: see if TUNSIFMODE -&gt=
; IFF_BROADCAST works here?)<br><br>- tun=2Ec do_ifconfig_ipv6()<br>   - ne=
eds &quot;add_route_connected_v6_net()&quot; for tun and tap(!) devices,<br=
>     otherwise the on-link /64 is not routed to the tun device<br><br>- ll=
addr=2Ec: add TARGET_DRAGONFLY to TARGET_FREEBSD format<br><br>Change-Id: I=
5ab959e7101cf801ac93e5185855e75db0fb6225<br>Signed-off-by: Gert Doering &lt=
;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/lladdr=2Ec<br>M src/op=
envpn/tun=2Ec<br>M tests/t_client=2Esh=2Ein<br>3 files changed, 82 insertio=
ns(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/70/2170/1</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/lladdr=2Ec b/src/openvpn/lladdr=2Ec</span><br><span>index 8bd572a=2E=
=2Ec70e282 100644</span><br><span>--- a/src/openvpn/lladdr=2Ec</span><br><s=
pan>+++ b/src/openvpn/lladdr=2Ec</span><br><span>@@ -24,7 +24,8 @@</span><b=
r><span> }</span><br><span> #else /* TARGET_LINUX */</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_OPENBSD=
) || defined(TARGET_FREEBSD) || defined(TARGET_DARWIN)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_OPENBSD) || defined(T=
ARGET_FREEBSD) || \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    defined(TARGET_DARWIN)  || defined(TARGET_DRAGONFLY)</span><br><span> #=
define IFCONFIG_LLADDR_FMT &quot;%s %s lladdr %s&quot;</span><br><span> #el=
if defined(TARGET_NETBSD)</span><br><span> #define IFCONFIG_LLADDR_FMT &quo=
t;%s %s link %s active&quot;</span><br><span>diff --git a/src/openvpn/tun=
=2Ec b/src/openvpn/tun=2Ec</span><br><span>index bcea331=2E=2E605a9fe 10064=
4</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openv=
pn/tun=2Ec</span><br><span>@@ -965,7 +965,7 @@</span><br><span> #endif /* i=
fdef _WIN32 */</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) || defined(TARGET_DRA=
GONFLY)</span><br><span> </span><br><span> /* some of the platforms will au=
to-add a &quot;network route&quot; pointing</span><br><span>  * to the inte=
rface on &quot;ifconfig tunX 2001:db8::1/64&quot;, others need</span><br><s=
pan>@@ -1147,6 +1147,10 @@</span><br><span>     openvpn_execve_check(&amp;a=
rgv, es, S_FATAL, &quot;FreeBSD BSD &#39;ifconfig inet6 -ifdisabled&#39; fa=
iled&quot;);</span><br><span> #endif</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_DRAGONFLY</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    add_route_connected_v6_net(tt, e=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #elif defin=
ed(TARGET_AIX)</span><br><span>     argv_printf(&amp;argv, &quot;%s %s inet=
6 %s/%d mtu %d up&quot;, IFCONFIG_PATH, ifname, ifconfig_ipv6_local,</span>=
<br><span>                 tt-&gt;netbits_ipv6, tun_mtu);</span><br><span>@=
@ -1461,7 +1465,7 @@</span><br><span>         add_route(&amp;r, tt, 0, NULL=
, es, NULL);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#elif defined(TARGET_FREEBSD) || defined(TA=
RGET_DRAGONFLY)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#eli=
f defined(TARGET_FREEBSD)</span><br><span> </span><br><span>     /* example=
: ifconfig tun2 10=2E2=2E0=2E2 10=2E2=2E0=2E1 mtu 1450 netmask 255=2E255=2E=
255=2E255 up */</span><br><span>     if (tun_p2p) /* point-to-point tun */<=
/span><br><span>@@ -1479,6 +1483,44 @@</span><br><span>     argv_msg(M_INFO=
, &amp;argv);</span><br><span>     openvpn_execve_check(&amp;argv, es, S_FA=
TAL, &quot;FreeBSD ifconfig failed&quot;);</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#elif defined(TARGET_DRAGONFLY)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t remote_e=
nd =3D INADDR_ANY;  /* for &quot;virtual&quot; subnet topology */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* example: ifconfig tun2 10=2E2=2E0=2E2 10=
=2E2=2E0=2E1 mtu 1450 netmask 255=2E255=2E255=2E255 up */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (tun_p2p)       /* point-to-po=
int tun */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&am=
p;argv, &quot;%s %s %s %s mtu %d netmask 255=2E255=2E255=2E255 up&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    IF=
CONFIG_PATH, ifname, ifconfig_local,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    ifconfig_remote_netmask, tun_mtu);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else if (tt-&gt;type =3D=3D DEV_T=
YPE_TUN &amp;&amp; tt-&gt;topology =3D=3D TOP_SUBNET)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        remote_end =3D create_arbitrary_remote(tt);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&am=
p;argv, &quot;%s %s %s %s mtu %d netmask %s up&quot;, IFCONFIG_PATH,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    ifname=
, ifconfig_local, print_in_addr_t(remote_end, 0, &amp;gc),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    tun_mtu, ifconfi=
g_remote_netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s =
%s %s netmask %s mtu %d&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    IFCONFIG_PATH, ifname, ifconfig_local,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    ifcon=
fig_remote_netmask, tun_mtu);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
argv_msg(M_INFO, &amp;argv);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    openvpn_execve_check(&amp;argv, es, S_FATAL, &quot;DragonFly i=
fconfig failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Add a net=
work route for the local tun interface */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp; tt=
-&gt;topology =3D=3D TOP_SUBNET)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       struct route_ipv4 r;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        CLEAR(r);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        r=2Eflags =3D RT_DEFINED;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        r=2Enetwork =3D tt-&gt;local &amp; tt-&gt;remot=
e_netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
=2Enetmask =3D tt-&gt;remote_netmask;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        r=2Egateway =3D remote_end;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        add_route(&amp;r, tt, 0, NULL, es=
, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #elif d=
efined(TARGET_AIX)</span><br><span>     {</span><br><span>         /* AIX i=
fconfig will complain if it can&#39;t find ODM path in env */</span><br><sp=
an>@@ -2853,11 +2895,44 @@</span><br><span> </span><br><span> #elif defined=
(TARGET_DRAGONFLY)</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* DragonFly tun/tap devices are similar to NetBSD</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - for a dynamic tun/tap=
, open /dev/tun or /dev/tap, get assigned</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *    the first free device, ask with devname(3) what=
 you got, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
the interface will auto-destruct on close</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  - for a pre-created tun/tap, open &quot;/dev/tun3=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  - using &=
quot;--dev tun3&quot; and have it dynamically created needs a call</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *    to &quot;ifconfig tun3=
 create&quot; which we don&#39;t currently do</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> void</span><br><span> open_tun(const char *dev,=
 const char *dev_type, const char *dev_node, struct tuntap *tt,</span><br><=
span>          openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    open_tun_generic(dev, dev_type, dev=
_node, tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
strcmp(dev, &quot;tap&quot;) =3D=3D 0 || strcmp(dev, &quot;tun&quot;) =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        char tunname[256];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tun=
name, sizeof(tunname), &quot;/dev/%s&quot;, dev);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if ((tt-&gt;fd =3D open(tunname, O_RDWR)) &lt; 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;Canno=
t allocate DragonFly TUN/TAP %s dynamically&quot;, tunname);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	char *devname =3D fdevname(tt-&gt;fd);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (devname =3D=3D NULL)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;Cannot =
query DragonFly TUN/TAP device name&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        set_nonblock(tt-&gt;fd);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        set_cloexec(tt-&gt;fd); /* don&#39;t pas=
s fd to scripts */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(M_INFO, &quot;TUN/TAP device %s opened&quot;, devname);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        tt-&gt;actual_name =3D string_alloc(dev=
name, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        open_tun_generic(dev, dev_type, dev_no=
de, tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span> </span><br><span>     if (tt-&gt;fd &gt;=3D 0)</span><br><span>=
     {</span><br><span>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_clie=
nt=2Esh=2Ein</span><br><span>index 5e924bb=2E=2E7488d4b 100755</span><br><s=
pan>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Es=
h=2Ein</span><br><span>@@ -212,8 +212,8 @@</span><br><span>                =
 LANG=3DC @NETSTAT@ -rn -4 -6</span><br><span>             fi</span><br><sp=
an>             ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     FreeBSD | NetBSD | Darwin)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            echo &quot;-- FreeBSD/NetBSD/Darwin [MacOS X] --&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        FreeBSD | =
DragonFly | NetBSD | Darwin )</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            echo &quot;-- FreeBSD/DragonFly/NetBSD/Darwin [MacOS =
X] --&quot;</span><br><span>             @IFCONFIG@ -a | egrep &quot;(flags=
=3D|inet)&quot;</span><br><span>             @NETSTAT@ -rn | awk &#39;$3 !~=
 /^UHL/ { print $1,$2,$3,$NF }&#39;</span><br><span>             ;;</span><=
br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2170?usp=3Demail">change 2170</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2170?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2170 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>

</body></html>
--80Qey4bwxow=--


--===============2906840163742485335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2906840163742485335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2906840163742485335==--

