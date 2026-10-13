Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D9CCC6B08
	for <openvpn-devel@archiver.kernel.org>; Tue, 13 Oct 2026 14:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=cEl4dFpwCQ0RRpSX2XBCzVxnRVcxvm4xQ/nwwQZ7dX0=; b=cEyq24wxHq5VPI
	dEQEQwYj9/VOQ82FNMI6dUeV5kypYeHXlhcbSQ5Cyr2OsO64sqJExNTNfacWHMTTnaUAday5gCF5y
	ZONMoRNx/GE7du1XhnIv7OQZ54tcNFERjx9SVkx1mBK36w3IgXoE8EtERMbSe2cYi/p69U63ZFhWD
	j0c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGdPm-0000Fz-Mc;
	Tue, 13 Oct 2026 14:23:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGdPl-0000Fj-H0
 for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 14:23:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZE/4ocmT8SnGrxU3644zB1ppidcI+q6jFTtn7o9peSc=; b=CEzMKEn/Ap96vS/nDkDp8Y4WFf
 2RhX7hMiYADuKnqEVRjbLV9q7AMBl/dkzebfqbD4uF19V7fGot3UO4NuRv9rAapZLw/SkOweXdWrp
 CxL0+qHNx8XueYgKOhbiuMZKS4Y6UOfPlq+HcwdyFTqQFKdKqH+4ugxtxoUc0Cpi4KHo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZE/4ocmT8SnGrxU3644zB1ppidcI+q6jFTtn7o9peSc=; b=B
 C+J50uCwA2MUjtAYpW6RBLiqkv+X//+BYNPa33Vogx7P13fY5EEHUmLVs2WKNE/xV4rK0HtxVHzXp
 gpdcmsd0l37WmfLaS00KqGMIq15UxMPCSIZ8iBWA2IqqHBqX/5hQXB27RXfKla1xfIA+Cu5A9Dkai
 OLQ1gPgOyrYLAxLY=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGdPk-0001Tv-In for openvpn-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 14:23:38 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so24269535e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791901410; x=1792506210; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZE/4ocmT8SnGrxU3644zB1ppidcI+q6jFTtn7o9peSc=;
 b=VbPIVxzDxlj/AEcRcgjwSgA7fIFFUCb+vmXk391wnRc5F8ykXaAoCKAzvphkEVZJ2W
 71NjyA0aSek/FGPYKHDaUg9OsnHSyoR/Gc4TKm4hFsBpp2TC/ZPZdFARyaIc2Yq5FLZr
 2lebQY6mbr56tlKB6tlLvzMDHHQpkIe9tvSPm4bP9F+dTfJymVoIhIiv5ovFZ7XmfoD2
 LCcd2jSQmYhx3iYQSH5seO1wvfO3EcZtIV0psP7KTn6Ow/QeYAKd05D9FKsz/vCst3UC
 9j8Pg22Xo2Jhh+Jc1T/9V6kIER8FRfcsgWO6Y4dmeDE4BrwmEHu6rlhTRMXN3+2mV9Ky
 5qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791901410; x=1792506210;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZE/4ocmT8SnGrxU3644zB1ppidcI+q6jFTtn7o9peSc=;
 b=S84GM5V7Qo2s39GcsIElonMfBQivas6q8fMB68L3lGtMadyiO5f2LOBpwRN8wr2ZG8
 jk19IAKHZ6U1yE4DNAzzaoScM0nJYHYm8HgWYYM/1VXltKH3uXu9qXodEzB9HPgPBgFj
 53HX+/PsHGho+ngY0BtuenO351O1djveIR+46vZF4P1hxoSjG26AvARr3EQYdH/jpvE0
 6ddf6tvAyahi5IgfvPeo67PIPhA0JNW7f+OVsAAjJf9xOvYibDj6KngDtZUaIJm0egCl
 Vge7ig0LOsl89K+ssara42Rivs3CIa5m6jgZ9ViiBgcNJWZQMBoX5gq6r/FmkdePIsJ0
 xzjg==
X-Gm-Message-State: AFq9FYK7jRg3D85gVF+Wg8ky+4HrKZ3JBJANcs1Uto3mRsBAWZU0RPhk
 009V6uUlFEwq4Pv3pUYz48mhHYoHXXiD4nrSjq2qvMGsGTySUyhnu9NKHXifDNRbnriGdAsR9K0
 3s3pwv7HoD8mVhCyq+VsKDFn/h+bYO7eXF3mP1yvpBqEiKMiKuRK2efD1/IOTWtCprCd55kaw18
 Q5KN936g==
X-Gm-Gg: AYBFou3Ii8nrp2QdB3U01wH0CIKnO9v+VCJZVErwII85aFQVzG9YDrTCYfENQ1pxLEb
 JNHEHOU92yOMndr9LnUHF1IvGmAmtGUfsZ2EefpVrLq8zuDd+z9AbEhJ9MDGtNqV+XzsvSQ3r2i
 VMA7tW4vBcxzMq5vCFi2w951dLyQTTbksjQk2u3ZqxAedzh+FqT+f4JA2JrVpQUE7TxTSLZNcsu
 ftro0Nb6sFII/pLQtbwiwB1pXuc3oQ2BZVqFrOzHzGyZPeY6uAaYQ2U1RfZZrBvMDaDeoI5zDY4
 ye9qsiz9UcDYEKjsOMY3Q9mtOia821Qpz3eb0pnOX4DHobjrSaLkcAT+7eSvIOz+M258vihnuvx
 /2jngIQ/g/bB1LX0m7bWWxuFK0lqcu5nsaciBTilavlQUV91+cObpj4AkA3L8LLY9jFQsZ000ms
 amhZWUyJdKKRiybpPMvAjPK3yMRnA8tHV0EmvPmemfezmPA0bVFs4QGqfVcAqRMAv28EqIoJRwO
 lZirp3IX1E7tPwTB53thPJ33U42PApndTaCUK4ZWkxZEnN065PmdC+w3DwDGzKivdvMwCp1dZzf
 SbUmkpKs0xVFSSYxdQvrBnSWDTxy94gcJdDE2qPLzrAwOwJgdS+KOKUxMBn9
X-Received: by 2002:a05:600c:46cf:b0:4a1:7e1f:21bc with SMTP id
 5b1f17b1804b1-4a18e4d6636mr259706215e9.29.1791901409455; 
 Tue, 13 Oct 2026 07:23:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bead84esm365506625e9.13.2026.10.13.07.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 07:23:29 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 13 Oct 2026 14:23:28 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I61e29dd2af9302b240c93735179d43c72e37b335
X-Gerrit-Change-Number: 1996
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1996?usp=email>
X-Gerrit-Commit: 041a72adf5fb8166d03d3dc9ef543207bfc6ccec
References: <gerrit.1791901394000.I61e29dd2af9302b240c93735179d43c72e37b335@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk2MWUyOWRkMmFmOTMwMmIyNDBjOTM3MzUxNzlkNDNjNzJlMzdiMzM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e5f855ba16a6eae76599677897687d4d444b64f9-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGdPk-0001Tv-In
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Replace strncat with
 strlcat
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
Content-Type: multipart/mixed; boundary="===============3720923198434936354=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3720923198434936354==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A1VCDsrTjRQ="; charset=UTF-8

--A1VCDsrTjRQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1996?usp=3Demail

to review the following change=2E
=


Change subject: Replace strncat with strlcat
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace strncat with strlcat

Generally =
much better API=2E Not a straight-forward
replacement in many cases, trying=
 to improve the
code generally=2E

Change-Id: I61e29dd2af9302b240c93735179d=
43c72e37b335
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---=

M src/openvpn/misc=2Ec
M src/openvpn/options_parse=2Ec
M src/openvpn/statu=
s=2Ec
M src/openvpn/xkey_helper=2Ec
M src/plugins/auth-pam/utils=2Ec
5 file=
s changed, 20 insertions(+), 23 deletions(-)



  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/96/1996/1

diff --git a/src/openvpn=
/misc=2Ec b/src/openvpn/misc=2Ec
index a75bd8f=2E=2Eb9cc6a2 100644
--- a/sr=
c/openvpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -437,12 +437,11 @@
       =
              }
                     else
                     {
-         =
               if (strlen(up->password) + strlen(response) >=3D USER_PASS_L=
EN)
+                        if (strlcat(up->password, response, USER_PASS_=
LEN) >=3D USER_PASS_LEN)
                         {
                       =
      msg(M_FATAL,
                                 "ERROR: could not conca=
tenate password/static_response: string too long");
                       =
  }
-                        strncat(up->password, response, USER_PASS_LEN =
- strlen(up->password) - 1);
                     }
                 }
 #en=
dif /* ifdef ENABLE_MANAGEMENT */
diff --git a/src/openvpn/options_parse=2E=
c b/src/openvpn/options_parse=2Ec
index 12934ab=2E=2E3d893d4 100644
--- a/s=
rc/openvpn/options_parse=2Ec
+++ b/src/openvpn/options_parse=2Ec
@@ -244,10=
 +244,7 @@
     else if (is->type =3D=3D IS_TYPE_BUF)
     {
         bool =
status =3D buf_parse(is->u=2Emultiline, '\n', line, size);
-        if ((in=
t)strlen(line) + 1 < size)
-        {
-            strcat(line, "\n");
-   =
     }
+        strlcat(line, "\n", size);
         return status;
     }
 =
    else
diff --git a/src/openvpn/status=2Ec b/src/openvpn/status=2Ec
index=
 c7d375b=2E=2E981bb23 100644
--- a/src/openvpn/status=2Ec
+++ b/src/openvpn=
/status=2Ec
@@ -234,14 +234,11 @@
 
         if (so->fd >=3D 0 && !so->erro=
rs)
         {
-            strcat(buf, "\n");
-            ssize_t len =3D=
 strlen(buf);
-            if (len > 0)
+            size_t len =3D strlcat=
(buf, "\n", sizeof(buf));
+            ASSERT(len < sizeof(buf));
+        =
    if (write(so->fd, buf, (unsigned int)len) !=3D (ssize_t)len)
          =
   {
-                if (write(so->fd, buf, (unsigned int)len) !=3D len)
-=
                {
-                    so->errors =3D true;
-              =
  }
+                so->errors =3D true;
             }
         }
 
diff =
--git a/src/openvpn/xkey_helper=2Ec b/src/openvpn/xkey_helper=2Ec
index 114=
9c7b=2E=2Ec945d18 100644
--- a/src/openvpn/xkey_helper=2Ec
+++ b/src/openvp=
n/xkey_helper=2Ec
@@ -247,7 +247,10 @@
 
     if (is_message)
     {
-     =
   strncat(alg_str, ",data=3Dmessage", sizeof(alg_str) - strlen(alg_str) - =
1);
+        if (strlcat(alg_str, ",data=3Dmessage", sizeof(alg_str)) >=3D =
sizeof(alg_str))
+        {
+            return -1;
+        }
     }
 
   =
  dmsg(D_LOW, "xkey management_sign: requesting sig with algorithm <%s>", a=
lg_str);
diff --git a/src/plugins/auth-pam/utils=2Ec b/src/plugins/auth-pam=
/utils=2Ec
index a4d2d0b=2E=2Eb6b9424 100644
--- a/src/plugins/auth-pam/uti=
ls=2Ec
+++ b/src/plugins/auth-pam/utils=2Ec
@@ -65,23 +65,24 @@
 
     /* s=
tate: all parameters are valid */
 
-    const char *searching =3D tosearch=
;
-
-    char temp[templen + 1];
-    temp[0] =3D 0;
-
-    const char *scr=
atch =3D strstr(searching, searchfor);
+    const char *scratch =3D strstr(=
tosearch, searchfor);
     if (!scratch)
     {
         return strdup(tose=
arch);
     }
 
+    const char *searching =3D tosearch;
+    char temp[tem=
plen + 1] =3D { 0 };
+    char *target =3D temp;
+
     while (scratch)
   =
  {
-        strncat(temp, searching, (size_t)(scratch - searching));
-    =
    strcat(temp, replacewith);
+        size_t skipped =3D (size_t)(scratch=
 - searching);
+        memcpy(target, searching, skipped);
+        target=
 +=3D skipped;
+        memcpy(target, replacewith, replacewithlen);
 
-   =
     searching =3D scratch + strlen(searchfor);
+        searching =3D scra=
tch + tosearchlen;
         scratch =3D strstr(searching, searchfor);
     =
}
     return strdup(temp);

-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1996?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I61e29dd2af9302b240c93735179d43c72e37b335
Gerrit-Change-Number: =
1996
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--A1VCDsrTjRQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">Replace strncat with strlcat<br><br>Generally much better =
API=2E Not a straight-forward<br>replacement in many cases, trying to impro=
ve the<br>code generally=2E<br><br>Change-Id: I61e29dd2af9302b240c93735179d=
43c72e37b335<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Eco=
m&gt;<br>---<br>M src/openvpn/misc=2Ec<br>M src/openvpn/options_parse=2Ec<b=
r>M src/openvpn/status=2Ec<br>M src/openvpn/xkey_helper=2Ec<br>M src/plugin=
s/auth-pam/utils=2Ec<br>5 files changed, 20 insertions(+), 23 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/96/1996/1</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/misc=2Ec b/src/=
openvpn/misc=2Ec</span><br><span>index a75bd8f=2E=2Eb9cc6a2 100644</span><b=
r><span>--- a/src/openvpn/misc=2Ec</span><br><span>+++ b/src/openvpn/misc=
=2Ec</span><br><span>@@ -437,12 +437,11 @@</span><br><span>                =
     }</span><br><span>                     else</span><br><span>          =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
               if (strlen(up-&gt;password) + strlen(response) &gt;=3D USER_=
PASS_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              if (strlcat(up-&gt;password, response, USER_PASS_LEN) &gt;=3D=
 USER_PASS_LEN)</span><br><span>                         {</span><br><span>=
                             msg(M_FATAL,</span><br><span>                 =
                &quot;ERROR: could not concatenate password/static_response=
: string too long&quot;);</span><br><span>                         }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        strn=
cat(up-&gt;password, response, USER_PASS_LEN - strlen(up-&gt;password) - 1)=
;</span><br><span>                     }</span><br><span>                 }=
</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span>diff=
 --git a/src/openvpn/options_parse=2Ec b/src/openvpn/options_parse=2Ec</spa=
n><br><span>index 12934ab=2E=2E3d893d4 100644</span><br><span>--- a/src/ope=
nvpn/options_parse=2Ec</span><br><span>+++ b/src/openvpn/options_parse=2Ec<=
/span><br><span>@@ -244,10 +244,7 @@</span><br><span>     else if (is-&gt;t=
ype =3D=3D IS_TYPE_BUF)</span><br><span>     {</span><br><span>         boo=
l status =3D buf_parse(is-&gt;u=2Emultiline, &#39;\n&#39;, line, size);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((int)strlen(l=
ine) + 1 &lt; size)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            st=
rcat(line, &quot;\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    strlcat(line, &quot;\n&quot;, size);</span><br><span>         return st=
atus;</span><br><span>     }</span><br><span>     else</span><br><span>diff=
 --git a/src/openvpn/status=2Ec b/src/openvpn/status=2Ec</span><br><span>in=
dex c7d375b=2E=2E981bb23 100644</span><br><span>--- a/src/openvpn/status=2E=
c</span><br><span>+++ b/src/openvpn/status=2Ec</span><br><span>@@ -234,14 +=
234,11 @@</span><br><span> </span><br><span>         if (so-&gt;fd &gt;=3D =
0 &amp;&amp; !so-&gt;errors)</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            strcat(buf, &quot;\n&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ssize_t le=
n =3D strlen(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         if (len &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            size_t len =3D strlcat(buf, &quot;\n&quot;, sizeof(buf));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(l=
en &lt; sizeof(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (write(so-&gt;fd, buf, (unsigned int)len) !=3D (ssize_t)le=
n)</span><br><span>             {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                if (write(so-&gt;fd, buf, (unsigned int)len) !=
=3D len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   so-&gt;errors =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                so-&gt;errors =3D true;</span><br><span>             }</=
span><br><span>         }</span><br><span> </span><br><span>diff --git a/sr=
c/openvpn/xkey_helper=2Ec b/src/openvpn/xkey_helper=2Ec</span><br><span>ind=
ex 1149c7b=2E=2Ec945d18 100644</span><br><span>--- a/src/openvpn/xkey_helpe=
r=2Ec</span><br><span>+++ b/src/openvpn/xkey_helper=2Ec</span><br><span>@@ =
-247,7 +247,10 @@</span><br><span> </span><br><span>     if (is_message)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       strncat(alg_str, &quot;,data=3Dmessage&quot;, sizeof(alg_str) - strl=
en(alg_str) - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (strlcat(alg_str, &quot;,data=3Dmessage&quot;, sizeof(alg_str)) &g=
t;=3D sizeof(alg_str))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span>     }</span><br><span> </span><br><span>     dmsg(D_=
LOW, &quot;xkey management_sign: requesting sig with algorithm &lt;%s&gt;&q=
uot;, alg_str);</span><br><span>diff --git a/src/plugins/auth-pam/utils=2Ec=
 b/src/plugins/auth-pam/utils=2Ec</span><br><span>index a4d2d0b=2E=2Eb6b942=
4 100644</span><br><span>--- a/src/plugins/auth-pam/utils=2Ec</span><br><sp=
an>+++ b/src/plugins/auth-pam/utils=2Ec</span><br><span>@@ -65,23 +65,24 @@=
</span><br><span> </span><br><span>     /* state: all parameters are valid =
*/</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   const char *searching =3D tosearch;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
char temp[templen + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    temp[0] =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *scratc=
h =3D strstr(searching, searchfor);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char *scratch =3D strstr(tosearch, searchfor);</s=
pan><br><span>     if (!scratch)</span><br><span>     {</span><br><span>   =
      return strdup(tosearch);</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *searchi=
ng =3D tosearch;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 char temp[templen + 1] =3D { 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    char *target =3D temp;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>     while (scratch)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strnca=
t(temp, searching, (size_t)(scratch - searching));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        strcat(temp, replacewith);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        size_t skipped =3D (siz=
e_t)(scratch - searching);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        memcpy(target, searching, skipped);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        target +=3D skipped;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        memcpy(target, replacewith,=
 replacewithlen);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        searching =3D scratch + strlen(searchfor);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        searching =3D scratch =
+ tosearchlen;</span><br><span>         scratch =3D strstr(searching, searc=
hfor);</span><br><span>     }</span><br><span>     return strdup(temp);</sp=
an><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1996?usp=3Demail">change 1996</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1996?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I61e29dd2af9302b240c93735179d43c72e37=
b335 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1996 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--A1VCDsrTjRQ=--


--===============3720923198434936354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3720923198434936354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3720923198434936354==--

