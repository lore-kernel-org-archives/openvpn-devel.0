MIME-Version: 1.0
References: <20260315184337.1541272-1-luca.boccassi@...277...>
 <20260315230620.1594780-1-luca.boccassi@...277...>
 <20260315230620.1594780-2-luca.boccassi@...277...>
 <b54e0eae-8fe2-420e-ba24-4d73ca50086d@...1227...>
 <CAMw=ZnQy+i0debrWv2ya=xy12_h1EmrRVfiuKEK9-aWZ6GJRoQ@...278...>
 <150f9ffe-bf48-43dd-86aa-b69961de1f99@...1227...>
In-Reply-To: <150f9ffe-bf48-43dd-86aa-b69961de1f99@...1227...>
From: Luca Boccassi <luca.boccassi@...277...>
Date: Mon, 16 Mar 2026 12:09:17 +0000
Message-ID: <CAMw=ZnQxvpy2Xx2rFHZCJprzx=SG_SC-i1O80noVRT7_BAOKJQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Increase TLS_CHANNEL_BUF_SIZE
 from 2048 to 8192
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, 16 Mar 2026 at 12:05, Arne Schwabe <arne@...1227...> wrote:
> > Could you please clarify what you mean by compatibility problems? And
> > what would be the right approach instead to let the client process
> > larger passwords? Thanks
>
> By compatibility problem I mean that a peer that is modified like you
> are suggesting will not be able to communicate to other peers without
> that patch.
>
> This should be pretty obvious from the way you are changing the code
> that you allow a send buffer of 8k but do not take into account that
> peers without that patch only have 2k to receive.

Thanks, first time I work on this repo so trying to get familiar with
these details, I'll look into it.

The issue here is that the handshake fails, as the azvpn server
expects a full token to be received, but it gets truncated. I have no
control over the server, just the client. Do you have a suggestion on
how to solve this in a way that would be acceptable?

