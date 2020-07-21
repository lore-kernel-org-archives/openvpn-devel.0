References: <20200717160231.12042-1-a@...2181...>
 <20200721163906.GE1431@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ae3a509f-dc9f-0949-05a9-7e1f9d87d287@...2181...>
Date: Tue, 21 Jul 2020 21:04:18 +0200
MIME-Version: 1.0
In-Reply-To: <20200721163906.GE1431@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] t_net.sh: drop hard dependency on
 t_client.rc
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
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 21/07/2020 18:39, Gert Doering wrote:
> In here, print & set
> 
>       if [ -z "$RUN_SUDO" ]
>       then
>  +        echo "$0: no RUN_SUDO=... in t_client.rc or environment, defaulting to 'sudo'." >&2
>  +        echo "      if that does not work, set RUN_SUDO= correctly for your system." >&2
>  +        RUN_SUDO=sudo"
>       fi
> 
> done - less code, message conveyed if needed.
>   


hmhmhmh makes sense. v2 incoming!

-- 
Antonio Quartulli

