MIME-Version: 1.0
In-Reply-To: <1323303229-31079-1-git-send-email-davids@...1347...>
References: <1323303229-31079-1-git-send-email-davids@...1347...>
Date: Thu, 8 Dec 2011 09:44:48 +0200
Message-ID: <CAOazyz1wxUHB27gj0y7L048af-ajfqvZno5KjtFUC9Ad4Uqn3w@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Add a wrapper for access() when
 compiling via Visual Studio
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Dec 8, 2011 at 2:13 AM, David Sommerseth <davids@...1347...> wrote:
> +/* The POSIX access() function is called via _access() on Windows,
> + * defined in io.h
> + */
> +#define HAVE_ACCESS 1
> +#define access _access
> +#pragma warning(disable : 4996) /* Avoid Visual Studio to complain about access(), which is redefined */

Where is it defined?
Anyway, won't it better:
---
#ifdef access
#undef access
#endif
#define access _access
---

Alon.

