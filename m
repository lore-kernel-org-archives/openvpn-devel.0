Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F039C44529
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=52PxE6WSU9uehZVL369rN8XfheSEl+/cJxHunQTJzk0=; b=RzaP7I01q+oXRKBJ/k0K0bcLDR
	6PRDJHQhq3W3VEajetSuF+lBAxpN68EXHBZKPuxN5QsWr8F6XxGraz7VodHCo+L/n85AQTR7/3nIb
	Ge0fcXb4VNwYH+Mkq4+mIgjh2BFDlXE2OPJTeTLKkVuXCBSHzNoavItQr/48sLeWubcw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmCSJ-0005qC-2e;
	Tue, 21 Jul 2026 15:32:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmCS0-0005pt-5F
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 15:32:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=G2+dlJy0qEJMCheLgGi3M1HO+AazjKZc0TGGwSNiLoM=; b=nI4mV0iF3ExKfMQb5BJzGqfM6I
 TXKNQMVBS7eevYtYPNz/9A4kzleM3wcx/CpEilhVVKWJMZHMRhTHssQWxHxkD6afLvE+LnzzEspe+
 jxqS7Pbc0MdBrngnUwinjW1WJ1jt3PkysnDjuxFQhH9a2WOi6wnXdzHy7zQVPCc3orEc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=G2+dlJy0qEJMCheLgGi3M1HO+AazjKZc0TGGwSNiLoM=; b=i
 yCmlF4Ss5S1s9tOmQXCNuoMf5fuWxXCiJuO7C47wjOzmnOsCvu1eh12tTsV04kwVkr5TQ6gWrwL33
 X5E7UZ0TFf6to3y95I8bDym9GjPiI4tsF31QLmJShEYY1m29Ot99DTlNX3tdR6X9Swu/kE1E3hTJr
 59coPYP5Sr7wbo7o=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmCRw-0001tS-KN for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 15:32:05 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47f7444576cso1826218f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784647918; x=1785252718; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=G2+dlJy0qEJMCheLgGi3M1HO+AazjKZc0TGGwSNiLoM=;
 b=XzzqGWPToCWAMQASBoxL9wL/7QQN+I85QEvqI/lO9XKH+xRvrq+jgH2LgKFVEedbgu
 zE4q97Q2/PSb2hX7dNsdT+c3qFiSX1B1aD5BLEbp00khi5feMoMXJ+4m/dEE1nRaS9jJ
 Bhltcx+oNw5FxyFBUHiTTI2FGo75UB9FjYmO/huB02tRYxVdpjrL35yhMgcZl6Xbdj8+
 yIn71IGUmz5fi3SHajPSxUlzOQ8++GntXs5/coJGnCwSvmFPA3T/9i15CicHhWmVYL8r
 ir62iFnct/VIn0lQX1C86veTy2UjqOBS5Xv51MTpY8eqcyT4uOWsq8VVBRTNpKowimQC
 OJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784647918; x=1785252718;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=G2+dlJy0qEJMCheLgGi3M1HO+AazjKZc0TGGwSNiLoM=;
 b=ZlYWiiQMEV8Q6vmVLIUGAEj2/kO2GvniACJmhACRwoeR9Kv0LJ5ym8lHEpszEt4KWJ
 fQ29hL/fx7AyhuAV60SpLGZQnbdVk1agtt8DWqgv72JoS8qF3KsY3ZaHwnCDXGU1mSya
 UX46AUQK3MyQ/Ynm4unO2XZ1H7wQcR75HR5v50xcv9HABxvkbbdVm3Ip+Jla5pnM1pBe
 TlVJuCkyb2Mp3ir2gGZqmoietTufgqgp7PQqzIJJ5QxQz3g5C8WcIH21Qfv/DpOEcvDp
 A7DMDx3tcfOVktBkgRw1omtucq3/aaiLuQQA0V771DvNdlCQ1sRQdfbsQWHgGWFs8SlH
 csaw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJNjB5gixbCpGJ3i5vmB3/CXGZ35HF0h5R/ugt9/1qK3ID+Md1tumVrp/6fKUY5ac+l/QCb87/iEDXhic2@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yx5U7Gg+wdL8DRPiyZnfznh/aEHqG8nOG+bBvne7+aryfGjLDGa
 0RzkIODR8pqTI2XAoIMHbugY6pZeaX1XNq0TaLDRLiMxh+tkQtgbTKyFo6X5GmYwo4/+0N1EoDp
 Je7cBakWAlxE0n9aU56r5LKlX1a7m3VDbZYzEZQTLjE5kwp9V6yyBbqR1c15KtpoIT696xMFgHv
 ZiGjoMIQ==
X-Gm-Gg: AR+sD11blCSE5LltN2vqycW2h/g6MGdM/JeBRvdbN6V5sZV3cw7KjYC8ubeEpUNuBwP
 r10tz3Dcv2/rY/Hy13UoA5UjFgBjregQgYMxPvB0haVksH3Tk6pFDVfc0CHwZP7f5YGjg3ZcKzz
 Pkl/D5tB2l8VIx7OE1r4CM74ZDtbRGDLMB4hAjHFe9ZtTxSoHmK/ipEjGCxHrConVDFQtHyauDM
 0w7m5+JdbfOTKHL0WrG+cZ+xPHbGh90WCQQRvqqoV6XpU2cHgfmd18eHkb5CPwncBDAaKcnQWLo
 9PpmqSRRnUqxcWuPwv2ydruVOhBav0eUmzUR+Yv8ZWJ3wWdlUW5HiMLUZGRwItM6Zhf4Ve58Feg
 CqJL4fSmS3cYPCpnt3tqcCIJkHGhAHWHMG7zD+uYz5DBaC9Fa0WCsFJ7sf2WUo8igw6JCv9Lofa
 42FozRqcAk1Vh8BqJcWACQLmSM8uMvPdRWmCgsSft6k0VMLnUcgoaslomqr7RcsPGUJQAERMumJ
 SDpQBc6Xk1iYcRXn3HhePoALOh2nf1Y+bi3JTj1kQvwPwgDytcr711L26dEmI/p/FR4Ybt4z9lC
 OF4=
X-Received: by 2002:a05:6000:41e5:b0:47f:81af:1a3b with SMTP id
 ffacd0b85a97d-47f81af1b11mr3261946f8f.22.1784647917866; 
 Tue, 21 Jul 2026 08:31:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49acesm38375977f8f.6.2026.07.21.08.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 08:31:57 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 15:31:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I4d0887839b4a13a92e92250d1b315dec949698f3
X-Gerrit-Change-Number: 1795
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1795?usp=email>
X-Gerrit-Commit: 542284246bc45f683d0ebf05c4b930607ff62da3
X-Gerrit-Comment-Date: Tue, 21 Jul 2026 15:31:56 +0000
In-Reply-To: <gerrit.1784390158000.I4d0887839b4a13a92e92250d1b315dec949698f3@gerrit.openvpn.net>
References: <gerrit.1784390158000.I4d0887839b4a13a92e92250d1b315dec949698f3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzkwMTU4MDAwLkk0ZDA4ODc4MzliNGExM2E5MmU5MjI1MGQxYjMxNWRlYzk0OTY5OGYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <07d6dad26e897fac1eefcb90f3d6564588faeb17-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmCRw-0001tS-KN
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: make key state
 desync recoverable
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7015035947764963743=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7015035947764963743==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HhnMI2bFa/0="; charset=UTF-8

--HhnMI2bFa/0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

ralf_lici has po=
sted comments on this change by ralf_lici=2E ( http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1795?usp=3Demail )

Change subject: dco: make key state desyn=
c recoverable
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 3:

(1 comment)

File src/openvpn/dco=2Ec:

http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1795/comment/81cb31b8_dca9a8fc?usp=3Demail :
PS2, L=
ine 203:             ASSERT(secondary->dco_status =3D=3D DCO_INSTALLED_PRIM=
ARY);
> should we also convert this ASSERT() since it's basically part of t=
he same class of problems? Simila [=E2=80=A6]
Yes I agree=2E I converted th=
is one too, and moved the check before `dco_swap_keys()` so we fail before =
mutating the kernel key slots if the userspace DCO state is already inconsi=
stent=2E

(also wrapped the printed strings while I was at it)



-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d0887839b4a13a92e92250d1b31=
5dec949698f3
Gerrit-Change-Number: 1795
Gerrit-PatchSet: 3
Gerrit-Owner: ra=
lf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ec=
om>
Gerrit-Comment-Date: Tue, 21 Jul 2026 15:31:56 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ordex <antonio@mandelbit=
=2Ecom>

--HhnMI2bFa/0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1795?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/dco=2Ec:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/179=
5/comment/81cb31b8_dca9a8fc?usp=3Demail">Patch Set #2, Line 203:</a> <code =
style=3D"font-family:monospace,monospace">            ASSERT(secondary-&gt;=
dco_status =3D=3D DCO_INSTALLED_PRIMARY);</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">should we a=
lso convert this ASSERT() since it&#39;s basically part of the same class o=
f problems? Simila [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Yes I agree=2E I converted =
this one too, and moved the check before `dco_swap_keys()` so we fail befor=
e mutating the kernel key slots if the userspace DCO state is already incon=
sistent=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">(also wrapped the printed strings while I was at it)</p></li=
></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1795?usp=3Demail">change 1795</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1795?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I4d0887839b4a13a92e92250d1b315dec94969=
8f3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1795 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Tue, 21 Jul 2026 15:31:56 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: =
No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;anton=
io@mandelbit=2Ecom&gt; </div>

</body></html>
--HhnMI2bFa/0=--


--===============7015035947764963743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7015035947764963743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7015035947764963743==--

