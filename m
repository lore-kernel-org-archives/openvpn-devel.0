From: "Fish Wang" <fish.thss@...277...>
References: <564BA6DB.4070703@...2070...>	<564DE8B3.9030803@...2070...>	<20151124083944.GY24952@...1296...>	<5654A314.3080607@...2070...>	<20151124201135.GM24952@...1296...>	<CAKuzo_jdcOjunyVmpT8er3HqWG7yh6pr+i8Tn8kD3omj=G_Pqw@...278...>	<565547AB.9030607@...2070...>	<20151125075416.GR24952@...1296...>	<CAKuzo_iUzeYSWWvbpyV5RY_FwoNMm=97cfo0-uzeMFQKki3sWg@...278...>	<5655C387.40805@...1227...>
	<20151125145439.GV24952@...1296...>
In-Reply-To: <20151125145439.GV24952@...1296...>
Date: Wed, 25 Nov 2015 08:52:09 -0800
Message-ID: <052201d127a1$a07c65a0$e17530e0$@gmail.com>
MIME-Version: 1.0
Content-Language: zh-cn
Subject: Re: [Openvpn-devel] [PATCH v4-master] Add Windows DNS Leak fix
	using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
To: 'Gert Doering' <gert@...1296...>, 'Arne Schwabe' <arne@...1227...>
Cc: 'openvpn-devel' <openvpn-devel@lists.sourceforge.net>

Just a small suggestion: I think the following will work:

- Check the version of the current operating system.
- Dynamically loading related DLLs (in this case, should be WFP-related
libraries) using LoadLibrary() only if OpenVPN is running Windows Vista+,
and pops a warning for XP users who has that option enabled.
- On Vista+, get addresses of those APIs that we want to call (via
GetProcAddress() ), and then use them as function pointers.

Pros: one binary works for all Windows.
Cons: the code is a bit messier. 

I've done this before for my own projects that must be running on both XP
and later versions of Windows, and it works reliably. I can look into this
later this week (if ValdikSS doesn't have cycles).

Best,
Fish

-----Original Message-----
From: Gert Doering [mailto:gert@...1296...] 
Sent: Wednesday, November 25, 2015 6:55 AM
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Subject: Re: [Openvpn-devel] [PATCH v4-master] Add Windows DNS Leak fix
using WFP ('block-outside-dns')

Hi,

On Wed, Nov 25, 2015 at 03:19:51PM +0100, Arne Schwabe wrote:
> I am not sure if we want to ship separate WIN XP and Vista+ versions.

We are in agremeent that we do *not* want that :-) - but we *do* want this 
patch to work around Win10 DNS brokenness, and that binary won't run on XP.

Which of the options do we want less...?

gert

-- 
USENET is *not* the non-clickable part of WWW!
 
//www.muc.de/~gert/
Gert Doering - Munich, Germany
gert@...1296...
fax: +49-89-35655025
gert@...1297...


