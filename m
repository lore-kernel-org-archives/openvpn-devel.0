Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24F7606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 03:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iwICychm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LJ+wF53A;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OeQUbGoV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HosD0t9C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UOGsISWd5hcfyXb9my9x1Avrg5G51b8gOZmJ47jP6S0=; b=iwICychmu9Bc6ZbUAQ8tEKGC36
	Yzp5P2ZtzwhZMhTCAxF7gCPMIvV8dUynsUfGwmjX6n4AtlTM5gvf73hZf7JXmVZU1n9HMmGKO5DcB
	ohBlWlz18GBFdlosKjM8o6KY9q2g96qICDnDxhpZlAWyZ6l4KfqpL81TfqOuZcgHXieY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWmNX-000000001O2-0U8B;
	Fri, 27 Nov 2026 03:12:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWmNV-000000001Nl-1vDA
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 03:12:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lywtdB+iUPRqK/OStZcassfLVXSkjbzb7BruPWTSWmU=; b=LJ+wF53AfWM0vE8qOMWv8gH+Ba
 oCJh0T7OBCWgPVbOQy5obdJY9cLW9QuKpUqdoCC3TBiRS21u3vRtvZM8BN/3DURJ2lPdFGiuZyR5f
 Kn+2BJBQVbr3xFhVX5hm0xHOEGv5R8BPRSGJZTQHJaAFkoAPM13BZTO2+u5kuLS3+rDo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lywtdB+iUPRqK/OStZcassfLVXSkjbzb7BruPWTSWmU=; b=OeQUbGoV1OkiXip9HypGQ/jhL6
 jiMvCCNUOicHDQ/5smmLQXcB1wPTyXd1Jh82c+b1bIFHRCnJnT5j7GyS2qSKfIS6Y49FTuQo3MoaH
 ulTx6x7lIS28WIRZDh7WAFc5DgjpWdoYti7euhIV3Ywb5KUQI5cmgytOAnhrmgaPqCHY=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWmNS-000000006sl-0GWP for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 03:11:59 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so66858365e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 19:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795749111; x=1796353911; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lywtdB+iUPRqK/OStZcassfLVXSkjbzb7BruPWTSWmU=;
 b=HosD0t9Cc9k5BY8Xq3UVOFSggU1FCg+OQ2gsKQD5cub7GkWaIOuhfhIBxaCBkrwjM0
 ySVffDkJl6E5cmVK5MFK6yYQdwqmup9ZpkiAdSP3fH4dIusn18KIEQJ8H3eK92XqnVoD
 CP0zLEcTKKi/Dg5vR8IGTm1v0sbfOOsaLVNnGtpErEQsCGXrhql8owUcssqwlqbpD+Za
 daKZrkOjPHEdsFOo0RGLNd1ZTZjc/aTTM3pK9Ub/vcP8iWeQQDBP8hjuTbaqI9T8GaxE
 eBvgTNQ9sJgUamlbE4TjRJm07+tLPfwKfUzbCUysD69qAHKsr2TWXad538ocUW5Uldjz
 sioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795749111; x=1796353911;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lywtdB+iUPRqK/OStZcassfLVXSkjbzb7BruPWTSWmU=;
 b=AzNlcWN7txwqGJug2hySGAuou46V7gxoCwXpnWyWJZFaAhhkMC/Tuq4kZApXT3BgY/
 rMru468gr/iGLhdv+EMQ3gNFTNYxHo/6LW39IMFWeyUToA2Ith3hKmYs38IPtJylX4jo
 ANFO4B6QakcTyTLHg34pzWBnIN/sgRR8oAcvEWbDqFlPhS9UIGetzq0O0S/J7zs4C6Hw
 nu2XaxPgyuzYsJSrk75SFwQeEUmaE09p0vBYWyyzNlmOspJD5FvrZUSxb1gIT6zx4h1a
 trWTJ4O9Xecym2Q0kMZogDDMxQhtzembuAHXQKmgtI1Hqnvbp09b7w5XedWWLEtpHQnJ
 e1RQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFnO5wq+kNXYbKSN2wgzpu4VnMIwttrMQm0TGH5rJARQuyh/frSJBnktH+tDb/28LJGI9ge9PKbggxZ5Uus@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8rzs1UzqJuVRSP4Z5y5ZaHvLLK2drAC7GNvVH9wHdf36slnMTO
 QnruUbLej/fauB2V6i9Ury56eKR7KCJ4F/5zUKBXlU2nQD4GoiscU0IN/N0JxZonjVB2UsUurVI
 QoqyAjCVkv7goEGF6nc/k7P8Vo4ZYUD+jzuA3KtaydsPnoPOc/FFcJeCwYQMtXHnAZgcx
X-Gm-Gg: AZFdTZf+zmWxc9Oq8qAq8IrqYDgkiKXP2Nn+yUi4az4nuWRpZxn2qQWaQhbBW5cIGu7
 zKJrew/WWiKnaNfpawsRZc3xtE7+hqMv7ZOwkQylNwcRCLEimlXJfSeba9GKh7lfzu289Fp19lD
 SrGVCBqeXf4b8I+J5f/AquT5VBsC1Tql2kOeHoyMpvyqbIJrzdwQPvqSejkUJ9FX9+jhVv6nRXK
 sVhXuQt0sT5EGEACodvzH41EkM5WDWLB+bTvBz5DbfnsWoEDdGlVm1hjfRYp6yUsg1OhbBfF10W
 2W0aMlCOJ7uanF1NUOab74v90Yw4yH8Zjeea0eWsKH/DYJTgmlks57lR4b6G7vka71Q4y6cOsVm
 w4DEP4XDi6H1Wa8Y1NJbpFcLSBMi5AcMJqh1Wrh83Qsr+79EMXG8GVDe7+yCWZXxujq1LnmPxgw
 utufWbzhBMalRRIZOjybgrVFjdjVApg5DqLyGbt7uSWZj6JzywWqsLsHC7n6eKoPb4HTSoCOOyx
 ql5CTRzp2B5bOwcsmcH0aJ/7TFCcLglbhWez12FWWBfLS8YuNyMKJpwFawdlMMBT/tFmzMN4Mrx
 rS26W6j8HAHWIgz5ETttuDJgiH+Ik+y/PFWSY8Ofy4yOILdpFYBkbuxxn19U/6cOlfQpz42x1A2
 reXdo3V1VI2XBbHUWUrqvlfoDZqcwF2uqJZsY66D6EDZX4BFOM+dho1x90ak4MLRzZfu5f/B6GX
 /Bna5OlSrsTBMfqYI=
X-Received: by 2002:a05:600c:5303:b0:4ba:495c:2f5d with SMTP id
 5b1f17b1804b1-4bb8880767amr419091335e9.9.1795749111405; 
 Thu, 26 Nov 2026 19:11:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm907831475e9.13.2026.11.26.19.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 19:11:51 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 03:11:48 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6
X-Gerrit-Change-Number: 1981
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1981?usp=email>
X-Gerrit-Commit: 02e1598c759109ca5a6c7176aeb6bf03ecbf0cb3
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 03:11:48 +0000
In-Reply-To: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
References: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg2NDUyMDAwLkkwMDUxZWZmZTdmMDYzNmUzMDU1N2Q5Y2U5MmM1MGM0NTgwMDJmOWU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <84b9d67a92801c3675c778c70607f98b4915d73e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWmNS-000000006sl-0GWP
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: dco: detect local
 kernel capabilities through netlink policies
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, antonio@mandelbit.com
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2554044775757302575=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2554044775757302575==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8C6O2/AilDY="; charset=UTF-8

--8C6O2/AilDY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Ralf=
 Lici=2E

Gianmarco De Gregori has posted comments on this change by Gianma=
rco De Gregori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3De=
mail )

Change subject: dco: detect local kernel capabilities through netli=
nk policies
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 4:

(1 comment)

File src/openvpn/dco_linux=2Ec:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/dc469251_17046ab6?usp=3Demail :
P=
S2, Line 113: /* one row per capability; a row on a command of its own cost=
s one more dump */
> as discussed=2E let's go back to the full dump so we a=
void any ambiguity=2E
Done



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1981?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6
Gerrit-Change-Number:=
 1981
Gerrit-PatchSet: 4
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mand=
elbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: Antonio Quartulli=
 <antonio@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerri=
t-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 27 Nov =
2026 03:11:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-I=
n-Reply-To: Ralf Lici <ralf@mandelbit=2Ecom>
Comment-In-Reply-To: Antonio Q=
uartulli <antonio@mandelbit=2Ecom>
Comment-In-Reply-To: Gianmarco De Gregor=
i <gianmarco@mandelbit=2Ecom>

--8C6O2/AilDY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Ralf Lici=2E </p>
<p=
>Gianmarco De Gregori has posted comments on this change by Gianmarco De Gr=
egori=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?u=
sp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/d=
co_linux=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/dc469251_17046ab6?=
usp=3Demail">Patch Set #2, Line 113:</a> <code style=3D"font-family:monospa=
ce,monospace">/* one row per capability; a row on a command of its own cost=
s one more dump */</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">as discussed=2E let&#39;s go back =
to the full dump so we avoid any ambiguity=2E</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li=
></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1981?usp=3Demail">change 1981</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I0051effe7f0636e30557d9ce92c50c4580=
02f9e6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1981 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Fri, 27 Nov 2026 03:11:48 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-L=
abels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Ralf Lic=
i &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-=
In-Reply-To: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div =
style=3D"display:none"> Comment-In-Reply-To: Gianmarco De Gregori &lt;gianm=
arco@mandelbit=2Ecom&gt; </div>

</body></html>
--8C6O2/AilDY=--


--===============2554044775757302575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2554044775757302575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2554044775757302575==--

