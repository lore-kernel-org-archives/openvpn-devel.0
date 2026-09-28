Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DC2CA5FA2
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/dH7LET3eZ12ITQUp6B3NtfRphAOwQRs9Wyg8uxgW3w=; b=egdMimInEBUxkzIxakhzQtEveu
	4kdN6YxhmdhOayHxQq1MqEYHY3NK7383rWxsaXd7MXuHjlSMqJKCp7ll22V98oeO9x4Vsifj9S/BQ
	qQA6Sbtsv0QXnnV3wQbTfz54TlFOd7Z+DURedyHEuI+Pw//SWnY1anNowxaYw4/EWZTI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBC5L-0000u7-G5;
	Mon, 28 Sep 2026 14:12:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBC5K-0000u1-W6
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:12:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=oMPSDeK2wPlewsiRWMQVPysne7VI8vf8iSaWeTRCpN0=; b=PoFpnRrm/ca98R5m6Zjh681aPc
 UOMuxJAQW3WJZzwnuyIy3zqzi/EpHLMkt2QLmalynBlVlZoKVRdocxIW3lUtaUKUE71aLVElwIbTR
 ER9eK3LIWRXB31Dw8jdXqEsgW73xTmRqHITg0IpPrwMooG86jxQkzd5GAgRgMNC/KFsk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oMPSDeK2wPlewsiRWMQVPysne7VI8vf8iSaWeTRCpN0=; b=J
 2Ri7azxiImYZGMm0pjuTlcKPQHRL9uIaqv0gGUuOfQASfLIGjT7yXr4H9SAaA/xYcqqzh14AKJcL5
 F6UWJyVmfnYDFOEpoPjo8XQq+eUAXb32oMB+cMmxT8Q9ErRJ3pLEUcFLY+HAfPRssRRWxxATwawOL
 d/WujHNE8PusEsiI=;
Received: from mail-wr2-f13.google.com ([74.125.225.77])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBC5K-0003oC-Bp for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:12:02 +0000
Received: by mail-wr2-f13.google.com with SMTP id
 ffacd0b85a97d-4843378fb37so1861890f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 07:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790604716; x=1791209516; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oMPSDeK2wPlewsiRWMQVPysne7VI8vf8iSaWeTRCpN0=;
 b=JwAawSrgG6oAhJKh2wng5Eft8S/7uwQdbUl4qhfd7ZRs+RjYn/tPfQNUnmWwfADAo9
 5pTwT5s98jcQYSft3egjLAyjLfX00DwddK8BeaiTlBvNPaq9L6TifDUnqVdPa8Z+xRK6
 kV13qTUHiwfzFE7d5RELpMb9iZIYY+wMW8WaacmzmDcweUcLSJUJoaHN69MAYrao1/ro
 q9rKa3RdlvEP3YDelRdozLatQK2+Y/fxheXHxCDewpmY96cu9xEt13OwAClksV7PIZl3
 u7/jdhEEryL78+wjTS3xKB8YRAoZn9Nli63V+xHSEqtCY3aEujusD1YtUctkuZTgOTOG
 hSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790604716; x=1791209516;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oMPSDeK2wPlewsiRWMQVPysne7VI8vf8iSaWeTRCpN0=;
 b=IJE0wDLaePgpN9eWIViNkOe4X0ztB0Dp6ae0sisf8mabfeg3knWXUYIkxUSmGCnfuF
 S4vIffqHgmHIul+2q+ci3b3m8/UXglJ6EqNlquUJvKtfZAz93HC6G7IdhRABu5ovqWtb
 b+/PQiU26fz6QfmKpMUlNH4cD7LBFjEyRiEar8UIwnxJcE1rsjQ5rhyPzD/ZgnhMKyVv
 a2swTyF/MSJ8+E0WiwZAOr2QYdNaDzOOkFy6YKK29y8priNCVTs4/9vGOIQAa/bYqyCD
 96RmdGARHx4dqhU2Y3nMtUtRJC2Fzutdj3JjfvRj5fYK2NU6vkxSnoWtqvODJLtkWUbi
 vUEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVGXNQb+fhADwDmST/pspzb3A0xyhKEwu0YBD7Io8/hnsXDbGonuHZ30v3M/0YQAr2+0vBY66X931tcZg4@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKjufelJjZF+ef0Q1L41WGmCvdpWiBCCg7vhcNCtji1TYYDVNOm
 KqOua6CuQ83YWHgtfrP5nXK6lM19/Q38iy4r+NjrW8QWWutoDrNCDhpUFcMC5kpBDSnw29yN0ly
 1EpzVTYkL0hvKAe2+S8w4pV8KbRUd2NIEhYto/1hUKlBqeJw6kXrjE5zaSDO60dWziEhLwFNSbV
 Q7M5bsRg==
X-Gm-Gg: AYBFou0Qq7Y76CRDF/HNVSlcpBjrNHdIoffl+T7k1+4I/Hm0Yf8Ge6Z3IUUy286uSmd
 3Z+mW+h1bNga0dsYeNATLssjKpWS/n80PZGGXiQfxKdqw7r2XpNgn5KEfstxIqvKeBDdya6nDhK
 gMIOTRpekcr2JwR/2xRwi7ImyJwILGHTbc6iWuDZbfW37myuym0dxq8fGdJW/X1pYnXr7kj06HA
 q36T0Mgq3F9ELJBQhMiCIST3JHVVl7baclJe9kfoG3DfyMvvNsm4FkaHkiFTWoxq6Nz4/faoZut
 cCXnq9dpULaE0qfu0GMjfOL7QBFnE3uUAhXTQ0AaT8j9YpXUtLgaRH1aBQn1ueRAMFscQmN4dLG
 NKKAQyr44WQmEBA26mVV9SPJEVRhPxWJiTkvqu7JEPICTIlA/imeiiuJhsrrrWAWmTf4N9ZdqeY
 4Lxj+KUSlW9KAm3xaRHJNtmglKSP17qNcgoA2XlL4nNMCWpvqdN2YgCUf7Fut5rixSrknTY7kLQ
 zhDf7kGAaHUi4DeXEM4O1ONyQ21Ol9o2VfG3wMlc4lp0NgGom0g5t5J9h29eqJEVQf2EDk4lVij
 FEhJIHKWHfPJxAga6f6rSx9ESXTsDR/u6wMCRBHtd0+YeWZB5BTkJswC18dO9A==
X-Received: by 2002:a05:6000:4210:b0:488:892a:e125 with SMTP id
 ffacd0b85a97d-488892ae22dmr11557989f8f.42.1790604715645; 
 Mon, 28 Sep 2026 07:11:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a744fb5sm25645257f8f.33.2026.09.28.07.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 07:11:55 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 14:11:52 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
X-Gerrit-Change-Number: 1955
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1955?usp=email>
X-Gerrit-Commit: 7f48516ea1d96c7a8545cbdb1292def401ac411e
X-Gerrit-Comment-Date: Mon, 28 Sep 2026 14:11:52 +0000
In-Reply-To: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
References: <gerrit.1790599668000.I44d7171c7e4f8497bf8b902380df92a58bf8a79a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNTk5NjY4MDAwLkk0NGQ3MTcxYzdlNGY4NDk3YmY4YjkwMjM4MGRmOTJhNThiZjhhNzlhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8532d28af152d01f39374c4e4b427837ecb6b6c6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBC5K-0003oC-Bp
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Build against
 Windows 10 API and remove some backwards compatility code
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
Content-Type: multipart/mixed; boundary="===============0005184565082988225=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0005184565082988225==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nH0Mq9zUnaM="; charset=UTF-8

--nH0Mq9zUnaM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1955?usp=3Demail )

Change subject: Build against Win=
dows 10 API and remove some backwards compatility code
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

Fil=
e src/openvpn/win32=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1955/co=
mment/153287c6_4f670f4f?usp=3Demail :
PS1, Line 1350:     if (is_wow64)
> T=
his is I believe a bug=2E [=E2=80=A6]
Done



-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df92a58bf8a79a
Gerrit-Ch=
ange-Number: 1955
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: r=
azvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Com=
ment-Date: Mon, 28 Sep 2026 14:11:52 +0000
Gerrit-HasComments: Yes
Gerrit-H=
as-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--nH0Mq9zUnaM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>flichtenheld has posted=
 comments on this change by flichtenheld=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/win32=2Ec:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
955/comment/153287c6_4f670f4f?usp=3Demail">Patch Set #1, Line 1350:</a> <co=
de style=3D"font-family:monospace,monospace">    if (is_wow64)</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">This is I believe a bug=2E [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1955?usp=3Demail">change 1955</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1955?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I44d7171c7e4f8497bf8b902380df9=
2a58bf8a79a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1955 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D=
"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Mon, 28 Sep 2026 14:11:52 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: r=
azvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--nH0Mq9zUnaM=--


--===============0005184565082988225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0005184565082988225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0005184565082988225==--

