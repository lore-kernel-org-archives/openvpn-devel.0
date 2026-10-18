Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C6ECCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 06:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VVXFiSAGoIWeNOqURYFfKd7aZLB2DGrhPsJe0GrMLZA=; b=H5UYUaWJ2DK5UWk8FaBZaPVaPm
	tH/TDQ4imJ5g8gLNpSMLzTZwmcgvIPKw6L1wJl9LVG8BUtFy4MfyDjFFOtIluxwRMw84WrCs3Qo43
	iiHnaH+YRpjJ0bwbC50XO/HASBZsiKr16GJF11INr0icKl53BcObvI5c8WLZSKTsDuP0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIKjB-0000rh-Fa;
	Sun, 18 Oct 2026 06:50:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIKj9-0000ra-EK
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 06:50:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=adpjFlKDo8WJvSyKph1XeDaIGzeVvUQ8Nwq1k8Dx0Yg=; b=S26zZRnT9USOVUMSZJZn7+w7Ij
 hBiIaKDEvCrnguP78kS7fqh4/LS5rm6QrmMPUR3064aH583LG/ih6uD63dJRHB7pGhwT8WE7R7A4e
 EB7BsD2CVIjFZRwqERtmn/AuCu5224GycbLVR1dcb71TJKfaV9NJkjoT4avCepP6mTrg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=adpjFlKDo8WJvSyKph1XeDaIGzeVvUQ8Nwq1k8Dx0Yg=; b=K
 AGFScvjCfC7lRkOEUkR0b2NLFtGC3FveQA7KAZQv+IiR5a76VSkEoM696wNSBXhbKoBAgrclMNAew
 UjkkfsOMhY4iF68th+RJ/bgnykBsXtUxLrvfFqskXiWcP6Cgkv2KGK7Ki2H3F1gN3o3K1X5BbfaQO
 18aQA6STwj9BBrQg=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIKj7-0004QR-Do for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 06:50:40 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a1e2957d7eso2089465e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 23:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792306231; x=1792911031; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=adpjFlKDo8WJvSyKph1XeDaIGzeVvUQ8Nwq1k8Dx0Yg=;
 b=bTnA6kK/jIBjtme5lhFU9eYyY+5iKbXJbdGdhmebIzjFpqP2yvWzY5ARLN8sSGr8Vu
 RD4plYElQ4Koaaz/8k8kUzfJeL2QuC0FMXo/UivuN0BgCfNJlsIaZaO3s7owg8Z/yjA5
 H4jQymifMjgTvzCOZr2rMHdDheRcr+gd7exTd+Dk7eJTZjwAjb2Nf64XPTDdeEFV9ot8
 ThhPPeS/c4FD3pXVM9hyO0NzYjYJGCMRwRxVFwGVT6bOvcwQeBEkJTHZP/PMTxsbsRaQ
 GDS6dj1YNizCXJWS09TXfhrp7MIOJDCcbdc3urabo7VLIndNWf9rxQk2tzq+9o08hntn
 R00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792306231; x=1792911031;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=adpjFlKDo8WJvSyKph1XeDaIGzeVvUQ8Nwq1k8Dx0Yg=;
 b=eUep2dVet4n7YFjzRMB4reqq9LHgTxvCKy70oY+2XvDzFnw+A7TSUBFGinUzzuN3Z7
 vdenoyRTdqzU7Y8FwU+I5uNkcaIX70cnUOMCQmqJEWPJ9GTZ8M4bqu+dG7C97KZPPzTs
 AFLXA+vxBIhHuSPKmZ6a2Xsffo7YkIAUwxuzEWkLDwLh6kneTYtQ/4U889X3NjL+2YFi
 nX++ttaTWkWbQq1+IdKaXnP+4CiRHRZ/FJVe2ZCBFT39PaMxK79bPTUei38F/wb39dQM
 zpsWcmrOK26PzDByvSjSkPtO5xcZSw39jOFBRud1NUXGm/w44C78N6W9d33JZFZfX39C
 p9KA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjkK2TxrUWT4zyf/k6N1H5er57OC7E1LONePgx4ee0Wi3AuxvPGN2M8RzIh8/FLPgwFP6TE/XQO1GdLaPg@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJWJrMlIocC6e75JLQxjH3RwUq7pFsY5ZQ3EN9Tt7K11VWRY+Tj
 x010ojbz5rDEUy6lRhYSWkaay5MWjVpjLSk4vNmhQvXkQlis/0Rg1H3j1g5csf8ALyHtGW+CNm9
 wa1szJH6dB6zZ5Ye3hnM8eTw4HS2eaNrgvn3fZ7eDyZkTkWgpJVY/8Sj9XJgRmQtvBkQ6lDEn+W
 AI67CqkA==
X-Gm-Gg: AYBFou1cGRvKcThg1sHGChUD3BBZHAz93rQtB+EITPYhYwmDp/gw6WeOUiooJJVlqWb
 R+wSThFyzkhNRpqmOjsP99PJNqirRFyv9SAxF7ppVjuVXOcjH6emkdTzHh0i96El4ctp2vl10U1
 x0p3nLglA5HyfDJ4x7tBseKEoGxO8DBn2a62Ofa7xwLEZKdjF5QAD1QOpambgXEk4IHF44riq82
 Kj+TL0dh2mh9EVJAYZRwfrZ2c1kX/AIKauR2fc9NKCgbLJ+5csLn40HGblyBzhODQRYymGjziZ9
 jef3U/v6PwsfkG3pFmNeLaGNTxMSlpcewXQQQrH0D1kFGRU3Wore8rA2nLpUIfNQ/2UoxOGk3t3
 pyR9KVP0FcCPTlcIUmmhBVqAONXF/r3PBcsDzDMABEtwttzGIL0Xf7EOZ+McqG1bxg6gqVqfvtU
 vyZe3MhZXbnXK5C/SO2VQXZ1YwwxA/mJPjt+Ap4rhrw/9UV/hRf867CuoJAUfxENJlXCjVC31WW
 hU8VyzcCjV9Ztu4IuXwNSfJp6bNNyZ4rvvOOplMGkw0DM38b6Iv4n18+6KWRhMMrww/YzLlflvR
 7eBGPkgODxXwpLBVv91g091imKrf7hTGYNKf5iFNu/JiX3MKq9GcMilZI1WW9GXJvZao/Yo=
X-Received: by 2002:a05:6000:4288:b0:48a:fbf7:15c9 with SMTP id
 ffacd0b85a97d-48e079888a1mr7990873f8f.1.1792306230218; 
 Sat, 17 Oct 2026 23:50:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd503862sm15120668f8f.46.2026.10.17.23.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 23:50:29 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 06:50:27 +0000
To: Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3513563f199e1c5ac98219a527695e40540a9f73
X-Gerrit-Change-Number: 2009
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2009?usp=email>
X-Gerrit-Commit: 932aa2cc2f4bace8dedb736f1e1e1652afe7e970
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 06:50:27 +0000
In-Reply-To: <gerrit.1792274029000.I3513563f199e1c5ac98219a527695e40540a9f73@gerrit.openvpn.net>
References: <gerrit.1792274029000.I3513563f199e1c5ac98219a527695e40540a9f73@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjc0MDI5MDAwLkkzNTEzNTYzZjE5OWUxYzVhYzk4MjE5YTUyNzY5NWU0MDU0MGE5ZjczQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <860e638491762c426bdf62e034adcb2d1a830572-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIKj7-0004QR-Do
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: gen-sample-keys.sh:
 Don't apply server extensions to CSRs
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
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0740816352715939992=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0740816352715939992==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lgsRqJ91T5o="; charset=UTF-8

--lgsRqJ91T5o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Steffan Karger=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Steffan Karger=2E ( =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2009?usp=3Demail )

Change subje=
ct: gen-sample-keys=2Esh: Don't apply server extensions to CSRs
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2009?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3513563f199=
e1c5ac98219a527695e40540a9f73
Gerrit-Change-Number: 2009
Gerrit-PatchSet: 1=

Gerrit-Owner: Steffan Karger <steffan@karger=2Eme>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: Steffan Karger <steffan@karger=2Eme>
Gerri=
t-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date:=
 Sun, 18 Oct 2026 06:50:27 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: =
Yes

--lgsRqJ91T5o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Steffan Karger=2E </p>
<p>R=C4=83zvan C=
ojocaru has posted comments on this change by Steffan Karger=2E</p><p>Patch=
 set 1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 =
2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2009?usp=3Demail">View=
 Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2009?usp=3Dema=
il">change 2009</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2009?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I3513563f199e1c5ac98219a527695e40540a9f73 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 2009 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Ste=
ffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Steffan Karger &lt;steffan@karger=2Eme&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Sun, 18 Oct 2026 06:50:27 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: Yes </div>

</body></html>
--lgsRqJ91T5o=--


--===============0740816352715939992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0740816352715939992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0740816352715939992==--

