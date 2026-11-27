Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70D0606A31F
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OTK1x3ji;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=i5u6kEqq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MqNMkh/r;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZSmFD/Uv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=6uihUwcmhPuTxeSiZlYFHHOzZp+9A0xqlILpalDrLWk=; b=OTK1x3jiXZxBpFvrcIOFTk+zMd
	gorc+PjM+81fvVCua9h0tCL79FCyTUI8+I8CHK2ooQjXuXfB1/SKiiZZXQzkoLDvZp8pn3JswGueV
	Oe6eYOwSw+JHh8ECewm7C2G2HByF/ReU9u5Eni7F5blte4U0ehbOz/bv9M+HqHyHPApQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWx7p-000000008O7-05vp;
	Fri, 27 Nov 2026 14:40:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWx7n-000000008Nt-1Hlb
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:40:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VrxMkgNxHCAJ3czVf6FetqzNv6HkgWJVrrsT5VdwPOo=; b=i5u6kEqqROQYX4MtvwBEdN6o8i
 5ZFEsh54h8RPhvWUMYOgRwM6xredO0hIQl1ZY6Z60fZcjbc71KCmn9BeeHTgnyU4K2g6UG8QgcuiR
 OhByu11HHstR9vxdjF5F1DrqRmyu1szhgWu/QaHYJUMk1kD6m/bTSCnLS6rhLleKBSm0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VrxMkgNxHCAJ3czVf6FetqzNv6HkgWJVrrsT5VdwPOo=; b=MqNMkh/rS52+STIEf5DQw+qRQn
 ZYE4QQYMk4QLAUd/HBK6AOMV7pWaj1crxhZYWaJiA0HTs7rTuEehv79l2i3iq6JSvIoXgJhraVTEV
 XL3cnoFD64pYy0+LHew44+TNOWa0MT0Hwchr3YHy9Oc4cDyCvMGH4p3a3Ycjqy8b2mOc=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWx7l-000000006M6-28cQ for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 14:40:31 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb9d8e8e90so53231995e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 06:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795790423; x=1796395223; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VrxMkgNxHCAJ3czVf6FetqzNv6HkgWJVrrsT5VdwPOo=;
 b=ZSmFD/UvC60drkPt6DJKXPvAlxGv3n6tpazTRsD9zekdxUpUQ4gNnpmfKAu8AcUes7
 vxIqz8TjOs8vnxwUzu0itY3addHQoGYx9GFfXE2ljrJD3+x9/YLJgtCPWDwSQIPpzOFD
 8MnGdIdYxZUXXQYyRE19Id7AysLkFgD05vlFdmlynKlGecv8iFSHkRf3FMDX5JTAR60n
 ju4UYZwu3P452iC6wSZP4QPmlLemN9CiwtEpuqv8XwTFQH3sBInhB8oQJ5te6DsCbP2s
 KTLdPvbp7hmZJxZI8gg3EbdZADAFfydrvRtG7hZBxKqpZzfQzZu6Hyf5KibXnkyLG702
 65PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795790423; x=1796395223;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VrxMkgNxHCAJ3czVf6FetqzNv6HkgWJVrrsT5VdwPOo=;
 b=OOnI1wfvYu12hr0s52PW1ICTqMCGkoUKSZo1BbQMrz3fz9hZhay/iLDCnVNn8e+ZhZ
 v/1dyLpiWmZHWGK+opMUETjHhWe645ndHmL3WrfOXdlsYqYF8CdC2GBabY1aX6G+Lw7n
 HcHSfd3EIrs5e0IHBVfoaV0tON0a4TgvqBCu7iutyzchLDYlNAkpnWkaLMfY8Uf4pqxK
 2g12k5Nsnx0Js6xZuwcClfRrREiVAnkPgVVgoq9BU+EscRxFIr1+xWlCh+txRiU6269n
 iuah27Gy2l4buCUZxVmkmtG8vYqmnBjvDogfQ1yZaOl4ys55D8kxGHcYsPLG2FTkEv3V
 7hDA==
X-Gm-Message-State: APuU4Z+Un5dW0XemaCA3rDMsFFuurwARNUUcaK8Vx3Xmrfei623LyvHJ
 okQ0fY303YifSLKuMqxTC5MF3zk0/g2d9PcVyCDsbM4ls6i/sJ3fSoNo6yevK8BjF5Jp3uDlHlZ
 a5qsPJUZqDbjXYuOQ/fZxDoAlfRCmFleCfzb2BCIVfgGtDo7rKxy0I0K5eK/jRom0YbrL
X-Gm-Gg: AZFdTZfNuKnNJk7Gs9CQdG+1tAcNlvsLybupyXHrjbo1eAZZqGuvKrvi1xqL/w8xRKx
 oTQQjLxxe5lcRdPogm4heE1+MNJNf6HfPP0/BfohfLo8NWBe99yINs5WZovzGpoXt1ndlbEJUnw
 V1nuVqThflBGmznIw1Juw39LMfsBhe61lbE9Z5BYupnfuHArE5ppX1LuQAR0sUNuM2HYU8fJUYH
 +/On4RynDtu+5/f20IDMaOkEjHwsZ09Qm1Eli+pRGILs9PRgsbC6U/ZrGe2yGf+RMwej2fQcUWP
 g2REkoCI4s8p6DKDOPxU+yexe3on1oU8nORw+jpkF9NZ8VRtk1/5ERqc3AoIj5KA2uNxuaVy7qe
 olbbUpznRf3tqwRUw7YhMtEbd5WnbvQQmLA2oIOhkoEJ0FH42wBWHWKmXWR9238h5bjwvZfolcX
 6mNoMvCUt5VhEtHcc6Ryxmm9NvBc1R6Ec+uFWQtdi6XEw487SNfA4eU9AekAGdduBLvZ6bTa6eD
 4aLwRXXoupLSQxi+nYj3Zianyy4rkqv7KbXbQglyurPhtT6UZvbYtBdRZ0cv1m/T0tI9XQVPESH
 zyXXIARziUYWDJOFiCBlWulfMLdnk6GnXb/bOKThtwdMjgtlaFXRQwvo3zAoNJAHMISR0kyV8aY
 KXSIu6jmtMFwFUIHmL8qWZez7M4nyqEYxdTdxDQ75+0jBuuv7TMmwhGirJ6i1x+pU91rsyjFBMv
 CIgjQA31dQ6XbbWK4=
X-Received: by 2002:a05:600c:1548:b0:4a3:5aea:21e5 with SMTP id
 5b1f17b1804b1-4bb887fe7e0mr514195425e9.9.1795790422803; 
 Fri, 27 Nov 2026 06:40:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a68048esm49805324f8f.29.2026.11.27.06.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 06:40:22 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 14:40:22 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib7c79652a694313fa398852353bd1719f6ce7634
X-Gerrit-Change-Number: 2361
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2361?usp=email>
X-Gerrit-Commit: f96bbe8dcf0353f457f751e8291e31f550e3e7f9
References: <gerrit.1795790419000.Ib7c79652a694313fa398852353bd1719f6ce7634@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzkwNDE5MDAwLkliN2M3OTY1MmE2OTQzMTNmYTM5ODg1MjM1M2JkMTcxOWY2Y2U3NjM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cff71511e2975e9a31f94305b727f75586600b90-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWx7l-000000006M6-28cQ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnmsica: don't
 reuse the freed adapter address list
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2857178602337440341=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2857178602337440341==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1qNVfbL3jrg="; charset=UTF-8

--1qNVfbL3jrg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2361?usp=3Demail

to review the following change=2E
=


Change subject: openvpnmsica: don't reuse the freed adapter address list
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnmsica:=
 don't reuse the freed adapter address list

If GetAdaptersAddresses() over=
flowed on both attempts, find_adapters()
freed the buffer, then walked and =
freed it again=2E Fail instead=2E

Change-Id: Ib7c79652a694313fa398852353bd=
1719f6ce7634
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M s=
rc/openvpnmsica/openvpnmsica=2Ec
1 file changed, 7 insertions(+), 0 deletio=
ns(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/61/2361/1

diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsi=
ca/openvpnmsica=2Ec
index d2fd9af=2E=2E0ae8992 100644
--- a/src/openvpnmsic=
a/openvpnmsica=2Ec
+++ b/src/openvpnmsica/openvpnmsica=2Ec
@@ -183,6 +183,7=
 @@
         }
 
         free(pAdapterAdresses);
+        pAdapterAdresses=
 =3D NULL;
         if (ulResult !=3D ERROR_BUFFER_OVERFLOW)
         {
   =
          /* MSDN does not mention GetAdaptersAddresses() to set GetLastErr=
or()=2E
@@ -193,6 +194,12 @@
             goto cleanup_pAdapterList;
      =
   }
     }
+    if (pAdapterAdresses =3D=3D NULL)
+    {
+        msg(M_NO=
NFATAL, "%s: GetAdaptersAddresses() kept overflowing", __FUNCTION__);
+    =
    uiResult =3D ERROR_BUFFER_OVERFLOW;
+        goto cleanup_pAdapterList;=

+    }
 
     /* Count adapters=2E */
     size_t adapter_count =3D 0;

--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2361?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib7c79652a694313fa39=
8852353bd1719f6ce7634
Gerrit-Change-Number: 2361
Gerrit-PatchSet: 1
Gerrit-=
Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>

--1qNVfbL3jrg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2361?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">openvpnmsica: don&#39;t reuse the freed adapter address=
 list<br><br>If GetAdaptersAddresses() overflowed on both attempts, find_ad=
apters()<br>freed the buffer, then walked and freed it again=2E Fail instea=
d=2E<br><br>Change-Id: Ib7c79652a694313fa398852353bd1719f6ce7634<br>Signed-=
off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openv=
pnmsica/openvpnmsica=2Ec<br>1 file changed, 7 insertions(+), 0 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/61/2361/1</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpnmsica/openvpnms=
ica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>index d2fd9af=
=2E=2E0ae8992 100644</span><br><span>--- a/src/openvpnmsica/openvpnmsica=2E=
c</span><br><span>+++ b/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>@=
@ -183,6 +183,7 @@</span><br><span>         }</span><br><span> </span><br><=
span>         free(pAdapterAdresses);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        pAdapterAdresses =3D NULL;</span><br><span>      =
   if (ulResult !=3D ERROR_BUFFER_OVERFLOW)</span><br><span>         {</spa=
n><br><span>             /* MSDN does not mention GetAdaptersAddresses() to=
 set GetLastError()=2E</span><br><span>@@ -193,6 +194,12 @@</span><br><span=
>             goto cleanup_pAdapterList;</span><br><span>         }</span><=
br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (pAdapterAdresses =3D=3D NULL)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(M_NONFATAL, &quot;%s: GetAdaptersAddresses() kept overflowing&q=
uot;, __FUNCTION__);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        uiResult =3D ERROR_BUFFER_OVERFLOW;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        goto cleanup_pAdapterList;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><=
span>     /* Count adapters=2E */</span><br><span>     size_t adapter_count=
 =3D 0;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2361?usp=3Demail">change 2361</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2361?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: Ib7c79652a694313fa3988523=
53bd1719f6ce7634 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2361 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--1qNVfbL3jrg=--


--===============2857178602337440341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2857178602337440341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2857178602337440341==--

