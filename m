Message-ID: <1b2a01c4e11a$e22dfb00$0600000a@...139...>
From: "Gisle Vanem" <giva@...258...>
MIME-Version: 1.0
Subject: [Openvpn-devel] status.c patch
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Dec 13 06:14:10 2004
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: OpenVPN-dev <openvpn-devel@lists.sourceforge.net>

It looked rather suspicious to want (S_IRUSR | S_IWUSR) for MingW 
when opening files in status.c. Patch:

--- status.c.orig       Wed Dec 08 00:52:04 2004
+++ status.c    Mon Dec 13 14:44:17 2004
@@ -77,7 +77,7 @@
        {
          switch (so->flags)
            {
-#ifdef _MSC_VER
+#ifdef WIN32
             case STATUS_OUTPUT_WRITE:
               so->fd = open (filename,
                              O_CREAT | O_TRUNC | O_WRONLY,

--gv


