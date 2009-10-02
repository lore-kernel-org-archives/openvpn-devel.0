From: Marcel =?iso-8859-1?q?Pennewi=DF?= <mailinglists@...1145...>
Date: Fri, 2 Oct 2009 21:29:41 +0200
References: <7bb795fd0909251436v2369d6d5q674e63e0621fcd56@...278...>
	<7bb795fd0909301526s535c0e9aidfad95b0228adb4e@...278...>
	<200910010814.38064.mailinglists@...1145...>
In-Reply-To: <200910010814.38064.mailinglists@...1145...>
MIME-Version: 1.0
Message-Id: <200910022129.41205.mailinglists@...1145...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn over ipv6 support -v0.4.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Thursday 01 October 2009 08:14:38 Marcel Pennewi=DF wrote:
> > > Please apply this patch:
> > also available as full patch at
> > =A0=A0http://cloud.github.com/downloads/jjo/openvpn-ipv6/openvpn-2.1_rc=
19-2.1
> >_r c19c-ipv6-0.4.7.patch.gz
>
> compiling failed with:
>
> multi.o: In function `management_client_auth':
> multi.c:(.text+0x22ee): undefined reference to `tls_authenticate_key'
> collect2: ld returned 1 exit status
>
> make[1]: *** [openvpn] Error 1
> make[1]: Leaving directory
> `/var/tmp/portage/net-misc/openvpn-2.1_rc19/work/openvpn-2.1_rc19'
> make: *** [install-recursive] Error 1

Problem seams to be "make -j3" on singlecore-system. "make -j2" works=20
perfectly.

regards,

Marcel

