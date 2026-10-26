Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34002606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iAHphbHw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=b9oW2Pzl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gX7LlWUQ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aWAwEblU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/ZHru1JxD0Vp547+DJmClBJ4r0STvFQtdh9KsLZJs5s=; b=iAHphbHwHeUsI/PFiNOEF9GYEg
	JEpO/i5LdybnSF+AZR289XYamw8V39erWQdzFn9pErJSBWE7S/MzJMTd+eKKo5LwReXA6gWIU30GM
	THJkloh/6b2f2s4I5oa9Hk0QzvmsG32Q9xuUJWJ9FhZQS2IPQqvh1yBWewDucn2xYOCI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLLUh-000000001Li-2wxQ;
	Mon, 26 Oct 2026 14:16:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLLUf-000000001La-3B7i
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:16:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=prYpLZTr1F1v2oI3U83/zY6CnnCm1WVc+NNK8O6R6GY=; b=b9oW2PzljrLkTacxfqP1nFBuSS
 lLrPocJKLutm7oXkRoTjIqm0FlSIX7L/CufrKENhw27otKXzimv9not0E/fKBMquWWfXZpEEIMPBp
 LLnZGlFubNK8sigHkklx8kYdkVsTisZAhH/L+V6b5GBbHm+RcFHf7Ylv4z85yOU3sfXU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=prYpLZTr1F1v2oI3U83/zY6CnnCm1WVc+NNK8O6R6GY=; b=gX7LlWUQDKSa0E0JuGXMF1SuTG
 yqswHaWDwZzQf6HOqLUIRMQ8rMddMMoKkyQqPURb95p2NMVq/Wz7Sosp1cKQ+L3vya61McbCPrT3g
 JUhizh3XZho2MTD2NrOXi5H/D+b7WjoSZEuLL14vLBGrI4+ULLfSFpC+CubNdAE5ZkZg=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLLUe-000000001st-0Uvv for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:16:09 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso3151246f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 07:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793024161; x=1793628961; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=prYpLZTr1F1v2oI3U83/zY6CnnCm1WVc+NNK8O6R6GY=;
 b=aWAwEblU4pBQQsNiZI2ciGjOyuepGbivwDhC4jy2C2M573F36bc8sQe/KEtVFQ1jUo
 lYcL0HWKzPgvGP/2wsz7SX9Hj+jfmb8C4jZ4VnZ9aioyUWIev8/6+8TeqYk1XZpptsZ3
 HTr7CWTRebQPZWMExVEfP821Yw3BBj87VH1aSCqDcxiwYRCsmkOrVrL1F3XN1IzcK/nl
 6hDHk+wCiAHK9VhHx8kp5oJo6muoPW9rYq/JysBpvimS53fNsKATfmcvG0DA3tBBdN9+
 4EJt2Ei0Grmyf2sZVGofLtVXn4j7vlsCE+SeGXave6n3HMu0OpT8rEWxglRUWTGom6Tm
 V2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793024161; x=1793628961;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=prYpLZTr1F1v2oI3U83/zY6CnnCm1WVc+NNK8O6R6GY=;
 b=P+bm0BPVR6r+DOD3wuKK5wBOKxcndAk3ejxgrmwn2+XxvHq34qUSeeORhA5d5W1Mlo
 C7mOYm1Hgl/q4yyuQ6/c9bkFNzFalvkKMY+8kgJDp0AiL4Z8WuH7rMoYL1WsGzTt25ZB
 /S6Zi1pFbIogBoRbju8jSuQsYuLlOgdrDOVdjHk0ZjxMIjlqsLSQGBiQ0yJWB2xe/07X
 c43WfUi2JcwpxIkxeVEruzxGc0g2hSvTBZXV27bPIxqG0vc0KuFMBkvf6OfYfhWKApbK
 xnOMLXicXg/j7/U3cJ1W/E73QyLIOjTLFcSMCF1wef30ixXHS73pgO69WqdB6x+rn+8K
 8+hw==
X-Gm-Message-State: AFq9FYKw9Rx8ivUejCsxZb1p/2sJUbU+qFr6ZalQDqHC9BZ/QKH+6+xr
 oyJSOe66DKouByiOszsWDs4fnlD64lGGEQY1pzTXw1CPaFnEkSbUB3YDR+kplA8y6ipze+2vcxM
 B7+lqjmBhfymBYXZQAuiQYI64+VBZQ9OCtTcLqub4zXCF45kGaDc3xTjsC0lxvXF8o+DB
X-Gm-Gg: AYBFou147xTs6nKzJU3oCFsV/B5rNG5/zXv3SXP5QeB7TQWnwLV7m5A2ZpvK2wyQv9w
 2tqEGZd8zs34AlKgQa4oYEoJJ0HuLCcX0t4eMRL8pD2g5egocbQlGjeoelzHyqrE3/nH4hqHObF
 wOSQ+Ev3ccfKKzHcBcn9aHk2r/HDAEw9JQ7NK2crZt40YjDrHr5EBw+ymTk1CNFZWtug9+tLFRB
 uJXKiyCV0kgQ8vHU9xLy4DZq2pIWsArk7vXLxWrllcLbtKHMByuIOR5t/ON+ujCO8L35e5KVxOZ
 fwuSo2mqoNhC40u9Q6g9ZcFSZG+wElPAwRvMeEfyb1KIZ1ERxfmpQp+1Nd4zSBOyKluamGyanAs
 dDdt9uI9sm6LJSSMwfmJ+FRG7sra8nHQj8Yn2vqm/uZvLnkvP7Tk5rUYLwsoYbLOqjfdJ2uhScD
 3b6fsq/yaW4MY94FrrW2L0YcyfQyP3omRcHsu8ea2sQGqfQ3uitxEZCVR0Du7yu6b8NQ9sGu3au
 V0EhPyzaRawQ79Shy/oyc6tXliyK9A/XqvrieC2h9rQsmZcWQ2ixsvviGRyndFphVJ/yOp+0LPG
 jQnNtmhQDqCxeYD5ehQzScnCjy9ao/wusC3bI/aKueyPYJtgm4snDY8InBc+iNiPw/HK5/9ZF1K
 nbpF6LbPHHpePMnxaLaVtlWJIa5coturuyM8vyyOi4Io=
X-Received: by 2002:adf:e007:0:10b0:48e:84b:e83e with SMTP id
 ffacd0b85a97d-48e3eb2bca4mr8806213f8f.1.1793024161293; 
 Mon, 26 Oct 2026 07:16:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb902sm17493359f8f.24.2026.10.26.07.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 07:16:00 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 14:15:59 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I136d57b7487f228e37894fa710b1ccc2c4606eb5
X-Gerrit-Change-Number: 2031
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2031?usp=email>
X-Gerrit-Commit: 766320d69bc402e700fe4d014d3738ec8a9441da
In-Reply-To: <gerrit.1792963979000.I136d57b7487f228e37894fa710b1ccc2c4606eb5@gerrit.openvpn.net>
References: <gerrit.1792963979000.I136d57b7487f228e37894fa710b1ccc2c4606eb5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyOTYzOTc5MDAwLkkxMzZkNTdiNzQ4N2YyMjhlMzc4OTRmYTcxMGIxY2NjMmM0NjA2ZWI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e06c4c79954c64693db2efd37db1a642da469e6e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLLUe-000000001st-0Uvv
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix typo of nprocs
 instead of nproc in run-cppcheck.sh
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9129757524039510521=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9129757524039510521==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S7P72nn9VEc="; charset=UTF-8

--S7P72nn9VEc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2031?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by Antonio Quartulli, Code-Review+2 by Frank Lichtenheld


Change s=
ubject: Fix typo of nprocs instead of nproc in run-cppcheck=2Esh
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix typo of nprocs ins=
tead of nproc in run-cppcheck=2Esh

Commit ccd058e75 accidentally used npro=
cs instead nproc, making the
script fail on Linux=2E

Change-Id: I136d57b74=
87f228e37894fa710b1ccc2c4606eb5
Signed-off-by: Arne Schwabe <arne@rfc2549=
=2Eorg>
Acked-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Acked-by: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2031
Message-Id: <20261026110205=2E55077-1-frank@licht=
enheld=2Ecom>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg40134=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M dev-tools/run-cppcheck=2Esh
1 file changed, 1 insertion(=
+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/31/2031/2

diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools=
/run-cppcheck=2Esh
index 58609b2=2E=2Ea9c4643 100755
--- a/dev-tools/run-cp=
pcheck=2Esh
+++ b/dev-tools/run-cppcheck=2Esh
@@ -22,7 +22,7 @@
     num_pr=
ocs=3D$(sysctl -n hw=2Encpu)
 else
     SCRIPT_DIR=3D$(dirname $(readlink -=
e "${BASH_SOURCE[0]}"))
-    num_procs=3D$(nprocs)
+    num_procs=3D$(nproc=
)
 fi
 : ${SOURCE_DIR:=3D$SCRIPT_DIR/=2E=2E}
 : ${BUILD_DIR:=3D$PWD}

-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2031?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I136d57b7487f228e3789=
4fa710b1ccc2c4606eb5
Gerrit-Change-Number: 2031
Gerrit-PatchSet: 2
Gerrit-O=
wner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Antonio Qu=
artulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Frank Lichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--S7P72nn9VEc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/203=
1?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by Antonio Quartulli, Code-Review+2 by Frank=
 Lichtenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Fix typo of nprocs instead of nproc in run-cp=
pcheck=2Esh<br><br>Commit ccd058e75 accidentally used nprocs instead nproc,=
 making the<br>script fail on Linux=2E<br><br>Change-Id: I136d57b7487f228e3=
7894fa710b1ccc2c4606eb5<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eo=
rg&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Ac=
ked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2031<br>Message-Id: &lt;2026102611=
0205=2E55077-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://www=2Email-archi=
ve=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40134=2Ehtml<br>Signed-=
off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/=
run-cppcheck=2Esh<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/31/2031/2</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/dev-tools/run-cppcheck=2Esh b/dev-t=
ools/run-cppcheck=2Esh</span><br><span>index 58609b2=2E=2Ea9c4643 100755</s=
pan><br><span>--- a/dev-tools/run-cppcheck=2Esh</span><br><span>+++ b/dev-t=
ools/run-cppcheck=2Esh</span><br><span>@@ -22,7 +22,7 @@</span><br><span>  =
   num_procs=3D$(sysctl -n hw=2Encpu)</span><br><span> else</span><br><span=
>     SCRIPT_DIR=3D$(dirname $(readlink -e &quot;${BASH_SOURCE[0]}&quot;))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    num_procs=3D$(npro=
cs)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    num_procs=3D=
$(nproc)</span><br><span> fi</span><br><span> : ${SOURCE_DIR:=3D$SCRIPT_DIR=
/=2E=2E}</span><br><span> : ${BUILD_DIR:=3D$PWD}</span><br></pre><p>To view=
, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2031?usp=3Dem=
ail">change 2031</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2031?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: I136d57b7487f228e37894fa710b1ccc2c4606eb5 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 2031 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</=
body></html>
--S7P72nn9VEc=--


--===============9129757524039510521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9129757524039510521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9129757524039510521==--

