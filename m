Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B590C5DF87
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pj1awRvsybQVEMC+N038Xya9n8lgoEFKv4CDT9bwLR4=; b=WO4R28uVbttqba2QNe437q4fH4
	D+m+2xnzataIxQVPz5HbBeHwXgjuMn9QdBnZuTPDl9gyEOk37cOFg4iv/0OIpyxOqv8AJbW2ym6Ql
	C/u/BCxlqxzEUVzxPIF5Jxu6O2b6NiIeEfVqT34MNZuCNSbHZbI1QEQkqA4C/a/02ttk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwzpB-0008Ov-Gk;
	Thu, 20 Aug 2026 10:16:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwzp9-0008Of-3f
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:16:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Kg+aKrsSFNT9mGLNjTMJ4/3Vs+VF5bMky1EO8PzffYc=; b=FCTw7/irMiiZAbiOjp3ZZJYrGK
 bK9qWDXi5P6iieqxRAikLMZu28ixDEW0crjXCGy99ajlzm0crwBqtS7Y5DuvFGorFZf4DDABmaMaj
 cD+RkT94YXsAPcUsQ4c14u8jUDgP/IjPhcWacyhoB6Fgh+urdBEkfiPZUPRnp/cckwT4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Kg+aKrsSFNT9mGLNjTMJ4/3Vs+VF5bMky1EO8PzffYc=; b=a
 vAczhBdvARrJ5hZfQ6uF/6TS2ejZuRkCc16SZ08sAtP8FN6sakdpU5in0P0TdUu1fMjz0vgnp0DwB
 qxONeUIjN+XUG+TdSezMuWgniAqg4f6M4FApV37Ub3aliDVGEjW98iZ8uTI1hcQgh8iWhGwU9xHeL
 mSJuoxbGzwiSDuL8=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwzp5-0003GU-1e for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:16:36 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47fecbbafdaso723089f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 03:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787220988; x=1787825788; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Kg+aKrsSFNT9mGLNjTMJ4/3Vs+VF5bMky1EO8PzffYc=;
 b=Sxs+f/4F5vH8cGnme+JZgvFj7/DOdWLBgsvexpANYfHCL1o+umQjW8CxaLjOkKSBvT
 ZG0b114WHXtuwKT0P8j5ZiLiKFkDuavouDRgwOgdOpUNvWoUav0+tZRE3BO3m/Oj6cQr
 aBx3stVdBtCURfw4fXn02dUEVHyjaUzwnnTELznyhoxMNxoHuQ7eanGOFUFrwcGmmJsx
 tJeFtFmyABv+xGByaBa3M6liOkonKtStWH769FliN2zub6FnPfvwAy0SCfcRD/DX0/np
 PIcDdW1+rgiQnqoHf56Kzv25uAC2PZtmnoh0s/PI7b5RYdZMrsYQyCw04cLPs64Zkbqp
 IFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220988; x=1787825788;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Kg+aKrsSFNT9mGLNjTMJ4/3Vs+VF5bMky1EO8PzffYc=;
 b=PgpmOYE2jyfWpX6U+pYRcSuhFIQUWAFYhhfDKNLy6kjQ61nEutBQLzaHi14zN0mIPf
 DI0uo5HegJrlmE46rikJsff0shFQdDqh69UzZD2LV1rVfJ7N552jXa1ugZRV2w44Py9k
 Cxmlw6RmPRNJbPvQwcWLMHx0BWDE+CcUrNZXOuuqv2QF3RoiuH0QtYZzcNGXgLk9eWyn
 6+tf8iRcArIroXfv6un9hz/cvx/CZeDERmdeC8pzM0KTbpWWJ4s2KfUrC7ioNxPPMbNa
 jroAqLPQK2TNNzbYq5V4gl+QMhe40nnqH8Wu2atnpYH4xGt0yTFwhaADC95RAakgrS+o
 0xXg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr8SAG4gTrRn+O244rwSP9goow8COz84LG6ymxoUBGQQGgsZxpAUqEVC0P0UxMYrWoZR6Sg71CfwU9BYt2M@lists.sourceforge.net
X-Gm-Message-State: AFuF++nK1C6r2/9RyZwdY+6iEf96mZwaZbJQNk6bp9cig3FdELnbCGEu
 i6SxPeZhCxT3CebOCJEvNUbehGgdCPll9AVGKwzg3rcgR9rlnzApfAUdI0xLNl2dNeikU2V/Y44
 m76qa83d02a6IWdJ0wuTYw3lEHSffK2X3h7F3Vmu03mb7lAEvwVIgsWfilSDca2Ky4tAr
X-Gm-Gg: AR+sD12h0rc8iO3u+bfxzJcVpQn846uZZ71LuTZA/sZqqq08S8y082KF+KrphlVRbyy
 aCJy00p+eEHkTGSeK18dtHk2LvMQ6Hi+v3nTqEW1OevBF/tSVsLjO2/02rtSOtwZSEEA8uoOW71
 D2p+pynIQjcYUP2IWBSAtrfQUL4nLuoahQlvBud9GIqFfQbDLrmwn255WJyUcDO/1+72n8hKZv5
 6pOaIK1dystaFVSaAnMaH/TGOwQ8jBvWQy4bd0vhkOCBWnALM/fAP/8PrZs3oqXJD6bY3anwS2Q
 hZcJynTHLZdUbt3v481uubBJ+K+5M5cSxMKQpRcgtHWrHSjnszsWkUDyv9bqBPo0uCrpWS36Cyn
 sUqoEXx9OsZ/0wrxvme4qOL9aCOFM27SyVYBN1BUFC//fRoc2xEljDX9Q/GmPwLocIgh8CBLgpK
 weXyeT/QkPZ1gClT+7SopuK/I0+K7N/b8uHIwJ3EMABusmd8cWOm+F2J/i6j1AcZJmyPxrtUqvx
 kirx5ixT8CoBxBatBaFwBfF4a59B3pzPwGTfZidSGgiB5hA4ZvhS4lAnMnp6/lPkKouNnKUuwVZ
 wYgDUajhIKDbQyiCMe7TU5YBmMzyvd0qJznco9sYwXx893t9IVI=
X-Received: by 2002:a05:6000:401e:b0:482:a610:7a27 with SMTP id
 ffacd0b85a97d-482b1ff2808mr18452399f8f.20.1787220988134; 
 Thu, 20 Aug 2026 03:16:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1450e54sm13383490f8f.11.2026.08.20.03.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:16:27 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 20 Aug 2026 10:16:27 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I80a94dde26631e5a665029f495b2104cfecb1915
X-Gerrit-Change-Number: 1792
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1792?usp=email>
X-Gerrit-Commit: 5663fd71f4358e404031d57f9ec1acbb0b78358a
In-Reply-To: <gerrit.1784305303000.I80a94dde26631e5a665029f495b2104cfecb1915@gerrit.openvpn.net>
References: <gerrit.1784305303000.I80a94dde26631e5a665029f495b2104cfecb1915@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLkk4MGE5NGRkZTI2NjMxZTVhNjY1MDI5ZjQ5NWIyMTA0Y2ZlY2IxOTE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f9f6af3130a988a446c7118807f3325c936c42dc-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwzp5-0003GU-1e
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, ralf@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5046692395378645540=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5046692395378645540==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="66jCI1i44Q0="; charset=UTF-8

--66jCI1i44Q0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1792?usp=3Demail )

Change subject: dev-tools/reformat-shell=2Esh: Make=
 our shell code more consistent
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

dev-tools/reformat-shell=2Esh: Make our shell code more=
 consistent

Our shell code is currently not very consistent about
formatti=
ng=2E So provide a tool to achieve that consistency=2E
Especially in our te=
st code we have several important shell
scripts that we actively develop=2E=


Change-Id: I80a94dde26631e5a665029f495b2104cfecb1915
Signed-off-by: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792
M=
essage-Id: <20260820091512=2E4550-1-gert@greenie=2Emuc=2Ede>
URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38546=2E=
html
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
A dev-tools/=
reformat-shell=2Esh
1 file changed, 14 insertions(+), 0 deletions(-)




di=
ff --git a/dev-tools/reformat-shell=2Esh b/dev-tools/reformat-shell=2Esh
ne=
w file mode 100755
index 0000000=2E=2Edbbdaa9
--- /dev/null
+++ b/dev-tools=
/reformat-shell=2Esh
@@ -0,0 +1,14 @@
+#!/bin/sh
+#
+# Apply consistent for=
matting to our shell code=2E
+# Uses shfmt: https://github=2Ecom/mvdan/sh
+=

+set -u
+
+FORMAT_ARGS=3D"--indent=3D4 --func-next-line --case-indent"
+FO=
RMAT_CMD=3D"shfmt --list --write"
+
+# hardcoded to --posix due to =2Ein fi=
lename and invalid shebang
+$FORMAT_CMD --posix $FORMAT_ARGS =2E/tests/t_cl=
ient=2Esh=2Ein
+# handle *=2Esh files recursively
+$FORMAT_CMD $FORMAT_ARGS=
 =2E/tests =2E/dev-tools

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1792?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I80a94dde26631e5a665029f495b2104cfecb1915
Gerrit-Change-Number: 1792
Ger=
rit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc =
<razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-CC: ralf_lici <ralf@mandelbit=2Ecom>

--66jCI1i44Q0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1792?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">dev-tools/reformat-shell=2Esh: Make our sh=
ell code more consistent<br><br>Our shell code is currently not very consis=
tent about<br>formatting=2E So provide a tool to achieve that consistency=
=2E<br>Especially in our test code we have several important shell<br>scrip=
ts that we actively develop=2E<br><br>Change-Id: I80a94dde26631e5a665029f49=
5b2104cfecb1915<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792<br>Message-Id: &l=
t;20260820091512=2E4550-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38546=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>A dev-tools/reformat-shell=2Esh<br>1 file changed, 14 insertions(+), 0 del=
etions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/dev-tools/reformat-shell=2Esh b/dev=
-tools/reformat-shell=2Esh</span><br><span>new file mode 100755</span><br><=
span>index 0000000=2E=2Edbbdaa9</span><br><span>--- /dev/null</span><br><sp=
an>+++ b/dev-tools/reformat-shell=2Esh</span><br><span>@@ -0,0 +1,14 @@</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/sh</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# Apply consistent formatting to our shell code=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Uses shfmt: https:=
//github=2Ecom/mvdan/sh</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set -u</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+FORMAT_ARGS=3D&quot;--indent=3D4 --func-next-li=
ne --case-indent&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+FORMAT_CMD=3D&quot;shfmt --list --write&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# hardcoded to --posix due to =2Ein filename and invalid shebang<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+$FORMAT_CMD --posix =
$FORMAT_ARGS =2E/tests/t_client=2Esh=2Ein</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# handle *=2Esh files recursively</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+$FORMAT_CMD $FORMAT_ARGS =2E/tests =2E/=
dev-tools</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Demail">change 1792</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none=
"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branc=
h: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I80a94dde26=
631e5a665029f495b2104cfecb1915 </div>
<div style=3D"display:none"> Gerrit-C=
hange-Number: 1792 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ralf_lici &=
lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--66jCI1i44Q0=--


--===============5046692395378645540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5046692395378645540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5046692395378645540==--

