References: <20210406162518.4075-1-arne@...1227...>
 <20210406162518.4075-2-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <f16a3c68-89c0-c9a9-5a36-272979b8e95e@...2181...>
Date: Tue, 6 Apr 2021 22:39:59 +0200
MIME-Version: 1.0
In-Reply-To: <20210406162518.4075-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/5] Remove checks for uint* types that
 are part of C99
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
> Signed-off-by: Arne Schwabe <arne@...1227...>

As expected this patch creates no issues on the platforms I could test
(mingw, gcc-10 and gcc-9).

Acked-by: Antonio Quartulli <antonio@...515...>

Gert should be able to test on *more ancient things* that we still support.

Regards,


-- 
Antonio Quartulli

