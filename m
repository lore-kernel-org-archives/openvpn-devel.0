Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0E1606A885
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=M0GglLTg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WnkKCGmy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Si0aeXqh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=My/k06YH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ja1qiXEOX5WsFNLnToUuxw9ZR7JSUQqTzKgOIVS/TRw=; b=M0GglLTgwTfLbNc05jv6T4kY7k
	df9Wfgfght12d2JGPKVyFYbeIK465IXRP4THrSUcZB9Xw3yohE16oRQ/06w30zXVDNLvlgxM170Bw
	9MZtenf0vw3R/7NbZWiratOAChVR02H/pAkl2DegTxbsVvQbIB58vSv2WglVK1Idblf8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYLA-000000002TT-3cpL;
	Thu, 12 Nov 2026 17:12:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRYL6-000000002SV-1h2J
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:11:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aRJw8jMMCV+TXtWMoyUhKvmpscS8IAtVCUbQT4MKa2o=; b=WnkKCGmy3tGEFX2ZQVyDMNssWN
 oDsTp4VqNiWddLVt4WFI54wglWrGYsVjEsJf/38YXXdDSgJx+Sdl8uquxmNhkS47jLsu74UJmhhox
 2+eWT+p6O4M4PrYgCNnn1nmG4iq4doVhOO2Sxs41E4oBy9JYl/5Byl3O8zbWK59e5f2Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aRJw8jMMCV+TXtWMoyUhKvmpscS8IAtVCUbQT4MKa2o=; b=Si0aeXqhfCNWWAwEaNPveHiECY
 OAlMrEkOrurRH1O6UyO9Zp0MBrmx76mnbFPvdyqmv6GD2AM4atgbOOzTZ4EyxwGNpuJ2KjB29tc1a
 so1LX3KeqxevuHaCnFYY4e3XQK1Wv6KUR0O3lQg5E3IQQRZGjmnMlnxKlgkWHiO1vofw=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRYL0-000000002wX-3fkB for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:11:55 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so115365e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794503504; x=1795108304; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aRJw8jMMCV+TXtWMoyUhKvmpscS8IAtVCUbQT4MKa2o=;
 b=My/k06YHi06XOjdGAO/geieL6brEX61kof+0pQs+JJudh0814MROLEm5C3RyqPVNn3
 ro+8yhdEolNMFtNhwl/SWYeOfkvgGPwx4/w+SNvMhDt8LhQtVpHtO4CfEI1r0ncHQQgE
 1X26OyBfOTgWz+QBHoLWYZ888kDc+EEH6oIYei6d6HGfrTlwekzD585ek3RveLF6BW9N
 lMA2ToVMvIUkI6qffnKOQ58nQYrTSNOPuRaOU8asW/UC1WIKJPvxaJZkkt+gknDYI9Fj
 5Zr/gD8mepIlNMKhj7sYg+zzyaMwIyYLw2DSfWY+H1pbEeNZ0rPevYEvwvKspxTXycaL
 yw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794503504; x=1795108304;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aRJw8jMMCV+TXtWMoyUhKvmpscS8IAtVCUbQT4MKa2o=;
 b=BQEBaaqjMh8jEP31sQPdA5/PBnDFb1+RG4AGAt5LwAtITYqIC76sAR6hHdk52gStHw
 WMFu8Up2hqiW2pHL+3QJp37Ql/+wsSbUNreFepDDgPEvKOZuLZvy/LNNZ7bED46dHXKd
 oi7jlJ/cNMzEv+rhfRZKE+6kpKeWatzKxfZqDWjE7J5hzPq1H65PSZLoU2YsYY5/NpTW
 gRQb7MM9IwPkdpKXVuoY6lxkyQliQTzRh2fAfqzMN2tnHkupD5jSZP0TQObF2G3kG9Ms
 8V8YlVKHVtKZaO6ctTR7MMF7Bcsg2O2B7VYtdkjzrVV0FWxypFKjpLhysE+rTFQnk3cZ
 x5IQ==
X-Gm-Message-State: APuU4Z9fyXIzMqnyYeHQ9KV+f+lv8yKMkoAebCaZ+ASewTkFONvvWd32
 4KelxOuulrquAbd0Dt9W2jOaVFhnrTPvsNkLoRp43CS4z6UIuBs8tB2reE8JHyMm/opjCVRC1C/
 GvC+B9j+Rogh08YZCPKp0dLamRBr9U5J9olhRfzElcNiSU032YuXBJ1aWpPmhtz9er+XfyoFnLv
 tvMNLHWw==
X-Gm-Gg: AYBFou07ob+4tWHMn/D8DlHHF+XoXQPgQd+PF81lXNjjUEZWDnPI72wbnF2D9K9XNF0
 XNFY/pGOKDYprjcksKBgvSOuzDZ+rImsdyski4wsDhDSBFGsSv7PtUiGRmbsdahX2j8QfgnzXzo
 zIpMEYLHUhZs9pNfWMWUqh0RgF4yWDpq8W/try1jrAPF6vCYZcQffuMwSGxUL+ohjqncGD1Cu/2
 q6y+SH2SK3spEGbLcOjxNoS2B1Huj6S1GXwLJyB5NAi+8y2JSJzsxF4v6njsdSG+OEel7m50Vk+
 W3whCJdSdMesGpWzpL6GfYUptOcfOXFWpGe2ca/UG/WZdf5E5z/4Bbg0NyCJLHINo/4+FPFsdvH
 z/+gbJC8mLelkUH7uEVF+d1guKuYb1WiWuG4dQipy8J6GYVcE4dXag/MTHdHzIucsSb5DpUg5Nt
 eDonJb94YTPzrwOIJfExKJPE9HUsAKHk+074II4Dxu0bZKs1on2H0/837KFPtXWQ4XIR7z1OPAK
 gk1XvVNME7QvqHD97BcIi4dwBYt7rsLMbkTebxYFVyR34hH4XB018WiOwU+NKsWbe5FeLw+vMQL
 xdBAh1x1JcO+OMDaMiiREerQjErCcU8tg6CJpYMHa4fp0TufhoylgBFoweO/8a7HNDv9M9bMCIP
 LImN0zqpZcdTbd+stSlk93Smd8pQ76VgasIIR/ehFU5nH4ZzmibSmbEoP5GC+hPK/Y6wo7eMrD5
 CVo55+kazGZbDjjl0=
X-Received: by 2002:a05:600c:e558:10b0:4a3:18ca:806 with SMTP id
 5b1f17b1804b1-4ba0938e116mr74630695e9.20.1794503504037; 
 Thu, 12 Nov 2026 09:11:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e251686sm82699535e9.3.2026.11.12.09.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:11:43 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:11:31 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
X-Gerrit-Change-Number: 2177
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2177?usp=email>
X-Gerrit-Commit: 94d1c3ad8e783a6f7831b2d676f80a276bfc45b3
In-Reply-To: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
References: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkk2ZjVjYTUzZDQyODhiMDkyMTYxMGY3YTNmODRhZDU1ZDJhYjQ5MTE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <65da50d3be4e9d1c13b62923cdb6965a0aeab52c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRYL0-000000002wX-3fkB
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking_sitnl:
 Reduce boilerplate code for parameter checks
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3160779006563511525=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3160779006563511525==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="coj5PQClU3Y="; charset=UTF-8

--coj5PQClU3Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2177?usp=3Demail

to look at the new patch set (#2)=2E

The f=
ollowing approvals got outdated and were removed:
Code-Review-1 by R=C4=83z=
van Cojocaru


Change subject: networking_sitnl: Reduce boilerplate code fo=
r parameter checks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

networking_sitnl: Reduce boilerplate code for parameter checks

Als=
o removes some inconsistencies and some
sign conversion warnings=2E

Change=
-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
Signed-off-by: Frank Lichten=
held <frank@lichtenheld=2Ecom>
---
M src/openvpn/networking_sitnl=2Ec
1 fil=
e changed, 74 insertions(+), 169 deletions(-)


  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/77/2177/2

diff --git a/src/openvpn=
/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index 501c635=2E=
=2Eee6229b 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/=
networking_sitnl=2Ec
@@ -673,25 +673,37 @@
 
 #ifdef ENABLE_SITNL
 
+static=
 int
+get_ifindex(const char *func, const char *iface, uint32_t *ifindex)
+=
{
+    if (!iface)
+    {
+        msg(M_WARN, "%s: passed NULL interface",=
 func);
+        return -EINVAL;
+    }
+
+    *ifindex =3D if_nametoindex(=
iface);
+    if (*ifindex =3D=3D 0)
+    {
+        msg(M_WARN | M_ERRNO, "=
%s: rtnl: cannot get ifindex for %s", func, iface);
+        return -ENOENT=
;
+    }
+    return 0;
+}
+
+
 int
 net_iface_up(const openvpn_net_ctx_t *=
ctx, const char *iface, bool up)
 {
     struct sitnl_link_req req;
-    in=
t ifindex;
+    uint32_t ifindex;
 
     CLEAR(req);
 
-    if (!iface)
+  =
  const int ret =3D get_ifindex(__func__, iface, &ifindex);
+    if (ret < =
0)
     {
-        msg(M_WARN, "%s: passed NULL interface", __func__);
-   =
     return -EINVAL;
-    }
-
-    ifindex =3D if_nametoindex(iface);
-    =
if (ifindex =3D=3D 0)
-    {
-        msg(M_WARN, "%s: rtnl: cannot get ifi=
ndex for %s: %s", __func__, iface, strerror(errno));
-        return -ENOEN=
T;
+        return ret;
     }
 
     req=2En=2Enlmsg_len =3D NLMSG_LENGTH(=
sizeof(req=2Ei));
@@ -699,7 +711,7 @@
     req=2En=2Enlmsg_type =3D RTM_SET=
LINK;
 
     req=2Ei=2Eifi_family =3D AF_PACKET;
-    req=2Ei=2Eifi_index =
=3D ifindex;
+    req=2Ei=2Eifi_index =3D (int)ifindex;
     req=2Ei=2Eifi_=
change |=3D IFF_UP;
     if (up)
     {
@@ -707,7 +719,7 @@
     }
     els=
e
     {
-        req=2Ei=2Eifi_flags &=3D ~IFF_UP;
+        req=2Ei=2Eifi_=
flags &=3D ~(unsigned int)IFF_UP;
     }
 
     msg(M_INFO, "%s: set %s %s"=
, __func__, iface, up ? "up" : "down");
@@ -719,14 +731,13 @@
 net_iface_mt=
u_set(const openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
 {
   =
  struct sitnl_link_req req;
-    int ifindex, ret =3D -1;
+    int ret =3D=
 -1;
+    uint32_t ifindex;
 
     CLEAR(req);
 
-    ifindex =3D if_nameto=
index(iface);
-    if (ifindex =3D=3D 0)
+    if (get_ifindex(__func__, ifa=
ce, &ifindex) < 0)
     {
-        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot =
get ifindex for %s", __func__, iface);
         return -1;
     }
 
@@ -735=
,7 +746,7 @@
     req=2En=2Enlmsg_type =3D RTM_SETLINK;
 
     req=2Ei=2Eif=
i_family =3D AF_PACKET;
-    req=2Ei=2Eifi_index =3D ifindex;
+    req=2Ei=
=2Eifi_index =3D (int)ifindex;
 
     SITNL_ADDATTR(&req=2En, sizeof(req), =
IFLA_MTU, &mtu, 4);
 
@@ -750,14 +761,13 @@
 net_addr_ll_set(const openvpn_=
net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr)
 {
     st=
ruct sitnl_link_req req;
-    int ifindex, ret =3D -1;
+    int ret =3D -1;=

+    uint32_t ifindex;
 
     CLEAR(req);
 
-    ifindex =3D if_nametoinde=
x(iface);
-    if (ifindex =3D=3D 0)
+    if (get_ifindex(__func__, iface, =
&ifindex) < 0)
     {
-        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get =
ifindex for %s", __func__, iface);
         return -1;
     }
 
@@ -766,7 +=
776,7 @@
     req=2En=2Enlmsg_type =3D RTM_SETLINK;
 
     req=2Ei=2Eifi_fa=
mily =3D AF_PACKET;
-    req=2Ei=2Eifi_index =3D ifindex;
+    req=2Ei=2Eif=
i_index =3D (int)ifindex;
 
     SITNL_ADDATTR(&req=2En, sizeof(req), IFLA_=
ADDRESS, addr, OPENVPN_ETH_ALEN);
 
@@ -778,22 +788,19 @@
 }
 
 static int
=
-sitnl_addr_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_f=
amily,
+sitnl_addr_set(uint16_t cmd, uint16_t flags, const char *iface, sa_=
family_t af_family,
                const inet_address_t *local, const inet=
_address_t *remote, int prefixlen)
 {
     struct sitnl_addr_req req;
-    =
uint32_t size;
-    int ret =3D -EINVAL;
+    size_t size;
+    uint32_t if=
index;
 
-    CLEAR(req);
-
-    req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeo=
f(req=2Ei));
-    req=2En=2Enlmsg_type =3D cmd;
-    req=2En=2Enlmsg_flags =
=3D NLM_F_REQUEST | flags;
-
-    req=2Ei=2Eifa_index =3D ifindex;
-    ASS=
ERT(af_family <=3D UINT8_MAX);
-    req=2Ei=2Eifa_family =3D (uint8_t)af_fa=
mily;
+    int ret =3D get_ifindex(__func__, iface, &ifindex);
+    if (ret=
 < 0)
+    {
+        return ret;
+    }
+    ret =3D -EINVAL; /* for SITNL=
_ADDATTR */
 
     switch (af_family)
     {
@@ -810,10 +817,20 @@
        =
     return -EINVAL;
     }
 
+    CLEAR(req);
+
+    req=2En=2Enlmsg_len =
=3D NLMSG_LENGTH(sizeof(req=2Ei));
+    req=2En=2Enlmsg_type =3D cmd;
+    =
req=2En=2Enlmsg_flags =3D NLM_F_REQUEST | flags;
+
+    req=2Ei=2Eifa_index=
 =3D ifindex;
+    ASSERT(af_family <=3D UINT8_MAX);
+    req=2Ei=2Eifa_fam=
ily =3D (uint8_t)af_family;
+
     /* if no prefixlen has been specified, a=
ssume host address */
     if (prefixlen =3D=3D 0)
     {
-        prefixle=
n =3D size * 8;
+        prefixlen =3D (int)size * 8;
     }
     ASSERT(pr=
efixlen <=3D UINT8_MAX);
     req=2Ei=2Eifa_prefixlen =3D (uint8_t)prefixle=
n;
@@ -848,76 +865,37 @@
 sitnl_addr_ptp_add(sa_family_t af_family, const c=
har *iface, const inet_address_t *local,
                    const inet_add=
ress_t *remote)
 {
-    int ifindex;
-
-    switch (af_family)
-    {
-    =
    case AF_INET:
-        case AF_INET6:
-            break;
-
-        de=
fault:
-            return -EINVAL;
-    }
-
-    if (!iface)
-    {
-     =
   msg(M_WARN, "%s: passed NULL interface", __func__);
-        return -EIN=
VAL;
-    }
-
-    ifindex =3D if_nametoindex(iface);
-    if (ifindex =3D=
=3D 0)
-    {
-        msg(M_WARN, "%s: cannot get ifindex for %s: %s", __f=
unc__, np(iface), strerror(errno));
-        return -ENOENT;
-    }
-
-    =
return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, a=
f_family, local,
+    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM=
_F_REPLACE, iface, af_family, local,
                           remote, 0);=

 }
 
 static int
 sitnl_addr_ptp_del(sa_family_t af_family, const char *if=
ace, const inet_address_t *local)
 {
-    int ifindex;
-
-    switch (af_fa=
mily)
-    {
-        case AF_INET:
-        case AF_INET6:
-            br=
eak;
-
-        default:
-            return -EINVAL;
-    }
-
-    if (!if=
ace)
-    {
-        msg(M_WARN, "%s: passed NULL interface", __func__);
- =
       return -EINVAL;
-    }
-
-    ifindex =3D if_nametoindex(iface);
-  =
  if (ifindex =3D=3D 0)
-    {
-        msg(M_WARN | M_ERRNO, "%s: cannot g=
et ifindex for %s", __func__, iface);
-        return -ENOENT;
-    }
-
-  =
  return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, local, NULL, 0)=
;
+    return sitnl_addr_set(RTM_DELADDR, 0, iface, af_family, local, NULL,=
 0);
 }
 
 static int
-sitnl_route_set(uint16_t cmd, uint16_t flags, int if=
index, sa_family_t af_family, const void *dst,
+sitnl_route_set(uint16_t cm=
d, uint16_t flags, const char *iface, sa_family_t af_family, const void *ds=
t,
                 int prefixlen, const void *gw, enum rt_class_t table, i=
nt metric,
                 enum rt_scope_t scope, unsigned char protocol, =
unsigned char type)
 {
     struct sitnl_route_req req;
-    int ret =3D -1=
, size;
+    int ret =3D -1;
+    size_t size;
+    uint32_t ifindex =3D 0;=

 
     CLEAR(req);
 
+    if (iface)
+    {
+        const int ret =3D get=
_ifindex(__func__, iface, &ifindex);
+        if (ret < 0)
+        {
+    =
        return ret;
+        }
+    }
+
     switch (af_family)
     {
    =
     case AF_INET:
@@ -982,64 +960,14 @@
 static int
 sitnl_addr_add(sa_fam=
ily_t af_family, const char *iface, const inet_address_t *addr, int prefixl=
en)
 {
-    int ifindex;
-
-    switch (af_family)
-    {
-        case AF_=
INET:
-        case AF_INET6:
-            break;
-
-        default:
-    =
        return -EINVAL;
-    }
-
-    if (!iface)
-    {
-        msg(M_WAR=
N, "%s: passed NULL interface", __func__);
-        return -EINVAL;
-    }
=
-
-    ifindex =3D if_nametoindex(iface);
-    if (ifindex =3D=3D 0)
-    {=

-        msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __fu=
nc__, iface);
-        return -ENOENT;
-    }
-
-    return sitnl_addr_set(=
RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, addr, NULL,
=
+    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, iface=
, af_family, addr, NULL,
                           prefixlen);
 }
 
 stati=
c int
 sitnl_addr_del(sa_family_t af_family, const char *iface, const inet_=
address_t *addr, int prefixlen)
 {
-    int ifindex;
-
-    switch (af_fami=
ly)
-    {
-        case AF_INET:
-        case AF_INET6:
-            brea=
k;
-
-        default:
-            return -EINVAL;
-    }
-
-    if (!ifac=
e)
-    {
-        msg(M_WARN, "%s: passed NULL interface", __func__);
-   =
     return -EINVAL;
-    }
-
-    ifindex =3D if_nametoindex(iface);
-    =
if (ifindex =3D=3D 0)
-    {
-        msg(M_WARN | M_ERRNO, "%s: rtnl: cann=
ot get ifindex for %s", __func__, iface);
-        return -ENOENT;
-    }
-=

-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family, addr, NULL,=
 prefixlen);
+    return sitnl_addr_set(RTM_DELADDR, 0, iface, af_family, a=
ddr, NULL, prefixlen);
 }
 
 int
@@ -1174,17 +1102,6 @@
                 co=
nst void *gw, uint32_t table, int metric)
 {
     enum rt_scope_t scope =3D=
 RT_SCOPE_UNIVERSE;
-    int ifindex =3D 0;
-
-    if (iface)
-    {
-     =
   ifindex =3D if_nametoindex(iface);
-        if (ifindex =3D=3D 0)
-     =
   {
-            msg(M_WARN | M_ERRNO, "%s: rtnl: can't get ifindex for %s=
", __func__, iface);
-            return -ENOENT;
-        }
-    }
 
     =
if (table =3D=3D 0)
     {
@@ -1196,7 +1113,7 @@
         scope =3D RT_SCOP=
E_LINK;
     }
 
-    return sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, if=
index, af_family, dst, prefixlen, gw,
+    return sitnl_route_set(RTM_NEWRO=
UTE, NLM_F_CREATE, iface, af_family, dst, prefixlen, gw,
                  =
          table, metric, scope, RTPROT_BOOT, RTN_UNICAST);
 }
 
@@ -1258,24=
 +1175,12 @@
 sitnl_route_del(const char *iface, sa_family_t af_family, con=
st inet_address_t *dst, int prefixlen,
                 const inet_address_=
t *gw, uint32_t table, int metric)
 {
-    int ifindex =3D 0;
-
-    if (if=
ace)
-    {
-        ifindex =3D if_nametoindex(iface);
-        if (ifinde=
x =3D=3D 0)
-        {
-            msg(M_WARN | M_ERRNO, "%s: rtnl: can't =
get ifindex for %s", __func__, iface);
-            return -ENOENT;
-      =
  }
-    }
-
     if (table =3D=3D 0)
     {
         table =3D RT_TABLE_MA=
IN;
     }
 
-    return sitnl_route_set(RTM_DELROUTE, 0, ifindex, af_famil=
y, dst, prefixlen, gw, table, metric,
+    return sitnl_route_set(RTM_DELRO=
UTE, 0, iface, af_family, dst, prefixlen, gw, table, metric,
              =
              RT_SCOPE_NOWHERE, 0, 0);
 }
 
@@ -1439,7 +1344,7 @@
 net_ifac=
e_type(const openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYP=
E_LEN_MAX])
 {
     struct sitnl_link_req req =3D {};
-    int ifindex =3D =
if_nametoindex(iface);
+    int ifindex =3D (int)if_nametoindex(iface);
 
 =
    if (!ifindex)
     {
@@ -1471,7 +1376,7 @@
 net_iface_del(const openvpn=
_net_ctx_t *ctx, const char *iface)
 {
     struct sitnl_link_req req =3D {=
};
-    int ifindex =3D if_nametoindex(iface);
+    int ifindex =3D (int)if=
_nametoindex(iface);
 
     if (!ifindex)
     {

-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118=

Gerrit-Change-Number: 2177
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>

--coj5PQClU3Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #2</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/217=
7?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">net=
working_sitnl: Reduce boilerplate code for parameter checks<br><br>Also rem=
oves some inconsistencies and some<br>sign conversion warnings=2E<br><br>Ch=
ange-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/network=
ing_sitnl=2Ec<br>1 file changed, 74 insertions(+), 169 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/77/2177/2</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/networking_sitnl=2Ec b=
/src/openvpn/networking_sitnl=2Ec</span><br><span>index 501c635=2E=2Eee6229=
b 100644</span><br><span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><=
span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><span>@@ -673,25 +673=
,37 @@</span><br><span> </span><br><span> #ifdef ENABLE_SITNL</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+get_ifindex(const char *=
func, const char *iface, uint32_t *ifindex)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!iface)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_WARN, &quot;%s: passed NULL interface&quot;, func);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return -EINVAL;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    *ifindex =3D if_nametoindex(iface);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (*ifindex =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot ge=
t ifindex for %s&quot;, func, iface);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        return -ENOENT;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><sp=
an> net_iface_up(const openvpn_net_ctx_t *ctx, const char *iface, bool up)<=
/span><br><span> {</span><br><span>     struct sitnl_link_req req;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    uint32_t ifindex;</span><br><=
span> </span><br><span>     CLEAR(req);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (!iface)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const int ret =3D get_ifindex(__func_=
_, iface, &amp;ifindex);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (ret &lt; 0)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: passed NULL interfa=
ce&quot;, __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       return -EINVAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ifindex =3D=
=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: r=
tnl: cannot get ifindex for %s: %s&quot;, __func__, iface, strerror(errno))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return -ENOE=
NT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return r=
et;</span><br><span>     }</span><br><span> </span><br><span>     req=2En=
=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br><span>@@ -699,7 +=
711,7 @@</span><br><span>     req=2En=2Enlmsg_type =3D RTM_SETLINK;</span><=
br><span> </span><br><span>     req=2Ei=2Eifi_family =3D AF_PACKET;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    req=2Ei=2Eifi_index =3D i=
findex;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2Ei=
=2Eifi_index =3D (int)ifindex;</span><br><span>     req=2Ei=2Eifi_change |=
=3D IFF_UP;</span><br><span>     if (up)</span><br><span>     {</span><br><=
span>@@ -707,7 +719,7 @@</span><br><span>     }</span><br><span>     else</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        req=2Ei=2Eifi_flags &amp;=3D ~IFF_UP;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        req=2Ei=2Eifi_flags &amp;=3D ~(unsigned i=
nt)IFF_UP;</span><br><span>     }</span><br><span> </span><br><span>     ms=
g(M_INFO, &quot;%s: set %s %s&quot;, __func__, iface, up ? &quot;up&quot; :=
 &quot;down&quot;);</span><br><span>@@ -719,14 +731,13 @@</span><br><span> =
net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const char *iface, uint32_t=
 mtu)</span><br><span> {</span><br><span>     struct sitnl_link_req req;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex, ret =3D=
 -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D=
 -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t if=
index;</span><br><span> </span><br><span>     CLEAR(req);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_na=
metoindex(iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (get_ifindex(__func__, iface, &amp;ifindex) &lt; 0)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M=
_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&quot;, __func__,=
 iface);</span><br><span>         return -1;</span><br><span>     }</span><=
br><span> </span><br><span>@@ -735,7 +746,7 @@</span><br><span>     req=2En=
=2Enlmsg_type =3D RTM_SETLINK;</span><br><span> </span><br><span>     req=
=2Ei=2Eifi_family =3D AF_PACKET;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    req=2Ei=2Eifi_index =3D ifindex;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    req=2Ei=2Eifi_index =3D (int)ifindex;</span=
><br><span> </span><br><span>     SITNL_ADDATTR(&amp;req=2En, sizeof(req), =
IFLA_MTU, &amp;mtu, 4);</span><br><span> </span><br><span>@@ -750,14 +761,1=
3 @@</span><br><span> net_addr_ll_set(const openvpn_net_ctx_t *ctx, const o=
penvpn_net_iface_t *iface, uint8_t *addr)</span><br><span> {</span><br><spa=
n>     struct sitnl_link_req req;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    int ifindex, ret =3D -1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int ret =3D -1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint32_t ifindex;</span><br><span> </span><br><spa=
n>     CLEAR(req);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    ifindex =3D if_nametoindex(iface);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (ifindex =3D=3D 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (get_ifindex(__func__, iface, =
&amp;ifindex) &lt; 0)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot=
 get ifindex for %s&quot;, __func__, iface);</span><br><span>         retur=
n -1;</span><br><span>     }</span><br><span> </span><br><span>@@ -766,7 +7=
76,7 @@</span><br><span>     req=2En=2Enlmsg_type =3D RTM_SETLINK;</span><b=
r><span> </span><br><span>     req=2Ei=2Eifi_family =3D AF_PACKET;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    req=2Ei=2Eifi_index =3D if=
index;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2Ei=
=2Eifi_index =3D (int)ifindex;</span><br><span> </span><br><span>     SITNL=
_ADDATTR(&amp;req=2En, sizeof(req), IFLA_ADDRESS, addr, OPENVPN_ETH_ALEN);<=
/span><br><span> </span><br><span>@@ -778,22 +788,19 @@</span><br><span> }<=
/span><br><span> </span><br><span> static int</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-sitnl_addr_set(uint16_t cmd, uint16_t flags, int if=
index, sa_family_t af_family,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+sitnl_addr_set(uint16_t cmd, uint16_t flags, const char *iface, s=
a_family_t af_family,</span><br><span>                const inet_address_t =
*local, const inet_address_t *remote, int prefixlen)</span><br><span> {</sp=
an><br><span>     struct sitnl_addr_req req;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    uint32_t size;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int ret =3D -EINVAL;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    size_t size;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    uint32_t ifindex;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(req);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    req=2En=2Enlmsg_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    req=2En=2Enlmsg_type =
=3D cmd;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    req=2En=
=2Enlmsg_flags =3D NLM_F_REQUEST | flags;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   req=2Ei=2Eifa_index =3D ifindex;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ASSERT(af_family &lt;=3D UINT8_MAX);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    req=2Ei=2Eifa_family =3D (uint8_t)af_f=
amily;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =
=3D get_ifindex(__func__, iface, &amp;ifindex);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return ret;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ret =3D -EINVAL; /* for SITNL_ADDATTR */</span><br><span> </span><br><s=
pan>     switch (af_family)</span><br><span>     {</span><br><span>@@ -810,=
10 +817,20 @@</span><br><span>             return -EINVAL;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    CLEAR(req);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlms=
g_len =3D NLMSG_LENGTH(sizeof(req=2Ei));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    req=2En=2Enlmsg_type =3D cmd;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    req=2En=2Enlmsg_flags =3D NLM_F_REQU=
EST | flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    req=2Ei=2Eifa_index =
=3D ifindex;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASS=
ERT(af_family &lt;=3D UINT8_MAX);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    req=2Ei=2Eifa_family =3D (uint8_t)af_family;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* if no p=
refixlen has been specified, assume host address */</span><br><span>     if=
 (prefixlen =3D=3D 0)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        prefixlen =3D size * 8;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        prefixlen =3D (int)size * 8;</sp=
an><br><span>     }</span><br><span>     ASSERT(prefixlen &lt;=3D UINT8_MAX=
);</span><br><span>     req=2Ei=2Eifa_prefixlen =3D (uint8_t)prefixlen;</sp=
an><br><span>@@ -848,76 +865,37 @@</span><br><span> sitnl_addr_ptp_add(sa_f=
amily_t af_family, const char *iface, const inet_address_t *local,</span><b=
r><span>                    const inet_address_t *remote)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    switch (af_family)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case AF_INET:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case AF_INET6:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
return -EINVAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!iface)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        msg(M_WARN, &quot;%s: passed NULL interface&quot;, __func=
__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return -E=
INVAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex(iface);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (ifindex =3D=3D 0)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: cannot get ifinde=
x for %s: %s&quot;, __func__, np(iface), strerror(errno));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return -ENOENT;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifin=
dex, af_family, local,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return sitnl_addr_set(RTM_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, ifa=
ce, af_family, local,</span><br><span>                           remote, 0)=
;</span><br><span> }</span><br><span> </span><br><span> static int</span><b=
r><span> sitnl_addr_ptp_del(sa_family_t af_family, const char *iface, const=
 inet_address_t *local)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int ifindex;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
witch (af_family)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET=
:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET=
6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        default:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            return -EINVAL;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (!iface)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;=
%s: passed NULL interface&quot;, __func__);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        return -EINVAL;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =
=3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 msg(M_WARN | M_ERRNO, &quot;%s: cannot get ifindex for %s&quot;, __func__,=
 iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retur=
n -ENOENT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return sitnl_addr_set(RTM_DELADDR, 0, ifinde=
x, af_family, local, NULL, 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return sitnl_addr_set(RTM_DELADDR, 0, iface, af_family, loca=
l, NULL, 0);</span><br><span> }</span><br><span> </span><br><span> static i=
nt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_route_set(uin=
t16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family, const void *=
dst,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_route_set=
(uint16_t cmd, uint16_t flags, const char *iface, sa_family_t af_family, co=
nst void *dst,</span><br><span>                 int prefixlen, const void *=
gw, enum rt_class_t table, int metric,</span><br><span>                 enu=
m rt_scope_t scope, unsigned char protocol, unsigned char type)</span><br><=
span> {</span><br><span>     struct sitnl_route_req req;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int ret =3D -1, size;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    size_t size;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    uint32_t ifindex =3D 0;</span><br=
><span> </span><br><span>     CLEAR(req);</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (iface)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        const int ret =3D get_ifindex(__func__, iface,=
 &amp;ifindex);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     switch (=
af_family)</span><br><span>     {</span><br><span>         case AF_INET:</s=
pan><br><span>@@ -982,64 +960,14 @@</span><br><span> static int</span><br><=
span> sitnl_addr_add(sa_family_t af_family, const char *iface, const inet_a=
ddress_t *addr, int prefixlen)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    int ifindex;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    switch (af_family)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case =
AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case =
AF_INET6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        default:</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            return -EINVAL;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (!iface)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN,=
 &quot;%s: passed NULL interface&quot;, __func__);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        return -EINVAL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
findex =3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: cannot get ifindex for %s&quo=
t;, __func__, iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        return -ENOENT;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_addr_set(RTM_NEWAD=
DR, NLM_F_CREATE | NLM_F_REPLACE, ifindex, af_family, addr, NULL,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_addr_set(RTM=
_NEWADDR, NLM_F_CREATE | NLM_F_REPLACE, iface, af_family, addr, NULL,</span=
><br><span>                           prefixlen);</span><br><span> }</span>=
<br><span> </span><br><span> static int</span><br><span> sitnl_addr_del(sa_=
family_t af_family, const char *iface, const inet_address_t *addr, int pref=
ixlen)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int ifindex;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (af_family)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        case AF_INET6:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        default:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            return -EINVAL;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!iface)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: passed NULL i=
nterface&quot;, __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return -EINVAL;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    ifindex =3D if_nametoindex=
(iface);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ifind=
ex =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN | M_ER=
RNO, &quot;%s: rtnl: cannot get ifindex for %s&quot;, __func__, iface);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        return -ENOENT;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return sitnl_addr_set(RTM_DELADDR, 0, ifindex, af_family=
, addr, NULL, prefixlen);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return sitnl_addr_set(RTM_DELADDR, 0, iface, af_family, addr, NUL=
L, prefixlen);</span><br><span> }</span><br><span> </span><br><span> int</s=
pan><br><span>@@ -1174,17 +1102,6 @@</span><br><span>                 const=
 void *gw, uint32_t table, int metric)</span><br><span> {</span><br><span> =
    enum rt_scope_t scope =3D RT_SCOPE_UNIVERSE;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int ifindex =3D 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (iface)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ifindex =
=3D if_nametoindex(iface);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (ifindex =3D=3D 0)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            msg(M_WARN | M_ERRNO, &quot;%s: rtnl: can&#39;t get ifindex fo=
r %s&quot;, __func__, iface);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            return -ENOENT;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span> </span><br><span>     if (table =3D=3D 0)</span><b=
r><span>     {</span><br><span>@@ -1196,7 +1113,7 @@</span><br><span>      =
   scope =3D RT_SCOPE_LINK;</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_route_set(R=
TM_NEWROUTE, NLM_F_CREATE, ifindex, af_family, dst, prefixlen, gw,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_route_set(R=
TM_NEWROUTE, NLM_F_CREATE, iface, af_family, dst, prefixlen, gw,</span><br>=
<span>                            table, metric, scope, RTPROT_BOOT, RTN_UN=
ICAST);</span><br><span> }</span><br><span> </span><br><span>@@ -1258,24 +1=
175,12 @@</span><br><span> sitnl_route_del(const char *iface, sa_family_t a=
f_family, const inet_address_t *dst, int prefixlen,</span><br><span>       =
          const inet_address_t *gw, uint32_t table, int metric)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifinde=
x =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (iface)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        ifindex =3D if_nametoindex(iface);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (ifindex =3D=3D 0)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN | M_ERRNO, &quot;=
%s: rtnl: can&#39;t get ifindex for %s&quot;, __func__, iface);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            return -ENOENT;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span>     if (table =3D=3D 0)</span><br><sp=
an>     {</span><br><span>         table =3D RT_TABLE_MAIN;</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return sitnl_route_set(RTM_DELROUTE, 0, ifindex, af_family, dst, pr=
efixlen, gw, table, metric,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return sitnl_route_set(RTM_DELROUTE, 0, iface, af_family, dst, =
prefixlen, gw, table, metric,</span><br><span>                            R=
T_SCOPE_NOWHERE, 0, 0);</span><br><span> }</span><br><span> </span><br><spa=
n>@@ -1439,7 +1344,7 @@</span><br><span> net_iface_type(const openvpn_net_c=
tx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])</span><br><spa=
n> {</span><br><span>     struct sitnl_link_req req =3D {};</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int ifindex =3D if_nametoindex(if=
ace);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ifinde=
x =3D (int)if_nametoindex(iface);</span><br><span> </span><br><span>     if=
 (!ifindex)</span><br><span>     {</span><br><span>@@ -1471,7 +1376,7 @@</s=
pan><br><span> net_iface_del(const openvpn_net_ctx_t *ctx, const char *ifac=
e)</span><br><span> {</span><br><span>     struct sitnl_link_req req =3D {}=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ifindex =3D =
if_nametoindex(iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int ifindex =3D (int)if_nametoindex(iface);</span><br><span> </span>=
<br><span>     if (!ifindex)</span><br><span>     {</span><br></pre><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=
=3Demail">change 2177</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2177?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2177 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>

</body></html>
--coj5PQClU3Y=--


--===============3160779006563511525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3160779006563511525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3160779006563511525==--

