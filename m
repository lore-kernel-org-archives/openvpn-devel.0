Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C50C88E53
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 12:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cNlzlop1PDz3YEjBZXSysJdsqDzAjIVZ5kUN7XWqZH0=; b=hrWl6PqwLbcv5xBc6k8RJ2yTQr
	CYRnt3l4tZ/vK4faVTjQhAUxnTfJb917SgUkmIXMRsxpf2gmYNjAzfRANx4Pl47EWILybHAWbRaQ4
	sfCTBho3sRHbwMISUf8aR/REl46Jdv2svh0Nk3hRXkwKRf3V64HQd2HpGy5ZumyLBFbU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5Mai-0003Sy-Oj;
	Sat, 12 Sep 2026 12:12:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5Mah-0003Sr-O5
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 12:12:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hrX6FvDMhj35ED4xQzjLI7/+mEhc5M3CIBIX26yEFwY=; b=mmCHVHYzZRcYjxI5t/3kmhmFeD
 nrjAQWkC5N7xaA5qUj21CbCt0XzKPxUSI+5Rucy+Xl0ybPN/nVfqlFJNWxs/ctxnxXURrffscEtCn
 CK4tLZvDrUGWQCz9Q4cV4lnEVNLn200NvRGhdXUzIHYQcjbwBXtcXjRFyqL0caw8bC0Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hrX6FvDMhj35ED4xQzjLI7/+mEhc5M3CIBIX26yEFwY=; b=O
 c83RGGvYV9XahdjKQ4+WMA5DhxPC0keJwR+kW4J1fRZ04RGbMLcszP+1ePEW0mB1leNXHiNCqGM5t
 +TsatWqI2WCRpvMfyfdC/RqCChgJJNFO17R3eL+nWFGX6+MGHW7f3DM3a4qAPFwbJ1z9O8ASKMBmI
 un5Ea+vwpMweaS8c=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5Mab-0005Zk-VA for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 12:12:17 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-486e70f2457so845814f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 12 Sep 2026 05:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789215127; x=1789819927; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hrX6FvDMhj35ED4xQzjLI7/+mEhc5M3CIBIX26yEFwY=;
 b=QDaHiXiWo9/s4Ks7GkAE+NFcIvMBNCwNDtyiFxDL9wyjIIGht9Ie1m3EHriGqGHgAt
 fiZ8kLoFrrZPWNM55qqF9uFVBwaU7GUBU0h1KIly6d9RhHwZr4ncKORerJEVVdS0Oi++
 jdc5le92ol8GIAfPk7oZ/jiobxpZPhN830SshkJXCPusdOoTbv6gnyRogSuvuP2vVgdQ
 m3FJvWjH+2Kyjjctpdk71KArbl4F25u4oNQNja0qcfERzf1jxSCgtV4ITdgvcuYxSjYy
 n5mhXlRkxCTpVrv8Zoy/m1KrHvpG6hG4XM+EM623n4JFNkCweJpziBFsUb7r29xFSrLe
 4nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789215127; x=1789819927;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hrX6FvDMhj35ED4xQzjLI7/+mEhc5M3CIBIX26yEFwY=;
 b=fxOi+IViuwGoBH9bBSX0sWYoG5K89zm8oP4mCEzo1w1IdJjE8v8Lez5LADyqBwhkuN
 P+SlBogeygaqlDh925woNdUXGmDEbEO3z4dKt+e1Q8rcg7mkONI4Ns3t1CPS0Dicabzt
 sWGQB5BW9Ydm95gW4JeJL2Fd/rJSSPWeAOXJa7fmYla73ly0VSt+IUr238xXZ/HbxbU1
 X2kHDHydIzeJmJQKiqk63MowIxIjRLXjkeDy1gOnTz2if17HpuEpT9EraYWJACb7606g
 5/BsfsT4HgSg+1FR8zw1BwO/uICJFb/8XdvBtosDJ8qDDTmwg6viCDsuVh8t6njn/zTW
 QDEg==
X-Gm-Message-State: AFuF++k8sEwpkuumlkC6EUYeRFVoCGi9SlGuwqwvQccSjslq6S9awKZ1
 OjdnXfecbLwif25o4oT8uwNojls7ZHrP1GZzXCFwrTACy+U9FcQj8TmSwFPQzBF8A5W7Mibruz5
 slG/GiL6gz6hhX2s5CtcSdsPlw0FyFVwdXOaASMHQqW/ejshTzlBq4tRmgfiKqwBnPm4a
X-Gm-Gg: AYBFou1dcqVHLH0+bOqe/webrV+5M1HUeoL6Lc9PC3Jr04sPfIAtEUXoUkcNlZqgObh
 SGonUH3OPBXyQ9he+QUjE/JuQ2/z9XC4nQSJqR1GKUF8124uPycrivoJc8m9WhYfu+HDgn4cLEH
 Tw4DeXpdeznlMLdZ1Ec6v3L/oVTE2rwKy2r4HgzH8I4lQunVm0Tz/FeKyKqxwhJj2lT5qARZtaZ
 rEIJCie5iOueTe8LEbU/BjFEm8Z4Nt46g4EZY4P+behCCDKIPxCiOWTjywNmrWVOVO8lSyH4Tku
 TKUirbMg0yfeuxI+qDi5Bo/IWTFUgppG6eWIg3XMH+c44Qpin7B6Ib0jPxEQyb/4y+NUJxsro6W
 /VYsgjiXKUEVMzcdGA0pGJF53WftLcIw+tAcWrChExk44oWuOHI/swEBfWse5PFLIdD9usWzLCG
 5jAM17xFLR5zN9VGHwAciwBxklO1JOzh+lPCvarK5gciw7oqsxlEaeW1ljnlUl7h1w1Q+Vo6VkL
 GMOtEPG8EG8WmMpGcQp0E9udKuvDf3I2cTo92gl+0OTwhzZLZeWwl6Q1MZTVZPq3QsfoY1Rixq8
 iCknoCDWL1IFWWOw0F5eZFPn4FJYq/Nt0h7q/7LWtfgKoz2O8zLMC+m1DQiEGA==
X-Received: by 2002:a05:6000:88a:b0:485:8fe2:eda1 with SMTP id
 ffacd0b85a97d-486eb2fbbf7mr7383607f8f.17.1789215127034; 
 Sat, 12 Sep 2026 05:12:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ea60sm12689744f8f.17.2026.09.12.05.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 05:12:06 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 12 Sep 2026 12:12:05 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I4351fc499188b7d0cdbcb4f0531e9f157e948c5e
X-Gerrit-Change-Number: 1903
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1903?usp=email>
X-Gerrit-Commit: 9689f4ebb5d6c6689fe07b32c7f20ecf78946e16
In-Reply-To: <gerrit.1788815035000.I4351fc499188b7d0cdbcb4f0531e9f157e948c5e@gerrit.openvpn.net>
References: <gerrit.1788815035000.I4351fc499188b7d0cdbcb4f0531e9f157e948c5e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODE1MDM1MDAwLkk0MzUxZmM0OTkxODhiN2QwY2RiY2I0ZjA1MzFlOWYxNTdlOTQ4YzVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d56b329b18435a57b720ae41a1973727bb05a12a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5Mab-0005Zk-VA
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3435438558872809461=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3435438558872809461==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vFIX0jKjMCQ="; charset=UTF-8

--vFIX0jKjMCQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1903?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: management: Remove management argument to func=
tions that do not need it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

management: Remove management argument to functions that do n=
ot need it

Found when reviewing the cppcheck constParameterPointer
warning=
s=2E

Change-Id: I4351fc499188b7d0cdbcb4f0531e9f157e948c5e
Signed-off-by: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
03
Message-Id: <20260911204545=2E15750-1-gert@greenie=2Emuc=2Ede>
URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg391=
09=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
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
=2Enet:29418/openvpn refs/changes/03/1903/4

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
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ra=
zvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--vFIX0jKjMCQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1903?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">management: Remove manag=
ement argument to functions that do not need it<br><br>Found when reviewing=
 the cppcheck constParameterPointer<br>warnings=2E<br><br>Change-Id: I4351f=
c499188b7d0cdbcb4f0531e9f157e948c5e<br>Signed-off-by: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1903=
<br>Message-Id: &lt;20260911204545=2E15750-1-gert@greenie=2Emuc=2Ede&gt;<br=
>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg39109=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>---<br>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M=
 src/openvpn/manage=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openvpn/options=
=2Ec<br>M src/openvpn/push=2Ec<br>6 files changed, 42 insertions(+), 44 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/03/1903/4</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=
=2Ec b/src/openvpn/init=2Ec</span><br><span>index 1109a13=2E=2E453ee7e 1006=
44</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/ope=
nvpn/init=2Ec</span><br><span>@@ -260,7 +260,7 @@</span><br><span>         =
    struct buffer out =3D alloc_buf_gc(256, &amp;gc);</span><br><span>     =
        buf_printf(&amp;out, &quot;&gt;PROXY:%u,%s,%s&quot;, (l ? l-&gt;cur=
rent : 0) + 1,</span><br><span>                        (proto_is_udp(ce-&gt=
;proto) ? &quot;UDP&quot; : &quot;TCP&quot;), np(ce-&gt;remote));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            management_notify_g=
eneric(management, BSTR(&amp;out));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            management_notify_generic(BSTR(&amp;out));</spa=
n><br><span>             management-&gt;persist=2Especial_state_msg =3D BST=
R(&amp;out);</span><br><span>         }</span><br><span>         ce-&gt;fla=
gs |=3D CE_MAN_QUERY_PROXY;</span><br><span>@@ -425,7 +425,7 @@</span><br><=
span> </span><br><span>         buf_printf(&amp;out, &quot;&gt;REMOTE:%s,%s=
,%s&quot;, np(ce-&gt;remote), ce-&gt;remote_port,</span><br><span>         =
           proto2ascii(ce-&gt;proto, ce-&gt;af, false));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        management_notify_generic(manage=
ment, BSTR(&amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        management_notify_generic(BSTR(&amp;out));</span><br><span>     =
    management-&gt;persist=2Especial_state_msg =3D BSTR(&amp;out);</span><b=
r><span> </span><br><span>         ce-&gt;flags &amp;=3D ~(CE_MAN_QUERY_REM=
OTE_MASK &lt;&lt; CE_MAN_QUERY_REMOTE_SHIFT);</span><br><span>diff --git a/=
src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 2b0a6=
61=2E=2E310d2e1 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><=
br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -843,7 +843,7 @@</=
span><br><span> }</span><br><span> </span><br><span> static void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-man_forget_passwords(struct mana=
gement *man)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_for=
get_passwords(void)</span><br><span> {</span><br><span>     ssl_purge_auth(=
false);</span><br><span>     (void)ssl_clean_auth_token();</span><br><span>=
@@ -1344,18 +1344,16 @@</span><br><span>  * Checks if the correct number of=
 arguments to a management command are present</span><br><span>  * and othe=
rwise prints an error and returns false=2E</span><br><span>  *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * @param man       The management=
 interface struct</span><br><span>  * @param p         pointer to the param=
eter array</span><br><span>  * @param n         number of arguments require=
d</span><br><span>  * @param flags     if MN_AT_LEAST require at least n pa=
rameters and not exactly n</span><br><span>  * @return          Return whet=
her p has n (or at least n) parameters</span><br><span>  */</span><br><span=
> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_need=
(struct management *man, const char **p, const int n, unsigned int flags)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_need(const char *=
*p, const int n, unsigned int flags)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span>     ASSERT(p[=
0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 1;=
 i &lt;=3D n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   for (int i =3D 1; i &lt;=3D n; ++i)</span><br><span>     {</span><br><sp=
an>         if (!p[i])</span><br><span>         {</span><br><span>@@ -1522,=
7 +1520,7 @@</span><br><span>     }</span><br><span>     else if (streq(p[0=
], &quot;signal&quot;))</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (man_need(man, p, 1, 0))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (man_need(p, 1, 0))</sp=
an><br><span>         {</span><br><span>             man_signal(man, p[1]);=
</span><br><span>         }</span><br><span>@@ -1554,7 +1552,7 @@</span><br=
><span>     }</span><br><span>     else if (streq(p[0], &quot;kill&quot;))<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (man_need(man, p, 1, 0))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (man_need(p, 1, 0))</span><br><span>         {<=
/span><br><span>             man_kill(man, p[1]);</span><br><span>         =
}</span><br><span>@@ -1632,7 +1630,7 @@</span><br><span>     }</span><br><s=
pan>     else if (streq(p[0], &quot;log&quot;))</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, =
p, 1, MN_AT_LEAST))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (man_need(p, 1, MN_AT_LEAST))</span><br><span>         {</span><=
br><span>             if (p[1])</span><br><span>             {</span><br><s=
pan>@@ -1646,7 +1644,7 @@</span><br><span>     }</span><br><span>     else =
if (streq(p[0], &quot;echo&quot;))</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, p, 1, MN_AT_L=
EAST))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (m=
an_need(p, 1, MN_AT_LEAST))</span><br><span>         {</span><br><span>    =
         if (p[1])</span><br><span>             {</span><br><span>@@ -1660,=
14 +1658,14 @@</span><br><span>     }</span><br><span>     else if (streq(p=
[0], &quot;username&quot;))</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (man_need(man, p, 2, 0))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (man_need(p, 2, 0))=
</span><br><span>         {</span><br><span>             man_query_username=
(man, p[1], p[2]);</span><br><span>         }</span><br><span>     }</span>=
<br><span>     else if (streq(p[0], &quot;password&quot;))</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man=
_need(man, p, 1, MN_AT_LEAST))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (man_need(p, 1, MN_AT_LEAST))</span><br><span>       =
  {</span><br><span>             if (p[2])</span><br><span>             {</=
span><br><span>@@ -1685,25 +1683,25 @@</span><br><span>     }</span><br><sp=
an>     else if (streq(p[0], &quot;forget-passwords&quot;))</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        man_fo=
rget_passwords(man);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        man_forget_passwords();</span><br><span>     }</span><br><span>   =
  else if (streq(p[0], &quot;needok&quot;))</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, p, 2=
, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ma=
n_need(p, 2, 0))</span><br><span>         {</span><br><span>             ma=
n_query_need_ok(man, p[1], p[2]);</span><br><span>         }</span><br><spa=
n>     }</span><br><span>     else if (streq(p[0], &quot;needstr&quot;))</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (man_need(man, p, 2, 0))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (man_need(p, 2, 0))</span><br><span>         {</s=
pan><br><span>             man_query_need_str(man, p[1], p[2]);</span><br><=
span>         }</span><br><span>     }</span><br><span>     else if (streq(=
p[0], &quot;cr-response&quot;))</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, p, 1, 0))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man_need(p, 1,=
 0))</span><br><span>         {</span><br><span>             man_send_cc_me=
ssage(man, &quot;CR_RESPONSE&quot;, p[1]);</span><br><span>         }</span=
><br><span>@@ -1718,42 +1716,42 @@</span><br><span>     }</span><br><span> =
    else if (streq(p[0], &quot;bytecount&quot;))</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man,=
 p, 1, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (man_need(p, 1, 0))</span><br><span>         {</span><br><span>          =
   man_bytecount(man, atoi(p[1]));</span><br><span>         }</span><br><sp=
an>     }</span><br><span>     else if (streq(p[0], &quot;client-kill&quot;=
))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (man_need(man, p, 1, MN_AT_LEAST))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (man_need(p, 1, MN_AT_LEAST))</spa=
n><br><span>         {</span><br><span>             man_client_kill(man, p[=
1], p[2]);</span><br><span>         }</span><br><span>     }</span><br><spa=
n>     else if (streq(p[0], &quot;client-deny&quot;))</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need=
(man, p, 3, MN_AT_LEAST))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (man_need(p, 3, MN_AT_LEAST))</span><br><span>         {</=
span><br><span>             man_client_deny(man, p[1], p[2], p[3], p[4]);</=
span><br><span>         }</span><br><span>     }</span><br><span>     else =
if (streq(p[0], &quot;client-auth-nt&quot;))</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, p, =
2, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (m=
an_need(p, 2, 0))</span><br><span>         {</span><br><span>             m=
an_client_auth(man, p[1], p[2], false);</span><br><span>         }</span><b=
r><span>     }</span><br><span>     else if (streq(p[0], &quot;client-auth&=
quot;))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (man_need(man, p, 2, 0))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (man_need(p, 2, 0))</span><br><span>   =
      {</span><br><span>             man_client_auth(man, p[1], p[2], true)=
;</span><br><span>         }</span><br><span>     }</span><br><span>     el=
se if (streq(p[0], &quot;client-pending-auth&quot;))</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(=
man, p, 4, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (man_need(p, 4, 0))</span><br><span>         {</span><br><span>      =
       man_client_pending_auth(man, p[1], p[2], p[3], p[4]);</span><br><spa=
n>         }</span><br><span>@@ -1777,7 +1775,7 @@</span><br><span>     }</=
span><br><span>     else if (streq(p[0], &quot;pkcs11-id-get&quot;))</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (man_need(man, p, 1, 0))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (man_need(p, 1, 0))</span><br><span>         {</span>=
<br><span>             man_pkcs11_id_get(man, atoi(p[1]));</span><br><span>=
         }</span><br><span>@@ -1789,35 +1787,35 @@</span><br><span>     }</=
span><br><span>     else if (streq(p[0], &quot;remote-entry-get&quot;))</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (man_need(man, p, 1, MN_AT_LEAST))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (man_need(p, 1, MN_AT_LEAST))</span><br>=
<span>         {</span><br><span>             man_remote_entry_get(man, p[1=
], p[2]);</span><br><span>         }</span><br><span>     }</span><br><span=
>     else if (streq(p[0], &quot;proxy&quot;))</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, p=
, 1, MN_AT_LEAST))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (man_need(p, 1, MN_AT_LEAST))</span><br><span>         {</span><b=
r><span>             man_proxy(man, p);</span><br><span>         }</span><b=
r><span>     }</span><br><span>     else if (streq(p[0], &quot;remote&quot;=
))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (man_need(man, p, 1, MN_AT_LEAST))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (man_need(p, 1, MN_AT_LEAST))</spa=
n><br><span>         {</span><br><span>             man_remote(man, p);</sp=
an><br><span>         }</span><br><span>     }</span><br><span>     else if=
 (streq(p[0], &quot;push-update-broad&quot;))</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_need(man, p,=
 1, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
man_need(p, 1, 0))</span><br><span>         {</span><br><span>             =
man_push_update(man, p, UPT_BROADCAST);</span><br><span>         }</span><b=
r><span>     }</span><br><span>     else if (streq(p[0], &quot;push-update-=
cid&quot;))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (man_need(man, p, 2, 0))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (man_need(p, 2, 0))</span><br><span=
>         {</span><br><span>             man_push_update(man, p, UPT_BY_CID=
);</span><br><span>         }</span><br><span>@@ -1825,7 +1823,7 @@</span><=
br><span> #if 1</span><br><span>     else if (streq(p[0], &quot;test&quot;)=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (man_need(man, p, 1, 0))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (man_need(p, 1, 0))</span><br><span>         =
{</span><br><span>             int i;</span><br><span>             const in=
t n =3D atoi(p[1]);</span><br><span>@@ -3024,13 +3022,13 @@</span><br><span=
> }</span><br><span> </span><br><span> void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-management_notify(struct management *man, const char =
*severity, const char *type, const char *text)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+management_notify(const char *severity, const ch=
ar *type, const char *text)</span><br><span> {</span><br><span>     msg(M_C=
LIENT, &quot;&gt;NOTIFY:%s,%s,%s&quot;, severity, type, text);</span><br><s=
pan> }</span><br><span> </span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-management_notify_generic(struct management *man, =
const char *str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man=
agement_notify_generic(const char *str)</span><br><span> {</span><br><span>=
     msg(M_CLIENT, &quot;%s&quot;, str);</span><br><span> }</span><br><span=
>@@ -3128,7 +3126,7 @@</span><br><span> }</span><br><span> </span><br><span=
> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_lear=
n_addr(struct management *management, struct man_def_auth_context *mdac,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+management_learn_addr(=
struct man_def_auth_context *mdac,</span><br><span>                       c=
onst struct mroute_addr *addr, const bool primary)</span><br><span> {</span=
><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>@@ -3220,7=
 +3218,7 @@</span><br><span> }</span><br><span> </span><br><span> void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-management_auth_token(stru=
ct management *man, const char *token)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+management_auth_token(const char *token)</span><br><span=
> {</span><br><span>     msg(M_CLIENT, &quot;&gt;PASSWORD:Auth-Token:%s&quo=
t;, token);</span><br><span> }</span><br><span>diff --git a/src/openvpn/man=
age=2Eh b/src/openvpn/manage=2Eh</span><br><span>index 27d3b60=2E=2E3ab937c=
 100644</span><br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/=
src/openvpn/manage=2Eh</span><br><span>@@ -384,10 +384,10 @@</span><br><spa=
n> </span><br><span> void management_up_down(struct management *man, const =
char *updown, const struct env_set *es);</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void management_notify(struct manageme=
nt *man, const char *severity, const char *type,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void management_notify(const char *severity, c=
onst char *type,</span><br><span>                        const char *text);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-voi=
d management_notify_generic(struct management *man, const char *str);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void management_notify_ge=
neric(const char *str);</span><br><span> </span><br><span> void management_=
notify_client_needing_auth(struct management *management,</span><br><span> =
                                           const unsigned int auth_id,</spa=
n><br><span>@@ -400,7 +400,7 @@</span><br><span> void management_notify_cli=
ent_close(struct management *management,</span><br><span>                  =
                   struct man_def_auth_context *mdac, const struct env_set =
*es);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-void management_learn_addr(struct management *management, struct man_def_=
auth_context *mdac,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void management_learn_addr(struct man_def_auth_context *mdac,</span><br><sp=
an>                            const struct mroute_addr *addr, const bool p=
rimary);</span><br><span> </span><br><span> void management_notify_client_c=
r_response(unsigned mda_key_id,</span><br><span>@@ -487,7 +487,7 @@</span><=
br><span> /*</span><br><span>  * Echo an authentication token to management=
 interface</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-void management_auth_token(struct management *man, const char *to=
ken);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void managemen=
t_auth_token(const char *token);</span><br><span> </span><br><span> /*</spa=
n><br><span>  * These functions drive the bytecount in/out counters=2E</spa=
n><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</spa=
n><br><span>index 46ff1ba=2E=2E3e72b92 100644</span><br><span>--- a/src/ope=
nvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>=
@@ -1194,7 +1194,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><=
span>     if (management &amp;&amp; owner)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        management_learn_addr(m=
anagement, &amp;mi-&gt;context=2Ec2=2Emda_context, &amp;addr, primary);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        management_lear=
n_addr(&amp;mi-&gt;context=2Ec2=2Emda_context, &amp;addr, primary);</span><=
br><span>     }</span><br><span> #endif</span><br><span>     if (primary &a=
mp;&amp; multi_check_push_ifconfig_extra_route(mi, addr=2Ev4=2Eaddr))</span=
><br><span>@@ -1239,7 +1239,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT<=
/span><br><span>     if (management &amp;&amp; owner)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        management_l=
earn_addr(management, &amp;mi-&gt;context=2Ec2=2Emda_context, &amp;addr, pr=
imary);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mana=
gement_learn_addr(&amp;mi-&gt;context=2Ec2=2Emda_context, &amp;addr, primar=
y);</span><br><span>     }</span><br><span> #endif</span><br><span>     if =
(primary &amp;&amp; multi_check_push_ifconfig_ipv6_extra_route(mi, &amp;add=
r=2Ev6=2Eaddr))</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/=
openvpn/options=2Ec</span><br><span>index 7a649de=2E=2E25a3746 100644</span=
><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/=
options=2Ec</span><br><span>@@ -7373,7 +7373,7 @@</span><br><span> #ifdef E=
NABLE_MANAGEMENT</span><br><span>         if (management)</span><br><span> =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
management_auth_token(management, p[1]);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            management_auth_token(p[1]);</span><br><sp=
an>         }</span><br><span> #endif</span><br><span>     }</span><br><spa=
n>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>=
index fa7bf1e=2E=2Eda2bb9f 100644</span><br><span>--- a/src/openvpn/push=2E=
c</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -179,7 +179=
,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>         if=
 (management)</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            management_notify(management, &quot;info&quo=
t;, c-&gt;sig-&gt;signal_text, m);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            management_notify(&quot;info&quot;, c-&gt;sig-&g=
t;signal_text, m);</span><br><span>         }</span><br><span> #endif</span=
><br><span>     }</span><br><span>@@ -215,7 +215,7 @@</span><br><span> #ifd=
ef ENABLE_MANAGEMENT</span><br><span>     if (management)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        manageme=
nt_notify(management, &quot;info&quot;, &quot;remote-exit&quot;, &quot;EXIT=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        man=
agement_notify(&quot;info&quot;, &quot;remote-exit&quot;, &quot;EXIT&quot;)=
;</span><br><span>     }</span><br><span> #endif</span><br><span> }</span><=
br><span>@@ -245,7 +245,7 @@</span><br><span>         struct buffer out =3D=
 alloc_buf_gc(256, &amp;gc);</span><br><span>         if (buf_printf(&amp;o=
ut, &quot;&gt;%s:%s&quot;, &quot;INFOMSG&quot;, m))</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            manage=
ment_notify_generic(management, BSTR(&amp;out));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            management_notify_generic(BSTR(&am=
p;out));</span><br><span>         }</span><br><span>         else</span><br=
><span>         {</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1903?usp=3Demail">change 190=
3</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1903?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I4351fc499188b7d0cdbcb4f0531e9f157e948c5e </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1903 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>

</body></html>
--vFIX0jKjMCQ=--


--===============3435438558872809461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3435438558872809461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3435438558872809461==--

