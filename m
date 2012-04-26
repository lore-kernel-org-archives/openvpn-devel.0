MIME-Version: 1.0
Sender: fabian@...1547...
In-Reply-To: <1333366661-6711-1-git-send-email-alon.barlev@...277...>
References: <1333041552-6752-1-git-send-email-alon.barlev@...277...>
	<1333366661-6711-1-git-send-email-alon.barlev@...277...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Thu, 26 Apr 2012 14:45:35 +0200
Message-ID: <CAP+U6t+A2X1xtEt-ZGZfByjJ=Cipx0LwBYRupY9NdXiiCUbK6w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup: add .gitattributes to control
 eol style explicitly
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

Hi Alon,

2012/4/2 Alon Bar-Lev <alon.barlev@...277...>:
> Having the text auto detection is a risk, as the detection may detect
> text files that are not text and vise versa.
>
> Having global setting will create confusion and differentiate between
> users. So this patch also move this to local repository.

IMHO, this is a real benefit. Reduces the number of steps necessary to
contribute and avoids line-ending mistakes for new contributions.

> Having git to check out files differently in different OS is also
> a not correct, as checkouts may be used in shares or in *NIX emulation
> environments, so it have no effect.
>
> Another issue is packaging, if we change out the tree differently
> in several OSes, we may have different package content, which is
> something that should be avoided.
>
> Currently any editor of MS supports LF end of lines, so there is no
> need to convert source files while checking out.
>
> The visual studio files should be stored as CRLF as they are generated
> by visual studio every save, in a way that CRLF are added.
>
> I handled only the files that may be touch by MS users.

The rest I generally agree with, but don't have strong feelings about them.

> diff --git a/.gitattributes b/.gitattributes
> new file mode 100644
> index 0000000..34463f9
> --- /dev/null
> +++ b/.gitattributes
> @@ -0,0 +1,7 @@
> +*.c eol=lf
> +*.h eol=lf
> +*.rc eol=lf
> +*.txt eol=lf
> +*.bat eol=lf
> +*.vc*proj* eol=crlf
> +*.sln eol=crlf

Why not .rc and .bat as crlf too?

Apart from that, ACK.

Cheers
Fabian

