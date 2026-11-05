Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF1E606A326
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=kUzbR/aH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NGjGs1me;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G5HhZd1k;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Hvp4RIlc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DMML54aIOYeNgeG1nodi7e66i24+qSveKnrodKMgFKk=; b=kUzbR/aHSwQw0PQD5+zAmItQUY
	qrSXv6dc3CHHxHtvm9hcoe3LSD8WsXQpGt9Z3LEJNU8M9xnLfymW6NoMyzf4Kd00wNEMLa0LTbZBG
	myXSwCw6c8afs+kb4d9jGTzu1ES6fEnTZeuFSYPTmW1FZhjp2RMRXeALFFD2LX8vuwSs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOrxY-000000008UT-1jeo;
	Thu, 05 Nov 2026 07:32:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOrxX-000000008UE-1hFP
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 07:32:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HcXk+CFqpPlJst4vm+uVpP8ki060L/LPdm/AQlwPrSk=; b=NGjGs1me9iwGvGuTTENHDYspG6
 CX0ogfFtfYRIf8aeQVy56NFeyom+X25gme2Xt+DeNrdF4QRjX1R6ONpP1Ddo1Vspuyb29rbLr56xl
 LqC4k2d6/w8o9ojq8j8l9oPsGfyA5wBYjMQEgIAsoPAGnUqqyUPG6u/DtszHN9eB/HN4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HcXk+CFqpPlJst4vm+uVpP8ki060L/LPdm/AQlwPrSk=; b=G5HhZd1k4eopDQJrNpCYd7d1hl
 LMuEzQTt/ja5tEn5VtyqIpaZo6ZEjrlaLsYF7hnVNd1CbhPdnfHyG/Lx1Xq25Ppo6gWx/CAGwycxG
 31NncuLAs+cmPJunzVwPMtYCYEC3DrJHZvsarSRDr28PFvbw2lyQ6fy/HpTtuw2BjwwI=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOrxE-000000008DE-202o for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 07:32:16 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so12427015e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 23:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793863926; x=1794468726; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HcXk+CFqpPlJst4vm+uVpP8ki060L/LPdm/AQlwPrSk=;
 b=Hvp4RIlcZDnv3EiwpbG0d/Iy7N29fM6MEHKlbCstdjHyCCTiXC3u/JPMSKZXQ5YYRu
 QJ7tPR92V8qOj+qLSLVJGJrPshn3SAnpqqL3zqf4fCD9DpxKBLX9eYnMIQoTrh5OMF4j
 7U9CX6DLSezftPk3ydfWZ8lFiANgxtdbt+pL6ChF6NT9yYRS8os8SlTMeQ8L+dXBrKX5
 b5KZ0mPjRPzloCARB0dRltlhBmuGKx4tgVIYJiJQrcTeylkWpSwAXpEf7kXsnOmCFO+A
 r0fUZ+/ISHfmVFQ6lPTSn6tJSO28YNarhvdgzhwfSmNqCvVom4LtaO7IedkRxYN25JTx
 TPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793863926; x=1794468726;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HcXk+CFqpPlJst4vm+uVpP8ki060L/LPdm/AQlwPrSk=;
 b=mDQJOOa3jE+NnQLzdAywetTma2mIr3dQXDdzT4+FiROaRs030xzma7myLpD0mZaID+
 BowOwzRTRFWTMqUIswgTfxS/zqFvdn/DOiRjGnpwy9/e0W6t9zpoHcmcQSoBP/OkczAv
 S3qXwFmS8cwTrS+KQOCf1/gr7he0z0gvI3B0/nO0tHKWo+YI5zR2sptI9NceA8/ac5Uq
 9zrQ+7RsYrGUXsbxGIV88EYy8TiHlDytZdbeKnCSDHxi5GFTgrBqrEbwL9o/bDoeQYjl
 PF80fa/ZilihWaqKGgYi1UWrWbR5OJjNcIslqYVSj6/R9rhhIR0dkuD4apMZnU4SGEk6
 cwjQ==
X-Gm-Message-State: APuU4Z/TMYVNkilA4aZaW7AT+Fz2xorJjzzenT9HQlS4Qdui7O321RUG
 l2Y810OmLjbg5+/E3WKjzT4o26uSmncfsxQi4QyZvchvJF+a66WcdgMRjJ9Sg0qg27saCkqUPyT
 a5hP4gKoycgeS3sEQaY6y6uKMdiYRM3tU1P7WOHQhVg6MaGO5n9bEm0Ti9EBGJ0b9lgXxpdQduc
 aK0a9MeQ==
X-Gm-Gg: AYBFou1i5QIuXh8/3TAlnovsvKOxTamWLq2YAD1LaSCXLPQplkXlfhAK9EG+ePRnC7p
 /G0BL2NvGILAlb2jl46QG1F278/0ASL76J/8Nlj51b1V4ryVYvY706YHpdGXJov2+F92lv7F6/8
 bPNKpm83U28rFbwBLvXHchNFK6VlyZdMQDdzMmDuMlWBz0tLvOhq0zBblpwMOyN/tnnfwI8T7zc
 g6AZUfUu6yhy/CWz/+JzzEuRopQTbL3RTwIS8pv6cnA2jFhfdUwX13We3rHDkJ7TXiwd+i3sCua
 POf10wqK9bWVKKQffaopU4YxaeOFoDE433bSMri/Kymb1EZXO2u47JdEHaF5BAAPrzTHyk3mF+h
 qUOSEFDTW1526UOugyYDsXk/ILTXjDtn7Eo3HA+5ek72mgqTXS3XrYG3AOmicaVbSqYthxYe2ot
 daqkP3IDsLetG5YoPoctw2wP8h0kJ2Yx+BUv0ucyoHqv8aEBVZKY1pxFkUMQU2oWAuj0z4lnEmV
 Vtw38YRlFbY5FEdG3uvd1WlLuPXS2HH2p9Y87czd516iuOFBIQ4U3qZkfXqd3cWkL1KaOjP0d/t
 AofiosePpoiakIC/f23aTiQOLOv7Z+gz1rGqOhewU+BZAiuEVgqY/koGcQ19TTMTfnAIJQMGRna
 0VsQiWC5TXd0EE66slEnmPQXfp+vRh2ac07hPr0gsUjCfdPvAJxqoLtOWeDG4Nnp9qRDfB3PNFG
 eAgfSHP34A+FvmVw==
X-Received: by 2002:a05:600c:4e90:b0:4a4:f48e:78fa with SMTP id
 5b1f17b1804b1-4ac175669e4mr393789075e9.12.1793863925712; 
 Wed, 04 Nov 2026 23:32:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4527fed5bsm149781295e9.3.2026.11.04.23.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 23:32:05 -0800 (PST)
X-Google-Original-From: "Ralf Lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 07:32:03 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
X-Gerrit-Change-Number: 1860
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1860?usp=email>
X-Gerrit-Commit: 2eab5e0e8841fc61017933bfe62d7386c7f3de94
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 07:32:03 +0000
In-Reply-To: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
References: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzQ1NDE2MDAwLkllMjAyODk3MzdkNTAyYTI1ZWVkYzYwNjc3ZDNjMzUwZGRjM2IzYzIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <09f8e405a1f833b91fa7b18239eeaff091246bb2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOrxE-000000008DE-202o
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate using the dpc1 ACC protocol
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Ralf Lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Ralf Lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4081647908175318491=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4081647908175318491==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2ZSaAVoa818="; charset=UTF-8

--2ZSaAVoa818=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Ralf Lici has posted=
 comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1860?usp=3Demail )

Change subject: Add python scripts that d=
emonstrate using the dpc1 ACC protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 7:

(1 comment)

Patchset:

PS7: 
http=
s://sashiko=2Edev/#/patchset/fe5214e4b0c74321f906d962fed3264091f1f2fa-Email=
ReplacePatchSet-HTML@gerrit=2Eopenvpn=2Enet?part=3D1



-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c=
22
Gerrit-Change-Number: 1860
Gerrit-PatchSet: 7
Gerrit-Owner: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not set #1000061
Gerr=
it-CC: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 05 Nov 2026 07:32:03 +0000
Gerri=
t-HasComments: Yes
Gerrit-Has-Labels: No

--2ZSaAVoa818=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Ralf Lici has posted comments=
 on this change by Arne Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1860?usp=3Demail">View Change</a></p><p>1 comment:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?tab=3Dcomments&amp;us=
p=3Demail">Patch Set #7:</a> </p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">https://sashiko=2Edev/#/patchset/fe5214e4=
b0c74321f906d962fed3264091f1f2fa-EmailReplacePatchSet-HTML@gerrit=2Eopenvpn=
=2Enet?part=3D1</p></li></ul></li></ul><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">change 1860</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie20289737d50=
2a25eedc60677d3c350ddc3b3c22 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1860 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Name of =
user not set #1000061 </div>
<div style=3D"display:none"> Gerrit-CC: Ralf L=
ici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date:=
 Thu, 05 Nov 2026 07:32:03 +0000 </div>
<div style=3D"display:none"> Gerrit=
-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No=
 </div>

</body></html>
--2ZSaAVoa818=--


--===============4081647908175318491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4081647908175318491==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4081647908175318491==--

