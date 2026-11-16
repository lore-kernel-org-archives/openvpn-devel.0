Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98178606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EMyUck0c;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=j9pnhPxq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jUbz1jjw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TE+cg9Z6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=W08xj28MWN2CFQQ9exco+r2sVIRNIneYe6n+FqqbZwc=; b=EMyUck0c5YWjYCSLTa67aa3KtK
	RXE3Y21WhOZP1wl8WN7QwgqBiNiOW4KqK9wWByqVh8qCYnLMpyLvM7zNffVmxYOQl1vZgVSxsnSCn
	rZnKLWT9Q6tKprkN1fy5+iEJIFzZdIz8y0TW6y2a9H8j134Gam2ZRf000Z3N34zMmx9Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT1OI-000000004p7-1Dbg;
	Mon, 16 Nov 2026 18:25:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT1OH-000000004ox-2xUh
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 18:25:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1jIo+Mx/V5Bd2a0fezRaW4DjOiNJ3pzAz8AxF24rvmQ=; b=j9pnhPxqhR4dmBqKor7DG/wMzq
 kxz225xk22F8WhZXkjH/KUID+P4EfMdaMDrTQOPeiR7RfF9X8GhWwzv0IcbKAqbFI0JRRRi724Opz
 gtA8SAU7tljKR7PSkykyMJnxKAw2Qe04Jlm3ojUqmBhSVM1irJJY12arFDLBGw8Uq+X4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1jIo+Mx/V5Bd2a0fezRaW4DjOiNJ3pzAz8AxF24rvmQ=; b=jUbz1jjwDLOndKr4p5cmcvUU+J
 KYKHWnFQvjdYY4JBUYCPfwDuPy1BWNgzMVXip460FV8P8iq8GCXnTTKiuq+nHrKk2dzGWUAXOF0nO
 IsrCmNdGjnCnqBza2cHYXl8hyutZJDYE2PoSoP5x5YPmRP4qzG0FW5S9b75zy+FJOL54=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT1OF-000000006Cd-3sNJ for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 18:25:17 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a14so19433165e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 10:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794853509; x=1795458309; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1jIo+Mx/V5Bd2a0fezRaW4DjOiNJ3pzAz8AxF24rvmQ=;
 b=TE+cg9Z6m6f4jQLwrcai02uloMmcGXryFuom/TZq/nDePoilhpKFee59NDYDejSDBm
 vVpGI44uCP/dY80G6kP6ByHDBlebdOZKmCoGzrDxlXpv7nx8zEYH69TsCFY1UiBCacqP
 39VKsVSQKkbrskAUrOz/yQPK8wzE7VoFOuED68wML59+LYIpwPS12XZOE79nyAHGKejM
 EomJS4yb2wd4YXGJE7+nBiusdXnNAVE7NcOiMiTTjuY7DSuEbyEPGMdMejNb08CHHqDj
 ItPEDjez8cAztIQVgcEbtj8vq89DZ2G6rlInxFRtAtvVrOwVZLGwpV3vB56fAjsdGcj4
 I5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794853509; x=1795458309;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1jIo+Mx/V5Bd2a0fezRaW4DjOiNJ3pzAz8AxF24rvmQ=;
 b=cFa/xOWowehHyY31OSGg0+czrjcbp/+ykEvVFMF5auF6+PZK9Ch2EgqgkACXnMhSiN
 IoHuKVF6mIwGJm1JDGU9EeYqTzEyiWIr5EqI/ILFOA9WkFyswvC1m8n/XDUNW7LTFLGX
 cuqSpNbj29LIfpgVM8rEktgzaY/Pvloqovqzl6fDNAEGUbncEbaKMazYeL6yq50rLJF8
 lCOxhjYCpyIuU/woQidRrL5t1sybEfwcH6WRJdOfeM/oLkk8ZSU+vZnXfMEvp+QQBX36
 4Cuzi4hdKedA4JQ4zqNgo3a6RufUbOshYQ9T4BeP9Dg9V/UyIReWKmIogLAIRXxjWw5F
 OouA==
X-Gm-Message-State: APuU4Z82XY7NjyDwutk+kUS7Hidf30EgKOjKMzjOOF3qOV1UF4hGXNo+
 DB7wyrN6C3HMa72DkUb9a31cTocT6UX605igxvdaTmpMQVnARPkntnmfDS6MdDSHWpHKhK5o8tx
 vjuc56fAmPtbcApucnw1aKHPWSjCMrneMWKprHZBe77nJZ0F+4NFTOSqmAPWH8Lak/FHvbiNBbi
 JD9plbtA==
X-Gm-Gg: AYBFou2F5Yt2cDociUp0NpuMDrD8txFKncbNkb7uhw52MrptdPqqBHJhYQCycUoEoNj
 KMQ8G9pNhquS5LfbZXg15C29RPf02xtO1dURTBa+AYSHNd5aX03oFu0BC0umEX56nci0VY7gW8k
 k9k682h52IUh3dOvRFxGnHQDOaPlki7yONUANhRvrbndGETccgw5wL2Pmkh8IHX5WIr9BKzy8fO
 B/J+tiNK0v6v/RedUyg5cwiUeX6+M9puZtn6l9JNH6iIdKSz5pPcMNsaiJcV78DYaqIBXLzaeum
 fPKb8i6lXTqTouLuLWIjQfSo7JdMlf1ZkFIFsAYnbPfAt11sjw6LwOdGy5Y2g2GH/zmDMQGdLfS
 3U3CrS52mAQVrTVJ67gv+RexoM7GRuoHGD336BMRjEAZpr5YUA6KxwIvRBWKke3znvJfYdVk2ep
 a2M2SemfjOhF1gKWwZwBg9uu/h/exIE8IPEtjLA4dcN7s6fLw21uZgAmR31OPLFyvNj9ZgAYFva
 OTdzrxZnDg1g7wULV8wTvmONdEUz5txj0c9Wb+ffMkNwrWKf7RkplNlYhfMri/cfaXw9CtXcjU8
 cnUqWIe7wkO8g6gH8pzdM6+5lg+UmfI6kTYufXnhvSeZ60EU3WvFA2ikVaTRfNEJ04GhUcHkp6u
 M65W7Do1keKkA07c+uczqxbeTLxfkanI5AVctZhpoJJRv8E5Vsv6MXN15W2VijofX93gGoVP0pa
 BoGdkr/f/+oM31LFAgfqL1zjgNeSxcF60BuhZG
X-Received: by 2002:a05:600c:4e8c:b0:4bb:60ba:49e0 with SMTP id
 5b1f17b1804b1-4bb60ba4a70mr173315295e9.26.1794853509205; 
 Mon, 16 Nov 2026 10:25:09 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8154sm6426545e9.4.2026.11.16.10.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:25:08 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 18:25:08 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I388a52d19633d0604a1610fbfba31cfff7f518ef
X-Gerrit-Change-Number: 2202
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2202?usp=email>
X-Gerrit-Commit: 933e563d2dc9ff61407112961a140fb79b6122bc
References: <gerrit.1794853507000.I388a52d19633d0604a1610fbfba31cfff7f518ef@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODUzNTA3MDAwLkkzODhhNTJkMTk2MzNkMDYwNGExNjEwZmJmYmEzMWNmZmY3ZjUxOGVmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9786f9263a4eac48ad512ab68e28ebc11b5ce968-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT1OF-000000006Cd-3sNJ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: mudp: drop unused
 addr parameter of do_pre_decrypt_check()
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
Content-Type: multipart/mixed; boundary="===============3426653894216642485=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3426653894216642485==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OCWPXIv1pME="; charset=UTF-8

--OCWPXIv1pME=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2202?usp=3Demail

to review the following change=2E
=


Change subject: mudp: drop unused addr parameter of do_pre_decrypt_check(=
)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mudp: drop=
 unused addr parameter of do_pre_decrypt_check()

It was passed by value on=
 every connection attempt and never read=2E

Change-Id: I388a52d19633d0604a=
1610fbfba31cfff7f518ef
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eor=
g>
---
M src/openvpn/mudp=2Ec
1 file changed, 2 insertions(+), 2 deletions(=
-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/02=
/2202/1

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 217=
b299=2E=2E0e1e21d 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=
=2Ec
@@ -113,7 +113,7 @@
 /** Returns a verdict if this packet should creat=
e a new session */
 static enum pre_decrypt_verdict
 do_pre_decrypt_check(s=
truct multi_context *m, struct tls_pre_decrypt_state *state,
-             =
        struct mroute_addr addr, struct link_socket *sock)
+               =
      struct link_socket *sock)
 {
     ASSERT(m->top=2Ec2=2Etls_auth_stand=
alone);
 
@@ -259,7 +259,7 @@
     struct tls_pre_decrypt_state state =3D {=
 0 };
     struct multi_instance *mi =3D NULL;
 
-    enum pre_decrypt_verd=
ict verdict =3D do_pre_decrypt_check(m, &state, *real, sock);
+    enum pre=
_decrypt_verdict verdict =3D do_pre_decrypt_check(m, &state, sock);
 
     =
if (verdict !=3D PRE_DECRYPT_NO_ACTION)
     {

-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2202?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I388a52d19633d0604a1610fbfba31cfff7f518ef
Ger=
rit-Change-Number: 2202
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--OCWPXIv1pME=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2202?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">mudp: drop unused addr parameter of do_pre_decrypt_chec=
k()<br><br>It was passed by value on every connection attempt and never rea=
d=2E<br><br>Change-Id: I388a52d19633d0604a1610fbfba31cfff7f518ef<br>Signed-=
off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openv=
pn/mudp=2Ec<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/02/2202/1</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=
=2Ec</span><br><span>index 217b299=2E=2E0e1e21d 100644</span><br><span>--- =
a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br=
><span>@@ -113,7 +113,7 @@</span><br><span> /** Returns a verdict if this p=
acket should create a new session */</span><br><span> static enum pre_decry=
pt_verdict</span><br><span> do_pre_decrypt_check(struct multi_context *m, s=
truct tls_pre_decrypt_state *state,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                     struct mroute_addr addr, struct link_soc=
ket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
            struct link_socket *sock)</span><br><span> {</span><br><span>  =
   ASSERT(m-&gt;top=2Ec2=2Etls_auth_standalone);</span><br><span> </span><b=
r><span>@@ -259,7 +259,7 @@</span><br><span>     struct tls_pre_decrypt_sta=
te state =3D { 0 };</span><br><span>     struct multi_instance *mi =3D NULL=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  enum pre_decrypt_verdict verdict =3D do_pre_decrypt_check(m, &amp;state, =
*real, sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    en=
um pre_decrypt_verdict verdict =3D do_pre_decrypt_check(m, &amp;state, sock=
);</span><br><span> </span><br><span>     if (verdict !=3D PRE_DECRYPT_NO_A=
CTION)</span><br><span>     {</span><br></pre><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2202?usp=3Demail">change 2202</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2202?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3=
88a52d19633d0604a1610fbfba31cfff7f518ef </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2202 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--OCWPXIv1pME=--


--===============3426653894216642485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3426653894216642485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3426653894216642485==--

