Message-ID: <20100724205830.29502.qmail@...1287...>
Date: Sat, 24 Jul 2010 22:58:30 +0200
From: Peter Stuge <peter@...1287...>
References: <4C4B3F41.6090302@...1390...>
MIME-Version: 1.0
In-Reply-To: <4C4B3F41.6090302@...1390...>
Subject: Re: [Openvpn-devel] features
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Alex T wrote:
> - some kind of route / firewall manipulation for the Windows client.

Try:

push "ip-win32 dynamic"
push "redirect-gateway def1"


//Peter

