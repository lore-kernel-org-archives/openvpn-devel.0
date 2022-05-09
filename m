Message-ID: <1c49666b-032a-4978-dd2c-6879c308bf5a@...2181...>
Date: Mon, 9 May 2022 13:52:49 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220429170236.48239-1-kprovost@...2661...>
 <20220429170236.48239-4-kprovost@...2661...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220429170236.48239-4-kprovost@...2661...>
Subject: Re: [Openvpn-devel] [PATCH 3/4] Ensure dynamic_name is always
 populated
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
To: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 29/04/2022 19:02, Kristof Provost via Openvpn-devel wrote:
> From: Kristof Provost <kp@...1376...>
> 
> It's always used for open_tun_dco(), so we must ensure it's populated,
> even if 'dev_node' is set.
> 
> Signed-off-by: Kristof Provost <kprovost@...2661...

I squashed this change in the dco branch.
Thanks a lot!

Regards,

-- 
Antonio Quartulli

