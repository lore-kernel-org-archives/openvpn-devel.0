MIME-Version: 1.0
References: <CAGyAFMVbX1m_LhB=rV1Kh0uqpjfgCy6WP9t1o2bLTT+dO-L9Gg@...278...>
 <20211109015927.311-1-lstipakov@...277...> <YY1HU85OwqH442H+@greenie.muc.de>
 <CAGyAFMXNmuHUphBCCnPtr+RJ5ygam5JNaK94VBGTU6mizkjCJw@...278...>
In-Reply-To: <CAGyAFMXNmuHUphBCCnPtr+RJ5ygam5JNaK94VBGTU6mizkjCJw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 12 Nov 2021 08:22:43 -0500
Message-ID: <CAKuzo_g=vsaogDMjxLfWA4ZpOkeY+0OTAudS_QyNkws3dU7QZQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Use network address for emulated DHCP
 server as a default
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
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

>
> How about we apply my original patch (0 for /28 and -1 for the rest)
> to 2.5 and this one to master?

I do not see the logic behind that. If there are any platforms where 0
(network address) is not acceptable, it's unlikely to work for /30 as
well. /31 is special, /30 is not. And, based on your tests 0 does work
on all platforms we support. Same was my conclusion the last time I
checked.

So I would also vote for the current patch as is.

Selva

