Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7A7C982CF
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UuaGRPcs3YpZWwzomgG+MwXQbJn7WO7LuUVNQr6qvbo=; b=Pfz6c/xQPSd4EOFshmBGXvbcMT
	U2RZSbE8wXAymfbAxo8PqC3T71LCVY5EoJ8E7HoRmCoasfxEx59Yzg9nxL6YsRudmCppm4mygWZwT
	lrFoIVz7khF01UWWbT++xaomb0Q0iLOFWW2/h4A0+RwfQaYwhcFChVhXMDuzbE221BcQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7ANv-0000gf-Co;
	Thu, 17 Sep 2026 11:34:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7ANt-0000gO-Ba
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 11:34:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CCiAdaKM3O88HutvIiCYhNUV9YQFPPYrFeiu7+TsPhY=; b=IJnUjRM8uWI0mmI+uABcdWxdBF
 3PvDqZCaftb4m6KiMH8oYlfIYpMc6LzUgK6atzN55pd1CWL61csgiHR1jT4ZjwSGZDR1sGVVdEZoI
 jmZpq9f9OhsQ2VvqT381mARawSu+ZpMZ1/FDpjns7SXpRNohPrjoseGoKuWvqdirwVtg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CCiAdaKM3O88HutvIiCYhNUV9YQFPPYrFeiu7+TsPhY=; b=G
 YCFJrYIgpeC+xEvo/FL/hxbMRPpCdmKbFyA9ndUtyEq8rruNajJloQSC/gzj0RH+0IDZMs2jmntD1
 cNUiYJU4Do5S+jPjyhojYJ9g6KHeb5mFtkV6+HhslkmIev4Aem7LkWLcnI1f1NsDVN5205rTedyCj
 vMefmaMWjeW46RO0=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7ANt-0004HJ-I4 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 11:34:34 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so9670165e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 04:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789644867; x=1790249667; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CCiAdaKM3O88HutvIiCYhNUV9YQFPPYrFeiu7+TsPhY=;
 b=NT+LCwljrD4dusy7hql81YBXmbwJ7FqJYWyiXB761Z1N6KYm+dC/tc5jyx0h35T60Y
 M5ORDb6pFlgTzawVEUF+eMI4NeI0A7yNkk1VcYt0fO/N8BWqhRzZoC9IQCe1sw3sulZa
 uxtv5dJ1mf3+K8QKln7mAoCBGPuwGbgfnbxi+lPXYphRZimpTNjtKYL4MYNY7HGe7K6e
 xuyUeHK1+bxO22LPfy3PxW1PmLo1+vHErHtYP1vdQR2nem0eOhWNQjFGor5r/bkLZUFF
 dBpq4cD2cy+KqWxaEnLvyWYW4yT42BaEF7Nq6znMxpNmI1M40+5yayqjFmwJpiQdJwTL
 gIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789644867; x=1790249667;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CCiAdaKM3O88HutvIiCYhNUV9YQFPPYrFeiu7+TsPhY=;
 b=vVIlkjEte1zts2J7rG9uAhTs6gWF7pfL1i12hQ6PJxwXeFwvrf6u7UN0oMO9tCg6RN
 8PjuREd6m/2wJZsLvosX9pR9RUWf/Y+mcl7RyMsFTIIX1558Uupqxe+zkuhAyUtRUINC
 hhySKWzfI5Viq/sBcbSpY/1UMvy2xHWpZ2MXw+1ygob7yNuQ1HD5cVPudZWnA5pAmIVi
 JSwirbRqj5DDVxqES/8DFzJ9AP45KcvRSliTsFPUSwYTCZnE8ttgE6PILn4GHBFbUvK7
 Nd9cS/mfBGVaTrcd0hRa0rhwctYkQ7m8kB758P5x6DWko+1C0C9INeg0eeZaCqustSmq
 mQzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLnW20oiDY1HJdHHxQME25lHjPxNdNjOVqqNdDE7MUqMnfBquvjEb8wfZBZlDHDPZFFn0TAJBDykybRenu@lists.sourceforge.net
X-Gm-Message-State: AFuF++kMt34+U/2Q2sAvUE2LXldLM9nzOWndIeKMq4SSBLGqE/WHs0Jc
 wYaZLphvxNr4jglJpNhKOywWXqVdVhdAj0swLWcs63VxYLgc8PfdwvLa2R+/uqcXzwXHbgrdLrq
 Ra909H9NO/Dap5GANwU0H6r0MfaH78WoIFwroYN3Erhvn+OFy2tMca9kHB3d9kfUVnXpo
X-Gm-Gg: AYBFou3lxAQc4W6FBbTSm6u/vCQ6yNaHM3l3+/t1Bcpd813iHeqw5WwhRSWghc6TqrL
 VNzgyDWpJi2rbse1Z83uKoBebDJOIsh1vGedcETYOPd+A0l+i19YmMuHVD6gtXeBk1QwwpvVeGP
 e8gv2Y1lZYP+1sAQgaMyUr0kytKexR3UDWt+EB2EfrkdIhEvOKhopSaKopBDSTT5A6HM44l7w0o
 nrytSruns7MnQVUrxeveF0BMAyjG26ckgA0dE0IKC8WFWa1t47juZqsilptycnYDIJX04Q7hqHM
 D9u54Nn/rP5L91i5NcS/2jpIW1RMkNL8MoQ5en3/a2Q+9WFSnQizkqR/5mJCv/HDj23T514yd9k
 t9idN7jH26r2BDGZ3Pk27i16wZWbtYIbEETKEawrn8DXOP3zbU9AyEAHzUgpU0L1JUeCVzlaEh8
 IfNjlOxQdyp+36hfMlecUabDwzbWYerUxKHDkRpn/oZPbhJZ4L7w/nKCvPOg53tjEWG5rJa1wh6
 EokKv7MRHU8Ub+8pcK1hvHZwCTmxTBYtJeNtFMr3ElrQXL6Ep4x/WwxIsw/LQJEcXm6vDLxrtrx
 coX2fRUnnNzUWwIKKClB95QfthzKdPCGxZqTDM6aDcLbZ1G/xE0AzZCtBiDIMg==
X-Received: by 2002:a05:600c:548f:b0:49c:fc6e:8cbb with SMTP id
 5b1f17b1804b1-49ec0543ce6mr76433725e9.31.1789644866909; 
 Thu, 17 Sep 2026 04:34:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf43511sm13980275f8f.33.2026.09.17.04.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 04:34:26 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 11:34:25 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
X-Gerrit-Change-Number: 1902
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1902?usp=email>
X-Gerrit-Commit: ed00063229719e8056263c1b2fbf05ccf7aaae19
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 11:34:25 +0000
In-Reply-To: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
References: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzgxMzUwMDAwLkllYTE0ODFlOTRiYTFhYmUxOGMzOWQ4MWNkNzk3MTg3Yzg4NDI3NTcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3a0b8ba0db90be79c731ddb3742a1b2fb9b1e79a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7ANt-0004HJ-I4
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.7]: Check for
 null-bytes in certificate subjects
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, gert@greenie.muc.de
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9147117039742982791=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9147117039742982791==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/0ONX/yEhtQ="; charset=UTF-8

--/0ONX/yEhtQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos, syzzer=2E

MaxF has=
 posted comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1902?usp=3Demail )

Change subject: Check for null-bytes in cer=
tificate subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 3:

(1 comment)

File src/openvpn/ssl_verify_openssl=2Ec:

=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902/comment/1da26cc9_aea5d429?us=
p=3Demail :
PS2, Line 408:     }
> ``` [=E2=80=A6]
I had to push another ve=
rsion because I didn't check the return value of BIO_reset correctly, so I =
also replaced the for-loop=2E I wasn't aware that memchr exists, so thanks =
for pointing it out!



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1902?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: comment
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Ch=
ange-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
Gerrit-Change-Number: 19=
02
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: syzzer <st=
effan@karger=2Eme>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: syz=
zer <steffan@karger=2Eme>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Da=
te: Thu, 17 Sep 2026 11:34:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labe=
ls: No
Comment-In-Reply-To: cron2 <gert@greenie=2Emuc=2Ede>

--/0ONX/yEhtQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos, syzzer=2E </p>
<p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">View Change</a></p><p=
>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/ssl_verify_openssl=2Ec:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1902/comment/1da26cc9_aea5d429?usp=3Demail">Patch Set #2=
, Line 408:</a> <code style=3D"font-family:monospace,monospace">    }</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">``` [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">I had to push another ve=
rsion because I didn&#39;t check the return value of BIO_reset correctly, s=
o I also replaced the for-loop=2E I wasn&#39;t aware that memchr exists, so=
 thanks for pointing it out!</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">change 19=
02</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: release/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: Iea1481e94ba1abe18c39d81cd797187c88427571 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1902 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;=
max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: syzzer &lt;steffan@karger=2Eme&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: syzzer &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2E=
muc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, =
17 Sep 2026 11:34:25 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCo=
mments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div=
>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>

</body></html>
--/0ONX/yEhtQ=--


--===============9147117039742982791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9147117039742982791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9147117039742982791==--

