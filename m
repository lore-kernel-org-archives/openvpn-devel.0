Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841D1C44536
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 11:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nO3GNqA0khmZMd0JSCRk1ozi8iDBhNi1Hanx2XG+rE4=; b=NJCgacHPyBzTiVlgF4Xso8924J
	vdEkrcUxVFUmHSoITF7VjbqI1YXSCcnW+p2SU2TOrLRmWl3vHeYrv3ITDiLfH8EOhI4vhr5O3OKcK
	nvCNFaWPGUHOQhUfHvsQEprx7KWy/Sb0I1lZpw5FjbQmTPIEOCMgMZmT6p1dOlVUnHi4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmUuw-0002Ig-Ub;
	Wed, 22 Jul 2026 11:15:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmUud-0002HO-QM
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 11:14:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/hBHGMzwonCDJ1WCUCBMEeiK6aP0M2Pj+HBv5m3Jilw=; b=fTZjtjtMsa8HyPpdhOHm7ogDMi
 KY98Ofg8H63A8WZsx92A9ApimucH6mvfTrmPEO0IaQZVzKKoANP0pLy8tSGK/9vtEDfeQrnAHwDo7
 l4268CX1mQLz+zbxqSWX4au8emWGQHLTaz3H1FZrFYkPIRP/jSxphcjCCFo3yaL2ghsU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/hBHGMzwonCDJ1WCUCBMEeiK6aP0M2Pj+HBv5m3Jilw=; b=m
 1bqomBgdg+Q1Dsv+aXmNQlHzVOb8ABrBaTTZiLwoa66oa3MuEjfRjsZr9jK2d3O6wt9TmHPhU3UFL
 mBoUBT60Q2FvNthHLGy5nuw8fB/HZzGrSbkVW9QrHhuPAYGgdU0IZfBXXEneyne0YO3il2/oPuEdy
 ze/eg/thZB3CLm7k=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmUuP-0001Be-4Z for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 11:14:44 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso45826975e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 04:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784718874; x=1785323674; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/hBHGMzwonCDJ1WCUCBMEeiK6aP0M2Pj+HBv5m3Jilw=;
 b=E81fv5AZfWYxjQgC7zxdjBYLsr4QciydpuiGIUPruRM02e9JJ4aYZIVJi6I6rt11cH
 gWNg3GjShjiH07GoLRjKB0cjjxs3RmEnkQkO4e2JOHb3Tg5W04FII3GMAWeP7l/Sl7ar
 DM+fPxvg3e+hEYRYdqAfwE1vrbINAzA7JfaWktVKMb2youAUgkFlfFbsjJuD7FEjBuGH
 4HUYPr69n0dLM8XJ16IpxaZrUMerOVHtJ8xiEFVGdVuqo5vSP57Ql6SFGxKfiftYOt1t
 89i6sHkYKsZmiYIs3Y3Rm3rhXrXd73KXBr64SvFsK9/RpyLMm2kSWl1WMXmkPFqrAEFr
 3LgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784718874; x=1785323674;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/hBHGMzwonCDJ1WCUCBMEeiK6aP0M2Pj+HBv5m3Jilw=;
 b=a1smFTTnzlHBmpOLlPKEYkHv4+zz1Jg7Yd62/cyxj2Wi+7u3Wmia597n5FTRgVERUo
 +gln7kIE22kvhCtQLbPfq45fNPxEfvC7kVB/6LgKfSlSM7y0av7Y4nhMSHjb5lvd2a1t
 sIcudOBQp4aYMY5G/kAl8V+3DBYlvT5/rFXbSb3iMU8t0YpY9Rt1x+e95K+hum8Ejf/C
 qwXrkKfLXPTA8WbQCa/8x+qf96R3NMOAty6179W2eHfvyOw9vkG3Rwbm7K2q+7mkevNE
 wYF9rzxouwHMfEmruVedAApRydXrXvjCjoZPA2mmbkGwYrmQnOuPiPla9bLITNOlMAv9
 UV7Q==
X-Gm-Message-State: AOJu0YzM3pHAC+8KYinp8DUpc3nywt4SWXu/THUZKdhmbgf8MxzqTM9u
 PQdvjyPBoXEatjlt5yaJEpzLws6f5xX0HujnjOmzNOf0chbPr5c/H/DfPxCvTqpyOaGrDRLGSOd
 YENr/gZt7d4EsmYmyZe3jEBz09QM1OeogLQ5lkjWro7tVGnCmUAYMA5og/ap5ulbXT5+5cBuOCT
 12o9SKWw==
X-Gm-Gg: AR+sD11MGOl3fezR4/CnLDfBfX/E1m2Xrv2I9oB7N+5l4TwSiRsLXuLCjGhdph+fflt
 Tx0gig9ZPGj8m1A93qOHNmU6o9Nv+jvFv3XEA8qqigkz60NaaC/60KqKXNFQtC0GGzYM9cz91qW
 YPRDPVVS6Grl+VYDzDHWtLo1oy3NFrOtwvD1qMjCDz8+K87zFAVLw5J7MJiZlmrLosxldLjBiQF
 ygO0FyW5qhHtnk5JxVfvh6tTb20mcUtjR4xwq/L6DhAAPBzrkUUV3SbQUB24yevJuuepsGlhI5n
 oCicxSfVJsEzvS3C6+MHBLJ57Ja2pwabu4DWaNN7pJQLkTtCoQngy906M9yfwftGE921MQJn0nB
 rVohSbh3PApSe4RfehXfhOyycE8nsSJ2mJBOciF+0Adx0XUYN4UkQesbJgG8VrQEqt8Et9BaKQt
 TQ4Hq0LTlKCu0DjbbSmPk/QgGX8ymo4JNTLUWuYFGRJWyPNAo8p1/2rOMuxmj0lNphx7Sex0qcl
 OGU2TO69gWVaeuxRkHqaC7NjNEwJBca+r+sgXuF8y9ENT4vstcfmAVAr6Xb42qPPvar
X-Received: by 2002:a05:600c:a010:b0:495:5365:c0d9 with SMTP id
 5b1f17b1804b1-4955365c1e7mr201960805e9.16.1784718874268; 
 Wed, 22 Jul 2026 04:14:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c635e5sm5245808f8f.26.2026.07.22.04.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 04:14:33 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 11:14:32 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e
X-Gerrit-Change-Number: 1799
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1799?usp=email>
X-Gerrit-Commit: 1ec92ed73b843478ad10411fc63aa76cc3f1b3a8
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 11:14:32 +0000
In-Reply-To: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
References: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzE4NDQ0MDAwLkkwZjU2Y2E2OWVmYWUwY2EzNzZlYjllYWUwNjRhODkzYzg3NjgxODhlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c2bca7a6dfea8fb07ca61a458ba3f63a0c6171a1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmUuP-0001Be-4Z
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove --providers
 option for Mbed TLS
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
 max@max-fillinger.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0463963891435812477=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0463963891435812477==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RDfnEB+aWoU="; charset=UTF-8

--RDfnEB+aWoU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF=2E

plaisthos has posted comment=
s on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/179=
9?usp=3Demail )

Change subject: Remove --providers option for Mbed TLS
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(=
1 comment)

Patchset:

PS1: 
Ignoring it and only print a warning was by de=
sign so you could share config files more easily between different TLS back=
ends=2E Is there a strong reason that you rather want to error here instead=
?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0f56ca69efae0ca=
376eb9eae064a893c8768188e
Gerrit-Change-Number: 1799
Gerrit-PatchSet: 1
Ger=
rit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>
Gerrit-Comm=
ent-Date: Wed, 22 Jul 2026 11:14:32 +0000
Gerrit-HasComments: Yes
Gerrit-Ha=
s-Labels: No

--RDfnEB+aWoU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1799?usp=3Demail">View Change</a></p><p>1 comment:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"=
><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?tab=3Dcomments&amp;usp=3Dem=
ail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Ignoring it and only print a warning was by des=
ign so you could share config files more easily between different TLS backe=
nds=2E Is there a strong reason that you rather want to error here instead?=
</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1799?usp=3Demail">change 1799</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I0f56ca69efae0ca376eb9eae064a8=
93c8768188e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1799 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D=
"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Comment-Date: Wed, 22 Jul 2026 11:14:32 +0=
000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--RDfnEB+aWoU=--


--===============0463963891435812477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0463963891435812477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0463963891435812477==--

