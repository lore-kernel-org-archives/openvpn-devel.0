Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3337D606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=T84Emy8n;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Fe8OlTsh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cT9pFoaL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WPCXZvOw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8g77OgLQBBDKmvybQ/Opj3PZpoGG+azl21X9bHuH+oQ=; b=T84Emy8nbZJ1YnRPO7FCfu0QWN
	ru3c6UJz6izJiBoGy+WqO/7TmBvbIs4n/1/c3gFJvMBgYFk9fZGZ+o0mu03QlX9cAEIrcRLbG0Lft
	syUrc6eHRWYVWYSK9GfHtlHZ5V4uORU9gYvkk8XeLYgqjEY/E+56BdQ0uupM/7MsYQI4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNoQD-000000002uC-0yvg;
	Mon, 02 Nov 2026 09:33:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNoPv-000000002tH-18vd
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:33:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JbC0nj1jcySl1WKKxraNbLZDcMwZ8wtgbMYUZ4gBElg=; b=Fe8OlTshbjQ+vMXEhr9EkiGbsY
 1PbI30oYBrWzJ/I25M1Yfox0ZgHMkhiLpAT4I+JHP/LgWWRHpjr0F+F21/tgXk9eSWT1VQWypjpq2
 owWD7mT8Hs2G8vPB6O6V8UqisImN4RMl+cOshjumNA6YfGFuy77UJ7m9Ra8nC+lSkUKo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JbC0nj1jcySl1WKKxraNbLZDcMwZ8wtgbMYUZ4gBElg=; b=cT9pFoaLUi1LJP5uA/Rkq5qmxZ
 eW6brQRs+v0txB9j+ikIthhH/4gH/h5HaQQddL0H5GSOQW8YDLXkHfVx3uopRJ28nSQHhtgQ/0bd7
 aJvRa95s3IGx7EQHwRnwNNRtFl9EhbVlxSFp1BRqOImNwp2i+LNZ3TxVvWo3CQI6ENok=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNoPo-000000002Ca-1ASJ for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 09:33:21 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so24985335e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 01:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793611994; x=1794216794; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JbC0nj1jcySl1WKKxraNbLZDcMwZ8wtgbMYUZ4gBElg=;
 b=WPCXZvOwyD5HzYMMHBzo2vUVcfM7BsIDpoqCXc/Y3MK6Vp4uWhpCTr3i8YOkDAFfUt
 4q2sWSvxxZHNTmqcSvFOSbZOSG0DWmS/hPzN+vtFoHs/ZvJF+u6KXgddXNHgOaC0Tn0v
 /1ymk6ut9cxDAsUxXHFW/Ev/KEkAif9SP4KBCPPLgrMH79tZ8ImZvgkYB6EqeUZzCnCe
 P7MVK+zzheuNBtfbOO0dLAM+c+7X2wFJgLrg9t0IZ+GgPTeQt6nShfoi3EQ/QCLdb82s
 GaTZcNlAh3Mekwh2w4pOqt2PXAzkvFDrOoMr8iaE8We7Bwst2BKvUSHu3h+LuRwP5ygx
 RivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793611994; x=1794216794;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JbC0nj1jcySl1WKKxraNbLZDcMwZ8wtgbMYUZ4gBElg=;
 b=kSezuFRqalAzeohX5ghLpJBc3+DIRw2baxNVb8PYnh6IlF58GCSbyVOeLYG7dti52P
 cndypTUNhl8w0a9SvhFxiXsFa064spXtMj5toL/V5pY4ZjMbFgfgiNLsMF4rQFzLPKcy
 MWBD2Cnt7m57IiV7z72vHgtUz3alb+jxyyMG61EOot+KKZVFZywbnwdvqtP7GX5vC+TL
 EQyAZ4/554yxyx/CN6msN/8hb/oPjrDd4XtHeqy6POUMn/7hQlpMVQsrJiRqDHNG2AFb
 sorMYw5F1TWJk70G9JzxdOjymwB0DxFnFOQIokHGEUaQCSdmXbI8igxtZ/34rop2hN64
 j+Yg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzc3cOA7wM99kSez1OsSXkHZjpOcweKi1T6tDcnbJA7fmlgGCPdu0B0vZaeUdKKjCiGGJOwI9qTuPpR0Os3@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKT0kpRflQDrmEHYcD7PBFa7D4YyKphNKIZHe0pBLhP8hB0G1dw
 4ijvxiAWUWB+s7ee6DmP+kvNxfvKwmrnAq+1z5gxnQIDU6ZI4xHtalR/+j5Iy/9qYYFxGUk+AqK
 QBsDHMWO+EXvD+/iIQ93106gSuJalyCmWexViVKXp1MqcVUXaB3EMfmYu8jdpdbZKm8bp
X-Gm-Gg: AYBFou1cE9VWOWvFheRpr8fOq+agbM03WjiJQ8g4NupimyEpCxaZYmt7CAPGGZ06lPx
 BfZ5giNcYvfgKiEZMRu3J0i8XRTuzy4tJ0KP4u7GyqP5coOosE75PMvKlleEdXQg38o32YMIdM7
 S/HDWR7yApJXno3rfswyI/HJeULIXRGBS1i3Uj9g/qfIxAWm1FCzTA8Lr92lcGO9TV6chkSUUoG
 Dfl1i3M5usnA5+5sDQo6KVb2fMQJDeBw//jFwiBbDSGWJhVZo8ouCGyBl+eDlHmM1emtSlIuLe8
 WOONjo7QXOgQqkL/OowxOVvb245GRynURPPLEhVhBblFHHr62KfltuUy0Llhisupl/7rSWA0Jce
 gNVA5aFwem+qX2aSvnP29rjmcU0ve6uEaovjOySzCzYrkaFAGZJcGwhNcQvIPBdHel0pOisezqy
 CXiPfntllh4T+/LBlk0VlA9heVEwSXhJW34X/pDhpLnnsf0K2w8CaTAhV5mpsJMkgb8Z822SzUU
 plXXCczDZM3MkcurQ0r99dwskBOQ+07JXmo35MG57CrwGISHmrAx4yW+AyNt+Rli/59wBR05UHv
 B2+qkLv9mkW4bo1MqD8qhRYGQKeHOhCjp2oNTpK/s4p9bM3q3I+p/EPbQWC9aPTNuFgAhFdXW+X
 Ur6gJ7z4dd5hyisjVvjGKrVtAXztiwmM0jM7TXdXO8Ob1ws0Fjzyqk7qT2Hl2puNFOWIai4HUmn
 jV/eyAhYbVLr/3+ymXH94nBwo3uYTMSDP9piE=
X-Received: by 2002:a05:600c:1d29:b0:4a5:5fb9:5d35 with SMTP id
 5b1f17b1804b1-4ac187a7678mr232004415e9.21.1793611993569; 
 Mon, 02 Nov 2026 01:33:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab61d8b9f4sm304389225e9.12.2026.11.02.01.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 01:33:13 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 09:33:10 +0000
To: Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie54c455006782662e3ed51e0db869ce403a66e74
X-Gerrit-Change-Number: 2011
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2011?usp=email>
X-Gerrit-Commit: d61099578ddede400f751b12eda1ccbb6d62beec
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 09:33:10 +0000
In-Reply-To: <gerrit.1792315181000.Ie54c455006782662e3ed51e0db869ce403a66e74@gerrit.openvpn.net>
References: <gerrit.1792315181000.Ie54c455006782662e3ed51e0db869ce403a66e74@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzE1MTgxMDAwLkllNTRjNDU1MDA2NzgyNjYyZTNlZDUxZTBkYjg2OWNlNDAzYTY2ZTc0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <93df6a0eba1d564584047df1030413a2f4069bb4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNoPo-000000002Ca-1ASJ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: sample-keys: add
 tls-crypt-v2 keys and revoked cert
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
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8581080123105587990=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8581080123105587990==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Uc0dtPn5QrA="; charset=UTF-8

--Uc0dtPn5QrA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Steffan Karger=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Steffan Karger=2E ( =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2011?usp=3Demail )

Change subje=
ct: sample-keys: add tls-crypt-v2 keys and revoked cert
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2011?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie54c455006782662e3=
ed51e0db869ce403a66e74
Gerrit-Change-Number: 2011
Gerrit-PatchSet: 1
Gerrit=
-Owner: Steffan Karger <steffan@karger=2Eme>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Steffan Karger <steffan@karger=2Eme>
Gerrit-Atten=
tion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 0=
2 Nov 2026 09:33:10 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--Uc0dtPn5QrA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Steffan Karger=2E </p>
<p>R=C4=83zvan C=
ojocaru has posted comments on this change by Steffan Karger=2E</p><p>Patch=
 set 1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 =
2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2011?usp=3Demail">View=
 Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2011?usp=3Dema=
il">change 2011</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2011?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Ie54c455006782662e3ed51e0db869ce403a66e74 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 2011 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Ste=
ffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Steffan Karger &lt;steffan@karger=2Eme&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comm=
ent-Date: Mon, 02 Nov 2026 09:33:10 +0000 </div>
<div style=3D"display:none=
"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: Yes </div>

</body></html>
--Uc0dtPn5QrA=--


--===============8581080123105587990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8581080123105587990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8581080123105587990==--

