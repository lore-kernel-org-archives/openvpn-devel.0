Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB27CA5FFC
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 18:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b9Ut5iwzefAseaqOsheE+a7LwvlT+ihcftxMTLMqq1k=; b=R5VtooXfwz8qRF2c+Vyo1YpLlZ
	D84LXmRVQqGrhG1g41KjX0kNan9JngUW99vm4rPxT86UCpgEdGllYCgN0DDIc0yxBLgDOkre+qop3
	ikXOES/ETqBJ6zvGnimjUVSJS7+To5q8ll1SHwrh2978h0/Y0F8egAnXOM/BpBRHUacg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDnLG-0007Fg-4J;
	Mon, 05 Oct 2026 18:23:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDnLE-0007FZ-DL
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 18:23:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=SLWdMdtsk1Al1RjPZBbCJp35YQtH3H+bYwCaJkjoHLc=; b=fGAyX+FR3CXIwAC2rah0Gg8FWO
 xJyGUEb5R4pBYYAsZr3QF4nmNT6C3cynHni2H1SEscqndc2G5L26OZpPaQWr8w/rrvgS+YAwJz5ij
 mzjeps8Dge0DXO1/FV8aFrKKtKVBQ/wB4+Ak7jHb6XQXtvX/V+ok1Cz3KyTmmFS5bp1w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SLWdMdtsk1Al1RjPZBbCJp35YQtH3H+bYwCaJkjoHLc=; b=Z
 VPU/+HRyaisKzmJ8295WGV/t9hUi29n3C5s9XvzTKYSVTjwLV+LCb9/bMJXgZjFsWXsmGtevng6kp
 UY04r8BGmtoK7Nhp5+pnXzPjG3335SvlmHvuYALHhleY9zdfmDaoxASa4soVwywzb8gaA+VcJAQTA
 wXUGn5dIJrxauzLI=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDnLE-0006si-41 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 18:23:13 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-4a1706a2b24so10693795e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791224585; x=1791829385; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SLWdMdtsk1Al1RjPZBbCJp35YQtH3H+bYwCaJkjoHLc=;
 b=USISEraWy65HFru0Z8HCwclHG0v8gb3LzBDbKby6IaN1sfNsJ3NHZcwU2GEmN+Pqi2
 Z88rSqRZmgHuz7mUVbX++PjOkiLrEb0cv/yBhAOXtO5rkjqXmQ1e7MAKpXk3QRRW/zfm
 jVuhUSOeGfp9fzQ9rfugddXINjiVN0wjHahLgCvLzo0vHkcNGFgl5ChGl4Ls7aPZoaQe
 AoPJ1y1DKbWEg+Ua7cFwtYVhGQuejkt/6iUnMNGeHw1cyzKYNBoe0Lprh1reL3gPEgkV
 delXPvsgFZK+gC0FjW4xRVAoJzeD44AmA5Oc5gyZLNY2ptwBLJsYtiewccTFVydgsXyQ
 F55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791224585; x=1791829385;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SLWdMdtsk1Al1RjPZBbCJp35YQtH3H+bYwCaJkjoHLc=;
 b=rNcPQni2N1zyCihAlE6hSkx0Rbq2K6ZRSrGkBI3JGtMZuML/3a/4vTDaVreyxXymN3
 IonyuwWbeLpztI9LZO3NOG9ksYzlKVTAYYOxVFWk1chlpf6nFK8+H94h9Hv6TCKkSPZ3
 rKciFesLVsznaYLSBRNuvnhD5JiIB4i9FjRYSYZMhj892mIPSfG3qqAIH5PxLLo8FG4+
 GpX/QsLotlHRBLYackZNlTk/KloMgx6cQgajVdbBmnYmNYOT4mWWSfDbdG1Ja58JzMWe
 Jm73V72p7JVcXce295SZjNshjWObRBjrZOQVqwn7QZ2y+qjVQqfoMpid3WkWTJzei5Da
 Pk2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6E8YdjB/gdku47QMtE2clsd+qVTzkfmDvFLPq0ks83QkANUiOQrN5ByRLjAJ/qYgcPE2rQmDNA71r+HNM@lists.sourceforge.net
X-Gm-Message-State: AFuF++l6I+t5Jj7s0cHFtTy0tdr+AfQ32PdBzy77DNMe8DNzCD4kMdVw
 Gwwy5L0xVfCHvGEDuPiUMT3VbOnlvBES6GoGO3IRH8cbhwLf9kJ07uRo9c6gbj61NzxcfCngd9H
 2Hag4af328AGcA813b8LTMX/hOtbmYQxoTNAfoI/EzPec66sD5m9+4XxW7Jet856kimvy
X-Gm-Gg: AYBFou29kF+8eVP16iFjHP4SRxhGFVih11CZDoINHcEYMnmDv74FFd/ZEv5jza78iAA
 FO1qR9//zFIXXlF2MvscdCh4/ue5iYlJsniSwYBL6iWVTBFz4Egk2go25XL8YvsM8dQfRhpK2Ig
 rr9z6u7SVIB4laBVgIPSYF/W2qAf0YzIJeQZrbCy0swAlpJaNxcUU8DsL3AzoE7clKZxrHj/p60
 slKEWxghxSXwHhQfXgPajbJlVMOtPQ6lPdzcLn03fyiUWxL2XNgI9TejwNK5GH+wF/INYEjIRvM
 Z0LlzB2P0Ldun7JzgCFCOZpwJ9wPPyR+Xi+7bjWn9UiEA+3suTpZY4A9GBQg2dOLYIt5OcAuCLz
 79iaIvS1eLnleQsSCgO2u51068HKHhESj7aqFJ45qtdQaDCFzUOVwHZDdCxNhYpBs4OL496kZI0
 DHgEHTD7MBs9dYnPjv6GdBA07oW41pjf1c0AQGPiUunHp8SqXJgMpjGorZbnPTWs+mqL+USFmkU
 TW08pDtEBFjj7c8+MCUwULLVVxK9dIrR3mAi9R6lDxK9kpevRZp/jhvxq+12Fj+dO2GeXm/1L7I
 /BiAwjcnWJJz6uXC8scOPKP5A2OfJgHaFzQTOHku+24pZe45gygWjC5niawCvA==
X-Received: by 2002:a05:600c:3e1a:b0:4a0:1b15:8852 with SMTP id
 5b1f17b1804b1-4a027559e29mr192324515e9.16.1791224585447; 
 Mon, 05 Oct 2026 11:23:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178db09d6sm10459875e9.10.2026.10.05.11.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:23:05 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 18:23:02 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 29
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: 16fca091150b2954a89c7140f846c21189372008
X-Gerrit-Comment-Date: Mon, 5 Oct 2026 18:23:02 +0000
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <97c02cb1ef1df71001559071d9d9f4f69b5a5185-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDnLE-0006si-41
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
Content-Type: multipart/mixed; boundary="===============8113632161251134493=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8113632161251134493==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C7/E4bmVc+M="; charset=UTF-8

--C7/E4bmVc+M=
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


Patch Set 29: C=
ode-Review-1

(1 comment)

File src/openvpn/ssl_mbedtls=2Ec:

https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/e48c8e81_220c4b0f?usp=3Demail :
=
PS29, Line 272: tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *c=
tx, const char *ciphers)
This hasn't changed to non-const and breaks the mb=
edTLS build=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1663?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5=
6248cf6d199c2da770774b8fd1e5daf2b116f58
Gerrit-Change-Number: 1663
Gerrit-P=
atchSet: 29
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Mon, 05 Oct 2026 18:23:02 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: Yes

--C7/E4bmVc+M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 29:<span style=3D"border-radius: 3px; display: inline-block; mar=
gin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span><=
/p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demai=
l">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_mbedtl=
s=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/e48c8e81_220c4b0f?usp=3De=
mail">Patch Set #29, Line 272:</a> <code style=3D"font-family:monospace,mon=
ospace">tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, cons=
t char *ciphers)</code></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">This hasn&#39;t changed to non-const and breaks=
 the mbedTLS build=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">change 1663</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I56248=
cf6d199c2da770774b8fd1e5daf2b116f58 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1663 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 29 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Mon, 05 Oct 2026 18:23:02 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: Yes </div>

</body></html>
--C7/E4bmVc+M=--


--===============8113632161251134493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8113632161251134493==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8113632161251134493==--

