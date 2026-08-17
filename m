Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63553C5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nbsHnsi36ZpupowJTlNaIYC+jjRp1L9Dc0Y2tiSSAns=; b=dhsTl0yUWoGb1O4cuUQaFTvP3m
	PxjL5it1dj98WKEVLQSSwm6ICZ5wHmAm5gfnu6QU2SvOSprklp7eeMUQ3PVCv9EgTp37F20arO6JC
	QKc+bQFX8VuQbZQo0OeXlJC8O0Q/vnMgwKtjAToxypTUMKzbZ8NA4V7klbJm5MKJhIh4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvy62-0003JK-M4;
	Mon, 17 Aug 2026 14:13:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvy61-0003J8-FA
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:13:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=eKckA1BTSGxPdrTh7DKzFIbp2lPymRdOanpfypV+rUs=; b=j48C3StozpREoJo61c+0Xj8frV
 E5b9SN9SmcH5lJerSvITVrhVZ3N5YDOU8TtUGW+1C7redbSTgB3/Yn9mjWkEdDrc3JwZ6F664zJfd
 mk9F5VwSACGrSn9CWg/l66wLzi82Dx/dnujeL/KmQGQ1wjEcS+Um4Rw+ISIkHcI2km2Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eKckA1BTSGxPdrTh7DKzFIbp2lPymRdOanpfypV+rUs=; b=f
 P53N723QA/T9JELoCYzbZFww6vMeubI7TA4iYwTBnvRj/RKsd5yL9wqLPy97HbcDmNwAIKrFS5DtC
 APMbtbfBb3dGd96sgJNNSPSdAenJrZYcsT7Ikg0FNUtLdSivhyJjfxvJYim6CaYJyBP1WcntLVbLt
 IibOSNkjGEBIRMYQ=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvy60-0002z6-LJ for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 14:13:50 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so32479405e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 07:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786976022; x=1787580822; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eKckA1BTSGxPdrTh7DKzFIbp2lPymRdOanpfypV+rUs=;
 b=NTT0lzqKDQFt6trdw/bIMZlhmgBqIrNd8udorcNcxGfy++Sv7oiU20ogHDnfwU6hPw
 WwoP0yI5ZZzFT1BfvPoitlwE4LLC8JFMzQ/Z4VbLiWNJrKGnHWO7wV+PBALoYvBJdBqu
 Pfw27J6dL/QK67ZzyZwZzPr2S1NNhztzEMlvkDQI6hS9DaOoObwAtm2/0aP4KycGfPi5
 +PsxVZ7XjZRXp/76pMuNg6FcVnGp3j0GdPA3IGAsMB8mSeqbotepbYwnvIGoCm3GS+rt
 SYpwuPN9mM9O+gAztsOwzXUOdMU8PATyt251tBj3y30lnEIlc1xNBUT3N+qMpM7ZEVfO
 cgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976022; x=1787580822;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eKckA1BTSGxPdrTh7DKzFIbp2lPymRdOanpfypV+rUs=;
 b=OqX8hvcOXDvY/8ZCRV8+G/JTwlFr/T6ktDpVYlNUtqcrdZfAFFE8b99TCjUiMaUzXL
 /yG0fHcWwlfCBH+6kxK9vndxrH2mCYgKVdxy120N3HCW5nNLTxvB/fZAIvJKze8XWBtv
 +slz7l8mnr8MXobg1XOj2pHpZwtYx5oN9QG9bltqPPzDTVBw+4mwlOoxNvmTDL/gCvMh
 BJ4mTdbDr8Lf0E6qfqlQHLSy9uhv65PR+nIi0PcvcGZfwb/BV+2xri4L7us65iC9uzBp
 CSMRpyGGLdBLSGgApqxke4/dbJKuYMWsQTNu79UMwWboVmr50AEbyQojRgN00N9lE4T/
 k/mg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0mazQX4MBRgmk0VM/fpb9h8PtgH/2k+AxKiZsxqR2H+5sl5+G/ffUldmTXKAQBgaNGNV4BYkP950TX5aK@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yygo+w21cfqOkxyENeSv+ecMfZQKEfwBj0NypjRr/0FKwk5LTRm
 s5jyhVcsfEWOuW7DauWa5prB/BvsqUmRNR8o2xu8rwGjQm1hJtSSn15wDZxc4Dl5EL1gjCAMEz0
 dZNlEw1ceIPHgcgEDFEjUp2X+VDYIHa0Kc0ckc5qLnyYnPG+1YuuoGsBycuFCF0BhU9JE
X-Gm-Gg: AR+sD13MeCNyBgWWYWCIxUjbRgSAndOlRESMU07XFnaDEqv5VrAWHgqAEt2kM3a06Za
 /ICbF063Qe+Lcjsle0+EQwdAJyZMZk1Ji4W6QIW0z+anIqXdb7OOMX0q42cOtyugFms0XwARHjU
 I8UDBfvFVjal/bFKTsipyDqKThz6ns2vxD6FeFwOJK4WS46nwwgHHa1pner+RzbXpi/eI1oS3rS
 bTt/hZE/nVCKrRFgKXjHwICKIcmR6EreB0aPmTJA3eN9JBSDBC+je7P+JOnajWnpWzdS017ESt9
 IdvLzHnGvYOgcRtEzruULVX8JuFpGsFg3hX1OhXGJc/ett0g7NEVsTK1MVGj7IEWT+4CoDBhAdF
 ffHLyy+OI9tHW3nDNWw2h5rwcUvSuVfTN+1hA/Y02echLcTMepgV1JosTtqsgshTPoS3xly0ppS
 anVFI82fGruKlcxqDva11rsr7yZfLMmnNH+d3qtqCpChFcoSndjm0bL9EO9s8mfyk1NACFrtd0R
 ha1yhODutw4kPG6PC+Gr9LPurPQ1uopj7CtPGo//4ge0MTcRmldbkwUR5jqBOaQ/wM12dOiCFZb
 v12zN1bu4KipLbeBfdnmOALxqc7+cYHjaTxvuDEUXJHtk8AQ1SQ=
X-Received: by 2002:a05:600c:4e0a:b0:499:737c:ce4c with SMTP id
 5b1f17b1804b1-49987948ae5mr425755675e9.6.1786976021993; 
 Mon, 17 Aug 2026 07:13:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998777caebsm279998125e9.0.2026.08.17.07.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 07:13:41 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 14:13:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
X-Gerrit-Change-Number: 1772
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1772?usp=email>
X-Gerrit-Commit: f2165dfdf57e6037d5a43a8b6226c98d088b5b4e
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 14:13:40 +0000
In-Reply-To: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
References: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2MTc2MjM3NGMxNDE2NjJkNTk2YmJmODhiNjRjYTdmNzQ3MmI1MTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <19bd133dd7d5219afb64dbc1f885748afebde466-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvy60-0002z6-LJ
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: options: Factor out
 options display code from options.c
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
Content-Type: multipart/mixed; boundary="===============0243521468849492558=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0243521468849492558==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OtoC+AfKXSU="; charset=UTF-8

--OtoC+AfKXSU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1772?usp=3Demail )

Change subject: options: Factor o=
ut options display code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(1 comment)

File src/openvpn/o=
ptions_show=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772/comment/c5=
27374f_5c6ef187?usp=3Demail :
PS2, Line 25: #endif
> It's not that we need =
anything from there, but my reasoning was that if we include the header her=
e w [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1772?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I61762374c141662d596bbf88b64ca7f7472b5149
Gerrit-Change-Number: 1772
Gerr=
it-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Mon, 17=
 Aug 2026 14:13:40 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comm=
ent-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>
Comment-In-Reply-To=
: razvanc <razvanc@mailbox=2Eorg>

--OtoC+AfKXSU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/options_show=2Ec:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1772/comment/c527374f_5c6ef187?usp=3Demail">Patch Set #2, Line 25:</=
a> <code style=3D"font-family:monospace,monospace">#endif</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">It&#39;s not that we need anything from there, but my reasoning was th=
at if we include the header here w [=E2=80=A6]</blockquote></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1772?usp=3Demail">change 1772</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1772?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn =
</div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5=
149 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1772 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display=
:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Mon, 17 Aug 2026 14:13:40 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body>=
</html>
--OtoC+AfKXSU=--


--===============0243521468849492558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0243521468849492558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0243521468849492558==--

