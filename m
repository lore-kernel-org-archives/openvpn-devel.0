Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84615606A331
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MKRg2oWQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LxZP0K0+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mWZJdGx/;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Ds5Utth2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vloZYAM7+J2byTzzm11Q/+mU5PIDlfH6TcbiE9f6E6w=; b=MKRg2oWQolC9aylw1uEtNjY1hv
	bL4dMXVOkgKmaBhenERncxz1jj0xZ/Lt0f+H1PB1lvsJgta7AMdeUK+A7mNmtp4v4zNEftPFHPnBH
	2DJAhbKFHrwQpL/qPPqX39NHjC+1ExVYngiYWYlwdUgUGTe3WC3qOgfMXPaBTvez9hv4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xURGq-000000005s5-4Byj;
	Fri, 20 Nov 2026 16:15:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xURGn-000000005rh-3N5V
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 16:15:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xO2m3t15eYxE5FxpOl39wPSn4pC230N2UIRCayCBveI=; b=LxZP0K0+Tppiz8ybm5UB365Yhk
 VvQ6xPTS5GltmVzGPXpF1g1Z2ij89e4d3xt7Ftbw5c6KF7vxdGGSECf4qYrniYqrJfVdU5sSW66cD
 q/sn6l1pilAhMTE6fBFrCqcWG0LLBjgtqSQznUwImNHXtOfaMJkSNGzODXMQqkJnxOrs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xO2m3t15eYxE5FxpOl39wPSn4pC230N2UIRCayCBveI=; b=mWZJdGx/l2yaLShZhCdx6yqW0S
 o9OATx5IOdLfzvroXbao7OwDQSVaoezQwyJasthLXwP2UGWfg0JuL6vpmB/uajJdoiY38iSuryHOq
 SJW5QiAErwpHJIxrUYv3QbT6hke+2KkJIgyBmPdnqlZkymkzE5EeiArPIZJZyo+OEyZ8=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xURGm-000000004c3-15Ii for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 16:15:25 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so12747525e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 08:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795191318; x=1795796118; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xO2m3t15eYxE5FxpOl39wPSn4pC230N2UIRCayCBveI=;
 b=Ds5Utth2GBc23cyYnU11T3UI+rh98jd2FJlk4yfLI8KIki2YV1f7KWopOBd6neQuCq
 vZM6cJxkDWUEobXhYeZj6Ivv4x6eeOxEHTMfgJMCBGmYRqbV/nEwx3pU4vDZxJkU79Qk
 JqQFhyfMthzq6tMrD4LeuICp9TXU0N6VZ8TORQeA1Y4noaVi+Kh0N4eITr4Itu1YxRv9
 fJp60bwfkFu6i74DNjTb7zRjk4irydJ+AbTIvTvDJw3qKzEcBPx7fO2CotTVR7dPLPE6
 4qj8gvDW0pb+9p48FK0cxJ8XPkCOu2NSpAncqP1QLpjUfRi3POYlRNc7ZjCtI6RFiPxp
 0Vyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795191318; x=1795796118;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xO2m3t15eYxE5FxpOl39wPSn4pC230N2UIRCayCBveI=;
 b=DXxdt7wgxPwf6NaeC8t6GaEN/wiZVpZ8y1xmCtdJPlIRyfPpzoelBYLPI5mzK+qkg3
 Wdrs7GLXTK1MZXCG/dqNyaJ7eN1vMswDVNrbuY2f4KWdkHhLKpXb/pwMqF10VIit+LD0
 caRVgT+gn+Y3WbffrbwRWvMtGB5S++vxEXcwf6ZI76BWtxwryyg//9rQZHclbeawQLq/
 YYXSwH2KUdp0QS3odavi75RqavG493so4sdRcWzvd3PTBy7tP3ni9k2J/Wz3Ll5+Ongg
 TJ5hOpVYJ0EwuDFQvRudwCO0vAd0OBEw/sudET2g9wP9EAHMQ6A849/AkVMmsrwafXp7
 /rVA==
X-Gm-Message-State: APuU4Z//9lTKi40A2hvfLwf4jCmo82q9uyHQwqmup7n9zBr9ZdjRsHlS
 HJ4Xm8kgExeEtNWwyEXj6TDBDBiLN7T0o+QB6001FFbYcVB6AR+p/o6VKXiaxSM2qdGvYgHuEZB
 OeVJlzX0r1HytOIPW3CkNF7gezd/fhrMVqcu0RBhK1IKLfXwKz0mQHrSc40j9MU9LWTc0tAcQZL
 aXTXeMow==
X-Gm-Gg: AYBFou1yxVkx+nuw7WdRaK4rHJ3kfj0M0BmNBeMiTG/nxrjBfTydywgQujnWLJ5vTnF
 XJK9jtJbKubtF+0a1qyqRizI0Y0TYxDZIprJfSI1zt3gGQBr8bSy3FgAbAS7oUUpRZgqcY319gq
 eOkcSCJI+5qfaNBHSOVlgyF1vWM6yiA66TJuHxod11nNYMFzWSrIzO6cBpMc+tBc+VOxA9LQbMY
 wsrh4FEG9YH7/M2C/KVjb5vpm2NnBPIcw10EU5AljdwlNGXN8AxCVghXag82VEynwqmwJaaokzI
 ny85toENzpqT4g9aR5Zol+acK0BpCEqc2seVJO6FOpFo8aDh/FV5fmWHMdDl3X0+lw45xi8c1g6
 Kdu686uGKRN5OprDo4ZVP6h9e1mCHTQ/IC821L3r9vKkWyBsiW7gSPA96yDba3jXmxD/JIHqlDC
 ua5PZctbK6PFRoia+qJV0XP3taKNJF5+SZK55kKxgmLgxjqcy+ZUUIQx8k13+OaS7frIWSkQYso
 JCf2ILmvqJ2KqYkBjEawRTnOsQO85ssmxBx+PyydNGoeYSz6TARsMDkRBzyfwsbu67ZYXNkSK8n
 z+Aajbl2J+y1Uau83gD0661XCimkkb3NrZGa25obsgZTFXV2c+LRXMok0xYJrW3D/UYCERjp6rC
 fyjM0otnNLTKOJ2C7KoDDa/yfvmFWlYFjczRWh24NYVuc8x4PjSscQWB4+u601tb6jqARI/k1c0
 p2mDDRoxIgQ00blGjbyWg8TgPjDzQ/kQVZ8/Qr
X-Received: by 2002:a05:600d:600b:b0:4a2:18c4:61a5 with SMTP id
 5b1f17b1804b1-4bb887fb6e7mr80827615e9.6.1795191317504; 
 Fri, 20 Nov 2026 08:15:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b8429sm147536385e9.14.2026.11.20.08.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 08:15:17 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 16:15:15 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b
X-Gerrit-Change-Number: 2232
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2232?usp=email>
X-Gerrit-Commit: c6ee15ad9c27b777e9be29a2922c851d14a853cc
In-Reply-To: <gerrit.1795190994000.I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b@gerrit.openvpn.net>
References: <gerrit.1795190994000.I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTkwOTk0MDAwLkk0OWJjMWZlMGIyYzJhNzFmMmYzNzQ5MWExYjQ0ZDRjYWNjOGE3MDZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3e72511cc2515eeffd6f294a9cbdb6739a043f56-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xURGm-000000004c3-15Ii
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: merge the
 two multiline flatten helpers
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8929678246384127353=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8929678246384127353==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rnGL99m7HjI="; charset=UTF-8

--rnGL99m7HjI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2232?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: manage: merge the two multiline flatten helpers
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: merge th=
e two multiline flatten helpers

management_query_multiline_flatten_newline=
() differed only in the
aggregate length and separator; pass those as param=
eters instead=2E

Change-Id: I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b
Sign=
ed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/manage=
=2Ec
1 file changed, 7 insertions(+), 36 deletions(-)


  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/32/2232/2

diff --git a/src=
/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 86c498e=2E=2E3505d6b 100=
644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -3905,45 +=
3905,17 @@
 }
 
 static char *
-/* returns allocated base64 signature */
-m=
anagement_query_multiline_flatten_newline(struct management *man, const cha=
r *b64_data,
-                                           const char *prompt=
, const char *cmd, int *state,
-                                           =
struct buffer_list **input)
-{
-    int ok;
-    char *result =3D NULL;
-
-=
    ok =3D management_query_multiline(man, b64_data, prompt, cmd, state);
-=
    if (ok && buffer_list_defined(*input))
-    {
-        buffer_list_aggr=
egate_separator(*input, 10000, "\n");
-        const struct buffer *buf =3D=
 buffer_list_peek(*input);
-        if (buf && BLEN(buf) > 0)
-        {
- =
           result =3D (char *)malloc(BLENZ(buf) + 1);
-            check_ma=
lloc_return(result);
-            memcpy(result, buf->data, BLENZ(buf));
- =
           result[BLEN(buf)] =3D '\0';
-        }
-    }
-
-    buffer_list=
_free(*input);
-    *input =3D NULL;
-
-    return result;
-}
-
-static cha=
r *
-/* returns allocated base64 signature */
+/* returns allocated, flatte=
ned multiline input */
 management_query_multiline_flatten(struct managemen=
t *man, const char *b64_data, const char *prompt,
-                        =
           const char *cmd, int *state, struct buffer_list **input)
+      =
                             const char *cmd, int *state, struct buffer_lis=
t **input,
+                                   const size_t max_len, const =
char *sep)
 {
     char *result =3D NULL;
 
     const int ok =3D managemen=
t_query_multiline(man, b64_data, prompt, cmd, state);
     if (ok && buffer=
_list_defined(*input))
     {
-        buffer_list_aggregate(*input, 2048);=

+        buffer_list_aggregate_separator(*input, max_len, sep);
         c=
onst struct buffer *buf =3D buffer_list_peek(*input);
         if (buf && B=
LEN(buf) > 0)
         {
@@ -3982,7 +3954,7 @@
     }
     char *ret =3D ma=
nagement_query_multiline_flatten(man, (char *)buf_bptr(&buf_data), prompt, =
desc,
                                                    &man->connection=
=2Eext_key_state,
-                                                   &man-=
>connection=2Eext_key_input);
+                                            =
       &man->connection=2Eext_key_input, 2048, "");
     free_buf(&buf_data=
);
     return ret;
 }
@@ -3995,10 +3967,9 @@
     buf_write(&buf_prompt, p=
rompt_1, strlen(prompt_1));
     buf_write(&buf_prompt, cert_name, strlen(c=
ert_name) + 1); /* +1 for \0 */
 
-    char *result;
-    result =3D manage=
ment_query_multiline_flatten_newline(
+    char *result =3D management_quer=
y_multiline_flatten(
         man, NULL, (char *)buf_bptr(&buf_prompt), "ce=
rtificate", &man->connection=2Eext_cert_state,
-        &man->connection=2E=
ext_cert_input);
+        &man->connection=2Eext_cert_input, 10000, "\n");
=
     free_buf(&buf_prompt);
     return result;
 }

-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2232?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a70=
6b
Gerrit-Change-Number: 2232
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--rnGL99m7HjI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru <strong>=
uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2232?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">manage: merge the two multiline flatten helpers<br><br>management=
_query_multiline_flatten_newline() differed only in the<br>aggregate length=
 and separator; pass those as parameters instead=2E<br><br>Change-Id: I49bc=
1fe0b2c2a71f2f37491a1b44d4cacc8a706b<br>Signed-off-by: Razvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/manage=2Ec<br>1 file chan=
ged, 7 insertions(+), 36 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/32/2232/2</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>=
index 86c498e=2E=2E3505d6b 100644</span><br><span>--- a/src/openvpn/manage=
=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -3905,=
45 +3905,17 @@</span><br><span> }</span><br><span> </span><br><span> static=
 char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* returns all=
ocated base64 signature */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-management_query_multiline_flatten_newline(struct management *man, con=
st char *b64_data,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                                        const char *prompt, const char *cmd=
, int *state,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                                   struct buffer_list **input)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int ok;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    char *result =3D NULL;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=
k =3D management_query_multiline(man, b64_data, prompt, cmd, state);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ok &amp;&amp; buffer=
_list_defined(*input))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buffer_=
list_aggregate_separator(*input, 10000, &quot;\n&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        const struct buffer *buf =3D buf=
fer_list_peek(*input);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (buf &amp;&amp; BLEN(buf) &gt; 0)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            result =3D (char *)malloc(BLENZ(buf) + 1);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            check_malloc_retur=
n(result);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 memcpy(result, buf-&gt;data, BLENZ(buf));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            result[BLEN(buf)] =3D &#39;\0&#39;;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  buffer_list_free(*input);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    *input =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return resul=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static char *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-/* returns allocated base64 signature */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* returns allocated, flattened multiline input=
 */</span><br><span> management_query_multiline_flatten(struct management *=
man, const char *b64_data, const char *prompt,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                   const char *cmd=
, int *state, struct buffer_list **input)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                   const char *cmd, i=
nt *state, struct buffer_list **input,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                   const size_t max_len,=
 const char *sep)</span><br><span> {</span><br><span>     char *result =3D =
NULL;</span><br><span> </span><br><span>     const int ok =3D management_qu=
ery_multiline(man, b64_data, prompt, cmd, state);</span><br><span>     if (=
ok &amp;&amp; buffer_list_defined(*input))</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        buffer_list_aggregate(*=
input, 2048);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  buffer_list_aggregate_separator(*input, max_len, sep);</span><br><span>  =
       const struct buffer *buf =3D buffer_list_peek(*input);</span><br><sp=
an>         if (buf &amp;&amp; BLEN(buf) &gt; 0)</span><br><span>         {=
</span><br><span>@@ -3982,7 +3954,7 @@</span><br><span>     }</span><br><sp=
an>     char *ret =3D management_query_multiline_flatten(man, (char *)buf_b=
ptr(&amp;buf_data), prompt, desc,</span><br><span>                         =
                           &amp;man-&gt;connection=2Eext_key_state,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
                      &amp;man-&gt;connection=2Eext_key_input);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
                    &amp;man-&gt;connection=2Eext_key_input, 2048, &quot;&q=
uot;);</span><br><span>     free_buf(&amp;buf_data);</span><br><span>     r=
eturn ret;</span><br><span> }</span><br><span>@@ -3995,10 +3967,9 @@</span>=
<br><span>     buf_write(&amp;buf_prompt, prompt_1, strlen(prompt_1));</spa=
n><br><span>     buf_write(&amp;buf_prompt, cert_name, strlen(cert_name) + =
1); /* +1 for \0 */</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    char *result;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    result =3D management_query_multiline_flatten_newline(</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *result =3D man=
agement_query_multiline_flatten(</span><br><span>         man, NULL, (char =
*)buf_bptr(&amp;buf_prompt), &quot;certificate&quot;, &amp;man-&gt;connecti=
on=2Eext_cert_state,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       &amp;man-&gt;connection=2Eext_cert_input);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        &amp;man-&gt;connection=2Eext_cert_in=
put, 10000, &quot;\n&quot;);</span><br><span>     free_buf(&amp;buf_prompt)=
;</span><br><span>     return result;</span><br><span> }</span><br></pre><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2232?=
usp=3Demail">change 2232</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2232?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchs=
et </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 2232 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerr=
it-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>

</body></html>
--rnGL99m7HjI=--


--===============8929678246384127353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8929678246384127353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8929678246384127353==--

