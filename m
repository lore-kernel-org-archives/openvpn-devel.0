Date: Mon, 11 Jul 2016 20:13:35 +0200 (CEST)
Message-Id: <201607111813.u6BIDZjq092387@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1465871689-13533-1-git-send-email-selva.nair@...277...>
References: <1465871689-13533-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: Promptly close the
	netcmd_semaphore handle after use
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

ACK.  Reviewed the patch before - performance impact is not high
(compared to exec()'ing netsh.exe), and I can see the argument that
the approach I suggested would be changing too many different places
to be more "clean".  Compile-tested, not run.

Your patch has been applied to the master and release/2.3 branch (bugfix).

commit 6aa4c9091300f62fae0bf7a9198de0edd2d8b7c7 (master)
commit 13f3526a9b05bed63c50c93c5903b0cde0dcc7f4 (release/2.3)

Author: Selva Nair
Date:   Mon Jun 13 22:34:49 2016 -0400

     Promptly close the netcmd_semaphore handle after use

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1465871689-13533-1-git-send-email-selva.nair@...277...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/11919
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


