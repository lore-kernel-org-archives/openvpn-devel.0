Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A545606A327
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=mHDzbSeG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XGiLOq2E;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=f9qe5a9m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=LKKUxAx1bRVelA0+iahy/OgvYgPT09EwrggjQiqIYVg=; b=mHDzbSeGqa/ZmR
	LOR8ia5bPyLTqWY+Ddi4dhwoGbPIMgln7ErcwCncjd0Vkp7bOu1hdXR+9BvRvwQ4LGvsEwOXaf3Zj
	PZk5ZvQK2Jxmf9dmhBus61uXZ1GeQGVVSuNEfOfr/ZAJvrza4Zcxqx40Nive+8K2pehMMpPdDGsKa
	K2c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWwBU-000000003IV-2C63;
	Fri, 27 Nov 2026 13:40:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xWwBU-000000003IM-015S for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 13:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sEybQB1u4jwndLI/MZdL910inyJgstMkpAAe16Mb9Qc=; b=XGiLOq2EO462s22BE+Tl6ZYdWN
 8Y71uWpbaOMru90UZ9p8kF5aC55CyfxrKJTLV7Jb0Ot7ipkF7KQAbNzESJn/a46QaRYQ6ZsFBj/0M
 znpOjQHCJStAOxgyNUhYLYolYsb8zYwGYVvCFHjmjQmTvHkM5nicsRDr7rn30YhD1VqU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sEybQB1u4jwndLI/MZdL910inyJgstMkpAAe16Mb9Qc=; b=f9qe5a9mJj2xaLEiLPdv2BoPEO
 2hZUI3zPYyEuqe3r3LjOvCsiklLlIYSvL+inPVRkEohC10Ekr9Tcb2U3hzhG27aYXhRcfEKOpcAfW
 8Fl3GYbbwiOmJSHRoB8VTXLd8J96wLeF6V9fdyI91VloNuSbU8yh5CRzqokEedgCgtSc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWwBQ-000000001lL-3lR9 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 13:40:15 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ARDe60M030777
 for <openvpn-devel@lists.sourceforge.net>; Fri, 27 Nov 2026 14:40:06 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ARDe62i030776
 for openvpn-devel@lists.sourceforge.net; Fri, 27 Nov 2026 14:40:06 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 27 Nov 2026 14:40:00 +0100
Message-ID: <20261127134006.30729-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
References: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xWwBQ-000000001lL-3lR9
Subject: [Openvpn-devel] [PATCH v4] dco: detect local kernel capabilities
 through netlink policies
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Gianmarco De Gregori <gianmarco@mandelbit.com>

The ovpn module lives in the kernel, so the attributes it accepts may
differ from what we were built against. CTRL_CMD_GETPOLICY dumps the
validation policy of a family: which attributes each command takes, of
what type, and for a nested one the sub-policy that validates it.

Add a helper to query it, wrapped in dco_probe_capabilities() so the
rest of the tree never talks to netlink itself. Answering a requirement
means following a chain - which policy validates the command, where its
nested attribute points if it has one, what type the target attribute
has there. One dump of the whole family answers every requirement: it is
recorded as it arrives and the chains are followed once it is complete.

The answer has three values rather than two: without "could not ask", a
netlink error would look the same as a kernel without the feature.

The query needs uapi headers from 5.10 or later. Built against older
ones, it is left out and dco_probe_capabilities() reports no capability.

No capability is defined yet, so the bitmap comes back empty; the rows
that fill it arrive with the features that need them. The unit test
feeds hand-built dumps to the pass and checks what each requirement
resolves to.

Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Ralf Lici <ralf@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1981

---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1981
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Ralf Lici <ralf@mandelbit.com>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 50b2d68..bb2ea0c 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -19,6 +19,7 @@
 include(CheckLinkerFlag OPTIONAL)
 include(CheckTypeSize)
 include(CheckStructHasMember)
+include(CheckCSourceCompiles)
 include(CTest)
 
 option(UNSUPPORTED_BUILDS "Allow unsupported builds" OFF)
@@ -205,6 +206,11 @@
     check_symbol_exists(getpeereid "unistd.h;sys/socket.h" HAVE_GETPEEREID)
 endif()
 
+if (ENABLE_LINUXDCO)
+    check_c_source_compiles("#include <linux/genetlink.h>
+int main(void) { return CTRL_ATTR_OP_POLICY; }" HAVE_DECL_CTRL_ATTR_OP_POLICY)
+endif ()
+
 check_include_files(grp.h HAVE_GRP_H)
 if (HAVE_GRP_H)
     check_symbol_exists(getgrnam grp.h HAVE_GETGRNAM)
@@ -728,6 +734,12 @@
             )
     endif ()
 
+    if (ENABLE_LINUXDCO AND HAVE_DECL_CTRL_ATTR_OP_POLICY)
+        list(APPEND unit_tests
+            "test_dco"
+            )
+    endif ()
+
     if (NOT WIN32 AND ${ENABLE_PKCS11})
         set(_HAVE_SOFTHSM2 YES)
         find_program(P11TOOL p11tool)
@@ -969,6 +981,14 @@
             )
     endif ()
 
+    if (TARGET test_dco)
+        target_sources(test_dco PRIVATE
+            tests/unit_tests/openvpn/mock_dco_dependencies.c
+            tests/unit_tests/openvpn/mock_get_random.c
+            src/openvpn/fdmisc.c
+            )
+    endif ()
+
     target_compile_definitions(test_dhcp PRIVATE DHCP_UNIT_TEST)
     target_sources(test_dhcp PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
diff --git a/config.h.cmake.in b/config.h.cmake.in
index f7818cf..aa21532 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -87,6 +87,9 @@
 /* Define to 1 if you have the `daemon' function. */
 #cmakedefine HAVE_DAEMON
 
+/* Define to 1 if linux/genetlink.h has netlink policy introspection (5.10) */
+#cmakedefine01 HAVE_DECL_CTRL_ATTR_OP_POLICY
+
 /* Define to 1 if you have the <direct.h> header file. */
 #cmakedefine HAVE_DIRECT_H
 
diff --git a/configure.ac b/configure.ac
index 05fa964..ef05253 100644
--- a/configure.ac
+++ b/configure.ac
@@ -664,6 +664,7 @@
 		;;
 esac
 
+dco_unit_tests="no"
 if test "$enable_dco" != "no"; then
 	enable_dco_arg="$enable_dco"
 	if test "${enable_iproute2}" = "yes"; then
@@ -692,6 +693,12 @@
 				OPTIONAL_LIBNL_GENL_CFLAGS="${LIBNL_GENL_CFLAGS}"
 				OPTIONAL_LIBNL_GENL_LIBS="${LIBNL_GENL_LIBS}"
 
+				dnl
+				dnl Netlink policy introspection needs uapi headers from 5.10
+				dnl
+				AC_CHECK_DECLS([CTRL_ATTR_OP_POLICY], , , [[#include <linux/genetlink.h>]])
+				dco_unit_tests="${ac_cv_have_decl_CTRL_ATTR_OP_POLICY}"
+
 				AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
 				AC_MSG_NOTICE([Enabled ovpn-dco (via ovpn kernel module) support for Linux])
 			fi
@@ -1340,6 +1347,7 @@
 AC_SUBST([PLUGIN_AUTH_PAM_LIBS])
 
 AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
+AM_CONDITIONAL([DCO_UNIT_TESTS], [test "${dco_unit_tests}" = "yes"])
 AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" = "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pam}" = "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_root}" = "yes"])
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index c435f8c..b0a8621 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -254,6 +254,17 @@
  */
 bool
 dco_supports_epoch_data(const struct context *c);
+
+/**
+ * Return a bitmap of DCO_CAP_* bits describing the negotiable features the
+ * local kernel supports. Everything DCO does without negotiating is available
+ * regardless. Resolved once and reused; platforms without capability probing
+ * return 0.
+ *
+ * @return  bitmask of DCO_CAP_* flags; 0 both when the kernel supports none
+ *          of them and when it could not be asked
+ */
+unsigned int dco_probe_capabilities(void);
 #else  /* if defined(ENABLE_DCO) */
 
 typedef void *dco_context_t;
@@ -388,5 +399,11 @@
 {
     return false;
 }
+
+static inline unsigned int
+dco_probe_capabilities(void)
+{
+    return 0;
+}
 #endif /* defined(ENABLE_DCO) */
 #endif /* ifndef DCO_H */
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 11b8dff..9613c63 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -707,6 +707,12 @@
     return 0;
 }
 
+unsigned int
+dco_probe_capabilities(void)
+{
+    return 0;
+}
+
 bool
 dco_available(msglvl_t msglevel)
 {
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 3a55b6e..fefc517 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -103,6 +103,361 @@
     return ret;
 }
 
+/* What the local kernel supports. It cannot change while we run, so the first
+ * caller resolves it and the rest just read it. */
+static unsigned int dco_caps = 0;
+static bool dco_caps_resolved = false;
+
+#if HAVE_DECL_CTRL_ATTR_OP_POLICY
+/*
+ * Netlink policy introspection: the ovpn module lives in the kernel, so the
+ * attributes it accepts may differ from what we were built against.
+ * CTRL_CMD_GETPOLICY says which attributes each command takes and of what type.
+ */
+
+/* One row per capability, all resolved from the same dump. A row can
+ * only ask for an attribute the dump reports: UNSPEC and REJECT ones never
+ * appear, and before Linux 7.4 neither do BE16/BE32 ones (b785f5c56fb3). */
+struct ovpn_cap_req
+{
+    unsigned int cap;
+    uint16_t cmd;
+    uint16_t nested_attr; /* 0 if target_attr is not nested */
+    uint16_t target_attr;
+    int expected_type;
+};
+
+/** the outcome of resolving one capability requirement */
+enum ovpn_cap_status
+{
+    OVPN_CAP_UNKNOWN,     /**< the question could not be asked */
+    OVPN_CAP_SUPPORTED,   /**< the kernel accepts the attribute */
+    OVPN_CAP_UNSUPPORTED, /**< the kernel answered, and does not accept it */
+};
+
+/* The command map is kept with the policies under this index: there `id` is a
+ * command and `nested` the policy of its doit. -1 means "not reported". */
+#define OVPN_CAP_CMD_MAP (-2)
+
+/* ovpn on Linux 7.3 reports 77 links */
+#define OVPN_CAP_INITIAL_LINKS 128
+
+/* inside `policy`, attribute `id` has type `type` and, if nested, is
+ * validated by policy `nested` */
+struct ovpn_cap_link
+{
+    int policy;
+    uint16_t id;
+    int type;
+    int nested;
+};
+
+struct ovpn_cap_query
+{
+    struct ovpn_cap_link *links;
+    size_t n_links;
+    size_t max_links;
+
+    bool cmd_map; /* the dump carried a command map */
+    int err;      /* a message we could not parse, or no memory to record it */
+};
+
+static struct nla_policy ovpn_cap_ctrl_policy[CTRL_ATTR_MAX + 1] = {
+    [CTRL_ATTR_POLICY] = { .type = NLA_NESTED },
+    [CTRL_ATTR_OP_POLICY] = { .type = NLA_NESTED },
+};
+
+static struct nla_policy ovpn_cap_op_policy[CTRL_ATTR_POLICY_DUMP_MAX + 1] = {
+    [CTRL_ATTR_POLICY_DO] = { .type = NLA_U32 },
+};
+
+static struct nla_policy ovpn_cap_attr_policy[NL_POLICY_TYPE_ATTR_MAX + 1] = {
+    [NL_POLICY_TYPE_ATTR_TYPE] = { .type = NLA_U32 },
+    [NL_POLICY_TYPE_ATTR_POLICY_IDX] = { .type = NLA_U32 },
+};
+
+static int
+ovpn_cap_add_link(struct ovpn_cap_query *query, int policy, uint16_t id, int type, int nested)
+{
+    if (query->n_links == query->max_links)
+    {
+        size_t max_links = query->max_links ? 2 * query->max_links : OVPN_CAP_INITIAL_LINKS;
+        struct ovpn_cap_link *links = realloc(query->links, max_links * sizeof(*links));
+        if (!links)
+        {
+            return -NLE_NOMEM;
+        }
+
+        query->links = links;
+        query->max_links = max_links;
+    }
+
+    query->links[query->n_links++] = (struct ovpn_cap_link){ policy, id, type, nested };
+
+    return 0;
+}
+
+static const struct ovpn_cap_link *
+ovpn_cap_find(const struct ovpn_cap_query *query, int policy, uint16_t id)
+{
+    for (size_t i = 0; i < query->n_links; i++)
+    {
+        if (query->links[i].policy == policy && query->links[i].id == id)
+        {
+            return &query->links[i];
+        }
+    }
+
+    return NULL;
+}
+
+/*
+ * One message of the dump carries either the command map or a slice of one
+ * policy. Everything is recorded and the chain is followed only once the
+ * dump is complete, so the order of the messages does not matter.
+ */
+static int
+ovpn_cap_query_cb(struct nl_msg *msg, void *arg)
+{
+    struct ovpn_cap_query *query = arg;
+    struct nlattr *tb[CTRL_ATTR_MAX + 1];
+    const struct genlmsghdr *ghdr = nlmsg_data(nlmsg_hdr(msg));
+
+    query->err = nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(ghdr, 0),
+                           genlmsg_attrlen(ghdr, 0), ovpn_cap_ctrl_policy);
+    if (query->err)
+    {
+        return NL_STOP;
+    }
+
+    /* CTRL_ATTR_OP_POLICY: which policy validates the doit of each command */
+    if (tb[CTRL_ATTR_OP_POLICY])
+    {
+        const struct nlattr *nla_cmd;
+        int rem_cmd;
+
+        query->cmd_map = true;
+
+        nla_for_each_nested(nla_cmd, tb[CTRL_ATTR_OP_POLICY], rem_cmd)
+        {
+            struct nlattr *tb_cmd[CTRL_ATTR_POLICY_DUMP_MAX + 1];
+
+            query->err = nla_parse(tb_cmd, CTRL_ATTR_POLICY_DUMP_MAX, nla_data(nla_cmd),
+                                   nla_len(nla_cmd), ovpn_cap_op_policy);
+            if (query->err)
+            {
+                return NL_STOP;
+            }
+
+            if (tb_cmd[CTRL_ATTR_POLICY_DO])
+            {
+                query->err = ovpn_cap_add_link(query, OVPN_CAP_CMD_MAP, (uint16_t)nla_type(nla_cmd),
+                                               -1, (int)nla_get_u32(tb_cmd[CTRL_ATTR_POLICY_DO]));
+                if (query->err)
+                {
+                    return NL_STOP;
+                }
+            }
+        }
+    }
+
+    /* CTRL_ATTR_POLICY: which attributes each policy accepts */
+    if (!tb[CTRL_ATTR_POLICY])
+    {
+        return NL_OK;
+    }
+
+    const struct nlattr *nla_policy;
+    int rem_policy;
+
+    nla_for_each_nested(nla_policy, tb[CTRL_ATTR_POLICY], rem_policy)
+    {
+        struct nlattr *nla_attr;
+        int rem_attr;
+        int policy_id = nla_type(nla_policy);
+
+        nla_for_each_nested(nla_attr, nla_policy, rem_attr)
+        {
+            struct nlattr *tb_attr[NL_POLICY_TYPE_ATTR_MAX + 1];
+            int attr_id = nla_type(nla_attr);
+            int type = -1;
+            int nested = -1;
+
+            query->err = nla_parse_nested(tb_attr, NL_POLICY_TYPE_ATTR_MAX, nla_attr,
+                                          ovpn_cap_attr_policy);
+            if (query->err)
+            {
+                return NL_STOP;
+            }
+
+            if (tb_attr[NL_POLICY_TYPE_ATTR_TYPE])
+            {
+                type = (int)nla_get_u32(tb_attr[NL_POLICY_TYPE_ATTR_TYPE]);
+            }
+            if (tb_attr[NL_POLICY_TYPE_ATTR_POLICY_IDX])
+            {
+                nested = (int)nla_get_u32(tb_attr[NL_POLICY_TYPE_ATTR_POLICY_IDX]);
+            }
+
+            query->err = ovpn_cap_add_link(query, policy_id, (uint16_t)attr_id, type, nested);
+            if (query->err)
+            {
+                return NL_STOP;
+            }
+        }
+    }
+
+    return NL_OK;
+}
+
+/* Dump the policies of the family into query->links. Returns 0, or the
+ * netlink error that kept us from reading it all. */
+static int
+ovpn_cap_ask(struct ovpn_cap_query *query)
+{
+    struct nl_msg *nl_msg = NULL;
+    int ret = 0;
+
+    struct nl_sock *nl_sock = nl_socket_alloc();
+    if (!nl_sock)
+    {
+        return -NLE_NOMEM;
+    }
+
+    ret = genl_connect(nl_sock);
+    if (ret < 0)
+    {
+        goto out;
+    }
+    set_cloexec(nl_socket_get_fd(nl_sock));
+
+    nl_msg = nlmsg_alloc();
+    if (!nl_msg)
+    {
+        ret = -NLE_NOMEM;
+        goto out;
+    }
+
+    /* nlctrl has a fixed family id, so there is nothing to resolve first.
+     * Unlike CTRL_CMD_GETFAMILY, CTRL_CMD_GETPOLICY does not load the module:
+     * this relies on dco_available() having resolved the family already. */
+    if (!genlmsg_put(nl_msg, NL_AUTO_PORT, NL_AUTO_SEQ, GENL_ID_CTRL, 0, NLM_F_DUMP,
+                     CTRL_CMD_GETPOLICY, 0))
+    {
+        ret = -NLE_MSGSIZE;
+        goto out;
+    }
+
+    ret = nla_put_string(nl_msg, CTRL_ATTR_FAMILY_NAME, OVPN_FAMILY_NAME);
+    if (ret < 0)
+    {
+        goto out;
+    }
+
+    ret = nl_socket_modify_cb(nl_sock, NL_CB_VALID, NL_CB_CUSTOM, ovpn_cap_query_cb, query);
+    if (ret < 0)
+    {
+        goto out;
+    }
+
+    ret = nl_send_auto(nl_sock, nl_msg);
+    if (ret < 0)
+    {
+        goto out;
+    }
+
+    ret = nl_recvmsgs_default(nl_sock);
+    if (ret >= 0)
+    {
+        ret = query->err;
+    }
+
+out:
+    nlmsg_free(nl_msg);
+    nl_socket_free(nl_sock);
+
+    return ret < 0 ? ret : 0;
+}
+
+/*
+ * Decide whether the kernel supports the requirement, from the links the pass
+ * collected. A link the kernel never mentioned is a no. A dump without a
+ * command map is not an answer either way, and is reported as such, but the
+ * capability stays off just the same.
+ */
+static enum ovpn_cap_status
+ovpn_cap_resolve(const struct ovpn_cap_query *query, const struct ovpn_cap_req *req)
+{
+    /* no command map: the dump cannot say which policy validates the command */
+    if (!query->cmd_map)
+    {
+        return OVPN_CAP_UNKNOWN;
+    }
+
+    /* a link is missing: the command, the container or the target is not there */
+    const struct ovpn_cap_link *link = ovpn_cap_find(query, OVPN_CAP_CMD_MAP, req->cmd);
+    if (link && req->nested_attr)
+    {
+        link = ovpn_cap_find(query, link->nested, req->nested_attr);
+    }
+    if (link)
+    {
+        link = ovpn_cap_find(query, link->nested, req->target_attr);
+    }
+    if (!link)
+    {
+        return OVPN_CAP_UNSUPPORTED;
+    }
+
+    /* the whole chain is there: a yes only if the attribute has the type we
+     * would be writing into it */
+    return (link->type == req->expected_type) ? OVPN_CAP_SUPPORTED : OVPN_CAP_UNSUPPORTED;
+}
+
+unsigned int
+dco_probe_capabilities(void)
+{
+    if (dco_caps_resolved)
+    {
+        return dco_caps;
+    }
+
+    /* no capability is defined yet: resolve one whose answer we already know */
+    static const struct ovpn_cap_req self_test = { 0, OVPN_CMD_PEER_NEW, OVPN_A_PEER,
+                                                   OVPN_A_PEER_ID, NL_ATTR_TYPE_U32 };
+    struct ovpn_cap_query query;
+    CLEAR(query);
+    int err = ovpn_cap_ask(&query);
+    enum ovpn_cap_status status = err ? OVPN_CAP_UNKNOWN : ovpn_cap_resolve(&query, &self_test);
+    free(query.links);
+
+    msg(D_DCO_DEBUG, "%s: policy introspection self-test: %s (status %d, err %d)", __func__,
+        status == OVPN_CAP_SUPPORTED ? "ok" : "unexpected", (int)status, err);
+
+    dco_caps_resolved = true;
+    msg(D_DCO_DEBUG, "%s: DCO local capabilities: 0x%x", __func__, dco_caps);
+
+    return dco_caps;
+}
+
+#else  /* if HAVE_DECL_CTRL_ATTR_OP_POLICY */
+
+unsigned int
+dco_probe_capabilities(void)
+{
+    if (!dco_caps_resolved)
+    {
+        msg(D_DCO_DEBUG,
+            "%s: built without netlink policy introspection, no DCO capability can be detected",
+            __func__);
+        dco_caps_resolved = true;
+    }
+
+    return dco_caps;
+}
+
+#endif /* if HAVE_DECL_CTRL_ATTR_OP_POLICY */
+
 static struct nl_msg *
 ovpn_dco_nlmsg_create(const dco_context_t *dco, uint8_t cmd)
 {
@@ -428,6 +783,12 @@
 {
     dco->ovpn_dco_id = resolve_ovpn_netlink_id(M_FATAL);
 
+    /* nothing consumes the bitmap yet; resolve it here to exercise the path */
+    if (check_debug_level(D_DCO_DEBUG))
+    {
+        dco_probe_capabilities();
+    }
+
     dco->nl_sock = nl_socket_alloc();
 
     if (!dco->nl_sock)
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 6074552..0f2b9eb 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -612,6 +612,12 @@
     return 0;
 }
 
+unsigned int
+dco_probe_capabilities(void)
+{
+    return 0;
+}
+
 bool
 dco_available(msglvl_t msglevel)
 {
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index e3404754..d1dfac9 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -40,6 +40,12 @@
 endif
 endif
 
+if HAVE_SITNL
+if DCO_UNIT_TESTS
+test_binaries += dco_testdriver
+endif
+endif
+
 if !CROSS_COMPILING
 TESTS = $(test_binaries)
 endif
@@ -452,4 +458,16 @@
 	$(top_srcdir)/src/openvpn/run_command.c \
 	$(top_srcdir)/src/openvpn/socket_util.c
 
+dco_testdriver_CFLAGS  = \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
+	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO_CFLAGS)
+dco_testdriver_LDFLAGS = @TEST_LDFLAGS@ $(OPTIONAL_CRYPTO_LIBS)
+dco_testdriver_SOURCES = test_dco.c \
+	mock_msg.c mock_msg.h mock_dco_dependencies.c mock_get_random.c test_common.h \
+	$(top_srcdir)/src/compat/compat-strlcpy.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/fdmisc.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/win32-util.c
+
 build-tests-local: $(check_PROGRAMS)
diff --git a/tests/unit_tests/openvpn/mock_dco_dependencies.c b/tests/unit_tests/openvpn/mock_dco_dependencies.c
new file mode 100644
index 0000000..e7f20f5
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_dco_dependencies.c
@@ -0,0 +1,80 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *  Copyright (C) 2026 Gianmarco De Gregori <gianmarco@mandelbit.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+/*
+ *  Stubs for what dco_linux.c drags in but capability probing never reaches:
+ *  the data path, the event loop and the signal machinery.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+#include "dco.h"
+#include "crypto_backend.h"
+#include "forward.h"
+#include "multi.h"
+#include "networking.h"
+#include "socket_util.h"
+
+void
+multi_process_incoming_dco(dco_context_t *dco)
+{
+}
+
+void
+process_incoming_dco(dco_context_t *dco)
+{
+}
+
+void
+register_signal(struct signal_info *si, int signum, const char *signal_text)
+{
+}
+
+int
+net_iface_new(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const char *type,
+              const void *arg)
+{
+    return 0;
+}
+
+int
+net_iface_del(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface)
+{
+    return 0;
+}
+
+unsigned int
+cipher_kt_key_size(const char *ciphername)
+{
+    return 0;
+}
+
+const char *
+print_sockaddr_ex(const struct sockaddr *addr, const char *separator, const unsigned int flags,
+                  struct gc_arena *gc)
+{
+    return "[mock]";
+}
diff --git a/tests/unit_tests/openvpn/test_dco.c b/tests/unit_tests/openvpn/test_dco.c
new file mode 100644
index 0000000..bd874bf
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_dco.c
@@ -0,0 +1,487 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *  Copyright (C) 2026 Gianmarco De Gregori <gianmarco@mandelbit.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+/*
+ *  Unit tests for the DCO capability queries.
+ *
+ *  Resolving a requirement is a pass over a policy dump that records what it
+ *  reports, followed by a walk along what the pass recorded. The pass is fed
+ *  dumps built by hand, which cover what would otherwise need a particular
+ *  kernel.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include <stdarg.h>
+#include <setjmp.h>
+#include <cmocka.h>
+
+#include "dco_linux.c"
+
+#define CMD_POLICY   4
+#define SUB_POLICY   9
+#define OTHER_POLICY 7
+
+/* the bit is never read here, only the chain that would set it */
+static const struct ovpn_cap_req test_req = { .cap = 1u,
+                                              .cmd = OVPN_CMD_PEER_NEW,
+                                              .nested_attr = OVPN_A_PEER,
+                                              .target_attr = OVPN_A_PEER_KEEPALIVE_INTERVAL,
+                                              .expected_type = NL_ATTR_TYPE_U32 };
+
+/* the same requirement without a container: the target sits in the command's
+ * own policy */
+static const struct ovpn_cap_req flat_req = { .cap = 1u,
+                                              .cmd = OVPN_CMD_PEER_NEW,
+                                              .nested_attr = 0,
+                                              .target_attr = OVPN_A_IFINDEX,
+                                              .expected_type = NL_ATTR_TYPE_U32 };
+
+static struct ovpn_cap_query
+new_query(void)
+{
+    struct ovpn_cap_query query;
+
+    CLEAR(query);
+    return query;
+}
+
+/* a CTRL_ATTR_OP_POLICY message saying which policy validates `cmd` */
+static struct nl_msg *
+msg_op_policy(uint16_t cmd, uint32_t do_policy)
+{
+    struct nl_msg *msg = nlmsg_alloc();
+    struct nlattr *ops, *op;
+
+    assert_non_null(msg);
+    assert_non_null(genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, 0, 0, 0, CTRL_CMD_GETPOLICY, 0));
+
+    ops = nla_nest_start(msg, CTRL_ATTR_OP_POLICY);
+    op = nla_nest_start(msg, cmd);
+    assert_int_equal(nla_put_u32(msg, CTRL_ATTR_POLICY_DO, do_policy), 0);
+    nla_nest_end(msg, op);
+    nla_nest_end(msg, ops);
+
+    return msg;
+}
+
+/* one attribute of a policy: its id, which field of its descriptor to set,
+ * and the value to put there */
+struct attr_desc
+{
+    uint16_t attr_id;
+    int field;
+    uint32_t value;
+};
+
+/* a CTRL_ATTR_POLICY message describing `n` attributes of one policy */
+static struct nl_msg *
+msg_policy_attrs(uint16_t policy_id, const struct attr_desc *descs, size_t n)
+{
+    struct nl_msg *msg = nlmsg_alloc();
+    struct nlattr *policies, *policy, *attr;
+
+    assert_non_null(msg);
+    assert_non_null(genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, 0, 0, 0, CTRL_CMD_GETPOLICY, 0));
+
+    policies = nla_nest_start(msg, CTRL_ATTR_POLICY);
+    policy = nla_nest_start(msg, policy_id);
+    for (size_t i = 0; i < n; i++)
+    {
+        attr = nla_nest_start(msg, descs[i].attr_id);
+        assert_int_equal(nla_put_u32(msg, descs[i].field, descs[i].value), 0);
+        nla_nest_end(msg, attr);
+    }
+    nla_nest_end(msg, policy);
+    nla_nest_end(msg, policies);
+
+    return msg;
+}
+
+/* the shape the kernel actually sends: one attribute per message */
+static struct nl_msg *
+msg_policy_attr(uint16_t policy_id, uint16_t attr_id, int field, uint32_t value)
+{
+    const struct attr_desc one = { attr_id, field, value };
+
+    return msg_policy_attrs(policy_id, &one, 1);
+}
+
+static void
+feed(struct ovpn_cap_query *query, struct nl_msg *msg)
+{
+    assert_int_equal(ovpn_cap_query_cb(msg, query), NL_OK);
+    nlmsg_free(msg);
+}
+
+/* Walk the whole chain, with both policies carrying attributes we are not
+ * after and the ones we are neither first nor last, so that the pass has to
+ * skip past them rather than stop at the first mismatch. */
+static void
+feed_full_chain(struct ovpn_cap_query *query)
+{
+    const struct attr_desc cmd_attrs[] = {
+        { OVPN_A_IFINDEX, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U32 },
+        { OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX, SUB_POLICY },
+        { OVPN_A_KEYCONF, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_NESTED },
+    };
+    const struct attr_desc sub_attrs[] = {
+        { OVPN_A_PEER_ID, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U32 },
+        { OVPN_A_PEER_REMOTE_PORT, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U16 },
+        { test_req.target_attr, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U32 },
+        { OVPN_A_PEER_LOCAL_PORT, NL_POLICY_TYPE_ATTR_TYPE, NL_ATTR_TYPE_U16 },
+    };
+
+    feed(query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(query, msg_policy_attrs(CMD_POLICY, cmd_attrs, SIZE(cmd_attrs)));
+    feed(query, msg_policy_attrs(SUB_POLICY, sub_attrs, SIZE(sub_attrs)));
+}
+
+/* the map tells us which policy validates the command we asked about */
+static void
+test_reads_command_policy(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    const struct ovpn_cap_link *link = ovpn_cap_find(&query, OVPN_CAP_CMD_MAP, OVPN_CMD_PEER_NEW);
+    assert_non_null(link);
+    assert_int_equal(link->nested, CMD_POLICY);
+    free(query.links);
+}
+
+/* and not about another one */
+static void
+test_ignores_other_command(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_DEL, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                                 SUB_POLICY));
+    feed(&query, msg_policy_attr(SUB_POLICY, test_req.target_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL_ATTR_TYPE_U32));
+    assert_int_equal(ovpn_cap_resolve(&query, &test_req), OVPN_CAP_UNSUPPORTED);
+    free(query.links);
+}
+
+/* the nested attribute of that policy points at the sub-policy */
+static void
+test_follows_nested_attribute(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                                 SUB_POLICY));
+    const struct ovpn_cap_link *link = ovpn_cap_find(&query, CMD_POLICY, OVPN_A_PEER);
+    assert_non_null(link);
+    assert_int_equal(link->nested, SUB_POLICY);
+    free(query.links);
+}
+
+/* an attribute id only means something inside its own policy, so the same
+ * number elsewhere says nothing about our question: a command policy without
+ * the container is a no, whatever comes after it */
+static void
+test_ignores_nested_attribute_elsewhere(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_A_IFINDEX, NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL_ATTR_TYPE_U32));
+    feed(&query, msg_policy_attr(OTHER_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                                 SUB_POLICY));
+    feed(&query, msg_policy_attr(SUB_POLICY, test_req.target_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL_ATTR_TYPE_U32));
+    assert_int_equal(ovpn_cap_resolve(&query, &test_req), OVPN_CAP_UNSUPPORTED);
+    free(query.links);
+}
+
+/* the type of the target attribute is read in the sub-policy */
+static void
+test_reads_target_type(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    feed_full_chain(&query);
+    const struct ovpn_cap_link *link = ovpn_cap_find(&query, SUB_POLICY, test_req.target_attr);
+    assert_non_null(link);
+    assert_int_equal(link->type, NL_ATTR_TYPE_U32);
+    free(query.links);
+}
+
+/* and the same holds for the target attribute: a type read off some other
+ * policy is not an answer to what we asked */
+static void
+test_ignores_target_attribute_elsewhere(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                                 SUB_POLICY));
+    feed(&query, msg_policy_attr(OTHER_POLICY, test_req.target_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL_ATTR_TYPE_U32));
+    assert_int_equal(ovpn_cap_resolve(&query, &test_req), OVPN_CAP_UNSUPPORTED);
+    free(query.links);
+}
+
+/* the command's own policy does get read, so the target attribute has to be
+ * turned away there too: the same id there is a different attribute */
+static void
+test_ignores_target_attribute_in_command_policy(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                                 SUB_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, test_req.target_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL_ATTR_TYPE_U32));
+    assert_int_equal(ovpn_cap_resolve(&query, &test_req), OVPN_CAP_UNSUPPORTED);
+    free(query.links);
+}
+
+/* the sub-policy is read too, so the nested attribute has to be turned away
+ * there as well */
+static void
+test_ignores_nested_attribute_in_sub_policy(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                                 SUB_POLICY));
+    feed(&query, msg_policy_attr(SUB_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                                 OTHER_POLICY));
+    feed(&query, msg_policy_attr(OTHER_POLICY, test_req.target_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL_ATTR_TYPE_U32));
+    assert_int_equal(ovpn_cap_resolve(&query, &test_req), OVPN_CAP_UNSUPPORTED);
+    free(query.links);
+}
+
+/* an attribute that is there but not as a nest has nothing to follow */
+static void
+test_nested_attribute_without_policy_idx(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL_ATTR_TYPE_U32));
+    feed(&query, msg_policy_attr(SUB_POLICY, test_req.target_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL_ATTR_TYPE_U32));
+    assert_int_equal(ovpn_cap_resolve(&query, &test_req), OVPN_CAP_UNSUPPORTED);
+    free(query.links);
+}
+
+/* and one that is a nest says nothing about the type we are after */
+static void
+test_target_attribute_without_type(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                                 SUB_POLICY));
+    feed(&query, msg_policy_attr(SUB_POLICY, test_req.target_attr,
+                                 NL_POLICY_TYPE_ATTR_POLICY_IDX, OTHER_POLICY));
+    assert_int_equal(ovpn_cap_resolve(&query, &test_req), OVPN_CAP_UNSUPPORTED);
+    free(query.links);
+}
+
+/* a flat requirement needs no hop: the command's policy is where to look */
+static void
+test_flat_requirement_reads_command_policy(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, flat_req.target_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL_ATTR_TYPE_U32));
+    assert_int_equal(ovpn_cap_resolve(&query, &flat_req), OVPN_CAP_SUPPORTED);
+    free(query.links);
+}
+
+/* and an absent one is a plain no */
+static void
+test_flat_requirement_absent_is_unsupported(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(OTHER_POLICY, flat_req.target_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL_ATTR_TYPE_U32));
+    assert_int_equal(ovpn_cap_resolve(&query, &flat_req), OVPN_CAP_UNSUPPORTED);
+    free(query.links);
+}
+
+/* a message we cannot parse stops the pass with an error, rather than
+ * leaving a hole that would read as a no */
+static void
+test_malformed_message_stops(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+    struct nl_msg *msg = nlmsg_alloc();
+    struct nlattr *ops, *op;
+
+    assert_non_null(msg);
+    assert_non_null(genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, 0, 0, 0, CTRL_CMD_GETPOLICY, 0));
+    ops = nla_nest_start(msg, CTRL_ATTR_OP_POLICY);
+    op = nla_nest_start(msg, OVPN_CMD_PEER_NEW);
+    assert_int_equal(nla_put_u16(msg, CTRL_ATTR_POLICY_DO, CMD_POLICY), 0);
+    nla_nest_end(msg, op);
+    nla_nest_end(msg, ops);
+
+    assert_int_equal(ovpn_cap_query_cb(msg, &query), NL_STOP);
+    assert_true(query.err < 0);
+    assert_int_equal(query.n_links, 0);
+    nlmsg_free(msg);
+    free(query.links);
+}
+
+/* nothing to read an answer out of is not the same as a "no" */
+static void
+test_resolve_without_command_policy(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    assert_int_equal(ovpn_cap_resolve(&query, &test_req), OVPN_CAP_UNKNOWN);
+}
+
+/* a kernel that does not nest the attribute simply never mentions it */
+static void
+test_resolve_nested_absent(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    assert_int_equal(ovpn_cap_resolve(&query, &test_req), OVPN_CAP_UNSUPPORTED);
+    free(query.links);
+}
+
+/* the sub-policy is there but does not define the attribute: the ordinary no */
+static void
+test_resolve_target_absent(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                                 SUB_POLICY));
+    assert_int_equal(ovpn_cap_resolve(&query, &test_req), OVPN_CAP_UNSUPPORTED);
+    free(query.links);
+}
+
+/* right name, wrong type: not the attribute we would be writing */
+static void
+test_resolve_wrong_type(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                                 SUB_POLICY));
+    feed(&query, msg_policy_attr(SUB_POLICY, test_req.target_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL_ATTR_TYPE_U8));
+    assert_int_equal(ovpn_cap_resolve(&query, &test_req), OVPN_CAP_UNSUPPORTED);
+    free(query.links);
+}
+
+/* and the whole chain, from a dump to a yes */
+static void
+test_resolve_complete_chain(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    feed_full_chain(&query);
+    assert_int_equal(ovpn_cap_resolve(&query, &test_req), OVPN_CAP_SUPPORTED);
+    free(query.links);
+}
+
+/* the kernel's order is not relied upon */
+static void
+test_resolve_any_order(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    feed(&query, msg_policy_attr(SUB_POLICY, test_req.target_attr, NL_POLICY_TYPE_ATTR_TYPE,
+                                 NL_ATTR_TYPE_U32));
+    feed(&query, msg_policy_attr(CMD_POLICY, OVPN_A_PEER, NL_POLICY_TYPE_ATTR_POLICY_IDX,
+                                 SUB_POLICY));
+    feed(&query, msg_op_policy(OVPN_CMD_PEER_NEW, CMD_POLICY));
+    assert_int_equal(ovpn_cap_resolve(&query, &test_req), OVPN_CAP_SUPPORTED);
+    free(query.links);
+}
+
+/* a dump larger than the first allocation */
+static void
+test_resolve_large_dump(void **state)
+{
+    struct ovpn_cap_query query = new_query();
+
+    for (uint16_t attr_id = 1; attr_id <= 3 * OVPN_CAP_INITIAL_LINKS; attr_id++)
+    {
+        feed(&query, msg_policy_attr(OTHER_POLICY, attr_id, NL_POLICY_TYPE_ATTR_TYPE,
+                                     NL_ATTR_TYPE_U32));
+    }
+    feed_full_chain(&query);
+    assert_true(query.n_links <= query.max_links);
+    assert_int_equal(ovpn_cap_resolve(&query, &test_req), OVPN_CAP_SUPPORTED);
+    free(query.links);
+}
+
+int
+main(void)
+{
+    const struct CMUnitTest tests[] = {
+        cmocka_unit_test(test_reads_command_policy),
+        cmocka_unit_test(test_ignores_other_command),
+        cmocka_unit_test(test_follows_nested_attribute),
+        cmocka_unit_test(test_ignores_nested_attribute_elsewhere),
+        cmocka_unit_test(test_reads_target_type),
+        cmocka_unit_test(test_ignores_target_attribute_elsewhere),
+        cmocka_unit_test(test_ignores_target_attribute_in_command_policy),
+        cmocka_unit_test(test_ignores_nested_attribute_in_sub_policy),
+        cmocka_unit_test(test_nested_attribute_without_policy_idx),
+        cmocka_unit_test(test_target_attribute_without_type),
+        cmocka_unit_test(test_flat_requirement_reads_command_policy),
+        cmocka_unit_test(test_flat_requirement_absent_is_unsupported),
+        cmocka_unit_test(test_malformed_message_stops),
+        cmocka_unit_test(test_resolve_without_command_policy),
+        cmocka_unit_test(test_resolve_nested_absent),
+        cmocka_unit_test(test_resolve_target_absent),
+        cmocka_unit_test(test_resolve_wrong_type),
+        cmocka_unit_test(test_resolve_complete_chain),
+        cmocka_unit_test(test_resolve_any_order),
+        cmocka_unit_test(test_resolve_large_dump),
+    };
+
+    return cmocka_run_group_tests_name("dco", tests, NULL, NULL);
+}


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
