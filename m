Message-ID: <2a8d3a58-502b-b3e2-e636-111fda278477@...2181...>
Date: Thu, 4 Aug 2022 11:40:32 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220803194211.1727822-1-gert@...1296...>
 <20220804082502.1750074-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220804082502.1750074-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v2] Break 'try 256 dco devices' loop on
 EPERM
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 04/08/2022 10:25, Gert Doering wrote:
> If we get a permission denied error on one DCO device, trying 255 more
> times will not succeed, and just fill the log file with errors.
> 
> Also, remove the msg() call there because it was at debug level
> (needed --verb 4 to be seen), didn't see the correct errno, and the
> sitnl code already prints the error.
> 
> v2: use "else if"
> 
> Signed-off-by: Gert Doering <gert@...1296...>

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

