Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972BC606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bNYJD2dt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=D8hh+382;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UqncAGmQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Zbw1FB4w
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=E/ROlOm5ATfieHXWwdZ72c7/XNFKiewaTX8I8uJZASc=; b=bNYJD2dt0GtOMK6ODC+pp27EiS
	/4iW9RM5vyFLTkelH0igvz5C8RR17o11bHTflGO4aB9DpVvo+g4fOsQgDnbCWQEcIJORjqOwaDHF5
	aepvzhUt4B3g5iDvQFa486/4JLtmULXil01zeC7z9qWhFy8AECvRqgpcwBC8qwe+Nv9M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTI61-000000000qy-44pY;
	Tue, 17 Nov 2026 12:15:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTI60-000000000qf-1VMj
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 12:15:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k+EJWk1nmbl3tpBs+ro3bAq2E9x9Bcbemrffq1dgRl0=; b=D8hh+382ui0j4n+0/zaEDOvH6I
 GdQJpeewh6cb9GHdFOTxgdYpr+hvigSXhQ5j97No19fbGsNMBfTKcNeGwWmlO2A+HeZOjGc7uCE3D
 MBesT2qpENuwEI/HapMntmqSl66LLZoMZZU1ehBnkAL6sDwZBnKDGId8oPJW/iyWqoc0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k+EJWk1nmbl3tpBs+ro3bAq2E9x9Bcbemrffq1dgRl0=; b=UqncAGmQYYLIAK3VKtx9kDxP8O
 teCbPCQWd+aFSrS0+IN2wHNt/SGVMZqDix7Gi4uFPpSp6aw5fxGzK9MGsvd2H98tgxQrqt49Uwo1J
 y6GmeZSZC56LwiJZ3q9zdipcuFTLNLQsS9Jbfwve86daKOqDNa5zBsjoISxDFbXaJYo4=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTI5i-000000004hm-1bVF for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 12:15:16 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb6886d30aso20956005e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 04:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794917708; x=1795522508; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k+EJWk1nmbl3tpBs+ro3bAq2E9x9Bcbemrffq1dgRl0=;
 b=Zbw1FB4w6AB/LLDmzM/0dRV/6hd5tHmf4gHrJ7kwyTD6n+0Ns5augxLL5ai+gQPeCN
 n3es/ZbSQPI3KZGEHkk0IneV6IUquvAnphm8YZCuX3JtXTqeucMTADNJQk+7DYcy2x0h
 H0zlXojSBbdrJiKFsaiEizObDzfwcKzFio7OxrkkJZ276e2LIDxUzPwuNdk0kLwhh8My
 eIh1dSWTvDS6FQwo+N1GckuonSfgeORspQxAEoUWfsEHGavjSPv340oPmDAtMMnxlx8p
 uaFb1wtOF0YxBd9Kj4lZpuFIVi0sXU54X2IYdWYac48bAB7z+0MuJdcwjR5UVaRaI43l
 K0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794917708; x=1795522508;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=k+EJWk1nmbl3tpBs+ro3bAq2E9x9Bcbemrffq1dgRl0=;
 b=OtJhaqYpgDCtpq0E8Vkt9CcJI+GWdagdiwP+cWiY1p47C3sEp7d6tGGepsnSp/iT5B
 xkzJWU/eGRG5SgONZeg1JedtcyVUMDjv7deb45UPnvgRE94L4Bc9UHbSoKltQq3MSOXq
 8spwBHTHY3Mhl5B2rhBbKKNfEGYVbKqScXhQL4t/LcZ5Jud7I5wX8ZqQ3aW1WZTmTxEJ
 VA9GN+dStLZfZE67H9f+h9eovLy8WrP5xzHpVAbHjh4dwoWf5q9BhT9O9A7GVaOkXHvf
 KvVGYVVfSwpzxf/0+PqZ40resggh6KdRHYQiBLwfgnED0HLjkEe3kS6UMDikG4aAbh/C
 0bag==
X-Forwarded-Encrypted: i=1;
 AL+hErEEdU5R2ZolKEOx54M2Fur2stfZmKs1/WAm53h54ZfVShQYdFMlEb3F6b9is4fk1mte1GMuX2Cr5xKk4bMj@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8HX0fE3Y4upNzIxKJedNmnw7mB/d+55fGITWyCDd3D99NebDF6
 bb4GlOXjyIrzznk5nfP4le6TAN3eeV/Qvv0496LEzUiOKLQd/yQRbMT2xQnGkV7b6+aY/LrR4TW
 bsukNjR4XNFbE5MUgAbYsF7KIEA8qrdyXLhzAcYcLVvhvnJ+rYL9N1KlDJ1Sev2koGkUY
X-Gm-Gg: AYBFou2Kl7divtA5r9Rk0JM1O1cI5GbQ72KrarKGqwH3pBvT9dxldRU7Wu5WDTbMW9V
 Q13l3DqENrbLsDNZ5LNeoO9M5gZzi8iL93m7vLfsckxfr+nLTubv4cdkVYxeXZN5vqdQqPiGgB1
 mCdLfXv1CIde1XHzzz/Vu1hUvRiRISyr0MzkgS84Jgo8ctLpH6QWHn/LMZ/MTt2gP6h2cKnp/LZ
 5vpJPg7y2R09jA/tP+0n2DAw5GoMX7+9Wi3odT4uUwF0Woi+06FwqQN6pxwOsISKRaae1Fz87rq
 cAVL7OUuigDxzAduplkkkbDGxiGywTzjjmhRT20TnsgrfdjFSdYDhjLIcd/YFo7P609isuLL9k7
 Q7hRuUbAk5EWBUyC1dylC8ii8rsMRpnInyHUry8+wv4JfXxCZWfRZQwA/wDWYyMcQkXzXRl4RTe
 sBGv5jcymyiLn2eo2hm+v9GwE/sXwBCPmEVdmQKUAQnFoYiYXgIeBg5ZDyEbHKONk9EB/DxUjwf
 hqhc7ZiMBbdWveIq4OLbSMjZJJMCuNvsx4ktOY7wyR8ZakqDv6lMr4vabw+/Zc2DkG7YiL0Dw6Z
 pzYecGyrxRVcmNuerC7IEI39Y0/1zhbu2OEqfzz/oEgOzqsstuBDrdfCrhZOypn5k3bkwr7lJA9
 jSXimXI9v2BNkobTwIMC+NLq/MXIWB3NnAlaCT+FrHQ34Tm5oifh6KvIkFLDBlDXvKePLHoP+hJ
 s/BvrnbiP+bYXc3DoH
X-Received: by 2002:a05:600c:3551:b0:4bb:534b:ada4 with SMTP id
 5b1f17b1804b1-4bb55abdc18mr294150555e9.33.1794917707431; 
 Tue, 17 Nov 2026 04:15:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a3ad4ecb62sm3745884f8f.57.2026.11.17.04.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:15:07 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 12:15:05 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 3a1321674127756e760c096a18b7d8e0cc463112
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 12:15:05 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <674a98bf2603992ba08f37c7d89d9d3017bd01f7-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xTI5i-000000004hm-1bVF
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add
 P_CONTROL_V2 and the probe request and reply TLVs
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1010275185427490727=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1010275185427490727==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fcFs3+0juMk="; charset=UTF-8

--fcFs3+0juMk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Ralf=
 Lici, chugly=2E

Lev Stipakov has posted comments on this change by Lev St=
ipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail )

=
Change subject: control_msg: Add P_CONTROL_V2 and the probe request and rep=
ly TLVs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 26:

(2 comments)

File src/openvpn/Makefile=2Eam:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/224fc063_d1864bb8?usp=3Demail :
P=
S26, Line 123: 	pool=2Ec pool=2Eh 	probe=2Ec probe=2Eh \
> probe=2Ec probe=
=2Eh ended up on the pool=2Ec line with a tab in between=2E [=E2=80=A6]
Ind=
eed, fixed=2E


File tests/unit_tests/openvpn/test_probe=2Ec:

https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/fa0ebcef_232c4108?usp=3Demail :=

PS26, Line 342: test_find_tlv_skips_optional_after_wanted(void **state)
> =
Nothing tests the "unknown mandatory TLV rejects the message" rule by itsel=
f=2E [=E2=80=A6]
Agreed, test added=2E



-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Chan=
ge-Number: 1741
Gerrit-PatchSet: 26
Gerrit-Owner: Lev Stipakov <lstipakov@g=
mail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=
alf Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: chugly <charlie=2Evigue@op=
envpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: c=
hugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-Comment-Date: Tue, 17 Nov 2026 12:15:05 +0000
Gerrit-HasCo=
mments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: chugly <charlie=2Evi=
gue@openvpn=2Ecom>

--fcFs3+0juMk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Ralf Lici, chugly=2E=
 </p>
<p>Lev Stipakov has posted comments on this change by Lev Stipakov=2E=
</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Dema=
il">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/Makefile=
=2Eam:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/224fc063_d1864bb8?usp=3De=
mail">Patch Set #26, Line 123:</a> <code style=3D"font-family:monospace,mon=
ospace">	pool=2Ec pool=2Eh 	probe=2Ec probe=2Eh \</code></p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">pro=
be=2Ec probe=2Eh ended up on the pool=2Ec line with a tab in between=2E [=
=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Indeed, fixed=2E</p></li></ul></li><li style=3D=
"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_probe=2Ec:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/fa0ebcef_232c4108?usp=3Demail">Pa=
tch Set #26, Line 342:</a> <code style=3D"font-family:monospace,monospace">=
test_find_tlv_skips_optional_after_wanted(void **state)</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">Nothing tests the &quot;unknown mandatory TLV rejects the message&quot; =
rule by itself=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Agreed, test added=2E</p></l=
i></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1741?usp=3Demail">change 1741</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437=
388268 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1741 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 26 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Fr=
ank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: chugly &lt;charlie=2Evigue@openv=
pn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: chugly &lt;charlie=2Evigue@open=
vpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 17 Nov 2026 12:15:=
05 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>=

<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"di=
splay:none"> Comment-In-Reply-To: chugly &lt;charlie=2Evigue@openvpn=2Ecom&=
gt; </div>

</body></html>
--fcFs3+0juMk=--


--===============1010275185427490727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1010275185427490727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1010275185427490727==--

