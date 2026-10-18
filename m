Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB41CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ya4BnHJA6d0PLtL+kdna0IvpJ8hIigMKxDH6fLPrryE=; b=eW7c+MbonPoaIGxqQfujnqs72v
	V6obFLJWN0paQNI+TLJwNeb/peyPkKpqaXSWueG+qzNFhep7cbxGyoChTydOJn9wdlkIjI7YkF65y
	VEnkmg6HLjj0lxM5yRA+B23yvrCuUEvSO341Q/ibvbEcik5HQAN1qpmc6DUClk1/InmI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIQY5-0000H3-3P;
	Sun, 18 Oct 2026 13:03:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIQY3-0000Go-EL
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:03:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JxpEG4QDRBZR9yo7F8YJjrLc16X30ednPmAzQABb3jI=; b=KrTqWnLBshDfO51m+yR/47x/yA
 R2LI+1ayiV0nRKZAj6si+c53w/AckmYkRaBf1o+p1vfaKNgtRDrhdyIKasnCNATuPllmna+9opHyd
 WlrqCgNVPLy4jV2CQlubzVW6wWEkOPyfYYTXG2XXIj2TyuR9Jj9r995t+SIxUvcpOp+M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JxpEG4QDRBZR9yo7F8YJjrLc16X30ednPmAzQABb3jI=; b=d
 W+JFoeUZadvWBNZwD7BBfm5E5KjzTabh0vBoIcFZXDIi6jSFMebKvczTiLlsPDn6jfckt5MpZ6fX2
 yEbbyogWwa0kAVOTkXBWZEoiNyn1Ny0Ut0zEIXlbTVN1SUSBvIRHv/nyfZeSijpjQDJYpavRHfyFG
 xJZuiVlqgPq5w+ak=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIQY2-0004Yu-Ef for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:03:36 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so1025876f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792328608; x=1792933408; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JxpEG4QDRBZR9yo7F8YJjrLc16X30ednPmAzQABb3jI=;
 b=chQMvixGQJsuG9+sZ1sfuny3nSx28dWtmfXrfh6EgbKStOsMnTHH9NwrtE1upfdtnP
 m2miVEVS4UudnIMQVrZ/I//VvjkGmOvKzr1ur+n/lX83SdZnPi1EeFQ4c+J/SA0Cb9qB
 GmpUB7N2V1WB74h5cC4N/IgMJzBMYRb9j/YG2EBtHlwNgtcccNSACEkEZnjcbg9v7/Nq
 64G1Uo/0MlbdtBJRtZ+Kk+jEdL7sgIrTtcnadrFkQn83vWQf6LFuq/KT/Mk+ViWvmBtJ
 NN3XEsYYQ8PuFF2bJ5ucPrIvrmT1U4QOic3rr9PqOAuWlFP9Xw74fowue4l060sV7I6A
 s+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792328608; x=1792933408;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JxpEG4QDRBZR9yo7F8YJjrLc16X30ednPmAzQABb3jI=;
 b=SSNNP3pLj/7E6Yqg0aYQzJSu7eAnftcYY/iPv8/olKlI2Jn9hDexGz6fznDyytlDCh
 zPPh1tj6JuWOyiut2sMdMEOut1qjbTBPoEhpMRwByvY36DaZYdxVdc8kHirsuab98CHz
 3j9S6nOWDQMYfYOOxM10LdKXgA3ss+E0lK0BByc/mIR6TpMGWidblwsNUMmaSMhkNCsY
 0BHowfW9z437E5ovA8yt5pwQdrUs72slHKEwpBo7MrcsCQFiGZAgIhRExhJNSjf0e9TA
 9uHY474D5lPxUvp/tYXTuSFSIwuTOfaUm45SIL06IWeNjSrOsuznn/uWWjYkwDPHS3NM
 3zNA==
X-Gm-Message-State: AFq9FYK5UU1xXsBGwSd49k2A9S3LBI6wNCZKFIwJ2gxGcTFuTl3zBq1v
 brciU6eCQv+uSE7BPXgrKat0thjA0GLLaopjcw4jOysUbFnMmGKJliHTyufca3Y5P+NmEDOZeqv
 Y3HRMaRXWCe9M5KYJLfXU8GiEKJZBci6nijJpe9q7S6r2/nNXCgEw8MjUNgQVZUbJA8IP
X-Gm-Gg: AYBFou1PNjkRgiT2jS6sm6ZZ0NIBAyj2bzFuRcDqWUrGpEVmlNfHQR6TILGr4fqIiSR
 BhXz8ruNKOSCB3mt7Jeeix/QzRsDZOBHciOWjF0BEo56/TEJwHD2oIVzNEYbsszirE+4Bqak/NW
 OvZTty16j6Y9q7UpVbkOYTkkbh5tPTCBnBgYsm5Bo2+Qck9qzOvdzTEnUk6IrZsuI392hDIMScp
 Z2aavXf8TJUjkH9xRCyo8xIz0S1+Viav2CG/o3dmUiEq0cALZMD6w6HXJXLYe0r7dQvMXiaCVWa
 KVPaTUDgWBtQfSegoDf8nx8ZphVtwHnuCCN+1Ono2e7a6PvOdqptCKHJIGhk54KemYmMLtW1ymn
 BqMaQ2leLd45FX0WxUEN7y0goduiLb9BfQ7EIUT0tAHsYQgx2H1xL9lCOi18uzhgBFhUz1TU47w
 A5ABk9GYBxddD/xhZKwxTxq70O4gWS5Hq9WmiA6gVhIPt9XWZa+3f+J9Bm4NIG6SQIWM9qcvlLn
 qhT7n/mnAiQQVQDqyG/b8W0QaeQNqAoG9EmZMZcZTpIdQsm05NJNtAT9crEAQMWdjDTVIwrDvGw
 LzWGQm+vDmH816WGqSlzhSX+29lUHNGFPje1wjXCYBi4C1y7ddUljCYLnl+5
X-Received: by 2002:adf:edc6:0:b0:48d:f7c0:97c0 with SMTP id
 ffacd0b85a97d-48e07fb751bmr6453524f8f.50.1792328607626; 
 Sun, 18 Oct 2026 06:03:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4e7889sm16852380f8f.24.2026.10.18.06.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 06:03:27 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 13:03:25 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I61e29dd2af9302b240c93735179d43c72e37b335
X-Gerrit-Change-Number: 1996
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1996?usp=email>
X-Gerrit-Commit: fa57eb158da8a1c03a6f037cc536f5a3bce656f3
In-Reply-To: <gerrit.1791901394000.I61e29dd2af9302b240c93735179d43c72e37b335@gerrit.openvpn.net>
References: <gerrit.1791901394000.I61e29dd2af9302b240c93735179d43c72e37b335@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk2MWUyOWRkMmFmOTMwMmIyNDBjOTM3MzUxNzlkNDNjNzJlMzdiMzM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <590c3041e227e01de399f3ad23db588483431a1f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIQY2-0004Yu-Ef
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6870982192917451558=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6870982192917451558==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/lboBT+4gow="; charset=UTF-8

--/lboBT+4gow=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
996?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: Replace strncat with=
 strlcat
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Repl=
ace strncat with strlcat

Generally much better API=2E Not a straight-forwa=
rd
replacement in many cases, trying to improve the
code generally=2E

Chan=
ge-Id: I61e29dd2af9302b240c93735179d43c72e37b335
Signed-off-by: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996
Message=
-Id: <20261017171508=2E15923-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39946=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/mis=
c=2Ec
M src/openvpn/options_parse=2Ec
M src/openvpn/status=2Ec
M src/openvp=
n/xkey_helper=2Ec
M src/plugins/auth-pam/utils=2Ec
5 files changed, 25 inse=
rtions(+), 25 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/96/1996/4

diff --git a/src/openvpn/misc=2Ec b/src/ope=
nvpn/misc=2Ec
index a75bd8f=2E=2Eb9cc6a2 100644
--- a/src/openvpn/misc=2Ec
=
+++ b/src/openvpn/misc=2Ec
@@ -437,12 +437,11 @@
                     }
   =
                  else
                     {
-                        if (=
strlen(up->password) + strlen(response) >=3D USER_PASS_LEN)
+              =
          if (strlcat(up->password, response, USER_PASS_LEN) >=3D USER_PASS=
_LEN)
                         {
                             msg(M_FATAL,
=
                                 "ERROR: could not concatenate password/sta=
tic_response: string too long");
                         }
-              =
          strncat(up->password, response, USER_PASS_LEN - strlen(up->passwo=
rd) - 1);
                     }
                 }
 #endif /* ifdef ENABLE=
_MANAGEMENT */
diff --git a/src/openvpn/options_parse=2Ec b/src/openvpn/opt=
ions_parse=2Ec
index 79b8098=2E=2E5d6f93e 100644
--- a/src/openvpn/options_=
parse=2Ec
+++ b/src/openvpn/options_parse=2Ec
@@ -244,10 +244,7 @@
     els=
e if (is->type =3D=3D IS_TYPE_BUF)
     {
         bool status =3D buf_pars=
e(is->u=2Emultiline, '\n', line, size);
-        if ((int)strlen(line) + 1 =
< size)
-        {
-            strcat(line, "\n");
-        }
+        str=
lcat(line, "\n", size);
         return status;
     }
     else
diff --git=
 a/src/openvpn/status=2Ec b/src/openvpn/status=2Ec
index cfbc38d=2E=2E10365=
36 100644
--- a/src/openvpn/status=2Ec
+++ b/src/openvpn/status=2Ec
@@ -234=
,14 +234,11 @@
 
         if (so->fd >=3D 0 && !so->errors)
         {
-   =
         strcat(buf, "\n");
-            ssize_t len =3D strlen(buf);
-    =
        if (len > 0)
+            size_t len =3D strlcat(buf, "\n", sizeof(=
buf));
+            ASSERT(len < sizeof(buf));
+            if (write(so->f=
d, buf, (unsigned int)len) !=3D (ssize_t)len)
             {
-             =
   if (write(so->fd, buf, (unsigned int)len) !=3D len)
-                {
-=
                    so->errors =3D true;
-                }
+              =
  so->errors =3D true;
             }
         }
 
diff --git a/src/openvpn=
/xkey_helper=2Ec b/src/openvpn/xkey_helper=2Ec
index 1149c7b=2E=2E6908cbb 1=
00644
--- a/src/openvpn/xkey_helper=2Ec
+++ b/src/openvpn/xkey_helper=2Ec
@=
@ -157,7 +157,7 @@
  * @param tbslen        len of data in dgst
  * @param =
sigalg        extra signature parameters
  *
- * @return              signa=
ture length or -1 on error=2E
+ * @return              1 on success or 0 on=
 error=2E
  */
 int
 xkey_management_sign(void *unused, unsigned char *sig,=
 size_t *siglen, const unsigned char *tbs,
@@ -247,7 +247,10 @@
 
     if (=
is_message)
     {
-        strncat(alg_str, ",data=3Dmessage", sizeof(alg_=
str) - strlen(alg_str) - 1);
+        if (strlcat(alg_str, ",data=3Dmessage=
", sizeof(alg_str)) >=3D sizeof(alg_str))
+        {
+            return 0;=

+        }
     }
 
     dmsg(D_LOW, "xkey management_sign: requesting sig=
 with algorithm <%s>", alg_str);
diff --git a/src/plugins/auth-pam/utils=2E=
c b/src/plugins/auth-pam/utils=2Ec
index a4d2d0b=2E=2E01cc4de 100644
--- a/=
src/plugins/auth-pam/utils=2Ec
+++ b/src/plugins/auth-pam/utils=2Ec
@@ -47,=
10 +47,11 @@
     }
 
     size_t tosearchlen =3D strlen(tosearch);
+    si=
ze_t searchforlen =3D strlen(searchfor);
     size_t replacewithlen =3D str=
len(replacewith);
     size_t templen =3D tosearchlen * replacewithlen;
 
-=
    if (tosearchlen =3D=3D 0 || strlen(searchfor) =3D=3D 0 || replacewithle=
n =3D=3D 0)
+    if (tosearchlen =3D=3D 0 || searchforlen =3D=3D 0 || repla=
cewithlen =3D=3D 0)
     {
         return NULL;
     }
@@ -65,23 +66,26 @@=

 
     /* state: all parameters are valid */
 
-    const char *searching =
=3D tosearch;
-
-    char temp[templen + 1];
-    temp[0] =3D 0;
-
-    con=
st char *scratch =3D strstr(searching, searchfor);
+    const char *scratch=
 =3D strstr(tosearch, searchfor);
     if (!scratch)
     {
         return=
 strdup(tosearch);
     }
 
+    const char *searching =3D tosearch;
+    c=
har temp[templen + 1];
+    memset(temp, 0, sizeof(temp));
+    char *targe=
t =3D temp;
+
     while (scratch)
     {
-        strncat(temp, searching,=
 (size_t)(scratch - searching));
-        strcat(temp, replacewith);
+     =
   size_t skipped =3D (size_t)(scratch - searching);
+        memcpy(target=
, searching, skipped);
+        target +=3D skipped;
+        memcpy(target=
, replacewith, replacewithlen);
+        target +=3D replacewithlen;
 
-   =
     searching =3D scratch + strlen(searchfor);
+        searching =3D scra=
tch + searchforlen;
         scratch =3D strstr(searching, searchfor);
    =
 }
     return strdup(temp);

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1996?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I61e29dd2af9302b240c93735179d43c72e37b335
Gerrit-Change-Num=
ber: 1996
Gerrit-PatchSet: 4
Gerrit-Owner: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--/lboBT+4gow=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1996?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Replace strncat with strlcat<br><br>Generally much better API=2E Not a =
straight-forward<br>replacement in many cases, trying to improve the<br>cod=
e generally=2E<br><br>Change-Id: I61e29dd2af9302b240c93735179d43c72e37b335<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acke=
d-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996<br>Message-Id: &lt;20261017171508=
=2E15923-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39946=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
misc=2Ec<br>M src/openvpn/options_parse=2Ec<br>M src/openvpn/status=2Ec<br>=
M src/openvpn/xkey_helper=2Ec<br>M src/plugins/auth-pam/utils=2Ec<br>5 file=
s changed, 25 insertions(+), 25 deletions(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/96/1996/4</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</span><br><sp=
an>index a75bd8f=2E=2Eb9cc6a2 100644</span><br><span>--- a/src/openvpn/misc=
=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span><br><span>@@ -437,12 =
+437,11 @@</span><br><span>                     }</span><br><span>         =
            else</span><br><span>                     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                        if (strlen(up-&gt=
;password) + strlen(response) &gt;=3D USER_PASS_LEN)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        if (strlcat(up-&g=
t;password, response, USER_PASS_LEN) &gt;=3D USER_PASS_LEN)</span><br><span=
>                         {</span><br><span>                             ms=
g(M_FATAL,</span><br><span>                                 &quot;ERROR: co=
uld not concatenate password/static_response: string too long&quot;);</span=
><br><span>                         }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                        strncat(up-&gt;password, response, =
USER_PASS_LEN - strlen(up-&gt;password) - 1);</span><br><span>             =
        }</span><br><span>                 }</span><br><span> #endif /* ifd=
ef ENABLE_MANAGEMENT */</span><br><span>diff --git a/src/openvpn/options_pa=
rse=2Ec b/src/openvpn/options_parse=2Ec</span><br><span>index 79b8098=2E=2E=
5d6f93e 100644</span><br><span>--- a/src/openvpn/options_parse=2Ec</span><b=
r><span>+++ b/src/openvpn/options_parse=2Ec</span><br><span>@@ -244,10 +244=
,7 @@</span><br><span>     else if (is-&gt;type =3D=3D IS_TYPE_BUF)</span><=
br><span>     {</span><br><span>         bool status =3D buf_parse(is-&gt;u=
=2Emultiline, &#39;\n&#39;, line, size);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if ((int)strlen(line) + 1 &lt; size)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            strcat(line, &quot;\n&quot;);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        strlcat(line, &quot;\n&qu=
ot;, size);</span><br><span>         return status;</span><br><span>     }<=
/span><br><span>     else</span><br><span>diff --git a/src/openvpn/status=
=2Ec b/src/openvpn/status=2Ec</span><br><span>index cfbc38d=2E=2E1036536 10=
0644</span><br><span>--- a/src/openvpn/status=2Ec</span><br><span>+++ b/src=
/openvpn/status=2Ec</span><br><span>@@ -234,14 +234,11 @@</span><br><span> =
</span><br><span>         if (so-&gt;fd &gt;=3D 0 &amp;&amp; !so-&gt;errors=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            strcat(buf, &quot;\n&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            ssize_t len =3D strlen(buf);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            if (len &gt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            size_t len=
 =3D strlcat(buf, &quot;\n&quot;, sizeof(buf));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            ASSERT(len &lt; sizeof(buf));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (write(so-=
&gt;fd, buf, (unsigned int)len) !=3D (ssize_t)len)</span><br><span>        =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 if (write(so-&gt;fd, buf, (unsigned int)len) !=3D len)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    so-&gt;errors =3D true;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                so-&gt;=
errors =3D true;</span><br><span>             }</span><br><span>         }<=
/span><br><span> </span><br><span>diff --git a/src/openvpn/xkey_helper=2Ec =
b/src/openvpn/xkey_helper=2Ec</span><br><span>index 1149c7b=2E=2E6908cbb 10=
0644</span><br><span>--- a/src/openvpn/xkey_helper=2Ec</span><br><span>+++ =
b/src/openvpn/xkey_helper=2Ec</span><br><span>@@ -157,7 +157,7 @@</span><br=
><span>  * @param tbslen        len of data in dgst</span><br><span>  * @pa=
ram sigalg        extra signature parameters</span><br><span>  *</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * @return              signatur=
e length or -1 on error=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @return              1 on success or 0 on error=2E</span><br><spa=
n>  */</span><br><span> int</span><br><span> xkey_management_sign(void *unu=
sed, unsigned char *sig, size_t *siglen, const unsigned char *tbs,</span><b=
r><span>@@ -247,7 +247,10 @@</span><br><span> </span><br><span>     if (is_=
message)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        strncat(alg_str, &quot;,data=3Dmessage&quot;, sizeof(alg_=
str) - strlen(alg_str) - 1);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (strlcat(alg_str, &quot;,data=3Dmessage&quot;, sizeof(a=
lg_str)) &gt;=3D sizeof(alg_str))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            return 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span>     }</span><br><span> </span><br><span>  =
   dmsg(D_LOW, &quot;xkey management_sign: requesting sig with algorithm &l=
t;%s&gt;&quot;, alg_str);</span><br><span>diff --git a/src/plugins/auth-pam=
/utils=2Ec b/src/plugins/auth-pam/utils=2Ec</span><br><span>index a4d2d0b=
=2E=2E01cc4de 100644</span><br><span>--- a/src/plugins/auth-pam/utils=2Ec</=
span><br><span>+++ b/src/plugins/auth-pam/utils=2Ec</span><br><span>@@ -47,=
10 +47,11 @@</span><br><span>     }</span><br><span> </span><br><span>     =
size_t tosearchlen =3D strlen(tosearch);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    size_t searchforlen =3D strlen(searchfor);</span><=
br><span>     size_t replacewithlen =3D strlen(replacewith);</span><br><spa=
n>     size_t templen =3D tosearchlen * replacewithlen;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tosearchlen =3D=
=3D 0 || strlen(searchfor) =3D=3D 0 || replacewithlen =3D=3D 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (tosearchlen =3D=3D 0 ||=
 searchforlen =3D=3D 0 || replacewithlen =3D=3D 0)</span><br><span>     {</=
span><br><span>         return NULL;</span><br><span>     }</span><br><span=
>@@ -65,23 +66,26 @@</span><br><span> </span><br><span>     /* state: all p=
arameters are valid */</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const char *searching =3D tosearch;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    char temp[templen + 1];</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    temp[0] =3D 0;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const char *scratch =3D strstr(searching, searchfor);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *scratch =3D strstr(tose=
arch, searchfor);</span><br><span>     if (!scratch)</span><br><span>     {=
</span><br><span>         return strdup(tosearch);</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char *searching =3D tosearch;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    char temp[templen + 1];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    memset(temp, 0, sizeof(temp));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    char *target =3D temp;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     while =
(scratch)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        strncat(temp, searching, (size_t)(scratch - searching));=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strcat(temp, =
replacewith);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  size_t skipped =3D (size_t)(scratch - searching);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        memcpy(target, searching, skipped=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        target +=
=3D skipped;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 memcpy(target, replacewith, replacewithlen);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        target +=3D replacewithlen;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        searching=
 =3D scratch + strlen(searchfor);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        searching =3D scratch + searchforlen;</span><br><span=
>         scratch =3D strstr(searching, searchfor);</span><br><span>     }<=
/span><br><span>     return strdup(temp);</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996?usp=3Demail">ch=
ange 1996</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I61e29dd2af9302b240c93735179d43c72e37b335 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1996 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body>=
</html>
--/lboBT+4gow=--


--===============6870982192917451558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6870982192917451558==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6870982192917451558==--

