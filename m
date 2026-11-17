Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54998606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aE7/G2vR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VG09ocAL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SkasPZ1E;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=L41E9fNW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hsX35yikfUiCcbWNCsTAib9kZ/uWqzFE8sZKQU/H84I=; b=aE7/G2vRVju3YcI4VWGm82CVbt
	x/i6SeEpJdHDaj4Dg7IbyJsaYLSTjeUsAETYF2fCdI9jwSGDQjPFaDEUODH9AxkCMqMSlupUSECdk
	1A1ZZqvI1b0ETWrs8oron2sRsZXwsnpUMebLjRFal1T+/mJ0dmWoHDKI/XAHrbFVUup4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTKx0-000000007HD-04aV;
	Tue, 17 Nov 2026 15:18:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTKwz-000000007H3-1A95
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 15:18:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UVsmhLr0m+xhhhU32zDMNc1jP/Z7+LW4Fj0nGSKKuZk=; b=VG09ocAL6oeyINmqZs3FSO7WcI
 gfvBNX7yM0cvRDljXDuf/yT+2L5djORq21jL2eSv+yy4xk7kcel3ViYiHiEjucYwMrp78uQoSogre
 40dya6on6wFKKj2a12ooluSxS5/OHLWR52YtNDnzxHNupMyfPNIZ2xgfrMYK7ZRHXlyo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UVsmhLr0m+xhhhU32zDMNc1jP/Z7+LW4Fj0nGSKKuZk=; b=SkasPZ1E++KGvk0HEBKt8C9jYQ
 oZHerDGjB4MPLWYE/QDMMk2l+BUGUHdwKmNk/kbOwgpQ2kLl1o7XwgqMtA51umJUhBRC3IO+BhK6A
 uY6jjmDz/l6zO6XZXF32KVsHwYtqhEapLYAOn3Kxy6hQ7S+p6T2Xf5CZJmuk/Po20+KA=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTKwx-0000000053c-3WPx for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 15:18:25 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so15961345e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 07:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794928697; x=1795533497; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UVsmhLr0m+xhhhU32zDMNc1jP/Z7+LW4Fj0nGSKKuZk=;
 b=L41E9fNWK/Uz4erRMhI0ZERmH1Vskei7ug/78wVd9gAd7hyQzu6rQw/iy57bEU6p9p
 ECPo8dS20UHmejMGj5rX5AO3drdM7oF87XpRPxgrv8nHo01522KPpoJXeTTnzSxHDUo3
 KG7uuHRARkC7qmUuBosZQ0C7uMAqPfToVZmFZ7L1lTL15Tmo81JjS0wQ3kPuNkwz1TAN
 vPdXzbzGPjyBknZhg84MkY1KhZpiOR1S8hQkt0Dn4XGbczDahw68XHMZ6meZ1NhYai+W
 nt1Apk0xs39OBMKr5t//iiCUJIxtT7K6BxupcJAikj/hFFnYpQaeo9Wy7/gxz0zdhXvP
 FXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928697; x=1795533497;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UVsmhLr0m+xhhhU32zDMNc1jP/Z7+LW4Fj0nGSKKuZk=;
 b=DvglP4WC5TXkwwEV5Fd/782NTUzDLAHvSn9YYFO7yeIFa9dYfzc3B2H5Qq6RxHqVZF
 ENi8AkX41u8yYsTG3j+WdB1raDKtCYUn+5szftX8p0+HR0ZBfLOIIchdvQ/EWd4uFDI+
 J+jSIhV3/WbILL00U8N8x3t4MGwuCShWKQhq4zPLYrfwtdCzatcsh+iZBLbExEvGtlEB
 wxKZk3HEv5KtMCMjX8nL73EtvwBfHMvGs6b03H84fRZhIquQpcDoRllxGbTOgrUhKmAg
 V5/m4a9eqK8fEVErlB7ThSgKo7HQFZRwmRsru+P162j1nzqc64+KC7BlJ1MjR7r7U+YR
 MsYA==
X-Forwarded-Encrypted: i=1;
 AL+hErFzZNK0mnyMUjbYf9SFPRmw71ky4IsyHzZt6QNKHer3xpA1MNLjNEadOAdnVX8CY/Y2uVfzUoyhuptilEig@lists.sourceforge.net
X-Gm-Message-State: APuU4Z98GtfRmrP+fqv9fjHlTHoR1uH9z3Wp2lQ/IAtyNZ9wNu+cGn17
 XjbYKlEhJ5HpajAruBSaJXcJnFoYOK554vVHZv3VmZfl6Bu5P6YTrlyXm403EsBWYWNrrbdH7LQ
 rQw1aGL++f7GZNcXWdyUOgwpvRJY1ELmMWteXeOLllJn3MC/omBqufMhOb1ECDTfvsT+/
X-Gm-Gg: AYBFou36kUmKyvVuj8kqEOPuhjYCxqamWH4zgMNTXPDxkG0OJaVwLMjDeXw9/roDDLN
 QYUzL1DSEVL6vJcUgSRgnm9n/PkKdFFwxGnJy4NGJz10L28I4yRsNkPYON/tfU6gw5mXYiRrKae
 zzTVmSkbBTjm2fOIx4nxiBQWdZ5B6SHXEy0Lz6nmZkOrYAgyG3FDPdwnXpj1lVY3jdh+COY0qsL
 rMjzy6BuXyP6PtOMOo9+vNx+/Yv4v2ZhRjUSpMflmiWD9xwcCN2MMmcRf9hVy4EfMRxtYRKZmEU
 2cs5c/0E111NsUDO8WucS8t0Ihh1yEUSMLDepZUokK2FhoUpWoh/AZIVy5BIAi09P6LmHAU7Wgb
 +d4B2mk3F3KSrHBX9fkHJOuzc66FpJPW8+Ei+SXi7aeH1gpxEjjxJuSPwnFbvo5A51qlAmZ8DFc
 JKZPBzYQ6+tGaY+lx/Mevc0QYr5Jgexf8pRbcMdiwSfmZuJHyvXal47wGVunXNQ18Cv9BQFeM+r
 jv8rQd5XBpOqiI0GoA03QrOxFViaPLvA40MRIk7I8aXm0L9odPnWfEQJ6UdRa48YkWQ6kXnQjpG
 t8Gi6U9rguS7WG0BDSGDoMI6YaoRngo41QW0TF6jGLE/eBqNhiqMol7PWBUxhricMZ9Kf1OM59W
 6s95twwETo1qOZDOgdyr8Xw6dKqcroRwNIfYC6PO1aGJXusky2U8hPAm7Y5egioKMTKYajq6k54
 oDKvX2LkrVX+6Esvw=
X-Received: by 2002:a05:600c:3b93:b0:4bb:6f67:ca0b with SMTP id
 5b1f17b1804b1-4bb6f67caf0mr192138235e9.29.1794928697082; 
 Tue, 17 Nov 2026 07:18:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb732a2a9csm129343725e9.3.2026.11.17.07.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 07:18:16 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 15:18:16 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie87632ae3503f4c74b327186e6952f66ada66640
X-Gerrit-Change-Number: 2178
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2178?usp=email>
X-Gerrit-Commit: 0561f3eacdca44808a82b59bae2ff9578ccbd9fe
In-Reply-To: <gerrit.1794486217000.Ie87632ae3503f4c74b327186e6952f66ada66640@gerrit.openvpn.net>
References: <gerrit.1794486217000.Ie87632ae3503f4c74b327186e6952f66ada66640@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDg2MjE3MDAwLkllODc2MzJhZTM1MDNmNGM3NGIzMjcxODZlNjk1MmY2NmFkYTY2NjQwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <db62a518d1e112d4905fae805138d77842414c17-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTKwx-0000000053c-3WPx
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: xkey_digest: free
 the EVP_MD when EVP_Digest() fails
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
Content-Type: multipart/mixed; boundary="===============7631211121494328521=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7631211121494328521==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mErV9eMuzlE="; charset=UTF-8

--mErV9eMuzlE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2178?usp=3Demail )

Change subject: xkey_digest: free the EVP_M=
D when EVP_Digest() fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

xkey_digest: free the EVP_MD when EVP_Digest() fails

The err=
or path returned without EVP_MD_free()=2E

Change-Id: Ie87632ae3503f4c74b32=
7186e6952f66ada66640
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>=

Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2178
Message-Id: <20261112214330=2E13701=
-1-gert@greenie=2Emuc=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/=
20261112214330=2E13701-1-gert@greenie=2Emuc=2Ede
Signed-off-by: Gert Doerin=
g <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/xkey_helper=2Ec
1 file change=
d, 3 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/xkey_helper=
=2Ec b/src/openvpn/xkey_helper=2Ec
index f4be796=2E=2Edb4381d 100644
--- a/=
src/openvpn/xkey_helper=2Ec
+++ b/src/openvpn/xkey_helper=2Ec
@@ -71,12 +71=
,13 @@
     }
 
     unsigned int len =3D (unsigned int)*buflen;
-    if (E=
VP_Digest(src, srclen, buf, &len, md, NULL) !=3D 1)
+    int ret =3D EVP_Di=
gest(src, srclen, buf, &len, md, NULL);
+    EVP_MD_free(md);
+    if (ret =
!=3D 1)
     {
         msg(M_WARN, "WARN: xkey_digest: EVP_Digest failed")=
;
         return 0;
     }
-    EVP_MD_free(md);
 
     *buflen =3D len;
 =
    return 1;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2178?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: me=
rged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie8763=
2ae3503f4c74b327186e6952f66ada66640
Gerrit-Change-Number: 2178
Gerrit-Patch=
Set: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>

--mErV9eMuzlE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2178?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">xkey_digest: free the EVP_MD when =
EVP_Digest() fails<br><br>The error path returned without EVP_MD_free()=2E<=
br><br>Change-Id: Ie87632ae3503f4c74b327186e6952f66ada66640<br>Signed-off-b=
y: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichten=
held &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2178<br>Message-Id: &lt;20261112214330=2E13701-1-gert@g=
reenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-devel/202=
61112214330=2E13701-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/xkey_helper=2Ec<b=
r>1 file changed, 3 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/xkey_helper=2Ec b/src/openvpn/xkey_helper=2Ec</span><br><=
span>index f4be796=2E=2Edb4381d 100644</span><br><span>--- a/src/openvpn/xk=
ey_helper=2Ec</span><br><span>+++ b/src/openvpn/xkey_helper=2Ec</span><br><=
span>@@ -71,12 +71,13 @@</span><br><span>     }</span><br><span> </span><br=
><span>     unsigned int len =3D (unsigned int)*buflen;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (EVP_Digest(src, srclen, buf, &amp=
;len, md, NULL) !=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    int ret =3D EVP_Digest(src, srclen, buf, &amp;len, md, NULL);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVP_MD_free(md);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret !=3D 1)</spa=
n><br><span>     {</span><br><span>         msg(M_WARN, &quot;WARN: xkey_di=
gest: EVP_Digest failed&quot;);</span><br><span>         return 0;</span><b=
r><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    EVP=
_MD_free(md);</span><br><span> </span><br><span>     *buflen =3D len;</span=
><br><span>     return 1;</span><br></pre><p>To view, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2178?usp=3Demail">change 2178</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2178?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie87632ae3=
503f4c74b327186e6952f66ada66640 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 2178 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 =
</div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--mErV9eMuzlE=--


--===============7631211121494328521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7631211121494328521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7631211121494328521==--

