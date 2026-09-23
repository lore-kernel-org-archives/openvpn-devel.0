Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25226C9830B
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LnDf9L610PCFYsf8vZ4V5eO58h4lAW8SKzBz3SsATjw=; b=MOjUz390oeycoHuR8ng+G4y4oF
	HXgKitYwiM8KwIQM/ncXvPw9AbsWytduIemAyql3/WiiAPkXR3jro9wuUkeuFuKG4reuNVIMEl/YM
	E1OCNb/t1wxJS5lTR/u6LOfG6fI7LrBNzWlwZp41qfKpe/3PuQMnPIyOH1gBSPqqh85Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9OZc-0007zm-Ct;
	Wed, 23 Sep 2026 15:07:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9OZY-0007zd-AE
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 15:07:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=leUhFtvWVQoQc0vxrogYj/yBBp/ajM0aTMkXQtLUrYs=; b=Bnis9lBNShtMHGkYK17/haLvdC
 iT4hlcp1Ce9JwnDr9YL+hbQlSA3NVCu2/A4Hq7qb+2gMyVJCtcqsP74TRek5RViPXZfRPdqO+AZ00
 41O56ZBtN2uKFGrkVBx1n6qviXQFb2fxvRv5PILq80zXIUQnHxdt3VQRmkVKy8HGfzAo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=leUhFtvWVQoQc0vxrogYj/yBBp/ajM0aTMkXQtLUrYs=; b=Q
 jk7utZMiBQCNXw7EGe235Az9oRhTbE3sTH0LnBbtXHgJbBFPC9FpT/8VXGMTDmkFnW3PP5bH4M5qC
 HZ36dtLgoA1GUIz0VhiBZ5aGueeKRqIs5VIWZf/CKlp0N2fr+a4np3Ts6e+0V7fb2QHB7tSp1VJKL
 5HP72E6eDbI80Hzg=;
Received: from mail-wr2-f14.google.com ([74.125.225.78])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9OZU-0002z1-NS for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 15:07:47 +0000
Received: by mail-wr2-f14.google.com with SMTP id
 ffacd0b85a97d-482f6350f88so768009f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 08:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790176058; x=1790780858; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=leUhFtvWVQoQc0vxrogYj/yBBp/ajM0aTMkXQtLUrYs=;
 b=XHyiCwy0uJrCZyp3/D3t3asx0fqheuoKKwGPC2PMyNlgPjI9pmuASGq8joec10nLSA
 MUG5YISdlS8b96cNJMnhf3vY7+ZxKIgrhKat+li8emeF/cNEk1wFlt94FZJ+S0ce+WUk
 ZOs4/R50QhW54IyJ5cK+jzFR2023ebEjfSPiD08xqo0A75WlFyHR++zIie/2o5kkc72y
 sglghYty4AS2cAV/mKMrlDWaX+SF/vRztd3In+lcO15TM1yQDti92ccZAYuSSQyW/FWp
 q1bQN5qC4usC5HzmHk6MiajeMbGgyxQlRx8e6TYHoXrWosIpDYZPx0H6HRzQryE7YgIl
 9ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790176058; x=1790780858;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=leUhFtvWVQoQc0vxrogYj/yBBp/ajM0aTMkXQtLUrYs=;
 b=JXCH6bHu9o2yhWb+AxdDQW+6bxIcp4i8DJhjHx6yRv6L9C5zL7UFbatHCBhyiQRplu
 j0wuWgeFnWSBkSVSXXIugx2Yh1RiDSdM+D1Zd0EOVLUUlRjEvifKjn4R8zJSWVmqxJRd
 WV6Z2uHYRR1fkPP0y7NUuAgUGm1NpVGp42WZ2DhpNTdmqOXCRbgKZDfFbsFTPQxqHVPB
 M7eOT61tUjYavdi8ZlCo7NMytorW7jsvcjd4wBT3MMWNmB7spo7SXGsxTv98LkFQ+Xag
 fX6bf++aucVbyBA+KTjuOSCppwvcsKTlmQvOTRAuhuaS61GMpwBLkgb99e4XNDCgbtAQ
 RCKg==
X-Gm-Message-State: AFuF++luC68cQbQWUB97HWT+ZfZIEJMgUZlnWGepQ9kANGp6Z20Lc2gx
 CSkmlVlGfsm4ODQKnUigirJlieWjfhzaURhRMFELbglDy2piNXDJQHkoR5uyQBtdBGCHA16IDgM
 wTVMYnlS+EiYDU804K9z945z3RCyqE3Y1Keb/4oMYqhgq5I8DEn1dtr+KP3W6Yz0iicVr
X-Gm-Gg: AYBFou1iGZQAINpvyYfxvgFigX+G6Yjy1cYihqD/84sbLb1sdGHy+7bAhta9BnWwFum
 lWUS3Vqeyp80kuG5Dt3K1LvYe3dHIfJcZDh22QJ6gRzL1QcPW6hTIQp3Frgid2C8ZxoG6HClYV7
 E/4TWpfSDvP6PLao2qgDneYqBpHq+qpZ5wcTKUHM64EqimhR9VipoIoUoB8m5qj757Rkhde0+ya
 2SIDH7Ljk8W3Qx/BNlzgseqUXDRIVJU57+xFAPlKMec5a0gUgtO9WCiBMKQrrAh+DjbKasnFIrd
 8mgpK/BN+QkD414KNqfzM7YgS6NZkllLlH72VeW1xC0J/ankvhrzV3PAip/+T4WIJ478k76oewe
 0pp0ticzQxkbJ8zdLJ8SeLBOaRGAOaBMIvEKrjDA9vyLPvcd1LLsYOM59Sas1oRAXHniSgJo+gZ
 z6y3sSavEZiwaqo3sVulMJyvEULxIvjpKSqHLSRTiO1i6HSBXKi0+WC2yRMFljAJbC85F8yTtrf
 k1wNNmpVOFIrut/TK0aFr88444fO9h14gL52hM/YpXV0gczVhqpVCmdk4cMLNz2wdj7b7lmGLQc
 gky0EVD5dV3Vr5KiBEXRGgq6ykbUZGfOInhSng0HcHp/POKVpM58vUzMZEN3
X-Received: by 2002:a05:6000:2c02:b0:488:5535:415e with SMTP id
 ffacd0b85a97d-4886706f657mr5514473f8f.25.1790176057045; 
 Wed, 23 Sep 2026 08:07:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868486408sm6719209f8f.9.2026.09.23.08.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:07:36 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 15:07:34 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: 18f91033f3bc76f57a3140e8d76d71ab88f43331
X-Gerrit-Comment-Date: Wed, 23 Sep 2026 15:07:34 +0000
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7670f4153f609c3df3284fbc0c6dd715b66d6755-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9OZU-0002z1-NS
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change most
 ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL
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
Content-Type: multipart/mixed; boundary="===============2256790843647024342=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2256790843647024342==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="29YSbE1BpJc="; charset=UTF-8

--29YSbE1BpJc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1942?usp=3Demail )

Change subject: Change most ENABLE_DEBUG ifde=
fs to ifndef ENABLE_SMALL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 6: Code-Review-1

(2 comments)

File Changes=2Emd:=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942/comment/b437786f_8299eba1?=
usp=3Demail :
PS6, Line 29:   available and the verbose logging is now alwa=
ys included=2E
"always" should be "unless --enable-small is set" ?


File s=
rc/openvpn/forward=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942/com=
ment/1e4664df_294e51e5?usp=3Demail :
PS6, Line 78: #endif /* ifdef ENABLE_D=
EBUG */
wrong comment



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1942?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I3f96cd1c3488b558b8a597594d99edcba1214d27
Gerrit-Change-Number: 1942
Ger=
rit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 23 Sep 2026 15:07:34 +000=
0
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--29YSbE1BpJc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld has posted comments=
 on this change by plaisthos=2E</p><p>Patch set 6:<span style=3D"border-rad=
ius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-col=
or: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1942?usp=3Demail">View Change</a></p><p>2 comments:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File Changes=2Emd:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942/comment/b4377=
86f_8299eba1?usp=3Demail">Patch Set #6, Line 29:</a> <code style=3D"font-fa=
mily:monospace,monospace">  available and the verbose logging is now always=
 included=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">&quot;always&quot; should be &quot;unless --enable-=
small is set&quot; ?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File src/openvpn/forward=2Ec:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942/comment=
/1e4664df_294e51e5?usp=3Demail">Patch Set #6, Line 78:</a> <code style=3D"f=
ont-family:monospace,monospace">#endif /* ifdef ENABLE_DEBUG */</code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
wrong comment</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail">change 1942</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f96cd1c3488b558b=
8a597594d99edcba1214d27 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1942 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Wed, 23 Sep 2026 15:07:34 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes=
 </div>

</body></html>
--29YSbE1BpJc=--


--===============2256790843647024342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2256790843647024342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2256790843647024342==--

