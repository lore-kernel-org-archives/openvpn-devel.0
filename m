Date: Thu, 25 Feb 2016 14:36:03 +0100 (CET)
Message-Id: <201602251336.u1PDa3Ys021449@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1455470881-32341-1-git-send-email-selva.nair@...277...>
References: <1455470881-32341-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Send stdout and stderr of
	OpenVPN started by interactive service to NUL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.  Fixes the "OpenVPN.exe hanging with no understandable reason when
the log file cannot be written to" issue for good (logging on management
interface will still work).

Again, I might overlook something Windows special, but from a generic
C and "on unix, the equivalent stuff would work correctly" perspective,
the code looks good.  More review welcome, though.

Your patch has been applied to the master branch.

commit 852f1e49c7e692c6392fe07160cfbc8d6b17f0d0
Author: Selva Nair
Date:   Sun Feb 14 12:28:01 2016 -0500

     Send stdout and stderr of OpenVPN started by interactive service to NUL

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1455470881-32341-1-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11161
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


