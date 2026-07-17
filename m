Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5065C4451B
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cSREnuydhWzEjLjcYGMkL4jm+qUbHpQCzJB7k6MkZ84=; b=jGOCsPXAqzrEAMhQE7Slq69RyI
	jQU8hzbmtAJKvz00KO5XBEZfEjPZj4g9JXsBN3vxe4kmayuSc5kxWTpdCJ7Rh9Ltm5EyvZI80UpNb
	tpbeyMNP15iG8m7DiZ80Ul4s0QSqiI5SnwX8/vNFoqij/XuVryPXiVSO08mnvdAmRmeQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkjdm-0007NI-K0;
	Fri, 17 Jul 2026 14:34:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkjdl-0007NC-HL
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:34:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fofctWq9hS8F4/Dlgwa/RgMIV0Qrtxc6unA1ZWeRewE=; b=RVDxCgAzlGd4APirW7ED4+q+tz
 m7/wFU29xLMKVeMDVt75Q45htaEl2WMVd+SslSLXcwxZPnq9H4v0ayMKtOBw0y2I7y35DlMx8ZIZH
 qnx1dSlDdlUrNo4HujEjHS1QUoz39To6/2J39E+shaknIF3jeBnc65ZlaTIjRDdn7PVQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fofctWq9hS8F4/Dlgwa/RgMIV0Qrtxc6unA1ZWeRewE=; b=l
 o8eTyC15Z/3r0dN/o7DIWE3ywuSWluwWGPLWYVebmCCNBarExSjfGyEWubaHI1u+n7zcbsMzDamXp
 4G7fZx64zThezriCWqd08WzgdY2WaSI2Obpjphjf2WIjsbTK1JT4Os+YnlzJIipUNrjvO3HN9o2kf
 wF8tdI/Fnp2On4lE=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkjdh-0005SO-Lu for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:34:10 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4954c9f380bso3235765e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 07:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784298843; x=1784903643; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fofctWq9hS8F4/Dlgwa/RgMIV0Qrtxc6unA1ZWeRewE=;
 b=Ga7lYqSCSPziw70Txf3Uj4PTez7mrccDl3KJ5otxU2PHwhwzBzLSc/bwDCebeeSUMa
 GFdKoNF7Rql/ipGELTBehweXDhalBeA18yAOolLL7ns4D+0TQVJf5Xhjo2LGYD2UEJE5
 qSyHgp/zfGa06kB4/p7bqUk+0CncxZRUmXlVNr2TFOrdT3kQrWglcsgPPhBZoIo8bWSp
 YpNvOvf953MsVijAUkA/H6G/xILsLHGsfRzDHTaNPI6Zu6T8FN5e1bFn+90MJcbzgGCz
 6jzueE+QYE8unFS+ghHSTMz3WVYuUeDekyeGOPtEQ8WvcvPQzoVxwD85pk74TkBMJyHC
 0N7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784298843; x=1784903643;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fofctWq9hS8F4/Dlgwa/RgMIV0Qrtxc6unA1ZWeRewE=;
 b=sP1dymB8k+eH2T18UT37uBC5v28K3O0qKSNq6dUojMwpS/liybxUk+7/J080R32Ypq
 2I3AWyQ1wK3U8z+F0U10VGuB/lVtQq8jn0Mxohb4ZY7yz39A5vKtCnD8QutBgHMfMNCF
 8nY8O/z7GegeDldkq++AGjKhb5REWLSNWIf3PRDAdo02m4wmEoasq5sNEx9RGK0fBBix
 UitvsU5IYBRodagOkVXK/B2fujn23ErKtGcWWVEvHkJguh7BEHjRNVeHWcdVqnyjERgO
 24FjxuDfK2h5Qr+RKTD7YDDUxZ8yZlcBqN7TRRaHgYt4YbGWIb0q6ZU0Z04ce4/91Fx/
 +0fg==
X-Gm-Message-State: AOJu0Yxx2hw8ORlcKhVzfU2gPG/v+itciCtVGXs8ZTzMCozxWoaG1y7F
 pqBYRwwBR1d2Y6820mUptXoeuRuxnMomY8+l71RCblodBs/UvT4sEQXvQWfBXkWyRGbaG+LpFH7
 sS4Ee/55STow62P7EFL2qlD337HOfWxznNDtcbnP1ArqBigRpvaYxxHIlGodnaW1mlvhsHD4iD5
 yFYfojAw==
X-Gm-Gg: AfdE7cmId0/gdJNURXU2nULaVpq15Ma8zR8VRCQAuIZADTmjPk+zOlUti4eQ8oZrUsF
 MZtf3uHrUvwKqtQQWWQpz2CfBHrXE3btKYCt37F03UgeL6tv+0/G30TXPDRSUCUxmBUJ4b26yjO
 5w/rKNO2y3dcc6y0hqcrrAMvZmeBW1rwCGUB0RKw4TtvZjWr+z0Xdx2MDKmprU0K1YGDXr5Qzfc
 k4/E7+dmLMd1COcTonTK88sRjONRjrhDQ4UhXDHs+Q3Jx3RNLEjTV7YePsYI8XZfGHRosd7XFOw
 GQKApToAQw4H+rxWX8g6df4FQCezbFexaU5JQlBL/cE6Q1+ofWgOZe64ASDxtyAovJHs8PoPu+D
 /Vpp/2UJ6jeYX1euVZiSAMEs5JSrePPbwwguntCzMxCiSvMjk7VOAQ5ganmi4uLmD/lTPSIWSOz
 k09CrFno1dugiI5udezSnHYdwdbPphripXvyrUIfvp5WnxDU5DrSG6Hsozjlg3t9gppLK9fmVIW
 VycPTk2LWeZKba9g22sO0EsO9YZ2myuJiA4IlfeoztWLYxD4oRJ9BklIHfpmgj6akUI
X-Received: by 2002:a05:600c:a42:b0:493:e983:806e with SMTP id
 5b1f17b1804b1-4954a3ee98emr35696925e9.3.1784298842891; 
 Fri, 17 Jul 2026 07:34:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a359a6sm55922145e9.1.2026.07.17.07.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 07:34:02 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 14:34:01 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 6e4746b5ad1e73d7bf95b650d780b7a07e7a7506
X-Gerrit-Comment-Date: Fri, 17 Jul 2026 14:34:01 +0000
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <655203ae8278fcd2b5610e1f08f43ce1db0e6637-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkjdh-0005SO-Lu
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 dynamically allocated ctx
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6581028450718034170=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6581028450718034170==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="N1wtg4HoNkw="; charset=UTF-8

--N1wtg4HoNkw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1571?usp=3Demail )

Change subject: Change hash iv to a dynamical=
ly allocated ctx
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 10: -Code-Review

(1 comment)

File src/openvpn/list=2Eh:

=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/1f6643fe_55d84d36?us=
p=3Demail :
PS5, Line 106: void *hash_func_new_ctx(void);
> please provide =
documentation for new functions
This is removed again in #1573



-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde8=
21899839324d
Gerrit-Change-Number: 1571
Gerrit-PatchSet: 10
Gerrit-Owner: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Comment-Date: Fri, 17 Jul 2026 14:34:01 +0000
Gerrit-HasComments: Yes
Gerri=
t-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Eco=
m>

--N1wtg4HoNkw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 10:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ddd;">-Code-Review</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/list=2Eh:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/comme=
nt/1f6643fe_55d84d36?usp=3Demail">Patch Set #5, Line 106:</a> <code style=
=3D"font-family:monospace,monospace">void *hash_func_new_ctx(void);</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">please provide documentation for new functions</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">This is removed again in #1573</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail">cha=
nge 1571</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: If47c7d920b2fa4047b7db03fcde821899839324d </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1571 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Fri, 17 Jul 2026 14:34:01 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-R=
eply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html=
>
--N1wtg4HoNkw=--


--===============6581028450718034170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6581028450718034170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6581028450718034170==--

