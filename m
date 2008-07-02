Message-ID: <486B1657.4000409@...1114...>
Date: Wed, 02 Jul 2008 07:47:03 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [resend] X509 TLS digest identifcation to plugin
	environment
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net



Hello!

My last attempt to send to this mailing list was rejected, so I'm just trying it once more.


kind regards,

David Sommerseth



-------- Original Message --------
Subject: X509 TLS digest identifcation to plugin environment
Date: Wed, 18 Jun 2008 16:35:23 +0200
From: David Sommerseth <dazo@...384...>
To: openvpn-devel@lists.sourceforge.net


Hello!

I posted the following patch to the SourceForge patch tracker almost 2
weeks ago.  I do not see if it has been acted upon this patch at all

http://sourceforge.net/tracker/index.php?func=detail&aid=1986805&group_id=48978&atid=454721

Patch summary:
The patch implements another environment variable which is accessible
for the plug-in interface.  A tls_digest_%i variable will contain the
certificate X509 digest in SHA1 format.

The patch compiles cleanly against the 2.0 branch.  It complains with
"hunk" fails when patching against the 2.1 branch, but it seems to me to
be mainly that the ssl.c has received more attention lately, and the
part of the code which I patch is being moved a little bit.

This patch only adds code, it do not change existing code.

Does anyone have a comment to this patch?  Does it need some rework to
be accepted?  Some feedback would be appreciated.


kind regards,

David Sommerseth




