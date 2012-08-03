From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 3 Aug 2012 09:45:22 +0200
Message-ID: <3004840.HQRGjKhztB@...1526...>
In-Reply-To: <CAOazyz3A8UDfdPmU5DgLSnkjR_LnTj0ctRunFDfYeh3PUh4S9Q@...278...>
References: <1343821058-11456-1-git-send-email-heiko.hund@...1489...>
	<1343920822-29161-1-git-send-email-heiko.hund@...1489...>
	<CAOazyz3A8UDfdPmU5DgLSnkjR_LnTj0ctRunFDfYeh3PUh4S9Q@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 2/2 v4] add API for plug-ins to write to
	openvpn log
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Alon

On Thursday 02 August 2012 20:20:45 Alon Bar-Lev wrote:
> Thanks, although I think the extra macro is not required.

It looked messy without it. That's why we have it.

> Last thing I see is that you need to #include <stdarg.h> as va_list is used.

It's included already.

> And last style comment, I don't think use of enum for bit fields is
> common, better to simply #define the constants.

I try to prefer enums over the preprocessor whenever I can. I like that there 
is a type that you can look up, even if it's not worth much besides that.

Heiko
-- 
Heiko Hund | Sr. Software Engineer | Tel +49-721-25516-237 | Fax -200
SOPHOS NSG | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germany


