From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] OpenVPN source repository migrated to svn (subversion)
Message-ID: <20050927093348.GA4144@...33...>
References: <Pine.LNX.4.58.0509262203120.25922@...41...>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0509262203120.25922@...41...>
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
Date: Tue Sep 27 02:36:03 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Mon, 26 Sep 2005, James Yonan wrote:

> I've migrated the OpenVPN source repository from CVS to subversion.
> 
> Read-only access is available at svn://openvpn.net/openvpn
> 
> Examples:
> 
> Check out the stable branch:
>   svn checkout svn://openvpn.net/openvpn/trunk openvpn

Hum, it has trunk/CVSROOT
            trunk/openvpn

Probably the CVSROOT is not too useful to other people, so to checkout:

svn checkout svn://openvpn.net/openvpn/trunk/openvpn openvpn
                                            --------

Should give more of what is expected to start work.

Best viewed with a nonproportional font :)

-- 
Matthias Andree

