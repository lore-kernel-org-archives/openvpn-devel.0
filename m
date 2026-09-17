Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9714CC982C1
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7nRSqrAuaqQCo62dLawWm2bOOELog+QUVULsIDcQApI=; b=W7wR039aFIUQq/m3S7kvWw96ZW
	JtnydJcYugOCrLphlyelc+Ees0okN5t0j4w1F84BorYda01/Kchab7kzscVvi//D8rvr5eqnW/F4T
	K2iHXvacfNdfy1z9T0fYUWc9nPBOX0vrArGNF/wLasqRRjddUv2mEKgE2XforqnztEJU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7732-0006oq-K7;
	Thu, 17 Sep 2026 08:00:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7730-0006og-UK
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 08:00:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4oM52k/TN8plStmecEWjmmSOPcY+H8sLdnWpq4uZH5A=; b=WRSQYbnRXJ/jrCKJ7Ozd77cw//
 KQu3DvOPDdocSuU29M9XKHAUEzBfISlB4VCyNyB1TtddTiiYYH4VLLRRHxm1ePAHyDTBZAsH/f7Jg
 MejfQ9YlG76JKGDZLFAt5qlcAzZGXAKqq2vbljbqOx14cOzdhNxQVIcZmbhyTyLHJLiY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4oM52k/TN8plStmecEWjmmSOPcY+H8sLdnWpq4uZH5A=; b=C
 8QfC+D4BWCR++T3+6yccWVSGtnuQNT0mIFeM1jJmRRQopFBetMunLDN2zWjyuNZhDDxbY3NBXJtdI
 1eaSmkQm0DbfPrG111ihkl7N36WUJeLA2/dDj17BOfOxxSxk4T6tQtzdJr5/hQqiiYo5+ktvraZLS
 ZEkhLuNA74gBUbFc=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x772z-00057Y-Az for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 08:00:46 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so2747375e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 01:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789632039; x=1790236839; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4oM52k/TN8plStmecEWjmmSOPcY+H8sLdnWpq4uZH5A=;
 b=Ng/pb5zgZv+qvhyPXx7Rw01jfZI+Sy/qIaDvAfEwnliPGHMM9CzV0JQs3en/Xz0dQt
 GaHPthYgCfpP/px6MpQ9DcuZGAG/0ztoXpfG1J5dRVCrWlrcs7p33DcE+N2rAjRYqEda
 nK3HqLdrYllVebRUOexEw/mO0is15zRTBsN+erGXTVGkJ9+9MUWMQQFwVnEfZW3AYrVv
 OSgCorQLN+FWNLu7Zn+842t2Kzees0n/j9Q2F3p4BaQUY6JgvSlROO6A7Ce5uTD8YWJP
 fBvxwHUZaV8vwsBMvqJ/SW+JnCn1/aLi1lo3BsVJVZUsgMLwz75DgSYzLMi83vfD5jI+
 sOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789632039; x=1790236839;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4oM52k/TN8plStmecEWjmmSOPcY+H8sLdnWpq4uZH5A=;
 b=0aO959mm/De9oA10IQa1kTpWkjO2R1Xx78LqAs0A/fpJvNOr65faq2PaZlA2UI15Ze
 44Yf8CG2S8fcNVPQNt4fWctsvPil2oD5Nc0ljwtGMBEbhb5hiSEpM2juR1gUoExiWcox
 1Qqbl9X7SmhzUHRZms0anWa9+JbmgsCVhK0Fsc/sYg2ePC8SUX+UDyEzVyGMNybz1ytk
 uceJePuwGVhirA3gYXDvb/yhR/evWTzqjPFsbUmHzIYjWHZRC+Yc4Kk634hf32sRv9UB
 LlJcI5KXhfhcM07VfGxxkPZm/cbA8NIrtq79pdt9HOweFWQGH08R3JqbPpIH2ko+VYg8
 mpLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAkUVFv8nm05VdVf1FFsQXtbQU8C/jWqiCM+mXUSi5PHrIu1jeJrzbPU4xHd0ZXoXXjg2uGh08CMLMbKA3@lists.sourceforge.net
X-Gm-Message-State: AFuF++ngbeX7aDb3zKgvbOfZGcI+jEDJ2od97JTHCuKQA4CgXkjGxaYt
 qQ/+ylK8Ly+kLohTqdKVwQpSXWi0QtUI8RwBpOyLSxb7yA4oCMpNQC6Y0IP3/7iFG+4R4Z/jaCH
 KIK1Do+ATE5vrVBj4cz1FPsH1icvodR1U/NiFv8JjNBAHIlZaMJN4BKaTEoNsLFxlu4rf
X-Gm-Gg: AYBFou1ByfVa300ww+i0nJcvx2NjkkYPCrk7H2StnC4vGWn718wtVK4iDIa6UQ7uIV8
 LRpO+hgFsDwphvV1hu3od+/fFOnBFvPhzh4JvJeJEHlAw3Y/fJ5GrboCDExYwbNmC3sRjYRoN7k
 xah0mQxXdjvZSeYHeK2XgsSnwRHhmuXDsODVK1uq+CrRDo+BlPLPfu2qKBkycYFPnC9uZFtkI+I
 6U1y9p0Y2tZu2qYpDyOUpvJQuH6ue0iyttrNhqbn3FGxoKCH7ZPHeVlnS0vz2qRQtnel0BoA5Cq
 4RpkdGW7GVwIwdrbJtS/tngOh0utd5bcZMmAUhY3QTh7r5AfUNpuE5adVhHi2pxT9J31xUezDM2
 a/TkZ+pifKLcF8Lws9mriGt+AGAyPN1WiySlpxRNxO6hrUYiXCLzXOzq0CJTer/wDL5JgcGbejY
 s7b2TEcPZudXqgwVSb8WW3z9jUO8bxQYvMtATh3RQzqC62PSPtAODXq3H4C/6WDy1QL/w1CTsy2
 WxODbbPJc365+LwAM542aIemT6VLW/r8AbtbE1FhfrnK3XG3X8EUoy//zrFUI6B5oAsYCL33sUu
 odjrkn4XsJtkeOTtN+fQlc/fvk3YAjK2Pr3VhXifWVMrxTaEWLLWzJOLHjGC2Q==
X-Received: by 2002:a05:600c:621a:b0:49d:1d6a:4cfb with SMTP id
 5b1f17b1804b1-49eac463a00mr63573905e9.1.1789632038669; 
 Thu, 17 Sep 2026 01:00:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd2563ccsm66679275e9.13.2026.09.17.01.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 01:00:38 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 08:00:35 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 24
X-Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f9550d24894c61
X-Gerrit-Change-Number: 1749
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1749?usp=email>
X-Gerrit-Commit: 339db8515e5cf80c66ad78d8a56361bee1ac76b5
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 08:00:35 +0000
In-Reply-To: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
References: <gerrit.1782719911000.I7d8546da9ef06c2226ea77e461f9550d24894c61@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk3ZDg1NDZkYTllZjA2YzIyMjZlYTc3ZTQ2MWY5NTUwZDI0ODk0YzYxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dbbebbcc17cc5d0fcaeb15f46f3842667ee9454a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x772z-00057Y-Az
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Extract
 init_tls_wrap_ctx() control-channel wrap helper
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1511458395016495717=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1511458395016495717==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QXxgxALJn5E="; charset=UTF-8

--QXxgxALJn5E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

stipa has po=
sted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1749?usp=3Demail )

Change subject: oob: Extract init_tls_wrap_ct=
x() control-channel wrap helper
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 24:

(1 comment)

File src/openvpn/init=2Ec:=


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1749/comment/570e2e0d_26f782a5?=
usp=3Demail :
PS20, Line 3132: init_tls_wrap_ctx(struct tls_wrap_ctx *tls_w=
rap, const struct connection_entry *ce, bool tls_client,
> nit: This functi=
on assumes that `tls_wrap` is already zero-initialized: otherwise the no-wr=
apping ca [=E2=80=A6]
Done: the function clears the context first and the c=
omment says so=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1749?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
7d8546da9ef06c2226ea77e461f9550d24894c61
Gerrit-Change-Number: 1749
Gerrit-=
PatchSet: 24
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mand=
elbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attent=
ion: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Thu, 17 Sep 2026=
 08:00:35 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Re=
ply-To: ralf_lici <ralf@mandelbit=2Ecom>

--QXxgxALJn5E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p><a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail">View Change</a></p><p>1 c=
omment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/init=2Ec:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1749/comment/570e2e0d_26f782a5?usp=3Demail">Patch Set #20, Line 3132:</a=
> <code style=3D"font-family:monospace,monospace">init_tls_wrap_ctx(struct =
tls_wrap_ctx *tls_wrap, const struct connection_entry *ce, bool tls_client,=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">nit: This function assumes that `tls_wrap` is alread=
y zero-initialized: otherwise the no-wrapping ca [=E2=80=A6]</blockquote></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Done: the function clears the context first and the comment says so=2E</=
p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1749?usp=3Demail">change 1749</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1749?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I7d8546da9ef06c2226ea77e461f95=
50d24894c61 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1749 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 24 </div>
<div style=
=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_=
lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf=
_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Thu, 17 Sep 2026 08:00:35 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: r=
alf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--QXxgxALJn5E=--


--===============1511458395016495717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1511458395016495717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1511458395016495717==--

