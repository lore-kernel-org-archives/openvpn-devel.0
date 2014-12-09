Message-ID: <5486F1A1.70106@...1490...>
Date: Wed, 10 Dec 2014 01:57:05 +1300
From: Jason Haar <Jason_Haar@...1490...>
MIME-Version: 1.0
References: <54833CC6.8010507@...1490...> <5486B561.8080104@...515...>
In-Reply-To: <5486B561.8080104@...515...>
Subject: Re: [Openvpn-devel] feature request: get openvpn to use closest
	server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

On 09/12/14 21:40, Samuli Sepp=E4nen wrote:
> Would 3 pings and ping replies adequately measure the overall
> performance of OpenVPN server even for one particular VPN session? What
> if there's a temporary congestion somewhere between the "best" server
> and the client? I think that reliably determining the best server (on
> average) would require long-term statistics to be any good, but that
> would only work for clients that don't move around. In a road-warrior
> scenario what you suggest would work better.
Exactly. Static clients don't need any such feature because obviously it
would be worth the manual effort figuring out what server would be best
to connect to long-term, but "road warriors" involve end-users and I can
tell you from our experience with 6000 employees with Cisco Anyconnect,
that they don't think much about it :-) They will 99.9% of the time use
the same server that they used last time - and will then complain how
poorly it performs

As far as 3 pings not being enough, I'd argue in general it would - as
long as you don't have servers geographically "competing" with each
other. eg servers on the East and West coast of the USA and same for
Europe, plus one in China and one in Asia Pacific would mean every
client would "see" a server that is fundamentally closer to it than all
the rest - irrespective of temporary congestion. But if you were to
(say) start populating the USA with servers all over it, then they would
start making that decision point "fuzzy" - but frankly even that's a win
because the USA clients would be "mostly happy" using any of them - but
would be "mostly unhappy" if they were using China (for example)

...and of course it could be 5 packets instead of 3 - that was just  a
figure :-)

>
> In what kind of scenario would an OpenVPN server not be available, if
> the server itself still responds to pings?

Firewalls. It's not impossible that a client be on a network that blocks
all outbound traffic except for tcp port 443 (ie including ping).
Running openvpn on tcp port 443 would allow that client to get a tunnel.
Basically as no-one can predict what every network firewall in the world
has in common, then relying on something outside your own control to
test the availability of your product is risky (IMHO). In general
icmp-ping works - but I've been involved with companies that disabled it
- so there will be others

--=20
Cheers

Jason Haar
Corporate Information Security Manager, Trimble Navigation Ltd.
Phone: +1 408 481 8171
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1



