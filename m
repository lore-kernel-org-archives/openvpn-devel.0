Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD4606A320
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CLVpJbpM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TiNRntnJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ihuBk6jR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WZFjThn0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iUrnf7ZYHK796xDSD+2l/ME83+bIcdZURr1sEqxnqYo=; b=CLVpJbpMXF3sTWmbLKPx9G/RaH
	3enncL7SuIGiCuDpKWLKwMR6dOerer71p66UVekMhCt47x5ppCJBv2jA1SXc3SnJQyB0MwdAU69wc
	dAyCu//BYJWEYAtA8sWNQEVeQ2Yj6kOfK7NXjCxKwjEdOYUxfPY+lUashmV1ZqShj3FY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTn97-000000000DL-21U4;
	Wed, 18 Nov 2026 21:24:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTn96-000000000DE-1z5m
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 21:24:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X8bC1AaVL41zJl+mIm+1D0Qoy33QZFhlxHKEsgqd2vk=; b=TiNRntnJQwvK/ukerrVsfRsgrc
 q54WdcfVEHV6/BEok1I5TN1Mu3yw4UNZFDMyQjLBYw578Dytk2U2IiRE4HLXgA17fqNg3KHl0vJNN
 Q0YAnObx+97Na/lbZjQGxxRlw263xtFf/+HcWNeJG00hLmxmwMi3UR4rhKOEnzEevpY8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X8bC1AaVL41zJl+mIm+1D0Qoy33QZFhlxHKEsgqd2vk=; b=ihuBk6jR9xjS9xxnsiejLQIb/Q
 LR+OPZ7iMrcm7G59U9yjiLlQOYv0/nX/UzK8VoSpsAqMoVC3Gcf7vMeV8BN+kaq3xmjzlMzsBpzWQ
 /RQp9yxs0v21zZ1L1tnNDzewJJO89d5DEjtaH0rl1v3N3aXR68G2i1zNP1F6StizLjjs=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTn95-000000002Rm-1FUR for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 21:24:48 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb64c99d2fso17509865e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 13:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795037081; x=1795641881; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X8bC1AaVL41zJl+mIm+1D0Qoy33QZFhlxHKEsgqd2vk=;
 b=WZFjThn0nNoNURlPhFB9ug3yq8wLZaRj2R6LTJ5mhm0r0av9+66l6LiVx57coAKPjj
 1aXndg51WomuftQh9OXiYWkarKJ7NSQbOpErQB2lqELik2TBuFoLsXPqY5KAC6A6bsKb
 kjx6GZleve6679042brFjov/sRiplbLBwdj07oyiXe8CZUNTD45caF1/pj2TuzZmsKwl
 Cmtivq6cldqCvQRtjeT66gK4sItpQLMYS0pVBaqxsxfw3naCcObFBPRwnGxksP73jbfK
 FiFWlvJaU8lvGhu8M89BHPsXjF2Lh8d/viKrSFSCe/d3TotGDrKoGpFUhNoZkgVZXG25
 Y0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795037081; x=1795641881;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=X8bC1AaVL41zJl+mIm+1D0Qoy33QZFhlxHKEsgqd2vk=;
 b=Nr/J9Dnc6RMoYq3PWCDWCOgvga03XpHv+ntL45VxuL5tl3Ayc84ldCK0hLuuKrujuV
 g8skvHZka6AJs9MhKfun7D23ABKu4l0cHgrt7dalOUZNd9TgxjwVLvk+Pr3taIdKp5FG
 ZvNhwGV+R587Z5f+SSz3e6eU9EhnFI8wsUcOuo3aCqx8IDywxo1jj+Wf/T+ezFBNdjEP
 8JmeTa4EGQ88IWAiedPhmJ94o7BbdvNm54RC/VBNcySv6EkJNZ3yTudczdAP/Mm1Jw0v
 qVYHIbHLzXqicf4jQdigZwhnqe/kUJHW2GQsevNnPImn+IZhODHadTLR0NFIgf99IGvk
 8tLw==
X-Forwarded-Encrypted: i=1;
 AL+hErHqZ/vnK5QU4AxHfPG43n1s28qKhWiNjBFjcF8fzJFwARvMxY7SEX+6NOvSqju1utdVZWl2wFuwTOV+rjiS@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8PPoJJ9lpWE3gtus7Go5SpPtJlR2YxQHqhLt9kqkl7Ct5rM46+
 WvN/jZrdJKVAZ7ypO+c356o9wwPQQbA+VVGHWcGPMbbW9c2qrdO/PX+g8FWtRGnGF0EYrNhk+fe
 kOZYbsWvr4jANjkSuqLru4r2xyXPyNf8GHNiuI4Xd75aG3YQNM6+woDBo2L3K5hWEkMnd
X-Gm-Gg: AYBFou2N40L2ShzkmKsQ4AlSx0MZ07h//LB2VE/ZPBs/9fx4xmDPBGIGEyc4v8XrpIb
 GjeDPrPG+Nvqu1/wT5e8TgKJ6vxjpV3/S+fWmrmEJMsmB2MIlmnYTldyqXNrCg9vfiRVQdEq3pm
 w76izsSJtzwFRZLRjdmU5oOawDFJqCI3LExL3Z0U/msg9dLh64vqQlH5AiI2p27YwexyIq7SpOo
 XiiZTQlNuu5+ap66gHKhLTpfy272gaxydKOELoIUbMdEElvjWwcbuNJF/D9dEvZRRJXSIndGEZw
 1z/TjSAZ+yX+/81OSjb40hWXb/EHVRouSysSiHJVy7RowkYGkRC/IClALGLL2kxtl6uRKPaVX3j
 4Blo+S//Iz70vTNc3zSrMh9JM/Yc3dkSTPHunkPz2DRzFJvCnKHeMS2LnPv+M3YwqTtxsSu+SVO
 tL7HunrtE8HRs3Au8QhgsflHFUyj237s4IKda/WMpVbIj4zfrB0BMDgHU9dzf/x0/xcI5riu2Qk
 xvD2ySg16ljGCw62oZfuVjJLnaP57T52BWma5O9dYthPxfw+DpscNrMth04Al+eWimJEKO7a1mS
 avahKt8JEt70YmkeN9sILJTURNeONj9Klqvm38zIVWQM0hKXCtFoMha0pfgH+9CxwhORucWdNBd
 JRrsuNBNGCb1qhKej6q4CaZwHYrP0RwIpD5IHBlEFYytiI0Zc+mEC/ZB9Rpmxa6x/4haGp8LH/k
 RnIFeMJJoMKZpk5rI=
X-Received: by 2002:a05:600c:c086:b0:4bb:69d8:3e92 with SMTP id
 5b1f17b1804b1-4bb7da57425mr57368995e9.29.1795037080582; 
 Wed, 18 Nov 2026 13:24:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c37fsm6840856f8f.18.2026.11.18.13.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 13:24:39 -0800 (PST)
X-Google-Original-From: "Name of user not set (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 21:24:39 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
X-Gerrit-Change-Number: 2175
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2175?usp=email>
X-Gerrit-Commit: 2a6784b2e2ae52b53379945fc5a88fb33a30142d
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 21:24:39 +0000
In-Reply-To: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
References: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzk1MTg2MDAwLkkyMzBiM2IyNDgzZTE1NDc3YjE3OWIyNzdkYzhmN2M5MWM1M2ZhMGMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ee0b1776844601383dc3c5a82c8d8539d0d7ca48-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTn95-000000002Rm-1FUR
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 tls_pre_decrypt_extract_session_id and pre_decrypt_find_session
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Name of user not set \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Name of user not set \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6434153028262539714=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6434153028262539714==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sBbnBolGfpQ="; charset=UTF-8

--sBbnBolGfpQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Name of user not set #1000056 has posted comments on this change by Arne Sc=
hwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail )

C=
hange subject: Extract tls_pre_decrypt_extract_session_id and pre_decrypt_f=
ind_session
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 5: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2175?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
Gerrit-Change-Number: 21=
75
Gerrit-PatchSet: 5
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: Name of user not set #1000056
Gerrit-Reviewer: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Comment-Date: Wed, 18 Nov 2026 21:24:39=
 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--sBbnBolGfpQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Name of user not =
set #1000056 has posted comments on this change by Arne Schwabe=2E</p><p>Pa=
tch set 5:<span style=3D"border-radius: 3px; display: inline-block; margin:=
 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail">V=
iew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3D=
email">change 2175</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2175?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2175 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Name of user not set #1000056 </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Wed, 18 Nov 2026 21:24:39 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:no=
ne"> Gerrit-Has-Labels: Yes </div>

</body></html>
--sBbnBolGfpQ=--


--===============6434153028262539714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6434153028262539714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6434153028262539714==--

