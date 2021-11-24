MIME-Version: 1.0
References: <20211119015548.687-1-lstipakov@...277...>
 <202111241005.1AOA5Os7011522@...2054...>
In-Reply-To: <202111241005.1AOA5Os7011522@...2054...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 24 Nov 2021 16:26:37 +0200
Message-ID: <CAGyAFMWf57YwLvvDERYmUv4427amuAkHro5c4vMHP-7huLoxaA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Load OpenSSL config on
 Windows from trusted location
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Do we need this fix in openvpn-gui? It only (?) uses openssl to change
private key password, could this functionality be affected by config?

ke 24. marrask. 2021 klo 12.06 Gert Doering (gert@...1296...) kirjoitti:
>
> Your patch has been applied to the master and release/2.5 branch
> (I consider this a bugfix since the "do not load config!" CVE patch
> unintendedly broke functionality for people)
>
> As instructed I have changed "* " to " *" according to style :-), and
> removed the double declaration in buffer.h - the latter is something
> on the edge of "can I do that at commit time?" but in this case it's
> "the very same declaration", "tun.c and win32.c do include win32.h",
> so easy enough.
>
> I did not change the "static" bit.
>
> I have not tested this "for real", just did a test compile of master
> and release/2.5 on MinGW.  But the code change looks good, and it does
> not break compilation, even with my changes :-)
>
> Added the trac reference to #1296 (thanks Lev for digging it up).
>
> commit 23e6aaef149bd31a7e80af28ee1e3658d2810d4f (master)
> commit f911b3f69b0a8296918a06d02eb5144bb4cd8a06 (release/2.5)
> Author: Lev Stipakov
> Date:   Fri Nov 19 03:55:48 2021 +0200
>
>      Load OpenSSL config on Windows from trusted location
>
>      Signed-off-by: Lev Stipakov <lev@...515...>
>      Acked-by: Selva Nair <selva.nair@...277...>
>      Message-Id: <20211119015548.687-1-lstipakov@...277...>
>      URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23248.html
>      Signed-off-by: Gert Doering <gert@...1296...>
>
>
> --
> kind regards,
>
> Gert Doering
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



--
-Lev

