Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AA1606A32E
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 00:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kbwqq/7i;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OK3OVS7D;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=i97XfcY+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PR7ELp0N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/cMflAQNsv5FquixO3ILB960qBvhs0CkuG/D9zV/YCU=; b=kbwqq/7iveS55fKfyQRIQfV51G
	DZdhIJyRtccTuvYPSkZQBXCnxanwDuojb941Rvh6wY8ua9FHnoOolEDaz3hmhuatgI9Wo7RDoLhsW
	lLtBpTSh+nGeYc9JnWbHFOz1kw4oz5tnlArn/qBEuK8oLBQZn9/ZSfFToV3lfuCGi9qc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNgC9-000000004e3-15PU;
	Mon, 02 Nov 2026 00:46:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNgC6-000000004dw-3qv4
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 00:46:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G+oh5xAJlE6dfParTciBFE9bDDJVxmk+sX3J5xYOGvM=; b=OK3OVS7DHXmUaEK1/9ypu9eK1R
 H2hS/oGjqe8zo/LY+vRrtrFEznx/Rt2wfSEagVnPvx/Fjzcwsff0Bs2JOQWfMFYF3UquQCi9qrWf1
 Nhr2IuBPiuVuWDKFIjT4V8UZ2VypALqZgglSX8Gd8+lmgu5XNGbRdkUnTUlRBZ+tt5mc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G+oh5xAJlE6dfParTciBFE9bDDJVxmk+sX3J5xYOGvM=; b=i97XfcY+/DcC7gVaSI8iR6g8wh
 xru6D92hsi5xZZ+lpdPs4KRyklQgl+RW/HoA6ftshlBBu8yQeiHprFJVH89AaneLLtVF+GPBTLzlE
 tp4fex1PB3jrcbZP1cUjstFH4g3UPS8SXMJdeoW874aVkwbUCUfhGOcIhVExZtKWlZDk=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNgC6-0000000078q-19lb for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 00:46:38 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso1042317f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 16:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793580392; x=1794185192; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G+oh5xAJlE6dfParTciBFE9bDDJVxmk+sX3J5xYOGvM=;
 b=PR7ELp0NhzsZGSrMCP7HkIiVV+IvDu83+kbjyBtU78BvtEweHUMX3dw5+rupKqkjYe
 gBVz5bzILwenxLo1lSp5vDIRZh0anTujGtf+dIObe4XrTmge6pwc3gLFT98rkzugQpcN
 0F+LlUV9yJVMdDPqZ1/wwI4Sl6RDcFBnaIudLtvs4ha5CS5hWv9kN7kQgkIBUiAXRzre
 d3SuZGTzsNltqinAqW2MEEHU8bh4rCGkyb3kZTS528BQsrT6edI29//d0BebDhon8Du7
 v7lZRve4nznfbgcP2iPG6Vj057LISn0BgjY2JWImq8bJyPDEnrcOIp/AbTnzIrBj+rc6
 Z2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793580392; x=1794185192;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=G+oh5xAJlE6dfParTciBFE9bDDJVxmk+sX3J5xYOGvM=;
 b=eWihkESHTng0rtQvqyeg284gx3cOOpEmR1EVVjAJAfN0/Bke091Z0lbWTCM/y9luBV
 P+xgrjsTsVJF9TR21757zd9XYi4Mi9AWS12XI8EQ4UqOYaYH/fn0bTSzc51/jiEPXqkT
 hJDp+/kfur3bIl8Q8SQ9E9tqJXyWwAgSzhmLkmwr0ULqSxCaTrD3jlCr8w+jDau6WVMZ
 boqnyYHBSTHpcc3BKIpIRhxHYkCT9pLJBoZgTZPiGWik8UNGjYop5+N65Nu3Be6UtmFQ
 nKiJWwB79vxmCZnpa3X2m+vOfTij6OBdYKA3I0FrJ1P4XBAfbB0onav7i367CeQtAq9W
 eyXQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdI15aGEEmgTcO6/K1LtMsKbvtB1yx2+anO0z2T/L26n5TCVGEqs94pi7JjYkWMEKJ6ousRF0uwRCUnemT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z97Z+rnVwQchwq7dCfo+JLJD0IW05XSjiXjC0aea/epb+b6ZN2N
 10YMEL6Vfm7asbUehiYC9TPUNbiBkwHst+xoMzOPK+ArFbHt4im6hMtw+FpB3wT1jLVfh36EV3/
 LbXdGuI2x2R/KZQ7jE0pJDsqGWFAOvwBEE+wJPdDwsQCxJiw/4yq8rC6sWt6zwarUcnNG
X-Gm-Gg: AYBFou1P8+s9uUsxZPnBPwkxf4yzPyQOkECGZD5JFPOX+UcWALMSR0MqZHqCcTKEvAo
 QDbywZ+5jjXQLH4fjhhllYQNpd5PPlccj/UmJcCXJB9yLrWxV3+1DYg+6C8+nFIzztF6Trrkl+b
 6xujo80F+vB+L1Z1fYUTX4a6c41iVIRgofqh2NpQ1cP2H3UBJDMdnUEXHnWBhvD6UfXcFeojNWS
 6klszZGGbS2RJsjMSQpjXo9yeHek3ZAuTMVXUiYUSfpGYTRxQZ+Q3LyCB5l31xrOV6/+5NkI+G0
 id1XLqHlQGowErhdGEePS3OMB12SHBwPLeFW8EvW7zB5Wfuz4cRVRsoXohUKEx4Xpv62NbHYIEa
 ehSx0IUv+8tKr3JoOb8MO6RlZd/lKlw/D1e0Fkvb834QRCFWMZf+CNSXccQgpyzvSkwHXQ1FQi8
 +rVzO8VMXOeQw4K/jQ3KQkdW6SCXlTmMBjIlpcERD8TthAzHyNl1JYpFnmsPBYcnL/GNccGNgm6
 5Ip6ZmlZdHd679EaDr47YAGs3mK+JVjVbnzzdN11Wqjgz4Ku052ZyKv8niPjMHauiiIqNRnrHL4
 0hMXDJvvk9iBMv5k06qFZoKjnYoSCA3zh7NZAyz2kq/MMqyUZyLh8FgrhZSXoEfWt9ycLeS/mBM
 CSCfd7hzIfN9O7qusBmmSK6Wyzyahwg5hBq0yyltoulVi1WZbWYXwlhDa8RyymP3VIuFeBnYPkj
 Cfj8hQjDNgX/DT812F4OSCJSXHgXa86ASOMVE=
X-Received: by 2002:a05:6000:22c3:b0:48e:61c9:4e32 with SMTP id
 ffacd0b85a97d-48e6e505515mr18349502f8f.32.1793580391510; 
 Sun, 01 Nov 2026 16:46:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78a6bsm16494908f8f.27.2026.11.01.16.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 16:46:31 -0800 (PST)
X-Google-Original-From: "Hansaem Wi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 00:46:30 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52
X-Gerrit-Change-Number: 2076
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2076?usp=email>
X-Gerrit-Commit: b9f4c1f5236329ee63284a2b85ebba5baf2095e1
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 00:46:30 +0000
In-Reply-To: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
References: <gerrit.1793496756000.Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNDk2NzU2MDAwLkliNWViMjRiMTU2YWNiNWE5OWM2MTQwNTBmYjFiZDY0ZmU0NmQ4YjUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bfa1599fee0fb58f559407153cdcedf4fba7f1bd-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xNgC6-0000000078q-19lb
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth_token: Wipe
 the server secret key after loading it
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Hansaem Wi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: hansaemw@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, gert@greenie.muc.de
Cc: "Hansaem Wi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1768905475509292620=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1768905475509292620==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QPZVF3XKjFI="; charset=UTF-8

--QPZVF3XKjFI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, Steffan K=
arger=2E

Hansaem Wi has posted comments on this change by Hansaem Wi=2E ( =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail )

Change subje=
ct: auth_token: Wipe the server secret key after loading it
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

=
File src/openvpn/auth_token=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2076/comment/613b8e50_88b46a66?usp=3Demail :
PS1, Line 176:     buf_clear=
(&server_secret_key);
> @hansaemw@gmail=2Ecom oh indeed, sorry for not look=
ing more closely=2E [=E2=80=A6]
Done in patch set 2, thanks=2E

The same st=
ruct key_parameters copy is left on the stack in init_key_ctx_bi() (data ch=
annel keys when epoch keys are not used, tls-auth, tls-crypt and static key=
s) and in tls_crypt_v2_init_server_key()=2E crypto_epoch=2Ec already clears=
 its copies, so I wiped those two in https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2078=2E Scanning the stack right after init_key_ctx_bi() in test_crypt=
o found the cipher and HMAC keys twice each before that change and not afte=
r it=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
76?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib5eb24b1=
56acb5a99c614050fb1bd64fe46d8b52
Gerrit-Change-Number: 2076
Gerrit-PatchSet=
: 1
Gerrit-Owner: Hansaem Wi <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@gre=
enie=2Emuc=2Ede>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: Steffan Karger <steffan@karger=2Eme>
Gerrit-Attention: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2E=
muc=2Ede>
Gerrit-Comment-Date: Mon, 02 Nov 2026 00:46:30 +0000
Gerrit-HasCo=
mments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Hansaem Wi <hansaemw=
@gmail=2Ecom>
Comment-In-Reply-To: Steffan Karger <steffan@karger=2Eme>
Com=
ment-In-Reply-To: Gert Doering <gert@greenie=2Emuc=2Ede>

--QPZVF3XKjFI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, Steffan Karger=2E </p>
<p=
>Hansaem Wi has posted comments on this change by Hansaem Wi=2E</p><p><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2076?usp=3Demail">View Cha=
nge</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0;"><p>File src/openvpn/auth_token=2Ec:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2076/comment/613b8e50_88b46a66?usp=3Demail">Patch =
Set #1, Line 176:</a> <code style=3D"font-family:monospace,monospace">    b=
uf_clear(&amp;server_secret_key);</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">@hansaemw@gmail=2Ec=
om oh indeed, sorry for not looking more closely=2E [=E2=80=A6]</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done in patch set 2, thanks=2E</p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">The same struct key_parameters cop=
y is left on the stack in init_key_ctx_bi() (data channel keys when epoch k=
eys are not used, tls-auth, tls-crypt and static keys) and in tls_crypt_v2_=
init_server_key()=2E crypto_epoch=2Ec already clears its copies, so I wiped=
 those two in https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2078=2E Scanning t=
he stack right after init_key_ctx_bi() in test_crypto found the cipher and =
HMAC keys twice each before that change and not after it=2E</p></li></ul></=
li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2076?usp=3Demail">change 2076</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2076?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>=

<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Id: Ib5eb24b156acb5a99c614050fb1bd64fe46d8b52 </=
div>
<div style=3D"display:none"> Gerrit-Change-Number: 2076 </div>
<div st=
yle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"=
> Gerrit-Owner: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Steffan=
 Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 0=
2 Nov 2026 00:46:30 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>=

<div style=3D"display:none"> Comment-In-Reply-To: Hansaem Wi &lt;hansaemw@=
gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: St=
effan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
=

</body></html>
--QPZVF3XKjFI=--


--===============1768905475509292620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1768905475509292620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1768905475509292620==--

