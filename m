Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B04606A32F
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hzGBawwF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HVCgx2CB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WK07ovJz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TWWFQLwA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QGYHz7qsMnKsnu9vHzp4BRuCTQVLJNTIcy1ggKkFnWs=; b=hzGBawwFwSCAeWnf879h6sC6an
	ha2y+vp6yiZuhrcNunrGb5K3Kjyg2kRj15ZBE3z2cYChhm7R8QLtxvAeQpHUbi6IVl+sF/yd4LMXy
	Hwn86fjA98VWgFZEXXmAUs+3/BdWR+hFupLRk1zIpXzD2iYkkK344154NUbVmagCNM78=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSxtl-000000002BB-1c6A;
	Mon, 16 Nov 2026 14:41:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSxtj-000000002Ar-1cbu
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:41:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7IGYgQNnUwxIkqfPpiD6Q4wfRORDJE83K69pse3/lW4=; b=HVCgx2CBWtMGzKWk5GveEopyno
 hWJTuVCPi1388IIhr22+h7b6ioz8VinncQS7/DaOX/RqG7K3eA5mi+Ucyw96RfnKOiaaSLiLgw4rM
 Yjivnyve9wb9srpp3+ZC1xW4CI9D3n/FjA3QPw0MupgwKBzWIuRK7K/JiIg+GE0QbHiw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7IGYgQNnUwxIkqfPpiD6Q4wfRORDJE83K69pse3/lW4=; b=WK07ovJzhVtYE/eWUUbtMDAc81
 XfMUUtcZyJbGma4oQmS546uns76VOBJUKudSdKm2TKB+Vonyc90iFdVQloN+s/igrZyQL/KTO2na9
 f3ebkbaIFxf3KKbMu6fnTzrlqBZ/neAmnebX+NU7H1rozTrK8yQbdexS6zeVSzbTkQvg=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSxtO-000000000fa-0wbI for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:41:10 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso24114585e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794840064; x=1795444864; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7IGYgQNnUwxIkqfPpiD6Q4wfRORDJE83K69pse3/lW4=;
 b=TWWFQLwAo9JSzetq4eaEkSMtpBFYK9iFWQtuy5oU/dG3qCbNUZXvuIIZmsQXh2RtEP
 6OGwn+RUiD4bH6oHNdN+oA0S1gdr11QyDrLkoTAA/bjEce1/mzMD6RFd/X+jYWE/QNFx
 JtWF+naoTSQniKNn5MhPQEzjRL3gpnr1w4OgxgRRLHGTrg5AJoDpI1HLSqmy357WA1nT
 rKyPPvMJAMFeHaYLnmqMoyuRK0UX2sKk2dXKZUcb35dpbOBTsKoRjLlVgx5fcJcutjDf
 ACpoKrYOi1B6bQioD46zmiUnJ1BHSldbQsKQrwgZtHoBCQsBqEafN6DFAHq1yP+GhfRp
 UUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794840064; x=1795444864;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7IGYgQNnUwxIkqfPpiD6Q4wfRORDJE83K69pse3/lW4=;
 b=COZklTwn52qqJAoUjKQ3Q/H+USb6CMOfygiPm9/zDyXqRgGTnWd/KcXUn40ITEmjL4
 QlOX+5kurh6fxAkRSdOKcbqPmNxDQjJ4oxc9pMVA0nkOyDZKqajSKFPi9sArHxv8UnDF
 SY/NQG2r0+Q/G69v8RbeLlhmFD4lsJBjxZcdvOswVvbmvUhoQyY5mMXa24DJPxYYdyxM
 IXnp8wK5JTiP7yxH/WYjAkJAznAUViKSGxsOzyFzdOSJFPbUFvKB9FYYkHIidsBcvXZN
 2A5V2xd3Ri1MmCDOgc9ECNEDaM2+qgYmyzkEDslXY3o12D6FHjv2wyF48+JTz4icvshu
 UtNg==
X-Forwarded-Encrypted: i=1;
 AL+hErHOMVtPNoduthDnhVVkJBLSDztj0bvcxhQh/IwGtL+hIKOtLVpA2jalb7p2CiPrbYfEAoimiAkQVX9pRZs2@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9gAWARuJtVZFUCZUI2HMhVmHNOYCehnq0JMfjHokmy8+305rYA
 tEk+woNZAGIdi/5E2ZMxeSmLw7OeKCCPEL+jvGHS+YoE+BcXYAfcBCwavLnlT66rmRPbQGDC7Nd
 zD9trrLawRS3SSmqjWgMtO9XwYeaGpeJiy8rYHivJr0jF3i1p36qSQItz41Pv6FUkC9iR
X-Gm-Gg: AYBFou2AkdXab/B3nuQXslz48/CjFhIe0teVmsqt93EYcwzoHb6M3oaztpA2YljBe46
 WxpOVvUOIF6A/cHeeTs/Kmk0LeW2HYUzap+P7gjInft+U0ePYeyQ8kKA2xFjvB1/Cf2mNBozH9N
 xBaLUFpN6Q94TxXwrS0uZyeVbNGb9rAfChmmx9K7UJ3XeeLVtW3kDPQASi13hMm2dIGdglnXSti
 37DW0v3qytzHZHAqJ+RZ9A+pD0G1ZLShtTaHQJ5f4YjsPaksBQ0rtY/XQw5UroM/6LUZHzU7qfL
 DOOy+P7afsjolS4F7mrIzOwvfsy5AisWS7TpJwZAK2zaf6wc5wSOB9bi33bIK9Bt9mnDoJ6In/a
 +kokptO4zO0iCb+d8z6ROXW6AssXTTPvjVC3W7YpHAEYyzUv1+nVN9/fNiTbrch+VC7SUBUegWP
 ktcrMuQOgOVainS5PmqQQ4V+utvTnwSh4wbRwvPqLu188/s42oLESX0sy7WvXukc5MFjiOnBvcU
 +f+V/izXd0ZjhBdWVKAo87AE0Tcpu9NBvO8vG+6cxJHj4HW/lW3hiBGZ20pfjZ/Pa83ay6c6VWm
 RjUtDBfqKPgwbkxJ6+q8kidvlyhsFeZJZlU+xfi2bASwA4p7qY1lczyOv+fHV50yTmh8SzrFdSq
 KmLGYBRCfPgszItjcMZ53WJPiwFFxMrMUTKYimi3eKk3tg4LEoV3k8Euopch5I1AaegQtAJB2gb
 uq8MVHrqByQK0W4b/KTv0PhPkyENKHFnICf+4I
X-Received: by 2002:a05:600c:c172:b0:4bb:5f3b:25a9 with SMTP id
 5b1f17b1804b1-4bb5f3b27f9mr169717895e9.30.1794840058853; 
 Mon, 16 Nov 2026 06:40:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2538b9sm596603585e9.1.2026.11.16.06.40.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:40:58 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:40:56 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: 9c8fabfb154d8e55b56aef80ed34175a48cf2504
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 14:40:56 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9bf33436d1910d43752d8a49c235ebc866f2e0cb-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSxtO-000000000fa-0wbI
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, steffan@karger.me,
 lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4933105071651288503=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4933105071651288503==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CKEAr8YYTMA="; charset=UTF-8

--CKEAr8YYTMA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov, Steffan Karger=2E

R=C4=83zvan Cojocaru has posted comments on th=
is change by Lev Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
965?usp=3Demail )

Change subject: control_msg: Add a shared TLV codec and =
use it for early negotiation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 8: Code-Review+1


-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Gerrit=
-Change-Number: 1965
Gerrit-PatchSet: 8
Gerrit-Owner: Lev Stipakov <lstipak=
ov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Steffan Ka=
rger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
G=
errit-Attention: Steffan Karger <steffan@karger=2Eme>
Gerrit-Attention: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 16 Nov 2026 14:40:56 +0=
000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--CKEAr8YYTMA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov, Steffa=
n Karger=2E </p>
<p>R=C4=83zvan Cojocaru has posted comments on this change=
 by Lev Stipakov=2E</p><p>Patch set 8:<span style=3D"border-radius: 3px; di=
splay: inline-block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;=
">Code-Review +1</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1965?usp=3Demail">View Change</a></p><ul style=3D"list-style: none=
; padding: 0;"></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1965?usp=3Demail">change 1965</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f=
0a24c04e8146 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1965=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Kar=
ger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Steffan =
Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mo=
n, 16 Nov 2026 14:40:56 +0000 </div>
<div style=3D"display:none"> Gerrit-Ha=
sComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </=
div>

</body></html>
--CKEAr8YYTMA=--


--===============4933105071651288503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4933105071651288503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4933105071651288503==--

