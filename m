Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF47C44536
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b5z0la7avTolIW4HuXLUaNWf/5FDLo1LYI+HE55ITNA=; b=Shtv8xZ90pZiPQh1rGjXR+WwXs
	6LAG7jyOPydcgOJcJuquHkgn5bCJV+zj/xtE0TfoBrKpeIpDrPLqU2ZjNc0TpdNzXKGUqkgF6atsr
	RoanZf7SXMP7OtagaXF0WZXlY/MK4NiEp9lITGjjGci7Ju71LTPu5ZqiSD1ogB8bSMJk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmYmw-0002FZ-Cm;
	Wed, 22 Jul 2026 15:23:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmYmu-0002FS-4C
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 15:23:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nS14HTfaYxbDE1oKX05Z4jLEOXEcHt/Xwp/uKHPSM4g=; b=ZVFkhe03asUWWJex6keUBU4fek
 Hp62Wz+ugj04YM5yDzl+AhsSCKA16KDRzXQHjxdUsRqYqihMX7TpIpUpkTvHU9MJrZX5LQ8DDaNOL
 xC/Y1l0BWirgAGeHQVJyPhV3+lN/ytYe86yKoQqUk5uukyX7NadTOxQ3BXReWyFqlyIk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nS14HTfaYxbDE1oKX05Z4jLEOXEcHt/Xwp/uKHPSM4g=; b=d
 sLtB6+y6plEgsRO8z88m6H4abpnRjRVTBBjAcqShoK0EMtYwjKjyRb11qoftxCjhXCA4mtCOHKqKS
 RNen5JRakOQ+/6A1cyhevrBcHRQcXnT/7ehv8vPXgy7tSEzPYZAhO9iMC75Lyosaendul3KZdETdZ
 TPUV5PkdMbs3/l7U=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmYmr-0004po-A6 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 15:23:12 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so36722825e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784733778; x=1785338578; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nS14HTfaYxbDE1oKX05Z4jLEOXEcHt/Xwp/uKHPSM4g=;
 b=JyZSe1ERXFPffMM7Z9IxCIgaPRdjTWeShgcDpif789ynMcN36q8hGhAGzBZJnm1kJ/
 XtXPGF218v8B2ffopTTPY/doo8G0Adv9jd2u9K62X5RoiTaeeSyR1y9tikmWuA7LDWJQ
 kOauHg9f/F22UxDKAl2LbfptxZQARMfqHTEKMA04lJowa+bLKRiuZCGcfIECGB8qucFv
 IXxmpVHKP4D2nyfFxDpvpyM7ow9I1Z1SUV+D+hN7eRByTWytFz3ukGBr5faC4h1Q2nwi
 iAJjkpJaZYz8NFLD9j0BvYcdn+ySxrDk+3cUNpK+T38pkT1JDtIUWM4oDW9Hux5om+Up
 2Z3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784733778; x=1785338578;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nS14HTfaYxbDE1oKX05Z4jLEOXEcHt/Xwp/uKHPSM4g=;
 b=YXKQhTjQHN5LD6ElQzXaVUcj96q+H8U7WCbEbMpIDrWxk/OrOZY1lr88+R/stXvknD
 LLtrmRhaH+DCwb57oyHrKEWAZC6q4tqvx0A4zcggcfoO1IahEE55rfdNW9H/nEdlMR52
 Q5CIyJPv2UeQOh+oiIuGJkGswESexfJDUJ8HjSi5cQRAyxzTl+Nm8aiw5KyRCqlKoKoa
 cnPVRPJWa/AywstUhLK1l83jJiXVoD5eO4p3ZplnCwer3i8JsgviNfe7Jwn0GxYILv+G
 B8d7nX1PsYOrECIUN9rOaH1ebirOj+u1w0ZMqTfpLsmV8P0WsL0XUA61CkllLee4q0of
 GmMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro84m0Q6lOMbAxc5d+SamNqdY92t2YpUXQzJmFwxp8epeBFXPIF7i/iyIHQEOIS4WPNlQGWYxIMrs44PxPR@lists.sourceforge.net
X-Gm-Message-State: AOJu0Ywvj4K+FNd55iSXydIDXugLAqSFaiOsE6CM+jW/EFCr6xyDyLHz
 GkMrPATQjBFt66yIEXTe1b0ZR+sAfWO+AvqPxO0oANIOLbIZTzDqMdiPm1hSCZcup00imPe1eyW
 +qYDECee5vosvzhKyndAXuoyZ+7SQUTeTaZRSBw916H/N6ykGE1Kn2L7hADtvoq3beLtFOOQ1mF
 aN28ou9w==
X-Gm-Gg: AR+sD1230TFSlH5vsVLTJxgZIa5sdRHQsmGa6ityAemcCPWZm44eGRlRJVr6qSsXReT
 sWLsJ6AfHkY6Na3cHDVhTKB30jn9YJZ6Tqr4qH79j667tyd2J5GRFJ8e2qZhyLszeNzAcysGlL4
 SxB7gJuduobxbGpaV6cWfJu6JoeqQybFwNJgettT0/cTD3qnPZTDSIMT3cjT4YBxgOhSdXIptiI
 4Z0QCahXF5RZaBwZ7Y7EcrxbNtKr/i3hiU9lHCTEgN8evMTWGFfnckBwaG3Yc0ECS6LizqD4Hp1
 T0UrWquoaz9rXcE2KJdZ99F4tMPSM1yHRU26Ppn7tM7iSZyBycbwVDKF8AVAhDBAx8jTOTkUIKV
 AP8uqiz9/QARvciTFJBacAyiUgeyKBSBQWRp7f/Vr0G4Zclqgk20uuM5No0ujgmLA1pUowOr1dF
 ypgZyAA7I0fcvUz9t/S2Jseu0EKcvmE8cjk3q9dXsJdw5n2msFdI+0GUTEIGW+EUdct5rcdBWdh
 Y/qwfi6/faDSShqdu1/kPr0N0nBrOnXdVjdMrSXxWERtBI99MJ+BfyI76lvl5P9Sjee
X-Received: by 2002:a05:600c:49aa:b0:495:5943:b76c with SMTP id
 5b1f17b1804b1-4955943b9dfmr127199325e9.34.1784733777622; 
 Wed, 22 Jul 2026 08:22:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c98ebsm141840935e9.13.2026.07.22.08.22.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 08:22:57 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 15:22:55 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a
X-Gerrit-Change-Number: 1801
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1801?usp=email>
X-Gerrit-Commit: e00d04feda433cd8d84584c85ab90f6f0cc6518a
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 15:22:55 +0000
In-Reply-To: <gerrit.1784724772000.Ic183f1f1f90561454b7b1128c95255368427cc4a@gerrit.openvpn.net>
References: <gerrit.1784724772000.Ic183f1f1f90561454b7b1128c95255368427cc4a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzI0NzcyMDAwLkljMTgzZjFmMWY5MDU2MTQ1NGI3YjExMjhjOTUyNTUzNjg0MjdjYzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <acfa86132d152189e0d66e8e2dc3e534a4822b0e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmYmr-0004po-A6
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make
 --x509-username-field work with Mbed TLS
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0422287273219890387=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0422287273219890387==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+1kag377sqk="; charset=UTF-8

--+1kag377sqk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1801?usp=3Demail )

Change subject: Make --x509-username-field work wi=
th Mbed TLS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 3: Code-Review+2

(3 comments)

Patchset:

PS3: 
LGTM


File src/=
openvpn/ssl_verify_mbedtls=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1801/comment/9e2b6e26_a24dfe50?usp=3Demail :
PS2, Line 245:             if =
(cn_index >=3D cn_len)
> Strictly speaking we can abort here if `>=3D cn_le=
n -1` since we always write 2 characters
Done


File tests/unit_tests/openv=
pn/test_ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801/comment/ba=
a6a772_cecadb27?usp=3Demail :
PS2, Line 844:     ret =3D backend_x509_get_u=
sername(username, sizeof(username), "serialNumber", cert);
> Probably shoul=
d add an additional test to exercise the length checks?
Done



-- 
To view=
, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: Ic183f1f1f90561454b7b1128c9525536=
8427cc4a
Gerrit-Change-Number: 1801
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <=
max@max-fillinger=2Enet>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 22 Jul 2026=
 15:22:55 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-R=
eply-To: flichtenheld <frank@lichtenheld=2Ecom>

--+1kag377sqk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 3:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1801?usp=3Demail">View Change</a></p><p>3 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801?tab=3Dcomments&am=
p;usp=3Demail">Patch Set #3:</a> </p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">LGTM</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/ssl_verify_mbedtls=2Ec:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1801/comment/9e2b6e26_a24dfe50?usp=3Demail">Patch Set =
#2, Line 245:</a> <code style=3D"font-family:monospace,monospace">         =
   if (cn_index &gt;=3D cn_len)</code></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Strictly speaking we =
can abort here if `&gt;=3D cn_len -1` since we always write 2 characters</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;">=
<p>File tests/unit_tests/openvpn/test_ssl=2Ec:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1801/comment/baa6a772_cecadb27?usp=3Demail">Patch Set #2, Line 844:</a> =
<code style=3D"font-family:monospace,monospace">    ret =3D backend_x509_ge=
t_username(username, sizeof(username), &quot;serialNumber&quot;, cert);</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">Probably should add an additional test to exercise the l=
ength checks?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801?usp=3Demail">ch=
ange 1801</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1801 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;=
max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 22 Jul 2026 15:22:55 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none=
"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=


</body></html>
--+1kag377sqk=--


--===============0422287273219890387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0422287273219890387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0422287273219890387==--

