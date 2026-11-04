Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC3C606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=j6XXkqym;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hWRCyZQt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=W/eZGt//;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bzuhk/L/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=rPO8k0FuXz79vePHEzc1iRGKMG4JhAltypK2V3KAQJY=; b=j6XXkqymRkLegs/0AqSoTw9jgR
	C71oqT3z6pGMVPMdMMfjk6jHDEs+GvRGhNDnnsstJdsG8X4KTE11Ui0NHApD8tAgTumy/gbK/Bt+q
	X3PVbQ/hg/QtvflFq2x1sXZgx3HZBbv8tNxkmPAgLlHdKAgonaGeDaGLwZrDcKpzhZ7M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOWOQ-0000000021t-2I9H;
	Wed, 04 Nov 2026 08:30:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOWOO-0000000021c-3cDT
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 08:30:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BcSSv94xOj2ckq3N0ygqJw+pKTviXB1RNEQLizEtC4E=; b=hWRCyZQtxm/GJjIks/AS10YoE2
 ZCPS1XALfIcu30v8JdtKTkJSMrL8x2UY+cv5i3c4HRv3kbA9woNEtazOh+JaCNXwhPYsncNHdL/XD
 wZLH6/zmIC+53K5MJYGTyLKdrvp2WQrsbSo+25q6qDC0ggAAN0pEvnrcxB0XBIp+eaAA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BcSSv94xOj2ckq3N0ygqJw+pKTviXB1RNEQLizEtC4E=; b=W/eZGt//msr2VCwRnta+cj+so9
 +TaMuiW0nTxfDQD+d4Zx+BIk1IrGr1aLIVTucQMiQP4noQegNc6C1zOPD7CVbOgNb0ucP4pFP0xR8
 G7n1ipDYaIGCr5obIhTSlnb0PvyPmX33HIUzaW4uu1RGWd7O8hlaPSpXHpdPZR2J/Q4c=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOWON-000000000D6-0rG4 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 08:30:48 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso158729f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 00:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793781041; x=1794385841; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BcSSv94xOj2ckq3N0ygqJw+pKTviXB1RNEQLizEtC4E=;
 b=bzuhk/L/yez64qbErfnWLEAckuFTmF6y1Qt+DxpMW/7sSRxWfDH6R040x60sdnlkMI
 JvZxyC/DqnrzgFUkCoryx0tGb3dJI3JTLKhzWVAScMjkzW34y/Zi53qPZpWTt2y+QZmF
 xj+UJFarlbDvpqbCAFLVAgvov12kyRfCnXGrJ4vAby9uXKuhgg+rKyfJiQgMbNsAtO6K
 hRqpWVz6/FRRST60oZ/dNUjMhuNjsqtU7JNmpA5Wc/c+RAhoLhSOVrmEXhhFXIuMEn4u
 cuqb2Mpolv55GhtisLhFgbXfIkUsmdiHGH/9THO62xydjsP2VeXXc81WzjmpMJFhpYNH
 VqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793781041; x=1794385841;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BcSSv94xOj2ckq3N0ygqJw+pKTviXB1RNEQLizEtC4E=;
 b=w9WV8XsZYv98JRq2L59xmpX7iA/LC8qFyvtfDJRFsFkd3uubCvLV4+6Ym5RvvmnkYW
 zZWaZvw6I8iRTLlDqVpb7kxPOJPorTd5bLh2N3efyGr/nAgLUGqT9+Gr9ry78/6cV1JR
 1sx12TCGG2HmCnQYwEXYNxzz6fUDHGP8fYuNvorS8DMShI8iYlWeJegJ/8wUMY0yvfow
 0fp9qi8yKe6W0kCgu4fDAf8LAFNZ3vasZR4iDWRAei1m5b2QFjDHu98EN1CERUULc6xB
 nzjSqQrRWmg+YDwBjFPx9Ebko3LHzQ+t6RgFgC9skh3Jzn3xbcJicXUyaFPb5o0PchuG
 G7sA==
X-Gm-Message-State: APuU4Z8tLfhshYZWJ55G1HpqT73dFn2MeVTkx2vMQDhc2Tq1kX0qbPbL
 dSLsm0SAsL+eML2QF6T84tvGvpoBYuS+BZsIQfYTPcn4fjnPUh/4u6xa7u63+DG35QNs/x8+rrY
 8r4fPhDAeLv/8US30MdsfqCbf8QcZqoZ0p1qKkP4uSlUIWqdSJGSLfWQQoPcLxSXREqFj36ZGxe
 YWocux9g==
X-Gm-Gg: AYBFou2FONz1Pmooex4+MIaUy1RkaZcgkTjMNOaGH6+O6vE3XjdjviKoJgeQblG4Xri
 4p3TTDdYdEZsnPmHJJiM7CSFU+5vwegybeA5QRfznhvS9TEgMKJdq3LB8efeAuiESjrhNykpA4X
 sbMwPiCG+plc9+zTdCuNckQAlKuasCLQwBrF/qah4CQv22sgLR+fdxxf677fNs0oc9o9POw/PbW
 cQ3bPtc2FpsafDflmtFDY3tO2FaCfCNTwZNpHRVex9+0Dyg/NtkULle1d6xFdgwMjwV63ccDnCV
 d0JKJKYrfoKkJkQlVkZ7aQBi9x9HOVtHyB3GWUsq59mHyNPB5ryxqUHNwgHjndSuDx0nWDMZmNr
 XimP+dkbkUtrK5CA0DAtGioUOiYIL5zBWiJOdHWQ1purrnhzr7PvlkXGHtBJABbfA6BjyiH71Ci
 30zVjOLhpxaY7wApOall8U9Sze0E6XpEY+mFYZnSnzrAycifPC1ogV58clIok/J6FCml9FgPRVc
 QbNZMTNXjUWd79kPmvCF/vWh5iX8a2mJ1fS06xIdfHMIXhJakL0vzr21X30qDXaQifIs76sYik3
 JKVx9isMpubU0kbtuoAls9L9Kgj57FeAuG+AQYrgi08eNYjDqyUGv1d25+vxaYFk2bQFzzlb2ty
 xq/7qZorl7+5e/fIJUS3QTNogsWHt4o6+5ihs/ARtAou+w0VLle5jmWCYT7YoDW4AKBv6i8QraD
 0ymexALeVSXTrcTaJwltaANMyr7HjwDdk0fFo=
X-Received: by 2002:a05:600c:4715:b0:4a6:eca1:7d5c with SMTP id
 5b1f17b1804b1-4ac182dca82mr361316715e9.32.1793781040297; 
 Wed, 04 Nov 2026 00:30:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4533873f0sm33416635e9.4.2026.11.04.00.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:30:39 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 08:30:39 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d
X-Gerrit-Change-Number: 2126
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2126?usp=email>
X-Gerrit-Commit: af0a34c160f03ea97af19b58ec16fa4b6e8f6116
References: <gerrit.1793781037000.I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzgxMDM3MDAwLkkwZjhlYTRmYTU3MmY4NGU2ZGNjOWIwODA2YzIzOTc3YzY0ZWE2NDVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <42ee1f6829e56a81d1a5a9d5afef88d05745cd54-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOWON-000000000D6-0rG4
Subject: [Openvpn-devel] [M] Change in openvpn[master]: pool: reuse
 handle-to-address helpers in ifconfig_pool_acquire()
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
Content-Type: multipart/mixed; boundary="===============3928778340268506683=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3928778340268506683==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jad2f6lDcCg="; charset=UTF-8

--jad2f6lDcCg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2126?usp=3Demail

to review the following change=2E
=


Change subject: pool: reuse handle-to-address helpers in ifconfig_pool_ac=
quire()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

pool=
: reuse handle-to-address helpers in ifconfig_pool_acquire()

ifconfig_pool=
_acquire() duplicated the address calculation of
ifconfig_pool_handle_to_ip=
_base() and
ifconfig_pool_handle_to_ipv6_base()=2E Use those instead, and a=
dd
in6_addr_low32() for the three open-coded conversions of the last
32 bit=
s of an IPv6 address=2E Its uint32_t casts also avoid shifting
an int into =
the sign bit=2E

Change-Id: I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d
Signe=
d-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/pool=2E=
c
1 file changed, 27 insertions(+), 28 deletions(-)



  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/26/2126/1

diff --git a/src/=
openvpn/pool=2Ec b/src/openvpn/pool=2Ec
index fff0e3f=2E=2E7978f93 100644
-=
-- a/src/openvpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -35,6 +35,20 @@
 
 =
#include "memdbg=2Eh"
 
+static in_addr_t ifconfig_pool_handle_to_ip_base(c=
onst struct ifconfig_pool *pool,
+                                         =
        ifconfig_pool_handle hand);
+
+static struct in6_addr ifconfig_pool=
_handle_to_ipv6_base(const struct ifconfig_pool *pool,
+                   =
                                      ifconfig_pool_handle hand);
+
+/* Ret=
urn the last 32 bits of an IPv6 address in host byte order */
+static inlin=
e uint32_t
+in6_addr_low32(const struct in6_addr *a)
+{
+    return ((uint3=
2_t)a->s6_addr[12] << 24) | ((uint32_t)a->s6_addr[13] << 16)
+           | =
((uint32_t)a->s6_addr[14] << 8) | a->s6_addr[15];
+}
+
 static void
 ifconf=
ig_pool_entry_free(struct ifconfig_pool_entry *ipe, bool hard)
 {
@@ -192,8=
 +206,7 @@
          * 4 bytes, therefore we can just extract that and use =
it as base in
          * integer form
          */
-        uint32_t base =
=3D (ipv6_base=2Es6_addr[12] << 24) | (ipv6_base=2Es6_addr[13] << 16)
-    =
                    | (ipv6_base=2Es6_addr[14] << 8) | ipv6_base=2Es6_addr[=
15];
+        uint32_t base =3D in6_addr_low32(&ipv6_base);
         /* som=
e bits of the last 4 bytes may still be part of the network
          * por=
tion of the address, therefore we need to set them to 0
          */
@@ -31=
4,33 +327,22 @@
 
         if (pool->ipv4=2Eenabled && local && remote)
   =
      {
-            switch (pool->ipv4=2Etype)
+            const in_addr_=
t b =3D ifconfig_pool_handle_to_ip_base(pool, i);
+            if (pool->ip=
v4=2Etype =3D=3D IFCONFIG_POOL_30NET)
             {
-                case =
IFCONFIG_POOL_30NET:
-                {
-                    in_addr_t b =
=3D pool->ipv4=2Ebase + (i << 2);
-                    *local =3D b + 1;
- =
                   *remote =3D b + 2;
-                    break;
-        =
        }
-
-                case IFCONFIG_POOL_INDIV:
-                {
-=
                    in_addr_t b =3D pool->ipv4=2Ebase + i;
-               =
     *local =3D 0;
-                    *remote =3D b;
-                   =
 break;
-                }
-
-                default:
-                   =
 ASSERT(0);
+                *local =3D b + 1;
+                *remote =3D=
 b + 2;
+            }
+            else
+            {
+                *l=
ocal =3D 0;
+                *remote =3D b;
             }
         }
 
-  =
      /* IPv6 pools are always INDIV (--linear) */
         if (pool->ipv6=
=2Eenabled && remote_ipv6)
         {
-            *remote_ipv6 =3D add_in6=
_addr(pool->ipv6=2Ebase, i);
+            *remote_ipv6 =3D ifconfig_pool_ha=
ndle_to_ipv6_base(pool, i);
         }
     }
     return i;
@@ -415,11 +41=
7,8 @@
         }
     }
 
-    base =3D (pool->ipv6=2Ebase=2Es6_addr[12] <=
< 24) | (pool->ipv6=2Ebase=2Es6_addr[13] << 16)
-           | (pool->ipv6=
=2Ebase=2Es6_addr[14] << 8) | pool->ipv6=2Ebase=2Es6_addr[15];
-
-    addr =
=3D (in_addr->s6_addr[12] << 24) | (in_addr->s6_addr[13] << 16) | (in_addr-=
>s6_addr[14] << 8)
-           | in_addr->s6_addr[15];
+    base =3D in6_ad=
dr_low32(&pool->ipv6=2Ebase);
+    addr =3D in6_addr_low32(in_addr);
 
    =
 ret =3D addr - base;
     if (ret < 0 || ret >=3D pool->size)

-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2126?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0f8ea4fa572f84e6dcc9b0806c=
23977c64ea645d
Gerrit-Change-Number: 2126
Gerrit-PatchSet: 1
Gerrit-Owner: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--jad2f6lDcCg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2126?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">pool: reuse handle-to-address helpers in ifconfig_pool_=
acquire()<br><br>ifconfig_pool_acquire() duplicated the address calculation=
 of<br>ifconfig_pool_handle_to_ip_base() and<br>ifconfig_pool_handle_to_ipv=
6_base()=2E Use those instead, and add<br>in6_addr_low32() for the three op=
en-coded conversions of the last<br>32 bits of an IPv6 address=2E Its uint3=
2_t casts also avoid shifting<br>an int into the sign bit=2E<br><br>Change-=
Id: I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d<br>Signed-off-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/pool=2Ec<br>1 fi=
le changed, 27 insertions(+), 28 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/26/2126/1</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec</span><br><s=
pan>index fff0e3f=2E=2E7978f93 100644</span><br><span>--- a/src/openvpn/poo=
l=2Ec</span><br><span>+++ b/src/openvpn/pool=2Ec</span><br><span>@@ -35,6 +=
35,20 @@</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic in_addr_t ifconfig_pool_handle_to_ip_base(const struct ifconfig_pool =
*pool,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                                    ifconfig_pool_handle hand);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static struct in6_addr ifconfig_pool_handle_to_ipv=
6_base(const struct ifconfig_pool *pool,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                                      =
   ifconfig_pool_handle hand);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Retur=
n the last 32 bits of an IPv6 address in host byte order */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static inline uint32_t</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+in6_addr_low32(const struct in6_=
addr *a)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return ((uint32_t)a-&gt;s=
6_addr[12] &lt;&lt; 24) | ((uint32_t)a-&gt;s6_addr[13] &lt;&lt; 16)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+           | ((uint32_t)a-&=
gt;s6_addr[14] &lt;&lt; 8) | a-&gt;s6_addr[15];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> static void</span><br><span> ifconfig_pool_entr=
y_free(struct ifconfig_pool_entry *ipe, bool hard)</span><br><span> {</span=
><br><span>@@ -192,8 +206,7 @@</span><br><span>          * 4 bytes, therefo=
re we can just extract that and use it as base in</span><br><span>         =
 * integer form</span><br><span>          */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        uint32_t base =3D (ipv6_base=2Es6_addr[12] &=
lt;&lt; 24) | (ipv6_base=2Es6_addr[13] &lt;&lt; 16)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        | (ipv6_base=2Es6_a=
ddr[14] &lt;&lt; 8) | ipv6_base=2Es6_addr[15];</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        uint32_t base =3D in6_addr_low32(&amp;ip=
v6_base);</span><br><span>         /* some bits of the last 4 bytes may sti=
ll be part of the network</span><br><span>          * portion of the addres=
s, therefore we need to set them to 0</span><br><span>          */</span><b=
r><span>@@ -314,33 +327,22 @@</span><br><span> </span><br><span>         if=
 (pool-&gt;ipv4=2Eenabled &amp;&amp; local &amp;&amp; remote)</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    switch (pool-&gt;ipv4=2Etype)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            const in_addr_t b =3D ifconfig_pool_handle_to_ip_=
base(pool, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if (pool-&gt;ipv4=2Etype =3D=3D IFCONFIG_POOL_30NET)</span><br><span=
>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          case IFCONFIG_POOL_30NET:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    in_addr_t b =3D pool-&gt;ipv4=2Ebase + (i &lt=
;&lt; 2);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        *local =3D b + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    *remote =3D b + 2;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    break;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                case IFCONFIG_POOL_INDIV:</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    in_addr_t b =3D pool-&gt;ipv4=2Ebase +=
 i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  *local =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              *remote =3D b;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    break;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          ASSERT(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                *local =3D b + 1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                *remote =3D b + 2;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                *local =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                *remote =3D b;</span><br><span>   =
          }</span><br><span>         }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        /* IPv6 pools are always INDIV (=
--linear) */</span><br><span>         if (pool-&gt;ipv6=2Eenabled &amp;&amp=
; remote_ipv6)</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            *remote_ipv6 =3D add_in6_addr(pool-&gt;ipv6=
=2Ebase, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     *remote_ipv6 =3D ifconfig_pool_handle_to_ipv6_base(pool, i);</span><br=
><span>         }</span><br><span>     }</span><br><span>     return i;</sp=
an><br><span>@@ -415,11 +417,8 @@</span><br><span>         }</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    base =3D (pool-&gt;ipv6=2Ebase=2Es6_addr[12] &lt;&lt; 24) | (pool-=
&gt;ipv6=2Ebase=2Es6_addr[13] &lt;&lt; 16)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-           | (pool-&gt;ipv6=2Ebase=2Es6_addr[14] &lt;&=
lt; 8) | pool-&gt;ipv6=2Ebase=2Es6_addr[15];</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    addr =3D (in_addr-&gt;s6_addr[12] &lt;&lt; 24) | (in_addr-&gt;s6_addr=
[13] &lt;&lt; 16) | (in_addr-&gt;s6_addr[14] &lt;&lt; 8)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-           | in_addr-&gt;s6_addr[15];</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    base =3D in6_addr_=
low32(&amp;pool-&gt;ipv6=2Ebase);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    addr =3D in6_addr_low32(in_addr);</span><br><span> </span=
><br><span>     ret =3D addr - base;</span><br><span>     if (ret &lt; 0 ||=
 ret &gt;=3D pool-&gt;size)</span><br></pre><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2126?usp=3Demail">change 2126</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2126?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f8=
ea4fa572f84e6dcc9b0806c23977c64ea645d </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2126 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--jad2f6lDcCg=--


--===============3928778340268506683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3928778340268506683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3928778340268506683==--

