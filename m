Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C72C98311
	for <openvpn-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a2YUN7e6qvaIrJoW135w4H6W4TpWpqoABW5u1/lZ5xU=; b=gIxcP+Uc+5rtRgFYAsSCY/xcFH
	PY+LjOCpm4tn92kWQ4KOr0wbInp7huRns8s09awUfwms9737u0fwkdhwGJ9zTgknGEsYKBLromUph
	O96eflyGUa0xcctS9gLyNsGswR13rvjouRr5/4y/A0REb2kSdR2NeMZnTkQM8trkoro4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9gtm-0006cP-2N;
	Thu, 24 Sep 2026 10:41:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9gth-0006cG-DD
 for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 10:41:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=PXVMhme04LeanFxhvh2M9+5R4W4mXc/WPXW0NdHTm50=; b=TMiDcB+YrvrPYnT4LH8OgN4LHc
 xLgBDBjcABAeC40er80VYACK004xzSizwDRFpdPncRDkKwGmTAcHBMKxUpswhiTEJvW0r+Uu12R6b
 J0EDCn09ahwZL27WLU2rN1O1M1gf47AeTWOq+frdR+IBhYiNqMgrxNn9Gss9wlpGrFi0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PXVMhme04LeanFxhvh2M9+5R4W4mXc/WPXW0NdHTm50=; b=J
 jLrBuHlNJzvHFTd0X8oPWLR3eXSIIcgLwzumDcnrfRUQEVJNGyKRENQ4sSkf/LaeEPpnNoQQZbEXR
 xoBEeo3WjoINuhoZ5BNOn57mdqildaaBS8OR6bgYKWw6gLsJ3BboVIIHbfWQSsUL8SXN9bn9mlORy
 dUZYLjSTe5KndU7I=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9gtf-00048K-5t for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 10:41:49 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843796e373so1274636f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 03:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790246500; x=1790851300; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=PXVMhme04LeanFxhvh2M9+5R4W4mXc/WPXW0NdHTm50=;
 b=JDBFAAP+TOjPQcmq9wLWPUWdVT7KI+VRkNmZXWUfy4WJB3zFBrB5AcuD944T26I2lN
 z8spUZyyIAv00UngRH/s9Cd+KBD8ZfoJsxPWfurSO9JKViC38PWpHSoNYTKdGLy1+9sg
 JvnyMUs77lTvI6q2gdAaVlP1iqJrP7IuYc7Jv9PXV6pSQ+yXPVYi4VFzHp5si0KkgR9z
 2z8u+WBvjhlMzfAic0/J/w/IZ36Tb3A/tVT++T5rneVEr81TMfiK4t7sA+CKFOTD7QQ4
 9ehaPw53mvEXihfSXqI4cmaCVr+Pt+qfarYV6MM1CCvO0UZX3Aw0/AslpnXa6yrLTSZV
 9KsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790246500; x=1790851300;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=PXVMhme04LeanFxhvh2M9+5R4W4mXc/WPXW0NdHTm50=;
 b=ydNwUXU81nAfAFR27olu9Xj2XEbD+Slj5atk8jqzrE+SUeM7rms2Bmo8bkMvSKC0zn
 Sp88m7bkTYqCwxwajac1JqE/womANU0Cor+hTlWQcbUnkKXQ4F48WXB0JUqD+l9qZWbZ
 0pf9EVw0uYT/75VqC0IWCTgLLRK9c6c+f+SLhkwcXt5cDsoGstaafzm6tAeEbf7nKyva
 yOvBj1ciTzvLe6aoAbo8WhxddhxHWNrdRInie7caT19I6DYLNMLlt5X/cRg5NoRq81XG
 qBN3cnDtq7nbRkLNC5v7zwNVrLupAA1t09K4r99539M6FwVG7eiDWss15F3205KtC/yZ
 2seA==
X-Gm-Message-State: AFuF++l0KHpiBkjaUTxKzx7/J0FZxAy35TBWJbedNWCEQVEBO/RHR8GU
 bv2OyEPKOJHgs4FYG18AEikMf3d2O9snpyKFHmglhFBYTj0tV7htbjHlbO275HjgG+4M/WeFoYg
 v6UcQkiyIDpdU76/Xsty/hPC2N7Wx9cu+/AHAOwzOBkdgU4aKhySxupT5tiYG7Ozq8Hkg
X-Gm-Gg: AYBFou1DdBhY0aOk7c5K0jid5eq6kDpS4YHpeUdHw/7449CghwAPwx/7vIQqi/p0KMc
 zfvA2HiPjLuzrLroQhB+1LVzloko5f+GsEBQgTewaGYzwMB6gsWvsolzaQEY6kLOcPjnrhRzCaQ
 /+dxRVotdpbnTJI+RsihbEhBtHWJlmfSbY+H0R2kXVyoXjsW0o85KV4qg/P+TNAPGGOHCcQIhLG
 rVQ2gSqxpLX+jZKmB7eDWZsMquzer6ELUJrRIIBSLrzFFVjX06r3iK6TamrAECqsPIibyYruaTg
 w8JRHEZ6yPf8BTW+pmmRTE6VheQ73zpvJEj2WcHQ2iZ+4UK9G0Oazy0QE8P8Z43L65n/lujWcfg
 5sbdmKdDYPqOYLIJsr7cWd0iFZFMU5zUg7Ab0K4QU1s/lzctdmA4QRs/oJQkY5z4GQcykARSP4C
 XIRMkF4jpefxbCkvI8HHSdGyZcXEjOfbK4VlK7UlMFo31OQHONDofHfLboimi511RYG5CDrOTYb
 WSQQ77OtqaovBAVsIw18+XSO6LiOPn7Hc9jZgiebqB2Fbe/Z3nnu9xTIq/Yl/aQYmZsBOfqSkSI
 ddSw1C7Q3uDR3kIGOleT/pAES5avLcV+I0SdJN4xqWf+yRO1TGImwkNMTgQ6
X-Received: by 2002:a05:6000:4285:b0:485:8fb2:b8cd with SMTP id
 ffacd0b85a97d-488716b2917mr3655978f8f.6.1790246500439; 
 Thu, 24 Sep 2026 03:41:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886877a247sm14185994f8f.28.2026.09.24.03.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 03:41:39 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 24 Sep 2026 10:41:38 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
X-Gerrit-Change-Number: 1942
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1942?usp=email>
X-Gerrit-Commit: 61ec725bc26e80622b42f983253dda74bcffa763
X-Gerrit-Comment-Date: Thu, 24 Sep 2026 10:41:38 +0000
In-Reply-To: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
References: <gerrit.1790079868000.I3f96cd1c3488b558b8a597594d99edcba1214d27@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDc5ODY4MDAwLkkzZjk2Y2QxYzM0ODhiNTU4YjhhNTk3NTk0ZDk5ZWRjYmExMjE0ZDI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8332bf9f680e8a1ead9948894fd3ff85defe993f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9gtf-00048K-5t
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2657642659653647262=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2657642659653647262==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UPoQistlMyQ="; charset=UTF-8

--UPoQistlMyQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1942?usp=3Demail )

Change subject: Change most ENABLE_DEBUG ifde=
fs to ifndef ENABLE_SMALL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 8: Code-Review+2

(2 comments)

File Changes=2Emd:=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942/comment/581f6523_7f26d455?=
usp=3Demail :
PS6, Line 29:   available and the verbose logging is now alwa=
ys included=2E
> "always" should be "unless --enable-small is set" ?
Done

=

File src/openvpn/forward=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
942/comment/ada0a61e_7fcbb944?usp=3Demail :
PS6, Line 78: #endif /* ifdef E=
NABLE_DEBUG */
> wrong comment
Done



-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1942?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I3f96cd1c3488b558b8a597594d99edcba1214d27
Gerrit-Change-Nu=
mber: 1942
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 24 Sep 2026=
 10:41:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-R=
eply-To: flichtenheld <frank@lichtenheld=2Ecom>

--UPoQistlMyQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld has posted comments=
 on this change by plaisthos=2E</p><p>Patch set 8:<span style=3D"border-rad=
ius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-col=
or: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1942?usp=3Demail">View Change</a></p><p>2 comments:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File Changes=2Emd:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942/comment/581f6=
523_7f26d455?usp=3Demail">Patch Set #6, Line 29:</a> <code style=3D"font-fa=
mily:monospace,monospace">  available and the verbose logging is now always=
 included=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;">&quot;always&quot; should be &quot;unles=
s --enable-small is set&quot; ?</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/forward=2Ec:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1942/comment/ada0a61e_7fcbb944?usp=3Demail">Patch Se=
t #6, Line 78:</a> <code style=3D"font-family:monospace,monospace">#endif /=
* ifdef ENABLE_DEBUG */</code></p><p><blockquote style=3D"border-left: 1px =
solid #aaa; margin: 10px 0; padding: 0 10px;">wrong comment</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1942?usp=3Demail">change 1942</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1942?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f96cd1c3488b558b8a59=
7594d99edcba1214d27 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1942 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div =
style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu,=
 24 Sep 2026 10:41:38 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </d=
iv>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>

</body></html>
--UPoQistlMyQ=--


--===============2657642659653647262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2657642659653647262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2657642659653647262==--

