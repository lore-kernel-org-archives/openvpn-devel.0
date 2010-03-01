Date: Mon, 01 Mar 2010 10:01:52 -0600
From: "Karl O. Pinc" <kop@...1206...>
In-Reply-To: <jwvsk8kkuci.fsf-monnier+inbox@...1269...> (from
	monnier@...1268... on Mon Mar  1 08:12:03 2010)
Message-Id: <1267459312.30675.12@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] FQDN for routes should expand to all
 IPs (second round)
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
To: Stefan Monnier <monnier@...1268...>
Cc: Openvpn-devel@lists.sourceforge.net

On 03/01/2010 08:12:03 AM, Stefan Monnier wrote:
> >> If someone could give at least some vaguely plausible scenario,
> >> that'd help.
> > Maybe there's more than one tunnel and there's some stupid
> > load balancing going on using a hosts file?  (Along with
> > deleting all non-vpn routes.)
>=20
> [ Setting aside the fact that using OpenVPN's broken handling of
>   multi-FQDN to implement this is far from the only option. ]
>=20
> I'm not even sure *how* this could work: how would you ensure that=20
> the
> different tunnels happen to (together) route all IPs rather than all
> chosing the same IP (for example)?

I'm just waving my hands here; I'm not thinking closely about
the details and don't want to.  It sounded plausible when
it popped into my head so I sent a braindump.  I was thinking
along the lines of "well if you might want to randomize
remote endpoint choice using FQDNs resolved from a hosts file..."

Sorry if this has been more confusing than helpful.

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


