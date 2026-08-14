Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAC0C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=srdB+Not8d7pV9fKpETjZ8LwSpTtbuN/bA5JAj3DUcE=; b=aR+j8F/eM+i6PIf9B41vB/u8FI
	CbhLDWpNBwanCH/yg0yX8cHpmMXjw1B3IuYMbqrao9wpLIHUFjMm1ObBxPtmgxqucifJeXpLe/W7h
	w/bYbGdBoc5OCutj54dQ7CG/7SltfANAFbRHqak2MornVUqW8fvYkLzmhATbY0uOcLUs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuppY-0002b1-E7;
	Fri, 14 Aug 2026 11:12:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuppW-0002av-IM
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:12:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NgVMFP4HVxTm500cwZM3StINzxWWA3xhDwrsHuhQ+zU=; b=OXOjn02g3iVmx9y/Rba9mrQLeM
 IY5zZU5B+KEUydOh6/18fmJn6bPR5/MfZG982zprw8KrHKiXKZDUi+p8+40Cr3baYj9uuQD/KmCLP
 yv/s/9A0Ah+iHgX8m15aHV3NSssJUbNa90u/I3Zhze6YrVJl43TbCK7AIl1PL224pH7U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NgVMFP4HVxTm500cwZM3StINzxWWA3xhDwrsHuhQ+zU=; b=K
 6z8KunpldNbaEyX9Y6sBI5+zUz0ZfZnl4VjnuUm0+o3xbfFxQtbQ183z/x76Q8YeAIrLTmewo3TYw
 yJ3vSakkY0CeXer6bgUGvIV8OckuTcmTH4DlS4XNi028h48/B6KCNZQXUgMWgmO2JUxrhGTlZSCMl
 +mURUafpi2VANATo=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuppW-0004VD-Uu for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:12:04 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49802c418b5so8287605e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 04:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786705917; x=1787310717; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NgVMFP4HVxTm500cwZM3StINzxWWA3xhDwrsHuhQ+zU=;
 b=GK2ggZj+GE30lTX55R+Pmg8JCQHPZ5bYb33U2htv74y7/CAii1exXQRhhwgIkkM/Hj
 9NINPdwg2REKPKh3Z4sMVFsN2IdW3buM3dko95jt2tyFyuYpusFml/LnjLCaoT5Czqje
 +d5mqKYJXjKifUNxsIe8sSKPKJKbUrwUbrnNKwwVJcnp/QDSiliUffXkfEdO4FyMYYAl
 QdQqa12dbV63IhKs10CSqDiiHtGzHwUM5p0xw3R1Zc35L6xFJfqEND8r91IDCsgPHM3U
 EtEymPQDatEpJGn5TFKJuGBkTXlHQxFNepckpXU/xmlzXge2te0SAMxzWCf9KscVozJk
 FpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786705917; x=1787310717;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NgVMFP4HVxTm500cwZM3StINzxWWA3xhDwrsHuhQ+zU=;
 b=NB3Oa97OoZYkthFoO0d0H2hOf85NnUuvtSeNi7G5OCI7tUUdn7FCt7BPSlQki4Myxo
 f+nLTfWfXZMKqkJ6odkxqmDRUw47kfzGIZ9xIVtA2A6WLc3fZHWebl7/1ENzrT5MN9w/
 /UcL3Gw150AvMlwxKWY2kO8KBXwn17nXWvOECAbPQBMSl98x31TBta7tq5NjHfZOIf2q
 TFPvtUyjdKfj4pZ7yEynzoYQ8bCxQ2ct4OYtU8OiJ2OvxWWe5bkCKzzDVwaQAS+Xyz1G
 z/5AwqLtNSc1vVuEkpz3mE2QRyaYdfMyJInXWhgcumxlYTH+oUtqQ8gw62LTO92+Mzfz
 VWmg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRYdrn1ApWdYuAPqo4rRi51VWF83IA6TtWF/OQuK5HQ8LMy4ZFRUPRYIL9jXcJacAOblL12q0Xk3tZNX2I@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxZHrgy1IgRNr3iBVXq8y0xThYhcK6JxkY4vUb2lgPTJLrkt1DL
 OltxHJxf5Ix0Ojt10a+c5ThOxfGLHveenk9kg//SFY/9UI2UEgMCu0SBcXlRG5mc1aiIj53u5aj
 2fiRheNshQuPeKJ9WL5204boHjsSumwQvQEldR1lJ7ZcCk5HXmxd7nY1WfWtHOEEmqZ7HAtfr1j
 KwnfLjgA==
X-Gm-Gg: AR+sD13sgCNRbGc4wDqOIJ7Y0/7dKr2UKlwSFAWZbZpiVd+hnj/V6MeWC3xyHa2tpcA
 kQeP6WfQ8TBsc/IOIkMEfWpJiCv6F5iCCzsUxQZxGLADp5Ix1TvKWjGw1c20lssA5oh0y+NxN3U
 M+B8TnvTYCPfYrN86DfRNoJ09NEpponHsjLJ33oMxcov7kGmQzkCLSE93IV+0JXwRBVDhqV/4rn
 mJUxAT7Ol4WSpqtBiaqLx2YLpvkXhCLRusX2hMXAeNSX9LTODjfjP3OYW6fzXr0RKXbX0nT3oVc
 nhOlSLn5gndHLKuuPx+emnqAm/LAqjXrArqEvqxwaotI1HmuYKvn7gPGchNP3aKi1M14gicrZED
 4hE+gpFlfYsPbGbC5a1Btqc4avE6nmHawGefykAsOR0oEgfJexEx+xn/Q2iXPZ48RQxtRoaGykq
 6O/SJb+LgazuzzRa9RZw8q+9TfkHNxT5HAaAWUUmVsfekD/vJf6IoB7MNI78BtzUIKZlejtlXOG
 1ghugs3qIErmqvndm3GBHA5DxhdmOb0TblFduR0vDzje6AZQFNj5d3rIkhYpQjArZZqky/XV+CB
 wd6PQ3YHQhaRrymv+/ahfLsMtCxOCJX7IwcMyNMwYxvcQnklGOQ=
X-Received: by 2002:a05:600c:68ca:b0:495:641a:bd3f with SMTP id
 5b1f17b1804b1-49987995272mr54190455e9.13.1786705916299; 
 Fri, 14 Aug 2026 04:11:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b2a509sm41147965e9.14.2026.08.14.04.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:11:55 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 11:11:54 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
X-Gerrit-Change-Number: 1407
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1407?usp=email>
X-Gerrit-Commit: c80b7640aab6ada319d989df363df39135c58aad
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 11:11:54 +0000
In-Reply-To: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
References: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY0MTY4MzQ3MDAwLkliMDU4NGU4NzI4NzAxY2NhMTBhYzU2NzVjOWNiMGU2ZjVlYjkwMWFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3b9e94cde49c017c5b1bf621dd4b01848c915361-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuppW-0004VD-Uu
Subject: [Openvpn-devel] [M] Change in openvpn[master]: packet_id: Avoid
 conversion warnings
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
Content-Type: multipart/mixed; boundary="===============0666180447955817812=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0666180447955817812==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sbb/IaMysGs="; charset=UTF-8

--sbb/IaMysGs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1407?usp=3Demail )

Change subject: packet_id: Avoid conversio=
n warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 7:

(1 comment)

File src/openvpn/circ_list=2Eh:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1407/comment/e6d5f35a_344027b9?usp=3Demail :
P=
S7, Line 51:                (obj)->x_cap)
> So the array index and the size=
 should be the same type=2E Before we had int for both=2E [=E2=80=A6]
This =
is wrong=2E What I changed the value of is the size in bytes (x_sizeof), no=
t the number of array elements (x_size and x_cap)=2E x_sizeof will be alway=
s significantly larger than those=2E

As I have implied x_sizeof is not rea=
lly used anyway=2E It is only printed once in packet_id_debug_print and oth=
erwise ignored=2E

So I think this change is fine=2E



-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac=

Gerrit-Change-Number: 1407
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Dat=
e: Fri, 14 Aug 2026 11:11:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Label=
s: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>

--sbb/IaMysGs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1407?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/circ_list=2Eh:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407/=
comment/e6d5f35a_344027b9?usp=3Demail">Patch Set #7, Line 51:</a> <code sty=
le=3D"font-family:monospace,monospace">               (obj)-&gt;x_cap)</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">So the array index and the size should be the same type=
=2E Before we had int for both=2E [=E2=80=A6]</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This is wron=
g=2E What I changed the value of is the size in bytes (x_sizeof), not the n=
umber of array elements (x_size and x_cap)=2E x_sizeof will be always signi=
ficantly larger than those=2E</p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">As I have implied x_sizeof is not really =
used anyway=2E It is only printed once in packet_id_debug_print and otherwi=
se ignored=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">So I think this change is fine=2E</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407=
?usp=3Demail">change 1407</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1407?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1407 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Fri, 14 Aug 2026 11:11:54 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=

</body></html>
--sbb/IaMysGs=--


--===============0666180447955817812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0666180447955817812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0666180447955817812==--

