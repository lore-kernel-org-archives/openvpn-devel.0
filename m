Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE45C55ABF
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 12:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AUitocuJe0y5yRYA5wd/OCTircRCsFS9TyAEX6Gcfvk=; b=bg0E03491Ooq4yl7ntSWlI6cm+
	+W80sxQKZ11htd7Tfu79l4dsExAQgMtVt9Yhzon3GxQ3eOt9dF8VEJRDAcZh3gHoWs1vKTeEBVaiC
	f79G/EJHzw7tcKBlXSXb3WUs6h+ljX6T3OAnY8ND/f7LPntpjWcZSpG1wHo2tYknFqlk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrwuH-0004Xm-6v;
	Thu, 06 Aug 2026 12:09:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrwuG-0004XL-DW
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 12:09:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fIKl8CZHqc/3HCTxa3jn9dzipn0MsVpnpEkOvQeOKOo=; b=fZmU4ojd1SBQpyPl70njZDlOj/
 kjte1pamLNFC+bTXxWXZe2NtdEp8wZyhZFS0ZZ6KBM1ETQ5PR2P8sX6diPjBa6QP9dfhfPejk2THO
 XwoOCdQ7x973Q+o+/QWRtj5zl2iURqJgoVUGtKYeAYOQIeBVtlPetiCAPGCwKqVKpvcg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fIKl8CZHqc/3HCTxa3jn9dzipn0MsVpnpEkOvQeOKOo=; b=P
 rDcEBlf4WNwES8xHyaJ0RmYtPFdiDWwpPIkaT5hF1KjFgfr6Vz3pn+YpCBA6wqrAjbWPNFrZr8Atx
 YUiJgP/dVNuHrX5YnikcKNS4DUrk+qN/DDc3zAI861wfzcjQYb2UN+zOiEMFtJOVaey0XQRsC6a8r
 H3FmyYmk6yjiX3ro=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrwuG-0003Zw-1K for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 12:09:01 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so1798431f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 05:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786018134; x=1786622934; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fIKl8CZHqc/3HCTxa3jn9dzipn0MsVpnpEkOvQeOKOo=;
 b=D5syHEs7qnLqJdmBc4ps0O0PFKv1Q0WzVqpKT3s653+jS4mNEnq1RGJ2v/xcwap91e
 NGkXfAxEMq0aZvjCHd5R1G0G1HiMRjSHlPbJ3J/IdkHpliKNVzhTFhXBOBLScaDZ4jlA
 1M4xfOdmMqWiCq64iu7q7i79MK+utJ0SNQq0cjrDN9S8fk4aoRoXY8HHRL517S4z3SoW
 wAzh2ANj6+CZjBUbcmHGq7W5JO5wCSN8BpVAyUJePzC5rQ8nMfnnrmy8MfWANhLWN5jP
 QNLwfFjfqUs2PUgSisp3gNepzqVIr2/Q4rrDEeP1xrW3IWCUyCLCnYOZJrbZa9WOwUIR
 PDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786018134; x=1786622934;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fIKl8CZHqc/3HCTxa3jn9dzipn0MsVpnpEkOvQeOKOo=;
 b=hzGSAfuHhDzEKb0kppICeKS0MnXuIygvWJHT2yZIHSgjmXXXbQx0AD2d3TBkwli6gi
 UTObrW+f4dZpCsQack01/Fhfv9de+rbMW0cgCpfeIHdGbHpW4Atd9PKf4vne7bfSqunQ
 TqZ3alL8fpoO0QTlgd5Mfb/Ha45Feo/8R3kjLX7dSNeoT4cZr5knNwWuo+CnZWRjlnVC
 OIn35ZDcWLKhkFxa1vrIE9TloLbKIeD8uB9qdoCbM9EdWlnJ/0iNHCRmuN2pFSijT+lA
 5MMxrHn2poIc0K1sKpOtMEeXDir15D18cbxXCimGdJZdEprUrEbHisyyxU5+ZjUp4B1f
 Mqpg==
X-Gm-Message-State: AOJu0Yx1vBMKAcEqUb6Gp59+JHX+kWQoUcXzpkff2t+42r4TjcICZ6TB
 +Id2S8h9gCm7awkXGTk2l49GzerTowZtiFe4kQn4IDifO1USCtpkZl9LfOxdrsRsMWYh6STxxIv
 NEau4c0itd4TPv0kKjkFJwJTLbbEhEurEskGFCUcf9Fz82sg/NGuDjVeMLzt5uG9+HhH+IJb+F0
 Ynzan4qg==
X-Gm-Gg: AR+sD114tgRENU5dLyLvIEq6koteM+gLTLA+leurpRHUfRWKq1TONgAAOJutow9NyL7
 KuuXzLfofimsjGnQAXmh4TWvUFEZhh1M85xgUHayMD/EG6bpgVl6P0W1dtXN3OTm+bXMN4ju+zT
 AL5IPZuuV/zFtYkMi0POQyz1H5cJwselhTrqBt73ALWbPzaRqoYPch4t6xv5uBZ52cmPSXgP6h7
 ukSpzQjcKXc6Yes0pgaT1JnoSuTbYOlhI4hZwT+QvLrDGJwRSkb5u7mu5cJRhduny2XY7P4ouho
 omXPb6jVwtFkHlYOMt4N3qf6xiKV6eizvh5IYsvH6+U9K1izWTalkh/dj6My6t8JW40cI96+HtC
 5kJEfhgTfR5arAyHdUCzt82aZ7rsu8jSZ2qfCFdjYha5TaTpuNT95OKEUX6LmymgmcB0tzN0z1a
 UyVsyMd8bKnGIjZ7s+CKd59WWLPUBmufENtmwRTJDt641clpambGY8tkwixkcwt4svopoksZf2L
 tYMzwg280hIHyPUbaVryLLBz/t8PIiYd8ITAfTkORTcD01lzF/rbFd4Co50xAyOpOVJZNCiPufx
 LwDEUrIno8i1rFCdoXOiU4MefIj011voTWpjtSWQ0kULVmEWuTQ=
X-Received: by 2002:a05:6000:4714:b0:47d:eedb:ee62 with SMTP id
 ffacd0b85a97d-47fec62d861mr23851560f8f.14.1786017667628; 
 Thu, 06 Aug 2026 05:01:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff79b496esm6240482f8f.14.2026.08.06.05.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 05:01:07 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 12:01:06 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1a6a0ca8beba3214b21047755246ceeb30141c2a
X-Gerrit-Change-Number: 1839
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1839?usp=email>
X-Gerrit-Commit: 6f6d02e72343e04c0b473d8dd7a762498ef37d84
In-Reply-To: <gerrit.1786014571000.I1a6a0ca8beba3214b21047755246ceeb30141c2a@gerrit.openvpn.net>
References: <gerrit.1786014571000.I1a6a0ca8beba3214b21047755246ceeb30141c2a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2MDE0NTcxMDAwLkkxYTZhMGNhOGJlYmEzMjE0YjIxMDQ3NzU1MjQ2Y2VlYjMwMTQxYzJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <892b4311ed9dde8f340d12574ee83e7beb52358a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrwuG-0003Zw-1K
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: Make test_misc
 compile with -Werror again.
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8256715267423919580=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8256715267423919580==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NqoucAR6Vvg="; charset=UTF-8

--NqoucAR6Vvg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1839?usp=3Demail )

Change subject: Make test_misc compile with -Werror=
 again=2E
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

M=
ake test_misc compile with -Werror again=2E

Commit 5978a46e3 (master)/3402=
f9aa0 (release/2=2E7) removed the
local prototype/function get_random in te=
st_misc and use the
global prototype in crypto=2Eh=2E

This made get_random=
 return uint64_t instead of uint32_t=2E
Adjust the calls in test_list accor=
dingly=2E

On master the general hash rewrite/cleanup completely
removes th=
e iv argument from hash_init and therefore
only 2=2E7 requires this patch=
=2E

Change-Id: I1a6a0ca8beba3214b21047755246ceeb30141c2a
Signed-off-by: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Acked-by: Gert Doering <gert@greeni=
e=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1839
M=
essage-Id: <20260806111323=2E32150-1-gert@greenie=2Emuc=2Ede>
URL: https://=
www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38167=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/u=
nit_tests/openvpn/test_misc=2Ec
1 file changed, 2 insertions(+), 2 deletion=
s(-)




diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_t=
ests/openvpn/test_misc=2Ec
index b9e2db0=2E=2Ea9c3845 100644
--- a/tests/un=
it_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec=

@@ -170,8 +170,8 @@
      */
 
     struct gc_arena gc =3D gc_new();
-    =
struct hash *hash =3D hash_init(10000, get_random(), word_hash_function, wo=
rd_compare_function);
-    struct hash *nhash =3D hash_init(256, get_random=
(), word_hash_function, word_compare_function);
+    struct hash *hash =3D =
hash_init(10000, (uint32_t)get_random(), word_hash_function, word_compare_f=
unction);
+    struct hash *nhash =3D hash_init(256, (uint32_t)get_random()=
, word_hash_function, word_compare_function);
 
     printf("hash_init n_bu=
ckets=3D%u mask=3D0x%08x\n", hash->n_buckets, hash->mask);
 

-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1839?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
G=
errit-Branch: release/2=2E7
Gerrit-Change-Id: I1a6a0ca8beba3214b21047755246=
ceeb30141c2a
Gerrit-Change-Number: 1839
Gerrit-PatchSet: 2
Gerrit-Owner: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=
=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>

--NqoucAR6Vvg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1839?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Make test_misc compile with -Werror again=
=2E<br><br>Commit 5978a46e3 (master)/3402f9aa0 (release/2=2E7) removed the<=
br>local prototype/function get_random in test_misc and use the<br>global p=
rototype in crypto=2Eh=2E<br><br>This made get_random return uint64_t inste=
ad of uint32_t=2E<br>Adjust the calls in test_list accordingly=2E<br><br>On=
 master the general hash rewrite/cleanup completely<br>removes the iv argum=
ent from hash_init and therefore<br>only 2=2E7 requires this patch=2E<br><b=
r>Change-Id: I1a6a0ca8beba3214b21047755246ceeb30141c2a<br>Signed-off-by: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Acked-by: Gert Doering &lt=
;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1839<br>Message-Id: &lt;20260806111323=2E32150-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg38167=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/unit_tests/openvpn/test_misc=2E=
c<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre>
<pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/t=
est_misc=2Ec</span><br><span>index b9e2db0=2E=2Ea9c3845 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/test=
s/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -170,8 +170,8 @@</spa=
n><br><span>      */</span><br><span> </span><br><span>     struct gc_arena=
 gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
struct hash *hash =3D hash_init(10000, get_random(), word_hash_function, wo=
rd_compare_function);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    struct hash *nhash =3D hash_init(256, get_random(), word_hash_function,=
 word_compare_function);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct hash *hash =3D hash_init(10000, (uint32_t)get_random(), wor=
d_hash_function, word_compare_function);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct hash *nhash =3D hash_init(256, (uint32_t)ge=
t_random(), word_hash_function, word_compare_function);</span><br><span> </=
span><br><span>     printf(&quot;hash_init n_buckets=3D%u mask=3D0x%08x\n&q=
uot;, hash-&gt;n_buckets, hash-&gt;mask);</span><br><span> </span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1839?usp=3Demail">change 1839</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1839?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: release/2=2E7 </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I1a6a0ca8beba3214b21047755246=
ceeb30141c2a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1839=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--NqoucAR6Vvg=--


--===============8256715267423919580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8256715267423919580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8256715267423919580==--

