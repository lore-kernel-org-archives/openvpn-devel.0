Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110D2C88E53
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 09:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zqh+Ih3XKmVSaZKjR5OkPCsNSK7M1a3SF9mi3iboLTw=; b=Y8g5+yiwYPUQ6ZlR7vfyguxyh0
	D8soQEE9cmolK4/hMp8Og5zmsIxNye4h+5O3HXpcJHETFgnettjXaNrjTNlYmBr4saHdFqo6zLDyq
	4kRDtPRD8JtvgRT8KGXNfX+2nPYcbkmPdmAZBdsGDP12L3G1Bzm9xDby/zrqo7ZG0D+8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6Pwz-0000da-BC;
	Tue, 15 Sep 2026 09:59:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6Pwx-0000dO-SI
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 09:59:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=E/ehz+PNuQtJjIU1GyoNyh7lEVZ6Nv/ISQ9ZyCGyCJE=; b=nBQwi/v7ga5PPQGxpMxDmLUf9+
 DzlPlziC4iVvAOWe0dIN8SgeVpI6H4rN6wvVDlae7+Y3a4y0zSEQhuDB/xYcAF2pZWK+b4Q5Esnz9
 19OozlvRbntHxcTGv5xCf7mdHu7mav8pB6KhHBrf9kyWrG6ZCJcx4FyMh1cbgFSWWf94=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=E/ehz+PNuQtJjIU1GyoNyh7lEVZ6Nv/ISQ9ZyCGyCJE=; b=N
 acfhnY0zKujQP1aVQ8hYljl/vKWMj2YCBdDgCk48ia0IlPUjfUkf92Yug3Of/le3u/iebk/NLsNgD
 Z1h0bFfZ7isCu0ilKD9diLOjKbaHvI1ywcLiekj9nVA9gxpCuWwBym9/GdBr09zI7k7mzG3JPgX3g
 PpmhL34MspG7wTEQ=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6Pwx-0002uV-O7 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 09:59:40 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48437356d60so52239f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 02:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789466373; x=1790071173; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E/ehz+PNuQtJjIU1GyoNyh7lEVZ6Nv/ISQ9ZyCGyCJE=;
 b=TcxkaMtTAEOch2ItSetgVpW130PHVbCB+tjoty+QyQCnhWZSKT0bpf6HdsAWXOjsh5
 gP07Ko30FOq3A4SiT81bMN3gN1BRyyv9+58zSRB/2s1LvuLl+gi38x4VrzM/qMiDoa1n
 AqpiptRu0PLUcCxurbL3CDlzGam2eypjfsiKe7LhdYLhRdHdivtENHOgIvsTo3fLCwEs
 7x8zbhcS3P45pbUH2lu9AxIo4k+3D2EnTnG9IeZGVVw27YX/FzBVCs9ej2YdKYSzrn+j
 CapwVyd2VTuQXUIt+eFwn6oExFYOSWcF83DXl7l1xSub13DF2S+I1j3Jk45KpzEGUUYz
 oD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789466373; x=1790071173;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=E/ehz+PNuQtJjIU1GyoNyh7lEVZ6Nv/ISQ9ZyCGyCJE=;
 b=xwh4tFGKu76OW4pyBLm0eClSSMKOHzQiOOLGFpe93x88fop+2qJa+OPDCfZtQJnNIE
 PV2a/P5FPcR6FFxqhifrlEMASsz96U+otK64g6/yVRXZhHF+cscagUekZFfaPLE2nyp4
 /9qqLfRAevGdJRgOODQTJmkPwA1okdvS7CWPcqTrpKEfv0PrAymR5AEmS2Dm2L+hVZsU
 hsELlUpc39EemS0b4d2RUh4rNDS4wIv9NLohQX7UcbYZhB3c8vft6z+aG40JgSLnBE44
 pVEOaUUHxZfyRcZW7HbVkDIM5Dfa08jY5OnhN7XWo9egGTD2Yfrgj/AeJL+MaVZMVD20
 d9/w==
X-Gm-Message-State: AFuF++nOkDwHJkePLJBv0oqPCMI18iZkVL2zOXpl6GaikjQyiXyNEcvp
 oqlm0zLx2W+rb44Er+2I/5KCCnUFsErwWKcTLI96TqCqbFx/cA1Um0V5rLShlQLEDC783L+g6+M
 mFVH2lo3LYlhT8CeLs/XaZ6hxY6QpNaDAUdgXHUxS++8tgjT79GzIT0N7lv4t5GqxBU7wUTT1Da
 ielywiAA==
X-Gm-Gg: AYBFou11oLhhPMQsUTCjR5QvavR8WJUKUQys7fArJX7o7RU5PwsFiZTKIqnVDm5qRat
 ld9SScp9acwJXbuFJFjbfkaNAo2KtMD4ZNOFZUvFnUXwEvfyr5Pqa9/pXTzpyj06Or3RMpDl+sw
 iASlQNz7DNgulOfoWDLpvBE/h72KnAXNyTT5HxySYsozwCkMVOyUyZtmOT7hJ7Y8TTgLJbFVklc
 3RTDCOVTInqsC9fLH1bcV00NUtPIAWu21ONdEHq1uV7xtNHnTf5IMxF5QKmdC11yy3WcgHiXJ2f
 pRc7hQSRYVCErj3tbdsDd0q/CDNU9QAOT5MYlwXcWVwQu11KvtotpAsiy0me2HhQtd6O+tejhzJ
 lC17p2m4lgA97M6Rs1ETB6hPXthH40Zr+8Q/pDglUJlbgPMp5mH3+cvW78a83IDH5tmJtKg8kOj
 Qp0Wn0tgbGh0QVVvrTDbrzENZ5ZjIg9B7NO0suUhaCraabQAiyedo1LBfgRQNxyzFS3NRS0zm4l
 uw/91p8IRNY6RPeHNCp7aVl0sI2LaRSBlXmSe+QRqhCvoUsNHrZ9iAkiaA4YQ4KlV7p6Fabc48Z
 6UzKVJ18rFM8Binh98NOP6tJKi2IgLwp+C3kpbRK9Lg2EY2uf2ims+bSye9RwC0=
X-Received: by 2002:a5d:6f1e:0:b0:47f:e377:8d61 with SMTP id
 ffacd0b85a97d-4870a94a139mr49658f8f.11.1789466372986; 
 Tue, 15 Sep 2026 02:59:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48707e00133sm3454199f8f.11.2026.09.15.02.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 02:59:32 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 09:59:31 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4
X-Gerrit-Change-Number: 1916
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1916?usp=email>
X-Gerrit-Commit: 65262c0afd5095fa68f320d23fdacd1b8c8a8e92
X-Gerrit-Comment-Date: Tue, 15 Sep 2026 09:59:31 +0000
In-Reply-To: <gerrit.1789456688000.Iac6d49d064215510bde9a4cd4600ab3a50a45cb4@gerrit.openvpn.net>
References: <gerrit.1789456688000.Iac6d49d064215510bde9a4cd4600ab3a50a45cb4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NDU2Njg4MDAwLklhYzZkNDlkMDY0MjE1NTEwYmRlOWE0Y2Q0NjAwYWIzYTUwYTQ1Y2I0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <18bd0902b9ba1f175ac4b2408f2c326e021958e8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6Pwx-0002uV-O7
Subject: [Openvpn-devel] [M] Change in openvpn[master]: ssl: do not trust
 the peer's request to resend the wrapped client key
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
 lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7493034410792729522=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7493034410792729522==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Xy230QPBBxg="; charset=UTF-8

--Xy230QPBBxg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

plaisthos has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
916?usp=3Demail )

Change subject: ssl: do not trust the peer's request to =
resend the wrapped client key
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(2 comments)

File src/openvp=
n/ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916/comment/28bbd6d6=
_fa5ad272?usp=3Demail :
PS2, Line 2625:                      * promising a =
key we do not have=2E */
This is quite strangely written and talks about th=
e client itself in a weird 3rd person and does not follow our style of comm=
ents

```suggestion
                     * Only accept the EARLY_NEG_FLAG_R=
ESEND_WKC flag 
                     * from the server if we are configured=
 with tls-crypt-v2
```


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916/com=
ment/2649fc5a_7c021f6d?usp=3Demail :
PS2, Line 2685:            && session-=
>tls_wrap=2Etls_crypt_v2_wkc;
I don't particulary like mixing in this condi=
tion into this condition as it now does not really match its name anymore=
=2E Either rename the function to something better like control_packet_shou=
ld_append_wkc or move the check if we can actually append the wkc to the ca=
ller and keep the function name=2E

Also it seems that we are actually chec=
king for if we can really send it with the "                msg(D_TLS_ERROR=
S, "Could not append tls-crypt-v2 client key");" key that then also properl=
y reports an error in the log instead of silently not sending the WKc key=
=2E

It feels like this change is better to be just dropped=2E



-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Iac6d49d064215510bde9a4cd4600=
ab3a50a45cb4
Gerrit-Change-Number: 1916
Gerrit-PatchSet: 2
Gerrit-Owner: st=
ipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Tue, =
15 Sep 2026 09:59:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--Xy230QPBBxg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>Patch set 2:<span style=3D"border-ra=
dius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-co=
lor: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1916?usp=3Demail">View Change</a></p><p>2 comments:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916/comme=
nt/28bbd6d6_fa5ad272?usp=3Demail">Patch Set #2, Line 2625:</a> <code style=
=3D"font-family:monospace,monospace">                     * promising a key=
 we do not have=2E */</code></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">This is quite strangely written and talks =
about the client itself in a weird 3rd person and does not follow our style=
 of comments</p><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">```suggestion<br>                     * Only =
accept the EARLY_NEG_FLAG_RESEND_WKC flag <br>                     * from t=
he server if we are configured with tls-crypt-v2<br>```</pre></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916/comment/2649fc5a_7c021=
f6d?usp=3Demail">Patch Set #2, Line 2685:</a> <code style=3D"font-family:mo=
nospace,monospace">           &amp;&amp; session-&gt;tls_wrap=2Etls_crypt_v=
2_wkc;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">I don&#39;t particulary like mixing in this condition int=
o this condition as it now does not really match its name anymore=2E Either=
 rename the function to something better like control_packet_should_append_=
wkc or move the check if we can actually append the wkc to the caller and k=
eep the function name=2E</p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Also it seems that we are actually checking fo=
r if we can really send it with the &quot;                msg(D_TLS_ERRORS,=
 &quot;Could not append tls-crypt-v2 client key&quot;);&quot; key that then=
 also properly reports an error in the log instead of silently not sending =
the WKc key=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">It feels like this change is better to be just dropped=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1916?usp=3Demail">change 1916</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: Iac6d49d064215510bde9a4cd460=
0ab3a50a45cb4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 191=
6 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Tue, 15 Sep 2026 09:59:31 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Xy230QPBBxg=--


--===============7493034410792729522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7493034410792729522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7493034410792729522==--

