Subject: Re: [Openvpn-devel] Problem with regenerate ac/am stuff.
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1063758974.56444@...41...>
In-Reply-To: <8stemv0kdc7e2mlbfedacq1bepruuppevj@...105...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Sep 16 17:37:14 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arkadiusz Patyk <areq@...104...>, openvpn-devel@lists.sourceforge.net

Arkadiusz,

The missing malloc.c is a known bug in beta7 and will be fixed in beta8.

Alternatively, you can download malloc.c from:

http://openvpn.sourceforge.net/patch/malloc.c

or you can remove the AC_FUNC_MALLOC line from configure.ac

James

Arkadiusz Patyk <areq@...104...> said:

> Hi,
> 
> I have a problem with regenerate ac/am stuff.
> 
> + cd openvpn-1.5-beta7
> + aclocal
> + autoheader
> + autoconf
> + #touch malloc.c
> + automake -a -c -f --foreign
> Makefile.am:42: required file `./malloc.c' not found
> 
> Ugly hack:
> touch malloc.c before automake.
> 
> autoconf-2.57-6
> automake-1.7.7-1
> 
> Any ideas ?
> 
> Best regards,
> 
> -- 
> Arkadiusz Patyk [areq(at)pld-linux.org] [http://rescuecd.pld-linux.org]
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




