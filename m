Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94D4606A325
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NVUxpPxG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HRw30ZLB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ir9w03++;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eI7/oEB0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=BM7uIxez240X3WZxk3PPhoTftAyg0o3Xyeos4/nnBy8=; b=NVUxpPxG+vzYUB15lnvzciq04p
	W6k9SqZCv+KB3ET+lmjYJiFVzTAzNmmgGyGHKEq8RXAwj1d1hel6utxmUH6zCckW/sTVvY2oKg5/J
	KkG9Ph+pYTgWf7Zl97G+/9hrnxS18YchzgUW5Sb0fnC3E6f5Wg/rsUm0tWW78dkMuvJQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTjjK-000000000B2-1PNv;
	Wed, 18 Nov 2026 17:45:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTjjI-000000000Ad-1kaw
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:45:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eIuyYdQgrJZP0k5cZ/boOTdB0WAy/lEblAPU5XDJ5qs=; b=HRw30ZLB53OJoDsYOVQYN3OoAn
 nu/Hf/1yes96VdMg+kRp1rzeL6JuhpWXtrXrXZqdszB2NogFnlbx9nu7NByFS4e3b4XZkSrlWl3YF
 CRYuucvp0LADxhMLcSZWECQti9mEMlMUPrzd86D4oKKB/+Zy+ykuN4iteSYmwOJ9g2So=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eIuyYdQgrJZP0k5cZ/boOTdB0WAy/lEblAPU5XDJ5qs=; b=Ir9w03++MRnlGEPgKbyojnBS2b
 DJLCFVs++J8gQNOqoTjch1QQLHfO/pO2sSD1jASmipycks8Xzt4bx4nzhKh8JK/6TOuYQoZNPV87K
 8Jr/tlkR6cK+U+UU/AHuRk0Bglq+bn6tg/8vMN/uxtRM4KotjtBB9ouGDXgAeptx0U4I=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTjit-000000005sc-2CDJ for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:45:33 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb61185057so10847265e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 09:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795023925; x=1795628725; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eIuyYdQgrJZP0k5cZ/boOTdB0WAy/lEblAPU5XDJ5qs=;
 b=eI7/oEB0qEPn9cxWMaramv27Z+FFU2Od5HlqaiUHUpQiwDtwcr99TadYAtpCTWV/kd
 seq3FtNYYQnPLFjUyEt0VLTabAiU4bS0z1cukElA4CsPvDj3zMGwKi6aJkIUlDZCKxLI
 8sgzlslqsqIifuYzM/3AtSENKtbFv8TxJF2PVKTPsEYh+f7lXWUqh7HFFZNT+d272zJI
 yJDEKs0qneT+1siuL8DRIwALEaq1SXIe0/98O49imbj/2VH9H10r/nzDYx6V6DoFbIB1
 UCCx5RNt+nk2kvZ12cvnch9LQ/4xN2dspve+Q01CCrj3AfQWXi9jOtcdWo3MY3CLuqeR
 HMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795023925; x=1795628725;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eIuyYdQgrJZP0k5cZ/boOTdB0WAy/lEblAPU5XDJ5qs=;
 b=Fakzm+Bv0giJtIxcu1xa0j+aTBYxT0kJn8SYt7bbKofSxw1mBQ1or4jfmGjEte91/+
 6WrQu/l664WlDhH8ewpL12nuCkd9aIF9CHgCEX41r1HDvoPueAJUP5Yv3oOuaS7YqxEi
 QcKBc5bCADwpXZ4V1FB7d/pN+1IOoltwwe/Itaq+cpwNPs1ZNBsEf32tZ6W6vIjdaz0e
 Hy30LYnl06QyzxaFORPIDxhJ4TyQpkPxsesKPAe2wMOHBRSTkSOI/fwE8H7BWg40BGSY
 ln+fmxMM/xLsIiSmr+uRbINDG2mbQ4/Qqp3Rt7/jdLp1S0Y7T71x27618khdj6E29wiJ
 oi0g==
X-Gm-Message-State: APuU4Z96W7KL2pdWOHTbwgx2/aT+DV+Y3/inptVnrnSJjtmg0YY8RCXx
 Bz96bhw2aJ4ZplMdYJt5E6wzQRqyh1ZUs8DERaiwcUAFWH7FI3HctCRn1He4zRBHnIGonqatWFn
 iIwr4KQt6EJRwh4pL8OIbjk/A1zfg6Y7bVHSmSEook4vVDJ55v/qNhGEYO6G280N5m0HR3IaodK
 7BOFeypA==
X-Gm-Gg: AYBFou1nDMjH0tek5Vpn+rtmPRZA9Ji7+f1tA7X/JcQPmFidE/XTNf86sPGolw9V7O+
 la028hHNEPGVotlfXxdBdN9qcyAhptzeNBdStHK1kCttBI7+IFfjxcOq9uOHq0dhrUPON5N/Y7r
 IpHgBTRMK5Ofjy17ftiHc9VKnG+tRQOVtBx+rv/Fw7I8COb7pvx99qZeZzq4Dfmi9p0Z7v6RYap
 +bS0eh8K8/ENQEppfjlnb+dFaQBZGQDLDkHfrUP4VDgedq99sLBcjoDSNkLdHNCcpvF3NFrbnDA
 rbD/ELgZywwIhPm4BW8XrAPYoOllP5FD92RlzF5LYLaOwYMGlGKgVliWLbuVzA8wAowzZgUJgc/
 tHge4iVXN9zku3uq+eutHdcmb/zKZXXp/DH3iOCW8g7Bop7Tpqdqv15UTD8mMOdWp0MZXHA90BZ
 QKj2r9l6gIZbE2CBwH3EBfxUaOMwMW0kP9YYOYhFXZOXohtgVzy5vBDesBBMAsDOz3MJaEuUkon
 QdYVKlTzzC6ES/IsuSmpC0c/2TDM/ApDW+Ckvz0dimdmQ9Hr4pRIub9q9bznkHNKtvAd8b0eir4
 pswNrapd8vD9FLZgJI4eLYett7Nq4OUqTpScZbVE6yzCb25hU2DI+4tDHPUa1k08qu198FpzSzp
 hfLNz9Z7PBo0f279+Gt+K/e5n91lIw3tn86XLHLvCJ2aJ6+GbS7Fx70lGjapmksHV+GQBGLf1uB
 k02wzmlMmZnYLShPi27xT4Sap8EfB0VPCo3K57
X-Received: by 2002:a05:600c:19c7:b0:4a6:eca1:7d5c with SMTP id
 5b1f17b1804b1-4bb7da5a2d2mr65912045e9.32.1795023924790; 
 Wed, 18 Nov 2026 09:45:24 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb83252d5asm4729235e9.5.2026.11.18.09.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 09:45:24 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 17:45:24 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4571033af79092d85657b176044497245faf5e39
X-Gerrit-Change-Number: 2219
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2219?usp=email>
X-Gerrit-Commit: 9937c88e9ed63eabd2f2d41ef86c7371b5773c7c
References: <gerrit.1795023922000.I4571033af79092d85657b176044497245faf5e39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDIzOTIyMDAwLkk0NTcxMDMzYWY3OTA5MmQ4NTY1N2IxNzYwNDQ0OTcyNDVmYWY1ZTM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <36a61c252b0d8e8abff71f59f27add8c499ce572-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTjit-000000005sc-2CDJ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: let the
 interactive service add routes again
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6203207940663418817=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6203207940663418817==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tZq9y2NWxKg="; charset=UTF-8

--tZq9y2NWxKg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2219?usp=3Demail

to review the following change=2E
=


Change subject: options: let the interactive service add routes again
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: let the=
 interactive service add routes again

Since c139e82d the service puts --ms=
g-channel in front of the user
options, a --route-method from the config ov=
errides the service
route method implicitly set by --msg-channel, and addin=
g routes
in turn fails without admin rights=2E

Force the service route met=
hod in postprocessing when --msg-channel is
used, independent of the option=
 order=2E

Github: OpenVPN/openvpn#1151
Change-Id: I4571033af79092d85657b17=
6044497245faf5e39
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
=
---
M doc/man-sections/windows-options=2Erst
M src/openvpn/options=2Ec
2 fi=
les changed, 12 insertions(+), 0 deletions(-)



  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/19/2219/1

diff --git a/doc/man-se=
ctions/windows-options=2Erst b/doc/man-sections/windows-options=2Erst
index=
 8d7dcbb=2E=2E87c7008 100644
--- a/doc/man-sections/windows-options=2Erst
+=
++ b/doc/man-sections/windows-options=2Erst
@@ -179,6 +179,10 @@
   :code:`=
exe`
         Call the route=2Eexe shell command=2E
 
+  When OpenVPN is st=
arted by the interactive service, the service adds
+  the routes and a ``--=
route-method`` given in the configuration is
+  ignored=2E
+
 --service arg=
s
   Should be used when OpenVPN is being automatically executed by another=

   program in such a context that no interaction with the user via display=

diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 94743=
9d=2E=2E09a9d522 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/opt=
ions=2Ec
@@ -2494,6 +2494,14 @@
         options->ifconfig_noexec =3D false=
;
     }
 
+    /* the service adds the routes, --route-method must not ove=
rride it */
+    if (options->msg_channel && options->route_method !=3D ROU=
TE_METHOD_SERVICE)
+    {
+        msg(M_WARN, "WARNING: ignoring --route-m=
ethod, routes are added by the interactive service");
+        options->rou=
te_method =3D ROUTE_METHOD_SERVICE;
+    }
+
+    /* this depends on option=
s->route_method, which is set above */
     remap_redirect_gateway_flags(op=
tions);
 
     /*

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2219?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I4571033af79092d85657b176044497245faf5e39
Gerrit-Change-Number: 2219
Gerri=
t-PatchSet: 1
Gerrit-Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>

--tZq9y2NWxKg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2219?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">options: let the interactive service add routes again<br><br>Sinc=
e c139e82d the service puts --msg-channel in front of the user<br>options, =
a --route-method from the config overrides the service<br>route method impl=
icitly set by --msg-channel, and adding routes<br>in turn fails without adm=
in rights=2E<br><br>Force the service route method in postprocessing when -=
-msg-channel is<br>used, independent of the option order=2E<br><br>Github: =
OpenVPN/openvpn#1151<br>Change-Id: I4571033af79092d85657b176044497245faf5e3=
9<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<=
br>M doc/man-sections/windows-options=2Erst<br>M src/openvpn/options=2Ec<br=
>2 files changed, 12 insertions(+), 0 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/19/221=
9/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/doc/man-sections/windows-options=2Erst b/doc/man-s=
ections/windows-options=2Erst</span><br><span>index 8d7dcbb=2E=2E87c7008 10=
0644</span><br><span>--- a/doc/man-sections/windows-options=2Erst</span><br=
><span>+++ b/doc/man-sections/windows-options=2Erst</span><br><span>@@ -179=
,6 +179,10 @@</span><br><span>   :code:`exe`</span><br><span>         Call =
the route=2Eexe shell command=2E</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  When OpenVPN is started by the interactive=
 service, the service adds</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  the routes and a ``--route-method`` given in the configuration is<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ignored=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --service=
 args</span><br><span>   Should be used when OpenVPN is being automatically=
 executed by another</span><br><span>   program in such a context that no i=
nteraction with the user via display</span><br><span>diff --git a/src/openv=
pn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 947439d=2E=
=2E09a9d522 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br>=
<span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -2494,6 +2494,14 @@<=
/span><br><span>         options-&gt;ifconfig_noexec =3D false;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* the service adds the routes, --route-method must not overr=
ide it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (op=
tions-&gt;msg_channel &amp;&amp; options-&gt;route_method !=3D ROUTE_METHOD=
_SERVICE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quo=
t;WARNING: ignoring --route-method, routes are added by the interactive ser=
vice&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 options-&gt;route_method =3D ROUTE_METHOD_SERVICE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* this depends on options-&gt;route_method, which is set above */</sp=
an><br><span>     remap_redirect_gateway_flags(options);</span><br><span> <=
/span><br><span>     /*</span><br></pre><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2219?usp=3Demail">change 2219</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2219?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4571033af=
79092d85657b176044497245faf5e39 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 2219 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 =
</div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=
=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--tZq9y2NWxKg=--


--===============6203207940663418817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6203207940663418817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6203207940663418817==--

