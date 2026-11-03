Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7F2606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CzunPRYb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iAG35rqM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hFhwU2BZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Sf37Mb81
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CPdaLYaQzTM2zNYujkQyVivMsyLYRxeV/NF3DpJaegU=; b=CzunPRYbGZMKdXS2h/KIf9FJn9
	PTZOgBwNR2nyUkcxPHMr7Ukb2BAkL7LmdwOIR+akH4m0swBopYi4+2VSgoUr2yUGTHcSrznDS5NQz
	mCM1R9+YCg67tGa30C3w5TsRtk7fdPQGSqNvyqtzMRz6sbdN0b4Eibclv6sBZyWouJ0s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOI9A-000000004HN-0GLA;
	Tue, 03 Nov 2026 17:18:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOI99-000000004HE-1JiT
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:18:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=32ds4/cJDLfBRYlrcoEmwVKZ4k046Laj0pVpUThaZbk=; b=iAG35rqMPX3XqS2trn3/pL0Y4i
 b4gWPILPIr9dYX1qNlZYGJ1T+0PIcQVYVfTlEEYEEAw8PP2MPn0iQ98VMl2wRhoIhGSjNY/Sgdg5N
 j+fI3+nGxYKXsdcO+izPi64o2xzpbGzwWit52p33vPssjdIxpKVA65DjXwoiNaaQcHtU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=32ds4/cJDLfBRYlrcoEmwVKZ4k046Laj0pVpUThaZbk=; b=hFhwU2BZJqd1S9xEOuG8UdMeom
 cfPGbKVUrwVTO7ydEANPyO5z+saOdu94f3D8I0U+SmM7zHdFbfI5v1dLwKrrpxElBibNFgzSEGXRt
 9kGKCfLzaRzlh2lNSFHC+p0kwUp1gGcwidqmIQ3yV3weu7zYENqEANqHYaDgFG3WzanU=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOI97-000000000y0-2rs5 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:18:07 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so2425793f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 09:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793726279; x=1794331079; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=32ds4/cJDLfBRYlrcoEmwVKZ4k046Laj0pVpUThaZbk=;
 b=Sf37Mb817+f2vONT9tNZFsdV0ksWZ/p7L1DfYXMDDirr4cNV9LWGhUwTnEc38Hly9Y
 2Rpv5AmTtqfMrNrABLEPIWVyVVpxwMqwXLilXxBawKdSv3z6kpl/7ErpMGbssZ6RJIOZ
 DuH9AvaxO07BzShU2c/XKCZ461mCvB2peezz4e9T0eGw/YjisDtYimAd9aIZNaeU//KG
 Aei3/iKT2+oWBDpvdKhmmljRdI2WViSPjRmbiRaOexJnmTpFKOxfoANRvior+mg3SEGx
 YOpACYBWkK8PN1+6WUMOs+KZmXuPmftkuY/TfWBOSXLmM865LaMZS0gbo3j6WfXOOZeN
 gPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726279; x=1794331079;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=32ds4/cJDLfBRYlrcoEmwVKZ4k046Laj0pVpUThaZbk=;
 b=D1jqvu3gm5fxKVYDwaUhj/wTN0cd1c/qw8+rIXM6VY9+am+B7gsbA496fOgEF/gmg/
 LqJ4qKm/E5pAL4ySTkMOQmYeNYy7KlipjIhb/srC/rG/AOlNeYavfffpbUQS9TpDcKhN
 4CsOUuL9mD9Hll8PEkwAxpo2b6JAKaeGJ+fvwXlhcA9rjHJwHxwcs511fHnA7rgZiEjL
 t0UB1bL0KCg7qcByFbkTovh9fiAl0HsBfBjqGqMAVjZrsFxf5QDzDx7Ay3RiE/RaWdEa
 oLPx5Y4PCLY2GboX178JminVS7wK3zB0outT62Fpi0D9hm8gRVoetc267tpVkKGPcnnb
 a/og==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3wShIDwPo64nWgiBEEP33YEVdOGaSQLR37hGNkTssjCSBfDAydYm8nLP0ipcb4wB1EeGy80xAbvuHCTBt@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8zn38RyIXZz328aDaWU1ESzhUgeH4AnSJukEOLGj4c0mwrEDDA
 ZQfwO5hkKTE8katKFFuc9nNCOWkrUA86w6zlJOKmXK+Bb51P0QrFWFNod7EbI4F1OieqQHiQOCG
 5da/HKRydDB+NLHNmt0e3UTdl7kgVluHhSxAM06PBbzDDTfGBtPlTRSwTalnh181IFqAH
X-Gm-Gg: AYBFou1qrBqiQ/2wxZL7FCwZVrGXPt2h2U/P+8VYb2SqRSvTQsVaV/WUP+PoWpZ9BBj
 OjjsfXJcfbrmdK4yncajBla9TQ0dVUU1HoxZtJE5rM9mh1+PmGV+BSJNeZ4/I/fSr2sH7u/Z13w
 lvFG3JnhmBdbgkK7GOAwqK3Qso9f7Cio5Tq7OQZ+p2xXVaxog9uqSkoVmHKWKz2mnve6ggcz3OU
 DVDRjfz6m1ZYpJllphJiMuw1LsFbWDbGlE1GuCs2k2nACQy8aVs9tGULm4xNrQO8IRWUqYrg0qp
 yQkaE4gGT9lOT18muaDBQkgmrzNHv4wiBD03/2j6WpRfVKR+B4ZiZhXEn2edM3tuDqj9OHMSBkh
 VVx3GspHfHbYwmIIzxLe0++Z7Z/tbg6SlayfHQOJmOJuX/5cJqNoJ0d25bWtwiy6Pj8NLbWsAu8
 bLxy6lUSvdYNIO94owZ1HAzk49Z9JZ54vzU/GmDDY6hCncLFAdMpV++elTb46WtouweZg8IyKGI
 k5UfoLMrItqX0ANRSAy8taKvvlu4rCxmZwJ/NGssiXmpCQxrWUGgcR4aHxSZi/qqmwja4NhD04R
 FA28TsaLaYe3v8ZfPFYxNrTAb57FJstJOwM4gUVX6JICL9Eqq4pEPlY5JpZ9qhcbi6dGqwr40L6
 SEPJr9PihWQRE3Mcxg0PUUxLI9qm3JTXpEn/iL1XvvnYEy3tOqWXrX6KKGKnH6ND4klDLFWHC0J
 jydWtTBQaqs3n/gw==
X-Received: by 2002:a05:6000:b85:b0:48d:f7f0:327d with SMTP id
 ffacd0b85a97d-48e6e4fe248mr24266192f8f.29.1793726279053; 
 Tue, 03 Nov 2026 09:17:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78a1dsm25263876f8f.24.2026.11.03.09.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:17:58 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 17:17:58 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iad78e78cf51812c392f53cd58b33b54cb99cc6a8
X-Gerrit-Change-Number: 2097
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2097?usp=email>
X-Gerrit-Commit: 4a6bd5f532195ca89550c3e930576734ac7ff486
In-Reply-To: <gerrit.1793686207000.Iad78e78cf51812c392f53cd58b33b54cb99cc6a8@gerrit.openvpn.net>
References: <gerrit.1793686207000.Iad78e78cf51812c392f53cd58b33b54cb99cc6a8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjg2MjA3MDAwLklhZDc4ZTc4Y2Y1MTgxMmMzOTJmNTNjZDU4YjMzYjU0Y2I5OWNjNmE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5a006f13e8f47167386315bf33a777e96cdcc742-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOI97-000000000y0-2rs5
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5804808326079082949=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5804808326079082949==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0VjFxpQ/o9k="; charset=UTF-8

--0VjFxpQ/o9k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2097?usp=3Demail )

Change subject: console_systemd: free argv =
when openvpn_popen() fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

console_systemd: free argv when openvpn_popen() fails

get_co=
nsole_input_systemd() returned without freeing argv on popen
failure=2E Fre=
e it right after openvpn_popen(), which no longer needs it=2E

Change-Id: I=
ad78e78cf51812c392f53cd58b33b54cb99cc6a8
Signed-off-by: Razvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2097
Message-Id: <20=
261103121903=2E2369-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40566=2Ehtml
Signed-of=
f-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/console_syst=
emd=2Ec
1 file changed, 3 insertions(+), 3 deletions(-)




diff --git a/sr=
c/openvpn/console_systemd=2Ec b/src/openvpn/console_systemd=2Ec
index 9588b=
95=2E=2Eeaed24e 100644
--- a/src/openvpn/console_systemd=2Ec
+++ b/src/open=
vpn/console_systemd=2Ec
@@ -69,7 +69,9 @@
     argv_printf_cat(&argv, "--ti=
meout=3D0");
     argv_printf_cat(&argv, "%s", prompt);
 
-    if ((std_out=
 =3D openvpn_popen(&argv, NULL)) < 0)
+    std_out =3D openvpn_popen(&argv,=
 NULL);
+    argv_free(&argv);
+    if (std_out < 0)
     {
         return=
 false;
     }
@@ -81,8 +83,6 @@
     }
     close(std_out);
 
-    argv_fr=
ee(&argv);
-
     return ret;
 }
 

-- 
To view, visit https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2097?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: Iad78e78cf51812c392f53cd58b33b54cb99cc6a8
Gerrit-Change-Numb=
er: 2097
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--0VjFxpQ/o9k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2097?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">console_systemd: free argv when op=
envpn_popen() fails<br><br>get_console_input_systemd() returned without fre=
eing argv on popen<br>failure=2E Free it right after openvpn_popen(), which=
 no longer needs it=2E<br><br>Change-Id: Iad78e78cf51812c392f53cd58b33b54cb=
99cc6a8<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>=
Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2097<br>Message-Id: &lt;20261103=
121903=2E2369-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40566=2Ehtml<br>Signed=
-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openv=
pn/console_systemd=2Ec<br>1 file changed, 3 insertions(+), 3 deletions(-)<b=
r><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/console_systemd=2Ec b/src/openvpn/=
console_systemd=2Ec</span><br><span>index 9588b95=2E=2Eeaed24e 100644</span=
><br><span>--- a/src/openvpn/console_systemd=2Ec</span><br><span>+++ b/src/=
openvpn/console_systemd=2Ec</span><br><span>@@ -69,7 +69,9 @@</span><br><sp=
an>     argv_printf_cat(&amp;argv, &quot;--timeout=3D0&quot;);</span><br><s=
pan>     argv_printf_cat(&amp;argv, &quot;%s&quot;, prompt);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((std_out =
=3D openvpn_popen(&amp;argv, NULL)) &lt; 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    std_out =3D openvpn_popen(&amp;argv, NULL);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    argv_free(&amp;argv=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (std_out &=
lt; 0)</span><br><span>     {</span><br><span>         return false;</span>=
<br><span>     }</span><br><span>@@ -81,8 +83,6 @@</span><br><span>     }</=
span><br><span>     close(std_out);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    argv_free(&amp;argv);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     return ret;</span=
><br><span> }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2097?usp=3Demail">change 2097</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2097?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: Iad78e78cf51812c392f5=
3cd58b33b54cb99cc6a8 </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 2097 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>

</body></html>
--0VjFxpQ/o9k=--


--===============5804808326079082949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5804808326079082949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5804808326079082949==--

