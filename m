Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86DDC5AC7A
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pyZYsJpZEeM4ImsBTrSxh3Lb6LNVEEjXGuGPQsCIdZA=; b=JHcsEC9MGLQjZFpbEU92e9ux+L
	K+KL8SRx2KlmZpx0jMPDSQpyXqaXiBMTCdurmWdD8wYnWUI91mTQnHOvnpw4MAX54A6i/HMex2baH
	7/EqtzF3I04Pd/TK5PTnaIr2SpdxxRAmgfouxOym5x4btR0QUx4V55jtOrNcWIh/jmzI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsMm2-00042R-Q7;
	Fri, 07 Aug 2026 15:46:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsMm1-00041u-G7
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:46:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=INXXL81nTG6UxV5e29ybnqflaazKKw2vZujfwTUS1E8=; b=kBxlQ00cfD4uG+G2oKnTwv8QAO
 zv2myPlya00r7w36QKa/EZhlBxL2J+NWY5JUnxjaF6wgY1FElOvCcrGDAJU/vqLhhZmOawlCPStuJ
 9nzsBbgmK9YDed7h0hGxr+VBb4Y4e2PMMpY4ZiSd178bdSt+tA32quMM1FqZD3RMZto4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=INXXL81nTG6UxV5e29ybnqflaazKKw2vZujfwTUS1E8=; b=L
 q5F8DWkOq2OgPrn4lYJJEBVP3z2+RK29csFf/L1flBtXzuq55I7TmiwZoRt8P6t7qlrEJ2OPc8b+k
 e/U1Jm6j6yUEgP9GVztFUxGJ3BWkAWr08GC8mU58L2pBc+UwxMZpmic+ngq3uxSzVSwtencdw8I51
 nSLKP1yH7/jFnO+k=;
Received: from mail-ej1-f53.google.com ([209.85.218.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsMlY-0004xs-TB for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:45:49 +0000
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c20363107f4so364350266b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 08:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786117539; x=1786722339; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=INXXL81nTG6UxV5e29ybnqflaazKKw2vZujfwTUS1E8=;
 b=eV6bckMgAJ+DITaFI37sSHmflnBRV3K/5u7y0SY8LBRKbYITUjgF+W3idc96Onuk2j
 015y2Hjqsg3peG1P8C8M5M6TrMMou3/aiEoSqbygT4/cbwJ32oHY258E1AWT110/P2CL
 aFoUR0kGNWO3brStKuIshqjFqI9GP2b/9QunAjlW4HVH3MpVe1bIBDe4ngwHOKF22CTd
 nDMg1rvfXjb3+r+IAraWc4Z45r/Mn1s5SHnkR9JmcAeVJR6Fc7y8de9c5JeLYzn7lksl
 6lGN73Tb4mIkTX7DbSPSgkyl2cMDxCLEaOVy9cyh10/brA6cZXEk6v0vjQSmLHbQPF9r
 lA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786117539; x=1786722339;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=INXXL81nTG6UxV5e29ybnqflaazKKw2vZujfwTUS1E8=;
 b=Cdcjyuft9vytlgeRs/r/QzqKIigKBv5iLwuIXhCRarE4JeLqnX5GOAL05uWw4VjSQT
 P0dCFfBBq+WYpZb1CZl5bL5DYBV1tdMhvFpnuVUYvw301iAvXIM6zPmfxQqz421HFXRw
 ObhCE+PCwb9TQFzvAqG0qGFGrpphjMw5qegBT8R/z5/OSTMDFExv3n5QqUCayTLYTKlu
 TZEhXv+n6uzXKRljyGAJ3W/AkD9I3MV1AeTvbyqV7O8+iUEXWLOHC50kzHn+foIXCNBf
 j7FJf6zax7MbRbMLHEqFFs+H0OPaemAN4qaz+XR9V91JqmzqJy0t5UREQzZbOaEydTPr
 zqrQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpWMmBds1OaU0RfWGwnblAzy6oyvcuZS+bCPrYGS4//T5SObhVoDEqRg+UOwivxYLWa1bgrEN7ostmjr5ne@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwOPLBDdZzLI2C1wkdsYi4KOIQ0TQ6WpTeAd/QRGusnR8CuLCF4
 Wvcz+U8K/Y54nQvO3ych/z04NO/vwjLbIDOGBrdEL2sOP1Ds2eb3M9ucUGhf6txI1YJYqVbCoXG
 0gmUOfoOpMLWytLAIxa+ID5fxtyP34mbzp1PZrMNnboHANjaLy+BsAnAbVy7CG4pO393+y8Sunq
 wWLH+ZVQ==
X-Gm-Gg: AR+sD10pCl5j4Ad3c4JN/8CXWXNaMij1YAVc3fB28kwuZ4+4fWqB1hDXyv8uZ7GZNMc
 JZB/pgyR9uFAIV71JqH0DOz/UWmTv3j0TBNGyWjqA67lB3n1GUO+Mv+nqpsziSWWFl+7PyQfNaB
 dNiUFU3jYYHedSf2+xI2Kzi8xZDPVhykfjOsS7B1zcWSE3uMhm12DQmXAZuw9eLapV9WDBenfm9
 vvI1RgM2uXB1pE1vtGq9sNAR4BwhU/8Tv688VK1wGQ4trDZlDGIoy0UnftnieEDeOTLxODjZ/4P
 eFZHaUjAHRlC5QppcqYPkqSWesSpTl2Te9C5ksZKgkDgTFN96L017D/GWxINQ69lDyimh5Dqitd
 AlnaglIIsS57q6O9Rkg9S8yzo6sGChivz+pFkRhJIoRS+myzgyErw4kjPPVwCgnnuL0f7bJzJQm
 SvdviEqe4inIpAdJPeipd4OSUa3xwDxNDwRSnPD9KNhy6uuyIwz3uwwypgYsQNE9zvZwYGy80z9
 /Kb+suAB5H/AfR5a8nCG3wiYHcXvlStP1b9BtmGRjy9sCXmNx7XElC4OqSJJZxsBe2lpYL3tKLN
 bXipxn9SxUiU5MmIsQlGTzWBB2jpOwcAGnB6zxXcRg31kHj2ZX2byaEiyutvfg==
X-Received: by 2002:a05:6000:29c2:b0:47f:77dc:b066 with SMTP id
 ffacd0b85a97d-47fec4e896dmr27669241f8f.5.1786107557561; 
 Fri, 07 Aug 2026 05:59:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021fd392sm5552990f8f.31.2026.08.07.05.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 05:59:17 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 7 Aug 2026 12:59:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41
X-Gerrit-Change-Number: 1763
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1763?usp=email>
X-Gerrit-Commit: de4a268fe490245fce4a6443a886bd6aea8ee893
X-Gerrit-Comment-Date: Fri, 7 Aug 2026 12:59:15 +0000
In-Reply-To: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
References: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyOTMzODUyMDAwLkkxOTA1ZDk0OTQzMzZkYTRlOTFmMTk0NmQyZmZkODc1NzIwNjA1YjQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9526d31c898f10b07abbf694db4503eaef598277-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsMlY-0004xs-TB
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in: Add
 utility function needs_openvpn()
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
Content-Type: multipart/mixed; boundary="===============2337439884232216876=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2337439884232216876==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lF5Q6w/OUII="; charset=UTF-8

--lF5Q6w/OUII=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1763?usp=3Demail )

Change subject: t_client=2Esh=2Ein: Add ut=
ility function needs_openvpn()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

File tests/t_client=2Esh=2E=
in:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763/comment/8828cdef_a13a64=
44?usp=3Demail :
PS2, Line 79: =2E "${t_client_rc}"
> Is =2E [=E2=80=A6]
`s=
ource` is a bashism=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1763?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I1905d9494336da4e91f1946d2ffd875720605b41
Gerrit-Change-Number: 1763
Ge=
rrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 07 Aug 2026 12:59:15 +00=
00
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plais=
thos <arne-openvpn@rfc2549=2Eorg>

--lF5Q6w/OUII=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1763?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File tests/t_client=2Esh=2Ein:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763/c=
omment/8828cdef_a13a6444?usp=3Demail">Patch Set #2, Line 79:</a> <code styl=
e=3D"font-family:monospace,monospace">=2E &quot;${t_client_rc}&quot;</code>=
</p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pa=
dding: 0 10px;">Is =2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">`source` is a bashism=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1763?usp=3Demail">change 1763</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1763?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I1905d9494336da4e91f1946d2ff=
d875720605b41 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 176=
3 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 07=
 Aug 2026 12:59:15 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
=
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>

</body></html>
--lF5Q6w/OUII=--


--===============2337439884232216876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2337439884232216876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2337439884232216876==--

