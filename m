Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E54606A321
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eJQ8eduC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ATYCFeqF;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=chOOvYu3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bMeZ+0Rs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vVtAS8Wjc8pzNfxZ/Guitghz+wQfoPcsKSsdyAqZfVw=; b=eJQ8eduC7R5YAhdcAv3rlCxsUw
	SrUHxorIzG9yQ+CqPHGrMVsVNgpb3nh5nBq7pXvcjQY2AIc65qo4D2Er03NQixu/793GwybmRtuyn
	Dqtc6S38W6UK/19X58/Y3gQELIx2WSuZUn38SBc7S1hw5VDVvcQI0xp8Zi8owdP9AdEI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVTgg-00000000230-31rG;
	Mon, 23 Nov 2026 13:02:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVTgK-0000000022S-15l1
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 13:02:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yajGEGX86Ef+qKmejshhvhDN91H1hKkOGzsNU0hlkmU=; b=ATYCFeqF5NQ3S1BXeRAkYnT40u
 jLJAnEGjcm6opfre1crtoOoOxQWofoEV9hHADCqs0A2mQdrnsiASgfSOBDkthCtHe2r+OovpkL0kU
 9bjTWJ85h2Nu+DK8+gcCiXJ2nvchsPME96Si+Kjk05/Jbjb807cvKlDcNdtwqKCv2dD0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yajGEGX86Ef+qKmejshhvhDN91H1hKkOGzsNU0hlkmU=; b=chOOvYu3bNPJ7pmubkIrCnzslW
 zNeig8hCqaD69FFN15+LDUsRo2QUiNykkVkqT0J0C2FpuIRbkNwvGghGWKwaPMZ4k8e8++XNrKibP
 Hwr0QV8YXtqFWdoUVuJsupxSHPo+SYLrEw5UiTjaVFeWDFXuRpdMFdpZQP8WHIo6eJek=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVTg4-000000001dY-2XcB for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 13:01:51 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so1906107f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 05:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795438902; x=1796043702; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yajGEGX86Ef+qKmejshhvhDN91H1hKkOGzsNU0hlkmU=;
 b=bMeZ+0RsINGPbaAo32SCzzkzID7h0E56c9NYiEBFRnBV+LO6f1F/U1yrmyy9vsp79n
 ZKfG7z+V42Yvp2BJaWlqvUDvirh0kYxYXugKulAFcrV1v2dAPAZIk7ikUekRD3Iqor1z
 17AH/rVsThxcoMz3sUJ0zFd2Af8qQXbVvEOtDJOZy5yDqV5gsk70Qp9YZ0ZjCptCOZac
 p2FJ5aZF0Epz69FJSyxGcdMOrtg6kx3tQle3qXuhnZ7Xx3q02HoCowUl//K7bTqDK3SI
 WreqZpZJoehN0Lnqd4+jhGdNRaePx4fmZ0Plfqe07INdBvfoDgSth8qs64kbhkucw9uF
 xPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795438902; x=1796043702;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yajGEGX86Ef+qKmejshhvhDN91H1hKkOGzsNU0hlkmU=;
 b=TLJ3R4s0QD1sElXWqdOLMtWEHrOmEmkWfIaOlvmPmewWfhnSbxYsk+ZaQ0+Pmpwpm3
 JmA4w1mqr3oaO1JBVPYshCBKFUfHaVDQSR1mlAt0SvaCvsjO0N4zuF9c6ziVC1rh9h0x
 Ps2PYnk6Q1pO3yTE2ZPd5Hzd6tmtWfBhcczC2cpojh9Jkp8pPbKE8VWcbVqkaweJB8Z8
 0XBZqLvc42efxqvTSoNACf02AkW7m4cJjjE/dw+0RR7LYl1lBsilzAEtbqXnR6Y844u3
 uCmiVNEJOoE14o2xN3K5XsoDgx08XovlTjWSsp2amgs93Wbx/9HA1Jj3idfhXSIdAKl7
 02Mg==
X-Gm-Message-State: APuU4Z8Q556EirhOnB+1Uyk0qEam3bathnrqGJUbVcoNC23+xa+FUtR+
 cb/lJ2LqqCbJ2zxLsfsYKN2hKXBZpqrPGJXnCUDqKR7VPhpZ93lzwjM5tuIuiqsfNwN/vD0rFIO
 tCMzI/Op9PaSElvGge3z3UMtoJtZZ4YRPzjtsEJKe8y9GS//HTL2bUD4jbUDro1/wpb3+
X-Gm-Gg: AZFdTZfPbKXtgHsFFR9ISoXh00vdhIb4WOulIrMJlC3/5rEW3d8fxWorGXHcv3VqeaW
 AWudV9Ul9gvK2VO7CzwbUHHv1e8AlLy1h4BKYndAx4Q/y7GS5DT1LzwKyj9bm8nBEgCN9SdeWt6
 7/orX1j53fMQM7lIrgopM3neNfl1Akh1TUvW0bvKtJCEuup6mDv292VZbG1P1tjleVE34oHTh2F
 iPim9uuaBpWC+ovGR9oC0Bq+guMb04OYKC5LqoFAzJFNa7a8P5itwFZjLsg35Nt0TWiV0OYnkTz
 kWAO7UqGCXYVRVr96nktx8zAI/hHXMqKvtc5NwEgQ5nqhj4Mbfxiy7/jFvxMkxVxaM3SFRW86cA
 CU1JY4PuxvjOLMgLEVRtODSBNUwhH31vjYDyc1cHzlmHYFgJNslvY7COlcjl1yCEIQG//f5unF4
 Z3f+biWgA3S1i8zkbmvK3bF+UIOOaPqFeS9I9TJpNS6R24PF+RxFkLVjS9woBPS076DI3OofojZ
 Vc+Z+6NGtHlaLKtV0rFlz5Mn/18smiRewOde6LnW99zaiHsY+K72Nynt04CCtdv2oXSD60Wn2zE
 nWi9lPX2gmwIs10B9FNn2ihluleMBneihFQ0Isg0mbtb3DTi2rgav/YfesP34p88PjHGUv3tkBc
 DyM7Wa5+SE7ECbY42MXAsmzBAjlzJj581E2KMdZL53gGHWpQIccD/NNaRwzHvOBbVPyOor+XJCg
 Pe/bXC+LIQVyIeQu24
X-Received: by 2002:a5d:5d08:0:b0:4a6:4f91:284c with SMTP id
 ffacd0b85a97d-4abb83116bdmr24630012f8f.51.1795438901845; 
 Mon, 23 Nov 2026 05:01:41 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf630esm22875886f8f.16.2026.11.23.05.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 05:01:41 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 13:01:40 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I48d315a38a653aed4b33d3277433cb8a6596942d
X-Gerrit-Change-Number: 2237
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2237?usp=email>
X-Gerrit-Commit: a7ad863b2d13ed0d364704d5ae9223502a6f765b
In-Reply-To: <gerrit.1795250594000.I48d315a38a653aed4b33d3277433cb8a6596942d@gerrit.openvpn.net>
References: <gerrit.1795250594000.I48d315a38a653aed4b33d3277433cb8a6596942d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjUwNTk0MDAwLkk0OGQzMTVhMzhhNjUzYWVkNGIzM2QzMjc3NDMzY2I4YTY1OTY5NDJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2bc5f59abad79c096c8274cb5c07cdd49875b31b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVTg4-000000001dY-2XcB
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: free
 ext_cert_input in man_connection_close()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8385390799417936095=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8385390799417936095==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Zgm0fkxy7CY="; charset=UTF-8

--Zgm0fkxy7CY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, Frank Lichtenheld, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2237?usp=3Demail

to look at the new patch set (#2)=2E

The foll=
owing approvals got outdated and were removed:
Code-Review+2 by Frank Licht=
enheld

The change is no longer submittable: Code-Review and checks~ChecksS=
ubmitRule are unsatisfied now=2E


Change subject: manage: free ext_cert_in=
put in man_connection_close()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

manage: free ext_cert_input in man_connection_close()

ext=
_key_input was freed there, its certificate counterpart was not=2E
While he=
re, pass mc to in_extra_reset() like the rest of the function=2E

Change-Id=
: I48d315a38a653aed4b33d3277433cb8a6596942d
Signed-off-by: Razvan Cojocaru =
<razvanc@mailbox=2Eorg>
---
M src/openvpn/manage=2Ec
1 file changed, 2 inse=
rtions(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/37/2237/2

diff --git a/src/openvpn/manage=2Ec b/src/ope=
nvpn/manage=2Ec
index 86c498e=2E=2Ea5b635d 100644
--- a/src/openvpn/manage=
=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2860,8 +2860,9 @@
 
     event_timeou=
t_clear(&mc->bytecount_update_interval);
 
-    in_extra_reset(&man->connec=
tion, IER_RESET);
+    in_extra_reset(mc, IER_RESET);
     buffer_list_free=
(mc->ext_key_input);
+    buffer_list_free(mc->ext_cert_input);
     man_co=
nnection_clear(mc);
 }
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2237?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I48d315a38a653aed4b33d3277433cb8a6596942d
Gerrit-Change-Number: 2=
237
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2E=
com>

--Zgm0fkxy7CY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #2</strong> to =
this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2237?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by Frank Lichtenheld</p><p>The change is =
no longer submittable: Code-Review and checks~ChecksSubmitRule are unsatisf=
ied now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">manage: free ext_cert_input in man_connection_c=
lose()<br><br>ext_key_input was freed there, its certificate counterpart wa=
s not=2E<br>While here, pass mc to in_extra_reset() like the rest of the fu=
nction=2E<br><br>Change-Id: I48d315a38a653aed4b33d3277433cb8a6596942d<br>Si=
gned-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/=
openvpn/manage=2Ec<br>1 file changed, 2 insertions(+), 1 deletion(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/37/2237/2</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/open=
vpn/manage=2Ec</span><br><span>index 86c498e=2E=2Ea5b635d 100644</span><br>=
<span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=
=2Ec</span><br><span>@@ -2860,8 +2860,9 @@</span><br><span> </span><br><spa=
n>     event_timeout_clear(&amp;mc-&gt;bytecount_update_interval);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in_extra=
_reset(&amp;man-&gt;connection, IER_RESET);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    in_extra_reset(mc, IER_RESET);</span><br><span>=
     buffer_list_free(mc-&gt;ext_key_input);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    buffer_list_free(mc-&gt;ext_cert_input);</span=
><br><span>     man_connection_clear(mc);</span><br><span> }</span><br></pr=
e><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
237?usp=3Demail">change 2237</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2237?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I48d315a38a653aed4b33d3277433cb8a6596942d </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 2237 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>

</body></html>
--Zgm0fkxy7CY=--


--===============8385390799417936095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8385390799417936095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8385390799417936095==--

