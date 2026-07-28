Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0621DC53219
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 22:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+AvegGPrr+pxS/eglkPpv0POebwBdATwUA6VH5UHWhc=; b=Js4SzcQgCBSl8iMPgHyRZPKcKu
	IgvAFe4MISBoLS9FiRS+jjWassdLORRJQeULG1B8za7XnVZWb972f1n/9T9LIABkpxbAKwd9RYCa9
	xJz+nmm2uuPDucIVSWZobmSGXSNRfoOpl58ZZZo4bBRWAc3S5Ozt3AeaxgM3Cw5HRss4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woqF7-0003Mj-Vm;
	Tue, 28 Jul 2026 22:25:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woqEf-0003LM-8P
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 22:25:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=g0zLu0Tq97SqsaDRjIA0rEoyejAKh+nyXQeOU+uChZE=; b=KHKNHF4hOYRtf2T8CJXzvdUDKr
 EjmEdGPRX1j40L0Zn49nkQ3T5AKRYpP4KkcuV+an5IJRctWN/qOxd8GALt53bprZNKKqYLIcUN1T3
 rueXbMUkDJEBRQswtPf/cEk0YvE7St+gVJyejnAQszZ3EsAokqJrT0ElmthL+3k1L6n0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=g0zLu0Tq97SqsaDRjIA0rEoyejAKh+nyXQeOU+uChZE=; b=b
 Td9xUAM1Hp25ssN3+7cm9R5Bcz/pPviO2iv7fZFdcS1CoX87OyVPOLdwye1m6LH8HG5uvoM9I2qiC
 qPLrcvmcNjBNnxCr5HxeFqMhj+j9i9txd+CdAXMo8u/afvNljHUvTg4/gpi779cq4/8l2cV4EEzcH
 8tFBv3v45FjiZPx0=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woqEi-0007DZ-Db for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 22:25:17 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49548aebcd8so2147935e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 15:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785277510; x=1785882310; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g0zLu0Tq97SqsaDRjIA0rEoyejAKh+nyXQeOU+uChZE=;
 b=Xq3C7rPAmWDV6f3zbvWy8PVoCl0t3CZnAFTj8VC8IxSJ7ynNeeVnsioG116X+c6xDP
 W0WLpL5d35513YgPbpiJh3i34TRygRilhIUV4BLnpYR1lSIbok3Yw0iMKZ/I83FlGabO
 2UN5itOSJyc1qocmQukSqP3Ivi4Il5i4s7824zA2CQEc6lqCeRlKqFeefE0MwmrJpL/3
 g90mD8Ez79j3l5mfeDFUk6b8tczLytrYOfzDHxvBe9uIPGUKSouVY8dXKvmwmvmqYS5L
 3/z+z/O3gYY+JCHjRe5bOWzgoDMmiCPNlQVaAWMrJf7MiNkuM4OQa6j7Lrk/8SdxexeJ
 vAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785277510; x=1785882310;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g0zLu0Tq97SqsaDRjIA0rEoyejAKh+nyXQeOU+uChZE=;
 b=cKvnAJupX4scq0FwVrWGW8M+xccPppabVZ8VPm6Rc8vQ8ctClp3ug2Iyz18DZgQJwh
 HFkBMolNzlhjCmsuswVaRgG0T45IBJQ2xiRh6vZ8T+1XKaQrPNEH3LHCG0n6qpkrFwX+
 SLat/gJX/B4IQsh/sxMAIBRQAcMMz3NRSRQ0IMXkFMWtAir57Zqxy62vGIWHzcuS0BY5
 eThk+UajnOqkqZ6P+GH1bou+qPj7+OqAQpLi32UQYl1d5vsqwVLGKy523NJdBtLgieel
 98Ow/A7CsSvs8tfJRz95KcWvfM4egB+2dEvHs0RuM74wBxzjnDJaAt+coRBTh3gbPH7Y
 dsBA==
X-Gm-Message-State: AOJu0YwLecNAF8s42keFWtHjouXCBoum7muTtlsmf4zJLVvCr3PmNt6f
 hJa6auZpPrwVSOQ1X2UH9fROS0ADQIeH6SZjJHCdBA2mv5fmG3Y6IPZh+ijPUVtl94bqeZgKKwv
 MAKVibaRk6/XSmtSSaAFRKwSBspgTx2MbswN9LTuolJsvo1H9AE6PrtuOBcGu1DfnyqrTc4l29y
 j2j+R0uA==
X-Gm-Gg: AR+sD137FgAFqzf2e27ypNuybfr2D2RaYZlPi9Ci12cJZWlckGdN+nBL96qy8osWAaV
 EggD/weqqOcR+I9/3lxsGTp7yObH837DNMqEQpDN4eaFlvYaAbiB7Ph3uB6oE/VZNrheaw0Vok+
 QqDysSRAzXGsZBN4LX3hW/Dbez+hqBg74Vj1ioBA2xsljg0TBD5WYeiiKJGnOSiTbfeCprusoE4
 jicYlYmvVAkOP2D/sVGN1ZoY96KJdQI8k2DJGdUL/hRCsOuZBySXYbFKHNbQjBlW7KwsV9WOxcE
 eV0axFg/vPFJpNVfCGdULw7vAQu4+zmFiqpARLFgJYINVicarKZ9SHZ3/2XDe5tkx2BC4vZQArV
 BOy7b10iNe+n+YW/XWJOJih/P3jd1IlZTf3u//EVZilsL5PaH1mBMrvT0bQ8/EEKEMFPi8iNfg9
 oZE3dCei8mlouTWBzp1W4nflJ5SCRHUmgP2is0Gr+WkbUdZpsZ3HlH67nz53l/P52aSQnyW/6Je
 kKEWZ820ZdtZLs+GKw+soYoEalUdx0MGg8P7Ju2fd4ETS3eG3//p5ERcPnj0u+5pOdk6nL1DAYx
 YHccrmkkHFSLPUc5SJmxRN4SoG4spytudwl7FP8tVk5EJ6lzZPQWmbSHvX+gIw==
X-Received: by 2002:a05:600c:3f10:b0:495:7278:95c3 with SMTP id
 5b1f17b1804b1-496c657de59mr43403885e9.26.1785277510225; 
 Tue, 28 Jul 2026 15:25:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49764d72d9asm12615515e9.3.2026.07.28.15.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 15:25:09 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 22:25:08 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e
X-Gerrit-Change-Number: 1829
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1829?usp=email>
X-Gerrit-Commit: c4c3172a707875fbb49f214adb2c12526d545488
In-Reply-To: <gerrit.1785264441000.I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e@gerrit.openvpn.net>
References: <gerrit.1785264441000.I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjY0NDQxMDAwLkk1Yjg2MmVhYmUwMzJlYjRkMjIyOWZmNWIyZjRmNmFmNzQwNmY2ZjRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d24dcfa14e95d75aa7e7c9a1182461fc0af0859d-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woqEi-0007DZ-Db
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Correctly calculate
 packet id size when epoch packet format is in use
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4415538135897546696=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4415538135897546696==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9EO6F7awFTc="; charset=UTF-8

--9EO6F7awFTc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

Hello ordex, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1829?usp=3Demail

to look at the new patch set (#2)=
=2E

The following approvals got outdated and were removed:
Code-Review-1 b=
y ordex


Change subject: Correctly calculate packet id size when epoch pac=
ket format is in use
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Correctly calculate packet id size when epoch packet format is in u=
se

The code assumed that always when tls mode (without CFB/OFB) is in use
=
that the packet size is 4 bytes=2E With epoch packet format is incorrect
as=
 that uses 64 bit=2E

Even thought packet_id_long_form has a the same size =
(8 byte) it is not
the same header format (32 bit time + 32 bit IV) as the =
epoch
format (16 bit epoch + 48 IV)=2E Use a simple sizeof(uint64_t) to
avo=
id suggesting that it might be the same=2E

Closes: Github #1074

Change-Id=
: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e
Signed-off-by: Arne Schwabe <ar=
ne@rfc2549=2Eorg>
---
M src/openvpn/mtu=2Ec
1 file changed, 8 insertions(+)=
, 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/29/1829/2

diff --git a/src/openvpn/mtu=2Ec b/src/openvpn/mtu=2E=
c
index e5db8ab=2E=2E1f64a8a 100644
--- a/src/openvpn/mtu=2Ec
+++ b/src/ope=
nvpn/mtu=2Ec
@@ -35,6 +35,7 @@
 #include "crypto=2Eh"
 
 #include "memdbg=
=2Eh"
+#include "ssl_common=2Eh"
 
 /* allocate a buffer for socket or tun =
layer */
 void
@@ -51,6 +52,13 @@
 calc_packet_id_size_dc(const struct opti=
ons *options, const struct key_type *kt)
 {
     bool tlsmode =3D options->=
tls_server || options->tls_client;
+    bool epoch =3D options->imported_pr=
otocol_flags & CO_EPOCH_DATA_KEY_FORMAT;
+
+    /* epoch uses a 64-bit pack=
et ID consisting of 64 bit (24 bit epoch + 48 bit IV) */
+    if (epoch)
+ =
   {
+        return sizeof(uint64_t);
+    }
 
     bool packet_id_long_fo=
rm =3D !tlsmode || cipher_kt_mode_ofb_cfb(kt->cipher);
 

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1829?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af740=
6f6f4e
Gerrit-Change-Number: 1829
Gerrit-PatchSet: 2
Gerrit-Owner: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ordex <antonio@mandelbit=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ord=
ex <antonio@mandelbit=2Ecom>

--9EO6F7awFTc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p>plaisthos <strong>uploade=
d patch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1829?usp=3Demail">View Change</a></p><p>The follo=
wing approvals got outdated and were removed:
Code-Review-1 by ordex</p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">Correctly calculate packet id size when epoch packet format is i=
n use<br><br>The code assumed that always when tls mode (without CFB/OFB) i=
s in use<br>that the packet size is 4 bytes=2E With epoch packet format is =
incorrect<br>as that uses 64 bit=2E<br><br>Even thought packet_id_long_form=
 has a the same size (8 byte) it is not<br>the same header format (32 bit t=
ime + 32 bit IV) as the epoch<br>format (16 bit epoch + 48 IV)=2E Use a sim=
ple sizeof(uint64_t) to<br>avoid suggesting that it might be the same=2E<br=
><br>Closes: Github #1074<br><br>Change-Id: I5b862eabe032eb4d2229ff5b2f4f6a=
f7406f6f4e<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---=
<br>M src/openvpn/mtu=2Ec<br>1 file changed, 8 insertions(+), 0 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/29/1829/2</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mtu=2Ec b/src=
/openvpn/mtu=2Ec</span><br><span>index e5db8ab=2E=2E1f64a8a 100644</span><b=
r><span>--- a/src/openvpn/mtu=2Ec</span><br><span>+++ b/src/openvpn/mtu=2Ec=
</span><br><span>@@ -35,6 +35,7 @@</span><br><span> #include &quot;crypto=
=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ss=
l_common=2Eh&quot;</span><br><span> </span><br><span> /* allocate a buffer =
for socket or tun layer */</span><br><span> void</span><br><span>@@ -51,6 +=
52,13 @@</span><br><span> calc_packet_id_size_dc(const struct options *opti=
ons, const struct key_type *kt)</span><br><span> {</span><br><span>     boo=
l tlsmode =3D options-&gt;tls_server || options-&gt;tls_client;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    bool epoch =3D options-&gt;=
imported_protocol_flags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* epoch uses a 64-bit packet ID consisting of 64 bit =
(24 bit epoch + 48 bit IV) */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (epoch)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn sizeof(uint64_t);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span> </span><br><span>     bool packet_id_long_form =
=3D !tlsmode || cipher_kt_mode_ofb_cfb(kt-&gt;cipher);</span><br><span> </s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1829?usp=3Demail">change 1829</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1829?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5b862eabe032eb4d2=
229ff5b2f4f6af7406f6f4e </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1829 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;=
antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;=
antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--9EO6F7awFTc=--


--===============4415538135897546696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4415538135897546696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4415538135897546696==--

