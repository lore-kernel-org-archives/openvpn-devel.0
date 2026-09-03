Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3D4C61DD3
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=0Yq8IN5SEC1lkvGCb+oQd4RWxKRR/W7+TtfModlanP0=; b=HGuHWlyfNwB8fk
	70OZXdmxe7VFGgNehymkzmQhQzkUDap2/sfYB9Cmijegou31P+/7kJPVOj5vA60Mh/ikhf+ayLm3N
	9R+sOa2RpfsWlroD7QGCXF8ry9AjZ9m6iZ1RgFZ20mERUn6Up1P062VD7xlFWPjP/R8XEcbZxUeAl
	vk4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x27A1-0007h5-U2;
	Thu, 03 Sep 2026 13:07:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x279l-0007fo-Gr
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 13:07:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V0ZvItRZkfKAVWoF4ykdwlFiM3rTsrc2HVXRTMvwt1I=; b=DK6qFwrUtMAhyu3Evuj86ZWEFC
 UpFHQRMFrrXLz2BBbQ5k+l5vhuYWSjKn/UPXucla9Ty2NY1yE1IDisfZtSN4Wn0jtwVSHrLS7ziW3
 AfXzn7ZTaOq6Glm6UO0IensJAFCNFAT9OuVKK21Aj7lf1FzwZQMwVDyDJf/BEZT6cgnc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=V0ZvItRZkfKAVWoF4ykdwlFiM3rTsrc2HVXRTMvwt1I=; b=F
 P6CG+NyjEsDP1H47cNR8+k0LodZRcZLAQalGIKSSjbAmHw/YTuE0cqewuCLHbTzrlNKDpqdc/a6lh
 8gs44kp/TRljsvmkkpPEDgIJkB2WDWDSp5gvL6bDlQsWmRmHdTOrLVhngFMRpWJIM3EN5thYy0s4L
 1DqxvD5h0qmJr/vc=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x279j-0003Q6-Nf for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 13:07:05 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48444ec4fe2so1307553f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 06:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788440817; x=1789045617; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=V0ZvItRZkfKAVWoF4ykdwlFiM3rTsrc2HVXRTMvwt1I=;
 b=X+jX6oL2xpEsFHh4Ctutmqspjwb/TC6C6JM4GhQ4YTuxG7ZygJg0L6VelSWH7S8Jq2
 7Jd/Oeq8RIn3pWmgUprxX7gHSnW0d7L4j2U+1nDW2ylsO0rzp1OMg0+cbvgLbV/AmPw9
 ei1Btrfru+XlTUNqPRBWxcOiWXOaMBYdgmbH/m56/wtBdxrCQ5IpWZQtsYATY/ZqBlpC
 1/QpYsjRn4lcYcyoySRDINdhEENFD2l7lf9YZDl3Y4ot20PmjgjbA7axEnAZNMjfc+KB
 3mSgWecqZPYJtHAe0dAhZ16A2kfvu553vgnoZHAl20z9oYPvxIdBKgkjS7QqnQHBQmfh
 6gEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788440817; x=1789045617;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V0ZvItRZkfKAVWoF4ykdwlFiM3rTsrc2HVXRTMvwt1I=;
 b=SxT7Dzz35br1zWjwQfwEomD3RFsTzjjIZo6ouiB+OCx/gTpU3238SVmciOAjk0IvgZ
 PDKGEm2CHkj5zBoL7Zs8Gum2vNDfB/rCTYWKRPVjs+R4zWyGkv28YxkhW4wmPXbbh6Yv
 7oY5F7cqc0dmFiuOp0pf+ualOzO/ZGm1y08E6F4puXPU2Oci6MuwVDFtYuvCTPBusDYX
 rpkpOatJolYZg6i9s/csZ61IIEuMB1w0TKYaYhnK63zIiMKvDTOeZb71cRm9b8OIYhG3
 z00tCuG3loD1giGIZ2of779eGnC0COG3U38o2cvBNo0TMkvGCTsR9289twYCapxn8xK/
 Xx0A==
X-Gm-Message-State: AFuF++ncqKsje5SjiChO09ZxJi79gfj0IC3yEVG4BC4mHbqF6wDOKX4c
 6PGtKYjjqAzo36W4dr/5hs+Daazp4tdLQV4CLcizurvowGLMvwiauuuyBZO7Ux6rpbMpbENVzrO
 o7GchUVeDCY6bUhOIfbcjBJnFLV/cNJXmMiViLHhFR1+htwwbrZVygXVxM7cY9onWgKD8y2SyPD
 B1QN34KA==
X-Gm-Gg: AYBFou21Fq82frMzxt2lptpPNNq1IiRY3PojIhv5eIrXPScFApYrkObF4S90HrGpX0t
 bkqKUpuPuhHyJA8jByfkbl5e8DUtj849DmVTkVjL4xzlq8o+TbWWjlXtBPUUGB3GMAAExIecvit
 N1QM8ahgpbVacVtPQyMS6ZmYq2fQdQ7EPr8FrR/GoFNcgVSWWTdKK8qTJCtDkJnx7R3au1oSNOc
 umBLAWvFiI93E3b/ZBzzBjlZJuCgqqBL50aKfsBkI7nO6Dvjwj+MC4XV7Bnvlo3U9KjZ4+niW8P
 fNYxM28Fj9SJmRdEcJJz6K54H45alSq2AQLm4jY5Kmfp7Pdj7PTkDmEeN1akiZTtooIfc4Y0gYa
 +Yk+i0YdXYDkR3DWraVZH0pfefxdyGjmt/CHqH/nK7N+Q/V0abyrgr1m+U5XrJY0e1ZJwnbErXZ
 bvjADfCvpLlp/tSVgwgDyOtff7ca5hWPypAn81mFbJuQrWkpxtFbDCEmiTBc6pZnmpNyPmFlq0Q
 HgKbG+aliDs9MPjf6j0BTnmaobEm35fJmvT3/lskEepaVwV3sVo87dcLpkAvmd5eXVhH2ecM4Gl
 oNZJr253Y2rcV6XFQrWV6PRu9giqLFpK/Yr/F2ei12qPT/h1dWg=
X-Received: by 2002:a5d:68d2:0:b0:483:8040:449a with SMTP id
 ffacd0b85a97d-48488f07aa9mr19712030f8f.12.1788440816859; 
 Thu, 03 Sep 2026 06:06:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-484492cf550sm13872524f8f.37.2026.09.03.06.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:06:56 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 3 Sep 2026 13:06:55 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1cd2fcb363b6ee95f25c5cba72f74f85e43ab66d
X-Gerrit-Change-Number: 1896
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1896?usp=email>
X-Gerrit-Commit: 3e597f69e1f1583a086fe787c591924f58020ecf
References: <gerrit.1788440813000.I1cd2fcb363b6ee95f25c5cba72f74f85e43ab66d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDQwODEzMDAwLkkxY2QyZmNiMzYzYjZlZTk1ZjI1YzVjYmE3MmY3NGY4NWU0M2FiNjZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <74513cc3eb747ea9729f42efce9890218858bd08-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x279j-0003Q6-Nf
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_linux: set
 ifindex also when adopting a pre-existing interface
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1887982059032315545=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1887982059032315545==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MdqOl4KbmDE="; charset=UTF-8

--MdqOl4KbmDE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1896?usp=3Demail

to review the following change=2E


Chang=
e subject: dco_linux: set ifindex also when adopting a pre-existing interfa=
ce
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_linux:=
 set ifindex also when adopting a pre-existing interface

When the DCO inte=
rface is created by the user before the daemon is
started, net_iface_new() =
gets -EEXIST back from the kernel=2E
At this point open_tun_dco() returns r=
ight away and never reaches
the assignment of tt->dco=2Eifindex=2E

Missing=
 the ifindex assignment makes all subsequent netlink call fail,
as they req=
uire a proper ifindex to identify the target device (ENODEV)=2E

The breaka=
ge is easy to miss, because the error is reported at D_DCO,
which is not pr=
inted at the default verb, while the reassuring "re-using
existing device" =
message is=2E

Resolve the ifindex for the -EEXIST case too and pass -EEXIS=
T on to the
caller, which already knows how to deal with it=2E This also br=
ings the
Linux implementation in line with the FreeBSD one, which has alway=
s
completed the interface setup on -EEXIST as well=2E

The dynamic device n=
ame path is not affected: it accepts a return value
of 0 only and keeps sca=
nning the next name on -EEXIST=2E

Change-Id: I1cd2fcb363b6ee95f25c5cba72f7=
4f85e43ab66d
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---=

M src/openvpn/dco=2Eh
M src/openvpn/dco_linux=2Ec
2 files changed, 7 inser=
tions(+), 3 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/96/1896/1

diff --git a/src/openvpn/dco=2Eh b/src/openv=
pn/dco=2Eh
index 4e5aad5=2E=2E1898bcf 100644
--- a/src/openvpn/dco=2Eh
+++ =
b/src/openvpn/dco=2Eh
@@ -114,7 +114,8 @@
  * @param tt        the tuntap c=
ontext
  * @param ctx       the networking API context
  * @param dev      =
 the name of the interface to create
- * @return          0 on success or a=
 negative error code otherwise
+ * @return          0 on success, -EEXIST i=
f the interface already existed
+ *                  and was adopted, or an=
other negative error code on failure
  */
 int open_tun_dco(struct tuntap *=
tt, openvpn_net_ctx_t *ctx, const char *dev);
 
diff --git a/src/openvpn/dc=
o_linux=2Ec b/src/openvpn/dco_linux=2Ec
index 56f6259=2E=2E40b4781 100644
-=
-- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -509,7 +5=
09,10 @@
     ASSERT(tt->type =3D=3D DEV_TYPE_TUN);
 
     int ret =3D net_=
iface_new(ctx, dev, OVPN_FAMILY_NAME, &tt->dco);
-    if (ret < 0)
+    /* =
don't bail out on -EEXIST, as we need to resolve the ifindex also
+     * i=
n this case (the interface was pre-created and we may want to use it)
+    =
 */
+    if (ret < 0 && ret !=3D -EEXIST)
     {
         msg(D_DCO_DEBUG, =
"Cannot create DCO interface %s: %d", dev, ret);
         return ret;
@@ -5=
21,7 +524,7 @@
         msg(M_FATAL, "DCO: cannot retrieve ifindex for inte=
rface %s", dev);
     }
 
-    return 0;
+    return ret;
 }
 
 void

-- 
T=
o view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1896?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1cd2fcb363b6ee95f25c5cba=
72f74f85e43ab66d
Gerrit-Change-Number: 1896
Gerrit-PatchSet: 1
Gerrit-Owner=
: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--MdqOl4KbmDE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1896?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">dc=
o_linux: set ifindex also when adopting a pre-existing interface<br><br>Whe=
n the DCO interface is created by the user before the daemon is<br>started,=
 net_iface_new() gets -EEXIST back from the kernel=2E<br>At this point open=
_tun_dco() returns right away and never reaches<br>the assignment of tt-&gt=
;dco=2Eifindex=2E<br><br>Missing the ifindex assignment makes all subsequen=
t netlink call fail,<br>as they require a proper ifindex to identify the ta=
rget device (ENODEV)=2E<br><br>The breakage is easy to miss, because the er=
ror is reported at D_DCO,<br>which is not printed at the default verb, whil=
e the reassuring &quot;re-using<br>existing device&quot; message is=2E<br><=
br>Resolve the ifindex for the -EEXIST case too and pass -EEXIST on to the<=
br>caller, which already knows how to deal with it=2E This also brings the<=
br>Linux implementation in line with the FreeBSD one, which has always<br>c=
ompleted the interface setup on -EEXIST as well=2E<br><br>The dynamic devic=
e name path is not affected: it accepts a return value<br>of 0 only and kee=
ps scanning the next name on -EEXIST=2E<br><br>Change-Id: I1cd2fcb363b6ee95=
f25c5cba72f74f85e43ab66d<br>Signed-off-by: Antonio Quartulli &lt;antonio@ma=
ndelbit=2Ecom&gt;<br>---<br>M src/openvpn/dco=2Eh<br>M src/openvpn/dco_linu=
x=2Ec<br>2 files changed, 7 insertions(+), 3 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
96/1896/1</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh</s=
pan><br><span>index 4e5aad5=2E=2E1898bcf 100644</span><br><span>--- a/src/o=
penvpn/dco=2Eh</span><br><span>+++ b/src/openvpn/dco=2Eh</span><br><span>@@=
 -114,7 +114,8 @@</span><br><span>  * @param tt        the tuntap context</=
span><br><span>  * @param ctx       the networking API context</span><br><s=
pan>  * @param dev       the name of the interface to create</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * @return          0 on success or =
a negative error code otherwise</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @return          0 on success, -EEXIST if the interface alre=
ady existed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
            and was adopted, or another negative error code on failure</spa=
n><br><span>  */</span><br><span> int open_tun_dco(struct tuntap *tt, openv=
pn_net_ctx_t *ctx, const char *dev);</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><s=
pan>index 56f6259=2E=2E40b4781 100644</span><br><span>--- a/src/openvpn/dco=
_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br><span>=
@@ -509,7 +509,10 @@</span><br><span>     ASSERT(tt-&gt;type =3D=3D DEV_TYP=
E_TUN);</span><br><span> </span><br><span>     int ret =3D net_iface_new(ct=
x, dev, OVPN_FAMILY_NAME, &amp;tt-&gt;dco);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (ret &lt; 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* don&#39;t bail out on -EEXIST, as we need to r=
esolve the ifindex also</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * in this case (the interface was pre-created and we may want to u=
se it)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret &lt; 0 &amp;&=
amp; ret !=3D -EEXIST)</span><br><span>     {</span><br><span>         msg(=
D_DCO_DEBUG, &quot;Cannot create DCO interface %s: %d&quot;, dev, ret);</sp=
an><br><span>         return ret;</span><br><span>@@ -521,7 +524,7 @@</span=
><br><span>         msg(M_FATAL, &quot;DCO: cannot retrieve ifindex for int=
erface %s&quot;, dev);</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span> }</spa=
n><br><span> </span><br><span> void</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1896?usp=
=3Demail">change 1896</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1896?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I1cd2fcb363b6ee95f25c5cba72f74f85e43ab66d </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1896 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--MdqOl4KbmDE=--


--===============1887982059032315545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1887982059032315545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1887982059032315545==--

