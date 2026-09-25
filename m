Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6301AC9830D
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 11:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SneyQGyw/ZYgzBRan/eP7hbwMweK/Qq5R1xV0TZ7N6w=; b=ThRbmcH3iKRWIV1Zk7TBUw601M
	xL7lpAOck8ovDLR68rdd+41eN/wAbzWQqiKUXX/e4+LbEBgiNWarQ3ubnO59A31a3r4zd1LIfmRCU
	a15F/VYLpd1uc/by8aRV9P1U+QssB6sDv+f5kfgxFNuLRNKIwfiBp0x7Pi02MZkul/GM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA4Rx-00077O-Uv;
	Fri, 25 Sep 2026 11:50:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA4Rv-00077H-Dt
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 11:50:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+R2JmmiKRBGOEKk1gv0wsEqORUuPI4I60dTHIZjYDj0=; b=exj+qtKAltJw0ChjiKHgNxbbWG
 IqY5V7BAG+RlZ8/Jv4QXiAffxNvIl334xepGbKCsAT1mZR48P55/LhdSPk6VxsX0bkTRzjx12O5gW
 UY6VXldUn4gTJXH3gCYjZ3USoSbpN5QkYPNYzfFxj2SSU54bsWMzpOiz7Q7fUrAyAW2U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+R2JmmiKRBGOEKk1gv0wsEqORUuPI4I60dTHIZjYDj0=; b=e
 xbR8gTi/7y6vW+AcNk5jpLjq7HS7MtBgVmPh4nnvHTiQ2vA+K3FvDLDDJ5qIjACOaOxKx3djajbnc
 kAKiF756PoLXBNoUYd1LVWJVAxtGKTm2D7nUNaz/wOjbf9SILVGzh+xvBFfX6U5XXo3LGVW0fUSvP
 E/wjTivQtFk+8SQw=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA4Rr-0004Z2-CJ for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 11:50:40 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48449f62b93so263974f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790337033; x=1790941833; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+R2JmmiKRBGOEKk1gv0wsEqORUuPI4I60dTHIZjYDj0=;
 b=Bn6FvHfiZ8C/AfZTyBqN6WKJoJp04c8BUYMwaMDb0hgcprtefDCoiebjiTUj6FRvTH
 1qGp6N3tV8mF3+mppPyM5B0wOfXTZxXN9JXvGYekCsduy5YyZHvfCLhoHFEvvUOiK/J2
 F3mYfZgMbH6PYNSqejeZ5BOTIC1hqHElY1MQeabLtJ42j8bE3QKBMXpHg8cgrk9IaZen
 obRAwIS8EYfPs/6cD28tOCWjoJ9ca6wlQhQfUwC1AYeljUyX7XlKTlugiuZcC5oUf/YG
 rWHQdPiEInEPwmtnGpSScJyljf6SzQ9X0hHb4XzxCmIR8cP9T1yWNfPtdeF26BfhPvjC
 Saew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790337033; x=1790941833;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+R2JmmiKRBGOEKk1gv0wsEqORUuPI4I60dTHIZjYDj0=;
 b=vBzDs7hQu1j448SWhWmLxNBhaVbQ8j+YyQm42X1fLL7lewh4TvVi9eATZbDCB7ACcy
 qXo/qjqVj+PIluJ8hsJN8UjTrhloSSRmLOFjlZd7ppc4FZCfiJBv2ah91uOJOnScipP3
 oSTPX8hFiDkad/GAK8B7Tp8pzF0cf8gOfOM9OZxQQl4OGfRwW76kIWhBaGsz+yYqevF8
 7fwJvHL+7DrsZUgyNNynfoit75dczDIe0KHC+jHdNjubbpLooTXvem/BY6+gm1xVvon6
 H7WPZg+n1HfnSfhdGH+xG58iaT3C68Y8AF0nQdwOY09XazZcRI9EI9u4IXjYkjKNY0He
 8coA==
X-Gm-Message-State: AFuF++mEZAAPRyL9bHPVREc3CJjTyDwF83oap38pviesobDUyuN89RJv
 bKVhYrFQZZjPtVF/+f9Bpl36r5QwhLv40JxqtF2qOprKVW781KAu+B1tO3tT/liQbJGutmlbuoT
 ee7kRGjy0zVkQD9ZBzSNCL6vkjVAkEarxo3pp6CY2bsJpQXsVbq40v4byMJukxw+vgiv2ofrKSz
 01qZ1CTA==
X-Gm-Gg: AYBFou35XnT34McKYZe+lpuR3nKmjGCdwo5m9UIWMYXpVS5BlBf/FStV93To1t8BpIY
 MrMPRAR881LpX2s72Aze1K/JM943fjwKjOX6r5cWu2LFdHqkMMdT0qkuCd5F1+NfCasPZbv1fMu
 I9STSkeMe7rKAV15GIlSuE34QHHjk99+m8zX/3M8IdA6OPC/mktvQMobntWcOEPTmC+vdC7Q7qy
 WJeuizIB6lBjcdiTw/b6XxUA7ZeptPO/e2lyu/AkFdyRZjHe2Yp8dwRTVDVsJf0n+3ORRBd7zvH
 o1nNNFu65whiIuIzRtTkPP8gzvwGXL+GKYv6wNuOBjmaIVpii8yC18yVJRxMWuWKxus88anfJDw
 RZK6nxoz8T0u3FA/LPHKx7HisPHSjZePGtuU/FzW6cs16ABsqkW2vK7398B3Qqlhi0A7NEdweqK
 GEsdkH+Voft4oFDi5B8YA9eGKkFBfCMxyUJGnjW+e4LhpHwFIcN/t5FSNCvTdGz8U2dQt/PtDlD
 Jrb5mk/zXJM0iEm55PeuCILv1N2utewJHqk0tEXukJZMHJHlX5IFSD9/O/D4ZbIt4SD3hBI9uR5
 grZYeY+fwZDHSnHx2ifofFhRAtmvtey6mxXq1EYszzo9EKjSIcjEFTrDZ9B6RNt1DylKf2XH
X-Received: by 2002:a05:6000:4a16:b0:487:13a9:80d with SMTP id
 ffacd0b85a97d-488716a19bamr11459039f8f.10.1790337032727; 
 Fri, 25 Sep 2026 04:50:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a354d57sm6201013f8f.14.2026.09.25.04.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 04:50:32 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 11:50:30 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: 1b0fd629f80b3eeb32e665223402afc26101581c
X-Gerrit-Comment-Date: Fri, 25 Sep 2026 11:50:30 +0000
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <98ea56dad37631ef9aee1fa182933d9237af9dd7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA4Rr-0004Z2-CJ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change most
 ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL
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
Content-Type: multipart/mixed; boundary="===============4315311814774099342=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4315311814774099342==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c+2q0kQuUwQ="; charset=UTF-8

--c+2q0kQuUwQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1942?usp=3Demail )

Change subject: Change most ENABLE_DEBUG ifde=
fs to ifndef ENABLE_SMALL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 10: Code-Review+2


-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
Gerrit-Cha=
nge-Number: 1942
Gerrit-PatchSet: 10
Gerrit-Owner: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 25 S=
ep 2026 11:50:30 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--c+2q0kQuUwQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld has posted comments=
 on this change by plaisthos=2E</p><p>Patch set 10:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1942?usp=3Demail">View Change</a></p><ul style=3D"list=
-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail">change 1942</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f96cd1c3488b558b8a59=
7594d99edcba1214d27 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1942 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: F=
ri, 25 Sep 2026 11:50:30 +0000 </div>
<div style=3D"display:none"> Gerrit-H=
asComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes <=
/div>

</body></html>
--c+2q0kQuUwQ=--


--===============4315311814774099342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4315311814774099342==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4315311814774099342==--

