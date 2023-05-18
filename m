Message-ID: <3a2e12d0-705f-4ee3-d892-25eb7fa33ef5@...68...>
Date: Thu, 18 May 2023 09:12:02 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230517200143.216-1-chipitsine@...277...>
 <a362a6e5-c80b-1473-d503-4e51befd22ee@...2181...>
 <f1428331-1d68-aafc-ba18-e7ce96ba363c@...68...>
 <ZGXPOEHPiim-dguK@...1296...>
From: Matthias Andree <matthias.andree@...68...>
In-Reply-To: <ZGXPOEHPiim-dguK@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] src/openvpn/dco_freebsd.c: handle
 malloc failure
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
To: openvpn-devel@lists.sourceforge.net

Am 18.05.23 um 09:09 schrieb Gert Doering:
> Hi,
>
> On Thu, May 18, 2023 at 09:00:26AM +0200, Matthias Andree wrote:
>> That, and constants usually go on the left-hand side of comparison so
>> the compiler flags the accidental if (foo = NULL) even if it does not
>> produce "add a pair of parentheses if you really mean to use an
>> assignment as if() expression" like warnings. You can't if (NULL = foo)...
> This is actually not OpenVPN style today (it's "syzzer style" so we find
> it in a few crypto modules).

I personally find if (B) or if (!B) more concise and clearer, too.


