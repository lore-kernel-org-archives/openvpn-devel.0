Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4B606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IMGKIy5C;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dI7YU2S8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=h7DE65NC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YgJvqmDN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8318tGJRvHdMiMoHZY6GCLoRyPgDfE5NEFnMyUNgdP8=; b=IMGKIy5C1yAOhdslqi4hfcq7jm
	mbmH2uidl83XGSD1eICFaGF60UNGQzM1KuTlIJ1o3f1hHf4Lmx5VHbd/tob+nApNEhJ1G2SyhquTK
	MigTB/4bdYxigAEQ+l/3Kknnpd8YYqW5ml/RMqIZ0LwKTRpJ9TQBdyADU7OeVwX2GM9Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNCKT-000000007Ns-1cpw;
	Sat, 31 Oct 2026 16:53:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNCKS-000000007Nm-2CBK
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 16:53:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QJQm8p3MHxqyAoMomVVqVqxJj58ujvm5x2KNEROzw+U=; b=dI7YU2S8tCghUNIJKaK9R98oZw
 NecuIrZarGiA6F7UqQfa/ou9SEkDZPy4GClVqIF5IMH3Vnepe0t6rWiBQIgAhcprqbuZkPEBYqP2E
 ZQfAjFVuNVX7/a7zwQxQdJBfVyUMKyVDsrhNtmc0wOBiaJBsv6v3Oz2yLggj300HnhBY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QJQm8p3MHxqyAoMomVVqVqxJj58ujvm5x2KNEROzw+U=; b=h7DE65NC8ToelwmXBhRA3kTXvw
 IvzOOlukw8pUqF4xCxgXU2r7QaiF+9F3s+G/EnYLkR/3OA7Q4FQYdRLi8FlDgeOc5E/o5MxcZnNmU
 i5Oy9dntG0KxQxNX1ylJlGzyLrAo3kJb0kaqHYXE0jw83jRC9I1HXV6TCm2kykOp99do=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNCKR-000000007GI-0kHU for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 16:53:16 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so16494095e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793465589; x=1794070389; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QJQm8p3MHxqyAoMomVVqVqxJj58ujvm5x2KNEROzw+U=;
 b=YgJvqmDNqg0vrSVrZhwBOTxJKSbG/MOxl6hz0a4pPNHQUQBavzRX4C3845XIhWNgf0
 qJOpw+a3N/AXHfCz6/H6/8khqizTiir1q4oM2ZORoztOwA7G+52l/slDVRoB1SMT2jCq
 dti4/7uphS7yRttyL5U5Ld53idYIyj+4dC2qGY15/RIu/fZGwCWH8XKVxIp1smcrRbaP
 wBPDUhCxAYdre69YMPH7KqA5QedDIc/YD/p2yselzyCE4g/VU1UheyCW4u0x/9XZEzP7
 S24FVnJWeDCq2Ng/WWtBR46tJI0aEPfGSnCjnkoEbi6RhrLdw6eCP/FhJYzB/UTB3/mA
 hnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793465589; x=1794070389;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QJQm8p3MHxqyAoMomVVqVqxJj58ujvm5x2KNEROzw+U=;
 b=nv9tD0jV5zaFzkH4zzQqlX2zkoxXgcbtpiwJRA3xT+S+mRcRBZOR+bF10By3ELcPdb
 YbL8iyyI8iuqPBhPyk0mhxl1S5jw5VVcIwCEnGTt91h/fZ3lmSLQXmJ8odBXmqPIjSEP
 dJc6wDU3t3/H8n9ZNQpDUSKF3B8PapyzKYxG1kYVCe8dD6HOx2qGc7U2MeGIZ4964/4S
 b4mb3XB9fYymAOaqiT2CFyv6gFtOkYFS+xPwxIXodVx2BGpZhgz80D8TMpjPkDWDqDrX
 t9FqGNV4VGKZfxZ8ebPUBIkr2258VSwyRLcH85sDYsjICVkZRZv0Uy8268N1aXE9yYpn
 VVrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxP4S7SUzCptsn9qVtCsl5bExbaNPyVfvuZq+OpTuQxczhG3X7/yPYBT+GAqZQiA6fIpwqXyv3ZlPSPmE5g@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJJHn58SzztAkm0b8+HGmx86w+IIBfg6CvFXSQje+QeXTbwcPSt
 wernNc/FKkmqITVykC717T26ISllz921Gw0rz33BzrsWKZJ1ZEt0b1GEkaxzV9SHVoURqVaBx4V
 ELfetD/Nsx7IFpS8TyGUnZsZ3cFKmnEXSXT7Unb6Kafk8eCRtX5LSSfTNWESDuMb0C9AMPY1I/k
 8pCJ6sng==
X-Gm-Gg: AYBFou2aByfyc+fC3OflmM7IhdGAd58M/hck1zTnjPz+aTRyCW5HPq1SjgttPOHqlEX
 VNlo2M3868dP+HF2BVuiArh0e0LEy0dQf4yObZmiS1KBP3oFhEs1o0BXqakNeYPvKStIez9NZbu
 LFvw5d8oO/+b1k6TpZ7smAV0QI6mAT8k3TlVD55BQBWfOcdVeb4SCr1m+cCVh7o5snnLAdNCckl
 3EUvB6qGVBw2eq01e7QUss68N6r9jtGA6OtZi4mvShb3UEqUEzMuZGcerMgQ1ipXpLy2nrvxHsw
 qwJjP6S80jz1oEgfvryKAuNyHlMx9xTUBowen3pGqnqVkvqYq4mQ+7DD8VyJdMLElcfcXMsqapI
 NHQ1/Qqu98fTh/i7lAJ5xawHs4jpmU/Nahw9ihWTmAq98tlP13omhJmGrUmeqR8CKmSe6IpI+u8
 XTFv4JYRTO3F+TvTHeEkXQeTIFdW3uXKJvhaUeLikbUOFYkRRU4G9K2M+86QmWwOAL3gUwgkFam
 t0UcWWddHzdgwLjk9OSESYZTJrpTRGuLnKhQWiF6HXKWjOAjk+DrpXVRenY7XgBZfvIW1qDCugq
 xZzC56X/yWOk9T7txkNfjuXIE/IpFn5wFYZn+PuTRRO/s7t49VW6RkHnLnIkiLrb6f/3++G5dYh
 rAdMbOibVMtnm3sHKuCiU8voQHy1s/stBw72SQQYIyvx5D1PhOkRYZHgle4WyX2zb+4ZPH4Igpq
 hD/6Hr2+08aCbhYQT3
X-Received: by 2002:a05:600c:1f93:b0:4a0:1fb9:2f51 with SMTP id
 5b1f17b1804b1-4ac182dbc34mr123326525e9.14.1793465588323; 
 Sat, 31 Oct 2026 09:53:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf5b27e46sm218735835e9.3.2026.10.31.09.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:53:07 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 16:53:06 +0000
To: Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I88b17af9988aa640ca04c765b6e79dd1c8f822c7
X-Gerrit-Change-Number: 1998
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1998?usp=email>
X-Gerrit-Commit: ededb5b3b364d350fbe8fbe023eaf33d42ca4c29
X-Gerrit-Comment-Date: Sat, 31 Oct 2026 16:53:06 +0000
In-Reply-To: <gerrit.1792059610000.I88b17af9988aa640ca04c765b6e79dd1c8f822c7@gerrit.openvpn.net>
References: <gerrit.1792059610000.I88b17af9988aa640ca04c765b6e79dd1c8f822c7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMDU5NjEwMDAwLkk4OGIxN2FmOTk4OGFhNjQwY2EwNGM3NjViNmU3OWRkMWM4ZjgyMmM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3eae22848bf6d2ed7ad909bc7fcf583f167cf636-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNCKR-000000007GI-0kHU
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: Check for
 null-bytes in certificate subjects
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6800335627426742967=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6800335627426742967==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ba8ZMV+Ffqw="; charset=UTF-8

--Ba8ZMV+Ffqw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Steffan Karger=2E

Gert=
 Doering has posted comments on this change by Steffan Karger=2E ( https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail )

Change subject: Chec=
k for null-bytes in certificate subjects
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(1 comment)

Patc=
hset:

PS2: 
From what I'm reading in the build failure logs, this fails ma=
cOS builds due to OpenSSL 4=2E0

```
essl_openssl=2Ec:638:11: error: 'X509_=
cmp_time' is deprecated [-Werror,-Wdeprecated-declarations]
e  638 |     re=
t =3D X509_cmp_time(X509_get0_notBefore(cert), NULL);
e      |           ^
=
essl_openssl=2Ec:1102:35: error: 'X509_STORE_get0_objects' is deprecated [-=
Werror,-Wdeprecated-declarations]
e 1102 |     STACK_OF(X509_OBJECT) *objs =
=3D X509_STORE_get0_objects(store);
e      |                               =
    ^
essl_openssl=2Ec:1627:24: error: assigning to 'X509_NAME *' (aka 'str=
uct X509_name_st *') from 'const X509_NAME *' (aka 'const struct X509_name_=
st *') discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-q=
ualifiers]
e 1627 |                     xn =3D X509_get_subject_name(info->=
x509);
e      |                        ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=
```

(more lines to the same effect)=2E  Not sure if this was introduced by=
 the patch, or is just that we didn't add anything for 2=2E6 in a while and=
 macOS was upgraded to 4 behind our backs=2E

It also fails the "mbedtls 4 =
only" buildbots, which is a general 2=2E6 problem and not a problem of this=
 patch=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1998?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comm=
ent
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Change-Id: =
I88b17af9988aa640ca04c765b6e79dd1c8f822c7
Gerrit-Change-Number: 1998
Gerrit=
-PatchSet: 2
Gerrit-Owner: Steffan Karger <steffan@karger=2Eme>
Gerrit-Revi=
ewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Steffan Karger <steffan@karger=2Eme=
>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Commen=
t-Date: Sat, 31 Oct 2026 16:53:06 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: Yes

--Ba8ZMV+Ffqw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Steffan Karger=2E </p>
<p>Gert Doering =
has posted comments on this change by Steffan Karger=2E</p><p>Patch set 2:<=
span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; pad=
ding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail">View Chang=
e</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1998?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">From what I&#39=
;m reading in the build failure logs, this fails macOS builds due to OpenSS=
L 4=2E0</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">```<br>essl_openssl=2Ec:638:11: error: &#39;X509_cmp_time&#39; =
is deprecated [-Werror,-Wdeprecated-declarations]<br>e  638 |     ret =3D X=
509_cmp_time(X509_get0_notBefore(cert), NULL);<br>e      |           ^<br>e=
ssl_openssl=2Ec:1102:35: error: &#39;X509_STORE_get0_objects&#39; is deprec=
ated [-Werror,-Wdeprecated-declarations]<br>e 1102 |     STACK_OF(X509_OBJE=
CT) *objs =3D X509_STORE_get0_objects(store);<br>e      |                  =
                 ^<br>essl_openssl=2Ec:1627:24: error: assigning to &#39;X5=
09_NAME *&#39; (aka &#39;struct X509_name_st *&#39;) from &#39;const X509_N=
AME *&#39; (aka &#39;const struct X509_name_st *&#39;) discards qualifiers =
[-Werror,-Wincompatible-pointer-types-discards-qualifiers]<br>e 1627 |     =
                xn =3D X509_get_subject_name(info-&gt;x509);<br>e      |   =
                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>```</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">(more l=
ines to the same effect)=2E  Not sure if this was introduced by the patch, =
or is just that we didn&#39;t add anything for 2=2E6 in a while and macOS w=
as upgraded to 4 behind our backs=2E</p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">It also fails the &quot;mbedtls 4 =
only&quot; buildbots, which is a general 2=2E6 problem and not a problem of=
 this patch=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail">change 1998</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1998?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
release/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I88b17a=
f9988aa640ca04c765b6e79dd1c8f822c7 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1998 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;ste=
ffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 31 Oct 202=
6 16:53:06 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Ye=
s </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body=
></html>
--Ba8ZMV+Ffqw=--


--===============6800335627426742967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6800335627426742967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6800335627426742967==--

