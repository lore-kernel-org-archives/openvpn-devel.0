Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C383AC61DB9
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h7BSa9EMQkbN8o9oG1874KyQAYd2Dkzyf7km6asSht8=; b=a7OZXZ0u0s2sQqLW+plTUKsJXc
	te4X4ehntPJusJIlfdAO1HOhQ5cFptanVWoLrmudNIU3njfblesU3DwXyMKtrNu8FUvnbnegrd3ne
	o4BLwiQUdsxb1xuREQFh+xRE707IMhvc67yyQJ7grinUysw3TYhyAxnY75QBeYgOIp68=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wytKo-0006BL-Il;
	Tue, 25 Aug 2026 15:45:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wytKn-0006BE-Ft
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:45:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=X2JSAk48a2YmM58IKE2y118YT6eJ2tec/EYX9I+I1YE=; b=XLpbDviDRMoa3Cd2zwDUSsTO6o
 +5ams7Ywq7d1xg4k9J0ItAMTF1nuRnafgVVKbDPgYWsrtCPPkUElRsp1bfwuTz/UMrDhV1yiDaVmK
 Y9evHzWNDpchStbH+N24iNrR6v2KYM5wkl3Fg6JGsgQJGMI2JAMyMvpokPUWr8ceEgqQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=X2JSAk48a2YmM58IKE2y118YT6eJ2tec/EYX9I+I1YE=; b=j
 opMVpK7YZOJUJXKtrc/iJfvSc6dheE6e786hgpSZ8oEokNWy4r7z+Lx6YJfcZa7lhEBODxOINmHTZ
 QaOy71fRFU/Em6sPQEj/tJEEXRapsXWRbWBYtNbfQBlI/ylHYYJle3U4hsX+HJyV0YnhlwdWabbCE
 a++JvJen6WqOX+LU=;
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wytKk-0002Br-5U for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:45:10 +0000
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6a0de062db5so8663349a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787672699; x=1788277499; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X2JSAk48a2YmM58IKE2y118YT6eJ2tec/EYX9I+I1YE=;
 b=KzXHh3CjzQV7ZEG44rlYo67Kndha+RMCzRs/Hgi2vM6H7UEhnvLl16VkpPT3uXjNMC
 Xqf/mAYlgNHTf9N9Xq+01Kylb+mXQ8L0jlnkxLy6NouiHLHFe4upL7GIsInhQp3uwu0f
 ezEkV6j9aPzV32Uu82JDWYn6QShEijb7r95BiB5YnO2EURzTlHf45Z6pOedRyTcmd6E0
 mc+HfKvwBhwIKJGNj9Ocb3qGvAqZ8v/kmdI1VyO3MxQ79aeP3ay7U+jv0UGBOHYih/az
 UJh9NCeBQWX9rsLlNFLn0seX0DwH24shwd2Zts7T/VeDRpd3nnMbj6EL0dFcim2jVzQE
 smAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787672699; x=1788277499;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=X2JSAk48a2YmM58IKE2y118YT6eJ2tec/EYX9I+I1YE=;
 b=Jy8UcZj1t30FF9FN1GNlTH90I58nZ5vDveVzUNyZPo0BbIL+lA8wPdiYc9ZSGrE+k0
 Rv6gdBxP8hoJk2+FFJjOzTE+mvmgqkp0Mu49yuiDtJ4IKdBEx7YvtUnlOHufs1NWssUK
 Ttqo/vSjux5/rQkRJweJOAm6Bf7IlvsH0ikx9rXlYf8ZAI6Zt8K9VaYkEywxWXlBSBgK
 mG2WbWbqcsuNulFJyQDc0eXedaOImqWcWzn7j0qtCy4F4dtYDBHbDa3NcnH81QWVZfQu
 NfLi8oUMNXRhwhYpcJJdmKrlVApHiwKrfFNPoHw59YiSwse6FwxlQuy52VopFMBIcKv9
 OSBA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDEakSBeGVKdsyHkzXsDLwWfcGKCnsnkB0XMK0N1EiUfRZHgQRDF0OCzwZce8t9N9i62/3DDor5f4ZPzod@lists.sourceforge.net
X-Gm-Message-State: AFuF++lkGIpYCe0V7uY7p0hQfD18NmCP3U/NCGyD/b4TL/MJLIbjyE5U
 18hgoWduGtmPdWydYt0VwQwtHfgEbASaBIdEJqAcU+2rfOyyqVadnGhP2Vgr0LkFM1OOan402mV
 lB1bCko9RtnpkMc6mRyJHaS2MMxEies/cThjnOk/DDs/0xkzernRIFAyb/jyEmwM8SmVSCXQ9BL
 djWUUnZQ==
X-Gm-Gg: AR+sD11hDL2BUd5B1u/YUYVqjL8rjXA4OFOnP+lRs65r1/xX+EPH5R54sng04AE5LYa
 3Nzsq6ZA/uPieF1fMbAUhTfEXV/vzGPBcDIdI5Yt7u1ElxzOQ8+eLgtmdR+642M80hLDP1EqV/3
 53Ng9NYo8UvuSOavySwp2MhgceWCgSonM97Gm9Hei66stn3QmDECkzBz+71YUWxHMWpit9UaSeA
 zHkXx/PPRDkUPwa7lSm3LHi02aO/5CUvPwrP/VBNb+J7so/DHUhlKzvEoBM1RUYM2IxpMlbbA07
 TCOC5LxN0k9hxYMCaxASHds9NPfejnCnvDAaqteJxdxuZMJpDaIV3i+Gq7hpqvpw7T+d52eiRNl
 u/swD5/EPJZyvtzROZM3KguE01lAXzJ9lBRmWPUX72Yf8KYKAiC6BpoNPWg4OrDlMqcngfVq+C+
 crsP2EJGsp7a+RwpmAmr1I63IhtZ/fEW6vBkGyE2GHNhjR7H2Wrw92uviZCQNCIo4PxPKVwC4wH
 sRSmYOJwHU05Vc+QwyLXVJoRMsCzdBeNE4xlVrWjW+fEx0kvkZUuYBlXITHxPAuqmvW8WWuvGXt
 KYFUAUPUuso1U51X/dEjPcSak36Y0yBmKCiPtOZ69Vph7SF+nY2CuZLuMISH+g==
X-Received: by 2002:a17:907:94c9:b0:c1c:2173:d412 with SMTP id
 a640c23a62f3a-c24e5c8bfe3mr871667666b.1.1787672699416; 
 Tue, 25 Aug 2026 08:44:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b106dsm10334766b.43.2026.08.25.08.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 08:44:58 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 15:44:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
X-Gerrit-Change-Number: 1755
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1755?usp=email>
X-Gerrit-Commit: b60ab3c9f41d033dd44c5b0f70f23a0da11224a9
X-Gerrit-Comment-Date: Tue, 25 Aug 2026 15:44:56 +0000
In-Reply-To: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
References: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLkk2YzUxYmNkZGE1NjY2ZTBkYWIyYWRjZGFmZjI4NDA4YzliZmNiODQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <813020f22da183e99d86ef2949714fd0340cf0ed-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wytKk-0002Br-5U
Subject: [Openvpn-devel] [M] Change in openvpn[master]: t_client.sh.in: Add
 support for expected test failures
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
Content-Type: multipart/mixed; boundary="===============8230508942473507125=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8230508942473507125==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1IUtDsThIFs="; charset=UTF-8

--1IUtDsThIFs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1755?usp=3Demail )

Change subject: t_client=2Esh=2Ei=
n: Add support for expected test failures
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(2 comments)

File tests/t_clie=
nt=2Esh=2Ein:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755/comment/74400=
f0a_371645c7?usp=3Demail :
PS5, Line 379:     $RUN_SUDO "${openvpn}" $openv=
pn_conf >>$LOGDIR/$SUF:openvpn=2Elog &
> Should we make sure we don't also =
include these two synthetic lines in the grep input to prevent fal [=E2=80=
=A6]
I don't think that theoretical problem is worth complicating the code
=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755/comment/c34a1d82_afce4e95?=
usp=3Demail :
PS5, Line 389:             grep "$expect_fail" $LOGDIR/$SUF:o=
penvpn=2Elog >/dev/null
> If we're not allowing for regular expressions, do=
 we want this to be `grep -F`?
No, I think we do not want to limit this to =
-F



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c51bcdda5666e0=
dab2adcdaff28408c9bfcb844
Gerrit-Change-Number: 1755
Gerrit-PatchSet: 5
Ger=
rit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <=
razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Tue, 25 Aug 2026 15:44:56 +0000=

Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc=
 <razvanc@mailbox=2Eorg>

--1IUtDsThIFs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail">View Change</a></p><p>2 com=
ments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>File tests/t_client=2Esh=2Ein:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1755/comment/74400f0a_371645c7?usp=3Demail">Patch Set #5, Line 379:</a>=
 <code style=3D"font-family:monospace,monospace">    $RUN_SUDO &quot;${open=
vpn}&quot; $openvpn_conf &gt;&gt;$LOGDIR/$SUF:openvpn=2Elog &amp;</code></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">Should we make sure we don&#39;t also include these two synthe=
tic lines in the grep input to prevent fal [=E2=80=A6]</blockquote></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I d=
on&#39;t think that theoretical problem is worth complicating the code</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755/comment/c=
34a1d82_afce4e95?usp=3Demail">Patch Set #5, Line 389:</a> <code style=3D"fo=
nt-family:monospace,monospace">            grep &quot;$expect_fail&quot; $L=
OGDIR/$SUF:openvpn=2Elog &gt;/dev/null</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">If we&#39;re n=
ot allowing for regular expressions, do we want this to be `grep -F`?</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">No, I think we do not want to limit this to -F</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1755?usp=3Demail">change 1755</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1755?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1755 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none">=
 Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Tue, 25 Aug 2026 15:44:56 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvan=
c@mailbox=2Eorg&gt; </div>

</body></html>
--1IUtDsThIFs=--


--===============8230508942473507125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8230508942473507125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8230508942473507125==--

