Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523B2606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=N9wK6iM8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AK6dhOWW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FKFqcYWn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=B3OzD6ao
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=RIV7Mofxdyvg+TvSVUPbfiswr3EqY6uiTNEqXpdpHss=; b=N9wK6iM8F/v7tnUGyzoYxdUjIY
	ZfSmir4g9PLKdkYn+WUcPB+qpLlVtzCBvSmvl6VKCuP7fTDWLYHpdbFEAcD+jH699mZdVEEhDfW4n
	AfFVJhGrNFcMMjCTqyxSzxLOLDnnRAfrRHTQawkhyjvGn35K3VYLM4aCemFXOpO1PZtI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLRR9-000000002TZ-3wNL;
	Mon, 26 Oct 2026 20:36:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLRR9-000000002TR-2RtI
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 20:36:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a47RxAWMkXQf35f4XNY/LO2mZA57TJ203I1//ZotTiE=; b=AK6dhOWWMB4kMFlxSA+WgTPbBm
 BxCs1pLHRV0aMGI0WJO6IxTBnpB2Et/Z991FMcmrxqvfeARxtid1F39YI7kQ91epyOFav9YcpJ19k
 Shm7ITJm8QpBEHlH8NEDfkV2qFkuu8tys0vJidglHUVrAIrcZRzFQ5fdrCoxvLLbD4QY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a47RxAWMkXQf35f4XNY/LO2mZA57TJ203I1//ZotTiE=; b=FKFqcYWnfrYMC/e7MIW8C5Kz8k
 jY5qT2gTPovXT30X8ng5QDxDtksJm5TwxvsPxHvx1qksOk1J0Cz8H4aUMIBsxMtF/0CrQ1vYv+N8u
 e8LgHgscUE5PrBDBC1OYoXfJbfn+g1/9+eEKpft1ur+mfGBbsll/M7GtHhf7+iEtF1kQ=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLRR8-000000003hb-3erU for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 20:36:55 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so26245405e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 13:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793047008; x=1793651808; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a47RxAWMkXQf35f4XNY/LO2mZA57TJ203I1//ZotTiE=;
 b=B3OzD6aoDM2Bxy2VS8r/S0UoEXoGWOKRpPYUMa4R11ynRZKVGgBMy8x3uO7rF51G73
 TMwgEp+EFi8df+9Vw2XUpnLkCi/USRfCcoEzo5dzxu6VM6uYhWfqQA6BcuRyV2CSPyxY
 BOFzBei50GGSIep+z7FrsXwR4sVSz81N4ZMCqFA7Pilqmv/EL44rKtr43+XTImZogUPa
 xLTtOba96UueNbvodybxbvlEO7goftHEyHhPA53Hn9zL3nUQ3Nh7Tj5PaMqwjEt5QF7q
 X/p1aJlRh5wf9shs2zXMKhlsBHbpHfTNOk7HtoWRnpi91/Mu51Uo3GIuy/S29zEJjVO7
 rDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793047008; x=1793651808;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a47RxAWMkXQf35f4XNY/LO2mZA57TJ203I1//ZotTiE=;
 b=aKTmZqnPcQbeuJopK72GTUFJ8kK+piA7/dANo+gK58NIeLQlXZZbwLBLtp5LdalIG6
 YZKVqhZPJ0C04wrZ8mlYdW6PU+J29xIWV6+GtAtdXPtabu5fk7XuNIZP1mdseScdzF/Q
 vyFlXRCHyBij4AuudU1S/mIZb3XB/lo2mUSiIKRN84D9QAio3AU5yZw9FVeWPPraSslx
 TYQGcUikIT+QssGVToASHuHMzmcVX6QgEeWw2gMr28/Ohf2wKZ6gOz0SXV4IJwk141Bg
 XlrW6aYsHG7hEiuWhaWiiWz4RVkbal7Admyb3SiavDZ1I97vpZrTIKQFvkngyjFrwy2c
 lnXQ==
X-Gm-Message-State: AFq9FYIs8MZvPLcuJD+Hi5CNIPLYPa0Xv6KvRRnpvhgwGfIP7IcTvU1B
 ZG8ArWFD1D7ZQez/cm0/V0ENO4pxNC4i4gvzkMA++EJqmfHLE2nDm/llXBPYgDrr35aTvbGr4GX
 3CBXZu+CsIjbz0SvBNvq+e1o14MjfpsX1OBDZ8YalulPMDF4klrMgC9/3TrcgiFP1dZ/lSZ9qV6
 frzsyHDg==
X-Gm-Gg: AYBFou3vdLWlPAQL7FYoRe/0DYeHYEqlP6KOFaQedq6uajOk4SbSeF85VmJPAtgDO0g
 kX8raFGgqBTwuWc9ZyImFRnBCu6miYjXPN9EZ17jw4F1NAPWfUk96JNRqmxcHm5A/fTykUyi6d4
 3gCSZ/DTPVZ4DjqdVUooghXGLQNasx4VXGAD2qhBDXkNclCqGMPFM+kHAiZHBXPyjXUpxwrcLb5
 G3SUlKnnLMOFvi2eLE8/W/+jWnIBeBx1NBQQfYqGZ9YCg4oXH1rlV1jaRvCua/DjZDaFt2b/jTw
 JVxLmkLXaysTdc+45GbJvGyxMVTtvDxbsSyKHWL/UDMtWkmmlmSrgzo2/zXoQD/gvgaRbT58B04
 CwdzBUr0sW5HfK7hRIi9R9L29WsZf4lyVjoNabpX50H1Akdl+PTRfKeM9gbRK5EbQ3Lz7dH/q1v
 8eKZ7FkanhE2a7/iYl+1xojKWf6tSOQ2JsJhO9iEKIht0YRrLUFDLMroxIAnPT6r7XD4zayygXl
 BRUeqeM/QzwkgJyEGcqr9qTOCKY2B/3rg2Neua8psiWe9qh3vJ3enp2I/yvocyUeD8Cwrk48nhD
 fUz6A89UoF8j+GIQ9MsfLtOoyP1SwVPHLG1i9QvvncmtuLRxsNTRIJ/tmeqRpc8w4z9u+/XzPE1
 A+UyMszS3MRcgSqybeHvDDCyyNPs9hXlCy3TTxKHvdHg=
X-Received: by 2002:a05:600c:8b41:b0:4a7:7d22:c50c with SMTP id
 5b1f17b1804b1-4a77d22c51amr30672055e9.2.1793047008121; 
 Mon, 26 Oct 2026 13:36:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm18789675f8f.25.2026.10.26.13.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 13:36:47 -0700 (PDT)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 20:36:47 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib40b439ad84a08fe6d5d4407da18ed78151327e7
X-Gerrit-Change-Number: 2039
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2039?usp=email>
X-Gerrit-Commit: 80382792dcd05cc4467d4cc287bf6fc8d8a00817
References: <gerrit.1793047006000.Ib40b439ad84a08fe6d5d4407da18ed78151327e7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQ3MDA2MDAwLkliNDBiNDM5YWQ4NGEwOGZlNmQ1ZDQ0MDdkYTE4ZWQ3ODE1MTMyN2U3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dc6aba53f9f416db0c34dee815fdb9897326387d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLRR8-000000003hb-3erU
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: plugin: detect too
 long plugin paths on Windows
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7304550586380747414=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7304550586380747414==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RR+LQKurC9E="; charset=UTF-8

--RR+LQKurC9E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2039?usp=3Demail

to review the following change=2E
=


Change subject: plugin: detect too long plugin paths on Windows
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

plugin: detect too lon=
g plugin paths on Windows

GetFullPathNameW() returns the required buffer s=
ize if the normalized
path doesn't fit=2E This case is currently not checke=
d, so a normalized
path longer than MAX_PATH left the buffer empty and the =
plugin was
then rejected with the misleading message that it is not located=
 in
a trusted directory=2E

Treat a return value that does not fit into the=
 buffer as failure, so
that the error says that the path could not be norma=
lized=2E Since
GetFullPathNameW() sets no error code, set ERROR_FILENAME_EX=
CED_RANGE
manually before logging=2E

Change-Id: Ib40b439ad84a08fe6d5d4407d=
a18ed78151327e7
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
--=
-
M src/openvpn/plugin=2Ec
1 file changed, 7 insertions(+), 1 deletion(-)

=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/39/203=
9/1

diff --git a/src/openvpn/plugin=2Ec b/src/openvpn/plugin=2Ec
index a94=
f07b=2E=2E9826510 100644
--- a/src/openvpn/plugin=2Ec
+++ b/src/openvpn/plu=
gin=2Ec
@@ -284,8 +284,14 @@
     WCHAR *wpath =3D wide_string(p->so_pathna=
me, &gc);
     WCHAR normalized_plugin_path[MAX_PATH] =3D { 0 };
     /* No=
rmalize the plugin path, converting any relative paths to absolute paths=2E=
 */
-    if (!GetFullPathNameW(wpath, MAX_PATH, normalized_plugin_path, NUL=
L))
+    DWORD len =3D GetFullPathNameW(wpath, _countof(normalized_plugin_p=
ath), normalized_plugin_path, NULL);
+    if (len =3D=3D 0 || len >=3D _cou=
ntof(normalized_plugin_path))
     {
+        /* GetFullPathNameW() sets no=
 error code if the buffer is too small */
+        if (len !=3D 0)
+       =
 {
+            SetLastError(ERROR_FILENAME_EXCED_RANGE);
+        }
      =
   msg(M_ERR, "PLUGIN_INIT: could not load plugin DLL: %ls=2E Failed to nor=
malize plugin path=2E",
             wpath);
     }

-- 
To view, visit htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2039?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: Ib40b439ad84a08fe6d5d4407da18ed78151327e=
7
Gerrit-Change-Number: 2039
Gerrit-PatchSet: 1
Gerrit-Owner: Heiko Hund <h=
eiko@openvpn=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--RR+LQKurC9E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2039?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">plugin: detect too long plugin paths on Windows<br><br>GetFullPat=
hNameW() returns the required buffer size if the normalized<br>path doesn&#=
39;t fit=2E This case is currently not checked, so a normalized<br>path lon=
ger than MAX_PATH left the buffer empty and the plugin was<br>then rejected=
 with the misleading message that it is not located in<br>a trusted directo=
ry=2E<br><br>Treat a return value that does not fit into the buffer as fail=
ure, so<br>that the error says that the path could not be normalized=2E Sin=
ce<br>GetFullPathNameW() sets no error code, set ERROR_FILENAME_EXCED_RANGE=
<br>manually before logging=2E<br><br>Change-Id: Ib40b439ad84a08fe6d5d4407d=
a18ed78151327e7<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2En=
et&gt;<br>---<br>M src/openvpn/plugin=2Ec<br>1 file changed, 7 insertions(+=
), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/39/2039/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/plugin=2Ec b/src/openvpn/plugin=2Ec</span><br><span>index a94f07b=2E=2E98=
26510 100644</span><br><span>--- a/src/openvpn/plugin=2Ec</span><br><span>+=
++ b/src/openvpn/plugin=2Ec</span><br><span>@@ -284,8 +284,14 @@</span><br>=
<span>     WCHAR *wpath =3D wide_string(p-&gt;so_pathname, &amp;gc);</span>=
<br><span>     WCHAR normalized_plugin_path[MAX_PATH] =3D { 0 };</span><br>=
<span>     /* Normalize the plugin path, converting any relative paths to a=
bsolute paths=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (!GetFullPathNameW(wpath, MAX_PATH, normalized_plugin_path, NULL))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD len =3D GetFu=
llPathNameW(wpath, _countof(normalized_plugin_path), normalized_plugin_path=
, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (len=
 =3D=3D 0 || len &gt;=3D _countof(normalized_plugin_path))</span><br><span>=
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Ge=
tFullPathNameW() sets no error code if the buffer is too small */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (len !=3D 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            SetLastError(ERROR_FILE=
NAME_EXCED_RANGE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span>         msg(M_ERR, &quot;PLUGIN_INIT: could not l=
oad plugin DLL: %ls=2E Failed to normalize plugin path=2E&quot;,</span><br>=
<span>             wpath);</span><br><span>     }</span><br></pre><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2039?usp=3De=
mail">change 2039</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2039?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: Ib40b439ad84a08fe6d5d4407da18ed78151327e7 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2039 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--RR+LQKurC9E=--


--===============7304550586380747414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7304550586380747414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7304550586380747414==--

