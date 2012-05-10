Message-ID: <4FAB8134.6000103@...515...>
Date: Thu, 10 May 2012 11:49:56 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4FAAE0A1.2080808@...1227...>
In-Reply-To: <4FAAE0A1.2080808@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hello,
>
> I have developed the port of openvpn for Android 4.0:
> https://play.google.com/store/apps/details?id=3Dde.blinkt.openvpn and
> http://code.google.com/p/ics-openvpn/
>
> The API of Android 4.0 requires that openvpn runs as completely
> unprivileged process. There all opening of tun, adding of routes,
> ifconfig etc. has to be done by another process.
>
> This patch implements an API to allow pushing routes, dns, tun over the
> management interface (unix socket). Also on Android 4.0 the connection
> for the control has to be protect via an API call from the Java GUI.
>=20=20
> Basically I am using the needok feature of the management protocol to
> push all relevant information to the GUI or to request information. I
> have not split the patch into multiple small patches because it should
> be first discussed if this is right architectural way.
>
>
> Arne
Hi Arne,

This is very neat, thanks! I wish I had an Android phone to test with
this...

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


