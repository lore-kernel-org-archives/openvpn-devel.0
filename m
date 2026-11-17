Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A0606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dxl4/M8L;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=A/Lqi2w3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=N2W4yHZV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fRXm9Ifd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=aFlr7KOIG+wYnrGiMW4wFMfa19uukm7lf5gQhcbqMY8=; b=dxl4/M8LOV43PVs86LHqw8+NtS
	yEc2X1NZVX390bdLbpg5kr5isE1xfyp9AySO/DHv13g7zsHZhM21Au9MBZNXsK0AhZSg0iRAtFrHM
	cUEb3RhGvV55s5acjtUnXs2Lf9hG4nwOkXLV2TVcQXT8T+t39c/WCSjp9mW80fiivOaQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTHn1-000000007PF-3mW4;
	Tue, 17 Nov 2026 11:55:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTHn0-000000007P8-3GLg
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:55:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ax0dHoTO7KLcH88qgAXykYmidUFWvpobQ9iHayHemhY=; b=A/Lqi2w30fr5tiZQ6GCSlDNdBh
 RJB8ji/BlEGRfzDbwPWgs5bY9pzOdfw8dkbmEL0/+JyEBJeNdLPa19GYhhCRyVHprtDouyr/gTPt8
 IbTkyHyVY7vFBuVpkkW1WsQhaxT5eH3gHSR0wvQ1pLrNMfchvfQDH/Xf1fz59czJjOyg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ax0dHoTO7KLcH88qgAXykYmidUFWvpobQ9iHayHemhY=; b=N2W4yHZVhAsmGCgynWnK+Il2g8
 3cfhzoFp4ngfM336Pp4T+q5auJcHTM33bK/mwkwBWluvDEAtKqj54IcrN91GGfKPeSv9L8BnP95Qr
 Waf1e3030EbohL3Vur/vFU6UUi0QuC1i9wmVQXX8M1J+TeytLNqD6oSHWzdLnjoBni3M=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTHmz-000000004FN-1cdA for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:55:54 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso4797931f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 03:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794916547; x=1795521347; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ax0dHoTO7KLcH88qgAXykYmidUFWvpobQ9iHayHemhY=;
 b=fRXm9IfdZSAXJxbkjHJjYtXdIqAuul1QNA5TZmYTd7wg2in8vWErH5Z9rHw7qP/Uz1
 q7OIfm3/DlDRWuxyje9WMmzSKqO49CDGmQPB+NSwgZUAkzlQ+D7KsZ6aa+gWIHUYxwec
 6FwjFM3EbLV8vNYQRo3SWqwQzrxREV+g0hiczZuhYP8q7n1TSTCumdsuN6LjZctKEO6b
 6rnenapVcbck7ewOK7wZnCVMriKvLJbZflOvoX+R2AMkwAxa2Slu2Rvo8y+bQzC0cEr1
 i6Wd76TbcQ9ea/zxedR6A6X9JY0oIxX+LcIxb4PcXlr6x2uj1vANu2vZGrwJm2O0KTnM
 tclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794916547; x=1795521347;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ax0dHoTO7KLcH88qgAXykYmidUFWvpobQ9iHayHemhY=;
 b=Vt/tDl5I0iUtUurC5fsj50bnQRL4dfxxguwuMHgSJgvs0jCwWu2q00LF7nyj/wO2vp
 auPgO+hUZEq7gr09fKNRWxQRKVWFzsCTb+RypDkJ+B/DheN+53t9ZZelyxGpZViFtMD9
 azjiP57TdEtzBMfcmVYOw5N92DdSIbtfPuAgAOs2Kak6Yo5yKWqsKP0zoqna4+ijnwq/
 tW7PqzsM0f3+0RDkGHX17KIqzKAzyUVkJlpV/vhaT2AJGYFlsy8VGJS6p7EaUOfz+wHX
 TC5AgmUZtXSUD0O+pPpHPCSTm3i+h8OCjfyJvBPo24O7AsswI3zMzXADAUXvwuwxapew
 OsOQ==
X-Gm-Message-State: APuU4Z+agfH8CMrRPkFCETxqGq9+jzU4+lQTsnlLHJaQUL08T/IcIaBx
 pU2X4iNSSQ7HVaMNhLw88z6r8MfKS90ILD/3Re5VgCnHWrkMDcD1xsUKe0teSfc8BWFJIVYyTXT
 o2g3gYTbREzT9C4CADin3hwzjceLu1LlfhrtZZZAwIrY9/i1BnGuIKPUbWXxnV2ESNfm8ruM9aC
 Y0kikV4g==
X-Gm-Gg: AZFdTZediHwlyVY0db1ztdAlbeuDSeDdGwlBG4bW7f/KzDKxFCkBAr9BKXFNYtN5W1H
 7C8F8MdNceI15Uf6Dl/DNYAz/nTFJqJtFhlGY2SahwJue+rDWC+QIXWqI18uwM5yTxUt1j38P3E
 FOJNxJxop/mQ+2Wn3eQH//3YxQ9BGgu7Vm/Jod+druaHUbyExQz3auruGgSxujC4Pyfsnv8Cu94
 Ni+WPd112Ek3oTlD/A7fgzz++W77EwLzTLMHbg0tI2t6TTaSd6qL7TpuI73sjaWmg6Y3flziP6T
 CHutEp+OujCqz0fHjv5WCOqqkpuuS+t+Q6AhlcaDEvf78WYs+Rb+AAlmbHTgNg2plNPThzb1/6I
 Qfq8+J0MIyQc05dNdRsSIDOQ8a5Fpw374BBvjKE642tDJghomYzp7Ag5XSySRVpUZupZdqhnuKx
 SYngWWXNsO4PfUccPRYgNK4sTwxQyeOM71sVdguCS+Mvu8OtbbsJJA4PhApnuP8bKpelWXdK2ec
 wS9VlzFf8EwUItLs2vdKhzVe+/XA+JLlGydeRfu58I46n+qHcPxUxbVyQP81MVwZc/4WE15uTWj
 8LZE3KRlhyvpm5ysobzgDLSumCpne/NQaSC2UILmNPnU2Cvb29tR1Apr8auHvS61r3HXEDHNCeL
 j+IedUQ3m8O6cZHMaqqA9BWZMQ61jqnl434vji7cIEOmUCxcPKbJZq0/0qytbMe/R6TPdq4lFLD
 jw3q3Tw5C8QJ5cE+E=
X-Received: by 2002:a05:6000:4b10:b0:4a5:4367:dc84 with SMTP id
 ffacd0b85a97d-4a54367dd1amr1125557f8f.18.1794916546544; 
 Tue, 17 Nov 2026 03:55:46 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c605e4a2asm26625354f8f.39.2026.11.17.03.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 03:55:46 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 11:55:45 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
X-Gerrit-Change-Number: 2209
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2209?usp=email>
X-Gerrit-Commit: 5a1090cb382ecdf4f80d611cc42553934488cce2
References: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTE2NTQ0MDAwLkkzNjMwYWMzZGVmYmI2NGUyNTJhYzMwMDlmZGQ3ODQxNTMzNjdlNGZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <92a75bcf60193e5503bf017223d8bc1675904e07-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTHmz-000000004FN-1cdA
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6762548202118068048=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6762548202118068048==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="01FHEWt5Omo="; charset=UTF-8

--01FHEWt5Omo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2209?usp=3Demail

to review the following change=2E
=


Change subject: dhcp: locate the UDP header via the IP header length
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dhcp: locate the=
 UDP header via the IP header length

dhcp_extract_router_msg() assumed a 2=
0-byte IP header, so DHCP replies
carrying IP options were not recognised=
=2E Use the IHL to find the UDP
header and skip fragments, whose UDP checks=
um covers data we don't
have=2E Drop struct dhcp_full, no longer used=2E

C=
hange-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
Signed-off-by: Razvan C=
ojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/dhcp=2Ec
M src/openvpn/dh=
cp=2Eh
M src/openvpn/proto=2Eh
3 files changed, 32 insertions(+), 23 deleti=
ons(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/09/2209/1

diff --git a/src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=2Ec
index=
 525d567=2E=2Ecbbf0d7 100644
--- a/src/openvpn/dhcp=2Ec
+++ b/src/openvpn/d=
hcp=2Ec
@@ -152,27 +152,44 @@
 in_addr_t
 dhcp_extract_router_msg(struct bu=
ffer *ipbuf)
 {
-    struct dhcp_full *df =3D (struct dhcp_full *)BPTR(ipbu=
f);
-    const int optlen =3D
-        BLEN(ipbuf)
-        - (int)(sizeof(=
struct openvpn_iphdr) + sizeof(struct openvpn_udphdr) + sizeof(struct dhcp)=
);
-
-    if (optlen >=3D 0 && df->ip=2Eprotocol =3D=3D OPENVPN_IPPROTO_UDP=

-        && df->udp=2Esource =3D=3D htons(BOOTPS_PORT) && df->udp=2Edest =
=3D=3D htons(BOOTPC_PORT)
-        && df->dhcp=2Eop =3D=3D BOOTREPLY)
+    =
if (BLENZ(ipbuf) < sizeof(struct openvpn_iphdr))
     {
-        const int =
message_type =3D get_dhcp_message_type(&df->dhcp, optlen);
+        return =
0;
+    }
+
+    const struct openvpn_iphdr *ip =3D (const struct openvpn_i=
phdr *)BPTR(ipbuf);
+    const int hlen =3D OPENVPN_IPH_GET_LEN(ip->version=
_len);
+
+    /* The UDP header follows any IP options=2E Skip fragments: l=
ater ones
+     * carry no UDP header, and the checksum covers the whole da=
tagram=2E */
+    struct buffer udpbuf =3D *ipbuf;
+    if ((ntohs(ip->frag=
_off) & (OPENVPN_IP_MF | OPENVPN_IP_OFFMASK))
+        || hlen < (int)sizeo=
f(struct openvpn_iphdr) || !buf_advance(&udpbuf, hlen))
+    {
+        ret=
urn 0;
+    }
+
+    struct openvpn_udphdr *udp =3D (struct openvpn_udphdr =
*)BPTR(&udpbuf);
+    struct dhcp *dhcp =3D (struct dhcp *)(udp + 1);
+    =
const int optlen =3D
+        BLEN(&udpbuf) - (int)(sizeof(struct openvpn_u=
dphdr) + sizeof(struct dhcp));
+
+    if (optlen >=3D 0 && ip->protocol =3D=
=3D OPENVPN_IPPROTO_UDP
+        && udp->source =3D=3D htons(BOOTPS_PORT) &=
& udp->dest =3D=3D htons(BOOTPC_PORT)
+        && dhcp->op =3D=3D BOOTREPLY=
)
+    {
+        const int message_type =3D get_dhcp_message_type(dhcp, op=
tlen);
         if (message_type =3D=3D DHCPACK || message_type =3D=3D DHCP=
OFFER)
         {
             /* get the router IP address while padding o=
ut all DHCP router options */
-            const in_addr_t ret =3D do_extra=
ct(&df->dhcp, optlen);
+            const in_addr_t ret =3D do_extract(dhcp=
, optlen);
 
             /* recompute the UDP checksum */
-            df-=
>udp=2Echeck =3D 0;
-            df->udp=2Echeck =3D htons(ip_checksum(
-  =
              AF_INET, (uint8_t *)&df->udp,
+            udp->check =3D 0;
=
+            udp->check =3D htons(ip_checksum(
+                AF_INET, (u=
int8_t *)udp,
                 sizeof(struct openvpn_udphdr) + sizeof(struc=
t dhcp) + optlen,
-                (uint8_t *)&df->ip=2Esaddr, (uint8_t *)&=
df->ip=2Edaddr, OPENVPN_IPPROTO_UDP));
+                (const uint8_t *)&i=
p->saddr, (const uint8_t *)&ip->daddr, OPENVPN_IPPROTO_UDP));
 
           =
  /* only return the extracted Router address if DHCPACK */
             if=
 (message_type =3D=3D DHCPACK)
diff --git a/src/openvpn/dhcp=2Eh b/src/open=
vpn/dhcp=2Eh
index 38ebf8d=2E=2E8517b92 100644
--- a/src/openvpn/dhcp=2Eh
+=
++ b/src/openvpn/dhcp=2Eh
@@ -80,15 +80,6 @@
     uint32_t magic;     /* mu=
st be 0x63825363 (network order) */
 };
 
-struct dhcp_full
-{
-    struct =
openvpn_iphdr ip;
-    struct openvpn_udphdr udp;
-    struct dhcp dhcp;
-#=
define DHCP_OPTIONS_BUFFER_SIZE 256
-    uint8_t options[DHCP_OPTIONS_BUFFE=
R_SIZE];
-};
-
 #pragma pack()
 
 in_addr_t dhcp_extract_router_msg(struct =
buffer *ipbuf);
diff --git a/src/openvpn/proto=2Eh b/src/openvpn/proto=2Eh
=
index 14f9264=2E=2E0841ad5 100644
--- a/src/openvpn/proto=2Eh
+++ b/src/ope=
nvpn/proto=2Eh
@@ -96,6 +96,7 @@
     uint16_t tot_len;
     uint16_t id;
 =

+#define OPENVPN_IP_MF      0x2000
 #define OPENVPN_IP_OFFMASK 0x1fff
    =
 uint16_t frag_off;
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2209?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
Gerrit-Change-Number: 2209
G=
errit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>

--01FHEWt5Omo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">dhcp: locate the UDP header via the IP header length<br=
><br>dhcp_extract_router_msg() assumed a 20-byte IP header, so DHCP replies=
<br>carrying IP options were not recognised=2E Use the IHL to find the UDP<=
br>header and skip fragments, whose UDP checksum covers data we don&#39;t<b=
r>have=2E Drop struct dhcp_full, no longer used=2E<br><br>Change-Id: I3630a=
c3defbb64e252ac3009fdd784153367e4fd<br>Signed-off-by: Razvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/dhcp=2Ec<br>M src/openvpn/=
dhcp=2Eh<br>M src/openvpn/proto=2Eh<br>3 files changed, 32 insertions(+), 2=
3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/09/2209/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/dhcp=2Ec b/src/openvpn/dhcp=2Ec</span><br><span>index 525d567=2E=2Ecbbf0d=
7 100644</span><br><span>--- a/src/openvpn/dhcp=2Ec</span><br><span>+++ b/s=
rc/openvpn/dhcp=2Ec</span><br><span>@@ -152,27 +152,44 @@</span><br><span> =
in_addr_t</span><br><span> dhcp_extract_router_msg(struct buffer *ipbuf)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct dhcp_full *df =3D (struct dhcp_full *)BPTR(ipbuf);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    const int optlen =3D</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        BLEN(ipbuf)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        - (int)(sizeof(struct openvpn_i=
phdr) + sizeof(struct openvpn_udphdr) + sizeof(struct dhcp));</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (optlen &gt;=3D 0 &amp;&amp; df-&gt;ip=2Eprotocol=
 =3D=3D OPENVPN_IPPROTO_UDP</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        &amp;&amp; df-&gt;udp=2Esource =3D=3D htons(BOOTPS_PORT) &amp=
;&amp; df-&gt;udp=2Edest =3D=3D htons(BOOTPC_PORT)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        &amp;&amp; df-&gt;dhcp=2Eop =3D=3D BOO=
TREPLY)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLEN=
Z(ipbuf) &lt; sizeof(struct openvpn_iphdr))</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        const int message_type=
 =3D get_dhcp_message_type(&amp;df-&gt;dhcp, optlen);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const struct openvpn_iphdr *ip =3D (const struct openvpn_iphdr *)BPTR(=
ipbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const in=
t hlen =3D OPENVPN_IPH_GET_LEN(ip-&gt;version_len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* The UDP header follows any IP options=2E Skip fragmen=
ts: later ones</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* carry no UDP header, and the checksum covers the whole datagram=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer udpbu=
f =3D *ipbuf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 ((ntohs(ip-&gt;frag_off) &amp; (OPENVPN_IP_MF | OPENVPN_IP_OFFMASK))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        || hlen &lt; (int=
)sizeof(struct openvpn_iphdr) || !buf_advance(&amp;udpbuf, hlen))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct openvpn_udphdr *udp =3D (struct openvpn_udphdr *)BPTR(&amp;udpb=
uf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct dhcp=
 *dhcp =3D (struct dhcp *)(udp + 1);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const int optlen =3D</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        BLEN(&amp;udpbuf) - (int)(sizeof(struct openv=
pn_udphdr) + sizeof(struct dhcp));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (optlen &gt;=3D 0 &amp;&amp; ip-&gt;protocol =3D=3D OPENVPN_IPPROTO_UDP<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; u=
dp-&gt;source =3D=3D htons(BOOTPS_PORT) &amp;&amp; udp-&gt;dest =3D=3D hton=
s(BOOTPC_PORT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   &amp;&amp; dhcp-&gt;op =3D=3D BOOTREPLY)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        const int message_type =3D get_dhcp_message_type(dhcp, op=
tlen);</span><br><span>         if (message_type =3D=3D DHCPACK || message_=
type =3D=3D DHCPOFFER)</span><br><span>         {</span><br><span>         =
    /* get the router IP address while padding out all DHCP router options =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            const i=
n_addr_t ret =3D do_extract(&amp;df-&gt;dhcp, optlen);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            const in_addr_t ret =3D do_e=
xtract(dhcp, optlen);</span><br><span> </span><br><span>             /* rec=
ompute the UDP checksum */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            df-&gt;udp=2Echeck =3D 0;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            df-&gt;udp=2Echeck =3D htons(ip_checksum(<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                AF_INE=
T, (uint8_t *)&amp;df-&gt;udp,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            udp-&gt;check =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            udp-&gt;check =3D htons(ip_checksum(</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                AF_INE=
T, (uint8_t *)udp,</span><br><span>                 sizeof(struct openvpn_u=
dphdr) + sizeof(struct dhcp) + optlen,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                (uint8_t *)&amp;df-&gt;ip=2Esaddr, (uint8_=
t *)&amp;df-&gt;ip=2Edaddr, OPENVPN_IPPROTO_UDP));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                (const uint8_t *)&amp;ip-&gt=
;saddr, (const uint8_t *)&amp;ip-&gt;daddr, OPENVPN_IPPROTO_UDP));</span><b=
r><span> </span><br><span>             /* only return the extracted Router =
address if DHCPACK */</span><br><span>             if (message_type =3D=3D =
DHCPACK)</span><br><span>diff --git a/src/openvpn/dhcp=2Eh b/src/openvpn/dh=
cp=2Eh</span><br><span>index 38ebf8d=2E=2E8517b92 100644</span><br><span>--=
- a/src/openvpn/dhcp=2Eh</span><br><span>+++ b/src/openvpn/dhcp=2Eh</span><=
br><span>@@ -80,15 +80,6 @@</span><br><span>     uint32_t magic;     /* mus=
t be 0x63825363 (network order) */</span><br><span> };</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-struct dhcp_full</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct openvpn_iphdr ip;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct openvpn_udphdr udp;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct dhcp dhcp;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define DHCP_OPTIONS_BUFFER_SIZE =
256</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t option=
s[DHCP_OPTIONS_BUFFER_SIZE];</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> #pragma pack()</span><br><span> </span><br><span> in_addr_t dhcp_extr=
act_router_msg(struct buffer *ipbuf);</span><br><span>diff --git a/src/open=
vpn/proto=2Eh b/src/openvpn/proto=2Eh</span><br><span>index 14f9264=2E=2E08=
41ad5 100644</span><br><span>--- a/src/openvpn/proto=2Eh</span><br><span>++=
+ b/src/openvpn/proto=2Eh</span><br><span>@@ -96,6 +96,7 @@</span><br><span=
>     uint16_t tot_len;</span><br><span>     uint16_t id;</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_IP_=
MF      0x2000</span><br><span> #define OPENVPN_IP_OFFMASK 0x1fff</span><br=
><span>     uint16_t frag_off;</span><br></pre><p>To view, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demail">change 2209</=
a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div =
itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3=
630ac3defbb64e252ac3009fdd784153367e4fd </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2209 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--01FHEWt5Omo=--


--===============6762548202118068048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6762548202118068048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6762548202118068048==--

