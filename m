Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2BB606A324
	for <openvpn-devel@archiver.kernel.org>; Sun,  1 Nov 2026 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IoocFwUJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lJtpGZZx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=STEieYnt;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Rk6IJlzL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=13u4FnuW3uF1OL6kurrnvTLEv/RfftfizFOUbaeqLbk=; b=IoocFwUJy1GdG4hWpMDnnI/AWC
	qhhVtgMwjq3DSiIDlVIWZX4r18I93PlioEJCks87/ppKdmVS0PNDc+KXrRfnNN103EaCBMTKXwGTa
	Xz1v3HEbEuE6isBUmol0UNRiDew8GQdewGMi7raEmkTeJ5FFFTrUWB8jNMN3tJfjHw+k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNU2D-00000000618-09KH;
	Sun, 01 Nov 2026 11:47:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNU2A-0000000060z-2mzm
 for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 11:47:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4c+pyScBlTfQzQmKx2Fck6KnEFyt1vZGmx8yy8oVoYw=; b=lJtpGZZx+55DZeg/mNTGBrSO6M
 FyKkn5pApwSkPbLHfBmJBMxGMu8NG1JgwTXDdTpP76OaX+ahMiE511aP0uakGUA2CYn9exX0NgeEn
 PU8L/UOkpDD3zYWK3tngPPEVQ1gFqrpNPI99O4dM4H7xhylt4Yy0r03wMyH0VFcACPUA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4c+pyScBlTfQzQmKx2Fck6KnEFyt1vZGmx8yy8oVoYw=; b=STEieYntxSC6D8QuY314GUbu3m
 Hztun+HTmlEZsnxxB6AKoCFumNYSl6WrNRbilm///9EF7f0k+MyGdnsxU7+oNQlU8sIMw5ZAQbBZO
 crABSBDkuy4R/ENFnerp+IiftFZbu+ZGKsWgDJPPvnrQRnclHepLZEO/S3gpuAH6Y6uY=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNU2A-0000000021s-0A4U for openvpn-devel@lists.sourceforge.net;
 Sun, 01 Nov 2026 11:47:34 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso941090f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 01 Nov 2026 03:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793533647; x=1794138447; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4c+pyScBlTfQzQmKx2Fck6KnEFyt1vZGmx8yy8oVoYw=;
 b=Rk6IJlzL9t2Rnpxbv2cwlMd/Yzwl07tWy4qoJPHJyr0cAUaEtarlDF0Dck88arWBms
 1RpS+o9iKo4kCRu9wCQvOZKAVJ5noIuqQHDICuDNSC58yPcrI6Qf7EueKif6yCMP2V+f
 LnaL1Px+bC8gVou6HjCI6/SgVYXZb1mVn4mtqCUY39arAJNfvKHHgnR5tw7yhNhF9+cw
 VfcfNWgEzv7aE/KBg092AfzAkaHb2p6Hf+2m+dgKqhBMZ8ilQn7qdf2XC3keVkBt0Zhb
 6yq60o1VhLlebeYW1dIMN2hjycFIPRhQZ7eTY3OlgtaZVOOhXti5K0g+aN7/ipYhBuKb
 YiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793533647; x=1794138447;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4c+pyScBlTfQzQmKx2Fck6KnEFyt1vZGmx8yy8oVoYw=;
 b=kiZprqdliNxNPCs+TqWDEJhM9v4MJhoEr6+CkMDfh3ZJ1j5/Cskhxhp0jEE4Fr9s1M
 cCo022c2abpPR4pzQNDNC6AwzDBiMwqT9CpAnt9JwsT89Wcw6TrgMcQH18ohfG2iUozj
 fG3teD3EgwUAqaKfrKP7GACKmE0E23YZK7p83C2sU11tR6sXAKYPuTvpt7vEWttjSugk
 GcAU3NdNGmbAYBY5+1t9QvNj5KygmjzFP8+h1LuHl04hbFJ22Z9OcecR79RtkMSpt9J+
 AZjvdSqB1xCg2TUIRsdtF2Oq5VoL4HE56aXqzejhOkYS9NtCrHZGM3ir5jAnRMvOBjNP
 Mf8g==
X-Forwarded-Encrypted: i=1;
 AKwUvByyYvV29KiRjyNrS6IhAReRG47OiKc/k3uq43sZUX7xcSoDNj+t9k3TAnUsUjqPnHjZ4ljp4dok7blZy8NR@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/3BTi8inZLcxMOsbGk8uxfDm+iMnJpR0PHY4RtObEZl10klWlb
 PdIvwJTptjGL5B3f85/hqLtTfYhRAGg4nn32jNRpb5b936FWEtexZ7SIIRhtyMMq5F74pwPufJ7
 WNoe9Tpp5/HNNKPNL//t6Qw7jeFQBY2oROWCLHSDyH6oh78/BIG3SyCM8eUVZoeKCbVZR
X-Gm-Gg: AYBFou0jFk05/VPKdWnDMDp/warmnbilZaqTQZILsZcRr1RQrLFNovIPiHmdI61e0Th
 /FlflYleKMKJo8E7CFVGJioEqF2dkQd5E1ev4XuxCf9I48JpK/vHJ0ZauBaSr23rv9DHTbCYAAq
 aEJ8dQlHHUhOhkfEn49p1RMhvnaVoBKsjtxdwhvTW6LdSdGP95YyzNGpxAjfVB0z9G+CfaY7ww7
 DkuItsj4oHqoNZVtPmbOf5OyWe40KHDbJFLhE/+XbgczKCLB4Z6ecIPokL3+90DubRdVuNfqnUx
 xdXvTA5/irpxTdXPNeCbunMwd4nn9h0pza/2cfxl7CsjKvQN/xLher6phh5zhc2at5y4uAfe8MW
 YpoyNvcTTjea9nQCSD5NMPzYLzShmYABkn4zioSBdSryOBAXE13kCGKCYmVRM1RGUGoQF/HR+7E
 HzZohA5jWbpm4QldoiseGhJjUBIZlnl/JD0XEteg9hZ5AxKPimKLq1m8cL6nwWtBBKfmUovZkN+
 bDiRmhXeBvKW/9DhoWNlTP+NxSVnV1aMzyN9GqLLWeRx8x2iRqLl/sWfp/fy/g4iZIVN/LAeL2Q
 cNtAjTws9e9qZN6pDclXyacKW+AKUxf3XrcsoANb8YyK4xsAo8BhGOh3sjqaTMraCbsvD0iPmnc
 9hlVRbTtudXeerBLVKKg0c6EVCH3pCEL9cFctJGSEtoabwxio1CmrSrgHZwdcTa535PRMUjnba7
 Be2QOL+K8IsY1M4A==
X-Received: by 2002:a05:6000:4908:b0:48e:7470:9e98 with SMTP id
 ffacd0b85a97d-48e74709f70mr12521538f8f.39.1793533647339; 
 Sun, 01 Nov 2026 03:47:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71ba7168sm14936364f8f.55.2026.11.01.03.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 03:47:27 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 1 Nov 2026 11:47:26 +0000
To: Heiko Hund <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5aa1a838afa924df292e630efb173c3b1dc5b407
X-Gerrit-Change-Number: 2072
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2072?usp=email>
X-Gerrit-Commit: 5f28589175a1cda2f5bf675e93655db229cb4116
In-Reply-To: <gerrit.1793298866000.I5aa1a838afa924df292e630efb173c3b1dc5b407@gerrit.openvpn.net>
References: <gerrit.1793298866000.I5aa1a838afa924df292e630efb173c3b1dc5b407@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjk4ODY2MDAwLkk1YWExYTgzOGFmYTkyNGRmMjkyZTYzMGVmYjE3M2MzYjFkYzViNDA3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <75bfaca8fcb9709c96c23ba60a5baab81d701b03-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNU2A-0000000021s-0A4U
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: cmake: don't prefix
 the event message DLL with lib
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0869271569677841006=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0869271569677841006==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FpuC4+8Iii4="; charset=UTF-8

--FpuC4+8Iii4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2072?usp=3Demail )

Change subject: cmake: don't prefix the eve=
nt message DLL with lib
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

cmake: don't prefix the event message DLL with lib

MinGW builds=
 named the DLL libopenvpnservmsg=2Edll, while the event log
expects openvpn=
servmsg=2Edll=2E

Change-Id: I5aa1a838afa924df292e630efb173c3b1dc5b407
Sign=
ed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Acked-by: Razvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2072
Message-Id: <20261029221700=2E30289-1-gert@greenie=2Emuc=2Ede>=

URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg40305=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
-=
--
M src/openvpnserv/CMakeLists=2Etxt
1 file changed, 2 insertions(+), 1 de=
letion(-)




diff --git a/src/openvpnserv/CMakeLists=2Etxt b/src/openvpnse=
rv/CMakeLists=2Etxt
index 2cc4a93=2E=2E35f1efe 100644
--- a/src/openvpnserv=
/CMakeLists=2Etxt
+++ b/src/openvpnserv/CMakeLists=2Etxt
@@ -69,7 +69,8 @@
=
 if (MSVC)
     set_target_properties(openvpnservmsg PROPERTIES LINK_FLAGS =
"/NOENTRY")
 else()
-    set_target_properties(openvpnservmsg PROPERTIES LI=
NKER_LANGUAGE C OUTPUT_NAME "openvpnservmsg")
+    set_target_properties(op=
envpnservmsg PROPERTIES LINKER_LANGUAGE C OUTPUT_NAME "openvpnservmsg"
+   =
                                                PREFIX "")
     target_link=
_options(openvpnservmsg PRIVATE
         -Wl,--entry=3D0
         -nostdlib=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2072?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5aa1a838afa924df29=
2e630efb173c3b1dc5b407
Gerrit-Change-Number: 2072
Gerrit-PatchSet: 2
Gerrit=
-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>

--FpuC4+8Iii4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2072?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">cmake: don&#39;t prefix the event =
message DLL with lib<br><br>MinGW builds named the DLL libopenvpnservmsg=2E=
dll, while the event log<br>expects openvpnservmsg=2Edll=2E<br><br>Change-I=
d: I5aa1a838afa924df292e630efb173c3b1dc5b407<br>Signed-off-by: Heiko Hund &=
lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2072<br>Message-Id: &lt;20261029221700=2E30289-1-gert@greenie=2Emuc=2Ede=
&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg40305=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/CMakeLists=2Etxt<br>1 file chan=
ged, 2 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pnserv/CMakeLists=2Etxt b/src/openvpnserv/CMakeLists=2Etxt</span><br><span>=
index 2cc4a93=2E=2E35f1efe 100644</span><br><span>--- a/src/openvpnserv/CMa=
keLists=2Etxt</span><br><span>+++ b/src/openvpnserv/CMakeLists=2Etxt</span>=
<br><span>@@ -69,7 +69,8 @@</span><br><span> if (MSVC)</span><br><span>    =
 set_target_properties(openvpnservmsg PROPERTIES LINK_FLAGS &quot;/NOENTRY&=
quot;)</span><br><span> else()</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    set_target_properties(openvpnservmsg PROPERTIES LINKER_LANGUAG=
E C OUTPUT_NAME &quot;openvpnservmsg&quot;)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    set_target_properties(openvpnservmsg PROPERTIES=
 LINKER_LANGUAGE C OUTPUT_NAME &quot;openvpnservmsg&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                     =
              PREFIX &quot;&quot;)</span><br><span>     target_link_options=
(openvpnservmsg PRIVATE</span><br><span>         -Wl,--entry=3D0</span><br>=
<span>         -nostdlib</span><br></pre><p>To view, visit <a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2072?usp=3Demail">change 2072</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2072?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5aa1a838a=
fa924df292e630efb173c3b1dc5b407 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 2072 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 =
</div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@open=
vpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>

</body></html>
--FpuC4+8Iii4=--


--===============0869271569677841006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0869271569677841006==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0869271569677841006==--

