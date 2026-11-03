Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EAF606A328
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bvmhSflB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OyLtHCnR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=g4pZEGOG;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HrWNUyI5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=X3VXXkb4i4x5F5xa3XHm2ghqnAANE+amlca+2eC8nHo=; b=bvmhSflBILWRgNFMyfzq3EV4hX
	gv8XaYGhI9Y8hOc3m5WUEZyxY49+FGOJjyIwprnAhNfwTVQ/nLicG6V1+uqsRzaerns/9G4fgShYE
	aMylek7d2FPdjnH7nDT0N1wIXWXRxYcS9WxjUqiBdWuwr6KX4T3FD2T65S3Mv9eh2SXQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOHLw-000000000R5-3xx3;
	Tue, 03 Nov 2026 16:27:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOHLw-000000000Qo-0GqC
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:27:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F8eIE6tc8KkRCBkwwSLs6KCNEm9AbaGIQHsfixE1lLk=; b=OyLtHCnReDe3+U0Q5yUW8x9ak1
 bVkOukjvq1OF0DH47WCuygz49WDG7+SyB86OGLY6LkANUOX1SmqcwwE+UyU+uyX38RIXMeuE9zq1c
 9YMVSrgHJOqB1R+IhhkKiNSYvNPG+dFcBnJ/9MRIif3nAsCgMMD+h3TXsvWaPYZ4WBas=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F8eIE6tc8KkRCBkwwSLs6KCNEm9AbaGIQHsfixE1lLk=; b=g4pZEGOGGgWN7dVTkbCpxuW1T2
 xvG8Zn/Iv67tELpk0RTFPRarPWR9vFRQ9cFWYnQt0O1ieqBjG+lEZm/Il+4J+1Hh0jT93x71vCH0k
 kpgHbMLKX9AX0Iv3HMjoMsC0DrBI7jVGlA5/LdQlg7JTlO4J/0KiREsgIbDlY0SR95AY=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOHLu-0000000087B-2bsL for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 16:27:15 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso31719385e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 08:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793723228; x=1794328028; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F8eIE6tc8KkRCBkwwSLs6KCNEm9AbaGIQHsfixE1lLk=;
 b=HrWNUyI5IemXRM2VlPnqKp8D+1u4qbfoTDORC3Id9fWV5wsZp3s/ny6DVehKTrGNx4
 5wd9oXRoQZtdut8G882KPQ+IAeNS07CfgK3lMGMXadULLhZ4BFUjFbXPnvLmy9NORKuM
 5E+STlZvMrLf8AXQK4AmhKvsK2RN4qcUt/MCkm9Fn2yJ1pmxKIAiKj7kko/qxe5QLRbV
 D16Wlf8UHptHs+mJusBoZJZtz4KNah0Cu+GZHV44xAf1zxIWPmGUbE5eD+qiqXuAATvC
 fMAffTmvMHmjHcReP44PdRUmtq9+t2Vw/lsbcvOl2yzHj48OOjAnNW2svLYfDw51oFnY
 w4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793723228; x=1794328028;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=F8eIE6tc8KkRCBkwwSLs6KCNEm9AbaGIQHsfixE1lLk=;
 b=jDU2+J1Mi+F4XmKz/xM9kknTugioIOdftCS+yYTuIGX6W4RDucOB65hjpnyxfYwZxU
 McA6tq4Cd9Veeq5dkUXx5h4y4g2IhRISySG2xJhRjrtBqgzkOKOrxF5zE2Bi/0qgFJBZ
 hAVW93o9GRzSNqfeMGw/wytJg+hyj3V8Wlh6fOF586ZSgRocSHaCp0v715PhzumVKcCk
 MXj61sb7CHxGy6jf8XRRdtew6+N3yUXQ4ceNcnG3RCNztK/OIk6dljnJTpw1wbkxW5zY
 HBDKh2jVCod8Y3ZjmX2W0RHo+sph6eKvoZlsnMjyYFaq8fAakd48wglhwKCFFHArAaiw
 rdJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxi4lQXUcDa3TrI/EEvccqu1VytMMFkiGIOmLbLTIDC6LCoWM4LNj+TdIGkRgfxcn07h/Ws3V+LG1sEq1WG@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9nR7oAoR+sYkANON+ZqzqA8INz5UZLNrytqw7GSImOk2oKOAaV
 m/YjJeivG3OolKPUSeF5jsMgKZxhiSfYurRWmJba8nFrsh2GhKfIX8weR0QAJtJPLonr4Bck2/R
 AnIe8430UxMRxvUtBb93Tnwdex1c0Csi7m4tkt3qf8OAhsUfJxcvlEpQE5B9Kw6Z7qQ53
X-Gm-Gg: AYBFou0RAYKUndezTVUBIPvaOzAdISa6W+lv7P6Om83YZuSH5tQAcbI7VIr4LchTrf5
 e9UzIyxBxsu4+Sf8qlrjm1VH+Nqg85yzxQ5DsvzKVRjKGxaRp2P4RQQkBTR1UAZf7hO8Li89Fkb
 xl9gjeksHCjCJ2yFRzkHmVYbPoRyngbMFfNNFmY8jNMHRvObOkKqzHRTxia2XFujnJIION5jrK7
 OK1p5fKIfgshfJJ8eQ2e4JdbPursmxx7rDcVP2dgY7I0XsKZkKc5rF42hrdDbyPzGhPL6FdL3wE
 TvvFfSRm5S6L9/9wJoIDbtO/9acGxb9SX1JX56uspC61kuo79OEPTv9L4TC5mYRjZ7rrGm3K7Vb
 Uz4OdHENn0aeEK8bCEt8XIaASEd88tdjrxFS8Wq5Gx9gRDYU6wEojYBRm6aGjK0ilQfCCn4IoBV
 3QZ1dffMMYuCTdDPTqrs4UAgmO8iYiioCY26fPzuOp6JUqaHJFnlGHTwRzvZkwQ1FSLncWiewIN
 4tPgLTw6S/frKfGNGEUEI+dB2oVPWrofSSeOdoeBdwKkbk/am+MhYuXZeM3PRSJyU3oijsgx8Ox
 zXANjO8P9CZ0hRrhmmEFSQwPJpfiyjNT3AZCbzZY7RGRdPWPyUNle600exDet2cv4X3nn8jNK3k
 7cCn+t3BHxgaMXbZN8m4qZHc5LR860rKDCSB/tCxNmBB+XRLTZ2PRQyP5Cog/4IRc3pKvGTGeWN
 3PEerCp+x1PzoI1A==
X-Received: by 2002:a05:600c:a012:b0:49f:fd2d:23c7 with SMTP id
 5b1f17b1804b1-4ac17b2ce18mr303605555e9.27.1793723227766; 
 Tue, 03 Nov 2026 08:27:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2afee292bsm76093885e9.4.2026.11.03.08.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 08:27:07 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 16:27:07 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id6587b3d44d3326cae83c460cd85e8570ee8666a
X-Gerrit-Change-Number: 2089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2089?usp=email>
X-Gerrit-Commit: abc1f3260bc11373d671dd7ad3a9e97ec489a7f5
In-Reply-To: <gerrit.1793623141000.Id6587b3d44d3326cae83c460cd85e8570ee8666a@gerrit.openvpn.net>
References: <gerrit.1793623141000.Id6587b3d44d3326cae83c460cd85e8570ee8666a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjIzMTQxMDAwLklkNjU4N2IzZDQ0ZDMzMjZjYWU4M2M0NjBjZDg1ZTg1NzBlZTg2NjZhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7a15cef6d0a5d52094db8df48747ed5732b91423-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOHLu-0000000087B-2bsL
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto: assert opt
 before first use in openvpn_decrypt_aead()
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
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5139896347016819852=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5139896347016819852==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NVxxhJcx/Nw="; charset=UTF-8

--NVxxhJcx/Nw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2089?usp=3Demail )

Change subject: crypto: assert opt before f=
irst use in openvpn_decrypt_aead()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

crypto: assert opt before first use in openvpn_decry=
pt_aead()

opt was dereferenced before ASSERT(opt)=2E Move the assertion up=
=2E

Change-Id: Id6587b3d44d3326cae83c460cd85e8570ee8666a
Signed-off-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Steffan Karger <steffan@kar=
ger=2Eme>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2089
Messa=
ge-Id: <20261102141556=2E29908-1-gert@greenie=2Emuc=2Ede>
URL: https://lore=
=2Ekernel=2Eorg/openvpn-devel/20261102141556=2E29908-1-gert@greenie=2Emuc=
=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openv=
pn/crypto=2Ec
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git =
a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index ff17b22=2E=2E2d91c6=
0 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -440,=
6 +440,7 @@
     struct gc_arena gc;
     gc_init(&gc);
 
+    ASSERT(opt);=

     struct key_ctx *ctx =3D &opt->key_ctx_bi=2Edecrypt;
     const bool u=
se_epoch_data_format =3D opt->flags & CO_EPOCH_DATA_KEY_FORMAT;
     if (!u=
se_epoch_data_format && cipher_decrypt_verify_fail_exceeded(ctx))
@@ -450,7=
 +451,6 @@
     const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;
 
 
-    AS=
SERT(opt);
     ASSERT(frame);
     ASSERT(buf->len > 0);
     ASSERT(ctx->=
cipher);

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/208=
9?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id6587b3d44=
d3326cae83c460cd85e8570ee8666a
Gerrit-Change-Number: 2089
Gerrit-PatchSet: =
3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Steffan Karge=
r <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>

--NVxxhJcx/Nw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2089?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">crypto: assert opt before first us=
e in openvpn_decrypt_aead()<br><br>opt was dereferenced before ASSERT(opt)=
=2E Move the assertion up=2E<br><br>Change-Id: Id6587b3d44d3326cae83c460cd8=
5e8570ee8666a<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t;<br>Acked-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2089<br>Message-Id: &lt;202611021=
41556=2E29908-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=
=2Eorg/openvpn-devel/20261102141556=2E29908-1-gert@greenie=2Emuc=2Ede<br>Si=
gned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/o=
penvpn/crypto=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br><=
/pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span=
><br><span>index ff17b22=2E=2E2d91c60 100644</span><br><span>--- a/src/open=
vpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span=
>@@ -440,6 +440,7 @@</span><br><span>     struct gc_arena gc;</span><br><sp=
an>     gc_init(&amp;gc);</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ASSERT(opt);</span><br><span>     struct key_ct=
x *ctx =3D &amp;opt-&gt;key_ctx_bi=2Edecrypt;</span><br><span>     const bo=
ol use_epoch_data_format =3D opt-&gt;flags &amp; CO_EPOCH_DATA_KEY_FORMAT;<=
/span><br><span>     if (!use_epoch_data_format &amp;&amp; cipher_decrypt_v=
erify_fail_exceeded(ctx))</span><br><span>@@ -450,7 +451,6 @@</span><br><sp=
an>     const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;</span><br><span> </=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    A=
SSERT(opt);</span><br><span>     ASSERT(frame);</span><br><span>     ASSERT=
(buf-&gt;len &gt; 0);</span><br><span>     ASSERT(ctx-&gt;cipher);</span><b=
r></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2089?usp=3Demail">change 2089</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2089?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: Id6587b3d44d3326cae83c460cd85e8570ee8666a </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2089 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none">=
 Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Steff=
an Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--NVxxhJcx/Nw=--


--===============5139896347016819852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5139896347016819852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5139896347016819852==--

