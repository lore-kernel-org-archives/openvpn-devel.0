Message-ID: <41A057C3.90800@...138...>
From: "Ian D. Bjorhovde" <ianbjor@...138...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Using miniLZO?
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
Date: Sun Nov 21 00:56:14 2004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

Has anyone tried using miniLZO instead of the full-blown LZO library?
I'm looking to build openvpn for the Sveasoft firmware on Linksys
WRT54G, but don't want the relatively large (216kb) library.

If what I'm reading is correct, moving to lzo1x_1_compress is
only slightly slower than lzo1x_1_15_compress (~1.5%), and that
would be the only disadvantage...

Thoughts, anyone?




