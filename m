Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A7CCA9ED0
	for <openvpn-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fcwlC9iVIKw3Shm/93hPlqlnBY+wRl7GHdDdm8oZcZE=; b=HZBKz5ixwl/5wm/QFVDHR4sanl
	Hefx0iDwUcyUc32Mk2DYQVHNG1G4Z8pWXOLarwqwcum1CiuwHLDXYY03VhYci4lUUQxVP/gSnpbGx
	khpLwaz+xc4Tv0VcnotBAhkGCAqGkhQLdFQPmfpXwMsl+X+ATJy1tE0VuGJ/KMFuwnPw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGMDL-0007Zz-Pd;
	Mon, 12 Oct 2026 20:01:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGMDK-0007Zs-Dr
 for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 20:01:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LpH4fqS0qmMajogE/6k/gpdqMeXvIrLfRW6ayPTiyVA=; b=DqgMskIGzMMwYzF/oqfb+l30Jt
 CcUBOT0PyR+Csq92PVkPsQyyiSq6yu85qa1UOHD/anc0U2FUbxSxVg68cUrNZ6mwwLjcKRA+/oLhN
 +hx1KKmv+8c34sRUxc+okOtOzf5JE0wJ8RO4c6V15X/aeqNYeeiRNTcsurQ3SIeJ0Hsg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LpH4fqS0qmMajogE/6k/gpdqMeXvIrLfRW6ayPTiyVA=; b=e
 QN9JCi0j9fy+Q+QCmL2SYUwyblB9Gy7TWfcB57lMx9HBToQCjyZ5+r8ZnZx8SwpJSGn0hkcczy10e
 JXtQ6EOoOGW3rElnkrNRZPxiHNMhEaFyqN5JiKNJ4aJ18bnpJmqUlSbf67sA1Wd7joJMcpsyl+y6B
 2JJSrSAmnRwJNzV8=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGMDI-00079T-Jo for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 20:01:38 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48c411d6615so1577144f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 12 Oct 2026 13:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791835290; x=1792440090; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LpH4fqS0qmMajogE/6k/gpdqMeXvIrLfRW6ayPTiyVA=;
 b=RPSlaTYKFJRGJVYmH1L3gq5aX2bJxsNZ+UNA/TNoHw+OAdFeMct1hQPTFItXdjJWA6
 wT596fkGSX+4E61uBMkD5oCZTGURYFUsu+xeeCtopqXe0GSxbO3a7mbUiYSO/GwYNQXT
 3GGCK1U6Rc7E/3X1UXvUMK2Hbzf3AqVd7b8ORQupy/1wbevt+Q02dga2tRMXDbDhcDsP
 TJyejRV7s3DxCGg91YYAoxw/4NIGVm94YU+5hSGP+z8CADA+DcUvUXkXiQNP/Yj5l3Ko
 iGGwjYZFrm6JU1d7hziseBKVEkNiS2fy5y72H4WdQaQpP0LEnxZksPm3TlurQvWUp2sT
 WYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791835290; x=1792440090;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LpH4fqS0qmMajogE/6k/gpdqMeXvIrLfRW6ayPTiyVA=;
 b=LqPzUCYBj3cbovqg9IbBQb6YDcN+tyQqpsMCcwlzeerocWB9k4b+NYjx3dCC21GExm
 MIsPClaYcNV0+MqooH5HibhlmVA0HUkPq4E9O9wBGK0qlFmxY3y+6FYV9DzmTEnH/Ml8
 xy/7BmJ864Uv7ribJO7nzj/kQANWR1vBH9BTMUTHoUwGviJGnyBxIT3L2/1tnLtcv7un
 sJwZjLAFCDSlh+dN8MzTGqgItpW2Lsc2U4u2vyOgnKGW3rShBhqavh6xe5pQuZ5RPk1C
 OjbhLgUR36cchkHRbfDHmlyINipvpfGyG+p+Hh8KxkrEp3d5s1WiRtY7Dx5Pm0LzgPSA
 vzNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByC/zJs8PYqGE848NS9yBAyVPqkK00b1TLnHrQoMrIy5EsH/SeGDP+tfb1ZHRG5a9aQEg3H1wyrXNbfGLmG@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK6ga65Ls5wvOrv84RTBeq0Zhm2Icr12oEw2ZB8VqC0/Z/Ll7jB
 1krhHKOCv+I2YZnx0gXkjiRnqZGl7ELoIllvzZCn5AVNStniqzr07+W8fA6ikT2DKZTX5tAxT6F
 N9SGXU0nBcXIY3D56EiUB7yTi/Xy+17avtSyM2OvNbLF1ROI70Z4mULejjPS/R5SRmf48
X-Gm-Gg: AYBFou2lO3NjXBAKi2TwbpAVH4n7rWFM42LCw0JzkT/N9czYTkFeEEDYYaC0TuGuoT9
 m4iKJwPQTjPvZk4T82VUWSbVo/SvQF12585bPURwm2gnJnTKRhMM0ptzpnQHOiui7f0hsh1LWoG
 LvLVC+JJAj1lRenunMnUDxUITq9wgLAiPQLvaquV23PRbBQgLYN9hzuZ3o9QS+HQZfTm9/pKVvh
 GVWg4cnO+Lh2FE2R1vgoBOOSLLvpLE4IbuOScOKLxquWDo2t+7140y5VCWznCKT0ljYtm97BROl
 XJyr4AsmbBHwDThA9eocOFyK6CqZumtu9MY8fsczYXAAofJkLwa8iNepuX+jhOiurE4/IuiIytL
 Xu2EVdc39GpuTNLdMUW5BnKRA/vTrNu09IwNrCChlJ86ubeHAcoRP2dVlSgcTT+xSOWYqW8p6iX
 XmPizCwbuQXqktPakLe3sqciL/0JeH0+UPnMGXyWKG0DSfzAe8BLg7ZP8bMA0ffkt8qPK3P5XZV
 8JYVr/XbArMy0dNzkPRZMZYm0P0sygArNJ8yN3c1wc+/YNis9y7UGoCrEFqo8DyE2ydE3eURRIN
 MIt88uA1LEjbKIA4iNHnr/ZxVqLFsBjb4b/1PW1qsYIfPZm9tpP3ZC+6vi9HULxinIJ4QQ8=
X-Received: by 2002:adf:f94e:0:b0:487:1256:ab80 with SMTP id
 ffacd0b85a97d-48dbad0d4fcmr14431654f8f.57.1791835289057; 
 Mon, 12 Oct 2026 13:01:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bd733fsm1078543f8f.58.2026.10.12.13.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 13:01:28 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 12 Oct 2026 20:01:28 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib74788b0365f6b44383ce09cf7d4914bbe500f8a
X-Gerrit-Change-Number: 1990
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1990?usp=email>
X-Gerrit-Commit: 15a1465f981bb3f1950056a8f82b91dfe5f3fdbc
In-Reply-To: <gerrit.1791790522000.Ib74788b0365f6b44383ce09cf7d4914bbe500f8a@gerrit.openvpn.net>
References: <gerrit.1791790522000.Ib74788b0365f6b44383ce09cf7d4914bbe500f8a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNzkwNTIyMDAwLkliNzQ3ODhiMDM2NWY2YjQ0MzgzY2UwOWNmN2Q0OTE0YmJlNTAwZjhhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4f615c6cb74ba025b79d9da73b0941e4cf79a131-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGMDI-00079T-Jo
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make CRL reload EOF
 detection independent of stale error queue entries
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3527076322362157620=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3527076322362157620==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2+00Az3F9kY="; charset=UTF-8

--2+00Az3F9kY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1990?usp=3Demail )

Change subject: Make CRL reload EOF detecti=
on independent of stale error queue entries
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Make CRL reload EOF detection independent o=
f stale error queue entries

backend_tls_ctx_reload_crl() treats a NULL fro=
m PEM_read_bio_X509_CRL()
as EOF when ERR_peek_error() shows PEM_R_NO_START=
_LINE=2E ERR_peek_error()
returns the OLDEST queued error, so any entry lef=
t behind earlier in the
thread turns a clean EOF into a "CRL: cannot read C=
RL from file" warning,
prints the unrelated errors as if they came from the=
 CRL file, and still
installs the CRLs already parsed=2E The previous commi=
t removes the
leftover that triggered this in practice; this one stops the =
loop from
depending on the queue being clean at all=2E

If the queue is not=
 empty when the CRL is loaded, say so at D_LOW with
the queued errors, sinc=
e that is a bug somewhere else worth seeing, then
start the loop from an em=
pty queue so only errors raised by
PEM_read_bio_X509_CRL() are visible=2E T=
est the error it raised last
rather than the oldest one, and clear the queu=
e on the EOF path instead
of popping a single entry=2E

Change-Id: Ib74788b=
0365f6b44383ce09cf7d4914bbe500f8a
Signed-off-by: Drew Blokzyl <drew@linuxki=
ds=2Ecom>
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Razvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Github: OpenVPN/openvpn#1104
Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1990
Message-Id: <20261012102657=
=2E13611-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg39839=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_openssl=2Ec
1 file =
changed, 17 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/ssl_=
openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index b88e1d9=2E=2E96e90f82 10064=
4
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ssl_openssl=2Ec
@@ -1=
360,6 +1360,19 @@
     }
 
     int num_crls_loaded =3D 0;
+    /*
+     * =
The EOF test below must only see errors raised by
+     * PEM_read_bio_X509=
_CRL()=2E Anything already queued was left by an
+     * earlier operation =
in this thread and would otherwise be what
+     * ERR_peek_error() returns=
, turning a clean EOF into "cannot read CRL"=2E
+     * Report it, since th=
at is a bug elsewhere, then start from an empty
+     * queue (crypto_msg()=
 drains the queue while printing it)=2E
+     */
+    if (ERR_peek_error() =
!=3D 0)
+    {
+        crypto_msg(D_LOW, "CRL: OpenSSL error queue not emp=
ty on CRL load");
+    }
+    ERR_clear_error();
     while (true)
     {
 =
        X509_CRL *crl =3D PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);
@@ -=
1367,13 +1380,15 @@
         {
             /*
              * PEM_R_NO_STA=
RT_LINE can be considered equivalent to EOF=2E
+             * ERR_peek_las=
t_error() is the error PEM_read_bio_X509_CRL()
+             * raised last;=
 ERR_peek_error() would be the oldest queued one=2E
              */
-     =
       bool eof =3D ERR_GET_REASON(ERR_peek_error()) =3D=3D PEM_R_NO_START_=
LINE;
+            bool eof =3D ERR_GET_REASON(ERR_peek_last_error()) =3D=
=3D PEM_R_NO_START_LINE;
             /* but warn if no CRLs have been load=
ed */
             if (num_crls_loaded > 0 && eof)
             {
         =
        /* remove that error from error stack */
-                (void)ERR=
_get_error();
+                ERR_clear_error();
                 break;
 =
            }
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1990?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib74=
788b0365f6b44383ce09cf7d4914bbe500f8a
Gerrit-Change-Number: 1990
Gerrit-Pat=
chSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Rev=
iewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>

--2+00Az3F9kY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1990?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Make CRL reload EOF detection inde=
pendent of stale error queue entries<br><br>backend_tls_ctx_reload_crl() tr=
eats a NULL from PEM_read_bio_X509_CRL()<br>as EOF when ERR_peek_error() sh=
ows PEM_R_NO_START_LINE=2E ERR_peek_error()<br>returns the OLDEST queued er=
ror, so any entry left behind earlier in the<br>thread turns a clean EOF in=
to a &quot;CRL: cannot read CRL from file&quot; warning,<br>prints the unre=
lated errors as if they came from the CRL file, and still<br>installs the C=
RLs already parsed=2E The previous commit removes the<br>leftover that trig=
gered this in practice; this one stops the loop from<br>depending on the qu=
eue being clean at all=2E<br><br>If the queue is not empty when the CRL is =
loaded, say so at D_LOW with<br>the queued errors, since that is a bug some=
where else worth seeing, then<br>start the loop from an empty queue so only=
 errors raised by<br>PEM_read_bio_X509_CRL() are visible=2E Test the error =
it raised last<br>rather than the oldest one, and clear the queue on the EO=
F path instead<br>of popping a single entry=2E<br><br>Change-Id: Ib74788b03=
65f6b44383ce09cf7d4914bbe500f8a<br>Signed-off-by: Drew Blokzyl &lt;drew@lin=
uxkids=2Ecom&gt;<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<=
br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Github: OpenV=
PN/openvpn#1104<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
990<br>Message-Id: &lt;20261012102657=2E13611-1-gert@greenie=2Emuc=2Ede&gt;=
<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg39839=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/ssl_openssl=2Ec<br>1 file changed, 17 in=
sertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_o=
penssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index b88e1d9=2E=
=2E96e90f82 100644</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span>=
<br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -1360,6 +136=
0,19 @@</span><br><span>     }</span><br><span> </span><br><span>     int n=
um_crls_loaded =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * The =
EOF test below must only see errors raised by</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * PEM_read_bio_X509_CRL()=2E Anything alread=
y queued was left by an</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * earlier operation in this thread and would otherwise be what</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ERR_peek_error()=
 returns, turning a clean EOF into &quot;cannot read CRL&quot;=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * Report it, since that =
is a bug elsewhere, then start from an empty</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * queue (crypto_msg() drains the queue while =
printing it)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ERR_peek=
_error() !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        crypto_ms=
g(D_LOW, &quot;CRL: OpenSSL error queue not empty on CRL load&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ERR_clear_error();</span><br><span>=
     while (true)</span><br><span>     {</span><br><span>         X509_CRL =
*crl =3D PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);</span><br><span>@@ -1=
367,13 +1380,15 @@</span><br><span>         {</span><br><span>             =
/*</span><br><span>              * PEM_R_NO_START_LINE can be considered eq=
uivalent to EOF=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
            * ERR_peek_last_error() is the error PEM_read_bio_X509_CRL()</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+             * raised =
last; ERR_peek_error() would be the oldest queued one=2E</span><br><span>  =
            */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     bool eof =3D ERR_GET_REASON(ERR_peek_error()) =3D=3D PEM_R_NO_START_LI=
NE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            bool=
 eof =3D ERR_GET_REASON(ERR_peek_last_error()) =3D=3D PEM_R_NO_START_LINE;<=
/span><br><span>             /* but warn if no CRLs have been loaded */</sp=
an><br><span>             if (num_crls_loaded &gt; 0 &amp;&amp; eof)</span>=
<br><span>             {</span><br><span>                 /* remove that er=
ror from error stack */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                (void)ERR_get_error();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                ERR_clear_error();</span><br><span>   =
              break;</span><br><span>             }</span><br></pre><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1990?usp=
=3Demail">change 1990</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1990?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: Ib74788b0365f6b44383ce09cf7d4914bbe500f8a </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1990 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--2+00Az3F9kY=--


--===============3527076322362157620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3527076322362157620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3527076322362157620==--

