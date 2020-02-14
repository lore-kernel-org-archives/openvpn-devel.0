MIME-Version: 1.0
References: <20191117181243.28919-3-arne@...1227...>
 <20200213135126.9131-1-arne@...1227...>
 <CAGyAFMUUqvVoioxidB0utxQUQ+YsbgNUO+Zhj9SHkvNNH1q+qQ@...278...>
 <c54791fe-3697-5591-52dd-ea589f565bd4@...1227...>
In-Reply-To: <c54791fe-3697-5591-52dd-ea589f565bd4@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 14 Feb 2020 16:49:27 +0200
Message-ID: <CAGyAFMW9z82hVTbDwooQoOyNuW55sYiWvRB+-BQ5ZexgSEKi1A@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/5] Move NCP related function into a
 seperate file and add unit tests
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I found this discussion

https://sourceforge.net/p/openvpn/mailman/message/34405489/

and wonder if we should replace strdup with string_alloc("AES-256-GCM").

If the result of strdup is NULL because of OOM, then following is NULL

    char *peer_ncp_list = tls_peer_ncp_list(peer_info);

and it is passed to

    const char *token = strtok(tmp_ciphers, ":");

and then behavior depends on the previous state of strtok.

string_alloc(), on the other hand, calls check_malloc_return(), which
prints "out of memory" and exits program.


pe 14. helmik. 2020 klo 16.35 Arne Schwabe (arne@...1227...) kirjoitti:
>
> Am 14.02.20 um 14:08 schrieb Lev Stipakov:
> > Hi,
> >
> > <skip>
> >
> > I was planning to send a separate patch, but since you moved
> > this code, maybe you could fix it here.
> >
> >> +bool
> >> +tls_item_in_cipher_list(const char *item, const char *list)
> >> +{
> >> +    char *tmp_ciphers = string_alloc(list, NULL);
> >> +    char *tmp_ciphers_orig = tmp_ciphers;
> >
> > This is redundant. strtok() manipulates string, but doesn't modify pointer,
> > unlike strsep. So it should be safe to to call
> >
>
> This patch is just moving code that it does not touch. The original code
> is from Steffan. If we fix it, that should go into a different patch I
> think.
>
> But yes you are correct. But the compiler will optimise that away I think :)
>
> Arne
>


-- 
-Lev

