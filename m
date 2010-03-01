Date: Sun, 28 Feb 2010 22:38:51 -0600
From: "Karl O. Pinc" <kop@...1206...>
References: <4B88110D.3020501@...1114...>
	<jwvzl2vr3aw.fsf-monnier+inbox@...1269...>
	<4B8A59A2.6050601@...1114...>
	<jwvk4txceyv.fsf-monnier+inbox@...1269...>
In-Reply-To: <jwvk4txceyv.fsf-monnier+inbox@...1269...> (from
	monnier@...1268... on Sun Feb 28 14:04:01 2010)
Message-Id: <1267418331.30675.4@...1207...>
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

On 02/28/2010 02:04:01 PM, Stefan Monnier wrote:

>=20
> I'm at a loss when it comes to try and imagine someone who's used to
> the
> current behavior and bothered by the new behavior.  Really.  How can
> the
> current behavior ever be preferable?  Why would someone ever prefer
> that
> a route would be randomly chosen to either go through the VPN or not.
>=20
> I haven't heard any such someone raise her voice, and neither have
> I heard anyone come up with a scenario where such a someone could
> exist.
>=20
> If someone could give at least some vaguely plausible scenario,
> that'd help.

Maybe there's more than one tunnel and there's some stupid
load balancing going on using a hosts file?  (Along with
deleting all non-vpn routes.)

??

Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                 -- Robert A. Heinlein


