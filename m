Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF12606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=k0pfWYUL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=maFJQphR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fHYpDvXl;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UgdHA/hx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wE3cGkex2PBmYHoF4s6AvnUqPsl/FxEODIrxbaotB4g=; b=k0pfWYULwKH9tWREMu3A8R+PZY
	GbrHVIvGImqJzNwZfxu9InGobVIttrEfXZ02VlEa7KOBGkoyc8YWFQyF9M+nFgD/fFMZkQ+5dJe8m
	BCtmcZyy+NhCtvXUJ4J+3ClwmGGQ7bLUf1IWe4D6xAo5ySEPHxyfLFh+uEm1MvG8pON0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWIOl-000000002ux-3A20;
	Wed, 25 Nov 2026 19:11:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWIOk-000000002uq-0Rlp
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 19:11:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Cp+yrwQpNOx/2xEqiy+R/U32fPcOhl1jDrrxdP3DiRQ=; b=maFJQphRcEvGb4vEbnT6Xb151n
 hdPi8KISwuum8YRg3f5StZeR7XQvsOpEdZWgEDHmMC8yvwAM2B07jbUsRfkBNEoypAr5vK6fIDQ5O
 dHSrWaSnbERdSHJAIdi45YWOrCszI/LT4Qh5zWcWLzsDpxOrcyaIFBD65djIIk8OzZus=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Cp+yrwQpNOx/2xEqiy+R/U32fPcOhl1jDrrxdP3DiRQ=; b=fHYpDvXl2vguu/nMDeyATvtrey
 s55EipVrZ3RpFiG/d6p9DwGAAkrMj6OL3CKtivEKrZcreSsKtov6PWDKBRrtrx3KpfrTLNFIJpUoz
 1uc5RYO0TJredDVFs6fAMheRLpjS3s03HqA7CdpegeMBXN1FDMmAFBTzYfUcLinD+OEk=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWIOi-000000007xu-3Hut for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 19:11:18 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4a42b34e930so5378881f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 11:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795633870; x=1796238670; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Cp+yrwQpNOx/2xEqiy+R/U32fPcOhl1jDrrxdP3DiRQ=;
 b=UgdHA/hxTQThO1MmXjKetsWpE/LxIRLMwDTenEzGO+ifijisIEx5DKP4+R95aY+t5i
 iM80Tzf5UQi7Ys2rU+dcAX6HclcFXJ3PbZph0EBSwWLOtIot8aGzvDAnDCYsmNbqxaUW
 5TOHkmyE9W3zp+c9E0k+kT9LQbN+zYUIQONkZvAe++lWtgAY2F83aRhXMboQG9ziJDOo
 zIs5ri4oND2QHHjz3h1Nv1VyO767+BZXj0vbBApbHql4b9GjEydtG8Wc3TIMOzIGKrvb
 eJ4gUElDyAKiS1wSuUauMsfAi/6XXWRK3QvxuyG6Fy+UKOOE3PE6qyDqkIflJ2PKv706
 4Aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795633870; x=1796238670;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Cp+yrwQpNOx/2xEqiy+R/U32fPcOhl1jDrrxdP3DiRQ=;
 b=ukoD1Y9kUL+Jz40h+jsQsSybklIzmrCkwpIM8+HrIhTi4LVlOZf7e9RWSSManNGhb8
 5UEphB4p+7kaTjClw2XaUYCsur1c4qtn2ccH1wkNy7Pk6aJVBJY5P+/GSNAhURjusaAS
 auYa4Q9UE8GUEzidLg0s43mmAD8l7sBuNIu4UEp17hREGdpHb/w6suxAEdIe68lc7EI8
 nxxMrTkBlg5h71eLqqdPoWJ5qPsDNXnmYBIn3E2L0cYNVefqJ3WsL/jiclIwALzG00ut
 6MwkJ8oS53JqVKBAek+s0VVrjqsE9nHRFdtl3fDglOhYQ8BXXclzjC8u6fzBf4wChZ1C
 5thQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEmbdIGrPucXZZ/4aad/OqDleVZ27gw/7qWcQ6jD8lgb53SyaUlTHqQVr6RJKRsC00GUeYmqPWdZTz+3IKQ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z866tkHVht3dp7yvucuQfTiGnFIGIbkLQ488iEm1TLUq+O5+JdN
 bHpzK7CiBqf84OFDO0NmT2JR5DtDPanwvzAxaqvs+JO6H5JWkiYAki65VW/4bqIJevvdrdCfIKw
 CBxJpkZAnSqJlpXBR3HInzr40CmLUgum9gY/pROojo+SvPbHdVCpFltk62g8kRjJ+0l6p
X-Gm-Gg: AZFdTZdqMBpBt8FWnwFJzSBdnFX53j/15b2hiO33MS97TN0kkfmzYweqesv7fWMkNBL
 ifsGY8BNqg6lvXGXzG+B/gRiiRw+459WF5xv5e2CDWfLekbH0zBnISzh57PD+vNrC1GH1Td6keC
 R+4yjmmPLkIH772VBqOXm5c52Bd59JBFeE6WP/JwZCQ7F6fzX7NQ1vYuvMBSE3TqeZrzueiKeP3
 FekCtXBt3snS3u1ShXfRHeKvQqD2AIIOsRWNbLod1HiKVOv9l/ymUToJKE7V8XBA+4OsTeA9yVo
 4Lxauoov9zXy+lHvekl9TmBSMY1nBq+kdgepYhdShqUZnqeBMMhq9+i7YkVk2lcgCvYSmyNGiZn
 2n33OluK3x0uXxa/oi7KFxCFuYjLvwmFUmZ8kEUbZiQA5ZekHD5L0l04NBirxg70zpWzalttqqT
 7BWim2EvJjyhJ1M22j2GFjEP8+J4oxNp8xjWZSLOgyZKigT1NaBQaJbhg0GLhmkTGDuNwMzt1Wk
 NJSn3a76m4qvRYhIyAwUelK8zpSg5NcwF9+Yxq1i66ZUBhVFc7N9xUGdt5+1JvU6Mei/L8J/Jfe
 0wHjjkoazfapvFfdvCKXsBL73R991Gpb/4OTi0xZRbhft+iDEuj3H2DBvoATptugqbDS+BI5GWI
 YYZXC4S4Bgf5cbzBUGuCEgzKSz7tp0uFjHG2j8kJJ1pc0X3X732I/2ScPVFyvEiwWVnY7ipHMMy
 DACx4lkKaT5RRFco4=
X-Received: by 2002:a05:6000:4b13:b0:4b7:75cf:44c6 with SMTP id
 ffacd0b85a97d-4b775cf4568mr11813422f8f.11.1795633869933; 
 Wed, 25 Nov 2026 11:11:09 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a680355sm30030198f8f.27.2026.11.25.11.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:11:09 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 19:11:08 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b
X-Gerrit-Change-Number: 2346
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2346?usp=email>
X-Gerrit-Commit: 2a2310f4bca9c51a67500fb575b57ae04e8a12a8
X-Gerrit-Comment-Date: Wed, 25 Nov 2026 19:11:08 +0000
In-Reply-To: <gerrit.1795624133000.I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b@gerrit.openvpn.net>
References: <gerrit.1795624133000.I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjI0MTMzMDAwLkkxZTg0NTI1MGI2ZTYwNmZmYjQ5ZmE1ZmUxYmZkMDM0YmU3ZWFhZjJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6be1867876f68bb0490221f0c9145ffb007ade6c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWIOi-000000007xu-3Hut
Subject: [Openvpn-devel] [L] Change in openvpn[master]: push: check INFO_PRE
 length before sending AUTH_PENDING
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
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
Content-Type: multipart/mixed; boundary="===============5529718767255909776=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5529718767255909776==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8g8rJotKhcI="; charset=UTF-8

--8g8rJotKhcI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail )

Cha=
nge subject: push: check INFO_PRE length before sending AUTH_PENDING
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 c=
omment)

File tests/unit_tests/openvpn/test_push=2Ec:

https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2346/comment/9bcdd4ff_33bc2fa0?usp=3Demail :
PS1, Li=
ne 58: #ifdef ENABLE_MANAGEMENT
> Unless it might break something feel free=
 to add to the mock_* files as needed=2E [=E2=80=A6]
Done



-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I1e845250b6e606ffb49fa5fe1bfd034be=
7eaaf2b
Gerrit-Change-Number: 2346
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attentio=
n: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 25=
 Nov 2026 19:11:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comm=
ent-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Comment-In-Re=
ply-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--8g8rJotKhcI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn=
/test_push=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346/comment/9bcdd4ff_33bc2f=
a0?usp=3Demail">Patch Set #1, Line 58:</a> <code style=3D"font-family:monos=
pace,monospace">#ifdef ENABLE_MANAGEMENT</code></p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Unless it mi=
ght break something feel free to add to the mock_* files as needed=2E [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=3Demail">change =
2346</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2346?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I1e845250b6e606ffb49fa5fe1bfd034be7eaaf2b </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2346 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Wed, 25 Nov 2026 19:11:08 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Comment-In-Reply-To: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>

</body></html>
--8g8rJotKhcI=--


--===============5529718767255909776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5529718767255909776==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5529718767255909776==--

