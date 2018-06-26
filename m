Reply-To: openvpn-devel@lists.sourceforge.net
References: <20180605081407.6944-1-a@...2181...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <c9c95b63-e182-a02d-ae65-5d3cf2b6c75a@...2080...>
Date: Tue, 26 Jun 2018 23:33:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180605081407.6944-1-a@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v3 1/2] crypto: always reload
 tls-auth/crypt key contexts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

On 05/06/18 10:14, Antonio Quartulli wrote:
> In preparation to having tls-auth/crypt keys per connection
> block, it is important to ensure that such material is always
> reloaded upon SIGUSR1, no matter if `persist-key` was specified
> or not.

Has this been tested with --chroot and --user/--group?


-- 
kind regards,

David Sommerseth
OpenVPN Inc


