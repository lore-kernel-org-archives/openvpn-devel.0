Message-ID: <009701c20a62$13fc4d90$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <003f01c2099e$ee25c290$1000000a@...4...> <20020602090401.GA2902@...6...>
Subject: Re: [Openvpn-devel] New OpenVPN beta available for testing
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Sun Jun  2 11:19:02 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Alberto Gonzalez Iniesta <agi@...5...>, openvpn-devel@lists.sourceforge.net

> > * Added ACX_PTHREAD (from the autoconf
> >   macro archive) to configure.ac
> >   to figure out the right pthread
> >   options for a given platform.
>
> Hi James,
>
> I some archs in Debian build binary packages using gcc3, the following
> patch solved the problem:
>
> --- openvpn-1.2.0.orig/configure
> +++ openvpn-1.2.0/configure
> @@ -9716,7 +9716,7 @@
>                 CFLAGS="$CFLAGS -pthread"
>                 ;;
>           *)
> -               CFLAGS="$CFLAGS -pthread"
> +               CFLAGS="$CFLAGS -lpthread"
>                 ;;
>           esac
>
> --- openvpn-1.2.0.orig/configure.ac
> +++ openvpn-1.2.0/configure.ac
> @@ -284,7 +284,7 @@
>                 CFLAGS="$CFLAGS -pthread"
>                 ;;
>           *)
> -               CFLAGS="$CFLAGS -pthread"
> +               CFLAGS="$CFLAGS -lpthread"
>                 ;;
>
>
> The new configure* scripts work flawlessly :-)

Cool!  I did see that patch over on Debian, unfortunately it's not a
portable solution...  I did some fishing and found ACX_PTHREAD which looks
like it's the Right way to do this.

James



