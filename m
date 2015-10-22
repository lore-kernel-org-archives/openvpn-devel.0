From: "Morris, Russell" <rmorris@...1315...>
Date: Thu, 22 Oct 2015 18:22:02 +0000
Message-ID: <SN1PR08MB13915E4AEE4D1046CE7953AFB9270@...2065...>
References: <56211F0D.2010806@...515...> <2421664.qQJpUDo69u@...1526...>
	<56261F0D.9020208@...515...> <1921973.yRGlOPzy2x@...2001...>
	<20151022075000.GD22054@...1296...>
	<SN1PR08MB1391D82901BB0F9F4C8CB5E9B9270@...2065...>
	<20151022173701.GP22054@...1296...>
In-Reply-To: <20151022173701.GP22054@...1296...>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Actually, I already have nobind in my config file (and am running v2.3.8). =
I tend to see 2 errors,=20
- CONNECTION, but with ERROR (TAP adapter hung, have to close openvpn.exe, =
disable / enable TAP, restart openvpn.exe)
- TAP adapter exited

Thanks,
... Russell


-----Original Message-----
From: Gert Doering [mailto:gert@...1296...]=20
Sent: Thursday, October 22, 2015 12:37 PM
To: Morris, Russell <rmorris@...1315...>
Cc: Gert Doering <gert@...1296...>; Heiko Hund <heiko.hund@...1489...>; ope=
nvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?

Hi,

On Thu, Oct 22, 2015 at 04:43:05PM +0000, Morris, Russell wrote:
> Sorry, catching up, but to the comments previously ... I do see openvpn.e=
xe crash quite regularly. I run it on a laptop, sleeping / resuming and mov=
ing from wired to wireless (and) back quite a bit. These tend to break open=
vpn.exe, and in some cases can hang the TAP adapter also ... :-(.

Try without local bind (--nobind in the client config)...

That should even give you seamless roaming without losing your tunnel
if the server is new enough to support peer-id (git master, no older
than about half a yaear).

gert=20

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

