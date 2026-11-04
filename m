Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9384606D814
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ldcjdvLC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kT8TPSZr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BAgUz4uG;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ClcLCewV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=TZ093JqkKtX+8hVqGSohBdektvrCcF+TunmP3Fmn8tU=; b=ldcjdvLC/hRE7rfZAHSKVi3CTY
	NwM6j6S09v6f6p3anyVPWydf1j/millcVoUpBe8Jhhkig1uClEuQBzuZeTV7cMeJrlMXphfAtP+TK
	To7pFSHZ10KCwA6waGaEBav0c/iWriXjgzaZdyR1bAxfAkEtIzKn/Gp5qC+m6v+gBdGk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOVKe-0000000075Y-0v1h;
	Wed, 04 Nov 2026 07:22:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOVKd-0000000075S-2Q5H
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:22:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A7BMp/4Uxq3dI6/nVL+Gx+IAGkzVCBcYzFMm4MtlmrA=; b=kT8TPSZrfYmewZRODpFzwyZFMI
 JZUAYQthhdZh0AmWYutt8Ys/aDymLs8CeW2pdKFlX1lxhTkLvMhEejeTB3Exk3CE+gZTt4zE6x/Y1
 bOschHNMB2n7KA37tzI35aUBIgH7dqntgfxUCE1L7Emcvd5Jsuq/irSEMp7ewmfGNV1M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A7BMp/4Uxq3dI6/nVL+Gx+IAGkzVCBcYzFMm4MtlmrA=; b=BAgUz4uGrr1UmVkKLHcLpGU0do
 2EKHck+XkzTs/+PjZ2WRdjt+5YwSwA4pR3espacnYQ2V/Ic+2P1J8Y/nrU4sM6+5oZbBAyamuGjy4
 tcPO/gmlGqPjc/9F2WWOsk8poUEyw5I+naTNvQHoq0eEvHVEudNBYlPSkpSE2qvRKUN4=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOVKb-000000008E3-46mV for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:22:51 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a2d6cf958bso1069785e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 23:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793776963; x=1794381763; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=A7BMp/4Uxq3dI6/nVL+Gx+IAGkzVCBcYzFMm4MtlmrA=;
 b=ClcLCewVLCDQx6iBm4tsX49MBv8dFQ0MCqfbak1Odtga9BMas2dSixM3S9XCucMFxX
 GCWpf32Us6xlqR5IewIclzSO0J0R4Nnm/gt9n81ZLAyRzdF0ZDGtYlCecbKdW17m90Jr
 LuGUfUX0Flne775YIapWhkyJhSLeg0cMkbT3uW9mn4at/ZhtoVtMmWELOxRe3SA/grcp
 fbzjSeHNahZogsRnvI2uP4KKejGgs5mJMcMq+4kwulzjq2gGW+mZmvYk1+/eWVjNa+5j
 9h5MfUIDASadLxKY6lv4hOFP+PZrqCFuLcERlpnNoxS0Nqm7Vyu2JZo7c+JrmlMD1bmi
 kiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793776963; x=1794381763;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A7BMp/4Uxq3dI6/nVL+Gx+IAGkzVCBcYzFMm4MtlmrA=;
 b=bf9c6NoZZVZsJZ18P4PG8+3+5Uzkc9J4p53WRNCLOjvE1ert9Eo0cDk6fD5RlswzEw
 vSVsObk0aYv4oeK4N3qr/2Vw7TV25bCilexu6hjXzArhcQGIXAOU9UPRBUsXJ280VFSJ
 GDTx5UAgRqg0JCLMpOH09FqTGf8rzQPT4glZkemEnYQBpallcaMw9wA4vK/KeYLDdx4V
 NBpFAy6Jsd4oa2eUybPCKk0WwR+3K4MocOpJCIB+T7DjKVuF1Mcswh0pWSvgOwcgm4HB
 aC4Phy0cinuxpJ4vBCbAoRB7j342XBMMuWWVTtepoLSwL6axxFsqhzDtwsFH5QI/vs1F
 1z3g==
X-Gm-Message-State: APuU4Z+bnilngnilzSbSEZ1AgWn9IrqbV/OBcmEB/pUplBTUh5oW9hP5
 euTcEHl6sFBjnsTtZMhJ7ALkhFq6C5F84r631ss4udINFFoHlAfP42eJMthZvGNr4bSuN++SCZC
 8oN4mw2pZ1WI3Xf6LcC57JLWe3Wn4qUEsVTfen1+aKnTLoa1MUh71G+ONQ84pAZxGykOm/sqLwg
 Fg6n0HVw==
X-Gm-Gg: AYBFou3wazzt5gkSYnFpC1qlUIvw/VfN/RLJuk1d3OQu6e6ZkpgyeKDF7FODamFnGi8
 lvDPRFHnbt3yEdNaFlCyFZRD7Kia86rwizwGMQ9tKcjugKyvoYdLVbvptcjfZUTbvE5AgZemnDg
 WJQ9Jf1bfFEJeLksZomnk8VAaoqLz52yPFHZFcJKxEDVcQj5Z4msjaMSjOvVVKZA0c6uSaji9Ny
 o6DwMag6XnmFIkQ6If7ThJ9qInMwfU1+8e/FkadG7oEGbQVN9OVP4s8pgPpL7jeTgstfm5QG6lR
 AMGJEWHsrCWMErtlDzlHaePlRSLJQ3jXrXa8hTUHtlLZppAGZYcvVL22XtjblZt0tfimQTEMGMz
 vSTacgFJBWnNY+VXSFqjmKbQP6oNA4FNVtzvSpaUV0kRUbNx3Ya4hNmCv38nkhQNCHZuRRAwSfH
 O0qFzaMY75iNkl6Vh0RJpu2wYwg5PTqM5tiSYl08OY44CwUw0A/Bs3vSI05ePzOG8VyE5mHotFK
 ZqsWppi/3N86OTYFW9iXaXC1bUlQoWEGMM3IKM/HVSRcIEaUTe74MtqwcvH+GfbuKeACMwx3WAT
 25z5KuZsAmTGCYAHpEQgAelmG7vbd8HuA3WDqNEeJefVfIgb558WLC7coh60jpdB19ORBHcVgG5
 BYlpbG7S6z7mgtM38bcUZhxbKV2qyEENMbiJgYurNz50iVvGUH6nCFUDKjJWn3gc0k7E2Rrhizk
 tttvBxZZOCtBvX2g==
X-Received: by 2002:a05:600c:638f:b0:4a3:59c2:b41e with SMTP id
 5b1f17b1804b1-4ac150b304cmr344376265e9.4.1793776962207; 
 Tue, 03 Nov 2026 23:22:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed45d7f7sm2260638f8f.38.2026.11.03.23.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:22:41 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 07:22:41 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8b9efc75656e01df9afe99c280ba8c9c82e937f0
X-Gerrit-Change-Number: 2120
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2120?usp=email>
X-Gerrit-Commit: 476ca73437086cce61452a674af56d625672386d
References: <gerrit.1793776960000.I8b9efc75656e01df9afe99c280ba8c9c82e937f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2OTYwMDAwLkk4YjllZmM3NTY1NmUwMWRmOWFmZTk5YzI4MGJhOGM5YzgyZTkzN2YwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <03b92e8882bdd34289ee9f1a3385a102746f0398-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOVKb-000000008E3-46mV
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: log the actual
 error in Windows tun_read_queue()
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
Content-Type: multipart/mixed; boundary="===============0894204529488352370=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0894204529488352370==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UnWRhRAB7p0="; charset=UTF-8

--UnWRhRAB7p0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2120?usp=3Demail

to review the following change=2E
=


Change subject: tun: log the actual error in Windows tun_read_queue()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tun: log the act=
ual error in Windows tun_read_queue()

The read error message passed the Re=
adFile() result, which is always
FALSE on that path, to strerror_win32() in=
stead of GetLastError()'s
err, so it never showed the real error=2E

Change=
-Id: I8b9efc75656e01df9afe99c280ba8c9c82e937f0
Signed-off-by: Razvan Cojoca=
ru <razvanc@mailbox=2Eorg>
---
M src/openvpn/tun=2Ec
1 file changed, 1 inse=
rtion(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/20/2120/1

diff --git a/src/openvpn/tun=2Ec b/src/openvp=
n/tun=2Ec
index 225d8b1=2E=2E10f738c 100644
--- a/src/openvpn/tun=2Ec
+++ b=
/src/openvpn/tun=2Ec
@@ -3305,7 +3305,7 @@
                 tt->reads=2Eios=
tate =3D IOSTATE_IMMEDIATE_RETURN;
                 tt->reads=2Estatus =3D =
err;
                 dmsg(D_WIN32_IO, "WIN32 I/O: TAP Read error [%d] : %s=
", len,
-                     strerror_win32(status, &gc));
+              =
       strerror_win32(err, &gc));
                 gc_free(&gc);
          =
   }
         }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2120?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
8b9efc75656e01df9afe99c280ba8c9c82e937f0
Gerrit-Change-Number: 2120
Gerrit-=
PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>

--UnWRhRAB7p0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2120?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">tun: log the actual error in Windows tun_read_queue()<b=
r><br>The read error message passed the ReadFile() result, which is always<=
br>FALSE on that path, to strerror_win32() instead of GetLastError()&#39;s<=
br>err, so it never showed the real error=2E<br><br>Change-Id: I8b9efc75656=
e01df9afe99c280ba8c9c82e937f0<br>Signed-off-by: Razvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/tun=2Ec<br>1 file changed, 1 ins=
ertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/20/2120/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 225d8b1=2E=
=2E10f738c 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span=
>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -3305,7 +3305,7 @@</span><br>=
<span>                 tt-&gt;reads=2Eiostate =3D IOSTATE_IMMEDIATE_RETURN;=
</span><br><span>                 tt-&gt;reads=2Estatus =3D err;</span><br>=
<span>                 dmsg(D_WIN32_IO, &quot;WIN32 I/O: TAP Read error [%d=
] : %s&quot;, len,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                  strerror_win32(status, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     strerror_win32(err, =
&amp;gc));</span><br><span>                 gc_free(&amp;gc);</span><br><sp=
an>             }</span><br><span>         }</span><br></pre><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2120?usp=3Demail"=
>change 2120</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
20?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I8b9efc75656e01df9afe99c280ba8c9c82e937f0 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2120 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body><=
/html>
--UnWRhRAB7p0=--


--===============0894204529488352370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0894204529488352370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0894204529488352370==--

