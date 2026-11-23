Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0FA606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cD+aWZDF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=O/lRBHA5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=g2V1W90V;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=B7fWW0KO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Bgn2QpIJQSeiW14q1GcIbUY2FGpZEhJW6YtLy3xpHPQ=; b=cD+aWZDF8AY/zDCe5mK8q8APWG
	SQZhdbhzijkGj7MZtX3HW+r9XGD1mz87hTidSvlY0TmMHqVZnR+8guET96WENHa3gCEovDGSc3t0n
	yEw2G68qBCcdRp65g73Vf3Ff3db/GakYU0wgYD1BiyQTi7xam3ocAHSjv/2+EYFHrjHI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVWd4-000000003KY-2014;
	Mon, 23 Nov 2026 16:10:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVWd3-000000003KR-3Cji
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 16:10:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LiCMdVF1r9JjIzmyBgNuKfkvVpfLcxraeCaUV5/1KJE=; b=O/lRBHA5KBJnISbkBbYiYX5gqo
 Ax/R8hLfX1o09MG/IdCN0i95400ijZ3j4NCrLnOfl59YySf3l26RTl2q3L5+ENEyjjOJpXdGBVFjx
 fjvvSD/gfBppSWDIO6koRo6O6HKu5TvUDwu9IIT9RlQSTdaZ0TwD5LSe1JSGHPMqQvIM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LiCMdVF1r9JjIzmyBgNuKfkvVpfLcxraeCaUV5/1KJE=; b=g2V1W90VXUuLp/EgWyCejoN2yf
 CDRUo/UQI7DPPfAdwJIeTH13KSFe8Y7oNRuXw3BUUBoF9VfsUKaY5z3og6XKcEOW3Xc88juCgv8Rn
 QHNlqgNk9YfdsM3czek0zbgvBZ+yaOa6qH+af6qTkjLCN0BQmZqkyBS3ankaGtAtpiF8=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVWd2-000000007rW-0YFf for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 16:10:53 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so2226190f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 08:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795450245; x=1796055045; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LiCMdVF1r9JjIzmyBgNuKfkvVpfLcxraeCaUV5/1KJE=;
 b=B7fWW0KOzeWNfDJE4eqFc7imennrZL8nsvLnBNYUPZ7SeNGvO5PDvRkXdmLZva8E5I
 6Y8Dw8xRyMkvVY/XyEsNDAs6InNCltaCwiEzcs3u1h+Mdb8aNMlO1qQRhiGg2qt/v2Dv
 2yOWiwKUYdXJu5m21nkwUqcWcb5SZrvOzvM/BrZVRCXig34pA8rpe7mgLcP4068qbMQK
 k2JJ5E5AqGuYRn/cuP4Xnf7p+1FJwekIzWqlnFMJN1fExJRxXvTfzEhLujlCLTUF0dy8
 zu9y1+m/9TGc61xEJtbtwxNrPY3tHfx02E4ZQ6keunLbD2CZhO8Ik5TFoIiPsvpX6oY1
 +THA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795450245; x=1796055045;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LiCMdVF1r9JjIzmyBgNuKfkvVpfLcxraeCaUV5/1KJE=;
 b=hf/ByDBpXHPrqrvgntrC5C4VcGantykW7kQBSMoZ3CiWqeAMuICL0qDagQUw/5xVTo
 DU7UrfmOnq5KZolaOs7xDAagk2ymDdnRRvxCeL3E6CQVB0xpDoWqOKX8YDus9qzfHXDA
 hn/MX1dT6xHkZIGkwhuuoL6MHcXUV+LSAxcCHHvKZhbf5CcaczHjJVY8jSJwMi64bM5d
 x0CyNmhcJUZReK3FzuSGMjF6FOkDQAKKgzOE9To+oXxOHwUUkH5s1nEfNXxPSG6ykG6/
 BHnh7XULXBm0825uYh6PaZUwh153hoE53fC7EgAwhH7m9jUA9aUmkfHkfaaZ64Ijqhj/
 5/8Q==
X-Forwarded-Encrypted: i=1;
 AL+hErHm5NCHYq+jVIA6veue4QT7hg00rR5DICc0CRQWuJRjLscvGmhIhbsm3YokYp5YgRRtE+v9ZaW9/bh2WkqE@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/7zACtlNBShwQlYFlILyYHEP+9gCyO2ho0e0MX0sfKHzZqM8uY
 CDY5brsfsNt1qRs/jUIl5gE+9NFxuhR0ovXaAEYWeWtyFBzC8GY6fL6p1bAROADZYoUTTwzCbdn
 aXxFGFD+9rooSmeIaTEZYcl8v9Mcr1yTOcLxITp+xKNxWM9fUlQkK9IFf9eWfRElH8nChc9V28G
 npbr59zg==
X-Gm-Gg: AZFdTZfKbGuKGl2RnrUAo7vTXpi5cnpvSUE85ATBQPopuV40wJhuFs+SFE0frrSkHuU
 TmYusr1hMyjRAmUmrHXABc5g9RAzFPk44h4s9VYP4yOGgzYRW0DjVvS9W8FkDDeKpRSD5rOxJ91
 2OpfHInwjxo+6TTgpM2wJibHcrMXCIDugD8DE8ak1ZcgB4+6l/SwntJ8fO2U3yVuoaCcP+JY66v
 77b3ZHyuswAXi7v4jj94IN7q/ZiJ6Yc5uQKQfyH/bd74kYcO2lWoQKxeexavjDPzCxy0I9/C8xm
 LstZ5BqEmsBFdHlJYffNaLjdEn6IH867XEqBnBHaM6wCmPagYa4Jq63RO1OMbhZXUyhc6tVhinF
 S5VQOid1B6HrYB9zwklrdUnloIJ67TScu/y2Qmobuc6uNFijW1O+38t+HGX3MZ4joFwuzPPJSi3
 BYzVqc1PVCyEVFqyVS3Giy5pixdF10pAOZC2TUr3s768KzA6g5KlugxsFIL9TrYHEcNl3tZvqmd
 95qxjWcY1guFOjmv5GcQWxtL6WGwbkF1Yh8gmnvsJoH4+6Kp9gEQMq+HgfRLeJmnjaHH5835hQg
 NChojCTbs+Fp+F3E1nkqUaGTaks193FOBIVCPgu109WYAs/eI9EMci+wDEnpbQI81txg047SgIA
 JnJsvbXJ/hpvCbEzU3/YRMpoK3rOPaGxo+1jZNaQAiZI57d577bq+icqVGMXG6+i8jwVZ3tdPAb
 8/GdsSM0XW5jeS5lI=
X-Received: by 2002:a05:6000:460e:b0:4a7:790c:4a34 with SMTP id
 ffacd0b85a97d-4abb3b42a90mr21801795f8f.20.1795450245227; 
 Mon, 23 Nov 2026 08:10:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b8b7888sm22862843f8f.42.2026.11.23.08.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 08:10:44 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 16:10:43 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I00b340f30dc3518994b74c49565736524b7df318
X-Gerrit-Change-Number: 2195
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2195?usp=email>
X-Gerrit-Commit: b091ec1e334d9e3fcf809775f4a359ed0e32fab8
X-Gerrit-Comment-Date: Mon, 23 Nov 2026 16:10:43 +0000
In-Reply-To: <gerrit.1794834286000.I00b340f30dc3518994b74c49565736524b7df318@gerrit.openvpn.net>
References: <gerrit.1794834286000.I00b340f30dc3518994b74c49565736524b7df318@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM0Mjg2MDAwLkkwMGIzNDBmMzBkYzM1MTg5OTRiNzRjNDk1NjU3MzY1MjRiN2RmMzE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <842a215043af477ab407c7bdc92eb24467c33a77-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xVWd2-000000007rW-0YFf
Subject: [Openvpn-devel] [S] Change in openvpn[master]: gerrit-send-mail:
 Support user authentication
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7199323319595351078=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7199323319595351078==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6yWIs58W4F4="; charset=UTF-8

--6yWIs58W4F4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

Frank =
Lichtenheld has posted comments on this change by Frank Lichtenheld=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail )

Change subject=
: gerrit-send-mail: Support user authentication
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

File dev-too=
ls/gerrit-send-mail=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195/=
comment/922bdb36_6a6ee3f1?usp=3Demail :
PS1, Line 150:         auth =3D req=
uests=2Eauth=2EHTTPBasicAuth(gerrit_user, gerrit_pass)
> this very much loo=
ks like "user + password", which I might not even know (auth comes via gith=
ub, git [=E2=80=A6]
Added documentation



-- 
To view, visit https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I00b340f30dc3518994b74c49565736524b7df318
Gerrit-Cha=
nge-Number: 2195
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@gr=
eenie=2Emuc=2Ede>
Gerrit-Comment-Date: Mon, 23 Nov 2026 16:10:43 +0000
Gerr=
it-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Gert Doering=
 <gert@greenie=2Emuc=2Ede>

--6yWIs58W4F4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>Frank Lichtenhe=
ld has posted comments on this change by Frank Lichtenheld=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>File dev-tools/gerrit-send-mail=2Epy:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2195/comment/922bdb36_6a6ee3f1?usp=3Demail">Pa=
tch Set #1, Line 150:</a> <code style=3D"font-family:monospace,monospace"> =
       auth =3D requests=2Eauth=2EHTTPBasicAuth(gerrit_user, gerrit_pass)</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">this very much looks like &quot;user + password&quot;,=
 which I might not even know (auth comes via github, git [=E2=80=A6]</block=
quote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Added documentation</p></li></ul></li></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=3Demail">change=
 2195</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2195?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I00b340f30dc3518994b74c49565736524b7df318 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2195 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Commen=
t-Date: Mon, 23 Nov 2026 16:10:43 +0000 </div>
<div style=3D"display:none">=
 Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--6yWIs58W4F4=--


--===============7199323319595351078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7199323319595351078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7199323319595351078==--

