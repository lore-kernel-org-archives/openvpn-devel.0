Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C0CC44507
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SgN1LxAlwO5pp8864iT/59XS8GGSz7VVHfLOgs3yPSk=; b=UNphuxIFd7QtLY+8uKKXYqzuYA
	xnEX5JX1QqGPzURTrk38Rz8D/pLJdp1Sm5+6pUsnFeg5PinlCxGIsuNQc1Lbm/ijlReKXwlqI8OaK
	sowqoV0MXEWG+oejRPZqUt67eN9Aa2vwg/zLj0oI/5K+BmqQUGFPNqbl3sX3k025suvo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjx98-0003Jf-Uc;
	Wed, 15 Jul 2026 10:47:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjx97-0003JS-4O
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 10:47:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=eDEoQpi1E3prk6jURpkX6eFAKTfRuVChVMwi1as/OxY=; b=mQS2TLmra7FQ71cDSnfcEe0Fr8
 3QRQb2ILjFzhm5N7xQ1I2mRs8QP1mQSJpy0RDdQpQsbsW/5pjVcI8/MqEPsg6Q7as+P30g6jM04nF
 /4Dyw4ZAyMNMy8qtI2yspEAhqIUqUXMIzUSFixMBKFbQYIhVspCGrK3Us/J+5BV8aR3Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eDEoQpi1E3prk6jURpkX6eFAKTfRuVChVMwi1as/OxY=; b=m
 VJcq5xOjxpA1MxHZGbnO4DqOGfaFRFjnyHJgMg5H6+JHvjmuLt9IuqLQqU8CivpGDWDRosZ4AmwKA
 h6mOmUAnPyaH6jQ6q9H6G2A1HRHRoZpNQ8ZmvvhOwKWCmP42gBLU/u2ZmpEMFpxBEQSzN96WfMdqy
 ZmEVg2/iK1OCHlJY=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjx8x-0001sD-Tc for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 10:47:13 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493f60208a5so44910035e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 03:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784112420; x=1784717220; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eDEoQpi1E3prk6jURpkX6eFAKTfRuVChVMwi1as/OxY=;
 b=fU2x4TItXljLeSgap02tnyaaCi3GWFFHJXF9aoNxHn+ogQXousfHAaSGNK1CSrRYEj
 8nc2QFGnS6/6Bb598/OsdqUJbQi7oz6ihDV78PH+vD5OBAQcVxaHd/otRMeX0ENUszPK
 QlEYhzl7m3qiPJWCeIY2DedkJE8HcxBF7iNagTCMYXGqj9ZSTsz3HWLQZM/dvIdrY/yi
 2IaSrcBVopDyrCmQL0ePpHB7OY7pXQ0nL/5W+4M7izBzUkpPat0lLKwt7p66NtyrhsWI
 WGe0ztHYfL/PogDPsxzmus8GYrN5T9dXwwBEwwIJMFIG8vsRxqb8AZ4x1iZiYVMC0q7T
 f09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784112420; x=1784717220;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eDEoQpi1E3prk6jURpkX6eFAKTfRuVChVMwi1as/OxY=;
 b=RpGpvmb8g+RjAFIuypCbUJBGdk+wGd7gW8uhXRS+Gn4ZvxuzYKuBFtCBPF2KWWjU/e
 CNtJZXvQPC4sJ2GkAE/495+NbWDccxMBH7bhROF2Fp4xaUwuVO5Uua+CQWPdFG7gtzqZ
 3lkh6sBykmIBEQ4Ww1xr404USaPISves/BxTqcB5M1482IaziW87vQdCMXb1c5l+0ImG
 0xCBJGkJf6yByKN9eJrGgfLt/K5jJ3bwpJE6YfABCGVmM4YYfwTRRTdzIlf4G4EN7VVn
 quDqItgTDFxZ5v1Q0uW3v9gt779FyqHQ7z91T6zfBhyDBRKE+PlF+kXSTqz1bnDVp1Vg
 OQmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1uIbYlbXjJ0nQEYqWNHMYapTWrcMX6s52NSbIoNM/vFXnS83G/hzSgguqiWEWakBHkYj7Eny4e6tm2T8V@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz5Rm1n5CV6q2A6j/xHjZbrkQBtY1O9eFnawsLWN8JoBr8bULtv
 wJOs2TVkhE7kP1UMrQsKuRMUHdWY3An+DYEniy1xWcMLnyfUad1w4x89oCv4HpjxdFhZXrBxEvc
 uXtqLJTd8fWC97RXA8Bc10XDUaBEojiOfNJlQrjB1Y00I9iAkZUyjQfon+iXmWLwtrgZVOVAKm3
 v3MxzZ1w==
X-Gm-Gg: AfdE7cll/UWNJWMKurg48x4aW9ult8LA/HA39cJFfgg5U7hVzowQuQkmBE7U0u0xoJx
 vp5l/7+Y5n8CqmSHpbl6GMM4z2mCe3dlEO+c1aWdNOfKQWQTD9LWBe71yAoTB6CshxOJg/yJ9Wb
 lLMkQX0qT0DMKTURK2/u6YTAWA/Ds9MRQlBscjSSmiB4Xm8mKe40LPZgHysnRzIAt6TNhKLMUmY
 nu9F7pxUWdrj10Kk6P4UiJbFET6RcNZIHR1nYONJdwRlIiatYwzdyIjIo1BjqgL4QbQZA135vRn
 3RNtVlzMr0/V8EUVlwIiXOx4KgftMd49XP0CPXQZNKrz8uoAMvn81jFlAlZNYZ8sSK3fN9nilyZ
 ki0vHYEAOWvjsMAxb+NInuk+3Cz+ItbDcGxMy3oN4bcnEY8hFeEPY013BaufnuenuQi+KiPDQM9
 He/8x4oVoFEBgBnCxvBEFUWkgQFOOef5eAExCMVdV1e4JNnsqkckzyENwwphtc0Hxe1M5wdZ+fK
 yCitrkZKZtrMNMvdKbzmPpiexqiet08vFrMOtsIXVYWGRZ6ih5GH84Vale8uBNniMhs9HplIHP6
 9/Q=
X-Received: by 2002:a05:600c:530d:b0:493:f278:ba2f with SMTP id
 5b1f17b1804b1-4953c157140mr26737405e9.9.1784112420147; 
 Wed, 15 Jul 2026 03:47:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495086ca93esm143213195e9.0.2026.07.15.03.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:46:59 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 10:46:58 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I087cbccc9b4a994376aa2d2409509a2307068899
X-Gerrit-Change-Number: 1784
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1784?usp=email>
X-Gerrit-Commit: b180e57b096faa86e9821d68b0bf05f9ee15f42f
X-Gerrit-Comment-Date: Wed, 15 Jul 2026 10:46:58 +0000
In-Reply-To: <gerrit.1784067448000.I087cbccc9b4a994376aa2d2409509a2307068899@gerrit.openvpn.net>
References: <gerrit.1784067448000.I087cbccc9b4a994376aa2d2409509a2307068899@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkkwODdjYmNjYzliNGE5OTQzNzZhYTJkMjQwOTUwOWEyMzA3MDY4ODk5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a52b307d844216b09fb7af8370244cc762e5ba8c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjx8x-0001sD-Tc
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options_util: move
 subnet_pool_by_tag out of multi.c
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6422597240553749400=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6422597240553749400==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yDUagn/fMLg="; charset=UTF-8

--yDUagn/fMLg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

cron2 has posted=
 comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1784?usp=3Demail )

Change subject: options_util: move subnet_pool_by=
_tag out of multi=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 2: Code-Review-2

(1 comment)

Patchset:

PS2: 
pleas=
e squash into the commit introducing `subnet_pool_by_tag()`



-- 
To view,=
 visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1784?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I087cbccc9b4a994376aa2d2409509a230=
7068899
Gerrit-Change-Number: 1784
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <=
antonio@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ec=
om>
Gerrit-Comment-Date: Wed, 15 Jul 2026 10:46:58 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: Yes

--yDUagn/fMLg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1784?usp=3Demail">View Change</a></p><p>1=
 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1784?tab=3Dcom=
ments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">please squash into the commit=
 introducing `subnet_pool_by_tag()`</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1784?usp=3Demail">ch=
ange 1784</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1784?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I087cbccc9b4a994376aa2d2409509a2307068899 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1784 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt=
;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 15 Jul 2026 10:46:58=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--yDUagn/fMLg=--


--===============6422597240553749400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6422597240553749400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6422597240553749400==--

