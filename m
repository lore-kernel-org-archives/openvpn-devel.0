Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67156C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 22:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UMQryewymxhUcmYffzP9eF90jwhzVEdXX9wjkGP6F6M=; b=IwbU/VKbxZrdQ5x9a20LRGy0dZ
	jiQ+3a1dOAponn+RgQHmBSmn1Rzg+buM1j8ooJvjWaOLW/ifu8DQvBpXZwkX7GshfYnQOZ2RS8aPy
	G/OU3DG+/Mnic5R4IlKO2mk4yuVvSCYKP30OSwtPo7heiy2JKJFqlJKqpOC18u3x1R2I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wf3Bo-0007HZ-CF;
	Wed, 01 Jul 2026 22:13:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wf3Bn-0007FC-AG
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 22:13:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xQnET7arrQmOhl9yASctqBQmLtFZ1J41S2+v8hRkS5E=; b=PieMMbQx56d8F2mnEIcR8zNdqC
 MgBbYuO12huIa04sHlQX6bDEbnrrpquC5ggEv1Ss7jsF07m4n+XjrV8LZsBObTCkQcspSzL0og1qn
 B+cX3db4nqKoU/3DDtXT1rZeIFQF4VOUMLtDHVPT8pnzAcXFbTlOXoj/cbHC7FdpM0Fw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xQnET7arrQmOhl9yASctqBQmLtFZ1J41S2+v8hRkS5E=; b=F
 DUobrwWDEox3lkN+AxXo4y8eXn8D9wNw9Ze8vhKALLWmk3OZj+g1Pk4q0gVWxHRfijCs3iborQTtC
 kX0/X/ZT7RK2VuYW/7WyZtH6xDpAnW5WOFkTkcraHMNQoPs5o9ta4fJvpECnWVOvXHNGLxZHk9uJa
 kPBPs8EoD8VV2r68=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wf3BE-0002jM-Du for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 22:13:18 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4703bc0a99aso648989f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 01 Jul 2026 15:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782943990; x=1783548790; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xQnET7arrQmOhl9yASctqBQmLtFZ1J41S2+v8hRkS5E=;
 b=AYu50KVkEZy0Msq1GTwyJXu1iAlo534LiZ9iq5j0Bb1yimfUajCSZUqWUEBabzZT/K
 z22ZpiRCXk8etwGh9r/aYyGZ5MCpnUszaRXLvAP7P8Sk3kSH5n6MzzLzVophAjuPYewf
 Qi5IL2tGJlJPk7SnVSBDh+RsgSbeqALkus709sJml8k2aFXTx2L3MDXvgVor/oDsYkRm
 o599ufPnqJtvDLg+Bk6W5oghY3clagKu4v59VkakkpEwyr82R6ato/89YWpS3OXVqOJK
 4rRiVGWy5f9fcu+SBHFG6YqSYH/34RYVaiBUvZEbtOcFxxyeLdBwlyWtusdjlRHmxT20
 hCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782943990; x=1783548790;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xQnET7arrQmOhl9yASctqBQmLtFZ1J41S2+v8hRkS5E=;
 b=r1JR0j5AOYuS/rXqhuS9eLJuOPMntskpRyuAMdwiJhhnHQVPzOQ4ougSKikKUUGGJX
 +r3mgv8+nmFA44/Np5gwR1CZylbxFfP4BDoR7K2A8c979DnwTdt3tZW5RX00cgLctPDt
 M6aAn/HRGEfQ+aDKAWWH6eXTdNR06q/+ASzkOPjfc6Z0NObao0QlCDQy+OKhL+9r1ch7
 Uh8H3QbwKuZsv4Ra8T3BwvfRcyFRvMykfzCEpe9FTq3h9g2VTXuYIgw4ndVBAb+2ltz+
 CqGjY9pm2RET4EdEfoGGD+69QYbEAHOWVehcqtGFaHJc6I6cIauGbkt6ZlTT58NvY74n
 wxvg==
X-Gm-Message-State: AOJu0Yw1PCVcnn8vIhtw2VmIngez0qPuscZCmUWf5D8oW+nGLjikl7hR
 amTrzAI/RWzXrc1sLfpkYwnIgjULb2sgFEYWXp/qRc4U8HZjnlMHel9Zf5OApVW7YAP7p0U2jyo
 rs1VLhgUVwDu2g9FXcxsvTn3gwYxXmQcVaLYMPAG0bmZG0IW4+pIdGtBTR8Ir4S5KiBz3+u5dSO
 qVmuH+Ag==
X-Gm-Gg: AfdE7cnSSiSEgIOY+jQX1VFNPpMPpxRNKotfSnsHSRB/JGxH8xR+UABJ5YCh/WBaUs7
 Al9gqDl1ie/4KmMxyzaH+3QXtxOt20Mdflb0WrTf6ALZiEcRvCF6rK9X50/Gtx6nPU5v5YRHIck
 +HYrNwUcsNIJVWtj0XYkzA34DyLhwide47Lhyx5XjGHQbqOmu9TERG6liQ/64LwWh/Yf8Y1g6pc
 tnEIV8lVZc6V8IgO0Zy2Cv4mBd0n9R4qJQdT2MoGfk/86GwIoaqqd0/yCC1WtXF8JQSEM3jfDaN
 1pq3ZFi6jUtibC7vS3MSvEpita0MdxpqeabwGcT5iUIiK3X7Sj5j5+0FKghCg6SmRKrjxBLAS4C
 ads3sHMCz+Z9C/vVKq8a2z3q9Qt4kFA/tO+C8wMjJ38o/IraL3KvyKd7fB6Pmjdht/1tQ2oLF6C
 GBuZo7vMe2cfJUS42U2hIEcpbPCZJhEHeg8GwZ0iNH0XRYosOBSlFhMMhWSRQiwoqgzukWbiK7B
 UdT9u0litg/V89KMh+9otaZsrpmw/m+mKeYNpVS7dXBoVaHwKavYZZjgYPZeR4qwGh6d4rps/Xe
 Mck=
X-Received: by 2002:a5d:5e82:0:b0:477:6874:5415 with SMTP id
 ffacd0b85a97d-47768745749mr5296538f8f.26.1782943990320; 
 Wed, 01 Jul 2026 15:13:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a450bsm3370068f8f.10.2026.07.01.15.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 15:13:10 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 1 Jul 2026 22:13:09 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iba577d662b389de539b81034735e437199cb495d
X-Gerrit-Change-Number: 1761
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1761?usp=email>
X-Gerrit-Commit: bb285c2156009fbfbc3ceee439e71daf2cc3dc8a
X-Gerrit-Comment-Date: Wed, 1 Jul 2026 22:13:09 +0000
In-Reply-To: <gerrit.1782921496000.Iba577d662b389de539b81034735e437199cb495d@gerrit.openvpn.net>
References: <gerrit.1782921496000.Iba577d662b389de539b81034735e437199cb495d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTIxNDk2MDAwLkliYTU3N2Q2NjJiMzg5ZGU1MzliODEwMzQ3MzVlNDM3MTk5Y2I0OTVkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <29b461f3fe9efb8635c8f3a675b125f352eecbb4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wf3BE-0002jM-Du
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: test_tls_crypt: Fix
 issue with temp file name on big endian systems
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7340099144424772746=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7340099144424772746==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="j4HVpg6WGlk="; charset=UTF-8

--j4HVpg6WGlk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1761?usp=3Demail )

Change subject: test_tls_crypt: Fix issue =
with temp file name on big endian systems
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1: 
I=
 don't love this approach but are fine with it=2E



-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1761?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Iba577d662b389de539b81034735e437199cb495d
Ge=
rrit-Change-Number: 1761
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: We=
d, 01 Jul 2026 22:13:09 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No=


--j4HVpg6WGlk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1761?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1761?tab=3Dcomments&amp;=
usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">I don&#39;t love this approach but are =
fine with it=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1761?usp=3Demail">change 1761</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1761?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iba577d662b389de=
539b81034735e437199cb495d </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1761 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>=

<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Wed, 01 Jul 2026 22:13:09 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: N=
o </div>

</body></html>
--j4HVpg6WGlk=--


--===============7340099144424772746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7340099144424772746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7340099144424772746==--

