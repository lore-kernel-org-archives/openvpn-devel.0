From: Antonio Quartulli <a@...2181...>
References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-4-arne@...1227...>
 <0b251f8c-9745-319b-db9e-58a661cd7e13@...2181...>
Message-ID: <ba5d23f9-30a5-f9a9-86c6-8de012642ae8@...2181...>
Date: Tue, 21 Jul 2020 15:47:39 +0200
MIME-Version: 1.0
In-Reply-To: <0b251f8c-9745-319b-db9e-58a661cd7e13@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v5 4/9] Implement tls-groups option to
 specify eliptic curves/groups
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



On 21/07/2020 15:46, Antonio Quartulli wrote:
> Aren't we calling strsep() twice in a row now?
> Once in the while() condition and once at the end of the cycle?
> 
> I think Arne agreed on the issue on IRC, but maybe forgot to fix the patch?
> 
> 

However, please note that now the patch compiles on my gitlab-ci test bench.

-- 
Antonio Quartulli

