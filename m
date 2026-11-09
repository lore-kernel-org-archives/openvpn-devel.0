Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AABD606D807
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KOa6hwAI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WP3Rb+qd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lOPFFJUG;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YFzDvjV3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hO+mkTxgSwg5Wfkukvn3dIHwJOskxVb0lmmowDHYUXU=; b=KOa6hwAIMY8PdJ6HVpuTU72/9+
	jIRTBs59zx9+qiAxJkhuZnw725R9jMalFtQOYHcYBYo2Pil84PdnCySbPqgHYnsDltRacp17rZyPn
	kBvKx9Ao9uxaspsoKX4By+yJhwFdpTl7ag8UGTxplx/XN4cg3KZu58CgpKcmEn1o7wfo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQPo8-000000002Xs-1cqE;
	Mon, 09 Nov 2026 13:53:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQPnw-000000002Wt-0Sf6
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 13:53:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L3hGlH7N+dbi4kGhce6Is8UFlbt2PyMpbJ676117enk=; b=WP3Rb+qdvdkPe89zj6gQ3xBZPI
 /WA5ewe72oBJpCJkfLAFlqt8zhMclWWRSjNz6BlKDAkDVPIKv7ZlzQL7aecj810abRW7d5lW1j/X2
 3qnX2JXq3YdBKjJShkDjr7W5+T1bqYYx8fWFHq7+2GZ/NwPA0pfkm4rxGB0mVINOzggI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L3hGlH7N+dbi4kGhce6Is8UFlbt2PyMpbJ676117enk=; b=lOPFFJUGDP+fNEJChEo2jZaAOo
 n0an2AVSA691zog/NEq1plWCQsT1IY2iaq37Rrr9QXBorQ6/ktCo/OyY55sxDwAOT/FU+cSL5WEcR
 rE0GjPZmyFusEL5OEx/UYa2ODsd+X41SrNTK2V/5mmx7O2pGqXIQgXV/6QHQLmFWSnoU=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQPnu-000000007yG-3Hms for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 13:53:00 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so5940725e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 05:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794232372; x=1794837172; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=L3hGlH7N+dbi4kGhce6Is8UFlbt2PyMpbJ676117enk=;
 b=YFzDvjV354aNjfT5pCNwON+rG3ebBvhVTiyS+HskKX0lop74/oQdrpWHE2bpfhMrss
 LHtuGd7uHjHA4u1OOpwE4gi4yj9RkRaT9xQESvjwo0RD/ehgooouNu1+fektvQ17CTgc
 +N0Hi6KUtRpCmOui7tH8tDbVCwLujyuizhPqBOd0g37ImTMkxqorfNwfFz5HQIVqSoTQ
 eQniN/U2AEpTP+eBWC6+sIS5piOG1HHK/2Vi/8HDeKs4ZMWWEL9df2SX9Jx40K0sPkON
 t6okepIPQK+IUZVjFu3EVHP1NrqoQw+cA2Dm6ulRoc+13jebwM6sUfyHG5gEQX2W+OEq
 zicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794232372; x=1794837172;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=L3hGlH7N+dbi4kGhce6Is8UFlbt2PyMpbJ676117enk=;
 b=KHt638wJKC8arUbadyXrla+zN4uMQHF0G1xxbKPsSc9bScmtIjrzsKaur2galXJD1z
 7UhyzPSqQWTeq7efcHtkRI8JyRTfDNHex6y/iwcIoDfuSW2hqtZ8IIr/Oq2TAXh+dS6h
 8GLLn31BWDGLrGwjCCcX+3R2GyrKPly9y2E7mEe4cUbCDT3cFt1G9Q68dPSrs6KccaL/
 g5yzHv7QKz0zyhwJdeMpqhFkwbQn5VtamPb2FFC4RB6SF2HE65NakgyvDrNgh0IjjO3V
 TsepJWGIQKn16Xz0CNhyb1mLr/8RQS6e0cIskslvs4xxgmOKynbQXM5XCiAsTw+Gi7b6
 t9MA==
X-Forwarded-Encrypted: i=1;
 AL+hErF155ot+3XTOJZCdqeMFnS3gUzgnVtRa9ZHy0MZeiRaoEOhk/JtWFNJCac7m4XTJ7qO9CI/NUYJPZsLfLmJ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9QAQbXTh9f8WZ2ZfPmsnb8n7aZeJS7FJt9DO2lW9puEZyxr0Ye
 0XqIa3UCFY3/8LbiyupkfvkLSS9gtHiUnTnhJRPW+YYa8yIkLjG9q+v3SMjD1sL1ab33Vsle6oD
 C35Jzm+Kus1aGXy/YzIxUoB06cc8azKyVHwCGOTMOcDVoxYULQZ2jRY1rUwDK0j2D213h
X-Gm-Gg: AYBFou0h1XXGVWvvQLRaANdPLLWMG3Omz6BtGDGzzcX5oYlQyYFp6GvN+kRndmbzyzg
 kfLRiV1dB94WqaxMqEQOJhu/W8Jq39trbjqnwf0qCaY8+cIBNDdSP5N+HxEetCV/GwFnZ0kYVX1
 gcF8C/dFRhJupoD1qoeHWa6EZFC+I2PnNNJYAkWG+gACsiftBOyfpNJrf9830AnTWGvY8OyH2hQ
 SngEjZQmpkChdIj4UxFOABrWZwJ9nNIVKu1mu6is+OfHT2GpATPaSi0Qmub3L8H3gCQjIbN3BPF
 ob8flkozaIW/93M1sC7CBd0bM+IQpJFKfw45egmJgjzwqVlVKUuAMZM3A/JlaAijFFFXEyInIqr
 0GZh6oZ5Mw874KJgm8z+Lu4iNv3AcuH58kAh4PqTh5ybPX5hFKgCG/qT7GwyUGRdWiYRaNz8TEN
 XOnMmLegrzPj1BiH7EtS8NfOIWlVMKwDR9PUCK5VezaxdH97CC6KotFnLJDcSUlvJFb2NTkcAH5
 J2mC73EvMz8X7owP+00guEzPXih0I8PplXJgx+zl+OwTZS87lXmoEIkNk0hWUkEgpCLhZSECjrR
 cEa9yPUl759pQpY9FGbs7NeitBEH72/JIlRcwux884uTRw/rvDyDuTcD8fn/WOF8EIab65t8G/G
 ZzypB3x9OohnDtOQN8AfrmhcNH8snsf53Lc4U+Q/QAjtwQJNl5VxnJ1taHSiAuo3zd3ri0UfTBH
 8Yi71jIhof3uLWWw==
X-Received: by 2002:a05:600c:190e:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4b960da4c0cmr77921405e9.9.1794232371781; 
 Mon, 09 Nov 2026 05:52:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597b1f969sm9958512f8f.50.2026.11.09.05.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 05:52:51 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 13:52:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b
X-Gerrit-Change-Number: 2001
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2001?usp=email>
X-Gerrit-Commit: 1896422807ad9616e71c8e8e99c921312cd21b25
X-Gerrit-Comment-Date: Mon, 9 Nov 2026 13:52:49 +0000
In-Reply-To: <gerrit.1792128387000.I089e5b79600c535e3c0c5d1bb14319ac03f4144b@gerrit.openvpn.net>
References: <gerrit.1792128387000.I089e5b79600c535e3c0c5d1bb14319ac03f4144b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMTI4Mzg3MDAwLkkwODllNWI3OTYwMGM1MzVlM2MwYzVkMWJiMTQzMTlhYzAzZjQxNDRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a82d26c99ee1dc942341b7565ebebf026ddb2a73-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQPnu-000000007yG-3Hms
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: openvpnserv: add
 automatic service again
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com,
 heiko@ist.eigentlich.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3923193823633964985=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3923193823633964985==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2a1YzUTSCg4="; charset=UTF-8

--2a1YzUTSCg4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund, Lev Stipako=
v, Selva Nair=2E

Frank Lichtenheld has posted comments on this change by H=
eiko Hund=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail =
)

Change subject: openvpnserv: add automatic service again
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review-1
=

(2 comments)

File src/openvpnserv/automatic=2Ec:

https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2001/comment/40e40d34_f50a9275?usp=3Demail :
PS3, Line =
113:  * @param pos   [in,out] position in the buffer in wide characters
@pa=
ram[in,out]


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001/comment/fe85b=
420_7346bfb6?usp=3Demail :
PS3, Line 858:  * The interactive service lets N=
T SERVICE\\<ovpn_service_user> start OpenVPN
This breaks the doxygen build =
in buildbot
```
/build/ubuntu-2404-doxygen/build/src/openvpnserv/automatic=
=2Ec:858: warning: Unsupported xml/html tag <ovpn_service_user> found
```

=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I089e5b79600c535e3=
c0c5d1bb14319ac03f4144b
Gerrit-Change-Number: 2001
Gerrit-PatchSet: 3
Gerri=
t-Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=2Ecom>
=
Gerrit-Reviewer: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Selva Nair=
 <selva=2Enair@gmail=2Ecom>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=
=2Ecom>
Gerrit-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: M=
on, 09 Nov 2026 13:52:49 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Y=
es

--2a1YzUTSCg4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund, Lev Stipakov, Selva Nair=2E=
 </p>
<p>Frank Lichtenheld has posted comments on this change by Heiko Hund=
=2E</p><p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-bl=
ock; margin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1=
</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?us=
p=3Demail">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnse=
rv/automatic=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001/comment/40e40d34_f50a=
9275?usp=3Demail">Patch Set #3, Line 113:</a> <code style=3D"font-family:mo=
nospace,monospace"> * @param pos   [in,out] position in the buffer in wide =
characters</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">@param[in,out]</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2001/comment/fe85b420_7346bfb6?usp=3Demail">Pa=
tch Set #3, Line 858:</a> <code style=3D"font-family:monospace,monospace"> =
* The interactive service lets NT SERVICE\\&lt;ovpn_service_user&gt; start =
OpenVPN</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">This breaks the doxygen build in buildbot<br>```<br>/bui=
ld/ubuntu-2404-doxygen/build/src/openvpnserv/automatic=2Ec:858: warning: Un=
supported xml/html tag &lt;ovpn_service_user&gt; found<br>```</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2001?usp=3Demail">change 2001</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2001?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f41=
44b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2001 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Selva Nair &lt;selva=2Enair=
@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Lev Stipakov &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 09 Nov 2026 1=
3:52:49 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes <=
/div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></=
html>
--2a1YzUTSCg4=--


--===============3923193823633964985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3923193823633964985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3923193823633964985==--

