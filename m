Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB89606B9C3
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FygQ8imi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mvhoRsp5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jawM85F4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YS5bn/sH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zD1GehLTBeyHMS1rbXXXnBnyim3KBqzTA42tjb01d5o=; b=FygQ8imi3OnqMT8dK4oQ7ZCaJm
	28YQVYXhBKBQi3FiwesHCiGJi2nDeOPmmx50Qidi0eWK1ugoUXRgs0yDO2XwBniyBIz0lEle+AfKy
	Ldsp3LuqsjcY7wU8QiAv11zon0Grb5mNZpTmMb4Yz5QVmUdcD6KxE9g4b1OLf8zbno3Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP3Wq-0000000051F-3nxd;
	Thu, 05 Nov 2026 19:53:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xP3Wp-00000000517-36oo
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 19:53:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=klQIBGBy/ZNzi9ine1QUnNdGmmeYO4bN0xjA3Y/wnW4=; b=mvhoRsp5vXp8E5D1du4WTaimDr
 PQL3gHfISg+eYgR78CPl2JhTOLZYq9j3Fq7pUK/TanrD5QwFVZJcuzujzfn7xVuSLvv6M6Mqv9zly
 PFXzDspK9Xg7RG5gIV1MCDzBRXZQviH6PAuqIS8Q+4l/eliAkR/i+224IVceqtsIKFgw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=klQIBGBy/ZNzi9ine1QUnNdGmmeYO4bN0xjA3Y/wnW4=; b=jawM85F45acuc6FeGLmZWns9Dk
 2FAjzwfJvogN+LXp1o9MT4eYiusIL2onKR+r6F5N30udOI8m8F1hsa2VdoQmq+AlWHWIPJ1Q5yzBe
 2HKD/bwPE7eQwi0uzkOYQKSDZ0PEAWbVIW+xqXepHa8Ul3cBEuwvWmvk2xGdLFmuXUm4=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xP3Wo-000000006zT-3b23 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 19:53:43 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so21273885e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 11:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793908416; x=1794513216; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=klQIBGBy/ZNzi9ine1QUnNdGmmeYO4bN0xjA3Y/wnW4=;
 b=YS5bn/sHtkboD0j+clyoXA9k0nqy0N5bnEHkPVsTAAQqMAjrhHm98V5fg648+m0fPo
 +F/Uo8I9QmBxI/uYkU+rRBglMkAoQnOW2ubWPyu1AllhzaaS84APTNWRB8Pv81EiMr51
 xC8zWboha4sm53GuywKMBwiGeoUV7j8qKL6pw+zWHDCz/lgTUWSfJ5QpdCi7Cx7nw981
 fapsjNcS0kRE0g+flWY8yJnSwEw7sVZcGY6ALtYId6u55At1a4la3Zlqc/lvBvL7PqUj
 cO1I5w79oBU2blhw1603FwAhRnP6Rx5RypgCjfV5AhssBWjXACZtev59oUYfo2AdxgNd
 zWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793908416; x=1794513216;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=klQIBGBy/ZNzi9ine1QUnNdGmmeYO4bN0xjA3Y/wnW4=;
 b=jJRgnUJy8MDCT8AoMsq8SBSJCRlKWCXjxFv8ILx0+zzlbnl9/xmm7qxKK4GgZVudJc
 tZ/Qp1avmMa/PcrUHkmcLzaUldqC5VVVE6h7qXN/l63Fo3IeGtgwfTnNGuDCkZ2BCacB
 3w6BSMPqSt+oR23asVa0aKulEtqH5J6nu6p8ZYYvAGHhGFZ7vSVxr0FITrnYgSSbt/tC
 TnlHgevpgMFSMUcO8D9Sohyo2PdywApGIXOrDOVHqTtfx42wFycbVnVBdGhcNFhIFTr0
 nfQ7wImMUNMpg0ysXqLfTmmwJVBwNCW9gdXTWkt3Gzie63i0unrprfcjbUsXYNA+9j6x
 rcHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5hLiJSVBkmoTENvWI0Bz8D8TQoK5iuuOtjAAXJFTwT/FhaWa2UCJaFem6nDnHmS28Yz4O7eIC4LScmqjn@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+b7nP/vMvyTUbvf1Vu8OaOacc4tfQtUYHk2wF3u/2H6BJ1xWe5
 /c4SolSdYYBPncle22lyySMmVOmrdHYYQDZd46jtJeSXG90mY3ijB0gRAfvMWwppq0AKzhOtdQJ
 Aze/HIpuPtG9XjyhPQz09qsbFYUGDUuAm+KxslJrcfKij5g7orSEHykiDneE4ClxMCiL3
X-Gm-Gg: AYBFou12eC5Vn41U+K1VkNx5LvgSfgLmqU0IBpbt+qcpw/PAqcCKWJ6J8WwdqYCvhfG
 OVQbV0gwV6bVV+Rg/MYiS5MGO2g29UX6e08HZ+fKkuOc02Kz1E4o2EEJI7+3+Ot4zSFgfKDxAHE
 WRPwH/Yndbtfl6D6I7sphm1f6H63AjPwmZWVt8tHsERyHgO9BWHktVpkGHy2/CzKC4WoMZNSCp1
 ciy32SSXL0crVKaQE/M3QZLNsBOPeg5yZrkzG9uysmVn90X2Qae72jGi6C8k5e+ylUiAVZxNdvy
 Z09t//O4l6jh/L0WPcaZ0ejk0tPK7QX+KyD9xKBFY/25+LdArxlFZ4cqEeYICjdCEXbXSyN5kAy
 gXHxEF40AO3tp8uBDs7upeJhaNHlDWxYVtc4KoF8vUsSQ0TPxLSb2301L74lQrE0pXxZlGB7L5X
 OmCbd9VTcTlLcT7456y9kTIURP1ydlHlovNSbWWQ67U+8JqpGyhqADjHdbVtOP/LANN4vs+XgEI
 OoIaSol9Hr+nTaPVzmvMRwYvzUDPe/6ADbhnP4mvNQQqsfpRE7OmgjtHH938cGAJTrJhESaRA3C
 lIQHHKw7HLeAu/aqn5P2RQk4OUDS7gkUr7hMrTO0skRltFpK1GDWyOBUwVCw4tMcYigLidNzFmi
 q3tMh3LaL0A3efYFwQDkxsXLpo8a7NAhIsBgwH3V5MMvi32tQiVsY67ni483NHHWX5fm0Ti9N64
 PNNVbu/hy4HF5AIQ==
X-Received: by 2002:a05:600c:811b:b0:49d:1fa8:b266 with SMTP id
 5b1f17b1804b1-4b6deb5fe17mr2866475e9.26.1793908415725; 
 Thu, 05 Nov 2026 11:53:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feea5d4e4sm11359691f8f.57.2026.11.05.11.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:53:35 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 19:53:33 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5
X-Gerrit-Change-Number: 2105
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2105?usp=email>
X-Gerrit-Commit: 8eb4af5adaff4a6f1f9a8801a45c00eac2a2df24
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 19:53:33 +0000
In-Reply-To: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
References: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkk0OTRhNDI3OTI0ZWE1MDEzODIyNzVlYTk2ZWY4NWE2YWJjZDc4MGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0e306d7c2801fc808e5442d26a9a3cafe5901e6a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xP3Wo-000000006zT-3b23
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Move gc from
 openvpn_net_ctx_t to local variables
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5754689982518105436=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5754689982518105436==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kfLYHWHXBuc="; charset=UTF-8

--kfLYHWHXBuc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Gert Doering has pos=
ted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2105?usp=3Demail )

Change subject: Move gc from openvpn=
_net_ctx_t to local variables
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(2 comments)

Patchset:

PS1:=
 
I think we should just get rid of the `gc_arena()` here=2E  It's just mor=
e expensive for a single string to be malloc() per function=2E


File src/o=
penvpn/networking_iproute2=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2105/comment/6b3e6e3f_06be757e?usp=3Demail :
PS1, Line 367:     struct gc_=
arena gc =3D gc_new();
technically we can just go without a `gc_arena()` in=
 all these places - `print_in6_addr()` uses `gc_malloc()` which will fall b=
ack to regular `malloc()` if fed `NULL`=2E  So we just need to add a `free(=
dst_str)` at the end=2E=2E=2E



-- 
To view, visit https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2105?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5
Gerrit-Change-Number=
: 2105
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit=
-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Comment-Date: Thu, 05 Nov 2026 19:53:33 +0000
Gerrit-H=
asComments: Yes
Gerrit-Has-Labels: Yes

--kfLYHWHXBuc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gert Doering has posted comme=
nts on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demail">View Change</a></p><p>2 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?tab=3Dcommen=
ts&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">I think we should just get rid o=
f the `gc_arena()` here=2E  It&#39;s just more expensive for a single strin=
g to be malloc() per function=2E</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File src/openvpn/networking_iproute2=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2105/comment/6b3e6e3f_06be757e?usp=3Demail">Patch Set #1, Line=
 367:</a> <code style=3D"font-family:monospace,monospace">    struct gc_are=
na gc =3D gc_new();</code></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">technically we can just go without a `gc_are=
na()` in all these places - `print_in6_addr()` uses `gc_malloc()` which wil=
l fall back to regular `malloc()` if fed `NULL`=2E  So we just need to add =
a `free(dst_str)` at the end=2E=2E=2E</p></li></ul></li></ul><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2105?usp=3Demail"=
>change 2105</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
05?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I494a427924ea501382275ea96ef85a6abcd780e5 </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 2105 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@green=
ie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Thu, 05 Nov 2026 19:53:33 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-=
Has-Labels: Yes </div>

</body></html>
--kfLYHWHXBuc=--


--===============5754689982518105436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5754689982518105436==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5754689982518105436==--

