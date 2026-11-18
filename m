Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E9606A32F
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fJtfMVu2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DkOZI5vT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jpiTE1z4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PVC9Aa/z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Zi5yg6Xp+7E92GucM1jzb2sNltRUPmKpfSFMamvntMA=; b=fJtfMVu2Sf9jfmY/eJUWKo+bPn
	fF2lNSj+hZvJS+Go9j+lu0szl7buGOgD9q/rnvAjDRa2qrvVaZ1kbw3sDa4HaKAu01ZtgXCOxjTTl
	B+80wy338DEIlKxk6fd90P+NgxAq9WwFp+W7QlGWVEdtZJ0fv+ECXqS+nqL8PmCwkbwM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTgsZ-0000000044E-3msI;
	Wed, 18 Nov 2026 14:43:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTgsX-0000000043x-2dCY
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:43:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zZ8xmpt+96SMGcJ6OGGEZIbQctjL/padx+HOGK2nAcc=; b=DkOZI5vTfSjyxQF878W4zkzTPI
 JFxS1csv1NQbjWicNd9kPqqfSjUqBceTOB/YqwnC8SQG21PXrR+zDz7gSBvl36Sqn0N2FQi+tUz//
 EpgFquzn6eunYpmg+ThSSXLhlhRUnq1H/BG+Xktged/Uf6f3/Y47/6cudYphjSotz3bg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zZ8xmpt+96SMGcJ6OGGEZIbQctjL/padx+HOGK2nAcc=; b=jpiTE1z45O0PvzJAY1Cv+9NnaX
 MSMufXwGvr8vwcDj8WFVRmgA+GALoL4elwMz424ZGwu2o1TcTY7H6oxWCXXEQDPQf8rKQ2DheSyN9
 0W93UepAlUTvAi2nRKya8s84RcpqkMQxIjiW+AZzuQypatvH7+jlfqdcrPb14+9wCzp8=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTgsW-0000000036M-0u00 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 14:43:17 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb6c7b6dbdso15951345e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 06:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795012990; x=1795617790; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zZ8xmpt+96SMGcJ6OGGEZIbQctjL/padx+HOGK2nAcc=;
 b=PVC9Aa/zmpf7gaS8WZGnpi672wfMCICxvCoaKiiedb3/QxX3aI+zWAAg6T8DpX7P6T
 sC/27iX9hGczfzkcB7BuzJLtlyoBM1n7G7rbPMdtM9NJDiOU2RyGdf2rS9abLh97/q8a
 PWy1a4EhhKc4ExxB5D9iE+zWlhxf9zfWmsD1Q5ygdKd9tKfy0/GcXB2gFAPMvEs+TkJ5
 LPV5lqXmSkWo4SbCk5PNAZCJy03AtANPLWveBt+SecjCq+v3o/D3mVtkYqrWXViyTuif
 Z3NDYyS/MmnLArbaMfsT8bUruFLfKfoN1mFaLxPbGPe5bFzfB+5269lzA7zYKLTGYkBo
 7vNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795012990; x=1795617790;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zZ8xmpt+96SMGcJ6OGGEZIbQctjL/padx+HOGK2nAcc=;
 b=2KNUSorDYKySLaVSKDMl7Ik8ezoHPBduSKS8u3EGKx/b3PVrv4P6vSRd6E0c1jET/B
 V3BMd+wGB48DJUVkGuWdlI+cbQheOBaPlSuTa9Xp1VfO/okavzSkizOK2ETu73RMm/4Q
 ntzBePEunqzmED9jhi/Q+uURSr62t0eAKuswnbepvgzNCN6zazfslTkXVLOykdAen+Q/
 8tzL7lDy1JPwDCfzdH97XfQwvWv+9gRAAHtOXiIYedSfBQ/LPfWlU4g41Agrd8usYmJn
 F7xCFZR/FGFEc06jEXhnx18toLElReYTA7i2zmRyGTj5ggcjOMB3N8JjUsu4JBPWTDxF
 TzDw==
X-Forwarded-Encrypted: i=1;
 AL+hErH6ms+XWdF/k0wXhTJ6CFThoPmKK0+eczzDtGs6zMZI6bXEc77kFgXnOh16RjXvXsXQ+ZFZ0CR2gfGeti2v@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8YqSWxbGvDAvn56CEKvy66D5oK6Mj4jQe1f7SmJyQaTf8XFdcs
 kmVEp0hpmlLR+Q7qHwN+2xNTnNAKJutmPfe16aa7sHf8uAtGvIvpG7okKulK6A89FsNGTnd0xOv
 25lID2sUgK8eLusF22GDl1Kx+y6tVr+Xw9F3VLyRseL6Ds6XH9FbddadrWTmuUKgkqH6d
X-Gm-Gg: AYBFou17JmgWGnDeZaS2nRwczhTI9T/OaijR0QYPW5T9WAXfsNqqFTjldEsUwOalp1G
 LcGyDpA1pHTl8mWUWFScITetwksaJE5iQIqT+iqtAvofQJhLmiEVkkILOaUTN9lObLXhrTATXhp
 x8LetBFntc3BDV+cjnHQba7SgFZS+GBQnIRSN6gOYiZ8rKZhYSdK8oUYkRrjdmTcLPF5loRYKwS
 rVEi1C6Dfw+KsH+2op7H7cJNyR/lO4sdcJKW7Cutj89E6QP1O8O6zsAowYgU50wZ98U+J7jQjo7
 BMax8lirEdppjRvJk1fzRsEVZzKi2Mcs30d4+GKoR55Yma4vEWDsyFJekSY2gcr7cbB/jqcDB+B
 Ldd+mOfi6rsz36q5kXTbPqzj6dKFFxKafZknbKBrEYhT9HvkCO5CuthOl2baFgtnwgAFCBMIwdV
 rKqOaG4MKze4W0vAp8+ijZrW23phEG1+1XpGsYHLsVAy3mSqoYQE3M08/dAgeV2TAywViQEW1hj
 0JAtkJpBWBuPc7x/5+2iAjKv0UmcaNd4OmWzoiPi1R4IFLU4U4+YVocdcIZgrJinGpcmGrEjNQE
 cTIaEqtT8WP0m+zImBnsHVYZlyyB4T5cOMSdsf0Xi4P3O6KKNNJbJ8Uml3Rn8DxPUypHk/HL+Pn
 gaeFDYeYiuSFSKBPgPvKxSDJ1qr2+F8MnExhIspI5BYiVfQohKswc8NAaI+RX6CXYBq2IDi6pOE
 DXzrOmxLsL/aaHsis=
X-Received: by 2002:a05:600c:4e02:b0:4bb:6994:abf0 with SMTP id
 5b1f17b1804b1-4bb7da4b889mr57245505e9.23.1795012989296; 
 Wed, 18 Nov 2026 06:43:09 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2cfce7sm71652225e9.14.2026.11.18.06.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 06:43:09 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 14:43:08 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic49db236b36014ea6ee621a09252a534e3d05ef7
X-Gerrit-Change-Number: 2205
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2205?usp=email>
X-Gerrit-Commit: 3a72da5a1608f039e359168cea20c5ca99c778bb
In-Reply-To: <gerrit.1794903017000.Ic49db236b36014ea6ee621a09252a534e3d05ef7@gerrit.openvpn.net>
References: <gerrit.1794903017000.Ic49db236b36014ea6ee621a09252a534e3d05ef7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTAzMDE3MDAwLkljNDlkYjIzNmIzNjAxNGVhNmVlNjIxYTA5MjUyYTUzNGUzZDA1ZWY3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cfcd14c3bf5c8989c3c6ed6def79fd46aea16576-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTgsW-0000000036M-0u00
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: console_systemd:
 treat read() error as failure
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
Content-Type: multipart/mixed; boundary="===============0448921596063849084=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0448921596063849084==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="m9dmtLIofxA="; charset=UTF-8

--m9dmtLIofxA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2205?usp=3Demail )

Change subject: console_systemd: treat read=
() error as failure
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

console_systemd: treat read() error as failure

read() returning -1=
 was taken as success, so a failed read from
systemd-ask-password yielded a=
n empty response instead of an error=2E

Change-Id: Ic49db236b36014ea6ee621=
a09252a534e3d05ef7
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
A=
cked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2205
Message-Id: <20261117175223=2E14555-1=
-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-dev=
el@lists=2Esourceforge=2Enet/msg41575=2Ehtml
Signed-off-by: Gert Doering <g=
ert@greenie=2Emuc=2Ede>
---
M src/openvpn/console_systemd=2Ec
1 file change=
d, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/console_syste=
md=2Ec b/src/openvpn/console_systemd=2Ec
index f0ca7fa=2E=2E059686f 100644
=
--- a/src/openvpn/console_systemd=2Ec
+++ b/src/openvpn/console_systemd=2Ec=

@@ -76,7 +76,7 @@
         return false;
     }
     memset(input, 0, capa=
city);
-    if (read(std_out, input, capacity - 1) !=3D 0)
+    if (read(st=
d_out, input, capacity - 1) > 0)
     {
         chomp(input);
         ret=
 =3D true;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
205?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merge=
d
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic49db236=
b36014ea6ee621a09252a534e3d05ef7
Gerrit-Change-Number: 2205
Gerrit-PatchSet=
: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>

--m9dmtLIofxA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2205?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">console_systemd: treat read() erro=
r as failure<br><br>read() returning -1 was taken as success, so a failed r=
ead from<br>systemd-ask-password yielded an empty response instead of an er=
ror=2E<br><br>Change-Id: Ic49db236b36014ea6ee621a09252a534e3d05ef7<br>Signe=
d-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2205<br>Message-Id: &lt;20261117175223=2E14555=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg41575=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/console_sy=
stemd=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/console_systemd=2Ec b/src/openvpn/console_systemd=
=2Ec</span><br><span>index f0ca7fa=2E=2E059686f 100644</span><br><span>--- =
a/src/openvpn/console_systemd=2Ec</span><br><span>+++ b/src/openvpn/console=
_systemd=2Ec</span><br><span>@@ -76,7 +76,7 @@</span><br><span>         ret=
urn false;</span><br><span>     }</span><br><span>     memset(input, 0, cap=
acity);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (read(s=
td_out, input, capacity - 1) !=3D 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (read(std_out, input, capacity - 1) &gt; 0)</span><=
br><span>     {</span><br><span>         chomp(input);</span><br><span>    =
     ret =3D true;</span><br></pre><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2205?usp=3Demail">change 2205</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2205?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic49db236b36014ea6=
ee621a09252a534e3d05ef7 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2205 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--m9dmtLIofxA=--


--===============0448921596063849084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0448921596063849084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0448921596063849084==--

