Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6DBC624D3
	for <openvpn-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vKvtOwqOSPRN3FB+KWeWSLVQbNJ1cbTmhofXyvC/JH4=; b=ejGJLnCHLwRkuf0v5sjDufemzD
	bhvNuVLyzURJdzkp7tT4ts2y1+OfMNa+uKZzGeRQCHKad7BOY7oeI9xL65txUNdDmWHe7He0YiVK3
	hDpQMFl25RFatdKl7JXBVPGHvuACnSOYJI7rCbpDwV0kSOpwiV/0IhA9XZoe0H9nup/k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1n0C-0005zl-Oy;
	Wed, 02 Sep 2026 15:35:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1n0B-0005zf-2N
 for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 15:35:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yfx8spIYGmlpV/6QwpKwxdbWSEsHDArMxfqrJ0oANkk=; b=LBEEJh559xPzlZGWNOcG9HvDwb
 Lz+b2JEAj3OI1Y3F9Gspa7HdvybAqrb4gyhLix3veTz0jroj6Zr8MRrB3uQg76q3jhLiEo80IWzZr
 vNtwS/BEaKnmsr/WuH1IstCTQV2gdaNox7vYq+mfIMnRgfkVCv7uuk+3cxfo/xFh6Lw8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yfx8spIYGmlpV/6QwpKwxdbWSEsHDArMxfqrJ0oANkk=; b=D
 xUSJ/UvUJjxQgZlTVy9D1cr9DmNahTRjTgTDEur9ElZfqNVoP6OhMF2S4DhVx9myrQpOdJzu68FB5
 oSOmBSQR1jXMtnTaTVIRsMfFLiAEmwTOpUiDS/fOucrxeyNVWqTEskqX5QUlcy3jDbtJ8RPkBjYZf
 RgX9psde6v5Ja08Q=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1n0A-0005VB-IZ for openvpn-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 15:35:51 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48431648f33so1743690f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 08:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788363344; x=1788968144; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yfx8spIYGmlpV/6QwpKwxdbWSEsHDArMxfqrJ0oANkk=;
 b=ES7qjL3cIVqkDlJfXJFfyxmX6uwVOguhoiV4JFE3rMJb240jmOakQJ6AX+y0FTutql
 oeAOmEmpR0okcvvSBNg7LdSh7HiYXNWyc7xjVZqkC/XxoII8iqNxTDVcedoMeqQDyn/j
 SteudRsH9aqY6p3k/R3FYLdUeR5fJGWIJPIOSLPQrWm0PJC71uT9ioEWCZBzzq/ZSrKe
 4s7C/60Gk2XuUWJbMlxTbJdXzJUdFHaUOuZrUKCg5szF9u7lg1w41owFdHQLdZPZqBBE
 vILE+vz0M7H6jOFEot7AVLBY1sRBnXRkYG9YzR048gvfTe50FC7fflpD0gt0EwVn8V0O
 iQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788363344; x=1788968144;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yfx8spIYGmlpV/6QwpKwxdbWSEsHDArMxfqrJ0oANkk=;
 b=ME/HzBQvzr2Lti80yIJoFETrQ1usChye5k0DtRlMeiY6CtroH/tpoBVqnIqeT0D92O
 GdiZdNnpR+So8JjG8l/bOJs61PCL+Gmuu4v40J9PO2d44kzqXUh/3Tlr69o2ea6zkGck
 sKf902+UTynFHPF7b1vhO1PmMIpyt3nTzXrqrUu6CaLrOZ04Kwj71K6PPNlxRa9I8RzL
 1s2vsti9JarijyaLKysdk+vW8cDwx8jpc9A9IeJt/+EDeXhAqMBavXrrn/Ny9JFEVU4Q
 iRTGpgR6Y3Pwm0ZV63uIImccn3jOHiH3XR78nBbx2nLmqc7AjLVaw/nZ2cg7/tQCsFgj
 b2ZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5a4yOgb7wSEEd5Y2N9Znou6kAJNgHutindT0VJGtZIBTXV3PraLmifrixGQfmqOCB+Fzty0Njcq84ErjH@lists.sourceforge.net
X-Gm-Message-State: AFuF++mRn6/ISBIPocPiP0kR2W7DfxeX7Utpafz0jlpRVfhX2LLrhKSK
 SXnEq9+Q1Jdlet3xFPoKtSdXcMuh8QO9kZGDiCh26Io6++VKACdZZ/7P4TDodGl70OcGjlpFxPG
 +TFeVGsoD6xdOyktodLtoKV3tv/L+W36H/BffhQKKp4lPreVJdVwhJveqMS4x6KI1TeA8
X-Gm-Gg: AR+sD135PPouyXREaVuwoSmAaAALQB/d/qUR9nPgdK1GyKYJcm6OVnT2Xt8mxydZGmW
 O9JRk44kOBNGYfhocGmuZyeZziO08lxxKiV397I1518xkBOpjhXq5oZS9sBJsWrCOQlJScDKzst
 CNuVXPitj956k7clZzzZMbZDKpwNnuyWfFUWDtkBUWWTFQEGMWBEWH97DANsytmRqSGp6OveYfN
 ot6CkalKoGoXiC3Kaq78P4H1bKhIKowAhZOADjLeaTWRznIA8wRvwA/Ihg/BU9colSGZaVbU2b3
 0xOfAiw62IxWSJVsguPMuB3kDro5VRDjZ2vQvDLE/YPYWL1xMAAtNFGYY42TCh0WBLx2I98/iHl
 loyMNj6RKjF/ScobK50IsfrDSRR4njE8qmyo/YzlPcmCGS++yBJ4lOHo3Vo3FwB0Z6Et2LfwU2c
 K2/5VxUuC0+RUNTtH9PRgzTpvpF8bDi0++P9jXPhCED06JoKrSn+ulVeV1u5D6ZMnygtoVREvKj
 ARqb58dp59QKcf0CnCYP2LqqGD0Y5uwbEvdI+yqyL8D0juqnu+ZGTyyCcemXn01lABm5uALeIQx
 uWCY9eFAyOSWz/WaDswCSfcwvUcFboOKuiY62umluWSI7RP/unE=
X-Received: by 2002:a05:600c:4ecc:b0:49c:e37e:4389 with SMTP id
 5b1f17b1804b1-49cee5e2370mr148645e9.4.1788363343589; 
 Wed, 02 Sep 2026 08:35:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce47b9817sm57709975e9.1.2026.09.02.08.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 08:35:43 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 2 Sep 2026 15:35:42 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I68429deb39c0bae335d46a4170973a14c644ccf9
X-Gerrit-Change-Number: 1891
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1891?usp=email>
X-Gerrit-Commit: cf08504bbbacdb0c3d94c7a0358a6ec06c553cdd
In-Reply-To: <gerrit.1788295708000.I68429deb39c0bae335d46a4170973a14c644ccf9@gerrit.openvpn.net>
References: <gerrit.1788295708000.I68429deb39c0bae335d46a4170973a14c644ccf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4Mjk1NzA4MDAwLkk2ODQyOWRlYjM5YzBiYWUzMzVkNDZhNDE3MDk3M2ExNGM2NDRjY2Y5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <305c7bcf29fba3c5bcb25f525ddfe9f3c3af9c03-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1n0A-0005VB-IZ
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>, d12fk <heiko@openvpn.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9172494134229644535=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9172494134229644535==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JwcHfm6pyyw="; charset=UTF-8

--JwcHfm6pyyw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1891?usp=3Demail )

Change subject: win32: quote arguments that cmd=2Ee=
xe would reinterpret
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

win32: quote arguments that cmd=2Eexe would reinterpret

wide_cmd_l=
ine() only quoted arguments containing a space, so & | < > ^ %
( ) and ! we=
re passed unquoted=2E CreateProcess() runs =2Ebat and =2Ecmd files
through =
cmd=2Eexe, which parses the command line again, so a certificate
subject pa=
ssed to --tls-verify could start a second command (CERT/CC
VU#123335)=2E

Q=
uote on those characters too=2E Double quotes are already replaced with
'_'=
, so nothing else needs escaping=2E The delimiters , ; and =3D are left
out=
: cmd=2Eexe uses them to separate %1=2E=2E%9 but cannot run anything with
t=
hem, and quoting them would change what existing scripts receive=2E

GitHub=
: OpenVPN/openvpn-private-issues#159
Reported-By: Clouditera Security; Z=2E=
ai Security; NSFOCUS <security@clouditera=2Ecom>
CVE: 2026-84256
Change-Id:=
 I68429deb39c0bae335d46a4170973a14c644ccf9
Signed-off-by: Lev Stipakov <lev=
@openvpn=2Enet>
Acked-by: Heiko Hund <heiko@openvpn=2Enet>
Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1891
Message-Id: <20260902121416=2E7=
047-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvp=
n-devel@lists=2Esourceforge=2Enet/msg38897=2Ehtml
Signed-off-by: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/win32=2Ec
1 file changed, 19=
 insertions(+), 3 deletions(-)




diff --git a/src/openvpn/win32=2Ec b/src=
/openvpn/win32=2Ec
index dd88a22=2E=2Ea9990b5 100644
--- a/src/openvpn/win3=
2=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -1034,6 +1034,22 @@
     }
 }
 
+/* sp=
ecial to cmd=2Eexe, which CreateProcess() uses to run =2Ebat/=2Ecmd (VU#123=
335) */
+#define CMD_QUOTE_TRIGGERS " &|<>^%()!"
+
+static bool
+argv_eleme=
nt_needs_quotes(const char *str)
+{
+    for (const char *c =3D str; *c !=
=3D '\0'; ++c)
+    {
+        if (strchr(CMD_QUOTE_TRIGGERS, *c) !=3D NULL=
)
+        {
+            return true;
+        }
+    }
+    return false;=

+}
+
 static WCHAR *
 wide_cmd_line(const struct argv *a, struct gc_arena =
*gc)
 {
@@ -1072,13 +1088,13 @@
         {
             buf_printf(&buf, " =
");
         }
-        if (string_class(work, CC_ANY, CC_SPACE))
+        =
if (argv_element_needs_quotes(work))
         {
-            buf_printf(&bu=
f, "%s", work);
+            buf_printf(&buf, "\"%s\"", work);
         }
 =
        else
         {
-            buf_printf(&buf, "\"%s\"", work);
+   =
         buf_printf(&buf, "%s", work);
         }
     }
 

-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1891?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I68429deb39c0bae335d46a4170973a14c644c=
cf9
Gerrit-Change-Number: 1891
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert=
@greenie=2Emuc=2Ede>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>

--JwcHfm6pyyw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1891?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">win32: quote arguments that cmd=2Eexe woul=
d reinterpret<br><br>wide_cmd_line() only quoted arguments containing a spa=
ce, so &amp; | &lt; &gt; ^ %<br>( ) and ! were passed unquoted=2E CreatePro=
cess() runs =2Ebat and =2Ecmd files<br>through cmd=2Eexe, which parses the =
command line again, so a certificate<br>subject passed to --tls-verify coul=
d start a second command (CERT/CC<br>VU#123335)=2E<br><br>Quote on those ch=
aracters too=2E Double quotes are already replaced with<br>&#39;_&#39;, so =
nothing else needs escaping=2E The delimiters , ; and =3D are left<br>out: =
cmd=2Eexe uses them to separate %1=2E=2E%9 but cannot run anything with<br>=
them, and quoting them would change what existing scripts receive=2E<br><br=
>GitHub: OpenVPN/openvpn-private-issues#159<br>Reported-By: Clouditera Secu=
rity; Z=2Eai Security; NSFOCUS &lt;security@clouditera=2Ecom&gt;<br>CVE: 20=
26-84256<br>Change-Id: I68429deb39c0bae335d46a4170973a14c644ccf9<br>Signed-=
off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Heiko Hund &lt;=
heiko@openvpn=2Enet&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1891<br>Message-Id: &lt;20260902121416=2E7047-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg38897=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/win32=2Ec<br>1 file changed, 19=
 insertions(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/wi=
n32=2Ec b/src/openvpn/win32=2Ec</span><br><span>index dd88a22=2E=2Ea9990b5 =
100644</span><br><span>--- a/src/openvpn/win32=2Ec</span><br><span>+++ b/sr=
c/openvpn/win32=2Ec</span><br><span>@@ -1034,6 +1034,22 @@</span><br><span>=
     }</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* special to cmd=2Eexe, which CreateProcess() uses=
 to run =2Ebat/=2Ecmd (VU#123335) */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define CMD_QUOTE_TRIGGERS &quot; &amp;|&lt;&gt;^%()!&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+argv_element_needs_quotes(const char *str)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    for (const char *c =3D str; *c !=3D =
&#39;\0&#39;; ++c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (str=
chr(CMD_QUOTE_TRIGGERS, *c) !=3D NULL)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static WCHAR=
 *</span><br><span> wide_cmd_line(const struct argv *a, struct gc_arena *gc=
)</span><br><span> {</span><br><span>@@ -1072,13 +1088,13 @@</span><br><spa=
n>         {</span><br><span>             buf_printf(&amp;buf, &quot; &quot=
;);</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (string_class(work, CC_ANY, CC_SPACE))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (argv_element_needs_quote=
s(work))</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            buf_printf(&amp;buf, &quot;%s&quot;, work);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&a=
mp;buf, &quot;\&quot;%s\&quot;&quot;, work);</span><br><span>         }</sp=
an><br><span>         else</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;buf, &quot;\&qu=
ot;%s\&quot;&quot;, work);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            buf_printf(&amp;buf, &quot;%s&quot;, work);</span><br><s=
pan>         }</span><br><span>     }</span><br><span> </span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1891?usp=3Demail">change 1891</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1891?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I68429deb39c0bae335d46a4170973a14c644c=
cf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1891 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html=
>
--JwcHfm6pyyw=--


--===============9172494134229644535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9172494134229644535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9172494134229644535==--

