Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441F0CC6B1A
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IUXxhLE8HxHwsSinUSvo+a8mzucVH0wjGl1dkIrPdqs=; b=Po9wKcY38mdc6fCR3XEAwRYt1A
	WeTJIn0+IxltbjwdgJiCHEQFBGOTAHehUJIG/9k37ytVd7TklP9uAcn0N+dDxbn4BY0FE9RZ9xQ/h
	xvHu4Gfx7fY8nDTkBLC3pIUJOxCjEabrSreaPH9DjvkTtL2DQaASf8FtZIMtoJgljYLw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGxbb-0000kh-1x;
	Wed, 14 Oct 2026 11:57:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGxba-0000kb-0z
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:57:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=FLBsy7KnrLTCJvNGUiIfuW1h7GbC4E7XUug1rJP52qA=; b=inPYqJKKOPW8abUjZFN7Xm49rk
 O62+p6pGhJRJvFs6S1CMf5/auq38zsFD2ysVwROEoY2BK3PR3MOlUkYjU8KnqDrjj+ufbUkAQSsxc
 slTZsh6XG0R677S6/UIB7xfDxP6KNzDNKHtUptteEgaNBxBrYKKKrK37RdtztkJXAfZE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FLBsy7KnrLTCJvNGUiIfuW1h7GbC4E7XUug1rJP52qA=; b=C
 VOIAuHAgfx/axTvGfPhAb5K8uG+93so1ejC1JOX7yCvzc29c5wTO0bJQPCszC+59g/bWW6DbYEZOv
 hgGERYGuxxg1ot/fUuOHK+ujVdBVYkqnMsJYiTXRJMQhrKY0oV8o5FiUGlbMpCyUdCmwcPBIgDn4k
 s3488ok4wTpZvrpM=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGxbY-000544-Ts for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:57:10 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48dc202a60eso1476839f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 04:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791979022; x=1792583822; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FLBsy7KnrLTCJvNGUiIfuW1h7GbC4E7XUug1rJP52qA=;
 b=MJOjFYzZpJVR2XO8iPrelXPoZkWZBOjAZnh7RCbDS7hbXCFHigbt/anqFMQSaHTack
 vbWC46UtKWI5txGwHYm6plbHcK5Bpttr6Xda7aPpZeOZBGELd1bXWL/4ToRwjlSfQT07
 U29Vo5gZHFfaJU6zeiJ9I5qNINE3MZYkpFbj856MKQLtQOwxSB6NA26pSlfeCo3uLlhU
 2Dhv+lgVd18e9anb5aMFd5BGvdse2WdNMFVrA4cauOK2OSiEoC0K3t3bg6ndKBiXGZDi
 CP1VXhMbvqo3mXKRRX4U4le4t6A7M0WLXJ7hxwFqhZfS1g/3uXd3yyHiMhESK/g9br+p
 hLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791979022; x=1792583822;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FLBsy7KnrLTCJvNGUiIfuW1h7GbC4E7XUug1rJP52qA=;
 b=tm5znvBwSdS2aN5mySbkHfJnerQBfKr5FDw3y7xI0pNY6ViZSwqAiLFfmu7gZbqYyY
 /SRiwIy1aNKas6MjX9imJiCw+rqN85OjonQF4X8OI9pp0BY1USbYlTBIMMP64YVTNRBN
 Wp7TajXD6VUeK/zDF2BDn2jE/zZw1k7v1IRgUzqkbRY1qTe6Bm9xnLnlT46AJqmTxfoJ
 dv9HKbMtiS1kb3/nEYkJ7KGa7mlb4kxOoBCZd13P575LCt2ODAmBl2VW8sldkOqZ9Oxr
 gIfcEx/iyneP9zxhM73tbgj5rYJRAmKkIDaS3JBQ8KsVgrivzCLE7zNKPQGwzJIRO1NI
 3cQg==
X-Gm-Message-State: AFq9FYK+NM3CokpgzxnJSa8DtoDX+X6GW3+QFJc1u3ceB1vAJRJXHrqD
 SOONawtYsYNKU/ujJ2HA9i6/PHIdRbeYfswPIInKhckEyKGwe28YlKoTmzI5AMJkVMVwMG/h73E
 KsWUL8a9eojo869BKLxTc13CD+dlKwY5IwPUYwyM5QUedEa18l9s2HQZHTwWV+SmnVOJY
X-Gm-Gg: AYBFou2XuoryDJJwZ3yNpvrTcnI1Al2h2XI3PhSkgIi9nnxXav2tmrau4nUD1bomPC1
 WFavMww1D8dc0GN/EX2kIsaOG7Z+9x0iruVE/YxKpy6gVBcgx7bE2cp8J7miqKAryYfqwgHHJHv
 eAAmX4pllej1RSElvmWH2kTA76PS2Yt+JQSF41V5LRWIqJWZdL3eht9TxsmAK1dZhMGM1ugTOP7
 RxRuZxKIdWNQKuygUn6Hua8vlWOI4Ln0tklzFoDnNYeivkK0ulNnf2DTEe5iUcAKbx73CrnONIL
 +BWuHWCEMnjGNZS5EoxYGpHCylRXwk/4jjkNmUsRG9dcEXLeD6s8+k/CyDSe2S7ELjJfUBe9Utq
 D+s7A0DYyp43uk+5QZUq0SBmGew8cCzg8rsr8Kk7skzu0az6IRDCt6lLQ0DEI1nTwsfY2TNJkEV
 pu2ZRa8nSgk3WY2FL8mOuHYJ+/RMKQqnioQYG6Lii28QvRN1f3JPvHn+4ASmaix64NTal17rXhb
 SFjZM7A7ti3RV0v1aSe9TvkNPDbk6eXneJc/aB+EzjXaSCgMpK/kSMwcJxaxKXuJEWVafkmM6sO
 nhka3ylcCb1Ui214/okv852+j4Un5zTcEv/TyCGTTks9os85Td2aE9fXtP6C
X-Received: by 2002:a05:6000:2584:b0:48b:10af:f857 with SMTP id
 ffacd0b85a97d-48dbaae547fmr28029509f8f.23.1791979021522; 
 Wed, 14 Oct 2026 04:57:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ac5265sm12209252f8f.41.2026.10.14.04.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:57:01 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 11:56:59 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I61e29dd2af9302b240c93735179d43c72e37b335
X-Gerrit-Change-Number: 1996
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1996?usp=email>
X-Gerrit-Commit: f598e350bab4a80bba9d9be162ab11485254c44c
In-Reply-To: <gerrit.1791901394000.I61e29dd2af9302b240c93735179d43c72e37b335@gerrit.openvpn.net>
References: <gerrit.1791901394000.I61e29dd2af9302b240c93735179d43c72e37b335@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk2MWUyOWRkMmFmOTMwMmIyNDBjOTM3MzUxNzlkNDNjNzJlMzdiMzM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b870752713cf2508c4248f913d72b170635ad95d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGxbY-000544-Ts
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace strncat with
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4222734624442570858=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4222734624442570858==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kqoSeBAVTso="; charset=UTF-8

--kqoSeBAVTso=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a c=
hange=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996?=
usp=3Demail

to look at the new patch set (#3)=2E


Change subject: Replace=
 strncat with strlcat
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Replace strncat with strlcat

Generally much better API=2E Not a=
 straight-forward
replacement in many cases, trying to improve the
code gen=
erally=2E

Change-Id: I61e29dd2af9302b240c93735179d43c72e37b335
Signed-off-=
by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/misc=2Ec
=
M src/openvpn/options_parse=2Ec
M src/openvpn/status=2Ec
M src/openvpn/xkey=
_helper=2Ec
M src/plugins/auth-pam/utils=2Ec
5 files changed, 25 insertions=
(+), 25 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/96/1996/3

diff --git a/src/openvpn/misc=2Ec b/src/openvpn/m=
isc=2Ec
index a75bd8f=2E=2Eb9cc6a2 100644
--- a/src/openvpn/misc=2Ec
+++ b/=
src/openvpn/misc=2Ec
@@ -437,12 +437,11 @@
                     }
         =
            else
                     {
-                        if (strlen=
(up->password) + strlen(response) >=3D USER_PASS_LEN)
+                    =
    if (strlcat(up->password, response, USER_PASS_LEN) >=3D USER_PASS_LEN)
=
                         {
                             msg(M_FATAL,
      =
                           "ERROR: could not concatenate password/static_re=
sponse: string too long");
                         }
-                    =
    strncat(up->password, response, USER_PASS_LEN - strlen(up->password) - =
1);
                     }
                 }
 #endif /* ifdef ENABLE_MANAG=
EMENT */
diff --git a/src/openvpn/options_parse=2Ec b/src/openvpn/options_p=
arse=2Ec
index 12934ab=2E=2E3d893d4 100644
--- a/src/openvpn/options_parse=
=2Ec
+++ b/src/openvpn/options_parse=2Ec
@@ -244,10 +244,7 @@
     else if =
(is->type =3D=3D IS_TYPE_BUF)
     {
         bool status =3D buf_parse(is-=
>u=2Emultiline, '\n', line, size);
-        if ((int)strlen(line) + 1 < siz=
e)
-        {
-            strcat(line, "\n");
-        }
+        strlcat(=
line, "\n", size);
         return status;
     }
     else
diff --git a/sr=
c/openvpn/status=2Ec b/src/openvpn/status=2Ec
index c7d375b=2E=2E981bb23 10=
0644
--- a/src/openvpn/status=2Ec
+++ b/src/openvpn/status=2Ec
@@ -234,14 +=
234,11 @@
 
         if (so->fd >=3D 0 && !so->errors)
         {
-        =
    strcat(buf, "\n");
-            ssize_t len =3D strlen(buf);
-         =
   if (len > 0)
+            size_t len =3D strlcat(buf, "\n", sizeof(buf))=
;
+            ASSERT(len < sizeof(buf));
+            if (write(so->fd, bu=
f, (unsigned int)len) !=3D (ssize_t)len)
             {
-                if=
 (write(so->fd, buf, (unsigned int)len) !=3D len)
-                {
-     =
               so->errors =3D true;
-                }
+                so-=
>errors =3D true;
             }
         }
 
diff --git a/src/openvpn/xkey=
_helper=2Ec b/src/openvpn/xkey_helper=2Ec
index 1149c7b=2E=2E6908cbb 100644=

--- a/src/openvpn/xkey_helper=2Ec
+++ b/src/openvpn/xkey_helper=2Ec
@@ -15=
7,7 +157,7 @@
  * @param tbslen        len of data in dgst
  * @param sigal=
g        extra signature parameters
  *
- * @return              signature =
length or -1 on error=2E
+ * @return              1 on success or 0 on erro=
r=2E
  */
 int
 xkey_management_sign(void *unused, unsigned char *sig, size=
_t *siglen, const unsigned char *tbs,
@@ -247,7 +247,10 @@
 
     if (is_me=
ssage)
     {
-        strncat(alg_str, ",data=3Dmessage", sizeof(alg_str) =
- strlen(alg_str) - 1);
+        if (strlcat(alg_str, ",data=3Dmessage", si=
zeof(alg_str)) >=3D sizeof(alg_str))
+        {
+            return 0;
+   =
     }
     }
 
     dmsg(D_LOW, "xkey management_sign: requesting sig with=
 algorithm <%s>", alg_str);
diff --git a/src/plugins/auth-pam/utils=2Ec b/s=
rc/plugins/auth-pam/utils=2Ec
index a4d2d0b=2E=2E01cc4de 100644
--- a/src/p=
lugins/auth-pam/utils=2Ec
+++ b/src/plugins/auth-pam/utils=2Ec
@@ -47,10 +4=
7,11 @@
     }
 
     size_t tosearchlen =3D strlen(tosearch);
+    size_t =
searchforlen =3D strlen(searchfor);
     size_t replacewithlen =3D strlen(r=
eplacewith);
     size_t templen =3D tosearchlen * replacewithlen;
 
-    i=
f (tosearchlen =3D=3D 0 || strlen(searchfor) =3D=3D 0 || replacewithlen =3D=
=3D 0)
+    if (tosearchlen =3D=3D 0 || searchforlen =3D=3D 0 || replacewit=
hlen =3D=3D 0)
     {
         return NULL;
     }
@@ -65,23 +66,26 @@
 
  =
   /* state: all parameters are valid */
 
-    const char *searching =3D t=
osearch;
-
-    char temp[templen + 1];
-    temp[0] =3D 0;
-
-    const ch=
ar *scratch =3D strstr(searching, searchfor);
+    const char *scratch =3D =
strstr(tosearch, searchfor);
     if (!scratch)
     {
         return strd=
up(tosearch);
     }
 
+    const char *searching =3D tosearch;
+    char t=
emp[templen + 1];
+    memset(temp, 0, sizeof(temp));
+    char *target =3D=
 temp;
+
     while (scratch)
     {
-        strncat(temp, searching, (siz=
e_t)(scratch - searching));
-        strcat(temp, replacewith);
+        si=
ze_t skipped =3D (size_t)(scratch - searching);
+        memcpy(target, sea=
rching, skipped);
+        target +=3D skipped;
+        memcpy(target, rep=
lacewith, replacewithlen);
+        target +=3D replacewithlen;
 
-        =
searching =3D scratch + strlen(searchfor);
+        searching =3D scratch +=
 searchforlen;
         scratch =3D strstr(searching, searchfor);
     }
  =
   return strdup(temp);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1996?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I61e29dd2af9302b240c93735179d43c72e37b335
Gerrit-Change-Number: 19=
96
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Co=
jocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>

--kqoSeBAVTso=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld <strong>uploaded patch set #3</strong> to this change=2E</p><p><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996?usp=3Demail">View=
 Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Replace strncat with strlcat<br><br>Generally =
much better API=2E Not a straight-forward<br>replacement in many cases, try=
ing to improve the<br>code generally=2E<br><br>Change-Id: I61e29dd2af9302b2=
40c93735179d43c72e37b335<br>Signed-off-by: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt;<br>---<br>M src/openvpn/misc=2Ec<br>M src/openvpn/options=
_parse=2Ec<br>M src/openvpn/status=2Ec<br>M src/openvpn/xkey_helper=2Ec<br>=
M src/plugins/auth-pam/utils=2Ec<br>5 files changed, 25 insertions(+), 25 d=
eletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/96/1996/3</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mis=
c=2Ec b/src/openvpn/misc=2Ec</span><br><span>index a75bd8f=2E=2Eb9cc6a2 100=
644</span><br><span>--- a/src/openvpn/misc=2Ec</span><br><span>+++ b/src/op=
envpn/misc=2Ec</span><br><span>@@ -437,12 +437,11 @@</span><br><span>      =
               }</span><br><span>                     else</span><br><span>=
                     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                        if (strlen(up-&gt;password) + strlen(response) &gt=
;=3D USER_PASS_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        if (strlcat(up-&gt;password, response, USER_PASS_LE=
N) &gt;=3D USER_PASS_LEN)</span><br><span>                         {</span>=
<br><span>                             msg(M_FATAL,</span><br><span>       =
                          &quot;ERROR: could not concatenate password/stati=
c_response: string too long&quot;);</span><br><span>                       =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
      strncat(up-&gt;password, response, USER_PASS_LEN - strlen(up-&gt;pass=
word) - 1);</span><br><span>                     }</span><br><span>        =
         }</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br>=
<span>diff --git a/src/openvpn/options_parse=2Ec b/src/openvpn/options_pars=
e=2Ec</span><br><span>index 12934ab=2E=2E3d893d4 100644</span><br><span>---=
 a/src/openvpn/options_parse=2Ec</span><br><span>+++ b/src/openvpn/options_=
parse=2Ec</span><br><span>@@ -244,10 +244,7 @@</span><br><span>     else if=
 (is-&gt;type =3D=3D IS_TYPE_BUF)</span><br><span>     {</span><br><span>  =
       bool status =3D buf_parse(is-&gt;u=2Emultiline, &#39;\n&#39;, line, =
size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((in=
t)strlen(line) + 1 &lt; size)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        strcat(line, &quot;\n&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        strlcat(line, &quot;\n&quot;, size);</span><br><span>        =
 return status;</span><br><span>     }</span><br><span>     else</span><br>=
<span>diff --git a/src/openvpn/status=2Ec b/src/openvpn/status=2Ec</span><b=
r><span>index c7d375b=2E=2E981bb23 100644</span><br><span>--- a/src/openvpn=
/status=2Ec</span><br><span>+++ b/src/openvpn/status=2Ec</span><br><span>@@=
 -234,14 +234,11 @@</span><br><span> </span><br><span>         if (so-&gt;f=
d &gt;=3D 0 &amp;&amp; !so-&gt;errors)</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            strcat(buf, &quot;\=
n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
ssize_t len =3D strlen(buf);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            if (len &gt; 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            size_t len =3D strlcat(buf, &quot;\n&quot;, size=
of(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  ASSERT(len &lt; sizeof(buf));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (write(so-&gt;fd, buf, (unsigned int)len) !=3D (=
ssize_t)len)</span><br><span>             {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                if (write(so-&gt;fd, buf, (unsigned i=
nt)len) !=3D len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            so-&gt;errors =3D true;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                so-&gt;errors =3D true;</span><br><span>       =
      }</span><br><span>         }</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/xkey_helper=2Ec b/src/openvpn/xkey_helper=2Ec</span><br>=
<span>index 1149c7b=2E=2E6908cbb 100644</span><br><span>--- a/src/openvpn/x=
key_helper=2Ec</span><br><span>+++ b/src/openvpn/xkey_helper=2Ec</span><br>=
<span>@@ -157,7 +157,7 @@</span><br><span>  * @param tbslen        len of d=
ata in dgst</span><br><span>  * @param sigalg        extra signature parame=
ters</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @return              signature length or -1 on error=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return              1 on succ=
ess or 0 on error=2E</span><br><span>  */</span><br><span> int</span><br><s=
pan> xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,=
 const unsigned char *tbs,</span><br><span>@@ -247,7 +247,10 @@</span><br><=
span> </span><br><span>     if (is_message)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        strncat(alg_str, &quot=
;,data=3Dmessage&quot;, sizeof(alg_str) - strlen(alg_str) - 1);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (strlcat(alg_str, &q=
uot;,data=3Dmessage&quot;, sizeof(alg_str)) &gt;=3D sizeof(alg_str))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            return 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</=
span><br><span> </span><br><span>     dmsg(D_LOW, &quot;xkey management_sig=
n: requesting sig with algorithm &lt;%s&gt;&quot;, alg_str);</span><br><spa=
n>diff --git a/src/plugins/auth-pam/utils=2Ec b/src/plugins/auth-pam/utils=
=2Ec</span><br><span>index a4d2d0b=2E=2E01cc4de 100644</span><br><span>--- =
a/src/plugins/auth-pam/utils=2Ec</span><br><span>+++ b/src/plugins/auth-pam=
/utils=2Ec</span><br><span>@@ -47,10 +47,11 @@</span><br><span>     }</span=
><br><span> </span><br><span>     size_t tosearchlen =3D strlen(tosearch);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t searchfor=
len =3D strlen(searchfor);</span><br><span>     size_t replacewithlen =3D s=
trlen(replacewith);</span><br><span>     size_t templen =3D tosearchlen * r=
eplacewithlen;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (tosearchlen =3D=3D 0 || strlen(searchfor) =3D=3D 0 || re=
placewithlen =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (tosearchlen =3D=3D 0 || searchforlen =3D=3D 0 || replacewithlen =
=3D=3D 0)</span><br><span>     {</span><br><span>         return NULL;</spa=
n><br><span>     }</span><br><span>@@ -65,23 +66,26 @@</span><br><span> </s=
pan><br><span>     /* state: all parameters are valid */</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *search=
ing =3D tosearch;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    char temp[templen + 1=
];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    temp[0] =3D 0;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const char *scratch =3D strstr(searchin=
g, searchfor);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *scratch =3D strstr(tosearch, searchfor);</span><br><span>     if=
 (!scratch)</span><br><span>     {</span><br><span>         return strdup(t=
osearch);</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char *searching =3D tosearch;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    char temp[templen + =
1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memset(temp,=
 0, sizeof(temp));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   char *target =3D temp;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span>     while (scratch)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        strncat(temp, searchin=
g, (size_t)(scratch - searching));</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        strcat(temp, replacewith);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        size_t skipped =3D (size_t)(scratch - s=
earching);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
emcpy(target, searching, skipped);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        target +=3D skipped;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        memcpy(target, replacewith, replacewithlen)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        target +=
=3D replacewithlen;</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        searching =3D scratch + strlen(searchfor);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        searching =3D scratc=
h + searchforlen;</span><br><span>         scratch =3D strstr(searching, se=
archfor);</span><br><span>     }</span><br><span>     return strdup(temp);<=
/span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1996?usp=3Demail">change 1996</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1996?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I61e29dd2af9302b240c93735179d43=
c72e37b335 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1996 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"=
display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>

</body></html>
--kqoSeBAVTso=--


--===============4222734624442570858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4222734624442570858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4222734624442570858==--

