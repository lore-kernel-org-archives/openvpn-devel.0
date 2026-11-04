Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD51606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AD+WWgXj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ljcQFIal;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Hxh4DqLm;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=LoagwbFK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2hW1ulANCxj5pRj5819tJwzDmQ0xYekoVACIeNqq0Uw=; b=AD+WWgXjWIZ9v6wW5VLluwemDK
	LXYfSsnVARILvhNhAFlK+btau89PpXg9Ec/EhO7N/Kv8/ZlElxwsCs+8sstCH2pBi+VQZUKsugxJX
	ZL+uVX6Xsmuv95W2cOGWAcyiLnoa3ePUfRtT9QbAla/Cup1hWJgChqiYXtYYaSKSHNBc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOXdB-000000006DG-0Zio;
	Wed, 04 Nov 2026 09:50:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOXd9-000000006D8-1kOs
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 09:50:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jOfjGzBrVWu47Z4UW+eF7ICeMucnwqSqv7LHelXyTHw=; b=ljcQFIalFfSmF8Bm54AG/e/fYW
 6oSq1xy1Xbn0hhe2aYjZEcN2ynmLoXqQl3A3K9JoJJopWwQyTm6EEOerF0Rq1Mmv3Kz8zPpeL7SF3
 dtgAt0Okod8jnMIQmTB3+4wsHJJdxH3q86PbYftWfb6T/f2RImZQS8d8vvR3VX8MQ/gk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jOfjGzBrVWu47Z4UW+eF7ICeMucnwqSqv7LHelXyTHw=; b=Hxh4DqLm+Zfrf54iDQ7+uV4JSW
 jSkthL/9h99G5n5qOkFpfjBAUUGz+1R7RJzVBnUb6YmiilpyPuRs/NtJLCpf0lsk9zHE7HwwDapEZ
 EUit4y+uXC1c0DxMSG6AjCLMyMALMCoiZ1ffIt47zNSg2/Wa4wKZUZM0Rghuj9/dIM+g=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOXd7-000000006sm-1jus for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 09:50:07 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so449921f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 01:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793785799; x=1794390599; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jOfjGzBrVWu47Z4UW+eF7ICeMucnwqSqv7LHelXyTHw=;
 b=LoagwbFKc65lKtlUs5nxvMKqErXLYFaTJzAz32rCc+RgzePVIHOSl51Oz0i4j1Or9y
 sm4aN9ktn+OxnJQyKnvl0e6SxtDg92JFLusAP5flxRMn+a/tMTJ7RARI7hqM9shJV4/r
 p6iPIeFB897kSSEoDb9pIKnA1zLIerY/2Y0Plc+v7SFQ4hemm4A5VLf330d62Y+ZOxeo
 HOFPHWxn6SyMYH0BqIyuNBlfarUsLY+YoGXDRLO3CwJX/6H935IdaJSqaoMIYAhb70kd
 weLjkCGKGcmJbqnHrbJnGdx7h1lodRHWZ7LnJuYPAMBpslJn4XVa0NTH+VfKYyBcdDWo
 YoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793785799; x=1794390599;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jOfjGzBrVWu47Z4UW+eF7ICeMucnwqSqv7LHelXyTHw=;
 b=hJvdiNsv9jqRgWDiV3yUyhs8rrYQncVFrW9ufuZlPUOnLCrF0g3OmERYFSAXBwpFAS
 NbIuVmL9rc+7HyEKzKJ5kcMJNZ7VJMDMGPVjwC26HA1Db110deKkGRXf9pVq7SYYjMyw
 tBCJ2kjK+5BAvC/ZXhhSf+qBr4hIaxi2Gag7Tie5cpdb8JF2XcLaD6oVPwhjMQJ0WOB9
 fCMLD2ndo68WuE/+9lpPmZeeOUNGqnUvRDhN0sMKh4GUUvhZ7Bl/JVZBvblMMM+aZokT
 6uEMT94h0DB29smlB6f4QViZPqK8V0psom2R2e12r2ubVoqoG3k0eb7A9Qr3ziHCWncv
 yccA==
X-Gm-Message-State: APuU4Z+H1Hj7B/WEsXl9ykpOsmBrrcWX/djKySCsKIisOu/Za6BjYzl9
 bzTEjI5NKBL7hmvNLQBnC52bAdiM76QoJ+vQYm30HVzHE7i7xnAS9+V3v6dPAUoej7U9AFR6ihb
 O8i6+9Z93yJ/XXA79AwhbS1lXI5liYRzENkwOTvykOscKI8MuwlfeGd6wDQ4LXUq2sR70
X-Gm-Gg: AYBFou1ER3tIIDNg/ntIfTrn5Yxx1c5mwnuRCgHGDaJDWyKP1iplY0C19tE1NcNVJvj
 eVLREZvnrHXDQRk70wMl6tRGPgh74YLjzbCMy+Y98fKt+QbgrUqg1JIfEFwEsLgogHEcyuW8YfY
 6nMEEIbjoyzdQY/32fvEunvMYtaea/XQ1eZdBjhb4vbm6FDyFC9wpqDHrtWgTQVFhWOZYsBnh2m
 sOo6LlZ38AXjG47348C2C0pQnYxQhTBRXdFelc/hHb9qtZajc0FeWlKFstdcuE2IYVDzqbdEkom
 5+xgnN1RguDR3XSfUWl6tU0nAOxAJTBKyU6BIz6V+f5ZadDrSale4J7q4ep/ITUVSUJrTdlsc2W
 eV+rOMYgzf0PwXXYwPMuKuDe/QXCIgTIYInSgIgnxVC3O99kHQBwYlHQnksU4ozjdt5cBG/14C+
 fxMg3ygBJNeAz9+kVPpQvxmKYUj0/Kc8fDd0SVnsKXwl0UHVdOmWPYB8zS8RYKzgb6xeF6CI76R
 9Uw4pD5o++o7tDazI1tLRfjxaE+BS4NbogJbu41AbxwkMBHiS21daL/CATgaWrg0JjaUFDeDqTr
 IN91PFlBhGL4QPFDQ9eAGHs10bMNgAt7bo7aY8o4kRXH4XdFirtSY14i3gFwGVJq8CySrYmrRX2
 NyyTljXsfv78KZaLWu+DmIKpSlrfMDFAyd7+wcHJ/mtJedLvIHsqk2asH7c2vThOKDI/Povj9zn
 KFuXuTCIVoD1Dhdw==
X-Received: by 2002:a05:6000:4383:b0:48b:f92:1f67 with SMTP id
 ffacd0b85a97d-48e6e30b9afmr31916838f8f.21.1793785798453; 
 Wed, 04 Nov 2026 01:49:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda203b6sm2770874f8f.48.2026.11.04.01.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 01:49:58 -0800 (PST)
X-Google-Original-From: "Name of user not set (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 09:49:56 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c73228a5
X-Gerrit-Change-Number: 1859
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1859?usp=email>
X-Gerrit-Commit: 5dd2d2b580e2e623384cc48c9afb28f83e1bfd92
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 09:49:56 +0000
In-Reply-To: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ib09bafabf612e9501ea757647c86a450c73228a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkliMDliYWZhYmY2MTJlOTUwMWVhNzU3NjQ3Yzg2YTQ1MGM3MzIyOGE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f7bb96244d2ce23fc5685b64b53890b87dd24b93-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOXd7-000000006sm-1jus
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Add python scripts
 that demonstrate using the mangement interface
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Name of user not set \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Name of user not set \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1472399117225135871=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1472399117225135871==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YDkRYMxQgkM="; charset=UTF-8

--YDkRYMxQgkM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Name of user not set=
 #1000061 has posted comments on this change by Arne Schwabe=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail )

Change subject: Add p=
ython scripts that demonstrate using the mangement interface
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 8:

(10 commen=
ts)

File sample/management/omi=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1859/comment/e49d5ac3_334177a3?usp=3Demail :
PS5, Line 109:     asyn=
c def _send_loop(self):
> It will still trigger a backtrace but also the wh=
ole program will stop working and that is somewhat  [=E2=80=A6]
Acknowledge=
d


File sample/management/omi=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1859/comment/db7868be_37f2abfa?usp=3Demail :
PS8, Line 105:          =
   logger=2Ewarn(f'Connection lost ({exc})=2E Shutting down=2E')
warn is de=
precated, use warning


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/com=
ment/4cc351c3_8c9f0627?usp=3Demail :
PS8, Line 211:             self=2Erecv=
Buffer =3D self=2ErecvBuffer[len(OMI_PASSWORD_PROMPT) + 1:]
snake_case inst=
ead of camelCase


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/=
94a9e184_80aa8788?usp=3Demail :
PS8, Line 308:     def log_message(self, ti=
me, level, message):
misssing typing


File sample/management/omi_client_pr=
otocol=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/c15e0=
009_d75bfc9f?usp=3Demail :
PS8, Line 38:     def __init__(self, finish_futu=
re, connect_data):
Missing typing


File sample/management/omi_server_demo=
=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/7492ebe7_1c=
9b6b8c?usp=3Demail :
PS8, Line 88: class ServerDemoConnectedClient(Connecte=
dClient):
@dataclass is missing here=2E The parent being a dataclass is not=
 enough, since subclass fields are only processed when the subclass is deco=
rated too, so env is a dataclasses=2EField object until it is assigned


ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/638f27c2_9411a7ec?usp=
=3Demail :
PS8, Line 189:                                          "NOTIFY:=
Please wait for 23s to let the server think if it want to admit you")
NOTIF=
Y:: ? Currently the text is in the flags placeholder=2E=2E ?


File sample/=
management/omi_server_protocol=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1859/comment/55810b23_7fc77701?usp=3Demail :
PS5, Line 116:          =
   logger=2Einfo(f"Client event {event} not handled=2E (message: {args!r})"=
)
> I think this should probably handle all event type and dispatch them so=
 we should not really see thi [=E2=80=A6]
Acknowledged


File sample/manage=
ment/omi_server_protocol=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1859/comment/51463e88_fddb73c4?usp=3Demail :
PS8, Line 143:             cli=
ent=2E_partial_acc_msg +=3D msg=2Edecode()
Each fragment is decoded as UTF-=
8 separately, but messages are split at byte boundaries, so a multi-byte ch=
aracter crossing a fragment boundary makes decode() fail and the whole mess=
age gets lost=2E Am I right?


File sample/management/omi_tools=2Epy:

http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/c568aa4d_1564c4c2?usp=
=3Demail :
PS8, Line 39: def openvpn_escape(text):
missing typing



-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib09bafabf612e9501ea757647=
c86a450c73228a5
Gerrit-Change-Number: 1859
Gerrit-PatchSet: 8
Gerrit-Owner:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not set =
#1000061
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment=
-Date: Wed, 04 Nov 2026 09:49:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-L=
abels: No
Comment-In-Reply-To: Name of user not set #1000061
Comment-In-Rep=
ly-To: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--YDkRYMxQgkM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Name of user not set #1000061=
 has posted comments on this change by Arne Schwabe=2E</p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859?usp=3Demail">View Change</a></=
p><p>10 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File sample/management/omi=2Epy:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1859/comment/e49d5ac3_334177a3?usp=3Demail">Patch Set #5=
, Line 109:</a> <code style=3D"font-family:monospace,monospace">    async d=
ef _send_loop(self):</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">It will still trigger a backtrac=
e but also the whole program will stop working and that is somewhat  [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Acknowledged</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File sample/management/omi=2Epy:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1859/comment/db7868be_37f2abfa?usp=3Demail">Patch Set #8, Line 105=
:</a> <code style=3D"font-family:monospace,monospace">            logger=2E=
warn(f&#39;Connection lost ({exc})=2E Shutting down=2E&#39;)</code></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">war=
n is deprecated, use warning</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1859/comment/4cc351c3_8c9f0627?usp=3Demail">Patch Set #=
8, Line 211:</a> <code style=3D"font-family:monospace,monospace">          =
  self=2ErecvBuffer =3D self=2ErecvBuffer[len(OMI_PASSWORD_PROMPT) + 1:]</c=
ode></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">snake_case instead of camelCase</p></li><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/94a9e184_80aa8788?usp=3Demail"=
>Patch Set #8, Line 308:</a> <code style=3D"font-family:monospace,monospace=
">    def log_message(self, time, level, message):</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">misssing typi=
ng</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sample/ma=
nagement/omi_client_protocol=2Epy:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comme=
nt/c15e0009_d75bfc9f?usp=3Demail">Patch Set #8, Line 38:</a> <code style=3D=
"font-family:monospace,monospace">    def __init__(self, finish_future, con=
nect_data):</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">Missing typing</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File sample/management/omi_server_demo=2Epy:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1859/comment/7492ebe7_1c9b6b8c?usp=3Demail">Patch Set =
#8, Line 88:</a> <code style=3D"font-family:monospace,monospace">class Serv=
erDemoConnectedClient(ConnectedClient):</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">@dataclass is missing he=
re=2E The parent being a dataclass is not enough, since subclass fields are=
 only processed when the subclass is decorated too, so env is a dataclasses=
=2EField object until it is assigned</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/638f27c2_9411a7ec?usp=3Demail">Pa=
tch Set #8, Line 189:</a> <code style=3D"font-family:monospace,monospace"> =
                                        &quot;NOTIFY:Please wait for 23s to=
 let the server think if it want to admit you&quot;)</code></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">NOTIFY:: ? =
Currently the text is in the flags placeholder=2E=2E ?</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File sample/management/omi_server_pro=
tocol=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/55810b23_7fc77701?us=
p=3Demail">Patch Set #5, Line 116:</a> <code style=3D"font-family:monospace=
,monospace">            logger=2Einfo(f&quot;Client event {event} not handl=
ed=2E (message: {args!r})&quot;)</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I think this should =
probably handle all event type and dispatch them so we should not really se=
e thi [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File sample/management/omi_server_protocol=
=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/51463e88_fddb73c4?usp=3De=
mail">Patch Set #8, Line 143:</a> <code style=3D"font-family:monospace,mono=
space">            client=2E_partial_acc_msg +=3D msg=2Edecode()</code></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Each fragment is decoded as UTF-8 separately, but messages are split at by=
te boundaries, so a multi-byte character crossing a fragment boundary makes=
 decode() fail and the whole message gets lost=2E Am I right?</p></li></ul>=
</li><li style=3D"margin: 0; padding: 0;"><p>File sample/management/omi_too=
ls=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1859/comment/c568aa4d_1564c4c2?usp=
=3Demail">Patch Set #8, Line 39:</a> <code style=3D"font-family:monospace,m=
onospace">def openvpn_escape(text):</code></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">missing typing</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1859?usp=3Demail">change 1859</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1859?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ib09bafabf612e9501ea757647c86a450c7322=
8a5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1859 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: Name of user not set #1000061 </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 09:49:56 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: Name of user not set #1000061 </div>
<div style=3D"d=
isplay:none"> Comment-In-Reply-To: Arne Schwabe &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>

</body></html>
--YDkRYMxQgkM=--


--===============1472399117225135871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1472399117225135871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1472399117225135871==--

