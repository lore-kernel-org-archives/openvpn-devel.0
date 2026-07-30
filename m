Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B72C5516D
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 18:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SgvP5D4g2+WP56w8iErLJ9enW/DQIzZxcRmRQfk35Pg=; b=BC51OgH9Nmuxanh3GAEsj0EmVw
	Ci6pJtvVaQ449/2fHo3o8MiPFRUezkCw8sxDGp54HCQMoAht4TK9eGOKnqxJySwzpmHBpohNM44t5
	KfeG60x+MKJ6HWet+0797LCeqNEORbXQ8z40KrAhaZFXSmG6qUwDc2vOgF/ukFrI5GBc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpVQD-0000Js-Ub;
	Thu, 30 Jul 2026 18:23:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpVQD-0000Jj-Ba
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 18:23:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Rm6wEJonp20vaBsD3xJeZW56zqkQAmUaiRdrYujq1y0=; b=dZDg/yOMdJb3PxHE6jGnAr9f0e
 sfUWpWaeviU7Y4b4/MLengoSYp+nBif4I2I1hX2XUwt1KstH31ihqO3muXmeErQt2ZxKRLPFtQhbd
 Zy5FQwWSp+O4GU8p4xPlTmDF+Nw5Jh+ozddfQ7BbZpem8AXiMotStIr77utqEdR7bB5M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Rm6wEJonp20vaBsD3xJeZW56zqkQAmUaiRdrYujq1y0=; b=c
 0bha+ah93Hi3clJVxHcV0rfMxTVv+g/D59pGwDhPnVvy19FPqaTFc93UmU5g/i99fccvS/SUN5GOS
 P0m4xKW2RcZ7t2ppK0vCe5IzL62wgA4rBE+Q+IHoTmNjOBC9ERTsPnTM2SeWun2sotKd2vQcLYt0Z
 d3HRlHUahOB4yU2Q=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpVQ9-0003TD-MP for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 18:23:54 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47f97d310caso5320f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 11:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785435827; x=1786040627; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Rm6wEJonp20vaBsD3xJeZW56zqkQAmUaiRdrYujq1y0=;
 b=O01qdOKWVcpczJX0mm9qI8hwkkt8GNiqHAZsyUBmYppSxTeX0gsCCEWaMkpcscBplU
 s2rQ1bGBoPzAz0znt+CjCQ/HTGz4jEa2RjsYP4GoTDkCQbznDfTRdnELxPiXos2lKLdr
 imdIaXRl/7W0AsRhY+Wo66NHc5RBzts9cFU60fiqlCcyDQvs3PageIDJNrLKcYulcH00
 iCWDJtnch52owL34Osc04nriFa420RCU+nn0x6r+nFgpOiOSCDpmgni9KLQNhdOc9Hvu
 PhLre8gGX+eK4lAMSqfKtgsW6QWRVK9MHaXgnsFyyUg81ufXKQz1cZmrAvb/Q0Jt1Wot
 rXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785435827; x=1786040627;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Rm6wEJonp20vaBsD3xJeZW56zqkQAmUaiRdrYujq1y0=;
 b=p9EfKtqzMhK+Qh4kFwthuY4Hk+XGKoS8QcRxiTa35c7Ad3j2p3GCpQOGcfcCZxKkfb
 8umvOHqVTjIE8UaysI6mFG9tHvX8M1B9EvPsL+ZJh9kTsv55wAGskA5I4OlN9tdVX933
 KmKpAhe6JM6UIHKo2L2nALC/SDs7+l66tm8khlJUauWyAk5DyjF/Zi4dq5oECTYx2yyA
 o09OYmeIeOyO9VTtwsonN0TmxCslAie65vhBP01vbaVJqaESRn/6iUsIDCmFKNimLx88
 3Q1TII8FL0peOMVyuMsgUucnqb+fJ6UKo6tW8LQueYUT/Gn2RDfv/gPaB/AEPSx5/L7+
 LWAg==
X-Gm-Message-State: AOJu0YwhLdUl9HLGRlaE+0z616qWbfK30NN5VsLB2rB43Fj3VrxDlGJo
 Z1H/KeZb6fy0TT9p8xDewTCPgsQZPLMw1jj4LLy3+7De0WQF10eAijYA/Ib3Uq5+VwMy/v0FOOF
 LJqhDPqMwp61zVJeO+JxTmGSWJAkUkzivDce//e4Sp8GtSmcyDhUuTILFYiuz3Phg+13piJMoU8
 wtVbxyhA==
X-Gm-Gg: AR+sD12SbODyila/eiAJpEO0f/lms+aWngfW4CCnZxo9ivh6ObNEPXY4YoiAAy5pzIK
 y1Va8Nf3UmyovudVI2s/zvn8bPf4vQu29Je2DLMX7X6EiiQI06f+4vu/RiIeEUFg3NKNRi5b9W4
 30esXQRicNISEuar5uCQFEAcrWhcXD2r7B2DMziAAbjzowcpo51fG2yyGwtvhIWbbsK0/DNGjwo
 EPr3SPl9musdlbVjpetxCtJg4MFwqMAT7uU5cV+lYs7NHhZ9Nmx/SoGL8U4fhtpg1yKe1fVE2o1
 Ugb/ePU+qjnxs3ikbSAqTIAsFZ4BvuskF2IAfD8sm/Vg4KlgzUJagfZvwpQLUmIIJ2W087CZ/sR
 XPrUGDpNssYlaT1eVIlkeId3BJNPGv76fVWarFrYIOx4Y6fxVdPP7vNyoPIcgiECJNcrF8NsDfI
 +Ddv2dE67giqulNoNcWIAe0NbsZymRG4iLSryc0F/Dx9WTvgN83657vzWN1lhhYfd4sZMT4gpHf
 4NL7AUYw7icLYYWxhdI8DvHk7vQ0lI/GITGGVZUjq28I4Z58ldFSpZ+O0uNrlB4UI3SyZ390YaZ
 lyqnwSGCu3INpWBmaLj0ZW9qGLqIMc8LOK1bQfjpISZEf/30Vb9hHWm1zNHnAQ==
X-Received: by 2002:a05:600c:c4ab:b0:495:4730:15b2 with SMTP id
 5b1f17b1804b1-49800eb3d94mr53945935e9.31.1785435827058; 
 Thu, 30 Jul 2026 11:23:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc8935d83sm7864461f8f.30.2026.07.30.11.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:23:46 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 18:23:45 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 30
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: 3ab3f07018aedd02f1455770efa617090fc004cf
X-Gerrit-Comment-Date: Thu, 30 Jul 2026 18:23:45 +0000
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <45a728f186118971babe033775912a415833e6c4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpVQ9-0003TD-MP
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Use OpenSSL's
 SIPHASH implementation to double check our implementation
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
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4344579062079425623=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4344579062079425623==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7zNF1HjOYtk="; charset=UTF-8

--7zNF1HjOYtk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/31?usp=3Demail )

Change subject: Use OpenSSL's SIPHASH implement=
ation to double check our implementation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 30: Code-Review+2

(4 comments)

Fi=
le CMakeLists=2Etxt:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/=
9105e2b1_f784d6bb?usp=3Demail :
PS28, Line 801:     target_compile_definiti=
ons(test_crypto PRIVATE PREFER_OPENSSL_SIPHASH)
> Does this still do anythi=
ng?
Done


File tests/unit_tests/openvpn/Makefile=2Eam:

http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/31/comment/13bc8e15_e9fb0f81?usp=3Demail :
PS28, Li=
ne 102: 	-DPREFER_OPENSSL_SIPHASH \
> Does this still do anything?
Done


F=
ile tests/unit_tests/openvpn/siphash_openssl=2Eh:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/31/comment/c2a5f74c_9ec317f0?usp=3Demail :
PS28, Line 2:=
  * SipHash reference C implementation
> Wrong copyright header
Done


File=
 tests/unit_tests/openvpn/siphash_openssl=2Ec:

http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/31/comment/e652f08a_7890d92e?usp=3Demail :
PS28, Line 35:  *=
 implementation, so we only use for unit testing that our impelmentation
> =
"use it" [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/31?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
Gerrit-Change-Number: 31
Ger=
rit-PatchSet: 30
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 30 Jul 2026 18:23:45 +00=
00
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flic=
htenheld <frank@lichtenheld=2Ecom>

--7zNF1HjOYtk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 30:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/31?usp=3Demail">View Change</a></p><p>4 comments:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File CMakeLists=2Etxt:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment=
/9105e2b1_f784d6bb?usp=3Demail">Patch Set #28, Line 801:</a> <code style=3D=
"font-family:monospace,monospace">    target_compile_definitions(test_crypt=
o PRIVATE PREFER_OPENSSL_SIPHASH)</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Does this still do =
anything?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; p=
adding: 0;"><p>File tests/unit_tests/openvpn/Makefile=2Eam:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/31/comment/13bc8e15_e9fb0f81?usp=3Demail">Patch Set #28, Line=
 102:</a> <code style=3D"font-family:monospace,monospace">	-DPREFER_OPENSSL=
_SIPHASH \</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">Does this still do anything?</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tes=
ts/unit_tests/openvpn/siphash_openssl=2Eh:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/=
comment/c2a5f74c_9ec317f0?usp=3Demail">Patch Set #28, Line 2:</a> <code sty=
le=3D"font-family:monospace,monospace"> * SipHash reference C implementatio=
n</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">Wrong copyright header</blockquote></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/o=
penvpn/siphash_openssl=2Ec:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/e652f08=
a_7890d92e?usp=3Demail">Patch Set #28, Line 35:</a> <code style=3D"font-fam=
ily:monospace,monospace"> * implementation, so we only use for unit testing=
 that our impelmentation</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;use it&quot; [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail">change 31</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail"/><me=
ta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"d=
isplay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I09aa27caa1=
a3aab0d1be6118b26d54a1c1bf7aa0 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 31 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 30 </=
div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-=
Date: Thu, 30 Jul 2026 18:23:45 +0000 </div>
<div style=3D"display:none"> G=
errit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--7zNF1HjOYtk=--


--===============4344579062079425623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4344579062079425623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4344579062079425623==--

