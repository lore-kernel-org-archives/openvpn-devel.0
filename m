Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D063C4450B
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 22:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=p9GOv9uSIV2CkK+NUdpTUpsInmsnnUO2b+eemGaDOqM=; b=l8KgT1rhIFdyBp
	oLN/AMDUU7ZuDtZpXkWL91ULemNBtbx5q8OblN5DVjWyiIamYL21DWPTnByqQ7LMVXTXFBnEANgUD
	MW7nbU5LD0xUQeSzal4TRrtVcnmxFEU0azafyBu+ISY2vQzXxwbWhava9qoOEIN4CjBFHVSovqSC1
	VOg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjlRv-0005sE-IA;
	Tue, 14 Jul 2026 22:18:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjlRp-0005rE-Oi
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 22:17:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Has5QhdXluKF6NKin9xiKCPZeSQqO/Tyx/OH21Mqn1o=; b=Ufuhgu1681mABqft+tNjWQDmlP
 BI2CVU19Rf2SJt4BelSInyNzbgJADDIvgkzJR9wiOyHy9LM+VuUKe3YJDdl7RgSW4bZm4e522sAjT
 UI9MlEKng+Zc9dwDjMDeNISJjiJQaPF1uLYYlrjxYZs5ejh0lh/znsxYkHXEy4HCtenQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Has5QhdXluKF6NKin9xiKCPZeSQqO/Tyx/OH21Mqn1o=; b=I
 zuConhem+so/ydLh7O5wiyUaORyB17nrMXyXESIgaLQe7+/drj7yUHLqwwUVnDMxkhuM25wWvXcC4
 KvAaU2DM5kNFrJ55ebJz9G9Vu19BM3qLESvjQtFKoR+NwXUQFIFQ/RzOykbFEngj9cLWlbvq61NwE
 f2J5UyueQwdWmIEU=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjlRp-0002eV-Kg for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 22:17:54 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493ece78b0cso34553015e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 15:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784067462; x=1784672262; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Has5QhdXluKF6NKin9xiKCPZeSQqO/Tyx/OH21Mqn1o=;
 b=FaTgSv52ugBL4pXzzAN3CblFVckcygmPigIRVxi241nfpKaI3H4E3vRh1CSCRyPdF+
 hQpj7rUaBKpAskhuVT7BtUZ/leRy3Y82CezmTTt3S/C38FNonpo1XMMgI7KeX7rBp94Q
 G5yo6M747kSDOw1Ap3il+4DCpYSp8WfeWIbQpHSNQilipfyD8kPnVcud8qG5zVYhfvsr
 ukJJCxnw8cTNjKp+Pwc1sw9yiYvxe7NuSzwh4aQVj7wZqT5/alUacYdosUiEa4Zw8OLL
 t5IFBO3RETv9rJzOmjtAiLoGZwWJo7Ba3dbbAfMqZRwFflUNmAllINSW+SjWkC34ifxV
 +jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784067462; x=1784672262;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Has5QhdXluKF6NKin9xiKCPZeSQqO/Tyx/OH21Mqn1o=;
 b=dVhaypNNBDQk6TF4qlODYiJ1Zdf03cvfstcU/B7yawul0rbGipiA7HAnsgJVLSUDwO
 bPL6a/katJ39aPSzvRq2Abg8LgxkeBcSz8zSEK2MeS+xGAfCbDp93hImKhpnYyxBBABU
 vDQ/Sv9sYWGDsvYo/e2CSMhTwAaW3wL/BY6+3M/1lkgWyLtBASTMmM0XQQhgmoz7PGpM
 TdrNEW5iyt9eYPiDqxrK1+a7IV818n7ksX/CzJqNRR18IkCt9XYSsPXIUfOBgJElxTKr
 vY5qBuekaSttxbaGiHCrvQE2zOjykB4Trgk+0YaWtXzeEttgFJOyyVCO7e+1TH7LT9U2
 sZBQ==
X-Gm-Message-State: AOJu0YzSuwQkXDqQ7n2G+U161TZVHAkcnRXE28X1A7euhH2BEbmA/jY8
 6AV/2x5JCGgCat2pRPBvjLHSnKmA7n/tKyvzwOgXt7GMsFhOmg2iHqWlFv/BGioXrRc7ZUPSvoJ
 PNN/zUuAtz8ugcIWZVNL7M/T+30ZCo4Ri50HZi3moCo3EVef6vgiQfvaD4c6BsvwwHoA3
X-Gm-Gg: AfdE7cku9a3eoJ5cFLfIFyUral2LC3veuBM+YG6HIUX9/G3KD4gfrjze7tb8VjsvnS9
 2jP4jdEh4Ke0lxDXvedIsnzxtDpVkmUgEW2uMqNbjOY0aXvYLm8zeiMPaoPqigkbVy9+zsVpUHG
 7cgC6X2s7sCjUmuFPSrwr1Hi5jkqTInhXF9p91v6vbCqbC1NLQTaEiQy/1jhnjB3h/Xo7ZvwDN+
 0m00vhjmElfdQTPU3fBOjMfVz3YvWuHj9Iy0HWv8pVdCdhZ0AKmniesfNY0id0HdRHpEOjqjv4U
 yTT+eej/bUs9Di+RjTxUC+pQnlbndgE6suOnklIceohBgSjskSbwXVM5VF5R9vhs2W3+vgLCCZZ
 qobCkblCoSAr+M7p8mIYAiQQMiWMaVu6KaZnMcwTNOMw4F6yqufHtQML3OWC++WU8FSeCEftol6
 /T8fgNJpo5EozFXxMYSFHlbVLaW6IAdO/jetK6ZCEGLTrELrfli5zNkwLPtcweRXHtNr4Iy6/zh
 jHkeZocZPIzVlmtYiSanSqmUxmJuaEI7FIDKv+xna2uvwvoTga0sCAZG+hwCvsj9LUNgAURZuMf
 D1U=
X-Received: by 2002:a05:600c:8509:b0:493:e451:fb8 with SMTP id
 5b1f17b1804b1-49515904c4cmr63900775e9.21.1784067462040; 
 Tue, 14 Jul 2026 15:17:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950873270esm97705815e9.6.2026.07.14.15.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 15:17:41 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 22:17:41 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I37793543cd026aa4917129710c085c808e648c60
X-Gerrit-Change-Number: 1788
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1788?usp=email>
X-Gerrit-Commit: 075653b41714320b083668b0bc60a2460d0b0630
References: <gerrit.1784067448000.I37793543cd026aa4917129710c085c808e648c60@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLkkzNzc5MzU0M2NkMDI2YWE0OTE3MTI5NzEwYzA4NWM4MDhlNjQ4YzYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8f804e24ea75ef2b81cf944444eb4e587270c310-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjlRp-0002eV-Kg
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tests: cover
 subnet_pool6_by_tag
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5670315887746051073=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5670315887746051073==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7zlcIdG3DO8="; charset=UTF-8

--7zlcIdG3DO8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1788?usp=3Demail

to review the following change=2E


Chang=
e subject: tests: cover subnet_pool6_by_tag
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tests: cover subnet_pool6_by_tag

Extend th=
e subnet-pool unit test with the IPv6 tag lookup, mirroring the
IPv4 case=
=2E

Change-Id: I37793543cd026aa4917129710c085c808e648c60
GitHub: closes op=
envpn/OpenVPN#987
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom=
>
---
M tests/unit_tests/openvpn/test_subnet_pool=2Ec
1 file changed, 18 in=
sertions(+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/88/1788/1

diff --git a/tests/unit_tests/openvpn/tes=
t_subnet_pool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=2Ec
index 8e7=
3b64=2E=2Ed01ce05 100644
--- a/tests/unit_tests/openvpn/test_subnet_pool=2E=
c
+++ b/tests/unit_tests/openvpn/test_subnet_pool=2Ec
@@ -60,8 +60,26 @@
  =
   assert_null(subnet_pool_by_tag(NULL, "grpA"));
 }
 
+/* the IPv6 counter=
part resolves independently: a tag may name a v4 pool, a
+ * v6 pool, or bo=
th=2E */
+static void
+test_subnet_pool6_by_tag(void **state)
+{
+    struc=
t subnet_pool6_def c =3D { =2Enext =3D NULL, =2Etag =3D "grpC", =2Enetbits =
=3D 64 };
+    struct subnet_pool6_def b =3D { =2Enext =3D &c, =2Etag =3D "=
grpB", =2Enetbits =3D 96 };
+    struct subnet_pool6_def a =3D { =2Enext =
=3D &b, =2Etag =3D "grpA", =2Enetbits =3D 64 };
+
+    assert_ptr_equal(sub=
net_pool6_by_tag(&a, "grpA"), &a);
+    assert_ptr_equal(subnet_pool6_by_ta=
g(&a, "grpB"), &b);
+    assert_ptr_equal(subnet_pool6_by_tag(&a, "grpC"), =
&c);
+    assert_int_equal(subnet_pool6_by_tag(&a, "grpB")->netbits, 96);
+=
    assert_null(subnet_pool6_by_tag(&a, "nope"));
+    assert_null(subnet_p=
ool6_by_tag(NULL, "grpA"));
+}
+
 const struct CMUnitTest subnet_pool_tests=
[] =3D {
     cmocka_unit_test(test_subnet_pool_by_tag),
+    cmocka_unit_t=
est(test_subnet_pool6_by_tag),
 };
 
 int

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1788?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: ma=
ster
Gerrit-Change-Id: I37793543cd026aa4917129710c085c808e648c60
Gerrit-Cha=
nge-Number: 1788
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@mandelbit=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>

--7zlcIdG3DO8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1788?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">te=
sts: cover subnet_pool6_by_tag<br><br>Extend the subnet-pool unit test with=
 the IPv6 tag lookup, mirroring the<br>IPv4 case=2E<br><br>Change-Id: I3779=
3543cd026aa4917129710c085c808e648c60<br>GitHub: closes openvpn/OpenVPN#987<=
br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<=
br>M tests/unit_tests/openvpn/test_subnet_pool=2Ec<br>1 file changed, 18 in=
sertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/88/1788/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/tests/unit_tests/openvpn/test_subnet_pool=2Ec b/tests/unit_tests/openvpn/t=
est_subnet_pool=2Ec</span><br><span>index 8e73b64=2E=2Ed01ce05 100644</span=
><br><span>--- a/tests/unit_tests/openvpn/test_subnet_pool=2Ec</span><br><s=
pan>+++ b/tests/unit_tests/openvpn/test_subnet_pool=2Ec</span><br><span>@@ =
-60,8 +60,26 @@</span><br><span>     assert_null(subnet_pool_by_tag(NULL, &=
quot;grpA&quot;));</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* the IPv6 counterpart resolves indepe=
ndently: a tag may name a v4 pool, a</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * v6 pool, or both=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_subnet_pool6_by_tag(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct subnet_pool6_def c =3D { =2Enext =3D NULL, =2Eta=
g =3D &quot;grpC&quot;, =2Enetbits =3D 64 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct subnet_pool6_def b =3D { =2Enext =3D &a=
mp;c, =2Etag =3D &quot;grpB&quot;, =2Enetbits =3D 96 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool6_def a =3D { =2E=
next =3D &amp;b, =2Etag =3D &quot;grpA&quot;, =2Enetbits =3D 64 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_ptr_equal(subnet_pool6_by_tag(&amp;a=
, &quot;grpA&quot;), &amp;a);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_ptr_equal(subnet_pool6_by_tag(&amp;a, &quot;grpB&quot;=
), &amp;b);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_ptr_equal(subnet_pool6_by_tag(&amp;a, &quot;grpC&quot;), &amp;c);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(subne=
t_pool6_by_tag(&amp;a, &quot;grpB&quot;)-&gt;netbits, 96);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_null(subnet_pool6_by_tag(=
&amp;a, &quot;nope&quot;));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_null(subnet_pool6_by_tag(NULL, &quot;grpA&quot;));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const struct CMUnitTest=
 subnet_pool_tests[] =3D {</span><br><span>     cmocka_unit_test(test_subne=
t_pool_by_tag),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
cmocka_unit_test(test_subnet_pool6_by_tag),</span><br><span> };</span><br><=
span> </span><br><span> int</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1788?usp=3Demail">=
change 1788</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1788?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I37793543cd026aa4917129710c085c808e648c60 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1788 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &=
lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--7zlcIdG3DO8=--


--===============5670315887746051073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5670315887746051073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5670315887746051073==--

