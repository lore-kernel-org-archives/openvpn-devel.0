References: <20210125125628.30364-11-arne@...1227...>
 <20210518122635.2235658-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <5585fe35-4770-60a0-8106-0782b28d6e4c@...2181...>
Date: Tue, 10 Aug 2021 11:38:46 +0200
MIME-Version: 1.0
In-Reply-To: <20210518122635.2235658-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Implement --client-crresponse script
 options and plugin interface
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 18/05/2021 14:26, Arne Schwabe wrote:
> This is allows scripts and pluginsto parse/react to a CR_RESPONSE message
> 
> Patch V2: doc fixes, do not put script under ENABLE_PLUGIN
> Patch V3: rebase
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

I have a high level question about this patch.

At the moment there is no trace of CR_RESPONSE or request in the
OpenVPN2 code.

To the best of my knowledge that's because this protocol is entirely
handled outside of OpenVPN using INFO_PRE and custom control messages.

With this patch we are aiming at moving a piece of this "external" logic
inside OpenVPN.

Question 1:

What is the benefit of moving the CR response handling inside OpenVPN,
if there is no code to generate the request? Maybe there are advantages
that are just assumed?

Question 2:

If we implement handling CR-RESPONSE, do we want to implement such
handling in the future with every custom control message that may be
sent by the management interface?

Question 3:

IMHO, this is a very good case where OpenVPN can be transparent and let
the upper layer deal with it (i.e. via mgmt interface), why changing that?



Best Regards,


-- 
Antonio Quartulli

