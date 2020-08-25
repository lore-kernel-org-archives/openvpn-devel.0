References: <20200825073643.15920-1-arne@...1227...>
 <20200825073643.15920-2-arne@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <45e5b26d-36d5-e07c-e449-39ae0fcff7e5@...277...>
Date: Tue, 25 Aug 2020 10:21:24 +0100
MIME-Version: 1.0
In-Reply-To: <20200825073643.15920-2-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v4 2/2] Implement generating data
 channel keys via EKM/RFC 5705
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

This sentence is badly constructed, so, use some grammar to help it read 
correctly:


On 25/08/2020 08:36, Arne Schwabe wrote:

> + * When the client sends the IV_PROTO_TLS_KEY_EXPORT flag and the server replies
> + * with `key-derivation tls-ekm` the RFC5705 key material exporter with the
> + * label EXPORTER-OpenVPN-datakeys is used for the key data.
>    *



 > + * When the client sends the IV_PROTO_TLS_KEY_EXPORT flag and the 
server replies
 > + * with `key-derivation tls-ekm` *then* the RFC5705 key material 
exporter, with the
 > + * label EXPORTER-OpenVPN-datakeys, is used for the key data.
 >    *


Sorry to be a pain ..


