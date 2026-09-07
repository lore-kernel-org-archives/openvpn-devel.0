Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49EAC79F9E
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 21:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Nd1lmPBeW0DjFZ4KlkS4OWEYbCqglqquB9iK6ve0dcU=; b=GxzJ9RJgF4MfVG
	ZVAHkh4NNqu83D3t0QEuUO8fhH3fVzHTRp4XjemimDQSjac+onp9qnwhOZ1JBVLRll8croFGr4AjI
	VtZf2+uV1mS+sO4HX0oxzSeVHeBGa40k+8EJFAQi1x2HUXQ6aH/BI0Bhzhy0l7LP37ZcCHD5sdI3s
	ixs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3gta-0002fe-7z;
	Mon, 07 Sep 2026 21:28:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3gtY-0002fM-6G
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 21:28:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nL1zyunqrpQJWSGT1yfgI6HbSa+VD92zvsXWqk3b+iY=; b=BdcIjphW/3H2ywZL/8sVhPRjIR
 Z9fbZTt05WdG4sERiAUDngwVxGdyfBGnz5eUx4A3Vu6CB5Hqu5mv0LIwZXqRa0NEZ6xe2IK9YwJF3
 V2zuKpNeh/pym/o4YfAlnqW9o6LxwaoEWz3k3vvS5lUocTb0GedTUe5UGuZ1GOzPVON4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nL1zyunqrpQJWSGT1yfgI6HbSa+VD92zvsXWqk3b+iY=; b=A
 k+3Z9Aw7GC3FDeQo+FRGkVDaeKQdIUI/bM9vpUmy3cqat74yZM/RzODcGtNxzqnhdrgwQcAauwI/O
 yKsSnkcJZG77H2/vmTs6llVc3EgyJOruziH21iENIzQqrikc60jgiQF1fQGDtxZvP1kTxBcdlwu+H
 HG4H8gEPrf9UtfAk=;
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3gtX-0005Wz-3I for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 21:28:52 +0000
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c1600d040e4so635571266b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 14:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788816524; x=1789421324; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nL1zyunqrpQJWSGT1yfgI6HbSa+VD92zvsXWqk3b+iY=;
 b=eqIjjmL6Ms6UvQMTwijQ6HiW7J63iJmaS2VZzxIF5R+LyTP1VLBGC6mm5UhfVufXQM
 MIXwAfV3p+xbY0T1b/TKv6vFVQGbp4o9yyxxf3UZmzF0QaOnGod4IzO/0gET66w2JjTA
 6u1erPIWW8rBp/av9Yau7UQrcqox+aJsvPvosICL4G+SKT6yD/LfFFXn3RoqMDOVQpCa
 BqKek7fMHVozsT6JnwAWSzaUzcmlY36zU92bQJTHitEXiQwhY7PwzTopoIhLFbu0Gjv7
 KdrQ/db76Pj8i/gk/UlMVuYN9hHfib9dI0an+YGPeP+gD255E4STYPlreniaIB96XdFO
 hz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788816524; x=1789421324;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nL1zyunqrpQJWSGT1yfgI6HbSa+VD92zvsXWqk3b+iY=;
 b=J36Rd/ZfOhzu2Ec0fHzkevBJ5G1phb6qjNh+/k8MDY58tqY59p69sHJou+QI24jOfR
 nRFzHOjS/q07Z1qx3j+y2VD/cD8d2v3gl6u1qh7ohO4BGnxC1VuPh5L9VBnMaJlPYWXU
 ukQA3GxtfjZQ/vHJcgjSVJNmhoHm8OYj4gjNHCQZE6LzzWR+OKsJ3gjX7CeDJuWW+BFS
 2e5XiR23w7m1VKkft0CHV6lk9jLcw2lfjKAM15BjNeuzpK2abmuVX3dDX1iCzxYlPaMB
 PS3tA5Xtwrx7rESDqv7wp3INY4f2ijvaJVyb/hKUJrWe9cU8hbdlyPTyFno8IwRmgVKi
 XrjQ==
X-Gm-Message-State: AFuF++mlYu+Brv781p4dtY8WemmSxEmN/rbrjUXLemM8FLUGuRMVGjad
 YEcJWVONFr7+JGBQwO19IDEqUQ3LspJZN5XHq0kXxIPiNfw3ji7d4veqJ/BZgz8QvDUR7I9/tkh
 G88OzN7WhZHxp7fKL39AmnvEOBrAmFsGIpDYz14Yos07bf/qDQGPGqtsLHB03gGujYoxZCagWtD
 KzeLAUxQ==
X-Gm-Gg: AYBFou0WPSWBOya4kcsleg0S26EUa1YubwWki10UnvWyPkomt82jiMZXUQhu+M7Y3We
 nejHDkqMl8QSOq/XbWg9MLyh9HYjxVylCC/izAKSsysVzq90n8HtxCdfZ7SZP8goKovoRyPF/+Z
 PTdmHMrmrbQWP8euAs3po+MW0xiw1SUeD2yTu81EOpSWY129kcw9u8gVBTYE4jBlMc49o4iB2kh
 QaFynV7TmfwkTdwG8AAlXcsncRavr6H5mj264kq8+Dsey+HG00x53ti+bGIHGIKQZxx54wo4c9/
 rQt+TGcLB0BCH5MKwO2PFS0CHSqlCFhHLJp8eec096aYYXgzxcaddo2FznnFBqSMbxtKFRF1aYN
 Mc5y030yA4RdwRUV8CtJmp26REZb3utJC968hZlWGoUY2fMb5OYOWFWEgSmxG0gFySWI53CGPCt
 RytrEhewOs2ENaqJn/9pyv/vhX381EsmdEu34FgC6bh9nLUXOJ86UWXI0diCq0ZNSCjCIxRFkv3
 n44b0CQgyRJ8d0tFZpQA6DSglUsVSYANTRKtWCwoCCAz95zMJUiIKvBEIhOjvHSQKL5P0mZLXkx
 dmC7lH5braNXqTM2x0gGim64FongbOOmXav/9+RHSQIHmGi/WqY=
X-Received: by 2002:a05:600c:8b12:b0:49c:f13e:e4d with SMTP id
 5b1f17b1804b1-49d17572958mr32340485e9.10.1788815043680; 
 Mon, 07 Sep 2026 14:04:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58da3acsm888589875e9.0.2026.09.07.14.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:04:03 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 21:04:02 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4351fc499188b7d0cdbcb4f0531e9f157e948c5e
X-Gerrit-Change-Number: 1903
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1903?usp=email>
X-Gerrit-Commit: 36f20d2bc0d9a6c5a5e3e7c3d302dcd653522451
References: <gerrit.1788815035000.I4351fc499188b7d0cdbcb4f0531e9f157e948c5e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODE1MDM1MDAwLkk0MzUxZmM0OTkxODhiN2QwY2RiY2I0ZjA1MzFlOWYxNTdlOTQ4YzVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <884e2fc154fbb51923a7ccdd4b7f2b63edf1d42b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3gtX-0005Wz-3I
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0038571317824216802=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0038571317824216802==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="70IJtWlQ4r8="; charset=UTF-8

--70IJtWlQ4r8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1903?usp=3Demail

to review the following change=2E


Chang=
e subject: management: Remove management argument to functions that do not =
need it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mana=
gement: Remove management argument to functions that do not need it

Found =
when reviewing the cppcheck constParameterPointer
warnings=2E

Change-Id: I=
4351fc499188b7d0cdbcb4f0531e9f157e948c5e
Signed-off-by: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
---
M src/openvpn/init=2Ec
M src/openvpn/manage=2E=
c
M src/openvpn/manage=2Eh
M src/openvpn/multi=2Ec
M src/openvpn/options=2E=
c
M src/openvpn/push=2Ec
6 files changed, 42 insertions(+), 44 deletions(-)=




  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/03/1=
903/1

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 1109a=
13=2E=2E453ee7e 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2E=
c
@@ -260,7 +260,7 @@
             struct buffer out =3D alloc_buf_gc(256, =
&gc);
             buf_printf(&out, ">PROXY:%u,%s,%s", (l ? l->current : 0)=
 + 1,
                        (proto_is_udp(ce->proto) ? "UDP" : "TCP"), np=
(ce->remote));
-            management_notify_generic(management, BSTR(&out=
));
+            management_notify_generic(BSTR(&out));
             manage=
ment->persist=2Especial_state_msg =3D BSTR(&out);
         }
         ce->f=
lags |=3D CE_MAN_QUERY_PROXY;
@@ -425,7 +425,7 @@
 
         buf_printf(&ou=
t, ">REMOTE:%s,%s,%s", np(ce->remote), ce->remote_port,
                   =
 proto2ascii(ce->proto, ce->af, false));
-        management_notify_generic=
(management, BSTR(&out));
+        management_notify_generic(BSTR(&out));
 =
        management->persist=2Especial_state_msg =3D BSTR(&out);
 
         =
ce->flags &=3D ~(CE_MAN_QUERY_REMOTE_MASK << CE_MAN_QUERY_REMOTE_SHIFT);
di=
ff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 2b0a661=2E=
=2E310d2e1 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec=

@@ -843,7 +843,7 @@
 }
 
 static void
-man_forget_passwords(struct managem=
ent *man)
+man_forget_passwords(void)
 {
     ssl_purge_auth(false);
     (=
void)ssl_clean_auth_token();
@@ -1344,18 +1344,16 @@
  * Checks if the corr=
ect number of arguments to a management command are present
  * and otherwi=
se prints an error and returns false=2E
  *
- * @param man       The manage=
ment interface struct
  * @param p         pointer to the parameter array
 =
 * @param n         number of arguments required
  * @param flags     if MN=
_AT_LEAST require at least n parameters and not exactly n
  * @return      =
    Return whether p has n (or at least n) parameters
  */
 static bool
-ma=
n_need(struct management *man, const char **p, const int n, unsigned int fl=
ags)
+man_need(const char **p, const int n, unsigned int flags)
 {
-    int=
 i;
     ASSERT(p[0]);
-    for (i =3D 1; i <=3D n; ++i)
+    for (int i =
=3D 1; i <=3D n; ++i)
     {
         if (!p[i])
         {
@@ -1522,7 +152=
0,7 @@
     }
     else if (streq(p[0], "signal"))
     {
-        if (man_=
need(man, p, 1, 0))
+        if (man_need(p, 1, 0))
         {
            =
 man_signal(man, p[1]);
         }
@@ -1554,7 +1552,7 @@
     }
     else i=
f (streq(p[0], "kill"))
     {
-        if (man_need(man, p, 1, 0))
+      =
  if (man_need(p, 1, 0))
         {
             man_kill(man, p[1]);
     =
    }
@@ -1632,7 +1630,7 @@
     }
     else if (streq(p[0], "log"))
     {=

-        if (man_need(man, p, 1, MN_AT_LEAST))
+        if (man_need(p, 1,=
 MN_AT_LEAST))
         {
             if (p[1])
             {
@@ -1646,7 =
+1644,7 @@
     }
     else if (streq(p[0], "echo"))
     {
-        if (ma=
n_need(man, p, 1, MN_AT_LEAST))
+        if (man_need(p, 1, MN_AT_LEAST))
 =
        {
             if (p[1])
             {
@@ -1660,14 +1658,14 @@
   =
  }
     else if (streq(p[0], "username"))
     {
-        if (man_need(man=
, p, 2, 0))
+        if (man_need(p, 2, 0))
         {
             man_que=
ry_username(man, p[1], p[2]);
         }
     }
     else if (streq(p[0], "=
password"))
     {
-        if (man_need(man, p, 1, MN_AT_LEAST))
+        =
if (man_need(p, 1, MN_AT_LEAST))
         {
             if (p[2])
        =
     {
@@ -1685,25 +1683,25 @@
     }
     else if (streq(p[0], "forget-pas=
swords"))
     {
-        man_forget_passwords(man);
+        man_forget_pa=
sswords();
     }
     else if (streq(p[0], "needok"))
     {
-        if (=
man_need(man, p, 2, 0))
+        if (man_need(p, 2, 0))
         {
        =
     man_query_need_ok(man, p[1], p[2]);
         }
     }
     else if (st=
req(p[0], "needstr"))
     {
-        if (man_need(man, p, 2, 0))
+        =
if (man_need(p, 2, 0))
         {
             man_query_need_str(man, p[1]=
, p[2]);
         }
     }
     else if (streq(p[0], "cr-response"))
     {=

-        if (man_need(man, p, 1, 0))
+        if (man_need(p, 1, 0))
     =
    {
             man_send_cc_message(man, "CR_RESPONSE", p[1]);
         =
}
@@ -1718,42 +1716,42 @@
     }
     else if (streq(p[0], "bytecount"))
  =
   {
-        if (man_need(man, p, 1, 0))
+        if (man_need(p, 1, 0))
 =
        {
             man_bytecount(man, atoi(p[1]));
         }
     }
  =
   else if (streq(p[0], "client-kill"))
     {
-        if (man_need(man, p=
, 1, MN_AT_LEAST))
+        if (man_need(p, 1, MN_AT_LEAST))
         {
   =
          man_client_kill(man, p[1], p[2]);
         }
     }
     else if =
(streq(p[0], "client-deny"))
     {
-        if (man_need(man, p, 3, MN_AT_=
LEAST))
+        if (man_need(p, 3, MN_AT_LEAST))
         {
             m=
an_client_deny(man, p[1], p[2], p[3], p[4]);
         }
     }
     else if=
 (streq(p[0], "client-auth-nt"))
     {
-        if (man_need(man, p, 2, 0)=
)
+        if (man_need(p, 2, 0))
         {
             man_client_auth(m=
an, p[1], p[2], false);
         }
     }
     else if (streq(p[0], "client=
-auth"))
     {
-        if (man_need(man, p, 2, 0))
+        if (man_need(=
p, 2, 0))
         {
             man_client_auth(man, p[1], p[2], true);
 =
        }
     }
     else if (streq(p[0], "client-pending-auth"))
     {
-=
        if (man_need(man, p, 4, 0))
+        if (man_need(p, 4, 0))
       =
  {
             man_client_pending_auth(man, p[1], p[2], p[3], p[4]);
    =
     }
@@ -1777,7 +1775,7 @@
     }
     else if (streq(p[0], "pkcs11-id-ge=
t"))
     {
-        if (man_need(man, p, 1, 0))
+        if (man_need(p, 1=
, 0))
         {
             man_pkcs11_id_get(man, atoi(p[1]));
         =
}
@@ -1789,35 +1787,35 @@
     }
     else if (streq(p[0], "remote-entry-ge=
t"))
     {
-        if (man_need(man, p, 1, MN_AT_LEAST))
+        if (man=
_need(p, 1, MN_AT_LEAST))
         {
             man_remote_entry_get(man,=
 p[1], p[2]);
         }
     }
     else if (streq(p[0], "proxy"))
     {
=
-        if (man_need(man, p, 1, MN_AT_LEAST))
+        if (man_need(p, 1, =
MN_AT_LEAST))
         {
             man_proxy(man, p);
         }
     }
=
     else if (streq(p[0], "remote"))
     {
-        if (man_need(man, p, 1=
, MN_AT_LEAST))
+        if (man_need(p, 1, MN_AT_LEAST))
         {
      =
       man_remote(man, p);
         }
     }
     else if (streq(p[0], "pus=
h-update-broad"))
     {
-        if (man_need(man, p, 1, 0))
+        if (=
man_need(p, 1, 0))
         {
             man_push_update(man, p, UPT_BROA=
DCAST);
         }
     }
     else if (streq(p[0], "push-update-cid"))
   =
  {
-        if (man_need(man, p, 2, 0))
+        if (man_need(p, 2, 0))
  =
       {
             man_push_update(man, p, UPT_BY_CID);
         }
@@ -1=
825,7 +1823,7 @@
 #if 1
     else if (streq(p[0], "test"))
     {
-        =
if (man_need(man, p, 1, 0))
+        if (man_need(p, 1, 0))
         {
    =
         int i;
             const int n =3D atoi(p[1]);
@@ -3024,13 +3022,=
13 @@
 }
 
 void
-management_notify(struct management *man, const char *sev=
erity, const char *type, const char *text)
+management_notify(const char *s=
everity, const char *type, const char *text)
 {
     msg(M_CLIENT, ">NOTIFY=
:%s,%s,%s", severity, type, text);
 }
 
 void
-management_notify_generic(st=
ruct management *man, const char *str)
+management_notify_generic(const cha=
r *str)
 {
     msg(M_CLIENT, "%s", str);
 }
@@ -3128,7 +3126,7 @@
 }
 
 vo=
id
-management_learn_addr(struct management *management, struct man_def_aut=
h_context *mdac,
+management_learn_addr(struct man_def_auth_context *mdac,
=
                       const struct mroute_addr *addr, const bool primary)
=
 {
     struct gc_arena gc =3D gc_new();
@@ -3220,7 +3218,7 @@
 }
 
 void
-=
management_auth_token(struct management *man, const char *token)
+managemen=
t_auth_token(const char *token)
 {
     msg(M_CLIENT, ">PASSWORD:Auth-Token=
:%s", token);
 }
diff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=
=2Eh
index 27d3b60=2E=2E3ab937c 100644
--- a/src/openvpn/manage=2Eh
+++ b/s=
rc/openvpn/manage=2Eh
@@ -384,10 +384,10 @@
 
 void management_up_down(stru=
ct management *man, const char *updown, const struct env_set *es);
 
-void =
management_notify(struct management *man, const char *severity, const char =
*type,
+void management_notify(const char *severity, const char *type,
    =
                    const char *text);
 
-void management_notify_generic(st=
ruct management *man, const char *str);
+void management_notify_generic(con=
st char *str);
 
 void management_notify_client_needing_auth(struct managem=
ent *management,
                                            const unsigned=
 int auth_id,
@@ -400,7 +400,7 @@
 void management_notify_client_close(stru=
ct management *management,
                                     struct man_=
def_auth_context *mdac, const struct env_set *es);
 
-void management_learn=
_addr(struct management *management, struct man_def_auth_context *mdac,
+vo=
id management_learn_addr(struct man_def_auth_context *mdac,
               =
             const struct mroute_addr *addr, const bool primary);
 
 void m=
anagement_notify_client_cr_response(unsigned mda_key_id,
@@ -487,7 +487,7 @=
@
 /*
  * Echo an authentication token to management interface
  */
-void m=
anagement_auth_token(struct management *man, const char *token);
+void mana=
gement_auth_token(const char *token);
 
 /*
  * These functions drive the b=
ytecount in/out counters=2E
diff --git a/src/openvpn/multi=2Ec b/src/openvp=
n/multi=2Ec
index 46ff1ba=2E=2E3e72b92 100644
--- a/src/openvpn/multi=2Ec
+=
++ b/src/openvpn/multi=2Ec
@@ -1194,7 +1194,7 @@
 #ifdef ENABLE_MANAGEMENT
=
     if (management && owner)
     {
-        management_learn_addr(managem=
ent, &mi->context=2Ec2=2Emda_context, &addr, primary);
+        management_=
learn_addr(&mi->context=2Ec2=2Emda_context, &addr, primary);
     }
 #endif=

     if (primary && multi_check_push_ifconfig_extra_route(mi, addr=2Ev4=2E=
addr))
@@ -1239,7 +1239,7 @@
 #ifdef ENABLE_MANAGEMENT
     if (management =
&& owner)
     {
-        management_learn_addr(management, &mi->context=2E=
c2=2Emda_context, &addr, primary);
+        management_learn_addr(&mi->cont=
ext=2Ec2=2Emda_context, &addr, primary);
     }
 #endif
     if (primary &&=
 multi_check_push_ifconfig_ipv6_extra_route(mi, &addr=2Ev6=2Eaddr))
diff --=
git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 7a649de=2E=2E=
25a3746 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
=
@@ -7373,7 +7373,7 @@
 #ifdef ENABLE_MANAGEMENT
         if (management)
  =
       {
-            management_auth_token(management, p[1]);
+           =
 management_auth_token(p[1]);
         }
 #endif
     }
diff --git a/src/op=
envpn/push=2Ec b/src/openvpn/push=2Ec
index fa7bf1e=2E=2Eda2bb9f 100644
---=
 a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -179,7 +179,7 @@
 #if=
def ENABLE_MANAGEMENT
         if (management)
         {
-            mana=
gement_notify(management, "info", c->sig->signal_text, m);
+            man=
agement_notify("info", c->sig->signal_text, m);
         }
 #endif
     }
@=
@ -215,7 +215,7 @@
 #ifdef ENABLE_MANAGEMENT
     if (management)
     {
- =
       management_notify(management, "info", "remote-exit", "EXIT");
+     =
   management_notify("info", "remote-exit", "EXIT");
     }
 #endif
 }
@@ -=
245,7 +245,7 @@
         struct buffer out =3D alloc_buf_gc(256, &gc);
    =
     if (buf_printf(&out, ">%s:%s", "INFOMSG", m))
         {
-            =
management_notify_generic(management, BSTR(&out));
+            management_=
notify_generic(BSTR(&out));
         }
         else
         {

-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1903?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4351fc499188b7d0cdbcb4f0531e9=
f157e948c5e
Gerrit-Change-Number: 1903
Gerrit-PatchSet: 1
Gerrit-Owner: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--70IJtWlQ4r8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1903?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">management: Remove management argument to functions that do not need i=
t<br><br>Found when reviewing the cppcheck constParameterPointer<br>warning=
s=2E<br><br>Change-Id: I4351fc499188b7d0cdbcb4f0531e9f157e948c5e<br>Signed-=
off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/o=
penvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/manage=2Eh<br>=
M src/openvpn/multi=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/push=
=2Ec<br>6 files changed, 42 insertions(+), 44 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/03/1903/1</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec=
</span><br><span>index 1109a13=2E=2E453ee7e 100644</span><br><span>--- a/sr=
c/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><sp=
an>@@ -260,7 +260,7 @@</span><br><span>             struct buffer out =3D a=
lloc_buf_gc(256, &amp;gc);</span><br><span>             buf_printf(&amp;out=
, &quot;&gt;PROXY:%u,%s,%s&quot;, (l ? l-&gt;current : 0) + 1,</span><br><s=
pan>                        (proto_is_udp(ce-&gt;proto) ? &quot;UDP&quot; :=
 &quot;TCP&quot;), np(ce-&gt;remote));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            management_notify_generic(management, BSTR(&am=
p;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 management_notify_generic(BSTR(&amp;out));</span><br><span>             ma=
nagement-&gt;persist=2Especial_state_msg =3D BSTR(&amp;out);</span><br><spa=
n>         }</span><br><span>         ce-&gt;flags |=3D CE_MAN_QUERY_PROXY;=
</span><br><span>@@ -425,7 +425,7 @@</span><br><span> </span><br><span>    =
     buf_printf(&amp;out, &quot;&gt;REMOTE:%s,%s,%s&quot;, np(ce-&gt;remote=
), ce-&gt;remote_port,</span><br><span>                    proto2ascii(ce-&=
gt;proto, ce-&gt;af, false));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        management_notify_generic(management, BSTR(&amp;out));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        management_notif=
y_generic(BSTR(&amp;out));</span><br><span>         management-&gt;persist=
=2Especial_state_msg =3D BSTR(&amp;out);</span><br><span> </span><br><span>=
         ce-&gt;flags &amp;=3D ~(CE_MAN_QUERY_REMOTE_MASK &lt;&lt; CE_MAN_Q=
UERY_REMOTE_SHIFT);</span><br><span>diff --git a/src/openvpn/manage=2Ec b/s=
rc/openvpn/manage=2Ec</span><br><span>index 2b0a661=2E=2E310d2e1 100644</sp=
an><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn=
/manage=2Ec</span><br><span>@@ -843,7 +843,7 @@</span><br><span> }</span><b=
r><span> </span><br><span> static void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-man_forget_passwords(struct management *man)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+man_forget_passwords(void)</span>=
<br><span> {</span><br><span>     ssl_purge_auth(false);</span><br><span>  =
   (void)ssl_clean_auth_token();</span><br><span>@@ -1344,18 +1344,16 @@</s=
pan><br><span>  * Checks if the correct number of arguments to a management=
 command are present</span><br><span>  * and otherwise prints an error and =
returns false=2E</span><br><span>  *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * @param man       The management interface struct</span><b=
r><span>  * @param p         pointer to the parameter array</span><br><span=
>  * @param n         number of arguments required</span><br><span>  * @par=
am flags     if MN_AT_LEAST require at least n parameters and not exactly n=
</span><br><span>  * @return          Return whether p has n (or at least n=
) parameters</span><br><span>  */</span><br><span> static bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-man_need(struct management *man, c=
onst char **p, const int n, unsigned int flags)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+man_need(const char **p, const int n, unsigned =
int flags)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int i;</span><br><span>     ASSERT(p[0]);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 1; i &lt;=3D n; ++i)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 1; i &lt=
;=3D n; ++i)</span><br><span>     {</span><br><span>         if (!p[i])</sp=
an><br><span>         {</span><br><span>@@ -1522,7 +1520,7 @@</span><br><sp=
an>     }</span><br><span>     else if (streq(p[0], &quot;signal&quot;))</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (man_need(man, p, 1, 0))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (man_need(p, 1, 0))</span><br><span>         {</s=
pan><br><span>             man_signal(man, p[1]);</span><br><span>         =
}</span><br><span>@@ -1554,7 +1552,7 @@</span><br><span>     }</span><br><s=
pan>     else if (streq(p[0], &quot;kill&quot;))</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man,=
 p, 1, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (man_need(p, 1, 0))</span><br><span>         {</span><br><span>          =
   man_kill(man, p[1]);</span><br><span>         }</span><br><span>@@ -1632=
,7 +1630,7 @@</span><br><span>     }</span><br><span>     else if (streq(p[=
0], &quot;log&quot;))</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (man_need(man, p, 1, MN_AT_LEAST))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man_need(p, 1,=
 MN_AT_LEAST))</span><br><span>         {</span><br><span>             if (=
p[1])</span><br><span>             {</span><br><span>@@ -1646,7 +1644,7 @@<=
/span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;echo=
&quot;))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (man_need(man, p, 1, MN_AT_LEAST))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (man_need(p, 1, MN_AT_LEAST)=
)</span><br><span>         {</span><br><span>             if (p[1])</span><=
br><span>             {</span><br><span>@@ -1660,14 +1658,14 @@</span><br><=
span>     }</span><br><span>     else if (streq(p[0], &quot;username&quot;)=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (man_need(man, p, 2, 0))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (man_need(p, 2, 0))</span><br><span>         =
{</span><br><span>             man_query_username(man, p[1], p[2]);</span><=
br><span>         }</span><br><span>     }</span><br><span>     else if (st=
req(p[0], &quot;password&quot;))</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, p, 1, MN_AT_LEA=
ST))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man=
_need(p, 1, MN_AT_LEAST))</span><br><span>         {</span><br><span>      =
       if (p[2])</span><br><span>             {</span><br><span>@@ -1685,25=
 +1683,25 @@</span><br><span>     }</span><br><span>     else if (streq(p[0=
], &quot;forget-passwords&quot;))</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        man_forget_passwords(man);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        man_forget_passwo=
rds();</span><br><span>     }</span><br><span>     else if (streq(p[0], &qu=
ot;needok&quot;))</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (man_need(man, p, 2, 0))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (man_need(p, 2, 0))</span><br=
><span>         {</span><br><span>             man_query_need_ok(man, p[1],=
 p[2]);</span><br><span>         }</span><br><span>     }</span><br><span> =
    else if (streq(p[0], &quot;needstr&quot;))</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, p=
, 2, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(man_need(p, 2, 0))</span><br><span>         {</span><br><span>            =
 man_query_need_str(man, p[1], p[2]);</span><br><span>         }</span><br>=
<span>     }</span><br><span>     else if (streq(p[0], &quot;cr-response&qu=
ot;))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (man_need(man, p, 1, 0))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (man_need(p, 1, 0))</span><br><span>     =
    {</span><br><span>             man_send_cc_message(man, &quot;CR_RESPON=
SE&quot;, p[1]);</span><br><span>         }</span><br><span>@@ -1718,42 +17=
16,42 @@</span><br><span>     }</span><br><span>     else if (streq(p[0], &=
quot;bytecount&quot;))</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (man_need(man, p, 1, 0))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (man_need(p, 1, 0))</spa=
n><br><span>         {</span><br><span>             man_bytecount(man, atoi=
(p[1]));</span><br><span>         }</span><br><span>     }</span><br><span>=
     else if (streq(p[0], &quot;client-kill&quot;))</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(m=
an, p, 1, MN_AT_LEAST))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (man_need(p, 1, MN_AT_LEAST))</span><br><span>         {</sp=
an><br><span>             man_client_kill(man, p[1], p[2]);</span><br><span=
>         }</span><br><span>     }</span><br><span>     else if (streq(p[0]=
, &quot;client-deny&quot;))</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (man_need(man, p, 3, MN_AT_LEAST))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man_need=
(p, 3, MN_AT_LEAST))</span><br><span>         {</span><br><span>           =
  man_client_deny(man, p[1], p[2], p[3], p[4]);</span><br><span>         }<=
/span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;clie=
nt-auth-nt&quot;))</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (man_need(man, p, 2, 0))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (man_need(p, 2, 0))</span><b=
r><span>         {</span><br><span>             man_client_auth(man, p[1], =
p[2], false);</span><br><span>         }</span><br><span>     }</span><br><=
span>     else if (streq(p[0], &quot;client-auth&quot;))</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_n=
eed(man, p, 2, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (man_need(p, 2, 0))</span><br><span>         {</span><br><span>  =
           man_client_auth(man, p[1], p[2], true);</span><br><span>        =
 }</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;c=
lient-pending-auth&quot;))</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (man_need(man, p, 4, 0))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (man_need(p, 4, 0))<=
/span><br><span>         {</span><br><span>             man_client_pending_=
auth(man, p[1], p[2], p[3], p[4]);</span><br><span>         }</span><br><sp=
an>@@ -1777,7 +1775,7 @@</span><br><span>     }</span><br><span>     else i=
f (streq(p[0], &quot;pkcs11-id-get&quot;))</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, p, 1,=
 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man=
_need(p, 1, 0))</span><br><span>         {</span><br><span>             man=
_pkcs11_id_get(man, atoi(p[1]));</span><br><span>         }</span><br><span=
>@@ -1789,35 +1787,35 @@</span><br><span>     }</span><br><span>     else i=
f (streq(p[0], &quot;remote-entry-get&quot;))</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, p,=
 1, MN_AT_LEAST))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (man_need(p, 1, MN_AT_LEAST))</span><br><span>         {</span><br=
><span>             man_remote_entry_get(man, p[1], p[2]);</span><br><span>=
         }</span><br><span>     }</span><br><span>     else if (streq(p[0],=
 &quot;proxy&quot;))</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (man_need(man, p, 1, MN_AT_LEAST))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man_need(p, 1, =
MN_AT_LEAST))</span><br><span>         {</span><br><span>             man_p=
roxy(man, p);</span><br><span>         }</span><br><span>     }</span><br><=
span>     else if (streq(p[0], &quot;remote&quot;))</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(m=
an, p, 1, MN_AT_LEAST))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (man_need(p, 1, MN_AT_LEAST))</span><br><span>         {</sp=
an><br><span>             man_remote(man, p);</span><br><span>         }</s=
pan><br><span>     }</span><br><span>     else if (streq(p[0], &quot;push-u=
pdate-broad&quot;))</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (man_need(man, p, 1, 0))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (man_need(p, 1, 0))</span><=
br><span>         {</span><br><span>             man_push_update(man, p, UP=
T_BROADCAST);</span><br><span>         }</span><br><span>     }</span><br><=
span>     else if (streq(p[0], &quot;push-update-cid&quot;))</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (m=
an_need(man, p, 2, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (man_need(p, 2, 0))</span><br><span>         {</span><br><spa=
n>             man_push_update(man, p, UPT_BY_CID);</span><br><span>       =
  }</span><br><span>@@ -1825,7 +1823,7 @@</span><br><span> #if 1</span><br>=
<span>     else if (streq(p[0], &quot;test&quot;))</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(ma=
n, p, 1, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (man_need(p, 1, 0))</span><br><span>         {</span><br><span>        =
     int i;</span><br><span>             const int n =3D atoi(p[1]);</span>=
<br><span>@@ -3024,13 +3022,13 @@</span><br><span> }</span><br><span> </spa=
n><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mana=
gement_notify(struct management *man, const char *severity, const char *typ=
e, const char *text)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+management_notify(const char *severity, const char *type, const char *text=
)</span><br><span> {</span><br><span>     msg(M_CLIENT, &quot;&gt;NOTIFY:%s=
,%s,%s&quot;, severity, type, text);</span><br><span> }</span><br><span> </=
span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-m=
anagement_notify_generic(struct management *man, const char *str)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+management_notify_generic(con=
st char *str)</span><br><span> {</span><br><span>     msg(M_CLIENT, &quot;%=
s&quot;, str);</span><br><span> }</span><br><span>@@ -3128,7 +3126,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-management_learn_addr(struct management *=
management, struct man_def_auth_context *mdac,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+management_learn_addr(struct man_def_auth_contex=
t *mdac,</span><br><span>                       const struct mroute_addr *a=
ddr, const bool primary)</span><br><span> {</span><br><span>     struct gc_=
arena gc =3D gc_new();</span><br><span>@@ -3220,7 +3218,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-management_auth_token(struct management *man, const =
char *token)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+managem=
ent_auth_token(const char *token)</span><br><span> {</span><br><span>     m=
sg(M_CLIENT, &quot;&gt;PASSWORD:Auth-Token:%s&quot;, token);</span><br><spa=
n> }</span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/mana=
ge=2Eh</span><br><span>index 27d3b60=2E=2E3ab937c 100644</span><br><span>--=
- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</sp=
an><br><span>@@ -384,10 +384,10 @@</span><br><span> </span><br><span> void =
management_up_down(struct management *man, const char *updown, const struct=
 env_set *es);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void management_notify(struct management *man, const char *sever=
ity, const char *type,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void management_notify(const char *severity, const char *type,</span><br=
><span>                        const char *text);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void management_notify_generi=
c(struct management *man, const char *str);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void management_notify_generic(const char *str);</s=
pan><br><span> </span><br><span> void management_notify_client_needing_auth=
(struct management *management,</span><br><span>                           =
                 const unsigned int auth_id,</span><br><span>@@ -400,7 +400=
,7 @@</span><br><span> void management_notify_client_close(struct managemen=
t *management,</span><br><span>                                     struct =
man_def_auth_context *mdac, const struct env_set *es);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-void management_learn_ad=
dr(struct management *management, struct man_def_auth_context *mdac,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void management_learn_addr=
(struct man_def_auth_context *mdac,</span><br><span>                       =
     const struct mroute_addr *addr, const bool primary);</span><br><span> =
</span><br><span> void management_notify_client_cr_response(unsigned mda_ke=
y_id,</span><br><span>@@ -487,7 +487,7 @@</span><br><span> /*</span><br><sp=
an>  * Echo an authentication token to management interface</span><br><span=
>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void management_=
auth_token(struct management *man, const char *token);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void management_auth_token(const char *t=
oken);</span><br><span> </span><br><span> /*</span><br><span>  * These func=
tions drive the bytecount in/out counters=2E</span><br><span>diff --git a/s=
rc/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 46ff1ba=
=2E=2E3e72b92 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br>=
<span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -1194,7 +1194,7 @@</sp=
an><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     if (management =
&amp;&amp; owner)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        management_learn_addr(management, &amp;mi-&gt;co=
ntext=2Ec2=2Emda_context, &amp;addr, primary);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        management_learn_addr(&amp;mi-&gt;contex=
t=2Ec2=2Emda_context, &amp;addr, primary);</span><br><span>     }</span><br=
><span> #endif</span><br><span>     if (primary &amp;&amp; multi_check_push=
_ifconfig_extra_route(mi, addr=2Ev4=2Eaddr))</span><br><span>@@ -1239,7 +12=
39,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     if (=
management &amp;&amp; owner)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        management_learn_addr(management, &=
amp;mi-&gt;context=2Ec2=2Emda_context, &amp;addr, primary);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        management_learn_addr(&amp;=
mi-&gt;context=2Ec2=2Emda_context, &amp;addr, primary);</span><br><span>   =
  }</span><br><span> #endif</span><br><span>     if (primary &amp;&amp; mul=
ti_check_push_ifconfig_ipv6_extra_route(mi, &amp;addr=2Ev6=2Eaddr))</span><=
br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</sp=
an><br><span>index 7a649de=2E=2E25a3746 100644</span><br><span>--- a/src/op=
envpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><=
span>@@ -7373,7 +7373,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</span>=
<br><span>         if (management)</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            management_auth_token(m=
anagement, p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          management_auth_token(p[1]);</span><br><span>         }</span><br=
><span> #endif</span><br><span>     }</span><br><span>diff --git a/src/open=
vpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index fa7bf1e=2E=2Eda2b=
b9f 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b=
/src/openvpn/push=2Ec</span><br><span>@@ -179,7 +179,7 @@</span><br><span> =
#ifdef ENABLE_MANAGEMENT</span><br><span>         if (management)</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        management_notify(management, &quot;info&quot;, c-&gt;sig-&gt;signa=
l_text, m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    management_notify(&quot;info&quot;, c-&gt;sig-&gt;signal_text, m);</spa=
n><br><span>         }</span><br><span> #endif</span><br><span>     }</span=
><br><span>@@ -215,7 +215,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</s=
pan><br><span>     if (management)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        management_notify(management, &=
quot;info&quot;, &quot;remote-exit&quot;, &quot;EXIT&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        management_notify(&quot;in=
fo&quot;, &quot;remote-exit&quot;, &quot;EXIT&quot;);</span><br><span>     =
}</span><br><span> #endif</span><br><span> }</span><br><span>@@ -245,7 +245=
,7 @@</span><br><span>         struct buffer out =3D alloc_buf_gc(256, &amp=
;gc);</span><br><span>         if (buf_printf(&amp;out, &quot;&gt;%s:%s&quo=
t;, &quot;INFOMSG&quot;, m))</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            management_notify_generic(man=
agement, BSTR(&amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            management_notify_generic(BSTR(&amp;out));</span><br><spa=
n>         }</span><br><span>         else</span><br><span>         {</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1903?usp=3Demail">change 1903</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1903?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I4351fc499188b7d0cdbcb4f0=
531e9f157e948c5e </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
1903 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--70IJtWlQ4r8=--


--===============0038571317824216802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0038571317824216802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0038571317824216802==--

