From: Matthias Andree <matthias.andree@...68...>
Subject: Re: [Openvpn-devel] RPM build of 2.0-rc16 fails on MandrakeSoft
Message-ID: <20050227225359.GA16324@...33...>
References: <4220EC61.1000005@...355...> <Pine.LNX.4.58.0502270152590.23437@...41...> <42220B98.2010001@...355...> <42223300.1050402@...355...>
Mime-Version: 1.0
In-Reply-To: <42223300.1050402@...355...>
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
Date: Sun Feb 27 14:57:02 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: TomWalsh <tomw-junk01@...355...>
Cc: James Yonan <jim@...41...>, openvpn-devel@lists.sourceforge.net

On Sun, 27 Feb 2005, TomWalsh wrote:

> Hmm, although the build of the RPM will succeed, the package won't 
> install.  Doing a mere "urpmi openvpn" results in:
> 
> ================== error ====================
> [root@...23... root]# urpmi openvpn
> Some package requested cannot be installed:
> openvpn-2.0_rc16-3.i586 (due to unsatisfied liblzo[>= 1.07])

> Either way, there would still be an issue with Mandrake as I see that 
> the lzo package of SuSE 9.1 provides "lzo" not "liblzo".

Just make the dependency libzo.so.1 and be done with distro-specific
differences whether it is liblzo, lzo, lzo1, liblzo1,
my_grandma_ate_all_her_chickens or whatever.

-- 
Matthias Andree

