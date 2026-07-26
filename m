Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376E4C54EFC
	for <openvpn-devel@archiver.kernel.org>; Sun, 26 Jul 2026 00:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=zAjILUMJaKshJF5b6nY10/WIvt+bsJCxWAjXKD8Woro=; b=geyZVMrDmwdAm1
	KTGPBevtRbS5jzJg/qeOHe0McPT34rdlowxE8Jg+x9XmPE6hgENNR8+f990auaj0uVToQx1PsXlhd
	LAfAPEtO5Uhd9tppFPFjjloPDLAMy1azRwvdChedPdlynlTV6uyIznu3KXbYduSZIkMg4ZNVAAchE
	yi0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnmOb-0003nZ-6h;
	Sun, 26 Jul 2026 00:07:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnmOR-0003n6-Vy
 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 00:07:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9eMFXyVJc2+2F+kSRlK3DT2VlmgbOS42l5CDeAQMm3w=; b=XaDf14s26C6WqZ6KOItWfhh5Dc
 nHg6ChQzEOImxOUtP62eySncX/YXnwpzj1e6doeW1mJBb2CwC71PgHtjL49gjEMrY80/bhiV4aJ0D
 VMEoAe/cPe2/eLuqn/God277A82AAjSHjvlNM+nBx13qgkG2/ohJLzQczTx2vvIOkkwU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9eMFXyVJc2+2F+kSRlK3DT2VlmgbOS42l5CDeAQMm3w=; b=g
 WM1lYR9T7mvrOaEpEeBhg3mgPJx5vrKL0Xsv5/NRQ/5L0LqDjLopaxDFtliz1a9Uum4ommGKl5CyU
 vntCSoU5ffh3Dl6KqIXJQURXrIcRryBttFgCbY1o59LDHIowgCshG5gIij8QAYuS4yfncQuF9gNOL
 ekdW2fHcKmylbCpU=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnmOV-0005yz-KC for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 00:07:00 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493f6de72faso12896725e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 17:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785024413; x=1785629213; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9eMFXyVJc2+2F+kSRlK3DT2VlmgbOS42l5CDeAQMm3w=;
 b=CJzlEsAZSU3vW+rAqSY1aXfmVVLw/5JIddAZTuILNeAIEoWASUBt/CcddcMWN64phn
 vmtJAwgfYwDYWKd2HCCEPM3uByDgvs/BzNa3BEDLmYZwXtbamo3kEV9HpTIcEGfpGWwu
 fNaiAgKNjjnf7eW7HuYwvOFRp0yeYdz3Dexke00eWVz4spSxmFy38+DTFM9VnZoNEByq
 U44Re3D07PRcPE65Ce9HJyfo0EWaQK4oOJfJm1KGUmj8OJ4m568VqNCPzcuhysiOnbLy
 FLDs2F7d8MGnISiYh7to7SBpYE75m0nyhkVqe31vqrOslW55ZOOK4CGf5xRE/uVb5sYX
 MMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785024413; x=1785629213;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9eMFXyVJc2+2F+kSRlK3DT2VlmgbOS42l5CDeAQMm3w=;
 b=YVZwS+5LJKYyWobuysxAHKR+pt/8tG+7NeuOZD+RffjfoaMmS29sj/oVMU/CyOFyJt
 URXjxt/GzNkDfF8jNCojCLpOKUc4h+wyTyO2WPAOQTqV7WVobZbf+yZVpDF4mEQzqZf+
 MDmpJQaKdxOF29BauflmkvqQPXM9WQqpndse5fr9kCmRWUerU09pMJHkQbsfD9oe1JOQ
 pl6lfJ0rnsXtwSlAWWrMXbWd7Cyh4/I+g8QDl5TIt/tzRgcT6Q2hCD6p0PsVm4ibonYo
 PcDgbZ5GlPykAP/c9i0gLXWEuB3j2RZujtW7hxtHiU3KNEEtda5nyUu2zZ8vFjIRuzEn
 tt6g==
X-Gm-Message-State: AOJu0YxM2C+JoMi8NWOMyQbTuZQtv3d/ZKs2DFIZWc7QSycvJmPca1hk
 z+07AyQ5wnkQaHpY6aaGbAzlp+Apl1IZ8J+S9o1bpLWh4GsCw7Lzxn3PcgZzWk6gtRmerfQGZOY
 KYj9RYzEFxhr4dbWR8FBFk8HwN/EFryPFuI4MxKZ6zbwTItvD3xFunp52DA0dCzdAOWCfP7uusm
 3I8PvFlA==
X-Gm-Gg: AR+sD12ggEhVkjIOyitH8kADaZkaa/6gLyNTuyVZ4q5VuBtuQCdCfnJm1o6xp8TeApN
 HhW9y1rZ+E/0yPXbnSJ5sk0FY+shaLWUBLIwcWt1n9xmLj/s5YilifRT+/qisMoZr37iFurEVXO
 vRWtBlu/JS3RE6aF39a3mwsNk7C/D2Q9wZPzIBdUBLpwwPunwY+ottSmYzLhSoGx0iTcTIMk24z
 woYiAGNy/Wg7IbC62oy8ft+8ovdsVrDUA+xvt7uh6A4OHpq9aRhNkCJDZejOn6Cm7ItMnILoLGJ
 SvGbvxLZkw106VxGeu4wY+qKqcJ68wX02ENkHJR/nEgIHdKnQDXj/iZ18aAJ4jlrTUYJRdN9/h7
 +SorB32rCo3Edy8Cke2hcRA+9o1tDPI2D74asSLycK8X2QiXqDCjwJ1l9lbIUoWHrxYus/ARUJz
 oFuUvnsr6KUSpMoPCiaUm5aK5i4GuQhyjpVKbVMGTCEkmWEw3W6Lq0GNYGicnFpaFyagiqdv7kj
 sMEAezqLR7nmK9iZHHONNnWAzht7sVNTvFsnDH92WJVRHnsqeI/7u9jkfHpNyI9MgvU
X-Received: by 2002:a05:600c:3b08:b0:494:1f7:8057 with SMTP id
 5b1f17b1804b1-496b5b3af32mr43452755e9.1.1785024413260; 
 Sat, 25 Jul 2026 17:06:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4f30126sm98988005e9.13.2026.07.25.17.06.52
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 17:06:52 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 26 Jul 2026 00:06:52 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2d4801e282501274396f6421400abe5136e927eb
X-Gerrit-Change-Number: 1825
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1825?usp=email>
X-Gerrit-Commit: e97a30c5ef67d01008d4d91620cd3ec38abc8c6f
References: <gerrit.1785024389000.I2d4801e282501274396f6421400abe5136e927eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MDI0Mzg5MDAwLkkyZDQ4MDFlMjgyNTAxMjc0Mzk2ZjY0MjE0MDBhYmU1MTM2ZTkyN2ViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b5505def7056cd5b384afce6e53a9bb1e4209a8e-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnmOV-0005yz-KC
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: P2P: transmit ping
 timeout to peer and adjust own frequency
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
Content-Type: multipart/mixed; boundary="===============7811585404257755594=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7811585404257755594==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JJ9k5b9v6BQ="; charset=UTF-8

--JJ9k5b9v6BQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1825?usp=3Demail )


Change subject: P2P: transmit ping =
timeout to peer and adjust own frequency
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

P2P: transmit ping timeout to peer and adjust =
own frequency

If the ping timeout received from the peer is more than our =
own sending
interval, warn about this and set our own timeout to a third of=
 the
peers timeout to avoid the connection breaking because of ping timeout=
=2E

Change-Id: I2d4801e282501274396f6421400abe5136e927eb
Signed-off-by: Ar=
ne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/init=2Ec
M src/openvpn/ss=
l=2Ec
M src/openvpn/ssl_common=2Eh
3 files changed, 9 insertions(+), 0 dele=
tions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/25/1825/1

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
ind=
ex e8644f4=2E=2E3667c15 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn=
/init=2Ec
@@ -3281,6 +3281,7 @@
     to=2Ereplay_window =3D options->replay=
_window;
     to=2Ereplay_time =3D options->replay_time;
     to=2Econfig_c=
iphername =3D c->options=2Eciphername;
+    to=2Eping_rec_timeout =3D c->op=
tions=2Eping_rec_timeout;
     to=2Econfig_ncp_ciphers =3D c->options=2Encp=
_ciphers;
     to=2Etransition_window =3D options->transition_window;
     =
to=2Ehandshake_window =3D options->handshake_window;
diff --git a/src/openv=
pn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 245f937=2E=2Edfff7d7 100644
--- a/sr=
c/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2000,6 +2000,13 @@
        =
 {
             /* If we are not using pull we announce P2P NCP support */
=
             iv_proto |=3D IV_PROTO_NCP_P2P;
+
+            /* We are sendi=
ng our ping receive timeout to allow detecting
+             * mismatched p=
ing */
+            if (session->opt->ping_rec_timeout)
+            {
+   =
             buf_printf(&out, "P=3D%d\n", session->opt->ping_rec_timeout);
=
+            }
         }
 
         if (session->opt->data_epoch_supported=
)
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
inde=
x f6392f9=2E=2E5a21bcce 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/o=
penvpn/ssl_common=2Eh
@@ -371,6 +371,7 @@
 
     const char *config_ciphern=
ame;
     const char *config_ncp_ciphers;
+    int ping_rec_timeout;
 
    =
 /** whether our underlying data channel supports new data channel
      * =
features (epoch keys with AEAD tag at the end)=2E This is always true

-- 
=
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1825?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2d4801e282501274396f642=
1400abe5136e927eb
Gerrit-Change-Number: 1825
Gerrit-PatchSet: 1
Gerrit-Owne=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>

--JJ9k5b9v6BQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1825?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">P2P: transmit ping timeout to peer and adjust own frequency<br><br=
>If the ping timeout received from the peer is more than our own sending<br=
>interval, warn about this and set our own timeout to a third of the<br>pee=
rs timeout to avoid the connection breaking because of ping timeout=2E<br><=
br>Change-Id: I2d4801e282501274396f6421400abe5136e927eb<br>Signed-off-by: A=
rne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/init=2Ec<br>=
M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>3 files changed, 9=
 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/25/1825/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index e86=
44f4=2E=2E3667c15 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><=
br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -3281,6 +3281,7 @@</=
span><br><span>     to=2Ereplay_window =3D options-&gt;replay_window;</span=
><br><span>     to=2Ereplay_time =3D options-&gt;replay_time;</span><br><sp=
an>     to=2Econfig_ciphername =3D c-&gt;options=2Eciphername;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    to=2Eping_rec_timeout =3D c-=
&gt;options=2Eping_rec_timeout;</span><br><span>     to=2Econfig_ncp_cipher=
s =3D c-&gt;options=2Encp_ciphers;</span><br><span>     to=2Etransition_win=
dow =3D options-&gt;transition_window;</span><br><span>     to=2Ehandshake_=
window =3D options-&gt;handshake_window;</span><br><span>diff --git a/src/o=
penvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 245f937=2E=2Edff=
f7d7 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b=
/src/openvpn/ssl=2Ec</span><br><span>@@ -2000,6 +2000,13 @@</span><br><span=
>         {</span><br><span>             /* If we are not using pull we ann=
ounce P2P NCP support */</span><br><span>             iv_proto |=3D IV_PROT=
O_NCP_P2P;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            /* We are sendin=
g our ping receive timeout to allow detecting</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+             * mismatched ping */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (session-&gt;opt-&gt=
;ping_rec_timeout)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         buf_printf(&amp;out, &quot;P=3D%d\n&quot;, session-&gt;opt-&gt;pin=
g_rec_timeout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span>         }</span><br><span> </span><br><span>    =
     if (session-&gt;opt-&gt;data_epoch_supported)</span><br><span>diff --g=
it a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><spa=
n>index f6392f9=2E=2E5a21bcce 100644</span><br><span>--- a/src/openvpn/ssl_=
common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span=
>@@ -371,6 +371,7 @@</span><br><span> </span><br><span>     const char *con=
fig_ciphername;</span><br><span>     const char *config_ncp_ciphers;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int ping_rec_timeout;<=
/span><br><span> </span><br><span>     /** whether our underlying data chan=
nel supports new data channel</span><br><span>      * features (epoch keys =
with AEAD tag at the end)=2E This is always true</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1825?usp=3Demail">change 1825</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1825?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I2d4801e282501274396f6421400abe5136e927eb <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 1825 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--JJ9k5b9v6BQ=--


--===============7811585404257755594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7811585404257755594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7811585404257755594==--

