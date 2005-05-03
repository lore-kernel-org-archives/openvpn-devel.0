Subject: Re: [Openvpn-devel] Re: client-connect script not always called ?
From: Alex Ongena <Alex.Ongena@...388...>
In-Reply-To: <pan.2005.05.02.16.36.26.328642@...294...>
References: <1115022714.29941.47.camel@...389...>
	 <pan.2005.05.02.16.36.26.328642@...294...>
Message-Id: <1115123460.29941.106.camel@...389...>
Mime-Version: 1.0
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
Date: Tue May  3 05:32:59 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Charles Duffy <cduffy@...294...>
Cc: Openvpn Development <openvpn-devel@lists.sourceforge.net>

no, I'am not aware of such an option, nor do I find this
option/parameter in the manual page.

I'am using OpenVPN 2.0.0 and have never used the version before.

alex


On Mon, 2005-05-02 at 11:36 -0500, Charles Duffy wrote:
> > It's a proper shutdown on client side, so the client can inform
> > the server. The server should call IMHO 'client-disconnect' and
> > afterwards a 'client-connect', regardless if some timeouts are
> > expired or not.
> 
> Do you have the "explicit-exit-notify" operative in use (ideally,
> pushed
> to the clients from the server, such that it won't be necessary to
> modify
> the client configs after it's replaced with something more permanent)?
> Otherwise, the server finds out that the clients are down only when
> their
> timeout expires.
> 
> 

--
aXs GUARD has completed security and anti-virus checks on this e-mail
(http://www.axsguard.com)
---------------------------------------------------

