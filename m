References: <20210406162518.4075-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d0c401d1-bad2-1cc5-43cf-dacc67cf7a92@...2181...>
Date: Tue, 6 Apr 2021 23:14:14 +0200
MIME-Version: 1.0
In-Reply-To: <20210406162518.4075-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/5] Remove check for socket functions
 and Win XP compatbility code
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

On 06/04/2021 18:25, Arne Schwabe wrote:
> While the check if all socket related functions are present sounds like
> a good idea in theory, in reality it just adds time to configure runs.
> 
> Our poll check on windows is currently only depending on sys/poll.h
> non-existance. Make the check and comment more explicit.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

This compiled fine on my various linux environments and also when using
mingw32 (both 32 and 64 bits).

However, I have no idea how this really impacts WindowsXP or other
Windows versions.


Cheers,


-- 
Antonio Quartulli

