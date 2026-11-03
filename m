Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFC6606A326
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MBKx72V0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BF6NUijD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=V59SEvwd;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=E+ypCVhl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0av+TDUnHNX8/INNw++V/PdtwvNsI38y8Lrw6Gx/O+Q=; b=MBKx72V05KYAVSLOgxZW5u7Nf9
	UuI+kCzSubqS+vJUv6CDVx8mGDmMUEZNHFEm10XhGPvH4N/9PxDrku0HMem3ALJm4fdhbhk/QC+NZ
	NJD0ZmMIMwmrLZRsK/v529BNlrfHILo0b7LO0slXtBmzV1HppWYFSJUjnprg1swYwp00=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKck-000000000zp-0fK3;
	Tue, 03 Nov 2026 19:56:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOKci-000000000zg-22d5
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:56:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i6Pg5kwUZjBKZNs8PHeE7ETZcOs7+fTP4gBgz5jLbWU=; b=BF6NUijD/8CTBlDP0j9Z4LL6NE
 O/Q3W/zZDf3MK8y4PKNVX4gxI1bWZr4ggmnVFI6HEipnecq1l0CGMcJHDikYqr8YcH2ZtRmdlchsA
 VtgN3wb4WSz6ObVsfB5nwdoFg2RwUgiVxTkSP+s1Gt21PkJv5iTtpnBnWyQ5kb/TEGzQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i6Pg5kwUZjBKZNs8PHeE7ETZcOs7+fTP4gBgz5jLbWU=; b=V59SEvwdDQAkv9uZmqooNGiDiH
 KxQe6kDdxbzoWXF0y6mfnDbv+iJgGveghATuxb/iHScJJsORT0wsmmIec9tVars3bQSVIbtqYvAsl
 lBuxnOn1Cnf76BqRgyHvHJorbvRaMC9CDcFyBwuikPMIpcpePYJQFbLxPvLPOwsKQIhU=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOKch-0000000052K-3ATQ for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:56:48 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so36500145e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 11:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793735801; x=1794340601; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=i6Pg5kwUZjBKZNs8PHeE7ETZcOs7+fTP4gBgz5jLbWU=;
 b=E+ypCVhlWSCVN6u+Mt0IUY1jh4HkoKuCpxUlgb4xdmXCQzBPdZdLLdlOqk6FHJzj4Y
 A6sygCzvx75pBHCoy177LAwKyealFAcmYenRIVueUw59OdrBeG4PK07xgePDYMIp7ocW
 8fElJN2HybjwM0PqkMqGpskKsdD3wJOd5+hBoS+FLb4eWePYrdehi4zdnhkrdnwkR39G
 MQ7hsMTKLw8gmsgkN/x+23mfdXut86EJJrPcHIII8oocv6vJaRqYKZ1jL+1S9IDynSrP
 WBzJpAaJK23WlyfafE0hUSMC9Cqnext3oIfT6evXfiAgK/uDin5UK88zSi6+8YOIZUYi
 BzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793735801; x=1794340601;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=i6Pg5kwUZjBKZNs8PHeE7ETZcOs7+fTP4gBgz5jLbWU=;
 b=Jzjb870YginCFCvIQ9TGsTnO3bHi4mobpsVptxs7NY1KyNb/hlL4CACgUZ6SRHglok
 XgNy5Pod2iJfNyBIM7gXsMuADNxVCDnoiTPloGACZ9KdUNpM2m9wMhIhbCZ6fFvVfmrV
 vEqvRvbug+O++qY8sM89MyJUiRwd1tD1/E/pdKuDE83evOPY3Z6mtDpkbG9yMJ+yxnbm
 85+F/KYjoETNbptvfGjjSq+7+OjmX2YX+pvXeO7kTGJimElBF9ce0JZWDv/v1PYPOXlI
 t7+DWo1yLNHEqsvl9OtX3P2pIk2gCvztOe1JMwRiSVa419z1VA7PwJoa16XCM4mxfkPM
 fqFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdWGEeKC5hqRdrBVkx6UsHK/Ju90F6KW+LXdN5xY6eqCVSEZJEjvQf8EFizi1EPD837r+4d/g9tk3tEgII@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+uLo09moOM4uCScQTowABTrMe7nVnphKUNIq/9sLPI+n/ehosV
 yE+AKVJZw5hqeHDohAEaykggCQ2alXRL7DfqFzNgwG9+ACMaWrXLcvS2kJw++E6Hh1IeLoFAwJI
 /JrEuMNuxP09AKeSl2SULML/ekOVB0p0D7al7ng9PHN8sRqx1cWOUCd9nmwtvivQtiNrX
X-Gm-Gg: AYBFou18FIRZu54LmO9rjz4cvMQO+aEdBsPeDxgaMQDZ/r1IqHWArNHfSvwsQjf1dFm
 oXTKLBbVikoUJS/xk17zlM30GT9OlgDIzTBLXhei4Yo1pYj/XyKH6QDQSCTN5GYmtq4u1wOHqfF
 5Pp/H2EWJHvdbzXWMqFUq+8XyW34gsnpSnZ0El/xUEWssu586h4MMUTQvKWW8Kc0iaBd31DJj1U
 pCZs8nyhiPt7oe8dkRxKdU4rP8TAVluJfg/4/go7E5DScrN8XP6suiIaioAXfXAJYquBZaeq5F/
 8KUed52AYh3q5IqpG0YiDTGYV10yRuFc2huvaAM+AFvKiOL/ohz25dhkrGxHe+nA2dsZFYbnArj
 kuojMrtgv47XWwcfkZjxmOmEie/JdYzE09lxM9oRFzpqIL9qUWHCXYzGB9b2vToH6TJsU9Ij7Z0
 JYMaAeTJSIAYqEELN3cio35TTv6epxBoo6mZdLXssVVUoX8u7J+lzmf9lx80wEKAOYq6obaBTRv
 6g7/PcPrg1/HgMt/lceTW5tdq6I8l9+SYyyFfXoQvGCFi+7ewD5IkKbICwVqZy+W5nmfqyqchRo
 sLY2L58wi5rFvZIPY2AjaPyquLvxPaVSDdKlMW5iw9NtgH4s/FO3waos53tLAcUqcEGCLBew7SX
 k6EFpgy/DnntE6TiW3vE5/pk2Sm+l0PABc7m8fFuDBEQO3EJCEyDqbKnJbnOJTbgHoK5+fdrK3C
 R1AuJeSoLI6fCQGw==
X-Received: by 2002:a05:600c:a11b:b0:4b2:3c81:d1 with SMTP id
 5b1f17b1804b1-4b23c810353mr82358165e9.5.1793735801026; 
 Tue, 03 Nov 2026 11:56:41 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9fafe08sm130556755e9.3.2026.11.03.11.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 11:56:40 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 19:56:39 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib53e82554712d881b1e24f6f3a2f8fbb702951bd
X-Gerrit-Change-Number: 2110
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2110?usp=email>
X-Gerrit-Commit: ce4ffcd7a39ddff95a66902d55c9f2c5b14c2612
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 19:56:39 +0000
In-Reply-To: <gerrit.1793733304000.Ib53e82554712d881b1e24f6f3a2f8fbb702951bd@gerrit.openvpn.net>
References: <gerrit.1793733304000.Ib53e82554712d881b1e24f6f3a2f8fbb702951bd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzMzMzA0MDAwLkliNTNlODI1NTQ3MTJkODgxYjFlMjRmNmYzYTJmOGZiYjcwMjk1MWJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e2e672d06d224034aff572cb7fe1f846ee30afb6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOKch-0000000052K-3ATQ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: don't
 use registry default as format string
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1246649552000380835=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1246649552000380835==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1XXORw5kXPI="; charset=UTF-8

--1XXORw5kXPI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Heiko Hund has posted comments on this change by R=C4=83zvan Cojocaru=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2110?usp=3Demail )

Change sub=
ject: openvpnserv: don't use registry default as format string
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2110?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib53e82554712d8=
81b1e24f6f3a2f8fbb702951bd
Gerrit-Change-Number: 2110
Gerrit-PatchSet: 1
Ge=
rrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko Hund <heiko=
@openvpn=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date=
: Tue, 03 Nov 2026 19:56:39 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels:=
 Yes

--1XXORw5kXPI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Heiko H=
und has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Pat=
ch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2110?usp=3Demail">Vi=
ew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2110?usp=3De=
mail">change 2110</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2110?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Ib53e82554712d881b1e24f6f3a2f8fbb702951bd </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2110 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Heiko Hund &lt;heik=
o@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Comment-Date: Tue, 03 Nov 2026 19:56:39 +0000 </div>
<div style=3D"di=
splay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Ger=
rit-Has-Labels: Yes </div>

</body></html>
--1XXORw5kXPI=--


--===============1246649552000380835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1246649552000380835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1246649552000380835==--

