Subject: Re: [Openvpn-devel] Patch: TAP usage made non ARP dependent
From: Marcelo Toledo <marcelo@...461...>
In-Reply-To: <4342D092.4050502@...361...>
References: <43404D99.8080309@...361...>  <434189C7.5090304@...361...>
	 <1128369731.6952.59.camel@...399...> <4342703F.90607@...361...>
	 <1128428582.7061.18.camel@...399...>
	 <4342D092.4050502@...361...>
Message-Id: <1128619301.7000.58.camel@...399...>
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
Date: Thu Oct  6 10:23:15 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Rolf Fokkens <r.fokkens@...361...>
Cc: openvpn-devel@lists.sourceforge.net

Em Ter, 2005-10-04 às 20:57 +0200, Rolf Fokkens escreveu:
> Marcelo Toledo wrote: 
> > Em Ter, 2005-10-04 às 14:06 +0200, Rolf Fokkens escreveu:
> >   
> > > So another thing that should be implemented probably is aging.
> > >     
> > 
> > Alright, I am aware. Are you planning working on this?
> >   
> Attached you'll find find a new patch which includes aging. Could you
> try?

We have tested it in two ways:

1. Applied only in the server, worked perfectly with 3 clients. Right
now we're going to try few hundreds.

2. Applied the patch only in the client, worked well but they couldn't
see each other.

Should I apply in both or only in the server is enough?
-- 
Marcelo Toledo <marcelo@...461...>


