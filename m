From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0 released
In-Reply-To: <20050420141742.B1503@...283...>
Message-ID: <Pine.LNX.4.58.0504211811260.14131@...41...>
References: <Pine.LNX.4.58.0504172223570.14131@...41...><20050420091539.C21
 <20050420091539.C21450@...283...> <Pine.LNX.4.58.0504201125560.14131@...41...>
 <20050420141742.B1503@...283...>
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
Date: Thu Apr 21 17:30:38 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: JuanJo Ciarlante <jjo-ipsec@...283...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 20 Apr 2005, JuanJo Ciarlante wrote:

> On Wed, Apr 20, 2005 at 11:28:18AM -0600, James Yonan wrote:
> > 
> > On Wed, 20 Apr 2005, JuanJo Ciarlante wrote:
> > 
> > > On Sun, Apr 17, 2005 at 10:35:36PM -0600, James Yonan wrote:
> > > > I'm happy to announce that OpenVPN 2.0 has been released!
> > > > 
> > > > http://openvpn.net/download.html
> > > > 
> > > > Thanks to all who have supported the project with donations, developing
> > > > code, writing articles, and helping to support people on the mailing
> > > > lists.
> > > > 
> > > > I'm going to sit back now, relax, maybe try to get my server slashdotted, 
> > > > and I'll try not to think too much about OpenVPN 3.0 until the middle of 
> > > > the week :)
> > > 
> > > Congratulations for the great work!, openvpn-2 rocks.
> > > 
> > > BTW I've finished my UDPv6 "port" for openvpn-2.0-final, I'll announce the details
> > > ASAP.
> > 
> > Excellent -- I'm glad you've been keeping the patch in sync.
> 
> Yep; fortunately there are several ppl using it, they feedback'd several fixes (the
> latest one related to FreeBSD compilation and semantics).

I would like to merge your IPv6 patch into the 2.1 branch, once it gets 
started (I'd like to keep the 2.0.x branch as stable as possible, with 
minimalistic changes that don't go beyond bug fixes and small patches).

One potential speed bump will be in merging both IPv6 + the multihomed 
patch which will definitely be going into 2.1:

http://openvpn.net/patch/openvpn-2.0_rc16MH.patch

Because both patches touch much of the same code, there will likely be a
need for manual merging.

There's also a new CVS branch where I've been working on pthread support 
(see the BETA20-THREAD branch in the cvs).  The multihomed code has 
not been merged into this branch yet (though it's a clean merge with no 
conflicts).

James

