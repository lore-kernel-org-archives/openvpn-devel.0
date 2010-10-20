Date: Wed, 20 Oct 2010 21:31:35 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20101020193135.GE10703@...1296...>
References: <4CBC6CD4.7000103@...1418...>
	<20101018164138.GB16573@...1330...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="53amhw1LtfB3vlEx"
Content-Disposition: inline
In-Reply-To: <20101018164138.GB16573@...1330...>
Subject: Re: [Openvpn-devel] Errors adding routes on Windows 7 with OpenVPN
	2.1.3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--53amhw1LtfB3vlEx
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Oct 18, 2010 at 06:41:39PM +0200, Alberto Gonzalez Iniesta wrote:
> It's not a bug in the Windows implementation but in OpenVPN 2.1.3
> itself. The bug is reported and it is being worked in.
> I think you're using 'remote_host' on your client configuration (or
> pushing it from the server). If that's the case, try changing that with
> the IP of the VPN server and see if that fixes it in the meantime.

Indeed.  *sigh*.  For "special case" routes, the change introduced in 2.1.3
to handle routes to multiple targets wrecks things in interesting ways.

If I read the code right, init_route() will leave &netlist untouched for
get_special_addr() routes ("remote_host" one of them).  netlist is on stack,
contains random garbage, and netlist.len will not be 0 - thus, random stack
data is copied from netlist.data[] until the route_list is full.

I think the patch below should fix this, but have not tested this at all
(neither with nor without the patch).  Applies to tag v2.1.3

I'd appreciate if someone could verify my analysis and ACK or NAK :-)

gert

----------------------------------------------------------
--53amhw1LtfB3vlEx--
