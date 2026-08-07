Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C122C5AC7C
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eIcmjjdiF4h4i0B0s06guBOrAH2tzMmn/5JI87ey3/8=; b=GjSMznpsH4MHEnPOEz6rkf4AKl
	m7tBZpbh7MVYh/M0pWt1JQ2nFP7u7E7sSEaAWgz7VVLPWDj1LAPMcz/pYstFYTURf+Wj/j0woJbWz
	HGnp26vkhhAhKBpqExHlgzO59WqEqYBjevvqLMngR5TYZQwZKKHS7prUUUWiOdGd7L00=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsHoI-0006IS-Oi;
	Fri, 07 Aug 2026 10:28:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsHoD-0006II-7g
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 10:28:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jfdMvNS4XlCtzEyn251zpbMu4mtDeW3Hj59XiKtFxC8=; b=eDAGknR0uMjpDPYZSFeCNyRps/
 imXUym9lrvixRiJePUqFNft7nKgJvlOXf6utrvn9U0typbFKq7WWai3KtFl9lNeEVKeku2SSalFnc
 2kb3VazVi6/MDcx2f1ucgACQC+lbcUt8c86I3HN3kTftrKC2t890LESURGvIG5j1DjlY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jfdMvNS4XlCtzEyn251zpbMu4mtDeW3Hj59XiKtFxC8=; b=N
 dnh3nqwjaVnX5WpmObHR/1xAjYxZJGIxG8oTZhIpDXYlo7l0n9b6HG2cToY80FS6pj3tHcWsO+atj
 KKY5zw7hiYcQDW33Y/Njz9CrQ7wmqlj0K5PNgsX6ZTVoqLBvzEvFMc9p97AHBimhGx8jHST+bXyX3
 SJrw82EHcghX3dOU=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsHoA-00044M-D7 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 10:28:11 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-495437bb891so17156985e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 03:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786098484; x=1786703284; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jfdMvNS4XlCtzEyn251zpbMu4mtDeW3Hj59XiKtFxC8=;
 b=DEF3eoLpxPdYvwne4x7zJvFMncPlPICJBBZiwINgb4gJ4bQOXlvmCpf80CPX2hUaML
 4ogHXL4KHv5Oq7ACSWFBUQrWts077ecw+nwzE7BU+Euzvka2qY2M+AoEAai7XDjlr74Y
 Cdn7fxWY/y6zKIKKQ/xOUwBb72Br5h7mrhvJqeelPzheQkciZ3nsJqzxFL6PRoVF3hJn
 BDwgcW+9a3u1QLDW1QJT9Ra9Hxj2LdD2Xe9NXmhQk7vuITF8YgBoxfy0isQ4zFkr1TJ7
 Lp9SFAopTQAwGW3BZOctlPfZa1qy6BTEumMQb04FlZoR9Ah2sY6MUUZztdQzV7OyWCnR
 SbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786098484; x=1786703284;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jfdMvNS4XlCtzEyn251zpbMu4mtDeW3Hj59XiKtFxC8=;
 b=IywzSx1tYyqdJyNXskGaD2xZQMbGzFYmbrbCN0T/vkGRMKHCU2Zxf4U4wRiCuqMO5v
 lXWea8K456ZJJEmtj5ybqixGXno6M4NxdFTkmofHwGLjhE9b5OTFt+7KQPtFAWZqbiEe
 WET2EM+wyAgemZxTYKVq5rrjqF/T5ENUg5Sg7Fs9QFKMSDgUpWM+fpNnMWqLunl5KqFs
 G2xDPeqIKDRb65TdHpUX5fLHxAnTT4s6jxeP8ur3Xk0KwGMlSz0OgaO+h4EEd9k4/2fQ
 8ZHpfqELXvNdyEohZBhMY6SDllIWe5kDiVQ/fqsvveHQRVw8sBdOOjAsVkxPhr50z5b6
 IpWQ==
X-Gm-Message-State: AOJu0Yw6QR3QGOsalfxvmPub358FU377Irz5zz5E0tdZyv/SSwGtFYXT
 G8E1s3zzN05YsNl39Dd1MBjSWkavkOwR/9afmTuv1lsLQg+tc1xeH8do8xkf/Kn7PBT0gpkMdco
 ZeIj2I9oCPDQKvkmu57Mst29rp8TICVPozvzR2d3awG2NihQTKNnks4nXH9B18JA1AVz+
X-Gm-Gg: AR+sD12GJQAKURa37l35UfNzR25tpSQzClS4gZ2ngQIQ1QywRvFdl0Zo3W9fYoT6FY3
 U7inR4D9t8ppa9uUlaJh77x9ANC6brdKJFD0q5B0BvfqMF6k9GdxlhuLefW6JXTkXjxAAx8BXyV
 XD6YDecpLcT7RCkyF2o1bhH8PU5AeWFKc4OAbBmqtWgnEaZbmFAqAPTnkfq8pxVmTbyM7X07ywY
 Zj5e6JM58X/2qAfD6NiLwQkwFV1IalsitvpNd9FX0G5HEHFS98TElH3HrCUGvetjOVS8uasmlNu
 E4sGueFnKkwpeghojio0bHvFYhMvLCJZMIqBxHn2VPHjT806jEzXZ7y21CeldP8Lu0gMz5Kuqug
 +pHAms2kA73PrQEdi1EI9gJH1fCxUTaMAeEagkZTTAbKAV75B1ZL7s/2td9ddNX6AtUS168rcS7
 Q9Vi4X01fiuedsZtqeUzp/GkPzBbV2ApNHz7gAB/x8hMvXNJVwv9AsQrXUT7LW1wClenOat7H0R
 Foz2vukMSWf057Q+RQ3LmqjuhvsWHQJh6hMmjZEDbeYJ+4Wgk76txbTe73n5PmyaIloqMTwVBs8
 Tmshp4m6SndKb8PW+NIWeMv0PmhrkzxZax0qF30rjAmXW9waMfU=
X-Received: by 2002:a05:600c:4454:b0:495:3a52:71b1 with SMTP id
 5b1f17b1804b1-499553d5ab1mr119213845e9.5.1786098483686; 
 Fri, 07 Aug 2026 03:28:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995e9e7164sm32966505e9.2.2026.08.07.03.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:28:03 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 7 Aug 2026 10:28:00 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 25
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: f663c5f5f607e7e8dc1492ec43d6a7d80fa9c748
X-Gerrit-Comment-Date: Fri, 7 Aug 2026 10:28:00 +0000
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f374e632ca8ce671065282414da1b85adc119693-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsHoA-00044M-D7
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Replace custom
 hash_func with siphash
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
Content-Type: multipart/mixed; boundary="===============8922991910748866102=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8922991910748866102==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lrZMusnbL2Y="; charset=UTF-8

--lrZMusnbL2Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1573?usp=3Demail )

Change subject: Replace custom hash_func with=
 siphash
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 25: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1573?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I807f398903ac2047530800c29949793c6f4f0ec9
Gerrit-Change-Number: 1573
G=
errit-PatchSet: 25
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 07 Aug 2026 10:28:00 +=
0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--lrZMusnbL2Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 25:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><ul style=3D=
"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail">change 1573</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I807f398903ac20475=
30800c29949793c6f4f0ec9 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1573 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 25 </div>
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
 Fri, 07 Aug 2026 10:28:00 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes=
 </div>

</body></html>
--lrZMusnbL2Y=--


--===============8922991910748866102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8922991910748866102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8922991910748866102==--

