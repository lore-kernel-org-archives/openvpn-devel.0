Date: Fri, 12 Jun 2009 10:21:20 -0500
From: "Karl O. Pinc" <kop@...1206...>
References: <c91c634ea4a3bbe7dd72c9c423b68849@...1228...>
In-Reply-To: <c91c634ea4a3bbe7dd72c9c423b68849@...1228...> (from
	arne@...1227... on Fri Jun 12 08:32:13 2009)
Message-Id: <1244820080l.4854l.4l@...1207...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Packet filtering in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; DelSp=Yes; Format=Flowed; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: Openvpn-devel@lists.sourceforge.net


On 06/12/2009 08:32:13 AM, Arne Schwabe wrote:
> Hello,
>=20
> I am at the moment looking to integrating packet filtering into
> OpenVPN. My
> reason to do so, are the following:
>=20
> - Windows own Firewall does not work when routing/bridging is used
> - I am not aware of a OpenSource Firewall for windows
> - Being able to do NAT without the help of the operating system can be
> very
> nice

I am not part of the the OpenVPN development team but this sounds
like feature creep to me.  Why put filewall support into OpenVPN,
which is already complicated enough, when you can write a
stand-alone firewall?


Karl <kop@...1206...>
Free Software:  "You don't pay back, you pay forward."
                  -- Robert A. Heinlein

