Message-ID: <9963b338-ae7c-b786-babc-4f1d005dfff6@...1227...>
Date: Mon, 22 May 2023 12:11:07 +0200
MIME-Version: 1.0
References: <20230517110230.2234266-1-arne@...1227...>
 <20230517110230.2234266-2-arne@...1227...>
 <CAKuzo_jQ6nCjWr-jCEUTvZKJC=XSdNrGx=jK+vguLuVd4eRkLA@...278...>
Content-Language: en-GB
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAKuzo_jQ6nCjWr-jCEUTvZKJC=XSdNrGx=jK+vguLuVd4eRkLA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix CR_RESPONSE mangaement message
 using wrong key_id
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Am 19.05.23 um 15:45 schrieb Selva Nair:
> Hi,
> 
> While this bugfix should be merged, I'm a conflicted about the way these 
> two patches are split up. It just makes reviewing harder than it should 
> be. They actually form two independent changes but with one half 
> intersecting with the other for no reason.

Yeah. I moved the logging to 1/2. It seems to fit much better in that patch.

Arne


