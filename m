References: <56211F0D.2010806@...515...> <2421664.qQJpUDo69u@...1526...>
	<56261F0D.9020208@...515...> <1921973.yRGlOPzy2x@...2001...>
	<20151022075000.GD22054@...1296...>
	<SN1PR08MB1391D82901BB0F9F4C8CB5E9B9270@...2065...>
	<20151022173701.GP22054@...1296...>
	<SN1PR08MB13915E4AEE4D1046CE7953AFB9270@...2065...>
	<20151022182439.GS22054@...1296...>
	<SN1PR08MB13916305A3CB7B167CC0B1A7B9270@...2065...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <56293AC9.7010702@...1147...>
Date: Thu, 22 Oct 2015 21:36:41 +0200
MIME-Version: 1.0
In-Reply-To: <SN1PR08MB13916305A3CB7B167CC0B1A7B9270@...2065...>
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: "Morris, Russell" <rmorris@...1315...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,


On 22-Oct-15 20:28, Morris, Russell wrote:
> Hi,
>
> 90% sure it's I60x ... but I installed it a little bit ago, and didn't keep the installer. Is there an easy way to check (to be 100% sure, so I don't accidentally lie to you)?
>
try looking in the list of installed programs
    Control Panel -> Programs and Features

Otherwise, look at the driver file for the tun adapter (tap0901.sys); 
I've got the 060x version installed and it has version 9.0.0.21 ; I am 
not entirely sure but I think the 010x version has a different (lower) 
version number.

HTH,

JJK

>
>
> -----Original Message-----
> From: Gert Doering [mailto:gert@...1296...]
> Sent: Thursday, October 22, 2015 1:25 PM
> To: Morris, Russell <rmorris@...1315...>
> Cc: Gert Doering <gert@...1296...>; Heiko Hund <heiko.hund@...1489...>; openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
>
> Hi,
>
> On Thu, Oct 22, 2015 at 06:22:02PM +0000, Morris, Russell wrote:
>> Actually, I already have nobind in my config file (and am running v2.3.8). I tend to see 2 errors,
>> - CONNECTION, but with ERROR (TAP adapter hung, have to close openvpn.exe, disable / enable TAP, restart openvpn.exe)
>> - TAP adapter exited
> Is this the old or new tap adapter?  (Windows installers I60x or I00x?)
>
> gert


