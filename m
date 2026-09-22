Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C82DC982FA
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TflGdhGd6xxl3jK2ukRL8YvnG2h2plajWTIZkTESVps=; b=lrO+yaqvhUU3YK0SlPXJzEsWcf
	74hrNKyOASzf7lJ+gn9NocF53rJ5bLLNAuyxOfxjr8LG1pE8VK24i21HXQ028yxybhBld3ccjdwYg
	+7LPPyAGgo69/4NvYaq+5K/T1Nkj6koMF7N33lyeTjtUVS5BGfDb6zeJ6BqkF0ATgnnM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x92wE-0004fR-5e;
	Tue, 22 Sep 2026 16:01:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x92wC-0004fK-AY
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 16:01:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mhKGCIsrvyzFPKADyBEfKkqlOatYDJi7GzLUud7Q41A=; b=F3Vgn/2PYiYknkdnk3oEBbfrGU
 S50HcxfdtWaXffsVSZI7gNU661UfQCb/ojIvTrmc4Z5X5QqnT80iNiwbt4j0eQZ40WjJ4zqUVcnPe
 off3Qs10QRkioIUKsauxahn4DSCSLs4jr8mpv+15sG3znt58o3HOVRtLgjFnbBaobtk8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mhKGCIsrvyzFPKADyBEfKkqlOatYDJi7GzLUud7Q41A=; b=a
 Wt8PBtN4Kmyf9YXVlTd90C3IkzX6dkWkK40QXdMVrihrs80aTIuS+KACCpXQDk4fgoG4qCiVg18D+
 qe6KNICqtvkUE0XI6oDj/RK+OhcE+KWTtfthEwiGiSkw2rES0aoOOGfj7YLnP/jkyzsoW7/T2m915
 SgMukbanSzqiAPeg=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x92w8-0007k4-99 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 16:01:43 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6351831so60818f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790092894; x=1790697694; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mhKGCIsrvyzFPKADyBEfKkqlOatYDJi7GzLUud7Q41A=;
 b=Qt2WS0pu5atI9bTGPA9Dd82o+XLkCn3jiQ21XZnE+5b4OS5wWkymsnXs5660fnL56J
 gSCVRay/018k9JtZ3dDOXrQpRgGjCsMnxc5B1xX4ZaMu39k28IGyxA01GFaaFj4uXkM6
 SBlOK/C/GfjxZyw5n/KubIueazZL5mCzHh3bUqdZTH0/QyXXsuq1i0ZkmqDGA8BPZy1/
 HHuM6UzFkoo9tjfV9+liVwld3wA0O6V4q8ZKzXODsc+3IiY+Fqk7WDy4TIt7QPV029E5
 LM+SxTqASbtgkAMFBk3PpfJhxToKAJ3DwKvvJcEfSIljDfmcS4+GBKE8K2AE1ghEiPUA
 jeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790092894; x=1790697694;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mhKGCIsrvyzFPKADyBEfKkqlOatYDJi7GzLUud7Q41A=;
 b=HbO5sQsgtdVAu/dgTNi9jJOKqHuvQR/MOj+yCsaCN7gbR6mLB4K8UJJh73cWsLeill
 H8L3j8Wy0Br83BO9r3t3ZVN7AfDGH8IJK7SE7Yt39208Ks5stjD9oZcYwrhlxQhMRV+c
 teaQBpL/4sfOqBhyFO68zfLdSGqHLqQwQRLLCtj/h4UH/EkFfaz5TddzB48NenkJ3ipF
 L5MEVWHvfPAGmiselsHd55LFyzlvmP8W1pQhhbqcMK3Nn/SPzcPYBlzLtC/ioe9j/87F
 St/6wyWNFwaahSn+4p6o4eJ7ZEYxwpihYlvZQoWH/W+wEBqxp56Ca2ctRSyhSTzaWtLW
 tNTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxP14cfS80M9HltPFa3WSrIpKMzTjxXVohqCIEvvPQtZv7oDsMxcaHsioayWf1XGd8sczAVXOoHLjemZVSP@lists.sourceforge.net
X-Gm-Message-State: AFuF++kzss2dpiUffODO4Nd+yByFqpPATTejYyy+XOlX5qK4I9CVQWjt
 vFCsYvPRYDfu1b9a8vKmjnLgzmhVf0Ogx/PCjbe8WWb1YLhkBJb83VrQRyBYGn22yv6UlRc8tSf
 MNITGbwZHnP2ucUyBV9dbvf7qSwQ8hqYI9vEoMCl7AONaHGjkyj5Z+KQfcsnJVTcjMETK7ZPrb9
 +mCtgGHw==
X-Gm-Gg: AYBFou3at/u8om9wqmX8vwKeR+vnmfOE3CADET4b9T1d3y4z04gFT9vp1IdOMc+ijUn
 ly7BEQ5WiFRlHNbhq0ITJVCWOI6QI36sGXL9KrCu0EcXXf2iiWoP8q1iojlop06vtWn2GvKUL9O
 a3hSjNTPHypN0H3slViEGlMFpL4qwRLLYSaXqniRs0WSi0aBoWaLmUiWzqfareHmrp8g59blxbz
 e7e3dJle0zdLvWHNIFN/7bmZM4n2J1tGVFSLpRXYtdbCXeOKgWNMA5nkbDIbOnYMEaJKaDSlTkB
 diJVKIw78SmJR85ndIbiPpN1GsRkuWmLVuKtw/hBv5GHeR2iWMdCq5YpjcyJJlut1V+nNnnnzaY
 /sfRaFyztJkhwgFPsQdahuya7RLxdQLE1NZCv//HkEoZvwMBack9gGusNUK33VWvPrp/Ge6t1VS
 iFK20dWaJ53EJYoRZxElB/eErO5Ds5rcKIbY7v6XhYyYtr13ykaqc/82fVp1JsVQN+MDdu+Jx06
 qLhiZiTKkhmvZqrX+wlgeX7KoCY5HQhCuzyCeMBl4VP0uC+9VPGkSL6wybaUWunXXxaNDXZeE4A
 +M2jySWUArexWEakqp1ndlxEs5y3hitSMir4Jxktep4VvZKbxEitXAAn3q87N3L7OjJf26E=
X-Received: by 2002:a05:6000:2409:b0:487:221f:65b8 with SMTP id
 ffacd0b85a97d-4886709ef94mr43089f8f.50.1790092893170; 
 Tue, 22 Sep 2026 09:01:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886277df46sm6154482f8f.17.2026.09.22.09.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 09:01:32 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 16:01:30 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: b4cb1d8aa312b8ab550c9b540cd670f93839beff
X-Gerrit-Comment-Date: Tue, 22 Sep 2026 16:01:30 +0000
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9a4102a1e0436bd538083a343ee44f59d66eb9d0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x92w8-0007k4-99
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change most
 ENABLE_DEBUG ifdefs to ifndef ENABLE_SMALL
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
Content-Type: multipart/mixed; boundary="===============7953691452451562914=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7953691452451562914==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ugmKJgu/D4E="; charset=UTF-8

--ugmKJgu/D4E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1942?usp=3Demail )

Change subject: Change most ENABLE_DEBUG ifde=
fs to ifndef ENABLE_SMALL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 4:

(3 comments)

File configure=2Eac:

http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1942/comment/142c932b_e63410b2?usp=3Demail =
:
PS2, Line 134: 	[AS_HELP_STRING([--enable-developer-debug], [enable devel=
oper debugging support (enable gremlin) @<:@default=3Dyes@:>@])],
> default=
=3Dno
Acknowledged


File src/openvpn/crypto_mbedtls=2Ec:

http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1942/comment/d34e3cc5_d12a13e4?usp=3Demail :
PS2,=
 Line 846:     /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_DEBUG =
to avoid unused
> comment is now wrong
Acknowledged


File src/openvpn/opti=
ons=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942/comment/2777de9f_1=
9b8ae6d?usp=3Demail :
PS2, Line 4941: #if defined(ENABLE_SMALL)
> `#ifdef E=
NABLE_SMALL`
Acknowledged



-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1942?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
Gerrit-Change-Number: 1942=

Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 22 Sep 2026 16:01:30 =
+0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: fl=
ichtenheld <frank@lichtenheld=2Ecom>

--ugmKJgu/D4E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos has posted comments=
 on this change by plaisthos=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1942?usp=3Demail">View Change</a></p><p>3 comments:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;=
"><p>File configure=2Eac:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942/comment/142c932=
b_e63410b2?usp=3Demail">Patch Set #2, Line 134:</a> <code style=3D"font-fam=
ily:monospace,monospace">	[AS_HELP_STRING([--enable-developer-debug], [enab=
le developer debugging support (enable gremlin) @&lt;:@default=3Dyes@:&gt;@=
])],</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">default=3Dno</blockquote></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypt=
o_mbedtls=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942/comment/d34e3cc5_d12a13e=
4?usp=3Demail">Patch Set #2, Line 846:</a> <code style=3D"font-family:monos=
pace,monospace">    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_D=
EBUG to avoid unused</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">comment is now wrong</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Acknowledged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><=
p>File src/openvpn/options=2Ec:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942/comment/2=
777de9f_19b8ae6d?usp=3Demail">Patch Set #2, Line 4941:</a> <code style=3D"f=
ont-family:monospace,monospace">#if defined(ENABLE_SMALL)</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">`#ifdef ENABLE_SMALL`</blockquote></p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1942?usp=3Demail">change 1942</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1942?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comme=
nt </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 1942 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerr=
it-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Comment-Date: Tue, 22 Sep 2026 16:01:30 +0000 =
</div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:non=
e"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>

</body></html>
--ugmKJgu/D4E=--


--===============7953691452451562914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7953691452451562914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7953691452451562914==--

