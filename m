Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0F9C44532
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 16:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lk53UAQkOObpZIocZTWo7aM8edP0p3Mh5VxAaP3Z7rk=; b=RpJPyetx6/A3kRwu2d0e9ZQlxl
	7QwT3fAoFZs5Hf77brF/6JjBIwnbn3xzp1ygh+XZg3Pj66PLq6hll3OL+CjStuJC7HkH5itxrtvbm
	YuslTU1kqB+z+mSDCJu9uew3P2T+nU0nIJCHdftEspM1iJjt4C79fPi7tKqG0CKolmCI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmZxY-0006rj-Lm;
	Wed, 22 Jul 2026 16:38:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmZxH-0006qL-Dm
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 16:38:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=blMEqdbDAt3KOalZn/hebh1fGp6E67NTTMt8tqEpee4=; b=HaZ4w8TPl/dgfxbiyNbg40TZO5
 3LDytYq+YofZ4Xe2EVkoe4NxPgOgxARcVRh9JbC1+7jXGCv6pWzRmzrGVBmYFa3yj1AqBFir1w3TU
 3cgrSdeF/EyjG1hn/PQusSBLk2xR/5Oxybbj8Ubh5+55X+Qy8zIDN/mQy8SEqrFONpgk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=blMEqdbDAt3KOalZn/hebh1fGp6E67NTTMt8tqEpee4=; b=R
 GwzwNoxVLH9S3HQdmhMAuWc2lyYgXDAV94GEAyzkfayjGJXeGtQgUbstYOC9Ys7etoC0NCoRiHvBe
 2AjwrpHkHljaioBWHB4kAMihe36Qbo59pa3Jvdny3r8ghUl10kXmJQ0vUWWrpJOE0F1Ue1/z7OY0A
 RUHFNGZNV6LtyZGs=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmZxG-0002hK-Qw for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 16:38:00 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-475417f010dso7338622f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 09:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784738267; x=1785343067; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=blMEqdbDAt3KOalZn/hebh1fGp6E67NTTMt8tqEpee4=;
 b=RRPMFHzvMZiYPNkdCVG/GeTLDt12t80HQ2/a7+RFRkpj2ZQRWdPuw4gr2F4JIpEZsI
 Kr4TU3SV8NeNg6UTv95EDcrRIfCO1Fzc+ZxmxHyvCceLdyM4VasmcOG5apy/cLPf8161
 cESg5Bcsw3yhTWvZIPm7jE+HyRrasPKsjqeYJwBHeobijqL1Jrly1q+McsY1tfiCT/FK
 YImB/4HcbM8NZOGJpLhjyzcD1dJZkgRPjTH+tZDiSLCVrtckTk6xp7TF/UxMFxnJmVFU
 onaRMU6+D4iOkIbMzmeK6n/Wi9O/+OVL2qsmmojaZcjC5T/e+gE8BS/hCjKWuCcTN2Fx
 aaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784738267; x=1785343067;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=blMEqdbDAt3KOalZn/hebh1fGp6E67NTTMt8tqEpee4=;
 b=ZXXlQhKAhfh8MFbEf3spgt7NPIeDFLuZQ8HWasjIZCcR+ZmwZ38Snbu0A5kGWRCDl2
 ysvTI44SrB6cUuuLFdZNpCFBNQNzXwINTUBTKa5FvsDbZEEBlS9A4yGBU19BnpnytPBs
 C1WkjDWjjgEuQB5nDpIcx7IRK6WkF+l92qRubCxrV8vCkvNxEhgaFvlaBrdeIqD8OAfA
 5LyMg6gZqPEfehLviGJY995c7dbsM9KrXtWZCIfKZjdkwwdKbbS83/Hwb4VZBxvOgwDT
 6z9Y7csBjwtrZ2z2sBoXZ+bIYwzC/v2wCMzGiWT18gwzrPjNA8K/8D1RU9sIRKkDhwuo
 bQ/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpW/6eqS3M10lPgkes4VEk4UijrKxkrV1N6hmqqagv+ZgsKxAebALLW2vIDkyxyq8uiPQnhcNVLbgvR0Cb@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxQqb8YfvNrnPxkxZsNiJc89HJc4ZkZ1FUevsluy01l3q6eloe1
 R6EYkyhbvQOyvXQWGCVTMhja4Mm4OtFF8AU/smmPh6NrC23F3vRzzZsJfDnD5vG6B/LnU0jNTbw
 YdmN38PMUh1DhdsUSYtdGrKOBytea9krQ/nXGSfR1Bg1gXrKerXcx101cCa0J+b6WkOtC
X-Gm-Gg: AR+sD11V0jhtSgKnYFx0rjUDKjtjq/2GPWPrfMxqzBhg8roXERTpMz8wlqlywifIlzS
 KQhnYUWzIcFN0Yp+vxzHRbciNpHi5JNDtnZQaf1uAFQ4wWN9SjUmJV9Rtx7bDX/6nZDwBp1EfjX
 XH1YbOVYfxJFCGOnPyT9dronLQAvHTPqZE8SCnioViNR6RAMfLXPt6eGYW6MFWWiUCGp25HEXD0
 ooSNijs4A2k7jMPF8Xlr6SoV87t+Hd73rv8gSt/nUmp4ntb4gYTdFyqwKIfRAD6fD2oghuv+2gA
 D0cMbeK3hj3sc09MrTSla6EiO/3kGRaacujpmcxEypiAcA3jb1EHXlWOh3IOAuxtUiWKTXtJuXJ
 lt/xuHBb9VfQan3zHjqu4MYieL5Kqej8DDLTQ/m9XBuFEn7pfPsw480qgri76rf9vc8HgzWWhpI
 kU+eo+IUjrm0JhD0GP8aNjl+PBFR7FsDGxBbD3LT8d0AcYFsEEFOpwOmIV85HlYg2+GKL1rg69J
 UJ5x+i/vS75Aqx+81ktLbomlUFzrHwhBSXGMqiNIe/ou/KtgXdCIgOJYbO7Kl9/YHk0
X-Received: by 2002:a05:600c:35d0:b0:495:3fe8:880f with SMTP id
 5b1f17b1804b1-4954a3ec4b1mr255248305e9.4.1784738267076; 
 Wed, 22 Jul 2026 09:37:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956d475e24sm48930225e9.0.2026.07.22.09.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 09:37:46 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 16:37:45 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0f56ca69efae0ca376eb9eae064a893c8768188e
X-Gerrit-Change-Number: 1799
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1799?usp=email>
X-Gerrit-Commit: 28c867778a91a651e3eed9974a09922536b958d1
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 16:37:45 +0000
In-Reply-To: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
References: <gerrit.1784718444000.I0f56ca69efae0ca376eb9eae064a893c8768188e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzE4NDQ0MDAwLkkwZjU2Y2E2OWVmYWUwY2EzNzZlYjllYWUwNjRhODkzYzg3NjgxODhlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <79d6f93859722054a30c537741c4393b7d2083d3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmZxG-0002hK-Qw
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove --providers
 from --help output for Mbed TLS
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
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6706872963556485188=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6706872963556485188==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zXYBeKXKmgk="; charset=UTF-8

--zXYBeKXKmgk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF=2E

cron2 has posted comments on=
 this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?us=
p=3Demail )

Change subject: Remove --providers from --help output for Mbed=
 TLS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 2: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1799?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I0f56ca69efae0ca376eb9eae064a893c8768188e
Gerrit-Change-Number: 1799
Gerri=
t-PatchSet: 2
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer:=
 cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: MaxF <max@max-fillinger=2Enet>
Gerrit-Comment-Dat=
e: Wed, 22 Jul 2026 16:37:45 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: Yes

--zXYBeKXKmgk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF=2E </p>
<p>Patch set 2:<span style=3D"border-rad=
ius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-col=
or: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1799?usp=3Demail">View Change</a></p><ul style=3D"list-=
style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail">change 1799</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1799?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f56ca69efae0ca376eb9=
eae064a893c8768188e </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1799 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@max-fillin=
ger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed,=
 22 Jul 2026 16:37:45 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </di=
v>

</body></html>
--zXYBeKXKmgk=--


--===============6706872963556485188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6706872963556485188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6706872963556485188==--

