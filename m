Date: Tue, 11 Aug 2015 08:53:02 +0200
From: Samuel Thibault <samuel.thibault@...1817...>
Message-ID: <20150811065302.GH3494@...2049...>
References: <20150730233727.GW3676@...2049...>
	<CAGyAFMWagBfdJtNvX_sK9CGH-SvvxgsnVBX3xx1Z2Ym41hhaGw@...278...>
	<20150810232802.GX3494@...2049...>
	<20150811055906.GX382@...1296...>
MIME-Version: 1.0
In-Reply-To: <20150811055906.GX382@...1296...>
Subject: Re: [Openvpn-devel] Packet loss due to radius issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Gert Doering, le Tue 11 Aug 2015 07:59:06 +0200, a =E9crit :
> > I can see that when accounting fails, an
> > exception is thrown, to return an error to openvpn and thus prevent
> > the connection.  I guess this is an important part that shouldn't be
> > dropped, but I don't see a way to make it asynchronous without modifying
> > the openvpn core.
> >=20
> > In our case we don't actually make use of radius accounting...
>=20
> ... you could modify the radiusplugin to just "do not do accounting" -
> just return "success!" right away, and quickly so...

Yep, already done so on our platform, so we at least avoid the issue :)

It still needs to be fixed upstream :)

Samuel

