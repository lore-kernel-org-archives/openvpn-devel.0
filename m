Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A210BC5AC80
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 15:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n8MDyyXgs7q9ePg+4ZJqItkph7YE63Z4MFHaMrcD1hg=; b=Ibrj8uXK16IyfKdGfaSYUm4eia
	R4MoDedRLoyZsUp1odP9IXdQuIuJZfv20qFGNhR7S0HUXIltMLNBANgSSIjpGWehvg9Cr5rFuEGe+
	SoJkCeBvlLtUUVuvnNB7B+r8PGg85RxigDbeQ0oOlKxk10jbM2Myd07DQSDCkiQQjctw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wt5MY-0002NP-Nt;
	Sun, 09 Aug 2026 15:22:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wt5MW-0002NI-QO
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 15:22:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=SWPPvWCgE+pqspdmF4ZKhuDrdHDEWZTNJCraFxmIV08=; b=NyWT1AJXIBhcgqm2bwY9NvlFML
 6ipxyJXxIfSMQH/SpaxUN/2gMnzbDBmzedjCUj95m/1b6LAe7CZ80OCG2EgVYG3bHe+QlorWWNLby
 epGRY8h5xJ7Ua3mnAoFhFp9OJ1c9X2Im/tvwkyzAqRKqeUtUdMaaIeOQ1BQ/MLhL7rK0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SWPPvWCgE+pqspdmF4ZKhuDrdHDEWZTNJCraFxmIV08=; b=l
 Glg6KHk8a1NTvbCTCwteWM3FikQZZKhBCveUkS19H1AyE0L5QC4x3+YFudc9vVM0CiWoWZMyoyUHx
 uDcrf55KxXihifxhYYR+moAm5YzVp1Crl//A8lUtSBNYZKrGWUlJnYXUOe88BkrxA7/1Hw4ZrllBp
 z5vHAqzuXdCLrGhw=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wt5MX-0004kn-0C for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 15:22:54 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so5254905e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 09 Aug 2026 08:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786288967; x=1786893767; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SWPPvWCgE+pqspdmF4ZKhuDrdHDEWZTNJCraFxmIV08=;
 b=er0947ALDYKYezL6wbIacg0DhnhJwJJPNMvGJFQiHfEDaJDBFA+KJCv6uUkWhZhgPe
 iMRYh0U54l0VafmmcAHkXUIl/2Zx/Azd0NIHzruj/5UQbiGjbzHoZr79gFgb13iIKpWa
 j4XNulzNJEeh5YmEOmK3jzmFggKeSMVXqze2v2p5x+lKzbb5oh42l1j2j++6Abey/Xw6
 c+KgzKqz3M/z305FAp//zsZGz5aH75eyA2xx73o3S7Nf+g4i/o/HHdl0EYkz1BHrKdCw
 vCYxAoPtmF/0cd6IV329r/3c8Ak0D9yQiJh456ba30rojha2gplXwKpYk2ZiPoy7aOOp
 1zKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786288967; x=1786893767;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SWPPvWCgE+pqspdmF4ZKhuDrdHDEWZTNJCraFxmIV08=;
 b=i09o9LK6KberEfgEfl9629928zMbLpsJn9mmD3ZYTWp5YX0HTQuTAm2lAld1xk4E8u
 soUrT6nOv+b+jtd4BoUrTuJhEHqNeCAwgIubyWp1poiPLKuJS3dprnyj2pxaK1kaf3YG
 yDSpC24/gEinuGr11T1EG7RDfvj6oLy/DFwmtU0UsfbUfF5jbnEFRfjGXqfrlkmfycNM
 HjGX+Yo4sd9/ecF5/c8RieYaQ2zPnaJuxHlE7GPFjvwo/0rR2Bp9FbwAiO5Ari/MgYnm
 6heWFi8BGh2x5AqvKdBLi7dV0x9pBIh2le3ga6ZQ0ndtQYJwIfJzxU7j4e+mPxhe3QPN
 gfGA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rro1F4Y4+DgCrzzAjuKW+b4nyfswQbgAYi2uf2NfarTU/tSe7UnsBAXNo85qLmTZcqQIosUsXgVBbkGq0M3@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzlTxxggEWbR5NL6wcuV3NRmInhwenLUPnixhOthhEhcZKHxy1F
 W7RDKbgBtEkpmd0Raw7MrjPCC9SE3HU6m5bYSxjiIE8smNQPvlt2+sO0h7Wd20bflEzDEhBGt3u
 vITS8tFDBkjOZhOhGkkx3tH7GCLtoa624coIiBIXnPjpGjiqSW9cZqGZy0UnoO6da30Pu
X-Gm-Gg: AR+sD12h/DR/pOfsMfd52ldDoHSYI1PVW9dNZ1xPxQ0RdjnYJH6g5/RNb0zvdOmmboO
 HH45FmY/FerwIUOYHU4d3AIlfdgz6A9rN320YY+G6YyqKxy1WLjYto28lvQG85HTvBwQLAXUAvm
 +tIcL0IAeWJj/Q7jzI66L4gIA3r1LcxX48CN0VloKcajmMVu9Ug7AmolNI3IyoEZ/6lagYIgIXf
 d7Hrf5lyWgrV1XfafdI3/qcdqiBkC0ANjV6ppoM8TQ6D8bfVkBTGZGb7f2tLNyInpdGnrXvvSog
 3RV96FUvbvLZaqzkkJg3eGjt6PFkGuFg9c3NmqKA7iSOS1JcQb0sQh5ndNkO0AUBbA3akaGn13a
 DPDbv+gOAvUFUHs8MJlX/ixspXxJ5XpeEVz/5zQId6n2IChcMjPvXiXkizF23n5A+lotKCX5mfJ
 UdWx5kE1b+aHPalx2s2FfaYfbr4WU4W9+PH/nFDBNskXp9Wo+nNC7sfAQtbxiFnz4bkhRNsjtAd
 jWpTIDQcTxZdJMj4BlpIphD3sj5ZXKmkyG5lenQOjs0dsjSpHcNbZMEwS8Rf45WRLE9rxzebVuk
 6kaJXsnid8TW63dxtf2iw0BWx3hSs9C4SU5FnvLM9SxyUe0LtisfiIs3GNsw4g==
X-Received: by 2002:a05:600c:1987:b0:495:3de8:33a6 with SMTP id
 5b1f17b1804b1-4995e0dfb2emr235351825e9.16.1786288966746; 
 Sun, 09 Aug 2026 08:22:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995e9e7164sm256237825e9.2.2026.08.09.08.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 08:22:46 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 9 Aug 2026 15:22:46 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: Ie552084638320b3bace76be2f589013f12af3c46
X-Gerrit-Change-Number: 1724
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1724?usp=email>
X-Gerrit-Commit: d42a9912c1d62006323a12af86baa148c77592e9
In-Reply-To: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
References: <gerrit.1782134588000.Ie552084638320b3bace76be2f589013f12af3c46@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkllNTUyMDg0NjM4MzIwYjNiYWNlNzZiZTJmNTg5MDEzZjEyYWYzYzQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <163e1aece93faac421aacbebd5be82743e9c39dd-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wt5MX-0004kn-0C
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
Content-Type: multipart/mixed; boundary="===============4757080740186917559=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4757080740186917559==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9As0Q347Txs="; charset=UTF-8

--9As0Q347Txs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1724?usp=3Demail )

Change subject: Add check that username is identica=
l to multi float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Add check that username is identical to multi float

This adds an addi=
tional safe guard for setups that do not use
client certificates=2E

Change=
-Id: Ie552084638320b3bace76be2f589013f12af3c46
Signed-off-by: Arne Schwabe =
<arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724
Message-Id: <20=
260731100815=2E3406-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arch=
ive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38095=2Ehtml
Signed-of=
f-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/multi=2Ec
1 =
file changed, 13 insertions(+), 1 deletion(-)




diff --git a/src/openvpn/=
multi=2Ec b/src/openvpn/multi=2Ec
index f5a18f7=2E=2E20b4f14 100644
--- a/s=
rc/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -3111,6 +3111,18 @@
   =
      goto done;
     }
 
+    /* do not allow if target address has a diff=
erent username */
+    if (m1->locked_username || m2->locked_username)
+   =
 {
+        if (!m1->locked_username || !m2->locked_username
+            |=
| strcmp(m1->locked_username, m2->locked_username) !=3D 0)
+        {
+    =
        msg(D_MULTI_LOW, "Disallow float to an address taken by another cli=
ent %s",
+                multi_instance_string(ex_mi, false, &gc));
+     =
       goto done;
+        }
+    }
+
     /* It doesn't make sense to let =
a peer float to the address it already
      * has, so we disallow it=2E Th=
is can happen if a DCO netlink notification
      * gets lost and we miss a=
 floating step=2E
@@ -3127,7 +3139,7 @@
 
     msg(D_MULTI_LOW,
         "c=
losing instance %s due to float collision with %s "
-        "using the sam=
e certificate",
+        "using the same certificate and username",
       =
  multi_instance_string(ex_mi, false, &gc), multi_instance_string(mi, false=
, &gc));
     multi_close_instance(m, ex_mi, false);
     ret =3D true;

--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
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

--9As0Q347Txs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1724?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Add check that username is identical to mu=
lti float<br><br>This adds an additional safe guard for setups that do not =
use<br>client certificates=2E<br><br>Change-Id: Ie552084638320b3bace76be2f5=
89013f12af3c46<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br=
>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL:=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724<br>Message-Id: &lt;2026073=
1100815=2E3406-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38095=2Ehtml<br>Signe=
d-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/open=
vpn/multi=2Ec<br>1 file changed, 13 insertions(+), 1 deletion(-)<br><br></p=
re>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br=
><span>index f5a18f7=2E=2E20b4f14 100644</span><br><span>--- a/src/openvpn/=
multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -3=
111,6 +3111,18 @@</span><br><span>         goto done;</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* do not allow if target address has a different username */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (m1-&gt;locked_usernam=
e || m2-&gt;locked_username)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (!m1-&gt;locked_username || !m2-&gt;locked_username</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            || strcmp(m1-&gt;locked_u=
sername, m2-&gt;locked_username) !=3D 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(D_MULTI_LOW, &quot;Disallow float to an address =
taken by another client %s&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                multi_instance_string(ex_mi, false, &amp;gc))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto d=
one;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* It doesn&#39;t=
 make sense to let a peer float to the address it already</span><br><span> =
     * has, so we disallow it=2E This can happen if a DCO netlink notificat=
ion</span><br><span>      * gets lost and we miss a floating step=2E</span>=
<br><span>@@ -3127,7 +3139,7 @@</span><br><span> </span><br><span>     msg(=
D_MULTI_LOW,</span><br><span>         &quot;closing instance %s due to floa=
t collision with %s &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        &quot;using the same certificate&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        &quot;using the same certificate =
and username&quot;,</span><br><span>         multi_instance_string(ex_mi, f=
alse, &amp;gc), multi_instance_string(mi, false, &amp;gc));</span><br><span=
>     multi_close_instance(m, ex_mi, false);</span><br><span>     ret =3D t=
rue;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail">change 1724</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1724?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie552084638320b3ba=
ce76be2f589013f12af3c46 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1724 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </div>
=
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>

</body></html>
--9As0Q347Txs=--


--===============4757080740186917559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4757080740186917559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4757080740186917559==--

