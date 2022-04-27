Message-ID: <0ac50685-43e1-0ff9-3e7a-fe3396a15cc5@...2181...>
Date: Wed, 27 Apr 2022 16:51:40 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-7-arne@...1227...>
 <408bf431-bbfa-16c9-0b3d-be8676e408b4@...2181...>
 <YmlSrcvSYjvcc6pH@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <YmlSrcvSYjvcc6pH@...1296...>
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
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net



On 27/04/2022 16:26, Gert Doering wrote:
> Hi,
> 
> On Wed, Apr 27, 2022 at 04:04:41PM +0200, Antonio Quartulli wrote:
>> On 22/04/2022 16:29, Arne Schwabe wrote:
>>> The current place that we reload is a bit more efficient since it only
>>> triggers reload after a completed 3way handshake. On the other hand the
>>> key_state_init is a much more logical place and with the upcoming
>>> HMAC based UDP code and TCP code, the initialisation will only be done
>>> after a 3way handshake.
>>
>> There is something strange. Upon client reconnection the CRL is not
>> always reloaded. It feels as if "some stuff" are already initialized
>> (because we have a session for this client floating around) so we skip
>> that initialization and we also skip reloading the CRL.
> 

I take this back.

I managed to fool myself (and OpenVPN) because instead of really 
updating the CRL file, I was rather switching between two CRLs (one with 
client revoked, one with client allowed) using a symlink.

However, as reported in stat(2), stat() will follow the symlink and 
report stats about the linked file (which had a constant mtime).

To properly test the CRL-reload behaviour, I therefore had to change the 
symlink and then touch the linked file. This made my test correct and I 
could check that also the OpenVPN behaviour, with this patch, is 
actually correct.

Acked-by: Antonio Quartulli <a@...2181...>

Regards,

-- 
Antonio Quartulli

