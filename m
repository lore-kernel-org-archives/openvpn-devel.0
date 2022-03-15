Message-ID: <5965f690-8d38-51f9-7548-dff49afebeb4@...2181...>
Date: Tue, 15 Mar 2022 16:06:11 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220313200715.13518-1-openvpn@...2080...>
 <20220313200715.13518-3-openvpn@...2080...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220313200715.13518-3-openvpn@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2.4 v4 2/3] plug-ins: Disallow multiple
 deferred authentication plug-ins
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
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

Hi,

On 13/03/2022 21:07, David Sommerseth wrote:
> From: David Sommerseth <davids@...515...>
> 
> The plug-in API in OpenVPN 2.x is not designed for running multiple
> deferred authentication processes in parallel. The authentication
> results of such configurations are not to be trusted.  For now we bail
> out when this discovered with an error in the log.
> 
> CVE: 2022-0547
> Signed-off-by: David Sommerseth <davids@...515...>

Tested and it does what it says on the lid.
The whole approach requires larger refactoring, but for now this is 
enough to close the hole.

Acked-by: Antonio Quartulli <a@...2181...>



-- 
Antonio Quartulli

