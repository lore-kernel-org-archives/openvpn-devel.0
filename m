Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9BD606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 02:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TKX+32kg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=T9J6w7Ap;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QltHSfog;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=F1iJAo+I
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=I0EmLzWtyAqPXCzPyQb2EOgr5M7t6ZYm6G0PyP+5KIg=; b=TKX+32kgUmsHQ/O+/kF2yBxhl8
	TNvpJY2QSy6G4z/JOAu2dnHr/RTBv0EVCSrfHUrr6uH7lD1QIBzCOC4Z6905Jlzwn3HVDabSgfmTm
	X+VKSoTBnxrTXkVYcYS5hMCP0cliPK3KFa/4SvtYgUt85otSacxwKWtWNJIywpuVvi2M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWlMm-000000008Tt-3RIm;
	Fri, 27 Nov 2026 02:07:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWlMk-000000008Tl-2Csf
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 02:07:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kX/n+Ih+fVdGFvt0aM2HsDryqelwKRIYunqBCemKHTk=; b=T9J6w7Ap3FleKRVuDQKAKiyhzE
 +c0o6qDdWK7QfnceJROj7nW9BKDkXfY3Qg6xjSC8ljfhVYdoH+GIyWNzZmVTqXYkGD12kQ1gfVO/A
 tHk14ioQM96zFlE3WyjjtjdK1yZWyzgmwnD8fDhhWJXutw9Z5B4QVGxmy9NTl+zH1hPY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kX/n+Ih+fVdGFvt0aM2HsDryqelwKRIYunqBCemKHTk=; b=QltHSfogEWBQuG952N04owEd/T
 onAvv0atmoWDLvatQFWEfFyefv+l6Hp0R73SgOGL8yz8/JAnu0/Mzap559L/jjvPvG6OyJ5XVuPj3
 NN9FVKzDyj+Y6QVgeySsqojv+2AfFtSyN77F/DQMRAIsQ4G1oXutkwma2aTvT9Rg7lIw=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWlMg-000000002JU-2Mci for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 02:07:10 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb6ba3b244so77661545e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 18:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795745220; x=1796350020; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kX/n+Ih+fVdGFvt0aM2HsDryqelwKRIYunqBCemKHTk=;
 b=F1iJAo+I1PbF8+WhRKnjza62PH6mRVCLkuVEJG3mMGzgBZvVmcimc60DC53tGoLJZc
 0NxxipfAYkFBEuXRC45oVp31tT6hwds5Z6GL8VuPNqflxrZw8nghkUyPANLqW8eCuQ5n
 irYccVd2cxYwQAKrzJNNogdTXBLm7TdQy2go4wh0ULY1lR39rlArhYDyzS5bkqgT5gsp
 sEqsncVMPuabuXpEZ0rw1dr5q1JYw07gEl93rGQIycugHEFMie7memE/L+v9venjxm9F
 WcvJk25UATlvSS3DfGk+KE0vZie3VNAtHqmFvtH3ZZRlI+YTTSVSJPYMGLCQVmlfU2wI
 UirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795745220; x=1796350020;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kX/n+Ih+fVdGFvt0aM2HsDryqelwKRIYunqBCemKHTk=;
 b=ivlaOlc5qv1W274OPLZ1n6yjVecR9wtl/P7cx38SfRs9JZQWcUJ53mHrjVMly9QhAE
 Fio6OjXsWWr4Vr6ourk/BC+A7ixYndeRdjTUw9RaAkHogNdLrHfMbS5fWpViz73ZenHQ
 YmVEbpjdoLKxU23+rZLlol9o/EbX87OBOXFXGknu7Q4GoOj9lR2U7+MEsoAvryWg71NJ
 DvYT1kB498Qel0qLUjCX/wrnnD2GQO2QNIIrNOtsnhtPsSrvaD7R4Lwef7+RM5gO6Xj2
 kLKZNNAtutezqYB0MOZML/3Bpc2YvcQdnQVgaSenJcunpwHwuV3kd+Lq3YHCtqFtoU4T
 N/nQ==
X-Gm-Message-State: APuU4Z8VckhEyrk0ELxU+m3R6Lxi9Iln84xbUQVJRUT691KbV9Da8gyr
 REwunUFCmzm96VSCcQrgfgab8kqC5c1pjCgaehRh57DGSsP8jC+G6dNbD+EW2PXlHlXsk7cowj6
 myjzA6pJluINA1gT99NAPoVzj8Zw6fFxp6Gt4GVU4+yuuHh9O9FIaKz8qK9lDwX+p2TTb
X-Gm-Gg: AZFdTZfYg24HU4tgcXH4YT5QI9yvHiPSNPkv7irP30ZK77ViPUWh6isC9ZVU05Qeoko
 bVJxE+rNrD6Nk3LBnSPStg2EMHudia5PPEUFswsrpE/7SpzXM3CSNZ/tx0L0GpLbFMdCNRKsqCA
 i0OTnnMpn42v2PCHFTZ5B66iKnr3ROtjOE0UeX9R2Ve8rjFuw+21mVtpSv4QHJpH8DXvVwhb8TI
 OtZ73E0jHshbISHxq5ITU/1ui3+gmMQi7JKgVd84SND12swGfsuc+2tIU94reTIWoWl9SXVlHR+
 6Cm7iirMkU4n8IHVqFP2Yf5L2vpe4r/QQqxnmfU/H/AKkkdS6oCYuH+I/CfSHiX0ZPHvHSQmYcT
 YyVkDuPeyFPM/Xd6/W8d03v+OGfwel6vAClRFXrHMcIU8cBFvYsKXQPCBFJVuFro/8zF3Glm6Qo
 uMgUNKiBn58xG5kPGbaBsdc3H3zZPFMYLO2auPWIRSEDb5ZEPV4Z2kCXw93IaF4g60Q+2dvAeKH
 s0jqHfLxiigaIVBvGjBZxfrCbMM88E6LNf74Lhg7tq8UvGRyNWzjhHNP7oVj0BpxPC8qVdes+SF
 Af8f6zrYfFq8sgaNIkUXx+OkOvMFKjlPBJTIKML2SbRFKNKVX4taVXwuWynbw9oSlHNt2avxWa+
 bXKV6Z7uwq65kdW4aejWjISqL3nm5UuU1zX9zsjOlUDQF15EGJfoZ5Hh0wYtjteYj0w8THkMeQo
 JiK8vNccEvaulSQGUkRYeIYRh5jsNuPSu8V03sRQ==
X-Received: by 2002:a05:600d:1c:b0:4a4:fc8c:cfd9 with SMTP id
 5b1f17b1804b1-4bb9de0d5ffmr211129065e9.25.1795745219967; 
 Thu, 26 Nov 2026 18:06:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442693sm586219975e9.1.2026.11.26.18.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 18:06:59 -0800 (PST)
X-Google-Original-From: "Max Fillinger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 02:06:58 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6c6dfed1557608d5b1442fb008bf84fa4f948579
X-Gerrit-Change-Number: 2359
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2359?usp=email>
X-Gerrit-Commit: 629b843c843ffff725f9de551b2568f21abc2d4e
In-Reply-To: <gerrit.1795743323000.I6c6dfed1557608d5b1442fb008bf84fa4f948579@gerrit.openvpn.net>
References: <gerrit.1795743323000.I6c6dfed1557608d5b1442fb008bf84fa4f948579@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzQzMzIzMDAwLkk2YzZkZmVkMTU1NzYwOGQ1YjE0NDJmYjAwOGJmODRmYTRmOTQ4NTc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8041a509ddba12f3c1c088cd48eefbfcb2765673-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWlMg-000000002JU-2Mci
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Mark as private
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Max Fillinger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Max Fillinger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7142065145598389142=="
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7142065145598389142==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/MoVOi/Jx6g="; charset=UTF-8

--/MoVOi/Jx6g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Arne Schwabe, 

I'd like you to reexamine a change=2E Please visit

 =
   https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2359?usp=3Demail

to look at =
the new patch set (#2)=2E


Change subject: Mark as private
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Mark as private

Change-Id: =
I6c6dfed1557608d5b1442fb008bf84fa4f948579
---
M src/openvpn/ssl_verify_mbed=
tls=2Ec
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/2359/2

diff --git a/sr=
c/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec
index=
 bba2f2f=2E=2Ea92897f 100644
--- a/src/openvpn/ssl_verify_mbedtls=2Ec
+++ b=
/src/openvpn/ssl_verify_mbedtls=2Ec
@@ -74,6 +74,7 @@
     }
 
     /* did =
peer present cert which was signed by our root cert? */
+    /* dummy chang=
e */
     if (*flags !=3D 0)
     {
         int ret =3D 0;

-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2359?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c6dfed1557608d5b1442fb008bf8=
4fa4f948579
Gerrit-Change-Number: 2359
Gerrit-PatchSet: 2
Gerrit-Owner: Max=
 Fillinger <max@max-fillinger=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>

--/MoVOi/Jx6g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Max Fillinger <st=
rong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2359?usp=3Demail">View Change</a></p=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Mark as private<br><br>Change-Id: I6c6dfed1557608d5b1442fb00=
8bf84fa4f948579<br>---<br>M src/openvpn/ssl_verify_mbedtls=2Ec<br>1 file ch=
anged, 1 insertion(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/2359/2</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbed=
tls=2Ec</span><br><span>index bba2f2f=2E=2Ea92897f 100644</span><br><span>-=
-- a/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/s=
sl_verify_mbedtls=2Ec</span><br><span>@@ -74,6 +74,7 @@</span><br><span>   =
  }</span><br><span> </span><br><span>     /* did peer present cert which w=
as signed by our root cert? */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* dummy change */</span><br><span>     if (*flags !=3D 0)</=
span><br><span>     {</span><br><span>         int ret =3D 0;</span><br></p=
re><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2359?usp=3Demail">change 2359</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2359?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newp=
atchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I6c6dfed1557608d5b1442fb008bf84fa4f948579 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2359 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--/MoVOi/Jx6g=--


--===============7142065145598389142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7142065145598389142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7142065145598389142==--

