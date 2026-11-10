Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664A8606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jQaOkFxz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NAG1acuI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=INwq0puo;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fjEOlA0m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=7e6EYsFmM4dVRbUxstavfhUUdSW4EAXNS9yD4kjy5Js=; b=jQaOkFxz3OBkvNTNV48SPLzO1Z
	l0DLZ7Nfe92gvmETyhv3ETjO7crsYdWfDwHIGN+LYo4YSGs5dBqlyaEooTwptM+YPSSBGAsIMAik6
	GElpLVpaHhOztHG0+sYLqrNfxWvtvL2JvYs2xoYWRwaFsqDI4/Oc2alBX+LIUOTQELvQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQiVw-000000006GF-41nf;
	Tue, 10 Nov 2026 09:51:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQiVv-000000006G7-0o23
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 09:51:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AHgeQl0OeTFzlRJMtvb+QtxILyGGXyDRXYcUMMNO8TU=; b=NAG1acuITASLfIarJCI83dQqWm
 /z9rQrN8wb/8xa8y0V1EEjRONQIyqc/whC+hKr9llbSNCaviK3uJXUt3mLdcz3ZplPJ2qcCzXLXK6
 DvvpBeXUxmQxQH+PxNO+axRaS3r4pFG1F9PkhWpxQCf8yMT7INKon08BT6zKCQvmyv+A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AHgeQl0OeTFzlRJMtvb+QtxILyGGXyDRXYcUMMNO8TU=; b=INwq0puowacxZCGk3NB3/1szAa
 bRpnfGfPTf34v1ebvOo0QNryTpQ+T7dJzCaEBvw/NkmgiOzbaMLpkJg6pDdFnZxKIp0eE9s3StJZ+
 ClgZWekjOuxrUS6vQ9/UWgF2uLNy1mILgGMSXVBBqS9a6BK4v8o6SLGqta1pZ6H0DAkM=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQiVt-000000002XO-2eAH for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 09:51:39 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so1177722f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 01:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794304291; x=1794909091; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AHgeQl0OeTFzlRJMtvb+QtxILyGGXyDRXYcUMMNO8TU=;
 b=fjEOlA0mRuZFlpcYyGL2l4o4DAQXatCzMPqBU0Rh/ZkbVLQmKQGq966aIAykLklCOf
 HYNfK3yRB+XcGD61HoKmWoGuQeDQgX8HUQKR6cwr13U+NmAExti6P7SjMk5n9d+f8Yyu
 qESa5Lh1Lt3BgarduLBJKANbbMU+NhvdPLSgWV0IyOAEXeA/U0rlD0CQ9WIjhyA/MHyM
 hg3E40DNuH2hhtxYm1i6615mC28e4QYgw6UX7v4gvHzoKoCdvclwcmHqJlq0GJOrXQIB
 7q/Q0QhdyJxut3rh3azwY8AG7vFQr0VyPbALJ9tVl6EKhrLJ03t63zd4Y26feiFM/ucY
 Y2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794304291; x=1794909091;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AHgeQl0OeTFzlRJMtvb+QtxILyGGXyDRXYcUMMNO8TU=;
 b=GR0nal8wmsknCQIWQ2JterKzGps970nuSMLI8naRzrXDqnpyoiMz39PyYvz2E5/boW
 hbowAL8qeKTWMGdtS6z8zanC8PzkPrICZPsukOBX0TzZdHB31ohI2o1BiYxs5LXvsYag
 oI+xPDb6ogur9D6fLE663Iv/Y+NfoW62VWCMriqJdvCMDM87jo1q6pkulxmfQDR2+PMz
 dDaLfu9cBp6pLWJNf5z47jOps9wAGkBmJcFqdw/5AoFTtELbWxRzjMGTcSCUfZ5TCSTm
 MXxiDL9y7U/HFD2fyX5JgzTCRCZBHE8UhH2YDBDVtQJxsCKJmXaf38bBp3H3/SUXNJS0
 UlQw==
X-Gm-Message-State: APuU4Z9FYJ/UtPstA+QGvhNB5TPD9g7A18voix1fK0FsAHepzAtlcOeI
 J8M6FKGVL0+WJiwM9AezMIoNkldi37o9txidlo3mzIDYxF6bynEhSHeR/dXj+AVkTSdzS4s13LZ
 1h2fGomnoFSAiO6C/e3mW6od1fNs5HpWEVvXdN4WTaMpUNjYp7KHgkKQpruFZDMerCwQYKj5C7M
 10XDqxmQ==
X-Gm-Gg: AYBFou2ynIVthWI6lMMUBdsxJQMkcYxGL7v33M4YDmzhxLPCvEZRn+IS1I5ZnjhFzvm
 MTMYzGMc4Vy0XgCPkQTWU8wWQl4LONOiZV8Fu/BjzELB+TBoouKgZA8b8sSklcRaLwofIKjUeqQ
 WAt/6Ayf6RUfde0/WDSqL+tXlETm3T9rBkFLIMGkNYEwSLl18BGn4kqdf7uu2dUht7vMNwBGCyB
 2WEK//adxwJuyEbbvG7riDIrt5PDFYurA5uD0OCHHdanLZAgsxmEyanPMI/R8lNGVcpG8+eZbBn
 Ljh42vM9hMPa/0fS8/hnOJgf43+vR66lXg3arNE9WzYuu2nlrncAWsUE5GIBDdh2DGdTPO+uONF
 pkz1Md1yEDXQjFhbf1JIvKfSGYEbfsFj37V+NlE/8jGnL0Y2rUXUnsDWfUuucEBSlpodvFqwpbN
 MoacaI8ywghQlCFkEUQ/ZGBIDfGZXOPI+aM4mVvoxLiAQook1ORn03x2qsmseu2tDvjlA3pHUVG
 Bneao7xE27OkxTxSXPTMGaubY/n8fSCVej5sSpnX/EyG6zRdGOnGHha9XaN3hzyNkblrbg7K3HR
 WkojkcQzG8y2uNEKpnDoa9pJ8VaIp0dQn9XnIeXzH6xt1YAsF7gY8aHyZ7nV4lTGWS+XSf5+kiY
 BrX7rCxdwznF8s7O8GZpXaVm6iR3WuI0GRdG0r5y1PmCvxhC9YuCmXTPg/ZlL6S4OmhvVJb3VhO
 yrrIFCtzmwcpQAl/M=
X-Received: by 2002:a05:6000:220b:b0:491:c392:1f35 with SMTP id
 ffacd0b85a97d-498301126c8mr3728858f8f.32.1794304290844; 
 Tue, 10 Nov 2026 01:51:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835e20f91sm4521243f8f.27.2026.11.10.01.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 01:51:30 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 09:51:29 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
X-Gerrit-Change-Number: 2162
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2162?usp=email>
X-Gerrit-Commit: f7ecc5e1df7f4b5260059e70c49b7b6e63f3818d
References: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA0Mjg4MDAwLkljNjAyYjEyNWQ4NTdmMWJlZWQ0YWY4NjYxZjUyMmQzMzliYzllOTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3cf6a63685e67940d3b8abd78931c3b22137abe6-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQiVt-000000002XO-2eAH
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: keep
 IPv6 name servers in NRPT exclude rules
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
Content-Type: multipart/mixed; boundary="===============7437901211857155414=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7437901211857155414==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t9/y+sQq234="; charset=UTF-8

--t9/y+sQq234=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2162?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: keep IPv6 name servers in NRPT exclude rules=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnser=
v: keep IPv6 name servers in NRPT exclude rules

GetNrptExcludeData() read =
the IPv6 name servers in after the IPv4 list,
but the IPv4 size includes th=
e terminating NUL=2E With both present, the
string ended at the IPv4 list a=
nd the IPv6 servers never made it into
GenericDNSServers=2E Join the lists =
by replacing that NUL with a
delimiter=2E

For the join to be safe, have bo=
th readers start from an empty string,
so a missing registry value cannot p=
ick up old buffer contents, and
return the length of the list without trail=
ing delimiters, instead of
the registry value size, which can include NUL p=
adding=2E

Broken since 0f3b7d17 ("win: implement --dns option support with=

NRPT")=2E

Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
Signed-off=
-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpnserv/interact=
ive=2Ec
1 file changed, 29 insertions(+), 4 deletions(-)



  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/62/2162/1

diff --git a=
/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 81=
205d6=2E=2E3af70f1 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/o=
penvpnserv/interactive=2Ec
@@ -2128,6 +2128,24 @@
 }
 
 /**
+ * Remove trai=
ling delimiters from a name server list
+ *
+ * @param  addrs      NUL-term=
inated list of addresses
+ *
+ * @return the size of the list in bytes, inc=
luding the terminating NUL
+ */
+static DWORD
+TrimNameServers(PSTR addrs)
=
+{
+    size_t len =3D strlen(addrs);
+    while (len && (addrs[len - 1] =
=3D=3D ',' || addrs[len - 1] =3D=3D ' '))
+    {
+        addrs[--len] =3D =
'\0';
+    }
+    return (DWORD)len + 1;
+}
+
+/**
  * Get DNS server IPv4 =
addresses of an interface
  *
  * @param  itf_key    registry key of the IP=
v4 interface data
@@ -2140,6 +2158,7 @@
 static LSTATUS
 GetItfDnsServersV4=
(HKEY itf_key, PSTR addrs, PDWORD size)
 {
+    addrs[0] =3D '\0';
     add=
rs[*size - 1] =3D '\0';
 
     LSTATUS err;
@@ -2165,7 +2184,7 @@
 
     if=
 (strchr(addrs, '=2E'))
     {
-        *size =3D s;
+        *size =3D Tri=
mNameServers(addrs);
         return NO_ERROR;
     }
 
@@ -2178,13 +2197,1=
5 @@
  *
  * @param  itf_key    registry key of the IPv6 interface data
  *=
 @param  addrs      pointer to the buffer addresses are returned in
- * @pa=
ram  size       pointer to the size of the buffer
+ * @param  size       po=
inter to the size of the buffer, contains the
+ *                    size o=
f the addresses on return
  *
  * @return LSTATUS NO_ERROR on success, a Wi=
ndows error code otherwise
  */
 static LSTATUS
 GetItfDnsServersV6(HKEY it=
f_key, PSTR addrs, PDWORD size)
 {
+    addrs[0] =3D '\0';
     addrs[*size=
 - 1] =3D '\0';
 
     LSTATUS err;
@@ -2231,12 +2252,11 @@
             po=
s +=3D addr_len;
             s -=3D (DWORD)addr_len;
         }
-        s=
 =3D (DWORD)strlen(addrs) + 1;
     }
 
     if (strchr(addrs, ':'))
     {=

-        *size =3D s;
+        *size =3D TrimNameServers(addrs);
         =
return NO_ERROR;
     }
 
@@ -2563,6 +2583,11 @@
                          =
     __func__, itf_guid, err);
                 goto next_itf;
            =
 }
+            if (v4_addrs_size && v6_addrs_size)
+            {
+       =
         /* Join the lists: replace the v4 terminating NUL with a delimiter=
 */
+                v6_addrs[-1] =3D ',';
+            }
         }
 
    =
     if (v4_addrs_size || v6_addrs_size)

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
Gerrit-Ch=
ange-Number: 2162
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--t9/y+sQq234=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">openvpnserv: keep IPv6 name servers in NRPT exclude rul=
es<br><br>GetNrptExcludeData() read the IPv6 name servers in after the IPv4=
 list,<br>but the IPv4 size includes the terminating NUL=2E With both prese=
nt, the<br>string ended at the IPv4 list and the IPv6 servers never made it=
 into<br>GenericDNSServers=2E Join the lists by replacing that NUL with a<b=
r>delimiter=2E<br><br>For the join to be safe, have both readers start from=
 an empty string,<br>so a missing registry value cannot pick up old buffer =
contents, and<br>return the length of the list without trailing delimiters,=
 instead of<br>the registry value size, which can include NUL padding=2E<br=
><br>Broken since 0f3b7d17 (&quot;win: implement --dns option support with<=
br>NRPT&quot;)=2E<br><br>Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e9=
72<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<b=
r>M src/openvpnserv/interactive=2Ec<br>1 file changed, 29 insertions(+), 4 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/62/2162/1</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnser=
v/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 8=
1205d6=2E=2E3af70f1 100644</span><br><span>--- a/src/openvpnserv/interactiv=
e=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span=
>@@ -2128,6 +2128,24 @@</span><br><span> }</span><br><span> </span><br><spa=
n> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Remove tra=
iling delimiters from a name server list</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param  addrs      NUL-terminated list of addresses</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @return the size of the list in bytes, including t=
he terminating NUL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static DWORD</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+TrimNameServers(PSTR add=
rs)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    size_t len =3D strlen(addrs);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (len &amp;=
&amp; (addrs[len - 1] =3D=3D &#39;,&#39; || addrs[len - 1] =3D=3D &#39; &#3=
9;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        addrs[--len] =3D &#39=
;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (DWORD)len + =
1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span>  * Get DNS server IPv4 addresses =
of an interface</span><br><span>  *</span><br><span>  * @param  itf_key    =
registry key of the IPv4 interface data</span><br><span>@@ -2140,6 +2158,7 =
@@</span><br><span> static LSTATUS</span><br><span> GetItfDnsServersV4(HKEY=
 itf_key, PSTR addrs, PDWORD size)</span><br><span> {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    addrs[0] =3D &#39;\0&#39;;</span><br>=
<span>     addrs[*size - 1] =3D &#39;\0&#39;;</span><br><span> </span><br><=
span>     LSTATUS err;</span><br><span>@@ -2165,7 +2184,7 @@</span><br><spa=
n> </span><br><span>     if (strchr(addrs, &#39;=2E&#39;))</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *size =
=3D s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *size=
 =3D TrimNameServers(addrs);</span><br><span>         return NO_ERROR;</spa=
n><br><span>     }</span><br><span> </span><br><span>@@ -2178,13 +2197,15 @=
@</span><br><span>  *</span><br><span>  * @param  itf_key    registry key o=
f the IPv6 interface data</span><br><span>  * @param  addrs      pointer to=
 the buffer addresses are returned in</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @param  size       pointer to the size of the buffer</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param  size       p=
ointer to the size of the buffer, contains the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *                    size of the addresses on r=
eturn</span><br><span>  *</span><br><span>  * @return LSTATUS NO_ERROR on s=
uccess, a Windows error code otherwise</span><br><span>  */</span><br><span=
> static LSTATUS</span><br><span> GetItfDnsServersV6(HKEY itf_key, PSTR add=
rs, PDWORD size)</span><br><span> {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    addrs[0] =3D &#39;\0&#39;;</span><br><span>     addrs[*=
size - 1] =3D &#39;\0&#39;;</span><br><span> </span><br><span>     LSTATUS =
err;</span><br><span>@@ -2231,12 +2252,11 @@</span><br><span>             p=
os +=3D addr_len;</span><br><span>             s -=3D (DWORD)addr_len;</spa=
n><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        s =3D (DWORD)strlen(addrs) + 1;</span><br><span>     }</span><br><=
span> </span><br><span>     if (strchr(addrs, &#39;:&#39;))</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *size =
=3D s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *size=
 =3D TrimNameServers(addrs);</span><br><span>         return NO_ERROR;</spa=
n><br><span>     }</span><br><span> </span><br><span>@@ -2563,6 +2583,11 @@=
</span><br><span>                               __func__, itf_guid, err);</=
span><br><span>                 goto next_itf;</span><br><span>            =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (v=
4_addrs_size &amp;&amp; v6_addrs_size)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                /* Join the lists: replace the v4 terminating =
NUL with a delimiter */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                v6_addrs[-1] =3D &#39;,&#39;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span>         }</spa=
n><br><span> </span><br><span>         if (v4_addrs_size || v6_addrs_size)<=
/span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2162?usp=3Demail">change 2162</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d33=
9bc9e972 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2162 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>

</body></html>
--t9/y+sQq234=--


--===============7437901211857155414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7437901211857155414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7437901211857155414==--

