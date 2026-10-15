Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF197CC6B33
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VsRU4p84ENff4/3MIluPamXSSynI5DTjC3cUURJ+LEs=; b=Ze2dcq87iCymAoiwZFrJZeuGr9
	MTFJ4XfcMw1uVXIS6Lug2pmHnJWHwD4Pgg7RKV6qMI6UWbK8348usRTGXe/RdRYtu9OXTpJr2Ws4d
	2QJOontJbcwmDlP5pekZoyUhbynol/uIy1+FeXNPN6cb3X8s5ptXAp/liNtVw74NS7jo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHJ2w-0002F8-7q;
	Thu, 15 Oct 2026 10:50:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHJ2u-0002F2-Ht
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 10:50:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=004rl75u8AGov4idkunJCWYFTply+PjTadXYosev+5w=; b=Isq+kjLSS1cdYNhWw20WJzjCM3
 8ZaYHOaN9ZYDnOreCFwk4E/JwOTBWmPx4QSrTcetfE3smY9qQOIfILXmZP8N4Y9HbHu12veL5CT4z
 cm8YI8vU3rfM+5xAs1idFVd+L1vTbf5mag+YJAyuNVNDgn/s8r0aeVl57Bc/fyLqegWE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=004rl75u8AGov4idkunJCWYFTply+PjTadXYosev+5w=; b=a
 vi/xGEGupNhlnX3V8xc3oB7Q6OtiKYJMziBpkjQ5A8p03/QY/H2yUy4qpShbdNvTi9wct1dhOU1Wb
 CFWrYIjMnoxxh398TYhKjYOM5aVtHOa7QG1iAMjl/G7drafyKbKFUfjB5LHQOnogRDa+JnRu2mzJQ
 a64MhV38a78Qhz8I=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHJ2t-00060T-4v for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 10:50:48 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so268993f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792061440; x=1792666240; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=004rl75u8AGov4idkunJCWYFTply+PjTadXYosev+5w=;
 b=MbMEMUIdJwP6x8mxtMUnLab6gQmSjGVirBRkNEyn3ONAfibfKCYNXJsP2x7OTNHfAY
 ohS8nCPZuB6aup/A7Ihw7uxd4Jv/wIkRzGrHMShFkw0Sa4jgTLEmZSojUmTr3WBjss8q
 7u0vBzrZ9S3UfX+OrfAXMkHiXAoHkNcxAJQ2UtLx18bjzEhCtYs4V6tDRd7vNa8dscFM
 kNjZd8gP8dGxTkv9MbHOhPpr5EoznqjxZnX00gnjjMLdb45VTUEo29E2DdTDFdG6TbM4
 yXJ+jcBMII2uMfo2g6KJZdiuh4dac3PpPpom30iOPc6m/iIrylC06v6L/t8YptPbfEH2
 9MSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061440; x=1792666240;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=004rl75u8AGov4idkunJCWYFTply+PjTadXYosev+5w=;
 b=BWTSbo2KRpQl6T4Caeoi0yc3LrVq4TPpJBXNcba8rTv870oTYB0g+fCcrK95JByNg9
 qdI+Kluk1B69LO2th+rRKKKsGw9+EIuSt5vNDKaVsLkhinVCRwfsY47+p+azMtZmtnpb
 Ix2JTOjZhkKxwr0Ea7W3wNuNY3Oxpv7SkhCkWAJT3Y8LtYElnVePBNkqINM9u7+ZKka/
 FxP/3PBWeM6tpgg3SWxqiLvnzLoR8YeV106Bax/m74k0ZV17RjIWfQXkr9AHU3S05kpM
 LCngdiexcTU229uIJfugTTd7Z9jXIABaM9bDkvHB3DASPkgsBARNfqi3VCOAo/ZJnuMk
 Kjyw==
X-Gm-Message-State: AFq9FYK/I2vL8ixr1pHH2nbro2Kx9SXxfBZAxtSR5VeilPFo+L04D6oF
 kc8A/mwu2W30SM7JQB3Px1cYeozj1OKUVmmWjyM8N8krPdDkFRbj6GenQwbtT3EqsuV2dDGno3t
 5c4sTavlqbsejUdRcIt3vBc/TI+OZ0Dj3CDg+8L+AMs1Y8IbA9jbsjp9qZ/WUWmlp/Zt1
X-Gm-Gg: AYBFou0qHo4FIjuXIK7GnXv87Zbn4N72oka5xDWz2cIzl9nykVdKXAjhX3ToyJW/rtI
 AaZf6vNelr3n090trYDdxj5Ltw8rZaHmIf9TMSObMPl8C4wfXjKeLNGzb3jssOp3Rl4p+rCO0vj
 aEYq+ty2p7UH69Xzayj2hb29xgKbhz5m07wVG9dROK+Gx8q2K1CjXqIVWhRaxdzv/W4/mDIpDyM
 gbi3cOfyfTS+uUpaV4/dCMlZbm2LnXqw83OphyrRJRJojOhq+BLl1uJM3PpD8GSIK53/4q4gdgc
 v87pxBIjM73O0qF0DFBKQjfQNDswZctW174NeiEJuKS+4R+htgVIKGHgEIzq3JrVpyoNUvprvZl
 SsdmKR6F/otj9dJktCe8AYOqxAG6z0NLPCjkPqjQAtYMZm8iDbsCQ6EnHrMlie2gqpxLqD8cZqG
 Qhwb+BQQ0N2DPontjy/rBo4xFuxr1cKHlf+845s/XfIwaClLO5m6N/O/a304cHLI5FjRqmSgjdp
 4Rxn6xdm96d9wxSDH/S6e3RerhBHweIVTvlqEpNs3n7lJzSB5vFsPJo0cDLjmI0XbjzDt58YZl9
 OLaiV4lgFSoAtggfwUaFtV3Hp8XCjdDutnJLxIoSe16YNHHwpmwVPxK9yCh6irQgKCPYn2A=
X-Received: by 2002:a05:6000:c3:b0:487:27f9:841 with SMTP id
 ffacd0b85a97d-48dbace7242mr25936268f8f.54.1792061440429; 
 Thu, 15 Oct 2026 03:50:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm12294609f8f.13.2026.10.15.03.50.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:50:40 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 10:50:35 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
X-Gerrit-Change-Number: 1856
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1856?usp=email>
X-Gerrit-Commit: 9f283438f71b20dcde9bce14623a94737c6e3000
X-Gerrit-Comment-Date: Thu, 15 Oct 2026 10:50:35 +0000
In-Reply-To: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
References: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MmQ4Nzg1OTU5YzI0YmY2ODgxOTA5NjVlNThiOWI5ODI1MWI4NTU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <181f9627a5ca37448ec1b1c42058b11e3caeee38-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHJ2t-00060T-4v
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Introduce
 get_key_by_management_key_id helper function
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8562415883002248009=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8562415883002248009==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZIUNpgLggnk="; charset=UTF-8

--ZIUNpgLggnk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Frank Lichtenheld ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1856?usp=3Demail )

Change subject: Introduce get_key=
_by_management_key_id helper function
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 10: Code-Review+2

(1 comment)

File s=
rc/openvpn/ssl_common=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856=
/comment/f64fc087_ebca2672?usp=3Demail :
PS6, Line 775:             return =
ks;
> So each key_state has its own unique mda_key_id so there is only one =
valid key_state with mda_key_id [=E2=80=A6]
Done



-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
G=
errit-Change-Number: 1856
Gerrit-PatchSet: 10
Gerrit-Owner: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Com=
ment-Date: Thu, 15 Oct 2026 10:50:35 +0000
Gerrit-HasComments: Yes
Gerrit-H=
as-Labels: Yes
Comment-In-Reply-To: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Comment-In-Reply-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--ZIUNpgLggnk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 10:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/ssl_common=2Eh:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1856/comment/f64fc087_ebca2672?usp=3Demail">Patch Set #6, Line 7=
75:</a> <code style=3D"font-family:monospace,monospace">            return =
ks;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">So each key_state has its own unique mda_key_id s=
o there is only one valid key_state with mda_key_id [=E2=80=A6]</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail">change 1856</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I42d8785959c24bf6=
88190965e58b9b98251b8557 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1856 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>=

<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
omment-Date: Thu, 15 Oct 2026 10:50:35 +0000 </div>
<div style=3D"display:n=
one"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Ha=
s-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Comment-In-Reply-To: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>

</body></html>
--ZIUNpgLggnk=--


--===============8562415883002248009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8562415883002248009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8562415883002248009==--

