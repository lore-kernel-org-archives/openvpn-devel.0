Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEAE606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RCAD+AFY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CfeLAx/t;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fzuJtj0J;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LpOKuZ1X
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=By0SOwa5mkgT18CpKjlSt8PTWoq0l3ieq3El0zIUNu8=; b=RCAD+AFYzPe8k46eq9foqGqfT8
	SIgI/UBfZxBZ31Z/zMyu91W0my/RRmo+yxk8J3nx0YKn5CIhsd4zPu4xkomubFGjVvatGNM40roij
	xIdH5F113JSyaJ7BZqWRqmKrQZeh9Wv4UbePgDu9l1dDnf8O2gN2blhTrC5CVS9Nawi8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVpTL-000000006fV-2Kge;
	Tue, 24 Nov 2026 12:18:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVpT1-000000006by-3bNR
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:17:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uBiOuHY0WE4tWR66Li+knyGE4gBULLJUNf+EYO8LFfs=; b=CfeLAx/tq7dchviILysbaDtLZ2
 S0Z2WHTwdVsAOCAhNj4mzj3FizS2dXAKVo0vSI7l2je8h/XRPn8FNXc0szk8VjtkJef41VuEdQNLq
 t+9QPd5AN9Hh6mEeoFX0DhIAVFjiv49TmZpmYS/RJFzmIc3LKTEWjFFHJngUCzkWERa0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uBiOuHY0WE4tWR66Li+knyGE4gBULLJUNf+EYO8LFfs=; b=fzuJtj0J24H7vDsYt8+HpOTMUe
 yrO4o449NafgJO/hZGFs5j/NghvkPSTBp4D8CY4ykbyJLzjv03ENPMfQJRSRc1Ct1ups2JlB3Ip6k
 2lK5V0X0LHIy+Sd/GgqwKirpafzQfviBGEqfwtO6z60a80t9ZVYKt69Z8qYPQG2FvTRM=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVpSs-000000001b1-21Gj for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:17:39 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso35072455e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 04:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795522652; x=1796127452; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uBiOuHY0WE4tWR66Li+knyGE4gBULLJUNf+EYO8LFfs=;
 b=LpOKuZ1X+Kt+NQ4gZl7cF9Pn+B+MaebLfoseKlw6YhbWhP2gASEjkLHDcAlJXCXNXJ
 urzcugjP/2z8AFfsmqkFSCG48dbnmIitTkBpgYwUYKpg57TQKXTyOj9ctqOljG8hoR3h
 ecrqddwUFL3GRMgqlpxJQ/NTD1sHNhTSpreBLT9lZuooxRga3QanK3SMsK9xPkNUn6VF
 iNPclev7BcgG8V6MFYCxYGKG5828mWnjr1qJHo48RhBVHEx7CaQX1y+PYs+k2WjDxAEk
 pEpK6/19R1VhBj9BYAaHQ+AjMa2+QxXCs34cIGdci11+L/ee0FmpxKS3znweWeuvc8lS
 AFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795522652; x=1796127452;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uBiOuHY0WE4tWR66Li+knyGE4gBULLJUNf+EYO8LFfs=;
 b=YXcQNF47RCdSEMguIFkk+z3vGALebgN45nQ0RxfCk1fMu1HLENDXojA/eePLKR20si
 G03s7UxROKAGc1azSSjPAag+HHd5EZk6vwp22Ir1sWRi5YORXXLu0/hPifr5LQdDz7LH
 8p6s/bLNbuWF6OfrQN94BJO5ZQ0tdARa/YdqQ/XBdKuMAgHc3kyXQxfYk722/UIc7AUQ
 y+H79h5WDgOJM/u7Mdw49qsQuW0OrFqh2iFfUwxTTqVzkZp75AoppWCWW50vArc8uFqm
 uA0GvBg72RIZl8EJORApNoZC4L1owT0BeynWn3GDTFnKxudGJD4zcV/zD6cx/+uCG9/w
 p39Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEzp240fD7MgIk0VaW5N89tVPsipuvpY8nGFmZ7bsFVVZU5sNuXFgTQEiQnd/jGX6CvYEWhyiyGz4twhnsi@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/CAFLEd7OW4Kc/ZXNRDRPWBaqdINOMte6f0WvvcfvnOiVnTo6D
 kPrOhSohoxQPRMufpM5wHLuUL5U1NcqHKkFmLa9RvPpp6zC1IGFjEDpyUWldOH1IpfEGUG4uV+G
 8b0Hd3qeABW9LrSB5Q9jPEcGNabbeY1HnJFSlC66fQ6P8uJl17gC47U2RczYocKgDqRr4
X-Gm-Gg: AZFdTZcMz2tst3oPk4uOWBm4fZHRWJqyKcSbVyvAoaILPWpQS6dO3g7MV0bNHf3mBoU
 LPnZyoCHbxoSCS3cfH2VPLuGu9ZUmXbk33uWmVvXrPLXe+pLVclGdb5ayu0b6X17pEGfex24i2w
 1xpJjBLLnp0ARnqPeSE5AIsiXqQuRdq3kIbFA3IsD3rNjB25J9Uy93M4NJucjhkm6kZY1EdowX3
 fh3+SdXNvE9ci5kXBRFMGAJ1LLgbFx8EeTJGpSZ9tzSK9gtQPPEFg/3Ljsfsv7huPTnTo3RJU7l
 Xh2B/KEIbi00edBTNNnsU7nij+B5GM9d9oMvGQPaQDeqag5b3dgSHKghSPTiaGIn//qPPX/uqOr
 YZB8OhWPHxtMKEkLFru9WQB64Lncw2l7UbPtogP83umcyh1owRUL4HJK2RGfhm+0v+zrxfwbqZt
 4HJYxG92RPKbZW5aN3UVKnkq5Ll9ZDIuuuA5wZ0tvIs0oLb5rXqngIQUC3lrVhKR08x9vAkvmUi
 4Mhz/Irlz9i3wylKKORGNxFdhRECrVT6FDLyVhTT34F/2eEvWYfTi6/FA3J1r8Q2eVUC16j5sc0
 V9igfI85QnmUiJe4BWCpwNRJyBzw6bwawsdgY/Rk/8ialiDBX6cW6w+kwAcAu7hcXH7WVF16zTK
 1l7IrfJReCcXfR29FOzzg+sN7p70CJyW5Wnj3CV5DRxPMdlGloZmHSTplquf+c7Y2TtbqmBlWXH
 VpLw+EPzf0NyLTV7k8eFWXFzt1LtD3MIUPeF7K
X-Received: by 2002:a05:600d:1c:b0:4a4:fc8c:cfd9 with SMTP id
 5b1f17b1804b1-4bb9de0d5ffmr64892015e9.25.1795522651698; 
 Tue, 24 Nov 2026 04:17:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a1e8bsm364211085e9.9.2026.11.24.04.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 04:17:31 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 12:17:30 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396
X-Gerrit-Change-Number: 2333
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2333?usp=email>
X-Gerrit-Commit: 20621756e209873f71742fd856fe0bb494a49ecd
X-Gerrit-Comment-Date: Tue, 24 Nov 2026 12:17:30 +0000
In-Reply-To: <gerrit.1795515857000.Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396@gerrit.openvpn.net>
References: <gerrit.1795515857000.Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE1ODU3MDAwLklmYTA1YjlmZDA2ZTVkNTI4MThjOTFjNWIxNjBiNmRkMDZlYzcxMzk2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <169458d6fd3f619f2cb96f7f7d5ed596930dc7bd-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVpSs-000000001b1-21Gj
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpn: make the
 context mode an enum
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
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1183839024341073078=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1183839024341073078==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="crzOJIvMkY4="; charset=UTF-8

--crzOJIvMkY4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Lev Stipakov has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2333?usp=3Demail )

Change=
 subject: openvpn: make the context mode an enum
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2333?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifa05b9fd06e5d52818c91c5b16=
0b6dd06ec71396
Gerrit-Change-Number: 2333
Gerrit-PatchSet: 2
Gerrit-Owner: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Atten=
tion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Tue, 2=
4 Nov 2026 12:17:30 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--crzOJIvMkY4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Lev Sti=
pakov has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 2:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2333?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2333?usp=
=3Demail">change 2333</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2333?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2333 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev Stipako=
v &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Tue, 24 Nov 2026 12:17:30 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--crzOJIvMkY4=--


--===============1183839024341073078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1183839024341073078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1183839024341073078==--

