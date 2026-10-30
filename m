Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF7B606A320
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kecCGagU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=B9kpzyrB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BuiIgI6x;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MrRwXChD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HeGNIdcalY9t/DXeVXtGTmLcjXtDbdVVAqLkF9gO4tE=; b=kecCGagUE8JIWeapdimdA40Jrh
	kbkcymTeIesMNVeqDK1m8n0wfSazTf7BvpNOXjJpJ1vb/SDEw4YX/rHNCMsEqwMa6jzqbzlm4kPIB
	eUG0R2xNn+Ls7nMZYjTBTpWZdKKrN5i95JSzemsMObSn5jAfBjK3WHFnnTAAZ6nWzzm4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMcOS-000000002kx-2yeo;
	Fri, 30 Oct 2026 02:31:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMcOR-000000002kq-3lqp
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 02:30:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zZyyPtPf1UPN19oPQMXNZSvrkWJKw+tFuAPLV2BCjWI=; b=B9kpzyrB9h7VyKYML+nb1DD4gG
 9NJjQFCQnSJDJd/Qt1YJarEr94yGrvPjWxHTMLmiqaxJvkERptMMO4Q+hCXvKNMwN48XIDixmqbym
 e1PZQNwCqe1qBvQ0OZymX5cfNaVgeRHZwc9BRQPd0ktM6thjOqm98CZgACvEpxEP11J8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zZyyPtPf1UPN19oPQMXNZSvrkWJKw+tFuAPLV2BCjWI=; b=BuiIgI6x5+xNaKF99jMpnZu/21
 a+iajtez8DaiCsWEOabkzCLV8nn3ZuJGimL95v4Hr3Pk29HNcDKEnZz4XeIvnw0bJwL1SrTiQDhWv
 Qc8U52tJD5MkcdlsIMFgngXtPxu9JjqeblxTxlwcqb1FfbEyhKN+4HFN8fYezDOvW3xY=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMcOO-000000004i9-2nou for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 02:30:59 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso194375f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 19:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793327450; x=1793932250; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zZyyPtPf1UPN19oPQMXNZSvrkWJKw+tFuAPLV2BCjWI=;
 b=MrRwXChDQYmRRFGC5rk0JUy6CqjoJ/k39hI2oPYKutg38NxcgUR3t/+ZCAAcI3XEO9
 k6/ewz5Jt+r1E+Pjg+qr1Xjc6MxbBJ03YwtPVkAJ1hHnWxtuXO8lKP3h9LJ1ajUAbwg7
 KmnaCdbBPCQy2ccrjby5PEaDgH92IUKY0nklGYocpUObAa/vu5V6md5M79YvZdTtQRl+
 GDrPsW1Jq3eZm3B9uD001Fga8tDAj/z/CR288HPsZZhispd95MwkwcC4TabD/jEFrKZ7
 0ulcchYWNbLNylKSlG31802sYv/iOeSoccKCH/ydwYkKyXZ9ggfKCTuW/P9oqd20iwLT
 0wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793327450; x=1793932250;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zZyyPtPf1UPN19oPQMXNZSvrkWJKw+tFuAPLV2BCjWI=;
 b=pJyozBInSjtzGq2BeT8GFGKzdIcFAo5RdA/pEQQySQd0bIGKPRHVLD3MI18yXSn6tb
 cEAOGt517xPuY+B4W6WU0Gsa9cTpfixKs01FapaMkxsIeUpL4hRFfng0gsuy4Y/s/JvL
 gD5lz0WfrtFiEATLss07HcX+97DbfJ+Wq+vb0fwVPMKjF1/v+81c24g3xFDtnJZRHuuh
 AhtEkrwhXIHx2wV/TfJFA6GFiIaMdG7cnEgLxUSSUFYa0urUIw/wGeMx7D7lerAbxvVs
 1cBS3SRBjgp81EAkfZcQfRiyJU/Rb2UyUeG7McBE/WXL0iVhYHRtDDMcF/xNxNpo/lmE
 Fxlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1vbBuOh+p136Pjgo7nOxxYKMgbw/3IT1us9la00ESQZ3dbpuiUi61CDgzWKJgNpfdwetI4A8FHi6kv3Gw@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIXp0su+yCfycaJC7C5a3lF8F4oP5fe5kyBw2DThUVqQCB8QIea
 ziZalazr2lwxdDxveeXzIIP40T4G+hSWUChoHYoM9Zgp65UD282JiRo8uuHBr6wz2eslaFFn1+L
 lYznH96nfLS1mU6mNWQOgn164zGE9hhf/F2IKeIR0SGQfk1UFW2tcLKcmETP47q7pZ6qsRdLHza
 /yfg3a6g==
X-Gm-Gg: AYBFou3X5E0qqy0Ij/udQ+Aylb3umeHJdq4nz0cZ6yWhv5hkaJHntfcqOj7ntlqdn0F
 md/4/1qd63pxeFUHiuIXBGaQRd7+cp0d4j04g2+2TE4xunCiA+v2TU+D2O9LHKkNXRE5xjn3yIe
 SkhsDLSmZTQjM1ogZA4kj1wSYBEL+6E7mBB4NZJIbHECiC6ZE6A9gpmo0OcL84ASGPG2gvn3Ecj
 zPSS1Jr3Dwbl4L5VEuUOSQ/ZhnfkvsM7h2gYVIZJIZ01IBoTWnHukkKJhnIq/Dmqb/WDvC6xx5p
 cF1++y0DEJg+kJMIqXmG18nVGBaSAGqi7qQfZkTuqbfrY8DI2qFDlfqr4XgGD+UJ9uBBM3tSprv
 IcwVEXMrtpPKCUBGjEI537hCfYpYIJ4NG9KTb2SGrH0DEKM1GvX+G9kt/f4i9KsoIlN1kJVmkSZ
 zYG0Ot64eEcia8bHNEhWsU9Nlr5a9UXiWcxUM8DsjSfaKe7cD5Z2Qk8tAa6YD1U1cR2SC32Z0r3
 4b2taBfoN08qzInsy820aRktQdqMFp9VgLWN1W3Nr8TSC8+UhD/Bqw/f7ajgI2Z+MG/Wsb11hbh
 6oE9jf8fUDwKrUXzX1vFOrf3mAJ54/e9SjAK3bPQ4ihVH0FDZFJ1/mSOYWjShmMTFFpTGgkeZom
 nDIkaObC0Swvig2XfA3KqcxYQ/7p4G7I+Wiz2QSa2P9gXfUwy8gcey5Lo/fhVUB+jczJe64Qt/o
 F94TFcc/7O1hXVOq8=
X-Received: by 2002:a05:6000:2893:b0:48e:5d33:da5c with SMTP id
 ffacd0b85a97d-48e6e2db4cdmr2527226f8f.1.1793327450000; 
 Thu, 29 Oct 2026 19:30:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b789ecsm494905f8f.29.2026.10.29.19.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 19:30:49 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 02:30:42 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 23
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 0d8719830b6fb0a55223b6d99b9b458ddfdb63cd
X-Gerrit-Comment-Date: Fri, 30 Oct 2026 02:30:42 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <edd0242600f2201542d619cd4e2bcb896567bcef-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMcOO-000000004i9-2nou
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1428549814181346428=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1428549814181346428==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="N6s6lJHOoos="; charset=UTF-8

--N6s6lJHOoos=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

c=
hugly has posted comments on this change by Arne Schwabe=2E ( https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subject: Implement=
 sending/receiving app custom control protocol messages
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 23: Code-Review+2

P=
S23 builds clean and make check passes here, and my earlier points are addr=
essed apart from one doc line, thanks=2E

management-notes=2Etxt still has =
"to facilitate the pending authentication" in the app custom control sectio=
n=2E

In management_send_acc_message() the unknown-flag message says "proto=
col '%s' not in the list of supported flags"; that's a flag, not a protocol=
=2E Same branch as Razvan's A comment=2E


-- 
To view, visit https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Cha=
nge-Number: 1858
Gerrit-PatchSet: 23
Gerrit-Owner: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Re=
viewer: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Comment-Date: Fri, 30 Oct 2026 02:30:42 +0000
Gerrit-HasC=
omments: No
Gerrit-Has-Labels: Yes

--N6s6lJHOoos=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>chugly has=
 posted comments on this change by Arne Schwabe=2E</p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">PS23 builds clean an=
d make check passes here, and my earlier points are addressed apart from on=
e doc line, thanks=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">management-notes=2Etxt still has &quot;to facilit=
ate the pending authentication&quot; in the app custom control section=2E</=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">In management_send_acc_message() the unknown-flag message says &quot;pro=
tocol &#39;%s&#39; not in the list of supported flags&quot;; that&#39;s a f=
lag, not a protocol=2E Same branch as Razvan&#39;s A comment=2E</p><p>Patch=
 set 23:<span style=3D"border-radius: 3px; display: inline-block; margin: 0=
 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">Vie=
w Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view=
, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Dem=
ail">change 1858</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1858?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 23 </div>
<div style=3D"display:none"> Gerrit-Owner: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Fri, 30 Oct 2026 02:30:42 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--N6s6lJHOoos=--


--===============1428549814181346428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1428549814181346428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1428549814181346428==--

