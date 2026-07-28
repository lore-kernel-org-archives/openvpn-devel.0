Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441F3C54F54
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=oztLTr8c7ND701gvwLuVldqEXgm3QFbgz3h892pxetI=; b=XxWFEVsLQB1oeC
	zELobN4UrOyE1guQHacQdMzpwdKxNYUpAH0nw9sbqCpscHEjXS+QiaKsxVi5y3JrVZgk9+Qc2iO5g
	vL9RVUNJcLDgC7C8muWypLs9PpTlB4mI6VbwNFrPKMg0Qdym3EAAnxS1Dpd/+l0pfOdC0N0/YVnZ3
	+CA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wompx-0006Xw-0t;
	Tue, 28 Jul 2026 18:47:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wompv-0006Xq-Jl
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 18:47:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OCsLnmQgF/P2L4PpEYu1GldgJsN4h71febPmVHKTZHc=; b=do8zqrtDilFQfQxEkJ/ttUQiKE
 MeBnHA1z01yF5akE24HOZFkrkoO72SGjzEsFt82Xo9RNik/1bmiUifYK92L0/hIdLUt1+fQ+2FYw8
 dzl+tIzj0717Dk1d6LSYLhk9gYrXvJZfkLk6+Rgbyp8ejpXP27H+EqNZ+GnHymYdOpws=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OCsLnmQgF/P2L4PpEYu1GldgJsN4h71febPmVHKTZHc=; b=f
 l+FvFZKCjfsauD5EDjLj5FNNIxmf1TmAuMmX+GTOb/vKSJUQprhLt2khdqBvc0RDN4PQlQuZOyrix
 ddivxxbKl2buUvpvHPwKVpibVRapW3ptUNAU+774c3nb72vIsisCNmnfjBsuFpEqW6nFybEaIx+Te
 TXWOYYlzwsO6MN8I=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wompu-0000Wv-Eu for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 18:47:32 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-495437bb891so1361265e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 11:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785264444; x=1785869244; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OCsLnmQgF/P2L4PpEYu1GldgJsN4h71febPmVHKTZHc=;
 b=V4LhiTleHN9vmQq72O05HNM3lyGg9pNm0baFvjU15LT91DDOTmYZ0rpMUacMhZkQs9
 c6mCZkXm/Y0NLP15WUNpFag0yvRtsJmsll0HjdtKda9yFw/UTdS3COwpZnenmFwm4F1w
 14Hc4ebvwQFcfZvVAOhXukhrJbIqbnVZXtRZBEGAki6SBfySrbooluplfHCBrVID39Dv
 G7jmukvsfOlpk74X1h7Ef6KChyH6gDRAvfY0zffUxo9wFH81U+eC6EkIJPzmf6lnpqoY
 x3FYpEWhjzUw/FXqg2Lm/6U2lJuiSesnEqUU/ZiLIN5d/qtqciaVBC9A9Rhdw46Q0vLi
 5SNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785264444; x=1785869244;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OCsLnmQgF/P2L4PpEYu1GldgJsN4h71febPmVHKTZHc=;
 b=CDZDDfA0gBCG7xn15H5AVJgGrEpm1pyVwRuyHLLqB+qqfzYrJsUjH0ms2MLd6bfLbG
 0OMwY3dDXtj3aEM74FJfaMUl/3mktbL4ldIaYhSJV84c9qt5ig1o8RWk6725PE4MC19u
 0+f7BTgT6OziVJm58uZBf2cMKgqIWK69fIYJN8oohvWgd5NFZXVYnlbT87PEvnxp/7WK
 Jr/cymjxqqd14vtohHfM+Lot+OwDAqRqGkY2RjorRwylIZiA7HllJ4s0BLT8YCjCWL/f
 bRa+XgJvlETR+NSw+Y72mEreNOOYfjlQm9BPbC9/Oi+oQrlB/rDE9qZT6B6kq/4IhWsY
 iAYA==
X-Gm-Message-State: AOJu0Yz3J5t3RH3WN0cCI/2wuNGlJ/X6x/s0ntPsavTqq94UmHPEVmEz
 Rf3+pj/Dmmu1YTfsn8TCdmmVpeDgRzSRR7u5iKBxusnFGijp6yPIV3bGTaLlyJN1V88FRzdgX/u
 W4JexniC7kVq53LhjETpmX5mR2AyQzhZl2ta6GWaL+usSdrT7v9f5ekOZPO4RwNN7fA7vjaI042
 b4NghsUg==
X-Gm-Gg: AR+sD11s6d0kDXzm5Z6m9vRLc1dFeXmjmpM1Gh/sWNxrUJN+yVYOoH4hGvDiphx4+kp
 A1CJmn25XNxv4X2ei8HQhEJz88lhmS3hsX4N9zI7fMCU+MWYT97dMMwe8Pee2Dpq8gPe/6b9yUx
 EepKlgRNwmkPJ0TwtG1q1RurHFPPWr7BGgJhOjrCiuYEWNmmjI+fQZUnE5a7ub9xadWzpzScFly
 mCRd1nmZW9fomzF7qKGWaYsGsZqbkLCKZ8VfA/lx8YqVxib2NP/qaKAKMFyPjCKoArzVDVk86b8
 p+oeqp9s1e0/JxYu8uTU/mRJgiKf46loykqNTzllT4iY4hg5xDmi8jsQcP69aPX61OCBvrXTqTD
 Vfemfc2lkfSG9xpQS7/ML2JtH1INrB+J8I1pu/zHFedZ39cIE44U2FgtaxV1/T9leu2FRIYcB0L
 Roi9wywZr5Zu3FYIG0RMvlRi9hz3gm0SlUroB9Imv9zVOjo260XQW3FQ0iDUg0i/z+HwzBtzWzB
 MZXOyf67bdguBZ0i81G0l7OZJG5oFSwvU0mPLAmRRVqriGI381LPEVItOGsA79c60jJ
X-Received: by 2002:a05:600c:5291:b0:495:6193:c6c0 with SMTP id
 5b1f17b1804b1-496c658f6cdmr37576695e9.18.1785264443726; 
 Tue, 28 Jul 2026 11:47:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49764d72d9asm147055e9.3.2026.07.28.11.47.23
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 11:47:23 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 18:47:23 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e
X-Gerrit-Change-Number: 1829
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1829?usp=email>
X-Gerrit-Commit: 8633bd5a871a62e457eeb592467f2af21678e7b6
References: <gerrit.1785264441000.I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjY0NDQxMDAwLkk1Yjg2MmVhYmUwMzJlYjRkMjIyOWZmNWIyZjRmNmFmNzQwNmY2ZjRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <938d5a20855a05d8ab820a91f54fb66e4b1dabcb-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wompu-0000Wv-Eu
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Correctly calculate
 packet id size when epoch is in use
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
Content-Type: multipart/mixed; boundary="===============6113282558043119830=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6113282558043119830==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rvE9/iKNqBk="; charset=UTF-8

--rvE9/iKNqBk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1829?usp=3Demail )


Change subject: Correctly calculate=
 packet id size when epoch is in use
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Correctly calculate packet id size when epoch is =
in use

Even thought packet_id_long_form has a the same size (8) it is not
=
the same header format (32 bit time + 32 bit IV) as the epoch
format (16 bi=
t epoch + 48 IV)=2E Use a simple sizeof(uint64_t) to
avoid suggesting that =
it might be the same=2E

Closes: Github #1074

Change-Id: I5b862eabe032eb4d=
2229ff5b2f4f6af7406f6f4e
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
-=
--
M src/openvpn/mtu=2Ec
1 file changed, 7 insertions(+), 0 deletions(-)


=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/29/1829=
/1

diff --git a/src/openvpn/mtu=2Ec b/src/openvpn/mtu=2Ec
index e5db8ab=2E=
=2Ed5fec80 100644
--- a/src/openvpn/mtu=2Ec
+++ b/src/openvpn/mtu=2Ec
@@ -3=
5,6 +35,7 @@
 #include "crypto=2Eh"
 
 #include "memdbg=2Eh"
+#include "ssl=
_common=2Eh"
 
 /* allocate a buffer for socket or tun layer */
 void
@@ -5=
1,6 +52,12 @@
 calc_packet_id_size_dc(const struct options *options, const =
struct key_type *kt)
 {
     bool tlsmode =3D options->tls_server || option=
s->tls_client;
+    bool epoch =3D options->imported_protocol_flags & CO_EP=
OCH_DATA_KEY_FORMAT;
+
+    if (epoch)
+    {
+        return sizeof(uint64=
_t);
+    }
 
     bool packet_id_long_form =3D !tlsmode || cipher_kt_mode_=
ofb_cfb(kt->cipher);
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1829?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e
Gerrit-Change-Number: 1829
Ge=
rrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--rvE9/iKNqBk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1829?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Correctly calculate packet id size when epoch is in use<br><br>Eve=
n thought packet_id_long_form has a the same size (8) it is not<br>the same=
 header format (32 bit time + 32 bit IV) as the epoch<br>format (16 bit epo=
ch + 48 IV)=2E Use a simple sizeof(uint64_t) to<br>avoid suggesting that it=
 might be the same=2E<br><br>Closes: Github #1074<br><br>Change-Id: I5b862e=
abe032eb4d2229ff5b2f4f6af7406f6f4e<br>Signed-off-by: Arne Schwabe &lt;arne@=
rfc2549=2Eorg&gt;<br>---<br>M src/openvpn/mtu=2Ec<br>1 file changed, 7 inse=
rtions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/29/1829/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/mtu=2Ec b/src/openvpn/mtu=2Ec</span><br><span>index e5db8ab=2E=
=2Ed5fec80 100644</span><br><span>--- a/src/openvpn/mtu=2Ec</span><br><span=
>+++ b/src/openvpn/mtu=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br><spa=
n> #include &quot;crypto=2Eh&quot;</span><br><span> </span><br><span> #incl=
ude &quot;memdbg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;ssl_common=2Eh&quot;</span><br><span> </span><br><spa=
n> /* allocate a buffer for socket or tun layer */</span><br><span> void</s=
pan><br><span>@@ -51,6 +52,12 @@</span><br><span> calc_packet_id_size_dc(co=
nst struct options *options, const struct key_type *kt)</span><br><span> {<=
/span><br><span>     bool tlsmode =3D options-&gt;tls_server || options-&gt=
;tls_client;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    boo=
l epoch =3D options-&gt;imported_protocol_flags &amp; CO_EPOCH_DATA_KEY_FOR=
MAT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (epoch)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return sizeof(uint64_t);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>=
     bool packet_id_long_form =3D !tlsmode || cipher_kt_mode_ofb_cfb(kt-&gt=
;cipher);</span><br><span> </span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1829?usp=3Demail">=
change 1829</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1829?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I5b862eabe032eb4d2229ff5b2f4f6af7406f6f4e </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1829 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--rvE9/iKNqBk=--


--===============6113282558043119830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6113282558043119830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6113282558043119830==--

