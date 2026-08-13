Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3322C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=kabRUa6UessgrrOEa+AouVfXLo3JDzCo+MEHXDpZXUc=; b=l6NEm/bAIvJ3ij
	yT7yW6xg2BQEuPG5lMmf4gkatlLnpyOwSYx2NNGufeAubA/MaS7sp9Q7jFNbdm1N8VfQ5lH2CbTPX
	WA0qJnLesJpZqlvWQQV02qViaWzVSvqF4ypQOdG1KRzV5nRiBl5O9px5lMBmpqo5udtlF4XrqmUzF
	UEE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuWhd-0003OP-4Q;
	Thu, 13 Aug 2026 14:46:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuWhc-0003OI-3m
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 14:46:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dhmls7hWAFyKAmD/s0/1WMz3KHJPyILWW69w1Q2mIUI=; b=NTFqoc3h3CGXqsDsPlug9vvt+1
 yr2NEC56vtZ25MYXDeL3IvK6f0kNp4biGsMsG4CeibSb+nS9d/oSEwZnZqz/kIR+aSFXg1x8OWi9E
 /C+6lYChOd3XYd6Bn4YlmVx8ZQ+r2aRY67XeNFs8fSm9CqI8w5Aew2mtHkiZTecFmG6s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dhmls7hWAFyKAmD/s0/1WMz3KHJPyILWW69w1Q2mIUI=; b=Z
 NvG3P2P4pByIn2vJVuY/IYdbSxJH/d84tWHVdVyNvJjDiYV77SwD15ob465/3UmZD7zoK9SyeblV/
 RzlqPDCMlvZiQsmY1dZ4EPIjS+gmPgw5u0f0lIemeEcMPXZ5rh8kD63gN/BuiHZ8Izow997Z90+5d
 HXo7sV0GpAz4mVv0=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuWha-0003rg-Mu for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 14:46:36 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f7854678cso1585771f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 07:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786632388; x=1787237188; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dhmls7hWAFyKAmD/s0/1WMz3KHJPyILWW69w1Q2mIUI=;
 b=QKszZ6TXMj2q4f9vpj26Jp6bQfKG2ZVKLDhJwW0sZPjKmZ5DYi5+tvyGb6zwhQqnMr
 V0Cl/RlnhYqTx5c6YkAjwRU3jmXd5iLKZY48mylzIKo7O9SgiEHD7yFM/bt56LPZVO5A
 jUr+9F1+/tAUDY2TwIPZbCXkXDT1SWOY4O2Fp5X8jA0IGBwxW9b69fxjDM8/+LJJXiQE
 GrIiPa0gTpzlFeyKoBo4vuzIedNbc98HBRpQXR0CuV3b7+2E90TVJ8UIfuck4+TMcJyn
 VDGg8kWYazYiyyDoe7JdC3ZYXVPTSCpgdLsBdPlcT0jC2VsXiF3cIo25hDHk9Azg+NHg
 gxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786632388; x=1787237188;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dhmls7hWAFyKAmD/s0/1WMz3KHJPyILWW69w1Q2mIUI=;
 b=BjKAwEJlubW+530URyqhExh43pK1efvyXAYDwWcryYWByD/YCTYj//PGZqq3ezRVKY
 WtxAP8tHEF2FEKfdDE4gboJ6y+0V+XLCctYs0hZaEISQryL94Jew050tqUozm4I+VmDp
 XJFC6Ju4VBUF8CrxdRRKoaPw4gKhFBuJwGRd7Ngt72I1vgHMg904YR7+9gGnV/Lchn8p
 48c/7veF1XcopAh1fipqxYZvvju8deymzj97EabcdDF6ToMnwQlnDPAWTHJ0Nhmkjjrx
 SsiNHVgPXcFS9045LxXD3cs0PRExQpg536VvUz5MplcrDdOCiqIQGxbQaxmbgBnDJRor
 sudw==
X-Gm-Message-State: AOJu0YxsgBuw9wZVrFRDPjKdaaum8mPLQMYtIH4PsBlYxoeW+BOvZjFf
 xU2OQbmtURebP0sQ+PNTc54oCRKHvuQYrPB9QuBOzLm1C6lWDGMXg4HmvKkAVt2ueTU9KnCvwOa
 hlOQbPHcvBxu7PildJxyRsj02qW9glgUER7iqhsQJjpomo4SkU56vWxaiUnmAbSbIz6xxkaxdgj
 ANjAgbEQ==
X-Gm-Gg: AR+sD10+84tdSDtKD9ZX2HEEN1/NA5UdzTfepqSy0wAbmiCY9ZSTrh+P/m2tkrfDKch
 HljTAn+spdn6ToxH8uxqGKbjxCyNF13dD/50r+YoIMQSfws2vrGQ2/N8D6LNNpigRcndLbkQpv+
 /KC6uygM4uyEgcxoqNdijU1IQJ+MGdlwYkEV1q/PNcG10J8M/r4AHOgH4krld/D/NGiNJ2F+tks
 3BlTDOEIP5V+M6djXyDQwA4D4wrZe1aXj5SIbiOZ7a9W4m3zgXdpmAHG8tbHxukVG0mEthYREvf
 Ii+zRoFS5e8m++y0w41FqK+LlOP6eloRLM/RfUvKVOU6dy4nWgyOOo9diZD66KzTpeTLLu6yjdX
 Jsu9TIOOswADCiKVovCXkbhmvHcYFHGBEfsSPLGzN/GZkfG2Z3h6Jls+IOVqw6LyQNnQDJHzvZ1
 1h5JKgBnNYW8T165irkfz7FCzs+D8BotwCNhobUtqq+K09edmqlpy2EdtZgnh78Rtj50i5gZL2Z
 m7BqRIeZrlTrQJAM9dCK+5A8q7Gj2/zNA2QW2QUiC7YGTiuG36RCOqCwgx9Eo2zquo0S+ML5lIB
 TrvomO0HVuXxP8dSmj6BBoqrFsvzT4iiDetGaHWEcdZwwitKB5U=
X-Received: by 2002:a05:6000:1861:b0:47f:9568:ebf0 with SMTP id
 ffacd0b85a97d-48159ffdcbfmr8418173f8f.23.1786632388086; 
 Thu, 13 Aug 2026 07:46:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5c2769sm6875985f8f.36.2026.08.13.07.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 07:46:27 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 14:46:27 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id8524d9c36ea913d557d3f43f1f62acc4186b4eb
X-Gerrit-Change-Number: 1843
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1843?usp=email>
X-Gerrit-Commit: 053e6a74f801d2670d17bcd667d775f87eda4bfa
References: <gerrit.1786632384000.Id8524d9c36ea913d557d3f43f1f62acc4186b4eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NjMyMzg0MDAwLklkODUyNGQ5YzM2ZWE5MTNkNTU3ZDNmNDNmMWY2MmFjYzQxODZiNGViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0d2a6874d9a6eb12b1b88e5c7ebb5615f6e81c03-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuWha-0003rg-Mu
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1970764894885788780=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1970764894885788780==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="d3vjeSfRHwY="; charset=UTF-8

--d3vjeSfRHwY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1843?usp=3Demail

to review the following change=2E


Chang=
e subject: Fix format string specifier for size_t
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix format string specifier for size_=
t

size_t being the same as unsigned long is true on Linux, but this
produc=
es a warning when cross-compiling for Windows=2E Replace %lu with
the corre=
ct format specifier %zu=2E

Change-Id: Id8524d9c36ea913d557d3f43f1f62acc418=
6b4eb
Signed-off-by: Max Fillinger <maximilian=2Efillinger@sentyron=2Ecom>
=
---
M src/openvpn/pkcs11_mbedtls=2Ec
1 file changed, 1 insertion(+), 1 dele=
tion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/43/1843/1

diff --git a/src/openvpn/pkcs11_mbedtls=2Ec b/src/openvpn/pkc=
s11_mbedtls=2Ec
index bf9d953=2E=2E2183217 100644
--- a/src/openvpn/pkcs11_=
mbedtls=2Ec
+++ b/src/openvpn/pkcs11_mbedtls=2Ec
@@ -64,7 +64,7 @@
 
     i=
f (cert_blob_size > max_cert_size)
     {
-        msg(M_WARN, "PKCS#11: Ce=
rtificate too large: %lu bytes, maximum is %lu", cert_blob_size, max_cert_s=
ize);
+        msg(M_WARN, "PKCS#11: Certificate too large: %zu bytes, maxi=
mum is %zu", cert_blob_size, max_cert_size);
         goto cleanup;
     }
=
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1843?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id8524d9c36ea913d=
557d3f43f1f62acc4186b4eb
Gerrit-Change-Number: 1843
Gerrit-PatchSet: 1
Gerr=
it-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--d3vjeSfRHwY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>MaxF would like plaisthos to <st=
rong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1843?usp=3Demail">View Change</a></p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Fix=
 format string specifier for size_t<br><br>size_t being the same as unsigne=
d long is true on Linux, but this<br>produces a warning when cross-compilin=
g for Windows=2E Replace %lu with<br>the correct format specifier %zu=2E<br=
><br>Change-Id: Id8524d9c36ea913d557d3f43f1f62acc4186b4eb<br>Signed-off-by:=
 Max Fillinger &lt;maximilian=2Efillinger@sentyron=2Ecom&gt;<br>---<br>M sr=
c/openvpn/pkcs11_mbedtls=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/43/1843/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/pkcs11_mbedt=
ls=2Ec b/src/openvpn/pkcs11_mbedtls=2Ec</span><br><span>index bf9d953=2E=2E=
2183217 100644</span><br><span>--- a/src/openvpn/pkcs11_mbedtls=2Ec</span><=
br><span>+++ b/src/openvpn/pkcs11_mbedtls=2Ec</span><br><span>@@ -64,7 +64,=
7 @@</span><br><span> </span><br><span>     if (cert_blob_size &gt; max_cer=
t_size)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(M_WARN, &quot;PKCS#11: Certificate too large: %lu byte=
s, maximum is %lu&quot;, cert_blob_size, max_cert_size);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;PKCS#11: Cer=
tificate too large: %zu bytes, maximum is %zu&quot;, cert_blob_size, max_ce=
rt_size);</span><br><span>         goto cleanup;</span><br><span>     }</sp=
an><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1843?usp=3Demail">change 1843=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1843?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"disp=
lay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerr=
it-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id8=
524d9c36ea913d557d3f43f1f62acc4186b4eb </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 1843 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-f=
illinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--d3vjeSfRHwY=--


--===============1970764894885788780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1970764894885788780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1970764894885788780==--

