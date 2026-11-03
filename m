Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975F7606A32E
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ams8q2Dz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bmsOSnqz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ddRn+2DP;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CjfzWOdU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Nt9KTDaZAp1YZQK5NFsCiuX7K5Fgwpl7puRRAkZdWmY=; b=ams8q2Dze20WCHj0vh+XG5q4jP
	sbY+FhCCsipIDSW0/4aWSrCzhEbYUUQ3OHwUFINsx5EQBG1UbqrgVnA2TCPILoReUAGBiRbzxYlJB
	d9uLKTrP5VMJEX0Pnk2yAQanSfUoVjP/zxCU+Wzrpe1WAMy9TK2rQTtNerIQqbVKC1yI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOGlx-000000006JD-1EAg;
	Tue, 03 Nov 2026 15:50:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOGlt-000000006He-2reW
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:50:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=54+deqUZ6eFzxQAruu2B34kP+0YsIA39X0hlEbwZsz4=; b=bmsOSnqzc1bpTZ9ApjsUktMJDO
 v348EPZ3+G7WUFY1X9t7y/kIgT4iQsXK4Mj8zjoCPmeL77R94hj5OpZeun4U3RKZkgreHz6nhxkCY
 9zDHCnbEWQug2L/ZoEsjBJSfSFJZp+llDeI4ccqCjxsQ+/2BX2KogI8fb1j/910Gcbis=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=54+deqUZ6eFzxQAruu2B34kP+0YsIA39X0hlEbwZsz4=; b=ddRn+2DPxLhkvNsWKaCkGpcMzu
 llq2IGipBbGbtZfuR8hK6gioSp4lq9ZhJ4Rx56a1zfQlS3ccUBJg5+A9DcxF83DBxgAbKIzX0vNGp
 CtZx0WINc74DXTVp38U+x5bYX+t3Pu67K6Xksgk++43MW0zSqwo29OqJOTKuLJIUyXAU=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOGlp-000000000C7-1csT for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:49:59 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so2656797f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 07:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793720991; x=1794325791; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=54+deqUZ6eFzxQAruu2B34kP+0YsIA39X0hlEbwZsz4=;
 b=CjfzWOdUMJlNvvict5WbBeQgkVCc4EGCjxrOqKOlSYKi2nKrcrPtEsk+WfiCvsMQ7r
 ErxXUBuyY5L5I9RwisxBtnEGb08DVmzVJQwNFcyw8SU5wlVulRFr+J/4A/pBZaV74y0h
 aoBqsad5Fa1ribjZpPNj86RkLjV5kOqrLYwuTcRnnCffhluR+VNjOkhLlVW0QRccOr8S
 +bUP0k5VnNxwKW6Ca7HFJtEG+0rAr5O8u33ng5sBUCDhfLcZ+Y9NK0i3aDiv5MnRWUg/
 yatWk0yk5Nf8WoAPKIrV86u3He5fVR1McH76CaYoxsIj5ZLpU45UfMsFwtLeSLF+Efc2
 d34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720991; x=1794325791;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=54+deqUZ6eFzxQAruu2B34kP+0YsIA39X0hlEbwZsz4=;
 b=kPcy3bcBDy3phZuCaDf3fWJIwZUtP6SqIdK3fM6I0zz+zo+AcF1UuixBS8izPgq8ti
 2Xy/mLFgBEG6oRrMLXl++f6KW6rzm+QCYUU7jS9TPcwStE+0c0SzFlK7iktZeaPqlf+X
 hPhHeKiSHthX2ru+kCMlZZ3tYQp57yOaM938+G2WnCNEgLtQHVH8cNWYk1UH6vnx1fBP
 y7wKDkp8MPcKUW8vN1DhX1S2T1VlCXDoJRhHolXZ1BHv+VyZYVp6Dbk6p036P5vaPohy
 sGP2Yyg2acJSqEqvn7eJtI9xFP0WJe3lxcv4R++6V1sTfKnbs3T+tib7NYvpB7MqH29e
 GxBA==
X-Gm-Message-State: APuU4Z9ASb728v0kRHhrtoWsKH3eCkWIVGMEC0MGgYcCOqQ9tluZ7le4
 cD4P0PGv8Lx6abMv85NoyXMajFe3uAeDkFEsJ5V5P6T0o5ivNPLxguLQMM6lz5fwisVYLQeXOJU
 hwJZJm5flzOXNCEjxRNZn8PppBDFbfgWzoKvGr+gKUDHOKYWFVAxxjVHmEaVhTcjOfR2V
X-Gm-Gg: AYBFou1wDkHn/4HEPzt0/6JgvFsWOpJ6bjlBqyHtocB3efCwLBYwVd//1RdlvGA9Ufy
 hZ/lmyUyBbLtmffjEc/e9HpO8zm/ioZfSPcVbSX7rlAlPbGX6HQpVoQcnxb4JePCk6QhewV45xU
 OQEtExCtDhek3BlTBtf0LzW5pXfG40RcTxtPLIWdjt9asbTkJSxA2YsAfhYhhAdbE1nGehXTDjR
 2Fa7Fb+4wfUhfeTyrErIHPZooHkADoIDweK+KGoFcx09/ut82lJXCFRM0TyObl9UUjKWqKpWii3
 fatWiLpjtx1Gcx9fnumfIGLziZi9ilxpDIghSxDgPpvwDaYHGPdb9ySIsaANCTBma1oacmroBTW
 RGbvdt5yZyRLbJs0R3bdZGaJBXfgj56krq1gSLYEkz9IeRANsayqy2oZ3ZHGr4oRuUmYwHuEJo4
 E3D7zzeItc8hmCfS8RaYrfKX4CFme9u4iUBGK/QNbg94F6RL1/EwEcQ3Wn3B7t6fiqJyod8iOaz
 Oga7uLLkm6qNzDIgSnUH1MBUO/nkv2R22iLICK8cw2Z5WcAPiVZy85jC3+dfncXXzM+qPIljhQp
 mcLVQJeb0lnJ4t0Ss84ML1E9RDO3LFVjQ1TEfN/sfeum4ZGmbF0jQHylbjnRYNZXuYxQDZu4NI7
 9+27hx6LwpSjm8ap8uHg7aso16VqZIWn6g+vC53UedlrvSc6/wXmhzMCt/DdJU8mMIyyv8SnSFe
 kGvQ2USWKOgUFsNw==
X-Received: by 2002:a05:6000:4027:b0:48d:fbdd:4132 with SMTP id
 ffacd0b85a97d-48e6e4f540bmr28425446f8f.18.1793720990539; 
 Tue, 03 Nov 2026 07:49:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b723fcsm26570169f8f.14.2026.11.03.07.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:49:50 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 15:49:49 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ia3f6dd4ce35869c92619ce0c56eeda8796bde006
X-Gerrit-Change-Number: 2084
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2084?usp=email>
X-Gerrit-Commit: a1cd0cf8a97bd09c12d2e0980a88acc27612ec5d
In-Reply-To: <gerrit.1793618639000.Ia3f6dd4ce35869c92619ce0c56eeda8796bde006@gerrit.openvpn.net>
References: <gerrit.1793618639000.Ia3f6dd4ce35869c92619ce0c56eeda8796bde006@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4NjM5MDAwLklhM2Y2ZGQ0Y2UzNTg2OWM5MjYxOWNlMGM1NmVlZGE4Nzk2YmRlMDA2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <765b3c1af8d4c7efc1746631d666ee0bd5af29f3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOGlp-000000000C7-1csT
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: check_file_access:
 fix --extra-certs access check
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8678060309003349794=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8678060309003349794==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZvieOLsEbEY="; charset=UTF-8

--ZvieOLsEbEY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2084?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: check_file_access: f=
ix --extra-certs access check
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

check_file_access: fix --extra-certs access check

The fil=
e name was passed as the is_inline flag, so the check was
always skipped=2E=
 Pass extra_certs_file_inline instead=2E

Broken since cb2e9218 ("convert *=
_inline attributes to bool")=2E

Change-Id: Ia3f6dd4ce35869c92619ce0c56eeda=
8796bde006
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2084
Message-Id: <20261102115818=2E14189-1-gert@gr=
eenie=2Emuc=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/2026110211=
5818=2E14189-1-gert@greenie=2Emuc=2Ede
Signed-off-by: Gert Doering <gert@gr=
eenie=2Emuc=2Ede>
---
M src/openvpn/check_file_access=2Ec
1 file changed, 1=
 insertion(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/84/2084/3

diff --git a/src/openvpn/check_file_acces=
s=2Ec b/src/openvpn/check_file_access=2Ec
index 83654b2=2E=2E25d7f90 100644=

--- a/src/openvpn/check_file_access=2Ec
+++ b/src/openvpn/check_file_acces=
s=2Ec
@@ -267,7 +267,7 @@
     errs |=3D check_file_access_inline(options->=
cert_file_inline, CHKACC_FILE | CHKACC_ACCEPT_URI,
                        =
              options->cert_file, R_OK, "--cert");
 
-    errs |=3D check_f=
ile_access_inline(options->extra_certs_file, CHKACC_FILE,
+    errs |=3D ch=
eck_file_access_inline(options->extra_certs_file_inline, CHKACC_FILE,
     =
                                 options->extra_certs_file, R_OK, "--extra-=
certs");
 
     if (!(options->management_flags & MF_EXTERNAL_KEY))

-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2084?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia3f6dd4ce35869c92619c=
e0c56eeda8796bde006
Gerrit-Change-Number: 2084
Gerrit-PatchSet: 3
Gerrit-Ow=
ner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--ZvieOLsEbEY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2084?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">check_file_access: fix --extra-certs access check<br><br>The file name =
was passed as the is_inline flag, so the check was<br>always skipped=2E Pas=
s extra_certs_file_inline instead=2E<br><br>Broken since cb2e9218 (&quot;co=
nvert *_inline attributes to bool&quot;)=2E<br><br>Change-Id: Ia3f6dd4ce358=
69c92619ce0c56eeda8796bde006<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Eco=
m&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2084<br>Mes=
sage-Id: &lt;20261102115818=2E14189-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: h=
ttps://lore=2Ekernel=2Eorg/openvpn-devel/20261102115818=2E14189-1-gert@gree=
nie=2Emuc=2Ede<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t;<br>---<br>M src/openvpn/check_file_access=2Ec<br>1 file changed, 1 inser=
tion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/84/2084/3</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/check_file_access=2Ec b/src/openvpn/check_file_access=2Ec</span><br=
><span>index 83654b2=2E=2E25d7f90 100644</span><br><span>--- a/src/openvpn/=
check_file_access=2Ec</span><br><span>+++ b/src/openvpn/check_file_access=
=2Ec</span><br><span>@@ -267,7 +267,7 @@</span><br><span>     errs |=3D che=
ck_file_access_inline(options-&gt;cert_file_inline, CHKACC_FILE | CHKACC_AC=
CEPT_URI,</span><br><span>                                      options-&gt=
;cert_file, R_OK, &quot;--cert&quot;);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_file_access_inline(o=
ptions-&gt;extra_certs_file, CHKACC_FILE,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    errs |=3D check_file_access_inline(options-&gt;ex=
tra_certs_file_inline, CHKACC_FILE,</span><br><span>                       =
               options-&gt;extra_certs_file, R_OK, &quot;--extra-certs&quot=
;);</span><br><span> </span><br><span>     if (!(options-&gt;management_fla=
gs &amp; MF_EXTERNAL_KEY))</span><br></pre><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2084?usp=3Demail">change 2084</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2084?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia=
3f6dd4ce35869c92619ce0c56eeda8796bde006 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2084 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--ZvieOLsEbEY=--


--===============8678060309003349794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8678060309003349794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8678060309003349794==--

