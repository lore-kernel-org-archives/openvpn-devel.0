Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77007C5516D
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EVxA5dg9a3624vPOfnhM14FfVsf/KZjllPeT16jjZlo=; b=nJqDkPDFXqpiECcPttxCFsukTb
	JOO3MMXObgUkLXMzY4NxNMszUE6/BJo8lFlXiqtR1BoMJLGfamMBEhLi8qDuJ5huhQ4Ddh0rC90Y+
	fhpA/10J1Xfll523KS6kh3tD+Kv8s7RZxw6GYo/bT5mcmGVL1ir0C4NaKJTrboWaAU/Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpVhd-0003b3-Ai;
	Thu, 30 Jul 2026 18:41:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpVhc-0003ax-76
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 18:41:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KCXWfam3VJZKD2FqmWaF5IhrDMmSvEwsmmb2AJx6XrQ=; b=gsCYYFx8OmfelQbwSVDNRgefB/
 PjuUW6MbVeFqYHAgHfa5pTpxnqpodpnSiQA3k6es/w4EGDlr8yMC7puWQaYIJS25ZkBiV7I4mN1/6
 WVg/GBmAE9ezKy/SAi9KaEegMcVC0ZlfpN3La0Tzh7BONf952RPR2Zco46UfTMZ40SHA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KCXWfam3VJZKD2FqmWaF5IhrDMmSvEwsmmb2AJx6XrQ=; b=m
 FaRaQ1XGTHwc8Jk/NsMUEAYM+evzPANk/1oUcFouCkYDDVILOG1Y9JVzBLUbo4fpNfeg8NZZB6noR
 OIFcCAz00IoZzE2LAXBqVeuM+74UY5SeuY/TL+nb8Bvr8M+mZ7omBVdk+zSUBWfo4NWSHPmvJbCIE
 fQKJDK+VfbnZiFd0=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpVhc-0001WE-KF for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 18:41:53 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-495590dde14so1039365e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 11:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785436906; x=1786041706; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KCXWfam3VJZKD2FqmWaF5IhrDMmSvEwsmmb2AJx6XrQ=;
 b=X4dwjRG1RyQZkkwjHZu+C9VuRPEYgR5DjD8z9FqqhYPu4D4u/kKkscr1w9Y95BPENV
 IK/bdYx7vVf1052kGjE0cy2zoNX4hHjS1t6fO9moYn6fqoJ/Bqxss+OYMWa1RyB7J27w
 +SdsMGFon5TxVqUd9+Z1BXFBDODM4vxeI3+JrznI8l8L8N+mxaLrXzaSglvohWBS19o7
 yerOHnbAUvD3UNWMZDvSkrowNi7SyWrCZY/HhfXGnFGZ4p5YaQ8IhHZLl6ILW7Q4ZmVF
 LdLfKlErhq6hZ6rV9CRhIIMrqBeapOWuSYzuqyNORSrdpQBYn5RsIW80lyNfzwg1E+DC
 FH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785436906; x=1786041706;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KCXWfam3VJZKD2FqmWaF5IhrDMmSvEwsmmb2AJx6XrQ=;
 b=iVb1qEhVhsLU/PqNix23dV8NASI512jhgnETHgjXSAdNEXgFAJJWd0u/fTQRfI2men
 l6hlpWEKW5rxkCI6S4sHKV4vgKsiHKxen6QnfWG9RbP+Fpa4Seq7kwTH0rNQ3UnOp3wp
 NIrwRjL9ZrTPrp0D1oaWnQvlwh5AJCsxjcUY0gJtlsX6mXRcCeiRztvC/N70xbzkFeLc
 n5wG6zr3jDU7h/2wOsh8GqKII9LJYUHzxUJMOs2Ew+xOwKXEE0kkMB9wqXaTbdrdoiTz
 gyRRTeUlvGDDxJW/gVdgL/wXc7akm2dnQ+TOwFJmWHy9BDuEEJgXxYmqURVf4FGvggha
 GP+w==
X-Gm-Message-State: AOJu0Ywt7i2f7ulss4cY1v8FcWHXr63deXhQKBSWlLL3M7Kgz+7SB0hU
 7vVYNBgXzL6u6o/C+5/4qaixAd2hdqUAozi0QOcm4E8kXjs0rNKXBdvlJkksJoBkQ861QxOYacS
 e+RPLXwfArPoWYg/1DtK9D36WnrT7z/CmR0NFQOQw9UaeY3lH3Xb4NncrZ1dtmd6tHjeQ
X-Gm-Gg: AR+sD10HxWdvI2BgnUJ1zWpkW9T981VA0uF3PQ2DHJ3JQf4yNVgHEoFJtx+Mbw0MVNL
 /wzYddRuzYJ6ToWW8kO+A73qBUul4twzArpV5PUYKjcLCZwSEowPbkWt3SYsleSDcWezXkbcQT8
 zZPiVPwDLU+R3s1pgIN+gq5kcoChte30sl53pHBxhwW2BQ8Y1Z1mnhGAtN2zASgVVNx+m++9pA+
 gKBHMXlkdztKmUn14eSCA5lI9KlLIs4/xhUVxnF2sZjoDOTCU4MgjwCoWqJorJagTons9zkJm7O
 dS+2/jMfxUTn4JkAT6a7263Dkhq/AcL8uOJzw3BozZn/ak8Oe7HcMB6zBBfDHz6r1f6un7Ewi3W
 NUCJyIINCgS61vB2IaikWLSRyYzT2fm+3Rw/xSi7gsEekqejDnPH7tMfxYX30NTqDBfiF4T9tNt
 0jLceEgVtFjY3FEG8MU5st2vFHdSmxLD7Axv15g6qrzpal+1cIAmycycTN/u2nO4dgkRK+kIyyv
 J4B+gF+pqMTt7m9ys7pJJM54yb8WvtdKcht5Tfj3KUhRAj4RyzoIdTbfLgW9/K3K2W3qy2YA5gE
 IXHCUv4siNPm3mmZdGQwBmxMDnN27CWlVjnvjjLTyuANQbqoitQ=
X-Received: by 2002:a05:600c:3105:b0:495:3b8a:bf11 with SMTP id
 5b1f17b1804b1-49804c6115cmr26226225e9.26.1785436906286; 
 Thu, 30 Jul 2026 11:41:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4980120b42csm83109945e9.10.2026.07.30.11.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:41:45 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 18:41:44 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
X-Gerrit-Change-Number: 1827
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1827?usp=email>
X-Gerrit-Commit: ef634bfdb8b3cd3c3a6c72b105a42f585834b86d
X-Gerrit-Comment-Date: Thu, 30 Jul 2026 18:41:44 +0000
In-Reply-To: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
References: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTYxMTE4MDAwLkkzYjZiYjE3OGZmYjJiYjQ5OTgxYmMyM2VhYmYwNGZlOGUwNmQ2ZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d3d352e8c9b78c10aec99bf870c41d77a162edbc-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpVhc-0001WE-KF
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace SHA256 with
 SIPHASH24 in HMAC cookie approach
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
Content-Type: multipart/mixed; boundary="===============1592899573376197158=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1592899573376197158==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/TWLMLH0VN8="; charset=UTF-8

--/TWLMLH0VN8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1827?usp=3Demail )

Change subject: Replace SHA256 with SIPHASH24=
 in HMAC cookie approach
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 3: Code-Review-1

(1 comment)

File src/openvpn/in=
it=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827/comment/01bfb3d3_3b=
356a6a?usp=3Demail :
PS3, Line 3476:         ASSERT(rand_bytes(c->c2=2Esess=
ion_id_key, sizeof(c->c2=2Esession_id_key)));
I have to say that I don't pa=
rticularly care for sprinkling that `ASSERT(rand_bytes())` all over the cod=
e=2E Might be better to have a
`siphash_key_init` or something=2E It will n=
ot reduce the amount of code, but it will reduce the amount of duplicated s=
emantics if you know what I mean=2E



-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1827?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
Gerrit-Change-Nu=
mber: 1827
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 30 Jul 2026=
 18:41:44 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--/TWLMLH0VN8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 3:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1827?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/init=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827/c=
omment/01bfb3d3_3b356a6a?usp=3Demail">Patch Set #3, Line 3476:</a> <code st=
yle=3D"font-family:monospace,monospace">        ASSERT(rand_bytes(c-&gt;c2=
=2Esession_id_key, sizeof(c-&gt;c2=2Esession_id_key)));</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I have =
to say that I don&#39;t particularly care for sprinkling that `ASSERT(rand_=
bytes())` all over the code=2E Might be better to have a<br>`siphash_key_in=
it` or something=2E It will not reduce the amount of code, but it will redu=
ce the amount of duplicated semantics if you know what I mean=2E</p></li></=
ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1827?usp=3Demail">change 1827</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1827?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6=
fc3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1827 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 30 Jul 2026 18:=
41:44 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </d=
iv>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></ht=
ml>
--/TWLMLH0VN8=--


--===============1592899573376197158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1592899573376197158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1592899573376197158==--

