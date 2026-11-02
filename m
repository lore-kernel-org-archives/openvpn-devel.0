Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7A6606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LpfEVb7r;
	dkim=temperror header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZBqrr8WA;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ED91CIpp;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=byBaSr6c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uFdEhXNsbREU/9fyihUKcUl8d570yIq8YlZ4TcZRhKo=; b=LpfEVb7rn2ki0Sk7+XEm7Uyym8
	WrABeiX3mGbg/I1lSiP7W+D2JEuus/iwLyfqS0INyyqUcC2aHq0p+GFtzZvGA+CqvrP2xNXFF3PB4
	4BK8McUqHIclI0laol00MxAsnsO69qJQnIKVmyb1xaAUzN1EHJsVJw4VCKq1cbCSpmzg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNpWu-000000008Uv-1jY6;
	Mon, 02 Nov 2026 10:44:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNpWs-000000008Ue-1eKk
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:44:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HpntHejoB7hkY0qkwCpilxYNG7oFrTC5fBTay3v71Mg=; b=ZBqrr8WA5nMrYy0jbHnhQSuWSz
 uQ0BZfM2N5kiw8yMAo2eQ7QGLCqMNH6d48MtmMIFZKxc7sqa9zjD5kT0fB0Iz1lvJ9J66mCAw58iN
 r+8siDOvFRVep238qB0Wb3OCnsKYRMW7wTilbOdsCRLa1UIFdI9NroSIEkcA/AVPYICE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HpntHejoB7hkY0qkwCpilxYNG7oFrTC5fBTay3v71Mg=; b=ED91CIppRDhXD46CPUtfyrlJ5/
 XhBs739uCpVfJwvICLIuLAQ87FWNGbjRR+XoGAs9qhIZM8Zmy0ERcfClDnQosF0ixuE3D1YHEYwXN
 lazqK6zziuzGx6Kq1pqPUihVJrWXe8QFaMiGwCZmQqRgbne308zZnARGw/2HPOVKAzoo=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNpWp-000000003mJ-2WW8 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:44:42 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso1312189f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 02:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793616273; x=1794221073; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HpntHejoB7hkY0qkwCpilxYNG7oFrTC5fBTay3v71Mg=;
 b=byBaSr6cRVN3pZ1WPtm3mx4cOzsPWooy1cFRO6L/kaAtgVC6o9R24a9VVyG4HVUvAn
 9UNSRNNwyJLH3K0b88rucYqCkkSKcIurLPHzKPMEv+AzpNQP097B32rlW8Ua3UMMxgyG
 EpqvsdP7PvYknXIH5rkyXXfzpWbINCSL82r8u/vSjJlb448nXgnoCsV7qUMW9FC4LPqY
 qt/l11/oHVtCSII1SIubRoPXsPqaHVxBsm79VptcfVFySs2ryxY0YSjzV6zxEFVw2SPg
 hARswp8zxgBfuG7DNB9vubRKwKp+rkwb8g0wnFiimg1ynA9MSiDJ4xoXL5Yf6YM/IhPx
 IF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793616273; x=1794221073;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HpntHejoB7hkY0qkwCpilxYNG7oFrTC5fBTay3v71Mg=;
 b=ptp5a+09DKAxatAHaEj0wbyPAE4rAy4ctJs4tBcj1hq/IIFPNiynNJBsgil4qNHsQo
 di3buJk4koVQMwxTvkfIv8cQJubLXgNGbWJ4uSVmjaVYLXMggSVBy5ZRxBi5NBThtdeH
 w34YB1tUA0sd1YbrZT3ToelXhw72D7/PNdJvVFldqTQGV3cqfLcRtAahtNk3aaSeaUgH
 sbtYtSpGCYiBQNuCvu05sLA4/q3nZ5j4tmPBRCbyi+SbQyrodfWxAP/sz4RLrXlJWxcY
 +tKyvhaSYSyGU6xkEB6nbdfBOV4wax6LRgEfs5IrZ6iSJx8N5EIr/CoYgyFQmShUGVJG
 pJuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByb1LOAGafll9qF08FnAPj6fUUc67ghMeOCOrLEkLdeFYEgZhmYjWiACBklL1Dy5XCQnLzgRu7VvHXRH4N6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/ZLuxCPZBsU9QX1kC9kUPDjs6aRRX61d64cn6aPS19xooSMe9l
 FbrZNHY7KjEqGnrBi+zg+Q2z2GL+GU86AtsIEMf9CkPejEXuO7xtA0H65e7l+O0Oknx84TnHXyR
 DxhSO/xFK8gU5DxHGzFCyZN5lkKrPFQ01MEfO2MEeUgpUOWCUjUYwBRWq3/dodNobBq7Y
X-Gm-Gg: AYBFou2HzwXnKrjWgNtSwvTRDz4hmONgfwG7MdVXgeQu/w10farbnXP0Qqzm/0ADrsK
 8C3Q2xnGRJ4Tvd++ZT2y60WrKOfLBrm2NixJSMK4hUoh4/uJv8shDxxkCp1pfrp//FyutPGTxXr
 P8CkYFYGTVqQGOxM1n38n1WSVQ+9Ufie5pC8oGbb5HnfZuXJYeji/uT73/bhzgaGSzFRzDE3BU+
 s8/eI9W07TL8UD/QZtketHbO5pJDsNUeLbNeqlrbpVeG8uWad2TrQIZRl//z0rCfZ6emKwcee6t
 zKQT+sAMYbbpkv/78UiOx2jUtzQpXs29QjjEhJNpFUCEL5Sg/vcNVTSjadCVJh3SyKefBAnHGTt
 f5KAf6LUJD5+VakNdcqluTNsTiEUTWzza8OHRjGquBtGtWf3bW5WAb6yDDSyXT0nzCOwt3sich0
 3GYI5gSodmaNYVZZ2ZtV0IkuwP1YHvCx8E1h8kpj1cKM/C5a8bmJseDXKuD+zEt6ivgnzPa7bkp
 j6vpU9gf7UVqdNf/3Nd4FTDlGRV/Tz7HgrJGN/1e+t6FLB1JhKBpREuxaddj9OasEJDf2twp3ZU
 dMQIsmqOT38cvFIYcD5x9ZAAbaa8PBhsb3UtRcP95Oazo+WSS5EF3/bjmsoUcltJjnOps6m2wMx
 hvNvSSOeqmNypAaewOoht64OJi/B8LuuzvPDs8hJUY6PaTKz7gyvQ89WGL03cE/K2nSnSBpCyhb
 qH5ANscNASEyLe6DkPNVIHcShwlpXEQhq44ZQ=
X-Received: by 2002:a05:6000:2c0f:b0:48e:25e1:5eb8 with SMTP id
 ffacd0b85a97d-48e6e2c1430mr22645456f8f.3.1793616272869; 
 Mon, 02 Nov 2026 02:44:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bab1a8sm19175843f8f.57.2026.11.02.02.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:44:32 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 10:44:32 +0000
To: Selva Nair <selva.nair@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045
X-Gerrit-Change-Number: 2073
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2073?usp=email>
X-Gerrit-Commit: 35f40a2cb94317dc15dfbae82b7477c86a8d4219
In-Reply-To: <gerrit.1793389270000.Iea14ef08268e6f6309e4bac4acff27958da8b045@gerrit.openvpn.net>
References: <gerrit.1793389270000.Iea14ef08268e6f6309e4bac4acff27958da8b045@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMzg5MjcwMDAwLkllYTE0ZWYwODI2OGU2ZjYzMDllNGJhYzRhY2ZmMjc5NThkYThiMDQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f63e6fe220dab917fe4211c34c48642855a4a1b9-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNpWp-000000003mJ-2WW8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Increase the buffer
 size for alert-message in management user-pass query
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2219953795316664959=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2219953795316664959==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YdBVNVcZgls="; charset=UTF-8

--YdBVNVcZgls=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2073?usp=3Demail )

Change subject: Increase the buffer size fo=
r alert-message in management user-pass query
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Increase the buffer size for alert-messa=
ge in management user-pass query

Increase the buffer size from 128 to 256 =
to accommodate a reasonably
long username and static challenge message when=
 both are included in
the prompt=2E Print a warning if the text is truncate=
d=2E

If the encoded " UN:<username-base64>" string is longer than 128 byte=
s,
skip adding it to the prompt=2E Print a warning=2E This caters to up to
=
about 90 bytes long usernames=2E

Change-Id: Iea14ef08268e6f6309e4bac4acff2=
7958da8b045
Signed-off-by: Selva Nair <selva=2Enair@gmail=2Ecom>
Acked-by: =
Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2073
Message-Id: <20261031074840=2E27546-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg40361=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
1 file changed, 16 insertions(+),=
 8 deletions(-)




diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manag=
e=2Ec
index 65e2881=2E=2E16864c8 100644
--- a/src/openvpn/manage=2Ec
+++ b/=
src/openvpn/manage=2Ec
@@ -3618,7 +3618,7 @@
     {
         volatile int s=
ignal_received =3D 0;
         const bool standalone_disabled_save =3D man-=
>persist=2Estandalone_disabled;
-        struct buffer alert_msg =3D alloc_=
buf_gc(128, &gc);
+        struct buffer alert_msg =3D alloc_buf_gc(256, &g=
c);
         const char *alert_type =3D NULL;
         const char *prefix =
=3D NULL;
         unsigned int up_query_mode =3D 0;
@@ -3680,23 +3680,31 @=
@
              * Indicate it in the prompt as base64 encoded=2E
          =
    */
             char *user64 =3D NULL;
-            if (openvpn_base64_=
encode(up->username, (int)strlen(up->username), &user64) !=3D -1)
+        =
    const int user64_len =3D openvpn_base64_encode(up->username, (int)strle=
n(up->username), &user64);
+            if (user64_len =3D=3D -1)
         =
    {
-                buf_printf(&alert_msg, " UN:%s", user64);
+         =
       msg(M_NONFATAL, "ERROR: could not base64-encode username");
+       =
     }
+            else if (user64_len + 4 > 128)
+            {
+        =
        msg(M_WARN | M_INFO, "Preferred username too long for user-pass pro=
mpt sent to management; omitting UN:<username> hint=2E");
             }
  =
           else
             {
-                msg(M_NONFATAL, "ERROR: cou=
ld not base64-encode username");
+                buf_printf(&alert_msg, " =
UN:%s", user64);
             }
             free(user64);
         }
 
   =
      if (sc)
         {
-            buf_printf(&alert_msg, " SC:%d,%s",
-=
                       BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECH=
O)
-                           | (BOOL_CAST(flags & GET_USER_PASS_STATIC_CH=
ALLENGE_CONCAT) << 1),
-                       sc);
+            if (!buf_p=
rintf(&alert_msg, " SC:%d,%s",
+                            BOOL_CAST(flags=
 & GET_USER_PASS_STATIC_CHALLENGE_ECHO)
+                                | =
(BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_CONCAT) << 1),
+         =
                   sc))
+            {
+                msg(M_WARN | M_INFO=
, "SC:<challenge-text> in user-pass prompt sent to management got truncated=
=2E");
+            }
         }
 
         man_wait_for_client_connection(=
man, &signal_received, 0, MWCC_PASSWORD_WAIT);

-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045
Gerrit=
-Change-Number: 2073
Gerrit-PatchSet: 3
Gerrit-Owner: Selva Nair <selva=2En=
air@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--YdBVNVcZgls=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2073?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Increase the buffer size for alert=
-message in management user-pass query<br><br>Increase the buffer size from=
 128 to 256 to accommodate a reasonably<br>long username and static challen=
ge message when both are included in<br>the prompt=2E Print a warning if th=
e text is truncated=2E<br><br>If the encoded &quot; UN:&lt;username-base64&=
gt;&quot; string is longer than 128 bytes,<br>skip adding it to the prompt=
=2E Print a warning=2E This caters to up to<br>about 90 bytes long username=
s=2E<br><br>Change-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045<br>Signed-=
off-by: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt;<br>Acked-by: Razvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2073<br>Message-Id: &lt;20261031074840=2E27546-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg40361=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/manage=2Ec<br>1 file=
 changed, 16 insertions(+), 8 deletions(-)<br><br></pre>
<pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 65e2881=
=2E=2E16864c8 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br=
><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -3618,7 +3618,7 @@</=
span><br><span>     {</span><br><span>         volatile int signal_received=
 =3D 0;</span><br><span>         const bool standalone_disabled_save =3D ma=
n-&gt;persist=2Estandalone_disabled;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        struct buffer alert_msg =3D alloc_buf_gc(128, &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct b=
uffer alert_msg =3D alloc_buf_gc(256, &amp;gc);</span><br><span>         co=
nst char *alert_type =3D NULL;</span><br><span>         const char *prefix =
=3D NULL;</span><br><span>         unsigned int up_query_mode =3D 0;</span>=
<br><span>@@ -3680,23 +3680,31 @@</span><br><span>              * Indicate =
it in the prompt as base64 encoded=2E</span><br><span>              */</spa=
n><br><span>             char *user64 =3D NULL;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            if (openvpn_base64_encode(up-&gt;user=
name, (int)strlen(up-&gt;username), &amp;user64) !=3D -1)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            const int user64_len =3D =
openvpn_base64_encode(up-&gt;username, (int)strlen(up-&gt;username), &amp;u=
ser64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (user64_len =3D=3D -1)</span><br><span>             {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                buf_printf(&amp;alert_ms=
g, &quot; UN:%s&quot;, user64);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                msg(M_NONFATAL, &quot;ERROR: could not base64-e=
ncode username&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         else if (user64_len + 4 &gt; 128)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                msg(M_WARN | M_INFO, &quot;Preferred usern=
ame too long for user-pass prompt sent to management; omitting UN:&lt;usern=
ame&gt; hint=2E&quot;);</span><br><span>             }</span><br><span>    =
         else</span><br><span>             {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                msg(M_NONFATAL, &quot;ERROR: could n=
ot base64-encode username&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                buf_printf(&amp;alert_msg, &quot; UN:%s&quot;=
, user64);</span><br><span>             }</span><br><span>             free=
(user64);</span><br><span>         }</span><br><span> </span><br><span>    =
     if (sc)</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            buf_printf(&amp;alert_msg, &quot; SC:%d,%s&qu=
ot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
      BOOL_CAST(flags &amp; GET_USER_PASS_STATIC_CHALLENGE_ECHO)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                           | (BO=
OL_CAST(flags &amp; GET_USER_PASS_STATIC_CHALLENGE_CONCAT) &lt;&lt; 1),</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                       sc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!=
buf_printf(&amp;alert_msg, &quot; SC:%d,%s&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                            BOOL_CAST(flags &=
amp; GET_USER_PASS_STATIC_CHALLENGE_ECHO)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                | (BOOL_CAST(flags &a=
mp; GET_USER_PASS_STATIC_CHALLENGE_CONCAT) &lt;&lt; 1),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                            sc))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                msg(M_WARN | M_I=
NFO, &quot;SC:&lt;challenge-text&gt; in user-pass prompt sent to management=
 got truncated=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            }</span><br><span>         }</span><br><span> </span><br>=
<span>         man_wait_for_client_connection(man, &amp;signal_received, 0,=
 MWCC_PASSWORD_WAIT);</span><br></pre><p>To view, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail">change 2073</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iea14ef08268e6f=
6309e4bac4acff27958da8b045 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 2073 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div=
>
<div style=3D"display:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair@gm=
ail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>

</body></html>
--YdBVNVcZgls=--


--===============2219953795316664959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2219953795316664959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2219953795316664959==--

