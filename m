From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] status.c patch
In-Reply-To: <1b2a01c4e11a$e22dfb00$0600000a@...139...>
Message-ID: <Pine.LNX.4.58.0412131559580.26365@...41...>
References: <1b2a01c4e11a$e22dfb00$0600000a@...139...>
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
Date: Mon Dec 13 15:04:05 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Gisle Vanem <giva@...258...>
Cc: OpenVPN-dev <openvpn-devel@lists.sourceforge.net>

On Mon, 13 Dec 2004, Gisle Vanem wrote:

> It looked rather suspicious to want (S_IRUSR | S_IWUSR) for MingW 
> when opening files in status.c. Patch:
> 
> --- status.c.orig       Wed Dec 08 00:52:04 2004
> +++ status.c    Mon Dec 13 14:44:17 2004
> @@ -77,7 +77,7 @@
>         {
>           switch (so->flags)
>             {
> -#ifdef _MSC_VER
> +#ifdef WIN32
>              case STATUS_OUTPUT_WRITE:
>                so->fd = open (filename,
>                               O_CREAT | O_TRUNC | O_WRONLY,

It's not strictly necessary, since MinGW has:

sh-2.04$ grep -Er '_S_IRUSR|_S_IWUSR' .
./sys/stat.h:#define    _S_IWUSR        _S_IWRITE
./sys/stat.h:#define    _S_IRUSR        _S_IREAD
./sys/stat.h:#define    S_IWUSR         _S_IWUSR
./sys/stat.h:#define    S_IRUSR         _S_IRUSR

James

