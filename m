Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7A3C982FE
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hz2kSWcm4WhiDsUtPOL/jhbZ/Xp6lNDAanqqJSxajFU=; b=QOLHRELZK0IUd4FyF1UYGzjaFp
	P3dTLRGJBt0gc4Ba7nj2HeFB6D2Nr4rO3xsdIfVvM5jn2oNllts6jZeH22VzGEN4fM7u3AEmDIR/i
	XyEkehJaHbOtaqCngwSo1/cVSweDwre5D8CbZMu3tyg0HJ/3iN9yEd8+YrUdFJ6G7haE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x91ms-000358-Pe;
	Tue, 22 Sep 2026 14:48:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x91mr-00034r-96
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:48:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5lZoLyh/2Y9iT33ejnEfpV8uQPjbta0kOUxOLQepHgU=; b=duBo5amiICFa6g+dPmBmzPOAD6
 HltSjJrUvwIi3WhT6KWtE33JwCCE/tQfDlpAPW1lFiS/y2sCYxexA+F++pY/5rPs1U8rTZwRa1eYA
 HlpiIoo9dfaR29VtfXNvd+Ywq4qLYsHjkYwJ1ZSaiyqBO2VW8SdEkulgVl+hFP/VcyoA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5lZoLyh/2Y9iT33ejnEfpV8uQPjbta0kOUxOLQepHgU=; b=f
 Sa+DauvTczKhRGZNYfjqNMAhYsx4PG2McGFG9DLIOwpSsBuvkyMzdj4YBf5iindzhkBWQgixS4jk6
 rAdQadeeYxGGdoyNQeVvxM2cOe6hxeitkqdA3+iIMyFQUJppFioJgU9avLfdzqkgeVocf9w0D+T+/
 ASXNUEr+5he46PBo=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x91mk-00030O-OZ for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 14:47:57 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f633ece3so2151f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790088468; x=1790693268; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5lZoLyh/2Y9iT33ejnEfpV8uQPjbta0kOUxOLQepHgU=;
 b=AUXcRdEqzHdpDSwxKFB9jPbfH7fFQ4I3z8RwwftDAIuuV1j19C/0xQc8ZeWEw/wLeZ
 XgfdeJxXe7wr3ugtgzpsXx4fKTj5Rn1jbRkt3YuPvm1fPlgcDVgMAXpCmL0SmU5WS1br
 UXgMBN/0QsvjDDbi5QTakhI0LB3bg+zhdkKk5iaGmknZsfMHlZ8hISYqFa6d5cfN9E0j
 xcQusMbmzLLYGfZk/aJwCuN1NXi+LqZkAmmZl8mjnLif2e613YpXfBS1HhKU55PN1dVL
 6yCBXCGAAui2u1aNHrlwxchD0N9cTMvvbNW65rBfDnasNeIs+FS1vSn6WK+bSJfVdheV
 D+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790088468; x=1790693268;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5lZoLyh/2Y9iT33ejnEfpV8uQPjbta0kOUxOLQepHgU=;
 b=jBFC+5SPnkV2SdEhWM9q9gWgawy53SAC+9h4s0D3ck41dhNj1dovhe/ZMoCQM8U55T
 TXNaDBY5jP71XyFuOLfGadAH0KmeP+yngnjH/7DzDbUkS2da09w56/VmfXdA20CjkXkM
 6t04xZizk8sDCWyHy7yGS6v4+irNkN4dNjLzRhuhvktb0xJKrFBussWZPB631ZPHaw83
 hIOac4lg6jV16IKOK1qgXj8yukJYpzcN3Isa8Yyvv5Ghv72qs8McnHJHGAYj0U6lX/vH
 nrbiuzXm0dSLp8g3wPJ0z1X/tHJlFz8N527v8RwSq5G32/L0TOeznnokpvL3pNcI5xPE
 KJjQ==
X-Gm-Message-State: AFuF++ntQhEYxPKCIMnTw3uss53yl22juJ8SqzQYUIlJQJIvAKP34LjU
 nGlE2lxDowON5mRAraDprxYmhPB7yDMuAMK8z1NtdvOSTqpRZDj7BWqn8bnEc9wbGVxNjkSUFKz
 N5TuMD7wOLBzYennjUVdzpjJNU7pzK9JZ7PaVmQ0N7s++q1KEEKo5nFNypp1gP7bei8E+
X-Gm-Gg: AYBFou1fc4cBY//QsSxM2emizcaPqoUurraKK3PedaXH7JLNwUdHP72MqExn3Zb6Z5c
 gmEJt/zrDLz/J+ey2d/pcdCoe4+EwcfjD1TJ5kY48iJ/iPkshfeDcDfZPwyLnGQO4zxpvnLiPOP
 +YK+maIn8eNgNTGc77XaJMKeV/5VmN7gRSRV4gtkfWIpyjukSPit0W31D3x4jtIU7r2PmuClj5G
 mpi2jG6Yryn7dclx5WJJhulGYVHqIqvYmL6lO9DkVl4gW86uMPg9CJbVh4s4ONov3dvkdj4iUf5
 E2QYVn1VRQPSbfy6R7N2CFIG33r3iutuCy8U8UhGVaIAniHKFEP026TMztbJtCw6X4q34JqBOKt
 ydD3uLlBiyYUQPVJ+q1sB+7DNI81sLM0AoazWH0dgjlxbKq3fzPHRq5aVX+C15QUxV4+iikn8E3
 O1k0UODBZG0lYMmuawlNPjKuQ2XqBKu6DYgB3j++v90y4LZbDpqkBDPPZlb0LCPXEy9dKHuJO8l
 QwblgeXcgHNleK6Hne19qIYuPN+jCaLB39Z8KOAR/2ruujpe21jCzc9epYTSq7X7UwcvES8rlFN
 RHYFUeah4INVkOhdYLKA0+ZnswgnFUZE4BMn3rzunCNHhj0t5dz9z+ovQ0Gvxg==
X-Received: by 2002:a05:6000:4685:b0:487:2385:e19c with SMTP id
 ffacd0b85a97d-4872385f827mr11982720f8f.0.1790088468097; 
 Tue, 22 Sep 2026 07:47:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886277e84dsm6003688f8f.20.2026.09.22.07.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 07:47:47 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 14:47:45 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
X-Gerrit-Change-Number: 1919
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1919?usp=email>
X-Gerrit-Commit: dbde2bc6021437e1cc5b3dd8d793fa8b87c6043a
X-Gerrit-Comment-Date: Tue, 22 Sep 2026 14:47:45 +0000
In-Reply-To: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
References: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NTkwNDAwMDAwLkk2MjE3YzA1NDFiZmY4MWVlZmE2M2E5ODdkYjg5MDRiMmZlZGEyNTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9cd9eaae5a7074fadae505fa32515a843568f9c1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x91mk-00030O-OZ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Document notify as
 auth pending method
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
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1784743467902527116=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1784743467902527116==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RYN4omnVyWQ="; charset=UTF-8

--RYN4omnVyWQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

razvanc has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1919?usp=3Demail )

Change subject: Document notify as auth pending me=
thod
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 2:

(3 comments)

File doc/management-notes=2Etxt:

http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1919/comment/cb682bf7_0ee8b601?usp=3Demail :
PS2, Li=
ne 799: This is notification that there be might some activity that potenti=
ally takes
"there be might" -> "there might be"?


http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1919/comment/349ebd15_c023627e?usp=3Demail :
PS2, Line 8=
01: a server side check or an out-of-band authentication like requiring to =
have
"might a server side check" -> "might be a server-side check"?


http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/832fe02e_db1f168b?usp=3De=
mail :
PS2, Line 804: This message still might prompt the user to look thei=
r phone for example=2E
"look their phone" -> "look at their phone"?



-- 
=
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6217c0541bff81eefa63a987d=
b8904b2feda2546
Gerrit-Change-Number: 1919
Gerrit-PatchSet: 2
Gerrit-Owner:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@m=
ailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Com=
ment-Date: Tue, 22 Sep 2026 14:47:45 +0000
Gerrit-HasComments: Yes
Gerrit-H=
as-Labels: No

--RYN4omnVyWQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>razvanc has posted comments on t=
his change by plaisthos=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1919?usp=3Demail">View Change</a></p><p>3 comments:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>=
File doc/management-notes=2Etxt:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919/comment/=
cb682bf7_0ee8b601?usp=3Demail">Patch Set #2, Line 799:</a> <code style=3D"f=
ont-family:monospace,monospace">This is notification that there be might so=
me activity that potentially takes</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">&quot;there be might&quot; -&=
gt; &quot;there might be&quot;?</p></li><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1919/comment/349ebd15_c023627e?usp=3Demail">Patch Set=
 #2, Line 801:</a> <code style=3D"font-family:monospace,monospace">a server=
 side check or an out-of-band authentication like requiring to have</code><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">&quot;might a server side check&quot; -&gt; &quot;might be a server-sid=
e check&quot;?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1919/comment/832fe02e_db1f168b?usp=3Demail">Patch Set #2, Line 804:</a=
> <code style=3D"font-family:monospace,monospace">This message still might =
prompt the user to look their phone for example=2E</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;look th=
eir phone&quot; -&gt; &quot;look at their phone&quot;?</p></li></ul></li></=
ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
919?usp=3Demail">change 1919</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1919?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1919 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit=
-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Tue, 22 Sep 2026 14:47:45 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: No </div>

</body></html>
--RYN4omnVyWQ=--


--===============1784743467902527116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1784743467902527116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1784743467902527116==--

