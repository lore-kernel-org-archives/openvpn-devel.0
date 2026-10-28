Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBA0606A31D
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jXm5IcO8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OxGGqXsE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=X/fm1AiB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GLAVvmEN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LYjv49KsWVI7176eH9l8crhstwXUD8Q1FXNF2PWBWpI=; b=jXm5IcO8YvjoNxt/0Evz4lp1PL
	jl5nKSAotmfza3XlitUlodrahgdhx5a0R6RruSY5mecXxSHzzH6GMHiX70EZ3uSUK26YGUrK2o040
	gnz3wH+/SnTc6o10tTXDzwDdWO6xXzjMTo/yC9MLeVEJhL6HOVpXi4PoUWy0eAm8yvZo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM26D-000000004Dr-27yr;
	Wed, 28 Oct 2026 11:45:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM26C-000000004Dk-1Q2U
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 11:45:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8WdCEQv7XSvKXxHyevzhtl0ayXRBlHH4fg0mLYk6b8o=; b=OxGGqXsES4Lo/Kc+nSmhoEGqjV
 PIZwV07d+mC1ChwEN7fGBm95p3DglAaad4zzNBLQnC8i6psiASKs3muIycXJpX+4Z/LZm9u//dmRM
 +90qxIZrQdvfqVK2V2xqy9MuWt6Xd218PnqyT7YkmSpMtmZL+/XfPPZL2dpUCZQqar38=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8WdCEQv7XSvKXxHyevzhtl0ayXRBlHH4fg0mLYk6b8o=; b=X/fm1AiBZe6uQpEjsXsFutT5Ad
 VCetj4II3e/F5WA9LJLhqN3GsZvJE7IhXzzIfVyw8d+sywKceQVz5J9pBn19KDaw7gfodV/6/5ZTU
 eg+JfBsZdhFbpWPbaWO7BNigB8Mj7NnrS+Y/233oNp53VOQAVO0Uk1rx2lLTl23T9et4=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM269-000000005Xq-31EN for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 11:45:44 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso7591085e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 04:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793187934; x=1793792734; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8WdCEQv7XSvKXxHyevzhtl0ayXRBlHH4fg0mLYk6b8o=;
 b=GLAVvmENaFLzwJ/XcFwf9HC+4x/kmo8RWj0Fg1yy0ITK97EGu/8R3mFAIq1W02FHcT
 LCPxmFHO+nslNmJcSwr7iUzOENUjOzJJ1bjjM+6XDte9CAnLEDEdGJUqYmT62uAh9jY7
 NVJ+6gVULJQIEyR52hyEDUWVavPxJsEpr7kshuHCp+5XMJtA/pYtlTbjTFJD4WcbzOUI
 M3VpSU6Dl/gDcdZqRG6BwQBuDqpTwxli/4M0olZrBvZer9s01+YBGOkwMvDLa8xntu+/
 b7riywcBow8gqJ2ox3bvC/HjsrtAi1b6gNRdGH97Oewf+lIo+loupby0QYLZab4L9xVp
 VI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793187934; x=1793792734;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8WdCEQv7XSvKXxHyevzhtl0ayXRBlHH4fg0mLYk6b8o=;
 b=fuNLZwc5OJ8LXDPAybWX/xahnWqAcvN5E+LjJw8niXGlyTvEfXKMEcXYDf6VtUZiFp
 Flj/Sm8x8gH3B3i2eZ/jYipU0KloUWfOfVhaI7vr39AvZhPNANs+kjRgA5GJwyVl/Ti9
 RnpzyDhGrlb0rGJdASDBSgZoWjBbJxfEiiAcPg+R+eSqLwztx7HK3xeMf90N7kNhxsxB
 JjxggZu1DTgzO+U1E3qorpjLj+2u4F/7YBVA6CPZVQo2tH4tovo7F38w91a3bhh1yYjx
 dayy+t4J5ikCP/EiaXRYpSss9AK0mp4lJqyMcicvFDFyoYY0mx7kWMhXPCOXi3xer39y
 4fwg==
X-Gm-Message-State: AFq9FYKTOY+YTH+XIHSvYCCEpXqA5mU8Au9+b8kSC7K7AW95HKA6Espt
 QxyYS5lA/fCz55PtXJdbvDPzqDiC0prlMx0AjSURg4QtfPdC0F6nNOfQP8ljjtWLU9MBhNUyKVT
 3jiyyjvwb9u+nYvrFSeRVOlEtsgwh2a7DYpp/l0X8lLZhDSOCN3T5oLJELjr1npZUC98X
X-Gm-Gg: AYBFou0vZDl0xYrr4dDEB8vsTFS6NBF7ISC8y+iMLl5CrXNGaES42joNNO4wXoXoAPl
 3+JY36V5AhO0nurMQ7BYYbb9CnyrDvkYDYW4Qox2uLiQuSlDefGMDnH3kmzyM9nHkzqdLe/VvMr
 gpeuGqbXpakqEt1j/MKT6jUZ/yVpvjqJ7fuAo96GJCZcy7WQmty2nL53jiAKwfxj3T9Pbvym/Uu
 oMqZUp6guBPGya98/69OTGii9hfKLxY85g7nLH+kg3EPt6csiEaBuuTZ6TUR9kNn8DVd4aMdcUt
 YeDoiddZUtjYb55mVyR+0ayWla1Hypk+D5Pftv6O8tOTLdX5cxHl5NGGmzmrmhWdAsdpDRtN8br
 lJ02EIwZFoMV1vo2nnABuFZnCnZzAD2ThBGQZh1L+1H9MdZX6kHtwTZRGIoycboOTfEpss3r4td
 TbtgXESZk9IaOtY9Ic5/iPFCk5QEKsp5eeEzsckNwYrjM8sWL9f9XXl9YS5+qMnOE9Uyibt8yl5
 NkPAa21vZqn8AVHQoj7ztj4Nbzq2R4+khVg/Mlhu0BpznBdt+uQh5skCABLr8ohjlSJLIKMMkZb
 TQbFvzXeMm6wtuPRqZNljvi+5qY+V6f6cjiwJ6Ipp8LPegi4ssn5wFitIR1mimF+RC+hn9DrA4B
 CBMrNdeNy5pveXsqrFzrabjhEup+MXuCiKA/svAYmoCiZyoJAmXMGj8APRwscpEYDVqAUmp8x/s
 /WWWoaNgZ+CaXcwlU3uEvSQG9YswAbbm78VXoK
X-Received: by 2002:a05:600c:4f4a:b0:4a3:5c67:55ed with SMTP id
 5b1f17b1804b1-4a966c40261mr39351725e9.12.1793187933433; 
 Wed, 28 Oct 2026 04:45:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a978d57c36sm40042485e9.11.2026.10.28.04.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 04:45:33 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 11:45:31 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4
X-Gerrit-Change-Number: 2058
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2058?usp=email>
X-Gerrit-Commit: cadb8ca8c1ff8c268285fc89bb059e4623e2e0ff
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 11:45:31 +0000
In-Reply-To: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
References: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTg3MjQ5MDAwLklkZTVhMzA2NGU1MWQ0YTIyZjkxNGU3NmMxZDgxNjVmZGQ0ZDAwNWY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <92f89c4e5c9064a36c096ad17b8bbf633f8cea41-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM269-000000005Xq-31EN
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Mark buffer invalid
 with username mismatch in server side float
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6360378792686663340=="
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6360378792686663340==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wwkI+vyG2xA="; charset=UTF-8

--wwkI+vyG2xA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2058?usp=3Demail )

Change subject: Mark buffer in=
valid with username mismatch in server side float
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2

(3 comme=
nts)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058/comm=
ent/8159604f_a192f5dd?usp=3Demail :
PS1, Line 11: not mark the buffer as in=
valid in those case kike the certificate
Typo: "in those case" -> "in those=
 cases"=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058/comment/6b9940=
6e_26ebd790?usp=3Demail :
PS1, Line 11: not mark the buffer as invalid in t=
hose case kike the certificate
Typo: "kike" -> "like"=2E


https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2058/comment/26a2ec7e_756190aa?usp=3Demail :
P=
S1, Line 14: Reported-By: QiuYiati on https://github=2Ecom/OpenVPN/openvpn/=
issues/1137
Minor nit: it's usually "Reported-by" (lowercase "b")=2E



-- =

To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ide5a3064e51d4a22f914e7=
6c1d8165fdd4d005f4
Gerrit-Change-Number: 2058
Gerrit-PatchSet: 1
Gerrit-Own=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Comment-Date: Wed, 28 Oct 2026 11:45:31 +0000
Gerrit-HasCo=
mments: Yes
Gerrit-Has-Labels: Yes

--wwkI+vyG2xA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail">View Change</a></p><p>=
3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058/=
comment/8159604f_a192f5dd?usp=3Demail">Patch Set #1, Line 11:</a> <code sty=
le=3D"font-family:monospace,monospace">not mark the buffer as invalid in th=
ose case kike the certificate</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Typo: &quot;in those case&quot; -&=
gt; &quot;in those cases&quot;=2E</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2058/comment/6b99406e_26ebd790?usp=3Demail">Patch =
Set #1, Line 11:</a> <code style=3D"font-family:monospace,monospace">not ma=
rk the buffer as invalid in those case kike the certificate</code></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Typo=
: &quot;kike&quot; -&gt; &quot;like&quot;=2E</p></li><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058/comment/26a2ec7e_756190aa?usp=3Dem=
ail">Patch Set #1, Line 14:</a> <code style=3D"font-family:monospace,monosp=
ace">Reported-By: QiuYiati on https://github=2Ecom/OpenVPN/openvpn/issues/1=
137</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Minor nit: it&#39;s usually &quot;Reported-by&quot; (lowerca=
se &quot;b&quot;)=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail">change 2058</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ide5a3=
064e51d4a22f914e76c1d8165fdd4d005f4 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2058 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Wed, 28 Oct 2026 11:45:31 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>

</body></html>
--wwkI+vyG2xA=--


--===============6360378792686663340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6360378792686663340==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6360378792686663340==--

