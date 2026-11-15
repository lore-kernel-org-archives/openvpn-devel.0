Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D58606A31D
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IOeTGJ3T;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NzEamj3p;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BOntkJTi;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HoYxFnfI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=k0eN5rIpk27eOk/On+dxE6VNVoSRde1ULrjxY1VTn8E=; b=IOeTGJ3TSugKCsRA5HgoJ4BqKe
	jC9q7HKVzXMnoYgjX6VQcB6GvhUObHd7YRAB1FniizSNEZogLUfIhdhxDh2ZZ6La+PQbLuLLyaC9Z
	RO9U/VxTYKJhJKp/E5THBVuw9ACcQBohArWDrT0WxTSUAz61MiYSW/BDd8CzPBWlEIQU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSaZk-000000004jP-3l35;
	Sun, 15 Nov 2026 13:47:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSaZi-000000004jI-3IDU
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 13:47:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=laM4lk4HNaYoIrTspoEURs247FLNoggOCxPRfZAOs4E=; b=NzEamj3pZZRQgFeWe+f4ptKpT1
 QucK7SCxWJV9diSxUIJ2GsYOmeqhE5sTs13CCU420brl0kgUj3Q48b/MsiLrnBfUpixogag8Z3r1W
 WERwmVzMcuKhtZo+03lDaMNkNbgJDTYG5FlmYkelbcQyDBMTcPRXJe57x8mHN8Gq1Xqg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=laM4lk4HNaYoIrTspoEURs247FLNoggOCxPRfZAOs4E=; b=BOntkJTi0dpRz4jaypBgNHF8KB
 g/ix4lnecvdQVTMFHkGxJYWs9+r5A1LjiCSOzI0DB4FQt7T+FX8U3OGBxwryHzBblkoYJIWQpklCG
 mG6BncjWv+5nA10PJDFazKH6L2VYjODJ1fky8r/op1/M5pPoodFMX5/OQ1o4itr1VQm8=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSaZh-000000001H3-2hIV for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 13:47:18 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb64c99d2fso11794625e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 05:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794750431; x=1795355231; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=laM4lk4HNaYoIrTspoEURs247FLNoggOCxPRfZAOs4E=;
 b=HoYxFnfI88bsL2twmrngRp4Hp5NWfn6W4bd+kmk+Yb54oG//7eY6Q7orEu+Y4xtO/7
 0l4QHJxVFJb4EMMLocT5YlGX2mG70AFI9CdFgCOMzYheYzDJ0pPtalrRRPdrhoWaajyD
 IvFgPJk6KzoAU4VMNzPwhre3jR1GAE7m+C+RrM05X+uYfB/wHEdQim38/5gmuT72eQP7
 iekNZouE/vX+9ukUolsroDqNaISQjS2OJdPmz5ihAClteqe/NVoKUVZmLF/ZUh4TJZW9
 L/g6wGtQIML2KV9q3gpsn0aOfWKWUXYDl7Y6IRAd+LaxFxoKNF0fCluuKGkwug6OKpRt
 l77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794750431; x=1795355231;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=laM4lk4HNaYoIrTspoEURs247FLNoggOCxPRfZAOs4E=;
 b=Wx45gLRZ/dbzZYXCeRQm4DYRJ5Bz1UODthHG2DEWiDwJEUa69I8jjqE9iEFeQgmrwH
 ZN5j7dk/yMh0piutgEirXU5KXEYtBQmHjYnf70l9NCaOU8Hf7Vitty9zkZsNv1UKTbCO
 Vvqxd8cJW2Vf32jKcHGv1ZPl29F/kRPDX67m04mHh+Y7L1lnBg5uPE8IWkv8odnCpOHP
 RgvKqc7rM0cpAS2v9lf4shCYSySTIVtbEbR+CCIwaB82+L+HLK4+/1hOktQvTllAr7c9
 i6ieqWP8qUUUGrgtRWTHRK5ys6nJwuHO775/R0nnEvOzcw65XHezB99EeFO9DFeVfkob
 smqw==
X-Gm-Message-State: APuU4Z9CPFBAur/5tDBeCIzLTrD9jq8TGOFxQQcNQg/r5Gop82S2n5nR
 cxVrjrevHbYA1JjLFxxfbsqbYxhduPQH4Uidb/CEhRwTy18ywghBaOIksQQ1Sl9ukUrX+eVM4a9
 XJL4Fl0GdmRSBUryDXLkYkuYeA7TLzTrFOtyDQyyr86+wGE39zeRSblycDU+TvugzGE5i
X-Gm-Gg: AYBFou2mlgj18ipcPSRvzsqi9jVxPA+kpeio23w/k/PvWpp3poepnTOJq/vOYVDv6tv
 EBZ42iRGJgIX5J+h1tH40SV/wLiwQUicKdfL0LFYfVv1SwCTXsR1PkQUrF+xpN75OptmrJYgVQX
 BCUm/pzXudiy13ZZntWDmS3im+I0I1GnJmhyqyqYVwb+NhstgNtwbgIe4ztDJq8qmelCkAI8QnY
 OvigKkV5khtv9+ccS1Tczc8hB4eDcpV5/0fvXkgeDPo2gsyJR3FDe0yqfatFqOoVyTa0TCdyqmZ
 /KyHqO9EURMKJ+9u2R5UyxH/Wz2mrvdxuKl/AG1QTXmc21jRpOUbLib0UAfEhR+QQBanq60m23N
 eE+lSS1yI8CWvDwsWFWtP2HSx3o3M3GxDigupsv0gqvkNBsJKwF1WZt8WHPkrrhZNlFR+gArVhc
 Gl+3v79R4z1e6LzIxQZKWFIdXXFLo4nnI3j/rK2ozU9+O2oD6RZiuQRu1lJiNLH1MNVe2HO1pQz
 8/2G5Qgm0jgj/WeuiuStMzG2Yx7vgZFRGZa94Q7HjkaGnCnTEyi/FTNDQfPzah1Tw67DcKTDIxU
 qBOy34EBQ99H7+Q8FjoX6FfI1h9hSyMrGjGJuSNLGw28T+SGLtOpmN0Y0WO55dksRlSqf2rdQRV
 mtjZL5eUwY7v06urJbP8HaNmRaQyMO13nf/ZloWnnF75UYkLSU5eXxGhlXQfRCOCED965oOxS3p
 zQ8nbxfvxkOM5h46g=
X-Received: by 2002:a05:600c:4e02:b0:4bb:6994:abf0 with SMTP id
 5b1f17b1804b1-4bb6994b88dmr47236345e9.23.1794750430809; 
 Sun, 15 Nov 2026 05:47:10 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb6caae30csm37847115e9.2.2026.11.15.05.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 05:47:10 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 13:47:09 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I387f652ecba92283a272610ff0780273c4902996
X-Gerrit-Change-Number: 2183
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2183?usp=email>
X-Gerrit-Commit: 09eb959c29b4cd3efc8b565529c965895fcb14cd
In-Reply-To: <gerrit.1794571077000.I387f652ecba92283a272610ff0780273c4902996@gerrit.openvpn.net>
References: <gerrit.1794571077000.I387f652ecba92283a272610ff0780273c4902996@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NTcxMDc3MDAwLkkzODdmNjUyZWNiYTkyMjgzYTI3MjYxMGZmMDc4MDI3M2M0OTAyOTk2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <335cb35c50b6919160027721aae56d1d93197065-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSaZh-000000001H3-2hIV
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_openssl: free
 what PKCS12_parse() returns
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
Content-Type: multipart/mixed; boundary="===============7090125807151105864=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7090125807151105864==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6ScxCt8+7Fg="; charset=UTF-8

--6ScxCt8+7Fg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2183?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: ssl_openssl: free wh=
at PKCS12_parse() returns
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

ssl_openssl: free what PKCS12_parse() returns

tls_ctx_load_p=
kcs12() never released its references to the
certificate, key and CA stack,=
 leaking them on every SSL context
setup=2E The context takes its own refer=
ences, except for extra chain
certificates, which it takes over=2E

Change-=
Id: I387f652ecba92283a272610ff0780273c4902996
Signed-off-by: Razvan Cojocar=
u <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2183
Message-Id=
: <20261113161309=2E24472-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Emai=
l-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41268=2Ehtml
Sig=
ned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_op=
enssl=2Ec
1 file changed, 5 insertions(+), 0 deletions(-)


  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/2183/2

diff --git a=
/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 035cfb8=2E=
=2Ee190935 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_o=
penssl=2Ec
@@ -1025,6 +1025,7 @@
                 }
             }
        =
 }
+        sk_X509_pop_free(ca, X509_free);
     }
     else
     {
@@ -10=
45,7 +1046,11 @@
                 }
             }
         }
+        /* t=
he certs now belong to ctx */
+        sk_X509_free(ca);
     }
+    X509_f=
ree(cert);
+    EVP_PKEY_free(pkey);
     return 0;
 }
 

-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2183?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I387f652ecba92283a272610ff0780273=
c4902996
Gerrit-Change-Number: 2183
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--6ScxCt8+7Fg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2183?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">ssl_openssl: free what PKCS12_parse() returns<br><br>tls_ctx_load_pkcs1=
2() never released its references to the<br>certificate, key and CA stack, =
leaking them on every SSL context<br>setup=2E The context takes its own ref=
erences, except for extra chain<br>certificates, which it takes over=2E<br>=
<br>Change-Id: I387f652ecba92283a272610ff0780273c4902996<br>Signed-off-by: =
Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2183<br>Message-Id: &lt;20261113161309=2E24472-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg41268=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl_openssl=2Ec<br>1=
 file changed, 5 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/2183/2</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=
=2Ec</span><br><span>index 035cfb8=2E=2Ee190935 100644</span><br><span>--- =
a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=
=2Ec</span><br><span>@@ -1025,6 +1025,7 @@</span><br><span>                =
 }</span><br><span>             }</span><br><span>         }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        sk_X509_pop_free(ca, X509_=
free);</span><br><span>     }</span><br><span>     else</span><br><span>   =
  {</span><br><span>@@ -1045,7 +1046,11 @@</span><br><span>                =
 }</span><br><span>             }</span><br><span>         }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* the certs now belong to=
 ctx */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sk_X=
509_free(ca);</span><br><span>     }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    X509_free(cert);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    EVP_PKEY_free(pkey);</span><br><span>     return 0;</=
span><br><span> }</span><br></pre><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2183?usp=3Demail">change 2183</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2183?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I387f652ecba9=
2283a272610ff0780273c4902996 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2183 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--6ScxCt8+7Fg=--


--===============7090125807151105864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7090125807151105864==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7090125807151105864==--

