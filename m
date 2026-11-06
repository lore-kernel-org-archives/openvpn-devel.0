Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67932606D806
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=A8frR7HO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=k2a/zh6p;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JJa3HOiQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=g7givibP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oKQ1pxHMNKmW/s99AOyfF4eA347gD4jJAYwvnRAM4XA=; b=A8frR7HOy/SlbbcXADJlvxL2oi
	+8U3Eixxp5DKIyBn/c2iZylf9E+LOUJl4CTCFW0Q4zXnyfCCtqIc9fuFYXJtxvSljIqrRurQMlGob
	ox0kSF97xNBDm2ckFX805Jz35Iyf8hLvX1gIqllAhi1AIDZ3wvOHtmA1t0EChw2edemQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPHvL-000000006cZ-3J51;
	Fri, 06 Nov 2026 11:15:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPHvK-000000006cL-1JM2
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:15:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vyomdhv5dQyX8C9YhR4/gZ4jcXNi3gtLgHTWqgf1Jfg=; b=k2a/zh6poo5GcQsDy0SeC8bXXf
 JFjWuAmYUYbX6uuq4WoKZGKl25wgAwUBIgrkHw/v6TBcALmZy7ET+ZmimfoZ7+tMyHpu9ZbSQj8KT
 +UomfvgfTIRja2rlXbGXPrR+b74slYm7JdaaQDBRTWE0SIvzf4DqqCiik5ojadMNDO3o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vyomdhv5dQyX8C9YhR4/gZ4jcXNi3gtLgHTWqgf1Jfg=; b=JJa3HOiQre0I2BU1T6GblWULkG
 0Wfm8+Mdlbcv1xziLKFBGd6uvALDlsNNhJKHo1LawpMvd5im20uQAp/yzkS9HbhADo5afvAZukwQX
 doCuVTD6WstzJ2WCvIqptde5P9YF0ZiA/BJ+3UcD3ooZ86LjKBZ90cAp2fNR443dP/Xw=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPHvJ-000000003fF-08Bz for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:15:58 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-490585eddfcso349663f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 03:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793963750; x=1794568550; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vyomdhv5dQyX8C9YhR4/gZ4jcXNi3gtLgHTWqgf1Jfg=;
 b=g7givibPKo6SrvB/+ZK7pPKDSgSEMpE9JRed3h17P4m+KumC4NaET72G6gLiNLTWyP
 jyKNnRnKK8iA3i77YoiUxYSaJk9OLjQZUk6pFnu/TBDKthqBT8rGg28UWglWtX05/ZMK
 NiLisCpACV7Y8xV/3pTDg0d55fh5Ez3Qj8H6acu/W0+xcrGLnsxTt4EcCm8r1IvoXYaj
 f5iu4GsVvI8YXqeRl35lhUl1j8hEMxXluC+A20IJxPHNCFbKkSiXLv2xVmfxk6TNIK2C
 QCaK9AV2GkLa6m4t90D/vugprovm+edKobidH/FLrjMoFiglWIs+F/uO/360pkp87tX8
 y4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793963750; x=1794568550;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vyomdhv5dQyX8C9YhR4/gZ4jcXNi3gtLgHTWqgf1Jfg=;
 b=JqzvY0dG4WGt2lFbU/FibhdV2I195biIlnqbX/ZxUdjY19L5iENBpg2Bv/MhI7GecN
 KrQ11/wWa32sLnjVaA95zI1ZZ4iWasnDfmSphJsbRqQNzhEuSYe1BzFLqUkLDxlzlNgj
 Dqx+32glLR70dZiJwhvlubhvinECBQZ0Y3k3qC47gVnU1SFwD5fqben0aQURHeArrjaF
 Nw/+XM3jdtJ7Z9XdfUfqY5T36q13DdJRHgg/9AuG4qnTWFkypzJhOxwPdbJqrOV/gVaL
 dUyEZaYJEOLRuMJDBWpJsu9GqTYpVGvHVsxmAJc+sNvC/3S17skmoiky+lL6auiZFljL
 bziw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1f4NRq/FAcSxJ5rQpQwRwPFoL0Kq30gZkGjJc7EhPuwMs0DoNyd6fCkEL6Z2ZjRHiQTQG3AKf9FFpARKH@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8q6frfRn4m6Kli/eZKWi8E0Y0haIlBsaQCPkPgasGgyScRV6pU
 wP6Wq2Fi8J5ElI9BDr9+ywogL+Wui5bCDgZdeGKvUaxsE6Gpmkh0SOuPfoQWPclzFsRzo/nhu/X
 XQ/SwsVXvG1X4cEgrxPKTPCK304tWWbvcK7U5RWDKw8W3ST1GiRNzpXzrhGkeTU9jOmaI+ShDa3
 sprMkiPA==
X-Gm-Gg: AYBFou31SrxZkHcBunkeJDukTdpfVa/htmtztvWnHBBWvf0BNfFr9u1K2j/ChPZsETr
 htrKfvNCKG/TZJ94jZUcPW+UJshC63NataSy0Bg8WwJjM/Z+oPTGhMEalCkxmyUnmgUb0PbpoPy
 1TtqHKTjK07/yKNdbFmT0s5Nq7SxpzgA24F9GBzXovh1uqtixLXc0ucVrCMKdQLpk2O4j6Amq30
 oLGHyWSNFvB4BXtw7A09M6kOUj1u9r00osERET0Mu1/S1YGnfcv7FdcemWfSnBoWAP1KPtRSlH4
 hPQKt9ivfICLabflUaf00JE6hEhGVURYX/w+DPCTxs3FCO2exxYJ/gqb+oJEvd0kZvDVzTLWVaj
 2kbGEmj58oJG/R7fnT8nBqEVQKMYrkoX25H3GvxiZLT2Bx979lxe2anlsmnUd9ggdhVcLUuZ3x0
 z9Mnw6VJPNYuesWvM8/FwE+AWEQe94effR/9MDvlQRajPhC6GVswCnldzB7TK/waIIPM1mdi3s0
 BPHUaNCTancEh0b03TusY7mlACNnftMLKC2WsGGcbqBHB5aac/4u8j2fJNriazQv+OeZIxcZNJl
 O+t4FrSQiUfDZwiaR3GtdHTcc76ItBmpX504B2oW/K/YicgAVGeQMFM1twb/Y9hvqNP1PDsRoWU
 2+mZmAbJrkS84EbCjvcMqWSVHWtbUiW44e3iWNMH4f3GGCSpt5FKyM3XWv8KBu/mTmcieqpTbuY
 UAMJNudw1foQvgwn4u1u382eNSX+kDd7Gu1dU=
X-Received: by 2002:a05:600c:4443:b0:4b6:b2cf:3088 with SMTP id
 5b1f17b1804b1-4b6ddcf59abmr37021455e9.14.1793963750144; 
 Fri, 06 Nov 2026 03:15:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e58fcc6sm240511315e9.2.2026.11.06.03.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 03:15:49 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 11:15:48 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
X-Gerrit-Change-Number: 1860
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1860?usp=email>
X-Gerrit-Commit: 6e50bb1d2c9a151a25a3ebdec30e88c37bd787f5
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 11:15:48 +0000
In-Reply-To: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
References: <gerrit.1787345416000.Ie20289737d502a25eedc60677d3c350ddc3b3c22@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzQ1NDE2MDAwLkllMjAyODk3MzdkNTAyYTI1ZWVkYzYwNjc3ZDNjMzUwZGRjM2IzYzIyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bd6b14d1885a5af894b57a1a4a8ee4ed38e49e2f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xPHvJ-000000003fF-08Bz
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0097661864122958096=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0097661864122958096==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="b1XATedfz3Y="; charset=UTF-8

--b1XATedfz3Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Name of user not set #1000061, Ralf L=
ici=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail )

Change sub=
ject: Add python scripts that demonstrate using the dpc1 ACC protocol
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 8:

(=
5 comments)

Patchset:

PS8: 
> Sorry, this is for the other patch (2037)=
=2E Got confused by the similar names=2E [=E2=80=A6]
Thanks I addressed all=
 that is in this report=2E Sashiko will probably report again since it does=
 not see this as patch series for the first comment and the second we don't=
 care about the condition that Sashiko cares about=2E


File sample/managem=
ent/acc_dpc1_client_demo=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1860/comment/bb3a1073_507679ea?usp=3Demail :
PS4, Line 86:                 =
"ver": "1=2E0",
> missing correlation_id and timestamp
They are not really =
needed by Connexa=2E It works fine without them=2E


File sample/management=
/acc_dpc1_server_demo=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/186=
0/comment/7105021e_bfc3552b?usp=3Demail :
PS4, Line 68:         dpc_respons=
e =3D msg["dpc_response"]
> Shouldn't we accept only response with the same=
 correlation_id as request?
I never understood why we need the correlation =
id in the first place=2E The correlation id is also not something that is u=
nique per message but rather all messages to a client have the same correla=
tion id since that apparently helps Connexa to track that in their backend =
architecture=2E

And if all messages to a client have the same id, I don't =
see the point in checking if the client echos it back correctly in this exa=
mple script=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/1c=
210a17_6f893651?usp=3Demail :
PS4, Line 123:         dpc_cmd =3D {"dpc_requ=
est": {"ver": "1=2E0", "correlation_id": "n/a", "timestamp": "yesterday", "=
client_info": True,
> timestamp shouldn't be real timestamp? correlation_id=
 shouldn't be real uuid?
I am sure if we have a fixed format for these or i=
f the format is actually correctly standardised accross the existing client=
s=2E


File sample/management/acc_dpc1_server_demo=2Epy:

https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1860/comment/10ab0d39_a0a3534d?usp=3Demail :
PS6,=
 Line 68:         print(f"Received DPC1 message: {acc_message!r}")
> should=
 be logger
Acknowledged



-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1860?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: Ie20289737d502a25eedc60677d3c350ddc3b3c22
Gerrit-Change-Number: 1860=

Gerrit-PatchSet: 8
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-CC: Name of user not set #1000061
Gerrit-CC: Ralf Lici <ralf@mandel=
bit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: Name of user not set #1000061
Gerrit-Attention: Ralf L=
ici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Fri, 06 Nov 2026 11:15:48 +=
0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Nam=
e of user not set #1000061
Comment-In-Reply-To: Ralf Lici <ralf@mandelbit=
=2Ecom>

--b1XATedfz3Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Name of user not set #1000061, Ralf Lici=2E </p>
<p>A=
rne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1860?tab=3Dcomments&amp;usp=3Demail">Patch Set #8:</a> </p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>Sorry, this is for the other patch (2037)=2E Got confused by the similar n=
ames=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Thanks I addressed all that is in this=
 report=2E Sashiko will probably report again since it does not see this as=
 patch series for the first comment and the second we don&#39;t care about =
the condition that Sashiko cares about=2E</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File sample/management/acc_dpc1_client_demo=2Epy:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/bb3a1073_507679ea?usp=3Demail">P=
atch Set #4, Line 86:</a> <code style=3D"font-family:monospace,monospace"> =
               &quot;ver&quot;: &quot;1=2E0&quot;,</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">mi=
ssing correlation_id and timestamp</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">They are not really nee=
ded by Connexa=2E It works fine without them=2E</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File sample/management/acc_dpc1_server_demo=
=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/7105021e_bfc3552b?usp=3De=
mail">Patch Set #4, Line 68:</a> <code style=3D"font-family:monospace,monos=
pace">        dpc_response =3D msg[&quot;dpc_response&quot;]</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">Shouldn&#39;t we accept only response with the same correlation_id =
as request?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">I never understood why we need the correlation=
 id in the first place=2E The correlation id is also not something that is =
unique per message but rather all messages to a client have the same correl=
ation id since that apparently helps Connexa to track that in their backend=
 architecture=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">And if all messages to a client have the same id, I do=
n&#39;t see the point in checking if the client echos it back correctly in =
this example script=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1860/comment/1c210a17_6f893651?usp=3Demail">Patch Set #4, Lin=
e 123:</a> <code style=3D"font-family:monospace,monospace">        dpc_cmd =
=3D {&quot;dpc_request&quot;: {&quot;ver&quot;: &quot;1=2E0&quot;, &quot;co=
rrelation_id&quot;: &quot;n/a&quot;, &quot;timestamp&quot;: &quot;yesterday=
&quot;, &quot;client_info&quot;: True,</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">timestamp shou=
ldn&#39;t be real timestamp? correlation_id shouldn&#39;t be real uuid?</bl=
ockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">I am sure if we have a fixed format for these or if the forma=
t is actually correctly standardised accross the existing clients=2E</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sample/management/=
acc_dpc1_server_demo=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860/comment/10ab0=
d39_a0a3534d?usp=3Demail">Patch Set #6, Line 68:</a> <code style=3D"font-fa=
mily:monospace,monospace">        print(f&quot;Received DPC1 message: {acc_=
message!r}&quot;)</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">should be logger</blockquote></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">A=
cknowledged</p></li></ul></li></ul><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail">change 1860</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1860?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie20289737d502a25=
eedc60677d3c350ddc3b3c22 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1860 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Name of user=
 not set #1000061 </div>
<div style=3D"display:none"> Gerrit-CC: Ralf Lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Name of user not set #1000061 </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;ralf@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri=
, 06 Nov 2026 11:15:48 +0000 </div>
<div style=3D"display:none"> Gerrit-Has=
Comments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </d=
iv>
<div style=3D"display:none"> Comment-In-Reply-To: Name of user not set =
#1000061 </div>
<div style=3D"display:none"> Comment-In-Reply-To: Ralf Lici=
 &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--b1XATedfz3Y=--


--===============0097661864122958096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0097661864122958096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0097661864122958096==--

