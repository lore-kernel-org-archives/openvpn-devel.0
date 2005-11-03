From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.0.4 Released -- Note security fixes
In-Reply-To: <20051103110003.GA8098@...33...>
Message-ID: <Pine.LNX.4.58.0511030930160.13189@...41...>
References: <Pine.LNX.4.58.0511011238570.16655@...41...>
 <20051101222421.GA15094@...33...> <Pine.LNX.4.58.0511012351170.13189@...41...>
 <20051102082433.GA3710@...33...> <Pine.LNX.4.58.0511021203330.13189@...41...>
 <20051103110003.GA8098@...33...>
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
Date: Thu Nov  3 09:00:50 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Thu, 3 Nov 2005, Matthias Andree wrote:

> On Wed, 02 Nov 2005, James Yonan wrote:
> 
> > So you can build your tarball as such:
> > 
> > svn co -r 760 http://svn.openvpn.net/projects/openvpn/trunk/openvpn openvpn
> > cd openvpn
> > autoreconf -i -v
> > ./configure
> > make dist
> 
> I prefer the 2.0.5 port.
> 
> BTW, are there official download mirrors for OpenVPN? The FreeBSD ports
> system suggests to add some.

I would prefer to keep the downloads on openvpn.net (or a clone of the
website) for the principal reason that donations are an important source
of funding for the project, and people are more likely to donate if they 
are reminded that it is an option during the download process.

As far as reliability is concerned, openvpn.net has the capability to
dynamically fail over between two mirrored servers at different data
centers.  Right now the domain is pointing to the backup server because
I'm in the process of migrating to a new primary server, so the failover
is temporarily turned off.

The new primary is at The Planet -- here's the details on their data 
center:

http://www.theplanet.com/network/

The planet has high bandwidth limits, 1200 GB per month, far more than 
openvpn.net needs at this point, and with the dynamic failover in place, I 
think most of the issues regarding reliability are well-covered.

James


