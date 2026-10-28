Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CEB606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=c+5QG7hQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XH2mgJ6K;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Tdmv2Aev;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PkXwZ4Vy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=vy5IX1kIFpCmTuPO11UjQCb4bGkTnFSDvQK4EMq0r/E=; b=c+5QG7hQUuYrogbVWqBkvb5WRe
	DuCaC06WvPsv4rzuxuQTppXcBD6ecvazrmCGaRAigObVNmiSECm/IXxpWEjvwdJPvaX8pTdCxhBrx
	fzNJI1CknosIR/uSIvPK5kmcg3gu3pk+0pL2lNpThkH12MA/o6a4F/uqFMtJiEcU+kAE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM1vP-0000000018b-01I9;
	Wed, 28 Oct 2026 11:34:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM1vC-00000000159-40Cu
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 11:34:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C8rs7RE25hA7korjhxE5AF7YoD3/0eiLCmRYoT2RrQQ=; b=XH2mgJ6Ktd8tNzue8YOaXJFTwh
 nV0Ljorz9zBfkvzsC4z53Q04T8SyH8A+V5Pc7FIawiqd4W0dPe8f3zsssWgw2GBzjxIzw91VX/hKU
 yzJqujgyfxQKKOMCG38/ayOokxh7DBzOhYQ7jFmvq46OMiY6nu/8ZDrzdQ8HgQbmJBh4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C8rs7RE25hA7korjhxE5AF7YoD3/0eiLCmRYoT2RrQQ=; b=Tdmv2AevKVJeunE43JEcOEIU2Z
 9yVlhc8SDAAmtI9CxeqGmbLmqyu+gzfXd0MFGGfuesMUAXe3FfJmWPU/9hlWVvjb5EaZ5cdGmh5ng
 QrRLZFOzdJc7Y3XF70ZSZZ+L8ObJe7yWsalZVlbjiGre3An93nISUNb8tE0ZMzwCPimI=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM1vB-000000004J9-0pAc for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 11:34:22 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so6295575e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 04:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793187255; x=1793792055; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=C8rs7RE25hA7korjhxE5AF7YoD3/0eiLCmRYoT2RrQQ=;
 b=PkXwZ4Vyk5KDMl0ool3tvktvJcwCHn/uy/cRPtVINKYsg4vQ0u4qYWVuxScwOo37+l
 CSfw0QqbJQa6xiMDBpse6w3B1Y3/8SsGmThJIf3ZnNYxAbeMJEmzo/dslcVY9SEjlefv
 8HsscG4D5my/GpC6OgWQJletSFVAwxL8Muw2zyILI69UsVjQNUkawfHLzWAGdNWr39w0
 Af+prm3qBDiAZgY0XuOjx2WBn4nv4RbBDVB51NmiEYHy78bIjOZedHhrXJtandvjG24S
 c81N+EGxOX+UcannwtlqP6ETwyw+xnjaYNTR2kxF33Q4syJZZQhSGlwweu12QeN7923P
 aEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793187255; x=1793792055;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C8rs7RE25hA7korjhxE5AF7YoD3/0eiLCmRYoT2RrQQ=;
 b=MEyCs+Nv/JLpNGz351VVZg3EcBkc/Db3aZIkoV5Y/TP+iMaBWpW4Zy33gHMvxvo9Mh
 C8ZtW0s3H4dFhUAaQwEzwKAevPln++aPW8G0JFXETruSh3ippTKURoo6urL5bwkzx1Cy
 R/pT1A79f1lheVQbeeEgvmblIqXAfPbA32ZX9QlMlnOhPm2qWRE7cP3VW8CNbeP+Ru7S
 23bGAFhUNunpj0s9UqRhEJzWjix/O5y4hvCObMk8LYCCWMStlFEJGkMkrtCzNbR8WMB7
 2frIR56I2UzloBQ9hnEEjuvQzErTNESC/578ZzR59ykMvQ04u+++vFAGSU+Pr/ugaYBt
 ndRA==
X-Gm-Message-State: AFq9FYIBuzkqorA9+iubmnQZyGOaRIJLraHfFqzot5yUOR7/JYx+LNte
 YCOGvbmHi8P/RFLHNrJOy2UFOGNKrNgFWGIpyfCDwwwEYj3jlAPTQdp/6JS/etmYNmtjCjmKC66
 5sPlMXAcQBz4spvlsGYL13seZdzGk99ZMSM/2ughrqLkIC1uQu4emozY3qpMGdDpsO35iXXP0+9
 e71VQiOA==
X-Gm-Gg: AYBFou3EQ7uMjMkcvmOvh5XbeQw8QSMYyOqYdnU6wKxrWU9MBTWcXYn72fbJvxjxXcg
 n2ghgruruo7U646B92WPFVC4xIwerfTkrxI3YjX/7mHgG67jVVSq79Ls0shksxLsE+7orfVLBLj
 2lprntqZDnuRAjQsS97U/y5nJ8r8/PNjJSwNRAckK9diKtrFTd+n31gwB/v9mLD6TlwbC2JHVLj
 YyxxLSLLrgW0Tr7beGZXHcTofe1ff4lSzSTdPsmnsA0zcsmh/pytFAbw5QuFQ8DuKfHlI3PJdI/
 by7MIGX1IUNMoJR3qZSPfYB0EQwUWa6a6EwbebcVRnUkhj9qljvyFMt4ilwvdAJfZlF6l/1I0UX
 SwbQAVyD4x7814vxKh35sgCF1KQAqFFlH9m0ufBkV2KNXTXdvopA+CTdI9cD/84axdPS4grH+af
 K4snKgO6bLdIjoz6GrgFRSBrMXDD0XO9hFz2R/kxfbQXgx0RB60f5cprqyC4z3WkAL9dZVa/qJa
 uLkEZQ6cNUSRZn/nFK9gNol7rwH5YALrtUa/cJ73pP2iuvY6emBajnIe8IFI7NUK7Q/9DtV97hW
 1i2gQxeDW6/pSU0Q1HVP+XlHwHzeModyWNQWQ3cRde+TE3CwUGmWLMnCtqdZGI8laMuVt7G8pk/
 B24+KiYy9r7TIknL5ZUDtxr3sDuh3Mj4M/7Y6rWQtawcQFk/eDFYaK8WSxlTLQmpNqdzDnPLjzH
 MZZ8gqsoY2UFkW59BwC1fciDXbtarGYwpPoxIv
X-Received: by 2002:a05:600c:8b78:b0:49f:fd2d:23c7 with SMTP id
 5b1f17b1804b1-4a9672fa52cmr42183985e9.27.1793187254336; 
 Wed, 28 Oct 2026 04:34:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a97c42b3c1sm42868905e9.6.2026.10.28.04.34.13
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 04:34:13 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 11:34:13 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4
X-Gerrit-Change-Number: 2058
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2058?usp=email>
X-Gerrit-Commit: cadb8ca8c1ff8c268285fc89bb059e4623e2e0ff
References: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTg3MjQ5MDAwLklkZTVhMzA2NGU1MWQ0YTIyZjkxNGU3NmMxZDgxNjVmZGQ0ZDAwNWY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <75456acb04a7805727f11bbeee8634ba35029969-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xM1vB-000000004J9-0pAc
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Mark buffer invalid
 with username mismatch in server side float
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0485814279988349589=="
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0485814279988349589==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iUjZeeKvVhE="; charset=UTF-8

--iUjZeeKvVhE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2058?usp=3Demail )


Change subject: Mark buffer inva=
lid with username mismatch in server side float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Mark buffer invalid with username mismat=
ch in server side float

Commit d42a9912c1 introduced a check to ensure tha=
t also the username
is identical for floats and not only the certificate=2E=
 This check did
not mark the buffer as invalid in those case kike the certi=
ficate
check=2E

Reported-By: QiuYiati on https://github=2Ecom/OpenVPN/open=
vpn/issues/1137

GitHub: closes OpenVPN/openvpn#1137
Change-Id: Ide5a3064e5=
1d4a22f914e76c1d8165fdd4d005f4
Signed-off-by: Arne Schwabe <arne@rfc2549=2E=
org>
---
M src/openvpn/multi=2Ec
1 file changed, 1 insertion(+), 0 deletion=
s(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
58/2058/1

diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index=
 e302a81=2E=2Ecaee3ff 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/=
multi=2Ec
@@ -3172,6 +3172,7 @@
         {
             msg(D_MULTI_LOW, "D=
isallow float/connect to an address taken by another client %s",
          =
       multi_instance_string(ex_mi, false, &gc));
+            mi->context=
=2Ec2=2Ebuf=2Elen =3D 0;
             goto done;
         }
     }

-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ide5a3064e51d4a22f914e76c=
1d8165fdd4d005f4
Gerrit-Change-Number: 2058
Gerrit-PatchSet: 1
Gerrit-Owner=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>

--iUjZeeKvVhE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Mark buffer invalid with username mismatch in server side floa=
t<br><br>Commit d42a9912c1 introduced a check to ensure that also the usern=
ame<br>is identical for floats and not only the certificate=2E This check d=
id<br>not mark the buffer as invalid in those case kike the certificate<br>=
check=2E<br><br>Reported-By: QiuYiati on https://github=2Ecom/OpenVPN/openv=
pn/issues/1137<br><br>GitHub: closes OpenVPN/openvpn#1137<br>Change-Id: Ide=
5a3064e51d4a22f914e76c1d8165fdd4d005f4<br>Signed-off-by: Arne Schwabe &lt;a=
rne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 file changed, =
1 insertion(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/2058/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index e=
302a81=2E=2Ecaee3ff 100644</span><br><span>--- a/src/openvpn/multi=2Ec</spa=
n><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -3172,6 +3172,7 =
@@</span><br><span>         {</span><br><span>             msg(D_MULTI_LOW,=
 &quot;Disallow float/connect to an address taken by another client %s&quot=
;,</span><br><span>                 multi_instance_string(ex_mi, false, &am=
p;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</span><br><span>             goto do=
ne;</span><br><span>         }</span><br><span>     }</span><br></pre><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=
=3Demail">change 2058</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2058?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2058 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>

</body></html>
--iUjZeeKvVhE=--


--===============0485814279988349589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0485814279988349589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0485814279988349589==--

