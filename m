Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24083606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eHa0+m6C;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mD5XOAyZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dnNSQoYi;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WRMTUTs6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MgwtJtWLWFMI4WEdZexw9tkWtJZAj02+F0LN4X0Esfw=; b=eHa0+m6CKOZWAUGrEprZMurd2+
	+cgAnX2cEuhGsQ8takgNDHYh/AQrhZ2nYmhBpD0pks1820N85gKnIXVrq2iSSfvBcTqLMLYwi5o08
	YXEIItb4k5RQuPPh5WrVsoWUzXNTFm5h/SjAyEsuDKAWrenkyQW1K8tcY2CvANm05pcU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNs7t-000000006I9-1oHG;
	Mon, 02 Nov 2026 13:31:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNs7s-000000006I3-3d3n
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:31:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vUELzMXhoRIfG6nqcMaVTQzFU8AXEK9IC9qRwZznUwI=; b=mD5XOAyZ4c6xRkVW/s8MnqPY3y
 IcqxnX2ngIm0FMLbiLcaYafmUnGXXrmZ7m+v++7lWOxMTWqib+h90ZW1BnJHd9QougFx4MRSQRYa5
 wfQRkbuhfmmvNEDf1pJJfD3GuJxVA3mmS5uzX4NgBZwlXjCYsGXb8q0TwyboFkyY9XpE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vUELzMXhoRIfG6nqcMaVTQzFU8AXEK9IC9qRwZznUwI=; b=dnNSQoYiqvYIvK59udFMlRB/8t
 IYxbkd3ktBggVwTiACY7yYQt96OxOD+C9fITlIexRoM+hzgfth7LUAbi5yxlzRP9a2P/iwdwDJgiz
 2dlYN76YnYaMVxnXnLsuB0eXd6HI/BAmSr9Ep4b8vzBzjWVtfrPNNXD0aJfoJgc9iEh4=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNs7s-0000000006D-02oe for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:31:04 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso1815825f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 05:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793626257; x=1794231057; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vUELzMXhoRIfG6nqcMaVTQzFU8AXEK9IC9qRwZznUwI=;
 b=WRMTUTs6G2I4U+N2G5PIyztSDNmWY6iqhM8FRT3/XzarchTCnTXh6do0oVwrQyr3Ge
 idHuaDCHJ+qLQCu8boLkyYq8bD6sEOKWu8P9Xzex0TyQxvdpBOIEIJV2QePg6NTYJIKi
 hlSbBOYFE0/lOXzGR+cDlu/GsTobuDuJTiwfM4V3FZkxAwEVIlCrNUf/KG5noy9TaIFh
 qpd7d75HwT9KB9Vx4dd/GtvluMdqwgjY1HwutcvCqWQd3zCZuDS97cSEsqZAbVauXKjd
 caElZuBDMft2495mOdWUpo7pJtq3sAHTFTxO1QNvdM85KzBDOux1tNWEkr4FQtWVBug3
 IyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793626257; x=1794231057;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vUELzMXhoRIfG6nqcMaVTQzFU8AXEK9IC9qRwZznUwI=;
 b=KujDH+rsQrrj3Y9CzCfo42jzkYr1gXKHJN5kPRSJVw+tx103UQOEtpXlfxJsEy/eJP
 PbfaIKQH58kNVGwQAV3UKvPogHS91Je32EyBqn/blxRx9jx87eA+U9kBng1ZsE+CXMPg
 E2EuiGfqYVdK45c+5vl9r9YFEDX+FAKpjy6qWdM4fL0nEjuP9ryPBtZGgpxZrhOlbrOu
 d4IkR9mi9vOiJD7/QyuaO5l+av84DEWGXOngCPksyyJpk8m/mBONy9Buv0+RNFU4Jn+t
 5XqVF4jRUmHOmXYNCfehfDL3LjcvYi4c9ZWWjCN1n+3Txkl3xL7+2l+W7iyJORUe47aO
 EuDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzm90G6qdUHuMBh4J0P8sIko1tK0xRqlQfiDkniPz2x90tIPyVdyhHDb3ntRs17oE0pZEOuSvmyXDbZOyqQ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/PAeh7UdumuiEZ+eqw4YLeX9FGEznKxaO2r2C3nNce/e0UWCt9
 teBGWxslT3gEc+JjA7SVdcmbcAImYO8ApM80KGzhR3VYpOC5qYd/yVGpB3sB3BZMu/V01fXzptM
 NXv8KceofGAnwah9c35aWgZ8x74pFcyoSj4K/DQzNwyseBGFS4k20/GadBDc+5Yna2j6/
X-Gm-Gg: AYBFou3jEcBMeSoZ0UjQaBwpGgk2kbiyJyPAIyOOfFgzrjFsWrSTSmjFq3QW8GxwY3+
 pdY49a7t/jut2ZB8eZp+H0k0aBBI5VtVhiihjk913AewjkUZjaTJ2eW0Xx2+A0rxI+XpUxBFfcs
 V3iC216QRE8bcrh2S/Ep34Wo0xN5KIJM0itP7imdmDMSH9iwL+907RJn85eS4w0Utg1mr+SEZ+B
 koKH4xw5v1vWbivSLU2Mmix3w2hZkF55bI6g4MwjxRpm657YItGj/XKpubMKhUbyoEiZNpOEzMq
 OrefDyuAHU8DOOgOHDXKjEwjgXhkO9SB0TRWrPmQKM8/quoDReeijz/P6dpx2GAxbrDWvr3w4Mp
 iX1C2KPp4JMrsHNYaYFi4pXvK8PGNlygbCIDfMzBzUd5D5bQm0zGdUf6v5h74ZBx9jcx87GngAb
 rTd1G+eNzD+WO9a62/c+Jtm+ZJvP19LiO+DMwbiLRf0u7v20HgbGZHV5z9eOT44QL3OlRDuoJMk
 6RGL+lJ+XBav8tp3ydDNnuU6+LoS+pVFUbCpg3+QoBRocIUwN3uJ4QHRNJtHpo9mbI8RZzXBoRw
 FfeEYEpNgNhQ4IFDDBCe3w/UlgjWdWksPCPHW5NP/NJNVwqVwEfPCm3G9uUIvomj1CtrYgFhcdl
 GTxn9aJ6361jqBzR3V4SC6LraOJlva/CV18ay/P0NvKs68o6cyB2yA5Z4gvcoFd/3WRT1ykiSZC
 JpCDZO59LkuQAWs78=
X-Received: by 2002:a05:6000:4559:b0:48e:6f76:dea2 with SMTP id
 ffacd0b85a97d-48e6f76f4b3mr14256482f8f.38.1793626257212; 
 Mon, 02 Nov 2026 05:30:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b81c74sm19634788f8f.36.2026.11.02.05.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 05:30:56 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 13:30:55 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
X-Gerrit-Change-Number: 2081
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2081?usp=email>
X-Gerrit-Commit: a2a2cc01358e3a525aeec49707cd02330e0a3924
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 13:30:55 +0000
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljYWRiZWU1MGEzYWY1NWYwZjIwNjlmNmQ2ZjFjY2M3NDYxODBmMzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aba05b8359e101238813f5750ef972020b094c16-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNs7s-0000000006D-02oe
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6739945510774355052=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6739945510774355052==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Op31VLiBU0k="; charset=UTF-8

--Op31VLiBU0k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail )

Change subj=
ect: Remove support for --secret
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review-1

(3 comments)

File Changes=
=2Emd:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/448628ea_ab=
ed7b74?usp=3Demail :
PS2, Line 32:  
Trailing whitespace shown in diff=2E

=

File src/openvpn/crypto=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
081/comment/281a98f6_9f29cbdf?usp=3Demail :
PS2, Line 1719:    {
This looks=
 like an accidental mis-indentation=2E


File src/openvpn/options=2Ec:

htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/800e53f0_74471d6a?usp=
=3Demail :
PS2, Line 1600:     if (!options->test_crypto)
With the early re=
turn, we never get here anymore=2E



-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2081?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
Gerrit-Change-N=
umber: 2081
Gerrit-PatchSet: 3
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 02 Nov 2026 13:30:55 +000=
0
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--Op31VLiBU0k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 3:<span style=3D"border-radius: 3px; display: inline-block; margin: 0=
 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">Vie=
w Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File Changes=2Emd:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2081/comment/448628ea_abed7b74?usp=3Demail">Patch Set #2=
, Line 32:</a> <code style=3D"font-family:monospace,monospace"> </code></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Trailing whitespace shown in diff=2E</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/crypto=2Ec:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2081/comment/281a98f6_9f29cbdf?usp=3Demail">Patch Set #2, Line 1719:</=
a> <code style=3D"font-family:monospace,monospace">   {</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This lo=
oks like an accidental mis-indentation=2E</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2081/comment/800e53f0_74471d6a?usp=3Demail">Patch Set #2, Line 16=
00:</a> <code style=3D"font-family:monospace,monospace">    if (!options-&g=
t;test_crypto)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">With the early return, we never get here anymore=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2081?usp=3Demail">change 2081</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Icadbee50a3af55f0f2069=
f6d6f1ccc746180f368 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2081 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 02 No=
v 2026 13:30:55 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComment=
s: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

<=
/body></html>
--Op31VLiBU0k=--


--===============6739945510774355052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6739945510774355052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6739945510774355052==--

