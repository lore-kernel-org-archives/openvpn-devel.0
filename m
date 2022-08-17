Message-ID: <f5044f8b-f1eb-9f34-0fa8-1700cea6b7aa@...2181...>
Date: Wed, 17 Aug 2022 14:03:49 +0200
MIME-Version: 1.0
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
Subject: Re: [Openvpn-devel] Fix IV_PLAT_VER and UV_ variables sent without
 push-peer-info
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
To: openvpn-devel@lists.sourceforge.net

Patch is easy and by looking at the "breaking" commit it is easy to 
understand what happened: peer-info-detail levels have been shifted by 
one and what was "2" before is now "3".

So the check that decides to append the extra info should check for ">= 
3" (or "> 2") now.

This patch makes this change.

Note that this patch is lacking the SoB line.

Wouldn't be bad to also add some 'Fixes: ID ("commit title")' line


But........Arne, could you resend this patch rebased on top of latest 
master? It doesn't apply right now :-)

Cheers,


-- 
Antonio Quartulli

