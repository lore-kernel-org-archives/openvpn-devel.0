Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262DF606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=B00vLIAx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kEp/noew;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=i1nIE/ZI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CBUTgvnZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rV1kjPHpRlF5IQQ2qcWi1AlTOug6fGSgV0R193bT+ow=; b=B00vLIAx5mFVn7LUlnmFlo8gfm
	MQut/ZSDl+mfsZ8F/FpOIacmjRBhYEMnw9t/2eB7y2ToetgEt52j8/xhg5r5rhY5q2cOjs+IpFVrC
	ckx/igyjLRg9AsmjfupHCHMxX+DdMpt/g9C6mP1HEzTiuQtNVQ43SrUuPej4pGZZvpFo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX2jO-000000002VO-3Z6Z;
	Fri, 27 Nov 2026 20:39:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX2jN-000000002VH-0kRl
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 20:39:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WBrPLEOAXkz5mFTh2tnGaSxwjpn3PpH9OPB0HNkKQSY=; b=kEp/noewckn7FDAGi823zC06dO
 dPwFpUm/eVPYeLqQYjkLZ+nXwGbkyQCrlx0hqc8tEI/RTAOUhnstOUizWF7RBvi/1H+3k7YCc4ocB
 2HreMB1AOL5CYitBYzLXFZtEJKXdSIOSCaxevSrUDWqpU8tYPTvFwaB0qSQroDxbsryY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WBrPLEOAXkz5mFTh2tnGaSxwjpn3PpH9OPB0HNkKQSY=; b=i1nIE/ZINHl65oiJDTO0+xvQTT
 52aCJE8aCBGUg0EA8Pq86VkZi3JGYktNd2dv4zyzkmjr7Kz00o8H5WhCHu+8miWKRX8Bwy6sqERlp
 s9gCAQgT3Sl2dkL8VKPV/TAyhDS1+tvgWZ5s2bZsmPo8JnvrKHvZoIYh2UZ6jdkViXH8=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX2jL-000000002W0-1eSk for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 20:39:41 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so5316171f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 12:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795811973; x=1796416773; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WBrPLEOAXkz5mFTh2tnGaSxwjpn3PpH9OPB0HNkKQSY=;
 b=CBUTgvnZDiNDeIcWVW+apsnA5ePX9ovRxHma9gFlKDhAoEgABEmC+Z53X7foDqW+BL
 jdlOQy2c7U1AUTSHGSWbzBcSsnORgZxjPN90MljUSLTsHWBGPwFDvcC2EXx8deF0S/Bh
 BBaYExoKR3cQincQ3Yi0zehiuJqeitsfTbzVxUWceeAhbvL8lVZvEZ/sK/Cii/zSPkIZ
 lfCZzWIESwobcxK6CtZXt0TxGl+GK9aVvxFIKhbnSow9uvg4HUOKhFzNOL+lFq7ysRgX
 33XfP9YPQ1W7aYxsxNp4Xvros/01MFwlV3oHt1Mzcnh0EE3AT9CAvHg7eNiEEnR6NLDb
 byEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795811973; x=1796416773;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WBrPLEOAXkz5mFTh2tnGaSxwjpn3PpH9OPB0HNkKQSY=;
 b=akftsgxSRlZ4m63W/TlGTt/lbh0gCsEgSpFm9BTin1Mg3iMWIhXwJPLY7UXpwIoXBJ
 0uBOcq5HUKiX8dzbOmNy7ZVOFY92m3madTagngpEwa5RSpmcWzlNQL/eX7Nzxr3CG0AL
 kSCh1odAc75NB4DfR2MXhWVjfZTbA3BEbG9kCuMiu6PzK80+PyCWN6ixZHC5bSkMhxJv
 eWtzs7sbpDCwBy1oEfTFB5u/BHJqJpLMgvvUc92Uv0Vk7F6kKzeJcOpW0FbFs/6PJGLo
 uF2FrIH2yucxboKGCVwVoxvS8wMUjtqIvKDKZIKKAU83LxcA165h3pYxYqB8ONQKh/6U
 LSuA==
X-Gm-Message-State: APuU4Z/Qi8FeinTcHl0sN2Y6AH+eT2NvlcUqTxWReLHiHgVLj+3r5zzV
 sRmZNoaq1rAzTz1ktuOWSWBYyn/VOc1IUUfHHPxIVWcel9cwS009ozMAhFRo58+QKMkWQWMog12
 6uyCeSCpDbNOfYJ6tMDVcz69XeJRjj4yBm+W90Kr7Ganwa4k1WVF2x2J4aYh9d3/0HyLG
X-Gm-Gg: AZFdTZe1zubGwdRxnQgPWLoyntxTVSs9leYUuyxGM3V+NQOHNsL0o4b7xFhB3wPU5yV
 bfF/cVT3IG9GmcnxiHZ5mllGvrXZXmI1wFZj72i/N2HFntaytIteV8e+hPuxXqrHbpK3BX52fgG
 ziarhCpX2RXJuQu/VYMi3ya5RJqYaAKZBUVnXkZOJmaVoWjCQs7nAGpCrIJD4NIVP8fb5BsadsA
 rQ/EqqOpGYdcs3wz5Ef4CeESQbmH7UlJvfowaoPvJz0RfcRJ8F78FviGoIz9zAssktUvIzw1mRd
 Y394ckupEyw6g2rUvlNlYZUZTo7bwq0DRab0HJMTJOBQeb/zf6glVpS4bTENHCh4hoCTZiwVbZK
 yvzzc45g2Fxct6hu5Ggod2AH/Fnr5UCdIdKtWK9+HEb0zGLc8Qptue4JSWhicsmtbvZqiAVuSG6
 cm77A3qJ++D8DSn/U7SpA1uCLy5K80WLcEik2mXtFEj6axN39AlIZHxiC4txCSF8RMu0enhBDCC
 2U1vT2WLy0wk9aPv/YU92pSkWTzocEH1wFciZ9S2ZgAE4sJSHa/6yInjjIDctDM8waZ6fsP3WFh
 BICDesnIa2VrTNoqtzFRBH9QFXKrvFYP06gZzI2ndmGqUFOnKS617T83lFRtSGUvrVScHK/VTlK
 eDO7ChYQKi3qkZP92kL2Qw+4Abfs/bjkcUCJ2im5XgfaDzjS+pqGwNc7jt7T2w1YSS8hV8uSKla
 JG9b3hvb7fJbWhDYAt
X-Received: by 2002:a05:600c:5303:b0:4ba:495c:2f5d with SMTP id
 5b1f17b1804b1-4bb8880767amr476473825e9.9.1795811972634; 
 Fri, 27 Nov 2026 12:39:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906e4ce6sm447946425e9.4.2026.11.27.12.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:39:32 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 20:39:30 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Lev Stipakov <lstipakov@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
X-Gerrit-Change-Number: 2209
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2209?usp=email>
X-Gerrit-Commit: a8d0aafa8d0d9feeae516f87a37a5fafd3e636c4
In-Reply-To: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
References: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTE2NTQ0MDAwLkkzNjMwYWMzZGVmYmI2NGUyNTJhYzMwMDlmZGQ3ODQxNTMzNjdlNGZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8b1d72e140445196b106c99129168c3725d421fa-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xX2jL-000000002W0-1eSk
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dhcp: locate the UDP
 header via the IP header length
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0990210039218879418=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0990210039218879418==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4D8Ks3B5vAY="; charset=UTF-8

--4D8Ks3B5vAY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2209?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Lev Stipakov


Change subject: dhcp: locate the UDP head=
er via the IP header length
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

dhcp: locate the UDP header via the IP header length

dhcp=
_extract_router_msg() assumed a 20-byte IP header, so DHCP replies
carrying=
 IP options were not recognised=2E Use the IHL to find the UDP
header and s=
kip fragments, whose UDP checksum covers data we don't
have=2E Drop struct =
dhcp_full, no longer used=2E

Change-Id: I3630ac3defbb64e252ac3009fdd784153=
367e4fd
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Le=
v Stipakov <lstipakov@gmail=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2209
Message-Id: <20261126115848=2E7329-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg42018=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/dhcp=2Ec
M src/openvpn/dhcp=2Eh
M src/openvpn/prot=
o=2Eh
3 files changed, 37 insertions(+), 23 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/09/2209/3

diff --git a/=
src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec
index 525d567=2E=2E8c9e520 1006=
44
--- a/src/openvpn/dhcp=2Ec
+++ b/src/openvpn/dhcp=2Ec
@@ -152,27 +152,49=
 @@
 in_addr_t
 dhcp_extract_router_msg(struct buffer *ipbuf)
 {
-    struc=
t dhcp_full *df =3D (struct dhcp_full *)BPTR(ipbuf);
-    const int optlen =
=3D
-        BLEN(ipbuf)
-        - (int)(sizeof(struct openvpn_iphdr) + si=
zeof(struct openvpn_udphdr) + sizeof(struct dhcp));
-
-    if (optlen >=3D =
0 && df->ip=2Eprotocol =3D=3D OPENVPN_IPPROTO_UDP
-        && df->udp=2Esou=
rce =3D=3D htons(BOOTPS_PORT) && df->udp=2Edest =3D=3D htons(BOOTPC_PORT)
-=
        && df->dhcp=2Eop =3D=3D BOOTREPLY)
+    if (BLENZ(ipbuf) < sizeof(s=
truct openvpn_iphdr))
     {
-        const int message_type =3D get_dhcp_m=
essage_type(&df->dhcp, optlen);
+        return 0;
+    }
+
+    const stru=
ct openvpn_iphdr *ip =3D (const struct openvpn_iphdr *)BPTR(ipbuf);
+    co=
nst int hlen =3D OPENVPN_IPH_GET_LEN(ip->version_len);
+
+    /* Skip fragm=
ents: later ones carry no UDP header, and the checksum
+     * covers the w=
hole datagram=2E */
+    if (ntohs(ip->frag_off) & (OPENVPN_IP_MF | OPENVPN=
_IP_OFFMASK))
+    {
+        return 0;
+    }
+
+    /* The UDP header fol=
lows any IP options=2E */
+    struct buffer udpbuf =3D *ipbuf;
+    if (hl=
en < (int)sizeof(struct openvpn_iphdr) || !buf_advance(&udpbuf, hlen))
+   =
 {
+        return 0;
+    }
+
+    struct openvpn_udphdr *udp =3D (struct =
openvpn_udphdr *)BPTR(&udpbuf);
+    struct dhcp *dhcp =3D (struct dhcp *)(=
udp + 1);
+    const int optlen =3D
+        BLEN(&udpbuf) - (int)(sizeof(s=
truct openvpn_udphdr) + sizeof(struct dhcp));
+
+    if (optlen >=3D 0 && i=
p->protocol =3D=3D OPENVPN_IPPROTO_UDP
+        && udp->source =3D=3D htons=
(BOOTPS_PORT) && udp->dest =3D=3D htons(BOOTPC_PORT)
+        && dhcp->op =
=3D=3D BOOTREPLY)
+    {
+        const int message_type =3D get_dhcp_messa=
ge_type(dhcp, optlen);
         if (message_type =3D=3D DHCPACK || message_=
type =3D=3D DHCPOFFER)
         {
             /* get the router IP address=
 while padding out all DHCP router options */
-            const in_addr_t =
ret =3D do_extract(&df->dhcp, optlen);
+            const in_addr_t ret =3D=
 do_extract(dhcp, optlen);
 
             /* recompute the UDP checksum */
=
-            df->udp=2Echeck =3D 0;
-            df->udp=2Echeck =3D htons(=
ip_checksum(
-                AF_INET, (uint8_t *)&df->udp,
+            ud=
p->check =3D 0;
+            udp->check =3D htons(ip_checksum(
+           =
     AF_INET, (uint8_t *)udp,
                 sizeof(struct openvpn_udphdr=
) + sizeof(struct dhcp) + optlen,
-                (uint8_t *)&df->ip=2Esad=
dr, (uint8_t *)&df->ip=2Edaddr, OPENVPN_IPPROTO_UDP));
+                (co=
nst uint8_t *)&ip->saddr, (const uint8_t *)&ip->daddr, OPENVPN_IPPROTO_UDP)=
);
 
             /* only return the extracted Router address if DHCPACK */=

             if (message_type =3D=3D DHCPACK)
diff --git a/src/openvpn/dhc=
p=2Eh b/src/openvpn/dhcp=2Eh
index 38ebf8d=2E=2E8517b92 100644
--- a/src/op=
envpn/dhcp=2Eh
+++ b/src/openvpn/dhcp=2Eh
@@ -80,15 +80,6 @@
     uint32_t =
magic;     /* must be 0x63825363 (network order) */
 };
 
-struct dhcp_full=

-{
-    struct openvpn_iphdr ip;
-    struct openvpn_udphdr udp;
-    stru=
ct dhcp dhcp;
-#define DHCP_OPTIONS_BUFFER_SIZE 256
-    uint8_t options[DH=
CP_OPTIONS_BUFFER_SIZE];
-};
-
 #pragma pack()
 
 in_addr_t dhcp_extract_ro=
uter_msg(struct buffer *ipbuf);
diff --git a/src/openvpn/proto=2Eh b/src/op=
envpn/proto=2Eh
index 14f9264=2E=2E0841ad5 100644
--- a/src/openvpn/proto=
=2Eh
+++ b/src/openvpn/proto=2Eh
@@ -96,6 +96,7 @@
     uint16_t tot_len;
 =
    uint16_t id;
 
+#define OPENVPN_IP_MF      0x2000
 #define OPENVPN_IP_O=
FFMASK 0x1fff
     uint16_t frag_off;
 

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
Gerrit-=
Change-Number: 2209
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Review=
er: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--4D8Ks3B5vAY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2209?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Lev Stipakov</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">dhc=
p: locate the UDP header via the IP header length<br><br>dhcp_extract_route=
r_msg() assumed a 20-byte IP header, so DHCP replies<br>carrying IP options=
 were not recognised=2E Use the IHL to find the UDP<br>header and skip frag=
ments, whose UDP checksum covers data we don&#39;t<br>have=2E Drop struct d=
hcp_full, no longer used=2E<br><br>Change-Id: I3630ac3defbb64e252ac3009fdd7=
84153367e4fd<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
;<br>Acked-by: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt;<br>Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209<br>Message-Id: &lt;2026112611=
5848=2E7329-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archiv=
e=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg42018=2Ehtml<br>Signed-o=
ff-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn=
/dhcp=2Ec<br>M src/openvpn/dhcp=2Eh<br>M src/openvpn/proto=2Eh<br>3 files c=
hanged, 37 insertions(+), 23 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/09/2209/3</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec</span><br><span>=
index 525d567=2E=2E8c9e520 100644</span><br><span>--- a/src/openvpn/dhcp=2E=
c</span><br><span>+++ b/src/openvpn/dhcp=2Ec</span><br><span>@@ -152,27 +15=
2,49 @@</span><br><span> in_addr_t</span><br><span> dhcp_extract_router_msg=
(struct buffer *ipbuf)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct dhcp_full *df =3D (struct dhcp_full *)BPTR(i=
pbuf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int o=
ptlen =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        BLEN=
(ipbuf)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        - (int=
)(sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr) + sizeof(str=
uct dhcp));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (optlen &gt;=3D 0 &amp;&=
amp; df-&gt;ip=2Eprotocol =3D=3D OPENVPN_IPPROTO_UDP</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; df-&gt;udp=2Esource =3D=
=3D htons(BOOTPS_PORT) &amp;&amp; df-&gt;udp=2Edest =3D=3D htons(BOOTPC_POR=
T)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; =
df-&gt;dhcp=2Eop =3D=3D BOOTREPLY)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (BLENZ(ipbuf) &lt; sizeof(struct openvpn_iphdr))</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     const int message_type =3D get_dhcp_message_type(&amp;df-&gt;dhcp, opt=
len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const struct openvpn_iphdr *ip =3D (const str=
uct openvpn_iphdr *)BPTR(ipbuf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const int hlen =3D OPENVPN_IPH_GET_LEN(ip-&gt;version_len)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Skip fragments: later ones car=
ry no UDP header, and the checksum</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * covers the whole datagram=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (ntohs(ip-&gt;frag_off) &amp; (OPE=
NVPN_IP_MF | OPENVPN_IP_OFFMASK))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* The UDP header follows any I=
P options=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct buffer udpbuf =3D *ipbuf;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (hlen &lt; (int)sizeof(struct openvpn_iphdr) || !buf_ad=
vance(&amp;udpbuf, hlen))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_udphdr *udp =3D (struc=
t openvpn_udphdr *)BPTR(&amp;udpbuf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct dhcp *dhcp =3D (struct dhcp *)(udp + 1);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int optlen =3D<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        BLEN(&amp;ud=
pbuf) - (int)(sizeof(struct openvpn_udphdr) + sizeof(struct dhcp));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (optlen &gt;=3D 0 &amp;&amp; ip-&gt;pro=
tocol =3D=3D OPENVPN_IPPROTO_UDP</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        &amp;&amp; udp-&gt;source =3D=3D htons(BOOTPS_PORT) &a=
mp;&amp; udp-&gt;dest =3D=3D htons(BOOTPC_PORT)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        &amp;&amp; dhcp-&gt;op =3D=3D BOOTREPLY=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        const int message_type =
=3D get_dhcp_message_type(dhcp, optlen);</span><br><span>         if (messa=
ge_type =3D=3D DHCPACK || message_type =3D=3D DHCPOFFER)</span><br><span>  =
       {</span><br><span>             /* get the router IP address while pa=
dding out all DHCP router options */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            const in_addr_t ret =3D do_extract(&amp;df-&gt;d=
hcp, optlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      const in_addr_t ret =3D do_extract(dhcp, optlen);</span><br><span> </=
span><br><span>             /* recompute the UDP checksum */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            df-&gt;udp=2Echeck =3D 0=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            df-&gt;u=
dp=2Echeck =3D htons(ip_checksum(</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                AF_INET, (uint8_t *)&amp;df-&gt;udp,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            udp-&gt;check =3D =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            udp-&=
gt;check =3D htons(ip_checksum(</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                AF_INET, (uint8_t *)udp,</span><br><span>      =
           sizeof(struct openvpn_udphdr) + sizeof(struct dhcp) + optlen,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                (uint8_t=
 *)&amp;df-&gt;ip=2Esaddr, (uint8_t *)&amp;df-&gt;ip=2Edaddr, OPENVPN_IPPRO=
TO_UDP));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      (const uint8_t *)&amp;ip-&gt;saddr, (const uint8_t *)&amp;ip-&gt;dadd=
r, OPENVPN_IPPROTO_UDP));</span><br><span> </span><br><span>             /*=
 only return the extracted Router address if DHCPACK */</span><br><span>   =
          if (message_type =3D=3D DHCPACK)</span><br><span>diff --git a/src=
/openvpn/dhcp=2Eh b/src/openvpn/dhcp=2Eh</span><br><span>index 38ebf8d=2E=
=2E8517b92 100644</span><br><span>--- a/src/openvpn/dhcp=2Eh</span><br><spa=
n>+++ b/src/openvpn/dhcp=2Eh</span><br><span>@@ -80,15 +80,6 @@</span><br><=
span>     uint32_t magic;     /* must be 0x63825363 (network order) */</spa=
n><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-struct dhcp_full</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct op=
envpn_iphdr ip;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct openvpn_udphdr udp;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    struct dhcp dhcp;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define DHCP_OPTIONS_BUFFER_SIZE 256</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    uint8_t options[DHCP_OPTIONS_BUFFER_SIZE];</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> #pragma pack()</span><br><span> <=
/span><br><span> in_addr_t dhcp_extract_router_msg(struct buffer *ipbuf);</=
span><br><span>diff --git a/src/openvpn/proto=2Eh b/src/openvpn/proto=2Eh</=
span><br><span>index 14f9264=2E=2E0841ad5 100644</span><br><span>--- a/src/=
openvpn/proto=2Eh</span><br><span>+++ b/src/openvpn/proto=2Eh</span><br><sp=
an>@@ -96,6 +96,7 @@</span><br><span>     uint16_t tot_len;</span><br><span=
>     uint16_t id;</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define OPENVPN_IP_MF      0x2000</span><br><span> #define=
 OPENVPN_IP_OFFMASK 0x1fff</span><br><span>     uint16_t frag_off;</span><b=
r></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2209?usp=3Demail">change 2209</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2209?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd784153367e=
4fd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2209 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></htm=
l>
--4D8Ks3B5vAY=--


--===============0990210039218879418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0990210039218879418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0990210039218879418==--

