From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Using miniLZO?
In-Reply-To: <41A057C3.90800@...138...>
Message-ID: <Pine.LNX.4.58.0411230848170.21753@...41...>
References: <41A057C3.90800@...138...>
MIME-Version: 1.0
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
Date: Tue Nov 23 07:51:03 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "Ian D. Bjorhovde" <ianbjor@...138...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

On Sun, 21 Nov 2004, Ian D. Bjorhovde wrote:

> Has anyone tried using miniLZO instead of the full-blown LZO library?
> I'm looking to build openvpn for the Sveasoft firmware on Linksys
> WRT54G, but don't want the relatively large (216kb) library.
> 
> If what I'm reading is correct, moving to lzo1x_1_compress is
> only slightly slower than lzo1x_1_15_compress (~1.5%), and that
> would be the only disadvantage...

What if you statically link with the full LZO library?  One would think
that would only bring in a subset of the whole library.

James


