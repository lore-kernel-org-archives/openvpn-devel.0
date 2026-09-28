Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA517CA5FA2
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k99tu2gGDTxvVGsa/BcLGl+PAGuT1/JNEy3CC5b/DoQ=; b=m+m46VoRYqYSnWWQhb/LmpjzVl
	Cnuflh/5kDHlQ4UNC2SUHF+XzQrX1mY/2wO86n0dwDuv9fYzhABURUbH4u74UheX+dTZKziQqr/bx
	lC/DlE/CuBcE1jfLaoRzgFT9VGwadYOI08KMuFYFsT9zM1WI4Xjj1CDTzqv8oh+hBJ7A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBDYj-0007Bu-1P;
	Mon, 28 Sep 2026 15:46:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBDYe-0007BY-Ca
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 15:46:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mIo/9Zu9KmNEw+mds9aUB9l88MFHblufSUxfGHcSxEg=; b=URlrEzDMAM7W8F6ZqMd/HV13/i
 vqos6PsV5FHp7N+Jgl6+Ya3qhsmexueuyTHuDYVIu2x770R7E/X31XKtOacGzahiOeRsPk0oafoPh
 I/3cRieHTa/v8cvhgyLNXok366a6tehw1zkY7XvEmVDBUrdAzKDdPP0UeqXP3DYDcgeg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mIo/9Zu9KmNEw+mds9aUB9l88MFHblufSUxfGHcSxEg=; b=B
 mJl5H24Klk//+a/+oL9zp2+JtRk4en5VKgaz78iIAj1L8MGuJ84J7560f87Tc9ItPXTN6fVse5OjU
 j8O+FflNtGNQIWhifTGnDHWgEMzHFb+IfcPqEmv0JqNRGz+yQkPbhjYfGVPPRqPdPg7Q2nWzIcG5y
 WoiLJu5k9e3uq3oY=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBDYe-0005tn-6I for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 15:46:25 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so23654225e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 08:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790610378; x=1791215178; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mIo/9Zu9KmNEw+mds9aUB9l88MFHblufSUxfGHcSxEg=;
 b=JQQf4vItiy/KqA7xuV0Om6B99F+6o/xVDAbXHFgB+FP4XcER6Me0c0Pq/Sh0NRt+cA
 LNOijpWUgC9fJcv32M/maoMSkK2XrLHR1xmB1D6z2Pj0tHIypeQZIQPy4XmPqbjvnJAR
 Qg2j09tIsIQlFRWRg1xIiICirCv8QvTl0QQKukBEAOQZEkoCWuD/l45lD9an79lJ+9EO
 fF3rokQCesJSNJ9DkY6jZpKP3rBhONJuwyeu8rI+U2kXG/KQzObBQ7rN0aQz9EXXVXGz
 E27ImzQwU4P/ERGkMl/D1qRRWmIgwep5ltOxB3X0aC/U+w7eN/WLIMwr+2fo01tk3BEt
 ppWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790610378; x=1791215178;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mIo/9Zu9KmNEw+mds9aUB9l88MFHblufSUxfGHcSxEg=;
 b=OVLCXnQ7zFPksU9PUP6eyuRa6gaxipMVXj1e+J9e8gIXz0bWwThxFvHYp7iNZrt7Jz
 37h1ZtdCi5zyf1oL8gXwdGuJj/uVw8n0KOcJVoEDi3lZaHFi9Bc1tQYnx49Gnpc94EpD
 5Bbmb7+1ZfcLgY/d4c4UpY1Jke0UkyQwCnaeFf4KpFWMsPTLAz1vJjIAFXChoj3IK3UB
 kJ2WC+uxkID/q/g5pAbshV3s/BOfD2g1DR+LRtI91ibuz6Pk82lYpv+W198XN6AMGaVM
 51gxv4v55yCMr+FQdVop9LUpqZmz/BGYNc97rIx/CfbV+p8Np3Inv+zjzO8R36Jdial0
 iPAA==
X-Forwarded-Encrypted: i=1;
 AKwUvByA/+wJo/ajm2WZFeQXWLuZFVek/1oaDl5xPwOnh/qP6Mzjr6/7O/Xi0xp1wWhFD+Gq/p/9AykngJrlLFz8@lists.sourceforge.net
X-Gm-Message-State: AFuF++m0cjQS3U713uqD/rfFfSrgqfmVycm8592gFJGQn2XJ3uYgnpgK
 2DvbnufScs/Z7/5EdCkPbE24lFObE5Fgkacs7hQCu4Sfcs2jZmH/WoKsqCnUKduEfVgZGT+60dl
 bFeApJXDfwKRj2/CyKHr1/JA1D07UfGulKFf3HrjOXxj2DOm6/K+o9OBNrcMtGmUrg5u6H68NzK
 vSq2l4sg==
X-Gm-Gg: AYBFou1cxMEreqXmxx3ZiA42QTaQM1f9MOyHS9EKVerYBxGJdHU3BB3VlkNGYVt6Xig
 69GF1FKKlUJgQQTRcFPL0hpwdg0fhgBmbxbRNmXu/kv7Z9hIssIsTKwSeXqVcxUZhhdqwWPovEO
 f0bgQ5uoIjiebea67GSMRP+j+s4gvhPejvpTpI8fyitd74C3ixG0N6vjD3LVqizMNIq8nqD19J+
 gdR3vHvC1dlRHXLeTil7PmwYSn/mDOTWdC7kjnyqB8zsziMdJSpcgPlOavoev3Qinc1KiUfuzwa
 rY0uOnMY5uc3skDDq8X3A8YpkHMdkj63r4k/WGG032X7x0olmnos3U6a0rJGpDwfbRnr4fAifIN
 GNkGRGt5GczawnLaPX8T2LIjopz32huzMXBBjnBgxlCp6QsrnmAV2V9qnN4T7Vy+MTb671FNmxD
 +vZMOHpHyDs2VysqhE4NW7r+FnF9cHyDu8G8LNDQGhNez4OsnH8vHAHcwdO3AbmXWHI5MnjvhnR
 6ImtlsnTaXmVjLNehWR8G6CjSyQi/y1we5emmg2TZEzMgFveFxn30GLJUhQdXNLkIP9rdsNmnrI
 T7hAPAFf2jdFfEWWyPfuKYsFm9fMA9up5tbQTh72dxMCHXM85JucVb5HfVOO
X-Received: by 2002:a05:600c:4e12:b0:49d:1842:f001 with SMTP id
 5b1f17b1804b1-49fe66b6e0emr242813685e9.14.1790610377408; 
 Mon, 28 Sep 2026 08:46:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf869c4sm1442415e9.2.2026.09.28.08.46.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:46:16 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 15:46:13 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: 8872a126dbfe67e9889b38ebd0bc287af8c8b280
X-Gerrit-Comment-Date: Mon, 28 Sep 2026 15:46:13 +0000
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dd092cc419cabf7adccfc37cf7a21881b3d2a244-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBDYe-0005tn-6I
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0772556512214608147=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0772556512214608147==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yc+/S22U0hQ="; charset=UTF-8

--yc+/S22U0hQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1663?usp=3Demail )

Change subject: Remove instances =
of constParameterPointer cppcheck warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 26:

(1 comment)

This change is=
 ready for review=2E

Patchset:

PS26: 
Back to enabled now that is properl=
y rebased (needed to redo all the suppressions)



-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
Gerr=
it-Change-Number: 1663
Gerrit-PatchSet: 26
Gerrit-Owner: flichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: razvanc <razva=
nc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Comment-Date: Mon, 28 Sep 2026 15:46:13 +0000
Gerrit-HasComments: Ye=
s
Gerrit-Has-Labels: No

--yc+/S22U0hQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>flichtenheld has posted=
 comments on this change by flichtenheld=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?tab=3Dcomments=
&amp;usp=3Demail">Patch Set #26:</a> </p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Back to enabled now that is prope=
rly rebased (needed to redo all the suppressions)</p></li></ul></li></ul><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?u=
sp=3Demail">change 1663</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1663?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1663 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 26 </div>
<div style=3D"display:none"> Gerrit-O=
wner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon=
, 28 Sep 2026 15:46:13 +0000 </div>
<div style=3D"display:none"> Gerrit-Has=
Comments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </d=
iv>

</body></html>
--yc+/S22U0hQ=--


--===============0772556512214608147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0772556512214608147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0772556512214608147==--

