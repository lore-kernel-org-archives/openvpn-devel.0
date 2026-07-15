Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC10C44507
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AFcYYpUbPlpvfege2c0UG2YXNhUpGgF675OaED+kLLE=; b=Yf5DHX9d0Od5lPemfkPnG2fxhM
	LJPA6CnlqmpZv+n+u0Bq/BkTD2HnBHd7ykcsu4V7AwDTH1M0yN1gIU+NoRv5vzR0zlVwD8VPi9m8e
	YCXxJo3pZ6x9eodVXh1ZYcq+3D/CvyhVAGZO5FqqXbXwuArTa4EAABIy2aY25Tev4hn8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjx8e-00051x-Am;
	Wed, 15 Jul 2026 10:46:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjx8c-0004sc-Mm
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 10:46:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/91t+X/5RdgpiDmqRMK41hCiY1/mNPeHmf0wx9xSEeY=; b=Limo/SGqFZoCbb75vr6yw/dQr4
 7hG9SgagN+7/5CHcsJpBtUT9xYT6W5hcoaD2HqzxiiKAsHCTowbjTrm9O0iSFNgJuZ6iyYmZyBDF3
 P8R9DkRE1PLPciHISzVPkmWKcg1zm5K3smDOfsvLz7Hs37AfefC5lUNWNFSnUOw75tGM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/91t+X/5RdgpiDmqRMK41hCiY1/mNPeHmf0wx9xSEeY=; b=C
 Br4E1UD4iahZz9RbKdzupik/rBJr5YBWQdpmGLpyXTSNDFgadnBuPFhjnpT4dBJX3fcLYHKcKpt+h
 X+Xq1juKV4x+kvR9hqRdD9NGyY4a6ns9n0opaz5Gamh4yfaH66aWa55IpOZXYdAzYb/1spDs2jD2c
 lPdlmr+hct4BNNec=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjx8W-0001qv-RF for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 10:46:46 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-476a130c138so1942906f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 03:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784112393; x=1784717193; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/91t+X/5RdgpiDmqRMK41hCiY1/mNPeHmf0wx9xSEeY=;
 b=d/fgZs9dseUA9HwTAUdI9SgNgdWtyxHt7SAzDaQJsyfD6rhCeEubKKQcaI0n0HHtb7
 3CkxBQklZOOYqVNt8vm28XYrQMoG7sLmVST+5kZJ8/SnPLVbL6EdnKV8mjJorMv5w92A
 ZKfPkJCiSUyceWz92R+7ssJ6CLlpR7i5kTiq+VQTmK0lTugeB3kezAwsGCdYQeq/qCMm
 CK1fL/2UXAGvMeI3zc3BmilEVGV2+JoWn2es3RnmCIVKVccC4lMzHdkegx+YABBJy2gL
 NtSWJYXedjiv82Je+dDA9hf9loOvrggEThdnYNydE7IsEW4PRlYTXTkzMu2+w0twVuJM
 YVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784112393; x=1784717193;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/91t+X/5RdgpiDmqRMK41hCiY1/mNPeHmf0wx9xSEeY=;
 b=N8F/UEs/DN1Gv97ZnWjPCQ/jBM9GrjF099FpGWw8KP3prbevnTOpgJOjY2tIw6dv64
 z2eXB3T4NWhwDQGzwXu6XU3xGo6B3kfSolW+0qkIy2TbmkR78VtlDRsBc+S8o045kaAB
 PJNAVHYQB+x87r+yENWWtVl266dcB7Jdb2qi4WvJBYlfRbda0EnCIFXjls6FHQW0x9D6
 WTXTxSZv64xwbL5FdqP0a9Ldy/Sh0wrBMa//kMXm2uuhPejgBaN3LAslV03xWs4vHLsz
 4odV+UrjS/BGjcCn3lZfdZvPTaOh7YuW+skd2eclKxdQxKeh92DTYF83zVsyMnbIiXyZ
 QYig==
X-Forwarded-Encrypted: i=1;
 AHgh+RqpqeJ6hR/uD3imd4UXMENcdeC37LkmxS5ULVzWXzMIYSar76SKc7e9kAfukDFS/2FTwT0XIMxEIyMMhLRX@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwIwLRZewsuYAmMrFO4OgfBO3I1QUr2SCBIlyetvI2+4v7xCTY8
 zYe80nwDDePD0n/GKRIWAnqQH9IcPlp97Dcv6mQA0t8iIW3kg7JWP6o3ZakfI0bs+CqiwJQ7Foo
 ocJO7+fjHr9kWcGxbo96O40j0zaYig5/rA4Fsud49guV7mUihrTDeT0VUB1pqBdHYeUMe
X-Gm-Gg: AfdE7cn8sJruysx3Xdi41Hbo3bOugZLFFxTGS6myae4Hytqvuu2heRfVTV4dvbCenmy
 CfnJ/yc16FKOyFOidToI58zsKo0RdMS85PCpQhUI4s04sU3GfWwFlwrRBSMzjquTAK+QEVb+HNc
 9jyWTPhbR3UeZ+P85LFtqK3/Uuts6y1HDqYouHaTEU6u7hfI1R5dlUBTgLXBnUrwJIdkb9N4xHB
 zllMW/uXNijd6t96NC8BhMEquc3LroFNq8mmSa2Fj5e1N4AdvILIZfwp8QEC51NJD2dPkjDlJJ4
 o49ahQDItFJbwv8SDUSJgv8/n7HkAXqxfYpybl90k3Z6Hxs+QJYTZDTlJg9sq93owq2SJFzm0Tj
 VaMw0+W9XmcOLB+VJZtrr0QiOKr4/Uv9PVmPXMY1KVrVZyqwCVi410wSnMFgt9D6urvS7gjEzig
 UVxEY0dT1Pgt+fOsXTZkGqCYfgmTH6EEqayvVz66X2pHm6YbxFv7J1NyUzhzcBSiJ/PLYH/r5fF
 MKdyFdnIoyB6apGmCfJCJ3E6XIMlXf5Z1cUNg5odDY4LGVjZmbz0RATkMpmknsgl0eXmT9IMXgm
 emA=
X-Received: by 2002:a05:600d:8444:20b0:492:6447:7a7f with SMTP id
 5b1f17b1804b1-493f87d8909mr140847835e9.6.1784112393096; 
 Wed, 15 Jul 2026 03:46:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a32b9f3sm163324695e9.13.2026.07.15.03.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:46:32 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 10:46:31 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48
X-Gerrit-Change-Number: 1787
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1787?usp=email>
X-Gerrit-Commit: 4f1173c86b727de98c0aee4a0f07a5ad83feb043
X-Gerrit-Comment-Date: Wed, 15 Jul 2026 10:46:31 +0000
In-Reply-To: <gerrit.1784067448000.I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48@gerrit.openvpn.net>
References: <gerrit.1784067448000.I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk3YzBmZjQ4ZmIwMTlhYzdjMmQxZDk4MWI3YjdlNDU3OGZmNWRjZTQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4de015298609ae6e0c7a9f2183f3db91efead376-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjx8W-0001qv-RF
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: push
 route-gateway(s) and server route(s) for subnet-pool clients
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5286380605536191069=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5286380605536191069==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FCBujibAPEg="; charset=UTF-8

--FCBujibAPEg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

cron2 has posted=
 comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1787?usp=3Demail )

Change subject: push: push route-gateway(s) and s=
erver route(s) for subnet-pool clients
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-2

(1 comment)

Patchse=
t:

PS2: 
why push a route for the VPN IP?  We don't do this for on-server-=
subnet pool IPs, so we should not do it for "other pool IPs"



-- 
To view=
, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578=
ff5dce48
Gerrit-Change-Number: 1787
Gerrit-PatchSet: 2
Gerrit-Owner: ordex =
<antonio@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2E=
com>
Gerrit-Comment-Date: Wed, 15 Jul 2026 10:46:31 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: Yes

--FCBujibAPEg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail">View Change</a></p><p>1=
 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?tab=3Dcom=
ments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">why push a route for the VPN =
IP?  We don&#39;t do this for on-server-subnet pool IPs, so we should not d=
o it for &quot;other pool IPs&quot;</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?usp=3Demail">ch=
ange 1787</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1787?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I7c0ff48fb019ac7c2d1d981b7b7e4578ff5dce48 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1787 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt=
;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 15 Jul 2026 10:46:31=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--FCBujibAPEg=--


--===============5286380605536191069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5286380605536191069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5286380605536191069==--

