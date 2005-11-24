From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] OpenVPN AutoConf macro bug
In-Reply-To: <20051122162842.GK32660@...507...>
Message-ID: <Pine.LNX.4.58.0511232247000.7087@...41...>
References: <20051122162842.GK32660@...507...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Nov 24 00:03:01 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: David Stipp <dstipp@...507...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 22 Nov 2005, David Stipp wrote:

> Hi all,
> 
> There's a bug in the autoconf macros that cause the compile to fail on
> Sun Studio 9.  One of the tests (empty array support) is not escaped
> properly, so the macro int bar[0] expands to int bar0, which won't
> exactly test what it needs to be testing...
> 
> Patch below.  (basically put the bar[0] brackets within brackets.)
> 
> ********************************************************************************
> --- acinclude.m4.orig   2005-11-21 17:13:48.214828000 -0600
> +++ acinclude.m4        2005-11-21 17:12:51.172087000 -0600
> @@ -19,7 +19,7 @@
>    AC_MSG_RESULT([checking for C compiler empty array support])
>    AC_COMPILE_IFELSE(
>      [
> -        struct { int foo; int bar[0]; } mystruct;
> +        struct { int foo; int bar[[0]]; } mystruct;
>      ], [
>          AC_DEFINE_UNQUOTED(EMPTY_ARRAY_SIZE, 0, [Dimension to use for
> empty array declaration])
>      ], [
> ********************************************************************************
> 
> I checked trunk in svn last night and noticed the same problem.  It's be
> nice if this change could be included.

Thanks -- nice catch.  I will merge this as well in the next 2.0.x and 2.1 
releases.

James


