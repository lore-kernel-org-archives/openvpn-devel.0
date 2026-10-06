Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8C4CA5FED
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 11:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=OsNGshGG9o/ojRPbU0z+YQUrr6lY4zGTGN6XZ0J2tzU=; b=KZUd1dH2SJ+Y5T
	hqFGR0NQFBVCOtfWKdtZ074flqLBYhf8dq7/HzJtbDTvn7CPilAI1zJhvJT7ZVxh8K4rErQez184r
	93lEPtLCZHrLVoyCmYx+Fh++w0kuyHryBVFMk+rSvfSpLC8FxCte9LpDkREeGyv8WOYoE+OmZNGA5
	gxE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xE3RK-0006Wy-Ii;
	Tue, 06 Oct 2026 11:34:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xE3RI-0006Wh-KP
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 11:34:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RdxSp68CfbOs/C3p7ewV22aoFRIpqfe7GcqQELZCgqU=; b=l+H2PT7e+NMnI5W5HMuYq06gss
 HF70oDxJ83OhP/WjsIfA6QjCdH9NCkuq8CtbBFdNYx3OEFY7zNMdzbJ6rM9Pj/sgLRMPsP0R2H3kW
 d4rViYvKw9u0MyKfPyZKq3KYGqCyiePMWzy9nKUkbPyBu66qFbPNEw+YZYdwV5n7VSMI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RdxSp68CfbOs/C3p7ewV22aoFRIpqfe7GcqQELZCgqU=; b=H
 1NnwpqdIedldH/287KsKBnSc83uCQ0h5Z7Xa/Y47Jm3QfT9DdmaM9WVIwKuGVevyMr61LGOEwQIpq
 EQE/GduWZwypGJrmlEKc8tIalkIRwdSz9jbfuqLgDWL0zdT7Unbns9Ierr+P8t24tducBbobJTBK8
 mTbVI9aZA83lOFaM=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xE3RB-0003oN-D2 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 11:34:33 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a17b4c6133so5177315e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 06 Oct 2026 04:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791286459; x=1791891259; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RdxSp68CfbOs/C3p7ewV22aoFRIpqfe7GcqQELZCgqU=;
 b=UYZjix+9VR7nAYve/4yt5f39k67Q7Oc5l4D2ZxIwrEdh3kX3ZeG855E5v8v5jiFevy
 NcZvVzPQYfXW3Qs1c7gLsxV8jdw45wV+qDbzXDsGxAbAItFYjmczh0TKO6v97VwdCbJe
 B95F8soIyg9tj8DiNDuJ+EwoNSJ7Xthkq0aI+dp13K/PPk0sXduXhtBZVgJQ1hLD8+70
 hl5NYarxCGwKfqb6SuywcHNg+Xav4+GBRfeSJGK99+MZGaxPCWzlyABaaZyW0emgvEYM
 tIFdhcDiOlM2crERjWqPGsbUYavAKPdfFNpIRsFGnu9iAvLtdR+0CYHcrGgux0FdUW86
 tN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791286459; x=1791891259;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RdxSp68CfbOs/C3p7ewV22aoFRIpqfe7GcqQELZCgqU=;
 b=MpnNWp1kZw2jx5ZvpbCwK/OMsGq3wj1WJfc4hoFCLP8y10zSv+6pz8tQVQJrDj+zzo
 iEfCSIaMov9sZkqKSYe57DXwrefWSZp0zyuRLgwf4fp0szhtNOYpNHaw+bPBjdJUKXnP
 UT7D1kBF+o1s+4VEe6eMMw3hEpvXobH0Rhubg9QHcLmliTkhEK6Z6RPgZ2bWalVdBDgP
 WTRu2aY0Guty2Xc2aPMsSX4crOGjic+n8MCFMp7F96WiIUJDAI47S2YVImkhR3HXJNq+
 WEfBDTIT0rmGLBsbUkyrLTd5K6HFVs1R5dW+FC/M9TkGEBEwSSbUjltALCBGobXTvMiz
 XhGQ==
X-Gm-Message-State: AFuF++lnicgERfv2hoXdiwt7cZb77OBLXLOJK0RnyidB8Ko7qg+ynzkA
 VjK71xk1RFrv69dGhAHyS0AyNmQBgu9HKf6tfqsqD5Aphxq11ougNTC2pXWymrRMULOjh3Tha6T
 DzXl87wgJdBMfzRZiECxCz9ZEdg+avFSAmiZmvWmhpGrvbCbDIywifej/NvBm966ufG4Gr0u1ws
 rqWfhVjg==
X-Gm-Gg: AYBFou2y8L6z2mPUq7Bln4ToewdFItGOs2YYg9EC4icAyWk/D+or3kdv6uBXxDmCwcq
 T4lNv2dU19P1za63LyruKoLGTdlw6ykkSF9R9wc7lJG6ALHcsUF5jrVacyi8kemQ/psdMYMi1Wb
 wl3A0OhZJOFeKrYQ8SMigHhOVOx9EZOoOT4xHqvBtk99sd4giajf8V3ztiQN5q1BQq0p6Thx1t5
 7nP04uFZ31kZTeG9Vp8VPOxUsqMGecOEq3piFiaDsLV4BCbkmvaXrB9smqana0oFMWj1sdpZfNT
 An8l4QlFYnJUedV5ren2RxX7svtUp2VKJtmBr1gTvNdFUHN7c6EX7UwBxlvIAoIE5igbqN7WGrK
 SJ3R/h8TC7TXT740kppCwWrK6AKKqK1E7H6oo+bj6u5A3jykni6Jxh7QU1/8CshbppW6+8F3xpU
 B3okZ5x70QMawqi/nOiDJNdIfXm6/4uWiAeFMzgRdwBC1NlA/j1neSuva7d5TGBF4IpHUrHlpoc
 OI0pUAVvj230fj8/broIbs5927MY0wub2mGyy+Zcx9Ybw9+9Lk0qmCBiT5OSWtpmyzw6x2rz4Vr
 4mnnSMzOkOxY69AkxDOO+DbL14DHFNOJrBzcd5QbJ7m3mfGJkn8oFNbxcZwO
X-Received: by 2002:a05:600c:4fc2:b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4a17b4f4d36mr19253635e9.4.1791286458212; 
 Tue, 06 Oct 2026 04:34:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c33091sm67451175e9.4.2026.10.06.04.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 04:34:17 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 11:34:17 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6
X-Gerrit-Change-Number: 1981
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1981?usp=email>
X-Gerrit-Commit: 94a7f519348c3d96cee72ac53f5d80f1f5f96e9e
References: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg2NDUyMDAwLkkwMDUxZWZmZTdmMDYzNmUzMDU1N2Q5Y2U5MmM1MGM0NTgwMDJmOWU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c1a0969699c431b1f052f2a1388d8ad2aa5e48f8-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xE3RB-0003oN-D2
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco: detect local
 kernel capabilities through netlink policies
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
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1839594364505309834=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1839594364505309834==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/qqjXR15QNo="; charset=UTF-8

--/qqjXR15QNo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1981?usp=3Demail

to review the following change=2E
=


Change subject: dco: detect local kernel capabilities through netlink pol=
icies
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: de=
tect local kernel capabilities through netlink policies

The ovpn module li=
ves in the kernel, so the attributes it accepts may
differ from what we wer=
e built against=2E CTRL_CMD_GETPOLICY dumps the
validation policy of a fami=
ly: which attributes each command takes, of
what type, and for a nested one=
 the sub-policy that validates it=2E

Add a helper to query it, wrapped in =
dco_probe_capabilities() so the
rest of the tree never talks to netlink its=
elf=2E Answering a requirement
means following a chain - which policy valid=
ates the command, where its
nested attribute points if it has one, what typ=
e the target attribute
has there - and CTRL_ATTR_OP narrows the dump enough=
 to collect all
three in one pass=2E

The answer has three values rather th=
an two: without "could not ask", a
netlink error would look the same as an =
old kernel=2E

No capability is defined yet, so the bitmap comes back empty=
; the rows
that fill it arrive with the features that need them=2E The unit=
 test
drives the pass and the decision separately, on dumps built by hand=
=2E

Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6
Signed-off-by: Gi=
anmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M configure=2Eac
M src/o=
penvpn/dco=2Eh
M src/openvpn/dco_freebsd=2Ec
M src/openvpn/dco_linux=2Ec
M =
src/openvpn/dco_win=2Ec
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/un=
it_tests/openvpn/mock_dco_dependencies=2Ec
A tests/unit_tests/openvpn/test_=
dco=2Ec
8 files changed, 862 insertions(+), 0 deletions(-)



  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/1981/1

diff --git=
 a/configure=2Eac b/configure=2Eac
index 56109af=2E=2E0758ad9 100644
--- a/=
configure=2Eac
+++ b/configure=2Eac
@@ -1313,6 +1313,7 @@
 AC_SUBST([PLUGIN=
_AUTH_PAM_LIBS])
 
 AM_CONDITIONAL([WIN32], [test "${WIN32}" =3D "yes"])
+A=
M_CONDITIONAL([DCO_UNIT_TESTS], [test "${enable_dco}" !=3D "no"])
 AM_CONDI=
TIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" =3D "yes"])
 AM_CONDITIONAL(=
[ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pam}" =3D "yes"])
 AM=
_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_root}" =
=3D "yes"])
diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index 7e=
f75fee=2E=2Ed074257 100644
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=
=2Eh
@@ -254,6 +254,17 @@
  */
 bool
 dco_supports_epoch_data(struct contex=
t *c);
+
+/**
+ * Return a bitmap of DCO_CAP_* bits describing the negotiab=
le features the
+ * local kernel supports=2E Everything DCO does without ne=
gotiating is available
+ * regardless=2E Resolved once and reused; platform=
s without capability probing
+ * return 0=2E
+ *
+ * @return  bitmask of DC=
O_CAP_* flags; 0 both when the kernel negotiates none
+ *          of them =
and when it could not be asked
+ */
+unsigned int dco_probe_capabilities(vo=
id);
 #else  /* if defined(ENABLE_DCO) */
 
 typedef void *dco_context_t;
@=
@ -388,5 +399,11 @@
 {
     return false;
 }
+
+static inline unsigned int
=
+dco_probe_capabilities(void)
+{
+    return 0;
+}
 #endif /* defined(ENABL=
E_DCO) */
 #endif /* ifndef DCO_H */
diff --git a/src/openvpn/dco_freebsd=
=2Ec b/src/openvpn/dco_freebsd=2Ec
index 87eea55=2E=2E9ace240 100644
--- a/=
src/openvpn/dco_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -702,6 +70=
2,12 @@
     return 0;
 }
 
+unsigned int
+dco_probe_capabilities(void)
+{
=
+    return 0;
+}
+
 bool
 dco_available(msglvl_t msglevel)
 {
diff --git a=
/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index a397fb8=2E=2Ee=
abb3ea 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=
=2Ec
@@ -103,6 +103,308 @@
     return ret;
 }
 
+/*
+ * Netlink policy int=
rospection: the ovpn module lives in the kernel, so the
+ * attributes it a=
ccepts may differ from what we were built against=2E
+ * CTRL_CMD_GETPOLICY=
 says which attributes a command takes and of what type,
+ * and CTRL_ATTR_=
OP narrows the dump to a single command=2E
+ */
+
+/* one row per capabilit=
y; a row on a command of its own costs one more dump */
+struct dco_capabil=
ity_req
+{
+    unsigned int cap;
+    uint16_t cmd;
+    uint16_t nested_a=
ttr; /* 0 if target_attr is not nested */
+    uint16_t target_attr;
+    i=
nt expected_type;
+};
+
+/** the outcome of resolving one capability requir=
ement */
+enum ovpn_cap_status
+{
+    OVPN_CAP_UNKNOWN,     /**< the quest=
ion could not be asked */
+    OVPN_CAP_SUPPORTED,   /**< the kernel accept=
s the attribute */
+    OVPN_CAP_UNSUPPORTED, /**< the kernel answered, and=
 does not accept it */
+};
+
+struct ovpn_cap_query
+{
+    const struct dc=
o_capability_req *req;
+
+    int cmd_policy; /* policy validating the doit=
 of req->cmd, -1 until seen */
+    int sub_policy; /* where nested_attr po=
ints, -1 until seen */
+    int type;       /* type of target_attr in the s=
ub-policy, -1 until seen */
+
+    /* policies walked past before their rol=
e was known */
+    int unclassified;
+};
+
+/* What the local kernel suppo=
rts=2E It cannot change while we run, so the first
+ * caller resolves it a=
nd the rest just read it=2E */
+static unsigned int dco_caps =3D 0;
+static=
 bool dco_caps_resolved =3D false;
+
+/*
+ * The command map arrives before=
 any policy and a nested policy after the one
+ * nesting it, so one pass s=
uffices=2E That order is not promised, so policies
+ * walked past unclassi=
fied are counted: an incomplete chain then means we could
+ * not tell, not=
 that the attribute is missing=2E
+ */
+static int
+ovpn_cap_query_cb(struc=
t nl_msg *msg, void *arg)
+{
+    struct ovpn_cap_query *query =3D arg;
+  =
  struct nlattr *tb[CTRL_ATTR_MAX + 1];
+    const struct genlmsghdr *ghdr =
=3D nlmsg_data(nlmsg_hdr(msg));
+
+    /* one message of the dump: it carri=
es either the command map or a slice of
+     * one policy, and fills in wh=
ichever link of the chain it happens to hold */
+
+    if (nla_parse(tb, CT=
RL_ATTR_MAX, genlmsg_attrdata(ghdr, 0), genlmsg_attrlen(ghdr, 0), NULL))
+ =
   {
+        return NL_SKIP;
+    }
+
+    /* CTRL_ATTR_OP_POLICY: which p=
olicy validates the doit of each command */
+    if (tb[CTRL_ATTR_OP_POLICY=
])
+    {
+        const struct nlattr *nla_cmd;
+        int rem_cmd;
+
+ =
       nla_for_each_nested(nla_cmd, tb[CTRL_ATTR_OP_POLICY], rem_cmd)
+    =
    {
+            struct nlattr *tb_cmd[CTRL_ATTR_POLICY_DUMP_MAX + 1];
+
=
+            /* the dump is filtered, but do not rely on that */
+         =
   if (nla_type(nla_cmd) !=3D query->req->cmd)
+            {
+            =
    continue;
+            }
+
+            if (nla_parse(tb_cmd, CTRL_ATTR=
_POLICY_DUMP_MAX, nla_data(nla_cmd), nla_len(nla_cmd),
+                   =
       NULL))
+            {
+                continue;
+            }
+
+ =
           if (tb_cmd[CTRL_ATTR_POLICY_DO])
+            {
+               =
 query->cmd_policy =3D (int)nla_get_u32(tb_cmd[CTRL_ATTR_POLICY_DO]);
+
+  =
              /* a requirement with no container looks for its target in th=
e
+                 * command's own policy, so the search ends where it sta=
rts */
+                if (!query->req->nested_attr)
+                {
+ =
                   query->sub_policy =3D query->cmd_policy;
+              =
  }
+            }
+        }
+    }
+
+    /* CTRL_ATTR_POLICY: which attr=
ibutes each policy accepts */
+    if (!tb[CTRL_ATTR_POLICY])
+    {
+     =
   return NL_OK;
+    }
+
+    const struct nlattr *nla_policy;
+    int re=
m_policy;
+
+    nla_for_each_nested(nla_policy, tb[CTRL_ATTR_POLICY], rem_=
policy)
+    {
+        struct nlattr *nla_attr;
+        int rem_attr;
+  =
      int policy_id =3D nla_type(nla_policy);
+
+        /* only the two po=
licies of the chain can hold anything we need=2E One we
+         * cannot =
place yet is counted, because skipping it may be why the
+         * chain =
ends up incomplete */
+        if (policy_id !=3D query->cmd_policy && poli=
cy_id !=3D query->sub_policy)
+        {
+            if (query->sub_policy=
 < 0)
+            {
+                query->unclassified++;
+            }=

+            continue;
+        }
+
+        nla_for_each_nested(nla_attr,=
 nla_policy, rem_attr)
+        {
+            struct nlattr *tb_attr[NL_PO=
LICY_TYPE_ATTR_MAX + 1];
+            int attr_id =3D nla_type(nla_attr);
+=

+            if (attr_id !=3D query->req->nested_attr && attr_id !=3D quer=
y->req->target_attr)
+            {
+                continue;
+           =
 }
+
+            if (nla_parse_nested(tb_attr, NL_POLICY_TYPE_ATTR_MAX, nl=
a_attr, NULL))
+            {
+                continue;
+            }
+
+=
            /* An attribute id only means something inside its own policy, =
so
+             * each link is read where it belongs=2E First link: the ne=
sted
+             * attribute of the command's policy names the sub-policy=
=2E */
+            if (policy_id =3D=3D query->cmd_policy && attr_id =3D=
=3D query->req->nested_attr
+                && tb_attr[NL_POLICY_TYPE_ATTR=
_POLICY_IDX])
+            {
+                query->sub_policy =3D (int)nl=
a_get_u32(tb_attr[NL_POLICY_TYPE_ATTR_POLICY_IDX]);
+            }
+
+     =
       /* Second link: the type the target has in that sub-policy=2E */
+  =
          if (policy_id =3D=3D query->sub_policy && attr_id =3D=3D query->r=
eq->target_attr
+                && tb_attr[NL_POLICY_TYPE_ATTR_TYPE])
+   =
         {
+                query->type =3D (int)nla_get_u32(tb_attr[NL_POL=
ICY_TYPE_ATTR_TYPE]);
+            }
+        }
+    }
+
+    return NL_OK;=

+}
+
+/* Dump the policy of req->cmd and let the callback pick the chain o=
ut of it=2E
+ * Returns false if we could not ask at all, with the netlink =
error in *perr=2E */
+static bool
+ovpn_cap_ask(const struct dco_capability=
_req *req, struct ovpn_cap_query *query, int *perr)
+{
+    struct nl_msg *=
nl_msg =3D NULL;
+    int ret =3D 0;
+
+    struct nl_sock *nl_sock =3D nl_=
socket_alloc();
+    if (!nl_sock)
+    {
+        *perr =3D -NLE_NOMEM;
+ =
       return false;
+    }
+
+    ret =3D genl_connect(nl_sock);
+    if (=
ret < 0)
+    {
+        goto out;
+    }
+    set_cloexec(nl_socket_get_fd=
(nl_sock));
+
+    nl_msg =3D nlmsg_alloc();
+    if (!nl_msg)
+    {
+    =
    ret =3D -NLE_NOMEM;
+        goto out;
+    }
+
+    /* nlctrl has a fi=
xed family id, so there is nothing to resolve first */
+    if (!genlmsg_pu=
t(nl_msg, NL_AUTO_PORT, NL_AUTO_SEQ, GENL_ID_CTRL, 0,
+                    =
 NLM_F_ROOT | NLM_F_MATCH | NLM_F_REQUEST, CTRL_CMD_GETPOLICY, 0))
+    {
+=
        ret =3D -NLE_MSGSIZE;
+        goto out;
+    }
+
+    ret =3D nla_=
put_string(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_FAMILY_NAME);
+    if (ret <=
 0)
+    {
+        goto out;
+    }
+
+    ret =3D nla_put_u32(nl_msg, CTR=
L_ATTR_OP, req->cmd);
+    if (ret < 0)
+    {
+        goto out;
+    }
+
=
+    ret =3D nl_socket_modify_cb(nl_sock, NL_CB_VALID, NL_CB_CUSTOM, ovpn_c=
ap_query_cb, query);
+    if (ret < 0)
+    {
+        goto out;
+    }
+
+=
    ret =3D nl_send_auto(nl_sock, nl_msg);
+    if (ret < 0)
+    {
+      =
  goto out;
+    }
+
+    ret =3D nl_recvmsgs_default(nl_sock);
+
+out:
+  =
  if (ret < 0)
+    {
+        *perr =3D ret;
+    }
+    nlmsg_free(nl_msg=
);
+    nl_socket_free(nl_sock);
+
+    return ret >=3D 0;
+}
+
+/*
+ * Dec=
ide whether the kernel supports the requirement, from the links the pass
+ =
* collected=2E A link the kernel never mentioned is a no; a chain we could =
not
+ * follow is not an answer either, and saying so is what keeps a trans=
ient
+ * failure from turning a capability off for good=2E
+ */
+static enu=
m ovpn_cap_status
+ovpn_cap_resolve(const struct ovpn_cap_query *query)
+{
=
+    /* the dump never named the policy that validates the command */
+    =
if (query->cmd_policy < 0)
+    {
+        return OVPN_CAP_UNKNOWN;
+    }
=
+
+    /* a link is missing: a plain no, unless policies were walked past b=
efore
+     * they could be placed, in which case one of them may have held=
 it */
+    if (query->sub_policy < 0 || query->type < 0)
+    {
+        r=
eturn query->unclassified ? OVPN_CAP_UNKNOWN : OVPN_CAP_UNSUPPORTED;
+    }=

+
+    /* the whole chain is there: a yes only if the attribute has the ty=
pe we
+     * would be writing into it */
+    return (query->type =3D=3D q=
uery->req->expected_type) ? OVPN_CAP_SUPPORTED : OVPN_CAP_UNSUPPORTED;
+}
+=

+/* Resolve one capability requirement against the running kernel=2E */
+s=
tatic enum ovpn_cap_status
+ovpn_cap_probe_one(const struct dco_capability_=
req *req, int *perr)
+{
+    struct ovpn_cap_query query =3D {
+        =2E=
req =3D req, =2Ecmd_policy =3D -1, =2Esub_policy =3D -1, =2Etype =3D -1, =
=2Eunclassified =3D 0
+    };
+
+    if (!ovpn_cap_ask(req, &query, perr))
=
+    {
+        return OVPN_CAP_UNKNOWN;
+    }
+
+    return ovpn_cap_reso=
lve(&query);
+}
+
+unsigned int
+dco_probe_capabilities(void)
+{
+    if (d=
co_caps_resolved)
+    {
+        return dco_caps;
+    }
+
+    /* no capa=
bility is defined yet: resolve one whose answer we already know */
+    sta=
tic const struct dco_capability_req self_test =3D { 0, OVPN_CMD_PEER_NEW, O=
VPN_A_PEER,
+                                                         OVPN_=
A_PEER_ID, NL_ATTR_TYPE_U32 };
+    int err =3D 0;
+    enum ovpn_cap_statu=
s status =3D ovpn_cap_probe_one(&self_test, &err);
+
+    msg(D_DCO_DEBUG, =
"%s: policy introspection self-test: %s (status %d, err %d)", __func__,
+  =
      status =3D=3D OVPN_CAP_SUPPORTED ? "ok" : "unexpected", (int)status, =
err);
+
+    dco_caps_resolved =3D true;
+    msg(D_DCO_DEBUG, "%s: DCO loc=
al capabilities: 0x%x", __func__, dco_caps);
+
+    return dco_caps;
+}
+
 =
static struct nl_msg *
 ovpn_dco_nlmsg_create(dco_context_t *dco, uint8_t c=
md)
 {
@@ -417,6 +719,12 @@
 {
     dco->ovpn_dco_id =3D resolve_ovpn_netli=
nk_id(M_FATAL);
 
+    /* nothing consumes the bitmap yet; resolve it here =
to exercise the path */
+    if (check_debug_level(D_DCO_DEBUG))
+    {
+  =
      dco_probe_capabilities();
+    }
+
     dco->nl_sock =3D nl_socket_al=
loc();
 
     if (!dco->nl_sock)
diff --git a/src/openvpn/dco_win=2Ec b/src=
/openvpn/dco_win=2Ec
index c230a90=2E=2Edbe8b78 100644
--- a/src/openvpn/dc=
o_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -606,6 +606,12 @@
     return 0;=

 }
 
+unsigned int
+dco_probe_capabilities(void)
+{
+    return 0;
+}
+
 b=
ool
 dco_available(msglvl_t msglevel)
 {
diff --git a/tests/unit_tests/open=
vpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 5954902=2E=
=2E52f18b5 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/=
unit_tests/openvpn/Makefile=2Eam
@@ -40,6 +40,12 @@
 endif
 endif
 
+if HAV=
E_SITNL
+if DCO_UNIT_TESTS
+test_binaries +=3D dco_testdriver
+endif
+endif=

+
 if !CROSS_COMPILING
 TESTS =3D $(test_binaries)
 endif
@@ -424,3 +430,1=
4 @@
 	$(top_srcdir)/src/openvpn/env_set=2Ec \
 	$(top_srcdir)/src/openvpn/=
run_command=2Ec \
 	$(top_srcdir)/src/openvpn/socket_util=2Ec
+
+dco_testdr=
iver_CFLAGS  =3D \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$=
(top_srcdir)/src/openvpn \
+	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO_CFLAGS)
+dco_t=
estdriver_LDFLAGS =3D @TEST_LDFLAGS@ $(OPTIONAL_CRYPTO_LIBS)
+dco_testdrive=
r_SOURCES =3D test_dco=2Ec \
+	mock_msg=2Ec mock_msg=2Eh mock_dco_dependenc=
ies=2Ec mock_get_random=2Ec test_common=2Eh \
+	$(top_srcdir)/src/openvpn/b=
uffer=2Ec \
+	$(top_srcdir)/src/openvpn/fdmisc=2Ec \
+	$(top_srcdir)/src/op=
envpn/platform=2Ec \
+	$(top_srcdir)/src/openvpn/win32-util=2Ec
diff --git =
a/tests/unit_tests/openvpn/mock_dco_dependencies=2Ec b/tests/unit_tests/ope=
nvpn/mock_dco_dependencies=2Ec
new file mode 100644
index 0000000=2E=2Ec609=
e77
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_dco_dependencies=2Ec
=
@@ -0,0 +1,74 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP n=
etworks
+ *             over a single UDP port, with support for SSL/TLS-ba=
sed
+ *             session authentication and key exchange,
+ *           =
  packet encryption, packet authentication, and
+ *             packet comp=
ression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Ene=
t>
+ *  Copyright (C) 2026 Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>=

+ *
+ *  This program is free software; you can redistribute it and/or mod=
ify
+ *  it under the terms of the GNU General Public License version 2
+ *=
  as published by the Free Software Foundation=2E
+ *
+ *  This program is =
distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRAN=
TY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FO=
R A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more=
 details=2E
+ *
+ *  You should have received a copy of the GNU General Pub=
lic License along
+ *  with this program; if not, see <https://www=2Egnu=2E=
org/licenses/>=2E
+ */
+
+/*
+ *  Stubs for what dco_linux=2Ec drags in but=
 capability probing never reaches:
+ *  the data path, the event loop and t=
he signal machinery=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
=
+#endif
+
+#include "syshead=2Eh"
+#include "dco=2Eh"
+
+void
+multi_proces=
s_incoming_dco(dco_context_t *dco)
+{
+}
+
+void
+process_incoming_dco(dco_=
context_t *dco)
+{
+}
+
+void
+register_signal(struct signal_info *si, int =
signum, const char *signal_text)
+{
+}
+
+int
+net_iface_new(openvpn_net_ct=
x_t *ctx, const char *iface, const char *type, void *arg)
+{
+    return 0;=

+}
+
+int
+net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
+{
+  =
  return 0;
+}
+
+int
+cipher_kt_key_size(const char *ciphername)
+{
+    r=
eturn 0;
+}
+
+const char *
+print_sockaddr_ex(const struct sockaddr *addr,=
 const char *separator, const unsigned int flags,
+                  struct=
 gc_arena *gc)
+{
+    return "[mock]";
+}
diff --git a/tests/unit_tests/op=
envpn/test_dco=2Ec b/tests/unit_tests/openvpn/test_dco=2Ec
new file mode 10=
0644
index 0000000=2E=2Eef3fe44
--- /dev/null
+++ b/tests/unit_tests/openvp=
n/test_dco=2Ec
@@ -0,0 +1,433 @@
+/*
+ *  OpenVPN -- An application to secu=
rely tunnel IP networks
+ *             over a single UDP port, with suppor=
t for SSL/TLS-based
+ *             session authentication and key exchange=
,
+ *             packet encryption, packet authentication, and
+ *        =
     packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sa=
les@openvpn=2Enet>
+ *  Copyright (C) 2026 Gianmarco De Gregori <gianmarco@=
mandelbit=2Ecom>
+ *
+ *  This program is free software; you can redistribu=
te it and/or modify
+ *  it under the terms of the GNU General Public Licen=
se version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  =
This program is distributed in the hope that it will be useful,
+ *  but WI=
THOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILI=
TY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public =
License for more details=2E
+ *
+ *  You should have received a copy of the=
 GNU General Public License along
+ *  with this program; if not, see <http=
s://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/*
+ *  Unit tests for the DCO ca=
pability queries=2E
+ *
+ *  Resolving a requirement is a single pass over =
a policy dump followed by a
+ *  look at what the pass collected=2E The pas=
s is fed dumps built by hand and
+ *  the decision is fed a query filled in=
 directly, which between them cover
+ *  what would otherwise need a partic=
ular kernel=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
=
+
+#include "syshead=2Eh"
+
+#include <stdarg=2Eh>
+#include <setjmp=2Eh>
+=
#include <cmocka=2Eh>
+
+#include "dco_linux=2Ec"
+
+#define CMD_POLICY   4=

+#define SUB_POLICY   9
+#define OTHER_POLICY 7
+
+/* the bit is never rea=
d here, only the chain that would set it */
+static const struct dco_capabi=
lity_req test_req =3D { =2Ecap =3D 1u,
+                                   =
                 =2Ecmd =3D OVPN_CMD_PEER_NEW,
+                           =
                         =2Enested_attr =3D OVPN_A_PEER,
+                 =
                                   =2Etarget_attr =3D OVPN_A_PEER_KEEPALIVE=
_INTERVAL,
+                                                    =2Eexpected=
_type =3D NL_ATTR_TYPE_U32 };
+
+/* the same requirement without a containe=
r: the target sits in the command's
+ * own policy */
+static const struct =
dco_capability_req flat_req =3D { =2Ecap =3D 1u,
+                         =
                           =2Ecmd =3D OVPN_CMD_PEER_NEW,
+                 =
                                   =2Enested_attr =3D 0,
+                 =
                                   =2Etarget_attr =3D OVPN_A_IFINDEX,
+    =
                                                =2Eexpected_type =3D NL_ATT=
R_TYPE_U32 };
+
+static struct ovpn_cap_query
+new_query_for(const struct d=
co_capability_req *req)
+{
+    struct ovpn_cap_query query =3D {
+        =
=2Ereq =3D req, =2Ecmd_policy =3D -1, =2Esub_policy =3D -1, =2Etype =3D -1,=
 =2Eunclassified =3D 0
+    };
+
+    return query;
+}
+
+static struct ovp=
n_cap_query
+new_query(void)
+{
+    return new_query_for(&test_req);
+}
+
=
+/* a CTRL_ATTR_OP_POLICY message saying which policy validates `cmd` */
+s=
tatic struct nl_msg *
+msg_op_policy(uint16_t cmd, uint32_t do_policy)
+{
+=
    struct nl_msg *msg =3D nlmsg_alloc();
+    struct nlattr *ops, *op;
+
+=
    assert_non_null(msg);
+    assert_non_null(genlmsg_put(msg, NL_AUTO_POR=
T, NL_AUTO_SEQ, 0, 0, 0, CTRL_CMD_GETPOLICY, 0));
+
+    ops =3D nla_nest_s=
tart(msg, CTRL_ATTR_OP_POLICY);
+    op =3D nla_nest_start(msg, cmd);
+    =
assert_int_equal(nla_put_u32(msg, CTRL_ATTR_POLICY_DO, do_policy), 0);
+   =
 nla_nest_end(msg, op);
+    nla_nest_end(msg, ops);
+
+    return msg;
+}
=
+
+/* one attribute of a policy: its id, which field of its descriptor to s=
et,
+ * and the value to put there */
+struct attr_desc
+{
+    uint16_t at=
tr_id;
+    int field;
+    uint32_t value;
+};
+
+/* a CTRL_ATTR_POLICY me=
ssage describing `n` attributes of one policy */
+static struct nl_msg *
+m=
sg_policy_attrs(uint32_t policy_id, const struct attr_desc *descs, size_t n=
)
+{
+    struct nl_msg *msg =3D nlmsg_alloc();
+    struct nlattr *policie=
s, *policy, *attr;
+
+    assert_non_null(msg);
+    assert_non_null(genlms=
g_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, 0, 0, 0, CTRL_CMD_GETPOLICY, 0));
+
+=
    policies =3D nla_nest_start(msg, CTRL_ATTR_POLICY);
+    policy =3D nla=
_nest_start(msg, policy_id);
+    for (size_t i =3D 0; i < n; i++)
+    {
+=
        attr =3D nla_nest_start(msg, descs[i]=2Eattr_id);
+        assert_i=
nt_equal(nla_put_u32(msg, descs[i]=2Efield, descs[i]=2Evalue), 0);
+       =
 nla_nest_end(msg, attr);
+    }
+    nla_nest_end(msg, policy);
+    nla_n=
est_end(msg, policies);
+
+    return msg;
+}
+
+/* the shape the kernel ac=
tually sends: one attribute per message */
+static struct nl_msg *
+msg_pol=
icy_attr(uint32_t policy_id, uint16_t attr_id, int field, uint32_t value)
+=
{
+    const struct attr_desc one =3D { attr_id, field, value };
+
+    ret=
urn msg_policy_attrs(policy_id, &one, 1);
+}
+
+static void
+feed(struct ov=
pn_cap_query *query, struct nl_msg *msg)
+{
+    assert_int_equal(ovpn_cap_=
query_cb(msg, query), NL_OK);
+    nlmsg_free(msg);
+}
+
+/* Walk the whole=
 chain, with both policies carrying attributes we are not
+ * after and the=
 ones we are neither first nor last, so that the pass has to
+ * skip past =
them rather than stop at the first mismatch=2E */
+static void
+feed_full_c=
hain(struct ovpn_cap_query *query)
+{
+    const struct attr_desc cmd_attrs=
[] =3D {
+        { OVPN_A_IFINDEX, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_=
U32 },
+        { OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX, SUB_POLICY }=
,
+        { OVPN_A_KEYCONF, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_NESTED =
},
+    };
+    const struct attr_desc sub_attrs[] =3D {
+        { OVPN_A_=
PEER_ID, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U32 },
+        { OVPN_A_PE=
ER_REMOTE_PORT, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U16 },
+        { te=
st_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U32 },
+      =
  { OVPN_A_PEER_LOCAL_PORT, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U16 },
+=
    };
+
+    feed(query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+ =
   feed(query, msg_policy_attrs(CMD_POLICY, cmd_attrs, SIZE(cmd_attrs)));
+=
    feed(query, msg_policy_attrs(SUB_POLICY, sub_attrs, SIZE(sub_attrs)));
=
+}
+
+/* the map tells us which policy validates the command we asked about=
 */
+static void
+test_reads_command_policy(void **state)
+{
+    struct ov=
pn_cap_query query =3D new_query();
+
+    feed(&query, msg_op_policy(OVPN_=
CMD_PEER_NEW, CMD_POLICY));
+    assert_int_equal(query=2Ecmd_policy, CMD_P=
OLICY);
+}
+
+/* and not about another one, even though the dump is suppose=
d to be filtered */
+static void
+test_ignores_other_command(void **state)
=
+{
+    struct ovpn_cap_query query =3D new_query();
+
+    feed(&query, ms=
g_op_policy(OVPN_CMD_PEER_DEL, CMD_POLICY));
+    assert_int_equal(query=2E=
cmd_policy, -1);
+}
+
+/* the nested attribute of that policy points at the=
 sub-policy */
+static void
+test_follows_nested_attribute(void **state)
+{=

+    struct ovpn_cap_query query =3D new_query();
+
+    feed(&query, msg_=
op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_att=
r(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+               =
                  SUB_POLICY));
+    assert_int_equal(query=2Esub_policy, S=
UB_POLICY);
+}
+
+/* an attribute id only means something inside its own po=
licy, so the same
+ * number elsewhere says nothing about our question */
+=
static void
+test_ignores_nested_attribute_elsewhere(void **state)
+{
+    =
struct ovpn_cap_query query =3D new_query();
+
+    feed(&query, msg_op_pol=
icy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(OTHE=
R_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                   =
              SUB_POLICY));
+    assert_int_equal(query=2Esub_policy, -1);
=
+}
+
+/* the type of the target attribute is read in the sub-policy */
+sta=
tic void
+test_reads_target_type(void **state)
+{
+    struct ovpn_cap_quer=
y query =3D new_query();
+
+    feed_full_chain(&query);
+    assert_int_eq=
ual(query=2Etype, NL_ATTR_TYPE_U32);
+}
+
+/* and the same holds for the ta=
rget attribute: a type read off some other
+ * policy is not an answer to w=
hat we asked */
+static void
+test_ignores_target_attribute_elsewhere(void =
**state)
+{
+    struct ovpn_cap_query query =3D new_query();
+
+    feed(&=
query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg=
_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+    =
                             SUB_POLICY));
+    feed(&query, msg_policy_att=
r(OTHER_POLICY, test_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,
+        =
                         NL_ATTR_TYPE_U32));
+    assert_int_equal(query=2E=
type, -1);
+}
+
+/* the command's own policy does get read, so the target a=
ttribute has to be
+ * turned away there too: the same id there is a differ=
ent attribute */
+static void
+test_ignores_target_attribute_in_command_pol=
icy(void **state)
+{
+    struct ovpn_cap_query query =3D new_query();
+
+ =
   feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&q=
uery, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_I=
DX,
+                                 SUB_POLICY));
+    feed(&query, msg_p=
olicy_attr(CMD_POLICY, test_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,
+ =
                                NL_ATTR_TYPE_U32));
+    assert_int_equal(q=
uery=2Etype, -1);
+}
+
+/* the sub-policy is read too, so the nested attrib=
ute has to be turned away
+ * there as well */
+static void
+test_ignores_n=
ested_attribute_in_sub_policy(void **state)
+{
+    struct ovpn_cap_query q=
uery =3D new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, =
CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL=
_POLICY_TYPE_ATTR_POLICY_IDX,
+                                 SUB_POLICY)=
);
+    feed(&query, msg_policy_attr(SUB_POLICY, OVPN_A_PEER, NL_POLICY_TYP=
E_ATTR_POLICY_IDX,
+                                 OTHER_POLICY));
+    a=
ssert_int_equal(query=2Esub_policy, SUB_POLICY);
+}
+
+/* an attribute that=
 is there but not as a nest has nothing to follow */
+static void
+test_nes=
ted_attribute_without_policy_idx(void **state)
+{
+    struct ovpn_cap_quer=
y query =3D new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NE=
W, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER,=
 NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL_ATTR_TYPE_U=
32));
+    assert_int_equal(query=2Esub_policy, -1);
+}
+
+/* and one that =
is a nest says nothing about the type we are after */
+static void
+test_ta=
rget_attribute_without_type(void **state)
+{
+    struct ovpn_cap_query que=
ry =3D new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CM=
D_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_P=
OLICY_TYPE_ATTR_POLICY_IDX,
+                                 SUB_POLICY));=

+    feed(&query, msg_policy_attr(SUB_POLICY, test_req=2Etarget_attr,
+   =
                              NL_POLICY_TYPE_ATTR_POLICY_IDX, OTHER_POLICY)=
);
+    assert_int_equal(query=2Etype, -1);
+}
+
+/* a policy we cannot pla=
ce yet is counted, one we walk past afterwards is not */
+static void
+test=
_counts_only_what_it_could_not_place(void **state)
+{
+    struct ovpn_cap_=
query query =3D new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEE=
R_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(OTHER_POLICY, OVPN_A=
_PEER_ID, NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL_AT=
TR_TYPE_U32));
+    assert_int_equal(query=2Eunclassified, 1);
+
+    feed(=
&query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY=
_IDX,
+                                 SUB_POLICY));
+    feed(&query, msg=
_policy_attr(OTHER_POLICY, OVPN_A_PEER_ID, NL_POLICY_TYPE_ATTR_TYPE,
+     =
                            NL_ATTR_TYPE_U32));
+    assert_int_equal(query=
=2Eunclassified, 1);
+}
+
+/* a flat requirement needs no hop: the command'=
s policy is where to look */
+static void
+test_flat_requirement_reads_comm=
and_policy(void **state)
+{
+    struct ovpn_cap_query query =3D new_query_=
for(&flat_req);
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_PO=
LICY));
+    assert_int_equal(query=2Esub_policy, CMD_POLICY);
+
+    feed(=
&query, msg_policy_attr(CMD_POLICY, flat_req=2Etarget_attr, NL_POLICY_TYPE_=
ATTR_TYPE,
+                                 NL_ATTR_TYPE_U32));
+    asser=
t_int_equal(ovpn_cap_resolve(&query), OVPN_CAP_SUPPORTED);
+}
+
+/* and an =
absent one is a plain no, with nothing left unclassified */
+static void
+t=
est_flat_requirement_absent_is_unsupported(void **state)
+{
+    struct ovp=
n_cap_query query =3D new_query_for(&flat_req);
+
+    feed(&query, msg_op_=
policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(O=
THER_POLICY, flat_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,
+           =
                      NL_ATTR_TYPE_U32));
+    assert_int_equal(query=2Eunc=
lassified, 0);
+    assert_int_equal(ovpn_cap_resolve(&query), OVPN_CAP_UNS=
UPPORTED);
+}
+
+/* nothing to read an answer out of is not the same as a "=
no" */
+static void
+test_resolve_without_command_policy(void **state)
+{
+=
    struct ovpn_cap_query query =3D new_query();
+
+    assert_int_equal(ov=
pn_cap_resolve(&query), OVPN_CAP_UNKNOWN);
+}
+
+/* a kernel that does not =
nest the attribute simply never mentions it */
+static void
+test_resolve_n=
ested_absent(void **state)
+{
+    struct ovpn_cap_query query =3D new_quer=
y();
+
+    query=2Ecmd_policy =3D CMD_POLICY;
+    assert_int_equal(ovpn_c=
ap_resolve(&query), OVPN_CAP_UNSUPPORTED);
+}
+
+/* unless the dump went by=
 in an order we could not follow, in which case we
+ * did not find out eit=
her way */
+static void
+test_resolve_incomplete_after_skipping(void **stat=
e)
+{
+    struct ovpn_cap_query query =3D new_query();
+
+    query=2Ecmd_=
policy =3D CMD_POLICY;
+    query=2Eunclassified =3D 1;
+    assert_int_equ=
al(ovpn_cap_resolve(&query), OVPN_CAP_UNKNOWN);
+}
+
+/* the sub-policy is =
there but does not define the attribute: the ordinary no */
+static void
+t=
est_resolve_target_absent(void **state)
+{
+    struct ovpn_cap_query query=
 =3D new_query();
+
+    query=2Ecmd_policy =3D CMD_POLICY;
+    query=2Esu=
b_policy =3D SUB_POLICY;
+    assert_int_equal(ovpn_cap_resolve(&query), OV=
PN_CAP_UNSUPPORTED);
+}
+
+/* right name, wrong type: not the attribute we =
would be writing */
+static void
+test_resolve_wrong_type(void **state)
+{
=
+    struct ovpn_cap_query query =3D new_query();
+
+    query=2Ecmd_policy=
 =3D CMD_POLICY;
+    query=2Esub_policy =3D SUB_POLICY;
+    query=2Etype =
=3D NL_ATTR_TYPE_U8;
+    assert_int_equal(ovpn_cap_resolve(&query), OVPN_C=
AP_UNSUPPORTED);
+}
+
+/* and the whole chain, from a dump to a yes */
+sta=
tic void
+test_resolve_complete_chain(void **state)
+{
+    struct ovpn_cap=
_query query =3D new_query();
+
+    feed_full_chain(&query);
+    assert_i=
nt_equal(query=2Eunclassified, 0);
+    assert_int_equal(ovpn_cap_resolve(&=
query), OVPN_CAP_SUPPORTED);
+}
+
+int
+main(void)
+{
+    const struct CMU=
nitTest tests[] =3D {
+        cmocka_unit_test(test_reads_command_policy),=

+        cmocka_unit_test(test_ignores_other_command),
+        cmocka_uni=
t_test(test_follows_nested_attribute),
+        cmocka_unit_test(test_ignor=
es_nested_attribute_elsewhere),
+        cmocka_unit_test(test_reads_target=
_type),
+        cmocka_unit_test(test_ignores_target_attribute_elsewhere),=

+        cmocka_unit_test(test_ignores_target_attribute_in_command_policy)=
,
+        cmocka_unit_test(test_ignores_nested_attribute_in_sub_policy),
+=
        cmocka_unit_test(test_nested_attribute_without_policy_idx),
+      =
  cmocka_unit_test(test_target_attribute_without_type),
+        cmocka_uni=
t_test(test_counts_only_what_it_could_not_place),
+        cmocka_unit_test=
(test_flat_requirement_reads_command_policy),
+        cmocka_unit_test(tes=
t_flat_requirement_absent_is_unsupported),
+        cmocka_unit_test(test_r=
esolve_without_command_policy),
+        cmocka_unit_test(test_resolve_nest=
ed_absent),
+        cmocka_unit_test(test_resolve_incomplete_after_skippin=
g),
+        cmocka_unit_test(test_resolve_target_absent),
+        cmocka_=
unit_test(test_resolve_wrong_type),
+        cmocka_unit_test(test_resolve_=
complete_chain),
+    };
+
+    return cmocka_run_group_tests_name("dco", t=
ests, NULL, NULL);
+}

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1981?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6
Gerrit-Change-Number: 1981
G=
errit-PatchSet: 1
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--/qqjXR15QNo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">dco: detect local kernel capabilities through netlink p=
olicies<br><br>The ovpn module lives in the kernel, so the attributes it ac=
cepts may<br>differ from what we were built against=2E CTRL_CMD_GETPOLICY d=
umps the<br>validation policy of a family: which attributes each command ta=
kes, of<br>what type, and for a nested one the sub-policy that validates it=
=2E<br><br>Add a helper to query it, wrapped in dco_probe_capabilities() so=
 the<br>rest of the tree never talks to netlink itself=2E Answering a requi=
rement<br>means following a chain - which policy validates the command, whe=
re its<br>nested attribute points if it has one, what type the target attri=
bute<br>has there - and CTRL_ATTR_OP narrows the dump enough to collect all=
<br>three in one pass=2E<br><br>The answer has three values rather than two=
: without &quot;could not ask&quot;, a<br>netlink error would look the same=
 as an old kernel=2E<br><br>No capability is defined yet, so the bitmap com=
es back empty; the rows<br>that fill it arrive with the features that need =
them=2E The unit test<br>drives the pass and the decision separately, on du=
mps built by hand=2E<br><br>Change-Id: I0051effe7f0636e30557d9ce92c50c45800=
2f9e6<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&=
gt;<br>---<br>M configure=2Eac<br>M src/openvpn/dco=2Eh<br>M src/openvpn/dc=
o_freebsd=2Ec<br>M src/openvpn/dco_linux=2Ec<br>M src/openvpn/dco_win=2Ec<b=
r>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/unit_tests/openvpn/mo=
ck_dco_dependencies=2Ec<br>A tests/unit_tests/openvpn/test_dco=2Ec<br>8 fil=
es changed, 862 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/1981/1</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>index 56=
109af=2E=2E0758ad9 100644</span><br><span>--- a/configure=2Eac</span><br><s=
pan>+++ b/configure=2Eac</span><br><span>@@ -1313,6 +1313,7 @@</span><br><s=
pan> AC_SUBST([PLUGIN_AUTH_PAM_LIBS])</span><br><span> </span><br><span> AM=
_CONDITIONAL([WIN32], [test &quot;${WIN32}&quot; =3D &quot;yes&quot;])</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+AM_CONDITIONAL([DCO_UNIT=
_TESTS], [test &quot;${enable_dco}&quot; !=3D &quot;no&quot;])</span><br><s=
pan> AM_CONDITIONAL([GIT_CHECKOUT], [test &quot;${GIT_CHECKOUT}&quot; =3D &=
quot;yes&quot;])</span><br><span> AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], =
[test &quot;${enable_plugin_auth_pam}&quot; =3D &quot;yes&quot;])</span><br=
><span> AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test &quot;${enable_plug=
in_down_root}&quot; =3D &quot;yes&quot;])</span><br><span>diff --git a/src/=
openvpn/dco=2Eh b/src/openvpn/dco=2Eh</span><br><span>index 7ef75fee=2E=2Ed=
074257 100644</span><br><span>--- a/src/openvpn/dco=2Eh</span><br><span>+++=
 b/src/openvpn/dco=2Eh</span><br><span>@@ -254,6 +254,17 @@</span><br><span=
>  */</span><br><span> bool</span><br><span> dco_supports_epoch_data(struct=
 context *c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Return a bitmap of DCO_CAP_* bits desc=
ribing the negotiable features the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * local kernel supports=2E Everything DCO does without nego=
tiating is available</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * regardless=2E Resolved once and reused; platforms without capability pr=
obing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * return 0=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @return  bitmask of DCO_CAP_* fla=
gs; 0 both when the kernel negotiates none</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *          of them and when it could not be asked</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+unsigned int dco_probe_capabilities(v=
oid);</span><br><span> #else  /* if defined(ENABLE_DCO) */</span><br><span>=
 </span><br><span> typedef void *dco_context_t;</span><br><span>@@ -388,5 +=
399,11 @@</span><br><span> {</span><br><span>     return false;</span><br><=
span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static inline unsigned int</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_probe_capabilities(v=
oid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #endif /* defined(EN=
ABLE_DCO) */</span><br><span> #endif /* ifndef DCO_H */</span><br><span>dif=
f --git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec</span><=
br><span>index 87eea55=2E=2E9ace240 100644</span><br><span>--- a/src/openvp=
n/dco_freebsd=2Ec</span><br><span>+++ b/src/openvpn/dco_freebsd=2Ec</span><=
br><span>@@ -702,6 +702,12 @@</span><br><span>     return 0;</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_=
probe_capabilities(void)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><spa=
n> dco_available(msglvl_t msglevel)</span><br><span> {</span><br><span>diff=
 --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><s=
pan>index a397fb8=2E=2Eeabb3ea 100644</span><br><span>--- a/src/openvpn/dco=
_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br><span>=
@@ -103,6 +103,308 @@</span><br><span>     return ret;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Netlink policy in=
trospection: the ovpn module lives in the kernel, so the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * attributes it accepts may differ fr=
om what we were built against=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * CTRL_CMD_GETPOLICY says which attributes a command takes an=
d of what type,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * a=
nd CTRL_ATTR_OP narrows the dump to a single command=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* one row per capability; a row on a command of its own costs one more du=
mp */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct dco_cap=
ability_req</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int cap;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t cmd;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t nested_attr; =
/* 0 if target_attr is not nested */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    uint16_t target_attr;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int expected_type;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** the ou=
tcome of resolving one capability requirement */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+enum ovpn_cap_status</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    OVPN_CAP_UNKNOWN,     /**&lt; the question could not be ask=
ed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CAP_S=
UPPORTED,   /**&lt; the kernel accepts the attribute */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    OVPN_CAP_UNSUPPORTED, /**&lt; the k=
ernel answered, and does not accept it */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct ovpn_ca=
p_query</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const struct dco_capabilit=
y_req *req;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    int cmd_policy; /* poli=
cy validating the doit of req-&gt;cmd, -1 until seen */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int sub_policy; /* where nested_att=
r points, -1 until seen */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int type;       /* type of target_attr in the sub-policy, -1 unt=
il seen */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* policies walked past =
before their role was known */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int unclassified;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* What the local kerne=
l supports=2E It cannot change while we run, so the first</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * caller resolves it and the rest ju=
st read it=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic unsigned int dco_caps =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static bool dco_caps_resolved =3D false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 The command map arrives before any policy and a nested policy after the on=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * nesting it, so =
one pass suffices=2E That order is not promised, so policies</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * walked past unclassified are co=
unted: an incomplete chain then means we could</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * not tell, not that the attribute is missing=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ovpn_cap_query_cb(struct nl_msg *msg, voi=
d *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query *que=
ry =3D arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct nlattr *tb[CTRL_ATTR_MAX + 1];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const struct genlmsghdr *ghdr =3D nlmsg_data(nlmsg_hdr(ms=
g));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* one message of the dump: it=
 carries either the command map or a slice of</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * one policy, and fills in whichever link of=
 the chain it happens to hold */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(ghdr, 0), genlmsg_attrlen(g=
hdr, 0), NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NL_=
SKIP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* CTRL_ATTR_OP_POLICY: which policy valida=
tes the doit of each command */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (tb[CTRL_ATTR_OP_POLICY])</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        const struct nlattr *nla_cmd;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        int rem_cmd;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        nla_for_each_nested(nla_cmd, tb[CTRL_ATTR_OP_POLICY], re=
m_cmd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct nlat=
tr *tb_cmd[CTRL_ATTR_POLICY_DUMP_MAX + 1];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            /* the dump is filtered, but do not rely on that */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (nla_type(nl=
a_cmd) !=3D query-&gt;req-&gt;cmd)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                continue;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (nla_parse(tb_cmd, CTRL_ATTR_POLICY_DUMP_MAX, nla_data(nla_cmd), nla_l=
en(nla_cmd),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                   NULL))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                continue;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (tb_=
cmd[CTRL_ATTR_POLICY_DO])</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                query-&gt;cmd_policy =3D (int)nla_get_u32(tb_cmd[CTRL_ATTR_=
POLICY_DO]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                /* a requi=
rement with no container looks for its target in the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 * command&#39;s own poli=
cy, so the search ends where it starts */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                if (!query-&gt;req-&gt;nested_attr)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    que=
ry-&gt;sub_policy =3D query-&gt;cmd_policy;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* CTRL_ATTR_POLICY: wh=
ich attributes each policy accepts */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!tb[CTRL_ATTR_POLICY])</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return NL_OK;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct=
 nlattr *nla_policy;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int rem_policy;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nla_for_each_n=
ested(nla_policy, tb[CTRL_ATTR_POLICY], rem_policy)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct nlattr *nla_attr;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int rem_attr;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        int policy_id =3D nla_type(nla_=
policy);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* only the two polici=
es of the chain can hold anything we need=2E One we</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * cannot place yet is counted, b=
ecause skipping it may be why the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * chain ends up incomplete */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (policy_id !=3D query-&gt;cmd_=
policy &amp;&amp; policy_id !=3D query-&gt;sub_policy)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (query-&gt;sub_policy &lt; 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                query-&gt;uncla=
ssified++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            con=
tinue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        nla_for_each_nested(nla_attr, nla=
_policy, rem_attr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 struct nlattr *tb_attr[NL_POLICY_TYPE_ATTR_MAX + 1];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            int attr_id =3D nla_type(nla_=
attr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (attr_id !=3D que=
ry-&gt;req-&gt;nested_attr &amp;&amp; attr_id !=3D query-&gt;req-&gt;target=
_attr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                con=
tinue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (nla_parse_nested(tb_at=
tr, NL_POLICY_TYPE_ATTR_MAX, nla_attr, NULL))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                continue;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* An attribute id only means something inside its own policy,=
 so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * e=
ach link is read where it belongs=2E First link: the nested</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+             * attribute of the com=
mand&#39;s policy names the sub-policy=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (policy_id =3D=3D query-&gt;cmd_pol=
icy &amp;&amp; attr_id =3D=3D query-&gt;req-&gt;nested_attr</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                &amp;&amp; tb_attr[=
NL_POLICY_TYPE_ATTR_POLICY_IDX])</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                query-&gt;sub_policy =3D (int)nla_get_u32(tb_attr[NL=
_POLICY_TYPE_ATTR_POLICY_IDX]);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /=
* Second link: the type the target has in that sub-policy=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (policy_id =3D=
=3D query-&gt;sub_policy &amp;&amp; attr_id =3D=3D query-&gt;req-&gt;target=
_attr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  &amp;&amp; tb_attr[NL_POLICY_TYPE_ATTR_TYPE])</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                query-&gt;type =3D (int)nla_get_u32(t=
b_attr[NL_POLICY_TYPE_ATTR_TYPE]);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return NL_OK;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Dump the policy of req-&gt;cmd and let the callback pick the chain out=
 of it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Returns=
 false if we could not ask at all, with the netlink error in *perr=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ovpn_cap_ask(const struct dco_=
capability_req *req, struct ovpn_cap_query *query, int *perr)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct nl_msg *nl_msg =3D NULL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct nl_sock *nl_sock =3D nl_socket_alloc();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!nl_sock)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        *perr =3D -NLE_NOMEM;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ret =3D genl_connect(nl_sock);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    set_cloexec(nl_socket_get_fd(nl_sock));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    nl_msg =3D nlmsg_alloc();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!nl_msg)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      ret =3D -NLE_NOMEM;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* nlctrl has a fixed fam=
ily id, so there is nothing to resolve first */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!genlmsg_put(nl_msg, NL_AUTO_PORT, NL_A=
UTO_SEQ, GENL_ID_CTRL, 0,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                     NLM_F_ROOT | NLM_F_MATCH | NLM_F_REQUEST, CTRL_C=
MD_GETPOLICY, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D =
-NLE_MSGSIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ret =3D nla_put_string(nl_msg, CTRL_A=
TTR_FAMILY_NAME, OVPN_FAMILY_NAME);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (ret &lt; 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ret =3D nla_put_u32(nl_msg, C=
TRL_ATTR_OP, req-&gt;cmd);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ret =3D nl_socket_modify_cb(nl_sock, =
NL_CB_VALID, NL_CB_CUSTOM, ovpn_cap_query_cb, query);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D nl_=
send_auto(nl_sock, nl_msg);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (ret &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ret =3D nl_recvmsgs_default(nl_sock);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+out:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (ret &lt; 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        *perr =3D ret;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 nlmsg_free(nl_msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    nl_socket_free(nl_sock);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n ret &gt;=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Decide whether the kernel supports the requirement, fr=
om the links the pass</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * collected=2E A link the kernel never mentioned is a no; a chain we cou=
ld not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * follow is =
not an answer either, and saying so is what keeps a transient</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * failure from turning a capabil=
ity off for good=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static enum ovpn=
_cap_status</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_cap=
_resolve(const struct ovpn_cap_query *query)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* the dump never named the policy that validates the command */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (query-&gt;c=
md_policy &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return O=
VPN_CAP_UNKNOWN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* a link is missing: a plain no=
, unless policies were walked past before</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * they could be placed, in which case one of the=
m may have held it */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (query-&gt;sub_policy &lt; 0 || query-&gt;type &lt; 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return query-&gt;unclassified ? OVPN_=
CAP_UNKNOWN : OVPN_CAP_UNSUPPORTED;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the whole =
chain is there: a yes only if the attribute has the type we</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * would be writing into it */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (query-&g=
t;type =3D=3D query-&gt;req-&gt;expected_type) ? OVPN_CAP_SUPPORTED : OVPN_=
CAP_UNSUPPORTED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* Resolve one capability requirement ag=
ainst the running kernel=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static enum ovpn_cap_status</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ovpn_cap_probe_one(const struct dco_capability_req *req,=
 int *perr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query =
query =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
=2Ereq =3D req, =2Ecmd_policy =3D -1, =2Esub_policy =3D -1, =2Etype =3D -1,=
 =2Eunclassified =3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ovpn_cap_ask(req, &a=
mp;query, perr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return OV=
PN_CAP_UNKNOWN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return ovpn_cap_resolve(&amp;quer=
y);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+unsigned int</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+dco_probe_capabilities(void)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (dco_caps_resolved)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return dco_caps;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* no capability is defin=
ed yet: resolve one whose answer we already know */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    static const struct dco_capability_re=
q self_test =3D { 0, OVPN_CMD_PEER_NEW, OVPN_A_PEER,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
                OVPN_A_PEER_ID, NL_ATTR_TYPE_U32 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int err =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    enum ovpn_cap_status status =3D ovpn_=
cap_probe_one(&amp;self_test, &amp;err);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    msg(D_DCO_DEBUG, &quot;%s: policy introspection self-test: %s (status=
 %d, err %d)&quot;, __func__,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        status =3D=3D OVPN_CAP_SUPPORTED ? &quot;ok&quot; : &quot=
;unexpected&quot;, (int)status, err);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   dco_caps_resolved =3D true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: DCO local capabilities: 0x%x&quot=
;, __func__, dco_caps);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return dco_=
caps;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static struct =
nl_msg *</span><br><span> ovpn_dco_nlmsg_create(dco_context_t *dco, uint8_t=
 cmd)</span><br><span> {</span><br><span>@@ -417,6 +719,12 @@</span><br><sp=
an> {</span><br><span>     dco-&gt;ovpn_dco_id =3D resolve_ovpn_netlink_id(=
M_FATAL);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* nothing consumes the bitmap yet; resolve it here to exercise=
 the path */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(check_debug_level(D_DCO_DEBUG))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       dco_probe_capabilities();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>     dco-&gt;nl_sock =3D nl_socket_alloc();</span><br><span=
> </span><br><span>     if (!dco-&gt;nl_sock)</span><br><span>diff --git a/=
src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>index c23=
0a90=2E=2Edbe8b78 100644</span><br><span>--- a/src/openvpn/dco_win=2Ec</spa=
n><br><span>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -606,6 +606,12=
 @@</span><br><span>     return 0;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+dco_probe_capabilities(void)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> bool</span><br><span> dco_available(msglvl_t =
msglevel)</span><br><span> {</span><br><span>diff --git a/tests/unit_tests/=
openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><s=
pan>index 5954902=2E=2E52f18b5 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Make=
file=2Eam</span><br><span>@@ -40,6 +40,12 @@</span><br><span> endif</span><=
br><span> endif</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+if HAVE_SITNL</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+if DCO_UNIT_TESTS</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_binaries +=3D dco_testdriver</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> if !CROSS_COMPILING</span><br><span> TESTS =3D $(test_binaries)</=
span><br><span> endif</span><br><span>@@ -424,3 +430,14 @@</span><br><span>=
 	$(top_srcdir)/src/openvpn/env_set=2Ec \</span><br><span> 	$(top_srcdir)/s=
rc/openvpn/run_command=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/so=
cket_util=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_testdriver_CFLAGS  =
=3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdi=
r)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	@TEST_CFLAGS@ $(OPTIONAL_C=
RYPTO_CFLAGS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_te=
stdriver_LDFLAGS =3D @TEST_LDFLAGS@ $(OPTIONAL_CRYPTO_LIBS)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+dco_testdriver_SOURCES =3D test_dco=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg=2Ec=
 mock_msg=2Eh mock_dco_dependencies=2Ec mock_get_random=2Ec test_common=2Eh=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/sr=
c/openvpn/buffer=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	$(top_srcdir)/src/openvpn/fdmisc=2Ec \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/win=
32-util=2Ec</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_dco_=
dependencies=2Ec b/tests/unit_tests/openvpn/mock_dco_dependencies=2Ec</span=
><br><span>new file mode 100644</span><br><span>index 0000000=2E=2Ec609e77<=
/span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvp=
n/mock_dco_dependencies=2Ec</span><br><span>@@ -0,0 +1,74 @@</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP=
 networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     over a single UDP port, with support for SSL/TLS-based</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             session authenticati=
on and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *             packet encryption, packet authentication, and</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenV=
PN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  Copyright (C) 2026 Gianmarco De Gregori &lt;gianmarco@ma=
ndelbit=2Ecom&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is=
 free software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is distributed in the hope that it wi=
ll be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  GNU General Public License for more details=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/lic=
enses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Stubs for what dco_linux=2Ec drags in but capability p=
robing never reaches:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  the data path, the event loop and the signal machinery=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;dco=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_process_incoming=
_dco(dco_context_t *dco)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+process_incoming_dco(dco_context_t *dco)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+register_signal(struct signal_info *si,=
 int signum, const char *signal_text)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+net_iface_new(openvpn_net_ctx_t *ctx, const char *ifa=
ce, const char *type, void *arg)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+cipher_kt_key_size(const char=
 *ciphername)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+print_sockaddr_ex(const struct sockaddr *addr, const char *separator, cons=
t unsigned int flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                  struct gc_arena *gc)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return &quot;[mock]&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
dco=2Ec b/tests/unit_tests/openvpn/test_dco=2Ec</span><br><span>new file mo=
de 100644</span><br><span>index 0000000=2E=2Eef3fe44</span><br><span>--- /d=
ev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_dco=2Ec</span><=
br><span>@@ -0,0 +1,433 @@</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVP=
N -- An application to securely tunnel IP networks</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             over a single UDP port, with =
support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             session authentication and key exchange,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption,=
 packet authentication, and</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             packet compression=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2=
026 Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  This program is free software; you can redistribu=
te it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  it under the terms of the GNU General Public License version 2</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free=
 Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This prog=
ram is distributed in the hope that it will be useful,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without ev=
en the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Publ=
ic License for more details=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Yo=
u should have received a copy of the GNU General Public License along</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if=
 not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Unit tests fo=
r the DCO capability queries=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  R=
esolving a requirement is a single pass over a policy dump followed by a</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  look at what the p=
ass collected=2E The pass is fed dumps built by hand and</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  the decision is fed a query filled=
 in directly, which between them cover</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  what would otherwise need a particular kernel=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &lt;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;dco_linux=2Ec&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 CMD_POLICY   4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine SUB_POLICY   9</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define OTHER_POLICY 7</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* the bit is nev=
er read here, only the chain that would set it */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static const struct dco_capability_req test_r=
eq =3D { =2Ecap =3D 1u,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                                    =2Ecmd =3D OVPN_CMD=
_PEER_NEW,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                           =2Enested_attr =3D OVPN_A_PEER,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                                =2Etarget_attr =3D OVPN_A_PEER_KEEPALIVE_IN=
TERVAL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                                        =2Eexpected_type =3D NL_ATTR_TYPE_U=
32 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* the same requirement without a=
 container: the target sits in the command&#39;s</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * own policy */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static const struct dco_capability_req flat_req =
=3D { =2Ecap =3D 1u,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                                    =2Ecmd =3D OVPN_CMD_PE=
ER_NEW,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                                        =2Enested_attr =3D 0,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
                   =2Etarget_attr =3D OVPN_A_IFINDEX,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
           =2Eexpected_type =3D NL_ATTR_TYPE_U32 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static struct ovpn_cap_query</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+new_query_for(const struct dco_capability_req *req)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Ereq =3D =
req, =2Ecmd_policy =3D -1, =2Esub_policy =3D -1, =2Etype =3D -1, =2Eunclass=
ified =3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return query;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic struct ovpn_cap_query</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+new_query(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return new_q=
uery_for(&amp;test_req);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* a CTRL_ATTR_OP_POLICY message=
 saying which policy validates `cmd` */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static struct nl_msg *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+msg_op_policy(uint16_t cmd, uint32_t do_policy)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct nl_msg *msg =3D nlmsg_alloc();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nlattr *=
ops, *op;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(msg);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(gen=
lmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, 0, 0, 0, CTRL_CMD_GETPOLICY, 0));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ops =3D nla_nest_start(msg, CTRL_AT=
TR_OP_POLICY);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o=
p =3D nla_nest_start(msg, cmd);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(nla_put_u32(msg, CTRL_ATTR_POLICY_DO, do_p=
olicy), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nla_=
nest_end(msg, op);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   nla_nest_end(msg, ops);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return m=
sg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* one attribute of a policy: its id, which field of =
its descriptor to set,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * and the value to put there */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+struct attr_desc</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
int16_t attr_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 int field;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint=
32_t value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* a CTRL_ATTR_POLICY message describing `n`=
 attributes of one policy */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static struct nl_msg *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+msg_policy_attrs(uint32_t policy_id, const struct attr_desc *de=
scs, size_t n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nl_msg *msg =
=3D nlmsg_alloc();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct nlattr *policies, *policy, *attr;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_non_null(msg);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_non_null(genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, =
0, 0, 0, CTRL_CMD_GETPOLICY, 0));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p=
olicies =3D nla_nest_start(msg, CTRL_ATTR_POLICY);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    policy =3D nla_nest_start(msg, policy_id=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i=
 =3D 0; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        att=
r =3D nla_nest_start(msg, descs[i]=2Eattr_id);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        assert_int_equal(nla_put_u32(msg, descs[=
i]=2Efield, descs[i]=2Evalue), 0);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        nla_nest_end(msg, attr);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    nla_nest_end(msg, policy);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    nla_nest_end(msg, policies);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return msg;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* the shape the kerne=
l actually sends: one attribute per message */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static struct nl_msg *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+msg_policy_attr(uint32_t policy_id, uint16_t =
attr_id, int field, uint32_t value)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const struct attr_desc one =3D { attr_id, field, value };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return msg_policy_attrs(policy_id, &amp;one, 1);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+feed(struct ovpn_cap_query *query, struct nl_msg *msg)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(ovpn_cap_query_cb(msg, query=
), NL_OK);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nlmsg=
_free(msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* Walk the whole chain, with both policies c=
arrying attributes we are not</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * after and the ones we are neither first nor last, so that the =
pass has to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * skip =
past them rather than stop at the first mismatch=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+feed_full_chain(struct ovpn_cap_query *query)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const struct attr_desc cmd_attrs[] =
=3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { OVPN=
_A_IFINDEX, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U32 },</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        { OVPN_A_PEER, NL_POLICY_TYPE=
_ATTR_POLICY_IDX, SUB_POLICY },</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        { OVPN_A_KEYCONF, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYP=
E_NESTED },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct attr=
_desc sub_attrs[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        { OVPN_A_PEER_ID, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U32 },=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        { OVPN_A_PE=
ER_REMOTE_PORT, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U16 },</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        { test_req=2Etarget_attr,=
 NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U32 },</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        { OVPN_A_PEER_LOCAL_PORT, NL_POLICY_TYPE=
_ATTR_TYPE, NL_ATTR_TYPE_U16 },</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(query, msg_=
op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    feed(query, msg_policy_attrs(CMD_POLICY, cmd_att=
rs, SIZE(cmd_attrs)));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    feed(query, msg_policy_attrs(SUB_POLICY, sub_attrs, SIZE(sub_attrs))=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* the map tells us which policy validates the command=
 we asked about */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_read=
s_command_policy(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct ovpn_cap_query query =3D new_query();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    feed(&amp;query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(que=
ry=2Ecmd_policy, CMD_POLICY);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* and not about another on=
e, even though the dump is supposed to be filtered */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_ignores_other_command(void **state)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new_query(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_policy(O=
VPN_CMD_PEER_DEL, CMD_POLICY));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(query=2Ecmd_policy, -1);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* the nested attribute of that policy points at the sub-policy */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test_follows_nested_attribute(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query que=
ry =3D new_query();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query=
, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(CMD_POLIC=
Y, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                 SUB_POLICY));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(query=2Esub_policy, SUB_POLICY);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* an attribute id only=
 means something inside its own policy, so the same</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * number elsewhere says nothing about ou=
r question */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ignores_n=
ested_attribute_elsewhere(void **state)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct ovpn_cap_query query =3D new_query();</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    feed(&amp;query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLIC=
Y));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;q=
uery, msg_policy_attr(OTHER_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY=
_IDX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                   SUB_POLICY));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(query=2Esub_policy, -1);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* the type of the target attribute is read in the sub-policy */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_reads_target_type(void **state)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D n=
ew_query();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    feed_full_chain(&amp;qu=
ery);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(query=2Etype, NL_ATTR_TYPE_U32);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* and the same h=
olds for the target attribute: a type read off some other</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * policy is not an answer to what we=
 asked */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ignores_targe=
t_attribute_elsewhere(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct ovpn_cap_query query =3D new_query();</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    feed(&amp;query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query=
, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
             SUB_POLICY));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    feed(&amp;query, msg_policy_attr(OTHER_POLICY, test_req=2Etarget=
_attr, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                 NL_ATTR_TYPE_U32));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(query=2E=
type, -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* the command&#39;s own policy does get read,=
 so the target attribute has to be</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * turned away there too: the same id there is a different a=
ttribute */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ignores_tar=
get_attribute_in_command_policy(void **state)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct ovpn_cap_query query =3D new_query();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    feed(&amp;query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD=
_POLICY));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(=
&amp;query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_PO=
LICY_IDX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                       SUB_POLICY));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, test_req=
=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                 NL_ATTR_TYPE_U32));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(query=2Etype, -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* the sub-policy is read too, so the=
 nested attribute has to be turned away</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * there as well */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+test_ignores_nested_attribute_in_sub_policy(void **state)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new_q=
uery();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_pol=
icy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, OVPN_A_PE=
ER, NL_POLICY_TYPE_ATTR_POLICY_IDX,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                 SUB_POLICY));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_=
attr(SUB_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
OTHER_POLICY));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(query=2Esub_policy, SUB_POLICY);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* an a=
ttribute that is there but not as a nest has nothing to follow */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_nested_attribute_without_policy_=
idx(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_=
query query =3D new_query();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&=
amp;query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(=
CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                 NL_ATTR_TYP=
E_U32));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(query=2Esub_policy, -1);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* and one that is a n=
est says nothing about the type we are after */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+test_target_attribute_without_type(void **state)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new_quer=
y();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_op_policy=
(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER,=
 NL_POLICY_TYPE_ATTR_POLICY_IDX,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                 SUB_POLICY));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_att=
r(SUB_POLICY, test_req=2Etarget_attr,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                 NL_POLICY_TYPE_ATTR_POLI=
CY_IDX, OTHER_POLICY));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(query=2Etype, -1);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* a policy w=
e cannot place yet is counted, one we walk past afterwards is not */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+test_counts_only_what_it_could_not=
_place(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_c=
ap_query query =3D new_query();</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fee=
d(&amp;query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_at=
tr(OTHER_POLICY, OVPN_A_PEER_ID, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                 NL_=
ATTR_TYPE_U32));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(query=2Eunclassified, 1);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    feed(&amp;query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLIC=
Y_TYPE_ATTR_POLICY_IDX,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                 SUB_POLICY));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(OTHER_P=
OLICY, OVPN_A_PEER_ID, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                 NL_ATTR_TYPE_=
U32));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(query=2Eunclassified, 1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* a flat requirement n=
eeds no hop: the command&#39;s policy is where to look */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+test_flat_requirement_reads_command_policy(vo=
id **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_query =
query =3D new_query_for(&amp;flat_req);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    feed(&amp;query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(query=
=2Esub_policy, CMD_POLICY);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&a=
mp;query, msg_policy_attr(CMD_POLICY, flat_req=2Etarget_attr, NL_POLICY_TYP=
E_ATTR_TYPE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                          NL_ATTR_TYPE_U32));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(ovpn_cap_resolve(&amp;query)=
, OVPN_CAP_SUPPORTED);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* and an absent one is a plain no=
, with nothing left unclassified */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_flat_requirement_absent_is_unsupported(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new_query_f=
or(&amp;flat_req);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    feed(&amp;query,=
 msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    feed(&amp;query, msg_policy_attr(OTHER_POLI=
CY, flat_req=2Etarget_attr, NL_POLICY_TYPE_ATTR_TYPE,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                 NL_ATTR_=
TYPE_U32));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(query=2Eunclassified, 0);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(ovpn_cap_resolve(&amp;query), OVPN_=
CAP_UNSUPPORTED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* nothing to read an answer out of is =
not the same as a &quot;no&quot; */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_resolve_without_command_policy(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new_query();</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(ovpn_cap_resolve(&amp;qu=
ery), OVPN_CAP_UNKNOWN);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* a kernel that does not nest t=
he attribute simply never mentions it */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+test_resolve_nested_absent(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct ovpn_cap_query query =3D new_query();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    query=2Ecmd_policy =3D CMD_POLICY;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ovpn_cap_=
resolve(&amp;query), OVPN_CAP_UNSUPPORTED);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* unless the=
 dump went by in an order we could not follow, in which case we</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * did not find out either way =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test_resolve_incomplete_a=
fter_skipping(void **state)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 ovpn_cap_query query =3D new_query();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    query=2Ecmd_policy =3D CMD_POLICY;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    query=2Eunclassified =3D 1;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(ovpn_cap_resolve(&amp;q=
uery), OVPN_CAP_UNKNOWN);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* the sub-policy is there but =
does not define the attribute: the ordinary no */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+test_resolve_target_absent(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct ovpn_cap_query query =3D new_query();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    query=2Ecmd_policy =3D CMD_POLICY;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    query=2Esub_polic=
y =3D SUB_POLICY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(ovpn_cap_resolve(&amp;query), OVPN_CAP_UNSUPPORTED);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* right name, wrong type: not the attribute we would be wri=
ting */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_resolve_wrong_t=
ype(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ovpn_cap_=
query query =3D new_query();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    query=
=2Ecmd_policy =3D CMD_POLICY;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    query=2Esub_policy =3D SUB_POLICY;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    query=2Etype =3D NL_ATTR_TYPE_U8;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ovpn_ca=
p_resolve(&amp;query), OVPN_CAP_UNSUPPORTED);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* and the =
whole chain, from a dump to a yes */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+test_resolve_complete_chain(void **state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct ovpn_cap_query query =3D new_query();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    feed_full_chain(&amp;query);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(query=2Eunclassifi=
ed, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(ovpn_cap_resolve(&amp;query), OVPN_CAP_SUPPORTED);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+main(void)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const struct CMUnitTest tests[] =3D =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_reads_command_policy),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_ignores_other_command),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(t=
est_follows_nested_attribute),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_ignores_nested_attribute_elsewhere=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_un=
it_test(test_reads_target_type),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        cmocka_unit_test(test_ignores_target_attribute_elsewhe=
re),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_=
unit_test(test_ignores_target_attribute_in_command_policy),</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_ignor=
es_nested_attribute_in_sub_policy),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cmocka_unit_test(test_nested_attribute_without_poli=
cy_idx),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmo=
cka_unit_test(test_target_attribute_without_type),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_counts_only_wh=
at_it_could_not_place),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_flat_requirement_reads_command_policy),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_t=
est(test_flat_requirement_absent_is_unsupported),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_resolve_without=
_command_policy),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cmocka_unit_test(test_resolve_nested_absent),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_resolve_inc=
omplete_after_skipping),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmocka_unit_test(test_resolve_target_absent),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_resolv=
e_wrong_type),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   cmocka_unit_test(test_resolve_complete_chain),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return cmocka_run_group_tests_name(&quot;dco&quot;, tests, NULL, NULL);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br></pre><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?u=
sp=3Demail">change 1981</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1981?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1981 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-=
Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>

</body></html>
--/qqjXR15QNo=--


--===============1839594364505309834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1839594364505309834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1839594364505309834==--

