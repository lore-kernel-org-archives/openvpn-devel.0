Message-ID: <bb8a7ffd-91e8-24c4-da12-01a8af5cbee2@...1227...>
Date: Wed, 29 Dec 2021 19:23:29 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211229172714.6424-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20211229172714.6424-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] options.c: fix version reported in
 --cipher warning message
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 29.12.21 um 18:27 schrieb Antonio Quartulli:
> BF-CBC is the default value for the --cipher option in OpenVPN <2.5
> and not <2.6. However, the warning printed to screen talks about
> "OpenVPN before 2.6", which is wrong and needs to be fixed.
> 
> Fix message by saying ".. before 2.5"

Technically it is still the default value but not added to data-ciphers 
anymore but that doesn't matter for the message :)

Acked-By: Arne Schwabe <arne@...1227...>

