Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CB606A32A
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=E2Agjs8c;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=K1tv70vE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DmuyKYCN;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Xhw1mU8C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MCrUxiab4klcQ2HO+rYeIMxiPRniaBSPtwil6hz6UQY=; b=E2Agjs8cBlSirOew5vBN3ri0s1
	8XWj8T7yth1f8oHcT9cd0Z4tRjjTehKZZFyn8IFS6fPEenvwQts9IHtaFGCiCjLJPx+sHpybWXXRU
	62LQgjhX73fC0lRsHzTr17tFnHKhi8TajW8KlfJCLBZ5s7sKw4GEptx4sTPB9XdNm08c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUp7U-000000003PV-0Er8;
	Sat, 21 Nov 2026 17:43:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUp7R-000000003PO-3gop
 for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 17:43:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/o1uY1vTlb36HegVDuICQ/lna6VlpjyEJE1n8mM6xL4=; b=K1tv70vEnrG3emjbR69CFDAnlx
 gY6CH60lDhz1Jb/YVjz4NvpHFCfcH+XBii4byqir7HK9Y+eNb7tHuLLpg237HwPLKDepPltAj4NTz
 IKdAXD1/MaaXpwdq6OeKCRuGAsDmuy2V2ZbZu2mBnPY7LETSjeTeu3Xvtcdb/ek7dUf0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/o1uY1vTlb36HegVDuICQ/lna6VlpjyEJE1n8mM6xL4=; b=DmuyKYCNo3BLjmyqdfsP1kjvMM
 ujzlh9b81Vb2i1qYnku8E5G6RHPZbcZbJZQz4FczHq9jFp6ew3v9OARwfiRHr3OCfPrXVN1Vj5356
 fQ0A2zwdMEi7XezgDxtCriXURkYQ7il+12/bg8vhDlDSCMZCPikSvTuvZJNv8nAZtuEc=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUp7R-000000003RO-02ro for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 17:43:21 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4a7b8abe209so1484896f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 21 Nov 2026 09:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795282994; x=1795887794; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/o1uY1vTlb36HegVDuICQ/lna6VlpjyEJE1n8mM6xL4=;
 b=Xhw1mU8C1HEU2RDA1jmRXKL9JjKhGFMBIXlRrjJCX6pRP4MDvUokMwTOeIfuhbjQHF
 x8MQbVVefq0kpB+6adYWOwf6p76TaNs2iaukeTM9AGgmJmVhTB6mtRctGKkCSTjICJX/
 4eb40mTXEvn9hW5HBgK0PSPsTpW9Y/jAZ2uUpu62NPtXXdBecIQWlFMhcfdk6yANBXNq
 DtWnbpMsGvHA9PaVqDszjYpTFX3Wlo0AwXyt+mN8YKmMI3ggnQIo2mfEvAff0NVPgNfw
 1CLmgqrYXb7eASmTwa+/6+ycqOqI7iTQsF49Ljj2gny3hTFY97XojjmfAmZWtiSnMyCt
 Jq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795282994; x=1795887794;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/o1uY1vTlb36HegVDuICQ/lna6VlpjyEJE1n8mM6xL4=;
 b=kDYDzhrYL4fV6B2TTpziZIEka6nlvZJ5eKssSvVRxiVfOftaRF8Td0EVXsepg7JvUw
 1+OZXqt5/rtF2AoGFCD3IB4b7bMd1tbkj/cU5WTLpBvrKfx8mx+E9pDepYvTM1MqEQxT
 Ap+jQPYz7fXvPTPmzeT7977zVkPzWz0djD68/Ya61DOgIkr2e7GIClGjGABzfzFx8TMy
 JQ9KRMwzbLg9L9YklABA/QSp/vG/VCzJ057GK9fXutJnaEmYR4w3AIMdtUUibKOQkOwr
 DY5nvmB7Tb6iXv8mFCyfHzJIzSwcFk0lgjUrUDnM5dgTThP10yTUOhMmf4wGhal/zLKs
 I7hQ==
X-Gm-Message-State: APuU4Z+I3cguRSJtxiZmOvjT8brs8FZcICNLovKHXN6Kw5zktqO4z7Ef
 xhPuWKMOEgyhwP/S19/ehyqoUDh+6+PKv4RsBbJ+rXJhCP2LTuNEOa11Kt911qUv/lyQIK7UBAW
 61pGSZmzv8oKO3wv7AxXf9Z/DesEpKGafCJXbIkqpG5Lo+wLDGZp8CBu+OmSezrtdWk6z
X-Gm-Gg: AZFdTZcOb8rWC+Jd59FFpuXthm700vTc06oW8EGXrt+9JKyJrAKWzPKchT0DobHPKpT
 +rltMfr6g28ZdHqracWp+mppp5f2V+U+mcHW7PtP80YZpE3/yivABk093X7JDQSAM9MW5Wyqte0
 1KTXszUHw/rxfKmQsBC424zJqhbRFdcLunXLpQVjmNYaf8NlwIIVTZSRTYIIxKmyt7DpYRZRA/y
 upiOjuhafDGOoRyTR927oGnmiqoKWogCSd9/QGmzGkc9inqkUQYR5t/kVoT9I0h0I5vB8gcrz+5
 booT2TNiFJ0DfB1qJCDYrRX+O5Q0ZWyxH4z31A20zrB0Mo58vpeMo/7fgq0lQjy+bHejHEI6Y4P
 1U+P21nvnhbKiAdVqQ7Bmlsuxi7eRgeq/kBoIZcJhvPhJAmqD+dZcTvYH/0lRdMv7In59fz27q0
 yyVZBw/dfZa3EaP+c2wwiqtcJp1TdgqdUL4T8becym7YQWtydhCrndYNxo0smZKlupSjNGBPZw1
 IZgYGXN2yLCjAWAt930nrKlz5BKumBudOxY/O0+4pa09GoeKcc0fvDLkNqe2Q6bJs8I5JJp/gpz
 Tj664HUlopwIEsCSx20ae1UYNpfjfwys57/be8r3S1ETxXjBLM77KD7ga1Eg/HSB3PSW+xzre7Z
 6HNsfiXLeeOAtpshSrVJE4RS0Z0c0t6a5c6RfBzZ6s/PbNiWY5mv4xHBdLMu0vGfbIPh459bkKq
 uhPoKmSfhASK4jsDw=
X-Received: by 2002:a5d:64c8:0:b0:493:c0a:507d with SMTP id
 ffacd0b85a97d-4abaab633c7mr15595272f8f.1.1795282994306; 
 Sat, 21 Nov 2026 09:43:14 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf680fsm14144354f8f.14.2026.11.21.09.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 09:43:13 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 21 Nov 2026 17:43:13 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ifbd6badab31a48653fa0bca7f086db058f83f891
X-Gerrit-Change-Number: 2191
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2191?usp=email>
X-Gerrit-Commit: 47dacce0d488cb126d08c0cd426402e89752a061
In-Reply-To: <gerrit.1794830847000.Ifbd6badab31a48653fa0bca7f086db058f83f891@gerrit.openvpn.net>
References: <gerrit.1794830847000.Ifbd6badab31a48653fa0bca7f086db058f83f891@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODMwODQ3MDAwLklmYmQ2YmFkYWIzMWE0ODY1M2ZhMGJjYTdmMDg2ZGIwNThmODNmODkxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e08121cabe3149ce6cb9e109b7a2a212ef7eea80-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUp7R-000000003RO-02ro
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_verify: remove
 script temp files on all exit paths
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7823753585528169789=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7823753585528169789==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rYmSt8wlk3c="; charset=UTF-8

--rYmSt8wlk3c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2191?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Arne Schwabe


Change subject: ssl_verify: remove script=
 temp files on all exit paths
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

ssl_verify: remove script temp files on all exit paths

Th=
e file holding the client's challenge response was never deleted,
although =
the manual says it is removed after the script returns=2E The
--auth-user-p=
ass-verify via-file credentials file was kept when the
deferred auth contro=
l files could not be created=2E Unlink both on every
exit path=2E

Change-I=
d: Ifbd6badab31a48653fa0bca7f086db058f83f891
Signed-off-by: Razvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg=
>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2191
Message-Id: <=
20261119212143=2E5413-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41690=2Ehtml
Signed-=
off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_verify=
=2Ec
1 file changed, 5 insertions(+), 2 deletions(-)


  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/91/2191/4

diff --git a/src/=
openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 8641d15=2E=2E75cd=
a97 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2E=
c
@@ -1372,7 +1372,7 @@
             "could not create deferred auth contro=
l file",
             __func__);
         retval =3D OPENVPN_PLUGIN_FUNC_ER=
ROR;
-        goto error;
+        goto done;
     }
 
     /* call command=
 */
@@ -1415,7 +1415,6 @@
         platform_unlink(tmp_file);
     }
 
-err=
or:
     if (!session->opt->auth_user_pass_verify_script_via_file)
     {
 =
        setenv_del(session->opt->es, "password");
@@ -1487,6 +1486,10 @@
  =
       tls_deauthenticate(multi);
     }
 done:
+    if (tmp_file)
+    {
+=
        platform_unlink(tmp_file);
+    }
     argv_free(&argv);
     gc_fr=
ee(&gc);
 }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2191?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifb=
d6badab31a48653fa0bca7f086db058f83f891
Gerrit-Change-Number: 2191
Gerrit-Pa=
tchSet: 4
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--rYmSt8wlk3c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2191?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Arne Schwabe</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ssl=
_verify: remove script temp files on all exit paths<br><br>The file holding=
 the client&#39;s challenge response was never deleted,<br>although the man=
ual says it is removed after the script returns=2E The<br>--auth-user-pass-=
verify via-file credentials file was kept when the<br>deferred auth control=
 files could not be created=2E Unlink both on every<br>exit path=2E<br><br>=
Change-Id: Ifbd6badab31a48653fa0bca7f086db058f83f891<br>Signed-off-by: Razv=
an Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2191<br>Message-Id: &lt;20261119212143=2E5413-1-gert@greenie=2Em=
uc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg41690=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl_verify=2Ec<br>1 file chan=
ged, 5 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/91/2191/4</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br=
><span>index 8641d15=2E=2E75cda97 100644</span><br><span>--- a/src/openvpn/=
ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><=
span>@@ -1372,7 +1372,7 @@</span><br><span>             &quot;could not cre=
ate deferred auth control file&quot;,</span><br><span>             __func__=
);</span><br><span>         retval =3D OPENVPN_PLUGIN_FUNC_ERROR;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        goto error;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        goto done;</span><br><s=
pan>     }</span><br><span> </span><br><span>     /* call command */</span>=
<br><span>@@ -1415,7 +1415,6 @@</span><br><span>         platform_unlink(tm=
p_file);</span><br><span>     }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-error:</span><br><span>     if (!session-&gt;op=
t-&gt;auth_user_pass_verify_script_via_file)</span><br><span>     {</span><=
br><span>         setenv_del(session-&gt;opt-&gt;es, &quot;password&quot;);=
</span><br><span>@@ -1487,6 +1486,10 @@</span><br><span>         tls_deauth=
enticate(multi);</span><br><span>     }</span><br><span> done:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (tmp_file)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        platform_unlink(tmp_file);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     argv_f=
ree(&amp;argv);</span><br><span>     gc_free(&amp;gc);</span><br><span> }</=
span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2191?usp=3Demail">change 2191</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2191?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Ifbd6badab31a48653fa0bca7f086db=
058f83f891 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2191 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"=
display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--rYmSt8wlk3c=--


--===============7823753585528169789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7823753585528169789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7823753585528169789==--

