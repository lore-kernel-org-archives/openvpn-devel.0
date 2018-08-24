References: <149619ba-265f-1a7a-6403-f99c6f4b7eac@...1227...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <794a25e0-c143-76af-6dea-accbe8d6abc8@...277...>
Date: Fri, 24 Aug 2018 14:25:56 +0100
MIME-Version: 1.0
In-Reply-To: <149619ba-265f-1a7a-6403-f99c6f4b7eac@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Discussion: Moving forward with compression and
 voracle
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



On 24/08/18 12:11, Arne Schwabe wrote:
> Hey,
> 
> with this mail I would like to discuss the way forward for compression.
> 

<s>

> 
> Our default configuration has not compression enabled. So our default
> configuration is safe from Voracle. 

<s>

> 
> I would like to have some feedback what the rest of you thinks
> 

This could be improved..

https://github.com/OpenVPN/openvpn/blob/a6fd48ba36ede465b0905a95568c3ec0d425ca71/sample/sample-config-files/server.conf#L254

eg:

# WARNING: Enabling compression has known attacks, see VORACLE

# Enable compression on the VPN link and push the
# option to the client (v2.4+ only, for earlier
# versions see below)
;compress lz4-v2
;push "compress lz4-v2"

# This is the recommended configuration
;compress stub
;push "compress stub"

# For compression compatible with older clients use comp-lzo
# If you enable it here, you must also
# enable it in the client config file.
;comp-lzo

# This is the recommended configuration
;comp-lzo no
;push "comp-lzo no"



