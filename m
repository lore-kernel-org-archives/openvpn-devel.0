Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886C1C5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8R6IcdVuBksC47AeRU/U3E5cRy6swVDhb3lHVImsesE=; b=OgwrlqcQxezNv/XaqyHkBdLAH0
	SyKzbZJeGL0veveoCrN301Xr8Aq1PZdBBgqAt1hd3MjmKpUFwBYGwvtFQ3e2eEK1QHAw5pP819ocH
	txOLi8at+rCHFLwXR2aVP2ZVkTHjekgCPcEXxibpQAv4QH089H5FO4tV9Y00kEF2BArw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvwKE-0002Bn-78;
	Mon, 17 Aug 2026 12:20:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvwKC-0002Bh-TV
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:20:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=T6YYusyyIwsRtYKN2wuVkfwft9vIbw4mpQhtsywomCY=; b=alL/iItt4luP6ph5HNJEuCc0d8
 YHQy9GuZNAZF1u+/Bub1avzgBNCHQyXsS8sP2ASIwu84mfNDidB4663aruLRxnQpQBx1taEJNiQqI
 1SrYeSBgeE30Q/DWnspO5j9XhBV/FeEGM8q+Uz4PsJuwuFZYa0PVl5w01BbjWkvR4uOg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=T6YYusyyIwsRtYKN2wuVkfwft9vIbw4mpQhtsywomCY=; b=K
 mSoXND/do/yL1OFwA/7OfZ5Hp9MhA+iRvytj9nvYI5zqybl7DJ1JSkorG+g8Js0Gd3gRvhsvGELRH
 N10HUt4xRUUagmbuv9m2oQTDzIvBab5CpjAhUc2iSxSNmWqwYKZhkPHIlDQkPwL1Nb4oNDu2G404j
 qjqHLKmevKCR87so=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvwKB-0005h0-H0 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:20:20 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so22066885e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786969213; x=1787574013; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T6YYusyyIwsRtYKN2wuVkfwft9vIbw4mpQhtsywomCY=;
 b=gb+yf96LrARUNdxltpLesTnHElfDvX2+pCOXx/ERbixaepLpycd+00XhRy1/A7LtAj
 qNmzY7J4PAtNhxMs7mrWGaCpCQZoLeD9lkjMIxCOOBZR9FFN6z3g6EmCVxloTGP1ivop
 efRKmaUuQDT/d5eiIs9goGecU/zz4Adi8BFicvVTn1DAFgDGhPeBH0YsgtyhMDKOaL1Y
 rjUuwBNtTPN7Ne6t7mnZQvcrFvYYxeVF5E1HdbQ9Y77DgGzY2V3fvPkgyOHGdP7h/Ol1
 MxcuoFH1tbWWiHneBWUNodBXgg7RH+oc3RJO9PMyC4zIj0dx8otU+8+SpUSOnG9ltME7
 lplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786969213; x=1787574013;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=T6YYusyyIwsRtYKN2wuVkfwft9vIbw4mpQhtsywomCY=;
 b=dEw4YwaPa/mrqupUhbAYYBLM06tL+Xt56kBalrsGudFxxcTtzpiVyjONwOJENP02Vl
 F+8UdwgzLH3Iy6mOFxTGAVw9l/6/PAGZyYgp0GJZNvBOTJqHkZFyVm2jH9NxU5QD9pxF
 aXlerDRnK/7E63IC0tOgrL8Tr5knK/RflZrm4fY9YrQkAk+QVPJQ7vb+UNWEeH0fO2po
 81DKvOcee0SszLaII01PnYpaaNPCk3AgMEDmJ+5BZY1v0fLa4H9fUbbCrXOjI86tUkzJ
 +MBpceyEYjX33vUTXOInHqvHbdOvvYtqn8D/IOnLQGRLhRPtozOPWSUZMPV2a5mcurzn
 nXXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrHlkxW7q7iDxEcuMcTV5MvUqq85rCDDmkOPYafC7TMTNro5fVqU/WEasEEktqqoKHRC/O6xyKIkqax/AwF@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzwXzMn0jyGSdstN9XsLWNEspnf6CiFPoRvOkmVW7pbPyQpeqvc
 60IFsBFokRQBN7AhSlJ2o8MKiE3jv7+x/wneqvmSibBXqjzIqeM6Jf9Exsw3nOC5K2uojX+PEmH
 RpJPXq2CalsL/vNdA8/NHsRw6PdNb06Ax6dxIkqrOORVaWIEdsu0oF2YunGzTBGy10TyD
X-Gm-Gg: AR+sD11IJx6EoCMZH0C9QWW48EmNOPLDW00cUNsUQDZL2mh/vcIQ1KlipWgJGA/i0+k
 uoh61KFzyjCiOF8Tn5x61RbjTmCs3REQrOOhTNbkh6rRNKWmDAa7APx9OCLDQh1C1ZDzS8FrXZV
 vKMqKOYM8y+c+ViD9O9HqC4frDhcdqzcmjv+dy0DPC5F47i43lCJ3qzDn9l4SNTc8vZsnN6lbh6
 GA3XM+v5X0nsFfth61UlzMBBSzDhI8nKRE7NoBe2CkHKVgswlmsKakmlHDntj30v17jx2FTURVe
 3XBjbTlNMGed9agd2KWGtYwtnFhMfvNbfkL8paRd4q0i4sQjqAsQQ4pZUAIhuph+KKLkkZl9PKZ
 NfqKbKwhblfK/3ephlfMH+bBTIbE7mHz4jyvLZAz05NywKJwcsyV+UdaLyUGrh6tqNwgolirPuV
 3h/GwO66xbtnBn9EYad+DIkVFhBU0aHhgcZBOckt0lsBTng7GjKMsjTaDlwGoerl9XqPZJwnEvX
 j8FAWsnsoCkWZ4CsKhgKf/gJBupikEliJHPxQKDoKn9CaInB0LubDIm7CwOY4YDBeyoyF47h+Ud
 c60awTGSFD36UfciUD/m0j4/nXJrhs/szrF1BRHbWvLnOsUzXuE=
X-Received: by 2002:a05:600c:8209:b0:490:e5c1:b8bf with SMTP id
 5b1f17b1804b1-4998796f497mr411305145e9.13.1786969212891; 
 Mon, 17 Aug 2026 05:20:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d078523sm39401545e9.6.2026.08.17.05.20.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:20:12 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 12:20:10 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
X-Gerrit-Change-Number: 1772
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1772?usp=email>
X-Gerrit-Commit: 16f746e22115b096bb1e6f1723cb4f63f0f6885c
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 12:20:10 +0000
In-Reply-To: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
References: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2MTc2MjM3NGMxNDE2NjJkNTk2YmJmODhiNjRjYTdmNzQ3MmI1MTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5d7fa19d7a302709fb6e89c7c4518eff6941f8c0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvwKB-0005h0-H0
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6603840349447004876=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6603840349447004876==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yICeY9U04vY="; charset=UTF-8

--yICeY9U04vY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1772?usp=3Demail )

Change subject: options: Factor o=
ut options display code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

File src/openvpn/o=
ptions_show=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772/comment/a5=
671ea6_e8cc4660?usp=3Demail :
PS2, Line 25: #endif
> Have added the #includ=
e there=2E But not sure whether I should include options_show=2Eh here=2E [=
=E2=80=A6]
It's not that we need anything from there, but my reasoning was =
that if we include the header here we will be warned for free, by the compi=
ler, if the "public" function's signature drifts (in this case, `show_setti=
ngs()`)=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1772?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comme=
nt
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6176237=
4c141662d596bbf88b64ca7f7472b5149
Gerrit-Change-Number: 1772
Gerrit-PatchSe=
t: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
G=
errit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 17 Aug 2026=
 12:20:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Re=
ply-To: flichtenheld <frank@lichtenheld=2Ecom>
Comment-In-Reply-To: razvanc=
 <razvanc@mailbox=2Eorg>

--yICeY9U04vY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/options_show=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1772/comment/a5671ea6_e8cc4660?usp=3Demail">Patch Set #2, Line =
25:</a> <code style=3D"font-family:monospace,monospace">#endif</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">Have added the #include there=2E But not sure whether I should in=
clude options_show=2Eh here=2E [=E2=80=A6]</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">It&#39;s not th=
at we need anything from there, but my reasoning was that if we include the=
 header here we will be warned for free, by the compiler, if the &quot;publ=
ic&quot; function&#39;s signature drifts (in this case, `show_settings()`)=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1772?usp=3Demail">change 1772</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I61762374c141662d596bbf88b64=
ca7f7472b5149 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 177=
2 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Mon, 17 Aug 2026 12:20:10 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </=
div>

</body></html>
--yICeY9U04vY=--


--===============6603840349447004876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6603840349447004876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6603840349447004876==--

