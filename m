Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ADB606A684
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iLfbJ8kB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=a5ks1v/8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TRAXv+/q;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IQIiDBcx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UnEB+86h9lvpHJeD4HZSsyK6FnoYJljW/PQBsE+3wso=; b=iLfbJ8kByR30w01paADvHAzG7X
	3Vg1KHg/mHbAUIV6Vl+KAS0dFVp1efv3833MH6u+0RzU+KJ7B5YENQ2t6fRbBauZGV4FYaxm5s0wQ
	YiBGPnl/BD6MSElh0vz8RNVsKgS2yTZ3T0t8I7SE6VLBflAbZPzED6HAVCEqSegC9bto=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV6t1-000000001o6-0jsv;
	Sun, 22 Nov 2026 12:41:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xV6sz-000000001nQ-3XCY
 for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 12:41:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cQtQnkEZaE11IBzV+mHMnytg+PirhITw7J0/NZP/7wQ=; b=a5ks1v/8lSZ8e9SE3eTeLG1p32
 jFfLDS3v9VUenS/ZHwA9csKATSBYx2K3ykucYXv0ywg1a92wVlTFO0eaxz2ryBvrxqSImieZdnwDa
 Rof5Ysacma+5D+E4FA8PjSqtuHSJ701mWF6Z8TjoUlkdKFezZpdpqiPCvmJqFk7rVPUE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cQtQnkEZaE11IBzV+mHMnytg+PirhITw7J0/NZP/7wQ=; b=TRAXv+/q43bUbMLMdhEglRQfSs
 2Cv4zq9+oPlcnDj6QERaOSrDo2x7ZGktC6RddRg2BjGjmAn4CEoYHgivd5NLrz+3rnH/hlnwC8aNE
 9Y/y/iHkB8m1J99/C+FqE54UltBw1VCr+UO+xRwbA0/TDKtkuUfyOGT2oFCmd3ryFvX4=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xV6sR-000000000hn-2Xrn for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 12:41:05 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso1551238f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 22 Nov 2026 04:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795351257; x=1795956057; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cQtQnkEZaE11IBzV+mHMnytg+PirhITw7J0/NZP/7wQ=;
 b=IQIiDBcx8Ws1CCANyaiOqLkHG8hkmyDt6ukb6QhLKeq0kX7nr158Xb77WxuIaFQhL1
 Jq3tQM4rn11uYKQjc7PAT7TF5baufKcIqw4NUMsnVtS9mmbN+zCmX26GRGnIO9dO98rd
 YTtOsgNhbkWYbotOJ9IQO0BJgM45+jIOPCO7+bFjI5o6KD2ZNv6Vat8hnhDNZB0Q4ugq
 KXHLNU19ibLOKU5Y3bnyLQP7HNkELe7WSYv3PxRe5I/cGgIy+5To/v5bgucJl7Igb1ly
 L+RQoQUqLr8qNGSuKwWXD5T8kYlbIjhyud6Ou5UX6x0M/M2aaRlTHn7szpbKNEXkYRjl
 sUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795351257; x=1795956057;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cQtQnkEZaE11IBzV+mHMnytg+PirhITw7J0/NZP/7wQ=;
 b=z8oNosnFeRD4issAZLyWjQg06B/4NqjOgmJwvLqTjhRyPPhqrtuVdHSPrOxb+K8EDV
 jXf5l5r5V1UMb3SLhNwjKoHQKkwtMjrnIk7WXdinvZqHX7/xDUg+QgH7sfCL2qXZUB4J
 v+j/XNBLsGxsqAey19cuybyQGPrGedSaZEGV/W04dyh230RDYeL0X9/OkPlEfn1JcS0W
 hHdRids+8w7EeEiXrNe61JGu2rwVyKgLb5HOAQ6j6Oor/CQ9mW/YJEQTSRbd5lfOjYHG
 pGhqktNf+MeDEUhJGqwOSDMNyp0phb37+LHRWkmit7L2ArXB9Ex9NhEQ8ce7g+z0ibjq
 eilg==
X-Gm-Message-State: APuU4Z+kNqXGMfZQd8uYh6ouWrQmK48Ydi8Ef+UaJw2+PeVHunqDwU4M
 R4q6p2lltItLs6uWzdoie/An4ewrerXg3o8UlSddhHqsU/CiAQrx2iWGl97mrF9Co/eGWQKCN0c
 TG4HyReerncbk1lpP3zZfImN28JYndrbzU5NUsWi2MoQxaCMvo9dCUa+6djk6hy+73iMLhIWNko
 1vySdsRA==
X-Gm-Gg: AZFdTZcGjy59tyTwJ/UWWdPiGsNCBZSB9YRZE2SCzBPMGaU/Hzo+H+4XwqKKSnWP8q0
 9+4RjA8uwvCw3MQxON9LrU+QYW9Vu6E0lEn9c+ty/3JRYsc/VJ6vTMzfTEkGQ3I8mmwlyKOs8el
 Dm1usJXBTxKHnrHmKZ2CJzmrB1WwmRwAqsnkpCPGO2t7T2quyJEVVYufazbxiP6roCfVjx3t0i7
 tyg+M3oz50oGNtnQAVoTJ1Cl7WliousRRF30h3SJY3i7Oko9y6Z1ivbgWgdWozpAQLxx/F3gUKy
 FzW4wOuPELzvqEnMSW1VoFvax1OzDohKtTDbtPIlg2x3KtBWyhogh0fuGUk8P+3WIlMMWcQU2vW
 0Psx7NHlugxMBHCTtpEeNAGIrEHaEjz0K07wIJacsR1+ehUOH4sgLx4r6pr4/0kVwA2+EmoTsGR
 2O3NcMy1EYXTU0I0z85Qe7AYXPouzTV+3J1u77s6HXKc+1xR3Y3wZ8RVGvAwMab1YtDEpr+fCOM
 9+d/IMkNDy28R2glUheK4P95e0PozJ/OLnaiASUpnKfjA4hrqKCyjJXh420pRFvJdWcSSfELOl9
 JW6uOM/6GlUYsnTVWQUeYhNZUK5xB34fmA3ImD0Ah2xN3WErI/fopMpiD50QgtPH3lyaTm46Mz3
 llFRqV5AFM+IOPVY2jRhij1ktuxpy12+epUzybbWVjleGmbaJRnRduy92RpbzjwKI/Qr/6fVFr7
 4wf1u8wwokxzoG9wUrKJpCHFrlR/okIiYhq+wc
X-Received: by 2002:a05:6000:18ab:b0:488:7787:469d with SMTP id
 ffacd0b85a97d-4abb47b24dcmr16657649f8f.25.1795351256893; 
 Sun, 22 Nov 2026 04:40:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab65cb41f4sm16008898f8f.7.2026.11.22.04.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 04:40:56 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 22 Nov 2026 12:40:55 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie5336121e8a48e5a63b509d6a30349be42d311f9
X-Gerrit-Change-Number: 2216
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2216?usp=email>
X-Gerrit-Commit: 4a724c44388106379e80830cc0418015948fb989
In-Reply-To: <gerrit.1794990920000.Ie5336121e8a48e5a63b509d6a30349be42d311f9@gerrit.openvpn.net>
References: <gerrit.1794990920000.Ie5336121e8a48e5a63b509d6a30349be42d311f9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkwOTIwMDAwLkllNTMzNjEyMWU4YTQ4ZTVhNjNiNTA5ZDZhMzAzNDliZTQyZDMxMWY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a13c4d98b72471c98090fe9851584f6af126e3ce-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xV6sR-000000000hn-2Xrn
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_openssl: don't
 log inline CRL contents
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
Content-Type: multipart/mixed; boundary="===============0562904197910483238=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0562904197910483238==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AAof/h6/HsE="; charset=UTF-8

--AAof/h6/HsE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2216?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: ssl_openssl: don't l=
og inline CRL contents
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

ssl_openssl: don't log inline CRL contents

With an inline <crl-=
verify>, crl_file holds the PEM data, and the
"CRL: loaded" message printed=
 all of it=2E Use print_key_filename() as
the other CRL messages do=2E

Cha=
nge-Id: Ie5336121e8a48e5a63b509d6a30349be42d311f9
Signed-off-by: Razvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2216
Messag=
e-Id: <20261118151224=2E14866-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41613=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
ssl_openssl=2Ec
1 file changed, 2 insertions(+), 1 deletion(-)


  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/16/2216/2

diff --=
git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index e2b65=
bd=2E=2E03e0279 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/=
ssl_openssl=2Ec
@@ -1410,7 +1410,8 @@
         }
         num_crls_loaded++=
;
     }
-    msg(M_INFO, "CRL: loaded %d CRLs from file %s", num_crls_load=
ed, crl_file);
+    msg(M_INFO, "CRL: loaded %d CRLs from file %s", num_crl=
s_loaded,
+        print_key_filename(crl_file, crl_inline));
     ssl_ctx-=
>crls =3D crls;
     BIO_free(in);
 }

-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2216?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: Ie5336121e8a48e5a63b509d6a30349be42d311f9
Gerrit-Cha=
nge-Number: 2216
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--AAof/h6/HsE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2216?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">ssl_openssl: don&#39;t log inline CRL contents<br><br>With an inline &l=
t;crl-verify&gt;, crl_file holds the PEM data, and the<br>&quot;CRL: loaded=
&quot; message printed all of it=2E Use print_key_filename() as<br>the othe=
r CRL messages do=2E<br><br>Change-Id: Ie5336121e8a48e5a63b509d6a30349be42d=
311f9<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Ac=
ked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2216<br>Message-Id: &lt;2026111815=
1224=2E14866-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archi=
ve=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41613=2Ehtml<br>Signed-=
off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvp=
n/ssl_openssl=2Ec<br>1 file changed, 2 insertions(+), 1 deletion(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/16/2216/2</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/=
openvpn/ssl_openssl=2Ec</span><br><span>index e2b65bd=2E=2E03e0279 100644</=
span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/=
openvpn/ssl_openssl=2Ec</span><br><span>@@ -1410,7 +1410,8 @@</span><br><sp=
an>         }</span><br><span>         num_crls_loaded++;</span><br><span> =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_INFO, =
&quot;CRL: loaded %d CRLs from file %s&quot;, num_crls_loaded, crl_file);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_INFO, &quot=
;CRL: loaded %d CRLs from file %s&quot;, num_crls_loaded,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        print_key_filename(crl_file, =
crl_inline));</span><br><span>     ssl_ctx-&gt;crls =3D crls;</span><br><sp=
an>     BIO_free(in);</span><br><span> }</span><br></pre><p>To view, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2216?usp=3Demail">cha=
nge 2216</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2216=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: Ie5336121e8a48e5a63b509d6a30349be42d311f9 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2216 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body>=
</html>
--AAof/h6/HsE=--


--===============0562904197910483238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0562904197910483238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0562904197910483238==--

