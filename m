Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1609D60A2602
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EHsZMlfp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=a7waIINO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XglHldy1;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VuIfM/Xu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=p/1C8R31eeRmeBJC1ggV3NmpoVOu4Q8+gdH2dD8e2V0=; b=EHsZMlfp3xfAy4AWFA0iqBwt1n
	BJD7ltK1EZEPg5rimoVv5mbsbGNe+FyDN2QQ2CoIYwmmdrL/b7yLaWZb7DlAjLHmk8zkYJi6kqHDY
	ck3Wrq5MflTOr8E4Yv2FXn1g5q6uHVe3YIFO6ZSmRSn9kJQ5fyX69pVwjHKNIZoYdiIw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xURBg-000000004op-0RVh;
	Fri, 20 Nov 2026 16:10:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xURBe-000000004oi-29Bq
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 16:10:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L56vJFIj1aTwQaAsYoBz9oQ9vqrQjTTV8aukQW+ieSM=; b=a7waIINO4jvHr6p4/VIGxim5KC
 U4wCnC0AJUHC+WMFokPdUHxUL0amCeMmd9WMV+W5br3lT98yUiaD/25Fu9Vqif2T0Nq0OUmgVj+KS
 aicSYZY/oi6zCnosxKJ9kl8FjPUmxIjF7nntTOtVMFR0c7VvC/8RnNWLwc4/Stfwq43o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L56vJFIj1aTwQaAsYoBz9oQ9vqrQjTTV8aukQW+ieSM=; b=XglHldy1VdSLNPvm3xsj6rX4hm
 f5/CB0WyZBcDer6jGnNeuwYCA1kEN5YDnEVDVyaFWpp5IqBdZ+EEIzP60Wl1PQruosHnc0eH1f5g8
 Vz3L6cWCZ3RTaeO8S3ulf2zGLMdCe42+A4k6fK2To4eC57XdLfMLz6QgJl8KsSsnhy1w=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xURBc-000000004Th-3HTY for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 16:10:06 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4ac109a8a12so577045f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 08:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795190998; x=1795795798; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L56vJFIj1aTwQaAsYoBz9oQ9vqrQjTTV8aukQW+ieSM=;
 b=VuIfM/Xuk4kBwRSId+ewB2XzRFVlEJS5DRG0GjkpicyCAJyz0aFe7sd4b/wn+A4MIo
 5QelI5BDKaWDJXBb8t4adIAxh2aGrUy1voaXSBp1L4jgj6fuFxx61VzflSf1GcSg1EBH
 qaZZCZwJW9YMdUrNHfK2u5+we5sJAer5TBO81HiA795Y/guaA8An1dPrasssg7St0R8f
 gTxMZq87dE0t8dzFtuX5x1xcCXIXckODMGVr2agx7Q7O7XmzhqdYuWQlf/cvQyIDUtBs
 r2GFuD5Tl/Q3SrCyYMXClOlU+Z6Mo9ZHU2YUXVNYvrgyOsgvZ73sNBkXO9NT4tX14K5j
 o6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795190998; x=1795795798;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L56vJFIj1aTwQaAsYoBz9oQ9vqrQjTTV8aukQW+ieSM=;
 b=a9MXp2spWGSNIuUAZgewzPf/I/8xdbiEsgBhJxZQw/1v6UTSzPw+rdd+ZdbK78aZN+
 UfAmnPc9YP0Pje7rgajtDPHcdbaPU6fr/T7XemXymKs3BOInFX+H0Ccj6nYpokQ3uwjx
 ojnkOaRvZof7gcLH1PB/A1l5UEDLz+gWME7+YHwZTmVUrIaFzX06W+eeXYvsGrfk3sO2
 BKC4/jKGFmJ47IOwOeUzfgVAX1NxhYVQXsImsMUSezolmYTLYrfDwWw52t4oFuo1+GC5
 o28zSfYq0VCkqrY9SX6LmKbQW+uLfZ5UV8IaeSwW19H4eMavkHagrZrDtCeT2w1aNHBt
 4U6A==
X-Gm-Message-State: APuU4Z+mgTUoDqN3Y1ARPmiSLhovurham+FYY/eFcDr/XSA1MCxGZtCc
 6dtySL3Zks19BS2gZOb0qtH5WNbTOwOHVhEQO0OzGCp5FEEqFs+hurLWdhxnDjV0x88G+wRSwh+
 T8sYDTLfxstYBKqX7G1jCsbgr6+gRD7vp7e6/p3N/FJBA3Q6okLYSujKvTa9nJi1J/QYshjYoFs
 nxf4UY5A==
X-Gm-Gg: AZFdTZf5OwKidFNElsJ8KoavrcwbC/5WHQCFCL5bcTBrXJvo4qozugFgYe+Oz/mMcym
 btOnebe8JaEDdZu0Nv6JZHmLPf8otz2HCobLQqfRCW5tvRYN+yzLtN+zA4ZUDa+sPIxi+YFT/Dg
 lLqIHADCfVtM43IrTkBMUfv9d8jvbAapBoaCGuJ1rsAyCKsm3Vh8JaN8rNME4TSpfAY2+sUbjkv
 2qi76tT/UZj5gdgp/04Vo1BcSYpx+3cvogdy7Y8BEGQGvy3UI5g4GzM6AYbOPSvmmM3riQm9+lA
 UV3slCObnayUMUFxngQIYY54etQXVs7Lqeyjuxl/qF/jAjDj2rqH6ypWip4ojIaXfnNQPioOHWZ
 mEYRSZhQzrBTN6k5ItALjopB8rYuDmNcXqMtKTsZGnOMfXh4qikIZMyep1xnU4t8+prsiPMiLYa
 37nHS1ZVR3bMRsIRbgjqu8zueZxW/iP0B/kVJp+Z3RxOWugFFQW+ci7YVvHEx8+l+rYfo/j1wCo
 d1WeTQDeLTJL4qPUfn3cNEYo8WJ17petIdELFFt8u+Me2jImMdTf1gigYNNBwOccxffN8FFvw3Z
 hWEFpIBUvbomipAVHvckS8NH7PiImLJNO8IvtdXwA8MSZ5GUOFBS3Z1exuMZGq43w2j4g9Njy0J
 TzZt65I21gbCbRjbFwA0uAFy2xE4JoSMD/qWQCf4JAucHsNZUNc+hk1dQtKe0kpImpIsEkUwpL1
 rx78f2XxQaByYytFyiQ5Xqbd31ffcHmXnWG1RK
X-Received: by 2002:a5d:64c9:0:b0:4a6:bc53:2478 with SMTP id
 ffacd0b85a97d-4abb0d5256fmr7487725f8f.13.1795190997877; 
 Fri, 20 Nov 2026 08:09:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2e6dsm6647200f8f.6.2026.11.20.08.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 08:09:57 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 16:09:57 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b
X-Gerrit-Change-Number: 2232
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2232?usp=email>
X-Gerrit-Commit: 1498f76e1e0b225e40c3186c7fb6b9b00b27ef12
References: <gerrit.1795190994000.I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTkwOTk0MDAwLkk0OWJjMWZlMGIyYzJhNzFmMmYzNzQ5MWExYjQ0ZDRjYWNjOGE3MDZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <baa16fce5c51c0ee37384ceb33af7ba981dce7c7-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xURBc-000000004Th-3HTY
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
Content-Type: multipart/mixed; boundary="===============3139133537344087658=="
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3139133537344087658==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wCXq9A35aBs="; charset=UTF-8

--wCXq9A35aBs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2232?usp=3Demail

to review the following change=2E
=


Change subject: manage: merge the two multiline flatten helpers
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: merge the two =
multiline flatten helpers

management_query_multiline_flatten_newline() dif=
fered only in the
aggregate length and separator; pass those as parameters =
instead=2E

Change-Id: I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b
---
M src/=
openvpn/manage=2Ec
1 file changed, 7 insertions(+), 36 deletions(-)



  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/32/2232/1

d=
iff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 86c498e=
=2E=2E3505d6b 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=
=2Ec
@@ -3905,45 +3905,17 @@
 }
 
 static char *
-/* returns allocated base=
64 signature */
-management_query_multiline_flatten_newline(struct manageme=
nt *man, const char *b64_data,
-                                           =
const char *prompt, const char *cmd, int *state,
-                         =
                  struct buffer_list **input)
-{
-    int ok;
-    char *re=
sult =3D NULL;
-
-    ok =3D management_query_multiline(man, b64_data, prom=
pt, cmd, state);
-    if (ok && buffer_list_defined(*input))
-    {
-      =
  buffer_list_aggregate_separator(*input, 10000, "\n");
-        const stru=
ct buffer *buf =3D buffer_list_peek(*input);
-        if (buf && BLEN(buf) =
> 0)
-        {
-            result =3D (char *)malloc(BLENZ(buf) + 1);
-  =
          check_malloc_return(result);
-            memcpy(result, buf->dat=
a, BLENZ(buf));
-            result[BLEN(buf)] =3D '\0';
-        }
-    }
=
-
-    buffer_list_free(*input);
-    *input =3D NULL;
-
-    return result=
;
-}
-
-static char *
-/* returns allocated base64 signature */
+/* returns=
 allocated, flattened multiline input */
 management_query_multiline_flatte=
n(struct management *man, const char *b64_data, const char *prompt,
-      =
                             const char *cmd, int *state, struct buffer_lis=
t **input)
+                                   const char *cmd, int *state,=
 struct buffer_list **input,
+                                   const size=
_t max_len, const char *sep)
 {
     char *result =3D NULL;
 
     const in=
t ok =3D management_query_multiline(man, b64_data, prompt, cmd, state);
   =
  if (ok && buffer_list_defined(*input))
     {
-        buffer_list_aggreg=
ate(*input, 2048);
+        buffer_list_aggregate_separator(*input, max_len=
, sep);
         const struct buffer *buf =3D buffer_list_peek(*input);
   =
      if (buf && BLEN(buf) > 0)
         {
@@ -3982,7 +3954,7 @@
     }
   =
  char *ret =3D management_query_multiline_flatten(man, (char *)buf_bptr(&b=
uf_data), prompt, desc,
                                                   =
 &man->connection=2Eext_key_state,
-                                       =
            &man->connection=2Eext_key_input);
+                           =
                        &man->connection=2Eext_key_input, 2048, "");
     f=
ree_buf(&buf_data);
     return ret;
 }
@@ -3995,10 +3967,9 @@
     buf_wri=
te(&buf_prompt, prompt_1, strlen(prompt_1));
     buf_write(&buf_prompt, ce=
rt_name, strlen(cert_name) + 1); /* +1 for \0 */
 
-    char *result;
-    =
result =3D management_query_multiline_flatten_newline(
+    char *result =
=3D management_query_multiline_flatten(
         man, NULL, (char *)buf_bpt=
r(&buf_prompt), "certificate", &man->connection=2Eext_cert_state,
-        =
&man->connection=2Eext_cert_input);
+        &man->connection=2Eext_cert_in=
put, 10000, "\n");
     free_buf(&buf_prompt);
     return result;
 }

-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2232?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I49bc1fe0b2c2a71f2f374=
91a1b44d4cacc8a706b
Gerrit-Change-Number: 2232
Gerrit-PatchSet: 1
Gerrit-Ow=
ner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>

--wCXq9A35aBs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2232?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">manage: merge the two multiline flatten helpers<br><br>=
management_query_multiline_flatten_newline() differed only in the<br>aggreg=
ate length and separator; pass those as parameters instead=2E<br><br>Change=
-Id: I49bc1fe0b2c2a71f2f37491a1b44d4cacc8a706b<br>---<br>M src/openvpn/mana=
ge=2Ec<br>1 file changed, 7 insertions(+), 36 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/32/2232/1</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=
=2Ec</span><br><span>index 86c498e=2E=2E3505d6b 100644</span><br><span>--- =
a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span=
><br><span>@@ -3905,45 +3905,17 @@</span><br><span> }</span><br><span> </sp=
an><br><span> static char *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-/* returns allocated base64 signature */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-management_query_multiline_flatten_newline(struct =
management *man, const char *b64_data,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                           const char *pro=
mpt, const char *cmd, int *state,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                           struct buffer_list *=
*input)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    int ok;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    char *result =3D NULL;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    ok =3D management_query_multiline(man, b64_data, prompt=
, cmd, state);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(ok &amp;&amp; buffer_list_defined(*input))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        buffer_list_aggregate_separator(*input, 10000, &quot;\n&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const struc=
t buffer *buf =3D buffer_list_peek(*input);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (buf &amp;&amp; BLEN(buf) &gt; 0)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            result =3D (char *)malloc(BLEN=
Z(buf) + 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   check_malloc_return(result);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            memcpy(result, buf-&gt;data, BLENZ(buf));</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            result[BLEN(buf)] =3D=
 &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    buffer_list_free(*input);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    *input =3D NULL;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return result;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static char *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-/* returns allocated base64 signature */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* returns allocated, flat=
tened multiline input */</span><br><span> management_query_multiline_flatte=
n(struct management *man, const char *b64_data, const char *prompt,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
      const char *cmd, int *state, struct buffer_list **input)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
   const char *cmd, int *state, struct buffer_list **input,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
const size_t max_len, const char *sep)</span><br><span> {</span><br><span> =
    char *result =3D NULL;</span><br><span> </span><br><span>     const int=
 ok =3D management_query_multiline(man, b64_data, prompt, cmd, state);</spa=
n><br><span>     if (ok &amp;&amp; buffer_list_defined(*input))</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bu=
ffer_list_aggregate(*input, 2048);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        buffer_list_aggregate_separator(*input, max_len, sep=
);</span><br><span>         const struct buffer *buf =3D buffer_list_peek(*=
input);</span><br><span>         if (buf &amp;&amp; BLEN(buf) &gt; 0)</span=
><br><span>         {</span><br><span>@@ -3982,7 +3954,7 @@</span><br><span=
>     }</span><br><span>     char *ret =3D management_query_multiline_flatt=
en(man, (char *)buf_bptr(&amp;buf_data), prompt, desc,</span><br><span>    =
                                                &amp;man-&gt;connection=2Ee=
xt_key_state,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                                           &amp;man-&gt;connection=2Eext_ke=
y_input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                         &amp;man-&gt;connection=2Eext_key_=
input, 2048, &quot;&quot;);</span><br><span>     free_buf(&amp;buf_data);</=
span><br><span>     return ret;</span><br><span> }</span><br><span>@@ -3995=
,10 +3967,9 @@</span><br><span>     buf_write(&amp;buf_prompt, prompt_1, st=
rlen(prompt_1));</span><br><span>     buf_write(&amp;buf_prompt, cert_name,=
 strlen(cert_name) + 1); /* +1 for \0 */</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    char *result;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    result =3D management_query_multiline_=
flatten_newline(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 char *result =3D management_query_multiline_flatten(</span><br><span>     =
    man, NULL, (char *)buf_bptr(&amp;buf_prompt), &quot;certificate&quot;, =
&amp;man-&gt;connection=2Eext_cert_state,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        &amp;man-&gt;connection=2Eext_cert_input);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;man-&gt;con=
nection=2Eext_cert_input, 10000, &quot;\n&quot;);</span><br><span>     free=
_buf(&amp;buf_prompt);</span><br><span>     return result;</span><br><span>=
 }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2232?usp=3Demail">change 2232</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2232?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: I49bc1fe0b2c2a71f2f37491a1b44d4=
cacc8a706b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2232 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"=
display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>

</body></html>
--wCXq9A35aBs=--


--===============3139133537344087658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3139133537344087658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3139133537344087658==--

