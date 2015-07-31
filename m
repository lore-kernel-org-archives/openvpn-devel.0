Date: Fri, 31 Jul 2015 11:32:06 +0200
From: Samuel Thibault <samuel.thibault@...1817...>
Message-ID: <20150731093206.GE3164@...2050...>
References: <20150730233727.GW3676@...2049...>
	<CAGyAFMWagBfdJtNvX_sK9CGH-SvvxgsnVBX3xx1Z2Ym41hhaGw@...278...>
	<20150731092451.GD3164@...2050...>
MIME-Version: 1.0
In-Reply-To: <20150731092451.GD3164@...2050...>
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
To: Lev Stipakov <lstipakov@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Samuel Thibault, le Fri 31 Jul 2015 11:24:51 +0200, a =E9crit :
> Lev Stipakov, le Fri 31 Jul 2015 11:19:15 +0300, a =E9crit :
> > Do you use radius plugin from http://www.nongnu.org/radiusplugin/ ? I
> > think the way OpenVPN delegates authentication to a plugin
> > (OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY hook) is asynchronous, as well
> > as plugin implementation, i. e. OpenVPN does not wait for a response.
> > Instead it periodically checks a tmp file to where plugin is supposed
> > to write authentication result (1 or 0).
>=20
> Ok, I see where that is implemented, and I do see acf temp files being
> created. For some reason the plugin doesn't seem to be using the
> deferred case, so I'll dig further.

Err...

# Allows the plugin to use auth control files if OpenVPN (>=3D 2.1 rc8) pro=
vides them.
# default is false
# useauthcontrolfile=3Dfalse

Why is the default false??

Samuel

