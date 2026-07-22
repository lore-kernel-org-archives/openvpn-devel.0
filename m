Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95196C44536
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ce9xMyUAB01N+qiv+Il+nEuTCnYeea9yrSaB1sMtZQA=; b=F4r0VKpBqsEWZyu1SP4O5TAV6v
	9mfhlnWwrW0xKfo5CDzNVjTzQXxA9AaEexsT0zJXCkCbYBmYrKXaw87WlOxSle96qfo0y5ujeR+Kf
	aoGj4+A0BFfWoYl/yZmuiQWMS73U536vKvWZP5msekPdwB9xyDDdqIoOJT6uz7HFoQz8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmXn0-0004jd-7V;
	Wed, 22 Jul 2026 14:19:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmXmz-0004jW-O8
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 14:19:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WhaJ/K7SMrHxCz3EYnf4nYs2x6xgHyXZzIoUkRLdmuI=; b=DK/3PPcCHz5lUCcHQcObXtK6IK
 UMPyD1XKFBxLjKGHx72Xnwp63gRyoBUpGwLZZgQjIt4GAlnMOaZRndvUvQKAs3MUr/eXYKRRQ93RZ
 J2xHc828oojf1r0uB5B1ie7i0UngwpcoSOgnW5xC3g38/ACFRiiqfdB3JLXCG+lSflGE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WhaJ/K7SMrHxCz3EYnf4nYs2x6xgHyXZzIoUkRLdmuI=; b=e
 wCsyxYuX/zwn+/GYjdNoRYudRy9mJBcrh3NCaCMLeJrzXTAIsSZNhG9xPQoOXBRuoNiUlvAHWxgJj
 zxfUnO4Y4T9HDI5dZtXaGgkIXW8Izc2mBSeOcbBUK94C3H2MSiIosyfFL2XYsyMudlfq6D6tWdxsR
 OiwQLhU66ZHsOer4=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmXmx-0001Ox-FS for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 14:19:14 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so27567175e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784729940; x=1785334740; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WhaJ/K7SMrHxCz3EYnf4nYs2x6xgHyXZzIoUkRLdmuI=;
 b=CxMjHPLQApzLYN620k7xVniKNG0XfKKyZSS45Z7Ya6BmQo5QP6uF6eV735dsyQ/S/b
 bIIVcVlM2YFKqLY8nXVecOkuLlDoXqoxF+Zsc0JclQm8Hvef5E9dkjC34FCXLjuNGvif
 DuCby3nDsstC7dgFNdICIZ5Oj6s8+kNce26pPTkCQDEID+0sckqNXFAmMGOKe0YzqNvb
 WK1AhnCkLuNwWK9hU1iH8V+nCrBKnP4r6LVRjqyHTQfOwaZZxA+KVwWjBwoUeteqD5Aq
 Hys9wjhrTg4MjdWEFDM//QzNv/u9aNKSgbXkioa7JRBZHtVWOgmm7N3vWfFpE9XO41rw
 suPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784729940; x=1785334740;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WhaJ/K7SMrHxCz3EYnf4nYs2x6xgHyXZzIoUkRLdmuI=;
 b=R6yshlgRYH7MH9Uqt7gL+6gZu3GBQr+M8JF884zcdvQjF4AQ9AByJzsaEL5Gkge0Oj
 6kTP9+IQtQWOzYbzmslJWVEve91QGnUMjMpNoh79eVwmqTEPZFZhtZXBb+d+pcjX2N60
 y3juOPbYSY9mAn3kpxZzfzHsYcHsXL82UHP0Ba/rW+CULtO+/5CNeKVBICk//4tFqsM6
 LccoECzmNQ53zfNL2knPirI7yRKSkjwz7yZNwd1c+Lbca6agEWkA/KJ2FtyT43MNyT1B
 czpqKd5Z0EkL//WXff/qoMxIaMk9/A4vlOZLJHi9yzKkJiUaCPvkkk1GtuXBt9Oz7cjU
 CZRw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrfVHdEZif3SJjG20uJns1DAL1mEoiHR3GVILEPJzq6mVRCwJb2mNIQZ3gjrn4m2xayJYkMvOTUpfHmNQ2y@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxE+CPFWg1770bOYIc0QskRZpmKWlqtBhA5ozUsr9/cGOmZNtb+
 ynHAENe3lzZOS8q8LgL36Cllo9kGNTxS382zKLZEcnKeJ606lqqpMj0x94qt976wsZb5vpzLpUH
 VfnytxtCRyyzcXzJ7L/RAWdGBmdh/RPygcyoItgpy17K5vAu4HRmFPH6MLqxevlgI/QDMTwCAz7
 NiljYu5w==
X-Gm-Gg: AR+sD126L5EtW1xxwMVNZPMpygomv2rt7Ymh9FmTR/x5sloYXDXrDewJm2ZqCESL9N2
 3F3SiWeN0DLtf7Pr3HqvvP8Y51PuYE0ZMWhkQv0KpSkydNY9J5gd5nG4lO7946jZJap2/z49xD/
 qY7foEJbS64/SH2TSWfTeCMf3nC7fDck6L26MyjyzjtjXtjx3Ep4CXtP6rIV9nk8IaDK/o/bIgr
 3vcTZ4tfFZAF3w0XjBo3eK8mq2C/I4WrcDGE5RTHfqzlkgK8mNOqQANddvYGn5RsOyWJyPi9dqg
 kvjHDPVPX2KHGg4VeNSIEqvETeNH9W82MSjrvqUittdJkkfBB7MDgI1OQCeAHA7GitgSOftCeVq
 1ZthcnpJbbWzQso43EQ+J5mnkKGxnCRnsXHw9bxI/XoH2fs6QNJTLcXEvszAXAImjzbDsXSqgOh
 dWz/IhldwmxZJdzbC6WEIOJV4cy7mGom1z+6oQkbltDyXYP5B9px6FJ+wBm29aOg8/2SNVlf4fj
 RE8x7qt0z4lkbbAbQvaG1Fq2D8g9DSZNO8yUhceK+k8h71Asohzr+RTEGeE5CHdwRf4
X-Received: by 2002:a05:600c:8010:b0:48f:e230:29f5 with SMTP id
 5b1f17b1804b1-4956a519015mr46138755e9.16.1784729939650; 
 Wed, 22 Jul 2026 07:18:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a509901sm132856835e9.8.2026.07.22.07.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 07:18:59 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 14:18:58 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
X-Gerrit-Change-Number: 1634
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1634?usp=email>
X-Gerrit-Commit: a2901aa47740548f95755da585d8bb26f97ba8ca
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 14:18:58 +0000
In-Reply-To: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
References: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzY4MDAzMDAwLkkwNzM3Yjc2OWU3OGU2ZDI3MWVjODc0Y2FkYjlmYmQ4MWJmZWZkZWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <53ac7421c8323be754ce4c4ceef8b639627c89dd-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmXmx-0001Ox-FS
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Only announce
 support push updates/IV_NCP when actually supporting it
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
 frank@lichtenheld.com, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2524198274313532780=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2524198274313532780==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XH6q3rSpFc8="; charset=UTF-8

--XH6q3rSpFc8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld=2E

plaisthos has=
 posted comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1634?usp=3Demail )

Change subject: Only announce suppor=
t push updates/IV_NCP when actually supporting it
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 8:

(1 comment)

File src/=
openvpn/ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634/comment/7e=
62779c_1ef9d35a?usp=3Demail :
PS7, Line 1997:         {
> NAK on that chang=
e, because it would lead to a setup with `--server` + `--push-peer-info` se=
nd out I [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1634?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
Gerrit-Change-Number: 1634=

Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Ger=
rit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: =
Wed, 22 Jul 2026 14:18:58 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: =
No
Comment-In-Reply-To: cron2 <gert@greenie=2Emuc=2Ede>

--XH6q3rSpFc8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld=2E </p>
<p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail">View Change</a></p><p>1 co=
mment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
634/comment/7e62779c_1ef9d35a?usp=3Demail">Patch Set #7, Line 1997:</a> <co=
de style=3D"font-family:monospace,monospace">        {</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">NAK on that change, because it would lead to a setup with `--server` + `-=
-push-peer-info` send out I [=E2=80=A6]</blockquote></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1634?usp=3Demail">change 1634</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1634?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1634 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none">=
 Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-=
Date: Wed, 22 Jul 2026 14:18:58 +0000 </div>
<div style=3D"display:none"> G=
errit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;ge=
rt@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--XH6q3rSpFc8=--


--===============2524198274313532780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2524198274313532780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2524198274313532780==--

