Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ABA606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=clmpA2Fl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E5B5OLZs;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NiaF5wII;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=I0Uo7+Bm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=aNvhHlg/5Y86Lf0Pxjwa6giU5rVlqYDCzFfNWsBTwOM=; b=clmpA2FlsMq/oNm03eXeO27UGS
	yMmU2jeOT/XvhgwiIAJCwoS9zchBGEvAUiQK9VLIyb5aOLkjNEXYBmhJfi1AM5ArXwnh3/ZucPivm
	X4sQ4khxMDAFQJ301/ngSTYlq66Upn5sYvAuks+C+ePmZzrkPEhGsUZyJzy6cNcVQ7wU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOVC0-000000008Dw-2lWs;
	Wed, 04 Nov 2026 07:13:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOVBv-000000008Dn-341M
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:13:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rIGe79H/49vBAHgU45yDFHFEWY9rDyV41oZ3I1YNmy8=; b=E5B5OLZsucw8fo5WWsnvApdIhk
 lf6KuuUSj8BfDTt+SyZW0PbkEkw4SCfF5CzjkQLwiYnY8yeLo7Oa8s0YuyQaP0k6Pfo5G0WudeIZ4
 +hfWRAfb9/rfJ1sI1hXjQzHp39+bs7v7L4ONH0eLYbNE44Dx2fZNgPYFzFaBXEIY/Oo8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rIGe79H/49vBAHgU45yDFHFEWY9rDyV41oZ3I1YNmy8=; b=NiaF5wIIMDHeEYPQPCKMK9FzdU
 sbXyTsx2UPdKKE/t98iwvcTpkToZaVIrfoiPw31kvJgOPp0GouNAv5Ci+LJ1XEMNSBk65cIDmDMJO
 ylsCEg0uijDJR9oXG20nhQEo9OIWBV5D6Guwfee4tKZ7Uj6S2cIXY45n8Rc18kjhE+lc=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOVBv-000000005mj-0At0 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:13:51 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso144271f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 23:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793776424; x=1794381224; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rIGe79H/49vBAHgU45yDFHFEWY9rDyV41oZ3I1YNmy8=;
 b=I0Uo7+Bm16msZjh76I5BmkaLS1L1lrjkSNwa1p5Rf8FjlUEAAOooSt5BEXhKpRubRn
 1HbxNJfNfllV7X28TORT6sYxKBojYtgwq1HRh+yOkrjPoHUIUW9xY+rN/lk+IfuGX1dx
 iE1iSdJ7AyHhd3NL4bpT9eqmumdXv5LqYVlRlTObR2j6kcBDYVX9qsj5304Ra3qc2V0j
 wp8MqocM5/wrkQYnxaxJ1MbUAKnabT0G8KRy+1DajCYqVaUtmFra4CtBuy3C5Xnv2Ebc
 91Izf413iUr3N4oQ2lfZICgr48VJl4wv7/DuFHJnAGb6lZNo9qTAGrjg4VHmkZyO7U32
 MvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793776424; x=1794381224;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rIGe79H/49vBAHgU45yDFHFEWY9rDyV41oZ3I1YNmy8=;
 b=WMQ8VFo14NdKbve16bCcYW28h8m/nb5LmfTP8O2cY7w53U+0uaUqWF6N3Ftvn1SXrM
 4cDOihQGZjOjEYPhhL6GRhHhDNtXz6PyasfR/A5rB3w6Kj1XRxYFFP6zH41/9Eu+wF6+
 1ptSc0rjHroAq6goEBhklJYRtZAd/SY4Uc56Or6S5W24cdl1SB+ao5gGhtkoLVBWfNOB
 Fvrw0Fsrmhb42vrFqd4lDK6LhsnOzuN9QcNQtZF3TZUZlFjahE6oxBhTDChraSiwDGxy
 eIqvDiSXEudrws6svN3LDEDosY2ASeOewajIt2CbosTaIEJDn7mRegr8zvxYUiTYPEh+
 v2ag==
X-Gm-Message-State: APuU4Z9AEAg4boWb24yzhU6rsa6ngK/IYhRIVN1Os6KtD0d1VxBwWth9
 lurZZVsVb/TsyRGWAf4hcUnetc0sPS0SMFLmr3j8QCSiJY9AflRIPL+ZyK6MQkJDGQYlpbS8b5X
 Kt1OI4AR8bZGU/hDAVxQG0pxTHOXGfVWD+87Skz8Xe53jMTJ6IZiw/0DcPJPX17IseoHG
X-Gm-Gg: AYBFou2X+NOl9sdmuvjVOUhXKJ4a9uNRkuaM6nHRPhC/w2r9S8j0oxsaSgUBJ4UiVIW
 7fQSK8BBf68tYwxnxpwcqN2dAlieME9K4REEHzwYP9a3ykILLcizYVDn6qqISowaQfy0jWsSKuw
 EFPt+UrF/eXL9SJYRDREFoBR8X0hkPjN3hphsngNd2MDKol4VM2jMjdXcioJtlE8+hD8BiCh7bA
 9CaLOqcbNly4tk9CWn19RGBdIbQs79hatCx0XENXY9+iNfY+7hO39CVunGZrS0V0Up4EmAJylyB
 nstz3RZBA3/wcPJjGFYs+N7d63krLlU5Lm+K1zsZEedYnbD3S2LvGqoPUEWs2R0M4tVifpOUGlE
 X3i5OZ0BZEEntDb54VEfyk+3qAlAZzjCd8AW3h67Q85RoJaO7Y926pypvQ3J1RBCCxRkLVTTPUv
 YNoemN8YYQVPBwhfnePyFWeRdV508ADR0Wb6A8jDWcFgP2fOUo5tWOAPckf+/SYhp7K1YmXp4PD
 rgPZeSxrSQ7ccBEQP9Bt3ZvxQOq23hmygXjx69nxZoR8wSFuw0CLXuFqEJY854rATF/7hd62sGn
 IDKICBFKPcxcEm7+5+vI0Xz0EKyOzHvnXFAjp9i9cw22rQD1fQmlIGBP+FXCzsDaXd3tl4gWTrb
 igXwseWFw3YKUrg55/nftVPfg1TdsHffosxd8xSE4UULpgXC8B6WgwpbIO/9BhOETUIikHl6zrh
 IaL5KaTaBopRXEky5kYwYxyWwbLH//StvREqUg
X-Received: by 2002:a05:6000:128b:b0:48c:69bd:e971 with SMTP id
 ffacd0b85a97d-48e6e307437mr24884487f8f.16.1793776424336; 
 Tue, 03 Nov 2026 23:13:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fec9cd43bsm2287891f8f.14.2026.11.03.23.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:13:42 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 07:13:42 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icab02b28773a409821fa9b80ccb1560d2796d1df
X-Gerrit-Change-Number: 2117
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2117?usp=email>
X-Gerrit-Commit: 0a434bfae460af3b651e1737ec38cef82c58b546
References: <gerrit.1793776420000.Icab02b28773a409821fa9b80ccb1560d2796d1df@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2NDIwMDAwLkljYWIwMmIyODc3M2E0MDk4MjFmYTliODBjY2IxNTYwZDI3OTZkMWRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fcdf526228f1726d4564319ebcee6ad591f5ec49-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOVBv-000000005mj-0At0
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tls_crypt: print
 tls-crypt-v2 client key hint before CRYPT_ERROR
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8722250899830272142=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8722250899830272142==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kE+jnyppnCo="; charset=UTF-8

--kE+jnyppnCo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2117?usp=3Demail

to review the following change=2E
=


Change subject: tls_crypt: print tls-crypt-v2 client key hint before CRYP=
T_ERROR
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tls_=
crypt: print tls-crypt-v2 client key hint before CRYPT_ERROR

CRYPT_ERROR()=
 jumps to error_exit, so the hint about a client key
generated for a differ=
ent server key was never printed=2E Log it first,
and drop a stray ')' from=
 it=2E

Broken since 7a477c16 ("Print a more user-friendly error when
tls-c=
rypt-v2 client auth fails")=2E

Change-Id: Icab02b28773a409821fa9b80ccb1560=
d2796d1df
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/=
openvpn/tls_crypt=2Ec
1 file changed, 2 insertions(+), 2 deletions(-)



  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/17/2117/1
=

diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 9=
9e2411=2E=2Ee769190 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvp=
n/tls_crypt=2Ec
@@ -488,9 +488,9 @@
     {
         dmsg(D_CRYPTO_DEBUG, "t=
ag      : %s", format_hex(tag, sizeof(tag_check), 0, &gc));
         dmsg(D=
_CRYPTO_DEBUG, "tag_check: %s", format_hex(tag_check, sizeof(tag_check), 0,=
 &gc));
-        CRYPT_ERROR("client key authentication error");
         m=
sg(D_TLS_DEBUG_LOW, "This might be a client-key that was generated for "
- =
                            "a different tls-crypt-v2 server key)");
+     =
                        "a different tls-crypt-v2 server key");
+        CR=
YPT_ERROR("client key authentication error");
     }
 
     if (BLENZ(&plai=
ntext) < sizeof(client_key->keys))

-- 
To view, visit https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2117?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: Icab02b28773a409821fa9b80ccb1560d2796d1df
Gerrit-Change-N=
umber: 2117
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--kE+jnyppnCo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2117?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">tls_crypt: print tls-crypt-v2 client key hint before CR=
YPT_ERROR<br><br>CRYPT_ERROR() jumps to error_exit, so the hint about a cli=
ent key<br>generated for a different server key was never printed=2E Log it=
 first,<br>and drop a stray &#39;)&#39; from it=2E<br><br>Broken since 7a47=
7c16 (&quot;Print a more user-friendly error when<br>tls-crypt-v2 client au=
th fails&quot;)=2E<br><br>Change-Id: Icab02b28773a409821fa9b80ccb1560d2796d=
1df<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<=
br>M src/openvpn/tls_crypt=2Ec<br>1 file changed, 2 insertions(+), 2 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/17/2117/1</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/tls_cryp=
t=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>index 99e2411=2E=2Ee76919=
0 100644</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</span><br><span>++=
+ b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -488,9 +488,9 @@</span><br=
><span>     {</span><br><span>         dmsg(D_CRYPTO_DEBUG, &quot;tag      =
: %s&quot;, format_hex(tag, sizeof(tag_check), 0, &amp;gc));</span><br><spa=
n>         dmsg(D_CRYPTO_DEBUG, &quot;tag_check: %s&quot;, format_hex(tag_c=
heck, sizeof(tag_check), 0, &amp;gc));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        CRYPT_ERROR(&quot;client key authentication error&=
quot;);</span><br><span>         msg(D_TLS_DEBUG_LOW, &quot;This might be a=
 client-key that was generated for &quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                             &quot;a different tls-cryp=
t-v2 server key)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                             &quot;a different tls-crypt-v2 server key=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CRY=
PT_ERROR(&quot;client key authentication error&quot;);</span><br><span>    =
 }</span><br><span> </span><br><span>     if (BLENZ(&amp;plaintext) &lt; si=
zeof(client_key-&gt;keys))</span><br></pre><p>To view, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2117?usp=3Demail">change 2117</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2117?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icab=
02b28773a409821fa9b80ccb1560d2796d1df </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2117 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--kE+jnyppnCo=--


--===============8722250899830272142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8722250899830272142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8722250899830272142==--

