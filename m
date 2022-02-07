Message-ID: <4f3b12fd-af55-e4f8-205e-149dbbfe68be@...2181...>
Date: Mon, 7 Feb 2022 09:49:52 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20211006180644.3081219-1-arne@...1227...>
 <20211105150742.2909443-1-arne@...1227...>
 <4407050c-4304-9112-7cb2-7a8489aaa315@...2181...>
 <d363a86d-088a-e81f-aed8-77f22f698397@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <d363a86d-088a-e81f-aed8-77f22f698397@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Default to --cipher BF-CBC if not
 set and compat-mode < 2.4.0
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

On 04/02/2022 20:12, Arne Schwabe wrote:
> A 2.4 client with ncp-disable should work nicely as well. We just do not 
> make ourselves compatible with 2.4.0 with ncp-disable if you select 
> 2.4.0, you need 2.3.0 for that.

Thanks for the hint!

Went the lazy route and tested against 2.4.11 with --ncp-disable.

Server: 2.4.11 with --ncp-disable (to mimic 2.3.x) and no --cipher 
specified (BF-CBC is therefore the default).

Client: master + this patch and no --cipher specified.

* First attempt: wrong cipher negotiated and connection breaks.
* Second attempt: add --compat-mode 2.3.0 to client (to exercise the 
code implemented by this patch) and I could happily connect to the 
2.3.x-like server using BF-CBC.



Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

