Message-ID: <b5a7bbbe-fe1f-4f4f-b7a8-d911f289db8c@...1227...>
Date: Fri, 18 Oct 2024 00:34:15 +0200
MIME-Version: 1.0
References: <20241017064955.23959-1-gert@...1296...>
 <202410170701.49H71192039177@...2054...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <202410170701.49H71192039177@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Improve data channel crypto
 error messages
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
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net


Am 17.10.2024 um 09:01 schrieb Gert Doering:
> Stared a bit at the code, poked MaxF to do a more thorough review (thanks),
> did a test compile.
>
> Out of curiosity - are you really seeing that many "authentication
> errors on bad connections"?  Aka "shouldn't lower-layer checksums not
> catch and drop packet corruptions"?

This is more the question of what happens if someone starts messing with 
our packets. At that point we should not start spamming the logs without 
any throttling.


Arne


