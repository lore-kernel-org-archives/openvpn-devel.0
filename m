Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF38606A333
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 18:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XZsb/6ds;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TYfIEvNZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jpKF1SgS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KD8Fj7Vb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5ddTI4AECyC/QtDGgsNvKuuDJSthGMEczrsCOgyYacs=; b=XZsb/6dszn2YkTKBIGhEEbIV9T
	Fu8DNcbV4TCflAA3X9AihgXo9ABDEcOd6aGAHsUQRZ2TssQq39y8kDD/kHiUS/Gp/XNxVS3j1APiQ
	2DzAWIFA+c1jBzu5GMrM4JXaN6/FFkSaBlnGjSQn7mye5fCogw9XNym1VjSfTG29ud7A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRCzj-000000003C8-3dYv;
	Wed, 11 Nov 2026 18:24:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRCzP-000000003Bf-0pOw
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 18:24:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dXKlUQd0TPiM2s/8DtzXHTcHQ2dTh4PZW5hi5kTPtT8=; b=TYfIEvNZ9RIlyzhQhS/7hUsCFc
 QAEO4z8xz05oFHI7vuBxteWzZL5fxF7wk5j8iXmXVnC84gzGPnI7GtbuG6zhXGMmD0Q25KWC+mkRy
 R0SQHHgfa5nw0yHmNokBd8/fsYhH2k5Tk/qP5C/c0xsU2ckOAXI+dXyVbfFHjnZJH0sU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dXKlUQd0TPiM2s/8DtzXHTcHQ2dTh4PZW5hi5kTPtT8=; b=jpKF1SgS80HMkNwY1CiWRDwOzI
 g7r4BJlUirCfKVBOzGGJKQPG4kGytURJl3iolitcgLlXmaus+FKmxqn3xQC1d0eddTOb7Nz8rMEsm
 A+VXXx4GDfcjz/GxsvGdvJbi8s4yp/AB17JRGWgq/I+2xVss2GZsqt4xOmOiIE/P7+fE=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRCzI-000000004wh-3bla for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 18:24:02 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso30343565e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 10:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794421434; x=1795026234; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dXKlUQd0TPiM2s/8DtzXHTcHQ2dTh4PZW5hi5kTPtT8=;
 b=KD8Fj7Vbm8lpsyQngIJQ/y6au8uqlUIqCdvXCrFD2RUqNPoVyQCkJEO2Wq/AGqtGb6
 U2YQuDJ8ihtlNyTvkzZYJ0T/PgvdjEGRVQgc1HFnVwukkQ0WINBnXgmqLEl7BEKyKZ4A
 Vz3k/pGx21ARKaLih31gD2C8e8sef8q8qwtiwjFBJbhQYt9KawiXWBWlzvrGnaCM6WRT
 xry/J8s+C6eDlPjnTJDTLXrjUgefS/aY/OvgLPxE7aqBhUJKL98b8i0SITmv77t70xiF
 3ylHzTxn/vm1GG94PQPlRjTjxbcIPd+ekDUikUnantfVIl14SSGbvauW6ec6+dUm7cdH
 9PTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794421434; x=1795026234;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dXKlUQd0TPiM2s/8DtzXHTcHQ2dTh4PZW5hi5kTPtT8=;
 b=aIWiygQ8hJFhhtb/zy/5gaYO3+deTsfrH/dBsUHSu4pdaJTgOMe6TC7MEez5h3qe9Z
 64GVyO1f4H70LrjMNHbRhYChxZaAJNWvII+V3LXnPONCGlPTtl9lUJaIS8bL3mHZg4K9
 RZVk2Yu1K1/q6bAxquIv6OJL0V4HxdjJpsMAVHO2XPF8kZ0LlNRReloYzL0xB7nLHFEK
 lgxnzw6Q6fW0hjnIxa9TDvHweFkOioDbbweBbX8xK4CtTr4b/Y0/46LBxTBYWLDdycEb
 hXgwLNCwVigvva9tJGEJD2aKZ+5P6QcXxQ2hvuIy+PneKVhaUz3azfXReDWEh5tSO4Yr
 q97A==
X-Forwarded-Encrypted: i=1;
 AL+hErFR0ZWnUxeABCgxLNEeO863YMtMzHjekPhMt9KdPNjPTOe6GOLPnXwk1A6sB9OD4eiZkLBgpuUucydDb5nV@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+hvQ2BYlxOCkAwIkQxkKkP5AexW6jGcO8Oz4Ml5hB8nquDVCsX
 SjzhezAhyRFfjuRPTJMGmcKWjlLhcNi3vuCoiFldzGn5Kg2qbrEQFHT6yzpbimEmK3Jv+xucLnP
 /FxzreSisD2qZ3DYpihgTW0ysO8RS89WFdlZDb0pY1gOr8eOPbWhyUQ1t4nqBo7JEjliV
X-Gm-Gg: AYBFou3EbpYTEwk/Bcz6RuHwzZGu8BS1BJniN8pfF1jRRzwnadWmDpcq+PY3UhvN6w2
 HLYsoEzUw27KZtq8/wlwQzY619dmdfI2FVW6uFu+y9v9u4UDePLsb8Ai3LXOcR3mD+umwmvCY0n
 Ku8R6Dz7tjAl6f7ZU1zGcd6qlDtO3WfvvrsWXeh4cicrLmSOhZ4zAXzQIerrcc9UdyVCJPAdiq0
 owcQvzru43Yx9BPVKSfYaePp6gtc3j7lVR9JANXGJWamUpyF0KeZeQuInJzFq0BFZaI3FCk8Xc3
 d1VHUKk9xG1KNU/xSyHm10tcAhmXYwXt3gmUPk6mvt6vOvnbFcOHeHSujG+APTUdH7fcanQzBv+
 WE1s2VGUhjE6jtSSEO5bmqYggUPkgyuAK3PLM73V2v5LR4XqPjK6/fmWNKLDmkcgAzGN60AbnMS
 W1RSRGKgRdKLT6aA8VU5WvNkdn+V7n3VnIH6HVbzlp/1/Bot1IxgUKb7leUKNNk4Vg2t+oUI40U
 4kp+KCl9BFBHlqeMiEaeMjNv5cAIzZktEx4pbER/lQ6ITrUkQ7iwDbiuzo0Q5ikw+AWhHXwORbZ
 IY0+cyhiAk96KqFZ8MSegJ+LkxLIZAQ4OhFLDCRfIPf7ZwvmaI/3YzCqtpTa2mf4+2DU17js9VI
 MCw2mTJm9PoEGFg9wonnIspmaqZyuhTHucS5gK1OAGbDP3tlcPfJ9LeH5Q+c3cP6bBjqJyzc5dU
 lsRYqTrfkOOCkUmEs=
X-Received: by 2002:a05:600c:6212:b0:4b7:6942:39bf with SMTP id
 5b1f17b1804b1-4ba0938a405mr57329025e9.28.1794421434086; 
 Wed, 11 Nov 2026 10:23:54 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835d2c027sm12475136f8f.24.2026.11.11.10.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 10:23:53 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 18:23:51 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6f5ca53d4288b0921610f7a3f84ad55d2ab49118
X-Gerrit-Change-Number: 2177
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2177?usp=email>
X-Gerrit-Commit: f1aa080919614eb7977b422b7d8ac3911bf24cdf
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 18:23:51 +0000
In-Reply-To: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
References: <gerrit.1794417322000.I6f5ca53d4288b0921610f7a3f84ad55d2ab49118@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDE3MzIyMDAwLkk2ZjVjYTUzZDQyODhiMDkyMTYxMGY3YTNmODRhZDU1ZDJhYjQ5MTE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bb49f3105c0c0d797f5c3a7e1c3a7375093ff496-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRCzI-000000004wh-3bla
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking_sitnl:
 Reduce boilerplate code for parameter checks
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7209003177097164332=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7209003177097164332==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WEpXFONtDEc="; charset=UTF-8

--WEpXFONtDEc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail )

Change=
 subject: networking_sitnl: Reduce boilerplate code for parameter checks
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:=
 Code-Review-1

(1 comment)

File src/openvpn/networking_sitnl=2Ec:

https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177/comment/ae39d9af_0aa207c2?usp=3De=
mail :
PS1, Line 720: }
This function duplicates a lot of `get_ifindex()`, =
and looking at callers we might even get away with a single one of the abov=
e functions=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2177?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6=
f5ca53d4288b0921610f7a3f84ad55d2ab49118
Gerrit-Change-Number: 2177
Gerrit-P=
atchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Wed, 11 Nov 2026 18:23:51 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: Yes

--WEpXFONtDEc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail=
">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_=
sitnl=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177/comment/ae39d9af_0aa207c2?usp=
=3Demail">Patch Set #1, Line 720:</a> <code style=3D"font-family:monospace,=
monospace">}</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">This function duplicates a lot of `get_ifindex()`, =
and looking at callers we might even get away with a single one of the abov=
e functions=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail">change 2177</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2177?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6f5ca53d4288b=
0921610f7a3f84ad55d2ab49118 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 2177 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: We=
d, 11 Nov 2026 18:23:51 +0000 </div>
<div style=3D"display:none"> Gerrit-Ha=
sComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes <=
/div>

</body></html>
--WEpXFONtDEc=--


--===============7209003177097164332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7209003177097164332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7209003177097164332==--

