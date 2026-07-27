Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF5FC531D0
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B5Iw7daM4Nfh+cKAENp5SMxpUHTzCccEMQM5LygnLsA=; b=mM3jr8dIMH7IvXMxjYlr4fZn8s
	PwEpsDAj2KcYPTSgKlc42X4qoBXvaFmw0i4iHzgC9l68kwRGn+zQoqXsaDefIX/PozLcBOSXDEhCI
	YVa0yGDgi24ZUTeHXVj+bm2Kp6huPiJPWPDCxobI2J4TU0j4s3rj+PKOYFcfsgAbXqog=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woMhV-00006j-OK;
	Mon, 27 Jul 2026 14:53:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woMhT-00006V-Rl
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 14:53:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=/CDWTuQ5rQvbk17+yf61MfFt2J1d234Lq38/yrOCx1c=; b=LF+Stonh8/10WD+BL+UTmrxHUk
 ZkkLxv1Qtz2HfR0812TFovu7uAVOda6Qb1LB6jfqJNF3i083XxvRTC1+Ukk1VM0wTYwDT755RdsFe
 XjKtlARUvIZlyUj88dUCwle0oypywfjh8OxSTRNRfWyycVPYkJ+Hr9AH2soI/gkW3Agg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/CDWTuQ5rQvbk17+yf61MfFt2J1d234Lq38/yrOCx1c=; b=f
 2RIl/e8C5jX5zBrnZfnkNA1K6S4Y0CI24Yt/iOMCSJGNzw6/gPl/U9PbuUT/6j168i3VZ4kXvCUbH
 afkpHlXeN+falbiai8SvRAhupd37w9ivO8vUGCpQbTIJR8Pux2SjOzSlHXoGZBkCF+U03x8vjHo8d
 txlet+Do+hYQGKlA=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woMhV-0001v7-HS for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 14:53:04 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49557167508so27555345e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785163975; x=1785768775; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/CDWTuQ5rQvbk17+yf61MfFt2J1d234Lq38/yrOCx1c=;
 b=ZtgE5sfo53+QKSzP2MACjnMR/bFNrZZciILXnuv30pPkf1eK16MWY2IemrDjXC2HpQ
 qbD1VpZKVNBYv6iYNz89/e6YhX9ucDOmkpepGndSCqMiEpDY0EP5t3nSwD+ieES9vtFc
 Xhq67kKcRDg92ENDwEsVmEaDvdiwWHcyLhHJhLs3FoqxP3GnfqtTEnOBxE3eFbEAQ0Q9
 GJM13/dzQ4QRP0lPIiw/G1oyFfZMhVi8Fzc4dreA77zsau/paokueGlFU4k2HrI11l3h
 0oA0i+NdJmVx1v7FEmSsg8VnyAXp7msB9B//4YbJNZxGsPxevIjyRk+hW8VSHwRL0oOF
 p/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785163975; x=1785768775;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/CDWTuQ5rQvbk17+yf61MfFt2J1d234Lq38/yrOCx1c=;
 b=cr7uK/ktKoKwr4f9w9677ILqH8mg+LcwdFYTMaCcJE930+sh4G9osku5bnHvhRWhpG
 ThsT8o32e+Ygt8JgZxdcGnJnIKJlv7UUi4GQRfccG7JFEc8kYkWMyEnSCwWs0IebULPe
 TDeqDpjh36EKbLpfBWfaGWyvp/m3xNlwvbg58bXWwpYHkrVcifI9fiHEXctfN9QfXh/u
 cnc0UOx8r3vsRZaYl9T3qb7lUCYA6qK+413JAc7g2Z9XbyxGBvQ9Z3pSKlA2t7zTZ17k
 6mSgjOCPZ7A8u/xfL5oFiWBUqI+/SSIZzMngC+0IKqTUxnFS4zwoEr/VOmBeFmP94pqc
 utaQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIkPTkN1x0/p1vBSQXgHMsgleVLm1OKxDYmLKdmObH0AWRtTRnC8EXhPnIWSF5DDcDvWFnBiOMrVGv/qPe@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwfgIKiX4GJmoEZTkkxoFNsNy0Rz1pTFX5BQ9QeoMoxuQLPfGlN
 0qXz4J9UigPuAcLgaxLwmx7DmUejyfVH0i32380ELjx4IyJ1rGZLayCPAnbhitc5xuSdHk2bdlZ
 +sTM1I9BlZ++QbO9+pwneQs7bbkVJSLywxAkWR4oAAz4SryB5k9eSoCvoE0XsuhpIjBfYFU7y7K
 R/sukK+g==
X-Gm-Gg: AR+sD12F4c7XvQJ6gwKBgD7M4Y46D0ckOaCOr2Z0AHTu2+vOpp/O+tMv2dwy1YI9zrT
 l/JRGrlqQTdQZNJRUKjXklCOL7h2o4tCb53LbA4c/oP6fGpCJNCkyuI3tnaZKiL5P06If4PzPOx
 HTfvptGANkfK4rEonSmM8LfKlxiWl+FvOQRxMIyr2SW8rRUozxt60ScnK2/9C8QvwQSLmzWvS2q
 6Ajhj3GvI9tO/NxTVhG2OLw57jwV4z6vXuElFZRqr0APc6TsQB8ia1C/DLNSzgpzeURZNy4l219
 KlTuSp2O1QVdnY1s9Rxrr6J8zzLKOOoHCNl/Nu6tjbJltQQzbeY1szCpHWxfp8WT3WjtaQm187b
 hW7iTaVTxK9mu6H0ZS9ohDU8T87BZJ44MQdzR6D3+9Awhd50MmJuqTnQmwccNC1wbpGplhfmmfu
 cx0ozWv7nwQzBeIf0WQR2TKAgPzyyBXSblYdD7Q/UDttYJnXDt6D2fDfKsSLf77/aOvZs0ddSNa
 /YIu1wUUA+Xz+Va60pZPw9A72oUU2u5v4elJ6mjia2mz0kAv87tK5RwfaTQfAo9kB5PKNAXdG0D
 0gk=
X-Received: by 2002:a05:600c:8b52:b0:493:c2cc:aecb with SMTP id
 5b1f17b1804b1-496b570fc3cmr120525945e9.38.1785163975408; 
 Mon, 27 Jul 2026 07:52:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f9b8b67sm276387405e9.4.2026.07.27.07.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 07:52:55 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 14:52:52 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 1051a4ef164c3c97f42459c97e27384b2e500bf4
X-Gerrit-Comment-Date: Mon, 27 Jul 2026 14:52:52 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ed7432e350bfa49b67d9194243138f0d19c65c83-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woMhV-0001v7-HS
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6886973157047392420=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6886973157047392420==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OU/UsyW2AFo="; charset=UTF-8

--OU/UsyW2AFo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos=2E

cr=
on2 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: multipeer: intr=
oduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 28: -Code-Review


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Chan=
ge-Number: 1089
Gerrit-PatchSet: 28
Gerrit-Owner: its_Giaan <gianmarco@mand=
elbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Review=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Ge=
rrit-Comment-Date: Mon, 27 Jul 2026 14:52:52 +0000
Gerrit-HasComments: No
G=
errit-Has-Labels: Yes

--OU/UsyW2AFo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex, plaisthos=2E </p>
<p>Patch set 2=
8:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #ddd;">-Code-Review</span></p><p><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Change</a>=
</p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">change 1=
089</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
0a13ee90b6706acf20eabcee3bab3f2dff639bf9 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 28 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;g=
ianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Mon, 27 Jul 2026 14:52:52 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--OU/UsyW2AFo=--


--===============6886973157047392420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6886973157047392420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6886973157047392420==--

