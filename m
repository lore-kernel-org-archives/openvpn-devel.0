Message-ID: <f7ba0a2f-ffcc-cf37-cb8b-61897ab9adbe@...2181...>
Date: Fri, 9 Sep 2022 08:58:58 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220909064126.482-1-lstipakov@...277...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220909064126.482-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] do_persist_tuntap: remove indentation
 level
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
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Hi,

On 09/09/2022 08:41, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> Reverse if condition - this allows us to get rid of
> indentation level, which makes code easier to read.
> 
> Signed-off-by: Lev Stipakov <lev@...515...>

Thanks for this change. I also firmly believe this style makes the code 
easier to read (and to brain process, imho).

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

