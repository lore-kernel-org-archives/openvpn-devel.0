Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB34606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OnC6dqk3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZSKVVs10;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cEZaFdKa;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=R9ItUHi0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=U15o14rx/fANwoAN7EI0bRzY0UQlR0tjU/PVBts0Dig=; b=OnC6dqk34W2Sjcq2FY5KHqp/VS
	2qjsJOxZrk6cD5RTEo9FqZzzRButVhZFbNoznSWIAT/5/Oon4KWy/m24zWfJ9m0wMWlYyvFa435Xh
	n8hRn181twyDx4S5jlVxdljgOCYnfnSX6Hx9mIPOzTIshOaJSrnEm1a118NbVpDiB2Zs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQRqy-000000000om-3KG0;
	Mon, 09 Nov 2026 16:04:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQRqx-000000000of-0t2d
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 16:04:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v6Tnf5G/CB2KsaoeIAi8MOTqj+47ZJqzGFpDArpwHE8=; b=ZSKVVs10i+Gp2GasyBjLv3zB39
 zo9ec3upaMX55TIIHNJ8rQuKTCMgCIKMrHwH5JUWzMyffTWyjNcPG+jxC1fA+kQkSycZKDuMEMQna
 nbyPzTudUooGdqkjAtPLhygfqMgGWWc6pm9MM0ba6RcGqZxyaA9efThqCPLtq0Y/y57o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v6Tnf5G/CB2KsaoeIAi8MOTqj+47ZJqzGFpDArpwHE8=; b=cEZaFdKaOjw+exgzgrOX8mB8Tg
 6sr3l8MpaRLetgjRB3AOZYuNvdsW2Y0ok8eGl9lFQOZbKtWZVYrYXOpq2IwpgdvAM3Vf8Ji6L0oLu
 AvZd9V8yRXw5pYsJMIOwLx3FdrG3h255GEWznsjjDANuiXxDSuX2WJYeXKYaJGV0JVR4=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQRqv-000000002z9-3DQo for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 16:04:15 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4919a880834so657796f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 08:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794240247; x=1794845047; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v6Tnf5G/CB2KsaoeIAi8MOTqj+47ZJqzGFpDArpwHE8=;
 b=R9ItUHi0Y7DaQPW3xVlngHIsm28pY8MDKGkROm3Ju3lq/r40vBP+tjeFiLcGJT/uVF
 lF03vQc3CyVusvdaWT2acU6m98iU4uTbmiHHJfEA2nDeYCylWu/VGesctXWrvl9O+q+r
 x51epAjxkQwRBlkui9L/YHc0x+q/UhSzWmcSTCTGehVa1ISSbAho/TCcaxFsms9rBTgm
 kmzwg3hcO5dHW7yPxpkciCK5WCibZSY+wah4JlgmLYWfYaqzpT2u4rvFPb0sOxQaTTeJ
 mMi3nDoxEKC5W69WgHMhcn+IVqlCIDuINVNvqZalZh97Yh6sTVO6G6M9YQ8LNleWn0UW
 Z5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794240247; x=1794845047;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=v6Tnf5G/CB2KsaoeIAi8MOTqj+47ZJqzGFpDArpwHE8=;
 b=izNWYW/oKdM/tMP1ok+AfI1Ir+ddfWYKRFv5rNOrcmt9SfHu9+DrKO0O90n0Yvc/j9
 dEs4EkNLM8Y9a6DRwugxADP1TmKiAssufTez5BdKHn49lNwEU5Kth8LmOr6rnlK0yUy7
 zLUnD9j0XPmHFe93aIhydyRQSdEY8O5fPrDKZXrTGIt9jNSuyjVCGMk8jr4sryQrd9Ro
 6x56JK3yz7EmoUbBKo695eOIBvWdwlK5Y5MZ2wAJPvnPn8/l7p1xTKFQWFZ0Mjsce4OH
 w4zaj/SxqrW1HKGPoXPH9Vzkx9urLPpoF79d0fEuA9C0fO8LaQpgz2VrPTUIcM7Rl+fz
 Fjzw==
X-Forwarded-Encrypted: i=1;
 AL+hErEIodjdI1x/Ttxz8HYRv7l55ibO4mBP6g4C8RBWA2LC+AW5Xcc6Wp+Fdsm0rWzmttwXvgmG4YpYSPYHf4xE@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+XKjpbcfqJ9k+TK1cGd5p7Jn5umgFpXH7fRdf8sx0mHkLK91TI
 Oo0XHc7VCiyTotsqe/x0EPhq/f4hIFr6IQ1iZLc9KVaSl+BBWQzdMNma4wIw415DsZ943ovDzsj
 il2Kp3quXbgMrMKfBXknGu0qaLRPELjkReAxQKck0FurihwHNSWyUBWwVLA0zaOiPMj+pB8FWVX
 aAtLficw==
X-Gm-Gg: AYBFou2Z8G31Hv62aBs4WZA7QVYp0ox6J4Evz5bO3LNkJmXl/1U41p6hWu3P0O/ZUys
 KyGFC78lxdViX2eCbt9CSFa4br9IhjyRr+t40Ij5sIhnTndqPtVpRLqCWn+u9erjIGcjcCxOb5b
 YV+hTflHEm3r8SbZ3naaCGK8m+pBtwuVlC+ASNk93KoY8OQawp4+nW9HZNUyLTX/yhOHKK5LwOJ
 8oMC8a4gUjGOTRWUYyTGZprgavwOyaSAGew6jS0p7ZLUCV1YwRwgeMIP2NQ2ohKN5x5nw/8s/q4
 3z0dTtxQ2tnGOj7raqkcOyLbvuZGweHiUc/sVDgLZIRIX8DONcQNvMJUuhzi6rHwMaamPX8ab7m
 Nf+OC14YeSI83H8zfglTbnRY4bheWcKOqpVRy2Nprv+oA4ewenK5sS8MYoo6hQWNxaWMflbZgMn
 ZtYLN1lPdfnk8QdRGEpGKF0AJ2afFS5TPbL7No/Q3XNFvWp7NHjLP/oetG0yqx+m8NmURmK/9AM
 tv/WRaLk4xpfos17rxxfyvaGyaC2kTkdd2yXSJ6VhNwOr4+062NDkNmRE4J+GH6SwwRyFP3ZGTP
 Tn01xhmsVhSfZhEcVixh/1iSGIVc7DW16I1eRdK8hAtrA7l5Leaw5+q5MP1nt4isbfg87CaRWtF
 e8DPZi0HK6EdvGAK4Tr1zrGkw6JMrQvCMsa9W8seCc8b+7fa+q0QLXebiOxatO0mkgkU/w/XR9o
 netSE8DOSEVsAfiJcA0wvMc+P6Y4ZJnv9FJCk=
X-Received: by 2002:a05:6000:2c02:b0:48e:4300:c6d8 with SMTP id
 ffacd0b85a97d-495897718d1mr8528481f8f.35.1794240246980; 
 Mon, 09 Nov 2026 08:04:06 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4959650a0f1sm10863472f8f.20.2026.11.09.08.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:04:06 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 16:04:05 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I88ea70e88c3ec133261210e0404f324bbf025d9b
X-Gerrit-Change-Number: 2104
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2104?usp=email>
X-Gerrit-Commit: b6a82c12c83c3bad2a32b3ef73e2bb2d18f00844
In-Reply-To: <gerrit.1793704368000.I88ea70e88c3ec133261210e0404f324bbf025d9b@gerrit.openvpn.net>
References: <gerrit.1793704368000.I88ea70e88c3ec133261210e0404f324bbf025d9b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA0MzY4MDAwLkk4OGVhNzBlODhjM2VjMTMzMjYxMjEwZTA0MDRmMzI0YmJmMDI1ZDliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4f7ac96a9ca2ae952be2d17070e400e1df617e90-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQRqv-000000002z9-3DQo
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: proxy: free
 proxy_authenticate in http_proxy_close()
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
Content-Type: multipart/mixed; boundary="===============7259382160053783336=="
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7259382160053783336==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4I0NEcJgyJ4="; charset=UTF-8

--4I0NEcJgyJ4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2104?usp=3Demail )

Change subject: proxy: free proxy_authentic=
ate in http_proxy_close()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

proxy: free proxy_authenticate in http_proxy_close()

The Dig=
est challenge stored by store_proxy_authenticate() was never
freed when the=
 proxy info was released=2E

Reported-by: hz86 https://github=2Ecom/OpenVPN=
/openvpn/issues/1134

GitHub: closes OpenVPN/openvpn#1134
Change-Id: I88ea7=
0e88c3ec133261210e0404f324bbf025d9b
Signed-off-by: Razvan Cojocaru <razvanc=
@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2104
Message-Id: <2026110=
3123455=2E4065-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40569=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/proxy=2Ec
1 fil=
e changed, 4 insertions(+), 0 deletions(-)




diff --git a/src/openvpn/pro=
xy=2Ec b/src/openvpn/proxy=2Ec
index c3ad7de=2E=2E7b5a289 100644
--- a/src/=
openvpn/proxy=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -523,6 +523,10 @@
 void
 h=
ttp_proxy_close(struct http_proxy_info *hp)
 {
+    if (hp)
+    {
+       =
 free(hp->proxy_authenticate);
+    }
     free(hp);
 }
 

-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2104?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I88ea70e88c3ec133261210e0404f324bbf02=
5d9b
Gerrit-Change-Number: 2104
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--4I0NEcJgyJ4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2104?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">proxy: free proxy_authenticate in =
http_proxy_close()<br><br>The Digest challenge stored by store_proxy_authen=
ticate() was never<br>freed when the proxy info was released=2E<br><br>Repo=
rted-by: hz86 https://github=2Ecom/OpenVPN/openvpn/issues/1134<br><br>GitHu=
b: closes OpenVPN/openvpn#1134<br>Change-Id: I88ea70e88c3ec133261210e0404f3=
24bbf025d9b<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2104<br>Message-Id: &lt;2026=
1103123455=2E4065-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40569=2Ehtml<br>Si=
gned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/o=
penvpn/proxy=2Ec<br>1 file changed, 4 insertions(+), 0 deletions(-)<br><br>=
</pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec</span>=
<br><span>index c3ad7de=2E=2E7b5a289 100644</span><br><span>--- a/src/openv=
pn/proxy=2Ec</span><br><span>+++ b/src/openvpn/proxy=2Ec</span><br><span>@@=
 -523,6 +523,10 @@</span><br><span> void</span><br><span> http_proxy_close(=
struct http_proxy_info *hp)</span><br><span> {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (hp)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        free(hp-&gt;proxy_authenticate);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span>     free(hp);</span><br><s=
pan> }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2104?usp=3Demail">change 2104</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2104?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I88ea70e88c3ec133261210e0404=
f324bbf025d9b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 210=
4 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--4I0NEcJgyJ4=--


--===============7259382160053783336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7259382160053783336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7259382160053783336==--

