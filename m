Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C48C79F89
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SEWEykhlatGuzDx5f5e8meXNOT/riznpL73/jsGHl1U=; b=PSx4VkriGus3w3tWX0AgP/9+ei
	xbGK4Yt3o328LiwjQB94SAxKAZGwjID1HjSqabB8CJxwi0CTmLF5VuRPE5+A5+/v8Jqj0SyK8NUUd
	hVtiSv/QEv/Uger5qcKAJrPp9FCOUoTCmZxufopvRcoYwjQHiRIpHx1+pmlwYCUrNI9E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3Zg4-00052V-PT;
	Mon, 07 Sep 2026 13:46:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3Zg3-00052O-C7
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 13:46:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CkgE14Pdw5BfzrgMMeCec/NmXc6ToxSU+7Q9N0jEvI8=; b=S7x6lvosyXaoJ6dthfFYDL9AiT
 s4jFlvTwzUcSK3QNE+eVe6qHeUiiKpAMBJuM4AHDsXrpTbsS8xMVCX7+rDltBtCK8vo+cMPmJQM4K
 keu6TYljtfaZZETaw1zImiwolcX7tWYWRfomAPjLqseEfTK+Xj7zKbvPptvXYr9u0ZmU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CkgE14Pdw5BfzrgMMeCec/NmXc6ToxSU+7Q9N0jEvI8=; b=U
 F//mbPxV44yauDnQkolF3N0/r0ENN7g6V4P1BClMnrCPVSvnOjnHOfSqubYk6pJKkeqvhJOcq3dkK
 c/dpem2sLfbofCSkE07UibCAtaaqWqsBBYOiNs2qeJ0yDwWHnx45wWnXUR3TlMmcEPvRRknA6BIJR
 NIfI02VwpmSPO5wg=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3Zg2-00062f-6O for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 13:46:27 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49d0d2d37ceso8189835e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788788779; x=1789393579; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CkgE14Pdw5BfzrgMMeCec/NmXc6ToxSU+7Q9N0jEvI8=;
 b=NPaBVMCkkIPNwDqttl0lvgt6bPxqrq7fkBgcnBkGbSyeTL8nvQ5hfsJGgMHVeW2XGv
 pQ6zomwHw1rhAh1vHKy74YcSoT0/ABC/7d1HFtY3+4EhoPhkZr6uLPWzi7KK/0DL/ESD
 TfmmChpm7I8D3ddfxY+Tp4FMKe7oZHBpyJtk3SbVTu12s79zsVlBH7i2mgO9e3+arYLn
 khnkl0RuT24Nx1DcfPJXA7idxerXqGs67tvm/oPxgRs24pq9uKZpKezMAIN6w1raEcNG
 YfyB4t3mX/zdfU4qY6/jZAWT2eIvaqKZyJcbpAQ7A/fUTScURBS9Cooz1s/psnbIOgzi
 fjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788788779; x=1789393579;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CkgE14Pdw5BfzrgMMeCec/NmXc6ToxSU+7Q9N0jEvI8=;
 b=j9Q7oRnZ1AcaB/3JX8QNxIaC7P2RvXscLoNXmvl3heHDd+BBD+G9+C5Y1ba4njVmOM
 vUN35Q42sfmBFGIslMNB998Bm2dLf972XvcwDkT0jOqtoPPTDB8OL0YsA69w/xxTUQo6
 1Ip5iMzHwXK6+ePfVBQSHEA6GJB0KUQUQhn0gOftnJCB199GAp6rL70b+vE1UWsxbn7C
 GyTybVLszohGqmLf+7N7LO6121PZPO//RkU/8FIGDJ6hBl6kkhrd9O7LD54SHg6x3Ob+
 NsdNycMi+QCiC30ediHPnGCjj08o3iMTOYJD1KC+IbnJpMqS3ur8eiRmoLdeZQBUGdgD
 UsHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLfL55LWpC7p1ET5zhU8PaFs7Rkq1E3G8TQwrwMHzERWzasochrOF02TIUWIn2W6t+IZ9LLl3HmzXWDc2o@lists.sourceforge.net
X-Gm-Message-State: AFuF++kvwV022yo73Nu58V5N/mHlEWaE353IFCHmTXotz3Cih9T7E7r3
 EAa5oJLWmCSBWxuyHKW/KrRkbYrpdmezgIW/O+gUfdsrdwn/DQqDAltMXAl01dCiJf8YVbbG7dH
 ur7HL3V5CIeKMCWU9U3/YOLEhla4Wd0OigufoMSQVgwJgAX8gHRr6mhT0QS5/SQegTAzs
X-Gm-Gg: AYBFou1Xs99J8te91mXK+9+zUjxgQAMMQwuYFfMmi7tumi8uiPmgi8qDJVwydirDpnN
 GNQlgYuo234uiST/h6aZI2XYqpGxoHw/4iJodlIribIEry/T7cacL8+RXSNK/6Buayri6r3gca6
 4PYpnYoHIIik0GOVPy/yIPdoQbFNXd7k7hiI7/oZZV/U+MrkN+s/tCrY9L1WCWjrIx3jZ6mW5oW
 s3VCnYVzUjJK3dIIwzcjjUeBplvaSONyqOdNgoKl/UldUUV+2Bx5qp1ngPJZ70KpUYhTQ6DfAho
 yxB2iY8upNZtBUV2bEx+5wAmFOr/jskeddiBqHGzzDONRhGYCzEt1WySbYd0KcPT+46CfdwapIf
 fZ6WHaR+tkIaOyWUzFUm9+DbmgeMd29B8zArAnpLCgu+BJkQakVXRsfkjBw3fxKsilK0TMSmSwX
 aMFiPBFWsslYg8t80HqUC1sHP+JIIr1wjEUXXMt3GtReVTkOhKbpYVsa8fYbH3nsduSMKxHdwLL
 qdkiVR3tAQuFas3HfqqSRwC0vZBRdc96ehkpLS+XeC4jiu7vrfEGfJwUMOSic4qzc5gmIPQDON7
 /9KYZTYggL+BxpUSED4HiplHfFJhxu8JKH3agyhu3totDeJtXTk=
X-Received: by 2002:a05:600c:3e0a:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-49cf8267a36mr298848975e9.12.1788788779379; 
 Mon, 07 Sep 2026 06:46:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588394fa1sm27573923f8f.8.2026.09.07.06.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:46:19 -0700 (PDT)
X-Google-Original-From: "syzzer (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 13:46:17 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
X-Gerrit-Change-Number: 1902
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1902?usp=email>
X-Gerrit-Commit: efb1f77d28be164260bf4235949ee81f9aff5124
X-Gerrit-Comment-Date: Mon, 7 Sep 2026 13:46:17 +0000
In-Reply-To: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
References: <gerrit.1788781350000.Iea1481e94ba1abe18c39d81cd797187c88427571@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzgxMzUwMDAwLkllYTE0ODFlOTRiYTFhYmUxOGMzOWQ4MWNkNzk3MTg3Yzg4NDI3NTcxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <157e0920bf6675214eb50a1d651503a2d15c6a73-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3Zg2-00062f-6O
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.7]: Check for
 null-bytes in certificate subjects
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
From: "syzzer \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "syzzer \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9170209461713873956=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9170209461713873956==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="enTQtfY/UAE="; charset=UTF-8

--enTQtfY/UAE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, plaisthos=2E

syzzer has posted=
 comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1902?usp=3Demail )

Change subject: Check for null-bytes in certificat=
e subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1:

(1 comment)

File src/openvpn/ssl_verify_openssl=2Ec:

http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902/comment/f93e7c60_473c2dec?usp=3Dem=
ail :
PS1, Line 389:                            | ASN1_STRFLGS_ESC_CTRL);
>=
 I did the same thing in the master branch=2E [=E2=80=A6]
Hmm, but that sti=
ll changes user-visible behavior, since we now no longer escape all the oth=
er control characters=2E Maybe we need two print_ex calls: one to check for=
 null-bytes and one for actually printing the subject=2E

For master I seem=
 to have missed there are two closely related escape names: ASN1_STRFLGS_RF=
C2253 and ASN1_STRFLGS_ESC_2253=2E I thought you used the RFC2253 one, whic=
h also includes ESC_CTRL=2E=2E=2E Which makes me wonder, shouldn't we use t=
he RFC2253 one for the actual printing (and also have one extra just for ch=
ecking for nul-bytes)?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1902?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-=
Change-Id: Iea1481e94ba1abe18c39d81cd797187c88427571
Gerrit-Change-Number: =
1902
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit=
-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: syzzer <=
steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: MaxF <max@max-fillinger=2Enet>
Gerrit-Comment-Date: Mon, 07 Se=
p 2026 13:46:17 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment=
-In-Reply-To: syzzer <steffan@karger=2Eme>
Comment-In-Reply-To: MaxF <max@m=
ax-fillinger=2Enet>

--enTQtfY/UAE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/ssl_verify_openssl=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1902/comment/f93e7c60_473c2dec?usp=3Demail">Patch Set #1, Line =
389:</a> <code style=3D"font-family:monospace,monospace">                  =
         | ASN1_STRFLGS_ESC_CTRL);</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I did the same thi=
ng in the master branch=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Hmm, but that still=
 changes user-visible behavior, since we now no longer escape all the other=
 control characters=2E Maybe we need two print_ex calls: one to check for n=
ull-bytes and one for actually printing the subject=2E</p><p class=3D"block=
s" style=3D"white-space: pre-wrap; word-wrap: break-word;">For master I see=
m to have missed there are two closely related escape names: ASN1_STRFLGS_R=
FC2253 and ASN1_STRFLGS_ESC_2253=2E I thought you used the RFC2253 one, whi=
ch also includes ESC_CTRL=2E=2E=2E Which makes me wonder, shouldn&#39;t we =
use the RFC2253 one for the actual printing (and also have one extra just f=
or checking for nul-bytes)?</p></li></ul></li></ul><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demail">change 190=
2</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1902?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: release/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Change-I=
d: Iea1481e94ba1abe18c39d81cd797187c88427571 </div>
<div style=3D"display:n=
one"> Gerrit-Change-Number: 1902 </div>
<div style=3D"display:none"> Gerrit=
-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max=
@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: syzzer &lt;steffan@karger=2Eme&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Comment-Date: Mon, 07 Sep 2026 13:46:17 +0000 <=
/div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div styl=
e=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none=
"> Comment-In-Reply-To: syzzer &lt;steffan@karger=2Eme&gt; </div>
<div styl=
e=3D"display:none"> Comment-In-Reply-To: MaxF &lt;max@max-fillinger=2Enet&g=
t; </div>

</body></html>
--enTQtfY/UAE=--


--===============9170209461713873956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9170209461713873956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9170209461713873956==--

