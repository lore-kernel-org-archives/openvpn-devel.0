Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42037606A31D
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BGiu4+Uh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=g/cV4C0l;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=i/4MGm9Z;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cuwR2Ik3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=W0Ab5vWmvZsDSJ2gMI4nqc282UB0Eqn3sWy8pUBd6cg=; b=BGiu4+Uh33Q+EmACEuqECmSPSi
	ohQawrn9iq3NuYXA3Z3T+ssyggooIg7gVxvFwFP36X+j4pizfVZrHXWMShKeNI4WhxzPj5JjZluHI
	hpmrZnHI5Ito4Ee9pCitpKH6QiwmCDxfY3ufP4u2XTOXFC/gihTwPQ3K/YbL3DCBH3o8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSdaM-000000004J4-1RtS;
	Sun, 15 Nov 2026 17:00:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSdaK-000000004F5-3o6L
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 17:00:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mxDYePuqQ7HQHJPiFc/oHnfQuXTSHJgtyBMXtfICclI=; b=g/cV4C0lAPR3v+CrPPChTL1Y5O
 pGeGf0q4VTZq8FdMJes8pNXpHfX72CUsABJc4YpiNo/XxDVTnkXlKH2UM4TIrWdD1LJns77CNFUBm
 pT0ZpUN9/HsmCTK89inQIH2omGNXQGNutd/XuqLU+o6SddPw9xuVBq55qAZt6q/g+sNM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mxDYePuqQ7HQHJPiFc/oHnfQuXTSHJgtyBMXtfICclI=; b=i/4MGm9ZzpbghiciePucVCEcuI
 NarSOKbE/hpXeTl82RUx2twbrtUwe+sl/B4ab/cdHHGDUCx7AaAWItZWKRuQziGBmIJjAUp0qY/3w
 WZ4BwqBdI2SojC2s0lKrOz2ZVlPFyj6RvE8wNNi4c3/fcg6hqS4joKN+Yk5t0YHZNqcs=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSdaG-00000000530-1ZTE for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 17:00:08 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so2432135f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 09:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794761998; x=1795366798; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mxDYePuqQ7HQHJPiFc/oHnfQuXTSHJgtyBMXtfICclI=;
 b=cuwR2Ik3XBLehcC39n/ODxeGFa0rHPVwMAaeKJXXgnWC9wrIukQPdrbtFXowuL+dA4
 9YK59gT4x8BM47F2U/cZJ7vZhMBJ6iOjeUjWT/rMTjtNoldVBnUSf5Qb/mn6zY7nzKhX
 zL6A4QQ93OX4+UpFTTcqwfNaTKWGljy9OnPSsLvThEU1HzsvhUZX9LVq6Ekj+9w+7oh2
 bZLEFKxCjQ6LyIYOoNnD0+jbg2QBXrgUnS6hIANSZMyySBLYaGsVMtFVBituHwZ321wX
 OumtX3R5i3ybb/8IZNHM4miQeqA8x4ey1KmkS7HcphaKQJWssSd4w3KcLkKxuXjC1uDV
 KAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794761998; x=1795366798;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mxDYePuqQ7HQHJPiFc/oHnfQuXTSHJgtyBMXtfICclI=;
 b=nvfJmoIsE7VMlonaXn1QGfwleNZhyF7dWtLRWp26jC66C0jpegjs6thsm6UtM/GS/A
 xt+XoB+YO0UA6YVi0KZyUMtL6IlfkzHm6lHpYvRbPpwjVWE3sP4xDGbVTlxYemDb+6XN
 +S3cUy+VUSHzsPQG32gkt5RGyBDIRbQiBaJNEf7cqzl1GOdSl5+R2WJdPA9y9d/gAZ0m
 /bPgG9qgr9VX7ZoNkL4hvXn8i3cTyfxDHwHB1ksgtMgReTExmALXgiNMzcICErW+VrUi
 iSFAe4PWTgxGigvwLa9ZzKXYQYKFPzQ9FQAf62tCnj5VZi+tPRdQo7xfv1ZDAfHVj2CJ
 y7JQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHNugPJRkhyaG8QjZceG5RC5NC7km8w1jQUedf9bgu0f0Y4Jq6rSED/ipGJEsxQsTEtWgo4uxi9UfiTV+eX@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8nZxHat8JEAmeMu0v9DgA+Jc5X4hcIEg5nQznfr5GjGbOaCG80
 bHvczg91sJZ8r/5RzBB1WSKc4FuvsUGaia2WL8Sjw79FT2rpLB4MO4b0iLmkLMrfk7UcNQ8m7qc
 lRgp4247grWzWLLmLWAzhxw5nH9v5G5vfj1dPOq+kHcbhSCt4jPq4+1p00sbPTnFpN1ve
X-Gm-Gg: AYBFou1g2gObCudt5Pb+UGERwIIpfgR7DhIaRrNVUERLxqTN+u4Vd6QHFttv4RRQs3O
 sf88ItccFqAiCqvTyoXJJ2dVTdd7itXzETLbC8hBOvSETt2S83h4fNyotTt/mhdOxMQI8xB5I9G
 lhwMCfAZkw8fkvFjAeAK3jKXRMuGu+YTlUisXVeCAhaZsCS2LsQ/WEp5Cm6UMo/bDF2YPoWgHjC
 Rj2BY0JJKvHm6AUStd0gNAwfee+nBrnMfslILz0ic7/r76cQ+VXsOSW3b6CvSKg5E8g6dQIv6ND
 1WJNPKyi6JB89L3SCXCSnP6fa8MAQDtw9PYwgrmy75iVAbeaeOZ9M/rxwhq4LUFcxRi9I7ge1HX
 UjVLaAsh25OplMfGhVmHen0d7fPwx05+FYtZX51gC/z5X/4HQK0uQBmHFtgWqfxRmxInFlD1vA2
 r6VpVaFvISXWjdTPa02wW5ua/ws+WBz8NjGeWRKR6qzFnkzXPF5Je3SJxHzK9EQrgJQU/vJgw4f
 7aw4x+6OF+2Jb/QY1slUdsaj/7sSKJOsGwSBF/LjAf/X+A041Z88etdKLdZuXbpLUVDT/UA9pUk
 Z0w8VzY1o7PB4fdS4+8HzqV0F3r2HDecz9WdJdg/2vrjORk0dk9fOmR8MkLbXHHDMAmA4lVypZB
 SPCh/3LP6C8dDQDwuZD5Sh5VMGz74ybI9KkfpbpJ/Lq0zEg1+nZh7fYdFaGcLIwjURlSYzpIcde
 2B4+zPnPDRz/lVJNc=
X-Received: by 2002:a05:600c:8010:b0:4a7:9025:5c3b with SMTP id
 5b1f17b1804b1-4bb55a6a5f0mr172161725e9.19.1794761997509; 
 Sun, 15 Nov 2026 08:59:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb679b7e1asm183292975e9.6.2026.11.15.08.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 08:59:57 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 16:59:55 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib8a47751bb0d559083d1a50aab82c06fb0dad110
X-Gerrit-Change-Number: 2184
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2184?usp=email>
X-Gerrit-Commit: 53c0603bc15fcdb09318a2561a514df193ea8000
X-Gerrit-Comment-Date: Sun, 15 Nov 2026 16:59:55 +0000
In-Reply-To: <gerrit.1794653707000.Ib8a47751bb0d559083d1a50aab82c06fb0dad110@gerrit.openvpn.net>
References: <gerrit.1794653707000.Ib8a47751bb0d559083d1a50aab82c06fb0dad110@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NjUzNzA3MDAwLkliOGE0Nzc1MWJiMGQ1NTkwODNkMWE1MGFhYjgyYzA2ZmIwZGFkMTEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7d451051663352e04805c5856187580135ac21c4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSdaG-00000000530-1ZTE
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth-pam: Include
 dlfcn.h for dlerror()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0407862101905855850=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0407862101905855850==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bnkeImclWGA="; charset=UTF-8

--bnkeImclWGA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2184?usp=3Demail )

Change=
 subject: auth-pam: Include dlfcn=2Eh for dlerror()
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2

(1 co=
mment)

Patchset:

PS1: 
We fix it for now, and throw it all out later (if =
we decide so)



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2184?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib8=
a47751bb0d559083d1a50aab82c06fb0dad110
Gerrit-Change-Number: 2184
Gerrit-Pa=
tchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert =
Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Comment-Date: Sun, 15 Nov 2026 16:59:55 +0000
Gerrit-HasComments: Yes=

Gerrit-Has-Labels: Yes

--bnkeImclWGA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2184?usp=3Demail">=
View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2184?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">We fi=
x it for now, and throw it all out later (if we decide so)</p></li></ul></l=
i></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2184?usp=3Demail">change 2184</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2184?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Ib8a47751bb0d559083d1a50aab82c06fb0dad110 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2184 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none">=
 Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Sun, 15 Nov 2026 16:59:55 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--bnkeImclWGA=--


--===============0407862101905855850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0407862101905855850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0407862101905855850==--

