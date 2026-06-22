Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E598BCDB46F
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q6rReamRePPLLRkz1PHaToClq6Q4/DJ7JWfFr0dGJXw=; b=MOaTRuQVEfwhvkyx8M8MGkcQ64
	kn2iZHnF9qG2dnaSsASgvpitZqHc5YulRCf8R3yRI5lYcWIP95JK03myCRDYklTOCuwyFGJAzlGmV
	Ly9rdDBxlgAEkCZA4YBQTSHoYAFr1OrW/y98Pouuz5Q9Gi6O54LL7BpNFa4oVnV/4RT0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbgm1-000818-OX;
	Mon, 22 Jun 2026 15:41:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbgm0-00080q-18
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:41:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=k9TShRuHQWDwIAkbQlEvWYhJQ9ibb1DCnfGxRsRWL8s=; b=CPU4SiyZ8O/19kFV1VoK1nv7r5
 i2l1xUHdML1oNepTQ8JSo7cxhQlASmdjf3Jr22uOyKT4RSQZ+yXY3VAObhzZ+krqq+USh0JG0P+o6
 heG6wtahYEbAx4RIkxaplLU5u/UAxEgviV3oQY7x8AcN58uOSIyJo8IhfSdlAFvX0gCE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k9TShRuHQWDwIAkbQlEvWYhJQ9ibb1DCnfGxRsRWL8s=; b=P
 Sxb0AlfXD779kjhq+zWg068CNOVjt8TnXD4RIlin0pRHoG6L6pKcB60ZlofRg1DCKM049PnI2zXqh
 vNxKMQF7c3Z0LqTK+lx0MV3XiotvJ6lLhDtRodSrxX/PniZWGEGS1fsTYEW0B9v3Qqcrqu4nfwxVm
 9+2Z7Hn1sWLcBVvk=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbgli-0008Hf-5D for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 15:41:03 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso47271095e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782142851; x=1782747651; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k9TShRuHQWDwIAkbQlEvWYhJQ9ibb1DCnfGxRsRWL8s=;
 b=CFpIrCvQM0CLGFBCufA4+PXRaaWP+z+BdcVSWgvMnseMQgEtH/7ZlWTi9zDw/y/j3h
 6RhWCQl+yKvfi4O9B8qOo4wwAXECx2Mcd4jEIvyIK1hQ0hS6iJT14iIcuQjZwYegyfm2
 xW6A3qkK/JOXZhybGdN7VQyeYypMn3wIli1l7oPVV57VYYs+ameeyuHhxCSGsPkL+yFx
 7Iq8fke4rVui1VbAoyHjEr5lbVoDPDeUAlfAo1hEY09uxuPup4CfHbD6EdE13iY0iCG/
 GRFFTkWnIAtUvBI6VXqjYkg16aaVBJJsJSz9qAgQpDM4MI6J9Gtq8jfKqYyop96LbK5V
 q56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782142851; x=1782747651;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k9TShRuHQWDwIAkbQlEvWYhJQ9ibb1DCnfGxRsRWL8s=;
 b=eobgV3ClwhRNuudr4W7YivtmPPPz5IrS9Sg3Hkt+3D3QdT7uIkq/rwuq8djCHqdqU2
 w/qWH/UWzXrA3ik9XPJAk61QmuXZ0tab1RX0iRwAJw5i7qHk/qIQrfEisZNWaahqduuv
 mBIIF165DCQVUS1Hkw9yfvYPSymbcJcJ8zd/4+BKeafAxE3APwQZ0tfshc/TroseUaz2
 pNmQU9BkoVZVNFETNKUsiHP50Sy4StBNwaYSqSNb8shd7aVFc8nywJU01VHfAUUQLkXc
 acqR3nTo3qKmS5cTVyx13nfTH0K8hD7oNE+iMinQghn6enjFcBMhJwXUbJiPqlA3cOhw
 FuNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8izPSyRujSbq8cYV5P/AlC/PT5sseliQmBPH7ilOAk/4MRPO2uc/Yncfc6bffsibV1KVcadlmUaI5MTupe@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzApyS+h4Gr58xnkWLLm5klwWZmqWXPE56uQ4i4k07il6zPzJug
 q/h5K2xr2Fwcn/ht7FwS/6IOCQj+jT3LyohF9aVsR4Vh8RVg4Nzvolx/E3GtYf+KAY7+czS49NW
 rHyodYqVgArOdIaV4Ruu/8yBewUN3+IzVpDRrHxmOnh1dtgPiroXHhR3LIria+Yy0QZJAVz4MWB
 QzHpWI0g==
X-Gm-Gg: AfdE7cmKiXgpXrzlkhTup1AgGAx3RZNn07cqxCMTfKcf9o6vY4zFPPtP6CLCzo2ZIQX
 Hfq2yo2i3IogDIGcVb4QCDDC8eOfCg4/aLYeL7mzxBdk7eBaAkaFnhv6+2sn45zRwUun/W7HYiX
 6JMhraIJYdbSCjsItIXdQXHMl07ixTNXrwXIzZEnHa5Qsl445E/yWE2P4XN8jlPx1xxUzX/OZm3
 f5Km7gFa+uPr+MzXc2X/R+EOavZSLZkkthfSZdlwhDRHBykdE1c0JZpFfg7ceSvGyFuhqmHPacy
 sWeowD8pFdXWwLFgTFY7V+MBLcAMFrnmpqBKG3fqCKtkaywkcJnt/mcwl/X9jwNFdMKWHpo9vMQ
 q2sXckD1UrNHPAjuFRlLLMn+efk69mZdbxNg//8opJGi6UnJL1dbe28D3+88VTjRpOjlVM1qjbe
 siKjjiugDXMNfZ6yw1CsKBg6E4xncEoClbmGe5ZI02Fj3jRJWeg6HgHDpgat2f8gRm0Yw2Abt6T
 eBwfio0HjuomQ+9Hc8R/mLFwSp3rA9gNAhht6Bx2pnu0OGTyQuh/3ISs0KepHSvMSYgIdSIFcti
 8iI=
X-Received: by 2002:a05:600c:8010:b0:490:bad9:de43 with SMTP id
 5b1f17b1804b1-4923eeaca70mr245397275e9.0.1782142849846; 
 Mon, 22 Jun 2026 08:40:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c579dfsm26859917f8f.31.2026.06.22.08.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:40:49 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 15:40:48 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 8308e2cf037d771e82d12eeb570c1d3b2670a8e8
X-Gerrit-Comment-Date: Mon, 22 Jun 2026 15:40:48 +0000
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e618f3cc654a8768937a132c5d6e99e5de086888-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbgli-0008Hf-5D
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 dynamically allocated ctx
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
Content-Type: multipart/mixed; boundary="===============1077616903417600547=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1077616903417600547==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZnV/NyPVH3U="; charset=UTF-8

--ZnV/NyPVH3U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1571?usp=3Demail )

Change subject: Change hash iv to a dynamical=
ly allocated ctx
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 8:

(1 comment)

File src/openvpn/multi=2Ec:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/41b08c3b_7709e537?usp=3Demail :
P=
S5, Line 313:         hash_init(t->options=2Ereal_hash_size, NULL, free, in=
t_hash_function, int_compare_function);
> why NULL here and not hash_func_n=
ew_ctx ?
Since this is not using the normal hash function=2E I added a comm=
ent to explain that=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1571?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: If47c7d920b2fa4047b7db03fcde821899839324d
Gerrit-Change-Number: 1571
Ge=
rrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 22 Jun 2026 15:40:48 +00=
00
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flich=
tenheld <frank@lichtenheld=2Ecom>

--ZnV/NyPVH3U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/c=
omment/41b08c3b_7709e537?usp=3Demail">Patch Set #5, Line 313:</a> <code sty=
le=3D"font-family:monospace,monospace">        hash_init(t-&gt;options=2Ere=
al_hash_size, NULL, free, int_hash_function, int_compare_function);</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">why NULL here and not hash_func_new_ctx ?</blockquote></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">S=
ince this is not using the normal hash function=2E I added a comment to exp=
lain that=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">change 1571</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: If47c7d920b2fa4047=
b7db03fcde821899839324d </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1571 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Mon, 22 Jun 2026 15:40:48 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>

</body></html>
--ZnV/NyPVH3U=--


--===============1077616903417600547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1077616903417600547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1077616903417600547==--

