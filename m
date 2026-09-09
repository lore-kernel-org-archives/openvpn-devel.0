Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68905C79FB9
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X4Nx/QWlweX+gyaVemODIIBdMNWilBB4W5p8tqioQZU=; b=BD7EACqcEcheo3Wf7XL4x+PsLM
	3B7SpCj9OC+fmXkZiln4IyGGft+PgyRwBOHes/1Ng3+qyZhouhhGeFA4sidO/Sb2zzJZPE5Vfshcc
	Cu8rOYpS3agp3bSC7RnVkhYUS8uokOzaSUx7zE3vGJ5TKtRGDTmDC4rWLCPiMPhaV4eI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4Cif-0004jc-NT;
	Wed, 09 Sep 2026 07:27:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4CiT-0004jI-0P
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:27:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QNvL0YanTFeBwieHNkCmkzRMTtuvYdOWrPRLDp7fsAA=; b=k7cPqqsHeDOdd7WSMVk6WBQTq2
 q7aaS/qiw4HySApF+9KA5B/9k3QxUzHJcglFwg+kIUtwVudZ6D27qA17m2diPnbC5baFvY8KGpcru
 IcM30mUdqJl7FgHXKaOOXBxQm8u5HKmQOMOmVioNmhHeCD/FP4C5A+sQOjUIPv2nOqeY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QNvL0YanTFeBwieHNkCmkzRMTtuvYdOWrPRLDp7fsAA=; b=E
 ByrQiqs1i/uSSfPm1HFjOSHQcI6Th+eieWY4469glDDRSjlmI4JnxgD8BR0E/PRXQyVcOLSxh2BrW
 50qWANlhi4hH87mU3obsgaxlo2RoaMkMQhxKnCyq5tP9myNP1uifE5K01jaNZEXFsREh1pc9fBrjk
 0SQuYjvOJYltk9cE=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4CiS-0008Ob-Bx for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:27:32 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso80296755e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 00:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788938846; x=1789543646; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QNvL0YanTFeBwieHNkCmkzRMTtuvYdOWrPRLDp7fsAA=;
 b=EbiXWuZfmilchohHt0dwRu0I9jiIvXNNfIJNW4pKcFpFUGeXmainXKKaq7yG8tMRlA
 aBrlmdi8hw5nB80d+kysqbNDSJnkeckx2rmZX6c3/VxYt6oYz8Hvvev0EYCwQ5BDBQM0
 Y9Y2BxbqP3FfikBS7PMuAmsK81WAHUi5+bGK+1kW4IUAWDxbRnuX0P2CsLAv8udWr1kw
 nGPzizPotiW+NVptl2LlfNd86fzr2gL5pLw0OHsPABq2+S2ocY+29QRBbe4Q4M2GrNFs
 mqEiAhHa3t0OVtlwxyHAA+yC7nTRLFek3ShGrODwF11KiCNl8u0ADg3//sylz6vSyTE5
 9mzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788938846; x=1789543646;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QNvL0YanTFeBwieHNkCmkzRMTtuvYdOWrPRLDp7fsAA=;
 b=J3qRFQCBq43//o6vOX1R4XD9/YP6pez+HNe3Yz34Ik4dXDGJFjPuJfImZ0UeHHn4eT
 tcG8c++CygwO3+aRKAhXXoEVW6sr6+Lh6XiWoMAIAjHqJZZ3QsHj1YFZu2Qmut+VbsDN
 XKWbQuFCUlDomadJ0fflGeUO7m3TGQp4mstX3QT5LViP/tMIpEYO8d6gkewDokHytKNT
 mq3Jz7mritYj6AStSx485svhlU1i//luMHzhbc6hHEatyxY4x/g+D15zfvQ6z+9Yozid
 RSCPk5CshzHfQdSjWy7uIbv79DtEn8LFgSu6yvF5ndGcZWF7kh446mOveUhgN+Ltds83
 iuZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrJ/EqB8azPX9Dz8x8d+bnGIHlxAnNjg869/dgFl7dsEeHB1kxfN1Ho318yoC/5dxAkwZUwY/bxF2hACuJ@lists.sourceforge.net
X-Gm-Message-State: AFuF++li28XUUzPUmWACro/Yn9kAF7b59ek/VCslEWp3HtkHEokMRd5u
 KWTuwH4x4ZpjLAJpWiTXj1MYeyZw7KkgLBSJWWIruWD6UHrK4QFVeTvgeOhIoYkh1TMFXkA3dQ0
 tkRxVvUP0UVxMMsjFz+DNc9+JZy8L/9z6nHPG8MFYb/xVB8k0op5k6su3F7MQOUNd3pzr
X-Gm-Gg: AYBFou3cCntSQgfYdzqMMV8HnLBlIKmydqj6+6FWFyru2eVuQGOAcRtPR+sCwkviR6/
 /XRkouFYnssC/xgWRozcaXwDjKjRP6YO9IG+8jGmfhkFHghN1AQsByDElbTHGN7oD6P1h+8HgOt
 PtZk0q4IDQ9YHVHk9y73icaj7/MhJ8qEKQrgLsmVehyAEplqXhjKVedzlqp51pIjCLXC1BYnvvj
 eaEbEMPDggJVcONNHNHIMT5PKMaONXEZZt9N/sImGniWl1FBEydRBWqknEgO7hhHn6+hElQ6sdj
 SySJIBZPjOxPZ0LNsWeUGC8A1mU+7t4/qjMM8QKVPaTCw34WsK18fLTbB0LwxpLAxJuQ/1blGDW
 vtwWgDdK7OVnxe+Zhspi0lQBblKMyO/lYZ1ARWuTkV9qlZO/ly7saL6f9nvxQMKiqwIzVcpeg9n
 LwC0wQaEOuXlD/he+pbiI8hisdWDVYCgSKu+5G4HgRRaRx7sRCCDegZbP1TXn3yAHIDgN1e0sHk
 zoSCRyOw5vPJKHAN18ka4mGcV23PTh/cLKKPGwN6pQVfpbrjFkiAiaIlh6yxQUgyJvE1ezZhmyA
 OeIU9oNdwX9TZfFk4j9KfL3atAZ8fG+HuBKQ84oL23TzGCpEG6gMgFNWDgSCVA==
X-Received: by 2002:a05:600c:3b9b:b0:49a:77c1:d246 with SMTP id
 5b1f17b1804b1-49cf8286e30mr310950315e9.15.1788938845653; 
 Wed, 09 Sep 2026 00:27:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf7740d44sm987633205e9.15.2026.09.09.00.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 00:27:25 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 07:27:24 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 8285b3457f16c633f8971cc5725dd4b48e718cf3
X-Gerrit-Comment-Date: Wed, 9 Sep 2026 07:27:24 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5691cdb9b87edfc2e2fe9800137fcc47ff0bcf49-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4CiS-0008Ob-Bx
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2758123109343138372=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2758123109343138372==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aGw4DKbP1YE="; charset=UTF-8

--aGw4DKbP1YE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici=2E=


stipa has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add contro=
l message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 13:

(2 comments)

File src/openvpn=
/control_msg=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/d=
18d7f6c_303cd624?usp=3Demail :
PS12, Line 73:     while (ctrl_msg_tlv_read_=
header(payload, &hdr))
> Seems like a truncated TLV header after the wanted=
 TLV is accepted here=2E [=E2=80=A6]
Done=2E Truncated header means rejecti=
on=2E Test added=2E


File src/openvpn/oob=2Eh:

http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1741/comment/c8a0757f_b4229003?usp=3Demail :
PS12, Line 78:=
                                         *   0 means "defer to the client's=
 setting" */
> This comment wrongly describes 0 as a sentinel=2E [=E2=80=A6=
]
Right, comment is outdated - zero means 0ms band=2E



-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be36943738826=
8
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 13
Gerrit-Owner: stipa <lstip=
akov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ral=
f_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attenti=
on: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Wed, 09 Sep 2026 =
07:27:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Rep=
ly-To: ralf_lici <ralf@mandelbit=2Ecom>

--aGw4DKbP1YE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici=2E </p>
<p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change=
</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/control_msg=2Ec:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1741/comment/d18d7f6c_303cd624?usp=3Demail">Patch Se=
t #12, Line 73:</a> <code style=3D"font-family:monospace,monospace">    whi=
le (ctrl_msg_tlv_read_header(payload, &amp;hdr))</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Seem=
s like a truncated TLV header after the wanted TLV is accepted here=2E [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done=2E Truncated header means rejection=2E Test a=
dded=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/=
openvpn/oob=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/c8a0757f_b4229=
003?usp=3Demail">Patch Set #12, Line 78:</a> <code style=3D"font-family:mon=
ospace,monospace">                                        *   0 means &quot=
;defer to the client&#39;s setting&quot; */</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This com=
ment wrongly describes 0 as a sentinel=2E [=E2=80=A6]</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Righ=
t, comment is outdated - zero means 0ms band=2E</p></li></ul></li></ul><p>T=
o view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=
=3Demail">change 1741</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1741?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner=
: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &=
lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Wed, 09 Sep 2026 07:27:24 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comm=
ent-In-Reply-To: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></ht=
ml>
--aGw4DKbP1YE=--


--===============2758123109343138372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2758123109343138372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2758123109343138372==--

