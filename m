Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0331CCA490
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 09:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cfbWydjXCHGlKs8YPIuM2cGap8m7KfGGeIJMZ0aKJ20=; b=MNoN0wDLUayPObq2UEmXytqly2
	8qgXPwZj2zKHYzOkAGp1+plfdSGWY1rwFt5F7us72JEWCZRpczCxCsJi4E6a8H+OYSp4vJRyZ2Sij
	enTUfG91U93j0M2O+fT1V7G00/LRCQiZBRept1YRbSmdBe+8F+O9KM9OcFqUtXO57lkQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIMtV-0001hX-2c;
	Sun, 18 Oct 2026 09:09:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIMtT-0001hL-O6
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 09:09:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=oMurssOLNSSDy25L5TM3GJUDq1o6lMOE9Nwd4KN/SWQ=; b=DORxLdtaS0WXUp5d9MJIm0J52A
 Plpklri7vWs94g3PhEqpTs6CFQgUiyW9q9kLodJx+yIg1g20LagPi6HWZARw52Rnufr8D0KJry2Ox
 dZ55wgaZDV+0OlBR+NKsX7nHBFWpWZdz0r4P+PXmiggpgJbFnZeyjC1B10j0GsBqfdXQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oMurssOLNSSDy25L5TM3GJUDq1o6lMOE9Nwd4KN/SWQ=; b=F
 +8I2MI3fCN4dl00VdBlLvV722K+Y08ADLPyqRnRkTpvcpK57GMZZu3IvqIbiwNZfrELTWChKoy7Dv
 Iuf9UVFF7QJklglu4GPC9QDPqwHL6NCLcdRkUbPXwRnwnjnXsIIGUBeHQsuG/2xRa6LMtMxZoweE4
 BmhERcRnEVwp3qHo=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIMtQ-0000JB-Gn for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 09:09:25 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a1e3098ee2so2772025e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 02:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792314557; x=1792919357; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oMurssOLNSSDy25L5TM3GJUDq1o6lMOE9Nwd4KN/SWQ=;
 b=Fxj9EuQwWbq3Kp5aFaKaDS/4GJP9f5lQJYskjNkCOL9qIjAI1Um3taaChbHYtdSOKf
 RQrza/qE49vf3K9zBmPMzeo23bkjD8WLeBWM3OmQvo6cDT2viegU3QD2Qx0wsEJm2C9J
 PHm4pHZmxRjQqQtcsQ/c0rUnx6yEQALdXXzj2K8nl+vZukTinQCD9JhTG5XrjN4fXdEX
 52sl7f/K48wdxePMSy03vqMbKPaHpbf2ANrnHlXtFcb8TOEnJaZwjIac6A5VC5EsXnyN
 LynE8uqiQ1LYPIbM6FLpOtOEWhQ0uPRPxMTjWkTILTNQW7b2AOJP4j2H3kdcgOkNHx5r
 COLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792314557; x=1792919357;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oMurssOLNSSDy25L5TM3GJUDq1o6lMOE9Nwd4KN/SWQ=;
 b=mS8OFn1tKJVZmfdhsIdxJU8ssvo6qUd6UBUxcgeWFbyojRr/T/shiowyeepHnY9kLS
 6xZhPfOtJUUs/dxuMyy1rB7K0lmhq68I3Weby/QU2I5ylkchwMp8ySP+VrmabLzsB9Tn
 Qgaly6mRNIbW7eLjpul6YtlmQb9myNrhUyzixjT08iaqyWvsS8m/6cUQTt4W6+YPRIqI
 ez85FtdnxKK5tC35dbuSCkZLphqsM/Eu3e8PwFpqzGRo0lV7X472f8yfcVkwilRPLgLc
 hcaYlBR68rah2A6ZM01iLXX3CManvkzBL/bY8UTXqRVO6RS0TkcaTqNrkHtoUmM5xIk2
 tVaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+cmtaHkWPCj61pBhhF2X3QVZfXvRfIY9CXmBsSu7BgnYgZEDzLY9TqpKbybO9zwVFtNrIVtNp9ZolxY6T@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL2+lqKi6oP58dRWL13Zj5SZle9ob/s7R9RsmCkbzoBr3Tnf6ox
 IAPGV+xYYNtt2s227qk9nY5tog79Ad1HwUuC+UuBUEmX+FFc/AALD62xpzUvYMYJMlu/6M1wuaq
 BR+wvoiDgRbosd9AH9hvLGfHu3CcMNO89mVxqTmEvDyE8R2U4uHS0VTotgNmr5e2zUNic
X-Gm-Gg: AYBFou251KGyGUXtvZsMFKPQSIEsxyNxtPikot1Gji5xH7XMYWUt9FK3irJRUh5A9oP
 eURrYEHI891gH4Tfzo9hsZH+X5FQrPLwGvFgostzgKGpV4ldnnNrEt0QBJi/lac8laYpbOOTwa5
 +3UMLtkcUwSboZ3fLCzQfmyuU5zTm7R50/ADlEbZQ3bVItqhcJpT563tXUJ9nHweYcOEzszvBmd
 QtJh/ZuD8t/fCuX24fIPsip51yb2XX3+Cxn0K/2x3I2k/n7nUTJRT5EnuYisEtFmijd8VWtOlXM
 BZhZ/SKaXnxZcM61ak3clFBx83QwPwTx9oJI19FthA2sA7EUmeqMgKQZGG8xB0OLnsBhbSAZIV+
 boYuXU/8U95nxqQHMM1Km2swjxMI8566E8V+A49uy6z7apQMHpQ9fx5Y8lUzhMS/l83fy4FG3TM
 /2vcV3YIIGKT3imbDoheYN+QJXfnZ/bKhhTl9SHz7jEWGD7Yc44LWYGsuU1qUHGRUo5HRrgCLi+
 9IZlfCiEXUFThCfeE84X3N0tPkvRAmHnCxa3l3EUtlnJgonrveGQJ9JlErVPVVxiFpnLmMnBB+g
 +3sK6q//rQ0gfBQnX43Foma5eQIyRxfimcUbhufG5xfmXxe6NVE5IrSm79a4
X-Received: by 2002:a05:600c:4ec7:b0:4a1:d537:1c8d with SMTP id
 5b1f17b1804b1-4a1d760410dmr98139775e9.19.1792314557463; 
 Sun, 18 Oct 2026 02:09:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d3e2e602sm181817675e9.5.2026.10.18.02.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 02:09:16 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 09:09:15 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
X-Gerrit-Change-Number: 1783
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1783?usp=email>
X-Gerrit-Commit: 690ed32a0c87a92f2be1aecd90650d31f56953b4
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 09:09:15 +0000
In-Reply-To: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
References: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklhMWU3ZGI5NTYxNWQ5OWVmOTY4N2RlN2M0ZTk5NmRjODAzM2UyNjMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ac3301d05b7c5f4c4a10312ad6897699d3de30a9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIMtQ-0000JB-Gn
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multi: assign
 clients from a named, tagged subnet-pool
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4088819991623206816=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4088819991623206816==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gYpOPLtis/w="; charset=UTF-8

--gYpOPLtis/w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe, Fran=
k Lichtenheld=2E

Gert Doering has posted comments on this change by Antoni=
o Quartulli=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demai=
l )

Change subject: multi: assign clients from a named, tagged subnet-pool=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 6:

(1 comment)

Patchset:

PS6: 
Actually this is cppcheck now, and it on=
ly affects "test"

```
+tests/unit_tests/openvpn tests/unit_tests/openvpnse=
rv
etests/unit_tests/openvpn/test_subnet_pool=2Ec:127:15: style: Variable '=
b=2Enetwork'
+is reassigned a value before the old one has been used=2E [re=
dundantAssignment]
e    b=2Enetwork =3D 0x0a0a0000;
e              ^
```


=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1e7db95615d99ef96=
87de7c4e996dc8033e2631
Gerrit-Change-Number: 1783
Gerrit-PatchSet: 6
Gerrit=
-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ed=
e>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sun, 18 Oct 2026 09:09:15=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--gYpOPLtis/w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe, Frank Lichtenheld=2E=
 </p>
<p>Gert Doering has posted comments on this change by Antonio Quartul=
li=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=
=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1783?tab=3Dcomments&amp;usp=3Demail">Patch Set #6:</a> =
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Actually this is cppcheck now, and it only affects &quot;test&quot;</p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">```<br>+tests/unit_tests/openvpn tests/unit_tests/openvpnserv<br>etests/u=
nit_tests/openvpn/test_subnet_pool=2Ec:127:15: style: Variable &#39;b=2Enet=
work&#39;<br>+is reassigned a value before the old one has been used=2E [re=
dundantAssignment]<br>e    b=2Enetwork =3D 0x0a0a0000;<br>e              ^<=
br>```</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail">change 1783</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia1e7db95615d99ef968=
7de7c4e996dc8033e2631 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1783 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Antonio Quartulli &lt;antonio@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Comment-Date: Sun, 18 Oct 2026 09:09:15 +0000 =
</div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div sty=
le=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--gYpOPLtis/w=--


--===============4088819991623206816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4088819991623206816==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4088819991623206816==--

