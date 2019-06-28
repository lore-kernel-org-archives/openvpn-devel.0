MIME-Version: 1.0
References: <CAKuzo_j6F2+_JxosdVF3iB4kzWsR7Wq2FT8Vgi9Cg3yvT_A1JQ@...278...>
In-Reply-To: <CAKuzo_j6F2+_JxosdVF3iB4kzWsR7Wq2FT8Vgi9Cg3yvT_A1JQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 28 Jun 2019 16:56:03 -0400
Message-ID: <CAKuzo_h3eZ3sJTQ2Wm3MjnJBTvh9mXBzwi+k=BJaq+RsmqzqXg@...278...>
Subject: Re: [Openvpn-devel] Using AllowNonAdmin in the advanced options of
 tap adapter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Fri, Jun 28, 2019 at 4:51 PM Selva Nair <selva.nair@...277...> wrote:
>
> Hi,
>
> While testing a patch, I failed to toggle AllowNonAdmin access to the
> tap-adapter.
> Looking at the sources it seems we do not respect that setting.
>
> From adapter.c ~line

The quoted code was from tap-windows6/src/adapter.c ~line 428

