Message-ID: <0668f04e-bbcd-e084-c90f-c4cc58992223@...1227...>
Date: Mon, 12 Dec 2022 15:14:05 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20221212095832.2123-1-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20221212095832.2123-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] management: refactor bytecount
 routines
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Am 12.12.22 um 10:58 schrieb Lev Stipakov:
> From: Lev Stipakov <lev@...515...>
> 
> In preparation of DCO stats support, simplify
> call chains of bytecount routines. No functional changes.


It would be nice to be a bit more verbose what you are actually 
simplyfing in the commit message. E.g. inlining all the various function 
that are used only once.

> +
> +void
> +management_bytes_client(struct management *man,
> +                        const int size_in,
> +                        const int size_out)
> +{
> +    if (!(man->persist.callback.flags & MCF_SERVER))
> +    {
> +        man->persist.bytes_in += size_in;
> +        man->persist.bytes_out += size_out;
> +        man_bytecount_output_client(man);
> +    }
>   }

I don't like this part of the change. We are here moving a inline 
function from the critical path of data channel packets that is called 
on every single packet into an non-inline function.

The old code was taking care that everything that was in that critical 
path can be inlined. The new code breaks that promise.


  Arne

