Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3D8C5B572
	for <openvpn-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ib3JC5sEONSXaR+wgeIusoVIprDZkBWUbO3b9GGaAN0=; b=IsSEoZjndc4Jfdb8bekuY8ErTI
	lFEpODl8bepcHQw3Uy2/4CiSVOjcNkq2WjxFRO2BDKYG00H9EjfGo/mK0uruasixq6icHkMBV+vGr
	gNxLJAxXQ85IquJ+5qpEyvmrWFySY5RhT4+vztlsVXDX/u19Sb0SXEeo4eoVWI3gvMhM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtpKl-0000s6-Fv;
	Tue, 11 Aug 2026 16:28:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtpKk-0000s0-OG
 for openvpn-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 16:28:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6LbZdVyqTDBN0A5hJIceewiIafM7gR8VpM4MK5SnNC8=; b=hoy4VRTBwjk8+2Ae7jTdPxDa5u
 lV+xHpAOa/tpb7IGJ21W9F3a3ax9cdNA7qqU9WqUrQw3UButKQTuNw+lzH70mGRuBlr9uLrNNKuOJ
 7Gl++ioIpHD6m2c+8pyuQ/hkjgsr+NLdN1hXFUOAR9qUR4eYVkKgJSBBMTtN0f97JE38=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6LbZdVyqTDBN0A5hJIceewiIafM7gR8VpM4MK5SnNC8=; b=X
 Bm7SnKpOpGhAD4NqqiVOPvYFiPHOuJBS4POAqrFAM+mjsADDH+LUars1UhZbbeZ2qulTfL1zGCd+f
 Fjwp/3HlMia2KpcdZNMt+N6DQt15hGqjryCBGZrV35fKElFyZNIQggzq11ceUdhFZ1alCzrs9iZjX
 0Ot8TMDk46TWDZvM=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtpKk-0005qm-Vf for openvpn-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 16:28:11 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so7818475e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 11 Aug 2026 09:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786465681; x=1787070481; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6LbZdVyqTDBN0A5hJIceewiIafM7gR8VpM4MK5SnNC8=;
 b=LWT6utNZJy05uqLjI34Y4Tc8CFfpHghvmXgG5pAn1vfEWOtFioofFGkqi7/5YJaImG
 XDxsm8X1UX3icXvLr68hg915NRhHsf3x5N2KE0aA7ang3sBJ/sNIllGAVLFiU1MHBkZY
 +5MRTOOnVqBBDZreDQdrvVABx19AkPaLik9LVop6ucWUhKqdU8c/+uDoqdqcUPv32Sg+
 ggXS1wOZVOSMQJGNesavH8l1T/iDPbokFr6F7B6IxYuL7MMeCTIMWTfOVvbfnwtOl7kC
 GsENVD6J123mZ63h4Gju5cF+EP0AcyuFG0s3kc3X2Ly7QG2gqQF4mTt5YR7AQ4LUGhWn
 jERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786465681; x=1787070481;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6LbZdVyqTDBN0A5hJIceewiIafM7gR8VpM4MK5SnNC8=;
 b=SolqcTdr0fdDjhFKz8eOUjYB3/sVt11ZVnQBIR2LOsyFO325ixYvvuyBzXn+vew7Ei
 KwR4374xXjdKHaU086sxogmuhXDzpZg4Pu/PSIidzTRbloEpc78RBpkY4XKeAtoUI4OS
 uH+AC/gtW7Y4KRgb/T3ldgtJZHgI2NT7014Bt3lRwDmdi50yWNTbN/ImeCqc7jMTbPSs
 qsYE9uTV1Xq1AypWqkWJK77HpX7BMcMhDAtRHlyMzMLIAcyQ2xl36WABRtQ8VQEObrib
 CjZuqtn5yyJQktn3Td02H9SxEx1lPmbtboJ0GudamnW4pZzAOjRCyFIbPSZACZM7D2P0
 jdoA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7p43BPURr68/WzQhOAewuHriymef0Tz8JUi7nQsBnuGTmnz8oDYg1zwVHgb1qEodqViNfYFMcHvE2/9K/@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxLEw7MMCnxFweHYqnm0U5Aoilfnee3kC4GRMAjU4wku2ej7Lsx
 GJiIPxJ/hAUw6qjpGVzRyFHuZ05T4mR8QHMJhrvhzu8GiCZMTesfm3Aa7wu9p6ZfO7e9lVTZ+tw
 bhfYNm5uA9d1ZhtRqUkHdAkP/CfTsRHfL7dIkYaRcvDg/UvuDYMNUNQAOg0KdRyl3/A9z
X-Gm-Gg: AR+sD13z+TTfRs4ltos2nDSyjt58AiAfcQHivPEBcyxKhxCXXo3aJypfawGrhr63CV5
 6CBJi0MEdU8ZPXuo8GO/tpNwU3SD2T+OEmtaHduIETA3vi7oJIw+BzmoIVGvgLLmgjtj3UmLaGu
 0G6o+mNefpRjbFhv0W5lt6psCBqcuaxUNiwqB1SuFl8oxqGaI5YRf8o5ukj0LwQkJTxnLnbpg2+
 XTSCNhp5xk3+w4XI4wPI6hZo96OVWwRg4aYUHqblOcDmkylJgpub4wL359y8ejfA1oB33FqnAIb
 o3nqJKhFEahfmB1j+aM3xv/3sZYWUFsROHj+o5TFUXFxzhrxgxkCx/sugyWTrxAMsZE5io7J7Er
 NmpIUP7eKnZi3gqNgLmLNXISRjHW/31SdIDkbQTTC71lX9RGovs9rNdhfg8Yjo7C0qPC5ivKzpS
 00mhKJcx50Q1oXjxUq0yru0TcGi9RJfJ2+MbK+SQuyVGZUV3p2OVc3CUHv8YrFWOP0nwMQVI6Er
 5NWQSC7zUmTmmw0UJ1+T618GqVIXa7tRfCHg03dDqTVcVYVI6wXhGhNSoP09v1ryyzfOxrYHM/6
 PFotxstIcT4COIDsKfWVQbM2bbQotW4YKQy0xB3uHOTbw3iv49XfoevU7tEXCVQ=
X-Received: by 2002:a05:600c:310e:b0:499:59fd:dbfc with SMTP id
 5b1f17b1804b1-4997a6e5226mr16144015e9.1.1786465680760; 
 Tue, 11 Aug 2026 09:28:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997abf8fdcsm6282445e9.12.2026.08.11.09.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 09:28:00 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 11 Aug 2026 16:27:58 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
X-Gerrit-Change-Number: 1618
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1618?usp=email>
X-Gerrit-Commit: 9d569f6b08b8ba49c69ecfe0ece996c9f56f8980
X-Gerrit-Comment-Date: Tue, 11 Aug 2026 16:27:58 +0000
In-Reply-To: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
References: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLkk1MjhmNWZkMjAwZDg3Nzg0MWU0NzNlNWUwNWI3YWM3OTE1ZmEyZTMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a0cd64b94d5532dbf25b0e04ca50c8bd87ad8fa4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtpKk-0005qm-Vf
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Rename variables
 that shadow other variables or functions
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2516990014330580334=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2516990014330580334==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="U+Q+at631JA="; charset=UTF-8

--U+Q+at631JA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1618?usp=3Demail )

Change subject: Rename variables that shad=
ow other variables or functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 12:

(1 comment)

File src/openvpn/push=2Ec:=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618/comment/2691a00c_769a1935?=
usp=3Demail :
PS11, Line 1004:         openvpn_time(&local_now);
> I think =
this is also a leftover of the multithread stuff=2E [=E2=80=A6]
Moved this =
change to separate change: http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1841
W=
ill rebase this if we get it merged=2E



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
Gerrit-Chang=
e-Number: 1618
Gerrit-PatchSet: 12
Gerrit-Owner: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 11 Aug=
 2026 16:27:58 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-=
In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>

--U+Q+at631JA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1618?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/push=2Ec:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618/comme=
nt/2691a00c_769a1935?usp=3Demail">Patch Set #11, Line 1004:</a> <code style=
=3D"font-family:monospace,monospace">        openvpn_time(&amp;local_now);<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">I think this is also a leftover of the multithread st=
uff=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Moved this change to separate change: h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1841<br>Will rebase this if we get=
 it merged=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail">change 1618</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I528f5fd200d877841=
e473e5e05b7ac7915fa2e33 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1618 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
=
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Tue, 11 Aug 2026 16:27:58 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No=
 </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--U+Q+at631JA=--


--===============2516990014330580334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2516990014330580334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2516990014330580334==--

