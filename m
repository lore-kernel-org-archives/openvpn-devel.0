Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07830C61DBC
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yelPRCUwKpoZ1Z7vUlWnrfi/v8yh3vlGwvvSDklDEp4=; b=j6jLIazHl9r68Cmxp+vPjlDPUc
	f+iG0ItVyI440vZ+tClJKMJbmJg3gzZD8PYxPCyLs8tFKOl1qfCyOPfpMyVgzcb2nNxj3DwoeULuE
	s4rdXyTsCX1xkFgzafr318MG4az/qaZiSGaKt2ueKXr/r4Yu5VohoVUoK2N6YrT/bjkU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wylhZ-0008E0-II;
	Tue, 25 Aug 2026 07:36:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wylhY-0008Du-5c
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:36:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=z3hFuR6KMqFful5Nydgz+vywf96RhZNxpgFWRUo4Rmc=; b=GdpIvLf8qU+VwtQHzzjV68YHKF
 7QlwMRNZD0LfdXZ/RWPWRDOGKazo+2UPSVPuwlH5V6OcpRF7EAkKITDDH+uvEifmo4Vb5urEDeVpy
 Iw013vKuaEf/Cuw+Y6d8ktCTxggM7fCApHkZHAdmvu/kKlivMrbzYB0hMoiRyFsByekY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=z3hFuR6KMqFful5Nydgz+vywf96RhZNxpgFWRUo4Rmc=; b=g
 9u53nEIzLh+rIlX/mQR4l307IN6pSJU5tzw8OKRaXrOFmq0X/fMY1OqFF2h1gjaOXu5Jvr+1Q7rRj
 It4Z5yDOIWT3RDzbqcP4t6zdU98EfBvFw7KEZBK7+Su7WDDJLkgvviAZ23k5eAqx+AEsubLe1KVcb
 gSinQqNmfOmbePXQ=;
Received: from mail-ej1-f52.google.com ([209.85.218.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wylhU-0000Vu-2B for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 07:36:05 +0000
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c15ca7a7ca9so505972866b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 00:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787643357; x=1788248157; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z3hFuR6KMqFful5Nydgz+vywf96RhZNxpgFWRUo4Rmc=;
 b=clB6Vz5/89wgTlqYv2/PLwdC3+NEiJd5mCUfAQgmSqJ5FrOeU03+1WMqPKwM1oWls2
 7Frn9nLvbNISzrmjzdeIGmKM+PPsos7xaAQc4YXNPLltyQ793XHPy5DSOB+0cYx/Th5U
 WsGSmgKV2uA994m1cPCjsWaYVPasI+ew/5w85RORZVgqxOxTKb+mHqiE6Iv/FMN+zbUQ
 m/nqutL2IdQEpdnx5eF6s/sFgJq2Ja9vIUfOAYuS2T0OpBrWio6Qo/qoBxNvN7kYA6jX
 t6EjHe5MGLZP/GMghXbTChaHRsPOno4Caw8tHxOPMHMTE8r8iPVDNGnk4n5lKTg5wImS
 htKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787643357; x=1788248157;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=z3hFuR6KMqFful5Nydgz+vywf96RhZNxpgFWRUo4Rmc=;
 b=UGbDJONtF/I9DnQO3BiQ8HInWk1MLLCEuNVuqoyHhC/ZNopFBn5wPdml42a1xVI5ax
 gnveEHmjzjmSRiCVdr5/zOdDubCOmVEXXoPmHhSM7YtTYjSO3a7wsfenv8MHg9N5AdBD
 mQVm/+Xhx9jqOCcjXUbmeinrWW2eJcwz9+nCJEw3cCh594sLqkrGJ5GMhZJIGnk4XlKY
 5jmKwP/2JXHl6qrTP8+5efFWmQ58mpDL2njgtZJF72nbeIIGZwvd6Aus/poEgz20e+/l
 ynaipWwHNvMhCXG3po1T9tw0jrALtdkczZWWe1TCk0SkeN6zKxv6HjUwO95vgsr9fBiF
 CiWQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQKlMVzrxq0zhxgvRlVHoqCGIGgZ0dCqJ0YftD0gE/IEJ3/XzziZIKYQnom/j7ABkUKcmi6niRUbMGmF2O@lists.sourceforge.net
X-Gm-Message-State: AFuF++kJNJP10oH0l7oWN3q1gga/0OCEBc+aYF6U2ze1aslcIwtymWuF
 geVh2XHX8mN8L2gCF6/YNRycEEqe/DykHsEg7hxtFCGjj+7K0EvFL29x9Oa9WJ//L3/sE4F7FKq
 XLFKgvfLpoooYmuR5PqQRUm7a1hR17ZxtQDUg9B92lj6epkQbQl0dNgtlV0ba3Xh+HlsAWDHBSm
 tCRsTRGA==
X-Gm-Gg: AR+sD12PyjjTq6F5uk1A+ggU7+4cyiJFlzZvvahGpjxKsvSE4BU3rA31eugO9xl523z
 HqM7jW9Xe4AWvKOQlQYf75ktIEXrh9G5mNhpXafZi4wQEYPQigYDgB0NAe6r1E1PQK5NOmsCQaE
 73rxJgmXLF6QqUgIMCVyezKjJuG/5JfZuV7DIz677NBrni9Kw5RPcbcMDZooPHf+Zuu8dB6p+wW
 lbqu2jeC183PtlP6ddBuqVkPnOg7qW6CotwX8KUTIIM4Y/gPiDvaclhfBhDnIzouh6qK7Qh3jmz
 yYHk7JJ71156ijtYEYqQ19t3MrbXnFJaQ1gu7tHDIoA7aYOyNRc92MnxKfL5n66t8tjZZftd/k4
 I9Q/5XvwnFD7i/YFEmTgIaLni/kbqa50qY+EAvANR4Rdx9Cj/Se9gtrtJ93EjaeODG5hNofv0Hm
 Dx4x/ClK0RFAQl4miAhIJnGj/kbW4hJPKZNZOvyJLFPTdYLSqz45N8HvY1u5joJ2nkp7hW8wCRP
 1j6+uiJVbe90a6bsYU4jCdAf9DYD/SSLZNxaSc8PE7KrVgh5m9SLr0Y7n27INguqWWyUchfSv00
 TuMh6g1jCxVYhywYD8qY3ZonUgzk95ew/9+g6ZsvYLkjS9S59XA=
X-Received: by 2002:a17:906:ba83:b0:c24:47b8:ae5b with SMTP id
 a640c23a62f3a-c24e5c0bc67mr507779666b.22.1787643357276; 
 Tue, 25 Aug 2026 00:35:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f8f2asm1734282166b.36.2026.08.25.00.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 00:35:56 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 25 Aug 2026 07:35:55 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d
X-Gerrit-Change-Number: 1866
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1866?usp=email>
X-Gerrit-Commit: de5381481584165cf83a0b8b423e2efab40ebd9f
In-Reply-To: <gerrit.1787570563000.Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d@gerrit.openvpn.net>
References: <gerrit.1787570563000.Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLklhZDEzYzNiZjczZGJlMDczZTUyZWRlNTA0Y2VkN2ZiMmY2YTliNzFkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5500331b4138e6802a31faa97d51e484100f03b5-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wylhU-0000Vu-2B
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mroute: Remove
 unused functions
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6748431117914928742=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6748431117914928742==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w2aTrI7gW1k="; charset=UTF-8

--w2aTrI7gW1k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1866?usp=3Demail )

Change subject: mroute: Remove unused functions
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mroute: Remove u=
nused functions

Both of these have been unused since commit
1308ccec9f8541=
8b088723bb870855c0a933311b
("Remove support for PF")=2E
The first is ipv4 s=
pecific and very limited in scope=2E
The second is equivalent to just using=
 CLEAR (at least
in actual usage)=2E
So I think both can safely be removed=
=2E

Identified by cppcheck=2E

Change-Id: Iad13c3bf73dbe073e52ede504ced7fb=
2f6a9b71d
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-=
by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1866
Message-Id: <20260824161743=2E2156-1-gert@green=
ie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg38645=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/mroute=2Eh
1 file changed, 0 insertions(+), =
20 deletions(-)




diff --git a/src/openvpn/mroute=2Eh b/src/openvpn/mrout=
e=2Eh
index 639281b=2E=2E9d61b22 100644
--- a/src/openvpn/mroute=2Eh
+++ b/=
src/openvpn/mroute=2Eh
@@ -249,24 +249,4 @@
     dest->v4=2Eaddr =3D htonl(=
src);
 }
 
-static inline in_addr_t
-in_addr_t_from_mroute_addr(const struc=
t mroute_addr *addr)
-{
-    if ((addr->type & MR_ADDR_MASK) =3D=3D MR_ADDR=
_IPV4 && addr->netbits =3D=3D 0 && addr->len =3D=3D 4)
-    {
-        retu=
rn ntohl(addr->v4=2Eaddr);
-    }
-    else
-    {
-        return 0;
-    =
}
-}
-
-static inline void
-mroute_addr_reset(struct mroute_addr *ma)
-{
- =
   ma->len =3D 0;
-    ma->type =3D MR_ADDR_NONE;
-}
-
 #endif /* MROUTE_H =
*/

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1866?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iad13c3bf73dbe073=
e52ede504ced7fb2f6a9b71d
Gerrit-Change-Number: 1866
Gerrit-PatchSet: 2
Gerr=
it-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <ge=
rt@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--w2aTrI7gW1k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1866?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">mroute: Remove unused functions<br><br>Bot=
h of these have been unused since commit<br>1308ccec9f85418b088723bb870855c=
0a933311b<br>(&quot;Remove support for PF&quot;)=2E<br>The first is ipv4 sp=
ecific and very limited in scope=2E<br>The second is equivalent to just usi=
ng CLEAR (at least<br>in actual usage)=2E<br>So I think both can safely be =
removed=2E<br><br>Identified by cppcheck=2E<br><br>Change-Id: Iad13c3bf73db=
e073e52ede504ced7fb2f6a9b71d<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede=
&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1866<br>Mess=
age-Id: &lt;20260824161743=2E2156-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: htt=
ps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38=
645=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<b=
r>---<br>M src/openvpn/mroute=2Eh<br>1 file changed, 0 insertions(+), 20 de=
letions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/mroute=2Eh b/src/openv=
pn/mroute=2Eh</span><br><span>index 639281b=2E=2E9d61b22 100644</span><br><=
span>--- a/src/openvpn/mroute=2Eh</span><br><span>+++ b/src/openvpn/mroute=
=2Eh</span><br><span>@@ -249,24 +249,4 @@</span><br><span>     dest-&gt;v4=
=2Eaddr =3D htonl(src);</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-static inline in_addr_t</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-in_addr_t_from_mroute_addr(const s=
truct mroute_addr *addr)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((addr-&gt=
;type &amp; MR_ADDR_MASK) =3D=3D MR_ADDR_IPV4 &amp;&amp; addr-&gt;netbits =
=3D=3D 0 &amp;&amp; addr-&gt;len =3D=3D 4)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return ntohl(addr-&gt;v4=2Eaddr);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mroute_ad=
dr_reset(struct mroute_addr *ma)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ma-&g=
t;len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ma-&g=
t;type =3D MR_ADDR_NONE;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 #endif /* MROUTE_H */</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1866?usp=3Demail">chang=
e 1866</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1866?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Iad13c3bf73dbe073e52ede504ced7fb2f6a9b71d </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 1866 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--w2aTrI7gW1k=--


--===============6748431117914928742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6748431117914928742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6748431117914928742==--

