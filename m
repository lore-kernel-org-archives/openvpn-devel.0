Message-ID: <4F5152B2.70705@...1490...>
Date: Sat, 03 Mar 2012 12:07:30 +1300
From: Jason Haar <Jason_Haar@...1490...>
MIME-Version: 1.0
References: <b7eff4b3227380d9911bac1a18327c69@...1528...>
	<20120302145900.GF1359@...1296...>
In-Reply-To: <20120302145900.GF1359@...1296...>
Subject: Re: [Openvpn-devel] Running udp and tcp server in the same instance
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 03/03/12 03:59, Gert Doering wrote:
> I would *love* to have that. And it's somewhere on my TODO list of
> things to implement in OpenVPN (multiple listening sockets in a single
> process).

Given the issue with the non-threaded nature of openvpn and the
bottlenecks that can cause under load, what's wrong with running
separate instances on multiple tcp and udp ports, and then using a
"--client-connect" script to return a unique IP to clients? We use that
so that all VPN users are always assigned "their" constant IP by mapping
an IP to the CN field - that also stops them using the same cert on >1
clients... (ie that's a feature for us - not a bug). Actually it doesn't
stop them using it on >1 clients - but it stops them running >1 clients
simultaneously :-)

With this, we have the luxury that every client always gets the same IP
- which makes asset management *much* easier and means you get
marvellous side-effects like I can be SSH-ed into a work machine at
home, suspend my laptop, go to another building and get an completely
different Internet address, and yet seconds later have openvpn
auto-reconnect to work and find my SSH session still works. So cool :-)

-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +1 408 481 8171
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


