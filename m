Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC02E606A334
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LUps2rE8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PWnwnexp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NxAqJPE6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TeqUZ9Jf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4UCHxAsDF2tpuCAvrW73vqQUknk4HgRV/gPpWFMXPl8=; b=LUps2rE8CC5QVEc+pQipXaMGch
	ZTolswPoD9hz4VhWYftC+g6qr+Ye9+CZTfBTaT7GTAk6t3irMHDUfi9F51l8fMRoDUdfnBwuCJjQ2
	oqCFHOYk99G9wIEe4bbKXOzDfm7H/JrF6CtyDprKDbO//cD93QtOPNGiPHz9udCHoZAM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU4wN-000000006Nm-0uhg;
	Thu, 19 Nov 2026 16:24:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xU4wM-000000006Nf-1jQh
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 16:24:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2GmF+xrmHgZqM2k4kxUMvAsjP9NaMyv5AK0ZcJju9qM=; b=PWnwnexpH+yxE7dh8Gp8MMroMS
 CvQoDZQgZfyY4EGxTHP2aJLG1RQ6RATyOeSqsdEkFJiMSyA8KxX/nIxUJn1gSHahKtpbNbRArEQXK
 VAX7KM+RWsCt7AJ1RQ5VN2CWTP3xeJIFAhMXQcL+1i72UzitqmPtgX1W7wBZHgaSMygE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2GmF+xrmHgZqM2k4kxUMvAsjP9NaMyv5AK0ZcJju9qM=; b=NxAqJPE6GKqemDVvr3HYru6n+4
 Tqis6OQSjXjC/wKFIhAeZTdyr+lFIaok1pLjUV+YHfvl94yHsBJYkFdGLuHYIeAHJFvvXzQyv2PQo
 NGevGoPBicrng08/fSGXBKRKOiTpbrgObA1hbHd5GxjdbfAqap51JEzyYMY2NQ0LZzuI=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU4wJ-000000006EW-3ap0 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 16:24:50 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so27132495e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 08:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795105481; x=1795710281; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2GmF+xrmHgZqM2k4kxUMvAsjP9NaMyv5AK0ZcJju9qM=;
 b=TeqUZ9JfTyzJZ6M84jgUx5rvNA5CwXgVRssSspyzDrVnucDIPhy7Ws3sG7ermOiLvQ
 sLq/BxOuvIjaqIFiU0q8+0FJm6ySkGzmOCLOKC4cn3/2NPxocONwZTdznSVcT3XqOlDa
 KyeNwurET1lmhbyv2cv3+55hCtgvpLUHo0T2tTWn10P0XUPGEkmFNef1kIqLBCafHpv3
 QspZEMnDUJThgPGobJ7GUEZtRAbMd19UlwOUpQXMVSSI/daSFRdCWdUhZmogd8os9ENw
 HhBf4a0fS26Tz6R8cd4iMpovkO3ZEnKsTvuvoXMKIVvg7ZFZKH5abVNS6WZZgkTKPoSW
 9NGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795105481; x=1795710281;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2GmF+xrmHgZqM2k4kxUMvAsjP9NaMyv5AK0ZcJju9qM=;
 b=VlF/rdNRDxUktXoWvyQ3v3awolYTi68/E1kqiSYAa8KXz9laufrIcXWGhFkwxluj2Z
 dLN2Zrss90XKmP19uKNIIx3OrJF8GH1jiQ9NZEGMANqZDeMy253UE74kE6zhUiwNi03L
 M7i7nk/Od6A5glLJ6PJD4Rr/7rzCYmfNIa9XFLs+mp1tLyQrO0ibH3WkToyI6BSoWutI
 po7qRwm7XMIjFHVlahUUK5zcac8bF9sNwRMO0d15nZWI1IypY+cLFvsoWMFtaZSxNc90
 iSs56tr9anoaVyXpAoArrD+RwvDVdtdbvLiyiXdtY7GqkT4k6g9OO1VEuhaB9BnOdBE7
 C59w==
X-Gm-Message-State: APuU4Z+/QjJOZi73HC07ODdKaQDaAUgSE8rekvViTd0UD4+tpooJPvUY
 aFsqYasa/Uoj2MFZSmm/2JnK3paOtljEfPuPBon4R9OYKUgmNSz/apVhzntMkpoAKuW4PMvupZL
 M2ZXV1ElInW+n9Uv8HT0nxrbeRyRl9glmoec9xLSf+MuVpJ9PcSxXwZW79MVfsSJ1ZrSe
X-Gm-Gg: AYBFou0Cat+S780xcAwUQxc4+jhpE6pJZBytZK0UYNCk/2T4/61K939W82nMaevNPBx
 7Z8S/oTRvJ+mouFvWtHsIlma/vz7L/J/4tpM8trtmGfjacd9RbiA05iDOuj7rI7adYTxbJqFwlq
 cdNMgcpdM9BC3QJy5vKvtraYbs3fx+0ewPKvI5Baznt99e2uOHsex5VpdgPV1sfPYBFByEDsbwp
 +vogmGE6lyMMNOwoR/OMgYGXjR75ZluujwB3nq9UaKDsJm2IGxhvHnGUwJcL8jpURbYds7TDPRs
 yNZn0rGk02XyVQ5TXyXkvurRAmrC3JVeXftIOi+rxIsuvk/PmaE6ZMFPPD5+QVTTmqasPTOScOZ
 1Jv1CK5rOt+rfqHFzpPAJW2EaacufhZHMRouaGoVbIB2gGk3itrXl578twEZt3bh4LoyjnKHqPR
 VFZZzJ1EBWprW6C9Hu8nl8W2OAZVN/HWdVMda03BhCCeNv82DVNbT55pa6DqCQB0/W2OhKVi+4s
 KT2cWmxz2cVhaEAWGeBmJ3jfqqSj4VLvnWbt4WBf0SJoZcA0vGcgmu4W8ZaORBs3vKFXvTZ9M/9
 t/lSBZI+5h+HSM4vLTMiXSx7B2xJ5lT0ZFinWLsRgcFNs9F2+tk2vOpEDQpXg+BpACU3hssUQ21
 j5bZfYz/WpOQAimuTGko0o5rmbJwtVt6Ur/+cztpILly6SNxH4iTVmdKqTvSEz7AjbGmqrCmJIQ
 BdtOkp5X4Jzja/PVM=
X-Received: by 2002:a05:600c:8210:b0:4bb:6a2d:b438 with SMTP id
 5b1f17b1804b1-4bb88786c81mr2137015e9.0.1795105480930; 
 Thu, 19 Nov 2026 08:24:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6ae2dd55sm435158f8f.30.2026.11.19.08.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:24:40 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 16:24:38 +0000
To: Lev Stipakov <lstipakov@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
X-Gerrit-Change-Number: 2209
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2209?usp=email>
X-Gerrit-Commit: 36f8ddaeb2cd952fb137a9322d5340b47799c9ea
In-Reply-To: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
References: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTE2NTQ0MDAwLkkzNjMwYWMzZGVmYmI2NGUyNTJhYzMwMDlmZGQ3ODQxNTMzNjdlNGZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5a463040f9942c57aa635cf1596c8a556b1d0d0a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xU4wJ-000000006EW-3ap0
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4319018264165496103=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4319018264165496103==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EgY2ulJtNE0="; charset=UTF-8

--EgY2ulJtNE0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov, R=C4=83zvan Cojocaru=2E

Hello Arne Schwabe, Lev Stipakov, 

I'd =
like you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2209?usp=3Demail

to look at the new patch set (#2)=2E
=

The following approvals got outdated and were removed:
Code-Review+1 by Le=
v Stipakov


Change subject: dhcp: locate the UDP header via the IP header =
length
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dhcp=
: locate the UDP header via the IP header length

dhcp_extract_router_msg()=
 assumed a 20-byte IP header, so DHCP replies
carrying IP options were not =
recognised=2E Use the IHL to find the UDP
header and skip fragments, whose =
UDP checksum covers data we don't
have=2E Drop struct dhcp_full, no longer =
used=2E

Change-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
Signed-off-by=
: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/dhcp=2Ec
M src/=
openvpn/dhcp=2Eh
M src/openvpn/proto=2Eh
3 files changed, 37 insertions(+),=
 23 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/09/2209/2

diff --git a/src/openvpn/dhcp=2Ec b/src/openvpn/dhcp=
=2Ec
index 525d567=2E=2E8c9e520 100644
--- a/src/openvpn/dhcp=2Ec
+++ b/src=
/openvpn/dhcp=2Ec
@@ -152,27 +152,49 @@
 in_addr_t
 dhcp_extract_router_msg=
(struct buffer *ipbuf)
 {
-    struct dhcp_full *df =3D (struct dhcp_full *=
)BPTR(ipbuf);
-    const int optlen =3D
-        BLEN(ipbuf)
-        - (in=
t)(sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr) + sizeof(st=
ruct dhcp));
-
-    if (optlen >=3D 0 && df->ip=2Eprotocol =3D=3D OPENVPN_I=
PPROTO_UDP
-        && df->udp=2Esource =3D=3D htons(BOOTPS_PORT) && df->ud=
p=2Edest =3D=3D htons(BOOTPC_PORT)
-        && df->dhcp=2Eop =3D=3D BOOTREP=
LY)
+    if (BLENZ(ipbuf) < sizeof(struct openvpn_iphdr))
     {
-        c=
onst int message_type =3D get_dhcp_message_type(&df->dhcp, optlen);
+      =
  return 0;
+    }
+
+    const struct openvpn_iphdr *ip =3D (const struct =
openvpn_iphdr *)BPTR(ipbuf);
+    const int hlen =3D OPENVPN_IPH_GET_LEN(ip=
->version_len);
+
+    /* Skip fragments: later ones carry no UDP header, a=
nd the checksum
+     * covers the whole datagram=2E */
+    if (ntohs(ip->=
frag_off) & (OPENVPN_IP_MF | OPENVPN_IP_OFFMASK))
+    {
+        return 0;=

+    }
+
+    /* The UDP header follows any IP options=2E */
+    struct b=
uffer udpbuf =3D *ipbuf;
+    if (hlen < (int)sizeof(struct openvpn_iphdr) =
|| !buf_advance(&udpbuf, hlen))
+    {
+        return 0;
+    }
+
+    str=
uct openvpn_udphdr *udp =3D (struct openvpn_udphdr *)BPTR(&udpbuf);
+    st=
ruct dhcp *dhcp =3D (struct dhcp *)(udp + 1);
+    const int optlen =3D
+  =
      BLEN(&udpbuf) - (int)(sizeof(struct openvpn_udphdr) + sizeof(struct d=
hcp));
+
+    if (optlen >=3D 0 && ip->protocol =3D=3D OPENVPN_IPPROTO_UDP
=
+        && udp->source =3D=3D htons(BOOTPS_PORT) && udp->dest =3D=3D htons=
(BOOTPC_PORT)
+        && dhcp->op =3D=3D BOOTREPLY)
+    {
+        const =
int message_type =3D get_dhcp_message_type(dhcp, optlen);
         if (mess=
age_type =3D=3D DHCPACK || message_type =3D=3D DHCPOFFER)
         {
      =
       /* get the router IP address while padding out all DHCP router optio=
ns */
-            const in_addr_t ret =3D do_extract(&df->dhcp, optlen);
+=
            const in_addr_t ret =3D do_extract(dhcp, optlen);
 
           =
  /* recompute the UDP checksum */
-            df->udp=2Echeck =3D 0;
-   =
         df->udp=2Echeck =3D htons(ip_checksum(
-                AF_INET, (=
uint8_t *)&df->udp,
+            udp->check =3D 0;
+            udp->check =
=3D htons(ip_checksum(
+                AF_INET, (uint8_t *)udp,
          =
       sizeof(struct openvpn_udphdr) + sizeof(struct dhcp) + optlen,
-     =
           (uint8_t *)&df->ip=2Esaddr, (uint8_t *)&df->ip=2Edaddr, OPENVPN_=
IPPROTO_UDP));
+                (const uint8_t *)&ip->saddr, (const uint8_t=
 *)&ip->daddr, OPENVPN_IPPROTO_UDP));
 
             /* only return the ext=
racted Router address if DHCPACK */
             if (message_type =3D=3D DH=
CPACK)
diff --git a/src/openvpn/dhcp=2Eh b/src/openvpn/dhcp=2Eh
index 38ebf=
8d=2E=2E8517b92 100644
--- a/src/openvpn/dhcp=2Eh
+++ b/src/openvpn/dhcp=2E=
h
@@ -80,15 +80,6 @@
     uint32_t magic;     /* must be 0x63825363 (networ=
k order) */
 };
 
-struct dhcp_full
-{
-    struct openvpn_iphdr ip;
-    s=
truct openvpn_udphdr udp;
-    struct dhcp dhcp;
-#define DHCP_OPTIONS_BUFF=
ER_SIZE 256
-    uint8_t options[DHCP_OPTIONS_BUFFER_SIZE];
-};
-
 #pragma =
pack()
 
 in_addr_t dhcp_extract_router_msg(struct buffer *ipbuf);
diff --g=
it a/src/openvpn/proto=2Eh b/src/openvpn/proto=2Eh
index 14f9264=2E=2E0841a=
d5 100644
--- a/src/openvpn/proto=2Eh
+++ b/src/openvpn/proto=2Eh
@@ -96,6 =
+96,7 @@
     uint16_t tot_len;
     uint16_t id;
 
+#define OPENVPN_IP_MF =
     0x2000
 #define OPENVPN_IP_OFFMASK 0x1fff
     uint16_t frag_off;
 

-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3630ac3defbb64=
e252ac3009fdd784153367e4fd
Gerrit-Change-Number: 2209
Gerrit-PatchSet: 2
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lst=
ipakov@gmail=2Ecom>
Gerrit-CC: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>

--EgY2ulJtNE0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov, R=C4=
=83zvan Cojocaru=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set=
 #2</strong> to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2209?usp=3Demail">View Change</a></p><p>The following appro=
vals got outdated and were removed:
Code-Review+1 by Lev Stipakov</p><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">dhcp: locate the UDP header via the IP header length<br><br>dhcp_ex=
tract_router_msg() assumed a 20-byte IP header, so DHCP replies<br>carrying=
 IP options were not recognised=2E Use the IHL to find the UDP<br>header an=
d skip fragments, whose UDP checksum covers data we don&#39;t<br>have=2E Dr=
op struct dhcp_full, no longer used=2E<br><br>Change-Id: I3630ac3defbb64e25=
2ac3009fdd784153367e4fd<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt;<br>---<br>M src/openvpn/dhcp=2Ec<br>M src/openvpn/dhcp=2Eh<br>=
M src/openvpn/proto=2Eh<br>3 files changed, 37 insertions(+), 23 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/09/2209/2</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dhcp=2Ec b/s=
rc/openvpn/dhcp=2Ec</span><br><span>index 525d567=2E=2E8c9e520 100644</span=
><br><span>--- a/src/openvpn/dhcp=2Ec</span><br><span>+++ b/src/openvpn/dhc=
p=2Ec</span><br><span>@@ -152,27 +152,49 @@</span><br><span> in_addr_t</spa=
n><br><span> dhcp_extract_router_msg(struct buffer *ipbuf)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct dhcp_ful=
l *df =3D (struct dhcp_full *)BPTR(ipbuf);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    const int optlen =3D</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        BLEN(ipbuf)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        - (int)(sizeof(struct openvpn_iphdr) + sizeof=
(struct openvpn_udphdr) + sizeof(struct dhcp));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (optlen &gt;=3D 0 &amp;&amp; df-&gt;ip=2Eprotocol =3D=3D OPENVP=
N_IPPROTO_UDP</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
&amp;&amp; df-&gt;udp=2Esource =3D=3D htons(BOOTPS_PORT) &amp;&amp; df-&gt;=
udp=2Edest =3D=3D htons(BOOTPC_PORT)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        &amp;&amp; df-&gt;dhcp=2Eop =3D=3D BOOTREPLY)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(ipbuf) &lt; =
sizeof(struct openvpn_iphdr))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const int message_type =3D get_dhcp=
_message_type(&amp;df-&gt;dhcp, optlen);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const stru=
ct openvpn_iphdr *ip =3D (const struct openvpn_iphdr *)BPTR(ipbuf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const int hlen =3D OPEN=
VPN_IPH_GET_LEN(ip-&gt;version_len);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* Skip fragments: later ones carry no UDP header, and the checksum</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * covers the whole d=
atagram=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (ntohs(ip-&gt;frag_off) &amp; (OPENVPN_IP_MF | OPENVPN_IP_OFFMASK))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* The UDP header follows any IP options=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer udpbuf =3D *ipbuf;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (hlen &lt; (int)s=
izeof(struct openvpn_iphdr) || !buf_advance(&amp;udpbuf, hlen))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct openvpn_udphdr *udp =3D (struct openvpn_udphdr *)BPTR(&amp;udpbuf);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct dhcp *dhcp=
 =3D (struct dhcp *)(udp + 1);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const int optlen =3D</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        BLEN(&amp;udpbuf) - (int)(sizeof(struct openvpn_udp=
hdr) + sizeof(struct dhcp));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (op=
tlen &gt;=3D 0 &amp;&amp; ip-&gt;protocol =3D=3D OPENVPN_IPPROTO_UDP</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; udp-&gt=
;source =3D=3D htons(BOOTPS_PORT) &amp;&amp; udp-&gt;dest =3D=3D htons(BOOT=
PC_PORT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &am=
p;&amp; dhcp-&gt;op =3D=3D BOOTREPLY)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        const int message_type =3D get_dhcp_message_type(dhcp, optlen);=
</span><br><span>         if (message_type =3D=3D DHCPACK || message_type =
=3D=3D DHCPOFFER)</span><br><span>         {</span><br><span>             /=
* get the router IP address while padding out all DHCP router options */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            const in_add=
r_t ret =3D do_extract(&amp;df-&gt;dhcp, optlen);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            const in_addr_t ret =3D do_extrac=
t(dhcp, optlen);</span><br><span> </span><br><span>             /* recomput=
e the UDP checksum */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            df-&gt;udp=2Echeck =3D 0;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            df-&gt;udp=2Echeck =3D htons(ip_checksum(</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                AF_INET, (u=
int8_t *)&amp;df-&gt;udp,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            udp-&gt;check =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            udp-&gt;check =3D htons(ip_checksum(</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                AF_INET, (u=
int8_t *)udp,</span><br><span>                 sizeof(struct openvpn_udphdr=
) + sizeof(struct dhcp) + optlen,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                (uint8_t *)&amp;df-&gt;ip=2Esaddr, (uint8_t *)&=
amp;df-&gt;ip=2Edaddr, OPENVPN_IPPROTO_UDP));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                (const uint8_t *)&amp;ip-&gt;sadd=
r, (const uint8_t *)&amp;ip-&gt;daddr, OPENVPN_IPPROTO_UDP));</span><br><sp=
an> </span><br><span>             /* only return the extracted Router addre=
ss if DHCPACK */</span><br><span>             if (message_type =3D=3D DHCPA=
CK)</span><br><span>diff --git a/src/openvpn/dhcp=2Eh b/src/openvpn/dhcp=2E=
h</span><br><span>index 38ebf8d=2E=2E8517b92 100644</span><br><span>--- a/s=
rc/openvpn/dhcp=2Eh</span><br><span>+++ b/src/openvpn/dhcp=2Eh</span><br><s=
pan>@@ -80,15 +80,6 @@</span><br><span>     uint32_t magic;     /* must be =
0x63825363 (network order) */</span><br><span> };</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-struct dhcp_full</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct openvpn_iphdr ip;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    struct openvpn_udphdr udp;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct dhcp dhcp;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define DHCP_OPTIONS_BUFFER_SIZE 256</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t options[DHC=
P_OPTIONS_BUFFER_SIZE];</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 #pragma pack()</span><br><span> </span><br><span> in_addr_t dhcp_extract_r=
outer_msg(struct buffer *ipbuf);</span><br><span>diff --git a/src/openvpn/p=
roto=2Eh b/src/openvpn/proto=2Eh</span><br><span>index 14f9264=2E=2E0841ad5=
 100644</span><br><span>--- a/src/openvpn/proto=2Eh</span><br><span>+++ b/s=
rc/openvpn/proto=2Eh</span><br><span>@@ -96,6 +96,7 @@</span><br><span>    =
 uint16_t tot_len;</span><br><span>     uint16_t id;</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_IP_MF   =
   0x2000</span><br><span> #define OPENVPN_IP_OFFMASK 0x1fff</span><br><spa=
n>     uint16_t frag_off;</span><br></pre><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demail">change 2209</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3630=
ac3defbb64e252ac3009fdd784153367e4fd </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 2209 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Co=
jocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>

</body></html>
--EgY2ulJtNE0=--


--===============4319018264165496103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4319018264165496103==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4319018264165496103==--

