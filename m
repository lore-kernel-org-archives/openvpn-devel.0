From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] RPM build of 2.0-rc16 fails on MandrakeSoft
In-Reply-To: <422BC993.5040206@...355...>
Message-ID: <Pine.LNX.4.58.0503070841070.1122@...41...>
References: <4220EC61.1000005@...355...> <422BC993.5040206@...355...>
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
Date: Mon Mar  7 09:35:29 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: TomWalsh <tomw-junk01@...355...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, 6 Mar 2005, TomWalsh wrote:

> As long as we are on the subject of "Requires" in the openvpn.spec file, 
> shouldn't there also be a:
> 
> Requires:  bridge-utils >= 0.9.7

Why is this required?  What if you are not bridging?

James


