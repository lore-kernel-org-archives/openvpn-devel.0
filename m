MIME-version: 1.0
Message-id: <08FAFA87DB33410B973A78243D6791E6@...139...>
From: Gisle Vanem <gvanem@...139...>
References: <1322828243-21196-1-git-send-email-davids@...1347...>
	<CAOazyz3QLENvuKcchda6sooFJCF60zT=AnrfhGnaXAhyHDBkPA@...278...>
Date: Fri, 02 Dec 2011 13:54:39 +0100
Subject: Re: [Openvpn-devel] [PATCH v2] Provide an access() wrapper
	for	Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; CHARSET=US-ASCII; charset="US-ASCII"; format=flowed;
 reply-type=original
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

"Alon Bar-Lev" <alon.barlev@...277...> wrote:

> Why not:
> #ifdef WIN32
> #define access _access
> #endif

We should write "#ifndef _MSC_VER". MingW's access() handles 
X_OK correctly. From MingW's <io.h>:

#ifdef __USE_MINGW_ACCESS
/*  Old versions of MSVCRT access() just ignored X_OK, while the version
    shipped with Vista, returns an error code.  This will restore the
    old behaviour  */
static inline int __mingw_access (const char* __fname, int __mode)
  { return  _access (__fname, __mode & ~X_OK); }
#define access(__f,__m)  __mingw_access (__f, __m)
#endif

--gv



