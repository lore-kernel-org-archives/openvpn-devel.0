Message-ID: <8cf2c0a0-7f63-4707-bedb-fb6a25e31d79@...2181...>
Date: Fri, 9 May 2025 16:15:43 +0200
MIME-Version: 1.0
References: <20250430123250.8627-1-a@...2181...>
 <20250505225549.19492-1-a@...2181...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20250505225549.19492-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next v2] ovpn: ensure sk is
 still valid during cleanup
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

On 06/05/2025 00:55, Antonio Quartulli wrote:

> Signed-off-by: Antonio Quartulli <antonio@...515...>

Merged to main, commit id 476148af4e28

So far we didn't spot any regression, so we'll move on with this fix for 
the time being as we know it is preventing the crash for good.

We can improve it later if we feel this is not the best we can do.

Cheers!

-- 
Antonio Quartulli


