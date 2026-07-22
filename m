Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F60CC44539
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KamgIuTscwSbT17zv4dAWzx0hroGKhhTdaJrxo6GWSU=; b=mZX0GjMy3KSkXumZM7HtAHUqgd
	m1eqMv4NVhOCGr12deE2nSyvQKw2FvX7ibDwlDodnPlhwfvOrBdapTJOEj46TGzm5vT6WV0qGuBc4
	oq5SgxeN1ia3fGS4W+GwzwGD/jtx3X51lTBH18NfnrJEPy7Az3cobqioIAzhMDiMmSRQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmWjg-00028k-Qz;
	Wed, 22 Jul 2026 13:11:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmWje-00028b-UU
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:11:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tkcjJ2qzKLWP2eLGL45+i1BgAnqjN5cXFq3cpEB/S5k=; b=QGKaw8SAs6P3xzOBElJLmbYprx
 kUUywB6Nxzrbp3elIxtj/ixdNN8CuIEvQ8nIvGSv6NKbScTIxnf1biM5GjO53CU+jbJTz81piCTIa
 j5TFjUD0+9SwbFEUFd2f682JfqFAidbwPOmPGTkXwpxVDlWeM7bNHu88h0KB33AF/bdo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tkcjJ2qzKLWP2eLGL45+i1BgAnqjN5cXFq3cpEB/S5k=; b=X
 C8CjmpUnuLcjTkW6MGgAhi+tKoQON+hk362+7PFZEx4kPAsyUztNfHE5Bv2/xIz5eL1SIN1B2ObAV
 FXYhSaOxaZJYn8FQbmavT0mHgZyap/syltq3ITJ2D9EacXNYzu3+AN6BvpAhq/xLctU+bHjojkj3X
 Y/Zw8v9tFLWLrEMo=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmWja-0006dl-QF for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:11:40 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso47249055e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 06:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784725887; x=1785330687; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tkcjJ2qzKLWP2eLGL45+i1BgAnqjN5cXFq3cpEB/S5k=;
 b=aK+Wt8qh6o1MtZak2lOBvqbsfQNCx9aBm1wMbnUKwt5+VupxQ3w4qyo4UrOwoQkBHK
 HsTy9Dv0EekjDuIt6D/90oZzwPzahJvqS6+RV9fiWFq30Vho9UHHmaHJWAYiVmT0/6kk
 ZuinHzrPIzN1+xQQyza2YIbwgHFcBvhnecIQrGSDobVjwjX32zV9npxTmR2+9etpEW3x
 7huXnDV0NZX64rXAG9jYMG97ePknZ+8J3gRncR5sSs240h4o6M153/F6jfYESWftQb+v
 CoO+PDh4nDAUrAxrYsUx9hcBkVxmHKSbmueos/8Hg7qkVRYIVnTV68Un4ejgiejiniI6
 U0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784725887; x=1785330687;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tkcjJ2qzKLWP2eLGL45+i1BgAnqjN5cXFq3cpEB/S5k=;
 b=THGuPoEQWBEyvPgqzilzyLSaBRzn8fz7dVrQ1RCZw+dwc2w7VU+P7VDiGmoGMqlCqj
 aZ64S3xbOMBKNcWc6C8EpRxxozAtqRtlLf+g74f7Fu/87KStgx7Abrp5AP9LtKAV2WaV
 FZeiFBb57vH936s4TiudEGbj9Rmh4v+URNlQeSzAZlyhSNFAV1p6C7cbH8YRUfXmtJma
 ctOLUteBT0dNWSlhLEVH/X69lkl1RTqySDlaBF0tXEuftuycXEfNFyvLVEygGrSDfEa3
 Hg0Q0/C0xYmIhZus87mIun/MgEk1Jb675aB8QMaIo5IGOJBQ7lCGDNTNVvn59pRMAa5k
 EC+Q==
X-Gm-Message-State: AOJu0YxKlETTLfigGeDrvEcJsw9fJGRiC+ZDWAmMwHoIOHYg+/W5s6qH
 jYnw4jJrAoa5tbyM9BGhmXQFmZG8peBG6w09kXGwpjBnXFjuM7TmErbTB7+K/eGAOzyg/m4KAKU
 60iwv7Qksombobg+l64Ge0pJUoOnCKQEurlXJSp+CTXvart4l7gPycqrdb84jQqsB1ZBh
X-Gm-Gg: AR+sD10wHIcEmLfx8Bu4W2rCAOyvPtnRg4OyAErvxK0v5Cfrgal+qYXivKi1U+iqRG2
 hNtTHKqWVDaKNtqSAp1Jy9jPXsLGxyJLoH54QWy78FP3ANCeyrEo4Hmt4q4Q0GyFPe5JW66tDwm
 XSszmXsSQDg/qAB3M12SiVCrxtlh3y/hn8CEAJDmC11CrC6ZZdvY2KOkl4xj/eUXGtpaJZQT6Vn
 Ifp2xfV0/HT2MBS8VwjP6cp8HxmTXHwkKOtJv6fjGetkpJhVWoVal65RkUDLfmvVxCblkPjI3Dw
 Ji5BZc8hqgLM1uRkSQM9fEN7I3A843r0bS03ud4zqEXgGUBcuXuUxoGrVaSK0gk9pS8pwc1qA3X
 YWEbIL+8XfD06sgy2NpAKQet4wZaTsYiAwleg1BFM3a0+mVjq29Vq8AgzQqKBfHReIRYH5qPBDz
 arx8UEIMLOA1Xq0iK4B3whQNituYF01nBpQjW9eDFenupULLaJrVwfenu3Xe7/1SOzUljTjoUco
 O7FSeRODBMBJb+SJGoTN4Ji9kl9PsTv4SYIXClJH9F+l6ouqONyaGTX9YGEWbQhUqzT
X-Received: by 2002:a05:600c:4f92:b0:495:f31:7340 with SMTP id
 5b1f17b1804b1-4954a3d06e4mr254489275e9.5.1784725887036; 
 Wed, 22 Jul 2026 06:11:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b5c2108sm96169705e9.2.2026.07.22.06.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 06:11:26 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 13:11:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I80a94dde26631e5a665029f495b2104cfecb1915
X-Gerrit-Change-Number: 1792
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1792?usp=email>
X-Gerrit-Commit: 2e02ce5ae37f81d5972a0e2a5103fccc8670eee6
In-Reply-To: <gerrit.1784305303000.I80a94dde26631e5a665029f495b2104cfecb1915@gerrit.openvpn.net>
References: <gerrit.1784305303000.I80a94dde26631e5a665029f495b2104cfecb1915@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLkk4MGE5NGRkZTI2NjMxZTVhNjY1MDI5ZjQ5NWIyMTA0Y2ZlY2IxOTE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <291311a25f0d7ceab158ac32c58f53de6991b0ac-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmWja-0006dl-QF
Subject: [Openvpn-devel] [S] Change in openvpn[master]:
 dev-tools/reformat-shell.sh: Make our shell code more consistent
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3876767761824287213=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3876767761824287213==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jbKt93szsyY="; charset=UTF-8

--jbKt93szsyY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1792?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: dev-tools/reformat-shell=2Esh: Make our shell code more co=
nsistent
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dev-=
tools/reformat-shell=2Esh: Make our shell code more consistent

Our shell c=
ode is currently not very consistent about
formatting=2E So provide a tool =
to achieve that consistency=2E
Especially in our test code we have several =
important shell
scripts that we actively develop=2E

Change-Id: I80a94dde26=
631e5a665029f495b2104cfecb1915
Signed-off-by: Frank Lichtenheld <frank@lich=
tenheld=2Ecom>
---
A dev-tools/reformat-shell=2Esh
1 file changed, 14 inser=
tions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/92/1792/2

diff --git a/dev-tools/reformat-shell=2Esh b/=
dev-tools/reformat-shell=2Esh
new file mode 100755
index 0000000=2E=2Edbbda=
a9
--- /dev/null
+++ b/dev-tools/reformat-shell=2Esh
@@ -0,0 +1,14 @@
+#!/b=
in/sh
+#
+# Apply consistent formatting to our shell code=2E
+# Uses shfmt:=
 https://github=2Ecom/mvdan/sh
+
+set -u
+
+FORMAT_ARGS=3D"--indent=3D4 --f=
unc-next-line --case-indent"
+FORMAT_CMD=3D"shfmt --list --write"
+
+# hard=
coded to --posix due to =2Ein filename and invalid shebang
+$FORMAT_CMD --p=
osix $FORMAT_ARGS =2E/tests/t_client=2Esh=2Ein
+# handle *=2Esh files recur=
sively
+$FORMAT_CMD $FORMAT_ARGS =2E/tests =2E/dev-tools

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I80a94dde26631e5a665029f495b2104cfe=
cb1915
Gerrit-Change-Number: 1792
Gerrit-PatchSet: 2
Gerrit-Owner: flichten=
held <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--jbKt93szsyY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1792?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">de=
v-tools/reformat-shell=2Esh: Make our shell code more consistent<br><br>Our=
 shell code is currently not very consistent about<br>formatting=2E So prov=
ide a tool to achieve that consistency=2E<br>Especially in our test code we=
 have several important shell<br>scripts that we actively develop=2E<br><br=
>Change-Id: I80a94dde26631e5a665029f495b2104cfecb1915<br>Signed-off-by: Fra=
nk Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>A dev-tools/reform=
at-shell=2Esh<br>1 file changed, 14 insertions(+), 0 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/92/1792/2</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/dev-tools/reformat-shell=2Esh b/dev-=
tools/reformat-shell=2Esh</span><br><span>new file mode 100755</span><br><s=
pan>index 0000000=2E=2Edbbdaa9</span><br><span>--- /dev/null</span><br><spa=
n>+++ b/dev-tools/reformat-shell=2Esh</span><br><span>@@ -0,0 +1,14 @@</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/sh</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# Apply consistent formatting to our shell code=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Uses shfmt: https:/=
/github=2Ecom/mvdan/sh</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set -u</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+FORMAT_ARGS=3D&quot;--indent=3D4 --func-next-lin=
e --case-indent&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+FORMAT_CMD=3D&quot;shfmt --list --write&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+# hardcoded to --posix due to =2Ein filename and invalid shebang</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+$FORMAT_CMD --posix $=
FORMAT_ARGS =2E/tests/t_client=2Esh=2Ein</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# handle *=2Esh files recursively</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+$FORMAT_CMD $FORMAT_ARGS =2E/tests =2E/d=
ev-tools</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Demail">change 1792</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I80a94dde=
26631e5a665029f495b2104cfecb1915 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1792 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--jbKt93szsyY=--


--===============3876767761824287213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3876767761824287213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3876767761824287213==--

