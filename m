Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C60606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=a/tFGLQA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Sj5NouUA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bsFDIdgt;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UhUUCKlP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9ksjruYCa5ZsECNSdoakCkji/yrWWIYqdo/wOvYhT4Y=; b=a/tFGLQA95A9cV1SO3E/gfejIi
	KHAKu0+PUUiIZK2MZdAAiOcTmXMvyeApuXlxGeTO7dONLYua4blOJNjAoJmVKUF+3qlDt60m/6WB8
	dyirijxAhqDEmJg8QSNkC5IfFYm4pTrvlBIPhaYXJFXvf0w0lXjgQZbdJyswr2h3rQ+M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVSBI-000000000R6-09xm;
	Mon, 23 Nov 2026 11:25:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVSBG-000000000Qy-3NxG
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 11:25:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x3e4x/d5/1eALQV8Dxl7nyVwRi0GHfCB+vC1IIzIwJs=; b=Sj5NouUAHxRBwelDxIqQQlouTP
 GIm8cGB0DphCuDXSd9O+aUtJKBZ2Bm5X+JqqmzT5WbwXJAk0H6ppuvlhQcxAdiIqk4eLCFRJX5+fg
 FjWlhFqbk62BvG59uXj9rOQdFUCAv90L5uU4VnXWECMYxzenLj9mmer0mDx1ph3pn0k0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x3e4x/d5/1eALQV8Dxl7nyVwRi0GHfCB+vC1IIzIwJs=; b=bsFDIdgtRPy0geWCG3iZfrCnnB
 nNLzyA+h1QRlnUlaenBgnG17bghYzF430XRARIRb945/x+rjX/CvjuFTVvwkE8LMDQFtJ2evRqAgm
 fLdldjoXCe7/WoNiZoZ23C4qA+zulRt+8goI91YxEjY2Z5hXGJQtIRuwIEDU08ZZGlPk=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVSBD-000000007Ac-3Vwl for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 11:25:54 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so39746265e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 03:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795433145; x=1796037945; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=x3e4x/d5/1eALQV8Dxl7nyVwRi0GHfCB+vC1IIzIwJs=;
 b=UhUUCKlPvEN4gRR5vYPDzqqLIIFUnZZU+tDe0c8y3hDW4KVSGEwDlDAo8bV7dzd01Z
 tdIoGip/oqiPjN7IYrs17Gk28CW+5sVYRcsO7CyH638EG9ZbhvsiVF8T8tozQGBbZZfn
 be2jtJsDS0McO4pQEiIOq3kSjaCyiahRGwNKF2gq+KgWfxLXukxAOIs7C8xb6q4YeG9K
 HjpyJgJQ//7cWTUukvJ1+dRsOw2Ki5ELRhr1en9/hnrPE6OzFNRQOZa6MrGbcgitgjh3
 ayTLmqSAUvRgXfNN2Yz9ulJEyzVhqqTqVSUge8PvaqqfqWPPX89px79MTMxusic1pgE+
 Ex8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795433145; x=1796037945;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=x3e4x/d5/1eALQV8Dxl7nyVwRi0GHfCB+vC1IIzIwJs=;
 b=FMR5TStNMfso9Ha0S1xpAaJFugV3z1+07T5VDqkBPAmO92/hcCmhxNlCt0FW1GCn1K
 EHRHMhRWmf6QM1FTpVD5b00myt6tyLHqWYEXZPVKBJZlPLB9xfx5ciwC5K0LcMtym11j
 82jCtRXYPSHznpkyDW8XQkhk6wZbhHPinhaavRaMEwvFlIxrD2VH7zOgau0cKD+PLumL
 CoeH8tLsPVRAI/rOMI/dfV2DrEnyFMaODtd8ai87uW6qyW/7r/p6rC5vi3TL1TR12Sff
 LCFKeV2bLlnAJ8sLxw32h2WJrQitdbxR/iJ/GiWcFhgEfrRA5je60PwsCQzxAA7IL9f3
 7U7A==
X-Forwarded-Encrypted: i=1;
 AL+hErG+tDxlDA8LRf9pjYx+PMIRRPYqTOZZP4zBlpozvS6jUXrtcsheRJUehcvFdaCvsibXtvNr0SqYBb92fBdW@lists.sourceforge.net
X-Gm-Message-State: APuU4Z90xDSDxyXLEdD2ldV4hgtsdmpic3sSqoFak2e7ZGx6nYBrYrS1
 AIZjEa9yol4Z1q9t/ZnU9LeygmHLBbih8Vh+HEuECBS+bh0qBmF4/oxAgFTwtl0AgIVoQxzlWA/
 Me8aCkJJCV429twrAJwJ3iSt8I78uvU7OqTdfa/P/5eJD1F6YVtytS+jfoazgRKAH42W0
X-Gm-Gg: AZFdTZdm69fMe2LCh+lPOtOo0qQkFLCO021QSFXdxtSWynlKZ88QTQv2D78DCGMlpdg
 dOhIHf6rC8CgIW5if8xfExIF484Argoe7+dBxnoi037cEpuN6Euj1cBsQuELCwplaRaBZqBSpUG
 wsoys/DZMMl0NcA/udO42EeYokmyaP54RbQIg63ul2Va8b02z7jnybpGKzhNKcPP2sFU5x2JcZB
 LT3bni1q4IMdaE6MPO2EPbG9n4u9Ws5z/GvFF3o9sDYjuyauksYE+fYRmv9t/fKNORPl0Kv6SwX
 9DgAWNyPbx19uvi5TcKUrlqZAegGBCMvucjBF4gwgFB1jxcvJnu5d5HX937fuBVSHJUOCH2Ct8q
 m4JNoHq1Hb9qK4PpwvmbrLCDgjUXL/T1rglr363Ywzq/Gx6mVOetVQcqBnXDXK1MSHTtKKn992x
 VDXPMh/z+rFOmy0DHuXL/CgTRzj/wPs7iiNJahxexyWytcDhbT+tK0zTXKGnM0or67c3xMex9j4
 AfiThNrBS6anwki/dIeraV9v8EoKy7Jer4sfV3sjX/hOgw13Jk66otzQYQpiscQaV5nsb3RyX7U
 nwYrB5QN+V7eHni4YFBbtolwErJD9BHno0PgsXuF/oWcrR/MZqnhtQev2wRleey/wyV5SrjtlXH
 paK8CJNKsHpXCzVDe1zdkIWtwf1uQUuOLQOHpGjd3FR+ds7Jg7NWppE57v1tf/PEbsSJZDsk8Q0
 s26+yfOgiRtL0uHknUReYYoX1gW5Odilnc7Psp
X-Received: by 2002:a05:600c:4f81:b0:4bb:5e8c:13bc with SMTP id
 5b1f17b1804b1-4bb88805902mr219282345e9.7.1795433145100; 
 Mon, 23 Nov 2026 03:25:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884ab091sm493126415e9.11.2026.11.23.03.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 03:25:44 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 11:25:43 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
X-Gerrit-Change-Number: 2326
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2326?usp=email>
X-Gerrit-Commit: efa25f6851eba8a7900478f14942f8f015054603
X-Gerrit-Comment-Date: Mon, 23 Nov 2026 11:25:43 +0000
In-Reply-To: <gerrit.1795430074000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
References: <gerrit.1795430074000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NDMwMDc0MDAwLkljM2VmY2RiN2JjNGU2MGE4MWI5MjkyYWRmZTdmOGUyMmI4NmUyNzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5c9aed24457b2d818f50e671e969ddd774dad5f6-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVSBD-000000007Ac-3Vwl
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: socket: check
 the address family in addrlist_match()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6931509159751546296=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6931509159751546296==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8q5hJIdIX8w="; charset=UTF-8

--8q5hJIdIX8w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2326?usp=3Demail )

Change=
 subject: socket: check the address family in addrlist_match()
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2326?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Change-Id: Ic3efcdb=
7bc4e60a81b9292adfe7f8e22b86e274a
Gerrit-Change-Number: 2326
Gerrit-PatchSe=
t: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revi=
ewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Comment-Date: Mon, 23 Nov 2026 11:25:43 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--8q5hJIdIX8w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2326?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2326?usp=
=3Demail">change 2326</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2326?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 2326 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Comment-Date: Mon, 23 Nov 2026 11:25:43 +0000 </div>
=
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--8q5hJIdIX8w=--


--===============6931509159751546296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6931509159751546296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6931509159751546296==--

