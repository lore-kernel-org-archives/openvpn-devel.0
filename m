Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4513F606A325
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jqQS+tbe;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CqkHBIV5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gNiBnnlw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Y5ZxPibU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=bN0H1kLzjgTEmLerk3svTUf7zyZCEUrWdd4DfNzmGLM=; b=jqQS+tbeCcMVmbTJ1JUeEXGNas
	gOGTUOW0GBnFVGyObikWq+O9/xNIRo2lj39lU1K2txAYTwMgOgViiTwooafUK6AeqO14P3O8Cv2g6
	uQAVAMmuV3eNjwAmyIO33EWZoxuVUetceQPsHz3d2v8tq+Xqp2i9uHq5VHBa/px+uN4g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTjuN-000000004Ea-2nPN;
	Wed, 18 Nov 2026 17:57:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTjuK-000000004ET-3zlb
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:57:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=93svycZTplOu5YLTrs0icdvb+wDTt0LDyNUj3lXMTB0=; b=CqkHBIV5aq1SgLJpBXxJ0XRGDx
 ocrTtBarHjCqewCnVjFLCLClqHaRmqujx84InkOA5tkQJb49OcuylOW3sdT+3vWo4sI2MYOX1I2GJ
 sjPZitcitG60URgcY+dZBzyvUC9nOA999sVYJf1bKgB4kG43bkNRkpmcPhzjo90o40i8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=93svycZTplOu5YLTrs0icdvb+wDTt0LDyNUj3lXMTB0=; b=gNiBnnlw0/gHW6XeFYD0WmkPVd
 xxfxOHjIQOoEvu5ezsPL+fjUQgwNyRYNHfxuwhIbqtCgkTTZ0qhVdPjo6C9BhwRwO8YOoCpzaVtdb
 oXx/hF7N3yiOILOgoqLTwfCkeDWfTehflPZ88ASiGh9YRxjbYmx5KZ+bgl6gLnYtee08=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTjuJ-000000006G0-2L4s for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:57:20 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so10176245e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 09:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795024633; x=1795629433; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=93svycZTplOu5YLTrs0icdvb+wDTt0LDyNUj3lXMTB0=;
 b=Y5ZxPibUz1Ewg4hX1jFPHhX+mU+7TYVGkSC7pTirWDn0bxBJGNrkLcjL5uxwXxVSgc
 LTmE8lCF9HyazPV6LFH0Ly9RaEPeKFFKPtu0b2fS/rEEdic2i3S5RFajVGZDAYCX+NJM
 JCfZybDL/f1y1gol9jcPu8QZ1ZGGVsXNLJXnriiIzxHRpM0+X+QmQ4GsA7UxWP/4l1u0
 jsqnrPB2IuHnrJcibVd74BfmXKZmuawLx7m0m8IeLONJytpU9svm7SQZ0Wgd0w6FX8VS
 yGVZmhwB38RjLDDFDNG3Z+bDQsghAXYmMhA8nrSxIM/gqFWLl2TmOME54wzCl62Ycu1H
 HjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795024633; x=1795629433;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=93svycZTplOu5YLTrs0icdvb+wDTt0LDyNUj3lXMTB0=;
 b=RgXuy2pOY7SvKAHpIxntKZ2n9fA4NWO8TC3mg9AMuDkcKTsSbLA79IzFDSYtrrax+a
 GDbmP3FTrxjQsekFMFVfnjRDBNGeEJCGVRT4AQx9wdQf9A+H9tnfUajxidjy65CT9CTO
 H1oDfzGYWwOk/ej7UPF3mZf6bomSuFW/q8nB4mJpx1b93szVK4xjn5jhpf91yrF29ntY
 Y2zTsMsA60lTtmVZPeHQPq4ir0PapF5yFRR3m3gZ+5993rkEANOOwC5zOdzxMps3diyZ
 S+EY4rcFOlkoUblRI2D+m+YOVcElsEvOp2txnwwpZrSIyDnagVS6HjxGFSiUYM6EQYca
 fgtg==
X-Gm-Message-State: APuU4Z+bhWnIXEYx1qTxQyBPHz4Nnqc83kZU+Au5aaH9QMKexpSjFBAI
 4DCF9005EPSxpOEfq1tvcGUQ48nAqlDlxFqcwFakbCvOyly+zpsnvEErC+m0Xi4deU8qp1XHvf6
 cG732rl4l15rQzZ80xtW1nm1ZB+nvjwmaD1cdeUOkzHQd10ka7Z1fX3UvfcO6gjCw3IJCaUBoJN
 osKDNOFQ==
X-Gm-Gg: AYBFou1oTfizyPPZuTut9QxPhtshDeDiByOyJ9tn9EHrRmPPkykwIqvbvClXUvdOtpH
 jJpRBSC4rdZbT/FZ7AFV+KxO1jgYU8AfDO+n6aDTPyA6lad67wQ7kqoP+MU2yzLYjqoU0PQ0YhU
 xMJ6m/z4F77KbXYSrZAH/B6X5e0OsPe4gu8pb79h/u68VYaKlqfsJ4/EbglcotLM4VnM6Vg9R6I
 qCrk22BY9kH65zuDKerWg9GYQgX55IzoQfmXLKVU1159/PQ/xwvTMtciuOLnRgKX06SZfrDoFlX
 T1bEfO7ANnbPuxLyu+/KsHaIljIWqvsSIyV0eEggtkxjCkP5mE28A0l7VONUiPb0/E0VX2wPMIk
 s75Q/P6eRhECXl0FICw0QJImD9B7OLa9InmK6cUq7EJRKAZi/VdN8poMDhWc0WzWhynfvXqThs3
 N4A2VfcSfylXCjEnr8nYGWYnDqtvfIF887ieGafHN6rQsUr8h6ptEaYOv69RXehMn+x93euhPo2
 7M/9oeo3E5ZcT53+BGKgfpGBa6cpGgPC+o2aA0wSg1cLpr2naUxUSK3hwSljgOHqkBdms+plZNy
 w+3AJjFNWuyH1yRo8vDv5zFuLpwElAuDQiil8v7Of62aw7dNDHzUAW4qUJx7WsrprfFhWL+mskB
 WmJH3rMXgOq0rh/x/IptMJFrMLLStDcq7Q+mwjoSwPlwVS2nwAcZ9NXXJtvEECn2v26WfYomr2S
 kuVUi752R+8LyMDqE=
X-Received: by 2002:a05:600c:501f:b0:4bb:6f67:ca0b with SMTP id
 5b1f17b1804b1-4bb7da462b2mr68989955e9.29.1795024632735; 
 Wed, 18 Nov 2026 09:57:12 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb832addccsm3747215e9.15.2026.11.18.09.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:57:12 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 17:57:12 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3
X-Gerrit-Change-Number: 2220
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2220?usp=email>
X-Gerrit-Commit: 6131a57429a2bd74c378bb73cf696be4482e79f0
References: <gerrit.1795024630000.I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDI0NjMwMDAwLkk5YTc4ZTU3Y2ZmODA1ZTE4OTZkNzlhMTdmYmNkNDEzMmM1YTRiMWIzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <56085f483031bd9a9c49d54f082289849e9dd207-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTjuJ-000000006G0-2L4s
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: fix MSVC C4047
 in key_method_2_read()
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
Content-Type: multipart/mixed; boundary="===============6330055100961242377=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6330055100961242377==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pTt218+O5SQ="; charset=UTF-8

--pTt218+O5SQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2220?usp=3Demail

to review the following change=2E
=


Change subject: ssl: fix MSVC C4047 in key_method_2_read()
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl: fix MSVC C4047 in ke=
y_method_2_read()

Assigning strstr()'s result to the bool remote_usescomp =
warns under
MSVC and fails the /WX build=2E Compare against NULL=2E

Change=
-Id: I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3
Signed-off-by: Razvan Cojoca=
ru <razvanc@mailbox=2Eorg>
---
M src/openvpn/ssl=2Ec
1 file changed, 1 inse=
rtion(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/20/2220/1

diff --git a/src/openvpn/ssl=2Ec b/src/openvp=
n/ssl=2Ec
index e06659a=2E=2Ed5ae13d 100644
--- a/src/openvpn/ssl=2Ec
+++ b=
/src/openvpn/ssl=2Ec
@@ -2409,7 +2409,7 @@
 
     free(multi->remote_cipher=
name);
     multi->remote_ciphername =3D options_string_extract_option(opti=
ons, "cipher", NULL);
-    multi->remote_usescomp =3D strstr(options, ",com=
p-lzo,");
+    multi->remote_usescomp =3D (strstr(options, ",comp-lzo,") !=
=3D NULL);
 
     /* In OCC we send '[null-cipher]' instead 'none' */
     =
if (multi->remote_ciphername && strcmp(multi->remote_ciphername, "[null-cip=
her]") =3D=3D 0)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2220?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I9a78e57cff805e1896d79a17fbcd4132c5a4b1b3
Gerrit-Change-Number: 2220
Gerrit=
-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ger=
rit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>

--pTt218+O5SQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">ssl: fix MSVC C4047 in key_method_2_read()<br><br>Assig=
ning strstr()&#39;s result to the bool remote_usescomp warns under<br>MSVC =
and fails the /WX build=2E Compare against NULL=2E<br><br>Change-Id: I9a78e=
57cff805e1896d79a17fbcd4132c5a4b1b3<br>Signed-off-by: Razvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed,=
 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/20/2220/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index e0665=
9a=2E=2Ed5ae13d 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br>=
<span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -2409,7 +2409,7 @@</span=
><br><span> </span><br><span>     free(multi-&gt;remote_ciphername);</span>=
<br><span>     multi-&gt;remote_ciphername =3D options_string_extract_optio=
n(options, &quot;cipher&quot;, NULL);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    multi-&gt;remote_usescomp =3D strstr(options, &quot;,co=
mp-lzo,&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
multi-&gt;remote_usescomp =3D (strstr(options, &quot;,comp-lzo,&quot;) !=3D=
 NULL);</span><br><span> </span><br><span>     /* In OCC we send &#39;[null=
-cipher]&#39; instead &#39;none&#39; */</span><br><span>     if (multi-&gt;=
remote_ciphername &amp;&amp; strcmp(multi-&gt;remote_ciphername, &quot;[nul=
l-cipher]&quot;) =3D=3D 0)</span><br></pre><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demail">change 2220</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2220?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9a7=
8e57cff805e1896d79a17fbcd4132c5a4b1b3 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2220 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--pTt218+O5SQ=--


--===============6330055100961242377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6330055100961242377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6330055100961242377==--

