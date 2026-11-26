Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9A6606A321
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YXuKzM3x;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GDkkvedJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MG3HKbI3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UjOgmkJ4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YRIzFMdbLUzoNO0bE9hOTRNPfIdr5WLe3nBZKi5wJoo=; b=YXuKzM3xoF4ynS0q6sTTTp5tZq
	bXbvMb/8d/sPZoktWFbdNirN5uCbeDGwLIR8OSQViPOKg08RtivWAVvxiUbemt+N0cX8y8Vn2M0AP
	cku9et35lSWOOfW1QNHq8Q6vxQl+0O+xYW8h0Otc/Zsmqk8jvyUs7T9VpbSkDyeftC2k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWXle-000000007hw-17sD;
	Thu, 26 Nov 2026 11:35:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWXlc-000000007hp-3Qwl
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:35:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w2Og0y+eeUWRmrfNsL8yXXJYDWLF7mqxda3WfX/EG8Q=; b=GDkkvedJoeJZC16grhEueUeF7g
 lK5ivj8MhryQ8Sf0MXM+PtXvDaL3VmRqosatO7Xn/s59yI235rr+baC0tE+aDRSShj/I+Li37kIEZ
 kjAfsNH8JNVwko2HpCVUrl1a+5CJb6hxHCWJrGeGnLQM/bwLdYv9YKZwp65fl8Qf+pFw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w2Og0y+eeUWRmrfNsL8yXXJYDWLF7mqxda3WfX/EG8Q=; b=MG3HKbI3b6wato9JG5XPj0a1pn
 Jj408LiYV0rbHlHQ17zdOF6Cr2iSg3a+7YpEJt5WBsit6WeaGzsgE2JOZc5nQOWXOobW1ksv3IGEs
 8o89gbfZSJc9HKF2wHl+2G2X8Xvxwc7xKmQ0vXlymjRAWmzZDUUfmTPsG84rP+v+JClA=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWXla-000000005Td-3IoX for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 11:35:56 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bba60271d7so15341965e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 03:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795692948; x=1796297748; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w2Og0y+eeUWRmrfNsL8yXXJYDWLF7mqxda3WfX/EG8Q=;
 b=UjOgmkJ4xxS5Mx/BLY9wJ5RDk1FV3WhaEBOEEj3zkPu95SuD0vdsO+TDrPg5ND7gEA
 SQPmYiJLbb+s58V/hitZnP1Ocm6lWa7bSwKnxWlD7c/KHVkkBCglTjcvxBbuioQQnlTA
 3D2nP4zyztAzdo4xV5Md2AX4ra0dqXX8h3EbLDo01MS/9w3Sy7Lp9RgCiFVUiTRAbWNL
 LToTviyoXrOdg3nWU1VTjkNiOwuWs3KK3nhYCAGxnFUd+IT+mXEVHa5x2/TBiBn5+lcf
 +iGlhErCy9ak0BGUuvDAqAgRn4rgcJo/6dM0tHQaeQbVymT/TwEbt0gVQv2PIf6ECAco
 CHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795692948; x=1796297748;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w2Og0y+eeUWRmrfNsL8yXXJYDWLF7mqxda3WfX/EG8Q=;
 b=RNRinCnVCOrB1ysSGBNyPpCqF11WAHhueF3TIDL8YxQsrmij39nEMyv0bFrISEWJV9
 qQ7Xb4TmEl6TT6v7CycouZUqOq7zUyp4tRbxlsH4Nw7hNYiYnKWDIrnwaJu7jUuntBCm
 CxCd28eDVON15aWuXuORLBIRjnVp4lgLCjBh9xl6zDqdSLBVg8ZQRvlgjzyTfaZSxWOV
 AjI94SzsNNRbfQlnRKl+GMJQbiOIR4XMYAAdmvBnB2Ws9t6/KCMn5uIGLOc537MVXDTb
 4Sogb9H9F8z/skg3TFluGqKwSU4g885abPMQ5nxByT6hdZ7clw7FeKGzgFPabH8IBoA/
 TCPQ==
X-Gm-Message-State: APuU4Z/0D2KKPVKr2H8BG2VUliJNiv3H3S7XRAe6LgrnlrLg8+vc6c23
 fmkDrw6FMXYham0/Gjn7wyKwmoZ8W3vbNFxjYxtO7owhDiFEHsm5RYxgGGIyl55o6rXWuJUCpuX
 mGgtpQWiUzZ9tPjB+PBn/02B5ZgRNCU7eY6y04QTgvlVyG4dWpJzwHV7ObeWUbTMv6J8r
X-Gm-Gg: AZFdTZdY6sO3n6D9KTaIhbTAtxMXvFzP04KmRhg3oOiNzRblf4fOFbC79FJ1oS4r2eU
 wYNTdffR0SaAQQ37m7cMkMcw76J9aX5Zus2nZHtN3BClEKxBvdQf8SWZk7hE6zHe9tIyIA1hAKE
 kusZ3rfXYLYbP2uU1gTsOtHt9nwFOXHa6WzJYP/GlQlwJ2phV2CP8eTeQoXWpPOXshhDHUDmJcF
 SPi2ekFCgcDIzdSeG6F8u/yYm5K3xanQ7+mcI3Hc2f2Wtb0HHiyv/qv/2CdTmZo2OgknpDpqlub
 tKtWFoyW9oAGdp7jWfL85Sb5HeCpyO1/CvXCp6o2yjh9r8l/n66JzDI+7FN7RNXFEoSa78mPcQX
 kr6SS1+x8u7Sz7ArB4ButOrJYuOtcvflWez05MeFOIBdvZHJH01ApDAdAsSju1rcGKe2TZL8dsK
 sf6SfJpzw0YC7qWoMBfGafIeEH6Mp9te441TdjYPpiQmDAnYSuJHDvid7ybnzPtQFY2AcotquXE
 yfQXKfP6f2L0f0sinKrCpW4u0zSPm8OvyCLauTQTVErZaS9IAjgkQtjV5jzesx1OMNIhz9vQMKR
 7h8xJZxjS6+VBHiEY+8fbmB3QpSwhEflihNTpHp/DZndRdXDPk2xyKmQZvJKxAKPLiVwE3Z1Kc6
 O+4PI3JGGadcRvV/82cE1sTDDCiEMCoG3wHeq+SfefhrCENOQ5RE25HwW6vU92eNxnzvME5Sd3p
 F7A7uHC0x0UVBb6qWg2q552Dowe6BwchR4J/f6
X-Received: by 2002:a05:600c:4e0b:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4bb8881ae90mr430254545e9.32.1795692948097; 
 Thu, 26 Nov 2026 03:35:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9687sm663997475e9.10.2026.11.26.03.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 03:35:47 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 11:35:46 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I225c21dbd843601b697fe712b5b66c2a4f5c2ac2
X-Gerrit-Change-Number: 2342
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2342?usp=email>
X-Gerrit-Commit: cd9a867eae0bf147107a388a8d7d22aa4f4b1c77
In-Reply-To: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
References: <gerrit.1795563178000.I225c21dbd843601b697fe712b5b66c2a4f5c2ac2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTYzMTc4MDAwLkkyMjVjMjFkYmQ4NDM2MDFiNjk3ZmU3MTJiNWI2NmMyYTRmNWMyYWMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <71ae0c0aafb37f0c8f7feddc4c21cacb651e392c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWXla-000000005Td-3IoX
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Windows: Switch all
 uses of address family to ADDRESS_FAMILY type
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5030056193361822450=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5030056193361822450==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nZ1jaVPsG2w="; charset=UTF-8

--nZ1jaVPsG2w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
342?usp=3Demail )

The following approvals got outdated and were removed:
B=
uild-Request+1 by Frank Lichtenheld, Code-Review+2 by R=C4=83zvan Cojocaru
=


Change subject: Windows: Switch all uses of address family to ADDRESS_FAM=
ILY type
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Wind=
ows: Switch all uses of address family to ADDRESS_FAMILY type

Previously w=
e had conversion errors between short
and unsigned short=2E

Also remove us=
eless SetNameServers wrapper=2E Wrapping
only a name is really not that use=
ful=2E

Add a definition for ADDRESS_FAMILY for cppcheck=2E
The built-in wi=
ndows platform definition doesn't
cover it=2E

Change-Id: I225c21dbd843601b=
697fe712b5b66c2a4f5c2ac2
Signed-off-by: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342
Message-Id: <20261125173055=2E2=
3341-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openv=
pn-devel@lists=2Esourceforge=2Enet/msg41952=2Ehtml
Signed-off-by: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
---
M dev-tools/openvpn-cppcheck-windows=2Ecf=
g
M include/openvpn-msg=2Eh
M src/openvpn/tun=2Ec
M src/openvpnserv/interac=
tive=2Ec
4 files changed, 22 insertions(+), 36 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/2342/3

diff --git=
 a/dev-tools/openvpn-cppcheck-windows=2Ecfg b/dev-tools/openvpn-cppcheck-wi=
ndows=2Ecfg
index dca2b07=2E=2E19d32a1 100644
--- a/dev-tools/openvpn-cppch=
eck-windows=2Ecfg
+++ b/dev-tools/openvpn-cppcheck-windows=2Ecfg
@@ -8,6 +8=
,7 @@
       <formatstr />
     </arg>
   </function>
+  <podtype name=3D"A=
DDRESS_FAMILY" sign=3D"u" size=3D"2" />
   <!-- MinGW uses GCC, so we need =
to handle GCC builtins=2E gnu=2Ecfg has these,
        but we do not load i=
t for Windows=2E Without this cppcheck does not
        understand our like=
ly()/unlikely() macros=2E -->
diff --git a/include/openvpn-msg=2Eh b/includ=
e/openvpn-msg=2Eh
index ca3267e8=2E=2Edd20f7b 100644
--- a/include/openvpn-=
msg=2Eh
+++ b/include/openvpn-msg=2Eh
@@ -80,7 +80,7 @@
 typedef struct
 {
=
     message_header_t header;
-    short family;
+    ADDRESS_FAMILY family=
;
     inet_address_t address;
     int prefix_len;
     interface_t iface;=

@@ -89,7 +89,7 @@
 typedef struct
 {
     message_header_t header;
-    sh=
ort family;
+    ADDRESS_FAMILY family;
     inet_address_t prefix;
     in=
t prefix_len;
     inet_address_t gateway;
@@ -102,7 +102,7 @@
     message=
_header_t header;
     interface_t iface;
     char domains[512];
-    shor=
t family;
+    ADDRESS_FAMILY family;
     unsigned int addr_len;
     inet=
_address_t addr[4]; /* support up to 4 dns addresses */
 } dns_cfg_message_=
t;
@@ -150,7 +150,7 @@
 typedef struct
 {
     message_header_t header;
-  =
  short family;
+    ADDRESS_FAMILY family;
     interface_t iface;
 } flus=
h_neighbors_message_t;
 
@@ -177,7 +177,7 @@
 {
     message_header_t heade=
r;
     interface_t iface;
-    short family;
+    ADDRESS_FAMILY family;
 =
    int mtu;
 } set_mtu_message_t;
 
diff --git a/src/openvpn/tun=2Ec b/src=
/openvpn/tun=2Ec
index fe1af45=2E=2E65edf73 100644
--- a/src/openvpn/tun=2E=
c
+++ b/src/openvpn/tun=2Ec
@@ -101,7 +101,7 @@
 static void netsh_ifconfig=
(const struct tuntap_options *to, DWORD adapter_index, const in_addr_t ip,
=
                            const in_addr_t netmask, const unsigned int fla=
gs);
 
-static void windows_set_mtu(const int iface_index, const short fami=
ly, const int mtu);
+static void windows_set_mtu(const int iface_index, con=
st ADDRESS_FAMILY family, const int mtu);
 
 static void netsh_set_dns6_ser=
vers(const struct in6_addr *addr_list, const unsigned int addr_len,
       =
                             DWORD adapter_index);
@@ -118,7 +118,7 @@
 #en=
dif
 
 static bool
-do_address_service(const bool add, const short family, =
const struct tuntap *tt)
+do_address_service(const bool add, const ADDRESS_=
FAMILY family, const struct tuntap *tt)
 {
     bool ret =3D false;
     ac=
k_message_t ack;
@@ -241,7 +241,7 @@
 }
 
 static void
-do_dns_service(bool=
 add, const short family, const struct tuntap *tt)
+do_dns_service(bool add=
, const ADDRESS_FAMILY family, const struct tuntap *tt)
 {
     ack_message=
_t ack;
     struct gc_arena gc =3D gc_new();
@@ -366,7 +366,7 @@
 }
 
 sta=
tic bool
-do_set_mtu_service(const struct tuntap *tt, const short family, c=
onst int mtu)
+do_set_mtu_service(const struct tuntap *tt, const ADDRESS_FA=
MILY family, const int mtu)
 {
     bool ret =3D false;
     ack_message_t =
ack;
@@ -5320,7 +5320,7 @@
 }
 
 static void
-windows_set_mtu(const int ifa=
ce_index, const short family, const int mtu)
+windows_set_mtu(const int ifa=
ce_index, const ADDRESS_FAMILY family, const int mtu)
 {
     DWORD err =3D=
 0;
     MIB_IPINTERFACE_ROW ipiface;
diff --git a/src/openvpnserv/interact=
ive=2Ec b/src/openvpnserv/interactive=2Ec
index 77b91e0=2E=2Ed155fd6 100644=

--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2E=
c
@@ -529,7 +529,7 @@
 #endif
 
 static SOCKADDR_INET
-sockaddr_inet(short =
family, const inet_address_t *addr)
+sockaddr_inet(ADDRESS_FAMILY family, c=
onst inet_address_t *addr)
 {
     SOCKADDR_INET sa_inet;
     ZeroMemory(&=
sa_inet, sizeof(sa_inet));
@@ -1858,7 +1858,7 @@
  * @return BOOL to indica=
te success or failure
  */
 static BOOL
-GetInterfacesKey(short family, PHK=
EY key)
+GetInterfacesKey(ADDRESS_FAMILY family, PHKEY key)
 {
     PCSTR i=
tfs_key =3D family =3D=3D AF_INET6
                          ? "SYSTEM\\Cur=
rentControlSet\\Services\\Tcpip6\\Parameters\\Interfaces"
@@ -1868,7 +1868,=
7 @@
     if (err)
     {
         *key =3D INVALID_HANDLE_VALUE;
-        =
MsgToEventLog(M_SYSERR, L"%S: could not open interfaces registry key for fa=
mily %d (%lu)",
+        MsgToEventLog(M_SYSERR, L"%S: could not open inter=
faces registry key for family %hu (%lu)",
                       __func__, =
family, err);
     }
 
@@ -1885,7 +1885,7 @@
  * @return DWORD NO_ERROR on =
success, a Windows error code otherwise
  */
 static DWORD
-SetNameServersV=
alue(PCWSTR itf_id, short family, PCSTR value)
+SetNameServersValue(PCWSTR =
itf_id, ADDRESS_FAMILY family, PCSTR value)
 {
     DWORD err;
 
@@ -1899,7=
 +1899,7 @@
     err =3D RegOpenKeyExW(itfs, itf_id, 0, KEY_ALL_ACCESS, &it=
f);
     if (err)
     {
-        MsgToEventLog(M_SYSERR, L"%S: could not o=
pen interface key for %s family %d (%lu)",
+        MsgToEventLog(M_SYSERR,=
 L"%S: could not open interface key for %s family %hu (%lu)",
             =
          __func__, itf_id, family, err);
         goto out;
     }
@@ -190=
7,7 +1907,7 @@
     err =3D RegSetValueExA(itf, "NameServer", 0, REG_SZ, (P=
BYTE)value, (DWORD)strlen(value) + 1);
     if (err)
     {
-        MsgToE=
ventLog(M_SYSERR, L"%S: could not set name servers '%S' for %s family %d (%=
lu)",
+        MsgToEventLog(M_SYSERR, L"%S: could not set name servers '%S=
' for %s family %hu (%lu)",
                       __func__, value, itf_id,=
 family, err);
     }
 
@@ -1924,21 +1924,6 @@
 }
 
 /**
- * Set the DNS na=
me servers in a registry interface configuration
- *
- * @param itf_id    t=
he interface id to set the servers for
- * @param family    internet addres=
s family to set the servers for
- * @param addrs     comma separated list o=
f name server addresses
- *
- * @return DWORD NO_ERROR on success, a Window=
s error code otherwise
- */
-static DWORD
-SetNameServers(PCWSTR itf_id, sh=
ort family, PCSTR addrs)
-{
-    return SetNameServersValue(itf_id, family,=
 addrs);
-}
-
-/**
  * Delete all DNS name servers from a registry interfac=
e configuration
  *
  * @param itf_id    the interface id to clear the serv=
ers for
@@ -1947,7 +1932,7 @@
  * @return DWORD NO_ERROR on success, a Wind=
ows error code otherwise
  */
 static DWORD
-ResetNameServers(PCWSTR itf_id=
, short family)
+ResetNameServers(PCWSTR itf_id, ADDRESS_FAMILY family)
 {
=
     return SetNameServersValue(itf_id, family, "");
 }
@@ -2035,7 +2020,7 =
@@
             offset =3D strlen(addrs);
         }
 
-        err =3D Set=
NameServers(iid, msg->family, addrs);
+        err =3D SetNameServersValue(=
iid, msg->family, addrs);
         if (err)
         {
             return =
err;
@@ -2096,10 +2081,10 @@
 static LSTATUS
 SetNameServerAddresses(PWSTR =
itf_id, const nrpt_address_t *addresses)
 {
-    const short families[] =3D=
 { AF_INET, AF_INET6 };
+    const ADDRESS_FAMILY families[] =3D { AF_INET,=
 AF_INET6 };
     for (size_t i =3D 0; i < _countof(families); i++)
     {
=
-        short family =3D families[i];
+        ADDRESS_FAMILY family =3D f=
amilies[i];
 
         /* Create a comma sparated list of addresses of this=
 family */
         size_t offset =3D 0;
@@ -2127,7 +2112,7 @@
         }
 =

         /* Set name server addresses */
-        LSTATUS err =3D SetNameS=
ervers(itf_id, family, addr_list);
+        LSTATUS err =3D SetNameServersV=
alue(itf_id, family, addr_list);
         if (err)
         {
             =
return err;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2342?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I22=
5c21dbd843601b697fe712b5b66c2a4f5c2ac2
Gerrit-Change-Number: 2342
Gerrit-Pa=
tchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>

--nZ1jaVPsG2w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2342?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Build-Request+1 by Frank Lichtenheld, Code-Review+2 b=
y R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Windows: Switch all uses of address=
 family to ADDRESS_FAMILY type<br><br>Previously we had conversion errors b=
etween short<br>and unsigned short=2E<br><br>Also remove useless SetNameSer=
vers wrapper=2E Wrapping<br>only a name is really not that useful=2E<br><br=
>Add a definition for ADDRESS_FAMILY for cppcheck=2E<br>The built-in window=
s platform definition doesn&#39;t<br>cover it=2E<br><br>Change-Id: I225c21d=
bd843601b697fe712b5b66c2a4f5c2ac2<br>Signed-off-by: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342<b=
r>Message-Id: &lt;20261125173055=2E23341-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg41952=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M dev-tools/openvpn-cppcheck-windows=2Ecfg<br>M include/ope=
nvpn-msg=2Eh<br>M src/openvpn/tun=2Ec<br>M src/openvpnserv/interactive=2Ec<=
br>4 files changed, 22 insertions(+), 36 deletions(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/2=
342/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/dev-tools/openvpn-cppcheck-windows=2Ecfg b/dev-t=
ools/openvpn-cppcheck-windows=2Ecfg</span><br><span>index dca2b07=2E=2E19d3=
2a1 100644</span><br><span>--- a/dev-tools/openvpn-cppcheck-windows=2Ecfg</=
span><br><span>+++ b/dev-tools/openvpn-cppcheck-windows=2Ecfg</span><br><sp=
an>@@ -8,6 +8,7 @@</span><br><span>       &lt;formatstr /&gt;</span><br><sp=
an>     &lt;/arg&gt;</span><br><span>   &lt;/function&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  &lt;podtype name=3D&quot;ADDRESS_FA=
MILY&quot; sign=3D&quot;u&quot; size=3D&quot;2&quot; /&gt;</span><br><span>=
   &lt;!-- MinGW uses GCC, so we need to handle GCC builtins=2E gnu=2Ecfg h=
as these,</span><br><span>        but we do not load it for Windows=2E With=
out this cppcheck does not</span><br><span>        understand our likely()/=
unlikely() macros=2E --&gt;</span><br><span>diff --git a/include/openvpn-ms=
g=2Eh b/include/openvpn-msg=2Eh</span><br><span>index ca3267e8=2E=2Edd20f7b=
 100644</span><br><span>--- a/include/openvpn-msg=2Eh</span><br><span>+++ b=
/include/openvpn-msg=2Eh</span><br><span>@@ -80,7 +80,7 @@</span><br><span>=
 typedef struct</span><br><span> {</span><br><span>     message_header_t he=
ader;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    short family=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ADDRESS_FAMILY=
 family;</span><br><span>     inet_address_t address;</span><br><span>     =
int prefix_len;</span><br><span>     interface_t iface;</span><br><span>@@ =
-89,7 +89,7 @@</span><br><span> typedef struct</span><br><span> {</span><br=
><span>     message_header_t header;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    short family;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ADDRESS_FAMILY family;</span><br><span>     inet_address_t=
 prefix;</span><br><span>     int prefix_len;</span><br><span>     inet_add=
ress_t gateway;</span><br><span>@@ -102,7 +102,7 @@</span><br><span>     me=
ssage_header_t header;</span><br><span>     interface_t iface;</span><br><s=
pan>     char domains[512];</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    short family;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ADDRESS_FAMILY family;</span><br><span>     unsigned int addr_len;<=
/span><br><span>     inet_address_t addr[4]; /* support up to 4 dns address=
es */</span><br><span> } dns_cfg_message_t;</span><br><span>@@ -150,7 +150,=
7 @@</span><br><span> typedef struct</span><br><span> {</span><br><span>   =
  message_header_t header;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    short family;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ADDRESS_FAMILY family;</span><br><span>     interface_t iface;</span=
><br><span> } flush_neighbors_message_t;</span><br><span> </span><br><span>=
@@ -177,7 +177,7 @@</span><br><span> {</span><br><span>     message_header_=
t header;</span><br><span>     interface_t iface;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    short family;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ADDRESS_FAMILY family;</span><br><span>     i=
nt mtu;</span><br><span> } set_mtu_message_t;</span><br><span> </span><br><=
span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span=
>index fe1af45=2E=2E65edf73 100644</span><br><span>--- a/src/openvpn/tun=2E=
c</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -101,7 +101,=
7 @@</span><br><span> static void netsh_ifconfig(const struct tuntap_option=
s *to, DWORD adapter_index, const in_addr_t ip,</span><br><span>           =
                 const in_addr_t netmask, const unsigned int flags);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static voi=
d windows_set_mtu(const int iface_index, const short family, const int mtu)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void window=
s_set_mtu(const int iface_index, const ADDRESS_FAMILY family, const int mtu=
);</span><br><span> </span><br><span> static void netsh_set_dns6_servers(co=
nst struct in6_addr *addr_list, const unsigned int addr_len,</span><br><spa=
n>                                    DWORD adapter_index);</span><br><span=
>@@ -118,7 +118,7 @@</span><br><span> #endif</span><br><span> </span><br><s=
pan> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_ad=
dress_service(const bool add, const short family, const struct tuntap *tt)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_address_service(c=
onst bool add, const ADDRESS_FAMILY family, const struct tuntap *tt)</span>=
<br><span> {</span><br><span>     bool ret =3D false;</span><br><span>     =
ack_message_t ack;</span><br><span>@@ -241,7 +241,7 @@</span><br><span> }</=
span><br><span> </span><br><span> static void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-do_dns_service(bool add, const short family, const =
struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+d=
o_dns_service(bool add, const ADDRESS_FAMILY family, const struct tuntap *t=
t)</span><br><span> {</span><br><span>     ack_message_t ack;</span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span>@@ -366,7 +366,7 @=
@</span><br><span> }</span><br><span> </span><br><span> static bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-do_set_mtu_service(const stru=
ct tuntap *tt, const short family, const int mtu)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+do_set_mtu_service(const struct tuntap *tt, c=
onst ADDRESS_FAMILY family, const int mtu)</span><br><span> {</span><br><sp=
an>     bool ret =3D false;</span><br><span>     ack_message_t ack;</span><=
br><span>@@ -5320,7 +5320,7 @@</span><br><span> }</span><br><span> </span><=
br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
windows_set_mtu(const int iface_index, const short family, const int mtu)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+windows_set_mtu(const=
 int iface_index, const ADDRESS_FAMILY family, const int mtu)</span><br><sp=
an> {</span><br><span>     DWORD err =3D 0;</span><br><span>     MIB_IPINTE=
RFACE_ROW ipiface;</span><br><span>diff --git a/src/openvpnserv/interactive=
=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 77b91e0=2E=2Ed=
155fd6 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><=
br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -529,7 +5=
29,7 @@</span><br><span> #endif</span><br><span> </span><br><span> static S=
OCKADDR_INET</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sockaddr_=
inet(short family, const inet_address_t *addr)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+sockaddr_inet(ADDRESS_FAMILY family, const inet_=
address_t *addr)</span><br><span> {</span><br><span>     SOCKADDR_INET sa_i=
net;</span><br><span>     ZeroMemory(&amp;sa_inet, sizeof(sa_inet));</span>=
<br><span>@@ -1858,7 +1858,7 @@</span><br><span>  * @return BOOL to indicat=
e success or failure</span><br><span>  */</span><br><span> static BOOL</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-GetInterfacesKey(short fam=
ily, PHKEY key)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+GetI=
nterfacesKey(ADDRESS_FAMILY family, PHKEY key)</span><br><span> {</span><br=
><span>     PCSTR itfs_key =3D family =3D=3D AF_INET6</span><br><span>     =
                     ? &quot;SYSTEM\\CurrentControlSet\\Services\\Tcpip6\\P=
arameters\\Interfaces&quot;</span><br><span>@@ -1868,7 +1868,7 @@</span><br=
><span>     if (err)</span><br><span>     {</span><br><span>         *key =
=3D INVALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        MsgToEventLog(M_SYSERR, L&quot;%S: could not open interfaces re=
gistry key for family %d (%lu)&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;%S: could not open=
 interfaces registry key for family %hu (%lu)&quot;,</span><br><span>      =
                 __func__, family, err);</span><br><span>     }</span><br><=
span> </span><br><span>@@ -1885,7 +1885,7 @@</span><br><span>  * @return DW=
ORD NO_ERROR on success, a Windows error code otherwise</span><br><span>  *=
/</span><br><span> static DWORD</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-SetNameServersValue(PCWSTR itf_id, short family, PCSTR value)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+SetNameServersValue(PCW=
STR itf_id, ADDRESS_FAMILY family, PCSTR value)</span><br><span> {</span><b=
r><span>     DWORD err;</span><br><span> </span><br><span>@@ -1899,7 +1899,=
7 @@</span><br><span>     err =3D RegOpenKeyExW(itfs, itf_id, 0, KEY_ALL_AC=
CESS, &amp;itf);</span><br><span>     if (err)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_SYS=
ERR, L&quot;%S: could not open interface key for %s family %d (%lu)&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLo=
g(M_SYSERR, L&quot;%S: could not open interface key for %s family %hu (%lu)=
&quot;,</span><br><span>                       __func__, itf_id, family, er=
r);</span><br><span>         goto out;</span><br><span>     }</span><br><sp=
an>@@ -1907,7 +1907,7 @@</span><br><span>     err =3D RegSetValueExA(itf, &=
quot;NameServer&quot;, 0, REG_SZ, (PBYTE)value, (DWORD)strlen(value) + 1);<=
/span><br><span>     if (err)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        MsgToEventLog(M_SYSERR, L&quot;%S: =
could not set name servers &#39;%S&#39; for %s family %d (%lu)&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_S=
YSERR, L&quot;%S: could not set name servers &#39;%S&#39; for %s family %hu=
 (%lu)&quot;,</span><br><span>                       __func__, value, itf_i=
d, family, err);</span><br><span>     }</span><br><span> </span><br><span>@=
@ -1924,21 +1924,6 @@</span><br><span> }</span><br><span> </span><br><span>=
 /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Set the DNS na=
me servers in a registry interface configuration</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * @param itf_id    the interface id to set the servers for</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * @param family    internet =
address family to set the servers for</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @param addrs     comma separated list of name server add=
resses</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * @return DWORD NO_ERROR on succe=
ss, a Windows error code otherwise</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stati=
c DWORD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-SetNameServers=
(PCWSTR itf_id, short family, PCSTR addrs)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return SetNameServersValue(itf_id, family, addrs);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</sp=
an><br><span>  * Delete all DNS name servers from a registry interface conf=
iguration</span><br><span>  *</span><br><span>  * @param itf_id    the inte=
rface id to clear the servers for</span><br><span>@@ -1947,7 +1932,7 @@</sp=
an><br><span>  * @return DWORD NO_ERROR on success, a Windows error code ot=
herwise</span><br><span>  */</span><br><span> static DWORD</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-ResetNameServers(PCWSTR itf_id, short =
family)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ResetNameSer=
vers(PCWSTR itf_id, ADDRESS_FAMILY family)</span><br><span> {</span><br><sp=
an>     return SetNameServersValue(itf_id, family, &quot;&quot;);</span><br=
><span> }</span><br><span>@@ -2035,7 +2020,7 @@</span><br><span>           =
  offset =3D strlen(addrs);</span><br><span>         }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D SetNameS=
ervers(iid, msg-&gt;family, addrs);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        err =3D SetNameServersValue(iid, msg-&gt;family, ad=
drs);</span><br><span>         if (err)</span><br><span>         {</span><b=
r><span>             return err;</span><br><span>@@ -2096,10 +2081,10 @@</s=
pan><br><span> static LSTATUS</span><br><span> SetNameServerAddresses(PWSTR=
 itf_id, const nrpt_address_t *addresses)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const short families[] =3D { AF_=
INET, AF_INET6 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const ADDRESS_FAMILY families[] =3D { AF_INET, AF_INET6 };</span><br><spa=
n>     for (size_t i =3D 0; i &lt; _countof(families); i++)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        short =
family =3D families[i];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        ADDRESS_FAMILY family =3D families[i];</span><br><span> </span>=
<br><span>         /* Create a comma sparated list of addresses of this fam=
ily */</span><br><span>         size_t offset =3D 0;</span><br><span>@@ -21=
27,7 +2112,7 @@</span><br><span>         }</span><br><span> </span><br><spa=
n>         /* Set name server addresses */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        LSTATUS err =3D SetNameServers(itf_id, family,=
 addr_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 LSTATUS err =3D SetNameServersValue(itf_id, family, addr_list);</span><br>=
<span>         if (err)</span><br><span>         {</span><br><span>        =
     return err;</span><br></pre><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail">change 2342</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2342?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I225c21dbd843=
601b697fe712b5b66c2a4f5c2ac2 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2342 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</b=
ody></html>
--nZ1jaVPsG2w=--


--===============5030056193361822450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5030056193361822450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5030056193361822450==--

