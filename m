References: <20200401193258.GY1431@...1296...>
 <20200625083745.211-1-lstipakov@...277...>
 <20200625085428.GR1431@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <be627b67-b127-108f-2099-4e9e44ad303a@...1227...>
Date: Thu, 25 Jun 2020 11:18:36 +0200
MIME-Version: 1.0
In-Reply-To: <20200625085428.GR1431@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v2] msvc: fix various level2 warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: Lev Stipakov <lev@...515...>, openvpn-devel@lists.sourceforge.net


>> @@ -1812,7 +1812,7 @@ do_open_tun(struct context *c)
>>  #ifdef _WIN32
>>      /* store (hide) interactive service handle in tuntap_options */
>>      c->c1.tuntap->options.msg_channel = c->options.msg_channel;
>> -    msg(D_ROUTE, "interactive service msg_channel=%u", (unsigned int) c->options.msg_channel);
>> +    msg(D_ROUTE, "interactive service msg_channel=%u", (unsigned long long) c->options.msg_channel);
> 
> This gets a NAK.  "%u" is "unsigned int", not (never!) (unsigned long long) -
> if you want that, because the data type is so big, use %llu or %I64u
> (Windows special, according to common.h).

Or use the standardised ones. E.g. PRIu64 for uint64_t. We already use
that auth-token.c.

See also https://en.cppreference.com/w/cpp/header/cinttypes (or another
reference).


> 
>> index 04868cd6..8178ff06 100644
>> --- a/src/openvpn/mtu.c
>> +++ b/src/openvpn/mtu.c
>> @@ -175,7 +175,7 @@ set_mtu_discover_type(int sd, int mtu_type, sa_family_t proto_af)
>>  #if defined(HAVE_SETSOCKOPT) && defined(IP_MTU_DISCOVER)
>>              case AF_INET:
>>                  if (setsockopt
>> -                        (sd, IPPROTO_IP, IP_MTU_DISCOVER, &mtu_type, sizeof(mtu_type)))
>> +                        (sd, IPPROTO_IP, IP_MTU_DISCOVER, (const char *)&mtu_type, sizeof(mtu_type)))
> 
> I find this questionable as well.  Setsockopt() on Unix wants a 
> "void *", not a "const char *" - and this cast suggest to the reader
> that we're dealing with "something character based", which it is not.
> 
>>  #if defined(HAVE_SETSOCKOPT) && defined(IPV6_MTU_DISCOVER)
>>              case AF_INET6:
>>                  if (setsockopt
>> -                        (sd, IPPROTO_IPV6, IPV6_MTU_DISCOVER, &mtu_type, sizeof(mtu_type)))
>> +                        (sd, IPPROTO_IPV6, IPV6_MTU_DISCOVER, (const char *)&mtu_type, sizeof(mtu_type)))
> 
> Same here.
> 
>>  show_available_tls_ciphers_list(const char *cipher_list,
>>                                  const char *tls_cert_profile,
>> -                                bool tls13);
>> +                                const bool tls13);
> 
> I'm not sure why this is needed or beneficial?  This const stuff is
> good for pointers ("do not modify the pointed-to area") but for
> call-by-value arguments, the compiler can figure this out itself.

Clang tidy actually warns against this for integral types saying that
they are passed by value always in C++. Not sure if this also applies to C.

Arne


