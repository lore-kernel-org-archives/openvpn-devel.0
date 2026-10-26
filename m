Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D2B606A323
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Y0ld4tWc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kovjictb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=btcmgVx6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=b26tgxX4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=K23e6WinSF3T6hSf626JIR5sgYrea2OH7HnqiNVm7n8=; b=Y0ld4tWcnYc8vg9/GlGR1tuEZe
	IrCUlq+FlJZz+HTtckoFYDpGDZljjRSw37gGZWENs2LyE8RHlMYPE8NJi5LSfPZtCYkXE69hBlyQd
	Yu+QnSEe7eXt/XkvP+x/XLk+2xQj6tDXnX6+XN1PayHwsGpig3XP20HRDgP4s4CGVXZA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLGmD-000000004Hb-2FKN;
	Mon, 26 Oct 2026 09:13:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLGmC-000000004HG-0e7k
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 09:13:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cBaqpLq0LJNt7qlv6G+ec2ujkYGlkF+/S40e2DwzUoI=; b=kovjictbI6kVX9SkDuxvL8E8QM
 A3JOwcrpSrGKGJDiHQhegvzl5AXl6Yk9z3acppmGBp1MNQuL0aEKIaQTiHpqQrBwepyEFRJqu19DN
 0U/tyKz3uB2sXDZn2wXNvmeVuC56ShWw7vUO1HtYCIMqJ6gbVpCI94X6YYPFjJgXjXOI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cBaqpLq0LJNt7qlv6G+ec2ujkYGlkF+/S40e2DwzUoI=; b=btcmgVx6tkc+dNKGOQ1MB/9Y9X
 A/SgUoeLwBu3fDuc8+u80Zaz61gVDxqSDlvDC2W6iknvJXL6Yy8YyrkLPkTbhaejMumY6OCSw75HT
 ut7SOpAnlwBzPjmSWL0bL9n5ZbnNvqSWmJNuMEwNFMsTF+IO64FqMUyxHTTEbVhneF9g=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLGmA-000000001BH-0Uak for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 09:13:56 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so22451955e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 02:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793006027; x=1793610827; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cBaqpLq0LJNt7qlv6G+ec2ujkYGlkF+/S40e2DwzUoI=;
 b=b26tgxX4hA4+QYFcU4ftSPmF9sxN9ZwZdk1EysLCnGQtb67hutMI/c0nXG9S+V0uSX
 lnZm/MKNUjNmMaz0e4YQiXWdsgD1c+Ds0qLXqj17xtlZuTo9vXBkqP6TyojaYRsgOVVn
 xuigcHMizVAjw569vOiRnge0vff05xt+c26OZSRubOximPyZQdj4/NaQiyS7P4KO/2cc
 nZXSff2hyezIRNzs+g7Vy9yrRl5jmfU0d8rtpxLkKqxP6WAN5OMSI5Ecej8we3CtIr3H
 Bx9CgRzG74Ws7xkVpjD0kuODXfb513nTf/4t7cMb8oi0jie4UARxzIvUg1Uz0vWFcvtd
 oMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006027; x=1793610827;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cBaqpLq0LJNt7qlv6G+ec2ujkYGlkF+/S40e2DwzUoI=;
 b=VbVnE7iMxPVek8iUDP+Wh8dmUoaTC/isDJShY0rASy7Msvjg1i3vOqakzT/lVawvIZ
 WJ9jsd4v+PorWMPqtqDyxOZEYZx3PMo/nyLFkIm2IHO2895w99nlN6vuFL1qx97tSpi1
 B4fGjBaa1T4po1dMyUnvtkKkm/WoZImtchnuG7rkFAXtv+fkPrPYI+t78in2I013+pXG
 DKSs5WH1Fen1Nkbufllv5vApHdP1NdTxdcR0VTQJZwt5tzxbwn0yg07pJyfQbb7qsZWj
 48scb3NHsgXqMb5XTfkQ7r9JGLPI/lqQ9Y9MPmIYCqZv2FP13D1BnZn8y/sRs76CwAik
 29kg==
X-Gm-Message-State: AFq9FYJVKLs38uupu0Ujh2/W1WfwY5hgIL9sGgdUzPQowZVn7AJbVf7d
 +mFL0ApJsTzQswwN/0OzgrfjOqiDoIP0ouGrDliVQO0yhhsQvVHiFSNovKU2/ufvfyiIKjnbhWQ
 2Ser5+NT3Es8E1Bky/ZxrZZ8dBRmn1CiEADvImncwMP5BHMJ7Zx4bmhCnwDxit+/CWyl0fK5eM4
 bCgQHgbw==
X-Gm-Gg: AYBFou3W+J+H546JJ+vDriGU8mIJCRDS9acw6ZwrO/rKH9Kl0caFO1fgktCB8vKnr7b
 /6L+d+DyFlXKVF0VDzZLhSE3UBfNe+ginZRU+4jydZVZp1VxbFm85a7Yw0qaaqWd75y7K2G7jxS
 QN7CSE/bb122nwowMDHuEcW56BQ2b6vVgsjslkCmAduHL42oh/Twkez6iNcBAQ+kXQcjvxK8rrt
 5YJ2rDRzHWZWn40YDUFUEXzP/EsRqAdbhaQd/H98oGBpQOSH0zHTuVyc6qfUYH3o/44o1wWNzdP
 flJP14EpEmzsXU9EykymUeaPgV4LP7fxlfpOfvA/7XaWS/tTXo75o/eYnSNgV6FT0NCVHOTwc13
 4mxhf8stpcSLOJrg9VEZCyP7/O5od41iZPxqQ9AQDZk87Mtkd4jsvMppJi4OPsffGWVu4A8pXUQ
 ruY52HsiS3YWch0KCi5xBcFMtoCV4HqvureT2N0CrnGomHro8zX2aAKtwMQLYvF32+k4+r4ORXU
 dRuTzBReJvIm9ZlMRtajsKDf/6ZSuRF7640iNlP/NpoPT7WUb+zvIXXC7hBfjLUQTWh1TvXxnbC
 mz6tIwqiGjzAfN3R/nk0+Ug9YwhHeNLMyKjsnGV/cn/nuooAd9svDRYNfFiNOi8/CQvFM6LgHSA
 PtSXx34/ui50O0WPv36YGFVyLZvMpw81xDu2AZS2b9Q==
X-Received: by 2002:a05:600c:609a:b0:4a2:fd2:985d with SMTP id
 5b1f17b1804b1-4a35ac95969mr96609055e9.12.1793006027402; 
 Mon, 26 Oct 2026 02:13:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0cc374sm187612635e9.9.2026.10.26.02.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 02:13:46 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 09:13:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727
X-Gerrit-Change-Number: 1786
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1786?usp=email>
X-Gerrit-Commit: b255adb97204820d2345d6ba30c1de5958bb3f28
X-Gerrit-Comment-Date: Mon, 26 Oct 2026 09:13:45 +0000
In-Reply-To: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
References: <gerrit.1784067448000.I64e0850d48647a2c0e3d385c2f20a9f445931727@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkk2NGUwODUwZDQ4NjQ3YTJjMGUzZDM4NWMyZjIwYTlmNDQ1OTMxNzI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <042ca5493b2f8c298dc9addb5f39e448de80e205-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xLGmA-000000001BH-0Uak
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multi: assign IPv6
 addresses from a tagged subnet-pool
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7876485191184200183=="
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,MXG_THREAD_INDEX_BAD,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7876485191184200183==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="08FpNEvRG0E="; charset=UTF-8

--08FpNEvRG0E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli=2E

Arne Schwabe ha=
s posted comments on this change by Antonio Quartulli=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail )

Change subject: multi: ass=
ign IPv6 addresses from a tagged subnet-pool
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 8:

(1 comment)

Patchset:

PS8:=
 
This needs to add strlcpy-compat=2Ec to the unit test to address the link=
 error on old Linux distros=2E



-- 
To view, visit https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1786?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I64e0850d48647a2c0e3d385c2f20a9f445931727
Gerrit-Change-Numbe=
r: 1786
Gerrit-PatchSet: 8
Gerrit-Owner: Antonio Quartulli <antonio@mandelb=
it=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Mon, 2=
6 Oct 2026 09:13:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--08FpNEvRG0E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli=2E </p>
<p>Arne Schwabe has posted =
comments on this change by Antonio Quartulli=2E</p><p><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail">View Change</a></p><p>1 =
comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?tab=3Dcom=
ments&amp;usp=3Demail">Patch Set #8:</a> </p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">This needs to add strlcpy-com=
pat=2Ec to the unit test to address the link error on old Linux distros=2E<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1786?usp=3Demail">change 1786</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1786?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I64e0850d48647a2c0e3d385c2f=
20a9f445931727 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 17=
86 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Antonio Quartulli &lt;antonio@mandelbit=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;antoni=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Da=
te: Mon, 26 Oct 2026 09:13:45 +0000 </div>
<div style=3D"display:none"> Ger=
rit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels:=
 No </div>

</body></html>
--08FpNEvRG0E=--


--===============7876485191184200183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7876485191184200183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7876485191184200183==--

