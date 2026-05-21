Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33237CD5BAF
	for <openvpn-devel@archiver.kernel.org>; Thu, 21 May 2026 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=XcnOoNcaHC7OXgwH6gC0RGfw2CAM9oEhiMEo8XxJrJA=; b=I6WKvRwnCeaVDb
	pV1BwkW9w+TTmB5VoSAS77CaF1qZYJrgzTjlzvUrQXUzOvBJZgrxFPQZJa/CgoocThMyCvAsLWA6g
	6s+KP8qqm5A6f8x4Z1GuufccLagtsLAuNwp/xEKhN6wz3myJvDyKO9jA6xWL6akfKddDA0tsfbiAJ
	EPo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wQ6UW-0006CI-OB;
	Thu, 21 May 2026 16:43:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wQ6UV-0006CA-1K
 for openvpn-devel@lists.sourceforge.net;
 Thu, 21 May 2026 16:43:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WxuGZsB5dWV4GV8Llwf8kiND7wsVLPckCs5QFtZm1hE=; b=gBqigZszPVBHvaSSiwWrK7XCYM
 Gi4zTrSXxpb4UY51Bp7v9k8Zb4YR7aYlKKb4thL96uvvHvaUQvlPNWpirdy8pmJhEBmGY2SWTSfoX
 diS7Wbmnd8YGa00z6yDE2kKtUDFrbZyf1kmWwZKJYzvxKksYcjFhqiVim65lSCRlqfQ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WxuGZsB5dWV4GV8Llwf8kiND7wsVLPckCs5QFtZm1hE=; b=E
 BtoJ6z1Ypo1J3ssP6OqUSJF6yFgcLvBwM76PgVECKOnsrgpKxXlfejjsdYsUqXh5qG0tQD5A4PmwU
 Ib65lI339SG5y18z2hApQgTWenAMPJRqUkQPY6xzzbKPaDscQ/vZhlxSWhp5WKUtlt7lYmjFHhuf7
 FX0PHAJXf3wz8eHU=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wQ6UT-0001Km-3t for openvpn-devel@lists.sourceforge.net;
 Thu, 21 May 2026 16:43:22 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso65236975e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 21 May 2026 09:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779381790; x=1779986590; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WxuGZsB5dWV4GV8Llwf8kiND7wsVLPckCs5QFtZm1hE=;
 b=gjKqZXL6lrxMgjv/j29A+Z62ypKiwHX+585/XDiUxYcQNwbU2qCPm0W9cqrTH17i21
 FXvDCoc/olXk7hoBH8uRg766J/+PYuGTZtfpnAvMbNizB+EnmLkoEiZGEluB5WnWm92z
 QlFewjC5GgR7gbmTtcNX3viCW2Go0LGvsTd3FackRb/00YuMi4R0prAvgoonmldHvIAn
 SJ1K5ZbJx2gpsUIas1OiUhw5wBxfwU4Q9yKJZRQY4IGFH6+Zpvsp9keFHm9OA8M3XMRm
 3raFXZt2ShW4F+IdFDrojgjoIM6yC8N1jCv0qlWP3ar7emzodA7nPKK09SoydR0ARDnm
 4DjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779381790; x=1779986590;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WxuGZsB5dWV4GV8Llwf8kiND7wsVLPckCs5QFtZm1hE=;
 b=m/4rvI9Ge8loE4v97A2+Z/9fO1ZXrUvxSSSGWNa43TJm5fScOTmwUHwRdqAArG6238
 Vv6GEVlNQperVVVQ4dHz1ctTFH+VZiV48E4HybcEg63P8F//BaETI0K6Sy8xCdhKbBuT
 VMr8Vymd/vBbP+iAFtYOtISJP1dqptxRQLwhvD5MqHwklRO+lXmCtw7OVUPW49iCdOge
 zNz/7e/xgwlYtZlzDCmwPQzE2E8goPqnTtjEPjNsHIcxATpJordLGdKrYsE3JVQl3UIz
 X0WBADqz1yoPOa1ndWRvSCVwnfy1Q6NiS0FnNFIPBg1cXh46ikfvmlCtJHqmKk0khx40
 tDlA==
X-Gm-Message-State: AOJu0YwRQphl2WfE2F+SaBEr8JIzlV6Js0CzDKJOaWtf5RvLGFVDIt/M
 2uXVMnUyYFUNh/b2gbrIC1ELAPXW07PpI1fxmm0apt2AK/7QEaiK1flp8U9x6yobSzWPJFJDIHx
 TU5857FT/0tJ5u8Nca2PDfF1crBbDaJHDzSEUj17VHO/IgBRcO0tXezi5xepu0Oy1mtH9xNmGnb
 3mhZJa4g==
X-Gm-Gg: Acq92OE7upppc9f5ZLLqijMSinYSZOsjPjiwuhgFND9nH/oJDyu40Na+8innbMzFk2c
 3V4Z97jYI31V9+NaN9u/k9Yblcpz4QDqDiGRgrd6j146kDBErPgo4SQo0b1zMSQ5EAcCZ1pefAN
 ewld+SfjuD2yebysJQj7qFil/lIM+UAEl83LEzRk6hKaOrhxEiRCHNrLNVSRYwqpeKSiQjgbY7V
 b4QB6oAZ8a7MY+6A4qqkGeiQe0k6lJarc+fOH2KgMTSJ7yVWcoY8uso8Q9jtDX8iGEX6u+zSGEN
 1V0nkARqvcuUNfNBKWHeo2b7tJmtAhnPnnU7VbEK3cyfefm4mE7z8KFFcJpEJkTRMn5G3RZPJxV
 Z3NVBjjqX2oSPVSVEMwIAD3Him31gXsabjrKCF/OKIB7HRzpcpMwIPG7X2wpEER47zTLWwvIrAT
 oi/8cYzioWTkIHluLbDlrhLJpmN15AOQO3AK2VQLsGvv3G3DDLqwgzj8wUF9UFUt5poH1mA0UVr
 8kgimPuHHLASEviU7wq1UeYvNfGziU9jcEBYr/+hajGlG+u2zHyeBBWmAhOHuSEOa/sAmRakUd8
 Cu1ewhXLSo5m3Q==
X-Received: by 2002:a05:600c:6211:b0:490:3c83:433a with SMTP id
 5b1f17b1804b1-4903c834541mr39189965e9.15.1779381789835; 
 Thu, 21 May 2026 09:43:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903c9a5b67sm39858245e9.7.2026.05.21.09.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 09:43:09 -0700 (PDT)
From: "MaxF (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 21 May 2026 16:43:09 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5
X-Gerrit-Change-Number: 1701
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1701?usp=email>
X-Gerrit-Commit: 8c28f890128eb7beab953a326abf4f0b82ab24e3
References: <gerrit.1779381787000.I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MzgxNzg3MDAwLkkyY2E4YmY5MGE3OTZmMmI3NTdjMmZkZTBhZTI0NDY4ZWYzYWJjM2I1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4a3bb83eb92b3a9add4ebe1ced86bd009b965d94-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wQ6UT-0001Km-3t
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Null-terminate
 tls-crypt client keys when testing
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
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0469260114318418699=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0469260114318418699==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SzQnguj9D5c="; charset=UTF-8

--SzQnguj9D5c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1701?usp=3Demail

to review the following change=2E


Chang=
e subject: Null-terminate tls-crypt client keys when testing
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Null-terminate tls-crypt =
client keys when testing

After generating a tls-crypt-v2 client key, OpenV=
PN will try to load the
generated key to verify that it was generated corre=
ctly=2E If the client
key is not written to disk but printed out on the com=
mand line, the PEM
encoded key is stored in memory and read_pem_key_file is=
 called with
key_file_inline =3D true=2E However, this key is not a null-te=
rminated
string, so we end up calling strlen on a buffer that isn't
null-te=
rminated=2E

This commit adds a null-byte at the end of the key=2E

Change-=
Id: I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5
Signed-off-by: Max Fillinger =
<maximilian=2Efillinger@sentyron=2Ecom>
---
M src/openvpn/tls_crypt=2Ec
1 f=
ile changed, 2 insertions(+), 1 deletion(-)



  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/01/1701/1

diff --git a/src/openvpn/=
tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index e91f80c=2E=2E8c3d722 100644=

--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -758,9 =
+758,10 @@
 
     if (!filename || streq(filename, ""))
     {
-        pri=
ntf("%=2E*s\n", BLEN(&client_key_pem), BPTR(&client_key_pem));
+        buf=
_null_terminate(&client_key_pem);
         client_file =3D (const char *)BP=
TR(&client_key_pem);
         client_inline =3D true;
+        printf("%s\n=
", client_file);
     }
     else if (!buffer_write_file(filename, &client_=
key_pem))
     {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1701?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2=
ca8bf90a796f2b757c2fde0ae24468ef3abc3b5
Gerrit-Change-Number: 1701
Gerrit-P=
atchSet: 1
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2=
549=2Eorg>

--SzQnguj9D5c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>MaxF would like plaisthos to <st=
rong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1701?usp=3Demail">View Change</a></p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Nul=
l-terminate tls-crypt client keys when testing<br><br>After generating a tl=
s-crypt-v2 client key, OpenVPN will try to load the<br>generated key to ver=
ify that it was generated correctly=2E If the client<br>key is not written =
to disk but printed out on the command line, the PEM<br>encoded key is stor=
ed in memory and read_pem_key_file is called with<br>key_file_inline =3D tr=
ue=2E However, this key is not a null-terminated<br>string, so we end up ca=
lling strlen on a buffer that isn&#39;t<br>null-terminated=2E<br><br>This c=
ommit adds a null-byte at the end of the key=2E<br><br>Change-Id: I2ca8bf90=
a796f2b757c2fde0ae24468ef3abc3b5<br>Signed-off-by: Max Fillinger &lt;maximi=
lian=2Efillinger@sentyron=2Ecom&gt;<br>---<br>M src/openvpn/tls_crypt=2Ec<b=
r>1 file changed, 2 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/01/1701/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec=
</span><br><span>index e91f80c=2E=2E8c3d722 100644</span><br><span>--- a/sr=
c/openvpn/tls_crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</sp=
an><br><span>@@ -758,9 +758,10 @@</span><br><span> </span><br><span>     if=
 (!filename || streq(filename, &quot;&quot;))</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        printf(&quot;%=2E*s\=
n&quot;, BLEN(&amp;client_key_pem), BPTR(&amp;client_key_pem));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        buf_null_terminate(&amp=
;client_key_pem);</span><br><span>         client_file =3D (const char *)BP=
TR(&amp;client_key_pem);</span><br><span>         client_inline =3D true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        printf(&quot;=
%s\n&quot;, client_file);</span><br><span>     }</span><br><span>     else =
if (!buffer_write_file(filename, &amp;client_key_pem))</span><br><span>    =
 {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1701?usp=3Demail">change 1701</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1701?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2ca8bf90a796f2b=
757c2fde0ae24468ef3abc3b5 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1701 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>=

<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>

</body></html>
--SzQnguj9D5c=--


--===============0469260114318418699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0469260114318418699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0469260114318418699==--

