Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2D8C5AD4E
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 15:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ojHlHzdbToIHNPl3EEQdFVWOrZHEdhFtT7NMu/WlF3s=; b=XpCp8XE/rGNUnFbzng72TkrfhE
	zh50xeAR+QJznHiB9cULfg796gHZ9uKTKKoCsCNurO0BzDVl2oIZvXocGySYd8qlidaeO9swzUwY9
	9iDELUOH0k7N1Z+LsaUFgbJvN2gvwOvPaLYHIloOtUD8RDN9iSxxfAO91nLme+Ae+CHk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wt5MU-0008Rp-BT;
	Sun, 09 Aug 2026 15:22:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wt5MT-0008Rj-DK
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 15:22:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ANS0IlG9rpzWg4MnniWTtVjE3bBx2S34pjLUOGnLWtk=; b=Z7+vE65ar0W+hSv9N8Bgb3Fxtx
 4odfW0c4n6u2WFP7bLqCSWFge5wY5oV3N32TzrPNec8Jrwa6HsQL7/8t66QElMNglSFQOxbpqpe24
 ebUW2ZGSk2rF8jd71XDAUgPiPKoGiw+Lrg0mdHgjHhaCMrLAkXwlhY6ZEI7EzcHxFmRs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ANS0IlG9rpzWg4MnniWTtVjE3bBx2S34pjLUOGnLWtk=; b=k
 azbslWK+tqulaUESuHFHTZlD18cTtwlsWHDn6WfGD4wK06KW2elMq64ZrL4IRgNQmaA0XaTs9/z2f
 uvfiIuhHk/27eL4gvXfU176X+qqzAHE/HqkouLNKPQfF5kDgnyFbYd6XrXSE+nOiz/QQeItu0cdBQ
 52TYD+0WR0nnaqt4=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wt5MW-0004ki-5A for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 15:22:53 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-495590dde14so12361055e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 09 Aug 2026 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786288966; x=1786893766; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ANS0IlG9rpzWg4MnniWTtVjE3bBx2S34pjLUOGnLWtk=;
 b=GzHE6+Bc319qr3va5uxwTm8Ww7buSOgp1hIK6ZMCKLakh9PdUqHq2qBomdtYkQYEA8
 3ptIlBCtOk+uzqE2yS2zlLD+rN5Jt7oXFsol1zVF9Kj2BAB+mJOu0z/rx6YiKo0x3Hjm
 ugMPtivfSTpkEIf+gzrYpP+yLXmrf68UNE4TIsasE/ltybDTe0+1aMGRaPxClind3Anv
 8Ztz91xiO6KLpv9J3lhyVyZgOIpKKGA1gzsxJkkrqC/r1CIrnlnX87vpsvAbYlXO4TWU
 IgPFmylwh4xTgqCi7TNpYEGaPVOmZIDrV+ipGYjRxLwSAJPgwZmfoJjC/I64rWEjmjt2
 cXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786288966; x=1786893766;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ANS0IlG9rpzWg4MnniWTtVjE3bBx2S34pjLUOGnLWtk=;
 b=IzVAsn4zkvMl7RMXejH2nh421+gLHAT0yEO/jrDgADpPJQNdBEk2cWyPqJ3DoD/83n
 CrTlTBn3E26GVO7Vi+zrU8Kdt1J3/JBunXDT2WrMnhuplBjUtKo++DIJNjvQjHjqLyXD
 7yK0VbFtGX8DxMZDwRR0fA5SbnwdXQEbT/NmnysxyPcdsCbp/nkPVihjbZgtEdLdDbjx
 KIsdU/R/hKE7+XeZ8B03J/IZnLJKEs6furrpoB1swj6HJB7DfCNNFGRc343M7VzlF7+J
 3QNdEHiQK0x3AOj9bhXfdRca9Qd+LwzZLs+d97z5WXC9hIxwuwMV0Y9QcAwEQY/u3+nO
 K33Q==
X-Gm-Message-State: AOJu0YyqbnKIT8w/CFKVJSDQFwWiLq943By+D5NgcLJHKAltfuk+fak0
 JbI/ZsaGHz1jQi0nAUaPwUMm576DmUYskKEWnFjNTEiYEU87w92cJuBMW/UzPYBzVFiLRBQJ5WO
 FhCcgVo30jkbvpBZq+KsNlhrBoJBZOLZddO91wGGuEqZ58/gsIJQOOGqOArn17u0477TO
X-Gm-Gg: AR+sD11aTkgrOKlHML16AImByavRvMBsT31JhMrYoQzTGFmFJkMkkGLGHAHvBVLwUXi
 hueKz/erprAyfudDr8/TSewfpCuGt0l+TdQdP8LfzpKc8iiVAFI0czUmwFrFnE3R22N7mVibdou
 fD6TwWwXRGTLWmf4HEMMkhXWuwYBxIis2pgJdCaHI66QlEoPzhQroosaOmjGNyRNZcyBJ3QO5Kp
 HKDfwXKWuDItjpStRs/m9dQW7wQhC4p10QWbO6fAnJMg34GzIcqJYWHvPOECcJq6vlKn1chr151
 Yc9wqnJpfpdsbOU9wxbC9xuysEbdtPJFLMVU3/1jl5uRv4JpaXpsRrR6g4i8JmmMcJPt5bGtA+C
 Ccjv63S4zO7jQ60BdYifrVgK5dhLOtmSCJEZQI+pda22gcl1lGWf/2ig68WExfr9b7LyqtoWsD9
 OPiYrC4BImMvQqXXW29zzGa7qUNYvq+BU3QmsYRBcoxepARb3fROBiQQASELN4R6uj4UYu/9yvN
 XyWss58wqKzimBVx2qR354i09Rd2H0pS6L9HIAZHKTkuJpplkyD2TYNZInTB+jy93vQaH8W0PUK
 SrsCKGE63eudcobkqnfltwJdJJaGVs+PT+PtqyU/qZQtQ09YdGAMbzxA2cJkJg==
X-Received: by 2002:a05:600c:8b51:b0:495:6b55:f938 with SMTP id
 5b1f17b1804b1-4994e7ba99emr539993035e9.10.1786288965870; 
 Sun, 09 Aug 2026 08:22:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995ea27ef0sm236954915e9.9.2026.08.09.08.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 08:22:45 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 9 Aug 2026 15:22:41 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
X-Gerrit-Change-Number: 1724
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1724?usp=email>
X-Gerrit-Commit: d42a9912c1d62006323a12af86baa148c77592e9
In-Reply-To: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
References: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkllNTUyMDg0NjM4MzIwYjNiYWNlNzZiZTJmNTg5MDEzZjEyYWYzYzQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <163e1aece93faac421aacbebd5be82743e9c39dd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wt5MW-0004ki-5A
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add check that
 username is identical to multi float
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1972821564354589549=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1972821564354589549==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F3S2z90UfOY="; charset=UTF-8

--F3S2z90UfOY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#20) to the change originally created b=
y plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail=
 )

The following approvals got outdated and were removed:
Code-Review+2 by=
 flichtenheld


Change subject: Add check that username is identical to mul=
ti float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add =
check that username is identical to multi float

This adds an additional sa=
fe guard for setups that do not use
client certificates=2E

Change-Id: Ie55=
2084638320b3bace76be2f589013f12af3c46
Signed-off-by: Arne Schwabe <arne@rfc=
2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724
Message-Id: <20260731100=
815=2E3406-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg38095=2Ehtml
Signed-off-by: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/multi=2Ec
1 file chan=
ged, 13 insertions(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/24/1724/20

diff --git a/src/openvpn/multi=
=2Ec b/src/openvpn/multi=2Ec
index f5a18f7=2E=2E20b4f14 100644
--- a/src/op=
envpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3111,6 +3111,18 @@
        =
 goto done;
     }
 
+    /* do not allow if target address has a different=
 username */
+    if (m1->locked_username || m2->locked_username)
+    {
+ =
       if (!m1->locked_username || !m2->locked_username
+            || str=
cmp(m1->locked_username, m2->locked_username) !=3D 0)
+        {
+         =
   msg(D_MULTI_LOW, "Disallow float to an address taken by another client %=
s",
+                multi_instance_string(ex_mi, false, &gc));
+          =
  goto done;
+        }
+    }
+
     /* It doesn't make sense to let a pee=
r float to the address it already
      * has, so we disallow it=2E This ca=
n happen if a DCO netlink notification
      * gets lost and we miss a floa=
ting step=2E
@@ -3127,7 +3139,7 @@
 
     msg(D_MULTI_LOW,
         "closin=
g instance %s due to float collision with %s "
-        "using the same cer=
tificate",
+        "using the same certificate and username",
         mul=
ti_instance_string(ex_mi, false, &gc), multi_instance_string(mi, false, &gc=
));
     multi_close_instance(m, ex_mi, false);
     ret =3D true;

-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie552084638320b3bace76be2=
f589013f12af3c46
Gerrit-Change-Number: 1724
Gerrit-PatchSet: 20
Gerrit-Owne=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>

--F3S2z90UfOY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #20</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Add check that usern=
ame is identical to multi float<br><br>This adds an additional safe guard f=
or setups that do not use<br>client certificates=2E<br><br>Change-Id: Ie552=
084638320b3bace76be2f589013f12af3c46<br>Signed-off-by: Arne Schwabe &lt;arn=
e@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724<br>M=
essage-Id: &lt;20260731100815=2E3406-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g38095=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
;<br>---<br>M src/openvpn/multi=2Ec<br>1 file changed, 13 insertions(+), 1 =
deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/24/1724/20</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mu=
lti=2Ec b/src/openvpn/multi=2Ec</span><br><span>index f5a18f7=2E=2E20b4f14 =
100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/sr=
c/openvpn/multi=2Ec</span><br><span>@@ -3111,6 +3111,18 @@</span><br><span>=
         goto done;</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* do not allow if target addr=
ess has a different username */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (m1-&gt;locked_username || m2-&gt;locked_username)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (!m1-&gt;locked_username || =
!m2-&gt;locked_username</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            || strcmp(m1-&gt;locked_username, m2-&gt;locked_username) !=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_MULTI=
_LOW, &quot;Disallow float to an address taken by another client %s&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                mult=
i_instance_string(ex_mi, false, &amp;gc));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            goto done;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>     /* It doesn&#39;t make sense to let a peer float to=
 the address it already</span><br><span>      * has, so we disallow it=2E T=
his can happen if a DCO netlink notification</span><br><span>      * gets l=
ost and we miss a floating step=2E</span><br><span>@@ -3127,7 +3139,7 @@</s=
pan><br><span> </span><br><span>     msg(D_MULTI_LOW,</span><br><span>     =
    &quot;closing instance %s due to float collision with %s &quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        &quot;using the same =
certificate&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       &quot;using the same certificate and username&quot;,</span><br><span=
>         multi_instance_string(ex_mi, false, &amp;gc), multi_instance_stri=
ng(mi, false, &amp;gc));</span><br><span>     multi_close_instance(m, ex_mi=
, false);</span><br><span>     ret =3D true;</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
724?usp=3Demail">change 1724</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1724?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatc=
hset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46 </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 1724 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> =
Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--F3S2z90UfOY=--


--===============1972821564354589549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1972821564354589549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1972821564354589549==--

