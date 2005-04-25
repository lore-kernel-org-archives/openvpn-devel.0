From: Denis Vlasenko <vda@...380...>
Subject: Re: [Openvpn-devel] Help!
References: <200504251354.08540.vladimir@...379...> <200504251319.57914.vda@...380...> <200504251430.43169.vladimir@...379...>
In-Reply-To: <200504251430.43169.vladimir@...379...>
MIME-Version: 1.0
Message-Id: <200504251628.25454.vda@...380...>
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
Date: Mon Apr 25 06:31:45 2005
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: vladimir@...379..., openvpn-devel@lists.sourceforge.net

On Monday 25 April 2005 17:30, Vladimir S. Petukhov wrote:
> On Monday 25 April 2005 10:19, you wrote:
> > On Monday 25 April 2005 16:54, Vladimir S. Petukhov wrote:
> > > Hi!
> > >
> > > Sorry for my English...
> > >
> > > I have next task:
> > > 	We have client and provider with 2 channel (land & satellite) between
> > > them: for in/outgoing traffic. Client and server have a soft, implemented
> > > as local http-proxy. Server proxy made real http-request. Between client
> > > and server all data must be compressed and encapsulated in udp packets.
> > >
> > >
> > >                            <----compressed udp channel (satellite)--
> > > Client  |  "proxy"    --- compressed udp channel (land) ->  "proxy" |
> > > server
> > >
> > > The main goal - compression (HTTP - 70-90%).
> > >
> > > Can anybody advice usefull soft or any decisions?
> >
> > Well, openvpn will do this.
> 
> hardly...
> OpenVPN - is a tunnel and not support two separated channels...

Use policy routing + TWO openvpn tunnels.

> And compression may not be good (not a main goal of openVPN)...

What do you mean 'may not'? I thought you already tested at least that
before asking questions...
--
vda


