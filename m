References: <20200911115916.16117-1-gert@...1296...>
 <9d04cb8e-83a5-505a-9031-44b0d9bf9331@...2181...>
 <20200917070157.GP976@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <f6a49701-d0fa-cf07-df74-fbb8d55866b0@...2181...>
Date: Thu, 17 Sep 2020 09:23:47 +0200
MIME-Version: 1.0
In-Reply-To: <20200917070157.GP976@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] If IPv6 pool specification sets pool
 start to ::0 address, increment.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 17/09/2020 09:01, Gert Doering wrote:
> We look at "base", which is only the host part, but "at most 32 bits of
> the host part".
> 
> (This is *your* code...!)

(self-shaming dance mode=ON)

Riiight, then drop this comment. The patch looks good, except for the
comment that needs more verbosity.


> 
> gert
> 

-- 
Antonio Quartulli

