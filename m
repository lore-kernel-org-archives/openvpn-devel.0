Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8947D606A321
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 01:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QO+gNQUX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lV+ZfIIp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bn/9mSAv;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ku9AqD+b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qeNiHKjORoStMIfWo0dOHAo0Z123XmJHvzKfvUaT6jM=; b=QO+gNQUXsv09FqS3b0pKF0bZJN
	pQF91D0afD2IeKaq8i7vVcCov9gRADrR4juI/67rO/belsWWYepo7+y5eP7wfL4q4wY5nBmOkx6qN
	N6mLhYYrnZFe+MSqz57bk/rg9ZyxnFh0iFnGXOxYCy7RpQFiwVwwuvDVebVs9j9Y9jEo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWksu-000000007Uj-0Qa0;
	Fri, 27 Nov 2026 01:36:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWkst-000000007UY-0GcC
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 01:36:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WhPnzcnfy4O0l5QebxUrdleZOQw2GHsIMnNuHKc7mJ0=; b=lV+ZfIIpk2PY1ZTPIqMU0zOsdI
 18wEgimh8paq1ucv8kBIJaHqKFTCiO6p8MvbNZ9Yjm1j9ez7rg5DQ8i7gA0iwwiSAWmB5yr8dRbvc
 CucEKsZbFVUTBP0awpWJhSQj9y4BU56gXLB0pRAaYgbSZUuDPkFoNLfMMbdSc870wuUs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WhPnzcnfy4O0l5QebxUrdleZOQw2GHsIMnNuHKc7mJ0=; b=bn/9mSAv+WSW+5lwQ2uhn8IbV1
 aN1lhQpX0+IuWUpskNRqL8AcZmYc7gvIqM0l+cCMDFscse8PKaV076g3ERl13I2DSRvmP372PmRbd
 yJ74j52Jf4TROEGZ1BKD9fwdi9VGEgxUGXBbtpTIX4YYkgvcP2EUGHmukpAHR9mqhZTI=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWksn-000000005Wu-0L90 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 01:36:14 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so66100415e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 17:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795743366; x=1796348166; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WhPnzcnfy4O0l5QebxUrdleZOQw2GHsIMnNuHKc7mJ0=;
 b=Ku9AqD+b5YuQafHv6SpPQ5xZy7+DVUYYWPuU8N6ZDExKwJhj54ZAQn5AUm7UQWwogY
 I3/75RWnunSm4OKuyNG6UbUvJMt3q7fC+/GJKK5GrZfFnxdZWb1GN5XhkPORABE+uAT9
 zlUWMxIbJ/PJ+Ic8bP063pSszN4v7bJO0snglmnVOx6xGaSQusvBJ6BnIYdqr1E/QMu8
 cx/wikGZoIfNUC2MFyUiAEzwaLV79Ok5YrCc9icN62GV1lw+BVUQTzdL+dtw1rbU6t1u
 4ojsMa/YXO33lcynXd9kpNga5Pi1IfBXLSMu9/Y6OMeRPIe3ukHDrZpJXHQNtXIOYaQK
 9cTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795743366; x=1796348166;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WhPnzcnfy4O0l5QebxUrdleZOQw2GHsIMnNuHKc7mJ0=;
 b=RcW2zwdNgZc6t+ZqDVPMoP0f14RjSTcZ9oGEnopx0CthT2e3kplKLB56CX16NoKhkQ
 57/fSDsqofSGccY8fbXUhpOkAXnhoHW+8QxzKESfuzanPeZPgRp8CuunVrKQneYTyTbJ
 ue3+KpfNsiirFQtUd4lR0z1X8AMm2ttysG9b298Hu/+HKBr+9Ze9kdmDazs1z7v1TlH4
 XadH3zF6jfbsqUPmnKrmwhKhixYsyMXsfgc26Db7uYU93oUs6hXwuE+DrhZANGxu0OLx
 xu5Gn0CTWCPXtlEcyCMcd6BdHeiDkKSIhcBmzdJR20rIZi+jo08tAk0tQGTYyTfD3Zpp
 jWOQ==
X-Forwarded-Encrypted: i=1;
 AL+hErER/yyp5AmXC4mL+rpT4idbfXdzVIPrIDUX8v+ktR2PLEWzMdlTPGXkfQFm8MJT3Px8lksuMstzB4nGtJBJ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8ZaPCFvC1L0vbcvYg23vLOFDezE2d2geiZ9Hah/1TAK313RK3F
 OFgn2aNr6oS9L0VSLm0cKVmrAtPpEwvoRobLzlx6QUq4jkwFC+ahFYVLR8myxleBsytBPwBe3y5
 0WLPOd1vf8vSdk4EIENmDA8MuGbHr1rxTrWVBQ0dISV68RLZ4tNAfpFs9MLFPmg/9gYkE0I2Zi2
 tebUOFkA==
X-Gm-Gg: AZFdTZfaBJUolFIbVwZKTgo6Uu8P0QV7bg+8J4ZvNhg1rhjO/E3C9C9flYxC6OPRP9p
 IkgUXDoEcdMwJmAqOqBb0uwicMlyb0zHTlAp+mKdw500MxctjPoUPbuzMy+LPMDOwgERoRwYARj
 bEFK0ppjtkJZ32phgkrXnFG77hHOUlxBqXPA73Vw7iVaazXicZMPJonYMWlFvlqdCU+atOinWZj
 y7UWSLB2MwupMXVlM3pbSZQOrDK5UfTA1DrKP1OHOR4Fk/9PGTBl655zAUSfHBm8mjyjKM8yfDn
 lWxRM6Ca5cRMXeBtgyEVytKB/qcv6+rYUgQqGChuQnHCkaO/WxVMTPzg1OqgpUjEEgLgZCkUzTL
 hFc3f/wCLWjcQWjTLKhYzlbYPaz+wExx34D1gSL2PI4GJVMgQwWytEV0XARIbgl0UOL+if6VYxP
 6P7jgRYl43YC/1jh2lzRhlkyG+dT5LA08Sjx7WXH3ZihG9jPG39Ai8oguh+eesU0i0//GNFRI3J
 vkvD9e7tnPCq4vKUpM7ef5jY46t6Z13u6kAal4+QiBVcPlilACTR7HEdHIGRvt08vZmk8JRRYdB
 jmmBpWI69whOuimsbzxp3pgMKhNF2UdSak/HDlgTDae6J0kNfRpcullxb2rNkUE6O8UdhbYapH+
 rIM3ihJ4XHxwJcb6z95w5pm9K1GIDJL2O/E5PFD3KiGpr+pTsYo3URPirWR0UPsyQMLqOfrEYpv
 1/XYGllSuKQt6ZpRQ0
X-Received: by 2002:a05:600c:a317:b0:4bb:a5f1:fb56 with SMTP id
 5b1f17b1804b1-4bba5f20897mr111269425e9.26.1795743366344; 
 Thu, 26 Nov 2026 17:36:06 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b10b5f6sm41358224f8f.34.2026.11.26.17.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 17:36:06 -0800 (PST)
X-Google-Original-From: "Max Fillinger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 01:36:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6c6dfed1557608d5b1442fb008bf84fa4f948579
X-Gerrit-Change-Number: 2359
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2359?usp=email>
X-Gerrit-Commit: 165b8298c79e51ec1a92bbcf3c324df48879ced3
In-Reply-To: <gerrit.1795743323000.I6c6dfed1557608d5b1442fb008bf84fa4f948579@gerrit.openvpn.net>
References: <gerrit.1795743323000.I6c6dfed1557608d5b1442fb008bf84fa4f948579@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzQzMzIzMDAwLkk2YzZkZmVkMTU1NzYwOGQ1YjE0NDJmYjAwOGJmODRmYTRmOTQ4NTc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2429043f7fbfca5df752479442bc1e9e123c2198-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWksn-000000005Wu-0L90
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Reject certificates
 with too large serial numbers
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Max Fillinger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Max Fillinger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7542005511108954965=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7542005511108954965==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Kha8ALcwDqg="; charset=UTF-8

--Kha8ALcwDqg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Max Fillinger has abandoned this change=2E ( https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2359?usp=3Demail )

Change subject: Reject certificates with t=
oo large serial numbers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Abandoned
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2359?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: abandon
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I6c6dfed1557608d5b1442fb008bf84fa4f948579
Gerrit-Change-Number: 2359
Gerr=
it-PatchSet: 1
Gerrit-Owner: Max Fillinger <max@max-fillinger=2Enet>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--Kha8ALcwDqg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Max Fillinger <st=
rong>abandoned</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2359?usp=3Demail">View Change</a></p><div style=3D"=
white-space:pre-wrap">Abandoned</div><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2359?usp=3Demail">change 2359</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2359?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: abandon </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6c6dfed1557608=
d5b1442fb008bf84fa4f948579 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 2359 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: Max Fillinger &lt;max@max-fill=
inger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>

</body></html>
--Kha8ALcwDqg=--


--===============7542005511108954965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7542005511108954965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7542005511108954965==--

