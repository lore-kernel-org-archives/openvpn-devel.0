Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C366606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 00:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ceQEFl37;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=frt8NZ2k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=e4y3XUpE;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZnCbvykE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oQ71h1Tr8JEZZhI9hP/vRWVSSN0pOiG4UGQngJ9NgGA=; b=ceQEFl37wE271kEkFJAd6ORYpq
	ke1WOIMcViOMtTNlj7V821rIq4linUZkpJGTimB2LznreiXxVJbhKSGX09QL/A0WShjH7/YbN3SiZ
	yroFiIH+VtkCNcBOPT/Dl89uGt1hQiqKT88aGRQkqdbsGHcf7QwDrrHmutoO0+6mMHTE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMwcM-000000005F9-0ODl;
	Sat, 31 Oct 2026 00:06:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMwcL-000000005F3-1ufh
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 00:06:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nwBB31QlV1lseC/WtLySJzDnzZcQPUxrvh7PJMm8oOs=; b=frt8NZ2kZL9hXNA7uLnPxI69ly
 pyoTltv1D7aj9igOBcjf9X8g4e4nV2xFZ6rZ4BUXc4EY5FQAQLuZugavXmd6TH9EEPdhpL+uxS4ev
 JaK7yDmpPlg4WQjjxbEXGatQv5laQkAbco+GZbBf3mzMNZb4uNzexZ5bJYsHiRwtnorU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nwBB31QlV1lseC/WtLySJzDnzZcQPUxrvh7PJMm8oOs=; b=e4y3XUpEA7ViA9Q5xMV5SkPOcU
 G+7D1klnWgAuHQjlhJACGjEN8M5Nm/M4TV8EHExwKwLkCh4i3DnwNm2c6JyHrQD39lEAeDCkC9ksb
 unkegsZqlrGihkNIQNrKZhsFh6mJSc3U9wTlo5AiBIT36mvv4+0thUEVs+sP0t2Xh+94=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMwcK-000000003Nn-1lj1 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 00:06:41 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a4dc547987so6780945e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 17:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793405194; x=1794009994; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nwBB31QlV1lseC/WtLySJzDnzZcQPUxrvh7PJMm8oOs=;
 b=ZnCbvykEKWictR8beGQSYoM8OPz9qx1gmcmfMoCpzXJWuFLZl3Af6+WH7wyj5WhNaL
 t+uER/jsbDDhwyXb+QasjaUQh6rMeE5nexMiljV0YoEtaIKYWRz/Zs4cf0thbUTPCIP0
 iB+VVkzUfvRYbYZTZsOzQzkuToMtiqUOCO5KuA8ILzjIhSRgc9px57HmnBkfOP+58hVo
 Vxz9/PAGydyBJ6sFHgNpfGIdExoRinE4rxdlBfV4xmejyFI8YjSzs4YYalPFbkHZmR0V
 t0Px+LXvHjIdiYwugkghWlpir4fwGD1ox1410tYjydyTcqnwhXjZ9MdsDvRQmWLRhhlG
 +5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793405194; x=1794009994;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nwBB31QlV1lseC/WtLySJzDnzZcQPUxrvh7PJMm8oOs=;
 b=Fq2b/zdEXq9dwAolQTATanNkrt6e79dGFZ5a1+qj7KPCb/14kOBilFg7dzQYLNbQdA
 qN7AdzReUOv+TMaL/T0VXmvG+OlQOnz1QGSOuJf6f7RfoDJIUVNmAMV8d6GOKvBVdjd1
 7XgPoQOhbKeZO+tz9VA281XH0ONwM6/m+HtaKlecDp/I6tgG7RipucUc47p/hrxp93q8
 W9pPmfxICLi25UdB/RoOzyO+kqnkGpDsXZra4h01SQXGPqStRjbOd8EgHIYN2wfMbB8p
 vhMAA0+4/J4mi0cwkheUKbcx02kGpOWy+gx8bAoywHVJMhCjiNkORo66nVoKXpnUit4U
 hq5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2K6brGRsAwBqcj9jp5JzdSRF7jIKGRHjmhDKhIdwKNtJnlVz09JSmxyJfmXYvrGrxNtV7zTXqKOD1EfYv@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJ4fmAg5YMx1M3Z2YPjxHtMIK0duuelCP4HCq9zzKiwsGF4XMG8
 aLbtoR+b7GIm648PICcMnOHlfOm8cbULqqTkA9ZwNTAyVEt4tK4RvQ2Or9dWWblPz4tsuASUB96
 6mCLmGTooj9A4qwxNLugqRf/w3c2UQvowu6QpmOxHMKYtiVqQY6eySQM6BENabB4fY3NfXIE5sR
 aEwcPBoQ==
X-Gm-Gg: AYBFou0VoHJUR/vdHo2VscNrd5nfeIANmbf/oQ/hNUgsXHl5zHa2DSRtfHBjc3wZLfz
 VgiYvSeZ9Kla6kDVXDPruPHrJbA8oMuvH+DHKKJKfONk/JKTdQXtc+7bQGCzeLqERzGJp2hc9wQ
 D2vsh66LxJbM0lFQtPBNlGW7+n5UouIVuuKiEjCm4+v1NmC1smCNROSGUQ4aB/sMpmSZjMTlO8X
 D/VYPeZ7/E4x/HPIIKxG+7R/nIdPYkq0Xbrmd3FuMq9KrkYJFIRVDlXC2z/eqa1UmpLUGjr+eSe
 6vjEM5tX0AVRKWvgI8kz82FzDPwlu1or6G+E6F4Vy2ul/xXNdxRXy/rT+hLVevvRL/JYdPm0Bha
 KcNzRghBfdIX8Nml/SH3Chuonn5/LgcFxRzWZ8wXUAwQEN8qVn1dh7+Er6DmqE8+bxYz4roCyy+
 uGI1VfiJTnH7+JRKwQ/+J6Npv7tOMB9zgoAG6wc0GjFW4+NFIGEoEJWJvmn9E5D4L+rz+TEF+qp
 5Rhuoi2VzlzikF/EXK8osll8ZG4J/hjBXheLrcBF7s2X+xZx3oy44SiTTGsPolw5paCEPCYhBS2
 /Woyt7bziMLCc/aPTAllZ5CRSoeM7EZ5p5iSBvBjvBnhDIf1VXZCp5xYeQO/oiqfAi13IZulvXJ
 uReHdkI5+Fh1M0GWWw9h6NhOBt3OObaBWk88fkojJePrhwvZjSDaztwzutwY8qnXmXIctQZAq71
 oS70vdwrhk4ZHahBQ=
X-Received: by 2002:a05:600c:840e:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4ac17d168b1mr93449635e9.11.1793405193673; 
 Fri, 30 Oct 2026 17:06:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf368bff7sm93841215e9.2.2026.10.30.17.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 17:06:33 -0700 (PDT)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 00:06:31 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045
X-Gerrit-Change-Number: 2073
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2073?usp=email>
X-Gerrit-Commit: fcd51de7b4ed18d43d6acdec8bf148cf6323ffeb
X-Gerrit-Comment-Date: Sat, 31 Oct 2026 00:06:31 +0000
In-Reply-To: <gerrit.1793389270000.Iea14ef08268e6f6309e4bac4acff27958da8b045@gerrit.openvpn.net>
References: <gerrit.1793389270000.Iea14ef08268e6f6309e4bac4acff27958da8b045@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMzg5MjcwMDAwLkllYTE0ZWYwODI2OGU2ZjYzMDllNGJhYzRhY2ZmMjc5NThkYThiMDQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a65745d39dfdedd1cf26e26460433f0ef916d05a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xMwcK-000000003Nn-1lj1
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Increase the buffer
 size for alert-message in management user-pass query
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Selva Nair \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: selva.nair@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Selva Nair \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4910841786011366377=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4910841786011366377==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Mem8qZrEAyY="; charset=UTF-8

--Mem8qZrEAyY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Selva Nair has posted comments on this change by Selva Nair=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail )

Change subject: Incr=
ease the buffer size for alert-message in management user-pass query
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 c=
omment)

File src/openvpn/manage=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2073/comment/42086021_1dd05e91?usp=3Demail :
PS1, Line 3685:        =
         if (!buf_printf(&alert_msg, " UN:%s", user64))
> `buf_printf()` ke=
eps only partial text on overflow, so a long username sends a truncated `UN=
:` and s [=E2=80=A6]
Okay, we can ensure that the added string " UN:<user64=
>" does not eat into the currently available space for static-challenge str=
ing=2E If its too long, do not add it and print a warning=2E
This will have=
 room for up to 93 bytes long usernames=2E



-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045
Gerrit=
-Change-Number: 2073
Gerrit-PatchSet: 1
Gerrit-Owner: Selva Nair <selva=2En=
air@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sat, 31 Oct 2026 00:06:31=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--Mem8qZrEAyY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Selva N=
air has posted comments on this change by Selva Nair=2E</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail">View Change</a><=
/p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage=2Ec:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2073/comment/42086021_1dd05e91?usp=3Demail">Patch Set #1, Li=
ne 3685:</a> <code style=3D"font-family:monospace,monospace">              =
  if (!buf_printf(&amp;alert_msg, &quot; UN:%s&quot;, user64))</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">`buf_printf()` keeps only partial text on overflow, so a long use=
rname sends a truncated `UN:` and s [=E2=80=A6]</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Okay, we c=
an ensure that the added string &quot; UN:&lt;user64&gt;&quot; does not eat=
 into the currently available space for static-challenge string=2E If its t=
oo long, do not add it and print a warning=2E<br>This will have room for up=
 to 93 bytes long usernames=2E</p></li></ul></li></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail">change=
 2073</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2073 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Selva Nair=
 &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Co=
mment-Date: Sat, 31 Oct 2026 00:06:31 +0000 </div>
<div style=3D"display:no=
ne"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has=
-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--Mem8qZrEAyY=--


--===============4910841786011366377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4910841786011366377==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4910841786011366377==--

