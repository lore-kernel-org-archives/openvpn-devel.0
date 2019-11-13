MIME-Version: 1.0
References: <20191113085854.6016-1-tom.ty89@...277...>
 <CAGnHSEnZraNv72SvtfdiipptQ4ESHvOSBn87vJREdh6trCb7ng@...278...>
 <20191113091844.GA40538@...1296...>
In-Reply-To: <20191113091844.GA40538@...1296...>
From: Tom Yan <tom.ty89@...277...>
Date: Wed, 13 Nov 2019 17:30:52 +0800
Message-ID: <CAGnHSEm9S2bSYpU97tEDF6nrUNRxR0dFP6RU2=VbZgD2Htw85w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix server directive for /31 subnet
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
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 13 Nov 2019 at 17:18, Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> It might be related to the way the windows tap6 driver always needs a
> gateway address even in tun mode (and uses the last address from the
> subnet for this).  There's very few typos in OpenVPN code regarding
> *this* type of math, and way more "just funny platforms and old lore".

The reason I think it is a typo is because the pool start is network
address + 2 (i.e. I think it's a copy-and-paste kind of typo). AFAIK,
the gateway address issue is addressed in commit 4cc6a25 by using the
pool start for that. (The commit message stated that using the address
of the server does not work for Windows.)

In any case, should I just keep it as-is just to be "conservative"?

> Not sure.  This code has been rewritten a number of times over the
> years, so maybe the assignment slipped outside of an if() block...

Again, should I keep it as-is, or "try it and see"?

> Things like this can (and should) all be fixed, but please do not lump
> them together with a functional change in one big patch.

No problem, I can split it and resend.


>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh Mistress
>
> Gert Doering - Munich, Germany                             gert@...1296...

