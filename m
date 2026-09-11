Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD4BC88E58
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 11:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aqUJ5coNV3V55zTOW9rE0jMdJljTYx3pOuCB+n6tPC0=; b=LOnyQLOSnihNH2RBrwOmfEhUQ7
	3kTfMWjLO2TfFXUiQlv4qC+ZkJUpmIY5NlN4+kCQSL+M1PzQJ1UUjryx24qT3Lb4/xFuXtyJbgvy3
	FjcHbihQN4O1q2XIfIm+8ct5T080plu2BzA7JHPEJ3rtzn21kWnGqXb1G9P2FIgcdnKc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4zlp-0001n4-Kz;
	Fri, 11 Sep 2026 11:50:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4zlN-0001le-W5
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 11:49:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+uv4rgqwAbBl2HhGCBhmHBooqi9y1rusgM0pHPi8l90=; b=B+Enfei4zWmokNV8bvqA7E7p3O
 4Pngn04M8I2tJNR+3N8K5ej6wFXTWqvfeA+mZaPED/ObcTF55yEQigj2ziRVeEyfjFA+R83MisWP4
 h90+vd5x+kvrPTy3sYScC2FYorwNbnqMjozLlgd/XUAr/zge8j6uNymyDnNShKnSsAaY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+uv4rgqwAbBl2HhGCBhmHBooqi9y1rusgM0pHPi8l90=; b=l
 W3KJn5a8VU5Q8gRn9t3c/Vn4nLqe1QJFFEmduo+yPkxPQTBEtGEEUQiit+/PPVs/NvfRlAQyh/54m
 NflXkVMmudH/UFemQJCGksakTHIsouMD2oDHc1mJUUVlOP+p3adpnMviJk94tiAN1/INqA8YoISUg
 TgUJrRXkQZeymWbA=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4zlD-0001Nk-16 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 11:49:41 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso6521375e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 04:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789127372; x=1789732172; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+uv4rgqwAbBl2HhGCBhmHBooqi9y1rusgM0pHPi8l90=;
 b=U463DIKjY5i5/LtQO8Ut3KMO9ES8LiwC+pr6wnOn27TQSshrykzn8d9vUr6zOYobv+
 XbafYrsWI8+deWn7FPl0Ntq04YVAHKfhpt1JIBLJjHMeccCFarVY/cjs9+9V9+ZUxOYy
 eNmokjWrVNnu4Os+Is03/hRLj2hDi5xllObTVJalyUG38daGEWp7kENZ/BWpr4LBmcFe
 Ofmamb3eOzkRwizY0UUhXmmp6/ixlXWL+Ci0Go53OcFktDAj+OeUSzizBn+C8U5M776s
 JARyfZWSwi4m1XVvwwWzU+hvrusQ+4dUddWhdFP11dvZBXgYykCBlOcWsFBGiisVm7+t
 zOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789127372; x=1789732172;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+uv4rgqwAbBl2HhGCBhmHBooqi9y1rusgM0pHPi8l90=;
 b=fWZoACLHHplf73f1agJ3aFDl0mQ1EA8aoqF9yJIQy4QVgi95qp0k3ziBkOGNzD+3hk
 6eb6BrVmyutBuPD+28/GxXpZEongmH/GzkY3TrnIEuzu6L4TXLORpkGgQnVbb+4PmNXt
 Vg1aJiYLQkCGEDoqhj9weSkWN9ptuEHR5c2WvLVlliiQBtxtc0fmD/xzAcZuawfaX4Rr
 MT/dSZE4lOXr+yppYImgUutiYqfDl+DixAw0sH3jdqi7EyQGH6IzVX8NHNJVN7eKZ04G
 dVojZZxl9IhvJLluuwHSieYHV4YcxjkFFa+WGn1i9ZvvjwV9+MOIdsd8p9XWWXrMdNEA
 3l3w==
X-Gm-Message-State: AFuF++nF+YIKghJlEu/HMIiyUpmNDQLDc9SamlVW4twHnCUf9BaBsidH
 Oz8q2zcvhulyB0wAvnxyoWYMf7zjb6pPCaOe8fKtEOO+myqiMJB0gK4GOd6rBb6zDUc0IofJok1
 GJg8sOktULsOSYb0Ox5TmPo4ZEJKBXWyUX61sPdhdw7zHMbwYu1SNsjY4jU5Yd9yXugc2GIbnLH
 w/Vfm5mg==
X-Gm-Gg: AYBFou1vcieoq6fKNv91E+8gawI7bjk9vwZqR6cooCzMMNcDMxw+959DlxqQOdNGWyD
 RS1jjBqA+ry8ZUez9TcexZMyQUIkt3zObkXfyPpV8NwqhfKBSeinDT8x5k43rlAozcC1KDXeypv
 MFQ/CkbRrF7iubfHeSkeUrm5wGqn+LNks06A+SQMxRBBgoz3N7YsGGagExCCEGE8M00ZSzCq+Fn
 IBq0MIJflwuqxgTRkQwXqzjD8iPZA2+ACpNbyToVIR8SDXH209+iVm8qWTn2v+/aHSlyctQsPyY
 DR3s+tEqMA7/NqTJg6hibBR0dnbxs/exwGCgbN9YFTWxs0GxLa0qWK9vmVFmfE2E4L80mtRGcmP
 i2iUbHJbTfKejH7I1VECpEUoLV4x3K78WK9cKSB1/BB6uVvQlrs51xJA7JLW2AroCuvviO7HBiR
 XGIpOzgfWsnOt0e0QbP089LyMhEIRWzs0bD3wB8OA4uq4wDCYpZ6qujhC8MHa8bfhVf3Mb+uroa
 3klGZc+Yl6pkrKDkjs54AIAraN4fKuZ5fpATvV3srNsOBBGbbkZC/NHYFNzCDHFvGLx2zUTz7nZ
 33pHPiNHmLuCFV8O1NyOuHelyH9yjAa4Gs52ON6mGZnogKSotGTHKRNxP5Nfyw==
X-Received: by 2002:a05:600c:1d08:b0:49d:2450:68ac with SMTP id
 5b1f17b1804b1-49e619b57admr92253595e9.5.1789127372102; 
 Fri, 11 Sep 2026 04:49:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60adaee4sm100278145e9.14.2026.09.11.04.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 04:49:31 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 11:49:27 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I4351fc499188b7d0cdbcb4f0531e9f157e948c5e
X-Gerrit-Change-Number: 1903
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1903?usp=email>
X-Gerrit-Commit: 5c5d65d441b73c3fa30eb7d0151e89b2c04c8dad
In-Reply-To: <gerrit.1788815035000.I4351fc499188b7d0cdbcb4f0531e9f157e948c5e@gerrit.openvpn.net>
References: <gerrit.1788815035000.I4351fc499188b7d0cdbcb4f0531e9f157e948c5e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODE1MDM1MDAwLkk0MzUxZmM0OTkxODhiN2QwY2RiY2I0ZjA1MzFlOWYxNTdlOTQ4YzVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0e79c6768a5aa28ee6d9bd15ab2d9fdbb58555e8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4zlD-0001Nk-16
Subject: [Openvpn-devel] [M] Change in openvpn[master]: management: Remove
 management argument to functions that do not need it
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
Content-Type: multipart/mixed; boundary="===============2096735346634496469=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2096735346634496469==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ag5teOoEdEo="; charset=UTF-8

--Ag5teOoEdEo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, razvanc, 

I'd like you to reexamine a change=2E Please visit

    =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1903?usp=3Demail

to look at the =
new patch set (#3)=2E

The change is no longer submittable: checks~ChecksSu=
bmitRule is unsatisfied now=2E


Change subject: management: Remove managem=
ent argument to functions that do not need it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

management: Remove management argument t=
o functions that do not need it

Found when reviewing the cppcheck constPar=
ameterPointer
warnings=2E

Change-Id: I4351fc499188b7d0cdbcb4f0531e9f157e94=
8c5e
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/o=
penvpn/init=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/ope=
nvpn/multi=2Ec
M src/openvpn/options=2Ec
M src/openvpn/push=2Ec
6 files cha=
nged, 42 insertions(+), 44 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/03/1903/3

diff --git a/src/openvpn/init=
=2Ec b/src/openvpn/init=2Ec
index 1109a13=2E=2E453ee7e 100644
--- a/src/ope=
nvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -260,7 +260,7 @@
             s=
truct buffer out =3D alloc_buf_gc(256, &gc);
             buf_printf(&out, =
">PROXY:%u,%s,%s", (l ? l->current : 0) + 1,
                        (proto=
_is_udp(ce->proto) ? "UDP" : "TCP"), np(ce->remote));
-            manageme=
nt_notify_generic(management, BSTR(&out));
+            management_notify_g=
eneric(BSTR(&out));
             management->persist=2Especial_state_msg =
=3D BSTR(&out);
         }
         ce->flags |=3D CE_MAN_QUERY_PROXY;
@@ -=
425,7 +425,7 @@
 
         buf_printf(&out, ">REMOTE:%s,%s,%s", np(ce->remo=
te), ce->remote_port,
                    proto2ascii(ce->proto, ce->af, fa=
lse));
-        management_notify_generic(management, BSTR(&out));
+       =
 management_notify_generic(BSTR(&out));
         management->persist=2Espec=
ial_state_msg =3D BSTR(&out);
 
         ce->flags &=3D ~(CE_MAN_QUERY_REMO=
TE_MASK << CE_MAN_QUERY_REMOTE_SHIFT);
diff --git a/src/openvpn/manage=2Ec =
b/src/openvpn/manage=2Ec
index 2b0a661=2E=2E310d2e1 100644
--- a/src/openvp=
n/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -843,7 +843,7 @@
 }
 
 static =
void
-man_forget_passwords(struct management *man)
+man_forget_passwords(vo=
id)
 {
     ssl_purge_auth(false);
     (void)ssl_clean_auth_token();
@@ -1=
344,18 +1344,16 @@
  * Checks if the correct number of arguments to a manag=
ement command are present
  * and otherwise prints an error and returns fal=
se=2E
  *
- * @param man       The management interface struct
  * @param p=
         pointer to the parameter array
  * @param n         number of argu=
ments required
  * @param flags     if MN_AT_LEAST require at least n param=
eters and not exactly n
  * @return          Return whether p has n (or at =
least n) parameters
  */
 static bool
-man_need(struct management *man, con=
st char **p, const int n, unsigned int flags)
+man_need(const char **p, con=
st int n, unsigned int flags)
 {
-    int i;
     ASSERT(p[0]);
-    for (i=
 =3D 1; i <=3D n; ++i)
+    for (int i =3D 1; i <=3D n; ++i)
     {
       =
  if (!p[i])
         {
@@ -1522,7 +1520,7 @@
     }
     else if (streq(p[=
0], "signal"))
     {
-        if (man_need(man, p, 1, 0))
+        if (man=
_need(p, 1, 0))
         {
             man_signal(man, p[1]);
         }
@=
@ -1554,7 +1552,7 @@
     }
     else if (streq(p[0], "kill"))
     {
-    =
    if (man_need(man, p, 1, 0))
+        if (man_need(p, 1, 0))
         {
=
             man_kill(man, p[1]);
         }
@@ -1632,7 +1630,7 @@
     }
 =
    else if (streq(p[0], "log"))
     {
-        if (man_need(man, p, 1, MN=
_AT_LEAST))
+        if (man_need(p, 1, MN_AT_LEAST))
         {
          =
   if (p[1])
             {
@@ -1646,7 +1644,7 @@
     }
     else if (stre=
q(p[0], "echo"))
     {
-        if (man_need(man, p, 1, MN_AT_LEAST))
+   =
     if (man_need(p, 1, MN_AT_LEAST))
         {
             if (p[1])
   =
          {
@@ -1660,14 +1658,14 @@
     }
     else if (streq(p[0], "usern=
ame"))
     {
-        if (man_need(man, p, 2, 0))
+        if (man_need(p,=
 2, 0))
         {
             man_query_username(man, p[1], p[2]);
      =
   }
     }
     else if (streq(p[0], "password"))
     {
-        if (man_=
need(man, p, 1, MN_AT_LEAST))
+        if (man_need(p, 1, MN_AT_LEAST))
   =
      {
             if (p[2])
             {
@@ -1685,25 +1683,25 @@
     =
}
     else if (streq(p[0], "forget-passwords"))
     {
-        man_forget=
_passwords(man);
+        man_forget_passwords();
     }
     else if (stre=
q(p[0], "needok"))
     {
-        if (man_need(man, p, 2, 0))
+        if =
(man_need(p, 2, 0))
         {
             man_query_need_ok(man, p[1], p[=
2]);
         }
     }
     else if (streq(p[0], "needstr"))
     {
-      =
  if (man_need(man, p, 2, 0))
+        if (man_need(p, 2, 0))
         {
  =
           man_query_need_str(man, p[1], p[2]);
         }
     }
     else=
 if (streq(p[0], "cr-response"))
     {
-        if (man_need(man, p, 1, 0)=
)
+        if (man_need(p, 1, 0))
         {
             man_send_cc_messa=
ge(man, "CR_RESPONSE", p[1]);
         }
@@ -1718,42 +1716,42 @@
     }
   =
  else if (streq(p[0], "bytecount"))
     {
-        if (man_need(man, p, 1=
, 0))
+        if (man_need(p, 1, 0))
         {
             man_bytecount=
(man, atoi(p[1]));
         }
     }
     else if (streq(p[0], "client-kill=
"))
     {
-        if (man_need(man, p, 1, MN_AT_LEAST))
+        if (man_=
need(p, 1, MN_AT_LEAST))
         {
             man_client_kill(man, p[1],=
 p[2]);
         }
     }
     else if (streq(p[0], "client-deny"))
     {
=
-        if (man_need(man, p, 3, MN_AT_LEAST))
+        if (man_need(p, 3, =
MN_AT_LEAST))
         {
             man_client_deny(man, p[1], p[2], p[3]=
, p[4]);
         }
     }
     else if (streq(p[0], "client-auth-nt"))
   =
  {
-        if (man_need(man, p, 2, 0))
+        if (man_need(p, 2, 0))
  =
       {
             man_client_auth(man, p[1], p[2], false);
         }
 =
    }
     else if (streq(p[0], "client-auth"))
     {
-        if (man_nee=
d(man, p, 2, 0))
+        if (man_need(p, 2, 0))
         {
             ma=
n_client_auth(man, p[1], p[2], true);
         }
     }
     else if (streq=
(p[0], "client-pending-auth"))
     {
-        if (man_need(man, p, 4, 0))
=
+        if (man_need(p, 4, 0))
         {
             man_client_pending_=
auth(man, p[1], p[2], p[3], p[4]);
         }
@@ -1777,7 +1775,7 @@
     }
=
     else if (streq(p[0], "pkcs11-id-get"))
     {
-        if (man_need(ma=
n, p, 1, 0))
+        if (man_need(p, 1, 0))
         {
             man_pk=
cs11_id_get(man, atoi(p[1]));
         }
@@ -1789,35 +1787,35 @@
     }
   =
  else if (streq(p[0], "remote-entry-get"))
     {
-        if (man_need(ma=
n, p, 1, MN_AT_LEAST))
+        if (man_need(p, 1, MN_AT_LEAST))
         {=

             man_remote_entry_get(man, p[1], p[2]);
         }
     }
    =
 else if (streq(p[0], "proxy"))
     {
-        if (man_need(man, p, 1, MN_=
AT_LEAST))
+        if (man_need(p, 1, MN_AT_LEAST))
         {
           =
  man_proxy(man, p);
         }
     }
     else if (streq(p[0], "remote"))=

     {
-        if (man_need(man, p, 1, MN_AT_LEAST))
+        if (man_nee=
d(p, 1, MN_AT_LEAST))
         {
             man_remote(man, p);
         =
}
     }
     else if (streq(p[0], "push-update-broad"))
     {
-        if=
 (man_need(man, p, 1, 0))
+        if (man_need(p, 1, 0))
         {
      =
       man_push_update(man, p, UPT_BROADCAST);
         }
     }
     else =
if (streq(p[0], "push-update-cid"))
     {
-        if (man_need(man, p, 2,=
 0))
+        if (man_need(p, 2, 0))
         {
             man_push_updat=
e(man, p, UPT_BY_CID);
         }
@@ -1825,7 +1823,7 @@
 #if 1
     else if=
 (streq(p[0], "test"))
     {
-        if (man_need(man, p, 1, 0))
+       =
 if (man_need(p, 1, 0))
         {
             int i;
             const i=
nt n =3D atoi(p[1]);
@@ -3024,13 +3022,13 @@
 }
 
 void
-management_notify(=
struct management *man, const char *severity, const char *type, const char =
*text)
+management_notify(const char *severity, const char *type, const cha=
r *text)
 {
     msg(M_CLIENT, ">NOTIFY:%s,%s,%s", severity, type, text);
 =
}
 
 void
-management_notify_generic(struct management *man, const char *st=
r)
+management_notify_generic(const char *str)
 {
     msg(M_CLIENT, "%s", =
str);
 }
@@ -3128,7 +3126,7 @@
 }
 
 void
-management_learn_addr(struct man=
agement *management, struct man_def_auth_context *mdac,
+management_learn_a=
ddr(struct man_def_auth_context *mdac,
                       const struct =
mroute_addr *addr, const bool primary)
 {
     struct gc_arena gc =3D gc_ne=
w();
@@ -3220,7 +3218,7 @@
 }
 
 void
-management_auth_token(struct managem=
ent *man, const char *token)
+management_auth_token(const char *token)
 {
 =
    msg(M_CLIENT, ">PASSWORD:Auth-Token:%s", token);
 }
diff --git a/src/op=
envpn/manage=2Eh b/src/openvpn/manage=2Eh
index 27d3b60=2E=2E3ab937c 100644=

--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -384,10 +384,=
10 @@
 
 void management_up_down(struct management *man, const char *updown=
, const struct env_set *es);
 
-void management_notify(struct management *m=
an, const char *severity, const char *type,
+void management_notify(const c=
har *severity, const char *type,
                        const char *text);=

 
-void management_notify_generic(struct management *man, const char *str)=
;
+void management_notify_generic(const char *str);
 
 void management_noti=
fy_client_needing_auth(struct management *management,
                     =
                       const unsigned int auth_id,
@@ -400,7 +400,7 @@
 voi=
d management_notify_client_close(struct management *management,
           =
                          struct man_def_auth_context *mdac, const struct e=
nv_set *es);
 
-void management_learn_addr(struct management *management, s=
truct man_def_auth_context *mdac,
+void management_learn_addr(struct man_de=
f_auth_context *mdac,
                            const struct mroute_addr =
*addr, const bool primary);
 
 void management_notify_client_cr_response(un=
signed mda_key_id,
@@ -487,7 +487,7 @@
 /*
  * Echo an authentication token=
 to management interface
  */
-void management_auth_token(struct management=
 *man, const char *token);
+void management_auth_token(const char *token);
=
 
 /*
  * These functions drive the bytecount in/out counters=2E
diff --git=
 a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 46ff1ba=2E=2E3e72b92=
 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -1194,7 =
+1194,7 @@
 #ifdef ENABLE_MANAGEMENT
     if (management && owner)
     {
-=
        management_learn_addr(management, &mi->context=2Ec2=2Emda_context, =
&addr, primary);
+        management_learn_addr(&mi->context=2Ec2=2Emda_con=
text, &addr, primary);
     }
 #endif
     if (primary && multi_check_push_=
ifconfig_extra_route(mi, addr=2Ev4=2Eaddr))
@@ -1239,7 +1239,7 @@
 #ifdef E=
NABLE_MANAGEMENT
     if (management && owner)
     {
-        management_l=
earn_addr(management, &mi->context=2Ec2=2Emda_context, &addr, primary);
+  =
      management_learn_addr(&mi->context=2Ec2=2Emda_context, &addr, primary=
);
     }
 #endif
     if (primary && multi_check_push_ifconfig_ipv6_extra_=
route(mi, &addr=2Ev6=2Eaddr))
diff --git a/src/openvpn/options=2Ec b/src/op=
envpn/options=2Ec
index 7a649de=2E=2E25a3746 100644
--- a/src/openvpn/optio=
ns=2Ec
+++ b/src/openvpn/options=2Ec
@@ -7373,7 +7373,7 @@
 #ifdef ENABLE_M=
ANAGEMENT
         if (management)
         {
-            management_auth_=
token(management, p[1]);
+            management_auth_token(p[1]);
        =
 }
 #endif
     }
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
=
index fa7bf1e=2E=2Eda2bb9f 100644
--- a/src/openvpn/push=2Ec
+++ b/src/open=
vpn/push=2Ec
@@ -179,7 +179,7 @@
 #ifdef ENABLE_MANAGEMENT
         if (man=
agement)
         {
-            management_notify(management, "info", c->s=
ig->signal_text, m);
+            management_notify("info", c->sig->signal_=
text, m);
         }
 #endif
     }
@@ -215,7 +215,7 @@
 #ifdef ENABLE_MANA=
GEMENT
     if (management)
     {
-        management_notify(management, "=
info", "remote-exit", "EXIT");
+        management_notify("info", "remote-e=
xit", "EXIT");
     }
 #endif
 }
@@ -245,7 +245,7 @@
         struct buffer=
 out =3D alloc_buf_gc(256, &gc);
         if (buf_printf(&out, ">%s:%s", "I=
NFOMSG", m))
         {
-            management_notify_generic(management, =
BSTR(&out));
+            management_notify_generic(BSTR(&out));
         }=

         else
         {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1903?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I4351fc499188b7d0cdbcb4f0531e9f157e948c5e
Gerrit-Change-Number: 19=
03
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ra=
zvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--Ag5teOoEdEo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1903?usp=3Demail">View Change</a></p><p=
>The change is no longer submittable: checks~ChecksSubmitRule is unsatisfie=
d now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">management: Remove management argument to functio=
ns that do not need it<br><br>Found when reviewing the cppcheck constParame=
terPointer<br>warnings=2E<br><br>Change-Id: I4351fc499188b7d0cdbcb4f0531e9f=
157e948c5e<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&=
gt;<br>---<br>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M src/o=
penvpn/manage=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openvpn/options=2Ec<b=
r>M src/openvpn/push=2Ec<br>6 files changed, 42 insertions(+), 44 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/03/1903/3</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/=
src/openvpn/init=2Ec</span><br><span>index 1109a13=2E=2E453ee7e 100644</spa=
n><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/in=
it=2Ec</span><br><span>@@ -260,7 +260,7 @@</span><br><span>             str=
uct buffer out =3D alloc_buf_gc(256, &amp;gc);</span><br><span>            =
 buf_printf(&amp;out, &quot;&gt;PROXY:%u,%s,%s&quot;, (l ? l-&gt;current : =
0) + 1,</span><br><span>                        (proto_is_udp(ce-&gt;proto)=
 ? &quot;UDP&quot; : &quot;TCP&quot;), np(ce-&gt;remote));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            management_notify_generic(=
management, BSTR(&amp;out));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            management_notify_generic(BSTR(&amp;out));</span><br><=
span>             management-&gt;persist=2Especial_state_msg =3D BSTR(&amp;=
out);</span><br><span>         }</span><br><span>         ce-&gt;flags |=3D=
 CE_MAN_QUERY_PROXY;</span><br><span>@@ -425,7 +425,7 @@</span><br><span> <=
/span><br><span>         buf_printf(&amp;out, &quot;&gt;REMOTE:%s,%s,%s&quo=
t;, np(ce-&gt;remote), ce-&gt;remote_port,</span><br><span>                =
    proto2ascii(ce-&gt;proto, ce-&gt;af, false));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        management_notify_generic(management, B=
STR(&amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    management_notify_generic(BSTR(&amp;out));</span><br><span>         man=
agement-&gt;persist=2Especial_state_msg =3D BSTR(&amp;out);</span><br><span=
> </span><br><span>         ce-&gt;flags &amp;=3D ~(CE_MAN_QUERY_REMOTE_MAS=
K &lt;&lt; CE_MAN_QUERY_REMOTE_SHIFT);</span><br><span>diff --git a/src/ope=
nvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 2b0a661=2E=
=2E310d2e1 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><s=
pan>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -843,7 +843,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> static void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-man_forget_passwords(struct managemen=
t *man)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_forget_p=
asswords(void)</span><br><span> {</span><br><span>     ssl_purge_auth(false=
);</span><br><span>     (void)ssl_clean_auth_token();</span><br><span>@@ -1=
344,18 +1344,16 @@</span><br><span>  * Checks if the correct number of argu=
ments to a management command are present</span><br><span>  * and otherwise=
 prints an error and returns false=2E</span><br><span>  *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * @param man       The management inte=
rface struct</span><br><span>  * @param p         pointer to the parameter =
array</span><br><span>  * @param n         number of arguments required</sp=
an><br><span>  * @param flags     if MN_AT_LEAST require at least n paramet=
ers and not exactly n</span><br><span>  * @return          Return whether p=
 has n (or at least n) parameters</span><br><span>  */</span><br><span> sta=
tic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_need(stru=
ct management *man, const char **p, const int n, unsigned int flags)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+man_need(const char **p, c=
onst int n, unsigned int flags)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    int i;</span><br><span>     ASSERT(p[0]);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 1; i &l=
t;=3D n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fo=
r (int i =3D 1; i &lt;=3D n; ++i)</span><br><span>     {</span><br><span>  =
       if (!p[i])</span><br><span>         {</span><br><span>@@ -1522,7 +15=
20,7 @@</span><br><span>     }</span><br><span>     else if (streq(p[0], &q=
uot;signal&quot;))</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (man_need(man, p, 1, 0))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (man_need(p, 1, 0))</span><b=
r><span>         {</span><br><span>             man_signal(man, p[1]);</spa=
n><br><span>         }</span><br><span>@@ -1554,7 +1552,7 @@</span><br><spa=
n>     }</span><br><span>     else if (streq(p[0], &quot;kill&quot;))</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (man_need(man, p, 1, 0))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (man_need(p, 1, 0))</span><br><span>         {</span=
><br><span>             man_kill(man, p[1]);</span><br><span>         }</sp=
an><br><span>@@ -1632,7 +1630,7 @@</span><br><span>     }</span><br><span> =
    else if (streq(p[0], &quot;log&quot;))</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, p, 1,=
 MN_AT_LEAST))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (man_need(p, 1, MN_AT_LEAST))</span><br><span>         {</span><br><s=
pan>             if (p[1])</span><br><span>             {</span><br><span>@=
@ -1646,7 +1644,7 @@</span><br><span>     }</span><br><span>     else if (s=
treq(p[0], &quot;echo&quot;))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, p, 1, MN_AT_LEAST=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man_n=
eed(p, 1, MN_AT_LEAST))</span><br><span>         {</span><br><span>        =
     if (p[1])</span><br><span>             {</span><br><span>@@ -1660,14 +=
1658,14 @@</span><br><span>     }</span><br><span>     else if (streq(p[0],=
 &quot;username&quot;))</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (man_need(man, p, 2, 0))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (man_need(p, 2, 0))</sp=
an><br><span>         {</span><br><span>             man_query_username(man=
, p[1], p[2]);</span><br><span>         }</span><br><span>     }</span><br>=
<span>     else if (streq(p[0], &quot;password&quot;))</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_nee=
d(man, p, 1, MN_AT_LEAST))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (man_need(p, 1, MN_AT_LEAST))</span><br><span>         {<=
/span><br><span>             if (p[2])</span><br><span>             {</span=
><br><span>@@ -1685,25 +1683,25 @@</span><br><span>     }</span><br><span> =
    else if (streq(p[0], &quot;forget-passwords&quot;))</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        man_forget=
_passwords(man);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     man_forget_passwords();</span><br><span>     }</span><br><span>     el=
se if (streq(p[0], &quot;needok&quot;))</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, p, 2, 0)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man_ne=
ed(p, 2, 0))</span><br><span>         {</span><br><span>             man_qu=
ery_need_ok(man, p[1], p[2]);</span><br><span>         }</span><br><span>  =
   }</span><br><span>     else if (streq(p[0], &quot;needstr&quot;))</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (man_need(man, p, 2, 0))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (man_need(p, 2, 0))</span><br><span>         {</span>=
<br><span>             man_query_need_str(man, p[1], p[2]);</span><br><span=
>         }</span><br><span>     }</span><br><span>     else if (streq(p[0]=
, &quot;cr-response&quot;))</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (man_need(man, p, 1, 0))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (man_need(p, 1, 0))=
</span><br><span>         {</span><br><span>             man_send_cc_messag=
e(man, &quot;CR_RESPONSE&quot;, p[1]);</span><br><span>         }</span><br=
><span>@@ -1718,42 +1716,42 @@</span><br><span>     }</span><br><span>     =
else if (streq(p[0], &quot;bytecount&quot;))</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, p, =
1, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (m=
an_need(p, 1, 0))</span><br><span>         {</span><br><span>             m=
an_bytecount(man, atoi(p[1]));</span><br><span>         }</span><br><span> =
    }</span><br><span>     else if (streq(p[0], &quot;client-kill&quot;))</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (man_need(man, p, 1, MN_AT_LEAST))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (man_need(p, 1, MN_AT_LEAST))</span><b=
r><span>         {</span><br><span>             man_client_kill(man, p[1], =
p[2]);</span><br><span>         }</span><br><span>     }</span><br><span>  =
   else if (streq(p[0], &quot;client-deny&quot;))</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man=
, p, 3, MN_AT_LEAST))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (man_need(p, 3, MN_AT_LEAST))</span><br><span>         {</span=
><br><span>             man_client_deny(man, p[1], p[2], p[3], p[4]);</span=
><br><span>         }</span><br><span>     }</span><br><span>     else if (=
streq(p[0], &quot;client-auth-nt&quot;))</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, p, 2, 0=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man_n=
eed(p, 2, 0))</span><br><span>         {</span><br><span>             man_c=
lient_auth(man, p[1], p[2], false);</span><br><span>         }</span><br><s=
pan>     }</span><br><span>     else if (streq(p[0], &quot;client-auth&quot=
;))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (man_need(man, p, 2, 0))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (man_need(p, 2, 0))</span><br><span>       =
  {</span><br><span>             man_client_auth(man, p[1], p[2], true);</s=
pan><br><span>         }</span><br><span>     }</span><br><span>     else i=
f (streq(p[0], &quot;client-pending-auth&quot;))</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man,=
 p, 4, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (man_need(p, 4, 0))</span><br><span>         {</span><br><span>          =
   man_client_pending_auth(man, p[1], p[2], p[3], p[4]);</span><br><span>  =
       }</span><br><span>@@ -1777,7 +1775,7 @@</span><br><span>     }</span=
><br><span>     else if (streq(p[0], &quot;pkcs11-id-get&quot;))</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (man_need(man, p, 1, 0))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (man_need(p, 1, 0))</span><br><span>         {</span><br>=
<span>             man_pkcs11_id_get(man, atoi(p[1]));</span><br><span>    =
     }</span><br><span>@@ -1789,35 +1787,35 @@</span><br><span>     }</span=
><br><span>     else if (streq(p[0], &quot;remote-entry-get&quot;))</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (man_need(man, p, 1, MN_AT_LEAST))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (man_need(p, 1, MN_AT_LEAST))</span><br><spa=
n>         {</span><br><span>             man_remote_entry_get(man, p[1], p=
[2]);</span><br><span>         }</span><br><span>     }</span><br><span>   =
  else if (streq(p[0], &quot;proxy&quot;))</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, p, 1,=
 MN_AT_LEAST))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (man_need(p, 1, MN_AT_LEAST))</span><br><span>         {</span><br><s=
pan>             man_proxy(man, p);</span><br><span>         }</span><br><s=
pan>     }</span><br><span>     else if (streq(p[0], &quot;remote&quot;))</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (man_need(man, p, 1, MN_AT_LEAST))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (man_need(p, 1, MN_AT_LEAST))</span><b=
r><span>         {</span><br><span>             man_remote(man, p);</span><=
br><span>         }</span><br><span>     }</span><br><span>     else if (st=
req(p[0], &quot;push-update-broad&quot;))</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, p, 1, =
0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man_=
need(p, 1, 0))</span><br><span>         {</span><br><span>             man_=
push_update(man, p, UPT_BROADCAST);</span><br><span>         }</span><br><s=
pan>     }</span><br><span>     else if (streq(p[0], &quot;push-update-cid&=
quot;))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (man_need(man, p, 2, 0))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (man_need(p, 2, 0))</span><br><span>   =
      {</span><br><span>             man_push_update(man, p, UPT_BY_CID);</=
span><br><span>         }</span><br><span>@@ -1825,7 +1823,7 @@</span><br><=
span> #if 1</span><br><span>     else if (streq(p[0], &quot;test&quot;))</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (man_need(man, p, 1, 0))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (man_need(p, 1, 0))</span><br><span>         {</s=
pan><br><span>             int i;</span><br><span>             const int n =
=3D atoi(p[1]);</span><br><span>@@ -3024,13 +3022,13 @@</span><br><span> }<=
/span><br><span> </span><br><span> void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-management_notify(struct management *man, const char *sev=
erity, const char *type, const char *text)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+management_notify(const char *severity, const char *=
type, const char *text)</span><br><span> {</span><br><span>     msg(M_CLIEN=
T, &quot;&gt;NOTIFY:%s,%s,%s&quot;, severity, type, text);</span><br><span>=
 }</span><br><span> </span><br><span> void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-management_notify_generic(struct management *man, cons=
t char *str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+managem=
ent_notify_generic(const char *str)</span><br><span> {</span><br><span>    =
 msg(M_CLIENT, &quot;%s&quot;, str);</span><br><span> }</span><br><span>@@ =
-3128,7 +3126,7 @@</span><br><span> }</span><br><span> </span><br><span> vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_learn_ad=
dr(struct management *management, struct man_def_auth_context *mdac,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+management_learn_addr(stru=
ct man_def_auth_context *mdac,</span><br><span>                       const=
 struct mroute_addr *addr, const bool primary)</span><br><span> {</span><br=
><span>     struct gc_arena gc =3D gc_new();</span><br><span>@@ -3220,7 +32=
18,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-management_auth_token(struct m=
anagement *man, const char *token)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+management_auth_token(const char *token)</span><br><span> {<=
/span><br><span>     msg(M_CLIENT, &quot;&gt;PASSWORD:Auth-Token:%s&quot;, =
token);</span><br><span> }</span><br><span>diff --git a/src/openvpn/manage=
=2Eh b/src/openvpn/manage=2Eh</span><br><span>index 27d3b60=2E=2E3ab937c 10=
0644</span><br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src=
/openvpn/manage=2Eh</span><br><span>@@ -384,10 +384,10 @@</span><br><span> =
</span><br><span> void management_up_down(struct management *man, const cha=
r *updown, const struct env_set *es);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-void management_notify(struct management =
*man, const char *severity, const char *type,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void management_notify(const char *severity, cons=
t char *type,</span><br><span>                        const char *text);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void m=
anagement_notify_generic(struct management *man, const char *str);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void management_notify_gener=
ic(const char *str);</span><br><span> </span><br><span> void management_not=
ify_client_needing_auth(struct management *management,</span><br><span>    =
                                        const unsigned int auth_id,</span><=
br><span>@@ -400,7 +400,7 @@</span><br><span> void management_notify_client=
_close(struct management *management,</span><br><span>                     =
                struct man_def_auth_context *mdac, const struct env_set *es=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid management_learn_addr(struct management *management, struct man_def_aut=
h_context *mdac,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d management_learn_addr(struct man_def_auth_context *mdac,</span><br><span>=
                            const struct mroute_addr *addr, const bool prim=
ary);</span><br><span> </span><br><span> void management_notify_client_cr_r=
esponse(unsigned mda_key_id,</span><br><span>@@ -487,7 +487,7 @@</span><br>=
<span> /*</span><br><span>  * Echo an authentication token to management in=
terface</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void management_auth_token(struct management *man, const char *token=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void management_a=
uth_token(const char *token);</span><br><span> </span><br><span> /*</span><=
br><span>  * These functions drive the bytecount in/out counters=2E</span><=
br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><=
br><span>index 46ff1ba=2E=2E3e72b92 100644</span><br><span>--- a/src/openvp=
n/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ =
-1194,7 +1194,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><spa=
n>     if (management &amp;&amp; owner)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        management_learn_addr(mana=
gement, &amp;mi-&gt;context=2Ec2=2Emda_context, &amp;addr, primary);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        management_learn_a=
ddr(&amp;mi-&gt;context=2Ec2=2Emda_context, &amp;addr, primary);</span><br>=
<span>     }</span><br><span> #endif</span><br><span>     if (primary &amp;=
&amp; multi_check_push_ifconfig_extra_route(mi, addr=2Ev4=2Eaddr))</span><b=
r><span>@@ -1239,7 +1239,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</sp=
an><br><span>     if (management &amp;&amp; owner)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        management_lear=
n_addr(management, &amp;mi-&gt;context=2Ec2=2Emda_context, &amp;addr, prima=
ry);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        managem=
ent_learn_addr(&amp;mi-&gt;context=2Ec2=2Emda_context, &amp;addr, primary);=
</span><br><span>     }</span><br><span> #endif</span><br><span>     if (pr=
imary &amp;&amp; multi_check_push_ifconfig_ipv6_extra_route(mi, &amp;addr=
=2Ev6=2Eaddr))</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/o=
penvpn/options=2Ec</span><br><span>index 7a649de=2E=2E25a3746 100644</span>=
<br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/o=
ptions=2Ec</span><br><span>@@ -7373,7 +7373,7 @@</span><br><span> #ifdef EN=
ABLE_MANAGEMENT</span><br><span>         if (management)</span><br><span>  =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            m=
anagement_auth_token(management, p[1]);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            management_auth_token(p[1]);</span><br><spa=
n>         }</span><br><span> #endif</span><br><span>     }</span><br><span=
>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>i=
ndex fa7bf1e=2E=2Eda2bb9f 100644</span><br><span>--- a/src/openvpn/push=2Ec=
</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -179,7 +179,=
7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>         if =
(management)</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            management_notify(management, &quot;info&quot=
;, c-&gt;sig-&gt;signal_text, m);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            management_notify(&quot;info&quot;, c-&gt;sig-&gt=
;signal_text, m);</span><br><span>         }</span><br><span> #endif</span>=
<br><span>     }</span><br><span>@@ -215,7 +215,7 @@</span><br><span> #ifde=
f ENABLE_MANAGEMENT</span><br><span>     if (management)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        managemen=
t_notify(management, &quot;info&quot;, &quot;remote-exit&quot;, &quot;EXIT&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mana=
gement_notify(&quot;info&quot;, &quot;remote-exit&quot;, &quot;EXIT&quot;);=
</span><br><span>     }</span><br><span> #endif</span><br><span> }</span><b=
r><span>@@ -245,7 +245,7 @@</span><br><span>         struct buffer out =3D =
alloc_buf_gc(256, &amp;gc);</span><br><span>         if (buf_printf(&amp;ou=
t, &quot;&gt;%s:%s&quot;, &quot;INFOMSG&quot;, m))</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            managem=
ent_notify_generic(management, BSTR(&amp;out));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            management_notify_generic(BSTR(&amp=
;out));</span><br><span>         }</span><br><span>         else</span><br>=
<span>         {</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1903?usp=3Demail">change 1903=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1903?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
4351fc499188b7d0cdbcb4f0531e9f157e948c5e </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1903 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>

</body></html>
--Ag5teOoEdEo=--


--===============2096735346634496469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2096735346634496469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2096735346634496469==--

