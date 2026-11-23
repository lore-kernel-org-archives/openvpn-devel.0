Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFAD606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aGiMUrtD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FbMPWH3i;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=etiQ2MkO;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hJ9PTLit
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SR0v9+lpsVQxcxjSQBft+ggbQbyyLA4AXBemk9sKG+w=; b=aGiMUrtDguK8wtlJPafiyqRTW1
	mVMVlFcMk3JA/UO8kxq5VrGJQ3MuWdmsZzRdPbLMrqwfiXdmZBYUFQTEetKGcjjHum4NIcHRe1cBd
	drh7Fib4W1uxVhZ9C+PY2Vl2Tsb+HJiqUQTJIycMeq2LO/o/TRo5+HxpuJd7Bo4h2oNs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVYc0-000000004WM-0TUz;
	Mon, 23 Nov 2026 18:17:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVYbx-000000004W2-2ZxL
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:17:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TGDqS3C/aCe+iNBio7HokxhUBDXJlDnEwwROgXKBfxc=; b=FbMPWH3iYTwJMTA8UQTQd0sUK4
 BkKcvCsni7DfPmEWGmFtiCOPfr2KNO1IuAMSgRIUM+oSJrfiAakLDeJTf8ZHVXPm7+JayQbmFxrHR
 hp6snbjHQjgFdCU2Ob//k2LNB4I9+rPk04qwK23/GfR80FpHxbn3YuoyQ27DoH/V8r5M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TGDqS3C/aCe+iNBio7HokxhUBDXJlDnEwwROgXKBfxc=; b=etiQ2MkO6k/Y0oQSYhJ5c+4MOs
 9U7wMI/FzqrhA+mXNR/KpXAezPrwf3umCZdBX34G8Fk6SjcuAKXxLqwv2v8fOWM54NKZhWKGdDRMA
 Qfvw3kVghCox1Grmrr8NUg3O7srBxKE7tyj6bfnJx7ptN1TvGLS0sSmo4ynz9G1AKSnA=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVYbt-000000002u5-3QQt for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:17:53 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso41475655e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 10:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795457863; x=1796062663; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TGDqS3C/aCe+iNBio7HokxhUBDXJlDnEwwROgXKBfxc=;
 b=hJ9PTLitX+gkFHDw5y40zIuBD320cJqZk2cHymfRArUxuuk6ccpUbVkv66deAReTjq
 ++glIHmvzcpuhWPDEIEVjME3ohUPeWcEd4AJJJ7XKiHORVmvZ+j34jyuCqxhQ/HM8t4K
 qfB/fEzwQa8SRRKztsTalXfvfCEtMeERVA+bePl4XGlAk5MD2e6WO7IeTnBDmXNR+qQT
 PH6Gw/WYr3JuFw2tRzDtUVzqM34Oc4WtmR2sKG639nq3eenhlVMW8t7nkAet9PPApeOu
 nMPcV8cBuGPQ2OEPO/1W5Kk8ecKNhELAgaDoZAS4vY0mzlxyQdAdtDAFrJoxwfUXqN9M
 Sixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795457863; x=1796062663;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TGDqS3C/aCe+iNBio7HokxhUBDXJlDnEwwROgXKBfxc=;
 b=V4/gtGjIb4k5r+2AumuspbEdhDuvRNU6YV3ZfvEv/8Y/5dpdNsvVzKfSnXq09YhsJE
 NRDpNjDieNOqOD+baaZd/fAmZPjKDDn69rUT1JuIR7JBiR2SIx5kW+lHZ5b8h7myz8rr
 vzBo97L68x9houSsU5aR2MRdUmMwCpX/EiRSr4ZHfOTxcbz3Vtr2ddhX6qX6xxOwG2cz
 JpwK9pLCqYn+vmjHi2/A+cumASD8PuQqSfhXMO2JK+AbLG9FQpxppa2QQYoX/iHRZ7qR
 UgRUj5+7nPnSB/x7L2JLBAKN0A14/kvqyR9CZOpYfQdiYVT53RwjlFmJKO/bKKYCxsns
 HuHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGB10BnBPy/9pVCwWScQ9FeenM2IiRocgSQQ+Y9swlXuiRWYoBpGKGFDoVTnN6VHN+OKjt1cceCXErk6Nxa@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/aB9kgvv3AcEMj3SpARG6cN/ZDQ6Qd/qomMTVWPt8AoOnPmjqn
 NcK3ck8UdmdvzBTLZMz2+AG9Ik+RqB8pl07vZYcGPnvbV8CiLLR24lwI3NIcoqgaDFnNM2DBwQn
 rZxB050kpKZu/8WLc6hUBR+195cjnegXhIUjOmCIIuLcbG7s0W1X8PpV6eL1DBGsPXxCLDtHFht
 5thqfWvw==
X-Gm-Gg: AZFdTZfkCT8IcSGXqjGuPeXgvBut26/c6o12/6P1PWxZUuCg1021knXcCFPdeKcuecL
 h5XCFiw+AfXgjildJ7E7pXGj/BZS0v8BAmS4D/dFQX7UIvMfGOZ0Ip90voTDvNwRCvWTtB+UtJq
 Yealrrtl1WZ5nY6bn3YbkIQ5qZ+EXbXO6It4WSJ5wGFgvDBIeARcGNs9qshxW8l+fsVCE/rObH4
 uTBg5W2dCZWCguH8eBk1SCRmBBKp7imO0D/ILTEQld5B9FWlc1sDssT/Vd0ZqkZw6ZwaVQHrOmQ
 8/yspIviteZNsABXnDGutWcnQg7DieaLMZHcrD7y6nUIn7vCKjQu206ZgmarS/uYW73gAipEqJa
 DtRCf9qAorekZf3WkSdzLeDJpwDdV6lBoJVfRqiLNed75+/sHvvYKUIl6FC/CmskIbWtdqOIpfA
 YIN85DUyDauevtUX7Xe64s2ncJckDlZi2+sRjltDC02AwtCgLuKZoFoIHBgaXAb7WIu08faORZ/
 sZsQ3glmh/hMXsWRsy9STlwqkdPq2wmpSGhQnEMP/FOQ3mFpU2uKYruOOVFPUawuKmJ++/R+540
 zItLaI5ELLvNdlXeNJKMPvLoxrVWixUYEDfpvdQC7KWf3Q2cMsE7DgTEFSIuzaBM7DAimQ8s/3R
 45Uxb9G56wXpFIFatRXoYsmc+UmmvT5yF7Mb8Bx+yf4pEQiLjDP/sZlJeZHq11AnP6dyySybZGG
 qBrLb9JoXyvcV2sX4t
X-Received: by 2002:a05:600d:600b:b0:4a2:18c4:61a5 with SMTP id
 5b1f17b1804b1-4bb887fb6e7mr259939745e9.6.1795457863050; 
 Mon, 23 Nov 2026 10:17:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9067846esm215696175e9.4.2026.11.23.10.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 10:17:42 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 18:17:42 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I48d315a38a653aed4b33d3277433cb8a6596942d
X-Gerrit-Change-Number: 2237
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2237?usp=email>
X-Gerrit-Commit: 2f921ab3b4b80c2ff1b2ff3daf41ff206f499bdd
In-Reply-To: <gerrit.1795250594000.I48d315a38a653aed4b33d3277433cb8a6596942d@gerrit.openvpn.net>
References: <gerrit.1795250594000.I48d315a38a653aed4b33d3277433cb8a6596942d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjUwNTk0MDAwLkk0OGQzMTVhMzhhNjUzYWVkNGIzM2QzMjc3NDMzY2I4YTY1OTY5NDJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4e08eec863f5d369f1bbb34ff7d2aa91feaa92f8-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVYbt-000000002u5-3QQt
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: free
 ext_cert_input in man_connection_close()
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7423846431802116585=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7423846431802116585==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="n8axFaeh7jw="; charset=UTF-8

--n8axFaeh7jw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2237?usp=3Demail )

Change subject: manage: free ext_cert_input=
 in man_connection_close()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

manage: free ext_cert_input in man_connection_close()

ext_ke=
y_input was freed there, its certificate counterpart was not=2E
While here,=
 pass mc to in_extra_reset() like the rest of the function=2E

Change-Id: I=
48d315a38a653aed4b33d3277433cb8a6596942d
Signed-off-by: Razvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237
Message-Id: <20=
261123135003=2E31908-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41824=2Ehtml
Signed-o=
ff-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
=
1 file changed, 2 insertions(+), 1 deletion(-)




diff --git a/src/openvpn=
/manage=2Ec b/src/openvpn/manage=2Ec
index ab814d5=2E=2E112db4a 100644
--- =
a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2841,8 +2841,9 @@=

 
     event_timeout_clear(&mc->bytecount_update_interval);
 
-    in_extr=
a_reset(&man->connection, IER_RESET);
+    in_extra_reset(mc, IER_RESET);
 =
    buffer_list_free(mc->ext_key_input);
+    buffer_list_free(mc->ext_cert=
_input);
     man_connection_clear(mc);
 }
 

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2237?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I48d315a38a653aed4b33d3277433cb8a6596942d
Gerrit-=
Change-Number: 2237
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--n8axFaeh7jw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2237?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">manage: free ext_cert_input in man=
_connection_close()<br><br>ext_key_input was freed there, its certificate c=
ounterpart was not=2E<br>While here, pass mc to in_extra_reset() like the r=
est of the function=2E<br><br>Change-Id: I48d315a38a653aed4b33d3277433cb8a6=
596942d<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>=
Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237<br>Message-Id: &lt;20261123=
135003=2E31908-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41824=2Ehtml<br>Signe=
d-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/open=
vpn/manage=2Ec<br>1 file changed, 2 insertions(+), 1 deletion(-)<br><br></p=
re>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><=
br><span>index ab814d5=2E=2E112db4a 100644</span><br><span>--- a/src/openvp=
n/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@=
@ -2841,8 +2841,9 @@</span><br><span> </span><br><span>     event_timeout_c=
lear(&amp;mc-&gt;bytecount_update_interval);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    in_extra_reset(&amp;man-&gt;co=
nnection, IER_RESET);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    in_extra_reset(mc, IER_RESET);</span><br><span>     buffer_list_free(=
mc-&gt;ext_key_input);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    buffer_list_free(mc-&gt;ext_cert_input);</span><br><span>     man_co=
nnection_clear(mc);</span><br><span> }</span><br></pre><p>To view, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237?usp=3Demail">chang=
e 2237</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2237?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I48d315a38a653aed4b33d3277433cb8a6596942d </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2237 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--n8axFaeh7jw=--


--===============7423846431802116585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7423846431802116585==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7423846431802116585==--

