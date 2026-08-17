Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD983C5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K59s18g2DmdnVmHxnjccMmN7DRYhqw/5IlduI3wUngU=; b=bnpWOuxyY/PZbRYbw94JMO/2OA
	6BqeNCxKC1/aNcxImi76ttm0KNF7eSke+YQExYJHFOa/PfdvyyVUdzm3LSWrBI4v97Aj2cMO5HwYG
	YRsNi4qirK4AFQojkjDInlAijV8kep9NppNgCFPB58S1BZJ8JLfJqJH44lXX97F1sMM0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvxcY-0005dg-Il;
	Mon, 17 Aug 2026 13:43:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvxcW-0005da-IN
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 13:43:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6NgIoXaByOxZX/daIoQPc0VMnRCoxp2gi1C93QGdrVg=; b=A347aHZwupUUU79qnSvy6OOw/c
 FR67a6je/f41hGftz7ia/6sVX5GDxz4Pq8obx4wviGyaSsKZWni9FjmRwhJ6A9f5MQS7BCEkSMeUZ
 vlmAfqIKFjzlNyCISfThoU3JNMbBiORYkHC5PsRqIu7G6t5u6dkCdv7PovbCS+wodzQ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6NgIoXaByOxZX/daIoQPc0VMnRCoxp2gi1C93QGdrVg=; b=n
 AsiL/Ju9BnN6b+JDX7fn9q8Spxb3pfqjohVXOj4dnvHVfvTVg2NmXcuEL+d0pN8o/98NpHmPD7FsN
 7ybjaZytDYAYajHNCMxzAvGb+J9AdC2uxg101FWr72+BRXQPvSXvvbzhDZqebKkVB2f7Dw7cghm42
 6wLLT20dnuaEH8pU=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvxcV-0006OR-QO for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 13:43:17 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4956242332dso36464925e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786974190; x=1787578990; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6NgIoXaByOxZX/daIoQPc0VMnRCoxp2gi1C93QGdrVg=;
 b=UO+10KPU+4p8Oicqs1rktIAzk2rdAw6fukz0DUoQAOFD4tkfHOlujy8Dp7qGbcMqiI
 WK4FAO/WqgakpcBG+zLpazpI13VVYJ/I2W5xVie9zy+K9NathkS61wNSgIUrZW5AhNwv
 06tBs0+8K3yLw3XBpdbFWD6WQLr88J0uG1UZxGWGmgYC6RB4ceqYjTLqs1BZ2Af9osPV
 g9eVhI5cn7rlz0At4gAtbKbZ0GtQ+cmhhKb8F83Cq/K9xZie6MnZj0ZCOH/yrzl5EymV
 hdslXAgtL5piNFmZRQIM7mu7Iaunyp04GlF44hLel7Tq19mdqB8DOZCYRvn8YVjIdWs+
 +dwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786974190; x=1787578990;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6NgIoXaByOxZX/daIoQPc0VMnRCoxp2gi1C93QGdrVg=;
 b=WavbGItFITeU3LYVEwPYivWeHbMg7iHsFohVOolJPWUyxdbZrOQb4Iw3Ngv5HMOYna
 ALaM97xmNPkDpWnx63ROzTu26omK26iCuc5eEfCBS9j7jaZnMOLjf3Ads9dAHTC6ydWb
 h1ZXlxCFf0/Pku0ivgr/yLDNTWCAHyZPJM6BeLmt42PDlGGa/L3iTpDS1U0IGgxysLBp
 ReNsr42sdlkuSkEnO3FD5RvMMySB9OyFoLLZzYptQ7LpfFNB9wQ/oSAeDCwvjcjfDiIe
 0xV2oDwC29Ph6Ek/1KFOL4PII08J4j5BISaJojyB0qQDFsRhy806DqjT7neBjFEi70si
 CNbw==
X-Gm-Message-State: AOJu0YyZ8uUeXHNV9Q03+TmgkN91dTjgm9432myXUyUtomTYHp2u5tin
 76oWmI0EjMq3co25e61ywb30bVv3xuempLT0klnneUAzmF4fm+Q/QVIOtxUqSQd+YBKTYxts5hx
 YyEgmRnCGBLOSd3XynIqFBSoS+n2/yJ1b3pT1Pf+OOyrIKvOZefuU0EXeQjkjTW9nIrUQVuFllq
 timEAwXQ==
X-Gm-Gg: AR+sD112HpGC+7RzKDl0F7QUjccJfithwm5xEFv/eUqbwmskL7/Rg025H+hao8IjGLu
 i4jM6vMrffT9WDXOKMxJvZeTV+L3+M/NYwqEwD4W5le98RNILBVnlF74OrlqvArMGG1dZQ+6HZu
 MNPeRENvhmVTC9x5y+OqAIG9muE5Wv7FN+JLkKLIGvflZ/8T52Td9gYxkrlZjupK7bC4+NhgSkm
 0ofo6s506/nzgl6W5Nw4/pMpzSLC514OMj4Zx30CmiO4Be7KpvGorzFj6RHJDPWvzE7k58g+asT
 2DI0gNcYXzts0YGR8vEtbl7jSpbn3OXT+0zKSDV+6rTLSg56/AU+RwK6RVZ6kgrhaxbgFAXO6/L
 OqJREd3DWh+CI5Y692ZtOZMRwLjZ1SfULmPuNpbGObgNFrFOFtWxqxw7nR0yZ0dVzjUY1yUdm5h
 4mfP+V7wkDS1hDbCVdf71nNlEpW09pkjCE5aETpy/Jp2NICJJxAWbffz1BQvfhT21sNGjLEZWVR
 EhgkECXmwYzOBRbEAKu60wVgXfGwhxU3UaStY3BSa/UYLpJpmZEIlF4o04diXHgG3SSCjfEU4DW
 MeSW0qbaeGK3uDJY+/Xqg8UzNdWtqW8f5DLkcj5PThbBR2M+lb4=
X-Received: by 2002:a05:600c:3495:b0:499:873b:471c with SMTP id
 5b1f17b1804b1-4998794fafdmr430247555e9.6.1786974188514; 
 Mon, 17 Aug 2026 06:43:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d086c6dsm40819835e9.7.2026.08.17.06.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:43:08 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 13:43:06 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
X-Gerrit-Change-Number: 1844
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1844?usp=email>
X-Gerrit-Commit: d1aa12f7c12ec03bdcaf0659d5ccbbcb198d7081
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 13:43:06 +0000
In-Reply-To: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
References: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTU5NzcxMDAwLklkM2M2NjgxYjI5MDI2YzI5MjBhNjJhMGVhNTcwZmQwOTg2NDllMTk3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <923630877be9041cdade4cb585020cd5f9d7a97d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvxcV-0006OR-QO
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0459119956557163316=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0459119956557163316==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aPa2eYnHs6w="; charset=UTF-8

--aPa2eYnHs6w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

razvanc has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1844?usp=3Demail )

Change subject: Reduce number of future epoch keys=
 from 16 to 4
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 3:

(1 comment)

Patchset:

PS2: 
> Done=2E [=E2=80=A6]
The co=
mment still says GB (not GiB):

     * One epoch lasts 910 GB with 128 byte=
 packets or 78s at 100 GBit/s=2E
     * (respectively 1011 GB and 86s with =
1280 byte packets)=2E

Did I calculate wrong and GB is correct?



-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570=
fd098649e197
Gerrit-Change-Number: 1844
Gerrit-PatchSet: 3
Gerrit-Owner: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: =
Mon, 17 Aug 2026 13:43:06 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: =
No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-R=
eply-To: razvanc <razvanc@mailbox=2Eorg>

--aPa2eYnHs6w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1844?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #2:</a> </p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">Done=2E [=E2=80=A6]</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">The comment still says GB (not GiB):</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">     * One ep=
och lasts 910 GB with 128 byte packets or 78s at 100 GBit/s=2E<br>     * (r=
espectively 1011 GB and 86s with 1280 byte packets)=2E</pre><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Did I calculat=
e wrong and GB is correct?</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Demail">change 1844=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id3c6=
681b29026c2920a62a0ea570fd098649e197 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1844 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Mon, 17 Aug 2026 13:43:06 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Comment-In-R=
eply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--aPa2eYnHs6w=--


--===============0459119956557163316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0459119956557163316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0459119956557163316==--

