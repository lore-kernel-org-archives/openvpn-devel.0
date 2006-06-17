Date: Sat, 17 Jun 2006 20:08:51 +0200
From: richard lucassen <mailinglists@...673...>
Message-Id: <20060617200851.4d3779e2.mailinglists@...673...>
In-Reply-To: <e710p7$8ic$1@...165...>
References: <20060617152151.6ce2f63f.mailinglists@...673...>
	<e710p7$8ic$1@...165...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] ovpn server on udp with multiple gateways
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Sat, 17 Jun 2006 08:40:50 -0500
Charles Duffy <cduffy@...294...> wrote:

> > Is there a (simple) way to let OpenVPN use the same source address
> > to which the connection was set up like in the following example?
> > 
> > - set up tunnel x.x.x.x to dst address 1.1.1.2
> >   return src address 1.1.1.2 to x.x.x.x
> > - set up tunnel x.x.x.x to dst address 2.2.2.2
> >   return src address 2.2.2.2 to x.x.x.x
> > - set up tunnel x.x.x.x to dst address 3.3.3.2
> >   return src address 3.3.3.2 to x.x.x.x
> 
> OpenVPN 2.1-beta3 merged a patch adding multihoming support.
> Multihoming  can be enabled or disabled at build-time, but should be
> enabled by  default if your OS supports it. There's a new "multihome"
> configuration  directive to enable this functionality if your build
> has support.

Ok, thanks a lot, I'll download 2.1beta3 then :)

> (BTW, this is a usage question rather than a development one; it
> should  go to OpenVPN-users, not OpenVPN-devel. That said, searching
> the  OpenVPN-devel archives for "multihome" should be interesting if
> you're  curious for the discussion surrounding the patch when it was
> initially  submitted).

Ok, I haven't searched yet for the keyword "multihome", otherwise I
would certainly have found it. I thought it would be more a
development question, so sorry for the noise I caused on this list. I'll
switch to users then.

Richard.

-- 
___________________________________________________________________
It is better to remain silent and be thought a fool, than to speak
aloud and remove all doubt.

+------------------------------------------------------------------+
| Richard Lucassen, Utrecht                                        |
| Public key and email address:                                    |
| http://www.lucassen.org/mail-pubkey.html                         |
+------------------------------------------------------------------+

