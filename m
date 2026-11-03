Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80861606FAF0
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XdbquLyp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mvAWZz4l;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MuvIjWXb;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=clNU9tqP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oYOlJi0sse3wwvUa0VmDB3o0oleW6a6Y+WobPEzunyU=; b=XdbquLypkrI1XfET6ennOdkWUE
	rRSEzknkWagpTA5kUDE+72h+UT+luB2Ykwwg3DTJX1+LdGLdHQfi1xfcC4v77SjaPTiMSQ9Fy2tk0
	oO+IytFJmfehG30wLHPMVsxSeA+XHhfSPbpMpL4yASayPTNxGzjZJV/8EkIgVZDZUnWI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOCRd-000000003NE-380C;
	Tue, 03 Nov 2026 11:12:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOCRc-000000003N4-2fHS
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:12:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kPWUfr/NQhMtaljFvX2sRq8uDR4ymKExMgLJMMyOaTE=; b=mvAWZz4lPQLx7m5Vf3m4z7mFZ4
 JgwHDj5jOONMuNcbd5BAOpi8snC5ohEJzfwYdHCxxp/tCczc4XgF7IqDVoLWryPxwG+trqLCPcTFa
 wRx3I+vhXWI52/nikot4ni9PVSrzon1qiR32RzRVBPsYM5W1NSk0gmxJEcZV30FRUEzM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kPWUfr/NQhMtaljFvX2sRq8uDR4ymKExMgLJMMyOaTE=; b=MuvIjWXbUg2SPePbI2utAvl5LL
 JZa+o6n6G+G9SuRzQIjsxX4Xa/+EvDUsnT6DujTEbnal1/I0Zyx8Z4pRcSR3BLYBIBCKdRuY8qpML
 WQ+6EdwbNgjiAmWzfeG1jPwpWx0TXdesHpBXpJfs04XFjvcmS2RV8Nmg9gLmJgRntgQI=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOCRa-000000001qF-3W3O for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 11:12:48 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so40520695e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 03:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793704360; x=1794309160; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kPWUfr/NQhMtaljFvX2sRq8uDR4ymKExMgLJMMyOaTE=;
 b=clNU9tqP+ZU3xqXcSudCoIT684hfdtYoHpVAr/uuzOxkTklwWgNPFwioV8tACgCZzK
 0Bz6ramah8g+ngn4ZxlF5JupRHiO1dU/uZAI7TXIsCoJr5OnJEZ+U+FFj6FsBVH4hle1
 34bI11aeZkQmmOb+9ZRP9l2MO5jou0Q+KtB0fskllT7JkZoFUxYk5w9O5TskAvh+NVhD
 xoqjmGdi8Oex3YZ60HeI1J4sbLq1Gsjwr6R8M28IVv2SxxNf+Get6tpM+llSJ8UtmKXg
 Puw0mOh2kuOnXrNRbeufABq1mCcyUUL9oog2CYhX9gHSu/BAibMDryfLi5RoExxGKnmM
 F6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793704360; x=1794309160;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kPWUfr/NQhMtaljFvX2sRq8uDR4ymKExMgLJMMyOaTE=;
 b=M/FcdAbQxesL6yO+58t9V1f2Hoo/elY7xoCp3HR3VJORFOb+XVI91dkWuZmN4o2GeA
 PN9kM3dMHFED7MAMHlvTtDOmrxvxtR7EaYV+IfRVijN6lrMuuB/oojo5LQr95Dy8G1xB
 2+WyOjzrtIEa48gWzax+PR9vkd2okDCHARhGhAI80pImX8/+Ox+Qgee7GexVrD0ybiPK
 tcgUDXZbhAWaSmxWSGRtCNgFuMmvaaDzSwOwE9Qqk391fHE14dgmPcK08hpX9oyL98pM
 N6WmIcB2EncCwpR1QHcVs/0a57h/+O3v4ZcRZMWMs8BCBi2wAji0w9fVj7RGszEmClAW
 ntbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHbjXQk0u6vKktrW7nfp/TC9Wf7LqorhPjGIdhEitY0meQxET64GwrFeAnjZ5nIQQ9bLx/oUe3387qokYh@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9Ci8Jh4NNdOSixNqVGuXqVSqWWMIaaKylvc9DXQNriG0GotJMY
 yCvhyjyZJRP22oUB87RHsf4bLmd27OddVbdr+QfWRyLkMB9k8FTChc79X3kg0Bdb3uvd1pX2XQT
 +yBzRtO3GXRSGarGMYVL9SBfX24Zq4vIlNl+WetulYhkF5fyt0YeZf9n7CNwEZhHrsla7
X-Gm-Gg: AYBFou0iVxM6q0ApQyXv33DKptC8asdlE7bxEl52UfDAB4VkQV2QdPC2gGb1VCEbRyp
 pyfH395WWyvPF4fzIqncFWmCH76VK20obrlGwxQcbC38HeD3NME3EES8vUS7fxmcryz0aVYZZj3
 K2JSqfQQ4Dgz1lGJ/AXpCQ9fxYDvK7EBmQ+4hMiOUZZuBQKQT30t5idofHh0kGK1sW9RNXosUoD
 ZRqn7tdRsUNnMUz2rZsKGqwn9juKo76IjDmj5pOFPwCAEgIkZaINWy2yc6n1bUz1vAhHm9qYqVZ
 rf8BiKvisBw8xbjOT492UCz/AVtfcrtDBwjH9lyuDyShVhAd19CrwgEHW+Mr5LDG7lVxm9qrTMS
 AuE39baIi5f5ZRmg4cM4RIGGg1oz3Z0L7GxGlg96zGu2F/dEjT0zOrZu1lf265QK9kLvFlzfWUp
 eTB/7Zggczdwq1dQZ2DZ6CdYG6B3Z8xS08QfNfniHZt70atFjDy4RVrl3XlF+4XNOoG1JnqqTqw
 Tp3BEtL6TpfdnpmnajZYzdgMc+5KH92iJs5ntLUf0ZvqgA6gCpJZb3h1LX0kPkK7kIK1PJNjZhI
 7elaBM3CHbl9AgPidkrVAWujFq6VzgP113MVE2IrojVfR2TarAyGpdiG35/C6PHh6Q/gBNj5xeM
 EtjdP8gffqRUTCJjsRuEwZWtZfslvkOYKygJ63Y451UikkF5R9s01oKg98JBOyKCgC++59U2ygt
 2E8BX4p3lmwc9gGhz15sDLdGCCu9cToBqVfig=
X-Received: by 2002:a05:600c:4f0f:b0:4b3:ad9d:e21 with SMTP id
 5b1f17b1804b1-4b3ad9d0e48mr1279865e9.12.1793704360116; 
 Tue, 03 Nov 2026 03:12:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09cc3e9asm142212035e9.3.2026.11.03.03.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 03:12:39 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 11:12:37 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
X-Gerrit-Change-Number: 2081
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2081?usp=email>
X-Gerrit-Commit: 168d741a412fe24413fcf382db0800a6ab23c95a
X-Gerrit-Comment-Date: Tue, 3 Nov 2026 11:12:37 +0000
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljYWRiZWU1MGEzYWY1NWYwZjIwNjlmNmQ2ZjFjY2M3NDYxODBmMzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e89191b062df116c6f7d3b840166f68657d1ec6b-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOCRa-000000001qF-3W3O
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove support for
 --secret
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6559048767512852849=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6559048767512852849==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e2WTkHCke3s="; charset=UTF-8

--e2WTkHCke3s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail )

Change subj=
ect: Remove support for --secret
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 4:

(9 comments)

Patchset:

PS4: 
> Do we w=
ant to document --allow-deprecated-insecure-static-crypto as removed in uns=
upported-options=2E [=E2=80=A6]
I found only one in --config that is really=
 relevant=2E All the other ones are referring to other types of secret=2E T=
here is one reference to --test-crypto that the requirement to specific --s=
ecret has been dropped=2E


File Changes=2Emd:

https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2081/comment/b818ef07_fe1ef158?usp=3Demail :
PS2, Line 32: =
 
> Trailing whitespace shown in diff=2E
Done


File src/openvpn/crypto=2Ec=
:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/59b69b4e_518ae57=
0?usp=3Demail :
PS2, Line 1719:    {
> This looks like an accidental mis-in=
dentation=2E
Done


File src/openvpn/options=2Ec:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2081/comment/36213a18_84557d36?usp=3Demail :
PS2, Line 1=
600:     if (!options->test_crypto)
> With the early return, we never get h=
ere anymore=2E
Done


File src/openvpn/options=2Ec:

https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2081/comment/70b90f1a_085382ba?usp=3Demail :
PS4, Line=
 2016:     if (options->tls_server + options->tls_client + options->test_cr=
ypto !=3D 1)
> Since we know that `options->test_crypto` is always zero her=
e, we can drop it from the `if()`=2E
Done


https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2081/comment/87c4e0d1_b8674ec1?usp=3Demail :
PS4, Line 2038: 
>=
 This now ends up as double blank lines=2E
Done


File tests/unit_tests/ope=
nvpn/test_crypto=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comm=
ent/cfa0eed3_e2518ed5?usp=3Demail :
PS4, Line 344:     /* No crypto at all =
*/
> This is now the same test as "auth none, cipher none"=2E We might drop=
 one of them=2E
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comm=
ent/896ad5ac_938bad53?usp=3Demail :
PS4, Line 361:     /* secret, cipher AE=
S-128-CBC, auth none */
> Leftover comment?
Done


https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2081/comment/ce87c6fc_43383eb1?usp=3Demail :
PS4, Line 3=
92:     for (int i =3D 990; i <=3D 1010; i++)
> Should this loop go to 1015=
 as well?
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2081?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic=
adbee50a3af55f0f2069f6d6f1ccc746180f368
Gerrit-Change-Number: 2081
Gerrit-P=
atchSet: 4
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Tue, 03 Nov 2026 11:12:37 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>

--e2WTkHCke3s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">View Ch=
ange</a></p><p>9 comments:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2081?tab=3Dcomments&amp;usp=3Demail">Patch Set #4:</a> </p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
Do we want to document --allow-deprecated-insecure-static-crypto as removed=
 in unsupported-options=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">I found only one in=
 --config that is really relevant=2E All the other ones are referring to ot=
her types of secret=2E There is one reference to --test-crypto that the req=
uirement to specific --secret has been dropped=2E</p></li></ul></li><li sty=
le=3D"margin: 0; padding: 0;"><p>File Changes=2Emd:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p st=
yle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2081/comment/b818ef07_fe1ef158?usp=3Demail">Patch Set #2, Line 32:</=
a> <code style=3D"font-family:monospace,monospace"> </code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
Trailing whitespace shown in diff=2E</blockquote></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></l=
i><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/crypto=2Ec:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2081/comment/59b69b4e_518ae570?usp=3Demail">Patch=
 Set #2, Line 1719:</a> <code style=3D"font-family:monospace,monospace">   =
{</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">This looks like an accidental mis-indentation=2E</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;">=
<p>File src/openvpn/options=2Ec:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment=
/36213a18_84557d36?usp=3Demail">Patch Set #2, Line 1600:</a> <code style=3D=
"font-family:monospace,monospace">    if (!options-&gt;test_crypto)</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">With the early return, we never get here anymore=2E</blockqu=
ote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fil=
e src/openvpn/options=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/70b90=
f1a_085382ba?usp=3Demail">Patch Set #4, Line 2016:</a> <code style=3D"font-=
family:monospace,monospace">    if (options-&gt;tls_server + options-&gt;tl=
s_client + options-&gt;test_crypto !=3D 1)</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Since we=
 know that `options-&gt;test_crypto` is always zero here, we can drop it fr=
om the `if()`=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/87c4e0d1_b8674ec1?usp=3Demail">P=
atch Set #4, Line 2038:</a> <code style=3D"font-family:monospace,monospace"=
></code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">This now ends up as double blank lines=2E</blockquo=
te></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File=
 tests/unit_tests/openvpn/test_crypto=2Ec:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
81/comment/cfa0eed3_e2518ed5?usp=3Demail">Patch Set #4, Line 344:</a> <code=
 style=3D"font-family:monospace,monospace">    /* No crypto at all */</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">This is now the same test as &quot;auth none, cipher none&=
quot;=2E We might drop one of them=2E</blockquote></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/896ad5ac_93=
8bad53?usp=3Demail">Patch Set #4, Line 361:</a> <code style=3D"font-family:=
monospace,monospace">    /* secret, cipher AES-128-CBC, auth none */</code>=
</p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pa=
dding: 0 10px;">Leftover comment?</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/ce87c6fc_4338=
3eb1?usp=3Demail">Patch Set #4, Line 392:</a> <code style=3D"font-family:mo=
nospace,monospace">    for (int i =3D 990; i &lt;=3D 1010; i++)</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">Should this loop go to 1015 as well?</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2081?usp=3Demail">change 2081</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746=
180f368 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2081 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 03 Nov 2026 =
11:12:37 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>

</body></html>
--e2WTkHCke3s=--


--===============6559048767512852849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6559048767512852849==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6559048767512852849==--

