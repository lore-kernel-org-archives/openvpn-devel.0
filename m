From: "Fish Wang" <fish.thss@...277...>
References: <CADCH5OiOnfpf1XZ6HTgJVkFjS8MTcwBTCNdD9m5JKz8U0147jA@...278...>
	<20151210085619.GB24952@...1296...>
In-Reply-To: <20151210085619.GB24952@...1296...>
Date: Thu, 10 Dec 2015 15:14:22 -0800
Message-ID: <054b01d133a0$82105f30$86311d90$@gmail.com>
MIME-Version: 1.0
Content-Language: zh-cn
Subject: Re: [Openvpn-devel] [PATCH] Make ValdikSS's DNS leak fix platform
	agnostic
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
To: 'Gert Doering' <gert@...1296...>
Cc: iam@...2070..., 'openvpn-devel' <openvpn-devel@lists.sourceforge.net>

Hi Gert,

A new patch will follow.

Best,
Fish

-----Original Message-----
From: Gert Doering [mailto:gert@...1296...] 
Sent: Thursday, December 10, 2015 12:56 AM
To: Fish Wang <fish.thss@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>; iam@...2070...
Subject: Re: [Openvpn-devel] [PATCH] Make ValdikSS's DNS leak fix platform
agnostic

Hi,

On Wed, Dec 09, 2015 at 05:30:14PM -0800, Fish Wang wrote:
> Based on release/2.3 branch, this patch is cross-compiled in MinGW and
> tested on Windows XP/10. The VC project file is left untouched - you might
> want to add rpcrt4.lib to compile and link it under MSVC.
> 
> Also, I didn't figure out how to keep ValdikSS's authorship of his code in
> the patch (sorry :-( ). Definitely no expert in git... Maybe I should
> generate a patch on top of his latest patch?

The latter is much better.  Use git release/2.3, apply ValdikSS' v8 patch on

top of that, and then do your changes - that way, proper author attribution
is there, and we can see much easier what you changed.  Right now this is
a long piece of code that differs only in a vew lines from "one of the
8 different patch versions from ValdikSS".  Hard to review.

thanks,

gert

-- 
USENET is *not* the non-clickable part of WWW!
 
//www.muc.de/~gert/
Gert Doering - Munich, Germany
gert@...1296...
fax: +49-89-35655025
gert@...1297...


