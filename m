References: <20210317160038.25828-1-arne@...1227...>
 <20210317160038.25828-2-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <cadc0805-043d-5b85-a04e-2f615b78dc2a@...2181...>
Date: Wed, 17 Mar 2021 17:32:33 +0100
MIME-Version: 1.0
In-Reply-To: <20210317160038.25828-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] Move NCP saving and restore to
 the prepush restore code
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
> This unifies save/restoring options that might be changed by a push
> from the server. It also removes using the context_1 to store something
> that is not related to a SIGHUP lifetime.
> 
> Patch v2: rebase on master.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

As a follow pu of patch 1/3, this patch moves the init and reset of ncp
settings to a common function for easier reading.

Moving the attributes out of c1 as it does not make much sense.

This patch was reviewed with the Arne's guidance.

Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

