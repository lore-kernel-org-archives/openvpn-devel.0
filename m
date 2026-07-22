Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E19CC44536
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Okqg+DlFO+BKFmuLR0Ur4+0QoyfK7ppMU9qeP78hQtI=; b=Pb0r8t0qT4ltVHr08jZOihPAee
	z5SN6XUAUJvRO4h0kcyKUDuWZtq9oPYAB30BcDvHwmgtftBSaWj5ciAtJ+95VLSbtRLO8Wa1gokI9
	yPJF7DC7Df3k8xEOI9UR7n91JZ00DOsh0U1NKLsjq7KuNb9iBXvgGTaXXDQhxNatED0M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmYkK-0002BZ-HP;
	Wed, 22 Jul 2026 15:20:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmYkJ-0002BT-Hz
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 15:20:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9hBZsMv2olQl4sU/jtPn7FFXH05vMhspZ8wWbq2E+pk=; b=g6KzvRwsVCDOF25my5bidwU7er
 7SAbABsbkq+ibDmijEXIwxijNa7/JTxNH6IpJjDsMIeU+NQAVvricD6uGhZkOXNsgeLQ68k+ST7xc
 4aqnYYJEcPx0QqFnQ3Cr/zDGPnQ5fja+YD5Op2srRCu8KlypFhhiBMJFkkdPItPnSwzA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9hBZsMv2olQl4sU/jtPn7FFXH05vMhspZ8wWbq2E+pk=; b=j
 Qo23FcCUNNomAh5Ip85j0Vs1B+Jq8JIKC2zYQ825UD5QZiLBM2J2uMvJvOhtYmxYcQTAgG28jXbbA
 t6DcT0LuSNY8QhAX5q23DysONS+zFMDqFu0/nbSplMRqApwbklQphxYYeuQWgxJDZBD07I9Np20vr
 1AYafi1lCtjZe9D0=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmYkI-0004gj-UM for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 15:20:31 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49571fea44eso979335e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784733619; x=1785338419; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9hBZsMv2olQl4sU/jtPn7FFXH05vMhspZ8wWbq2E+pk=;
 b=hS25W8/Se0QgHFUDxWgEXgijx9BJEUuBJnyuGiT5BTnccRrRqOdI10kJ9xmiT4X1vY
 vhU7DGf72aOd3gygzdSRTUeds6cwk07LjvVXs/iq5oAM0V25par5UT4qNeA9MspiWDzD
 OieX87AhutlasqjUTbxnAFOL1rrndmTWb90XmvZelew5efXPFQNoXkvagu/9M1ashYiM
 HF9MD7NaPimig4SubcYPe/3+QBiBKjg4VqUoGaMp22A+u82ubk0bw6ka63Xpa9rHA4wJ
 cfWXQWAecRcHEOqyJLlIQp473Ow2tGARWDVXenSJt7NUOJ1CSL9SjeT8s2wXH9ytPST9
 Scig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784733619; x=1785338419;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9hBZsMv2olQl4sU/jtPn7FFXH05vMhspZ8wWbq2E+pk=;
 b=e7vqprgwxzcq2pIywzjx7sxk8fhRB+OyhKS1JE2fNvzVWIsQiaFBBcqMspxspFsrU4
 FYQnm2T/eu9d5nfKQatKc16evQnAcxbTiEe0bsRSodb/wu+s6uPa6UyNQLTbhaKNQm9N
 RgYg1lPUNKSubx90hpXcRhClAezVVWDkf88GdfyBGsJSjm5tigXD6nnh20YRJwgK+dj5
 UI0fAthCmwpgOk9WmWEgi2dD46RQHCEdAAuORIygBbXzJxY9hh1PRnwLvB9w1RNSXtJh
 1qyl/Mb8gi4Ctya49wEjntcLLpSn1vhEGp5s9JcSaCILD2uYrbMgERkFAO2M2a5eMlsX
 HAfA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFIJulhvOXEOaVLKM6In60tZUo1eBtrT9O50CA74hpOJTguADYgjDK1EkN/wCwvtzIOQRXVD3izz2GxoqH@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzJeGJdz3BwRwB+RnJRjf1n6MMwoaQNKoQ7Xc/kmTIat4u+cdQt
 KY89n1UCI4iu9+MYhgvK2hJMihyRgXUvwL/6+eqQ+MDQyLMcccL7r/5h3AuwFRSch6VvvnA+pRK
 2rLlW2RL/c0wkJbX31ghmNwJs+fDCMPXIil4lax3EGbwJLjvQSC4yrBZWoAMafmVolU9F
X-Gm-Gg: AR+sD12ejRUDqeOWqxqBf58jP8wQ3420n6k5R1BCQm+7qbTBSBy5jTCwwRU/a4F9mAZ
 BGOXNwdnqUpaqWJs/kNijIb/MFSJXNbOeKCrS1bzy9OE8YbfBa6ws9M+8BCq7eQaw2hVvMvdWbQ
 ARqeDMGvFd5nk9GMnyDmIVSnEztfBw14nd4wDTx47LNfYnVWcLfqEM5J0nAEoPQb62DXJ5YRtDC
 7cS6vbtkoI2rswgbituanb2BHG5d0niZDRVx39bP+9vXRlOJRi32G0XDyBVioNgL9N9ADUgYX9o
 t40TaAjIg2QdSd+dfPDqRk/iRjK1X9LzbvK12wNt5c7rCJ4LJPHwkDOru7UJCst6MizJ2F9WvVv
 hMeT9fQq6IjQtSRE6EdCmQN7foe4SU2xrZLL+ztnWqpXtLYYtVNQJ1pLEybfdeUJDxzzzFZ1oRn
 Lb8JkxaBLRuVnBULPeT3gyQ6kNYtv/yIJIKUE88nApZ3lpb+2jgssxwcgl1IlYBX1YaofSY7U5A
 yrJ8IFy5HEcrXY/8pxjtLbpjGPwTKwKMWTd0ZqmUpBTDIjBV86EEKsZDuVKb8pT0fnHn89jVXyJ
 GKc=
X-Received: by 2002:a05:600c:524c:b0:495:4e12:6ae5 with SMTP id
 5b1f17b1804b1-4954e126afamr269240225e9.26.1784733619123; 
 Wed, 22 Jul 2026 08:20:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a659sm7061126f8f.6.2026.07.22.08.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 08:20:18 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 15:20:17 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a
X-Gerrit-Change-Number: 1801
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1801?usp=email>
X-Gerrit-Commit: e00d04feda433cd8d84584c85ab90f6f0cc6518a
X-Gerrit-Comment-Date: Wed, 22 Jul 2026 15:20:17 +0000
In-Reply-To: <gerrit.1784724772000.Ic183f1f1f90561454b7b1128c95255368427cc4a@gerrit.openvpn.net>
References: <gerrit.1784724772000.Ic183f1f1f90561454b7b1128c95255368427cc4a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0NzI0NzcyMDAwLkljMTgzZjFmMWY5MDU2MTQ1NGI3YjExMjhjOTUyNTUzNjg0MjdjYzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <beae26f594bf27a77672b79febf54944f0dbaf67-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmYkI-0004gj-UM
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make
 --x509-username-field work with Mbed TLS
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9043339127703982459=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9043339127703982459==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JLhgbh7PNug="; charset=UTF-8

--JLhgbh7PNug=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

MaxF has =
posted comments on this change by MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1801?usp=3Demail )

Change subject: Make --x509-username-field w=
ork with Mbed TLS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 3:

(2 comments)

File src/openvpn/ssl_verify_mbedtls=2Ec:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801/comment/9a79f378_a3860b2f?u=
sp=3Demail :
PS2, Line 245:             if (cn_index >=3D cn_len)
> Strictl=
y speaking we can abort here if `>=3D cn_len -1` since we always write 2 ch=
aracters
I think the check should be cn_index > cn_len - 3, because we also=
 need room for the '/0' byte=2E


File tests/unit_tests/openvpn/test_ssl=2E=
c:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801/comment/e0f5f42c_5c365a9=
1?usp=3Demail :
PS2, Line 844:     ret =3D backend_x509_get_username(userna=
me, sizeof(username), "serialNumber", cert);
> Probably should add an addit=
ional test to exercise the length checks?
I added that, and I noticed that =
the OpenSSL and Mbed TLS functions behaved differently when the buffer was =
too small=2E (The Mbed TLS version silently truncated the output=2E) So now=
 I've also changed the behavior of the Mbed TLS function to match the OpenS=
SL version=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1801?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: co=
mment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic183=
f1f1f90561454b7b1128c95255368427cc4a
Gerrit-Change-Number: 1801
Gerrit-Patc=
hSet: 3
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: flich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 22=
 Jul 2026 15:20:17 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comm=
ent-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--JLhgbh7PNug=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/ssl_verify_mbedtls=2Ec:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1801/comment/9a79f378_a3860b2f?usp=3Demail">Patch Set #2=
, Line 245:</a> <code style=3D"font-family:monospace,monospace">           =
 if (cn_index &gt;=3D cn_len)</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Strictly speaking we ca=
n abort here if `&gt;=3D cn_len -1` since we always write 2 characters</blo=
ckquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">I think the check should be cn_index &gt; cn_len - 3, because =
we also need room for the &#39;/0&#39; byte=2E</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_ssl=2Ec:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1801/comment/e0f5f42c_5c365a91?usp=3Demail">Pa=
tch Set #2, Line 844:</a> <code style=3D"font-family:monospace,monospace"> =
   ret =3D backend_x509_get_username(username, sizeof(username), &quot;seri=
alNumber&quot;, cert);</code></p><p><blockquote style=3D"border-left: 1px s=
olid #aaa; margin: 10px 0; padding: 0 10px;">Probably should add an additio=
nal test to exercise the length checks?</blockquote></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">I added that, and =
I noticed that the OpenSSL and Mbed TLS functions behaved differently when =
the buffer was too small=2E (The Mbed TLS version silently truncated the ou=
tput=2E) So now I&#39;ve also changed the behavior of the Mbed TLS function=
 to match the OpenSSL version=2E</p></li></ul></li></ul><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801?usp=3Demail">chang=
e 1801</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1801?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ic183f1f1f90561454b7b1128c95255368427cc4a </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1801 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;m=
ax@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 22 Jul=
 2026 15:20:17 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div=
 style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>

</body></html>
--JLhgbh7PNug=--


--===============9043339127703982459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9043339127703982459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9043339127703982459==--

