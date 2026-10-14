Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAFCCC6B2A
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h/8sGdBSnAZQsqHJco+4XWgbJklyWqVhP0XDrFv/fI0=; b=LgMnq1QtStx2g0EYn1vyzX8Yb0
	54A2UZjBlUbtYznE69p1IsZqwEKZYDJaTECrbftz/HIjTUYXkG5niCKMEl1b6y237qoFbX1Unn8X+
	xrx26zKVnROs1ImQ8F5x5Zwulf2XbWCv887w7Xb3KiMiSqcCdvcU8umPVN7fycY0bIv8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGyhK-0002Bw-7p;
	Wed, 14 Oct 2026 13:07:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGyhI-0002Bq-Pq
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 13:07:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=RUH69cQ5T+PGEiD4Qx2k/wUUoYmL1X5TeBsdhtUC2kk=; b=IoBoUtzu8Dj6l217rD4+Wq7XM1
 3oBPqoefzMNEs6Qdkp/xeNUQSr78s/5La/QFoT2AyxGpMydjSgEdjxFdL3bKmlsjIEZjYoJAsK6dC
 VA3VQEXj6NZU6tBME2rS1J44HZJFoDVfqXWFM1X/QEn2O2H6/OkuI/72bgcedTiXw5ZM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RUH69cQ5T+PGEiD4Qx2k/wUUoYmL1X5TeBsdhtUC2kk=; b=V
 ZNumHVnvGlEHFTEdV9ZUzB4vS30K/s5t+LTMLCS6IYgnYyLIGvJJKOwCu4ust/2iq1GggQl6IHF8m
 Dyu4yt+THncO0P8FZPq+aXuQ/5KvbrV0sQMgoMitkl2ub0pzPrA3q89Pygz28oEvmsbbL5PGICoyt
 e+o0xtAmgUVTQ8VU=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGyhG-000729-HM for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 13:07:09 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso11074865e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 06:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791983220; x=1792588020; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RUH69cQ5T+PGEiD4Qx2k/wUUoYmL1X5TeBsdhtUC2kk=;
 b=DzAXscAh9S4ZwdyGU8CVN31PgOGBEnwN1fxMf83xUkRCxZcBkus/ynPEpsCBVC9HED
 GkVUesnEAHMI2YuR11r5RgXLx9WmTjf9D1VnIFGJfb46sLXJEK84t/anMt3zg8UxgBb0
 hVOrIZKssLnfdWuam2xaxczgMOLBsE/NYo5aiKKJYDPp2zKrSXSuHpuRU4FsZzSDrEHj
 XVGT7YOk2k6WYVoeJlzl7Un7eWWdzR2/q9R9iLiONUKl7xKsVQ8WH71rvlQEw9ULLeQP
 a1XyvehCPJJk0LRk15ul/DFOVSAse9f2AeiszwIRvyBf0SFKmypwZ2oXjPwfXfX1e+Xn
 wj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791983220; x=1792588020;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RUH69cQ5T+PGEiD4Qx2k/wUUoYmL1X5TeBsdhtUC2kk=;
 b=ZBxNj3/IdVrFIyHcJ1U0hs5gfT8R7ynxgrC5WmadMMDioNwyWlr+H0aSNCrq+7dqTe
 eR92GX8pZsskL6r85flWkLFmxLLCW9ChVb4srpqAoGLie77N1T/j6YjCX8/L90vE4b3C
 K5dvqGBNCygMURd957Jn8DrOFeB5np6wSEfXhGPoXfKIUBKEKe3vPHvEWz2ySxiogBlh
 cIf+YRmIDOCCxDs/z+axTnXTZzt9rJ+L28dYE1Mw4g+LqjUtuqaWCtWk+oe7lt5oARHx
 eYGpOcQpihfdJBHdQadYJbN8cIpqHEMJbuAsVMYtI9c4b76Jj61dP+Orib7Cb+apxZ8j
 07Kg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjLrd01gx4+M4mmHqGHoO29PkGJKdKfXqXYh4kuzFgdB1Udf0OdcV2otiPK0qCLTd5cx5UTKRxoUX9G27H@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL4cRBN7UMaICFJI/MOhThA20LaeQ8A3JSK9YeyK1b390QIhUxX
 kjEtOjKVjjhid2hcx0NhPdt9YSLVxSLqmlfNToEtbaJIYe/243Huu53t3P6Md3C6JpmjF/G/PZ9
 sY6eG+V2FbuyPD1Bs8NL6SKC1X8JaGEr8a8kJMuIivyO4ogvfPhRRKt9qo87YnVn0fDYPuFz1nj
 pO+3AU+w==
X-Gm-Gg: AYBFou3azM+wA4Vvd808EcZ1nVqwGgEKLi1bCqtY1gMJ7o/G77//cFDEuge1sMamcd5
 68OjxK3axw1qC7+VGe+wEQMh9f+qGPvHZ5c8b/S09rP7IYyVznm1+AIlKtj6Kn7UYoj1jM0szWK
 l8tyjp7563+yE9tk04lb16IUC+GyLuow40Xu0HoaQKHb+5mCiwjhpbO7bXf9CBXmbQc53I3bHEi
 rIyjrZAId9b8WMbkig4cSrXk3RwMNxRrBDYO9gNX+XQAJf0+iBy57trds2Fy3IGmXStLO/ZwZVI
 /bzwv/NixYHFn17XdOCPwmftaT4YifAulqVOtUkRtV6KX4QnWEnyExTEP7kZdHxKXOOfOqro+m9
 DB5ECaHneEEqnRRT0wpmelNBa5QTqKCf2LU/2W+i6SvUyFFLduFT7PutzHZbwCig0XnwQGFOtlL
 ziCrg912BJD4Co2qodaJREYDVudxFuNLhEfKj4pgMLAr9ah1qw7UVKMFL3h5sC2jv5AQyhYV6Q+
 uR8l1UMXGUasCionroj9n+g18Kip/YDd068Ebd5ruUhO7XG4mG3tLZBIPgoetse7h0NOmC2yuak
 NU3AUVTRcby95pXUA/BWC/i1Nuu+TkoZ6pslH5pvKfrgsmONECfapoF4GxsFCE/iRNu0m14=
X-Received: by 2002:a05:600c:3e11:b0:4a1:6a10:4dc8 with SMTP id
 5b1f17b1804b1-4a18e4a90cfmr306495685e9.28.1791983219897; 
 Wed, 14 Oct 2026 06:06:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b2ec47fcsm55694155e9.1.2026.10.14.06.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 06:06:59 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 13:06:57 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icf004ddddb9b3a5fbfa0f4c6179c27bc1d306351
X-Gerrit-Change-Number: 1988
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1988?usp=email>
X-Gerrit-Commit: 831e15c489240f4f6abdea1868e5650ad95369f7
X-Gerrit-Comment-Date: Wed, 14 Oct 2026 13:06:57 +0000
In-Reply-To: <gerrit.1791551948000.Icf004ddddb9b3a5fbfa0f4c6179c27bc1d306351@gerrit.openvpn.net>
References: <gerrit.1791551948000.Icf004ddddb9b3a5fbfa0f4c6179c27bc1d306351@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNTUxOTQ4MDAwLkljZjAwNGRkZGRiOWIzYTVmYmZhMGY0YzYxNzljMjdiYzFkMzA2MzUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e1aa868a1319d808538ee2fe24d7a7be7fd8de81-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGyhG-000729-HM
Subject: [Openvpn-devel] [XL] Change in openvpn[release/2.7]: Convert
 Changes.rst to Markdown (2.7)
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6526181218993887070=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6526181218993887070==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="47DEgT0mFBU="; charset=UTF-8

--47DEgT0mFBU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1988?usp=3Demail )

Change=
 subject: Convert Changes=2Erst to Markdown (2=2E7)
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(2 comments)

File =
Changes=2Emd:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1988/comment/4ed0=
e1c2_cd1ec623?usp=3Demail :
PS1, Line 185:    - fix by introducing route fl=
ags and restraining the check on them)
> Might want to move `-` on the line=
 above so it doesn't become a sub-bullet point=2E
Done


https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1988/comment/214a371d_630bae6c?usp=3Demail :
PS1, =
Line 272:   - this was off by 4, for connections openvpn 2=2E7+ to openvpn =
2=2E7+,
> I think this will end up being a nested sub-bullet=2E [=E2=80=A6]=

Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1988=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
=
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: Icf0=
04ddddb9b3a5fbfa0f4c6179c27bc1d306351
Gerrit-Change-Number: 1988
Gerrit-Pat=
chSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-R=
eviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Comment-Date: Wed, 14 Oct 2026 13:06:57 +0000
Gerrit-HasComments:=
 Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razva=
nc@mailbox=2Eorg>

--47DEgT0mFBU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1988?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File Changes=2Emd:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1988/comment/4ed0e1c2_cd1ec623?usp=3Demail">Patch Set #1=
, Line 185:</a> <code style=3D"font-family:monospace,monospace">   - fix by=
 introducing route flags and restraining the check on them)</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">Might want to move `-` on the line above so it doesn&#39;t become a =
sub-bullet point=2E</blockquote></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1988/comment/214a371d_630bae6c?usp=3Demail=
">Patch Set #1, Line 272:</a> <code style=3D"font-family:monospace,monospac=
e">  - this was off by 4, for connections openvpn 2=2E7+ to openvpn 2=2E7+,=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">I think this will end up being a nested sub-bullet=
=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1988?usp=3Demail"=
>change 1988</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
88?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: Icf004ddddb9b3a5fbfa0f4c6179c27bc1d306351 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1988 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Comment-Date: Wed, 14 Oct 2026 13:06:57 +0000 </div>
<div st=
yle=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In=
-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</bod=
y></html>
--47DEgT0mFBU=--


--===============6526181218993887070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6526181218993887070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6526181218993887070==--

