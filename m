Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1118606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aGh+suVd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JvH17d5r;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Vc0/6C8f;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DWrd6CvJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6A5ajCCtgvO9yAuZnKLlKTfzb8jULMysvxwbwl+CyeM=; b=aGh+suVddOCuD+0NICOXVfErsP
	QlYa0gjYDbWPHpMNXKAOO2gOCG3bwYf/gUvib0FrZjt8xw//KC7e9yKjzDZHV+ayiDzMVc7oUBNc1
	g6nntoLE50zvrWJxfxPQ73jc7jcpbVf3ugkNIie2MlMSCddBPlN886kjK6YJdAq+Syg8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX2jP-000000001Co-1y69;
	Fri, 27 Nov 2026 20:39:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX2jN-000000001Cb-3ik7
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 20:39:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pN4kdNMxyKlPoS5vCPiFPrMz+mXdc541+eLlhffMvgg=; b=JvH17d5rIjg+X3psZLkaE/z4wO
 h3P8RrmaTFT+dxCIYqqeLQ+coOou2ZHXu0Lc+u61eUovolqfrAl1rwChy8zmJAXhE2WVAIkkrjQHr
 R+wDHtlurPxb5hDEi8ZN8aeJvH5nF/lcbuYMk0WJkqmJhhIGKqoVadZhMQYPNOCXQw6k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pN4kdNMxyKlPoS5vCPiFPrMz+mXdc541+eLlhffMvgg=; b=Vc0/6C8faD/OFCGnP4SgKfV9zE
 JJSeS+kRjWuQUs1v7hM7XAB+VDF1pIEuMFAUx+Yk10D+s4Xj0AcyGrWBf8/BlSDqypgJ5NqIpL4FS
 x/KwQFs4o4bEIvCwE+kALmhy2zdapm1bxLuQBPruQHRe4T4QDe1nGDPzV87PMJGak2YQ=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX2jM-000000002W1-0Mm3 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 20:39:41 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so6078580f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 12:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795811973; x=1796416773; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pN4kdNMxyKlPoS5vCPiFPrMz+mXdc541+eLlhffMvgg=;
 b=DWrd6CvJHpCMp9T+SbqDkK4kX/J1E6e/xZ+hVXLM/w3EX0ciou9lQy3nXn4Dma9ETg
 ktCRo6xklA7YNkrun1JPizwJUk+NhvOQtbgntZ8vymgzCJIoEnfQzoLJkBXDsFopoZY4
 6p21C4jEdfFPJrZJVY4yP/v5ReERqu5Xlj0nwAnHCNeS9ChWZoC3TjANF1PSIymdA67Y
 lAxArU61TAe53kafA00eQlollnG2QDZji0Q3XAXJnwm0EpPgg0+rjKrl5m0K8OIphoQj
 0L1aiEhklAXxC71rFi7xCrbXpUj+T2Bt4NReM5/Vuguok7lRgGeS1s66Q0vQ0T6A/M+w
 v68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795811973; x=1796416773;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pN4kdNMxyKlPoS5vCPiFPrMz+mXdc541+eLlhffMvgg=;
 b=OkuNF1/+xUxAjWrkv5LkXkhothgsnv8bldvAuSvui8pNy77ODLphPxrVVmOPJToMTN
 wT7PBoloiudvmOtlhvkxdxcSU7fG5z5fP2igL7vMkxI5jtr/0QiV2EDi15tDHXwAjAjs
 sn2uBw4V2vzWyMa84w/cbbqcNLVkkkpX/CyHmRBbEP99s+MR3yTON+HDRuRWaejk1Dwu
 wopRNv4WrzDrTnXRwheoYL3ugvaYVGRO7rNBSdaS90HkuZihrTiY3FuVzNcqy2pd5DJN
 B5gDIJK/QqZEPOelZ+tBF2bEV67cxoLLFlHSz06kp/ZUbqhyCWYOp8ajr6p+N6u6hVUg
 PqdQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHkkDhGckoJoyXQwfy+VmcaunFdjOzGiFXD4ulIT00FK/zcqJDl51P+ugLgLBjtoQZrICdF7M+64fgoByOa@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9xsjPPwz+NiS8JZy1LwCtjzCRgIRrho8WG4hpPdMA5P1gJ/LL9
 FaNl0AvLcEjQc/9yL7jONIbi/dP3uqhf3LdE5TdoYkW5odg10QiZ6xbz89vGNCAZUbRC53v5UYu
 oFPu1DztaTNcfZnuQAEABeDMrJMjbMrSoYP2icNNKRvdoJD8P5R8UvUtPOFQV49xG57dl
X-Gm-Gg: AZFdTZcR+cjH2RSexhBUbLCggCLmgg7fblVi1Q1hWi9sD2TUqR2oCKLmkavFxMc5kO9
 w3+Ofe3icgTEyR6Bu1/iGNC+MiLlkZIYe9jXBF88D6o/q/1XjmdsFkNvh2tHhNUiHAXe35C2bN8
 kim4WjteP8F723H89NrG0Yyokd2JvUp7lV5/wgqNAWPY9faIf8ymjLVOpk6QhzlzARcVa6g8ejo
 Qome1xQu2mQ50Il66XN/G6RN8u55hU8imtUlj+W1SQfy8k/qBhQ9TTGw6UibZBeUkrTuptqDTAj
 B9Aah5PVQgArKoLVslNtzYAOE7t7rVGrEHj+14qaGXA2k52rgw6ZhJF0I0R2Caw/zcPVjsoIwhR
 yXyPkcr2mUt9hmTn5CXqvHtPBe0Yr7xpo5T4aeGRo9K69w8GakQC7ss3Xae//YqsT0rK/4iFW6F
 9yepTOfoOyN4eTrI52D6sFmVspi1Yf1nXZ0DDuiD7TgshgS0PJ9IFpFUDlcxgCEPGH1RKXFRIe+
 p9q1hLeV7UhmkUf2yRD7ZfM4pgST2wwnCciRqjwH7N81NAnwMeXiwGm/dXS1Dlx3PYC/Pq/Bce0
 HmTjHiwAkBrvQNopJX4yLj/kBVj9i6q8FuG6uoSsFkAzeOE9G3eM48lp0O895PWqUV84wBrtx9W
 dPA91aR42pWTQwwOMl23b9op+6FKhpdNxGsomN17f14BYc6uOX5dc4WRlpoE7S8D6/n9nx4t6oa
 BrIJQ3CF1vHvRCY0g=
X-Received: by 2002:a05:6000:2313:b0:490:50c1:f359 with SMTP id
 ffacd0b85a97d-4abb4d70071mr52819553f8f.39.1795811973310; 
 Fri, 27 Nov 2026 12:39:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c340df4sm56235961f8f.55.2026.11.27.12.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:39:33 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 20:39:32 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
X-Gerrit-Change-Number: 2209
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2209?usp=email>
X-Gerrit-Commit: a8d0aafa8d0d9feeae516f87a37a5fafd3e636c4
In-Reply-To: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
References: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTE2NTQ0MDAwLkkzNjMwYWMzZGVmYmI2NGUyNTJhYzMwMDlmZGQ3ODQxNTMzNjdlNGZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8b1d72e140445196b106c99129168c3725d421fa-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xX2jM-000000002W1-0Mm3
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6669026403955926660=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6669026403955926660==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XWiiWJ3FpWg="; charset=UTF-8

--XWiiWJ3FpWg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2209?usp=3Demail )

Change subject: dhcp: locate the UDP header=
 via the IP header length
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

dhcp: locate the UDP header via the IP header length

dhcp_ex=
tract_router_msg() assumed a 20-byte IP header, so DHCP replies
carrying IP=
 options were not recognised=2E Use the IHL to find the UDP
header and skip=
 fragments, whose UDP checksum covers data we don't
have=2E Drop struct dhc=
p_full, no longer used=2E

Change-Id: I3630ac3defbb64e252ac3009fdd784153367=
e4fd
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Lev S=
tipakov <lstipakov@gmail=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2209
Message-Id: <20261126115848=2E7329-1-gert@greenie=2Emuc=2E=
de>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg42018=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/dhcp=2Ec
M src/openvpn/dhcp=2Eh
M src/openvpn/proto=2Eh=

3 files changed, 37 insertions(+), 23 deletions(-)




diff --git a/src/op=
envpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec
index 525d567=2E=2E8c9e520 100644
---=
 a/src/openvpn/dhcp=2Ec
+++ b/src/openvpn/dhcp=2Ec
@@ -152,27 +152,49 @@
 i=
n_addr_t
 dhcp_extract_router_msg(struct buffer *ipbuf)
 {
-    struct dhcp=
_full *df =3D (struct dhcp_full *)BPTR(ipbuf);
-    const int optlen =3D
- =
       BLEN(ipbuf)
-        - (int)(sizeof(struct openvpn_iphdr) + sizeof(s=
truct openvpn_udphdr) + sizeof(struct dhcp));
-
-    if (optlen >=3D 0 && d=
f->ip=2Eprotocol =3D=3D OPENVPN_IPPROTO_UDP
-        && df->udp=2Esource =
=3D=3D htons(BOOTPS_PORT) && df->udp=2Edest =3D=3D htons(BOOTPC_PORT)
-    =
    && df->dhcp=2Eop =3D=3D BOOTREPLY)
+    if (BLENZ(ipbuf) < sizeof(struc=
t openvpn_iphdr))
     {
-        const int message_type =3D get_dhcp_messa=
ge_type(&df->dhcp, optlen);
+        return 0;
+    }
+
+    const struct o=
penvpn_iphdr *ip =3D (const struct openvpn_iphdr *)BPTR(ipbuf);
+    const =
int hlen =3D OPENVPN_IPH_GET_LEN(ip->version_len);
+
+    /* Skip fragments=
: later ones carry no UDP header, and the checksum
+     * covers the whole=
 datagram=2E */
+    if (ntohs(ip->frag_off) & (OPENVPN_IP_MF | OPENVPN_IP_=
OFFMASK))
+    {
+        return 0;
+    }
+
+    /* The UDP header follows=
 any IP options=2E */
+    struct buffer udpbuf =3D *ipbuf;
+    if (hlen <=
 (int)sizeof(struct openvpn_iphdr) || !buf_advance(&udpbuf, hlen))
+    {
+=
        return 0;
+    }
+
+    struct openvpn_udphdr *udp =3D (struct open=
vpn_udphdr *)BPTR(&udpbuf);
+    struct dhcp *dhcp =3D (struct dhcp *)(udp =
+ 1);
+    const int optlen =3D
+        BLEN(&udpbuf) - (int)(sizeof(struc=
t openvpn_udphdr) + sizeof(struct dhcp));
+
+    if (optlen >=3D 0 && ip->p=
rotocol =3D=3D OPENVPN_IPPROTO_UDP
+        && udp->source =3D=3D htons(BOO=
TPS_PORT) && udp->dest =3D=3D htons(BOOTPC_PORT)
+        && dhcp->op =3D=
=3D BOOTREPLY)
+    {
+        const int message_type =3D get_dhcp_message_=
type(dhcp, optlen);
         if (message_type =3D=3D DHCPACK || message_typ=
e =3D=3D DHCPOFFER)
         {
             /* get the router IP address wh=
ile padding out all DHCP router options */
-            const in_addr_t ret=
 =3D do_extract(&df->dhcp, optlen);
+            const in_addr_t ret =3D do=
_extract(dhcp, optlen);
 
             /* recompute the UDP checksum */
-  =
          df->udp=2Echeck =3D 0;
-            df->udp=2Echeck =3D htons(ip_=
checksum(
-                AF_INET, (uint8_t *)&df->udp,
+            udp->=
check =3D 0;
+            udp->check =3D htons(ip_checksum(
+              =
  AF_INET, (uint8_t *)udp,
                 sizeof(struct openvpn_udphdr) +=
 sizeof(struct dhcp) + optlen,
-                (uint8_t *)&df->ip=2Esaddr,=
 (uint8_t *)&df->ip=2Edaddr, OPENVPN_IPPROTO_UDP));
+                (const=
 uint8_t *)&ip->saddr, (const uint8_t *)&ip->daddr, OPENVPN_IPPROTO_UDP));
=
 
             /* only return the extracted Router address if DHCPACK */
  =
           if (message_type =3D=3D DHCPACK)
diff --git a/src/openvpn/dhcp=
=2Eh b/src/openvpn/dhcp=2Eh
index 38ebf8d=2E=2E8517b92 100644
--- a/src/ope=
nvpn/dhcp=2Eh
+++ b/src/openvpn/dhcp=2Eh
@@ -80,15 +80,6 @@
     uint32_t m=
agic;     /* must be 0x63825363 (network order) */
 };
 
-struct dhcp_full
=
-{
-    struct openvpn_iphdr ip;
-    struct openvpn_udphdr udp;
-    struc=
t dhcp dhcp;
-#define DHCP_OPTIONS_BUFFER_SIZE 256
-    uint8_t options[DHC=
P_OPTIONS_BUFFER_SIZE];
-};
-
 #pragma pack()
 
 in_addr_t dhcp_extract_rou=
ter_msg(struct buffer *ipbuf);
diff --git a/src/openvpn/proto=2Eh b/src/ope=
nvpn/proto=2Eh
index 14f9264=2E=2E0841ad5 100644
--- a/src/openvpn/proto=2E=
h
+++ b/src/openvpn/proto=2Eh
@@ -96,6 +96,7 @@
     uint16_t tot_len;
    =
 uint16_t id;
 
+#define OPENVPN_IP_MF      0x2000
 #define OPENVPN_IP_OFFM=
ASK 0x1fff
     uint16_t frag_off;
 

-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2209?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
Gerrit-Change-Nu=
mber: 2209
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>

--XWiiWJ3FpWg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2209?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">dhcp: locate the UDP header via th=
e IP header length<br><br>dhcp_extract_router_msg() assumed a 20-byte IP he=
ader, so DHCP replies<br>carrying IP options were not recognised=2E Use the=
 IHL to find the UDP<br>header and skip fragments, whose UDP checksum cover=
s data we don&#39;t<br>have=2E Drop struct dhcp_full, no longer used=2E<br>=
<br>Change-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd<br>Signed-off-by: =
Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Lev Stipakov &lt=
;lstipakov@gmail=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2209<br>Message-Id: &lt;20261126115848=2E7329-1-gert@greenie=2Emu=
c=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg42018=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dhcp=2Ec<br>M src/openvpn/dhcp=
=2Eh<br>M src/openvpn/proto=2Eh<br>3 files changed, 37 insertions(+), 23 de=
letions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/dhcp=2Ec b/src/openvpn=
/dhcp=2Ec</span><br><span>index 525d567=2E=2E8c9e520 100644</span><br><span=
>--- a/src/openvpn/dhcp=2Ec</span><br><span>+++ b/src/openvpn/dhcp=2Ec</spa=
n><br><span>@@ -152,27 +152,49 @@</span><br><span> in_addr_t</span><br><spa=
n> dhcp_extract_router_msg(struct buffer *ipbuf)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct dhcp_full *df =3D =
(struct dhcp_full *)BPTR(ipbuf);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    const int optlen =3D</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        BLEN(ipbuf)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        - (int)(sizeof(struct openvpn_iphdr) + sizeof(struct op=
envpn_udphdr) + sizeof(struct dhcp));</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (optlen &gt;=3D 0 &amp;&amp; df-&gt;ip=2Eprotocol =3D=3D OPENVPN_IPPROTO_=
UDP</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp;=
 df-&gt;udp=2Esource =3D=3D htons(BOOTPS_PORT) &amp;&amp; df-&gt;udp=2Edest=
 =3D=3D htons(BOOTPC_PORT)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        &amp;&amp; df-&gt;dhcp=2Eop =3D=3D BOOTREPLY)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(ipbuf) &lt; sizeof(str=
uct openvpn_iphdr))</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        const int message_type =3D get_dhcp_message_ty=
pe(&amp;df-&gt;dhcp, optlen);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct openvpn_=
iphdr *ip =3D (const struct openvpn_iphdr *)BPTR(ipbuf);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const int hlen =3D OPENVPN_IPH_GET=
_LEN(ip-&gt;version_len);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Skip f=
ragments: later ones carry no UDP header, and the checksum</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * covers the whole datagram=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ntohs(ip-=
&gt;frag_off) &amp; (OPENVPN_IP_MF | OPENVPN_IP_OFFMASK))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The =
UDP header follows any IP options=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer udpbuf =3D *ipbuf;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (hlen &lt; (int)sizeof(struct o=
penvpn_iphdr) || !buf_advance(&amp;udpbuf, hlen))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_=
udphdr *udp =3D (struct openvpn_udphdr *)BPTR(&amp;udpbuf);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct dhcp *dhcp =3D (struct d=
hcp *)(udp + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const int optlen =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        BLEN(&amp;udpbuf) - (int)(sizeof(struct openvpn_udphdr) + sizeof(=
struct dhcp));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (optlen &gt;=3D 0=
 &amp;&amp; ip-&gt;protocol =3D=3D OPENVPN_IPPROTO_UDP</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; udp-&gt;source =3D=3D=
 htons(BOOTPS_PORT) &amp;&amp; udp-&gt;dest =3D=3D htons(BOOTPC_PORT)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; dhcp-&=
gt;op =3D=3D BOOTREPLY)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
nst int message_type =3D get_dhcp_message_type(dhcp, optlen);</span><br><sp=
an>         if (message_type =3D=3D DHCPACK || message_type =3D=3D DHCPOFFE=
R)</span><br><span>         {</span><br><span>             /* get the route=
r IP address while padding out all DHCP router options */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            const in_addr_t ret =3D do_=
extract(&amp;df-&gt;dhcp, optlen);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            const in_addr_t ret =3D do_extract(dhcp, optlen)=
;</span><br><span> </span><br><span>             /* recompute the UDP check=
sum */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            df-=
&gt;udp=2Echeck =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            df-&gt;udp=2Echeck =3D htons(ip_checksum(</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                AF_INET, (uint8_t *)&amp;d=
f-&gt;udp,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   udp-&gt;check =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            udp-&gt;check =3D htons(ip_checksum(</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                AF_INET, (uint8_t *)udp,<=
/span><br><span>                 sizeof(struct openvpn_udphdr) + sizeof(str=
uct dhcp) + optlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              (uint8_t *)&amp;df-&gt;ip=2Esaddr, (uint8_t *)&amp;df-&gt;ip=
=2Edaddr, OPENVPN_IPPROTO_UDP));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                (const uint8_t *)&amp;ip-&gt;saddr, (const uin=
t8_t *)&amp;ip-&gt;daddr, OPENVPN_IPPROTO_UDP));</span><br><span> </span><b=
r><span>             /* only return the extracted Router address if DHCPACK=
 */</span><br><span>             if (message_type =3D=3D DHCPACK)</span><br=
><span>diff --git a/src/openvpn/dhcp=2Eh b/src/openvpn/dhcp=2Eh</span><br><=
span>index 38ebf8d=2E=2E8517b92 100644</span><br><span>--- a/src/openvpn/dh=
cp=2Eh</span><br><span>+++ b/src/openvpn/dhcp=2Eh</span><br><span>@@ -80,15=
 +80,6 @@</span><br><span>     uint32_t magic;     /* must be 0x63825363 (n=
etwork order) */</span><br><span> };</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-struct dhcp_full</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    struct openvpn_iphdr ip;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct openvpn_udphdr udp;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    struct dhcp dhcp;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define DHCP_OPTIONS_BUFFER_SIZE 256</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    uint8_t options[DHCP_OPTIONS_BUF=
FER_SIZE];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #pragma pack=
()</span><br><span> </span><br><span> in_addr_t dhcp_extract_router_msg(str=
uct buffer *ipbuf);</span><br><span>diff --git a/src/openvpn/proto=2Eh b/sr=
c/openvpn/proto=2Eh</span><br><span>index 14f9264=2E=2E0841ad5 100644</span=
><br><span>--- a/src/openvpn/proto=2Eh</span><br><span>+++ b/src/openvpn/pr=
oto=2Eh</span><br><span>@@ -96,6 +96,7 @@</span><br><span>     uint16_t tot=
_len;</span><br><span>     uint16_t id;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_IP_MF      0x2000</sp=
an><br><span> #define OPENVPN_IP_OFFMASK 0x1fff</span><br><span>     uint16=
_t frag_off;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2209?usp=3Demail">change 2209</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I3630ac3defbb64e252ac30=
09fdd784153367e4fd </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2209 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Frank Lichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>

</body></html>
--XWiiWJ3FpWg=--


--===============6669026403955926660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6669026403955926660==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6669026403955926660==--

