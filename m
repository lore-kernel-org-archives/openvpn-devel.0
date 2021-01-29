References: <ca157141-dc88-8017-0e6e-3ace055bc36e@...2181...>
 <20210125124330.30046-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <0b03aed9-b6f6-ddc6-f145-a4118dbe7e18@...2181...>
Date: Fri, 29 Jan 2021 09:51:51 +0100
MIME-Version: 1.0
In-Reply-To: <20210125124330.30046-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] Allow running a default
 configuration with TLS libraries without BF-CBC
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

On 25/01/2021 13:43, Arne Schwabe wrote:
> Modern TLS libraries might drop Blowfish by default or distributions
> might disable Blowfish in OpenSSL/mbed TLS. We still signal OCC
> options with BF-CBC compatible strings. To avoid requiring BF-CBC
> for this, special this one usage of BF-CBC enough to avoid a hard
> requirement on Blowfish in the default configuration.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> 
> Patch v2: add more clarifying comment, do not warn about OCC only insecure
>           ciphers, code improvements
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Acked-by: Antonio Quartulli <antonio@...515...>

-- 
Antonio Quartulli

