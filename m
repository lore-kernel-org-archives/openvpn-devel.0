Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8F2CC6B3D
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7kRiYlrK9MylKP3dBU94CRlQdf2LS2UwPMdW6FoTpuY=; b=OpxyBwCatc05KKDvJ8HGjYBOkL
	wK0LR8DYWQ4s8bFILNuk/Zneo6PkIfaEbGlN0HzbKn0DQ2jDUgBQmx0vApbZpNOyBpqu8goFQ7rEN
	p0+X9n6t96qxnV6opYJskoXa0jGmeYremGnisoTysXnGXXNKnBs9ubM35NvZYLu+8A2g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHMvc-0001wj-MO;
	Thu, 15 Oct 2026 14:59:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHMvb-0001wY-IB
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 14:59:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4VdghseE96UvQZijplliUdZ+3xsUMqZyFG6s5oedEb0=; b=XaKXE6vEvZT3y99rmsnz4QgTQu
 4RuFiSEDt4+DIYaLiI5z373aeO047K/fdSqmfr0AptJlAW2kdezm38lF3DtXmGD1/coX/SpL13hRZ
 /3jjJHHJPsj5jcwlTpEvLHGb4ufnPDTYn6TUpzeFiOePuLZ13fUuEBx3KTCx/AiFSAqM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4VdghseE96UvQZijplliUdZ+3xsUMqZyFG6s5oedEb0=; b=A
 muJPIoJEkdrFXW4dXZSkV8cy3QpEJf9DBw981qw+MJChyhXaWKTOHwTxFW+xI4wbH+sAyxBFGkqFL
 yLtCUA8axBxmCvE5wNuFqAUDFw6Dq+UTkSFaH5dAkxGkha2INBjKqIzoB9EHsH5px3TLlp8K0YTst
 rLU6kL0QVsJlkEjs=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHMvX-0003KK-5w for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 14:59:29 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a1688d7769so19923245e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 07:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792076361; x=1792681161; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4VdghseE96UvQZijplliUdZ+3xsUMqZyFG6s5oedEb0=;
 b=WhWUTe31xd/SNvqkwp/dybvVVSObdKgh9yA/qrP9uJsIym+vi83Wfs64tbtC6mjiVe
 H5087orPB9JzyWqs63pqyx6O9A6ghLu/kxvTc7Y/f3bnKB6PVW8EJn/Jm/ZjmTBzwxsA
 4Hz086v91WRxT2Ugtr2XpGCTH2kqiX7nMIXqrjnTJb4JE+DSe7XCYupTpUAQeFYp77Q8
 ls7Tiyuq6gxj6z+x5ehqhveU72+j4JjB+Aq+NikzT0tw8alTaD+WJ6kGUulIQkqpdNWE
 +WhM+jniDIW7WGyNb3XfvnilsjQdliAPpAbSykndNKNRmnuVVdwVN1GLQAGbSfa1r/kd
 NXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792076361; x=1792681161;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4VdghseE96UvQZijplliUdZ+3xsUMqZyFG6s5oedEb0=;
 b=FCBi77Ps3L63oCQ2cxd1zKrBnjp6Ptzb+vvPsXTADIpePSnJsrGgA/vPx6Zg5J3gQ6
 9vqfcCjmXHqsDA0MtInQD1N7GlDf/PsH//m+Ss6b+RGrI6jKOs6Thal2RJlg8ucsoOEK
 gZZvortcJsg40xeIr6cNu9LN3ZkxX79EdX3w7j8ZznxNsSUqB4AptQWt7UEN7ai6OxqV
 sXbxNlplW2AR9DmtpwrnvbmEG+QfL6DMb4jgk0WnKMXyhB+OsjDRy+QNtNboKUYhvthu
 CBjXwaGD8v6N/Xh5bZJjiTxmnKXvMV4ynbZNDD9TeThfmeO/wztukhiUSOm2lJYDOOv8
 73Ng==
X-Forwarded-Encrypted: i=1;
 AKwUvBzR3w1s1PY19FNYSRx9PX+iGpEWCM6zXf/hwTBJV8b0lDWAtLgQiRlZrb8JxbHczdYZCB3zu2Dg/3GJL3LV@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKLhnENYLjbfoskvhri7WWXlfwzRYlTZ3/S5NVTjxxrcpZVirOP
 af3KHM0afN3egNUfVti/koNlY8xIJfTC75QCq2mnMRFW0ShT4ujDDsxrfhQ41uGrliwDGZy7307
 l51E4deZD+frWxojj1nvvb99ciM5gASFUw7uq98wixJurU3IRYcVSiIwGvdoKQCuf2ZkU
X-Gm-Gg: AYBFou3B2VeNwoYdaNQoWZaoHXo8YCWFTLLMFJSE6OLfYk69EDoh8YPX+3e7Zn17LgK
 2YQ0zccIIf0etFwb+6mAQT2+Eh5/nVB84d3RPL50yx1929QWShNVgdSVj7UBMBUUEZX4Od8hw0y
 yLwFoeeUWzMb1D/UBQOmD296V4y/HfTlrkcks0wsDNu79buoWPq24y5hycbi3YPIcMIv7vrMIpH
 uF8S7i4HwSgbXYTjIdXhGnTnfT9P3VT9Vpc/8E9QLTACYm+aNP+RwmwLNjPUUjT6Dx+u6SlxREX
 Oj14UhZP2I+3in39AGqqpQhEf63Hfzr8LzLMOoWXqeyYC5szpuS0YrFtESYS3qZpyZWWLFz6jq9
 o49KFX3HwgRhAbOTmHGebyU0xgrvIFlDLjL2jbxQuJZ952MgMlY6R5KNV5HGPLECxQ3bLqkV2N0
 rzmAbhTJVhf7M5FiDlir0XJx7DIkewjzliQTzMw2uSeFIkxrXB4L2su/ntI689wRkA99dKIo7FQ
 Brb05vTW0ot6pmJA0jbRM9Y4GcMYKFJkdbEPvPoWq5x8gkqBN+WwLH8udj2a6bSYdFEU6O0G6Pa
 9y0jZX81K8dw2NvhPg30Bz3/wvjOIjUqcAzeIzK44YcEqJJMaTGcUDpeTMcP
X-Received: by 2002:a05:600c:8b09:b0:4a1:6f78:842f with SMTP id
 5b1f17b1804b1-4a18e4987b8mr410286335e9.11.1792076360322; 
 Thu, 15 Oct 2026 07:59:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1beb77054sm52016505e9.1.2026.10.15.07.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 07:59:19 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 14:59:19 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6294665e39ddf012f0a3943d0e356576f4fe02e1
X-Gerrit-Change-Number: 1999
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1999?usp=email>
X-Gerrit-Commit: cc54693fce1229731291ca3e79656034b212c900
In-Reply-To: <gerrit.1792062421000.I6294665e39ddf012f0a3943d0e356576f4fe02e1@gerrit.openvpn.net>
References: <gerrit.1792062421000.I6294665e39ddf012f0a3943d0e356576f4fe02e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMDYyNDIxMDAwLkk2Mjk0NjY1ZTM5ZGRmMDEyZjBhMzk0M2QwZTM1NjU3NmY0ZmUwMmUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <654e94797631df42d2c1e149e62c39a82f91eb8a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHMvX-0003KK-5w
Subject: [Openvpn-devel] [S] Change in openvpn[master]: clang-format: Enable
 InsertNewlineAtEOF
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5014979456258786228=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5014979456258786228==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1GsK3A6eLz0="; charset=UTF-8

--1GsK3A6eLz0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1999?usp=3Demail )

Change subject: clang-format: Enable Insert=
NewlineAtEOF
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


clang-format: Enable InsertNewlineAtEOF

We had some patches recently tha=
t committed files
without newline at EOF=2E Enforce consistency=2E

Change-=
Id: I6294665e39ddf012f0a3943d0e356576f4fe02e1
Signed-off-by: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doering <gert@greenie=2Emuc=2E=
de>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1999
Message-Id: <20261015111030=2E2257=
0-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg39893=2Ehtml
Signed-off-by: Gert Doering=
 <gert@greenie=2Emuc=2Ede>
---
M =2Eclang-format
M src/compat/compat-strtok=
_r=2Ec
M src/openvpn/schedule=2Ec
M src/openvpn/siphash=2Ec
M tests/unit_te=
sts/openvpn/siphash_openssl=2Eh
M tests/unit_tests/openvpn/test_schedule=2E=
h
6 files changed, 6 insertions(+), 5 deletions(-)




diff --git a/=2Eclan=
g-format b/=2Eclang-format
index 0823739=2E=2E23d224b 100644
--- a/=2Eclang=
-format
+++ b/=2Eclang-format
@@ -32,6 +32,7 @@
 IndentWidth: '4'
 IndentWr=
appedFunctionNames: false
 InsertBraces: true
+InsertNewlineAtEOF: true
 Ke=
epEmptyLines:
   AtEndOfFile: false
   AtStartOfBlock: false
diff --git a/s=
rc/compat/compat-strtok_r=2Ec b/src/compat/compat-strtok_r=2Ec
index debcdd=
3=2E=2E4240458 100644
--- a/src/compat/compat-strtok_r=2Ec
+++ b/src/compat=
/compat-strtok_r=2Ec
@@ -98,4 +98,4 @@
     }
     /* NOTREACHED */
 }
-#en=
dif
\ No newline at end of file
+#endif
diff --git a/src/openvpn/schedule=
=2Ec b/src/openvpn/schedule=2Ec
index 6c60dc2=2E=2Eff243dc 100644
--- a/src=
/openvpn/schedule=2Ec
+++ b/src/openvpn/schedule=2Ec
@@ -389,4 +389,4 @@
 {=

     s->earliest_wakeup =3D NULL; /* invalidate cache */
     schedule_rem=
ove_node(s, e);
-}
\ No newline at end of file
+}
diff --git a/src/openvpn/=
siphash=2Ec b/src/openvpn/siphash=2Ec
index e31b708=2E=2Eb9fc5e3 100644
---=
 a/src/openvpn/siphash=2Ec
+++ b/src/openvpn/siphash=2Ec
@@ -46,4 +46,4 @@
=
     } ret;
     siphash(k, length, hash_key, ret=2Eout, sizeof(ret=2Eout))=
;
     return ret=2Ehash;
-}
\ No newline at end of file
+}
diff --git a/te=
sts/unit_tests/openvpn/siphash_openssl=2Eh b/tests/unit_tests/openvpn/sipha=
sh_openssl=2Eh
index 0f1d329=2E=2E49c6a9d 100644
--- a/tests/unit_tests/ope=
nvpn/siphash_openssl=2Eh
+++ b/tests/unit_tests/openvpn/siphash_openssl=2Eh=

@@ -61,4 +61,4 @@
  */
 bool
 siphash_openssl_available(void *sip_context)=
;
-#endif /* ifndef SIPHASH_OPENSSL_H */
\ No newline at end of file
+#endi=
f /* ifndef SIPHASH_OPENSSL_H */
diff --git a/tests/unit_tests/openvpn/test=
_schedule=2Eh b/tests/unit_tests/openvpn/test_schedule=2Eh
index 55dc591=2E=
=2E3705af9 100644
--- a/tests/unit_tests/openvpn/test_schedule=2Eh
+++ b/te=
sts/unit_tests/openvpn/test_schedule=2Eh
@@ -24,4 +24,4 @@
 /** Runs the sc=
hedule test */
 void
 schedule_test(void **state);
-#endif
\ No newline at =
end of file
+#endif

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1999?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I6294665e39ddf012f0a3943d0e356576f4fe02e1
Gerrit-Change-Number: 1999
Gerrit=
-PatchSet: 2
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ger=
t Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>

--1GsK3A6eLz0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1999?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">clang-format: Enable InsertNewline=
AtEOF<br><br>We had some patches recently that committed files<br>without n=
ewline at EOF=2E Enforce consistency=2E<br><br>Change-Id: I6294665e39ddf012=
f0a3943d0e356576f4fe02e1<br>Signed-off-by: Frank Lichtenheld &lt;frank@lich=
tenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;=
<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL=
: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1999<br>Message-Id: &lt;202610=
15111030=2E22570-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-a=
rchive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39893=2Ehtml<br>Sig=
ned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =2Ecla=
ng-format<br>M src/compat/compat-strtok_r=2Ec<br>M src/openvpn/schedule=2Ec=
<br>M src/openvpn/siphash=2Ec<br>M tests/unit_tests/openvpn/siphash_openssl=
=2Eh<br>M tests/unit_tests/openvpn/test_schedule=2Eh<br>6 files changed, 6 =
insertions(+), 5 deletions(-)<br><br></pre>
<pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/=2Eclang-format=
 b/=2Eclang-format</span><br><span>index 0823739=2E=2E23d224b 100644</span>=
<br><span>--- a/=2Eclang-format</span><br><span>+++ b/=2Eclang-format</span=
><br><span>@@ -32,6 +32,7 @@</span><br><span> IndentWidth: &#39;4&#39;</spa=
n><br><span> IndentWrappedFunctionNames: false</span><br><span> InsertBrace=
s: true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+InsertNewlin=
eAtEOF: true</span><br><span> KeepEmptyLines:</span><br><span>   AtEndOfFil=
e: false</span><br><span>   AtStartOfBlock: false</span><br><span>diff --gi=
t a/src/compat/compat-strtok_r=2Ec b/src/compat/compat-strtok_r=2Ec</span><=
br><span>index debcdd3=2E=2E4240458 100644</span><br><span>--- a/src/compat=
/compat-strtok_r=2Ec</span><br><span>+++ b/src/compat/compat-strtok_r=2Ec</=
span><br><span>@@ -98,4 +98,4 @@</span><br><span>     }</span><br><span>   =
  /* NOTREACHED */</span><br><span> }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span>\ No newline at end of file</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff =
--git a/src/openvpn/schedule=2Ec b/src/openvpn/schedule=2Ec</span><br><span=
>index 6c60dc2=2E=2Eff243dc 100644</span><br><span>--- a/src/openvpn/schedu=
le=2Ec</span><br><span>+++ b/src/openvpn/schedule=2Ec</span><br><span>@@ -3=
89,4 +389,4 @@</span><br><span> {</span><br><span>     s-&gt;earliest_wakeu=
p =3D NULL; /* invalidate cache */</span><br><span>     schedule_remove_nod=
e(s, e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span>\ No newline at end of file</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span>diff --git a/src/openvpn/siphash=2Ec b/src/o=
penvpn/siphash=2Ec</span><br><span>index e31b708=2E=2Eb9fc5e3 100644</span>=
<br><span>--- a/src/openvpn/siphash=2Ec</span><br><span>+++ b/src/openvpn/s=
iphash=2Ec</span><br><span>@@ -46,4 +46,4 @@</span><br><span>     } ret;</s=
pan><br><span>     siphash(k, length, hash_key, ret=2Eout, sizeof(ret=2Eout=
));</span><br><span>     return ret=2Ehash;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span>\ No newline at end of file</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/siphash_openssl=2Eh b/tests/unit_tests/openvpn=
/siphash_openssl=2Eh</span><br><span>index 0f1d329=2E=2E49c6a9d 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/siphash_openssl=2Eh</span><br><s=
pan>+++ b/tests/unit_tests/openvpn/siphash_openssl=2Eh</span><br><span>@@ -=
61,4 +61,4 @@</span><br><span>  */</span><br><span> bool</span><br><span> s=
iphash_openssl_available(void *sip_context);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif /* ifndef SIPHASH_OPENSSL_H */</span><br><spa=
n>\ No newline at end of file</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif /* ifndef SIPHASH_OPENSSL_H */</span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_schedule=2Eh b/tests/unit_tests/openvpn/tes=
t_schedule=2Eh</span><br><span>index 55dc591=2E=2E3705af9 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/test_schedule=2Eh</span><br><span>+++ =
b/tests/unit_tests/openvpn/test_schedule=2Eh</span><br><span>@@ -24,4 +24,4=
 @@</span><br><span> /** Runs the schedule test */</span><br><span> void</s=
pan><br><span> schedule_test(void **state);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span>\ No newline at end of file</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br></pre=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
99?usp=3Demail">change 1999</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1999?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I6294665e39ddf012f0a3943d0e356576f4fe02e1 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1999 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit=
-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=

</body></html>
--1GsK3A6eLz0=--


--===============5014979456258786228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5014979456258786228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5014979456258786228==--

