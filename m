Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5C5C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uWmU0dopUWZlBZdaxktMFTOeEj4n3QgooR/XxH/LeH8=; b=KuHksBdsdWg44376flUJJr5Rtl
	uwNI8fjrlSRsGegsWjG1o2Sily4nvPooOWKj5k4o6SQ02keQ1FU6dOFdPWZ2MJ3o41JZ/SqRZVK2w
	yZfOmfUkq9zwc/1jOgMZtURpudobaRa4PKdIUqeUP51BDpJGWe8unpwwAiuNCwq05dIY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuYJ9-00038R-Mi;
	Thu, 13 Aug 2026 16:29:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuYJ4-00037Y-8P
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:29:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Hhi5/WF0e+I1mRytl5HChRnQ5GSJ/TMD37WVBTBmOn4=; b=NJtUnchUjRaLzHT6sZNdBtadu7
 bNKPHsQkGLO3fIeWySXOrYct8nkwwjf782kLBmhVFj0G0RrsoT1QnzIT5O2x+w9E5763sRSSIjDVl
 dz2b4IzJnYbkZ7J6lpcZRVMTqr3KhcB+4k4bllaH2vMAJuL40iChU+CIIp3SGQ/QnXQ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Hhi5/WF0e+I1mRytl5HChRnQ5GSJ/TMD37WVBTBmOn4=; b=B
 s5NHwPvdV1+1nObwPgKcmWm1X+DAsGcyymrj+IYOXDMBLzFBBTwfKcyKiPp04ZYP9++E/GuccSl5/
 gkEPQgm6vLNzurw8EtsSVYjjY99M6/ojbIXYCt/NtxJrfPCe38/GKv/M4WbCcWGZ8RausUl2LQK8U
 bz0Jk9lXMB4SUC/I=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuYIb-0006Ve-D4 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 16:28:56 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so983195e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786638527; x=1787243327; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Hhi5/WF0e+I1mRytl5HChRnQ5GSJ/TMD37WVBTBmOn4=;
 b=O10rIY+7jDIvR+CIRVIrOrDt8Rc/x5XdBa7qS+YdJ3tzSkErLSsu2I9cn7JKE67NDU
 NMygd6Eej1GJYQPsxcNAY6I0BkBHzXpqg1B6WmdgPuKhDVev0AL2jTKagAXacdIaGuQW
 xZ+iBPEKvDJepXLExHjNN3vzoJpY2x4J3q9C9SYzp/oW9kcD9XAiSQJihEtjNi09dauK
 KY49PjSf70zUJIyS5LKSlZV5bfUS8yLyLqBmZfs3nL74KIu5GgQv8fmkuPW0yLxTxIyd
 ApViesJfxYj2cJM5ngnXYHoW2PFSXf+BqVXD76VjLcuMTu2GIoHSWaXIQS6mqm/l8yuA
 psHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786638527; x=1787243327;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Hhi5/WF0e+I1mRytl5HChRnQ5GSJ/TMD37WVBTBmOn4=;
 b=K9bndZHfmUN/VklxqhMtf5DzX22O1Dyc9N2SVT3rxvcXm3Q0QDy4BK+KtQQudnzYlm
 gmx+arzJZJi/0+aKyT7BxAUdpAmKNOGaxO9WLr6zM4e88XITlJ3b4IB3OHOS+w7Ax2mo
 M0cnqGmyEfLJGZr5DQnYd9ZRkCq5ylD7cpyRo6/3SvhQ03e3AYdqzw3CGhvMrrPDQTTD
 jk96jis/hINOfvL6Sh7SXKKvzsGNS/+rdddOfTwGqtBnDThr3NbFS8cwltACfsUCUfCG
 feUrRxNv93Ikhho7fnOJ7wjrIaMlAVrUE3e/7JO9EdjlD7+AKdg2aFJ3I0p/C1tO1cUC
 JoRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+eFRN04x7quOSv5RxcLRsDHULWFzoVwJNXdg4UAHtBAxjWQEQyF2KHi6Oa+a004TBXS1ZLlHqFTicVlla@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyOU0ElaZdDkxKsfLaemE7/CG3JG1YAdMKrpo5pywM2JgqjHlAy
 Eawi44+kQalAjq1m7CYUMImArqRsrF47pmcafBT+u+jwcqF7Y8aIBJEcDpqIpZkQTj9Tj8vhIsx
 yoo3IIgbuyv2d0y0piaKxwmh6ff7FD4rVImDl5bPBe5OQlgUDVso7uLyTa5ReMKh27WDyZ/InOT
 oZDujtxQ==
X-Gm-Gg: AR+sD137B6nls4B451eXaJqM2gh+H5YIPrFsyoOmgcuR6PIToRJKyrYRfSfGRH5Hake
 OLFk7spctCRC6lszFXyPDXhRVi+OTSb5fsPb/HLZPVFRyFkwsyxQdJQBAkNb7u5S8AVA5D7/cYf
 RezJX1axMwU45e9TigssiuegrHPrpNLwTGGjOS+nxEOb/SaJGoDS6SQDentBhgwDAuBUmQ84XMG
 Yz4GmsGV3/B7DO9B4zwo1FZ6VHmbSmWrRC+ol92VC9AV3Qzd9Gydt9fkH0wth7ev9FHqqnqwe0q
 ZAcPW1TS9AnJaEny7qsv2yimQ5cjdah34/SrPeSq1mpB9rB0AP8lALaNwrxGsPzSbFjAXZHu5U+
 p+j08tV5eptKyrUzuHEcB0S0q8NFhWLI0T/SGlE09eD9OAelbGaVwdAnejice+1Qrsz++5ku4Ms
 71EynV8KhspJTMul7wlqcS/r9fF2VhGKJUlT1dqljKtaARuMoYeeuA4vNr5/WQ/FD//8i/M3XQD
 UfrR89feHdggMzvefWdhthfqVu+WOq5DyKYcnqlFPWww5nDi53k6Kv3lFPa5eHGJP3cE1Lg+0T/
 S0Jg0BefbTB7+ok88rC8b0gQLrBMlnNl2lLU7Fl1uVjNAwjgd5g=
X-Received: by 2002:a05:600c:4ecc:b0:499:7a4f:d13d with SMTP id
 5b1f17b1804b1-4998219d41fmr79467065e9.4.1786638527207; 
 Thu, 13 Aug 2026 09:28:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d616asm288555e9.3.2026.08.13.09.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 09:28:46 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 16:28:46 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id8524d9c36ea913d557d3f43f1f62acc4186b4eb
X-Gerrit-Change-Number: 1843
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1843?usp=email>
X-Gerrit-Commit: 7d44bf3d965a50387675a82ba31148fbde6fc8ac
In-Reply-To: <gerrit.1786632384000.Id8524d9c36ea913d557d3f43f1f62acc4186b4eb@gerrit.openvpn.net>
References: <gerrit.1786632384000.Id8524d9c36ea913d557d3f43f1f62acc4186b4eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NjMyMzg0MDAwLklkODUyNGQ5YzM2ZWE5MTNkNTU3ZDNmNDNmMWY2MmFjYzQxODZiNGViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4628da9b22a8ce720f70ec3457e42fda578b96cc-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuYIb-0006Ve-D4
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix format string
 specifier for size_t
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2988928685006247774=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2988928685006247774==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CzYW86jF4uw="; charset=UTF-8

--CzYW86jF4uw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1843?usp=3Demail )

Change subject: Fix format string specifier for siz=
e_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix for=
mat string specifier for size_t

size_t being the same as unsigned long is =
true on Linux, but this
produces a warning when cross-compiling for Windows=
=2E Replace %lu with
the correct format specifier %zu=2E

Change-Id: Id8524=
d9c36ea913d557d3f43f1f62acc4186b4eb
Signed-off-by: Max Fillinger <maximilia=
n=2Efillinger@sentyron=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=2E=
de>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1843
Message-Id: <20260813145122=2E14606-=
1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg38303=2Ehtml
Signed-off-by: Gert Doering <=
gert@greenie=2Emuc=2Ede>
---
M src/openvpn/pkcs11_mbedtls=2Ec
1 file change=
d, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/pkcs11_mbedtl=
s=2Ec b/src/openvpn/pkcs11_mbedtls=2Ec
index bf9d953=2E=2E2183217 100644
--=
- a/src/openvpn/pkcs11_mbedtls=2Ec
+++ b/src/openvpn/pkcs11_mbedtls=2Ec
@@ =
-64,7 +64,7 @@
 
     if (cert_blob_size > max_cert_size)
     {
-        m=
sg(M_WARN, "PKCS#11: Certificate too large: %lu bytes, maximum is %lu", cer=
t_blob_size, max_cert_size);
+        msg(M_WARN, "PKCS#11: Certificate too=
 large: %zu bytes, maximum is %zu", cert_blob_size, max_cert_size);
       =
  goto cleanup;
     }
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1843?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Id8524d9c36ea913d557d3f43f1f62acc4186b4eb
Gerrit-Change-Number: 1843
Ger=
rit-PatchSet: 2
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewe=
r: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--CzYW86jF4uw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1843?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Fix format string specifier for size_t<br>=
<br>size_t being the same as unsigned long is true on Linux, but this<br>pr=
oduces a warning when cross-compiling for Windows=2E Replace %lu with<br>th=
e correct format specifier %zu=2E<br><br>Change-Id: Id8524d9c36ea913d557d3f=
43f1f62acc4186b4eb<br>Signed-off-by: Max Fillinger &lt;maximilian=2Efilling=
er@sentyron=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede=
&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1843<br>Message-Id: &lt;2026=
0813145122=2E14606-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38303=2Ehtml<br>S=
igned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/=
openvpn/pkcs11_mbedtls=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)=
<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/pkcs11_mbedtls=2Ec b/src/openvpn=
/pkcs11_mbedtls=2Ec</span><br><span>index bf9d953=2E=2E2183217 100644</span=
><br><span>--- a/src/openvpn/pkcs11_mbedtls=2Ec</span><br><span>+++ b/src/o=
penvpn/pkcs11_mbedtls=2Ec</span><br><span>@@ -64,7 +64,7 @@</span><br><span=
> </span><br><span>     if (cert_blob_size &gt; max_cert_size)</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg=
(M_WARN, &quot;PKCS#11: Certificate too large: %lu bytes, maximum is %lu&qu=
ot;, cert_blob_size, max_cert_size);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        msg(M_WARN, &quot;PKCS#11: Certificate too large: =
%zu bytes, maximum is %zu&quot;, cert_blob_size, max_cert_size);</span><br>=
<span>         goto cleanup;</span><br><span>     }</span><br><span> </span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1843?usp=3Demail">change 1843</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1843?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: Id8524d9c36ea913d557d3f43f1f=
62acc4186b4eb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 184=
3 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emu=
c=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--CzYW86jF4uw=--


--===============2988928685006247774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2988928685006247774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2988928685006247774==--

