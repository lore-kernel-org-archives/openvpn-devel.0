Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A91CA600B
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 11:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d4OMMac02Tf0hJ3VjOT7KQSOJJbsmqFsOTS3/5n14fA=; b=Gw11mI0YDVRXJeas6lJBbgyQmN
	C1kM3O7xv9Xw768Naxg0KBbBsrMoKJP1Js/2V/zrnjtgL1uW+L/afY9Z7FHMuJBJle3B4yAvUnKed
	7v6aV+xLZKRM+KEYGEOv8lIE72Sp++jhcm63VwmTJd2jXOkhdImoPYvtrTOtj78pYZ/M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEmC4-0002Pj-0S;
	Thu, 08 Oct 2026 11:21:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEmBW-0002PJ-Oq
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 11:21:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1nbrVEgQpbo+uxZkcMlzSUQJTLa2fWzojae/Dpjj5uY=; b=VRr3imFFFS1Q64Vp6EMJIvSJKl
 bzEslj2oLW9KMAMDxDudvGJuzbhgK+0wI9fPFba86TjvGG5WO4q+GAi92jiFNi/gKhgnoeTXktPdj
 d/EqqfnjxsIzQNUndZ5Vbl689SpAJubyF2SRsk+2XEXbq8zKfNRPgh8eMhtdN4+7YFOU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1nbrVEgQpbo+uxZkcMlzSUQJTLa2fWzojae/Dpjj5uY=; b=k
 XAipBSel3DXmFqYipFJenQ93B1+W7kULEZS8n9Ur4HeEc2om9ydUjM+GhJ6a+YrFLiZg4fDFa1Gcs
 qTbzVq+SsDBcgDTQqF9J8oIlQPS2dDrteOb4oOw2IsQLl4hbSobi1UuetIL674h3AyQss14DQFVQy
 QAy6YUL7Ee/vGlfQ=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEmBP-0007NA-5h for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 11:21:08 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a021c809e3so29169745e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 04:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791458460; x=1792063260; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1nbrVEgQpbo+uxZkcMlzSUQJTLa2fWzojae/Dpjj5uY=;
 b=LcvNdGlpoVS2w+pcUZO4GvwzC2wceQkqSv0ED6RciaacyMsNDdJFGzOTvxYaBRvUGu
 olsLNIjS2C8TJNdLQGieB9c4EdG5a7DTxO+X6Fng3gFlYbZVZl8C9Gjd6ttr11pBNQyo
 eMTFN/0Hgz1l5gHi44fWCH66hCGgwfY2mQQzqcP6FMBiRFDcH021nvwpbOsHRgpH49zX
 BUawDkkitAlMz9hITLXo81wAAGkdJDJLjvc0KPRXndwyi651G0VVtEqhYqooZDgPpoHB
 n455xUTX8f6QEOtHaQLDr4A6cUda6mHXgoqoGl7DhL7J4kkllZ11XKN/DGLZeVijCJDN
 YUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791458460; x=1792063260;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1nbrVEgQpbo+uxZkcMlzSUQJTLa2fWzojae/Dpjj5uY=;
 b=ZLI40+ZyXLTQTe2evLW3t9rmu71ThLEqgN4zgsgQ/+K5r61KC9wKS4mc7/OSeyZ1pw
 5sd+jyUjTi/gRntfJWwBVWHZS7NAvzKkW7w0TjnO5ZNRznfbzMYayHdt5J7ccSqbir1d
 z2OOTFJpIybRmapz41VwO6CcZx0SGSk4lX8mhXW2Woo3u6/hgWzdzDdzBDuQCDX010gU
 aWUjc/xTXSh+9OtoDnCTrt3ndYMyWWOyxXD55r6tdKWdOBCGgt4Aq1CO1654wI376Zob
 19FLcyZ9MCUYVS0pvueJS1N/ov5IDSgxZ/6g4esHippFlqylG5zYQYS9EXRhu9+uC4OP
 MXqg==
X-Gm-Message-State: AFuF++mu72Ds8g7ws6hbn35aWRA55Vi7ZEG7ctJ7EsEqNbB6Oag7duq9
 /VjuG91Nh5W1hHD9LM7MSTMyQTzq9J+bnqe4b16V+hnAcyWAQoGiUXBI1X/W1bZxi1FTlMVdAVJ
 aAjoCreiPfvOGnvQiu8ttruppx2HnsF+W0t+Xb853qaU8vy7p3z2K/Kn787ZASzbO66AC
X-Gm-Gg: AYBFou1Qto8SH67qLb+Qq/fFKDXdAJ9CO8cg+8L5q/bZEPHghMTI0zXBJD8FmcX0mXp
 MRS++HWtkbIx19a15JC0hsjpFYZEKTqMEiLbR3aoSf7gsmE2ctkMkT2MdOsvXzCB94R4Ft2+cqW
 5ioQ/Td7XFACf/Qm5F0q0gMlJVRiq6SywkN/Or4rajCcIYVglZgH7DbleIlYullbFnPVaW3Rwy1
 jcjWmj33fjrXdTfzbStu37DgPUCya11iwUSsKBlxll8aJCkqJfs1LHp55BXBSwuJ1LzCb+ksGgf
 t6leUEiD5c9TDEFd3t3vFBiGbMKRURYZq9/tZj1GiBFQjxByp6vZaPF+GfS9lfGnLOd/d23aBVo
 s7uYfbTPiKrNIWCz6+BKnu8Yc2G3O+GdVKQBLF7yfUiQ8WJHeB4EObKDDjF9vMdaCfIzWfvzLhb
 +Xf0AN3sEujqvRCuksy0j3mOsovMVKN02dnRUZKY2FThwyK30CNO4oswjrrMrvedtnClBQdIVEt
 KA8qQ55UugtNEHf3WhLfyx0EToE8UHUhb/0+NZimKZELH+zKdm30TCpZzvkVKGad87Ly9Q07nBw
 J6XJ0ALY9WalGG2+pfNN0XNzIdkx6RAbaFqFUdP2TBAY9NKS3XIYZKawcoJJ
X-Received: by 2002:a05:600c:3b99:b0:4a0:1c10:1372 with SMTP id
 5b1f17b1804b1-4a1806501eamr112700085e9.27.1791458460508; 
 Thu, 08 Oct 2026 04:21:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d31767sm11218416f8f.51.2026.10.08.04.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 04:20:59 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 8 Oct 2026 11:20:58 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8a5349f66f5c1b52889c2f593e01c21824f937f0
X-Gerrit-Change-Number: 1986
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1986?usp=email>
X-Gerrit-Commit: 2053743b421fb08fd90ece583fc563b6ae2e03b9
In-Reply-To: <gerrit.1791458155000.I8a5349f66f5c1b52889c2f593e01c21824f937f0@gerrit.openvpn.net>
References: <gerrit.1791458155000.I8a5349f66f5c1b52889c2f593e01c21824f937f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNDU4MTU1MDAwLkk4YTUzNDlmNjZmNWMxYjUyODg5YzJmNTkzZTAxYzIxODI0ZjkzN2YwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4a9483768c99e3c71f84a39f65eb4f7da6df58c7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEmBP-0007NA-5h
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: config.h.cmake.in:
 Fix issues with string functions
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3838368892027959921=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3838368892027959921==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Pfogj0iaCk4="; charset=UTF-8

--Pfogj0iaCk4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1986?usp=3Demail

to look at the new patch set (#2)=2E

The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by R=C4=83z=
van Cojocaru

The change is no longer submittable: Code-Review and checks~C=
hecksSubmitRule are unsatisfied now=2E


Change subject: config=2Eh=2Ecmake=
=2Ein: Fix issues with string functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

config=2Eh=2Ecmake=2Ein: Fix issues with strin=
g functions

- Add missing HAVE_STRTOK_R
- Make HAVE_STRSEP a proper cmaked=
efine

Change-Id: I8a5349f66f5c1b52889c2f593e01c21824f937f0
Signed-off-by: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M config=2Eh=2Ecmake=2Ein
1=
 file changed, 4 insertions(+), 1 deletion(-)


  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/86/1986/2

diff --git a/config=2Eh=
=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein
index 6c8660c=2E=2E8c3088e 100644
-=
-- a/config=2Eh=2Ecmake=2Ein
+++ b/config=2Eh=2Ecmake=2Ein
@@ -268,7 +268,1=
0 @@
 #define HAVE_STRING_H 1
 
 /* Define to 1 if you have the `strsep' fu=
nction=2E */
-#undef HAVE_STRSEP
+#cmakedefine HAVE_STRSEP
+
+/* Define to =
1 if you have the `strtok_r' function=2E */
+#cmakedefine HAVE_STRTOK_R
 
 =
/* Define to 1 if you have the `syslog' function=2E */
 #cmakedefine HAVE_S=
YSLOG

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1986?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchse=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8a5349f6=
6f5c1b52889c2f593e01c21824f937f0
Gerrit-Change-Number: 1986
Gerrit-PatchSet=
: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Review=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--Pfogj0iaCk4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #2</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/198=
6?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><p>The change is =
no longer submittable: Code-Review and checks~ChecksSubmitRule are unsatisf=
ied now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">config=2Eh=2Ecmake=2Ein: Fix issues with string=
 functions<br><br>- Add missing HAVE_STRTOK_R<br>- Make HAVE_STRSEP a prope=
r cmakedefine<br><br>Change-Id: I8a5349f66f5c1b52889c2f593e01c21824f937f0<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<b=
r>M config=2Eh=2Ecmake=2Ein<br>1 file changed, 4 insertions(+), 1 deletion(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/86/1986/2</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/config=2Eh=2Ecmake=2Ein =
b/config=2Eh=2Ecmake=2Ein</span><br><span>index 6c8660c=2E=2E8c3088e 100644=
</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/config=
=2Eh=2Ecmake=2Ein</span><br><span>@@ -268,7 +268,10 @@</span><br><span> #de=
fine HAVE_STRING_H 1</span><br><span> </span><br><span> /* Define to 1 if y=
ou have the `strsep&#39; function=2E */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#undef HAVE_STRSEP</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#cmakedefine HAVE_STRSEP</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Define to 1 if you have the `strtok_r&#39; function=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_STRTOK_R</spa=
n><br><span> </span><br><span> /* Define to 1 if you have the `syslog&#39; =
function=2E */</span><br><span> #cmakedefine HAVE_SYSLOG</span><br></pre><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1986?=
usp=3Demail">change 1986</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1986?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchs=
et </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: I8a5349f66f5c1b52889c2f593e01c21824f937f0 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 1986 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerr=
it-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>

</body></html>
--Pfogj0iaCk4=--


--===============3838368892027959921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3838368892027959921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3838368892027959921==--

