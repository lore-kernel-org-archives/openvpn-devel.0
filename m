Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8168CA5FFC
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AVEyjo9VGPbKfhWbghDlFxTRUMSa+MplR7iRaiI9jU8=; b=Yn++Cdss86Mp+l5zYWqq5SlU1u
	Q84KnypCzLKAIr37t9ZlZOZ0XopSt8cOACnA1jwHVzNo81m4jIfvXxJRLDM4zVzLSXqKErPN8RVTY
	3mxQ4BknR+0PZ5kVYCttZyQ+n1p76NKfMvg9n0JAZHciCvQuxgP/2Fekl/P4hkI0Qtdo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEUmU-0002Yb-8N;
	Wed, 07 Oct 2026 16:46:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEUmS-0002YT-F3
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 16:46:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=foZaxf+8UFCk68dz1N5PK47lZQDSrZMisQS6r9Eu8tM=; b=UIBVYkpWopf+o0NR5EFHFEVaGC
 dCdvpVzjj1y/ramk2HfF2XlfRW+mCPvGMTRj1uOyWpjZjPuKmXZRkL2OpjHoSvME9PXg8Y30tz1Fb
 qiqrKxf81RofkJl8VTUNTNuNLvOUrZuQqSQXqYtK9qLWp8CXoovuWAijIo5IRUZnVOtI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=foZaxf+8UFCk68dz1N5PK47lZQDSrZMisQS6r9Eu8tM=; b=V
 WcFCN5w+5bSkMkiVgqTVYXBHtzU7zGBm5nPvtmEtcIWk2SiUVWN3F9BE/oioNLDKSBYdc0vxyJY/3
 1T09VyGSsAreflfCWX87hWi7LbQbG3xSBUEVdhuUbooY6FFOrZj05QULFZMxixdodgrxPB29HYT6q
 xdiExToi9+52fhxo=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEUmQ-0003sx-Fs for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 16:46:12 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a02753c04fso11910225e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 09:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791391564; x=1791996364; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=foZaxf+8UFCk68dz1N5PK47lZQDSrZMisQS6r9Eu8tM=;
 b=ORePjSVJU+lpBEtZ84xS9fVI/R8LTeem5kzTgfY9O/FAvvRI4VnK0i9eg13wed8wwD
 TW6Z5qlkgLv0sjfS3AoKeOfkgHkFk+IxKXjJiBFsy4k6ByLPYG8l0Pyh9Hf24VMUrjlX
 hhEfwZweVZRT08uTL9R/Svs+E/40OBHFnGo021rQ7PRcg4uhOolUat9WBLLbgqPdSJu8
 297NVXKN3uSwgSbnMh1Igc6zMX37UUnNbv9D6L4lkVNBSiOBRNTLw6iF3I1ycrGnECAJ
 om/0PZsyIJM6frL90ALL1A2RGdO6W18XH8CQ8qmUnAuyQVfkwtYJnBKgZsoFGEqepPlQ
 wv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791391564; x=1791996364;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=foZaxf+8UFCk68dz1N5PK47lZQDSrZMisQS6r9Eu8tM=;
 b=r0VZHEpmvJhMinuz5/RmgiH5WeZvfeILYMkKX5XfB/arYvigBgGgVbYz+n2F3wew/n
 F3al855woWHGsL7LCnUmvnq30HtnBjQFW4twFKPqE2DVDbaItHmOZNdEJG9cQmkj6W/C
 kzIFEzG3P4GMn13BbGwEBsFilZckEJr5vXLR04+X1bS5kvKZ/Eo2kOSBVEgwpCstWbGi
 p4gm9j8DZbZ9kDj7uCHtgpp9Rt25t+nd1jLeWKUK16TeznNmW/wCIOV4EgoW6S1+fgV1
 Q/2+A8IAeFLfq73M7yXqfagC0wPQenJ3ernAd0Ro8YxTOvcRd3bdXW5uLge2jDUEL0UJ
 oTtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxmjCzHoZGGQKqz5WXvU95yWXuJSRyVhkO/16oGMwTMAlamm+tSEA4yyCIRAWqUqVcfrVXxN37oxRzqdVi@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIlERO9zJywPROsk6pxYKuCpMfJcas/3itDpbCG/Eey0doN9mLi
 +ChrE649frUiITPManTGWNdiPRKd2/ZoxKEpoG6n5BYz4kAF76VXeclSmkrRDKi0R7xP2bWSsUW
 zI/9xMxI2M2lUUu9JEN7ekq0ZnsCNr4gAz5jVvRuZmOACn8bmdUI6b+oBa90dmFjhb1TO
X-Gm-Gg: AYBFou1S4GsGtd/+aNxkOE9vZ1+a+SdyEC+gZpXKsMqqysEfIkdFrAN0OZnJcbjdees
 rtlRZU3e34CGLKPn00C4gfbrYojnwLVoCFSXFa5FTge+4SfOp0asDmp4stfd48E/XYqZS9W+wkS
 wTfx5GXgYrkPLn1kLti0C1/iB26aZP9408GdHseaW6V8g/KALtS9s91hqfmoswmWu8geFVaNVLb
 QF1RlG/zGZPF3Jjfj7T1y95Z9+Lepvz/TQx7gupKp5JSkI9L4E/octq9yctPh07VjlrWmf8AHCY
 rBzslArVEOW//0rGog6RuuhZzTSPzoJSB9p1ctnlKaFo5WVEfpKsFFTBTehxcJR8Z/D00hGT07B
 GAz7wYf29nwLPlADgm4lYljXVvuSata+Ae+gtelGJxq15qF5gF6E8CktBrxPg2uOIonWsjaCfIP
 OUVq8nGOAM8uUHJG/eYFtJ2yHjVQJ2Iqzx8b/qnNTgjH7zJZuUJFqppSrPxvhE54+a/LC5ZeKiD
 nYAUHByb0OJSDSQmdPBcF6QcszS6jaCPbr+2iG8ye1Aolaaucx7TUJw77y/3ZflNij6QuCgNuX5
 lIFUwTVIpV9K8ihE5DS7HV1Bus4jbN+fn02RTBKIzstB/QkU8lnUhW2Al3VYVIn6TuZPupw=
X-Received: by 2002:a05:6000:987:b0:488:8a5d:ffcc with SMTP id
 ffacd0b85a97d-48c7275b6bbmr6019633f8f.13.1791391563518; 
 Wed, 07 Oct 2026 09:46:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c7b293d9dsm653678f8f.25.2026.10.07.09.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 09:46:02 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 7 Oct 2026 16:45:57 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 31
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: d26fb6d4a2ad7f59269b568c80419bc18bbca028
X-Gerrit-Comment-Date: Wed, 7 Oct 2026 16:45:57 +0000
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6d05ffcac2afaa81f5dd818969b5cfc63633d4d7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEUmQ-0003sx-Fs
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6482004102658198528=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6482004102658198528==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jCg+g24AIRg="; charset=UTF-8

--jCg+g24AIRg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail )

Change=
 subject: Remove instances of constParameterPointer cppcheck warnings
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 31: C=
ode-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1663?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5624=
8cf6d199c2da770774b8fd1e5daf2b116f58
Gerrit-Change-Number: 1663
Gerrit-Patc=
hSet: 31
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-R=
eviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Comment-Date: Wed, 07 Oct 2026 16:45:57 +0000
Gerrit-HasComments: =
No
Gerrit-Has-Labels: Yes

--jCg+g24AIRg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 31:<span style=3D"border-radius: 3px; display: inline-block; mar=
gin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span><=
/p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demai=
l">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?us=
p=3Demail">change 1663</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1663?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1663 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 31 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Wed, 07 Oct 2026 16:45:57 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"d=
isplay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--jCg+g24AIRg=--


--===============6482004102658198528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6482004102658198528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6482004102658198528==--

