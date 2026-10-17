Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C30CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1LaVznrFXVSQ6yjjrWIUq0gUOgff0o5hmbYbwL1KvTI=; b=Eq6XtxNbTLs6kgbrhyaX8MyjPu
	YF+o1hUdd5FliQzLLE54l2RNwexwMLe44S9Rj19nDr7WsCYMCRHuKWvSPSjA1LxsQCj1P47QTrFuS
	gyaD36dy10TyU05+Uj14kAp7jHXQcZONKybfzrgdsj/DkScNoC3S0gJRi1A4jaXDXUlw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIA1Y-0004XY-SK;
	Sat, 17 Oct 2026 19:24:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIA1X-0004XP-I3
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 19:24:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Lwk2pPyMUMvTFFBvlKFOiGjSxizJqximO8Ns8saPyKc=; b=AhRZn9DyI0WxEjEotNEQpTopY8
 T2GsOmTvZ36F3WRDr9Bjd+/GRUS0EOH4NDp/kkIV07/G0IgreP09LKXP8AJoBJStmnM8cD+rMRJXh
 OIaMz0Jr8OR9qF5BrS1M1Ckrai2u/KGSmTR9zvpDheiRMrvQD2Yr2TL6nUEgyaVcnSAU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Lwk2pPyMUMvTFFBvlKFOiGjSxizJqximO8Ns8saPyKc=; b=g
 gHoLPxEpa1XpTbo05jyVeAlIfbrP/wCuaGsATgmANkmD3ktaPJ69+7WJYdanDnntFWwVUaRNJfVnC
 E18EFiaKgwFuXfdnDvYtArtnBL4JOWo/RK4VnI+ubWFNYvYwcbm4G6RiJ+0e/Cx1NhYsZ/gqldjtp
 v1zcj+mKRMNQqCOA=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIA1X-00013J-Js for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 19:24:56 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so500418f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 12:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792265089; x=1792869889; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Lwk2pPyMUMvTFFBvlKFOiGjSxizJqximO8Ns8saPyKc=;
 b=SGwkLCrXztZUQ7OMbwJ/yf3fEjcmhYD373oDplbkT43VE84VWUz6svHA9le4Jj+pzR
 1RB6ELi3ce8OaRdYXzCIaCWwixo98anHUUmxe92R6hbzp1C6MOe80uerCbWIWwpH3vSV
 btfxpm2+E22rtdspWN0cBXs4VNtP77vU0Kk1sszpzlGq0HYw8ppeCUINfsdBPuLdKvQ5
 bH8wN2Z9ClSAE4V4byMAgEYiYhsi8m+8SzT42npBqRjzluLO47A0VG2MI+hEtsQOdTp0
 lXWgZkEjLLmJ8EOqcuSbiFue17jQN9h+4FQD3VVhsql6G0F8AAjy89lMNYICbD9TiCGD
 AM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792265089; x=1792869889;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Lwk2pPyMUMvTFFBvlKFOiGjSxizJqximO8Ns8saPyKc=;
 b=Iqn/FEOqB9zAAFT2JpwO/kDfQUXACBRizFAL//WQ9Q1PC3ykIzAT7MrYgxr+EoMk8Q
 cF7JcEe4WMLGGMMRt/8toxe3dooCSosO3m8nS1sEvAFvfIQdGSd++quXX56qZZ7KqJtG
 +1Op4sEMeWJ/XPhTB5MoDnbO603rMWhE6U8hvsai2s8hha9NCyYfELPY5PfriPTCuQrP
 ulMyFFNw9RkP3g5ogdWbVHbJdxRifL0q3zUIhiF0UUtxuq5KPhA4VuFEj3TDqydJus08
 QRUjRSt1NiykGA99yhpq2nk+IDPhHqccobhtyd+N7Dl1trnl8A+pjflxYOPsBRCtK9LF
 ZL+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbQMb80vqUagkBNSEXV4MfXcs59AG/F1h+viq+XAGtsv0Z+8NczEI7ITRFs4FI7Qqc1gcDZO21XNxE3wnS@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLAmrr9Dif5/jw35vy0i6itjeMzzUH5VVbZtE/TDcwzOGCxdvDV
 Yc79vLtVnLOpB1+G1edMkuoZG4uIs16Tqg1+wUze+ULLbYgktquQrbARHhqFRiDRU1oJ0hchCKj
 sGhRwz/OAh7jtV6GbN/vusi65V9nvTXIcRv0WAp89giwsPYLUzNC/YQ3VRRl82I6Qfc1/
X-Gm-Gg: AYBFou3U942HDNlgC5i18EoPChvzxzCUl2ODz3rIvdBvC453XjaSeSQJGZ3jQiJzG51
 SJ8UB4zWvWMNubYN7Leyk0xILQUOnkntksRIKoMQ8CiJis+XP34Qh7Cc/NkYFgYS3I7NnTaRFzl
 dOkRzHeKaWfjDkot8nYW9cBc8N53Km/+8Rhptuoa00XzNkJv3G/wTB9a9RYcjIu/lp03dDWeO52
 0a0NJhVITXIYzfxs8aWRQc19G/WprSNn2r0mqFr+OKaE6YT4aaThQrPM4eGm+bEDZvoqOqtDIZf
 y5eBn5Nzx1JVk71e2OFdscXofexWzyhD29TzMt9mUeMl+dck9iCxIRxsBsl12k2v+shUXxiKxoD
 HaiugZoe+jMFGq2+inAyB1ACQ5LFYTYWytMcQPY8vkfsjOLnAoW/9qmHPKVbIjjPqjPPVdp1Dn5
 NyDn4c4LOXz7X17K47Pa7kTdegBWVEpkDDkuS8IjJtbiOK+63as/ZePUnGqbZzF/7Tj834PpZJ3
 rl7/wvAzhr0kzYFm+cVDX0BNYkRI8oUhpI5L/rHr3XSANv/Kdcu2BvhXs8DQphkLkm6Bt7F8fs7
 MO/Qg8iOecaayhw40y31qf4lbJMJfnv3C3vKZUOGWVCz54txQ5WNxGbSLM6h
X-Received: by 2002:a05:600c:1d06:b0:49f:ce73:5e94 with SMTP id
 5b1f17b1804b1-4a1d7616d1emr69213085e9.34.1792265088856; 
 Sat, 17 Oct 2026 12:24:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce02d619sm98377535e9.3.2026.10.17.12.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 12:24:48 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 19:24:46 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0245175f2884d56838990f53cee6381b981b79c1
X-Gerrit-Change-Number: 2004
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2004?usp=email>
X-Gerrit-Commit: a7b30d8b6adb00967b43c8c5c5036db3d0cbbd86
X-Gerrit-Comment-Date: Sat, 17 Oct 2026 19:24:46 +0000
In-Reply-To: <gerrit.1792255622000.I0245175f2884d56838990f53cee6381b981b79c1@gerrit.openvpn.net>
References: <gerrit.1792255622000.I0245175f2884d56838990f53cee6381b981b79c1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLkkwMjQ1MTc1ZjI4ODRkNTY4Mzg5OTBmNTNjZWU2MzgxYjk4MWI3OWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <88432f4aeb66686db56990205b9e973da9897d05-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIA1X-00013J-Js
Subject: [Openvpn-devel] [S] Change in openvpn[master]: misc: Avoid
 conversion warnings in parse_auth_challenge
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8034664725413348020=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8034664725413348020==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yqJRzOxUwqA="; charset=UTF-8

--yqJRzOxUwqA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2004?usp=3Demail )

Change=
 subject: misc: Avoid conversion warnings in parse_auth_challenge
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew+2

(1 comment)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2004/comment/88ff60fe_cbbd97ab?usp=3Demail :
PS1, Line 9: Make sure we=
 have a sane length and convert it int=2E
Typo: "convert it to int"=2E



-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2004?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0245175f2884d56838=
990f53cee6381b981b79c1
Gerrit-Change-Number: 2004
Gerrit-PatchSet: 1
Gerrit=
-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Commen=
t-Date: Sat, 17 Oct 2026 19:24:46 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: Yes

--yqJRzOxUwqA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2004?usp=3Demail=
">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2004/comment/88ff60fe_cbbd97ab?usp=3Demail">Patch Set #1=
, Line 9:</a> <code style=3D"font-family:monospace,monospace">Make sure we =
have a sane length and convert it int=2E</code></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Typo: &quot;convert it =
to int&quot;=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2004?usp=3Demail">change 2004</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2004?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0245175f2884=
d56838990f53cee6381b981b79c1 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2004 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: S=
at, 17 Oct 2026 19:24:46 +0000 </div>
<div style=3D"display:none"> Gerrit-H=
asComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--yqJRzOxUwqA=--


--===============8034664725413348020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8034664725413348020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8034664725413348020==--

