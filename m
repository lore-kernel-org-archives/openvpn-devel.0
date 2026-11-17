Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E626606A887
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dyDSG/eU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hkNp1Q7k;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Cji6d72S;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cusHMatU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=nmkNviVMl3vNjDysSa1Ru96CI//dGa02zIvelwTvOmk=; b=dyDSG/eUbUKkH+Ceft7rQR6NSi
	0wnXNErZL6o0FYyDgJn04YqUvAS18ZO0uEyf9Bhx/xoaYUBj8LqaIFWL5hCmUWM8201C4wm55UvF/
	1zcwmL18kE7vTEP0yJWItZMdkzhHckT/VJ6Yzeq/lfhFSOQpDMXg/sXHy2UtLAexsFAY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTJqz-000000001kU-3I6g;
	Tue, 17 Nov 2026 14:08:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTJqw-000000001iy-0oSA
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:08:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aR5h7QKdhh/ggj9NR1Gpswzd6+cRk0/cbmsiFOzDIjA=; b=hkNp1Q7k2gbsdz4QKDwHrEhswj
 Iamj8GP6pXhpLmUxktQJgMo9beLyNH+zSO58/s0dVc4VDDiKXVfZNzaJ1iBgsmMbJNG1dbThMB734
 wbrbE+bp5GVdm/VZCmnfHCKCgBroJ9q4pNVrsu+q0B3b0AV0YyLgE8rlR80hx7QmiXfE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aR5h7QKdhh/ggj9NR1Gpswzd6+cRk0/cbmsiFOzDIjA=; b=Cji6d72Sx6mLbVFogRYGlKxOFX
 AmDRgRaMePxkMaGUcHByl7scbqr4fTOFwlq7+MZNB94gQXkB5cR0UHgI2g/T32/PAE+DOYK3aKrHq
 4LHdGWm0pHFAZXeMS1LDEclAfr51nxPjrlcZg8RH1o7GquBZeIMAe+P6eb1yxDoYAhWY=;
Received: from mail-ej1-f53.google.com ([209.85.218.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTJqd-000000007og-49Ms for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:07:49 +0000
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c50ac25cdd4so481567566b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 06:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794924461; x=1795529261; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aR5h7QKdhh/ggj9NR1Gpswzd6+cRk0/cbmsiFOzDIjA=;
 b=cusHMatUcB2umnmzuYuKn4on5JeTQcQqhOP4vjSr7dw+6a3v9ZBzsZ7Jg+nZJwjBs8
 +0I1v3PmoEejix5zgKkIhAX6nwsAwzgliabsiV6Cq+QHwTEzNJIAp/FLPCVjoGa4Hrkt
 oovYbx8iVSNQLS8oyXme4b9bxWNujO7n8yfOkMkrUG5fcCmYhWMKDVLrpBPWnD9OQsA4
 7yuzGMtIoQmlclohcB3pEwnKV6XoPjrnuo0YjUT1cLTZ0NdH/dntZHc4zQ7W18YuEPC5
 EF8M8JmjebA8ANOkTzEj/cbJoJnafpz1tE18emzvZTKrfeO+8YCi/p6omhHTl6mSqJWJ
 neCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794924461; x=1795529261;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aR5h7QKdhh/ggj9NR1Gpswzd6+cRk0/cbmsiFOzDIjA=;
 b=qG/p9/GBgRzX2xFfiv3UYPBSv6q/BrLD3GJaSMisWXtxwOloYTxgHmJklovFZ2/CcE
 EsNp1bpAmLxAgUrapnyik78s+sMgeEDXolCwahFeuhBvYb57IZDLc0CaCBnWL/SHWhtA
 j/2h/ksCdX6CXv834hVT+tDIIR+dnMbAwGoPrEx0PnDGi5eBnJ0UmeLkXZNHjhdWH+jr
 lvm3leVXE9i/ntUTaaIDEuxUMVVJCxhsuVidkerMdmJLSgcpCzRkcho8Kaz7McuZEB8q
 bwDPHpe9wgEwdbChOyiJGBNg3DhhH11wEjTZYwILjHkUTGvwI4c/iR/ibCX3Za7thMNK
 8pSg==
X-Gm-Message-State: APuU4Z8lKnTE/BpZZGd501FsW20TL5OP2Pt2WN/XXBXtjrZfgTbHuDc6
 p2+tCurqE6VXK7QMmumgdlHYtvuGxtflzdz+u66cUcY1FNYt6d0Gf7atSSRfxPuiklnbwOPRHdS
 HjISHvmgHr8KjiDY6hAZd4w8B4IZdfQD/2Se6drNXha3aqCg0jvy0e9iXBHdS7pSl3rioU42LFP
 ddq7R7Dw==
X-Gm-Gg: AYBFou0I5ganiQSCF/0x1mu3jGSA2xWeg219F1HJLVoketYBTmXoR+wfT7OGYjPjCzg
 kJoQ72z81zKTxeD22EyGq/UrqfDTov10y36kYeU6X+oDJJoM5P6Hxnjbd5AudJ4xucqH0wB7Vvd
 NzMZCH3rHcnax6+fUBPSQtKm6rJwhlEf2TzYuIeLkPNevox3znIv+fp549kzaI48zV+q2Dd0IOr
 NAITzS4HtkDJe9CRreItmVE1wPQw9rBzeDfM+EHEub4UrMRba9XrGrOcwpglnVf2WFveyvv+xJh
 9ZV7Qxo/OtAJlZPYiWpcC+z0esUEtMUeswTStQy/WslPafKCtuDUPyntGW4q3zyAkOU1hg72U5q
 ujYmZsuvITLtU55ScagKwiSPZ5J5W+HXrWJhUyBUcFS0jwWR9rLMGBO8bjoYFe1kfJsP3cWCXjB
 2ZY1fJKKZKOVv3BCGqK2cLc8atVH17eUGSs+YMW3oqRXuWBecGTaCk155IX5D1NrRxPkCBq1qfq
 vqbmyxVAqoByzxloKi8fcBMgFeKE68d+4jEKaYOmlaKWXDd/84cnN693jp+pBt8oa5u/xvTlXXF
 Ra12IANUnw2m/pxtFQFTdRFeQBtUx5KLDNYeQ5lhf8Dx4zTUqZCTuijo4WEj2HS45yUNJSOjvyr
 ZKkPuqls0tCFHGOwQoRuJ9GaaD15ZH+CJ8u/MLMUDOsSobGOCDpBkFr9wyTEImsjFtQgkgf0KFF
 uUK8pWzO+ffe2Em08=
X-Received: by 2002:a17:907:980b:b0:c29:f5d8:9c73 with SMTP id
 a640c23a62f3a-c50963daba3mr1249344666b.34.1794924460682; 
 Tue, 17 Nov 2026 06:07:40 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b79d19sm544885566b.71.2026.11.17.06.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:07:40 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 14:07:39 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I06302e82cdc7c98503430500daa4ec95f5ce961f
X-Gerrit-Change-Number: 2212
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2212?usp=email>
X-Gerrit-Commit: d48e8499aa189cc2e576dc15f7e7dd142ff51e4b
References: <gerrit.1794924454000.I06302e82cdc7c98503430500daa4ec95f5ce961f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkkwNjMwMmU4MmNkYzdjOTg1MDM0MzA1MDBkYWE0ZWM5NWY1Y2U5NjFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e0043b8ebb131835f58d52089d21573b1aee5f41-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTJqd-000000007og-49Ms
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: stop polling
 the listen socket while a client is connected
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1607415014588789515=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1607415014588789515==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3OZvChWcmmU="; charset=UTF-8

--3OZvChWcmmU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2212?usp=3Demail

to review the following change=2E
=


Change subject: manage: stop polling the listen socket while a client is =
connected
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

m=
anage: stop polling the listen socket while a client is connected

In serve=
r mode the management listen socket stays in the persistent
event set after=
 a client is accepted=2E A second connection queued on it
keeps it readable=
, so every event wait returns immediately for the
management, management_io=
() finds nothing to do on the client socket,
and the server spins at 100% C=
PU while timers starve=2E

Remove sd_top from the event set on accept; it i=
s re-added when the
state goes back to MS_LISTEN=2E Reset the cached state =
on removal, so the
next update registers the right socket even after an acc=
ept or close in
a standalone management loop, and skip the removal when not=
hing is
registered=2E

Trac: #681
Change-Id: I06302e82cdc7c98503430500daa4e=
c95f5ce961f
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>=

---
M src/openvpn/manage=2Ec
M src/openvpn/multi=2Ec
2 files changed, 16 i=
nsertions(+), 5 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/12/2212/1

diff --git a/src/openvpn/manage=2Ec b/sr=
c/openvpn/manage=2Ec
index e0a490e=2E=2E10bc028 100644
--- a/src/openvpn/ma=
nage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -344,6 +344,17 @@
 #endif
 }
 
+#i=
fndef _WIN32
+static void
+man_delete_event(struct management *man, const s=
ocket_descriptor_t sd)
+{
+    if (man->persist=2Ecallback=2Edelete_event)
=
+    {
+        (*man->persist=2Ecallback=2Edelete_event)(man->persist=2Eca=
llback=2Earg, sd);
+    }
+}
+#endif
+
 static void
 man_close_socket(struc=
t management *man, const socket_descriptor_t sd)
 {
@@ -352,10 +363,7 @@
  =
    * Windows doesn't need this because the ne32 event is permanently
     =
 * enabled at struct management scope=2E
      */
-    if (man->persist=2Ec=
allback=2Edelete_event)
-    {
-        (*man->persist=2Ecallback=2Edelete_=
event)(man->persist=2Ecallback=2Earg, sd);
-    }
+    man_delete_event(man=
, sd);
 #endif
     openvpn_close_socket(sd);
 }
@@ -2070,6 +2078,8 @@
    =
     {
 #ifdef _WIN32
             man_stop_ne32(man);
+#else
+            =
man_delete_event(man, man->connection=2Esd_top);
 #endif
         }
 
diff =
--git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index dacda86=2E=2E23=
89e66 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -40=
53,9 +4053,10 @@
 management_delete_event(void *arg, event_t event)
 {
    =
 struct multi_context *m =3D (struct multi_context *)arg;
-    if (m->multi=
_io)
+    if (m->multi_io && m->multi_io->management_persist_flags)
     {
=
         multi_io_delete_event(m->multi_io, event);
+        m->multi_io->m=
anagement_persist_flags =3D 0;
     }
 }
 

-- 
To view, visit https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2212?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I06302e82cdc7c98503430500daa4ec95f5ce961f
Gerrit-=
Change-Number: 2212
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarco De Gregori <=
gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--3OZvChWcmmU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2212?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">manage: stop polling the listen socket while a client i=
s connected<br><br>In server mode the management listen socket stays in the=
 persistent<br>event set after a client is accepted=2E A second connection =
queued on it<br>keeps it readable, so every event wait returns immediately =
for the<br>management, management_io() finds nothing to do on the client so=
cket,<br>and the server spins at 100% CPU while timers starve=2E<br><br>Rem=
ove sd_top from the event set on accept; it is re-added when the<br>state g=
oes back to MS_LISTEN=2E Reset the cached state on removal, so the<br>next =
update registers the right socket even after an accept or close in<br>a sta=
ndalone management loop, and skip the removal when nothing is<br>registered=
=2E<br><br>Trac: #681<br>Change-Id: I06302e82cdc7c98503430500daa4ec95f5ce96=
1f<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;=
<br>---<br>M src/openvpn/manage=2Ec<br>M src/openvpn/multi=2Ec<br>2 files c=
hanged, 16 insertions(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/12/2212/1</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><sp=
an>index e0a490e=2E=2E10bc028 100644</span><br><span>--- a/src/openvpn/mana=
ge=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -344=
,6 +344,17 @@</span><br><span> #endif</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+man_delete_event(struct managemen=
t *man, const socket_descriptor_t sd)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (man-&gt;persist=2Ecallback=2Edelete_event)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        (*man-&gt;persist=2Ecallback=2Edelete_event)(man-&=
gt;persist=2Ecallback=2Earg, sd);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</=
span><br><span> man_close_socket(struct management *man, const socket_descr=
iptor_t sd)</span><br><span> {</span><br><span>@@ -352,10 +363,7 @@</span><=
br><span>      * Windows doesn&#39;t need this because the ne32 event is pe=
rmanently</span><br><span>      * enabled at struct management scope=2E</sp=
an><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (man-&gt;persist=2Ecallback=2Edelete_event)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        (*man-&gt;persist=2Ecallback=2Edelete_event)(man-&gt;p=
ersist=2Ecallback=2Earg, sd);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ma=
n_delete_event(man, sd);</span><br><span> #endif</span><br><span>     openv=
pn_close_socket(sd);</span><br><span> }</span><br><span>@@ -2070,6 +2078,8 =
@@</span><br><span>         {</span><br><span> #ifdef _WIN32</span><br><spa=
n>             man_stop_ne32(man);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            man_delete_event(man, man-&gt;connection=2Esd_top);</span><br>=
<span> #endif</span><br><span>         }</span><br><span> </span><br><span>=
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>=
index dacda86=2E=2E2389e66 100644</span><br><span>--- a/src/openvpn/multi=
=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -4053,9=
 +4053,10 @@</span><br><span> management_delete_event(void *arg, event_t ev=
ent)</span><br><span> {</span><br><span>     struct multi_context *m =3D (s=
truct multi_context *)arg;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (m-&gt;multi_io)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (m-&gt;multi_io &amp;&amp; m-&gt;multi_io-&gt;management_pe=
rsist_flags)</span><br><span>     {</span><br><span>         multi_io_delet=
e_event(m-&gt;multi_io, event);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        m-&gt;multi_io-&gt;management_persist_flags =3D 0;</spa=
n><br><span>     }</span><br><span> }</span><br></pre><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2212?usp=3Demail">change=
 2212</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2212?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I06302e82cdc7c98503430500daa4ec95f5ce961f </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2212 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco =
De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></h=
tml>
--3OZvChWcmmU=--


--===============1607415014588789515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1607415014588789515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1607415014588789515==--

