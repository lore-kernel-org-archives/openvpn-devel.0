References: <CAAUX2SUjd8azhSZta8KT8b2LjTG6v7P6LxKwVN1-+U6B8_vtJg@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <21895770-6d58-9b0a-4d22-a8364edc40f3@...2181...>
Date: Wed, 25 Nov 2020 08:50:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAAUX2SUjd8azhSZta8KT8b2LjTG6v7P6LxKwVN1-+U6B8_vtJg@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [ovpn-dco] question about the comment about
 AEAD nonce
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Tony He <huangya90@...277...>, openvpn-devel@lists.sourceforge.net

Hi Tony,

The graphic is wrong. Some of the text that you can find in the code
comes from old internal documentation and it hasn't always been updated.

To clarify, AES-GCM (and ChaCha20Poly1305) accepts a 12 bytes nonce that
OpenVPN creates by concatenating the 4 bytes packet ID (sent over the
wire) with 8 bytes nonce-tail generated from the key material.

So all numbers in the doc are correct - just the hex string is wrong.

It is now fixed. Thanks for reporting.

Please note that the documentation in the code is still work in
progress, so some other inconsistency may jump out every now and then.

Cheers,

On 25/11/2020 03:33, Tony He wrote:
> Hi Antonio,
> 
> I'm reading the source code to study this module driven by intertest.
> I'm new to crypto stuffs. In pktid.h:
> 
> /* When the OpenVPN protocol is run in AEAD mode, use
>  * the OpenVPN packet ID as the AEAD nonce:
>  *
>  *    00000005 521c3b01 4308c041 83ba3099
>  *    [seq # ] [nonce_tail                                    ]
>  *    [               12-byte full IV                            ] ->
> NONCE_SIZE
>  *    [4-bytes                                                       ->
> NONCE_WIRE_SIZE
>  *    on wire]
>  */
> 
> /* AEAD nonce size */
> #define NONCE_SIZE 12
> 
> Is " 00000005 521c3b01 4308c041 83ba3099" wrong? Its size is 16 bytes,
> but you also comment
> "12-byte full IV" after two lines of it. 
> 
> Tony

-- 
Antonio Quartulli

