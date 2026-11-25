Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7544F606A326
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CUIAAcOD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XLE1NskW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GeUQxolo;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Z91ruIFM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=R9zwSXAufCkVY5CiQsW2dNwwgiXGBpk6aix/l3sppxk=; b=CUIAAcODkDSaoilFCPyFjXYsmN
	/A93NTFYtgQsPS5IRJnFiw1eR9guwF3OG5CPFp0XpqegPHtooGCN447jPjaXxarAsh9lHy39C6rrH
	CpEWuxNvIghs2Qh2rEqDmXZJQQdUXXpYujmFzkDgZyDF8McYMe0JytZC+2fokw2bbIP4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWFro-000000003Mo-3aDz;
	Wed, 25 Nov 2026 16:29:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWFrm-000000003Mg-1cgM
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:29:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RmdR1FWvjIol1DMGTUyNKk4Dum51G+xXk56oyKSpXy0=; b=XLE1NskW8SgjWhHz07fyTjHpTe
 ftC3XAI4uV4IIzY/8zefD11SsPaD3N+WSn7gubUSrAtwiEWVrwKRNdipsGdAUPodqY11YyzcJE3oT
 01Etj3g/jh3lf1Q5eUR2cq47nKx7d1aJTxG6uqg99x1dyCfEVnXf1/Nk2bMGg+vMdIX0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RmdR1FWvjIol1DMGTUyNKk4Dum51G+xXk56oyKSpXy0=; b=GeUQxolopU1kMA7EVf2BgePRyL
 nQFsIxdqXwl3RKkTdsyl/1QSzHnM+cNpFAksENuvfQwxCyC2OPHsRVYMzxlDt657Ia39uqeO7wSiW
 GLcxuI2MK3WJxjfTJoJNwspjQYGn7FV5EGAzx9oHhvSMOIw4m3Q4gKWUFdNI05pViSjQ=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWFrj-000000004KM-259g for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 16:29:06 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4a34ffd3e39so3280829f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 08:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795624137; x=1796228937; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RmdR1FWvjIol1DMGTUyNKk4Dum51G+xXk56oyKSpXy0=;
 b=Z91ruIFMTrnQzztmH3kyG5Y6CLSvCfdfU5esIIjT/fMr4JzHcRDGvlu9/G8Ah+v5RP
 onk1gQD3/YMLFJ5rGCYZ9Mlq8NTkv43F78Y3wSr8m0mrtU4eLNBcsf3mZnzDGd7bkZL2
 dqA3RB9KHek5qBDATSNXjCF2g5amoSgnfl1p5jOCDTE872xrIrkl25ze80eTrW14/0OQ
 ba6+ekoPVnPpNLZZEthXxktda71sAjPeP3yyGs4x1eHDJxV/r2hdfyvwNmRfm61GT1Ks
 7bK+fIfJClRghegb2TM6nOSHO3pmJcTf59kViN91xxIVElSKcGI0wKSN+ybSCdgdg0Oj
 rEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795624137; x=1796228937;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RmdR1FWvjIol1DMGTUyNKk4Dum51G+xXk56oyKSpXy0=;
 b=Zxpc94x3eQGwje6HPwxWDJRlwEpBK7rnCPj+sCQKBFUHjcUTNqXdj5PtYPzn3EWa8C
 GMcblpYa7W+wVTfmO96KlKfeOYDwoqlF70oW5sdKK116WuMXy1DABn0rCwjtvEL9t9eR
 5Xhk+w8/vQu73A7ahZjubUNhTwFDYUnSsUSEaIKduN2aAFnkOQ5XwpFmwLfsFue23ln2
 RgWIYwATzYPnPhxaquU9t09pHhm8yutMGUtYYwhisek1LVFW5a5ISZZqDubCG5+4ega1
 mSqczbg79ptRkhi81QjnWL4/C9kFLbsXp2jRQoQrGBPznwBBQks4nR3F2hjOT0NewOcW
 R7Jw==
X-Gm-Message-State: APuU4Z+O+BBA6+Jo71NrLQkIXViZd3mNvPWXLbWXKLYXujiZqcG3mCKH
 m92X1l9IULTl/cRNqyiDRBbEMJgPqEcdKd1ofTVinEmBqg5aApSdi0dBwSUBqE7SzqXvepEgc0V
 0hHiKCV3wvkuNLBx/+pRI/Z7rlrQHkg6Fq0yBDUb1oQvbF4kSJU58VsX05qEYEz7VzjCbhM7EEr
 XzFEgxEQ==
X-Gm-Gg: AZFdTZfSZ9+BlBU6f4P45+tD2MjjPmylYxlMkWEptuDYslVDyCpwDbqP0xSxQo6JBA+
 3yB4rOqLcYZ6G6CTiybngt/dFPs0W6bxSkjKnWkk5Mlp55DrDDKB31E3XRiDGbWsnS8vd+RBtYC
 V1dlE9gSoy/GaztUW5BjOCERjW+ON5wDFN5cenWHrCoGp3bDEzdgJkw64+K6K7Oc3Yf91lBN2Tg
 fpPu9i2Ot9H6ZCQIY8fwJsDGlYYTY40CtnRPwq/1DDvuEyvnoph4OLlvYK2H1QPhvqDV900AMSJ
 bZryqigQlH+WvdxtkeEK+UaaoFxjN5iDK5yNyvIfOeLQcgMTs5abfUsycOjXhhhty6iGnw8y41R
 2BYXGdZFriZLD95srjR5LY9dhSQOAtPCKlpX6vD+GXfkmux8EiuaBDXBMlJnLcHRvN8hloKhBjw
 M7PAfS/oFDGvgZ41F0hlIC5w+1ZgC+yozEiMYZc3gO2tHOqcUyA7mbUaW9SbExrNayPLOBZDOfO
 m16/e7B4izxk094VqpKSxLn/8agqgYRVx5Mc20YaogB338xRi/BUe+/FIM2nrFt6cnFs+dLdJKz
 mSslFfCL2JlrAuQgukswFT2LnRKnOIvjhNaLlImzk2D2TLz9sgLEXkPM33PgcWrH1ehyjOfcVQm
 g3dUBlnbLRI3jck6p7OhVI8FHDEA+NyppDsbXIAwnJ52fqhug8wIL/xbqPy2wlXvDZMx2EzxE4t
 ADBs8xnlLCZ42fEeo5
X-Received: by 2002:a05:6000:2c0a:b0:4a7:73d5:703a with SMTP id
 ffacd0b85a97d-4abb1ab66d9mr36156980f8f.23.1795624136752; 
 Wed, 25 Nov 2026 08:28:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2c8csm36309347f8f.2.2026.11.25.08.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 08:28:56 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 16:28:56 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8799b8f81945d643bb340a334b1891a5e625c2b9
X-Gerrit-Change-Number: 2345
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2345?usp=email>
X-Gerrit-Commit: d591fa6b305d7301fb5d2d8ca4f99a43335febc4
References: <gerrit.1795624133000.I8799b8f81945d643bb340a334b1891a5e625c2b9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjI0MTMzMDAwLkk4Nzk5YjhmODE5NDVkNjQzYmIzNDBhMzM0YjE4OTFhNWU2MjVjMmI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1daad81ea5e1a4379b8058ddb8def2ba6a45fc64-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWFrj-000000004KM-259g
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify: fail
 deferred auth if AUTH_PENDING cannot be sent
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
Content-Type: multipart/mixed; boundary="===============2401232413270767240=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2401232413270767240==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P0s+kUoNc/k="; charset=UTF-8

--P0s+kUoNc/k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2345?usp=3Demail

to review the following change=2E
=


Change subject: ssl_verify: fail deferred auth if AUTH_PENDING cannot be =
sent
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_ver=
ify: fail deferred auth if AUTH_PENDING cannot be sent

key_state_check_aut=
h_pending_file() ignored the return value of
send_auth_pending_messages()=
=2E When it failed, e=2Eg=2E on an oversized
INFO_PRE, the client got no IN=
FO_PRE, yet auth stayed deferred until
the deferred window ran out=2E

Fail=
 the auth instead and tell the client why, as for an unsupported
pending me=
thod=2E Document the EXTRA length limit=2E

Change-Id: I8799b8f81945d643bb3=
40a334b1891a5e625c2b9
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg=
>
---
M doc/man-sections/script-options=2Erst
M include/openvpn-plugin=2Eh=
=2Ein
M src/openvpn/ssl_verify=2Ec
3 files changed, 8 insertions(+), 4 dele=
tions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/45/2345/1

diff --git a/doc/man-sections/script-options=2Erst b/doc/man=
-sections/script-options=2Erst
index 474c7fd=2E=2Ebc8ac2b 100644
--- a/doc/=
man-sections/script-options=2Erst
+++ b/doc/man-sections/script-options=2Er=
st
@@ -149,7 +149,8 @@
   :code:`auth_pending_file`=2E The first line must =
be the timeout in
   seconds, the required method on the second line (e=2Eg=
=2E crtext) and
   third line must be the EXTRA as documented in the
-  ``c=
lient-pending-auth`` section of ``doc/management=2Etxt``=2E
+  ``client-pen=
ding-auth`` section of ``doc/management=2Etxt``=2E The EXTRA
+  must not ex=
ceed 1014 bytes; if it does, authentication fails=2E
 
   This directive is=
 designed to enable a plugin-style interface for
   extending OpenVPN's aut=
hentication capabilities=2E
diff --git a/include/openvpn-plugin=2Eh=2Ein b/=
include/openvpn-plugin=2Eh=2Ein
index dde5dea=2E=2Ed108779 100644
--- a/inc=
lude/openvpn-plugin=2Eh=2Ein
+++ b/include/openvpn-plugin=2Eh=2Ein
@@ -575,=
6 +575,7 @@
  * line 1: timeout in seconds
  * line 2: Pending auth method =
the client needs to support (e=2Eg=2E openurl)
  * line 3: EXTRA (e=2Eg=2E =
WEBAUTH::http://www=2Eexample=2Ecom)
+ *         at most 1014 bytes, otherw=
ise authentication fails
  *
  * In addition the OPENVPN_PLUGIN_CLIENT_CONN=
ECT_DEFER and
  * OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2 are called when Op=
enVPN tries to
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_ve=
rify=2Ec
index 2f81968=2E=2Ed48483b 100644
--- a/src/openvpn/ssl_verify=2Ec=

+++ b/src/openvpn/ssl_verify=2Ec
@@ -966,10 +966,12 @@
                   =
  pending_method);
                 ret =3D false;
             }
-        =
    else
+            else if (!send_auth_pending_messages(multi, session, =
BSTR(extra_buf),
+                                                 (unsigne=
d int)timeout))
             {
-                send_auth_pending_messages(=
multi, session, BSTR(extra_buf),
-                                         =
  (unsigned int)timeout);
+                auth_set_client_reason(multi, "A=
uthentication failed, pending auth "
+                                     =
         "request could not be sent");
+                ret =3D false;
    =
         }
         }
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2345?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I8799b8f81945d643bb340a334b1891a5e625c2b9
Gerrit-Change-Number: 2345=

Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>

--P0s+kUoNc/k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2345?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">ssl_verify: fail deferred auth if AUTH_PENDING cannot b=
e sent<br><br>key_state_check_auth_pending_file() ignored the return value =
of<br>send_auth_pending_messages()=2E When it failed, e=2Eg=2E on an oversi=
zed<br>INFO_PRE, the client got no INFO_PRE, yet auth stayed deferred until=
<br>the deferred window ran out=2E<br><br>Fail the auth instead and tell th=
e client why, as for an unsupported<br>pending method=2E Document the EXTRA=
 length limit=2E<br><br>Change-Id: I8799b8f81945d643bb340a334b1891a5e625c2b=
9<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br=
>M doc/man-sections/script-options=2Erst<br>M include/openvpn-plugin=2Eh=2E=
in<br>M src/openvpn/ssl_verify=2Ec<br>3 files changed, 8 insertions(+), 4 d=
eletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/45/2345/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-section=
s/script-options=2Erst b/doc/man-sections/script-options=2Erst</span><br><s=
pan>index 474c7fd=2E=2Ebc8ac2b 100644</span><br><span>--- a/doc/man-section=
s/script-options=2Erst</span><br><span>+++ b/doc/man-sections/script-option=
s=2Erst</span><br><span>@@ -149,7 +149,8 @@</span><br><span>   :code:`auth_=
pending_file`=2E The first line must be the timeout in</span><br><span>   s=
econds, the required method on the second line (e=2Eg=2E crtext) and</span>=
<br><span>   third line must be the EXTRA as documented in the</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  ``client-pending-auth`` section =
of ``doc/management=2Etxt``=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  ``client-pending-auth`` section of ``doc/management=2Etxt``=2E=
 The EXTRA</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  must no=
t exceed 1014 bytes; if it does, authentication fails=2E</span><br><span> <=
/span><br><span>   This directive is designed to enable a plugin-style inte=
rface for</span><br><span>   extending OpenVPN&#39;s authentication capabil=
ities=2E</span><br><span>diff --git a/include/openvpn-plugin=2Eh=2Ein b/inc=
lude/openvpn-plugin=2Eh=2Ein</span><br><span>index dde5dea=2E=2Ed108779 100=
644</span><br><span>--- a/include/openvpn-plugin=2Eh=2Ein</span><br><span>+=
++ b/include/openvpn-plugin=2Eh=2Ein</span><br><span>@@ -575,6 +575,7 @@</s=
pan><br><span>  * line 1: timeout in seconds</span><br><span>  * line 2: Pe=
nding auth method the client needs to support (e=2Eg=2E openurl)</span><br>=
<span>  * line 3: EXTRA (e=2Eg=2E WEBAUTH::http://www=2Eexample=2Ecom)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         at most 1014 =
bytes, otherwise authentication fails</span><br><span>  *</span><br><span> =
 * In addition the OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER and</span><br><span>=
  * OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2 are called when OpenVPN tries to=
</span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_=
verify=2Ec</span><br><span>index 2f81968=2E=2Ed48483b 100644</span><br><spa=
n>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_ve=
rify=2Ec</span><br><span>@@ -966,10 +966,12 @@</span><br><span>            =
         pending_method);</span><br><span>                 ret =3D false;</=
span><br><span>             }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            else if (!send_auth_pending_messages(multi, session, BSTR(=
extra_buf),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                                         (unsigned int)timeout))</span><br>=
<span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               send_auth_pending_messages(multi, session, BSTR(extra_buf),<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
                     (unsigned int)timeout);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                auth_set_client_reason(multi, &quo=
t;Authentication failed, pending auth &quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                              &quo=
t;request could not be sent&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                ret =3D false;</span><br><span>            =
 }</span><br><span>         }</span><br></pre><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2345?usp=3Demail">change 2345</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2345?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8=
799b8f81945d643bb340a334b1891a5e625c2b9 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2345 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--P0s+kUoNc/k=--


--===============2401232413270767240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2401232413270767240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2401232413270767240==--

