From: "Morris, Russell" <rmorris@...1315...>
Date: Thu, 22 Oct 2015 16:43:05 +0000
Message-ID: <SN1PR08MB1391D82901BB0F9F4C8CB5E9B9270@...2065...>
References: <56211F0D.2010806@...515...> <2421664.qQJpUDo69u@...1526...>
	<56261F0D.9020208@...515...> <1921973.yRGlOPzy2x@...2001...>
	<20151022075000.GD22054@...1296...>
In-Reply-To: <20151022075000.GD22054@...1296...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
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
To: Gert Doering <gert@...1296...>, Heiko Hund <heiko.hund@...1489...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Sorry, catching up, but to the comments previously ... I do see openvpn.exe=
 crash quite regularly. I run it on a laptop, sleeping / resuming and movin=
g from wired to wireless (and) back quite a bit. These tend to break openvp=
n.exe, and in some cases can hang the TAP adapter also ... :-(.

Thanks,
... Russell


-----Original Message-----
From: Gert Doering [mailto:gert@...1296...]=20
Sent: Thursday, October 22, 2015 2:50 AM
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?

Hi,

On Thu, Oct 22, 2015 at 07:49:45AM +0200, Heiko Hund wrote:
> On Tuesday 20 October 2015 14:01:33 Samuli Sepp=E4nen wrote:
> > My NSSM-based replacement thingie aims to address all these
> > shortcomings. I believe the interactive service and NSSM are complement=
ary.
>=20
> Or we extend the GUI to make it start tunnels automatically on startup, t=
hen
> the additional service is no longer needed, is it?

I've heard people ask for "we need the VPN to be up before user login so
windows domain login works!" - so the GUI won't be around yet.

Now, not being a windows person and not running this domain stuff I'm=20
not sure if there are other ways to achieve that - but this is what has
been told to me...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

