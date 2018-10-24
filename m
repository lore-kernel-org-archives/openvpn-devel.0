MIME-Version: 1.0
References: <CADkMwqTKd1tjTboxmvgrvk9kVtHDtubvQmEQ0m=nt4GB-RtoqA@...278...>
 <CAFHpkQG10QOhGUb4R4VyPHwCNMfkVSQgCVgmypsBidsgNcsBaw@...278...>
 <CADkMwqQ+F-rLr3V5_BxjixbvnyOW6T+Y6tP---3PBaOcHkRBpA@...278...>
 <CAFHpkQExnJLdr1kNMkXoYxXjOdX4+M3KTcOfBp1ZQwmV3CkkXA@...278...>
 <CADkMwqS7AUDVz_tj0_6ewhJ7YgfJmph71dK-hCVhgOY=5+z3oA@...278...>
 <CAFHpkQHhy_w=0vSag_cqwQ=BiPStuVBzK0GOheMpjvpFFY_wAQ@...278...>
 <CADkMwqQCC_5=tWyX5HPQpPBVqwm8eoisYY=GtjLYcwx7KpN2Hg@...278...>
 <CAFHpkQHpaLNwfWvm3C6YsWE1wTRndXMJPa4QkBqcvMGTwk7=dw@...278...>
 <CADkMwqRaW_7VrDg+k0ok6ZNqaZo=FheJFz+ZW958E5HD4xX_cQ@...278...>
 <CAFHpkQGOV+g7-Fe+ANHCPAE4_Ew8fgWo3DOoeYhExyVzdr5Dfg@...278...>
 <CADkMwqTZ9F8wbYrJjmoQQ56yf+e2DwRc3MQ7y6R0E3gSL4Zf2g@...278...>
 <CAKuzo_iVf7zOFV7b-5d0gR=6Ea9RR3o0420jhNtmSAuAq1MegA@...278...>
 <CADkMwqT8_Y8C4MSw7Jxjm+D+A9irBPVtouC9o+XE+EuzP0J6Fg@...278...>
 <CAKuzo_j3z2qSsxw1G_EYFtZCqch+nNd-9=gu9MKRXX+eP2LhYQ@...278...>
 <DM5PR2101MB11120B19BDCDCC39A3C834D3B0E40@...2412...>
 <CAKuzo_iFdNEOKsBq3tJ8VKye-zh5se6LSS5BpeJxoSP5J7EK-A@...278...>
 <CADkMwqSmonP074Xu-Wgex=gQ=K89VGXDAEc-efNqD0iLGu29zQ@...278...>
 <DM5PR2101MB11121D4F30EA5206D1BA11EAB0E60@...2412...>
 <CADkMwqTFZaVMXS79ck1esi9EWAt4hhnpCZ9Fq12nZw5VyAm_=g@...278...>
In-Reply-To: <CADkMwqTFZaVMXS79ck1esi9EWAt4hhnpCZ9Fq12nZw5VyAm_=g@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 23 Oct 2018 20:06:11 -0400
Message-ID: <CAKuzo_geNXXF52aXV=3oeuEq-NiKdOfd2wPupYzKFJW+sy2WJQ@...278...>
Subject: Re: [Openvpn-devel] Slow outbound network speed for Windows Server
 2016 only via the OpenVPN tunnel
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: rostyslav.maryliak@...2454...
Cc: Jon Kunkee <jkunkee@...2393...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Tue, Oct 23, 2018 at 6:37 PM Rostyslav Maryliak
<rostyslav.maryliak@...2454...> wrote:
>
> Dear John and Selva,
>
> I've tried almost all advises I was able to find in Internet but still no luck.
> Also, I've tried to test this hacky tap-adapter from jkunkee. I was able to build the tapinstall itself, but failed to add new adapter with it.
>
> Are you able to recreate my scenario and confirm the problem as I have on your side?
> Do you have any suggestions I can try?

By default, Windows 2016 server will not accept unsigned drivers, so you will
have to enable testsigning in boot configuration to install it correctly
(I've never tried this on server 2016).
See https://docs.microsoft.com/en-us/windows-hardware/drivers/install/the-testsigning-boot-configuration-option

Implementing missing OIDs in the tap driver is in the works, but I do not
know the ETA of it or whether that will "fix" the misbehaviour you see.

Selva

