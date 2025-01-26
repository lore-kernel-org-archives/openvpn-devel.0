From: "ordex (Code Review)" <gerrit@...515...>
Date: Sun, 26 Jan 2025 01:33:38 +0000
In-Reply-To: <gerrit.1734087083000.I9e27ff335d892429334137d028f8503da4e4ca5b@...2715...>
References: <gerrit.1734087083000.I9e27ff335d892429334137d028f8503da4e4ca5b@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <447c0709e58cb547280386568e628e1bf3471237-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mEAkM2KlTaA="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco_linux: extend
 netlink error cb with extra info
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mEAkM2KlTaA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/841?usp=3Demail

to look at the new patch set (#5).


Change subject: dco_linux: extend netlink error cb with extra info
......................................................................

dco_linux: extend netlink error cb with extra info

A netlink error may contain more specific attributes: i.e.
missing attributes or missing neted objects.

Parse and print this information too.

Change-Id: I9e27ff335d892429334137d028f8503da4e4ca5b
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M dev-tools/special-files.lst
M src/openvpn/Makefile.am
M src/openvpn/dco_linux.c
A src/openvpn/netlink.h
4 files changed, 396 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/841/5

diff --git a/dev-tools/special-files.lst b/dev-tools/special-files.lst
index e5f2fc2..8702dfc 100644
--- a/dev-tools/special-files.lst
+++ b/dev-tools/special-files.lst
@@ -3,3 +3,4 @@
 E:src/compat/compat-lz4.h              # Preserve LZ4 upstream formatting
 E:src/openvpn/ovpn_dco_linux.h         # Preserve ovpn-dco upstream format=
ting
 E:src/openvpn/ovpn_dco_win.h           # Preserve ovpn-dco-win upstream fo=
rmatting
+E:src/openvpn/netlink.h                # Preserve netlink.h upstream forma=
tting
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index ecb2bcf..7ed27a5 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -79,6 +79,7 @@
 	mbuf.c mbuf.h \
 	memdbg.h \
 	misc.c misc.h \
+	netlink.h \
 	ovpn_dco_freebsd.h \
 	ovpn_dco_linux.h \
 	ovpn_dco_win.h \
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b038382..881d495 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -29,6 +29,14 @@

 #include "syshead.h"

+/* include bundled netlink.h as we need a relatively modern version
+ * defining NLMSGERR_ATTR_MISS_NEST and NLMSGERR_ATTR_MISS_TYPE.
+ *
+ * Include it first to make sure that nobody else pulls in the system
+ * copy.
+ */
+#include "netlink.h"
+
 #include "dco_linux.h"
 #include "errlevel.h"
 #include "buffer.h"
@@ -339,6 +347,18 @@
             (char *)nla_data(tb_msg[NLMSGERR_ATTR_MSG]));
     }

+    if (tb_msg[NLMSGERR_ATTR_MISS_NEST])
+    {
+        msg(M_WARN, "kernel error: missing required nesting type %u\n",
+            nla_get_u32(tb_msg[NLMSGERR_ATTR_MISS_NEST]));
+    }
+
+    if (tb_msg[NLMSGERR_ATTR_MISS_TYPE])
+    {
+        msg(M_WARN, "kernel error: missing required attribute type %u\n",
+            nla_get_u32(tb_msg[NLMSGERR_ATTR_MISS_TYPE]));
+    }
+
     return NL_STOP;
 }

diff --git a/src/openvpn/netlink.h b/src/openvpn/netlink.h
new file mode 100644
index 0000000..47bac97
--- /dev/null
+++ b/src/openvpn/netlink.h
@@ -0,0 +1,374 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __LINUX_NETLINK_H
+#define __LINUX_NETLINK_H
+
+#include <linux/const.h>
+#include <linux/socket.h> /* for __kernel_sa_family_t */
+#include <linux/types.h>
+
+#define NETLINK_ROUTE		0	/* Routing/device hook				*/
+#define NETLINK_UNUSED		1	/* Unused number				*/
+#define NETLINK_USERSOCK	2	/* Reserved for user mode socket protocols 	*/
+#define NETLINK_FIREWALL	3	/* Unused number, formerly ip_queue		*/
+#define NETLINK_SOCK_DIAG	4	/* socket monitoring				*/
+#define NETLINK_NFLOG		5	/* netfilter/iptables ULOG */
+#define NETLINK_XFRM		6	/* ipsec */
+#define NETLINK_SELINUX		7	/* SELinux event notifications */
+#define NETLINK_ISCSI		8	/* Open-iSCSI */
+#define NETLINK_AUDIT		9	/* auditing */
+#define NETLINK_FIB_LOOKUP	10
+#define NETLINK_CONNECTOR	11
+#define NETLINK_NETFILTER	12	/* netfilter subsystem */
+#define NETLINK_IP6_FW		13
+#define NETLINK_DNRTMSG		14	/* DECnet routing messages (obsolete) */
+#define NETLINK_KOBJECT_UEVENT	15	/* Kernel messages to userspace */
+#define NETLINK_GENERIC		16
+/* leave room for NETLINK_DM (DM Events) */
+#define NETLINK_SCSITRANSPORT	18	/* SCSI Transports */
+#define NETLINK_ECRYPTFS	19
+#define NETLINK_RDMA		20
+#define NETLINK_CRYPTO		21	/* Crypto layer */
+#define NETLINK_SMC		22	/* SMC monitoring */
+
+#define NETLINK_INET_DIAG	NETLINK_SOCK_DIAG
+
+#define MAX_LINKS 32
+
+struct sockaddr_nl {
+	__kernel_sa_family_t	nl_family;	/* AF_NETLINK	*/
+	unsigned short	nl_pad;		/* zero		*/
+	__u32		nl_pid;		/* port ID	*/
+       	__u32		nl_groups;	/* multicast groups mask */
+};
+
+/**
+ * struct nlmsghdr - fixed format metadata header of Netlink messages
+ * @nlmsg_len:   Length of message including header
+ * @nlmsg_type:  Message content type
+ * @nlmsg_flags: Additional flags
+ * @nlmsg_seq:   Sequence number
+ * @nlmsg_pid:   Sending process port ID
+ */
+struct nlmsghdr {
+	__u32		nlmsg_len;
+	__u16		nlmsg_type;
+	__u16		nlmsg_flags;
+	__u32		nlmsg_seq;
+	__u32		nlmsg_pid;
+};
+
+/* Flags values */
+
+#define NLM_F_REQUEST		0x01	/* It is request message. 	*/
+#define NLM_F_MULTI		0x02	/* Multipart message, terminated by NLMSG_DONE */
+#define NLM_F_ACK		0x04	/* Reply with ack, with zero or error code */
+#define NLM_F_ECHO		0x08	/* Receive resulting notifications */
+#define NLM_F_DUMP_INTR		0x10	/* Dump was inconsistent due to sequence cha=
nge */
+#define NLM_F_DUMP_FILTERED	0x20	/* Dump was filtered as requested */
+
+/* Modifiers to GET request */
+#define NLM_F_ROOT	0x100	/* specify tree	root	*/
+#define NLM_F_MATCH	0x200	/* return all matching	*/
+#define NLM_F_ATOMIC	0x400	/* atomic GET		*/
+#define NLM_F_DUMP	(NLM_F_ROOT|NLM_F_MATCH)
+
+/* Modifiers to NEW request */
+#define NLM_F_REPLACE	0x100	/* Override existing		*/
+#define NLM_F_EXCL	0x200	/* Do not touch, if it exists	*/
+#define NLM_F_CREATE	0x400	/* Create, if it does not exist	*/
+#define NLM_F_APPEND	0x800	/* Add to end of list		*/
+
+/* Modifiers to DELETE request */
+#define NLM_F_NONREC	0x100	/* Do not delete recursively	*/
+#define NLM_F_BULK	0x200	/* Delete multiple objects	*/
+
+/* Flags for ACK message */
+#define NLM_F_CAPPED	0x100	/* request was capped */
+#define NLM_F_ACK_TLVS	0x200	/* extended ACK TVLs were included */
+
+/*
+   4.4BSD ADD		NLM_F_CREATE|NLM_F_EXCL
+   4.4BSD CHANGE	NLM_F_REPLACE
+
+   True CHANGE		NLM_F_CREATE|NLM_F_REPLACE
+   Append		NLM_F_CREATE
+   Check		NLM_F_EXCL
+ */
+
+#define NLMSG_ALIGNTO	4U
+#define NLMSG_ALIGN(len) ( ((len)+NLMSG_ALIGNTO-1) & ~(NLMSG_ALIGNTO-1) )
+#define NLMSG_HDRLEN	 ((int) NLMSG_ALIGN(sizeof(struct nlmsghdr)))
+#define NLMSG_LENGTH(len) ((len) + NLMSG_HDRLEN)
+#define NLMSG_SPACE(len) NLMSG_ALIGN(NLMSG_LENGTH(len))
+#define NLMSG_DATA(nlh)  ((void *)(((char *)nlh) + NLMSG_HDRLEN))
+#define NLMSG_NEXT(nlh,len)	 ((len) -=3D NLMSG_ALIGN((nlh)->nlmsg_len), \
+				  (struct nlmsghdr *)(((char *)(nlh)) + \
+				  NLMSG_ALIGN((nlh)->nlmsg_len)))
+#define NLMSG_OK(nlh,len) ((len) >=3D (int)sizeof(struct nlmsghdr) && \
+			   (nlh)->nlmsg_len >=3D sizeof(struct nlmsghdr) && \
+			   (nlh)->nlmsg_len <=3D (len))
+#define NLMSG_PAYLOAD(nlh,len) ((nlh)->nlmsg_len - NLMSG_SPACE((len)))
+
+#define NLMSG_NOOP		0x1	/* Nothing.		*/
+#define NLMSG_ERROR		0x2	/* Error		*/
+#define NLMSG_DONE		0x3	/* End of a dump	*/
+#define NLMSG_OVERRUN		0x4	/* Data lost		*/
+
+#define NLMSG_MIN_TYPE		0x10	/* < 0x10: reserved control messages */
+
+struct nlmsgerr {
+	int		error;
+	struct nlmsghdr msg;
+	/*
+	 * followed by the message contents unless NETLINK_CAP_ACK was set
+	 * or the ACK indicates success (error =3D=3D 0)
+	 * message length is aligned with NLMSG_ALIGN()
+	 */
+	/*
+	 * followed by TLVs defined in enum nlmsgerr_attrs
+	 * if NETLINK_EXT_ACK was set
+	 */
+};
+
+/**
+ * enum nlmsgerr_attrs - nlmsgerr attributes
+ * @NLMSGERR_ATTR_UNUSED: unused
+ * @NLMSGERR_ATTR_MSG: error message string (string)
+ * @NLMSGERR_ATTR_OFFS: offset of the invalid attribute in the original
+ *	 message, counting from the beginning of the header (u32)
+ * @NLMSGERR_ATTR_COOKIE: arbitrary subsystem specific cookie to
+ *	be used - in the success case - to identify a created
+ *	object or operation or similar (binary)
+ * @NLMSGERR_ATTR_POLICY: policy for a rejected attribute
+ * @NLMSGERR_ATTR_MISS_TYPE: type of a missing required attribute,
+ *	%NLMSGERR_ATTR_MISS_NEST will not be present if the attribute was
+ *	missing at the message level
+ * @NLMSGERR_ATTR_MISS_NEST: offset of the nest where attribute was missing
+ * @__NLMSGERR_ATTR_MAX: number of attributes
+ * @NLMSGERR_ATTR_MAX: highest attribute number
+ */
+enum nlmsgerr_attrs {
+	NLMSGERR_ATTR_UNUSED,
+	NLMSGERR_ATTR_MSG,
+	NLMSGERR_ATTR_OFFS,
+	NLMSGERR_ATTR_COOKIE,
+	NLMSGERR_ATTR_POLICY,
+	NLMSGERR_ATTR_MISS_TYPE,
+	NLMSGERR_ATTR_MISS_NEST,
+
+	__NLMSGERR_ATTR_MAX,
+	NLMSGERR_ATTR_MAX =3D __NLMSGERR_ATTR_MAX - 1
+};
+
+#define NETLINK_ADD_MEMBERSHIP		1
+#define NETLINK_DROP_MEMBERSHIP		2
+#define NETLINK_PKTINFO			3
+#define NETLINK_BROADCAST_ERROR		4
+#define NETLINK_NO_ENOBUFS		5
+#define NETLINK_RX_RING			6
+#define NETLINK_TX_RING			7
+#define NETLINK_LISTEN_ALL_NSID		8
+#define NETLINK_LIST_MEMBERSHIPS	9
+#define NETLINK_CAP_ACK			10
+#define NETLINK_EXT_ACK			11
+#define NETLINK_GET_STRICT_CHK		12
+
+struct nl_pktinfo {
+	__u32	group;
+};
+
+struct nl_mmap_req {
+	unsigned int	nm_block_size;
+	unsigned int	nm_block_nr;
+	unsigned int	nm_frame_size;
+	unsigned int	nm_frame_nr;
+};
+
+struct nl_mmap_hdr {
+	unsigned int	nm_status;
+	unsigned int	nm_len;
+	__u32		nm_group;
+	/* credentials */
+	__u32		nm_pid;
+	__u32		nm_uid;
+	__u32		nm_gid;
+};
+
+enum nl_mmap_status {
+	NL_MMAP_STATUS_UNUSED,
+	NL_MMAP_STATUS_RESERVED,
+	NL_MMAP_STATUS_VALID,
+	NL_MMAP_STATUS_COPY,
+	NL_MMAP_STATUS_SKIP,
+};
+
+#define NL_MMAP_MSG_ALIGNMENT		NLMSG_ALIGNTO
+#define NL_MMAP_MSG_ALIGN(sz)		__ALIGN_KERNEL(sz, NL_MMAP_MSG_ALIGNMENT)
+#define NL_MMAP_HDRLEN			NL_MMAP_MSG_ALIGN(sizeof(struct nl_mmap_hdr))
+
+#define NET_MAJOR 36		/* Major 36 is reserved for networking 						*/
+
+enum {
+	NETLINK_UNCONNECTED =3D 0,
+	NETLINK_CONNECTED,
+};
+
+/*
+ *  <------- NLA_HDRLEN ------> <-- NLA_ALIGN(payload)-->
+ * +---------------------+- - -+- - - - - - - - - -+- - -+
+ * |        Header       | Pad |     Payload       | Pad |
+ * |   (struct nlattr)   | ing |                   | ing |
+ * +---------------------+- - -+- - - - - - - - - -+- - -+
+ *  <-------------- nlattr->nla_len -------------->
+ */
+
+struct nlattr {
+	__u16           nla_len;
+	__u16           nla_type;
+};
+
+/*
+ * nla_type (16 bits)
+ * +---+---+-------------------------------+
+ * | N | O | Attribute Type                |
+ * +---+---+-------------------------------+
+ * N :=3D Carries nested attributes
+ * O :=3D Payload stored in network byte order
+ *
+ * Note: The N and O flag are mutually exclusive.
+ */
+#define NLA_F_NESTED		(1 << 15)
+#define NLA_F_NET_BYTEORDER	(1 << 14)
+#define NLA_TYPE_MASK		~(NLA_F_NESTED | NLA_F_NET_BYTEORDER)
+
+#define NLA_ALIGNTO		4
+#define NLA_ALIGN(len)		(((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
+#define NLA_HDRLEN		((int) NLA_ALIGN(sizeof(struct nlattr)))
+
+/* Generic 32 bitflags attribute content sent to the kernel.
+ *
+ * The value is a bitmap that defines the values being set
+ * The selector is a bitmask that defines which value is legit
+ *
+ * Examples:
+ *  value =3D 0x0, and selector =3D 0x1
+ *  implies we are selecting bit 1 and we want to set its value to 0.
+ *
+ *  value =3D 0x2, and selector =3D 0x2
+ *  implies we are selecting bit 2 and we want to set its value to 1.
+ *
+ */
+struct nla_bitfield32 {
+	__u32 value;
+	__u32 selector;
+};
+
+/*
+ * policy descriptions - it's specific to each family how this is used
+ * Normally, it should be retrieved via a dump inside another attribute
+ * specifying where it applies.
+ */
+
+/**
+ * enum netlink_attribute_type - type of an attribute
+ * @NL_ATTR_TYPE_INVALID: unused
+ * @NL_ATTR_TYPE_FLAG: flag attribute (present/not present)
+ * @NL_ATTR_TYPE_U8: 8-bit unsigned attribute
+ * @NL_ATTR_TYPE_U16: 16-bit unsigned attribute
+ * @NL_ATTR_TYPE_U32: 32-bit unsigned attribute
+ * @NL_ATTR_TYPE_U64: 64-bit unsigned attribute
+ * @NL_ATTR_TYPE_S8: 8-bit signed attribute
+ * @NL_ATTR_TYPE_S16: 16-bit signed attribute
+ * @NL_ATTR_TYPE_S32: 32-bit signed attribute
+ * @NL_ATTR_TYPE_S64: 64-bit signed attribute
+ * @NL_ATTR_TYPE_BINARY: binary data, min/max length may be specified
+ * @NL_ATTR_TYPE_STRING: string, min/max length may be specified
+ * @NL_ATTR_TYPE_NUL_STRING: NUL-terminated string,
+ *	min/max length may be specified
+ * @NL_ATTR_TYPE_NESTED: nested, i.e. the content of this attribute
+ *	consists of sub-attributes. The nested policy and maxtype
+ *	inside may be specified.
+ * @NL_ATTR_TYPE_NESTED_ARRAY: nested array, i.e. the content of this
+ *	attribute contains sub-attributes whose type is irrelevant
+ *	(just used to separate the array entries) and each such array
+ *	entry has attributes again, the policy for those inner ones
+ *	and the corresponding maxtype may be specified.
+ * @NL_ATTR_TYPE_BITFIELD32: &struct nla_bitfield32 attribute
+ */
+enum netlink_attribute_type {
+	NL_ATTR_TYPE_INVALID,
+
+	NL_ATTR_TYPE_FLAG,
+
+	NL_ATTR_TYPE_U8,
+	NL_ATTR_TYPE_U16,
+	NL_ATTR_TYPE_U32,
+	NL_ATTR_TYPE_U64,
+
+	NL_ATTR_TYPE_S8,
+	NL_ATTR_TYPE_S16,
+	NL_ATTR_TYPE_S32,
+	NL_ATTR_TYPE_S64,
+
+	NL_ATTR_TYPE_BINARY,
+	NL_ATTR_TYPE_STRING,
+	NL_ATTR_TYPE_NUL_STRING,
+
+	NL_ATTR_TYPE_NESTED,
+	NL_ATTR_TYPE_NESTED_ARRAY,
+
+	NL_ATTR_TYPE_BITFIELD32,
+};
+
+/**
+ * enum netlink_policy_type_attr - policy type attributes
+ * @NL_POLICY_TYPE_ATTR_UNSPEC: unused
+ * @NL_POLICY_TYPE_ATTR_TYPE: type of the attribute,
+ *	&enum netlink_attribute_type (U32)
+ * @NL_POLICY_TYPE_ATTR_MIN_VALUE_S: minimum value for signed
+ *	integers (S64)
+ * @NL_POLICY_TYPE_ATTR_MAX_VALUE_S: maximum value for signed
+ *	integers (S64)
+ * @NL_POLICY_TYPE_ATTR_MIN_VALUE_U: minimum value for unsigned
+ *	integers (U64)
+ * @NL_POLICY_TYPE_ATTR_MAX_VALUE_U: maximum value for unsigned
+ *	integers (U64)
+ * @NL_POLICY_TYPE_ATTR_MIN_LENGTH: minimum length for binary
+ *	attributes, no minimum if not given (U32)
+ * @NL_POLICY_TYPE_ATTR_MAX_LENGTH: maximum length for binary
+ *	attributes, no maximum if not given (U32)
+ * @NL_POLICY_TYPE_ATTR_POLICY_IDX: sub policy for nested and
+ *	nested array types (U32)
+ * @NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE: maximum sub policy
+ *	attribute for nested and nested array types, this can
+ *	in theory be < the size of the policy pointed to by
+ *	the index, if limited inside the nesting (U32)
+ * @NL_POLICY_TYPE_ATTR_BITFIELD32_MASK: valid mask for the
+ *	bitfield32 type (U32)
+ * @NL_POLICY_TYPE_ATTR_MASK: mask of valid bits for unsigned integers (U6=
4)
+ * @NL_POLICY_TYPE_ATTR_PAD: pad attribute for 64-bit alignment
+ *
+ * @__NL_POLICY_TYPE_ATTR_MAX: number of attributes
+ * @NL_POLICY_TYPE_ATTR_MAX: highest attribute number
+ */
+enum netlink_policy_type_attr {
+	NL_POLICY_TYPE_ATTR_UNSPEC,
+	NL_POLICY_TYPE_ATTR_TYPE,
+	NL_POLICY_TYPE_ATTR_MIN_VALUE_S,
+	NL_POLICY_TYPE_ATTR_MAX_VALUE_S,
+	NL_POLICY_TYPE_ATTR_MIN_VALUE_U,
+	NL_POLICY_TYPE_ATTR_MAX_VALUE_U,
+	NL_POLICY_TYPE_ATTR_MIN_LENGTH,
+	NL_POLICY_TYPE_ATTR_MAX_LENGTH,
+	NL_POLICY_TYPE_ATTR_POLICY_IDX,
+	NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE,
+	NL_POLICY_TYPE_ATTR_BITFIELD32_MASK,
+	NL_POLICY_TYPE_ATTR_PAD,
+	NL_POLICY_TYPE_ATTR_MASK,
+
+	/* keep last */
+	__NL_POLICY_TYPE_ATTR_MAX,
+	NL_POLICY_TYPE_ATTR_MAX =3D __NL_POLICY_TYPE_ATTR_MAX - 1
+};
+
+#endif /* __LINUX_NETLINK_H */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/841?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9e27ff335d892429334137d028f8503da4e4ca5b
Gerrit-Change-Number: 841
Gerrit-PatchSet: 5
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--mEAkM2KlTaA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex <strong>uploaded patch set #5</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/841?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">dco_linux: extend netlink error cb with extra info<br><br>A netlink error=
 may contain more specific attributes: i.e.<br>missing attributes or missin=
g neted objects.<br><br>Parse and print this information too.<br><br>Change=
-Id: I9e27ff335d892429334137d028f8503da4e4ca5b<br>Signed-off-by: Antonio Qu=
artulli &lt;antonio@...2726...&gt;<br>---<br>M dev-tools/special-files.lst<=
br>M src/openvpn/Makefile.am<br>M src/openvpn/dco_linux.c<br>A src/openvpn/=
netlink.h<br>4 files changed, 396 insertions(+), 0 deletions(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/841/5</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/dev-tools/special-files.lst b/dev-tools/special-files.lst</s=
pan><br><span>index e5f2fc2..8702dfc 100644</span><br><span>--- a/dev-tools=
/special-files.lst</span><br><span>+++ b/dev-tools/special-files.lst</span>=
<br><span>@@ -3,3 +3,4 @@</span><br><span> E:src/compat/compat-lz4.h       =
       # Preserve LZ4 upstream formatting</span><br><span> E:src/openvpn/ov=
pn_dco_linux.h         # Preserve ovpn-dco upstream formatting</span><br><s=
pan> E:src/openvpn/ovpn_dco_win.h           # Preserve ovpn-dco-win upstrea=
m formatting</span><br><span style=3D"color: hsl(120, 100%, 40%);">+E:src/o=
penvpn/netlink.h                # Preserve netlink.h upstream formatting</s=
pan><br><span>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.a=
m</span><br><span>index ecb2bcf..7ed27a5 100644</span><br><span>--- a/src/o=
penvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.am</span><br>=
<span>@@ -79,6 +79,7 @@</span><br><span> 	mbuf.c mbuf.h \</span><br><span> =
	memdbg.h \</span><br><span> 	misc.c misc.h \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	netlink.h \</span><br><span> 	ovpn_dco_freebsd.h=
 \</span><br><span> 	ovpn_dco_linux.h \</span><br><span> 	ovpn_dco_win.h \<=
/span><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linu=
x.c</span><br><span>index b038382..881d495 100644</span><br><span>--- a/src=
/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><b=
r><span>@@ -29,6 +29,14 @@</span><br><span> </span><br><span> #include &quo=
t;syshead.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* include bundled netlink.h as we need a relatively modern=
 version</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * defining=
 NLMSGERR_ATTR_MISS_NEST and NLMSGERR_ATTR_MISS_TYPE.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Include it first to make sure that nobody else pulls in=
 the system</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * copy.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;netlink.h&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #inclu=
de &quot;dco_linux.h&quot;</span><br><span> #include &quot;errlevel.h&quot;=
</span><br><span> #include &quot;buffer.h&quot;</span><br><span>@@ -339,6 +=
347,18 @@</span><br><span>             (char *)nla_data(tb_msg[NLMSGERR_ATT=
R_MSG]));</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (tb_msg[NLMSGERR_ATTR_MISS_NEST])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;kernel erro=
r: missing required nesting type %u\n&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            nla_get_u32(tb_msg[NLMSGERR_ATTR_MISS_=
NEST]));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (tb_msg[NLMSGERR_ATTR_MISS_TYPE])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;kernel erro=
r: missing required attribute type %u\n&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            nla_get_u32(tb_msg[NLMSGERR_ATTR_MIS=
S_TYPE]));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     r=
eturn NL_STOP;</span><br><span> }</span><br><span> </span><br><span>diff --=
git a/src/openvpn/netlink.h b/src/openvpn/netlink.h</span><br><span>new fil=
e mode 100644</span><br><span>index 0000000..47bac97</span><br><span>--- /d=
ev/null</span><br><span>+++ b/src/openvpn/netlink.h</span><br><span>@@ -0,0=
 +1,374 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* SPDX-L=
icense-Identifier: GPL-2.0 WITH Linux-syscall-note */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef __LINUX_NETLINK_H</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define __LINUX_NETLINK_H</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;linux/const.h&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &lt;linux/socket.h&gt; /* fo=
r __kernel_sa_family_t */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &lt;linux/types.h&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine NETLINK_ROUTE		0	/* Routing/device hook				*/</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define NETLINK_UNUSED		1	/* Unused numbe=
r				*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define NETL=
INK_USERSOCK	2	/* Reserved for user mode socket protocols 	*/</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define NETLINK_FIREWALL	3	/* Unu=
sed number, formerly ip_queue		*/</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define NETLINK_SOCK_DIAG	4	/* socket monitoring				*/</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define NETLINK_NFLOG		5	/=
* netfilter/iptables ULOG */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define NETLINK_XFRM		6	/* ipsec */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define NETLINK_SELINUX		7	/* SELinux event notifi=
cations */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define N=
ETLINK_ISCSI		8	/* Open-iSCSI */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define NETLINK_AUDIT		9	/* auditing */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define NETLINK_FIB_LOOKUP	10	</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define NETLINK_CONNECTOR	11</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define NETLINK_NETFI=
LTER	12	/* netfilter subsystem */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define NETLINK_IP6_FW		13</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define NETLINK_DNRTMSG		14	/* DECnet routing messages=
 (obsolete) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne NETLINK_KOBJECT_UEVENT	15	/* Kernel messages to userspace */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define NETLINK_GENERIC		16</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* leave room for NETLI=
NK_DM (DM Events) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define NETLINK_SCSITRANSPORT	18	/* SCSI Transports */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define NETLINK_ECRYPTFS	19</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define NETLINK_RDMA		20</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define NETLINK_CRYPTO		21=
	/* Crypto layer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define NETLINK_SMC		22	/* SMC monitoring */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define NETLINK_INET_DIAG	NETLINK_SOCK_DIAG</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define MAX_LINKS 32		</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struc=
t sockaddr_nl {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	__k=
ernel_sa_family_t	nl_family;	/* AF_NETLINK	*/</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	unsigned short	nl_pad;		/* zero		*/</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	__u32		nl_pid;		/* port ID	*/</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+       	__u32		nl_gro=
ups;	/* multicast groups mask */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * struct nlmsghdr - fixed format metad=
ata header of Netlink messages</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @nlmsg_len:   Length of message including header</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @nlmsg_type:  Message content=
 type</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @nlmsg_flag=
s: Additional flags</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @nlmsg_seq:   Sequence number</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @nlmsg_pid:   Sending process port ID</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+struct nlmsghdr {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	__u32		nlmsg_len;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	__u16		nlmsg_type;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	__u16		nlmsg_flags;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	__u32		nlmsg_seq;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	__u32		nlmsg_pid;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Flags values */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define NLM_F_REQUEST		0x01	/* It is requ=
est message. 	*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine NLM_F_MULTI		0x02	/* Multipart message, terminated by NLMSG_DONE */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define NLM_F_ACK		0x0=
4	/* Reply with ack, with zero or error code */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define NLM_F_ECHO		0x08	/* Receive resulting n=
otifications */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine NLM_F_DUMP_INTR		0x10	/* Dump was inconsistent due to sequence change *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define NLM_F_DUMP=
_FILTERED	0x20	/* Dump was filtered as requested */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Modifiers to GET request */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define NLM_F_ROOT	0x100	/* specify tree	root	*/<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define NLM_F_MATCH	=
0x200	/* return all matching	*/</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define NLM_F_ATOMIC	0x400	/* atomic GET		*/</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define NLM_F_DUMP	(NLM_F_ROOT|NLM_F_M=
ATCH)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Modifiers to NEW request */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define NLM_F_REPLACE	=
0x100	/* Override existing		*/</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define NLM_F_EXCL	0x200	/* Do not touch, if it exists	*/</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define NLM_F_CREATE	0x400=
	/* Create, if it does not exist	*/</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define NLM_F_APPEND	0x800	/* Add to end of list		*/</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* Modifiers to DELETE request */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define NLM_F_NONREC	0x100	/* D=
o not delete recursively	*/</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define NLM_F_BULK	0x200	/* Delete multiple objects	*/</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* Flags for ACK message */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define NLM_F_CAPPED	0x100	/* request was=
 capped */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define N=
LM_F_ACK_TLVS	0x200	/* extended ACK TVLs were included */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+   4.4BSD ADD		NLM_F_CREATE|NLM_F_EXCL</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+   4.4BSD CHANGE	NLM_F_REPLACE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+   True CHANGE		NLM_F_CREATE|NLM_F_REPLACE</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+   Append		NLM_F_CREATE</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+   Check		NLM_F_EXCL</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define NLMSG_ALIGNTO	4U</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define NLMSG_ALIGN(len) ( ((len)+NLMSG_ALIGNTO-1) &amp; ~(NLM=
SG_ALIGNTO-1) )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine NLMSG_HDRLEN	 ((int) NLMSG_ALIGN(sizeof(struct nlmsghdr)))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define NLMSG_LENGTH(len) ((len)=
 + NLMSG_HDRLEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine NLMSG_SPACE(len) NLMSG_ALIGN(NLMSG_LENGTH(len))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define NLMSG_DATA(nlh)  ((void *)(((char=
 *)nlh) + NLMSG_HDRLEN))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define NLMSG_NEXT(nlh,len)	 ((len) -=3D NLMSG_ALIGN((nlh)-&gt;nlmsg_l=
en), \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+				  (struct=
 nlmsghdr *)(((char *)(nlh)) + \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+				  NLMSG_ALIGN((nlh)-&gt;nlmsg_len)))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define NLMSG_OK(nlh,len) ((len) &gt;=3D =
(int)sizeof(struct nlmsghdr) &amp;&amp; \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+			   (nlh)-&gt;nlmsg_len &gt;=3D sizeof(struct nlmsg=
hdr) &amp;&amp; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		=
	   (nlh)-&gt;nlmsg_len &lt;=3D (len))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define NLMSG_PAYLOAD(nlh,len) ((nlh)-&gt;nlmsg_len - NL=
MSG_SPACE((len)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define NLMSG_NOOP		0=
x1	/* Nothing.		*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define NLMSG_ERROR		0x2	/* Error		*/</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define NLMSG_DONE		0x3	/* End of a dump	*/</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define NLMSG_OVERRUN		0x4	/* Data=
 lost		*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define NLMSG_MIN_TYPE		0x10	=
/* &lt; 0x10: reserved control messages */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+struct nlmsgerr {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	int		error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	stru=
ct nlmsghdr msg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	/*=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	 * followed by the=
 message contents unless NETLINK_CAP_ACK was set</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	 * or the ACK indicates success (error =3D=3D=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	 * message leng=
th is aligned with NLMSG_ALIGN()</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	/=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	 * followed by TL=
Vs defined in enum nlmsgerr_attrs</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	 * if NETLINK_EXT_ACK was set</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	 */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * enum nlmsgerr_attrs - nlmsgerr attribu=
tes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @NLMSGERR_ATT=
R_UNUSED: unused</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@NLMSGERR_ATTR_MSG: error message string (string)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @NLMSGERR_ATTR_OFFS: offset of the invalid=
 attribute in the original</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *	 message, counting from the beginning of the header (u32)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @NLMSGERR_ATTR_COOKIE: a=
rbitrary subsystem specific cookie to</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *	be used - in the success case - to identify a created<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *	object or operati=
on or similar (binary)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @NLMSGERR_ATTR_POLICY: policy for a rejected attribute</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @NLMSGERR_ATTR_MISS_TYPE: type =
of a missing required attribute,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *	%NLMSGERR_ATTR_MISS_NEST will not be present if the attribu=
te was</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *	missing at=
 the message level</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @NLMSGERR_ATTR_MISS_NEST: offset of the nest where attribute was missing<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @__NLMSGERR_ATTR_=
MAX: number of attributes</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @NLMSGERR_ATTR_MAX: highest attribute number</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+enum nlmsgerr_attrs {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	NLMSGERR_ATTR_UNUSED,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	NLMSGERR_ATTR_MSG,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	NLMSGERR_ATTR_OFFS,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	NLMSGERR_ATTR_COOKIE,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	NLMSGERR_ATTR_POLICY,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	NLMSGERR_ATTR_MISS_TYPE,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	NLMSGERR_ATTR_MISS_NEST,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	__NLMSGERR_ATTR_MAX,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	NLMSGERR_ATTR_MAX =3D __NLMSGERR_ATTR_MAX - 1</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define NETLINK_ADD_MEMBERSHIP		1</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define NETLINK_DROP_MEMBERSHIP		2</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define NETLINK_PKTINFO			3</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define NETLINK_BROADC=
AST_ERROR		4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 NETLINK_NO_ENOBUFS		5</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define NETLINK_RX_RING			6</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define NETLINK_TX_RING			7</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define NETLINK_LISTEN_ALL_NSID		8</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define NETLINK_LIST_MEMBERSHIPS	9</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define NETLINK_CAP_ACK			=
10</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define NETLINK_E=
XT_ACK			11</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
NETLINK_GET_STRICT_CHK		12</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct nl_pk=
tinfo {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	__u32	group=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+struct nl_mmap_req {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	unsigned int	nm_block_size;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	unsigned int	nm_block_nr;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	unsigned int	nm_frame_size;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	unsigned int	nm_frame_nr;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+struct nl_mmap_hdr {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	unsigned int	nm_status;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	unsigned int	nm_len;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	__u32		nm_group;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	/* credentials */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	__u32		nm_pid;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	__u32		nm_uid;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	__u32		nm_gid;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+enum nl_mmap_status {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	NL_MMAP_STATUS_UNUSED,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	NL_MMAP_STATUS_RES=
ERVED,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	NL_MMAP_STAT=
US_VALID,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	NL_MMAP_S=
TATUS_COPY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	NL_MMAP=
_STATUS_SKIP,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define NL_MMAP_MSG_ALIGNMENT		NLMSG_ALIG=
NTO</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define NL_MMAP_=
MSG_ALIGN(sz)		__ALIGN_KERNEL(sz, NL_MMAP_MSG_ALIGNMENT)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define NL_MMAP_HDRLEN			NL_MMAP_MSG_A=
LIGN(sizeof(struct nl_mmap_hdr))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e NET_MAJOR 36		/* Major 36 is reserved for networking 						*/</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+enum {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	NETLINK_UNCONNECTED =3D 0,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	NETLINK_CONNECTED,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  &lt;------- NLA_HDRLEN ------=
&gt; &lt;-- NLA_ALIGN(payload)--&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * +---------------------+- - -+- - - - - - - - - -+- - -+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * |        Header =
      | Pad |     Payload       | Pad |</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * |   (struct nlattr)   | ing |                   | in=
g |</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * +------------=
---------+- - -+- - - - - - - - - -+- - -+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  &lt;-------------- nlattr-&gt;nla_len ----------=
----&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+struct nlattr {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	__u16           nla_len;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	__u16           nla_type;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * nla_type (16=
 bits)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * +---+---+-=
------------------------------+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * | N | O | Attribute Type                |</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * +---+---+--------------------------=
-----+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * N :=3D Car=
ries nested attributes</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * O :=3D Payload stored in network byte order</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Note: The N and O flag are mutually exclusive.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define NLA_F_NESTED		(1 &lt;&lt; 15)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define NLA_F_NET_BYTEORDER	(1=
 &lt;&lt; 14)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e NLA_TYPE_MASK		~(NLA_F_NESTED | NLA_F_NET_BYTEORDER)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define NLA_ALIGNTO		4</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define NLA_ALIGN(len)		(((len) + NLA_ALIGNTO - 1) &amp;=
 ~(NLA_ALIGNTO - 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define NLA_HDRLEN		((int) NLA_ALIGN(sizeof(struct nlattr)))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* Generic 32 bitflags attribute content sent to the=
 kernel.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * The value is a bitmap tha=
t defines the values being set</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * The selector is a bitmask that defines which value is legit</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Examples:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  value =3D 0x0, and selector =3D 0x1</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  implies we are select=
ing bit 1 and we want to set its value to 0.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  value =3D 0x2, and selector =3D 0x2</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  implies we are selecting bit 2 and we want =
to set its value to 1.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+struct nla_bitfield32 {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	__u32 value;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	__u32 selector;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * policy des=
criptions - it&#39;s specific to each family how this is used</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Normally, it should be retriev=
ed via a dump inside another attribute</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * specifying where it applies.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * enum netlink_attr=
ibute_type - type of an attribute</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @NL_ATTR_TYPE_INVALID: unused</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @NL_ATTR_TYPE_FLAG: flag attribute (present/n=
ot present)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @NL_A=
TTR_TYPE_U8: 8-bit unsigned attribute</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @NL_ATTR_TYPE_U16: 16-bit unsigned attribute</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @NL_ATTR_TYPE_U32: 32-bit =
unsigned attribute</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @NL_ATTR_TYPE_U64: 64-bit unsigned attribute</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @NL_ATTR_TYPE_S8: 8-bit signed attribute</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @NL_ATTR_TYPE_S16: 16=
-bit signed attribute</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @NL_ATTR_TYPE_S32: 32-bit signed attribute</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @NL_ATTR_TYPE_S64: 64-bit signed attribute</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @NL_ATTR_TYPE_BINA=
RY: binary data, min/max length may be specified</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @NL_ATTR_TYPE_STRING: string, min/max lengt=
h may be specified</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @NL_ATTR_TYPE_NUL_STRING: NUL-terminated string,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *	min/max length may be specified</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @NL_ATTR_TYPE_NESTED: nest=
ed, i.e. the content of this attribute</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *	consists of sub-attributes. The nested policy and max=
type</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *	inside may b=
e specified.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @NL_=
ATTR_TYPE_NESTED_ARRAY: nested array, i.e. the content of this</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *	attribute contains sub-attrib=
utes whose type is irrelevant</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *	(just used to separate the array entries) and each such array<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *	entry has attribu=
tes again, the policy for those inner ones</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *	and the corresponding maxtype may be specified.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @NL_ATTR_TYPE_BITF=
IELD32: &amp;struct nla_bitfield32 attribute</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+enum netlink_attribute_type {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	NL_ATTR_TYPE_INVALID,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	NL_ATTR_TYPE_FLAG,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	NL_ATTR_TYPE_U8=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	NL_ATTR_TYPE_U16,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	NL_ATTR_TYPE_U32,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	NL_ATTR_TYPE_U64,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	NL_ATTR_TYPE_S8,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	NL_ATTR_TYPE_S16,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	NL_ATTR_TYPE_S32,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	NL_ATTR_TYPE_S64,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	NL_ATTR_TYPE_BINARY,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	NL_ATTR_TYPE_STRING,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	NL_ATTR_TYPE_NUL_STRING,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	NL_ATTR_TYPE_NESTED,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	NL_ATTR_TYPE_NESTED_ARRAY,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	NL=
_ATTR_TYPE_BITFIELD32,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * enum netlink_policy_type_attr - policy type at=
tributes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @NL_POLI=
CY_TYPE_ATTR_UNSPEC: unused</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @NL_POLICY_TYPE_ATTR_TYPE: type of the attribute,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *	&amp;enum netlink_attribute_typ=
e (U32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @NL_POLIC=
Y_TYPE_ATTR_MIN_VALUE_S: minimum value for signed</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *	integers (S64)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @NL_POLICY_TYPE_ATTR_MAX_VALUE_S: maximum va=
lue for signed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *	in=
tegers (S64)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @NL_=
POLICY_TYPE_ATTR_MIN_VALUE_U: minimum value for unsigned</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *	integers (U64)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @NL_POLICY_TYPE_ATTR_MAX_VALUE_U: max=
imum value for unsigned</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *	integers (U64)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @NL_POLICY_TYPE_ATTR_MIN_LENGTH: minimum length for binary</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *	attributes, no minimum if no=
t given (U32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @NL=
_POLICY_TYPE_ATTR_MAX_LENGTH: maximum length for binary</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *	attributes, no maximum if not given =
(U32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @NL_POLICY_=
TYPE_ATTR_POLICY_IDX: sub policy for nested and</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *	nested array types (U32)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE:=
 maximum sub policy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *	attribute for nested and nested array types, this can</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *	in theory be &lt; the size of the p=
olicy pointed to by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *	the index, if limited inside the nesting (U32)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @NL_POLICY_TYPE_ATTR_BITFIELD32_MASK: vali=
d mask for the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *	bi=
tfield32 type (U32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @NL_POLICY_TYPE_ATTR_MASK: mask of valid bits for unsigned integers (U64=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @NL_POLICY_TYPE=
_ATTR_PAD: pad attribute for 64-bit alignment</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @__NL_POLICY_TYPE_ATTR_MAX: number of attributes</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @NL_POLICY_TYPE_ATTR_MAX: highe=
st attribute number</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum netlink_pol=
icy_type_attr {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	NL_=
POLICY_TYPE_ATTR_UNSPEC,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	NL_POLICY_TYPE_ATTR_TYPE,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	NL_POLICY_TYPE_ATTR_MIN_VALUE_S,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	NL_POLICY_TYPE_ATTR_MAX_VALUE_S,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	NL_POLICY_TYPE_ATTR_MIN_VALUE_U,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	NL_POLICY_TYPE_ATTR_=
MAX_VALUE_U,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	NL_POL=
ICY_TYPE_ATTR_MIN_LENGTH,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	NL_POLICY_TYPE_ATTR_MAX_LENGTH,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	NL_POLICY_TYPE_ATTR_POLICY_IDX,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	NL_POLICY_TYPE_ATTR_BIT=
FIELD32_MASK,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	NL_PO=
LICY_TYPE_ATTR_PAD,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	NL_POLICY_TYPE_ATTR_MASK,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	/* keep las=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	__NL_POLICY_TY=
PE_ATTR_MAX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	NL_POL=
ICY_TYPE_ATTR_MAX =3D __NL_POLICY_TYPE_ATTR_MAX - 1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif /* __LINUX_NETLINK_H */</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/841?usp=3Demail">chan=
ge 841</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/841?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9e27ff335d892429334137d028f=
8503da4e4ca5b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 841 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--mEAkM2KlTaA=--

