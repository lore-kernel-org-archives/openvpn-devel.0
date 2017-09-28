From: fragmentux <fragmentux@...277...>
References: <1b275182-8551-6100-e3e9-80c966c2b200@...277...>
Message-ID: <c2fbb372-cbfe-5231-66fa-33403a1566df@...277...>
Date: Thu, 28 Sep 2017 13:18:20 +0100
MIME-Version: 1.0
In-Reply-To: <1b275182-8551-6100-e3e9-80c966c2b200@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] Too much output at --verb 0 (bug?)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

SF bounced this .. resending

On 27/09/17 15:57, fragmentux wrote:
> Hi,
> 
> not sure if this really counts as a bug but ..
> 
> according to the manual --verb 0 = "No output except fatal errors"
> 
> This, however, is the output at --verb 0 (2.4.4)
> 
> == Start client:
> Option 'explicit-exit-notify' in [PUSH-OPTIONS]:3 is ignored by previous 
> <connection> blocks
> Option 'explicit-exit-notify' in [PUSH-OPTIONS]:9 is ignored by previous 
> <connection> blocks
> do_ifconfig, tt->did_ifconfig_ipv6_setup=0
> WARNING: this configuration may cache passwords in memory -- use the 
> auth-nocache option to prevent this
> 
> == Reconnect client:
> WARNING: 'link-mtu' is used inconsistently, local='link-mtu 1550', 
> remote='link-mtu 1602'
> WARNING: 'cipher' is used inconsistently, local='cipher AES-256-GCM', 
> remote='cipher AES-256-CBC'
> WARNING: 'auth' is used inconsistently, local='auth [null-digest]', 
> remote='auth SHA512'
> Option 'explicit-exit-notify' in [PUSH-OPTIONS]:3 is ignored by previous 
> <connection> blocks
> Option 'explicit-exit-notify' in [PUSH-OPTIONS]:9 is ignored by previous 
> <connection> blocks
> do_ifconfig, tt->did_ifconfig_ipv6_setup=0
> 
> None of these are Fatal errors ..
> 
> Thanks
> 

