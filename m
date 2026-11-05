Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62692606A32C
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Wgxi+8Cr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hfJaBtFI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=h6WGxlR1;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DuXslp7+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PJumOUiDmZeBz8EJ5RQetDuRe5yGUeNL1OIfrRSczS0=; b=Wgxi+8CrsAvbLH/OY4d2h4fCIS
	FJV9hGrG0oN/MRvOnJ6Z5nXs4nU6NSJ6LmjZIoDS2dziJ/5K/zV3dCkOS7TLXVaLpDpyw5BJJRVa/
	z34IMORcFFuz0w60pZMZ04V/Ix9om8aA4uk5Aht8WZIzv3aJR+Ru4H7hLpqCVKiMhMWI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOyQA-000000003UB-39n5;
	Thu, 05 Nov 2026 14:26:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOyPp-000000003Tq-1JM0
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 14:26:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=huENO4ti9v/oxLx9FbjhSItTUI5bT1BimjJgg4/k/28=; b=hfJaBtFIBMEMA2vzUI8HmdYn0y
 gDTWfK1wbhEBjlkLPQGIegit2f0oBsnSBZ2B0f89BUax8u8NjbqC2yL6pWuZpXYIqWEfIGlwfqcQF
 1DArFq/qfZzvwzTR1SGCHaXbDPOwWdpJjSloblLjgbVJAp8ezdMeH4EFNDARfyc/TqmQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=huENO4ti9v/oxLx9FbjhSItTUI5bT1BimjJgg4/k/28=; b=h6WGxlR1bQVezA8jOzimsG4V88
 43KD9nnKdykIoZXPqX60qFmVrr/hJ+BTdVY6NHjJHlbdaa9P1eDRmkSEUgu4jQvuAVehgDqQ5S8BW
 vPfVu0TWYh5enZF9cW4m2XdYVe8DfGwCgScEqXcF+GNVpWXxCYeYyKheEP65ZDnNkHqo=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOyPl-000000006Gk-3DuH for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 14:26:07 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so18360075e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 06:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793888759; x=1794493559; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=huENO4ti9v/oxLx9FbjhSItTUI5bT1BimjJgg4/k/28=;
 b=DuXslp7+E7vFU6m9yqCnaB/6lyPcbUd91be5GjtNDxx/bCowxxtv72F5sb0EAYNOb1
 uiqcL42Lqw7iTriXJTlVcxzGxIUD0nElAd5J6yN4dB5xFt8NFYRC0htqprdzskaoKF5E
 7R2z+uEjc90ssCuY3U7qPbZdx4uXzzsSUvkEK7VDuuqi7XQWAPqk9O2w/Vtgvc7gCIA0
 UhFPG5OyKkAMeJ32ilJuHbLn7Sl4K9hF4+mtc7ufsch303pulvfgSZH5d7qzoIXcnzS4
 5XN6+gEfzsH84YdBkzoy/JmyLOS+N5bpCIs58c5Nc1duHOSgKBPTfw0tUFOa6U6AcJHC
 BgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793888759; x=1794493559;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=huENO4ti9v/oxLx9FbjhSItTUI5bT1BimjJgg4/k/28=;
 b=2JvOsJFhappkAQ732/AqTqF4gtVVn1NPOJcbMA2xsDdehWD8kBnA/ak9IfYySEiytY
 3/k0qiENkNzo80xWwc4zF3bOfhF8dxseCj+NQLWQvT1RSfpW/XkScYU5PKiLyQk3lJcs
 HDBZbi6/OrRf10hfwVpLfQjvhjaTzKWAMv74FFQ1AWHDOT3rs6nMwgq5uE8mwLumoVMx
 Rs/iuGpill4ewBZnS9gMLY8X7o3oSO9W/J2CowGUv1v7UtpNddP/qB15AHpr11/+gL1X
 0kwV+AWx87xCsnQ8/fWX1qgulhfAgcVP/C+Sje+hJCe4sBbZLAqr10KWIm+/cRixDqpH
 WPNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByrPHicm4havan2axa1e7bM86MsIcVHikqMT1kJG4gAZBdOd5n/BPDSNJaSLy/V1a4gmi2DReFworaldbnp@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9A+aCnFPYeKlVQwodlK+tUvpo18PNKq/SZCl0YXsUFYXYw43Wu
 7l7+x7cP9XY4Ek4FUElmitshJw9iDFngAY9OiixQxEG+h/+7Z7U+JQk7OgsZurBW7HDOoa3T+Hx
 gjnRneuc1K21LioyFwFFR52OPOUu8R95yeGrt+A94Zz4+EWIgHwmzAs2ZKWv13C70jGx5
X-Gm-Gg: AYBFou2u74MeSN9rPf9U5E4mxYoG5ZvidelLELlZIbu25XvRfprtuDpn3cqYNz2nvFP
 HVDtX7PIa06VheXqJNV+aZ0OMiTDBUbzkJhDWCG7ql9aU6368CRLlH85xvQmpx2my3s4yTTDJA+
 7BZNPTH/Nx72jSbQ/gzKtryRFgQ22g0RJ/tmZKqHSuB2ijRCBDwOAhPYhoGQbB4A1R53hNO5rTW
 uemRN6NpACGoov+njkeg7uTnrv7yhGo8JbHroKkRnLfuDcRPQ2EAaKOqn46jcjQqLPSrcZul6XU
 7OQvQM0XkBLXu5nprXzBt4BeHJcn5CSZ6QgHVP3DcPaWl5S+Ui38RliU8md4t9ORsaWQcgCin+X
 hKX6CGmF+re7xDmCLeUa7g4ZKzKkLG31ZPt504ofEpTj01HS20YR67bahZLBekiK0DqQsOoXjBB
 qFUO1NH3ITPo+w+2HB1SJJrjYCM4PF7MDIvJMiPGVa9S+65VkH87eX2rvU/AEJS+SWvacOlPZOK
 NbtKaPZ4/fXyznaiJ+ksQyxAeP/6rxDSAbWoMiOvQB8P12U0F7azj01sGjD4bgdNOssuUlj/O3n
 6h5VVqlDprCQ6ZK0LDJ3yS+XGRzEoiQ6RTQqB6yGD6CJZxV/2IcjytObl8NhhMfM4EZBHFPSTgq
 UzDOwdYSUtK3k8uaiah5b30gVFd0OaQXBNil3kqEeFph27Kn8SqNk0ZgMKzLZ7su5jfTGbuDwPu
 xhlByjIhNsQJT9Nw==
X-Received: by 2002:a05:600c:3114:b0:4b1:32c8:27db with SMTP id
 5b1f17b1804b1-4b132c8286fmr241785465e9.22.1793888759004; 
 Thu, 05 Nov 2026 06:25:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b452eb99b1sm107549315e9.3.2026.11.05.06.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 06:25:58 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 14:25:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0
X-Gerrit-Change-Number: 1852
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1852?usp=email>
X-Gerrit-Commit: fb08f2ed58217017e53f66a5bae20280bd48bf1d
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 14:25:56 +0000
In-Reply-To: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I307e64079f436aa782f7e24bfff665a545ad2fa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkkzMDdlNjQwNzlmNDM2YWE3ODJmN2UyNGJmZmY2NjVhNTQ1YWQyZmEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <02993280d376511d058b4bae3cfe71b14b890b44-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOyPl-000000006Gk-3DuH
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add unix-script
 functionality to the --management feature
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2571036329371737581=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2571036329371737581==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ducDun0fOKg="; charset=UTF-8

--ducDun0fOKg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld=2E

Arne Schwabe ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1852?usp=3Demail )

Change subject: Add unix-script f=
unctionality to the --management feature
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 16: -Code-Review

(1 comment)

Patc=
hset:

PS16: 
You need to do something incredible stupid like 

--managemen=
t /tmp/some-socket unix
--management /path/to/your/script unix-script

this=
 to actually overwrite a script and not just error out=2E So I think this i=
s quite unlikely=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1852?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I307e64079f436aa782f7e24bfff665a545ad2fa0
Gerrit-Change-Number: 1852
Ger=
rit-PatchSet: 16
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Comment-Date: Thu, 05 Nov 2026 14:25:56 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: Yes

--ducDun0fOKg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld=2E </p>
<p>Arne Schwabe has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 16:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ddd;">-Code-Review</span></p><p><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1852?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1852?tab=3Dcommen=
ts&amp;usp=3Demail">Patch Set #16:</a> </p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">You need to do something incred=
ible stupid like </p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">--management /tmp/some-socket unix<br>--management /p=
ath/to/your/script unix-script</p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">this to actually overwrite a script and =
not just error out=2E So I think this is quite unlikely=2E</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1852?usp=3Demail">change 1852</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1852?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I307e64079f436aa782f7e24bfff665a545ad2fa0 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1852 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"=
> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Thu, 05 Nov 2026 14:25:56 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div styl=
e=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--ducDun0fOKg=--


--===============2571036329371737581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2571036329371737581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2571036329371737581==--

