Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323C8C4451B
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nzvfh6PwYzIyCDdnAegn0Gk/JtJJ+SrFzFFRicBiVVk=; b=a5DD6FeJ30IY9FioGd8ojy3Kpl
	3fZDCAC/kiqs2QpcsobgSxPX5FKUiHZxuljnXmQWmx+WvPgArJd0SrGZpcGpwR0570AcH6oKu+tAF
	3XMQx4XpYthS2xyg8n8y9A+82H8xAG3ypubfS2rhDlR2hMJwnpFBAzkHgFp4G9ENMgII=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkj75-0004oc-5A;
	Fri, 17 Jul 2026 14:00:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkj73-0004oW-2m
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:00:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BZRHcQ6yLiyYauJ9z+v2myBwUo7v2mj7cIJ8rNklQZs=; b=DiZn8v6M9UsVrXDMWw8ChgpJOw
 UC7XIVMhDkAK3jW2Gu7tnTzLAxHMfo+rigS923YqXiiPq03zBzUok+e2rrlmBzerYz1b1eGCsJXKC
 5YqaEZKTPa1yWD3tizVUOPd5YqkhzeexMkYzwlRFof/uzKGIFIPy8ipz60TWedswJj+4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BZRHcQ6yLiyYauJ9z+v2myBwUo7v2mj7cIJ8rNklQZs=; b=Q
 3mkCcQ7xPuGDJuQv1UZHNktwegBDWugeFG6k16hlNV6yzddr7+hXi4nbbwzH8NFpPSowN4xBDwC21
 IEZIUrEpZVMu/MLmAiZx9Whjo/jNWVPVzuRA/qDmjpZVOLTqZ3zhjRVWTUKmBpsZBzqD79UkMNG7i
 7Z3BC0KkrRufUAGs=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkj72-0003jn-KS for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:00:25 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47db714766aso828227f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 07:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784296818; x=1784901618; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BZRHcQ6yLiyYauJ9z+v2myBwUo7v2mj7cIJ8rNklQZs=;
 b=c1cqXUScGSApNNVcERBSdBB/YzjwPEdobHD81ika8rmEwSbDqWmYGGED2tdYlw6xFI
 kAPSgU3WM2VuK8cmi1ar0NMBbt6ngiCiFuFhbNeVGfWIdXqS/wNwATIYLo9tK7r/XZ+q
 S1Xfz06nr7fc92rmZD54Lq/c/aSWA3G9ggy6BrfuxaI23cTQ3EKfgvX5TXdUstvNH7Og
 K6UjmvWHJhn3Q77BdII1LKXRbyYvrDtdJRtPJpP3jD8jDWGwuy4UF4wqCM696hZfi87M
 1yG6EmVGDsH71f4ahF8WycLrQhfXz0fBzXFhzYAS7R9z2J/EcKKI/Vaw84jEMHqO2iqx
 miLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784296818; x=1784901618;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BZRHcQ6yLiyYauJ9z+v2myBwUo7v2mj7cIJ8rNklQZs=;
 b=IiVKyKQN316uNmX/MzdCBhUHhSJe+JECyaWpR18sFNtR/tSUPc/9KAoe/v7nPkuB0U
 hGPNnSBkNSQUpStVy+yJBGbRJXO6lyuhhha8MkgzMXYZvaglQYYfQ2Ja4B0SOuginJp6
 xBosmrieyQuhCxgsRpZc7Ze1AfaRuBIf3025QnO9NVVg0iunJCWK9/lfUpbkj0ivOli4
 7bRvkGf98U8V8LkY2RxatM3OluAuBnrHHqYIu0koy+9FEltZqJlB8cIVzIhemPPX9CIi
 xFGBFSl09jBc09CWUdMFAc78a2cvZ2VjeVDh22LhqTo5VNLf65/wn7VinhgAmV+rYViY
 PAOg==
X-Gm-Message-State: AOJu0Ywk/1hY84G7kTAm9OlvF7BSTJBgdhXWODpYdK4mdswhYRmflLtJ
 gyO87vXwPCmd3b4Og3gwNbKMUVXEtUSzzepy0cCcGFhVwTrQvTehnFHpHHPJTFaqaptptHHFSJE
 GO3sztwWHU7RaRQqY213Wpjwh2a6XN7+NxvSALEezu0jkrwSGymHhZjW1gf6T37J61ILy7d9Mh4
 sEAanAEg==
X-Gm-Gg: AfdE7cn1i6pZxBei2tk3nxLKk23mT4eHyH/moDoQOeP+Na+FGzY9KTs+GUmHc9Qk5Ll
 YoYbzq3MaNcYr2pqj8U+jH72siAW8c5T2aZt8nEmA2jm4jHHliCps4q+PvYlsiN7ZDMU2OmiMUQ
 R2T8vmPugpU7/AZpRimctAVKHiqJaWfFgI0X2NDJQM3mvNguT48rKdHIPl0v7KCFIo6tpZzTgIn
 a698yzz07jTXjRM9QE/m39HGtoz0d6SIAz/t10eWx/a+0j8bqP7jiwmCyTBKTd6JU02h4IxEk/k
 rGGxd7AYs7e/LH15/E1k/1IqIqQA2WLYrQdJ+qLT0zHNgg+s89YPALsYMjuX0RNOUor5Ene7V+O
 z9oymNODeYWxvyRrEjyoQswtqI7EKl3V09ip+EIazsqNPNU9MK9v2Z0qPZXLG1XIOQkhoRydF/5
 rIJ4z3Ni1md26hqSXP+rLyQ/YrgYfg3PQ1Y1kufzF815TvBK9sskSB/zrCHUs5ovKAMQb2j8e/2
 xFzzP2vxgK78Wc/lBPR+jTViKMaRo/uO4jiy0FbTMHqmGp6mdGh916K5ZJdaKkjlSU+3PJSHa+f
 L8c=
X-Received: by 2002:a05:6000:4b04:b0:470:b344:22e3 with SMTP id
 ffacd0b85a97d-47f5a548818mr9525053f8f.18.1784296817640; 
 Fri, 17 Jul 2026 07:00:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63eddd27sm3938354f8f.28.2026.07.17.07.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 07:00:17 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 14:00:15 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
X-Gerrit-Change-Number: 1725
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1725?usp=email>
X-Gerrit-Commit: 80db22e527814dc2b948f04afb83b6e93de5395d
X-Gerrit-Comment-Date: Fri, 17 Jul 2026 14:00:15 +0000
In-Reply-To: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
References: <gerrit.1782134588000.I37ade55d7674c68dd98cf4dfde35c4ad42e20d39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzN2FkZTU1ZDc2NzRjNjhkZDk4Y2Y0ZGZkZTM1YzRhZDQyZTIwZDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ea45e3abf50bdcbe4e0b90d2d07b9722ec56f9e4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkj72-0003jn-KS
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Extract
 multi_get_instance_udp_real method
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
Content-Type: multipart/mixed; boundary="===============1907516319181983415=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1907516319181983415==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C04D1Fx2I0Y="; charset=UTF-8

--C04D1Fx2I0Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1725?usp=3Demail )

Change subject: Extract multi_get_instance_ud=
p_real method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 4: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1725?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I37ade55d7674c68dd98cf4dfde35c4ad42e20d39
Gerrit-Change-Number: =
1725
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 17 Jul 2026 14:00=
:15 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--C04D1Fx2I0Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 4:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1725?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail">change 1725</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1725?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I37ade55d7674c68dd=
98cf4dfde35c4ad42e20d39 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1725 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Fri, 17 Jul 2026 14:00:15 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--C04D1Fx2I0Y=--


--===============1907516319181983415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1907516319181983415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1907516319181983415==--

