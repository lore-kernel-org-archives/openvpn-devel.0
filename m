Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCED2C98311
	for <openvpn-devel@archiver.kernel.org>; Thu, 24 Sep 2026 01:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=WQSLP+r3I/A8AnZysdo0ieG0SKTph6+ysGue4qljY4c=; b=HWsR/DWuMQJxAo
	N7kbQiZt+L+4wDU8ip8S696x7E9dZOfGAvJaASicG9DGWZWVgybcZ0fzIfDwpW2zZ7d4trKTMXsNF
	7gtB5Zzxpg8E4/ySe2deldH7sr/asYP2zICDbMpXyqAhG5rf6koUPi9WZ6yR4VhBdc7YuLZaa+XQC
	NKc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9Xyw-0002Qf-4Q;
	Thu, 24 Sep 2026 01:10:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9Xyu-0002QR-2l
 for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 01:10:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pvzYYk6xyQXigZKjYAqe/eLDiGPxiT7KjKuMvZ0K2v8=; b=UYSx6r9EZiBvfLqu9vqEIuKY/0
 eDJz1Td1daBCMdVTsBrVgS8J7r6qz7mT/4qNWWdJNlm4Yq5dOLRwE1XhGcD3JfW2rdl4WENsfllu2
 AJySk09pJgcXtw/6FdxwxyMc1aSf5aAgssV4C2xkDzPHmCwlm64up3MnDXCM/NT9pfdE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pvzYYk6xyQXigZKjYAqe/eLDiGPxiT7KjKuMvZ0K2v8=; b=d
 kSWSCcuA3a9dPz/kkEJFNJP1AuZsZBecraI6gPimH9BG3odPlfR7+ce0R7iG+P7UZBDb5u3INJtDU
 LUhjFhsnl3Ap0WQ1xIXUBtBxClK4Q/IqkJ04ub1FRoAJCCawIws8vigROf66kV4E5bo48FUmZ28DJ
 TyqXtLXt2L6c7HNA=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9Xyt-0007qa-7m for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 01:10:36 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so8137325e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 18:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790212229; x=1790817029; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pvzYYk6xyQXigZKjYAqe/eLDiGPxiT7KjKuMvZ0K2v8=;
 b=SEqBkDqiHMB7iSjqRGsOJYEe+HkpSP/nRRBhg56kiQNtAc53dYEgCnwtnjbF4bJ8uR
 o5iCO43mKfwbrQXPiwLrNhqWdlYHoyzp3ubynLp2Usnl/WRDwtlTfef5cHsbIi3stPK+
 UZFNCp4QBxU3RB/P47q07pt7sGYHqF33ySro1ghnjFSQGwcM3sqOH9VYXEjgVQdywDi6
 Z5RgttztvIbEAIesw/tL06CNmoAmaTYrU52ebqnyDrcPBFwJK8HNngJO0j8CJ1WDQe0c
 iz4lLgLBEL7VCm7j63/Vkr2Qvkn6O7uyLXyQjoCgAFvTteLCCauCcOtQN7/gxzFB+utI
 wOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790212229; x=1790817029;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pvzYYk6xyQXigZKjYAqe/eLDiGPxiT7KjKuMvZ0K2v8=;
 b=E/gtJyiCzmO99UXza+6+OdjKCL0Xqjo/D7hicz3l2NU8SgEZIUEx8zMJCoPOf9B4Vf
 lggE1TCAb0kMhuX16QlHE+dyjd1pXLXswnCt07feNA3Qc2oLwkzoEGy1Rrhex1S+d06+
 MJme/3Q5sqf7PQjD9EHjIkvhcTudTrOwLh03NSpzzUxIQaiZ3VPWvrZwulq0LqDIIX4B
 E1O5lgEgCAeYfvBIl9r8ZhfzNjgxa/koOwn9zmpTTfbOyCc7yTbh5det+5c2Fvk+FdRg
 9yc4/CyrsDOP1jbxWApo4yknpYyNT6EeFW3F5oM3F2OkPAtTR22Bwp6VB5evL0Z5v15w
 WzBg==
X-Gm-Message-State: AFuF++mX4mLeDwaMOTx0q/8vQT+k/X75oIuyHLfhB/ncYgN/NzQ5Dbyr
 EtaAZDz1cIhtlze6NVjMFYRtmwDPCyVPxfyC8ucNog7UTzS3TwJEgA3S9FKLp4Rz4XB9SG+MyB0
 cWJ38LG0toae8bjtULEfhe7LuNSz6H9nI7j86BiRU/H0hM7boDmSfDAKi22ZrDzZG3ophu0tmNQ
 kSJafloA==
X-Gm-Gg: AYBFou2mvJhKo4QIf8dMFLlRzK7PbIOgUCD01TzOyvUkv5LTdBbxb8MbqdNoFzhjr9a
 1daBhIPQJ9m1Sw1OJsZgFjQt/y9cODQxO3B3Q1epXCb5u03DPiuLPEsw/qbBovaVtbWKGV4OGPo
 50Pn4G7Zc1Ex0Kucw/ZQxsQBjzdVn/jdOy2OKYw0t8cSiRrk1nN9otrBMyn7U/DqSBAsRGgqaRe
 mCJbGaeik5a9ehN9nZD90IVKI6ImSvAvGmh7laQp9UmtSsXR49jgojybz+/PyA5h6QDiqS6N7+M
 N13tNRMP/nrLRnGnFmEgZ/YMd8gOOZPhFkUftFGbYjTnB6oErWeZlEpA38iJzsq9D9cZV38q+tI
 dZZlVBheXG+nkD55fQPWYaCUz5sW7J/B6yDXgzYzE7blgU4xjxXEAlesb5OAgklCLDnURLgJPWt
 7VopJ9rcol2+ommkwJDVZYHA5kcweHMZGLETgcZc8wEcFkuVzdxf0i3HAd7jJAyBOTZFdQ1v/pb
 d+xSsQMX67G9O8EIop4ICW/5kkCJy2gZWXhMhiwQGl195yHgi3tLK3cXEc+q3u9ryOs5Kxvihvw
 fTFzO6MTse8k150J8k0R5z7LSpetYe3K1o0WvhPa7ClkmgHLoQ/hwKFChw9Gbw==
X-Received: by 2002:a05:600c:8b86:b0:49d:1fd8:b874 with SMTP id
 5b1f17b1804b1-49fe66f13c2mr13868075e9.19.1790212228643; 
 Wed, 23 Sep 2026 18:10:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48867b49661sm10157049f8f.0.2026.09.23.18.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 18:10:27 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 24 Sep 2026 01:10:26 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6
X-Gerrit-Change-Number: 1948
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1948?usp=email>
X-Gerrit-Commit: 9d30ccd17c7f0ae71488d9929531e0834018ec38
References: <gerrit.1790212215000.I04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkkwNDk3NGFjZjY0ZjU0YjIxMmJiNWYyY2RhYThhNzQ1ZmMzZGNmNWU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a99b2586966956ca472688bd4279c7a049070886-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9Xyt-0007qa-7m
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: doc: document
 net_gateway_ipv6 for --route-ipv6
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
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7369944733299690732=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7369944733299690732==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ueHUUdB+g0E="; charset=UTF-8

--ueHUUdB+g0E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1948?usp=3Demail

to review the following change=2E


Chang=
e subject: doc: document net_gateway_ipv6 for --route-ipv6
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

doc: document net_gateway_ip=
v6 for --route-ipv6

The IPv4 special gateway keywords are listed under --r=
oute, but the IPv6
counterpart had no entry anywhere, so the only way to di=
scover it was to
read route=2Ec=2E  Describe it where --route-ipv6 document=
s its gateway
parameter, and point at the --route text for the shared seman=
tics=2E

Github: OpenVPN/openvpn#1015
Change-Id: I04974acf64f54b212bb5f2cda=
a8a745fc3dcf5e6
Signed-off-by: Charlie Vigue <charlie=2Evigue@openvpn=2Ecom=
>
---
M doc/man-sections/vpn-network-options=2Erst
1 file changed, 8 insert=
ions(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/48/1948/1

diff --git a/doc/man-sections/vpn-network-opt=
ions=2Erst b/doc/man-sections/vpn-network-options=2Erst
index 960c6ad=2E=2E=
4c4ae77 100644
--- a/doc/man-sections/vpn-network-options=2Erst
+++ b/doc/m=
an-sections/vpn-network-options=2Erst
@@ -487,6 +487,14 @@
         and if =
missing, the ``ipv6remote`` field from ``--ifconfig-ipv6`` or
         ``--=
route-ipv6-gateway`` is used=2E
 
+        It may also be given as the spec=
ial keyword
+        :code:`net_gateway_ipv6`, the IPv6 counterpart of
+   =
     :code:`net_gateway` described under ``--route``: the pre-existing
+   =
     IPv6 default gateway, read from the routing table (not supported on
+ =
       all OSes)=2E The route is then installed on the interface that
+    =
    gateway is reachable through, which is how traffic is kept out of
+    =
    the tunnel=2E
+
   ``metric``
         default taken from ``--route-met=
ric`` if set, otherwise :code:`0`=2E
 

-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1948?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: I04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6
Gerrit-Change=
-Number: 1948
Gerrit-PatchSet: 1
Gerrit-Owner: chugly <charlie=2Evigue@open=
vpn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>

--ueHUUdB+g0E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>chugly would like plaisthos to <=
strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1948?usp=3Demail">View Change</a></p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">d=
oc: document net_gateway_ipv6 for --route-ipv6<br><br>The IPv4 special gate=
way keywords are listed under --route, but the IPv6<br>counterpart had no e=
ntry anywhere, so the only way to discover it was to<br>read route=2Ec=2E  =
Describe it where --route-ipv6 documents its gateway<br>parameter, and poin=
t at the --route text for the shared semantics=2E<br><br>Github: OpenVPN/op=
envpn#1015<br>Change-Id: I04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6<br>Signe=
d-off-by: Charlie Vigue &lt;charlie=2Evigue@openvpn=2Ecom&gt;<br>---<br>M d=
oc/man-sections/vpn-network-options=2Erst<br>1 file changed, 8 insertions(+=
), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/48/1948/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-s=
ections/vpn-network-options=2Erst b/doc/man-sections/vpn-network-options=2E=
rst</span><br><span>index 960c6ad=2E=2E4c4ae77 100644</span><br><span>--- a=
/doc/man-sections/vpn-network-options=2Erst</span><br><span>+++ b/doc/man-s=
ections/vpn-network-options=2Erst</span><br><span>@@ -487,6 +487,14 @@</spa=
n><br><span>         and if missing, the ``ipv6remote`` field from ``--ifco=
nfig-ipv6`` or</span><br><span>         ``--route-ipv6-gateway`` is used=2E=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       It may also be given as the special keyword</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        :code:`net_gateway_ipv6`, the IPv6 c=
ounterpart of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  :code:`net_gateway` described under ``--route``: the pre-existing</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        IPv6 default gatewa=
y, read from the routing table (not supported on</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        all OSes)=2E The route is then install=
ed on the interface that</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        gateway is reachable through, which is how traffic is kept out=
 of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        the tunn=
el=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>   ``metric``</span><br><span>         default taken from ``--route-metr=
ic`` if set, otherwise :code:`0`=2E</span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1948?usp=3Demail">change 19=
48</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1948?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"=
display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> =
Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id:=
 I04974acf64f54b212bb5f2cdaa8a745fc3dcf5e6 </div>
<div style=3D"display:non=
e"> Gerrit-Change-Number: 1948 </div>
<div style=3D"display:none"> Gerrit-P=
atchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: chugly &lt;cha=
rlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--ueHUUdB+g0E=--


--===============7369944733299690732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7369944733299690732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7369944733299690732==--

