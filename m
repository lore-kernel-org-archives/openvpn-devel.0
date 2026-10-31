Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DE1606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZSlk8M0I;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LNAV4DV+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XZjJeIYe;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QDuCMc3a
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BNmQCjUg9ePY/+JySl1MXoRiOtCBFcErar8kur8MJTc=; b=ZSlk8M0I0cX7Q+UC7N6LpQHYKy
	ejCE5JNmaLRVZnwHbaIIjT8SpZocbeLJZwTj8//WuGLOKb5LdlPTM2vC+9dLzwEta1HWzcuDFp7+5
	z64IE1D9/uVMvXfOQOTLes+mYGd3J6iJwYFQiqiFvlA8arfzia1NHAhyca/KH8lV5imo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMwsu-000000002EP-3rB4;
	Sat, 31 Oct 2026 00:23:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMwsc-000000002CW-3nvC
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 00:23:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bMzQK6hwKw8UHS0xmDy6j8dxfVTYU1Vz5gWL8E1OKI4=; b=LNAV4DV+OY6k0LJWSveHUwwMPz
 9tHgfDEusO+QhAByu/sum3INKV4xy838lvyHx4VzwdIjhJbDHZzs1gG1yAi3BJjLtQ2IqF0Ytpcmo
 2eZ3JAdUVp7+n/AvSQ/FH4yqrpJWBvGui/Wp5bs1oXj5TDw2/dza5Wmj90LdxlHS1bs0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bMzQK6hwKw8UHS0xmDy6j8dxfVTYU1Vz5gWL8E1OKI4=; b=XZjJeIYePkTTYCZgGUgvSAD/IH
 PVGqRDtqYywW512tfyJIx47/R67ck78o2mpqIF4dHA2jEwqBnzU7IW1kO4D6x0BxxammDeb0jnJ0A
 fMCPHTXVqViDMrgEWPvlDCEWJ+Y8rBw6DYyPgUZAqiuubNF+50FbK9B++3Hy2ioEqxtM=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMwsQ-000000007eB-0CpO for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 00:23:19 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48df8fe8513so1101063f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 17:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793406191; x=1794010991; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bMzQK6hwKw8UHS0xmDy6j8dxfVTYU1Vz5gWL8E1OKI4=;
 b=QDuCMc3aLJCXwQi6PS3Cz4v6/GYouL1hvuPaiMEEru9uLEwsUgu6UD/TPT4y84MyHO
 cwjmEpDEBAMuG88mCXfInb01QyEvIKUCUBCp7udIBONW0Pp8IwPT1joJcpwwWubLtk4s
 rGOMk7GJi3IxYXKiTirxmybN9eSd5sLhCZ3wjGRneJQhOteKHgS/omao4e+GlFvn7iPh
 VciWkX8g/mW2dJAwwpPP4uXQcepbIkRnp+7bd3lrYeh2quXfZwXYXR//fwTWuZgMVWaV
 t6pjztv+sTJaICX9+/aQksd9xiKXyypE9ZVgIaGe6ZAuGp4L+jXPyYoIuTNYyXJGPrgX
 dtxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793406191; x=1794010991;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bMzQK6hwKw8UHS0xmDy6j8dxfVTYU1Vz5gWL8E1OKI4=;
 b=hOI1Mx/ya+ripuZ+Hb7eUuVUiePiJ9lnbb9A3CXamzcsMX/UUT6pmarOOaRewkMbUH
 xy1An9OoQ9DBiZNAY7+pn4kEwNafBI3xAn2CRE+b3Sszx12TKA+IXHhTAJS0zDw6BDSB
 /ZB/dGe4GXeLx4QybPL5pVYmGsyGFHOoQbyq1dZqHDSfR8xnzRPOEBLOjGUxDXlPMfzj
 mt9lx1nNpREtD9n+q98ySPxJwvuH6H7yb3abeB/1wFJlzOdvdpF1CTDtZuQW4Z09bodY
 /9d+0CT0gtWJB+f30LdKb0tuTrWgLyldcEICuWni9f6JtmXs4qZufgi+X4yfPapsr+Qe
 GXBg==
X-Gm-Message-State: AFq9FYKaPMbqItuAWG8CAM/HRWuOT5yJHasGp3uHUDy7bxCo+tN6T4XA
 oPtXydru0apQIGTFIQqu+swIC7NlU1ERe7ZzFm5GX350CkJbGlwneS7L2NgC+kc7JSzSGwnGS6k
 FRnC189JeUbOjDrAdkVRSdgu5tAjlIllgUxLnWfbq11ZwAg6Ila2MJ1rokkm8RMUYK+Ec
X-Gm-Gg: AYBFou2Rf0J/36f9eIdFfh3DUlgr31ijXUtttrSo2lHcrraXceqYs+XuoBGeFoJvLZY
 BGo/qqRtqlMlGV2Ske5REIwuBigwRoDHLRa0NFMHNH32W91uIavORchB9NPp9E2YAS4xBCTCcU0
 f/M33N9kQTmYDo20tBv+TVPpKNSw18YkwTji9vWQfal9QEHIajrfw00Hb7z/sDJTSSk7qFqD/iM
 PP6VU7/TohgZ+h5+wLSVt1sEmAwmfRfrPbWTDflkp9hWA1QASnoFqmUh7iax7ZPRiyOZ1vN74Eb
 0X8Een0/NsyUZJtW3GiCFsX9k4kxrY8huZ4FC5MSNSqThyWkDrypDtlVo7QicdsX2pYkpRTgXn2
 8s+e51Yne2ogUsJXkgReSaEiAeJyeVkBMgGxLMFO0FMTe4XZ4LhF1jem+xEfm9FCx03FYlCo9/M
 VY+me4xva7AwnAPr5kifB37WbAxUAJf7k7A2WOlA6tZUOdWgjB4HbzyqDG/2wXQcTZp+pQxU4we
 q5b5oS1vUvcfTNldGNf0LNyHGJacNHR0PVX2kdAwcuNCZtcqUYiwo55l4oKJ6vF+h1XSH5L47iq
 dwwUe6rt1eRlTUxEhtpXAtO3iyyMi2tjORHzUfXO6Em1Sm4emKJijqr0F8pe1LcMG/DqvHPYblY
 qIdF8+joljieG3rjI0nZtU1lQB1koqSIFsufd2QTKOv2MA1cHSDnb68T4KHfA7e0VqE90KQVENz
 mKS9XtzK/lN74afGs=
X-Received: by 2002:a05:6000:2504:b0:48e:5df9:1ec9 with SMTP id
 ffacd0b85a97d-48e6e500979mr8308486f8f.24.1793406191284; 
 Fri, 30 Oct 2026 17:23:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d511sm5763540f8f.8.2026.10.30.17.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 17:23:10 -0700 (PDT)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 00:23:09 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045
X-Gerrit-Change-Number: 2073
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2073?usp=email>
X-Gerrit-Commit: 96c6b6477a3538e936b0043ac238579e58f501f1
In-Reply-To: <gerrit.1793389270000.Iea14ef08268e6f6309e4bac4acff27958da8b045@gerrit.openvpn.net>
References: <gerrit.1793389270000.Iea14ef08268e6f6309e4bac4acff27958da8b045@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMzg5MjcwMDAwLkllYTE0ZWYwODI2OGU2ZjYzMDllNGJhYzRhY2ZmMjc5NThkYThiMDQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <572e422e0a76f70309f7cd61b0b085d625ec312d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMwsQ-000000007eB-0CpO
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Increase the buffer
 size for alert-message in management user-pass query
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Selva Nair \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: selva.nair@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Selva Nair \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0830647438506217238=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0830647438506217238==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s5IoEvv6GLw="; charset=UTF-8

--s5IoEvv6GLw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a c=
hange=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?=
usp=3Demail

to look at the new patch set (#2)=2E

The following approvals =
got outdated and were removed:
Code-Review-1 by R=C4=83zvan Cojocaru


Chan=
ge subject: Increase the buffer size for alert-message in management user-p=
ass query
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

I=
ncrease the buffer size for alert-message in management user-pass query

In=
crease the buffer size from 128 to 256 to accommodate a reasonably
long use=
rname and static challenge message when both are included in
the prompt=2E =
Print a warning if the text is truncated=2E

If the encoded " UN:<username-=
base64>" string is longer than 128 bytes,
skip adding it to the prompt=2E P=
rint a warning=2E This caters to up to
about 90 bytes long usernames=2E

Ch=
ange-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045
Signed-off-by: Selva Nai=
r <selva=2Enair@gmail=2Ecom>
---
M src/openvpn/manage=2Ec
1 file changed, 1=
6 insertions(+), 8 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/73/2073/2

diff --git a/src/openvpn/manage=2Ec b/=
src/openvpn/manage=2Ec
index 65e2881=2E=2E16864c8 100644
--- a/src/openvpn/=
manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -3618,7 +3618,7 @@
     {
      =
   volatile int signal_received =3D 0;
         const bool standalone_disab=
led_save =3D man->persist=2Estandalone_disabled;
-        struct buffer ale=
rt_msg =3D alloc_buf_gc(128, &gc);
+        struct buffer alert_msg =3D all=
oc_buf_gc(256, &gc);
         const char *alert_type =3D NULL;
         con=
st char *prefix =3D NULL;
         unsigned int up_query_mode =3D 0;
@@ -36=
80,23 +3680,31 @@
              * Indicate it in the prompt as base64 encod=
ed=2E
              */
             char *user64 =3D NULL;
-            if =
(openvpn_base64_encode(up->username, (int)strlen(up->username), &user64) !=
=3D -1)
+            const int user64_len =3D openvpn_base64_encode(up->use=
rname, (int)strlen(up->username), &user64);
+            if (user64_len =3D=
=3D -1)
             {
-                buf_printf(&alert_msg, " UN:%s", us=
er64);
+                msg(M_NONFATAL, "ERROR: could not base64-encode use=
rname");
+            }
+            else if (user64_len + 4 > 128)
+      =
      {
+                msg(M_WARN | M_INFO, "Preferred username too long =
for user-pass prompt sent to management; omitting UN:<username> hint=2E");
=
             }
             else
             {
-                msg(M_NONF=
ATAL, "ERROR: could not base64-encode username");
+                buf_prin=
tf(&alert_msg, " UN:%s", user64);
             }
             free(user64);=

         }
 
         if (sc)
         {
-            buf_printf(&alert_ms=
g, " SC:%d,%s",
-                       BOOL_CAST(flags & GET_USER_PASS_STA=
TIC_CHALLENGE_ECHO)
-                           | (BOOL_CAST(flags & GET_US=
ER_PASS_STATIC_CHALLENGE_CONCAT) << 1),
-                       sc);
+     =
       if (!buf_printf(&alert_msg, " SC:%d,%s",
+                          =
  BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO)
+                 =
               | (BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_CONCAT) =
<< 1),
+                            sc))
+            {
+                ms=
g(M_WARN | M_INFO, "SC:<challenge-text> in user-pass prompt sent to managem=
ent got truncated=2E");
+            }
         }
 
         man_wait_for_c=
lient_connection(man, &signal_received, 0, MWCC_PASSWORD_WAIT);

-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iea14ef08268e6f6309e4bac4=
acff27958da8b045
Gerrit-Change-Number: 2073
Gerrit-PatchSet: 2
Gerrit-Owner=
: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-At=
tention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--s5IoEvv6GLw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Selva N=
air <strong>uploaded patch set #2</strong> to this change=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Rev=
iew-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Increase the buffer size for=
 alert-message in management user-pass query<br><br>Increase the buffer siz=
e from 128 to 256 to accommodate a reasonably<br>long username and static c=
hallenge message when both are included in<br>the prompt=2E Print a warning=
 if the text is truncated=2E<br><br>If the encoded &quot; UN:&lt;username-b=
ase64&gt;&quot; string is longer than 128 bytes,<br>skip adding it to the p=
rompt=2E Print a warning=2E This caters to up to<br>about 90 bytes long use=
rnames=2E<br><br>Change-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045<br>Si=
gned-off-by: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt;<br>---<br>M src/op=
envpn/manage=2Ec<br>1 file changed, 16 insertions(+), 8 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/73/2073/2</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/open=
vpn/manage=2Ec</span><br><span>index 65e2881=2E=2E16864c8 100644</span><br>=
<span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=
=2Ec</span><br><span>@@ -3618,7 +3618,7 @@</span><br><span>     {</span><br=
><span>         volatile int signal_received =3D 0;</span><br><span>       =
  const bool standalone_disabled_save =3D man-&gt;persist=2Estandalone_disa=
bled;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct b=
uffer alert_msg =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct buffer alert_msg =3D alloc_buf_g=
c(256, &amp;gc);</span><br><span>         const char *alert_type =3D NULL;<=
/span><br><span>         const char *prefix =3D NULL;</span><br><span>     =
    unsigned int up_query_mode =3D 0;</span><br><span>@@ -3680,23 +3680,31 =
@@</span><br><span>              * Indicate it in the prompt as base64 enco=
ded=2E</span><br><span>              */</span><br><span>             char *=
user64 =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       if (openvpn_base64_encode(up-&gt;username, (int)strlen(up-&gt;userna=
me), &amp;user64) !=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            const int user64_len =3D openvpn_base64_encode(up-&gt;us=
ername, (int)strlen(up-&gt;username), &amp;user64);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (user64_len =3D=3D -1)</sp=
an><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                buf_printf(&amp;alert_msg, &quot; UN:%s&quot;, user64=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m=
sg(M_NONFATAL, &quot;ERROR: could not base64-encode username&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            else if (user64_len =
+ 4 &gt; 128)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    msg(M_WARN | M_INFO, &quot;Preferred username too long for user-pass pr=
ompt sent to management; omitting UN:&lt;username&gt; hint=2E&quot;);</span=
><br><span>             }</span><br><span>             else</span><br><span=
>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          msg(M_NONFATAL, &quot;ERROR: could not base64-encode username&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 buf_printf(&amp;alert_msg, &quot; UN:%s&quot;, user64);</span><br><span>  =
           }</span><br><span>             free(user64);</span><br><span>   =
      }</span><br><span> </span><br><span>         if (sc)</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 buf_printf(&amp;alert_msg, &quot; SC:%d,%s&quot;,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                       BOOL_CAST(flags &amp; G=
ET_USER_PASS_STATIC_CHALLENGE_ECHO)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                           | (BOOL_CAST(flags &amp; GET_USER_=
PASS_STATIC_CHALLENGE_CONCAT) &lt;&lt; 1),</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                       sc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            if (!buf_printf(&amp;alert_msg, &q=
uot; SC:%d,%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                            BOOL_CAST(flags &amp; GET_USER_PASS_STATIC_CHA=
LLENGE_ECHO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                         | (BOOL_CAST(flags &amp; GET_USER_PASS_STATIC_CHAL=
LENGE_CONCAT) &lt;&lt; 1),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                            sc))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                msg(M_WARN | M_INFO, &quot;SC:&lt;challenge-t=
ext&gt; in user-pass prompt sent to management got truncated=2E&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span>         }</span><br><span> </span><br><span>         man_wait_for_c=
lient_connection(man, &amp;signal_received, 0, MWCC_PASSWORD_WAIT);</span><=
br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2073?usp=3Demail">change 2073</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2073?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Iea14ef08268e6f6309e4bac4acff27958da8b=
045 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2073 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</bo=
dy></html>
--s5IoEvv6GLw=--


--===============0830647438506217238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0830647438506217238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0830647438506217238==--

