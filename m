Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA17CA9ED2
	for <openvpn-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i+Mcgqby2woHFoyvgCXykxGajygPlWcM9y+NQ4iXv+s=; b=fVQDArbW9ZYf9rZYfBjkZGywzl
	6GM6wuIifGZ+6KWx7fq2KNKULE3q/GlV8FdrPC6hAAI64qI+Fn7Gmik02Lp53HPcHd2NFMHMB2HcX
	dyeSCAZZVE4ZIRHXuUa0Ie/ychlM+/5Uzr+2VEA5wIpqH8ExbOoMXig5B/tfSJ4QxxBo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGMDJ-0001L2-No;
	Mon, 12 Oct 2026 20:01:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGMDI-0001Kr-6r
 for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 20:01:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nV6E/9R8OG4IUK3HrIc7lM/q4M6evjszzX6BKt/fu5o=; b=ZpNjujnWYYwRujfhaodxA+WbZx
 LuVEYbi3gv+ByGadnY+3bf/oPgcYw0YLk8pngl6aL+jGmtGkJuKsza9FZLPgP3mYZXrCLlHDXxNwO
 ZmK34000VCY3BJXryhQ68DLs4UVZPASx2zEMOyxpHzHNwkjKiei/Z8Dfpx1+A8AJ99PA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nV6E/9R8OG4IUK3HrIc7lM/q4M6evjszzX6BKt/fu5o=; b=A
 5GdBDZEodcsMGPLoOQmLrpOiwliBXYWnFn/mbcAa9Ipzlg2Dql8/LRS3puI230Zm5bTNQHES2rx+H
 LIn+K9K7w9dCIKTNz6szp/PhTWBi+Tqoc0cW5zJ3t9tisrygOY9N3ijuQHx6pKXKz0CW27agEbAzL
 RM5ScwEUCHsNU7iM=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGMDH-0004Tt-4x for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 20:01:36 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48dc202a60eso723205f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 12 Oct 2026 13:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791835288; x=1792440088; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nV6E/9R8OG4IUK3HrIc7lM/q4M6evjszzX6BKt/fu5o=;
 b=creXCx7y2XY8q8bfEqnacAopQ87IuL5IxkAHwZ8qlI6C008jn1VKSTE1h4Ugwq8OkP
 bHK8d8EiDaKcNn3I9L/0GozFVi7CPnpcW2BfN/wLu3IUpiEL2Gf8GuPaE+WxYPFkVPtw
 JlO4a/ar/fzMddmNvhNPMa+V9ch5tYXsBttueLw5itu6PTG/BhmMJT0d+PPS61gp5ZA9
 +HKFvG7ksbPvu6irV3H/oaitqPcTXgarQzpAOlO7vSAiHQ+PDvNGPjlJjiK3A/o7UqhO
 qTSQNTyM0TaO36MzpLArrMr+MpC5C0Q0kFUxRWXbpKGeS9XQ/9IxqqCjGpYdCT+mviGw
 wb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791835288; x=1792440088;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nV6E/9R8OG4IUK3HrIc7lM/q4M6evjszzX6BKt/fu5o=;
 b=Ij2CVsZWNA30JynmxVJESUfvX5bLLzb+7u/wHFg9YL2l2gtsyhLKp5iMJk1NheQ+1H
 SXnglsS/RIjqhEj6ZGVS206X6GaSYAxYL6THsnjJdxLrrbMxxw89rITeIIKQEuJJd77l
 1AuBJU5v22PKr4/hiONPsNrpJE7Bhvth9ZqltGChYoiuU0HB/kOnL8omrIBF/kWh3Lqq
 Euf4m1PlVyyzJPobdy9JdD6IbK4qe7KUQ49siWsbfpHrI94/vO9AN7wdg+pq1roXY1O8
 fucN45Xm1sA//kfpgtXEbczlqBJQkfw5ojvxz0L2KSWauAsYCrRNMDBHucKA+g/8Jski
 MTuQ==
X-Gm-Message-State: AFq9FYIy+exVWTCVRQgBScuWd14KKJFFa67+gO63lP4mt7xfB3tdTt1+
 YfnMYOhpuhIKmvfl7Tnc3aH5l1wzV4Jg9ud9xmsc+DWB9hoIgPhEVlYN/owvmPnlRkJTZxcp3F0
 w5zQ1S4v9HN5z1juEELkXXJYAI2QP/M/Wjd4g8+valf4bPs4yCr//WZwsvJHjloGvs5qA
X-Gm-Gg: AYBFou3O26rQU+Vu+OTIYU5pMKXgHwa2mLJu6iKxwuVsw0rXuAqchL3bjzCEuh0JFgl
 SHuBoNIKfKDcXOVC0CdkVOrhh5gjQuYqwQQqvk1uWHvffB7Ovgo2IlR6yVyEeVhbaCcwF7w1Q31
 WfkJv21+/GOP8SzblM39DuXX1z7L1Loh6Hm8o7/BO/INNx6cRZ82WfyqmdnlIA4utEP2wm+SL2x
 H0COQszf+6Kf/AL73mzh1U2qJITshJyRom7Kl0DGYIRYJZso4djjzqWUgIN/gHmK+gGD/v8O7un
 jiTQw8tME72S13s3fblnyxahVLHKDK7igCntSGyjkDHTMDzmM547b2xWkhaXLa+OCuTJph3DXHf
 dHpnKCfn8+1WmRrexpqVUbFp0i4k+4TnGdqHA2CkBr/jFb6yyugzXNV9o3W8RRiIF7QyM5nUsY2
 MvVN4ClSpSIGo6P+Tmwtr/XPMZxJ2mHrUBhQcdz9pv0ulUnYbK3ldBiRcwUHkwHIYZkx3l0Ouul
 eMAlcyexgVr5xrkMHL1BejxWaVcgNry3ClutE/FjXf7LLPyUfXBZzk3kKgsSMTJ0E02xPjszKKH
 XLgDQXdNlE/Q7czcZ14tG/uaSE/NqrZtSlJFhngsXpi3emkbymfUe/3xZJCTtP4vmbuLhak=
X-Received: by 2002:a5d:5846:0:b0:48d:b9ad:e48c with SMTP id
 ffacd0b85a97d-48dbace3fc5mr18640831f8f.46.1791835286851; 
 Mon, 12 Oct 2026 13:01:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ac4f65sm1119511f8f.39.2026.10.12.13.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 13:01:26 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 12 Oct 2026 20:01:24 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib74788b0365f6b44383ce09cf7d4914bbe500f8a
X-Gerrit-Change-Number: 1990
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1990?usp=email>
X-Gerrit-Commit: 15a1465f981bb3f1950056a8f82b91dfe5f3fdbc
In-Reply-To: <gerrit.1791790522000.Ib74788b0365f6b44383ce09cf7d4914bbe500f8a@gerrit.openvpn.net>
References: <gerrit.1791790522000.Ib74788b0365f6b44383ce09cf7d4914bbe500f8a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNzkwNTIyMDAwLkliNzQ3ODhiMDM2NWY2YjQ0MzgzY2UwOWNmN2Q0OTE0YmJlNTAwZjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4f615c6cb74ba025b79d9da73b0941e4cf79a131-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGMDH-0004Tt-4x
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make CRL reload EOF
 detection independent of stale error queue entries
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9187112978417094611=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9187112978417094611==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="m+lbY6Wo+DA="; charset=UTF-8

--m+lbY6Wo+DA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1990?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by R=C4=83zvan Cojocaru


Change subject: Make CRL reload EOF detec=
tion independent of stale error queue entries
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make CRL reload EOF detection independen=
t of stale error queue entries

backend_tls_ctx_reload_crl() treats a NULL =
from PEM_read_bio_X509_CRL()
as EOF when ERR_peek_error() shows PEM_R_NO_ST=
ART_LINE=2E ERR_peek_error()
returns the OLDEST queued error, so any entry =
left behind earlier in the
thread turns a clean EOF into a "CRL: cannot rea=
d CRL from file" warning,
prints the unrelated errors as if they came from =
the CRL file, and still
installs the CRLs already parsed=2E The previous co=
mmit removes the
leftover that triggered this in practice; this one stops t=
he loop from
depending on the queue being clean at all=2E

If the queue is =
not empty when the CRL is loaded, say so at D_LOW with
the queued errors, s=
ince that is a bug somewhere else worth seeing, then
start the loop from an=
 empty queue so only errors raised by
PEM_read_bio_X509_CRL() are visible=
=2E Test the error it raised last
rather than the oldest one, and clear the=
 queue on the EOF path instead
of popping a single entry=2E

Change-Id: Ib7=
4788b0365f6b44383ce09cf7d4914bbe500f8a
Signed-off-by: Drew Blokzyl <drew@li=
nuxkids=2Ecom>
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: R=
azvan Cojocaru <razvanc@mailbox=2Eorg>
Github: OpenVPN/openvpn#1104
Gerrit =
URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1990
Message-Id: <202610121=
02657=2E13611-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg39839=2Ehtml
Signed-off-by: =
Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_openssl=2Ec
1 =
file changed, 17 insertions(+), 2 deletions(-)


  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/90/1990/2

diff --git a/src/openvp=
n/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index b88e1d9=2E=2E96e90f82=
 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec=

@@ -1360,6 +1360,19 @@
     }
 
     int num_crls_loaded =3D 0;
+    /*
+ =
    * The EOF test below must only see errors raised by
+     * PEM_read_bi=
o_X509_CRL()=2E Anything already queued was left by an
+     * earlier oper=
ation in this thread and would otherwise be what
+     * ERR_peek_error() r=
eturns, turning a clean EOF into "cannot read CRL"=2E
+     * Report it, si=
nce that is a bug elsewhere, then start from an empty
+     * queue (crypto=
_msg() drains the queue while printing it)=2E
+     */
+    if (ERR_peek_er=
ror() !=3D 0)
+    {
+        crypto_msg(D_LOW, "CRL: OpenSSL error queue n=
ot empty on CRL load");
+    }
+    ERR_clear_error();
     while (true)
  =
   {
         X509_CRL *crl =3D PEM_read_bio_X509_CRL(in, NULL, NULL, NULL)=
;
@@ -1367,13 +1380,15 @@
         {
             /*
              * PEM_R_=
NO_START_LINE can be considered equivalent to EOF=2E
+             * ERR_pe=
ek_last_error() is the error PEM_read_bio_X509_CRL()
+             * raised=
 last; ERR_peek_error() would be the oldest queued one=2E
              */
=
-            bool eof =3D ERR_GET_REASON(ERR_peek_error()) =3D=3D PEM_R_NO_=
START_LINE;
+            bool eof =3D ERR_GET_REASON(ERR_peek_last_error())=
 =3D=3D PEM_R_NO_START_LINE;
             /* but warn if no CRLs have been =
loaded */
             if (num_crls_loaded > 0 && eof)
             {
     =
            /* remove that error from error stack */
-                (void=
)ERR_get_error();
+                ERR_clear_error();
                 brea=
k;
             }
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1990?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: Ib74788b0365f6b44383ce09cf7d4914bbe500f8a
Gerrit-Change-Number: 1990
G=
errit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--m+lbY6Wo+DA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/199=
0?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Mak=
e CRL reload EOF detection independent of stale error queue entries<br><br>=
backend_tls_ctx_reload_crl() treats a NULL from PEM_read_bio_X509_CRL()<br>=
as EOF when ERR_peek_error() shows PEM_R_NO_START_LINE=2E ERR_peek_error()<=
br>returns the OLDEST queued error, so any entry left behind earlier in the=
<br>thread turns a clean EOF into a &quot;CRL: cannot read CRL from file&qu=
ot; warning,<br>prints the unrelated errors as if they came from the CRL fi=
le, and still<br>installs the CRLs already parsed=2E The previous commit re=
moves the<br>leftover that triggered this in practice; this one stops the l=
oop from<br>depending on the queue being clean at all=2E<br><br>If the queu=
e is not empty when the CRL is loaded, say so at D_LOW with<br>the queued e=
rrors, since that is a bug somewhere else worth seeing, then<br>start the l=
oop from an empty queue so only errors raised by<br>PEM_read_bio_X509_CRL()=
 are visible=2E Test the error it raised last<br>rather than the oldest one=
, and clear the queue on the EOF path instead<br>of popping a single entry=
=2E<br><br>Change-Id: Ib74788b0365f6b44383ce09cf7d4914bbe500f8a<br>Signed-o=
ff-by: Drew Blokzyl &lt;drew@linuxkids=2Ecom&gt;<br>Signed-off-by: Arne Sch=
wabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt;<br>Github: OpenVPN/openvpn#1104<br>Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1990<br>Message-Id: &lt;20261012102657=2E136=
11-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg39839=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl_open=
ssl=2Ec<br>1 file changed, 17 insertions(+), 2 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/90/1990/2</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/=
ssl_openssl=2Ec</span><br><span>index b88e1d9=2E=2E96e90f82 100644</span><b=
r><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn=
/ssl_openssl=2Ec</span><br><span>@@ -1360,6 +1360,19 @@</span><br><span>   =
  }</span><br><span> </span><br><span>     int num_crls_loaded =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * The EOF test below must only se=
e errors raised by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * PEM_read_bio_X509_CRL()=2E Anything already queued was left by an</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * earlier operatio=
n in this thread and would otherwise be what</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * ERR_peek_error() returns, turning a clean E=
OF into &quot;cannot read CRL&quot;=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * Report it, since that is a bug elsewhere, then st=
art from an empty</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * queue (crypto_msg() drains the queue while printing it)=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (ERR_peek_error() !=3D 0)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        crypto_msg(D_LOW, &quot;CRL: Open=
SSL error queue not empty on CRL load&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ERR_clear_error();</span><br><span>     while (true)</span>=
<br><span>     {</span><br><span>         X509_CRL *crl =3D PEM_read_bio_X5=
09_CRL(in, NULL, NULL, NULL);</span><br><span>@@ -1367,13 +1380,15 @@</span=
><br><span>         {</span><br><span>             /*</span><br><span>     =
         * PEM_R_NO_START_LINE can be considered equivalent to EOF=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+             * ERR_peek_l=
ast_error() is the error PEM_read_bio_X509_CRL()</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             * raised last; ERR_peek_error() w=
ould be the oldest queued one=2E</span><br><span>              */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            bool eof =3D ERR_GE=
T_REASON(ERR_peek_error()) =3D=3D PEM_R_NO_START_LINE;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            bool eof =3D ERR_GET_REASON(=
ERR_peek_last_error()) =3D=3D PEM_R_NO_START_LINE;</span><br><span>        =
     /* but warn if no CRLs have been loaded */</span><br><span>           =
  if (num_crls_loaded &gt; 0 &amp;&amp; eof)</span><br><span>             {=
</span><br><span>                 /* remove that error from error stack */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                (void)=
ERR_get_error();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             ERR_clear_error();</span><br><span>                 break;</sp=
an><br><span>             }</span><br></pre><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1990?usp=3Demail">change 1990</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1990?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib=
74788b0365f6b44383ce09cf7d4914bbe500f8a </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1990 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>

</body></html>
--m+lbY6Wo+DA=--


--===============9187112978417094611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9187112978417094611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9187112978417094611==--

