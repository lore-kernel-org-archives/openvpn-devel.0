Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D3A606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IRJiuAcd;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Jocra+WR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=H2ZONBOu;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ABCD13/F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Wmy6AGzUw++q248dXn2sqGCatWJmX+Jge1Nz8fWKxLI=; b=IRJiuAcdb95gr7GNvcwc/jFOSk
	CLJyo5AbFL/kGcLlwYl0yLDtrS65L1NUYZd7sBd1LmHiYK1qj7wDyHDxMEv+yqvgwN2NuvvdpTQnA
	b8+w3IOKw3Oe9siMjQ6l9ywxo2PCIAsv5g3CmjIzjDIxjf/LThhlqrvnp9U+aux3xm0M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVYxI-000000005YY-2siw;
	Mon, 23 Nov 2026 18:39:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVYxH-000000005YQ-398c
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:39:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8u/MXmIqpNHUXJLZ6CWWA0jRt5FB61+76DS0ULd5vng=; b=Jocra+WRs3jk9RD8PWXMDWtftG
 W7WqBVdSoWzB5v+IZN6gMKe2hsG2nMeWkebYwdodlvHyDBOvu0fpoliupYQdLCssI780nXkkHxho5
 RVOsHxtLINNm7sQjqruyk6zPNI/kybpTSReB+2pYEBBr/dyysxhtZM5jU1q2by+H/72Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8u/MXmIqpNHUXJLZ6CWWA0jRt5FB61+76DS0ULd5vng=; b=H2ZONBOuoBTZvp2d9a2d9XcB6p
 Qs6baPyIVswpvTY7B+nfwIbQL8p7eXaSXPjfjXf+cGQaJfq/ttdSKQgCdvvbNgH34C4Sajaqgn9n0
 OyeYyyI+cvGsAnjKsVazAyGLNJ/PLGKU7iJfi54ZAAevlWpc9st9zJsamvamaxwClnd4=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVYxG-000000003iN-0ylU for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:39:55 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4acb44dcd7bso3047705f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 10:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795459188; x=1796063988; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8u/MXmIqpNHUXJLZ6CWWA0jRt5FB61+76DS0ULd5vng=;
 b=ABCD13/FJpOPWNkXDM57+KH5+rhSZHG0CMgxFwb1xUAOBskm56kSuKrav/QMb4jxn/
 Ur5W8Fk3yut2N5SXya7ddWITntsivDj/K5aWmzNB3R5qRd/Gp/AOkBbBFLNv0Qb5ou0/
 jEMpvb/pTOHPPakvkVVdOCIxy7l8kLCjwxMDpXIvzfpGfCJHgQEf+8bfHa5XnW/iZMkL
 IU5uzFhIk2Dd+kNgDrBVVsgU/8RhfkpMjUKUwkvyTlm3S8xuwdvNlNYpLEQEdogGmR9g
 tBUoTby07JOSvhwmXOiOIhnlRDdLN9o8s1inbYpQxpnUij4+q/VrQaHIRwaVhh0k5xSu
 NkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795459188; x=1796063988;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8u/MXmIqpNHUXJLZ6CWWA0jRt5FB61+76DS0ULd5vng=;
 b=BeDfhhnovOL0+l1XZGDrSKQ9O5UYzgou8VzTexVdK4HHEmHYP+GH4Y3nMI22TsjRuF
 5kE0HWRDIXr2QYs2VjoJg+xRf52N/5wZ1y28K49BTW5fFZUtTLpYzg1MkGm9VR/1mxYf
 VFNISa70Bxgyb4pleHW4mjFfzZgC7PCnLx3HWvTz2aQ4Ht48tvax/aNho0d14IfGi2Ep
 DAv8iqKyDaWnGNIwM/26FWYR7o4Z4G2Z4isrbjskf58yRrKZADw3HGUqRAFhFXeWeaL/
 JaVaPqiev/4Lnr/J407/5YpA6MpbHdb/Z41CRnxJ8D8Hpo3LiY0og6yZUpiuNx9+x2JI
 25ag==
X-Forwarded-Encrypted: i=1;
 AL+hErGwjb20bKMliHt5PSkifLRe3lfelUV21mM5A76rJR31e5GTcW3rhhIX6zHMtD9bETgehL5tuIO4ioOnL53i@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8TyO0Wy/bJefQ1E6FLgGSWTGshoPetzp2mFhVifLllAnKLaGN+
 s3RweEDWffjonQ0zvVdrHpqBevxM9Kis23MBWKrtPAquKuzaOFPRAPAuCOU/5BAPefveeq9ZJ/w
 evzjfbMisIX8VYZjEI/UmnY/EkLuD3n9wByx+BA4VYKGvDE46UVQbMylVJ5XliQPBoF0Z
X-Gm-Gg: AZFdTZcqjSAMFhTOTV35KgzH1Cf8nyW0+GiMB+5nax6xyLYeh+I9uplVwNk9FnlSusa
 Qel8VgcZZz26JQ/vaNbSMPvsZUqlyeBU6omWYJLP/j5RdEDZxJ9ka/XxjYjmT9WBb+ydaRMSJuy
 ZNCTn/fOH2Dv86rL12QAQDjjcQ8Fm43thxU4drD8QmwtzQF255iktT+GEtxtLHjm8IiR4XGlze3
 9i2PN+YXEPoaO0WIP2bwAyrkQvW2Fj7EIQ7Hm3GIt3MfaI94JY+hDTYejZg1R5We988tXozHiPe
 zeieeUg3TlS3IdT/GGRPMxBZAqgUPxierdTlqb3P73+KxL//xNVXExDeuOS17ktiBvdR6P/GYam
 eSQVB0jv9CJvnmn99qgNLLJE1d+shilwMu709Z2t9CA539/KSa10KD45+4Ciq5FPRih997355F7
 rw8Dosamd519+tu9e1iXW50ezT8eHQBPBn7DgvehcqY0Py9U3SFvaj7PfE24kbqJhanbvQNowE7
 oftb8CrNheqAMW/7IU/AUG1Kj70QDPP1yUsSyC0H7RkFfCXypo+qp5G6LeIRCszz+SxJ2fn1yyw
 C2HtwshD4HXnGbgSgY5fwJF/zD2SKQ+yKcmGuRiQZBMJOigAkWrHKVvlVUC9ST3vTUGs7+Bna3K
 XQmu4QYCxFPOFkNdsD/BwHtmUZwxbLDa8r45COF/oRg0nCeU4VfNtJMy9sS+p0G+V1T28DSFvSp
 9vH0GsbHnwJgKvP1AvaKVkyNIVVeVmUBf/zqj2Hw==
X-Received: by 2002:a05:600c:4f10:b0:4bb:60bd:5398 with SMTP id
 5b1f17b1804b1-4bb88804d35mr283065625e9.10.1795459187519; 
 Mon, 23 Nov 2026 10:39:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b8429sm577637955e9.14.2026.11.23.10.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:39:47 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 18:39:46 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I58b88ca3934e52cfc5140a564c9ed7260857ce80
X-Gerrit-Change-Number: 2238
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2238?usp=email>
X-Gerrit-Commit: f7d89f63de3c40c24bb00e7894a882261c11c130
In-Reply-To: <gerrit.1795353062000.I58b88ca3934e52cfc5140a564c9ed7260857ce80@gerrit.openvpn.net>
References: <gerrit.1795353062000.I58b88ca3934e52cfc5140a564c9ed7260857ce80@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MzUzMDYyMDAwLkk1OGI4OGNhMzkzNGU1MmNmYzUxNDBhNTY0YzllZDcyNjA4NTdjZTgwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a3e69ab5f40586dc67b465574e82be35bbe74ed3-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVYxG-000000003iN-0ylU
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: drop
 redundant NULL checks
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7357568705335329853=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7357568705335329853==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1JNldWo/PTM="; charset=UTF-8

--1JNldWo/PTM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2238?usp=3Demail )

Change subject: manage: drop redundant NULL=
 checks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mana=
ge: drop redundant NULL checks

man_need() already guarantees p[1] for log =
and echo, and
up_query_type is non-NULL once "needed" holds in
man_query_pa=
ssword_base64()=2E

Change-Id: I58b88ca3934e52cfc5140a564c9ed7260857ce80
Si=
gned-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2238
Message-Id: <20261123134906=2E31644-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg41822=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/manage=2Ec
1 file changed, 3 insertions(+), 9 dele=
tions(-)




diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
i=
ndex 112db4a=2E=2Ed63d53b 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/ope=
nvpn/manage=2Ec
@@ -1051,7 +1051,7 @@
         msg(M_CLIENT, "ERROR: no pas=
sword is currently needed at this time");
         return;
     }
-    if (=
!man->connection=2Eup_query_type || !streq(man->connection=2Eup_query_type,=
 type))
+    if (!streq(man->connection=2Eup_query_type, type))
     {
    =
     msg(M_CLIENT, "ERROR: password of type '%s' entered, but we need one o=
f type '%s'",
             type, man->connection=2Eup_query_type);
@@ -1665=
,10 +1665,7 @@
     {
         if (man_need(p, 1, MN_AT_LEAST))
         {
=
-            if (p[1])
-            {
-                man_log(man, p[1]);
=
-            }
+            man_log(man, p[1]);
             if (p[2])
    =
         {
                 man_log(man, p[2]);
@@ -1679,10 +1676,7 @@
    =
 {
         if (man_need(p, 1, MN_AT_LEAST))
         {
-            if (p[=
1])
-            {
-                man_echo(man, p[1]);
-            }
+  =
          man_echo(man, p[1]);
             if (p[2])
             {
      =
           man_echo(man, p[2]);

-- 
To view, visit https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2238?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I58b88ca3934e52cfc5140a564c9ed7260857ce80
Gerrit-Change-Number:=
 2238
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbo=
x=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>

--1JNldWo/PTM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2238?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">manage: drop redundant NULL checks=
<br><br>man_need() already guarantees p[1] for log and echo, and<br>up_quer=
y_type is non-NULL once &quot;needed&quot; holds in<br>man_query_password_b=
ase64()=2E<br><br>Change-Id: I58b88ca3934e52cfc5140a564c9ed7260857ce80<br>S=
igned-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Fr=
ank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2238<br>Message-Id: &lt;20261123134906=2E316=
44-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg41822=2Ehtml<br>Signed-off-by: Ge=
rt Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/manage=
=2Ec<br>1 file changed, 3 insertions(+), 9 deletions(-)<br><br></pre>
<pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>=
index 112db4a=2E=2Ed63d53b 100644</span><br><span>--- a/src/openvpn/manage=
=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -1051,=
7 +1051,7 @@</span><br><span>         msg(M_CLIENT, &quot;ERROR: no passwor=
d is currently needed at this time&quot;);</span><br><span>         return;=
</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (!man-&gt;connection=2Eup_query_type || !streq(man-&gt;connection=
=2Eup_query_type, type))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!streq(man-&gt;connection=2Eup_query_type, type))</span><br><s=
pan>     {</span><br><span>         msg(M_CLIENT, &quot;ERROR: password of =
type &#39;%s&#39; entered, but we need one of type &#39;%s&#39;&quot;,</spa=
n><br><span>             type, man-&gt;connection=2Eup_query_type);</span><=
br><span>@@ -1665,10 +1665,7 @@</span><br><span>     {</span><br><span>    =
     if (man_need(p, 1, MN_AT_LEAST))</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            if (p[1])</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                man_log(man, p[1]);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            man_log(man, p[1]);<=
/span><br><span>             if (p[2])</span><br><span>             {</span=
><br><span>                 man_log(man, p[2]);</span><br><span>@@ -1679,10=
 +1676,7 @@</span><br><span>     {</span><br><span>         if (man_need(p,=
 1, MN_AT_LEAST))</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            if (p[1])</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                man_echo(man, p[1]);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            man_echo(man, p[1]);</span><br><span>=
             if (p[2])</span><br><span>             {</span><br><span>     =
            man_echo(man, p[2]);</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2238?usp=3Demail">change 223=
8</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2238?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"disp=
lay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerr=
it-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I58=
b88ca3934e52cfc5140a564c9ed7260857ce80 </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 2238 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--1JNldWo/PTM=--


--===============7357568705335329853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7357568705335329853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7357568705335329853==--

