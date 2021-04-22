References: <20210421134348.1950392-1-arne@...1227...>
 <20210421134348.1950392-2-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <770ef286-442f-276c-c550-b21bfcb7ff58@...2181...>
Date: Thu, 22 Apr 2021 02:03:44 +0200
MIME-Version: 1.0
In-Reply-To: <20210421134348.1950392-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/7] Move direct.h header where it is
 used
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

On 21/04/2021 15:43, Arne Schwabe wrote:
> The direct.h header provides only a handful of functions [1] of which
> we only use _wchdir. Directly included the direct.h file where it is
> used and remove autoconf magic around it.
> 
> [1] https://docs.microsoft.com/en-us/previous-versions/visualstudio/visual-studio-2012/as5kw0ze(v=vs.110)?redirectedfrom=MSDN
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

Should this be removed too?

config-msvc.h:33:#define HAVE_DIRECT_H 1


Regards,



-- 
Antonio Quartulli

