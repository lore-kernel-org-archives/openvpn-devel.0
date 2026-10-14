Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39198CC6B1A
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P5H7qBPl0GXPLglLegL32g3c1QyLxSsomHv1GrUAleQ=; b=dkJnjuT5MdNgn0zKPMKb2GJD9W
	6AipTGLYDCqW99fYsunzLG0gEEhJlbo3bTwWGMAdnvYLhQ9nVaIjuJdD+jyUXaX7wPoJ9L+RiBCCW
	lbV43f6pT5deJrhyBPykAwNS31VYh62B61x4cjHyq5NagpN/yZA8ouc72NvJdyMRXx4w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGwZQ-0007Ua-Vy;
	Wed, 14 Oct 2026 10:50:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGwZP-0007UR-CZ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 10:50:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=RjBz63QQeH7ei+6oVAXCP4PEJJbRQYzYwlhUNveLFjc=; b=UD7P5LbXVhKATaSyivR0pcgq7n
 TSvDWWbu5lHJgsL3BnHwJsOJX1esocAc8hvrnfpZlZ7BP9lioTqdolRsjvJqBwKTYYpalOY/MfGSs
 H88vnEQL8PNEo+FxSOHMBBOaLD81bAaSQMisutJECgaX5S9fKGVur853Ulz9IIItXQrM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RjBz63QQeH7ei+6oVAXCP4PEJJbRQYzYwlhUNveLFjc=; b=W
 5XOQtoNUdy/Sm9bPinDx7P/AZd05c+HvXNzpf04Znl8CJs/Cu7vn8q//G/vcBPhohW2GPcj2kJpnP
 MtCDpsUckgKMfrQeuRnOFVxxCCkEbO2mkFXzLQQKbZ3uboMPiTJf6ZRTVPGKISc83UugLWcWeT689
 Kq18uXoJ3up33Enw=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGwZK-00032r-Oa for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 10:50:48 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48c4d99c32bso487721f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 03:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791975040; x=1792579840; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RjBz63QQeH7ei+6oVAXCP4PEJJbRQYzYwlhUNveLFjc=;
 b=TxHnW2Nj55JXVZ4vKueqhr4gOCTFZ1aOIU7auppBW8PwFGEDXYlXIxi+nm4MRG0MDk
 ykeApS7atja1dUkxJ9HVOwSbDZtuE9VCXr2hwqKb8FseF/jhGlJhH360jBH1asLvleb+
 t0bISD1rMDHChnYq9lSjVYbnKJDJG1GK4hpgfLA0H/J3zrHZK8kbVvaB/9xNhmruMtz+
 RAZ8nwuRunwkKfJiIU+yj4JleNZJtWy6sMEhbCtnU7i8fKvJSB5bK0I7ziJ2nsjCYEPL
 Sx9X+h/hsAmjEtC15LgxIjUHGrsGUwj3dfaZE0VfC3ygxkUAx47brzuX0jP/WWcG1L1v
 +vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791975040; x=1792579840;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RjBz63QQeH7ei+6oVAXCP4PEJJbRQYzYwlhUNveLFjc=;
 b=QdC5zXbpgWwWHzBwQZszkrBMoBKi+giZBc0uVOqKL81QLLBTF2SJAjI65YxC68OP3s
 giCJtS2QD6jaSb6TsNAIYXJkA5jjCx7F6IBkvc06wT+5naETHPK+psAA2i/dUEE0aK01
 VPmTspLOKY3GOEorLWqbTJv3P/SFlQr8q04lpCD78xD2gQRT6GZS6LAxMd9aKDj8ppgG
 SNJysWZVgeoI2OEZxPqfVEPyg/1B7nPQsRPSeTSuPEpGBsWaAFHEHCVzL07UZWOLAubr
 gNeNCbFwCO9oTV0UB6Env19RicrKbnPAZ53HoxZjEA5nCQFILzE5Av36nJl1N49S7f6P
 JdMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByhDa+kdAjb4QqvrkWwNtBcphye0u9i4jVpV4g7IV9vGp/qNlfqISeFuSU1K+JoFDsijeJNVpcAVTKItqtS@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK11CkpW3ZP8IrUvEBf77LPYe4oDK1iQIvqok3qooCK4SV/AeVt
 iRjjgx0Ma6Y/Jqt7q+0xu03KchZVjWuyPXU42Y7Vh7l4CCAFZBelFT9I2TzcD63MRF+yjyE2wIN
 RJ072Q6I2ZCZhmGm8u9BtYNj1+Mu0ErjgYUjcFqos0/BE2gg+yhWNnus027oL6u9s4fSjaX/e9C
 E3kMoq0A==
X-Gm-Gg: AYBFou3W1k+g5kFZqDpVd+n70gB9k3EXDI6+7NCB9dhX3jWp+IgBgjw/kH1G8rj3som
 ba5kGNdCNe93N6+H+VNKuZBNa3mJXOP4Oyxrq4a/A5U6ktkyH/WdBgKHU4yoC6ycXKTceQ79ZLb
 msGZoXDVu/Lwdiyg9AjvLG4nQEu85S+QHdu+XUnHaTlHTsbKsIartvtkxTM6u/dg84fBxLAYur+
 +SX8cQqmTZnfRWeMx3mfiUtYWsmBHN7CwNSzF62HVe1oX7j5hBkxnXkued5ytvn9CMOTxKm4Pbj
 VHNf6sNUrzJVFoD2/B9J7uU3Xe2km/RvdFQ568ppxlNdBBSIFk83qfAO1OVJb3VYFTMlbYbjFun
 R6CO/IhQsqfEJJpjH7ftBMXffnKDckQzxJnXkp1oUC4g8WKBYKwlA2ZtXCLBq83tTznUHvL7Gqb
 41r32fnp3TF+5+3fRC/DcclbJyrNUZxsb8SLPVXOihR0ox7Mgj/p2PvX3aAhzE+6RZZzd9e4soB
 9BT1rlIzhGqRkXHqf9676PBDnWOcMqlwVI+tBicNyH5kgAV9fJ9qwmfAbzgO1UAcQRHqnc7Nk7a
 w8BKsJSGaneNYVjFpNMR0afjajCIUipyTTVaP8eBfD8o81Hggu68ATQQO1D6
X-Received: by 2002:adf:e712:0:b0:488:7927:9ca2 with SMTP id
 ffacd0b85a97d-48dbace0e05mr23597355f8f.49.1791975039021; 
 Wed, 14 Oct 2026 03:50:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bd733fsm11239536f8f.58.2026.10.14.03.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 03:50:38 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 10:50:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
X-Gerrit-Change-Number: 1997
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1997?usp=email>
X-Gerrit-Commit: a05840749fae02ea496242e2624097ed6817b9b2
X-Gerrit-Comment-Date: Wed, 14 Oct 2026 10:50:36 +0000
In-Reply-To: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
References: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkkxZDZlZDVkNDA5MTAzNTliNjViOWY1YzVkOGY1NmFkM2QzYmM4MjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3befca4e985ab35b513b4d229a4586c430bc671c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGwZK-00032r-Oa
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Fix small
 issues buf_printf and buf_puts
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7637506501868709141=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7637506501868709141==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5x86u7Z+/Fw="; charset=UTF-8

--5x86u7Z+/Fw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail )

Change=
 subject: buffer: Fix small issues buf_printf and buf_puts
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(2 comments)
=

File src/openvpn/buffer=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
997/comment/09b6961e_a7004139?usp=3Demail :
PS1, Line 795:  * @return true =
if the buffer was changed, i=2Ee=2E at least one character was appended=2E
=
> `buf_puts(buf, "")` returns `true` whenever `cap > 1` so that's not techn=
ically true=2E [=E2=80=A6]
I don't understand this one


File tests/unit_te=
sts/openvpn/test_buffer=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
97/comment/16d53d2a_2ec6f17a?usp=3Demail :
PS1, Line 68:     assert_buf_equ=
als_str(&buf, "123some text, t");
> This passes with the old code as well=
=2E [=E2=80=A6]
Yes, this was just to confirm the behavior=2E It did not ch=
ange=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
97?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1d6ed5d4=
0910359b65b9f5c5d8f56ad3d3bc827a
Gerrit-Change-Number: 1997
Gerrit-PatchSet=
: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Review=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Comment-Date: Wed, 14 Oct 2026 10:50:36 +0000
Gerrit-HasComments: Yes
=
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>

--5x86u7Z+/Fw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/buffer=2Eh:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1997/comment/09b6961e_a7004139?usp=3Demail">Pa=
tch Set #1, Line 795:</a> <code style=3D"font-family:monospace,monospace"> =
* @return true if the buffer was changed, i=2Ee=2E at least one character w=
as appended=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">`buf_puts(buf, &quot;&quot;)` returns =
`true` whenever `cap &gt; 1` so that&#39;s not technically true=2E [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">I don&#39;t understand this one</p></li></ul></li><li=
 style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_buf=
fer=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997/comment/16d53d2a_2ec6f17a?usp=
=3Demail">Patch Set #1, Line 68:</a> <code style=3D"font-family:monospace,m=
onospace">    assert_buf_equals_str(&amp;buf, &quot;123some text, t&quot;);=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">This passes with the old code as well=2E [=E2=80=A6]=
</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Yes, this was just to confirm the behavior=2E It did not =
change=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail">change 1997</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d6ed5d40910359b=
65b9f5c5d8f56ad3d3bc827a </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1997 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed,=
 14 Oct 2026 10:50:36 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </di=
v>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--5x86u7Z+/Fw=--


--===============7637506501868709141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7637506501868709141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7637506501868709141==--

