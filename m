Message-ID: <60406b9a-ac53-d462-bc83-dff14bb98f97@...2181...>
Date: Tue, 15 Mar 2022 16:05:10 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220313200715.13518-1-openvpn@...2080...>
 <20220313200715.13518-2-openvpn@...2080...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220313200715.13518-2-openvpn@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2.4 v4 1/3] sample-plugin: New plugin
 for testing multiple auth plugins
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
> This plugin allows setting username/passwords as well as configure
> deferred authentication behaviour as part of the runtime initialization.
> 
> With this plug-in it is easier to test various scenarios where multiple
> authentication plug-ins are active on the server side.
> 
> A test documentation was also added to describe various test cases and
> the expected results.
> 
> Signed-off-by: David Sommerseth <davids@...515...>

Tested and it greatly helps understanding various auth plugin 
combinations behaviours.

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

