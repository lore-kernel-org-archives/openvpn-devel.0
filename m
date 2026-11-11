Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A595606A331
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bQVN/xmh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OHuCTcEA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mys8TLuf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UNQ+xlc/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=LmWPgMnCNU23dhWqsoTj4geVi+c1VziBcGJgrcZ5BfM=; b=bQVN/xmhnb3c1JJP0LjGaTDEkS
	17R/Ru5sejz9zn5MLspIBS+kzHs6z3QbDNxT46hdYH18hRwkAEvpCV+vcho3gjK+p06ETLZGahOak
	Mv6gahx5QmjvVXRRR5MdzgKKeqU1KupH13drED39YNjpa6pVgbcfzho3bO8sJdsQJedw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR42Q-000000004k4-2KRO;
	Wed, 11 Nov 2026 08:50:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR42E-000000004j7-3h97
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:50:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I+LjDUzBW16se7XDZbdM2zieqHkgUps8Ya0yCYkU2fE=; b=OHuCTcEAE7OMYxMPrPzPckeceM
 Dy1QzVbUgq9ni22YxLOxkxqi+xN8psvWgs6vuMf97sOeo0tM1q/YTggsYXCc9L/xEOUACNRNa8msx
 TkbdXh/E4X4+s3XYNxMsfsC7R10LKHMIajD+Zx6ygDHACJL0LxamUNLA8FwmQvpaYd9o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I+LjDUzBW16se7XDZbdM2zieqHkgUps8Ya0yCYkU2fE=; b=mys8TLufGSXGf6bvCXTFeu7hyn
 MiadayeqiVz36ceAL59KlhWyQL/LLCPP//Gsei+JE9cRTp1VzvXvfCehUGyeL8heSUoJJV38n9C2O
 AGE2azPy/xpLatBf+MZ97Htve51eRPMz9ilLUS/faaUzlnXtj3dMxZ7iw7FqJUIqPzns=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR42D-000000006yD-0Tvr for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:50:26 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso20146595e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 00:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794387018; x=1794991818; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=I+LjDUzBW16se7XDZbdM2zieqHkgUps8Ya0yCYkU2fE=;
 b=UNQ+xlc/005i3kRJEVdYcHB26Rm6PwiiEkJxOGSTlxgfsEA81dW4XgDxHuiTNM7Ncp
 nlQoO75TqzRu/Dn4gCJDAaioTYScN+/RX2+DuyL920lorfx7AcY6I/I/Tqb0w7Y3Q/kZ
 pefFO2Xvji0i9KK35DbIwc0IJBCG4+aXELTagyEa6UNGwIh7sTHz075mJ3jw2vLYdd39
 9osWdlSrE+1D1kE+5K889FXyZW7hOcZ/u9/mNOnez4z5pH8/6p7Tr8MXsGktTO3Mr3A+
 f+Dr85alMagVJzmEkei4M8gW2n7Pf67WSYPKMtQNP7sUWuW7AdqIYlkIphn8C+dDWEb8
 j04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794387018; x=1794991818;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I+LjDUzBW16se7XDZbdM2zieqHkgUps8Ya0yCYkU2fE=;
 b=Ki5xyim7J3y57Q4EUioja/jsn7oxz/o3YlWGbmnfZAnQgQ4jXfcqRQAnQdC5s6wAb5
 D5tQoWjlLVoekEbB1rgaUZrobK2TSBU77R4KfhOpgBGn7hIegLuJQki3fjurrlKeMivs
 HaF37fLIYTMyugFQ60/LX8yT/RkqxxCOQ23TMpPZfziNfVw8FJlDhlAUHAEXOnRl3Tfa
 hQQ7Q+ui2HOHghsZL2Gzh1Nt4wFPi1saIWnxw43Pc80uRycmmglQjaBkCNbsb4DfdLmS
 bnovxfeRiYUvoJT7yxbhP0wUj3c7Tm0BMop7W0EW193W+cPGEeqJWMH7w56/fMEJe4Q8
 x1Bw==
X-Gm-Message-State: APuU4Z+HNV12JCkCNyQWSYoQ1zwoMzDmioC8SYwfsyxlk1uPMyVeCn/4
 hHbszAJqaJJB6JGJUYyKVJh1R2GO+uISMbICg1ASMgE4SopWSDC1MKyBPT2N7REoWTqXjr2ERRe
 yjm89Gu8GNTUGhn/NB4vBV6DT/1fJNtSV+asw7EuPDt95wKiknPsfDFC+DE2UYWzGS4qq
X-Gm-Gg: AYBFou0J1DwgcEGvhbgS9wNBNjXNb3/ikE1Oae3tiv1J7IWRDfKVpogUlbDda5vUgTd
 eD23GD//kiEChLsCyL4cQXHkf5941bFMPJ1c9niCu6z1stt8Z03l/TfwSpcj3bXYWIIyT4Hjwdf
 bpFDdPX6rodjP+g3aAiG9WxrIp4DRMQnkdOcjRy3VZNtqQDluI9HOu8KRYQiOSBLFaIvAJpXpuj
 RedlEzk06Fajl56SJvTz+S48YeGwfPzbjpu9mmxq0iuWLtjiFu2R4l7xSwu431ghIaKYXvkH+8L
 DDssFR+8CD9ORcyvybxDGN1bxt48QxJnufHhbNRRbVn+uwwufBi63gZFjRi0SSsXZS/HwR99PkN
 hb4NadsuGAejF6w1JO0kUCZodFzk8aUp7xLGvwbyPsSfzwb81v6o9s5rt7Xcou/4I6F+OK7XXba
 Ah1O1xEVWobWFdeLZKeZ5lz9CO9CXfyH7atATlsIJ5obD0M1oeWYN5KXZ/qmP2t8mr97wlHMTot
 qDxC+v22NmVH9arC/cHvSe6NDVn5l3Yffpm4vpnofpWxvowj3OQuPY4LF1B0wWbClYLGQI1cBFc
 Pt6ynXQyqvZN7OQ1RbDwtZgW6iqIiiVhWsX/t+Db8U+SFaSUSjLQW8JOEvk1fgOO67HTGQMqRED
 PjO1eRWpnTecIy5toBxZSNzQapRUt+pc+ONSh1+tMorZmgifnwSconI1UiE8vwb8C36DtdTTVq6
 LpgEXEZeLSVJrao1w=
X-Received: by 2002:a05:600c:3485:b0:4a5:a5ca:de1d with SMTP id
 5b1f17b1804b1-4ba093a9321mr32355645e9.30.1794387018313; 
 Wed, 11 Nov 2026 00:50:18 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fef1d0sm119939675e9.13.2026.11.11.00.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 00:50:18 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 08:50:17 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I19904af95d0b9efa868d42050f7187565c7f7a23
X-Gerrit-Change-Number: 2172
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2172?usp=email>
X-Gerrit-Commit: 353b6c910ede8d4073d2c53b89561c558f423e7b
References: <gerrit.1794387016000.I19904af95d0b9efa868d42050f7187565c7f7a23@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzg3MDE2MDAwLkkxOTkwNGFmOTVkMGI5ZWZhODY4ZDQyMDUwZjcxODc1NjVjN2Y3YTIzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f2f55fab2b3bd73f2429d99708455372eb3e8607-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR42D-000000006yD-0Tvr
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: init: close AF_UNIX
 tun on SIGUSR1 with --persist-tun
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5134784719983496252=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5134784719983496252==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l1GmXI3djw0="; charset=UTF-8

--l1GmXI3djw0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2172?usp=3Demail

to review the following change=2E
=


Change subject: init: close AF_UNIX tun on SIGUSR1 with --persist-tun
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

init: close AF_U=
NIX tun on SIGUSR1 with --persist-tun

can_preserve_tun() never keeps an AF=
_UNIX tun, but do_close_tun()
skipped closing it on SIGUSR1 with --persist-=
tun=2E do_open_tun() then
reopened over it, leaking the socket fd and actua=
l_name and leaving
the old child process running=2E

Change-Id: I19904af95d=
0b9efa868d42050f7187565c7f7a23
Signed-off-by: Razvan Cojocaru <razvanc@mail=
box=2Eorg>
---
M src/openvpn/init=2Ec
1 file changed, 3 insertions(+), 1 de=
letion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/72/2172/1

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
in=
dex 3bc4de4=2E=2E7ac4803 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvp=
n/init=2Ec
@@ -2044,7 +2044,9 @@
 
     run_dns_up_down(false, &c->options,=
 c->c1=2Etuntap, &c->persist=2Eduri);
 
-    if (force || !(c->sig->signal_=
received =3D=3D SIGUSR1 && c->options=2Epersist_tun))
+    /* AF_UNIX tun i=
s never preserved, see can_preserve_tun() */
+    if (force || !(c->sig->si=
gnal_received =3D=3D SIGUSR1 && c->options=2Epersist_tun)
+        || c->c1=
=2Etuntap->backend_driver =3D=3D DRIVER_AFUNIX)
     {
         static_cont=
ext =3D NULL;
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2172?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
19904af95d0b9efa868d42050f7187565c7f7a23
Gerrit-Change-Number: 2172
Gerrit-=
PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>

--l1GmXI3djw0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2172?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">init: close AF_UNIX tun on SIGUSR1 with --persist-tun<b=
r><br>can_preserve_tun() never keeps an AF_UNIX tun, but do_close_tun()<br>=
skipped closing it on SIGUSR1 with --persist-tun=2E do_open_tun() then<br>r=
eopened over it, leaking the socket fd and actual_name and leaving<br>the o=
ld child process running=2E<br><br>Change-Id: I19904af95d0b9efa868d42050f71=
87565c7f7a23<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
;<br>---<br>M src/openvpn/init=2Ec<br>1 file changed, 3 insertions(+), 1 de=
letion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/72/2172/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=
=2Ec b/src/openvpn/init=2Ec</span><br><span>index 3bc4de4=2E=2E7ac4803 1006=
44</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/ope=
nvpn/init=2Ec</span><br><span>@@ -2044,7 +2044,9 @@</span><br><span> </span=
><br><span>     run_dns_up_down(false, &amp;c-&gt;options, c-&gt;c1=2Etunta=
p, &amp;c-&gt;persist=2Eduri);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (force || !(c-&gt;sig-&gt;signal_received=
 =3D=3D SIGUSR1 &amp;&amp; c-&gt;options=2Epersist_tun))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* AF_UNIX tun is never preserved,=
 see can_preserve_tun() */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (force || !(c-&gt;sig-&gt;signal_received =3D=3D SIGUSR1 &amp=
;&amp; c-&gt;options=2Epersist_tun)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        || c-&gt;c1=2Etuntap-&gt;backend_driver =3D=3D DRIV=
ER_AFUNIX)</span><br><span>     {</span><br><span>         static_context =
=3D NULL;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2172?usp=3Demail">change 2172</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2172?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I19904af95d0b9efa868d420=
50f7187565c7f7a23 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 2172 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>

</body></html>
--l1GmXI3djw0=--


--===============5134784719983496252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5134784719983496252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5134784719983496252==--

