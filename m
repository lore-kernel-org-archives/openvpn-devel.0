Message-ID: <408bf431-bbfa-16c9-0b3d-be8676e408b4@...2181...>
Date: Wed, 27 Apr 2022 16:04:41 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-7-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220422142953.3805364-7-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 16/28] Move CRL reload to key_state_init
 from S_START transition
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 22/04/2022 16:29, Arne Schwabe wrote:
> The current place that we reload is a bit more efficient since it only
> triggers reload after a completed 3way handshake. On the other hand the
> key_state_init is a much more logical place and with the upcoming
> HMAC based UDP code and TCP code, the initialisation will only be done
> after a 3way handshake.

There is something strange. Upon client reconnection the CRL is not 
always reloaded. It feels as if "some stuff" are already initialized 
(because we have a session for this client floating around) so we skip 
that initialization and we also skip reloading the CRL.


Regards,

-- 
Antonio Quartulli

