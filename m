Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5061606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=K50z6Io9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bTYMR1gG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=c+Ct997l;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=b2XLpsYV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uMskclAjoXD4MoXOEFBxFQu6gbXp6BXUjX97XQDMImA=; b=K50z6Io9ubbjKfNsUwTXc0YxMt
	NyQg4xmh7Qw0iBZI/ukPURsGzDyg4EJFFBRqKRO4toWxkImUdrasjnQ/Xg/7SP/R+qtwQ9t2Hx/P5
	Sp3z1ToVPbLvejshWPZ48FO0qyvR/gjN/0aGs3hb7POcp1gf5dPte8R4MGm+dC3olX1Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWGUn-000000003lB-1eIN;
	Wed, 25 Nov 2026 17:09:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWGUk-000000003l4-3R3j
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 17:09:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LjdIO9sLw3x5YsEl8Q0K0QFltdhDdOYikG1YL46HPFU=; b=bTYMR1gGpqwDMECAiUzenCVJhr
 VwS78nG4swkrjaSZowrBJWNCkYb4tUM4oJig1mr0xfQdgxf2Rdo8pabR9mNwUMPeU1YZ8F51+lxxk
 z6IdWDAsGL7AEmReLy8d5qLVJWP5NMDzgoPT6FTJkjFzL3Jdju4AqrlTJolMmxCTkMJ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LjdIO9sLw3x5YsEl8Q0K0QFltdhDdOYikG1YL46HPFU=; b=c+Ct997lf6furHyFokbTiGCgeP
 xj/RQ6l6ciHJBisUj0vbZqvuzpRK9inViWlLrg7KjTNlZHfrE/ZQPCyOz4HR3TXx3kgvJZWlEOnMS
 HkYPQafc+BuXrQe2gS6M5Kb37juTCw7BHGaXKjme3EEFm7YTkq/taQ4V8utESO4JowTI=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWGUi-0000000085j-0q8u for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 17:09:22 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4a68190a2a7so4975157f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 09:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795626553; x=1796231353; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LjdIO9sLw3x5YsEl8Q0K0QFltdhDdOYikG1YL46HPFU=;
 b=b2XLpsYVSLn+LH6vcccCJHglsbu+5Cw7s02HfD2F2fBzwMbX4X9cHda/Zimham93ON
 ao4bnRtDBhEla/8BS9xMD48KHHoG3L7mZVaiVt/24ce1wUX/6em72TmrO4WPhr1kaHnm
 bvBfLbpInd1F0nUf0n7M6HcUAhS1ij2S4qa746SAoG7SALOjZ7UV9LoZHiGm3UqvLbeO
 fVW/Zvplt6668XIhAUuanbVC7+mLm6W0uvtBkUW3NtdgZrqcMl2d03VZX8WpXfHtrXmv
 q3ZUxOnJZ+f1mvrXt+2HqdEzwt4BSLDyA6Gnp1fMJfFSEyBGWFAxlbk5DiZ+TWDYCxi0
 4vjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795626553; x=1796231353;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LjdIO9sLw3x5YsEl8Q0K0QFltdhDdOYikG1YL46HPFU=;
 b=DDEPMhRmS5EzybvnVOkI0VRslTfu/BqfDMjpcCl6ZnanQUlzbFM5P63n4jrCPyfPAD
 DDVGsdhEJed4vfZ1GozbDUTqQAUniyiNf0SAMJdkCuZEEGFF6vofXLwMtjJWq1yYrvo7
 HjXw/Dhkk3VqMQimIVnvL/NhEVLfpLsnLtfZWOBLGRUjXS1Y7XyG90cvsa6OWO7CCMpn
 Xa/IYwzOJutfbCZcweb7KxJnyGTo2Dbk+ne2CnqvriT6gC/HyevmtQZcwATwIZl+4Jtr
 ZtEPYHq5bpiSmeLJG01rrmU/4obOoOUUVA7ppacgJj96HfiSC3E/1FnchuY7iNLx4hVR
 C4cg==
X-Gm-Message-State: APuU4Z/H2jBMBKAQcXQTmNtAO0yS/x57/R17G53/rvdnefAGFLT/ZmXk
 T03Iai44U+mDXUEQuIvEm0OVHSDF5rAv90lqCYZn9/OrTQkv2zNDO+6zsq06Xd1k+DRECZWQfTx
 tLTcgGz5Ztvq6ymqZ4aFsmYaO8qQpx1HnNvBvpxqMTnkpUYehKUv2bvuy2w2zJ6RZD/mq
X-Gm-Gg: AZFdTZeW2Wk3utmIauspXjMh7GN+/6nyOcLGHLlHY126ZBw1/tWhq2I6+VNmmETvFIO
 ZkmWk5JVsN4BF/fYRXb93XED2M7XNYeBvwUeD4pFhoj6wmdETwXXSWF9naeXNOfnQTHYiQ7TfqD
 NPlZYOHA2Py0TN9zxrcL5IjRUKHnX2BWEsaLmg6v7IYNu9hCCydKFg283txClZEejF5/NECaqAT
 zEagrs+1QWcQWN/u+6h8fKP++E38fFGHo4JDSldeQXQw3RWCI3ZDdpJkpM4q+zwYkimSwIDP8E9
 71uUO9TN1hTMYDyqD/ObwW+GEqqNJv5YVAGBto+h4NffkhI/OihK58nSosyWU6oAjQfAVZaVYCF
 M8mLzOEKHmJPayjvsrb9BFY4s3bbnqjz0/NGyowWwV7akG76PXoqj30Vn26ghu7DHOsQhsQDcxf
 89SUyRDuqyjTwJT4L9+4nkBtFm/S7pQjCIxhSCTU3SZ/Z2fVWrfxnVJqpDBGbW8YuThQ8i8nnNA
 DBuDaFL/issecLPn7sJN0N5wVuk8wVrA8OvciCG/EfNDxxyujljCmMn0eAvXFjSerkWBtk6llBd
 9a41zKoPa5aPAHdgEyUw03knC2oYLrwhZatZKD/nXrTAbVVyqkdnKb7eZx/25CeKBYxSx+ZMvwZ
 V+koh9QByklfy0h0MlI3nuqlC04dftK/ufEcXBgOkaK4AMN4lCXv38LdJ2jO9fOS8HabENVK79U
 mkhx4fCt+kwHCZE8E=
X-Received: by 2002:a05:600c:64c6:b0:4a3:598e:e7a8 with SMTP id
 5b1f17b1804b1-4bb887c2c98mr340250895e9.4.1795626553428; 
 Wed, 25 Nov 2026 09:09:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm981389415e9.4.2026.11.25.09.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 09:09:12 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 17:09:11 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5
X-Gerrit-Change-Number: 2339
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2339?usp=email>
X-Gerrit-Commit: 108da9fba71ade99303d1aef272df58c9b5eb5ef
In-Reply-To: <gerrit.1795538311000.I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5@gerrit.openvpn.net>
References: <gerrit.1795538311000.I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTM4MzExMDAwLkk4N2RkNDFiNjZmN2Q3N2NhYjdhYWY4MGZhOWQ5MDk1ZTQ2YzAzM2Q1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6b1c4d084f27a3e9f044b97ac69ea7f299f16ede-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWGUi-0000000085j-0q8u
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: Fix
 conversion warnings in man_write
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2274741501923121017=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2274741501923121017==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="d3ENz2k8+bg="; charset=UTF-8

--d3ENz2k8+bg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a chan=
ge=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=
=3Demail

to look at the new patch set (#3)=2E

The change is no longer sub=
mittable: checks~ChecksSubmitRule is unsatisfied now=2E


Change subject: m=
anage: Fix conversion warnings in man_write
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: Fix conversion warnings in man_writ=
e

Use openvpn_send to avoid warnings due to
Windows/Unix differences=2E

C=
hange-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5
Signed-off-by: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/manage=2Ec
1 file cha=
nged, 4 insertions(+), 13 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/39/2339/3

diff --git a/src/openvpn/manag=
e=2Ec b/src/openvpn/manage=2Ec
index bbf454a=2E=2Ecdd9501 100644
--- a/src/=
openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2448,11 +2448,6 @@
 
 #=
endif /* ifdef TARGET_ANDROID */
 
-#if defined(__GNUC__) || defined(__clan=
g__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-c=
onversion"
-#endif
-
 static ssize_t
 man_read(struct management *man)
 {
@=
@ -2550,14 +2545,14 @@
 static ssize_t
 man_write(struct management *man)
 =
{
-    const int size_hint =3D 1024;
+    const size_t size_hint =3D 1024;
=
     ssize_t sent =3D 0;
 
     buffer_list_aggregate(man->connection=2Eout=
, size_hint);
     const struct buffer *buf =3D buffer_list_peek(man->conne=
ction=2Eout);
-    if (buf && BLEN(buf))
+    if (buf && BLEN(buf) > 0)
   =
  {
-        const int len =3D min_int(size_hint, BLEN(buf));
+        cons=
t size_t len =3D min_size(size_hint, BLENZ(buf));
 #ifdef TARGET_ANDROID
  =
       if (man->connection=2Efdtosend > 0)
         {
@@ -2568,7 +2563,7 @@=

         else
 #endif
         {
-            sent =3D send(man->connectio=
n=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);
+            sent =3D openvpn_s=
end(man->connection=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);
         }
  =
       if (sent >=3D 0)
         {
@@ -2591,10 +2586,6 @@
     return sent;=

 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic =
pop
-#endif
-
 static void
 man_connection_clear(struct man_connection *mc)=

 {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87dd41b66f=
7d77cab7aaf80fa9d9095e46c033d5
Gerrit-Change-Number: 2339
Gerrit-PatchSet: =
3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Co=
jocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--d3ENz2k8+bg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Frank Lich=
tenheld <strong>uploaded patch set #3</strong> to this change=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=3Demail">View Ch=
ange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule=
 is unsatisfied now=2E</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">manage: Fix conversion warnings in =
man_write<br><br>Use openvpn_send to avoid warnings due to<br>Windows/Unix =
differences=2E<br><br>Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<=
br>M src/openvpn/manage=2Ec<br>1 file changed, 4 insertions(+), 13 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/39/2339/3</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec=
 b/src/openvpn/manage=2Ec</span><br><span>index bbf454a=2E=2Ecdd9501 100644=
</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/ope=
nvpn/manage=2Ec</span><br><span>@@ -2448,11 +2448,6 @@</span><br><span> </s=
pan><br><span> #endif /* ifdef TARGET_ANDROID */</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defin=
ed(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma =
GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#p=
ragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> static ssize_t</span><br><span> man=
_read(struct management *man)</span><br><span> {</span><br><span>@@ -2550,1=
4 +2545,14 @@</span><br><span> static ssize_t</span><br><span> man_write(st=
ruct management *man)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const int size_hint =3D 1024;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const size_t size_hint =3D 1024;</spa=
n><br><span>     ssize_t sent =3D 0;</span><br><span> </span><br><span>    =
 buffer_list_aggregate(man-&gt;connection=2Eout, size_hint);</span><br><spa=
n>     const struct buffer *buf =3D buffer_list_peek(man-&gt;connection=2Eo=
ut);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf &amp;=
&amp; BLEN(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (buf &amp;&amp; BLEN(buf) &gt; 0)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        const int len =3D min_int(si=
ze_hint, BLEN(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        const size_t len =3D min_size(size_hint, BLENZ(buf));</span><br><s=
pan> #ifdef TARGET_ANDROID</span><br><span>         if (man-&gt;connection=
=2Efdtosend &gt; 0)</span><br><span>         {</span><br><span>@@ -2568,7 +=
2563,7 @@</span><br><span>         else</span><br><span> #endif</span><br><=
span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      sent =3D send(man-&gt;connection=2Esd_cli, CBSTR(buf), len, MSG_NOSIG=
NAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            se=
nt =3D openvpn_send(man-&gt;connection=2Esd_cli, CBSTR(buf), len, MSG_NOSIG=
NAL);</span><br><span>         }</span><br><span>         if (sent &gt;=3D =
0)</span><br><span>         {</span><br><span>@@ -2591,10 +2586,6 @@</span>=
<br><span>     return sent;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined=
(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GC=
C diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> st=
atic void</span><br><span> man_connection_clear(struct man_connection *mc)<=
/span><br><span> {</span><br></pre><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=3Demail">change 2339</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I87dd41b66f7d=
77cab7aaf80fa9d9095e46c033d5 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2339 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>

</body></html>
--d3ENz2k8+bg=--


--===============2274741501923121017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2274741501923121017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2274741501923121017==--

