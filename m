Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD7E606A332
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MRh+gXF6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iXrXsU3c;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=l+Bruz9y;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GgWX8ABb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pexycp+01ktQv7o0TYfx3pek9ByiSBMjKVYBa80W5sY=; b=MRh+gXF6yg1M1oSeuK/+w/hHlx
	nCvBFF+2wuKMfmzElwrPGkycw8vLv/zPNo39f/PcM2adLMOzD8mKu0ZZAqCziAzpOxjSeNHMTgsfb
	UGBMIz6lUxc9w7q3tUnYicPMfs9Yf7R3dEv0LAFWFZj7gLy7l24mFFgCob2te00k6Fd0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQRqw-000000002G7-3Dc2;
	Mon, 09 Nov 2026 16:04:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQRqv-000000002Fw-1tkM
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 16:04:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZCMFNmo8digydu258azyLsBPviZh7COMAvSkZ+R6D9A=; b=iXrXsU3cx+od9TJhqNbp68wPZR
 fTEpk5Za2VxhV8qIcvHMZhogJe8HCqkMxMe2llP/aLsHOzuy0op8bgGIqZ9XH4niC1xxlJRmxAWCD
 1BdqCZUuDxz6liFiKPsyx0SKCf4X/W76Eqcrr/aAePoKvlqVNg/UYoV1U4+lO0pEeArY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZCMFNmo8digydu258azyLsBPviZh7COMAvSkZ+R6D9A=; b=l+Bruz9yWTpcuPgkz1+9LJYKsY
 lSdduYkAT8QnUpAs11iAALHMHeYvZL9OJdKTLKC7KzNpf+o5pDtjypYQfr+osnovA8XRgbkS+ZTJJ
 AGXS2pht2lWBwF/D68H3mYIUfEd/5YDBovOZOVkQn28GB30AE6+O2fDHHPM7GbY3M5xE=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQRqu-000000001vp-2OWm for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 16:04:13 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so12772815e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 08:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794240246; x=1794845046; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZCMFNmo8digydu258azyLsBPviZh7COMAvSkZ+R6D9A=;
 b=GgWX8ABb4Br5uonU1vpSCnGpj5ZBOfiGFC7/Qo+Q1qmTIhrrZsvGVsyrdAouTGjaJK
 sVeZjVg+p492T6BVRQ7QpCSDsTMvafag5L4NeL3OVwO2lg+6/UrSeFg/OZX0PlrB/7Sa
 jhbEJDCTcE7be0+WpS9KeZ4rQCBCcL7n2bWJSNRzXXP9OzTY5vyqA6gc7jYXCiH5rih5
 8beOoJuHbh0Q3fOdCh6rJu3e/8mAMY0bzQikXq2nx7+UriWRF5JQ66F/aAWRwa9XjBf1
 W05dj3sW30yKv5D80Mti1Lts40bMgIcSW/a58/VMKoZJoEwHfflcescVPr7m1K67FpbW
 MP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794240246; x=1794845046;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZCMFNmo8digydu258azyLsBPviZh7COMAvSkZ+R6D9A=;
 b=dadqNSI3TvIh59z5p21yGWZGABrmxKv93pYmsxsBJRtoHLjf+Vcafd92hVuPR77cQH
 mI+eqdiFZXJST68OPBQim5EyWWfM/NZzKREnWdLiuREd0wGvy+yDhzHpkt6RnV42jKya
 XhbAew/sd+YRI6VMx6c9zrdL4lUV4C6KbDYtx1mNshKHXY7YlV8aXax3UCWsl3NPZDxc
 g8crJXVEVtK8TNz7q4Zm2DQPpCv3o8VlR6KBXdq+flv4REoWYJ1PuTw/tRyV7WSeRZ7N
 3garyw4Yse1FOgWZKG5kp4BH6eU7OnISaCORN26kKDISuIVZSwTgMo8dexqcZrp+awqg
 CApA==
X-Gm-Message-State: APuU4Z8zWCxL8glMChkL0vxUs/yTSvYPZ/Z4S+QTLiEO/AzuWV9Iy83Q
 CvrUJUKGM0EQ2WKfu3JtoYzC9YSs/0pp1HphHCMkyQea2u1jy8sVgzqAcFtCXp0FAOmBzWjQpq3
 FION5ViY3zV3xvsBllwypYgy7YUqLMrSGhqBVZ9NnUM2xOL0ZqFDCTD7qf52N808Awmmp
X-Gm-Gg: AYBFou0I8eoQEWwLJr1LiDtuCvK2HAxEMyAIOIJ0dbalIjOjk+VF+lw69AtwjwMtVO6
 iczTHfF1a0LPfZiIuqS7JWIX85Ozr4S4M319mQlGJZnJCn8AUmXajPDZQfnWpJ7tLWIIBOfwaS1
 0ga13JdfVulfB+qMCK4UZ0jLrb6TTP/7DJmy8n3dvxRop6l4PHnFlXebq05MFWRX/Vkl0xbmY6s
 PuWFoRrh4Lsw/Go0rCt2RaKmiiqzHmnwLzN87gSjf28I1QqjvgelFlgU44A/OtzOpZV0uTA16i1
 K1AbrQKV4g0jkFXqFrmVSIcFvGGo7AyG7ly4vnOsqFAutwTykoFPgBqK+k7xNassf+hp2gebesP
 u2eW6yTAbmNxccF2JDUI8QnsYUUQeps5Duo+hlkKxZbUAIATc5//R6C2OBQhdEmybyqFp128YuN
 Fgvp11vgpoeaphyABJfacl+id9C4XtnhYBLHYHAFStpVR3F+5lJiXXtE/yi4HbzKr0xxZBDQ+r3
 VU4Ft9vZAG9KfW5NjfDs47pHNwfTYkrt8Mwh2viueqO5Y61dn47dYEEeAr+UwcaX5qqO77CdzXE
 CdJ2hlESN1cuV7i/LJBrUbZOTIe4Zl97OSfYVF0jiO5KBnX0joOOBtv8IzueZnFhZR4spF5gY4Z
 TIIr4nvjbMIf/D4IFwAJMxqPWOphILdGW25xb5eNPrKUd8jRB7TmO7p1BxCboXT22CgDIqJwJ1h
 bX/xpeQ77fpHjjmQ==
X-Received: by 2002:a05:600c:3b8e:b0:4a7:9006:b176 with SMTP id
 5b1f17b1804b1-4b9633cf5b0mr104975005e9.7.1794240245565; 
 Mon, 09 Nov 2026 08:04:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b96cd012e1sm136965745e9.8.2026.11.09.08.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 08:04:03 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 16:04:00 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I88ea70e88c3ec133261210e0404f324bbf025d9b
X-Gerrit-Change-Number: 2104
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2104?usp=email>
X-Gerrit-Commit: b6a82c12c83c3bad2a32b3ef73e2bb2d18f00844
In-Reply-To: <gerrit.1793704368000.I88ea70e88c3ec133261210e0404f324bbf025d9b@gerrit.openvpn.net>
References: <gerrit.1793704368000.I88ea70e88c3ec133261210e0404f324bbf025d9b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA0MzY4MDAwLkk4OGVhNzBlODhjM2VjMTMzMjYxMjEwZTA0MDRmMzI0YmJmMDI1ZDliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4f7ac96a9ca2ae952be2d17070e400e1df617e90-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQRqu-000000001vp-2OWm
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: proxy: free
 proxy_authenticate in http_proxy_close()
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
Content-Type: multipart/mixed; boundary="===============7403029548470758219=="
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7403029548470758219==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UFpqWYPZhZs="; charset=UTF-8

--UFpqWYPZhZs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2104?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: proxy: free proxy_au=
thenticate in http_proxy_close()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

proxy: free proxy_authenticate in http_proxy_close()

T=
he Digest challenge stored by store_proxy_authenticate() was never
freed wh=
en the proxy info was released=2E

Reported-by: hz86 https://github=2Ecom/O=
penVPN/openvpn/issues/1134

GitHub: closes OpenVPN/openvpn#1134
Change-Id: =
I88ea70e88c3ec133261210e0404f324bbf025d9b
Signed-off-by: Razvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2104
Message-Id: <2=
0261103123455=2E4065-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40569=2Ehtml
Signed-o=
ff-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/proxy=2Ec
1=
 file changed, 4 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/04/2104/2

diff --git a/src/openvp=
n/proxy=2Ec b/src/openvpn/proxy=2Ec
index c3ad7de=2E=2E7b5a289 100644
--- a=
/src/openvpn/proxy=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -523,6 +523,10 @@
 vo=
id
 http_proxy_close(struct http_proxy_info *hp)
 {
+    if (hp)
+    {
+  =
      free(hp->proxy_authenticate);
+    }
     free(hp);
 }
 

-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2104?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I88ea70e88c3ec133261210e0=
404f324bbf025d9b
Gerrit-Change-Number: 2104
Gerrit-PatchSet: 2
Gerrit-Owner=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>

--UFpqWYPZhZs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2104?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">proxy: free proxy_authenticate in http_proxy_close()<br><br>The Digest =
challenge stored by store_proxy_authenticate() was never<br>freed when the =
proxy info was released=2E<br><br>Reported-by: hz86 https://github=2Ecom/Op=
enVPN/openvpn/issues/1134<br><br>GitHub: closes OpenVPN/openvpn#1134<br>Cha=
nge-Id: I88ea70e88c3ec133261210e0404f324bbf025d9b<br>Signed-off-by: Razvan =
Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2104<br>Message-Id: &lt;20261103123455=2E4065-1-gert@greenie=2Emu=
c=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg40569=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/proxy=2Ec<br>1 file changed, 4=
 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/04/2104/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec</span><br><span>index c=
3ad7de=2E=2E7b5a289 100644</span><br><span>--- a/src/openvpn/proxy=2Ec</spa=
n><br><span>+++ b/src/openvpn/proxy=2Ec</span><br><span>@@ -523,6 +523,10 @=
@</span><br><span> void</span><br><span> http_proxy_close(struct http_proxy=
_info *hp)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (hp)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free=
(hp-&gt;proxy_authenticate);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span>     free(hp);</span><br><span> }</span><br>=
</pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2104?usp=3Demail">change 2104</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2104?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I88ea70e88c3ec133261210e0404f324bbf025d9b=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2104 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>

</body></html>
--UFpqWYPZhZs=--


--===============7403029548470758219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7403029548470758219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7403029548470758219==--

