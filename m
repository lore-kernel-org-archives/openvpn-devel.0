Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1586FC61DD6
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=xD2PVFTmVyqyS/C9AdOg1vf5lZRw27zqqhS0/SmXusE=; b=JcF4ggI72YUpN2
	oLmiXvPdXWQEE1UaEmlTDYIOIaeX5eehCgDgbW4ejvS4R/p6lPXF3q6orKtukAX4jUF2ZlEr3gah/
	XmdpPA4sslUe1R9rmsGn4Q5rAizXjhQk5WG5rAKijWcCcEnPx/KyYoPRY07HyRkoDpAcgmMbzf2Lk
	jNM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1VPQ-0002cN-FJ;
	Tue, 01 Sep 2026 20:48:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1VPO-0002cE-Oz
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 20:48:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bZ0PvMTSIKBnAwfaT1CBon6v5boVp7sEFqBAJbLNXa8=; b=hnBclgP9ZFM4mgmvbftTQa4r3L
 9lv/qYuKWLBiwxvm1IT97qcn5bgiBWNc+EDheWnPR/yFXoBwpZub1xQ2fW5bbpBXoHTtMpldW3mh6
 35XZlYv93bCTjTtNqO0Iu5aVq3MCdszHfpgjXhH73SRCMIAUwFkWAEO8Olzk4/qNAyuE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bZ0PvMTSIKBnAwfaT1CBon6v5boVp7sEFqBAJbLNXa8=; b=g
 3NWKX5P7jC/0AR5hOUTL4+5rnEyECWiiew4v8IuFVk2Gu7vupAAqad4ef+P10xfwZl7CgI+URkkQd
 H0baqSVtzCbzuzVuuGdch/8tD0FRiOxPS0xiBe8RfTyoWJ0u0/TXXf3qbIvnz33AJOO/oBTYqGB9s
 yON3uulcoPm6NS0w=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1VPK-0004Vt-Mo for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 20:48:40 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso2864145e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 13:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788295712; x=1788900512; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bZ0PvMTSIKBnAwfaT1CBon6v5boVp7sEFqBAJbLNXa8=;
 b=SWmtQHe2FuBLJcwFkGgIT8nRHKrKWrciXG7EOOyJKUqZUN4MrmpIlkBfSGd7CIgdhi
 +RNGjLUn6fVFi1uwlji4FP3lx60DmAux4ExichXBBIUusHj1wVgP8FSqyVGUTWf19IyN
 D2nfXOYJRqzUArzdUohwrCvqFkARzNBORQ4o3icw7OzGBiw6Na571NegETboBWHtGFot
 ThOagaEu2qaj1DyDKkhPOixXYqSQ5cNQo057dxhFBvs64OlVP7XNXQy7l45gTdNF/Imu
 q+i2yK57tJQn2F3gQlkS9+/c0nhYvA1ElxRkQYiAF22slxClN889wb21ph4vhpcVa3bU
 VM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788295712; x=1788900512;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bZ0PvMTSIKBnAwfaT1CBon6v5boVp7sEFqBAJbLNXa8=;
 b=doXCBPaUej2bg12xYkL41WpqId9xXnB2Uv0bv6ZIAXGUJLIHrWJJYXaNLF8pqOcSpP
 AuVnqkqH2mU+PtoP37uF5LOPcj9kgLeYyMNIv5aAVgl/SG79s5fK/AO50XfqvFuw9+YH
 adPv7+fB7MbrI510EERngF+JnJTbUWSWQmBWppNtGXGktPyWIl4bp79wq9NU99v9MO6Q
 9VGuT4IKWyNoCXMvf80mB/O03g/vMKn4QXxh0JMgHPkMWBLuEqaT31tSwtO+S/zNBi5V
 GeBVqkxj3pave5CqlFhVX8P6puhTuAZ8P492iS1WGKBxqcYXK/Ry1Gk5LCJFZtIONM+F
 xnXA==
X-Gm-Message-State: AFuF++m0H4NehTG+1uYAVbZCn0/ocP4KpT2R9xhTvd4UvDHTo6C2dqz7
 fTTecq8/v6eNgy9TYTFKNDxYmkBMsIjzOhm42v/v61XueIPyybVA1DrQCNu10cUteFOVJTCfkjx
 iY7z9p349BdmfdHpoRZPiZ5Y0XBx9g2/xKShKJAFKVFnxEH6gX1qVoJ5czSOA4DRqNsDnU11co3
 sWVcXZgg==
X-Gm-Gg: AR+sD11K1LkqKA3HazauescF+yqtjrfIjmjRkza3Y6+vc5PTaYBQAZdT1uiCuNTPuQp
 NqPYsZpcxQvr1nn/3DvQ5qv8zIxunG73QmyuNW3jz06j7f+kkW7qP9+dgoZkfItRVZR1445zBvt
 9+mfIi/871mi0wYFEg+EN5S3dDCPRT3LO8lxTtQ+HWo9cvZZTA/dWZPtOJQ4P7wAZwYX4SC+glJ
 Pe9vszACKZnRRgRaPcXiEQsYd3Rjb2D+dRHKYb5b/smVfHCqHUguQu23w7MidjYCAj21hiOPCRo
 pPH3hswy+D9ostPLF+WUqD69tb8uYm0IqGRInmh8RLEyEj1o//46GGw58OLR/XtzsXjX2vbDWly
 Q79IwRZbjE05c+YigN3NgkuRpBBWIc36IgqDLhwmFd6IRP411Wc6y1l/fACvdPQ909+AkFX2Nl5
 WKG8pTpomQV3vv4OQBptZ+2CiSO+zvhSeb3eFvDZ08GF5sQEjVh/Mj6D7c2r2gQMY4ln/QZF71m
 8RiYI8l1KNRMNroNKaElLr7lNbGt0vMDaUxkIi8y8FNhmtpxkCrBr99ZZeLU6jfCd6vPUW0MIl0
 XC0dcwEF3LWuq0sWDFxwlcT9QO5p+iC2fjYROyyp2jen4A6Xo4is
X-Received: by 2002:a05:600c:c16d:b0:49b:47b3:d6d with SMTP id
 5b1f17b1804b1-49ce5842737mr5062555e9.10.1788295711861; 
 Tue, 01 Sep 2026 13:48:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce4774a43sm13059305e9.9.2026.09.01.13.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:48:31 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 20:48:31 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I68429deb39c0bae335d46a4170973a14c644ccf9
X-Gerrit-Change-Number: 1891
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1891?usp=email>
X-Gerrit-Commit: 8de20c8c1408935ebb47b395edb637de4e6818e9
References: <gerrit.1788295708000.I68429deb39c0bae335d46a4170973a14c644ccf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4Mjk1NzA4MDAwLkk2ODQyOWRlYjM5YzBiYWUzMzVkNDZhNDE3MDk3M2ExNGM2NDRjY2Y5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4c2e90c634ba96c585dd17e5a08bb06724d98194-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1VPK-0004Vt-Mo
Subject: [Openvpn-devel] [S] Change in openvpn[master]: win32: quote
 arguments that cmd.exe would reinterpret
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6050129351785307586=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6050129351785307586==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GI3mRde1glQ="; charset=UTF-8

--GI3mRde1glQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1891?usp=3Demail

to review the following change=2E


Chang=
e subject: win32: quote arguments that cmd=2Eexe would reinterpret
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

win32: quote argume=
nts that cmd=2Eexe would reinterpret

wide_cmd_line() only quoted arguments=
 containing a space, so & | < > ^ %
( ) and ! were passed unquoted=2E Creat=
eProcess() runs =2Ebat and =2Ecmd files
through cmd=2Eexe, which parses the=
 command line again, so a certificate
subject passed to --tls-verify could =
start a second command (CERT/CC
VU#123335)=2E

Quote on those characters to=
o=2E Double quotes are already replaced with
'_', so nothing else needs esc=
aping=2E The delimiters , ; and =3D are left
out: cmd=2Eexe uses them to se=
parate %1=2E=2E%9 but cannot run anything with
them, and quoting them would=
 change what existing scripts receive=2E

GitHub: OpenVPN/openvpn-private-i=
ssues#159
Reported-By: Clouditera Security; Z=2Eai Security; NSFOCUS <secur=
ity@clouditera=2Ecom>
CVE: 2026-84256
Change-Id: I68429deb39c0bae335d46a417=
0973a14c644ccf9
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/o=
penvpn/win32=2Ec
1 file changed, 19 insertions(+), 3 deletions(-)



  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/91/1891/1

dif=
f --git a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
index 44b010d=2E=2E=
d527160 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -=
936,6 +936,22 @@
     }
 }
 
+/* special to cmd=2Eexe, which CreateProcess(=
) uses to run =2Ebat/=2Ecmd (VU#123335) */
+#define CMD_QUOTE_TRIGGERS " &|=
<>^%()!"
+
+static bool
+argv_element_needs_quotes(const char *str)
+{
+   =
 for (const char *c =3D str; *c !=3D '\0'; ++c)
+    {
+        if (strchr(=
CMD_QUOTE_TRIGGERS, *c) !=3D NULL)
+        {
+            return true;
+  =
      }
+    }
+    return false;
+}
+
 static WCHAR *
 wide_cmd_line(const=
 struct argv *a, struct gc_arena *gc)
 {
@@ -974,13 +990,13 @@
         {
 =
            buf_printf(&buf, " ");
         }
-        if (string_class(wor=
k, CC_ANY, CC_SPACE))
+        if (argv_element_needs_quotes(work))
       =
  {
-            buf_printf(&buf, "%s", work);
+            buf_printf(&buf=
, "\"%s\"", work);
         }
         else
         {
-            buf_pri=
ntf(&buf, "\"%s\"", work);
+            buf_printf(&buf, "%s", work);
     =
    }
     }
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1891?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
change
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I684=
29deb39c0bae335d46a4170973a14c644ccf9
Gerrit-Change-Number: 1891
Gerrit-Pat=
chSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>

--GI3mRde1glQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>cron2 would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1891?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">wi=
n32: quote arguments that cmd=2Eexe would reinterpret<br><br>wide_cmd_line(=
) only quoted arguments containing a space, so &amp; | &lt; &gt; ^ %<br>( )=
 and ! were passed unquoted=2E CreateProcess() runs =2Ebat and =2Ecmd files=
<br>through cmd=2Eexe, which parses the command line again, so a certificat=
e<br>subject passed to --tls-verify could start a second command (CERT/CC<b=
r>VU#123335)=2E<br><br>Quote on those characters too=2E Double quotes are a=
lready replaced with<br>&#39;_&#39;, so nothing else needs escaping=2E The =
delimiters , ; and =3D are left<br>out: cmd=2Eexe uses them to separate %1=
=2E=2E%9 but cannot run anything with<br>them, and quoting them would chang=
e what existing scripts receive=2E<br><br>GitHub: OpenVPN/openvpn-private-i=
ssues#159<br>Reported-By: Clouditera Security; Z=2Eai Security; NSFOCUS &lt=
;security@clouditera=2Ecom&gt;<br>CVE: 2026-84256<br>Change-Id: I68429deb39=
c0bae335d46a4170973a14c644ccf9<br>Signed-off-by: Lev Stipakov &lt;lev@openv=
pn=2Enet&gt;<br>---<br>M src/openvpn/win32=2Ec<br>1 file changed, 19 insert=
ions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/91/1891/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/win32=2Ec b/src/openvpn/win32=2Ec</span><br><span>index 44b010d=2E=
=2Ed527160 100644</span><br><span>--- a/src/openvpn/win32=2Ec</span><br><sp=
an>+++ b/src/openvpn/win32=2Ec</span><br><span>@@ -936,6 +936,22 @@</span><=
br><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* special to cmd=2Eexe, which CreateProc=
ess() uses to run =2Ebat/=2Ecmd (VU#123335) */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define CMD_QUOTE_TRIGGERS &quot; &amp;|&lt;&gt;=
^%()!&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+argv_element_needs_quotes(const cha=
r *str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    for (const char *c =3D str=
; *c !=3D &#39;\0&#39;; ++c)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (strchr(CMD_QUOTE_TRIGGERS, *c) !=3D NULL)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> st=
atic WCHAR *</span><br><span> wide_cmd_line(const struct argv *a, struct gc=
_arena *gc)</span><br><span> {</span><br><span>@@ -974,13 +990,13 @@</span>=
<br><span>         {</span><br><span>             buf_printf(&amp;buf, &quo=
t; &quot;);</span><br><span>         }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (string_class(work, CC_ANY, CC_SPACE))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (argv_element_nee=
ds_quotes(work))</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            buf_printf(&amp;buf, &quot;%s&quot;, work=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_p=
rintf(&amp;buf, &quot;\&quot;%s\&quot;&quot;, work);</span><br><span>      =
   }</span><br><span>         else</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;buf, &q=
uot;\&quot;%s\&quot;&quot;, work);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            buf_printf(&amp;buf, &quot;%s&quot;, work);</spa=
n><br><span>         }</span><br><span>     }</span><br><span> </span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1891?usp=3Demail">change 1891</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1891?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I68429deb39c0bae335d46a41709=
73a14c644ccf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 189=
1 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>

</body></html>
--GI3mRde1glQ=--


--===============6050129351785307586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6050129351785307586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6050129351785307586==--

