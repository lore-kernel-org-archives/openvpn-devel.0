Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9946CC43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=yFnKveji4ruvC/brMmsI5zlhz5O/H3f2vNK/fbQBVXQ=; b=FuyLlxuP3jV0Y2
	IBjeUVSTUHCDdgtfSyC5YLh2R4t5pJtNdarM0Qj4w6GzIxl8b4Qr9GvHaFpdJqcGIWug2otXDldHM
	XddL4B2jfm5MLmVkU9/DbkHuQfGcR0ABlWY4tm1hZDDYdPst4u8n9ejLVya/0vx1CT2VWVGnFBY+B
	sUQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfEA2-00074Z-1W;
	Thu, 02 Jul 2026 09:56:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wfE9x-00074F-HD
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 09:56:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zC/K9AfK9gPcnuv3eUswAExh3MSgfdAn0+AwjLO4qAI=; b=i/Uqm8wJ7urTXLFjGEHEm0llRi
 jnIh5+XTZ4U8Vowa23iolpm8o1Mi6zdXWIu8QuU58O4+RNF/MV4AXpq+lpZA51oNn9sKXqprR+Pfc
 /BifCnTlTOI7xVy6V23LoVwdqZAXB/O/QErIi4l+c0iF6wRo2G9lAL5vgtcEBZBfvwG0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zC/K9AfK9gPcnuv3eUswAExh3MSgfdAn0+AwjLO4qAI=; b=U
 mVala691XlT89749zCKLsjlRTnadGEQLMh2jLi4XezD7JfkXmelJOB6IsOuQEiBBrgMWKEU9qgAh+
 lQ7cj59j5NrF8GkOnrMlreUoLvYyfoVkY7qIxjDbl26Qoxaz61HVhPgKFBoIHngPC7HM90bYor33E
 CACqSn71aAAriwAo=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wfE9u-0006af-0B for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 09:56:39 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so1022692f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 02 Jul 2026 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782986185; x=1783590985; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zC/K9AfK9gPcnuv3eUswAExh3MSgfdAn0+AwjLO4qAI=;
 b=JaC8FUDt07n4qbyzZSe+hsoWVmt6b38Mwf7n/4gzTwh5FvArwKZWlMZ1rbBIXboyST
 XRI3E7fDZbGXjHUbyLPH5k9rbdKb+hs1YCSjhTc0CLyrKTbtdgm5hh7QZ/KawSXb0kEw
 hqjdFgiNPOnSqyYmdcXC2PoqFndYWGYeQKEddcjJJc0k0bXJ8Bj13Bk4/JJ+6iwM+smS
 MbcFnhZNPuXUOWlnzR4Zvhx74c/A6vkyLZtQpS8zBr7eeq1uZsl8XEb1iep7rLFreZfd
 XxLv0+XtW8J1m2azJggc71MfkphWDFu/Vkhrkkm3SilDX4XipRcJp+JIwnYHvsl65eAC
 35sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782986185; x=1783590985;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zC/K9AfK9gPcnuv3eUswAExh3MSgfdAn0+AwjLO4qAI=;
 b=JAeyWFFi6YEaArtfhVsvDuECTEvnLdHk0UgYBysB/nMqM2TtM0KRMosEqBZzk+eKfU
 k6P+c5zM+6WJp1p5UpNr5E4up2LKcvO3sEMoKoUovo7dxIfeg0Ae4pKz88K8dfCpyESP
 wN3BWpb386utLBq5odXV07jaornhXVThc15ns+6Kquzfz8KCIUIokFIm5qMw/vEF8WVy
 ntqM0bdWU6TO36g1Xr3VFW1zmYMS0X4fVN0UHJqmBp0LBAvZnDL+JmOOkVE6dV5AOysg
 JJYdau7xwoiXJX1NeJ5Z52sq++W00Kq3iHIluUyFLyuQgzYbWdQ3FJxD+T9s31hQcV21
 YOQQ==
X-Gm-Message-State: AOJu0Yxku+7fmPnVh8g/mV4ivD1BMb3vszMB9w284/UHqDb2JvJ61hI6
 72RkwM3YuhVdibapTiD75x4xzwA4rStmehGDUX63G2WRk2P/jvjXyiR0rfxNaI3lR+D2NiJyWup
 X4IgBSL+EDLrjixZ0OcfwfLx4+dIKkf8FHO/1W17gG0lSSx1tc2an9zqFNjfNpvQkIt3cny8jo3
 IFmLJMVA==
X-Gm-Gg: AfdE7cnXD1ri2TQ1TX4oR05gqpzqfREUY51X3eqeqH5W0jED85SFool2LEW8lCMcBZD
 vyK/A3WFC2zwGmFAvDbXKVzKRETS9HigjviufUt6/i5cLMsIoyV/aBUYOOIotV9NHGYHCjAwSFg
 uQe1Gs55ugoTupDBxZu20uUzRClseX83dGZfiI1msw06CphBwn+Gsx+BvumTn66KcE5JMEpK+GB
 4InkxAGGpK7GTLHEJKh0bTKqWEApcM54o1EHGWCBMmUD04yAOm+fqf6v3SeCtGWsYYVnQTDRMRD
 0aPZxaAVUaUv9k240/tf+fS7lLiCHfYj98ePCI8zz0HaZHL9Zfj+2WUEEq14R6v3m2rjyGqNt70
 tygPc2WPix/c2Qg9lA7UF1vG4FHCHTDDFwVgIEN3OIq9+7RuONaoCy+8LJVT+hMaao7QLy6SG+v
 qJeyoKexFD9FwuItT6Fm13HlrnQjCbWY2pN0lsl3O7yHBsO/yaHkXbDrWiXUShAOTnAk9Zm0xS6
 cXuBcibvm9n4B+8JhbSpOM0Hqw0sQ7XWS3Kro2j8XqLVrl4FlwX3zt/ZFkz7ihI/ylwbPUuoAHL
 KG8=
X-Received: by 2002:a05:6000:2485:b0:466:6d18:ae93 with SMTP id
 ffacd0b85a97d-477577983famr7760012f8f.21.1782986185197; 
 Thu, 02 Jul 2026 02:56:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a44d7sm7090798f8f.9.2026.07.02.02.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 02:56:24 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 2 Jul 2026 09:56:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I20cc89a546b69aceadcd1630828de407d530d7c7
X-Gerrit-Change-Number: 1765
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1765?usp=email>
X-Gerrit-Commit: 26690394b5de8bc95140331a0308f515f5de80f8
References: <gerrit.1782986182000.I20cc89a546b69aceadcd1630828de407d530d7c7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTg2MTgyMDAwLkkyMGNjODlhNTQ2YjY5YWNlYWRjZDE2MzA4MjhkZTQwN2Q1MzBkN2M3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f68b9207f96e6936ef594d404cf39f10689423af-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wfE9u-0006af-0B
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_pkt: Fix
 doxygen warning about read_control_auth
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1992667056210447968=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1992667056210447968==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sSREgjHedJs="; charset=UTF-8

--sSREgjHedJs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1765?usp=3Demail

to review the following change=2E


Chang=
e subject: ssl_pkt: Fix doxygen warning about read_control_auth
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_pkt: Fix doxygen w=
arning about read_control_auth

Commit 01ee1693f960a696a613e7b83f9960002264=
a379
("Ensure tls-crypt keys are not setup twice") removed
the argument but=
 did not delete it from the doxygen
documentation, leading to warnings=2E

=
Change-Id: I20cc89a546b69aceadcd1630828de407d530d7c7
Signed-off-by: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/ssl_pkt=2Eh
1 file c=
hanged, 0 insertions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/65/1765/1

diff --git a/src/openvpn/ssl_p=
kt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 640885e=2E=2E82cb5b1 100644
--- a/sr=
c/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -207,7 +207,6 @@
  *=
 @param ctx               control channel security context
  * @param from =
             incoming link socket address
  * @param opt               tls =
options struct for the session
- * @param initial_packet    whether this is=
 the initial packet for the connection
  * @return                  if the =
packet was successfully processed
  */
 bool read_control_auth(struct buffe=
r *buf, struct tls_wrap_ctx *ctx,

-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1765?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I20cc89a546b69aceadcd1630828de407d530d7c7
Gerrit-Change-Numb=
er: 1765
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>

--sSREgjHedJs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1765?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">ssl_pkt: Fix doxygen warning about read_control_auth<br><br>Commit 01e=
e1693f960a696a613e7b83f9960002264a379<br>(&quot;Ensure tls-crypt keys are n=
ot setup twice&quot;) removed<br>the argument but did not delete it from th=
e doxygen<br>documentation, leading to warnings=2E<br><br>Change-Id: I20cc8=
9a546b69aceadcd1630828de407d530d7c7<br>Signed-off-by: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/ssl_pkt=2Eh<br>1 file =
changed, 0 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/1765/1</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><s=
pan>index 640885e=2E=2E82cb5b1 100644</span><br><span>--- a/src/openvpn/ssl=
_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -=
207,7 +207,6 @@</span><br><span>  * @param ctx               control channe=
l security context</span><br><span>  * @param from              incoming li=
nk socket address</span><br><span>  * @param opt               tls options =
struct for the session</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * @param initial_packet    whether this is the initial packet for the con=
nection</span><br><span>  * @return                  if the packet was succ=
essfully processed</span><br><span>  */</span><br><span> bool read_control_=
auth(struct buffer *buf, struct tls_wrap_ctx *ctx,</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1765?usp=3Demail">change 1765</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1765?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I20cc89a546b69aceadcd1630828de407d530d7c7 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 1765 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--sSREgjHedJs=--


--===============1992667056210447968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1992667056210447968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1992667056210447968==--

