Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71211606A321
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cCsbDolG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WZGOssuh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZvOUsquj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZmSJwmhW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=grICCieiQmP9Xh3iH87AdU8IfXJlxBMcMkJ1KGucnv8=; b=cCsbDolGpk4yO/JW4aMz9Fr6Sv
	U8zPDshZK185MkDRqWt8n6Mpg+FISQKzxf+Mywcp/qGECJo3/ZZ9jtvoZ8m7iKQpmfqzQl+6iAKsX
	1CGFvSVp+OCX+OzKBDmyKCZ4xvqEPS2D7oXzbPNMgt39B+ob/QE8Wb75X2gKmkGgssdc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQKr2-000000006l4-0bua;
	Mon, 09 Nov 2026 08:35:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQKr0-000000006kQ-49Lg
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 08:35:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uOqNgM2zJ+Srx227VKFBGquHZa0K7QiHZ9zXXsfMRb4=; b=WZGOssuhxnbpHqvHTf/+RstStw
 2AYAX0JZBwcJ1py7EiTHhTycxnswktqArKQ6+Nlp2fNLZx6KnJla7fpRb5CtTrlIBjfmh2HAn43MB
 QRboZKY2AyQuoOxiMEhzW/tcPorhOLzbWTzRYxbTO4KvOF2WQVeTB7cskTkKHBIrIDdc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uOqNgM2zJ+Srx227VKFBGquHZa0K7QiHZ9zXXsfMRb4=; b=ZvOUsqujtunDRcdzFcHmimtBiH
 RVezWmX96F94gs18cezvQ0LnxMphDFLW1tKzdEBHE39v7qSzvUGfBAfjbC0hyuDspJx8Itnpmv1yD
 6uYo9xEvNzKi71X1iCJI3Qmp6d3FNa6p+FJF/h1uDy16AKG21EDBEH6e9xdpt8isfyIs=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQKqz-000000006BT-1aya for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 08:35:50 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso351181f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 00:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794213343; x=1794818143; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uOqNgM2zJ+Srx227VKFBGquHZa0K7QiHZ9zXXsfMRb4=;
 b=ZmSJwmhWWdMyJSZ/W0FSRjF/jWKlerPMt5oPsiVjqUBxrxN78KjxV3+EdVW98CKeo1
 w3DTGQG6arwqd4+bEn0V2yqe6GlLI9azHtegylMWpMLSnpfI+68ME3CbdobfZeAFmeG3
 sxC0pm9Sk0BhhOFh/S/4xCXhAvsZ/VkItldztu+HWBSKzqQpGbF0LCXZwcjIQRdvpTdw
 RBnN2ItwoWn+7yMMHaGRTAH2xdEfsbxCEr9rbgBkCyWe5itiNDvDwoGUiMSTQVl07F3x
 CpNS5AzBparBxd9RSQ01oMVDVZp19dNEe23QjiQHFfI93gLj0k7ITJ2qwoQRo/4o5ZU+
 MZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794213343; x=1794818143;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uOqNgM2zJ+Srx227VKFBGquHZa0K7QiHZ9zXXsfMRb4=;
 b=18VVwVK0RJhbCtAiTpeLk8XpyF9IwBapXAOSuMJmO4p6S/wIQwZdXOsRqZULRqE9A+
 wlXyEn/qqN5SStvo4qFN0tPCSnKkDUbggtb3ExoLc9DX0MmonhByKnuLstdmiWpcj4KD
 j4M9ScKRTmBb+94pnSzDnwTitdKHQ0gyQCRHj56Eeeu5i+JpKutX8ZEpPNwBlMkJ/wwp
 jHP7TcL9VC1ZAEP08hJ3a/DONV0rkQ+H7NvedgJm9psh20E0xOFs8iqN+tLkH0NRzsXc
 92vj81SboLVsmqqyeMYBqEbhIh4SUOOXlcYnMfTPMP36D4puuRNNQi76AcweE6tzG8hB
 uscg==
X-Forwarded-Encrypted: i=1;
 AL+hErHN7E6kYCv4SsiIAKLj8JKDMekf8DM3FJ+lPXil03jBugGhu0T8saVMDuNnkKtQQLgKZXgl0VZ9dfU23Bs2@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8Rt2EQI98cnM3Ln00Zan4XpYpqg0DV5t0diq9YnI0LluEfZ4Yy
 wEhNY9PoWJraztjaQGjH4OdCAGJnQqMby+pCaI3+3HTkM1YQanu4y5eHVN9cmRp+RUqqC0DNtYv
 vGWAa7zFQD0IR0h+MK6lWR7wkENTJxj4KzErDO9auf9ZmanOlFovUd2EvI1TMkuVr2NQei56JHd
 gZFeaIQQ==
X-Gm-Gg: AYBFou3OW5yfCfIYZo7JnoFVonDdsBuyF3N0fWJ1onxPWIci09KPpFHLrKr1JemMXxE
 T0RGKE43j1DJf2EM4DJnBABA4Rh290pS+SkUf96CMN+op4P5U1Zb9uopg34U5MKW9wnfGcwt3Fm
 xaNtI4oQ7FS4ppfFJ1Vg1ckO28IAYNpaoc2AdNkOQ8yvfKMp+/mc0u+pACdstIM1kYM3CQW6DC3
 cuTswvPr89ABxPI/8Wa4dldD82ly6TeJmYVO3TAnFM3YF6y8YcCMEcy7ZRLG2+bpvSfqgTqdfcs
 q23rr2XNuoIgLLdGmLXmPZ8Rs7kBp651U9aIwp2g8Xyxx8msis9fh+gsi1m4JwFLAHtvcxPpyiK
 lCK64tk2emsCApzpgPGuPYX51Z6ew1Q0wqZRb7q6WC1ME46teontaLIQSoZb/jj4szYNCxzx81i
 Pyo4tWiw19AnPQvB0AOwKnp6O174IBRbMI+DdtWjwiYxS++ZOqQQSWS2dJLlIO6IO5s/4oem1eK
 hKSVUqceJhB6dg29vYN0r/jHQ8SrCofay0A15LTXFqdJMn9IGk0zH7r5XbYgNeM8A526Qdt1Bap
 0LxLtb4hk51OqPQNncICOCnNrN1iW3cXGFQoftDTYAR3G7cRd1eCrOD06T21OusxB35N3cJfikb
 MFgJ1nhu69FKTszbDAtJQkjju8cl68PC3uf9HzxsmUZg/MMT8Hv2Fyj0RAcMc6zrlhOxNmZtE88
 K3MLy5Ay9sr9ALHHK8p6LpUrZ5vbUm0iHOn54=
X-Received: by 2002:a05:600c:4747:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4b963c7e7e1mr67494725e9.17.1794213342584; 
 Mon, 09 Nov 2026 00:35:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b795024730sm159231965e9.4.2026.11.09.00.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 00:35:42 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 08:35:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ied9e36d45b30a88610cafee668ecefa98b29eddc
X-Gerrit-Change-Number: 2146
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2146?usp=email>
X-Gerrit-Commit: 8b7e241ff25b9ebe71c56cdf0a3b4d7424cf252b
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 08:35:40 +0000
In-Reply-To: <gerrit.1793970201000.Ied9e36d45b30a88610cafee668ecefa98b29eddc@gerrit.openvpn.net>
References: <gerrit.1793970201000.Ied9e36d45b30a88610cafee668ecefa98b29eddc@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzOTcwMjAxMDAwLkllZDllMzZkNDViMzBhODg2MTBjYWZlZTY2OGVjZWZhOThiMjllZGRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1740a8de6d27796b71124ed13f7ccab650507c52-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQKqz-000000006BT-1aya
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: reflect_filter:
 zero the rate limiter on allocation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0419401410140195725=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0419401410140195725==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0B+GTJNZNSY="; charset=UTF-8

--0B+GTJNZNSY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Lev Stipakov has pos=
ted comments on this change by Lev Stipakov=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2146?usp=3Demail )

Change subject: reflect_filter: zero=
 the rate limiter on allocation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/reflect_fi=
lter=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146/comment/ddba5d6f=
_ac98f1a7?usp=3Demail :
PS1, Line 97:     irl->last_period_reset =3D 0;
> E=
ither have all fields set by =3D or do not se the ones that are =3D 0 when =
the object is cleared=2E [=E2=80=A6]
Went with =3D=2E



-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Ied9e36d45b30a88610cafee668ecefa98b29e=
ddc
Gerrit-Change-Number: 2146
Gerrit-PatchSet: 1
Gerrit-Owner: Lev Stipako=
v <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Commen=
t-Date: Mon, 09 Nov 2026 08:35:40 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: No
Comment-In-Reply-To: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--0B+GTJNZNSY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Lev Stipakov has posted comme=
nts on this change by Lev Stipakov=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2146?usp=3Demail">View Change</a></p><p>1 comment:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0;"><p>File src/openvpn/reflect_filter=2Ec:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2146/comment/ddba5d6f_ac98f1a7?usp=3Demail">Patch Set #1, Line 97:</a> =
<code style=3D"font-family:monospace,monospace">    irl-&gt;last_period_res=
et =3D 0;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">Either have all fields set by =3D or do not=
 se the ones that are =3D 0 when the object is cleared=2E [=E2=80=A6]</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">Went with =3D=2E</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146?usp=3Demail">change 2=
146</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2146?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ied9e36d45b30a88610cafee668ecefa98b29eddc </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2146 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipak=
ov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Comment-Date: Mon, 09 Nov 2026 08:35:40 +0000 </div>
<div styl=
e=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:no=
ne"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-R=
eply-To: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></h=
tml>
--0B+GTJNZNSY=--


--===============0419401410140195725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0419401410140195725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0419401410140195725==--

