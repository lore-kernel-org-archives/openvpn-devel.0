Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D5C606A335
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W84dOpdT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jlKcBDGc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=P8s5XOh2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=daTxiANd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OEFC6A89TCwyH9ERP0LpJB4TyDtfKMbww5wDC0o/oDw=; b=W84dOpdTiCEajT0mbID2DZIrKn
	bQuNbPJnAK38zOpBmrfJVaCQDIlMxZrIxgMzOOro95lbW+mjX8CFpYBcCJHGD+l522jTXavabJfYk
	MnVyAHHm1q7TzwfN6Uej+LyTb7qL5+Jcm/Fu3Swrft8LmLATEbPHjHIlF4/ZJ+fALxJc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRo0b-000000007jg-2xSo;
	Fri, 13 Nov 2026 09:55:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRo0J-000000007iy-2wGF
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 09:55:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wkVhMUT9nh3MkGlrUgGrjrgdE7Pxsf6zfCoAla9bNH4=; b=jlKcBDGchwE0An95U4B6Ica1VM
 X65hCb3/vL0A5puLL/kMAnrmk6CTD76ojDt7vejJuJ2yuuWk89Qmxc55M8eFQvSl/TNDPSJ8vg5aQ
 +l28KnTvfUrj/hZ+lIeeU+UFitvLqjkOZWgPoZzUQM3qaCCe9+8URtmYefx0IEVq5V24=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wkVhMUT9nh3MkGlrUgGrjrgdE7Pxsf6zfCoAla9bNH4=; b=P8s5XOh2iVZ27x9cUdpo7R2Yzo
 yr6IgHbXL2Ke/SxGa0bHZVzCPvUxZRiyAsKBKGO+KTbBkWJCEKFPHm+53rAkv4OZhpM+OgeON9Kcg
 8eILlilWZbP3lz5rljhCPuJyZEr3Tv8dOaBEFLEKpG+q4OK6Ewc80bAK/8Ur836HIs/8=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRo0G-000000000I6-1LaN for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 09:55:29 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso5074095e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 01:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794563722; x=1795168522; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wkVhMUT9nh3MkGlrUgGrjrgdE7Pxsf6zfCoAla9bNH4=;
 b=daTxiANdJdKZzD5EHHo5JbHuqkujv+ahmMppey34qQKdVKcusV+9lx11GvV/2AIsXN
 KPD/8K4Pq8DElXYrZxVcs185B8ykNLuXZBKy77xJJxXzy46++V6KAD8Isul1mrPE0aTc
 EDdBWga3n8wHBssSN12Er29L61IykPxCyLIzSYw77iFBh55lAbpgUh7XDKtiEhbRHueh
 6axdW0c1TDr2AnndmC6DqpiLWDI6OL+ZFm7YhHTFiFoyMkIGbTYyMLLu8CVXSRzYlYdZ
 p0HI937UobFtq1aZBiY2NBINyhIh2a9T0Mrr/VHT4ury6IuHIa/dQi9UDJqZdw0c7jg/
 /67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794563722; x=1795168522;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wkVhMUT9nh3MkGlrUgGrjrgdE7Pxsf6zfCoAla9bNH4=;
 b=dDZoSRUYfjp/i/I7uDRQg3L+3+aJWyIvEB9cmOUKN4tREjtPZMZaV7s70/2VAuCTLE
 oAkmMNSDXu5HbKm4SFnV2hYQY5YbFq2UfmzgR+5VFpfU8jd6GBlplflbMeUxTbbuyW0n
 ajQldl3b55lfG585g8rs4LdPyYSCV2hrSqT6xPBwufpwV2QA7629q+Wvst5dRrhMtNkt
 vQ3WLs+OxRpPPtZDbiS5CVJW1sfcK+mel1mFfzPS2cCHMhBvpqhd1RL6xbpBFiRE6XDO
 EpO2y3yNpSiqKXHC3ecPix43G6YuPbZAMwb77NJeYjcoIJtGQNgwDbQTjV6XXjAyNp0Y
 doNQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGrORwsiDNhr1M8Uf8qH9yELacE91I1Mzz2oo2cIpiNLiooT1j7omGKsMNgtkCt3MPRYxeKqtFg8La5DWFS@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/n1gNpDIKidRQ/dynOQfzOyuX/TuFYBdDKFmrrPVAgfcn/gvrt
 wxdsO59ADcDq5HvLz4/HGVcYsHSysuWW/l97okGUilfomJd7jeF1anBDzNL8Z5Ug7bxV3u5I8CW
 4MBy/CdapcIhM+Fi2zTOBAibDE69W9fRCZUDqfw9HvWHqk/1HmRqHxsCuaPhjN7NpVWDM
X-Gm-Gg: AYBFou1GzlrckeQkrALAagvDDxMVDMenKFH9kri4K7B2wL1a+CoDL4oDbJzbaB4CPY2
 uUn0XVTNGpjYhvMAhONnKrzmHZWv7jGWO31jBTTqp8IDZNwa0A9g+MP/8n35bMWAehLBfXg7g/m
 TTKBNSE+MLePnVFI2dIuQoclls5srR6SA53+2pkAQ+HFupNzt7pEjnhrhUpFsEkXHqcJgvFw/gQ
 3VaHti4MnSUZAb31L7WhZC9SMxRI1jsovM1p6UaoqjOcEMIhx/cjh2A3rAyW8Wjb/lOlhjdr6Th
 FcCdnZQp/78cEwPqytXjke51C5JFpllCudIxS2Zg4pIEaQlzpmwfhpIaUuGz72+Un/iXdtVuOQx
 3VJ+nEPH62yANf+qSD/rSs2ODEwiAv/lkCtOzuGBJ7/T8IXE4pCKKtR2T7RQDBty3lFXLvVJKBu
 OixvmyVmfzJbKn914+18BeaO8MpG5bQg47JYBqLVZpMdMIipeOQ83EHvpVobjlFM/Br14lEGy3+
 GPUCpatIFEWm1rS/B4zKCw+Sip1dfJKxj0z88guP+9sEmAL9FDO70l0xGr2ZDXTj7wYO2dJWgVd
 G+L0Jtt1DkLL1brU8Dpae4RRGPae8CUXTLHsD8hYzTfZeN0H1XWuTt0X0ciqI+XbygAoQUQrmR8
 RPZDu8hZkJkyFsdH+JigFn78m0RUJKGe9/Nf9roqokuzqAZ1RIL+o3A9veZ0iahdV05rbZgRHRI
 jJ2RTlfIKw754Cw3Y=
X-Received: by 2002:a05:600c:a45:b0:4ac:86c9:b09c with SMTP id
 5b1f17b1804b1-4bb55a69123mr39514435e9.13.1794563721608; 
 Fri, 13 Nov 2026 01:55:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2acf81sm128946315e9.14.2026.11.13.01.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 01:55:21 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 09:55:20 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ibc9eb15714f14a9f49366fc84072087fc3f013c9
X-Gerrit-Change-Number: 2152
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2152?usp=email>
X-Gerrit-Commit: 11da41d10b9a772df0dec1862e25f3e303a56ce0
In-Reply-To: <gerrit.1794067506000.Ibc9eb15714f14a9f49366fc84072087fc3f013c9@gerrit.openvpn.net>
References: <gerrit.1794067506000.Ibc9eb15714f14a9f49366fc84072087fc3f013c9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDY3NTA2MDAwLkliYzllYjE1NzE0ZjE0YTlmNDkzNjZmYzg0MDcyMDg3ZmMzZjAxM2M5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1bc597608ae7f78b72c0e231ec6297bbb4909f8a-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRo0G-000000000I6-1LaN
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_verify: reject
 an empty certificate fingerprint
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
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, max@max-fillinger.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>, Max Fillinger <max@max-fillinger.net>
Content-Type: multipart/mixed; boundary="===============5389301284611166271=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5389301284611166271==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vPGkK5jeFmA="; charset=UTF-8

--vPGkK5jeFmA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2152?usp=3Demail )

Change subject: ssl_verify: reject an empty=
 certificate fingerprint
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

ssl_verify: reject an empty certificate fingerprint

verify_c=
ert() compares the configured hashes over the length of the
computed finger=
print=2E With mbedTLS built without SHA-1 the SHA-1
fingerprint is empty, s=
o the zero-length compare matched the first
entry and --verify-hash <hash> =
SHA1 accepted any CA certificate at
depth 1=2E Reject an empty fingerprint =
instead=2E

The compare length has come from the computed fingerprint since=

2193d7c0 ("crypto: Enable SHA256 fingerprint checking in --verify-hash")=
=2E

Change-Id: Ibc9eb15714f14a9f49366fc84072087fc3f013c9
Signed-off-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Steffan Karger <steffan@kar=
ger=2Eme>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2152
Messa=
ge-Id: <20261110143703=2E15137-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41110=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
ssl_verify=2Ec
1 file changed, 7 insertions(+), 0 deletions(-)




diff --g=
it a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 0cdec1e=
=2E=2Ea5b57a5 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl=
_verify=2Ec
@@ -697,6 +697,13 @@
                 goto cleanup;
         }
=
 
+        if (BLEN(&cert_fp) =3D=3D 0)
+        {
+            msg(D_TLS_E=
RRORS, "TLS Error: cannot compute the certificate fingerprint for "
+      =
                        "--verify-hash/--peer-fingerprint");
+            g=
oto cleanup;
+        }
+
         const struct verify_hash_list *current_h=
ash =3D opt->verify_hash;
 
         while (current_hash)

-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2152?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: Ibc9eb15714f14a9f49366fc84072087fc3f0=
13c9
Gerrit-Change-Number: 2152
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zva=
n Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: Max Fillinger <max@max-fillinger=2Enet>=

Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: Gert Doer=
ing <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--vPGkK5jeFmA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2152?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl_verify: reject an empty certif=
icate fingerprint<br><br>verify_cert() compares the configured hashes over =
the length of the<br>computed fingerprint=2E With mbedTLS built without SHA=
-1 the SHA-1<br>fingerprint is empty, so the zero-length compare matched th=
e first<br>entry and --verify-hash &lt;hash&gt; SHA1 accepted any CA certif=
icate at<br>depth 1=2E Reject an empty fingerprint instead=2E<br><br>The co=
mpare length has come from the computed fingerprint since<br>2193d7c0 (&quo=
t;crypto: Enable SHA256 fingerprint checking in --verify-hash&quot;)=2E<br>=
<br>Change-Id: Ibc9eb15714f14a9f49366fc84072087fc3f013c9<br>Signed-off-by: =
Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Steffan Karger &=
lt;steffan@karger=2Eme&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2152<br>Message-Id: &lt;20261110143703=2E15137-1-gert@greenie=2Em=
uc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg41110=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl_verify=2Ec<br>1 file chan=
ged, 7 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>index 0cdec=
1e=2E=2Ea5b57a5 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</sp=
an><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -697,6 +69=
7,13 @@</span><br><span>                 goto cleanup;</span><br><span>    =
     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (BLEN(&amp;cert_fp) =3D=3D 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(D_TLS_ERRORS, &quot;TLS Error: cannot compu=
te the certificate fingerprint for &quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                              &quot;--verify-hash/--p=
eer-fingerprint&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            goto cleanup;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span>         const struct verify_hash_list *current_hash =3D o=
pt-&gt;verify_hash;</span><br><span> </span><br><span>         while (curre=
nt_hash)</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2152?usp=3Demail">change 2152</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2152?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: Ibc9eb15714f14a9f49366fc8407=
2087fc3f013c9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 215=
2 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2E=
me&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Gert Doering &lt;gert=
@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></=
html>
--vPGkK5jeFmA=--


--===============5389301284611166271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5389301284611166271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5389301284611166271==--

