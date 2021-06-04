MIME-Version: 1.0
References: <20210507145644.195-1-lstipakov@...277...>
 <202105101557.14AFvbud098718@...2054...>
In-Reply-To: <202105101557.14AFvbud098718@...2054...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 4 Jun 2021 17:33:25 +0300
Message-ID: <CAGyAFMUH0e-Uoxik+PfS03RUAyTSseCQUmjOKbTsu=SeD4Bhdg@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: msvc: add ARM64
 configuration
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

This can be applied to release/2.5 as well.

ma 10. toukok. 2021 klo 18.58 Gert Doering (gert@...1296...) kirjoitti:
>
> Acked-by: Gert Doering <gert@...1296...>
>
> I have no idea what these things do, but the new blocks look reasonably
> similar to the existing XML, just with "ARM64".  No code changes.
>
> And since Lev is the one who understands MSVC this is good enough for me :-)
>
> Your patch has been applied to the master branch.
>
> commit 8de7e643baefcb6a3000a3a89ae42ce1328a9a7d
> Author: Lev Stipakov
> Date:   Fri May 7 17:56:44 2021 +0300
>
>      msvc: add ARM64 configuration
>
>      Signed-off-by: Lev Stipakov <lev@...515...>
>      Acked-by: Gert Doering <gert@...1296...>
>      Message-Id: <20210507145644.195-1-lstipakov@...277...>
>      URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22325.html
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

