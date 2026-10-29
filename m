Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E5606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=UrbcPH8i;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UK3psbwY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hi7WvATg;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bZYrh+aN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iuKgwKDN8X53Un3j4gy+xi6A9E2/2ur95Un5K36sPQE=; b=UrbcPH8iK2oGQapqyiycruvotc
	m8uWN4vFUhaRuids57i4Si+nmgUIxza1/w64JT3v9tzAAgKBHO0ev5e1DUOwKQHN9VvblWXRDrxs0
	BaqG52l2/nMqyhRXX8CpCAGAzo9uO3Ty7+PJ4SWe4c8HaVTU5jNeJP4lNwMxrFoad/X8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMTmy-00000000296-1Hnm;
	Thu, 29 Oct 2026 17:19:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMTmx-00000000290-0uFE
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:19:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tc5y9rg8rychhYIy2Z+7TAq7cT5k3F6ZshGtFw8WqRE=; b=UK3psbwYZzXz9+4yPEf78o5hI6
 8jNCh5J/GtcLCXMX4K9yUXqegAYKu9Lodrgmz4FwNXUXoC1oXPztSvgCmZlW7MrrapmHa0ZyWgLpr
 yJ2cJ1jOF/Ft1wfCWaqkq7fthRXSVcQipF8x1890Qu1gHCB0LUSQLXNTd7YI9wgEQmrk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tc5y9rg8rychhYIy2Z+7TAq7cT5k3F6ZshGtFw8WqRE=; b=hi7WvATgUh9DI+SmK7P7Viczn2
 1b67guhQEMLCQmHWrudMk7OfZeG42GZQO2c0zZZhOU7ASBbpXpjDBL/TQL/qKBk+JKEvD7gBUC4Fk
 b9ZGe4PToxvmH3QjN7qwaFrK7ci7htkHhM9fETHppTx53qMckdQaqZ/5m/wPKSqd5a2c=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMTmv-000000000tK-2aSn for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:19:43 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e20edd106so1906765f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 10:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793294375; x=1793899175; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tc5y9rg8rychhYIy2Z+7TAq7cT5k3F6ZshGtFw8WqRE=;
 b=bZYrh+aNjKyfPUz4/+lRNW+cdmmmRowpS/ZUpkJPYu3G8B2i/GTUi1IPYyDoecZvkv
 a1OK1WGHemyuiKNCfr5EW5AymqqJiRz62vhTh7gc3R/PlHrZ7T/ngOK+hgU+nO3V3CIJ
 8r88xZ3rmmaGObGhwat+4Nk/WefLBAez0uz9DM1yH3uftAw0OoHuVlUIwrHqF9yHpgl7
 aU0iHHkxQMcT0A36WJK4cgXQO4hwyhnsKl1CyUb4N2TDFNvvrAEPl1Zdwm4dxsUXSpTi
 7AcAwHsJfQBSEjTCibQzEkHPjOjyOY4XNirQDoHF9sUj8j7NRGAgGpJrE4oBCsu9MUkO
 U5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294375; x=1793899175;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tc5y9rg8rychhYIy2Z+7TAq7cT5k3F6ZshGtFw8WqRE=;
 b=CsSokBmqME4E9hIZo4vXuP1ByRcskjM4o97UC/FRn9CR94lf3qPeSSynnpD+uRwq3G
 J+pCBYhg+WXN3g8XbWeCwMVfdtplerPnx3IrjK1Y6W1SQisc8YQhRldiLJFgDhWnVep2
 A1Pamgr74rAXZiC+ULOCn5NZAZv9qX36lKIt/7Rm86qJCWLsCiHwjBKhC0xQudGUfAJt
 1cc4V3CKpLCla+QxJwG4/TBsaS/KzhWsJNmDfNOSS3noLFJqFqqupM0JAEqOmjWB9cx8
 +Yw34ASo3tMA2I7Erh1IYSITxs/lRY2vxVlk790ycSBelQ9vgfkHomLcE979AizL2bGn
 MXkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxS2Uj0HdWokV4QSZC8/n5O9u8vCWPEGFLytHIstJpu5tlH/go4yKeDWJB6B8XkafwKOquipf3Vii03Zkk2@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIjM8b7SMxe6Lv9WVw/a6tWyWvxPlBRU3TUlwd5aYs3mrwoa9so
 zk//Vl26o8qhU1AAP9W9a3i5A2e8HyCaAXv90fiRbxXow28EowWbjuIDJLpueEdFjHt7XbrBG3Q
 vBh7ySxCGFf9DYYz2FC8ihHOv8fQ+KbnOQHXrFx7zO844FSfq8xXv9PZiIJ+Yeuge7RFyHmmYC5
 GWvmndGQ==
X-Gm-Gg: AYBFou3RJsp0fIfbp0YSC9G79Al7eVmyj7bIt0WNbljmYmbNooH2b98Cz+/BlCkg588
 t0t85bJzhUqvPLbjCkPL/PjBRJ/sqrbRObwsckfaHJ6ZLMWCCOmDw+UAKUTkNyupXiEd8/St4ti
 k6afEtqq08q8xbpg8c1TA4FfVBDZe5G9qi1QEiz8j+8l4N5awFb6i+I3OeWQNFepxa/c2jYgSaX
 3eeyFkHCqk0UjKS9/4/9dZ/APT7LFzHU5N6sCtS5Fnknb0BU+LL7QuUKH3Kpd6M88er2O3uq6xZ
 5fozvKHLkZ4pB/QGrGl0twK0bMfx8nCNUcWClP76ctWqc0Ssc6Uj06mSv00Fc/uijc90R1fBt5B
 w2usQRQdf2vbJqZM1E/HAlbkqQGhNZfu4hlJuxOpI1/mwOo+h2GLPTzKuDEY/bxbI2TCMhg/QNF
 UUL/SGqAxdoDrTX6r7runN+cVenXQ0BE1bdy8pef/CrSiJ0ManjKrxWjvgPiM2Ke+7xhrSCuVGo
 ps+FqIVFkfj2PQck4czzLzopf2/Y90YYqx6yP8fO5MZ5ADyCukz9TB+IbBe81PgcAlhztat9LR5
 1vJgiUN04RajQy828re+IvGIm0o9sUkEvLlw0DGHqRfvyJqRkK+pXpg/2tFa6RVo9IF2ujyrKHY
 JZ9y6+vvnu3LQYx3FtmBJAL+/RKP+qP2OSGm9FggL7vk99ANNWksEAX07MjjmJG1E1aL+NmnRRK
 x9HhcR5NC1gvoa6Lc=
X-Received: by 2002:a05:6000:2211:b0:48e:6419:ddf2 with SMTP id
 ffacd0b85a97d-48e6e2e76bcmr146812f8f.17.1793294374826; 
 Thu, 29 Oct 2026 10:19:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6dfa0d58sm435000f8f.33.2026.10.29.10.19.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:19:34 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 17:19:32 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If8ae9cbc971f60800a998abf2f97da0384c023f3
X-Gerrit-Change-Number: 2067
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2067?usp=email>
X-Gerrit-Commit: 8841b1dbf2dc7ca506222cbd8f8bb9266cc26a97
X-Gerrit-Comment-Date: Thu, 29 Oct 2026 17:19:32 +0000
In-Reply-To: <gerrit.1793206499000.If8ae9cbc971f60800a998abf2f97da0384c023f3@gerrit.openvpn.net>
References: <gerrit.1793206499000.If8ae9cbc971f60800a998abf2f97da0384c023f3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjA2NDk5MDAwLklmOGFlOWNiYzk3MWY2MDgwMGE5OThhYmYyZjk3ZGEwMzg0YzAyM2YzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aca1d38e891275399d1a3be30de39f1c370fa9f7-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xMTmv-000000000tK-2aSn
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Do not hash real
 addresses of TCP connection
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
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4943167685012424896=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4943167685012424896==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0F5lYtSSGZA="; charset=UTF-8

--0F5lYtSSGZA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Arne Schwabe=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2067?usp=3Demail )

Change subject: Do not hash re=
al addresses of TCP connection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1:

(3 comments)

Patchset:

PS1: 
> `manage=
ment_check_bytecount_server()` and the `PACKET_TRUNCATION_CHECK` status blo=
ck still use `{mul [=E2=80=A6]
I overlooked management_check_bytecount_serv=
er=2E I addresses that in a new version of 2065=2E For PACKET_TRUNCATION_CH=
ECK I think that code does not have a good purpose anymore and added a patc=
h to remove it to the patch set


Commit Message:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2067/comment/f51ff1a6_61a056fb?usp=3Demail :
PS1, Line 9=
: With neither status report nor max-client depending on TCP
> max-clients
=
Done


File src/openvpn/multi=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2067/comment/d3923fa9_4a004533?usp=3Demail :
PS1, Line 2485:  */
> Shou=
ld this comment be changed to say that this now only applies to UDP?
Acknow=
ledged



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/206=
7?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If8ae9cbc9=
71f60800a998abf2f97da0384c023f3
Gerrit-Change-Number: 2067
Gerrit-PatchSet:=
 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Thu, 29 Oct 2026 17:19:32 +0=
000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--0F5lYtSSGZA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>Arne Schwabe has post=
ed comments on this change by Arne Schwabe=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2067?usp=3Demail">View Change</a></p><p>3 co=
mments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067?tab=3Dcomm=
ents&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">`management_check_b=
ytecount_server()` and the `PACKET_TRUNCATION_CHECK` status block still use=
 `{mul [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">I overlooked management_check_bytecount=
_server=2E I addresses that in a new version of 2065=2E For PACKET_TRUNCATI=
ON_CHECK I think that code does not have a good purpose anymore and added a=
 patch to remove it to the patch set</p></li></ul></li><li style=3D"margin:=
 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067/comm=
ent/f51ff1a6_61a056fb?usp=3Demail">Patch Set #1, Line 9:</a> <code style=3D=
"font-family:monospace,monospace">With neither status report nor max-client=
 depending on TCP</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">max-clients</blockquote></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/m=
ulti=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2067/comment/d3923fa9_4a004533?usp=
=3Demail">Patch Set #1, Line 2485:</a> <code style=3D"font-family:monospace=
,monospace"> */</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">Should this comment be changed to say=
 that this now only applies to UDP?</blockquote></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2067?usp=3Demail">change 2067</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2067?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn =
</div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: If8ae9cbc971f60800a998abf2f97da0384c02=
3f3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2067 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, =
29 Oct 2026 17:19:32 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCo=
mments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div=
>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--0F5lYtSSGZA=--


--===============4943167685012424896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4943167685012424896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4943167685012424896==--

