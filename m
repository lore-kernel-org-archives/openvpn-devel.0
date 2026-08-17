Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CA0C5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gYRX0/7HS53xKSL6dAHo+b4Y7dBCzlk+hQldH9FarIE=; b=VxFoz3zW1yaAsZ63C7rAsQkEOk
	aYS0lQFlaxhHtH5eWu1f0b7fwOmMa8RHqxQt/i4AmvMzmU3SA9Z5mdTgw5G9JQClvZR6DWrpLS78S
	Rar2Qv4XiINyXC4rgflJ/MSSIEErWKubgOYSBy/oomXJmASFDXotEMGYIbx6SBGtpQic=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvwA9-00050z-Gx;
	Mon, 17 Aug 2026 12:09:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvwA8-00050s-NJ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:09:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0p9jw+BjICDHzYgYaVHvzaThu2HriVXHiXC99wjz6Yk=; b=GpqCLc/u0PLta+M1voWdICTqrz
 S50987YpdICuhkwx/fB9n0xydP9WEY1Oa06MYceqlO8CeM60cHJeexa6mxaL0CFcouvwi4HKEBC/F
 JSCpC1+W84dnTrih7kKpj+V5JbAUvQqK2HUSlLnZJWnhzBRNn7XTDKzw4ugxdL+E1tdU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0p9jw+BjICDHzYgYaVHvzaThu2HriVXHiXC99wjz6Yk=; b=k
 Fw+KWOLP6jivcihO79l/FY1D9uxStM+fBCEhvlyhaFZ26SuEA4BzKydnDxeUzHO7ZBWGnphhbRHtj
 /iYwJpvk7TTXy4ccU59U36zhI4Kmk9xzGSzt533c/AEQHLOKxYBUhuXsCHmArXCx6cD6Fz0+JW1Q5
 YY5pZyK1gjDDTXbE=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvwA6-00058U-RI for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:09:57 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-495590dde14so41536325e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786968588; x=1787573388; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0p9jw+BjICDHzYgYaVHvzaThu2HriVXHiXC99wjz6Yk=;
 b=VrFz4Sqc8yd2rin/Kdx2S1/eejE1h/4TP0q9hfH2pmdp4d/x5QYhMNpey+T17Dy+dI
 rd8rZrH4rEG7SxVsc7qeu/4yy0qra9Z2xYCgx7zuEm/0/TkAPwBAl1pLjh3qkvDQRrkO
 14m/b57UwdsXsrlpFyukB26ay6GEaP4QooOqwkOSPl0tNMdMsFPCtQeVfHL1iL+YJuCQ
 /sNhm7TsmhmPXvtq1zebFplU5yUU1VPrdjAgbUAcoceGhMs4CVX9DqBT2u2GK1m8OdRl
 35l22l4Zd8jBY6Wh2x0YLu11MaSloQU+izSclv15OdkytaOpe6hQlOkoyO09YGjpO4HD
 hhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786968588; x=1787573388;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0p9jw+BjICDHzYgYaVHvzaThu2HriVXHiXC99wjz6Yk=;
 b=scKxRpRjmVDeYT0HPW8O/mUmKm9nt2UZxlZMXPxkbRCNTJWJtM4w7IYjENkJsCKgB3
 vATNpMkHPvs08GBPwyVKyx3aYWCbiVdqC75ZeGn89GZuzJwRys7SX5Fac8AQcQXZgEZ0
 baRxc+f0dfNPAb0GYg3SXtq4lnWNN40a2AC4kNGvVtAMzsFR2CBNx/Gj3sXXYbW2nogT
 o1G7wpQZQsPh4wWrnAhiT49w0gKAqD0i93bm2U78wRqmiqvBBbyUM/waEbToe8kGlhKb
 cLeaH1bH52yoB2gpXNzKYA5Pq7w8XfLJQjWCWBweZV+cKq09/WXPXQI8FA7tF9PJKZLs
 WFUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3TNkvdyuMawnBSzA7BWYpA9WHsV+78ShVT18Cr/SV+wmCSWJ3BFd1eCF0naEGdpPtkQYEXgzLB/z13Tcn@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzMfOm2N/RXUvnnBPR4Gb+ol7djMk9RuagUCmiGWeJp9P21M7GD
 +SC93+dzJ0Tpd87V/3iLZWhtnlS6/hDBZzSoG6FRXo6Eh0UDb+H+UIQ2kX+eQas2ZpBUd7Ph1K6
 mKYk7bkANTL7Y88KJr/QcF9iqQi/sxpamr4poLiuwm9KwT7VUx++hPwKVMqCjIy0g40L4
X-Gm-Gg: AR+sD12BPQE/dme4hRgJuXeY4gMJurlNNzIFMF02c/GMYUjjrwcwkpLPJ4EoWKUp8Yu
 JJ6X3iTDInb3npnPakoS7b75yhly6CyYup7BCOp0zXt7ZQezqgvDkG+juDaIRTgET/X19O9bQdJ
 yTlYDFlBTlHHDnkvKjRUGQhx/WnIE7jH11FoEbOBh6qfrXLNEOGPSObltlEp5+b1W1RC3ypR1fH
 CwJbIo1L/VU+0tLK8CjgANLOOs2z4SlCAFT4UVHO2AHG49UiMq8NibGD+sGwJUib+lXDIPAdu7R
 +q8EsarMtOcih4SOzIxqT9BA4s5w5z5ECpDUPaiUr+ZxwYLtzaLoaKmAEp+2/7yLJbLSjHyBraC
 S3+pfjzzA6zddnaSBwJA8vDeDvKjfdvHKdkgQ7FFzwKQM1m7MYu0Fupi18Zcw93sIpB5DYWbM4Z
 hmRBODM6HuXnDGN4A27tfyV/ua+pQXmSar6Bnpvcn+uyxsjV07NVhVqMK3co3QeocG406cPjYKv
 +1zpQcZklKSZ7t/QtKUTqBsgRyZBTjayRHFPi0brtqot+/qkUX7vfCukSfDEfWk+jFf0UnyFuxi
 FIECWTK5WMFgOph5LA1d7yOTLhhnkskP4EbelXsXzWQ9rs6vMPU=
X-Received: by 2002:a05:600c:1d89:b0:499:726a:117c with SMTP id
 5b1f17b1804b1-499879bf7d0mr433155345e9.19.1786968588214; 
 Mon, 17 Aug 2026 05:09:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d0fb867sm50150865e9.10.2026.08.17.05.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:09:47 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 12:09:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
X-Gerrit-Change-Number: 1773
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1773?usp=email>
X-Gerrit-Commit: ac5bba75869ca630b9d4e01dc0482b9e34f78b5f
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 12:09:45 +0000
In-Reply-To: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6824058fc9c4efd48ceeb32d4164f97b2a243d85@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ODI0MDU4ZmM5YzRlZmQ0OGNlZWIzMmQ0MTY0Zjk3YjJhMjQzZDg1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <10f405ba108e84a69825ed13faf20ad8616959c1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvwA6-00058U-RI
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: Factor out
 options_string code from options.c
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0793731980144242527=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0793731980144242527==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ns4PFMKyvGU="; charset=UTF-8

--Ns4PFMKyvGU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1773?usp=3Demail )

Change subject: options: Factor o=
ut options_string code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

File src/openvpn/o=
ptions_string=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1773/comment/=
b3626000_3dbf7c3d?usp=3Demail :
PS2, Line 24: #define OPTIONS_SHOW_H
> Than=
ks for catching that=2E It didn't cause any compiler errors since options_s=
how=2E [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1773?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I6824058fc9c4efd48ceeb32d4164f97b2a243d85
Gerrit-Change-Number: 1773
G=
errit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mai=
lbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Mon, 17 Au=
g 2026 12:09:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment=
-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>
Comment-In-Reply-To: r=
azvanc <razvanc@mailbox=2Eorg>

--Ns4PFMKyvGU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/options_string=2Eh:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1773/comment/b3626000_3dbf7c3d?usp=3Demail">Patch Set #2, Line 24:=
</a> <code style=3D"font-family:monospace,monospace">#define OPTIONS_SHOW_H=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">Thanks for catching that=2E It didn&#39;t cause any =
compiler errors since options_show=2E [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1773?usp=3Demail">change 1773</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1773?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I6824058fc9c4efd48ceeb32d4164f=
97b2a243d85 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1773 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D=
"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razv=
anc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Comment-Date: Mon, 17 Aug 2026 12:09:45 +0000 </div>
<div style=3D"displa=
y:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit=
-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</bo=
dy></html>
--Ns4PFMKyvGU=--


--===============0793731980144242527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0793731980144242527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0793731980144242527==--

