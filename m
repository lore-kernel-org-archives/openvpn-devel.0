Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1E6606A320
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lnqOSBVu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=G+o0Z9YE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cbZggjB5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Fqy5riDl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=25gySulrIzGKdPSNbgQ2nBQIsrVSUOpm7y58Qy2Yz1c=; b=lnqOSBVu4v4ZJAZfqEffBi3EQB
	a6u5vovid1bJGhahV5LBbqQvDqjNt5OAWkAcOW2eYmH1sRp91swfvQdtiUxIbNILeqifwawzkfZAH
	3Ny4DGVn9jZEJRKua0lOY9+4FaeCsyOTZs56MKpqng6afIAWy7TWd/n8JTsRIba24W1g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQpui-000000003X2-0yes;
	Tue, 10 Nov 2026 17:45:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQpuh-000000003Ww-1mhM
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 17:45:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oV6dStqc5tp8yc/aEy4a+7AJnE44zIZnFEt+oeKPeHQ=; b=G+o0Z9YExNAA7Tg2fQ1H7iqrJG
 s7IaruZ6MHLBdu9BIeNpPC80cXoFJx57eT43uMJvwyDKhfjoSAx76liORfkYrNoUmljOLAZdPbMxF
 CKbVASIXWVDQZYOjQLeiN4j8LwkcPrcatP87oSro9xnhtAK7kS98dLz80ajArvhkjeCQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oV6dStqc5tp8yc/aEy4a+7AJnE44zIZnFEt+oeKPeHQ=; b=cbZggjB5LTk+OAh4A4LXtalBqn
 4Iswj8c4nFHWYRp0lmi4FGEuWSyxLi6Ta0woQjgwJu4wmehnRjjYh2gxkzdV8a5EpIp3Vjamr3ftm
 5gDZGLzuhmOtBDccTZDPpveZXPsKpg1yTVNVFgg/fpH5hdf/eADlD8LXKK2Ydy64XLdI=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQpug-000000005KG-1RAB for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 17:45:43 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so13567825e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 09:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794332736; x=1794937536; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oV6dStqc5tp8yc/aEy4a+7AJnE44zIZnFEt+oeKPeHQ=;
 b=Fqy5riDlQ8HbVaoJuyBHlkZBcM8qN+s7KJPSLD82tEILEn6/4YmPyWqS4VN4S68D+s
 6LIAjKGQ5smbp+UoXdLh+8/+yQPqpfBiDkVn1witij6puBHvWIuuhXfNNxKQnXHRyJ3Y
 7KWi5Mg2hmfjA/vfjdnO1WtquN73ranVCEhIrk4/2v8TbR6Q30p3SdZ87hFyu7mA8O+m
 90e32MuSgHydpQCyFbV+ktmfQC15+NVM2Jxb/JYpoodEgXG73jv9greQmfomk+MUtfAl
 359XWkg8N3pmylFrlBj+sd/45s0cllv4xm93gd45ULuLlAug5mYe4shHHrOj6Tig1Zfo
 Tk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794332736; x=1794937536;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oV6dStqc5tp8yc/aEy4a+7AJnE44zIZnFEt+oeKPeHQ=;
 b=Eu5YqqNq+PXqisJS4hPxwAVBpCfx9qupF+wg+HSWDbrYqijpzXP8lnvA7ZrOvJ+f4c
 y5c4DDcOk/FHBHs3GLASRoJmbfouZoLIqtXnty6N2eCirzpktanOpQwIX8rv4xE7bTn7
 vIPMe2jaEKC+7UXgn8hE+LC7ZGVTF9yehhABcoeomjz3ZCUBFqe+fpzcPwbJCE+fNega
 6/lfH7aH3lEPosfgNOXojIq5kGae0pqRBIkV16nBFBANpgS+ZMP754GHbBo+D/HboFtV
 juGndLYIyLA3Wmf5oJqhcXivPxy02N+xFwxG5aa8kSwqyBHFx3C5mVHF60pXGYNyNtHl
 Hfpg==
X-Gm-Message-State: APuU4Z+vyT1iXqsC08/3fk23+0z3oWWMzvs9QQT+ZrnP3tjb7j/hRE4f
 sEAxkC90jUOKUDW423SlbWkYJZg2SIV7dsMIggwUMrNFwpQ4+bx0iVnpwvWZgLIcxjtMEHQsXOE
 FtoP+xPya4KV4+GuV0LioKcNMG27qdBAlqV6KD+BAO3mpLIv4FA5jihDsMOkDDqzDbijH4C/yXo
 J9TGZgXA==
X-Gm-Gg: AYBFou3RX7oib2WJfSbXAdAmnBky6z2ZwN/rQA4zt6W6vXhjyswjOE7QPVDPEZKZEsM
 qS2YcndwXhlxe+Aya7d0WmDbpIgY0Quj3RGTFjL+qeusORqTGHkyb/129CbHAp8ToZ6d9XlhPmM
 8nDkLsaQX3OrerZc/krH98IDqabbEiZgE9OyPxB/7ZB60x4KSAT/hS4RoSJJh5OrLOP7NaBLH3o
 fWHAGZPR6gzdlPZch0BgioZgg4sN6NoWf0Gg4qLmeB7bLpSz85+uET5w9PdujF9z1qgic3ZmeAi
 8g+jGwAG72ktcK5kGsxWNECopSiCXtXPS68MYyALgV6YK27QVruv4ueUvHScBE6gcHUFSVishD9
 UnmsI1RKpCecqbHT60pepRMFw+ywvdxqmToHEf7zszo2FtNG95TFJKVzERmCDCWeQ7wUEd+/I72
 BlUUCaZ/tEf8UOu9gy917D8W+switRY1H7+NO6osNiylEsBGlgVUzPIyO43XGIkAi+MWs7sJSBK
 rL1Itz3ygnaXMsiIRyWDaeu101VdkJqJAS05W8nJVjPk4XwVdnJdCPaRX1l7PfsTZZ++gyatWXV
 oR0Ms9A1TcLszHQjGRVtT//vb6CMMunIf7G7BCDy+rvDJ1gK2swvKxDz6v8ipJnUywlR1pYuN7z
 qI+Oa1OjwdNqdIz+JZAw7s40h0yc+x3Zxzb4v9LPpVlft/EeqArfuL86kNf2g6dkH9TvxDubHSK
 sXS7VPMTJ6gYAaW3w7YW3/TOJ9XEMiAjoHlE9m6g==
X-Received: by 2002:a05:600c:3d05:b0:4a1:d459:db4b with SMTP id
 5b1f17b1804b1-4ba0234d4a0mr59235165e9.24.1794332735100; 
 Tue, 10 Nov 2026 09:45:35 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fe9357sm88571895e9.9.2026.11.10.09.45.34
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 09:45:34 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 17:45:34 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I86154e5c997b044f6913bddab58b43193ff539e1
X-Gerrit-Change-Number: 2169
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2169?usp=email>
X-Gerrit-Commit: 7cf1cf94a453259d7a71acd00ab0acdb5660aa75
References: <gerrit.1794332732000.I86154e5c997b044f6913bddab58b43193ff539e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzMyNzMyMDAwLkk4NjE1NGU1Yzk5N2IwNDRmNjkxM2JkZGFiNThiNDMxOTNmZjUzOWUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <da14bf9bcf2a8bcd3655ffd17be38362b7353054-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xQpug-000000005KG-1RAB
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Extract
 tls_pre_decrypt_verify_opcode from tls_pre_decrypt
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8848701338901115757=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8848701338901115757==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xcZ/Ht2qWb8="; charset=UTF-8

--xcZ/Ht2qWb8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has uploaded this change for review=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2169?usp=3Demail )


Change subject: Extract tls_pre_=
decrypt_verify_opcode from tls_pre_decrypt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Extract tls_pre_decrypt_verify_opcode from =
tls_pre_decrypt

This extracts the pre-check to verify allowed op codes int=
o its own
method to reduce the complexity=2E

Change-Id: I86154e5c997b044f6=
913bddab58b43193ff539e1
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
--=
-
M src/openvpn/ssl=2Ec
1 file changed, 41 insertions(+), 7 deletions(-)


=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/69/2169=
/1

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index cdb94ed=2E=
=2E5d33b84 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3=
725,6 +3725,46 @@
     *opt =3D NULL;
 }
 
+/**
+ * Does a very coarse chec=
k on the received opcode=2E It only checks if the
+ * opcode is an allowed =
op code for the peer to send at all, not if this
+ * opcode is valid for th=
e current state=2E
+ */
+static bool
+tls_pre_decrypt_verify_opcode(int op,=
 bool server, const struct link_socket_actual *from)
+{
+    if (op < P_FIR=
ST_OPCODE || op > P_LAST_OPCODE)
+    {
+        if (op =3D=3D P_CONTROL_HA=
RD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)
+        {
=
+            msg(D_TLS_ERRORS, "Peer tried unsupported key-method 1");
+   =
     }
+        struct gc_arena gc =3D gc_new();
+        msg(D_TLS_ERRORS,=
 "TLS Error: unknown opcode received from %s op=3D%d",
+            print_l=
ink_socket_actual(from, &gc), op);
+        gc_free(&gc);
+        return f=
alse;
+    }
+
+    /* hard reset ? */
+    if (is_hard_reset_method2(op))
=
+    {
+        /* verify client -> server or server -> client connection *=
/
+        if (((op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V2 || op =3D=3D P_CO=
NTROL_HARD_RESET_CLIENT_V3)
+             && !server)
+            || ((op =
=3D=3D P_CONTROL_HARD_RESET_SERVER_V2) && server))
+        {
+            =
struct gc_arena gc =3D gc_new();
+            msg(D_TLS_ERRORS,
+          =
      "TLS Error: client->client or server->server connection attempted fro=
m %s",
+                print_link_socket_actual(from, &gc));
+            =
gc_free(&gc);
+            return false;
+        }
+    }
+    return true=
;
+}
+
 /*
  *
  * When we are in TLS mode, this is the first routine which=
 sees
@@ -3783,14 +3823,8 @@
     struct session_id sid; /* remote session =
ID */
 
     /* verify legal opcode */
-    if (op < P_FIRST_OPCODE || op >=
 P_LAST_OPCODE)
+    if (!tls_pre_decrypt_verify_opcode(op, multi->opt=2Ese=
rver, from))
     {
-        if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 |=
| op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)
-        {
-            msg(D_T=
LS_ERRORS, "Peer tried unsupported key-method 1");
-        }
-        msg(=
D_TLS_ERRORS, "TLS Error: unknown opcode received from %s op=3D%d",
-      =
      print_link_socket_actual(from, &gc), op);
         goto error;
     }=

 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2169?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I86154e5c997b=
044f6913bddab58b43193ff539e1
Gerrit-Change-Number: 2169
Gerrit-PatchSet: 1
=
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>

--xcZ/Ht2qWb8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
uploaded this change for <strong>review</strong>=2E</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2169?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Extract tls_pre_decrypt_verify_opcode from tls_pre_decrypt<br>=
<br>This extracts the pre-check to verify allowed op codes into its own<br>=
method to reduce the complexity=2E<br><br>Change-Id: I86154e5c997b044f6913b=
ddab58b43193ff539e1<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&g=
t;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 41 insertions(+), 7 d=
eletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/69/2169/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index cdb94ed=2E=2E5d33b84 10064=
4</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openv=
pn/ssl=2Ec</span><br><span>@@ -3725,6 +3725,46 @@</span><br><span>     *opt=
 =3D NULL;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Does a very coarse check on the received opcode=2E It only c=
hecks if the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * opco=
de is an allowed op code for the peer to send at all, not if this</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * opcode is valid for the cu=
rrent state=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+tls_pre_decrypt_verify_opcode=
(int op, bool server, const struct link_socket_actual *from)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (op &lt; P_FIRST_OPCODE || op &gt; P_LAST_OPC=
ODE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (op =3D=3D P_CONTR=
OL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_ERRORS, &quot;=
Peer tried unsupported key-method 1&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(D_TLS_ERRORS, &quot;TLS Erro=
r: unknown opcode received from %s op=3D%d&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            print_link_socket_actual(from, &a=
mp;gc), op);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* hard reset ? */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (is_hard_reset_method2=
(op))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* verify client -&g=
t; server or server -&gt; client connection */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (((op =3D=3D P_CONTROL_HARD_RESET_CLI=
ENT_V2 || op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             &amp;&amp; !server)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            || ((op =3D=3D P=
_CONTROL_HARD_RESET_SERVER_V2) &amp;&amp; server))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            struct gc_arena gc =3D gc_new();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_ERRORS,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &qu=
ot;TLS Error: client-&gt;client or server-&gt;server connection attempted f=
rom %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          print_link_socket_actual(from, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            return false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> /*</span><br><span>  *</span><br><span>  * When we a=
re in TLS mode, this is the first routine which sees</span><br><span>@@ -37=
83,14 +3823,8 @@</span><br><span>     struct session_id sid; /* remote sess=
ion ID */</span><br><span> </span><br><span>     /* verify legal opcode */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (op &lt; P_FIRS=
T_OPCODE || op &gt; P_LAST_OPCODE)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!tls_pre_decrypt_verify_opcode(op, multi-&gt;opt=2Es=
erver, from))</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =
=3D=3D P_CONTROL_HARD_RESET_SERVER_V1)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            msg(D_TLS_ERRORS, &quot;Peer tried unsupported key-method =
1&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_TLS_ERRORS=
, &quot;TLS Error: unknown opcode received from %s op=3D%d&quot;,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            print_link_socket_a=
ctual(from, &amp;gc), op);</span><br><span>         goto error;</span><br><=
span>     }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2169?usp=3Demail">change 2169</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2169?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I86154e5c997b044f691=
3bddab58b43193ff539e1 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2169 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--xcZ/Ht2qWb8=--


--===============8848701338901115757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8848701338901115757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8848701338901115757==--

