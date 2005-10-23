Message-ID: <435BDF68.6000800@...480...>
From: Andreas Gaufer <Andreas.Gaufer@...480...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000604060709000607000808"
Subject: [Openvpn-devel] man page --client-config-dir hint
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
Date: Sun Oct 23 12:09:52 2005
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000604060709000607000808
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi,

my deep respect for this beautiful peace of software. It helps a lot=20
every day.

I was a little astonished because client-configuration-directory files=20
seemed to be not re-read on
client connect.

I learned from the source that the responsible function only runs on=20
session-init and not on
session-move. I did=B4t expect this from reading the man page.  The patch=20
attached introduces a hint
which could save other users a little time. I would be honored if you=20
consider including it.

Greetings

Andreas Gaufer




--------------000604060709000607000808
Content-Type: text/plain;
 name="openvpn.8.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn.8.patch.txt"

Index: openvpn.8
===================================================================
RCS file: /cvsroot/openvpn/openvpn/openvpn.8,v
retrieving revision 1.68
diff -u -r1.68 openvpn.8
--- openvpn.8	16 Aug 2005 20:14:25 -0000	1.68
+++ openvpn.8	23 Oct 2005 18:45:47 -0000
@@ -2540,7 +2540,8 @@
 One of the useful properties of this option is that it
 allows client configuration files to be conveniently
 created, edited, or removed while the server is live,
-without needing to restart the server.
+without needing to restart the server. Notice that a custom
+client config file is not re-read during session-move.
 
 The following
 options are legal in a client-specific context:

--------------000604060709000607000808--

