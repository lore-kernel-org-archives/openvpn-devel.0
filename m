Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C76C606A320
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NwbH/Cyh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Gw6IYCXZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SMBndgjC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=StFd4lXM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PgKRiFNHAJspEl/7dieufIfLbdn5/LjbUPbevsF7ZaE=; b=NwbH/CyhgcM0uK83HJVl9v7eDH
	pl85I2+MFO/GgHv8sr5ml1EPXhGvplWDC04mOIp56Jg8JcsmpXGCIvxrQBVlIh9upZ/yWPOcZWYhA
	UIBnlbyMXC+z58Gvp6XkuBhYRSI7Qdm5M2Z3Z5C4yqQH4VlcqQzwTqSfEw3uZ1elCLUQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV6c7-000000005Es-0vEW;
	Sun, 22 Nov 2026 12:24:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xV6c6-000000005Em-1xnI
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 12:24:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GDtndMZf+9mGnzPtXmLN4L0GJG7JP65JOcH0seHaVUk=; b=Gw6IYCXZe/yA6DGRSNwVzm0sQ0
 M5VOKTH3kq9cUsXwFYZ/o8lQfDORTNU1zg+2HBBUCqb1vocbYF1dsPyhLNXfe8g/z+Zbbs/nurkpi
 99OJ/w3LR+tPb9uVBeWElKJiSxIywjDcjgJC14Rtljl0a+mlR+LJMYOg9zd2qRUdfCWU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GDtndMZf+9mGnzPtXmLN4L0GJG7JP65JOcH0seHaVUk=; b=SMBndgjClYxlWEQWgHbM9fdvrt
 XHTm0mYK8Rp5nPn9IyHlPNNgEL96xruBn0hH5idu7yanMlONKeoYsnYs/+K7gOlSRrkl6nu4a0OTK
 KbuOqXH6EvM96T9aDrW3gqnNFQuXOcD1nqVOEu0w+f1TqiZMqJ4Fxg9WtF6bCT5hCJc0=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xV6c4-000000006Kt-2dR8 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 12:24:10 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso20311755e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 22 Nov 2026 04:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795350242; x=1795955042; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GDtndMZf+9mGnzPtXmLN4L0GJG7JP65JOcH0seHaVUk=;
 b=StFd4lXMg6R1AlOkelItEM9CZNgQgW2C3fSZ8JCxVQT+WhsuNfzrS/NIKP7Nf0xHuL
 pdmHs6PkY4CKc/56UG+z1XImw3uRL7AyeTcMMU4kOV3pTz8txlqpbmVDB6/pQ/AJ9hPF
 VhrorjV7cviWwbuQ5/p5pUW0cuTqmAtBn+5ckSwgmq/PYNnm0Of6pvwNieStgxfVP82R
 Ay21Z4f1eLumyOfZZ5oLmRU/dAEKwojM4okG5pTtI+jAdNu89LlNj7/uJczENHIRDUbA
 C4Lp+O+MiVgKJdQJnS/ilWJmWC7yPEeGGc1sYWPjpozXftYHhQyEqS2Jzr+4SCGD6Zs4
 D6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795350242; x=1795955042;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GDtndMZf+9mGnzPtXmLN4L0GJG7JP65JOcH0seHaVUk=;
 b=RWOdL9q3cjlH6tL0QNPxo2ObyxHaGUBvqU7JvfrWypSdU11d9Rz2f5e4XNNa7c+gaK
 4rOksDv+vXPm0pF2Q6uRaARFJ+4ERsM7N4iBb/5jeK8g+qQlKntxeaWxo7odjmw7hyQt
 JMUpq+iWwSfZPVTC69hLOJI3PK+8hHjWzYC6nx4Zwjjum4nJEA7qBn6rgf7xTzy18Cks
 xQ+8AKMrTzZOjb6N/VE1ZOiA324v8Bqg6/ZuM7WPRO371/jPyGxICQvh1qf5ZveU2Uyq
 /6Nq4o+KuqBKuYvCMJ21r1jf19Crbs0yDK2y9AVKBa1N7OO8eiAcH+LMQyg+SjPCUCrt
 ifdA==
X-Forwarded-Encrypted: i=1;
 AL+hErEwtIvZUQWW2bPRMLoJ5liuJqYMrlA5C5wGumxg6lPdX7GVxkAuBPQJJShwU+FyYD4eeivz2sHl3jkM1vyd@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+xBRJwhH6OKDczmtXvJaWwtXlJWJs1oyxrTN7MOHCEt9SD9+Hu
 t5PTHRnq1Jh0QGGdO7Do2eKFkgnvMyCejSpnm8k6OUGP5gwsUsbb8EkxS1YZMQyMGNXyZZAEgA2
 zbA41cQXxx9fFIYhmZXggefdLgGBtrpQkh4WQ+mvlVjN/XtBtcWxmLTX2LZqMiPzQ6Kw/UsEkkT
 WB2m1W6w==
X-Gm-Gg: AZFdTZdoxDYGd0+3IfHZizW0Ok0TlWqj5ujkMPgnF6Wk0yH3uUwtfuVS0oLR9SYFFOI
 SBFAI30MFB0SWsTHAk3hE31B0k3HBCSaO4Oc6eKt6yG3QSGbT0rXXUaG1hjXEfjVLXJQi4K5njI
 oOp6/8h8CA5i+U6aRxkr9xZMubpmm25WN0Eu8u9JB+WXqJUD2zL7svZABMG11BHpvKEgZ0mP54m
 5hRfuaG0NmNGL/PrKFcSfmhtcMW7GwatOr9hsQ/80pE/rHwRGc4bcURnu62wjf4YCHyAjDiYuE1
 ynOEZS0Pq85fjaCYniinFESZssaDohaJG5jZUm8l0E8OAB35fn0Mb1TeSOJSQHTpk4OmK0ytHj5
 YaCL/hvBhhFHNegau8xHjWNyx0MbaV30+jQzZxPaQqOxg7sq37mJ6p3EojptKeSNH3UBMoH8FeU
 dySTs7IUlO1r2/lqaKLBczY+2soL2lWARtetKX2va3Mrj2c9cbaS/IF0GST5ZhEolCUF/03YGIJ
 uLqe5RwMzKxOQyyolMZ3fT9ZeXSlvhBJRbS1DiXiRdTyF9cYKw8T/khETMnm6055kPSuJ5N33vj
 dspYo2AGWzSbZ2VUYoWtLgBlDcudWunVDrEuudcYvFo7g89x6dFvWs2gOdyyxgwMrYASQBOnKgr
 WWLaZ1eLWfQ3NnvlM2FvvEAfCWviT/F1y36lh/gO6AkTtGpVm+oy6mJurWsKJmZioPqkChwZoKu
 Y/bjM50T7CS4LPhZFZ
X-Received: by 2002:a05:600c:820d:b0:4bb:5de1:e923 with SMTP id
 5b1f17b1804b1-4bb887c33f7mr178284775e9.4.1795350241887; 
 Sun, 22 Nov 2026 04:24:01 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b7515sm354445255e9.13.2026.11.22.04.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 04:24:01 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 12:23:59 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I00b340f30dc3518994b74c49565736524b7df318
X-Gerrit-Change-Number: 2195
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2195?usp=email>
X-Gerrit-Commit: 85cad2c4888fcfa210020d397ec90e3e1d68337d
X-Gerrit-Comment-Date: Sun, 22 Nov 2026 12:23:59 +0000
In-Reply-To: <gerrit.1794834286000.I00b340f30dc3518994b74c49565736524b7df318@gerrit.openvpn.net>
References: <gerrit.1794834286000.I00b340f30dc3518994b74c49565736524b7df318@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM0Mjg2MDAwLkkwMGIzNDBmMzBkYzM1MTg5OTRiNzRjNDk1NjU3MzY1MjRiN2RmMzE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e9c493169b6675975d32049193aa9a77931c6ba8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xV6c4-000000006Kt-2dR8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: gerrit-send-mail:
 Support user authentication
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3786573438144651796=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3786573438144651796==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G/oMc1xFi80="; charset=UTF-8

--G/oMc1xFi80=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

G=
ert Doering has posted comments on this change by Frank Lichtenheld=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail )

Change subject=
: gerrit-send-mail: Support user authentication
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(1 comment)=


File dev-tools/gerrit-send-mail=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2195/comment/006e2f1b_70de1282?usp=3Demail :
PS1, Line 150:       =
  auth =3D requests=2Eauth=2EHTTPBasicAuth(gerrit_user, gerrit_pass)
this v=
ery much looks like "user + password", which I might not even know (auth co=
mes via github, github auth is done via passkey=2E=2E=2E) - you mentioned t=
hat gerrit can create auth tokens=2E  How would that work?  Would they be u=
sed as GERRIT_PASS then, or is some other method needed?



-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I00b340f30dc3518994b74c49565736524b=
7df318
Gerrit-Change-Number: 2195
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sun, 22 Nov 20=
26 12:23:59 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--G/oMc1xFi80=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Gert Doeri=
ng has posted comments on this change by Frank Lichtenheld=2E</p><p>Patch s=
et 1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2p=
x; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File dev-tools/gerrit-send-mail=2Epy=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2195/comment/006e2f1b_70de1282?usp=3Demail"=
>Patch Set #1, Line 150:</a> <code style=3D"font-family:monospace,monospace=
">        auth =3D requests=2Eauth=2EHTTPBasicAuth(gerrit_user, gerrit_pass=
)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">this very much looks like &quot;user + password&quot;, which I=
 might not even know (auth comes via github, github auth is done via passke=
y=2E=2E=2E) - you mentioned that gerrit can create auth tokens=2E  How woul=
d that work?  Would they be used as GERRIT_PASS then, or is some other meth=
od needed?</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail">change 2195</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00b340f30dc35189=
94b74c49565736524b7df318 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 2195 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 22 Nov=
 2026 12:23:59 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</=
body></html>
--G/oMc1xFi80=--


--===============3786573438144651796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3786573438144651796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3786573438144651796==--

