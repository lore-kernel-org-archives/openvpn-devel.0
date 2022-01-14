Message-ID: <222922b3-377a-3eab-1edc-7dc692471196@...2181...>
Date: Fri, 14 Jan 2022 11:39:03 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220113190241.96-1-lstipakov@...277...>
 <c375afce-72df-95b7-c959-502d9b2d55fd@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <c375afce-72df-95b7-c959-502d9b2d55fd@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] tun: remove tun_finalize()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, Lev Stipakov <lstipakov@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 14/01/2022 11:32, Arne Schwabe wrote:
> 
>> +#define SocketHandleGetOverlappedResult(sh, io) (sh.is_handle ? \
>> +    GetOverlappedResult(sh.h, io->overlapped, io->size, FALSE) : \
>> +    WSAGetOverlappedResult(sh.s, io->overlapped, io->size, FALSE, 
>> io->flags))
>> +
>> +#define SocketHandleGetLastError(sh) (sh.is_handle ? \
>> +    GetLastError() : WSAGetLastError())
>> +
>> +#define SocketHandleSetLastError(sh, ...) (sh.is_handle ? \
>> +    SetLastError(__VA_ARGS__) : WSASetLastError(__VA_ARGS__))
>> +
>> +#define SocketHandleSetInvalError(sh) (sh.is_handle ? \
>> +    SetLastError(ERROR_INVALID_FUNCTION) : WSASetLastError(WSAEINVAL))
>> +

I think macros are just way simpler at handling varargs, as you just use 
... and __VA_ARGS__ in the code.

> 
> I would prefer small static inline functions here. With modern compilers 
> they get inlined and are nicer than these macros.
> 
> 
> 
>>   #else  /* ifdef _WIN32 */
>>   #define openvpn_close_socket(s) close(s)
>> @@ -1020,7 +1041,8 @@ link_socket_read_udp_win32(struct link_socket 
>> *sock,
>>                              struct buffer *buf,
>>                              struct link_socket_actual *from)
>>   {
>> -    return socket_finalize(sock->sd, &sock->reads, buf, from);
>> +    sockethandle_t sh = { .s = sock->sd };
> 
> It would be good to explicitly have is_handle = false here. Otherwise we 
> rely on implicit zero initialisation, which I am not sure is guaranteed 
> and it also is better for documentation.

I agree here - especially on the documentation bit.

Cheers,

> 
> Arne
> 
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 

-- 
Antonio Quartulli

