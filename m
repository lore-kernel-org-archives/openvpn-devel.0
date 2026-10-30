Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF9D606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mNoAYIZ/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gy946gCN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RkoVoWcf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dhRezgcb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QUkszoHYNCWtxflj+6ruhNfDirE8HtkN6IMcByNwatg=; b=mNoAYIZ/vbmpQ3xBLxUmWLs31G
	XkAfpp83v5BFd233IAe/r1Nt3LjgiZhKWlCtABnvYBfCzjSLF/JTV/ronv6n4JZvX1DIYOE9cukbm
	5EAysSL2daPx3W/CU5g/z/ZS11kCxV0UGNWsTmIIuyaOwe6tG1KDIxJJjzkeUgWiTtXg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMrZw-0000000072Z-0s9v;
	Fri, 30 Oct 2026 18:43:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMrZu-0000000072S-2ulS
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:43:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uXbZW8kNy38nKekAHnCehNMj2kpoTR4PCoGFdtblz4A=; b=gy946gCNhz9zNuuFFsGiTj4pTn
 zcJ2g2TADPr1/L5mupYkgSxCBPI0s5P4LU+hUeqA5LyQjoewRlv+VITtZie1tz/uwVjyZfS5RKCOX
 ++akNQ9+bFQE6qcfYxTZqpkdoF1mXDOrPH5gX8V4H1CPRBNO1BfRqNG+BSFoPodGIs5Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uXbZW8kNy38nKekAHnCehNMj2kpoTR4PCoGFdtblz4A=; b=RkoVoWcfAbSAGXCbJfkcE7DpH4
 uEorSya00dLant5eHvJ7mkYL39RludqJGKd2ELIkUpJIBf16aNf2E4XtpbqyoOR3BF6+5ZB6XrZZA
 yMc4om8qVh3K4mzkoGn1STQaGkDLoiHoi0zMqRNJrzMvVqrNGVgB8Ooh29tbM34Y/S94=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMrZt-000000001MN-10Pc for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:43:50 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a2084d62cdso9416565e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 11:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793385823; x=1793990623; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uXbZW8kNy38nKekAHnCehNMj2kpoTR4PCoGFdtblz4A=;
 b=dhRezgcbiUHuhw9oNnnGnUwJJsgKi9JKgGZso1q3cg9572jiSFnZajvX30eWd2yMef
 fOang7136NQrsGdJ2ZlHOU4VXpA3pPqpeRt3tlA2qkmFbNMWf9PESeWHGxrQ+dDopBp/
 22ZsYc+3xeKgwAZcYVEdFoiRTq4gmgiQovyvntszfKNAXH4rY5MU7JtUsiZAtUuQACjq
 CNBPANUJOBSLyJ/lzAwCXRlXh/YLu8XS+sck/k0q9pmMKdN9ABBV4saNbJyiAK3bDJlX
 YXYXUkkPyoQl2QsLECXY8tBP6mjsxb2sjGLzz5s4TsAfOQr7TlSc6yC0JqWQoPdofn/b
 khOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793385823; x=1793990623;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uXbZW8kNy38nKekAHnCehNMj2kpoTR4PCoGFdtblz4A=;
 b=0h5M3ZY5k3MSmgNAUho5LibdDulElwiFQ2H/58DPRrEZQVvVN1V8HWA7EyrAb37544
 tU/7MzhIDhzmGPdlJGWBCc1uh19+2t7DTGnI+zTkBIepU0HfdGoLda7dvPY0r/t/9v21
 MGqoi0K8WRi/wK+TrHcFRDAujxJk6VmKEkK3F6UwZsJgNH+I8tmchfh2Sc6MbPAN8b7f
 IqNV1J4OYzEfs52kDR27lavkUcwH4RLzMPmgULsDc5j/a6TIZXTGCAqc7Y4ZznQQM3n3
 2UuX8+himkyatpKGRnxPAD+RJPPfs0ptRzxiyUU6a5VAfGc3WR749zE/x+kj52RSeBDj
 PzXg==
X-Gm-Message-State: AFq9FYJaksizuCO93/ZowcQQe1mVtJhiFK1cYFgkyC36NLfXblaLRRHQ
 xEkm9fvkxQ62D54oSWYrpUswefnUTZj44t4obUtQD/+qV5/DbxfQGgO8CIJwyqxbu3cTmvfrr8y
 11P+Q3AyILgHYh89zXWGJRAzkFh/IZJnX9x1fWZOZshYvqm8V+vvIChvebBX5NBwm18A1
X-Gm-Gg: AYBFou1KqX//KF7RWT7DTfYBIwvICmiDfj1EqRQSCKrocpTnmSWEPL6DOUAeHDB3DCx
 /6Sr0l+UnOa+fyWYHxnWq64oalIH3VMJv3vbVTcI0bZB2UV+NAlIamr+DcgOFj4lcdIRNga7HgV
 dOhamkeC2K0GmZGtDTDHyobX5SkxUG1jZ4AEgx9ioBwvHK7ticU6wHYPu0VwIu1v8eGbeCgvdlA
 XolF8i4r/E48fNIvzENCFImrgGeRp+xVWLNCd7HB9+WsVN+txexmLbL8kVDIwcFrQbU2WNffyen
 0WPRoRKaoqVlkMbtHu568PsVu+Xzp01JJN+5sTmYZFfCM+gWCbqMcuQE//0RqybgvvxajDXJyi9
 Eg2L9TXEfOCrvo6B2XbCrsqYs+6QzwKNwshAPZrPg9Qm1qXv1wA/7vFi0dvRtMF/V4z3iUcSFsL
 h2yZXOQocPy6YVqm4u8vHSSqU7n2kbwHKCLzkDk2U9JIdGeKXJuJ5pGsErqZvgUbrKN8IxBOdSU
 5tt9VKU1DxEgP9zoYIQn7BVhIVp/SvMc8yiWaG36oUXUlLQN2VD0Kg+02QVkuMjA7TYXHvOFwxq
 TBeyYosHaUdbHLOWk5b/HyvqG3u5gG5eeDwHZkvFSvagkjs7oUGWwtby6a/jzpneH43V7IM+3h5
 xAEIRC/pLlKCbqmlI5FUkB/vdr+eK/lsv8dQxCXZ1+p64gokLcz/ueXa/4Mpe260O0NAD3p8XcU
 uPJ2/YEUKavr24wmU=
X-Received: by 2002:a05:600c:c48e:b0:4a3:2f35:38b4 with SMTP id
 5b1f17b1804b1-4ac16bc4829mr72038605e9.10.1793385822555; 
 Fri, 30 Oct 2026 11:43:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abebe33e79sm57866355e9.2.2026.10.30.11.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:43:42 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 18:43:40 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20
X-Gerrit-Change-Number: 2045
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2045?usp=email>
X-Gerrit-Commit: 486077fe500217ad7a3f5ecee4191f66580bbd0b
In-Reply-To: <gerrit.1793094393000.I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20@gerrit.openvpn.net>
References: <gerrit.1793094393000.I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkkyZjQ5ZjQwZTQ5YWY4NTAzZjVjMDhjNTU3NWZmYzlhOGI0YzlhYTIwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <585975109f5f5550d006aba09ebfa4210de10eaf-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMrZt-000000001MN-10Pc
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: walk the
 link sockets once in multi_io_wait()
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
 gianmarco@mandelbit.com, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4002461002107677075=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4002461002107677075==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tCbGHkEPfmM="; charset=UTF-8

--tCbGHkEPfmM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Gianmarco De Gregori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2045?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by R=C4=83zvan Cojocaru


Change subject: multi_io: walk th=
e link sockets once in multi_io_wait()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

multi_io: walk the link sockets once in multi_io_=
wait()

multi_io_wait() went over the link sockets twice: first to register=

every socket as a listening socket, then, if a UDP socket is configured,
a=
gain to arm the UDP ones=2E The UDP sockets were thus registered twice,
and=
 on Windows the first pass created an FD_ACCEPT event for them=2E

Walk the=
 sockets once, arming the UDP sockets and registering only the
TCP ones as =
listening sockets=2E Drop the mode check as well, since
multi_io_wait() onl=
y runs in server mode=2E

Change-Id: I2f49f40e49af8503f5c08c5575ffc9a8b4c9a=
a20
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Acked-b=
y: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2045
Message-Id: <20261027124501=2E682-1-gert@greeni=
e=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg40223=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/multi_io=2Ec
1 file changed, 7 insertions(+)=
, 17 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/45/2045/2

diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/=
multi_io=2Ec
index 56216d4=2E=2Efb4810b 100644
--- a/src/openvpn/multi_io=
=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -168,27 +168,17 @@
     int status;
=
     unsigned int *persistent =3D &m->multi_io->tun_rwflags;
 
-    if (!tu=
ntap_is_dco_win(m->top=2Ec1=2Etuntap))
+    for (int i =3D 0; i < m->top=2E=
c1=2Elink_sockets_num; i++)
     {
-        for (int i =3D 0; i < m->top=2E=
c1=2Elink_sockets_num; i++)
+        struct link_socket *sock =3D m->top=2E=
c2=2Elink_sockets[i];
+
+        if (proto_is_dgram(sock->info=2Eproto))
  =
       {
-            socket_set_listen_persistent(m->top=2Ec2=2Elink_socke=
ts[i], m->multi_io->es,
-                                         &m->top=
=2Ec2=2Elink_sockets[i]->ev_arg);
+            multi_io_process_flags(&m->t=
op, m->multi_io->es, sock, p2mp_iow_flags(m, sock));
         }
-    }
-
- =
   if (has_udp_in_local_list(&m->top=2Eoptions))
-    {
-        for (int i=
 =3D 0; i < m->top=2Ec1=2Elink_sockets_num; i++)
+        else if (!tuntap_=
is_dco_win(m->top=2Ec1=2Etuntap))
         {
-            struct link_socke=
t *sock =3D m->top=2Ec2=2Elink_sockets[i];
-
-            if ((m->top=2Eopt=
ions=2Emode =3D=3D MODE_SERVER) && proto_is_dgram(sock->info=2Eproto))
-   =
         {
-                unsigned int flags =3D p2mp_iow_flags(m, sock);=

-
-                multi_io_process_flags(&m->top, m->multi_io->es, sock, =
flags);
-            }
+            socket_set_listen_persistent(sock, m->m=
ulti_io->es, &sock->ev_arg);
         }
     }
 

-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2045?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I2f49f40e49af8503f5c08c5575ffc9a8b4c9aa20=

Gerrit-Change-Number: 2045
Gerrit-PatchSet: 2
Gerrit-Owner: Gianmarco De G=
regori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--tCbGHkEPfmM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Gian=
marco De Gregori=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2045?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">multi_io: walk the link sockets once in multi_io_wait()<br><br>multi_i=
o_wait() went over the link sockets twice: first to register<br>every socke=
t as a listening socket, then, if a UDP socket is configured,<br>again to a=
rm the UDP ones=2E The UDP sockets were thus registered twice,<br>and on Wi=
ndows the first pass created an FD_ACCEPT event for them=2E<br><br>Walk the=
 sockets once, arming the UDP sockets and registering only the<br>TCP ones =
as listening sockets=2E Drop the mode check as well, since<br>multi_io_wait=
() only runs in server mode=2E<br><br>Change-Id: I2f49f40e49af8503f5c08c557=
5ffc9a8b4c9aa20<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandel=
bit=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br=
>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2045<br>Message-Id:=
 &lt;20261027124501=2E682-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40223=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/multi_io=2Ec<br>1 file changed, 7 insertions(+), 17 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/45/2045/2</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi_io=
=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index 56216d4=2E=2Efb4810b =
100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b=
/src/openvpn/multi_io=2Ec</span><br><span>@@ -168,27 +168,17 @@</span><br><=
span>     int status;</span><br><span>     unsigned int *persistent =3D &am=
p;m-&gt;multi_io-&gt;tun_rwflags;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!tuntap_is_dco_win(m-&gt;top=2Ec1=
=2Etuntap))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for =
(int i =3D 0; i &lt; m-&gt;top=2Ec1=2Elink_sockets_num; i++)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (=
int i =3D 0; i &lt; m-&gt;top=2Ec1=2Elink_sockets_num; i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        struct link_socket *sock =
=3D m-&gt;top=2Ec2=2Elink_sockets[i];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (proto_is_dgram(sock-&gt;info=2Eproto))</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            socket_s=
et_listen_persistent(m-&gt;top=2Ec2=2Elink_sockets[i], m-&gt;multi_io-&gt;e=
s,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
                      &amp;m-&gt;top=2Ec2=2Elink_sockets[i]-&gt;ev_arg);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_io_p=
rocess_flags(&amp;m-&gt;top, m-&gt;multi_io-&gt;es, sock, p2mp_iow_flags(m,=
 sock));</span><br><span>         }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (has_udp_in_loca=
l_list(&amp;m-&gt;top=2Eoptions))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    for (int i =3D 0; i &lt; m-&gt;top=2Ec1=2Elink_sockets_num; i++)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (!tuntap_i=
s_dco_win(m-&gt;top=2Ec1=2Etuntap))</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            struct link_socket *so=
ck =3D m-&gt;top=2Ec2=2Elink_sockets[i];</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          if ((m-&gt;top=2Eoptions=2Emode =3D=3D MODE_SERVER) &amp;&amp; pr=
oto_is_dgram(sock-&gt;info=2Eproto))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                unsigned int flags =3D p2mp_iow_flags(m, sock);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                multi_io_process_flags(&amp;m-&=
gt;top, m-&gt;multi_io-&gt;es, sock, flags);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            socket_set_listen_persistent(sock, m-&gt;multi=
_io-&gt;es, &amp;sock-&gt;ev_arg);</span><br><span>         }</span><br><sp=
an>     }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2045?usp=3Demail">change 2045</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2045?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I2f49f40e49af8503f5c08=
c5575ffc9a8b4c9aa20 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2045 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--tCbGHkEPfmM=--


--===============4002461002107677075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4002461002107677075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4002461002107677075==--

