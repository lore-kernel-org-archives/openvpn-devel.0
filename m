Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30323606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=h4odq7vU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MqRxf8HK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZGh1Rrm7;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hCYjAHP9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OMOdi1YS3c+5DI7n1iwMohBXquuAae5rhYTHbJ0CbpQ=; b=h4odq7vUXz+ZQkGW5Nz9y8mRw7
	PeyV4tn9mekjqXetOHvAesN8bjeBkrdheVsJ5cPQnvu+VvnIE4KS3UUM4sVYftQufJ9AmtTXzp7YQ
	/3Iyk1g/6uGCeA2Zxr33h4Z1E9G2n7KwhXLzv6u/hYRdddaP79WraNl96RHCI2brlXf0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLIzP-000000002Ya-11es;
	Mon, 26 Oct 2026 11:35:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLIzO-000000002YU-3KnP
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 11:35:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jhkl8b2JAWH1fCHGeGKkARpPEPlrUJ7SWCgFwn1OXrA=; b=MqRxf8HK3on/ctDU9rmxtAyBhZ
 N9SqGn7s5UM5Gf8dGK1+Mu4Z//gr8xZASzGtP01FVyKLrrFgE3cGUVnxMVXsDq+xuqgHqI/jdITrx
 JE6WTaV8uteKltNJEF+XLXYsTxL4pl0X2BqdGZcXAkHat2kCcMwU5k+JwbtzQq9X2PLQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jhkl8b2JAWH1fCHGeGKkARpPEPlrUJ7SWCgFwn1OXrA=; b=ZGh1Rrm7vfS+QvRwxZxdejZ9vB
 gFtOeEoGDUFE+W/h/E/abt9qGom6KWcB5sbM4RiRuw9PskBn9kqsbE95afHz0didDUKRY1ivKIz4+
 Kr7+RutlJA2+rg8aRMqcwED50mji23eDklQbnuRMfuEAYM1aWKGBBSrfP6oLiFK5O0dc=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLIzN-000000007bK-3FjK for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 11:35:42 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so8433335e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 04:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793014535; x=1793619335; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Jhkl8b2JAWH1fCHGeGKkARpPEPlrUJ7SWCgFwn1OXrA=;
 b=hCYjAHP9yAExr8pQfQAj1Zh7cbbBVK0cQTrWDWvz7YDaVv0kxLNSNQpTJDivTS+tCu
 5FVfCDd5LfBqqC+LlASjWvIToiB19Y6xdrrWGe1/XLdQG1Xy0Sx2qJwuYZS4htLP0VkN
 RLArHxIa3bz0wj2Gq2fqktWQD32P4BclhjWTZ1tPucwNX582UyZxhb4lclwJaeSsynHA
 LQVMi21i3j2+ys03KEWj5rj7vWGfRLu5RLJHnn4f1SC6NfpcBaooI9lLC/93pQXiE/sb
 34h/GKd/A4UKv+9zpqYB49kwihBHkTZg1FG0GKaUuLRx/Y0d5KtMpKPMnA3WYorxDQ9Q
 +nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793014535; x=1793619335;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Jhkl8b2JAWH1fCHGeGKkARpPEPlrUJ7SWCgFwn1OXrA=;
 b=BA0xchkRCp0KEzH1rP93Z7M9rUqPKEOOuZIBvITsjiQzkvTppKeO2cTBfcvtzggwBB
 w07VplsNOxRpCc+1Tgnu8owPCIjKEqXOxge75dh/kMe+bOVozdMU4tWXakPphKZtzjQf
 kRaucMofSiNnKY1RGqGMDnuWj7TLc6WvHDy2OuOMfBeLR1yduc0o6pd5nwEEHysKbiD/
 tUYHIQhNXN3fdrhMRw4k8lkJVikprrFZAsE/tNetM14vu+BVU8d7ETppkhrKc03tbDD/
 DnSpxddq8pvr+U72gl4qyko+xQroVCencdevKi/zI2yVkN19rz98glxZXuH0yEZziAcy
 0VDQ==
X-Gm-Message-State: AFq9FYLiv35o1UfBzCrebqkALNb9l3rkMlhDrg6cOh8vi62TTW4bkuFz
 PFNfFXm2PzdUn2oxIb2pNj43qqz5zbgh0tdkcXYhMMSkLk1hdKSPTPyGr6H4GT25gxeXK9v3yJp
 oxLlKV/VohDF08xXGMDgvJgKkkJa/3zX57SauONSbCwq0vrk1etnTOHBm9DVQUzqBvo65
X-Gm-Gg: AYBFou2TEXp9nLrS2zkJhGnbsj46B/YRXgE8hH5/0ZI2OR5+0RphtQ0Y7G67t298IAQ
 Bfc9qNMEvv/1akozZaYnl60nAz4gfRs0Csyn0G07BoZv4BWOWA05JzMmx2XyIiTjMTeO9Qdx3r/
 YY9NYHphHYTkEDxu9ZHJOQ5i6+pDAxVP8l96bdr1RLRTTredYYjVNZ0T91RyOkIW1QxuuW7wCRi
 ZE4+1TzfhRpXnbnGt56BffnxWJuHR9757uT+rMZkzA34VChugcxIxLK27oqa4vYPJ44bJ0+gv3c
 RX9Z2CQxXKjsYTI84Fp1oyf5+ivKNYPcQdOO9kmYSUdFG5tZnx2y8BONDjEUj2IEUPIvZEwIOg9
 opT9oKfQH6OJjF2SGmXT5LeuXRk0FHZrWBDm05LZ7SLB4c+Oh9uQ3ZpPZdRrNpe+mXxTthRFJV7
 ow3l+Wdm+pBfFKqwSrkX0oNmK9IR6jY/+fTCYc0nYwqhUoIz8zMlwK0p++FwNCVYnx/o+MI9uhR
 72nzEumyJKnbOdB+6U+Vv6b3KkUgeAStdlFsF/IOE8j6RE8wpGRL84yddlFVk95FyucqODL7buG
 WR/Y4/0cSXaRXG/KCVeRxznLnWzdLp2mKEYqrAGZ/dATa613ZzFCqaJ/pqVwa2Zqkxb92BwHx4y
 BLbApG3pRgptQT8mUFTZhVEN815aSXPOrSRgCAz2Z/w==
X-Received: by 2002:a05:600c:8184:b0:4a1:ac66:6059 with SMTP id
 5b1f17b1804b1-4a35aca6b82mr107872745e9.26.1793014534680; 
 Mon, 26 Oct 2026 04:35:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0bae01sm233477685e9.7.2026.10.26.04.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 04:35:34 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 11:35:32 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id206b12bd67c0b8a014a2c62277b43b18debfd43
X-Gerrit-Change-Number: 2033
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2033?usp=email>
X-Gerrit-Commit: 25ccb3e6bd0949e31d3ed918307d67f381ee300d
In-Reply-To: <gerrit.1793012308000.Id206b12bd67c0b8a014a2c62277b43b18debfd43@gerrit.openvpn.net>
References: <gerrit.1793012308000.Id206b12bd67c0b8a014a2c62277b43b18debfd43@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDEyMzA4MDAwLklkMjA2YjEyYmQ2N2MwYjhhMDE0YTJjNjIyNzdiNDNiMThkZWJmZDQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6017d1ce5b93684e4fdff0b70948b251dddf83de-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLIzN-000000007bK-3FjK
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: run-cppcheck.sh:
 Make CPPCHECK_CHECK_LEVEL=normal the default
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1655401359363160948=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1655401359363160948==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x5g9PjNgRyk="; charset=UTF-8

--x5g9PjNgRyk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld=2E

Hello Arne Schw=
abe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a change=2E Please v=
isit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2033?usp=3Demail

to l=
ook at the new patch set (#2)=2E

The change is no longer submittable: chec=
ks~ChecksSubmitRule is unsatisfied now=2E


Change subject: run-cppcheck=2E=
sh: Make CPPCHECK_CHECK_LEVEL=3Dnormal the default
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

run-cppcheck=2Esh: Make CPPCHECK_CHEC=
K_LEVEL=3Dnormal the default

exhaustive is generally not usable since it r=
uns for hours=2E
So avoid confusion by choosing a sane default=2E

Change-I=
d: Id206b12bd67c0b8a014a2c62277b43b18debfd43
Signed-off-by: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
---
M dev-tools/run-cppcheck=2Esh
1 file chang=
ed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/33/2033/2

diff --git a/dev-tools/run-cppcheck=
=2Esh b/dev-tools/run-cppcheck=2Esh
index a9c4643=2E=2E07c0a6f 100755
--- a=
/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=2Esh
@@ -3,7 +3,7=
 @@
 set -eu
 
 : ${CPPCHECK_VERBOSE:=3Dfalse}
-: ${CPPCHECK_CHECK_LEVEL:=
=3Dexhaustive}
+: ${CPPCHECK_CHECK_LEVEL:=3Dnormal}
 
 if "${CPPCHECK_VERBO=
SE}"; then
     verbosity_arg=3D"-v"

-- 
To view, visit https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2033?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: Id206b12bd67c0b8a014a2c62277b43b18debfd43
Gerrit-Chan=
ge-Number: 2033
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>

--x5g9PjNgRyk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld=2E </p>
<p>Frank Lichtenheld <stron=
g>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2033?usp=3Demail">View Change</a></p><p=
>The change is no longer submittable: checks~ChecksSubmitRule is unsatisfie=
d now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">run-cppcheck=2Esh: Make CPPCHECK_CHECK_LEVEL=3Dno=
rmal the default<br><br>exhaustive is generally not usable since it runs fo=
r hours=2E<br>So avoid confusion by choosing a sane default=2E<br><br>Chang=
e-Id: Id206b12bd67c0b8a014a2c62277b43b18debfd43<br>Signed-off-by: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-tools/run-cppcheck=
=2Esh<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/33/=
2033/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cpp=
check=2Esh</span><br><span>index a9c4643=2E=2E07c0a6f 100755</span><br><spa=
n>--- a/dev-tools/run-cppcheck=2Esh</span><br><span>+++ b/dev-tools/run-cpp=
check=2Esh</span><br><span>@@ -3,7 +3,7 @@</span><br><span> set -eu</span><=
br><span> </span><br><span> : ${CPPCHECK_VERBOSE:=3Dfalse}</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-: ${CPPCHECK_CHECK_LEVEL:=3Dexhaustive=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+: ${CPPCHECK_CHECK=
_LEVEL:=3Dnormal}</span><br><span> </span><br><span> if &quot;${CPPCHECK_VE=
RBOSE}&quot;; then</span><br><span>     verbosity_arg=3D&quot;-v&quot;</spa=
n><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2033?usp=3Demail">change 2033</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2033?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Id206b12bd67c0b8a014a2c62277b43b18d=
ebfd43 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2033 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--x5g9PjNgRyk=--


--===============1655401359363160948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1655401359363160948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1655401359363160948==--

