Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D2D606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IZILzx/k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ih1zdjtT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GSmLbwRW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Zd4teMSc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=tL9qCaIjtGgrIlJw6xHL+THbx3VD4nuC6G4ZCz+Oifw=; b=IZILzx/kk4usm/K92HtM1k5u5M
	1hNNRkkFvlVZnL9ad8Vfk48CF6BjvuMaE5iT+7Ft9yAiqZ103GA8FBIRxNQOkJhvjh0pm+QgJXmre
	2I8McUI+ZkFIqB85GAAdi/YPLSoxzmlOjGkeVPM4Xz0vKXoY/NPPkV/w9zFoANVIeq3g=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xONbF-000000007nW-07UJ;
	Tue, 03 Nov 2026 23:07:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xONbD-000000007nQ-2Qys
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 23:07:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bzlTc8xo6oxo4cmmUfwXeT3WUNdXE/V0LfUV3L0J5XA=; b=ih1zdjtTzZLQwowtJCg3bVSY4m
 NuTwJ6XVpAt1Ux6oePCRUsbjow2QlM2E0lXXZ3lVxaJepAK2vZke+tyRQGjWgW/gXdkNOSxnipa17
 Fa7pTbDKejabHcFjhF1wqtit7+iww+vQmOHZ1I/vShRfpXs/gIpr/xvs/0gPDUKpMRsg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bzlTc8xo6oxo4cmmUfwXeT3WUNdXE/V0LfUV3L0J5XA=; b=GSmLbwRWpsYOabf85NBokke5ZU
 GLVX8ILBbLoU+N7bmBGdazbu1Y/NalyOAQvGdP7ZTJFnefVXfy6bz1+M4nyV6tY7O7LuIT69Anhdk
 tOei5tRh+5UaWgP7D8RM1cLO6HssQHKdw96P8tfCMkbGhZiip2UG58NZfyJ/r8XWhvh0=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xONbB-000000002sE-4Bfp for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 23:07:27 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so530575e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 15:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793747239; x=1794352039; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bzlTc8xo6oxo4cmmUfwXeT3WUNdXE/V0LfUV3L0J5XA=;
 b=Zd4teMSczosjzNOBmqYZXAQXX9OR9ERSMmWrE1/pyhwpF/HciG4S46CWhSwYyKK5rL
 /17dhs8aH4guHLfhJ5cOUYXFs98e5fEJXxTIQfDyhIbiyEihhAf7rDX9QeOsSnECzgs0
 4xYA1GyigHscyeh/cXjw218bdkdDwvGWpMpt7UBCp7DL1JkMLicVVVuxeBlLLQ4V/2fY
 lzumIykT4Q+Iqty7H1IKwyJfDOwMFGc4Bn8HWUBdn0U0iJ3nUR1Co/2gbOL12PAD0S1a
 4fWyuAxSGyGJdpXjvr6ppIdGLwJPKyWz04PCE58496OQskVJuQWeIHhYQS57pUQeGnXG
 sEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793747239; x=1794352039;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bzlTc8xo6oxo4cmmUfwXeT3WUNdXE/V0LfUV3L0J5XA=;
 b=t/rklgZge3tQqULfMl5raBViDb2hmUae8aNEciInskxB6Bs5J+9fOQMF3FN4/280VR
 /p3vM1aNxYq+nVhnCGDA0IEtUuTPFxW0S/mV9Z0gcKR9eX4RzjZ0ng9Pf5Uhrfln7une
 xIbqA1LN+8thA+U4g53IDdyzifnS4Ts31dszJ3WkI1rVZh3ZG+zdlBL2i1fER2SJxDxt
 8Gq0VGdnMwYusraoxtKMzJpPo03Fju63iQ3pZSCrLeHwHZieqN9EybAUNfwV9Ga/Nfxf
 EIPJutMLzVOePi1KJd3GmqJjpQYIzly9SzL7fQqjnbbYHKFvTb4a7sfQBNrSPNBe/wON
 aiKA==
X-Gm-Message-State: APuU4Z856CbYSz8cFoDZs5e41Vqrt+S/YV70H3E3qTzHaVoNGxZcvUDF
 5L2KtSddufjLpMDuWMGqPhrigbx94Dj11rVM9iv+eaaeLHUgN+sHpbLLWgdWzQppY1ZcrLTPsfM
 y7OJYzKY2lHPPPYglYmqRLBllYuspjEHTSh0LuuaytvUKuhHqeblHogsH/yf4nA+pQSSrC9m8Sn
 4MFQ0DUQ==
X-Gm-Gg: AYBFou1TwPbNKKa2OjgiXFC2B8P/sMDerr++K6ow6StsXmLKzfwcTHPHAskm2Jxtton
 5kB77bsxSlDhZv92+c4jdzNMGN8+Js8a6t5gTAzhpYaKkxskPXdZv+AGybdrxlCiEviiDNRR6tI
 U6LBobPcna4jPI1NVVQrd912orCPh4/Yp9fVkt+YxEP2iki0qmN2f9H9KLsMx5hX2IGTikHAAWj
 oSkMpmutPXGuZHrXxHGbPA/0IfWu7Bfd+qSYAJ5uFRPnuwddULcNm6USo9OGWmymK9X6Y4neb54
 WSGy6LsxQL329W3280E/QZbtmzZmjLAIE7HKUIt/DY+0kKeph6dhrfgUV5pp8lAJM6YkwlYEMQ4
 mSdnbzHKqfUPKrHCZenH1uyWF/NZjy1DSC83xRDyTcqGiDMan0Xvf/r4ZZPVbZq7upWhgB9KamK
 cZB0khD4Lcz9IikjYdMqQOgYaRa9ttZUPJ663t7AdPaR6n2wvc3olZs08IFEtWIgIAjh54eskif
 Ei/q4M6ypq1b+VL+jExHWNaub74soIHHuB85MbCENSuxfsO2s5yrnkNsNosATpX0HO+9qWgH6B9
 4IU3IdK4vaewdkMj69gPsuuAM7FKWk1dOPXWjdhCQFTLFeFZs04mianLVfYpFXfbV7llPkHT6jx
 NQlXClDZSwfABgCMwiaqaR4ntIOB/Khhu+/VA5+Mkq2i1PYi005xaRxHxrGRiA/6O3W72r0sY8o
 Z+vXdm7YSzfgXo0w==
X-Received: by 2002:a05:600c:19c9:b0:4a1:7c7d:8881 with SMTP id
 5b1f17b1804b1-4ac182dcb6fmr326363785e9.13.1793747239274; 
 Tue, 03 Nov 2026 15:07:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fecf8e341sm487733f8f.25.2026.11.03.15.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 15:07:18 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 23:07:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib65ceb898d23777663c32241156d597918a24ffb
X-Gerrit-Change-Number: 2114
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2114?usp=email>
X-Gerrit-Commit: 2dea0d7f7ae25baf03867e3d5e92e34703000ca5
References: <gerrit.1793747232000.Ib65ceb898d23777663c32241156d597918a24ffb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzQ3MjMyMDAwLkliNjVjZWI4OThkMjM3Nzc2NjNjMzIyNDExNTZkNTk3OTE4YTI0ZmZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f179ae2f0ec3382a3ea27007c1c830e02e3bf409-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xONbB-000000002sE-4Bfp
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: don't
 stop if the next pipe instance cannot be created
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5617431135656611557=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5617431135656611557==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="spTiXcRpyHs="; charset=UTF-8

--spTiXcRpyHs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2114?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: don't stop if the next pipe instance cannot =
be created
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
penvpnserv: don't stop if the next pipe instance cannot be created

If crea=
ting the next client pipe instance failed, the service stopped=2E

Drop the=
 client and keep listening on the current instance instead=2E
Handing it to=
 a worker would leave no instance to listen on=2E

Change-Id: Ib65ceb898d23=
777663c32241156d597918a24ffb
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentl=
ich=2Enet>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 10 inserti=
ons(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/14/2114/1

diff --git a/src/openvpnserv/interactive=2Ec b=
/src/openvpnserv/interactive=2Ec
index bffc9da=2E=2E37e8667 100644
--- a/sr=
c/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -408=
7,6 +4087,16 @@
         {
             /* Client connected, spawn a worker=
 thread for it */
             HANDLE next_pipe =3D CreateClientPipeInstanc=
e();
+            if (next_pipe =3D=3D INVALID_HANDLE_VALUE)
+            {=

+                /*
+                 * Drop the client and keep listening=
 on this instance=2E Handing
+                 * it over would leave no ins=
tance to listen on=2E
+                 */
+                DisconnectNamed=
Pipe(pipe);
+                ResetOverlapped(&overlapped);
+               =
 continue;
+            }
 
             /* Avoid exceeding WaitForMultiple=
Objects MAXIMUM_WAIT_OBJECTS */
             if (handle_count + 1 > MAXIMUM=
_WAIT_OBJECTS)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2114?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib=
65ceb898d23777663c32241156d597918a24ffb
Gerrit-Change-Number: 2114
Gerrit-P=
atchSet: 1
Gerrit-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>

--spTiXcRpyHs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2114?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">openvpnserv: don&#39;t stop if the next pipe instance cannot be c=
reated<br><br>If creating the next client pipe instance failed, the service=
 stopped=2E<br><br>Drop the client and keep listening on the current instan=
ce instead=2E<br>Handing it to a worker would leave no instance to listen o=
n=2E<br><br>Change-Id: Ib65ceb898d23777663c32241156d597918a24ffb<br>Signed-=
off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M src/ope=
nvpnserv/interactive=2Ec<br>1 file changed, 10 insertions(+), 0 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/14/2114/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interacti=
ve=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index bffc9da=2E=
=2E37e8667 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</sp=
an><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -4087=
,6 +4087,16 @@</span><br><span>         {</span><br><span>             /* C=
lient connected, spawn a worker thread for it */</span><br><span>          =
   HANDLE next_pipe =3D CreateClientPipeInstance();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (next_pipe =3D=3D INVALID_=
HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
    * Drop the client and keep listening on this instance=2E Handing</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                 * it over=
 would leave no instance to listen on=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                 */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                DisconnectNamedPipe(pipe);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                ResetOverlapped=
(&amp;overlapped);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               continue;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span> </span><br><span>             /* Avoid =
exceeding WaitForMultipleObjects MAXIMUM_WAIT_OBJECTS */</span><br><span>  =
           if (handle_count + 1 &gt; MAXIMUM_WAIT_OBJECTS)</span><br></pre>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/211=
4?usp=3Demail">change 2114</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2114?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchan=
ge </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: Ib65ceb898d23777663c32241156d597918a24ffb </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 2114 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerr=
it-Owner: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body=
></html>
--spTiXcRpyHs=--


--===============5617431135656611557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5617431135656611557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5617431135656611557==--

