Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3888606A31E
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KK5J2Y3m;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LKuC+eO+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Hu0nmbZk;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dxHNmrzO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2Wm1f9YmuK/rNudcUW40Jd7AUaYZCmCk4DMHpFmE/wg=; b=KK5J2Y3m2xFhGLE/ixpi8nVxRQ
	VGMHMoGVnXTbSYq0qk2kCJz2zVQNhrv92eeHbFWQyaYhbtpSBfNZhar6is4sbXhjfVVAOvTMLLRyD
	vJfetNQbnOPHcx7RVwH0tereu5xAeKubHx9rOHMJQxLBi0f/6KCfStXPpFpezLc1rmpc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWukW-000000004Qw-1kjl;
	Fri, 27 Nov 2026 12:08:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWukV-000000004Qn-2vE8
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 12:08:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nFcOhUHJaONxqa2Svr8thXFoCwXuJLxL34ECz28346k=; b=LKuC+eO+QBOO1f9oGCFMJvUhvJ
 LjHzzd4RZCsb6qgO/81JviaG2UuSCFlaCCA/hiKHt8szkk0WYk4C8XHQAbtGH58p+JjsIYzOQxE4I
 K8JKcqpy9m3/ylp8kzb7ZpZWoJSssv4CElH20k0oGphiCVWcidMBuDUFkdhfZADdV7Zs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nFcOhUHJaONxqa2Svr8thXFoCwXuJLxL34ECz28346k=; b=Hu0nmbZkfZb+ENNwmWp8gO6CNh
 GcL4582b0fXlT6VAHX15/l/sZ3JdXaY+yAM39Cbcw40/LS7bDecObZNgcJP+nRV0UZzyyPln2iZWK
 ZB3bF4tnYPDdn2RAWhFinn4nEnyQ+o93+fYjqJKyv9e+x5K0FPFBpj2Jg7FgDwkccha0=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWukR-0000000082A-2oHu for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 12:08:19 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so75537385e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 04:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795781289; x=1796386089; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nFcOhUHJaONxqa2Svr8thXFoCwXuJLxL34ECz28346k=;
 b=dxHNmrzOdK2dEy5CSYqX66Z7ORsA6pmgbZRdyxA2urRyBemMGHVDRbLBBpJS5VoWaT
 U/sxD5LxaDfXMXxrklL+YJk1MPQ+tPzAciyW7DFa0hMd+1xA6QTVzr/mXgVMmWqCpi0g
 70Bg3k2r4+b9o3tuwYoKGLz9rvlxpihuFQpAg430jn0sUKpGZBfGA9849hce8fDci9xo
 t1X1MBsYht8Z1rgL55wdZ1HIkTsRklHkoTNSiceIi3D0D/hvORGI5Da2hES4+dbYrksK
 XzxwxDjVkKs6eB2jIyiYxDp90ozCT2uBXXmEq3dD7p3VbGmM3xWlBfpXFIDUV5hU5hCE
 fOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795781289; x=1796386089;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nFcOhUHJaONxqa2Svr8thXFoCwXuJLxL34ECz28346k=;
 b=R+a5ZqIjaTQJUFKOW4ZTPC+F5TsIbbCzFu3gk60UY93R1YzC0E1sdOIicOIE1/gFp6
 ZDrWqHXNhhMDCQBxjqhVly3Y2Z2qyu0+pZYLoW2qqZInqSmqzl7JvF6eADpGhIkL7+Q6
 96BanBsZGixuxOdTqn5R4nmpkH/bMELas5qTi6mL57yss2SnySZl8Moi7jPbKaNhvh4r
 qOzd7PMBVOeP8fqosHCdRJTyxCgl1IEykL3l9IxANHnZbdJ3up1nBFxOdgmr6h870oG/
 GZvYcD4pJql8AKgqYpm9Q13nOiBG3VPnMhG102zYK+gOMVhyUZG7cdZctQ1h6KG0uJqi
 /0sQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEnRlOiqWJWQ7jlPC4FzyPhh2IKnAmduJo6xVcQOWJWTQCMDT9avRbkezGttVKrqlW6pOhDZxgQ+tGJShe2@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9VABG1gmmYr22/y/3NST5ldXh72NLZ4rdeuaDI944c9RG9QLr6
 fB8UxhJdBpcuHyfWy5c97yhSJRE0bTRuJnXX+diJ8vE/bdW+7JEmBrBExBpu5TOPaf5bDYvXiOF
 P7PEacjTD1awAcK/dzgO/WNws5tesj0/PHcM1dFH90TRXbpVV3jJiAt8XDs7yUVv2iemJ
X-Gm-Gg: AZFdTZd/IqKOhNLDb/+2zC+Krr4MlFH8W/71aavjrwf4J/GGERkmAiuicX1p2On0A7u
 zd82QbfPSyd9wFO/Z+RyjZmYp7OSmh/a+eKd3BFxmtOzZ24ldgbahoNZi+V3GFLGSdEW7IoRSJS
 3Zk+cUQbwJfKEz7viRVUs1aKEt+GzcuDtY1myS6wh5fccobbELgXzyhVs7EOS4QwNAC/1Akm1CF
 kM897GX7wB4NWnodKrq754mfdV0kFY3bXU8yFlwKiFm10wC48dfvAAWKPT6DkuJzuKWfLxsKFVv
 CRlnXrFAh0H6kuVmBjzDNJullEoxM/gKfqTUlICFUnHfJFrZbSe8ZB8BSPO6jlysjbOR8AH9KbO
 nWzrQ68NIkWEJMhX1HZ0EJFETJ6E3VsmRGWuKbXaL/O4ebVEPuNkTL/Edn3z2lxZ+SpUD3FsR1F
 8y2OI1DvWC3TSLucqemm0DNa54PEX71aJA0aDopFAIGe9ZiX4s3+DJyExZkM2bNftpyvKMi1PmN
 qEbhVfKYSaSXGqfvFKvOAUSg1A+gVhrEFQ7sDhhI95fkXQlKRwdrlkj1KlcHiEuSvSuhJQLiOl5
 l97ziFJq00s8Fns/ez86nWOK6wE2OPx4KyHi34rWWt4ev1iXvfDoADgiBriH0B3LVBfshQGjZIZ
 ap+iSd26f6NilgcRV6coc552CG1VHQeth25AOgsG7sGhzuT4nF+KOvRvtUMIzJio5OeC6ielGUI
 a3Y2sBw7WIbvA4RJg=
X-Received: by 2002:a05:600c:4f15:b0:4bb:6861:657d with SMTP id
 5b1f17b1804b1-4bb88923954mr572960805e9.21.1795781287808; 
 Fri, 27 Nov 2026 04:08:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8526cbd0sm911468295e9.0.2026.11.27.04.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 04:08:07 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 12:08:06 +0000
To: Marco Baffo <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib20f4965f25472f47b98981d54eaf4e2269d7408
X-Gerrit-Change-Number: 2360
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2360?usp=email>
X-Gerrit-Commit: ecf8d7a55b8642e75d9c8ec381df503fde1ecde9
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 12:08:06 +0000
In-Reply-To: <gerrit.1795779011000.Ib20f4965f25472f47b98981d54eaf4e2269d7408@gerrit.openvpn.net>
References: <gerrit.1795779011000.Ib20f4965f25472f47b98981d54eaf4e2269d7408@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Nzc5MDExMDAwLkliMjBmNDk2NWYyNTQ3MmY0N2I5ODk4MWQ1NGVhZjRlMjI2OWQ3NDA4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <22a226f78b600d64441e654870f6a2f2f803050c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWukR-0000000082A-2oHu
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: preserve
 --dns-updown across PUSH_UPDATE
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1342607426056346110=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1342607426056346110==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qhn5xska1ks="; charset=UTF-8

--qhn5xska1ks=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo=2E

R=C4=83=
zvan Cojocaru has posted comments on this change by Marco Baffo=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail )

Change subject: op=
tions: preserve --dns-updown across PUSH_UPDATE
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+1

(1 comment)=


File src/openvpn/options=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2360/comment/1bfd847a_26586e02?usp=3Demail :
PS1, Line 3629:     dns->serv=
ers =3D NULL;
Looks good, but would it be good to "save and restore" here, =
so that people who add new fields to `struct dns_options` in the future don=
't forget to clear them manually here?

Maybe something like this?


```
st=
ruct dns_options *dns =3D &options->dns_options;
const char *updown =3D dns=
->updown;
enum dns_updown_flags updown_flags =3D dns->updown_flags;

gc_fre=
e(&dns->gc);
CLEAR(*dns);
/* --dns-updown is local configuration, not pushe=
d */
dns->updown =3D updown;
dns->updown_flags =3D updown_flags;
```



-- =

To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib20f4965f25472f47b9898=
1d54eaf4e2269d7408
Gerrit-Change-Number: 2360
Gerrit-PatchSet: 1
Gerrit-Own=
er: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Attention: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 27 Nov =
2026 12:08:06 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--qhn5xska1ks=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo=2E </p>
<p>R=C4=83zvan Cojo=
caru has posted comments on this change by Marco Baffo=2E</p><p>Patch set 1=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #d4ffd4;">Code-Review +1</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2360/comment/1bfd847a_26586e02?usp=3Demail">Patch Set #=
1, Line 3629:</a> <code style=3D"font-family:monospace,monospace">    dns-&=
gt;servers =3D NULL;</code></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Looks good, but would it be good to &quot;s=
ave and restore&quot; here, so that people who add new fields to `struct dn=
s_options` in the future don&#39;t forget to clear them manually here?</p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Maybe something like this?</p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;"><br>```<br>struct dns_options *dns =3D &amp;=
options-&gt;dns_options;<br>const char *updown =3D dns-&gt;updown;<br>enum =
dns_updown_flags updown_flags =3D dns-&gt;updown_flags;</p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">gc_free(&amp;dn=
s-&gt;gc);<br>CLEAR(*dns);<br>/* --dns-updown is local configuration, not p=
ushed */<br>dns-&gt;updown =3D updown;<br>dns-&gt;updown_flags =3D updown_f=
lags;<br>```</p></li></ul></li></ul><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail">change 2360</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib20f4965f25472f=
47b98981d54eaf4e2269d7408 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2360 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>=

<div style=3D"display:none"> Gerrit-Owner: Marco Baffo &lt;marco@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 27 Nov 2026 12:=
08:06 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></ht=
ml>
--qhn5xska1ks=--


--===============1342607426056346110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1342607426056346110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1342607426056346110==--

