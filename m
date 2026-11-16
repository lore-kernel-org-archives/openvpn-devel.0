Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A00A606A883
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hTNRnF+H;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EBZDFVVw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EoAe9agu;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GMn4Ota3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TdSZZUFPU0/DTI4MUSvgu/zAK3uPNkDtyijnQi23/8w=; b=hTNRnF+HbM+9ULAHOcNW7ZA5sI
	/MrCoO/AnB3qP7K9BDz65W4kSsMs/GcrKL0/TA5wVahQqp9fc2CaBu9Cubfy7VqjMPpgwVEt34GiF
	uMAtIwFbU5Lc8V5pBc3AxX+/E5GKN1i26QqWXRt6GK/jIf1Jemh2BddKC2/Ea81DvgrU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSs24-000000004ph-3d11;
	Mon, 16 Nov 2026 08:25:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSs23-000000004pZ-0LBq
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:25:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9xBPevy7s5U2FcSsTQX8l2o8vggTuEG9r/MA7ptAzK4=; b=EBZDFVVwyMowjBkJawWDN4VVHS
 dndjVRQIm8Osvk5wQLtGmzduj007dFzmIUywZCG/lh1EPPiujvcYR07+lC4sDQ2ZDXmnkYP4LwO0P
 mPkYjFOJrjUDWZpT8jDiLWO0M6yS4GcEakQ90X5LscQX38x0A7Q/b5lnSc3mVc7j6L6s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9xBPevy7s5U2FcSsTQX8l2o8vggTuEG9r/MA7ptAzK4=; b=EoAe9aguW3MpW2ac7kbwo0Qgd+
 4wUyyLYSIJHqCBJZJzW8+nDAfNF7UyDSy7CUgneeDlPdNHnfDNuk0pPAIbhmXWE8V/vDHzeYSF4XW
 +gjr4fiWnGc8SXsJcyk9cCfkki5i55XDU4TPEKhC8z/Zv3i2GCH7ZUSKUphFnjrddjr4=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSs20-000000006OE-3YYF for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 08:25:43 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so3498665e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 00:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794817534; x=1795422334; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9xBPevy7s5U2FcSsTQX8l2o8vggTuEG9r/MA7ptAzK4=;
 b=GMn4Ota3WST0pfnpeE2RAqLVQJBZz+S91z77B9OcildQbWmlBhY8dZdBn5RTnvbn22
 RU9vH//XCs1HoT1EQOP5UxpYDODtBHtkUq/73qLMEK10Z/xtu1A6Z0+CUnvd7oSX3/XJ
 LBcmjfp1peAEqHsmLejD41jsGlsIwaGflnb8uBzGHizd3xBNwR3vpALTiHGMLhIjtWe5
 rsneh8Cmthkuz3FyLl8QAoNRr/wV4cOnKWhVv+/HycbNbVxYhovMIZWFXCBL0B8U6K0s
 peYW7XS3ttsuwPRDJQ8ulWYMbuDkuTv/U9LdtZFvuxa6B6yuXQCWlWbaUiuoLUlZJUji
 Ll1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794817534; x=1795422334;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9xBPevy7s5U2FcSsTQX8l2o8vggTuEG9r/MA7ptAzK4=;
 b=n68O6PTJB4aWO4EvP6paeWUOuYlszc7+K5pSeRZEvBaq1s4DpXptnv7XuiNpCLYnaX
 2+AHsEJAL7b9/cWpWxFhNlXHFGW1DS+UtAKS8wBFqzGPnq8lKjdXUzFl9nY21IxygGIH
 mCzppx2et6Jopg1wipev15C2/LtMGHXrAedrci3RaiDFpzHZXdFGzZUYb3xyLSQkuZrA
 dHDBoSyxAZMIQGna77K5AZUiA02PMlT7i14bDIyBLUEADWkMgcEY/VVzijZgUm8jRWuF
 szPdg+bgAC4zsvCZthc9dkpCaCFFW0FRMkEfC2zo3FYDoeTQ1FuSF7aSUWf2K0nJQo29
 Pysw==
X-Forwarded-Encrypted: i=1;
 AL+hErGrGtYDYwEMX7GVASH4zXKp0gqUxOHBVUSqWf/OxGrcNjIi/xCkE5BAUSYX0iZoJnhuXv1QENGKbDtDaviH@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/8YRwEK5XcOZSGeUjw4xgV+ot0DbHWEjzZqQAvWuuZysXebodQ
 YPUtUBjRZIfhMuuHDp9DFFegG1iChubedp8DLtdim39vqLlkxmgqJCi56wUKZCvccxpbeJ3qzwq
 ox1y0by7fZxjttT5kizjoshcmlIAMHCX0NBrkhA24PoaCbnXmRHeMYJ8ovaAI2u/U3NQp
X-Gm-Gg: AYBFou09A8pvsdnyIxONGWPnZANARkwnqvVUAeDR7IHKxG+z1JayfX7OImJ/aoSnT2C
 3lGdHEQ+EbGmiU0xFUxSxEf77dftwQTBD59k30pU/HG4FfXo5Mk3Rs7wrdprxv+ojqBqX0LqwpJ
 WOoXz2zj85kwYfKGwVklysLDM1450Dd9cbLM2oal4hdT0797smcnmjoMkOWFxf68VGL48GlJov3
 EaIM4kWAjRQwaNDjN0wUkzbklK/aRv96Xir0moofe4giqK8PlDc3eSnzxU+0iLiwfeGrGCbRk1Z
 jLqXMHa5E2ojaD/ZjlAb6Dp5shVcTbPEmoqBxUSM81TbTswxRly0JNDR0sfd2bHsvDYjel6OgqE
 d31Rryz187NDBHg4CZV9HShaoB0rSin7sbBuQ2Ws2PQoGy3JJLFyCYkBF6ad35zLtijB1i01QlI
 VWEkRBYMbSd6EoyO6JCJEJbMf9vU8K8MclwVpqamhl9bqF3BBukS0RIxzr3d5VdPPKN0JNkYeun
 3ggNKJoAvL/Thx6OCNZ3fF62Vp0J+V9/D2UQ8iwtoRbWD8vhWgbF/RzM61YtRnXmVxVESZCxZOg
 8/swMELw56UtstpnxYCEMTTmCjLkMGjC34jkCesZddlKeM6EqHn+5hksi4wc5RsNGENBfokErtj
 fPVyg7081yH4kRQDChgIKhR7XLxReSZ4GigHWjhVf1ZgBhGMmsNZYzeVv5Nlb/APyQe1US3iiKF
 j2wNYVH9yc97k8ZncEvt3TJUIPIOWRnr3Y8NqY
X-Received: by 2002:a05:600c:6286:b0:4a1:7e77:c382 with SMTP id
 5b1f17b1804b1-4bb55a5d634mr193894255e9.5.1794817534033; 
 Mon, 16 Nov 2026 00:25:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb6f93b3e9sm73815205e9.1.2026.11.16.00.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 00:25:33 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 08:25:32 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d
X-Gerrit-Change-Number: 2126
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2126?usp=email>
X-Gerrit-Commit: 42b615c088c844180c4f5878ec7f0d6cd3e781fb
In-Reply-To: <gerrit.1793781037000.I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d@gerrit.openvpn.net>
References: <gerrit.1793781037000.I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzgxMDM3MDAwLkkwZjhlYTRmYTU3MmY4NGU2ZGNjOWIwODA2YzIzOTc3YzY0ZWE2NDVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a76dd57ca96e6cfc4247085dc8b1e8ccb72c7568-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSs20-000000006OE-3YYF
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7210034034394034533=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7210034034394034533==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NSUni7WK7OA="; charset=UTF-8

--NSUni7WK7OA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Gert Doering has sub=
mitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2126?usp=
=3Demail )

Change subject: pool: reuse handle-to-address helpers in ifconf=
ig_pool_acquire()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

pool: reuse handle-to-address helpers in ifconfig_pool_acquire()

ifco=
nfig_pool_acquire() duplicated the address calculation of
ifconfig_pool_han=
dle_to_ip_base() and
ifconfig_pool_handle_to_ipv6_base()=2E Use those inste=
ad, and add
in6_addr_low32() for the three open-coded conversions of the la=
st
32 bits of an IPv6 address=2E Its uint32_t casts also avoid shifting
an =
int into the sign bit=2E

Change-Id: I0f8ea4fa572f84e6dcc9b0806c23977c64ea6=
45d
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Antoni=
o Quartulli <antonio@mandelbit=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2126
Message-Id: <20261114221549=2E7019-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41340=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/pool=2Ec
1 file changed, 27 insertions(+), 2=
8 deletions(-)




diff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec=

index 016f3a8=2E=2Eeafd553 100644
--- a/src/openvpn/pool=2Ec
+++ b/src/ope=
nvpn/pool=2Ec
@@ -35,6 +35,20 @@
 
 #include "memdbg=2Eh"
 
+static in_addr=
_t ifconfig_pool_handle_to_ip_base(const struct ifconfig_pool *pool,
+     =
                                            ifconfig_pool_handle hand);
+
+=
static struct in6_addr ifconfig_pool_handle_to_ipv6_base(const struct ifcon=
fig_pool *pool,
+                                                         i=
fconfig_pool_handle hand);
+
+/* Return the last 32 bits of an IPv6 address=
 in host byte order */
+static inline uint32_t
+in6_addr_low32(const struct=
 in6_addr *a)
+{
+    return ((uint32_t)a->s6_addr[12] << 24) | ((uint32_t)=
a->s6_addr[13] << 16)
+           | ((uint32_t)a->s6_addr[14] << 8) | a->s6=
_addr[15];
+}
+
 static void
 ifconfig_pool_entry_free(struct ifconfig_pool=
_entry *ipe, bool hard)
 {
@@ -197,8 +211,7 @@
          * 4 bytes, therefo=
re we can just extract that and use it as base in
          * integer form
=
          */
-        uint32_t base =3D (ipv6_base=2Es6_addr[12] << 24) | (=
ipv6_base=2Es6_addr[13] << 16)
-                        | (ipv6_base=2Es6_a=
ddr[14] << 8) | ipv6_base=2Es6_addr[15];
+        uint32_t base =3D in6_add=
r_low32(&ipv6_base);
         /* some bits of the last 4 bytes may still be=
 part of the network
          * portion of the address, therefore we need =
to set them to 0
          */
@@ -319,33 +332,22 @@
 
         if (pool->ip=
v4=2Eenabled && local && remote)
         {
-            switch (pool->ipv4=
=2Etype)
+            const in_addr_t b =3D ifconfig_pool_handle_to_ip_base=
(pool, i);
+            if (pool->ipv4=2Etype =3D=3D IFCONFIG_POOL_30NET)
 =
            {
-                case IFCONFIG_POOL_30NET:
-                {=

-                    in_addr_t b =3D pool->ipv4=2Ebase + (i << 2);
-      =
              *local =3D b + 1;
-                    *remote =3D b + 2;
-  =
                  break;
-                }
-
-                case IFCONFI=
G_POOL_INDIV:
-                {
-                    in_addr_t b =3D pool-=
>ipv4=2Ebase + i;
-                    *local =3D 0;
-                    *=
remote =3D b;
-                    break;
-                }
-
-           =
     default:
-                    ASSERT(0);
+                *local =3D b=
 + 1;
+                *remote =3D b + 2;
+            }
+            else
=
+            {
+                *local =3D 0;
+                *remote =3D =
b;
             }
         }
 
-        /* IPv6 pools are always INDIV (--l=
inear) */
         if (pool->ipv6=2Eenabled && remote_ipv6)
         {
-   =
         *remote_ipv6 =3D add_in6_addr(pool->ipv6=2Ebase, i);
+            =
*remote_ipv6 =3D ifconfig_pool_handle_to_ipv6_base(pool, i);
         }
   =
  }
     return i;
@@ -420,11 +422,8 @@
         }
     }
 
-    base =3D (=
pool->ipv6=2Ebase=2Es6_addr[12] << 24) | (pool->ipv6=2Ebase=2Es6_addr[13] <=
< 16)
-           | (pool->ipv6=2Ebase=2Es6_addr[14] << 8) | pool->ipv6=2Eb=
ase=2Es6_addr[15];
-
-    addr =3D (in_addr->s6_addr[12] << 24) | (in_addr-=
>s6_addr[13] << 16) | (in_addr->s6_addr[14] << 8)
-           | in_addr->s6=
_addr[15];
+    base =3D in6_addr_low32(&pool->ipv6=2Ebase);
+    addr =3D =
in6_addr_low32(in_addr);
 
     ret =3D addr - base;
     if (ret < 0 || re=
t >=3D pool->size)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2126?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
0f8ea4fa572f84e6dcc9b0806c23977c64ea645d
Gerrit-Change-Number: 2126
Gerrit-=
PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--NSUni7WK7OA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gert Doering <strong>submitte=
d</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2126?usp=3Demail">View Change</a></p><div style=3D"white-space:p=
re-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">pool: reuse handle-to-address helpers in ifcon=
fig_pool_acquire()<br><br>ifconfig_pool_acquire() duplicated the address ca=
lculation of<br>ifconfig_pool_handle_to_ip_base() and<br>ifconfig_pool_hand=
le_to_ipv6_base()=2E Use those instead, and add<br>in6_addr_low32() for the=
 three open-coded conversions of the last<br>32 bits of an IPv6 address=2E =
Its uint32_t casts also avoid shifting<br>an int into the sign bit=2E<br><b=
r>Change-Id: I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d<br>Signed-off-by: Ra=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Antonio Quartulli =
&lt;antonio@mandelbit=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2126<br>Message-Id: &lt;20261114221549=2E7019-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg41340=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/pool=2Ec<br>1 file change=
d, 27 insertions(+), 28 deletions(-)<br><br></pre>
<pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/pool=2Ec b/src/openvpn/pool=2Ec</span><br><span>index 016f3a8=2E=2Eeafd=
553 100644</span><br><span>--- a/src/openvpn/pool=2Ec</span><br><span>+++ b=
/src/openvpn/pool=2Ec</span><br><span>@@ -35,6 +35,20 @@</span><br><span> <=
/span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static in_addr_t ifconfig_po=
ol_handle_to_ip_base(const struct ifconfig_pool *pool,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                        =
         ifconfig_pool_handle hand);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic struct in6_addr ifconfig_pool_handle_to_ipv6_base(const struct ifconfi=
g_pool *pool,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                                   ifconfig_pool_handle han=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* Return the last 32 bits of an IP=
v6 address in host byte order */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static inline uint32_t</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+in6_addr_low32(const struct in6_addr *a)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return ((uint32_t)a-&gt;s6_addr[12] &lt;&lt; 24) | (=
(uint32_t)a-&gt;s6_addr[13] &lt;&lt; 16)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+           | ((uint32_t)a-&gt;s6_addr[14] &lt;&lt; 8) =
| a-&gt;s6_addr[15];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 static void</span><br><span> ifconfig_pool_entry_free(struct ifconfig_pool=
_entry *ipe, bool hard)</span><br><span> {</span><br><span>@@ -197,8 +211,7=
 @@</span><br><span>          * 4 bytes, therefore we can just extract that=
 and use it as base in</span><br><span>          * integer form</span><br><=
span>          */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    uint32_t base =3D (ipv6_base=2Es6_addr[12] &lt;&lt; 24) | (ipv6_base=2E=
s6_addr[13] &lt;&lt; 16)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                        | (ipv6_base=2Es6_addr[14] &lt;&lt; 8) | ipv6_ba=
se=2Es6_addr[15];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      uint32_t base =3D in6_addr_low32(&amp;ipv6_base);</span><br><span>   =
      /* some bits of the last 4 bytes may still be part of the network</sp=
an><br><span>          * portion of the address, therefore we need to set t=
hem to 0</span><br><span>          */</span><br><span>@@ -319,33 +332,22 @@=
</span><br><span> </span><br><span>         if (pool-&gt;ipv4=2Eenabled &am=
p;&amp; local &amp;&amp; remote)</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            switch (pool-&gt;ipv4=2Et=
ype)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            con=
st in_addr_t b =3D ifconfig_pool_handle_to_ip_base(pool, i);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            if (pool-&gt;ipv4=2Ety=
pe =3D=3D IFCONFIG_POOL_30NET)</span><br><span>             {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                case IFCONFIG_POOL_=
30NET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 in_addr_t b =3D pool-&gt;ipv4=2Ebase + (i &lt;&lt; 2);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    *local =3D b + 1;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    *remo=
te =3D b + 2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                case IFCONFI=
G_POOL_INDIV:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        in_addr_t b =3D pool-&gt;ipv4=2Ebase + i;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    *local =3D 0;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    *remote =3D b;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    br=
eak;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                default:</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    ASSERT(0);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                *local =3D b=
 + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  *remote =3D b + 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  *local =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            *remote =3D b;</span><br><span>             }</span><br><span> =
        }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        /* IPv6 pools are always INDIV (--linear) */</span><br><span>=
         if (pool-&gt;ipv6=2Eenabled &amp;&amp; remote_ipv6)</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   *remote_ipv6 =3D add_in6_addr(pool-&gt;ipv6=2Ebase, i);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            *remote_ipv6 =3D ifconfi=
g_pool_handle_to_ipv6_base(pool, i);</span><br><span>         }</span><br><=
span>     }</span><br><span>     return i;</span><br><span>@@ -420,11 +422,=
8 @@</span><br><span>         }</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    base =3D (pool-&gt;i=
pv6=2Ebase=2Es6_addr[12] &lt;&lt; 24) | (pool-&gt;ipv6=2Ebase=2Es6_addr[13]=
 &lt;&lt; 16)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
   | (pool-&gt;ipv6=2Ebase=2Es6_addr[14] &lt;&lt; 8) | pool-&gt;ipv6=2Ebase=
=2Es6_addr[15];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    addr =3D (in_addr-&gt;s=
6_addr[12] &lt;&lt; 24) | (in_addr-&gt;s6_addr[13] &lt;&lt; 16) | (in_addr-=
&gt;s6_addr[14] &lt;&lt; 8)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-           | in_addr-&gt;s6_addr[15];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    base =3D in6_addr_low32(&amp;pool-&gt;ipv6=2Eba=
se);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    addr =3D in=
6_addr_low32(in_addr);</span><br><span> </span><br><span>     ret =3D addr =
- base;</span><br><span>     if (ret &lt; 0 || ret &gt;=3D pool-&gt;size)</=
span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2126?usp=3Demail">change 2126</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2126?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: I0f8ea4fa572f84e6dcc9b0806c23977c64e=
a645d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2126 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;=
antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></h=
tml>
--NSUni7WK7OA=--


--===============7210034034394034533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7210034034394034533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7210034034394034533==--

