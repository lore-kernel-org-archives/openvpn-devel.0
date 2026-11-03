Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B6F606A32C
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DOI0kfJI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hTaA636o;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HdnOSOfv;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AzpMU0WA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=iRd6YucoZ7AO7Y+CgHeSV7KB3YoH4UPznHjb9gUd5/0=; b=DOI0kfJIjbUqAY/hos4Ksbcg2B
	tBqeugST0wUxoSPprjvEojjy9Yz9XE/nl7ZqCedyC5i57wmPf5Sjf2V9fOB2ZIh+e4QGbSYqwBWP9
	xid0LutVXCvegRhF0BPk3nkAD4TWUqfgaw4VvRrbWZC0EYsQ0YzfLLdnu5Uupq7usIXk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xO7iu-0000000058V-0HoG;
	Tue, 03 Nov 2026 06:10:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xO7is-0000000058F-2sMC
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 06:10:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R4SrsSftKeqVZwr9Qg6ZkMEbfu+wRaHtY+uGM+5lS+s=; b=hTaA636onVZpmLaOfWGfpap+Ko
 YSF5dmIjQWLrZPzQltkxcGb7Nrn1Lfi5PGiLsVpAv52BcEz1vDVXrhlYYRyqnTDcPyrwoAxbJN15N
 GFs0MOQru71m3kzybblXOAvFbZDD1kDrBv+cbHSnEXoP0FP2hJghi6CF0tsh0sdRpSyo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R4SrsSftKeqVZwr9Qg6ZkMEbfu+wRaHtY+uGM+5lS+s=; b=HdnOSOfv3ee9SRzNx1iXI3TZIN
 Ul+SWQ9+wmlaLtPTOR8heKTqPENOjgkoz2VTfCZ5sT9AgysFSI1flCo6eV9mCDVC159yYboyMuV1q
 UdYz9e7Q+dS6GA5Jm1MPIlgvbEO1NBqRQl7jAlDlkXox1ye+GfUPQ6KQ4r8M3+RFRil0=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xO7iq-000000000li-3gVS for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 06:10:18 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so31178205e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 22:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793686210; x=1794291010; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=R4SrsSftKeqVZwr9Qg6ZkMEbfu+wRaHtY+uGM+5lS+s=;
 b=AzpMU0WAeWitJKUD3JLXRW/YiQbGYNOFAXO7ndC7Zz2xt+qPCrL21glx2QDrATOFWT
 rYBevKAvpz6en0qSKkHM2Sef5PaJQqyi76xENd1JeNjviqFeCWoQnYJD2vb31PtBDk23
 93fgNr7wPXA/DTR4FHtdWYo0kWFGa4rJlnxZn8MoNRiK8gLPpub2dcwftI0nL63Qd4BS
 Moa6/UxdReGmvT/Qot+eY/0EgpdczjJzxE2VDUV7JQBsWSiN/Z86UZC16phRqqBp8vj9
 Tn1psHEssMWNL6FHIZF8ujLgBM81m8WbjGhJedPAJAuGBlE0dBd/pkhui+oUVIjDSMaj
 uXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793686210; x=1794291010;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R4SrsSftKeqVZwr9Qg6ZkMEbfu+wRaHtY+uGM+5lS+s=;
 b=WX697QVpY0apx7O5iaPTMZm5PubGjZ2uvXPx9c67ENdW4/U3mDm+ydh7KAv8WsguGW
 EbmIVIelKNsa3RFwKQ/qAgRpGB1CA9qw68gwiat7Bf9JZQaTjrAnizmZfmOZf8b0Vhj0
 hkaDKDLPQId3/6UAYfiPKtYReqCtZCy8zhRxBkzw8GtKBWAQ1IhD6Xq7et8qzxT3hlFD
 RZrjmrgjiuXyPt4Zfbk73zSZE8lNpfr/EplJ35DwSKlAGwfg/lGJBgDqg72xXJQT6mi+
 GJIkqC/krIftue2hmdj5aEQ5JVOIe9jx7P0M306EsgU2v4OcSBVsacVl8dLR2ihuZKu8
 jSzA==
X-Gm-Message-State: APuU4Z8RWbbi8QI83i2acqYtLoFeGobXVuHVeGg08uASYjYB2CgPzeAI
 EWngtJ2JkqtcbFZiSrzJnAon6pxxivC3rfR199CJRT6rayl2OlhCkzmmZG+A7hmBPr4cNEMPRvh
 VQgI0OzyO8YdoeoKnf9qbxYYK9XEn++sTtL5teaE04r41vFaupR5LbgaS2QttLCeBJUb5wvvmgL
 xCHew3Jg==
X-Gm-Gg: AYBFou3VGvc2bmRaoRVFp78GesU071zleTWs8Bwb7H6tz7gYkPQxfHodF5Tpy+akO4i
 b5XLJ104fGfndyqFKp3loGbZT9p8K9LYPWekiZ9ypHQU5ucOcr2ij1/F7ny9iELVtYmand7Tsya
 OQ5BU0yOH9db4dV3zHQzyk5n3M8VIEKUnSOC721KIm482XRdpacog6nLqKtxZF5fVZ6QdoYxLGV
 jC0hed3BD+hrgSx5NLMW8ABGdM+6NV7hc4LKZf1RvYXyJHp+eWKZGnL5ouB8wT/03lXQHteOARH
 rI3Qeg4NNW+q4YXaFh7M+yo4HjLJgtWwMjfoa1Eyf98xXPjZ64NaFD12aV1KTdYKOVQJcRTeNg7
 TudRNUbeMxp8WPOuHg7vPJ8E3ksvWzzfEA+R/vRJs264eRWv/CeXFQYWuwRpd02xG8W+LaJ+365
 9jtM72R2HOHHNCptJuN+r+nOPLtkc5dXQMRTGeUC5tjK9GXIjlv7F8uiyCJKvh9FldP/WptqFKX
 wIKsdlnAub/JAr5mAyrFAb/k2wO+CXtPvLCp75AoET6hYTMDDVzjTGslpVR4gtsbUmtnlEZfupE
 qGJ0+IXEKuJvdTAm2Sq41VeM2nU4LfJzyHO1MfmXN79HRePNa1l/PqHlILphK/I9lL2BCMuRBub
 pkqsmjTM0g4QFUiHZ+qCboJEghedpX61rxn2nLa461wU/4lS5j++ZjWvb8oRGM+mqn25yYsM/Wz
 +7/f35AEqGSDo/EiU=
X-Received: by 2002:a05:600c:4e90:b0:4a2:526b:d410 with SMTP id
 5b1f17b1804b1-4ac17565fafmr285527745e9.13.1793686210306; 
 Mon, 02 Nov 2026 22:10:10 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa5781c9sm35041435e9.8.2026.11.02.22.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 22:10:10 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 06:10:09 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iad78e78cf51812c392f53cd58b33b54cb99cc6a8
X-Gerrit-Change-Number: 2097
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2097?usp=email>
X-Gerrit-Commit: 7aadd396e305f8cc1b26497066b6601385a62b1f
References: <gerrit.1793686207000.Iad78e78cf51812c392f53cd58b33b54cb99cc6a8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjg2MjA3MDAwLklhZDc4ZTc4Y2Y1MTgxMmMzOTJmNTNjZDU4YjMzYjU0Y2I5OWNjNmE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1156c686ef11f1bb7bde78e236f822bc7f9c497c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xO7iq-000000000li-3gVS
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: console_systemd:
 free argv when openvpn_popen() fails
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
Content-Type: multipart/mixed; boundary="===============7454975631327590904=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7454975631327590904==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LAoqzVOX6g0="; charset=UTF-8

--LAoqzVOX6g0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2097?usp=3Demail

to review the following change=2E
=


Change subject: console_systemd: free argv when openvpn_popen() fails
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

console_systemd:=
 free argv when openvpn_popen() fails

get_console_input_systemd() returned=
 without freeing argv on popen
failure=2E Free it right after openvpn_popen=
(), which no longer needs it=2E

Change-Id: Iad78e78cf51812c392f53cd58b33b5=
4cb99cc6a8
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src=
/openvpn/console_systemd=2Ec
1 file changed, 3 insertions(+), 3 deletions(-=
)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/97/=
2097/1

diff --git a/src/openvpn/console_systemd=2Ec b/src/openvpn/console_=
systemd=2Ec
index 9588b95=2E=2Eeaed24e 100644
--- a/src/openvpn/console_sys=
temd=2Ec
+++ b/src/openvpn/console_systemd=2Ec
@@ -69,7 +69,9 @@
     argv_=
printf_cat(&argv, "--timeout=3D0");
     argv_printf_cat(&argv, "%s", promp=
t);
 
-    if ((std_out =3D openvpn_popen(&argv, NULL)) < 0)
+    std_out =
=3D openvpn_popen(&argv, NULL);
+    argv_free(&argv);
+    if (std_out < 0=
)
     {
         return false;
     }
@@ -81,8 +83,6 @@
     }
     close(=
std_out);
 
-    argv_free(&argv);
-
     return ret;
 }
 

-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2097?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: Iad78e78cf51812c392f53cd58b33b54c=
b99cc6a8
Gerrit-Change-Number: 2097
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>

--LAoqzVOX6g0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2097?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">console_systemd: free argv when openvpn_popen() fails<b=
r><br>get_console_input_systemd() returned without freeing argv on popen<br=
>failure=2E Free it right after openvpn_popen(), which no longer needs it=
=2E<br><br>Change-Id: Iad78e78cf51812c392f53cd58b33b54cb99cc6a8<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvp=
n/console_systemd=2Ec<br>1 file changed, 3 insertions(+), 3 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/97/2097/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/console_systemd=
=2Ec b/src/openvpn/console_systemd=2Ec</span><br><span>index 9588b95=2E=2Ee=
aed24e 100644</span><br><span>--- a/src/openvpn/console_systemd=2Ec</span><=
br><span>+++ b/src/openvpn/console_systemd=2Ec</span><br><span>@@ -69,7 +69=
,9 @@</span><br><span>     argv_printf_cat(&amp;argv, &quot;--timeout=3D0&q=
uot;);</span><br><span>     argv_printf_cat(&amp;argv, &quot;%s&quot;, prom=
pt);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if ((std_out =3D openvpn_popen(&amp;argv, NULL)) &lt; 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    std_out =3D openvpn_popen(&am=
p;argv, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
rgv_free(&amp;argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (std_out &lt; 0)</span><br><span>     {</span><br><span>         re=
turn false;</span><br><span>     }</span><br><span>@@ -81,8 +83,6 @@</span>=
<br><span>     }</span><br><span>     close(std_out);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_free(&amp;argv);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>    =
 return ret;</span><br><span> }</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2097?usp=3Demail">change 209=
7</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2097?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
Iad78e78cf51812c392f53cd58b33b54cb99cc6a8 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2097 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--LAoqzVOX6g0=--


--===============7454975631327590904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7454975631327590904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7454975631327590904==--

