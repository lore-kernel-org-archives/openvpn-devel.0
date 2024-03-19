Date: Tue, 19 Mar 2024 17:58:33 +0100 (CET)
Message-Id: <202403191658.42JGwXsH041342@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240319135355.1279-2-lev@...515...>
References: <20240319135355.1279-2-lev@...515...>
Subject: [Openvpn-devel] [PATCH applied] Re: win32: Enforce loading of
 plugins from a trusted directory
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for that.

This patch was sent "with ACK included" to the openvpn-devel@ list because 
it was developed under embargo (CVE), and reviewed and ACKed in a closed
group.  I have verified that this patch is identical to the "v4 one" that
Selva and the original reporter saw and ACKed.

This is related to plugin loading on windows only.  We have discussed the
topic of "restricting plugin loading on other platforms" but it's more
complex to tackle (it starts with "there is no central registry to 
put restrictions into", but goes on to "on unix, openvpn runs as root
anyway, so we expect this to be done by admins who spend some thought
on what scripts and plugin they call, and from which paths") - so we
haven't done anything there yet.

I have test built this on MinGW/Ubuntu, just for completeness, and
via GHA.  Haven't tested the result myself (no plugin setup on windows).

(I do have a few gripes, but these are more cosmetical - like "make
get_openvpn_reg_value() static", and "wrap the long if() condition at 
the '&&', not in the middle of the function call" - but these are all
not important for the functionality)

Your patch has been applied to the master, release/2.6 and release/2.5
branch (security relevant bugfix).

commit aaea545d8a940f761898d736b68bcb067d503b1d (master)
commit 05d321ef980734478a86c5241dad7ba26a748a2f (release/2.6)
commit 30bddb1a5426523ef1d61c8a5df2c613ba2a47d3 (release/2.5)
Author: Lev Stipakov
Date:   Tue Mar 19 15:53:45 2024 +0200

     win32: Enforce loading of plugins from a trusted directory

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20240319135355.1279-2-lev@...515...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28416.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


