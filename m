Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCB2C5DF7D
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aN6CdgL3Ny6f7mbcsZ38re+3pGsDIp1XQJ/TguqYG30=; b=BCB+rS4J2ltALNubcc8DLLFmhP
	yxMpQGRoT6sl9aAyvC0f4aARd6bARFpEvb7WaohRncpdlXkgY75xKj/T6dkvPJ3eyJtjyWsPPOzXI
	JpFPiAtVlnJymuzOjbkKK2tb5FjTmQ7LTLbZOCMNX2svryKzfMagHpvV/JDIRZn8WKeA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxRVK-0004FE-HD;
	Fri, 21 Aug 2026 15:50:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxRVJ-0004F4-GN
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wGJaGGZbwZl/7aU2JLYFpNCLqkjmsGfOWWmC1IuarqM=; b=ciwEqLDi/Pw9wDBv3+eqkFOnsQ
 uU6xRBsGbdmL+13eJwEEa8Iypog6Lh9laCUhE74zclr+m/zZbIklwdZbnkEOA+UdXwEz47IXdaada
 C4Nz3ndkYQqedPf9NcpYEpSLFVyYLH4EWIm9JmYKXA/0/JkOKNqg7oyQVfapysyMgjbc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wGJaGGZbwZl/7aU2JLYFpNCLqkjmsGfOWWmC1IuarqM=; b=V
 8TSbIFxpM6JCvnMrkh/C5XBvyYc3YLU3dinfdMJu6yB30GqlytaH1OMb+/dvQbxtgF9z1w5dlqBQ+
 JLScl5pZnbYHTPxjWQcJ00+hPy/4WMV61b1M1biQmw8GpLl5cEUBmG40DZHNV1Ytp7rTpBr3xTMxz
 4wQDHx/anPs6ZMFc=;
Received: from mail-ej1-f51.google.com ([209.85.218.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxRVE-0005eC-FM for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:58 +0000
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c1c26d7e951so175508066b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 08:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787327390; x=1787932190; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wGJaGGZbwZl/7aU2JLYFpNCLqkjmsGfOWWmC1IuarqM=;
 b=B8skz+JdNZEhMLcEWo5bDJSbVodmbmN3Ks7dsndzkMF4+LV9kqt8ty4bEZTcOQ4uht
 Cg9l76jkjKoMv/zwblmApnzx1XRa6Yti641gxAzKQ4zbP8+BpzkSJPQbg7dq0fLiQlUP
 CStsxsD9tFIKIHGa4XiDULLn0pEmmFZEOcKRj5ODMqHYLI6Ylfui7d196sKGMaSYARNf
 2gOz2K1pE7zL/MF3g6TSJIOs1KtL+GYR3uCQYAfdQohuVjsCd06g0Wt+5V3s81ZxtHV4
 PCEN/CNM8DSYChr1LBIAD9d+GqCebATDfLvkBuf1FWt9eY0DzNRDNKc771GH3ZQbIWOy
 8TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787327390; x=1787932190;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wGJaGGZbwZl/7aU2JLYFpNCLqkjmsGfOWWmC1IuarqM=;
 b=VlBIN3MFnB1iuIl6OcnEF+OmnA6fx5L7/cXy7XSvXxwNzo5rqYtbrMcC+b+YTAayU1
 1aJXHyggM7frQb7rEvuPc/ECBDarKus+rdw/183JA5B+/WMnGaUHMTxlOkvbAxVaInb9
 dgJl5GGd4udhDOcltcIchjpvsHRM6EQ6WVZSejnvpvEDVcU/2o0QQyl8hyvtLBUTxo+Q
 CI2wfTlthvFHbGm25WRdCq/MDf8/Gm2WW8Hwxesj5AJHU1TKNi64WByPpJyyhDpBIh2H
 +pXGKzdI6+rgGPgM+BhDbazNF7kogEBK4efly2sCcINk8z+VeRvC3bn4GViRtCXkhgjp
 XPJA==
X-Gm-Message-State: AFuF++mB3A2VwD9kkUtcA8V1It4dK3lxfjuUZ3w7tZw67UzwEe6FU7m9
 HqVKsF+AzTErHXZv7+l2BzMQn/p7X1XyAST6hYvtqxNZ/+jbTEhV/O3+60Co1uIYoUCvlGx8eIK
 TMnFPXlIt/+OoY2TG0DEWFr3Z4abKbrgvaiW5/6Yf57irvExQFYNiMJhhiKaXoJpM/zaT9H3jWN
 iYNChXjA==
X-Gm-Gg: AR+sD12RG4o5Eu9m5s3o532lUDO3HkzTElF1HWx+S8U4WnrSGU1MqL8RcMVZCBbBHev
 RHMUpA6K2NWmELlFXFoaq21OzufFLtIRiOtzZCZCJuId8smK6WtS5DDmV0s6l951vO+H21FJXz6
 XjMgbiW4OEBRRxt+tchS6DDpIKMU40w9qpQRjsvv/CWKorbjhXm3fXFNwH9xOIWrsF1AH2oXXuM
 PpZSu3kbP6vrU/foIIW8f3ae8Wvpexo/uHntyRWZVELIfr+PzKvJX3bjV6L8uh+tp7F/yxhFMa3
 y63wlvIWkkF4PMQHZKaDmpc0DhQYrpB0628JLllaVS3O7+CLwfLI+ycnfzUHRgHs2nzdm1pjyn5
 NtwLC/3GAaIomG0nc3lsgChDpgYdt03jGkhEygqsAr4tZkez9AbNyKJZwUaqAoLzq+Aq4IyJBek
 EFsya3hcfGvchAzbnNe8zOw6wqYXe9/H+x6PSBEdBz3vXxZMPorqz7oy2sV4B3hP/iGgRG28N0B
 xr0MoyrXsAlRayh3aEH5LKhFdh19DcrSEbdkH2dFVbJ1ZN6yymoesNIrxTdLystcCpXY6suNkon
 u9D+vz8rbGxp/iPteao8fJACQwUw+7HhX+cPNdzUrOPKVzk+9AI=
X-Received: by 2002:a17:906:fd83:b0:c12:5a0e:3e0 with SMTP id
 a640c23a62f3a-c246a651b90mr751152766b.19.1787327389725; 
 Fri, 21 Aug 2026 08:49:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24589e04b5sm560611366b.5.2026.08.21.08.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:49:49 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 15:49:47 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
X-Gerrit-Change-Number: 1859
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1859?usp=email>
X-Gerrit-Commit: 2137330bbf353f24784c67ed259ddd3c897fc296
X-Gerrit-Comment-Date: Fri, 21 Aug 2026 15:49:47 +0000
In-Reply-To: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliMDliYWZhYmY2MTJlOTUwMWVhNzU3NjQ3Yzg2YTQ1MGM3MzIyOGE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f5b1a6b955fd4d658a6275113d9c58c194f6e7cf-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxRVE-0005eC-FM
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate using the mangement interface
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
Content-Type: multipart/mixed; boundary="===============8138841943455651493=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8138841943455651493==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vaBbyye0pqU="; charset=UTF-8

--vaBbyye0pqU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has posted comments on this change by plaisthos=2E ( http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail )

Change subject: Add pytho=
n scripts that demonstrate using the mangement interface
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Pat=
chset:

PS1: 
Marking as draft since the script already work and can be use=
d to test/demonstrate the appcontrol feature, they still need work and clea=
nup to be good examples=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1859?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
Gerrit-Change-Number: 185=
9
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Co=
mment-Date: Fri, 21 Aug 2026 15:49:47 +0000
Gerrit-HasComments: Yes
Gerrit-=
Has-Labels: No

--vaBbyye0pqU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail">View Change</a></p><p=
>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?tab=3Dc=
omments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Marking as draft since the =
script already work and can be used to test/demonstrate the appcontrol feat=
ure, they still need work and cleanup to be good examples=2E</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1859?usp=3Demail">change 1859</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1859?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1859 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Fri, 21 Aug 2026 15:49:47 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No=
 </div>

</body></html>
--vaBbyye0pqU=--


--===============8138841943455651493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8138841943455651493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8138841943455651493==--

