Message-ID: <4B22D7B2.8070903@...41...>
Date: Fri, 11 Dec 2009 16:37:22 -0700
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <411d6d370912111509s7dafa468p80e1e41537a5a976@...278...>
In-Reply-To: <411d6d370912111509s7dafa468p80e1e41537a5a976@...278...>
Subject: Re: [Openvpn-devel] Building the TAP drivers from source and then
 signing them (possible?)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Jon Onstott <jononstott@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Jon Onstott wrote:
> Hello,
> 
> I am compiling OpenVPN and the TAP driver from source and would like the 
> TAP driver to be signed so that it installs correctly on Vista (and 
> doesn't pop-up warning dialog boxes).  I noticed that the configure 
> scripts attempt to do that if "signtool" is defined.  Is there any way 
> that I could sign the TAP driver?

I think for most people, signing drivers themselves would be more pain 
than it's worth.  You have to get a special certificate from Verisign 
that costs ~$450/year.  You have to get the full WDK toolchain from 
Microsoft.

> I have thought about using the prebuilt TAP driver (from 
> openvpn.net/prebuilt/ <http://openvpn.net/prebuilt/>) but the prebuilt 
> binaries lag behind the current version and I need the TAP driver to be 
> the most recent one possible.

The TAP driver in http://openvpn.net/prebuilt/ is based on rc22 which is 
identical to the driver that was just released with 1.2.0.

James

