Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752CB606A31D
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QhSL66zQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=M83sj+J7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=B0MLw4Ch;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=AMM9HDdo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NiLExzkBaLXVYiFPqMzEvpUai7wS6KQaK/Vi/SQ+UYE=; b=QhSL66zQIkDcdiWkGClGUDpdrF
	ftfxMBzO5wR59UNHNyF5d+bz9MVuZEhgzgMFKesR9Iq1vjWKz/5dXuDvwqGgrzm2LtBFWP6Q0qBji
	J9CX9FUQ4bgY1IQ8K16iXPAXWsiSHSRMr88/QP175r1fwhttQaM8RFI1HVMGkp4FCmjg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLLWT-000000006Js-0ee6;
	Mon, 26 Oct 2026 14:18:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLLWQ-000000006Jk-0pf6
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:17:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0uCnnKnIUtbl4V9mf3fnOL6vljAFxlPKiMYB5cbuoBM=; b=M83sj+J7Ay8ZjSHgR82E05qGTn
 OzwPmq2zZVQVM5fNRg3uISBG7zvDo14kmm9WcCq6DA9p04bAXseCu6CMTC+DEsd5X4Nsi4ZcrMW7g
 g+tbegrPZNcMGZxtuTCI/RcOjY53MfAAKKkF2sMunPguXrjGkBK2uQCfx3s0M004FWgU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0uCnnKnIUtbl4V9mf3fnOL6vljAFxlPKiMYB5cbuoBM=; b=B0MLw4ChsqR4R/FF9a5Kv6S+Xt
 7YIBGL7BCB5OiO08ttltGf/H6GRhK/vGmCH8xLAThQOdk++PialciMqXmFKkoHjdyHmExhr21apqk
 4WCFv0OKPRYzfXTqHSzQFsm3Btn4UtaGIJBP+fb4GwKyHY2JBnZvQ7VYv02ioWT1iOn0=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLLWO-000000001xN-0tak for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:17:58 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so9391675e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793024269; x=1793629069; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0uCnnKnIUtbl4V9mf3fnOL6vljAFxlPKiMYB5cbuoBM=;
 b=AMM9HDdo85/dydwnop8tw+PIXnDr0xFHCcgs9DcAJZGp0tk68MroaXCSZ49O5WQRoN
 18QbF5p9J/ApnIbpV5FSjmSqn4WnwcA47SYnVPVypbcdPgPttisSesHED6emihjgJ0Gh
 OzuPSaf3/RXK/SRO7dZh3cJnoojCuP+sqGteTJVYCPNCJI/JhMZBEsjrWKu6oUy4zpr8
 4RYHo+Sci0Wo1OezIHy4BWI0+sLaNa6vUnT7aU1fUCHnTl5KrtOCxtHqf4U7M2FrwP/H
 w2zq/UJwZJb5d6ApaAdK4XMidprZe1dbYLvM5OC86tPySQpYdAXMJ6SsncuLWMbZ/AbC
 YBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793024269; x=1793629069;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0uCnnKnIUtbl4V9mf3fnOL6vljAFxlPKiMYB5cbuoBM=;
 b=INgXAkjXJ7+VMK5zgYIFupaIQfMx7nG3+hkF/5aVJW3lDy2smHeRTZSPAR69tCA6Qt
 HGk1kNY3LDHjXUmVUy2/F3Q25E2wUWLIl5dlFayDLj6MwRGGosHby+J/lGRu5K9JFLKc
 U+w/9RwYSgdRBRmdUXJviAuAJRoZAy8RWN/9+eEkobPW4BsIDto4mK4y5iYtcLAJzrz4
 xy+A5sWUF9EsGEVDr8qza4Uhjx9eEVEAxCedg3SHgMtLPL4V0rNienHj0sVMiwKhBwkr
 e+ZOuL6+YhuiJmbiwGARFE4iY9T+GNXfCPbyJPh8n8ISq3paFrdKHB4JHoDT+3UzFKCH
 Viog==
X-Forwarded-Encrypted: i=1;
 AKwUvBzfECa3ZcpnqkaLcw3Pi60oQzxVvLLLv3SRJMGlS2ucbfeoPtGanWhN70Ur+fwtKwTI5wBHlye5Y/8jcRbg@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLdbbKdKxSOCDxNs8Mn/zvV9yq2llQjeGOjKKCDuwZBxUwOxIWA
 tcWXnmMmD1kD65R7ehZzYW5kaqutA6G/ILLYWMMsziDL3dq1/gxW/NTAM+xtcDCTCqwlqORbeX4
 wKHvtLD40UIE2pJk022dcPeeoJjMlDIum8auMuPtu0S4pfKUmcOPE6vdvD6q8zI9EwVvtSdK1LD
 XcNGhjPg==
X-Gm-Gg: AYBFou1HAfno4OVdmTsIhphms2yHNuSTgKvMJsTzJxVSqi6LeuGmXGpZYF+zvhN0z73
 Z4BpzY/l/2IaemVbjVg1GpZPwTsu6Vg6x4rfkImvcbcNVypi10sO62hhJcf0CcLQF05kMdpj4g4
 pOHJmr0iZ6W5a29BaW2qOKLxkRIIWiLfRtZyfVqVgLSXKAj9oy2CDI0qOM0HazgdHdMLdKiEcbH
 ftTs6+QrdKmmYvWCG1dUV7f0CAfk/WIbpVzF+N7/mlWysfAuz+4ndnFm1g8OraTflDOZpI+faQl
 IRR6w3lH7YSPcrbKzzaVkIvzAkunVWMQ+RF5i9q2WIhB8VmbzDXywj/HjKeH3D08jtpVppFsyoO
 UvDSW3IQGL2V8sse7ukxiM1g+7QnFuTKQvfLp2B2HtCGefgBn1NKY09GY8EzR/hcgj1zDoaZLh1
 xC70q4dQlUeDFcEMSh+9gLWJ+WM5iRyqB3f78APtIOJzCAqtWxk59UBaHizJpg+wu8CO8c1YFm8
 tDlMnlpnRllS5fihZllZWZei2hLffwNymG4M/2LXWS2Lga6C9pT2NZd4/fRQ5XljsgDsPbkTQTe
 rgf2go+jp1Xtd7O8TZifvXUTiyDcXk6wB6ujtTUL6uJsTt30Arb1qEv1jNb3Vs/04bsU8vBIrvz
 4iNTAbFYmQl34vwiGJjPvBaqsigBEvsr+HamwRPBy4Q==
X-Received: by 2002:a05:600c:8708:b0:4a1:f736:79f3 with SMTP id
 5b1f17b1804b1-4a35ac803b2mr121473005e9.5.1793024269507; 
 Mon, 26 Oct 2026 07:17:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd354asm15887309f8f.43.2026.10.26.07.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 07:17:49 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 14:17:48 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id206b12bd67c0b8a014a2c62277b43b18debfd43
X-Gerrit-Change-Number: 2033
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2033?usp=email>
X-Gerrit-Commit: 54a66f355ace8e89b25ed9e85c659d290eb700d2
In-Reply-To: <gerrit.1793012308000.Id206b12bd67c0b8a014a2c62277b43b18debfd43@gerrit.openvpn.net>
References: <gerrit.1793012308000.Id206b12bd67c0b8a014a2c62277b43b18debfd43@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDEyMzA4MDAwLklkMjA2YjEyYmQ2N2MwYjhhMDE0YTJjNjIyNzdiNDNiMThkZWJmZDQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <130a6fd160631b018e0acc70bcd82a44587e9b59-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLLWO-000000001xN-0tak
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: run-cppcheck.sh:
 Make CPPCHECK_CHECK_LEVEL=normal the default
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
Content-Type: multipart/mixed; boundary="===============7098262879353187666=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7098262879353187666==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8dHkFT7pA5E="; charset=UTF-8

--8dHkFT7pA5E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2033?usp=3Demail )

Change subject: run-cppcheck=2Esh: Make CPP=
CHECK_CHECK_LEVEL=3Dnormal the default
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

run-cppcheck=2Esh: Make CPPCHECK_CHECK_LEVEL=3Dno=
rmal the default

exhaustive is generally not usable since it runs for hour=
s=2E
So avoid confusion by choosing a sane default=2E

Change-Id: Id206b12b=
d67c0b8a014a2c62277b43b18debfd43
Signed-off-by: Frank Lichtenheld <frank@li=
chtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2033
Message-Id: <20261026120859=2E76788-1-frank@li=
chtenheld=2Ecom>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg40139=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M dev-tools/run-cppcheck=2Esh
1 file changed, 1 inserti=
on(+), 1 deletion(-)




diff --git a/dev-tools/run-cppcheck=2Esh b/dev-too=
ls/run-cppcheck=2Esh
index a9c4643=2E=2E07c0a6f 100755
--- a/dev-tools/run-=
cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=2Esh
@@ -3,7 +3,7 @@
 set -eu
 
=
 : ${CPPCHECK_VERBOSE:=3Dfalse}
-: ${CPPCHECK_CHECK_LEVEL:=3Dexhaustive}
+:=
 ${CPPCHECK_CHECK_LEVEL:=3Dnormal}
 
 if "${CPPCHECK_VERBOSE}"; then
     v=
erbosity_arg=3D"-v"

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2033?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
Id206b12bd67c0b8a014a2c62277b43b18debfd43
Gerrit-Change-Number: 2033
Gerrit=
-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>

--8dHkFT7pA5E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2033?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">run-cppcheck=2Esh: Make CPPCHECK_C=
HECK_LEVEL=3Dnormal the default<br><br>exhaustive is generally not usable s=
ince it runs for hours=2E<br>So avoid confusion by choosing a sane default=
=2E<br><br>Change-Id: Id206b12bd67c0b8a014a2c62277b43b18debfd43<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2033<br>Message-Id: &lt;20261026120859=2E76788-1-frank@lichtenhel=
d=2Ecom&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg40139=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/run-cppcheck=2Esh<br>1 file cha=
nged, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-tools=
/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><span>index a9c4=
643=2E=2E07c0a6f 100755</span><br><span>--- a/dev-tools/run-cppcheck=2Esh</=
span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><br><span>@@ -3,7 +3=
,7 @@</span><br><span> set -eu</span><br><span> </span><br><span> : ${CPPCH=
ECK_VERBOSE:=3Dfalse}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
: ${CPPCHECK_CHECK_LEVEL:=3Dexhaustive}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+: ${CPPCHECK_CHECK_LEVEL:=3Dnormal}</span><br><span> </=
span><br><span> if &quot;${CPPCHECK_VERBOSE}&quot;; then</span><br><span>  =
   verbosity_arg=3D&quot;-v&quot;</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2033?usp=3Demail">change 203=
3</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2033?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"disp=
lay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerr=
it-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id2=
06b12bd67c0b8a014a2c62277b43b18debfd43 </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 2033 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--8dHkFT7pA5E=--


--===============7098262879353187666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7098262879353187666==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7098262879353187666==--

