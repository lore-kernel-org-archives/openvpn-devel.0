Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF16CC6B1D
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BySeLo+xwlYj9FumW1wqVe4tSrQJb+pXFrw9A0llk/4=; b=DEsom+POP0ZkgvXPWURSw8BNlF
	IiXJhVmMWYO+gtbUELzIGFLVbpkJzDL8+jlLr+5E3Iw5CPT2sbBVsPdz90DOZU4rFGCwK07su/TEd
	uSP9aupMqZrB8s/NaO0ZYCqlT+7MfSEjWJTzU1kAf4GMHwOiWjAxhDTbJ29Es0/fgvuY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGxBD-000749-8y;
	Wed, 14 Oct 2026 11:29:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGxBB-00073z-Q4
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:29:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wfOGY+v2KmmgoVNvmgUWfGOiszKk1b/wmrSxJ/JqjMg=; b=m7L3clsBGtbF4fE6Seh3p8r2gh
 5q696KZ0U8QzMdWs94g68yEplK5ftBtZancHVCWfL+KBJGyK9eis10jllkdF9fjUv/9X61BptvbAv
 SzgiZzyM4JQ2Bj1rdkbgJq1PH1owoUZ63CSMH8OLjSiknxN8gP63VMruEAT3G+h9WzaU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wfOGY+v2KmmgoVNvmgUWfGOiszKk1b/wmrSxJ/JqjMg=; b=n
 QWaJN/aHD9jfdcPNXz0P+pHbbTogcByW40g2SzjaBTO0bYWtTC3vVouobGwcIJnVtH/E/YLfxm4VI
 ymZY1MzaKMeh8XQ/s65PnYlo0AyTafPALW292Bbb9zSRCZeh/SdHeVX4BBP5szdR/PaQdUH2WD/52
 WpMNrHRhHXGHWJTw=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGxBA-0007PP-Ch for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:29:53 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso9665715e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 04:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791977386; x=1792582186; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wfOGY+v2KmmgoVNvmgUWfGOiszKk1b/wmrSxJ/JqjMg=;
 b=Ccweb2WhVU2nEG6hKtCZ1/4VjyWnTO9cBEaqDqwcPWow+sLtHH7rCF8irznhtPEIvp
 k1vIsy2FsdluYluKQ+fXkrzInJbV7Nh4lDYrBogtHfqq6Nnz77yoaQDcUVF8L9PHu/br
 0W/1PSP5GOCmm3gTXKbEsL3TomlqkZp4uoyb2RK7CTWF7++y8LTUQpTsijPeovM5PugD
 duz2PbD7oXDvoghhjwF4pkJRBFNxNY2o6hndeQUaANtOTWEYRrkNvfD/B67jRIAfndL4
 CgM5R4r1aIbyVxToGKWqy1nAlqO9RBwAq5VjOd4YAAQYx9RSoDscgwlgm5HwZd/6LlD0
 rEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791977386; x=1792582186;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wfOGY+v2KmmgoVNvmgUWfGOiszKk1b/wmrSxJ/JqjMg=;
 b=M5uSMEEEy80S+3/wxhQvRAw+7DE6OJ0hVsDkVFMqPvgdnrErHqCLtr9Ki93JTAutcy
 z72X4/VVG4h2/Df33LSZWMC1Z+xlXCbwu8qCkVlUYtHB4zs4kKfZfjrXnRbyaJJQtrk+
 J48gjMHQl+gKdL9J/s1YRZjL1k/q8Rik6K5/9/XuYvtxE8kNzkNjyXtDGrJ5ixJkYQY1
 vDs19LpG0tpnQIN7aiCT5XveEy+y0hFZkbhFSE6d1yK74oDYSBCmQl4DOKgMWoY5oePW
 fdYQy/rB+jCGktOL/rdXl2KNooh1kLsMwBDtdE7EQ0ufdvlWkzLSac7BUqBlyPHoMb9F
 g5kA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiuM0+wFEvG5AqhY9VtfZV/6uEDO2yGi2JMY2WHoyKjttMzNhhuWZQzeXKx4nfK0SciHBKrR2V2E8saxAh@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLnDJoSkfT3VhjYAZPHFE0T9RYFEuTN00GyHNnHdfnnpwpzBYfF
 7UNs2CIwIjlxtkgUmcXsRHftOnrGm3lzeVpAw5/0wnG8+DvrSFWsoP3ZlLv0/0fWRlySK0dvY0p
 l6i+b3hbgtun6HPWwKFxCXSRFQ0YPAdlJA1iNQ/XK6+85JOcPA+n+UDkg0MKHmGPY6z/y
X-Gm-Gg: AYBFou2YLS+OtGD2f8wOGxX/dACEtAU49VaJSe5Lwcp4LyMOY/s1JFkSoAuyxP4IwZL
 ThLkWO9tRTEJOSUqX3yEg23kytk/jTzu7T8fRIA/LnyjK04V+kRFooBqBceOAG9dOKAbljMTYO1
 nw7FnP6Bpd2cmROIfKoTzKFZ0o5i0WOGtGala0695dPQzkZRhDzU4P6Wz9p/gA47EwV3JgL76wI
 hQA61sR/WNYtVZrpxPyZf7GiS+3eyRxkAqyMplTKd2y0wzq+NANYflu9nIu5TTQsmQW87Pfo6GH
 UY6LFrFw7NY4qRl0vbEpTvarhTazCiLWPjwzKDTCcN2o6sgFb+8DdibQw9+gH3zsGN/nYWrmkpH
 ReUnQjRlRUlCyQInG+xQG/YuMd+rdI4bGamW9C5dASVe2WQklbRlDVGQ0l+2o2QGHEh5BLZbv9N
 swXi8gIlXNT72amVS5hFBsWo3aifhoxpfGdOwl4gvn96dlVWva6HweXe1K6866RY0+8dYe9jq1D
 GLvMXhBDkMCjvLRtgBo9uP8fckU4fYfH7VqJvDCg7tOkhXK5ad/0uc4kEauWr50lZ2TzX33huFH
 2SDFIzxIUlJFrhF9QeRRF+GnY0Crhh97KrbJSLSnB0pZThQyOzkRWiLqUIxZxQ==
X-Received: by 2002:a05:600c:8b64:b0:49d:174e:2a1e with SMTP id
 5b1f17b1804b1-4a18e498851mr327614365e9.19.1791977384706; 
 Wed, 14 Oct 2026 04:29:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a199e5db12sm346456005e9.2.2026.10.14.04.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:29:44 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 11:29:43 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I61e29dd2af9302b240c93735179d43c72e37b335
X-Gerrit-Change-Number: 1996
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1996?usp=email>
X-Gerrit-Commit: 5fb74caaaf6c7072dd50d05a84275d462e04cf1e
X-Gerrit-Comment-Date: Wed, 14 Oct 2026 11:29:43 +0000
In-Reply-To: <gerrit.1791901394000.I61e29dd2af9302b240c93735179d43c72e37b335@gerrit.openvpn.net>
References: <gerrit.1791901394000.I61e29dd2af9302b240c93735179d43c72e37b335@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk2MWUyOWRkMmFmOTMwMmIyNDBjOTM3MzUxNzlkNDNjNzJlMzdiMzM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2bedb8f95c67c18376bba2f6bb24154a56168b2d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGxBA-0007PP-Ch
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Replace strncat with
 strlcat
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0811693648205019333=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0811693648205019333==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rieIlk4bLMQ="; charset=UTF-8

--rieIlk4bLMQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996?usp=3Demail )

Change=
 subject: Replace strncat with strlcat
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(3 comments)

File src/plugins/aut=
h-pam/utils=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996/comment/7=
32262b6_10070ac2?usp=3Demail :
PS1, Line 75:     char temp[templen + 1] =3D=
 { 0 };
> This is a variable-length array, and C11 doesn't allow that, so G=
CC 16 rejects it: [=E2=80=A6]
Done


https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1996/comment/278eac39_89b3cdd2?usp=3Demail :
PS1, Line 83:         mem=
cpy(target, replacewith, replacewithlen);
> `target` isn't advanced after c=
opying `replacewith`=2E [=E2=80=A6]
Done


https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1996/comment/60fd9ac5_4193ef20?usp=3Demail :
PS1, Line 85:      =
   searching =3D scratch + tosearchlen;
> Shouldn't we use the length of `s=
earchfor` here?
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1996?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I61e29dd2af9302b240c93735179d43c72e37b335
Gerrit-Change-Number: 1996
Ge=
rrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Comment-Date: Wed, 14 Oct 2026 11:29:43 +0000
Gerrit-HasC=
omments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>

--rieIlk4bLMQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/plugins/auth-pam/utils=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996/comment/732262b6_10070ac2?usp=3Dem=
ail">Patch Set #1, Line 75:</a> <code style=3D"font-family:monospace,monosp=
ace">    char temp[templen + 1] =3D { 0 };</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This is =
a variable-length array, and C11 doesn&#39;t allow that, so GCC 16 rejects =
it: [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1996/comment/278eac39_89b3cdd2?usp=3Demail">Pa=
tch Set #1, Line 83:</a> <code style=3D"font-family:monospace,monospace">  =
      memcpy(target, replacewith, replacewithlen);</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">`t=
arget` isn&#39;t advanced after copying `replacewith`=2E [=E2=80=A6]</block=
quote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1996/comment/60fd9ac5_4193ef20?usp=3Demail">Patch Set #1, Line 85:</=
a> <code style=3D"font-family:monospace,monospace">        searching =3D sc=
ratch + tosearchlen;</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">Shouldn&#39;t we use the length =
of `searchfor` here?</blockquote></p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996?usp=3De=
mail">change 1996</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1996?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I61e29dd2af9302b240c93735179d43c72e37b335 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1996 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 2 </div>
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
v style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Comment-Date: Wed, 14 Oct 2026 11:29:43 +0000 </div>
<div st=
yle=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In=
-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</bod=
y></html>
--rieIlk4bLMQ=--


--===============0811693648205019333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0811693648205019333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0811693648205019333==--

