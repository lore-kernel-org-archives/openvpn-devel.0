Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87390606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=c2u2Y4c8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Y6X1i/vb;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=klalKfO3;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SDYThVqZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=GdfYbDTZG9RDAA1Vj3jj/Rg3at6wQT7nyFXaFkgrz00=; b=c2u2Y4c8EbVUb4nZe6uzn98osE
	tDEn7s953OZU33SmsOlMru5xfYITPsL7GdoXlopOhp7E8VHBjv1xDKR71UIalZ+rehxNsnZ+kqUfA
	/DzGrbQkxbsKLmnWr9XK2O4mi3hzJXJamJdnybidYBiAfeIN186nQHgbYk1HxL93gVNw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR9HP-000000004NP-1mhM;
	Wed, 11 Nov 2026 14:26:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR9HO-000000004NE-23Mp
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 14:26:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dkbeq5Yx0OL2sdVhUdHDnyjbzjCzFK2V/qxR4HugzCY=; b=Y6X1i/vbb6UG6b39QWn6QgMNZS
 dSCgWMlIHezQ6YBsvKw/j5ieZ2pGP+oa/YV063un+xnn7w82SGp9s4Mzi9R0fSdGFKRU92+0x7rnl
 7FY4tkt4LVHASplAnG50/4Hhy7VNHCFeQZQ//WJWNle4SIcIQyIb8nFbgw+xsVRsRDbA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dkbeq5Yx0OL2sdVhUdHDnyjbzjCzFK2V/qxR4HugzCY=; b=klalKfO3pkAnNwfb7JuLhXCHxg
 YMeW7dU6Pzisl3t6iEshBL+/sHNdBfhS6QBkA49QB/WoTOI6cwmKNLCksI3T1KixdTI2QndmLgZat
 uIf0Ypmq3K+ZkvbBjUgYBIhZFh6ePPY80x/Rh/IbVdGdhhQG33coVshqrfG9lIECT1p8=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR9HM-000000001pA-2sPF for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 14:26:26 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so19628735e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 06:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794407178; x=1795011978; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dkbeq5Yx0OL2sdVhUdHDnyjbzjCzFK2V/qxR4HugzCY=;
 b=SDYThVqZhfJ1JFTVfmieFyT0HlnFUZwR8eY/b1tn+Nt8hPpDALfRmbbpAoy5m3sKm0
 4Q+u7RucYSr+V9coBVkD2sL42NMpL8OzOIMmKGhrHgMvG1lXhRFCUL5DUL+dQSmf7eTQ
 A5Ht2dpKYcWCdwQjuFcxyxxKnrCOQnu9LIThAK6Nhkh2tw8A0GQkBNMAdZHoIE29kScY
 1mWwk4kwj6Jj6qBvpzsprynJlWjq0JHKL+4CB/DBR0A0JKh/9J7fYcKg4iDN2s0G62dX
 Wmuft0kmwrmnc8fpQq/25nMLMkAcDq6fYrq7mUjJjs8tAIuUqiuBXPsR3FrX/eF1519U
 f0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794407178; x=1795011978;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Dkbeq5Yx0OL2sdVhUdHDnyjbzjCzFK2V/qxR4HugzCY=;
 b=08SqlCOIRqj77ZTH2IznAfY3lX0NNRB0DfIgnFPa1rfFv9mZWD9/e9n2bPW9Ty9C08
 nBUsuAnwpScOPc9VcxX4TVrJtTc84gnTzWynlOWxee+2kYe4orX55ruDNFbuumaiP9b+
 sVdBRwhN78pfUHdzRkV9Apb56l4UDAUTIe2f/LYJ3IeQnVVAH0h0/b0IYuMVrhD/1J/3
 OjEqRrGIrwU3hiAc1pgjmZhp7fCMoXUrm1Qz3cm5gd/LeWgLf4iLuGZcIa74xOv22147
 g8FvaoJ/x5rjDFB1tGGxWLyHrOIl9DTbiJUtxatamd8OckZYgij0rxcfwAYyCX5e3wFS
 FUXw==
X-Gm-Message-State: APuU4Z98Inc2Yg/nOuQJssxQegPtfvPABiz3mPBjPKA4tZCAT46foQFh
 ntwdmUJ/KsI80hwzDhfMWlL5NgxaAG6XJjBVKJ2epoMV8+7PnvlTqLA+URT2yU/YJhkCk+yAHQg
 m3iJ4Zb510DPUYTCEXZG32ULmhTdcoZiW3E5x9WuhsgjxRyNhcVLfe7u8/x/Rwo2AEl8v
X-Gm-Gg: AYBFou1h0u+AGXFNWknGx52/DVCjOvWDaHKWRlYunNpjY1U7aJPvTSYK0B47R05cGy+
 8c4KjTnQU5iPC+hy6xvpSb4Cq5Ok08bRntd25lFGlZUQSCF/YKn85XvNQAlm1pJe+4UcKxOo66U
 vwzjaKlOowbKhFHQYex5Qe97N1BZSP2ytxAQud2JMSxzOxTNGAQJmOt2L+lgEF4LoEpOt1wPGV8
 Gn0CwNL2MB7X2EKwL5EpLKpOlJvQfYNyrtdASTkp5QKvtpX/cnjBeTLI/lhQjr9qAidSOgJouyi
 w4GQkBn8MVZ5joDOLjRx3rt2oudXUcQRzNqhbTGL1+2aGjOt++t/21Gd6YaAKWyN63I81Q6w3Ps
 DCwWwVzpO00At3rc7UyeCmNUI6Nxg1Hhv6VSSdtVyi5lX4PyAAf+gUco8z23V9AsEgrOmcH5QK9
 T5pSjpRr2+iit+WmB+2xmHA5cgzH1XNwNky/nHqb7vKbpV35ofeTuLavmDpRBTEDt2yZxF9IoxZ
 lytsIyJJV1fibkL8lAp1BfPtjHltJrtlzZDjQMIZj5H0YizdAt8vN+AjYOTY7m1QIVY9MueXMKr
 QI6YmbgozAc3E45n1OugVQeQJtiN4LowWnlJjWvIDLLu1c5NwKrwkpfxm2GkiFP2X3UeHr1Ro/g
 hve6Q9TdW1NJgm9DJLy/42UNe6lbWGWjGl1n9vISl94SdwcIOYHP8sUuwe6OP1fFnxNyE/fpLAT
 iKBelSniwn6Vpq3xI=
X-Received: by 2002:a05:600c:1e04:b0:4a7:9025:5c3b with SMTP id
 5b1f17b1804b1-4ba093b9702mr44815615e9.19.1794407177837; 
 Wed, 11 Nov 2026 06:26:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fea9eesm229724725e9.11.2026.11.11.06.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:26:17 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 14:26:16 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
X-Gerrit-Change-Number: 2175
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2175?usp=email>
X-Gerrit-Commit: 0ec30f1a1fd63034dc8d2fda869c97e1efbfa474
In-Reply-To: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
References: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzk1MTg2MDAwLkkyMzBiM2IyNDgzZTE1NDc3YjE3OWIyNzdkYzhmN2M5MWM1M2ZhMGMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <799162532dbbb391e6f54a9816e48c2958939c6c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR9HM-000000001pA-2sPF
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 tls_pre_decrypt_extract_session_id and pre_decrypt_find_session
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
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6377881729215555288=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6377881729215555288==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4XkXeuefMUU="; charset=UTF-8

--4XkXeuefMUU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Hello R=C4=83zvan Cojocaru, 

I'd like you to reexamine a change=2E Pleas=
e visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail

t=
o look at the new patch set (#4)=2E

The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru


Change subject: Ex=
tract tls_pre_decrypt_extract_session_id and pre_decrypt_find_session
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Extract tls_pre_=
decrypt_extract_session_id and pre_decrypt_find_session

These functions fu=
lfil steps that can be easily moved to their own
functions to make tls_pre_=
decrypt a bit more readable=2E

Change-Id: I230b3b2483e15477b179b277dc8f7c9=
1c53fa0c0
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvp=
n/ssl=2Ec
1 file changed, 76 insertions(+), 37 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/75/2175/4

diff --git=
 a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 3ad7fe7=2E=2Eb96e913 100=
644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3765,6 +3765,76=
 @@
     return true;
 }
 
+/**
+ * Read the session form the packet buffer=
 buf and puts it into the
+ * parameter sid=2E
+ *
+ * @return true if the =
extraction was successful, false otherwise
+ */
+static bool
+tls_pre_decry=
pt_extract_session_id(const struct link_socket_actual *from,
+             =
                      struct buffer buf, struct session_id *sid)
+{
+    /*=
 skip op code */
+    buf_advance(&buf, 1);
+    if (!session_id_read(sid, =
&buf) || !session_id_defined(sid))
+    {
+        struct gc_arena gc =3D g=
c_new();
+        msg(D_TLS_ERRORS, "TLS Error: session-id not found in pac=
ket from %s",
+            print_link_socket_actual(from, &gc));
+        g=
c_free(&gc);
+        return false;
+    }
+    return true;
+}
+
+/**
+ * =
 Find session matching the session id in sid in multi=2Esession array
+ *
+=
 * @return index of session in multi=2Esession array, TM_SIZE if not found
=
+ *         and -1 on error
+ */
+static int
+tls_pre_decrypt_find_session(=
struct tls_multi *multi, const struct link_socket_actual *from,
+          =
                   const struct session_id *sid)
+{
+    struct gc_arena gc=
 =3D gc_new();
+    int i;
+    /* use session ID to match up packet with a=
ppropriate tls_session object */
+    for (i =3D 0; i < TM_SIZE; ++i)
+    =
{
+        struct tls_session *session =3D &multi->session[i];
+        str=
uct key_state *ks =3D &session->key[KS_PRIMARY];
+
+        dmsg(
+        =
    D_TLS_DEBUG,
+            "TLS: initial packet test, i=3D%d state=3D%s,=
 mysid=3D%s, rec-sid=3D%s, rec-ip=3D%s, stored-sid=3D%s, stored-ip=3D%s",
+=
            i, state_name(ks->state), session_id_print(&session->session_id=
, &gc),
+            session_id_print(sid, &gc), print_link_socket_actual(f=
rom, &gc),
+            session_id_print(&ks->session_id_remote, &gc),
+   =
         print_link_socket_actual(&ks->remote_addr, &gc));
+
+        if (s=
ession_id_equal(&ks->session_id_remote, sid))
+        /* found a match */
=
+        {
+            if (i =3D=3D TM_LAME_DUCK)
+            {
+        =
        msg(D_TLS_ERRORS, "TLS ERROR: received control packet with stale se=
ssion-id=3D%s",
+                    session_id_print(sid, &gc));
+        =
        i =3D -1;
+                goto done;
+            }
+            d=
msg(D_TLS_DEBUG, "TLS: found match, session[%d], sid=3D%s", i,
+           =
      session_id_print(sid, &gc));
+            break;
+        }
+    }
+
=
+done:
+    gc_free(&gc);
+    return i;
+}
+
 /*
  *
  * When we are in TL=
S mode, this is the first routine which sees
@@ -3820,7 +3890,6 @@
     /* =
control channel packet */
     bool do_burst =3D false;
     bool new_link =
=3D false;
-    struct session_id sid; /* remote session ID */
 
     /* ve=
rify legal opcode */
     if (!tls_pre_decrypt_verify_opcode(op, multi->opt=
=2Eserver, from))
@@ -3834,46 +3903,16 @@
     dmsg(D_TLS_DEBUG, "TLS: cont=
rol channel, op=3D%s, IP=3D%s", packet_opcode_name(op),
          print_lin=
k_socket_actual(from, &gc));
 
-    /* get remote session-id */
+    struct=
 session_id sid; /* remote session ID */
+    if (!tls_pre_decrypt_extract_=
session_id(from, *buf, &sid))
     {
-        struct buffer tmp =3D *buf;
-=
        buf_advance(&tmp, 1);
-        if (!session_id_read(&sid, &tmp) || =
!session_id_defined(&sid))
-        {
-            msg(D_TLS_ERRORS, "TLS E=
rror: session-id not found in packet from %s",
-                print_link_=
socket_actual(from, &gc));
-            goto error;
-        }
+        got=
o error;
     }
 
-    int i;
-    /* use session ID to match up packet wit=
h appropriate tls_session object */
-    for (i =3D 0; i < TM_SIZE; ++i)
+ =
   int i =3D tls_pre_decrypt_find_session(multi, from, &sid);
+    if (i =
=3D=3D -1)
     {
-        struct tls_session *session =3D &multi->session[=
i];
-        struct key_state *ks =3D &session->key[KS_PRIMARY];
-
-       =
 dmsg(
-            D_TLS_DEBUG,
-            "TLS: initial packet test, i=
=3D%d state=3D%s, mysid=3D%s, rec-sid=3D%s, rec-ip=3D%s, stored-sid=3D%s, s=
tored-ip=3D%s",
-            i, state_name(ks->state), session_id_print(&se=
ssion->session_id, &gc),
-            session_id_print(&sid, &gc), print_li=
nk_socket_actual(from, &gc),
-            session_id_print(&ks->session_id_=
remote, &gc),
-            print_link_socket_actual(&ks->remote_addr, &gc))=
;
-
-        if (session_id_equal(&ks->session_id_remote, &sid))
-        /=
* found a match */
-        {
-            if (i =3D=3D TM_LAME_DUCK)
-    =
        {
-                msg(D_TLS_ERRORS, "TLS ERROR: received control p=
acket with stale session-id=3D%s",
-                    session_id_print(&s=
id, &gc));
-                goto error;
-            }
-            dmsg(D_=
TLS_DEBUG, "TLS: found match, session[%d], sid=3D%s", i,
-                 =
session_id_print(&sid, &gc));
-            break;
-        }
+        goto =
error;
     }
 
     /*

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2175?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
Gerrit-Change-Number: 21=
75
Gerrit-PatchSet: 4
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe=
 <arne-openvpn@rfc2549=2Eorg>

--4XkXeuefMUU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Arne Sc=
hwabe <strong>uploaded patch set #4</strong> to this change=2E</p><p><a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Re=
view+2 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">Extract tls_pre_decrypt_ext=
ract_session_id and pre_decrypt_find_session<br><br>These functions fulfil =
steps that can be easily moved to their own<br>functions to make tls_pre_de=
crypt a bit more readable=2E<br><br>Change-Id: I230b3b2483e15477b179b277dc8=
f7c91c53fa0c0<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>=
---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 76 insertions(+), 37 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/75/2175/4</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec =
b/src/openvpn/ssl=2Ec</span><br><span>index 3ad7fe7=2E=2Eb96e913 100644</sp=
an><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ss=
l=2Ec</span><br><span>@@ -3765,6 +3765,76 @@</span><br><span>     return tr=
ue;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Read the session form the packet buffer buf and puts it into the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * parameter sid=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @return true if the extraction was s=
uccessful, false otherwise</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_pre_decrypt_e=
xtract_session_id(const struct link_socket_actual *from,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                   str=
uct buffer buf, struct session_id *sid)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* skip op code */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    buf_advance(&amp;buf, 1);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!session_id_read(sid, &amp;buf) || !session_id_defin=
ed(sid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(D_TLS_ERRORS, &quot;TLS Error: session-id not found in packet from =
%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  print_link_socket_actual(from, &amp;gc));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  Find session matching the sessio=
n id in sid in multi=2Esession array</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @return index of session in multi=2Esession array, TM_SIZE if not found<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         and -1 on=
 error</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+tls_pre_decrypt_find_session(struct tl=
s_multi *multi, const struct link_socket_actual *from,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                             const struc=
t session_id *sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena=
 gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* use =
session ID to match up packet with appropriate tls_session object */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; T=
M_SIZE; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_se=
ssion *session =3D &amp;multi-&gt;session[i];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        struct key_state *ks =3D &amp;session-&gt=
;key[KS_PRIMARY];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dmsg(</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            D_TLS_DEBUG,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;TLS:=
 initial packet test, i=3D%d state=3D%s, mysid=3D%s, rec-sid=3D%s, rec-ip=
=3D%s, stored-sid=3D%s, stored-ip=3D%s&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            i, state_name(ks-&gt;state), session_=
id_print(&amp;session-&gt;session_id, &amp;gc),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            session_id_print(sid, &amp;gc), pri=
nt_link_socket_actual(from, &amp;gc),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            session_id_print(&amp;ks-&gt;session_id_remot=
e, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     print_link_socket_actual(&amp;ks-&gt;remote_addr, &amp;gc));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (session_id_equal(&amp;ks-&gt;session=
_id_remote, sid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* found a match */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (i =3D=3D TM_LAME_DUCK)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                msg(D_TLS_ERRORS, &quot;TLS ERROR: received contro=
l packet with stale session-id=3D%s&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    session_id_print(sid, &amp;gc));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                i =
=3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 dmsg(D_TLS_DEBUG, &quot;TLS: found match, session[%d], sid=3D%s&quot;, i,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 ses=
sion_id_print(sid, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return i;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> /*</span><br><span>  *</span><br><span>  * When we a=
re in TLS mode, this is the first routine which sees</span><br><span>@@ -38=
20,7 +3890,6 @@</span><br><span>     /* control channel packet */</span><br=
><span>     bool do_burst =3D false;</span><br><span>     bool new_link =3D=
 false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct ses=
sion_id sid; /* remote session ID */</span><br><span> </span><br><span>    =
 /* verify legal opcode */</span><br><span>     if (!tls_pre_decrypt_verify=
_opcode(op, multi-&gt;opt=2Eserver, from))</span><br><span>@@ -3834,46 +390=
3,16 @@</span><br><span>     dmsg(D_TLS_DEBUG, &quot;TLS: control channel, =
op=3D%s, IP=3D%s&quot;, packet_opcode_name(op),</span><br><span>          p=
rint_link_socket_actual(from, &amp;gc));</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /* get remote session-id */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid;=
 /* remote session ID */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!tls_pre_decrypt_extract_session_id(from, *buf, &amp;sid))</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      struct buffer tmp =3D *buf;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        buf_advance(&amp;tmp, 1);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (!session_id_read(&amp;sid, &amp;tmp) ||=
 !session_id_defined(&amp;sid))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          msg(D_TLS_ERRORS, &quot;TLS Error: session-id not found in packet=
 from %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          print_link_socket_actual(from, &amp;gc));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            goto error;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        goto error;</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* use session ID t=
o match up packet with appropriate tls_session object */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; TM_SIZE; ++i)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i =3D tls_pre=
_decrypt_find_session(multi, from, &amp;sid);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (i =3D=3D -1)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct tls_session =
*session =3D &amp;multi-&gt;session[i];</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        struct key_state *ks =3D &amp;session-&gt;key[KS_=
PRIMARY];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        dmsg(</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            D_TLS_DEBUG,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            &quot;TLS: initial packet =
test, i=3D%d state=3D%s, mysid=3D%s, rec-sid=3D%s, rec-ip=3D%s, stored-sid=
=3D%s, stored-ip=3D%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            i, state_name(ks-&gt;state), session_id_print(&amp;sessi=
on-&gt;session_id, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            session_id_print(&amp;sid, &amp;gc), print_link_socket_a=
ctual(from, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            session_id_print(&amp;ks-&gt;session_id_remote, &amp;gc),</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            print_link_sock=
et_actual(&amp;ks-&gt;remote_addr, &amp;gc));</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (session_id_equal(&amp;ks-&gt;session_id_remote, &amp;sid))</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* found a matc=
h */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            if (i =3D=3D TM_L=
AME_DUCK)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(=
D_TLS_ERRORS, &quot;TLS ERROR: received control packet with stale session-i=
d=3D%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            session_id_print(&amp;sid, &amp;gc));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                goto error;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            dmsg(D_TLS_DEBUG, &quot;TLS: found ma=
tch, session[%d], sid=3D%s&quot;, i,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                 session_id_print(&amp;sid, &amp;gc));</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br><span>    =
 }</span><br><span> </span><br><span>     /*</span><br></pre><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail"=
>change 2175</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
75?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0 </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 2175 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>

</body></html>
--4XkXeuefMUU=--


--===============6377881729215555288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6377881729215555288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6377881729215555288==--

