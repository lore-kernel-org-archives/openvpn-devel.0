Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65A7CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 16:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3iRaxRgUJzGYVOXQvXuE1F5KEZ9tM6crkeNXLjoh9qo=; b=gGSssDwmQdlbd70SWYMA/eGSLf
	3ABtr6WlkYLQSwon7ZUv6koFmTlgE741wn96D6Q2Yiy9qEBLzp/ZuxUlrA5osIqWuAh4qqcwkgUsY
	emIEKFYpnSLkolfWqALsI9Um8WmwMJKjZJ8x6bNb4Dx0T5C26abKLEPMiOdUWPaaD2L4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI7io-0001l4-Oj;
	Sat, 17 Oct 2026 16:57:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xI7im-0001kw-KQ
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:57:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XHmknsj7UPuek77Rzs6jpYt7dTjHnxLTDXmZqozcQyw=; b=ktPA39ro3Pbstp7FP6wxgIhr82
 m7ilIRog8Qaza0jliAZS/J5LGxCMi1KcuD7+jgRUbQ3EQ7h9bupzwPDp+7M/axE7Kd85JM9ab7LGx
 5y3M8koERScUitpa14hHnPtAhHiddR4QTujbkqrl6mrr/Oja9Nly9vxxeDky92hGHowk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XHmknsj7UPuek77Rzs6jpYt7dTjHnxLTDXmZqozcQyw=; b=a
 TJNOvwIx7qLbfmAI21uVwai/Q7wF9+rD7DOq5WRmu3nGzYPKvrVkyRmhVzMxCBQYSzcFOoSqCzxM3
 wKw5+y1n08d2dw+FNreqFSmK7VJyTus8USk7ifF68ILfYsvitLvecERECOfyI1GEXs8xvdcidAVT4
 BDKT22MO5Lz5nfPo=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xI7im-0007EI-Ib for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:57:25 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so620141f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 09:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792256238; x=1792861038; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XHmknsj7UPuek77Rzs6jpYt7dTjHnxLTDXmZqozcQyw=;
 b=ZT9bJtwjEFIg9B1YiJT6ia6ql6eQ2XA19Q8Y/dICt4H6njo2B4RgPtESmBu5rpkkWb
 4X6GSIvSWWMhfNKLeYOewqmpaQy6UZLqkZTBBsFXp0wYyeI+beauo0Wi42pg5GWMWg1s
 nPY5pR1i4ZmEv27pGF1gDNsxYZUICIo+3c3bZ7DbGwNXnQHUYLrjVqGwSvOU1gjpSpw9
 yDrgex5Y9mbjx/NxnqIB8OkqVMCTj9M4PWRJW6Vydpzdmy+GS0JmoCPWHCfIeZ6nun2n
 0DvcwT54FieNy4bThGH5Dh1fY/3IQrlnAurBzfFA1Lkk79XSDSsrr6G8UieKMOg776As
 qfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792256238; x=1792861038;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XHmknsj7UPuek77Rzs6jpYt7dTjHnxLTDXmZqozcQyw=;
 b=rsCwmpWqIvTmgRvBdGs+pWBnTEJ28ignkpSM4Mw47jt3KPVVJADhPFEoSfFPBLxlfJ
 Z2gMUjdT3kMubnRZt7hBlHUhFNYTveOzyqxXMtEzA5sjydxOkPgLd2VDZORrE5dAT4f7
 mNGgUMTCzcFfFoV682r9Mar9Ive5DA80KuGxR/DNSIp8ZDvVM0HTeICWjSJxJVEhwv/X
 ObUU2WdB3fGeq4XAojsXJFSEukwbJsDE7OVlTZ4AVB/MCz+Mp3nLI6WeHJ7eEvIDKbWe
 PQsyrrxsz0RzQlWnIoTgjcVql5fA3A/BKTA9MJ9uebGL474pd+eUKkD+oPNOkgXi1v6m
 s5IA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxW6nf8HQdVq8u7oNZCtRpDi9cAB38LLlxSHQWQOWyq8jwMiDs9jWU9KsFp9qEIXbNXzQQ6HXFxNK401WoE@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLlDtYY+HIstVXJ26+V+mSZoqgCHDqeVCFHdnLC+GT4IYYUakpD
 //vlBRID9A74jZURLXKcUvgEYOZiQgrFoZRfFfSgBEGCth++NDqOKUfPNmZq+/MHgEQi0ZGA2X2
 utwfW+PvCDOjuCVlFKABvgKr8plPvYw0JD8GGmaGdScCEBUjeaHoYzMY1YDT1rmax13bJ
X-Gm-Gg: AYBFou0dUXvLrvBEKO/uZwhsDb0y+4zg10UB2HlQPmrhGHU0E7F1pCEa8pRaq8wgD40
 //AJbsXKuHViXlVuZ5TZPA7hoKV6dz25YejfqgIXk3i3TTJfDMF7b/VvMV4dUjQikQOS3kWnhKS
 +v1VglrCzvUErf8ElsFHPazp+nEF/PLNRIjtyAQd5PLie60EGjcxj9Jl++CqXh4cY/AcI8O/s60
 WK6jwawANaFTpltJm1xk5I5RIGafeBMkDvXjT1tbQW5psPXucQTmxn9GLvDDlWLu9HYHG+NP+r7
 QI4B+G3IzKAQE8gFBBXuN4+DkRabSY+Udt0BBBTHmtQ39V7fLUZjBUXIG6O+6/QkPNhMqgHW3y/
 X6eMWzcU4bDsrfoa20Awpzpl9gguXw/59GOQ2NIM7F8Q06ONKPn60AlQd3HFKFRg6XCeLXbCGQU
 U7PQ7NpcdGKc6laDtWbmvCqGBRuB4mR9v0U7NB5e5Z0VQnrzo86qOyRZVJkfo9j5TFVHSyip8QD
 Ujjn0PGZtI9KP4DkCpTRf+bkZICNoLELZKl3zDsAF7Bb1RGLCIIZGRD6qUPNkFQoLtjV+TSUrEw
 9iRPqj5TySd2KYTA0Kkj3oN/CzZZbRsT9rBE6g4yM1N13zxyhb0sjZcZTGIC
X-Received: by 2002:a05:6000:e0f:b0:488:8a5d:ffbe with SMTP id
 ffacd0b85a97d-48e07f9faedmr4382880f8f.33.1792256237819; 
 Sat, 17 Oct 2026 09:57:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd503862sm12152208f8f.46.2026.10.17.09.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 09:57:17 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 16:57:13 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib1b4a9544e09506e95001609262269ab8154241e
X-Gerrit-Change-Number: 1995
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1995?usp=email>
X-Gerrit-Commit: 8c89419a3c7a16eec9f51c0d5a62b219d29f51bb
X-Gerrit-Comment-Date: Sat, 17 Oct 2026 16:57:13 +0000
In-Reply-To: <gerrit.1791901394000.Ib1b4a9544e09506e95001609262269ab8154241e@gerrit.openvpn.net>
References: <gerrit.1791901394000.Ib1b4a9544e09506e95001609262269ab8154241e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkliMWI0YTk1NDRlMDk1MDZlOTUwMDE2MDkyNjIyNjlhYjgxNTQyNDFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <943e1f390c9d7069c19b7fcf73dcd72b75fa0da1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xI7im-0007EI-Ib
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace strncpynt
 with strlcpy
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7417931729941248337=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7417931729941248337==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F/dvi7RLANI="; charset=UTF-8

--F/dvi7RLANI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

G=
ert Doering has posted comments on this change by Frank Lichtenheld=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1995?usp=3Demail )

Change subject=
: Replace strncpynt with strlcpy
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1995?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: Ib1b4a9544e09506e95001609262269ab8154241e
Ger=
rit-Change-Number: 1995
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sat, 17 Oct 2026 16:57:1=
3 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--F/dvi7RLANI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Gert Doeri=
ng has posted comments on this change by Frank Lichtenheld=2E</p><p>Patch s=
et 2:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2p=
x; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1995?usp=3Demail">View C=
hange</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1995?usp=3Demail=
">change 1995</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
995?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: Ib1b4a9544e09506e95001609262269ab8154241e </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1995 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Comment-Date: Sat, 17 Oct 2026 16:57:13 +0000 </div>
<div style=3D"displa=
y:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-=
Has-Labels: Yes </div>

</body></html>
--F/dvi7RLANI=--


--===============7417931729941248337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7417931729941248337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7417931729941248337==--

