Subject: Re: [Openvpn-devel] Files missing from BETA20 CVS
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1078262508.49331@...41...>
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
Date: Tue Mar  2 13:31:01 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>, openvpn-devel@lists.sourceforge.net

Matthias Andree <ma+ovpnd@...31...> said:

> Hi,
> 
> the files list.c, mroute.c and multi.c appear to be missing from the
> BETA20 branch in CVS:
> 
> ma@...174...:~/cvs-3rdparty/openvpn> LANG=C make -ks 2>&1 | grep ^make
> make[1]: *** No rule to make target `list.c', needed by `list.o'.
> make[1]: *** No rule to make target `mroute.c', needed by `mroute.o'.
> make[1]: *** No rule to make target `multi.c', needed by `multi.o'.
> make[1]: *** [openvpn.o] Error 1
> make[1]: Target `all-am' not remade because of errors.
> make: *** [all] Error 2

Ooops, it looks like I forgot to do a cvs add on some new files.

It's fixed now, and the BETA20 branch has been updated to reflect my current
development sources (I also updated the ChangeLog).

The current source should build and run a point-to-point tunnel correctly
using all the refactored code.  Grep for JYFIXME to see a bunch of gotchas in
the source -- mostly stuff that's there for debugging purposes.

The point-to-multipoint code is taking shape in multi.[ch] but is not finished
yet.

James


