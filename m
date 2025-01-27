Date: Mon, 27 Jan 2025 10:35:41 +0100 (CET)
Message-Id: <202501270935.50R9ZfXo050631@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250127091102.26983-1-gert@...1296...>
References: <20250127091102.26983-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: Fix some
 inconsistent usages of TEXT()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

I have looked a bit at the patch and it seems reasonable.  Lev has looked
harder and understands Windows, so that ACK is what counts ;-) - also
we have a mingw buildbot now, confirming that this isn't breaking 
windows builds.

Your patch has been applied to the master branch.

commit 02412106f406538db6f84fdea223b0972a3e3f41
Author: Frank Lichtenheld
Date:   Mon Jan 27 10:11:02 2025 +0100

     openvpnserv: Fix some inconsistent usages of TEXT()

     Signed-off-by: Frank Lichtenheld <frank@...2641...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20250127091102.26983-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30603.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


