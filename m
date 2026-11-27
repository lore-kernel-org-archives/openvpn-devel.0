Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558B9606A31F
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YavZsaBr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=grZWwN8D;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=J44RTOeZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=T55Y/pDU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=ihuQKbxTKvg4Gvym0DusiOW/xKpZ5heOD2KkWQf+Wcs=; b=YavZsaBrZ/Hvo91OrO+S8dvC1L
	a6GQPR4wwyZLKPCEnDuS6UjcifWCuPj7tHq0ONYMfGe4GVK5jHhmQVMqyN++7qWk6F4e0lMJOqG3o
	LycnX2a2xjnSRRGNgGWCObx4LKNBgHUSU/ciWWPp80WIprn89gA+lXcy4H1HQXsuLJcA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWu9r-000000003f5-3eFe;
	Fri, 27 Nov 2026 11:30:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWu9p-000000003ew-0VnW
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 11:30:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YrvJJMaQpG8sMZMKu5d9bGlHbNyMA5XPsUDgII5keGY=; b=grZWwN8D3kPeL86caV374vZiOc
 u7dbFuBOk29puNb6Ca1ZuoO4JnNu3jg5DU0cWd0Mdz/H7QkVffm42MC5H0z8otcyMS/L/7cSZsUa0
 pcwEUhWbmpBnIxjZbVRBxrvYs90Jr4r/+lJrecwG16I2Xpb6Vna3b/dpQsnKqP+EfqKk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YrvJJMaQpG8sMZMKu5d9bGlHbNyMA5XPsUDgII5keGY=; b=J44RTOeZqD6z0ejxn9ysSDIRmR
 8j6YMoQA5Q+z0UgFa1lU2riYSg6lbNe55V/Y/m2//TH8OLEq5lkiN/yPhzA8TaB5s0a5sHmwoXqDF
 1KFEH9IAuQzk8979dIqIPDaGVY7Ld9y/TZpI7JQY7kvLYr78DYNj92wd6uLyLdSCE14I=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWu9k-0000000071E-0Bdy for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 11:30:23 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bb6057b333so38836055e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 03:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795779013; x=1796383813; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YrvJJMaQpG8sMZMKu5d9bGlHbNyMA5XPsUDgII5keGY=;
 b=T55Y/pDUGq63IctUVCUQHiAMDniHCGR6QP8tYr8aW7j+V5bosDjCb1g9bheEDfWZbO
 aMVbvDfcxo0bNxBPt44qLC7tUqxclRERYTL7NC9IXyPrwlRSEKBtm6ErJrwV7itSFD1c
 5QOo5ikRzeC54MGsUFM64lHptL+I5GCNXxtCSwsJ23oM/ggocdC5hMTAu+jXuW0SvTwy
 yW176AxLu/t4DWyLLQv8hYGv4ubNoDfHwm04hcwy60UoH96oSXHQr3aJpQKhDDFz9sPX
 IjoTNljtmotIqyzrKeBIj5rD/bauQK6VPtRX97+GPCzsBLMSGw+9gDV3dUiNnN7A3OCt
 P13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795779013; x=1796383813;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YrvJJMaQpG8sMZMKu5d9bGlHbNyMA5XPsUDgII5keGY=;
 b=jxPMXzYMSNCvnCYstlG5pxmS3ik+TtTBau2DJfAWFzkagQ92osMlBHeLrfah0XnMBj
 euZJ/+z1m59ftI/nEdhflVyF/fNJ5R/cRMJaX89AhsLKuBS5u0lQ5OO/Xk6CSWNelCwp
 n5wgh6Ja9PRJKcPXA96IZPuTO0Na338Z1AYrDN3LoxhwtsQc6jiS0JmeRSeO+HssZNCD
 pQhgA1vTsHbEUcsUKfV+jvrY0Ttjsr9UWpxLd83Gz9v4FPZ+WXci+hga+rSxMorW7TjT
 NiLxrwBRE3QeyOQ7H94ingQPgAOrWPezmqBPEiDu8gvGUTOpSRBNWAvjZVOwT+98EP0X
 PRDg==
X-Gm-Message-State: APuU4Z8INZFllRPOsL5b7jnl3x5nHoacTEvnHW7ylulce/DqWNT0mGjD
 /36MPd8AMsHnMjHzPvxJGnGPUDBoBnjPRhDZCOQ52KJN9KHzApJh8dH0TQG0h3hPQoRTllzmsIw
 Ir6J6FY1oquJNrFLEBf7h0KEBX2yhz+MPIZDVB9xgTAZ+84+9sj8Q7mp7pAZmSFVNyBH5xvFe72
 1cUoVQyQ==
X-Gm-Gg: AZFdTZcWcri8DaL6SgbpeGsCn4V10JkqS1yhAzn3dAvl/VJa7lG4PmGm7dpcZHoPcpr
 q5dRrEKqMpXSbMD+HilTsws7pQ9IkSZQXu6dWjKdPWh6fD/kcuSlVdaXODYg1Oy9S1Pog5PF9od
 sOKtG7SV53AUwAyBgRxzLP2hVG7eODZ+scWP/Oboq0/Gl6/wzN0s/7407YqMT6WyqYx0dT19UIA
 R9TXsQNj8idLUG10riXvAxIHFuFEB904FiESktBL9Cz2Zgytp0qF3SEjJ4ipuWu1QTFxc26/j3Z
 STOOZz46EP7UtzoWWDp8LPflLU0uPRBlsDwQ7vz1Mxpe60Xb5Ejp1/Mb8fRJMJN+9pUuFAYkF+N
 dhmT82f+pTfmc/xwXJddQs7880oOBNdZ7MGs456gMdHD/n8cun8qnCCF7G0J5eT5e0JYLFDoeK3
 kA4E8wSRx4u6gl1ANmFh+UwHNmKMMKEN7EZp9tSmgEk5S1+6xbiGVu0nEq9athmm3tNBUN5bOkN
 TfeY/dY8uuskDTIM59FSieAlPGJOSZI6LwaAoKccbp5DsjIHKu/0J2Ap4CNyB9XahXgCc51XkFm
 qblkCaBQm355UkxchXvLNFOqyny+REI5ekE7rICP/MnPY2XIzFz7TPx2E81TbzvcczC+JyLHfVD
 9q0Shu+m+MHOWtFK4aQJdsusH+kpCoDSdx0pNKCdjaSzILslDdpv0BZ+sLNX5H5SRJe2Ypz0i7/
 nhZZbk3vmyWMnlw0KXwOCmNLFj8/vDujFLRz3F
X-Received: by 2002:a05:600c:64c6:b0:4bb:6a75:d04f with SMTP id
 5b1f17b1804b1-4bb88807d96mr459922255e9.8.1795779013086; 
 Fri, 27 Nov 2026 03:30:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853c9170sm750227895e9.14.2026.11.27.03.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 03:30:12 -0800 (PST)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 11:30:12 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib20f4965f25472f47b98981d54eaf4e2269d7408
X-Gerrit-Change-Number: 2360
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2360?usp=email>
X-Gerrit-Commit: ecf8d7a55b8642e75d9c8ec381df503fde1ecde9
References: <gerrit.1795779011000.Ib20f4965f25472f47b98981d54eaf4e2269d7408@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Nzc5MDExMDAwLkliMjBmNDk2NWYyNTQ3MmY0N2I5ODk4MWQ1NGVhZjRlMjI2OWQ3NDA4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f03733a652f0298141e56461d46fc356b4bd64ae-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWu9k-0000000071E-0Bdy
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: preserve
 --dns-updown across PUSH_UPDATE
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Marco Baffo \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6213806118629846692=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6213806118629846692==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="krJkFltpA+M="; charset=UTF-8

--krJkFltpA+M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2360?usp=3Demail

to review the following change=2E
=


Change subject: options: preserve --dns-updown across PUSH_UPDATE
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: preserve -=
-dns-updown across PUSH_UPDATE

Reset DNS records without clearing the loca=
l DNS up/down command
and flags when PUSH_UPDATE replaces or removes DNS op=
tions=2E

Change-Id: Ib20f4965f25472f47b98981d54eaf4e2269d7408
Signed-off-b=
y: Marco Baffo <marco@mandelbit=2Ecom>
---
M src/openvpn/options=2Ec
1 file=
 changed, 8 insertions(+), 2 deletions(-)



  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/60/2360/1

diff --git a/src/openvpn/op=
tions=2Ec b/src/openvpn/options=2Ec
index 1e0b4d8=2E=2E05f5d55 100644
--- a=
/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3619,8 +3619,14 =
@@
 static void
 reset_dns_options(struct options *options)
 {
-    gc_free=
(&options->dns_options=2Egc);
-    CLEAR(options->dns_options);
+    struct=
 dns_options *dns =3D &options->dns_options;
+
+    /* The DNS up/down comm=
and and flags come from local configuration=2E */
+    gc_free(&dns->gc);
+=
    CLEAR(dns->from_dhcp);
+    dns->search_domains =3D NULL;
+    dns->ser=
vers_prepull =3D NULL;
+    dns->servers =3D NULL;
 }
 
 static void

-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib20f4965f25472f47b9898=
1d54eaf4e2269d7408
Gerrit-Change-Number: 2360
Gerrit-PatchSet: 1
Gerrit-Own=
er: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=


--krJkFltpA+M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Marco Baffo would like Arne S=
chwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail">View Change</a></p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">options: preserve --dns-updown across PUSH_UPDATE<br><br>Reset D=
NS records without clearing the local DNS up/down command<br>and flags when=
 PUSH_UPDATE replaces or removes DNS options=2E<br><br>Change-Id: Ib20f4965=
f25472f47b98981d54eaf4e2269d7408<br>Signed-off-by: Marco Baffo &lt;marco@ma=
ndelbit=2Ecom&gt;<br>---<br>M src/openvpn/options=2Ec<br>1 file changed, 8 =
insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/60/2360/1</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index =
1e0b4d8=2E=2E05f5d55 100644</span><br><span>--- a/src/openvpn/options=2Ec</=
span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -3619,8 +36=
19,14 @@</span><br><span> static void</span><br><span> reset_dns_options(st=
ruct options *options)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    gc_free(&amp;options-&gt;dns_options=2Egc);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(options-&gt;dns_opt=
ions);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct dn=
s_options *dns =3D &amp;options-&gt;dns_options;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* The DNS up/down command and flags come from local configur=
ation=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;dns-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    CLEAR(dns-&gt;from_dhcp);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    dns-&gt;search_domains =3D NULL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    dns-&gt;servers_prepull =3D NULL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    dns-&gt;servers =3D NULL=
;</span><br><span> }</span><br><span> </span><br><span> static void</span><=
br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2360?usp=3Demail">change 2360</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2360?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Ib20f4965f25472f47b98981d54eaf4e2269d7408=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2360 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>

</body></html>
--krJkFltpA+M=--


--===============6213806118629846692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6213806118629846692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6213806118629846692==--

