From: "Vladislav Grishenko" <themiron@...2010...>
References: <20201004223614.12429-1-themiron@...2010...>
 <20201115220857.9307-1-themiron@...2010...>
 <20201204140135.GX976@...1296...>
In-Reply-To: <20201204140135.GX976@...1296...>
Date: Sat, 5 Dec 2020 16:07:54 +0500
Message-ID: <00f101d6caf6$e1762430$a4626c90$@yandex-team.ru>
MIME-Version: 1.0
Content-Language: ru
Subject: Re: [Openvpn-devel] [PATCH v9] Add DNS SRV remote host discovery
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: 'Gert Doering' <gert@...1296...>

Hi, Gert

Indeed, early platform-related code was tested on FreeBSD w/o EAI_NODATA
return results used.
Since that changes were not related to low-level resolving code, and
therefore was tested on Linux with _GNU and Windows only.
Unfortunately at some time point usage of EAI_NODATA return result was
introduced and I've missed FreeBSD testing thought it was still not
necessary, sorry.

Please refer v10 version sent and additional separate v9->v10 patch to see
exact changes.
It address all the places with EAI_NODATA and keeps windows logic consistent
as well.

> I have no idea *why* FreeBSD considers this "obsoleted", or what this
define is used for - have not yet investigated in any way

https://lists.freebsd.org/pipermail/freebsd-ports/2003-October/005757.html
> It was depricated in RFC3493 (aka RFC2553bis).  Now, getaddrinfo(3)
returns EAI_NONAME instead of EAI_NODATA.

--
Best Regards, Vladislav Grishenko

> -----Original Message-----
> From: Gert Doering <gert@...1296...>
> Sent: Friday, December 4, 2020 7:02 PM
> To: Vladislav Grishenko <themiron@...2010...>
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [PATCH v9] Add DNS SRV remote host discovery
> support
> 
> Hi,
> 
> On Mon, Nov 16, 2020 at 03:08:57AM +0500, Vladislav Grishenko wrote:
> > DNS SRV remote host discovery allows to have multiple OpenVPN servers
> > for a single domain w/o explicit profile enumeration, to move services
> > from host to host with little fuss, and to designate hosts as primary
> > servers for a service and others as backups.
> > Feature has been asked several times already, should be useful in case
> > of substantial number of clients & servers deployed.
> 
> So, Arne has ACKed it, and I went work on it today.  One problem showed up
on
> FreeBSD - the code uses EAI_NODATA, which is found in <netdb.h> on
FreeBSD,
> but with this comment:
> 
> #if 0
> /* obsoleted */
> #define EAI_NODATA       7      /* no address associated with hostname */
> #endif
> 
> I'm not sure what to make out of this, but as it stands, the patchset does
not
> work.
> 
> If I just add
> 
>   #define EAI_NODATA 7
> 
> to socket.c, it compiles and passes my regular client tests (no SRV tests
yet), but
> I do not think this is the correct solution.
> 
> (I have no idea *why* FreeBSD considers this "obsoleted", or what this
define is
> used for - have not yet investigated in any way)
> 
> 
> If you need to test on FreeBSD, openvpn-vagrant has boxes that get
installed
> with all prerequisites (or I can give you access to one of my
buildslaves).
> 
> gert
> 
> --
> "If was one thing all people took for granted, was conviction that if you
feed
> honest figures into a computer, honest figures come out. Never doubted  it
> myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
Mistress
> 
> Gert Doering - Munich, Germany
gert@...1296...


