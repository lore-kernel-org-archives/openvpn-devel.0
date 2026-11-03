Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B3606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Q272bPtc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WflJi0Qd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=F+NEU7gj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ULJbx/00
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=naiCHd9dJ7o2pglAJ0CCJusCZ4En8Dh/RwWOXUe6IdQ=; b=Q272bPtcAbALBfCzbbbPL3zUop
	pN29QeWCbCpQCfmE65DB+pkgYlORldx7Fv1L5rfGMlSO3dsbtZ62NnJOoaR8r467WiIPRoFRpraSL
	RvRtj761eZfuRGsMtp8VVRQ29dJ5YDW5n1gRJtLJynR4MZDM/zOGw/M49Qwv60+IUiDA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xODbc-000000000yA-3kLl;
	Tue, 03 Nov 2026 12:27:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xODbS-000000000xD-3uuq
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:27:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TCnJMk99M2zpcBpoWpAWHUFicc2sVfch4ArOrNKM7uU=; b=WflJi0QdYMyZoCmtZF62H2pQ+v
 oOhPXTKzN7c0uuj7QB0+UV0X2gR146Kt3bu+vMJgKykaQvg9hcpyItTodcUvK7TROK2B0bfYElwHJ
 hyO7alDqerZFN/mnPPdinXBg41llDnXxLEsvgM55Geg0jrmy8iSSwGb7XL1JmtfB8FPw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TCnJMk99M2zpcBpoWpAWHUFicc2sVfch4ArOrNKM7uU=; b=F+NEU7gjRH+X3X+iNk+EHJg6Ti
 hPwI23Whi/b9gbLTZz5dwVm9C8bmmuQ7wgT2rYSJpHB+auI69JOqpbQRlPvOUm8QrF0QrNYZmRuta
 rg4CIkq00qUooIeAauU1d3721934v2D6omjB0u8lclAf1VZytCmAt/GDzMZ1AUrTMtvg=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xODbS-000000003PO-1Kgs for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:27:02 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so36828545e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 04:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793708816; x=1794313616; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TCnJMk99M2zpcBpoWpAWHUFicc2sVfch4ArOrNKM7uU=;
 b=ULJbx/00gC+d08Q3smmH+WVIEAGj/MoGCppFrYj4KYiYuYLVmeDJTQS5U0cjnFvEWM
 Qfd36X2WjdfT1J/BMxwoWA1rXaBdXXD37OVVTcgmhGTd0V0YWwYNfYQ0b1u7gQW6IEOa
 ilp51jFm3BUqH1YuFVOydXLP2rjR4VPSI3e3aZDnEP4yEVj4F/y2++60D2/Bcx9CulcW
 cJ9Y+Xn6tLT4RspV4R2DfbyrWdOBnrPMXNyj3FcIPMHEZofkz3xxTsXxB0NBSEg6m2KT
 8mnR5nfxQsvAsXAvTXwR6p7M3vXCWfWEpn/3ADrZntyMfMqgxC7ECFpTuOfLyK+Vwmy+
 6MFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793708816; x=1794313616;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TCnJMk99M2zpcBpoWpAWHUFicc2sVfch4ArOrNKM7uU=;
 b=MI/m+cp39+g6W4Fg8hrmkchck1NroA+pqgwI6S/uUfe8JVNEF5BOTB2zY86Rvw/IF+
 cVv3yObYidSEi717kObAAW584YZwMIzr0lR7WHhpoAOLfaE0n1OPiUO41dC6XqEKLjf3
 AWrti3YoS1tzkHCe0tVjZgGYxJMelQF/tw38bFSrV6C3XE7CRbi5seVnGBO9S2+5eVts
 O2PidBCGHyHPE27lJCxd5ESYJU2xDE0JEnIpuLIrIk3lYhJfaVE+CGRdxAzALLQImkFi
 1Djt4pHV4UVwxMgMayndh0HOGy7jp+c0WzefLdRhRrL9XhAuMh1oHW/FXZPZk4ySwaOV
 y/Fg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuaooJR8WqygaNmfQxj8gK9kpX0tQpz4jQvtOJlpsWl+ot3geuliZggwGxsPaAM5Gl43UxFJifvyFbb1+z@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8LYs/EH4mldWnNemcatp7urCDMLMhg2IRCVa9Uqwe3+aA3GGot
 xO0NyxTrfLMtjkfmV6WxJZiNk85+JMH9sTgpFAKewvpIXLYO9NOX8FXRe9jguKwXLnBlt25afHI
 3phNfd7BLmoycTkYwWrksJv+aIfxAMed4twJKecIqIy+OOIOJ78nAwAI5vY1c6/K3yDzT
X-Gm-Gg: AYBFou3LqYyfzwHxPvmrc09xDEQ5Lw2asIG4IRl18mthRPimKfzbPOOpYvqWhBZTXf0
 XnKvdr4ymcpoBhB5gNf920my54Vmvgr7sxda+VMWbqAeyQXibefH5twb7qEphNUCwRSmEF74lPl
 aocBhsLWKH+ESw/RXHun3W4zk5ftUsdV4G3zwHvAimYFlVpN0eQ7N11/Bmoo9SZp0DbLc41VT8n
 HAAyS1TED85y8lOzD6OUTGGshBzdIJh5iZdm4+JbOP1mx2fC/WhHLZdXeQVgkB/R7UvBq21aEmG
 cQlFxRADQ0JttNOBcaW1QeIXQiT6pJtj5TZc54gXkgYHpECTPKHk30YkDz72H+yGvmcnQ0+v7HF
 2G0gbJGnlqvkIth4whAHLAnR3Yc/xEaY4UmY/HqxAK8MXS71lS1TEjq0pmMVjiYLiu609yWDcwt
 5/xieKF/VoZS4BAPWjYIaOL7qI/wlgmEUMTVJevcFNFWo/r+mZta2aOOOIO/7b8wpiGwxVVpxb/
 /Kacv8kcjBPhcaYV7m24k0mOu5d+gQT8UyyNSxhEy8kZGwjhvzUGxxvVMcdpG7IA+CeDwhmZ7v2
 JRSJApzihebj7A9gkqw2NBqPGjUknEvCmrHxh9WViiJ+o0yuzLKZfg6niu4g60JjgnS1eiiqPE4
 4DZDaFKud0WYJsxTuhXOEy9p/PP2Ql0dP5HtVH7fDbTpgggL07NLvKhvud3bLcd7Q/WJRJSIgIP
 A7+K3KCHAvGJG+PA==
X-Received: by 2002:a05:600c:138c:b0:4a1:acaa:9d4c with SMTP id
 5b1f17b1804b1-4ac18c740c5mr283360035e9.25.1793708815714; 
 Tue, 03 Nov 2026 04:26:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab010a66sm76716235e9.13.2026.11.03.04.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:26:51 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 12:26:50 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5099b109d43664d5b83adfded6adfaf5ae9d608f
X-Gerrit-Change-Number: 2099
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2099?usp=email>
X-Gerrit-Commit: 684acb81aed7f04e64e3a7d03b33996db6cc560f
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 12:26:50 +0000
In-Reply-To: <gerrit.1793686929000.I5099b109d43664d5b83adfded6adfaf5ae9d608f@gerrit.openvpn.net>
References: <gerrit.1793686929000.I5099b109d43664d5b83adfded6adfaf5ae9d608f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjg2OTI5MDAwLkk1MDk5YjEwOWQ0MzY2NGQ1YjgzYWRmZGVkNmFkZmFmNWFlOWQ2MDhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b458183e6fc9b4cbfd76e9634ac7666807c08c11-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xODbS-000000003PO-1Kgs
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_mbedtls: wipe
 private key password buffer after use
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4945527917854095166=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4945527917854095166==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L0EvLfufk/A="; charset=UTF-8

--L0EvLfufk/A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2099?usp=3Demail )

Cha=
nge subject: ssl_mbedtls: wipe private key password buffer after use
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-=
Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
99?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5099b109=
d43664d5b83adfded6adfaf5ae9d608f
Gerrit-Change-Number: 2099
Gerrit-PatchSet=
: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Comment-Date: Tue, 03 Nov 2026 12:26:50 +0000
Gerrit-HasComments: No
G=
errit-Has-Labels: Yes

--L0EvLfufk/A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2099?usp=3Dem=
ail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2099?=
usp=3Demail">change 2099</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2099?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I5099b109d43664d5b83adfded6adfaf5ae9d608f </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 2099 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 12:26:50 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--L0EvLfufk/A=--


--===============4945527917854095166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4945527917854095166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4945527917854095166==--

