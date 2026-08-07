Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F52C2A09B
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kj+Sz6HXsotcKnpebrNwA/cTR3fsLcEIjuwh5dSH8D8=; b=TRfetgHeS+ojXFHxW3X9zp7ms7
	uvn/p56Iarrdk8aL6peFrRj4L4eqlsCcYzDnKUaYMx0Zxh3Rb3jXuzYVr3IjHvj6INndOormbdW8T
	Bt4So+En+nbmaWFmAnagX+L3TEjBA+N2YWyrAvHm3DJfqpvnOWzBrOsi7DtBDh9SSc7w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsMn4-00045B-6g;
	Fri, 07 Aug 2026 15:47:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsMn3-000454-JD
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:47:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HfR+jxwIwCVlfQarDfu7UgQv9mePcSLPIu+qjqxZ3fc=; b=G3C2GGSjW+xtHtKP2fIco/A1D+
 VWmt0k3Vr64meSjczunntbmZgZxZMHkbkjs/AvjhWNtrRTOngPVc0O+U/r1TweFstSWT6sXXD/mRH
 NKNa3MueR3g3uXUsKu1pbpsKv0Ietwp7j14ECY70YCNwmO46BI3b1wklbwac6jouD65A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HfR+jxwIwCVlfQarDfu7UgQv9mePcSLPIu+qjqxZ3fc=; b=P
 BAXKMl9ltNxdAOn+P1SDlKjavDyc6qhrEOemb2Nb0Ue2WhmZ0ri7H5vLHsipj2uMgTVwMlx58tAJd
 PdGFWYR6ehbFyk+hjG2o/EcNTs5BvNpqsKxjtidz1hO3snF9XSGvfB6zBazhflh14mB97PAB6SeKe
 GDA0N9bc5z0i4fw4=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsMn5-000574-EI for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:47:21 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47362928f65so2950859f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786117633; x=1786722433; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HfR+jxwIwCVlfQarDfu7UgQv9mePcSLPIu+qjqxZ3fc=;
 b=FdGVhwNNMIJYJxcYSo3Cz+GiRAxMGQZADPsNh9ywBhPKX7KWEi3d2j7hCLrBPQwDAB
 Iutr9/YEW1J7T6ASULKKYkGolsrbVZU+RUy2zgwf8uCcuchwDBIg9GHb2yzR+D2XQ6nP
 ynQNae0g0PFtIXgdAHUw7JgYGGgevYRQSfWb8EKpQJkF5szkUI1NhSQkhTuZ5Cj4PQVZ
 aLDAHxLLXZ7Vd3f1i/Z2Gfqnfu6VxmZHxHwBciJ4n25qPMsHz0WVZxHd3kMbNp4EX6RX
 VmKGM0VfD1oJKTJ0f6FI6yzd4vazmGaGfzfW9iZVfcZvM7PsxRzsTA2TPkyzE6sghM7S
 NGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786117633; x=1786722433;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HfR+jxwIwCVlfQarDfu7UgQv9mePcSLPIu+qjqxZ3fc=;
 b=ACIYDbEhl7BU6b5+857ku1DLHUuO/nP+SFI2S8iG+I9mFRLuKtaw+llzPXNI7TJCqt
 9WHqfc/x9V4zK4yUHLd3EY4GxQojdkjrLfd1KlYioGcUI3AxTjmGtuIrrQ7kiAwsqwUK
 hdN4dPzO6zCzLroByMg5Xb+fiZanZ3U9ApcSQwT7yokMAAtLLUDk+Vf4nLSDGGqnq6LL
 m6PM7V6EA1lt3La934pPiXnkfOx3edK1Twg57GcrkzWmIcSXE9KUSS+DWZVuySorj3v+
 /G6/vuruF/T/zHkX+I9abb0EVzfZTCwbjXJFx9CzNMDXSV3QNdgFF0W9O2dGrIsMB6fH
 Z0KA==
X-Gm-Message-State: AOJu0YwlgICHAezMSw5dsDqZNcwqrYAlT0Q/Q4gFFpaQ/ilhEuAEHz4m
 h/9ZnWpeb84CGGSOmVp7JL/WogOS6qwbSCVHsrzMIWfchKvhsbEuty0fALaFx8c1q8f989/9DKI
 Yb1yQIF4Z7T1LiI0XLy20tI+8VW3ul3AJxHF1LzKlI3kHwJcz5rthODA1Tq+C3IRXyfzkdWFwuU
 VsZdIQZg==
X-Gm-Gg: AR+sD110Uy3pB2Mb1fLIwEQibTfdef7src89P+QyIeLfza2oJTTPDVi/+h1UvOg7crl
 HLZx0//HqN6Szx+UBpYrkSXQRwZYl/5o86U5tl7rOEJK9ewAqT2Sh5nUDGGn8o2Ue9x8c/u1p4x
 h7CI/U6wdiWCjLyLn5oUeWKvj2l3zNLtJlfEQVwWRPeUcQqbjHJF+P5Rqv9zv+m2CqQQm8e6+yz
 OkaLjMOuP6vAbLHL0TuVyQoEr+0gQqAukIbbUg7KvMDdbnNDez/qpeJ6cBn5RZEyvwz0EXIF1Xw
 iftIyM8omqJmxxv/mzG3+9QojCqfmKTwGQOZrAYk70s8xzBARXFv0YZZYZwP/Ch+TJBGz6w2PuX
 q2XIqxal2XWIkFCDUL9tKT5kZ9jKqIwJZh5gS9jhJTp19Lhu4968jPPbZCRMjh4IvVXUoSO94jR
 vWNarmThxjSwk5Zerq735ZPqg6pGDHgkWGt1Q6958yfNSlLMnFFqtAbnF1iB1pbjkY0PwEa/ldR
 hNeCBVOQBvLNzgKH5FuSUPDjqBYoGsLD05r+0ZjWKoKHv6kqMlv5jPAYBZ2z0Hz1+Ejm0LY171L
 55C8cF0+8EuHPFTZLeP8bTyx1rPQDpjot8rWcnBaCpHNTJ6//0n9RwJ+2nNqDg==
X-Received: by 2002:a05:600c:6052:b0:495:6396:8b67 with SMTP id
 5b1f17b1804b1-4994e70ae8dmr256441745e9.4.1786107123010; 
 Fri, 07 Aug 2026 05:52:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995420c68fsm137581075e9.1.2026.08.07.05.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 05:52:02 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 7 Aug 2026 12:52:00 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I4920318ac537064508eee3ca449d48de76c2ea5d
X-Gerrit-Change-Number: 1582
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1582?usp=email>
X-Gerrit-Commit: 64bcf0ad06bbab1f862c749cb3b9947162f67291
X-Gerrit-Comment-Date: Fri, 7 Aug 2026 12:52:00 +0000
In-Reply-To: <gerrit.1773842036000.I4920318ac537064508eee3ca449d48de76c2ea5d@gerrit.openvpn.net>
References: <gerrit.1773842036000.I4920318ac537064508eee3ca449d48de76c2ea5d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczODQyMDM2MDAwLkk0OTIwMzE4YWM1MzcwNjQ1MDhlZWUzY2E0NDlkNDhkZTc2YzJlYTVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dae1eeb2740c591fe5c65d5af61fc467ef94bd39-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsMn5-000574-EI
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove
 --with-mem-check=dmalloc
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
Content-Type: multipart/mixed; boundary="===============8924351357685501902=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8924351357685501902==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HzpOHXVClqk="; charset=UTF-8

--HzpOHXVClqk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1582?usp=3Demail )

Change subject: Remove --with-mem-check=3D=
dmalloc
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 2: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1582?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I4920318ac537064508eee3ca449d48de76c2ea5d
Gerrit-Change-Number: 1582
Ge=
rrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 07 Aug 2026 12:52:00 +00=
00
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--HzpOHXVClqk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 2:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1582?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1582?usp=3Demail">change 1582</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1582?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4920318ac53706=
4508eee3ca449d48de76c2ea5d </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1582 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div=
>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Fri, 07 Aug 2026 12:52:00 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--HzpOHXVClqk=--


--===============8924351357685501902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8924351357685501902==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8924351357685501902==--

