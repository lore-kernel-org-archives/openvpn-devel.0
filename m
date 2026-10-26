Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE67606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VmCCOQmR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Wia5wKDE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HPDYKE1U;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Vg3PjksR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=owd28ftDoO/LgklitmXsrXLOFcXVXQqEzCEXh0AVbn8=; b=VmCCOQmR+fbIkEu7OIMm/D5BRB
	UVx/PytT5Alr10wDTRRWXPkNj90zxrlYUDOLfueK3RZgPeZOgb/g8KWus9c4SQKMrHCKven0q/0Jc
	xyj+G4hrPl7PdkG0OkQJC1SmP7cqWXIu0MLqNmLjLNHtqn2kQZOkHML0svBAProEwok4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLQag-000000007IJ-2JMz;
	Mon, 26 Oct 2026 19:42:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLQaf-000000007ID-28Ek
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 19:42:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JFdsuyZITiDw3d4Afn0QVIoGV24szA2v+XgUbp/8nZo=; b=Wia5wKDEuEHeKZCjtxMs/WWEQp
 aQdEQzQYodoV/b9tg1GK/pvaQnDTiJoxaujh/RTT04QPBdfv54zE5JIl3WHcujxTyjoFo1AuBuKE4
 b3XB5qZa58WNUD/5srZ1aSGQpGW90F9kVrFF+aHu719mXhMLRPtH6VNG2J+pFaBQqsLs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JFdsuyZITiDw3d4Afn0QVIoGV24szA2v+XgUbp/8nZo=; b=HPDYKE1Umnp7Yy53OWV9DELAJd
 Jib6ZMhNF9aQO6eG92I6sZhGEah9v1l7LjmVHUoj4bD2wVKx/cgG/c1XkzvuAYhS60Q6I4i9cEL//
 alhxewAAxqbPAfYMKUhgYR7n5FARE1Ru7qeeO5flkN8u4i0OnNCwlF2wD6kWwcOghjj8=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLQae-000000002Ew-2uSE for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 19:42:41 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso35627105e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793043754; x=1793648554; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JFdsuyZITiDw3d4Afn0QVIoGV24szA2v+XgUbp/8nZo=;
 b=Vg3PjksRS2RGAxAopenJOIRf0f9LDQi8nJ9cIQnKbTLCuIxKzJSkp2svzAvithZEll
 D+AUX+Qgr+w8LHcJpllr7EsVelWBj5vcFtAmxxzyPzdJduUpus7IH/WJL/mBPe68cgjY
 rk+kG9e4yKnpr1lqpDc8CFtgrudAC8VGT4aQhjQzzgrptnOiv46l6Ijw85yip842gOVm
 V+0SGSx2VVUbfaHgplRO3Vx43/5qS1CyPL6Jq0N8KovFNYVU7r8Sce92xqjxSGLBXsy2
 yH9zyb6tkbwvSoiTndlLkPs6ns5S1YOUNsvQ3C/zlg8rcOeNNgwen7Cw1PxzJLtXzox1
 0x5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793043754; x=1793648554;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JFdsuyZITiDw3d4Afn0QVIoGV24szA2v+XgUbp/8nZo=;
 b=E0TJtt4FmbZ6+++OANQ7cLCa+JtOn/QmhnoOBQ1PAeO7B3rKzYFDgONn/CEQlggLWX
 1iRdv89IqHMaDTJSyZ1SeJLdo0SXvbKy7VBAVGsyJh2pH1pXnHQEPY8zT3yGjp8Q0k9/
 Yh18FZqP2bIAjGAF9V7uw5s61iUIEmN2EnDVRoBud7k8eqYChT0hqbwbxuowP52gcdyy
 FHeXaa9UpdTpJ9Q+b3TdikBUpNk88dq0VQmuAKOKmFoDtM0x8HDaV7iT+evhOCCdXr+U
 bEEc2wVhUaCV7zIgCSKM8QOCzxX9CM75tBAEYOqJlZsMjHA+PAFtqFZmd5yH0XGumelI
 RNHA==
X-Gm-Message-State: AFq9FYIQriaLkEoaQsMzy/1XXeDclG1MAKBl1sjYe31OjeBh2J4e09Q2
 HlspvK0lX0Z3gpWAfYtzMoCOL0YR5AxDqkH0bzmxQrXBnU0KQvdJAAq4y/cSE+G5n5rB9EFUTuV
 MYAkKTfYb7fYajUgp4842Lp+HrMNW4lpX6gMhmfRX7ccLdTLMzvnKRqYXsT+RZBIpVSse9r8dQ9
 o1hX965A==
X-Gm-Gg: AYBFou2Y6y03BJ8Q4CtebEe/EGJ91CVDVOmHkL6X1ZZDCXw9XpTFOQXlWCf+kHbS6uj
 W4YV+7UQDNoTnHj0/xjWiSWSSpnLRfVPVmlZ/6F7+Wr50pCXLbZzibeXyImFG2wjW00zJgaocTM
 TfUs+R1Sch+9PCkqOQXUc6wse//5urWPFXS+5JIycfjX02V0f///jdvnd+X0iJb12W+mZML8i/V
 19GetVg9Qksw/C8dlsCaMViL2Vg6IMuJ45p997phtq37xp5hm/2pRzwQm1ME2ujGkdusn6B0Ok+
 jtxHbq2spx9Q/d2loWRntMrfbuKZB3kuNCwkERTwO1flPV/BQvBqc0iiu0ztz5dKacGRTKy+KXm
 /RkGoCEn2oCkaVCO0r3djfOLpkhHltLDjoABKEH2X54+2tJkRvt24y5yszvh6KmZjuHDp4tm309
 HGX/pT1ru0VM1L7egvmt9/M9ahD65kruQwmFCHzs2QLkPtIYLQdNQmO7sQrevv12CDvLhYLQFSI
 zPx+RPMCmiezB0Zx0crJkjbgOGmAqK2ecyh7xsbqoNIORO0c+LkdF0Q8xuMCvd808D5IxpsowFk
 W2TQgiUsLaID9q+1tnC4kbfCLwK8ao+UCQTNiN6CxKpiA9amA8USjNW+fre8AbQyynfjITM/v6h
 jjhN3rsqvIgS1NniyAmqNLi3rQ6Ot6h1vM7ZQCttnlQ==
X-Received: by 2002:a05:600c:3b93:b0:4a2:397:73fd with SMTP id
 5b1f17b1804b1-4a35ac96004mr164799325e9.12.1793043753983; 
 Mon, 26 Oct 2026 12:42:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f4f20dsm148404675e9.0.2026.10.26.12.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:42:33 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 19:42:27 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
X-Gerrit-Change-Number: 1856
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1856?usp=email>
X-Gerrit-Commit: 53338ecb6ccfc4f9d8b690e59f69e621b3fbe53d
In-Reply-To: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
References: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MmQ4Nzg1OTU5YzI0YmY2ODgxOTA5NjVlNThiOWI5ODI1MWI4NTU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <98b2e439e3caea8fc6ac896997f5379d07e637c4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLQae-000000002Ew-2uSE
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Introduce
 get_key_by_management_key_id helper function
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1044280333807345978=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1044280333807345978==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JoH7o8w7EYc="; charset=UTF-8

--JoH7o8w7EYc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Frank Lichtenheld, 

I'd like you to reexamine a change=2E Please visi=
t

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail

to look=
 at the new patch set (#11)=2E

The following approvals got outdated and we=
re removed:
Code-Review+2 by Frank Lichtenheld


Change subject: Introduce =
get_key_by_management_key_id helper function
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Introduce get_key_by_management_key_id help=
er function

This function allows us to map from a management key id to a k=
ey structure
and also allows this function to be reused=2E

Patch v2: add m=
essage when key is not found=2E
Patch v3: only consider valid keys

Change-=
Id: I42d8785959c24bf688190965e58b9b98251b8557
Signed-off-by: Arne Schwabe <=
arne@rfc2549=2Eorg>
---
M src/openvpn/ssl_common=2Eh
M src/openvpn/ssl_veri=
fy=2Ec
2 files changed, 32 insertions(+), 10 deletions(-)


  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/1856/11

diff --git =
a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index 579f46c=2E=
=2E9a55ead 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_co=
mmon=2Eh
@@ -764,4 +764,24 @@
     return &multi->session[TM_ACTIVE]=2Ekey[=
KS_PRIMARY];
 }
 
+#ifdef ENABLE_MANAGEMENT
+/**
+ * Gets the \c key_state =
object that belongs to the management key id or
+ * return NULL if not foun=
d=2E
+ */
+static inline struct key_state *
+get_key_by_management_key_id(s=
truct tls_multi *multi, unsigned int mda_key_id)
+{
+    for (int i =3D 0; =
i < KEY_SCAN_SIZE; ++i)
+    {
+        struct key_state *ks =3D get_key_sc=
an(multi, i);
+        if (ks->mda_key_id =3D=3D mda_key_id && ks->state > =
S_UNDEF)
+        {
+            return ks;
+        }
+    }
+    return N=
ULL;
+}
+#endif
+
 #endif /* SSL_COMMON_H_ */
diff --git a/src/openvpn/ssl_=
verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 73e3696=2E=2E077ee2d 100644
-=
-- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1250,2=
2 +1250,24 @@
 tls_authenticate_key(struct tls_multi *multi, const unsigned=
 int mda_key_id, const bool auth,
                      const char *client_=
reason)
 {
-    bool ret =3D false;
+    struct key_state *ks =3D NULL;
   =
  if (multi)
     {
-        int i;
         auth_set_client_reason(multi, =
client_reason);
-        for (i =3D 0; i < KEY_SCAN_SIZE; ++i)
+        ks =
=3D get_key_by_management_key_id(multi, mda_key_id);
+
+        if (ks)
   =
      {
-            struct key_state *ks =3D get_key_scan(multi, i);
-    =
        if (ks->mda_key_id =3D=3D mda_key_id)
-            {
-             =
   ks->mda_status =3D auth ? ACF_SUCCEEDED : ACF_FAILED;
-                r=
et =3D true;
-            }
+            ks->mda_status =3D auth ? ACF_SUCC=
EEDED : ACF_FAILED;
+        }
+        else
+        {
+            msg(D_=
TLS_DEBUG_LOW, "%s: no key state found for management key id "
+           =
                      "%u",
+                __func__, mda_key_id);
       =
  }
     }
-    return ret;
+    return (bool)ks;
 }
 #endif /* ifdef ENABL=
E_MANAGEMENT */
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1856?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I42d8785959c24bf688190965e58b9b98251b8557
Gerrit-Change-Number: 1856
Ger=
rit-PatchSet: 11
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>

--JoH7o8w7EYc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Arne Schwa=
be <strong>uploaded patch set #11</strong> to this change=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Rev=
iew+2 by Frank Lichtenheld</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Introduce get_key_by_management=
_key_id helper function<br><br>This function allows us to map from a manage=
ment key id to a key structure<br>and also allows this function to be reuse=
d=2E<br><br>Patch v2: add message when key is not found=2E<br>Patch v3: onl=
y consider valid keys<br><br>Change-Id: I42d8785959c24bf688190965e58b9b9825=
1b8557<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>=
M src/openvpn/ssl_common=2Eh<br>M src/openvpn/ssl_verify=2Ec<br>2 files cha=
nged, 32 insertions(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/1856/11</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span=
><br><span>index 579f46c=2E=2E9a55ead 100644</span><br><span>--- a/src/open=
vpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><=
br><span>@@ -764,4 +764,24 @@</span><br><span>     return &amp;multi-&gt;se=
ssion[TM_ACTIVE]=2Ekey[KS_PRIMARY];</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEME=
NT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Gets the \c key_state object t=
hat belongs to the management key id or</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * return NULL if not found=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static inline struct key_state *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+get_key_by_management_key_id(struct tls_multi *=
multi, unsigned int mda_key_id)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fo=
r (int i =3D 0; i &lt; KEY_SCAN_SIZE; ++i)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        struct key_state *ks =3D get_key_scan(multi, i);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (ks-&gt;mda_key_id=
 =3D=3D mda_key_id &amp;&amp; ks-&gt;state &gt; S_UNDEF)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return ks;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* =
SSL_COMMON_H_ */</span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/=
src/openvpn/ssl_verify=2Ec</span><br><span>index 73e3696=2E=2E077ee2d 10064=
4</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/sr=
c/openvpn/ssl_verify=2Ec</span><br><span>@@ -1250,22 +1250,24 @@</span><br>=
<span> tls_authenticate_key(struct tls_multi *multi, const unsigned int mda=
_key_id, const bool auth,</span><br><span>                      const char =
*client_reason)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    bool ret =3D false;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct key_state *ks =3D NULL;</span><br><span>     if=
 (multi)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        int i;</span><br><span>         auth_set_client_reason(mu=
lti, client_reason);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       for (i =3D 0; i &lt; KEY_SCAN_SIZE; ++i)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        ks =3D get_key_by_management_key_id(mul=
ti, mda_key_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ks)</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           struct key_state *ks =3D get_key_scan(multi, i);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            if (ks-&gt;mda_key_id =3D=
=3D mda_key_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  ks-&gt;mda_status =3D auth ? ACF_SUCCEEDED : ACF_FAILED;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                ret =3D true;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            ks-&gt;mda_status =3D au=
th ? ACF_SUCCEEDED : ACF_FAILED;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms=
g(D_TLS_DEBUG_LOW, &quot;%s: no key state found for management key id &quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
               &quot;%u&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                __func__, mda_key_id);</span><br><span>         =
}</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return (bool)ks;</span><br><span> }</span><br><span> #endif /* ifdef ENA=
BLE_MANAGEMENT */</span><br></pre><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail">change 1856</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I42d8785959c2=
4bf688190965e58b9b98251b8557 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1856 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </=
div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</b=
ody></html>
--JoH7o8w7EYc=--


--===============1044280333807345978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1044280333807345978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1044280333807345978==--

