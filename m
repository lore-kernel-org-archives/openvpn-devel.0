Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D438CC5B572
	for <openvpn-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=83aygH1xgETSgULGtqaJ5Zc1ZLDRbKyuZqOsYuroBxs=; b=mh/O7S/RnsjrNL
	5MJuFCEboBCB5MEOzbKBQFZa3w988TZK7bOjRYiN4V9MkbafBaAjY4L7aIXhby1oom2+d8bmp6n2p
	dHF0g/pqYGwHsSHCPDciMRTN19nBR4/5KmuxtK1coyi/bAqVVdq/lVs1i8MTOSF6jLcVp2fLqOB2f
	LIw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wu8tc-0007ri-JV;
	Wed, 12 Aug 2026 13:21:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wu8tZ-0007rQ-UX
 for openvpn-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 13:21:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UiBRKIk8df/ZXuciRJAdc4e7RI3s49unutwNGFLTHWE=; b=Xaf31mmxJAKsiyw+N93m9LtMZS
 nIXu6cSUGKa1yeaWiakvZ7JSOrZU9OX1fvvrgibwU7u7Uic2hCBMxZYYKzczmqik3o5iic6W59ajz
 O/71Yct1VlhdRmTLHwUQiBfPJfNi2uO1yXukJX74htvNV7Ta2wVEcA8UbiK9Ouw9hiqE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UiBRKIk8df/ZXuciRJAdc4e7RI3s49unutwNGFLTHWE=; b=E
 XfB2tQrUnOxaJ7lUHRFcxvY9P+HZuLYuOPteGOBTDTSqE2CYuA8GW3X8xVlS2X5g1iKeFek3oxtoJ
 ReaFGs32CBvpS13+4R3IeFdWttXcdnHmHl2y45NyKdWE3L4O2oHiTSRyuwMfOEkbbxiJsomDraU8g
 0x6s+B0+Q1qjP+bc=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wu8tX-0006LR-Le for openvpn-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 13:21:26 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47362928f65so733292f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 12 Aug 2026 06:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786540877; x=1787145677; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UiBRKIk8df/ZXuciRJAdc4e7RI3s49unutwNGFLTHWE=;
 b=VLHlORPL5IRyDL+RrVzSsFQTdK9VAwkzy0BdCABMqVf3GJA5gZzphpRo5XdeYnR2HZ
 hxCLLWLpigxNnc+NI4CcBVztVp7+CBfpkSyo7aaXVytQbOz5jdaz/eM3RrtndR59CaeF
 FijBZOCnBTsS44hdRxlXTOAqP/dkH7wIz5GZbLvwBMyx8kQpgNWVA79bX8PB5HrUv3oh
 fWDCQFkS+X59LBZiiSwEp8eRZvUPBNP0hJsnb9AwnfBmO14Xx5zp92G5T12aRA4Uqd+K
 Pv4h5U32eN6HPCoa7AHkstadKmEHF+T6aR6d+SNeRPFBlWmuYPXJtmSXmXs22LQ8tPlY
 drVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786540877; x=1787145677;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UiBRKIk8df/ZXuciRJAdc4e7RI3s49unutwNGFLTHWE=;
 b=CXRhzo0KZ8UA3oX/62zg7WobQCnnrtGtHXl7UCggvsF+UmRF+0QGoCdkSOqHN1YKOg
 pmlbgdnO8n8DGYYCCrq4vSHuFigVjcq2BHSIONDtir8REA/rkp/WMrMlKj2TsMyPskXI
 V65dk6jlJGggUQt5yMJ92+kksid04wUEBX+Gs4zKq+VtM1efGrbypyg8RiBlO9PqoJGg
 1OMOcikrdubkwNiSsOxtkiOyBaK39sDhuO51g02IpgRZukFfWkNVl2P7MoroZigciURF
 zij/yOzmiTVEXMH0ARsBx5+wxcuRMMse+J23Q/3HhA4Ft4jDs3cdqe2QnYZMRGEIo36q
 xodw==
X-Gm-Message-State: AOJu0Yza2aKE1Z+X0KhherpG6poe/aNaBNTxeiRbw1TJHfBw4ck5WAF1
 GK8S6iFdcI3lr7/VXqRarf2PFsUaMylYLnqjZlZSRmjl8TbKSEEAHhhi5DB9DAgSyJAvCmYo+hQ
 VQ8TPBjCYg1tC80WnABOSOSx86jlDVn2FOAjENfAOBiH1bCbVUb+PceWH3SVJwWk3dJoSNK/hnu
 rPuJ84Zg==
X-Gm-Gg: AR+sD12xjW5ZoTQQhK0P7otMfHfRln5C1vEt6HEYQuDtBwekJNjmEZ9+atVuGddirpV
 tIY03JEucrALnDYcprm/tvkYUCN4SNc1vZzWkaw+nOH5szIn2ypn491L2vta5WVh+ibfD4q7GLj
 ++rBDSNtQFKJpuGMrLPX3HT1HtSvMxty03Do/Yubm3sUIQ5BB7VSTAtX+bHP/fAe55YHLWPw/oH
 pmxPysH0B6ik8VLhHeuzEbwyXDHMVyfo7oJ8MEcveilWQvVrxMNlQyh3/XN3qlaKprJFv9HK4TG
 R2c9t2ylm7YENfQpsqi+kj+TwacfhosqHPTk1EarKOtByK/2zFETPqchw640fX9jG0c2kXsaMAW
 Sf33JcEvV/mKvPJkhQ9Ra4/eaio0VgOfSWOnQRlqTqycPQMP09VGyOMHSfw9ShdlKUX3Gge29CR
 Fmrj86EKe9auBN3wSBWLZHWWzpgOIP4cYjnT9LdCy4fYbG3eJ2UUZ9gW4DwIwzN46OVvTriXCw0
 5ul8pq9HPrDSH1ks+UOaUr+LPwPxH3GkmMp/ZIFxcogyL6NseV50laWoBhKRToq572sdFX1x9dB
 aD1wj+TAzVJQPNwo9GhIyMBRTLm2JZ3lSLwLaOiVdYxfGdW0TmE=
X-Received: by 2002:adf:e195:0:b0:481:4761:45dc with SMTP id
 ffacd0b85a97d-481528c54femr6967952f8f.13.1786540872996; 
 Wed, 12 Aug 2026 06:21:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5eddbsm7887489f8f.31.2026.08.12.06.21.11
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 06:21:11 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 12 Aug 2026 13:21:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia2e238a41526ebc178c53d3807103d8b9da475a5
X-Gerrit-Change-Number: 1842
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1842?usp=email>
X-Gerrit-Commit: 015412bf44b22f47440a25a6645360af10659a12
References: <gerrit.1786540865000.Ia2e238a41526ebc178c53d3807103d8b9da475a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NTQwODY1MDAwLklhMmUyMzhhNDE1MjZlYmMxNzhjNTNkMzgwNzEwM2Q4YjlkYTQ3NWE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e019aa67162bf59bf2e792a4dab8f3bf7eaa2b72-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wu8tX-0006LR-Le
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix extracting
 IV_MTU
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6445939375486831582=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6445939375486831582==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dANTGd3jAYg="; charset=UTF-8

--dANTGd3jAYg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1842?usp=3Demail )


Change subject: Fix extracting IV_M=
TU
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix extrac=
ting IV_MTU

Commit 06ced3fd accidentally broke extracting the MTU from the=
 peer
info while refactoring the code=2E Before 06ced3fd the code used
iv_m=
tu as temporary string and extracted the value into client_max_mtu=2E
The n=
ew code never set client_max_mtu and used iv_mtu as integer instead=2E

Fix=
 this by setting client_max_mtu again with the real MTU value from
the peer=
=2E

Change-Id: Ia2e238a41526ebc178c53d3807103d8b9da475a5
Signed-off-by: Ar=
ne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/push=2Ec
1 file changed, =
2 insertions(+), 3 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/42/1842/1

diff --git a/src/openvpn/push=2Ec b/s=
rc/openvpn/push=2Ec
index ce2baf2=2E=2E357b25f 100644
--- a/src/openvpn/pus=
h=2Ec
+++ b/src/openvpn/push=2Ec
@@ -717,10 +717,9 @@
     }
 
     /* Push=
 our mtu to the peer if it supports pushable MTUs */
-    int client_max_mt=
u =3D 0;
-    unsigned int iv_mtu =3D peer_info_extract_uint(tls_multi->pee=
r_info, "IV_MTU=3D");
+    int client_max_mtu =3D peer_info_extract_uint(tl=
s_multi->peer_info, "IV_MTU=3D");
 
-    if (iv_mtu !=3D 0)
+    if (client=
_max_mtu !=3D 0)
     {
         push_option_fmt(gc, push_list, M_USAGE, "t=
un-mtu %d", o->ce=2Etun_mtu);
         if (client_max_mtu < o->ce=2Etun_mtu=
)

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1842?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia2e238a41526ebc1=
78c53d3807103d8b9da475a5
Gerrit-Change-Number: 1842
Gerrit-PatchSet: 1
Gerr=
it-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>

--dANTGd3jAYg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1842?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Fix extracting IV_MTU<br><br>Commit 06ced3fd accidentally broke ex=
tracting the MTU from the peer<br>info while refactoring the code=2E Before=
 06ced3fd the code used<br>iv_mtu as temporary string and extracted the val=
ue into client_max_mtu=2E<br>The new code never set client_max_mtu and used=
 iv_mtu as integer instead=2E<br><br>Fix this by setting client_max_mtu aga=
in with the real MTU value from<br>the peer=2E<br><br>Change-Id: Ia2e238a41=
526ebc178c53d3807103d8b9da475a5<br>Signed-off-by: Arne Schwabe &lt;arne@rfc=
2549=2Eorg&gt;<br>---<br>M src/openvpn/push=2Ec<br>1 file changed, 2 insert=
ions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/42/1842/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index ce2baf2=2E=
=2E357b25f 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><spa=
n>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -717,10 +717,9 @@</span><br=
><span>     }</span><br><span> </span><br><span>     /* Push our mtu to the=
 peer if it supports pushable MTUs */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    int client_max_mtu =3D 0;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    unsigned int iv_mtu =3D peer_info_extract_uint(=
tls_multi-&gt;peer_info, &quot;IV_MTU=3D&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int client_max_mtu =3D peer_info_extract_u=
int(tls_multi-&gt;peer_info, &quot;IV_MTU=3D&quot;);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (iv_mtu !=3D 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (client_max_mtu =
!=3D 0)</span><br><span>     {</span><br><span>         push_option_fmt(gc,=
 push_list, M_USAGE, &quot;tun-mtu %d&quot;, o-&gt;ce=2Etun_mtu);</span><br=
><span>         if (client_max_mtu &lt; o-&gt;ce=2Etun_mtu)</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1842?usp=3Demail">change 1842</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1842?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: Ia2e238a41526ebc178c53d3807103d8b=
9da475a5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1842 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--dANTGd3jAYg=--


--===============6445939375486831582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6445939375486831582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6445939375486831582==--

