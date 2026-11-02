Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F92E60A3806
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mPdFeUYA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=X1f/p6Qj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TkpHuoii;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VWUi1AGF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=V1DmJbaa6wdDuv1nqvRp/VHvW7XbpNUQDH7TyJC74u0=; b=mPdFeUYA6j71ql1835ykF8RvS9
	YUD8ywkkg5YTsWX1Mc2D4p2Kblbbf8MbLNVl0fEnj/3TIxRPzUVuQSAOSJoKfD4UUMbeyOdMCLK5Q
	rMKlQrTYTabR9q7lBFs+wLOnoH5WgYNLz3AbvlHnN4NVkx67KvFfXWIybU023/Yl8un8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNq3O-000000003Kw-3qrt;
	Mon, 02 Nov 2026 11:18:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNq3O-000000003Kq-0bmM
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:18:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WtODAXGGRyLPGbwf1KmgUVgdu6RMAvu5DHgCSUl8SA4=; b=X1f/p6QjC0F7U+yAN0hz29dsYT
 StoEcuhdkq1OCVzIHPYqbE+NshDoQOOZ9sCAYZAWcnFVlqOJwOH+AwE3oWSUSzwJ2B+uxzwHHcGG+
 zRpuLv+PrLnR94Y+kjxy0idUojansw7jleByS/5VHienCSxwZjGCkXcqJkRBb0jd5mgg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WtODAXGGRyLPGbwf1KmgUVgdu6RMAvu5DHgCSUl8SA4=; b=TkpHuoiiras84fz04aVL5ERbNj
 PBP9dcW+ZT3jIC3foxQogV4WqDw4vfeKWhB+0gFL9BtgMqA4g2g5D7wpqgQx0st4PrN8qnl2wicc6
 LHfYjl6xZbzvYi2+6hfPpCnLfrfOVwlXcqIAlUlWqDkb48HEWTNnfL6EFMO0FzNSqx+0=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNq3K-000000004T8-04P3 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:18:18 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so20380575e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 03:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793618287; x=1794223087; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WtODAXGGRyLPGbwf1KmgUVgdu6RMAvu5DHgCSUl8SA4=;
 b=VWUi1AGFZ4VfGm75QN3BWIVnBipb9xt5ul1ICykvskap9XL9VZW9RGf8QI62EWwT39
 iTsOG5PWG63sG/YSLdHBgPPr45PtY1GQtn8rop8eh7COYc728XGlXIGNTiTmj4ZQaTrg
 7OepnYJhNWvk/NIRkd+4tSE49P7km67YKtbCYDk6n3tppIEQiCJX1SthDytzX7Uskz2M
 4gaLQD8ySMWeW46hbh1mYf7+Lw4alkyanPH7ukPS7Q41D162lGzIwJD160C5DMCfd3Ch
 diG/IvZjWL0FNUHneW+rKdhfBtzftAbQNDclKhkKuQ9AV3I9Bu87jZiGqTzMKrmer6cp
 VvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793618287; x=1794223087;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WtODAXGGRyLPGbwf1KmgUVgdu6RMAvu5DHgCSUl8SA4=;
 b=ogpUrTBxN0QXGLMKsMKhaRqsZe66SMKTEm5Z5xA1VwRp/Io1mA1gQOdHj7trc1k/ln
 ANYkYGe+v0R02hvLNo9J9WA9ALPx2SxvVIohUu/NwaKUGY6B4VOTq42X4pmSD65yaGsd
 yFFldy7JFyxSTuMizOZ6+MRwcsLZQK0R/W08aBjnFem0dCguObArvIFT1I5S0GqClnNS
 ND7mOt3w5Hf07dirtzieXh76WLcR3/9OCT/wbUkTZR/2SNgIX9H3hLZHaKMsSKmH6rUB
 P7RA3GNDuwTQ7+JGY8+aegjmrrrg3T8aMj0jLbFFLW7Rcnit0eS+aGsNVHk25UL4V+Ix
 GWUQ==
X-Gm-Message-State: AFq9FYIh81x25RhQt+0lP+S5AIdpiDfZrjBF33bK6ocgLtueiWIDLL3x
 nMoTvgPcOuFRhj1BQxY0+nrFmAN/nGJuDcvaWnz49SJZ8jqkkaksm5n5Rbfv46wRlrIn5E9aR4r
 miK3ur+TAosWnpgGj5cuIMCS8oP9MH7BP2RzcC+q2TeL/r001wOSlgv817iYE862oOk6i
X-Gm-Gg: AYBFou2LkB1kHDdbtslREAhmBbREGnqV49CAyAoxaPlGZKkeU1jtnnx184yjpk5fch3
 tg1BvJEnXgjN42h9ny58b2RgxfwP7scDqAiXwk5qYa9h4xQbBxyFBYqobkDl5bJzxdaIgTI0pA1
 I7Vxx4ygOXVQFElnwVSbn+j5o9/8DgfmZFJNmUgDXss4JlDn68pAmTXZd6YhcTTdEmrsq60FUvw
 nB35nrIy4ny/nXaa5C+TDXEq2mv7SYk3+ODM2m26WH7cZeyJ6sle3bAjTiZ/Jv6aJkDM7p+SmLb
 7riI5TMMgljH1rfuO2amaXkM6rgu82E2CHaLvR9NlQXK5UZuEtOjnL3hpqGOZU9qwojN366i9CT
 jl2g61+zYdFGeWYZyb0VXv6wPNGhRxx1yI3Zzk4EMY7S8OtL7l6Fa6Kt+FdhAseKNzd2fA6fOdG
 oikdXPsq6+w+ZDGwchsluFbKDv2tWaArEWGLRne8RAyqH5esfmJIYkrt8WCuJNsDTb5NC+v0V/y
 RgCEoDeRNNbDYQGbvO/KzrnH8p45ZVm15PjBxGpHDn/pbrkd6eLqScq9DhCd1fs4nLoYIxDtUxi
 eTts2VmTP8qOVfTRQkkO5vaW42iv13AxfieMB9kZysUxQrYcuJYpbhSxdEaYfIHxgWeSey1dt25
 dcdo6PyKD53hSSaljemyix7TC3FXNgiz+S0w6EKosI/mBoz/zitMe1yGi4Sfs6YsnoVyhCDTpcT
 NP3MM1xf7b3y6dpQ==
X-Received: by 2002:a05:600c:1387:b0:4a1:88df:8a2a with SMTP id
 5b1f17b1804b1-4ac1793e81cmr238165255e9.13.1793618287344; 
 Mon, 02 Nov 2026 03:18:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0a0a3495sm210589735e9.4.2026.11.02.03.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 03:18:06 -0800 (PST)
X-Google-Original-From: "Hansaem Wi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 11:18:05 +0000
To: Steffan Karger <steffan@karger.me>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e
X-Gerrit-Change-Number: 2077
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2077?usp=email>
X-Gerrit-Commit: d1b1dff10d81d0fcfd57a74dbadf2958e025c98c
In-Reply-To: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
References: <gerrit.1793496782000.I6b42785de99ee1e6b555d8c5e61ebe2ae784510e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzgyMDAwLkk2YjQyNzg1ZGU5OWVlMWU2YjU1NWQ4YzVlNjFlYmUyYWU3ODQ1MTBlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e1e80b3c794a98230e24e3f5e5ef27cc94c238b5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNq3K-000000004T8-04P3
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto_openssl:
 Clear PEM decoded key data before freeing it
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Hansaem Wi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: hansaemw@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, gert@greenie.muc.de
Cc: "Hansaem Wi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7553166955578473701=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7553166955578473701==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6K+PaA3TWuA="; charset=UTF-8

--6K+PaA3TWuA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Hansaem Wi, Steffan Kar=
ger=2E

Hello Arne Schwabe, Gert Doering, Steffan Karger, 

I'd like you to=
 reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2077?usp=3Demail

to look at the new patch set (#2)=2E

The follow=
ing approvals got outdated and were removed:
Code-Review+2 by Steffan Karge=
r


Change subject: crypto_openssl: Clear PEM decoded key data before freei=
ng it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

crypto_=
openssl: Clear PEM decoded key data before freeing it

crypto_pem_decode() =
decodes the tls-crypt-v2 client and server keys
and the auth-token key, and=
 frees the decoded key bytes it got from
PEM_read_bio() with OPENSSL_free()=
=2E Clear them with OPENSSL_cleanse()
first=2E OPENSSL_clear_free() would d=
o both in one call, but LibreSSL
does not provide it=2E

Assisted-by: Claud=
e Code:claude-opus-5-5
Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e=

Signed-off-by: Hansaem Wi <hansaemw@gmail=2Ecom>
---
M src/openvpn/crypto_=
openssl=2Ec
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/77/2077/2

diff --git =
a/src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec
index e6a=
bd8f=2E=2E3c708c2 100644
--- a/src/openvpn/crypto_openssl=2Ec
+++ b/src/ope=
nvpn/crypto_openssl=2Ec
@@ -528,6 +528,7 @@
 cleanup:
     OPENSSL_free(nam=
e_read);
     OPENSSL_free(header_read);
+    OPENSSL_cleanse(data_read, da=
ta_read_len);
     OPENSSL_free(data_read);
     if (!BIO_free(bio))
     {=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6b42785de99ee=
1e6b555d8c5e61ebe2ae784510e
Gerrit-Change-Number: 2077
Gerrit-PatchSet: 2
G=
errit-Owner: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Attention: Steffan Karger <steff=
an@karger=2Eme>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=


--6K+PaA3TWuA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Hansaem Wi, Steffan Karger=2E </p>
<p>H=
ansaem Wi <strong>uploaded patch set #2</strong> to this change=2E</p><p><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail">View =
Change</a></p><p>The following approvals got outdated and were removed:
Cod=
e-Review+2 by Steffan Karger</p><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">crypto_openssl: Clear PEM dec=
oded key data before freeing it<br><br>crypto_pem_decode() decodes the tls-=
crypt-v2 client and server keys<br>and the auth-token key, and frees the de=
coded key bytes it got from<br>PEM_read_bio() with OPENSSL_free()=2E Clear =
them with OPENSSL_cleanse()<br>first=2E OPENSSL_clear_free() would do both =
in one call, but LibreSSL<br>does not provide it=2E<br><br>Assisted-by: Cla=
ude Code:claude-opus-5-5<br>Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae78=
4510e<br>Signed-off-by: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt;<br>---<br>M=
 src/openvpn/crypto_openssl=2Ec<br>1 file changed, 1 insertion(+), 0 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/77/2077/2</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_o=
penssl=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><span>index e6abd8f=
=2E=2E3c708c2 100644</span><br><span>--- a/src/openvpn/crypto_openssl=2Ec</=
span><br><span>+++ b/src/openvpn/crypto_openssl=2Ec</span><br><span>@@ -528=
,6 +528,7 @@</span><br><span> cleanup:</span><br><span>     OPENSSL_free(na=
me_read);</span><br><span>     OPENSSL_free(header_read);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    OPENSSL_cleanse(data_read, data_r=
ead_len);</span><br><span>     OPENSSL_free(data_read);</span><br><span>   =
  if (!BIO_free(bio))</span><br><span>     {</span><br></pre><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2077?usp=3Demail"=
>change 2077</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
77?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I6b42785de99ee1e6b555d8c5e61ebe2ae784510e </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 2077 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Ha=
nsaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Ka=
rger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Hansaem Wi &lt;hansaemw@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Steffan Ka=
rger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body>=
</html>
--6K+PaA3TWuA=--


--===============7553166955578473701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7553166955578473701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7553166955578473701==--

