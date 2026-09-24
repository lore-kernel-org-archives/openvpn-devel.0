Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A04CC98317
	for <openvpn-devel@archiver.kernel.org>; Thu, 24 Sep 2026 12:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vjdR0Y2YGuQtJOOdFBMKy1BVIzBk9clVi/TJt8LdTSM=; b=KeJOI9ttGBXaXlGcHNoSPFFAoj
	6gkFagFIoIK8oTZw6qo/SgyVQMTsiZsT6ooVS8UQvPqfNJvbZ1Ocr4c05FLZ66SofvdxCYSw5BA93
	h3we/I6rx5P8hc8tD6EgB2i7lHWPJM4+Jss6TH8USxfDx/PRzohns7GjXWQOfGisxU/c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9ilI-00008I-TE;
	Thu, 24 Sep 2026 12:41:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9ilG-00008A-Q5
 for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 12:41:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vryz0vK6t+xYHFAWW4Ohm1IF8N+MYsjI0dSFhaq0Wek=; b=ODpgvkcRyr81U1Px8e7vCMgGHk
 c/pnCICu62X6+EvZbZSCYwQHzcAWjfOui4MFQbUpZSK7bGbTabW6K6GZGi84nFoYWiFMbn3fr5g7u
 DdxFtAmcNh8rL+uFzEZXHXbJV6Xh+IKhEsBeen8y7GdoxpoG3dXYGBaxO+qQ0I5QNjbI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vryz0vK6t+xYHFAWW4Ohm1IF8N+MYsjI0dSFhaq0Wek=; b=P
 INoC3dNAx2/FznKx+AL0cxX7CXmo6Mh19y1XgwkgP7ShA6rbMm25EcIcKw93CJyQvm5Mch23tH+H9
 Yndo5RXdoQXjWbe/ZeROaC6DVAk1NeTyLfzDSghq6OkRC1zxPEXRP7ftxmbpP8F1DuxYU612TfJlI
 Wdw5OPGn3lK3Bqfs=;
Received: from mail-wr2-f21.google.com ([74.125.225.85])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9ilC-00086w-Tz for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 12:41:12 +0000
Received: by mail-wr2-f21.google.com with SMTP id
 ffacd0b85a97d-482f633cd80so1204477f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 05:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790253664; x=1790858464; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vryz0vK6t+xYHFAWW4Ohm1IF8N+MYsjI0dSFhaq0Wek=;
 b=NrYFbKfI8yFUiwMs0/5UpviHyJQWi2FUqRgq3fr/3bZBDxNIsgnV8ewjYExfSgqhAF
 z9JiaGlhcnHfdCDhJAbO73/Kb16T6pWjYxGG9TZtUp6ZFGVc3WmimRjyfRgrBxO8jtj4
 Jrl/EC4OM/Y0rgtAtssuVm/+UAQxyea+jSdCJ5a5JN9pq3cU8h+xtR65HD9wvO/n1HQ7
 1sbaxNpb2zbdjb11M2UanLag7CSxcr/CgwV6fE8zUJklsXGvgk21swT+yYGduyVVFQXA
 Ai3M1jcJTIRJsIjSZc5niKcdTAgDcDGCFidXwfLp88vdmz4ftjms4nfmU1dhuZ/vcyPE
 K3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790253664; x=1790858464;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vryz0vK6t+xYHFAWW4Ohm1IF8N+MYsjI0dSFhaq0Wek=;
 b=nWFgh6KMTk9CMoDhCXOQ2KpRkDBUTtQu1W7ojVFLaWdEoVrq+A7J/VKDHUzlC1dAvQ
 jZbruiMv0f2gx9srdUw7tNi2wDdHDf1qMlXWITQc+MpXZKBPO7YK+N6hipQgQEKeB2Re
 VBplUe1Y/sIiXO1/PkQVQDxC4Kt3m/arC/j00TTagzFbaYB7EMIBmC1HeaWhEMmuo9q/
 AlxPP7V9Ckvv+AQVabitJXxD4mE75j/RrCFMeoMDXp0RNxtg6XLwtKuZoXPjMOVSOfiL
 kp2IaomStqDXyt7Bt91MDeas/aPzOFh+gv75dmWwAF1fy/GsVkCvCbHNy64JyM8qfCJs
 pDhg==
X-Gm-Message-State: AFuF++koHa0Q7v/mXQietj0/F3YTwlbJdgj5nmN2jXZux3KS7z8MAYs7
 sbkwoOhM9wBWyA5TlF3Z+WaIQuMrK9u96yU7hqDLyIayMXdP3J/V2trmwbx9SUmrvoQvrMY2fNG
 Dhb2JcgNDS23sXB6lVKriw4OdTWECXWa8m7ECt3NXrhy6VgosckSPi7/Ga6hZdpxjrsvU05pYly
 i5sAAmFw==
X-Gm-Gg: AYBFou26ARAjWKwQhHoeprBPOXM9+HxFDmfSUdJSCicy1ZQxQy6+HVeXTe/fp84irR+
 yHBJMot+CND2YaGhz9zYJ/c+M7Vbp2yI4X0FMNEzHYeTZ/bPAM9OHAg1XlFT8LJifWBGZ4HWtx1
 nrOlc6HE3yH4xex5gXTmjCe13DCSMlv3jYFuOUPLDR1wirZl0HCPY0AdZkDwXVNB4E51PQ05zM+
 NB7hGqHWWzpLK5YiyWIxMNePdUyyIjCAn4UnHKSZQi1O2mx6HKSrwcJd7e8VlYkOjQHAI4XANMu
 WJmrgLB/ScwYYGAABaCSq5RGeY4fnloVBdsV9giFeLf6jUtpNU8jnm0PASXpE3e2GkueplRwfxb
 qCgwDEtG9kDjfklHoajCggy3bjyLTJ1IHTK7Xl3mPuhKjd2SqOroHwahfY/egUyeImFiHx7M7gj
 lOForXh/uOx0YxBwsjRSoHA13c8Xf0U3poriA761xqbakFxNEAfMKCbhpOeKVIxnjknDNyJk69/
 QkzYgp9r6OJiOX/ERKRebCklJAvz5w12cInF323CfsZr5E0ZkMioscEz3rtl4BK49BWnomb1yLG
 3unoyq2dTFVhaszdexd1VcHymZOhj9qThWXFkttjEiaU5fh8MgcllZDkWns/A2E615ilDMk=
X-Received: by 2002:a05:6000:4310:b0:486:f9a5:5b4b with SMTP id
 ffacd0b85a97d-488716995b8mr4282704f8f.33.1790253664255; 
 Thu, 24 Sep 2026 05:41:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886876c500sm15270070f8f.19.2026.09.24.05.41.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 05:41:03 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 24 Sep 2026 12:41:01 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: b777402583b3385f7b9c68b189084eaa469d0740
X-Gerrit-Comment-Date: Thu, 24 Sep 2026 12:41:01 +0000
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9ae2afbb22bc88d1efe55eb38c9ee394334ec24f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9ilC-00086w-Tz
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change most
 ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL
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
Content-Type: multipart/mixed; boundary="===============0242467538830903524=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0242467538830903524==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6VgWT2Axsec="; charset=UTF-8

--6VgWT2Axsec=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1942?usp=3Demail )

Change subject: Change most ENABLE_DEBUG ifde=
fs to ifndef ENABLE_SMALL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 9: Code-Review+2


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
Gerrit-Chan=
ge-Number: 1942
Gerrit-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 24 Sep=
 2026 12:41:01 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--6VgWT2Axsec=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld has posted comments=
 on this change by plaisthos=2E</p><p>Patch set 9:<span style=3D"border-rad=
ius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-col=
or: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1942?usp=3Demail">View Change</a></p><ul style=3D"list-=
style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail">change 1942</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f96cd1c3488b558b8a59=
7594d99edcba1214d27 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1942 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu,=
 24 Sep 2026 12:41:01 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </di=
v>

</body></html>
--6VgWT2Axsec=--


--===============0242467538830903524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0242467538830903524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0242467538830903524==--

