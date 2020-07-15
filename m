References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-10-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b38dc5cb-f9a1-fb42-4bb6-e0061147e97e@...2181...>
Date: Wed, 15 Jul 2020 10:26:04 +0200
MIME-Version: 1.0
In-Reply-To: <20200711093655.23686-10-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v5 10/14] client-connect: Move adding
 inotify watch into its own function
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

On 11/07/2020 11:36, Arne Schwabe wrote:
> This make the code a bit better readable and also prepares resuing
> the function for client-connect return files
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>


This patch looks good and does what it says. No functional change is
implemented, but it's all about moving a chunk of code in its own
function and indenting it better than how it was.

Acked-by: Antonio Quartulli <antonio@...515...>

-- 
Antonio Quartulli

