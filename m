Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C321606A323
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=B6tNN2EU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=X1E3v9XG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jLNN8NHG;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=av2mOla6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+8CWm/oOa1r3m91j9BB1tKpnQjVN5ItkNDmmZAd7sxQ=; b=B6tNN2EUQYm7t1wfoxDxHcSO20
	C5roXEKsQPmExRB1miDnp2lUhMukxuIZF9Pz6OzcDy0O0eI/Me0v3ZX+GM0WQFW4qAsLt1hTtasVV
	zc5Kl+ucrYfCH2Se6rRPmBygepBgp7pJSTksSzWbnkkxwWBzOJCDXNshOajS7H+REENI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVtqa-000000008Gb-3tIn;
	Tue, 24 Nov 2026 16:58:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVtqZ-000000008GP-2vzz
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:58:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=slSPeWJ9agXDNfT+V6jrNbyxPRTZBJ6FKtXkac+4+qM=; b=X1E3v9XGI958T31zh+U3babBjE
 gpoymVneLuO9obE6oigE3YLPLdQ7yx8noQGXRdu5gXO0PDtXLWzwZLK+09ADiqKLvsbD0AMzooyWU
 yJHOr1GokdiQbjriTqvsgN8kuAbsF6pmlEe0cN5i7OCO6bFOsS2/MMXfSdgYrgNKPzpY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=slSPeWJ9agXDNfT+V6jrNbyxPRTZBJ6FKtXkac+4+qM=; b=jLNN8NHGthBfzFWlMXjb4EnKqc
 qEy2MfXeh9ExO5UPlBngNv/ytu0z5YZuRHnS6O+ckheFi920kZuAjUkrCBa0+g6V2jJ3o7E4a11MP
 Zp2fnZKqT0nzWSl25jGXuCYfGgySEGB082SJWcyKSkXX1eMgA5Q08qCN7p8C6+XSZfaw=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVtqY-000000007e4-0Zcs for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:58:23 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso4259362f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 08:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795539495; x=1796144295; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=slSPeWJ9agXDNfT+V6jrNbyxPRTZBJ6FKtXkac+4+qM=;
 b=av2mOla68ttajM54hLz6NSoB6C9a+V4nXYqA/rn18/ae46wpv9R0mjvimwE+uKSazL
 eEwAbY8SJ5SbhZefPqIHc4VAUHN8l09jXtrmK6MT5RoHiClITEokXzBu3ZdzlDTbOu7A
 elQdnN2OJGCXMVvk8KDUCvCPOSkLX89OEQue3sOg+ExSzy0sXsKGUvGVUBW4nLRDzIPX
 R9P8lTV1JT0mPqBHN1+tGUoKr1XuCehcDsdMp2KUSxagQJWP0gUArCzOh0JYeDKuzhAh
 TkuPG+Zbg/MjGb/wVz9sF7I6G1NqDxR8asbdgD5d1CuixbDtf6OkOWi0zUJeusOTlhYX
 MB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795539495; x=1796144295;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=slSPeWJ9agXDNfT+V6jrNbyxPRTZBJ6FKtXkac+4+qM=;
 b=u02wAv9KwPO2Y6UKkZYz/9uoBq2ySFwcKHg3b/+aE+mfRgQHKYFV8uP075iQp4Vwaa
 TWLQ5540Y0KnH6jmpwkdF0Cd2rJSrJn2yb74JUdYATxeOyVOk38JxKtHgLCxiI8lgkM/
 clG8voZjmfpFySM3jW/dHcsU1+tT/T9w1cOc926PVWW741W5GQfnhSCt2qZo1ADYYbDz
 O4XblfWwetCNhJKlBOziTR24aYg4BBdjLk+nl6QoJnLN5Uu/wv/hbOtkukeM2+d5wWUI
 EJckZDk/h+KI68k4uvx2x0/eVEk9j6IejXvv04o8L9JKkh/yAKGMpa2/DvuQWb2TooEk
 PBsw==
X-Gm-Message-State: APuU4Z/fVJXoPFGVd565ZIkDv11ZuCri2nYyJTPBWsFYNmWDHIDdMmpt
 /BKDlXFt3f7MIpZtcGz6epw6dRtc4kkILrLwQKGYI+Ue9sC02HSQ51ExOvUS5mbY8Ls5xa1IMc0
 66AzFB3s1W0U22lMYeJN5u01mXXAjiy9cMICcsFErwBUsDiYnPVjVfi8lvc2aH/ny6DyL
X-Gm-Gg: AZFdTZdBHQn5VgrdmrlS21WcThOVUiws2gb+dr2Rg6AzQ6D1jg3YrqBPf5kgs3ZJQzQ
 J+l9VRuqGgnzHfQyv86yZqH/n20uncfZzIioFmoT5sBnoPGlSEGbPV+48D8MSnnUTwetI+a/Rju
 fObU5LEHOnQC1k5lQShMveoC+Zz1NyAtjc4osZoJfSWvR91KPye3hh2VjcDgMfGjN8OHcbLC+nX
 VyGZYQIVQSU8ZAE8XebY7cHZRrjPQyHgXGMSiK+/QPgC1+gQtx8ELM6pKdLhgbxQwGvdWSeOjBW
 eYYn110fp0Slh9vubevsn2I33/uaRzAecyrAx/dzxaqCHOfkq+on5Edatin3MISQ8y3BEhTYixa
 88TcLOFFzT+fkOSvKxlNfKQzh09tj/+0xqPQvuotetI4VWXloxpWF7TcZXZg/Hag4zzfLxI6Rb/
 x00N8CkIaMeqiMhFm8vqypfFQaMt5tfKAWgNEHvyJ+KrnQjSVlnSRPXb29jc22LuSECT/AoRXwn
 GTUGHm9hvu29wUzNqySpFSS3cM4Gi65IzFqug6NuDgn0K4V5mZpsYjcKaYNw6LDkxFXHMP0N6wn
 CPTbGZQMxEJDtwfNxnFLnD8n7lFHnPjpNC7ygFYskC/+/3ACB7IHDehhs+HVoBW6p5OxS8gGDDO
 HkXetZ2dZLJOjVZLTXF4JanhYF0szFY25Ts9XNrLkmHcU62w61CrDvjD6DSuPhsTOTlqZVzsbJl
 6l5Eu5i3uc8zSQbvU=
X-Received: by 2002:a05:6000:2282:b0:4a7:bde4:4d15 with SMTP id
 ffacd0b85a97d-4abb71cbb96mr30789776f8f.33.1795539495356; 
 Tue, 24 Nov 2026 08:58:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab65cb4341sm29407817f8f.4.2026.11.24.08.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:58:15 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 16:58:13 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5
X-Gerrit-Change-Number: 2339
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2339?usp=email>
X-Gerrit-Commit: 6c639e79beaafa6159e677e587bc82ca01fa34db
In-Reply-To: <gerrit.1795538311000.I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5@gerrit.openvpn.net>
References: <gerrit.1795538311000.I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTM4MzExMDAwLkk4N2RkNDFiNjZmN2Q3N2NhYjdhYWY4MGZhOWQ5MDk1ZTQ2YzAzM2Q1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <500fa4a56686db4dfb04457c58e7da4edc44a43d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVtqY-000000007e4-0Zcs
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: Fix
 conversion warnings in man_write
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
Content-Type: multipart/mixed; boundary="===============7087527985710949378=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7087527985710949378==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1tl5724jpEI="; charset=UTF-8

--1tl5724jpEI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2339?usp=3Demail

to look at the new patch set (#2)=2E

The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by R=C4=83z=
van Cojocaru

The change is no longer submittable: Code-Review and checks~C=
hecksSubmitRule are unsatisfied now=2E


Change subject: manage: Fix conver=
sion warnings in man_write
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

manage: Fix conversion warnings in man_write

Use openvpn_sen=
d to avoid warnings due to
Windows/Unix differences=2E

Change-Id: I87dd41b=
66f7d77cab7aaf80fa9d9095e46c033d5
Signed-off-by: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
---
M src/openvpn/manage=2Ec
1 file changed, 4 insertions=
(+), 13 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/39/2339/2

diff --git a/src/openvpn/manage=2Ec b/src/openvpn=
/manage=2Ec
index addd6f2=2E=2Ee917b35 100644
--- a/src/openvpn/manage=2Ec
=
+++ b/src/openvpn/manage=2Ec
@@ -2448,11 +2448,6 @@
 
 #endif /* ifdef TARG=
ET_ANDROID */
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC d=
iagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
=
-
 static ssize_t
 man_read(struct management *man)
 {
@@ -2550,14 +2545,14=
 @@
 static ssize_t
 man_write(struct management *man)
 {
-    const int si=
ze_hint =3D 1024;
+    const size_t size_hint =3D 1024;
     ssize_t sent =
=3D 0;
 
     buffer_list_aggregate(man->connection=2Eout, size_hint);
    =
 const struct buffer *buf =3D buffer_list_peek(man->connection=2Eout);
-   =
 if (buf && BLEN(buf))
+    if (buf && BLEN(buf) > 0)
     {
-        const=
 int len =3D min_int(size_hint, BLEN(buf));
+        const size_t len =3D m=
in_size(size_hint, BLENZ(buf));
 #ifdef TARGET_ANDROID
         if (man->co=
nnection=2Efdtosend > 0)
         {
@@ -2568,7 +2563,7 @@
         else
 #e=
ndif
         {
-            sent =3D send(man->connection=2Esd_cli, CBSTR(=
buf), len, MSG_NOSIGNAL);
+            sent =3D openvpn_send(man->connectio=
n=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);
         }
         if (sent >=
=3D 0)
         {
@@ -2591,10 +2586,6 @@
     return sent;
 }
 
-#if define=
d(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 st=
atic void
 man_connection_clear(struct man_connection *mc)
 {

-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87dd41b66f7d77cab7aaf80fa9d=
9095e46c033d5
Gerrit-Change-Number: 2339
Gerrit-PatchSet: 2
Gerrit-Owner: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>

--1tl5724jpEI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #2</strong> to thi=
s change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/233=
9?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><p>The change is =
no longer submittable: Code-Review and checks~ChecksSubmitRule are unsatisf=
ied now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">manage: Fix conversion warnings in man_write<br=
><br>Use openvpn_send to avoid warnings due to<br>Windows/Unix differences=
=2E<br><br>Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/op=
envpn/manage=2Ec<br>1 file changed, 4 insertions(+), 13 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/39/2339/2</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/open=
vpn/manage=2Ec</span><br><span>index addd6f2=2E=2Ee917b35 100644</span><br>=
<span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=
=2Ec</span><br><span>@@ -2448,11 +2448,6 @@</span><br><span> </span><br><sp=
an> #endif /* ifdef TARGET_ANDROID */</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC d=
iagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> static ssize_t</span><br><span> man_read(struc=
t management *man)</span><br><span> {</span><br><span>@@ -2550,14 +2545,14 =
@@</span><br><span> static ssize_t</span><br><span> man_write(struct manage=
ment *man)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    const int size_hint =3D 1024;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const size_t size_hint =3D 1024;</span><br><span>=
     ssize_t sent =3D 0;</span><br><span> </span><br><span>     buffer_list=
_aggregate(man-&gt;connection=2Eout, size_hint);</span><br><span>     const=
 struct buffer *buf =3D buffer_list_peek(man-&gt;connection=2Eout);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf &amp;&amp; BLEN(b=
uf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf &am=
p;&amp; BLEN(buf) &gt; 0)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        const int len =3D min_int(size_hint, BLE=
N(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st size_t len =3D min_size(size_hint, BLENZ(buf));</span><br><span> #ifdef =
TARGET_ANDROID</span><br><span>         if (man-&gt;connection=2Efdtosend &=
gt; 0)</span><br><span>         {</span><br><span>@@ -2568,7 +2563,7 @@</sp=
an><br><span>         else</span><br><span> #endif</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            sent =
=3D send(man-&gt;connection=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            sent =3D open=
vpn_send(man-&gt;connection=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);</span=
><br><span>         }</span><br><span>         if (sent &gt;=3D 0)</span><b=
r><span>         {</span><br><span>@@ -2591,10 +2586,6 @@</span><br><span> =
    return sent;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</=
span><br><span> man_connection_clear(struct man_connection *mc)</span><br><=
span> {</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2339?usp=3Demail">change 2339</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I87dd41b66f7d77cab7aaf8=
0fa9d9095e46c033d5 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2339 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--1tl5724jpEI=--


--===============7087527985710949378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7087527985710949378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7087527985710949378==--

