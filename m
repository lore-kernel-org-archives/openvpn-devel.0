Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CEC6C88E50
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 06:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qQMnPZ3lqCGwWOZypfiMFdjKqKvvlS0EwYB4mR/8DHk=; b=GSud7CqwuiixuXmjnnbKEbo+j4
	6VEzp1LFc2MjtySO1RxfyxD0/yPZ8ibpRLYg+dFljHgnY5OcmRPg6t00LrBccwj3Yqyx8PKiw/IE8
	wpJ1uposMeD3O8hxx3R/j2E5k1tAE6j9Bl91NJG7n8s2LGoTfckdRzXkjUjIaFRUxS7k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x600Z-0007OY-0g;
	Mon, 14 Sep 2026 06:17:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x600X-0007OR-HH
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 06:17:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UvtizvCNFM5aBxYPhK9JX+bRz5pn/K8ZU3jmZMZ3c74=; b=QLw3wIK/L4T283jKfhStTLK0ln
 IeJfzQ7QvDFgtIFumcuDNnjDvtq+q4iupUJwD69NcxzLG500IYvkRdrI5vz3gfSRWhzkibS4LfFDK
 lZLojuHLXzA/GxYJ1AUsXuwhWy2wUjrYGYpL9eQedLMqQLrwdxXyamF86smZGGNNaLKs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UvtizvCNFM5aBxYPhK9JX+bRz5pn/K8ZU3jmZMZ3c74=; b=K
 vPjtTMle2aRQ+fxaWHsaf72jW0QiWzVC0ug1cD9+HWLmeJf3iR+vMeZQhuKDKJwKuqtMjscRBcOKh
 45LJK2EoPswGiIPs70WjElXZ5/LrukMpro0g8VGYram5OxOXmHV/Pa+EE3Qg3sZCv1IEU98mxyHbv
 r+Uz4TV2x2c1/0eo=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x600X-0001HR-0x for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 06:17:37 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-482dd6ee390so2290537f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 13 Sep 2026 23:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789366650; x=1789971450; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UvtizvCNFM5aBxYPhK9JX+bRz5pn/K8ZU3jmZMZ3c74=;
 b=SP+XOGrkWnZ4gNrraiKwzp3ag00K9TxXeBDz9+E9lPVaVH4tNd14AGV1XVeufx+mSO
 vt2lLVyqTIKSjU95Mi6NCXQ28JUKiK5DhBNQfAWBzfKSuV7gqrGZ2KKSiBkhLO0Cnqj6
 RILhgRuiIyA1/yalM46BJy6PBGRoKzARBuo8Q+QF3rwgDi6s8/JYsrOmkdV2t0n2Lv+Y
 Xw2ec/5PVLpCuMAi703RV1H262Mc5nw+sSghSq6m3YXNMdljbLhvH9W+3sX1JGZiazwd
 o/I8Ne+LijEXWjUDXjeYn/3emLp7Q66NdffdMXAxg39xCqHbNLjip5q2c+A8i8mJeaAr
 YB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789366650; x=1789971450;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UvtizvCNFM5aBxYPhK9JX+bRz5pn/K8ZU3jmZMZ3c74=;
 b=JqzONMYyqlPOoqnUGANBM3EgKrRY2DBjhhzHXqg1L+pWL8iM8iOE8eVe+akh6W2TNW
 A04ovToL/uMJxNB3UNiuZNiZk2CMvMLLwCKbEr1XXCa1xsbFsDAzUJGLkq3U54pQ/Rxh
 uJqFuCHsUbHqA0PXncyWR9S+SPJIw3ngdSO8qo9crY0L669zKPZ1swnSoWWgRfTLufLv
 Fu6aj14nV6mTJwD0ubadwyow3uzje3GUny+wsq5BW+SjRt0bRvUK8nplSmPJEyZ1QJe2
 Z8BKH3mHIj7fA5L/vF3nO+9AgpFySuqcasC1ZpO34AaTrdfcvwnk+xiZPAHaXSmqVLrB
 ULGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBycY5xahVQOUnzsYSdsq6I652PfXnQwEZ+0shFAt91Uz1Cea8qTagTm5rt7WOLRzPL0IxYSWqsv/6d1rgXy@lists.sourceforge.net
X-Gm-Message-State: AFuF++k8yowUu3M80gANXfbIof1ORQVwiEUsIdlkFtd3fb7uZQEt1AQQ
 r+r2FUV59o840QzcvReM905bDiwdZCInOtIb08BXsMcNuNSqVyokBiDZHa+W5UJr3YuRRsNKXL7
 yPh3kjCsHvlqdKiG0No+yJTnvQGVDyN/qxVTqdAj5KC/TW5nOCFHmGFlMlXNx70QJ5IQc
X-Gm-Gg: AYBFou0jbBQjNcbZ/itCYHMCxHzpX4NEwgkweumr4l/qMvGWdCPQ9WYFG5Mfgu5AT8Z
 XFXF7hZbxIInj0EG/4xrzcfFbCXFIl7kzRKDNlcSQcjGtrrzTM1QnkGX45Fno+qe93XJFQRQqXE
 9+ZsaKUtfqn4XpmMqOfP5CHoXeLbeGFUqfiJyUEOYNPGo4/upNynNYDyWzwPjwl3D03HzpIjzng
 0fGSH5cMDsDtVyeM3MGh2O4QIyEzt8CaK283BXwvvyy3MveKekH4l5oR4u0SZv07vsrgxMrSUyf
 8t1cmDiiODQ2C1XYMJoEjtrBzuskdUOptKv/pZujK2m4TxY20scZjt4lhoBI4mxy5MftG4AYB2K
 MTT/sYqXOjWI5b7geHmwkCZjCsscW5lyyfP8jMQKY4vSb6oeP80Z5V8jZ3xcmTxJNc6zsgYsjvn
 GppssFZay70ayTakpSjAEVRPJMk9na9sHmpuJOohgBpMzp1rq2XeQ/wbtJ2MGGXQrbnVry8JQXF
 rrLqmFTqUYulmc8u0KureeyCcKB4bZA2yFqy3tUxi+7RXp5oAMdNyk6C4YA/er76FNMfsmlfghn
 eSuJs7Vzl5+nSTz4z7UejD55rWyrMmhcBYdDrfJVQ0aOBlRN2S5qKE1yLL+PEA==
X-Received: by 2002:a05:6000:46d0:b0:487:36a:7820 with SMTP id
 ffacd0b85a97d-487036a7847mr207955f8f.10.1789366650339; 
 Sun, 13 Sep 2026 23:17:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34f353sm23495439f8f.26.2026.09.13.23.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 23:17:29 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 06:17:26 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 24
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: 9a2e2752ccaa828668b00074c644c385fbc798fb
X-Gerrit-Comment-Date: Mon, 14 Sep 2026 06:17:26 +0000
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d41aefc258a1d0f932daf3afe7d39d7ee9e8e333-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x600X-0001HR-0x
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5294360549360743083=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5294360549360743083==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MwJelZRfNCY="; charset=UTF-8

--MwJelZRfNCY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1663?usp=3Demail )

Change subject: Remove instances =
of constParameterPointer cppcheck warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 24: Code-Review+2


-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2=
b116f58
Gerrit-Change-Number: 1663
Gerrit-PatchSet: 24
Gerrit-Owner: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 14 Sep 2026 06:17:26 +0000
Ger=
rit-HasComments: No
Gerrit-Has-Labels: Yes

--MwJelZRfNCY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 24:<span=
 style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding=
: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">View Change</a></=
p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">change 166=
3</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I562=
48cf6d199c2da770774b8fd1e5daf2b116f58 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1663 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 24 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 14 Sep 2026 06:=
17:26 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--MwJelZRfNCY=--


--===============5294360549360743083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5294360549360743083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5294360549360743083==--

