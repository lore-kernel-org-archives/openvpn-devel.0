Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3543606A320
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=InckbL5V;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kSXwJA16;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZPXDOTjn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=OZ+FiMDf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=1X+0jZEJzX+3iQB93vI9yYf4lwTuOl5/F/zxvzI2Ht0=; b=InckbL5VbDuMHda/ulS/qO/u5q
	8YWMw9YCLcbfTqWpp43U5GYB4U+0JOLKPNC5vJ63cacqz75IDZCSwihYrQYFSr2FrlO7oh93ADznn
	vG2Sl2w/G7/+UxNBStCjmIYMu++FgSsq/gY9vDf3G0k4M5ii+iopk67dBa9UN9crd0gQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTwom-000000004FB-2TS0;
	Thu, 19 Nov 2026 07:44:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTwoj-000000004F3-3PFB
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 07:44:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a1lQJkF/0flos5mlNq4Q9RDRmUb+0FT0DE9XvbzHQkc=; b=kSXwJA16iVkRh/azU6s2dU2Z75
 zjThdLG4ptPX1l2hhBh70l8PAnwBi8UX+egLS5Afti2i0vAMzwsjLjzIeQRfEkUpwoCovWhoeWyxr
 T1HuAZOpq1dgCVxzwetZj1Xo3zHYHFQBQOvD26z+glyXwgLG6WeOTt4yhMaLXNcD96fc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a1lQJkF/0flos5mlNq4Q9RDRmUb+0FT0DE9XvbzHQkc=; b=ZPXDOTjnYlIp+PKRd/RxPvJTj0
 CxNigToPPSduCuaE/zrHGh9ahb0lEL/CUhnIl+f23bvcxNqzXGKs4J0pnWL9oOL8sl1wvRB0+ukrT
 hGUEx3fls0shYe/Ftqv6Js3Zr2XWVWN6S45IuFl9I0nW3RKmQNPB7QGUeKPeycGW63tY=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTwoi-000000005Vi-0Em2 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 07:44:25 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so17078285e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 23:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795074257; x=1795679057; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a1lQJkF/0flos5mlNq4Q9RDRmUb+0FT0DE9XvbzHQkc=;
 b=OZ+FiMDfh4h4Uy28GnkrTlcUxQwRN1sPrKWQ9v9eOujKuzXAH8DjQRepFcGL7kLEkM
 C7t3wgJxlieJEYaFJ6dd9AcEoeTAeoPdqNYctqYQaFbchR/wyFsyhf1qn/Z72C/87FUU
 S4h5wey1JWfq7LhhPXa/ZcoBDqsMtgSWFozwx52EPbt5xA8PuBBLcj5YKnUdNxVywpeQ
 LlJBM0ZQ/Tzm0lxe1rDuIZZG8XY6rOxxcZwO1tnsUfx8jon+X+14bCQShJfaeDZJKN9W
 L7hvblNPNXuSrI2rS1WDikAk78dO58H957NYgocPm+6ejC2b0BMAtOd/LrKGM5xlxKYB
 90Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795074257; x=1795679057;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a1lQJkF/0flos5mlNq4Q9RDRmUb+0FT0DE9XvbzHQkc=;
 b=nwPqx+sd1eqf33ETagXf8vBvwB5F15quJrOjJ5gLyk/E8Hg+ix0VBrB88mDnPed2ar
 GxNWza/o5r4uhmFANCml6GQ4ZnYcQ/piT1F+OLjEMRunvb5kB55p4e5SSRHNkW5bon3v
 dmY+xASWGTySay+oVP1MmEEV6E7jV/WWY3L8EkLY6EN58KujyJS6dWaw35uR2y3bnPlz
 8ZUiKHr+im8p2icQTK+f4iZ1gY2ikfgLckkFpXMQqVLLMqtQXUJaECr9T7t1j0jqM4ul
 0N8HUAFwm8aI6OO7A2iTEbXSv8baY7RN/oqJsDHrSCKt0VePveIjlRRFkHZv+s0wXIS8
 36og==
X-Gm-Message-State: APuU4Z+bLzQlsNWlqKwTMoA5yY6GgjjrWjQKfFodL9dXB9iTo2lVoXSb
 hwmvQX95CKwhVjdxR5D/1Frv3ZIOEfwIPEtHZy4nEnsM3YNH8f6fa0o79gaEH/uzu4TcvXwJVWN
 DtXhE4VGojBvm3LRg7hI+OKcC+h6HCwaqeYlzPYGadXuXuLI69cZ1M3zhslc4fG+N5iSDT1wlnq
 MGy7oZ5Q==
X-Gm-Gg: AYBFou22j1BJIyjdS1pCP0AkFd9fDwbZtMHCxoH3ibXmElmEFXgVGlFYibz6XNoxFLF
 4jo27vqFOVEZeSwnLnwnnGF9QfnZ1e4DBFC8rrn3zW9MJQxC+IfSXxn8dPNmf0BWhZTAEOQA6hf
 SCL38moGwFzSMKly80SLc4Aq2JZ+agungVH5jXiyUzj4e00Fh5rNbkubD4VJE+Q3uQvOgqntOEP
 KjWG/f7RMF0Rvp7yW0M4DSLJCNNbchfAB8Hne62ykhhGvFMvt1JpJIIHnSJIJtdxlsiRpORoT8B
 sNbgQLO2yarOt7lbPwcORq2N8K8GEEn7Nk4t/yjbrO9azHkoD3ox9hUWO3rof+z6S/D3OooU41E
 CM1nyPu9hmB8dTjuihgUO14kOqRo6VjqFwAy8KFz9IuLCn1khBK4nkGE5G+582urI8SNKG8ldyI
 IJI7TDxn0PptCnygIuUOVQ6at/IQSGtNHktfkshGiUCzAsFHy07Pad2VrP4/TXTYslggA3IeVTM
 SEnHI6pTD4L4Jg6bwhULgEReTYTpCKRjsDoxmgXtS8ghSTM0EZf5+DwTHG15p6nEL4zt0WZsT+r
 xlrzRoNvlVt+ZqBU7FsLrIJjNklZjgaoyf3kYf6baoI6jOZ4YDWy8hDe8dHZT2Nvtg5/WKDtPZ7
 kY2SISB20ZwXEswyY34OIPSOHm3pbOOz4TFwasbfkzGuhUVy8K6Yu4JjdSborD1Wf59+695q559
 98B1IHDTSl1yqdQYeo
X-Received: by 2002:a05:600c:4e93:b0:4bb:5c92:ce12 with SMTP id
 5b1f17b1804b1-4bb7da12f06mr100377805e9.17.1795074257291; 
 Wed, 18 Nov 2026 23:44:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a6560962adsm9178161f8f.41.2026.11.18.23.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 23:44:16 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 07:44:16 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7e70d73f494382e99933d48eef67ecb50a52ee1e
X-Gerrit-Change-Number: 2221
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2221?usp=email>
X-Gerrit-Commit: 6ddfa021563ca174a2968557119e8fc4bb4894e6
References: <gerrit.1795074255000.I7e70d73f494382e99933d48eef67ecb50a52ee1e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDc0MjU1MDAwLkk3ZTcwZDczZjQ5NDM4MmU5OTkzM2Q0OGVlZjY3ZWNiNTBhNTJlZTFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0043dea94cbe3ff085c48c623b45d11d30a1f46d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTwoi-000000005Vi-0Em2
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove
 .svncommitters
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0694331662148508435=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0694331662148508435==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iEXWmzV3I+Y="; charset=UTF-8

--iEXWmzV3I+Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2221?usp=3Demail

to review the following change=2E
=


Change subject: Remove =2Esvncommitters
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove =2Esvncommitters

git-svn authors file =
from the 2010 SVN import, only read by
"git svn fetch -A"=2E The author map=
ping for history display
lives in =2Emailmap=2E

Change-Id: I7e70d73f494382=
e99933d48eef67ecb50a52ee1e
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
---
D =2Esvncommitters
1 file changed, 0 insertions(+), 1 deletion(=
-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/21=
/2221/1

diff --git a/=2Esvncommitters b/=2Esvncommitters
deleted file mode=
 100644
index 0772102=2E=2E0000000
--- a/=2Esvncommitters
+++ /dev/null
@@ =
-1 +0,0 @@
-james =3D James Yonan <james@openvpn=2Enet>

-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2221?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I7e70d73f494382e99933d48eef67ecb50a5=
2ee1e
Gerrit-Change-Number: 2221
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--iEXWmzV3I+Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2221?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">Remove =2Esvncommitters<br><br>git-svn authors file fro=
m the 2010 SVN import, only read by<br>&quot;git svn fetch -A&quot;=2E The =
author mapping for history display<br>lives in =2Emailmap=2E<br><br>Change-=
Id: I7e70d73f494382e99933d48eef67ecb50a52ee1e<br>Signed-off-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>D =2Esvncommitters<br>1 file c=
hanged, 0 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/21/2221/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/=2Esvncommitters b/=2Esvncommitters</span><br><span>deleted fil=
e mode 100644</span><br><span>index 0772102=2E=2E0000000</span><br><span>--=
- a/=2Esvncommitters</span><br><span>+++ /dev/null</span><br><span>@@ -1 +0=
,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-james =3D James =
Yonan &lt;james@openvpn=2Enet&gt;</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2221?usp=3Demail">change 222=
1</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2221?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I7e70d73f494382e99933d48eef67ecb50a52ee1e </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2221 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--iEXWmzV3I+Y=--


--===============0694331662148508435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0694331662148508435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0694331662148508435==--

