Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E86C982E1
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eaqlscfAfgKIThi74DkBg+e6NBC63sAZmE0yhBwUO3o=; b=FgTPo5S6rXTOM9Zt9VQ8m+YSck
	briQaaSGx5vSIObtCBHtCodQ39Z2rjVj7WHfjwLfxtg5WDn2zVomzCTNAg/WT75LUVCoutbKZznuS
	kdM0Yr0Hzn7WeB/lSNOxgKdfC5Amq/NVNR2ZU/fjc1CRw4MbY/6BLMSjPCSF3xOqTl4o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8b79-0000NZ-5U;
	Mon, 21 Sep 2026 10:19:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8b74-0000N8-TN
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 10:19:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2TKrTzbZPfFyGYzcK5mdcUrn159t/jFFMguUpy5rgQA=; b=bhbpNrXXWYxSRPBCSjWLcczMsC
 N1tvPx3NA4Y/7VrwcXylNfzZz8FJKUqTED6A0ETVeIJ8yVRYnu8WZvhzCDJWanf25VCg8FRX2KTFJ
 Hct+sJ3UcgEtWqqAf/IIpoeDrHMFMBBkwzS3NnDjQc2VcS271eNWzLBdD/PME+BrWi4A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2TKrTzbZPfFyGYzcK5mdcUrn159t/jFFMguUpy5rgQA=; b=Z
 BJ55ejxo0zuzWZLUc5FB+SHUMY90IyILjd184nHyqySQzZ0Xc1RTdNQY1XqdnAb7yRi74KVZL2TJN
 1pyQmPFxvixlXOnW2ndZQzXI2j2cN3bdCewi9meTERkisQ1m3XLg14KbmuJ+a+LPt9RKRz0qNVqm8
 SXv0U9UEElpa7m30=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8b72-0007Mn-QZ for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 10:19:06 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6350f91so1571882f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 21 Sep 2026 03:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789985938; x=1790590738; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2TKrTzbZPfFyGYzcK5mdcUrn159t/jFFMguUpy5rgQA=;
 b=Tpf37dpPMpggfMOzA6SviIek+kvwOhuGamqyaAiLwd1tut3yxK6/vfaclhP906B8sh
 x074o1brkFSHqeSR7rVRy7UbXIWD9qRx0gdbYhbnb34HSvu1LDnQAT4PCB1QTDt/Jbhl
 bwyYrlH4GkyJaVj8hQNWlpbiMAMMAxUC6WidDSR7lAUTEgrpkzaB+egHfN3hVOCNC+oS
 BciEgg6M6h2atgNZXYcaA7lSuy5a+6kUE7CYG60HNN3Wa1k7dYJ1MLtXAjNuV4YCp1+X
 cmhG4b7hNnzOqA3GPgeBXPleyRF8xiFqRdK+uRIs66n0SulCz5gpzbWmVlX1tOREgxS8
 aRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789985938; x=1790590738;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2TKrTzbZPfFyGYzcK5mdcUrn159t/jFFMguUpy5rgQA=;
 b=DKmURNK+EdG9Ob8qdiSzFblyXuHvRxnlLz6cPl56yUCeHvnAnIjR/HEIn3sxNzyT39
 D49hZu+lq0VoqLlO622exaP19ZJhIUoaNXF59O3FvvqdY3qrq41/8aPjX6ZQwps3hCHb
 kz/dFyRYESuNL7iadvmLK3/R1twMMqP44LY7IMXJk+7lUlCeGhNu5xdy7AVSbrUPXquq
 XOJR47oWVdHarG0ICDd+JCNevg1m7Ie9Xr6pPJgBwio0pqhv99x10GCSoscNRQ1J9B9k
 p45wa7hRDrVCtLamMwDRlpCRmobLiph9EgPQRtuNqsSQBQKTIJ5hw5ZBGxbqOuVjNQ5j
 chQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRsd13+rSX6NDdegWWLyOHRMgfQcKgPxUtmkPIXl5xy/F3Qztzs1YYWShGMB0X6iAXt61Y3YJWiwww0gLE@lists.sourceforge.net
X-Gm-Message-State: AFuF++mlJEe/28/8yZFKku1xgWa+XkYfeHOA6wXHUtHpED8e4bFTyLGa
 10mkG/RyPN6kwrYGozvryDPA4OKZYWs73henaAPzraMbH3Z9niuxd1dfsajUDUNqhvA8TQTi/Nm
 zVkoldr3OZJ9vR4DE+4rhVMCboW6X+9yqJlm6NEdKNxmEUztUTKyjB0KyDlOpE/NHMg4Y
X-Gm-Gg: AYBFou2lzueeFUou8CuKWg/er251MKyKVA/8w+XuHkSSUh7W4vmVw1uXzRuuXvT32QL
 b0i86JoVpIce/DvfXzOy1FhLzZi8bMy7PWG8Rcn132wWIgakIutqEjA+O5lwYkfWyJ5MhfM3jbM
 f1uPKPJGERTtxQMO/gxTUQkGvRaqrwLHNm+XHeTXqNmI2yOlJ5MefSdKkx15/BnGnktIp8Yqev2
 EmQXPPBkB6boeCkryIQAnxRBFSWffmgO0IsZOyoNNrWdU6FQtI5fSZrLV2X/hJm6Z62JsYNZ26P
 1ObxpgQ74NKl0nELyUqUhOokTGE41moQBhRqtOHxhxxe0CR6+rmXlB0VJaATAyIKYX3cjKGxXJz
 j1ILx7u/WSrbcM68XG4GqJhVv3baPH1DgU5+xi4NwvBlk9S6TLMfNASbUrwP04YNQKSrlzU7UUf
 C8FYq8r6eaoTb+NDFeBv5Nzj2xIXqbK+vNzNcmBlgqMiWvJpkRQUm9SI8VbR2E9hd9gfyp5HjAe
 pK/t6uG9VnRyzl1qBw0Qm5hL3PRVT96Sj5duPsBfZVMG14M8RzijJQZIvSItQJmwFglgRbN2+st
 RPWaAr6YRYsIGrmn6oq5K31tJSsU2216nMbLGvS+3DwzJ5iccmlBQIfXm8SseA==
X-Received: by 2002:a05:6000:1885:b0:487:c4b:7bd7 with SMTP id
 ffacd0b85a97d-4871e261f7bmr14214212f8f.34.1789985938146; 
 Mon, 21 Sep 2026 03:18:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724593bbfsm19526796f8f.27.2026.09.21.03.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 03:18:57 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 21 Sep 2026 10:18:56 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 29
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: 4d012d1a365a805f9abeae9014602d3556083bac
X-Gerrit-Comment-Date: Mon, 21 Sep 2026 10:18:56 +0000
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3d24ad0df039cee362e013e5ddea10b07228fc6c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x8b72-0007Mn-QZ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add
 --server-probe-reply to advertise probe reply values
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4617284357567641038=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4617284357567641038==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P12uTBJXilI="; charset=UTF-8

--P12uTBJXilI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

ralf_lici has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1752?usp=3Demail )

Change subject: oob: Add --server-probe-reply=
 to advertise probe reply values
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 29:

(1 comment)

File src/openvpn/options=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752/comment/ac19b049_ead3=
eea5?usp=3Demail :
PS29, Line 486: 'off' stops answering probes altogether
=
No longer it seems ;) This stale reference appears also in the commit messa=
ge=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id74cfae7e9d6=
9029d2ddbf635ee85a2a6cedc3d8
Gerrit-Change-Number: 1752
Gerrit-PatchSet: 29=

Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <=
lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Mon, 21 Sep 2026 10:18:56 +0000=

Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--P12uTBJXilI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1752/comment/ac19b049_ead3eea5?usp=3Demail">Patch Set #29, Line 486:</a>=
 <code style=3D"font-family:monospace,monospace">&#39;off&#39; stops answer=
ing probes altogether</code></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">No longer it seems ;) This stale reference=
 appears also in the commit message=2E</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail"=
>change 1752</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1752 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 29 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &=
lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Mon, 21 Sep 2026 10:18:56 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<d=
iv style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--P12uTBJXilI=--


--===============4617284357567641038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4617284357567641038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4617284357567641038==--

