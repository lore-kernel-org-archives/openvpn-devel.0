Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC4606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HcyCvsHk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EpZ/fFV+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZzvmdBwj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HdYhTSda
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pKC1yKyu3qHcUuWBm3k/95vFIrrh9NIMpkwF+H4P8LM=; b=HcyCvsHkC2abv5SA4zMyUDaEKk
	vno7WSU1NnczfUIttsXoXY9TY8DnmjmwYeMdtlHH0ERJ4ODnLJ646dCb/IYwJp7to82qig9PrFYu9
	0fYa3XbcyuzhQfzCRxzltAvT+DLgRjL+4rWGdYZ3dRSWgMx96atFOo+BVvTtyz0Hqn0E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNqa5-000000007mk-3Xa8;
	Mon, 02 Nov 2026 11:52:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNqa3-000000007md-2aFq
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:52:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G/l+vdSXgXcVVOxZByQ73+VncYELC4R4szb3flAiEtw=; b=EpZ/fFV+RoXLqpNCjbRchUUm8f
 6+j7MOPhSof5uvrFKPPck4ZUZWjbqAgMeOCaVu2RJWfMgL+gIpt6KVnoZcLk+HUGF67ro+FwaawBS
 cu2XXdzgfXh3EXKlrGkUzWMQakoOqth4qumihUOp+7IcaAGyrgsM1zCLIj6EuwPrw+js=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G/l+vdSXgXcVVOxZByQ73+VncYELC4R4szb3flAiEtw=; b=ZzvmdBwjtJTNqDkKCjDWTa9Bl0
 lHkG5tUH4Mx4s93z7nRdOt6navrXDokkuqEMTYZFTPfGCI/l+N4P+Ts2t75VkwXb7m5ljW0JhBVkc
 H/X6U4E8z3C/hNUAIjMYPydtbxQZIx9zzmiubiE0calhNNVe/BxUgBJd+J/ni/reltPM=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNqa2-000000005tT-0iB2 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:52:03 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so17199045e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 03:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793620315; x=1794225115; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G/l+vdSXgXcVVOxZByQ73+VncYELC4R4szb3flAiEtw=;
 b=HdYhTSda6WDnRyfxfqObZarA2DD4XArbLuZ7BrsNOlqbu8Ug+MbxtL0BUd6ScpTgjM
 KHvsoSPHKG0qxl2L6kQo6tuJn4l6hrkzcr6HbCJRZvluGaqeJbzr8hbwA+8Ndyy3OCmP
 JDT9yL+LHbxDV+W7F87fFj7+xehMeFGeDwetZ0wyIyh8lz3+KImENesySYEgCQnbgvTA
 qOIQM4BRbN/oKTZZgKbtdgKC3+/Zok7ad0SoADgnt4XAYUravdp2Lu7nPH+e0ZMk5DMa
 AIOf6brTKuRwGXwrUC5Wf39yVc5NvWMXh1bWYv2XO7SfOjBZw+Xoqv0wZFss9V9p6t2D
 UKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793620315; x=1794225115;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=G/l+vdSXgXcVVOxZByQ73+VncYELC4R4szb3flAiEtw=;
 b=K5+wszLyzsdiw2DJswgWxIQ8mT6LUKVWYXuAZsGeiG5RROlh4loRMXMP202gq6YL9R
 cm0rtgAWEgdBWoj1mq6SarObWUlat6VPABg5wY2fD4VHoHDPk0x+46SqvB04NLB/nIjU
 lgQloXePEI07/T8fXSC0YsG4jdYJOFomWUoxJkUJnKkPOCiYdwgitxkfP8qTXTtMdp9C
 JUUOunwg7rgWuLM4HlkDaMQyaLVzDfhAHgLcaaWdpwvy3E1RXeBFLSFSmqlhim950Xmm
 FqLqHnztF83cYijvUp+H3+Fm7NDjKYspGzGAmngO2QddD5qbfcr2OpMWMCOgzAUUPEY3
 qe1w==
X-Gm-Message-State: AFq9FYK6ZagSqMvZDbiLS0RQOAjZAH7dyto4MSeIatFzMHsHgzCheGFs
 c9tioz1O23N7filez7T/6z0zNFpD8w5dp6Fvq3pLYaYXMZ8C5Us6M6Ez4rC7wpXOWUNvzfzZIxU
 z9PhO5A+mxleyvlG84oxGGrjv4FQ/rK9QN3n5CElItN3Y+b7Keiid6dyd6ByMqqwy7EGCIXItIf
 QjZdKrTg==
X-Gm-Gg: AYBFou0A3a0TMKHFPllU5VOETkqBeUIBgrpTIl/LhreR5DlbXYaPZiHWHeM7yh2zWaL
 1kHMFrrMVkp/pF+SAcY9Hktfga5+CZ7ntbNzcjU7XgbVO1uVivrY42hitCda6tEFvfUPgTIov4Z
 6OUiFV4YOFj/LVA1oJWbGB302R3ZIHDsikzehteGKV4VQZGIe0H1yPzeP0NEdX2BgKUH1CxictU
 c91tHYiFriXsIH1yaWgJvFv+OfqeAEhIJWhrEWv9/wS4KW6AlCSjU5GqpARNqcm0MFXJysq1wx7
 9YfXty+1yfmQhq6dXcGubFgXfd2BSfZP4qY4wC/cRY3khPQOhBaQTZ5899EcKqGrPOvuQQ/D5sk
 2w2TP9PniihaPk/ig4C1Slch8PMXt63msgGMW6qqFA2BJmaygo7wExpl8G9Eb7+EPbwQPehS4zu
 aSZxtDXfLyo8V6Qqh47JJTdZZ2KSaOUhAhB2QCKuGLABRmlvxSUnbq1FyOw6Ey+5nc9PclilZ89
 30U+xSe4wCR4KBoTXKHLWpJC24nbEVzZUdkHgiN8TAI/+NWMhFr7miqZ8FM1shifXruN5Ketpsb
 +W4qwCp78FJLE6sjs/pXf7bxklsWXp1kV4KpRY3nx/+h8cvYncwbiCs3zi9z9cTWmLKm1NeYtuM
 8kIXYbzGTlapOZil4dEXjLvFf5CR1q+o0NCz+hBWV5Vw0YAwR7ECfdl2tm25/Jtd5zihtZvG0p3
 /e3nX6NGqGT/NIhhSA97dda8GTbi/yrNXRCT4=
X-Received: by 2002:a05:600c:1d23:b0:4a2:167a:c946 with SMTP id
 5b1f17b1804b1-4ac185bccfbmr223961645e9.13.1793620315267; 
 Mon, 02 Nov 2026 03:51:55 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac08b72578sm114990255e9.2.2026.11.02.03.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 03:51:54 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 11:51:53 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce93815
X-Gerrit-Change-Number: 2082
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2082?usp=email>
X-Gerrit-Commit: 2c288d527374c38f44541b24f54c56ede74f9750
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 11:51:53 +0000
In-Reply-To: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
References: <gerrit.1793618230000.I5ee231d157459e6406f1f4c12cd6c6e0fce93815@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkk1ZWUyMzFkMTU3NDU5ZTY0MDZmMWY0YzEyY2Q2YzZlMGZjZTkzODE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a0df3eed0d53b02349f2fdf6543e0fdd4e56d94a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNqa2-000000005tT-0iB2
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove replay-persist
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4241591795466269266=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4241591795466269266==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BlrYaZj5bS4="; charset=UTF-8

--BlrYaZj5bS4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Frank Lichtenheld ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2082?usp=3Demail )

Change subject: Remove replay-per=
sist
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1: Code-Review-1

(2 comments)

File Changes=2Emd:

https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2082/comment/64530744_25f55840?usp=3Demail :
PS1, L=
ine 36:   server mode and generally was a nice feature=2E
"niche"


File do=
c/man-sections/link-options=2Erst:

https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2082/comment/7eb68287_4c40f8e0?usp=3Demail :
PS1, Line 443: --replay-pe=
rsist file
Please add to list of "unsupported options"



-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I5ee231d157459e6406f1f4c12cd6c6e0fce9=
3815
Gerrit-Change-Number: 2082
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Comment-Date: Mon, 02 Nov 2026 11:51:53 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: Yes

--BlrYaZj5bS4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail">View Change</a></p><p>2 c=
omments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>File Changes=2Emd:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082/=
comment/64530744_25f55840?usp=3Demail">Patch Set #1, Line 36:</a> <code sty=
le=3D"font-family:monospace,monospace">  server mode and generally was a ni=
ce feature=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">&quot;niche&quot;</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File doc/man-sections/link-options=2Erst:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2082/comment/7eb68287_4c40f8e0?usp=3Demail">Patch Se=
t #1, Line 443:</a> <code style=3D"font-family:monospace,monospace">--repla=
y-persist file</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">Please add to list of &quot;unsupported options&q=
uot;</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2082?usp=3Demail">change 2082</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2082?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I5ee231d157459e6406f1f=
4c12cd6c6e0fce93815 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2082 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Mon, 02 Nov 2026 11:51:53 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: Yes </div>

</body></html>
--BlrYaZj5bS4=--


--===============4241591795466269266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4241591795466269266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4241591795466269266==--

