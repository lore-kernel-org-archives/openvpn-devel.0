Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C998C54F51
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rpyTiR9C/r74y9WhgJH64C5CSzsp/EJ8gmGjM61BcMc=; b=OlJ69zKpH4CqbBvlRP/+qqTU/R
	1dF8JB6lN97BncfJPSyl/IeOVVxx7FFeB0E1ZLf4biGNTza2LxjVntIkeBV9V07j9+sjK8k3MswuH
	0WbeuBa6F60LXOfU2bu1ABTzuq00J77B714XnUYJBcUz0STjSBFTQHNrCtsDw4X0iALI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp36o-0003Dm-Bz;
	Wed, 29 Jul 2026 12:09:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp36n-0003Dg-1Y
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:09:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2LVPIld2ztv8g4OHarVULHrbsMMe8EV0V2ElJ2Ylyk8=; b=SDQi+GE3VykqAm8eNSGUAbsQHC
 USnIDhAxYvSTKUh1lm3gPkmYfReZfx4D19uX6oosi+M0IlSAcF0PrNZTC+vkvVIz2m/kbFZBBfvkF
 0dR1k60c8Cxo985XTpxnTWfeFU39Ala0D23pMhX5VbnfqDSGvuBRftOdLp3/XAi9tu2M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2LVPIld2ztv8g4OHarVULHrbsMMe8EV0V2ElJ2Ylyk8=; b=b
 eENraT90dFPHj/aWmTgwUxuihNmcwEWZsBFpoCUAsihVzBglRV7nBKQLmfwFlEQEs/o1xN+jpHvAz
 /FwHRN8sFdCjiLQQKtdPZb/0T/h2HL+6jtkYGXlw+pWvh2fKGbzog7DDWPUjL+osEOGyCwaDbP12O
 LiIwq7+VKPL8FuH4=;
Received: from mail-ej1-f50.google.com ([209.85.218.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp36l-0004zh-9K for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:09:58 +0000
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c15e2dab83eso131587666b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 05:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785326989; x=1785931789; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2LVPIld2ztv8g4OHarVULHrbsMMe8EV0V2ElJ2Ylyk8=;
 b=a2jcbAcNTq9Hrzt08XHPyW/Mq8vmjhZ6xvXD/KnapoqnofpFjBNpKKqIn3Ce6bU7nc
 WkojxXGUEul5o7zFhjMbZI+RgGYY8c0j7StlVFC8DIwqhuUW4f15inJtAfqUyK9+i2US
 0tFS8W8OZS3+Sep1NlRNFXD2wHZhTSA/P0lWY2MiWKenCoawxboxBW4/3mvrpBxOWy8g
 WbWiaR9nmnyCWq5zTlFaUNWYBDR6aNSIbOewsMacD8leaZ17xTT4OWvlqDOCfgcSEXPE
 ThtBVvcz0qgRtqugeaLVdG+FLbc1tesDmriPkphHgKN8sgRKEHw82nkdL3OvUz9RRM15
 xG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785326989; x=1785931789;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2LVPIld2ztv8g4OHarVULHrbsMMe8EV0V2ElJ2Ylyk8=;
 b=W2r5waid2Q2MlSeVIRMFyUMO4UaFNBLDJ1syfoGWv8bc+58+K+O/irqEH7SoJynrYL
 ATm1Up9VMqHpA5hoEDHul6CgkbW51m5tAlXtkqRXkst5pDFsriFrCcjsRM8aJoCq7FWF
 Kqfz5i1Il40D8dPMM1trIPcWLUpNFA13oMPsYYEQrT7LlE7Jgv0Lwgi+dHHM1YTYliu1
 +7KTncoFtrf17WBcK+AGnDGENBGVd7R8tYGZFpSBBTqwqhrg3JACqvC/nmON2WTwAFAS
 N2+2sTvJwcevoocEGg7GxUR5bAyZxO79vvKCjGSAX5Hn1qOHDvK1huAARKypuwfnjbP4
 OepA==
X-Gm-Message-State: AOJu0YzCEonHhhC+jWFFVAPMUzIFYY0Fc7Po3FuLpEMSeYwt1IlRxMfq
 cXL0dnZ5xLfMJPZm+0jUAvUAZCIwGy6aLYJnitC3XMJLcie5wVdHS86wjq2cPXWs8rJgDoxiNAT
 JX3cK6OoHNedklJhgW1aAwTIziR17QtjLAQV2hwDBKzk/Tp0250YTMbahc75jTiJKI4bo2/4VJe
 akNl627w==
X-Gm-Gg: AR+sD12QE51+A6MHpnveRBw540Y/fjiRPJvUvpBFoz62u9F8GoyzEXo/VnfRaEbxZik
 Cfx/SxykruqdUUHd5ltMtNYqo70pm042F6nKb4j3mTY5K7fNEHDthLHe+DRCTZGJN2bqbrrsmD6
 2C4KT7GwsNAaGEwo7pmoekkFpYijc89ke+EKDDY3W550S5Gg+Ad0HpILyOtTJ8bKnclwEqwkQDG
 1GaJfBYTrvhXN/IWcbrVvqY5/oqloXmRno+B7kiNMnd7uSkdmXdjfIjBazV5qzXwYldH8/PdF48
 JdMc5KKGa+VKsr2RAyG9yqVNOiJ5QMAHj2yG95PjXN9chqx9aJAIIL89VbZRcIoO5DGloIf5S0z
 I7/30i02fONpEwHVwXr6Vh14FTEvispe/o2VGFZOd9dhBUBNq06Ndz/NPoH3SIloP+Y10/sSJXO
 TY8BbDbK2ElSuDOyUs+6SRLE9xjQKlm3kQoLHJrG0TkxB6XWI4G9aiI5ZN6m3gJ6ZA+vgFDkDQ/
 KgbrLLDetfEuL9fgTSWIB0P9vvA4GpIkEi7QLnJcNw6yH9Mzkz3/QXW+PufJSOB1u1wd5LQva36
 Tg8TOuz4P/SH4bqBPwvxJO1HtHnY8tivDqoGDweuVukhjx1hGszFcPEZeyMXAg==
X-Received: by 2002:a05:600c:4291:b0:492:3754:15f2 with SMTP id
 5b1f17b1804b1-496c65a23bdmr42977865e9.32.1785326506738; 
 Wed, 29 Jul 2026 05:01:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4976bd83fabsm54044885e9.15.2026.07.29.05.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:01:45 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 12:01:41 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
X-Gerrit-Change-Number: 1828
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1828?usp=email>
X-Gerrit-Commit: a106971f5cf6983ff862a7c0d8de831cd05b6bb2
X-Gerrit-Comment-Date: Wed, 29 Jul 2026 12:01:41 +0000
In-Reply-To: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
References: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjM5Mzg3MDAwLkllMzNhZWEyNjAyNmUwN2M4NjBkYTdkNzk4ODBjZWY2YjI3YjdiMGU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ee08af62452e747d9b43879b1a755176cd625b93-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp36l-0004zh-9K
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Move schedule test
 to a unit test
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3044012863039707636=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3044012863039707636==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hAR44luvFnA="; charset=UTF-8

--hAR44luvFnA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1828?usp=3Demail )

Change subject: Move schedule test to a unit =
test
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 4: Code-Review-1

(3 comments)

File tests/unit_tests/openvpn/test_sche=
dule=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828/comment/6917016e_=
d4b4df7a?usp=3Demail :
PS4, Line 91:         ASSERT(e !=3D e->lt);
We shoul=
d change these to proper cmocka asserts, but not sure whether it is better =
to do that in a separate commit?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1828/comment/c1735282_e178d672?usp=3Demail :
PS4, Line 168: #else  /* if =
1 */
Does this code still have value? If so, then we should integrate it in=
to the test=2E If not, maybe just delete it?


http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1828/comment/3ce2fabc_9e5f4fc4?usp=3Demail :
PS4, Line 173:  =
   struct gc_arena gc =3D gc_new();
gc seems to be unused?



-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27=
b7b0e8
Gerrit-Change-Number: 1828
Gerrit-PatchSet: 4
Gerrit-Owner: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment=
-Date: Wed, 29 Jul 2026 12:01:41 +0000
Gerrit-HasComments: Yes
Gerrit-Has-L=
abels: Yes

--hAR44luvFnA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 4:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1828?usp=3Demail">View Change</a></p><p>3 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File tests/unit_tests/openvpn/test_schedule=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1828/comment/6917016e_d4b4df7a?usp=3Demail">Patch Set #4=
, Line 91:</a> <code style=3D"font-family:monospace,monospace">        ASSE=
RT(e !=3D e-&gt;lt);</code></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">We should change these to proper cmocka ass=
erts, but not sure whether it is better to do that in a separate commit?</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828/comment=
/c1735282_e178d672?usp=3Demail">Patch Set #4, Line 168:</a> <code style=3D"=
font-family:monospace,monospace">#else  /* if 1 */</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Does this cod=
e still have value? If so, then we should integrate it into the test=2E If =
not, maybe just delete it?</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1828/comment/3ce2fabc_9e5f4fc4?usp=3Demail">Patch Set #4=
, Line 173:</a> <code style=3D"font-family:monospace,monospace">    struct =
gc_arena gc =3D gc_new();</code></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">gc seems to be unused?</p></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1828?usp=3Demail">change 1828</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1828?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1828 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none">=
 Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Wed, 29 Jul 2026 12:01:41 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--hAR44luvFnA=--


--===============3044012863039707636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3044012863039707636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3044012863039707636==--

