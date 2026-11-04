Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3C9606A328
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cS0LKgxe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BeW0l9/4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eqwFQxeu;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gxG6YWhe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=DlG862RPfZ43j+5H+KFRCIzxa1OAx0NMpT360WR4enw=; b=cS0LKgxeDqnSM/2qBXjVYRoTa5
	Kkh1rc7ql6QgBEjk1YxJ+E4cAEbRcDHp5xX5El5Jk1a+gD5Br6+h6FpFeGHjg2jUBiWxVu1XIB6E6
	Q1OD6mZhOXna1gni2RpqxstWAG/PJZyB4h5CieHXa2RkNw+Vxa+0EQdAdIdX7dlB7y8U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOW65-000000000JH-1crL;
	Wed, 04 Nov 2026 08:11:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOW63-000000000J0-2XXm
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 08:11:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/DvQCaO1TFWXlMNg6ZaSIarT0I8mzaAN7EgzUG2DQPo=; b=BeW0l9/4vXnCC2JNYTck+Xaz92
 hYWq91TbBNlVj0q7E9+tWWE1HouBARBPvmYMm2dYWH6VAuIa9ugzqmutt9o/HeSFGef3g/MD1MNzR
 wMxJdZwlZ1seIxE5U++I4ZaMv+xZtlYHd7EYWaVnuTpm+ZyHYjMnt63keSKauWbwbFBA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/DvQCaO1TFWXlMNg6ZaSIarT0I8mzaAN7EgzUG2DQPo=; b=eqwFQxeuvzRTcKChq47TSk9qI5
 1787A/wMmMPaCZK2dRVKKNB/B2wuTKlnVpx9BDn6qmkIJDmkQxHAxZAIqsv/x0BqkpeHyzOa9Ol89
 AzgUZxrvXSeJg+IOx16petU8pPwkAULEVO5zSVUZ2cNi6E9n8adcYhE+aR/ctGIsTALE=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOW62-000000007YD-0pTR for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 08:11:51 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso2420155e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 00:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793779904; x=1794384704; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/DvQCaO1TFWXlMNg6ZaSIarT0I8mzaAN7EgzUG2DQPo=;
 b=gxG6YWheKMmqo4tDzluHR3osZyNc5hjRjiRE/L1zx5KePyL+DpBI4SNWjNVKMbG/Dk
 kKhpnXuDZsxYiy9Z8GwOSgkzoKggRWYJRnpdZd3RSRvI2UmXo7lyxdoH0P/NvbOS14+c
 IK6VKUaRiStK3DJ/NGppHWMCYbaqr5ikYJ0UPtDpdfdL52XaZmD+t8LftFBs6j0ysLgA
 e+AmyFK9bsEcAaJRe44tm0lz/kWdCkP8105PkkyayUxHxB06z5V6RAxLJwSmPiZmx0qd
 L+1st1HRs8aSPUEnJoQk8JIMSvbw78B6gTir5jhAKCJt0GsiZjUcQFhvtzh9gveX6HV+
 ELwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793779904; x=1794384704;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/DvQCaO1TFWXlMNg6ZaSIarT0I8mzaAN7EgzUG2DQPo=;
 b=YUKopkaF2GvKhNUA93c1RBtt1q1iyFKIjtvL2iRuISITG1V6p7LGhPHSfzkTxB+ne8
 HjgR79kpM6cqN8CHwN4MIsxVvsOHRfNN9IJLRlZGKMmsJ5hWU6kaZD/yWhTAWb3lbx4M
 gdscctRnaNZi/ewzdlDt0U+PhjUZzHV6oeC+aPgG36r8dg1bz/xJorifDFA0ZE9X9aR3
 sjalzWnxwlmzYllSpGMmu33ppVDhzdUFcPDjSEv1dwMEn7TbflGLoj+Rv7upgzd4UX0v
 zUVUtQzs0MNGZyuHg5UfFbXK5VrS94MrjLTXdPo4L84mze3RB5GJTgu2rIlzZs4L2RnQ
 xHYQ==
X-Gm-Message-State: APuU4Z8s6PJFLELXkkHFsQkBIMjqjBSsfhHEo4vMMow76RC914Yr+Snj
 VjIudeRV+zQ++D03kXI/Tl+pWqRmvt5CI01y2Ft3UHY8k0tVJGVjAZywFSVIPMK4rJEiSKkPGUz
 gbMwoJ5bOLH2VpP4uBrN2pj+Dh9m+VPwJMnHCUPlVZ92x9DPpiQ3+vYfUwXmW3OcaQpMCZubdDM
 ZuYAczsQ==
X-Gm-Gg: AYBFou0KQR9MxPGjjxmV7affyMwERPgtEOUndwOTSE5eY0AYDpy1zexUDkeTJjBR+Ux
 8u0Aij7zA5L+gTkmM9JakXHVoSvzCjIknuuUOPnYEpHJYM/rYX+6k0KBLIyBEf/kd4Ne3oyjsa0
 VdfrO1eu0EzX6/N58PupaRvJdByoxZQciihuFfyxEch99gTKH+LwXAx+3a3b+mU8PyqmGRPYm+l
 fXeaH+K1tmgM+b9uqkCCqD5Z6H5+Zb+TSBBgd5E0qpMGJkOLcm180Zf9NYcagk8k3O9y7z/d5br
 ALk5akNqXuHrGic1YVPHrE+Blf9GyFXtFSaaaFB6HsanqVq2WNgsTrRhd+MdD2czqNYPHfs0YNM
 Xeisj74MQPYhykuvXZMXRKuoofcqll2oxEnutD23Bc1J+3Cqhir5Ck2HA0sP81EaqCNs2IRI/it
 XKQicdo5do+LKqRqfOrCbYGHNkleBpxNZEuhOg9otj1vuC8qqLNY0bAy5eSaoee6CFbptvVtv2e
 aXf7shdWV8IPRYrws7KEtPN7fyGiH4F10PoV/nBlULirW+qNswBx3iXzZLdCnyZXmak0iyZbtNe
 Cdi/R8zmlVVryiEkTujCONqgSoyIB+hVX0G1WWmvOP3ZgLa4Bk9W+6xZJl0XlUBxb+xhplXMUpI
 a1FQTXF7UAAPsMsbtjT1S2xLRMKVqx88a31DyPmIVQhCtH93YpwIhDHjR0U9CvQ0ojyaZ3vEOoO
 PKUII/elfzSnMXCA==
X-Received: by 2002:a05:600c:8b61:b0:4a2:1398:dd05 with SMTP id
 5b1f17b1804b1-4ac17752ee4mr327070915e9.16.1793779903501; 
 Wed, 04 Nov 2026 00:11:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a9faff90sm137561805e9.5.2026.11.04.00.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:11:43 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 08:11:42 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I40059eb9af845a5070ebb8caff741b0794632de2
X-Gerrit-Change-Number: 2125
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2125?usp=email>
X-Gerrit-Commit: a003e1bde535265e928f2a91d79fa6205f1fc53f
References: <gerrit.1793779900000.I40059eb9af845a5070ebb8caff741b0794632de2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc5OTAwMDAwLkk0MDA1OWViOWFmODQ1YTUwNzBlYmI4Y2FmZjc0MWIwNzk0NjMyZGUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <18cf0ec275154bfa51d41d9070a7141ea2ab6ab5-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOW62-000000007YD-0pTR
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: drop unused
 input parameter of management_query_multiline()
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
Content-Type: multipart/mixed; boundary="===============2304719678227203449=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2304719678227203449==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PETsDekagmw="; charset=UTF-8

--PETsDekagmw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2125?usp=3Demail

to review the following change=2E
=


Change subject: manage: drop unused input parameter of management_query_m=
ultiline()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

m=
anage: drop unused input parameter of management_query_multiline()

The par=
ameter has never been used since the function was added in
39e3d336 ("Mac O=
S X Keychain management client")=2E Its callers read the
input list themsel=
ves=2E

Change-Id: I40059eb9af845a5070ebb8caff741b0794632de2
Signed-off-by:=
 Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/manage=2Ec
1 fil=
e changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/25/2125/1

diff --git a/src/openvpn/m=
anage=2Ec b/src/openvpn/manage=2Ec
index 58f63e6=2E=2E57a9561 100644
--- a/=
src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -3830,7 +3830,7 @@
 =

 static int
 management_query_multiline(struct management *man, const char=
 *b64_data, const char *prompt,
-                           const char *cmd=
, int *state, struct buffer_list **input)
+                           const=
 char *cmd, int *state)
 {
     struct gc_arena gc =3D gc_new();
     int r=
et =3D 0;
@@ -3914,7 +3914,7 @@
     int ok;
     char *result =3D NULL;
 
=
-    ok =3D management_query_multiline(man, b64_data, prompt, cmd, state, i=
nput);
+    ok =3D management_query_multiline(man, b64_data, prompt, cmd, s=
tate);
     if (ok && buffer_list_defined(*input))
     {
         buffer_l=
ist_aggregate_separator(*input, 10000, "\n");
@@ -3941,7 +3941,7 @@
 {
    =
 char *result =3D NULL;
 
-    const int ok =3D management_query_multiline(=
man, b64_data, prompt, cmd, state, input);
+    const int ok =3D management=
_query_multiline(man, b64_data, prompt, cmd, state);
     if (ok && buffer_=
list_defined(*input))
     {
         buffer_list_aggregate(*input, 2048);
=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2125?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I40059eb9af845a50=
70ebb8caff741b0794632de2
Gerrit-Change-Number: 2125
Gerrit-PatchSet: 1
Gerr=
it-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>

--PETsDekagmw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2125?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">manage: drop unused input parameter of management_query=
_multiline()<br><br>The parameter has never been used since the function wa=
s added in<br>39e3d336 (&quot;Mac OS X Keychain management client&quot;)=2E=
 Its callers read the<br>input list themselves=2E<br><br>Change-Id: I40059e=
b9af845a5070ebb8caff741b0794632de2<br>Signed-off-by: Razvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/manage=2Ec<br>1 file change=
d, 3 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/25/2125/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>ind=
ex 58f63e6=2E=2E57a9561 100644</span><br><span>--- a/src/openvpn/manage=2Ec=
</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -3830,7 +3=
830,7 @@</span><br><span> </span><br><span> static int</span><br><span> man=
agement_query_multiline(struct management *man, const char *b64_data, const=
 char *prompt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                    const char *cmd, int *state, struct buffer_list **input=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
         const char *cmd, int *state)</span><br><span> {</span><br><span>  =
   struct gc_arena gc =3D gc_new();</span><br><span>     int ret =3D 0;</sp=
an><br><span>@@ -3914,7 +3914,7 @@</span><br><span>     int ok;</span><br><=
span>     char *result =3D NULL;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ok =3D management_query_multiline(man, b64=
_data, prompt, cmd, state, input);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ok =3D management_query_multiline(man, b64_data, prompt,=
 cmd, state);</span><br><span>     if (ok &amp;&amp; buffer_list_defined(*i=
nput))</span><br><span>     {</span><br><span>         buffer_list_aggregat=
e_separator(*input, 10000, &quot;\n&quot;);</span><br><span>@@ -3941,7 +394=
1,7 @@</span><br><span> {</span><br><span>     char *result =3D NULL;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const=
 int ok =3D management_query_multiline(man, b64_data, prompt, cmd, state, i=
nput);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int=
 ok =3D management_query_multiline(man, b64_data, prompt, cmd, state);</spa=
n><br><span>     if (ok &amp;&amp; buffer_list_defined(*input))</span><br><=
span>     {</span><br><span>         buffer_list_aggregate(*input, 2048);</=
span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2125?usp=3Demail">change 2125</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2125?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: I40059eb9af845a5070ebb8caff741b07=
94632de2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2125 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>

</body></html>
--PETsDekagmw=--


--===============2304719678227203449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2304719678227203449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2304719678227203449==--

