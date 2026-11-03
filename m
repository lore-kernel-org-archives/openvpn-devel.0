Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88A7606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AI2wOLi2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CV2gUYMd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hjM5axP+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HKCYUKdk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QEb0ZMSRyo73Tdbp/T9XlRl75uPMuFhzkFLuy1mhe1U=; b=AI2wOLi2Imk5TJeaWm/bTgnDHO
	rvNUn4UwFhe6k1923biRCAIpKxrdgKsucOEisymiDAo+Ed5EKPGnCslFC7EIN87ayi+hUuE3deyCP
	NoJkRPS9PwWp0yLxYFyIOqw1aSKV0fQBtUbh7uBAzwsnpc1KMnzzPXS9GbW1UKy3/amM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOGlw-000000007rJ-2H4a;
	Tue, 03 Nov 2026 15:50:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOGlt-000000007qG-22QY
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:50:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+VlGP+jnplLTaBed0whWYNDT8whKH3yxwYc8DYyiDtI=; b=CV2gUYMdUQ8m6H/jbtmAD+FWbk
 phUPYhS9kFNHmb9X+mPnusXY2ZH8+dFpMCT8rE7jl0Wgte+Lcsy6MF1vcYPVzOkBZF9MVJH9wPivb
 A08vKGUfY7nDbLnNi/oUKZUzG3PRUeGSGq8JgLLRTXG9uER5s3/9Oo3NHN9xOrmPGgCQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+VlGP+jnplLTaBed0whWYNDT8whKH3yxwYc8DYyiDtI=; b=hjM5axP+XGWb7sL7IZ5pns+O7E
 SToikRpt5C1DOWFOPAq+hFJfPkgU6na1CE24rxabejI9bZyO8BoYjhvdLTEo4SCbsxQZUTcoWjrhT
 PEbDd3yk1j4R8UNDahJNiWUqntA7SdeJn59RLiD6Xuuzni3Hb77UbxP8l9wEmuoBUnJI=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOGlq-000000000C8-0WOv for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 15:49:58 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so33435375e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 07:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793720991; x=1794325791; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+VlGP+jnplLTaBed0whWYNDT8whKH3yxwYc8DYyiDtI=;
 b=HKCYUKdkb8PaCpV7OS69QFksFr9bfdaKjJ1TWcNFmCkA13WR3Ns7ZIbanXsp3OyBfG
 1g9B5G+nB1cEqh3V8nb//uwvc3VrFPpRIcqOa268HuaFSejWv8gcRgOobGwacqisKZMa
 yEne2coHqC//8j+bjbzbiT8NkwteQdFU5/MA4j4uc6J11C3MYlugCYEfRfgJNEwvq1fK
 OdBZM7is2u7by2Xf509CvIQV9rdzznuNWvoYk2gceD5ADjogyPebrWEc9gw+Etf36izy
 3gMKRA2/DdtHswBuJPe6Rxbn6FNNJ54vzOwA2g1w4fNwcQVBMNypl1IuqfbWYq8YKf09
 fiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720991; x=1794325791;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+VlGP+jnplLTaBed0whWYNDT8whKH3yxwYc8DYyiDtI=;
 b=iRmwEHEjXy5OlYDBMa1bg9hrtWiGTLSB3K8kcHisZkoNXL5qEBqtIOxIwSO3rKaS0b
 YW67Ou+gAkaHJjjpES8A0AgxuC2iDUCdJlFoRv3Wd0uAs9aqDxesoxbjcaeFnhPVdQYu
 wikKt8PT13LP4U6ryTToSVSws5TGFP9lCt0dv0uMzPd1Sq2A0QrAXgygfMGQuN0qTNpf
 jTOL8JNAjgYub6zxMrevnANDX7pse3ND45Ht2yF+G1UXvPBUg7QsHKmMnAfom90zCSHG
 ScDYxpFg5bakWcaovX5IVpsOy7OO8yT8Rio5r02MOd2DEUtJYaxziwSNrGotkO1eBiXx
 WwMw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9G8wpGas5521EyTG3qpRzwCG8ysUXSnpIBdc0/lwi1ZhtXP8Dd1wVjw4lww9y7kqsKhGS343we28i3I/P@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+uZSUw0x4sYVajB0FYi7ZvEo5wj4gvzNY5BqCO6+p9m4/LVLU5
 IAXcrrbHlu67KI4hUvilAfYmPkEWAkivLtH5cB3wFB2oEycYG0ptBqUxXE+9jxCKd6CYhENwVJY
 ZkdMtz2CGwEWpLgNf/aPt0xxYX6U7ISIPbdqjKVfR96uLoJn5R5GyvN+OxiA42p0hnOds
X-Gm-Gg: AYBFou0ECZy9nsAQYxmqYL2NWL+ddVPjNPbtCyPZACmDXUwmrr1Yk6Cqt5OlDIulUOC
 O0cz49Hu4CzGn9bej1DDYE/w+uCjjih1LU3xFzN68Y15+l1FpUQTVsiLtVWexxRRleipnef2b05
 JKx32oa2h8x4ik72M1fJlFbMvpfPpMUpNpjssUs/o/p9BmPnTwT0I4AvyhAX3/en5jkMhZ/MCLG
 ZcXJc3aGFaRq1TqNdaWG4Lz/g5XfU2kEiqIOvh36IVrWZIdwNM+CPe0MbKCwB/9XKy5C4rWCaaE
 pneqaDWHNsyVP1w+0MHz5JfKU2oHXZZThROTt9zNYg/EN7xOumFI+4l8dktoiOWMw2ov/kt02fM
 0HZHpc3UztpLOlzmGXadtMZ0dd4BQim4XNtjkLDtJX9EmoFW8fTfTRjG1WrVEvp4x2Ue1acC84Q
 /osFYhH8sXCCL+j2JZccNgMKX4QRVyaOj4LA9p9ch0nIBQ02rmXxgQaagJJIHt5QlRyIT5xrNRw
 KiOlL0qSC7jI9jD0VXioUxbpitHI0aRlpc49D2Bf2qaOzcxSwpAi/RW1ShANA+9YnSrxqMWz8PP
 tiIb0Y5dSlpKll4vZ3kCLWVH/19WR3uNSy3OxDCxyxw+nUrbrISYTlSvPa4RiSx2ePtkR/NPIG0
 l8lLcWV6FT9YgNqCTQSQ5oltFymVXMTxe1KV9I+gTXEUroElZEzCb0xtWZgZGFXphGN8i+Qt9/d
 j3KiOq0zz0vdf6lA==
X-Received: by 2002:a05:600c:190f:b0:4a2:1a:a11d with SMTP id
 5b1f17b1804b1-4ac1275c26emr292795885e9.0.1793720991469; 
 Tue, 03 Nov 2026 07:49:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77af8csm469547985e9.1.2026.11.03.07.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 07:49:51 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 15:49:50 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ia3f6dd4ce35869c92619ce0c56eeda8796bde006
X-Gerrit-Change-Number: 2084
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2084?usp=email>
X-Gerrit-Commit: a1cd0cf8a97bd09c12d2e0980a88acc27612ec5d
In-Reply-To: <gerrit.1793618639000.Ia3f6dd4ce35869c92619ce0c56eeda8796bde006@gerrit.openvpn.net>
References: <gerrit.1793618639000.Ia3f6dd4ce35869c92619ce0c56eeda8796bde006@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4NjM5MDAwLklhM2Y2ZGQ0Y2UzNTg2OWM5MjYxOWNlMGM1NmVlZGE4Nzk2YmRlMDA2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <765b3c1af8d4c7efc1746631d666ee0bd5af29f3-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOGlq-000000000C8-0WOv
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: check_file_access:
 fix --extra-certs access check
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
Content-Type: multipart/mixed; boundary="===============5250152199176956022=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5250152199176956022==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c6jJqkly8QI="; charset=UTF-8

--c6jJqkly8QI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2084?usp=3Demail )

Change subject: check_file_access: fix --ex=
tra-certs access check
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

check_file_access: fix --extra-certs access check

The file name=
 was passed as the is_inline flag, so the check was
always skipped=2E Pass =
extra_certs_file_inline instead=2E

Broken since cb2e9218 ("convert *_inlin=
e attributes to bool")=2E

Change-Id: Ia3f6dd4ce35869c92619ce0c56eeda8796bd=
e006
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2084
Message-Id: <20261102115818=2E14189-1-gert@greenie=
=2Emuc=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261102115818=
=2E14189-1-gert@greenie=2Emuc=2Ede
Signed-off-by: Gert Doering <gert@greeni=
e=2Emuc=2Ede>
---
M src/openvpn/check_file_access=2Ec
1 file changed, 1 ins=
ertion(+), 1 deletion(-)




diff --git a/src/openvpn/check_file_access=2Ec=
 b/src/openvpn/check_file_access=2Ec
index 83654b2=2E=2E25d7f90 100644
--- =
a/src/openvpn/check_file_access=2Ec
+++ b/src/openvpn/check_file_access=2Ec=

@@ -267,7 +267,7 @@
     errs |=3D check_file_access_inline(options->cert_=
file_inline, CHKACC_FILE | CHKACC_ACCEPT_URI,
                             =
         options->cert_file, R_OK, "--cert");
 
-    errs |=3D check_file_a=
ccess_inline(options->extra_certs_file, CHKACC_FILE,
+    errs |=3D check_f=
ile_access_inline(options->extra_certs_file_inline, CHKACC_FILE,
          =
                            options->extra_certs_file, R_OK, "--extra-certs=
");
 
     if (!(options->management_flags & MF_EXTERNAL_KEY))

-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2084?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia3f6dd4ce35869c92619ce0c56eed=
a8796bde006
Gerrit-Change-Number: 2084
Gerrit-PatchSet: 3
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--c6jJqkly8QI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2084?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">check_file_access: fix --extra-cer=
ts access check<br><br>The file name was passed as the is_inline flag, so t=
he check was<br>always skipped=2E Pass extra_certs_file_inline instead=2E<b=
r><br>Broken since cb2e9218 (&quot;convert *_inline attributes to bool&quot=
;)=2E<br><br>Change-Id: Ia3f6dd4ce35869c92619ce0c56eeda8796bde006<br>Signed=
-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2084<br>Message-Id: &lt;20261102115818=2E14189-1-=
gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eorg/openvpn-dev=
el/20261102115818=2E14189-1-gert@greenie=2Emuc=2Ede<br>Signed-off-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/check_file_=
access=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/check_file_access=2Ec b/src/openvpn/check_file_a=
ccess=2Ec</span><br><span>index 83654b2=2E=2E25d7f90 100644</span><br><span=
>--- a/src/openvpn/check_file_access=2Ec</span><br><span>+++ b/src/openvpn/=
check_file_access=2Ec</span><br><span>@@ -267,7 +267,7 @@</span><br><span> =
    errs |=3D check_file_access_inline(options-&gt;cert_file_inline, CHKACC=
_FILE | CHKACC_ACCEPT_URI,</span><br><span>                                =
      options-&gt;cert_file, R_OK, &quot;--cert&quot;);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D check_fil=
e_access_inline(options-&gt;extra_certs_file, CHKACC_FILE,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    errs |=3D check_file_access_inli=
ne(options-&gt;extra_certs_file_inline, CHKACC_FILE,</span><br><span>      =
                                options-&gt;extra_certs_file, R_OK, &quot;-=
-extra-certs&quot;);</span><br><span> </span><br><span>     if (!(options-&=
gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2084?usp=3Demail">=
change 2084</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/208=
4?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ia3f6dd4ce35869c92619ce0c56eeda8796bde006 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2084 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--c6jJqkly8QI=--


--===============5250152199176956022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5250152199176956022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5250152199176956022==--

