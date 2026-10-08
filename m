Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6677CA600B
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 11:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aKVoSVGdHzJE7J1N5tV+vEAbvFaKQ1hVnPKteU8VrbE=; b=bBJ07/tMxHdgxrvfU62VRf2RTr
	zqDemZQblZHbv1QRPCbWxWqrVQo/efdBcuqs0XBSGFuCLGPdayUFjaO7aURKdBF6B1wv1P10dqeqY
	fyQxu5ciAwmCj9OkIXr+2gwyxxNnCvqIE7dUO2qMg3jrSL4ExKls0kChVVI3cHlfJlMQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEm9W-0001LT-CO;
	Thu, 08 Oct 2026 11:19:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEm9V-0001LM-7I
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 11:19:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Wx1Jney+SoG8iZL9zDkUzRo+f2bfbPzrnDUhT17/jPg=; b=Q7Uk52j0gbP5UQKjYw7EWvvJSd
 C/wXfk6P4MCafAEHeKn0/DGHqez7KhK7DfegMwaWmBjNmEHCpiZQW4VgvLioGnOPUZlR43JBcTzOw
 v8ucwDjUidUHepdbQqlGK5SreW3I8oyCGq2yRIF8pvvskU5s/x4jVzT96PlEC11X6wsg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Wx1Jney+SoG8iZL9zDkUzRo+f2bfbPzrnDUhT17/jPg=; b=W
 qFOL5cmKyUcwLKbzo9Nf7DZfOg+va2+xotJqiiBMR36utqwv3i70SsISzs/j3jGcSIjMWuazYJjWb
 p3v6Bz/VI9UBuZYhORw4TjuYNjcgSbmfJBdJILXqaVMPPcE0imIHTyfw6Ix38UrjVx6iz9yPjzS0T
 /ZqoBQIqDFyJWYYw=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEm9U-0007Kd-8r for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 11:19:09 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so2582205f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 04:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791458342; x=1792063142; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Wx1Jney+SoG8iZL9zDkUzRo+f2bfbPzrnDUhT17/jPg=;
 b=YaC8zYEhV3FdFo1yBVbCQud0yEVPpVlsFQDiXpRso7m2TeueekP3YbQ70E3RD9WxsV
 8DXb7fuA/89f4wDeUvtUXT0jaxyMert4gp3WPOWoRaeXJuXaer4m3EMsPADN7mgppPKh
 c9XwwytMCtJc2YQMsjVazYLAr0lk7jb5PnZNynwUikz/lpT4S73BlDlGmil5Hp22bQGr
 JLp5eLJ3nWI9gx2nCuszAYIQM8k7osLKHsE1lp3qn3zOQGtMswBcSaJ24exQcMmUMrvQ
 yXGunPJuD+ooHoS1zChrbpJtdcDRR5CQKLCHyG6V4UpuP5Di3NUYdeCwZlBS+NEhn4yY
 tQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791458342; x=1792063142;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Wx1Jney+SoG8iZL9zDkUzRo+f2bfbPzrnDUhT17/jPg=;
 b=qMu8VWRb2VQSWwvaUmEIRBUTh0rQ3aoDxssRHcxRjlRa1UMJeL4PRegBZdOpG4QrmK
 YpUY0q3X4c7jpnEAAPd9agvkDcQWvfu0ISIdewlZoh8MjYn/hmsJ2bkBTnKojxXVM0nR
 dyFi+N7HKuHefL75/+fQnlEneDph3oqTnyJbXejcq6HVesxxJEWTH8BF7Vb0AUJ+Nbr4
 ZHeGIi0vXKQYjtELhLU3OlZ2GXqbZ9KnPJDD9OYfotT9CY9Z3+eEqpQGjRvQu3W9WJGK
 PRgTG4I/+o3pH8+BYr5KVY2bqKfZ0D0gBXcaHgRjXQyMlwzsWFGQMNYrMDfQXWtulv+7
 UAkg==
X-Forwarded-Encrypted: i=1;
 AKwUvByyoO2D/q21f39zWRk/bgfMcwiwVbHc36ThvopOGjlXNFDmPtoypuLcdm2uEmchUGMtGs8j7speQ+l4991W@lists.sourceforge.net
X-Gm-Message-State: AFuF++nHf5celOuUD/HRCw+Gpnet1I9/deJs7lo+Sx8N2WrpvQehnGme
 0VOQHR0BeNfvkJOEq+M2oYPZVaRgVAAoVy/g7mBvrP64EKekQ48KSv3Z0Gfopmun/rE8r3c8sPX
 U9M8YEZo296VkI43MPl/LlWQKz9u5q1s/6IY0T1I+JZFS66T2ezl1E5FSwNKHGkg4rHSF/L/g4L
 wUUwEnuQ==
X-Gm-Gg: AYBFou2ih4vUjcX+wBNFqRUqn9/V1+fxqMmBpNk3T1oEHl7n8AXmx5Cg8vbbPAfGnxf
 OiElDFj4n49HZk5BFiq7lxUUFOOGuNsqFcTbp4XyAvJmIaMrqhmT1COYqk478sRjK2IPI4KMk4U
 6cFveICpDID122xUUyCj/zuWG2U8lulSyW2kvUSpv1Vyw/Q4YT2fasVVhfkEOUreJSTkE5E+wqd
 OUsbuxaRACu2WoAcSzCWlkUV55SzPr8eML2Lu74J5vWvEAMArZpdikcCqrcaJSJV8+8zK5pI/ty
 U0akXWVRleE+XGlLaPMTZ1PHTjiD1MgnA21JUaMhtK/QMlbg4cp+V2Fqa+UEVQS/HUTDJfEUcYR
 /6P+7bnygqG6SyelDxNcLlEfInKkgvgqUhSm4gXqw2ygJZg5XHjMiwmRaUjSFnJiFDwEUrcKPjG
 GUU249nUqIiYaC14KqvShd+ohbD7mUasUX9CxYxe9OOOxU5by+r5HdsDz40YIAclH8VX6G+HjVF
 VtmYT+tNR5SlbtfLH56nI40v671KaRs3Z2gKbGry7drHv7heRK+GbT/kYWTuLT53rW9e2y8ntst
 AHgJ9l3n1qqrDFPt+Qav0hv1zSmhsh+V91oUBs6Pdkov7YkAkIUDb/J+jKeO
X-Received: by 2002:a05:600c:190e:b0:4a1:722a:d2a3 with SMTP id
 5b1f17b1804b1-4a180455768mr91625445e9.23.1791458341411; 
 Thu, 08 Oct 2026 04:19:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843dbc6bsm69294405e9.11.2026.10.08.04.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 04:19:00 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 8 Oct 2026 11:18:58 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8a5349f66f5c1b52889c2f593e01c21824f937f0
X-Gerrit-Change-Number: 1986
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1986?usp=email>
X-Gerrit-Commit: 5c5bfa88beb26e2e2993f82af002a91330b8c15c
X-Gerrit-Comment-Date: Thu, 8 Oct 2026 11:18:58 +0000
In-Reply-To: <gerrit.1791458155000.I8a5349f66f5c1b52889c2f593e01c21824f937f0@gerrit.openvpn.net>
References: <gerrit.1791458155000.I8a5349f66f5c1b52889c2f593e01c21824f937f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNDU4MTU1MDAwLkk4YTUzNDlmNjZmNWMxYjUyODg5YzJmNTkzZTAxYzIxODI0ZjkzN2YwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eae49fa7a346a6a03790ba0f135ced765454451d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEm9U-0007Kd-8r
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: config.h.cmake.in:
 Add missing HAVE_STRTOK_R
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
Content-Type: multipart/mixed; boundary="===============7844938805019580904=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7844938805019580904==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j3OK3dZxuFY="; charset=UTF-8

--j3OK3dZxuFY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1986?usp=3Demail )

Change=
 subject: config=2Eh=2Ecmake=2Ein: Add missing HAVE_STRTOK_R
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1986?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8a5349f66f5c1b=
52889c2f593e01c21824f937f0
Gerrit-Change-Number: 1986
Gerrit-PatchSet: 1
Ge=
rrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Co=
mment-Date: Thu, 08 Oct 2026 11:18:58 +0000
Gerrit-HasComments: No
Gerrit-H=
as-Labels: Yes

--j3OK3dZxuFY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1986?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1986?usp=
=3Demail">change 1986</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1986?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I8a5349f66f5c1b52889c2f593e01c21824f937f0 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1986 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Thu, 08 Oct 2026 11:18:58 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--j3OK3dZxuFY=--


--===============7844938805019580904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7844938805019580904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7844938805019580904==--

