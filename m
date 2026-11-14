Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46225606A32D
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZiNS3J6W;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lwJ7TjbA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fwQZV4Cr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PvIwo76I
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=gxOCORfqtwXTSFoiTJu33I9XcMfrXk7qgbvjxOtjFGA=; b=ZiNS3J6W7Jq/NPq0g1TIFc/Pwj
	tgKEDZJnZXCpqTEdvziIBjsBteTXI1LWuN0ec/oB4nXxCTQszDrN7JuBUhZFw+1II4jm6QbJ1wtjB
	SachEl5JIqz6Ha2uzKl4KWtMrl2o6Gi74Ji60P4456Eb9/jcsQBWoNHpgLRN/0b3v7yo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSEQl-000000003lO-3Bk9;
	Sat, 14 Nov 2026 14:08:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSEQk-000000003lH-0v8A
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 14:08:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kcClHf6Fbknx1UfDBdLC1XXttLhA4QUHeEGyh+9fwe4=; b=lwJ7TjbAdNdC4XwPHwiFe43/JH
 phnST7cGqGgw0XzfPkVlktJRlEclu1/F1vJDB81HWr/Pi16QlXEP8BuJVMP4Lq2QJBtE4cisiBtW6
 Ef8OT1YBRcFUzQNuLHa3SYXowNpjBH7Zhp9N68mrs5ZJDNIH7ix/gWP0eXTFwZ/fJ5L0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kcClHf6Fbknx1UfDBdLC1XXttLhA4QUHeEGyh+9fwe4=; b=fwQZV4CrpqP4TZfciolH3d5SPL
 XWBYJe059Rn5Kb0Ql2P5EOIASZZIDndkKmIFbnZ8UOgSjVS3x2B1YUZ77ZW3tlHLSeRyhN6KccTTK
 y6LGOMnvWLKDSv4Et/9QKzLNVbb6WGUmXMaGAIZrUeQpyOaKV8PJosQUH3KX9t2BDRyo=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSEQj-0000000081t-0dvb for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 14:08:34 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so26925205e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 06:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794665306; x=1795270106; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kcClHf6Fbknx1UfDBdLC1XXttLhA4QUHeEGyh+9fwe4=;
 b=PvIwo76I1rgoeU+zgHRjf2tWfbPoz2FzJXXACD8+PQJb5+DwYblUCTHxZ3iCjgw6j4
 WSODTvLlSluRu+3t72uy6uqdS27JGYKhTfmMuG+ZgTljssguTBo+rEHhCJBnFv9uuO40
 RaP9IQlPX6V/HW0nm/UJAr9j0ZDzMndcSb1RTwCS0EAS4QqtYLseNwtXZ1AicrcchvQM
 lpfjULPKPhS6T67knJjHX37AcRmXDVi6zGwHlRwU5XG3GJn+8UzyUNf3cjZ+voOHYiLI
 UA/8Hh9AADRLMJ5O7NciXMbWxBjD4trPiLRWWApwKJDfGR/dC1Yr469CKnO7ZUyv584r
 jfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794665306; x=1795270106;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kcClHf6Fbknx1UfDBdLC1XXttLhA4QUHeEGyh+9fwe4=;
 b=TuhdlkkgN8LFSxbkk2CwlhmrCD21mS6/kVX0NJHlBtlDXxRH4MVmIA6fpiIxTHL8MV
 H2WVpFcLRQuAhh/RrvQw3tsQnCBHglD+oYDuukpGK7rfE83EksSHD55LcDUfkIs22y1N
 ncYUmE3ku8aY0LFkiwJpan+eqvHAFqVOOcYTpu4MK35WrICpoMtANxS/jwIkE5GHcMqN
 F7Apnx6ifrIfrGJXfF92PdzTgiZ+QiNEFFscKWRr++XM9VNSukRhPvLVLi4sXGi7R1lj
 sVNPtx+1d4y4oYoChd3cmmjQHanFCku+AmzC9yx4bSHYPNetAIp1ch73SxdbMeqEddZD
 zeOA==
X-Forwarded-Encrypted: i=1;
 AL+hErFOcp6TWyS7nH1gzgmL4wOfQTU6+q2cW2yloOLipHqkMGPzAwb5WpZ5EbVI3i+HgEaBaXmWSme48aUE0rEc@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8HA3dZsbJ8UJ7yRS1lm+O8Zt3NVyDNyBeEnnQBZMh8Wy939hyR
 Ghs/MljCN9iCodyd/eoL0Rn4L0nnqXM2jfkR6D+74ukZjwr/QbTw++GCAfXBKSCIro88bh0OpRF
 oZiO519/t2WWnutbK5+tkrdS9/esuh5bx4C1any9L17CbMKscWPE6sJA/uPWmznvCKeFOOgifon
 4x45TTfg==
X-Gm-Gg: AYBFou3AiHHwztEcKT7Adg41lH4jvC55oHQ5zQ19wJ27SJQ3TvsFbmu8sHlC90w1dUg
 HUpRqxE1t0zeYVCEYqQlRjDc+yseneQ4mV/gCXP7d5qpQWxq/lpkE0uekf4P4ktrd/eNiRDWPbO
 bSO6YgGPH5HcG2bOlGJ1rJ6Tw83LFOI8WXZv5IuPplaqbEptuj6mBGI9DLRZE20v8NS1yQ9yzZi
 axhRY/wxBSsftilYCoVriETU4jgoG8aPLp6LiX8kPaymxJEIXYxSTZNhzqcXlLDLDfoZ0fSElGN
 RR6wGtPhRm8AjtWZO2bj+4rVvUL10mR92RbZZ9ADmucYArL05yzt0CUgDcry9+Cl16MpxGSa6nN
 F6/Call6EemyxA6wGhnbzPVnroS4AiSldTkiCljeEAr9FYVTrMAFTL6yiH8Tvz8kVxC577x/7vy
 lrfa8mXLou8M1wey4AKEz8NQbEnldwt3/zRUNCdPUn3q7ng2u2/fYjhXnw1Ls1JgZL1Iadf9Kwn
 CQl2w/NezYOPblVkViKlpo0Tv9r2DwWO8IwU93Lxb9EddhliCXwdR+GFQaKca2ryzoAoSx5vLdf
 1GMXWNOZQqpSgrE4bF/ydyN2S36tHCoC5/lXY+ZvN1GxTQfgppRL9J1Gg/5dZ578jLwsSppgST3
 A30JNc/vc6LJt/N+zKPhm8I1iPWxklIRW0IQy3m7olCMz86aqDiqatiVFoSFW+m27VZ/vke31M8
 uRZhxyVceIhZT54Sw=
X-Received: by 2002:a5d:5f47:0:b0:48e:4f1e:5e24 with SMTP id
 ffacd0b85a97d-49c6fd92fbamr12719651f8f.14.1794665305840; 
 Sat, 14 Nov 2026 06:08:25 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c608cf46dsm11586358f8f.43.2026.11.14.06.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 06:08:25 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 14:08:23 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib8a47751bb0d559083d1a50aab82c06fb0dad110
X-Gerrit-Change-Number: 2184
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2184?usp=email>
X-Gerrit-Commit: 53c0603bc15fcdb09318a2561a514df193ea8000
X-Gerrit-Comment-Date: Sat, 14 Nov 2026 14:08:23 +0000
In-Reply-To: <gerrit.1794653707000.Ib8a47751bb0d559083d1a50aab82c06fb0dad110@gerrit.openvpn.net>
References: <gerrit.1794653707000.Ib8a47751bb0d559083d1a50aab82c06fb0dad110@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NjUzNzA3MDAwLkliOGE0Nzc1MWJiMGQ1NTkwODNkMWE1MGFhYjgyYzA2ZmIwZGFkMTEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bca2cf9509bed0de5345195831d4ae43a929c9a2-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSEQj-0000000081t-0dvb
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
Content-Type: multipart/mixed; boundary="===============6519625968969375692=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6519625968969375692==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ix3gbfG76mg="; charset=UTF-8

--ix3gbfG76mg=
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


Patch Set 1:

(1 comment)

Patchs=
et:

PS1: 
I do wonder if we can just drop --enable-pam-open and the #ifdef=
 completely?  This code was never touched since initial svn checkin (and th=
en directory reorganization) and I have never heard about it, so I guess "n=
obody is using it"=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2184?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: Ib8a47751bb0d559083d1a50aab82c06fb0dad110
Gerrit-Change-Number: 2184
G=
errit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Comment-Date: Sat, 14 Nov 2026 14:08:23 +0000
Gerrit-HasComments: Y=
es
Gerrit-Has-Labels: No

--ix3gbfG76mg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2184?usp=3Demail">View=
 Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2184?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I do wo=
nder if we can just drop --enable-pam-open and the #ifdef completely?  This=
 code was never touched since initial svn checkin (and then directory reorg=
anization) and I have never heard about it, so I guess &quot;nobody is usin=
g it&quot;=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2184?usp=3Demail">change 2184</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2184?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib8a47751bb0d55=
9083d1a50aab82c06fb0dad110 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 2184 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 14 Nov=
 2026 14:08:23 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</b=
ody></html>
--ix3gbfG76mg=--


--===============6519625968969375692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6519625968969375692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6519625968969375692==--

