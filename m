Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0EFCD8C90
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5PN3Vkwvn7NRMoy8RsWTmfQrKA8Tu3VJ98Xl2WtjxyY=; b=H3MxIsT6tZrTNGnQF29iPULJpe
	IEFDKuiMzmZQzyLtuvt4QGU4zBNhIy3Hcg5XyE/0tLroWMsXgQkdScd/JP/syBCyEkkTrTB7IHWjS
	WWTVR7tCdeW7byCjJviz8DQqJoa4JD7Ldi87qfH/p3yb1b2kZbICIYfi5RCz9xJMERTA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXMQD-0008N0-SN;
	Wed, 10 Jun 2026 17:08:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXMQA-0008Mb-VM
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:08:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OIlzL1Gbi2gMKUU7tappbTnYONZYUq6OQQHn5BNgb0M=; b=fQI/lGbO54bYXDOiXha8Njt4BJ
 9wb8V8iOK1v1qUUXq8mIGC9bxzESQq+FTdEnQgtiTgJ3BubXza8JfntOBCJ05eI8dakD6xuoihB4n
 u8+MwA19Y7IzuppiLXwyNzLYcEnQ1qZmHA5jUIH3aFpYQuYR7RIsmbRBFqTt44sCVJnU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OIlzL1Gbi2gMKUU7tappbTnYONZYUq6OQQHn5BNgb0M=; b=X
 inPujEmDypL3bdik8nI1gF10wC3+9Q3pD5IUntqxZCwWlKA5zt1VELAM32VTUqXHUwmNGts693ySm
 vYASgLS3PHdaHTAtqai3ZsMYuDvBEBXkWasvEVuYahyUSUuDB4KDSNXH7QnAS2NPA0gPhKcn+xaQf
 0uO+TalE1QfSUZ5g=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXMQ7-0006gL-7w for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:08:55 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso3901543f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781111320; x=1781716120; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OIlzL1Gbi2gMKUU7tappbTnYONZYUq6OQQHn5BNgb0M=;
 b=O5c6zlC1ePEuAxAMtfhPgm5zUBcczhn86FavTLiPrfEUwEGI3JKRJoarl5mzpWAMe/
 UwuCTWsjySEba3lDiwPrTTBSeBK4FK61RONYMwWVdUKEq864fWMjUpFrFJ78DIoPVscb
 IW+daFXM48BeSM0LyoAHr5/Y8StePMXvFgB4ujuZ5RoXsji1gADn17aP3lfNHjhND0Bn
 DBW2J+Eg8WDErZUyGhbRGaQ3hZxOHuvE/bJswcPjRHobq5MyjCp/PEWRaU1Z6vCn+P3l
 KoYD9MR7mcYFvVIYQy/MJRvqipM+bh4mt2/WxHRDEJO9PUCQ0G0WXZRYkpdAVP5BKC6c
 2INQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781111320; x=1781716120;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OIlzL1Gbi2gMKUU7tappbTnYONZYUq6OQQHn5BNgb0M=;
 b=fV8fJixRupjSQBHWH8CfnHFkg06jVWyHCiJWMUtM9IEijST3WM68q1eHWzl/Tm7aeu
 q522PZYfPEcUH2EwF0kFg/CGEFsPH1lj/20BeeGjmEiAx7i7nS9TMrWM0Ay5ztWlTmh5
 o/7bTc82zwCMDeDA96+1sOaZNYndqVrKZ65pl//7qcrtvMGcrAhFXehFv3n9BKMUfdKV
 dRhXw1DksoJhaHMI2MdvdiChLHNwNERn0YwQ1PnidZ0knbC6dD+YpLy3IuLWdrXT8wsJ
 TarB7kVtguHh/GBx+GHR0YPvKHkBYeUGPXVXvI70CJaJixD399KEasgyZeVN4DfkWa/B
 jdvA==
X-Gm-Message-State: AOJu0Yz4utxa+VCD1R6PwxmMoSVRu5xcfYb41uSecFKMsV2kWpvY9D6q
 Y8oVr5WfEBumwNjEBRKabzY48XNuCijnsigN+6LK28dE8EGhizvr8tUqOyFVVoZtFqp5/sMo5VB
 ay4dvH9c3tMZJFpzFoETL/KiHBSLab82gn/j/7ZDa6uJdeZ3s8xFx2nxi1sDj/3DKtYi8MjvL1y
 8hhLg/vQ==
X-Gm-Gg: Acq92OHOq8z/BgQ7vUQ1WJgOT9kJ7VrebTf21nfQtqGlwPSgyLDrzk1nfqmpHmO2mw8
 dXEiADbPCsRC6+ItSNFThl9DRYbN7LKEbZ6wIc+/QQS7YUO6GpaNkuKaCYrRzEqyTPtZs+7b6KI
 3cbNv6+v6f4KggUjiX+XlLFFyaDg9yghTLPUzW9J7wZrGrzOOo8bu06cx5WaZN+C7Om7jYbuqI4
 TR3jdZ3bVF65SWZmC1uGfn0BmAtejO3zb4pBUe9xY1eJDu4mc5XnoxTf4qE3+A1L9WFViPC0K9k
 9J5kNx2ADeUFPjH8PG2sc1T+7cA3w4pAUcnpokMcEKJFJU/jZBA6lmszyIFsllJg5k4o3H4Wvgt
 WfED8yDUFkjWDwq0bFuppvQ5M5Jeyfj2n7Isn8faEG3keUbO0lg4WOcvhatTMv6alsoRa0q4+1T
 LPnUYsMqUDIbktZ8z09f9r0w4IZLyycZML3ynLb3UkJu3I9c6sF+fkYd00lLFCw9rvkJGKae9Rj
 yZfURxE8jmifg5UPplvaokoqRuiJNHUXs6bj3ehvanVrrpPQptDsADGf7mAuCjLzXaVuIUo3yjw
 g+HZp7r/pnj9Rx/AzadZQBPr
X-Received: by 2002:a05:6000:1e4d:b0:460:1168:6dd4 with SMTP id
 ffacd0b85a97d-460302e49acmr30821488f8f.14.1781111319698; 
 Wed, 10 Jun 2026 10:08:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcde3sm75214668f8f.1.2026.06.10.10.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 10:08:39 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 10 Jun 2026 17:08:38 +0000
To: MaxF <max@max-fillinger.net>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5
X-Gerrit-Change-Number: 1701
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1701?usp=email>
X-Gerrit-Commit: b2dcffba0820a1a77472658623b5964e88cbb732
In-Reply-To: <gerrit.1779381787000.I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5@gerrit.openvpn.net>
References: <gerrit.1779381787000.I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MzgxNzg3MDAwLkkyY2E4YmY5MGE3OTZmMmI3NTdjMmZkZTBhZTI0NDY4ZWYzYWJjM2I1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5d4aa593e938efdfbec75b421f725b7f6e404e6a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXMQ7-0006gL-7w
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Null-terminate
 tls-crypt client keys when testing
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4661943739021327677=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4661943739021327677==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RHT2lThBNQI="; charset=UTF-8

--RHT2lThBNQI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 MaxF=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1701?usp=3Demail )

Th=
e following approvals got outdated and were removed:
Code-Review+2 by cron2=
, Code-Review+2 by plaisthos


Change subject: Null-terminate tls-crypt cli=
ent keys when testing
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Null-terminate tls-crypt client keys when testing

After generat=
ing a tls-crypt-v2 client key, OpenVPN will try to load the
generated key t=
o verify that it was generated correctly=2E If the client
key is not writte=
n to disk but printed out on the command line, the PEM
encoded key is store=
d in memory and read_pem_key_file is called with
key_file_inline =3D true=
=2E However, this key is not a null-terminated
string, so we end up calling=
 strlen on a buffer that isn't
null-terminated=2E

This commit adds a null-=
byte at the end of the key=2E

Change-Id: I2ca8bf90a796f2b757c2fde0ae24468e=
f3abc3b5
Signed-off-by: Max Fillinger <maximilian=2Efillinger@sentyron=2Eco=
m>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1701
Message-Id: <20260609102407=2E32590-1-=
gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg37116=2Ehtml
Signed-off-by: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
---
M src/openvpn/tls_crypt=2Ec
1 file changed, 2 in=
sertions(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/01/1701/2

diff --git a/src/openvpn/tls_crypt=2Ec b/sr=
c/openvpn/tls_crypt=2Ec
index e91f80c=2E=2E8c3d722 100644
--- a/src/openvpn=
/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -758,9 +758,10 @@
 
     =
if (!filename || streq(filename, ""))
     {
-        printf("%=2E*s\n", BL=
EN(&client_key_pem), BPTR(&client_key_pem));
+        buf_null_terminate(&c=
lient_key_pem);
         client_file =3D (const char *)BPTR(&client_key_pem=
);
         client_inline =3D true;
+        printf("%s\n", client_file);
 =
    }
     else if (!buffer_write_file(filename, &client_key_pem))
     {

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1701?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2ca8bf90a796f2b75=
7c2fde0ae24468ef3abc3b5
Gerrit-Change-Number: 1701
Gerrit-PatchSet: 2
Gerri=
t-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: cron2 <gert@greeni=
e=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--RHT2lThBNQI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by MaxF=2E</p>=
<p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1701?usp=3Demail">V=
iew Change</a></p><p>The following approvals got outdated and were removed:=

Code-Review+2 by cron2, Code-Review+2 by plaisthos</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Null-t=
erminate tls-crypt client keys when testing<br><br>After generating a tls-c=
rypt-v2 client key, OpenVPN will try to load the<br>generated key to verify=
 that it was generated correctly=2E If the client<br>key is not written to =
disk but printed out on the command line, the PEM<br>encoded key is stored =
in memory and read_pem_key_file is called with<br>key_file_inline =3D true=
=2E However, this key is not a null-terminated<br>string, so we end up call=
ing strlen on a buffer that isn&#39;t<br>null-terminated=2E<br><br>This com=
mit adds a null-byte at the end of the key=2E<br><br>Change-Id: I2ca8bf90a7=
96f2b757c2fde0ae24468ef3abc3b5<br>Signed-off-by: Max Fillinger &lt;maximili=
an=2Efillinger@sentyron=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1701<br>Message-Id: &lt;20260609102407=2E32590-1-gert@greenie=2Emuc=2Ede&gt=
;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforg=
e=2Enet/msg37116=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt;<br>---<br>M src/openvpn/tls_crypt=2Ec<br>1 file changed, 2 inse=
rtions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/01/1701/2</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>index=
 e91f80c=2E=2E8c3d722 100644</span><br><span>--- a/src/openvpn/tls_crypt=2E=
c</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -758,9=
 +758,10 @@</span><br><span> </span><br><span>     if (!filename || streq(f=
ilename, &quot;&quot;))</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        printf(&quot;%=2E*s\n&quot;, BLEN(&amp;cli=
ent_key_pem), BPTR(&amp;client_key_pem));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        buf_null_terminate(&amp;client_key_pem);</spa=
n><br><span>         client_file =3D (const char *)BPTR(&amp;client_key_pem=
);</span><br><span>         client_inline =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        printf(&quot;%s\n&quot;, client_f=
ile);</span><br><span>     }</span><br><span>     else if (!buffer_write_fi=
le(filename, &amp;client_key_pem))</span><br><span>     {</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1701?usp=3Demail">change 1701</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1701?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I2ca8bf90a796f2b757c2fde0ae24468ef3=
abc3b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1701 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body>=
</html>
--RHT2lThBNQI=--


--===============4661943739021327677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4661943739021327677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4661943739021327677==--

