Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16ECC44501
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uVw+QyXnZ7j/YlGZClyTyWTVCilyTLx4VQbhNEaWgDc=; b=lgyMJ46dSosq/PgGlFl+saD/le
	Zrks72+m7gsJGce2jxmpFy7cdkVplAub/0/bOib4dVSDovEA2qMu2ktaf9T7CGET9fhdwDEa638xu
	e+Ac6uxAQERNkycpE4XbIVbbE+xb1iQmKdvtYU0IAHhIwIEY20hLEh2UYh66IVKRhnFA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk1eB-0000Gh-3T;
	Wed, 15 Jul 2026 15:35:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk1e9-0000GW-BF
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:35:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tQ3lzQqngRdPjNK/YSOo5wHKP2PnFFxAnxXxblLB7jQ=; b=bdJ9CTga37HK9kRE7kB4ttRdYY
 kG1bjL2A0j1wA2liCwPUlAEe9da5QWzuYsjhoba1wTg1IHD+cmY1ewqokPiUwdiTci92Jw4wMI34p
 RBzBOsU9INC2ILLCIjCTAl39hl++onTEXQnp2Y5cx35e7TY5i3BONWrfWXu0FBQ5vsTQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tQ3lzQqngRdPjNK/YSOo5wHKP2PnFFxAnxXxblLB7jQ=; b=E
 Y30vygPq7w6HdufZ+FTfn5FdQ9zJLcG2xFI4dPBTL8QqYjW0XpuIqamEJFUbELTtHpYCqmTnXtLNL
 zI7iKOmNwigsl3+gL1on1fCJcaUyADCYE6zAbpchYT/ujn4gGP0a3ADJpcG2ROpHgVIilS6GvxK7X
 L+i/u7Pr2C1CJV8w=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk1e7-0000Wq-Uz for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:35:41 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4758b2a9e2aso3496045f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 08:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784129728; x=1784734528; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tQ3lzQqngRdPjNK/YSOo5wHKP2PnFFxAnxXxblLB7jQ=;
 b=ZhFWi1FfiNqIFYaIZpdn9N/rd9Y+SScVe/vj/zjEgtpWvYKHRsYOiij8/RPWJ28GnV
 rhwxJrGJPUbs4KLCFemATTIr10TY3ED/snaVoOTVTgzIaapnAzBGbWLz+PLjHIwAYY9O
 2HevOnrYz9gUhTy7WscRNU+60sbrS5S/EX1ORXyFRHoeH7MhdR3t6+GTn6xYH3aMZM8G
 PFNqV7wqEpZGAkb1bBq8LJ6LQW2f2WPQxlisFDtDPka4giFK3nRM0K94cnjEyh0ot+fu
 ngXhB4/38idqwEc6jdU83+H3VoSFJ4nwIh+O/NF7OkzfOvVKJBNoPD9t5kAIS+RvnARl
 cjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784129728; x=1784734528;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tQ3lzQqngRdPjNK/YSOo5wHKP2PnFFxAnxXxblLB7jQ=;
 b=WRA4owxQ1dUZnl9Mas6fPpBJqwB3qhMxOXPdM+DGi3Wsqy4K3tY0QCJivBhIlURwlq
 kTMOxaM8l9eamex18+y4UvD+7N3qSErCQuhJofqawIBUfthcKmO/SJGDFhuxpXCO/LOa
 MydTs2uFQZm4+LQHkmRMNxBYGFa+Zw5zeYce3ufYQx0ywogEEAufiT4wDR+Z0PC5ifNY
 HXdUvbLW0gqhaNZSrYfBpAtYH4GSlF5UIEw2J2ccPNxfKmBgAt+jSJibY4jaIBTQN9U6
 4Wd6itvblWWDiNFVRCIkm74GhgN1YwVJuwSvalOS8MkxHYp9NOFpaYevbLDIx8aeShJu
 4dVw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGarx0JwoCQ7oYTg1BQgtCE3kYIpbmavnoXDH6GJrBhLFqZnk6KUmBUsLpINve1Td9O3zYKKVcPCoNGEj8@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyZfwgNka2Hs2yM7zRh2/p2JYRtnp19BVFqPcWmohe8tqsumJtl
 3YpzWvy/wO94TMl+FnLcB3MmJbSY0ChoL+QAktkmtRfTFzzmk0YEcarcuZI7ZPYtUxjSAjd+sRC
 Ck1NQzKEGP74GBphGh/Jfpwcf16C7QEk28dJ0v46Eurd6HYjkd7wtgNhqXS+c8WGhRVeh
X-Gm-Gg: AfdE7ckQauT5BAHbd9QkGXx8mzb4WiY6RqAu/930h2rAOtri8L/hLBivP76lBwZ/uf3
 Jm2sWmXprqNCGbf6Vrq/lmPXL0PXo8qhPfvmGmMTfR1jXLjp7TRGAfcjB1s/EUA9M2HpiXuc+X9
 Rz7LPKK8QHnRrojDeh2Londajdg6dww6cWSDqO3X8SKgokjLf2FnwdNPBGOvQPlx1LjfqF03Fhu
 W+kuwRbAR45m/scwyObdiRNvDwq69JqErWgH2Ii/J+NT30/BBhEAJOxT+xb/zPuDV5Bspyr5Zu5
 ZE7dujyaijUn8UjLmyWM/+0oP5dpc05Y2zvzAHVP6AWqb5EkHbMPahn4ucLrqjTM3oK8SrLeOtq
 2SzhLsBDeFJpo8lmSYMAgZa5yhywsngsEduU1xEzRNP6YFnaUNnMLSr2Zml+skhoF08L0uhRj+t
 DYihsBDBFKsnGlzNDRP/BWyWm1BTSMO7D32BODo6m7Ytgm+iLuhch0JvHxeHl+8ncwopTcGrAtF
 PZ+Sd22qmnVWBwRN+XUV3x7BP2DDebGRmNELbuW7nXnK4U/bH9fHBaUYeqX/g196d1JXZQ8bauH
 GLE=
X-Received: by 2002:a05:6000:2982:10b0:47f:5297:4722 with SMTP id
 ffacd0b85a97d-47f52974899mr2332424f8f.0.1784129728027; 
 Wed, 15 Jul 2026 08:35:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464b7e22sm16530437f8f.25.2026.07.15.08.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:35:27 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 15:35:26 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe
X-Gerrit-Change-Number: 1789
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1789?usp=email>
X-Gerrit-Commit: 08e75f6ea182acd2c9b6d4ca06b5bb35b7b7addd
X-Gerrit-Comment-Date: Wed, 15 Jul 2026 15:35:26 +0000
In-Reply-To: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
References: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTI2NTIzMDAwLkk4MjE5YzYyOTVhY2YyOGZmMTBkZGIyZmNjMjg1ZjgxM2M0MmZhOGZlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0e064aa6c8f23d7d725eaba2325e2ba9d6c88001-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk1e7-0000Wq-Uz
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: proto: correct
 802.1Q length check in is_ipv_X
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5760254122253243102=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5760254122253243102==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Kz+TAng4C2c="; charset=UTF-8

--Kz+TAng4C2c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

flichtenheld has=
 posted comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1789?usp=3Demail )

Change subject: proto: correct 802=2E1Q le=
ngth check in is_ipv_X
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 2:

(1 comment)

Commit Message:

http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1789/comment/7f72adbb_3fe36377?usp=3Demail :
PS1, Li=
ne 10: Signed-off-by: rootvector2 <dxbnaveed=2Ek@gmail=2Ecom>
> I would mov=
e the Signed-off-by to its usual place at the end=2E [=E2=80=A6]
Done



--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8219c6295acf28ff10ddb2f=
cc285f813c42fa8fe
Gerrit-Change-Number: 1789
Gerrit-PatchSet: 2
Gerrit-Owne=
r: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-CC: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@green=
ie=2Emuc=2Ede>
Gerrit-Comment-Date: Wed, 15 Jul 2026 15:35:26 +0000
Gerrit-=
HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <f=
rank@lichtenheld=2Ecom>

--Kz+TAng4C2c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789/comment/=
7f72adbb_3fe36377?usp=3Demail">Patch Set #1, Line 10:</a> <code style=3D"fo=
nt-family:monospace,monospace">Signed-off-by: rootvector2 &lt;dxbnaveed=2Ek=
@gmail=2Ecom&gt;</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">I would move the Signed-off-by to it=
s usual place at the end=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1789?usp=3Demail">change 1789</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1789?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1789 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@green=
ie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Wed, 15 Jul 2026 15:35:26 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>

</body></html>
--Kz+TAng4C2c=--


--===============5760254122253243102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5760254122253243102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5760254122253243102==--

