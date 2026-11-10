Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F3606A321
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PzDMjF2Z;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DIy5SL5v;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FNGYT9Ba;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DEmK2AIH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=2eLYGEjbm6pGeCqXWNOOmlGqJj2kdR6krh7klzdeXcs=; b=PzDMjF2ZhSPIp5TXrt+ik2NPdg
	mNO/Uqrwi/oRb/YGVdaZbou8mNTV8QbKpA3CNG5P3fyBgBhDI+PqfKUHiH2nEjuGqV7ZDicthF9Gt
	F2//ro6h6qNKEvcm28rmaaGNgbAYR7P0q19tMIuUBYL37I9HopLccGfS+KKKE2yR0GFg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQhbb-000000003tq-0Cl3;
	Tue, 10 Nov 2026 08:53:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQhbK-000000003tU-2JZG
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 08:53:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ANPrh5hkrwB110SROfXPRqGtPvtPGbR2Gfy6kRkHKXA=; b=DIy5SL5vwL7y8wiJWcBtfhIBf7
 eMYl/FAu1EscJK5u3nRrcr93mCZe5dwcH9fId9CsL76NW24wxkSYGGX9mDFqS1d1Uir2l33IbwVmy
 hMtnwDymcl0VtMRNIA1nziJC6VUlCbwOnIUO0vikjlALLoVFSSdh5ZJ7yhqdEs6X4ozQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ANPrh5hkrwB110SROfXPRqGtPvtPGbR2Gfy6kRkHKXA=; b=FNGYT9Baxn1YUy/KwKKuTNfC0F
 mjM/qCL2nHHrey/DT4+7hslnoRE8SVkLMKkbRNa4sA4sawiTiSNGJ2djZdPTwnGxxdV2gAwHU1dmt
 pDT18L7zXCJTbyXV39Z43KrqpIH/y8ZquUUUvd7VKaZoS66l5rWrUB3d6MtSupJaMTDo=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQhbB-000000008Kr-29tD for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 08:53:02 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so995639f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 00:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794300775; x=1794905575; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ANPrh5hkrwB110SROfXPRqGtPvtPGbR2Gfy6kRkHKXA=;
 b=DEmK2AIHirWldJcTEKo5pqeP3Oti6k60UYi3RaWoDdBygU7IBCv1yvtpUAizwug1fd
 99WF1o6s0VWJahrJPQYcKeldWa/gQWYQsL1pItlGpGNM6vCZTYC93QI/O4P6HPtXhE35
 cukfLAFGJJHY2SX9KGB+n1aPHzDgr5aHm+CIMTPkEyuW9/On3+v7dphjWFmp4n6y/AJp
 6TQDi/VjaUYXM2pVjhNDS8NEdRilpKbLwK1ONC2NRgQ6+cgJCnhFEtGpbDbd+1SJkvNy
 LNN7B9ZVBGS2y0JbDLPtTYMWV2QJR1ayslOEwQMOGWVmU13woIOzPpgI1pWV4K9sg7By
 79Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794300775; x=1794905575;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ANPrh5hkrwB110SROfXPRqGtPvtPGbR2Gfy6kRkHKXA=;
 b=xhMXZez3s6ykgphuhQGlJrQ6DV1HsHnEBaaha1MQtbpWaIWqe7YuLcSCduv3gg38Ok
 vmpebLgtNrM0okbzJKXFvzUWG8obCJrFJ8spSc072S6RfobwtflWYhJHj8LpEA2fFoIK
 233ZZA/BIi6f5VNxHEgY+9sEjC81AZEqMgF7BPAJI0mZaLdvyZBQtkSnULKzfXragErr
 0xbf/AwKWqRMHIuN7B6e9JwH2r4eOV6CN3bum2WcnTJFZLEBHw/BdKa8PFCDKORsnafJ
 lHJMdBBx6yACXRjzr6sqwLNq6utBzdrrA6EHWoWxkBlK0ctWNHpfIh+uI/tTiq5CSU9L
 OKQw==
X-Gm-Message-State: APuU4Z9encLViaWb1xTTaBpVEOQ4cxk4RouuDqEcw1AQjq//8x6IEVbM
 iIszBV0HzoU+TYmB5TeXb5baKVaTC0Ght3bvPBDCCdk+X/RpvL8wJoK4aIlshoEt+qNp+vKT8E3
 xB/5wTdQQFxfL10LIv1nUh3zHttyOO6ZXlnJWDna1OQ6242K6BfOhQx30Edham+5EhCxXIlkTVE
 /nZLJhEg==
X-Gm-Gg: AYBFou26cyRoQI1wrg/44Gq/VjMwHkI4rVUWs8ME0uAmTvTnYXSBgkwADbnojN9IAVJ
 A6X71J0ltX2lawW/HTsQ3wGDeJotmMOHmsLr+j/yeqyyyub9UdiVl+1VykWLKrI63o6+EhoswAR
 EvW8riPWIdJ4UVmSlAC02GIWe57AdtoaV4QmJ2Qb3MHrGFSG0GAqwjtVH99Tx74tm6MNf9dNdpX
 7W65v7dzerwmb7TBTx3TqwblZPHwnk5MMKz5znX3dlZ6KiDCvwfl3rFQPLoU6JigiOrXEWEKvWK
 i/h+2/AxuQ7RddSt3qCO+badKZjr/s37jUhm8DlmKnL51UeGybFk4aAhAL1jpLpAWRtyZkpfnQE
 i2zP/uUS9sT7TGH4FCuguV0v40HdMu9DXXIZFbJJdtEJNqgnx5kvfPFuPd0yOOHnbKQD+MbkPgd
 E62YDJ12ZXdcG2E2aDC+49TV8XcMLoH00uVFwYKEKVqJSMhhIEgFdZXD1Y4iYz4z88/Y7aloDEc
 YarnZ9O+g/OychEbHKOxHM3tk0SB3K/6MJD3yC3WBtxIJ08vpb57+cr4UMtbDsvCWMBeyoo9pVu
 GyCyYQsJDDwi5rl8bG/fwiahnr6HYxViP6JTytPQ08Kcl3S3wPFZUIGOE7a+T9utA692VrWgcxu
 rTXwvqRrn5bLEOoMr3RPZMqt5gZEwBDwJT3/KEpwAZeSu5jGRHhL2ZXi7rP7PcKsYv5ZFlElEk2
 JL/iYJOYuAsR5sSMeGBY0GWl+3wldUPPAbHjwV
X-Received: by 2002:a5d:588b:0:b0:48b:a21:87f7 with SMTP id
 ffacd0b85a97d-49831527212mr3562420f8f.44.1794300774818; 
 Tue, 10 Nov 2026 00:52:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498363df7a5sm3795926f8f.37.2026.11.10.00.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 00:52:54 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 08:52:54 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: 3ac6ba619e4e2bebdc5f54b0e80b79f0dcdf225a
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b25a4b66ba3eeeeec4fed60d212504cb82568d6e-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQhbB-000000008Kr-29tD
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: accept
 a lone config file that passes validation
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
Content-Type: multipart/mixed; boundary="===============7015337716064023242=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7015337716064023242==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VqezLBf/u0o="; charset=UTF-8

--VqezLBf/u0o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2159?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: accept a lone config file that passes valida=
tion
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpn=
serv: accept a lone config file that passes validation

When the only optio=
n is a config file, ValidateOptions() checked it
with CheckOption() but ret=
urned FALSE even when the check passed=2E The
service then fell back to IsA=
uthorizedUser(), so users outside the
admin group could not start a config =
from the global config directory,
and got an empty error message=2E

Broken=
 since f3c8a04d ("Restrict options/configs for startup through
interactive =
service")=2E

Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
Signed-o=
ff-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpnserv/intera=
ctive=2Ec
1 file changed, 2 insertions(+), 1 deletion(-)



  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/2159/1

diff --git a=
/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 81=
205d6=2E=2E28448c8 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/o=
penvpnserv/interactive=2Ec
@@ -403,7 +403,8 @@
     {
         WCHAR *argv_=
tmp[2] =3D { L"--config", argv[first] };
 
-        if (!CheckOption(workdi=
r, 2, argv_tmp, &settings))
+        ret =3D CheckOption(workdir, 2, argv_t=
mp, &settings);
+        if (!ret)
         {
             swprintf(errmsg,=
 capacity, msg1, argv[first], workdir, settings=2Eovpn_admin_group);
      =
   }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I57469ca50c5=
51ad475510690ecfa2d5e7cf9cfcf
Gerrit-Change-Number: 2159
Gerrit-PatchSet: 1=

Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>

--VqezLBf/u0o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">openvpnserv: accept a lone config file that passes vali=
dation<br><br>When the only option is a config file, ValidateOptions() chec=
ked it<br>with CheckOption() but returned FALSE even when the check passed=
=2E The<br>service then fell back to IsAuthorizedUser(), so users outside t=
he<br>admin group could not start a config from the global config directory=
,<br>and got an empty error message=2E<br><br>Broken since f3c8a04d (&quot;=
Restrict options/configs for startup through<br>interactive service&quot;)=
=2E<br><br>Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvp=
nserv/interactive=2Ec<br>1 file changed, 2 insertions(+), 1 deletion(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/59/2159/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive=2E=
c b/src/openvpnserv/interactive=2Ec</span><br><span>index 81205d6=2E=2E2844=
8c8 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span><br>=
<span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -403,7 +403,=
8 @@</span><br><span>     {</span><br><span>         WCHAR *argv_tmp[2] =3D=
 { L&quot;--config&quot;, argv[first] };</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (!CheckOption(workdir, 2, a=
rgv_tmp, &amp;settings))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        ret =3D CheckOption(workdir, 2, argv_tmp, &amp;settings);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ret)</span>=
<br><span>         {</span><br><span>             swprintf(errmsg, capacity=
, msg1, argv[first], workdir, settings=2Eovpn_admin_group);</span><br><span=
>         }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2159?usp=3Demail">change 2159</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I57469ca50c551ad4755=
10690ecfa2d5e7cf9cfcf </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2159 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne S=
chwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--VqezLBf/u0o=--


--===============7015337716064023242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7015337716064023242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7015337716064023242==--

