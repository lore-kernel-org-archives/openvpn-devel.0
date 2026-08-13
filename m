Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E77C5CFEB
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ynK4AXLu53AvfjLS1vmZPqPMs7suVzn5VkxEsRvm/3E=; b=HP6N/vNg/ir4sEs+U0KYaQZIGr
	kNTEi6Xf0380wjQJtSReUUcHAHl+gZmTxTvNp6FhauDhpaU7dvrWDmykLk7uMzrcZHzUWXn3Cu/wU
	tlZR+5S7HlKbNbKl9lr4BwW+uxtlPCOgxXrig40Ty6IlPeRXz9zrGTOvOV+YQl8rxUO8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuSqc-0004S5-FG;
	Thu, 13 Aug 2026 10:39:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuSqb-0004Rx-Bs
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 10:39:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3rVvcs5zX0asBV1Ilg8VuJWIXoSaGeP+ocPmsyzJ2Ic=; b=ODOiereaxJV+emRw7D42Gnbo+p
 JEnAGzeHbaApGJZ/rAM7Sr1LVfBtuQFU6pIjxtJ5KApPBu6SQJzOLDn882hIaPMSJTkcDePFRIU1n
 W2mdEI3hN+0oGv/zFLoFZw2Nf1MdBieI3h7fL+7SCjxp4Vm1llCCEOD/IMUdbb/4tF60=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3rVvcs5zX0asBV1Ilg8VuJWIXoSaGeP+ocPmsyzJ2Ic=; b=N
 3wk1PqydLBitOkIYo3GqouQuHTQzWZzrKjyTyllDUuoLzdoSp1V9OJRt97BQEmkMu0R7BCREKw76z
 AKmlnxkrDI61aVV5tIov8XphQZ1UkhfXF03R43Fzobt4hhXK6VnaL92UfLNxRSvtnwywXMsYz7ZnV
 W77JYWA+R96UJiXI=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuSqZ-0003WW-7w for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 10:39:41 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so1327067f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 03:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786617573; x=1787222373; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3rVvcs5zX0asBV1Ilg8VuJWIXoSaGeP+ocPmsyzJ2Ic=;
 b=ED45O2raUlEda9H9o2QRqLfKYw1UmzQstR13TXKIvuxAfbgKgfnrX/4Eqae4VPhRHn
 s+HZu6J3KPmjJncli+aGpVpRo/MF33YbXYCw8UY/akpIu1PzJQ4uYbkUIzhER38rMWR4
 9Wpv82Zb8t1laoKTQs/EeIZ5e7Sh0dLgZmIlfJOnJR107gCsB4QkJ6t1d1QoCzKOoxPM
 HYXFZ6DfSZS+wVi7rVNRQs+wSgdlq15JGfk2f/I7A3ACKUV2WH7U0CINNiaa45lkj38n
 xUCTN+SaRA/sDhWTOrEO4XFDNGbJcV/+DTX1JDdEqqbkNg2vRxIkh++6UvKvUsLKbwBM
 AShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786617573; x=1787222373;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3rVvcs5zX0asBV1Ilg8VuJWIXoSaGeP+ocPmsyzJ2Ic=;
 b=MfFMrPwqc0r+wjrwE6RM4lOjwHDlfHFNVJa+5dk6/lXqLeqYlmTscCzLTRln1AcMVk
 vVJN/ehaBSmsdJtx3mJrwhlp0IW41xXEH2HSDEYF53mRez/1EKGVLCP7zDPPrxl+KXOT
 grBY00soEsDPnRMhKA3GBQTv8+fX/XtcUtOnAKMmZ0/5fVCwMl+TKs9fvPvxZmr7UoX9
 AA5CH0dcCr2fknCCEsigc/IUxIRzdgRFSoqPFD+w6Y1nIYVrwt8JB5eowld2c+gAlTas
 D+4iGIqO/+VHYKKQP9y4gWQvTDeo/oITgnOlyfKjzZyTa9+0++ZLf466B/COuOL/W+3w
 3/kA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9D9+466q44GHwJHHDIu1aCOge9dulA1GNx9iZiwwhFLwEqS+7OfkmfJek74sljAQW5AX8+muJs/ikZPEX@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwC7kIueaIQfF35wQwB9h3E0p+Uzj9ZqFSrHuddcQPDXd3u1Zp3
 J/dIRAnUHMqDUVGeae0O0puEgC/39so3Jx/QclVAjCLxPTXfSbp+dFOpcAf2UhvE1otSpheeyG6
 jDvfzljRhyIIHdyogfWqxYM5QMtRYMcY3PfW9jttmMT+VIa3A2+QrgEsappehSj4+wj/fWzsmS9
 pj3Qusmg==
X-Gm-Gg: AR+sD12SRWmc1txYUB6W3oEk0t9TJ7xtz96aqrDJYOVaZMXgde52gmhfzw+oCDIhDaf
 +kJSz+9kMHxsj0OF22zxe9Hak7VnQ05zXzPxVTYX4cphhgOo8FIyYOLYJj0DjD3st5bmXvTDrEl
 biTjXU6tsLo2vGtlBsUPM3kPu1A16HTvQqdm0E2V7O4/XGvxy2BOwOwF/NNyIK2LgYAXB5rY/PW
 HvOxCnNN8Zf9BthiorKTE2VsYi2k78R5mKIHcQSQXiZDr4uqlM8X2N6UyTRm+fw03O0BckdrQ8l
 E06hTAmkiTYhPTLiAWueW8onVi7hLguAKYqudklM++EEBa142H0U0jV2riEW3OAoHE2vM8ShHLg
 n0Y/aGu1zbuDLHKtXXw24RBwxv6ZeGVTE29g+YKB/xfoYvhSrno6NAfhXemG6eSFQsG/a/FH1p8
 dYqdcjR8GwN5APgaSQKyDrp4/nSjeWbbs6xPnAZ3+dkuMjmD3vNlbtCOX0t5odXxlHez0f6s013
 xg+ENWrGF7pzXr9JOsAjHSlzHyEX0pQc2kUa0XtFVzoq3zI/1/MtFBpZHWVpTGdrv2uZgIergGO
 hu4r5ThvryaKuO1raG7G0TIF6QWLuoOhOYsRTP7Vy6kwn4Ffu5c=
X-Received: by 2002:a05:6000:41ef:b0:47f:f4b9:88b7 with SMTP id
 ffacd0b85a97d-48159ed6c45mr6828161f8f.1.1786617572462; 
 Thu, 13 Aug 2026 03:39:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5af453sm5849229f8f.23.2026.08.13.03.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 03:39:32 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 10:39:30 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If458a3362e03630ce699bd122e957169601657a5
X-Gerrit-Change-Number: 1833
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1833?usp=email>
X-Gerrit-Commit: 1a3b086e44f9eae781d82779dfbcc2952c9e5207
X-Gerrit-Comment-Date: Thu, 13 Aug 2026 10:39:30 +0000
In-Reply-To: <gerrit.1785762169000.If458a3362e03630ce699bd122e957169601657a5@gerrit.openvpn.net>
References: <gerrit.1785762169000.If458a3362e03630ce699bd122e957169601657a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NzYyMTY5MDAwLklmNDU4YTMzNjJlMDM2MzBjZTY5OWJkMTIyZTk1NzE2OTYwMTY1N2E1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6b9f7d6374e35d09dd6fcd31f81573cbb0803506-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuSqZ-0003WW-7w
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Replace
 ASSERT(rand_bytes(...)) with prng_bytes
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2786764993759664116=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2786764993759664116==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tpkAYsa7gBc="; charset=UTF-8

--tpkAYsa7gBc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2=2E

plaisthos has posted commen=
ts on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1833?usp=3Demail )

Change subject: Replace ASSERT(rand_bytes(=2E=2E=2E)=
) with prng_bytes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 1:

(1 comment)

Patchset:

PS1: 
> In general, I think thi=
s is a good change=2E  It's incomplete, though, "git grep" says=2E=2E=2E [=
=E2=80=A6]
The first one is prng_bytes itself:

void
prng_bytes(uint8_t *ou=
tput, int len)
{
    ASSERT(rand_bytes(output, len));
}

The second one is =
something we could do but https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827 w=
ill then conflict since it completely removes the session_id_hmac_init meth=
od=2E I can do that if required but it might be worth the conflict=2E Or we=
 merge 1827 first, then this one does not matter anyone because it is alrea=
dy gone=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1833?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comme=
nt
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If458a33=
62e03630ce699bd122e957169601657a5
Gerrit-Change-Number: 1833
Gerrit-PatchSe=
t: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date:=
 Thu, 13 Aug 2026 10:39:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels:=
 No
Comment-In-Reply-To: cron2 <gert@greenie=2Emuc=2Ede>

--tpkAYsa7gBc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1833?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1833?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">In general, I think this is a g=
ood change=2E  It&#39;s incomplete, though, &quot;git grep&quot; says=2E=2E=
=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">The first one is prng_bytes itself:</p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">void<br>prng_bytes(uint8_t *output, int len)<br>{<br>    ASSERT(=
rand_bytes(output, len));<br>}</pre><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">The second one is something we could d=
o but https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827 will then conflict si=
nce it completely removes the session_id_hmac_init method=2E I can do that =
if required but it might be worth the conflict=2E Or we merge 1827 first, t=
hen this one does not matter anyone because it is already gone=2E</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1833?usp=3Demail">change 1833</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1833?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: If458a3362e03630ce699bd122e95716960165=
7a5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1833 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=
=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 13 =
Aug 2026 10:39:30 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComme=
nts: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<=
div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>

</body></html>
--tpkAYsa7gBc=--


--===============2786764993759664116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2786764993759664116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2786764993759664116==--

