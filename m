Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5413C5DF86
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=POT8Neh2ObWOwZa3otmfhuSACg7ulsa9Icr2yLjEvKE=; b=Cnvyk2e0GB3G4v
	jY1+Iy4xDlbDu91MPnEJUFExilynBjBmoaIr29s6g4SHPHzfow6u4sHOKkMQ6bxKGirh1hZwZHb25
	UwhodI6NdIzMtzEqRC0CN0y/Gtl5av/AthRJ2OF0yktGxgAc+cTEJTWWDQLjHREWHl0V0f+vfLNH9
	TdE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwfw5-0002mD-Mj;
	Wed, 19 Aug 2026 13:02:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwfw3-0002m6-TT
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:02:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IsK4hQqAOo/Mnm5DkT6t2iPkuZ4Ln2ryXR4B0z+VSpU=; b=kppHxATMk6nFzfLzvPHqElvyw+
 jX3qa5DVJfPfXbICie8MYOJDojtI6Ni6nUZvaZyrbFr5wdzRlUX6qTBHUQlhMb1Jfz4VL/dAZmd1T
 XfV3qP2Kt1XDsPeHKxYFJ+Qr6KbFE0LggLfX7E5MIWt2EbQbDGuEtpiARjprgQGlylE4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IsK4hQqAOo/Mnm5DkT6t2iPkuZ4Ln2ryXR4B0z+VSpU=; b=I
 XmS+De3yBG9fKTf/JM3FLnWgustaPSDTV0o04aB1a43lKJpDRyHpIbiCsURHR32qPQa3qToaVwgya
 sv/iROBLP69zCGzKmvrq+/ahAcw7gzx6rKNn92ecLJMFpiNCA4ylI92YmRlVtAhXZuIEKrW/HM0qw
 grakpyGTxHF55MXE=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwfw4-00029f-RC for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 13:02:28 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-476a130c138so1049423f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787144539; x=1787749339; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IsK4hQqAOo/Mnm5DkT6t2iPkuZ4Ln2ryXR4B0z+VSpU=;
 b=Tx1+94foPWHgsu5tEm4yty1FlVjzndof+LqC4u1W3UI1ltaq98XnQ3dxrAJOPG9mx+
 ZNQdHDuLbpi9L1srRQLZjPkZ6CG13t1UL2FtLCm3tDBUW2xRMcWmhvG8fZ3wIPgph6yg
 7kg8D6qoqBvj4kxflOLamseHPJ9ilitGQDyJi2ZVhY9UXzEexruUebdz6wyhul6FlU2p
 nQjpetV4e+b08rQvdyGQT0icrqTBmOxfIsQISh+4PC/KslPjAp+zjrwwigliSHLqbgbV
 RRFFJmxifETraenhNf1vK/8YMbaWD5yTGQqdHUXfD453jBW0QgnnNJZilx0xWIXbS0PX
 MPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787144539; x=1787749339;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IsK4hQqAOo/Mnm5DkT6t2iPkuZ4Ln2ryXR4B0z+VSpU=;
 b=kP27B/dI+THB0QxrywULXC4XhPEGW0HaPPNvehWj7iBtuSZHk4Zt7x+D8Rv0IhJ+eQ
 WvSJY/QrM8NzVD8lRWghDCtn8HAKrN0Iz8hQXhIhIsjVPgTC7IZVEVg+M3j/vL6prXTm
 AOpF7GjLO9VVNbXwFDYe2OJAUnR7V/VRyqvLwONM3x636FNEoq4Td9JteykXbYIDfbbJ
 3xZw8TVZ4KsH8jCY3CZjd8XdNYmCZavLTC1+17bUTIVffiweF5JssgpEMyYGwwFqw9wv
 RrzZqS49AFE9/0jE/PVWN/oPFydECu7UK4Ezsw92VCb0jQ8XHdHIJpBxG6tqIW4hqLGV
 oirQ==
X-Gm-Message-State: AOJu0Yz9SkM2xsikwj/8TGmNGMO0kW6jSRtzK5p8wFwNAPmQRSM7Hb+4
 hx0tOyKMAya3aTEA1HJAL8X9O27duy9u+lAaV9CYtwzSNv6Na4NFwqm4Ya7tUtz76TElgL9w8ZV
 qxfoz4150OmUuC/IjrwWKLcWH8eRBhpflBXIoiIt3avwx3nsWigXHajwzXRM0J8GTxGda+Rugr9
 khXDJ//Q==
X-Gm-Gg: AR+sD13wdvXHlY7G3aB5DRBZEPMJZ18y7Eg+1qZCehzG9ne9Cst78cKOhrVY88Otqw+
 b86yfQ0Riaz5MoMUonLNSSL8uX2jSdhU5EuLD1QRuAXcQC8xDTwvdS5kDApBhBJFZSfluybP8j9
 Fu/8WEz54Q8EenZS240NBH5edaassjUch++HVZA8DGqXwcbx9lq3xMU9+6FGJPWD0OhTIWbSCkc
 luQrvqBWVzcSEsg6LWPvZyHcCzGDGAzvxq6g/eVbVm6eoTAzzwDFjIf3DV1/D0tVA7OGZDz35am
 xU8YrXPF/PUT9kI8CmJsalQgMUdPl66KcIxblTdQAQALcJikNvjYRU+By88iL/wLLMMScGixIgl
 rvvCH5/X7FRUVU0YQ2wDn4+0FRTl2EfQ6GZFo8BLnDqhhisghMw9J5Y6YNu+u9zmSFdWBfpM+BX
 U8l5xOOB61j4uAj6qJBiUHIY3P+Hj8Y3vTPVV46pl5qgjKLgio8yUOjARW1jcoldNhPWEW+QQtr
 mupoiNcT9c3faJESBGzqZKN5DfoEoj1oguH+6DYeRkrdoowPLqA46Ll7o9gOJx5F9okxdViXmAn
 jpmDo9N3fLc2+H7rOo2pE5VrSCTIhvekD6MszYxiB3FJs9WlzvA=
X-Received: by 2002:a05:600c:4e47:b0:499:a0f3:9d5c with SMTP id
 5b1f17b1804b1-499aa14a711mr92378585e9.3.1787144537074; 
 Wed, 19 Aug 2026 06:02:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa111113sm50157165e9.4.2026.08.19.06.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 06:02:15 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 13:02:15 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ibb80db0547dcc0935964c9bd40222c27aac80439
X-Gerrit-Change-Number: 1848
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1848?usp=email>
X-Gerrit-Commit: 91b90cb1673a08f55173925b22acac51b611ea41
References: <gerrit.1787144531000.Ibb80db0547dcc0935964c9bd40222c27aac80439@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTQ0NTMxMDAwLkliYjgwZGIwNTQ3ZGNjMDkzNTk2NGM5YmQ0MDIyMmMyN2FhYzgwNDM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eab1f446114cc3c8a0dc1f6eae17dc631ee529c8-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwfw4-00029f-RC
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: .clang-format:
 Convert deprecated setting KeepEmptyLinesAtTheStartOfB...
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5127738603582922108=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5127738603582922108==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DcghcivQ3wM="; charset=UTF-8

--DcghcivQ3wM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1848?usp=3Demail

to review the following change=2E


Chang=
e subject: =2Eclang-format: Convert deprecated setting KeepEmptyLinesAtTheS=
tartOfBlocks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


=2Eclang-format: Convert deprecated setting KeepEmptyLinesAtTheStartOfBlo=
cks

Convert to new KeepEmptyLines settings=2E This adds
AtStartOfFile sett=
ing and applies it=2E

Change-Id: Ibb80db0547dcc0935964c9bd40222c27aac80439=

Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M =2Eclang-=
format
M src/openvpn/crypto_mbedtls=2Eh
M src/openvpnserv/validate=2Eh
3 fi=
les changed, 4 insertions(+), 3 deletions(-)



  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/48/1848/1

diff --git a/=2Eclang-fo=
rmat b/=2Eclang-format
index 4774d1e=2E=2E0823739 100644
--- a/=2Eclang-for=
mat
+++ b/=2Eclang-format
@@ -32,7 +32,10 @@
 IndentWidth: '4'
 IndentWrapp=
edFunctionNames: false
 InsertBraces: true
-KeepEmptyLinesAtTheStartOfBlock=
s: false
+KeepEmptyLines:
+  AtEndOfFile: false
+  AtStartOfBlock: false
+ =
 AtStartOfFile: false
 MaxEmptyLinesToKeep: '2'
 PointerAlignment: Right
 R=
eflowComments: true
diff --git a/src/openvpn/crypto_mbedtls=2Eh b/src/openv=
pn/crypto_mbedtls=2Eh
index 04346a9=2E=2E5c3b670 100644
--- a/src/openvpn/c=
rypto_mbedtls=2Eh
+++ b/src/openvpn/crypto_mbedtls=2Eh
@@ -1,4 +1,3 @@
-
 /=
*
  *  OpenVPN -- An application to securely tunnel IP networks
  *        =
     over a single TCP/UDP port, with support for SSL/TLS-based
diff --git =
a/src/openvpnserv/validate=2Eh b/src/openvpnserv/validate=2Eh
index 12150f1=
=2E=2E2da41dc 100644
--- a/src/openvpnserv/validate=2Eh
+++ b/src/openvpnse=
rv/validate=2Eh
@@ -1,4 +1,3 @@
-
 /*
  *  OpenVPN -- An application to sec=
urely tunnel IP networks
  *             over a single TCP/UDP port, with s=
upport for SSL/TLS-based

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1848?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: Ibb80db0547dcc0935964c9bd40222c27aac80439
Gerrit-Change-Number: 1848
=
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>

--DcghcivQ3wM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1848?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">=2Eclang-format: Convert deprecated setting KeepEmptyLinesAtTheStartOf=
Blocks<br><br>Convert to new KeepEmptyLines settings=2E This adds<br>AtStar=
tOfFile setting and applies it=2E<br><br>Change-Id: Ibb80db0547dcc0935964c9=
bd40222c27aac80439<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt;<br>---<br>M =2Eclang-format<br>M src/openvpn/crypto_mbedtls=2Eh=
<br>M src/openvpnserv/validate=2Eh<br>3 files changed, 4 insertions(+), 3 d=
eletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/48/1848/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/=2Eclang-format=
 b/=2Eclang-format</span><br><span>index 4774d1e=2E=2E0823739 100644</span>=
<br><span>--- a/=2Eclang-format</span><br><span>+++ b/=2Eclang-format</span=
><br><span>@@ -32,7 +32,10 @@</span><br><span> IndentWidth: &#39;4&#39;</sp=
an><br><span> IndentWrappedFunctionNames: false</span><br><span> InsertBrac=
es: true</span><br><span style=3D"color: hsl(0, 100%, 40%);">-KeepEmptyLine=
sAtTheStartOfBlocks: false</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+KeepEmptyLines:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  AtEndOfFile: false</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  AtStartOfBlock: false</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  AtStartOfFile: false</span><br><span> MaxEmptyLinesToKeep: &#39;2=
&#39;</span><br><span> PointerAlignment: Right</span><br><span> ReflowComme=
nts: true</span><br><span>diff --git a/src/openvpn/crypto_mbedtls=2Eh b/src=
/openvpn/crypto_mbedtls=2Eh</span><br><span>index 04346a9=2E=2E5c3b670 1006=
44</span><br><span>--- a/src/openvpn/crypto_mbedtls=2Eh</span><br><span>+++=
 b/src/openvpn/crypto_mbedtls=2Eh</span><br><span>@@ -1,4 +1,3 @@</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br>=
<span>  *  OpenVPN -- An application to securely tunnel IP networks</span><=
br><span>  *             over a single TCP/UDP port, with support for SSL/T=
LS-based</span><br><span>diff --git a/src/openvpnserv/validate=2Eh b/src/op=
envpnserv/validate=2Eh</span><br><span>index 12150f1=2E=2E2da41dc 100644</s=
pan><br><span>--- a/src/openvpnserv/validate=2Eh</span><br><span>+++ b/src/=
openvpnserv/validate=2Eh</span><br><span>@@ -1,4 +1,3 @@</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  *=
  OpenVPN -- An application to securely tunnel IP networks</span><br><span>=
  *             over a single TCP/UDP port, with support for SSL/TLS-based<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1848?usp=3Demail">change 1848</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1848?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibb80db0547dcc093596=
4c9bd40222c27aac80439 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1848 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>

</body></html>
--DcghcivQ3wM=--


--===============5127738603582922108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5127738603582922108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5127738603582922108==--

