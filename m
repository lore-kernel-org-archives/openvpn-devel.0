Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1F8606A323
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IZDSgGHu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KjDRwuNl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fCXMX2Xh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ABoI5dp5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TmLbPmaTE3R8Y+VrJju/KiMmXL4OyLMrJ3DcqjS3A8E=; b=IZDSgGHum5EjYClgSG8edz0ONI
	hCZoL/R8vs3cPLYRgTfEw7HVQnPJWe5Qr+umcn7owFLmwa2IetIn3NqkqJ9+Kw9KzGXkae/5jiSWw
	S6oQ6B9kTsd0LIKin8iMlbMwI9VQrYZio3RJnHUIEhZ5rAMaXDzEcMnaf8av2utluz+E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWYPv-000000003XG-3K2G;
	Thu, 26 Nov 2026 12:17:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWYPv-000000003X9-0V0h
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 12:17:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Iq4+Xn7l3H+zmKhEdGDpUIpxqboNPu1y+pHvsDScbg4=; b=KjDRwuNlSlNod0QL3bJEpZLpu1
 F4HJ/eJU13hmYACn3mBLJyx65B6IXd5HCYHJ7v1KGpPYUaLczizEYXbQ0DeaeJcn27jilvILt+0iB
 1A7gmbtOJuuC08Lvs32C8aJtPY4YIMZgfV8IvD9tqWCsEELx5m2ALLu48RYJhLv+MJbc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Iq4+Xn7l3H+zmKhEdGDpUIpxqboNPu1y+pHvsDScbg4=; b=fCXMX2XhE8xDq0KLssNPYuMGBz
 vPNLAV76VzEeRXLVmTQmMAxRdGw1b37Gv7WHrBxByOFkkmNYHdgQ2ylCRE3PMJQv1lAaIuZFAoMxP
 SFyX/rqjGWRhF6xz4ZJS98JQgyQqCbInLSYdHvqbGBU5yGsqUq4OhenIPvRmR3sK5XHE=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWYPt-000000006iP-0Jxx for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 12:17:34 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so74006275e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 04:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795695446; x=1796300246; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Iq4+Xn7l3H+zmKhEdGDpUIpxqboNPu1y+pHvsDScbg4=;
 b=ABoI5dp5rqF7zHhYHwCAn6aH841k1El+leXsbQrjd4e233GxgesR1u1iU0RwnhuyJV
 8wnwqHacWwaNS6IYUD2keB2KLEdDmsIuAq97FHNIrUseyqA0lac1adh5q3Eb/D+cs92d
 5k8m+MDSGCi5ercDpQlGgr4rr8GeYES/9kyw6aHvURPqWqRKKltG2FjR6rLz8AfKoHXX
 igWSw+IwJxkA1C6N9qt8yoMY2x9wGJafB9xZq87wlbQ2oQMNiaCrWf4y8PpbOOBHSKth
 0B7HNkgZCmCDarS4e51OsYbd5nRIOeaicXEpONZbjiJD9R7VM04BaO+aRtzpaEtqqRJo
 1gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795695446; x=1796300246;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Iq4+Xn7l3H+zmKhEdGDpUIpxqboNPu1y+pHvsDScbg4=;
 b=c7SwIorHR80/wjeMmWCpwGZEK/vFROkIdI0ffK/05/Yph0+ccUoKj6Qn4K4Eox4tb9
 peFl+JrueBRaB0NXckiBjdQg4yZ8ctzitgbSq+RqEiQ5sxIqVREiFHcO4dIGKYRh3WTE
 D/OTdeG+chm7lvG+rpnR7p9GVizl2kt+HkHehS1syfdcWJwSHgnqZF4cLsXHteD6OqsV
 P5jN7d5l2oLII7XIDtEGaOZ7v5CBZq10n6VY8pqXEm7EcN4XJDBCfkcvowoLMT8gnvZv
 rQm0eIbZAXMF8nEcUYeBF04Q85kemvvnd+qWKHK1uJf26/eVJ2f4X92TwP02QktBlf+8
 sbSA==
X-Forwarded-Encrypted: i=1;
 AL+hErGZKjLd0+6FTW26tKXAdIGA4giiNJqEnZtARsmqtiX4HVX8v9bNb3g5OHEQadb7uHQUnRAKeM6IX+K3BIIm@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/sGPA2oUZeAw9qVNqiMYmmZPT5YRrrg2F90ozWScm38uCB5nE0
 iUavWiGRCz/pzY+qirkkesAOhOtQ6cZ/cN6MqgHRuHjZqtcIryC7P6L1pmOHGD/oZRTxS70BPIn
 Wza/e2nBi8bcc6RMKiqZxvO0iWsWMjo5AovPP5VBCTvab3+55gPV/1HVFYu2Pi4rF8b12
X-Gm-Gg: AZFdTZebo0+Ma77rfTChTdplq0S1p5p8JeGY9XVm3qoUXy7VBb+0V3l7LnQeF2HF3fF
 QboeQOHkMJmwkq4k8T2kRdGeHAHFbpPd/AvmrqqIDwm1RrHaecmSaXpw/Kc2lOJrd0g3ng+Anfy
 N9SwdkzBhQe2cSBWY7YCBr4VqYUjvsHi7MQxkqd7ycJXtQ1ogB2QEl7IWHCQZIr9kGxddwX8trY
 dwXdKzFYdGlczG+5naYJlqQrkClzJ/w4ZsuxR13ZyO6IAue/FP1P6YuqK8vh2CydKG/ygnO70Jx
 Du2jb5vkyMpoRGs0u2RbGvMiBdnXyMInxKkFOvZYIzD3gQbkEAdUs9uuZXmnP8HcnTVsOOufNNo
 3DFThq4Zn2cYyvvLrM46QT2z71KmZF+Yobosmr29vjoSjjlakQBqf3mxxv8FgOBYrwi9fmwVgfN
 1PEVzCL6TiDCBwu6H1ZazDaFNuoSqrvqRFGobA2XQxoW7ezJkjLZBOKGQ2rtOW4CWBdlJjFXr/W
 avrTvBTmSJnR67D7BKvr+a5wnMALJZJRbs13UOfxZCr9ukORIbueiBAOQLD4juygvWXIkKYDzPv
 /I76bkxiJfXOrgY5uOn57/drGphEXFo0XIOyWx5FQvR21xPTfLqe/WBseaLy0c8Hj2ViRlUXfhV
 OHbxSIAjwuyjDRN98NrolvOVLIhvazLjNYvRcrfqQGVsuN7SUAQCCEyLpKe+qJSpb7vWxob2Gej
 RbwICvmwWoL5pB9PE=
X-Received: by 2002:a05:600c:a115:b0:4bb:a5e1:74ac with SMTP id
 5b1f17b1804b1-4bba5e195bcmr77979505e9.4.1795695445401; 
 Thu, 26 Nov 2026 04:17:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bba6a0d65fsm125626665e9.3.2026.11.26.04.17.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 04:17:25 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 12:17:23 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ibc58b9c3029ffea4f87093178cf52bbb46f6d837
X-Gerrit-Change-Number: 2352
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2352?usp=email>
X-Gerrit-Commit: fd5b0a0a662a9b6c5559952ae03c331790e02225
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 12:17:23 +0000
In-Reply-To: <gerrit.1795691059000.Ibc58b9c3029ffea4f87093178cf52bbb46f6d837@gerrit.openvpn.net>
References: <gerrit.1795691059000.Ibc58b9c3029ffea4f87093178cf52bbb46f6d837@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjkxMDU5MDAwLkliYzU4YjljMzAyOWZmZWE0Zjg3MDkzMTc4Y2Y1MmJiYjQ2ZjZkODM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fc19e7f71d8459edb3052cd24beb3d91c6d1a793-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWYPt-000000006iP-0Jxx
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: return early
 from man_check_for_signals() if a signal is set
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3795858783096632957=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3795858783096632957==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cKqkHSQz2nU="; charset=UTF-8

--cKqkHSQz2nU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail )

Cha=
nge subject: manage: return early from man_check_for_signals() if a signal =
is set
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 2:

(1 comment)

File src/openvpn/manage=2Ec:

https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2352/comment/27f2ada4_24267f0a?usp=3Demail :
PS1, Lin=
e 3761:                 if (signal_received || man_check_for_signals(&signa=
l_received))
> If we clean this up maybe better to add a `if (*signal_recei=
ved)` shortcut to man_check_for_signals  [=E2=80=A6]
Done



-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: Ibc58b9c3029ffea4f87093178cf52bbb4=
6f6d837
Gerrit-Change-Number: 2352
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 26 Nov 2=
026 12:17:23 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In=
-Reply-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--cKqkHSQz2nU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage=2Ec:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2352/comment/27f2ada4_24267f0a?usp=3Demail">P=
atch Set #1, Line 3761:</a> <code style=3D"font-family:monospace,monospace"=
>                if (signal_received || man_check_for_signals(&amp;signal_r=
eceived))</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">If we clean this up maybe better to add a `=
if (*signal_received)` shortcut to man_check_for_signals  [=E2=80=A6]</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail">change 2352</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2352?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibc58b9c3029=
ffea4f87093178cf52bbb46f6d837 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 2352 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </=
div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 2=
6 Nov 2026 12:17:23 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>=

<div style=3D"display:none"> Comment-In-Reply-To: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>

</body></html>
--cKqkHSQz2nU=--


--===============3795858783096632957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3795858783096632957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3795858783096632957==--

