Message-ID: <59a190df-7991-265d-27aa-58a484e247d4@...1227...>
Date: Tue, 28 Jun 2022 16:23:19 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-11-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220624083809.23487-11-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 10/25] dco: periodically check and
 possibly rotate/delete keys
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

Am 24.06.22 um 10:37 schrieb Antonio Quartulli:
> +    ASSERT(!primary || primary->dco_status != DCO_NOT_INSTALLED);

It would to be good to explain this assertion. I just spend too long 
understanding it and I understand the code. Something along the lines 
that we expect that primary key has been installed before here.

This code might also be subject to very unlikely (maybe not even 
possible) race condition.

When deferred auth is active and the deferred auth just happens at the 
edge of the window before timing out tls_select_encryption_key /might/ 
already return the new key without it having been a valid secondary key 
before. But maybe we fail for the timeout check before.

Arne

