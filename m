Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2556CC56205
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 12:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xfBo5gkR0jCx7yew53Q5/ZG8ysY8djkkAh/0OkCYvbc=; b=isauy3ZxIX4jNlnhx52rMp/Gyh
	sLp50YGzeIPe0FUhwoNS+Bfxw4pufjBBh/MYXyf2Nmqi98VaenfoHUgkAQOmpA7fKws24ZW1t4NcS
	XFbfUgfZnxc1lsDBUwnfqymsJ7A8E1wp2/vk1u3Qe/xuUGhfIxMcqZ2hiwqkVmpEpnts=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrwtA-0004Ur-QG;
	Thu, 06 Aug 2026 12:07:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrwt9-0004Ue-Mz
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 12:07:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0QI6pK+LNjLJ+w5XC4rBIySig6nXU5buaKgwtYbm0Gg=; b=F3gMuTeJQDGy3XWYszhSkxMLG4
 ycRuKb6yOIqPJEIgFnrEUL0vmnQ5+RgDOYvOkOVN9QUYRF++/9i5dF3DLOPBCw2WkKAejNpahOUAy
 BlSR3YF+ckVvxRhkL26ZN02CxFIkroC1H3TzRvxUpnvtzH6mEq8imtEvcnNqLKCzl8ig=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0QI6pK+LNjLJ+w5XC4rBIySig6nXU5buaKgwtYbm0Gg=; b=a
 PrEafX/ps77xCBz2xjGxHYEGvOmpYeCZPRLNKT4hTgZN+HqCvb1S6CxvbCaQnh+02fSX79577Bl0K
 5rn+WZSdnlMIV8LnkWvEtPXLBwhkQ5xanFapuOFY+4xYoRcwQeyDh6zfkrBoOks3rp0jFR9TwmFc6
 EiVhf7J1lVXuv7B4=;
Received: from mail-lj1-f170.google.com ([209.85.208.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrwt9-0003Wy-C4 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 12:07:53 +0000
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-39eb257e9fbso14484011fa.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 05:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786018065; x=1786622865; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0QI6pK+LNjLJ+w5XC4rBIySig6nXU5buaKgwtYbm0Gg=;
 b=X6toMUc61+VemsWtkO0jwrujtfcKHkiE4MJEmWkJ6jZ3sCCSCKwmhl3WuFhs0fAtJu
 HLDo4SrrdYbPeG43UtAcCL6B73HYIDwdlVYrMWEd5W2NWw+aI38rQAsoSK19P87Mjrjd
 1XgVig3SMMiW2frR2dPPttbxnC7VYnJU3BMXMaEA3E4uPvItMFStHU6yAMvvhbzRKPD/
 2flVLGXcdiPg+QIurihslpr+iefwVsnYHa9F8+T9Ae/Dg7WU1KmSnJzgWvijwKwH1lAU
 h6nBzbD39VcUNhWSdI+g/vKEM6zVc6vk2jiKkQ2iHL5CB4rCtw3H5flUDK+WjvEkCtAm
 bHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786018065; x=1786622865;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0QI6pK+LNjLJ+w5XC4rBIySig6nXU5buaKgwtYbm0Gg=;
 b=osA1CjcsXz6giewaz11KoMCr4izqSzGObLflyi28x/XZqFkIWGsMNJ3qY+AZNTLePW
 FUQb/98LkyqR6nrsQSLz1eocDUSuxpWqbCPyatDNRggV0k8a4Ul7u79kPLZkIWls35aZ
 0j3ERxK875xlxCGWhr2emBP6ZWpdLDB8Y6fIpQPISDTktatdxoVNyAmy7NdL0FksfULq
 ft00Hk8CuqaXJWAt97mNMHYbxLu1yJ4BM4Xs0mbxU0jCiOfCWDSnUymwZNP0Cm3YkxmH
 6rg94vUh0W+4AV/rITF8W05GQGKVgwkyBud4DmveBoFzFsTgCAiqmsWAG/qTTjMbeeL6
 mmyw==
X-Gm-Message-State: AOJu0Ywsl4xXr+U5KVqTNhoABh8wDNRtJhJy8OuCrtPmPh+8tYq3Adot
 V2IO/OQBNxgxlzxv15EapyZqTIO/4R1D0GWqpKj+xVl+1oC1kAQi4vHIk5JSCgEXiodfa/AHpzc
 JJSAfHq3+W+ulV4qPyvx/Qz9Bq0l1VckwC3aXvhlm8JJNQwsW7Nf1ffxSx4VayN6fIq7D0BYECt
 tpYW632g==
X-Gm-Gg: AR+sD11iK323Pq6TBTOmzT+K9A8HRsQ7utxzq+mToOZp0FuQtFQl8QflcC/j4QU24pv
 hAicW/jngBzBhlSxA4hymfdCvpfxOuOEkn/JBax+NZ85S8FuRXKtlQL0UXAJKPilWkWDB1UEz12
 RiTdNyHDC+Aw0j43BJcFwLEHN+vH3lbYWrTDzqz0T+wTvEYMGyGBKBFgonQ0Ckm8k0uxSBMfSi9
 UTWG47nh7+LrMJP9pfhmTy0l/dRuD80GP5jfPH1y4Xrv8dC4ZV/vA4i+YshQmwWgeoLEfh+IOeH
 4FJye+/5MC8DnKLE0gp7+X3CThq2+N77HeUF6OXZZIJ7lEK5xipSfipPGJlD/D+F+w1M95vK3xF
 Gm2RVJ+cagRUYRGUge01KeLMW3gBSvqco/D4A1mK5U4wONDQ99Wu3Fab6UQKaKHd5j8XGcuwfyk
 K+oYMdS6RW+isiFIWsb6mPgzfrrxYJc9YFWqrLV9BDS6+NyII5ReLME/D134MhVUpghvtzZQKQZ
 FFFcJCGh5Sx9a5TL+Sv1E8jF0FfWw3V621/kGDbx2mIhxGyGDsQ4zOdCToZb8Zc+O9xulLSc0uz
 MzeAvnkOHDI79v2B65+XhqXPuM86XcO9MR29wX29/tu0+KskYTQ=
X-Received: by 2002:a7b:c7d6:0:b0:495:4b42:8677 with SMTP id
 5b1f17b1804b1-4994e7d17c3mr153070025e9.18.1786017666642; 
 Thu, 06 Aug 2026 05:01:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff7b285b1sm6591160f8f.31.2026.08.06.05.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 05:01:06 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 12:01:04 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1a6a0ca8beba3214b21047755246ceeb30141c2a
X-Gerrit-Change-Number: 1839
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1839?usp=email>
X-Gerrit-Commit: 6f6d02e72343e04c0b473d8dd7a762498ef37d84
In-Reply-To: <gerrit.1786014571000.I1a6a0ca8beba3214b21047755246ceeb30141c2a@gerrit.openvpn.net>
References: <gerrit.1786014571000.I1a6a0ca8beba3214b21047755246ceeb30141c2a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2MDE0NTcxMDAwLkkxYTZhMGNhOGJlYmEzMjE0YjIxMDQ3NzU1MjQ2Y2VlYjMwMTQxYzJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <892b4311ed9dde8f340d12574ee83e7beb52358a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrwt9-0003Wy-C4
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: Make test_misc
 compile with -Werror again.
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3723629193229111461=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3723629193229111461==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kR95cZ48mps="; charset=UTF-8

--kR95cZ48mps=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1839?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
cron2


Change subject: Make test_misc compile with -Werror again=2E
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make test_misc comp=
ile with -Werror again=2E

Commit 5978a46e3 (master)/3402f9aa0 (release/2=
=2E7) removed the
local prototype/function get_random in test_misc and use =
the
global prototype in crypto=2Eh=2E

This made get_random return uint64_t=
 instead of uint32_t=2E
Adjust the calls in test_list accordingly=2E

On ma=
ster the general hash rewrite/cleanup completely
removes the iv argument fr=
om hash_init and therefore
only 2=2E7 requires this patch=2E

Change-Id: I1=
a6a0ca8beba3214b21047755246ceeb30141c2a
Signed-off-by: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerr=
it URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1839
Message-Id: <202608=
06111323=2E32150-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38167=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/unit_tests/openvpn/te=
st_misc=2Ec
1 file changed, 2 insertions(+), 2 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/39/1839/2

diff --git=
 a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_m=
isc=2Ec
index b9e2db0=2E=2Ea9c3845 100644
--- a/tests/unit_tests/openvpn/te=
st_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -170,8 +170,8 @=
@
      */
 
     struct gc_arena gc =3D gc_new();
-    struct hash *hash =
=3D hash_init(10000, get_random(), word_hash_function, word_compare_functio=
n);
-    struct hash *nhash =3D hash_init(256, get_random(), word_hash_func=
tion, word_compare_function);
+    struct hash *hash =3D hash_init(10000, (=
uint32_t)get_random(), word_hash_function, word_compare_function);
+    str=
uct hash *nhash =3D hash_init(256, (uint32_t)get_random(), word_hash_functi=
on, word_compare_function);
 
     printf("hash_init n_buckets=3D%u mask=3D=
0x%08x\n", hash->n_buckets, hash->mask);
 

-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1839?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 release/2=2E7
Gerrit-Change-Id: I1a6a0ca8beba3214b21047755246ceeb30141c2a
=
Gerrit-Change-Number: 1839
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--kR95cZ48mps=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1839?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">Make test_misc compile with=
 -Werror again=2E<br><br>Commit 5978a46e3 (master)/3402f9aa0 (release/2=2E7=
) removed the<br>local prototype/function get_random in test_misc and use t=
he<br>global prototype in crypto=2Eh=2E<br><br>This made get_random return =
uint64_t instead of uint32_t=2E<br>Adjust the calls in test_list accordingl=
y=2E<br><br>On master the general hash rewrite/cleanup completely<br>remove=
s the iv argument from hash_init and therefore<br>only 2=2E7 requires this =
patch=2E<br><br>Change-Id: I1a6a0ca8beba3214b21047755246ceeb30141c2a<br>Sig=
ned-off-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Acked-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1839<br>Message-Id: &lt;20260806111323=2E32150-1-=
gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg38167=2Ehtml<br>Signed-off-by: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/unit_tests/openvpn/=
test_misc=2Ec<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/39/1839/2</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_misc=2E=
c b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>index b9e2db0=2E=
=2Ea9c3845 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br=
><span>@@ -170,8 +170,8 @@</span><br><span>      */</span><br><span> </span=
><br><span>     struct gc_arena gc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct hash *hash =3D hash_init(10000, get_r=
andom(), word_hash_function, word_compare_function);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct hash *nhash =3D hash_init(256, g=
et_random(), word_hash_function, word_compare_function);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct hash *hash =3D hash_init(10=
000, (uint32_t)get_random(), word_hash_function, word_compare_function);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash *nhash=
 =3D hash_init(256, (uint32_t)get_random(), word_hash_function, word_compar=
e_function);</span><br><span> </span><br><span>     printf(&quot;hash_init =
n_buckets=3D%u mask=3D0x%08x\n&quot;, hash-&gt;n_buckets, hash-&gt;mask);</=
span><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1839?usp=3Demail">change 1839=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1839?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: release/2=2E7 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: I1a6a0ca8beba3214b21047755246ceeb30141c2a </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1839 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--kR95cZ48mps=--


--===============3723629193229111461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3723629193229111461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3723629193229111461==--

