From: JuanJo Ciarlante <jjo-ipsec@...283...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0 released
Message-ID: <20050426114625.E15659@...283...>
References: <Pine.LNX.4.58.0504172223570.14131@...41...><20050420091539.C21 <20050420091539.C21450@...283...><Pine.LNX.4.58.0504201125560.14131@...382... <Pine.LNX.4.58.0504211811260.14131@...41...><20050425104620.V15659@...383... <20050425104620.V15659@...283...> <Pine.LNX.4.58.0504251102160.14285@...41...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0504251102160.14285@...41...>; from jim@...41... on Mon, Apr 25, 2005 at 11:25:14AM -0600
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
Date: Tue Apr 26 08:49:46 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Apr 25, 2005 at 11:25:14AM -0600, James Yonan wrote:
> On Mon, 25 Apr 2005, JuanJo Ciarlante wrote:
> 
> > On Thu, Apr 21, 2005 at 06:27:03PM -0600, James Yonan wrote:
> > > I would like to merge your IPv6 patch into the 2.1 branch, once it gets 
> > > started (I'd like to keep the 2.0.x branch as stable as possible, with 
> > > minimalistic changes that don't go beyond bug fixes and small patches).
> > > 
> > > One potential speed bump will be in merging both IPv6 + the multihomed 
> > > patch which will definitely be going into 2.1:
> > > 
> > > http://openvpn.net/patch/openvpn-2.0_rc16MH.patch
> > > 
> > > Because both patches touch much of the same code, there will likely be a
> > > need for manual merging.
> > 
> > Ok ... indeed I tested "patch --dry ..." and shouted about 80% rejects.
> > I could merge both in my own CVS, but because it's a rather daunting task, 
> > I would like to be sure it's a productive one :-) ie. that it will have a
> > high chance to be merged , of course, if resulting patch quality qualifies.
> 
> The MH (multihomed) patch has a near 100% chance of being merged, since it
> is necessary for OpenVPN to operate properly as a multihomed server.  Here 
> is more info about it:
> 
> http://openvpn.net/archive/openvpn-users/2005-02/msg00640.html
> 
> The important thing in doing the merge is not so much to make the
> multihomed feature work with IPv6 (right away) as it is to do the correct 
> accounting and authentication of both source and destination address of 
> received packets (without this patch, OpenVPN does not keep track of 
> destination IP address of received packets when running in a multi-homed 
> context).

Ok
I've borrowed some sleep hours last night and ended having a consistent
merge, some polishing bits remain still (I'post as soon as I have it ready).

Nice to see same mechanism (w/ diff. goals) in MH and IPv6 patch: 
generalization of socket address type.
I've actually "moved upper" the pktinfo to the openvpn_sockaddr type:

  struct openvpn_sockaddr {
        union {                
	  struct sockaddr addr;
	  struct sockaddr_in in;
  #ifdef USE_PF_INET6
          struct sockaddr_in6 in6;
  #endif
  #ifdef USE_PF_UNIX
          struct sockaddr_un un;
  #endif
        } /* u */;                 /* use GCC anon union for now ... */
  #if ENABLE_IP_PKTINFO
        struct in_pktinfo pi;
  #endif
  };

and corresponding link_socket_addr:
  struct link_socket_addr
  {
        struct openvpn_sockaddr local;
	struct openvpn_sockaddr remote;
	struct openvpn_sockaddr actual;
  };

RATIONALE:
I this that moving ip_pktinfo to "main" openvpn_sockaddr struct allows
specifing output interface/etc even for client mode; so this
"generalization" is a good thing IMO.
There are new functions like addr_copy() , addr_zero() which replace
sin.sin_xxxx ... asignments to cope w/different AFs.

That "GCC (and others cc's)  anon. union " usage is temporary there, 
as a syntatic sugar:
  eg:           addr->in.sin_addr
  instead of:   addr->u.in.sin_addr
but I'll  obviously be changed.

> I think it's a fairly high priority to get your IPv6 patch + MH + the 
> BETA2.0-THREAD branch in the CVS merged as a baseline for 2.1.  I don't 
> expect the BETA2.0-THREAD code to conflict either with the MH or IPv6 
> patches.

cool ... as soon as I stabilize the merge we could try to apply to THREAD
branch.

> I'd be glad to work with you on this, as I am also interested in 
> extending the IPv6 support to allow IPv6 tunnels over OpenVPN in 
> client/server mode (right now, IPv6 tunnels are only supported in 
> point-to-point mode).

wow thanks... nice.

> 
> Incidentally, does your IPv6 patch affect performance when it is inactive, 
> i.e. when IPv4 is being used?

Some memory extra to hold the ipv4+ipv6 af union above; and new code paths
are more or less:
  +   switch(addr.sa_family) {
  +     case AF_INET:
           /* current code */
  +     case AF_INET6:
  +        /* ipv6 code */
  + }
  
So I think the performance impact it's quite negligible.

Anyway ... all IPv6 code is ifdef'd as  #ifdef USE_PF_INET6.

Regards!

-- 
--Juanjo

#  Juan Jose Ciarlante (JuanJo) jjo ;at; mendoza.gov.ar                     #
#  GnuPG Public Key: gpg --keyserver wwwkeys.eu.pgp.net --recv-key 66727177 #
#   Key fingerprint: 0D2F 3E5D 8B5C 729E 0560  F453 A3F7 E249 6672 7177     #

