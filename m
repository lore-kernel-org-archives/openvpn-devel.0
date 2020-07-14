References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-3-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <632a9e27-a1d8-5ea2-baca-534c396aeed9@...2181...>
Date: Tue, 14 Jul 2020 10:51:18 +0200
MIME-Version: 1.0
In-Reply-To: <20200711093655.23686-3-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v5 03/14] client-connect: Refactor
 multi_client_connect_source_ccd
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

On 11/07/2020 11:36, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
> 
> Refactor multi_client_connect_source_ccd(), so that options_server_import() (or
> the success path in general) is only entered in one place within the function.
> 
> Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
> 
> Patch V5: Simplify the logic even further to make more easy to understand.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---

Shouldn't this patch also bear Fabian's signature?

Anyway, other than the stylistic point made by Gert this patch looks
good. It's mostly creating a new interface without really introducing
any radical change.

Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

