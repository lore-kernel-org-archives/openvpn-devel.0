References: <E1lW0eX-00012w-9n@...2487...>
 <202104130557.13D5v3dv030280@...2054...>
From: Magnus Kroken <mkroken@...277...>
Message-ID: <54bcbe67-90cc-1f8e-5ff7-5c4a15fda096@...277...>
Date: Wed, 21 Apr 2021 23:44:25 +0200
MIME-Version: 1.0
In-Reply-To: <202104130557.13D5v3dv030280@...2054...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Fix build with mbedtls w/o
 SSL renegotiation support
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On 13.04.2021 07:57, Gert Doering wrote:
> Your patch has been applied to the master branch.
> 
> commit e4bd17c86e01aaf6f809d9ea355419c86c4defdc
> Author: Max Fillinger
> Date:   Mon Apr 12 19:46:17 2021 +0200
> 
>       Fix build with mbedtls w/o SSL renegotiation support

Please backport this to release/2.5 as well. 2.5.2 is affected by this 
and does not compile with an mbed TLS library built in this manner.

Regards,
Magnus Kroken

