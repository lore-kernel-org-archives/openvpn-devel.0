References: <56211F0D.2010806@...515...> <2421664.qQJpUDo69u@...1526...>
	<56261F0D.9020208@...515...> <1921973.yRGlOPzy2x@...2001...>
	<20151022075000.GD22054@...1296...>
From: Jason Haar <Jason_Haar@...1490...>
Message-ID: <562B67B2.30808@...1490...>
Date: Sun, 25 Oct 2015 00:12:50 +1300
MIME-Version: 1.0
In-Reply-To: <20151022075000.GD22054@...1296...>
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On 22/10/15 20:50, Gert Doering wrote:
> I've heard people ask for "we need the VPN to be up before user login so
> windows domain login works!" - so the GUI won't be around yet.
>
> Now, not being a windows person and not running this domain stuff I'm=20
> not sure if there are other ways to achieve that - but this is what has
> been told to me...
I can confirm that is precisely the way we use openvpn. We use it as an
"always on vpn" and so it needs to be running via a service at boot
time. nssm works well for us in that regard

--=20
Cheers

Jason Haar
Corporate Information Security Manager, Trimble Navigation Ltd.
Phone: +1 408 481 8171
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1



