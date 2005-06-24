From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Why must PAM library be dlopened?
Message-ID: <20050624074448.GA12685@...33...>
References: <200506141234.50171.nomis80@...401...> <20050623083639.GA14170@...33...> <Pine.LNX.4.58.0506230942080.10675@...41...> <200506231324.52051.nomis80@...401...> <Pine.LNX.4.58.0506231750330.10675@...41...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0506231750330.10675@...41...>
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
Date: Fri Jun 24 00:46:53 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thu, 23 Jun 2005, James Yonan wrote:

> I was thinking more about someone who builds a binary RPM on a machine
> that has a correctly linked pam-modules set causing autoconf to sense this
> -- now that RPM can't be used on a machine with an earlier broken version
> of pam-modules.

...which constitutes an incentive to update to the non-broken PAM installation.

If you compile something for glibc 2.3, chances are it doesn't work with
glibc 2.2 either.

-- 
Matthias Andree

