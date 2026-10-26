Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D34A606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=is9LJF1e;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NFwJPkps;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=nTCezf1M;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DhOqwCUY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FJlFqI1+79eV0UocrhT0mNBCgfUMBfi5UBpcN0xJjNc=; b=is9LJF1e4gQmNz+wHgBakHl/N/
	cuZtxf201TjnaBgtFA8ese9pIFWYDbctqOLJca6BNYQ99xuZwuA/CWDH3RsjrLQnyMDy5ujiBdzEC
	17725QCPMtOAaQUwDpljzk6OtS4935vkofHA+uHM8d9H4/FvNkXnNhXT7Ik4HHF3t8BM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLIQS-000000001oG-3RLZ;
	Mon, 26 Oct 2026 10:59:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLIQR-000000001o9-2rIC
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 10:59:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=USNSztxl27A9PSX9xglQ8Mg5jSMWYCV3p2nQ7EF8kIA=; b=NFwJPkpsFps82/KKWZn97SZ02V
 V/G/C/rNrsXriEAiRsSZ9jPFw5g4UIPRLdznZuf3sgHljGPmhXhOyBdLgM9dl6C39GyzogU2rJBXy
 dzU+rOd85i1pffJwv/r/XXVVcqKBKXwzcnu7OCTbkpprR7fsf/cKOVnBqUVjpxdW7TAg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=USNSztxl27A9PSX9xglQ8Mg5jSMWYCV3p2nQ7EF8kIA=; b=nTCezf1MpVdQLuKY3xFtR7mVoi
 FMfOXD14Pi/oQRH7bDFs4N1410v7w/XKpH9TTPpQGWpeeKbfBtLHK8l5V1bTFvTPaS2GyO+K3OGm3
 qDDQPcS+EucrO24kGaLvtn4xv6xRuIiNTFQFBVW9AeVt7ZNXy/lUuaKzX6YXPcmP4MQA=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLIQP-000000006Xe-3fim for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 10:59:35 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so32844105e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 03:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793012367; x=1793617167; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=USNSztxl27A9PSX9xglQ8Mg5jSMWYCV3p2nQ7EF8kIA=;
 b=DhOqwCUYRkAz3ogybKFK4UGCRWjc+ukCs/26LbBbN1vayhrBdIVJwiaQd6P7QE/DCb
 PkmtFhDq6P05qkeauAjVGxULWNF55lWEXLOa5Zw6EuzFpAZiFZdVQDMCvxqHuLQhSYB3
 bxMXmYP+KqlzFuGgd5P/mFa5JJGK2jnN3acv+UFlnwMCxNhy1Vl2zK6CD+tdBcMwmZMO
 apI565yUjFO1IeNZv2JtCjtYXSDNThs0KJcDokm0MTZXJV3QBqYk+5PmMdrktVN9i83H
 rBojSKimTVPYxGnkc9EZjeplKbSko52Vuj4Bt1H6hsnW9CR7ILGwwgUvdzSK6B0XNTEJ
 19ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793012367; x=1793617167;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=USNSztxl27A9PSX9xglQ8Mg5jSMWYCV3p2nQ7EF8kIA=;
 b=1/DzZukM9xyrByGxi63rWgCIYRTr/j7s5OxqG0Ouy0QPIvHd5H0D8r0H1Fhx4rjGkP
 XTcm45t6MwxsAepYMnVRMoBSX2oUM56/dCjxkxFMC5YnMHVrBZZik1VLM6lH3pHvSL0w
 IS9E/Jh4hg0WkHArngFQ/GQBawEov+0zWkeWf7Kt9t6g2tvmMRN3DAMnfNn7exM7cqXA
 F97lxjHhVHk+2QKA6B42xgO2OxLwTN2dkMnHCuQCzinMU/OuzYyyzRuG5rRW7pnkwe24
 zEEIrM8GCjkZXDWvqQN8wiP6iakYDndRXB+kv3FQBwGeUPbIwLOd9P0OPqOPJxoqmPMD
 6svQ==
X-Gm-Message-State: AFq9FYLPjja5izjRV4sxhwW6kMryFEwIRkCKTamWLIv3nNBqfNpVDVa5
 P9piQlVV0wqEVMBEYKt+Jx7n3F1kjwYGjr6WK9cgHJmKbiXM8xLvwGQbaRnGhvE7FGqUotbPk7h
 mV8tz1F/oL/h3pYdORNuSLDwHP4kKAC4uFDM+urtrVOal6A6CnECu0vf3+SzIroJZL7Mg
X-Gm-Gg: AYBFou0P5tYuoZE0ve//iPQn6kQeUMMSyDpGUqA+zT9t80SVr0ebYMHqZNFrulry4PB
 q55pJkv93wRq5JIQj4pRZ2L1MwacgsFYhQl3KuP3NHEWal5Nq0NpF7/ULBdZSxGwKsUkMbd64+9
 3TeASBXRQSpzeYBmO7ioWuTeCW0Gv57vATvg3rk0nMMyq2P5PXmraZ93emRduEXReIPmCI0Rfxa
 aetuq/Ad7zo9M0/HM6acY8rp4+ay3y7r4UNar5ilQLag/ZaCK1pP+OJ+AZX7Pjsnt3hXZdPVYpj
 YGX2E4cSXnpUgwmp9LTYm9gNkwJF0nMDxTjX7qR2REDq4G++UEZ2JsCUsaa74WKgOPDQDQcbkah
 P/TpgyhDs1u82h/XdzP/s1WmMuydCQn/aY21Txtr0QvxwhbLxzFYbZ/6Fjj7njiFRBudYvnG2Ks
 U0Mr9eHWhgxbwsqjabOneSAQLDlotYOxKHYMhGt3t9msQxm7HVP15T5eRvRtJTZk/O90D0ref6A
 9FU7YrkxVY8vud92fRqS+VdfzbtaXNosu0Kr6fZz8fqxX1NGndhnPJQ56kmCzNZgn0KUCJcFDpw
 d106jbir/VfA3zVadfPPWJ46tTR71UZhHwDNqhKHbHaqDD8BN13TghWuoczBURQsnQRQMz0QU6z
 r730aRU/9J9qdFgNq1kg0bkdYdJvJUJKzjy2EOeLjmQ==
X-Received: by 2002:a05:600c:1d01:b0:4a1:ac66:6ac6 with SMTP id
 5b1f17b1804b1-4a35acafdf5mr101956395e9.26.1793012367248; 
 Mon, 26 Oct 2026 03:59:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f3e00asm327165485e9.0.2026.10.26.03.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 03:59:26 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 10:59:25 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I136d57b7487f228e37894fa710b1ccc2c4606eb5
X-Gerrit-Change-Number: 2031
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2031?usp=email>
X-Gerrit-Commit: add6d94d1fc4685974f158c6e4ac7e32ed8620eb
X-Gerrit-Comment-Date: Mon, 26 Oct 2026 10:59:25 +0000
In-Reply-To: <gerrit.1792963979000.I136d57b7487f228e37894fa710b1ccc2c4606eb5@gerrit.openvpn.net>
References: <gerrit.1792963979000.I136d57b7487f228e37894fa710b1ccc2c4606eb5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyOTYzOTc5MDAwLkkxMzZkNTdiNzQ4N2YyMjhlMzc4OTRmYTcxMGIxY2NjMmM0NjA2ZWI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f86c71ae83d85a645ba1596029f29f4e65b760d5-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLIQP-000000006Xe-3fim
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix typo of nprocs
 instead of nproc in run-cppcheck.sh
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8265401980241732361=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8265401980241732361==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oqm1WkYtTDo="; charset=UTF-8

--oqm1WkYtTDo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Frank Lichtenheld ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2031?usp=3Demail )

Change subject: Fix typo of nproc=
s instead of nproc in run-cppcheck=2Esh
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2031?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I136d57b7487f228e37894fa710b1ccc2c46=
06eb5
Gerrit-Change-Number: 2031
Gerrit-PatchSet: 1
Gerrit-Owner: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antoni=
o@mandelbit=2Ecom>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Dat=
e: Mon, 26 Oct 2026 10:59:25 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: Yes

--oqm1WkYtTDo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 1:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2031?usp=3Demail">View Change</a></p><ul st=
yle=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2031?usp=3Demail">change 2031</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2031?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I136d5=
7b7487f228e37894fa710b1ccc2c4606eb5 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2031 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 26 Oct 2026 10:59:2=
5 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--oqm1WkYtTDo=--


--===============8265401980241732361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8265401980241732361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8265401980241732361==--

