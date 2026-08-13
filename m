Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49A2C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U/ptF4UXVT9TT5U8GOvnvq9j9Q0Cm9Rf1GFzzYzIu74=; b=SMCwbm6nBrJckvsZzcy+iBQiRI
	oD+GZ6OP0j7FvcDOrf5nN0seXGuOAoh0HfzPCtBKv+LepbqJa5+ZklxAI1gl2VjB5zYd/S2L6h1m9
	kmGQ6mQNWxnyA4UWspt9oleTi1xRM+oVVEZjpLwpKjtfPXEGxXJ3TSaFB1Rxc5PSIAkM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuWYn-0004ac-Cx;
	Thu, 13 Aug 2026 14:37:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuWYm-0004aQ-BC
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 14:37:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Yi7cVSu71J/lGHg4jR2DmzU0wx/dJgf64BbIChH2KSw=; b=RK0jv0GzBOp/cqgO5m55MbLyJv
 5wZNGDbvrySX/Viq2Up9XAKU+gT1DULZK0wPrHkZlBF9OD6UJmbL/W6nTdNjTpkZVYgjnjP4GPoiD
 6hfvLC9vlzt63udtnoEJyeOsOrqM03gbzg0xifiDtbXlfHWiZ3o+dcJvhvNTgjoD5sN8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Yi7cVSu71J/lGHg4jR2DmzU0wx/dJgf64BbIChH2KSw=; b=Y
 WzNwql+Gi8bOu8fygfqz4YoY6P4oD+8UOBh6/nIRtlswDKDUKtU0Z3Wym745XVj4ENHeImIULQUVQ
 VUoo4HWb6XCmO6LJjvwhs8G3OeCIPPNEj8pOiq9DoV1fGBJyNXC/5u0tyXYajW0M7PP9ivaakbk/H
 VO7aSMPEIOPJi2+o=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuWYh-0000yx-3P for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 14:37:29 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4815bce4652so442663f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 07:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786631840; x=1787236640; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Yi7cVSu71J/lGHg4jR2DmzU0wx/dJgf64BbIChH2KSw=;
 b=dt5mRXkT85xVXW9cQ0P15iXLHSD4QPveWmUOxN1jtc+LIe9cjzJ3mpDuhaDNN9YI/G
 AVtzYDT9NvP+NEwLhFjjkn2JAcK1JyOKFQq6TPYXyNTe2gUSKDiOwm4c8Ro46BscQxi+
 YCT6KQVehRuIa0U7MQEtN5IPnJIlheZb8TBbUmp70omSVtUwmfWo4vEqqJ3KhXj4BJIf
 w93hCko3feB1yUDhUHSFM27Bk+xen/vGW2N7uuehWTOHa7c561CxyTU+te3U26uwqxBq
 xRA/m3OVdfRdpgKxBWwcsaKihoN4l8czuuVQfL+CkebDFd00uTeunSjmUBan+pjp/m3d
 kEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786631840; x=1787236640;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Yi7cVSu71J/lGHg4jR2DmzU0wx/dJgf64BbIChH2KSw=;
 b=Aqv5kPiQ5lK8WDS2oiz6mEYjC0q9Z8YHo9aYcHb840Ct2t6XxRnFvmAc2/DM0X0Urj
 y13wseZaVLAlIbAHSHTb4Zr57g7nZsllfSomgTWkIft9Qgb5DOE+ivUXMqL+QUeJjEU2
 7T8wMtW44JjUy8B5xaoSbaB9JbgZG83DVtFGsoUtGlOCcs/Ln2XUUZ0gkkhBExo39gGE
 T06Mx4fyT+EqEW8LlrbLrMPFT1A9Zg3dDIFBlziWLdnNhIG2zAbsCC7NY1TGY4kfFkfw
 ZjjhnfNsyIg6E5SFV1gD7ff+/eB+Tp496W+kKO2l83nChKkTAdQe0+M7Eqx8McJt2M1c
 /WnQ==
X-Gm-Message-State: AOJu0YwriXR9SsGYqz1flfef8qnSMKnaithWCkJVIwzSJJchEtuD44Ny
 8FVZz+21FLtHYEpbOmATKISp5U2R4WANBbRm4F5j+1E0BXTtVB0t5PUx4sY2PHUO/cWIxGBv6Bm
 mANGI2h3CRDNHF7cGMtWyzGBKFilp1lo4tvxBCDy5omXzi7nDRCxjeLQJ7GIVgXN8w422
X-Gm-Gg: AR+sD11o0i3KYQ1Q9QpWDTogY91MXS6v9pj9AkkekLkhpoXZo4+/rJkwmNAi9m/xAQF
 WDdNyOEPXYP2xuI0IrZzqsYsq0fLbiXx1H1HRduTyRHyLmkrsHENjs7Fy8S4wvYsPjZCCxQAod7
 Rp5+pC52I7vrM8uVLqBwZu1bpwLP+ONtyL4WFoW8Vc/z68yStsP7SXJtDWdFgbv2Trw9MVcvnc9
 0jaTkglp07qTvtl/Eb+UfKmRU6e4gAqvGSZGKLTAI+Wg0gdhXhdWhXz8V/lfhII1I+zRhqQCNfN
 U0Taf5JHuNB58mrRBRPCijA6eMYd/SqjB1Rq1pcgWrPRkXw1KJ1lKN32U1HAW6Sc8+VLNIV3j2w
 AF4h0qe54UQq+jr/9v+mrh7H0XIcns2SIl1rJu80gKwzti1qYDdQ/CDHpu04uGmA7HZdwpDm0DP
 dpilF392a4G56qavCzBTQqGdhMOxE0MNjRoAq/ZqgT9JXN8QXeWLqn4nOSv/BdzfOHvEwC1+Te5
 5J62Jx1Wd3iNukwBk+8c2I6vDu3gvvp4WWwa2jOtQMicV0lvPzQB/yeVa0wL+/p1714hlz+9HGt
 jvFEEbBtF7J8voxCdNzJf+JKWKvfSXE9YvEa0XOq5j6EfrQejEw=
X-Received: by 2002:a05:6000:29cf:b0:481:5829:3f28 with SMTP id
 ffacd0b85a97d-48159ed6b41mr6980428f8f.5.1786631840381; 
 Thu, 13 Aug 2026 07:37:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a569314sm7530144f8f.16.2026.08.13.07.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 07:37:20 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 14:37:19 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia2e238a41526ebc178c53d3807103d8b9da475a5
X-Gerrit-Change-Number: 1842
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1842?usp=email>
X-Gerrit-Commit: 800ba2cfccf2173c466f9b57381bb6244110117f
In-Reply-To: <gerrit.1786540865000.Ia2e238a41526ebc178c53d3807103d8b9da475a5@gerrit.openvpn.net>
References: <gerrit.1786540865000.Ia2e238a41526ebc178c53d3807103d8b9da475a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NTQwODY1MDAwLklhMmUyMzhhNDE1MjZlYmMxNzhjNTNkMzgwNzEwM2Q4YjlkYTQ3NWE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0b9ee18c4420a211a924d4052d980433aaf7ad6f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuWYh-0000yx-3P
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1656505222510860469=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1656505222510860469==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WjUf0S16F2g="; charset=UTF-8

--WjUf0S16F2g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1842?usp=3Demail )

Change subject: Fix extracting IV_MTU
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix extracting IV_MTU

Co=
mmit 06ced3fd accidentally broke extracting the MTU from the peer
info whil=
e refactoring the code=2E Before 06ced3fd the code used
iv_mtu as temporary=
 string and extracted the value into client_max_mtu=2E
The new code never s=
et client_max_mtu and used iv_mtu as integer instead=2E

Fix this by settin=
g client_max_mtu again with the real MTU value from
the peer=2E

Change-Id:=
 Ia2e238a41526ebc178c53d3807103d8b9da475a5
Signed-off-by: Arne Schwabe <arn=
e@rfc2549=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1842
Message-Id: <20260813055=
836=2E32422-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg38291=2Ehtml
Signed-off-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/push=2Ec
1 file chan=
ged, 2 insertions(+), 3 deletions(-)




diff --git a/src/openvpn/push=2Ec =
b/src/openvpn/push=2Ec
index 97f352e=2E=2E5b15f71 100644
--- a/src/openvpn/=
push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -717,10 +717,9 @@
     }
 
     /* P=
ush our mtu to the peer if it supports pushable MTUs */
-    int client_max=
_mtu =3D 0;
-    unsigned int iv_mtu =3D peer_info_extract_uint(tls_multi->=
peer_info, "IV_MTU=3D");
+    int client_max_mtu =3D peer_info_extract_uint=
(tls_multi->peer_info, "IV_MTU=3D");
 
-    if (iv_mtu !=3D 0)
+    if (cli=
ent_max_mtu !=3D 0)
     {
         push_option_fmt(gc, push_list, M_USAGE,=
 "tun-mtu %d", o->ce=2Etun_mtu);
         if (client_max_mtu < o->ce=2Etun_=
mtu)

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1842?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia2e238a41526ebc1=
78c53d3807103d8b9da475a5
Gerrit-Change-Number: 1842
Gerrit-PatchSet: 2
Gerr=
it-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <ge=
rt@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>

--WjUf0S16F2g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1842?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Fix extracting IV_MTU<br><br>Commit 06ced3=
fd accidentally broke extracting the MTU from the peer<br>info while refact=
oring the code=2E Before 06ced3fd the code used<br>iv_mtu as temporary stri=
ng and extracted the value into client_max_mtu=2E<br>The new code never set=
 client_max_mtu and used iv_mtu as integer instead=2E<br><br>Fix this by se=
tting client_max_mtu again with the real MTU value from<br>the peer=2E<br><=
br>Change-Id: Ia2e238a41526ebc178c53d3807103d8b9da475a5<br>Signed-off-by: A=
rne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1842<br>Message-Id: &lt;20260813055836=2E32422-1-gert@greenie=2Emuc=2E=
de&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourc=
eforge=2Enet/msg38291=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/push=2Ec<br>1 file changed, 2 inse=
rtions(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/push=2E=
c b/src/openvpn/push=2Ec</span><br><span>index 97f352e=2E=2E5b15f71 100644<=
/span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvp=
n/push=2Ec</span><br><span>@@ -717,10 +717,9 @@</span><br><span>     }</spa=
n><br><span> </span><br><span>     /* Push our mtu to the peer if it suppor=
ts pushable MTUs */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int client_max_mtu =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    unsigned int iv_mtu =3D peer_info_extract_uint(tls_multi-&gt;peer=
_info, &quot;IV_MTU=3D&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int client_max_mtu =3D peer_info_extract_uint(tls_multi-&gt;=
peer_info, &quot;IV_MTU=3D&quot;);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (iv_mtu !=3D 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (client_max_mtu !=3D 0)</span><br=
><span>     {</span><br><span>         push_option_fmt(gc, push_list, M_USA=
GE, &quot;tun-mtu %d&quot;, o-&gt;ce=2Etun_mtu);</span><br><span>         i=
f (client_max_mtu &lt; o-&gt;ce=2Etun_mtu)</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/184=
2?usp=3Demail">change 1842</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1842?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ia2e238a41526ebc178c53d3807103d8b9da475a5 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1842 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--WjUf0S16F2g=--


--===============1656505222510860469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1656505222510860469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1656505222510860469==--

