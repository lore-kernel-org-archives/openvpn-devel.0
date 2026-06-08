Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65621CD6E79
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PIfLRNIy+kKojAJVoRyh1OyOU/p6ZG9hHACKX/+Tfo0=; b=nEtcDL+KUcYaSSv3uPkcWDTemp
	NshvOna0LU2T5YGZCsvven/3p84wRIjuqlUTVUIbFwshWdkaoI5Fo67aAsXM19iiN/t54Z2RGgumU
	aBByzd3CAgdZ6kEQEziD7jS/3qc6Nw6LBThrxGa1cg76XilqBIBIQezv0w559U2eNS98=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWcvF-00055a-Jj;
	Mon, 08 Jun 2026 16:33:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWcvE-00055T-Am
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 16:33:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=H+r+Kps0EnJcoxXE/o+PB6kohCmOQPUvfspTIS9EFYs=; b=jy2dkCrB71Ed1mCgeueJHR6xcB
 W4kSfsHcLBoGGzpHLxFmX4XWicy8ALmu+dZLus2wjoNW3GbRoC/GY3bnufvkpaPyV/qezebOzLO9T
 mL1r2Vc7GGDtYFFXXXW70qSku9sj0j9j9R8OgeYiOdlZACrskgammNyfdyfFEMQgfJis=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=H+r+Kps0EnJcoxXE/o+PB6kohCmOQPUvfspTIS9EFYs=; b=l
 zIDQ0FfUm8EUZg1aydyy/KSJSuRJVVAM2l3mmqZFIgXG7Cr/47bkEqzojmlLWEo3kENQaZhMwxH6a
 MibMf7FeIP3PsaNk3bGyejuPWvAMfNhu+3NJpvfHghOGgf56YjAHZvTwHZZROdAi/f5oE3U/Zyctd
 A7/8xhRJkg7o8BBI=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWcvB-0008Dk-QF for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 16:33:56 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-45efa80e0afso3518349f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 08 Jun 2026 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780936423; x=1781541223; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H+r+Kps0EnJcoxXE/o+PB6kohCmOQPUvfspTIS9EFYs=;
 b=YWAk8cJ/u+GuWj13rX8EMgyGyE01jQhYEsr+yNoyB3wSvk0Wynxm0m/JIYdySb3yL0
 nEAmQ18nQfeW+ZPkxLp1J7OBzogB2dl7blivstRgUZW2YjZEqZbh+RmqAOF1HPyNi997
 FGWg9hQjGBAkPJWjZDrYUo8pCYX40d+dlUJKxB6MR7V7MbwTIrtUsQbq9ny1AxvXWXcH
 W8UprCdlmDGfH14LAtf+vPqS7GrPUhZXwkqGhHMBcdMTrmHPKsyO2xwhM6w4CIjovgBp
 TXdOXJGZTKO8ysGz+pKTPkUrQ0y7CnDZqSVoorY/V4YktJhT2/UmPMUargrGvSvsyGKQ
 FdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780936423; x=1781541223;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H+r+Kps0EnJcoxXE/o+PB6kohCmOQPUvfspTIS9EFYs=;
 b=cpzPP6ozSPu6uQymKbuWQE/Q/NJcSXYBW630PtY30z6ABtegEmE16lnP4B+G/x2MDg
 zQugL+D1zIgd8wV4q/5sVkAxwkU6nB2ZT45MxLkc92Mo3VvB8blSOfYERAc5Ola6AEK5
 AeVpY3vxCgwAijjwNQj3fA2TYo1dfVF2fz1AFLwoxuZh65IDq7C51eqswePDe0UVCa/1
 2yAeAqBeHFEN/Tai6HQQPPkWVatwbWWRxd7ZWSfXWck02NdQNeFAFmUOcIq5zGKT7xKx
 HPHcsHRmZnDgEL04wupug0YFO1ADSOQncCg9XrMRtNfZ0lPPO+oPY6KWwcbZrEcY4kYS
 XUMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9MKDyDwfRZqO6iJln4vQe0yUK+JG2P28J3CK9uw3g1GUvpe5P/seDG+TMSEnPx3ZK00yZYhB0n4YpkHSo6@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx3NuxQOpBuh3rU9YErxWO0AyuW/X/Ym47dnabPCdaYSzmpSzWT
 MPq+4k8EahOsPc18/qZKmp86MhedGGcR085VMBc0ETto0+wtjsYv8u/YMHrbLmcPSAXEudRpa4E
 dh3VH18LKzz+4XnbHGoanSxwO011YhmFMXIj9mx/h4IrIPhtxblrgn0cpBHEEyMZJK5DN
X-Gm-Gg: Acq92OF24enp8mu4yMUWe6QYFOldi/khGcnHzIRT5T1H7J1JljsElT3GkbCMccGTLgN
 g1HPRWyZ76KGnj+mlj+3TUo7goB6v/+8iW11tQQRqv0KU++HNLeVCr2trhJvJ8OMjKrfY8guHcI
 L+qqCpYOlC7mgThK9Hm/TiVn/nXXiwbxpaOI4PsaKs8aKnF+oaLfehO1kiY9FoMxYfnfpXjwRug
 CpuBhj50J5qLKlFwLVf+cbophLamBJSIBiLmpFpgsCSfUtwbcJUsqCKpzLS8MA4UAUSWxPkT18r
 zunYGjHds9XfwCyTHMf1VU8O388qe40mZoQNQlRTNDUZVVcsgA0zOGN+PThHaKBkZUN4dCXJDos
 T/MYW/UIaOqiPPgA/h0RXVxlZr3AjoglYR0HXen+wQI+XJRnF14gQyz9xHTF5EAVmsQMm2mOwR5
 teTzvZn5QszzyMSO4fgpktvIGYDqNmR7TpSfuhY7iv1t0S8UQX1IWlQG2Jj8cEGIX/dPtZmeUx4
 KKlmPb9ST6r0enxdinP+rjBcxOhGjg+4mZjRcbWu4jI80ivMhwtKUyXlOkC4y496Mk5JA2EVPBh
 upap/2t++J91gXEktM1GoJ9C
X-Received: by 2002:a05:600c:8518:b0:490:a298:3859 with SMTP id
 5b1f17b1804b1-490c4993bdbmr292197595e9.24.1780936422508; 
 Mon, 08 Jun 2026 09:33:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f345209sm55248425f8f.17.2026.06.08.09.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 09:33:41 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 8 Jun 2026 16:33:39 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 040bb8548c15c48df5d615e916e46e7669c8d32b
X-Gerrit-Comment-Date: Mon, 8 Jun 2026 16:33:39 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b65dc234bfd57362033d7490729c2fb95d60c045-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWcvB-0008Dk-QF
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
Reply-To: arne-openvpn@rfc2549.org, gianmarco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4967882031773095509=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4967882031773095509==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x/M5FMW9G8s="; charset=UTF-8

--x/M5FMW9G8s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan=2E

plaisthos=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: multipeer: introdu=
ce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 11:

(1 comment)

File src/openvpn/ssl=2Ec:

http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/30f18a42_e2c10e22?usp=3Demai=
l :
PS11, Line 1194:             srand((unsigned)time(NULL));
srand will be=
 flagged by people for not being a secure random=2E Rather use rand_bytes h=
ere=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a13ee90b67=
06acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerrit-PatchSet: 1=
1
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: cron=
2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Attention: flichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 08 Jun 2026 16:33:39 +0000
Ge=
rrit-HasComments: Yes
Gerrit-Has-Labels: No

--x/M5FMW9G8s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1089/comment/30f18a42_e2c10e22?usp=3Demail">Patch Set #11, Line 1194:</a=
> <code style=3D"font-family:monospace,monospace">            srand((unsign=
ed)time(NULL));</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">srand will be flagged by people for not being a =
secure random=2E Rather use rand_bytes here=2E</p></li></ul></li></ul><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=
=3Demail">change 1089</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1089?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner=
: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Mon, 08 Jun 2026 16:33:39 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: No </div>

</body></html>
--x/M5FMW9G8s=--


--===============4967882031773095509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4967882031773095509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4967882031773095509==--

