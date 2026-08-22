Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225D4C5DF97
	for <openvpn-devel@archiver.kernel.org>; Sat, 22 Aug 2026 15:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BzfqRrHnqnjJPpfqp9OLNLHF8KlsvkkT/uaWv2rkt+A=; b=ZYq2S5WxgBvCuw2iZLe3lwHxyZ
	KjI9pcY7VTdDoz/MqvUvy8TqOLrx+GxoAAsVypT+sQVM5Os8MutLxrAdvPdePRhdQpyKixpaVmP+V
	dOM04sJMzbnTXZi/oNeLnsLHjGHfbgfHrODPquwHaFXPlz/GPNA3EAmsT2sYkqHiGWHw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxo4L-0006ir-AS;
	Sat, 22 Aug 2026 15:55:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxo3z-0006iC-KL
 for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 15:55:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=u9K0qDoQZafxfK+YzL2X8oRBk+wzk4N6+wDeWNYzeiI=; b=YKTtBmNg74eN9L5EDl52vCdwYW
 TcODgNrOPNmO0FeOBLmkrb6KCxcdFDJ7cMp7fiq6HP4PjZsvRh6d3+3kauDhkwY+f0z7XSsli6ZuS
 A80UHAzoQ2SNnL+aEAM4WTuoI7CpYvamcG4IMM3GsUoi83tjvXeYcpAwKUJJWl5lDkjU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=u9K0qDoQZafxfK+YzL2X8oRBk+wzk4N6+wDeWNYzeiI=; b=m
 Gn0R1eiz4gIoXCuqXU9EC1wK5Sa3A+3FCzNXpZA24e5y6BlKRcT4Sph7b0Lgm0oxUvF50pB1jaK9Q
 CoR6MX3uUkEJfaELZQAuQoLVrLm7ROkpCuf3Tg1jsk31dPE5vL/sYSDN8ya4aMiG8Sitw9o6fTCMY
 gd/dz1KWVigMOIuk=;
Received: from mail-ej1-f49.google.com ([209.85.218.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxo3q-0005W8-L4 for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 15:55:11 +0000
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c15ba3a2b4bso292101166b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 22 Aug 2026 08:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787414104; x=1788018904; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=u9K0qDoQZafxfK+YzL2X8oRBk+wzk4N6+wDeWNYzeiI=;
 b=AYgfWbd7XjRe+zIqPH6Rj78i1ZlbqhfZWtkt7AJpr18SR7IiVN14fLWr8fewprwBPT
 qGJ9EOMTSdg34UYr4l6Ay1pf6V8KWrAdyb6A5eDlRU3eIqfBTxACpEOYagiO68lGynf4
 w4QgpEeffhkTih00Rk6MvoE6pXLhyHBTg39acVdWEcFivMQLedfmfLHDlpbWz2mGHoQ/
 30/8ISP5FDF8NIuzpeqBBi+cvbDFqxPdUax0/Zh2APGoHSi81ba3fN8eqrAgOecCWN/R
 kYOOs1EJ8vAQksWAMJSJl9CfEHBlO3OkU2FEYny9Nilsf1pavOwspNve75dTNYr+hhMC
 5ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787414104; x=1788018904;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u9K0qDoQZafxfK+YzL2X8oRBk+wzk4N6+wDeWNYzeiI=;
 b=J3g1Tfiq70SE0//FzZPXsL/mCQ4h0ASfP7Q0ZEM9NlcNxL9DzAMiZ+1Y7vRP+ZEPgI
 P0yjsK/AQtcEFUxyp6aYBlfehCcu6LvQxn6/GXIJsnm7wCpRp2VMjmqRxvysbPwsy6L1
 I4etc1ZOeQPccF6jS2/XWxGjn475vjIWD9lIgH1PFyj+iY3X1GxulkQexkEkDE1aGwNm
 StUBfbTMlK3K80Qp/97ycD013UUGhdL+K0NlPo5+bHm3qVfB10xqFVC0sff4+byMTOG6
 0Cm5v8zTPsiEe23p5Z1ZX+6JaMvs7rLLCDp+WQjOJz7Y6laZ7LXxRZSSDt6hT4D7Hbxy
 qBsA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqP2EaJ6G/0fqMqkMjrYYDXWPvwLL9B+uq5wQvezOkpqGFVwFsEW+SgCQxUs0jhmsiiBaWU1QqRhzWPr+8T@lists.sourceforge.net
X-Gm-Message-State: AFuF++mixUpqd94R1GrhKS919KXC/3XZLnDbHbyhjTstWD/4/fERT6k2
 VErDYnvNOXmYamhOKaXsXbYTXt582866lgFjyrp8sdpNTmHN46c657NtUNWhElfySQefKvd07vh
 QBCvvr+7bN3PSbHu3xU0Ipb8xw4ZUFLTdyk5yH5QLgRQa9JOAmWUe+U3uGS3i1kVvkGER
X-Gm-Gg: AR+sD13CJOdKgYBGdPjcCDjMS2yyEmAxOlirTplTR+XpLgSKG5lqpEqN0vg9MsTfz+h
 Z5rJ2V/xPWLuymzmVJPQnGWjf8dIKQvirCa5fkmnG5VvyWAT/xNXem2pXsLU6B0lWGEdi+TV+dc
 YyAaPEl84yiEq9j66+IXR9WubeerPfs0OMEq4BL2Sckod8W3w2swTQYKSNeS+5YLleQjgSfk6aP
 uXxI1ACxbkdLNzWZoIbDNsBDXsMh8al9Ay8J34NaUK337dYcoAPyIQIdiEk8H+iXxaIIc8xrALL
 1ddXoBEwl7rRt13Iyx+NcsVjjp1uxBnH+xYPdRYPZtYneU1sr5hVdnsHK8eMgFfrno2qYri28VB
 u4bvrW2s08CdFZdrBOD9MwAdScvr55hKDdPKGU/aQAw608vZpiUoEPn0vdWLCo6P91u1pimUe8L
 22dHeBCjmOvZbFw5ckg9WjYlfyFfNkWiBjA72c4uUBbJCCIIATxb0kFsZ5M2xisGB7HJdHDmM0I
 UxyVS+VKAGWZjSmacSsDqNjuL5AiGkatToLfQs7fX9CZERPsnw3lENjOejvDba1YcKWzxLadRpo
 CqJvyPONH3oRXDMmWiitgLpZeDJ61pgN1Fx74+NKGUGkTUpM63I=
X-Received: by 2002:a17:906:3e5a:b0:c20:2165:d74f with SMTP id
 a640c23a62f3a-c246a6ca4f5mr1280110766b.22.1787414103981; 
 Sat, 22 Aug 2026 08:55:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f64f6sm385903366b.40.2026.08.22.08.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 08:55:03 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 22 Aug 2026 15:55:03 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I4068bf8175c23151298d142dc920ab89f861a411
X-Gerrit-Change-Number: 1681
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1681?usp=email>
X-Gerrit-Commit: c797db6225755e6d7144d433ed55d3992d8ff141
In-Reply-To: <gerrit.1779197752000.I4068bf8175c23151298d142dc920ab89f861a411@gerrit.openvpn.net>
References: <gerrit.1779197752000.I4068bf8175c23151298d142dc920ab89f861a411@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MTk3NzUyMDAwLkk0MDY4YmY4MTc1YzIzMTUxMjk4ZDE0MmRjOTIwYWI4OWY4NjFhNDExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ec263dbcfec03e456470ff3340f76a603306bf0f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxo3q-0005W8-L4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: clinat: do not
 adjust UDP checksum if zero
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5834863278867425232=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5834863278867425232==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3lYmI+zWKoE="; charset=UTF-8

--3lYmI+zWKoE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1681?usp=3Demail )

Change subject: clinat: do not adjust UDP checksum =
if zero
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

clin=
at: do not adjust UDP checksum if zero

As per RFC768, when the UDP checksu=
m is zero, it means
it was not computed by the source, therefore any NAT
pr=
ocessing along the way should leave the checksum alone
and not update it=2E=

Failing to do so would result in computing a bogus value=2E

At the same t=
ime, if the result of updating a non-zero
checksum ends up being zero, as p=
er the same RFC, we must
store its one-complement (0xFFFF) as zero is reser=
ved
for "checksum not computed", as mentioned above=2E

Ensure our Client N=
AT code follows both rules=2E

Github: closes OpenVPN/openvpn#1037
Reported=
-by: Jeff Salee <jeff@samjackson=2Ecom>
Change-Id: I4068bf8175c23151298d142=
dc920ab89f861a411
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom=
>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1681
Message-Id: <20260821182442=2E13542-1-=
gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg38581=2Ehtml
Signed-off-by: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
---
M src/openvpn/clinat=2Ec
1 file changed, 17 inse=
rtions(+), 1 deletion(-)




diff --git a/src/openvpn/clinat=2Ec b/src/open=
vpn/clinat=2Ec
index 32c1325=2E=2E3724022 100644
--- a/src/openvpn/clinat=
=2Ec
+++ b/src/openvpn/clinat=2Ec
@@ -258,7 +258,23 @@
         {
         =
    if (BLENZ(ipbuf) >=3D sizeof(struct openvpn_iphdr) + sizeof(struct open=
vpn_udphdr))
             {
-                ADJUST_CHECKSUM(accumulate, h-=
>u=2Eudp=2Echeck);
+                /* RFC 768: a UDP checksum of 0 means "=
no checksum computed"=2E
+                 * Do not run the incremental adj=
ustment over a non-checksum,
+                 * or we will write a bogus n=
on-zero value into the field=2E
+                 */
+                if (h=
->u=2Eudp=2Echeck)
+                {
+                    ADJUST_CHECKSUM(=
accumulate, h->u=2Eudp=2Echeck);
+
+                    if (!h->u=2Eudp=2Ec=
heck)
+                    {
+                        /* RFC 768: a compute=
d checksum of 0 must be transmitted
+                         * as 0xFFFF (=
one-complement), because 0 is reserved for
+                         * "no =
checksum computed"
+                         */
+                        h-=
>u=2Eudp=2Echeck =3D 0xFFFF;
+                    }
+                }
    =
         }
         }
     }

-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1681?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I4068bf8175c23151298d142dc920ab89f861a411
Gerrit-Change-Number: 1681=

Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <ra=
zvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>

--3lYmI+zWKoE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1681?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">clinat: do not adjust UDP checksum if zero=
<br><br>As per RFC768, when the UDP checksum is zero, it means<br>it was no=
t computed by the source, therefore any NAT<br>processing along the way sho=
uld leave the checksum alone<br>and not update it=2E<br>Failing to do so wo=
uld result in computing a bogus value=2E<br><br>At the same time, if the re=
sult of updating a non-zero<br>checksum ends up being zero, as per the same=
 RFC, we must<br>store its one-complement (0xFFFF) as zero is reserved<br>f=
or &quot;checksum not computed&quot;, as mentioned above=2E<br><br>Ensure o=
ur Client NAT code follows both rules=2E<br><br>Github: closes OpenVPN/open=
vpn#1037<br>Reported-by: Jeff Salee &lt;jeff@samjackson=2Ecom&gt;<br>Change=
-Id: I4068bf8175c23151298d142dc920ab89f861a411<br>Signed-off-by: Antonio Qu=
artulli &lt;antonio@mandelbit=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1681<br>Message-Id: &lt;20260821182442=2E13542-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg38581=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/clinat=2Ec<br>1 file changed, 1=
7 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/cl=
inat=2Ec b/src/openvpn/clinat=2Ec</span><br><span>index 32c1325=2E=2E372402=
2 100644</span><br><span>--- a/src/openvpn/clinat=2Ec</span><br><span>+++ b=
/src/openvpn/clinat=2Ec</span><br><span>@@ -258,7 +258,23 @@</span><br><spa=
n>         {</span><br><span>             if (BLENZ(ipbuf) &gt;=3D sizeof(s=
truct openvpn_iphdr) + sizeof(struct openvpn_udphdr))</span><br><span>     =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    ADJUST_CHECKSUM(accumulate, h-&gt;u=2Eudp=2Echeck);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                /* RFC 768: a UDP check=
sum of 0 means &quot;no checksum computed&quot;=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                 * Do not run the incrementa=
l adjustment over a non-checksum,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                 * or we will write a bogus non-zero value in=
to the field=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
             */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            if (h-&gt;u=2Eudp=2Echeck)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    ADJUST_CHECKSUM(accumulate, h-&gt;u=2E=
udp=2Echeck);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    if (!=
h-&gt;u=2Eudp=2Echeck)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                        /* RFC 768: a computed checksum of 0 must be t=
ransmitted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                * as 0xFFFF (one-complement), because 0 is reserved for</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
  * &quot;no checksum computed&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                         */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        h-&gt;u=2Eudp=2Echeck =3D =
0xFFFF;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      }</span><br><span>             }</span><br><span>         }</span><br=
><span>     }</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1681?usp=3Demail">change 1681</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1681?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4068bf=
8175c23151298d142dc920ab89f861a411 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1681 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mand=
elbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>

</body></html>
--3lYmI+zWKoE=--


--===============5834863278867425232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5834863278867425232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5834863278867425232==--

