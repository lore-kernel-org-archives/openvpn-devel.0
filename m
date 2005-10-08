From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Patch: TAP usage made non ARP dependent
In-Reply-To: <43478832.9050200@...361...>
Message-ID: <Pine.LNX.4.58.0510081447170.32321@...41...>
References: <43404D99.8080309@...361...>  <434189C7.5090304@...361...> 
 <1128369731.6952.59.camel@...399...> <4342703F.90607@...361...>
  <1128428582.7061.18.camel@...399...>  <4342D092.4050502@...361...>
  <1128619301.7000.58.camel@...399...>  <4346A01F.4030106@...361...>
 <1128702738.7000.97.camel@...399...> <4346ED46.4040204@...361...>
 <43478832.9050200@...361...>
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
Date: Sat Oct  8 14:04:12 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Rolf Fokkens <r.fokkens@...361...>
Cc: Marcelo Toledo <marcelo@...461...>, openvpn-devel@lists.sourceforge.net

On Sat, 8 Oct 2005, Rolf Fokkens wrote:

> Rolf Fokkens wrote:
> 
> > The problem is caused by the fact that the MAC table only keeps track 
> > of MAC's behind clients, no MAC's behind the TAP interface are 
> > registered. This can easily be fixed by registering them as well. I'll 
> > get back on that as well.
> 
> Well, another patch. It contains a new MAC table implementation:
> 
>     * The MAC table has 1024 entries
>       I tested it with 2 entries, it still worked fine.
> 
>     * It's a kind of FIFO table:
>       MAC addresses are only learnt based on the src MAC of incoming
>       packets, Lookups have nothing to do with learning (as it does in
>       the existing code)
>           o Newly learnt MAC entries are inserted at the head
>           o Old MAC entries are removed from the tail when the table is full
>           o Known MAC entries are moved to the head when being refreshed
>           o Lookups don't change the order of entries in the FIFO
> 
>     * Each entry has a Time To Live of 60 sec.
>       After 60 sec. an entry is no longer returned when lookup up. It
>       remains in the FIFO however, and may be refreshed.
> 
> The MAC table code is in the mac_table.c and mac_table.h files.
> 
> At several places multi.c is changed to use the new MAC table for TAP 
> devices, TUN devices still use the existing code though I haven't tested 
> that.
> 
> I tested with 1 server and 2 clients, and TCP dump shows proper 
> behaviour. For debugging I also modified the Admin interface to reflect 
> the MAC table contents (including TTL) when using the "status" command, 
> alle works like predicted.
> 
> Marcelo, you have a uniqe testbed with ~400 clients, could you test this 
> patch as well?

A couple points:

Why don't you use the existing multi_context::vhash hash to keep track of
the server-side MAC table?  I know that this hash is usually used to
associate MAC or IP addresses with a given client instance, but it seems
ideally suited for this.  Maybe you could add a flag to struct multi_route
to indicate that the MAC is server-side and set multi_route::instance to
NULL.

Also, it would be great if you could #ifdef this code so that we can turn 
it on or off.

James


