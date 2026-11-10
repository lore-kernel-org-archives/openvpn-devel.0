Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098F7606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Bm7NDW7l;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JVICP9a+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XztxQG73;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=M1TvKaP4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=mVVWee02MZqfmsdvzdvAEJcJ1iHVAIa2KnCjRi9RIsg=; b=Bm7NDW7l5/xLVx1/kHuzNuuyUN
	a3XUU3rtGIkwIB/v+YxRirFRt4AoH1cZYCqkyDtcVkkBVOuSiHxPEFhd+0Wm34H8H8g0ssO5n2xYq
	RRou72zjQE0H18vLyzXWOd30Wx4K3whPL3wLtkbjKmpdOjD7YkVMDLSM2RKInif/azyg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQkvn-000000002vP-21Qp;
	Tue, 10 Nov 2026 12:26:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQkvH-000000002tm-0DHR
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:25:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1aLzPpByeoL+OcoYteaQ8PTSuqf+xLlfT2NJTl665AQ=; b=JVICP9a+R5ngwtLF6je/247Z7f
 ZJlWCU+us82YsHWCNGt5hry35Hs7hojgyWlNOqmofNvfzWdLo86QcJmfS/bAv6TYe/uL8m31FM/vy
 v40ymkgWP0EPJqB6K2RU1EFhD/wi5B5MVBsOiuENQO6icO5eFFTNbHCG7451/76SIgRM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1aLzPpByeoL+OcoYteaQ8PTSuqf+xLlfT2NJTl665AQ=; b=XztxQG733mWS8fzc4NnZH1R7oX
 RQ++VNKleQMeoqg0FieC9El8WWedQQYuQOmOrBbpHQ2ibzk/xCoMq4+Wo1vjByJTNoV00HHlC/EDS
 OBTmNJhXbsdvZOwcNJM1jHEEwXeg1nyUPve8lDpUhQzlYEEiV1PosdLmJEeY2cIGWN4k=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQkvG-000000005Y7-15Ra for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 12:25:58 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so11753985e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 04:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794313552; x=1794918352; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1aLzPpByeoL+OcoYteaQ8PTSuqf+xLlfT2NJTl665AQ=;
 b=M1TvKaP47mZQ0EiieiKqmcNE2t8pbOahHxGU++TKbtUhp8AQlXMmMFuTBBgu3w6a4Q
 nqMdru/NNuit8tcdqA7q2zrg+TV86Cdq12zQYH2H5wJ/YPlEywQHBdnfAs2YUjUR5S58
 CSy0kJ9e3UBAih/9OHa4/+IEmkwSW78DdFf6qiSz4o08hW1ea0FPXJOstUhKEtJenBK1
 wR7xM89MMDxpURJ5wCNZYLMjxNhAeTqvsBYgPWA3f8i5d1dAdoWNRZsMhVf1JBaDAtXI
 YrGv+eXXLy2B5mwANwPMSwbhehaaHhLBiRPGqmLpNbbCxvfA6E2x4HN9pJx8ZhxhR5NB
 qcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794313552; x=1794918352;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1aLzPpByeoL+OcoYteaQ8PTSuqf+xLlfT2NJTl665AQ=;
 b=HLW8SoHPymoAOZrpSzAGRxOFWUQXddaoL8IU42RJ0Kv/xR537FYLQGPPsbNz7LkaYu
 Cxt9rHSIkYCbQQ/50O+oLtLK3Z6TNwsRYabcURLnmzkrjQ2FVbGKWHEHQo2EcjNLoYqA
 ich2D8w9/FQoJzxth90Y4Wx9Jtnv6T3bhQeuF9OwRovd9kcRe1Twpn1CKICmjqfJLi0r
 HwqHDNks/78b1wkJ6H+mJaRe1Vgj7cnBu8xZYB/mj/6OQaEikek8LeR7CcstMO8lRI+8
 ycBNDPQdnUL9qBujjYHXcetGLbGe2ZLP06ZAGDkXbuAkXUhX0qZFaz6Ylilzki2Ie/gS
 1ANw==
X-Gm-Message-State: APuU4Z9kcWcd3lVlII2toPI8Env3y0CqmPCO3yBoSwgzBQVyodNnT5qf
 BuK+Ofry2dNHi6+stawC4bxjG0V6Ulii0vJbzUgJFm9k87/ffRJk6jte8Y9HVUCNx8D7WloXmG0
 6WrW87jqZrbx+/wumEis6cV7CpteRU917hc0kcxrUdSZ/RpcoCbE1pgCi/2IZpWeLh3WkKrvLaY
 cJPowgVQ==
X-Gm-Gg: AYBFou1KrXAArmkrC5/DMQdDG5LaYOjwRB8cZCN6OOzhUEV8ppfcUs/ADz9pprgbBdu
 hwl2InZH3/H/HotkDzfZKtFYNyDmqeT5e3la9oMLoZz1HloOhl7G8HKmCIqgX28704QqrZv9R0M
 eOvIeOMoED3qRlMukieZtWFED0uisRQ3iNDRuxc3PKqA7H9Fb/rpcdOn3Qcuxg22Edgq7W8bPi7
 Xspxa/dXqZhE3rgO/nN+Ypd5zJ+tmJAkPOrWlsOVBR0tdc86s69lty7kgjajWKA8xhat7vxdI5Z
 Ep2pu0GP+KHmMn8Gc40JTRtUTfm3XIVRZUeEvmY22Oa4TvXQKoJW6NkO1VP4fXkL95BaVgUsk3K
 s+K+WFJd+sZlbByOf+qCKnDjdilSUvgU4Ns1dPJpnyo1qLqXjDZPDJwkmIk+04Gun0a6StAMktA
 rmlht3P7sMaaYs3RqMFXHPRqNCFcJaioxn4N+Ec2UikK/KSj1NFO0lYQWuk+ma5DYMRCwTGaErO
 urYw+Wt/4ahbWLhSVPIXZwyQnlkzElJZy0kiVWYkS0J1fy9jOYS5WAiQsXKT/wqMb0CFLq0lZiP
 6OnpqvRYNTCDAq8zsd0UiG5mZ7/FhqfZ85fOU59dhwzN0txVs3t6qYRi46aeELi/s5zLdvn98ai
 iDr+jzjZgBTE5wwpqhTgaWudL7BUJuE5J4dSOlKOCvHNRZeIY8tF0mY5OTiawB3Je8X3ORwBL9n
 Lv8GvRl3b25Omki5w=
X-Received: by 2002:a05:600c:6087:b0:4b4:a551:681a with SMTP id
 5b1f17b1804b1-4ba0233cbbbmr39430455e9.3.1794313551395; 
 Tue, 10 Nov 2026 04:25:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba022fbf75sm50964025e9.0.2026.11.10.04.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:25:50 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 12:25:50 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie2d784272184261a62c848e6ad3b7a4570ae6dc7
X-Gerrit-Change-Number: 2165
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2165?usp=email>
X-Gerrit-Commit: 217855e54eaff32ea697e3575533c19afdf1a2c9
References: <gerrit.1794313546000.Ie2d784272184261a62c848e6ad3b7a4570ae6dc7@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzEzNTQ2MDAwLkllMmQ3ODQyNzIxODQyNjFhNjJjODQ4ZTZhZDNiN2E0NTcwYWU2ZGM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aa365ffa66c1ef7f107797a947b4af230513224c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQkvG-000000005Y7-15Ra
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Change
 return type of buf_forward_capacity_total to size_t
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8307697674327824987=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8307697674327824987==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="44A73h+K9kE="; charset=UTF-8

--44A73h+K9kE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2165?usp=3Demail

to review the following change=2E
=


Change subject: buffer: Change return type of buf_forward_capacity_total =
to size_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

b=
uffer: Change return type of buf_forward_capacity_total to size_t

All call=
ers already want a size_t, so make the
conversion implicit=2E

Change-Id: I=
e2d784272184261a62c848e6ad3b7a4570ae6dc7
Signed-off-by: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=
=2Eh
M tests/unit_tests/openvpn/test_dhcp=2Ec
3 files changed, 3 insertions=
(+), 12 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/65/2165/1

diff --git a/src/openvpn/buffer=2Ec b/src/openvp=
n/buffer=2Ec
index 5f21de8=2E=2Ea4e2809 100644
--- a/src/openvpn/buffer=2Ec=

+++ b/src/openvpn/buffer=2Ec
@@ -275,7 +275,7 @@
     if (buf_forward_capa=
city(buf) <=3D 1)
     {
         size_t len =3D strlen(str) + 1;
-        =
if (buf_size_valid(len) && (int)len < buf_forward_capacity_total(buf))
+   =
     if (buf_size_valid(len) && len < buf_forward_capacity_total(buf))
    =
     {
             memcpy(buf->data + buf->capacity - len, str, len);
    =
     }
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index e=
de3066=2E=2Eae6dcb7 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/b=
uffer=2Eh
@@ -1068,7 +1068,7 @@
  *
  * @return Capacity minus offset, or 0=
 if \c buf is invalid=2E
  */
-static inline int
+static inline size_t
 buf=
_forward_capacity_total(const struct buffer *buf)
 {
     if (buf_valid(buf=
))
@@ -1078,7 +1078,7 @@
         {
             ret =3D 0;
         }
-   =
     return ret;
+        return (size_t)ret;
     }
     else
     {
diff =
--git a/tests/unit_tests/openvpn/test_dhcp=2Ec b/tests/unit_tests/openvpn/t=
est_dhcp=2Ec
index e331d3d=2E=2E3a84e1e 100644
--- a/tests/unit_tests/openv=
pn/test_dhcp=2Ec
+++ b/tests/unit_tests/openvpn/test_dhcp=2Ec
@@ -50,11 +50=
,6 @@
     return "dummy";
 }
 
-#if defined(__GNUC__) || defined(__clang__=
)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conv=
ersion"
-#endif
-
 static void
 test_write_dhcp_search_str(void **state)
 {=

@@ -146,10 +141,6 @@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || def=
ined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 main(void)
 {

=
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie2d784272184261a=
62c848e6ad3b7a4570ae6dc7
Gerrit-Change-Number: 2165
Gerrit-PatchSet: 1
Gerr=
it-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>

--44A73h+K9kE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">buffer: Change return type of buf_forward_capacity_total t=
o size_t<br><br>All callers already want a size_t, so make the<br>conversio=
n implicit=2E<br><br>Change-Id: Ie2d784272184261a62c848e6ad3b7a4570ae6dc7<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<b=
r>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>M tests/unit_test=
s/openvpn/test_dhcp=2Ec<br>3 files changed, 3 insertions(+), 12 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/65/2165/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/=
src/openvpn/buffer=2Ec</span><br><span>index 5f21de8=2E=2Ea4e2809 100644</s=
pan><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvp=
n/buffer=2Ec</span><br><span>@@ -275,7 +275,7 @@</span><br><span>     if (b=
uf_forward_capacity(buf) &lt;=3D 1)</span><br><span>     {</span><br><span>=
         size_t len =3D strlen(str) + 1;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (buf_size_valid(len) &amp;&amp; (int)len &lt;=
 buf_forward_capacity_total(buf))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (buf_size_valid(len) &amp;&amp; len &lt; buf_forwa=
rd_capacity_total(buf))</span><br><span>         {</span><br><span>        =
     memcpy(buf-&gt;data + buf-&gt;capacity - len, str, len);</span><br><sp=
an>         }</span><br><span>diff --git a/src/openvpn/buffer=2Eh b/src/ope=
nvpn/buffer=2Eh</span><br><span>index ede3066=2E=2Eae6dcb7 100644</span><br=
><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffe=
r=2Eh</span><br><span>@@ -1068,7 +1068,7 @@</span><br><span>  *</span><br><=
span>  * @return Capacity minus offset, or 0 if \c buf is invalid=2E</span>=
<br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static in=
line size_t</span><br><span> buf_forward_capacity_total(const struct buffer=
 *buf)</span><br><span> {</span><br><span>     if (buf_valid(buf))</span><b=
r><span>@@ -1078,7 +1078,7 @@</span><br><span>         {</span><br><span>  =
           ret =3D 0;</span><br><span>         }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        return ret;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return (size_t)ret;</span><br><span>    =
 }</span><br><span>     else</span><br><span>     {</span><br><span>diff --=
git a/tests/unit_tests/openvpn/test_dhcp=2Ec b/tests/unit_tests/openvpn/tes=
t_dhcp=2Ec</span><br><span>index e331d3d=2E=2E3a84e1e 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_dhcp=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_dhcp=2Ec</span><br><span>@@ -50,11 +50,6 @@</span><=
br><span>     return &quot;dummy&quot;;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__=
) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><sp=
an> test_write_dhcp_search_str(void **state)</span><br><span> {</span><br><=
span>@@ -146,10 +141,6 @@</span><br><span>     gc_free(&amp;gc);</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> int</span><br><span> main(void)</span><b=
r><span> {</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2165?usp=3Demail">change 2165</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2165?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie2d784272184261a62c=
848e6ad3b7a4570ae6dc7 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2165 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--44A73h+K9kE=--


--===============8307697674327824987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8307697674327824987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8307697674327824987==--

