Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA646CC6B1A
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x9sfn/KiXu8aFIglrZjG6Ps8uAQw8J0zGeGH4Cda8X0=; b=FAwSe8u2fXGbCy4OBVp9pEa1dw
	5IICGBQcpk3wtdiVbxNjfbHPGUj537SK0Wo5RAiYTm8IQZlJ89pHlw9L0PWIMPpRQKHpYAL3kO8aS
	MbO2+MLuiPCK2Fdt+kFTfJPFyfr9ABbdJ1azMvdbbnlssSQI2rnYyKnnKrU56JmXegLg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGwk2-0006VF-0O;
	Wed, 14 Oct 2026 11:01:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGwk0-0006V9-KK
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:01:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=S2uoKR019M6SykUJ0+nljZnlyVWGOdrAaBNecZsYee4=; b=csbrZXO73uz8IGU9SP2hfbxckG
 yc8AEFAeC6eGVf/sXYa1aPEnLyYOxUfAMQ+WO2dqtTXz2Dxp8ZWV6BFHS9FI3sDoQPzB5rFv+vgSd
 Nlgd0Zn6/GnkOuKrTgD57u6V7hEvBk1MQpxwNxqbEYffzksg6nFmk3mTJqeAymH+TZc0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=S2uoKR019M6SykUJ0+nljZnlyVWGOdrAaBNecZsYee4=; b=Y
 d1asT6IrK2CZkLSEyW+v2M/UUPG8Y5ZQlthYxkcybX8Xl86HTZ+ZzKetmVQtbqSOSC0+IDkZhNi85
 Ftrq0ReQIM0zodenQrjkOU8+/pFp4V+2f++MqPRvtwUZbWxK6B1urBfV44SUpAybW6s2PunfCt6oj
 0RHpIoj1uCSU01YA=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGwjv-0003Pl-MI for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:01:48 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a1635f7c89so8273835e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 04:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791975697; x=1792580497; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=S2uoKR019M6SykUJ0+nljZnlyVWGOdrAaBNecZsYee4=;
 b=XhDQyty5Vz+/BXgwaKDaRglSEQwW3Vmy4b1cWh4oMJSwZfaiw+QZz1j9mwEX3bWlJ6
 9qJEketV8v9V+af/Q5Y/Z7LeZehG83D2utmHRT5CHYSJPomwIqbAakpVTFlUTQQ/2Bbj
 YeGmbwfPhydUv0sbG4OSD0NIQrVv6vjbGYtO0uwMNyRrwzK6BhZNHFwiHcXwRyrA1MPL
 dVZiplPSQaVGAPXrcb4bnDKdyPBAD2BB1GaJrG8X7RKAr70ORwWTHDOItJ5M8sOUjMGr
 RDlqkgs7ycQ8fj3k7C+tdFx/ZPS6WxhBTo1LtuT0xXSaWJ8YeCMrFIzHa5JzrWYFvDkf
 noig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791975697; x=1792580497;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=S2uoKR019M6SykUJ0+nljZnlyVWGOdrAaBNecZsYee4=;
 b=QkAIwfz5l+BnZzr/CIHf7HSah0igJq3ky3Fla0bVVm2SVD/Z+F+8PUjPzBLmWiHX2a
 AAz/JGPZTCK0aUOFfZR6MsX2hiOxfvbtsmQNHZNBmIDhMyXgbIIuCoJ4B/1vcEbJ2qZz
 NZe4+qbhb+Sc44VNcjt9GzsqdgwpCLocnR85/9MWXt7wcRKIqSjnL1BUcQKA2Uy62cKV
 8IYAJI+kwioSsiVX+OwJ+6nIUwDZxfB9Exa3WqzXM2HSWKNgSuJIO7I5o4zEEuoYMpzs
 wnYT9nHgOJra96BNPTcVEmDUlLefvYmckTGMVRnk29NqBo0s0IeQtnThFeODt03XtNi6
 SvjA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwR3h1C4CPK67XA2umGPh/hqBmZsGDTjrtgdNBbiL75guNFlwWlSiUV2hDfNRMw2Voz5VbmQ/96v0NSd6Yg@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKBoVHHL0pDoGmINF/jRy5EVsQstuLViXZlcB6U89B2nm9NvQjJ
 iJaXRvfOytG6yhE/Atow8haZxsHvjPOQHUYO+FHJ8IPvevtzECYD7HJ29tVAfQxsyp74T/+HwrN
 buUT3ljE3ADnZzqPGXDXitbZA8lsMDc3Ve6j7LflunJGcFTv/9yRdwPdmkf30kcF/xGUC
X-Gm-Gg: AYBFou3Yrfn/g2tLstxmvRtAlEZqLnr6NwCFq1D+lHF8fKhKcdvjG3bGmY/5P+81sbj
 /7zwxTb5XdWBfGUphNvzMa/rEdfi9/JJ6O8Wz6zYWWhQP2ycg7rsCJBkFPa/FrRL69zimDB6Btt
 CrNZ/a1exe1lnAsqHUPoyW9TV5RzL3lFzBSLk8Zg8+CMKoML0lP9+r8mE3SwvWABc1DnZXFyi3P
 1cD4M8qEnL9bOubJYDFwnifYQmPmXJyVr+tN3xVBvle7sDIV6p0L+qcXc1w0T2yphayHjiVTFI8
 uFCgLNybiaEr02W8kY9Ge7blF8zNeTpkLSapjjEObdRH1Yjt3jLan3HNq465/QPiMULGPLidE7Z
 ujoC74F+KWTeC8Y1n7Q4EtFGHawXNwrF13fXM1sfIrMI+4vQgYfZSCuM3Xx6RWg/olgs1fmnya7
 fhpMR17YqWssol4iGiiy+N+e5M+t0fn75mUnNdoSDkEIb8OHsZQKudu4vzy1xqLx+gfL6yieULX
 ZBKgVvncL5UTHmHDmK1ntI7xKaogVI+8MHnthFgPEYVeGa0KikWNpKQNWGiTETvw+lTUWYO7bP6
 AU6LyOuEnkJE4N07Qm7kG6RKqaWMsbrEq/JiI0Z4LkMtLCH/3tghD082RnMM
X-Received: by 2002:a05:600c:e549:20b0:4a1:9438:719e with SMTP id
 5b1f17b1804b1-4a1943872ecmr166619485e9.9.1791975695521; 
 Wed, 14 Oct 2026 04:01:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c1e33d2sm641104645e9.0.2026.10.14.04.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:01:33 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 11:01:31 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
X-Gerrit-Change-Number: 1997
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1997?usp=email>
X-Gerrit-Commit: a05840749fae02ea496242e2624097ed6817b9b2
X-Gerrit-Comment-Date: Wed, 14 Oct 2026 11:01:31 +0000
In-Reply-To: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
References: <gerrit.1791901394000.I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkkxZDZlZDVkNDA5MTAzNTliNjViOWY1YzVkOGY1NmFkM2QzYmM4MjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <050c37eba4ce84ec4c8ea3dba64600081a966588-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGwjv-0003Pl-MI
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1682380773943772131=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1682380773943772131==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YtV9ai19Wlk="; charset=UTF-8

--YtV9ai19Wlk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail )

Change=
 subject: buffer: Fix small issues buf_printf and buf_puts
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

=
File src/openvpn/buffer=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
97/comment/601e60de_efe382ea?usp=3Demail :
PS1, Line 795:  * @return true i=
f the buffer was changed, i=2Ee=2E at least one character was appended=2E
>=
 I don't understand this one
I was thinking of the empty string: `buf_puts(=
buf, "")` with `cap > 1` returns `true`, but nothing gets appended and the =
buffer is unchanged=2E So true really means "there was room to append", not=
 "something was appended"=2E



-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1997?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a
Gerrit-Change-Number:=
 1997
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 14 Oct 2026 11:01:31 +0000
Gerr=
it-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Comment-In-Reply-To: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>

--YtV9ai19Wlk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/buffer=2Eh:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1997/comment/601e60de_efe382ea?usp=3Demail">Pa=
tch Set #1, Line 795:</a> <code style=3D"font-family:monospace,monospace"> =
* @return true if the buffer was changed, i=2Ee=2E at least one character w=
as appended=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">I don&#39;t understand this one</block=
quote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">I was thinking of the empty string: `buf_puts(buf, &quot;&quot;)=
` with `cap &gt; 1` returns `true`, but nothing gets appended and the buffe=
r is unchanged=2E So true really means &quot;there was room to append&quot;=
, not &quot;something was appended&quot;=2E</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1997?usp=3D=
email">change 1997</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1997?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I1d6ed5d40910359b65b9f5c5d8f56ad3d3bc827a </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1997 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Wed, 14 Oct 2026 11:01:31 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-=
Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Comment-In-Reply-To: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>

</body></html>
--YtV9ai19Wlk=--


--===============1682380773943772131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1682380773943772131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1682380773943772131==--

