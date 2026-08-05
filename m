Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A963C55174
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z5ONwyuaXYlHAx3EpqhdWVDqQhPYFFVEmNEySThwGr4=; b=GQcOvWmGGsqMOUjZ98yKYLlKU+
	XY+6FxWHU1a2mna4ybiXd0G8qrcc1F6mm8Hqa3j8+XM/YhimwhNGXtdBKmBjIYNbMtJ6JFFBHet7C
	JTivZ8QU1DMx4Yx+v7tTQwdm3IClmujXBi6of7jzYmJRmZ2qLmI3xG7l2pgdwYCN5rT0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrdJi-0007xv-2f;
	Wed, 05 Aug 2026 15:13:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrdJg-0007xn-BI
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 15:13:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gwG7T1wc52raeuAkXNPoDV8o0j18shHU3l4cgkjCbW4=; b=FeyM8jISiwrBtqrxWq4+fcoUXn
 0QcxNrqBFJybs4A0SlGUsgH/4p3TZ4MTghOpJKpGCH7C8+gPyIhq21hcdE72SQwfmE1W7AIGtIbn6
 lgeYlPUUsGNNQwxJd4Z/k9+yesSSF88AbMOtjcMaEM26dSHVztDvc0HsPHS1OmsYNWNY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gwG7T1wc52raeuAkXNPoDV8o0j18shHU3l4cgkjCbW4=; b=M
 Sh3ckcbtUP67SAPGh3fk1YQ4gcTuJTSrDqxnnUXVC+gD4PmlBJqXG0JCjYF7qJcJETrb5X4G1WQUd
 D/efPhkxI3VL7DEEHXinq6/Rpx9VeqMgmYhK+KGXzShLQQVG+XOKt5caqooJGzCoLLbmUIayXpKGe
 +XGOUnoxCYph5UqY=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrdJg-0002OH-PK for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 15:13:57 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso934190f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785942831; x=1786547631; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gwG7T1wc52raeuAkXNPoDV8o0j18shHU3l4cgkjCbW4=;
 b=I1xYDaX/5rHXj4Lr2hVw7OxrFXpdfGfpFz1Mnh6KDu/n8JxzooSWBmtyYqS7iifsOL
 +i+4gSSKxTgfnROx+rcHsucbJL3V3S0Lv0QNYpbqhncGhUlyvOel6hSi1FA7kb777cRa
 775drI/rK/j0jszsIK6/1GxmiPZOaYaqntPteFAEpKrz7VIzNO5bhXKIcyraPA0sSd6y
 RN06sSeZUAZ0UlJuQ47RHN757MKb1dXqXfRxIoYc3tYTxCpOihk6rXsRfb3KzoG5kWFV
 +GYAonnylwJpHki9mO8p9DHBfPNZpzri+0Ee6+Y8g5AwoJNtNV3JUusmlF46SJCYDwvX
 uoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785942831; x=1786547631;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gwG7T1wc52raeuAkXNPoDV8o0j18shHU3l4cgkjCbW4=;
 b=FktLCVm9yeX5BQrfIb0r/2/AjjxcIwdK/Hp7VWw8LmY18OJMGkMQ9RTzYD8Rt4n4FR
 jDjZVhgMjDNzTjuVm1js+mmyAkP8Qklqhr63dF1mxmxkxet7Adq1UrmBty+l1oo47sSv
 KeiXTHiR+tTA4fizLspJsfqj418gzUsmnMsBIi96Z/IG/Gpbj8WB2W+M7q+qSLIgouMI
 z1eJXF/5mtQET7niKUDIV4/8vF/KHMhvELG30n22DXS1zTCpLtx0MhN93pVryVLwtXtB
 MY0Z2T0bAOPy6NaWy9b3Ofxs2swsKEqueWf63JVYWZj1mIJ2huuOFVkCWmyURTIIDpBS
 xvhQ==
X-Gm-Message-State: AOJu0YwiqPxN7P8ETAzaDuVS8Xs7jEM0u/vDDmQkyN0pVZNQPUTu1CZC
 TwRco/hSQd57BSeiQrBPB6ZyYecVhbWqVJrUP20t7Yjnjetug/M9UiOnIaxl+Bu0KdPD1i/8lNv
 EvtCgONLy8+6jmhmYZaUIKOnp4IuqJkd2bh8rC5hOxQlmlKotn6PCqxt1wlW7VDUC0HL0hKT+e7
 3QcIam1Q==
X-Gm-Gg: AR+sD12Jnwf+bVu75ktfR9TQSQOQucjnJzbUvkv0648LEjUmLVpG2mjbFbLxv20CmXj
 GbttXvotxfVXRuci89Cj+bQnbwPFNRJRZCpyiytHQ6CsKphZSZpybrcIBrFKWxsHUMpg4FjgnoF
 4+7I3Gtwug4n0YHsuMSGjPDU0LLJ7S2Xq1Wh/cUD/S10ItWCwYZOO1rxKBDbP4AC/YYHB/xvxip
 yByL6/qxdmu6ddG832i5MbX73Q4ajRM6uGGHTRxd+dz4fhK37/8KhBzdFeu11BFRLKYmOA0265S
 tnCss89mKBRPwTjdqfMZElvkXuwbyk1Y1PbKoYse6VZ6t3m3u8anrGvmqZtIeKVBCC7JJFuX2SX
 DFQR7bmFUA1sU+Fu8wKkRreT5Sn9FyRK7F/9xpJ4arOTI6upClVBxbOuvCPtFqBMGlDuadQJiuH
 KrcDLOM3gOg4t758ZcR5TFTtUh9KytlE8RTTweioCBnxiw+APvzhVUgRyNkOcmhXrNj4shvj3t8
 C7f2kXBQslAzn+pMp2u8eHs+uxwR79AOljwm2C02q38tH+aHXpNJmM3XOem7Eh3gBfL79L2xYYN
 xgIzFy7Ojtio6fxUjomh/M/sirQZBA136I3hS/TB3UfZOAhajd0=
X-Received: by 2002:a05:6000:2991:20b0:47f:9ac6:c9bc with SMTP id
 ffacd0b85a97d-47fec4e2905mr11840082f8f.2.1785942830474; 
 Wed, 05 Aug 2026 08:13:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec24a24fsm10497649f8f.36.2026.08.05.08.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 08:13:50 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 15:13:48 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534
X-Gerrit-Change-Number: 1837
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1837?usp=email>
X-Gerrit-Commit: d8a9c1d752e81e5aeaaeaf74f73a56130b97d7af
In-Reply-To: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
References: <gerrit.1785931793000.I728067ef08481c87c7b6918c88ebcaeeec466534@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1OTMxNzkzMDAwLkk3MjgwNjdlZjA4NDgxYzg3YzdiNjkxOGM4OGViY2FlZWVjNDY2NTM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d6085659e2dd67f4ccc4ce648664a4a76f46c776-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrdJg-0002OH-PK
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2179741274621579128=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2179741274621579128==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lRBkamvqDsk="; charset=UTF-8

--lRBkamvqDsk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1837?usp=3Demail

to look at the new patch set (#2=
)=2E

The following approvals got outdated and were removed:
Code-Review-1 =
by flichtenheld


Change subject: Reenable xmit_hold when using p2p tcp-ser=
ver and tls-server
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Reenable xmit_hold when using p2p tcp-server and tls-server

Commit=
 619c3e9 changed the logic to enable xmit_hold only
when c->mode is CM_CHIL=
D_TOP=2E This works for --mode server and
was probably done to allow  to pr=
operly work when the server
is listening on multiple sockets and options->c=
e=2Eproto cannot be used
to determine if this socket is tcp or udp=2E

Rest=
ore the logic for p2p to avoid both sides starting sending
resets at the sa=
me time=2E

Closes: openvpn/openvpn#1089
Change-Id: I728067ef08481c87c7b691=
8c88ebcaeeec466534
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M s=
rc/openvpn/init=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/37/1837/2

diff=
 --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 0236886=2E=2Ebaa=
a7f3 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3330,=
7 +3330,7 @@
 
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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: flichtenheld <frank@lichtenheld=2Ecom>

--lRBkamvqDsk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1837?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Reenable xmit_hold when using p2p tcp-server and tls-server<b=
r><br>Commit 619c3e9 changed the logic to enable xmit_hold only<br>when c-&=
gt;mode is CM_CHILD_TOP=2E This works for --mode server and<br>was probably=
 done to allow  to properly work when the server<br>is listening on multipl=
e sockets and options-&gt;ce=2Eproto cannot be used<br>to determine if this=
 socket is tcp or udp=2E<br><br>Restore the logic for p2p to avoid both sid=
es starting sending<br>resets at the same time=2E<br><br>Closes: openvpn/op=
envpn#1089<br>Change-Id: I728067ef08481c87c7b6918c88ebcaeeec466534<br>Signe=
d-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/i=
nit=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/3=
7/1837/2</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</=
span><br><span>index 0236886=2E=2Ebaaa7f3 100644</span><br><span>--- a/src/=
openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span=
>@@ -3330,7 +3330,7 @@</span><br><span> </span><br><span>     /* should we =
not xmit any packets until we get an initial</span><br><span>      * respon=
se from client? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (to=2Eserver &amp;&amp; c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (to=2Eserver &amp;&amp; (c-&=
gt;mode =3D=3D CM_CHILD_TCP || (c-&gt;mode =3D=3D CM_P2P &amp;&amp; options=
-&gt;ce=2Eproto =3D=3D PROTO_TCP_SERVER)))</span><br><span>     {</span><br=
><span>         to=2Exmit_hold =3D true;</span><br><span>     }</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1837?usp=3Demail">change 1837</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1837?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I728067ef08481c87c7b6918c8=
8ebcaeeec466534 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
837 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>

</body></html>
--lRBkamvqDsk=--


--===============2179741274621579128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2179741274621579128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2179741274621579128==--

