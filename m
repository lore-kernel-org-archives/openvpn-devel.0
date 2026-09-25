Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392AAC98321
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 14:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XvvaoGsqdwsFJDzofJ1wKYxCN6mWY/jQ8xxGNLytg3g=; b=X4HW1gOg/aoa/Gd8EKtv4OCTLA
	9FdpOabt9F8nrKsSGvJpfCLE1oJmJedrIQDsHu5PsExKm1N9B+CphImiOre8TArsll7FdrHdP+NaL
	n3CkAiiB8ULvcoDO7GMOoqZLTB0iBdmmo9h2mI6z+1gqUda3JdSbnCRfqZ4w6YbvlQRg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xA73S-0007uN-UI;
	Fri, 25 Sep 2026 14:37:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xA73R-0007u8-38
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 14:37:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=IKHUafJ0xeyX0DBtqCQqjSCLDbxjpa2QtDxLYwnpUxU=; b=YavOtYvJp+Tcb9UfUZfbu0IcQG
 nDciVir96RBQ6pF1HPxuO0mW4FI5fY/+/DzqxOYZckDxLYDrcLMcY6oqPql3HERNuh5oogRnYzITH
 +cu/ac95NAhXLbr/Gtf+kX3TpiwKINMSnRq1j1jYB2NsIaie+nn9YdkTA4lNKQbGJIQM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IKHUafJ0xeyX0DBtqCQqjSCLDbxjpa2QtDxLYwnpUxU=; b=U
 UHN4yGQy4mFHDtOCbgH+pXetRqQRlRq5AXuW8yCovIp3pI4AK8T4PWlxDnnPx5qsJ4zB13nAKDE4w
 XvpYgDtGz+Ctml7mFVgGeWn4w/JMciDrEqjRN2aNipCIFemsOqf8XtMoay/Yep+AePk+hjP37B7xe
 enirc7JDsdFAQxyw=;
Received: from mail-wr2-f13.google.com ([74.125.225.77])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xA73D-0000ay-S4 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 14:37:25 +0000
Received: by mail-wr2-f13.google.com with SMTP id
 ffacd0b85a97d-4843378fb37so585249f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 25 Sep 2026 07:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790347037; x=1790951837; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IKHUafJ0xeyX0DBtqCQqjSCLDbxjpa2QtDxLYwnpUxU=;
 b=d+tZVNn8E72EVjmRc+J3HprY/nNoJmsoGZxm4yYhw5HQ8E0P3LyDZIKz16uSpN9C32
 8y6k0KwJfTs3XJTxpJcARhMvPMJO0ivyrg9uboBlCAjQUCQSC2iHuzKv21jUWIL5iHUx
 pWx8f5ZyBXo69UQ+sKwLL6W0nfLRhzaxLImqjbQRVn+ks3NN7zzfQofwEP0Fd0NvD3ev
 HUfxuju60wOEDMZzko9tI67m3g6Z+digwzMej/ElsiU4V1+RKIj3c/Altw2AgObpRZh6
 /cVOUXza5UcPLqFgcnaM07rbVxqIxSFlRl6y1sDYj+TVMQmFREfRyIPzRS+I9cpzzyCw
 HbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790347037; x=1790951837;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IKHUafJ0xeyX0DBtqCQqjSCLDbxjpa2QtDxLYwnpUxU=;
 b=LLxoIC8Hz0sx+OyTKxUDouzijZUiZw3YhPGiPGWEbARdj0P4OxNY4wIGwjjXDtHV31
 l+CL5HOUgm18bb7nbHJKAG9iaJHYV/q9vXK21tVHX9Dv2LDhYmIuqFXeb3R+eRgiK0Hp
 jJD9O3XZD01DyIITceiBlwtxUpTEbZ1yuvBiJ/4oVRLqX2TMRsgw05jqQavD26DnXOnl
 WMlM/dQv2wjepUgFYUJmUT2h/t2qCylVWWkhr6pR6G3CczonbSihJJnc470s9H5v4SKk
 eCwyGsT8xIWtdHq2pkn4brE2G6mHvXe83NijhX/TZHzjjiP10aKi+VsskdbKKX3mrgri
 CZwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhYEdU9+20TJWNiGq5ZySBMnB/7ZChrjjk0BdvkHHeDQt77vPUi299Cd+FxrZC2QgQYt33LjBA3NuK/8wS@lists.sourceforge.net
X-Gm-Message-State: AFuF++kUktOhu+9MYNI84qpqx3u5BVNS3gyRtcKbtysqww/8CRk+8goD
 tU0sNuafCzF8ZpRVc+IJc3Kwk5D7jQq7ehDxn8uUPJluU9k+aGd9xZuqt113Q870pcYCS4PKBX9
 Zr9OSGSwijyNgWHgOQjyuKsuk84blSke30JAQjmVRntcK5LOB2eo4JXM2yIVyeq4jrTIb
X-Gm-Gg: AYBFou01PtS1NSguwFKZKFsO7x9f4WZTQvDXTFqmeDMZ69uY6/X1I5fPa0iqxwaA5Oo
 tN9Crxz5L0BFs+FXlhAZKuiM2YymU1Tot9nd4bfpS3gLgqZOpuKG28KYurwBqxTExFJ4ifNfQB0
 lgAm5YdA+IOsM8PA0D0yfi8CVEWEulCia++1dMsCbN/VlriUc0F0ZA7UfuV8k0mDwWXBDsD9Kmw
 aKS3epTq94qatKZRWkrMpPqvntWJyf6FOa1TtGN+dDRMV7i0qgFZg7ZidHOzo4oZepUHOXDjfRj
 Yf1DQjkV1YLQMyqhbWjmVaK6hS7DxtIi3uFJAdHLNQlyjOqV/unLlms2h5kZIxCGFDrDC1uxqNI
 yoqu8GKxAOdsppJwkQK5DM84049ESAJ/12NLBhIl3Vpo5wn7A5/8MrUlWevnjDy1jIIjrtp+evh
 rbuQk/PXF2fmYCtOFMrCI7Wy95lyX5gmce127BPzpTCZJtf5PYNz1cms2t5fkUs49Fj5JSuY8w3
 7/4rvV1Jak5tdujze8mvRwOC5z9tieAHklYmFHwyORdBUzLVq7ywFaTj24zMcUN8ZSEnxqZN144
 E4J1bYqf87S4EjnwHMOqFQ6LPtElxqrCz6f1zl6aNDrUAgfFKX59vKfyLKL0
X-Received: by 2002:a05:6000:2910:b0:487:1aa1:f54f with SMTP id
 ffacd0b85a97d-488716a89cemr11467130f8f.46.1790347037086; 
 Fri, 25 Sep 2026 07:37:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30bcc4sm8003244f8f.1.2026.09.25.07.37.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 07:37:16 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 14:37:16 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id999691f74d291f4b902b8ca224a12d9bc7e6046
X-Gerrit-Change-Number: 1951
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1951?usp=email>
X-Gerrit-Commit: 67e6faa4496ff6fedc9297faf78d8cd4646a0b4b
In-Reply-To: <gerrit.1790339862000.Id999691f74d291f4b902b8ca224a12d9bc7e6046@gerrit.openvpn.net>
References: <gerrit.1790339862000.Id999691f74d291f4b902b8ca224a12d9bc7e6046@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzM5ODYyMDAwLklkOTk5NjkxZjc0ZDI5MWY0YjkwMmI4Y2EyMjRhMTJkOWJjN2U2MDQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f9df46f17c5b46fe8ae554af30d6bbccb06be6a6-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xA73D-0000ay-S4
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: multi: make
 multi_add_mbuf static
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
Content-Type: multipart/mixed; boundary="===============3565019707249770694=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3565019707249770694==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3Vp9Hnvo+RE="; charset=UTF-8

--3Vp9Hnvo+RE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1951?usp=3Demail )

Change subject: multi: make multi_add_mbuf static
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: make m=
ulti_add_mbuf static

This function is used only in multi=2Ec and can there=
fore be
declared as static=2E

Change-Id: Id999691f74d291f4b902b8ca224a12d9=
bc7e6046
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Acked-b=
y: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1951
Message-Id: <20260925130715=2E9850-1-gert@green=
ie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg39496=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
2 files ch=
anged, 1 insertion(+), 3 deletions(-)




diff --git a/src/openvpn/multi=2E=
c b/src/openvpn/multi=2Ec
index 67204c3=2E=2Efd54946 100644
--- a/src/openv=
pn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -2833,7 +2833,7 @@
  * Add a mb=
uf buffer to a particular
  * instance=2E
  */
-void
+static void
 multi_ad=
d_mbuf(struct multi_context *m, struct multi_instance *mi, struct mbuf_buff=
er *mb)
 {
     if (multi_output_queue_ready(m, mi))
diff --git a/src/openv=
pn/multi=2Eh b/src/openvpn/multi=2Eh
index 6cb86c7=2E=2Eac6cb78f 100644
---=
 a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -354,8 +354,6 @@
 
=
 struct multi_instance *multi_get_queue(struct mbuf_set *ms);
 
-void multi=
_add_mbuf(struct multi_context *m, struct multi_instance *mi, struct mbuf_b=
uffer *mb);
-
 void multi_ifconfig_pool_persist(struct multi_context *m, bo=
ol force);
 
 bool multi_process_signal(struct multi_context *m);

-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1951?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id999691f74d291f4b902b8ca224a1=
2d9bc7e6046
Gerrit-Change-Number: 1951
Gerrit-PatchSet: 2
Gerrit-Owner: ord=
ex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--3Vp9Hnvo+RE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1951?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">multi: make multi_add_mbuf static<br><br>T=
his function is used only in multi=2Ec and can therefore be<br>declared as =
static=2E<br><br>Change-Id: Id999691f74d291f4b902b8ca224a12d9bc7e6046<br>Si=
gned-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Acked-by:=
 Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1951<br>Message-Id: &lt;20260925130715=2E9850=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg39496=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/multi=2Ec<=
br>M src/openvpn/multi=2Eh<br>2 files changed, 1 insertion(+), 3 deletions(=
-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec</span><br><span>index 67204c3=2E=2Efd54946 100644</span><br><span>--- =
a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><=
br><span>@@ -2833,7 +2833,7 @@</span><br><span>  * Add a mbuf buffer to a p=
articular</span><br><span>  * instance=2E</span><br><span>  */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span> multi_add_mbuf(struc=
t multi_context *m, struct multi_instance *mi, struct mbuf_buffer *mb)</spa=
n><br><span> {</span><br><span>     if (multi_output_queue_ready(m, mi))</s=
pan><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</s=
pan><br><span>index 6cb86c7=2E=2Eac6cb78f 100644</span><br><span>--- a/src/=
openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><br><sp=
an>@@ -354,8 +354,6 @@</span><br><span> </span><br><span> struct multi_inst=
ance *multi_get_queue(struct mbuf_set *ms);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-void multi_add_mbuf(struct multi_co=
ntext *m, struct multi_instance *mi, struct mbuf_buffer *mb);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void multi_ifconf=
ig_pool_persist(struct multi_context *m, bool force);</span><br><span> </sp=
an><br><span> bool multi_process_signal(struct multi_context *m);</span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1951?usp=3Demail">change 1951</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1951?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: Id999691f74d291f4b902b8ca224a12d9bc7e6046 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1951 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-deve=
l &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--3Vp9Hnvo+RE=--


--===============3565019707249770694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3565019707249770694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3565019707249770694==--

