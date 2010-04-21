Date: Wed, 21 Apr 2010 09:49:33 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <4BCF0259.8070902@...1347...>
	<CA8D46C6-BAA6-4BEA-901B-34E1B5B20D97@...1348...>
In-Reply-To: <CA8D46C6-BAA6-4BEA-901B-34E1B5B20D97@...1348...>
	(from toby@...1348... on Wed Apr 21 09:13:35 2010)
Message-Id: <1271861373.1490.4@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Slight modification to the contrib client.up
 script: DNS in server order
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Toby Thain <toby@...1348...>
Cc: openvpn-devel@lists.sourceforge.net

On 04/21/2010 09:13:35 AM, Toby Thain wrote:
>=20
> On 21-Apr-10, at 11:49 PM, Richard Monk wrote:
>=20
> > I had an issue come up where the clients were getting DNS entries=20
> in
>=20=20
> > the
> > reverse order the server sends them when using the client.up=20
> contrib
> > script.  Since the DNS servers on our system are in order from
> > closest->farthest network wise from the VPN server, having them
> > backwards caused some performance issues.
>=20
> Have you considered a local caching DNS with forwarding?

I don't see how this will solve the problem.
What if the closest _is_ a local caching DNS with forwarding
to the next farthest out?  You still want all the DNS servers
available in case one is down for some reason.


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


