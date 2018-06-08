MIME-Version: 1.0
References: <1528229170-6175-1-git-send-email-selva.nair@...277...>
 <20180608140137.GA57262@...1296...>
In-Reply-To: <20180608140137.GA57262@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 8 Jun 2018 10:50:53 -0400
Message-ID: <CAKuzo_gGX+b-qSPr0PSDA-zW5Bn_fCNQSb119W_kB0es1_FWOw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Replace M_DEBUG with D_LOW as the
 former is too verbose
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Fri, Jun 8, 2018 at 10:01 AM Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Tue, Jun 05, 2018 at 04:06:10PM -0400, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > M_DEBUG only indicates the type of the message and will print even
> > at verb 0.  Use D_LOW which is M_DEBUG combined with verb = 4 and
> > a mute level.
>
> This does not want to apply for me - the tun.c hunk says "apply at
> line 1043", but the line in question is in line 893, and the
> context is different.
>
> I assume this was on top of Antonio's v6-only 1/5?
>
> OTOH this is trivial enough... I think the patch makes sense, it will
> inevitably create a conflict with Antonio's v2 1/8, so I'll just
> mangle the patch by hand.

You are right, based on wrong branch. Sorry about that. And, thanks.

Selva

