Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59C3606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mCLkT92Z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FHd/o4nP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fQkBYHvL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hIXeRd0V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iQKUiKtTRhVzfPEDHARiNV30fPoQ1DKx6X9VoEJw+1Q=; b=mCLkT92Z5mK5U9kiF6sWLHIP4i
	avi3d6/aZ9y2TPb9/AlCkIFpMS42b4RKx04Ve7cxZyK5W38/ogPNMumbM+PzYDq7xdcGaVLZS860d
	EW4ZYN1ZLEHRhfacyqngtVrTJsv91O7oVrkF9Mq6Y6LB9IJAFD3ehSSpjwrPuTpNukZk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVYuu-000000002jv-2fDj;
	Mon, 23 Nov 2026 18:37:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVYuu-000000002jp-0dxJ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:37:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HFpBfq9kAQnBQN0ERoFekQvCw0lavMKFvY/ewLX1uQ4=; b=FHd/o4nPTRwI8wHddOz9EPz5jM
 mOM4MeyFPYeOyZs/loJqs+haBfyzOh8wurd12UnHLzY7kYmvTxZeB8Do4CLPqdK/WT/6OguocPJnI
 2vXzu58fESPeMwBK1SRLRPMF60OURdx2BS2MQ0CbSYXhg88EfFy/RkyzAYSsdwcC4qR8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HFpBfq9kAQnBQN0ERoFekQvCw0lavMKFvY/ewLX1uQ4=; b=fQkBYHvLv70ygKJhqP5aJ02sYY
 cR4XCDwDpkzG9LHi8HWexI5a+/IFvi6jgw8dXt9f3oleW23oZAZMBWmsxxLsc5RonSaYxXMIVVSWk
 BdVoOiTbqAN5RuqqdDAFMIfT90gSGmUDmnoSFTPAEP8ahYMzz+dMOb4WDypMtschukZY=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVYut-000000003fe-1lEK for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:37:28 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so24905285e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 10:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795459041; x=1796063841; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HFpBfq9kAQnBQN0ERoFekQvCw0lavMKFvY/ewLX1uQ4=;
 b=hIXeRd0VpJ+kpiOTdPVzbYTgaQXTX5z/bZ8j+jPahvO2MqB8xxZknETwFE9/GxZCdO
 GqdoxZ/F3vxjM2FNXN7Ti2eTf3bICSqVTr6v2rhpl3ZFicxNM9GUZalBhkMnw4urn9Vj
 xc/fCv0ZQ9Dak3iWmjgaTRFkq4wGDoIIVdQzB2gL404Se5CGlrqznj2pKV6EomMG1+IL
 3U/wv+wrq1WxHC4rEtjGjiPwp0mHSLDvDWQkVbkuqQJhenGHiFGlWtNy4PuZEDleseU1
 cjPmzjLy9RWcM2zS2/RkiMFMtFTkbL1Wr7h3fRyLvm2AaqmTkzEKo75ggalSSdAfYvEB
 e6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795459041; x=1796063841;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HFpBfq9kAQnBQN0ERoFekQvCw0lavMKFvY/ewLX1uQ4=;
 b=Ffq8hvS19IRPxjquBt/sA/NdqV6MMV93HZrc6Z01Qg9XfRwVUJa+wUPHxHeK5qMOAf
 Pc7EPKjaO+8eXYJYpmPI3c2AFr298W3yd/ieCsUjyIJ/6d9XFmZ3DnHPiNuXTrIwJFXt
 Lo/RLPO9ZlOfsKsB2oUcVQOCtHSg8ZJILqs6aa4abeNm7fkdF/NX1jsZwh/+uUPOSXNK
 0vi6+b29BJ71sRjBERWFQgOeyx428oFFKs42CkWtkhvRHUhpj/NRHVxsjzmcmNHoDQoO
 Bt0jn3jLHGXz8qdlMEgz7kLKWoW3IGCDTynOXxv8mpEDjWAzn/IHfePZXeUhrJZNt4/p
 P7Gw==
X-Forwarded-Encrypted: i=1;
 AL+hErEG2IxgHQXNi3+tWmws5nXRm9+jyHpgxQvvufSPtRMaErkHg4lUFRADiYYU8+y0QjGMAAyz99uqeKlBMGbg@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+KEn8AlF+guGqgjEZmEKVzVGkXn2iTDyEHO/LEioqqflzTanWw
 X8tYDzSwkmVxODHN3yIR3VkNK2RjMkz7oORTl2vQgljk7G9DEJ5AFTFNxCny0/mdhymZLwgCXtG
 syJuBbIEv9pvrGJgQSgMsMK7mAlmD7GGHTyqqgshnq/JbsL79z+TqmVfdLBRtuehpm0ba
X-Gm-Gg: AZFdTZfhXPHGEKGjflT9KTawh0BLJSFQ8wK+lFasycd+6mXTqnwUi9oT8bHsPHLG+as
 otwLidJRLog96nm6ubpJ9m1wKFoq5LL/0i31kktqeYJYxt5/iJxZi8hS8oMhtccJA02ZasJFWkh
 1rWP6B1bFOPDNGuomQXVXCYy/zb9S1ZIZ4EAbxO9lOCBWea1SFF49b7aPxQOQOuXHyzLFgTF5p7
 LAps5A9xwQya4g1bx0OIBhIUj8QvclsUCn7mqcInh0tS+V0QYxbHee4hrNwZ+I+KbJfqOnwYbYL
 nlKtuZy8hGGkEIumqo5mIRfL5+KEjCDfZxdTSrbQnnbq08ywW7DHjsU4sbvKl5LDrnvUemcKj7D
 jWQvkM3ZvPeoM3rfeDHL8mf+iJc3errwxXXXCAKNETuhBR+88MhKfob1lJMHt2vfWcnYxJBWVX9
 gQ/iXoSPOUNzIGvrvIWw6O0XM7VuqrNsa9AfFCMGkzQTWv5HJQgU21U9wlct143OPOZPMLzGsN6
 UDJ/Jb03FSTy7HPOnwGtiAflNwuuT9ph43iRBjV0kONNg8JLUbQhwgjxFGA2jovVOZlY2uwZwEG
 8YYMFkoI3Ge/eYmA88hsCKSoNKnAIO6cSCTL/wk8S2r+dWMb3jBRvzTLu8jn1Dgc1n2Pch8GGou
 fzWDdwSp/DpjnF93T8j6F/1K54BX6AUZIMB7kjFgU016UO/LB7wf1FOkeAl94Jt+aKMpkycUD7K
 cIiM/Ed1qp3DBtUd4=
X-Received: by 2002:a05:600c:4f42:b0:4bb:5c5c:8130 with SMTP id
 5b1f17b1804b1-4bb8881c726mr319034985e9.5.1795459040603; 
 Mon, 23 Nov 2026 10:37:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ad644140b5sm20667942f8f.17.2026.11.23.10.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:37:20 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 18:37:19 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id142eda108dd4385dcdc263a4842aeb314a12f41
X-Gerrit-Change-Number: 2239
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2239?usp=email>
X-Gerrit-Commit: f42b9083a410ea28adbe69ccd5ae48d7b9ff7a9e
In-Reply-To: <gerrit.1795378662000.Id142eda108dd4385dcdc263a4842aeb314a12f41@gerrit.openvpn.net>
References: <gerrit.1795378662000.Id142eda108dd4385dcdc263a4842aeb314a12f41@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Mzc4NjYyMDAwLklkMTQyZWRhMTA4ZGQ0Mzg1ZGNkYzI2M2E0ODQyYWViMzE0YTEyZjQxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3ddb78f7c8464a5bf4dc0d0db285f34266cad6dc-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVYut-000000003fe-1lEK
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl: don't log key
 generation failure twice
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
Content-Type: multipart/mixed; boundary="===============7939395956341592828=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7939395956341592828==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8BttX0MReLs="; charset=UTF-8

--8BttX0MReLs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2239?usp=3Demail )

Change subject: ssl: don't log key generati=
on failure twice
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

ssl: don't log key generation failure twice

tls_session_generate_data=
_channel_keys() already logs
"generate_key_expansion failed"; tls_multi_pro=
cess() repeated it=2E

Change-Id: Id142eda108dd4385dcdc263a4842aeb314a12f41=

Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2239
Message-Id: <20261123134935=2E31769-1-gert@greenie=2Emu=
c=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg41823=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/ssl=2Ec
1 file changed, 0 insertions(+), 1 deletio=
n(-)




diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index d5ae1=
3d=2E=2Eeb6b86f 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
=
@@ -3504,7 +3504,6 @@
             enum key_gen_status status =3D tls_sessi=
on_generate_data_channel_keys(multi, session);
             if (status !=3D=
 KEY_GEN_OK)
             {
-                msg(D_TLS_ERRORS, "TLS Error: =
generate_key_expansion failed");
                 ks->authenticated =3D KS_=
AUTH_FALSE;
                 key_state_ssl_shutdown(&ks->ks_ssl);
         =
        ks->state =3D S_ERROR_PRE;

-- 
To view, visit https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2239?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: Id142eda108dd4385dcdc263a4842aeb314a12f41
Gerrit-Change-Numb=
er: 2239
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--8BttX0MReLs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2239?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl: don&#39;t log key generation =
failure twice<br><br>tls_session_generate_data_channel_keys() already logs<=
br>&quot;generate_key_expansion failed&quot;; tls_multi_process() repeated =
it=2E<br><br>Change-Id: Id142eda108dd4385dcdc263a4842aeb314a12f41<br>Signed=
-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2239<br>Message-Id: &lt;20261123134935=2E31769-1-=
gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg41823=2Ehtml<br>Signed-off-by: Gert Do=
ering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 =
file changed, 0 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index d5ae13d=2E=
=2Eeb6b86f 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span=
>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3504,7 +3504,6 @@</span><br>=
<span>             enum key_gen_status status =3D tls_session_generate_data=
_channel_keys(multi, session);</span><br><span>             if (status !=3D=
 KEY_GEN_OK)</span><br><span>             {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                msg(D_TLS_ERRORS, &quot;TLS Error: ge=
nerate_key_expansion failed&quot;);</span><br><span>                 ks-&gt=
;authenticated =3D KS_AUTH_FALSE;</span><br><span>                 key_stat=
e_ssl_shutdown(&amp;ks-&gt;ks_ssl);</span><br><span>                 ks-&gt=
;state =3D S_ERROR_PRE;</span><br></pre><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2239?usp=3Demail">change 2239</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2239?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id142eda108dd=
4385dcdc263a4842aeb314a12f41 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2239 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--8BttX0MReLs=--


--===============7939395956341592828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7939395956341592828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7939395956341592828==--

