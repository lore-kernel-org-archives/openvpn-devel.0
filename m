References: <20210317160038.25828-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <37db2341-3bd5-191e-103e-48895f016c51@...2181...>
Date: Wed, 17 Mar 2021 17:30:58 +0100
MIME-Version: 1.0
In-Reply-To: <20210317160038.25828-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Move restoring pre pull options
 to initialising of c2 context
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

Hi all,

On 17/03/2021 17:00, Arne Schwabe wrote:
> We currently delay restoring these options until we actually must
> restore them. Since there is no reason to do so apart from the very
> minor saving to not have to execute that code when a connection fails,
> move them it into the general context_2 initialisation.
> 
> Patch V2: rebase on master.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

This patch is simply about moving when the pre-pull settings have to be
restored. Aims at simplifying the code and make it easier to follow
(thanks to the patches that will come later).

This patch was reviewed with the Arne's guidance.

Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

