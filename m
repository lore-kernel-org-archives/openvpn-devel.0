Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB4360A2602
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BuY3qt2z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lX70cfY4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Jtg8+qFt;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=S2h61zuH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8Iz+5WRbhTCP5Su7JGC614vb0DTAVNiXfCt25H3HmZw=; b=BuY3qt2z/eMkY9tezfQiHDqMF5
	O8+xw/Ij6/tnHB2CXpP6/3dxAfqIZVQd4GGIUi6QLFdhkcW++KUb6o/mAQx/0tfWenVCdsf0D+Gcu
	1dS7InwHAxB2yRPjAgSBq8V4/Q5q54zJ75lyLk5AISZkfH4/a5KXWatvOz/jtixpm4h8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQmmV-000000001o9-2f22;
	Tue, 10 Nov 2026 14:25:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQmmT-000000001nQ-46YA
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:25:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TCi3tiGzbkdBlM7aC8bMiIKihouRmK7hTg/sCelvHAU=; b=lX70cfY4Hq8Yk8JPS5fmOE92Mk
 kpNqk7slBZAw6tJfJSO0mfklBPFWmoEH7RAdW9MN8JHc1Foy/Em7y5UO6M4aCO3yRZikG9uqMa3zQ
 rcCW5pAsfo6smiZkfkB+BxLtkHA16PHvoHo1kuqmsKFo450p7wQLE2eoIv80WZwcnAlY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TCi3tiGzbkdBlM7aC8bMiIKihouRmK7hTg/sCelvHAU=; b=Jtg8+qFtl7Sa5aWDTfIandIeER
 4BsqO9BPoGpciupBbiZJiyE6z61mGR0VsL98qyjn+j5u6IPSXFfVIyciU5gxS2gkcXWt5zc9ih4Ev
 CqXhSHm2J8Ke5pKCBIYbujR3AqrTrBdEvl8eGEUXT78UrsDUV3IRUKAUKQsYxMs1jCoY=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQmmS-000000008Uo-1ptI for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 14:25:01 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so24872135e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 06:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794320694; x=1794925494; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TCi3tiGzbkdBlM7aC8bMiIKihouRmK7hTg/sCelvHAU=;
 b=S2h61zuHRIjO2MJu5dazcIhM1zUlaag4v6PZRw4CNs7oeY2/oe9KPCcF7j9GWVq9cg
 mZfHjRgP20iWqqtLGkMkCPvqvCHwf94oSw2bfcOBYLRAeCZO52HAljPfx3pbideSvuSJ
 IMmFk1Q84x1qlR7RCInalCI+4kEBJMt2NZugkVVLG+26vufvx/3wYClKVoFcLORwa76Z
 BaHWw/iivr1/1MLiHiIpcvXTrTK2G1T+FDAx1pAmh5nRqsJUwCFbMP25FKvXHpTwpVL5
 BskebJ7IakIY00eU3foPBu8J9BACJy9V8q8FzXRoo9DsND+rdLsIVdhMmzNQuY61nLHV
 6A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794320694; x=1794925494;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TCi3tiGzbkdBlM7aC8bMiIKihouRmK7hTg/sCelvHAU=;
 b=BLuUxIygzHX5s10apRLehQA+BGKHpqhB7z2DcZlK7btIXMQoKIqjIRgiSYc8pIrudu
 /7pqam08ouFcZMfBjrl9jT4+RNXq9Wkxd8dB3ar7kvh04fEXK5q3YjGFBUC8gkWbAPCd
 PT3PTwmbraIDACiNWUgyZz99M8l//D3RJMM2dXpPJxfuD7DTCvNtxSe4Kks3qL8r+6Xp
 Mam+6bgqmLAABqCKv9S3fs+B/4Dx94auu5RSvrZKqtuGXQ1SPRaBkTYunVLuoimQRdrS
 3ljgwn6M99R0EpaBQSH5QBooqnN+v+LY9jHLmazDV3f6LobFUxfS0vAAo6kQbN0ZOhZp
 ieuw==
X-Forwarded-Encrypted: i=1;
 AL+hErGN2P56CjHSePEwcZUweCKMp6o3vhqFKw9qgHRnumZB9r5YXpNXzPWduGuSfL9OvSKXsnG+FRMoFmOEP8gS@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+0B3vv0H0q9sXiCEHechHNmZ2fxVqLlahftvtaP5pO42N4cQPZ
 pANsI4s92RANJINDPKAS4kdBJzTgsTvt5WjGdDHf0t9Ma9JLH983ChPTyU8c7oOkL4s2V8tCBFL
 4mYyeq5WOIp62xl/d0I5cXJY8kmI43uabbWv16NQMHc+tGHK473kAYp52Va8/w6p2NlBbbRuBju
 UBljqTnw==
X-Gm-Gg: AYBFou0SZi0ibJprE57f8KI+jgGyUCYD8/3g2y3xffgJTw5pve/NzeYrhMv96e1HWZR
 CIUZWlyfcVbsM2mjLxJn+mG+KuZ7A1JfikyDYAQySj4MOIGzoLYKo+3oSv36J45FwdY2ECbB8Nn
 BaMNL44HkOJflBj5WaBjC0ZD1/q9XQPdDoQK8LvSabxEP0ZZLsup8tsGP7/VTJf23DLJD+emFMR
 mcKBXhrnu5FHOeFrMpjd+oVzaQo51IR3MK3EaTyVYCfQzuGoOzWWVZir6h+dm6DiVZTIjwFfp5q
 Jjz5hh1StblEWaTC/JMapBjifTAfbz0jH8sKzX8tlmAGOHJPFi8y4lQmrDqWubAGuMzgDhkTSAV
 2w/Xl0hpbkKmzEpJL2qSKd29VvXpwB79nI8u6el10mE3+A7g8/g0BR+9UeeHk5fGaEMW19AetTo
 8mgr1jn8Rnx6ffugKWrV9JlSjMRl5DRQsf/jxn2w+cjCgri2mazJayB7FltjoYJAgL7INSpdRxE
 pRUXWtMAC0KjSYvrdAcW5JtIaV1grGlWZHUXL4qC7tOksGivZG9fP8WBxutBTaO8VVCE97TvIIu
 AyUtWYcgyhNAv3FMF0kJ+3qS80BliB7IhjQQTXkUdt8iOIIjAiN1F3gZqtIPINweqSSHqiJ1R/W
 jbtwFNMKhm1SWhGCxl3dca6AKLehSnkD0b+sp2sKiS+eFtIOm5jieuj1Lb3D/DSc4sCPNY4Bwu+
 pdlURK9uYe9OwMef4=
X-Received: by 2002:a05:600c:190f:b0:4a1:f99e:f22d with SMTP id
 5b1f17b1804b1-4ba02336807mr52140595e9.6.1794320693643; 
 Tue, 10 Nov 2026 06:24:53 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba023690f5sm51000455e9.3.2026.11.10.06.24.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 06:24:52 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 14:24:51 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ibc9eb15714f14a9f49366fc84072087fc3f013c9
X-Gerrit-Change-Number: 2152
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2152?usp=email>
X-Gerrit-Commit: a4735b9d6380f5a30ddd7174ae78dc86ef90e1de
X-Gerrit-Comment-Date: Tue, 10 Nov 2026 14:24:51 +0000
In-Reply-To: <gerrit.1794067506000.Ibc9eb15714f14a9f49366fc84072087fc3f013c9@gerrit.openvpn.net>
References: <gerrit.1794067506000.Ibc9eb15714f14a9f49366fc84072087fc3f013c9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDY3NTA2MDAwLkliYzllYjE1NzE0ZjE0YTlmNDkzNjZmYzg0MDcyMDg3ZmMzZjAxM2M5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <adf40645ffcc69d38687958a07b6577ed3ae2ce4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQmmS-000000008Uo-1ptI
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_verify: reject
 an empty certificate fingerprint
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net,
 gert@greenie.muc.de
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>, Max Fillinger <max@max-fillinger.net>
Content-Type: multipart/mixed; boundary="===============6294034105160115335=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6294034105160115335==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oiNuvVqvFUM="; charset=UTF-8

--oiNuvVqvFUM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Max Fillinger, R=C4=83z=
van Cojocaru=2E

Steffan Karger has posted comments on this change by R=C4=
=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2152?usp=
=3Demail )

Change subject: ssl_verify: reject an empty certificate fingerp=
rint
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1: Code-Review+2

(1 comment)

Patchset:

PS1: 
This is a nice minimal =
fix which can be used for master and the supported release branches=2E

The=
 real issue though seems to be in the underlying set of verify functions (r=
eturn 0-length buffers instead of errors) and the verify list (not specifyi=
ng the hash length), which have interfaces that are just too easy to get wr=
ong=2E I'll put it on my list to refactor those=2E



-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2152?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Ibc9eb15714f14a9f49366fc84072087fc3f013c9=

Gerrit-Change-Number: 2152
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Co=
jocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: Max Fillinger <max@max-fillinger=2Enet>
Ger=
rit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: Gert Doering =
<gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: Max Fillinger <max@max-fillinger=2Enet>=

Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Atte=
ntion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, =
10 Nov 2026 14:24:51 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--oiNuvVqvFUM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Max Fillinger, R=C4=83zvan Cojocaru=2E =
</p>
<p>Steffan Karger has posted comments on this change by R=C4=83zvan Co=
jocaru=2E</p><p>Patch set 1:<span style=3D"border-radius: 3px; display: inl=
ine-block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Rev=
iew +2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
152?usp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2152?tab=3Dcomments&amp;usp=3Demail">Patch Set=
 #1:</a> </p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">This is a nice minimal fix which can be used for master and t=
he supported release branches=2E</p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">The real issue though seems to be in t=
he underlying set of verify functions (return 0-length buffers instead of e=
rrors) and the verify list (not specifying the hash length), which have int=
erfaces that are just too easy to get wrong=2E I&#39;ll put it on my list t=
o refactor those=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2152?usp=3Demail">change 2152</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2152?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibc9eb=
15714f14a9f49366fc84072087fc3f013c9 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2152 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Max Fillinger &lt;max@max-fillinger=2En=
et&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Karger =
&lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Max Fillinger &lt=
;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 10=
 Nov 2026 14:24:51 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>=


</body></html>
--oiNuvVqvFUM=--


--===============6294034105160115335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6294034105160115335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6294034105160115335==--

