Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7361606A31B
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AYn0sQs/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=a0eJHQhn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=U1x44bgD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=H/CMeT/L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IEaJS1WIIyYlauo/HbjJ2oMq1YpW4sBFK35X1FkkzrM=; b=AYn0sQs/7QBiTFjYNLBvg9HviE
	D0LoPLRqWZOtMVtxBwHtvkwk/ABmP55GxgmDI2E1mZCI+Tcj5OFKIE7z77yiDJq7SA7Qh+amFA2wg
	24+QW6HafvkJ6YhRqSGP7DZG0D7OlMgva/N/CSBvYzGh0E5xEBMy9BHZppJNOYKgHuXI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLGo9-000000004Ub-3km2;
	Mon, 26 Oct 2026 09:15:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLGo8-000000004UG-0GIC
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 09:15:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P6X7TM7DUMmR8HyCjleUregVaA9Z8R2CKFvhMa8hLdo=; b=a0eJHQhnr0Q5Yq5hrARwT3hq/P
 hwrDWOchk0E92Y8+bL6OQFWfZnC0smgSyOGamNkPMkuvj0nrCIOLOgUU8b8hzuhTfrtPUOCO/0mHz
 QjSEsK9sPJ0o96pzMBYi+GQ2Ygy/zZz5wq0wcuovx8xyhrS4c/9960Uy2CR74QwtzFxk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P6X7TM7DUMmR8HyCjleUregVaA9Z8R2CKFvhMa8hLdo=; b=U1x44bgDSZ7UPL65FmPp5OxX56
 Pg/6euA+7y5AX4DWzZiIgbt9JndBXlUgC0/D1PHCQW81sxGcGIB6pku3gczJ/UXYQIpg+fFeJz2mC
 3SRLRWy+7LMABGVLrLXZY+28jOQJbPlgZLtbfBfCiJnuu+C7De+bapGYVGfFoL792Axs=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLGo5-000000002zf-1lXw for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 09:15:55 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so2385902f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 02:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793006147; x=1793610947; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P6X7TM7DUMmR8HyCjleUregVaA9Z8R2CKFvhMa8hLdo=;
 b=H/CMeT/L9loyxGH3cgxF8hJkZxy8fuDz2QEraXlRV3mVh+GC/5FjgdwOpruOml0DWS
 +iKSpddCE6H8Ki5MIx+xWMpSTwTgaga9S5yV2y/0pIp6B90iikJg8m9GnsrVZHWMcYe+
 kUauxThcrum7f98wDlsej0kK1WRLedwsBkXMssORbVA8egkbO+1xU1HyIoqEuQMad7n/
 OSS85CROQ00C+7lvU/Tak2uuuKM8FE4sOMi05qmMOQcToFx9z4TP9gpxLZGj+yN5irPW
 BbSjnh433pKKpqJR8R6LmAuU/57WCGwkCDwY9/0uVuUtini6VbMSYAPjLpUvhq9zZIHq
 L2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006147; x=1793610947;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=P6X7TM7DUMmR8HyCjleUregVaA9Z8R2CKFvhMa8hLdo=;
 b=rleYDqON2Dh0vb+7i9pYWhaVyg8J+OavXrSG7BoYlATCjZ/pZAPb3oUQztvSkXqY7p
 KswhOsz/nqQhT43+8mYNby281T/cJbz6kOAFDKSDZsJ7Yt12UkITjwVHHRDjZ2F0j9Y4
 vpE9LRl0ebh2D0ARL8x4vYuh+SuXxobQRYPuG4xeacojTqNVprMknYwtf8s45UDwsLtf
 OaNpXh27+oWFiJ+yUjroRmNK8DY1UC1NiUKq/bW9LGJdku/x9xWshLzji02CbHmApAZE
 WMZHUnKPpVG82dfaQZOVi+EMSkFMWecKem0Y3UxeBTPI+ooI8QaXU30aWTDAu/JBTecQ
 YwJg==
X-Forwarded-Encrypted: i=1;
 AKwUvByOTIrDmMf0u7+A+ZlJUtQ79ntbOvhRj4K3nBLylPF59eh6bgUeCA9nt76di92anc/R4BXfKvi0o9DVOe4L@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKTLUKlid4mwcKcg21XEh8yx81tjnGCd78roaH4yrjxY3zW72BC
 hyXTPC4Y2h4rupdU+Xh/3+GTNi7L/yGnAAvh7yYRky591Egx1Pyzpqgz88S9lt+LVXooluQVZeu
 WURsq8ZxzBmv5BLCnmy+gVhAtypu2MLoV2T+ll4Bk03eTHb4gLuITIRQjshr5ejbhqGmZ9BVLCb
 5aavehMA==
X-Gm-Gg: AYBFou0l5cBGf/JIfu/bQLZganwAtfIkwxrleV7XOdvNan/aJwZQL7QuaVzHQdKDxJJ
 iBVWsIpVuP5koaw5OF+7Nf636MGJq6ARPrSJNqKyufAIh1yHcjJGaXSN4ILiBiwjnnzqusIpVEZ
 fn4weRVj65ffCDtnzLugK42/gVynPqzbAsEaf5xj5ch5zM2k6b430VLAGDfe5RTTv2vhBMw2omK
 bRE3JPP2gM+qzjnq0Dp5aRn2jN906duu+d8xNfJjKLvfuU7Ulrt0GLA/0rtBKQUSAq7okZuyz8A
 dlSzGY8nUuavwco00hVK3RT3Jc8OfGQuIHq0aMOCaBmH+ok4hzwlAuNW0yo/i8gdPpPToVZWf6Q
 aPhZkijSIph+nZgrjp/SxU1Hvs4/rkzIWJx54GmYI016bDA/RvsjkSBRfot+OS3BN7bGdhzCcaK
 +1yD88R2Gs7UD9f5UTqf1Lt27V6qzfRRP67Adx/Lkm3bR2iHs01UlcEbylZgo/1Ht7rtrgOYEdz
 thy4pAtBBZyEkXMZ2/60NToiMMkIa3l0iO1SsFM7+5Ed4ks5sXYCsE4uJuc4XrvJkKdiXKp26S9
 kvJOobDAtLeLjXvfuXO5OwLvYKI8ZULSPc7Fey+v9C9H/eN2dwGWZvZ/35v05QBfw5oLmxwNKSK
 V/M9VqPLGd1OqkidX6cw6u0y8LqO/hSnJz3Xh/KlXHQ==
X-Received: by 2002:a05:6000:40dc:b0:48d:f014:63ee with SMTP id
 ffacd0b85a97d-48e3eb99fd6mr10799310f8f.20.1793006145792; 
 Mon, 26 Oct 2026 02:15:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e542ed998sm288696f8f.13.2026.10.26.02.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 02:15:45 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 09:15:43 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05
X-Gerrit-Change-Number: 1790
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1790?usp=email>
X-Gerrit-Commit: 505ff8017a30cf196bce82c1823f98d5614cc7c1
X-Gerrit-Comment-Date: Mon, 26 Oct 2026 09:15:43 +0000
In-Reply-To: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
References: <gerrit.1784150390000.I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTUwMzkwMDAwLkkwYmZmOGQwYTU0OWE2NWI3ZGEwMWVhMGU3ODViN2VjOGJlYTE3ZjA1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <068d095fe3e37aa720cd993a5c049d879c455b65-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xLGo5-000000002zf-1lXw
Subject: [Openvpn-devel] [L] Change in openvpn[master]: pool,
 multi: persist subnet pools via --ifconfig-pool-persist
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, antonio@mandelbit.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4297306635386339977=="
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,MXG_THREAD_INDEX_BAD,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4297306635386339977==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3YMQBn1z8Cs="; charset=UTF-8

--3YMQBn1z8Cs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Frank Lichtenheld=
=2E

Arne Schwabe has posted comments on this change by Antonio Quartulli=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail )

Change=
 subject: pool, multi: persist subnet pools via --ifconfig-pool-persist
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 7:

(=
1 comment)

File tests/unit_tests/openvpn/Makefile=2Eam:

https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1790/comment/ebd1eb99_e15dd47c?usp=3Demail :
PS7,=
 Line 20: 	pool_testdriver \
Does this really need its own testdriver or ad=
d we add the test_pool=2Ec as an extra compilation unit to something like t=
he some other test?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1790?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05
Gerrit-Change-Number: 1790
Ger=
rit-PatchSet: 7
Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <an=
tonio@mandelbit=2Ecom>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-Comment-Date: Mon, 26 Oct 2026 09:15:43 +0000
Gerrit-HasCo=
mments: Yes
Gerrit-Has-Labels: No

--3YMQBn1z8Cs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Frank Lichtenheld=2E </p>
<p>Arne =
Schwabe has posted comments on this change by Antonio Quartulli=2E</p><p><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/Makef=
ile=2Eam:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790/comment/ebd1eb99_e15dd47c?usp=
=3Demail">Patch Set #7, Line 20:</a> <code style=3D"font-family:monospace,m=
onospace">	pool_testdriver \</code></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Does this really need its own testd=
river or add we add the test_pool=2Ec as an extra compilation unit to somet=
hing like the some other test?</p></li></ul></li></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=3Demail">change=
 1790</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1790?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I0bff8d0a549a65b7da01ea0e785b7ec8bea17f05 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1790 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: Antonio Qu=
artulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Mon, 26 Oct 2026 09:15:43 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerr=
it-Has-Labels: No </div>

</body></html>
--3YMQBn1z8Cs=--


--===============4297306635386339977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4297306635386339977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4297306635386339977==--

