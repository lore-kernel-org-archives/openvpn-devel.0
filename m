Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC7C606AFAA
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eJ4Aj7Gk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=d2NLwlXs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UgS1lngH;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RKmtQXg1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=TlFuFtr3qc7FVwG6VgWUMDlzSJc2GuTddmt24amSiZM=; b=eJ4Aj7GkaokaLL
	in5+CykHUMpH0nt2oQENi/kTh7ycyxdyxh+DwTN5lHfrpB18n5IAqjcpWwnvtAdjFWSm/JE5ekgmP
	Ze9lJSrja+QuHLSsCZ/La+WuWcQq59M03ztszW4bmPY/mWM6fxAH8uJE3GHQ+A3uEoFJgmepVKZj0
	PRU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIpxP-0001qA-12;
	Mon, 19 Oct 2026 16:11:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIpxN-0001q4-Ls
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 16:11:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D5kN/QOKz17TBTWrGdQkgR7B0NDtJMOcPQXLhbss8mA=; b=d2NLwlXsCWuHx6KDAenMrEA5JK
 Ln8TVAF4Xu8SYmVOLje1CvIWD7pfjZ6P9dBrYnF8NF89E8oFpNXGIizIQkiUYKVq4fUB1eqCDX72M
 xq1qRjYJmLGeLwqT8FKyqxK2Yvvtt/US9w2KpsNm8ptffRDVeYzvZvZXlXT9+oSFLiKI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=D5kN/QOKz17TBTWrGdQkgR7B0NDtJMOcPQXLhbss8mA=; b=U
 gS1lngHWrZ+IRJDOEa/h6TBZBWu47eLTBv7tizGSF4ejRNIXaXGsaJAMgGrx7CLXSYRiK/YvgE+D7
 V7OkKX/SSBKWUr9smP8bk+x3ra+Iv+BdUXR1weHfHmDZXDctrX7hlKZahEkx3//s4dimRG1zeyu1C
 AVJSFh0eVbdazFQ0=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIpxM-0007nR-G1 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 16:11:26 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a1682bff3cso10812005e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 09:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792426278; x=1793031078; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D5kN/QOKz17TBTWrGdQkgR7B0NDtJMOcPQXLhbss8mA=;
 b=RKmtQXg1iPym9rH/myyV0xg5i8iAEWtCpwMtYSPnjLE8riTfsr6ZiEMiDk2SPZcBE8
 OnoGngcT+gHZIO49xN5KZOWj09deqhTNui9bqwZVwItP0fTFkgXzbhKfKHKl6/g/sSG/
 /wAvdNJpPmLBGL218hJ+B0zzF8a/rHyNUwFMTPc4+fYf4rTHviFswNdYV63yqbRwuHe4
 7v6QliJlQz5m0TP9TwJ1Vy1YMXwaP2lwEJRQwzmr8+kJASPoN6YZl8jGArbvljXp5TgT
 32RijIAiPaRcUvUcKeCELPxa/4Vw7aAJjzqUUz82aPrCbFT311lsmMSZ79Y4k66okmWq
 1Hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792426278; x=1793031078;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D5kN/QOKz17TBTWrGdQkgR7B0NDtJMOcPQXLhbss8mA=;
 b=n+qiXZORFuF7+4d3YrtcT/lx1RqUCpW+J04Q8VexVFVYjdpofwd9IZyR0DlvQR+kEA
 11DI57NBF4DpRE4qTCKwh5D8U/Ogia0E9ZOsleB4klVN0qDs5oWTrJTr9xKP2vRYwpHr
 xjZuEryT3KGwt1bV9WpKfNC6F1HdXYTqlRvrx5U+oW0jBpXDEX9J4XskWG61TBes+EVL
 M0AfZ9ZJ38j/MfcikjTCcOa+XDQ0jzoRzvOxMGjyAxQdhprCup6a1tTlxNUjpVLz0CjY
 5+VewK1tmB2civ3SgJlmAm2iTNEwpjLLZxjAj1ndbSLHii0EQGcWXFnl36V4ds3yfzeb
 n3Gg==
X-Gm-Message-State: AFq9FYJ/uDms8pZUvnYWXw21ab3ocUNopZDEbmBj6PUBP2JYAI4TenLT
 Nr9Unt21UMepfjjnvEOZQ1scpq4b0wGAwUSZOy6s3tSkmWdHpcNpqoyxprl+CqLsl1TOsq3tUGn
 CPB8Yvdfz4kLYhYHIiQhwvU/PlNifAT4eVA3maGjwd2sPSC320oGJRwL8P9sr8hSYg5jsvf16cn
 juCkHojg==
X-Gm-Gg: AYBFou1XpRe73HfyyoVwDEaCZ3WMNuwg5wIoGQGzQJHFYWNhPDMGa5WH1441rAexKR5
 e433QGHvyn7SB1s3IKvcGkuz4zLmipP37m67sMY/qUc1exUk2gTKOalzhPp6oW7zD8HieccglLh
 IKMdvNuEaieCTsVryDjwMA+l7XB4/0StCGNCsTBySYEqdWKxZ9QeY53tifmrJeeFmVuVrswMWYY
 /u8i2s/gEvX0OACyE62PvY2LSx7M3SAYQjeg4WSwEOpNYytHGFGec2qs5ioUVkQCO5/ZoaRivnC
 jRJcsHVZFnBSWKr5nynMgGWhd/+aQs6Y9a/Kxqvtk7Kp66ui616GyVXhqHUM/ZZUmtjxZHM7yzt
 l8DRRUVJtHB8fI7y4w4VHESPQioM1hTk9RYxJjW7TAlCrvsDHgjJDyJQewVqfzcM0pRuES8JfIi
 LTe5Y+GS1zj6k62zU03pNzDl89nvFVQEXkCRYN1jslJaXx2gu9kN7JMPw6JPG9KREH7arzLTlRw
 u557u/P2si24n913cuTUEPoimHz1oxcHlzro+h183yXmH8c6ORkfemjEnqLhPbZWLZp6G/jpR+7
 ySaCWrgMC8IsCgU9KAuZW7ktV69YX65Nd4jEiKMnj8CbChqhgKmT91fT463bevHx3Vnnsvo=
X-Received: by 2002:a05:600c:3541:b0:4a1:6c79:fd31 with SMTP id
 5b1f17b1804b1-4a1d7604118mr176211815e9.12.1792426277521; 
 Mon, 19 Oct 2026 09:11:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2cd348asm2366685e9.11.2026.10.19.09.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 09:11:15 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 19 Oct 2026 16:11:15 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7f2db60564fa179ce5f56979912c7e484dad1e1d
X-Gerrit-Change-Number: 2023
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2023?usp=email>
X-Gerrit-Commit: 2d5818e59110ab3f3a3d004a8f90023239daf4f8
References: <gerrit.1792426273000.I7f2db60564fa179ce5f56979912c7e484dad1e1d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNDI2MjczMDAwLkk3ZjJkYjYwNTY0ZmExNzljZTVmNTY5Nzk5MTJjN2U0ODRkYWQxZTFkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3432e0ced5ba98607a2b7ebdff743bea236f1f18-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xIpxM-0007nR-G1
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.7]: Fix broken
 unit tests after commit 5c6fbd0a11
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6608358262982049447=="
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6608358262982049447==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8n20E0KRcIE="; charset=UTF-8

--8n20E0KRcIE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2023?usp=3Demail

to review the following change=2E
=


Change subject: Fix broken unit tests after commit 5c6fbd0a11
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix broken unit tests =
after commit 5c6fbd0a11

Said commit only cherry-picked the "actual code ch=
ange" but not the
required adjustments for the unit tests, leading to an un=
resolved symbol=2E

Master has all the mock functions in mock_push_dependen=
cies=2Ec which
does not exist in release/2=2E7, so import "uninit_options()=
" into the
actual unit test source (as are all the other mocked functions i=
n 2=2E7)

Change-Id: I7f2db60564fa179ce5f56979912c7e484dad1e1d
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/unit_tests/openvpn/te=
st_push_update_msg=2Ec
1 file changed, 7 insertions(+), 0 deletions(-)



 =
 git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/23/2023/1=


diff --git a/tests/unit_tests/openvpn/test_push_update_msg=2Ec b/tests/un=
it_tests/openvpn/test_push_update_msg=2Ec
index 9b7978e=2E=2E75b654b 100644=

--- a/tests/unit_tests/openvpn/test_push_update_msg=2Ec
+++ b/tests/unit_t=
ests/openvpn/test_push_update_msg=2Ec
@@ -48,6 +48,13 @@
     return;
 }
 
=
+void
+uninit_options(struct options *options)
+{
+    gc_free(&options->gc=
);
+    gc_free(&options->dns_options=2Egc);
+}
+
 bool
 options_postproces=
s_pull(struct options *options, struct env_set *es)
 {

-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2023?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Ge=
rrit-Branch: release/2=2E7
Gerrit-Change-Id: I7f2db60564fa179ce5f56979912c7=
e484dad1e1d
Gerrit-Change-Number: 2023
Gerrit-PatchSet: 1
Gerrit-Owner: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--8n20E0KRcIE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gert Doering would like Arne =
Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2023?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">Fix broken unit tests after commit 5c6fbd0a11<br><br>Said commi=
t only cherry-picked the &quot;actual code change&quot; but not the<br>requ=
ired adjustments for the unit tests, leading to an unresolved symbol=2E<br>=
<br>Master has all the mock functions in mock_push_dependencies=2Ec which<b=
r>does not exist in release/2=2E7, so import &quot;uninit_options()&quot; i=
nto the<br>actual unit test source (as are all the other mocked functions i=
n 2=2E7)<br><br>Change-Id: I7f2db60564fa179ce5f56979912c7e484dad1e1d<br>Sig=
ned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/=
unit_tests/openvpn/test_push_update_msg=2Ec<br>1 file changed, 7 insertions=
(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/23/2023/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/tests/u=
nit_tests/openvpn/test_push_update_msg=2Ec b/tests/unit_tests/openvpn/test_=
push_update_msg=2Ec</span><br><span>index 9b7978e=2E=2E75b654b 100644</span=
><br><span>--- a/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span><b=
r><span>+++ b/tests/unit_tests/openvpn/test_push_update_msg=2Ec</span><br><=
span>@@ -48,6 +48,13 @@</span><br><span>     return;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+uninit_options(struc=
t options *options)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;o=
ptions-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
gc_free(&amp;options-&gt;dns_options=2Egc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> bool</span><br><span> options_postprocess_pull(stru=
ct options *options, struct env_set *es)</span><br><span> {</span><br></pre=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
23?usp=3Demail">change 2023</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2023?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newcha=
nge </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"=
display:none"> Gerrit-Change-Id: I7f2db60564fa179ce5f56979912c7e484dad1e1d =
</div>
<div style=3D"display:none"> Gerrit-Change-Number: 2023 </div>
<div =
style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:non=
e"> Gerrit-Owner: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>

</body></html>
--8n20E0KRcIE=--


--===============6608358262982049447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6608358262982049447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6608358262982049447==--

