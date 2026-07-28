Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61129C53219
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b+YAnnnukt9THR5nbch//mcDGIZfn+FhWgjVmX+cHkU=; b=T2tIa07/gCIed+3IXdp2WBItqi
	PS50nJBmhDKkovjf8+mPxCLNSedmmrCM3d/sZkYq0z6QRo7ZKi/PBuH6KZKmsqNsX7GcrEF80179u
	PEOQj4jSMLoyDFTHrlcfgnEpbsBdmQhJuPF2hMiZsKzoHoRidLSAaBeF6Y1BViGAUGmI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojNM-0001xL-Jp;
	Tue, 28 Jul 2026 15:05:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojNL-0001xC-Sd
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:05:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=maj8iZ+7FKVdLxJLfaLKNQ6/zjchQu1u4FhGTMMsX0k=; b=maOC5Wffy3oq5OvMqsJrWhKe/S
 Sh5NxEHtANlcvf8hI/rOucl6/EMksKEMxSThjbwZs+RCGOiv30mua5B3GWQ8U2fQL3J+XT2n/9rSK
 M/VuromlJxH4xh7lpXwsEPN8AZQA+GAtSgdulpVlbY5k/a1eYpO3MzCZ0TQqlXsEjEl0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=maj8iZ+7FKVdLxJLfaLKNQ6/zjchQu1u4FhGTMMsX0k=; b=Z
 /sgBvgrnWfLUd35lO6+QuvYG3R9ucgWkcU9qqOwVdXfThgOv0fbV9pbHlC9boeXtBBKHeLESs+hTZ
 LMh5eVnyLZg3gKCId+Fy+1O7y51+RoN+nKxvq7h2KWBKp1jVY+doGMpGiqug0qVqc7bA6H42WHzCe
 FvLs4DAbOL14SCmg=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojNI-0000Vj-5p for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:05:48 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f707e5d75so2727487f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251138; x=1785855938; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=maj8iZ+7FKVdLxJLfaLKNQ6/zjchQu1u4FhGTMMsX0k=;
 b=hHCjBzoGldPfNzlvXt42axFOD2Xx+BjD7O8DpPPjK7JLZAtMRflAtZ3QdkxA8G6TDc
 /AzkmJ5tlkqow8h4pccVwcCM8ZlHQS44dDFWd8lOvZg/Wnd6+LEvc6C+Z+rzsXqDq56j
 0tTCpmvOuDBrhe1+PJ/eFxWfzziBAckL/ShTdzJ+Ej46IfMbGTif5c4cUeMslB8YEbU/
 4O0/tt/hnBe7sxmfr2k0d6xRYKYmU8YukhiMBFHfwT8wSxoUsaBy0TWY9Zcbrn6aKnnJ
 k6PsjUr0Wxp4Jx9lSjJ3+9GUiujLS+BHv9+H9M8FpUg+M60qY92FPFvW7OoIAO8N+JKN
 b3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251138; x=1785855938;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=maj8iZ+7FKVdLxJLfaLKNQ6/zjchQu1u4FhGTMMsX0k=;
 b=WvuaHpiihbeLNb/hKyRsRflVQiB/0VyOYsdtxHoQj4qrdxIp6NKcy00d6+kcIPQmWF
 B9Gds+HoeAWulqaoSuvMr+2+nFWxfY2DZouOlPqU9LlTZrWxaclSLSila/ZRoSltvjPM
 MJ6GQr7vhj2sKXt5lhP0+Nn5ZE+fvLpqlemXEbnZ7j7FLjtKPDQWorFN+4OeWf9jHVdm
 s2LoVR0+5Nxr3CJBJDdVl25qmx1bi6Vc+t+Hfkf57aL+7ce5l+/P9XR5P4H4zaqPlHeB
 8exoLhG3YwPm/+UQO/IZf/19VxRe9assw/VjkjFwm5E+I31RlJzB9P35VK+4Jxix55wj
 J+/w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUxsllZhkFIcWPY1k73pPO3VKlaUzis/is68IX9xH1/0JSQYNmQfIwBFTsJCAUdEHGdaWO2q0I/D1YDRNH@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxiXyMSnyDC0DesRuW4L4UTbmVpHQx5uD47QvhAnGozYkRXBNzO
 B+j0J+lNvL/9VkmQThqQDeX6ZTQFH8q+ZQar3J59gwf9NORKyyhM6UkhxQPSauStuFMlYU6lN/A
 GnCbytHUjgi2Vapk5GeMWM3JZK6ZgicAGaV/JM0pLmV0azUQwQQis2goIV3lGWMu7EUQv7sd9f5
 EhXkJAsQ==
X-Gm-Gg: AR+sD12oG5DuR5OL3HeNw+1ZqzETWEuGe61W2xEReX6PCE4MxLOshvzPcZQGQ3+tRnW
 VgdY9xBMXbL7elwLxfZaQyGpjEXUAv/9YSdTcu2CIAykSMLw9PQEoZiKv6Em2dJAN/VXhcMJpNZ
 d70s2o68DGusJTMHryXRzqe6a2+ir0b5rDFfKiOquYL5xG39jpvpUpIZ0E2YOY2CLLPtqzLZIzQ
 sYL3vonPR2wkS+EWottRse39J4t2NNIVgXM1/hR+VyIqqZcS9nJM/qGlrBQHY3uoaMWV1nT+Fgj
 Z4fOluB7W2TEZAuzap+s5RiNyhBShgTOPv9OmalPt6L9XyEH1GqBGPU6CyxnpUV826eqsYPLWxi
 j4tbSBEoY92K0Hef1Ilu5f+z3Y/wui8nKxMHkzfMXmjAevQeHdX/NiSP0CzoexYmzCb3UAx8Nmw
 xPxQhhth3jGpMP0WHSeC+PICmYbPaSDuI5CJoj1EQqaZ8lXPH2fGwNhOVqMshvvhnIVXr+I1ix2
 iZpd3pzUAskjrtZcihssAWkQX28DgakSPtOFJ2u9AFayaUecNkIg5YvFYHFXHQKSJjV
X-Received: by 2002:a05:600c:628b:b0:495:441a:39d2 with SMTP id
 5b1f17b1804b1-496c658ef4fmr33433625e9.21.1785251137425; 
 Tue, 28 Jul 2026 08:05:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45bb2e7sm88820205e9.7.2026.07.28.08.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:05:36 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:05:34 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf
X-Gerrit-Change-Number: 1758
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1758?usp=email>
X-Gerrit-Commit: ee308e7f3ded508dc8b7e92405a46aaf011ca0ed
X-Gerrit-Comment-Date: Tue, 28 Jul 2026 15:05:34 +0000
In-Reply-To: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
References: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLklkYjhjMGM2NjBhOThkZThlYzU0OWI2OWY2NjkyYTdiNDFiMDkyZWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0a31d6ce212428791d7c04a391347586a923f274-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojNI-0000Vj-5p
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Unwrap
 tls-crypt-v2 server probes (P_CONTROL_OOB_WKC_V1)
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1808932230690734019=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1808932230690734019==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IJ568kgSpCU="; charset=UTF-8

--IJ568kgSpCU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

stipa has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
758?usp=3Demail )

Change subject: oob: Unwrap tls-crypt-v2 server probes (=
P_CONTROL_OOB_WKC_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 11:

(2 comments)

File src/openvpn/ssl_pkt=2Eh:

htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758/comment/638b609b_0d9444b7?usp=
=3Demail :
PS10, Line 79:  * protocol (CONTROL_OOB_WKC_V1)=2E */
> This app=
arently is also not a legal op code since P_LAST_OPCODE was not touched=2E
=
Already fixed by opcode-gate work=2E


File src/openvpn/ssl_pkt=2Ec:

http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758/comment/d7b487ea_fbed9cf1?usp=3De=
mail :
PS10, Line 400:         return VERDICT_VALID_OOB_V1;
> Either have V=
ERDICT_VALID_OOB_WKC_V1 or also have categories/consolidate some of the oth=
er enums tog [=E2=80=A6]
Agreed=2E Enum is per-opcode everywhere else=2E Ad=
ded VERDICT_VALID_OOB_WKC_V1 and grouped in do_pre_decrypt_check()=2E Reply=
_flags are now coming from the verdict instead of checking tls_wrap_tmp=2Ec=
leanup_key_ctx=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1758?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
db8c0c660a98de8ec549b69f6692a7b41b092eaf
Gerrit-Change-Number: 1758
Gerrit-=
PatchSet: 11
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Comment-Date: Tue, 28 Jul 2026 15:05:34 +0000
Gerrit-Has=
Comments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-op=
envpn@rfc2549=2Eorg>

--IJ568kgSpCU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1758?usp=3Demail">View Change</a></p><p>2 comments:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/ssl_pkt=2Eh:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758/c=
omment/638b609b_0d9444b7?usp=3Demail">Patch Set #10, Line 79:</a> <code sty=
le=3D"font-family:monospace,monospace"> * protocol (CONTROL_OOB_WKC_V1)=2E =
*/</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">This apparently is also not a legal op code since =
P_LAST_OPCODE was not touched=2E</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Already fixed by opcode-=
gate work=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File=
 src/openvpn/ssl_pkt=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758/comment/d7b487e=
a_fbed9cf1?usp=3Demail">Patch Set #10, Line 400:</a> <code style=3D"font-fa=
mily:monospace,monospace">        return VERDICT_VALID_OOB_V1;</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">Either have VERDICT_VALID_OOB_WKC_V1 or also have categories/cons=
olidate some of the other enums tog [=E2=80=A6]</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Agreed=2E =
Enum is per-opcode everywhere else=2E Added VERDICT_VALID_OOB_WKC_V1 and gr=
ouped in do_pre_decrypt_check()=2E Reply_flags are now coming from the verd=
ict instead of checking tls_wrap_tmp=2Ecleanup_key_ctx=2E</p></li></ul></li=
></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1758?usp=3Demail">change 1758</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1758?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1758 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"=
> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Jul 2026 15:05:34 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=

</body></html>
--IJ568kgSpCU=--


--===============1808932230690734019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1808932230690734019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1808932230690734019==--

