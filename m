Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AAF606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KG7D9Wy3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Euu9wOI6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Eb7a1972;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YAMEM9be
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=D1plWKvuJosfPCvih7pCt2hyP0fUq82NkPgjXxyZbHQ=; b=KG7D9Wy3cgiSZN6azU8jgUgNMM
	MSwcC2TyGwp00hW4TVz3zUYtFFJYFW4+Cb2+to6yy51oaTml50Qg8R0zwejNQiLbwZyx46MuKIZMl
	ixCN5+HtHIDmq4GojtlQnBHIP/jmdFVjaYGQPiQNjnFAtD6p65tN0W+zMSJ4oF65PJMs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOeNw-000000007Sz-1lnm;
	Wed, 04 Nov 2026 17:02:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOeNu-000000007Sr-3LDn
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:02:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8ViLgrQvDe2BZTehAc8QU6ubON8Cq+CsUdHsdugopr8=; b=Euu9wOI6vuUG6l7f+40yd5hAm/
 QypL7meZi/BqFOQP/c8iF6J3n+Sa4GX63rEsg6uaLODi0rmdYn2hVFzdcsX5u4DOVhJ7TjWSx7JIC
 Zsv/876h8JSAfZoWnzlIMEaAPw8qPmbl7W6tHVtvDBPx7WuXk6LCsJyVrtEtOIq+gvoc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8ViLgrQvDe2BZTehAc8QU6ubON8Cq+CsUdHsdugopr8=; b=Eb7a1972Khvg69EiM7tjqDLyn3
 dpXFbGpmrTlGsPP6UEghtYIe5p72BN7+iVvibovDOYKhHEQKXNBOZNmNBcKJhWSLHJjQq5pMD8NKX
 5TTXnNvDZXsafwEiCRg1F4pTLP7N/QEBopUpsZhDtuZkXMU18buJJZjxeHbHpJFOD5jA=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOeNt-000000001ev-0b5S for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 17:02:50 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so8645905e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 09:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793811762; x=1794416562; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8ViLgrQvDe2BZTehAc8QU6ubON8Cq+CsUdHsdugopr8=;
 b=YAMEM9beqWTgzzDJZTB9OrPQVf9yrmxhnI0L1oSEINiKIIxjPOUV3vrUgGY7lwrctX
 weUY9treWlp5YjAw+9vYlhMNtos8JzpAwZKhAKKuRx8HHqjkbbCQWMbERM3IxgTHWsxM
 ZRRY6iCO2jeSSr+BpIPn4BxC1L30SJ6ZI2tWmr1i/c69W2mQcR/hJYcI9Ge8PHNYA/aE
 jvPhPU+1jrGTAI/l7jS86MXP8UwtZuIUjEEUHVWn2pz7u+AhL21UmntlDYDbYJFk9RpY
 z7/pSUQrWCJqYjz8E2XdxZmLMUfVYgCFcv4wIAsu/s7FZ70b5fLYKQN9GQSrYN6zXe2W
 l2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793811762; x=1794416562;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8ViLgrQvDe2BZTehAc8QU6ubON8Cq+CsUdHsdugopr8=;
 b=0drDF4rU4WSzOzO3Bv/71Rg+rA2tfiF5JFWadoFq3f5i9IW2AynfSlYXMk+pGaZpk8
 WGzTLrwPf7MYTV96o032p3u3f53vdKVBA5DgtEh/F0RA8Iqi9NKd+QwkxQpdIia5ea+e
 Q8gNytm0JvAKsNn3F4HFL6mYWwh4pWILXwFy30pdjsyNuHb+eU5sH3hGl1ctun2lNpOt
 PfGIEGID6PYIfGRWUsh9HOL6ITVC3wxD6rVrb9pRzvhav+gyX5I8oc6GFN8lFYE7tl2K
 tNMi8TpNhbuRxD1/cnC7sBRe18sAzjWcgQlyzbX56Wqa6wZwWNSmmhowmZ2UOIseHkeH
 2qBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBhuvKMUndQYO5tXBpiJuWRNWvaazt1/bKrQZSIIW2CVhGWcnGP3LS/kqAKSJI8G+M0BmRCUogmeRj1PIS@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+0XYAlWYjdSJmWuinqqMOEaUnOY1hj36yYzrMof/uGIvh6JhQm
 o+0BOc3vaeU1FGQ0OJbykOaNSFNy+QQ1YygX1B8V4ATGv5cAcgvnypJKr90ORu8g+/fVb9nGasG
 tFe8pWg+GFk6cj32PMykHEBRh2Bc42UxD8aECmGN0owZn58u9s9Js8Jlc0kfHhX27KzDUMPmLCz
 oq7sEwdg==
X-Gm-Gg: AYBFou1Py3QptBNV2B/edzsxK59l4c22BhasRTUES9FfPcnEgiq8ewVZB0Esj2KxHy1
 0n//MtHwS599LQje2XX5zLWcpCKbHHgXQjcDF4j8xNHMOrFgr4AfIJNJACG9abky9RIotzqv5fn
 nWkaP8HCZ15dFPK42S8NRpBYXRmawwCfJkWU2MxZEvJ14rurPJyokNGoi5WTi2toy4xcc7O7/wm
 VPYjRPyRCXGkFk0ZfVgu7LgSVChoLx1olVnvoBNcse50c38TrlFG50WXvm8gbxm4QV7EsW1EMKH
 rYr794YNDq5Gkn6ax6ROlYm0Y/bPoyDHYBUtf/cOkgp/N+jmrsfgsoHcQiEcallrVQHQEy7G2D9
 5elBzRbVe8P8qHNss6qdI0M9dASdYAfwb5VBfIFVbIUpfSWIxD4RMXc/30LaX5d3AMCyds4aBDV
 zs65od/57+tkhuLu6B94S3S8hWBBN8ViDkoKfpWUABazuPycat6lLJxFYmd7B66kd8Sw0Coa0pw
 dW4J74awyhwLPbujm46hRKx5xm7Ma14TvdJZkuakApiqQ2FgeV6gPSj1aEk0ym6f13mfu5lF7GW
 35An4PSMqmTm5WTOnuXZz8UfCEdHoL1EkAVbQzj/d87sPx6CxdRnQBt+CczQETLQ+Ol6FlKUNCQ
 9dmHP5FbqgugBpAyO+pwd/TcScczyriNpUTNULFDPZESthKJEtYIRl5nfYxxwot+sL87r1XI6Of
 DXKtdE742noj+rjg==
X-Received: by 2002:a05:600c:3b97:b0:4a3:5a91:5f64 with SMTP id
 5b1f17b1804b1-4ac18e5dcbamr388359285e9.27.1793811762359; 
 Wed, 04 Nov 2026 09:02:42 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43d4c9d4csm89158345e9.12.2026.11.04.09.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 09:02:42 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 17:02:41 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8b9efc75656e01df9afe99c280ba8c9c82e937f0
X-Gerrit-Change-Number: 2120
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2120?usp=email>
X-Gerrit-Commit: 719f5c2c19037262a0758dc2f7e504ff7958b23e
In-Reply-To: <gerrit.1793776960000.I8b9efc75656e01df9afe99c280ba8c9c82e937f0@gerrit.openvpn.net>
References: <gerrit.1793776960000.I8b9efc75656e01df9afe99c280ba8c9c82e937f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2OTYwMDAwLkk4YjllZmM3NTY1NmUwMWRmOWFmZTk5YzI4MGJhOGM5YzgyZTkzN2YwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b2493d259a8c36c35305bab819dc12293f178688-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOeNt-000000001ev-0b5S
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: log the actual
 error in Windows tun_read_queue()
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
Content-Type: multipart/mixed; boundary="===============0254765906230848245=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0254765906230848245==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GKpAitDiY8I="; charset=UTF-8

--GKpAitDiY8I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2120?usp=3Demail )

Change subject: tun: log the actual error i=
n Windows tun_read_queue()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

tun: log the actual error in Windows tun_read_queue()

The re=
ad error message passed the ReadFile() result, which is always
FALSE on tha=
t path, to strerror_win32() instead of GetLastError()'s
err, so it never sh=
owed the real error=2E

Change-Id: I8b9efc75656e01df9afe99c280ba8c9c82e937f=
0
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2120
Message-Id: <20261104124931=2E18525-1-gert@greenie=2Em=
uc=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261104124931=2E18=
525-1-gert@greenie=2Emuc=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Em=
uc=2Ede>
---
M src/openvpn/tun=2Ec
1 file changed, 1 insertion(+), 1 deleti=
on(-)




diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 7637=
dc0=2E=2E943ad9f 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec=

@@ -3305,7 +3305,7 @@
                 tt->reads=2Eiostate =3D IOSTATE_IMM=
EDIATE_RETURN;
                 tt->reads=2Estatus =3D err;
               =
  dmsg(D_WIN32_IO, "WIN32 I/O: TAP Read error [%d] : %s", len,
-           =
          strerror_win32(status, &gc));
+                     strerror_win3=
2(err, &gc));
                 gc_free(&gc);
             }
         }

-- =

To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2120?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8b9efc75656e01df9afe99c=
280ba8c9c82e937f0
Gerrit-Change-Number: 2120
Gerrit-PatchSet: 2
Gerrit-Owne=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>

--GKpAitDiY8I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2120?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">tun: log the actual error in Windo=
ws tun_read_queue()<br><br>The read error message passed the ReadFile() res=
ult, which is always<br>FALSE on that path, to strerror_win32() instead of =
GetLastError()&#39;s<br>err, so it never showed the real error=2E<br><br>Ch=
ange-Id: I8b9efc75656e01df9afe99c280ba8c9c82e937f0<br>Signed-off-by: Razvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2120<br>Message-Id: &lt;20261104124931=2E18525-1-gert@greenie=2E=
muc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-devel/202611041249=
31=2E18525-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Gert Doering &lt;ger=
t@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/tun=2Ec<br>1 file changed,=
 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/tu=
n=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 7637dc0=2E=2E943ad9f 1006=
44</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/open=
vpn/tun=2Ec</span><br><span>@@ -3305,7 +3305,7 @@</span><br><span>         =
        tt-&gt;reads=2Eiostate =3D IOSTATE_IMMEDIATE_RETURN;</span><br><spa=
n>                 tt-&gt;reads=2Estatus =3D err;</span><br><span>         =
        dmsg(D_WIN32_IO, &quot;WIN32 I/O: TAP Read error [%d] : %s&quot;, l=
en,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
   strerror_win32(status, &amp;gc));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                     strerror_win32(err, &amp;gc));</span>=
<br><span>                 gc_free(&amp;gc);</span><br><span>             }=
</span><br><span>         }</span><br></pre><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2120?usp=3Demail">change 2120</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2120?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8b9efc=
75656e01df9afe99c280ba8c9c82e937f0 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 2120 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--GKpAitDiY8I=--


--===============0254765906230848245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0254765906230848245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0254765906230848245==--

