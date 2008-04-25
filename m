Date: Fri, 25 Apr 2008 22:07:38 +0800
From: Tim Davies <tim@...1090...>
Message-ID: <4811E5AA.8060900@...1090...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020806080502080809080707"
Subject: [Openvpn-devel] [patch] OpenVPN 2.1_rc7, multihome and 64 bit
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020806080502080809080707
X-Scanner: Scanned by EmailScan-2.1.10
X-Scanner: Configured *not* to virus scan this part
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

After attempting to use OpenVPN 2.1_rc7 on a 64 bit Centos 5 platform, I 
came across a peculiar error when enabling multihome.  Basically no UDP 
packets were allowed to send due to an incorrect size being set.

The problem seems to be in socket.c, where sizeof(opi) is incorrect.  
The structure is defined as:

struct openvpn_pktinfo
{
  struct cmsghdr cmsghdr;
  struct in_pktinfo in_pktinfo;
};

On a 64 bit platform, sizeof(struct cmsghdr) is 16, and sizeof(struct 
in_pktinfo) is 12.  Due to structure padding, sizeof(struct 
openvpn_pktinfo) is 32, not 28.

The attached patch fixed the problem, although I'm not sure it's the 
best way to go about it.


Tim.

--------------020806080502080809080707
X-Scanner: Scanned by EmailScan-2.1.10
X-Scanner: Configured *not* to virus scan this part
Content-Type: text/plain;
 name="openvpn-2.1-64bit.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-2.1-64bit.patch"

diff -ur openvpn-2.1_rc7/socket.c openvpn-2.1_rc7-work/socket.c
--- openvpn-2.1_rc7/socket.c	2008-04-22 08:43:16.000000000 +0800
+++ openvpn-2.1_rc7-work/socket.c	2008-04-22 13:32:06.000000000 +0800
@@ -2145,7 +2145,7 @@
   mesg.msg_name = &from->dest.sa;
   mesg.msg_namelen = fromlen;
   mesg.msg_control = &opi;
-  mesg.msg_controllen = sizeof (opi);
+  mesg.msg_controllen = sizeof(struct cmsghdr) + sizeof(struct in_pktinfo);
   buf->len = recvmsg (sock->sd, &mesg, 0);
   if (buf->len >= 0)
     {
@@ -2156,7 +2156,7 @@
 	  && CMSG_NXTHDR (&mesg, cmsg) == NULL
 	  && cmsg->cmsg_level == SOL_IP 
 	  && cmsg->cmsg_type == IP_PKTINFO
-	  && cmsg->cmsg_len >= sizeof (opi))
+	  && cmsg->cmsg_len >= sizeof(struct cmsghdr) + sizeof(struct in_pktinfo))
 	{
 	  struct in_pktinfo *pkti = (struct in_pktinfo *) CMSG_DATA (cmsg);
 	  from->pi.ipi_ifindex = pkti->ipi_ifindex;
@@ -2231,10 +2231,10 @@
   mesg.msg_name = &to->dest.sa;
   mesg.msg_namelen = sizeof (to->dest.sa);
   mesg.msg_control = &opi;
-  mesg.msg_controllen = sizeof (opi);
+  mesg.msg_controllen = sizeof(struct cmsghdr) + sizeof(struct in_pktinfo);
   mesg.msg_flags = 0;
   cmsg = CMSG_FIRSTHDR (&mesg);
-  cmsg->cmsg_len = sizeof (opi);
+  cmsg->cmsg_len = sizeof(struct cmsghdr) + sizeof(struct in_pktinfo);
   cmsg->cmsg_level = SOL_IP;
   cmsg->cmsg_type = IP_PKTINFO;
   pkti = (struct in_pktinfo *) CMSG_DATA (cmsg);

--------------020806080502080809080707--

