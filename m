Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02799606A332
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=I7dFK9Ju;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ahkl7Vwp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kRARPE14;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CxAuvZE4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=6WIBTa4nmls6ArDF93Y2kBsqiiEC6GnYWe5V8CQgSRY=; b=I7dFK9JuhZDz0JWLKJu/j943EB
	czV/E4dufk21tfA1UeR1HcRmF9PM+uRbvMai9QI53xUaYnyut7T+tmiYhfODnyA9x0zgwfxcTA4o4
	4NcCumveC+sVPy1lK65lNS1C6fTOczfbBm7ZVfoc5cKx7ulNvByHUIOsbalzSGOfWxfs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM8bx-000000004s5-1Y8Q;
	Wed, 28 Oct 2026 18:42:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM8bv-000000004ru-3h1Y
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:42:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rSGKsXoT4biGobVPG6y02HmqguIGCHH0IgQ9taw9XAo=; b=ahkl7VwpkB+R3gk4A4dkfodeWC
 gX/UnyhVP3E2Jy1DS/qbYneqD3B28GpNALowvikKDNGvz63ajhni6B+j+Ww8acariFXINbRc+h8tZ
 rVjEajym6fP51RVi8yFTwKh71/Vfz0V9/qAsLZRRZnwkXSaxWnNt5GOaZYAFDFxPTNZA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rSGKsXoT4biGobVPG6y02HmqguIGCHH0IgQ9taw9XAo=; b=kRARPE143Pna3dGY4FeOqSyqTo
 wdgVGRb4ZO2yayKUq6rRnpiMqEt4OI7tc0PVZ//bc12q4vhj1FTkinC4vMxAOmPmz5OJ41rjjMyG3
 rU1d5dKcBrgmWJr80AoDH9nunw3izP2UZZ5frP5jfgUqKbUk9mJdhh32Q7gp2NtCUTDk=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM8bu-0000000018S-1NOY for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:42:55 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so905808f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 11:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793212968; x=1793817768; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rSGKsXoT4biGobVPG6y02HmqguIGCHH0IgQ9taw9XAo=;
 b=CxAuvZE4sOIQfFmPgvSaKYRgzwWchgFfL/Gh+op9ue9dTCBuO4NKJlH/FWW9D4yfml
 Tjr9ANiCBMwTUwdX6sQ8LgtMduMi3aHQk8lotHJZjhu6J/bfgi/Dfc4NDk5P+Q8/QgWd
 5Co1xtBWJKqd6TmHXdw05Dh3YGypxLgWr2Mj2emeSl2vTPuRYxTXN5GUiCH0ukhdYk1V
 1f7IGq6QihVS6Vo87NJdT188JbKoTwaZvHkTScF8kGUOmOOhHhI481hlMlp4HxnYsZ0D
 CqE47Fw8sXLFowcsqQ3XsQjefAybTWIOKiUnP+r6/3SVHrZAl1ve8Zs2EO8ltfm1JdO8
 cpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793212968; x=1793817768;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rSGKsXoT4biGobVPG6y02HmqguIGCHH0IgQ9taw9XAo=;
 b=sbzxYfuGPWe9QNOwEPiEocM5H0xrj1TL+VqR7Ir6rDStcJ8STrfOI4lBxUboS4Bigq
 XcSqlaiiA7byeCs0hUT55gE7EHhHhqDg2O7v06qiAbcewF99KhEjhGcLFNIJz664r0CP
 pukAQXhDvoQru2wVS4YTtwLI7hgFReOa+/2xVBJUDZ7GGRlZD72m5Fk422zGNtJmEqAo
 mBDt3uAUa0UxHgVPi36OUymUtPGTyLlEi2aNMxK4jY2Ns3sRqEv/9wr4XVdFuR8gfdoN
 KIfloDRRBLM/nzZ1/UgPNGoAEet8GuMSWVk4QY58+FmTfJuj6oKChnEFugr/FvGeZDbD
 8ZOg==
X-Gm-Message-State: AFq9FYKZBdkoimYPNjjHA32VcEBkqLdsBUG6+NIZtU2BYdkR/wyXJAtm
 +0pSdRBn71FQinSrhqAIvfiZ7ITubtF6RswkWo+v84dHjV6FOWkKbfPFVLChBbyavsTPY5UJC5A
 Q9wiAfDjtOo5CVfhtzslN+shTkaqYhhhh/57K4/8k51A/3tMRvuWLGetg45tF9UlsRv2vnWUoaY
 +Cq0/mTg==
X-Gm-Gg: AYBFou1kjwCnAWnvsm3to0W2ZYX5fr9mCDwv1xVje/2sC4gVuh963LFch332VeYsh64
 whVrty20ceimM3yzZfwYc6rhrYMU8s06Dtyd5prZR1B0/ru5P+HXJQFAXP3RcKAWyJ7OxwUu98z
 51AC0/10o2cOmvwyWcRy3A8vyrMK9E8YV9PpGpUKWA9voO/20wqrymVnpoTv1VzqAmmowr3qdks
 MzRIFvWFvR6jKvs7WSPLdjUyp9U2ZDy2oLqZcyWY0/BALI3i9ZP7RjJ6mfTXWiSERtx6f05Wpqp
 xa5THSc1ZWUs3N/eUmlbBzz9uqhAvP81F8Bb+a8ZOxKZnrNXsrEoUJ29pFkpyqPUWF+osTY0k67
 0rYULQ19ux2iXbC5VdAUWWXb8ZsbqieZci1x0IC7nHLZW1+rxJeMFM5RFLm6yzwSGTSpwAu8pc9
 Nz4fKrnn+7UNQ3KnYcw9J/VWHkpUtjd544RuVJfUgee7eM6da3hohs5CfTq/Pah6Ibwcgau2QAc
 /YgWL8fSM6P4UBFMUSx75nCQdLC6vyPpPWG3cqQCA+Qu938fzoNYkeeoWwWfPyA0U7sm4Dvcbbe
 FxMIHfuaj0ysEAU9ztuaTUQpq5dA48BJVjy9kYyGZqVN6aCMc+jF1tBwlCO92mR/sQAfjOy+iMR
 xkygvN+hAjwPeT+tPfig3T46Kz2f+p9mKfBPpK8KCDOlYezuZHZC+M35NLe3lM3nIuduMVRDD+J
 nihXqLskOHG5z4wtRf2ivtsBOIZSIF5qD1/P5B
X-Received: by 2002:a5d:5f86:0:b0:48a:fe00:ad1 with SMTP id
 ffacd0b85a97d-48e64953d4amr1194834f8f.6.1793212967605; 
 Wed, 28 Oct 2026 11:42:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb40733sm23419268f8f.0.2026.10.28.11.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 11:42:47 -0700 (PDT)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 18:42:46 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I464672facb34de83930eddc4e86826d3b1cd3edd
X-Gerrit-Change-Number: 2068
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2068?usp=email>
X-Gerrit-Commit: 988fdee9ddb81d4e5d54232365c1345975ceb0b6
References: <gerrit.1793212962000.I464672facb34de83930eddc4e86826d3b1cd3edd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjEyOTYyMDAwLkk0NjQ2NzJmYWNiMzRkZTgzOTMwZWRkYzRlODY4MjZkM2IxY2QzZWRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <82427f2f5905fdba3a8b58f8a8d03f3698c1844e-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM8bu-0000000018S-1NOY
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix numbering of
 examples in management-notes.txt
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Selva Nair \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: selva.nair@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Selva Nair \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3818970732827721882=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3818970732827721882==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="11Yv/iQHLk4="; charset=UTF-8

--11Yv/iQHLk4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2068?usp=3Demail

to review the following change=2E
=


Change subject: Fix numbering of examples in management-notes=2Etxt
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix numbering of=
 examples in management-notes=2Etxt

Change-Id: I464672facb34de83930eddc4e8=
6826d3b1cd3edd
Signed-off-by: Selva Nair <selva=2Enair@gmail=2Ecom>
---
M d=
oc/management-notes=2Etxt
1 file changed, 7 insertions(+), 7 deletions(-)

=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/206=
8/1

diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt
i=
ndex a28a1a8=2E=2Eeac91a4 100644
--- a/doc/management-notes=2Etxt
+++ b/doc=
/management-notes=2Etxt
@@ -345,29 +345,29 @@
   The PASSWORD real-time mes=
sage type can also be used to
   indicate password or other types of authen=
tication failure:
 
-  Example 3: The private key password is incorrect and=
 OpenVPN
+  Example 4: The private key password is incorrect and OpenVPN
  =
 is exiting:
 
     >PASSWORD:Verification Failed: 'Private Key'
 
-  Examp=
le 4: The --auth-user-pass username/password failed,
+  Example 5: The --au=
th-user-pass username/password failed,
   and OpenVPN will exit with a fata=
l error if '--auth-retry none'
   (which is the default) is in effect:
 
  =
   >PASSWORD:Verification Failed: 'Auth'
 
-  Example 5: The --auth-user-pa=
ss username/password failed,
+  Example 6: The --auth-user-pass username/pa=
ssword failed,
   and the server provided a custom client-reason-text strin=
g
   using the client-deny server-side management interface command=2E
 
  =
   >PASSWORD:Verification Failed: 'custom server-generated string'
 
-  Exa=
mple 6: If server pushes --auth-token to the client, the OpenVPN
+  Example=
 7: If server pushes --auth-token to the client, the OpenVPN
   will produc=
e a real-time PASSWORD message:
 
     >PASSWORD:Auth-Token:foobar
 
-  Exa=
mple 7: Static challenge/response:
+  Example 8: Static challenge/response:=

 
     >PASSWORD:Need 'Auth' username/password SC:1,Please enter token PIN=

 
@@ -378,7 +378,7 @@
   formatted as described in the Challenge/Response =
Protocol section
   below=2E
 
-  Example 8: Dynamic challenge/response:
+ =
 Example 9: Dynamic challenge/response:
 
     >PASSWORD:Verification Faile=
d: ['CRV1:R,E:Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6l:Y3Ix:Please enter token PIN'=
]
 
@@ -395,7 +395,7 @@
   in the Challenge/Response Protocol section below=

 
 See the "Challenge/Response Protocol" section below for more details
-a=
bout examples 7 and 8, including how the management interface client
+about=
 examples 8 and 9, including how the management interface client
 should re=
spond=2E
 
 COMMAND -- forget-passwords

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2068?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I464672facb34de83930eddc4e86826d3b1cd3edd
Gerrit-Ch=
ange-Number: 2068
Gerrit-PatchSet: 1
Gerrit-Owner: Selva Nair <selva=2Enair=
@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--11Yv/iQHLk4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Selva Nair would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2068?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Fix numbering of examples in management-notes=2Etxt<br><br>Change=
-Id: I464672facb34de83930eddc4e86826d3b1cd3edd<br>Signed-off-by: Selva Nair=
 &lt;selva=2Enair@gmail=2Ecom&gt;<br>---<br>M doc/management-notes=2Etxt<br=
>1 file changed, 7 insertions(+), 7 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/2068/1=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Et=
xt</span><br><span>index a28a1a8=2E=2Eeac91a4 100644</span><br><span>--- a/=
doc/management-notes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt=
</span><br><span>@@ -345,29 +345,29 @@</span><br><span>   The PASSWORD real=
-time message type can also be used to</span><br><span>   indicate password=
 or other types of authentication failure:</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  Example 3: The private key passwor=
d is incorrect and OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  Example 4: The private key password is incorrect and OpenVPN</span=
><br><span>   is exiting:</span><br><span> </span><br><span>     &gt;PASSWO=
RD:Verification Failed: &#39;Private Key&#39;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  Example 4: The --auth-user-pass=
 username/password failed,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  Example 5: The --auth-user-pass username/password failed,</span><b=
r><span>   and OpenVPN will exit with a fatal error if &#39;--auth-retry no=
ne&#39;</span><br><span>   (which is the default) is in effect:</span><br><=
span> </span><br><span>     &gt;PASSWORD:Verification Failed: &#39;Auth&#39=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
Example 5: The --auth-user-pass username/password failed,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  Example 6: The --auth-user-pass use=
rname/password failed,</span><br><span>   and the server provided a custom =
client-reason-text string</span><br><span>   using the client-deny server-s=
ide management interface command=2E</span><br><span> </span><br><span>     =
&gt;PASSWORD:Verification Failed: &#39;custom server-generated string&#39;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Ex=
ample 6: If server pushes --auth-token to the client, the OpenVPN</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  Example 7: If server pushes=
 --auth-token to the client, the OpenVPN</span><br><span>   will produce a =
real-time PASSWORD message:</span><br><span> </span><br><span>     &gt;PASS=
WORD:Auth-Token:foobar</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  Example 7: Static challenge/response:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  Example 8: Static challenge/respon=
se:</span><br><span> </span><br><span>     &gt;PASSWORD:Need &#39;Auth&#39;=
 username/password SC:1,Please enter token PIN</span><br><span> </span><br>=
<span>@@ -378,7 +378,7 @@</span><br><span>   formatted as described in the =
Challenge/Response Protocol section</span><br><span>   below=2E</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Example 8: Dy=
namic challenge/response:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  Example 9: Dynamic challenge/response:</span><br><span> </span><br>=
<span>     &gt;PASSWORD:Verification Failed: [&#39;CRV1:R,E:Om01u7Fh4LrGBS7=
uh0SWmzwabUiGiW6l:Y3Ix:Please enter token PIN&#39;]</span><br><span> </span=
><br><span>@@ -395,7 +395,7 @@</span><br><span>   in the Challenge/Response=
 Protocol section below</span><br><span> </span><br><span> See the &quot;Ch=
allenge/Response Protocol&quot; section below for more details</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-about examples 7 and 8, including =
how the management interface client</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+about examples 8 and 9, including how the management interf=
ace client</span><br><span> should respond=2E</span><br><span> </span><br><=
span> COMMAND -- forget-passwords</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2068?usp=3Demail">change 206=
8</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2068?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I464672facb34de83930eddc4e86826d3b1cd3edd </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2068 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Selva Nair &lt;=
selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--11Yv/iQHLk4=--


--===============3818970732827721882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3818970732827721882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3818970732827721882==--

