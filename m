Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C51C5DF87
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hpO0CfriQDYpclYajLdD+6x0X1bWgKOVEt5EZPqprVo=; b=Fxrq+ph1l8W2cq8/PVCj6Dfjki
	kRWo/E9NKshYb8p0kSVfiD7Pc6NCupmdSHJ9QnpQw2BHRhhW4Hop66kxfD32qE60GZOfShGGpn1lQ
	3E1xyh9AbRGSJ3vgstdrbA+WO7isNgkYZh5zfG69zTMBtPVg53e3O5Dp+TH1RDWUD0lk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxOyS-0007eJ-3O;
	Fri, 21 Aug 2026 13:07:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxOyQ-0007eA-LB
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 13:07:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sMF1EkxNIKq00r4Aan0wswj9LMwaO660CoTcYunpkqc=; b=cuh8QA+kJV2GyzRCnEfUhFFaQC
 2APV0YJPsENmA5dIl3dt7/sLaLp0rAVIQu5uMtUFYPCQuS2/RjdfJ8eloL9Yw4/t617LEKD55p36z
 UnXo6LmHlbgwvplTcfi8XYftA4gyuCPs2s9FgjNUOmKTdTa6UpG/Gp8z02DMfkvSLWbw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sMF1EkxNIKq00r4Aan0wswj9LMwaO660CoTcYunpkqc=; b=X
 +GtorI4aev4Uf9kUjo88fu5x6Crd+jiMUahaDLEDfw4E5uV13k21oCaVDTKOqV4bctT7pEDXQfHBo
 C2012sZXYE7jF1+8jqIUNpRZK8R9z0C5nM9BXfwllrfT7cSa9LvxK664kUmB3LHPcUaupBrWhwL1p
 CUFbEwYbhRbWpxJc=;
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxOyO-0006Zo-Ga for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 13:07:54 +0000
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6a38098734bso1982475a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 06:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787317666; x=1787922466; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sMF1EkxNIKq00r4Aan0wswj9LMwaO660CoTcYunpkqc=;
 b=RaraIm/d/gKWX1kyvHfwYo2hyKNGfJyQN5wGI5nffzMqXaH/4+dhkBDSDYnbDlw+nF
 rpvhnTTFJlKHJO0veJQqt8ily1y+Y+9wgmryBcQMCMJmEp/Jy/AJPa8aQTwWsWa1+dtU
 0W8z2uxl0WJMrcXj1mWEoCBxw/R+2Jut7OeCDa8rSU2MqPPnG9my+m4MMoYv2RLKV/36
 onvP8HoFLByGa2UwtFZBg1o0L0Qsfca1lhoDoOCCXWSPH0yOc9QnySGUNgPmWPi18sQL
 LJaxX2WugchQnD0BXFJp9qqpNiCk5/IfwsFEhGYfR5vbYIWAqvjC3ZjS20NlH2B/BleD
 RRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787317666; x=1787922466;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sMF1EkxNIKq00r4Aan0wswj9LMwaO660CoTcYunpkqc=;
 b=kTTQ2n5YuRu4GK87xM4PHdLarrlsJvRLdGfbxMPq88HjKSRtTt4cDO/f+dGn0WYYRi
 8Pma6yVlHJtPUP1/KBMmBlp/yQfvp4wKDVM2i7h4v18Q2oTZ6I7SUJoYYMdIxtxfc72J
 4UdwMGG5o8lkaWxZ7VW3z2QGmeU/ItBg1GRTukbdFZwmzglJUhuQZbWp+AenqfKcWcZh
 qwlCyxK3n7j7WjfD3aliw5h/ypnSnwQt6Jf/kzBcuR23fQxOd3pmEOIgFlhJo3HPRocF
 B1aDJqkc/+P3eAVGycqRC52pS5gvh0y7eK54akQ/YHW24Mebx+cWwLOKn320WorhZvYK
 fYTg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxYLwd5Myd772+xFRs3jnB4gDGI4mV93Tv7EMO7vOS/BK2+eNecDUFWiw0vKYVK4dOiCdBcWHp7wnJdJ7L@lists.sourceforge.net
X-Gm-Message-State: AFuF++lJJ8QxjwOjLN1bD8A2uu0ZbLcVEeQvG19gcNDw/cSS1IJRurey
 QRQO+O1B38N1QkKmvQEOuwSAc1jb24N6OOhXU+/PwUpxTnUNzTQt0C/XNOK9LfjeDg2QlFByOfX
 eQuSyCjTOSSs16wk3umOrXsP2+s95WvyHSUzQBJpslzVgE1QEDMP5WqY7eRz07L/utltX
X-Gm-Gg: AR+sD11uadKooYQURMOBWhoHufr/gdR0IXsnYJHuwH1JJnG9O+g5kt0fH9N2x1s41MV
 JIzJAygkuhQhiDBwe/TxR/6SxVMk627N1qC6U0iLtQqQqPMJIOoDUDTYcT7e6covZ7IgezEyQeE
 lqDLPrXjR1n4nUr/4IyGmOu4DoGCoTKjrxYzU3Q3HpFbAIIPNlaUdyBfk5KzhVU7weMtnwa6UkL
 B6Wd0sDz6MFk8KRBFcmJLo6zkDP6k+19tdgDTWZ1/e21nftp5UlbQFwXOWyBYA+eGvPKlf/QREf
 zpf5hlUDNJL7NjYryUw3Wo052GAr8SqibARxa5LOW0gjRhR2R9YyluOVY1vCKwNU+6VhJAo0E/M
 0WilBOZNksiK5V/TR9nXfU6r9WZo9raJ5zwzZnGRQWTbSJZtdGz4XHbUQHBt9KVaUOZpzJO8X5h
 zvOTXOFiPjmtC7ChTW0Uw0Wtkf1uPq5gC9pMVBZZy2xPPJcKkX3kqsDFzgsldCJ5SYzMnAt99aP
 g9szoRfwx16gyeIWrQPRGJrKrIFXPfRsV223osAm+H/ajgZvK3Hc3XAvf4YDhuitvfHOguMTd9Z
 7j7+UzhkaqmUhgezCj+wv/MxVTbgAIbe+T0RnjF8Z1WjjADpxMM=
X-Received: by 2002:a05:6402:5188:b0:6a4:ae1:333a with SMTP id
 4fb4d7f45d1cf-6a42f2490acmr5909212a12.12.1787317665615; 
 Fri, 21 Aug 2026 06:07:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff177970sm6127430a12.26.2026.08.21.06.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 06:07:44 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 13:07:41 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I694410615958afbb422d9ead71f04c1a60edc640
X-Gerrit-Change-Number: 1849
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1849?usp=email>
X-Gerrit-Commit: 63603d64043f4ffc0761d964988ccddc36772709
X-Gerrit-Comment-Date: Fri, 21 Aug 2026 13:07:41 +0000
In-Reply-To: <gerrit.1787150248000.I694410615958afbb422d9ead71f04c1a60edc640@gerrit.openvpn.net>
References: <gerrit.1787150248000.I694410615958afbb422d9ead71f04c1a60edc640@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTUwMjQ4MDAwLkk2OTQ0MTA2MTU5NThhZmJiNDIyZDllYWQ3MWYwNGMxYTYwZWRjNjQwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dec678032d853e4b48c4b3d6d4f62870c27ca7ef-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxOyO-0006Zo-Ga
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mbedtls: Work-around
 bug in mbedtls 4.1.0 and 4.2.0
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
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7856381984366113859=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7856381984366113859==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cTneDLk8n+8="; charset=UTF-8

--cTneDLk8n+8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

MaxF has =
posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1849?usp=3Demail )

Change subject: mbedtls: Work-around=
 bug in mbedtls 4=2E1=2E0 and 4=2E2=2E0
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/m=
bedtls_compat=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849/comment/=
0b52619d_3c0b293e?usp=3Demail :
PS1, Line 240:                             =
                 (size_t *)&prv->MBEDTLS_PRIVATE(pub_raw_len))));
> These t=
wo casts would build even if the types of the variables would change in the=
 future=2E [=E2=80=A6]
If I understand it correctly, we'll only need to do =
this for versions 4=2E1 and 4=2E2=2E0=2E If a fixed version is released, I'=
d just add MBEDTLS_VERSION_NUMBER < =2E=2E=2E

Maybe we could do that preem=
ptively so we don't forget later but I'm not sure if the fix will be in 4=
=2E2=2E1 or 4=2E3=2E0=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1849?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I694410615958afbb422d9ead71f04c1a60edc640
Gerrit-Change-Number: 1849
=
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: MaxF <max@m=
ax-fillinger=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 21 Aug 2026 13:07:41 +0000
Ger=
rit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: razvanc <ra=
zvanc@mailbox=2Eorg>

--cTneDLk8n+8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/mbedtls_compat=2Eh:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1849/comment/0b52619d_3c0b293e?usp=3Demail">Patch Set #1, Lin=
e 240:</a> <code style=3D"font-family:monospace,monospace">                =
                             (size_t *)&amp;prv-&gt;MBEDTLS_PRIVATE(pub_raw=
_len))));</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">These two casts would build even if the typ=
es of the variables would change in the future=2E [=E2=80=A6]</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">If I understand it correctly, we&#39;ll only need to do this for versio=
ns 4=2E1 and 4=2E2=2E0=2E If a fixed version is released, I&#39;d just add =
MBEDTLS_VERSION_NUMBER &lt; =2E=2E=2E</p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Maybe we could do that preemptive=
ly so we don&#39;t forget later but I&#39;m not sure if the fix will be in =
4=2E2=2E1 or 4=2E3=2E0=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail">change 1849=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1849?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6944=
10615958afbb422d9ead71f04c1a60edc640 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1849 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 21 Aug 2026 1=
3:07:41 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes <=
/div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&g=
t; </div>

</body></html>
--cTneDLk8n+8=--


--===============7856381984366113859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7856381984366113859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7856381984366113859==--

