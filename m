References: <20200716134315.17742-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <5cc065bb-eb7f-f603-5a83-07b8984fe178@...2181...>
Date: Thu, 16 Jul 2020 17:13:08 +0200
MIME-Version: 1.0
In-Reply-To: <20200716134315.17742-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v7 1/6] client-connect: Add
 CC_RET_DEFERRED and cope with deferred client-connect
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 16/07/2020 15:43, Arne Schwabe wrote:
> This patch moves the state, that was previously tracked within the
> multi_connection_established() function, into struct client_connect_state.  The
> multi_connection_established() function can now be exited and re-entered as
> many times as necessary - without losing the client-connect handling state.
> 
> The patch also adds the new return value CC_RET_DEFERRED which indicates that
> the handler couldn't complete immediately, and needs to be called later.  At
> that point multi_connection_established() will exit without indicating
> completion.
> 
> Each client-connect handler now has an (optional) additional call-back:  The
> call-back for handling the deferred case.  If the main call-back returns
> CC_RET_DEFERRED, the next call to the handler will be through the deferred
> call-back.
> 
> Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
> 
> Patch V3: Use a static struct in multi_instance instead of using
>           malloc/free and use two states (deffered with and without
>           result) instead of one to eliminate the counter that was
>           only tested for > 0.
> 
> Patch V5: Use new states in context_auth instead of the extra state
>           that the patch series previously used.
> 
> Patch V6: Restructure code to make it a bit more readable, rebase on
>           master.
> 
> Patch V7: move defferred bool into client connect handler calls, switch
>           to switch case
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>


Haven't done a full test, this is why we have "Gert and his rig"[tm],
but the code looks good and I can't spot anything that may trigger my
personal alarm.

This version is much cleaner that what it looked like before. Thanks
Arne for reworking the patch once again.

Acked-by: Antonio Quartulli <antonio@...515...>

-- 
Antonio Quartulli

