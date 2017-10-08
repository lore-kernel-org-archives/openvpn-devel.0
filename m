Message-Id: <1507503487.3920753.1131984624.1DA42F97@...2307...>
From: logcabin@...2306...
MIME-Version: 1.0
Date: Sun, 08 Oct 2017 18:58:07 -0400
In-Reply-To: <20171008153814.GO70062@...1296...>
References: <1506735276.3927298.1123095944.62A302FF@...2307...>
 <20170930074629.GT70062@...1296...>
 <20170930161910.GX70062@...1296...>
 <1506794899.87173.1123548520.4DA7A99E@...2307...>
 <20170930181555.GA70062@...1296...>
 <1506797785.3933973.1123579944.40D80593@...2307...>
 <20171008153814.GO70062@...1296...>
Subject: Re: [Openvpn-devel] Unreferenced function in 2.4.4 Linux build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Thanks for the followup - I checked out the source from the master
branch and it builds with no problems. 

Looking forward to 2.4.5!

On Sun, Oct 8, 2017, at 11:38 AM, Gert Doering wrote:
> Hi,
> 
> On Sat, Sep 30, 2017 at 02:56:25PM -0400, logcabin@...2306... wrote:
> > This has solved the problem:
> > 
> > ./configure LZ4_CFLAGS=-I/usr/local/include LZ4_LIBS="-L/usr/local/lib
> > -llz4"
> > 
> > My mistake was to assume that since ./configure had found LZ4 version >=
> > 1.7.1, it would also locate the latest lz4 library. My bad.
> 
> Just as a small followup - we've discovered that this was not (only)
> a problem of your installation, but hit all Debian 8 systems.
> 
> We have adjusted our "configure" script to check for this particular
> problem (the version number reported is "130", which is "greater than
> 1.7.1",
> but actually a very old version), so 2.4.5 should build out of the box
> just fine.
> 
> gert
> 
> -- 
> USENET is *not* the non-clickable part of WWW!
>                                                            //www.muc.de/~gert/
> Gert Doering - Munich, Germany                            
> gert@...1296...
> fax: +49-89-35655025                       
> gert@...1297...
> Email had 1 attachment:
> + signature.asc
>   1k (application/pgp-signature)

