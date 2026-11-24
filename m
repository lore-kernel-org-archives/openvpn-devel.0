Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB536606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MUCTtlYa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=k6Z7ycTT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=h2qfOGUR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SSWqifUp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=kQ32+vEvKgEDn+9yNEQ+zJw61ygaxhU64GBaikztyUk=; b=MUCTtlYaf561R+IUn5M42s6jC/
	uDU/YMIghLoVYgf3swz2KfkEL7gY7pPaFytyYGV93hel9m/U6o4YV6Yd1LLTOiGzmwLJsZhie+Pnv
	Gu+J+44eN+ZYZ019l3KNpMS7queKA3AykmGO9+boA6bYPJu7eEl3wePQbJg3zzsB9tyY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVtXn-000000006mc-0x0V;
	Tue, 24 Nov 2026 16:38:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVtXW-000000006l8-2ZMD
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:38:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vNP+/L/bz938aO0GGZhr/2xUjqtqTxCc0FWcO/jrm/c=; b=k6Z7ycTTndS8OGsi8SjMtg/9k7
 hxZDvDKRSKsostYrgk6DpT3atejiN9G6z91xDcaAD9Ztw32CFpIhFdUoAD7j6OXZV89j4ZozXcT5j
 LApxbJtpSDhA9JELzQLZmFLDPEJ3IH6xWbv4bmw0LfjE1gnJpZUHK1ei2b9SaE9QrTns=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vNP+/L/bz938aO0GGZhr/2xUjqtqTxCc0FWcO/jrm/c=; b=h2qfOGURivit1MHtnRmeYWuFEK
 krQAvLpdMu94xssrL+xzBvXgwExtktxjeZ32gdd1xFy318BYV4dG/ZlVHmZqgOh6EqoKuDkeSaLnm
 9QsUP9BIkPvqDVz4M6uN5Ak5FlbwU07a3LLVrWS4Ub+41OYF4+3TtlKKYrdb5zqaTPG0=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVtXU-0000000076b-3PAg for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:38:42 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso51227465e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 08:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795538314; x=1796143114; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vNP+/L/bz938aO0GGZhr/2xUjqtqTxCc0FWcO/jrm/c=;
 b=SSWqifUpNGknGO4Fbm9uhByUeIHFyZazGk5gCMNg9gwunLkqA7QjJB1ZDTSSbJp7rl
 +jRc0+XqrvFIrFdqUpYfHht9xhHiYkvYnOKDRZzP2QfGsDCYyMvV3k7DqDyzF6FdYBVE
 cuOTFdxom0JmMtQanlYmxYn3ZiJ9RCJmuAIiwTOep37BGKTwJW1RxxqmELYtsaz9c4Zf
 AGrbf8uzCCOtO5Tj0nZpLB22kXvb8orXD0Hs/tlx5AjidnPvmOszWOYAcnXC/Zxjwst0
 ozb3vtE63SG5z4mDscq6o5VjxbmbJcl2/cB2Scze8o4YoXA2s9hTigVLzW3QXl/b4Q6q
 O7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795538314; x=1796143114;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vNP+/L/bz938aO0GGZhr/2xUjqtqTxCc0FWcO/jrm/c=;
 b=nToFFn39oD/2pJjUaQiorlLe3UhUjnc1zbg6t2SP9u07hWYHYeBRCbpnJXP3OWlRaK
 J2x1I9TdBq0uhNAPD1nSv+wBE5qlxc15ThRU2y7sj/UvBuXckt0ZI2JyqAdYTbPXj4+A
 Odtph8AytLHCY9XGwr4RmXu3/kI+2YBs8YCpyXyTkqocqW1SeDROcw6T991ib4oTB1y6
 BB7SztHHuueBMhy6ClWYHaY0xAzABpE3Xs/QiFbwoq2oKaKIZ97Vx0vz9RxmZV0MY9y1
 0KhX+bfBp8k7lKkhq9duv2mLWLf0oceAHQCBrrJ1iof6TrYpy8IpmwmZ1zUdDtL0qspA
 qfWQ==
X-Gm-Message-State: APuU4Z8NoVucwlDh48ZYEIAeTR5tocIcWyRUis6bSS/uCYwpze+bJWIQ
 Uwrp2kU6mXDN9MOWjnzCogLDWjPB/D+KNKP7XU/wqp5VCBDPiB3Tc5uuIXyAbQlmDbk4dsLK2zn
 waGdpSpuMNyz2Bi4zs9URtUOAbjwYef2XxEdS4UIxMcmHGBKb6aM3P7yYL0jxRan8fQX4Ykwlug
 cTdJKJqA==
X-Gm-Gg: AZFdTZfev0VsG+8YKT1/thLGvj92UhKCjOasQ2UVUzXJtaLzA7Vhyy8wFNeyBGTeYeG
 JOj2rPNCI9rWQsO2aNgR+htkc9yHpU/5a7mIu/aQRPvyIy4C64JwDdg0rQ/PMOXd+oTfphOLd+Y
 A9lfYsUz+1A2eOfdtJSjLDdjV5pWTQRJf5Izp9OYWYct5LMtn5W6sHJnQUjdHd+/KFZK+M7whnZ
 VCYg7lvQGUQp9jgd3NpDlP9dHJmyPFVOykXwpmZloGjighvzXkNGXVrPyHjMT/mFFADf5nmA9H1
 UhORW6xmKpdTNAgVZlXkcbJXQgQ5mVgmTJ3zYzTDYV8YAAT7stOPIvXMVqga1H+/HANS7ElW9eO
 /CmnqXrhYBxMF5DFygQYacp1Ci4GXeDmeonx7ef3ThC/p9KALkEwn/8zmccxeSf0QQ2xOFdcUuN
 igw/KC/HG3RlrhldxLo54zE7iTrtQmCjBUKviSi4nbY0LFh2y1U1+kFRUIo2OkX2ZTo5k+vWNC5
 KOl5wtR3Ii2j4UcccdiQo0FmmkCE4H/B2/mRaY3VCK+AH9ma0qxULDcL0WPAVnCFSHPgQ0KqZcs
 Bi6c8Rve8S0D2UzzF/bhQDyiUohknprFQdWxMf1WIkN2CNU/Xwsl09ulZo/XwkmA+UIsmFmV6q8
 CTXeBMZyIorMEHBiyBTma3O7PLmtA9XJrVKiRkjyNTolWJaq0b75+mqgmTa8cLA+hAk0/daX/XI
 0PJqD5ejH/uircRtg=
X-Received: by 2002:a05:600c:1d09:b0:4bb:66fd:ad68 with SMTP id
 5b1f17b1804b1-4bb888160cdmr329339765e9.14.1795538313756; 
 Tue, 24 Nov 2026 08:38:33 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90660cb4sm385431595e9.2.2026.11.24.08.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:38:33 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 16:38:33 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5
X-Gerrit-Change-Number: 2339
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2339?usp=email>
X-Gerrit-Commit: 3fe138dac3f51b7e1527a67ab703287beed0f2ac
References: <gerrit.1795538311000.I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTM4MzExMDAwLkk4N2RkNDFiNjZmN2Q3N2NhYjdhYWY4MGZhOWQ5MDk1ZTQ2YzAzM2Q1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3a4303a7e424863ad438d58c82241ad78fc63896-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVtXU-0000000076b-3PAg
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: Fix
 conversion warnings in man_read
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3545057501147770589=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3545057501147770589==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yeC/CVIay04="; charset=UTF-8

--yeC/CVIay04=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2339?usp=3Demail

to review the following change=2E
=


Change subject: manage: Fix conversion warnings in man_read
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: Fix conversion wa=
rnings in man_read

Use openvpn_send to avoid warnings due to
Windows/Unix =
differences=2E

Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5
Signed=
-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/mana=
ge=2Ec
1 file changed, 4 insertions(+), 13 deletions(-)



  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/39/2339/1

diff --git a/=
src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index addd6f2=2E=2Ee917b35 =
100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2448,1=
1 +2448,6 @@
 
 #endif /* ifdef TARGET_ANDROID */
 
-#if defined(__GNUC__) =
|| defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic =
ignored "-Wsign-conversion"
-#endif
-
 static ssize_t
 man_read(struct mana=
gement *man)
 {
@@ -2550,14 +2545,14 @@
 static ssize_t
 man_write(struct m=
anagement *man)
 {
-    const int size_hint =3D 1024;
+    const size_t siz=
e_hint =3D 1024;
     ssize_t sent =3D 0;
 
     buffer_list_aggregate(man-=
>connection=2Eout, size_hint);
     const struct buffer *buf =3D buffer_lis=
t_peek(man->connection=2Eout);
-    if (buf && BLEN(buf))
+    if (buf && B=
LEN(buf) > 0)
     {
-        const int len =3D min_int(size_hint, BLEN(buf=
));
+        const size_t len =3D min_size(size_hint, BLENZ(buf));
 #ifdef =
TARGET_ANDROID
         if (man->connection=2Efdtosend > 0)
         {
@@ -=
2568,7 +2563,7 @@
         else
 #endif
         {
-            sent =3D se=
nd(man->connection=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);
+            s=
ent =3D openvpn_send(man->connection=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNA=
L);
         }
         if (sent >=3D 0)
         {
@@ -2591,10 +2586,6 @@
=
     return sent;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragm=
a GCC diagnostic pop
-#endif
-
 static void
 man_connection_clear(struct ma=
n_connection *mc)
 {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2339?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5
Gerrit-Change-Number: 2339
Ge=
rrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>

--yeC/CVIay04=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">manage: Fix conversion warnings in man_read<br><br>Use ope=
nvpn_send to avoid warnings due to<br>Windows/Unix differences=2E<br><br>Ch=
ange-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/manage=
=2Ec<br>1 file changed, 4 insertions(+), 13 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/3=
9/2339/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=
=2Ec</span><br><span>index addd6f2=2E=2Ee917b35 100644</span><br><span>--- =
a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span=
><br><span>@@ -2448,11 +2448,6 @@</span><br><span> </span><br><span> #endif=
 /* ifdef TARGET_ANDROID */</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic =
ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> static ssize_t</span><br><span> man_read(struct manageme=
nt *man)</span><br><span> {</span><br><span>@@ -2550,14 +2545,14 @@</span><=
br><span> static ssize_t</span><br><span> man_write(struct management *man)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const int size_hint =3D 1024;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const size_t size_hint =3D 1024;</span><br><span>     ssize=
_t sent =3D 0;</span><br><span> </span><br><span>     buffer_list_aggregate=
(man-&gt;connection=2Eout, size_hint);</span><br><span>     const struct bu=
ffer *buf =3D buffer_list_peek(man-&gt;connection=2Eout);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (buf &amp;&amp; BLEN(buf))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf &amp;&amp; BL=
EN(buf) &gt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        const int len =3D min_int(size_hint, BLEN(buf));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const size_t =
len =3D min_size(size_hint, BLENZ(buf));</span><br><span> #ifdef TARGET_AND=
ROID</span><br><span>         if (man-&gt;connection=2Efdtosend &gt; 0)</sp=
an><br><span>         {</span><br><span>@@ -2568,7 +2563,7 @@</span><br><sp=
an>         else</span><br><span> #endif</span><br><span>         {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            sent =3D send(man=
-&gt;connection=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            sent =3D openvpn_send(man=
-&gt;connection=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);</span><br><span> =
        }</span><br><span>         if (sent &gt;=3D 0)</span><br><span>    =
     {</span><br><span>@@ -2591,10 +2586,6 @@</span><br><span>     return s=
ent;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><sp=
an> man_connection_clear(struct man_connection *mc)</span><br><span> {</spa=
n><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2339?usp=3Demail">change 2339</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2339?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c0=
33d5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2339 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--yeC/CVIay04=--


--===============3545057501147770589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3545057501147770589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3545057501147770589==--

