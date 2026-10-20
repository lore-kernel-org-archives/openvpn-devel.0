Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC5B606A31D
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mI7ZIbVN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gzr0FN47;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Dco09wRr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KkrQmzuq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=jYacRm/kLD+5ZGw3WDhCCzUKYmz+AuvUf71UcvKHC/0=; b=mI7ZIbVNIkhT72
	uOTSSq184c1j7BvOaUljswjBuu9ctYYILiKeiv5T4nnJKuWads2Pp9ZI/cfRH+PCnb3bOziMhytsG
	uJFkwHZd5PoHb1/EIPRZ2MPJ2JpUm9OAAWdseDM5lvYzJjdkO9/XlpQyJJO/sVsPGhm/1xn5hlSbt
	GHc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJ9as-00060h-9x;
	Tue, 20 Oct 2026 13:09:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJ9aq-00060a-UE
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 13:09:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tWv0ZX7+DVjcYqfN5BxJjp2vKhBSHXa1IHWJk6R4f3I=; b=gzr0FN47rfLkg2I0hwhwWYMt1t
 FQO813wAP4nosgU50xz+V4xWx4mlEp1ah6VYE3Balww3W1KlkNBXtILSyhwfV8AsRDnzhZNPOlXk3
 /a+xJFa7Do2HZvmWaPGfBvkimK/5iN3NgHSHZZ3K3FhgmW25fKGK+lqaIAepO2cUmo5Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tWv0ZX7+DVjcYqfN5BxJjp2vKhBSHXa1IHWJk6R4f3I=; b=D
 co09wRrWO9Gj+lHgoHQ7QcTnbQd/4gi4se+Q0809VG+xtC9f3DFQ4aj3sngV4zYlnh3Lh9b9lmTyR
 82xGjB//RqXQ22CtX+PQ0gCEkZvvTXUg4tKj8o31etsKdmVpvngsO4SA06uI8lg7KvYXT4UqRRcwH
 mLDuN/x3o9wQ2FvI=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJ9am-0004g9-Uj for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 13:09:28 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so32829005e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 06:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792501758; x=1793106558; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tWv0ZX7+DVjcYqfN5BxJjp2vKhBSHXa1IHWJk6R4f3I=;
 b=KkrQmzuqojWMuEphHHnpgE+AO9PiUfvSOYaOxQcwRwdZlWh4Mf+mLqwTOQuKASy8b+
 uXIX3zL6su5amr5fp/Lvg43oowLqEXGaZ2VhAqkDtGyZugnZCH1gXDG8eLqLWIjcEVdm
 uOUJUJAq/sVqI42/+z3HYKHTqaF3wKZp5ilBdMocV/7tvlz+SKT3y+GaErQeVFimFOxB
 ZVTkPuqPHQI83oRsCbU1v0RnIg+1kpyQIh5yJpv/Nw+nCNKGEmkl8vGIstTvQOd4ADlZ
 6RFzntmg51AYjs58IK0dNj+s18vqbXaDtytcUOeKCOavHyVAjvAW0atA+J0iNAblqU3z
 ioWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792501758; x=1793106558;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tWv0ZX7+DVjcYqfN5BxJjp2vKhBSHXa1IHWJk6R4f3I=;
 b=CYizAPRMxDJAz8QiG/Ef1J9X5CM8aRLJHKf3iO9VRqhJQ1J4fsMxc/PZEiwqgSPmBX
 zJJ/Xl2IWRsAjOIFNDje9AtuImmjtp0ejP/s0S8nz5uMobIqgAomXjEb+Uu0PkYSbwGk
 iKA/57bFpMNNgf5wYtnuoSvVU8Bf90DsFlXKNr3RVqwxpYicqtGSxLkrbsfUMNLd8gWD
 svWSLO9xThvJdeh7XX6oBoa5iqhtwo+QGxI1QhCuMmNoQy8E8yfHCQGGF+wcyS7BbW6I
 DnMRfd0T9wmWvXBAcKRDsJgXF1DHvRSgl01SN4fM6rkp39Z7xm9bjs0HPVNk0dk8e4iw
 aQPg==
X-Gm-Message-State: AFq9FYJnK2F+xyOkgC2pDePhjtVKUl6TkL/JeRixkxbV49kSOJqPzl1Y
 dr135H2wIrf4wFVK18ghxz3p20jIH+4bjM0mtJei4ZNLoHCq2k003IeFKr1oGH8DEbKlBq1zhXI
 ISNvtNeko1iOLNE3/vxKUHchAFGuznujRbwiBVyBHyPramqvAD+f4tmMx+X6nZPCSRzIeEwF/Is
 3nb7CiEw==
X-Gm-Gg: AYBFou1fi/kPGDHuAn8x3W+DeFgi9YGiAypW/27+ePlyx9dpuDA4gXJjivniii+UJgB
 QGigzY25S0MWqWJ4D66ciih/udSh0PMXnf9j8tWoCE+WE5UrNrryht4nijSgvu8i4T+v+w+kBpc
 tnOxVze3HayjAfjDTw3lpzdmwRQfMItlzMgWl65TgD4+jGpiqMsWEXdITALD2/YzCbrcDo/Br3I
 fh1OElT/ADXhrPYtgU+7H+WSZFFzEHJiMfLuRQ2eC/zWJR1P9vPq6pSl1B0arcFMzZMEHyNzTsn
 aC0Y/RaIndvSDoDFUPRk41tmcPYcwYFQvAGpF4gazje+iFuC+lX1kMd1oAx+gkJbRD0/r8stJZJ
 NVfYDKXIkyVwoNEuGmXklTgHh2c/eZlJV2Dw3QPFbgMCsdQ7iCjrTUEdrPUz6TtLa+8wjuNDWg8
 Sg+Jd9FMac4grqV3Hz3UdFaY5lAk/0gTrmr3Zy7/7uR6c5M8pJHzmmWXhdKRalrQUJAKo/+yVW0
 iWqzOvblxqp1QOwowSaLED4HdjsQAqMo61qafn4LsjTtmAfP9T4mZ7IeJ+4Haq9afh3TUbUo80Z
 aN6VPfbDnLp/nGx4pfmQI+79Y96pD2UQxKGWO0vzRRZuNcpG+7VXP70ITrkq
X-Received: by 2002:a05:600c:3555:b0:4a1:d52e:c2d9 with SMTP id
 5b1f17b1804b1-4a1d762c1bdmr223050675e9.23.1792501758027; 
 Tue, 20 Oct 2026 06:09:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce33ad3fsm296496285e9.5.2026.10.20.06.09.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 06:09:16 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 20 Oct 2026 13:09:16 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib99618742929fd96562884d071f3bedc5ca309e4
X-Gerrit-Change-Number: 2025
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2025?usp=email>
X-Gerrit-Commit: 930c5b29609edfed0201c4164ef1dfb14403fb26
References: <gerrit.1792501753000.Ib99618742929fd96562884d071f3bedc5ca309e4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNTAxNzUzMDAwLkliOTk2MTg3NDI5MjlmZDk2NTYyODg0ZDA3MWYzYmVkYzVjYTMwOWU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5c317c271613a3fee15055bfa14887a5d8e3fae8-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJ9am-0004g9-Uj
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: test_pkt: Correct
 comment about which systems use ushort sin_family
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6289852102966695605=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6289852102966695605==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="76XXyflagzg="; charset=UTF-8

--76XXyflagzg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2025?usp=3Demail

to review the following change=2E
=


Change subject: test_pkt: Correct comment about which systems use ushort =
sin_family
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t=
est_pkt: Correct comment about which systems use ushort sin_family

I found=
 out due to an unrelated problem that the comment
is wrong=2E So let's fix =
it before it confuses the next
person=2E

Change-Id: Ib99618742929fd9656288=
4d071f3bedc5ca309e4
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>
---
M tests/unit_tests/openvpn/test_pkt=2Ec
1 file changed, 5 insertion=
s(+), 4 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/25/2025/1

diff --git a/tests/unit_tests/openvpn/test_pkt=
=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index 51c73d8=2E=2Efbbb40f 100=
644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/open=
vpn/test_pkt=2Ec
@@ -579,13 +579,14 @@
 
     struct session_id expected_se=
rver_id =3D { { 0xec, 0xa3, 0xd5, 0xcc, 0xb4, 0x7c, 0xa1, 0xee } };
     /*=
 We have to deal with different structs here annoyingly */
-    /* Linux ha=
s an unsigned short int as family_t and this is field is always
+    /* Som=
e systems have an unsigned short int as family_t and the field is always
  =
    * stored in host endianness even though the rest of the struct isn't=2E=
=2E=2E,
-     * so Linux little endian differs from all BSD and Linux big e=
ndian */
+     * This affects at least Linux, Windows, and OpenIndiana=2E
+=
     */
     if (sizeof(addr=2Eaddr=2Ein4=2Esin_family) =3D=3D sizeof(unsig=
ned short int) && ntohs(AF_INET) !=3D AF_INET)
     {
-        struct sessi=
on_id linuxle =3D { { 0x70, 0x04, 0x8c, 0x0f, 0xfe, 0x30, 0x85, 0x12 } };
-=
        expected_server_id =3D linuxle;
+        struct session_id short_le=
 =3D { { 0x70, 0x04, 0x8c, 0x0f, 0xfe, 0x30, 0x85, 0x12 } };
+        expec=
ted_server_id =3D short_le;
     }
     assert_memory_equal(expected_server=
_id=2Eid, server_id=2Eid, SID_SIZE);
 

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2025?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: Ib99618742929fd96562884d071f3bedc5ca309e4
Gerrit-Ch=
ange-Number: 2025
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--76XXyflagzg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2025?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">test_pkt: Correct comment about which systems use ushort s=
in_family<br><br>I found out due to an unrelated problem that the comment<b=
r>is wrong=2E So let&#39;s fix it before it confuses the next<br>person=2E<=
br><br>Change-Id: Ib99618742929fd96562884d071f3bedc5ca309e4<br>Signed-off-b=
y: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M tests/unit=
_tests/openvpn/test_pkt=2Ec<br>1 file changed, 5 insertions(+), 4 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/25/2025/1</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvp=
n/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>inde=
x 51c73d8=2E=2Efbbb40f 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec<=
/span><br><span>@@ -579,13 +579,14 @@</span><br><span> </span><br><span>   =
  struct session_id expected_server_id =3D { { 0xec, 0xa3, 0xd5, 0xcc, 0xb4=
, 0x7c, 0xa1, 0xee } };</span><br><span>     /* We have to deal with differ=
ent structs here annoyingly */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    /* Linux has an unsigned short int as family_t and this is fie=
ld is always</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Some systems have an unsigned short int as family_t and the field is always=
</span><br><span>      * stored in host endianness even though the rest of =
the struct isn&#39;t=2E=2E=2E,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-     * so Linux little endian differs from all BSD and Linux big e=
ndian */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * This=
 affects at least Linux, Windows, and OpenIndiana=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span>     if (sizeof(a=
ddr=2Eaddr=2Ein4=2Esin_family) =3D=3D sizeof(unsigned short int) &amp;&amp;=
 ntohs(AF_INET) !=3D AF_INET)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        struct session_id linuxle =3D { { 0=
x70, 0x04, 0x8c, 0x0f, 0xfe, 0x30, 0x85, 0x12 } };</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        expected_server_id =3D linuxle;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct session_id =
short_le =3D { { 0x70, 0x04, 0x8c, 0x0f, 0xfe, 0x30, 0x85, 0x12 } };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        expected_server_id=
 =3D short_le;</span><br><span>     }</span><br><span>     assert_memory_eq=
ual(expected_server_id=2Eid, server_id=2Eid, SID_SIZE);</span><br></pre><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2025?u=
sp=3Demail">change 2025</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2025?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: Ib99618742929fd96562884d071f3bedc5ca309e4 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2025 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--76XXyflagzg=--


--===============6289852102966695605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6289852102966695605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6289852102966695605==--

