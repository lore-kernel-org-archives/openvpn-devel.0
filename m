References: <1498913642-32459-1-git-send-email-steffan.karger@...1435...>
 <1498913642-32459-4-git-send-email-steffan.karger@...1435...>
 <e063898a-6b6c-d716-824f-8e10b859d692@...2181...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <6c1bc6fc-4c09-2d9d-56fb-130c7aca2055@...1435...>
Date: Fri, 29 Dec 2017 10:26:16 +0100
MIME-Version: 1.0
In-Reply-To: <e063898a-6b6c-d716-824f-8e10b859d692@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 4/5] buffer_list_aggregate_separator():
 prevent 0-byte malloc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

On 28-12-17 23:51, Antonio Quartulli wrote:
> On 01/07/17 20:54, Steffan Karger wrote:
>> As pointed out in finding OVPN-05 of the cryptograpy engineering
>> audit (funded by Private Internet Access),
>> buffer_list_aggregate_separator() could perform a 0-byte malloc
>> when called with a list of 0-length buffers and a "" separator.
>> If other could would later try to access that buffer memory, this
>> would result in undefined behaviour.  To prevent this, always 
>> malloc() 1 byte.
>> 
>> To simplify as we go, use alloc_buf() to allocate the buffer.
>> This has the additional benefit that the actual buffer data (not
>> the contents) is zero-terminated, because alloc_buf() calls
>> calloc() and we have 1 extra byte of data.
>> 
>> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> 
> 
> Does it really make sense to continue the execution if we receive a
> list of empty buffers? Shouldn't we report this as an error?

Data is pushed to buffer lists from e.g. tls_send_payload(), where I'm
not sure that 'sending' 0-byte payload is an invalid operation.  So
instead of trying to figure out if that's possible, I prefer to just
make this function deal with it.

(Consider e.g. 0/n record splitting, which might want to 'send'
0-length data.)

I'll send follow-up patches to take care of your other remarks.

- -Steffan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJaRgo0AAoJEEEwndWOY1w5ajsH/AlPjZL21m1J+hFuhau30D6/
RkXQiR6bKSPhG1zW9IZ6voTz+/XTJK09t16ob4z0HiltRpZ35QXJ9QYKbMmgoOEe
IwOG2sDr1FZ8TZYlVOqYqZ9V2WISXsjuubhz6WCTEhkq0pXtBuMSEDqFZWdqjuVa
H7eBBd6Uw7VvyU4pPusQpPt5w1T39pQZkdLXj7XHSdOFJHYFKzuNwtGPCUrg67al
hObWWKGrbxczgMEZtLt/gqt5TWKsyBB4Uf+G1Qayb8TJuccyvYXUajfmjXufVHjd
e5U50FSp1QFS21aCU5ctjKPY/XjAxrx4BnUJUAg++aJw1a7+Z7utvPIDxin2TMU=
=7r2E
-----END PGP SIGNATURE-----

