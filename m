Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E562AC5AD5A
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 23:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ls3tes5ZFuk6frDMt9DWWv7Qf4rSFJx1jS8BWNu1xSY=; b=dk4PJWbnV8y8qRV6MSRmNafdyX
	u2mETX86sAol39K12mXQo4hnHBoZjw+0mrunpgkjN/cqByNz/hf4lbpBaN1WV1kfZFH+icik2oV/J
	6gNjsvoitxHIn8k9TSmTHkYR41LSM7zbbrUt2/kqeE9TI/4d2JO6zdiLGR0ZbMZfQo/s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtCin-00007B-K9;
	Sun, 09 Aug 2026 23:14:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtCim-000075-Gv
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 23:14:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=qP1kY4M1IWO8Z98F2S+vNxbNoyoNt0VgC3qSVlwB/u8=; b=IGMJ0P6WPeFLmze2OtQ53uotVu
 ExNeo40XHZ9jQlbymGoZZUQ+tPEPBLLDLCjObuyWXb2cMuKt675zLzA2l0gJiEfbYw4vRkeTjd5lA
 nTOlhW2JzJIQamjVU42bXQ2yUNFxCmJJTj05fIXH9YMhCYm+IqynMf2XG5gevQqOmZ2A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qP1kY4M1IWO8Z98F2S+vNxbNoyoNt0VgC3qSVlwB/u8=; b=Y
 rKsIBUgjuYFtmaR/cDoGBoSRFmdiB5mroRaJVPh67rD8rFZwqoX/DGEeqNkDA2k3EHUse93cAV0Rp
 VCVNgi9AM8bHTvUjyP9E04odn0xXvT2N9mUpO29YOgrtRZf468+ule4tlewDpNg9aB+L5wRGHTsO9
 tC8L3UHqVTa3r450=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtCil-0006gP-5L for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 23:14:24 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47f7854678cso814616f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 09 Aug 2026 16:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786317256; x=1786922056; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qP1kY4M1IWO8Z98F2S+vNxbNoyoNt0VgC3qSVlwB/u8=;
 b=ggci7dBblEPouLFyMDqHMmKRNXdoIdaTYw2eWB4LiqHIsOePOvuc3rkXPAeY75Z8p5
 mNfMk4avFvJjoHO7TMsiquvRncTSUWKVVmYu6dQtiwwQje+lbFEyi8HhwNd8bD9yvwSh
 OE6v0uZR7fFQhfg2wRIAU/p7LgCugbIBpfGfHlWkX57czbAd2tLSQe0UUNoXth63R1TB
 I3AUDut5zS/g/P3ioIG9kVRy19V871GASO7EklbMTbQJQHH6XIU5M7QEQIhphWAorUJz
 bx9OCcH0y9s545CzsYPIOX2vO7MGdZ0+O9211FhpjKRTuOYtsn7ydakKRRNjvAoBX803
 zBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786317256; x=1786922056;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qP1kY4M1IWO8Z98F2S+vNxbNoyoNt0VgC3qSVlwB/u8=;
 b=GOYyqMFteFAz7KvQBFXh+K3cZf1sBJGFWHVhkrXnIiQ7SdpB5bGy9aSTss8yr3azmS
 qtbZibgJxzCHImmKe9R6fEXPmpm+aJu3y9ZD0AJOdWb/lYxG6YhwJQtoK4YG9foa1z1E
 xApfOA7F30k8uru00L+gjvAi4i51YI8HTi0olkj7l7MouwY10fHxnvVJFoY5CCHatCHQ
 qB67L06q++7xfbiSwO2LwIDmagO9I39+hmOeABsE4NqEjmvJARsZyZnptzMG8aZ98Uja
 VBOH4YO/yroFrm5ktbwF3lbowwlnFv+8sk+deKgPQE1KTEtEymEMRP8NIA++h1EOQQNq
 Ke/Q==
X-Gm-Message-State: AOJu0YwFwLOOo4iCvScEKYX3ztcNpFPM5cu4CADrJl8qhDdo0UzZeR+S
 48/okEEPl9gHTYxxLuSi5029QfsE8q1hdW6yRT2aSyTEow3F2s/aHaSZ3MXMNCfkc6AhKYol/1b
 Jrnrh8sM8ITYjKR2j4FQPnbuqR+Vf0rQdimz82ETVOIX1ri87DCQOZjog/eYJsxaO3DFI6mkDsl
 wHfEmn2A==
X-Gm-Gg: AR+sD10gD7wgTfQoZlSAdPkbH7RFfumyV7o/rfWS8bdgfQOCqlF/YV802zCH1qGiIp9
 oNZlIf3LFQ1nr/oJkOV8JSHsslH29O1PSXHzKkh9gaI3OCS1bZj5PYvq8ZlWVD1XN/LVJFyiwjM
 /HTfXZ6Scwao200nwt43G+aO7UjFeEk5OKaiNolyJbLL3AAHzrrW025IaUEr8y+OaC0EjS/fC03
 c5RI5/R1XFKEHO8Et5FdwT9cyFylWnLwwb2FaJZVTA3dAJ0sETn3dKDki9mVupWMOa1hnf/92xK
 ibf+0SHkCB4BqasoTQeRi6bu1AQRnjuptrcZWKRm+T9hD3/ESr/ThXwA5x4jUdaf0GFqqoR0Qt9
 siwzrJZSMn66fCdCjGaAFZP9+LFxJ/UPQLGQm/+mchP3U2R7emrIWZ4QJL8oHdBvCh+D5JVDJOw
 3qmxSeIqK21/mvVr+MS3Di9+mVv7FYTff5AMDrbLZItooC1cc8IScjoZ8ATfET2lQ2aqnA7Mssx
 srucwcmtIbEJkR+jhTNZZiXPrWyZRnH7vgzqNoSYKBnwsmK9gU02ICwo5aMX4roHZ6VZ3ByMp4H
 mbcSeuDeyHJfB0atvLIhHUw+fxtYILbnwweg21UHD06ZlrHtXd8=
X-Received: by 2002:a05:600c:4e88:b0:495:4491:b8c2 with SMTP id
 5b1f17b1804b1-4996194e257mr184694905e9.3.1786317256547; 
 Sun, 09 Aug 2026 16:14:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995e9f060bsm246748625e9.7.2026.08.09.16.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 16:14:16 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 9 Aug 2026 23:14:11 +0000
To: flichtenheld <frank@lichtenheld.com>, MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534
X-Gerrit-Change-Number: 1837
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1837?usp=email>
X-Gerrit-Commit: b059b5d88eabdecb0316326b52c2bdd6108d540e
In-Reply-To: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
References: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1OTMxNzkzMDAwLkk3MjgwNjdlZjA4NDgxYzg3YzdiNjkxOGM4OGViY2FlZWVjNDY2NTM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a83176106e915e7b34bee061fb829cbca17a996e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtCil-0006gP-5L
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Reenable xmit_hold
 when using p2p tcp-server and tls-server
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, max@max-fillinger.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4724196314338166739=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4724196314338166739==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KXgSKsyJesk="; charset=UTF-8

--KXgSKsyJesk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld=2E

Hello MaxF, fl=
ichtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail

to look at the new p=
atch set (#4)=2E


Change subject: Reenable xmit_hold when using p2p tcp-se=
rver and tls-server
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Reenable xmit_hold when using p2p tcp-server and tls-server

Commit=
 619c3e9 changed the logic to enable xmit_hold only
when c->mode is CM_CHIL=
D_TCP=2E This works for --mode server and
was probably done to allow to pro=
perly work when the server
is listening on multiple sockets and options->ce=
=2Eproto cannot be used
to determine if this socket is tcp or udp=2E

Resto=
re the logic for p2p to avoid both sides starting sending
resets at the sam=
e time=2E

Closes: openvpn/openvpn#1089
Change-Id: I728067ef08481c87c7b6918=
c88ebcaeeec466534
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M sr=
c/openvpn/init=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)


  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/1837/4

diff =
--git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 69d226d=2E=2E0827=
8fc2 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3332,=
7 +3332,7 @@
 
     /* should we not xmit any packets until we get an initi=
al
      * response from client? */
-    if (to=2Eserver && c->mode =3D=3D =
CM_CHILD_TCP)
+    if (to=2Eserver && (c->mode =3D=3D CM_CHILD_TCP || (c->m=
ode =3D=3D CM_P2P && options->ce=2Eproto =3D=3D PROTO_TCP_SERVER)))
     {
=
         to=2Exmit_hold =3D true;
     }

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534
Gerrit-C=
hange-Number: 1837
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: MaxF <max@max-fillinger=2Enet>
Gerrit-Revi=
ewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>

--KXgSKsyJesk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, flichtenheld=2E </p>
<p>plaisthos <strong>uploa=
ded patch set #4</strong> to this change=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">Reenable xmit_hold when using p2p tcp-server and tls-server<br><br>Com=
mit 619c3e9 changed the logic to enable xmit_hold only<br>when c-&gt;mode i=
s CM_CHILD_TCP=2E This works for --mode server and<br>was probably done to =
allow to properly work when the server<br>is listening on multiple sockets =
and options-&gt;ce=2Eproto cannot be used<br>to determine if this socket is=
 tcp or udp=2E<br><br>Restore the logic for p2p to avoid both sides startin=
g sending<br>resets at the same time=2E<br><br>Closes: openvpn/openvpn#1089=
<br>Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534<br>Signed-off-by: =
Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/init=2Ec<br=
>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/1837/4</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><=
span>index 69d226d=2E=2E08278fc2 100644</span><br><span>--- a/src/openvpn/i=
nit=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -3332=
,7 +3332,7 @@</span><br><span> </span><br><span>     /* should we not xmit =
any packets until we get an initial</span><br><span>      * response from c=
lient? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (to=
=2Eserver &amp;&amp; c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (to=2Eserver &amp;&amp; (c-&gt;mod=
e =3D=3D CM_CHILD_TCP || (c-&gt;mode =3D=3D CM_P2P &amp;&amp; options-&gt;c=
e=2Eproto =3D=3D PROTO_TCP_SERVER)))</span><br><span>     {</span><br><span=
>         to=2Exmit_hold =3D true;</span><br><span>     }</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1837?usp=3Demail">change 1837</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1837?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec=
466534 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1837 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@max-fillinger=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF=
 &lt;max@max-fillinger=2Enet&gt; </div>

</body></html>
--KXgSKsyJesk=--


--===============4724196314338166739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4724196314338166739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4724196314338166739==--

