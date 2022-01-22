Message-ID: <ba7d9faa-34bf-6bad-7d4f-9ddbc1fac76f@...1227...>
Date: Sat, 22 Jan 2022 03:38:08 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20220121185752.14138-1-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20220121185752.14138-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Do not error when md_kt_size() is
 called with mdname="none"
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
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 21.01.22 um 19:57 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> An easy way to trigger this error is to run an otherwise working setup
> (at say verb = 4) with increased verbosity of verb >= 7 and using a GCM
> cipher (e.g., AES-256-GCM). It will cause a fatal exit while printing the
> cipher and hmac in key2_print().
> 
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> Its actually md_get("none") called by md_kt_size("none") that
> causes the error and I'm not entirely sure whether we should
> instead make md_get("none") to return NULL. But that would
> require all its callers to check for NULL.

Thanks for finding this.

Acked-By: Arne Schwabe <arne@...1227...>

