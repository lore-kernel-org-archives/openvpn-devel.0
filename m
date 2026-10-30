Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11710606A31E
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=T3orELv1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OBZvp6PO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hlJNx5BG;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=B233mllY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=M0/bWYypOHPNPg1u3Ksy89ISUr/IivhsEc/6uEeFgtc=; b=T3orELv1OOvqxZ49kNYC8NyGXg
	ZEhXwizvmR1vbgXH0wB5XajJzfR9crPGJI1QIwnNIwnutwVmg4JA4TyaOF3Syi/WQgoJT+i154HGY
	ckB1uIUwaqGROr1M6RSJzK/y1e14JvvqJVUj9rPFR03kM69NabTvitBoSDDNDK/ZAm8Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMsTb-0000000066U-2EyT;
	Fri, 30 Oct 2026 19:41:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMsTZ-0000000066N-310H
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:41:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SHdKjr1kjQ7pgpg+Sl932q92FnD+KOmJS1Ei4oIV+Oo=; b=OBZvp6PO37SsUh8nhPzTcdMNJC
 FSlUAT+6SIg86yTjzBTmrWSE7V3emrhH0w4uSdfrtIEPD5xGBsjDh9Qz2Eu7v0z9jox5dyv6xD04d
 cbo4h4Ro2cD1iqqdU8SZO1a3aG6KhFwQA44hIyomHKIBKvoTEDNIHmBFnwJrWB6pLUx8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SHdKjr1kjQ7pgpg+Sl932q92FnD+KOmJS1Ei4oIV+Oo=; b=hlJNx5BG5Io/51eDSwLtOaDa23
 zxmvgPwtvCaL6tgMYcdFbCth9+SnA+YTmfKRt8mw6PdMADq77gfnu+nnj8xvzfI8i80jyI0p/Ppdw
 oBEbX6N6OokZOhCq88XkRF9BTATSEMp35jeL9FrDiXDIJXR0PtO0HMd1EPfmg84YIjXk=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMsTY-0000000075Q-3xTG for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:41:21 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so14559385e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 12:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793389274; x=1793994074; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SHdKjr1kjQ7pgpg+Sl932q92FnD+KOmJS1Ei4oIV+Oo=;
 b=B233mllYH48wbkIv4uBuOh+HdhnHzGP0ICNktCm5MOFXsowEp4EnyCEz+EjBUageSP
 fLVeft4Vzt07ljivVjjkfVl/0dh3Uq7nLBIX0Yz8pQrEySxMZPhA1iLq0xqoRMBJlY2s
 JBxUHe/S4x6n07U75NlQwctuU7bdTv27e6nM9PQwqCbRvbZALedi0VDTFee6xM9n/ylS
 HM2HTjdy0c9ubtK+BYrzWghoe5JXkrkJLFp1Hxe9UMUaYtAQox/LgBGL8JZMk4DAAQcK
 sgp4B+sDbIrThO/WASm9iIqCzv+uk0IhWWeEbSyQ01E4Biq/zx4oXfTzH/M4WEtAK7eo
 mzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793389274; x=1793994074;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SHdKjr1kjQ7pgpg+Sl932q92FnD+KOmJS1Ei4oIV+Oo=;
 b=rnhIW1epPWVDKPif/PicFhXmyRZuAslovirahbHfiTXpvDBTh9q794gG36IQTD7KxX
 5o2FxuvoF7iXnO5kyzWbrdETy2BfKVTdkHO8fxpZwnzS6RboAh8C+eX4Hd7K3PEkMf+c
 /floeeNgTOJ6OonHNFLfPJb0+260d4I8uhw7Y4Q4sMM1lvXO49Vr8JhSO0YRUb6TRHLf
 9M5qm/wJgfhdGf9lbueE2ru7N3oWnuBnbgKkUPnED/kb7uc7/R6j1ydZ3vCc1YUJeDck
 Kcl8vNgLf3uyrJ4giSflteLI3WaGwya+VNCJf+fI/T13Aj+dBtR+YdGc6Qm6L2W3BVM/
 Nm1A==
X-Gm-Message-State: AFq9FYIuT6HnLYYBfRtmYp1CMe9BoNZwZ814Y6BVfsC2c/0lgffNyawu
 t+67oYisLBgq9XVFv3gH8GAJO3WYlyFkRt6Ax6V1NGMy0xwde3ArdJBYtmMNTBxdmEvXfMAQkA3
 4wenM+McFqFlNgReoFlcHohQiEqH+uxLIRTZ70RM7opNG5/C3I4dOA44O3ovtSFz7CUj06z9/d2
 jvSdSOlA==
X-Gm-Gg: AYBFou3F0ywvuA0tp1Il7kf4nj4YqEkCBUbLXRXt7UAYB4eChSCsppKxFm57pn06Pic
 iLrL9NGPtJw0d+Y3EWPNlf7mzoacjeSpLgkOklaKg+Qy0+EIDucqCQxfXH0hGtwNSGV6Pt4K2OZ
 5mlxxkgiUpZsy8gaFMtGZxwv4rDMCntznOxuqk2zznHoj1nXC/eCOXKYqX7AgI1fXoP8R0cJUp9
 rJMYivrtDMoJ8SGLlbGqkWNqSTM7q6bcZfQIvvpEl77AnUSt8BM7+qAjE334mMzDMOCRyTt/4hz
 xQ3r9y443Zl+ZjEs1Bm/x3ERpf/rgwJY3Vjd0dzdMvC1JULlaU6A2GNpKkgRPXtrBbCoywGAHVd
 4iFt0jUX4Q8Nxuu5IzojWArWgU/tMyHEUGLNKxSuXT/R60h6mECRmLIIdWwWd+dH9ZT4WpVRDqn
 odZNZSXolWDXF3sNEgURJrHskEpF4jV08Iglk8gvDoqdTS9KY3O7mOCiNBXFbeyJrPNjtZv9LXx
 fUL2t6yIXLmlRwEHBaYXTlduh64PnozKrlY9D4kxx6RcN1U7WvcnMTvwh+Cf4JMRtv7+nRiHUre
 KQCIkmPD7+mbTFMWYek2SYJF1bZQar6wrS/LJcDd3D/0fhkAT8gYmXIPNEvuP8BTVDILLJBmrz2
 XDkZ4NHTREKESELSTO6mTgYneWsiY14dKjjGk/Rul7ataV7wVJdVDohRa4bDm//3HUjKu7gZ4ub
 xrwOPjgbHQV1x0dNI=
X-Received: by 2002:a05:600c:4ece:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4ac169d7e39mr75137655e9.5.1793389274317; 
 Fri, 30 Oct 2026 12:41:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0a762bc1sm33250165e9.4.2026.10.30.12.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:41:13 -0700 (PDT)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 19:41:13 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045
X-Gerrit-Change-Number: 2073
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2073?usp=email>
X-Gerrit-Commit: fcd51de7b4ed18d43d6acdec8bf148cf6323ffeb
References: <gerrit.1793389270000.Iea14ef08268e6f6309e4bac4acff27958da8b045@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMzg5MjcwMDAwLkllYTE0ZWYwODI2OGU2ZjYzMDllNGJhYzRhY2ZmMjc5NThkYThiMDQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <82d7bc6e4797176c93d22e44ea9c7964adccf631-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMsTY-0000000075Q-3xTG
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
Reply-To: selva.nair@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Selva Nair \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5552762439266655825=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5552762439266655825==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Kj3wHNbJwA4="; charset=UTF-8

--Kj3wHNbJwA4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2073?usp=3Demail

to review the following change=2E
=


Change subject: Increase the buffer size for alert-message in management =
user-pass query
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Increase the buffer size for alert-message in management user-pass que=
ry

Increase the buffer size from 128 to 256 to accommodate a reasonably
lo=
ng username and static challenge message when both are included in
the prom=
pt=2E Print a warning if the text is truncated=2E

Change-Id: Iea14ef08268e=
6f6309e4bac4acff27958da8b045
Signed-off-by: Selva Nair <selva=2Enair@gmail=
=2Ecom>
---
M src/openvpn/manage=2Ec
1 file changed, 12 insertions(+), 6 de=
letions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/73/2073/1

diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=
=2Ec
index 65e2881=2E=2Eacd64be 100644
--- a/src/openvpn/manage=2Ec
+++ b/s=
rc/openvpn/manage=2Ec
@@ -3618,7 +3618,7 @@
     {
         volatile int si=
gnal_received =3D 0;
         const bool standalone_disabled_save =3D man->=
persist=2Estandalone_disabled;
-        struct buffer alert_msg =3D alloc_b=
uf_gc(128, &gc);
+        struct buffer alert_msg =3D alloc_buf_gc(256, &gc=
);
         const char *alert_type =3D NULL;
         const char *prefix =
=3D NULL;
         unsigned int up_query_mode =3D 0;
@@ -3682,7 +3682,10 @@=

             char *user64 =3D NULL;
             if (openvpn_base64_encode=
(up->username, (int)strlen(up->username), &user64) !=3D -1)
             {
=
-                buf_printf(&alert_msg, " UN:%s", user64);
+               =
 if (!buf_printf(&alert_msg, " UN:%s", user64))
+                {
+       =
             msg(M_WARN | M_INFO, "UN:<username> in user-pass prompt sent t=
o management got truncated=2E");
+                }
             }
        =
     else
             {
@@ -3693,10 +3696,13 @@
 
         if (sc)
       =
  {
-            buf_printf(&alert_msg, " SC:%d,%s",
-                     =
  BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECHO)
-                 =
          | (BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_CONCAT) << 1)=
,
-                       sc);
+            if (!buf_printf(&alert_msg, " S=
C:%d,%s",
+                            BOOL_CAST(flags & GET_USER_PASS_STAT=
IC_CHALLENGE_ECHO)
+                                | (BOOL_CAST(flags & GE=
T_USER_PASS_STATIC_CHALLENGE_CONCAT) << 1),
+                            sc=
))
+            {
+                msg(M_WARN | M_INFO, "SC:<challenge-text=
> in user-pass prompt sent to management got truncated=2E");
+            }=

         }
 
         man_wait_for_client_connection(man, &signal_received=
, 0, MWCC_PASSWORD_WAIT);

-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2073?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045
Gerrit-Change-Number: 20=
73
Gerrit-PatchSet: 1
Gerrit-Owner: Selva Nair <selva=2Enair@gmail=2Ecom>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>

--Kj3wHNbJwA4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Selva Nair would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Increase the buffer size for alert-message in management user-pas=
s query<br><br>Increase the buffer size from 128 to 256 to accommodate a re=
asonably<br>long username and static challenge message when both are includ=
ed in<br>the prompt=2E Print a warning if the text is truncated=2E<br><br>C=
hange-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045<br>Signed-off-by: Selva=
 Nair &lt;selva=2Enair@gmail=2Ecom&gt;<br>---<br>M src/openvpn/manage=2Ec<b=
r>1 file changed, 12 insertions(+), 6 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/73/207=
3/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</s=
pan><br><span>index 65e2881=2E=2Eacd64be 100644</span><br><span>--- a/src/o=
penvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><s=
pan>@@ -3618,7 +3618,7 @@</span><br><span>     {</span><br><span>         v=
olatile int signal_received =3D 0;</span><br><span>         const bool stan=
dalone_disabled_save =3D man-&gt;persist=2Estandalone_disabled;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        struct buffer alert_msg =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        struct buffer alert_msg =3D alloc_buf_gc(256, &amp;gc);=
</span><br><span>         const char *alert_type =3D NULL;</span><br><span>=
         const char *prefix =3D NULL;</span><br><span>         unsigned int=
 up_query_mode =3D 0;</span><br><span>@@ -3682,7 +3682,10 @@</span><br><spa=
n>             char *user64 =3D NULL;</span><br><span>             if (open=
vpn_base64_encode(up-&gt;username, (int)strlen(up-&gt;username), &amp;user6=
4) !=3D -1)</span><br><span>             {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                buf_printf(&amp;alert_msg, &quot; UN:%=
s&quot;, user64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              if (!buf_printf(&amp;alert_msg, &quot; UN:%s&quot;, user64))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    ms=
g(M_WARN | M_INFO, &quot;UN:&lt;username&gt; in user-pass prompt sent to ma=
nagement got truncated=2E&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                }</span><br><span>             }</span><br><s=
pan>             else</span><br><span>             {</span><br><span>@@ -36=
93,10 +3696,13 @@</span><br><span> </span><br><span>         if (sc)</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           buf_printf(&amp;alert_msg, &quot; SC:%d,%s&quot;,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                       BOOL_CAST(fla=
gs &amp; GET_USER_PASS_STATIC_CHALLENGE_ECHO)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                           | (BOOL_CAST(flags &amp;=
 GET_USER_PASS_STATIC_CHALLENGE_CONCAT) &lt;&lt; 1),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                       sc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (!buf_printf(&amp;al=
ert_msg, &quot; SC:%d,%s&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                            BOOL_CAST(flags &amp; GET_USER_PASS=
_STATIC_CHALLENGE_ECHO)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                | (BOOL_CAST(flags &amp; GET_USER_PASS_=
STATIC_CHALLENGE_CONCAT) &lt;&lt; 1),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                            sc))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                msg(M_WARN | M_INFO, &quot;SC:&lt;=
challenge-text&gt; in user-pass prompt sent to management got truncated=2E&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span>         }</span><br><span> </span><br><span>         man=
_wait_for_client_connection(man, &amp;signal_received, 0, MWCC_PASSWORD_WAI=
T);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2073?usp=3Demail">change 2073</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: Iea14ef08268e6f6309e4bac4ac=
ff27958da8b045 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 20=
73 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>

</body></html>
--Kj3wHNbJwA4=--


--===============5552762439266655825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5552762439266655825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5552762439266655825==--

