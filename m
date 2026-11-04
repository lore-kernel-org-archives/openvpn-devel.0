Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19F3606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=c7osUrPV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AEWBoToG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mBVK/F2f;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MTcqDDk3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7vpKnLpbeasQ2n+eOyfBwat1w0AUkvknU1kSqiD13Qo=; b=c7osUrPV7/lIbDCNb6RxVQZybu
	d9FHsz5cnbWuvJJp1CmguEIiTmHPPcPUcBqtsXwoNvW3pGFmmXNMWYBaI8MeMwfRynk0DjmoaTXCm
	g1YcSgg58yNyr/U5DDIoR1Vbqfi/HQr7PuS2dXBKWQc8MDuw9VL72u4/O79QGlkLnTpo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOXtb-000000006kr-2jgE;
	Wed, 04 Nov 2026 10:07:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOXta-000000006kk-0Ixl
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:07:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U0LWHSL3mTuVhefdcKRliqJ5gp6b7LFS4HIKDMbRUxI=; b=AEWBoToGxZzXrb+HwS4jtkDMJm
 QEOhYSfRnlcUaPMj8S2KkiaTxXu5EyIJ0+fQbk7H/LLNk927OwvXHDkTMRcTp8fhp419sOONmIxLA
 dulQ9BQ+TwSzUN8c5K7aaix4xMmgDHLdkpqE5hTAVP53Z3iphsEqTewqTY52AgwyPONw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U0LWHSL3mTuVhefdcKRliqJ5gp6b7LFS4HIKDMbRUxI=; b=mBVK/F2faimRQ2b+gBbT2jo6LI
 56RO2GHVl31eOCkJBGJSH0dq5voVRCUx31wx85XpmJdtvpnfJrYWntwX/Orwq+/eavhUMhUncVVqX
 8QPDsMs4K/6JxXM84AYfjPgkNxsBLmOf0BesnWkkxTzmeCSOwF4zCThnWeWMoaB1p54I=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOXtX-000000007HJ-0ZA0 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 10:07:06 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so307584f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 02:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793786816; x=1794391616; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=U0LWHSL3mTuVhefdcKRliqJ5gp6b7LFS4HIKDMbRUxI=;
 b=MTcqDDk3Cw4VnkHjDxQvqB6XPUEGkpiZwVfwIc2bPvLkQxLF3pPpZ5TW+o/kB1f+rQ
 GlSibGkG419KeAzNTZmq8qzfySS+82hgHMFAYV6ebwiGm6aKQno+ipoYx/Vpcp/uej7A
 2jFnd+1d2pVMjIHrOLWp5FL6sYilsBdx8YOZ3XVqDEGKZCXCMf3hfCL9t8tjCfkN5rur
 jJUb9cOykbZxvr+7ek76ESlK5TnxiFvIzSJhH3p1GGKGWh1YSddsHq5xwNHzGMUFEyJ4
 CzkhSKKIFwUQ7IbexWexXrTwt832u25PP4qXVIYjrQQ1/5rzEu7HXww1c2IMCwk8OY4k
 KuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793786816; x=1794391616;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=U0LWHSL3mTuVhefdcKRliqJ5gp6b7LFS4HIKDMbRUxI=;
 b=bda0bMj2bXbvPSfhe/u5gzU7FD7aDJkdzR1SuA37wwxutpwZeqjifLWZXdthrbFRTH
 FJrMxHtCKUEeJiF4nhZUdFsNhbie8qNW/ukQ6z28g4QUSM0QzQ5pPsjjIbLm21kHzDmc
 R31AS034F146hxGwLPye3Hrum1Mntp5Vx5C6KY7qBYtToCVe10oXT7Z9F3/F8W1APelG
 OvC23hr0hQD/xSEdb7WXxZHLgnu9ecvGjx71D0tAKNMvgZybUgV/+3pgstZ5UCAWz14K
 zUtGU9npjs1Uv1aJcOH/GEaZEDPL3N6LLxO+nCm+tFUWIOkXp3si2QMyFuxf1gK2Rgf1
 SlTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQDlU+RmjCzRTUSMMofZwxV6YPpqSZJLDYku5p6I+9h03JvyBhfzHNHvyqgvuUfZn8v4UD5MFtMw94UM6H@lists.sourceforge.net
X-Gm-Message-State: APuU4Z//0b+WQOAweB0VtQ9JgB9fKMlBm2oZbThOUFUdFmZltuGlGAwh
 l7TWG7YhrJm6GaZWWNJHOjDgYXhmrHZJz9LDWp7CXfu3ZlIDhl5R4Fyx1w/sS9Niylyi24KdnPM
 hKQ9OAsAxWDJFI9R8EKe9Lekbdx4zP/2PVWnEoqFPBcBAsYpsicvgGJXYlpOhcmBYtiEoRQnQar
 auTjqU9g==
X-Gm-Gg: AYBFou2TgeyGA1xfA6wH4DnPtmJMixtsrnQVyo2bFIWAdwuYWpADcBuDlUuEwHRxHBz
 V4LCuBSU+V9trAiqI6GFnNoUuIXvpI7TmdlGkDPgSHrc3YZrcadGGnIq5UB8UfjyJ+ZxFx40Kwk
 BpnOOIkAGdNL0xRMc+aWIlfdYUMUL5jaMFILezMqXjctZxjPMVjygBP8NUC1pcAyETNu+QKc5jk
 AwbZ8WlAYOkJXYzEh0VCOz9B/QA2Vu+RDgAiA/XYtj1prez9sIi9vsFgpWimpETeQddwDoFyG/A
 Qds131pyVHhorb/Buw1m6hvQvKvnMalQwaWV47qKWbFFrEd8MOrHqJU7QAuaTiHrIfurfUmiOdk
 GdNeJJTAs6K0M+4ybVhMkO3Tf1XZHchfy+dOKqhVA2MRnMmOWIi0EUbHlf3q/OmwwPkQheQ4LWm
 G8ul2z7KRo/2trkEQwnyYECbAHGuLsDN0JNFsneEavSEM/dUbWr7ERgdi4fV737gcmTM8JZlvzS
 DAPALEWXZGrl6oz1bLtuPBcViT0V4inXrAqJPYEnMjzz2dotC2CTLgpD8Xv8o+FJ8+e5fRSwH4R
 /X+hZkYIo3rPtpsgJtN6HAKinFTLuMG3HAM98GWvCHDf/TRoMlhdkBm+AneiE1Om+WT4zl8swK+
 8putgKY19zxFCZf0uQvTwjqaJZIFipSyCK64/+kcm6trJqfMqYgzIPyuYeswg7kRqn4qeLTTvSa
 Qr/k2XkIp4nFL9vw==
X-Received: by 2002:a05:6000:2388:b0:48e:b1a:fa6 with SMTP id
 ffacd0b85a97d-48e6e3002cfmr34830784f8f.40.1793786816229; 
 Wed, 04 Nov 2026 02:06:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed0844e2sm2331406f8f.28.2026.11.04.02.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 02:06:55 -0800 (PST)
X-Google-Original-From: "Name of user not set (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 10:06:54 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
X-Gerrit-Change-Number: 2037
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2037?usp=email>
X-Gerrit-Commit: 83d7171af6b153b64cc428cd58c782effb95014c
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 10:06:54 +0000
In-Reply-To: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
References: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQzNzQ3MDAwLkk2OTU5Njc1MjRiYjllODM4ODdiOGMwN2QwZDA5YmFmZjZlNDFhY2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <94d6ce4ce5f78e49a39699d9da58b9e3e77886e0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOXtX-000000007HJ-0ZA0
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate the ACC protocol
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com
Cc: "Name of user not set \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5816549097375555619=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5816549097375555619==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kdbh2Q/WjOc="; charset=UTF-8

--kdbh2Q/WjOc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Ralf Lici=2E

Name of u=
ser not set #1000061 has posted comments on this change by Arne Schwabe=2E =
( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail )

Change sub=
ject: Add python scripts that demonstrate the ACC protocol
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:

(7 comments)
=

File sample/management/acc_sysinfo_client_demo=2Epy:

https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2037/comment/07b8a3d6_58f8d753?usp=3Demail :
PS5, Li=
ne 61:     def receive_acc_sys_info(self, acc_message):
Missing typing


ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/5d483b42_a9b6844f?usp=
=3Demail :
PS5, Line 64:         logger=2Edebug(f"Received sys_info message=
: {acc_message!r}")
logged twice: print and logger


File sample/management=
/acc_sysinfo_server_demo=2Epy:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2037/comment/ab76278b_7c9a5605?usp=3Demail :
PS5, Line 53: class SysInfoCon=
nectedClient(ConnectedClient):
Missing @dataclass?


https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2037/comment/93f6501c_192bbdec?usp=3Demail :
PS5, Line=
 66:         logger=2Eerror(f"CLient connected: {client}")
"client connecte=
d" is an error? =F0=9F=98=80


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
037/comment/652b9761_54c0e4b9?usp=3Demail :
PS5, Line 67:         from ppri=
nt import pprint
unused import


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2037/comment/d9fb81c7_91f6af33?usp=3Demail :
PS5, Line 85: async def _send=
_sys_info_command(self, client: SysInfoConnectedClient, kid: int):
Ah, wron=
g indent, that won't work=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
037/comment/1988e0d7_3af8a1f4?usp=3Demail :
PS5, Line 89:     if not "sys_i=
nfo" in client=2Eacc_negotiated_protocols:
Hmm, better will be 

if "sys_in=
fo" not in client=2Eacc_negotiated_protocols:
   =2E=2E=2E



-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff=
6e41acf4
Gerrit-Change-Number: 2037
Gerrit-PatchSet: 5
Gerrit-Owner: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not set #100006=
1
Gerrit-CC: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ralf Lici <ralf@man=
delbit=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Comment-Date: Wed, 04 Nov 2026 10:06:54 +0000
Gerrit-HasComments: Yes=

Gerrit-Has-Labels: No

--kdbh2Q/WjOc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Ralf Lici=2E </p>
<p>Name of user not s=
et #1000061 has posted comments on this change by Arne Schwabe=2E</p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">View C=
hange</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File sample/management/acc_sysinfo_=
client_demo=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/07b8a3d6_58f8=
d753?usp=3Demail">Patch Set #5, Line 61:</a> <code style=3D"font-family:mon=
ospace,monospace">    def receive_acc_sys_info(self, acc_message):</code></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Missing typing</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2037/comment/5d483b42_a9b6844f?usp=3Demail">Patch Set #5, Line 64:=
</a> <code style=3D"font-family:monospace,monospace">        logger=2Edebug=
(f&quot;Received sys_info message: {acc_message!r}&quot;)</code></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">logged=
 twice: print and logger</p></li></ul></li><li style=3D"margin: 0; padding:=
 0;"><p>File sample/management/acc_sysinfo_server_demo=2Epy:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2037/comment/ab76278b_7c9a5605?usp=3Demail">Patch Set #5=
, Line 53:</a> <code style=3D"font-family:monospace,monospace">class SysInf=
oConnectedClient(ConnectedClient):</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Missing @dataclass?</p></li><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/93f65=
01c_192bbdec?usp=3Demail">Patch Set #5, Line 66:</a> <code style=3D"font-fa=
mily:monospace,monospace">        logger=2Eerror(f&quot;CLient connected: {=
client}&quot;)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">&quot;client connected&quot; is an error? =F0=9F=
=98=80</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
37/comment/652b9761_54c0e4b9?usp=3Demail">Patch Set #5, Line 67:</a> <code =
style=3D"font-family:monospace,monospace">        from pprint import pprint=
</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">unused import</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2037/comment/d9fb81c7_91f6af33?usp=3Demail">Patch Set #5=
, Line 85:</a> <code style=3D"font-family:monospace,monospace">async def _s=
end_sys_info_command(self, client: SysInfoConnectedClient, kid: int):</code=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Ah, wrong indent, that won&#39;t work=2E</p></li><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/1988e0d7_3af8a1f4?usp=3D=
email">Patch Set #5, Line 89:</a> <code style=3D"font-family:monospace,mono=
space">    if not &quot;sys_info&quot; in client=2Eacc_negotiated_protocols=
:</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Hmm, better will be </p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">if &quot;sys_info&quot; =
not in client=2Eacc_negotiated_protocols:<br>   =2E=2E=2E</pre></li></ul></=
li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2037?usp=3Demail">change 2037</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2037?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>=

<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4 </=
div>
<div style=3D"display:none"> Gerrit-Change-Number: 2037 </div>
<div st=
yle=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"=
> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: Name of user not set #1000061 </div>
<d=
iv style=3D"display:none"> Gerrit-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov =
2026 10:06:54 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments:=
 Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</bo=
dy></html>
--kdbh2Q/WjOc=--


--===============5816549097375555619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5816549097375555619==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5816549097375555619==--

