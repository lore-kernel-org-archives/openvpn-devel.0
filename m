From: "Fish Wang" <fish.thss@...277...>
References: <1450127176-43837-1-git-send-email-fish.thss@...277...>
	<20160108152231.GI24952@...1296...>
In-Reply-To: <20160108152231.GI24952@...1296...>
Date: Fri, 8 Jan 2016 10:30:09 -0500
Message-ID: <010b01d14a29$76e1d040$64a570c0$@gmail.com>
MIME-Version: 1.0
Content-Language: zh-cn
Subject: Re: [Openvpn-devel] [PATCH] Make MSVC happy about route.c
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
Cc: openvpn-devel@lists.sourceforge.net

Thanks for your response. I'll ship a patch for master soon :-)

Best,
Fish

-----Original Message-----
From: Gert Doering [mailto:gert@...1296...] 
Sent: Friday, January 8, 2016 10:23 AM
To: Fish <fish.thss@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] [PATCH] Make MSVC happy about route.c

Hi,

On Mon, Dec 14, 2015 at 01:06:16PM -0800, Fish wrote:
> Move the definition of out to the beginning of functions to comply with
> old-style C compilers. Tested on MSVC 2010.
[..]
>  #elif defined (WIN32)
> -
> -  struct buffer out = alloc_buf_gc (64, &gc);
> +  out = alloc_buf_gc(64, &gc);
>    buf_printf (&out, "interface=%d", tt->adapter_index );
>    device = buf_bptr(&out);

As things turns out, this is now actually no longer needed in the 
release/2.3 branch, as with the new code from Lev, this looks like:

#elif defined (WIN32)
 
  if (win32_version_info() != WIN_XP)
    {
      struct buffer out = alloc_buf_gc (64, &gc);
      buf_printf (&out, "interface=%d", tt->adapter_index );
      device = buf_bptr(&out);
    }
 
... and as such, avoids this VS2010 pitfall (thanks anyway!).

Master still has problematic code here, so if VS2010 compatibility is
desired, I'd appreciate a patch for it.

gert

-- 
USENET is *not* the non-clickable part of WWW!
 
//www.muc.de/~gert/
Gert Doering - Munich, Germany
gert@...1296...
fax: +49-89-35655025
gert@...1297...


