Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DD6606A32A
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cSYPIWDb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=M2lId16P;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MocqeYB4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YdxTjMmP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XJCR53T49UrsCswdfvXsqGUyxC046F/GhJs4RGsZKjE=; b=cSYPIWDbJYJBIPBBtxwdm/McQP
	b3DfKsTtDofW8HgF2JxQ/B0c8Y2CNfYllp8kw4MtfHftbVrroqvaIpG6Z5dLLRBYkZ97qXVzjvHXD
	1rWqpwr+weshEfsvCo2hawP8y2yf0SC0IB9NVj76/tr+E0DjsFN+5CcB/goiV/u/2wcU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSses-0000000062d-2k7z;
	Mon, 16 Nov 2026 09:05:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSser-0000000062X-2RzT
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:05:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DS/cidos4AYzq+IRBwBhO0uAzljNQyNL98z0qcLRZkQ=; b=M2lId16PQTF53aseQZklG81Q6v
 bIOtd7JUgDtm/RcU87fmzqHCxuWJToKcCgmFZvoJXIwS3O4Tt++ZH+I5ztCcTvvtoAnrmGin30BZe
 v4gDBedFY8DfrnOxp36bmiYohSa6si+ZtWY06a3RHaztDuB/m5RLth0Rr3dgs80tjznI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DS/cidos4AYzq+IRBwBhO0uAzljNQyNL98z0qcLRZkQ=; b=MocqeYB4q6GFr0omo+ySy8fGYU
 KdAa4qYXg43Cba924S/B+bLDYtGSLIRjgmQcjqUtGzd8F4MlmOvfYJmfmhydXFQ7LInjJUwqePjJp
 +uWJ+EDqpp+ikZCetqDQjGuaipOMaOe5nJ+C7cVXut3F/oBOrJ4mgf5uHS413ABCF2bU=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSsep-000000000HL-2YEA for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 09:05:49 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so25138155e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 01:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794819941; x=1795424741; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DS/cidos4AYzq+IRBwBhO0uAzljNQyNL98z0qcLRZkQ=;
 b=YdxTjMmPc35zcvMyhV27XmvupTnpno1ZOTAb4p4fTJt2MwSyxrpl0tkgxO/NmVQfyt
 v2A9KHT/1C/uiXd5QJVJXsepSfTuUiBRGF8BfjGVb8OKabm9gvrWNt80N632hHTTdiEG
 eUclq7I1JSKABizPx1N1lPAsb0d4wuK3+57PQjGbX2cu+yL9lNzHedBcCsCaaPAtH6q9
 ftuGyRULFF3UMiQmHAxmBkbdiiKs4llMQ7UKlxCawHHJJtLVpnJvP+bzQBJNyfz1HcLu
 vVabIDPbc+y7eIADjx5Crnt+kI3XL9vyS3aE6bVS4MTW6IN+Ofb/y/V8W+Sl7FxgbjnQ
 B6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794819941; x=1795424741;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DS/cidos4AYzq+IRBwBhO0uAzljNQyNL98z0qcLRZkQ=;
 b=vIY2GQxZO5vKGorliCkRJUSXBblsMkXCTdYh/5sbxyIlHgxPqv1XRiPcpzk3O8rQwH
 XaS3jTBwa8myaRfQ9t9MtVVD5KbAvXBjSwv4I5O9+ccAdHao/B1vMO/HPcX3xRrQnLVq
 K2ah/AxzwFrhtgtp4fBT6Ecxo/slca3QOBTRwPzBv2DP+W44C4PaSlQrZuL+Bh6cXQCG
 5QgdzRJkehp5kHk9Nv/uGta+DnOptb524ohdH6UqzWpfq3VBVusAjA+OY+Yzktm6L16h
 KEK4jLSN2GebXORsmm7VUIfvU+mkw0l419ooOU5OAszF/8kLHucz3iHlT90lZR3AG/E2
 4Cmg==
X-Forwarded-Encrypted: i=1;
 AL+hErF/QTEZgOLQG6o6ASWaXn7oJpMtXdlHiL6a2QqxDTrT4OTG60qEjiYVG3c1SjmkpdrZvEjRxoBND7AG8fbI@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/ziVXDKijv5aqxoh0CkXviJRtu6bFMa/7iuTCbyOraO6KRKq4L
 D+4fHhR+g65xN7N5hxHdcsqP9e/MZeaWpZzXzI4ocQZQK9xUDqxTAgqQZ/Qey5uPcYBvkynIpwo
 lYmSTAtqvVWTm1Uay9fcF2QRkN31LFkjQgp+v0olRYqnEk7U+dGS0asbm8m7aIDZfapQ7
X-Gm-Gg: AYBFou1fTA2tX16yRzKIqDVS2uxz6j/8JgW9KonSFX82J32WSWxtkSe65Pd0hrZTiAW
 TNpxPR0REu4fAraJoGt6KJasGKSul7JM/54NosbRcKdzlb75eigW/PQV+tjx8TS9WkQcR6/QsE6
 7OVpv047a5Zek/qapLINUzvcTQBoUEXwqhGsYpfceEh4++Rax7iKOZ63SvG+zmhxXF5Qzx/0q2N
 xdroJLnAg6sSI2V+J1+ZVfIC0fx5T6oTOA09GRlpG1cFKH75KoJPDvOZY83Mcl6dk3tdfAzzgsx
 kkGcOW20c7d/qPuvGKKSIfk+xezbpLWhEczzn668RSHXpJiYEaQJ0UQDc8Lhl/ukl/B9JxopXrz
 R2/Wq9UQHFXPw3wksOHNlxbl7y3S+WIG5PvG06sQ1QCijFb+VE2g77IpCCaMMvLmhyZiSIk2ZQ8
 6+U79a0VrRnAiTYCRtnSu0kv6bMb3QLi971qaRkLaVTPcM3iucVSk8zw2jMn7k/w8Dq+BEp5pO+
 S1OwrkqOTvz1ShAwaQF1o3tq7FS9EcGfIv8AY/JTJBgcLdUKaexi7hiXRqOxGUA6Ps4uNdizawq
 8Gl7RrQsW8Wz0S5NnD0gMU8t0TdNk7z8/WzMeGNv0iyJIeqYHG+oQkHYjJQacuzhzF2NOHSEq4T
 d9PxTLF21f8pAPjMU+tYk0hT9+3MaWRuBWu8zS1VMDeEjknrIlIS8Sa12rVcDTIYyaEFmVcRgAF
 TmqHU/PZTtVx7Ep/PfZdn9wUBcikNIySppg6xJ
X-Received: by 2002:a05:600c:8819:b0:4a1:d8fc:8165 with SMTP id
 5b1f17b1804b1-4bb55a6ad4emr188059155e9.20.1794819940751; 
 Mon, 16 Nov 2026 01:05:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ac0e1esm248716755e9.3.2026.11.16.01.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:05:40 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 09:05:40 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I272f840b547dde968ceca2c24de5a922f0721149
X-Gerrit-Change-Number: 2185
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2185?usp=email>
X-Gerrit-Commit: f5329ed2623e0bd148c43e0cdfef8bec6e998010
In-Reply-To: <gerrit.1794756855000.I272f840b547dde968ceca2c24de5a922f0721149@gerrit.openvpn.net>
References: <gerrit.1794756855000.I272f840b547dde968ceca2c24de5a922f0721149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NzU2ODU1MDAwLkkyNzJmODQwYjU0N2RkZTk2OGNlY2EyYzI0ZGU1YTkyMmYwNzIxMTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fada26609b2cb8075b673cc2f282f25a39ae217b-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSsep-000000000HL-2YEA
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun: drop no-op
 IFF_ONE_QUEUE on Linux
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1864132622601562676=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1864132622601562676==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T2CGrYiHWhk="; charset=UTF-8

--T2CGrYiHWhk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2185?usp=3Demail )

Change subject: tun: drop no-op IFF_ONE_QUE=
UE on Linux
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t=
un: drop no-op IFF_ONE_QUEUE on Linux

The kernel ignores the flag since Li=
nux 3=2E8, commit 5d097109257c ("tun:
only queue packets on device")=2E Als=
o drop its guard around the
--txqueuelen code, since SIOCSIFTXQLEN is alway=
s available, and the
stale --tun-ipv6 comment=2E

Drop the outdated kernel =
version and init script note from INSTALL=2E

Change-Id: I272f840b547dde968=
ceca2c24de5a922f0721149
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2185
Message-Id: <20261116080609=2E440-1-g=
ert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg41384=2Ehtml
Signed-off-by: Gert Doering <ger=
t@greenie=2Emuc=2Ede>
---
M INSTALL
M src/openvpn/tun=2Ec
2 files changed, =
3 insertions(+), 15 deletions(-)




diff --git a/INSTALL b/INSTALL
index d=
0ffaf0=2E=2E0484e98 100644
--- a/INSTALL
+++ b/INSTALL
@@ -226,13 +226,10 @=
@
 
 TUN/TAP Driver References:
 
-* Linux 2=2E6 or higher (with integrated=
 TUN/TAP driver):
+* Linux (with integrated TUN/TAP driver):
 
-  (1) load =
driver:              modprobe tun
-  (2) enable routing:           echo 1 >=
 /proc/sys/net/ipv4/ip_forward
-
-  Note that (1) needs to be done once per=
 reboot=2E  If you install from RPM (see
-  above) and use the openvpn=2Ein=
it script, these steps are taken care of for you=2E
+  (1) load driver (onl=
y if /dev/net/tun is missing):  modprobe tun
+  (2) enable routing:  echo 1=
 > /proc/sys/net/ipv4/ip_forward
 
 * FreeBSD:
 
diff --git a/src/openvpn/t=
un=2Ec b/src/openvpn/tun=2Ec
index 70fdd7e=2E=2E0ba8a4a 100644
--- a/src/op=
envpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -2123,16 +2123,9 @@
            =
 msg(M_ERR, "ERROR: Cannot open TUN/TAP dev %s", node);
         }
 
-     =
   /*
-         * Process --tun-ipv6
-         */
         CLEAR(ifr);
    =
     ifr=2Eifr_flags =3D IFF_NO_PI;
 
-#if defined(IFF_ONE_QUEUE) && define=
d(SIOCSIFTXQLEN)
-        ifr=2Eifr_flags |=3D IFF_ONE_QUEUE;
-#endif
-
 #i=
fdef IFF_BACKPRESSURE
         ifr=2Eifr_flags |=3D IFF_BACKPRESSURE;
 #end=
if
@@ -2175,7 +2168,6 @@
         /*
          * Try making the TX send que=
ue bigger
          */
-#if defined(IFF_ONE_QUEUE) && defined(SIOCSIFTXQLEN=
)
         if (tt->options=2Etxqueuelen)
         {
             struct ifr=
eq netifr;
@@ -2201,7 +2193,6 @@
                 msg(M_WARN | M_ERRNO, "No=
te: Cannot open control socket on %s", ifr=2Eifr_name);
             }
    =
     }
-#endif /* if defined(IFF_ONE_QUEUE) && defined(SIOCSIFTXQLEN) */
 
=
         set_nonblock(tt->fd);
         set_cloexec(tt->fd);

-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2185?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I272f840b547dde968ceca2c24de5a922f=
0721149
Gerrit-Change-Number: 2185
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ed=
e>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--T2CGrYiHWhk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2185?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">tun: drop no-op IFF_ONE_QUEUE on L=
inux<br><br>The kernel ignores the flag since Linux 3=2E8, commit 5d0971092=
57c (&quot;tun:<br>only queue packets on device&quot;)=2E Also drop its gua=
rd around the<br>--txqueuelen code, since SIOCSIFTXQLEN is always available=
, and the<br>stale --tun-ipv6 comment=2E<br><br>Drop the outdated kernel ve=
rsion and init script note from INSTALL=2E<br><br>Change-Id: I272f840b547dd=
e968ceca2c24de5a922f0721149<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@m=
ailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<=
br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2185<br>Message-I=
d: &lt;20261116080609=2E440-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41384=2E=
html<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<=
br>M INSTALL<br>M src/openvpn/tun=2Ec<br>2 files changed, 3 insertions(+), =
15 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/INSTALL b/INSTALL</span><br><=
span>index d0ffaf0=2E=2E0484e98 100644</span><br><span>--- a/INSTALL</span>=
<br><span>+++ b/INSTALL</span><br><span>@@ -226,13 +226,10 @@</span><br><sp=
an> </span><br><span> TUN/TAP Driver References:</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-* Linux 2=2E6 or higher (with =
integrated TUN/TAP driver):</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+* Linux (with integrated TUN/TAP driver):</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  (1) load driver:           =
   modprobe tun</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (2) =
enable routing:           echo 1 &gt; /proc/sys/net/ipv4/ip_forward</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  Note that (1) needs to be done once per reboot=
=2E  If you install from RPM (see</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  above) and use the openvpn=2Einit script, these steps are tak=
en care of for you=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  (1) load driver (only if /dev/net/tun is missing):  modprobe tun</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  (2) enable routing:  ech=
o 1 &gt; /proc/sys/net/ipv4/ip_forward</span><br><span> </span><br><span> *=
 FreeBSD:</span><br><span> </span><br><span>diff --git a/src/openvpn/tun=2E=
c b/src/openvpn/tun=2Ec</span><br><span>index 70fdd7e=2E=2E0ba8a4a 100644</=
span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/=
tun=2Ec</span><br><span>@@ -2123,16 +2123,9 @@</span><br><span>            =
 msg(M_ERR, &quot;ERROR: Cannot open TUN/TAP dev %s&quot;, node);</span><br=
><span>         }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-         * Process --tun-ipv6</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-         */</span><br><span>         CLEAR(ifr);</span><br><span=
>         ifr=2Eifr_flags =3D IFF_NO_PI;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(IFF_ONE_QUEUE) &amp;&amp; =
defined(SIOCSIFTXQLEN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        ifr=2Eifr_flags |=3D IFF_ONE_QUEUE;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span> #ifdef IFF_BACKPRESSURE</span><br><span>         =
ifr=2Eifr_flags |=3D IFF_BACKPRESSURE;</span><br><span> #endif</span><br><s=
pan>@@ -2175,7 +2168,6 @@</span><br><span>         /*</span><br><span>     =
     * Try making the TX send queue bigger</span><br><span>          */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(IFF_ONE_QUEUE=
) &amp;&amp; defined(SIOCSIFTXQLEN)</span><br><span>         if (tt-&gt;opt=
ions=2Etxqueuelen)</span><br><span>         {</span><br><span>             =
struct ifreq netifr;</span><br><span>@@ -2201,7 +2193,6 @@</span><br><span>=
                 msg(M_WARN | M_ERRNO, &quot;Note: Cannot open control sock=
et on %s&quot;, ifr=2Eifr_name);</span><br><span>             }</span><br><=
span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
 /* if defined(IFF_ONE_QUEUE) &amp;&amp; defined(SIOCSIFTXQLEN) */</span><b=
r><span> </span><br><span>         set_nonblock(tt-&gt;fd);</span><br><span=
>         set_cloexec(tt-&gt;fd);</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2185?usp=3Demail">change 218=
5</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2185?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"disp=
lay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerr=
it-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I27=
2f840b547dde968ceca2c24de5a922f0721149 </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 2185 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2E=
de&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--T2CGrYiHWhk=--


--===============1864132622601562676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1864132622601562676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1864132622601562676==--

