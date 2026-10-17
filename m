Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AD2CCF2D2
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 16:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=oGk0EAQ6YKc+DGo7me+NJ+KZgF1Hd1iBSpuw871sIgk=; b=gE46tdNsCAJ/p8
	uuxj8XT6njyG54cWQ/u9u6goLO1f6WOzmqBX+nlwOQuAss5n04PsHOr5I1pLSa7dh0XDUcjSEeKZE
	EVBDTRguLLFoxkkRZzKbYffKRxjDSeDs45ebCKZZzfwGUnqoShA8jub3oDWkR7GWkNCTxkVmpZmWd
	uWA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI7Z9-0007QX-96;
	Sat, 17 Oct 2026 16:47:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xI7Z4-0007QO-8N
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:47:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YbnEum7QKbg83XOwCSSkdjYOHrHWn7ez8qKVHosFZgg=; b=cbj6SPXdMc+tL8kOtgR2yoTsVf
 qEBte2UC/FBr3F6Kc7bpDsQYcxJbMNyRY6vbovu6Ph8RD4/NpiT8dvaUxBYNf/MMPCjCY8mq/ql5k
 pofFksCuSJxqFaEXdpby9D9FF8SEJ1y7wFfj1sMOqh3SkAMHqboLcJtHqCXgPFTndP1g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YbnEum7QKbg83XOwCSSkdjYOHrHWn7ez8qKVHosFZgg=; b=i
 HgIW3r/g7vkVGS85YewLfYhEKDD+hc+mHV9+HvSloIhjboTrjt4AVb/6pbIAYEeVCh8yFdNR3lzrd
 7Hi0rKkeyY8NRMJGaiRtd7MBtqIZpqikOR/lAPKGZ6WMdYiPzNX/C3i2o2nrkaqhFx1QhB9z540Xn
 3ZPfUgw+oYf5yFHs=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xI7Z4-00068u-AL for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 16:47:22 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a1d484b4a9so11676355e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792255636; x=1792860436; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YbnEum7QKbg83XOwCSSkdjYOHrHWn7ez8qKVHosFZgg=;
 b=P2g19lF5/yM17ABG6mC9lj4FPB2QUNNNlSCwjMi/kD1BMuxbBrmwnnj6xqhDTa8nTl
 c/rgoY1Afw+hQuhLdQxh8UIlf7durUMWSvkgzjn+3FVCAEGPXaTcqPuc9/u40sEIggPF
 gHAC5/YrCzpHn0GCPy1xX/gFrUATRZc8yKu4q1x9B97fHC4Gb0a0ysW+XegMIIKst5Is
 b1D9piUF4XCAchNiJUxMsJcOyT+CpaW/a7zZCYQObA3Wua7Vks0IqxswlGJ3v8cSaAIt
 +VZRM2mMY52EzeD8YTVkdSRM3g3dSWT4P7CcO27eL8ZWddizGdMAYJJiiLI8/Etd0x7d
 9/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792255636; x=1792860436;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YbnEum7QKbg83XOwCSSkdjYOHrHWn7ez8qKVHosFZgg=;
 b=sKP/ngM31feuNscQigR4ar8YEDDSVfvOKCmVGR6R3NQ1Zk//88WOf0yGhXvRKOR7fT
 4QePwQfJEi4bWF7Jeeh6FaURTQMseg3e3Gy5EFVhRQ7Rl2P4CTaX2m48+OLrT3eCOAux
 gslgRWaXzB7HMw9fJeKkW0scV32j/DAwm2uZBORYAcOQvdhJUpmfYYbFubxpZn0biFwn
 JwO1su2MKRVViNJEpeVrSnAJ+Pe2Gqfv7wj3jXPWpMQYmtJ1luQE0TPdT+wla8ttVIsr
 qm2oemyq9DszfbSZO1f9+xRbzUoM/q3CaItSu1Oo4BZiG9873JpRQpsXwBE9yHCGTg6u
 KUzQ==
X-Gm-Message-State: AFq9FYIGv1ZN+UTeOU4Ae+I3MOcL8ee+5YuqChJRQEmw0jC/DJIIUJ7S
 VWqx/TdS8NrDgVgc9Sb/EDQBYFBfopp7ENys3xZZaasCThbrdkkdhs4DYuW57TlnUma3RS3BfSk
 tJXH7LMhzPLVvail8+duZf7Wf1d13Vm8TKHsHuJ70IGUEO+6qHxqeJie1WZ3ENdKrRNfEwX6Bmq
 LFrDLqgQ==
X-Gm-Gg: AYBFou3bqASoI6HyqDl3JNaKQJUJ15XL34gEVRekNHsoPushQSgLBE06imKFUu18fCP
 RXPOO8E8agNcuTtr+HgsGg3p7XFc5rK+qJj5lYH0RxK5hVhshRepY3M/a+MYtx1ftSD2Yn/n51m
 HLq1/pPAAyQ8xaKwD6yXLFu/6Ouc5jlILaHViaHFzUldrp7TVNt8HovhRhvQooCIb2f/KSkMQfx
 o3ACwNcyxigvQEN0ok/g6733l3ad7w317lTHHP/KIo8S9AduMcjK1HP9E1XP0KdKnDZv85pFXhC
 WOCEZakiKBs6HcwxF8A4Jsf+vCV1J9QTgeZ97bTMYcs64baWekUUULBccz+FLQ+ete54/jpgZaZ
 aOtMdaa4hM+g/THXixLhN7SM5MPmqa62sRx/wofcUAFJMf0gS7dwtwv1cae6dGPwwRu4sb+UARi
 4DyT+5Z+RWxKOsQjaNi+Zd2i1+O7kES4q+a2dVoXUmQYwO10eSWNAbNA+9sHztZKUG6HvhVeOiM
 78hk9cah09zNwHktExkLF43o7Kyvo4dYeshbtw/EccArJd7cVw0NXpn215R3PBXCzSzHcHVW7Cp
 6XgX6xT/d9fPgz5J85lrzimebEhjerKOEh431G4A8oh/kyOW/J2pAnZbZu+Z
X-Received: by 2002:a05:600c:6218:b0:4a1:ddaa:571e with SMTP id
 5b1f17b1804b1-4a1ddaa5803mr38155025e9.15.1792255635528; 
 Sat, 17 Oct 2026 09:47:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4c5942sm17859069f8f.16.2026.10.17.09.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 09:47:15 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 16:47:14 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c
X-Gerrit-Change-Number: 2005
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2005?usp=email>
X-Gerrit-Commit: 95741acc59940c22f4234fbd677945bb9b5e8d7c
References: <gerrit.1792255622000.I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLkk2YjAzYmE5MzkzODdjMmE4NzMxMDVmNmI2Y2Q1ZjE4ZWZiZjRkZDRjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d80636a94540e58051c0bce0803f65b50ebb5c9a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xI7Z4-00068u-AL
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: Avoid
 conversion warnings in send_push_options
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8928925204056572091=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8928925204056572091==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/fZwWtuYv/A="; charset=UTF-8

--/fZwWtuYv/A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2005?usp=3Demail

to review the following change=2E
=


Change subject: push: Avoid conversion warnings in send_push_options
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

push: Avoid conv=
ersion warnings in send_push_options

Make sure we have a sane length and c=
onvert it to int=2E

Change-Id: I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c
S=
igned-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn=
/push=2Ec
1 file changed, 8 insertions(+), 12 deletions(-)



  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/05/2005/1

diff --git=
 a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index 8dfe0d5=2E=2Ead95a0f 1=
00644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -733,11 +733=
,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC=
 diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 =
static bool
 send_push_options(struct context *c, struct buffer *buf, struc=
t push_list *push_list, int safe_cap,
                   bool *push_sent, b=
ool *multi_push)
@@ -748,8 +743,13 @@
     {
         if (e->enable)
      =
   {
-            const int l =3D strlen(e->option);
-            if (BLEN(=
buf) + l >=3D safe_cap)
+            const size_t l =3D strlen(e->option);
=
+            if (!buf_size_valid(l))
+            {
+                msg(M_=
WARN, "--push option is too long");
+                return false;
+       =
     }
+            if (BLEN(buf) + (int)l >=3D safe_cap)
             {
  =
               buf_printf(buf, ",push-continuation 2");
                 {
=
@@ -764,7 +764,7 @@
                     buf_printf(buf, "%s", push_reply_c=
md);
                 }
             }
-            if (BLEN(buf) + l >=3D =
safe_cap)
+            if (BLEN(buf) + (int)l >=3D safe_cap)
             {=

                 msg(M_WARN, "--push option is too long");
               =
  return false;
@@ -776,10 +776,6 @@
     return true;
 }
 
-#if defined(__=
GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 =
send_push_reply_auth_token(struct tls_multi *multi)
 {

-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2005?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I6b03ba939387c2a873105f6b6cd5f18efbf4=
dd4c
Gerrit-Change-Number: 2005
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--/fZwWtuYv/A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2005?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">push: Avoid conversion warnings in send_push_options<br><b=
r>Make sure we have a sane length and convert it to int=2E<br><br>Change-Id=
: I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c<br>Signed-off-by: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/push=2Ec<br>1 =
file changed, 8 insertions(+), 12 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/05/2005/1</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><=
span>index 8dfe0d5=2E=2Ead95a0f 100644</span><br><span>--- a/src/openvpn/pu=
sh=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -733,1=
1 +733,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> static bool</span><br><span> send_p=
ush_options(struct context *c, struct buffer *buf, struct push_list *push_l=
ist, int safe_cap,</span><br><span>                   bool *push_sent, bool=
 *multi_push)</span><br><span>@@ -748,8 +743,13 @@</span><br><span>     {</=
span><br><span>         if (e-&gt;enable)</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            const int l =3D =
strlen(e-&gt;option);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            if (BLEN(buf) + l &gt;=3D safe_cap)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            const size_t l =3D strlen(e-&gt;opt=
ion);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 (!buf_size_valid(l))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            msg(M_WARN, &quot;--push option is too long&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                return false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (BLEN(buf) +=
 (int)l &gt;=3D safe_cap)</span><br><span>             {</span><br><span>  =
               buf_printf(buf, &quot;,push-continuation 2&quot;);</span><br=
><span>                 {</span><br><span>@@ -764,7 +764,7 @@</span><br><sp=
an>                     buf_printf(buf, &quot;%s&quot;, push_reply_cmd);</s=
pan><br><span>                 }</span><br><span>             }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            if (BLEN(buf) + l &gt=
;=3D safe_cap)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if (BLEN(buf) + (int)l &gt;=3D safe_cap)</span><br><span>           =
  {</span><br><span>                 msg(M_WARN, &quot;--push option is too=
 long&quot;);</span><br><span>                 return false;</span><br><spa=
n>@@ -776,10 +776,6 @@</span><br><span>     return true;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> void</span><br><span> send_push_reply_auth_token=
(struct tls_multi *multi)</span><br><span> {</span><br></pre><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2005?usp=3Demail"=
>change 2005</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
05?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I6b03ba939387c2a873105f6b6cd5f18efbf4dd4c </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2005 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></=
html>
--/fZwWtuYv/A=--


--===============8928925204056572091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8928925204056572091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8928925204056572091==--

