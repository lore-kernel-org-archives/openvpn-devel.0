From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] bugfix: SuSE handling in openvpn.spec
In-Reply-To: <41B0734E.3010105@...324...>
Message-ID: <Pine.LNX.4.58.0412031302050.10000@...41...>
References: <41B0734E.3010105@...324...>
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
Date: Fri Dec  3 12:05:03 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Stefan Engel <mail@...324...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net


On Fri, 3 Dec 2004, Stefan Engel wrote:

> Hi,
> 
> there is a minor bug in openvpn.spec (v2.0_beta19). In the %files
> section the init script is always taken from /etc/rc.d/init.d instead
> of /etc/init.d in case of a SuSE distribution. This results in an
> rpm build error on SuSE systems.
> 
> The appended patch should fix this.
> 
> Regards,
> 
> Stefan
> 

Does this patch deal correctly with SuSE 9.1/9.2 differences?

James

