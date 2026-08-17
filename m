Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDD0C5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EYzNtj19NRQt/Eo9+BD+c64Uzz8RI5XtTwZjK7C3TRg=; b=ly2Uyhud9h/ZPci58NFmOZajUP
	NDP5luBd65QJCVgeSuKZlJEsvUswyetOYkD3YoyeplUwoJWNbjkl2V7UgZuVgnzizMyrWh3MFuRVv
	M57P3bjZEvlHEDori98j2OxX6GF6S/ThAWnsMSd67fz/AUZV9l4MFAZxmyND25wHtGQk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvxWC-0003nD-1H;
	Mon, 17 Aug 2026 13:36:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvxWA-0003n7-EH
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 13:36:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Uu6zy4VKhDVYus4IbSN/IWTl/lQSTsylDfTU4PVDtm8=; b=KFnQRi9ocCNAlXgL78ufux8HHU
 Mkyr53UTOFOpu0t1EWtCLSCZFFtZeRizrFC+/C5s8wK7fTAEobp7/tyiokMQdzahxFDGSAUAzmXXn
 ZM8UuT1oHvieaF3ZY/JXVrxkJ9RvYyV2g47qG5IlG0eJlo7Jo4IjukYoa6zyvbQ1NHZM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Uu6zy4VKhDVYus4IbSN/IWTl/lQSTsylDfTU4PVDtm8=; b=G
 DZIQRXUrOhc2K8rr1g1h2bGe/B1pWEdV+TMco1vczKTyyOyXIHWRaW9j+rtMW5eLzqr1w6+n4sIsq
 wd2Qg+lmVqnYd4oZNfB4DUFCh8PdVbuk8pqvg0SZUhXEBesuDwaZQZzp44oBKPhupzJpiP3vkowwN
 gvxJIp/4P3uKC6MU=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvxWA-00066I-5d for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 13:36:46 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47f7027ca11so2096331f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 06:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786973796; x=1787578596; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Uu6zy4VKhDVYus4IbSN/IWTl/lQSTsylDfTU4PVDtm8=;
 b=J+coSNx16yfsKMEsJomXAq8uaPzoZ8rHRe6lyfR6hJOUcWf+D2kVqEzeuxfuYnq0s0
 q3EleB9M4lXkvBqYB7yzNDwfNwk6tw/tf8xVngCuM7Rccc5MI5F8BwUcPh6ni7IxVxH4
 Jj0JWl7DMiPmAzEZnRnjsfL1Rs4d0DDv7yvpg2jAJ6XT0gnTTTz+Z9cwFZzd1rgHzktb
 mXRbhiRz67RxAn2hqjKDmDExdNfl9rDanTQbYyS9o2T963aKsj3gtqQ880s1uMRYtCwK
 3QKt0grDwbue4m6eEw/cGmArQIpHsS78FgQ69kfykMn2m9qL8v/LsVuBiimugwPrX/eA
 xvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786973796; x=1787578596;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Uu6zy4VKhDVYus4IbSN/IWTl/lQSTsylDfTU4PVDtm8=;
 b=j9Gu1ft/BZ73fMn3XvuwOBMaopgbZrk196Rqn3yZTOYWjLpcU/HF1mpaXCFpVDbvB4
 g2Loa+W0C/Skv6vPleDjECRaP0qiUiZNmfkV+flSRsRYVGSolTbhRs5B4dqhRt85c4QY
 cbJsfgiN+68d2SxeD5aSYrVjllsK2k1jSJEljh6R5ZZAX2smm7J+GtYIPtDGFHrVJ78z
 OREzHeEzLabuCuyETgjqSqguKmbqzIP0uA3f+9r0ym/OXq3P4zGn6ZY/l3iCsHt6X0Xq
 ZrEFwpk4iCKtu2tCNIaT7nMs8pg2j/dCeaFKPGD9pMyMQXSShh3fIAoOITXmBp3zXXIY
 PKTA==
X-Forwarded-Encrypted: i=1;
 AHgh+RooYtUK4DxvSiwtQUmoyuRMN73YijfPndJll/0DhFp+fM88eGfn0s4Zywj8DKV64RtC0ZxNW/fxDXqy8vCV@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxR/JsgQbRVfwk35GGTeqZ5gzfNJCrOP3wAe1f2ss1CtX8Re1sX
 umL8H13xzQbzaqkmIOuWQ9NPpvnhUjCCGx6hxje84gtm5GhBPeP0uNzxtaTaIx6Cb914kkktz21
 16sJc+nu5G2Mdq0PoJcdurFjyYQeEDu3kIv1rmo/eDekxelB7ghY2ycfvotfpIzkz8Bit
X-Gm-Gg: AR+sD13CX+88sI1WoFZEnDcFHT6GSLQNW28X9Cfuh25S+iQ4fKXCqYoOT54IhkGLvLd
 MdxxKMHAMQqpedo0SMJcvFVRuCKZf2sdgUhYYdBLCS0iNhTl82mrmuAVop2Le7i5S8JFPa776vW
 vGu8iEm8+W4o45mhv6UB9GLNLG3EPpCgpXLAkpy94gHNlKQef6+5bXwc8FHAOfKc/jnXKsUVqui
 +YLsX3KLZWkimuvtrs34eMMOP8H2s10yFtESyRLkpXd0KZnjvAgW+8LU7lNfaBw5DV+AiP7WwDa
 QWZrFyAZ1RIHpZKUKsn0ew0g/pD/7J24Daby7Fem5jAiuydUUJsBJBrhT0djIUV3HUJAaW0UNP/
 G3oTaYLV1hv3roRE7jF60lzktHcOjDyIDvrBsXQMA9MvGhKvPBx1l+l+EKN/C8n+9dI1cRX4lvr
 PZdkvNQS3waLmptudCS4ZJqjcevZ6sjMCZ+aza14lGSMJ82cFB86Vc7P5y+HwVLRKP57/DIQHe+
 MMKVUTerd3s7Ip7bsn/Tq0JmYrQx/turmfCTFStX39lwVh1niUrIMgbBnD0niXbJA5JvoDWhelJ
 wi9V4L+d/FZl3NdCf4234sUn74exaRHz3jiAXIP7BaRukWMzieM=
X-Received: by 2002:adf:e54e:0:b0:47f:756f:9a8f with SMTP id
 ffacd0b85a97d-481607ac821mr35067278f8f.26.1786973795968; 
 Mon, 17 Aug 2026 06:36:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a7c603sm4010190f8f.21.2026.08.17.06.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:36:35 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 13:36:33 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
X-Gerrit-Change-Number: 1844
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1844?usp=email>
X-Gerrit-Commit: 79f87e8fa83b20485262f5a50497d621febc5e40
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 13:36:33 +0000
In-Reply-To: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
References: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTU5NzcxMDAwLklkM2M2NjgxYjI5MDI2YzI5MjBhNjJhMGVhNTcwZmQwOTg2NDllMTk3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a14e0b227cf98b0b2c1c2afde95492599fea42dc-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvxWA-00066I-5d
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Reduce number of
 future epoch keys from 16 to 4
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5240746301263830221=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5240746301263830221==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kuQHx9x9iPU="; charset=UTF-8

--kuQHx9x9iPU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: razvanc=2E

plaisthos has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1844?usp=3Demail )

Change subject: Reduce number of future epoch keys=
 from 16 to 4
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 2:

(1 comment)

Patchset:

PS2: 
> This now looks good, just =
a couple of more nits: [=E2=80=A6]
Done=2E I added a more explicit epoch_da=
ta_keys_future_count but also kept the real number since I don't think we w=
ill change this often=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1844?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
Gerrit-Change-Number: 1844
=
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: =
razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-Comment-Date: Mon, 17 Aug 2026 13:36:33 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc <razvanc@mailb=
ox=2Eorg>

--kuQHx9x9iPU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: razvanc=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1844?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #2:</a> </p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">This now looks good, just a cou=
ple of more nits: [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Done=2E I added a more expli=
cit epoch_data_keys_future_count but also kept the real number since I don&=
#39;t think we will change this often=2E</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Demai=
l">change 1844</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
44?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: Id3c6681b29026c2920a62a0ea570fd098649e197 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 1844 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Mon, 17 Aug 2026 13:36:33 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: razvanc &lt=
;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--kuQHx9x9iPU=--


--===============5240746301263830221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5240746301263830221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5240746301263830221==--

