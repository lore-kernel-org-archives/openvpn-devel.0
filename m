Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB1ECD98D9
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0azb7BlW1Xc6Fw2OJUgNalRfnK38B1VeUHvUu2TQweg=; b=lpN3o2D7zdawA2UvsWV0tuFco3
	qtCoh+gY5MZ859plKU9b03A3OGlEO60YxuKZXlISr2C9sQdR34labPZNOGvvgbnJ4SlhJ10GPKG5w
	Jpfwg5eZrwWJ18XxehT7adPdp7Ns/mrDmS26DhYifhPCCYRONo0hfah73eQtqv8fajDA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wY2cE-0007v7-FV;
	Fri, 12 Jun 2026 14:12:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wY2cC-0007uz-D3
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 14:12:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=m42hDWXOzXxLy9i5DOE3X63/LLIft8DHHemwCmDEkcE=; b=OJSqAo0q6kb0yyeOFoo3Lg/qWG
 bPs3cdzlQeXqgpozrdROVZRflzqDBGsGTJPHRnIPhnmCtUMrK1KEFhpOnK61tVMieZ90/44HuW5EN
 1hlnt6CP9lVlEaMzzX84JpUOFJGRgik+/feMrlvXNhR+KnrqGNfcHRl7WJG1pNExMhQw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=m42hDWXOzXxLy9i5DOE3X63/LLIft8DHHemwCmDEkcE=; b=e
 VbZjqkBTjT2shIJ7vcf4WHg9jZ60Yf9G/622q7BXlE+1Ar96N77tlHvSeTgtWCewr2QhjxOaEXFag
 nvjAPD8hrjPVQaHievfOH26M6hqJd2Fj303Q+14jh2cFHHDEbQJEm3goo3i1s+d/X+PdQMReGokLh
 iA+HzwsgdIYbroD4=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wY2cA-0001kg-Jj for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 14:12:09 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-45fd45e596cso585264f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 12 Jun 2026 07:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781273515; x=1781878315; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m42hDWXOzXxLy9i5DOE3X63/LLIft8DHHemwCmDEkcE=;
 b=aRLmR1iamfYmvZT/euQIFRIHoPxl1+b4mUkVGLPAsf1G9ZOIPC8g8nEVvPlXDumx0H
 g6koMMzoyIZTOglk3rYyuA7oMNbRHGsLHkHAdpZGm1TFIpBilZm7H4yIDwIiMoV93Lb/
 bQBHOJN9r2Ac3IbV0VaYzvV++omMA2TxuRc1CbGIGVE+/WMnj1KJmjUrPTWGvcHcnEEa
 +ywQkCV0gbNuTh/AgGC5PhMThkTRUbbdZoNe5fTc+6NBFdW7lSBHnb2feEQFZW0GSDx9
 c4x7/EF22TdzrMDZxiy7GfYVPTTsMynxOe7XtHYxi8hyweeLCqZ5EOsrqA0XI/1qYRFL
 0Oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781273515; x=1781878315;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m42hDWXOzXxLy9i5DOE3X63/LLIft8DHHemwCmDEkcE=;
 b=CzmZ4vvYgyhMtDhw8VBI1kv7obRq8YfhSo0OVLp9r46mxHkREOjRh8F0L2ozW7emB4
 CHPw6m15Hab0GUHVjged3b/UCs5/x5JYGEY7j+irR+HULIx0bNbRLnssJv4AOqVLVBQZ
 Cls7lUGPhPmvZinUEo6rXezt9dHESNw8VQ9Ef7dDO/r0haGxcppLVC8WWn2u9AI4DHwA
 0oPpUfuS6RHrYX+gOucu/eELxunUwBcBTgpaNg5XHNSyuI/5oUsZauM0MHJdsa1IFB9a
 RHp9vhhkYITTnbGoAUwhaFCzfqTiPKoNbEVKYtzsO1mo6svrLcjCQRIK/08DXDwgaTGL
 R9rw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/137PbN7wjpZ5k91IpSJQ/BkoDnMnxwOGpMxzotbYT6Hmrhy6trYN7LszEkQjfAULOgIfcGMfislGhEquV@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyaxST2cVskwmNrD17Zbmk0lPaWNNnNbX/W0m448kdIaet+i4Yo
 DsPjRUx1+lsFIEAJjh4kobVO7Tsq/2ZDFkigapk686gcSmXLI+GFrn8vNXshkq9+9ijkaab/5dz
 /LO1/zLUGRvWdwalMZCFIo3LhWogyhkW8tv6x4TGEsmgdZFfQwFvgEsmgb3mwXGiniWs6/S7+6K
 kfpxdTwg==
X-Gm-Gg: Acq92OEKfYFpfNcMfA43eL/U2DpG9NCmA8PYX7rMjoNFLY0TI3q8xZna/cgBMFGV+UJ
 /YytkMiyDeTNHud60mJYZ2A1ad+hOLB4+CTSgmjGovX4NEG6aSb1AMa5KVmD63oehwRCLBVsyiW
 MwKyQiCTod7pPQFgG8TWiXOEz81XAAwIa2OMCp3BqPisssNMbANM/z4cxsbx3jok9m2Ls6UQ2J4
 cP2yMp/btSQKAxuba3B1hSKmwwm8L7Jad7TiYW6+VBRsH331PWphqtyfSI2OpiaSR6G/i1PZ/jv
 YKY1uEJb6ULCpoVQFuGW2dRkn3v0+ObhHH/DFaGIo/hfDDGVoT1gMJzbfySFPXGg9cuee/hJbPQ
 5dziH26XjnuYo+vIhK+y6PH6xG4Q/2ZwI9sMdm9ViqdrNvnmvIUI5kC0YuoEMyg2IPoIA8nv5Nm
 Yxwpb6jVXOU2T0yWTpkFTdOk7JmjOvKc+dwWdOgHrMvYvC9fkGddjxZXX8bshnEaU/4f9uoqb9g
 howPCe20BaUzWmEWXhMUU3EZmO9SPc/VNE6a1+Lbtd6UIAa/YXz1Zx/2je3q8KB/WceDjKQGBFm
 sfr30lZzKNf4iA==
X-Received: by 2002:a05:6000:2984:20b0:44f:9b70:2996 with SMTP id
 ffacd0b85a97d-4606db97422mr3565738f8f.21.1781273515334; 
 Fri, 12 Jun 2026 07:11:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c5266sm6467435f8f.29.2026.06.12.07.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 07:11:54 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 12 Jun 2026 14:11:54 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: Icc31b7fa0da86220df45552aecc15dc6c769cd54
X-Gerrit-Change-Number: 1293
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1293?usp=email>
X-Gerrit-Commit: 8d23076babece34581ae9396b6280eb34c86c422
In-Reply-To: <gerrit.1761063820000.Icc31b7fa0da86220df45552aecc15dc6c769cd54@gerrit.openvpn.net>
References: <gerrit.1761063820000.Icc31b7fa0da86220df45552aecc15dc6c769cd54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzYxMDYzODIwMDAwLkljYzMxYjdmYTBkYTg2MjIwZGY0NTU1MmFlY2MxNWRjNmM3NjljZDU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a07182af7d038af54017aaf859b34404c6cafbff-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wY2cA-0001kg-Jj
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: Fix conversion
 issues related to timeout in send_auth_pending_m...
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0531117822070385979=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0531117822070385979==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZVhy5i5TMUc="; charset=UTF-8

--ZVhy5i5TMUc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1293?usp=3Demail )

Change subject: push: Fix conversion issues related=
 to timeout in send_auth_pending_messages
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

push: Fix conversion issues related to timeout=
 in send_auth_pending_messages

Add additional checking to make sure that t=
he required
casts are safe=2E

Change-Id: Icc31b7fa0da86220df45552aecc15dc6=
c769cd54
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-b=
y: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1293
Message-Id: <20260612113309=2E29903-1-gert@gr=
eenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg37184=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/push=2Ec
M src/openvpn/ssl_verify=2Ec
2 f=
iles changed, 13 insertions(+), 7 deletions(-)




diff --git a/src/openvpn=
/push=2Ec b/src/openvpn/push=2Ec
index 564ce86=2E=2Ee391147 100644
--- a/sr=
c/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -429,11 +429,6 @@
     gc_=
free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC d=
iagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bo=
ol
 send_auth_pending_messages(struct tls_multi *tls_multi, struct tls_sess=
ion *session,
                            const char *extra, unsigned int t=
imeout)
@@ -449,7 +444,12 @@
     /* Calculate the maximum timeout and subt=
ract the time we already waited */
     unsigned int max_timeout =3D
      =
   max_uint(tls_multi->opt=2Erenegotiate_seconds / 2, tls_multi->opt=2Ehand=
shake_window);
-    max_timeout =3D max_timeout - (now - ks->initial);
+   =
 time_t time_elapsed =3D now - ks->initial;
+    if (time_elapsed < 0 || ti=
me_elapsed >=3D (time_t)max_timeout)
+    {
+        return false;
+    }
+=
    max_timeout -=3D (unsigned int)time_elapsed;
     timeout =3D min_uint(=
max_timeout, timeout);
 
     struct gc_arena gc =3D gc_new();
@@ -734,6 +7=
34,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma =
GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
=
+
 static bool
 send_push_options(struct context *c, struct buffer *buf, st=
ruct push_list *push_list, int safe_cap,
                   bool *push_sent=
, bool *multi_push)
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/s=
sl_verify=2Ec
index 0804d2d=2E=2E31ecf13 100644
--- a/src/openvpn/ssl_verif=
y=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -922,8 +922,9 @@
             buf=
_chomp(iv_buf);
             buf_chomp(extra_buf);
 
+            errno =3D=
 0;
             long timeout =3D strtol(BSTR(timeout_buf), NULL, 10);
-   =
         if (timeout <=3D 0)
+            if (timeout <=3D 0 || (unsigned l=
ong)timeout > UINT_MAX || errno)
             {
                 msg(M_WARN=
, "could not parse auth pending file timeout");
                 buffer_lis=
t_free(lines);

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1293?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: mer=
ged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icc31b7=
fa0da86220df45552aecc15dc6c769cd54
Gerrit-Change-Number: 1293
Gerrit-PatchS=
et: 13
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer=
: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--ZVhy5i5TMUc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1293?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">push: Fix conversion issues related to tim=
eout in send_auth_pending_messages<br><br>Add additional checking to make s=
ure that the required<br>casts are safe=2E<br><br>Change-Id: Icc31b7fa0da86=
220df45552aecc15dc6c769cd54<br>Signed-off-by: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1293<br>Me=
ssage-Id: &lt;20260612113309=2E29903-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g37184=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
;<br>---<br>M src/openvpn/push=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>2 fil=
es changed, 13 insertions(+), 7 deletions(-)<br><br></pre>
<pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 564ce86=
=2E=2Ee391147 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><=
span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -429,11 +429,6 @@</span>=
<br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> send_auth_pendi=
ng_messages(struct tls_multi *tls_multi, struct tls_session *session,</span=
><br><span>                            const char *extra, unsigned int time=
out)</span><br><span>@@ -449,7 +444,12 @@</span><br><span>     /* Calculate=
 the maximum timeout and subtract the time we already waited */</span><br><=
span>     unsigned int max_timeout =3D</span><br><span>         max_uint(tl=
s_multi-&gt;opt=2Erenegotiate_seconds / 2, tls_multi-&gt;opt=2Ehandshake_wi=
ndow);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    max_timeout=
 =3D max_timeout - (now - ks-&gt;initial);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    time_t time_elapsed =3D now - ks-&gt;initial;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (time_elapsed &=
lt; 0 || time_elapsed &gt;=3D (time_t)max_timeout)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    max_timeout -=3D (unsigned int)time_elapsed;</span><br><span>     =
timeout =3D min_uint(max_timeout, timeout);</span><br><span> </span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span>@@ -734,6 +734,11 =
@@</span><br><span>     }</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined=
(__clang__)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma =
GCC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><span> send_=
push_options(struct context *c, struct buffer *buf, struct push_list *push_=
list, int safe_cap,</span><br><span>                   bool *push_sent, boo=
l *multi_push)</span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/sr=
c/openvpn/ssl_verify=2Ec</span><br><span>index 0804d2d=2E=2E31ecf13 100644<=
/span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/=
openvpn/ssl_verify=2Ec</span><br><span>@@ -922,8 +922,9 @@</span><br><span>=
             buf_chomp(iv_buf);</span><br><span>             buf_chomp(extr=
a_buf);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            errno =3D 0;</span><br><span>             long timeout =
=3D strtol(BSTR(timeout_buf), NULL, 10);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            if (timeout &lt;=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (timeout &lt;=3D 0 || (uns=
igned long)timeout &gt; UINT_MAX || errno)</span><br><span>             {</=
span><br><span>                 msg(M_WARN, &quot;could not parse auth pend=
ing file timeout&quot;);</span><br><span>                 buffer_list_free(=
lines);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1293?usp=3Demail">change 1293</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1293?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icc31b7fa0da862=
20df45552aecc15dc6c769cd54 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1293 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 =
&lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>

</body></html>
--ZVhy5i5TMUc=--


--===============0531117822070385979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0531117822070385979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0531117822070385979==--

