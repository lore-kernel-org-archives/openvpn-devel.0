Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319FE606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 12:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=buQFJ4P+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kM3WGiQE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=L86/P/2i;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PIBeT/S6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=nxiKSMOSsTZvRJ3imSBLPdbF4LvGUjHKFhfPmnSvEJ8=; b=buQFJ4P+dyw4yHmNZNoBFNfLWs
	Jw29D8IaH8BPoGGd7dQM7O2ReaqIrfA/WCOhRkTGi3FzfsGOub0+vWXVsvA+BKRXIi55pWtlq1NFD
	aed3ExqsKQcnK1GthVwwwzOP+/Ph4vlj8R4VoICYXYFSoGwnDhsExEYUasgslOXbOUMA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR7P0-000000008E8-10yM;
	Wed, 11 Nov 2026 12:26:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR7Oy-000000008E2-1Q0S
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 12:26:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=op2E6DO2eJU68P5pWh28j+kCpN4rFeTFx1sd7u98Uj4=; b=kM3WGiQEKvWL3Mw65hh4TzAq4B
 tnsyxTDmRcXkCoF3TL/h/tTAJvYjeGO4azVVHrzq8gbLNW1sySLhJp00sU02sMFtGQbQp6OmBL+9Z
 LgSRzR6K1isAaL/7hAYBgsKMR4kPOhrix+5LbG8ZZvW8qFfkOWKoM179Q8nRrLt5do0g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=op2E6DO2eJU68P5pWh28j+kCpN4rFeTFx1sd7u98Uj4=; b=L86/P/2iXQbyg610yNW4tMft7L
 1V2Z6i1zChF3FnSybIYVgrxuVpzJwF0z6YA8fpZo7lJb5xa0oFzaKpKfC8KPaTnwtKXdCoire4OtW
 u8TfaYHwBxqJmaZZmBmzbHmfOPsFMY2PT0cSGIgLXtv78rt3BAQZJNQkvGqQvvnGDr9s=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR7Ow-000000004yp-1Pyt for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 12:26:08 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4b4571ff080so35082215e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 04:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794399960; x=1795004760; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=op2E6DO2eJU68P5pWh28j+kCpN4rFeTFx1sd7u98Uj4=;
 b=PIBeT/S6XWal2q7Jbfqyka4n/0JQiHAIxMY7pB/JLkEOKov7fWBIjvX18+MHiuRTlh
 GEMVLqRFLEqlP0VGFrx9YWW9101csK5qxzSEQJH6EH3t6MI4uKYsJQ1IkPTgJJkH+8Iq
 l0MILoqgW9i7vcM316bt+gCW1/1HPNT1uAi7LldCwTcxCbvyRQs8e90ZQrF7IWIxlsf1
 NchmMEmLipFiDPE/+YkleFx5lZqbDPVhHeXPDI463O+MO2TwxQp6wHkTU2aR+8XkdJsH
 VdVuai6WbpKW0Fty35X17CPZ9UThYqLvadnzdRfxZN4QgY08yDWLnDxAXiQvI+dNAy5F
 3Tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794399960; x=1795004760;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=op2E6DO2eJU68P5pWh28j+kCpN4rFeTFx1sd7u98Uj4=;
 b=GmadENzpXx5z3hfulDSfLuGtp38SzuQoes8H4yLR80zGbNiHPDK0z7AJLtFVf31W4E
 AIXjBkkgQHcuVIpnzGuJztTG3LZf9U7D+ITRZFxbVv+0tB2PlQvPrkpuSpqzhW9/WRjk
 erU20tGi3fXt6GDqwngWqci5rWikZp28Yb08J1a7G1ENm/ciHlJzzvCeB4h4++LmR/0O
 YD1iZhn9avxzaRz/luUeyAu1ZavJczXz8APzQdSZ8UaBZrtKbSM/WU9+hjhR359+wZlh
 /1rk0hgqhRTiHWVjyI1SoRjlZAmVkeBv7AhrZQNcEx1+lg0Zzxr5Pyg9hNQwiKZmnWbV
 tPZw==
X-Gm-Message-State: APuU4Z9HjzsdPB+KnGNj8x3M/mn94elF5oXAoTDEnR+iEJZ2zoJ2k3dO
 64cJn37RxIKfWuTd5zDmVNoDh0sFOfHcltc+KO1ulLU9L1RLFHkhboo2TWM82coOEFE9KbTFSVS
 A3hbag4jJPPDKXZoU9GpEyOlMWAU7z0Igj/oIL3by2NnVz9wsvI1t9w0lxpQVeg2GkZir
X-Gm-Gg: AYBFou1ofR1u/NvPnGidSE2RFYZArIutjH3sAMLmVUAoX4GMXvJN7TOrZdk2LM+aXpL
 z6Ko+ZjuwwAidGhWA/+WWQTvTmRVyA8ngwWsK4FJu1Pk8VkiT467wrWQtF8Xh0B8BBOl3IruW/6
 6vEugiU1sF0PaJy2IX6ieYIyEUvnDzD8OatTIfIkRPsfm0ZXCFboyDq/0jmYaqVcznefyAI/YSH
 0Yt6BRP+bD2ezmSTuN58X+RSpoYVlbDNpkCjRoWBDqFE4L3h84QQXRYV3xFTkvG8E7utmqd/jpo
 rXge1eUxZxPKP5ZUz0Hw74LxnwmEZfnnMopesyZTxPTVhzQGDW6YT7SHDRMdFc2g5Iubv8yI36t
 JiNPFaWx7ZTvITYdQoKd9qhdu+CYkwdtmW+AymJVA2x8nURj1i76xOWdl+r/uLw5EazEqtC40E2
 Lnwy7KTMx3IxKyxtAycMU0qaj4bRtg/ujRytWBnFRAK1YTAQhexX3qCUqKVREvhIEIYZJJ0XLbV
 lwkspvtg8ECugAmN9jJ/jmw8a6TDsxOIouBy9mmzN6pyvQJTelMXSpRcIwBxbZWZc8LV+6ZkI3R
 jsmqjnS59JrveP3AiJ03ll4c5AODscwRCncFSakgrOySNBNs4vpKjvlMkIWgHxPYNnkArDYJGrY
 +4HLoOcQPgjDlmQwGGEQJWhKKb20qqp9HCu2NOsiYQyqakw24kiA7J3YjbQ/fWctkA3r5IvUaVX
 4tkL7fZfMXNj0Zy+M=
X-Received: by 2002:a05:600c:871b:b0:4a1:fe26:24f0 with SMTP id
 5b1f17b1804b1-4ba0938a4cdmr39092545e9.20.1794399959538; 
 Wed, 11 Nov 2026 04:25:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe2c5asm209728865e9.5.2026.11.11.04.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 04:25:59 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 12:25:57 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I86154e5c997b044f6913bddab58b43193ff539e1
X-Gerrit-Change-Number: 2169
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2169?usp=email>
X-Gerrit-Commit: 07f6f57e5f8ddd13fe97d81397579999a4e84442
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 12:25:57 +0000
In-Reply-To: <gerrit.1794332732000.I86154e5c997b044f6913bddab58b43193ff539e1@gerrit.openvpn.net>
References: <gerrit.1794332732000.I86154e5c997b044f6913bddab58b43193ff539e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzMyNzMyMDAwLkk4NjE1NGU1Yzk5N2IwNDRmNjkxM2JkZGFiNThiNDMxOTNmZjUzOWUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <96c508ee0b954bb65335068c4fc37e22b53705c8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR7Ow-000000004yp-1Pyt
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 tls_pre_decrypt_verify_opcode from tls_pre_decrypt
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2970126579885139070=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2970126579885139070==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0AYRNZ8bk/8="; charset=UTF-8

--0AYRNZ8bk/8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Antonio Quartulli ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2169?usp=3Demail )

Change subject: Extract tls_pre_d=
ecrypt_verify_opcode from tls_pre_decrypt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2

(1 comment)

Patc=
hset:

PS2: 
Patch looks good!
The commit message should probably say "func=
tion" instead of "method" =F0=9F=98=86
And I'd add a "No functional change =
intended=2E" at the end=2E

In any case +2=2E



-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2169?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I86154e5c997b044f6913bddab58b43193ff539e1
Gerr=
it-Change-Number: 2169
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbi=
t=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment=
-Date: Wed, 11 Nov 2026 12:25:57 +0000
Gerrit-HasComments: Yes
Gerrit-Has-L=
abels: Yes

--0AYRNZ8bk/8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Antonio Quartulli has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 2:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2169?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2169?tab=3Dcomm=
ents&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">Patch looks good!<br>The commi=
t message should probably say &quot;function&quot; instead of &quot;method&=
quot; =F0=9F=98=86<br>And I&#39;d add a &quot;No functional change intended=
=2E&quot; at the end=2E</p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">In any case +2=2E</p></li></ul></li></ul><p>To =
view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2169?usp=
=3Demail">change 2169</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2169?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I86154e5c997b044f6913bddab58b43193ff539e1 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2169 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 12:25:57 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<d=
iv style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--0AYRNZ8bk/8=--


--===============2970126579885139070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2970126579885139070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2970126579885139070==--

