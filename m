Message-ID: <1e6368e8050406085620d3496d@...278...>
From: Leonard Isham <leonard.isham@...277...>
Reply-To: Leonard Isham <leonard.isham@...277...>
Subject: Re: [Openvpn-devel] Lightweigh openvpn client for windows/linux?
In-Reply-To: <Pine.LNX.4.61.0504061227300.27337@...210...>
Mime-Version: 1.0
References: <20050406102031.42076.qmail@...367...>
	 <Pine.LNX.4.61.0504061227300.27337@...210...>
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
Date: Wed Apr  6 08:58:36 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Mathias Sundman <mathias@...209...>
Cc: Tomas Nouza <tnnx@...109...>, openvpn-devel@lists.sourceforge.net

On Apr 6, 2005 6:30 AM, Mathias Sundman <mathias@...209...> wrote:
> On Wed, 6 Apr 2005, Tomas Nouza wrote:
> 
> > So my question is, if there is a plan to develop a
> > lightweigh client, that would not need a TUN/TAP
> > interface. Now you can say it's not possible, but it
> > is, with some limitations:
> > The client would support only tunneling, and it would
> > listen on config/command-line specified tcp/udp ports
> > on localhost, encrypt each packet and send it.
> > Received and decrypted packets would of course appear
> > on the localhost (loopback) interface. The usage would
> > be similar to SSH port tunneling, while the openvpn
> > lightweight client would support OpenVPN servers, and
> > port ranges tunnelling.
> 
> What would you gain from making OpenVPN work this way, compared to using
> stunnel that was designed todo just this in the first place?
> 

IMHO UDP support.  Of course if OpenSSL supported UDP....
-- 
Leonard Isham, CISSP 
Ostendo non ostento.

