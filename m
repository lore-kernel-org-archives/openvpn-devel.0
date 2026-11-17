Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F31B606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aLC/XYvs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SSB+UG2a;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=k7zhNLHT;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bdJ8b7Ec
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KO0miQQ6oD5v3yjfyFVrJ02Uxm9hOA1F3lKRQVzzmnA=; b=aLC/XYvs/e5x7qoKOS1W8c9cPJ
	+sKwyNMBUE4ca42A44RgZXDK+9kPW4SNkf9uRAA3lzYSxgTh3IfFkxcgEKRKwp8hoHTWjEy4dSL7l
	1vvYMfdIpKH2qP2kGfDhf4G9Y9IUv3QW1Spxgikr0wm9Isn+X2ekkHmGbMGSiLlQt8eg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTKwy-000000004F8-1SqI;
	Tue, 17 Nov 2026 15:18:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTKwx-000000004F2-3722
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 15:18:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hbgn2q3OCJBOC1LcTkiiPb1stVJ9gFou1IwJQWmuzhE=; b=SSB+UG2aqwVNLj3SCHMw77qYNH
 ISxRDeFALjOIfSbglVA8A/a6FyEd/0gMDYVifc4v9HfigpouGCrRmG2oMqgYDIUO0/NcMfUgtqdOp
 WkYtzm4hP9++nIWLckuMowfJpjnoImLk/zq+4M1BVzuyf4jxMTG8TAEjMqe7dqmtcLqo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hbgn2q3OCJBOC1LcTkiiPb1stVJ9gFou1IwJQWmuzhE=; b=k7zhNLHT1czF55O4sK+JpUEzuX
 M2uhYCjk+cZ8jXrpZFeteAAUolYE+S7OKRlVJzaik7BmTHZCwPV0Ou1NSouT51F9lDAYVKrCc5RSM
 P6kCj9L2NyDB72nnb4VzYJmDdHGyY6E5S3KOMbXSNzTneMQj+TS4uJYeUDvRT4iZpUJk=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTKwx-0000000053a-0BzR for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 15:18:23 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so28683675e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 07:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794928696; x=1795533496; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Hbgn2q3OCJBOC1LcTkiiPb1stVJ9gFou1IwJQWmuzhE=;
 b=bdJ8b7EcJ0qSnszVHyE26KpqRFdeViAhFvdDE6yuvMMxGadlUxocgMs187a0JEY/Xl
 TTZzAK2+4ZfdO7AR1Q9zLK8XK0aMul/EEg8hlL7vEnUBf2kWo3TXjf5R+LSe9lnVBhEh
 UGHeucJ79nADOQYZJu3/qid2OcXILbOPYtNnMGWOCySf/KFw+X/WLVNXOuUHcH6LDck5
 OaZkLgs2qLGc7qGwahlyy4ppfB+ga2mIq3+a7ZsoYPCJUEMzn/ohZMTKMmzOWErx9zWN
 HWJNf7OMEwf9577ity0IhM9gnQo3DriPp8YZ3+3X9jmdgGoMFc621QnWpf1sxhm0RNTd
 yEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928696; x=1795533496;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Hbgn2q3OCJBOC1LcTkiiPb1stVJ9gFou1IwJQWmuzhE=;
 b=kCYPpVDpnjzzsspFNJSZ8YqqYuzFeY48/57SaxwqSfan/2SiLkZH8f8r1dU4hxH1TQ
 5xRNZt4erfHN1t0KGiwh4aEARQgiOEmL4z0V14i6EhHoDgulBUULDVV1CPgSUZUb2xr/
 CWXbHVSCGn1IDmqnMWOgwvlbtnMg5On/0xCfXmFPZxwxSTIhScpTr/ciBzLVHb1yE9kB
 7EALjc+vcBewZPt3y99D1QiA4Vm7ljKRDtYdHC2RXuU18GHxGycBJHvlTNmGE7AXDIIP
 j3VRMATRTpo+0NZckMYKm9I0Wija/q6BiRUoAljvTaHlANe6gZnSojX87/uWShzGbkS1
 tUsA==
X-Gm-Message-State: APuU4Z+DocCx0ra0au6B3mn7bu9U0dmN9UDsPbk3WIa4pOWfyMveZGtG
 i48lOmj+fFc020aQontENrLKTIq7yno360rhjgStoUx+5mBWp8V1muDGayX+0P06OaLMJAAt7iF
 djVkVkUYPHXhSI+GxvuE4nHWDong1w83BSv9Ur+Z9SygVr6NCoyqF7GAjBFnysLzhPlw+
X-Gm-Gg: AYBFou2iaSOEZmp1PLNQgkbeU3jP/WXVGl1ipSzz/hy/ah08etIRiMXVKXManNSeRS7
 q5w1eOSDy6Pch598zRpKazigzArQusTMi4zCojk6RPLPoKolq6zRaTv6umcnanWGPmEs8+KfRmY
 qoKhLSvJoj8COOBTiM0iwwC16OfV9HlFlybMBu7/V5zWJzPn/S8E1FITSL0sAO4KZCmugfWRfQR
 fvzM2uaWBbh4yE6TPSh8VsnK30R4uuDIM7IOlSOheQDHiSSdzw1SCgbFVyC8iqvwmJyYvRxR6st
 Rg5VABuvuUgM6PQAzOuGVOmThZ1uU+gK14JR6ajkvV6unoCLJXhwKTE3cplDpjNpZnc/vyhiek5
 CUtrF94yVkQBs1BMJDvIcYKzU+nROBoYkUU/IhrLCxFVrLEw3ximHAvWVt/bGyFEsHpU6Yag/gf
 /jCmbP6fKdd5eD8jeOIZnZvDg7kK3DvZsVRQVSbO6tv9r1c2RyRj3fJgWBfOWQ1YB5Yi9Pa0C10
 bYp/0fEDYfXKJymtNo3tXNOTOEnF+fQ2I0YZ+JK78iQCh9RtRrp9/MGpUi+Av1GXZHb4YAZE637
 9D4W4GNxkiPoV2cXMfaInMbIjbYTsWVieYVAPrBgcaw2pTjU6KKunspV8DolDsZr7Nxn8JGS+RJ
 WhPeLbFMWP2Tma2bOlJpFm+mFnSkTomAOPF9qwDKnZlwkImkY/XOT4EVsfbwzPnc/L/17zXUoWD
 PqjkqhqJUvXy3qFJ77VLyOraUNs7GgWTwipYi7
X-Received: by 2002:a05:600c:6989:b0:4bb:6823:3d3c with SMTP id
 5b1f17b1804b1-4bb68233edamr223751445e9.20.1794928696249; 
 Tue, 17 Nov 2026 07:18:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb734b9f44sm102698715e9.1.2026.11.17.07.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 07:18:15 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 15:18:15 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie87632ae3503f4c74b327186e6952f66ada66640
X-Gerrit-Change-Number: 2178
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2178?usp=email>
X-Gerrit-Commit: 0561f3eacdca44808a82b59bae2ff9578ccbd9fe
In-Reply-To: <gerrit.1794486217000.Ie87632ae3503f4c74b327186e6952f66ada66640@gerrit.openvpn.net>
References: <gerrit.1794486217000.Ie87632ae3503f4c74b327186e6952f66ada66640@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDg2MjE3MDAwLkllODc2MzJhZTM1MDNmNGM3NGIzMjcxODZlNjk1MmY2NmFkYTY2NjQwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <db62a518d1e112d4905fae805138d77842414c17-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTKwx-0000000053a-0BzR
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7498834945578059465=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7498834945578059465==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IWlLBuSmqak="; charset=UTF-8

--IWlLBuSmqak=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2178?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: xkey_digest: free th=
e EVP_MD when EVP_Digest() fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

xkey_digest: free the EVP_MD when EVP_Digest() fails

T=
he error path returned without EVP_MD_free()=2E

Change-Id: Ie87632ae3503f4=
c74b327186e6952f66ada66640
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2178
Message-Id: <20261112214330=
=2E13701-1-gert@greenie=2Emuc=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvp=
n-devel/20261112214330=2E13701-1-gert@greenie=2Emuc=2Ede
Signed-off-by: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/xkey_helper=2Ec
1 fil=
e changed, 3 insertions(+), 2 deletions(-)


  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/78/2178/2

diff --git a/src/openvpn/xk=
ey_helper=2Ec b/src/openvpn/xkey_helper=2Ec
index f4be796=2E=2Edb4381d 1006=
44
--- a/src/openvpn/xkey_helper=2Ec
+++ b/src/openvpn/xkey_helper=2Ec
@@ -=
71,12 +71,13 @@
     }
 
     unsigned int len =3D (unsigned int)*buflen;
-=
    if (EVP_Digest(src, srclen, buf, &len, md, NULL) !=3D 1)
+    int ret =
=3D EVP_Digest(src, srclen, buf, &len, md, NULL);
+    EVP_MD_free(md);
+  =
  if (ret !=3D 1)
     {
         msg(M_WARN, "WARN: xkey_digest: EVP_Diges=
t failed");
         return 0;
     }
-    EVP_MD_free(md);
 
     *buflen =
=3D len;
     return 1;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2178?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: Ie87632ae3503f4c74b327186e6952f66ada66640
Gerrit-Change-Number: 21=
78
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--IWlLBuSmqak=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2178?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">xkey_digest: free the EVP_MD when EVP_Digest() fails<br><br>The error p=
ath returned without EVP_MD_free()=2E<br><br>Change-Id: Ie87632ae3503f4c74b=
327186e6952f66ada66640<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<=
br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2178<br>Message-I=
d: &lt;20261112214330=2E13701-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:/=
/lore=2Ekernel=2Eorg/openvpn-devel/20261112214330=2E13701-1-gert@greenie=2E=
muc=2Ede<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>=
---<br>M src/openvpn/xkey_helper=2Ec<br>1 file changed, 3 insertions(+), 2 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/78/2178/2</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/xk=
ey_helper=2Ec b/src/openvpn/xkey_helper=2Ec</span><br><span>index f4be796=
=2E=2Edb4381d 100644</span><br><span>--- a/src/openvpn/xkey_helper=2Ec</spa=
n><br><span>+++ b/src/openvpn/xkey_helper=2Ec</span><br><span>@@ -71,12 +71=
,13 @@</span><br><span>     }</span><br><span> </span><br><span>     unsign=
ed int len =3D (unsigned int)*buflen;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (EVP_Digest(src, srclen, buf, &amp;len, md, NULL) !=
=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =
=3D EVP_Digest(src, srclen, buf, &amp;len, md, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    EVP_MD_free(md);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (ret !=3D 1)</span><br><span>    =
 {</span><br><span>         msg(M_WARN, &quot;WARN: xkey_digest: EVP_Digest=
 failed&quot;);</span><br><span>         return 0;</span><br><span>     }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    EVP_MD_free(md);</s=
pan><br><span> </span><br><span>     *buflen =3D len;</span><br><span>     =
return 1;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2178?usp=3Demail">change 2178</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2178?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie87632ae3503f4c74b327=
186e6952f66ada66640 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2178 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>

</body></html>
--IWlLBuSmqak=--


--===============7498834945578059465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7498834945578059465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7498834945578059465==--

