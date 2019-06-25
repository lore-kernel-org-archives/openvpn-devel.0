MIME-Version: 1.0
References: <1561491241-16380-1-git-send-email-lstipakov@...277...>
 <20190625194905.GM1097@...1296...>
 <CAKuzo_g200Ck8fBTMmTe93R5A_+FjGoK0zKNQr49i01RmHfHkw@...278...>
 <20190625203414.GN1097@...1296...>
In-Reply-To: <20190625203414.GN1097@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 25 Jun 2019 16:54:03 -0400
Message-ID: <CAKuzo_hz8vZ+WONCmY4ppc88A15Jvb=G+oBqBQnhxrCWRKv_eA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] openvpnserv: enable interactive service
 to open tun
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
Cc: Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi

On Tue, Jun 25, 2019 at 4:34 PM Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Tue, Jun 25, 2019 at 03:57:18PM -0400, Selva Nair wrote:
> > The way interactive service structures are coded should not require
> > this at all, does it? The size and message type are already in the
> > header, so why do we need to pass it? The result here is a new kind of
> > ack message with a different size and type and that could be checked
> > by accessing the header element. Unless I'm missing something.
>
> You could, indeed, do this inside send_msg_iservice() by looking
> at "what request did we sent?  so what should be coming back?" but
> I'm not sure I find this safe enough (caller allocates memory, and
> maybe we shouldn't rely on "it being big enough" unless explicitly
> told).  It would work, yes, but leaves me with a bit uneasy feeling.

I was thinking of dereferening the response pointer as a union and check the
header size which the caller is supposed to have set. So change ack * to
void * in send_msg_iservice()  as in the patch, and treat it as
ack or and extended ack depending on the specified size. Further, when
reading from the pipe one should also check the size of data received
matches what is expected.

It may be also useful to make all reply messages made up of an ack message
plus optional additional data -- ie., all start with a header and an error code.

Selva




>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh Mistress
>
> Gert Doering - Munich, Germany                             gert@...1296...

