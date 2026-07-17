Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AE9C4451B
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fiOcKsboEzOg/ksS/TnG7KFNWTSGcupQgGb3Uzr5/KA=; b=ajdUellt6+UCPYZ95jFT1fOQpR
	lepwUE2zA/8/eHN++4Wtb6GJPHAMkj2w9+zMi1YvUmBZgV0sxvxpHKfm1wfWHstZL/Xra/IltGZyA
	sTzlxHYS5PaA54On++tyIUWKee2LjjpW1+K1jY9dmNhOuk3i9XhjzaGgOM5Fkkefcnq8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkjZ0-0002ok-BY;
	Fri, 17 Jul 2026 14:29:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkjYz-0002od-5z
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:29:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ujAiRQDsL2rbhjqAn6AcrigzAxdUQj2En2mAbnlmszg=; b=FaTsF6MHwmfctz9JpsMT4YrBTa
 Qf0EJ190UEB05BFd0bH3zzgcY73+RAPwuKPWHAkgzXcaRFF0C4L5zcOIDbbbp22U6T1KMW+hQsvAF
 Vb/SJJmMJb644W6J4vNN7Ee+xsmsm3THkmDszNNvRiKmfmrg+ApmUZfTJdEH2cpTaSdI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ujAiRQDsL2rbhjqAn6AcrigzAxdUQj2En2mAbnlmszg=; b=b
 8rH4u0BrEwYZPPxb0WMXWZJvtii8iGrNE02sprEPmpbpQTYQ3dyBoyd1SKJY0nboyOuyQgm6TOeTn
 w7wxOLP8Bhx6xZzfgCa39l+AjXdfdiGsvd2SYPQBkBSatNFR6dpgiu7mgOaoDyPWfN8tI31MYrn2z
 CM2XtQqF/pTEDEYU=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkjYx-0005B8-KC for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:29:17 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-495437bb891so11585455e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 07:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784298544; x=1784903344; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ujAiRQDsL2rbhjqAn6AcrigzAxdUQj2En2mAbnlmszg=;
 b=JXNGE+nIJM9oBb54YSjZRP5ei1+t1K1WDwQlbbnIgxjPjbLqjQpgrvAfy/eoUOB5zA
 Nwx5kOutBhawLkXmYaKwXfmXE22KR7ETiuTy64jrg7noYRYBlnr4rTob5Q8N4ShPkQKF
 DL0YvseflQvRcWUO4Sdn6xtzRv82FOWIUYqZ1Qa7cU2T820sUQWrfCeYh9mJe68dKhvT
 P/kU0VOCq4LnA3Wou7oU3RWdQU0M7BaZQ9RMUX0Z3PuC2CxJbdDJuGa5Ev5uDQV7gTmZ
 tAf3N2ZR8hLaeTN4DwKBWofKVWkE1Q7IpHUSYU27DGX07PuERex70JwV45Djg59GGBli
 GFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784298544; x=1784903344;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ujAiRQDsL2rbhjqAn6AcrigzAxdUQj2En2mAbnlmszg=;
 b=jMrKUpjwm75h8qBuRXO2bd8AEBncEWNs3uiXLqIde1PfE3tYvopLKRmC+K7kD1uXLW
 cqFw4qUaqE+wzT0VyQgchK/tSptLCimDvddisNuxp27wvOY6ijYm0KBLb1QYRMrt09RL
 lp7hZqlZmPOPqSPXxbwywaT3SzB6XONfHBdyxjZF4rY9YnuF04rB5J0wqyPf45sj2rJ0
 myl55TpkziIn5vMkhY8j09X+rf9BcVckcc+uyQvwrWMElKBFSNfoSD6G2ls2PGPyGKjx
 xNHjyyEBnElWFpzlyRNNlUvxBJ2o1xcwhO+F8jfkQ+BOHsYOroWL/nTpgwRH0txQB8Pz
 fkzA==
X-Gm-Message-State: AOJu0YwRYJ4jywdq5CpaaIy4gsBeUFJfNFyE6JFufIwyr8E1Y9p1KskW
 GB7bs0GL6n8gVnCN5xFH5CITIPJmtzPJrfONzVqQO+aGrFfnY957UmjjrfV8pGzQ9Zkm4vNXF9A
 gtzpJ3vw+XTv1cnyE+l1pHMdE0PHqfza/pC6wvxj/+qU8mBbNlSXSkjBTcfkA979MXbawzMSiEz
 cHxtbcdA==
X-Gm-Gg: AfdE7ckANAZt8pP5J4Ju8QPA/7//s79apfyGMxsblvUDAWb5vj6y0kFpj6SBzqExaQE
 fb587AqvfYaDxUfZWxDaeB8Ap39JqzpESENQmFywbjkfyCmfm2YTcVfHsKc3KL/VVEfmFEUi20h
 xIq46wUm3G4JEXQ+BxzApq/LsH/Lhpnl6WNh4hmri5dxRiNp6ag9zXXASUGIWMhVBTnl+hZVvns
 tJITH1XyIl3Zohxo24OJDug440HzQ4Va+F8jMKnAlokmJbjP/9mUjkGl6mMttoWVVewvlxNS5ru
 usEvJ2i8KNJ9O1Gbtwt/hHyij4PvlJpoYB7E04WYeHfbuO/P0TeefM/cFiYs41XyTkrgbFz8bTn
 oUviZmDtZ6QJoIjbXQQsYwrJivWYN+F9qRw+in0anzsS3m1rFEX1DjR5kkCBzQoxc4/MCRa+/zv
 M3wXAfmbQFL92AYWPv7WFybd22HQf2kq7YZPuUV1QVqZtzQq4SFXw4JYf52gDOKljikagUCUn4/
 tH0eu4umKkkosehvFvNL++riAZchPWyxKb6J0F+sUhySdgXDYRWWDtoop9y09CV/BOv
X-Received: by 2002:a05:600c:3113:b0:493:f478:4c71 with SMTP id
 5b1f17b1804b1-4954a323b14mr32644305e9.7.1784298543793; 
 Fri, 17 Jul 2026 07:29:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a35830sm58268455e9.3.2026.07.17.07.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 07:29:03 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 14:29:01 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 6e4746b5ad1e73d7bf95b650d780b7a07e7a7506
X-Gerrit-Comment-Date: Fri, 17 Jul 2026 14:29:01 +0000
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8ac6b294023a0c4bcc200b18d51c61c2918c846b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkjYx-0005B8-KC
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 dynamically allocated ctx
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
Content-Type: multipart/mixed; boundary="===============8230727532164177679=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8230727532164177679==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ipSuvbICbpU="; charset=UTF-8

--ipSuvbICbpU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1571?usp=3Demail )

Change subject: Change hash iv to a dynamical=
ly allocated ctx
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 10: Code-Review-1


-- 
To view, visit http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1571?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
Gerrit-Change-Numbe=
r: 1571
Gerrit-PatchSet: 10
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 17 Jul 2026=
 14:29:01 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--ipSuvbICbpU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 10:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><ul style=3D=
"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">change 1571</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: If47c7d920b2fa4047=
b7db03fcde821899839324d </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1571 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
=
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Fri, 17 Jul 2026 14:29:01 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes=
 </div>

</body></html>
--ipSuvbICbpU=--


--===============8230727532164177679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8230727532164177679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8230727532164177679==--

