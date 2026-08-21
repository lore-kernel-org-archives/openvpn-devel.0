Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D86C5DF7D
	for <openvpn-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=xhL4YDZ2sffW7cY6SbCVYOUuUzX5WCf+lK8MN1CqKE4=; b=VOKjTrgLYas+Gl
	zENOvdb1VpJXm6KKFZXUFUg+NqV+7lVWlwuNbZKk4NfgD37nTp13gC+KkpHCHhgOyuz7yCHYN0TsW
	z8qquiUTJg/8XzFTGaHO8XMrPLj9ITIUxov02apcWGZmR5Kn8QRXHdFyziGwLt/m+q7IvK2I0A8xH
	Tvo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxRUx-0004CY-Fc;
	Fri, 21 Aug 2026 15:49:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wxRUw-0004CR-CE
 for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kKlZhYkODDLKPdpfWvBsPB3NkpE4TSrPWeIMViPgLf4=; b=IC9d27bL6OIV/JSaVFQQSjFlzn
 qWDZCBYOM3SpAH25w3Gw3aoLUbcfEuMIXbRF1o15oachBJ2kmZshFF37tqdMlzg7YIne66OqC9Ogg
 SIz3R3ynjd3Q8jQ3aNmLKjFJ7ScO5dp3B/Misn6/yo/TEqi+TgeDXxvexgI+6KDSSSec=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kKlZhYkODDLKPdpfWvBsPB3NkpE4TSrPWeIMViPgLf4=; b=h
 go1Bi6yIZB48bi2xZe8E1aqX3V3J1sA9zUooV0ilyP9SdBI6VBfj3inWAvq3a76b5s6gCoqPdCT3l
 UX9nN54J6hI8x9b5kyCkiYlAD882bGOqjnfUGAWgZNE/l4xRhhkJo6XF55baqCjk9cV5DDVrkD1te
 DakNi/1Eq6kfuQLs=;
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wxRUs-00059j-Fn for openvpn-devel@lists.sourceforge.net;
 Fri, 21 Aug 2026 15:49:35 +0000
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6a173ad7cf4so2319471a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 21 Aug 2026 08:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787327368; x=1787932168; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kKlZhYkODDLKPdpfWvBsPB3NkpE4TSrPWeIMViPgLf4=;
 b=JzSDVFBx6osDIMygnU67b1ybWCXPF/ZG99O/74IQnFN7ycRVoUfM+bSBXgFKQUenrR
 d5LpXJx7DQuT8pSj23E+oAaqPMKkhOIAnekHnWRRZ+m/LElC5V+iicOqTxTh38hvoEVR
 7R7pAQs/SWtUvOZIO9W4+mbjjdGRRpM7q2vbHg30ja/YhBQ0OgY6MsH5QNfEQQe4B6mV
 guxBCnlP77Ii5dXsTEpkCjK2a82atEulzzOADoLRQvbgyUpKd6J9T1fBMiBvqckv5OI1
 5MuIdJKcA4EJR+qmV45ZxwdzzBUAGdmb0a1Pq3l0kBiHaNgNJKz6Xs+Fg0WQskjtzQHe
 nOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787327368; x=1787932168;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kKlZhYkODDLKPdpfWvBsPB3NkpE4TSrPWeIMViPgLf4=;
 b=ccM+kZFgoTd1G2Vo55ZXKZFdwhf0ls8CeJYHA4JVECxYdlcK+MFl4/RxHZrJmSPUHn
 5mvQyZNKUJljKSbWr6Zd+ENsBSCKiYE7W8XD2HvLDO171TvlRm6I8TNW5MQma9Mhdi0F
 dmcmjBmzZSQmEYVxehcQvg+0UlUdsWaVzmPo5OsCCQ5PvQYQ91z/2VrxKPiZMmQrXS3e
 H4Cz+73pkSyohxbJhMVG5Xx+atbAE9YH1XL+g/LZ1x4m+eATLyF3GIlr1TtBeeVoRF2m
 5tCB2KhJ+Q7w0bjRi/eAx46b51Hsfmohjut7jotEF5AES1kzFpkB06W+kTmG8Gg9nkKs
 pfIQ==
X-Gm-Message-State: AFuF++n70nEksz5w3AxJ9kgGxBmawrzhyz6FtEgTjgyp4EoECLk1BR6+
 G2X9Vb6f7fXSqJkgJXyjtzsb5PZmbwSgOxMQOAksl6Cga9rv2QEYetgBPW6ElIPEB/i2S4cRVIV
 cYsdcBirFNkrP+bbFoaB4djcZm7aX2VT26PJ0Rd/eczi3DJWM5G8n6ltiPr+KYippThToFuHgQH
 pH8qcVgA==
X-Gm-Gg: AR+sD11ln52peKBvLZdwQVVbziFAg/gEbl7VdoxHFWhA9iehGkDr8Gnc19iIL1sILbn
 2Upeq2MO45vmhXjFH+yunZrg4EfXpAmHTgkxcI7JadjfcXfsAce8dqL6RRZrxR8CX5lSoySce9B
 kvyEDvy7d35RM96cd3MKjz0v6TdOkKjCuBYgWzc9fbjTY9Sz3b0FdVGgBS2uDlwfP9gOOFuUGkV
 C2u8GW2ohtCl8uMIUTDyefmmnlmHgu5QoPXRhvFWD0CqnHbDqHN6uRKvn2+8DMYOrK3BbKvhJPp
 yyw5yRZ53+3ZlA23qPOxOhVTWn7kVY7xJyOZrUqL6n3nocdxtu02gs7ggGQCjibaWosLLwg1mEq
 Wh36eYyW7+dXIU1qFFcFUAtGEYflWfYpuwcBP537deqXcRN+ybdopS2qYXHuhPdrNHi2It4Imp8
 NX6A9vqKo9Vg3yYAvrwYHqca6JwMf8hJGhhY4mqBQoTLQGD6f2nSP4969o371WgTpIrFz/nDMc5
 z4W1AWuJ68jiIjMlSan8NFjrajyTsafHvB55KhlFw1sJ6QhO5uhUoi3JEjtayRdbSfpVREDDwT7
 91MUhCFYQ5mDsh5i4+juu/VQz/ix4fn6TS5eLBZDQuWiXBmnpUA=
X-Received: by 2002:a17:907:a0e:b0:c19:45e3:2f57 with SMTP id
 a640c23a62f3a-c246a61435fmr756978866b.9.1787327367667; 
 Fri, 21 Aug 2026 08:49:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24589e1b0csm511949066b.8.2026.08.21.08.49.27
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:49:27 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 21 Aug 2026 15:49:26 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I432df6c69249b49e9b9a3a904803904d134387a0
X-Gerrit-Change-Number: 1857
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1857?usp=email>
X-Gerrit-Commit: 736091bab4b3b810bea37e418530cfcc72b13d8c
References: <gerrit.1787327336000.I432df6c69249b49e9b9a3a904803904d134387a0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MzJkZjZjNjkyNDliNDllOWI5YTNhOTA0ODAzOTA0ZDEzNDM4N2EwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <54ebfb5f45f5049a764f4df5eb96053f25f77e75-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wxRUs-00059j-Fn
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add mock support for
 management messages
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7219849969909412525=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7219849969909412525==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FyZ3YGsrwUE="; charset=UTF-8

--FyZ3YGsrwUE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1857?usp=3Demail )


Change subject: Add mock support fo=
r management messages
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Add mock support for management messages

Change-Id: I432df6c692=
49b49e9b9a3a904803904d134387a0
Signed-off-by: Arne Schwabe <arne@rfc2549=2E=
org>
---
M tests/unit_tests/openvpn/mock_msg=2Ec
M tests/unit_tests/openvpn=
/mock_msg=2Eh
2 files changed, 11 insertions(+), 0 deletions(-)



  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/57/1857/1

diff =
--git a/tests/unit_tests/openvpn/mock_msg=2Ec b/tests/unit_tests/openvpn/mo=
ck_msg=2Ec
index 8176d2a=2E=2E3e73d19 100644
--- a/tests/unit_tests/openvpn=
/mock_msg=2Ec
+++ b/tests/unit_tests/openvpn/mock_msg=2Ec
@@ -43,6 +43,7 @@=

 
 
 char mock_msg_buf[MOCK_MSG_BUF];
+char mock_managment_buf[MOCK_MSG_BU=
F];
 
 
 void
@@ -76,6 +77,14 @@
     {
         printf("FATAL ERROR:");
  =
   }
+
+    if (flags & M_MSG_VIRT_OUT)
+    {
+        CLEAR(mock_managmen=
t_buf);
+        vsnprintf(mock_managment_buf, sizeof(mock_managment_buf), =
format, arglist);
+        return;
+    }
+
     CLEAR(mock_msg_buf);
     =
vsnprintf(mock_msg_buf, sizeof(mock_msg_buf), format, arglist);
 
diff --gi=
t a/tests/unit_tests/openvpn/mock_msg=2Eh b/tests/unit_tests/openvpn/mock_m=
sg=2Eh
index da96b212=2E=2E41ce48f 100644
--- a/tests/unit_tests/openvpn/mo=
ck_msg=2Eh
+++ b/tests/unit_tests/openvpn/mock_msg=2Eh
@@ -36,6 +36,8 @@
 
=
 extern bool fatal_error_triggered;
 extern char mock_msg_buf[MOCK_MSG_BUF]=
;
+extern char mock_managment_buf[MOCK_MSG_BUF];
+
 
 msglvl_t mock_get_deb=
ug_level(void);
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1857?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
432df6c69249b49e9b9a3a904803904d134387a0
Gerrit-Change-Number: 1857
Gerrit-=
PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--FyZ3YGsrwUE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1857?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Add mock support for management messages<br><br>Change-Id: I432df6=
c69249b49e9b9a3a904803904d134387a0<br>Signed-off-by: Arne Schwabe &lt;arne@=
rfc2549=2Eorg&gt;<br>---<br>M tests/unit_tests/openvpn/mock_msg=2Ec<br>M te=
sts/unit_tests/openvpn/mock_msg=2Eh<br>2 files changed, 11 insertions(+), 0=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/57/1857/1</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/tests/unit_te=
sts/openvpn/mock_msg=2Ec b/tests/unit_tests/openvpn/mock_msg=2Ec</span><br>=
<span>index 8176d2a=2E=2E3e73d19 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/mock_msg=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/moc=
k_msg=2Ec</span><br><span>@@ -43,6 +43,7 @@</span><br><span> </span><br><sp=
an> </span><br><span> char mock_msg_buf[MOCK_MSG_BUF];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+char mock_managment_buf[MOCK_MSG_BUF];</=
span><br><span> </span><br><span> </span><br><span> void</span><br><span>@@=
 -76,6 +77,14 @@</span><br><span>     {</span><br><span>         printf(&qu=
ot;FATAL ERROR:&quot;);</span><br><span>     }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (flags &amp; M_MSG_VIRT_OUT)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        CLEAR(mock_managment_buf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        vsnprintf(mock_managment_buf, sizeof(mock_=
managment_buf), format, arglist);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>     CLEAR(mock_msg_buf);</span><br><span>     vsnprintf(mock_=
msg_buf, sizeof(mock_msg_buf), format, arglist);</span><br><span> </span><b=
r><span>diff --git a/tests/unit_tests/openvpn/mock_msg=2Eh b/tests/unit_tes=
ts/openvpn/mock_msg=2Eh</span><br><span>index da96b212=2E=2E41ce48f 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/mock_msg=2Eh</span><br><span=
>+++ b/tests/unit_tests/openvpn/mock_msg=2Eh</span><br><span>@@ -36,6 +36,8=
 @@</span><br><span> </span><br><span> extern bool fatal_error_triggered;</=
span><br><span> extern char mock_msg_buf[MOCK_MSG_BUF];</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+extern char mock_managment_buf[MOCK_MSG=
_BUF];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> </span><br><span> msglvl_t mock_get_debug_level(void);</span><br><span=
> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1857?usp=3Demail">change 1857</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1857?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I432df6c69249b49=
e9b9a3a904803904d134387a0 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1857 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>=

<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--FyZ3YGsrwUE=--


--===============7219849969909412525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7219849969909412525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7219849969909412525==--

