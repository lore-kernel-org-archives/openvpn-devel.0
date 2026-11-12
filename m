Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6159606A887
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=E0DRNhRK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VzcqVzAD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cObIGgKD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SSx4gXw2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=LCucfFBRVL8O/WDX+6r9bRig1BRQOFyCBrn+0dUxSG4=; b=E0DRNhRKPB4uuGs7nxzEcIqHfY
	Oe3pKXbMHWOMKiLP6yr3JRfZNUJOJk0dVN4lYJYY72PzERpjM3slN6d1q4ZFKA5jZ6ORBORkOav5s
	hPV/24Dv9swSp4reKsJmgZsXLQmYTjeQ4TXfMGfDCBkOrLrslSguEKWuHfs5PqVTsl9s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRTyE-000000002m3-3sBp;
	Thu, 12 Nov 2026 12:32:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRTxy-000000002lQ-16di
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 12:31:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9Svbc0P3G6UGJnzb8DPGP0znR6brEk2rh2RIOiYeJYs=; b=VzcqVzADK/fEVUyhErBMtWRyQ6
 cX2WmkTtBHwdIe5FkXNYuL6cCpa/nt5rTPTJLRIJqCXJf6BcJnDp4CAMZkm9/d6KxU/3UnBpgFhhp
 zHTq/26LJG9bVhs/Uw/RDMJLjaIRepjD24aG+25+oyvXLrq6HOv83uqIL6PUfC//2yro=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9Svbc0P3G6UGJnzb8DPGP0znR6brEk2rh2RIOiYeJYs=; b=cObIGgKDxxuW/HIDeg+biktf7D
 hCSgLyD1pFxqj8JsR+9Wi9cm/NYS5Y584cHircRngePjO4QkKWjAIpPaYtJuloFVF5Z6w0qHj8KkT
 MeFfEA55Avu5g+Nw2BBVBg2wv3J1C9tBECZUfCFSAZrUqG6zcdyBvqd89bJrixW9C4+I=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRTxo-000000004jJ-2ale for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 12:31:37 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so46144235e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 04:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794486690; x=1795091490; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9Svbc0P3G6UGJnzb8DPGP0znR6brEk2rh2RIOiYeJYs=;
 b=SSx4gXw20KJbsOpwuiZ5Ex59/DgLZjGP5kjytzUZwz2KSR467FLlqa9sO66tnjtSCn
 09HDaTor5AohhrnnS/mrYnaUqqN9aWicwnU0GgA6sycUI6GSoUbFF4CztTzjtd/RYOgT
 fQh5MSOmteGXidJHAqLoTRYb8iklqJgsC4iUUBrxdPXwT0Wpv+2vOjcftSjEoNDBT9Hm
 QEGcNl1ntxv6t81OfdVOkSu12FnMi7srJY6RViwVoLBkfIigaaF6B4tqu/M7RbmxK06K
 2VxuTT4CcFEsAOajBofgpEQL1zYbdsoEVIwwAR1hn8xNjPQZFe4Sh6jA1s625Pw6xr/N
 lMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794486690; x=1795091490;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9Svbc0P3G6UGJnzb8DPGP0znR6brEk2rh2RIOiYeJYs=;
 b=wmxDt4gOmHLPqv2bJBjQNKtjApklCE8NqOg4dXTbtspa3PIEc/twl+iYaOH8bjhZlp
 cJvRT7Caq9gLSvkdQOxQ7+o/Pp/LYcO5Tvi0bdZLj7JKiOgEiUNNh+HCh/bjf+XcD2nq
 2s7/URviPXdaqpWkaxuw16AYeE/5ttKDM9//uvIwPS/eBdtzrt8NZgzYbsnwQWsYBzU/
 qJcG1zUbQRH7YCOeWHTv/+SKmd77n+ONvmcDtczgKpywimYb8BpyYl75kgXa/eaJuSE9
 8f/HEf5ZLKG2spLTava0cwPZKwddhQHSrigBjizwpQMgFRQs8usRNkaEOeOpDnU7Fmyq
 JNug==
X-Gm-Message-State: APuU4Z9Gj3YAnWTFs0tuZY5NmIbw3W8egi0UA8V/YarlPOeVzCCxB+dA
 8gvpMX8C79ju3JkMC2cH3RYWsAX0GLwG88g7QMlQegpxN6tnk6VN5r9nek+OK6Jm1h28YUTYFV4
 vcNYh2PdChwYchFcTxwkrVJ+OyXdjYQnvGJgzAJuBamFnMia4IP/ATWX9anPkNKPQgHOH
X-Gm-Gg: AYBFou15AYCSnu9hBhH2BPnZ8p63UJFOtaDvhdqCruA8IF7AoPC0rB1sOFNfXNoe9e2
 xnqOigLZmfYVcVLYJBgb6Defr0m+QKkHDnB3mKERoVA98ACId11LjvaPc9gud5oeu4TDXh3mWdA
 8iVJR05yhujxwBlmZSCZT10unbwambU9yUtWMlQyfCnzzLmmvqVDFa+M1x7nV/NYnYxqUMr5huR
 6ISt1JqljXIAZf0+Ii9Z1BwxZLTGsQXKtxPmy6aWPyIEw4OP03E0ml/fJTlX+gIBnrTdl7cScoA
 kd/+5SzpPI9mBFpw43RgkrYo57Qlv629QR0mb9awoCApYl2DTST6L6+RhF+eiqXLwJPjkxASNcT
 X8TXKNbdbki6rFMXveNwUJbiEbHqyQWOL4jXAa9IbHZH8msrYHiup40RwnxxzmGfpmFbYSfiqEq
 nkDNnChmkY0iEy7Kaugj2ZITIFFZaE330t5d71nyLZoy5gnszt/BXOxJQWCeqakzx0GVWeIBEKr
 4kvDkNpEpFxnEHfIciXv4h0K7BW60rJuL+zjQxfZbZcv5TCw65cDm1fVTp2TIy0qKWURZxsWA3/
 fB57Re/Ycs/AcnZuoQ4gVyUx+p22Mij1oRYq8EBTLwrECeGG6bWN9cO2iiV9qRDwkLwsHgxOcGC
 OKTAiKAkJPE5DfFlp0xRCfUq+rbxdQGRqRPPkt5P0pUF2lsKuJE6ZfQ5K7SRRXdElrNPq+3C1WI
 e4BuPIiUS7cxgIFDQ=
X-Received: by 2002:a05:6000:2003:b0:490:50c1:f359 with SMTP id
 ffacd0b85a97d-499c708323emr11118426f8f.39.1794486689755; 
 Thu, 12 Nov 2026 04:31:29 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498361f674fsm16794069f8f.33.2026.11.12.04.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 04:31:29 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 12:31:29 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I793327150883ea0207bcb9724341e750bab92474
X-Gerrit-Change-Number: 2179
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2179?usp=email>
X-Gerrit-Commit: bbe3bf4a2299f15dae70f8fd12977c04f99a8399
References: <gerrit.1794486687000.I793327150883ea0207bcb9724341e750bab92474@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDg2Njg3MDAwLkk3OTMzMjcxNTA4ODNlYTAyMDdiY2I5NzI0MzQxZTc1MGJhYjkyNDc0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2051ee013d152242b9c5858dba7b6585bbb0e57f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRTxo-000000004jJ-2ale
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth-pam: wipe and
 free partial responses on conversation failure
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
Content-Type: multipart/mixed; boundary="===============3959388571563474351=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3959388571563474351==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="at7vJMaiR6U="; charset=UTF-8

--at7vJMaiR6U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2179?usp=3Demail

to review the following change=2E
=


Change subject: auth-pam: wipe and free partial responses on conversation=
 failure
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

auth=
-pam: wipe and free partial responses on conversation failure

When a later=
 message failed, my_conv() freed the response array but
not the responses a=
lready filled in, leaking copies of the password,
username or OTP without w=
iping them=2E

Change-Id: I793327150883ea0207bcb9724341e750bab92474
Signed-=
off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/plugins/auth-pam/=
auth-pam=2Ec
1 file changed, 8 insertions(+), 0 deletions(-)



  git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/79/2179/1

diff --g=
it a/src/plugins/auth-pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec
=
index 948b6af=2E=2Ed179533 100644
--- a/src/plugins/auth-pam/auth-pam=2Ec
+=
++ b/src/plugins/auth-pam/auth-pam=2Ec
@@ -779,6 +779,14 @@
     }
     els=
e
     {
+        for (int i =3D 0; i < num_msg; ++i)
+        {
+         =
   if (aresp[i]=2Eresp)
+            {
+                plugin_secure_memze=
ro(aresp[i]=2Eresp, strlen(aresp[i]=2Eresp));
+                free(aresp[i=
]=2Eresp);
+            }
+        }
         free(aresp);
     }
 

-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2179?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I793327150883ea0207bcb97=
24341e750bab92474
Gerrit-Change-Number: 2179
Gerrit-PatchSet: 1
Gerrit-Owne=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>

--at7vJMaiR6U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2179?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">auth-pam: wipe and free partial responses on conversati=
on failure<br><br>When a later message failed, my_conv() freed the response=
 array but<br>not the responses already filled in, leaking copies of the pa=
ssword,<br>username or OTP without wiping them=2E<br><br>Change-Id: I793327=
150883ea0207bcb9724341e750bab92474<br>Signed-off-by: Razvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt;<br>---<br>M src/plugins/auth-pam/auth-pam=2Ec<br>1 =
file changed, 8 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/79/2179/1</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/plugins/auth-pam/auth-pam=2Ec b/src/plugins/auth-pam=
/auth-pam=2Ec</span><br><span>index 948b6af=2E=2Ed179533 100644</span><br><=
span>--- a/src/plugins/auth-pam/auth-pam=2Ec</span><br><span>+++ b/src/plug=
ins/auth-pam/auth-pam=2Ec</span><br><span>@@ -779,6 +779,14 @@</span><br><s=
pan>     }</span><br><span>     else</span><br><span>     {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; nu=
m_msg; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (ar=
esp[i]=2Eresp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     plugin_secure_memzero(aresp[i]=2Eresp, strlen(aresp[i]=2Eresp));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                free(ares=
p[i]=2Eresp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span>         free(aresp);</span><br><span>     }</span><br></pre>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/217=
9?usp=3Demail">change 2179</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2179?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchan=
ge </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: I793327150883ea0207bcb9724341e750bab92474 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 2179 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerr=
it-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>

</body></html>
--at7vJMaiR6U=--


--===============3959388571563474351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3959388571563474351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3959388571563474351==--

