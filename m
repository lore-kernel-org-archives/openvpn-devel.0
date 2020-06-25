MIME-Version: 1.0
References: <20200401193258.GY1431@...1296...>
 <20200625083745.211-1-lstipakov@...277...>
 <20200625085428.GR1431@...1296...>
In-Reply-To: <20200625085428.GR1431@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 25 Jun 2020 12:24:23 +0300
Message-ID: <CAGyAFMXj7Ei4ALL_zg91=YJ15qM7eS2MzS-wP3nd-KwECmb0FA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] msvc: fix various level2 warnings
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Hi,

> > -    qsort(cipher_list, num_ciphers, sizeof(*cipher_list), cipher_name_cmp);
> > +    qsort((void *)cipher_list, num_ciphers, sizeof(*cipher_list), cipher_name_cmp);
>
> I find this one questionable.  Qsort wants a void *, but every pointer type
> should be convertible to void *, without a warning?

Yes, but this is about "const". VS shows "'function': different
'const' qualifiers".
I'll go with this one:

    /* cast to non-const to prevent warning */
    qsort((EVP_CIPHER *)cipher_list, num_ciphers,
sizeof(*cipher_list), cipher_name_cmp);

> > -    msg(D_ROUTE, "interactive service msg_channel=%u", (unsigned int) c->options.msg_channel);
> > +    msg(D_ROUTE, "interactive service msg_channel=%u", (unsigned long long) c->options.msg_channel);
>
> This gets a NAK.  "%u" is "unsigned int", not (never!) (unsigned long long) -

Good point, thanks. The warning was about casting from HANDLE to
unsigned int. I'll change
format specifier to "%llu".

> > -                        (sd, IPPROTO_IP, IP_MTU_DISCOVER, &mtu_type, sizeof(mtu_type)))
> > +                        (sd, IPPROTO_IP, IP_MTU_DISCOVER, (const char *)&mtu_type, sizeof(mtu_type)))
>
> I find this questionable as well.  Setsockopt() on Unix wants a
> "void *", not a "const char *" - and this cast suggest to the reader
> that we're dealing with "something character based", which it is not.

That's the case in Windows:

https://docs.microsoft.com/en-us/windows/win32/api/winsock/nf-winsock-setsockopt

> int setsockopt( SOCKET s, int level, int optname, const char *optval, int optlen );

> >  show_available_tls_ciphers_list(const char *cipher_list,
> >                                  const char *tls_cert_profile,
> > -                                bool tls13);
> > +                                const bool tls13);
>
> I'm not sure why this is needed or beneficial?

Otherwise there is warning "formal parameter 3 different from declaration".

I noticed that mbedtls implementation doesn't have "const", so I'll
just remove it from openssl implementation and won't change header.

> >  void
> > -delete_route_connected_v6_net(struct tuntap *tt,
> > +delete_route_connected_v6_net(const struct tuntap *tt,
> >                                const struct env_set *es)
>
> I might be convinced that this is a useful change, but if it's needed(!)
> for delete_route_connected_v6_net(), the "cost" should be added to
> add_route_connected_v6_net() as well.

I looked closer and in fact second argument of delete_route_connected_v6_net()
is always NULL, so I'll remove that parameter.


-- 
-Lev

