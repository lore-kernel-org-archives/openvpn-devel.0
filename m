Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90505C5DF86
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IS0RtufUDa8GrS6+HIhPh1yjtAicgvuc1ehwSFJaSa0=; b=WfR9lvTTWzWrxCnqYwTEnKMyYO
	OJatUhBrIxdq3KhXhYQPrmD2um+VdSAaYoBoJNWO0u5+TulsloR/Pp1AtiugZa66WTw4B353+ILMd
	+dwZU80jRqgr6IpLMBX5KvS/hVsYglNGg10DoW9C1ZRSP69P37LnKmasTFQuEY/uf8So=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwgCe-00035h-59;
	Wed, 19 Aug 2026 13:19:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwgCK-00035P-VB
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:19:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=065WjJC0QnXiF8OpzmckYt1h845PsZOqWDjglXFejr0=; b=gh4lDnujDEJsSfBscwvmMjQrBW
 pen4afQ0kz3WJ8CXlEfnsQ3r5z+P3RUIauC0e/EgpX3YQenuPr9Os853XWgtaqIbxVbWvo5u62LU7
 9eEA8Vtgv49ivigq9X8ajx7mlgY/xp/f+r5JkobC9nwTJt5PxD1WtURDYDe4MbGFF+2I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=065WjJC0QnXiF8OpzmckYt1h845PsZOqWDjglXFejr0=; b=a
 A4GhRshpo/9EoN+DDUwqM5WKb2LjHHuL4xpQ847b/PNEiHIY909An2l6mK7bSr2wwluDVI5c+EdD2
 C/xQk08MgtRfNdrZ+4x2vcEVnjJTG7zTtxYnUWtHxxcmRYSCQpfN1XcgPtjbJgUFOm/CnJ0Vvh4FA
 lcH1f52l251DnVPQ=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwgCI-00036B-9o for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:19:12 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4954dff6536so8589575e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 06:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787145544; x=1787750344; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=065WjJC0QnXiF8OpzmckYt1h845PsZOqWDjglXFejr0=;
 b=FkYjVtSKt+gbzL16Z0TkredvllMIh8uBwzJRcwgoLI0uB76njbTh97PB/5+dMuSaKO
 5G2qUIvSxgcGra699qTvO9pUmVb9xmNh9omj6LeilP7GKuEFIOSLJXZU0saK76qWMfh/
 SbAUjbuoT7ehlnHbWmp7J7R6lVkcOKD0O5BWVrUjaoE3hfCB3RJP81d8pCKeU/EVVtKc
 jrd5oIrsPgqWNtPd36CIqlBMvOcwjhGsPiONj6EyXiaEIsvfLxUaTWE9vC8zAjGUwpgX
 kCgbwZgJiYIsZ0nVT4eFFnZYCHDAynUi6VbrHSO/VVIdjdCnCXa9UzTPBQFQt6fD2Ufl
 AwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787145544; x=1787750344;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=065WjJC0QnXiF8OpzmckYt1h845PsZOqWDjglXFejr0=;
 b=X6DScrLMnKM4Y7DAH8EwoS/p5UKu0y1p1guv6JpQBBm9NB7WCjyM+yzXjgXgViJclu
 oj1UMWfFDUAGldkKntFSaMSjIPJe2HTiMcuYPL5fFM5pZ1riUVekZOVV7qwKhw/ip82h
 9M4uNWcqUA2nkTWBFLiskbqC9g94Ozq/JpeYBqIMJ4m3WQ1M5CyZr51txFWrcl3WBlET
 y5nrnKtgG1ULQ815DDjhPWLrH5bEV5Qv0np1PJCmp3juHEnLVYj21hwmgzCHvNFwWKDp
 mu12+nPnT93w5fbv19w+1SC2AcWvRIyneQF+Rx6t4nlHqXJbukScxhRbDJpf7qZMYdnd
 Ljgg==
X-Gm-Message-State: AOJu0Yy7mbBuQOXvBEevBkI5hBGCOCgS1EOWPZLbJRrEP/cgI2TdGrUt
 LrFfyvBMoNMefffHWSqjAPdqrRbxxy9+wu0mNdP0BDeUve5xfTUZjwZ9HKGzRtqYz8lpyIgy8WY
 vBMy6f8IEHhPAFDjmP+uJRRboYOiU+ztUb1MlGjL+tf0geEzeINxkf6Dbp1h+wzx5+wjQ
X-Gm-Gg: AR+sD11SruV1C3cdDJ6l5bxhXOVdhAR+xXFFp7/XYkWiIyc+m4Dy/bPPtqWSuhMcKEH
 rXSZAUlwz9yKr2k6mU0vyt2xqjQo3Hr2rKFymNmDKqZpv72oPgBNQ5NiA/TifBAVmtgevYmM6Xm
 ShKCluzELn+UiRiD+FxKghRzVu+bPrKvAGb1KyVmcBd6gv1wz1Wn9Ymb+6+tkHBSmB7+sMgEsiX
 lACGE3CX9LL1cQQ0RxXCuwrPvBCZXDt73NSlHnZtU2KJC4j2syZ5MB8nmmEUjhp7YB4Q6Yd3530
 8zeFyIe63JUES6XkMQzXPvOpu1gGORxbrDU02/Ra8mZqhGZ16DkHSAaZGBh5fMBnKQ5jukxYm7u
 00pl5dHAQriSyrxbBZvoVZ3mKTfwJl+1SBNU2Qww6wltiN5aHi7I8QXWhr8CPxf7v2VtCV+JJOd
 BImvHrGhHJPTsqsL5yjEzHKJZFDI7drUUtS4wIgJXh+VrJB8n5uIri6ekY4KFC4Il5TFdAzUaRz
 5Flr0PDUpErUvjbTvsrNpTqXglUUvu2AshCJV1s9FZVLU11/6KPAUspmnaWj2ZQ0yRgCAlHBkhF
 sXN9Z3fpjvIkzHbPzsn+nStsQsoh+ZxYg/3jy42mj5KsvRoESaI=
X-Received: by 2002:a05:600c:628d:b0:499:8ae1:b900 with SMTP id
 5b1f17b1804b1-499aa1c9610mr92298465e9.12.1787145544127; 
 Wed, 19 Aug 2026 06:19:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1947c6sm57279085e9.15.2026.08.19.06.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:19:03 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 13:18:58 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I80a94dde26631e5a665029f495b2104cfecb1915
X-Gerrit-Change-Number: 1792
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1792?usp=email>
X-Gerrit-Commit: 718da44ae0e0c3164b55df79ea27ec05814231a2
In-Reply-To: <gerrit.1784305303000.I80a94dde26631e5a665029f495b2104cfecb1915@gerrit.openvpn.net>
References: <gerrit.1784305303000.I80a94dde26631e5a665029f495b2104cfecb1915@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLkk4MGE5NGRkZTI2NjMxZTVhNjY1MDI5ZjQ5NWIyMTA0Y2ZlY2IxOTE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <be64a492c9eb8a593e631ebf62fea2e8dc7c722b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwgCI-00036B-9o
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5341197779257211632=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5341197779257211632==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CGEZxG5YJq0="; charset=UTF-8

--CGEZxG5YJq0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, razvanc, 

I'd like you to reexamine a change=2E Please visit

    =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Demail

to look at the =
new patch set (#4)=2E

The change is no longer submittable: checks~ChecksSu=
bmitRule is unsatisfied now=2E


Change subject: dev-tools/reformat-shell=
=2Esh: Make our shell code more consistent
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dev-tools/reformat-shell=2Esh: Make our she=
ll code more consistent

Our shell code is currently not very consistent ab=
out
formatting=2E So provide a tool to achieve that consistency=2E
Especial=
ly in our test code we have several important shell
scripts that we activel=
y develop=2E

Change-Id: I80a94dde26631e5a665029f495b2104cfecb1915
Signed-o=
ff-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
A dev-tools/reformat=
-shell=2Esh
1 file changed, 14 insertions(+), 0 deletions(-)


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/92/1792/4

diff --gi=
t a/dev-tools/reformat-shell=2Esh b/dev-tools/reformat-shell=2Esh
new file =
mode 100755
index 0000000=2E=2Edbbdaa9
--- /dev/null
+++ b/dev-tools/reform=
at-shell=2Esh
@@ -0,0 +1,14 @@
+#!/bin/sh
+#
+# Apply consistent formatting=
 to our shell code=2E
+# Uses shfmt: https://github=2Ecom/mvdan/sh
+
+set -=
u
+
+FORMAT_ARGS=3D"--indent=3D4 --func-next-line --case-indent"
+FORMAT_CM=
D=3D"shfmt --list --write"
+
+# hardcoded to --posix due to =2Ein filename =
and invalid shebang
+$FORMAT_CMD --posix $FORMAT_ARGS =2E/tests/t_client=2E=
sh=2Ein
+# handle *=2Esh files recursively
+$FORMAT_CMD $FORMAT_ARGS =2E/te=
sts =2E/dev-tools

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1792?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I80a94dde26631e5a665029f495b2104cfecb1915
Gerrit-Change-Number: 1792
Gerri=
t-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <r=
azvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--CGEZxG5YJq0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Demail">View Change</a></p><p=
>The change is no longer submittable: checks~ChecksSubmitRule is unsatisfie=
d now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">dev-tools/reformat-shell=2Esh: Make our shell cod=
e more consistent<br><br>Our shell code is currently not very consistent ab=
out<br>formatting=2E So provide a tool to achieve that consistency=2E<br>Es=
pecially in our test code we have several important shell<br>scripts that w=
e actively develop=2E<br><br>Change-Id: I80a94dde26631e5a665029f495b2104cfe=
cb1915<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<=
br>---<br>A dev-tools/reformat-shell=2Esh<br>1 file changed, 14 insertions(=
+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/92/1792/4</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-tool=
s/reformat-shell=2Esh b/dev-tools/reformat-shell=2Esh</span><br><span>new f=
ile mode 100755</span><br><span>index 0000000=2E=2Edbbdaa9</span><br><span>=
--- /dev/null</span><br><span>+++ b/dev-tools/reformat-shell=2Esh</span><br=
><span>@@ -0,0 +1,14 @@</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#!/bin/sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# Apply consistent forma=
tting to our shell code=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+# Uses shfmt: https://github=2Ecom/mvdan/sh</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+set -u</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+FORMAT_ARGS=3D&quot;=
--indent=3D4 --func-next-line --case-indent&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+FORMAT_CMD=3D&quot;shfmt --list --write&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# hardcoded to --posix due to =2Ein fi=
lename and invalid shebang</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+$FORMAT_CMD --posix $FORMAT_ARGS =2E/tests/t_client=2Esh=2Ein</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# handle *=2Esh files recu=
rsively</span><br><span style=3D"color: hsl(120, 100%, 40%);">+$FORMAT_CMD =
$FORMAT_ARGS =2E/tests =2E/dev-tools</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=
=3Demail">change 1792</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1792?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I80a94dde26631e5a665029f495b2104cfecb1915 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1792 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>

</body></html>
--CGEZxG5YJq0=--


--===============5341197779257211632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5341197779257211632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5341197779257211632==--

