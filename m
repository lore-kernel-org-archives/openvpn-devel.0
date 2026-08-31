Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4309C624CF
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=PLFxhGtp0E6iK7xbyt8rwH9mj+SxBbD3eCJFiLI/JB0=; b=fpoyW45o6qXG4w
	UZG2zaZARR4iIua4qQj9xDeEgrNDtyYWTjfgqdRVUtam2B4MaXWs7KW/L2y4g56dgRLk11Vs5Szox
	BJ9bP5efDDghQysvs5FKIz3QHADDCL2LuSxPlpiqJzV9v6/VFIlmh8rYxQn3EruFVwjYROmxg8Us6
	Csk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x14Th-0000Zq-Dh;
	Mon, 31 Aug 2026 16:03:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x14Te-0000Zj-83
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 16:03:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g2mjukR084xYy5FJkCzJ4mAwkOovhRr0uhkaISeiHrU=; b=Zn2tOrv6M8Z9dgt2cuvkJpu1or
 1IZGy9HBeAosb11BBEC5dNpmSeBml8D/Xa4V4gq+idPlhglKSpXvVMqX+Oedj+g3zAkGHsiaFHMXX
 qShZap0ugSUduD542eFDvwvTFqmSef97XH/fCqo068RsChrju206oi18mnCx1aNuK16w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=g2mjukR084xYy5FJkCzJ4mAwkOovhRr0uhkaISeiHrU=; b=H
 vq8WOes/ZMwVzZx0SfzvJEje8TnVcOL7iakzv9ZvCVRb0ypmUPESi7CTBjL2xLcynRbBILf8D0PnT
 4sMNNZDY6EEmQxTjdTdhaw41v/HAgytfncjaa83YxqBOuLX3pVUJ3QLUtGvPvaJEimgo0h3KdD2z4
 DSmwMX38MaeQoFDs=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x14TZ-0007mI-T7 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 16:03:15 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4843efcbdb2so497208f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788192187; x=1788796987; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g2mjukR084xYy5FJkCzJ4mAwkOovhRr0uhkaISeiHrU=;
 b=M3gnKqqh2jskLZ3MaWNz6eBUMRr0NHw4OsLvsiD7C5TwBdMMb9IC9E9trFuB+SF4sL
 yt6UbD3Vcd+lHmkNEzLTZO4Ss99qCtodCIZEUt/6/yPC7gpmOzaoo7s/wTZpuBnq1FYj
 33AQr+5+ZiKx+9Bo6a0X7jAKtSMMa37kFqiyeckyZ3vU8py8D/ipg6HsIcGAuJfmN+AG
 rofxhncmVSpMrYvoRW7EgTz6/0IMe10bd6l0LtmCEzxfYK4c19oyiiNjjGjZtTGkp6Or
 5uUGB/Xq5Xv3AmYCdJJmyl7a6q5Yotwz+8th0eDd7z4TFxD8kClN5zR0BpKTJjXFLVRU
 Wcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788192187; x=1788796987;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g2mjukR084xYy5FJkCzJ4mAwkOovhRr0uhkaISeiHrU=;
 b=Ke+LZMVMxrwvKeNE8ds70+A/YCM5dPYhE+6nnE900r2Pwhbd/2CZYa3DhfhsjdzoKH
 SpTTK+iOCwdAw+BjdbNPO0JNWShNu9zQLW5CxZOcl2Hu0S1rqSiJxohLynA/CPG4M5Y7
 lDaaWk47mbBfOVS4G1G+MGolRgoXn20skFFoF28NQ6pKeF80560SaoGiPDVNJbcddBJ/
 I4rsfwEWzSn5GYfNr2WyI8HHF1NAMGS2guxovFiRiWI4qlT+v5FFuT42ILgMBI7CeJlt
 2cAkSAaAEtnXb9llsyNKA/c/EYS77LYH3xQ8eurCPg2us/+Tq8OMqoRko9yBPVvXFxsu
 IqVQ==
X-Gm-Message-State: AFuF++mqGqVS0a0DMiHvCkKFmcPBBHQ5+mXrcShQ7YoXl358rX+T62MR
 Krq8reKS+jFHw7TMu6hwO49vnebk9jTRf/G/zlcrrAIAdxJkIJ1ealWisGbWKIorChRb3FIdOXt
 SkEnBzepLeDQkCEu2F5udAifRTqwpECNDV+QmSBCcH8MbcoXVT72EnYXVO1Q0aw2n7OatA5nxcp
 Pn9h/5FQ==
X-Gm-Gg: AYBFou0Zt3ojlJeGeX9QMQnKcftAhgTHpKP0eGPKtq55S7NFB53l6SfnzA6u0kggDEu
 Htt4REhf5sxgz+XgxaEwQTKYu0ZRtDUY/rRFfYbESM4UkiXZhBlT8LGRb2rw3rRLNCO8Uotl8cz
 PodWrVUCQ2WJslufAhik2Du0iLrBZBJDEtFfzdJpgC2CFkGLuF+uwnLn8YFHKOvEydwkLW2kPjP
 dFfM3ZV3tXeev8EOH6N15aEhZ2oSnaCrb01EN9HpJs6g5WYdJTEBk64r1GNU4ZKV/2h+w8oaIKF
 ZO+mlHQPut/gMNHfoY6TA7d5Z8AbaS8h8iSGwcyNVACtW4KHRwyKsokZUxvAFDh/veXvUjUgf5l
 y/3xkjU5roZwuY9V21z7BTzRWoC+w8gmvfxrx/f1bhMm4IjZL/cH9oYbcoJ/9ATws9NdxclVeFX
 VRr5ouU1tFzEeFoIpjRj1cRDHo2dOes/Q+VJLIf2jFUE3JOHXlGFIcpP1Wux1NB95MH8hv41cFs
 L2X2xySmhuA91vwMIFRZ1ensVQWuApEEAiuHbinlIxnEgz9UWvRA+MxQfQMZxTLbP8Z2tSmmDKJ
 QYF+O2CgzWe6PPkZ2ELHcQdQ0p+UERXshMg8gXEFc00tEmbwdBU=
X-Received: by 2002:a05:6000:41d1:b0:484:3310:f39b with SMTP id
 ffacd0b85a97d-48441043a69mr3660839f8f.28.1788192186882; 
 Mon, 31 Aug 2026 09:03:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20122sm23162751f8f.20.2026.08.31.09.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:03:06 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 31 Aug 2026 16:03:05 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182
X-Gerrit-Change-Number: 1886
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1886?usp=email>
X-Gerrit-Commit: d1e87a4b4ec6a953063ff9be501595571c17d921
References: <gerrit.1788192180000.Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTkyMTgwMDAwLkljOTgzYTNiZjFlZThkNGVmOThmMzg4M2Q1ZTVkZGYyMzQ2OTZhMTgyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a951adc4e6ef6e5da8c7be1c45b610e04bb89a87-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x14TZ-0007mI-T7
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: harden
 CheckConfigPath() a bit more
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0116199956902411815=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0116199956902411815==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6bNwfbEL43U="; charset=UTF-8

--6bNwfbEL43U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos=2E

Hello plaisthos,=


I'd like you to do a code review=2E
Please visit

    http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1886?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: harden CheckConfigPath() a bit more
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: harden=
 CheckConfigPath() a bit more

If the config_path retrieved from the Regist=
ry doesn't end with a path
sepatator, the prefix check could be satisfied b=
y a sibling directory
that starts with the same substring, e=2Eg=2E "config=
" vs=2E "configx"=2E While
code in common=2Ec ensures this, that code could=
 disappear in the future
leaving the check vulnerable=2E Instead spend the =
few CPU cycles to be
absolutely sure, we're doing the right thing here=2E

=
Discovered and reported by BreachX Zero Day Labs, using Typhon AI Mil v2=2E=

Contributing Researcher: Vivek Parikh=2E

Reported-by: Vivek Parikh <vivek=
=2Eparikh@breachx=2Eai>
CVE: 2026-78043
Change-Id: Ic983a3bf1ee8d4ef98f3883=
d5e5ddf234696a182
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
=
---
M src/openvpnserv/validate=2Ec
1 file changed, 7 insertions(+), 1 delet=
ion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/86/1886/1

diff --git a/src/openvpnserv/validate=2Ec b/src/openvpnserv/va=
lidate=2Ec
index e3ef8b6=2E=2E8e529b9 100644
--- a/src/openvpnserv/validate=
=2Ec
+++ b/src/openvpnserv/validate=2Ec
@@ -62,7 +62,13 @@
 {
     HRESULT =
res;
     WCHAR config_path[MAX_PATH];
+    const size_t config_dir_len =3D=
 wcslen(s->config_dir);
 
+    /* config_dir must end with a '\' or the pre=
fix check below could be satisfied by a sibling directory */
+    if (confi=
g_dir_len =3D=3D 0 || s->config_dir[config_dir_len - 1] !=3D L'\\')
+    {
=
+        return FALSE;
+    }
     /* fname =3D stdin is special: do not tr=
eat it as a relative path */
     if (wcscmp(fname, L"stdin") =3D=3D 0)
   =
  {
@@ -83,7 +89,7 @@
         res =3D PathCchCanonicalize(config_path, _co=
untof(config_path), fname);
     }
 
-    return res =3D=3D S_OK && wcsnicm=
p(config_path, s->config_dir, wcslen(s->config_dir)) =3D=3D 0;
+    return =
res =3D=3D S_OK && wcsnicmp(config_path, s->config_dir, config_dir_len) =3D=
=3D 0;
 }
 
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1886?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newc=
hange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic983=
a3bf1ee8d4ef98f3883d5e5ddf234696a182
Gerrit-Change-Number: 1886
Gerrit-Patc=
hSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: d12f=
k <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: d12=
fk <heiko@openvpn=2Enet>

--6bNwfbEL43U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, plaisthos=2E </p>
<p>cron2 would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1886?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">openvpnserv: harden CheckConfigPath() a bit more<br><br>If the config_=
path retrieved from the Registry doesn&#39;t end with a path<br>sepatator, =
the prefix check could be satisfied by a sibling directory<br>that starts w=
ith the same substring, e=2Eg=2E &quot;config&quot; vs=2E &quot;configx&quo=
t;=2E While<br>code in common=2Ec ensures this, that code could disappear i=
n the future<br>leaving the check vulnerable=2E Instead spend the few CPU c=
ycles to be<br>absolutely sure, we&#39;re doing the right thing here=2E<br>=
<br>Discovered and reported by BreachX Zero Day Labs, using Typhon AI Mil v=
2=2E<br>Contributing Researcher: Vivek Parikh=2E<br><br>Reported-by: Vivek =
Parikh &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>CVE: 2026-78043<br>Change-Id:=
 Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182<br>Signed-off-by: Heiko Hund &lt=
;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M src/openvpnserv/validate=2Ec<=
br>1 file changed, 7 insertions(+), 1 deletion(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/86/188=
6/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpnserv/validate=2Ec b/src/openvpnserv/val=
idate=2Ec</span><br><span>index e3ef8b6=2E=2E8e529b9 100644</span><br><span=
>--- a/src/openvpnserv/validate=2Ec</span><br><span>+++ b/src/openvpnserv/v=
alidate=2Ec</span><br><span>@@ -62,7 +62,13 @@</span><br><span> {</span><br=
><span>     HRESULT res;</span><br><span>     WCHAR config_path[MAX_PATH];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t con=
fig_dir_len =3D wcslen(s-&gt;config_dir);</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* config_dir must end with a &=
#39;\&#39; or the prefix check below could be satisfied by a sibling direct=
ory */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (confi=
g_dir_len =3D=3D 0 || s-&gt;config_dir[config_dir_len - 1] !=3D L&#39;\\&#3=
9;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     /=
* fname =3D stdin is special: do not treat it as a relative path */</span><=
br><span>     if (wcscmp(fname, L&quot;stdin&quot;) =3D=3D 0)</span><br><sp=
an>     {</span><br><span>@@ -83,7 +89,7 @@</span><br><span>         res =
=3D PathCchCanonicalize(config_path, _countof(config_path), fname);</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return res =3D=3D S_OK &amp;&amp; wcsnicmp(config_path, s-&=
gt;config_dir, wcslen(s-&gt;config_dir)) =3D=3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return res =3D=3D S_OK &amp;&amp; wcsnic=
mp(config_path, s-&gt;config_dir, config_dir_len) =3D=3D 0;</span><br><span=
> }</span><br><span> </span><br><span> </span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1886?u=
sp=3Demail">change 1886</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1886?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ic983a3bf1ee8d4ef98f3883d5e5ddf234696a182 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1886 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@openvpn=2Enet&gt; <=
/div>

</body></html>
--6bNwfbEL43U=--


--===============0116199956902411815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0116199956902411815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0116199956902411815==--

