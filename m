Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47B5606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VTP+Mdb/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fzcsji7Z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=U7BP9/48;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bTPfPqPY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ibkLV56ce2trUStVYvEnZr2y/9SJyJGxsQpUOc/Ng54=; b=VTP+Mdb/W3fUXNbaY2ZKaUxgRH
	hAoJq2n7lzRoH50pNkGCsEPgqbd7dbLB0ITKmj0Xt+KBmw9B1/3hm6BMxWsvgis1FghOJmLjF7W1v
	xB+m0VrYQgI3D5pVTQULldF3YNNKU1WJrayLq13qJ4P1RVGBEIOSFH6e0Oz7n0zZVLcw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVPJ9-000000001Fn-0wPF;
	Mon, 23 Nov 2026 08:21:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVPIq-000000001Dn-1RPA
 for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 08:21:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bnYVxzh5bOs02sV/UdYpscKJ2C5xLt5EnCS2gL37DEs=; b=fzcsji7ZJasKe9tVdJHv7SC5mX
 2NWwsSu1GjurfUZ4JKujwfNyB1KS+3JNiWN6E3qlHCB9GbBg6DEiSaGyJV7hq8rDBXs03R1f29Scn
 RxE6qaeIq/JzpN1qC90CTWbmvAeZnozVxNprQ4uvVRQdZlUejWSTLx+B4zRaV/oLMT+M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bnYVxzh5bOs02sV/UdYpscKJ2C5xLt5EnCS2gL37DEs=; b=U7BP9/486WdL9z1PWtc5UUSFOh
 98muzdqOKfsHuRm8GDeksCgETqVt0Ox0gHA1ETT9IRkZLhnMbvfYvhKW1WxfK5OpkMScw8AXl/2KQ
 GdrsJssGNrlWBr7zRVTrOM78vKwidBEQKb36SH16VwxKe21iNgH71Pswz0hEOZSRw+sk=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVPIh-000000006CS-2SQo for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 08:21:27 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4ac08f4a0b2so2097677f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 23 Nov 2026 00:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795422077; x=1796026877; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bnYVxzh5bOs02sV/UdYpscKJ2C5xLt5EnCS2gL37DEs=;
 b=bTPfPqPYcfqOiu/KGJxjtmyZb5s4bQxiEhdqxwwgL9HcMAH8t5rhnS1sFxjGmyoca+
 Rtc+HhYtD7Ld5mX345TnfceR97/WL8VsL+8irroAMhe2GBwdfDTmTmFa6irZ6Q4OHPYT
 avv7iIDctUooowVvpfxYj++vIs3N9tR/1jm/YdH5zp/mluEweFVsQKD6v4RSSNF3k4K9
 V1t6WuRXcSH+B/ifEkBOjhGINvFMttXnReJFsg9ajxm04LQ24ayY3xEuAGj4T0qPN/C5
 ecTEQXvjUg2U0sB9FDLj/Bc4HSCXGevJCqyk7u2cqFmp+SR5UrYqGeU1cAdbHaeHUyoS
 e07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795422077; x=1796026877;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bnYVxzh5bOs02sV/UdYpscKJ2C5xLt5EnCS2gL37DEs=;
 b=s9FFlAMttClq2lc9YZh3TmfRbLZJnyPLiaHrSTRKyQFC++Y/PD1+tDRZwj9Zzncg7c
 RboZYzu274IWzVs4TQd1DriBF20SQo2lNwurdL1GMV2b06FwYWHyyax4XgzS9BVPIwq5
 3n4v74FfRm6POCZfgz3YgbYh6LE6samZ5PQer6ihUfUclQf3OePytJS2dhKSvey2vRIa
 n2ZOV8zIr1HgMnTmtek2Wi3dVdoLtaSd45mCR/7sJ0MmfSGP0MpKAfk7bTCdVMIme9VO
 7l9Bvs8Q6wpe08splg4BfJdCu24KsdB36pYX8vFNT+6O4HTM/zpoAwH+pPVjyfmhKnp1
 HK3w==
X-Forwarded-Encrypted: i=1;
 AL+hErFnKK/qeYvxAVMg1Wu3mPQHQ6YB0SURLKs8rq+8Zuhcda6jqkQ/+B1ZlZQEFGIQeyJ7A90lUtJy3kEbN/u0@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/t4unPy4ImarjEY+1j2kQSqaSjY8P/0Sbx2Zhlaw0L0DECD8kd
 WVzTbqBp5m/aEnoGwFEmE0e7W1b5pXeBi+X+UovLfMzOheZR2ifQKHcuIjWBq9mkn+TkFgYmJOu
 euGHMqm0uXSR3aa4DwtDXsMm2/o43yZv46L8TgetLYw6SfUZ6JkpBMLF6TyyBFp+qV72qEqzyT9
 YtQUh5gw==
X-Gm-Gg: AZFdTZcXw8T1OBU6JmgekDzkylLMsw6obXS/pzhg8bG/9dYmfNc7V4/5Dexkkppr+qT
 V4p7PShmsbrosYELhmfkF1sWfZ1NkF2T83hXwczN83tCkz1Bz8tDVnSSmRtY5DkszJHxI2wb58d
 OabIFn6bvhNBpGPTebXwJZtw+R+DcBQRxlNY7hLJiGGGIX4RJ9i7R+c9jaPdN9ut+goFbmYo2ah
 nD2hi4icI1Rij9CNa3ySgY7KaLeTFVTqTC4J4GOiEjlVxaUXqz//r5d9PYVGwo4jRW2G5OkpA2f
 6qwRb1EC1u03jwtl0MeBLX3ACbxissqmWmNOtzVapeQSFh1Lj6q7MhQI5CBza3DCyhsZf5DRZbg
 9LlDOlyGoQH/ezfbayeqIPpojuEys6/Kmt46pIk29k22jJLp5yFqv9wIc+lNqmUQOOWrYOIJf39
 oWxwYeJ7b66+P47AZ4OvbKURxrz0P+JHdzahYvOR3IwHzVcfBZ7/be+cnZ3pEb2CBtz1xA4PYxv
 D5vPgXjcXzHCTxvc2dzwkO1ruooZ/1ZCeekctQj4PjeihTJfbR+0JkWxy2Ha9lelpULQlKbiU3D
 6N5LySFP5QwxU2k4/mzGJgNF8EP9RsHlNbk/PWef0GtFj56MSAKobl1a43ceIC5ekqRQMDwucxr
 nMHAyJvtN+zcALoyEGiBvXj1rqGxVz7eIOgFBpVRJEdw3ziynUP/aDONyT2gQ0niuW3yafY/C5+
 ql6PTvWY909Lbo+uw=
X-Received: by 2002:adf:e886:0:b0:48e:3ebc:d242 with SMTP id
 ffacd0b85a97d-4abb2dda339mr15772535f8f.37.1795422076837; 
 Mon, 23 Nov 2026 00:21:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fec7sm19471831f8f.26.2026.11.23.00.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 00:21:16 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 23 Nov 2026 08:21:16 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ied65202d269dedfa7ce69e62ef68d775ec0da36c
X-Gerrit-Change-Number: 2231
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2231?usp=email>
X-Gerrit-Commit: f7fe6f8f1715dc3943be629a057739cf3fff0725
In-Reply-To: <gerrit.1795190700000.Ied65202d269dedfa7ce69e62ef68d775ec0da36c@gerrit.openvpn.net>
References: <gerrit.1795190700000.Ied65202d269dedfa7ce69e62ef68d775ec0da36c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTkwNzAwMDAwLkllZDY1MjAyZDI2OWRlZGZhN2NlNjllNjJlZjY4ZDc3NWVjMGRhMzZjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <676bb4634c8315261a0c3eed49da2f2ea95e0b71-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVPIh-000000006CS-2SQo
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: use
 report_command_status() for client-deny, client-kill, pus...
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2374275173185431804=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2374275173185431804==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+3QJdgKbGCg="; charset=UTF-8

--+3QJdgKbGCg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2231?usp=3Demail )

Change subject: manage: use report_command_=
status() for client-deny, client-kill, push-update
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: use report_command_status() f=
or client-deny, client-kill, push-update

These printed the same SUCCESS/ER=
ROR lines by hand=2E Output is unchanged=2E

Change-Id: Ied65202d269dedfa7c=
e69e62ef68d775ec0da36c
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eor=
g>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2231
Message-Id: <20261122113822=2E710-1-ge=
rt@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@=
lists=2Esourceforge=2Enet/msg41785=2Ehtml
Signed-off-by: Gert Doering <gert=
@greenie=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
1 file changed, 3 inserti=
ons(+), 22 deletions(-)




diff --git a/src/openvpn/manage=2Ec b/src/openv=
pn/manage=2Ec
index 86c498e=2E=2Eab814d5 100644
--- a/src/openvpn/manage=2E=
c
+++ b/src/openvpn/manage=2Ec
@@ -1286,14 +1286,7 @@
         {
          =
   const bool status =3D (*man->persist=2Ecallback=2Eclient_auth)(
        =
         man->persist=2Ecallback=2Earg, cid, kid, false, reason, client_rea=
son, NULL);
-            if (status)
-            {
-                msg(M_=
CLIENT, "SUCCESS: client-deny command succeeded");
-            }
-        =
    else
-            {
-                msg(M_CLIENT, "ERROR: client-deny =
command failed");
-            }
+            report_command_status(status,=
 "client-deny");
         }
         else
         {
@@ -1312,14 +1305,7 @@=

         {
             const bool status =3D
                 (*man->pers=
ist=2Ecallback=2Ekill_by_cid)(man->persist=2Ecallback=2Earg, cid, kill_msg)=
;
-            if (status)
-            {
-                msg(M_CLIENT, "S=
UCCESS: client-kill command succeeded");
-            }
-            else
-=
            {
-                msg(M_CLIENT, "ERROR: client-kill command fa=
iled");
-            }
+            report_command_status(status, "client-k=
ill");
         }
         else
         {
@@ -1523,12 +1509,7 @@
         =
status =3D (*man->persist=2Ecallback=2Epush_update_by_cid)(man->persist=2Ec=
allback=2Earg, cid, p[2]);
     }
 
-    if (status)
-    {
-        msg(M_=
CLIENT, "SUCCESS: push-update command succeeded");
-        return;
-    }
=
-    msg(M_CLIENT, "ERROR: push-update command failed");
+    report_comman=
d_status(status, "push-update");
 }
 
 static void

-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2231?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Ied65202d269dedfa7ce69e62ef68d775ec0da36c
Ge=
rrit-Change-Number: 2231
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--+3QJdgKbGCg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2231?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">manage: use report_command_status(=
) for client-deny, client-kill, push-update<br><br>These printed the same S=
UCCESS/ERROR lines by hand=2E Output is unchanged=2E<br><br>Change-Id: Ied6=
5202d269dedfa7ce69e62ef68d775ec0da36c<br>Signed-off-by: Razvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2231<br=
>Message-Id: &lt;20261122113822=2E710-1-gert@greenie=2Emuc=2Ede&gt;<br>URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg41785=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t;<br>---<br>M src/openvpn/manage=2Ec<br>1 file changed, 3 insertions(+), 2=
2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/o=
penvpn/manage=2Ec</span><br><span>index 86c498e=2E=2Eab814d5 100644</span><=
br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/man=
age=2Ec</span><br><span>@@ -1286,14 +1286,7 @@</span><br><span>         {</=
span><br><span>             const bool status =3D (*man-&gt;persist=2Ecallb=
ack=2Eclient_auth)(</span><br><span>                 man-&gt;persist=2Ecall=
back=2Earg, cid, kid, false, reason, client_reason, NULL);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            if (status)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                msg(M_CLIENT, &quot;SUCCESS=
: client-deny command succeeded&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            else</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             msg(M_CLIENT, &quot;ERROR: client-deny command failed&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            report_command_s=
tatus(status, &quot;client-deny&quot;);</span><br><span>         }</span><b=
r><span>         else</span><br><span>         {</span><br><span>@@ -1312,1=
4 +1305,7 @@</span><br><span>         {</span><br><span>             const =
bool status =3D</span><br><span>                 (*man-&gt;persist=2Ecallba=
ck=2Ekill_by_cid)(man-&gt;persist=2Ecallback=2Earg, cid, kill_msg);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            if (status)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                msg(M_CLIENT, &quot=
;SUCCESS: client-kill command succeeded&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            else</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                msg(M_CLIENT, &quot;ERROR: client-kill command failed&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            report_c=
ommand_status(status, &quot;client-kill&quot;);</span><br><span>         }<=
/span><br><span>         else</span><br><span>         {</span><br><span>@@=
 -1523,12 +1509,7 @@</span><br><span>         status =3D (*man-&gt;persist=
=2Ecallback=2Epush_update_by_cid)(man-&gt;persist=2Ecallback=2Earg, cid, p[=
2]);</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (status)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msg(M_CLIENT, &quot;SUCCESS: push-update command succeeded&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    msg(M_CLIENT, &quot;ERROR: push-update=
 command failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    report_command_status(status, &quot;push-update&quot;);</span><br><=
span> }</span><br><span> </span><br><span> static void</span><br></pre><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2231?us=
p=3Demail">change 2231</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2231?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ied65202d269dedfa7ce69e62ef68d775ec0da36c </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2231 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=

</body></html>
--+3QJdgKbGCg=--


--===============2374275173185431804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2374275173185431804==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2374275173185431804==--

