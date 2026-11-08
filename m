Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98370606A326
	for <openvpn-devel@archiver.kernel.org>; Sun,  8 Nov 2026 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WRZcl488;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NzqBjHRj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bcwO1Rvt;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZjWM7vbv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ldRq6c/2rDXihlPaTA1iO+eFhbd7FyIKPwr6C6VJmcY=; b=WRZcl488tMGZDm4GxwVhFEA9C7
	w5AfPxVgXIO5XcVtoM0rDjRZ57F+ooJ3mUGjvfNguyEi67u5x98LoJxrzL3KunxPvnsq+rEG4AJ4n
	lSraHB9EgS5hcKnoLYDqGgr9B1vcY3k5auCijb7OOLHt29HbBqNJP8ueR82bJYw8+5mM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQ9WZ-000000000ih-2o0W;
	Sun, 08 Nov 2026 20:29:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQ9WY-000000000ib-1lAq
 for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 20:29:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0HO77s8B/gXjoRFi+4mv8kc443Tfh+kNBlDZDaSqR0Q=; b=NzqBjHRjyTrMP3JqKQf4oGrsuN
 LW2k+ALsc/Jxt8s2qcc9fAo6Mtuo6LUodr+ujFv0hQ8FgdXl963xAGqxIWuQVyGzfjliiC674oPJ7
 q6D6epNDy8XkmOpSKIDtz7K7zib0nfUf87OKOQQmXIFRft0f9wVchb0qAG51z9J/MAfU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0HO77s8B/gXjoRFi+4mv8kc443Tfh+kNBlDZDaSqR0Q=; b=bcwO1RvtDMf16WBlgXBZlILmJK
 WQOWh/di7dats079JTOULGoLrOmP8B4VLqe4QfQ7p7y7dTEVmJtSGzsqUIohiHVzGSttOc5IcEFSQ
 LpRoa9rpqfSI/1K8Vu2eOhfv1NOuwwetA9A0N35LbV/oOC5sVzc2zC6TzM+NGRJls0T4=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQ9WX-000000007db-1vbf for openvpn-devel@lists.sourceforge.net;
 Sun, 08 Nov 2026 20:29:58 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso2376965e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 08 Nov 2026 12:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794169791; x=1794774591; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0HO77s8B/gXjoRFi+4mv8kc443Tfh+kNBlDZDaSqR0Q=;
 b=ZjWM7vbv9Dy+au6CGp6QhVqcrdqebDXXzhHkorNs5N5+5EqC8kmGJBXwzJZWBq8s3B
 rWEOpYYOKgFvYYGbKooKKrJywmFt/0dYGwgM81PJiqCqjiBqRdXrDid51Kb1kmgZ6+2f
 MLyMHgPgBl6Q28GQu41VSYExCt8S+blOF+ZY8CszXRuOSLQgJl9klJFuNvulN1eNPCOJ
 rkxuuQsTxbL4O7Y0DsdzQEQfYhewXudzMYaFGzFzL6OjEr1pEBs2h0OXyC5i6p38yCjR
 EYR+1bDeisoKQ/pxMj1I+saiucTEhA/7XW7E+K66aHekaGBHFaHIIov1wWpuR/NovRjK
 yJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794169791; x=1794774591;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0HO77s8B/gXjoRFi+4mv8kc443Tfh+kNBlDZDaSqR0Q=;
 b=1p49aezdvj/+6sziB7rnyGHUM8iqH6eTBGFVHOXUmO8yGaVvSterWgXiLwFtgpBA7i
 V2LQIKkw6ziTr2nLH6HESNOa0oQrc9oVnA2qT+o+mrNLBoOxD7hJRqQYC6mFY+XZAXuL
 GZBYP5Oh7dwabqFhh0mS/iUYfMi7E836meLc4TOgY9RsJRrS86hunx6fHhjzYrjpR/4A
 alPOeL3hprMi1DNMfwIm0HNnuR6rKPyP4tXMv7I8WBIPdCz3T+K8Ggazw3nurVS1qGQc
 8IBuQqCeoT4ifmM2jRPKl4CVCOwt/Zo3YK8Vi781Ftl991sHvdSnSn+rm81Y7AUzoick
 emiA==
X-Forwarded-Encrypted: i=1;
 AL+hErE4UvQCSuIZw8wHLWCMZhJZU7LwEnJciofeVU6Uvl+GK2LI5J18Wifq3Q0WWfZGX/+p/+upon6kK+tCIjhF@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+l/snqFwo6c6VVCSLRtNQOm8HvwqbBfy/I5qcfeLiebRt5px30
 ga1n+PWBvz1e7NJlYMGCwAgSB3ancwCkaPazV4FOC8akv0Hks1NVTVTD5OQT4JJA8qCrcYUZ2+9
 lomrYDaMe+eK2RSqW9FrAthG+SN8wmPY3ooAUoLBpsAl63YAtySGVXS9YAh8CIvvXp8kUTbdY8W
 Xi0GBcwg==
X-Gm-Gg: AYBFou0/ZobhZyFNkwKyrIxn4HvBT0upd4upnC2eF4pF3wqLnVzNzeu82t0eJFee5rY
 DIupbEr0zpH2Tpp/DWIao+0V30BmfK3AaOHpVi9NYCvK/nEHXG7vgKRaTp9PwAPR+x7qjPF4C47
 2NNSpT5UB4tle3CyhqUOhfUD1F3lsgf+dT0TQNlHPbe4Mlxd82medTL4YoU9s7n7yK7NfcYk9CW
 kYsTXHctTZK8gkog0zhkIWHATK7pGn+WmSW4e2p0XlSEWFBHqzs6Jx401Uqs8GcskqrY2yyrGFQ
 Lm2tAkTaFVt3m2KM3AUxNzmMplcs7bC2ovWlbVT0EuDRo96WUJZS70DfxE3I5biLMksWOdIG4kY
 BvB8zXfrq5sHkLDdIXRUfS9RAihGHXHNsOSadJzcclc/JAiUC7ze0U6DPhymYjIfWEw4cLFcHCb
 1piAOXRvBzRRq8DxmgDC1Afqi5CKbTZqfbAna4ydJIqBB00Ck1jcDozGiQbKWSPZh1E1VEr/M/A
 G1ZiZtDwnur9ed1UjHHqS1nP/tPL9HDhBIhXRv5GeTvXxcYKdKWvxG2oEKep/yFiBWSVVqLFDsz
 UbsSJtWSHklbnxB60/MVESTEwxFlkmqKeohjqN3yG5FxlvjkwbQmu6/hdwWb5CcoJGqF5pNbzqb
 PeTiSh95jwJ1wUDfFsVdZcsmRaAGEUq4xdEYfaAWnjF9fh12aBcGLEOtZOY1T5WKqBk0qYEDpFi
 jtdfffYVYyo3Neq8Y=
X-Received: by 2002:a05:600c:6092:b0:4a1:f625:2108 with SMTP id
 5b1f17b1804b1-4b963c8722emr40258005e9.33.1794169790722; 
 Sun, 08 Nov 2026 12:29:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7efb1f3acsm190691125e9.14.2026.11.08.12.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 12:29:50 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 8 Nov 2026 20:29:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Idb22f731a00158ff020a819081a07e1235d8323d
X-Gerrit-Change-Number: 2156
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2156?usp=email>
X-Gerrit-Commit: fdef240d2d2daac61ffb09e68e85847df01cfbcb
X-Gerrit-Comment-Date: Sun, 8 Nov 2026 20:29:49 +0000
In-Reply-To: <gerrit.1794139716000.Idb22f731a00158ff020a819081a07e1235d8323d@gerrit.openvpn.net>
References: <gerrit.1794139716000.Idb22f731a00158ff020a819081a07e1235d8323d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MTM5NzE2MDAwLklkYjIyZjczMWEwMDE1OGZmMDIwYTgxOTA4MWEwN2UxMjM1ZDgzMjNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7ed8d4ebae3ad580a62113ab6d623af752a291e9-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQ9WX-000000007db-1vbf
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_linux: clear
 the context, not the pointer, in ovpn_dco_uninit_net...
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5356458638900085273=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5356458638900085273==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6mUrm0kUplo="; charset=UTF-8

--6mUrm0kUplo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Alexandre Laroche=2E

Antonio Quartul=
li has posted comments on this change by Alexandre Laroche=2E ( https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2156?usp=3Demail )

Change subject: dco_lin=
ux: clear the context, not the pointer, in ovpn_dco_uninit_netlink()
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-=
Review+2

(1 comment)

Patchset:

PS1: 
Next time I'd suggest pruning the b=
lah blah coming from Opus, but the patch looks good=2E
Thanks!



-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2156?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb22f731a00158ff020a819081a0=
7e1235d8323d
Gerrit-Change-Number: 2156
Gerrit-PatchSet: 1
Gerrit-Owner: Al=
exandre Laroche
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Alex=
andre Laroche
Gerrit-Comment-Date: Sun, 08 Nov 2026 20:29:49 +0000
Gerrit-H=
asComments: Yes
Gerrit-Has-Labels: Yes

--6mUrm0kUplo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Alexandre Laroche=2E </p>
<p>Antonio Quartulli has po=
sted comments on this change by Alexandre Laroche=2E</p><p>Patch set 1:<spa=
n style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddin=
g: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2156?usp=3Demail">View Change</a>=
</p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2156=
?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Next time I&#39;d s=
uggest pruning the blah blah coming from Opus, but the patch looks good=2E<=
br>Thanks!</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2156?usp=3Demail">change 2156</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2156?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb22f731a00158ff=
020a819081a07e1235d8323d </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 2156 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Alexandre Laroche </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Alexandre Laroche </di=
v>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 08 Nov 2026 20:29=
:49 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--6mUrm0kUplo=--


--===============5356458638900085273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5356458638900085273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5356458638900085273==--

