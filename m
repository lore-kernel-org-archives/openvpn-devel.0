Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF624606A326
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LdghQ4oD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dh6xTqme;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bO1HE/lc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NW+hSIBT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Hbd32vXPhQ4UxuiKRUH0eZTOamhZ7GDgnHiExKMoj8E=; b=LdghQ4oDRGLqkelpl5AUJSHdsE
	zn0bKn89qP8bQViPsEwQpcAuWxYuvVw/BNEDe7rlFeupdJAizutqesn9nWB7EFdNh74k13lptfjDr
	FNkbxmcv5pRRxhVa/c4Vhh4xhDnAF2O5tIbEELv5Tuq1iHxEk5YH/rLQeznYRWMpmcmg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWIbz-000000006tW-2XK4;
	Wed, 25 Nov 2026 19:24:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWIbv-000000006tL-3uEf
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 19:24:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jOcFYNiCL+8Q67J8FvYACKq39sgcCNi7AYnsMPk3Ngs=; b=dh6xTqmeIG4YpNIVKwHrXXCyaQ
 nZJBXHnOSeFFwamGhzirzC6NmvVGEE9T+IKeZgB+LL4InAiQLhrjvRlveQhi7oOeb57RvqwG44qeA
 yyloxydaZX7I5n/mQcG1m8KPY/l4DA5wfBm2MlR7aHLQAlnEp881wrBb4r6VzwynJuNo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jOcFYNiCL+8Q67J8FvYACKq39sgcCNi7AYnsMPk3Ngs=; b=bO1HE/lcXoV2h28Yf5ry8Pv///
 54ZJH6mQhKDMPA6wsRmQNNMbP96tS8RPnVtZ2oVjooGD7C5Qv7DU5cGkO2SgFaJ3qgpdn1OEQ3wSe
 GT+vR2QCCOZIxAXhBSB2fRgr8MOWRQ13Q+BtEh+IcMPbUphxt6CIfvfuH4BNrQJJmM4g=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWIbu-000000008Ft-2byY for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 19:24:55 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so4064828f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 11:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795634688; x=1796239488; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jOcFYNiCL+8Q67J8FvYACKq39sgcCNi7AYnsMPk3Ngs=;
 b=NW+hSIBTZtDH73R1nnzSTvsbYZ8D7c/gb+wIXOUB/p+8rCnSSuPNh669JeYqBM/VBg
 00ZFeyvcwz3iiTS3tGswVsNMxaUODFktxobfGt1QUw1vTHycYhlcKIO88u1S7JzaDFi7
 YawqswQHDtUCiNrwXGJ+/4G1S8kS9EjPNvECXpwZvMSQxoj+torRfjCTjwiZd2RqC/8+
 N2O26DTilr56dJe2YEcXpb9RYMjCe5Rsrm/Qr8Qncnrqr4gPd5y1dpfEDim8uUSdH7cn
 UbrSR9G5aAmH8t9by6Iind5phgTiQ0kLMBBq+WD/X8L+Dpi8Px5Yh3NOm5oTSC10WiZx
 mteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795634688; x=1796239488;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jOcFYNiCL+8Q67J8FvYACKq39sgcCNi7AYnsMPk3Ngs=;
 b=vuhCR418Ag3rmR70+2GK4+RewinELg+1hPzOcARH6PzVTdV5RxPHr4g1NsK+3gcmWE
 HKWWVI0slTFLc/IUx/6lC0uMdaxLSU6gAQKRznMd81KvffZpkSmFPTzGNuNV3hzKwytY
 Ln2wqewDkmtWbhfwCleTCvk+plcyUNyh74cUExd+84MV/ilmE9ExfYyPA2tumFTgxFwG
 5MBykwMXE22ljuo27Pvn4orMnoF7s27Ycwt6op5jPcvQlnaxbB8P0dmPdSEZZI1EuSVq
 gZrntGjMprZNTtTqs9Cs1jg+/+XsPdQBfb8O649xtSrxm9PNehmfr4Oex8Q9q+a0yCx7
 K1lA==
X-Forwarded-Encrypted: i=1;
 AL+hErGPyNlxpSEiIUXMUBmYahCWDIqxYe75P5zYsFvkGxLTUC08ImENfq7YiKrPtgfPnbLKMIre0AMpVhAdF5cH@lists.sourceforge.net
X-Gm-Message-State: APuU4Z87JArFwBJ+Zox/Mj1CGwEmKcdbtk/sqwyM5y8zLQeLTWk//l0P
 yalOyP8t4LWlJRNhvxNlhN1NVWLl+8yX6IaUyY6uQMwJpXqD3g3VfV5pynZBjhaPxrh7dx45hY6
 I3TcKKMYLlnBTKvRkfeQpo5mXuRJA/RirWZM4xFFm7oJYKSBInykXKwf6cOSgla2R3jtjE33EwN
 2QTCS3sQ==
X-Gm-Gg: AZFdTZdflFns39LF8URLhDulijn0gx3eEzu9KSCw9WsRhE5vG1HxH8JrVZ+myxdMKd+
 3Io6//h6bsDjUeDPKY/thdnJI0mcAOpQyz11YyPE3tTYpPxHUI6/u7aChnsMQ5GyBXlsIXQxpOD
 a8vNr4pewlCWoMGbvrSF6dJsb4CmOHPKy/s+0flx+IGvESIwrXg5wHVML4ELalktyHNxR8H/HxC
 1lEzI2EKDl1J5yAPn70d5SAlUygwj+mNhFx70Gak4T5FKJRBe6Sl4+nH7onMY013PCMnjhxdIWp
 gMjqQ0pOQRkQZycySbtS+yPLjshXdZrhUl2+md1uKNgieTDB7W6znGgbg2L0cgVUlSRMT8H8tIj
 xxslmS9ybGtAOn8jaQzn3SIOsc5Dy8fOl3A2OGKBRdeO/6XUywuGTJ7YQaw1F1W05zme5QPimmP
 J6h0MXRnDc789khMbj4AqkgfVhcTou1I8tCUaSp8kD0zzbzf90kIgp9tIj343j1Em9gcEL7fpPg
 yfbiFJKnDVqSbLH+9ZGmSWihI4NUgx4+6xYE9mdW3AAtljfqoyl8d+uostBAZs8Yir3fuCXxSEQ
 n1tIhqE+uyJLT4Gx86pL516mtdptvQiycGx9dl2dkJzSDpRROl2ZqjoCzKhvZJ9n0tZefA7YOQ4
 +llW37enreK80kuvAAB7Bihua4GZYHHJEpOvcwY0OmsPtKlF3cONrhGvaecC0obTY74XiSddMK4
 pyqZTjstQNnh5i4Rrj
X-Received: by 2002:a5d:5f86:0:b0:4ac:f79a:28ab with SMTP id
 ffacd0b85a97d-4acf79a2aa2mr34494868f8f.8.1795634687889; 
 Wed, 25 Nov 2026 11:24:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110d56sm34955585f8f.40.2026.11.25.11.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:24:47 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 19:24:47 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7b13d8b5e0babb697191e21adf2998a090c310f4
X-Gerrit-Change-Number: 2335
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2335?usp=email>
X-Gerrit-Commit: 99ee0917a97c06d30e46900467e9cea83bfe7003
In-Reply-To: <gerrit.1795515967000.I7b13d8b5e0babb697191e21adf2998a090c310f4@gerrit.openvpn.net>
References: <gerrit.1795515967000.I7b13d8b5e0babb697191e21adf2998a090c310f4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE1OTY3MDAwLkk3YjEzZDhiNWUwYmFiYjY5NzE5MWUyMWFkZjI5OThhMDkwYzMxMGY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <31bfa6187cd2dcb102f557a43a4b7f60f0bacebf-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWIbu-000000008Ft-2byY
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_win: use CM_*
 case labels when switching on context mode
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1065595384428840677=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1065595384428840677==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3ndvs5Fgaqs="; charset=UTF-8

--3ndvs5Fgaqs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2335?usp=3Demail )

Change subject: dco_win: use CM_* case labe=
ls when switching on context mode
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

dco_win: use CM_* case labels when switching on cont=
ext mode

ovpn_dco_init() switched on c->mode, a CM_* value, but used MODE_=
*
case labels, which are options modes=2E This only worked because
CM_P2P/C=
M_TOP and MODE_POINT_TO_POINT/MODE_SERVER share values=2E

Change-Id: I7b13=
d8b5e0babb697191e21adf2998a090c310f4
Signed-off-by: Razvan Cojocaru <razvan=
c@mailbox=2Eorg>
Acked-by: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit URL:=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2335
Message-Id: <2026112518242=
6=2E29675-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/=
openvpn-devel@lists=2Esourceforge=2Enet/msg41962=2Ehtml
Signed-off-by: Gert=
 Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/dco_win=2Ec
1 file cha=
nged, 2 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/dco_win=
=2Ec b/src/openvpn/dco_win=2Ec
index a854045=2E=2E6074552 100644
--- a/src/=
openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -197,12 +197,12 @@
 
 =
    switch (c->mode)
     {
-        case MODE_POINT_TO_POINT:
+        cas=
e CM_P2P:
             dco->ifmode =3D DCO_MODE_P2P;
             dco_p2p_s=
tart_vpn(dco->tt);
             break;
 
-        case MODE_SERVER:
+      =
  case CM_TOP:
             ovpn_dco_init_mp(dco, c->options=2Edev_node);
 =
            break;
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2335?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I7b13d8b5e0babb697191e21adf2998a090c310f4
Gerrit-Change-Number: 2335
Gerri=
t-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: L=
ev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>

--3ndvs5Fgaqs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2335?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">dco_win: use CM_* case labels when=
 switching on context mode<br><br>ovpn_dco_init() switched on c-&gt;mode, a=
 CM_* value, but used MODE_*<br>case labels, which are options modes=2E Thi=
s only worked because<br>CM_P2P/CM_TOP and MODE_POINT_TO_POINT/MODE_SERVER =
share values=2E<br><br>Change-Id: I7b13d8b5e0babb697191e21adf2998a090c310f4=
<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-b=
y: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2335<br>Message-Id: &lt;20261125182426=2E29675=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg41962=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dco_win=2E=
c<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre>
<pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>i=
ndex a854045=2E=2E6074552 100644</span><br><span>--- a/src/openvpn/dco_win=
=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -197,=
12 +197,12 @@</span><br><span> </span><br><span>     switch (c-&gt;mode)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       case MODE_POINT_TO_POINT:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        case CM_P2P:</span><br><span>             dco-&gt;ifmo=
de =3D DCO_MODE_P2P;</span><br><span>             dco_p2p_start_vpn(dco-&gt=
;tt);</span><br><span>             break;</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        case MODE_SERVER:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        case CM_TOP:</span><br>=
<span>             ovpn_dco_init_mp(dco, c-&gt;options=2Edev_node);</span><=
br><span>             break;</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2335?usp=3Demail">change 2335</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2335?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7b13d8=
b5e0babb697191e21adf2998a090c310f4 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 2335 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &=
lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--3ndvs5Fgaqs=--


--===============1065595384428840677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1065595384428840677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1065595384428840677==--

