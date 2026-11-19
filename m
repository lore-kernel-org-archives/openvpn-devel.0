Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46856606A320
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=F+rHOVMf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DHqND4PA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Cs298LjA;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bS4/dyCb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=p5HXdWnOU3jyO/kde6R9+yiRNnolgu4YEW+bfwNJtlU=; b=F+rHOVMfUGM91zFwwj1Ytm7zFu
	AALzOHP4cTkF7tofUbo+wC3B7oGqekslK7ovaYuwvabtqXHWhLfecyb1G5PqCSO0MyAYAc0M+7H5R
	HnnGrHj/sHsn6CWZQOZiWpnKgZrYO8HcorB8mNjp150BiaYDR1sSyFVKI7gU+lhwMrjo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTxAT-000000000lC-1Uo5;
	Thu, 19 Nov 2026 08:06:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTxAS-000000000kz-1AKP
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 08:06:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qY1CAWJQ31Dfk2Zk5UMMKbmvKNjAe2ISsh23u7wTv34=; b=DHqND4PAelT3n7va8LmIDKNUfS
 NrkZzmgQt/UANgNkFoXBBWHS1FBaZ9z3DT36W9MJ557V0QYSQttL9KTtlBZM0Cx6xH2LePUtMDWT8
 cDaH0feefjskpEeP0j2opwduf/fsADnhyCi+RzsTZesiEp0oRTB2K6qgczqgkODvyruU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qY1CAWJQ31Dfk2Zk5UMMKbmvKNjAe2ISsh23u7wTv34=; b=Cs298LjAvvUZhQ/VX+G59pXS3O
 /eR6Uz05zH7JCl6rnSyUomh34Gu8JXeJ+SJjUKrYb8f4laUEILg+d5fZyEU9X6Z1iHcKzzKXZyuWv
 lRpStc4wwIkupNnTF68ir76z767tbYHSzH9gXYJhjR3tJdKyurEl0R2s5WtX3Lk2TNgM=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTxAQ-000000006BQ-2AgM for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 08:06:52 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-491846221ffso1527937f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 00:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795075604; x=1795680404; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qY1CAWJQ31Dfk2Zk5UMMKbmvKNjAe2ISsh23u7wTv34=;
 b=bS4/dyCbfj6+SQnt5pNYDWEoXIUDEHMrCHH3NRKbMPGcVdhN+4WZ4Go9hYE/xrEGuA
 0MkPGcFYWJ12B+y1Pk6N5eyLqXj4yCwSeLviXXSVZljOhdB4TWUJrQT2X33mAi5drdFb
 4MSpYaLNgGZbUKgsC98XolVBnV+/EzXp+8AJXfTSaQpmCIHjKWxy2iPRz6Ra3qSFUnPC
 lEosvcMfoYztP98tziZy8OIjFVi5mnd1ZV/3Smdin7DBCpnr2gPtcIzCZxok3VSvrubY
 YusNGoN+UT3czOSog1swdqPFneaS2HDJnK4BWaO4URC0aBBaEWY6VDqyZK+CtWeJAXn1
 ar4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795075604; x=1795680404;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qY1CAWJQ31Dfk2Zk5UMMKbmvKNjAe2ISsh23u7wTv34=;
 b=kOjKSv/RlVKxKuV5s/UKXvSQyjRiJZofKZVkFaioe6IHt6seMka3cK3dp8/L1tBXbd
 2u1FF7nLIzLIwq+QjGxiHwfcwzYPTo0kFImHjUwKHTMgnmFongkUYi7Y/BfuiboRtqff
 TbNx8rF8USXY0tuMXdeBKWgw4BspuMZoeSvAuWIp8a2lnk1ZYy1FOjZHIkDZJOH6kEc1
 Wn6fK1MEbOqKvToTgGYVbTDJCToXuEVZDXUPjfg5Tr+tobFwWf2TaDTgLe4cOvQIgVda
 U9zwb+OE0g8Hlbw48UH0RWbEMfArrf/F8LkIOJHD4zFwVvQIUplv2k8ozWuNJz6oPKdy
 gklw==
X-Gm-Message-State: APuU4Z/mirTMACXWsnyeHsFuloAYLWWwbYZIUOh2Nlazxsi52nAfNw0s
 7Lw6vByuTVC3dD35Pw6QS8aZ5ByCET+YT+ivk0ctNOWur/O6ivhWCVnhGl3Pu/386yu778eF5So
 YcVkk0yumWt5vRL6d/F9RzBlV0dM+mS4RpV9w8K+aGAQZRDeCW6QgKtkoGWLoxY0a/vKQR5iHdK
 wOL6Bz4Q==
X-Gm-Gg: AYBFou2hI1TKn0IIVd/eGn5QHPRZ3iztyR5FfTfzbto/v7oFQcBsR815dRAS7KtjOfu
 MUspmdixZjlmi7kuVKxt0PzrKBEJSBwFG3DKKq4s04witiX/B/PT7YARxJXSGsqfknfQ7VqTMHE
 FaMs4TVXLwnrq3nPZWtIfbZYhXmaxQunT1rZZKeMM60mCw6/8NHyVb/Q/k/1Xo0941E48QWCIG9
 5SzDR/DITpZO30DfaQ66UYDYWuq9rerCQZ/3Xfb4LoQrB3KdTjh82qVRXJlhlUdryBx9Qb1iDWK
 cMFfAQHDb/8wtNyihLhtSoesiQWUKAEYGoXe9o2EcCkKeNqFEi8O6UIZzNJTTPO/6wuqwNF2Wwg
 GcswPzkWSRl0ezCbH7cVMYr+lBAmgdR1537CR+ZIruXHcVgJ16WErrSjyr3bSKW+frHQqP9N/JK
 AliKXnM2H30Po4mtiF8mhGXb6KM6+J6rGVsdUywHgFuXqvE5SNvNor84RVrdVdJTk0T0i1CwHrj
 I+fSOjKlOcIS5JffSLReLmoD7KYqFoMHx3A5LsWzM7PHWPRQfCzAV2NdbaOuqcGIVC5dmvuGHog
 buQeOKpiPcROkIPr4hyGP7dVRIknDcbvAQsKM/0NX9fegoo0O8sMYMETlbNMpkz0PV3BTOrRl5L
 3PHxuNYx7H6uOrVGjGmwbQ7EHIpDQ1m2jDzaVXLeOwsb6qOyxY1iGokmtM1Kgv0eytlu9ahNDsv
 BDKjnm0cXgaJZq7V4=
X-Received: by 2002:a05:600c:45d4:b0:4bb:5f45:c97f with SMTP id
 5b1f17b1804b1-4bb7da29ad4mr92930395e9.27.1795075603613; 
 Thu, 19 Nov 2026 00:06:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9846sm21482245e9.11.2026.11.19.00.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:06:43 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 08:06:42 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba
X-Gerrit-Change-Number: 2223
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2223?usp=email>
X-Gerrit-Commit: 689abfb238b7b44de2431d3303448dd93d61c1ef
References: <gerrit.1795075601000.I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDc1NjAxMDAwLkkzZDVjYWFiMzIxMGI2NTU1MWUyZjJmZjhmNmUyZWRiNTAwMjJlNGJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f9a2a2ede66056c97f602edf99aa35b28fb6dd62-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTxAQ-000000006BQ-2AgM
Subject: [Openvpn-devel] [S] Change in openvpn[master]: sample-plugins: drop
 broken defer and log winbuild scripts
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1570196578607861130=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1570196578607861130==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mOjqWxNMDFI="; charset=UTF-8

--mOjqWxNMDFI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2223?usp=3Demail

to review the following change=2E
=


Change subject: sample-plugins: drop broken defer and log winbuild script=
s
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

sample-plu=
gins: drop broken defer and log winbuild scripts

Both need a $1=2Edef that=
 doesn't exist in their directory=2E

defer/simple=2Ec and its =2Edef were =
removed in d816207b ("plugins:
Remove defer/simple=2Ec sample plugin"); the=
 remaining multi-auth=2Ec
uses fork() and doesn't build on Windows=2E log/w=
inbuild came from
the examples/ -> log/ rename and never had a =2Edef there=
=2E

log=2Ec builds on Windows with a plain "gcc -shared", since
OPENVPN_EX=
PORT already marks the entry points __declspec(dllexport)=2E

Change-Id: I3=
d5caab3210b65551e2f2ff8f6e2edb50022e4ba
Signed-off-by: Razvan Cojocaru <raz=
vanc@mailbox=2Eorg>
---
D sample/sample-plugins/defer/winbuild
D sample/sam=
ple-plugins/log/winbuild
2 files changed, 0 insertions(+), 36 deletions(-)
=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/23/22=
23/1

diff --git a/sample/sample-plugins/defer/winbuild b/sample/sample-plu=
gins/defer/winbuild
deleted file mode 100755
index 82927d9=2E=2E0000000
---=
 a/sample/sample-plugins/defer/winbuild
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-=
# Build an OpenVPN plugin module on Windows/MinGW=2E
-# The argument should=
 be the base name of the C source file
-# (without the =2Ec)=2E
-#
-
-# Thi=
s directory is where we will look for openvpn-plugin=2Eh
-INCLUDE=3D"-I=2E=
=2E/=2E=2E/=2E=2E/build"
-
-CC_FLAGS=3D"-O2 -Wall"
-
-gcc -DBUILD_DLL $CC_F=
LAGS $INCLUDE -c $1=2Ec
-gcc --disable-stdcall-fixup -mdll -DBUILD_DLL -o j=
unk=2Etmp -Wl,--base-file,base=2Etmp $1=2Eo
-rm junk=2Etmp
-dlltool --dllna=
me $1=2Edll --base-file base=2Etmp --output-exp temp=2Eexp --input-def $1=
=2Edef
-rm base=2Etmp
-gcc --enable-stdcall-fixup -mdll -DBUILD_DLL -o $1=
=2Edll $1=2Eo -Wl,temp=2Eexp
-rm temp=2Eexp
diff --git a/sample/sample-plug=
ins/log/winbuild b/sample/sample-plugins/log/winbuild
deleted file mode 100=
755
index decf05f=2E=2E0000000
--- a/sample/sample-plugins/log/winbuild
+++=
 /dev/null
@@ -1,18 +0,0 @@
-#
-# Build an OpenVPN plugin module on Windows=
/MinGW=2E
-# The argument should be the base name of the C source file
-# (=
without the =2Ec)=2E
-#
-
-# This directory is where we will look for openv=
pn-plugin=2Eh
-INCLUDE=3D"-I=2E=2E/=2E=2E/=2E=2E/include"
-
-CC_FLAGS=3D"-O=
2 -Wall"
-
-gcc -DBUILD_DLL $CC_FLAGS $INCLUDE -c $1=2Ec
-gcc --disable-std=
call-fixup -mdll -DBUILD_DLL -o junk=2Etmp -Wl,--base-file,base=2Etmp $1=2E=
o
-rm junk=2Etmp
-dlltool --dllname $1=2Edll --base-file base=2Etmp --outpu=
t-exp temp=2Eexp --input-def $1=2Edef
-rm base=2Etmp
-gcc --enable-stdcall-=
fixup -mdll -DBUILD_DLL -o $1=2Edll $1=2Eo -Wl,temp=2Eexp
-rm temp=2Eexp

-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2223?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3d5caab3210b6555=
1e2f2ff8f6e2edb50022e4ba
Gerrit-Change-Number: 2223
Gerrit-PatchSet: 1
Gerr=
it-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>

--mOjqWxNMDFI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2223?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">sample-plugins: drop broken defer and log winbuild scri=
pts<br><br>Both need a $1=2Edef that doesn&#39;t exist in their directory=
=2E<br><br>defer/simple=2Ec and its =2Edef were removed in d816207b (&quot;=
plugins:<br>Remove defer/simple=2Ec sample plugin&quot;); the remaining mul=
ti-auth=2Ec<br>uses fork() and doesn&#39;t build on Windows=2E log/winbuild=
 came from<br>the examples/ -&gt; log/ rename and never had a =2Edef there=
=2E<br><br>log=2Ec builds on Windows with a plain &quot;gcc -shared&quot;, =
since<br>OPENVPN_EXPORT already marks the entry points __declspec(dllexport=
)=2E<br><br>Change-Id: I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba<br>Signed-=
off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>D sample/sa=
mple-plugins/defer/winbuild<br>D sample/sample-plugins/log/winbuild<br>2 fi=
les changed, 0 insertions(+), 36 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/23/2223/1</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/sample/sample-plugins/defer/winbuild b/sample/sample-plu=
gins/defer/winbuild</span><br><span>deleted file mode 100755</span><br><spa=
n>index 82927d9=2E=2E0000000</span><br><span>--- a/sample/sample-plugins/de=
fer/winbuild</span><br><span>+++ /dev/null</span><br><span>@@ -1,18 +0,0 @@=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-# Build an OpenVPN plugin module on Windo=
ws/MinGW=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# The argu=
ment should be the base name of the C source file</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-# (without the =2Ec)=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# This di=
rectory is where we will look for openvpn-plugin=2Eh</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-INCLUDE=3D&quot;-I=2E=2E/=2E=2E/=2E=2E/buil=
d&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-CC_FLAGS=3D&quot;-O2 -Wall&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-gcc -DBUILD_DLL $CC_FLAGS $INCLUDE -c $1=2E=
c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-gcc --disable-stdcal=
l-fixup -mdll -DBUILD_DLL -o junk=2Etmp -Wl,--base-file,base=2Etmp $1=2Eo</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-rm junk=2Etmp</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-dlltool --dllname $1=2Edll --ba=
se-file base=2Etmp --output-exp temp=2Eexp --input-def $1=2Edef</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-rm base=2Etmp</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-gcc --enable-stdcall-fixup -mdll -DBUILD_=
DLL -o $1=2Edll $1=2Eo -Wl,temp=2Eexp</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-rm temp=2Eexp</span><br><span>diff --git a/sample/sample-pl=
ugins/log/winbuild b/sample/sample-plugins/log/winbuild</span><br><span>del=
eted file mode 100755</span><br><span>index decf05f=2E=2E0000000</span><br>=
<span>--- a/sample/sample-plugins/log/winbuild</span><br><span>+++ /dev/nul=
l</span><br><span>@@ -1,18 +0,0 @@</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Build=
 an OpenVPN plugin module on Windows/MinGW=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-# The argument should be the base name of the C sou=
rce file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# (without th=
e =2Ec)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-# This directory is where we will look for openvpn-p=
lugin=2Eh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-INCLUDE=3D&q=
uot;-I=2E=2E/=2E=2E/=2E=2E/include&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-CC=
_FLAGS=3D&quot;-O2 -Wall&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-gcc -DBUILD_=
DLL $CC_FLAGS $INCLUDE -c $1=2Ec</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-gcc --disable-stdcall-fixup -mdll -DBUILD_DLL -o junk=2Etmp -Wl,=
--base-file,base=2Etmp $1=2Eo</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-rm junk=2Etmp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
dlltool --dllname $1=2Edll --base-file base=2Etmp --output-exp temp=2Eexp -=
-input-def $1=2Edef</span><br><span style=3D"color: hsl(0, 100%, 40%);">-rm=
 base=2Etmp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-gcc --enab=
le-stdcall-fixup -mdll -DBUILD_DLL -o $1=2Edll $1=2Eo -Wl,temp=2Eexp</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-rm temp=2Eexp</span><br></pr=
e><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
223?usp=3Demail">change 2223</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2223?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newch=
ange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 2223 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>

</body></html>
--mOjqWxNMDFI=--


--===============1570196578607861130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1570196578607861130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1570196578607861130==--

