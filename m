Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18C8C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y0Ux7bWbxBgoKOfLz7wAv/XGIY7gLvzR8eyVuMoyP6g=; b=OMrbvQG1TKSkSlm18uDudMwbe+
	buGl32jZlQYL9sZrsRk+1VqTcy9v1bmZy0iVZlykcWI9fGnKtJWw1g4g0p7tL4sfPNn/P1qUORTrR
	J7MymYUI2KLftmc3gaJnQtdZufIhtTrqx9blIbDx32VM32LprLQ/L3Ax0FnCSiwwOXP8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wumNf-000535-Vg;
	Fri, 14 Aug 2026 07:31:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wumNe-00052y-Q3
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:31:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9PPZlwdbsnmIA38UgOTqKMZpMlpR8o5y9n1M8ZRSnTY=; b=BlXFjE45xMPb/feoWpJkgv8xBD
 BvQcyt2+K54731HDe+9whtwzOenNqMoEVq7fkKvn/BRyB+z1Kq3U1yhRNqMrrIfRDU95cj9bWUN05
 VsCimGbweBojDLLwLmNx+wBY6nfGNU/s7hPw4M3FYmLcOMeDfDEeNIztK367Xv7HDxPc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9PPZlwdbsnmIA38UgOTqKMZpMlpR8o5y9n1M8ZRSnTY=; b=k
 xCVywVYlM7vIvVam3oIXwW5aeyrBHZxK6nooFew1Q7W2yYiBxHBtRAkQR/xJJyheaM+nOPvDFwFov
 Dg/zw29YGSVV2Vd2bnzMWhuilCLd/GMBGz6Nl08srsB/O3lYo4mwvDhW+UkU3eCOVUN1g/mD09M4M
 c8SFjlXoH17xRfhQ=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wumNe-0002zX-7k for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:31:04 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4980dc26022so7072115e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 00:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786692656; x=1787297456; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9PPZlwdbsnmIA38UgOTqKMZpMlpR8o5y9n1M8ZRSnTY=;
 b=bLYC2480+ShUnE64ADmSZkbX8Fi5Vhj4AU7ZhOCedZs8vpYr9V57NbaGPzLOvlw9Bm
 C305R++9i3PlAOFBBmWQPKp+dTkiLmHfXt2GBdOLGW7KXa3DzSBJEvVATpH227razQks
 CKRfkBt374z4r9H0AmVgWXwF1jAndkI03iEQbyaNaTt7A2sxCdM3x+xFr8wCakCmSnSp
 q8xoqFPrPA588xbRerISsNC1Hqoqr1EmaVfv+7wfwNxK+Jedvk1zeR04z9GogcrJ6qSN
 GsYzxllV6tY6A6EMBeQ7fXK5QkBqUCKVNsANXZzsC5IY5JlP5O0MvuiLc/QVZ88TQWla
 H1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786692656; x=1787297456;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9PPZlwdbsnmIA38UgOTqKMZpMlpR8o5y9n1M8ZRSnTY=;
 b=AeYgXRp5aDZR9yUSBXrxqriQYUDM7v1Qif4hDuYF4EpR8QdQ+YO7QWCATqAqQHxnqC
 j4nM4d717ReW4B4DKh55j2oxP2o9sm5NerElHgeYG3xXuWa0LI097GJovovPne6U2Kdb
 vdGfTyWAoqH7ppcBqsL9OFlVoqvHa/p4JNgR0hg6FF46S+3m+H1VO6dZUO3iQL9Kll05
 BptACET+qbvKZCaL+ZRlw77ND2traBXKae/gmCoByr0zmTmbvq0i4xfAkMO3l0bwm56C
 /MSXIdiFB0DS5ygtIR2D6u9Exb71oTPoOlOL2Jv9EdWkXL/NnH5JPlUJaAcWFnlrtefb
 CVnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtDj17yQ7NtaHE2AVkvRqSkjLhjyFrdq9hBAqIgrrhWjPun7IACmb3Ubd5DvLLVPWGNIJf8R5MEKjRW3S7@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyTd2pjLpgaVQZVm6niFtwGQ/Wqaz1MSz+EAxI1ltSRIYtWWfHq
 +8fAKxbYz/2tgQ6lPnLlclaUV9Ai5gQPoq9RlT9x7xCoNF6MqlYcKmYHrNyZlEkQ44onOFDcfB2
 A18pZymncOduKw7RoSZAuMj9iqPlAV0SKQFz1e1nyaPUPLrnNJaGmQMllkXxU/pLqxER0
X-Gm-Gg: AR+sD139VRQbtX1GXVa38Oa87lY6l7yNTYJBxZ+TwuNMEFROeftFwfPqHGljsQn94x/
 Xq4I1I2C7rDFEPAIjAgw/kpipXMr1YOu46KCc1eCwPvYPgfjiyD457arLRyZdOljUd2ISQRubT0
 Vy3q6lrGrDqAUjknJ91PhCKNiIDeu7i2jVnhZrv0e5YzfMLBkms4NP9kpjr0tzL9W7IwagNyEmi
 fqGApJOR1i6GLHG0/kT0jOwBMiFsqe/nsBwhXxAJfZS+3BqXVm2AtaNmUrGCxCffwtTB/aj9/VB
 bLPdBrFQ/ARdU7HTxrE4gF1ws6QIzMtGHG/N3JHEFrEaxiGvZBPWOaeUR12o5zo5avdANrz2Vhd
 WFNi0eCUhxtziUm79m0abOnXw9UveMDze8vYicMujEgp/yu2W7pwzbMWbvzriwVOH/kKy4izPk4
 qksEObTP9o0RjYjawtQ97uh0ZJDwXGk6+1QCHnFJvJLHDKsDcE8rSuL8h9LtmxEneYhToQ6D246
 yreF2d5xB0/2wzIJDsxO6wX3odtb3Oq/iLtLLW3iv+wnc1s/8BFx4r02ggpMuEOgndkFoE1ps05
 mfIKW0f5QAeZh4FbH5Hkwy332sUPw4zeouO8YxjzWWFaxcZwuNo=
X-Received: by 2002:a7b:c4d0:0:b0:498:1595:be7b with SMTP id
 5b1f17b1804b1-4998792f242mr34958535e9.4.1786692656024; 
 Fri, 14 Aug 2026 00:30:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b2e6b6sm31190265e9.3.2026.08.14.00.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 00:30:55 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 07:30:55 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Iac4af315c6d7798f09a27383fc0a755a874b9881
X-Gerrit-Change-Number: 1480
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1480?usp=email>
X-Gerrit-Commit: 96dc5b7d2416e588ef9599d46b91a29fb1e0791b
In-Reply-To: <gerrit.1768911587000.Iac4af315c6d7798f09a27383fc0a755a874b9881@gerrit.openvpn.net>
References: <gerrit.1768911587000.Iac4af315c6d7798f09a27383fc0a755a874b9881@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY4OTExNTg3MDAwLklhYzRhZjMxNWM2ZDc3OThmMDlhMjczODNmYzBhNzU1YTg3NGI5ODgxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <baa5e210b15f3e8d0f0d58544746a021f7bc88d1-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wumNe-0002zX-7k
Subject: [Openvpn-devel] [S] Change in openvpn[master]: reliable: Avoid
 conversion warning in reliable_send_timeout
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3678161820212755497=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3678161820212755497==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+UyTVa4MMdU="; charset=UTF-8

--+UyTVa4MMdU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1480?usp=3Demail )

Change subject: reliable: Avoid conversion warning =
in reliable_send_timeout
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

reliable: Avoid conversion warning in reliable_send_timeout

=
It is not realistic that this produced big values
and we already discard ne=
gative values=2E So just use
whatever we get=2E

Change-Id: Iac4af315c6d779=
8f09a27383fc0a755a874b9881
Signed-off-by: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1480
Message-Id: <20260813180856=
=2E3208-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/op=
envpn-devel@lists=2Esourceforge=2Enet/msg38329=2Ehtml
Signed-off-by: Gert D=
oering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/reliable=2Ec
1 file chan=
ged, 1 insertion(+), 10 deletions(-)




diff --git a/src/openvpn/reliable=
=2Ec b/src/openvpn/reliable=2Ec
index 52adacf=2E=2E690e50d6 100644
--- a/sr=
c/openvpn/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -687,11 +687,6 @@
=
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagn=
ostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /* in =
how many seconds should we wake up to check for timeout */
 /* if we return=
 BIG_TIMEOUT, nothing to wait for */
 interval_t
@@ -713,7 +708,7 @@
      =
       }
             else
             {
-                ret =3D min_int(=
ret, e->next_try - local_now);
+                ret =3D min_int(ret, (int)(=
e->next_try - local_now));
             }
         }
     }
@@ -724,10 +719=
,6 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#=
pragma GCC diagnostic pop
-#endif
-
 /*
  * Enable an incoming buffer previ=
ously returned by a get function as active=2E
  */

-- 
To view, visit http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1480?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Iac4af315c6d7798f09a27383fc0a755a874b9881
Gerr=
it-Change-Number: 1480
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>

--+UyTVa4MMdU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1480?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">reliable: Avoid conversion warning in reli=
able_send_timeout<br><br>It is not realistic that this produced big values<=
br>and we already discard negative values=2E So just use<br>whatever we get=
=2E<br><br>Change-Id: Iac4af315c6d7798f09a27383fc0a755a874b9881<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1480<br>Message-Id: &lt;20260813180856=2E3208-1-ger=
t@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg38329=2Ehtml<br>Signed-off-by: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/reliable=2Ec<br>=
1 file changed, 1 insertion(+), 10 deletions(-)<br><br></pre>
<pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/reliable=2Ec b/src/openvpn/reliable=2Ec</span><br><span>inde=
x 52adacf=2E=2E690e50d6 100644</span><br><span>--- a/src/openvpn/reliable=
=2Ec</span><br><span>+++ b/src/openvpn/reliable=2Ec</span><br><span>@@ -687=
,11 +687,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> /* in how many seconds should we =
wake up to check for timeout */</span><br><span> /* if we return BIG_TIMEOU=
T, nothing to wait for */</span><br><span> interval_t</span><br><span>@@ -7=
13,7 +708,7 @@</span><br><span>             }</span><br><span>             =
else</span><br><span>             {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                ret =3D min_int(ret, e-&gt;next_try - local_n=
ow);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 ret =3D min_int(ret, (int)(e-&gt;next_try - local_now));</span><br><span> =
            }</span><br><span>         }</span><br><span>     }</span><br><=
span>@@ -724,10 +719,6 @@</span><br><span>     return ret;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> /*</span><br><span>  * Enable an incoming buff=
er previously returned by a get function as active=2E</span><br><span>  */<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1480?usp=3Demail">change 1480</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1480?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Iac4af315c6d7798f09a273=
83fc0a755a874b9881 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1480 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>

</body></html>
--+UyTVa4MMdU=--


--===============3678161820212755497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3678161820212755497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3678161820212755497==--

