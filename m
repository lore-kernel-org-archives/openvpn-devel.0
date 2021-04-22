References: <20210421134348.1950392-1-arne@...1227...>
 <20210421134348.1950392-3-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <386b8668-b399-f17e-7893-b72db21f8a0c@...2181...>
Date: Thu, 22 Apr 2021 02:13:37 +0200
MIME-Version: 1.0
In-Reply-To: <20210421134348.1950392-3-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 3/7] Remove always enabled
 USE_64_BIT_COUNTERS define
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
> Also change the types to use C99 uint64_t and its printf u64 define.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

This patch looks good and compiles on my test rig.

As expected, it is basically removing a bunch of ifdefs always forced on
the "true-branch".

Since we recently confirmed that all our suppotred platforms also
support C99, I don't expect breakages on any *BSD either.

Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

