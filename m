Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA09606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OChL5lIj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bxLKxoB8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LQiPUmJ5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hI29ZkIM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xs//rVpNfrBncc/9J7vFHE254unwI6Ddvn1NLVJNR5k=; b=OChL5lIjX51MGmAYKjINhH4Ohy
	SkUjFcHS4e9/MKwALYxMabpfxyemtZGA6dllcSLerfWakBo+MzHcSBLA+WqAoJq7NpVnt2ktlZUjE
	gdo0gv8XvQgiXxwoSZNVi7iIVbNKVwp/9cFtJIIwSDRIDy5a47HPlLT5WbC9eiQNBuKM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWeJq-000000007tS-2Inz;
	Thu, 26 Nov 2026 18:35:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWeJp-000000007tL-0ZUl
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 18:35:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dve3yohPAIP0hk2b0l4DrhesnrqS2IOUDKI8I/4IAuo=; b=bxLKxoB8thk8AnZ8bhuCFTJKu7
 6zLXoF6BIrKUM3KSolWC+qD/j9uRM2217NMeO3bOKvZrkC6ZTa6Q7ezMfElGTpS5hfjkOLmIFhlJX
 MAoJW1Mo1tznLmBcYxs9z7zb7oLgcPTpW0/FH3Gt7O8yOCZJG3wuPrHtnGgPMEhHpELw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dve3yohPAIP0hk2b0l4DrhesnrqS2IOUDKI8I/4IAuo=; b=LQiPUmJ59EVHHVxAQqoRb6A8Ud
 mC4qRE7UcvtacWcs+0OWp9PxAn4hbL129Yj0WlHILaI5p9zM1qemlRnrX46pF+Db6h0y0MBrqpbDg
 MwB6YuSqcM6TYn4rBjv1Hj6m6HN5RmWHBZDlYGLcguoRgjHC8XwKaLZzY6oVCoRnShnc=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWeJn-0000000034H-06WX for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 18:35:41 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so63972635e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 10:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795718132; x=1796322932; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dve3yohPAIP0hk2b0l4DrhesnrqS2IOUDKI8I/4IAuo=;
 b=hI29ZkIMfWGLcRODzbwMoigH3vneXu18irH0erFPC5wQm5CAyITbeQFMG8noieVOhz
 U46LIBWrIR8P5qTk7Ek/5fDPmOATyV5H3T1auxag2QDC23FjTS4fUYQUla6P7XECXftW
 OsYtfjaxNrHIVm0CRF4gvQCjQZTKFHYCHxxhZXfvo2k//id/9+9/m0ha3vVmfs0gZNn8
 0A/20GCxoMk2Tnk4WqajkdqJhE47JY9tFsBOQOMJzjE/0wvkmze7BpPCHMWt8jIt/AAh
 rtqG05pWknZgy3YlA+pBQS7zA1SNjj/ZUTYSc+/9QI7wULXb43TxU7QtgM59teXtTEQ0
 GWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795718132; x=1796322932;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Dve3yohPAIP0hk2b0l4DrhesnrqS2IOUDKI8I/4IAuo=;
 b=Y+e13qsjk0GuaBHu3jl4YD/Gr3JpLJq/kRMJ5AdnKsu3Cg04dk+hSmr2UILnRNGR2Y
 /UyNBTxvCGgUVtiJV5Awol6pPuxi95yLl58ZJlwcFH6WrEh0VsdpzbexwGqdzpSSRG0r
 H1mOecTg2Xrxdd0rOdMEMxbozYukMDTXjGPlIlo8mbbTisdDcG9g9DdtsLBxGjRwHjG6
 VNfjJz1aXZqOjybVWE+/bluyFkHqWaQIoXpChX5hNoZFIaZbTfCiMIyhLVoIT2Jjk/U3
 DOCHwkEFY3PETPsHO6F0BI1hl8NhHGDBPZK1xbeMfvvWN4jgTSRhdsI/sLqLj8atLnIR
 rw/w==
X-Forwarded-Encrypted: i=1;
 AL+hErHOi4W74Q2ucQOAZKCA9CoyIbvqSo3QTldci7H2snILWVa1lQzFVHsTIIjyLvll8jzwOveA4F6B0En2JBCQ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+HbIAyFp0h9FRw9DzdJ1oiR463NC5PhtMEnRNkQSjIyZb0KGps
 9NVTidKcZE9U+YJSLfUUHU9klx4fAxhIn1B+rcofVlh86VRsWJB0A+zKiiuAiFZKvOSUDhWYn5v
 loHO0Enu2vj9/GbydM/0kF7y4UC2Yb4ggH15HvUp5d+zS76O6aKh4fC0z7XSmLwgQoy2OFr/lE9
 BmPLVGMQ==
X-Gm-Gg: AZFdTZfQwjV7r7VjuXS3dd9wwQzmciQ4t0YUEZTuy1MI7OhlPWDu4DxByhjNpAszqOU
 i8DOgHwgEw2SNInXO+njxa+F25YUGBuM+te4MSWoD7MjkPTBmkkDB7Dzx+hpz4YJnsR15PjGcJr
 kLKBrBWrOJQpcr5tR5jrl1RB+TP/1zA15N7/nlyVW0EsYvml0w32c1NoPkyUolWnF6o3A9/mKH1
 U5EWhJSHuKbzxXvqZc3W5n+LojJ0cnibYS+cbuhxIhqxSmRIgCReSKd+1bQNOac/jhBYlu1o5de
 0DKjKkMSgPJUNKELee8OgVay09vO9rYKz8n7nG7Uidry7ix80lc9NUYoZ4Kqd7r4ZX02WKRq6YP
 9DIxfYevtW2HCUCP+SLwfnSuDIgojL+6aBcXybf6KAUoirc10Zs8WF286DG6ay6k8ryDHrcKRFe
 mi1AFP+Su7LBLcw046Xuae7LAdAByU6ISGcwPkO4taP+cwhWAYNem0GyXkk7/6mM6XCvLGor6Es
 XgWehD1Im4gnZi/1ytpN4yOrduIK08fEl8sLOKIMHYIhmxBtOGw4rlVBn8EwqOO8oLANtiF7o82
 rjGyzJJZSItGKaMgkZiptwq5COjRhJBRwZTlf4ELx4pG3rmgzyJF1jQ8ChgH/ViOMAruMZMkzAZ
 iciGG6bE7aEVelPHcQaMqc0SjxjrbVSObKpPYbsbOHQuTozrRkQqeQ0ypgA3V6gR7Fb65yLJo47
 GHMj/twifdg1/0sQU=
X-Received: by 2002:a05:600c:1d8c:b0:4bb:5345:606b with SMTP id
 5b1f17b1804b1-4bb8882358dmr438626985e9.31.1795718132347; 
 Thu, 26 Nov 2026 10:35:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9067a0e6sm303037855e9.4.2026.11.26.10.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 10:35:32 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 18:35:30 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7
X-Gerrit-Change-Number: 2358
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2358?usp=email>
X-Gerrit-Commit: ab5643eb461c214fd3e46dea5210b383809159b7
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 18:35:30 +0000
In-Reply-To: <gerrit.1795714582000.Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7@gerrit.openvpn.net>
References: <gerrit.1795714582000.Ia5c265bd1f2723be93fb8fbb73e73a4e86d1cac7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzE0NTgyMDAwLklhNWMyNjViZDFmMjcyM2JlOTNmYjhmYmI3M2U3M2E0ZTg2ZDFjYWM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5fb18f4881749890d358a2887800f145e37a9d06-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWeJn-0000000034H-06WX
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnmsica: Clean
 up sign conversion warnings
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6649943441951709349=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6649943441951709349==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Zlsx/xm4C4k="; charset=UTF-8

--Zlsx/xm4C4k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2358?usp=3Demail )

Change=
 subject: openvpnmsica: Clean up sign conversion warnings
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2
=

(1 comment)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
358/comment/0496790c_839eb9ca?usp=3Demail :
PS1, Line 11: Removes explict n=
ull termination that is not required
Typo: "explicit"=2E



-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2358?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: Ia5c265bd1f2723be93fb8fbb73e73a4e86=
d1cac7
Gerrit-Change-Number: 2358
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attentio=
n: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 26=
 Nov 2026 18:35:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--Zlsx/xm4C4k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2358?usp=3Demail=
">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2358/comment/0496790c_839eb9ca?usp=3Demail">Patch Set #1=
, Line 11:</a> <code style=3D"font-family:monospace,monospace">Removes expl=
ict null termination that is not required</code></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Typo: &quot;explicit&q=
uot;=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2358?usp=3Demail">change 2358</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2358?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia5c265bd1f2723be93f=
b8fbb73e73a4e86d1cac7 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2358 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 2=
6 Nov 2026 18:35:30 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div=
>

</body></html>
--Zlsx/xm4C4k=--


--===============6649943441951709349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6649943441951709349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6649943441951709349==--

