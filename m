Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89248606A683
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XRUos2/r;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KoeMRUGT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ETziJyKc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WRh5MDnv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HBsnKjrf7/MCAps+KxJQShxJqljrzpqdCQf2LDlbvSY=; b=XRUos2/rqdXJ0DXSnskHi94iR8
	JumN6LZmBv2QiP5rmS8C5l5AJjfJmk5ko9oCnrg/vqWOscExk6TEAa1QEMm55ma8QHsSNUovHGPl4
	hZ0saENnlT6WGjXt/HD3jlBfkx2Qbq7WScpPKhm5v/38Trn7OBe53krJYcZ5pMDq1gSo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV6t1-000000005Yf-0ENe;
	Sun, 22 Nov 2026 12:41:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xV6sz-000000005Xy-3XvU
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 12:41:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fiytSl0VYwC9vAEj+K2QuZZzVddrTMMkCBbuZwq7D6Y=; b=KoeMRUGT8B+rWH/3rfDHj9WDhn
 WTYkPSaXolghc3cvbaGsTHdEHfu6MrqyqQ0XXlmKu2UsJVGelrwTKU6iZTq8mlbOCvfIjWI2s4Afl
 LyUC5gF4G2JMVEpCUS7y52lTiUp82GUdagBZZmkqnEZQpPq4WdOnkdw0r2x/Tta56mmE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fiytSl0VYwC9vAEj+K2QuZZzVddrTMMkCBbuZwq7D6Y=; b=ETziJyKcx7iX3oKPT7kzKM66J+
 zDSfpicmOwtvZk559iRvzjIO0m9jN8lTJr1x07GqV9yF78HwfaileTsv/TG6f/tIyU5qzJeAdliTi
 IlveQENQvavNlAcz36j+GwX//LsreBGqmWbFBw3BWvY+kbwvnZv2IpmE5kEVq+TvfxCE=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xV6sS-000000006dH-0eKo for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 12:41:05 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4bb606491faso12809635e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 22 Nov 2026 04:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795351257; x=1795956057; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fiytSl0VYwC9vAEj+K2QuZZzVddrTMMkCBbuZwq7D6Y=;
 b=WRh5MDnvWN4d8ShClX8zB9pr5GGDboU38ImMNs3W1k2gESZYR7xnnE1ZiiPOV4y2Ub
 GHNbifOxKXco/k0rHnhy12tDZYdmD1umv81MZ/W/SzZETBl8zYB+NVCMKuQMoszL3QeL
 ApkORLG9F+1DLgY5xddFr+6WR8fNhLqhw6b+iOz250YZCeFH5tnB7spEznHleAd+TwPL
 kKgDcUXw+dKDJ+ozFSfGhM9gLJnkgi5cSQVIvXFPaktvXSOK92ulCv/IJwXkM8bKnE+J
 FwqCpq9btlFdNDyU31nzW6z5qCEdIt1yNPItsppoPt71beJpTxrGoqkDcC/5qPRP7FNr
 wP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795351257; x=1795956057;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fiytSl0VYwC9vAEj+K2QuZZzVddrTMMkCBbuZwq7D6Y=;
 b=RFj0P3wLaMV7Oac8xYd00Bj2/n4yyF8gVPglWpCiVQTD4e9YnZPbO3ySESTviV5XbZ
 qcibQB5xxkIgUKuoPETgwpc9njf54LQfDsTLYnubd6KjtK6a6/qLDrR9pBju9Vp8e0tO
 gieD36JSej1+fpZlwY4WBKzM4I+4ykWJcz3N47Uf262PUDZV4wfuvWgrdDMCgBkFYJrK
 7RtbmVC66lsBE632FJQ+E8gTn2D7fWz6xavsA8kmmgjbsMOrvWRvptihDX2vBmHlwhDj
 6Eg9oCXoV5+905LjGQl6h98K3r4LqNvjBTYK+8qiV2I73PyiVTPfCndsV3SZgozXY96j
 wlvg==
X-Forwarded-Encrypted: i=1;
 AL+hErFOjBrogMCW+biO3jGmWGz3in8dsa8WZtMYSkr/A7csQF6xP1FpKSw8Xrnv6FJLqDLXMA+Gg6rpJynI5WFS@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+1sRWBrf+1BfUlQpnBVFH3ZggBQu5GVhmwP7YDQD7Iz8/y6sBH
 PbgxU/cwvOIFAwNjtpVFbCGjsaGjXdu4C38SMAJ4fpj9JgoMiBBcI1rO+zEkNWr9aRFXrrEWP42
 G4NGD7b05tqvAITKg8wY3H36bBfLTi3BVnbyYtHalI/JYjMmQViFzSyV+1GSTAPOW531z
X-Gm-Gg: AZFdTZczMNPNEJQFVUaLTxPnob5lRswgw2E3HV6GGChS1lLe6qQk+nu4YoChtxnP7PZ
 L2zZCCP/RFvoXBxDFZ7V1u7u3A3kaCC1EHFzVqWJ7FRmbtfAXxZ8bMofDwQmPtpXPYN4Cwu4DE/
 lq7ceOihbAewX+6xDenz7p4l0Y+jce6OH75BK2cixJnC2tix9mtJzcIQVwW2cu85LEuzEN0CVp/
 6v+xUvbRLiF3HDvjhpIYWzJzRA4xYOvca7+ATUaP8N9ne+hD/GTtOpN17iz9l/JdGomniztg17m
 gSy2MDDn4pzQHCrwRgB5n1IWI/gZUdQuBERCTBa2+NPFPUFJoZ6+gTYckP0Oz1Ckr6sF6UaR9vH
 0HGvLKZW385rbry40LgkUNhtRnPO14sAR9vIcJdxp3g9lOv9yNBChu0H6iUCMnB9zam9wy/2RXh
 ekPPoqnNg3bNKhdN4vOZ1yVSyCasJoU4QoFn80y4M/xzihKF2Z8orYf3heIhsDpj4PR8yzhwQyo
 4b56JYbm14Wm15hkeRYGmAfykFWt1KWY7LMuMuj6UJPuKcBStEaXN3uZ43m61yRuCV6jHsTZdKO
 loo5vsIqXh4haQrLc7GaH+4qZgRn0vjEDeJYYE4F/IFOUKZ2xTkkGU1nadVop3eSsJys04eh9Wm
 cMJN8qrOsC9R7k9Ezsqd7VK2ytL9dP3HXXT9kShQZ2sYBl3yLlXKGSO/uQXvGZKcCWnZSEI/x6V
 rpflXizi09U9f+NF8=
X-Received: by 2002:a05:600c:4515:b0:4bb:659c:b8db with SMTP id
 5b1f17b1804b1-4bb88813b27mr188432135e9.12.1795351257527; 
 Sun, 22 Nov 2026 04:40:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884911e3sm305121985e9.6.2026.11.22.04.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 04:40:57 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 12:40:56 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie5336121e8a48e5a63b509d6a30349be42d311f9
X-Gerrit-Change-Number: 2216
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2216?usp=email>
X-Gerrit-Commit: 4a724c44388106379e80830cc0418015948fb989
In-Reply-To: <gerrit.1794990920000.Ie5336121e8a48e5a63b509d6a30349be42d311f9@gerrit.openvpn.net>
References: <gerrit.1794990920000.Ie5336121e8a48e5a63b509d6a30349be42d311f9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkwOTIwMDAwLkllNTMzNjEyMWU4YTQ4ZTVhNjNiNTA5ZDZhMzAzNDliZTQyZDMxMWY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a13c4d98b72471c98090fe9851584f6af126e3ce-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xV6sS-000000006dH-0eKo
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_openssl: don't
 log inline CRL contents
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
Content-Type: multipart/mixed; boundary="===============6611193658423157947=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6611193658423157947==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cL17Lbr9kPM="; charset=UTF-8

--cL17Lbr9kPM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2216?usp=3Demail )

Change subject: ssl_openssl: don't log inli=
ne CRL contents
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

ssl_openssl: don't log inline CRL contents

With an inline <crl-verify=
>, crl_file holds the PEM data, and the
"CRL: loaded" message printed all o=
f it=2E Use print_key_filename() as
the other CRL messages do=2E

Change-Id=
: Ie5336121e8a48e5a63b509d6a30349be42d311f9
Signed-off-by: Razvan Cojocaru =
<razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2216
Message-Id: =
<20261118151224=2E14866-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41613=2Ehtml
Signe=
d-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_open=
ssl=2Ec
1 file changed, 2 insertions(+), 1 deletion(-)




diff --git a/src=
/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index e2b65bd=2E=2E0=
3e0279 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_opens=
sl=2Ec
@@ -1410,7 +1410,8 @@
         }
         num_crls_loaded++;
     }
=
-    msg(M_INFO, "CRL: loaded %d CRLs from file %s", num_crls_loaded, crl_f=
ile);
+    msg(M_INFO, "CRL: loaded %d CRLs from file %s", num_crls_loaded,=

+        print_key_filename(crl_file, crl_inline));
     ssl_ctx->crls =3D=
 crls;
     BIO_free(in);
 }

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2216?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Ie5336121e8a48e5a63b509d6a30349be42d311f9
Gerrit-Change-Number: =
2216
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--cL17Lbr9kPM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2216?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl_openssl: don&#39;t log inline =
CRL contents<br><br>With an inline &lt;crl-verify&gt;, crl_file holds the P=
EM data, and the<br>&quot;CRL: loaded&quot; message printed all of it=2E Us=
e print_key_filename() as<br>the other CRL messages do=2E<br><br>Change-Id:=
 Ie5336121e8a48e5a63b509d6a30349be42d311f9<br>Signed-off-by: Razvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2216<br>Message-Id: &lt;20261118151224=2E14866-1-gert@greenie=2Emuc=2Ede=
&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg41613=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl_openssl=2Ec<br>1 file changed, =
2 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ss=
l_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index e2b65bd=
=2E=2E03e0279 100644</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</spa=
n><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -1410,7 +1=
410,8 @@</span><br><span>         }</span><br><span>         num_crls_loade=
d++;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    msg(M_INFO, &quot;CRL: loaded %d CRLs from file %s&quot;, num_crl=
s_loaded, crl_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    msg(M_INFO, &quot;CRL: loaded %d CRLs from file %s&quot;, num_crls_loa=
ded,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        print_k=
ey_filename(crl_file, crl_inline));</span><br><span>     ssl_ctx-&gt;crls =
=3D crls;</span><br><span>     BIO_free(in);</span><br><span> }</span><br><=
/pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2216?usp=3Demail">change 2216</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2216?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: Ie5336121e8a48e5a63b509d6a30349be42d311f9 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 2216 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--cL17Lbr9kPM=--


--===============6611193658423157947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6611193658423157947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6611193658423157947==--

